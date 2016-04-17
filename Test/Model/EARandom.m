//
//  EARandom.m
//  Test
//
//  Created by Alexey Sinitsa on 17.04.16.
//  Copyright © 2016 elvis. All rights reserved.
//

#import "EARandom.h"

@interface EARandom()

@property (nonatomic, strong) NSMutableArray *arrayRecorder;

@end

@implementation EARandom


- (NSArray*)mixArrayWithArray:(NSArray*)array {
    NSMutableArray *mixArray = [NSMutableArray new];
    self.arrayRecorder = [NSMutableArray new];
    for (int i = 0; i < [array count]; i++) {
        u_int32_t rnd = arc4random_uniform((uint32_t)[array count]);
        NSString *randomObject = array[rnd];
        if (![self.arrayRecorder containsObject:randomObject]) {
            [mixArray addObject:randomObject];
            [self.arrayRecorder addObject:randomObject];
        } else {
            i--;
        }
    }
    return [mixArray copy];
}


@end
