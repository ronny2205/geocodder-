# README

This is a small RoR application that allows a user to input an address, and geocodes it using the Google geocoding API (http://bit.ly/1QYAQv1). 

The successfully geocoded locations are stored in the database, along with the longitude and the latitude.
All the database entries are listed at the bottom of the page.

The app is deployed at: https://gecodder-ronny-almog.herokuapp.com/

To run locally:
After clonning the repo, get a google maps API key (https://developers.google.com/maps/documentation/geocoding/get-api-key) and store it in an ENV varable called GOOGLE_MAPS_API_KEY. 

To run the unit tests: run 'rspec' 


For the sake of simplicity, the address input form is US friendly - the user you can select a US state from a dropdowm. If you ignore the state and fill all the other fields, you can geocode international addresses. 