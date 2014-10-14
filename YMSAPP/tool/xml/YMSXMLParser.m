//
//  YMSXMLParser.m
//  YMS_GXZ_HTTP
//
//  Created by gaoxuzhao on 14/8/21.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import "YMSXMLParser.h"




@implementation YMSXMLParser


+(NSString*)stringParserXmldatefor:(NSString*)stringdata xmlelement:(NSString*)element
{
    
    NSString *result;
    
    if(stringdata&&element)
    {
        
        char *xmldata=[stringdata  cStringUsingEncoding:NSUTF8StringEncoding];
        
        int size=strlen(xmldata);
        
        xmlTextReaderPtr  reader=xmlReaderForMemory(xmldata,size, NULL, "utf-8", 0);
        
        if(!reader)
        {
            
            NSLog(@"reder不存在");
            
        }
        else
        {
            char*temp;
            NSString*currentElementValue=nil;
            NSString *elementName=nil;
            
            while (YES) {
                if(!xmlTextReaderRead(reader))
                    break;
                if(xmlTextReaderNodeType(reader)==XML_READER_TYPE_ELEMENT)
                {
                    temp=(char*)xmlTextReaderConstName(reader);
                    elementName=[NSString  stringWithCString:temp encoding:NSUTF8StringEncoding];
                    
                    if([elementName isEqualToString:element])
                    {
                        temp=(char*)xmlTextReaderReadString(reader);
                        currentElementValue=[NSString stringWithCString:temp encoding:NSUTF8StringEncoding];
                        
                        result=currentElementValue;
                        
                    }
                    
                }
            
            }
         
            
            
        }
        
        
        xmlTextReaderClose(reader);
        xmlFreeTextReader(reader);
    }
    
    
   
    
    return result;
    
}


+(NSDictionary*)parserXmldate:(NSString*)stringdata xmlelement:(NSString*)element
{
    
    
    
    NSString *result;
    
    if(stringdata&&element)
    {
        
        char *xmldata=[stringdata  cStringUsingEncoding:NSUTF8StringEncoding];
        
        int size=strlen(xmldata);
        
        xmlTextReaderPtr  reader=xmlReaderForMemory(xmldata,size, NULL, "utf-8", 0);
        
        if(!reader)
        {
            
            NSLog(@"reder不存在");
            
        }
        else
        {
            char*temp;
            NSString*currentElementValue=nil;
            NSString *elementName=nil;
            
            while (YES) {
                if(!xmlTextReaderRead(reader))
                    break;
                if(xmlTextReaderNodeType(reader)==XML_READER_TYPE_ELEMENT)
                {
                    temp=(char*)xmlTextReaderConstName(reader);
                    elementName=[NSString  stringWithCString:temp encoding:NSUTF8StringEncoding];
                    
                    if([elementName isEqualToString:element])
                    {
                        temp=(char*)xmlTextReaderReadString(reader);
                        currentElementValue=[NSString stringWithCString:temp encoding:NSUTF8StringEncoding];
                        
                        result=currentElementValue;
                        
                    }
                    
                }
                
            }
            
            
            
        }
        
        
        xmlTextReaderClose(reader);
        xmlFreeTextReader(reader);
    }
    
    NSData *jsondata=[result  dataUsingEncoding:NSUTF8StringEncoding];
   
    
    
    NSDictionary*dicResult=  [NSJSONSerialization  JSONObjectWithData:jsondata options:0 error:nil];
    
    
    
    return dicResult;
    
    
}
@end
