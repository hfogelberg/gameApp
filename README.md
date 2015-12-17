#GameApp

##1. Before deploying to production

The app uses Cloudinary for image storage

1. Set up an account at Cloudinary
2. Create a folder on Cloudinary where you want to store the images
3. Copy settings.json.copy to settings.json
4. Edit the settings.json file

To run locally start the app with 
meteor --settings settings.json

To deploy on Meteor
meteor deploy --settings settings.json

```
{
	"api_key": "YOUR_API_KEY
	"api_secret": "YOUR_API_SECRET",
	"public": {
		"cloud_name": "YOUR_CLOUD_NAME",
		"folder": "YOUR_FOLDER_NAME",
		"thumb_root": "https://res.cloudinary.com/YOUR_CLOUD_NAME/image/upload/w_90/",
		"image_root": "https://res.cloudinary.com/YOUR_CLOUD_NAME/image/upload/w_180/"
	}
}
```

##2. Picking random questions
Randomizing questions doesn't work with so few questions in the Db. There should be at least 50 or so per category.
The functions 	getAdultQuestions and getKidsQuestions in gameServer.coffee should be changed when enough questions have been added. See the outcommented code.

It could also be a good idea with a loop to check than enough questions are fetched? Unfortunately Meteor/Mongo doesn't have a good method to fetch random posts yet.


