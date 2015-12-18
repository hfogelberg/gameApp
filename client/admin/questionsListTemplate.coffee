Template.questionsListTemplate.events
	'click .delete': (event)->
		event.preventDefault

		if (confirm('Are you sure you want to delete the question?'))
    	Meteor.call 'deleteQuestionWithId', this._id, (err) ->

Template.questionsListTemplate.helpers
	level: ->
		Session.get 'level'

	thumbRoot: ->
		Session.get 'thumbRoot'