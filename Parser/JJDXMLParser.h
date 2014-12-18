//
//  JJDXMLParser.h
//  standwith
//
//  Created by Pavel A. Obischenko (jjdeluxe) on 11/12/14.
//

#import <Foundation/Foundation.h>

@interface JJDXMLParser : NSObject

- (NSDictionary*)xmlDictionaryRepresentationOfString:(NSString*)xmlString;
- (NSDictionary*)xmlDictionaryRepresentationOfData:(NSData*)xmlData;

- (NSDictionary*)htmlDictionaryRepresentationOfString:(NSString*)htmlString;
- (NSDictionary*)htmlDictionaryRepresentationOfData:(NSData*)htmlData;

@end
