Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E435E5483
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 22:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIUUeM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 16:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIUUeL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 16:34:11 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5E17DF68;
        Wed, 21 Sep 2022 13:34:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jG2aBLkuHhRFNtjfWnGtMcFiveh2BqS+QEg2imgRNrIpEUaDPerb50S8+k5qSWfXG3Ubt0dWQd45feXws/iR3wQhdDuNFmjebgMN0+S56mbHMN1Jaz4ZR2jiwjbqrIfQVNdpM76DQ+vpCVwYBovRMjtVzvKQD3IRa4o7p4CjLh3yyd0glLVOFqYd7Q8vm91UZge4tdmVVZdGL+ZUp5AOMGtQAAEyRnIN/AbI9p2wbJfgF1DJI70ZCEYNfDzFeGAm1KEbRf9v+yUiIaJMh9xM5yBbmj743RoxgbAfKlKGVxscV3Z6x4VSCTRKjTHyb8f3Ipe1oPG7JHy62PNDKNonUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdxCv7mrQHXczZ8Wu54MQSZROOWZZozu5hVaJ4E5m38=;
 b=RbUYqbLQoeah0FY2vA6Hven5NF3/oZe9OdOLwoSnsE1PXnkJuQ2dCfgOj/KLdA/XgC1bskXvNv26RiLKbOeJTuXz5GTEV4zuwtIThIVNXneaVMKzbBorToLfg2ObAs2Yj1ie1T/l8E5oeB0lst3ldUp+mwivqFkPNhZSf2tpYHoMzc6Mr9xB5jPyjr2Gt368E4WZEwqPsfNkjthUoqlMPTe+fUo7dZltYr8x4LtrgIfNeRWwip7wpR10S1BoYPob7JbFmb0rrIc51OlIV7VI7AWAm0xRq5g/TsAggtLfCbtJw+1E4iumm2SzRNrsDE5zfoZhIdMCe77sJcSRKg/pkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdxCv7mrQHXczZ8Wu54MQSZROOWZZozu5hVaJ4E5m38=;
 b=D6m5KgPv4dU0Yoep/zNCq3cl8K4yDRIO9Hy8+BAcbdDrNJ6PasSmFoSPHmBPi7ulYnbYxnhpvqW2raQEhVG1xLE0uCh89eqLZCx18si3yl08NOq1HOC1UVDFOjao1bsUfjZy3kbb/+/oApXukTmKSISqmOdDwS+D8j1F00r7XVH5HMFYmooDAGRvEUTN+MD9eHarN6y09SyCAfAu/KZNTRJu2VdnoFXvQkiULDizXMVm3UVKlfldQZGRRvQ0A1WNAAnjOLB4WahYroT2nASDP9pRmbQ7OSSXhzYEVuec/q26ubpFvG1+eMWxBD5gBRcBqML+TNNWc47SdoqRBMSIKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by AS8PR04MB8772.eurprd04.prod.outlook.com (2603:10a6:20b:42f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 20:34:06 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::358f:58dc:c0c2:1155]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::358f:58dc:c0c2:1155%7]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 20:34:06 +0000
Message-ID: <3671fd52-6034-7149-ebe4-f7560c0dc6b0@suse.com>
Date:   Wed, 21 Sep 2022 22:34:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] Support ESRT in Xen dom0
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>,
        Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
References: <20220919193257.2031-1-demi@invisiblethingslab.com>
 <CAMj1kXEBfJUfTQ3THqqKxsU09_S98B_TjTECKwGM0WAv_5tZaA@mail.gmail.com>
 <7930b617-d473-94dd-c7e4-33ffa19da13e@suse.com>
 <CAMj1kXEJ9d3-8xa7rkczY7ur2zDm9CjqM7u1eEdHHmPG=Oo=xA@mail.gmail.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <CAMj1kXEJ9d3-8xa7rkczY7ur2zDm9CjqM7u1eEdHHmPG=Oo=xA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0295.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::12) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|AS8PR04MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: 28fbc9fa-15a6-46f3-4173-08da9c10a0fb
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pWKjh2S0SuQ46oEPFuS6jrBNlsLwmt5sBwZzmKxkMGWcwGJAl6kTkiFxr0uUxxeXUl6o7i0kVj03mTsDsqFY76ysfsv4ED9tBr/HuoBXV/OE5y++CIcbbeLncoR8XmlQRfRScXn5PDh+0n4+lwU8G+Bo7lpktTx0OY7jbGWEUKTLwn8YXoD8EeaN2IaxHldtS7oyD1AnaTm5ORLND5mPLC2rZdG8mwTcieME3XjosPamIDy6/Q+wMhGs4FPq8/2rt9qNacLoSDbstdCjFi9weumHcP33JfCsdqHPngoec7yL33iU5FJQ9wu7scdm1iBZkmoo7ttoe1HoJ5lqwa0RgEF5uakMmlYnyDvjj2kj4DxKsxz/0SWT3xEYgDCkjRoAaHn2+NvFbCIQFhjmtNdduVcdxo5lh2XARTwqYo5/jDc2n/c+Q4gIZRZ/voN5MdM31zs6+LlBkxplWJOyYmES3NSNdlaAebMOhZv+Rew4BEfHAwXssjkZp+Ro5JWd6SE8MszblJ5WFmvIX8fkbNoims81Sl1lg6oXX8/lM/l9It86XKtUOchzz1CT2k48dOd/ApRWUL5fX7n06ZOXNMYhELwhef40T1NwafcZjkcfPnqJNQNAdgnTTgD+QdDXtQMu1Mz0a4PuR6X2svfyX4vKgbMFA/YlrhRWXVn28qXdd+lFWUq/a+VwJJOMEhIFLWJztegIZQviDpEZOILXOlcAAi/RKIbl8VuvxJffcCqyS0uWsgQ7v24EzRjxv72GYelFcaiS8mI3vRrlJBo0Vuzp2dFd1GDP4jxZXIp4dp3Iet0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199015)(186003)(54906003)(36756003)(110136005)(8936002)(31696002)(66556008)(86362001)(316002)(66476007)(8676002)(4326008)(66946007)(2616005)(83380400001)(5660300002)(6506007)(478600001)(6486002)(38100700002)(26005)(31686004)(41300700001)(6512007)(2906002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFFwczNZallNSDF1WmZVVTRENkdxcnNZYVIxR0dINFk0bDUxY01sZXpMN3Js?=
 =?utf-8?B?dlNhRk9lVkpLbmxiSFJ3Sko0THRjd1lLVlBOMjBmajBLcEE5TlN2S1EwcWZm?=
 =?utf-8?B?eVR4cC9nMUh5S2d4NFhreXpFMjdkSWM0UmRMK0VIVG9VVUhtRVVVYlhsRHZn?=
 =?utf-8?B?QnVoZ29FWkI2cXhwTDBibzlFd0NLQXI3NERaMDQ5Vyt2MERqNDlLVkJMNnN2?=
 =?utf-8?B?ZFFqdjFSNVNTYTJTZ2dKNVgwMnV1R09iS1E2ejM3UjNFbkkrQWUvQWdCZDZ0?=
 =?utf-8?B?YWh1SGN3V2RoWjhuTEFSSG54WEtCZUdpVHRRaUEvY0UwZlFsMVZkZmV4ZGZY?=
 =?utf-8?B?bzVDSFExWHBMSGpNMHpsOXI2NE1QQUpjRW1kRjByVUg5N2tWanJhdUtwR3ZG?=
 =?utf-8?B?MDVrNE0zZHp2TlZQZ0lxeHZtYVhqUExONmc4UDZWOStKbDBOV1lLall5cmR4?=
 =?utf-8?B?TjI4bWlkMGVXN2I2VFpPT0dVcVdIUWVRb0o4WlJzUEk2ZHZJY25Vem9uWHNU?=
 =?utf-8?B?TnVoR3FYRC9jYnJxM3VUb3FHcnlHZ1grVUZrNDJodEpENGdWYVZjK2lVVEpY?=
 =?utf-8?B?anVZdDF4RVFNYWF0TGp1S1VxMk5XT1A5a0ZKSlV5Z3drTkR0cjFUaEJhZDNs?=
 =?utf-8?B?NCs3cGVnMFIrS2h3YzFSNXZyMkM3TmcxZEkzR3JmVHJzNWw5cWkvdXIrTGpZ?=
 =?utf-8?B?MytUQ1ZGb0VSNlhleG9wb1YwcjgvYnhDcmk0SWtKWUdJK25tUWdtS2Y0TWJx?=
 =?utf-8?B?OGo1b0JWcWdiSDliTG80TER4RVV0Qm5RMkg3eDdSSTRETHh3Z1ZtN2doaWN3?=
 =?utf-8?B?VmRRSkNrSXIzUlFlVm9MSVVoZG5IMTBtYlBGdUtGbWRRQkthU3VIblZUbmFD?=
 =?utf-8?B?U0ZZL1BoVmNEWVNkS2M0Nmp4SFRmcDlKR2VwMlY3UVNSdEpYUGhvdmJ3ZWsw?=
 =?utf-8?B?N2VoSVBJc29ZV3ZDWWpjWjJTZktVVnNxbEtVOGhMSkF4SVZDaUg3MEdqMjlx?=
 =?utf-8?B?NE02Ynk0WkFXaUVpTkpuemN4Z2pDQWFrSkYvWWhNaWdaT0ZMVDY2eFB6UjV6?=
 =?utf-8?B?WSt5UXJGTUFZKzZLRVRVT3Z6M0FWRXNLdStJRlJubkZsMnlGVElKUlNyQSth?=
 =?utf-8?B?L0FuZjNkaHArUjVJR2tUUnJPU0hmeVdFeW8wT0h2b3QrSTJRNGZJUkh4MlBt?=
 =?utf-8?B?UnQvalV1NjZ6Y1FXdWpYMmtPV3NlYmlXUTV5RTh2UDZyelBmcUdIRXM4MHR4?=
 =?utf-8?B?U0w2OHJ6b2M3OURLQlJXa3lsd3U0MjIzWnVMaUFteXp0Z004RXFBK20rektH?=
 =?utf-8?B?eTRNc1hWMzF5UzF2V2JzSVkzcXoyQnV4UkViRUprdzJkUkliaW1HWlpMRFRO?=
 =?utf-8?B?UFVHSk1kNUt3UXUvcDlCcGpVUTFsRys1V1JYVmF2MFdjaEVkcW5TZENYYTFL?=
 =?utf-8?B?a2p4K3dNSURJY3dtVkx3K0xPRk4vSEVkUWlxS0RxUXlIeTFWVnNrenZtUnVm?=
 =?utf-8?B?MGlva1ArZGNtWXNnNDhHV0RKajZFb0JzbzFFVWQvOWxrdGMzMmk0Vkx2WHd4?=
 =?utf-8?B?OU5xY0RsUytYbWtMdTlEUVZkQmFnN0szU25YNE9aOFNUSHROU0ZrZkpmS25Z?=
 =?utf-8?B?Y2FxRTBaMDhtaEZaZ1dNeEJpUzRyMDgxZFhvYWFWb0lEK0dmN2Vqc2g1L3ZT?=
 =?utf-8?B?U3hlanlPQ1A4WHZRZGpRTHpQMmlVbXpDWFl0RXc1VHQ2d21raExuN1JGT1c0?=
 =?utf-8?B?cCttdUdZRTB5OFFpaldvSmhTK2Z6U0VnVVJOa2l5ejcyemNjNjI0Smpyc2NF?=
 =?utf-8?B?NmpZVWc1MTM4YUJZTU55MFZrbFBIWlR0d3VuYzZEdkFpWEdjUDB5dk5KKzZU?=
 =?utf-8?B?MUdtRGMyNU40dW1TR1VQWDZ3NUdKUXhNSkMxUXA0ZkhXL1piVzdvSHVLbnM5?=
 =?utf-8?B?RHdqLzlRUmRFQjRpNVBEMmVtWHRoMEpxMEpsekdZZTFubnNxZmtiOVZiT3Nw?=
 =?utf-8?B?SGROUXdPT1g0MEc2anh4OXBIVUZZa1BYZ3ZvaFl6VElDQ3hiRk9mRGhrTHBn?=
 =?utf-8?B?ODBsUW5lNGk3OG9CZmFsTElJaFA0UzZCMkFPWXFOYzBqelpsZHdWVUlXVXBT?=
 =?utf-8?Q?aohiGX6z41rnAGPW0ahtQlvnU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fbc9fa-15a6-46f3-4173-08da9c10a0fb
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 20:34:06.1827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1tXUQsJ18lYf6rS4dBY9tBiyvhxzHnRE0uUEACRx7r14FHnSYV6L2vFin8+fQw7oJoXTe8S9gk6X62JrZPVWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8772
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 20.09.2022 18:09, Ard Biesheuvel wrote:
> On Tue, 20 Sept 2022 at 17:54, Jan Beulich <jbeulich@suse.com> wrote:
>>
>> On 20.09.2022 17:36, Ard Biesheuvel wrote:
>>> On Mon, 19 Sept 2022 at 21:33, Demi Marie Obenour
>>> <demi@invisiblethingslab.com> wrote:
>>>>
>>>> fwupd requires access to the EFI System Resource Table (ESRT) to
>>>> discover which firmware can be updated by the OS.  Currently, Linux does
>>>> not expose the ESRT when running as a Xen dom0.  Therefore, it is not
>>>> possible to use fwupd in a Xen dom0, which is a serious problem for e.g.
>>>> Qubes OS.
>>>>
>>>> Before Xen 4.16, this was not fixable due to hypervisor limitations.
>>>> The UEFI specification requires the ESRT to be in EfiBootServicesData
>>>> memory, which Xen will use for whatever purposes it likes.  Therefore,
>>>> Linux cannot safely access the ESRT, as Xen may have overwritten it.
>>>>
>>>> Starting with Xen 4.17, Xen checks if the ESRT is in EfiBootServicesData
>>>> or EfiRuntimeServicesData memory.  If the ESRT is in EfiBootServicesData
>>>> memory, Xen allocates some memory of type EfiRuntimeServicesData, copies
>>>> the ESRT to it, and finally replaces the ESRT pointer with a pointer to
>>>> the copy.  Since Xen will not clobber EfiRuntimeServicesData memory,
>>>> this ensures that the ESRT can safely be accessed by the OS.  It is safe
>>>> to access the ESRT under Xen if, and only if, it is in memory of type
>>>> EfiRuntimeServicesData.
>>>>
>>>
>>> Thanks for the elaborate explanation. This is really helpful.
>>>
>>> So here, you are explaining that the only way for Xen to prevent
>>> itself from potentially clobbering the ESRT is by creating a
>>> completely new allocation?
>>
>> There are surely other ways, e.g. preserving BootServices* regions
>> alongside RuntimeServices* ones. But as the maintainer of the EFI
>> code in Xen I don't view this as a reasonable approach.
> 
> Why not?

Because it's against the intentions the EFI has (or at least had)
for this memory type. Much more than EfiAcpiReclaimMemory this
type is intended for use as ordinary RAM post-boot.

>>> TBH I still don't think this is a scalable approach. There are other
>>> configuration tables that may be passed in EFI boot services memory,
>>> and MS especially were pushing back in the UEFI forum on adding table
>>> types that were passed in anything other the EfiBootServicesData.
>>
>> Within Xen we might abstract the approach currently implemented in
>> case more such pieces of data appear.
>>
>> While I can easily believe MS might be advocating for this model,
>> I view it as problematic not only for Xen. How would you pass on
>> this information across kexec, for example, without introducing
>> further producer-consumer dependencies requiring separate protocols
>> to be followed?
>>
> 
> In this case, I don't think this is unreasonable for configuration
> tables, which only have a GUID and a base address. If the OS knows the
> GUID, and knows how to interpret the contents, it can decide for
> itself whether or not to preserve it. If it doesn't know the GUID, the
> memory is just treated as available memory [after EBS()]
> 
> I personally think reclaimable memory is more suitable for these
> cases, which is why I am willing to consider that as well. Note that
> the EFI spec now also mandates device trees on ARM to be passed via
> EfiAcpiReclaimMemory, simply because it is the memory type suitable
> for firmware tables that only the OS consumes.

We do preserve EfiAcpiReclaimMemory, for the simple reason that with
Xen "the OS" is ambiguous: Is that Xen or Dom0? Most of ACPI is
handled by Dom0, so we can't very well discard the data before Dom0
starts. (This then also matters for what you've said in the earlier
paragraph. In particular the sets of known GUIDs may be dissimilar
for Xen and the Dom0 kernel. Considering your other remark about
fragmentation you might agree that preserving in-place is not very
desirable.)

Especially with DT mandated to use EfiAcpiReclaimMemory I'm willing
to consider using that type for the storing of ESRT (and whatever
else may appear along these lines). Demi, you may want to check for
both types in your Linux side patch ...

Jan
