# onstagoram :  Flutter Instagram UI Clone - Development Details

This repository contains a Flutter Instagram UI clone. The project demonstrates a simplified version of Instagram, built using Flutter. 
It showcases how to create a user interface similar to Instagram and how to manage the state, user input, and UI updates with GetX.

<img src="https://github.com/chasangchual/onstagoram/blob/main/docs/capture-home.png" alt="Home View" width="300" /><img src="https://github.com/chasangchual/onstagoram/blob/main/docs/capture-search.png" alt="Search View" width="300" />
<br>
[![watch Onstagoram](https://github.com/chasangchual/onstagoram/blob/main/docs/youtuve-thumb.png)](https://www.youtube.com/shorts/kDk0tgzlYyc)
[![watch Onstagoram](https://github.com/chasangchual/onstagoram/blob/main/docs/youtuve-thumb.png)](https://github.com/chasangchual/onstagoram/blob/main/docs/recording.mp4)

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

-

# Implementation Details


## Main View

The **main view** is the starting point of the app, built with the **Scaffold** widget. It includes the **AppBar**, **Body**, and **BottomNavigationBar**.

- **AppBar**: Displays the app's title and actions. The actions allow the user to perform certain tasks (e.g., liking a post or sending a message).
    - The `actions` in the AppBar are aligned to the right by default.
    - Additional icons are added to the AppBar's right side via the `actions` parameter.

- **BottomNavigationBar**: Provides navigation between different views (e.g., Home, Search). It functions like tabs, where each item corresponds to a specific view.
    - Each item in the BottomNavigationBar is identified by its index, and navigation is handled via the `onTap(index)` gesture.
    - The views are linked to specific indexes using **enums**.
    - The active view’s index is managed using **GetX**, ensuring that state is updated reactively as the user navigates.

- **Body**: Displays the view selected by the **BottomNavigationBar**. Each view (e.g., Home, Search) is dynamically loaded based on the user’s selection.

### Theme Management

The app’s theme, including colors and fonts, is defined using **ThemeData** to ensure consistency across the entire app.

---

## Home View

The **Home view** is split into two parts:
1. **User Stories**: A horizontally scrollable list showing the recent activity of users.
2. **Feed List**: A vertically scrollable list showing the feed of posts.

- **User Stories**:
    - The horizontally scrollable user list is implemented using **SingleChildScrollView** with `scrollDirection: Axis.horizontal` and a **Row** widget.
    - Each user story is represented by a **Container** with circular borders (using `borderRadius`) to display the user profile picture.
    - The `BoxDecoration` widget is used to add background color and style to each user story container.

- **Feed List**:
    - The vertical feed of posts is built using **ListView.builder**.
    - To prevent overflow issues when rendering long feeds, the `shrinkWrap` and `physics` parameters are set accordingly:
        - `shrinkWrap: true` ensures that the ListView doesn't take up more space than necessary.
        - `physics: NeverScrollableScrollPhysics()` disables internal scrolling to allow smooth integration with the overall page scroll.
    - Each feed post is generated dynamically using `itemBuilder`, which creates and returns widgets for each item in the list.

- **Post Layout**:
    - Each post consists of a top bar (containing the user’s profile and post options), the post’s image, a bar for user interactions (like, comment, share), and the post’s caption.
    - The top bar is divided into two main groups:
        - The first group contains the user’s profile image and username, placed inside a **Row** widget.
        - The second group contains icons for post options like the three-dot menu.
    - For more advanced layout requirements (such as multi-line captions), **RichText()** and nested **TextSpan** are used to manage complex text formatting.

### Code Snippet (User Story Container)

```dart
Container(
  width: 80,
  height: 80,
  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
  margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
  decoration: BoxDecoration(
      color: RandomColor.getColorObject(Options(colorType: ColorType.orange, luminosity: Luminosity.light)),
      borderRadius: BorderRadius.circular(40)),
)
```

---

## Search View

The **Search view** is designed to help users explore and discover new content. It consists of:

1. **Search Bar**: A text field where users can input search keywords.
2. **Feed Grid**: A grid layout displaying search results or suggested posts.

- **Search Bar**:
    - The search input is created using a **TextField** widget.
    - The `TextField()` widget is wrapped in a **SizedBox** to control its dimensions and ensure proper layout.
    - The `decoration` property of **TextField** is used to style the input field with a grey background and round corners, making it visually distinct from other parts of the app.
    - The padding of the input field is managed using the `scrollPadding` property, which is reset from the default value to `EdgeInsets.all(0)` for better alignment within its parent widget.

- **Feed Grid**:
    - The grid layout is implemented using **GridView.count()**, which organizes the content in a 3-column grid.
    - The `physics: NeverScrollableScrollPhysics()` setting ensures that the grid scrolls smoothly with the overall page, avoiding conflicts with the main scroll behavior.

### Code Snippet (Search Bar)

```dart
TextField(
  cursorColor: Colors.black38,
  scrollPadding: EdgeInsets.all(0),
  decoration: InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade200,
      prefixIcon: Icon(Icons.search),
      hintText: 'search keyword',
      hintStyle: TextStyle(color: Colors.black12),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1)),
      contentPadding: EdgeInsets.all(0)),
)
```

---

## GetX for State Management

**GetX** is used extensively to manage the state of the app, ensuring smooth transitions and responsive user interaction. Key elements of the app (such as the **BottomNavigationBar** and the active view) are managed through **GetX** controllers.

- **BottomNavigationController**: Handles view transitions, ensuring that the correct view is displayed when a tab is selected.
    - The active state of the current view is tracked using **Rx** variables in **GetX**, allowing the UI to reactively update based on user input.
    - **Obx()** is used to wrap UI elements that need to reactively update when the state changes.

### Code Snippet (Main View with GetX)

```dart
GetMaterialApp(
  initialBinding: AppBinding(),
  theme: ThemeData(
      colorScheme: const ColorScheme.light(primary: Colors.white, secondary: Colors.black),
      useMaterial3: true),
  home: Scaffold(
    appBar: BottomNavigationController.to.activeView() == BottomNavigation.home
        ? AppBar(
            title: Text("Onstagoram", style: GoogleFonts.lobsterTwo(color: Colors.black, fontSize: 24)),
          )
        : null,
    body: OnstagoramBody(),
    bottomNavigationBar: BottomNavigationBar(
      onTap: (index) {
        BottomNavigationController.to.tap(index);
      },
    ),
  ),
);
```

---


This **Flutter Instagram UI clone** demonstrates a functional and visually appealing app structure, showcasing how to implement an Instagram-like UI with **Flutter**. With **GetX** for state management, the app maintains smooth transitions and responsive UI updates. This template can be extended to incorporate additional features, refine the design, or improve user interaction for a more comprehensive Instagram clone experience.
