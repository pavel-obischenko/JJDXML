//
//  NSDictionary+JJDXML.m
//  standwith
//
//  Created by Pavel A. Obischenko (jjdeluxe) on 11/14/14.
//

#import "NSDictionary+JJDXML.h"
#import "JJDResultDictionaryKeys.h"

@implementation NSDictionary (JJDXML)

- (NSString*)xmlName {
    return [self objectForKey:kJJDXMLNameKey];
}

- (NSString*)xmlValue {
    return [self objectForKey:kJJDXMLValueKey];
}

- (NSDictionary*)xmlAttributes {
    return [self objectForKey:kJJDXMLAttributesKey];
}

- (NSArray*)xmlChildren {
    return [self objectForKey:kJJDXMLChildrenKey];
}

- (NSArray*)xmlNodesWithName:(NSString*)name {
    return [self xmlNodesWithName:name recursive:YES];
}

- (NSArray*)xmlNodesWithName:(NSString*)name recursive:(BOOL)recursive {
    NSMutableArray* results = [[NSMutableArray alloc] init];

    for (NSDictionary* child in self.xmlChildren) {
        if ([child.xmlName isEqualToString:name]) {
            [results addObject:child];
        }

        if (recursive) {
            [results addObjectsFromArray:[child xmlNodesWithName:name recursive:YES]];
        }
    }

    return results;
}

- (NSDictionary*)xmlNodeWithName:(NSString*)name {
    return [self xmlNodeWithName:name recursive:YES];
}

- (NSDictionary*)xmlNodeWithName:(NSString*)name recursive:(BOOL)recursive {
    return [[self xmlNodesWithName:name recursive:YES] firstObject];
}

@end
