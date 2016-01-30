//
//  SDCollectionHeaderV.m
//  UICollection_Test
//
//  Created by Sunny on 15/11/10.
//  Copyright © 2015年 Sunny. All rights reserved.
//

#import "SDCollectionHeaderV.h"
#import "Masonry.h"

@implementation SDCollectionHeaderV
- (instancetype)initWithFrame:(CGRect)frame{


    self = [super initWithFrame:frame];
    if (self) {
        
        [self setCustomLayout];
        
    }
    return self;
}

- (void) setCustomLayout {

    self.backgroundColor = [UIColor colorWithRed:52.f/255.f green:128.f/255.f  blue:173.f/255.f  alpha:1.0f];
    self.layer.borderWidth = 3.0;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, self.bounds.size.height)];
    self.sectionLabel.textAlignment = NSTextAlignmentLeft;
    self.sectionLabel.textColor = [UIColor whiteColor];
    self.sectionLabel.font = [UIFont fontWithName:@"Avenir Next Medium" size:18];
    
    [self addSubview:self.sectionLabel];
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn setTitle:@"+" forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btn];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.top.equalTo(@2);
        make.right.equalTo(@-5);
        make.width.equalTo(@25);
        make.height.equalTo(@25);
    
    }];
    
}

- (void) clickBtn : (UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(collectionHeaderV:withSection:)]) {
        
        [self.delegate collectionHeaderV:self withSection:sender.tag];
    }
}

@end
