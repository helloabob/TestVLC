//
//  TopBarView.h
//  TestVLC
//
//  Created by mac0001 on 1/15/14.
//  Copyright (c) 2014 wangbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopBarViewDelegate;

@interface TopBarView : UIView

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) id<TopBarViewDelegate>delegate;

@end

@protocol TopBarViewDelegate <NSObject>

@required
- (void)viewDidClose;

@end
