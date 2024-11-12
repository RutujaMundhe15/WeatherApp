Weather App 🌤️

The Weather App is a clean, functional iOS application built with SwiftUI. It uses the OpenWeather API to display real-time weather information for a specific city, including current weather, hourly forecast, and an extended 14-day outlook. The app is designed with an elegant and responsive UI that adjusts to different weather conditions with dynamic backgrounds.

Features
Current Weather Information: Shows the current temperature, weather condition, and daily high/low temperatures.
Dynamic Background: Background changes based on the weather (Clear, Cloudy, Rainy, etc.).
Hourly Forecast: Displays the hourly temperature and conditions.
Expandable Bottom Sheet: Tap or swipe to expand the bottom sheet for a detailed 14-day forecast and tomorrow’s weather details.
Real-time Data: Fetches live data from the OpenWeather API, updating as the user opens or refreshes the app.

Prerequisites
To build and run this project, you’ll need:

Xcode 12 or higher
iOS 14.0 or higher
A valid OpenWeather API key

Getting Started
1. Clone the Repository
git clone https://github.com/yourusername/WeatherApp.git
cd WeatherApp

2. Open in Xcode
open WeatherApp.xcodeproj

3. Configure the API Key
Sign up at OpenWeather to get your API key.
Open ContentView.swift.
Replace YOUR_API_KEY in the fetchWeatherData() function with your OpenWeather API key.

4. Build and Run
In Xcode, select your target device or simulator.
Press Cmd + R to build and run the app.

Project Structure
ContentView.swift: Main view with weather display logic.
WeatherResponse.swift: Model struct for decoding API responses.
HourlyForecastCell.swift: A custom SwiftUI view displaying an individual hourly forecast.
FutureForecastView.swift: View for the 14-day forecast and tomorrow’s weather.
Assets: Contains image assets (icons, backgrounds, etc.).

Usage
View Current Weather: The app loads weather data for the specified city.
Swipe Up: Swipe up on the bottom sheet to expand it and view the 14-day weather forecast and detailed information for tomorrow’s weather.
Automatic Updates: The app retrieves real-time data every time it loads.

API Integration
The app integrates with the OpenWeather API for weather data. Ensure you have a valid API key and configure it as instructed in the setup.

API Data Structure
The WeatherResponse struct decodes data from the OpenWeather API. 

Key fields include:
name: City name
main: Temperature data (current, min, max)
weather: Array with condition information (e.g., clear sky, clouds)
wind: Wind speed and direction
sys: Sunrise and sunset times

Dynamic Backgrounds
The app’s background changes based on the weather. For example:
Clear: Sunny background
Cloudy: Cloudy background
Rainy: Rainy background
Backgrounds are defined in the dynamicBackground(for:) function in ContentView.swift.

Known Issues
API Errors: If the API request fails, the app displays a "Loading..." message. Improved error handling is planned.
Static City: Currently, the app fetches data for one predefined city (e.g., London). Future updates may allow dynamic city selection.

Future Enhancements
Location Services: Automatically detect user location for localized weather.
City Selection: Allow users to search for weather in different cities.
Error Handling: Add better error handling and user feedback.
Unit Conversion: Add support for Fahrenheit/Celsius.
