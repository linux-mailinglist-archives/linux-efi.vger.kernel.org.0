Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3366A709AF6
	for <lists+linux-efi@lfdr.de>; Fri, 19 May 2023 17:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjESPNL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 May 2023 11:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbjESPNJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 May 2023 11:13:09 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C51F121;
        Fri, 19 May 2023 08:13:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgYZOUGVOTKqNGEMh3xCQ/0uBgG5TRCj/YtKpQTEoOdcCaOXZ80WcNm2rbcs8zSbShQOqQd3PAMmeIm/zGVI6+wAEqqR4/aL1pkBoeZlN0je6T3OrRWO6zwqf2DIaPnovVNZlyCKpYbxv1LYjQ4WRAHirqibbadhosroETl9PQe1y48ENzLxaj8rJXQnPLQ41F5NHcCPlkRiIC31vtbkmhVoXpLQYYPyK5M801ojOrm0fCvUl10ES/Ps+tuj+Q/OM035woZvFwBgjUFPDL5bY5f/3ddYY+omtpE++MfPTB1ydl3JdzC7tIHBQDYUMwzkhI58KRMIfEX59zAZjnKCaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmBmUGqRxl1GFSqu7sLFMNdcH9s/3Do5R8nbzLIS9v0=;
 b=WzrGufQf4yn4FSz6GgrGR42kQQUnxix5EvdvVZcoXvBBUTkzByKwwNlrjShLbT0nhBfFRD9+pom3cE7br4BYsUmnpeOqnqdHLrXN9GjtC6Tm+8/tMZBIj/xMb6m0GXU7pAKLOo4pB/S1yK5JMbMp0SiUrHz6VPgmynfCbwLQCbYZo8Rp5dO4BvIbO31ICPAl4pbGC7P1GaDhibQ2OmYBPP/l8oD5/yi8U7BuunNKBOmNv/BUGmHteKVqrN8K/hrAdp+cdEvmZD3gj6KpvhkrFj7hJCz4yL+oKte3v1sG1P7Dy2nwkz69yXL9OZ3Cd4ufpgNeG/+otlwCi2pzfMAmlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmBmUGqRxl1GFSqu7sLFMNdcH9s/3Do5R8nbzLIS9v0=;
 b=4qK1s4rd5o9+JJb5E2ZTGX8RBhAweZQWumUMD6r6mzqPhZmbpQfhkDngH2t24JNGkOtzNCcbXN0rXPltLBnNgnygcNgzO0WVr9641WzScLCvW79KTNrdsotFfEOoATRfBqRPwH3eqkpaoaChc2G3kGJ9blmYgTkk6oY4RFVZ9GI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.37; Fri, 19 May
 2023 15:13:02 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 15:13:02 +0000
Message-ID: <7adbd915-5f3c-b21c-d09c-556a25686eaa@amd.com>
Date:   Fri, 19 May 2023 10:12:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCHv12 3/9] efi/libstub: Implement support for unaccepted
 memory
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
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230518231434.26080-1-kirill.shutemov@linux.intel.com>
 <20230518231434.26080-4-kirill.shutemov@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230518231434.26080-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::15) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f42e83-0d20-4867-1f01-08db587b89ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ADJa1qq5zGYyOA2eBT37BbBK266h5u3lxhpTcTL9IWWg9ykHE7cr5qCVlObhdeR0nXrmNYrp/FZ7vAUW/Tbz0EmbctBf8rMxLMFYMr8INBNsdIDUHwZqUJs7yuHNvN0ABEyhZrBfOWvqJ39SuXkUWwnH/rK65biU3aRGNGG0IBH+GbPpZyqPg0bJY5uhaQ51ylvhsdLLUU40tnPQBlXYV9MwOmoNWeU0fMN2WsvLYlk+Ep9CbrHNKZZWisHvdMsrOJa3ODoyb+UCkIyK6qgXTxPskvfVANdhiknsTSBDz/lXeFMTEdV1yelEqNtMP4PkQ9W79DnboIQSLakiTySHSIh8miyd04/oBEYRONmMWsI2gj6qpqo++lskXXqHpYATbBTWlMMFdDSPjuZyxUxOC80PXVjbAa6iuhylfJs8HKTwQyCZdDPseo/kkgftCdUgc9nQmr5suKFtAMZoj8yydx08A1WoFBH0h7dwhuk/R716/jvgCr/3Zn2jMdjdp9yaUNcWemVMuOSZfzekSO63zROQj5oXzWyu2XnxdAtDlruWDsGw0Qqeuf8YC/y2sc/lXqcHBNe+JK0GB1kFqrY8D/V6SJ+gCjt41naRz1mLw242We6D+RrHFFZ2+ikxcBDact6fyxMFVK5rXq9Lk8rYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(6506007)(26005)(6512007)(53546011)(36756003)(83380400001)(31696002)(38100700002)(86362001)(2616005)(186003)(7416002)(110136005)(7406005)(8676002)(478600001)(30864003)(2906002)(31686004)(4326008)(316002)(41300700001)(8936002)(54906003)(5660300002)(66556008)(66476007)(6666004)(66946007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUxVdDk4SFNrc1VObndRVmRrMzQ0MFozSkFkMXBSbkJwRGZyODU3WUxEdUNC?=
 =?utf-8?B?cVdaNmRqR3pybTRlQjFBK1htVmlVSDRHYWthVGJQQU5pWEZXdnFhVFg5eWRy?=
 =?utf-8?B?VnZUSnFJMjU1ckkzejROdEF6Z2JZTGQ0MzRNUEd3MGhUbzFSSDlZUVRVc3FG?=
 =?utf-8?B?S3BiNzlpR2JWSWdzeFdSdjhET0VVZHhFYmRReHZJeGhCRDh3K2RZVXkrZ3dO?=
 =?utf-8?B?UXlERHlQa2toU1hlNFVhZlE3R3d2OHNYTWtGaHg0U3RoVG1pa01yVGxwTEN1?=
 =?utf-8?B?eS8yR0tUYWZBZWdMTnVhZzZmMGNrdXA2bG9MOGI0MzQ2NUd4Nmd2bTRseDl3?=
 =?utf-8?B?N3BDVFgzdU8rVVZPdEFCMGIvT0NYMWVCdW1mUG9kcFMvSzF1ZHlDT1NmZEJB?=
 =?utf-8?B?UXZhak9SZkNQVnlIWHRlU3FCbmtIWWF2R2VGd0NyeHhDRzJuRGIrL2VGYVp1?=
 =?utf-8?B?cWhBSk9LUEdkL3dycGw3cUxISU11dDdmajhzVTF1RkNZS3l0WkF5VzdORUUr?=
 =?utf-8?B?QWlOd1ZRc0N0TTdzZjFlUVZpSlRKWFdhSFgyMjFRYVZ1SVBGMm9JdEtGYm1O?=
 =?utf-8?B?aDl1d0lxaVJjYndCNnlvYVNobUhPVFN6elpNcSs5dG1MUjk4eER6SUo2M0da?=
 =?utf-8?B?dHdNLzNiM1BOZ2lnOTFMWGRXYi9zTmVvNEVuNXZyT29FWERpd081MUdyaHIv?=
 =?utf-8?B?OTVZMmZNemZGS2Fycm1ndjBjbTNOUjB6aTdWVjBxVEJGMDFMTTFJOU1yNE8v?=
 =?utf-8?B?cnYydis1RUw5TjVwRGxoS0poUjJ0WkZwU1g2dHVwUnpVaDlxdUdJT2cxNXdr?=
 =?utf-8?B?SnhSTXpZWlN1UXhzTU9tUnpidTNEdGNFSElKc3ZjZExFVm9mSVJ0elY0UytV?=
 =?utf-8?B?a0hZcWhhbWpJS3JYYkZncmM5Z2JuVlpkaHZJVlFqKzRaSkpZTzZQa1lDNW1Q?=
 =?utf-8?B?N1V5NkdZTHRySGZZT2FBYWh4SXdyQzdyUGQ0eXplQ3JxWEtPOUxFeThpZnk5?=
 =?utf-8?B?cnNkRmhaaUVQaGJ2ZWxvRHpaYWZkdzJvWU9YYzIzbnZjZ3pCbVVOWktTc3lx?=
 =?utf-8?B?R3FjTmJ3dytRb25LbmJGb1duSlJQS2RFb1o0amNiM3FmaHVoeE00N1dGZjBv?=
 =?utf-8?B?a3UyVDcwR3VnWHlDRHdMS0s1L3JRZkw1UEZ2MHI3bzFLQkREdWRSSStRQ25p?=
 =?utf-8?B?OHBZdnV4eXg2Vm5LaUszTGsrS1V1bDFNQUhVUGwxdVZXRC9KL09kd0gwdjJy?=
 =?utf-8?B?Q3k0ZGpveEo3ZmRaekRXZ3ptMFFVK3drVUtGM3dRSGlKRVRtU1ZkanhzSEtF?=
 =?utf-8?B?RVpScXdDV0pQM0UvSjBKVTlJa0pMVkc4dDVtZjhuMlZUdFFYNDVUT3d1bm42?=
 =?utf-8?B?RWM4eU80aERMNkI2MitkTHFLM0VVQlIzVXYyQ2EraUM5T0YrYkpTYStXRmVC?=
 =?utf-8?B?MkgyMCsvSlJaTGlrenpqeHUvM1A4V0pLUnNCYTlKU2NoQ2RXN290cW5KZWFB?=
 =?utf-8?B?RDZKeXFFQ0tmSHQ0U1VNZkZ4OUQyYUhwOU84dmFLL0lMZFowT1hhMFFTUlRq?=
 =?utf-8?B?N3N5TmdkeExDZk1oZmFmRmQ0RlN5KzRtNW8vUFd6SzdaV0djOVovLzlZUkwr?=
 =?utf-8?B?MSsxU0c5WVVyWWp4YzVyOTlMZm5jQmp2M1BENGlUaG1DQjhtNXI2UEQ3S21X?=
 =?utf-8?B?VjNNVFJ0VWpjUmg1ckJSQ0QrYTFibWZ5dDRqbUJxaWNPYTZ0Nk9sRnRxczE0?=
 =?utf-8?B?Y1NyZ1hQazFydEtFWGZQRGRmSFUzQW96ZGhabGxhSTdUTzN2TmZxQXBwcThk?=
 =?utf-8?B?ZXpDUTdZTzEyY0l3YmJBeG9hSit6VmdKWW8xV0kvK2JoZXJMYlJQRVFYdDdX?=
 =?utf-8?B?Z2tVT09OUVlHMXZRZUF0TVArSER3c1FrVUt3cm9ENlRid21naHlCQ1hya0JI?=
 =?utf-8?B?SG1nZkFhUXdqenJzeExQRWhmN0ZVamRIaWtESVZxbnUxWDZIVWRRVzZyOVlJ?=
 =?utf-8?B?cFlHTStpd3A1ZGNmOHFLSjV2OVd4WlBBSUlYMFY0OHV2cXFEWm1aWFF6L1NJ?=
 =?utf-8?B?VXBuZ3ROeDhMNW9uNndKWVFieVZFKzlGbHRraHlpUFVGN1FFTFJ4R0NLNXdi?=
 =?utf-8?Q?3/KFBFmsqlSVJT//d26MEN6bh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f42e83-0d20-4867-1f01-08db587b89ab
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 15:13:01.9419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjbfyDSJzbYduT2dsKprdYSVY41CAahi7t0rLUdnhFyS2PnV2mzzMo4cZt99KXA2ZbpRuEANwFri7IDWIPlr3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/18/23 18:14, Kirill A. Shutemov wrote:
> UEFI Specification version 2.9 introduces the concept of memory
> acceptance: Some Virtual Machine platforms, such as Intel TDX or AMD
> SEV-SNP, requiring memory to be accepted before it can be used by the
> guest. Accepting happens via a protocol specific for the Virtual
> Machine platform.
> 
> Accepting memory is costly and it makes VMM allocate memory for the
> accepted guest physical address range. It's better to postpone memory
> acceptance until memory is needed. It lowers boot time and reduces
> memory overhead.
> 
> The kernel needs to know what memory has been accepted. Firmware
> communicates this information via memory map: a new memory type --
> EFI_UNACCEPTED_MEMORY -- indicates such memory.
> 
> Range-based tracking works fine for firmware, but it gets bulky for
> the kernel: e820 (or whatever the arch uses) has to be modified on every
> page acceptance. It leads to table fragmentation and there's a limited
> number of entries in the e820 table.
> 
> Another option is to mark such memory as usable in e820 and track if the
> range has been accepted in a bitmap. One bit in the bitmap represents a
> naturally aligned power-2-sized region of address space -- unit.
> 
> For x86, unit size is 2MiB: 4k of the bitmap is enough to track 64GiB or
> physical address space.
> 
> In the worst-case scenario -- a huge hole in the middle of the
> address space -- It needs 256MiB to handle 4PiB of the address
> space.
> 
> Any unaccepted memory that is not aligned to unit_size gets accepted
> upfront.
> 
> The bitmap is allocated and constructed in the EFI stub and passed down
> to the kernel via EFI configuration table. allocate_e820() allocates the
> bitmap if unaccepted memory is present, according to the size of
> unaccepted region.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   arch/x86/boot/compressed/Makefile             |   1 +
>   arch/x86/boot/compressed/mem.c                |   9 +
>   arch/x86/include/asm/efi.h                    |   2 +
>   drivers/firmware/efi/Kconfig                  |  14 ++
>   drivers/firmware/efi/efi.c                    |   1 +
>   drivers/firmware/efi/libstub/Makefile         |   2 +
>   drivers/firmware/efi/libstub/bitmap.c         |  41 +++
>   drivers/firmware/efi/libstub/efistub.h        |   6 +
>   drivers/firmware/efi/libstub/find.c           |  43 ++++
>   .../firmware/efi/libstub/unaccepted_memory.c  | 234 ++++++++++++++++++
>   drivers/firmware/efi/libstub/x86-stub.c       |  13 +
>   include/linux/efi.h                           |  12 +-
>   12 files changed, 377 insertions(+), 1 deletion(-)
>   create mode 100644 arch/x86/boot/compressed/mem.c
>   create mode 100644 drivers/firmware/efi/libstub/bitmap.c
>   create mode 100644 drivers/firmware/efi/libstub/find.c
>   create mode 100644 drivers/firmware/efi/libstub/unaccepted_memory.c
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 6b6cfe607bdb..cc4978123c30 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -107,6 +107,7 @@ endif
>   
>   vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
>   vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
> +vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
>   
>   vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>   vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
> diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
> new file mode 100644
> index 000000000000..67594fcb11d9
> --- /dev/null
> +++ b/arch/x86/boot/compressed/mem.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "error.h"
> +
> +void arch_accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +	/* Platform-specific memory-acceptance call goes here */
> +	error("Cannot accept memory");
> +}
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index 419280d263d2..8b4be7cecdb8 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -31,6 +31,8 @@ extern unsigned long efi_mixed_mode_stack_pa;
>   
>   #define ARCH_EFI_IRQ_FLAGS_MASK	X86_EFLAGS_IF
>   
> +#define EFI_UNACCEPTED_UNIT_SIZE PMD_SIZE
> +
>   /*
>    * The EFI services are called through variadic functions in many cases. These
>    * functions are implemented in assembler and support only a fixed number of
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 043ca31c114e..231f1c70d1db 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -269,6 +269,20 @@ config EFI_COCO_SECRET
>   	  virt/coco/efi_secret module to access the secrets, which in turn
>   	  allows userspace programs to access the injected secrets.
>   
> +config UNACCEPTED_MEMORY
> +	bool
> +	depends on EFI_STUB
> +	help
> +	   Some Virtual Machine platforms, such as Intel TDX, require
> +	   some memory to be "accepted" by the guest before it can be used.
> +	   This mechanism helps prevent malicious hosts from making changes
> +	   to guest memory.
> +
> +	   UEFI specification v2.9 introduced EFI_UNACCEPTED_MEMORY memory type.
> +
> +	   This option adds support for unaccepted memory and makes such memory
> +	   usable by the kernel.
> +
>   config EFI_EMBEDDED_FIRMWARE
>   	bool
>   	select CRYPTO_LIB_SHA256
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index abeff7dc0b58..7dce06e419c5 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -843,6 +843,7 @@ static __initdata char memory_type_name[][13] = {
>   	"MMIO Port",
>   	"PAL Code",
>   	"Persistent",
> +	"Unaccepted",
>   };
>   
>   char * __init efi_md_typeattr_format(char *buf, size_t size,
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 3abb2b357482..16d64a34d1e1 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -96,6 +96,8 @@ CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
>   zboot-obj-$(CONFIG_RISCV)	:= lib-clz_ctz.o lib-ashldi3.o
>   lib-$(CONFIG_EFI_ZBOOT)		+= zboot.o $(zboot-obj-y)
>   
> +lib-$(CONFIG_UNACCEPTED_MEMORY) += unaccepted_memory.o bitmap.o find.o
> +
>   extra-y				:= $(lib-y)
>   lib-y				:= $(patsubst %.o,%.stub.o,$(lib-y))
>   
> diff --git a/drivers/firmware/efi/libstub/bitmap.c b/drivers/firmware/efi/libstub/bitmap.c
> new file mode 100644
> index 000000000000..5c9bba0d549b
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/bitmap.c
> @@ -0,0 +1,41 @@
> +#include <linux/bitmap.h>
> +
> +void __bitmap_set(unsigned long *map, unsigned int start, int len)
> +{
> +	unsigned long *p = map + BIT_WORD(start);
> +	const unsigned int size = start + len;
> +	int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
> +	unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
> +
> +	while (len - bits_to_set >= 0) {
> +		*p |= mask_to_set;
> +		len -= bits_to_set;
> +		bits_to_set = BITS_PER_LONG;
> +		mask_to_set = ~0UL;
> +		p++;
> +	}
> +	if (len) {
> +		mask_to_set &= BITMAP_LAST_WORD_MASK(size);
> +		*p |= mask_to_set;
> +	}
> +}
> +
> +void __bitmap_clear(unsigned long *map, unsigned int start, int len)
> +{
> +	unsigned long *p = map + BIT_WORD(start);
> +	const unsigned int size = start + len;
> +	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
> +	unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
> +
> +	while (len - bits_to_clear >= 0) {
> +		*p &= ~mask_to_clear;
> +		len -= bits_to_clear;
> +		bits_to_clear = BITS_PER_LONG;
> +		mask_to_clear = ~0UL;
> +		p++;
> +	}
> +	if (len) {
> +		mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
> +		*p &= ~mask_to_clear;
> +	}
> +}
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 67d5a20802e0..8659a01664b8 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -1133,4 +1133,10 @@ const u8 *__efi_get_smbios_string(const struct efi_smbios_record *record,
>   void efi_remap_image(unsigned long image_base, unsigned alloc_size,
>   		     unsigned long code_size);
>   
> +efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
> +					struct efi_boot_memmap *map);
> +void process_unaccepted_memory(u64 start, u64 end);
> +void accept_memory(phys_addr_t start, phys_addr_t end);
> +void arch_accept_memory(phys_addr_t start, phys_addr_t end);
> +
>   #endif
> diff --git a/drivers/firmware/efi/libstub/find.c b/drivers/firmware/efi/libstub/find.c
> new file mode 100644
> index 000000000000..4e7740d28987
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/find.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/bitmap.h>
> +#include <linux/math.h>
> +#include <linux/minmax.h>
> +
> +/*
> + * Common helper for find_next_bit() function family
> + * @FETCH: The expression that fetches and pre-processes each word of bitmap(s)
> + * @MUNGE: The expression that post-processes a word containing found bit (may be empty)
> + * @size: The bitmap size in bits
> + * @start: The bitnumber to start searching at
> + */
> +#define FIND_NEXT_BIT(FETCH, MUNGE, size, start)				\
> +({										\
> +	unsigned long mask, idx, tmp, sz = (size), __start = (start);		\
> +										\
> +	if (unlikely(__start >= sz))						\
> +		goto out;							\
> +										\
> +	mask = MUNGE(BITMAP_FIRST_WORD_MASK(__start));				\
> +	idx = __start / BITS_PER_LONG;						\
> +										\
> +	for (tmp = (FETCH) & mask; !tmp; tmp = (FETCH)) {			\
> +		if ((idx + 1) * BITS_PER_LONG >= sz)				\
> +			goto out;						\
> +		idx++;								\
> +	}									\
> +										\
> +	sz = min(idx * BITS_PER_LONG + __ffs(MUNGE(tmp)), sz);			\
> +out:										\
> +	sz;									\
> +})
> +
> +unsigned long _find_next_bit(const unsigned long *addr, unsigned long nbits, unsigned long start)
> +{
> +	return FIND_NEXT_BIT(addr[idx], /* nop */, nbits, start);
> +}
> +
> +unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
> +					 unsigned long start)
> +{
> +	return FIND_NEXT_BIT(~addr[idx], /* nop */, nbits, start);
> +}
> diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
> new file mode 100644
> index 000000000000..fd6a3195c68f
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
> @@ -0,0 +1,234 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/efi.h>
> +#include <asm/efi.h>
> +#include "efistub.h"
> +
> +static struct efi_unaccepted_memory *unaccepted_table;
> +
> +/*
> + * Decompressor needs to initialize the variable to cover cases when the table
> + * is not allocated by EFI stub or EFI stub copied the kernel image with
> + * efi_relocate_kernel() before the variable is set.
> + *
> + * It must be call before the first usage of accept_memory() by decompressor.
> + */
> +void set_unaccepted_table(struct efi_unaccepted_memory *table)
> +{
> +	unaccepted_table = table;
> +}
> +
> +efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
> +					struct efi_boot_memmap *map)
> +{
> +	efi_guid_t unaccepted_table_guid = LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID;
> +	u64 unaccepted_start = ULLONG_MAX, unaccepted_end = 0, bitmap_size;
> +	efi_status_t status;
> +	int i;
> +
> +	/* Check if the table is already installed */
> +	unaccepted_table = get_efi_config_table(unaccepted_table_guid);
> +	if (unaccepted_table) {
> +		if (unaccepted_table->version != 1) {
> +			efi_err("Unknown version of unaccepted memory table\n");
> +			return EFI_UNSUPPORTED;
> +		}
> +		return EFI_SUCCESS;
> +	}
> +
> +	/* Check if there's any unaccepted memory and find the max address */
> +	for (i = 0; i < nr_desc; i++) {
> +		efi_memory_desc_t *d;
> +		unsigned long m = (unsigned long)map->map;
> +
> +		d = efi_early_memdesc_ptr(m, map->desc_size, i);
> +		if (d->type != EFI_UNACCEPTED_MEMORY)
> +			continue;
> +
> +		unaccepted_start = min(unaccepted_start, d->phys_addr);
> +		unaccepted_end = max(unaccepted_end,
> +				     d->phys_addr + d->num_pages * PAGE_SIZE);
> +	}
> +
> +	if (unaccepted_start == ULLONG_MAX)
> +		return EFI_SUCCESS;
> +
> +	unaccepted_start = round_down(unaccepted_start,
> +				      EFI_UNACCEPTED_UNIT_SIZE);
> +	unaccepted_end = round_up(unaccepted_end, EFI_UNACCEPTED_UNIT_SIZE);
> +
> +	/*
> +	 * If unaccepted memory is present, allocate a bitmap to track what
> +	 * memory has to be accepted before access.
> +	 *
> +	 * One bit in the bitmap represents 2MiB in the address space:
> +	 * A 4k bitmap can track 64GiB of physical address space.
> +	 *
> +	 * In the worst case scenario -- a huge hole in the middle of the
> +	 * address space -- It needs 256MiB to handle 4PiB of the address
> +	 * space.
> +	 *
> +	 * The bitmap will be populated in setup_e820() according to the memory
> +	 * map after efi_exit_boot_services().
> +	 */
> +	bitmap_size = DIV_ROUND_UP(unaccepted_end - unaccepted_start,
> +				   EFI_UNACCEPTED_UNIT_SIZE * BITS_PER_BYTE);
> +
> +	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
> +			     sizeof(*unaccepted_table) + bitmap_size,
> +			     (void **)&unaccepted_table);
> +	if (status != EFI_SUCCESS) {
> +		efi_err("Failed to allocate unaccepted memory config table\n");
> +		return status;
> +	}
> +
> +	unaccepted_table->version = 1;
> +	unaccepted_table->unit_size = EFI_UNACCEPTED_UNIT_SIZE;
> +	unaccepted_table->phys_base = unaccepted_start;
> +	unaccepted_table->size = bitmap_size;
> +	memset(unaccepted_table->bitmap, 0, bitmap_size);
> +
> +	status = efi_bs_call(install_configuration_table,
> +			     &unaccepted_table_guid, unaccepted_table);
> +	if (status != EFI_SUCCESS) {
> +		efi_bs_call(free_pool, unaccepted_table);
> +		efi_err("Failed to install unaccepted memory config table!\n");
> +	}
> +
> +	return status;
> +}
> +
> +/*
> + * The accepted memory bitmap only works at unit_size granularity.  Take
> + * unaligned start/end addresses and either:
> + *  1. Accepts the memory immediately and in its entirety
> + *  2. Accepts unaligned parts, and marks *some* aligned part unaccepted
> + *
> + * The function will never reach the bitmap_set() with zero bits to set.
> + */
> +void process_unaccepted_memory(u64 start, u64 end)
> +{
> +	u64 unit_size = unaccepted_table->unit_size;
> +	u64 unit_mask = unaccepted_table->unit_size - 1;
> +	u64 bitmap_size = unaccepted_table->size;
> +
> +	/*
> +	 * Ensure that at least one bit will be set in the bitmap by
> +	 * immediately accepting all regions under 2*unit_size.  This is
> +	 * imprecise and may immediately accept some areas that could
> +	 * have been represented in the bitmap.  But, results in simpler
> +	 * code below
> +	 *
> +	 * Consider case like this (assuming unit_size == 2MB):
> +	 *
> +	 * | 4k | 2044k |    2048k   |
> +	 * ^ 0x0        ^ 2MB        ^ 4MB
> +	 *
> +	 * Only the first 4k has been accepted. The 0MB->2MB region can not be
> +	 * represented in the bitmap. The 2MB->4MB region can be represented in
> +	 * the bitmap. But, the 0MB->4MB region is <2*unit_size and will be
> +	 * immediately accepted in its entirety.
> +	 */
> +	if (end - start < 2 * unit_size) {
> +		arch_accept_memory(start, end);
> +		return;
> +	}
> +
> +	/*
> +	 * No matter how the start and end are aligned, at least one unaccepted
> +	 * unit_size area will remain to be marked in the bitmap.
> +	 */
> +
> +	/* Immediately accept a <unit_size piece at the start: */
> +	if (start & unit_mask) {
> +		arch_accept_memory(start, round_up(start, unit_size));
> +		start = round_up(start, unit_size);
> +	}
> +
> +	/* Immediately accept a <unit_size piece at the end: */
> +	if (end & unit_mask) {
> +		arch_accept_memory(round_down(end, unit_size), end);
> +		end = round_down(end, unit_size);
> +	}
> +
> +	/*
> +	 * Accept part of the range that before phys_base and cannot be recorded
> +	 * into the bitmap.
> +	 */
> +	if (start < unaccepted_table->phys_base) {
> +		arch_accept_memory(start,
> +				   min(unaccepted_table->phys_base, end));
> +		start = unaccepted_table->phys_base;
> +	}
> +
> +	/* Nothing to record */
> +	if (end < unaccepted_table->phys_base)
> +		return;
> +
> +	/* Translate to offsets from the beginning of the bitmap */
> +	start -= unaccepted_table->phys_base;
> +	end -= unaccepted_table->phys_base;
> +
> +	/* Accept memory that doesn't fit into bitmap */
> +	if (end > bitmap_size * unit_size * BITS_PER_BYTE) {
> +		unsigned long phys_start, phys_end;
> +
> +		phys_start = bitmap_size * unit_size * BITS_PER_BYTE +
> +			     unaccepted_table->phys_base;
> +		phys_end = end + unaccepted_table->phys_base;
> +
> +		arch_accept_memory(phys_start, phys_end);
> +		end = bitmap_size * unit_size * BITS_PER_BYTE;
> +	}
> +
> +	/*
> +	 * 'start' and 'end' are now both unit_size-aligned.
> +	 * Record the range as being unaccepted:
> +	 */
> +	bitmap_set(unaccepted_table->bitmap,
> +		   start / unit_size, (end - start) / unit_size);
> +}
> +
> +void accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +	unsigned long range_start, range_end;
> +	unsigned long bitmap_size;
> +	u64 unit_size;
> +
> +	if (!unaccepted_table)
> +		return;
> +
> +	unit_size = unaccepted_table->unit_size;
> +
> +	/*
> +	 * Only care for the part of the range that is represented
> +	 * in the bitmap.
> +	 */
> +	if (start < unaccepted_table->phys_base)
> +		start = unaccepted_table->phys_base;
> +	if (end < unaccepted_table->phys_base)
> +		return;
> +
> +	/* Translate to offsets from the beginning of the bitmap */
> +	start -= unaccepted_table->phys_base;
> +	end -= unaccepted_table->phys_base;
> +
> +	/* Make sure not to overrun the bitmap */
> +	if (end > unaccepted_table->size * unit_size * BITS_PER_BYTE)
> +		end = unaccepted_table->size * unit_size * BITS_PER_BYTE;
> +
> +	range_start = start / unit_size;
> +	bitmap_size = DIV_ROUND_UP(end, unit_size);
> +
> +	for_each_set_bitrange_from(range_start, range_end,
> +				   unaccepted_table->bitmap, bitmap_size) {
> +		unsigned long phys_start, phys_end;
> +
> +		phys_start = range_start * unit_size + unaccepted_table->phys_base;
> +		phys_end = range_end * unit_size + unaccepted_table->phys_base;
> +
> +		arch_accept_memory(phys_start, phys_end);
> +		bitmap_clear(unaccepted_table->bitmap,
> +			     range_start, range_end - range_start);
> +	}
> +}
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index fff81843169c..8d17cee8b98e 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -613,6 +613,16 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
>   			e820_type = E820_TYPE_PMEM;
>   			break;
>   
> +		case EFI_UNACCEPTED_MEMORY:
> +			if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY)) {
> +				efi_warn_once(
> +"The system has unaccepted memory,  but kernel does not support it\nConsider enabling CONFIG_UNACCEPTED_MEMORY\n");
> +				continue;
> +			}
> +			e820_type = E820_TYPE_RAM;
> +			process_unaccepted_memory(d->phys_addr,
> +						  d->phys_addr + PAGE_SIZE * d->num_pages);
> +			break;
>   		default:
>   			continue;
>   		}
> @@ -697,6 +707,9 @@ static efi_status_t allocate_e820(struct boot_params *params,
>   		status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
>   	}
>   
> +	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) && status == EFI_SUCCESS)
> +		status = allocate_unaccepted_bitmap(nr_desc, map);
> +
>   	efi_bs_call(free_pool, map);
>   	return status;
>   }
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 7aa62c92185f..29cc622910da 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -108,7 +108,8 @@ typedef	struct {
>   #define EFI_MEMORY_MAPPED_IO_PORT_SPACE	12
>   #define EFI_PAL_CODE			13
>   #define EFI_PERSISTENT_MEMORY		14
> -#define EFI_MAX_MEMORY_TYPE		15
> +#define EFI_UNACCEPTED_MEMORY		15
> +#define EFI_MAX_MEMORY_TYPE		16
>   
>   /* Attribute values: */
>   #define EFI_MEMORY_UC		((u64)0x0000000000000001ULL)	/* uncached */
> @@ -417,6 +418,7 @@ void efi_native_runtime_setup(void);
>   #define LINUX_EFI_MOK_VARIABLE_TABLE_GUID	EFI_GUID(0xc451ed2b, 0x9694, 0x45d3,  0xba, 0xba, 0xed, 0x9f, 0x89, 0x88, 0xa3, 0x89)
>   #define LINUX_EFI_COCO_SECRET_AREA_GUID		EFI_GUID(0xadf956ad, 0xe98c, 0x484c,  0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
>   #define LINUX_EFI_BOOT_MEMMAP_GUID		EFI_GUID(0x800f683f, 0xd08b, 0x423a,  0xa2, 0x93, 0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
> +#define LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID	EFI_GUID(0xd5d1de3c, 0x105c, 0x44f9,  0x9e, 0xa9, 0xbc, 0xef, 0x98, 0x12, 0x00, 0x31)
>   
>   #define RISCV_EFI_BOOT_PROTOCOL_GUID		EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
>   
> @@ -534,6 +536,14 @@ struct efi_boot_memmap {
>   	efi_memory_desc_t	map[];
>   };
>   
> +struct efi_unaccepted_memory {
> +	u32 version;
> +	u32 unit_size;
> +	u64 phys_base;
> +	u64 size;
> +	unsigned long bitmap[];
> +};
> +
>   /*
>    * Architecture independent structure for describing a memory map for the
>    * benefit of efi_memmap_init_early(), and for passing context between
