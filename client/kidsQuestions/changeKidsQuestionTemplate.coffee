$.cloudinary.config
	cloud_name: Meteor.settings.public.cloud_name

images = new Array()
@answers = new Array()

Template.changeQuestionTemplate.helpers
	files: ->
		Cloudinary.collection.find()

	questionImage: ->
		Session.get 'questionImageId'

	complete: ->
		@status is "complete"

Template.changeQuestionTemplate.events
	'change input.file_bag': (e) ->
		console.log 'Files added'
		files = e.currentTarget.files
		console.log files
		$('.btnUpdateQuestion').attr('disabled', 'disabled')

		Cloudinary.upload files,
			folder: Meteor.settings.public.folder
			(err,res) ->
				if err 
					console.log err
				else
					console.log 'OK!'
					console.log res.public_id
					Session.set('questionImageId', res.public_id)
					images.push res.public_id
					$('.btnUpdateQuestion').removeAttr('disabled')

	'click .btnDeleteImage': (template) ->
		Cloudinary.delete this.image, (err,res) ->
			console.log "Cloudinary Error: #{err}"
			console.log "Cloudinary Result: #{res}"

	'click .btnUpdateQuestion': (template) ->
		template.preventDefault

		showAnswerImgElem = $('input:radio[name=showAnswerImg]:checked')
		showAnswerElem = $('input:radio[name=showAnswerElem]:checked')
		correctAnswersElem = $('input:radio[name=correctAnswers]:checked')
		questionTypeElem = $('input:radio[name=questionType]:checked')

		props = {
			title: $('#title').val()
			image: Session.get('questionImageId')
			showAnswerImg: $(showAnswerImgElem).val()
			showAnswer: $(showAnswerElem).val()
			questionType: $(questionTypeElem).val()
			showAnswerTimer: $('#showTimer').val()
			correctAnswers: $(correctAnswersElem).val()
			oneAnswerText: $('#oneAnswerText').val()
			level: KID
			updatedDate: new Date()
		}

		Meteor.call 'changeQuestion', this._id, props, (err) ->
			if err
				console.log err
			else
				console.log 'OK!'