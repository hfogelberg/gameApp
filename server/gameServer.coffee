Meteor.startup ->
	Meteor.publish	'getQuestionsTitleByLevel', (level) ->
		console.log 'getQuestionsTitleByLevel: ' +  level
		console.log 'Found: ' + Questions.find({level: level}).count()
		Questions.find
			level: level
			{
				_id: 1
				title: 1
			}

Meteor.methods
	createQuestion: (props) ->
		console.log 'createQuestion'
		console.log props

		Questions.insert props