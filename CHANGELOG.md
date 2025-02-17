
## Version 0.0.1

### **Released: [2025-02-17]**

#### **Initial Release**
- **Description**: The first version of the `CustomSwipeToConfirmWidget` package introduces a customizable swipe-to-confirm widget designed to enhance user interaction in Flutter applications.

#### **Features**
- **Swipe-to-Confirm Mechanism**:
  - Users can confirm actions by swiping horizontally.
  - Supports animations for smooth transitions during the swipe process.

- **Customizable UI**:
  - Change button colors, text, and styles to match your app's design.
  - Customize the button widget, border radius, and text styles.

- **Error Handling**:
  - Display error messages when an action fails.
  - Provide a retry option with customizable retry text.

- **Active/Inactive States**:
  - Enable or disable the button based on the app's logic.
  - Differentiate between active and inactive states using distinct colors.

- **Callback Functions**:
  - Execute custom logic when the swipe is complete (`onFinish`).
  - Handle intermediate states with the `onWaitingProcess` callback.

- **Animation Support**:
  - Smooth animations for swipe progress, success, and failure states.
  - Customizable indicator color for loading states.

#### **Properties**
- Introduced the following properties for customization:
  - `onFinish`: Callback function executed when the swipe is complete.
  - `onWaitingProcess`: Callback function executed during the waiting process.
  - `isFinished`: Indicates whether the action is complete.
  - `hasFailed`: Indicates whether the action has failed.
  - `isActive`: Enables or disables the button (default: `true`).
  - `activeColor`: Color of the button when active.
  - `disableColor`: Color of the button when disabled.
  - `buttonWidget`: Widget to display inside the button.
  - `buttonText`: Text to display on the button.
  - `retryText`: Text to display when retrying after failure.
  - `buttontextstyle`: Style of the button text.
  - `indicatorColor`: Color of the loading indicator.
  - `borderRadius`: Border radius of the widget.

#### **Known Issues**
- None reported at this time.

#### **Future Improvements**
- Add support for vertical swipe gestures.
- Enhance accessibility features for better usability.
- Optimize performance for large-scale applications.