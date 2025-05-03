plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
   
}

android {
    namespace = "com.aadaiz.h.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true  // ✅ Add this line
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.aadaiz.h.app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 21
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
           proguardFiles(getDefaultProguardFile("proguard-android.txt"), "proguard-rules.pro")
        }
    }
}

flutter {
    source = "../.."
}
dependencies {

    implementation("com.google.firebase:firebase-messaging:23.2.1")
    implementation("im.zego:zpns-fcm:2.8.0")
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
    
//     //Introduce Firebase BoM
// implementation platform('com.google.firebase:firebase-bom:31.0.2')

// // Add dependencies for Firebase SDK for Google Analytics and FCM.
// // When using BoM, do not specify the version in the Firebase dependency
// implementation 'com.google.firebase:firebase-analytics'
// implementation 'com.google.firebase:firebase-messaging:23.2.1'
// implementation 'im.zego:zpns-fcm:2.8.0' //ZPNs package for Google FCM push

}