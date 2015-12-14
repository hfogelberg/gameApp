$.cloudinary.config
	cloud_name: Meteor.settings.public.cloud_name

images = new Array()
@answers = new Array()

Template.changeAnswerTemplate.helpers
	id: ->
		Session.get 'answerId'

	files: ->
		Cloudinary.collection.find()

	answerImage: ->
		Session.get 'answerImageId'

	complete: ->
		@status is "complete"

Template.changeAnswerTemplate.events
	'change input.answers_file_bag': (e) ->
		console.log 'Files added'
		files = e.currentTarget.files
		console.log files
		$('.btnChangeAnswer').attr('disabled', 'disabled')

		Cloudinary.upload files,
			folder: Meteor.settings.public.folder
			(err,res) ->
				if err 
					console.log err
				else
					console.log 'OK!'
					console.log res.public_id
					Session.set('answerImageId', res.public_id)
					images.push res.public_id
					$('.btnChangeAnswer').removeAttr('disabled')


	'click .btnDeleteImage': (event) ->
		event.preventDefault

		Cloudinary.delete this.image, (err,res) ->
			console.log "Cloudinary Error: #{err}"
			console.log "Cloudinary Result: #{res}"

		Meteor.call 'deleteImageFromAnswer', Session.get('questionId'), Session.get('answerId'), (err) ->
			if err
				console.log err
			else
				console.log 'OK'

	'click .btnChangeAnswer': (event) ->
		event.preventDefault
		
		isCorrectAnswer = false
		if $('#isCorrectAnswer').checked then isCorrectAnswer = true

		params = {
			answers:{
				answerId: Session.get('answerId')
				answerTitle: $('#answerTitle').val()
				isCorrectAnswer: isCorrectAnswer
				image: Session.get('answerImageId')
			}
		}

		console.log params

		Meteor.call 'changeAnswerToQuestion', Session.get('questionId'), Session.get('answerId'), params, (err) ->
			if err
				console.log err
			else
				console.log 'OK!'

	