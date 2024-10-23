#  Jewell's CVS Health take home project

Thank you for reviewing my project app! 

## Steps to run the app are simple - clone the repo in your terminal by running 
`git clone https://github.com/jewell86/CVSFlickrApp.git`
### Open the project in Xcode & press the play button!

## This simple photo app has a couple functions:
### Upon first app launch, the photo grid is blank & a searchbar is present
### When entering a search term, a search is completed for each character entered & the photos are loaded
### When a photo is selected, a new view is presented with more detailed information about the photo & a larger photo
### VoiceOver & Dynamic Text are both supported

## Testing
### To run the UI & unit tests, tap the uppermost diamond symbol for each test file, or the diamond symbol next to the desired test.

## Notes about the architecture & code choices
### This MVVM design is common with SwiftUI implementation & is the design that I'm most familiar with, so I chose to follow that pattern
### I would have added Snapshot testing given more time, as well as covered all of the UI Views with tests
### Error handling is simply printed error statements, but given more time I would add user friendly error messages where needed
### The classes/files were all small enough that I decided against muddying them up with // MARK:, aside from the Mocks file
