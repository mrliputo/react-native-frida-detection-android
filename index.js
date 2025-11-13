import { NativeModules, Platform } from 'react-native';

const Native = NativeModules.FridaDetection || null;

export async function isFridaDetected() {
  if (Platform.OS !== 'android' || !Native || typeof Native.isFridaDetected !== 'function') {
    return false;
  }
  try {
    const result = await Native.isFridaDetected();
    return !!result;
  } catch (_e) {
    return false;
  }
}

export default { isFridaDetected };

