//
//  MDSWeekdayCollectionViewCell.m
//  ModusApp
//
//  Created by Alexey Korotkov on 12.4.16.
//  Copyright © 2016 modus. All rights reserved.
//

#import "MDSWeekdayCollectionViewCell.h"

@interface MDSWeekdayCollectionViewCell ()

@property (weak, nonatomic) UILabel *weekdayAbbreviationLabel;

@end

@implementation MDSWeekdayCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonInit];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.layer.borderWidth = 1.f;
    [self addWeekdayLabel];
}

- (void)addWeekdayLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:self.contentView.frame];
    label.numberOfLines = 1;
    label.minimumScaleFactor = 0.5;
    label.adjustsFontSizeToFitWidth = YES;
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label];
    
    self.weekdayAbbreviationLabel = label;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = self.bounds.size.width / 2;
    self.contentView.frame = self.bounds;
    
    self.weekdayAbbreviationLabel.frame = [self labelFrame];
}

- (CGRect)labelFrame {
    CGFloat offset = 4;
    
    return CGRectMake(offset, offset, CGRectGetWidth(self.bounds) - offset * 2, CGRectGetHeight(self.bounds) - offset * 2);
}

- (void)reuseWithWeekDay:(NSInteger)weekDay
                selected:(BOOL)selected
        oneLetterWeekday:(BOOL)oneLetterWeekday
              customFont:(UIFont *)customFont
   customBackgroundColor:(UIColor *)customBackgroundColor {
    
    self.weekdayAbbreviationLabel.text = [self flexibleStringForWeekday:weekDay oneLetter:oneLetterWeekday];
    self.weekdayAbbreviationLabel.font = customFont ?: [self defaultFont];
    [self.contentView setNeedsLayout];
    if (selected) {
        UIColor *color = customBackgroundColor ?: [self defaultBackfroundColor];
        self.layer.borderColor = color.CGColor;
        self.backgroundColor = color;
        self.weekdayAbbreviationLabel.textColor = [UIColor whiteColor];
    }
    else {
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.backgroundColor = [UIColor whiteColor];
        self.weekdayAbbreviationLabel.textColor = [UIColor grayColor];
    }
}

- (UIFont *)defaultFont {
    return [UIFont systemFontOfSize:12];
}

- (UIColor *)defaultBackfroundColor {
    return [UIColor colorWithRed:165.0/255.0 green:207.0/255.0 blue:66.0/255.0 alpha:1];
}

- (NSString *)flexibleStringForWeekday:(NSInteger)weekday oneLetter:(BOOL)oneLetter {
    return [oneLetter ? NSCalendar.veryShortWeekdayNames : NSCalendar.shortWeekdayNames objectAtIndex:(weekday - 1)];
}

@end
