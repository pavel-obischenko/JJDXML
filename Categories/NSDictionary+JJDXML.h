//
//  NSDictionary+JJDXML.h
//  standwith
//
//  Created by Pavel A. Obischenko (jjdeluxe) on 11/14/14.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JJDXML)

@property (nonatomic, strong, readonly) NSString* xmlName;
@property (nonatomic, strong, readonly) NSString* xmlValue;
@property (nonatomic, strong, readonly) NSDictionary* xmlAttributes;
@property (nonatomic, strong, readonly) NSArray* xmlChildren;

- (NSDictionary*)xmlNodeWithName:(NSString*)name;
- (NSDictionary*)xmlNodeWithName:(NSString*)name recursive:(BOOL)recursive;

- (NSArray*)xmlNodesWithName:(NSString*)name;
- (NSArray*)xmlNodesWithName:(NSString*)name recursive:(BOOL)recursive;

@end
