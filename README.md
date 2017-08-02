## [ECAuthorizationTools](https://github.com/EchoZuo/ECAuthorizationTools)

---
#### 更新 & bug fix
##### 20170731 bug修复：iOS7获取相册权限不弹框

```
// 当某些情况下，ALAuthorizationStatus 为 ALAuthorizationStatusNotDetermined的时候，
// 无法弹出系统首次使用的收取alertView，系统设置中也没有相册的设置，此时将无法使用，
// 所以做以下操作，弹出系统首次使用的授权alertView
__block BOOL isShow = YES;
ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
[assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
    if (isShow) {
        [self executeCallBack:accessStatusCallBack accessStatus:ECAuthorizationStatus_Authorized type:ECPrivacyType_Photos];
        isShow = NO;
    }
} failureBlock:^(NSError *error) {
    [self executeCallBack:accessStatusCallBack accessStatus:ECAuthorizationStatus_Denied type:ECPrivacyType_Photos];
}];
```
---


## Abstract 概要
##### 该工具类主要是为了方便大家获取设备权限和检查对应的权限，目前支持iOS7 - iOS10所有设置中的隐私权限获取和检测。具体每一个隐私的权限获取和检测都在工具类ECAuthorizationTools.h中有详细的逻辑思路。DemoViewController.m中也有详细的使用工具类方式。如果有什么不清楚的可以在git上issues我或者Email或者QQ联系我。
### Features & Requirements 特性 & 要求
- 支持iOS7+
- ARC 
##### 目前支持的隐私类型（顺序参照：iphone设置-隐私）：

```
typedef NS_ENUM(NSUInteger, ECPrivacyType){
    ECPrivacyType_None                  = 0,
    ECPrivacyType_LocationServices      = 1,    // 定位服务
    ECPrivacyType_Contacts              = 2,    // 通讯录
    ECPrivacyType_Calendars             = 3,    // 日历
    ECPrivacyType_Reminders             = 4,    // 提醒事项
    ECPrivacyType_Photos                = 5,    // 照片
    ECPrivacyType_BluetoothSharing      = 6,    // 蓝牙共享
    ECPrivacyType_Microphone            = 7,    // 麦克风
    ECPrivacyType_SpeechRecognition     = 8,    // 语音识别 >= iOS10
    ECPrivacyType_Camera                = 9,    // 相机
    ECPrivacyType_Health                = 10,   // 健康 >= iOS8.0
    ECPrivacyType_HomeKit               = 11,   // 家庭 >= iOS8.0
    ECPrivacyType_MediaAndAppleMusic    = 12,   // 媒体与Apple Music >= iOS9.3
    ECPrivacyType_MotionAndFitness      = 13,   // 运动与健身
};
```

###### 参照下图:
![image](https://raw.githubusercontent.com/EchoZuo/ECAuthorizationTools/master/ShowImages/0.PNG)


###### Tips：在iOS10下记得在plist文件下添加对应的参数。
```
<key>NSBluetoothPeripheralUsageDescription</key>
<string>需要获取蓝牙权限</string>
<key>NSCalendarsUsageDescription</key>
<string>日历</string>
<key>NSCameraUsageDescription</key>
<string>需要获取您的摄像头信息</string>
<key>NSContactsUsageDescription</key>
<string>需要获取您的通讯录权限</string>
<key>NSHealthShareUsageDescription</key>
<string>健康分享权限</string>
<key>NSHealthUpdateUsageDescription</key>
<string>健康数据更新权限</string>
<key>NSHomeKitUsageDescription</key>
<string>HomeKit权限</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>一直定位权限</string>
<key>NSLocationUsageDescription</key>
<string>定位权限</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>使用app期间定位权限</string>
<key>NSMicrophoneUsageDescription</key>
<string>需要获取您的麦克风权限</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>需要获取您的相册信息</string>
<key>NSRemindersUsageDescription</key>
<string>提醒事项</string>
<key>NSSiriUsageDescription</key>
<string>需要获取您的Siri权限</string>
<key>NSSpeechRecognitionUsageDescription</key>
<string>语音识别权限</string>
<key>NSVideoSubscriberAccountUsageDescription</key>
<string>AppleTV权限</string>
<key>NSAppleMusicUsageDescription</key>
<string>Add tracks to your music library.</string>
<key>NSMotionUsageDescription</key>
<string>运动与健身权限</string>

```


---

## Content 正文
### Installation 安装
- 将ECAuthorizationTools文件夹直接拖入项目中，导入头文件#import "ECAuthorizationTools.h"
- CocoaPods：pod 'ECAuthorizationTools'

```
#import "ECAuthorizationTools.h"
```
### Explain 说明
###### ps：该工具类中注释也比较完整，并且有完整的使用Dmeo。这里就简单解释说明一下代码以及一些容易踩的坑。
##### ECAuthorizationStatus 权限状态，参考PHAuthorizationStatus等。

```
typedef NS_ENUM(NSUInteger, ECAuthorizationStatus){
    ECAuthorizationStatus_NotDetermined  = 0, // 用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
    ECAuthorizationStatus_Authorized     = 1, // 已授权
    ECAuthorizationStatus_Denied         = 2, // 拒绝
    ECAuthorizationStatus_Restricted     = 3, // 应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
    ECAuthorizationStatus_NotSupport     = 4, // 硬件等不支持
};
```
##### ECLocationAuthorizationStatus 定位权限状态，参考CLAuthorizationStatus

```
typedef NS_ENUM(NSUInteger, ECLocationAuthorizationStatus){
    ECLocationAuthorizationStatus_NotDetermined         = 0, // 用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
    ECLocationAuthorizationStatus_Authorized            = 1, // 一直允许获取定位 ps：< iOS8用
    ECLocationAuthorizationStatus_Denied                = 2, // 拒绝
    ECLocationAuthorizationStatus_Restricted            = 3, // 应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
    ECLocationAuthorizationStatus_NotSupport            = 4, // 硬件等不支持
    ECLocationAuthorizationStatus_AuthorizedAlways      = 5, // 一直允许获取定位
    ECLocationAuthorizationStatus_AuthorizedWhenInUse   = 6, // 在使用时允许获取定位
};
```

##### ECCBManagerState 蓝牙状态，参考 CBManagerState

```
typedef NS_ENUM(NSUInteger, ECCBManagerStatus){
    ECCBManagerStatusUnknown         = 0,        // 未知状态
    ECCBManagerStatusResetting       = 1,        // 正在重置，与系统服务暂时丢失
    ECCBManagerStatusUnsupported     = 2,        // 不支持蓝牙
    ECCBManagerStatusUnauthorized    = 3,        // 未授权
    ECCBManagerStatusPoweredOff      = 4,        // 关闭
    ECCBManagerStatusPoweredOn       = 5,        // 开启并可用
};
```
### Usage 使用方式
#### Main Enter Method 主要的一些入口方法
###### ps：下述方法都有中文注释，就不再做过多解释，如果有疑问的可以参考Dmeo。

###### 检查和请求对应类型的权限
```
/**
 Check and request access for * type 
 检查和请求对应类型的权限

 @param type ECPrivacyType
 @param accessStatusCallBack AccessForTypeResultBlock
 */
+ (void)checkAndRequestAccessForType:(ECPrivacyType)type accessStatus:(AccessForTypeResultBlock)accessStatusCallBack;
```
###### 检查和请求定位服务的权限
```
/**
 Check and request access for LocationServices
 检查和请求定位服务的权限
 
 @param accessStatusCallBack accessStatus
 */
- (void)checkAndRequestAccessForLocationServicesWithAccessStatus:(AccessForLocationResultBlock)accessStatusCallBack;
```
###### 检查和请求蓝牙共享服务的权限
```
/**
 Check and request access for BluetoothSharing
 检查和请求蓝牙共享服务的权限

 @param accessStatusCallBack accessStatus
 */
- (void)checkAndRequestAccessForBluetoothSharingWithAccessStatus:(AccessForBluetoothResultBlock)accessStatusCallBack;
```
###### 检查和请求健康的权限
```
/**
 Check and request access for Health
 检查和请求健康的权限
 
 @param accessStatusCallBack accessStatus
 */
- (void)checkAndRequestAccessForHealthWtihAccessStatus:(AccessForTypeResultBlock)accessStatusCallBack;
```
###### 访问家庭权限是需要回调指定的的HMHomeManagerDelegate协议，并且回调之后的后续逻辑处理比较麻烦，建议使用者可以直接调用系统的获取权限方法。在回调协议中做处理。这里做出简单Demo以方便参考。注意：HMError.h类
```
/**
 Check And Request Access For Home
  Tip：访问家庭权限是需要回调指定的的HMHomeManagerDelegate协议，并且回调之后的后续逻辑处理比较麻烦，建议使用者可以直接调用系统的获取权限方法。在回调协议中做处理。这里做出简单Demo以方便参考。注意：HMError.h类

 @param accessForHomeCallBack AccessForHomeResultBlock
 */
- (void)checkAndRequestAccessForHome:(AccessForHomeResultBlock)accessForHomeCallBack;
```
###### 同访问Home一样，运动与健身这里也只给出简单demo方便参考，可以直接copy代码到自己的项目中直接用
```
/**
 Check And Request Access For Motion And Fitness
 同访问Home一样，运动与健身这里也只给出简单demo方便参考，可以直接copy代码到自己的项目中直接用

 */
- (void)checkAndRequestAccessForMotionAndFitness;
```

### Example 使用范例
###### 获取相册访问权限

```
[ECAuthorizationTools checkAndRequestAccessForType:ECPrivacyType_Photos accessStatus:^(ECAuthorizationStatus status, ECPrivacyType type) {
    // status 即为权限状态，状态类型参考：ECAuthorizationStatus
}];
```
###### 访问定位权限

```
ECAuthorizationTools *tools = [[ECAuthorizationTools alloc] init];
[tools checkAndRequestAccessForLocationServicesWithAccessStatus:^(ECLocationAuthorizationStatus status) {
    // status 类型参考 ECLocationAuthorizationStatus
}];
```
###### Tips:访问定位、蓝牙、健康、家庭、运动等权限的时候需要用对象方法去获取，其余可以采用类方法传入对应类型枚举即可获取。为什么呢？因为上述几种类型权限获取都需要响应对应的代理协议，并且需要在类中用到其对象，所以采用对象方法获取权限更便捷方便。可以参考Demo中的DemoViewController.m文件，里面有详细的使用方法可供参考。

###### 再附上一张Demo截图：
![image](https://raw.githubusercontent.com/EchoZuo/ECAuthorizationTools/master/ShowImages/1.PNG)

---

## More 更多
- 工具类和Demo中已经给出了非常完整的获取权限和检测权限逻辑代码，除了可以直接导入工具类使用外，也可以直接Copy逻辑代码到自己的项目中使用。
- 有什么使用方面的问题可以直接Issues我或者Email或者QQ都ok的。
- Email: zuoqianheng@foxmail.com || QQ:615125175
- 简书：@EchoZuo 或者 http://www.jianshu.com/u/3390ce71084e
