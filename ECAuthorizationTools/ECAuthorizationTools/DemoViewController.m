//
//  DemoViewController.m
//  ECAuthorizationTools
//
//  Created by EchoZuo on 2017/6/20.
//  Copyright © 2017年 Echo.Z. All rights reserved.
//

#import "DemoViewController.h"

#define kSCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height



@interface DemoViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) PrivacyModel *privacyModel;
@property (nonatomic, strong) ECAuthorizationTools *tools;

@end

@implementation DemoViewController


#pragma mark -------------------- lifecycle --------------------
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initData];
    [self updateUI];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -------------------- init data,update ui --------------------
- (void)initData
{
    _dataSource = [NSMutableArray arrayWithArray:[self initialDataSoure]];
}

- (NSArray *)initialDataSoure{
    
    NSArray *titleArray = @[@"访问定位服务权限", @"访问通讯录权限", @"访问日历权限", @"访问提醒事项权限", @"访问照片权限", @"访问蓝牙共享权限", @"访问麦克风权限", @"访问语音识别权限", @"访问相机权限", @"访问健康权限", @"访问HomeKit权限", @"访问媒体与Apple Music权限", @"访问运动与健身权限"];
    
    NSArray *detailTileArray = @[@"Location Services", @"Contacts", @"Calendars", @"Reminders", @"Photos", @"Bluetooth  Sharing", @"Microphone", @"Speech Recognition", @"Camera", @"Health", @"HomeKit", @"Media & AppleMusic", @"Motion & Fitness"];

    NSMutableArray *tempDataSoure = [NSMutableArray array];
    
    for (int i = 0; i < 13; i ++) {
        
        [tempDataSoure addObject:[self setUpModelWithTitle:titleArray[i]
                                           withDetailTitle:detailTileArray[i]
                                           withPrivacyType:i+1
                                             withClassName:@""]];
    }
    
    return tempDataSoure;
}

- (void)updateUI
{
    [self.navigationItem setTitle:@"iOS访问权限Demo"];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


#pragma mark -------------------- Private Methods --------------------
// 生成cell数据源
- (PrivacyModel *)setUpModelWithTitle:(NSString *)title
                      withDetailTitle:(NSString *)detailTitle
                      withPrivacyType:(ECPrivacyType)privacyType
                        withClassName:(NSString *)className
{
    PrivacyModel *model = [PrivacyModel new];
    model.title = title ? title : @"";
    model.detailTitle = detailTitle ? detailTitle : @"";
    model.privacyType = privacyType ? privacyType : ECPrivacyType_None;
    
    return model;
}


#pragma mark -------------------- UITableViewDelegate,UITableViewDataSource --------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdentifier = NSStringFromClass([self class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    self.privacyModel = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = self.privacyModel.title;
    cell.detailTextLabel.text = self.privacyModel.detailTitle;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.privacyModel = [self.dataSource objectAtIndex:indexPath.row];
    self.tools = [[ECAuthorizationTools alloc] init];

    
    if (self.privacyModel.privacyType == ECPrivacyType_LocationServices) {
        // 定位服务
        [self.tools checkAndRequestAccessForLocationServicesWithAccessStatus:^(ECLocationAuthorizationStatus status) {
            if (status != ECLocationAuthorizationStatus_NotDetermined) {
                [self alertViewWithTitle:[ECAuthorizationTools
                                          stringForPrivacyType:ECPrivacyType_LocationServices]
                                 message:[ECAuthorizationTools stringForLocationAuthorizationStatus:status]];
            }
        }];
    } else if (self.privacyModel.privacyType == ECPrivacyType_BluetoothSharing) {
        // 蓝牙
        [self.tools checkAndRequestAccessForBluetoothSharingWithAccessStatus:^(ECCBManagerStatus status) {
            if (status != ECCBManagerStatusUnknown) {
                [self alertViewWithTitle:[ECAuthorizationTools
                                          stringForPrivacyType:ECPrivacyType_BluetoothSharing]
                                 message:[ECAuthorizationTools stringForCBManagerStatus:status]];
            }
        }];
    } else if (self.privacyModel.privacyType == ECPrivacyType_Health) {
        // 健康
        [self.tools checkAndRequestAccessForHealthWtihAccessStatus:^(ECAuthorizationStatus status, ECPrivacyType type) {
            
            if (status != ECAuthorizationStatus_NotDetermined) {
                [self alertViewWithTitle:[ECAuthorizationTools
                                          stringForPrivacyType:ECPrivacyType_Health]
                                 message:[ECAuthorizationTools stringForAuthorizationStatus:status]];
            }
        
        }];
    } else if (self.privacyModel.privacyType == ECPrivacyType_HomeKit) {
        // 家庭
        [self.tools checkAndRequestAccessForHome:^(BOOL isHaveHomeAccess) {
            if (isHaveHomeAccess) {
                [self alertViewWithTitle:[ECAuthorizationTools stringForPrivacyType:ECPrivacyType_HomeKit]
                                 message:@"We have access for home."];
            } else {
                [self alertViewWithTitle:[ECAuthorizationTools stringForPrivacyType:ECPrivacyType_HomeKit]
                                 message:@"We don't have permission to home."];
            }
        }];
    } else if (self.privacyModel.privacyType == ECPrivacyType_MotionAndFitness) {
        // 运动与健身
        [self.tools checkAndRequestAccessForMotionAndFitness];
    } else {
        // 其他
        [ECAuthorizationTools checkAndRequestAccessForType:self.privacyModel.privacyType accessStatus:^(ECAuthorizationStatus status, ECPrivacyType type) {
            
            if (status != ECAuthorizationStatus_NotDetermined) {
                [self alertViewWithTitle:[ECAuthorizationTools
                                          stringForPrivacyType:type]
                                 message:[ECAuthorizationTools stringForAuthorizationStatus:status]];
            }
        }];
    }
}



#pragma mark -------------------- public methods --------------------
#pragma mark - 

- (void)alertViewWithTitle:(NSString *)title message:(NSString *)message;
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}



@end



@implementation PrivacyModel



@end




























