$.cloudinary.config
	cloud_name: Meteor.settings.public.cloud_name

images = new Array()


Template.newKidsQuestion.helpers
	files: ->
		Cloudinary.collection.find()

	complete: ->
		@status is "complete"

Template.newKidsQuestion.events
	"change input.file_bag": (e) ->
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


Template.newKidsQuestion.events
	'click .btnSaveQuestion': (template)->
		template.preventDefault

		showAnswerImgElem = $('input:radio[name=showAnswerImg]:checked')
		showAnswerElem = $('input:radio[name=showAnswerElem]:checked')
		correctAnswersElem = $('input:radio[name=correctAnswers]:checked')

		props = {
			title: $('#title').val()
			images: images
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

		Meteor
