//
//  ECAuthorizationTools.h
//  ECAuthorizationTools
//
//  Created by EchoZuo on 2017/6/20.
//  Copyright © 2017年 Echo.Z. All rights reserved.
//

/*
 Abstract：Checking and Requesting Access to Data Classes in Privacy Settings.
 Abstract：检查和请求访问隐私设置数据。
 */


@import Foundation;
@import UIKit;
@import AssetsLibrary;
@import Photos;
@import AddressBook;
@import Contacts;
@import AVFoundation;
@import CoreBluetooth;
@import CoreLocation;
@import EventKit;
@import Speech;
@import HealthKit;
@import HomeKit;
@import StoreKit;
@import CoreMotion;


#import "Define.h"


/*
 Enumerate
 */
// Privacy classify 分类
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

// ECAuthorizationStatus 权限状态，参考PHAuthorizationStatus等
typedef NS_ENUM(NSUInteger, ECAuthorizationStatus){
    ECAuthorizationStatus_NotDetermined  = 0, // 用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
    ECAuthorizationStatus_Authorized     = 1, // 已授权
    ECAuthorizationStatus_Denied         = 2, // 拒绝
    ECAuthorizationStatus_Restricted     = 3, // 应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
    ECAuthorizationStatus_NotSupport     = 4, // 硬件等不支持
};

// ECLocationAuthorizationStatus 定位权限状态，参考CLAuthorizationStatus
typedef NS_ENUM(NSUInteger, ECLocationAuthorizationStatus){
    ECLocationAuthorizationStatus_NotDetermined         = 0, // 用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
    ECLocationAuthorizationStatus_Authorized            = 1, // 一直允许获取定位 ps：< iOS8用
    ECLocationAuthorizationStatus_Denied                = 2, // 拒绝
    ECLocationAuthorizationStatus_Restricted            = 3, // 应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
    ECLocationAuthorizationStatus_NotSupport            = 4, // 硬件等不支持
    ECLocationAuthorizationStatus_AuthorizedAlways      = 5, // 一直允许获取定位
    ECLocationAuthorizationStatus_AuthorizedWhenInUse   = 6, // 在使用时允许获取定位
};

// ECCBManagerState 蓝牙状态，参考 CBManagerState
typedef NS_ENUM(NSUInteger, ECCBManagerStatus){
    ECCBManagerStatusUnknown         = 0,        // 未知状态
    ECCBManagerStatusResetting       = 1,        // 正在重置，与系统服务暂时丢失
    ECCBManagerStatusUnsupported     = 2,        // 不支持蓝牙
    ECCBManagerStatusUnauthorized    = 3,        // 未授权
    ECCBManagerStatusPoweredOff      = 4,        // 关闭
    ECCBManagerStatusPoweredOn       = 5,        // 开启并可用
};


/*
 定义权限状态回调block
 */
typedef void(^AccessForTypeResultBlock)(ECAuthorizationStatus status, ECPrivacyType type);
typedef void(^AccessForLocationResultBlock)(ECLocationAuthorizationStatus status);
typedef void(^AccessForBluetoothResultBlock)(ECCBManagerStatus status);
typedef void(^AccessForHomeResultBlock)(BOOL isHaveHomeAccess);
typedef void(^AccessForMotionResultBlock)(BOOL isHaveMotionAccess);




@interface ECAuthorizationTools : NSObject

@property (nonatomic, strong) CLLocationManager         *locationManager;       // 定位
@property (nonatomic, strong) CBCentralManager          *cMgr;                  // 蓝牙
@property (nonatomic, strong) HKHealthStore             *healthStore;           // 健康
@property (nonatomic, strong) HMHomeManager             *homeManager;           // home
@property (nonatomic, strong) CMMotionActivityManager   *cmManager;             // 运动
@property (nonatomic, strong) NSOperationQueue          *motionActivityQueue;   // 运动




#pragma mark -------------------- Public Methods --------------------
/*
 NS_ENUM -> NSString
 */
+ (NSString *)stringForPrivacyType:(ECPrivacyType)privacyType;
+ (NSString *)stringForAuthorizationStatus:(ECAuthorizationStatus)authorizationStatus;
+ (NSString *)stringForLocationAuthorizationStatus:(ECLocationAuthorizationStatus)locationAuthorizationStatus;
+ (NSString *)stringForCBManagerStatus:(ECCBManagerStatus)CBManagerStatus;


#pragma mark -------------------- Main Enter Method --------------------
/**
 Check and request access for * type 
 检查和请求对应类型的权限

 @param type ECPrivacyType
 @param accessStatusCallBack AccessForTypeResultBlock
 */
+ (void)checkAndRequestAccessForType:(ECPrivacyType)type accessStatus:(AccessForTypeResultBlock)accessStatusCallBack;

/**
 Check and request access for LocationServices
 检查和请求定位服务的权限
 
 @param accessStatusCallBack accessStatus
 */
- (void)checkAndRequestAccessForLocationServicesWithAccessStatus:(AccessForLocationResultBlock)accessStatusCallBack;

/**
 Check and request access for BluetoothSharing
 检查和请求蓝牙共享服务的权限

 @param accessStatusCallBack accessStatus
 */
- (void)checkAndRequestAccessForBluetoothSharingWithAccessStatus:(AccessForBluetoothResultBlock)accessStatusCallBack;

/**
 Check and request access for Health
 检查和请求健康的权限
 
 @param accessStatusCallBack accessStatus
 */
- (void)checkAndRequestAccessForHealthWtihAccessStatus:(AccessForTypeResultBlock)accessStatusCallBack;

/**
 Check And Request Access For Home
  Tip：访问家庭权限是需要回调指定的的HMHomeManagerDelegate协议，并且回调之后的后续逻辑处理比较麻烦，建议使用者可以直接调用系统的获取权限方法。在回调协议中做处理。这里做出简单Demo以方便参考。注意：HMError.h类

 @param accessForHomeCallBack AccessForHomeResultBlock
 */
- (void)checkAndRequestAccessForHome:(AccessForHomeResultBlock)accessForHomeCallBack;

/**
 Check And Request Access For Motion And Fitness
 同访问Home一样，运动与健身这里也只给出简单demo方便参考，可以直接copy代码到自己的项目中直接用

 */
- (void)checkAndRequestAccessForMotionAndFitness;

@end














