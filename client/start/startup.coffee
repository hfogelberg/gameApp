Meteor.startup ->
	Session.set 'level', KID
	Session.set 'thumbRoot', Meteor.settings.public.thumb_root
	Session.set 'imageRoot', Meteor.settings.public.image_root