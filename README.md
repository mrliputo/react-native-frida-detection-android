# React Native Frida Detection (Android)

React Native native module to detect Frida presence on Android.

- Detects frida-server process
- Looks for suspicious classes
- Checks common Frida port (27042)

Note: No detection is perfect. Combine with root/debugger detection and Play Integrity API.

## Installation

```bash
npm install react-native-frida-detection-android
# or
yarn add react-native-frida-detection-android
```

React Native >= 0.60 is supported via autolinking. No manual linking needed.

## Usage

```js
import { isFridaDetected } from 'react-native-frida-detection-android';

(async () => {
  const detected = await isFridaDetected();
  if (detected) {
    console.warn('Frida detected!');
  } else {
    console.log('No Frida detected.');
  }
})();
```

## Android native module

See `android/src/main/java/com/rnfridadetection/` for Java source.

### ProGuard/R8 (optional)
Obfuscation is recommended. Example keep rules (if you rename/obfuscate packages/classes):

```
-keep class com.rnfridadetection.** { *; }
```

## Development / Testing locally

```bash
# pack a tarball
npm pack
# in your test RN app
npm install ../path/to/react-native-frida-detection-android/react-native-frida-detection-android-*.tgz
```

## Example App
Ada dua opsi:

1) Cepat (generate otomatis di folder ini):

```bash
npm run bootstrap:example
# setelah selesai
cd example/FridaExample
npm start
# terminal lain
npm run android
```

2) Manual di app RN kamu:
```bash
npx react-native init DemoFridaApp --version 0.73.10
cd DemoFridaApp
npm install react-native-frida-detection-android
# salin isi contoh dari example/App.js ke App.js
npm start
npm run android
```

## License

MIT
