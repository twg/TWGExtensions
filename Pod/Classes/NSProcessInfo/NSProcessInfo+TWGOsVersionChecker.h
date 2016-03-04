
#import <Foundation/Foundation.h>

@interface NSProcessInfo (Extensions)

+ (BOOL)osVersionIsAtLeastMajorVersion:(NSInteger)majorVersion
                          minorVersion:(NSInteger)minorVersion
                          patchVersion:(NSInteger)patchVersion;

@end