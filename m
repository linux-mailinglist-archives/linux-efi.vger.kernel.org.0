Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B7754FD84
	for <lists+linux-efi@lfdr.de>; Fri, 17 Jun 2022 21:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiFQT22 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Jun 2022 15:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiFQT21 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Jun 2022 15:28:27 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3C345510;
        Fri, 17 Jun 2022 12:28:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q725Wyq7WAyFnyPgKz1nu8p4LP17R7mOFRfSD8qnJownUz4UEIIh5UftEojuqpBSANMKhed/qVJpHsKiFLVbbFcsfSPe/MyK85/k4YTwdtlppOn+3DPU1k7keIdWr21fOghAqcgNelYY22+SgnZl9lH6bG1JZaDGTzlvOeQI+hQ5UgGzg0ezO0dH/4zky4ZAALY7pu21b5SIDIoI5WunhalwPIfMDQsuMpj/6P71TRQ3KwwiOiktMc8oR0sWBsRzhx7MuCODDVB0xH2aMEV5XTBlB+O+rr1dgkeUIPl0hX2frpZnEbL1Fv+2XjG1GJX4qt4aIJQT8rI4bAZGkfEdtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cz1u0PvpDxC4/rnVanBgpT5w08uEahfomKTDHyKlIQ0=;
 b=deNloFRqyWb3ninNbmRuD3lEYrNv3mVcGs8DoPHfKXgxzXfazap5u1iTSqJAuDACebIoKb+teyQdo97JUpOSmz0j9Cl3jnwV4KtE/apEf0xCyQEP0NBkofiV/VWVk6EUrBeNmY6XWAFmGMF8d1Wb+c9Q+4633BZ5ToMgCYVkobiLaBFUcYWzKMj2Vqf8FE2eOt0NQyMy6DDURA7Aoap81jeYjJMvQXYwtCZU97StKwnusjoqAD1T3y7LVVc4wZc2NbQSxAK1Qb3IULU3IiAeYzWrnV4e5d0nbMQSGL+emr/zkxR8Pi/+cQ4YWvwPYVVkz8Tta8m/Mk4n/PSRabeVdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cz1u0PvpDxC4/rnVanBgpT5w08uEahfomKTDHyKlIQ0=;
 b=KK9sCWdlgeZf7sdMRygjJ/eb//5yB/6YmldeiTAC/N1Z2v8C9dqwiQ8Z7auNpv9m8aMeF/yjwdiy9dr/DSPiwsSfwWzAcTh10DZngN5E8W1wnTyXmEQRBJV+Rqsgluk5dmum3CNie14Dnaf3FIVQP6KWc2qvndQ/TfNJr0cTalU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CH2PR12MB3767.namprd12.prod.outlook.com (2603:10b6:610:26::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 19:28:23 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::9084:a97b:ab5c:6642]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::9084:a97b:ab5c:6642%6]) with mapi id 15.20.5353.018; Fri, 17 Jun 2022
 19:28:23 +0000
Message-ID: <af8038c6-d14e-a327-7685-14bcee778c96@amd.com>
Date:   Fri, 17 Jun 2022 14:28:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
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
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-3-kirill.shutemov@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220614120231.48165-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::13) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7696e11-142c-49d2-492f-08da50978b47
X-MS-TrafficTypeDiagnostic: CH2PR12MB3767:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3767F1A1256E0F94D5AF6A04ECAF9@CH2PR12MB3767.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RPc7sbdeza4D55/0s69liWWcSd8eFSQbUilxMGAt8GJgnHEuV2PHc2LG8UhOxmvC1FW4zYO+nAZQvOzm9145Bz6dCWIEEhlSpJYaWp36wMYhOGaBh9tsaGExeRpiZDtkJ2cmRLHoFbQCwsd/4cNf42p38n1XbPUoXqq62cFmDqplvDQyW+0RFj2jMXqvQe7p8c8FZB3/7o1eEJBiypMUzlaSLUek505W0NLAn4sCwupvyTUdBaF4TqZJoOr+j/FREOWWCz6+GOP06AI+4iYkzRvF/WKR1AqAvG82wOn+WqlQSGikWq0FrN5hKMu3Ky8qQze0VfMZ2hI2xg+SiObNexYTXUi5MH8hB2qnTvHP1hHnKEJDHUks2qaflkW4E4P8PUutfVgiWFYUgIPFJSNOM2Rw/exSFLWJb+P+zUgpDfdyXBCBvCYcK2HqwLQJPL1Rk2Py2Zu0eusThhSggMhWDAoTg43TkoQnKeV13N5Y2TUUP6S60hwi7bCIVsvGUCsDqBgDYZVbP/5HOSSuSEGdE6WP/K/FtheY4VPe+sWz4H8kehGEigCy7N3QrKDnck2tRWpqaG2u/UeZ9S16OLZwWXMj39qXgiTV2BeJ2huNYm+JhpxLmIWrCKe7vHO87Ff+Yzvn08eVcsX7h8EvdVbnpBDXf1374D3DAP67PY+dX7aKQS18Nne15uUfoOBPKHy9gr2zQFKNKhjjBFn2cU6MonN6xpC05/2TwT8CM/6OprXofw5oGtlioSNszciN9/1W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(2906002)(6486002)(6506007)(31696002)(316002)(7406005)(6512007)(66946007)(4326008)(53546011)(110136005)(54906003)(8676002)(26005)(38100700002)(66556008)(7416002)(8936002)(186003)(498600001)(5660300002)(2616005)(83380400001)(66476007)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzRPNWhMZ3dYNVIwdityMmNYUi9kNFRVcGs5Sy95NFZEbnE3Zk03Q1Z2MElp?=
 =?utf-8?B?NkNEUytsc1RMN2xzOEprelBUTFBuRXpEZG9QeDZpR2ZYNDdKZVVaaUZWMXA1?=
 =?utf-8?B?bDdSVkFiR3lqczEvUVVJNDNnWDkyT2J4MWFtRTFaVkNpbHFncnhDQ3doTUFV?=
 =?utf-8?B?L3MxOGVZZTE4c2REaDRpMnY5VFZvWjVsZ0NZaTJMSVhKd29PNm10SWsyMk1P?=
 =?utf-8?B?bWVZdi9uRmt0bU5Ic3dHN0dPMzNyYkJlSzFmM3VJVjh5U25GamtvanlGZTV3?=
 =?utf-8?B?QjNrMVl0NDhNUitlVGVuVDNpMG1pQmI3czd2WmJEWWdBUWNPa3FHc0tvaTdS?=
 =?utf-8?B?S2FYb3NPUUtBa3JBemtnRlQvWGlGVWE0N29LM2lBYVR6ZWVFMkNHWHczRThG?=
 =?utf-8?B?b2wrQmc2SGt1R2JRUmsxNTJuZTJxdkN1ZElrQ0FnNmFnRU5NK1I0YWdlVnZ6?=
 =?utf-8?B?ZlpLSmk5QXNBTEl2TWIxcXptODNXTEQrbDJSZUE0T1NjaGJxWUFGVFpLSTZk?=
 =?utf-8?B?OWY2MmdFOWJscFZPM0x3MElmNUFMeldjeUFUdzlDejdBUjBIYnRvTm9iSDRL?=
 =?utf-8?B?Z2pRZTlhOHZSUUZBbFVqY0tJaHRnNVFFZndQdjJYQ3kwN0ExbkFPaE02SnZM?=
 =?utf-8?B?R21Jd1VJVUR6ODhHWW5zRVI2aU9XbFZUUUhaV05PekRCNXJyZEFxVUxRVVB1?=
 =?utf-8?B?R1haZ0c5UUNaV1dlS0ZYU1Y3N0hta3hBczBYWEU3ekgzUnlrRlk0L2M0STEx?=
 =?utf-8?B?V1hGemJEbGpEK3JYK09ScFg1WVJhcmJHTzh3b3V2ejRLUVJRZ05kYjlRSTkx?=
 =?utf-8?B?KzJ3NHNyMDZBU2N0eUwzZ2pnTmV2d0d1aFZGQUJ1U1E3c1BzaHJRM3dIQ3Vx?=
 =?utf-8?B?RGEwUG9mQ1UxZDM5Y0sySHdRZEExZ2VOcWx3OGliNnNySDB3TVVFZjB4K1VZ?=
 =?utf-8?B?R2M0TytLQ0pxQXhyZ2JaSHUzakhZS2s0aGg1YmpTS1VsbTM3SHgvaEdwdVEx?=
 =?utf-8?B?NjE5d053V0pmZGM1SjdrMG9Jb2hIMnEyVVpaSTlWSTkyZTFMNnZ3bXYzbU4w?=
 =?utf-8?B?K1kzbTBhM3RkcmlYYkZFM0U2VTFCM1dUeG5EYVBlbnhFTnZhT1JJMHdaYzMv?=
 =?utf-8?B?akNIYWRLeGd2TWJtZ2ExNDVRL08zcmhVMEZJV05xRll0anMzbmJDR1NwRUZk?=
 =?utf-8?B?bHNScEF5K3dsL0FPdmJKeW1oVk9WaWVKSUhTS3g3YzFKTm91NGZWc3plT0du?=
 =?utf-8?B?VjlRZ0RTNW5RYm96cnVLdXlqa2lkdUZyWUZGN0gzNDg1dTVXMW9WUGljaFhS?=
 =?utf-8?B?b3FqeWdRWVJvUkp1RU9ZZVVWdXJLbU1GZnc5S0J5aWhyT0RRczNiRU1TZ3Bp?=
 =?utf-8?B?V1N3VTBubFh2NHFxUEFTcTl4RTVhNlJJbEVRQXZiYnVFZEZ0ZVEvUUltUlhr?=
 =?utf-8?B?UkJaaXpFcEIrN21VYUtuMkdZblAwWlpkOEpITEg4MkVhcU9TWGFxN2JFL0dB?=
 =?utf-8?B?T3BManFGU21hMUVOOThXQ0wvZ0NTaFdVNFUrMUxENFJVTVNpRXFXQlZreXcw?=
 =?utf-8?B?bFB0NlVhckdqMkZUUUtXWFZaMnJzbjhuQUhTQVEza1pxMzRDR3BLWjhLbDg3?=
 =?utf-8?B?bzg0OFozNkp4eUUwL2xURXpJTmpjVS9iU3YyK2ZmMzNXN2JOVXlzQkhKTk53?=
 =?utf-8?B?bGdhZjNvNGZSR1I5bWI3TVBSRVdORkpJaVZuTmhudnpYNnU2R3Z2MlBIcld0?=
 =?utf-8?B?OTUvUW5KY0ZrdVA2UGZzK3RlZm54Y09FUzA5N2ZlTlNyOVBqNzJpeFBKa3E0?=
 =?utf-8?B?cTgzb0xQdTg5bFdUMWx2bzVqak1lb1N3VjNRQzhkTGdnUXhqVjdnRXM3ck1Z?=
 =?utf-8?B?RFY1Ynd3anlyMktZNFhValU4WUR6YzlYVUhUKzY1Z1pUUnFDRVdqYXltMndw?=
 =?utf-8?B?c2FNNDc3eW1YMUpXNWk2RENJNzBnc1ZKbi9sQjJjMVl4Q3N3NjlHdXhxQW1p?=
 =?utf-8?B?dURoN3dMMkJzY2x0NkJCbkJCMGVScGVZVTNqZ2tyRlBHU1REbS92YVQySSts?=
 =?utf-8?B?bnViQlRHSFl3aGlJaDBNRjdzVlNLTlN6UVJEci85UWdJeGNwOXRYUzRzSVpS?=
 =?utf-8?B?V1lVRzBEMkVQQXpiSlRhZWlRTUNEeXNsbGtJejg5OC9EbExwYm02WWFKV2hp?=
 =?utf-8?B?cVBhd2lXRWp4WUJxV2Q3bUsvM2FWczE1N0szaTdadWQreG1GeWRaTU41REtP?=
 =?utf-8?B?N3pXVlptMGZmNkJqUXk2Y2VvM0tNMDJzTnNVNDNHbFRocG8rNHlEaTl1SUg5?=
 =?utf-8?B?eUhSa2FTdFZ1bGt3VTdTQWtRSWJoQmM2QktNTU1DUGpHanJiU1hrdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7696e11-142c-49d2-492f-08da50978b47
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:28:23.5379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwHdOcKe4xQ0vZoR0bJ8AEhBw9dbWZcPPLM6Q72ueRIpSCC/dcVSaiiHSfgKXa7yl0vo+wc6VBl7t6GVSomCfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3767
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 6/14/22 07:02, Kirill A. Shutemov wrote:
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

The SNP support will kmalloc a descriptor that can be used to supply the 
range to the hypervisor using the GHCB/VMGEXIT. But kmalloc won't work 
when called this early, so we are likely to need an early_accept_memory or 
some kind of flag to know whether this is an early call or not in order to 
use a static descriptor in the file.

Thanks,
Tom

> +
>   	return found;
>   }
>   
