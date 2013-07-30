# Description:
# 	haps is a package manager for hubot!
#
# Dependencies:
#
# Configuration:
#
# Commands:
#	@hubot list packages
#	@hubot info <packagename>
#	@hubot install <package name>
#	@hubot upgrade <package name>
#	@hubot configure <package name>
#	@hubot configure <ENV_VARIABLE NAME> <value>
#	@hubot uninstall <package name>

http = require 'https'
github = require 'githubot'

Messages = {
	NO_SUCH_PACKAGE: (name) -> "I couldn't find a package called #{name}!"
	NOT_IMPLEMENTED: () -> "I can't do that yet!"
}

Haps = {}

Haps.packages = {}

Haps.get_packages = (cb) ->
	github.get 'repos/github/hubot-scripts/contents/src/scripts', (scripts) ->
		for script in scripts
			Haps.packages[script.name.replace /(\..*)/, ''] = script
		cb()

Haps.parse_script_doc = (script) ->
	doc = {
		description: ""
		dependencies: ""
		configuration: ""
		commands: ""
		notes: ""
		author: ""
		all: ""
	}

	#I am seriously reconsidering major choices in my life
	# do some bullshit here to parse tomdoc
	# for now just return the tomdoc string
	
	#whee
	content = new Buffer(script.content, 'base64').toString('utf8')
	for line in content.split '\n'
		break if line[0] != '#'
		doc.all += line[2..]+'\n'
	
	doc

Haps.list_packages = (msg) ->
	Haps.get_packages ->
		msg.send(pack for pack of Haps.packages)

Haps.info_package = (msg, packageName) ->
	if !Haps.packages[packageName]
		msg.send Messages.NO_SUCH_PACKAGE(packageName)
	else
		github.get "repos/github/hubot-scripts/contents/#{Haps.packages[packageName].path}", (script) ->
			#later just send the description
			msg.send(Haps.parse_script_doc(script).all)

Haps.install_package = (msg, packageName) ->
	msg.send Messages.NOT_IMPLEMENTED()

Haps.upgrade_package = (msg, packageName) ->
	msg.send Messages.NOT_IMPLEMENTED()

Haps.configure_package = (msg, packageName) ->
	msg.send Messages.NOT_IMPLEMENTED()

Haps.uninstall_package = (msg, packageName) ->
	msg.send Messages.NOT_IMPLEMENTED()


module.exports = (robot) ->
	github = github robot
	robot.respond /list packages/i, (msg) ->
		Haps.list_packages(msg)
	
	robot.respond /(info\s+|readme\s+)(.*)/i, (msg) ->
		packageName = msg.match[2]
		Haps.info_package(msg, packageName)

	robot.respond /install\s+(.*)/i, (msg) ->
		packageName = msg.match[1]
		Haps.install_package(msg, packageName)
	
	robot.respond /upgrade\s+(.*)/i, (msg) ->
		packageName = msg.match[1]
		Haps.upgrade_package(msg, packageName)

	robot.respond /configure\s+(.*)/i, (msg) ->
		match = msg.match[1]
		if match is match.toUpperCase()
			Haps.configure_env_var(msg, match.split(/\s+/))
		else
			Haps.configure_package(msg, match)
	
	robot.respond /uninstall\s+(.*)/i, (msg) ->
		packageName = msg.match[1]
		Haps.uninstall_package(msg, packageName)

