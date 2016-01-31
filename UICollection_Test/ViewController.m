//
//  ViewController.m
//  UICollection_Test
//
//  Created by Sunny on 15/10/19.
//  Copyright © 2015年 Sunny. All rights reserved.
//

#import "ViewController.h"
#import "SDCollectionItem.h"
#import "SDCollectionHeaderV.h"
#import "SDCollectionFooterV.h"
#import "SDAddItem.h"
#import "SDData.h"

NSString *const KCellIdentifier = @"NormalCell";
NSString *const KAddCellIdentifier = @"AddCell";
NSString *const KHeaderIdentifier = @"Header";
NSString *const KFooterIdentifier = @"Footer";

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CollectionFooterVDelegate,CollectionHeaderVDelegate>

@property (nonatomic , weak) UICollectionView *collection;
@property (nonatomic , strong) NSMutableArray<SDData *> *dataArr;

@end

@implementation ViewController

- (NSMutableArray<SDData *> *)dataArr{

    if (_dataArr == nil) { _dataArr = [NSMutableArray array];}
    return _dataArr;
}

- (instancetype)init {
    
    if (self = [super init]) {
        SDData *data = [[SDData alloc] init];
        data.count = kMinCount;
        [self.dataArr addObject:data];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    UILabel *titleName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 24)];
    titleName.text = @"CollectionView";
    titleName.textAlignment = NSTextAlignmentCenter;
    titleName.font = KTitleFontNameSize;
    self.navigationItem.titleView = titleName;

    UICollectionView *collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    collectionV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionV];
    self.collection = collectionV;
    
    self.collection.delegate = self;
    self.collection.dataSource = self;
    
    [self.collection registerClass: [SDCollectionItem class] forCellWithReuseIdentifier:KCellIdentifier];
    [self.collection registerClass:[SDAddItem class] forCellWithReuseIdentifier:KAddCellIdentifier];
    [self.collection registerClass:[SDCollectionHeaderV class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KHeaderIdentifier];
    [self.collection registerClass:[SDCollectionFooterV class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:KFooterIdentifier];
    
}


#pragma mark - UICollectionViewDataSource 代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return self.dataArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    SDData *data = self.dataArr[section];
    return data.count;
}

#pragma mark - 配置item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == [(SDData *)self.dataArr[indexPath.section] count] - 1) {
        
        SDAddItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:KAddCellIdentifier forIndexPath:indexPath];
        item.index = indexPath;
        item.block = ^(NSIndexPath *index) {
            
            NSLog(@"section : %zd row :%zd",index.section,index.row);
            SDData *data = self.dataArr[index.section];
            data.count++;
            
            [self.collection performBatchUpdates:^{
                [self.collection insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:data.count-1 inSection:index.section]]];
            } completion:^(BOOL finished) {
                [self.collection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:data.count-1 inSection:index.section] atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
                [self.collection reloadData];
            }];
        };
        return item;
        
    }else{
        
        SDCollectionItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:KCellIdentifier forIndexPath:indexPath];
        item.index = indexPath;
        item.labelName = [NSString stringWithFormat:@"Item : %zd",indexPath.row];

        item.block = ^(NSIndexPath *index) {
            
            SDData *data = self.dataArr[index.section];
            data.count--;
            
            [self.collection performBatchUpdates:^{
                [self.collection deleteItemsAtIndexPaths:@[index]];
            } completion:^(BOOL finished) {
                [self.collection reloadData];
            }];
        };
        return item;
    }
}

#pragma mark - 配置Header和Footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    UICollectionReusableView *reusableV ;
    
    if (kind == UICollectionElementKindSectionHeader) {
        
         SDCollectionHeaderV *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KHeaderIdentifier forIndexPath:indexPath];
        headerView.text = [NSString stringWithFormat:@"Section : %zd",indexPath.section];
        headerView.index = indexPath.section;
        headerView.delegate = self;
        reusableV = headerView;
        
    }else{
    
        SDCollectionFooterV *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:KFooterIdentifier forIndexPath:indexPath];
        
        footer.index = indexPath.section;
        footer.delegate = self;
        reusableV = footer;
    }
    return reusableV;
}

#pragma mark - CollectionFooterVDelegate 代理
- (void)collectionFooterV:(SDCollectionFooterV *)footer withIndex:(NSInteger)index {
    
    if (self.dataArr.count > 1) {
        
        NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSetWithIndex:index];
        
        [self.collection performBatchUpdates:^{
            [self.dataArr removeObjectAtIndex:index];
            [self.collection deleteSections:indexSet];
        } completion:^(BOOL finished) {
            [self.collection reloadData];
        }];
    }
}


#pragma mark - SDCollectionHeaderV 代理
- (void)collectionHeaderV:(SDCollectionHeaderV *)header withSection:(NSInteger)index{

    SDData *newData = [[SDData alloc] init];
    newData.count = kMinCount;
    [self.dataArr addObject:newData];
    
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSetWithIndex:self.dataArr.count-1];
    [self.collection insertSections:indexSet];
    
    [self.collection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:[self.dataArr indexOfObject:newData]] atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];

}

#pragma mark - UICollectionViewDelegateFlowLayout 代理
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(kScreenWidth, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(kScreenWidth, 30);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return 0.5f;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{

    return 0.f;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake((kScreenWidth / 4) - 0.5,(kScreenWidth / 4)-0.5);
}
@end
