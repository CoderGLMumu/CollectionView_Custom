//
//  SDAddItem.h
//  UICollection_Test
//
//  Created by Sunny on 15/11/10.
//  Copyright © 2015年 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDAddItem;

typedef void (^clickItemBlock)(NSIndexPath *);


@interface SDAddItem : UICollectionViewCell

@property (nonatomic ,strong) UIButton *addBtn;
@property (nonatomic ,strong) NSIndexPath *index;
@property(nonatomic, copy) clickItemBlock block;

@end
