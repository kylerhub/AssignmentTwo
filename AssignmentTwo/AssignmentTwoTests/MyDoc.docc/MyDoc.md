# ``AssignmentOne``

<!--@START_MENU_TOKEN@-->Summary<!--@END_MENU_TOKEN@-->

Checklist app

## Overview

The project overview...

The purpose of this milestone to create an advanced Master/Detail app with persistent data using CoreData.  

You need to create a SwiftUI app that called FavouritePlaces, that runs on iOS in the simulator on the lab computers.  

The goal of the App is to keep a list of your favourite places, including detailed information and a picture.  For the first milestone, implement a Master/Detail user interface with persistent data.  Ensure that the Master View displays a list of (any number) of places.  

Each entry in the list (item) needs to show a thumbnail preview of the image of the place, the name of the place, and the location. 

The Master View needs to be fully editable, i.e., you need to be able to add, remove, and edit elements.

Embed your list in a Navigation View with an editable title.   
Each item needs to be embedded in a Navigation Link that allows the user to get to a Detail View by clicking (tapping) on the list item.  
The Detail View should show at least the image (or its URL when in editing mode), the name, the location, and notes.  
All elements including the image URLs and notes need to be fully editable, i.e., you need to be able to add, remove, and edit elements.  
The Detail View also needs to contain a back button (typically displaying the name of the list) at the top left that takes the user back to the list (Master View).

## Topics

Classes
class Detail
class FavouritePlace
Structures
struct AssignmentOneApp
struct Checklist
Struct for checklists with all items
struct ContentView
The ContentView struct is the Master View for the checklists that navigates to the items of each checklist Importantly, all data now need to be persistent through JSON serialisation.
struct DataModel
Struct for all the checklists
struct Items
Struct for all items with their checkedStatus
struct ListDetailView
The ListDetailView struct is the Detail View for the items within each checklist
struct PH
struct RowView
Variables
let defaultImage: Image
var downloadImages: [URL : Image]
Functions
func getFile() -> URL?
Function for JSON for persistence
func saveData()

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
