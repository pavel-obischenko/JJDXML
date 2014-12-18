//
//  NSData+JJDXML.m
//  standwith
//
//  Created by Pavel A. Obischenko (jjdeluxe) on 11/12/14.
//

#import "NSData+JJDXML.h"
#import "JJDXMLParser.h"

@implementation NSData (JJDXML)

- (NSDictionary*)xmlValue {
    JJDXMLParser* parser = [[JJDXMLParser alloc] init];
    return [parser xmlDictionaryRepresentationOfData:self];
}

- (NSDictionary*)htmlValue {
    JJDXMLParser* parser = [[JJDXMLParser alloc] init];
    return [parser htmlDictionaryRepresentationOfData:self];
}

@end
