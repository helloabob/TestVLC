//
//  PlayerViewController.m
//  TestVLC
//
//  Created by wangbo on 1/15/14.
//  Copyright (c) 2014 wangbo. All rights reserved.
//

#import "PlayerViewController.h"

#import "VLCMediaPlayer.h"

#import "VLCMediaListPlayer.h"

@interface PlayerViewController ()

@property(nonatomic, strong) UIView *movieView;
@property(nonatomic, strong) VLCMediaListPlayer *listPlayer;
@property(nonatomic, strong) VLCMediaPlayer *mediaPlayer;
@property (nonatomic, strong) TopBarView *viewTopBar;

@end

@implementation PlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.view addGestureRecognizer:tap];
    [tap release];
    
    
    
    if (self.URL) {
//        _movieView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 640)];
        _movieView = [[UIView alloc] initWithFrame:self.view.bounds];
        _movieView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_movieView];
        
        _listPlayer = [[VLCMediaListPlayer alloc] init];
        _mediaPlayer = _listPlayer.mediaPlayer;
        [_mediaPlayer setDelegate:self];
        [_mediaPlayer setDrawable:self.movieView];
        
        VLCMedia *media = [VLCMedia mediaWithURL:[NSURL URLWithString:self.URL]];
        [media parse];
        
        [_listPlayer setRootMedia:media];
        
        [_listPlayer playMedia:_listPlayer.rootMedia];
    }
    
    
    
    _viewTopBar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    _viewTopBar.title = @"直播频道";
    _viewTopBar.delegate = self;
    [self.view addSubview:_viewTopBar];
}

- (void)viewDidClose {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tapped:(UIGestureRecognizer *)gesture {
    if (_viewTopBar.superview != self.view) {
        [self.view addSubview:_viewTopBar];
    } else {
        [self.viewTopBar removeFromSuperview];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
