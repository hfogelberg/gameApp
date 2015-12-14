Router.configure
  layoutTemplate: 'layout'
  notFoundTemplate: 'not-found'

Router.map ->
  @route 'home',
    template: 'homeTemplate',
    path: '/'

  @route 'admin',
    template: 'adminTemplate',
    path: '/admin'
    waitOn: ->
      @subscribe 'getQuestionsTitleByLevel', Session.get('level')
    data: questions: ->
      Questions.find()

  @route 'newQuestion',
    template: 'newQuestionTemplate',
    path: '/newQuestion/:level'
      
  @route 'newKidsAnswer',
    template: 'newKidsAnswerTemplate',
    path: '/newKidsAnswer/:questionId'
    onBeforeAction: ->
      console.log @params.questionId
      Session.set('questionId', @params.questionId)
      this.next()
    waitOn: ->
      @subscribe 'getQuestionById', Session.get('questionId')
    data: question: ->
      Questions.findOne({_id: Session.get('questionId')})

  @route 'question',
    template: 'questionTemplate',
    path: '/question/:questionId'
    onBeforeAction: ->
      console.log @params.questionId
      Session.set('questionId', @params.questionId)
      this.next()
    waitOn: ->
      @subscribe 'getQuestionById', Session.get('questionId')
    data: question: ->
      Questions.findOne({_id: Session.get('questionId')})

  @route 'changeQuestion',
    template: 'changeQuestionTemplate',
    path: '/changeQuestion/:questionId' 
    onBeforeAction: ->
      console.log @params.questionId
      Session.set('questionId', @params.questionId)
      this.next()
    waitOn: ->
      @subscribe 'getQuestionById', Session.get('questionId')
    data: question: ->
      Questions.findOne({_id: Session.get('questionId')})


  @route 'changeAnswer',
    template: 'changeAnswerTemplate',
    path: '/changeAnswer/:questionId/:answerId'
    onBeforeAction: ->
      Session.set('questionId', @params.questionId)
      Session.set('answerId', @params.answerId)
      this.next()
    waitOn: ->
      @subscribe 'getAnswerById', Session.get('answerId')
    data: question: ->
      Questions.findOne({"answers.answerId": Session.get('answerId')})

