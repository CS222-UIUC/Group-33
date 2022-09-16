## MoodSpot


In Spotify, it is difficult to find songs within your playlist that match a specific mood. Sometimes, you don’t even know what you want to listen to. With MoodSpot, you can take a quick selfie and we can assemble a playlist that matches your mood.

### Functionality
Users can log into spotify
Users can take a selfie
User can confirm the emotion detected
User can view different spotify songs from the generated playlist
User can edit the generated playlist
User can play songs from generated playlist in our app
User can save playlist to spotify account

The app will evaluate the user’s mood based on a selfie, and then generate a playlist that matches that mood automatically. The app will pull songs from the user’s top 10 listened artists and combine songs that match the mood of the user into a playlist. Features 1-3, 5, 7 are essential to our MVP, and if time permits, we will also implement features 4 and 6. 

### Components

Frontend
The frontend is responsible for creating all the UI elements and generating the Spotify playlist from the calculated emotion of the picture and the user’s favorite artists/genres. 
The Spotify generated playlist is a multi-step process. First, we pull down the user’s top 20 artists that they listen to. Then, we get the top 10 songs from each artist and pull that down. Each Spotify track has information on the valence, danceability, and energy. These parameters are used to assign an emotion to the songs. The matching songs are then used to create a new playlist in Spotify.
We will write the frontend in Dart using Android Studio. We chose Dart due to its wide range of applications to both android and iOS apps. Dart is used to enable the Flutter framework, which will allow us to develop the app to be available on iOS and Android with one codebase. Flutter is also easier to learn.
We’ll use the flutter_test package to write test cases and the flutter_lint package would allow all of our code to follow the same style guide.
The frontend will have unit and integration tests as well as UI tests. 
The unit and integration tests will make sure core functionality works and prevent regressions in the future. The CI pipeline will prevent any code below the threshold of 100% coverage from being pushed into the repository. 
The UI test will make sure that the components are being correctly displayed to the screen. Again, this will also help us prevent regressions in our codebase.

Backend
The backend server is responsible for computing an emotion from the selfie image. 
We will write the backend in Python. We chose Python because it has useful libraries to determine an emotion from a picture. Specifically, the DeepFace Library is a lightweight face recognition and facial attribute Python library. It uses a strong facial attribute analysis module to detect emotions among other attributes from a facial expression. We chose this library because it has various tutorials and documentation. 
We plan to write unit and integration tests for the Python server. These tests will make sure core functionality works and prevent regressions in the future. The CI pipeline will prevent any code below the threshold of 100% coverage from being pushed into the repository. 

We decided to split up the project into 2 main components: fronted and backend. Since we need to use a python library for determining the emotion from an image, it would be easier to use a Python server for this portion of the project. We decided to include the spotify playlist generator as part of the frontend to avoid latency issues. Briefly, it would take more time for the requests to hit our external server than if we did the computation locally in the app . We plan on connecting the frontend with the backend through a REST api endpoints, including a GET endpoint to retrieve the emotion of an image. 

###Continuous Integration
Github PRs
Will be working on individual branches for each feature
When merging with the main branch, we will use the flutter_lint to ensure all of the code matches the style guide
To avoid merge conflicts, we will try to avoid working on the same files at once, by assigning different pieces of the program to different people. However, we recognize that this may not be possible sometimes, so we will communicate to each other to ensure that we are not working on the same methods at once. 
Every time a PR is created (at the end of the week), we will add the rest of the team as reviewers and will only merge into the main branch once other team members are finished reviewing 
We will require that each PR is reviewed by at least one other team member (ideally before out Friday recap meeting), and that each team member reviews at least one PR each week and provides any necessary feedback. 
CI: Github Actions
Style Guide
Flutter_lints package
To run unit and integration tests: flutter_test package
Code coverage: code_coverage
https://pub.dev/packages/code_coverage 

###Risks
Spotify_sdk could be difficult to use to modify the user’s spotify profile. To avoid this potential issue setting us back in the schedule, we are planning on giving ourselves some extra time and also making a list of various resources ahead of time. Also, if we cannot display the playlist and songs in the app view, we can redirect to the spotify app as well.
We may encounter issues with setting up the CI pipeline for Flutter. There aren’t many resources available on this topic, so it may take extra time. We can switch to a React web-based service after the first week if the pipeline is too difficult.
Our backend server may impose limits on the number of requests we send to it, or we may not be able to find a backend that has free hosting. In both cases we have a raspberry pi in which we can have more control over for acting as the server back end.

###Teamwork
We are planning on assigning tasks from the schedule to each team member at the end of the previous week, on Fridays. The Github PR at the end of the week would help keep track of the progress we’ll make. We are planning on communicating through Discord and will create separate channels for different features to organize resources. In order to avoid friction, we will work on different portions of the week’s tasks to different people, and will be available to help one another if we’re stuck at any point. At the end of the week, we all will push to our respective Github branches, and then do a combined PR, which will be reviewed by all of us. 

We will split up the work in an even manner throughout the project, on a week-by-week basis. The rough guidelines that we will follow will be based on our interests. Himnish is interested in ML and UI, so we are tasking him with the algorithmic portions of the UI. Matthew is interested in the Python scripts, so he can work together with Himnish on the Python server. Divya is more inclined to work on UI/UX and is the only one experienced with Spotify, so she will be focusing on the playback UI portions. Khalid has done Flutter apps before, so he’ll be focused on UI/UX portions as well as advising others if they need help.

	
###Schedule


High Level Tasks
Week 1
Setup Continuous Integration for Flutter
Setup Continuous Integration for Python
Design Barebones Pages - 2 ppl
Week 2
Implement Login Page UI
Implement Home Page UI
Implement setting up Python
Allow user to take picture of themself
Week 3
Implement Login Page functionality w/ authentication
Send images to Backend
Frontend Playlist Page UI
Week 4
Implement Playlist Creation Logic
Implement model into Python server to get mood from picture
Implement Music Player UI
Week 5
Make Music Player functional w/ spotify_sdk
Implement Emotion UI
Week 6
Connect Emotion functionality to backend
Beta Testing
Week 7
Beta Testing / Fix bugs
Buffer space to catch up on previous work/implement optional features
Week 8
Unifying colors, fonts, transitions.
Beta testing / Fix bugs


Optional Features:
Implement Loading page between form and emotion pages
Implement Internet not found Page UI
Redirect button in Playlist UI to open playlist in Spotify
