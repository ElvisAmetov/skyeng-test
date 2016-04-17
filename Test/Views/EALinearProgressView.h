//
//  EALinearProgressView.h
//  Test
//
//  Created by Alexey Sinitsa on 16.04.16.
//  Copyright © 2016 elvis. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EALinearProgressViewDelegate;

@interface EALinearProgressView : UIView

@property (nonatomic, weak) id<EALinearProgressViewDelegate> delegate;

- (void)changeProgressViewWithPercentage:(CGFloat)percentage;

@end

@protocol EALinearProgressViewDelegate <NSObject>

@optional

- (void)didChangeProgress;

@end
