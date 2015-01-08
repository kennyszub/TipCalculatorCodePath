//
//  SettingsViewController.m
//  TipCalculatorClass
//
//  Created by Ken Szubzda on 1/7/15.
//  Copyright (c) 2015 Ken Szubzda. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultCurrencyControl;

- (IBAction)updateDefaultCurrency:(id)sender;
- (IBAction)updateDefaultTipPercent:(id)sender;
- (void)updateDefaultTipControl;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self updateDefaultTipControl];
    [self updateDefaultCurrencyControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateDefaultCurrency:(id)sender {
    NSArray *currencies = @[@"en_US", @"es_ES", @"en_GB", @"ja_JP"];

    NSString *locale = [currencies objectAtIndex:self.defaultCurrencyControl.selectedSegmentIndex];
    int currencyIndex = self.defaultCurrencyControl.selectedSegmentIndex;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:locale forKey:@"locale"];
    [defaults setInteger:currencyIndex forKey:@"currencyIndex"];
    [defaults synchronize];
}

- (IBAction)updateDefaultTipPercent:(id)sender {
    int tipPercentIndex = self.defaultTipControl.selectedSegmentIndex;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:tipPercentIndex forKey:@"tipPercentIndex"];
    [defaults synchronize];
}

- (void)updateDefaultTipControl {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int intValue = [defaults integerForKey:@"tipPercentIndex"];
    self.defaultTipControl.selectedSegmentIndex = intValue;
}

- (void)updateDefaultCurrencyControl {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int intValue = [defaults integerForKey:@"currencyIndex"];
    self.defaultCurrencyControl.selectedSegmentIndex = intValue;
}


@end
