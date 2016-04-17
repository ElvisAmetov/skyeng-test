//
//  EAAnswersViewController.m
//  Test
//
//  Created by Alexey Sinitsa on 16.04.16.
//  Copyright © 2016 elvis. All rights reserved.
//

#import "EAAnswersViewController.h"
#import "UIButton+EAButton.h"
#import "EATask.h"

@interface EAAnswersViewController ()

@property (weak, nonatomic) IBOutlet UIButton *firstAnswerButton;
@property (weak, nonatomic) IBOutlet UIButton *secondAnsweButton;
@property (weak, nonatomic) IBOutlet UIButton *thridAnswerButton;
@property (weak, nonatomic) IBOutlet UIButton *fourthAnswerButton;
@property (weak, nonatomic) IBOutlet UIButton *notRememberButton;


@property (strong, nonatomic) NSArray *buttons;
@property (assign, nonatomic) NSInteger rightAnswerIndex;
@property (assign, nonatomic) BOOL isRightAnswer;

- (IBAction)chouseAnswer:(UIButton *)sender;

@end

@implementation EAAnswersViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.buttons = @[self.firstAnswerButton, self.secondAnsweButton, self.thridAnswerButton, self.fourthAnswerButton];
    self.rightAnswerIndex = 0;
    self.isRightAnswer = NO;
}

- (IBAction)chouseAnswer:(UIButton *)sender {
    UIButton *button = ((UIButton*)[self.buttons objectAtIndex:self.rightAnswerIndex]);
    if (sender.tag == 5) {
        [button successButton];
    } else {
        if (sender.tag == self.rightAnswerIndex) {
            [sender successButton];
            self.isRightAnswer = YES;
        } else {
            [sender failureButton];
            [button successButton];
        }
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(didChoiceAnswer:)]) {
            [self.delegate performSelector:@selector(didChoiceAnswer:) withObject:[NSNumber numberWithBool:self.isRightAnswer]];
        }
    });
    [self disableButtons];
}

- (void)disableButtons {
    for (UIButton *button in self.buttons) {
        button.userInteractionEnabled = NO;
    }
    self.notRememberButton.userInteractionEnabled = NO;
}

- (void)enableButtons {
    for (UIButton *button in self.buttons) {
        button.userInteractionEnabled = YES;
    }
    self.notRememberButton.userInteractionEnabled = YES;
}

- (void)reloadButtons {
    for (UIButton *button in self.buttons) {
        [button reloadButton];
    }
    self.isRightAnswer = NO;
    [self enableButtons];
}

- (void)setButtonsTitle:(NSArray*)titles rightAnswerIndex:(NSUInteger)index {
    for (int i = 0; i < [self.buttons count]; i++) {
        [self.buttons[i] setTitle:titles[i] forState:UIControlStateNormal];
    }
    self.rightAnswerIndex = index;
    ((UIButton*)[self.buttons objectAtIndex:index]).tag = index;
}

@end
