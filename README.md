Below is a complete `README.md` file for the provided Flutter package. This `README` explains the purpose of the package, how to use it, and provides examples and configuration details.

---

# Custom Swipe to Confirm Widget

A Flutter package that provides a customizable swipe-to-confirm widget. This widget allows users to perform an action by swiping horizontally, with optional animations, error handling, and success states.

---

## Introduction

The `CustomSwipeToConfirmWidget` is designed to enhance user interaction in your Flutter app by providing a swipe-based confirmation mechanism. It supports animations, error handling, and customization options such as button text, colors, and retry functionality.

---

## Features

- **Swipe-to-Confirm**: Users can confirm actions by swiping horizontally.
- **Customizable UI**: Change button colors, text, and styles to match your app's design.
- **Error Handling**: Display error messages and allow retries if the action fails.
- **Animation Support**: Smooth animations for swipe progress and completion.
- **Active/Inactive States**: Disable the button when needed.
- **Callback Functions**: Execute custom logic on swipe completion or failure.

---

## Installation

Add the package to your `pubspec.yaml` file:

```yaml
dependencies:
  custom_swipe_to_confirm: ^0.0.1
```

Then, run the following command to install the package:

```bash
flutter pub get
```

---

## Usage

### Basic Example

Here’s how to use the `CustomSwipeToConfirmWidget` in your Flutter app:

```dart
import 'package:flutter/material.dart';
import 'package:custom_swipe_to_confirm/custom_swipe_to_confirm.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFinished = false;
  bool hasFailed = false;

  void onFinish() {
    setState(() {
      isFinished = true;
    });
    print('Action completed!');
  }

  void onWaitingProcess() {
    print('Waiting for process...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Swipe to Confirm'),
      ),
      body: Center(
        child: CustomSwipeToConfirmWidget(
          onFinish: onFinish,
          onWaitingProcess: onWaitingProcess,
          isFinished: isFinished,
          hasFailed: hasFailed,
          activeColor: Colors.green,
          buttonWidget: Icon(Icons.arrow_forward),
          buttonText: 'Swipe to Confirm',
          retryText: 'Try Again',
        ),
      ),
    );
  }
}
```

---

### Customizing the Widget

You can customize the appearance and behavior of the widget using its properties:

```dart
CustomSwipeToConfirmWidget(
  onFinish: () {
    // Action to perform when the swipe is complete
  },
  onWaitingProcess: () {
    // Action to perform while waiting for the process to finish
  },
  isFinished: false, // Set to true when the action is complete
  hasFailed: false, // Set to true if the action fails
  isActive: true, // Enable or disable the button
  activeColor: Colors.blue, // Color of the button when active
  disableColor: Colors.grey, // Color of the button when disabled
  buttonWidget: Icon(Icons.check), // Widget to display inside the button
  buttonText: 'Swipe to Confirm', // Text to display on the button
  retryText: 'Retry', // Text to display when retrying after failure
  buttontextstyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // Button text style
  indicatorColor: AlwaysStoppedAnimation(Colors.white), // Color of the loading indicator
  borderRadius: BorderRadius.all(Radius.circular(22.5)), // Border radius of the widget
);
```

---

## Properties

| Property            | Type                  | Description                                                                 |
|---------------------|-----------------------|-----------------------------------------------------------------------------|
| `onFinish`          | `VoidCallback`        | Callback function executed when the swipe is complete.                     |
| `onWaitingProcess`  | `VoidCallback`        | Callback function executed during the waiting process.                     |
| `isFinished`        | `bool`                | Indicates whether the action is complete.                                  |
| `hasFailed`         | `bool`                | Indicates whether the action has failed.                                   |
| `isActive`          | `bool`                | Enables or disables the button. Default: `true`.                           |
| `activeColor`       | `Color`               | Color of the button when active.                                           |
| `disableColor`      | `Color?`              | Color of the button when disabled.                                         |
| `buttonWidget`      | `Widget`              | Widget to display inside the button.                                       |
| `buttonText`        | `String`              | Text to display on the button.                                             |
| `retryText`         | `String?`             | Text to display when retrying after failure.                               |
| `buttontextstyle`   | `TextStyle?`          | Style of the button text.                                                  |
| `indicatorColor`    | `Animation<Color>?`   | Color of the loading indicator.                                            |
| `borderRadius`      | `BorderRadius`        | Border radius of the widget.                                               |

---

## Contributing

 Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/new-feature`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add new feature'`).
5. Push to the branch (`git push origin feature/new-feature`).
6. Open a pull request.

---

## License

This package is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

---

This `README` provides a comprehensive overview of the package, making it easy for developers to understand and integrate the `CustomSwipeToConfirmWidget` into their Flutter projects.