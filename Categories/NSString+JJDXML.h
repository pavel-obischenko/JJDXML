//
//  NSString+JJDXML.h
//  standwith
//
//  Created by Pavel A. Obischenko (jjdeluxe) on 11/12/14.
//

#import <Foundation/Foundation.h>
#import "JJDResultDictionaryKeys.h"

@interface NSString (JJDXML)

- (NSDictionary*)xmlValue;
- (NSDictionary*)htmlValue;

@end
