//
//  MDSWeekdaysCollectionView.h
//  ModusApp
//
//  Created by Andrei Ollykainen on 9/19/16.
//  Copyright © 2016 modus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSCalendar+MDSWeekdaysMask.h"

@interface MDSWeekdaysCollectionViewFlowLayout : UICollectionViewFlowLayout
@end




@class MDSWeekdaysCollectionView;
@protocol MDSWeekdaysCollectionViewDelegate <NSObject>

@optional
- (BOOL)weekdaysCollectionView:(MDSWeekdaysCollectionView *)collectionView
           shouldSelectWeekday:(NSInteger)weekday;

- (void)weekdaysCollectionView:(MDSWeekdaysCollectionView *)collectionView
         didSelectWeekdaysMask:(MDSWeekdaysMask)weekdaysMask;

@end

@interface MDSWeekdaysCollectionView : UICollectionView

@property (nonatomic, weak) IBOutlet id <MDSWeekdaysCollectionViewDelegate> weekdaysDelegate;
@property (nonatomic) IBInspectable BOOL singleSelection;
@property (nonatomic) IBInspectable BOOL oneLetterWeekday;
@property (nonatomic) MDSWeekdaysMask weekdaysMask;
@property (strong, nonatomic) UIFont *customFont;
@property (strong, nonatomic) IBInspectable UIColor *customDayBackgroundColor;

@end
