# The DocPad Configuration File
# It is simply a CoffeeScript Object which is parsed by CSON
docpadConfig = {

	# =================================
	# Template Data
	# These are variables that will be accessible via our templates
	# To access one of these within our templates, refer to the FAQ: https://github.com/bevry/docpad/wiki/FAQ

	templateData:

		# Specify some site properties
		site:
			# The production url of our website
			url: "http://inkdesign.jp"

			# Here are some old site urls that you would like to redirect from
			oldUrls: [
				'www.inkdesign.jp'
			]

			# The default title of our website
			title: "inkdesign"

			# The website description (for SEO)
			description: """
				Hiroki Tani is Front-end engineer, Writer & Speaker
				"""

			# The website keywords (for SEO) separated by commas
			keywords: """
				 web, design, development, writing, speaking
				"""


		# -----------------------------
		# Helper Functions
		getPreparedType: ->
			if @document.url
				"blog"
			else
				"website"

		getPreparedUrl: ->
			# if we have a document url, then we should use that and suffix the site's url onto it
			if @document.url
				"#{@site.url + @document.url}"
			# if our document does not have it's own url, then we should just use the site's url
			else
				@site.url

		# Get the prepared site/document title
		# Often we would like to specify particular formatting to our page's title
		# we can apply that formatting here
		getPreparedTitle: ->
			# if we have a document title, then we should use that and suffix the site's title onto it
			if @document.title
				"#{@document.title} | #{@site.title}"
			# if our document does not have it's own title, then we should just use the site's title
			else
				@site.title

		# Get the prepared site/document description
		getPreparedDescription: ->
			# if we have a document description, then we should use that, otherwise use the site's description
			@document.description or @site.description

		# Get the prepared site/document keywords
		getPreparedKeywords: ->
			# Merge the document keywords with the site keywords
			@site.keywords.concat(@document.keywords or []).join(', ')

		getGruntedStyles: ->
			_ = require 'underscore'
			styles = []
			gruntConfig = require('./grunt-config.json')
			_.each gruntConfig, (value, key) ->
				styles = styles.concat _.flatten _.pluck value, 'dest'
			styles = _.filter styles, (value) ->
				return value.indexOf('.min.css') > -1
			_.map styles, (value) ->
				return value.replace 'out', ''

		getGruntedScripts: ->
			_ = require 'underscore'
			scripts = []
			gruntConfig = require('./grunt-config.json')
			_.each gruntConfig, (value, key) ->
				scripts = scripts.concat _.flatten _.pluck value, 'dest'
			scripts = _.filter scripts, (value) ->
				return value.indexOf('.min.js') > -1
			_.map scripts, (value) ->
				return value.replace 'out', ''

		# getIdForDocument: (document) ->
		# 	hostname = url.parse(@site.url).hostname
		# 	date = document.date.toISOString().split('T')[0]
		# 	path = document.url
		# 	"tag:#{hostname},#{date},#{path}"

		# fixLinks: (content) ->
		# 		baseUrl = @site.url
		# 		regex = /^(http|https|ftp|mailto):/

		# 		$ = cheerio.load(content)
		# 		$('img').each ->
		# 			$img = $(@)
		# 			src = $img.attr('src')
		# 			$img.attr('src', baseUrl + src) unless regex.test(src)
		# 		$('a').each ->
		# 			$a = $(@)
		# 			href = $a.attr('href')
		# 			$a.attr('href', baseUrl + href) unless regex.test(href)
		# 		$.html()

	# =================================
	# DocPad Events

	# Here we can define handlers for events that DocPad fires
	# You can find a full listing of events on the DocPad Wiki
	events:

		# Server Extend
		# Used to add our own custom routes to the server before the docpad routes are added
		serverExtend: (opts) ->
			# Extract the server from the options
			{server} = opts
			docpad = @docpad

			# As we are now running in an event,
			# ensure we are using the latest copy of the docpad configuraiton
			# and fetch our urls from it
			latestConfig = docpad.getConfig()
			oldUrls = latestConfig.templateData.site.oldUrls or []
			newUrl = latestConfig.templateData.site.url

			# Redirect any requests accessing one of our sites oldUrls to the new site url
			server.use (req,res,next) ->
				if req.headers.host in oldUrls
					res.redirect(newUrl+req.url, 301)
				else
					next()

		# Write After
		# Used to minify our assets with grunt
		writeAfter: (opts,next) ->
			# Prepare
			docpad = @docpad
			rootPath = docpad.config.rootPath
			balUtil = require 'bal-util'
			_ = require 'underscore'

			# Make sure to register a grunt `default` task
			command = ["#{rootPath}/node_modules/.bin/grunt", 'default']
			
			# Execute
			balUtil.spawn command, {cwd:rootPath,output:true}, ->
				src = []
				gruntConfig = require './grunt-config.json'
				_.each gruntConfig, (value, key) ->
					src = src.concat _.flatten _.pluck value, 'src'
				_.each src, (value) ->
					balUtil.spawn ['rm', value], {cwd:rootPath, output:false}, ->
				balUtil.spawn ['find', '.', '-type', 'd', '-empty', '-exec', 'rmdir', '{}', '\;'], {cwd:rootPath+'/out', output:false}, ->
				next()

			# Chain
			@
	# =================================
	# Plugins
	
	plugins:
	  moment:
	    formats: [
	      {raw: 'date', format: 'MMM D, YYYY', formatted: 'humanDate'}
	      {raw: 'date', format: 'YYYY-MM-DD', formatted: 'computerDate'}
	    ]
}

# Export our DocPad Configuration
module.exports = docpadConfig