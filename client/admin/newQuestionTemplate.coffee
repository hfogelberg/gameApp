Template.newQuestionTemplate.helpers
	level: ->
		#ToDo: Return default value if not set
		Session.get('level').toLowerCase()

	isKid: ->
		level = Session.get 'level'
		if level is KID
			return true
		else
			return false