# Weather App

A cross-platform application built in Flutter which tells the user about the weather conditions at their location.

## Architecture: BLoC
<a href="https://github.com/felangel/bloc"><img src="https://tinyurl.com/bloc-library" alt="Bloc Library"></a>

This application incorporates one of the most famous and community loved architecture `BLoC` which stands for `Business Logic Component`. This separates the business logic from the user interface which makes the code more testable, cleaner, and manageable.

<img src="https://raw.githubusercontent.com/felangel/bloc/master/assets/diagrams/bloc_architecture.png" width="500" alt="Bloc Architecture"></img>

## Weather API
OpenWeather's API is used to fetch the weather at a given location. A highly maintained wrapper for this API is already built and deployed on pub.dev named [Weather](https://pub.dev/packages/weather). This makes the task of fetching weather data much easier

## Platform Compatibilty
Can run on following platforms:
- <img src="https://cdn-icons-png.flaticon.com/512/226/226770.png" width="20" alt=""> Android
- <img src="https://icons.iconarchive.com/icons/iconsmind/outline/256/iOS-Apple-icon.png" width="20" alt=""> iOS
- <img src="https://static-00.iconduck.com/assets.00/macos-icon-2048x2048-uavbc6sb.png" width="20" alt=""> MacOS
- <img src="https://www.downloadsource.net/image/uploaded/English_2021_Q1/Windows_11_Customise_No_Activation/Windows_11.png?fit=max&s=d0b23fec60b53d943a6405fda1a25806" width="20" alt=""> Windows
- <img src="https://static-00.iconduck.com/assets.00/website-icon-2048x2048-ax2y60lj.png" width="20" alt=""> Web
