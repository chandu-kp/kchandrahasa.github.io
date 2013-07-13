---
layout: post
title: "Crazydomains - crazy issues"
date: 2013-07-09 06:37
comments: true
author: Chandra
categories: crazydomains cloudfare github custom domain
---
I purchased domain name from crazydomains, mainly to host my blog, because the domain name was cheaper at crazydomains. But little did I know that I will not be able to update my DNS records, unless I pay more for it. Creating a CNAME record seem to be pretty basic service, but alas crazydomains will not give you. Now I know why they named themselves as crazydomains.

Now let us look at what needs to be done for custom domain setup.

1. Create a CNAME file under source folder : 
`
  echo 'your-domain.com' >> source/CNAME
`
1. Create a CNAME record for sub-domains (A record for domain) under DNS settings.
>Ref: [Deploying to Github Pages](http://octopress.org/docs/deploying/github/#custom_domains)

Now, since I could not create CNAME, I was looking for other options. Luckily there are some options available, like:

- [FreeDNS](http://freedns.afraid.org/)
- [ClouDNS](http://www.cloudns.net/)
- [Cloudflare](https://www.cloudflare.com/)

Of the above I have tried only Cloudflare. Cloudflare basically a website optimizer mainly routes the traffic via their network. So, its double benefit. 

- Create an account in Cloudflare 
- Once you login, you will have to add your domain name. 
- It will scan your DNS settings, adds all the missing records if any (like for www etc)
- Now add a new CNAME as follows:
`<your sub-domain name>` and its alias name, which is `<github user>.github.io` as shown below.

{% img center /images/cloudflare-dns_settings.jpg 650 350 'image' 'images' %}

- Once done, click on *I'm done entering my DNS Records*.
- Now Cloudflare will provide you two nameservers (it could be different for different accounts)

Now login to crazydomains, 

- Click on Domains and click *Update Name Servers* under DNS settings.
- Delete the existing crazy domains name servers and enter the two nameservers given by cloudflare as follows:.

{% img center /images/crazydomain-dns_settings.jpg 650 350 'image' 'images' %}

That's it. It may take an 10 - 20 minutes. Now you can go to your subdomain and see that its pulling content off your github page. 
