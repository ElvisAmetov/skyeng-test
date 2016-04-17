//
//  EAInfoViewController.m
//  Test
//
//  Created by Alexey Sinitsa on 16.04.16.
//  Copyright © 2016 elvis. All rights reserved.
//

#import "EAInfoViewController.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"
#import "EATask.h"

@interface EAInfoViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *translationLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;
@property (strong, nonatomic) MBProgressHUD *progressHUD;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)nextButtonPressed:(UIButton *)sender;

@end

@implementation EAInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.activityIndicator startAnimating];
}

- (void)setImageOnImageViewWithURL:(NSURL*)imageURL {
   
    __weak typeof(self)weakSelf = self;
    [self.imageView setImageWithURLRequest:[NSURLRequest requestWithURL:imageURL] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        weakSelf.imageView.image = image;
        [weakSelf.activityIndicator stopAnimating];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        [weakSelf.activityIndicator stopAnimating];
    }];
}

- (void)setTranslationString:(NSString*)text {
    self.translationLabel.text = text;
}

- (IBAction)nextButtonPressed:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(next)]) {
        [self.delegate performSelector:@selector(next)];
    }
}

@end
