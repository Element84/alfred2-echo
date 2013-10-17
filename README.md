# Simple NASA ECHO Collection Searcher

A simple NASA ECHO Collection searcher that does keyword and free text searching against [NASA's ECHO Earth Data Clearing House] (https://api.echo.nasa.gov)

## Usage

Once installed, the workflow responds to 'echo'.  By itself, it returns all of the public collections in ECHO.
![sample1](https://raw.github.com/element84/alfred2-echo/master/screenshots/sample1.png)

With arguments, it performs an ECHO keyword search (free text) against Collection metadata and shows the results.
![sample2](https://raw.github.com/element84/alfred2-echo/master/screenshots/sample2.png)

Selecting any of the results opens a browser pointing to NASA's Reverb application with the collection selected and searches for granules in that collection.
