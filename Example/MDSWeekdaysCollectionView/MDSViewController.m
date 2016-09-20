//
//  MDSViewController.m
//  MDSWeekdaysCollectionView
//
//  Created by Andrei Ollykainen on 09/20/2016.
//  Copyright (c) 2016 Andrei Ollykainen. All rights reserved.
//

#import "MDSViewController.h"
#import <MDSWeekdaysCollectionView/MDSWeekdaysCollectionView.h>

@interface MDSViewController () <MDSWeekdaysCollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *selectedWeekdaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *decimalMaksLabel;
@property (weak, nonatomic) IBOutlet UILabel *binaryMaskLabel;

@end

@implementation MDSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [NSCalendar setWeekdaysLocale:[NSLocale localeWithLocaleIdentifier:@"EN_us"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)getBitStringForMask:(MDSWeekdaysMask)mask {
    
    NSString *bits = @"";
    
    for(int i = 0; i < 7; i ++) {
        bits = [NSString stringWithFormat:@"%i%@", mask & (1 << i) ? 1 : 0, bits];
    }
    
    return bits;
}

#pragma mark MDSWeekdaysCollectionViewDelegate

//- (BOOL)weekdaysCollectionView:(MDSWeekdaysCollectionView *)collectionView
//           shouldSelectWeekday:(NSInteger)weekday {
//    return (weekday != 1 && weekday != 7);
//}

- (void)weekdaysCollectionView:(MDSWeekdaysCollectionView *)collectionView
         didSelectWeekdaysMask:(MDSWeekdaysMask)weekdaysMask {
    NSArray <NSString *> *weekdays = [NSCalendar weekdaysForMask:weekdaysMask];
    self.selectedWeekdaysLabel.text = @"";
    
    for (NSString *weekday in weekdays) {
        self.selectedWeekdaysLabel.text = [self.selectedWeekdaysLabel.text stringByAppendingString:weekday.capitalizedString];
        self.selectedWeekdaysLabel.text = [self.selectedWeekdaysLabel.text stringByAppendingString:@"\n"];
    }
    
    self.decimalMaksLabel.text = [NSString stringWithFormat:@"%i", weekdaysMask];
    self.binaryMaskLabel.text = [self getBitStringForMask: weekdaysMask];
}

@end
