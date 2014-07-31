//
//  PXAlbumCell.h
//  Pixnetr
//
//  Created by vincent on 2014/08/01.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SAMBadgeView.h>

@interface PXAlbumCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *authorLabel;
@property (strong, nonatomic) UILabel *countLabel;
@property (strong, nonatomic) SAMBadgeView *typeLabel;

@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UIImageView *albumPreviewImageView;

@property (strong, nonatomic) UIButton *bookmarkButton;

@end
