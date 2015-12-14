Meteor.startup ->
	Meteor.publish 'getAnswerById', (answerId) ->
		console.log 'getAnswerById ' + answerId
		Questions.find({"answers.answerId": answerId})

	Meteor.publish 'getQuestionById', (questionId) ->
		console.log 'getQuestionById ' + questionId
		Questions.find
			_id: questionId
			{
				limit: 1
			}

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
	changeAnswerToQuestion: (questionId, answerId, params) ->
		console.log 'changeAnswerToQuestion ' + answerId
		console.log params

		Questions.update
			_id: questionId
			{
				$pull:
					answers:
						answerId: answerId
			}

		Questions.update
			_id: questionId
			{
				$push:
					params
			}

	removeAnswer: (questionId, answerId) ->
		console.log 'removeAnswer questionId: ' + questionId + ' answerId: ' + answerId
		Questions.update
			_id: questionId
			{
				$pull:
					answers:
						answerId: answerId
			}

	changeQuestion: (questionId, props) ->
		console.log 'changeQuestion ' + questionId
		console.log props

		Questions.update
			_id: questionId
			{
				$set:
					props
			}

	createQuestion: (props) ->
		console.log 'createQuestion'
		console.log props

		Questions.insert props

	addAnswerToQuestion: (questionId, params) ->
		console.log 'addAnswerToQuestion with id ' + questionId
		console.log params

		Questions.update
			_id: questionId
			{
				$push:
					params
			}
