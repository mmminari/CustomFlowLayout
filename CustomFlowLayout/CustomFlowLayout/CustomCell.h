//
//  CustomCell.h
//  CustomFlowLayout
//
//  Created by 김민아 on 2017. 3. 29..
//  Copyright © 2017년 김민아. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UICollectionViewCell

- (void)addViewWithList:(NSArray *)array pageIndex:(NSInteger)pageIndex;
- (void)cleanCells;


@end
