---
layout: post
title: "Android 4.2 and javax.crypto.BadPaddingException: pad block corrupted"
date: 2013-08-09 20:01
comments: true
author: Chandra
categories: android 4.2 padding exception security openssl 
---
We have an Android app where user login using username/password to access the service. To make the app autologin, we have had the authentication details stored in preferences. And yes, we did store the password as encrypted and used `SharedPreference` with `MODE_PRIVATE` so that no other app can access the data and user with root access can't easily get the password.
<!--more-->

Things have been working fine until its broken in Android 4.2. On debugging, found that its basically having issue because the key supplied during decryption is different than the one supplied during encryption. How that's changed? Simple, Android updated their default implementation of SecureRandom from Crypto to OpenSSL(<a href="http://android-developers.blogspot.com.au/2013/02/security-enhancements-in-jelly-bean.html" target="_blank">Security Enhancements in Jelly Bean</a>).

Its basically the following code having this issue:

```java
        KeyGenerator kgen = KeyGenerator.getInstance("AES");
        SecureRandom sr = SecureRandom.getInstance("SHA1PRNG");
        sr.setSeed(seed);
		kgen.init(128, sr); 
		SecretKey skey = kgen.generateKey();
		byte[] raw = skey.getEncoded();
```
The code above basically gets SecureRandom of `SHA1PRNG` algorithm. Now with the update to `OpenSSL`, this result it getting truly random values, which means generated keys are random each time its invoked. How can Android do this? It turns out that its not actually Android issue, but the code issue. We shouldn't have used `SecureRandom` to get key in the first place, which is plain wrong. 

How to resolve issue? If its need to done without major change, then the easy fix (***but not recommended***) would be as follows. Please note that this can be used as a temporary solution, though it resolves the issue, its still doing the wrong way.  
		-SecureRandom sr = SecureRandom.getInstance("SHA1PRNG");
		+SecureRandom sr = SecureRandom.getInstance("SHA1PRNG", "Crypto");

The recommended way (check <a href="http://nelenkov.blogspot.com.au/2012/04/using-password-based-encryption-on.html" target="_blank">Nelenkov's tutorial</a>) is to use proper key derivations PKCS (Public Key Cryptography Standard), which defines two key derivation functions, PBKDF1 and PBKDF2, of which PBKDF2 is more recommended.

So, using this how do we get the key? Here is the code snippet
```java	
        int iterationCount = 1000;
		int saltLength = 8; // bytes; 64 bits
		int keyLength = 256;
        SecureRandom random = new SecureRandom();
		byte[] salt = new byte[saltLength];
		    random.nextBytes(salt);
		KeySpec keySpec = new PBEKeySpec(seed.toCharArray(), salt,
			iterationCount, keyLength);
		SecretKeyFactory keyFactory = SecretKeyFactory
			.getInstance("PBKDF2WithHmacSHA1");
		byte[] raw = keyFactory.generateSecret(keySpec).getEncoded();
```

###Final thoughts
Using the symmetric key function as above could be used for storing the encrypted data in the device, but its always better to go for `token`(`oauth`) based authentication which is more secure and can be controlled outside of the device without changing the password.

#####References
<a href="http://android-developers.blogspot.com.au/2013/02/using-cryptography-to-store-credentials.html" target="_blank">Using Cryptography to Store Credentials Safely</a><br/>
<a href="http://nelenkov.blogspot.com.au/2012/04/using-password-based-encryption-on.html" target="_blank">Nelenkov's tutorial</a><br/>
<a href="http://stackoverflow.com/questions/13433529/android-4-2-broke-my-encrypt-decrypt-code-and-the-provided-solutions-dont-work/" target="_blank">Android 4.2 broke my encrypt/decrypt code</a>