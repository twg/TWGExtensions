
#import "NSDate+TimeInterval.h"

@implementation NSDate (TimeInterval)

+ (NSDate *)startOfToday
{
    return [[NSDate date] startOfDay];
}

- (NSDate *)twoWeeksAgo
{
    return [self daysAgo:14];
}

- (NSDate *)daysAgo:(NSInteger)days
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar dateByAddingUnit:NSCalendarUnitDay value:-days toDate:self options:0];
    return [date startOfDay];
}

- (NSDate *)startOfDay
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit units = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *components = [calendar components:units fromDate:self];
    return [calendar dateFromComponents:components];
}

- (NSDate *)startOfHour
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit units = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour;
    NSDateComponents *components = [calendar components:units fromDate:self];
    return [calendar dateFromComponents:components];
}

@end
