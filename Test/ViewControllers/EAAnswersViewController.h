//
//  EAAnswersViewController.h
//  Test
//
//  Created by Alexey Sinitsa on 16.04.16.
//  Copyright © 2016 elvis. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EAAnswersViewControllerDelegate;

@interface EAAnswersViewController : UIViewController

@property (weak, nonatomic) id<EAAnswersViewControllerDelegate> delegate;

- (void)setButtonsTitle:(NSArray*)titles rightAnswerIndex:(NSUInteger)index;
- (void)reloadButtons;

@end

@protocol EAAnswersViewControllerDelegate <NSObject>

@required
- (void)didChoiceAnswer:(NSNumber*)answer;

@end