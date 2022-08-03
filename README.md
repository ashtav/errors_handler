## Usage

To use this plugin, add `errors_handler` as a [dependency in your pubspec.yaml file](https://flutter.dev/platform-plugins/).

### Example

```dart 

try {
    // your code
} catch(e, s){
    Errors.check(e, s).then((Errors err){
        // do something...
        // We can make a report on this, send it to telegram (bot), etc
    });
}

// DEBUG CONSOLE

// [LOG] -- Error on MyClass.myMethod (Line 28), type 'int' is not a subtype of type 'String' of 'other'
// [LOG] 
//       -- Please check the errors below:
// [LOG] 1. package:myapp/app/controllers/my_class.dart 26:8 in MyClass.myMethod
// [LOG] 2. package:myapp/app/views/app_view.dart 28:30 in TestView.build.<fn>
// [LOG] 3. package:flutter/src/material/ink_well.dart 1005:21 in _InkResponseState._handleTap

```