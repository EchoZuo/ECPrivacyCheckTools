//
//  DemoViewController.h
//  ECAuthorizationToolsDemo
//
//  Created by EchoZuo on 2017/6/20.
//  Copyright © 2017年 Echo.Z. All rights reserved.
//

@import UIKit;

#import "ECAuthorizationTools.h"


@interface DemoViewController : UIViewController

@end


@interface PrivacyModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detailTitle;
@property (nonatomic, assign) ECPrivacyType privacyType;
@property (nonatomic, copy) NSString *className;


@end
