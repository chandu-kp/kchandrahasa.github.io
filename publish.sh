#!/bin/sh
# publish.sh - publish the page and commit the files
git add .
git commit -am "`date`" && git push origin source
rake generate && rake deploy
