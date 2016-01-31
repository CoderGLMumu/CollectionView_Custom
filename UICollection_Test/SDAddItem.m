//
//  SDAddItem.m
//  UICollection_Test
//
//  Created by Sunny on 15/11/10.
//  Copyright © 2015年 Sunny. All rights reserved.
//

#import "SDAddItem.h"
#import "Masonry.h"

@interface SDAddItem ()

@property (nonatomic ,weak) UIButton *addBtn;

@end

@implementation SDAddItem

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
       [self setCustomLayout]; 
    }
    return self;
}

- (void) setCustomLayout {

    self.backgroundColor = KItemBackgroudColor;
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    
    /** 添加按钮 */
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:35.0];
    [btn setTitle:@"+" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
    self.addBtn = btn;
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.size.equalTo(self);
    }];

}

- (void) clickAddBtn :(UIButton *)sender {
    
    if (_block) _block(self.index);
}


@end
