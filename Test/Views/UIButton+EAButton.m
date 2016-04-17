//
//  UIButton+EAButton.m
//  Test
//
//  Created by Alexey Sinitsa on 16.04.16.
//  Copyright © 2016 elvis. All rights reserved.
//

#import "UIButton+EAButton.h"

@implementation UIButton (EAButton)

- (void)successButton {
    [self configureButtonWithColor:[UIColor colorWithRed:164.f/255.f green:202.f/255.f blue:91.f/255.f alpha:1]];
}

- (void)failureButton {
    [self configureButtonWithColor:[UIColor colorWithRed:255.f/255.f green:116.f/255.f blue:117.f/255.f alpha:1]];
}

- (void)configureButtonWithColor:(UIColor*)color {
    self.layer.borderWidth = 0;
    self.backgroundColor = color;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)reloadButton {
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.backgroundColor = [UIColor clearColor];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

@end
