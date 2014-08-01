//
//  PXListedPhotoCell.m
//  Pixnetr
//
//  Created by vincent on 2014/08/01.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "PXListedPhotoCell.h"

@interface PXListedPhotoCell ()

@property (strong, nonatomic) CALayer *panelLayer;
@property (strong, nonatomic) CALayer *seperatorLayer;


@end

@implementation PXListedPhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.mainPhotoImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.mainPhotoImageView.backgroundColor = [UIColor lightGrayColor];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        
        self.panelLayer = [[CALayer alloc] init];
        self.panelLayer.backgroundColor = [[UIColor colorWithWhite:0.95 alpha:1] CGColor];
        
        self.seperatorLayer = [[CALayer alloc] init];
        self.seperatorLayer.backgroundColor = [[UIColor colorWithWhite:0.9 alpha:1] CGColor];
        
        self.likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.likeButton setImage:[UIImage imageNamed:@"heart_gray.png"] forState:UIControlStateNormal];
        [self.likeButton setImage:[UIImage imageNamed:@"heart_red.png"] forState:UIControlStateSelected];
        
        self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.shareButton setImage:[UIImage imageNamed:@"share_gray.png"] forState:UIControlStateNormal];
        
        [self.layer addSublayer:self.panelLayer];
        [self.layer addSublayer:self.seperatorLayer];
        
        [self addSubview:self.mainPhotoImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.likeButton];
        [self addSubview:self.shareButton];
        
    }
    return self;
}

- (void)layoutSubviews
{
    self.mainPhotoImageView.frame = (CGRect){ 0, 0, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame)/self.photoRatio };
    self.titleLabel.frame = (CGRect){ 7, CGRectGetMaxY(self.mainPhotoImageView.frame), CGRectGetWidth(self.frame), 23};
    self.likeButton.frame = (CGRect){ CGRectGetWidth(self.frame) - 30, CGRectGetHeight(self.frame) - 30, 30, 30 };
    self.shareButton.frame = (CGRect){ CGRectGetWidth(self.frame) - 30 * 2, CGRectGetHeight(self.frame) - 30, 30, 30 };
    
    self.seperatorLayer.frame = (CGRect){ 0, CGRectGetHeight(self.frame)-30, CGRectGetWidth(self.frame), 1 };
    self.panelLayer.frame = (CGRect){ 0, CGRectGetHeight(self.frame)-30, CGRectGetWidth(self.frame), 30 };
}

@end
