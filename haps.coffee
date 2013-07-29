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

Haps = {}

Haps.list_packages = (msg) ->
	github.get 'repos/github/hubot-scripts/contents/src/scripts', (scripts) ->
		names = (script.name.replace(/(\..*)/, '') for script in scripts)
		msg.send names



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
