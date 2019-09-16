package com.zyh.flutter_app

import android.app.AlertDialog
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    val TAG = "MainActivity"
    lateinit var str : String
    lateinit var methodChannel1 : MethodChannel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        val methodChannel = MethodChannel(flutterView,"com.zyh.flutter_app.android")//需要跟flutter的MethodChannel的name一致
        methodChannel1 = MethodChannel(flutterView,"com.zyh.flutter_app.flutter")//android调flutter的channel
        methodChannel.setMethodCallHandler { methodCall, result ->
            if ("dialog" == methodCall.method) {
                if (methodCall.hasArgument("content")) {
                    showAlertDialog()
                    str = methodCall.argument<String>("content").toString()
                    result.success("我是卖报的小行家")
                } else {
                    result.error("error", "弹出失败", "content is null")
                }
            } else {
                result.notImplemented()
            }
        }

    }

    private fun showAlertDialog() {
        val builder = AlertDialog.Builder(this)
        builder.setTitle("Flutter调用Android")
        builder.setMessage("我是内容")
        builder.setPositiveButton("确定") { _, _ ->
            Toast.makeText(this@MainActivity,"接收到Flutter传的数据:$str",Toast.LENGTH_SHORT).show()
        }
        builder.show()
    }


    /**
     * Android调用Flutter
     */
    override fun onResume() {
        super.onResume()
        val map = mutableMapOf<String,String>()
        map["AContent"] = "在onResume()中Android调用Flutter改变Text"
        methodChannel1.invokeMethod("showText",map,object : MethodChannel.Result {
            override fun notImplemented() {
                Log.e(TAG,"notImplemented()")
            }

            override fun error(errorCode: String?, errorMsg: String?, errorDetail: Any?) {
                Log.e(TAG, "errorCode:$errorCode errorMsg:$errorMsg errorDetail:${errorDetail.toString()}")
            }

            override fun success(any: Any?) {
                Log.e(TAG,any.toString())
            }
        })
    }
}
