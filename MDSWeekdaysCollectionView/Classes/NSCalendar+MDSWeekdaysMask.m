//
//  NSCalendar+MDSWeekdaysMask.m
//  ModusApp
//
//  Created by Alexey Korotkov on 26.4.16.
//  Copyright © 2016 modus. All rights reserved.
//

#import "NSCalendar+MDSWeekdaysMask.h"

static NSString * const MDSWeekdaysLocale = nil;

@implementation NSCalendar (MDSWeekdaysMask)

+ (instancetype)sharedGregorianCalendar {
    static dispatch_once_t pred;
    static NSCalendar *calendar = nil;
    dispatch_once(&pred, ^{
        calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    });
    return calendar;
}

+ (void)setWeekdaysLocale:(NSLocale *)locale {
    [[[self class] sharedGregorianCalendar] setLocale:locale];
}

+ (NSArray <NSString *> *)weekdayNames {
    return [NSCalendar sharedGregorianCalendar].weekdaySymbols;
}

+ (NSArray <NSString *> *)shortWeekdayNames {
    return [NSCalendar sharedGregorianCalendar].shortWeekdaySymbols;
}

+ (NSArray <NSString *> *)veryShortWeekdayNames {
    return [NSCalendar sharedGregorianCalendar].veryShortWeekdaySymbols;
}

+ (u_int8_t)weekdayMaskFromWeekdaysArray:(NSArray <NSString *> *)weekdaysArray {
    u_int8_t weekdayMask = 0;
    
    for (NSString *weekdayName in weekdaysArray) {
        NSInteger weekday = [[self weekdayNames] indexOfObject:weekdayName.capitalizedString];
        weekdayMask |= 1 << weekday;
    }
    
    return weekdayMask;
}

+ (NSArray <NSString *> *)weekdaysForMask:(u_int8_t)mask {
    NSArray <NSString *> *weekdayNames = [NSCalendar sharedGregorianCalendar].weekdaySymbols;
    
    NSMutableArray *currentWeekdaysArray = [NSMutableArray arrayWithCapacity:weekdayNames.count];
    
    for (NSInteger i = 0; i < weekdayNames.count; i++) {
        if (mask & 1 << i) {
            [currentWeekdaysArray addObject:weekdayNames[i].lowercaseString];
        }
    }
    return [currentWeekdaysArray copy];
}

+ (BOOL)weekdaysMask:(MDSWeekdaysMask)mask containsDay:(NSInteger)day {
    if (day < 1 || day > 7) {
        return NO;
    }
    return mask & (1 << day);
}

+ (void)weekdaysMask:(MDSWeekdaysMask *)mask addDay:(NSInteger)day {
    *mask = *mask | (1 << day);
}

+ (void)weekdaysMask:(MDSWeekdaysMask *)mask removeDay:(NSInteger)day {
    if ([[self class] weekdaysMask:*mask containsDay:day]) {
        *mask = *mask | (1 ^ day);
    }
}

+ (NSUInteger)weekdaysMaskDaysCount:(MDSWeekdaysMask)mask {
    MDSWeekdaysMask maskToCount = mask;
    NSUInteger count = 0;
    while (maskToCount != 0) {
        if (maskToCount & 1) {
            count++;
        }
        maskToCount >>= 1;
    }
    return count;
}

@end
