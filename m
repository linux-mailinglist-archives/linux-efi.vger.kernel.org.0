Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F1D52D0C1
	for <lists+linux-efi@lfdr.de>; Thu, 19 May 2022 12:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbiESKnm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 May 2022 06:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbiESKni (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 May 2022 06:43:38 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF85AF1E9;
        Thu, 19 May 2022 03:43:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHXWsjlyC66aln4s6lqJYFwspxdh8dUehg/QqBcpITirync+OCquM471hgqwjNxKJMCWfEMqFu2cQbHYtZupPTdrhT+IZWBNCmv5fTqvUFi7tW/5wnIQ1NtbXC35Uts08/A34b1Chp7l0Jwl8cEztP1pv5u0tk+4/8wIssUFlJwJE5k3/7+bjIEHIO4GHtrAprvSmObOuwIRVC2LQjYauOJFmQ36GcRA7cUlZczGuq8O1ZuHsupbXJf2wGn5PxsgOyV7vD70vHnZ5U748A6qWZSbV+134uicVprgDNQySlZQA5DJ58xMx/jb7XsfwdwtweJq7znIkIvza9XUjs3nUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CH3wEsZAIOdAQh3HrP3SvMhJvS+0o6ElWBxEJwHeygQ=;
 b=X82DrOSc3edXv1Aw5rEOup86/FFdZnOnJLdx71T7e0ytWeTLtOj0i+y0u8YwdVfEVGiW9lHzmMJeV1g+/HAYGkrKsxMFdN/njUeyd0hnXy9/2a7UkQrx6Sne74R2XXEVKdHgiuERlFxCr7ZhtxBbLgHaYP2e4wlGIc6fTkh581cYszEvGvYdHRdtgpOUDoyBS0hWDCNo8uQzYquU8q0XXAsjp39fjWHA1QlomaT3WZtPQ51uWhXktbz2P5611mFX6/ILRzkgDd0prtA6LgB8FU88J3rsIDMDPImqOD6FTXF2ECy5Ghvok1lJYAod3Yy+lc3+mUwdIvs79RHOA8ifvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CH3wEsZAIOdAQh3HrP3SvMhJvS+0o6ElWBxEJwHeygQ=;
 b=fsCH5tQHqWBiljeXWro30Lf9gBC0W3OWYpcSq3+nxHWEkglCFiNN/o5l3jJYLWWrYUCgd2g42GsDLuonwouvkKu+NAPSU8Xn+zkWdFeoY3lLnr87R3e/rQW94ASXcE4Zr7708XxgN81EPvwsgCywMMTkZuV4X3sDV1WABhRUpeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by BY5PR12MB4920.namprd12.prod.outlook.com
 (2603:10b6:a03:1d3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Thu, 19 May
 2022 10:43:28 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::5c1f:2ec0:4e86:7fad]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::5c1f:2ec0:4e86:7fad%3]) with mapi id 15.20.5250.018; Thu, 19 May 2022
 10:43:27 +0000
Message-ID: <972b5335-98df-f7b2-4b4f-53695e684d8b@amd.com>
Date:   Thu, 19 May 2022 12:43:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCHv6 02/15] mm: Add support for unaccepted memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
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
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
 <20220517153444.11195-3-kirill.shutemov@linux.intel.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20220517153444.11195-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0038.eurprd06.prod.outlook.com
 (2603:10a6:20b:463::10) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0fff120-910e-4051-6189-08da3984681b
X-MS-TrafficTypeDiagnostic: BY5PR12MB4920:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB492045DC8A35DC0F9465A6019BD09@BY5PR12MB4920.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AWyPU4jcV0PxMtPJlW/wvn9TcqVM/geZoJgel6POnitlwHfWlX5nnq+6/GgDexs79uZGtVV7w1PdiSNz2EtEb+FrRwkYHx2Fz1WyT/yawoFsQk+6gBIU7li9r67IQKnj0Qh3lDuODZqlWir7qaTTd+YxiKOOBuO2mKLDZ37Ig1hiPx7sq89wQr6AqyEB2+h30vJKJt+uk8+ixgNLGWN00yGP16ArzFPXR7uyYYqyZLfzOiMj6y1+rwHUU5sas4rmNGBNiRGaqeM3nzyEscSZiB4kIky4LLF4pSxUmlwqPnMdftFmPx6QyKRyL0hj58SDSsGr20f8BFTZhBbm1QYvoAhASkC0gZVtrm1dwCRZj2+000eOeXkBWUWM24PQdJdSgu34s08WwLEEoq0bDoNvhJYyJ6wgzeOSGSX3LmXKWtAcbAup8wGsztpnnp6et5rBhtjwa+LjoCTiYt1LSosbHeZbpUKjIXg4rubN3mc7NwerE0GHAGuW28A2MGwkWxFlDPwXu2hax3LXR8zeQG+hTzdlFcYyYOWCrXuhkD0tIokszo6guDqXWTFwhOkF/YYLWFNEmR8SPH7NJE6tH4O/73mrHIJfPHEv+0UZh42yFxXOPtzBEyjPmT5jdJWZIcew74LAPmXeGDmdQ20rwQ/V/EwzwofSAOrBuVZ3Wtadv6B8k9a6IN0s1KGP7EnLf4dwmoTwlnQd1fcdI5XmAAeEUhPk1gMgIg8Weg86wNiIDlA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(31686004)(508600001)(38100700002)(186003)(36756003)(5660300002)(7416002)(30864003)(2906002)(7406005)(83380400001)(110136005)(2616005)(316002)(66476007)(54906003)(31696002)(66556008)(8936002)(8676002)(86362001)(66946007)(6506007)(26005)(4326008)(6666004)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?di9Ga1pyVzlsb1dHNm9zTUxJNU9xY2ZaRXoxTS9wYzBuWFRLOCtHUFpWaGVw?=
 =?utf-8?B?TWJHd2MyeVA4aTdVTWZKRDB5cXNjNENIYldhWFlnRzJpZGN0QnR5K3Vwemdy?=
 =?utf-8?B?YmM2QktWL0JkZWo4ZkJwaEhINnN6dlNUeUlYQksydWlCcGhQUUhoSjY5NWh2?=
 =?utf-8?B?c0VxQ0YzcTFScUoyT0tJUFNxeFV5MW92OG9CM3p1bUx5Q2hCYm5Ob2E5THVH?=
 =?utf-8?B?c2JGb1B1b0tVYXBtZDhsMUt2NGNPWUFVVENJNDl2OG5IQVNDaVBGdTI3V0RD?=
 =?utf-8?B?MDNOM0dkZHpTeHFiZGtNQXFmTlFDOWxBbHQ2ckZ1OUJWVlM0L1JuQ0FjNW9U?=
 =?utf-8?B?ZktxVi9la1I5eUVVZjNvRkp5NU9zNWl0YXBoWUluNmVmeVNGNFA0VFM3ajB3?=
 =?utf-8?B?S1JUYlRNdHJabTlxbUpPQkdBWnd2NjRKdnUxMDY3cFJxdTFWYlc0OXcvYlNU?=
 =?utf-8?B?VUhTMUovekd0YjJJWmVjR2draklUUDZYYWRJdHlxbG4wOURFNGxFckNYZzlU?=
 =?utf-8?B?ZnVZdXphQ1hydnhXS3RGVVhXQXZYWW1oRGNNZlVvQ24rS0ZmTXdBQjNpNlc4?=
 =?utf-8?B?Yjg4ZWgvQ0lYdm1YVXJTTXI4dEc3RGdMQm5ZNFdwOThvTE1pM0VtQlNWUlFq?=
 =?utf-8?B?Q3lMY1FwdE1HV0ZvRTF5OFR6NVBBZUlxd2p6YmVwWTdiZUJyakxEdW95N0dJ?=
 =?utf-8?B?cHVROENpcnRSRTZNR3NScXBjWFpVbHIybDhtVGpIMU1VT2JrNUx6MkExWmsy?=
 =?utf-8?B?MisvTnRGRWZwWDJ1ckVhcjkrb3hDNWcvb29qeUFkdzNiNlJzbGZoNXRsWUdP?=
 =?utf-8?B?Nk1BbGcxODY5MmM3dDFJSDllUGEzUmxST0g3dkkxVkVBOGF3amVJMnhLNlBC?=
 =?utf-8?B?QXNGZzhRaVNyUU82WVVsZjhPdWFkdCtoaEZpZU5YNHppSUduY0lPdjdjYXI5?=
 =?utf-8?B?VjFrcExBdlB2R21vRytsUHZRTkJCcU9sQ1lvSTdEWjVrL041TTlPbWR1Rktt?=
 =?utf-8?B?aWQ5aERVaUhKZlFzY3BXa1NFZ3hnWC9Ud3pqNG9sZU1rWENpY0lvTWpOak9r?=
 =?utf-8?B?NTBnRUtxUFk1SExCSkVxa0QvZURwTlpDT3BNQWczMi83Qnp0ZU92ZGlVVkpy?=
 =?utf-8?B?Y3c4bHFPbnNlUEdXTHNVZEoxS0VqVXM5ZlZCbmxjb3VKVXFLeFZJT05zcGZT?=
 =?utf-8?B?a3ZCY1FmM3RyL3gvTEF4YTNoQ2piTnNKc29Mb043TzBRekJjVm9mVFJyRHh0?=
 =?utf-8?B?RUpkT0RScm81b1MyUy9hbVV3ck1mUGlQRUxCay82bjhDMXRrS3JucHIzbmll?=
 =?utf-8?B?WE9wbDZQRGpmSWw1bEQvKzhNZ2Nqc3hMQ3hDL3lQUDdtSXJsRU16QVpHTENi?=
 =?utf-8?B?elB6MFp3a1Q0cE03UkZJamUvRmEzOW1DRDhQOGZJRFBMSWNrbEorODZMRUp0?=
 =?utf-8?B?TE9WQTd4UlExMWhCdWM2QlIxUUxkVnRnTk42UkNMNlhRZEhGb1JVdElZZSsr?=
 =?utf-8?B?eldDalZlcVFLa2R6b1BiZGpkSU5kY3NjY1RZeVA4YVAxQ0U4MmhnaFVJcnhE?=
 =?utf-8?B?SXAxeG5WTVQ2UzZrRGNGL21zS3hLazBMN3Noay9IbGhObE1XR1ZWWFg5aTFt?=
 =?utf-8?B?ZE1SdkVwNmY0cmx5SUtVc2dFNFpPS21kQkgzdUdobjFmbUZVSXBlS1EwSnkr?=
 =?utf-8?B?MmU3QzdnUGkxT1VTWjBJM2JYTGVZRE9VRTBHdDhtV1V2L2UrOG41Wk1nMXAv?=
 =?utf-8?B?M0dSOUZ1N1BCclVrbzJTUnA5UWFXaXhoaDZmMlRONG1IOHdaRkFiY3FCN3lh?=
 =?utf-8?B?THpURU5RZU42VlNqRE1rbmd4em1QbkxROHFYZkZ2K0VXNnZGQnVBVjJ3V2lO?=
 =?utf-8?B?RUpaelhuakMvZ3ZHWEc5bERMVUJ0S3Y3ODk3aVlTKytsMkY2azNSZ1M0NXdk?=
 =?utf-8?B?WVo1a1F0b1BJT0Z3dU1ramk5bXVBejJsK0xRa2NndnZaMXJCNlRKL2w5Mk41?=
 =?utf-8?B?RmIxdWJPRTFCangwOENjcmNhamgwMnJ6N0Z6b05iNWJMbHRYdTNiQ2FHb1A0?=
 =?utf-8?B?cmlCcmhCRTJDbUxlM2pqQ25LQXc3TmRLSVFBcWpkN0tzY2Q2TlVtdHJ1U0pX?=
 =?utf-8?B?SVpPdTBnSFhkdC8vT2daN1g1bXlnNVZtQS9wQVh2QXJiRUoraVRDUkhuSjhx?=
 =?utf-8?B?eSs2OVBkVi9IckNuK2VWZFZpU1NpZ24rNkk4R0J4eFhPUlBES3N4bXM4SG5M?=
 =?utf-8?B?ZGJKalZORTAzS0p5NG5sSzhPWUxzOUxQRkxYMzIwUDYwZ0tPbEk3Rzd6Q25W?=
 =?utf-8?B?aW5hUEp6L3hZYjlDMVduc0xERkgzVEp4T3JHR2lJNzNycVVINEx6Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0fff120-910e-4051-6189-08da3984681b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 10:43:27.4562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJlICABxLPRsICM6Kvc9rsU5QINXNmYD0AqJK8yzu7Uu5N1QEXsCwrUAN3OYTJwKlrPQqMLg74fqXsPk7NdWdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4920
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


Hi Kirill,

Thank you for your patch series.

I am trying to catch up and understand the series. Have a question below:

> UEFI Specification version 2.9 introduces the concept of memory
> acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
> SEV-SNP, require memory to be accepted before it can be used by the
> guest. Accepting happens via a protocol specific to the Virtual Machine
> platform.
> 
> There are several ways kernel can deal with unaccepted memory:
> 
>   1. Accept all the memory during the boot. It is easy to implement and
>      it doesn't have runtime cost once the system is booted. The downside
>      is very long boot time.
> 
>      Accept can be parallelized to multiple CPUs to keep it manageable
>      (i.e. via DEFERRED_STRUCT_PAGE_INIT), but it tends to saturate
>      memory bandwidth and does not scale beyond the point.
> 
>   2. Accept a block of memory on the first use. It requires more
>      infrastructure and changes in page allocator to make it work, but
>      it provides good boot time.
> 
>      On-demand memory accept means latency spikes every time kernel steps
>      onto a new memory block. The spikes will go away once workload data
>      set size gets stabilized or all memory gets accepted.
> 
>   3. Accept all memory in background. Introduce a thread (or multiple)
>      that gets memory accepted proactively. It will minimize time the
>      system experience latency spikes on memory allocation while keeping
>      low boot time.
> 
>      This approach cannot function on its own. It is an extension of #2:
>      background memory acceptance requires functional scheduler, but the
>      page allocator may need to tap into unaccepted memory before that.
> 
>      The downside of the approach is that these threads also steal CPU
>      cycles and memory bandwidth from the user's workload and may hurt
>      user experience.
> 
> Implement #2 for now. It is a reasonable default. Some workloads may
> want to use #1 or #3 and they can be implemented later based on user's
> demands.
> 
> Support of unaccepted memory requires a few changes in core-mm code:
> 
>    - memblock has to accept memory on allocation;
> 
>    - page allocator has to accept memory on the first allocation of the
>      page;
> 
> Memblock change is trivial.
> 
> The page allocator is modified to accept pages on the first allocation.
> The new page type (encoded in the _mapcount) -- PageUnaccepted() -- is
> used to indicate that the page requires acceptance.
> 
> Architecture has to provide two helpers if it wants to support
> unaccepted memory:
> 
>   - accept_memory() makes a range of physical addresses accepted.
> 
>   - memory_is_unaccepted() checks anything within the range of physical
>     addresses requires acceptance.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock
> ---
>   include/linux/page-flags.h | 31 ++++++++++++++
>   mm/internal.h              | 12 ++++++
>   mm/memblock.c              |  9 ++++
>   mm/page_alloc.c            | 87 +++++++++++++++++++++++++++++++++++++-
>   4 files changed, 137 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 9d8eeaa67d05..7f21267366a9 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -928,6 +928,14 @@ static inline bool is_page_hwpoison(struct page *page)
>   #define PG_offline	0x00000100
>   #define PG_table	0x00000200
>   #define PG_guard	0x00000400
> +#define PG_unaccepted	0x00000800
> +
> +/*
> + * Page types allowed at page_expected_state()
> + *
> + * PageUnaccepted() will get cleared in post_alloc_hook().
> + */
> +#define PAGE_TYPES_EXPECTED	PG_unaccepted
>   
>   #define PageType(page, flag)						\
>   	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
> @@ -953,6 +961,18 @@ static __always_inline void __ClearPage##uname(struct page *page)	\
>   	page->page_type |= PG_##lname;					\
>   }
>   
> +#define PAGE_TYPE_OPS_FALSE(uname)					\
> +static __always_inline int Page##uname(struct page *page)		\
> +{									\
> +	return false;							\
> +}									\
> +static __always_inline void __SetPage##uname(struct page *page)		\
> +{									\
> +}									\
> +static __always_inline void __ClearPage##uname(struct page *page)	\
> +{									\
> +}
> +
>   /*
>    * PageBuddy() indicates that the page is free and in the buddy system
>    * (see mm/page_alloc.c).
> @@ -983,6 +1003,17 @@ PAGE_TYPE_OPS(Buddy, buddy)
>    */
>   PAGE_TYPE_OPS(Offline, offline)
>   
> +/*
> + * PageUnaccepted() indicates that the page has to be "accepted" before it can
> + * be read or written. The page allocator must call accept_page() before
> + * touching the page or returning it to the caller.
> + */
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +PAGE_TYPE_OPS(Unaccepted, unaccepted)
> +#else
> +PAGE_TYPE_OPS_FALSE(Unaccepted)
> +#endif
> +
>   extern void page_offline_freeze(void);
>   extern void page_offline_thaw(void);
>   extern void page_offline_begin(void);
> diff --git a/mm/internal.h b/mm/internal.h
> index cf16280ce132..3fd5d8f90492 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -758,4 +758,16 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
>   
>   DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
>   
> +#ifndef CONFIG_UNACCEPTED_MEMORY
> +static inline bool range_contains_unaccepted_memory(phys_addr_t start,
> +						    phys_addr_t end)
> +{
> +	return false;
> +}
> +
> +static inline void accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +}
> +#endif
> +
>   #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/memblock.c b/mm/memblock.c
> index e4f03a6e8e56..a1f7f8b304d5 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1405,6 +1405,15 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>   		 */
>   		kmemleak_alloc_phys(found, size, 0, 0);
>   
> +	/*
> +	 * Some Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP,
> +	 * require memory to be accepted before it can be used by the
> +	 * guest.
> +	 *
> +	 * Accept the memory of the allocated buffer.
> +	 */
> +	accept_memory(found, found + size);

If both Intel TDX and AMD SEV-SNP requires the memory to be accepted 
before it can be used by the guest. In what other use cases (apart from 
memory hotplug), the lazy memory acceptance will be useful?

Thank you!
Pankaj

> +
>   	return found;
>   }
>   
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0e42038382c1..c8b6e29f4402 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -121,6 +121,12 @@ typedef int __bitwise fpi_t;
>    */
>   #define FPI_SKIP_KASAN_POISON	((__force fpi_t)BIT(2))
>   
> +/*
> + * Check if the page needs to be marked as PageUnaccepted().
> + * Used for the new pages added to the buddy allocator for the first time.
> + */
> +#define FPI_UNACCEPTED_SLOWPATH	((__force fpi_t)BIT(3))
> +
>   /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
>   static DEFINE_MUTEX(pcp_batch_high_lock);
>   #define MIN_PERCPU_PAGELIST_HIGH_FRACTION (8)
> @@ -1023,6 +1029,32 @@ buddy_merge_likely(unsigned long pfn, unsigned long buddy_pfn,
>   	return page_is_buddy(higher_page, higher_buddy, order + 1);
>   }
>   
> +/*
> + * Page acceptance can be very slow. Do not call under critical locks.
> + */
> +static void accept_page(struct page *page, unsigned int order)
> +{
> +	phys_addr_t start = page_to_phys(page);
> +	int i;
> +
> +	accept_memory(start, start + (PAGE_SIZE << order));
> +	__ClearPageUnaccepted(page);
> +
> +	/* Assert that there is no PageUnaccepted() on tail pages */
> +	if (IS_ENABLED(CONFIG_DEBUG_VM)) {
> +		for (i = 1; i < (1 << order); i++)
> +			VM_BUG_ON_PAGE(PageUnaccepted(page + i), page + i);
> +	}
> +}
> +
> +static bool page_is_unaccepted(struct page *page, unsigned int order)
> +{
> +	phys_addr_t start = page_to_phys(page);
> +	phys_addr_t end = start + (PAGE_SIZE << order);
> +
> +	return range_contains_unaccepted_memory(start, end);
> +}
> +
>   /*
>    * Freeing function for a buddy system allocator.
>    *
> @@ -1058,6 +1090,7 @@ static inline void __free_one_page(struct page *page,
>   	unsigned long combined_pfn;
>   	struct page *buddy;
>   	bool to_tail;
> +	bool page_needs_acceptance = false;
>   
>   	VM_BUG_ON(!zone_is_initialized(zone));
>   	VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
> @@ -1069,6 +1102,11 @@ static inline void __free_one_page(struct page *page,
>   	VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
>   	VM_BUG_ON_PAGE(bad_range(zone, page), page);
>   
> +	if (PageUnaccepted(page)) {
> +		page_needs_acceptance = true;
> +		__ClearPageUnaccepted(page);
> +	}
> +
>   continue_merging:
>   	while (order < max_order) {
>   		if (compaction_capture(capc, page, order, migratetype)) {
> @@ -1089,6 +1127,13 @@ static inline void __free_one_page(struct page *page,
>   			clear_page_guard(zone, buddy, order, migratetype);
>   		else
>   			del_page_from_free_list(buddy, zone, order);
> +
> +		/* Mark page unaccepted if any of merged pages were unaccepted */
> +		if (PageUnaccepted(buddy)) {
> +			page_needs_acceptance = true;
> +			__ClearPageUnaccepted(buddy);
> +		}
> +
>   		combined_pfn = buddy_pfn & pfn;
>   		page = page + (combined_pfn - pfn);
>   		pfn = combined_pfn;
> @@ -1124,6 +1169,23 @@ static inline void __free_one_page(struct page *page,
>   done_merging:
>   	set_buddy_order(page, order);
>   
> +	/*
> +	 * The page gets marked as PageUnaccepted() if any of merged-in pages
> +	 * is PageUnaccepted().
> +	 *
> +	 * New pages, just being added to buddy allocator, do not have
> +	 * PageUnaccepted() set. FPI_UNACCEPTED_SLOWPATH indicates that the
> +	 * page is new and page_is_unaccepted() check is required to
> +	 * determinate if acceptance is required.
> +	 *
> +	 * Avoid calling page_is_unaccepted() if it is known that the page
> +	 * needs acceptance. It can be costly.
> +	 */
> +	if (!page_needs_acceptance && (fpi_flags & FPI_UNACCEPTED_SLOWPATH))
> +		page_needs_acceptance = page_is_unaccepted(page, order);
> +	if (page_needs_acceptance)
> +		__SetPageUnaccepted(page);
> +
>   	if (fpi_flags & FPI_TO_TAIL)
>   		to_tail = true;
>   	else if (is_shuffle_order(order))
> @@ -1149,7 +1211,13 @@ static inline void __free_one_page(struct page *page,
>   static inline bool page_expected_state(struct page *page,
>   					unsigned long check_flags)
>   {
> -	if (unlikely(atomic_read(&page->_mapcount) != -1))
> +	/*
> +	 * The page must not be mapped to userspace and must not have
> +	 * a PageType other than listed in PAGE_TYPES_EXPECTED.
> +	 *
> +	 * Note, bit cleared means the page type is set.
> +	 */
> +	if (unlikely((atomic_read(&page->_mapcount) | PAGE_TYPES_EXPECTED) != -1))
>   		return false;
>   
>   	if (unlikely((unsigned long)page->mapping |
> @@ -1654,7 +1722,9 @@ void __free_pages_core(struct page *page, unsigned int order)
>   	 * Bypass PCP and place fresh pages right to the tail, primarily
>   	 * relevant for memory onlining.
>   	 */
> -	__free_pages_ok(page, order, FPI_TO_TAIL | FPI_SKIP_KASAN_POISON);
> +	__free_pages_ok(page, order,
> +			FPI_TO_TAIL | FPI_SKIP_KASAN_POISON |
> +			FPI_UNACCEPTED_SLOWPATH);
>   }
>   
>   #ifdef CONFIG_NUMA
> @@ -1807,6 +1877,9 @@ static void __init deferred_free_range(unsigned long pfn,
>   		return;
>   	}
>   
> +	/* Accept chunks smaller than page-block upfront */
> +	accept_memory(pfn << PAGE_SHIFT, (pfn + nr_pages) << PAGE_SHIFT);
> +
>   	for (i = 0; i < nr_pages; i++, page++, pfn++) {
>   		if ((pfn & (pageblock_nr_pages - 1)) == 0)
>   			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
> @@ -2266,6 +2339,13 @@ static inline void expand(struct zone *zone, struct page *page,
>   		if (set_page_guard(zone, &page[size], high, migratetype))
>   			continue;
>   
> +		/*
> +		 * Transfer PageUnaccepted() to the newly split pages so
> +		 * they can be accepted after dropping the zone lock.
> +		 */
> +		if (PageUnaccepted(page))
> +			__SetPageUnaccepted(&page[size]);
> +
>   		add_to_free_list(&page[size], zone, high, migratetype);
>   		set_buddy_order(&page[size], high);
>   	}
> @@ -2396,6 +2476,9 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>   	 */
>   	kernel_unpoison_pages(page, 1 << order);
>   
> +	if (PageUnaccepted(page))
> +		accept_page(page, order);
> +
>   	/*
>   	 * As memory initialization might be integrated into KASAN,
>   	 * KASAN unpoisoning and memory initializion code must be

