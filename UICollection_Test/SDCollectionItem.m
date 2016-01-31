//
//  SDCollectionItem.m
//  UICollection_Test
//
//  Created by Sunny on 15/10/19.
//  Copyright © 2015年 Sunny. All rights reserved.
//

#import "SDCollectionItem.h"

@interface SDCollectionItem()

@property (nonatomic ,weak) UILabel *itemNameLabel;
@property (nonatomic ,weak) UIButton *deleteBtn;

@end

@implementation SDCollectionItem

- (instancetype)initWithFrame:(CGRect)frame {
    
    if ([super initWithFrame:frame]) {
        [self setCustomLayout];
    }    
    return self;
}

- (void) setCustomLayout {
    
    self.backgroundColor = KItemBackgroudColor;
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    /** item 名字 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.center = self.contentView.center;
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = KNormalItemFontNameSize;
    nameLabel.textAlignment = NSTextAlignmentCenter;

    [self.contentView addSubview:nameLabel];
    self.itemNameLabel = nameLabel;
    [self.itemNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(0);
        make.center.equalTo(self);
    }];
    
    /** 删除按钮 */
    UIButton *btn = [[UIButton alloc] init];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(clickDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
    self.deleteBtn = btn;
    [self.deleteBtn makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(0);
        make.top.equalTo(0);
        make.size.equalTo(self);
    }];
}

- (void) clickDeleteBtn : (UIButton *)sender {

    if (_block) _block(self.index);
}

- (void)setLabelName:(NSString *)labelName {
    
    self.itemNameLabel.text = labelName;
}

@end
