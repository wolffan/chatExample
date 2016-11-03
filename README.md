# chatExample
[![Build Status](https://travis-ci.org/wolffan/chatExample.svg?branch=master)](https://travis-ci.org/wolffan/chatExample)
Example of a chat conversation UI

No dependenceis are needed to run the project.
Tests will run with CMD+U

Overall architecture:

Router that handles all dependencies and controllers.
Controllers talk to extending Router methods in order to not have hidden dependencies between them
Cells have viewModel to abstract the presentation logic from Controller and Cell
Data is fetched and injected through Repositories with different protocols so each class has only the data it needs.
