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

```