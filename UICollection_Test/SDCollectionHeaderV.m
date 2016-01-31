//
//  SDCollectionHeaderV.m
//  UICollection_Test
//
//  Created by Sunny on 15/11/10.
//  Copyright © 2015年 Sunny. All rights reserved.
//

#import "SDCollectionHeaderV.h"

@interface SDCollectionHeaderV()

@property (nonatomic ,weak) UIButton *btn;
@property (nonatomic ,weak) UILabel *sectionLabel;

@end

@implementation SDCollectionHeaderV
- (instancetype)initWithFrame:(CGRect)frame{


    self = [super initWithFrame:frame];
    if (self) {
        
        [self setCustomLayout];
        
    }
    return self;
}

- (void) setCustomLayout {

    self.backgroundColor = KHeaderBackgroudColor;
    self.layer.borderWidth = 3.0;
    self.layer.borderColor = [UIColor whiteColor].CGColor;

    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    label.font = KHeaderFontNameSize;
    [self addSubview:label];
    self.sectionLabel = label;
    
    [self.sectionLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(10);
        make.center.equalTo(self);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"+" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    self.btn = btn;
    
    [self.btn makeConstraints:^(MASConstraintMaker *make){
    
        make.top.equalTo(2);
        make.right.equalTo(-5);
        make.width.equalTo(25);
        make.height.equalTo(25);
    }];
    
}

- (void)setText:(NSString *)text {

    self.sectionLabel.text = text;
}

- (void)setTag:(NSInteger)index {

    self.btn.tag = index;
}

- (void) clickBtn : (UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(collectionHeaderV:withSection:)]) {
        
        [self.delegate collectionHeaderV:self withSection:sender.tag];
    }
}

@end
