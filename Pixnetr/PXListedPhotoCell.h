//
//  PXListedPhotoCell.h
//  Pixnetr
//
//  Created by vincent on 2014/08/01.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PXListedPhotoCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *mainPhotoImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) NSString *originalPageURLString;
@property (strong, nonatomic) UIButton *likeButton;
@property (strong, nonatomic) UIButton *shareButton;

@property (nonatomic) CGFloat photoRatio;

@end
