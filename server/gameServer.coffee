Meteor.startup ->
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
		ids = _(Questions.find({level: ADULT}).fetch()).pluck '_id'
		randomIds = _(ids).sample NUM_ADULT_QUESTIONS
		console.log 'Random ids: ' + randomIds
		Questions.find({_id: {$in: randomIds}}).fetch()

	getKidsQuestions: ->
		ids = _(Questions.find({level: KID}).fetch()).pluck '_id'
		randomIds = _(ids).sample NUM_KIDS_QUESTIONS
		console.log 'Random ids: ' + randomIds
		Questions.find({_id: {$in: randomIds}}).fetch()

	createStats: (props) ->
		console.log 'Create stats'
		console.log props
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

	getGamesCountByLevel: (level)->
		console.log 'getGamesCountByLevel ' + level
		console.log Stats.find({level: level}).count()
		Stats.find({level: level}).count()

	getCorrectAnswersCount: (level)->
		console.log 'getCorrectAnswersCount ' + level
		total = 0
		Stats.find({level: level}).map (doc) ->
			total = total + doc.correctAnswers  
		console.log 'correctAnswers count for ' + level + ' ' + total
		return total

	getWrongAnswersCount: (level)->
		console.log 'getWrongAnswersCount ' + level
		total = 0
		Stats.find({level: level}).fetch().map (doc) ->
		  total = total + doc.wrongAnswers  
		console.log 'wrongAnswers count for '+ level + ': ' + total
		return total
