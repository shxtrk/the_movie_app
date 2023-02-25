# The Movie App

This iOS app displays a list of movies using the IMDB service API. It uses a complex, reusable, and testable architecture based on the Clean-MVVM architecture pattern. The app is designed to be responsive, precise, and accurate according to iOS design guidelines.

## Functionality

The app provides the following key functionality:

- A screen that displays the first 10 results from the list of TOP250Movies.
- Each result cell displays the movie's title, rank, and image.
- Tapping a cell redirects to a details screen.
- The details screen counts the occurrence of each character in the title of the selected movie and displays the results.
- The results are displayed using a UITableView.

## Additional Features

The app includes the following additional features:

- Response data local cache to improve performance.
- Image cache to improve performance and reduce network requests.
- Pull-to-refresh functionality to refresh the list of movies.
- Remote search to search for movies by keyword.

## Architecture

The app is built using the Clean-MVVM architecture pattern, which emphasizes separation of concerns and promotes testability, reusability, and maintainability of code. The app is designed to be modular, with each component responsible for a specific task.

## Third-Party Libraries

The app does not use any third-party libraries, and all functionality is implemented using native iOS frameworks and technologies.

## Installation

To run the app, follow these steps:

1. Clone the repository to your local machine.
2. Open the project in Xcode.
3. Build and run the app on a simulator or device.

## Conclusion

This iOS movie app provides a clean and responsive user experience, while also demonstrating advanced architectural concepts and best practices. It is designed to be easy to maintain and extend, with clear separation of concerns and a focus on code modularity and reusability.

## License

[MIT](https://choosealicense.com/licenses/mit/)

MIT License

Copyright (c) 2023 Serhii Striuk

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Authors

- [@shxtrk](https://github.com/shxtrk)
