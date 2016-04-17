//
//  EAInfoViewController.h
//  Test
//
//  Created by Alexey Sinitsa on 16.04.16.
//  Copyright © 2016 elvis. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EAInfoViewControllerDelegate;

@interface EAInfoViewController : UIViewController

@property (weak, nonatomic) id<EAInfoViewControllerDelegate> delegate;

- (void)setImageOnImageViewWithURL:(NSURL*)imageURL;
- (void)setTranslationString:(NSString*)text;

@end

@protocol EAInfoViewControllerDelegate <NSObject>

- (void)next;

@end