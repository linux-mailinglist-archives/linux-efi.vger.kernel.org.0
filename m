Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A958F54B1CF
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jun 2022 14:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240096AbiFNM55 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Jun 2022 08:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244238AbiFNM5z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Jun 2022 08:57:55 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::61e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDD62935A;
        Tue, 14 Jun 2022 05:57:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nt10oC6AIjK+MFLtsXeCcEtijgEjWI5ULv9XCVm8Mxe2wjg+1DQF0K7tMsNt0GMWk4bRNko1Wdu08J/2lmA7sh+DknOoT112/RCwNULPrc/v5wFOwSCQdnO1PvV2nu+J72o/jgXJnPXdHkh6JNQWtgMEsOhbGjRbYmqYc3BaCe3tut8i4Sf/kM0Y4/b0PwT+Q7e/Y8+4Pr6YVf+zGorcyDm5yyZgmX603fMHxgt2/LukRr3MEAeMLgVyccdQDXZerXDdDhnfhNuf/O5EYJFWRWhP9pRqI5ABr7S1qtVWXA/rKc4CUKiqiOmkJLZAcNB9bxIotc6nF0OlaKab0y8vzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FV+2zVi/9IuZPpPH1x2eA4vD1Kj44SJtw3gYm8LoRRs=;
 b=SrmWo+LkErcKjKx9toGXb0NInkIPmGZZQurMZ+Y34WaR2ryDGDuXTEl+Lsu144lrXp3x8q/L7FxiA5NGjW5eRY7MLLPiWJZftOg6BqEvA3dsDZzrXQJ9T25mydkqXOeOohRZWGFODDzLQ08lclMVOoIibr5a+pcBKeFCi/kKbAyDTYRsufktCRfTPAsM+fvor3ycNSxSdjjTsJ3e3UjCYffgl6ILmWdqkqu7c/dTmwaamTqFYWCtD7HNqk0yQWJt8UNsPD0w/677cSaL+MdUlFy+oWdQGypFydIbAUGsM692uoxNTN55VQilXQG5R4cQfrbDl9mTIBqi0P+CA7/2ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FV+2zVi/9IuZPpPH1x2eA4vD1Kj44SJtw3gYm8LoRRs=;
 b=zsZg6ooC+WmyN5WlsRpvp7x3ThtxcyQfIKM9lBWMqlA2/t5GSog9WSKRYX9cFXW8pm3heGnb+PQt17I0fwXGll/zaSl5hQ0oZu+Sqfq9b9vAjXSx3LaR11LG+B4OM9L1ejPi/+UuaIADJP6PUrkpOZBeD3kJSjehww8uxSIJicM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by MWHPR1201MB0270.namprd12.prod.outlook.com
 (2603:10b6:301:4f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Tue, 14 Jun
 2022 12:57:51 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%9]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 12:57:49 +0000
Message-ID: <e1c19522-8006-f02e-c8a4-c3d1b8067482@amd.com>
Date:   Tue, 14 Jun 2022 14:57:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
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
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-3-kirill.shutemov@linux.intel.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20220614120231.48165-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9P194CA0022.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:20b:46d::28) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a24b1b9-22f0-40ba-5601-08da4e057c00
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0270:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0270376E023E4E79F2F964159BAA9@MWHPR1201MB0270.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7wJV9jfWEBwkEWMbSiqK40+22MPjA682aplGVhFQMcOsjHl3CRiMk1L390UDrs1EZJ5m/HWVi98MnCq1l92nKReCXFHWi3WnpYlhrRwzGgf6hbcmSNTm2m3/8grEKgCxReUVgsscfuieMNFKipr8vRk2wYX5gtZwc7Wlg5Xnubleb4Z3HKOhIdY5L86GF//R/KAVxVS6mWb1YMIgFmr/ApDfEd0yZe9MfUlaJLeAS+M1+2ZcphZfxadVoEOnpx9/NSk7LLm0n4xaABcZR8tMa/ZEvuBO5+dhKSSpMqoLtsZ4eUIURUU3z5+6b3dQTiewCJ65LPW63x5acZJibnIrO0RB5oh2YGbIC8bIxfUH5RUYrX/Tv4bOSRuq7ez+rzxw9PaIQYvWivgGfQbGNmVAqwIid6E1YkkhOoaL1t+9ncTYTGloTa5Suddp/OJYgc+Wl3vsL3JHsMgKkthHqxp5VjHPc7V8ehjHUmwws+YMYquSaaUBLa6Bvsh9yADNOrUDwTHf8kzHO3Kb3qCX459AJwKD1qupm4PL1NlDpdviI9WMUHCJwf1Zfjh9XR8Eiq6aGykLdlzQt1+qdaC7Zgrhdd5vHRT+2L6NX+7VVwjJNqXcbtjdE0/qROugNF0ry+RkpEWJVSVoC5TspxZX3GxiebmEEUvpNdeuIdGM09A55c5YCaRVVuZXohfpsgo7oe4Kod9qfXhLm/4FXcUWrB/J4/5G1UEZMuaDndCIvrF7+tw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6486002)(508600001)(2906002)(8936002)(54906003)(6512007)(316002)(31696002)(2616005)(83380400001)(66946007)(86362001)(7406005)(36756003)(26005)(5660300002)(66556008)(8676002)(7416002)(6666004)(31686004)(66476007)(38100700002)(53546011)(110136005)(30864003)(186003)(4326008)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHRRRlY1anJaWWwzWkZDempkYUVtMWdEOEtKWlFWSXc3TVl6bk82TUdsLzVR?=
 =?utf-8?B?aVJOZi9ZT2xFZVE1K0ZRUFZtUUlSKzNEUUN4b3huNjg0QXN0YXplMExvQUt4?=
 =?utf-8?B?RUZMZE9IY2xXdWEyQTNzZGdocUF5UHZvajJuRWZIbWFoODZKQ2ZTa1dsMC9N?=
 =?utf-8?B?dkpOa3FKOHZkVHNLUDVRS0loZXUveTVDczZjTGhPYUV0aUxWejI2dGtXNXRH?=
 =?utf-8?B?SWZ3am8vek9EWjhkazVnd2d1aEwzSWtoK3BPZ1UyUUhQcmt1cHg3QXRYMmg1?=
 =?utf-8?B?QjMxdEtEK2pyZmllaXhxWkk3amdjWlNLZ1VpVERoZVJKd21ZTjd0RDBJajRq?=
 =?utf-8?B?bDYxbDkrZ05WOUZybFpXVm1jSWRzaUJOUkc2d2VUSzZtYmMzb2c5VUR5cGhJ?=
 =?utf-8?B?VVhrWGQxUlZzTm5SaFR4NkZ3Wi96dUpUbVdwTit4THlLMmVmU29JQVd1TTJ3?=
 =?utf-8?B?YlBwNWtwZE5ybFRLYTRtV2JPQml1VkhoZU93bE9vSGtxemNqN01jWTNkaXdl?=
 =?utf-8?B?NmhFSFNFWVZ2bU1GcDhEOGpzVFo4WEdNM3Jnb2h0REtaRTR3N3cyMEx4TzF1?=
 =?utf-8?B?a1dLQ1lkN1Z4OW9iNlRyTHE1YWZlTzFreUJtT21Zd0k0Q0xwQ2hXUnRWSWxP?=
 =?utf-8?B?akxtd1d2ZC9JL2Y5bVFkcnhtdzVTVXJuUkFLcFRJUUNsYzdvTm9DdlR0OFlu?=
 =?utf-8?B?MmpEbmR0aWgvdDR0WTZiYVg1aXU3UjJ2ekkwc29YT0lRTktJT1MzN2pyUnlQ?=
 =?utf-8?B?TVhsWEpRWDg1QjdYSFVBcVNnQlFsQ0h2R21nNjJEdnFib2MwTDZBak1ickNj?=
 =?utf-8?B?V1BYUHM3MFRwamU5SExhaSt2Umo2RnJtc3dGaFhJajd2blRST0xmbmpneGE4?=
 =?utf-8?B?Y1p0dW9XaDdBZjZRT0l5WlFFVHNIbjltdWNjVXVvYlVra3JTLzR6RnlCdis5?=
 =?utf-8?B?TDF0YVc5UnphdnlORDNMTUhxcjlxSCtIS0NNcHZlVlFLTlpWaXFFMGFaM0lr?=
 =?utf-8?B?MWZoOUhzYUlRdDdYc09HRTd0Rm1uSEVqaWlaaHRWQTZQY1F6T0R2VTBtNWpx?=
 =?utf-8?B?elhJTmE2cUlWY2Y2emo3TVcwR3FLVWFlcVB3WWJ5MmplSVlyL2x5MklhOURT?=
 =?utf-8?B?YUpGUGVhaGJUQUJ4RXhRYmVLNUtGci9Cb2xDTDBVTGJuNHBCYzlRdUZmRFZz?=
 =?utf-8?B?TFNDdGtkaWd6VDRMa211eSs2RTVSbmNGZ2xleDlWS3NzOUtKT2E2NUZWM0NR?=
 =?utf-8?B?RVdaaERFK2Nwb0JFeTgvN2ltWGYrL1ZjbUhXYUJaTU1qMUNVZkU2ejJJZ3I5?=
 =?utf-8?B?cTlFZUZObCsxaUttRTdoNEpqakhTaXlPUXBZaEJ4TEl3OGNjZjRYRTdxRWV4?=
 =?utf-8?B?dDdVcGdvN0VJTU1xbVpKdldhdThOZFlhcjB0bG9vWlMyZVppTlh4aUZwWlpC?=
 =?utf-8?B?Szgwck1xYXZnQlJvYjNGcDQxcmhBZEZUa2V2YStFcW9LakVDZjM0L2xUYlhz?=
 =?utf-8?B?aGdNQ0xJMEZrNEZ3Y2NFYVAxVVJCT1YzdjlVRllDOWtFOWJBSmtCRGxZcjlL?=
 =?utf-8?B?YjZ3OTZPSWpUa01DbE85SXdoNTJzSGtQQzdYYTd5UnM4SlJZc015U0grb1Bm?=
 =?utf-8?B?K1g1ZjFTblFpeU95dTR6d1pwWndNbnROYmhnRkVYcURZclBacWQ4S3h1S1dl?=
 =?utf-8?B?T3MzbVB5L0t2d1BOcENPSHlkM1l1T09ZTVRMZ1FsekViVkVaWG9kUGdHaTEw?=
 =?utf-8?B?Q1FTaENnalNlejhsYVZEZXc1SHA1ODFreWwzd3JaMEVaVWYyYy82TXJnK01V?=
 =?utf-8?B?M0Z6Ym4wdUxHYmVXNiszTFViaHdjTXh5OU5oRElPWmVHZ0c2aHBVcXU2aUxJ?=
 =?utf-8?B?VDI3WUhMS2Y3cFZHTDBUcWJ6eFpMTndHYW1YenYrVVpQQjU4WHl2MWx4SHJh?=
 =?utf-8?B?WmZZazlycEpTRUxEdDcvU1RUUkxBVmNsMHRDQmtlajN3dGNLcTU5RGJwcDJu?=
 =?utf-8?B?L3AwOUsyTmNMSXZsckdndnNvL0YxTUsrcTBSdjNwR2FCZUU2ZWluMFFqZlMy?=
 =?utf-8?B?R3VIZXhNNXBtVVdFSkRyZDljMVNEcmZYVWUzTkUyWGJUU3h4VnZzV3NuQkcr?=
 =?utf-8?B?TjFLaVVBdEs5OEU5SjZUZGJGbzRqZ3JENEtkZnlYZG5MWHRIWTV6cWF2TG5T?=
 =?utf-8?B?TDhtMXJDbHFIUlVSUFBvUUtuVThBUmUzL21zZHVsV0x3ZEJzNTlaN2Y3cjRU?=
 =?utf-8?B?L3pUZGpscEVvOFFvNzJLUFJJeHhpdFd5TmlyZ3MyekNpTTFXa2lYWVg1ekdK?=
 =?utf-8?B?Q2RUdmVtc0cxQVlHcVFrMTE1bnV2S09tajJFL056TEFXS2FKQlZkQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a24b1b9-22f0-40ba-5601-08da4e057c00
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 12:57:49.1827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsfgwnroH4yv/Rs2Ogq0FyjNMBu2/dE6AWjtfBCkkJwRSgUDiz0sW5sbm8U4RaTvw7efrngi7n5cfJB6x/Ag9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0270
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 6/14/2022 2:02 PM, Kirill A. Shutemov wrote:
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
>   - range_contains_unaccepted_memory() checks anything within the range
>     of physical addresses requires acceptance.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>   include/linux/page-flags.h | 31 +++++++++++++
>   mm/internal.h              | 12 +++++
>   mm/memblock.c              |  9 ++++
>   mm/page_alloc.c            | 89 +++++++++++++++++++++++++++++++++++++-
>   4 files changed, 139 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index e66f7aa3191d..444ba8f4bfa0 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -942,6 +942,14 @@ static inline bool is_page_hwpoison(struct page *page)
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
> @@ -967,6 +975,18 @@ static __always_inline void __ClearPage##uname(struct page *page)	\
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
> @@ -997,6 +1017,17 @@ PAGE_TYPE_OPS(Buddy, buddy)
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
> index c0f8fbe0445b..7c1a653edfc8 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -861,4 +861,16 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
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
> +
>   	return found;
>   }
>   
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e008a3df0485..279c2746aaa8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -122,6 +122,12 @@ typedef int __bitwise fpi_t;
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
> @@ -993,6 +999,35 @@ buddy_merge_likely(unsigned long pfn, unsigned long buddy_pfn,
>   			NULL) != NULL;
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
> +	if (!PageUnaccepted(page))
> +		return;
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
> +static bool page_contains_unaccepted(struct page *page, unsigned int order)
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
> @@ -1027,6 +1062,7 @@ static inline void __free_one_page(struct page *page,
>   	unsigned long combined_pfn;
>   	struct page *buddy;
>   	bool to_tail;
> +	bool page_needs_acceptance = false;
>   
>   	VM_BUG_ON(!zone_is_initialized(zone));
>   	VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
> @@ -1038,6 +1074,11 @@ static inline void __free_one_page(struct page *page,
>   	VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
>   	VM_BUG_ON_PAGE(bad_range(zone, page), page);
>   
> +	if (PageUnaccepted(page)) {
> +		page_needs_acceptance = true;
> +		__ClearPageUnaccepted(page);
> +	}
> +
>   	while (order < MAX_ORDER - 1) {
>   		if (compaction_capture(capc, page, order, migratetype)) {
>   			__mod_zone_freepage_state(zone, -(1 << order),
> @@ -1072,6 +1113,13 @@ static inline void __free_one_page(struct page *page,
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
> @@ -1081,6 +1129,23 @@ static inline void __free_one_page(struct page *page,
>   done_merging:
>   	set_buddy_order(page, order);
>   
> +	/*
> +	 * The page gets marked as PageUnaccepted() if any of merged-in pages
> +	 * is PageUnaccepted().
> +	 *
> +	 * New pages, just being added to buddy allocator, do not have
> +	 * PageUnaccepted() set. FPI_UNACCEPTED_SLOWPATH indicates that the
> +	 * page is new and page_contains_unaccepted() check is required to
> +	 * determinate if acceptance is required.
> +	 *
> +	 * Avoid calling page_contains_unaccepted() if it is known that the page
> +	 * needs acceptance. It can be costly.
> +	 */
> +	if (!page_needs_acceptance && (fpi_flags & FPI_UNACCEPTED_SLOWPATH))
> +		page_needs_acceptance = page_contains_unaccepted(page, order);
> +	if (page_needs_acceptance)
> +		__SetPageUnaccepted(page);
> +
>   	if (fpi_flags & FPI_TO_TAIL)
>   		to_tail = true;
>   	else if (is_shuffle_order(order))
> @@ -1164,7 +1229,13 @@ int split_free_page(struct page *free_page,
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
> @@ -1669,7 +1740,9 @@ void __free_pages_core(struct page *page, unsigned int order)
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
> @@ -1822,6 +1895,9 @@ static void __init deferred_free_range(unsigned long pfn,
>   		return;
>   	}
>   
> +	/* Accept chunks smaller than page-block upfront */
> +	accept_memory(PFN_PHYS(pfn), PFN_PHYS(pfn + nr_pages));
> +
>   	for (i = 0; i < nr_pages; i++, page++, pfn++) {
>   		if ((pfn & (pageblock_nr_pages - 1)) == 0)
>   			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
> @@ -2281,6 +2357,13 @@ static inline void expand(struct zone *zone, struct page *page,
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
> @@ -2411,6 +2494,8 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>   	 */
>   	kernel_unpoison_pages(page, 1 << order);
>   
> +	accept_page(page, order);
> +
>   	/*
>   	 * As memory initialization might be integrated into KASAN,
>   	 * KASAN unpoisoning and memory initializion code must be

Reviewed previous version(v6) of this patch. Seems no change in this 
version except '!PageUnaccepted' check addition in function 
'accept_page' and rename of function 'page_contains_unaccepted'.

Acked-by: Pankaj Gupta <pankaj.gupta@amd.com>
