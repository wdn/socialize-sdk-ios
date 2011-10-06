//
//  KIFTestStep+SampleAdditions.m
//  SocializeSDK
//
//  Created by Nathaniel Griswold on 9/14/11.
//  Copyright 2011 Socialize, Inc. All rights reserved.
//

#import "KIFTestStep+SampleSdkAppAdditions.h"
#import "SampleSdkAppAppDelegate.h"
#import "CGGeometry-KIFAdditions.h"
#import "UIAccessibilityElement-KIFAdditions.h"
#import "UIApplication-KIFAdditions.h"
#import "UIScrollView-KIFAdditions.h"
#import "UITouch-KIFAdditions.h"
#import "UIView-KIFAdditions.h"
#import "UIWindow-KIFAdditions.h"

@implementation KIFTestStep (SampleSdkAppAdditions)

+ (id)stepToReturnToList;
{
    return [KIFTestStep stepWithDescription:@"Reset the application state." executionBlock:^(KIFTestStep *step, NSError **error) {
        BOOL successfulReset = YES;
        
        SampleSdkAppAppDelegate* appDelegate = (SampleSdkAppAppDelegate *)[UIApplication sharedApplication].delegate;
        UIViewController *testListController = [appDelegate.rootController.viewControllers objectAtIndex:1];
        [appDelegate.rootController popToViewController:testListController animated:NO];
        // Do the actual reset for your app. Set successfulReset = NO if it fails.
        KIFTestCondition(successfulReset, error, @"Failed to reset the application.");
        return KIFTestStepResultSuccess;
    }];
}

+ (NSArray*)stepsToNoAuth
{
    NSMutableArray *steps = [NSMutableArray array];
    [steps addObject:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"emptycache"]];
    [steps addObject:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"noauth"]]; 
    return steps;
}
+ (NSArray*)stepsToAuthenticate;
{
    NSMutableArray *steps = [NSMutableArray array];
    
    // Tap the "I already have an account" button
    [steps addObject:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"authenticate"]];
    [steps addObject:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:@"Test List"]];
    
    return steps;
}

+ (NSArray*)stepsToShowActionBar {
    NSMutableArray *steps = [NSMutableArray array];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:10 inSection:0];
    [steps addObject:[KIFTestStep stepToScrollAndTapRowInTableViewWithAccessibilityLabel:@"tableView" atIndexPath:indexPath]];
    [steps addObject:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:@"Input Field"]];
    [steps addObject:[KIFTestStep stepToEnterText:[KIFTestStep getRandomURL] intoViewWithAccessibilityLabel:@"Input Field"]];
    [steps addObject:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Enter"]];
    return steps;
}
+ (NSArray*)stepsToWaitForActionCompleted {
    NSMutableArray *steps = [NSMutableArray array];

    [steps addObject:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"Socialize Action View"]];
    [steps addObject:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:@"Socialize Action View"]];
    
    return steps;
}

+ (NSArray*)stepsToCreateEntityWithURL:(NSString*)url name:(NSString*)name;
{
    NSMutableArray *steps = [NSMutableArray array];
    [steps addObject:[KIFTestStep stepToReturnToList]];
    NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
    [steps addObject:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:@"tableView" atIndexPath:path]];
    [steps addObject:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"Create Entity"]];    
    [steps addObject:[KIFTestStep stepToEnterText:url intoViewWithAccessibilityLabel:@"entityField"]];
    if (name != nil) {
        [steps addObject:[KIFTestStep stepToEnterText:name intoViewWithAccessibilityLabel:@"nameField"]];
    }
    [steps addObject:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"createButton"]];
    [steps addObject:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"resultTextField" value:@"success"traits:UIAccessibilityTraitNone]];

    return steps;
}

+(NSString*)getRandomURL;
{
    int randomNum = arc4random() % 999999999999;
    NSString *randomString = [NSString stringWithFormat:@"http://www.example.com/%i", randomNum];
    return randomString;
}
+ (NSArray*)stepsToCreateEntityWithRandomURL;
{
    NSString *randomString = [KIFTestStep getRandomURL];
    return [self stepsToCreateEntityWithURL:randomString name:nil];;
}

+ (NSArray*)stepsToGetEntityWithURL:(NSString*)url;
{
    NSMutableArray *steps = [NSMutableArray array];
    [steps addObject:[KIFTestStep stepToReturnToList]];
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    [steps addObject:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:@"tableView" atIndexPath:path]];
    [steps addObject:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"Get Entity"]];    
    [steps addObject:[KIFTestStep stepToEnterText:url intoViewWithAccessibilityLabel:@"entityField"]];
    [steps addObject:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"getEntityButton"]];
    [steps addObject:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"resultTextField" value:@"success"traits:UIAccessibilityTraitNone]];
    return steps;
}

+ (NSArray*)stepsToCreateCommentForEntity:(NSString*)entity comment:(NSString*)comment
{
    NSMutableArray *steps = [NSMutableArray array];
    
    [steps addObject:[KIFTestStep stepToReturnToList]];
    NSIndexPath *path = [NSIndexPath indexPathForRow:2 inSection:0];
    [steps addObject:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:@"tableView" atIndexPath:path]];
    [steps addObject:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"Create Comment"]];    
    [steps addObject:[KIFTestStep stepToEnterText:entity intoViewWithAccessibilityLabel:@"entityField"]];
    [steps addObject:[KIFTestStep stepToEnterText:comment intoViewWithAccessibilityLabel:@"commentField"]];
    [steps addObject:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"createButton"]];
    [steps addObject:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"resultTextField" value:@"success"traits:UIAccessibilityTraitNone]];
    return steps;
}

+ (NSArray*)stepsToCreateCommentWithControllerForEntity:(NSString*)entity comment:(NSString*)comment
{
    NSMutableArray *steps = [NSMutableArray array];
    
    [steps addObject:[KIFTestStep stepToReturnToList]];
    NSIndexPath *path = [NSIndexPath indexPathForRow:7 inSection:0];
    [steps addObject:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:@"tableView" atIndexPath:path]];
    [steps addObject:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:@"Input Field"]];
    [steps addObject:[KIFTestStep stepToEnterText:entity intoViewWithAccessibilityLabel:@"Input Field"]];
    [steps addObject:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Enter"]];
    [steps addObject:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"Comment Entry"]];
    [steps addObject:[KIFTestStep stepToEnterText:comment intoViewWithAccessibilityLabel:@"Comment Entry"]];
    [steps addObject:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Send"]];
    [steps addObject:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"Facebook?"]];
    [steps addObject:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"No"]];
    [steps addObject:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"Anonymous?"]];
    [steps addObject:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Ok"]];
    [steps addObject:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"Tests"]];
    return steps;
}


+ (NSArray*)stepsToGetCommentsForEntity:(NSString*)entity
{
    NSMutableArray *steps = [NSMutableArray array];
    [steps addObject:[KIFTestStep stepToReturnToList]];
    NSIndexPath *path = [NSIndexPath indexPathForRow:3 inSection:0];
    [steps addObject:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:@"tableView" atIndexPath:path]];
    [steps addObject:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"Fetch Comment"]];    
    [steps addObject:[KIFTestStep stepToEnterText:entity intoViewWithAccessibilityLabel:@"entityField"]];
    [steps addObject:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"getCommentsButton"]];
    [steps addObject:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"Comments List"]];
    return steps;
}

+ (NSArray*)stepsToVerifyCommentExistsForEntity:(NSString*)entity comment:(NSString*)comment {
    NSMutableArray *steps = [NSMutableArray array];
    [steps addObject:[KIFTestStep stepToReturnToList]];
    [steps addObjectsFromArray:[self stepsToGetCommentsForEntity:entity]];
    [steps addObject:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"Comment Cell"]];
    [steps addObject:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:@"Comments Table View" atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]];
    [steps addObject:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:comment]];
    
    return steps;
}

+ (NSArray*)stepsToLikeEntity:(NSString*)entity
{
    NSMutableArray *steps = [NSMutableArray array];
    
    [steps addObject:[KIFTestStep stepToReturnToList]];
    NSIndexPath *path = [NSIndexPath indexPathForRow:4 inSection:0];
    [steps addObject:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:@"tableView" atIndexPath:path]];
    [steps addObject:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"Create a like/unlike"]];    
    [steps addObject:[KIFTestStep stepToEnterText:entity intoViewWithAccessibilityLabel:@"entityField"]];
    [steps addObject:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"likeButton"]];
    [steps addObject:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"resultTextField" value:@"success" traits:UIAccessibilityTraitNone]];
    return steps;
}

+ (NSArray*)stepsToUnlikeEntity:(NSString*)entity
{
    NSMutableArray *steps = [NSMutableArray array];
    
    [steps addObject:[KIFTestStep stepToReturnToList]];
    NSIndexPath *path = [NSIndexPath indexPathForRow:4 inSection:0];
    [steps addObject:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:@"tableView" atIndexPath:path]];
    [steps addObject:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"Create a like/unlike"]];    
    [steps addObject:[KIFTestStep stepToEnterText:entity intoViewWithAccessibilityLabel:@"entityField"]];
    
    // FIXME: The test UI currently does not allow unlike to be the first action, so like before unliking
    [steps addObject:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"likeButton"]];
//    [steps addObjectsFromArray:[KIFTestStep stepsToWaitForActionCompleted]];
    [steps addObject:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"resultTextField" value:@"success" traits:UIAccessibilityTraitNone]];
    
    [steps addObject:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:@"unlikeButton"]];
    [steps addObject:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"unlikeButton"]];
    [steps addObject:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"resultTextField" value:@"success" traits:UIAccessibilityTraitNone]];
    return steps;
}


+ (NSArray*)stepsToVerifyLikesForEntity:(NSString*)entity areAtCount:(NSInteger)count
{
    NSMutableArray *steps = [NSMutableArray array];
    
    [steps addObjectsFromArray:[KIFTestStep stepsToGetEntityWithURL:entity]];
    NSString *countString = [NSString stringWithFormat:@"%d", count];
    [steps addObject:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"likesCount" value:countString traits:UIAccessibilityTraitNone]];
    return steps;
}

+ (NSArray*)stepsToViewEntityWithURL:(NSString*)url;
{
    NSMutableArray *steps = [NSMutableArray array];
    [steps addObject:[KIFTestStep stepToReturnToList]];
    NSIndexPath *path = [NSIndexPath indexPathForRow:6 inSection:0];
    [steps addObject:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:@"tableView" atIndexPath:path]];
    [steps addObject:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"Test create a view"]];    
    [steps addObject:[KIFTestStep stepToEnterText:url intoViewWithAccessibilityLabel:@"entityField"]];
    [steps addObject:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"createViewButton"]];
    [steps addObject:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"resultTextField" value:@"success"traits:UIAccessibilityTraitNone]];
    return steps;
}

+ (NSArray*)stepsToVerifyViewsForEntity:(NSString*)entity areAtCount:(NSInteger)count
{
    NSMutableArray *steps = [NSMutableArray array];
    
    [steps addObjectsFromArray:[KIFTestStep stepsToGetEntityWithURL:entity]];
    NSString *countString = [NSString stringWithFormat:@"%d", count];
    [steps addObject:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"viewsCount" value:countString traits:UIAccessibilityTraitNone]];
    return steps;
}

+ (id)stepToScrollAndTapRowInTableViewWithAccessibilityLabel:(NSString*)tableViewLabel atIndexPath:(NSIndexPath *)indexPath
{
    NSString *description = [NSString stringWithFormat:@"Step to tap row %d in tableView with label %@", [indexPath row], tableViewLabel];
    return [KIFTestStep stepWithDescription:description executionBlock:^(KIFTestStep *step, NSError **error) {
        UIAccessibilityElement *element = [[UIApplication sharedApplication] accessibilityElementWithLabel:tableViewLabel];
        KIFTestCondition(element, error, @"View with label %@ not found", tableViewLabel);
        UITableView *tableView = (UITableView*)[UIAccessibilityElement viewContainingAccessibilityElement:element];
        
        KIFTestCondition([tableView isKindOfClass:[UITableView class]], error, @"Specified view is not a UITableView");
        
        KIFTestCondition(tableView, error, @"Table view with label %@ not found", tableViewLabel);
        
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        CGRect cellFrame = [cell.contentView convertRect:[cell.contentView frame] toView:tableView];
        [tableView tapAtPoint:CGPointCenteredInRect(cellFrame)];
        
        return KIFTestStepResultSuccess;
    }];
}

@end
