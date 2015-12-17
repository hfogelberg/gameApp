Meteor.startup ->
	Meteor.publish 'getStats', ->
		Stats.find()

	# Meteor.publish 'getQuestionsForGame', (level, numQuestions) ->
	# 	r = Random.fraction()

	# 	# ToDo: Outcommented during dev
	# 	# Questions.find({level: level, random:{$gte:r}}, {limit: numQuestions})
	# 	Questions.find({level: level}, {limit: numQuestions})

	Meteor.publish 'getAnswerById', (answerId) ->
		Questions.find({"answers.answerId": answerId})

	Meteor.publish 'getQuestionById', (questionId) ->
		Questions.find
			_id: questionId
			{
				limit: 1
			}

	Meteor.publish	'getQuestionsTitleByLevel', (level) ->
		Questions.find
			level: level
			{
				_id: 1
				title: 1
			}

Meteor.methods
	deleteQuestionWithId: (questionId) ->
		Questions.remove
			_id: questionId

	getAdultQuestions: ->
		# r = Random.fraction()
		# console.log 'Returning ' +  Questions.find({level: 'ADULT'}, {limit: 4}).count()
		Questions.find({level: 'ADULT'}, {limit: 10}).fetch()

	getKidsQuestions: ->
		r = Random.fraction()
		# console.log 'Returning ' +  Questions.find({level: 'KID'}, {limit: 4}).count()
		Questions.find({level: 'KID'}, {limit: 8}).fetch()

	createStats: (props) ->
		Stats.insert props

	getOneQuestionById: (questionId) ->
		Questions.findOne
			_id: questionId

	changeAnswerToQuestion: (questionId, answerId, params) ->
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
		Questions.update
			_id: questionId
			{
				$pull:
					answers:
						answerId: answerId
			}

	changeQuestion: (questionId, props) ->
		Questions.update
			_id: questionId
			{
				$set:
					props
			}

	createQuestion: (props) ->
		Questions.insert props

	addAnswerToQuestion: (questionId, params) ->
		Questions.update
			_id: questionId
			{
				$push:
					params
			}

	deleteImageFromQuestion: (questionId) ->
		Questions.update
			_id: questionId
			{
				$set:
					image: ''
			}