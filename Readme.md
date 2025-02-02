# 🌩 ThunderCat - SwiftUI Weather App

ThunderCat is a modern and lightweight **SwiftUI** weather app that provides real-time weather data using **WeatherAPI.com**.

## 📸 Screenshots
<p align="center">
  <img src="/screenshot1.png" width="300">
  <img src="/screenshot2.png" width="300">
</p>

## 🚀 Key Features  
### **🔹 Data Handling**
- ** Weather Updates**  
  - The app **automatically refreshes** weather data when resuming from the background, ensuring users always see the latest conditions.  
  - Uses **UserDefaults** to persist the last searched location.  

- **Optimized API Calls**  
  - **Search Call /search**: Fetches a list of matching locations.  
  - **Weather Call /current**: Fetches real-time weather for each searched location.  

- **Dynamic Wind Direction Indicator**  
  - The wind direction icon rotates dynamically based on **wind degree data** from the API, accurately pointing in the direction the wind is blowing.  

## 🛠 Tech Stack
- **Swift** & **SwiftUI**
- **MVVM Architecture**
- **Async/Await API Integration**
- **UserDefaults for Data Persistence**

## 📦 Installation
1. Clone the repository:  
   ```bash
   git clone https://github.com/kevinkang88/ThunderCat.git
   
2. Sign up at WeatherAPI.com and obtain APIKEY

3. Add it to WeatherService.swift

```swift
private let apiKey = "YOUR_API_KEY"
```
