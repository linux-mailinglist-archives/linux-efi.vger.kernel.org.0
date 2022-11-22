Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1D46349A0
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 22:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbiKVVvA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 16:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbiKVVu7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 16:50:59 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7757468C62;
        Tue, 22 Nov 2022 13:50:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcXozNP0V/ldcXetOA9sRQlKyB86Z/MIpf1HtLdcl4/EJiZXWWlpEOoSKN5VpyjJnnJ5/jzJIMYDeRN3L+xwSS9xf0BmsKpXtM8fknDzhRUauWF9zX8v7UJVeNvgzBUOf7mydVE+T0l85JVRZ5CEAcjwBwyIruZ4rY1VDbMRQxIf/QazzAVs6Kj/ssVxwccW+qie+dzwUhnCAZx8Not3XEprd9q/nuulJEdQXBU3Y0wXo0Pp2j1m+xjPQN+C1TBJ7Hg3799PpOtntO+kqk5t+4stdqz3GSIUEgSVh3Jk7YFAtRusoNcotGNk02N8/G5Hzv7p0o8NlhxO7K0pqA1+rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPMUYN2rKhn5xmowH2bvPwweTc801s69s+e2G66ilS0=;
 b=n1D6Q29vz9mgUk6VbC5vpHNrNjbCeRZu9DZrtOrJXMABkCtFcObZbqiXtdZwuxbvM8JMQP99fK8TBUBewzgKBr09fVfjiTv7ls1Fdz7x10v2D5I0pm5mKCeQLRpnxmPsgnzRui59ybr8UbX8sB8FbaxIx0nSn+RZSTjaIEWCdah2ESasy+/daXwnVHWsaBocNHOWiG9hLXdsoPt/ilgYA8fZfm0WlqqiEEgfwQZLvzYvc1mn2kLQupN4czPq15jj8aeJuWXQ/6haD7JVbdezYtlxHlIA6mJtUo4d41u2qGn8ZQhZcPxGTGkARkrQx4uYz4mmFCRGnsoTKM6TFllhUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPMUYN2rKhn5xmowH2bvPwweTc801s69s+e2G66ilS0=;
 b=qbez2InpzEC5IMIvH8R7WYqFg1crhh8uI5Ryrhe54Odpt5yfSmjjgEkgxWStM50rz3Cr/j3vO4m9u7td1xwVU+DM1z5+SRci2BqqMuFASUg8J3xxsvxZLLx2wEybtzroh5lHsu0OgjjwJsigngB4EzFIly0RnMClb95WlVAGa8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 21:50:56 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00%2]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 21:50:56 +0000
Message-ID: <62147ae9-eca5-be9f-86a3-72b73eb3d4d4@amd.com>
Date:   Tue, 22 Nov 2022 15:50:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 00/17] x86: head_64.S spring cleaning
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
References: <20221122161017.2426828-1-ardb@kernel.org>
 <5750d157-43dd-6f3d-1407-f41af3cff207@amd.com>
 <CAMj1kXHUQFAcRKzRkuGG3Rsyrexdi7_NUS1-aXrS36LP4Q=rxw@mail.gmail.com>
 <CAMj1kXFX3df00cv5hwij396jS2AOgVGavDM-8hRii49Omn5=pw@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAMj1kXFX3df00cv5hwij396jS2AOgVGavDM-8hRii49Omn5=pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:806:24::24) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|MN2PR12MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: d8b5db7a-2100-432e-3db2-08daccd3a290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LZrOWJWyiVRs7/TMWjfhs3J+vqPIjBRZ43tngou5OLlEJ/vV3X3fTIJJwjaBgs2zUPLL0DH4B6256uY+zPK6JMHgLuVQ+vR7qijvTQmPtxPPDdEE/vs+D17tZLayD7PMFMZMWnNq8uxMSr5U+aw4IztZtu5/XjbYSYtCwcouXS6vc57m7ZYo65xMRBJP2nW0Lv0UsBeCLrzFRwqb5Kf7fTRrwWMg76udVamB4sH5uHh/WFSHIvo9stsSQUVNm1M1LlsceieZF4RXQhcJwdFcZYpWdKRyb8p4rrgpUGC02FOJ8vcqjz9oNDx/l9V6jsObBTOFG9mki0sF6fqCbR6tWhiOgntNztqH1p1yfPy86eJUbE0MfcqXQ8PBMqWBnasZKncDC62uK1EyvSsq+9r9+Lidn+sATFT8IieFxYQoe3uvcCyRwpxUiPGZnOgvZmXQxQbnaxZKXZti2Y1T+zVHG1Pt7mhiE9M0QpnjnS5pfjqp/8FSM4P2C4Koopll336uaVqqkc0LlUaSHc0uRqQy5TQhzlcJsncokYDVsSQ9VYv2iqAZCdzBywMIXVhls75wYHCyQcu7lunuif6r5IX+bB1CRNAo7w/zjWFdxWJcJCuUo6To7SGqY58/IPdQD2aWydEjA2ccQkQMftPUbt3UQxQXKWpXGZ1c5BDqKfSDS8pI6ZIj2gOoTfyKepC78wPAtvb23jHlUyTv1J1QkrO1wWU+/6T6AgNjXfPPj3WgQsI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199015)(31686004)(2906002)(83380400001)(6506007)(31696002)(478600001)(86362001)(316002)(36756003)(6486002)(53546011)(6512007)(8936002)(2616005)(5660300002)(186003)(26005)(66556008)(66476007)(6916009)(8676002)(4326008)(66946007)(38100700002)(54906003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFQ5bUVFcG9EZ1phM0swYTVMb2JVMDNtTFZDT0JDTDVKcDJjNVgvejdrQS84?=
 =?utf-8?B?VHJzaG4rdDMvcUYvRy9taytQc0lsYWVVN2xXQ0drU2R6TkRDNklEZXNnMklv?=
 =?utf-8?B?NW1sNzVRSjM2YldWNkMrSllLdmZ1ZXFBeTNOYk9qbExMYVVqd0c0SW5jSTdS?=
 =?utf-8?B?ZmI3VmxZbFlIaGJ3TVhvNkwrMTFkSkU5anJNRXFZeG5rVkJMY2hpWTN4c0Fx?=
 =?utf-8?B?aFd0eVRWM29NQmwxMXFuRlBiYWkySkwySU1MTkRRcG5UVW95M3VSS2lBR3Bk?=
 =?utf-8?B?KytwaVZGSElWZW41Rmg2UVowcHF4WVF0aVFZN2UwbG42dmlXdUlNK3QvYUVs?=
 =?utf-8?B?QjNLNlJ0dEZnaG9Hc0ZMVG9jWVJDOFZ6U0M0ZjFXVjN2TG1xa2dOS3l2N0FL?=
 =?utf-8?B?c1FYWWtNOHlIRFhCS2s4cVZNbGRha2lKV2p5TDFhc2lQZHJDbFI4NWhFVlpS?=
 =?utf-8?B?WjNVTElRbjZBT3lyWXZpek1QMzdBaGR4NVJId2thNHlmSS81d0l0N3FLRFVU?=
 =?utf-8?B?YlVnZWNuYzlVWnJqTXd6bFNudXN4S3pEVFdheWJNNndENTJlbWpWS1F5WlUr?=
 =?utf-8?B?c2hnTWQ2VGpwUThlR0pEdng2Q0dOQ2IzMXQ2WlVpc3FoajUxdWtMZ2MzTDlJ?=
 =?utf-8?B?cGdxRTNLakI5UUFRajliSm5XQzFDWVp2czE2Q1FMN0cyQjBiNlUrN20ybGow?=
 =?utf-8?B?eS8vMjVhMFpQZjlNSTRoVzF0d016cm5vdzRwcElLTm1nUlBPYWhKZVBBRnVX?=
 =?utf-8?B?ZGF6aE9STlNRWTZpRlF5cXBPeVV0SHdPcTROL1lNU1hiY0VQUEJSVGZXZkJ2?=
 =?utf-8?B?UndncW5kRTExVXlVcS96bHc3azhzeG1yaVAydlRteEpUZEs0dWs5UDlTUGFw?=
 =?utf-8?B?b3RxTUFNWE5TMFl5d01KM3M0YzFDRHozV2pXU1JGYWcxdzFKVFJvYklyYTFL?=
 =?utf-8?B?UWwrQzV2OG0zZW4rRDhwWmpTbHFTNVhxMTNadEEzekwxMXVYV0FaeThZd2ZQ?=
 =?utf-8?B?WUZtd2hnRzdXNm83S25JRysyT1ZHa0ZpUm9WaVZ5dE1Yb2F2UGNMWnp1T3RO?=
 =?utf-8?B?cWs2UDZDVWV2dWlSOERNWjh4b2VkWkhKR0c2cWpHWjVUbkFSWjBIUDh5Q1BX?=
 =?utf-8?B?dTBxUElqWWF2aXJEc1h0NTBGNWdudTFRWVlTaVFySWdRTnRyejUybjB2L09M?=
 =?utf-8?B?eG05S0toMzBEVndpNHZHYWdkNUN4TFlMbGloLzNBT2x0dzVtRjJKTTNpSkFF?=
 =?utf-8?B?dWtQODdpTm12MlptT1VYVDdySngwQkx6OU9neTBGeFpqZmdWV1cyTHF5dDBo?=
 =?utf-8?B?dS9peHZQSFYrL1FZRFpDS0s3bml0SFNjSXJLaW9oNUZ1K05jd3p1bGlSOS9l?=
 =?utf-8?B?TDFBdVF0STZyeU5LRk5UOHN0Y1V3OUNHclY5eDRHNkFjbDA0NkE5TVR4dlVL?=
 =?utf-8?B?SUdydEl6TDBWSmkvSDFNM1luN0Rpa1E4S3lSK1dzak9VQlJlTmg1OE9hVUVF?=
 =?utf-8?B?dTVBOStWNFA5NHA1Zyt1Y3V1WFVzNnY3ck9POWlEcjJiVnNhUUtOVnMxTytT?=
 =?utf-8?B?TTdIelppcDl0NzVpTmw5TzluVFdpTXppbVN5cXZsR3F6cGNKaEtVQ0U2YW14?=
 =?utf-8?B?TVRVcjVRRkoxL29YUEJIMzRUU0c2d1plY3YrN3dlQnE2UGRER05BcittcVFS?=
 =?utf-8?B?N041aTFZclh4NTcvdjhoYzMwOWtRK1piUEFOSFdzcVhMRWRKM3h5bnA4WHhp?=
 =?utf-8?B?SVQxRnQ4Zm1VOXJhU3p3LzYxTDRXZzh3ZkVxRXU1aTR3UU9zcFYyaTlCeGlR?=
 =?utf-8?B?Rm44NWtodWZOUHF2Q0RmZWRiRTl3S0FNdmM0OG0ycG5vQWlnbUxCaHRzOUNm?=
 =?utf-8?B?aHFWT1JsSksyZzU2UXZNRGo2YlN2d2NCeDhVd1MyejRFSkRFemFVMG1UYVYr?=
 =?utf-8?B?UlhWN0dwZVJPN1h5dW5ncGg2T1FuQWtheWtlc2NGYkdSRGw0VVJKWWlSMW9l?=
 =?utf-8?B?Y2s0dDhEeWxwb3VIS0NxdTBKOHZraTdhbkMyREU2TjEwemM0b1lOdGxvNWFz?=
 =?utf-8?B?VlpqN2RjUXNEWW5EVHdmR2lVRU9hVVpmQk5LM2gvenNLUXNCQkxkSDg3WE5O?=
 =?utf-8?Q?WdrKiqFIGn2oVS+Sz37RvbXgb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b5db7a-2100-432e-3db2-08daccd3a290
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 21:50:56.5124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwGpAZg1Wp5ZQ695hJxd2uzWwooKsUM4eubA5tTwaj+dFS7JpEXUyJA1cnKwPDbRJ+SjA9pk+MED5HVYItCb+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/22/22 15:42, Ard Biesheuvel wrote:
> On Tue, 22 Nov 2022 at 22:37, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> On Tue, 22 Nov 2022 at 21:48, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>
>>> On 11/22/22 10:10, Ard Biesheuvel wrote:
>>>> After doing some cleanup work on the EFI code in head_64.S, the mixed
>>>> mode code in particular, I noticed that the memory encryption pieces
>>>> could use some attention as well, so I cleaned that up too.
>>>>
>>>> Changes since v2:
>>>> - add some clarifying comments to the EFI mixed mode changes
>>>> - include patch to make the EFI handover protocol optional that was sent
>>>>     out separately before
>>>> - rebase onto tip/master
>>>>
>>>> Changes since v1:
>>>> - at Boris's request, split the patches into smaller ones that are
>>>>     easier to review
>>>>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>> Cc: Borislav Petkov <bp@alien8.de>
>>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>>> Cc: Michael Roth <michael.roth@amd.com>
>>>
>>> This causes an SEV guest to blow up on boot in the early boot code. It
>>> looks like the stack pointer is not valid and it triple faults on a pushq
>>> instruction (pushq $__KERNEL_CS in arch/x86/boot/compressed/head_64.S of
>>> startup_64).
>>>
>>
>> Thanks for the report.
>>
>> So the mystery here (at least to me) is that all the changes are to
>> the 32-bit code, and startup_64 reloads the stack pointer from the
>> symbol
>>
>> Does your config have CONFIG_EFI_MIXED enabled?
>>
>> Can I reproduce this fully emulated with QEMU? Or do I need a SEV host?
>>
> 
> Also, mind giving this a quick spin?

Just saw this after I sent out my email. Yes, this fixes it.

Thanks,
Tom

> 
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c
> b/drivers/firmware/efi/libstub/x86-stub.c
> index cb5f0befee57..1af11d34bc6c 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -23,7 +23,7 @@
> 
>   const efi_system_table_t *efi_system_table;
>   const efi_dxe_services_table_t *efi_dxe_table;
> -u32 image_offset;
> +u32 __section(".data") image_offset;
>   static efi_loaded_image_t *image = NULL;
> 
>   static efi_status_t
> 
> Thanks,
> Ard.
