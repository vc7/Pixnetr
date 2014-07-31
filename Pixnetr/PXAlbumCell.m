//
//  PXAlbumCell.m
//  Pixnetr
//
//  Created by vincent on 2014/08/01.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "PXAlbumCell.h"
#import "UIColor+PixnetrAdditions.h"

@implementation PXAlbumCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.authorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.bookmarkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.albumPreviewImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.typeLabel = [[SAMBadgeView alloc] initWithFrame:CGRectZero];
        
        self.avatarImageView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
        self.avatarImageView.contentMode = UIViewContentModeScaleToFill;
        
        self.titleLabel.text = @"Album Title";
        self.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        
        self.authorLabel.text = @"Author";
        self.authorLabel.textColor = [UIColor lightGrayColor];
        self.authorLabel.font = [UIFont systemFontOfSize:9];
        
        self.albumPreviewImageView.backgroundColor = [UIColor lightGrayColor];
        self.albumPreviewImageView.contentMode = UIViewContentModeScaleToFill;
        
        self.countLabel.text = @"共 10 張";
        self.countLabel.font = [UIFont systemFontOfSize:10];
        
        self.typeLabel.textLabel.text = @"不分類";
        self.typeLabel.textLabel.font = [UIFont boldSystemFontOfSize:9];
        self.typeLabel.cornerRadius = 4;
        self.typeLabel.badgeAlignment = SAMBadgeViewAlignmentRight;
        self.typeLabel.badgeColor = [UIColor pixnetrMainColor];
        
        [self addSubview:self.avatarImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.authorLabel];
        [self addSubview:self.albumPreviewImageView];
        [self addSubview:self.countLabel];
        [self addSubview:self.typeLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    self.avatarImageView.frame = (CGRect){ 5, 5, 23, 23 };
    self.titleLabel.frame = (CGRect){ CGRectGetMaxX(self.avatarImageView.frame) + 5, 5, CGRectGetWidth(self.frame) - ((23 + 5 * 2) * 2), 13 };
    self.authorLabel.frame = (CGRect){ CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame), CGRectGetWidth(self.titleLabel.frame), 10 };
    self.bookmarkButton.frame = (CGRect){ CGRectGetMaxX(self.titleLabel.frame) + 5, 5, 23, 23 };
    
    self.albumPreviewImageView.frame = (CGRect){ 0, CGRectGetMaxY(self.avatarImageView.frame) + 5, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame) };
    
    self.countLabel.frame = (CGRect){ 10, CGRectGetMaxY(self.albumPreviewImageView.frame) + 10, CGRectGetWidth(self.frame) / 2 - (10 * 2), 10 };
    self.typeLabel.frame = (CGRect){ CGRectGetMaxX(self.countLabel.frame) + 20, CGRectGetMinY(self.countLabel.frame) - 2.5, CGRectGetWidth(self.countLabel.frame), 15 };
}

@end
