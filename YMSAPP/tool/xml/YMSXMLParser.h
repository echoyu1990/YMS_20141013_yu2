//
//  YMSXMLParser.h
//  YMS_GXZ_HTTP
//
//  Created by gaoxuzhao on 14/8/21.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/xmlreader.h>
@interface YMSXMLParser : NSObject

+(NSString*)stringParserXmldatefor:(NSString*)stringdata xmlelement:(NSString*)element;
+(NSDictionary*)parserXmldate:(NSString*)stringdata xmlelement:(NSString*)element;

@end
