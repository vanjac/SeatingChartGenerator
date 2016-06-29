# Seating Chart Generator
Seating Chart Generator is a suite of programs for creating class seating charts. Features include:
- Easily create student lists, or load them from Excel files.
- Create arbitrary desk layouts, based on the layout of the desks in your room.
- Generate seating charts manually or have the computer randomize them. Seating charts can be adjusted after they have been generated. They also can be saved or printed.
- Create and save "constraints" for students. You can limit the desks that a student is allowed to sit at, and also restrict specific students from sitting too close together.

It requires [Processing 3](processing.org) to compile, along with the `ControlP5` library. Additionally, the contents of the `libraries` folder should be combined with Processing's libraries folder.

4 programs are included:
- ClassCreator is used to create lists of students.
- DeskLayout is used to arrange desks
- SeatingChartCreator is used to assign constraints to students and generate seating charts.
- ChartPrinter is used to create printable PDFs from the seating charts.

## ClassCreator
ClassCreator is used to create `.scclass` files (student lists). You can create lists manually, load them from Excel files, or do a combination of both. The SeatingChartGenerator program can only read .scclass files - not Excel files - so ClassCreator can be used as a converter for Excel files to work with the program.

### Creating Student Lists Manually
To create a new student, click the `+ STUDENT` button next to the student list. A new student will appear with the label `(N)`. The `N` represents No Gender, and will change to an `M` or `F` depending on what gender you select. You can then type in a first name, middle name, last name, and select a gender. Make sure that you press Enter in each of the text boxes to apply your changes. It is also important that you click the `+ STUDENT` button before entering student information.

All you need for a student to be valid is a first name. The program currently does nothing with the gender information, or the separation of names into 3 parts. However, the extra information could become useful in the future.

Click any student in the list to select it. The student's information will appear to the right. You can then edit the information, again making sure to press Enter in each text box to apply your changes.

Click the `SAVE` button at the top of the window to save the student list to a file. The `.scclass` extension will automatically be appended to the file name. Click `LOAD` to load a .scclass file you have previously created. Click `CLEAR` to clear the student list, the equivalent of starting a new document. When closing the program, it will not warn you if you haven’t saved your changes!

### Loading Student Lists from Excel Files
You can load lists of students from an Excel file. The file should have a `.xls` extension, not `xlsx,` so you may have to save your files in a different format.
Click the `LOAD EXCEL` button at the top of the window to open the file dialog. Once you have chosen the file, the `Load from Excel file` window will appear. Make sure there is not a Load from Excel window already open when you do this.

Once you have chosen your Excel file, you can select the options for how it should read it. Choose the cell you would like it to start reading at, and the direction you would like it to read. Click `OK` to start reading. As explained in the dialog, it will keep reading cells until it encounters a blank one. The text in each cell will be put in the First Name section of the student - it does not automatically separate names.

The dialog will not close on its own, but if all has gone well the text `FILE READ` will appear in green and the student list in the main window will have some names in it. If there were already students there, the new students will be added on. DO NOT CLOSE THE DIALOG! If you do, there is a bug that causes the entire program to close.

## DeskLayout
The DeskLayout program is used to design arrangements of desks. Each square on the grid represents a space for a desk. When you click a square, it will turn light blue, indicating that there is a desk there. Click it again, and it will turn dark blue, indicating that there is an empty space. You can click and drag to place many desks at once. You can draw your desks anywhere on the screen - the grid will be automatically cropped.

Click `SAVE` to save the current desk arrangement as a `.png` file, readable by the SeatingChartCreator. Click `LOAD` to load a valid image file. Click `CLEAR` to clear all desks, the equivalent of starting a new document.

## SeatingChartCreator
SeatingChartCreator program is used to create / randomize seating charts and design "constraints" for students.

On the left side of the window is the file panel. There is a `LOAD FILE` button at the top, which is used to load classes, desk layouts, constraints, and previously created seating charts. Below that is a menu with options to save constraints or the seating chart, or clear all constraints.

When you load a class file, a list of students will appear in the `STUDENTS` list on the right. This list is scrollable with a tiny scrollbar to the right (it is not always obvious that it is scrollable).

When you load a desk layout file, the desk arrangement will appear as a group of blue rectangles with Xs in the corners. You need at least a class file and a desk layout file loaded to use most of the functions of the program.

*Bug:* In very rare cases, extra desks and duplicate students can appear. If this happens, just reload the class or desk files.

### Manually Placing Students
Click a student's name in the list to select it – the student's full name will appear under `SELECTED STUDENT` above the list. Now click a desk. The student's name will disappear from the list and be moved to the desk.

Click the 'X' button in the top right corner of the desk to remove the student from the desk and move it back to the list. If you would like to start over, click `CLEAR ALL` in the top right corner. As you remove and add students to the list, the list will probably get out of order.

### Randomizing Seating
When you click the `RANDOMIZE` button in the top right corner, the remaining students in the students list will be placed in random desks. Students that were already in desks will not change positions.

After the students have been randomized, you can manually rearrange them as described above. To randomize them again, you'll have to click `CLEAR ALL` first.

Below the `RANDOMIZE` button you can select the fill mode. `RANDOM` fills desks completely randomly. `BOTTOM-UP` fills desks starting at the bottom, and moving up. `TOP-DOWN` starts at the top, and moves down.

### Setting Allowed Desks
If you have a student selected and a desk layout file loaded, you can click the `ALLOWED DESKS` button under the Constraints menu on the lower right side. When you click this, the desks will all turn green - this means that the student is allowed to sit at them. You can click a desk to make it turn red - this means that the student is not allowed to sit at it. Click it again to make it turn green. You can click and drag over a row of desks to activate them all at once.

Click `DONE` in the top right corner to apply your changes. If you have made any changes, the text `LTD. DESKS` (standing for Limited Desks) will appear next to the student’s name. When the seating chart is randomized, students will only be put in desks they are allowed to sit at. However, the desk limitations will not prevent you from manually placing students in desks they are not allowed to sit at.

### Adding Constraints
You can add "Constraints" to students to restrict their seating in relation to other students. With a student selected, click `NEW...` under the Constraints menu on the right. A menu will appear with only one option: `PROXIMITY.` Other types could be added in the future.

When you add a constraint, it will appear in the `CONSTRAINTS` list. Text will also appear next to the student’s name listing how many constraints it has. Click the constraint to select it - its properties will appear below.

A Proximity Constraint restricts a student’s distance to another student. You can force students to be farther away than the distance specified so that the students can’t sit together ("> distance"), or closer, so that the students must sit together ("<= distance"). You can adjust these settings in the properties section. Make sure you press Enter when typing in the distance to apply your changes.

When scanning for students within the specified distance, the program scans in a square centered on the student with the constraint. Empty spaces are included in the distance. The distance must be at least 1 for the constraint to have any effect. A distance of 1 prevents the student from sitting next to, or directly diagonal to, the other student.
It is generally not a good idea to have duplicate constraints - for example, giving Student A a Proximity Constraint to Student B, and Student B a Proximity Constraint to Student A.

Click `DELETE` (next to the `NEW...` menu) to delete the selected constraint. Click the `CLEAR` button under the Constraints section in the file panel on the left side to clear all constraints for all students.

If the program takes too long to generate a seating chart, it will eventually "give up." This can happen if you have very large distances in your constraints (> 5), if you have too many constraints, or if you have a set of constraints that is difficult to achieve. When the program is thinking, the `RANDOMIZE` button is highlighted light blue. If it can’t generate a seating chart, it will give you an error message. You can try again, but if it does this every time, it probably isn’t going to work.

### Hiding Things
All of the menus in the program can be collapsed. If, for example, you have the program open and would not like students to see the constraints you have assigned to them, just click the arrow next to the `CONSTRAINTS` menu bar.

## ChartPrinter
The ChartPrinter is used to print seating chart files (`.scdata`). When you start the program, it will first prompt you for the seating chart to use, and then for the PDF file to save to. Once you have chosen this, it will show the seating chart.

At the bottom of the screen is a grey slider. Drag this slider left or right to change the font size.

At the top of the screen is a grey box. Click in this box and type to make a title.

Only once you press Enter in the text box at the top of the screen will the program save the file.
