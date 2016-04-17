//
//  EANetwork.m
//  Test
//
//  Created by Alexey Sinitsa on 15.04.16.
//  Copyright © 2016 elvis. All rights reserved.
//

#import "EANetwork.h"
#import "AFNetworking.h"
#import "EATask.h"

NSString * const kNotificationWordDidLoadError = @"NotificationWordDidLoadError";
NSString * const kNotificationWordDidLoad = @"NotificationWordDidLoad";

@interface EANetwork()

@property (nonatomic, strong) NSMutableArray *tasks;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation EANetwork

EANetwork *network;

+ (EANetwork*)sharedInstance {
    if (network == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            network = [[EANetwork alloc] init];
            network.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[[NSURL alloc] initWithString:@"http://dictionary.skyeng.ru/api/v1"]];
            network.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
            [network.manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
            [network.manager.requestSerializer setTimeoutInterval:30];
        });
    }
    return network;
}

- (void)requestWordtasks {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    NSDictionary *params = @{@"meaningIds":@"211138,226138,177344,196957,224324,89785,79639,173148,136709,158582,92590,135793,68068,64441,46290,128173,51254,55112,222435", @"width":[NSString stringWithFormat:@"%f",width]};;

    [self.manager GET:@"wordtasks" parameters:params progress:^(NSProgress *downloadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        self.tasks = [[NSMutableArray alloc] init];
        NSArray *responseObjects = responseObject;
        for (NSDictionary *dic in responseObjects) {
            EATask *task = [[EATask alloc] initWithDictionary:dic];
            [self.tasks addObject:task];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationWordDidLoad object:self.tasks];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationWordDidLoadError object:[self stringWithError:error]];
    }];
}

- (NSString*)stringWithError:(NSError*)error {
    NSString *errorString = [error userInfo][@"NSLocalizedDescription"];
    return NSLocalizedString(errorString, nil);
}

@end
