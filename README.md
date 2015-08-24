# FogOrNot
Predicting fog coverage in San Francisco

The goal of 'Fog Or Not' is to predict fog coverage at the neighborhood level in San Francisco. The unique geography and climate of San Francisco mean that different areas of the city can have very different weather at the same time – it can be sunny on one side, and completely foggy on the other. My idea is to use data from amateur weather stations in different neighborhoods across the city to make predictions at a very local level. Ultimately, I want to display these predictions on a map that shows where the fog will be several hours from now, and at what intensity.

`main.R` is the main script.

`mapping.R` has functions to handle the mapping. It uses the `ggmap` package to access the Google Maps API as a layer on top of the`ggplot2` (the popular R package for plotting).

`forecasts.R` has functions to pull forecasts from Weather Underground and convert them into the right formats for this project.

`wu_api.R` has functions that access the Weather Underground APIs.
