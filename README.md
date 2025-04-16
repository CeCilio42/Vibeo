# Vibeo - Flutter Movie Streaming App

## Overview
Vibeo is a modern streaming platform built with Flutter that offers a seamless movie and TV series watching experience. 

## Table of Contents
1. Introduction
2. Features
3. Installation
4. Usage
5. Folder Structure
6. Dependencies

---

## Introduction
Vibeo is designed to provide users with a premium streaming experience, featuring:

- A modern, dark-themed interface optimized for comfortable viewing
- Personalized recommendations based on viewing history
- Collections of movies and TV series
- Easy-to-use navigation and content discovery
- Seamless playback integration
- Mood-based content suggestions

The app prioritizes user experience with a clean design that makes finding and enjoying content effortless.

## Features
- Movies and TV Series streaming
- Personalized recommendations
- My List functionality
- Mood-based filtering
- Horizontal scrolling content rows
- Featured content showcase
- Dark theme optimized interface

## Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/vibeo
   ```
2. Navigate to the project directory:
   ```sh
   cd vibeo
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Run the app:
   ```sh
   flutter run
   ```

## Usage

### Main Screen
The main screen features a gradient background with several key sections:
- Welcome message with user personalization
- Content type filters (Movies, TV-Series, Mood)
- Featured content showcase
- Quick action buttons (Play)
- Recommended content row
- Popular content row

### Navigation
- Use the content type filters to switch between Movies and TV-Series
- Scroll horizontally through content rows to discover more titles
- Add items to My List for quick access
- Play content directly from the featured section

## Folder Structure
```
lib/
 ├── main.dart          # Main entry point
 ├── screens/           # App screens
     └── movie_screen.dart  # Main movie browsing screen
```

## Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  http: ^1.3.0
```
