//
//  EANetwork.h
//  Test
//
//  Created by Alexey Sinitsa on 15.04.16.
//  Copyright © 2016 elvis. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const kNotificationWordDidLoadError;
FOUNDATION_EXPORT NSString * const kNotificationWordDidLoad;

@interface EANetwork : NSObject

+ (EANetwork*)sharedInstance;
- (void)requestWordtasks;

@end
