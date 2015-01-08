//
//  TipViewController.m
//  TipCalculatorClass
//
//  Created by Ken Szubzda on 1/7/15.
//  Copyright (c) 2015 Ken Szubzda. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

- (IBAction)onTap:(id)sender;
- (void)updateValues;
- (void)setToDefaultTip;
- (NSString*)convertFloatToPrettyString:(float)input;

@end

@implementation TipViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateValues];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues {
    float billAmount = [self.billTextField.text floatValue];
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = tipAmount + billAmount;
    
    self.tipLabel.text = [self convertFloatToPrettyString:tipAmount];
    self.totalLabel.text = [self convertFloatToPrettyString:totalAmount];
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)setToDefaultTip {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int intValue = [defaults integerForKey:@"tipPercentIndex"];
    self.tipControl.selectedSegmentIndex = intValue;
}

- (void)viewWillAppear:(BOOL)animated {
    [self setToDefaultTip];
    [self updateValues];
}

- (NSString*)convertFloatToPrettyString:(float)input {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *localeString = [defaults objectForKey:@"locale"];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:localeString];
    
    [numberFormatter setLocale:locale];
    [numberFormatter setMaximumFractionDigits:2];
    NSString *resultNumber = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:input]];
    return resultNumber;
}

@end
