JJDXML
======

Simple XML &amp; HTML Parser

This parser based on libxml2 library converts an XML or an HTML data to
a simple NSDictionary representation

Example
=======

```objc
#import "JJDXML.h"
```
Parsing XML
```objc
NSString* xmlString = ....
NSDictionary* dictionary = [xmlString xmlValue];
```
or
```objc
NSData* xmlData = ....
NSDictionary* dictionary = [xmlData xmlValue];
```
Parsing HTML
```objc
NSString* htmlString = ....
NSDictionary* dictionary = [htmlString xmlValue];
```
or
```objc
NSData* htmlData = ....
NSDictionary* dictionary = [htmlData xmlValue];
```
Getting node name
```objc
NSString* name = dictionary.xmlName;
```
Getting node value
```objc
NSString* value = dictionary.xmlValue;
```
Getting chidren nodes
```objc
NSArray* children = dictionary.xmlChildren;
```
Getting node attributes
```objc
NSDictionary* attributes = dictionary.xmlAttributes;
```
Finding nodes by name
```objc
NSDictionary* node = [dictionary xmlNodeWithName:@"node_name"]; // first node
NSArray* nodes = [dictionary xmlNodesWithName:@"node_name"]; // all nodes with this  name
```
or
```objc
NSDictionary* node = [dictionary xmlNodeWithName:@"node_name" recursive:NO]; // first node
NSArray* nodes = [dictionary xmlNodesWithName:@"node_name" recursive:NO]; // all nodes with this name
```
