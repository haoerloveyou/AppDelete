#import <UIKit/UIKit.h>
#import <AppList/AppList.h>
#import "../CC.h"


@interface SBIcon : NSObject
- (NSString *)applicationBundleID;
@end

@interface SBIconModel : NSObject
@end

@interface SBIconController : UIViewController
+(instancetype)sharedInstance;
- (SBIconModel *)model;
@end

static NSDictionary *settings;

%group iOS93

%hook SBIconController


- (BOOL)isUninstallSupportedForIcon:(SBIcon *)icon
{
	NSString *key = [@"Delete-" stringByAppendingString:icon.applicationBundleID ?: @""];
	if ([[settings objectForKey:key] boolValue]) {
		return NO;
	}
	return %orig;
}

%end

%end

%group iOS9

%hook SBIconController


- (BOOL)canUninstallIcon:(SBIcon *)icon
{
	NSString *key = [@"Delete-" stringByAppendingString:icon.applicationBundleID ?: @""];
	if ([[settings objectForKey:key] boolValue]) {
		return NO;
	}
	return %orig;
}

%end

%end

static void LoadSettings(void)
{
	[settings release];
	settings = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.CC.AppDelete.plist"];
}

%ctor
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	LoadSettings();
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback) LoadSettings, CFSTR("com.CC.AppDelete.prefs"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	if (isiOS93Up) {
		%init(iOS93);
	} else if (isiOS9Up) {
		%init(iOS9);
	}
	[pool drain];
}
