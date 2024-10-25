# My Little Radio

This project is built with **SwiftUI** and **The Composable Architecture (TCA)**. It's a basic radio app that lists radio stations, allowing users to view details and play station streams. Since TCA was a new framework for me, I worked on balancing SwiftUI principles with TCA requirements, trying to keep things as simple and manageable as I could.

## Project Overview

- **Data Fetching**: Data is retrieved from a mock Node.js server that simulates an API calls, providing station information from `http://localhost/stations`.
- **Feature**:
  - **Navigation to Detail View**: Selecting a station opens a detail view with the full station name and playback controls.
  - **Audio Playback**: Audio streaming functionality was built using an AVPlayer trying to fit into a TCA Feature which manage play/pause actions and state updates.
  - **UI**: I experimented with SwiftUI's design capabilities, focusing on layout, colors, and basic animations. This is my first real experience with swiftUI, so I didn't push things too hard

## What I Did

1. **Integration with Mock Server**: Replaced the mock data with live data from a local server. Added a simulated loader and an error-handling popup with a retry option.
   
2. **Navigation with Detail View**: Integrated navigation to a `StationDetailsView` for each station. Initially tried a hero animation but encountered display artifacts, so I reverted to using a sheet.

3. **Audio Streaming**: Using `AudioPlayerFeature`, users can play and pause streams directly from the detail view. This TCA feature handles state updates in line with play/pause controls.

4. **Accessibility**: Added a little accessibility label on radio station cards to support VoiceOver for people which needs it.

## Challenges

### Managing TCA State and Dependencies

With multiple features needing to interact and share state, managing dependencies like `audioPlayerClient` was occasionally challenging, especially when working with mock data in tests. Having `AppFeature` manage multiple feature states was useful but can become overwhelming if the app grows and will need modularisation

### SwiftUI Animations

Being new to SwiftUI, I experimented with various animations, including the `matchedGeometryEffect` for a hero-style animation, but eventually opted for a more straightforward sheet presentation due to artifact issues.

<p align="center">
  <img src="hero.gif" alt="Hero Animation Attempt"/>
</p>

<p align="center">
  <em>Hero animation using matchedGeometryEffect. I switched to a sheet due to display issues.</em>
</p>

### Testing with XCTest

Switching to XCTest rather than swift testing for speed, and few ressources where available online.
Also Leveragng TCA `TestStore` to test features.

## What I Learned

With this project  I tried to plugin SwiftUI’s declarative style TCA structure. I started to learn state management, actions, reducers and manage navigation via sheets. 

## Moving Forward

1. **Modularization**: Further splitting features into more modular components for scalability.
2. **Dynamic Island Support**: Extend audio playback controls to the Dynamic Island for a better user experience.
3. **Advanced Animations**: Improve animations by exploring `matchedGeometryEffect` more thoroughly.
4. **UI Testing**: Expand XCTest cases to cover more of the UI interactions and user flows.
5. **Enhanced Design**: Experiment more with SwiftUI design to improve the visual layout, especially around audio player indicators and station cards.

## Time Spent

- **Day 1 (4 hours)**: Familiarized myself with TCA, initial API setup, and basic UI.
- **Day 2 (3 hours)**: Experimented with animations, encountering some issues with `matchedGeometryEffect`.
- **Day 3 (3 hours)**: Integrated the audio player feature and get back to bottom-sheet navigation.
- **Day 3 (2 hours)**: Implemented last tests and worked on readme.
