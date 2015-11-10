//
//  SDCollectionHeaderV.h
//  UICollection_Test
//
//  Created by Sunny on 15/11/10.
//  Copyright © 2015年 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDCollectionHeaderV;

@protocol CollectionHeaderVDelegate <NSObject>

- (void) collectionHeaderV : (SDCollectionHeaderV *)header withSection : (NSInteger)index;

@end

@interface SDCollectionHeaderV : UICollectionReusableView

@property (nonatomic ,strong) UILabel *sectionLabel;
@property (nonatomic ,strong) UIButton *btn;
@property (nonatomic ,weak) id<CollectionHeaderVDelegate>delegate;

@end
