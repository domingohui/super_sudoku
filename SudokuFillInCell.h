//
//  SudokuFillInCell.h
//  Sudoku
//
//  Created by Domingo on 2013-05-31.
//  Copyright (c) 2013 Domingo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SudokuFillInCell : UICollectionViewCell

@property int column, row;//start with top left(1,1) to (9,9)
@property (weak, nonatomic) IBOutlet UIButton *button;
- (IBAction)setCellNumber:(id)sender;

@end
