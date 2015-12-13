Template.newQuestionTemplate.helpers
	isKid: ->
		level = Session.get 'level'
		if level is KID
			return true
		else
			return false