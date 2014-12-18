//
//  NSString+JJDXML.m
//  standwith
//
//  Created by Pavel A. Obischenko (jjdeluxe) on 11/12/14.
//

#import "NSString+JJDXML.h"
#import "JJDXMLParser.h"

@implementation NSString (JJDXML)

- (NSDictionary*)xmlValue {
    JJDXMLParser* parser = [[JJDXMLParser alloc] init];
    return [parser xmlDictionaryRepresentationOfString:self];
}

- (NSDictionary*)htmlValue {
    JJDXMLParser* parser = [[JJDXMLParser alloc] init];
    return [parser htmlDictionaryRepresentationOfString:self];
}

@end
