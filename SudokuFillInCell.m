//
//  SudokuFillInCell.m
//  Sudoku
//
//  Created by Domingo on 2013-05-31.
//  Copyright (c) 2013 Domingo. All rights reserved.
//

#import "SudokuFillInCell.h"

@implementation SudokuFillInCell

- (IBAction)setCellNumber:(id)sender {
    int number = [[(UILabel *)[self.superview viewWithTag:1000]text]intValue];//number in the invisible label
    
    if (number >= 1 && number <= 9) {//if the number is valid
        if ([self tag] == 0 || [self tag] != number) {
            //if the cell's tag is 0 --> not filled in yet
            //if the selected current number is different than the one filled in --> replace the grid num
            [self.button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i.png", number]] forState:UIControlStateNormal];
            [self setTag:number];
        }            
        else {
            [self.button setBackgroundImage:nil forState:UIControlStateNormal];
            [self setTag:0];
        }
    }
    
}

@end
