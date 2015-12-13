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

  @route 'newKidsQuestion',
    template: 'newKidsQuestion',
    path: '/newKidsQuestion'

