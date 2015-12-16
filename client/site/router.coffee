Router.configure
  layoutTemplate: 'layout'
  notFoundTemplate: 'not-found'

Router.map ->
  @route 'home',
    template: 'homeTemplate',
    path: '/'

  @route 'start',
    template: 'startTemplate',
    path: '/start'

  @route 'admin',
    template: 'adminTemplate',
    path: '/admin'
    waitOn: ->
      @subscribe 'getQuestionsTitleByLevel', Session.get 'level'
    data: questions: ->
      Questions.find()

  @route 'stats',
    template: 'statsTemplate',
    route: '/admin/stats'
    waitOn: ->
      @subscribe 'getStats'
    data: stats:->
      Stats.find()

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

  @route 'newAdultAnswer',
    template: 'newAdultAnswerTemplate',
    path: '/newAdultAnswer/:questionId'
    onBeforeAction: ->
      console.log @params.questionId
      Session.set('questionId', @params.questionId)
      this.next()
    waitOn: ->
      @subscribe 'getQuestionById', Session.get('questionId')
    data: question: ->
      Questions.findOne({_id: Session.get('questionId')})

  @route 'showAdultQuestion',
    template: 'showAdultQuestionTemplate',
    path: '/showAdultQuestion/:questionId'
    onBeforeAction: ->
      console.log @params.questionId
      Session.set('questionId', @params.questionId)
      this.next()
    waitOn: ->
      @subscribe 'getQuestionById', Session.get('questionId')
    data: question: ->
      Questions.findOne({_id: Session.get('questionId')})

  @route 'changeAdultQuestion',
    template: 'changeAdultQuestionTemplate',
    path: '/changeAdultQuestion/:questionId'
    onBeforeAction: ->
      console.log @params.questionId
      Session.set('questionId', @params.questionId)
      this.next()
    waitOn: ->
      @subscribe 'getQuestionById', Session.get('questionId')
    data: question: ->
      Questions.findOne({_id: Session.get('questionId')})

  @route 'changeAdultAnswer',
    template: 'changeAdultAnswerTemplate',
    path: '/changeAdultAnswer/:questionId/:answerId'
    onBeforeAction: ->
      Session.set('questionId', @params.questionId)
      Session.set('answerId', @params.answerId)
      this.next()
    waitOn: ->
      @subscribe 'getAnswerById', Session.get('answerId')
    data: question: ->
      Questions.findOne({"answers.answerId": Session.get('answerId')})

  @route 'adultGame',
    template: 'adultsGameTemplate',
    route: '/adultGame'
    # waitOn: ->
    #   @subscribe 'getQuestionsForGame', ADULT, NUM_ADULT_QUESTIONS
    # data: questions: ->
    #   Questions.find()

  @route 'kidsGame',
    template: 'kidsGameTemplate',
    route: '/kidsGame'
    # waitOn: ->
    #   @subscribe 'getQuestionsForGame', KID, NUM_KIDS_QUESTIONS
    # data: questions: ->
    #   Questions.find()
