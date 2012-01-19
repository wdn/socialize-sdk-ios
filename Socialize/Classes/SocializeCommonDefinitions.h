//
//  SocializeCommonDefinitions.h
//  SocializeSDK
//
//  Created by Fawad Haider on 6/15/11.
//  Copyright 2011 Socialize, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocializeErrorDefinitions.h"

#define SOCIALIZE_VERSION 1.1.8
#define SOCIALIZE_VERSION_STRING @"1.1.8"

/** 
 Third party authentication type 
*/
typedef enum SocializeThirdPartyAuthType {
    SocializeThirdPartyAuthTypeFacebook = 1
} SocializeThirdPartyAuthType;

typedef enum {
    SocializeShareMediumTwitter = 1,
    SocializeShareMediumFacebook = 2,
    SocializeShareMediumOther = 3
} SocializeShareMedium;

typedef enum {
    SocializeCommentActivity,
    SocializeLikeActivity,
    SocializeShareActivity,
    SocializeViewActivity,
    SocializeAllActivity
} SocializeActivityType;