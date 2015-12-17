Template.newQuestionTemplate.helpers
	level: ->
		Session.get('level').toLowerCase()

	isKid: ->
		level = Session.get 'level'
		if level is KID
			return true
		else
			return false