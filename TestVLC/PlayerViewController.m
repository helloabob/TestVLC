//
//  PlayerViewController.m
//  TestVLC
//
//  Created by wangbo on 1/15/14.
//  Copyright (c) 2014 wangbo. All rights reserved.
//

#import "PlayerViewController.h"



#import "VLCMediaListPlayer.h"

@interface PlayerViewController ()

@property (nonatomic, strong) UIView *movieView;
@property (nonatomic, strong) VLCMediaListPlayer *listPlayer;
@property (nonatomic, strong) VLCMediaPlayer *mediaPlayer;
@property (nonatomic, strong) TopBarView *viewTopBar;

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation PlayerViewController

- (void)dealloc {
    _mediaPlayer.delegate = nil;
    _mediaPlayer.drawable = nil;
    [_listPlayer release];
    [_URL release];
    [_movieView release];
    [_viewTopBar release];
    [_indicatorView release];
    [super dealloc];
}

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
    
    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _indicatorView.center = self.view.center;
    _indicatorView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:_indicatorView];
    [_indicatorView startAnimating];
    
    
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


/**
 * Sent by the default notification center whenever the player's state has changed.
 * \details Discussion The value of aNotification is always an VLCMediaPlayerStateChanged notification. You can retrieve
 * the VLCMediaPlayer object in question by sending object to aNotification.
 */
- (void)mediaPlayerStateChanged:(NSNotification *)aNotification {
    VLCMediaPlayerState currentState = _mediaPlayer.state;
    if (currentState == VLCMediaPlayerStateBuffering) {
        NSLog(@"=============buffering===============");
    } else if (currentState == VLCMediaPlayerStatePlaying) {
        NSLog(@"=============playing===============");
    } else {
        NSLog(@"=============others===============");
    }
}
/**
 * Sent by the default notification center whenever the player's time has changed.
 * \details Discussion The value of aNotification is always an VLCMediaPlayerTimeChanged notification. You can retrieve
 * the VLCMediaPlayer object in question by sending object to aNotification.
 */
- (void)mediaPlayerTimeChanged:(NSNotification *)aNotification {
    if (_mediaPlayer.time.intValue > 0) {
        [_indicatorView stopAnimating];
        [_indicatorView removeFromSuperview];
    }
//    NSLog(@"timeChanged:%d", _mediaPlayer.time.intValue);
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
