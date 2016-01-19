#GameApp

## Cloudinary

The app is deployed to https://laitquestionnaire.herokuapp.com.

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
