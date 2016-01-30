//
//  SDCollectionFooterV.m
//  UICollection_Test
//
//  Created by Sunny on 15/11/10.
//  Copyright © 2015年 Sunny. All rights reserved.
//

#import "SDCollectionFooterV.h"
#import "Masonry.h"

@implementation SDCollectionFooterV

- (instancetype)initWithFrame:(CGRect)frame{
    
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setCustomLayout];
        
    }
    return self;
}

- (void) setCustomLayout {

    self.backgroundColor = [UIColor lightGrayColor];
    self.layer.borderWidth = 3.0;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.deleteSectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteSectionBtn.titleLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:20];
    self.deleteSectionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
    [self.deleteSectionBtn setTitle:@"Delete Section" forState:UIControlStateNormal];
    [self.deleteSectionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.deleteSectionBtn addTarget:self action:@selector(clickDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.deleteSectionBtn];
    
    [self.deleteSectionBtn mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.top.equalTo(@0);
        make.left.equalTo(@10);
        make.width.equalTo(@(self.bounds.size.width - 10));
        make.height.equalTo(@(self.bounds.size.height));
    }];
}


- (void) clickDeleteBtn : (UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(collectionFooterV:withIndex:)]) {
        
        [self.delegate collectionFooterV:self withIndex:sender.tag];
    }
}
@end
