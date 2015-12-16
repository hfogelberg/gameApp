Template.questionsListTemplate.events
	'click .delete': (event)->
		event.preventDefault

		Meteor.call 'deleteQuestionWithId', this._id, (err) ->

Template.questionsListTemplate.helpers
	level: ->
		Session.get('level')