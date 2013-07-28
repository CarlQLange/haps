haps: the Hubot Assistive Package System
========================================

Installing Hubot scripts is hard! Now it's easy!

Let's say you want to use [fabulous-github-issues script for Hubot](https://github.com/CarlQLange).
Previously, this was a several step process that took place mostly in a terminal. Now, it's as easy as

	@hubot install fabulous-github-issues
	-> @csl_ Here's the README for fabulous-github-issues. Are you sure you want to install it (yes/no)?
	@hubot yes
	-> Downloading fabulous-github-issues...
	-> Installing dependencies for fabulous-github-issues...
	-> fabulous-github-issues requires configuration of these variables:
	-> HUBOT_GITHUB_USER, HUBOT_GITHUB_TOKEN, HUBOT_GITHUB_REPO
	-> @csl_ What's the value of HUBOT_GITHUB_USER?
	CarlQLange
	// ... etc ... //
	-> The package fabulous-github-issues has been installed and configured!
	-> Here are the new commands:
	-> hubot new issue: <title>. <description>
	// ... etc .. //


Installation
------------
This is the last time you'll have to install a hubot script manually, I hope.
Get `haps.coffee`, by cloning the repo or through other means, and put it in `HUBOT_REPO_ROOT/scripts`. Then, assuming you have a typical hubot setup, do a `git add ./scripts/haps.coffee`, `git commit -m "Installing haps."`, `git push heroku master`. But don't copy-paste those commands - make sure you know what you're doing.
Yeah, I know this is actually pretty easy - but pretend that you don't know how to use git, or something. This is installing scripts for ordinary people, not for wizards.


Commands
--------

```
@hubot list packages
@hubot info <packagename>
@hubot install <package name>
@hubot upgrade <package name>
@hubot configure <package name>
@hubot configure <ENV_VARIABLE NAME> <value>
@hubot uninstall <package name>
```

#### @hubot list packages
Lists all the packages hubot knows about!

#### @hubot info packagename

Displays the readme of the named package!

#### @hubot install packagename

Installs the named package!

#### @hubot upgrade packagename

Upgrades the named package to the latest version!

#### @hubot configure packagename

Helps you configure all the environment variables the named package requires.

#### @hubot configure ENVVARIABLE value

Sets ENVVARIABLE to value. Used for configuring a script. (This is a teensy bit dangerous - don't do anything silly)

#### @hubot uninstall packagename

Uninstalls the named package!
