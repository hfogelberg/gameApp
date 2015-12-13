Template.newQuestionTemplate.helpers
	isKid: ->
		if Session.get 'level' is KID
			return true
		else
			return false