//
//  SDCollectionItem.m
//  UICollection_Test
//
//  Created by Sunny on 15/10/19.
//  Copyright © 2015年 Sunny. All rights reserved.
//

#import "SDCollectionItem.h"
#import "Masonry.h"

@interface SDCollectionItem()



@end

@implementation SDCollectionItem

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        [self setCustomLayout];
    }
    
    return self;

}

- (void) setCustomLayout {
    
    self.backgroundColor = [UIColor colorWithRed:176.f/255.f green:68.f/255.f blue:54.f/255.f alpha:1.0];
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.itemNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
    self.itemNameLabel.center = self.contentView.center;
    self.itemNameLabel.textColor = [UIColor whiteColor];
    self.itemNameLabel.font = [UIFont systemFontOfSize:24.0f];
    [self.contentView addSubview:self.itemNameLabel];
    
    self.deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.deleteBtn.backgroundColor = [UIColor clearColor];
    [self.deleteBtn addTarget:self action:@selector(clickDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.deleteBtn];
    
}

- (void) clickDeleteBtn : (UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(collectionItem:withIndex:)]) {
        [self.delegate collectionItem:self withIndex:self.index];
    }

}

@end
