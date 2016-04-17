//
//  ViewController.m
//  Test
//
//  Created by Alexey Sinitsa on 15.04.16.
//  Copyright © 2016 elvis. All rights reserved.
//

#import "EAViewController.h"
#import "EATaskViewController.h"
#import "EANetwork.h"
#import "MBProgressHUD.h"
#import "EATask.h"
#import "EARandom.h"

@interface EAViewController ()

@property (weak, nonatomic) IBOutlet UIButton *beginButton;

@property (nonatomic, strong) NSArray *pages;
@property (nonatomic, strong) NSArray *tasks;
@property (strong, nonatomic) MBProgressHUD *progressHUD;

- (IBAction)beginButtonPressed:(UIButton *)sender;

@end

@implementation EAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didWordLoadError:) name:kNotificationWordDidLoadError object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didWordLoad:) name:kNotificationWordDidLoad object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:kNotificationWordDidLoad];
    [[NSNotificationCenter defaultCenter] removeObserver:kNotificationWordDidLoadError];
}

- (IBAction)beginButtonPressed:(UIButton *)sender {
    EANetwork *network = [EANetwork sharedInstance];
    [network requestWordtasks];
    self.progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.progressHUD.labelText = @"Загрузка";
    self.progressHUD.dimBackground = YES;
}

#pragma mark - Notifications

- (void)didWordLoadError:(NSNotification*)notification {
    NSString *errorString = [notification object];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ошибка" message:errorString preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    [self.progressHUD hide:YES];
}

- (void)didWordLoad:(NSNotification*)notification {
    self.tasks = [notification object];
    EARandom *eaRandom = [EARandom new];
    self.tasks = [eaRandom mixArrayWithArray:self.tasks];
    [self.progressHUD hide:YES];
    [self performSegueWithIdentifier:kFromMainViewControllerToTaskViewController sender:self.tasks];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    EATaskViewController *vc = (EATaskViewController*)segue.destinationViewController;
    vc.tasks = (NSArray*)sender;
}


@end
