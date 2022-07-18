package com.zhilong.zhilong_lamp;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;


import android.app.Activity;
import android.content.Context;
import android.hardware.camera2.CameraAccessException;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CameraManager;
import android.os.Build;
import android.os.Handler;

import androidx.annotation.RequiresApi;

/**
 * ZhilongLampPlugin
 */
@RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
public class ZhilongLampPlugin implements FlutterPlugin, ActivityAware, MethodCallHandler {
  private Activity activity;
  private Context context;


  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
    context = activity.getApplicationContext();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    this.onDetachedFromActivity();
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    this.onAttachedToActivity(binding);
  }

  @Override
  public void onDetachedFromActivity() {
    activity = null;
  }


  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;


  private CameraManager mCameraManager;
  private Boolean torchState = false;


  @RequiresApi(api = Build.VERSION_CODES.M)
  public void initData() {

    //获取CameraManager
    if (mCameraManager == null) {
      mCameraManager = (CameraManager) context.getSystemService(Context.CAMERA_SERVICE);
      CameraManager.TorchCallback torchCallBack = new CameraManager.TorchCallback() {
        @Override
        public void onTorchModeChanged(String cameraId, boolean enabled) {
          super.onTorchModeChanged(cameraId, enabled);
          torchState=enabled;
        }

        @Override
        public void onTorchModeUnavailable(String cameraId) {
          super.onTorchModeUnavailable(cameraId);
        }
      };
      mCameraManager.registerTorchCallback(torchCallBack, new Handler());
    }
  }

  public void toggleLight(boolean OPEN) {
    try {
      //获取当前手机所有摄像头设备ID
      String[] ids = mCameraManager.getCameraIdList();
      for (String id : ids) {
        CameraCharacteristics c = mCameraManager.getCameraCharacteristics(id);
        //查询该摄像头组件是否包含闪光灯
        Boolean flashAvailable = c.get(CameraCharacteristics.FLASH_INFO_AVAILABLE);

        /*
         * 获取相机面对的方向
         * CameraCharacteristics.LENS_FACING_FRONT 前置摄像头
         * CameraCharacteristics.LENS_FACING_BACK 后只摄像头
         * CameraCharacteristics.LENS_FACING_EXTERNAL 外部的摄像头
         */
        Integer lensFacing = c.get(CameraCharacteristics.LENS_FACING);
        if (flashAvailable != null && flashAvailable
                && lensFacing != null && lensFacing == CameraCharacteristics.LENS_FACING_BACK) {
          //打开或关闭手电筒
          if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            mCameraManager.setTorchMode(id, OPEN);
          }
          break;
        }
      }
    } catch (CameraAccessException e) {
      e.printStackTrace();
    }
  }


  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "zhilong_lamp");
    channel.setMethodCallHandler(this);
  }

  @RequiresApi(api = Build.VERSION_CODES.M)
  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "init":
        initData();
        result.success(true);
        break;
      case "turnOn":
        toggleLight(true);
        result.success(true);
        break;
      case "turnOff":
        toggleLight(false);
        result.success(false);
        break;
      case "toggle":
        toggleLight(!torchState);
        result.success(!torchState);
        break;
    }

    System.out.println(call.method);
    System.out.println("5=====================7777");
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
