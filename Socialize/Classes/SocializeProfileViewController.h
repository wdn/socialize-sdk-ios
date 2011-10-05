//
//  ProfileViewController.h
//  SocializeSDK
//
//  Created by Nathaniel Griswold on 9/26/11.
//  Copyright 2011 Socialize, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocializeFullUser.h"
#import "SocializeProfileEditViewController.h"
#import "_Socialize.h"

@class LoadingView;
@protocol SocializeProfileViewControllerDelegate;

@interface SocializeProfileViewController : UIViewController <UINavigationControllerDelegate, SocializeProfileEditViewControllerDelegate, SocializeServiceDelegate>
@property (nonatomic, retain) UIBarButtonItem *doneButton;
@property (nonatomic, retain) UIBarButtonItem *editButton;
@property (nonatomic, assign) id<SocializeProfileViewControllerDelegate> delegate;
@property (nonatomic, retain) id<SocializeFullUser> user;
@property (nonatomic, retain) IBOutlet UIImageView *profileImageView;
@property (nonatomic, retain) IBOutlet UILabel *userNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *userDescriptionLabel;
@property (nonatomic, retain) IBOutlet UILabel *userLocationLabel;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *profileImageActivityIndicator;
@property (nonatomic, retain) SocializeProfileEditViewController *profileEditViewController;
@property (nonatomic, retain) LoadingView *loadingView;
@property (nonatomic, retain) Socialize *socialize;
@end

@protocol SocializeProfileViewControllerDelegate
- (void)profileViewControllerDidCancel:(SocializeProfileViewController*)profileViewController;
- (void)profileViewControllerDidSave:(SocializeProfileViewController*)profileViewController;
@end
