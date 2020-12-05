Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1272CFED2
	for <lists+linux-efi@lfdr.de>; Sat,  5 Dec 2020 21:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgLEU3q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Dec 2020 15:29:46 -0500
Received: from mail-eopbgr60118.outbound.protection.outlook.com ([40.107.6.118]:47490
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726298AbgLEU3p (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 5 Dec 2020 15:29:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0pZZVAW+CTGIC4/75N+pDaX4p7yzv2vKVe3xBBFhR1z9X4cEfEht07FB3SNwOXuJIWHCfD6wUsVVHbN4BmZjbSMXeDi3hceI6GSIPxhrPbLATnO31WTc91esPY7Z0jkE2tH7KSWbPb3OEtxaKOFPrs90PXb4I2X8j13Riil+gkN2zGuBTUh687kJms0uBc1Ze8kHTo2G9byWzY9qHmXE2yC0RJglNWmJvxnqOvE1Kzv4a6ADnOxTURR7dljeqVSfWD1fRPguqzjLRQDY0hdAjoolMkR0MSXka3HBQQwWvAX39CeyOszFH6zfKAagiq/Q6s3pyvwhNPheA6uSWHvxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRLuC5qtmDqnet1/0+db7CE5/CWFB5k4GFkOU3aen3Q=;
 b=CJAa6GZ3qDLfPWTy8oUjuPAmM8P5n3tHtPoKWXlQLkhtyx/1YwRNbly7RaCZLqSXYtGOHJ9ZJ8QZ4WR5T27YofLodTKvIlszKKRkwRHllzdCXQrKo4fDnaI3i94pdcgJjj2MchS9GJJ3ZiovUSfM7jcNfgHY82rlQU2Q1e2A1VRK9q88I5jAGEeYwWODafocKX8B8WVfY++fwmdcZDw16Vj1gc2uP11CMGn8S8FzSqcc+2VjChwKnqWzFph7L6+jsAu+f7Wz83cA0FXqgcTWea5BD0MKof6naOLLy1tq2jl6uqTVM8mUSIIaMEmkTKYeWQKTCaTyCkvWffyKqyusXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRLuC5qtmDqnet1/0+db7CE5/CWFB5k4GFkOU3aen3Q=;
 b=dUMO+fsA8v7dViD0g99V5sf0g8mYQguMTCQ4MTDkkuruYzYeTvhWPzxFt+nkCSz6mC1BIduyvRjIpf6YwSXlLe/iAMXgh70jb631mj/uu0tkxYGq1IHy/aL11DKzuwrSxmfxt1LLDr3ONADwBY9S12B46GRBddlRAkilPwEUtIw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Sat, 5 Dec
 2020 20:28:56 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9068:c899:48f:a8e3]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9068:c899:48f:a8e3%6]) with mapi id 15.20.3632.021; Sat, 5 Dec 2020
 20:28:56 +0000
Subject: Re: [RFC PATCH v1 07/12] efi: Replace strstarts() by
 str_has_prefix().
To:     Ard Biesheuvel <ardb@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     laniel_francis@privacyrequired.com,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
 <20201204170319.20383-8-laniel_francis@privacyrequired.com>
 <CAMj1kXEQhT_LF5FDBO3-S7pBn55wG59bQUVr2q58A4FhqodY8Q@mail.gmail.com>
 <ab769a5188394cd3379cc627d14a0222050a1367.camel@HansenPartnership.com>
 <CAMj1kXFvCZKH-Bbvu-V5-GxcTun8yz98igeFxRc1tTswbttM0w@mail.gmail.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <b0747531-c988-55f8-7be9-0d9863d3d91a@prevas.dk>
Date:   Sat, 5 Dec 2020 21:28:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAMj1kXFvCZKH-Bbvu-V5-GxcTun8yz98igeFxRc1tTswbttM0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [5.186.115.188]
X-ClientProxiedBy: AM6PR08CA0011.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::23) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (5.186.115.188) by AM6PR08CA0011.eurprd08.prod.outlook.com (2603:10a6:20b:b2::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Sat, 5 Dec 2020 20:28:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3fc9d87-5ed6-47da-8534-08d8995c6392
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:
X-Microsoft-Antispam-PRVS: <AM0PR10MB3172B84EDE9C6E4BDD156AEC93F00@AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kmVEOBv/e8Mo1uvE+v5sGb5CeOOEtEMf0NYR2i19zy/05bRjjhFK3+CDn87000DrssE8mllsqjCbDCe7KTJRMbX6AhkKkRfVcvQ1TRG9Qe3GkaMgJJgeJBDFxZyFLb4/jtDBmHNG55OHJT4UtN7glSxQRNtTvuGAVAMHZLLQhuBluA706jqPNB+233RMB6Sj7jvcmkST2+QAgO1X94nQ9rO8lHWCpLx8UoJi030tc+v7WR6NjZ8SfW7JV0AuWhLjED8P2VxfQzYjzh5UXrpJhqM5sEFww4gMBuaUry/fbe3Kws62bWL+XXFl8pWER/9ZEphHWEdocc4zfqx28V5MUpfHiCBr5i1kw1TN4S1XKcstkHgMq86k5mUXvhelkxH9vX6mcWkPHyOM7ncGcve211Q5oOCqpqvT7gxs9rT3kq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(39840400004)(366004)(376002)(110136005)(36756003)(86362001)(66556008)(66946007)(16526019)(5660300002)(66476007)(4326008)(31696002)(26005)(186003)(6486002)(83380400001)(316002)(8676002)(2906002)(8976002)(52116002)(16576012)(956004)(44832011)(31686004)(54906003)(2616005)(8936002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VXorK1MxTllDMU1xcC9yWjJEQy9yMTFycElvbm9td2pjaW0rTE5aaVB3QzZ5?=
 =?utf-8?B?SFdKSjV3c0tHRk8xc2RCV2NDdTJEbmtNM1kycDY0TGdsRWc5V242QTY0YWo1?=
 =?utf-8?B?cGhLdXJEK1piQnd6OGZDeXV5UXFoWjVVeGRTZU9BTmdodlFHb2pXeGpzbmhn?=
 =?utf-8?B?cVU3ZDJhNDFldnYxc2Rkb1RRamNNdTY0cVI0N1doVkRUdTNoRk5pY08vT0d6?=
 =?utf-8?B?THA4Tjl4blJubStFb3lRUDJKb1FMTHZvczZoVTRwR1U5YXFjUTRqdDBwekwr?=
 =?utf-8?B?MmtHNGEyQ2kxNjZoc2k4eVJHbGREeUo3YzBoTWtZNng2R2hiQ2sxMVdybkJL?=
 =?utf-8?B?TTBPMlVKbm4xNG5KcW9ERWQ4UUU3MGNTcTg2S1RLMTA2KzlXK1l5c2JqWnpL?=
 =?utf-8?B?MU1nS2d4RFBEYStpR3FiQ29XcHJBdmlPQ2FTSHE0Z3VpTnV0TGpUOTNNb1l6?=
 =?utf-8?B?KzlkUGVrT3phbGlCcDdGbVVGTnpNNHZMVXEzWWxXSGR2aU5pcmRBM202bW9a?=
 =?utf-8?B?eUU2c3E1L2R0Umt4a0xkVGQ4NEdUWDlXVDN2aG1BVTEvQ3VXamk0djV0N3Q3?=
 =?utf-8?B?RGtnMWNwWkRZbW9BSm1IUEUwU0RlQTNDZU5ZSExpNU9DeUNUS2lzM2pBOWdE?=
 =?utf-8?B?LzRQQUxtT2xZayt3S1FqMzFFelRXRnRFMFZrZzFvZWtmdkN2cmhRNDBUNTdT?=
 =?utf-8?B?QkQ1M0FMWDMxUkR4YmZMcUwvRGVsTVZoZlpqekR3K3RSRG8rVzVQN0hVOVk1?=
 =?utf-8?B?SEd3NUsrM05vcUtGNXdxMWQ1M0FXZWxpaE1iRlhLWHdxMisxeWxRbTg3MjZZ?=
 =?utf-8?B?T2pzcWhoSU1jZ3B0RXdJMStxSHdnV1VJbGJKU01razlVU0Z4aUFzZjVPL1BU?=
 =?utf-8?B?Tm5GQllzSkpaWFBNck1xMHk4VmV4Mm55bFhlMXJwMXdKMnV2SGF4djd2WW50?=
 =?utf-8?B?a0xzS052VEhnb01JeUdPYng1QWdSM3ZrNTFlY2d0N2RWOXBMMithS3ZuMW5m?=
 =?utf-8?B?Y0dNTllmaWtIQ2dMSWZ0RHFvRzdTUUd1N3J6T0NMYW0yTWhSa2NFcC92VjN1?=
 =?utf-8?B?aFJzeUtQVk9lYUgrL25qVytFZUF0YWhlR21HT01KQ0psUzBGTGVPZ3E4U296?=
 =?utf-8?B?MHIzaVVtL1NjbWZXSU9KRFdXYUlkbnJvSHk5SXdZNkV2c0k4bXZRbnp3Nlcv?=
 =?utf-8?B?cWVqM0l0Rk5INmluZy9hSXZxbmxldUVZS1hPRDRZSzYxUVVyQnBkWTdjTjgw?=
 =?utf-8?B?alhhZjJOUGY2d2pqVUJ1UDN3d1luaTdBYmNJeDVlcm5rQ2pOYXhIOUZ3NXgy?=
 =?utf-8?Q?ITi6mLpcV9ppoKLQHkFgiSqawM/brfckWf?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fc9d87-5ed6-47da-8534-08d8995c6392
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2020 20:28:56.0442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wx5+DaidcN20u2Fp2DWtWWx3LlaYOrpxwWaSZ85z3fPi+4Ue5lwDw7m2Nh/k1GToLbwipS5EMSWZXTpGFeehi14E+lKfykoXGsZpPvtLLew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3172
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 05/12/2020 20.36, Ard Biesheuvel wrote:
> On Fri, 4 Dec 2020 at 19:02, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
>>
>> On Fri, 2020-12-04 at 18:07 +0100, Ard Biesheuvel wrote:
>>> On Fri, 4 Dec 2020 at 18:06, <laniel_francis@privacyrequired.com>
>>> wrote:
>>>> From: Francis Laniel <laniel_francis@privacyrequired.com>
>>>>
>>>> The two functions indicates if a string begins with a given prefix.
>>>> The only difference is that strstarts() returns a bool while
>>>> str_has_prefix()
>>>> returns the length of the prefix if the string begins with it or 0
>>>> otherwise.
>>>>
>>>
>>> Why?
>>
>> I think I can answer that.  If the conversion were done properly (which
>> it's not) you could get rid of the double strings in the code which are
>> error prone if you update one and forget another.  This gives a good
>> example: 3d739c1f6156 ("tracing: Use the return of str_has_prefix() to
>> remove open coded numbers"). so in your code you'd replace things like
>>
>>     if (strstarts(option, "rgb")) {
>>         option += strlen("rgb");
>>         ...
>>
>> with
>>
>>     len = str_has_prefix(option, "rgb");
>>     if (len) {
>>         option += len
>>         ...
>>
>> Obviously you also have cases where strstart is used as a boolean with
>> no need to know the length ... I think there's no value to converting
>> those.
>>
> 
> This will lead to worse code being generated. strlen() is evaluated at
> build time by the compiler if the argument is a string literal, so
> your 'before' version gets turned into 'option += 3', whereas the
> latter needs to use a runtime variable.

Well, both functions are static inlines

static inline bool strstarts(const char *str, const char *prefix)
{
        return strncmp(str, prefix, strlen(prefix)) == 0;
}

static __always_inline size_t str_has_prefix(const char *str, const char
*prefix)
{
        size_t len = strlen(prefix);
        return strncmp(str, prefix, len) == 0 ? len : 0;
}

So

len = str_has_prefix()
if (len) { use len }

is essentially

if (somecondition ? some-non-zero-constant : 0) { use
some-non-zero-constant  }

which I'm fairly certain the compiler has no problem turning into

if (somecondition) { ... }

which is exactly the existing strstarts() code. So I wouldn't expect a
huge difference in generated code.

Rasmus
