#import "NSObject+TWGProperty.h"
#import <objc/runtime.h>

@implementation NSObject (TWGProperty)

+ (NSSet *)determineCompileTimePropertyNames
{
    NSMutableSet *propertyNames = [NSMutableSet set];
    Class subclass = self;
    while (subclass != [NSObject class]) {
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList(subclass, &propertyCount);
        for (int i = 0; i < propertyCount; i++) {
            // Get property name
            objc_property_t property = properties[i];
            const char *propertyName = property_getName(property);
            NSString *key = @(propertyName);

            // Check if there is a backing ivar
            char *ivar = property_copyAttributeValue(property, "V");
            if (ivar) {
                // Check if ivar has KVC-compliant name
                NSString *ivarName = @(ivar);
                if ([ivarName isEqualToString:key] || [ivarName isEqualToString:[@"_" stringByAppendingString:key]]) {
                    // setValue:forKey: will work
                    [propertyNames addObject:key];
                }
                free(ivar);
            }
        }
        free(properties);
        subclass = [subclass superclass];
    }
    return [NSSet setWithSet:propertyNames];
}

- (void)mergeWithObject:(NSObject *)otherObject
{
    NSSet *properties = [[self class] determineCompileTimePropertyNames];
    NSSet *otherProperties = [[otherObject class] determineCompileTimePropertyNames];

    // Only collect keys which are common to both classes
    NSMutableSet *intersectingKeys = [NSMutableSet setWithSet:properties];
    [intersectingKeys intersectSet:otherProperties];

    for (NSString *property in intersectingKeys) {
        id otherProperty = [otherObject valueForKey:property];
        if (property) {
            [self setValue:otherProperty forKey:property];
        }
    }
}

@end
