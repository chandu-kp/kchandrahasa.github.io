---
layout: post
title: "Install Oracle Java jdk 7 on Ubuntu"
date: 2013-07-31 22:18
comments: true
author: Chandra
categories: java jdk oracle ubuntu jdk7
---
Installing Oracle JDK in Ubuntu (12.04+)

Ubuntu stopped hosting Oracle PPAs (Personal Package Archive) because of license issues, so now Oracle Java can't be installed from Ubuntu repositories. But, thanks to WebUpd8 team as they provide ubuntu PPAs from their repositories.

<!--more-->

* Install Oracle JDK 7 by executing the following commands

    `$ sudo add-apt-repository ppa:webupd8team/java`

    >In case you get error message **add-apt-repository: command not found**, then install **python-software-properties package** as follows and **re-execute** the above command.
    `$ sudo apt-get install python-software-properties`

    `$ sudo apt-get update`    
    `$ sudo apt-get install oracle-java7-installer`
    
    >Note that, they do have Oracle Java 8 (`oracle-java8-installer`) and Oracle Java 6 (`oracle-java6-installer`)

* Set the Oracle JDK as default (if already not set) by using the following command.
    `$ sudo update-java-alternatives -s java-7-oracle`

* Check the version<br/>
    `$ java -version`

    You should see the following
    >java version "1.7.0_25"    
    >Java(TM) SE Runtime Environment (build 1.7.0_25-b15) <br/>
    >Java HotSpot(TM) 64-Bit Server VM (build 23.25-b01, mixed mode)

* If you want to remove OpenJDK, then execute the following command on the terminal.
`$ sudo apt-get purge openjdk*`

> Reference: [Install Oracle Java in Ubuntu](http://www.webupd8.org/2012/01/install-oracle-java-jdk-7-in-ubuntu-via.html )