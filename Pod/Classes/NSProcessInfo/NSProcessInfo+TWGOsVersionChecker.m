
#import "NSProcessInfo+TWGOsVersionChecker.h"

@implementation NSProcessInfo (Extensions)

+ (BOOL)osVersionIsAtLeastMajorVersion:(NSInteger)majorVersion
                          minorVersion: (NSInteger)minorVersion
                          patchVersion: (NSInteger)patchVersion
{
    NSOperatingSystemVersion currentVersion = (NSOperatingSystemVersion){majorVersion, minorVersion, patchVersion};
    return [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:currentVersion];
}

@end