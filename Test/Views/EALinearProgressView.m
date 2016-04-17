//
//  EALinearProgressView.m
//  Test
//
//  Created by Alexey Sinitsa on 16.04.16.
//  Copyright © 2016 elvis. All rights reserved.
//

#import "EALinearProgressView.h"

@interface EALinearProgressView()

@property (nonatomic, copy) UIColor *barColor;
@property (nonatomic, copy) UIColor *trackColor;
@property (nonatomic) CGFloat trackPadding;
@property (nonatomic) CGFloat barThickness;
@property (nonatomic) CGFloat barPadding;
@property (nonatomic) CGFloat progressValue;
@property (nonatomic) UIColor *barBorderColor;

@end

@implementation EALinearProgressView

- (void)setProgressValue:(CGFloat)progressValue {
    _progressValue = progressValue;
    if (_progressValue >= 100) {
        _progressValue = 100;
    }
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self drawProgressView];
}

- (void)drawProgressView {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // Prgress Bar border
    CGContextSetStrokeColorWithColor(context, self.barBorderColor.CGColor);
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, self.barThickness + self.trackPadding);
    CGContextMoveToPoint(context, self.barPadding, self.frame.size.height / 2);
    CGContextAddLineToPoint(context, self.frame.size.width - self.barPadding, self.frame.size.height / 2);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextStrokePath(context);
    
    // Progress Bar Track
    CGContextSetStrokeColorWithColor(context, self.trackColor.CGColor);
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, self.barThickness + self.trackPadding - 1);
    CGContextMoveToPoint(context, self.barPadding, self.frame.size.height / 2);
    CGContextAddLineToPoint(context, self.frame.size.width - self.barPadding, self.frame.size.height / 2);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextStrokePath(context);
    
    // Progress Bar
    CGContextSetStrokeColorWithColor(context, self.barColor.CGColor);
    CGContextSetLineWidth(context, self.barThickness + 1);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.barPadding, self.frame.size.height / 2);
    CGContextAddLineToPoint(context, self.barPadding + [self calculatePercentage] , self.frame.size.height / 2);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextStrokePath(context);
    
    
    
    
    CGContextRestoreGState(context);


}

- (void)changeProgressViewWithPercentage:(CGFloat)percentage {
    self.progressValue = self.progressValue + percentage;
    if ([self.delegate respondsToSelector:@selector(didChangeProgress)]) {
        [self.delegate performSelector:@selector(didChangeProgress)];
    }
    [self setNeedsDisplay];
}

- (CGFloat)calculatePercentage {
    CGFloat screenWidth = self.frame.size.width - (self.barPadding * 2);
    CGFloat progress = ((self.progressValue / 100) * screenWidth);
    return progress < 0 ? self.barPadding : progress;
}

@end
