//
//  ViewController.m
//  CustomFlowLayout
//
//  Created by 김민아 on 2017. 3. 29..
//  Copyright © 2017년 김민아. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"

#define STANDARD_DEVICE_WIDTH                                       414.0f
#define DEVICE_WIDTH                                                [UIScreen mainScreen].bounds.size.width
#define WRATIO_WIDTH(w)                                             (w/3.0f) / STANDARD_DEVICE_WIDTH * DEVICE_WIDTH
#define CELL_WIDTH                                                  ( DEVICE_WIDTH - (COLUMN_COUNT + 1) * CELL_MARGIN ) / COLUMN_COUNT

#define CELL_MARGIN                                                 5.0f
#define COLUMN_COUNT                                                4


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageController;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alcHeightOfCollectionView;

@property (strong, nonatomic) NSArray *list;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellWithReuseIdentifier:@"CustomCell"];
    
    self.list = @[@"a", @"b", @"a", @"b", @"a", @"b",@"b", @"a", @"b", @"a", @"b", @"a", @"b", @"a", @"b",@"b", @"a", @"b", @"a", @"b", @"a", @"b", @"a", @"b",@"b", @"a", @"b",@"a", @"b", @"a", @"b", @"a", @"b",@"b", @"a", @"b"];
    
    
    self.alcHeightOfCollectionView.constant = [self heightOfCollectionView];
    
    self.pageController.numberOfPages = [self numberOfPagesWithList:self.list];
    
    NSLog(@"self.list count : %zd", self.list.count);
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger result = 0;
    
    result = [self numberOfPagesWithList:self.list];
    
    NSLog(@"numberOfItemsInSection : %zd", result);
    
    return result;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    CustomCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCell" forIndexPath:indexPath];
    
    // 셀은 재사용되기 때문에 셀의 아이템들을 세팅하기 전
    // 기존 subview들을 제거
    [cell cleanCells];
    
    NSArray *array = [self getListOfEightItemsWithCurrentList:self.list index:indexPath.item];
    
    [cell addViewWithList:array pageIndex:indexPath.item];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeZero;
    
    CGFloat cellHeight = [self heightOfCollectionView];
    
    size = CGSizeMake(DEVICE_WIDTH, cellHeight);
    
    return size;
}

#pragma mark - UICollectionViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
    
    [self.pageController setCurrentPage:[self currentPageOfCollectionView]];
    
}


// 페이지별로 해당 인덱스의 8개의 아이템을 가져와 담은 list
- (NSArray *)getListOfEightItemsWithCurrentList:(NSArray *)currentList index:(NSInteger)index
{
    NSMutableArray *result = [NSMutableArray array];
    
    NSInteger startIndex = index * 8;
    
    for (NSInteger i = startIndex; i < startIndex + 8; i ++)
    {
        // 구하려는 list가 현재 list의 최대 index보다 클때는 break
        if(i > currentList.count - 1)
            break;
        
        [result addObject:currentList[i]];
    }
    
    NSLog(@"imageList Count ; %zd", result.count);
    
    return (NSArray *)result;
}

// 총 페이지 수 구하기 ( 마지막 아이템까지도 출력해야함 )
- (NSInteger)numberOfPagesWithList:(NSArray *)list
{
    NSInteger result = 0;
    
    result = self.list.count / 8;
    
    if(self.list.count % 8 != 0)
    {
        result += 1;
    }
    
    return result;
}

- (CGFloat)heightOfCollectionView
{
    CGFloat result = 0.0f;
    
    result = CELL_WIDTH * 2 + CELL_MARGIN * 3;
    
    return result;
}

// collectionView의 offset으로 현재 페이지 index 리턴
- (NSInteger)currentPageOfCollectionView
{
    NSInteger result = self.collectionView.contentOffset.x / DEVICE_WIDTH ;
    
    return result;

}
@end
