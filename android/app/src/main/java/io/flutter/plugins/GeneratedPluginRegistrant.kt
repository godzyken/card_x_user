package io.flutter.plugins

import androidx.annotation.Keep
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry
import io.agora.agora_rtc_engine.AgoraRtcEnginePlugin
//import com.difrancescogianmarco.arcore_flutter_plugin.ArcoreFlutterPlugin
import io.flutter.plugins.camera.CameraPlugin
import io.flutter.plugins.firebase.firestore.FlutterFirebaseFirestorePlugin
import dev.dint.cryptography_flutter.CryptographyFlutterPlugin
import com.mr.flutter.plugin.filepicker.FilePickerPlugin
import io.flutter.plugins.firebaseanalytics.FirebaseAnalyticsPlugin
import io.flutter.plugins.firebase.auth.FlutterFirebaseAuthPlugin
import io.flutter.plugins.firebase.core.FlutterFirebaseCorePlugin
import io.flutter.plugins.firebase.crashlytics.FlutterFirebaseCrashlyticsPlugin
import io.flutter.plugins.firebase.inappmessaging.FirebaseInAppMessagingPlugin
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin
import io.flutter.plugins.firebase.storage.FlutterFirebaseStoragePlugin
import com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin
import io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin
import io.flutter.plugins.googlemaps.GoogleMapsPlugin
import io.flutter.plugins.googlesignin.GoogleSignInPlugin
import io.flutter.plugins.imagepicker.ImagePickerPlugin
import io.flutter.plugins.pathprovider.PathProviderPlugin
import com.baseflow.permissionhandler.PermissionHandlerPlugin
import com.flutter_webview_plugin.FlutterWebviewPlugin
import io.flutter.plugins.share.SharePlugin
import io.flutter.plugins.urllauncher.UrlLauncherPlugin
import io.flutter.plugins.videoplayer.VideoPlayerPlugin
import io.flutter.plugins.webviewflutter.WebViewFlutterPlugin

/**
 * Generated file. Do not edit.
 * This file is generated by the Flutter tool based on the
 * plugins that support the Android platform.
 */
@Keep
object GeneratedPluginRegistrant {
    fun registerWith(flutterEngine: FlutterEngine) {
        val shimPluginRegistry = ShimPluginRegistry(flutterEngine)
        flutterEngine.plugins.add(AgoraRtcEnginePlugin())
//        flutterEngine.plugins.add(ArcoreFlutterPlugin())
        flutterEngine.plugins.add(CameraPlugin())
        flutterEngine.plugins.add(FlutterFirebaseFirestorePlugin())
        flutterEngine.plugins.add(CryptographyFlutterPlugin())
        flutterEngine.plugins.add(FilePickerPlugin())
        flutterEngine.plugins.add(FirebaseAnalyticsPlugin())
        flutterEngine.plugins.add(FlutterFirebaseAuthPlugin())
        flutterEngine.plugins.add(FlutterFirebaseCorePlugin())
        flutterEngine.plugins.add(FlutterFirebaseCrashlyticsPlugin())
        flutterEngine.plugins.add(FirebaseInAppMessagingPlugin())
        flutterEngine.plugins.add(FlutterFirebaseMessagingPlugin())
        flutterEngine.plugins.add(FlutterFirebaseStoragePlugin())
        flutterEngine.plugins.add(FlutterLocalNotificationsPlugin())
        flutterEngine.plugins.add(FlutterAndroidLifecyclePlugin())
        FlutterWebviewPlugin.registerWith(shimPluginRegistry.registrarFor("com.flutter_webview_plugin.FlutterWebviewPlugin"))
        flutterEngine.plugins.add(GoogleMapsPlugin())
        flutterEngine.plugins.add(GoogleSignInPlugin())
        flutterEngine.plugins.add(ImagePickerPlugin())
        flutterEngine.plugins.add(PathProviderPlugin())
        flutterEngine.plugins.add(PermissionHandlerPlugin())
        flutterEngine.plugins.add(SharePlugin())
        flutterEngine.plugins.add(UrlLauncherPlugin())
        flutterEngine.plugins.add(VideoPlayerPlugin())
        flutterEngine.plugins.add(WebViewFlutterPlugin())
    }
}