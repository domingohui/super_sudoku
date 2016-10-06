//
//  SudokuFooterView.m
//  Sudoku
//
//  Created by Domingo on 2013-06-01.
//  Copyright (c) 2013 Domingo. All rights reserved.
//

#import "SudokuFooterView.h"
#import "SudokuFillInCell.h"

@interface SudokuFooterView () 

- (BOOL)checkAll : (NSArray *)theNineNums;
- (BOOL)checkColumns : (NSArray *)cells;
- (BOOL)checkRows : (NSArray *)cells;
- (BOOL)checkGrids : (NSArray *)cells;
- (BOOL)checkSingle : (NSArray *)cells;

@end

@implementation SudokuFooterView
@synthesize startButton, checkAnsButton;

- (IBAction)setCurrentNumber:(id)sender {
    [(UILabel *)[self.superview viewWithTag:1000]setText: [NSString stringWithFormat:@"%i", [sender tag]]];
}

- (IBAction)startPlaying:(id)sender {
    BOOL atLeastOne = NO;
    
    for (SudokuFillInCell *cell in [(UICollectionView *)self.superview visibleCells]) {
        int tag = [cell tag];
        if (tag >= 1 && tag <= 9) {//if the tag is 1~9 --> filled in
            cell.button.enabled = NO;//button in the number cell is disabled since its filled in
            
            //***change pic to actual number***
            [cell.button setTitle:[NSString stringWithFormat:@"%i", tag] forState:UIControlStateNormal];
            [cell.button setBackgroundImage:nil forState:UIControlStateNormal];
            [cell.button setBackgroundColor:[UIColor blackColor]];
            [cell.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            //*********************************
            
            //at least one cell is filled in
            atLeastOne = YES;
        }
    }
    
    if (!atLeastOne)//if no cell is filled
        [[[UIAlertView alloc]initWithTitle:@"Put in something..." message:@"Hey are you a genius? Put in some numbers." delegate:nil cancelButtonTitle:@"Alright" otherButtonTitles:nil] show];
    else {
        [startButton setEnabled:NO];//disable "start" button
        [checkAnsButton setEnabled:YES];//user can check ans now
    }
}

- (IBAction)checkAns:(id)sender {
    NSArray *allCells = [(UICollectionView *)self.superview visibleCells];
    BOOL allFilledIn = YES;//indicate if all cells are filled in
   
    for (SudokuFillInCell *cell in allCells) {
        if ([cell tag] == 0) {
            //if one cell is empty
            allFilledIn = NO;
            break;
        }
    }
    
    if (allFilledIn) {
        if ([self checkAll: allCells])
            [[[UIAlertView alloc]initWithTitle:@"BINGO" message:nil delegate:nil cancelButtonTitle:@"HURRAY" otherButtonTitles: nil]show];
        else
            [[[UIAlertView alloc]initWithTitle:@"OOPS" message:nil delegate:nil cancelButtonTitle:@"Check your answer" otherButtonTitles: nil]show];
    }
    else
        [[[UIAlertView alloc]initWithTitle:@"You are not done..." message:@"Fill in all the blanks" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]show];
}

- (BOOL)checkAll : (NSArray *)cells {
    return ([self checkColumns:cells] && [self checkRows:cells] && [self checkGrids:cells]);
}

- (BOOL)checkColumns : (NSArray *)cells {
    NSMutableArray *allColumns = [[NSMutableArray alloc]initWithCapacity:9];//contains 9 arrays of cells of same column #
    
    for (int col = 1; col <= 9; col++) {
        NSMutableArray *singleColumn = [[NSMutableArray alloc]initWithCapacity:9];
        for (SudokuFillInCell *cell in cells)//look for cells with the same column #
            if (cell.column == col)
                [singleColumn addObject:cell];
        [allColumns addObject:singleColumn];
    }
    
    BOOL correct = YES;
    for (NSArray* column in allColumns) {
        if (![self checkSingle: column]) {
            correct = NO;
            break;
        }
    }
    
    return correct;
}

- (BOOL)checkRows : (NSArray *)cells {
    NSMutableArray *allRows = [[NSMutableArray alloc]initWithCapacity:9];//contains 9 arrays of cells of same row #
    
    for (int row = 1; row <= 9; row++) {
        NSMutableArray *singleRow = [[NSMutableArray alloc]initWithCapacity:9];
        for (SudokuFillInCell *cell in cells)//look for cells with the same row #
            if (cell.row == row)
                [singleRow addObject:cell];
        [allRows addObject:singleRow];
    }
    
    BOOL correct = YES;
    for (NSArray* row in allRows) {
        if (![self checkSingle: row]) {
            correct = NO;
            break;
        }
    }
    
    return correct;
}

- (BOOL)checkGrids : (NSArray *)cells {
    NSMutableArray *allGrids = [[NSMutableArray alloc]initWithCapacity:9];//contains 9 arrays of cells of same grid
    
    for (int col = 1; col <= 7; col += 3) {
        NSMutableArray *singleGrid = [[NSMutableArray alloc]initWithCapacity:9];
        for (int row = 1; row <= 7; row += 3)
            for (SudokuFillInCell *cell in cells)
                if (cell.column >= col && cell.column <= col + 2 && cell.row >= row && cell.row <= row + 2)
                    [singleGrid addObject:cell];
        [allGrids addObject:singleGrid];
    }
    
    BOOL correct = YES;
    for (NSArray* grid in allGrids) {
        if (![self checkSingle: grid]) {
            correct = NO;
            break;
        }
    }
    
    return correct;
}

- (BOOL)checkSingle : (NSArray *)cells {
     for (int i = 0; i < 9; i++)
         for (int x = i+1; x < 9; x++)
            if ([cells[i]tag] == [cells[x]tag])
                return NO;
     
     return YES;
}

@end