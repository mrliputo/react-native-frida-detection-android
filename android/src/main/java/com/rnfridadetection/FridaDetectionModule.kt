package com.rnfridadetection

import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext

class FridaDetectionModuleKt(reactContext: ReactApplicationContext) : FridaDetectionModuleSpec(reactContext) {
    override fun getName() = "FridaDetection"

    override fun isFridaDetected(promise: Promise) {
        try {
            // Kotlin wrapper delegates to Java impl for stability (or implement here natively)
            promise.reject("UNAVAILABLE", "Kotlin module not wired. Use Java module.")
        } catch (e: Exception) {
            promise.reject("ERROR", e.message)
        }
    }
}

