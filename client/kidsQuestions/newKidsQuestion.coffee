$.cloudinary.config
	cloud_name: Meteor.settings.public.cloud_name

@answers = new Array()

questionId = Random.id()

Template.newKidsQuestion.helpers
	questionId: ->
		return questionId

	answers: ->
		return answers

	complete: ->
		@status is "complete"

Template.newKidsQuestion.rendered =->
	Session.set 'questionImageId', ''	

Template.newKidsQuestion.helpers
	thumbRoot:->
		Session.get 'thumbRoot'
		
	answersList: ->
		return answers

	questionImage: ->
		Session.get 'questionImageId'

	questionImageComplete: ->
		@status is "complete"

	complete: ->
		@status is "complete"

Template.newKidsQuestion.events
	'click #btnAddAnswer': (event) ->
		$('#kidsAnswerModal').modal()

	'change input.file_bag': (e) ->
		$('.btnSaveQuestion').attr('disabled', 'disabled')

		files = e.currentTarget.files
		Cloudinary.upload files,
			folder: Meteor.settings.public.folder
			(err,res) ->
				if err 
					console.log err
				else
					Session.set('questionImageId', res.public_id)
					$('.btnSaveQuestion').removeAttr('disabled')

'click .deleteImage': (template) ->
	Cloudinary.delete this.image, (err,res) ->
		console.log "Cloudinary Error: #{err}"

Template.newKidsQuestion.events
	'click .btnSaveQuestion': (template)->
		template.preventDefault

		showAnswerImgElem = $('input:radio[name=showAnswerImg]:checked')
		showAnswerElem = $('input:radio[name=showAnswer]:checked')
		correctAnswersElem = $('input:radio[name=correctAnswers]:checked')
		questionTypeElem = $('input:radio[name=questionType]:checked')

		props = {
			_id: questionId
			title: $('#title').val()
			image: Session.get('questionImageId')
			showAnswerImg: $(showAnswerImgElem).val()
			showAnswer: $(showAnswerElem).val()
			showAnswerTimer: $('#showTimer').val()
			correctAnswers: $(correctAnswersElem).val()
			oneAnswerText: $('#oneAnswerText').val()
			questionType: $(questionTypeElem).val()
			level: KID
			random: Random.fraction()
			createdDate: new Date()
			updatedDate: new Date()
		}

		Meteor.call 'createQuestion', props, (err) ->
			if err
				console.log err

	'click .deleteImage': (template)->
		template.preventDefault

		Session.set('questionImageId', '')
		Cloudinary.delete Session.get('questionImageId') ->
