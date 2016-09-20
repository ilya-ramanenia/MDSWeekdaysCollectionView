//
//  MDSWeekdayCollectionViewCell.h
//  ModusApp
//
//  Created by Alexey Korotkov on 12.4.16.
//  Copyright © 2016 modus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSCalendar+MDSWeekdaysMask.h"

@interface MDSWeekdayCollectionViewCell : UICollectionViewCell

- (void)reuseWithWeekDay:(NSInteger)weekDay
                selected:(BOOL)selected
        oneLetterWeekday:(BOOL)oneLetterWeekday
              customFont:(UIFont *)customFont
   customBackgroundColor:(UIColor *)customBackgroundColor;

@end
