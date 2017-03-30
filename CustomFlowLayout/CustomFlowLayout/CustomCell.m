//
//  CustomCell.m
//  CustomFlowLayout
//
//  Created by 김민아 on 2017. 3. 29..
//  Copyright © 2017년 김민아. All rights reserved.
//

#import "CustomCell.h"
#define STANDARD_DEVICE_WIDTH                                       414.0f
#define DEVICE_WIDTH                                                [UIScreen mainScreen].bounds.size.width
#define WRATIO_WIDTH(w)                                             (w/3.0f) / STANDARD_DEVICE_WIDTH * DEVICE_WIDTH
#define CELL_WIDTH                                                  ( DEVICE_WIDTH - (COLUMN_COUNT + 1) * CELL_MARGIN ) / COLUMN_COUNT

#define CELL_MARGIN                                                 5.0f
#define COLUMN_COUNT                                                4


@interface CustomCell ()

@end

@implementation CustomCell

- (void)awakeFromNib
{
    [super awakeFromNib];

}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.clearsContextBeforeDrawing = YES;
    self.contentView.clearsContextBeforeDrawing = YES;
}

#pragma mark - Private Method

- (void)addViewWithList:(NSArray *)array pageIndex:(NSInteger)pageIndex
{
    // 초기 x,y좌표 위 앞 마진을 제외한 부분부터 시작
    CGFloat originX = CELL_MARGIN;
    CGFloat originY = CELL_MARGIN;
    
    CGFloat cellWidth = CELL_WIDTH;
    CGFloat cellHeight = cellWidth;
    
    for (int i = 0; i < array.count; i++)
    {
        CGRect viewFrame = CGRectZero;

        NSInteger index = i % COLUMN_COUNT;
        
        // index는 0부터 시작하기 때문에 column count로 나눴을 때
        // 나머지가 column count 보다 1작은 수가 아닐 때는
        // x좌표의 값만 증가
        // column count - 1 일 때는 y좌표의 값 증가, x좌표 값 초기화
        if(index != COLUMN_COUNT - 1)
        {
            viewFrame = CGRectMake(originX, originY, cellWidth, cellHeight);
            
            originX += cellWidth + CELL_MARGIN;
        }
        else if(index == COLUMN_COUNT - 1)
        {
            viewFrame = CGRectMake(originX, originY, cellWidth, cellHeight);
            
            originX = CELL_MARGIN;
            originY += cellWidth + CELL_MARGIN;
        }
        
        UIView *view = [[UIView alloc]initWithFrame:viewFrame];
        
        view.backgroundColor = [UIColor blackColor];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, cellWidth, cellHeight)];
        
        NSInteger buttonTitle = pageIndex * 8 + i;
        
        [button setTitle:[NSString stringWithFormat:@"%zd", buttonTitle] forState:UIControlStateNormal];
        
        button.titleLabel.textColor = [UIColor whiteColor];
        
        [button addTarget:self action:@selector(didTouchButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:button];
        
        [self.contentView addSubview:view];
    }
    
}

- (void)cleanCells
{
    NSArray *subviews = self.contentView.subviews;
    
    NSLog(@"subview count : %zd", subviews.count);
    
    for (UIView *view in subviews) {
        [view removeFromSuperview];
        
    }
    
}

- (void)didTouchButton:(UIButton *)button
{
    NSLog(@"didTouchButton : %@", button.titleLabel.text);
}

@end
