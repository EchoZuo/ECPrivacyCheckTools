#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ECPrivacyCheckGatherTool.h"
#import "ECPrivacyCheckHelp.h"
#import "ECPrivacyCheckBluetooth.h"
#import "ECPrivacyCheckCalendars.h"
#import "ECPrivacyCheckCamera.h"
#import "ECPrivacyCheckContacts.h"
#import "ECPrivacyCheckFilesAndFolders.h"
#import "ECPrivacyCheckHealth.h"
#import "ECPrivacyCheckHomeKit.h"
#import "ECPrivacyCheckLocationServices.h"
#import "ECPrivacyCheckMediaAndAppleMusic.h"
#import "ECPrivacyCheckMicrophone.h"
#import "ECPrivacyCheckMotionAndFitness.h"
#import "ECPrivacyCheckPhotos.h"
#import "ECPrivacyCheckReminders.h"
#import "ECPrivacyCheckSpeechRecognition.h"

FOUNDATION_EXPORT double ECPrivacyCheckToolsVersionNumber;
FOUNDATION_EXPORT const unsigned char ECPrivacyCheckToolsVersionString[];

