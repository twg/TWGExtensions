
#import "UIDevice+TWGDevice.h"

@implementation UIDevice (TWGDevice)

+ (BOOL)isPhone
{
    return [[self currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}

+ (BOOL)isPad
{
    return [[self currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

@end
