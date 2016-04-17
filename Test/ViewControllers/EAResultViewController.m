//
//  EAResultViewController.m
//  Test
//
//  Created by Alexey Sinitsa on 17.04.16.
//  Copyright © 2016 elvis. All rights reserved.
//

#import "EAResultViewController.h"

#define TASK_COUNT 10

@interface EAResultViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

- (IBAction)repeatButtonPressed:(UIButton *)sender;

@end

@implementation EAResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.rightAnswerCount == NULL) {
        self.rightAnswerCount = @0;
    }
    self.resultLabel.text = [NSString stringWithFormat:@"%@/%d", self.rightAnswerCount, TASK_COUNT];
}

- (IBAction)repeatButtonPressed:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
