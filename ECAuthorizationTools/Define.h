//
//  Define.h
//  ECAuthorizationTools
//
//  Created by EchoZuo on 2017/6/28.
//  Copyright © 2017年 Echo.Z. All rights reserved.
//

#ifndef Define_h
#define Define_h


#define _isiOS7_          (([UIDevice currentDevice].systemVersion.floatValue >= 7.0f && [UIDevice currentDevice].systemVersion.floatValue < 8.0) ? YES : NO)
#define _isiOS7_Or_Later_ (([UIDevice currentDevice].systemVersion.floatValue >= 7.0f) ? YES : NO)
#define _isiOS8_          (([UIDevice currentDevice].systemVersion.floatValue >= 8.0f && [UIDevice currentDevice].systemVersion.floatValue < 9.0f) ? YES : NO)
#define _isiOS8_Or_Later_ (([UIDevice currentDevice].systemVersion.floatValue >= 8.0f) ? YES : NO)
#define _isiOS9_          (([UIDevice currentDevice].systemVersion.floatValue >= 9.0f && [UIDevice currentDevice].systemVersion.floatValue < 10.0f) ? YES : NO)
#define _isiOS9_Or_Later_ (([UIDevice currentDevice].systemVersion.floatValue >= 9.0f) ? YES : NO)
#define _isiOS10_          (([UIDevice currentDevice].systemVersion.floatValue >= 10.0f && [UIDevice currentDevice].systemVersion.floatValue < 11.0f) ? YES : NO)
#define _isiOS10_Or_Later_ (([UIDevice currentDevice].systemVersion.floatValue >= 10.0f) ? YES : NO)

#define stringWithLiteral(literal) @#literal


// NSLog
#ifdef DEBUG
# define NSLog(fmt, ...) NSLog((fmt), ##__VA_ARGS__);
#else
# define NSLog(...)
#endif

// log  EELog
#ifdef DEBUG
# define EELog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define EELog(...)
#endif

// 日志输出宏定义 ECLog printf 针对iOS10 + xcode 8 打印字典不完整
#ifdef DEBUG
#define ECLog(format, ...) printf("class: <%s:(%d) > method: %s \n%s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define ECLog(...)
#endif


#endif /* Define_h */
