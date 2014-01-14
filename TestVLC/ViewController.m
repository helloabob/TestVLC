//
//  ViewController.m
//  TestVLC
//
//  Created by wangbo on 1/13/14.
//  Copyright (c) 2014 wangbo. All rights reserved.
//

#import "ViewController.h"

#import "PlayerViewController.h"



@interface ViewController ()

@property (retain, nonatomic) IBOutlet UITextField *txtURL;

@property (retain, nonatomic) IBOutlet UIButton *btnPlay;

@end

@implementation ViewController

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)btnPlayTapped:(id)sender {
    PlayerViewController *playerVC = [[[PlayerViewController alloc] init] autorelease];
    playerVC.URL = self.txtURL.text;
    [self presentViewController:playerVC animated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.txtURL.delegate = self;
    [self.btnPlay setBackgroundColor:[UIColor lightGrayColor]];
    [self.btnPlay addTarget:self action:@selector(btnPlayTapped:) forControlEvents:UIControlEventTouchUpInside];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_txtURL release];
    [_btnPlay release];
    [super dealloc];
}
@end
