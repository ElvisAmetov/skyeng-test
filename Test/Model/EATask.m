//
//  EATask.m
//  Test
//
//  Created by Alexey Sinitsa on 16.04.16.
//  Copyright © 2016 elvis. All rights reserved.
//

#import "EATask.h"
#import "EARandom.h"

#define ANSWER_COUNT 3

@interface EATask()

@property (nonatomic, strong) NSMutableArray *record;
@property (nonatomic, strong) EARandom *eaRandom;

@end

@implementation EATask

- (id)initWithDictionary:(NSDictionary*)objects {
    if (self = [super init]) {
        self.meaningId = [objects[@"meaningId"] integerValue];
        self.text = objects[@"text"];
        self.translation = objects[@"translation"];
        self.alternatives = objects[@"alternatives"];
        self.imageURL = [objects[@"images"] firstObject];
        self.imageURL = [self setValidImageURL];
        self.record = [NSMutableArray new];
        self.eaRandom = [[EARandom alloc] init];
        self.alternatives = [self.eaRandom mixArrayWithArray:[self getRandomAlternatives]];
        self.index = [self getRightAnswer];
    }
    return self;
}

- (NSInteger)getRightAnswer {
    for (NSInteger i = 0; i < [self.alternatives count]; i++) {
        if ([self.alternatives[i] isEqualToString:self.translation]) {
            return i;
        }
    }
    return 999;
}

- (NSURL*)setValidImageURL {
    NSString *urlString = [NSString stringWithFormat:@"%@", self.imageURL];
    if (![urlString hasPrefix:@"http:"]) {
        urlString = [NSString stringWithFormat:@"http:%@", self.imageURL];
    }
    return [NSURL URLWithString:urlString];
}



- (NSArray*)getRandomAlternatives {
    NSMutableArray *randomAlternatives = [NSMutableArray new];
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i < [self.alternatives count]; i++) {
        [arr addObject:self.alternatives[i][@"translation"]];
    }
    NSArray *mixArray = [self.eaRandom mixArrayWithArray:[arr copy]];
    for (int i = 0; i < ANSWER_COUNT; i++) {
        NSString *randomObject = mixArray[i];
        [randomAlternatives addObject:randomObject];
    }
    [randomAlternatives addObject:self.translation];
    return [randomAlternatives copy];
}

@end
