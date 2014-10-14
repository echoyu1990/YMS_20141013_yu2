//
//  PartnerConfig.h
//  AlipaySdkDemo
//
//  Created by ChaoGanYing on 13-5-3.
//  Copyright (c) 2013年 RenFei. All rights reserved.
//
//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//

#ifndef MQPDemo_PartnerConfig_h
#define MQPDemo_PartnerConfig_h

//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088401030635589"
//收款支付宝账号
#define SellerID  @"ziguangguangcunchu@yahoo.cn"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @""

//商户私钥，自助生成
#define PartnerPrivKey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBANIO0hFyQSwt2gphiVLM9NlJsgvE7FdCU7EDbD+yUnQto7VZOWGMPBfLIC6uKEKZ9swzXJ2dPvkcmgNvmOA63EL2WvB1z+a039AtUA9wZ98vsXeyvpVJH9DyvtiQiJHzfaZBuGgCwIw8VZRlNGTkU2gVtqdqPXwchnNBrDPxeTl3AgMBAAECgYBImBifMOY3F22IMucbd3uS8HYYvSiUi3aS8UTiyoTWY8N08+3xuV43NtrbZxLA2abCMWnriqFtxCWx1Ep4C798wHFjGG9gONK4C2lfyGdx38emLrT4CuPicek0q3pLiRZcB4KDceM3kkLICYSpqNFR/sIv6E+uMclPuTTeFN9qoQJBAPEWGj6w8XNcty+UfVKNjuTCT3UXJjeKhL599VJ+RZU03W2YnZNvB+eqtnKJgZJnf5+vVcptv3Z84oDw6AKEoOcCQQDfDVg5PZTfpAZIh951hurhW+RLf5gINsGWWwNyrajMn+rc+sNMVBDx7rFGflGKbNHu9OBRbioRI2Ak+Hnh/EDxAkBIpFNGHoSyMPaVZJWaYUL0FMRiUJZYV+mFiGh58cg/nA04L6sTOHpWSK7uthYPqhXfZLJh602sgxawqWYPFC1zAkBWFyF5HmKqmvVt4zsio4tepggMd9fnO7MmZESFa6+eIw8UcZkVidDsgBNeQP0Z73xrvYojA+Eqsju2qUzpw2IRAkEAgJg9xyRP1p7+L2Acz35oyw147uRGqTFiRYGnChK2+SUgK4hK9QTDzHnpGiJmndJxLrdvuNGvJMoJ1gBBYquDKQ=="


//支付宝公钥
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"

#endif
