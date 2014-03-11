#import <Preferences/Preferences.h>

@interface videogesturesprefsListController: PSListController {
}
@end

@implementation videogesturesprefsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"videogesturesprefs" target:self] retain];
	}
	return _specifiers;
}

- (void)viewWillAppear:(BOOL)animated {
 
         ((UIViewController *)self).view.tintColor = [UIColor greenColor];
         ((UIViewController *)self).navigationController.navigationBar.tintColor = [UIColor greenColor];
    }

- (void)viewWillDisappear:(BOOL)animated {

         ((UIViewController *)self).view.tintColor = nil;
         ((UIViewController *)self).navigationController.navigationBar.tintColor = nil;
    
}

-(void)Follow:(PSSpecifier*)spec
{
    
   if([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"tweetbot:"]]){
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tweetbot://user_profile/davidedj10"]];
    }else if([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"tweetings:"]]){
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tweetings:///user?screen_name=davidedj10"]];
    }else if([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"twitter:"]]){
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"twitter://user?screen_name=davidedj10"]];
    }else{
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://twitter.com/davidedj10"]];
    }           
    
}

-(void)Github:(PSSpecifier*)spec
{
    
    NSURL *url = [[NSURL alloc] initWithString:@"https://github.com/davidedj10/VideoGestures"];
	[[UIApplication sharedApplication] openURL:url];
    
}

-(void)Donate:(PSSpecifier*)spec
{
    
    NSURL *url = [[NSURL alloc] initWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=davidedj10%40live%2eit&lc=IT&item_name=Davide%20Fresilli&currency_code=EUR&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHosted"];
	[[UIApplication sharedApplication] openURL:url];
    
}
@end

// vim:ft=objc
