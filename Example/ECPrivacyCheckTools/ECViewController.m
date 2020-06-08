//
//  ECViewController.m
//  ECPrivacyCheckTools
//
//  Created by EchoZuo on 05/22/2020.
//  Copyright (c) 2020 EchoZuo. All rights reserved.
//

#import "ECViewController.h"
#import "ECAlert.h"

#import <ECPrivacyCheckTools/ECPrivacyCheckGatherTool.h>

#import <ECPrivacyCheckTools/ECPrivacyCheckLocationServices.h>
#import <ECPrivacyCheckTools/ECPrivacyCheckContacts.h>
#import <ECPrivacyCheckTools/ECPrivacyCheckCalendars.h>
#import <ECPrivacyCheckTools/ECPrivacyCheckReminders.h>
#import <ECPrivacyCheckTools/ECPrivacyCheckPhotos.h>
#import <ECPrivacyCheckTools/ECPrivacyCheckBluetooth.h>
#import <ECPrivacyCheckTools/ECPrivacyCheckMicrophone.h>
#import <ECPrivacyCheckTools/ECPrivacyCheckSpeechRecognition.h>
#import <ECPrivacyCheckTools/ECPrivacyCheckCamera.h>
#import <ECPrivacyCheckTools/ECPrivacyCheckHealth.h>
#import <ECPrivacyCheckTools/ECPrivacyCheckHomeKit.h>
#import <ECPrivacyCheckTools/ECPrivacyCheckMediaAndAppleMusic.h>
#import <ECPrivacyCheckTools/ECPrivacyCheckFilesAndFolders.h>
#import <ECPrivacyCheckTools/ECPrivacyCheckMotionAndFitness.h>


/**
*  ECPrivacyCheckGatherTool             常用隐私权限检测集合工具，包含：定位、照片、相机、通讯录
*
*  ECPrivacyCheckLocationServices       定位
*  ECPrivacyCheckContacts               通讯录
*  ECPrivacyCheckCalendars              日历
*  ECPrivacyCheckReminders              提醒事项
*  ECPrivacyCheckPhotos                 照片
*  ECPrivacyCheckBluetooth              蓝牙
*  ECPrivacyCheckMicrophone             麦克风
*  ECPrivacyCheckSpeechRecognition      语音识别 >= iOS 10.0
*  ECPrivacyCheckCamera                 相机
*  ECPrivacyCheckHealth                 健康 >= iOS 8.0
*  ECPrivacyCheckHomeKit                HomeKit >= iOS 8.0
*  ECPrivacyCheckMediaAndAppleMusic     媒体与Apple Music >= iOS9.3
*  ECPrivacyCheckFilesAndFolders        文件和文件夹
*  ECPrivacyCheckMotionAndFitness       运动与健身
*
*/


@interface ECViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSoureArray;

@property (nonatomic, strong) ECPrivacyCheckGatherTool *gatherTools;  // 隐私集合
@property (nonatomic, strong) ECPrivacyCheckBluetooth *bluetoohTools;   // 蓝牙

@end

@implementation ECViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setupUI];
    [self initData];
}



// MARK: - setupUI
- (void)setupUI {
    [self.navigationItem setTitle:@"iOS 系统权限检测"];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, EC_SCREEN_WIDTH, EC_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, EC_HOMEBAR_HEIGHT, 0);
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _tableView.rowHeight = 50.0f;
    }
    return _tableView;
}

/**
*  ECPrivacyCheckGatherTool             常用隐私权限检测集合工具，包含：定位、照片、相机、通讯录
*
*  ECPrivacyCheckLocationServices       定位
*  ECPrivacyCheckContacts               通讯录
*  ECPrivacyCheckCalendars              日历
*  ECPrivacyCheckReminders              提醒事项
*  ECPrivacyCheckPhotos                 照片
*  ECPrivacyCheckBluetooth              蓝牙
*  ECPrivacyCheckMicrophone             麦克风
*  ECPrivacyCheckSpeechRecognition      语音识别 >= iOS 10.0
*  ECPrivacyCheckCamera                 相机
*  ECPrivacyCheckHealth                 健康 >= iOS 8.0
*  ECPrivacyCheckHomeKit                HomeKit >= iOS 8.0
*  ECPrivacyCheckMediaAndAppleMusic     媒体与Apple Music >= iOS9.3
*  ECPrivacyCheckFilesAndFolders        文件和文件夹
*  ECPrivacyCheckMotionAndFitness       运动与健身
*
*/

// MARK: - init data
- (void)initData {
    NSArray *titleArray = @[@"定位服务", @"通讯录", @"日历", @"提醒事项", @"照片", @"蓝牙", @"麦克风", @"语音识别", @"相机", @"健康", @"HomeKit", @"媒体与AppleMusic", @"文件和文件夹", @"运动与健身"];
    
    NSArray *detailTileArray = @[@"Location Services", @"Contacts", @"Calendars", @"Reminders", @"Photos", @"Bluetooth  Sharing", @"Microphone", @"Speech Recognition", @"Camera", @"Health", @"HomeKit", @"Media & AppleMusic", @"FilesAndFolders", @"Motion & Fitness"];
    
    for (NSInteger i = 0; i < titleArray.count; i ++) {
        NSDictionary *dict = @{@"title" : titleArray[i],
                               @"detailTitle" : detailTileArray[i],
                               @"image" : titleArray[i]
        };
        [self.dataSoureArray addObject:dict];
    }
    
    [self.tableView reloadData];
}

- (NSMutableArray *)dataSoureArray {
    if (_dataSoureArray == nil) {
        _dataSoureArray = [[NSMutableArray alloc] init];
    }
    return _dataSoureArray;
}



// MARK: - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSoureArray.count ? self.dataSoureArray.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIndentifier = NSStringFromClass([self class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifier];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSoureArray.count == 0) {
        NSAssert(self.dataSoureArray.count == 0, @"数据源呢？？？");
    }
    
    NSDictionary *dict = [self.dataSoureArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"title"];
    cell.detailTextLabel.text = [dict objectForKey:@"detailTitle"];
    cell.imageView.image = [UIImage imageNamed:[dict objectForKey:@"image"]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 5) {
        // 蓝牙特殊
        [self checkBluetooth:0];
    } else if (indexPath.row == 12) {
        // 文件和文件夹
        [ECAlert showConfirmAlertWithMessage:@"文件权限不同于其他隐私权限，直接和场景绑定，可以直接查看源码。" completion:nil];
    } else if (indexPath.row == 10) {
        [self checkHomeKit:0];
    } else {
        [ECAlert showWithTitle:@"请选择" message:nil completion:^(NSInteger buttonIndex) {
            [self handleAlert:buttonIndex withRowAtIndexPath:indexPath];
        } cancelButtonTitle:@"取消" otherButtonTitles:@"仅检查是否授权", @"检查并请求权限", nil];
    }
}

- (void)handleAlert:(NSInteger)buttonIndex withRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    if (buttonIndex == 0) {
        return;
    }
    switch (indexPath.row) {
        case 0: // 定位服务
        {
            [self checkLBS:buttonIndex];
        }
            break;
        case 1: // 通讯录
        {
            [self checkContact:buttonIndex];
        }
            break;
        case 2: // 日历
        {
            [self checkCalendars:buttonIndex];
        }
            break;
        case 3: // 提示事项
        {
            [self checkReminders:buttonIndex];
        }
            break;
        case 4: // 照片
        {
            [self checkPhotos:buttonIndex];
        }
            break;
        case 5: // 蓝牙
        {
            ///
        }
            break;
        case 6: // 麦克风
        {
            [self checkMicrophone:buttonIndex];
        }
            break;
        case 7: // 语音识别
        {
            [self checkSpeechRecognition:buttonIndex];
        }
            break;
        case 8: // 相机
        {
            [self checkCamera:buttonIndex];
        }
            break;
        case 9: // 健康
        {
            [self checkHealth:buttonIndex];
        }
            break;
        case 10:    // HomeKit
        {
            ///
        }
            break;
        case 11:    // 媒体与AppleMusic
        {
            [self checkMediaAndAppleMusic:buttonIndex];
        }
            break;
        case 12:    // 文件和文件夹
        {
            ///
        }
            break;
        case 13:    // 运动与健身
        {
            [self checkMotionAndFitness:buttonIndex];
        }
            break;
        default:
            break;
    }
}

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

- (void)checkCalendars:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        ECCalendarsAuthorizationStatus status = [ECPrivacyCheckCalendars calendarsAuthorizationStatus];
        ECAlertShow(@"日历权限状态：", [NSString stringWithFormat:@"%ld", (long)status], @"确定", ^{
        });
    } else {
        [ECPrivacyCheckCalendars requestCalendarsAuthorizationWithCompletionHandler:^(BOOL granted) {
            if (granted) {
                [ECAlert showConfirmAlertWithMessage:@"已获日历权限" completion:nil];
            } else {
                [ECAlert showConfirmAlertWithMessage:@"用户禁用该APP使用日历权限" completion:nil];
            }
        }];
    }
}

- (void)checkReminders:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        ECRemindersAuthorizationStatus status = [ECPrivacyCheckReminders remindersAuthorizationStatus];
        ECAlertShow(@"提醒事项权限状态：", [NSString stringWithFormat:@"%ld", (long)status], @"确定", ^{
        });
    } else {
        [ECPrivacyCheckReminders requestRemindersAuthorizationWithCompletionHandler:^(BOOL granted) {
            if (granted) {
                [ECAlert showConfirmAlertWithMessage:@"已获提醒事项权限" completion:nil];
            } else {
                [ECAlert showConfirmAlertWithMessage:@"用户禁用该APP使用提醒事项权限" completion:nil];
            }
        }];
    }
}

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

- (void)checkMicrophone:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        ECMicrophoneAuthorizationStatus status = [ECPrivacyCheckMicrophone microphoneAuthorizationStatus];
        ECAlertShow(@"麦克风权限状态：", [NSString stringWithFormat:@"%ld", (long)status], @"确定", ^{
        });
    } else {
        [ECPrivacyCheckMicrophone requestMicrophoneAuthorizationWithCompletionHandler:^(BOOL granted) {
            if (granted) {
                 [ECAlert showConfirmAlertWithMessage:@"已获取麦克风权限" completion:nil];
             } else {
                 [ECAlert showConfirmAlertWithMessage:@"用户禁用该APP使用麦克风权限" completion:nil];
             }
        }];
    }
}

- (void)checkSpeechRecognition:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        ECSpeechRecognizerAuthorizationStatus status = [ECPrivacyCheckSpeechRecognition speechRecognitionAuthorizationStatus];
        ECAlertShow(@"语音识别权限状态：", [NSString stringWithFormat:@"%ld", (long)status], @"确定", ^{
        });
    } else {
        [ECPrivacyCheckSpeechRecognition requestSpeechRecognitionAuthorizationWithCompletionHandler:^(BOOL granted) {
            if (granted) {
                 [ECAlert showConfirmAlertWithMessage:@"已获取语音识别权限" completion:nil];
             } else {
                 [ECAlert showConfirmAlertWithMessage:@"用户禁用该APP使用语音识别权限" completion:nil];
             }
        }];
    }
}

- (void)checkCamera:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        ECAuthorizationStatus status = [ECPrivacyCheckGatherTool cameraAuthorizationStatus];
        ECAlertShow(@"相机权限状态：", [NSString stringWithFormat:@"%ld", (long)status], @"确定", ^{
        });
    } else {
        
        [ECPrivacyCheckGatherTool requestCameraAuthorizationWithCompletionHandler:^(BOOL granted) {
            if (granted) {
                [ECAlert showConfirmAlertWithMessage:@"已获取相机权限" completion:nil];
            } else {
                [ECAlert showConfirmAlertWithMessage:@"用户禁用该APP使用相机权限" completion:nil];
            }
        }];
    }
}

- (void)checkHealth:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        ECHealthAuthorizationStatus status = [ECPrivacyCheckHealth healthAuthorizationStatus];
        ECAlertShow(@"健康权限状态：", [NSString stringWithFormat:@"%ld", (long)status], @"确定", ^{
        });
    } else {
        [ECPrivacyCheckHealth requestHealthsAuthorizationWithCompletionHandler:^(BOOL granted) {
            if (granted) {
                 [ECAlert showConfirmAlertWithMessage:@"已获取健康权限" completion:nil];
             } else {
                 [ECAlert showConfirmAlertWithMessage:@"用户禁用该APP使用健康权限" completion:nil];
             }
        }];
    }
}

- (void)checkHomeKit:(NSInteger)buttonIndex {
    [ECAlert showWithMessage:@"HomeKit家庭权限回调依赖于实际业务（HMHomeManagerDelegate协议回调中处理），回调中error类型可以参考HMError.h\n建议可以根据实际业务进行封装\n这里提供使用方法供参考" completion:^(NSInteger buttonIndex) {
        [ECPrivacyCheckHomeKit requestHomeAccessWithCompletionHandler:^(BOOL granted, HMHomeManager * _Nullable manager) {
            if (granted) {
                [ECAlert showWithMessage:@"已获取权限" completion:nil];
            } else {
                [ECAlert showWithMessage:@"没有权限" completion:nil];
            }
        }];
    }];
}

- (void)checkMediaAndAppleMusic:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        ECMediaAndAppleMusicAuthorizationStatus status = [ECPrivacyCheckMediaAndAppleMusic mediaAndAppleMusicAuthorizationStatus];
        ECAlertShow(@"媒体与Apple Music权限状态：", [NSString stringWithFormat:@"%ld", (long)status], @"确定", ^{
        });
    } else {
        [ECPrivacyCheckMediaAndAppleMusic requestMediaAndAppleMusicAuthorizationWithCompletionHandler:^(BOOL granted) {
            if (granted) {
                [ECAlert showConfirmAlertWithMessage:@"已获取媒体与Apple Music权限" completion:nil];
            } else {
                [ECAlert showConfirmAlertWithMessage:@"用户禁用该APP使用媒体与Apple Music权限" completion:nil];
            }
        }];
    }
}

//- (void)checkFilesAndFolders:(NSInteger)buttonIndex {
//
//}

- (void)checkMotionAndFitness :(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        if (@available(iOS 11.0, *)) {
            ECMotionAndFitnessAuthorizationStatus status = [ECPrivacyCheckMotionAndFitness motionAndFitnessAuthorizationStatus];
            ECAlertShow(@"运动与健身权限状态：", [NSString stringWithFormat:@"%ld", (long)status], @"确定", ^{
            });
        } else {
            // Fallback on earlier versions
            [ECAlert showWithMessage:@"iOS 11.0以下，无法直接检测运动与健身权限，请使用 请求运动与健身权限：requestMotionAndFitnessAuthorizationWithCompletionHandler " completion:nil];
        }

    } else {
        [ECPrivacyCheckMotionAndFitness requestMotionAndFitnessAuthorizationWithCompletionHandler:^(BOOL granted) {
            if (granted) {
                 [ECAlert showConfirmAlertWithMessage:@"已获取运动与健身权限" completion:nil];
             } else {
                 [ECAlert showConfirmAlertWithMessage:@"用户禁用该APP使用运动与健身权限" completion:nil];
             }
        }];
    }
}

- (void)callbackOnMainQueue:(dispatch_block_t)block {
    dispatch_async(dispatch_get_main_queue(), block);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
