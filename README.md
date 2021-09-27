# EVREKA CONTAINERS



This is a flutter case for Evreka!

# Design Notes

 1. There are 2 users to access app. It comes from database.

	ymg@evreka.com : 123456
	and
	ymg@sifiratik.co : 123456

 2. System checks internet connection, if you have connection you
    will redirect to login page.

 3. After login, system gets containers locations from firebase.  I
    chose 1000 random places in limited location coordinates (near
    Ankara).

 4. If you tap any container on map, you will see container
    informations. You can navigate it or you can relocate the container.
    If you tap the navigate button, it will open the Google Maps and will navigate you. 

 5. To relocate, you need to tap longly on map in relocation mode. After
    you tap the save button, you will update the database

## Missing Parts

 - Since I started to learn flutter from scratch 2 days ago, I could not
   able to make login page functionally as you specified.
 - And after all my researches, I could not find the way to change
   marker icon if tapped. Think that, Google api does not allow this.

## Dependencies
 - Cloud firestore
 - firebase auth
 - google maps flutter
 - maps launcher
 - connectivity

## Notes

You need to sdk version of 21.  In `android/app/build.gradle`:

	

    android {
    	    defaultConfig {
    	        minSdkVersion 20
    	    }
    	}
## How to Build
```
1- Flutter v.2.X must be installed and enviroment must be ready. See more : https://flutter.dev/docs/get-started/install
2- flutter pub get
3- flutter run
```
## Screenshots
![ScreenShots](https://github.com/mrymg/Environmental-Containers/blob/master/evr-ss.png)

