//
//  SDAddItem.m
//  UICollection_Test
//
//  Created by Sunny on 15/11/10.
//  Copyright © 2015年 Sunny. All rights reserved.
//

#import "SDAddItem.h"
#import "Masonry.h"

@implementation SDAddItem

- (instancetype)initWithFrame:(CGRect)frame{

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
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addBtn setTitle:@"+" forState:UIControlStateNormal];
    self.addBtn.titleLabel.font = [UIFont systemFontOfSize:35.0];
    [self.addBtn addTarget:self action:@selector(clickAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.addBtn];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.width.equalTo(@(self.bounds.size.width));
        make.height.equalTo(@(self.bounds.size.height));
    
    }];

}

- (void) clickAddBtn :(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(addItem:withItemRow:)]) {
        
        [self.delegate addItem:self withItemRow:self.index];
    }
    
    
}


@end
