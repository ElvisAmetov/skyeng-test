//
//  EATask.h
//  Test
//
//  Created by Alexey Sinitsa on 16.04.16.
//  Copyright © 2016 elvis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EATask : NSObject

@property (nonatomic, assign, readwrite) NSInteger meaningId;
@property (nonatomic, copy, readwrite) NSString *text;
@property (nonatomic, copy, readwrite) NSString *translation;
@property (nonatomic, strong, readwrite) NSArray *alternatives;
@property (nonatomic, strong, readwrite) NSURL *imageURL;
@property (nonatomic, assign, readwrite) NSInteger index;

- (id)initWithDictionary:(NSDictionary*)objects;

@end
