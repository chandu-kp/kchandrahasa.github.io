---
layout: post
title: "Github Hosted Blog with Octopress in Cloud9"
date: 2013-06-19 06:58
comments: true
author: Chandra
categories: octopress github cloud9 
---
I was looking for blogging framework, there were many choices like [Tumblr](http://tumblr.com/), [Wordpress](http://wordpress.com) etc. But when I came across Octopress, I really liked it. I can just write posts in markdown syntax and host it easily in Github.
>[Octopress](http://octopress.org/)  is a blogging framework for Jekyl, which isa static site generator powering Github Pages.
<!--more-->
Writing blog using Octopress and hosting it in Github Pages, requires the following:

- Ruby 1.9.3
- Git - a distributed version control system
- Account in [Github](https://github.com)

But having these environment in my local system was not an option, as I wanted to blog from anywhere. This is where Cloud9 helped me.
> [Cloud9](http://c9.io/) is an online IDE where Ruby, Git are pre-installed.

So, once you sign up for an account with Cloud 9, all you need is to create an workspace. In free edition, you can have one private workspace. 

Now, go to your workspace, and follow the steps as outlined below in the terminal window
```
git clone git://github.com/imathis/octopress.git myblog
```
> This creates a directory called myblog and copies all the related data from octopress.

Now goto the octopress directory and issue the following commands
``` 
cd myblog
bundle install
rake install
```
> This will install the default theme. Check _config.yml and update all details like blog name, blog address, twitter id, disqus id etc

Next step is to generate the blog and preview it.
```
rake generate
rake preview
```

Preview within Cloud9 may result in  Permission denied - bind(2) (Errno::EACCES). To resolve this issue, edit RakeFile and modify the following
```
....                                                                                                                                                                                 
....                                                                                                                                                                                 

#server_port     = "4000"      # port for preview server eg. localhost:4000                                                                                                          
server_host     = ENV['IP'] ||= '0.0.0.0'     # server bind address for preview server                                                                                               
server_port     = ENV['PORT'] ||= "4000"      # port for preview server eg. localhost:4000                                                                                           
....                                                                                                                                                                                 
....                                                                                                                                                                                 
#rackupPid = Process.spawn("rackup --port #{server_port}")                                                                                                                           
rackupPid = Process.spawn("rackup --host #{server_host} --port #{server_port}")                                                                                                      
```
> Refer [http://www.devopsy.com/blog/2012/10/04/octopress-on-cloud9/] for more details

Now you can preview your blog on `<blog_name>.<cloud 9 username>.c9.io`

###Deploying to Github pages
Login to github.com and create a repo as <username>.github.io.
Now on your cloud9 workspace, invoke
```
cd myblog
rake setup_github_pages
```

Enter repo url as:`git@github.com:<github username>/<github username>.github.io`
> Note: Make sure to add cloud9 ssh key into github. Cloud9 ssh key is avilable at your account settings, copy this ssh key and add it in Github account settings.

###Now generate the blog and deploy to github
```
rake generate
rake deploy
```
Now you are done with deploying your blog onto Github and you can go to your blog at `http://<github username>.github.io`.

###Commit the source
Now commit the source so that you don't loose any of the setup files and can checkout the code in someother system and start blogging.
```
git add .                                                                                                                                                                            
git commit -m 'your message'                                                                        
git push origin source                                                                                                                                                               
```

###Creating new post
```                                                                                                                                                                                  
rake new_post["My new blog"]                                                                                                                                                         
```
This will generate a file in the source\_posts folder which you can edit.

To generate your blog and deploy it, follow the same steps as outlined above.
