package com.example.ai_test_app

import com.chaquo.python.Python
import com.chaquo.python.android.AndroidPlatform
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result as FlutterResult
import android.os.Bundle
import com.chaquo.python.PyObject



class MainActivity : FlutterActivity() {

    private val CHANNEL = "runScript"
    private lateinit var pythonModule: PyObject

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Load Python module when the screen starts
       loadPythonModule()
    }



    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call: MethodCall, result: FlutterResult ->
                // Handle method calls from Flutter here
                if (call.method == "your_native_method") {
                    val message = yourNativeMethod(call.arguments as Map<String, Any>, result)
                    result.success(message)
                }  else if (call.method == "cameraCall") {
                val message = cameraCall(call.arguments as String, result)
                result.success(message)
            }

            else {
                    result.notImplemented()
                }
            }
    }





    // Function to manually convert the map to a string representation
    private fun convertMapToString(inputMap: Map<String, Any>): String {
        val formattedList = inputMap.entries.map { "'${it.key}': ${formatValue(it.value)}" }
        return "{${formattedList.joinToString(", ")}}"
    }

    // Function to format values in the string representation
    private fun formatValue(value: Any): String {
        return when (value) {
            is String -> "'$value'"
            is List<*> -> formatList(value)
            // Add more cases as needed for other types
            else -> value.toString()
        }
    }

    // Function to format lists in the string representation
    private fun formatList(list: List<*>): String {
        val formattedList = list.map { formatValue(it!!) }
        return "[${formattedList.joinToString(", ")}]"
    }

    // Your custom native method
    private fun yourNativeMethod(arguments: Map<String, Any>, result: FlutterResult): String {
        println("arguments are===========$arguments");
        val formattedArguments = convertMapToString(arguments)

        println("converted arguments are===========$formattedArguments");




        // Implement your native logic here
        if (!Python.isStarted()) {
            Python.start(AndroidPlatform(this))
        }

        val py = Python.getInstance()
        val module = py.getModule("train_v2")

//        val temp=module["update_train"]
//        val temp2=temp?.call(arguments);

        val obj = module.callAttr("update_train", formattedArguments)





        //val obj: PyObject = pyo.callAttr("update_train", arguments)

        return "Hello";
    }


//Load python
private fun loadPythonModule() {
    if (!Python.isStarted()) {
        Python.start(AndroidPlatform(this))
    }

    val pythonCall = Python.getInstance()
    pythonModule = pythonCall.getModule("main")

    // You can now use 'module1' throughout the activity
}


    //call for camera module
    private fun cameraCall(arguments: String, result: FlutterResult): String? {
        // Implement your native logic here

//

        val obj = pythonModule.callAttr("search_faces", arguments)


        val dataType = obj.javaClass.simpleName

// Print the data type
        println("Data type of obj: $dataType")


        println("Receiving from camera=================${obj}")


        val stringValue: String? = obj?.toString()

        // Print the String value
//        println("String value of obj: $stringValue")

        return stringValue



//        val temp=module["update_train"]
//        val temp2=temp?.call(arguments);

        //val obj = module.callAttr("update_train", formattedArguments)





        //val obj: PyObject = pyo.callAttr("update_train", arguments)

    }



}
