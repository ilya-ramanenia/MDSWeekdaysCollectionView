//
//  MDSWeekdaysCollectionView.m
//  ModusApp
//
//  Created by Andrei Ollykainen on 9/19/16.
//  Copyright © 2016 modus. All rights reserved.
//

#import "MDSWeekdaysCollectionView.h"
#import "MDSWeekdayCollectionViewCell.h"

@implementation MDSWeekdaysCollectionViewFlowLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGSize)itemSize {
    CGFloat collectionViewItemWidth = (self.collectionView.bounds.size.width - (7 - 1) * self.minimumInteritemSpacing) / 7;
    return CGSizeMake(collectionViewItemWidth, collectionViewItemWidth);
}

@end



@interface MDSWeekdaysCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) NSMutableIndexSet *selectedWeekdaysIndexSet;

@end

@implementation MDSWeekdaysCollectionView

- (void)commonInit {
    self.singleSelection = NO;
    self.selectedWeekdaysIndexSet = [NSMutableIndexSet new];
    self.delegate = self;
    self.dataSource = self;
    
    MDSWeekdaysCollectionViewFlowLayout *layout = [MDSWeekdaysCollectionViewFlowLayout new];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 5;
    
    self.collectionViewLayout = layout;
    
    [self registerClass:[MDSWeekdayCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MDSWeekdayCollectionViewCell class])];
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

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame
           collectionViewLayout:layout];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (NSInteger)weekdayForIndexPaht:(NSIndexPath *)indexPath {
    return indexPath.row + 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MDSWeekdayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MDSWeekdayCollectionViewCell class]) forIndexPath:indexPath];
    [cell reuseWithWeekDay:[self weekdayForIndexPaht:indexPath]
                  selected:[self.selectedWeekdaysIndexSet containsIndex:indexPath.row]
          oneLetterWeekday:self.oneLetterWeekday
                customFont:self.customFont
     customBackgroundColor:self.customDayBackgroundColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger weekday = [self weekdayForIndexPaht:indexPath];
    
    if ([self.weekdaysDelegate respondsToSelector:@selector(weekdaysCollectionView:shouldSelectWeekday:)] &&
        ![self.weekdaysDelegate weekdaysCollectionView:self
                                   shouldSelectWeekday:weekday]) {
        return;
    }
    
    if ([self.selectedWeekdaysIndexSet containsIndex:indexPath.row]) {
        [self.selectedWeekdaysIndexSet removeIndex:indexPath.row];
    }
    else {
        if (self.singleSelection) {
            [self.selectedWeekdaysIndexSet removeAllIndexes];
            [self reloadData];
        }
        [self.selectedWeekdaysIndexSet addIndex:indexPath.row];
    }
    [self reloadItemsAtIndexPaths:@[indexPath]];
    if ([self.weekdaysDelegate respondsToSelector:@selector(weekdaysCollectionView:didSelectWeekdaysMask:)]) {
        [self.weekdaysDelegate weekdaysCollectionView:self
                                didSelectWeekdaysMask:self.weekdaysMask];
    }
}

- (void)setWeekdaysMask:(MDSWeekdaysMask)weekdaysMask {
    self.selectedWeekdaysIndexSet = [[NSCalendar.weekdayNames indexesOfObjectsPassingTest:^BOOL(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return [[NSCalendar weekdaysForMask:weekdaysMask] containsObject:obj.lowercaseString];
    }] mutableCopy];
}

- (MDSWeekdaysMask)weekdaysMask {
    MDSWeekdaysMask mask;
    
    MDSWeekdaysMask *maskPointer = &mask;
    
    [self.selectedWeekdaysIndexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        [NSCalendar weekdaysMask:maskPointer addDay:idx];
    }];
    
    return mask;
}

@end
