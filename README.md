# chatExample
Example of a chat conversation UI

No dependenceis are needed to run the project.
Tests will run with CMD+U

Overall architecture:

Router that handles all dependencies and controllers.
Data is fetched and injected through Repositories with different protocols so each class has only the data it needs.
Missing: Controllers and cells should not get injected the repository but a ViewModel with the repository.
