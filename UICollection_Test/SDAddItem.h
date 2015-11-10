//
//  SDAddItem.h
//  UICollection_Test
//
//  Created by Sunny on 15/11/10.
//  Copyright © 2015年 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDAddItem;

@protocol AddItemDelegate <NSObject>

- (void) addItem : (SDAddItem *)item withItemRow : (NSIndexPath *)index;

@end

@interface SDAddItem : UICollectionViewCell

@property (nonatomic ,strong) UIButton *addBtn;
@property (nonatomic ,strong) NSIndexPath *index;
@property (nonatomic ,weak) id<AddItemDelegate>delegate;

@end
