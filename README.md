# LiveStreamAndComment
### Summary of the Assignment

Objective: Implementation of the “Live” Stream Playback and Commenting UI using Swift, UIKit, AVFoundation, UICollectionView and UITableView. UI has to implemented with Storyboard UI design and auto layout and/or programming UIView creation. 

Approach:  To implement the requirements of the Assignment I have followed the MVVM-Coordinator pattern to ensure seperation of conerns, used delegate pattern for communication.

Coordinator pattern for navigation logic handling in the app. 

Features Implemented:

- Created a full screen video player view with the user information such as user name, user profile pictures, likes count, viewers count, explore  and follow data.
- One player visible at a time, Video play and loop automatically
- Each cell has its own data such as video, user details.
- Comments on the video should be loaded in the transparent UITableview for every 2 seconds.
- Comment should display user information such as user name, profile picture, and comment.
- Pixel perfect UI and Colors as per UI/UX provided in the Figma design.
- Keyboard show and hide implementation and handle the UI updates as per the requirement such as UI pushes up for better user experience and visibility of comments.
- User can add her/his own comments which gets added to the existing comments list.
- Load content from the JSON files - video and comments

In the bonus points following requirement has been implemented.

1. Single tap should pause or resume the player. 

Technical Details:

- Image fetch and cache logic has implemented by loading image from the url using NSURLSession and caching using NSCache.
- To handle the auto layout have used the third party framework - Cartography

Challenges and Resolutions: 

- Relearning of AVFoundation framework (which I worked my initial period of career) and implementation of requirements.
- This assignment is full of learning and refreshing coding challenge than usual to-do list. Thank You for challenge.

Further improvements (could have implemented are), 

1. Unit test. 
2. Usage of reactive programming (RxSwift) for binding purpose. 
3. Improve the coding practice.
