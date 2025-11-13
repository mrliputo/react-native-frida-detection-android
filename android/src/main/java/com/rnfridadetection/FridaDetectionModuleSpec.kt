package com.rnfridadetection

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise

// Optional: if using RN Codegen in the future
abstract class FridaDetectionModuleSpec(context: ReactApplicationContext) : ReactContextBaseJavaModule(context) {
    @ReactMethod
    abstract fun isFridaDetected(promise: Promise)
}

