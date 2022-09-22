Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07DC5E5B23
	for <lists+linux-efi@lfdr.de>; Thu, 22 Sep 2022 08:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiIVGMZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Sep 2022 02:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIVGMW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Sep 2022 02:12:22 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2086.outbound.protection.outlook.com [40.107.105.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773E1B5170;
        Wed, 21 Sep 2022 23:12:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QH4R5pE22SQBtZ+8Sd0Isy9wFtcvniXleZCUbOnyJwBtEuSRFyoqrCf57Fux1+nwvosUXsOoZUnKIl4/7rawrItBT42pyGYO7BuAJ9FvCuewmcNM+BRxlbFd9XYNp09dPjAWZ83ccykNDFrbkyDIr4wmQElhz0M6bUcdu+EI7s8SLkX4G8HGt8j5sSS0gya/u5M7hJaolFjlGCmpHpd17MYq0EkszIS/+qlb+eZDSLV3xcLeoiViRlQVKL7CcxXt2yBj6LNlMYZmTX+Ehg+nq9C8SDQOUiPZtwmQ2vZPokJrwdrT4zfAhbh/Erz36opoBDi+E2ve0SBsrMXVJR8H4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WOUVXNLFDX+WoE27T33pXzOWdL2eC2PH3pSXbEjyGc=;
 b=eFx1bV+DFc63eP/OIuThfA6YuYQWYHe7QrOGJLuDI7pqGrGBYHMnynQf6FE49IH7IG4twob1j5nSPPp0EyNYrBeFLDqbGGcskuWOos+n+lKX2wIdLMOrM9o9Hgip1NUNue7TR0nXMpc6y3GXHmka7YafnX4b85abSKSMoVZA6z3xRC+PyOPfu62Ie5oYZir8rOetb2LQXNlqLqFPEFEb8oxPxfjtUCWgnFM+DnJWOYMfg0PLJWvbyRHndtIF+deq5VMTjbAUgU+3j1A2nLEiexRz9XRylK/7bx20Ae3Q6CmP5izvz+HYjTjrWp2KpUyl+E8/ery1VUxgZpUXgQyoUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WOUVXNLFDX+WoE27T33pXzOWdL2eC2PH3pSXbEjyGc=;
 b=5W3IfmBRT94noBjldJd+UXIt5hnEX3ZSnwU+UUoOiou2BxEZSlnup2jkyfSsLu60F8+FLaNYbI7nSIMIITPFJRcJ9ssMhJsuyjCPm+/lu563D5dq3owJVus/AbpCIKRt9zHK/pUq8vzI4Dro0watBwNzDAp44LGxiyRohKct/DIASHHOjgjZJ6eqhYSszaS9Lcy6eOYC6ci/O4/PXKEVAvFC7vnEnKkNw1mwcJiQiDmHg4cXMGZiElrqu9ONTgU8PUUkSQz9VM+dE/y5yhmb9TsT7+Hof6TTesVjuLZY8K3N4kR4n3Hw/uCUyBo/vfmUGsRTibSlQPBIGTQqMwzRRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by DU2PR04MB9211.eurprd04.prod.outlook.com (2603:10a6:10:2fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Thu, 22 Sep
 2022 06:12:16 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::358f:58dc:c0c2:1155]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::358f:58dc:c0c2:1155%7]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 06:12:16 +0000
Message-ID: <6f42a382-c5aa-ba16-f330-69a07476e2aa@suse.com>
Date:   Thu, 22 Sep 2022 08:12:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] Support ESRT in Xen dom0
Content-Language: en-US
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>, Ard Biesheuvel <ardb@kernel.org>
References: <20220919193257.2031-1-demi@invisiblethingslab.com>
 <CAMj1kXEBfJUfTQ3THqqKxsU09_S98B_TjTECKwGM0WAv_5tZaA@mail.gmail.com>
 <7930b617-d473-94dd-c7e4-33ffa19da13e@suse.com>
 <CAMj1kXEJ9d3-8xa7rkczY7ur2zDm9CjqM7u1eEdHHmPG=Oo=xA@mail.gmail.com>
 <3671fd52-6034-7149-ebe4-f7560c0dc6b0@suse.com> <Yyu1xC7Tlf9sS7Ro@itl-email>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <Yyu1xC7Tlf9sS7Ro@itl-email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0059.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::10) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|DU2PR04MB9211:EE_
X-MS-Office365-Filtering-Correlation-Id: 179652b7-3cef-462c-d480-08da9c616608
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: In0VVcVyhDGBjrQpfjJAQyLSU4kshi+Zvu0SMXAwGudG2etDyNT4Eyw/3fW2UeyIt+/1Nz/hzwaCmsCmqQkkfXnl5K99rC0QAS2jmu7t3CpgMw8QLNUQQWq3gtbZLNXqDZ+FxwlWGmOllMZ4lvjXrvYNKXE2OlSg26r6xBwQN6OQ5YlrxyhxZlLLkTMBk/dIerpbrKooSDjun0/Xg57cfie6tQVGOfxiqSE9OPPeml+5w13Eqx2OesRaEOiDS/PXrDLOGTjhvHofdpnIzGUdKWl2Z1j62qCsd0R38j65Nk00EgTdeeqDOTEGIIMYZCo7ddjJdQo9mZ9wAKkHgQ74XHwACawdD4fBaea+yzhQyaQwO/5I2aR8+gbc0TDtTE+DGw4DUnUPQjRBkuR2/E/PK70n6CywzDoSY0+cAd7WpYTdo6WufHu9eTkzJ7wLFfUEEegvko6qS+qnKYY8wLBR48NZmXLD22VUicU1XfCK+KES0WyYyIaokWz0Y8vfyujiZVKK46I37FZRwBdvVmRDKh9Oa0mZlt3JOlvXKOU/g4yCw4FVNhjSco9txALjeUhlg637One9OpIdPCGHsar7OfLNOb9zZaMWa+7GudFxpKUe0ldR4mjiWW7wdra+I5ZIcvQ2iNPRmPmoEv1RcYC3X13J1HNpDO6dFasExU6/jMJ36r17aAYjKIsNd7KP5Kh8JfprvFqCsPCz8kS5NWV99TEVGReXTbHDQ9a2OPXJc0LNIuR+IBDKk0LM/6PYAvHkKOlBOeSOdTAStQjvnKaoRJJNQIM5RV8Y+mpMXPeSZIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199015)(26005)(6512007)(53546011)(316002)(6916009)(54906003)(6486002)(478600001)(186003)(2616005)(83380400001)(31696002)(86362001)(38100700002)(6506007)(31686004)(5660300002)(2906002)(4326008)(66556008)(66946007)(41300700001)(66476007)(8936002)(8676002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTA3N2FYWEZ5dGJ2T01UMWEwd0EvU1VNbk5mQmlRNTRIRlpLMHdudEhWVmlx?=
 =?utf-8?B?TUVWVkpEbG9EOEhzSFJOdnQraUdPd3MwZkpWMVYva2ttS0E1QklVUmxld3R4?=
 =?utf-8?B?TENwcmdNdnR6Y3ZvSkVsRzlnY3ZFWXZPc01nTVlwVDA0d2I1eFN5VE0xSWV5?=
 =?utf-8?B?ZDVEWjROdGF6Qm91dlRiZS9yMjM5eVVmNGluWlVzYUxXOGRXQXZVQTBsa2hS?=
 =?utf-8?B?Ui81anlzdFUxc3pzYVZpZDJxbnB2VndNeWFJYTJSdmw0NXdQM3dwZ3hlOVFi?=
 =?utf-8?B?M1VOb0JSSmxJSklTWnNCSHIyZnEvWnNUby9pVjYrMXJHb2ZJQkw2MlVxWDdr?=
 =?utf-8?B?blNzZzlWeHc1L05tOTNqVXJ3aVBPN2dBMDJ5N3BiQUhIeGRXcExadzl6dU9C?=
 =?utf-8?B?aFIvTlpFcUJZOFlwdlk4ZGdIRzJMbDZBSXN2Rm1mWS9hUXk2dkZaeGhRVXRX?=
 =?utf-8?B?emhsalIyQUhhRk5POWNBU0N3QVpLRHArWjMxZDFkZHFPRFZXOEN5b2lmeWtp?=
 =?utf-8?B?alJWZDFqdHN6dEJVQktzZ0JUa3VZbXBnWTJqMUcrRVpJanFYMUM5V3lMaVlD?=
 =?utf-8?B?UjJXdWxLN2IwcVBGWUIzZll0VGoyUVlUOHZ1alEzTTZpOEdKRGIxVi90STZm?=
 =?utf-8?B?VXVSZXBUOE4yOHc3WlNiU1lEdWxUWnRnS0FyU0l5dmdHa2xSS05LTmRlYnVz?=
 =?utf-8?B?U2JaVkEzOXc1UW9leFRmSXN0L0pUd0trQU9TUkFKeHlFWk9sVEJYSFBndXFj?=
 =?utf-8?B?WkhJa2FLR0ZEczA4TnJuWEVvRk93QjhXWGVySzhrQVovRUttSThRcVB4ZVkr?=
 =?utf-8?B?dEpCN3hldWUyclF6TzRpVTY0RU5lV3pUbkNpb01jNmoyaFhBbHpHZDRodE51?=
 =?utf-8?B?VXlDekRSVjQzQnJjM3g4SGwwZ0s2NGZqa2c0cXBlRzN4OWFGbTFRRjdyY3Ru?=
 =?utf-8?B?bDcvdHJUajNxd2wxclplMmRKaDF3SmZHT1M2eVJvakEyT1UvbWpmNmxXdGRr?=
 =?utf-8?B?U1IrQUxYRm5YUHZZelZDb1B0ZE9aanpBeDE0YmFyUFFIQVc5UDZzVkR5eHpi?=
 =?utf-8?B?dmdJK2tzNG0vY1ZtUDZzcjB3c3JpRTY5VUFNT0IxdytKbVJ2Q2x0RkZWclVJ?=
 =?utf-8?B?c0J2Z0ZPcDR6R0U2NXAyb2lMVHdEWkEvZXNXTG96L1RhR2FaQXdlSVFyUGln?=
 =?utf-8?B?SDBHZTVmUklJcjVjTHpwcVFFNncwL1lpdmRqK3hNWGs0ZGV4NlpJbGhQMGY0?=
 =?utf-8?B?K1VVV29YVG1sMVZqU2Z0SUJtZzU3aWJtMkJrN1puczY1QkZPMlZScThXSmht?=
 =?utf-8?B?UTlGdkFnU3FrUFBWdGFFZFZ3c1FvK0RDMFBJOXJqWHJnOWZyZGhrZE5QV21r?=
 =?utf-8?B?YmkzQm14UXJZTmI3VW9uQUh3bjVnT1B2clNFZHg1VjM0MVUxZXRkKzFmTnFi?=
 =?utf-8?B?dlNaUUxJRlZnU0VZM2VSTnN3MWpNVmUwdlVrZGw2SDdrYUhxVm5LSDZ4aUxN?=
 =?utf-8?B?UkoyeWRuSmFUZG1lRFN6ZWFWU0NTMmJKYWdQQ0NuV0F5YTNETGlpVGJJTmJZ?=
 =?utf-8?B?Rm11c2R6cENIWkVuUS9ZRVhldEpoT1lUbENVV3dSaWhtZVVJVmtQaUNIY3F2?=
 =?utf-8?B?QTFXZGFBNG9oUzRaMi9iUXFnZ0c2elkrMmNRdXMzSGV1SU1HOXlBUWFFVVVW?=
 =?utf-8?B?RmNxU3hBOHduaHBqMmhWM0g4YTZjc0QyZDRYczlHRDd5SE1WK1lrN0RrVkZE?=
 =?utf-8?B?YzhtUEJhRjNLWUZqeW9EcFh1VHhBYldlcWpHOEFsRnJFa2Y2VEZwSGFNeU83?=
 =?utf-8?B?ZXJWTlRtT1BPS3VLdjBYb0NmbUhmcE5vbG5WZE9EMnlBRmF1NTFCY2h2UU13?=
 =?utf-8?B?VitsUW5YcVlxK1BUSnlQaEE1a2xmZFFQZ0VXZ3VydHpSY3dJbFhjbUliWEtU?=
 =?utf-8?B?Tm0wK3FCZVpxS01wR0RjRitNaVBzVENxU0JOWWtGVmhyQXlMWU16R2FHbG9Z?=
 =?utf-8?B?RWZERHludU5UekhLMU9DRkZLeXR6QkhNUW9YbDJjbTEraTZJdnpYVCtYVXJu?=
 =?utf-8?B?Y1J4Lzd3ZElsczkzMHUrak4xTG9zMHVZUUI3VUhrVmt4UUh0NUx3S0R0L2No?=
 =?utf-8?Q?2ydeilN12m/CpRDHJtw9pLWfd?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179652b7-3cef-462c-d480-08da9c616608
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 06:12:16.5211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R257653LUGO8Lm7f9D0BhbDoQviJci2HabRsUUNyXdBbgr3xl5N345XHiHEkCiusWvA4SZNw0H+SoREszMmeoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9211
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 22.09.2022 03:09, Demi Marie Obenour wrote:
> On Wed, Sep 21, 2022 at 10:34:04PM +0200, Jan Beulich wrote:
>> On 20.09.2022 18:09, Ard Biesheuvel wrote:
>>> On Tue, 20 Sept 2022 at 17:54, Jan Beulich <jbeulich@suse.com> wrote:
>>>>
>>>> On 20.09.2022 17:36, Ard Biesheuvel wrote:
>>>>> On Mon, 19 Sept 2022 at 21:33, Demi Marie Obenour
>>>>> <demi@invisiblethingslab.com> wrote:
>>>>>>
>>>>>> fwupd requires access to the EFI System Resource Table (ESRT) to
>>>>>> discover which firmware can be updated by the OS.  Currently, Linux does
>>>>>> not expose the ESRT when running as a Xen dom0.  Therefore, it is not
>>>>>> possible to use fwupd in a Xen dom0, which is a serious problem for e.g.
>>>>>> Qubes OS.
>>>>>>
>>>>>> Before Xen 4.16, this was not fixable due to hypervisor limitations.
>>>>>> The UEFI specification requires the ESRT to be in EfiBootServicesData
>>>>>> memory, which Xen will use for whatever purposes it likes.  Therefore,
>>>>>> Linux cannot safely access the ESRT, as Xen may have overwritten it.
>>>>>>
>>>>>> Starting with Xen 4.17, Xen checks if the ESRT is in EfiBootServicesData
>>>>>> or EfiRuntimeServicesData memory.  If the ESRT is in EfiBootServicesData
>>>>>> memory, Xen allocates some memory of type EfiRuntimeServicesData, copies
>>>>>> the ESRT to it, and finally replaces the ESRT pointer with a pointer to
>>>>>> the copy.  Since Xen will not clobber EfiRuntimeServicesData memory,
>>>>>> this ensures that the ESRT can safely be accessed by the OS.  It is safe
>>>>>> to access the ESRT under Xen if, and only if, it is in memory of type
>>>>>> EfiRuntimeServicesData.
>>>>>>
>>>>>
>>>>> Thanks for the elaborate explanation. This is really helpful.
>>>>>
>>>>> So here, you are explaining that the only way for Xen to prevent
>>>>> itself from potentially clobbering the ESRT is by creating a
>>>>> completely new allocation?
>>>>
>>>> There are surely other ways, e.g. preserving BootServices* regions
>>>> alongside RuntimeServices* ones. But as the maintainer of the EFI
>>>> code in Xen I don't view this as a reasonable approach.
>>>
>>> Why not?
>>
>> Because it's against the intentions the EFI has (or at least had)
>> for this memory type. Much more than EfiAcpiReclaimMemory this
>> type is intended for use as ordinary RAM post-boot.
> 
> What about giving that memory to dom0?  dom0’s balloon driver will give
> anything dom0 doesn’t wind up using back to Xen.

While perhaps in principle possible, this would require special casing
in Xen. Except for the memory the initrd comes in, we don't directly
hand memory to Dom0. Instead everything goes through the page allocator
first. Plus if we really were convinced boot services memory needed
retaining, then it would also need retaining across kexec (and hence
shouldn't be left to Dom0 to decide what to do with it).

Jan
