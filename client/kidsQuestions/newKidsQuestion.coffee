$.cloudinary.config
	cloud_name: Meteor.settings.public.cloud_name

images = new Array()
@answers = new Array()

questionId = Random.id()

Template.newKidsQuestion.helpers
	questionId: ->
		return questionId

	answers: ->
		return answers
		
	files: ->
		Cloudinary.collection.find()

	complete: ->
		@status is "complete"

Template.newKidsQuestion.rendered =->
	Session.set 'questionImageId', ''	

Template.newKidsQuestion.helpers
	answersList: ->
		return answers

	files: ->
		Cloudinary.collection.find()

	questionImage: ->
		Session.get 'questionImageId'

	questionImageComplete: ->
		@status is "complete"

Template.newKidsQuestion.events
	'click #btnAddAnswer': (event) ->
		$('#kidsAnswerModal').modal()

	'change input.file_bag': (e) ->
		console.log 'Files added'
		files = e.currentTarget.files
		console.log files
		$('.btnSaveQuestion').attr('disabled', 'disabled')

		Cloudinary.upload files,
			folder: Meteor.settings.public.folder
			(err,res) ->
				if err 
					console.log err
				else
					console.log 'OK!'
					console.log res.public_id
					Session.set('latesImageId', res.public_id)
					images.push res.public_id
					$('.btnSaveQuestion').removeAttr('disabled')

Template.newKidsQuestion.events
	'click .btnSaveQuestion': (template)->
		template.preventDefault

		showAnswerImgElem = $('input:radio[name=showAnswerImg]:checked')
		showAnswerElem = $('input:radio[name=showAnswer]:checked')
		correctAnswersElem = $('input:radio[name=correctAnswers]:checked')

		props = {
			_id: questionId
			title: $('#title').val()
			image: Session.get('questionImageId')
			showAnswerImg: $(showAnswerImgElem).val()
			showAnswer: $(showAnswerElem).val()
			showAnswerTimer: $('#showTimer').val()
			correctAnswers: $(correctAnswersElem).val()
			level: KID
			random: Random.fraction()
			createdDate: new Date()
			updatedDate: new Date()
		}

		console.log props

		Meteor.call 'createQuestion', props, (err) ->
			if err
				console.log err
			else
				console.log 'OK!'

