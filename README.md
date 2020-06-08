# [ECPrivacyCheckTools](https://github.com/EchoZuo/ECAuthorizationTools)

### ECPrivacyCheckTools 2.0.0  版本 20200608

## 更新 & bug fix

1. ECPrivacyCheckTools 2.0.0版本
   - 去掉对 iOS 7.0 版本支持
   - 针对 iOS 13.0 新 API 优化
   - 隐私权限模块独立文件，可以单独引入使用，无需引入全部工具类
   - 常见常用隐私权限检测集合类，可以直接导入项目中使用。包含：定位服务、照片、相机、通讯录
   - 其他bug fix

2. 20171211 bug修复：iOS11获取相册权限需要在plist中增加NSPhotoLibraryAddUsageDescription字段

```
<key>NSPhotoLibraryAddUsageDescription</key>
<string>需要获取您的相册信息</string>
```

3. 20170731 bug修复：iOS7获取相册权限不弹框

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



## Abstract 概要

###### 该工具类主要是为了方便大家获取设备系统权限和检查对应的权限。目前2.0版本兼容 iOS 8.0 及其以上版本。具体每一项隐私权限的获取和检测在源码中有非常详细的逻辑代码，使用方式在 ECPrivacyCheckTools_Example 工程中亦有相似介绍。如果有什么不清楚的可以在git上issues我或者微信联系我。

## Features & Requirements 特性 & 要求

- 支持 iOS 8.0 +
- ARC
- 最新版本：2.0.0

#### 目前支持的隐私类型（顺序参照：iPhone - 设置 - 隐私）：

```
LocationServices       定位服务
Contacts               通讯录
Calendars              日历
Reminders              提醒事项
Photos                 照片
Bluetooth              蓝牙
Microphone             麦克风
SpeechRecognition      语音识别 >= iOS 10.0
Camera                 相机
Health                 健康 >= iOS 8.0
HomeKit                HomeKit >= iOS 8.0
MediaAndAppleMusic     媒体与Apple Music >= iOS9.3
FilesAndFolders        文件和文件夹
MotionAndFitness       运动与健身
```

###### 参照下图

![01.PNG](https://upload-images.jianshu.io/upload_images/1424124-4c1ce31cf8cafe15.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



##### plist文件下添加对应的参数

```
<key>NSAppleMusicUsageDescription</key>
	<string>Add tracks to your music library.</string>
	<key>NSBluetoothPeripheralUsageDescription</key>
	<string>若不允许，你将无法使用联机服务</string>
	<key>NSBluetoothAlwaysUsageDescription</key>
	<string>若不允许，你将无法使用联机服务</string>
	<key>NSCalendarsUsageDescription</key>
	<string>若不允许，你将无法使用添加日历功能</string>
	<key>NSCameraUsageDescription</key>
	<string>若不允许，你将无法使用图片上传和识别功能</string>
	<key>NSContactsUsageDescription</key>
	<string>通讯录信息仅用于查找联系人，并会得到严格保密</string>
	<key>NSHealthShareUsageDescription</key>
	<string>若不允许，你将无法参与运动排行榜活动</string>
	<key>NSHealthUpdateUsageDescription</key>
	<string>若不允许，你将无法参与运动排行榜活动</string>
	<key>NSHomeKitUsageDescription</key>
	<string>若不允许，你将无法使用智能家居服务</string>
	<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
	<string>我们需要获取你的定位权限以供完成查找附近商户功能</string>
	<key>NSLocationWhenInUseUsageDescription</key>
	<string>我们需要获取你的定位权限以供完成查找附近商户功能</string>
	<key>NSMicrophoneUsageDescription</key>
	<string>我们需要获取你的麦克风权限以供完成语音搜索功能</string>
	<key>NSMotionUsageDescription</key>
	<string>我们需要获取你的运动权限以完成运动挑战赛功能</string>
	<key>NSPhotoLibraryAddUsageDescription</key>
	<string>我们需要获取你的相册权限以完成图片上传和识别功能</string>
	<key>NSPhotoLibraryUsageDescription</key>
	<string>我们需要获取你的相册权限以完成图片上传和识别功能</string>
	<key>NSRemindersUsageDescription</key>
	<string>我们需要获取你的提醒事项权限以供添加提醒事项</string>
	<key>NSSiriUsageDescription</key>
	<string>我们需要获取你的Siri权限以方便完成Siri建议功能</string>
	<key>NSSpeechRecognitionUsageDescription</key>
	<string>我们需要获取你的语音识别功能已完成键盘语音识别输入功能</string>
	<key>NSVideoSubscriberAccountUsageDescription</key>
	<string>我们需要获取你的TV权限</string>
```



## Content 正文

#### Uage 使用

- 使用 ECPrivacyCheckGatherTool 集合：包含：定位服务、照片、相机、通讯录
  - 将 ECPrivacyCheckTools 文件夹下 ECPrivacyCheckGatherTool.h 和 ECPrivacyCheckGatherTool.m 文件引入工程
  - 调用对应 API
- 单独使用任一权限检测
  - 将 ECPrivacyCheckTools/Core 文件下对应权限的 .h 和 .m 文件引入工程
  - 调用对应API

#### Code Example

```
// MARK: - 定位服务 LocationServices
/** 定位授权状态
 *

 *  ECLBSAuthorizationStatusUnable：不支持或不可用
 *  ECLBSAuthorizationStatusNotDetermined：用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
 *  ECLBSAuthorizationStatusRestricted：应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
 *  ECLBSAuthorizationStatusDenied：用户拒绝
 *  ECLBSAuthorizationStatusAuthorizedAlways：一直允许获取定位
 *  ECLBSAuthorizationStatusAuthorizedWhenInUse：在使用时允许定位
 *  ECLBSAuthorizationStatusAuthorized：已废弃，在iOS2.0~8.0使用，> iOS 8.0 请使用 ECLBSAuthorizationStatusAuthorizedAlways： 一直允许获取定位
    */
    typedef NS_ENUM(NSInteger, ECLBSAuthorizationStatus) {
     ECLBSAuthorizationStatusUnable = -1,
     ECLBSAuthorizationStatusNotDetermined = 0,
     ECLBSAuthorizationStatusRestricted,
     ECLBSAuthorizationStatusDenied,
     ECLBSAuthorizationStatusAuthorizedAlways,
     ECLBSAuthorizationStatusAuthorizedWhenInUse,
     ECLBSAuthorizationStatusAuthorized API_DEPRECATED("Use ECLBSAuthorizationStatusAuthorizedAlways", ios(2.0, 8.0)) = ECLBSAuthorizationStatusAuthorizedAlways
    };

/// 检查定位权限状态：仅检查权限，不主动请求权限

+ (ECLBSAuthorizationStatus)locationAuthorizationStatus;

/// 检查定位权限状态：仅检查权限，不主动请求权限

- (ECLBSAuthorizationStatus)locationAuthorizationStatus;

/// 请求定位权限
/// @param completionHandler completionHandler

- (void)requestLocationAuthorizationWithCompletionHandler:(void(^)(ECLBSAuthorizationStatus status))completionHandler;

// MARK: - 照片 Photos
/** 授权状态

 *  ECAuthorizationStatusUnable：不支持或不可用
 *  ECAuthorizationStatusNotDetermined：用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
 *  ECAuthorizationStatusRestricted：应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
 *  ECAuthorizationStatusDenied：用户拒绝
 *  ECAuthorizationStatusAuthorized：已授权
    */
    typedef NS_ENUM(NSInteger, ECAuthorizationStatus) {
    ECAuthorizationStatusUnable = -1,
    ECAuthorizationStatusNotDetermined = 0,
    ECAuthorizationStatusRestricted,
    ECAuthorizationStatusDenied,
    ECAuthorizationStatusAuthorized
    };

/// 检查相册权限状态：仅检查权限，不主动请求权限

+ (ECAuthorizationStatus)photosAuthorizationStatus;

/// 检查相册权限状态：仅检查权限，不主动请求权限

- (ECAuthorizationStatus)photosAuthorizationStatus;

/// 请求相册权限
/// @param completionHandler completionHandler

+ (void)requestPhotosAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;

// MARK: - Bluetooth 蓝牙
/** 蓝牙权限状态
 *

 * ECCBAuthorizationStateUnknown：未知状态

 * ECCBAuthorizationStateResetting：正在重置，与系统服务暂时丢失

 * ECCBAuthorizationStateUnsupported：不支持蓝牙

 * ECCBAuthorizationStateUnauthorized：未授权

 * ECCBAuthorizationStatePoweredOff：关闭

 * ECCBAuthorizationStatePoweredOn：开启并可用
   */
   typedef NS_ENUM(NSInteger, ECCBAuthorizationState) {

   ECCBAuthorizationStateUnknown = 0,
   ECCBAuthorizationStateResetting,
   ECCBAuthorizationStateUnsupported,
   ECCBAuthorizationStateUnauthorized,
   ECCBAuthorizationStatePoweredOff,
   ECCBAuthorizationStatePoweredOn
   };

/// 获取蓝牙权限
/// @param completionHandler completionHandler

- (void)requestBluetoothAuthorizationWithCompletionHandler:(void(^)(ECCBAuthorizationState state))completionHandler;

// MARK: - 通讯录 Contacts
/** 授权状态

 *  ECAuthorizationStatusUnable：不支持或不可用
 *  ECAuthorizationStatusNotDetermined：用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
 *  ECAuthorizationStatusRestricted：应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
 *  ECAuthorizationStatusDenied：用户拒绝
 *  ECAuthorizationStatusAuthorized：已授权
    */
    typedef NS_ENUM(NSInteger, ECAuthorizationStatus) {
    ECAuthorizationStatusUnable = -1,
    ECAuthorizationStatusNotDetermined = 0,
    ECAuthorizationStatusRestricted,
    ECAuthorizationStatusDenied,
    ECAuthorizationStatusAuthorized
    };

/// 检查通讯录权限状态：仅检查权限，不主动请求权限

+ (ECAuthorizationStatus)contactsAuthorizationStatus;

/// 检查通讯录权限状态：仅检查权限，不主动请求权限

- (ECAuthorizationStatus)contactsAuthorizationStatus;

/// 请求通讯录权限
/// @param completionHandler completionHandler

+ (void)requestContactsAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;

/// 请求通讯录权限
/// @param completionHandler completionHandler

- (void)requestContactsAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;
```

##### 获取定位权限

```
- (void)checkLBS:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        ECLBSAuthorizationStatus status = [ECPrivacyCheckGatherTool locationAuthorizationStatus];
        ECAlertShow(@"定位权限状态：", [NSString stringWithFormat:@"%ld", (long)status], @"确定", ^{
        });
    } else {
        self.gatherTools = [[ECPrivacyCheckGatherTool alloc] init];
        [self.gatherTools requestLocationAuthorizationWithCompletionHandler:^(ECLBSAuthorizationStatus status) {
            if (status == ECLBSAuthorizationStatusAuthorizedAlways) {
                [ECAlert showConfirmAlertWithMessage:@"已获取持续定位权限" completion:nil];
            } else if (status == ECLBSAuthorizationStatusAuthorizedWhenInUse) {
                [ECAlert showConfirmAlertWithMessage:@"已获取使用APP期间定位权限" completion:nil];
            } else if ((status == ECLBSAuthorizationStatusRestricted) || (status == ECLBSAuthorizationStatusDenied)) {
                [ECAlert showConfirmAlertWithMessage:@"用户禁用该APP使用定位权限" completion:nil];
            } else {
                NSLog(@"ECLBSAuthorizationStatusNotDetermined,用户未决定");
            }
        }];
    }
}
```

##### 照片权限

```
/// 请求相册权限
/// @param completionHandler completionHandler
- (void)requestPhotosAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler;

- (void)checkPhotos:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        ECAuthorizationStatus status = [ECPrivacyCheckGatherTool photosAuthorizationStatus];
        ECAlertShow(@"照片权限状态：", [NSString stringWithFormat:@"%ld", (long)status], @"确定", ^{
        });
    } else {
        [ECPrivacyCheckGatherTool requestPhotosAuthorizationWithCompletionHandler:^(BOOL granted) {
            if (granted) {
                [ECAlert showConfirmAlertWithMessage:@"已获取照片权限" completion:nil];
            } else {
                [ECAlert showConfirmAlertWithMessage:@"用户禁用该APP使用照片权限" completion:nil];
            }
        }];
    }
}
```

##### 通讯录权限

```
- (void)checkContact:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        ECAuthorizationStatus status = [ECPrivacyCheckGatherTool contactsAuthorizationStatus];
        ECAlertShow(@"通讯录权限状态：", [NSString stringWithFormat:@"%ld", (long)status], @"确定", ^{
        });
    } else {
        [ECPrivacyCheckGatherTool requestContactsAuthorizationWithCompletionHandler:^(BOOL granted) {
            if (granted) {
                [ECAlert showConfirmAlertWithMessage:@"已获取通讯录权限" completion:nil];
            } else {
                [ECAlert showConfirmAlertWithMessage:@"用户禁用该APP使用通讯录权限" completion:nil];
            }
        }];
    }
}
```

##### 蓝牙权限

```
- (void)checkBluetooth:(NSInteger)buttonIndex {
    // 这里要用全局属性
    self.bluetoohTools = [[ECPrivacyCheckBluetooth alloc] init];
    
    [self.bluetoohTools requestBluetoothAuthorizationWithCompletionHandler:^(ECCBAuthorizationState state) {
        if (state == ECCBAuthorizationStatePoweredOn) {
            ECAlertShow(@"蓝牙状态", @"开启并可用", @"确定", nil);
        } else if (state == ECCBAuthorizationStatePoweredOff) {
            ECAlertShow(@"蓝牙状态", @"关闭", @"确定", nil);
        } else if (state == ECCBAuthorizationStateUnauthorized) {
            ECAlertShow(@"蓝牙状态", @"未授权", @"确定", nil);
        } else if (state == ECCBAuthorizationStateUnsupported) {
            ECAlertShow(@"蓝牙状态", @"不支持蓝牙", @"确定", nil);
        } else if (state == ECCBAuthorizationStateResetting) {
            ECAlertShow(@"蓝牙状态", @"正在重置，与系统服务暂时丢失", @"确定", nil);
        } else {
            // ECCBAuthorizationStateUnknown
            ECAlertShow(@"蓝牙状态", @"未知状态", @"确定", nil);
        }
    }];
}
```

###### 代码中均有非常详细的中文注释，可以直接查看

##### 再附一张Demo截图
![02.PNG](https://upload-images.jianshu.io/upload_images/1424124-cad65ce16e04984d.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



######工具类和Demo中已经给出了非常完整的获取权限和检测权限逻辑代码，除了可以直接导入工具类使用外，也可以直接Copy逻辑代码到自己的项目中使用。 

## Author

- EchoZuo, zuoqianheng@foxmail.com
- WeChat：melody_echo || QQ：615125175 || Telegram：@echozuo
- 简书：@EchoZuo  http://www.jianshu.com/u/3390ce71084e
- 头条号：@猫头鹰左先森

## License

ECPrivacyCheckTools is available under the MIT license. See the LICENSE file for more info.
