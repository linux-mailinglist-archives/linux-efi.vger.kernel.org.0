Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11F13C9384
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jul 2021 00:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbhGNWFX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 14 Jul 2021 18:05:23 -0400
Received: from mail-dm6nam12on2069.outbound.protection.outlook.com ([40.107.243.69]:19297
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229498AbhGNWFW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 14 Jul 2021 18:05:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtfHtEp1sh7VVK3m8hsH9VAlaeUTW9BTvI2hUVOPMZYijIBXqSe/bAUXt3COoy+o241Wg4vFTdZUBCSsgIZqm3abQRryls2Vbr6fLHUh/oYqBLNmp2e+SI/Aymb+XtagzonuMjjmS1DUnk8l3aZ5uVzkkIm9DkROy3yIJx0z+Kr2fNd/SJhNHwV9h01QBID+7ApZlnoLGsPGcdmbHvqrq97/pcK+8XktiJWum0mV48G6bKiVOtCqJbeDbZgOi8PeDaxG6wLl8irVUo8IDTJQyKMEQxhWXlBoOwzcXIxbljobBX1Q1upqkggpoe1ONCAo+SE7jn24dp5Z/jfXPT2UnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jw6Hm3MJHb4GrlhG6Z9E8vXPMapYxGlWdAEz7n6vdfY=;
 b=k6nLdnwvclC+xyPxi3T+q7S4x8V0iiLCLdo9vbWctJMqcpkunfaJ2UlARBjOGLyFPFyANdjnlxWjTfwEgDxpzoQWBfMnvG6GD4m2qAnrVFHG6m6ia6IySFatdZYA8KqF33WhK4sKCAYEAq08mhUBk2Z3O5Fmq0/V07BMhrhzzPfZar0JY/So31pLjqMNQ66yAsprEGGCML9x9tJZzuBZ69RGcZZKxhj18YMMW1A7Us1V3iU92p9y5cwgMQ96SKKlF88/Ln2kXpeY/Zf8SiZT/kb2NL3Ixsu3VuFlxMNF28mjjJFFNpBDn4VKIFjzdgclpTACLAg2quuNfo2deIUwWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jw6Hm3MJHb4GrlhG6Z9E8vXPMapYxGlWdAEz7n6vdfY=;
 b=nTZLjacmrzihMjiiUjVmhb+GVgtTuZ2piuSClAGz4JuZXhAQN2aSuPmmt/1cWwyX58HqVJghBIH2fZjqu43kPkReeSFOqr2J0Z4GZw+YiF4THr9jd7VwoaI7dlTcqp7D8T4vuKthzh91zIW1qA2sJP21YWdNHs1BNSuBuJ3Lsfg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2687.namprd12.prod.outlook.com (2603:10b6:805:73::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 22:02:27 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 22:02:27 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 04/40] x86/sev: Add the host SEV-SNP
 initialization support
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-5-brijesh.singh@amd.com> <YO9SGT6byW8w37oO@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <31e57173-449a-6112-30ac-5b115dda1dbb@amd.com>
Date:   Wed, 14 Jul 2021 17:02:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YO9SGT6byW8w37oO@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0036.namprd05.prod.outlook.com
 (2603:10b6:803:40::49) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN4PR0501CA0036.namprd05.prod.outlook.com (2603:10b6:803:40::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.8 via Frontend Transport; Wed, 14 Jul 2021 22:02:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7d6e7d9-f9c2-4244-50be-08d947131162
X-MS-TrafficTypeDiagnostic: SN6PR12MB2687:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2687210B9608479AD118E30EE5139@SN6PR12MB2687.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hXfTzHDiN5CWntibbXtRcW6tZ4SZO/IpU67a+rKpK68nj9ISIyKVC3lYpCNblS/PVPEoOYu1yjabuKxcPw/PYsYIj6Jm2ali/wnCtgT4fRGS9KwuJ2Rxf6MGDCKgqI/PIGueXMH/SrFG+VBfvSTUy/55CRBsR44IdGgACkB5Zh9Tr1gpUR/EBwkrlOeh6FQju4SU1ig69KQqF5JUaPaqe6AZtNVkZD/6bjwEDLCwA+T1elj6Lm7BwC7t+P1/XBs0lcqXHuL5HYY6Q9Tp51dSiZKTiOyS0eqN2E6WWBtO7egkpOtJ7Sr02pxSL5xihIDBVzfr7f9o1pS/BJnZZntguCJMVm6fTDy8wNuI2OpLy/YAAuczIkx7aVCr456gI2NeGhyDlVU0xr9cmtp+VCmehXQZ7lTmRS2v2ypVgTTMSouqMaUXJaQdZOS7aAO1Fvds2PvObvsWNGey3qDCAd4A410uU6iBf+NRbPm5ysHFQPINoInz55yOXBsYLwMNWAwSHEEu/sp3coklc3Eof9na+idHqXhJYTqZdr2iLhrX1QiCeLkPV5PAdh8MrgvLhPymcGhYjGWv9FcktTy0RQTR01KJhFoNow/iZUrmfiPXavrLKCFacOfUDSOy9YenQwcJK3t6Yr/SkkJGLKK+sHvrAr6InJ7jMzpohjU8Hk8Md8N1NXufAnMIshNX2ddQmsUYN6LtF77KuhyeyeF61hxPj01IjP9UyGRYVFjhCT35qBS+BEk1NBMWoMKVic5EIXh/J3ZCnlAZpK/6xCiwmOsG6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(7406005)(7416002)(31686004)(186003)(86362001)(6916009)(4326008)(478600001)(6486002)(31696002)(36756003)(66476007)(52116002)(8676002)(66556008)(26005)(16576012)(956004)(2616005)(316002)(8936002)(38350700002)(53546011)(54906003)(38100700002)(44832011)(5660300002)(83380400001)(2906002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGlvRytoRnExOGJLcEhETWFYSk1taU1Gd0MxcUQxcm92a2o3aTU5QzQyY2FZ?=
 =?utf-8?B?V1dKQXdmYnl5WklIQXM0S290MDc5cmFzS3JHMTdVaEI5SjdRc3dTTnRBRS9W?=
 =?utf-8?B?Z1FNMW8zbDRETGxaNjlyOFVkYUdVczNadUtWL2EzK1FIYjQwVG84SlNrV2t5?=
 =?utf-8?B?UHhBMU5jd2k1NTkwSkJ4Q1REM1NmN2lrdUVmMzd1MUpqK1BwUkhPVGxhK3dP?=
 =?utf-8?B?b3M2WXZKOGhKSHZyOE5xUkR6Skd2MVdlYXRZZlVxRXNTbjlhR3JWd1J4MEgv?=
 =?utf-8?B?OCt6UkNBcldVcWduYkduVkVzSTVtOXZqMmxKT29EN1E5Q0pLbnNLbHNWZGh2?=
 =?utf-8?B?WE1tNm1jWk8rdXdjQ0tRV3h2UGtndEFjZjFuYWZZYVEvemRVbmk3cWZlb0dr?=
 =?utf-8?B?d1NvYnZ4T3BlMDRSMmRBKy9aS3VFOHpZdzNKWDhKZGJQWUxBOVlKcWdodVdV?=
 =?utf-8?B?eEZnSXIvYjBXT1ZqWmdMUm1VVkJEUmMydUpDZVJKVVFFRW42cFV1WXVvOXl2?=
 =?utf-8?B?WThBWTdQemlVdGc0NjlYUkhSeTdsVkNtT2Jyekt1MjZmSzFSaFMxNXpYUDgy?=
 =?utf-8?B?SlJ4QnFBVHB6OXMreFZ3dzNObjM2N3ZNdHBsNk5GWncxVFNiUGo5Z3hPQVZp?=
 =?utf-8?B?NXB0aVJBbGhlemFUOWtzc29TSW1mNHhxR2FlcmpyZnlFMWZPSFpGNjhXcDgv?=
 =?utf-8?B?K3YzMU45aDNiUkp6YllnSkhObnhCNFNtNy9RTGgvZjdVVkY1U3dnRmtxWkpG?=
 =?utf-8?B?TnF5OE1wUGpzTVVhRkYwL0FaN0hQNUtJL2ZGU3cwUEZHaGhZMTlycUhFOVg3?=
 =?utf-8?B?U0ZzQ2FGYWljWEVCajlDcUxaZ3IwSU9KMlV2RklLcU1yQnoyVk9uV2Zza3Rz?=
 =?utf-8?B?LzlJNktVMDZDdzZES1ZITEVXK2czam5mWkpsSU5pcGVrNW1KQnZEYUxKcEs1?=
 =?utf-8?B?T1NGNjB4TkIrclJqdktDeGJCL3JYWVRta1pmZGdva2FnTzArSHQ0TEM3QzZJ?=
 =?utf-8?B?Tm9lekpSZG4xSnZCZE1PQ2ZJNTgvcldEWWdxSmxUR283VE9hdTBNdUMwZ2N6?=
 =?utf-8?B?U0FVampNVmZMemZGUjJUTDR4N2p3aVNVVTVwQ1pCckxJQ2t3L3JUdzJrWXpv?=
 =?utf-8?B?clFDa1pUMnVXeHdtbTVZWmk2MitlMEErUHUvTk1hK1ZydzNuZGduL0RhMk1t?=
 =?utf-8?B?TU8rSmIrdWdlM28yeEFYZE9WUDljNlo0ejEvalloM3R5UHZEWkJLcStjckZB?=
 =?utf-8?B?SlRTVnhLaVBPWDV0dnRlZFAzVjJ6UFpYWnVkRkhCZUk4Zy9FOGpWTEl6eEpm?=
 =?utf-8?B?cHVLeCtpeStraVBNUjdraUVoNUhoSUhYeTcyVDdTZmVQOFZ0ZGxUNFVVRkR4?=
 =?utf-8?B?ZmFGTWxIMkhOTUpadkcvbkZKOUdicDltdFpHOGVPZ2VHTHNQQTFLcUxDUWZ6?=
 =?utf-8?B?Z3VkOHRuRVVrVVVHb3JDWTgwbEVkSjF2N1YvZFNvVG9nUmVKZUFpWUREdnJ5?=
 =?utf-8?B?Z1JhN0RjU2J6NVFabnFhMWtHYWF2Ti9SZlMxSlFrL1hCa0UyQXVBR2tSdWhm?=
 =?utf-8?B?aWEzeGVUUHdTZEhQWFV3TE9lN21Qb25ydzJhcHBibnVmUHMvTUtwOURzamJh?=
 =?utf-8?B?VGlTWkxxeDhJcmZtK3lReG5wVFVjZmthNjY1YmNOZ2hRaWxHMEFkNk1lbERP?=
 =?utf-8?B?Znl1QmRWZzBhRXVuaGtIcUcxd09KcnloWjM2UnUxd1RTVC90WFRnQWwxbFBs?=
 =?utf-8?Q?z1fYqT6LAcdANOojG2cAWZZxafR850xXlrCP8rS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d6e7d9-f9c2-4244-50be-08d947131162
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 22:02:27.4540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: je6YJ8CGGUgEqLCB3oCqFJPg50IqYiXPbpNJRQJXz41f8VaMxFREFgeWXXv2c1wV/W08NOX5YUXtM6tMRkYXng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2687
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/14/21 4:07 PM, Sean Christopherson wrote:
>>   
>> +#define RMPTABLE_ENTRIES_OFFSET        0x4000
> 
> A comment and/or blurb in the changelog describing this magic number would be
> quite helpful.  And maybe call out that this is for the bookkeeping, e.g.
> 
>    #define RMPTABLE_CPU_BOOKKEEPING_SIZE	0x4000

Noted.

> 
> Also, the APM doesn't actually state the exact location of the bookkeeping
> region, it only states that it's somewhere between RMP_BASE and RMP_END.  This
> seems to imply that the bookkeeping region is always at RMP_BASE?
> 
>    The region of memory between RMP_BASE and RMP_END contains a 16KB region used
>    for processor bookkeeping followed by the RMP entries, which are each 16B in
>    size. The size of the RMP determines the range of physical memory that the
>    hypervisor can assign to SNP-active virtual machines at runtime. The RMP covers
>    the system physical address space from address 0h to the address calculated by:
> 
>    ((RMP_END + 1 – RMP_BASE – 16KB) / 16B) x 4KB
> 

The bookkeeping region is at the start of the RMP_BASE. If we look at 
the PPR then it provides a formula which we should use to read the RMP 
entry location. And in that it adds the bookkeeping to the RMP_BASE.

       RMP Entry Address = RMP_BASE + 0x4000 + x>>8


>> +
>> +	val |= MSR_AMD64_SYSCFG_SNP_EN;
>> +	val |= MSR_AMD64_SYSCFG_SNP_VMPL_EN;
> 
> Is VMPL required?  Do we plan on using VMPL out of the gate?
> 

The SEV-SNP firmware requires that VMPL must be enabled otherwise it 
will fail to initialize. However, the current SEV-SNP support is limited 
to the VMPL0.

> 
> Can BIOS put the RMP at PA=0?

No, they should not. As per the PPR, the 0h is a reset value (means the 
MSR is not programmed).

> 
> Also, why is it a BIOS decision?  AFAICT, the MSRs aren't locked until SNP_EN
> is set in SYSCFG, and that appears to be a kernel decision (ignoring kexec),
> i.e. nothing would prevent the kernel from configuring it's own RMP.

In the current patch set, we assume that user is configuring the BIOS to 
reserve memory for the RMP table. From hardware point-of-view, it does 
not matter who reserves the memory (bios or kernel). In future, we could 
look into reserving the memory from the kernel before through the 
memblock etc.

> 
>> +		pr_info("Memory for the RMP table has not been reserved by BIOS\n");
>> +		return false;
>> +	}
>> +
>> +	rmp_sz = rmp_end - rmp_base + 1;
>> +
>> +	/*
>> +	 * Calculate the amount the memory that must be reserved by the BIOS to
>> +	 * address the full system RAM. The reserved memory should also cover the
>> +	 * RMP table itself.
>> +	 *
>> +	 * See PPR section 2.1.5.2 for more information on memory requirement.
>> +	 */
>> +	nr_pages = totalram_pages();
>> +	calc_rmp_sz = (((rmp_sz >> PAGE_SHIFT) + nr_pages) << 4) + RMPTABLE_ENTRIES_OFFSET;
>> +
>> +	if (calc_rmp_sz > rmp_sz) {
>> +		pr_info("Memory reserved for the RMP table does not cover the full system "
>> +			"RAM (expected 0x%llx got 0x%llx)\n", calc_rmp_sz, rmp_sz);
> 
> Is BIOS expected to provide exact coverage, e.g. should this be s/expected/need?
> 

BIOS provides option to reserve the required memory. If they don't cover 
the entire system ram then its a BIOS bug.

Yes, I will fix the wording s/expected/need.

To make things interesting, it also has option where user can specify 
amount of memory to be reserved. If user does not cover the full system 
ram then we need to warn and not enable the SNP. We cannot work with 
partially reserved RMP table memory.


> Should the kernel also sanity check other requirements, e.g. the 8kb alignment,
> or does the CPU enforce those things at WRMSR?
> 

The SNP firmware enforces those requirement. It is documented in the SNP 
firmware specification (SNP_INIT).



>> +
>> +	/*
>> +	 * Check if SEV-SNP is already enabled, this can happen if we are coming from
>> +	 * kexec boot.
>> +	 */
>> +	rdmsrl(MSR_AMD64_SYSCFG, val);
>> +	if (val & MSR_AMD64_SYSCFG_SNP_EN)
> 
> Hmm, it kinda feels like there should be a sanity check for the case where SNP is
> already enabled but get_rmptable_info() fails, e.g. due to insufficient RMP size.
> 

Hmm, I am not sure if we need to do this. We enabled the SNP only after 
all the sanity check is completed, so the get_rmptable_info() will not 
fail after the SNP is enabled. The RMP MSR's are locked after the SNP is 
enabled so we should not see a different size.


>> +		goto skip_enable;
>> +
>> +	/* Initialize the RMP table to zero */
>> +	memset(start, 0, sz);
>> +
>> +	/* Flush the caches to ensure that data is written before SNP is enabled. */
>> +	wbinvd_on_all_cpus();
>> +
>> +	/* Enable SNP on all CPUs. */
>> +	on_each_cpu(snp_enable, NULL, 1);
>> +
>> +skip_enable:
>> +	rmptable_start = (unsigned long)start;
> 
> Mostly out of curiosity, why store start/end as unsigned longs?  This is all 64-bit
> only so it doesn't actually affect the code generation, but it feels odd to store
> things that absolutely have to be 64-bit values as unsigned long.
> 

The AMD memory encryption support is compiled when 64-bit is enabled in 
the Kconfig; Having said that, I am okay to use the u64.


> Similar question for why asm/sev-common.h cases to unsigned long instead of u64.
> E.g. the below in particular looks wrong because we're shifting an unsigned long
> b y32 bits, i.e. the value _must_ be a 64-bit value, why obfuscate that?
> 
> 	#define GHCB_CPUID_REQ(fn, reg)		\
> 		(GHCB_MSR_CPUID_REQ | \
> 		(((unsigned long)reg & GHCB_MSR_CPUID_REG_MASK) << GHCB_MSR_CPUID_REG_POS) | \
> 		(((unsigned long)fn) << GHCB_MSR_CPUID_FUNC_POS))
> 
>> +	rmptable_end = rmptable_start + sz;
>> +
>> +	return 0;
>> +}
>> +
>> +static int __init snp_rmptable_init(void)
>> +{
>> +	if (!boot_cpu_has(X86_FEATURE_SEV_SNP))
>> +		return 0;
>> +
>> +	/*
>> +	 * The SEV-SNP support requires that IOMMU must be enabled, and is not
>> +	 * configured in the passthrough mode.
>> +	 */
>> +	if (no_iommu || iommu_default_passthrough()) {
> 
> Similar comment regarding the sanity check, kexec'ing into a kernel with SNP
> already enabled should probably fail explicitly if the new kernel is booted with
> incompatible params.

Good point on the kexec, I'll look to cover it.

thanks
