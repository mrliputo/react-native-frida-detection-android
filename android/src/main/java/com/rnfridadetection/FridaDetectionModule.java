package com.rnfridadetection;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import java.io.BufferedReader;
import java.io.InputStreamReader;

public class FridaDetectionModule extends ReactContextBaseJavaModule {

    public FridaDetectionModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "FridaDetection";
    }

    @ReactMethod
    public void isFridaDetected(Promise promise) {
        try {
            // Check for frida-server process
            Process process = Runtime.getRuntime().exec("ps");
            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.contains("frida-server")) {
                    promise.resolve(true);
                    return;
                }
            }

            // Check for suspicious classes
            try {
                Class.forName("frida");
                promise.resolve(true);
                return;
            } catch (ClassNotFoundException ignored) {}

            // Check for open Frida port (27042)
            Process netstat = Runtime.getRuntime().exec("netstat");
            BufferedReader netReader = new BufferedReader(new InputStreamReader(netstat.getInputStream()));
            while ((line = netReader.readLine()) != null) {
                if (line.contains("27042")) {
                    promise.resolve(true);
                    return;
                }
            }

            promise.resolve(false);
        } catch (Exception e) {
            promise.reject("ERROR", e.getMessage());
        }
    }
}

