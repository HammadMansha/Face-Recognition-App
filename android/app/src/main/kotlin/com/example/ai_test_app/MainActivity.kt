package com.example.ai_test_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import com.chaquo.python.Python
import com.chaquo.python.android.AndroidPlatform


class MainActivity: FlutterActivity() {

  private val CHANNEL = "runScript"



    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call: MethodCall, result: Result ->
                // Handle method calls from Flutter here
                if (call.method == "your_native_method") {
                    val message = yourNativeMethod()
                    result.success(message)
                } else {
                    result.notImplemented()
                }
            }
    }

    // Your custom native method
    private fun yourNativeMethod(): String {
        // Implement your native logic here
        if (! Python.isStarted()) {
            Python.start( AndroidPlatform(this));
        }


        val py=Python.getInstance();
        val module=py.getModule("script")


        //for getting the variable value from python
        val num=module["number"]?.toInt()
        println("The value of number is $num")

        //for getting the variable value from python
        val text=module["text"]?.toString()
        println("The value of text is $text")

        //for calling the function value from python
        val fact=module["factorial"]
        val temp= fact?.call(5)
        println("The value of fact is $temp")


        return "hello";
    }





}
