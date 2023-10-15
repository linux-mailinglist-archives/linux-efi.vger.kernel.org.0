Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106857C9A25
	for <lists+linux-efi@lfdr.de>; Sun, 15 Oct 2023 19:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjJORCc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 15 Oct 2023 13:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjJORCb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 15 Oct 2023 13:02:31 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2053.outbound.protection.outlook.com [40.107.6.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141C8AB;
        Sun, 15 Oct 2023 10:02:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwmyzxIKnTE74mG7Chf87iIdtQwsyv4Kql/LWPpYHgZk/urk+Eztq5ZTgcmhgwDMYO757Ko0KanvGUJxJ39inG2FefnavE+SOWxM55zIVzw2gkH5gRYK3sVgXs1rD8Wvh9+9oQAZ3cTA/BWw+s38lBG1Fj19viXg5T8Cbh4Wn4UKNp48Kmxaaj6nHYLeiXpR05cScpC7JLdMmcSn2Odor0bvQKBhDd/HZ4cXesrbYQv2XZiLPd4Z2rMwAPSgB4NR4pjlxfuJWLOHO+lnZ1DLtg3CYfaWahqhTjvlK4vgDsE3HNEUMD27YBrcEDM6L4jenq5U0a11TlPx9IFuDC0Agw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGe3W0doIg6S2a6Q1at2EJkEuXgPhd/SVP7hrwVMdsc=;
 b=J5EouLM5aXvtnkGKiYGRIVU1LSSniExLz10WGQetFFB4hM8CQ8B0NAJ0CMkcO92d6uqel0viqXmFKgU6/dRKlo6NFKoZN8b8+NQtpzq6cghLxDD1F17vl2D3NLmfuvMxsvX57kj/Z8/afGxgVqVPigImdMtjjY4akxr7MKwUihUjy7qNx3PvXxIYJ0QtrFkoD/z/siqu9lmA2fQ6zP0pugZx8VXRB0G6pyYQLuRIaRxUwD9QDdv4QKEg/Ritih4Vk+lzD1CdSEnOIpkmfi8HL+e2QllcxkdhTxUBxEj31rjsd3iZ/q7+xCvGJWZb+zXtu5/tiwBsHsfS5cJ3jIv1tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGe3W0doIg6S2a6Q1at2EJkEuXgPhd/SVP7hrwVMdsc=;
 b=yY/wrhmtdRSnnmb+nRfvYU0Mjh9+UUaEd+x/6fReOyO4G2L5Ty2Ymt8nYeBcZ6K6sxX2JsT1lTOL7ynoJj9F19C9vneTtalMXOnGdfnYa6EQEg5aBve3ygrGVkuOLxabmTBH3HiBUJZI0SCtKHnIKYJ1dNQvPYFHcnSzx1/dC/RLSKZvnXyPg7VtXQpFEn3iTp9XQFiBx0qtTm0KhHhDwR8FkH/hveVAiwX0AEmA3ZeOo8GzVT4/6xnD5vw1VQjdxkkFiJioZezi6noZoBUq0Gn2JUKfwQqRpcetXpOJl/phDJzuCm+T884rPl3glVZ4irfwKwcdQNtC1f6Bup8XUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by DB9PR04MB9791.eurprd04.prod.outlook.com (2603:10a6:10:4ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Sun, 15 Oct
 2023 17:02:26 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::edd3:f00:3088:6e61]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::edd3:f00:3088:6e61%4]) with mapi id 15.20.6863.046; Sun, 15 Oct 2023
 17:02:25 +0000
Message-ID: <d745361e-2867-4f3c-bd41-714c7a382910@suse.com>
Date:   Sun, 15 Oct 2023 20:02:16 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi/unaccepted: Fix soft lockups caused by parallel
 memory acceptance
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org
References: <20231014204040.28765-1-kirill.shutemov@linux.intel.com>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20231014204040.28765-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::16) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|DB9PR04MB9791:EE_
X-MS-Office365-Filtering-Correlation-Id: 67dba5cf-b8f6-4ec1-8509-08dbcda0818b
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vK82oIQ3knzn4TmyoR4KayR60LkxIN1KMamhXNqZkPvmBWLQ+CAjQkWtn0SOTNwBENO3UIgf0aiFKDwDJotwCf6AiXN9xjoiWgO9Prfa8csx9PcTfpB/rO6lm7PpRvKZPBUz/glqhCToUWbT/YbudrjIzYdEuUdm34yXIGS6hjL9spfkh68Z/4BTnrY1jkM9lEqHc2vaZDFbTu/jH76JeKi38b+V6lthrEDt4VTfikqSjv7/YrH3C8uZ9IeP3bcxkSC6HJNqsuETpjUmBS7YXvsATn9BcFIJjDlT4ZsNFTa5iOvtxhMY9hHBBNdu9GL0lV1xdU65c5Uoeo2tEnHYhaSinF//c3vd5HENHmxzlrssxqkVMWbFT7zAKGPj6YXUVEwZ7jbn2IDOf32MYNBG7vbjxsrRUVjBkuDVuz9CgRH1C/N519wejFMemRWmuTYAVcDoBalWultIo3EnE7Zjctdn4pjo8g/Un8bKdHawC2Lfb+li0heZ4G8Xh1X8UqkjLLtnNzEU0zkSGjwjtaMpHVMGoG9NhNakRH2LMvII9mnxne55sU3YZy/3Fe+mnjMtLZzUH9MpchnZX30FkQM1Tul5zhBG1MzTh6A+TYwapdKCHu2XYMd2DRohl+J6KgQU48Kryq4tKNatasdi8SAgIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31686004)(478600001)(110136005)(66946007)(66476007)(54906003)(6666004)(66556008)(6486002)(83380400001)(31696002)(86362001)(38100700002)(2616005)(6512007)(316002)(6506007)(41300700001)(5660300002)(36756003)(8936002)(8676002)(4326008)(7416002)(7406005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3B1R3d5Y2RqMVVqcFdiZGR0cGtBRTE2TWVWdW10cUYxbHIrMXBEWTlxYzRS?=
 =?utf-8?B?Q3dXZmtNUjFtYjNxNU9LaXc1RHdKdWZpZ1hUc2hiM2MvdWlkL0pZK0ZHRmhx?=
 =?utf-8?B?RlIyT0U0TzFzaDF6cWE1NDg5MWhVaDZEMndXNzEzNVlsVDNHYTBqMTE3TmtF?=
 =?utf-8?B?eWVxcHUrZFg2UmxrVDFsTzRqYWRxbGdsL2N6dS94cmVxOGt1a1IrVjg4U0k0?=
 =?utf-8?B?YUtrQmFBSTVjNGVCMUNMbDlyTXZsbEV2UGxEL0VCanh4Y3lja3RGcmViK2FP?=
 =?utf-8?B?VGc2cXdvQW1Ea0V6K2N2bjM5MURhSkJROWFUOThiMkNmVjM5VWdJaUtpWE1U?=
 =?utf-8?B?dGpIR3NuV0tjaThFcUhtVDVVdzI2SnVmQXpHZ2lyVTV3UlNiSkhNYjZHOU1R?=
 =?utf-8?B?cTc1Nzc5b1N4TmdxOHdCZVUzaVd2UlhvOGNCOHVHdVpqMHBBb3hqajdNZkh1?=
 =?utf-8?B?aS9rbHMySzQ5RHc4elZwODl3VlVmaG5QZFR2UlJnWE9uWlRoSU5oWkhUZGp1?=
 =?utf-8?B?N3g3YVZBdjBOLzhXZzlWdWIwNHdxKy9CRU4wbk5rclltci9OWkU3b0YvNUNT?=
 =?utf-8?B?ZnlXWVhvMFN2L3NtRzJUaHFWanVFTmRXT3N0Ykl4ZzZ3MitMbVdQQzBoKzRR?=
 =?utf-8?B?aml2TUJWLzZLWjM4ZzdnMW1aZ1YyQ0djMGcrRUx0KzlBcndMRjd4SDRMQkhK?=
 =?utf-8?B?RkxOdDZZaVN6MVpNdSt0aDdSTHFhTzFoS3hRVlVHL0xJZ21vZWRZL0hGenhF?=
 =?utf-8?B?RjZncTlHTnluZXJjK2plTzV2enlJWDFvdHIvVktGN3BURW1KK2grN3piMEwv?=
 =?utf-8?B?cFRNQ2JtVDI0cndhZisxZVVUV2V5MTI0WVNGMnV0eWwyY0I3VHVzaHVTbUl0?=
 =?utf-8?B?UWFrUGdQbHljZllQWVNhRC9BZDRQaHhXamF5dEhTdUdOcGlQbmVIUy9uZzVl?=
 =?utf-8?B?SDhNamtuTXl3SFJWZTdKaFd0T3NmKzBTM0V5VW9ETGdvTDkvUXBWU3cxenZp?=
 =?utf-8?B?clRnZHRBV1BMVWdvZnQ3U1YyU1dXcmFZK2lnQ2dhblAwOXVTQkhNblY1eWk2?=
 =?utf-8?B?NHlnQUhHLzA4emVQWndsUVFQUy9MNitUM2Q0aFJmRXhEM2svTXc3Y1F4Yzdr?=
 =?utf-8?B?NndaNXV4N3VHbkV2Myt0d3BVK3FBUlJJWnBpczE4OUlRUDFaSXZnZmZZcFVX?=
 =?utf-8?B?aTVaZFllRmNNSC81K2NHckg2ZUJXQVB2Y2hMMmJOQUhreHdCV0VrMkMvdG5w?=
 =?utf-8?B?OUsvYmVEMExUaGRGQlQ5NW55b1Z1ZG9MR1E5WlNwajVqeCtzYzRVbm93eklT?=
 =?utf-8?B?NERIQVVDOHIvM09CcDBzYjVTbzBSSkl0bE1JWGFHb0Q2TTRLS1BWc2srRGEx?=
 =?utf-8?B?aEphRHIxL1U2TGdYbjdNc2JzVUlQYlV3aThSbzZSdVc5Y1BWSTlHdzEwSmlm?=
 =?utf-8?B?ZWRKZ0JFQmU0UmVLTDh5Znlqc1dwRmNJTzN1NTV3cEpMSkU4Z1A3VVlWZ3pR?=
 =?utf-8?B?OXBkM0EyRjNJOEZqUStBL3NldCs3MmEyRU5BVTRXd1lDdWQ3VmNCWnBuTTdu?=
 =?utf-8?B?cEFCcWNzb0t5MDlwRkVKRG9lSmNOeEtaMk9wNFlvKzF2aGN3WDdZN1l6Y1hU?=
 =?utf-8?B?ZVBMeGZKd05Kb3NFUFQ3MFFWNXVFUzVkZEQ5S2Mwa1ZMZHFJYU13Qmh6SmNE?=
 =?utf-8?B?bFJ4b2VkTW9pWVRMSnRXMUl2REtLZnVYZFMzTWxNNVd1eWg5S2V0YUpDdlVE?=
 =?utf-8?B?ZVZtbnczbmlOc0RvTmdWL1diTUhMbVE1V3VHdm1WM2NKRlZmYlpkcHVNbVN4?=
 =?utf-8?B?QTNZTURtdTFUakhkMUE0alhjRTZKNVJyNlNtN1hFWDdFeFhNcmdoRmpudHhx?=
 =?utf-8?B?WjF6SDZRK1hWRUJrNGtlcGZ6U3ZySnVqUkNlLzdNdmNVcEtJTkdrbXNpaDZL?=
 =?utf-8?B?ekVaV3IyRHZHSHlCSUU1NHU4VXVFNWo1L3ZTMzkvZDV1a2N5VzRZSnZQYTI2?=
 =?utf-8?B?UXlGT25oSVZvUmsvZ0dqUEo0TWR2RzU2TmVqMUl4MHJMSHpTVkN2cTdZZWo5?=
 =?utf-8?B?RVlwb09VQ0VxMjVlbHQva0l4UE0wVFlLdWdHOTF4NC9QZUtPZGlFc0JyTDFE?=
 =?utf-8?B?TzJyaXlsRVVMaUE0TlBPaUMzTEhrek1QQzhZZWtTem1oQ21kRC8yMGMvOEFa?=
 =?utf-8?Q?xsOcCxuDxM1utAFC5nYFNGIuAtVLaLCC7OK/0SUXxy9t?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67dba5cf-b8f6-4ec1-8509-08dbcda0818b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2023 17:02:25.6903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilMKUP3Spm/Cwa24d25BAfiwvtXI+2cYKCrcLctRKl2FvWffnvg5LJArI4F52Fvj3bw0L2Nnpu9G6IBt8Xd40g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9791
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 14.10.23 г. 23:40 ч., Kirill A. Shutemov wrote:
> Michael reported soft lockups on a system that has unaccepted memory.
> This occurs when a user attempts to allocate and accept memory on
> multiple CPUs simultaneously.
> 
> The root cause of the issue is that memory acceptance is serialized with
> a spinlock, allowing only one CPU to accept memory at a time. The other
> CPUs spin and wait for their turn, leading to starvation and soft lockup
> reports.
> 
> To address this, the code has been modified to release the spinlock
> while accepting memory. This allows for parallel memory acceptance on
> multiple CPUs.
> 
> A newly introduced "accepting_list" keeps track of which memory is
> currently being accepted. This is necessary to prevent parallel
> acceptance of the same memory block. If a collision occurs, the lock is
> released and the process is retried.
> 
> Such collisions should rarely occur. The main path for memory acceptance
> is the page allocator, which accepts memory in MAX_ORDER chunks. As long
> as MAX_ORDER is equal to or larger than the unit_size, collisions will
> never occur because the caller fully owns the memory block being
> accepted.
> 
> Aside from the page allocator, only memblock and deferered_free_range()
> accept memory, but this only happens during boot.
> 
> The code has been tested with unit_size == 128MiB to trigger collisions
> and validate the retry codepath.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Michael Roth <michael.roth@amd.com
> Fixes: 2053bc57f367 ("efi: Add unaccepted memory support")
> Cc: <stable@kernel.org>
> ---
>   drivers/firmware/efi/unaccepted_memory.c | 55 ++++++++++++++++++++++--
>   1 file changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
> index 853f7dc3c21d..8af0306c8e5c 100644
> --- a/drivers/firmware/efi/unaccepted_memory.c
> +++ b/drivers/firmware/efi/unaccepted_memory.c
> @@ -5,9 +5,17 @@
>   #include <linux/spinlock.h>
>   #include <asm/unaccepted_memory.h>
>   
> -/* Protects unaccepted memory bitmap */
> +/* Protects unaccepted memory bitmap and accepting_list */
>   static DEFINE_SPINLOCK(unaccepted_memory_lock);
>   
> +struct accept_range {
> +	struct list_head list;
> +	unsigned long start;
> +	unsigned long end;
> +};
> +
> +static LIST_HEAD(accepting_list);
> +
>   /*
>    * accept_memory() -- Consult bitmap and accept the memory if needed.
>    *
> @@ -24,6 +32,7 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
>   {
>   	struct efi_unaccepted_memory *unaccepted;
>   	unsigned long range_start, range_end;
> +	struct accept_range range, *entry;
>   	unsigned long flags;
>   	u64 unit_size;
>   
> @@ -78,20 +87,58 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
>   	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
>   		end = unaccepted->size * unit_size * BITS_PER_BYTE;
>   
> -	range_start = start / unit_size;
> -
> +	range.start = start / unit_size;
> +	range.end = DIV_ROUND_UP(end, unit_size);
> +retry:
>   	spin_lock_irqsave(&unaccepted_memory_lock, flags);
> +
> +	/*
> +	 * Check if anybody works on accepting the same range of the memory.
> +	 *
> +	 * The check with unit_size granularity. It is crucial to catch all
> +	 * accept requests to the same unit_size block, even if they don't
> +	 * overlap on physical address level.
> +	 */
> +	list_for_each_entry(entry, &accepting_list, list) {
> +		if (entry->end < range.start)
> +			continue;
> +		if (entry->start >= range.end)
> +			continue;
> +
> +		/*
> +		 * Somebody else accepting the range. Or at least part of it.
> +		 *
> +		 * Drop the lock and retry until it is complete.
> +		 */
> +		spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> +		cond_resched();
> +		goto retry;
> +	}

So this works for the cases where we have concurrent acceptance of the 
same range. What about the same range being accepted multiple times, one 
after the other, the current code doesn't prevent this.

What if you check whether the current range is fully contained within 
the duplicate entry and if it's fully covered simply return ?

> +
> +	/*
> +	 * Register that the range is about to be accepted.
> +	 * Make sure nobody else will accept it.
> +	 */
> +	list_add(&range.list, &accepting_list);
> +
> +	range_start = range.start;
>   	for_each_set_bitrange_from(range_start, range_end, unaccepted->bitmap,
> -				   DIV_ROUND_UP(end, unit_size)) {
> +				   range.end) {
>   		unsigned long phys_start, phys_end;
>   		unsigned long len = range_end - range_start;
>   
>   		phys_start = range_start * unit_size + unaccepted->phys_base;
>   		phys_end = range_end * unit_size + unaccepted->phys_base;
>   
> +		spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> +
>   		arch_accept_memory(phys_start, phys_end);
> +
> +		spin_lock_irqsave(&unaccepted_memory_lock, flags);
>   		bitmap_clear(unaccepted->bitmap, range_start, len);
>   	}
> +
> +	list_del(&range.list);
>   	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
>   }
>   
