//
//  SudokuFooterView.h
//  Sudoku
//
//  Created by Domingo on 2013-06-01.
//  Copyright (c) 2013 Domingo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SudokuFooterView : UICollectionReusableView

- (IBAction)setCurrentNumber:(id)sender;
- (IBAction)startPlaying:(id)sender;
- (IBAction)checkAns:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *checkAnsButton;




@end
