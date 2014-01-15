//
//  PlayerViewController.h
//  TestVLC
//
//  Created by wangbo on 1/15/14.
//  Copyright (c) 2014 wangbo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TopBarView.h"

#import "VLCMediaPlayer.h"

@interface PlayerViewController : UIViewController<TopBarViewDelegate,VLCMediaPlayerDelegate>

@property (nonatomic, strong) NSString *URL;

@end
