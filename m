Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BA65BEA94
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 17:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiITPyy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 11:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiITPyx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 11:54:53 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2066.outbound.protection.outlook.com [40.107.104.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E952A41E;
        Tue, 20 Sep 2022 08:54:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGrB/c/q6xERibjOQPzcnwvP/OuzsWiW1Upj+j2MrhaDrvAts5ajO1n5eJ8dJKGlHs04/hRjwaSfXEF/J9k3mGHepyzitLkq9SJUhQBK959sd8WLxE8Zd8dydH6m31xVorHxV252BkySlzkjP5a6f7mX1hwdVzMKmxaoih4RLKneAGLYPg8l5b09//y2Dw8GhtSJFOHbapgX1P+clI9bGVKn7MsEkoM9L/m41zbDr8mxxoa9iKq3ZmBoky0t+hNQDIWxoeeHeGd2cnVbcOx5S80TaPPnTWQtjOyihQrd4mPZvEzHiwMrCHkXvuISjaBoJr16LJ27ENy8pGQe3wJhtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYxFh3csbWKrYwY/oyUVWTvkUEBGLgZw9LoiVS9asAk=;
 b=CkdlwCG+tWvRcQAVaFnIxH7OdhU4ty2USpEKAMg4e/ystd5iM5oQrMf7GxhxzyD6PakuR7NbrhR8KaIKqrc95B2Qa/HIKm7QHyo4eA/5onpnlopmV/YcmqL00vGSP6HZH0WKVLcvffepJbJDZqv29d11jeZh2ZdheVg32JqIFP/ZOONDncF4jJpK78srd1NlXLonH9DKwjGJZtbrvnJyL20g0q8tk9e43EUmZRtZqUIDyEE9fGJ33SLBfgERzaXy0bnwdEJPwClY7lhv8bsZwsDhaPq2UPDfDHGBq7fVze6nnIz8C3otbPfrMqPuzqvOMns3QWLtlXnGCH18tjsWnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYxFh3csbWKrYwY/oyUVWTvkUEBGLgZw9LoiVS9asAk=;
 b=zcP7KgnZ+SdGv9JgohBxIbeSoX/xuh7TGZv3UqH8pU6DDYqFVsjHgbSgdRsb+DG1xYmZ84IA3hK6dgfPv4Vwe0sdKcV49VTB5gv9RVMNIRBQRA3seZGW1WinoUqqxSj3rCmNEARVOwz7V3Z6XmeEUmsyw+wYMHnd/EMu+8qAiMttj4WMVQR+KIT5A5j5MCt0ITNlVYFbOXmVjPmlnKhgfN5G+7CR61cMqruHZsDTKRDTzAdtEWbpys87bO+gtg75+9FGs4M5H4hKoW2owwrnPKseYQ6KLMEsoZXaj1L/0BmpD7xpSbPeXhtJnUvoX6uXQh0VF3UUt9ait1zJEI5ztw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by DB9PR04MB8251.eurprd04.prod.outlook.com (2603:10a6:10:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 15:54:49 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::358f:58dc:c0c2:1155]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::358f:58dc:c0c2:1155%7]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 15:54:49 +0000
Message-ID: <7930b617-d473-94dd-c7e4-33ffa19da13e@suse.com>
Date:   Tue, 20 Sep 2022 17:54:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] Support ESRT in Xen dom0
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Demi Marie Obenour <demi@invisiblethingslab.com>
References: <20220919193257.2031-1-demi@invisiblethingslab.com>
 <CAMj1kXEBfJUfTQ3THqqKxsU09_S98B_TjTECKwGM0WAv_5tZaA@mail.gmail.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <CAMj1kXEBfJUfTQ3THqqKxsU09_S98B_TjTECKwGM0WAv_5tZaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0143.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::19) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|DB9PR04MB8251:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b5fb8b-0798-444d-1672-08da9b2072a8
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eg3ZR6vjg7q+RMbtDt/PYcNu6lltKHnpBKHPdpKu28GgFrzg0MS7N8lUkgptBnR6YiGPg0Pwr985MfrXRSibXPCNrSFsrtKeykidDTwPHGSqireUp2VJ8UVqkQKtf3lZ78Dy8UKqagUgfIjbXKZr/+PDyujvnqBlbqh2AUCPo0Hvm60A3CHEkiSwEQaXJM8ukM7lJOFxVtdbbrAN5PWEQC50aTUGDN2Drvd/p3dlQVsAmpfFUYZowm6SKg+1hFoKXLXwRKGbFpCfbFdjY0ONOsbnzA4swYH9DZf4CzjCuWCEH6zlUbcNItytWmJM6KYru22Cv7gcy4jONjd6XKwq3DCn2V+oqdqx962tOjnGVAg22Jhw9zUJjLN/68Yh7diWvqGV0me2OXXRF3AptkMXQ6mDE5lLEp57MEWl10iCDSQ/p1NjjROam6FmgW+zam2kj+BrR8faevMOKKLFaaKOUOvDrJ88+TXX7MhgbY2Qtt1ps0PXzqPIj6MaRLxKb6sbzJ351TtqOnbzixS6ckP6ZJ3iioRaZX3lHDGf4WrwemBhZOEcd84RGaWihrsj70WYhpcsHi+eHVy2FobHsrRjaa6r6rVgVk6g4DOHldKpi5/T3qSMA+pb6NI9Kqh/UitPgRJiNcjSkgx7SXgub1Jy5u1GF1JlebvgLUwJHedkXKZ90/vwf8tspxA9DBZ36tCw9xtm/yWXnWN5VxBm/7ChZjhP480KQzKVeTiakh1ElrnSy/7oNzBmSu41awa91DxwNBx1EekfJQiz8WpdQaTK9M+6g+p7u5TKXHbZ6qH+avQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(66476007)(8676002)(2906002)(36756003)(2616005)(38100700002)(66946007)(83380400001)(8936002)(6666004)(41300700001)(54906003)(66556008)(478600001)(186003)(31696002)(6512007)(86362001)(316002)(4326008)(6486002)(6916009)(6506007)(31686004)(53546011)(5660300002)(26005)(66899012)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NldpdHYvM0JWZnVmVFJLY2tOOWNtTk4wZ09jM2h3VEJudC9iQUY1bTJmNHFh?=
 =?utf-8?B?VWtjRlpTYkZwVDd1dUR3THhGOEFDSHRNRlZOczYzTDNxTFZ5QS9UWk1pZHgy?=
 =?utf-8?B?MDI4RXFxWU9NeWEyVXlYUkxFNFgrQ2ZLZGR4N0FTVmxISFdsdWY4ekNaNG1E?=
 =?utf-8?B?WHJmVDRDTkdNQmpPaFNFR2FGMlB2RUsySFVWUE1MSVBVdnlvZ2lyNG82UUVG?=
 =?utf-8?B?eDdUUWVaakhWVUVnRXZ5eGtZWU8zSkhQa2QvL08rMGUzUUZUTjd6RjIwWDdN?=
 =?utf-8?B?Tm0yTTByVHBQOHduUUtNa1JyVVFjM3lBWDZZejVOT0tlTHk1R1UvTFd5OGYw?=
 =?utf-8?B?RVFJWnJaZW5VSFY3cURneXgzRlU0bCsrNzBwZUh1cUNZYnlrZkNUNEZCY2g5?=
 =?utf-8?B?QTdrVVpsbHN0NzRUN2dqY3FFbGgxRWNqb3ZSVndvN2dDRlJ5TElucDdRbExt?=
 =?utf-8?B?NzFhbE03bEVqWHZGbC9QQTNlUVpGS3hqTm9vQXZpanE1aHYrVTFyd1VBMWJV?=
 =?utf-8?B?bDg2a1hyK1BQTU1oRk03ckV2ZmNKSmJmRUhLVUNzN2NpdnZxdTNJOW1DR0Jx?=
 =?utf-8?B?ajhkYUs2d3pXblJ2Q0ZjOVE1MHg3ZjV5TFR5VXBaZEVYVVg2NUZoTjVZN21m?=
 =?utf-8?B?ZFd1amRZZ1JnSjFPQWcyZTBMZlk5eUxJL2FmYk92Vk9Hd2ZNaWpVSktrNWZp?=
 =?utf-8?B?ajhzcUhNbnV6L0VITlpISVlwVWg5Rmt3aVZBZHRjdGl4T1hqQ011VnpiSk5H?=
 =?utf-8?B?Q1pyQzIxNWhzaDJ2Y2lZWmM3eThwOVd5R29QekNJQUozUk5mWVpMT3l4ODFE?=
 =?utf-8?B?bUZtbno3UHNoVm01VklsRHNpVExIakUzZVBWQUQ1YUMzc3VSa3RScVNWdDhs?=
 =?utf-8?B?MU1SRGZvY0EvS3Ztd3NPR3Raa0tLRlBoNDR3VGEzNzdWYk9SMUIxVmpWdjFU?=
 =?utf-8?B?M2VLZTlmRkJLSGo5bkNFRFA4VmZOZmxLQjB6Rmd2VzZwbGJkSWs5bk1FRWlL?=
 =?utf-8?B?UUhLMkhTK1ZzL09keTdMM0NQdm5VUExBejVzOG5nMlBaS0xnZUJWQmNOamxN?=
 =?utf-8?B?RHRXc2ZSY0pNSGl1WVppVEZLL1k1bDE4RXk3RUMrcFVZdmV1TktORFV4YWl2?=
 =?utf-8?B?aXdZd3hiQ1drL2YzbUlsL2xWRTcwTFpJd1ZPeWN5QlZGYy9weWtUejlFamwy?=
 =?utf-8?B?OWpDNFVUejQwelNrZkJhT3liSjhvQlNoaWZ6a0RzVEJhd3grRVZMaE8yNDJY?=
 =?utf-8?B?SmVhZmszeVJhZ0puSFlRdUtLUVV5c2F4RDdYNGh3TTlqcW1OVkU2N20xVTQv?=
 =?utf-8?B?eEZHZ0UrM3c5VW53clAxaGNaUWh3RUptY1lhSmtGdElnK2Nmb0N4SFVRZmh0?=
 =?utf-8?B?RFc5K1J2QndzSHJqU2pnZm9OakFENy96TmUrQW9RaEYzSWJrR2ZlSjhUVEkx?=
 =?utf-8?B?L0hTZUNmNktqWVlUU2VzQkVsYS9oYnZIZnJ5U0lDWXpvL2p0RWhzTVNNQitR?=
 =?utf-8?B?ajljdDJXa1ZRSFhQam5OakZzY0pWVlVOS0Y4MjZuVVMreG5mUmZYbXFBekw5?=
 =?utf-8?B?ZmpKOC9ORVIxbDU3MllYcWRCd1JTbW1qM2lLWDdBbWVNSUlvcG1jZ1pIbENx?=
 =?utf-8?B?b2ZjbW9RZnJwUFFPNEFsMkRuRXFqck9JSUdEWHM0QnhkNEI1dVdxUzVkV0VK?=
 =?utf-8?B?SVVVdXk0VUhxMzV1T3dwYWhJQVdMelc5VzRqR256M3RvVXM3SDZBaFFETkFF?=
 =?utf-8?B?bENTRGxjeUpIU3dqVWwvWFVCdllESDRWeVVmbVVwQVlHMkdhUlR1VEhpbENj?=
 =?utf-8?B?V25VOFVOOHJxZ2duRVBvb2FZK1dMeWdPejRMOFZwUThUT3loZ3JEUHBOZCtU?=
 =?utf-8?B?dG9nakJYc2kweXlTd2lyenhJWW1FU0ZGeUhIY3VuUWxEMXE2VzY3Rkt2QWl6?=
 =?utf-8?B?Z25MUEJCdE5UUkdvUkVjSkJjMy9lSWtRS2hoTlhma0pLam9QbFlrUWdyV01G?=
 =?utf-8?B?QXVEWVNEYXBCcGIraTFoOHpmMmNkUWhLSlVLNWExODBVWERWMjA2aDBld0Vw?=
 =?utf-8?B?Mm5vdjhYWGZFcjlXZUw0UFhMK2txbGFtZEVVcG9MWUx3OGg1MmFsdlN3bSt2?=
 =?utf-8?Q?j60YHg9NPN1J+L+Bqn76RG0LE?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b5fb8b-0798-444d-1672-08da9b2072a8
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 15:54:49.3098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QkCkoQr6QyAG65OrTFgBSPbqTwMVrrqCMJXFHjPwcko1Old0W9k6f+s5Ke6GEgbslTUR2Zv95uCay1/cSY59g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8251
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 20.09.2022 17:36, Ard Biesheuvel wrote:
> On Mon, 19 Sept 2022 at 21:33, Demi Marie Obenour
> <demi@invisiblethingslab.com> wrote:
>>
>> fwupd requires access to the EFI System Resource Table (ESRT) to
>> discover which firmware can be updated by the OS.  Currently, Linux does
>> not expose the ESRT when running as a Xen dom0.  Therefore, it is not
>> possible to use fwupd in a Xen dom0, which is a serious problem for e.g.
>> Qubes OS.
>>
>> Before Xen 4.16, this was not fixable due to hypervisor limitations.
>> The UEFI specification requires the ESRT to be in EfiBootServicesData
>> memory, which Xen will use for whatever purposes it likes.  Therefore,
>> Linux cannot safely access the ESRT, as Xen may have overwritten it.
>>
>> Starting with Xen 4.17, Xen checks if the ESRT is in EfiBootServicesData
>> or EfiRuntimeServicesData memory.  If the ESRT is in EfiBootServicesData
>> memory, Xen allocates some memory of type EfiRuntimeServicesData, copies
>> the ESRT to it, and finally replaces the ESRT pointer with a pointer to
>> the copy.  Since Xen will not clobber EfiRuntimeServicesData memory,
>> this ensures that the ESRT can safely be accessed by the OS.  It is safe
>> to access the ESRT under Xen if, and only if, it is in memory of type
>> EfiRuntimeServicesData.
>>
> 
> Thanks for the elaborate explanation. This is really helpful.
> 
> So here, you are explaining that the only way for Xen to prevent
> itself from potentially clobbering the ESRT is by creating a
> completely new allocation?

There are surely other ways, e.g. preserving BootServices* regions
alongside RuntimeServices* ones. But as the maintainer of the EFI
code in Xen I don't view this as a reasonable approach.

> What about other assets that may be passed
> via EFI boot services data regions?

These would need handling similarly then.

> So first of all, EfiRuntimeServicesData has a special purpose: it is
> used to carry data that is part of the EFI runtime service
> implementations themselves. Therefore, it has to be mapped into the
> EFI page tables by the OS kernel, and carved out of the linear map (to
> prevent inadvertent access with mismatched attributes). So unless you
> are writing the code that backs GetVariable() or SetVariable(), there
> are never good reasons to use EfiRuntimeServicesData.

That's a rather strict interpretation of the spec. Even back when
I started dealing with EFI, when it was still quite new, I know
RuntimeServices* was already used for similar purposes.

> If you want to use a memory type that is suitable for firmware tables
> that are intended for consumption by the OS only (and not by the
> runtime services themselves), you might consider EfiAcpiReclaimMemory.

Personally I consider this type less appropriate than the one we
currently use. It's intended to be used by ACPI, which doesn't
come into play here. It comes quite close to using e.g.
EfiUnusableMemory here ... We might be able to (ab)use
EfiLoaderData for this, but that would again require special
casing (inside Xen) when deciding whether the memory can be used
as general-purpose memory.

> TBH I still don't think this is a scalable approach. There are other
> configuration tables that may be passed in EFI boot services memory,
> and MS especially were pushing back in the UEFI forum on adding table
> types that were passed in anything other the EfiBootServicesData.

Within Xen we might abstract the approach currently implemented in
case more such pieces of data appear.

While I can easily believe MS might be advocating for this model,
I view it as problematic not only for Xen. How would you pass on
this information across kexec, for example, without introducing
further producer-consumer dependencies requiring separate protocols
to be followed?

Jan
