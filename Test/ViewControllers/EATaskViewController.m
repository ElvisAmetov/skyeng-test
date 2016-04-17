//
//  EATaskViewController.m
//  Test
//
//  Created by Alexey Sinitsa on 15.04.16.
//  Copyright © 2016 elvis. All rights reserved.
//

#import "EATaskViewController.h"
#import "EALinearProgressView.h"
#import "EATask.h"
#import "UIButton+EAButton.h"
#import "EAAnswersViewController.h"
#import "EAInfoViewController.h"
#import "EANetwork.h"
#import "EAResultViewController.h"

@interface EATaskViewController () <EAAnswersViewControllerDelegate, EAInfoViewControllerDelegate>{
    NSInteger currentPage;
}

@property (weak, nonatomic) IBOutlet EALinearProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) UIPageViewController *pageVC;
@property (strong, nonatomic) EAAnswersViewController *answerVC;
@property (strong, nonatomic) EAInfoViewController *infoVC;
@property (assign, nonatomic) NSInteger rightAnswer;


@end

@implementation EATaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.answerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"EAAnswersViewController"];
    self.infoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"EAInfoViewController"];
    
    self.infoVC.delegate = self;
    self.answerVC.delegate = self;
    
    [self addChildViewController:self.pageVC];
    [self.contentView addSubview:self.pageVC.view];
    [self.pageVC.view setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];

    [self.pageVC setViewControllers:@[self.answerVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];

    currentPage = 0;
    self.rightAnswer = 0;
    
    EATask *task = ((EATask*)self.tasks[currentPage]);
    self.wordLabel.text = task.text;
    
    [self.infoVC setImageOnImageViewWithURL:task.imageURL];
    [self.answerVC setButtonsTitle:task.alternatives rightAnswerIndex:task.index];
}

#pragma mark - Delegates

- (void)didChoiceAnswer:(NSNumber *)answer {
    [self.pageVC setViewControllers:@[self.infoVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    EATask *task = ((EATask*)self.tasks[currentPage]);
    if ([answer isEqualToNumber:@1]) {
        self.rightAnswer++;
    }
    [self.infoVC setTranslationString:task.translation];
    [self.infoVC setImageOnImageViewWithURL:task.imageURL];
}

- (void)next {
    currentPage++;
    if (currentPage == 10) {
        [self performSegueWithIdentifier:kFromTaskViewControllerToResultViewController sender:[NSNumber numberWithInteger:self.rightAnswer]];
    }
    EATask *task = ((EATask*)self.tasks[currentPage]);
    self.wordLabel.text = task.text;
    
    [self.progressView changeProgressViewWithPercentage:10];
    [self.pageVC setViewControllers:@[self.answerVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self.answerVC reloadButtons];
    [self.answerVC setButtonsTitle:task.alternatives rightAnswerIndex:task.index];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kFromTaskViewControllerToResultViewController]) {
        EAResultViewController *vc = segue.destinationViewController;
        vc.rightAnswerCount = (NSNumber*)sender;
    }
}

@end
