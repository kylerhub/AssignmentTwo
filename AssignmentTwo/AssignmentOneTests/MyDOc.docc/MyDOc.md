# ``AssignmentOne``

<!--@START_MENU_TOKEN@-->Summary<!--@END_MENU_TOKEN@-->

Checklist app

## Overview

The project overview...

List of Interactive Checklists

Master View that displays a list of checklist. 

Each entry in the list (item) needs to show the name of the checklist (title).   
Embed your list of checklists in a Navigation View with a title (use a suitable name for your list, e.g. "Checklists"). 
Each item needs to be embedded in a Navigation Link that allows the user to get to a view that shows the corresponding checklist (Detail View) by clicking (tapping) on the Master View list item.  
There needs to be a [+] button that allows to add a new Checklist and an 
Edit button that puts the list of checklists into edit mode, allowing checklists to be deleted.   

The Detail View should be the same view that you used for for last week's milestone with the addition of the ability to interact with the checklist, i.e. tick and untick items, 
as well as an Edit button that allows deleting items and 
resetting the check status of all items (i.e. unchecking all items).  
Ensure that there is an undo function that restores the status of the ticked-off items, in case the user hit the Reset button by accident. 
The Detail View now also needs to contain a back button (typically displaying "Back" or the name of the list in your Master View) at the top left that takes the user back to the list of checklists Master View.  

## Topics

struct Checklist
struct ContentView
struct DataModel
struct Items
struct ListDetailView

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
