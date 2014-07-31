//
//  PXListedPhotoCell.m
//  Pixnetr
//
//  Created by vincent on 2014/08/01.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "PXListedPhotoCell.h"

@interface PXListedPhotoCell ()

@property (strong, nonatomic) CALayer *seperatorLayer;
@property (strong, nonatomic) UIImageView *heartImageView;


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
        
        self.seperatorLayer = [[CALayer alloc] init];
        self.seperatorLayer.backgroundColor = [[UIColor lightGrayColor] CGColor];
        
        [self addSubview:self.mainPhotoImageView];
        [self addSubview:self.titleLabel];
        
        [self.layer addSublayer:self.seperatorLayer];
        
    }
    return self;
}

- (void)layoutSubviews
{
    self.mainPhotoImageView.frame = (CGRect){ 0, 0, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame)/self.photoRatio };
    self.titleLabel.frame = (CGRect){ 7, CGRectGetMaxY(self.mainPhotoImageView.frame), CGRectGetWidth(self.frame), 23};
    
    self.seperatorLayer.frame = (CGRect){ 0, CGRectGetHeight(self.frame)-1, CGRectGetWidth(self.frame), 1 };
}

@end
