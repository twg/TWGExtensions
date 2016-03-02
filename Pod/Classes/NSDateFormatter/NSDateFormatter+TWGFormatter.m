
#import "NSDateFormatter+TWGFormatter.h"

@implementation NSDateFormatter (TWGFormatter)

+ (NSDateFormatter *)ISO8601
{
    static NSDateFormatter *sharedFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedFormatter = [[NSDateFormatter alloc] init];
        [sharedFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    });

    return sharedFormatter;
}

+ (NSDateFormatter *)UTC
{
    static NSDateFormatter *sharedFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedFormatter = [[NSDateFormatter alloc] init];
        [sharedFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    });

    return sharedFormatter;
}

@end
