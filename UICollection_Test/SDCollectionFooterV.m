//
//  SDCollectionFooterV.m
//  UICollection_Test
//
//  Created by Sunny on 15/11/10.
//  Copyright © 2015年 Sunny. All rights reserved.
//

#import "SDCollectionFooterV.h"

@interface SDCollectionFooterV()

@property (nonatomic ,weak) UIButton *deleteSectionBtn;

@end

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
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = kFooterFontNameSize;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
    [btn setTitle:@"Delete Section" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    self.deleteSectionBtn = btn;
    
    [self.deleteSectionBtn makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(10);
        make.center.equalTo(self);
    }];
}

- (void)setIndex:(NSInteger)index {

    self.deleteSectionBtn.tag = index;
}

- (void) clickDeleteBtn : (UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(collectionFooterV:withIndex:)]) {
        [self.delegate collectionFooterV:self withIndex:sender.tag];
    }
}
@end
