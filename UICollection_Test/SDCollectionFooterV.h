//
//  SDCollectionFooterV.h
//  UICollection_Test
//
//  Created by Sunny on 15/11/10.
//  Copyright © 2015年 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDCollectionFooterV;

@protocol CollectionFooterVDelegate <NSObject>

- (void) collectionFooterV : (SDCollectionFooterV *)footer withIndex : (NSInteger)index;

@end

@interface SDCollectionFooterV : UICollectionReusableView

@property (nonatomic ,weak) id<CollectionFooterVDelegate> delegate;
@property(nonatomic,assign) NSInteger index;

@end
