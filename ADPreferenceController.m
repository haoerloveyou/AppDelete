#import <UIKit/UIKit.h>
#import <Cephei/HBListController.h>
#import <Cephei/HBAppearanceSettings.h>
#import <Preferences/PSSpecifier.h>
#import <Social/Social.h>
#import <HBPreferences.h>
#import "../CC.h"


@interface ADPreferenceController : PSListController
@end


@implementation ADPreferenceController

- (void)loadView
{
	[super loadView];
	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 110)];
	UILabel *tweakLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, 320, 50)];
	tweakLabel.text = @"AppDelete";
	tweakLabel.textColor = UIColor.systemBlueColor;
	tweakLabel.backgroundColor = UIColor.clearColor;
	tweakLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:40.0];
	tweakLabel.textAlignment = 1;
	tweakLabel.autoresizingMask = 0x12;
	[headerView addSubview:tweakLabel];
	[tweakLabel release];
	UILabel *footer = [[UILabel alloc] initWithFrame:CGRectMake(0, 75, 320, 20)];
	footer.text = @"Better app control";
	footer.alpha = 0.8;
	footer.font = [UIFont systemFontOfSize:14.0];
	footer.textColor = UIColor.systemBlueColor;
	footer.backgroundColor = UIColor.clearColor;
	footer.textAlignment = 1;
	footer.autoresizingMask = 0xa;
	[headerView addSubview:footer];
	[footer release];
	self.table.tableHeaderView = headerView;
	[headerView release];
}


- (id)init
{
	if (self == [super init]) {
		HBAppearanceSettings *appearanceSettings = [[HBAppearanceSettings alloc] init];
		appearanceSettings.tintColor = UIColor.systemBlueColor;
		appearanceSettings.tableViewCellTextColor = UIColor.systemBlueColor;
		appearanceSettings.invertedNavigationBar = YES;
		self.hb_appearanceSettings = appearanceSettings;
		UIButton *heart = [[[UIButton alloc] initWithFrame:CGRectZero] autorelease];
		UIImage *image = [UIImage imageNamed:@"Heart" inBundle:[NSBundle bundleWithPath:@"/Library/PreferenceBundles/ADSettings.bundle"]];
		image = [image _flatImageWithColor:UIColor.whiteColor];
		[heart setImage:image forState:UIControlStateNormal];
		[heart sizeToFit];
		[heart addTarget:self action:@selector(loved) forControlEvents:UIControlEventTouchUpInside];
		self.navigationItem.rightBarButtonItem =  [[[UIBarButtonItem alloc] initWithCustomView:heart] autorelease];
	}
	return self;
}

- (void)loved
{
	SLComposeViewController *twitter = [[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter] retain];
	twitter.initialText = @"#AppDelete by @ca13ra1 is awesome!";
	[self.navigationController presentViewController:twitter animated:YES completion:nil];
	[twitter release];
}


- (NSArray *)specifiers
{
	if (_specifiers == nil) {
		NSMutableArray *specs = [NSMutableArray arrayWithArray:[self loadSpecifiersFromPlistName:@"AppDelete" target:self]];
		_specifiers = [specs copy];
	}
	return _specifiers;
}

@end