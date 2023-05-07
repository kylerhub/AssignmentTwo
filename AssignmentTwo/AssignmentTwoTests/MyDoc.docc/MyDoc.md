# ``AssignmentOne``

<!--@START_MENU_TOKEN@-->Summary<!--@END_MENU_TOKEN@-->

FavouritePlaces app

## Overview

The project overview...

The purpose of this milestone is to add an interactive map your FavouritePlaces project to have an app that uses an online map services. 

Make sure you not only store a location name for each place in your app, but also its geographical coordinates (as already shown in the milestone 1 video).  
Add a navigation link to your detail view to display the full information of that location, which includes the name of the location, its coordinates, as well as an interactive map showing the location.  

Make sure that the map updates whenever the coordinates of the location change, and make sure that you allow the user to change the location (coordinates) interactively through the map.  

Pan the map

## Topics

Classes

class Detail
Details include image, latitude, longitude, name and notes.
Belongsto favourite place
class FavouritePlace
Contains Detail
class MyLocation
Extension to MyLocation class to limit latitude and longitude values and format them to 5 decimal places

Structures

struct AssignmentTwoApp
Struct for the app that uses coredata persistence
struct ContentView
The ContentView struct is the Master View for the checklists that navigates to the items of each checklist The purpose of this milestone to create an advanced Master/Detail app with persistent data using CoreData.
struct ListDetailView
The ListDetailView struct is the Detail View for the items within each checklist
struct PH
The purpose of this milestone to create an advanced Master/Detail app with persistent data using CoreData.
struct RowView
struct for image

Variables
let defaultImage: Image
var downloadImages: [URL : Image]
Functions
func saveData()
The purpose of this milestone to create an advanced Master/Detail app with persistent data using CoreData.

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
