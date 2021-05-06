package es.uned.siteica_user

import com.umair.beacons_plugin.BeaconsPlugin
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onPause() {
        super.onPause()

        //Habilitar proceso en segundo plano para escanear BLE
        BeaconsPlugin.startBackgroundService(this)
    }

    override fun onResume() {
        super.onResume()

        //Finalizar proceso en segundo plano para escanear BLE
        BeaconsPlugin.stopBackgroundService(this)
    }
}
