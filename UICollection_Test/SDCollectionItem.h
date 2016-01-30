//
//  SDCollectionItem.h
//  UICollection_Test
//
//  Created by Sunny on 15/10/19.
//  Copyright © 2015年 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDCollectionItem;
typedef void (^clickItemBlock)(NSIndexPath *);
@protocol CollectionItemDelegate <NSObject>

- (void) collectionItem : (SDCollectionItem *)item withIndex :(NSIndexPath *)index;

@end

@interface SDCollectionItem : UICollectionViewCell

@property (nonatomic ,strong) NSString *labelName;
@property (nonatomic ,strong) UILabel *itemNameLabel;
@property (nonatomic ,strong) UIButton *deleteBtn;
@property (nonatomic ,strong) NSIndexPath *index;
@property (nonatomic ,weak) id<CollectionItemDelegate>delegate;
@property(nonatomic, copy) clickItemBlock block;

@end
