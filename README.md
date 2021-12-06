# app_xiaomanyao2.0

手持机2.0

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
### 小蛮腰手持机按钮 扫描电子车牌

+ 1.扫描电子车牌工作流 配置flutter与android通信   MainActivity/AdroidManifest.xml
+ 2.android端MainActivity.java注册EventChannel: 案列`https://www.jianshu.com/p/b23174d06cf3`
+ 3.本能设备读到cid, 代码如下
```java
    /**
     * 本能读取到cid
     * @param event
     */
    @Subscribe(threadMode = ThreadMode.MAIN, sticky = false, priority = 0)
    public void onBNReadDataEvent(BNReadDataEvent event) {
        Map<String,String>eventMap = new HashMap<>();
        eventMap.put("event","bn_cid");
        eventMap.put("cid",event.cid);
        eventSink.success(eventMap);// 发送消息
    }
```
+ 4.flutter端接收信息
```dart
    eventChannel.receiveBroadcastStream().listen
```
  
