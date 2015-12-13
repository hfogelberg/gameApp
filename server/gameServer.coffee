Meteor.methods
	createQuestion: (props) ->
		console.log 'createQuestion'
		console.log props

		Questions.insert props