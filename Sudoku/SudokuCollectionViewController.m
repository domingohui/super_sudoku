//
//  SudokuCollectionViewController.m
//  Sudoku
//
//  Created by Domingo on 2013-05-31.
//  Copyright (c) 2013 Domingo. All rights reserved.
//

#import "SudokuCollectionViewController.h"
#import "SudokuFillInCell.h"
#import "SudokuFooterView.h"
#import <QuartzCore/QuartzCore.h>

@interface SudokuCollectionViewController ()

@end

@implementation SudokuCollectionViewController
{
    int c, r;//column & row
}

- (void)viewDidLoad
{    
    for (int y = 180; y <= 285; y += 105) {
        //horizontal lines
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, y, self.collectionView.bounds.size.width, 1)];
        [lineView setBackgroundColor:[UIColor blackColor]];
        [self.collectionView addSubview:lineView];
    }
    
    for (int x = 106.5; x <= 213; x += 106.5) {
        //vertical lines
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(x, 70, 1, self.collectionView.bounds.size.height - 220)];
        [lineView setBackgroundColor:[UIColor blackColor]];
        [self.collectionView addSubview:lineView];
    }
    
    c = r = 1;
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SudokuFillInCell *newCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    [newCell.button.layer setBorderWidth:0.5];
    [newCell setTag:0];//tag == number in the cell. init with tag of 0 --> this cell not filled in
    newCell.column = c;
    newCell.row = r;
    
    c++;
    if (c > 9) {
        c = 1;
        r++;
    }
    
    //NSString *pos = [NSString stringWithFormat:@"%i %i", newCell.column, newCell.row];
    
    //[newCell.button setTitle: pos forState:UIControlStateNormal];
    
    
    return newCell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *supplementaryView = nil;
    
    if (kind == UICollectionElementKindSectionFooter) {
        SudokuFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer" forIndexPath:indexPath];
        
        supplementaryView = footerView;
    }
    
    return supplementaryView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 81;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(80, 5, 40, 5);
}

@end
