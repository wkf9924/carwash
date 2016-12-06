//
//  BZEntityHelper.m
//  Merchant
//
//  Created by behring on 15/9/8.
//  Copyright (c) 2015年 Ivan. All rights reserved.
//

#import "BZModelHelper.h"
#import <objc/runtime.h>
@implementation BZModelHelper
+ (void) dictionaryToEntity:(NSDictionary *)dict entity:(NSObject*)entity
{
    if (dict && entity) {
        
        for (NSString *keyName in [dict allKeys]) {
            //构建出属性的set方法
            NSString *firstChar = [keyName substringWithRange:NSMakeRange(0,1)];
            NSString *uperChar = [firstChar uppercaseString];
            NSMutableString *newKeyName = [NSMutableString stringWithString:keyName];
            [newKeyName replaceCharactersInRange:NSMakeRange(0,1) withString:uperChar];
            
            NSString *destMethodName = [NSString stringWithFormat:@"set%@:",newKeyName];
            SEL destMethodSelector = NSSelectorFromString(destMethodName);
            
            if ([entity respondsToSelector:destMethodSelector]) {
                [entity performSelector:destMethodSelector withObject:[dict objectForKey:keyName]];
            }
            
        }//end for
        
    }//end if
}

+ (NSDictionary *) entityToDictionary:(id)entity
{
    
    Class clazz = [entity class];
    u_int count;
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray* valueArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
    {
        objc_property_t prop=properties[i];
        const char* propertyName = property_getName(prop);
        
        [propertyArray addObject:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
        id value = [entity performSelector:NSSelectorFromString([NSString stringWithUTF8String:propertyName])];
        if(value ==nil)
            [valueArray addObject:[NSNull null]];
        else {
            [valueArray addObject:value];
        }
    }
    
    free(properties);
    
    NSDictionary* returnDic = [NSDictionary dictionaryWithObjects:valueArray forKeys:propertyArray];    
    return returnDic;
}

@end
