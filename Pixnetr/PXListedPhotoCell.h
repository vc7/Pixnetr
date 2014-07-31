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

@property (nonatomic) NSInteger likedCount;
@property (nonatomic) CGFloat photoRatio;

@end
