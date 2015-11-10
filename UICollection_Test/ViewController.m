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
NSString *const KHeaderIdentifier = @"header";
NSString *const KFooterIdentifier = @"footer";

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CollectionHeaderVDelegate,AddItemDelegate,CollectionItemDelegate,CollectionFooterVDelegate>

@property (nonatomic , strong) UICollectionView *collection;
@property (nonatomic , strong) SDCollectionHeaderV *headerView;
@property (nonatomic , strong) NSMutableArray *dataArr;

@end

@implementation ViewController

- (NSMutableArray *)dataArr{

    if (_dataArr == nil) {
        
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;

}

- (instancetype)init {

    self = [super init];
    
    if (self) {
        
        SDData *data = [[SDData alloc] init];
        data.count = 1;
        [self.dataArr addObject:data];
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"CollectionView";

    self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    self.collection.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collection];
    
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
        item.delegate = self;
        return item;
        
    }else{
        
        SDCollectionItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:KCellIdentifier forIndexPath:indexPath];
        
        item.itemNameLabel.text = [NSString stringWithFormat:@"Item : %ld",indexPath.row];
        item.itemNameLabel.textAlignment = NSTextAlignmentCenter;
        item.index = indexPath;
        item.delegate = self;
        return item;
    }
    
}

#pragma mark - CollectionItemDelegate 代理

- (void) collectionItem:(SDCollectionItem *)item withIndex:(NSIndexPath *)index{

    SDData *data = self.dataArr[index.section];
    data.count--;
    
    [self.collection performBatchUpdates:^{
        [self.collection deleteItemsAtIndexPaths:@[index]];
    } completion:^(BOOL finished) {
        [self.collection reloadData];
    }];
    

}


#pragma mark - AddItemDelegate 代理
- (void)addItem:(SDAddItem *)item withItemRow:(NSIndexPath *)index{

    NSLog(@"section : %ld row :%ld",index.section,index.row);
    SDData *data = self.dataArr[index.section];
    data.count++;

    [self.collection performBatchUpdates:^{
        [self.collection insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:data.count-1 inSection:index.section]]];
    } completion:^(BOOL finished) {
        [self.collection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:data.count-1 inSection:index.section] atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
        [self.collection reloadData];
    }];
    
    
}

#pragma mark - 配置Header和Footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    UICollectionReusableView *reusableV ;
    
    if (kind == UICollectionElementKindSectionHeader) {
        
         _headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KHeaderIdentifier forIndexPath:indexPath];
        _headerView.sectionLabel.text = [NSString stringWithFormat:@"Section : %ld",indexPath.section];
        _headerView.btn.tag = indexPath.section;
        _headerView.delegate = self;
        reusableV = _headerView;
    }else{
    
        SDCollectionFooterV *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:KFooterIdentifier forIndexPath:indexPath];
        
        footer.deleteSectionBtn.tag = indexPath.section;
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
    newData.count = 1;
    [self.dataArr addObject:newData];
    
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSetWithIndex:self.dataArr.count-1];
    [self.collection insertSections:indexSet];
    
    [self.collection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:[self.dataArr indexOfObject:newData]] atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];

}


#pragma mark - UICollectionViewDelegateFlowLayout 代理
/**
 *  返回头headerView的大小
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(self.view.frame.size.width, 30);
}

/**
 *  返回头footerView的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    CGSize size = {self.view.frame.size.width,30};
    return size;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return 0.5f;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{

    return 0.f;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake((CGRectGetWidth(self.view.bounds) / 4) - 0.5,(CGRectGetWidth(self.view.bounds) / 4)-0.5);

}
@end
