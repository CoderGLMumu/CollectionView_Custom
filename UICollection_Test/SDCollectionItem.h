//
//  SDCollectionItem.h
//  UICollection_Test
//
//  Created by Sunny on 15/10/19.
//  Copyright © 2015年 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^clickItemBlock)(NSIndexPath *);

@interface SDCollectionItem : UICollectionViewCell

@property (nonatomic ,copy) NSString *labelName;
@property (nonatomic ,strong) NSIndexPath *index;
@property(nonatomic, copy) clickItemBlock block;

@end
