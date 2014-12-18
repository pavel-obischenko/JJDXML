//
//  JJDXMLParser.m
//  standwith
//
//  Created by Pavel A. Obischenko (jjdeluxe) on 11/12/14.
//

#import "JJDXMLParser.h"

#import <libxml2/libxml/parser.h>
#import <libxml2/libxml/HTMLparser.h>

NSString* const kJJDXMLNameKey = @"name";
NSString* const kJJDXMLValueKey = @"value";
NSString* const kJJDXMLAttributesKey = @"attributes";
NSString* const kJJDXMLChildrenKey = @"children";

@implementation JJDXMLParser

- (NSDictionary*)xmlDictionaryRepresentationOfString:(NSString*)xmlString {
    const char* buf = [xmlString UTF8String];
    return [self xmlDictionaryFromBuffer:buf length:strlen(buf)];
}

- (NSDictionary*)xmlDictionaryRepresentationOfData:(NSData*)xmlData {
    return [self xmlDictionaryFromBuffer:[xmlData bytes] length:[xmlData length]];
}

- (NSDictionary*)htmlDictionaryRepresentationOfString:(NSString*)htmlString {
    const char* buf = [htmlString UTF8String];
    return [self htmlDictionaryFromBuffer:buf length:strlen(buf)];
}

- (NSDictionary*)htmlDictionaryRepresentationOfData:(NSData*)htmlData {
    return [self htmlDictionaryFromBuffer:[htmlData bytes] length:[htmlData length]];
}

- (NSDictionary*)xmlDictionaryFromBuffer:(const char*)buf length:(int)length {
    NSDictionary* result = nil;

    if (buf && length) {
        xmlDocPtr xmlDoc = xmlParseMemory(buf, length);
        if (xmlDoc) {
            result = [self dictionatryFromXmlNode:xmlDocGetRootElement(xmlDoc)];
        }

        xmlFreeDoc(xmlDoc);
        xmlCleanupParser();
    }

    return result ? result : @{};
}

- (NSDictionary*)htmlDictionaryFromBuffer:(const char*)buf length:(int)length {
    NSDictionary* result = nil;

    if (buf && length) {
        xmlDocPtr xmlDoc = htmlReadMemory(buf, length, "", NULL, HTML_PARSE_NOWARNING | HTML_PARSE_NOERROR);
        if (xmlDoc) {
            result = [self dictionatryFromXmlNode:xmlDocGetRootElement(xmlDoc)];
        }

        xmlFreeDoc(xmlDoc);
        xmlCleanupParser();
    }

    return result ? result : @{};
}

- (NSDictionary*)dictionatryFromXmlNode:(xmlNode*)node {
    NSMutableDictionary* nodeDictionary = [NSMutableDictionary dictionary];

    if (node && node->name && node->type == XML_ELEMENT_NODE) {
        [nodeDictionary addEntriesFromDictionary:[self parseNodeName:node]];
        [nodeDictionary addEntriesFromDictionary:[self parseNodeAttributes:node]];

        NSDictionary* childrenDict = [self parseNodeChildren:node];
        [nodeDictionary addEntriesFromDictionary:childrenDict];
        if (![childrenDict count]) {
            [nodeDictionary addEntriesFromDictionary:[self parseNodeValue:node]];
        }
    }

    return (NSDictionary *)nodeDictionary;
}

- (NSDictionary*)parseNodeName:(xmlNode*)node {
    return @{kJJDXMLNameKey : [NSString stringWithCString:(const char*)node->name encoding:NSUTF8StringEncoding]};
}

- (NSDictionary*)parseNodeValue:(xmlNode*)node {
    xmlChar* value = xmlNodeGetContent(node);
    NSString* valueStr = [NSString stringWithCString:(char*)value encoding:NSUTF8StringEncoding];

    NSDictionary* resultDict = [NSDictionary dictionaryWithObject:valueStr ? valueStr : @"" forKey:kJJDXMLValueKey];
    xmlFree(value);

    return resultDict;
}

- (NSDictionary*)parseNodeAttributes:(xmlNode*)node {
    NSMutableDictionary *attributesDict = [NSMutableDictionary dictionary];

    for (xmlAttr* attribute = node->properties; attribute && attribute->name && attribute->children; attribute = attribute->next) {
        xmlChar* value = xmlNodeListGetString(node->doc, attribute->children, 1);

        NSString* attributeValue = [NSString stringWithCString:(const char*)value encoding:NSUTF8StringEncoding];
        NSString* attributeKey = [NSString stringWithCString:(const char*)attribute->name encoding:NSUTF8StringEncoding];

        if (attributeKey && attributeValue) {
            [attributesDict setObject:attributeValue forKey:attributeKey];
        }

        xmlFree(value);
    }

    return @{kJJDXMLAttributesKey : attributesDict};
}

- (NSDictionary*)parseNodeChildren:(xmlNode*)node {
    NSMutableArray *children = [NSMutableArray array];

    for (xmlNode* child = node->children; child; child = child->next) {
        NSDictionary *childDict = [self dictionatryFromXmlNode:child];
        if ([childDict count]) {
            [children addObject:childDict];
        }
    }

    return [children count] ? @{kJJDXMLChildrenKey : children} : @{};
}

@end
