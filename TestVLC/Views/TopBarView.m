//
//  TopBarView.m
//  TestVLC
//
//  Created by mac0001 on 1/15/14.
//  Copyright (c) 2014 wangbo. All rights reserved.
//

#import "TopBarView.h"

@interface TopBarView() {
    UILabel *_lblTitle;
}

@end

@implementation TopBarView

- (void)setTitle:(NSString *)title {
    if (title == _title) {
        return;
    }
    [_title release];
    _title = [title retain];
    _lblTitle.text = _title;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];
        
//        UIView *viewBack = [[[UIView alloc] initWithFrame:self.bounds] autorelease];
//        viewBack.backgroundColor = [UIColor blackColor];
//        viewBack.alpha = 0.5f;
//        viewBack.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        [self addSubview:viewBack];
        
        UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, 60, 30)];
//        [btnBack setBackgroundColor:[UIColor blueColor]];
        [btnBack setTitle:@"完成" forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(btnBackTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnBack];
        [btnBack release];
        
        _lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, self.bounds.size.height)];
        _lblTitle.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        _lblTitle.textColor = [UIColor whiteColor];
        _lblTitle.center = self.center;
        [self addSubview:_lblTitle];
        [_lblTitle release];
    }
    return self;
}

- (void)btnBackTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(viewDidClose)]) {
        [self.delegate viewDidClose];
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [[UIColor blackColor] CGColor]);
    CGContextSetAlpha(ctx, 0.4f);
    CGContextFillRect(ctx, self.bounds);
    
    
    
    
}


@end
