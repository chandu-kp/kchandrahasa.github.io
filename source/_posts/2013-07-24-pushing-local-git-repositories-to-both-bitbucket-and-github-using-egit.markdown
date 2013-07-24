---
layout: post
title: "Pushing Local git Repositories to both Bitbucket and Github using EGit"
date: 2013-07-24 00:46
comments: true
author: Chandra
categories: git egit github bitbucket push
---
This assumes that you have Eclipse with Egit already installed. If you are using the latest release of Eclipse (i.e, 4.3 - Kepler), then Egit is already installed in it. Otherwise install EGit as detailed in [EGit Download](http://www.eclipse.org/egit/download/)

> Egit is Eclipse plugin working on top of JGit which is Java implementation of git. So, you don't need to install git separately.

<!--more-->

###Create local repository

- Create `HOME` environment varibale and set to a directory where you want to keep all git repos. Ideally keep this directory outside of Eclipse workspace for performance reason. Click [here](http://wiki.eclipse.org/EGit/User_Guide#Considerations_for_Git_Repositories_to_be_used_in_Eclipse) for details.

- Now within Eclipse create a Java Project (or any project)
- Right click on the project, click `Team -> Share Project`
- Select `Git` as repository type and click `Next`
- In next screen, `Configure Git Repository`, click on `Create` against repository and enter name for your repository. You will notice that the `Parent Directory` is set to `HOME` directory. 
> In case you haven't set the `HOME` environment variable, then `Parent Directory` will be set to default `user` home which can be modified in Eclipse preferences (`Windows->Preferences->Team->Git`).
- Now that you have created the repository, you can add the project to git as follows:
    - Right click on the project, click `Team -> Add To Index`
- Now commit to git as follows:
    - Right click on the project, click `Team -> Commit`
    
Now your project is added to local git repository.

###Pushing to Bitbucket
In order to push to Bitbucket, you can use SSH or HTTPS. Using HTTPS, you will need to enter username/password to push the changes. Here, I will explain how to use SSH.

##### Generate public and private keys in Eclipse

  Public and private key pair together identifies the local system. In order generate these, goto, `Windows->Preferences->General->Network Connections->SSH2->Key Management` and click on `Generate DSA Key` and then click on `Save Private Key`. Copy the public key to notepad.
{% img center /images/eclipse-git-generate-ssh-key.jpg 650 350 'image' 'images' %}

##### Add public key in Bitbucket
Now login to [Bitbucket](https://bitbucket.org), add the above public key under `Account-> SSH Keys`

##### Create a repository in Bitbucket
Create repository in Bitbucket and note down the repository url which will be like : `git@bitbucket.org:<bb user name>/<repository name>.git`

{% img centre /images/bitbucket-new-repo.jpg 650 350 'image' 'images' %}

##### Add remote in Eclipse
- In Eclipse open `Git Repositories` view as follows:
`Window > Show View > Other > Git > Git Repositories`
- Right click on `Remotes` and click `Create Remote`. Enter remote name and click `OK` (Select `Configure push`)
-  In `Configure Push` screen, click `Change` and configure git repository as follows:
    - URI: `git@bitbucket.org:<bb user name>/<repository name>.git`
    - Host: `bitbucket.org`
    - Repository Path: `<bb user name>/<repository name>.git`
    - Protocol: Select `ssh` and click `Finish`
    {% img centre /images/eclipse-git-add-remote.jpg 650 350 'image' 'images' %}
    - Click `Advanced` to specify `Push Ref Specifications`
    > You will get an warning message **Known Hosts doesn't exist, do u want to create it**. Click `Yes`.
    - In `Push Ref Specification` dialog box, click `Add All Brannches to Spec` and click `Finish`
    - Click `Save and Push`

Now your local repository is pushed to Bitbucket.

###Pushing to Github

##### Add public key in Github
Login to [Github](https://github.com/) and add the above public key under `Account Settings-> SSH Keys`

##### Create a repository in Github
Create repository in Github and note down the repository url which will be like : `git@github.com:<github user name>/<repository name>.git`

{% img centre /images/github-new-repo.jpg 650 350 'image' 'images' %}
{% img centre /images/github-new-repo-url.jpg 650 350 'image' 'images' %}

##### Add remote in Eclipse
Follow the same step as outlined above, by giving a distinct remote name and github repository url.

Now you are ready with local git repository and remote git repositories at Github and Bitbucket. Similarly you should be able to add other remotes if required.

### Adding/Modifying files and pushing it
- Go to *Java perspective* and create a new package and a new Java class
- Add the newly added files to local git as follows:
    - Right click on the `project`, select `Team->Add to Index`
    - Right click on the `project`, select `Team->Commit`.
- Now come to `Git Repositories` view
    - Expand `Remotes` and right click on remote name (created earlier) and click on `push`. Follow the same with other remotes.

Some helpful references:

- [EGit/User Guide](http://wiki.eclipse.org/EGit/User_Guide)
- [Some instructions to use Git with Eclipse](http://www.slideshare.net/jlsantoso/some-instructions-to-use-git-with-eclipse)
