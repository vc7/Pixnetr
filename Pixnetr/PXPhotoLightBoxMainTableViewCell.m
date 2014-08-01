//
//  PXPhotoLightBoxMainTableViewCell.m
//  Pixnetr
//
//  Created by vincent on 2014/08/01.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "PXPhotoLightBoxMainTableViewCell.h"

@implementation PXPhotoLightBoxMainTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.mainImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        [self addSubview:self.mainImageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.mainImageView.frame = (CGRect){ 0, 0, CGRectGetWidth(self.frame),  CGRectGetWidth(self.frame)/self.photoRatio};
    
    CGRect frame = self.mainImageView.frame;
}

@end
