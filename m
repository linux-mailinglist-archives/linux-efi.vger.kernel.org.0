Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE813D0106
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 19:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhGTRPO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 13:15:14 -0400
Received: from mail-sn1anam02on2062.outbound.protection.outlook.com ([40.107.96.62]:38478
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231954AbhGTRPE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 13:15:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHD/NrYGKJR65AMmR/leOQjm52rSkIggWAu0cXU2kzexadfuC62R4JPk12kpOYKBGo/bq96qBwQmf+D4HyV32pd9rY8Fq7nNhEs83odlxrHHD3nm1Qu+7VyLtxR3u17qybXn8ll0qM4cTliqIMWF+mEsisRxWoMDWHQCRwjDV5GPU7nzZ6PIsOp/Ehx3yG67ZOy5lMfj9YByWTTgkEMO5hLVFyEnG5eWC/DTLsraIzpE+APjqsZA7YXM1suE+Gif7FfRdN8HHfXwZ1rWHp8olVdAksR9MtvZO2Fvfq/J2LevXNWyKcPI4LPWkMkyzsNVveQteZx64U3PYiUU8UqCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vct+0shJj2l+Oy06b5w7vhdce15QtGTFEw6lsbESlHw=;
 b=YlL3sh2IDSAGcpEnhEffEY0VXpo2bKI5lrf2i2nNzIWEETHUsgjXBo04vCjfCgFNczYMQUXFQI1/njeX3adCRxWc7sdT5mmoxe+zTp6nHzuoZp59j6f3tlmDedXSKkBZL3amg4zkOHk4z5xuc3zduCHw1pboAPvRw+c6v0WaKu+bE/wae13esFY6Z6yAZh1myaeDRwuE9bjYxLCxGi/bGg7cFFIX6Jxkadfzklk2jqLfr5t/99DF+PSKv6mX8F2W8vJ/adVpq5BdkoAkXupQRwMdWUtFQZLw/exrWBUfuUfQGKhBQTt/rZz/t6s0yhPLCaikl0TWvIJ9IGKhRjtNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vct+0shJj2l+Oy06b5w7vhdce15QtGTFEw6lsbESlHw=;
 b=lm24ok8MwT9pjNgQozxMXdjj5rFHivGpR7aOWDRHXYR1ME93NK8MElkkvb9nznzK0XJ6+Ylkfb+eOUA/07obDkjkn4LDHmhf5oqDIcnLnp876m6RyHfMgtCbuHvlBfTF8Ks4XIaGVju5jOLEhmZzN22s/0owD23Ez+BIAB+8H7Q=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.25; Tue, 20 Jul
 2021 17:55:39 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 17:55:39 +0000
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
Subject: Re: [PATCH Part2 RFC v4 37/40] KVM: SVM: Add support to handle the
 RMP nested page fault
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-38-brijesh.singh@amd.com> <YPYUe8hAz5/c7IW9@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <bff43050-aed7-011c-89e5-9899bd1df414@amd.com>
Date:   Tue, 20 Jul 2021 12:55:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPYUe8hAz5/c7IW9@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0170.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::25) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SA0PR11CA0170.namprd11.prod.outlook.com (2603:10b6:806:1bb::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 17:55:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfefd896-ee7d-4532-8a14-08d94ba7955f
X-MS-TrafficTypeDiagnostic: SN1PR12MB2414:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24149D5D67142863B650398BE5E29@SN1PR12MB2414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fPUog5W0mX8WpzfaaRT0Suij+84e+thkYX5gccTWJlhqBQiWXzDkfSMLAtmPzlp+rW17z2T0clQl8mqmnt5RIh6Jy2XMinvloOXvv9nj9DZlnRbcZRlzoJDB3Y5t0o9+q7lCkO7Iser1/2PY2+5GCf04rtlAQQgnmKeHnONVR2gxiFUAOazyg4yCtB2uD3mPlbRaHKRJAxi1dsg+A+zzfoilNRduyoWelcW73+QPamgkQjC5mKanzFtiViWaeS1uGCMkJrKS6jVTbRxeE6hlyF/gvOtB/EAJfXJkI26GncJ65bJEhV7VVOvAWYJw/xXSizYkp3L6/wMpcY1cdCRGYYMUzq5fdZCWppN30NJsj9kFsZXYhyfpE9iX9ae0EqTC2suCp5mFbIvqpf1fWQJ12W3Q9sCzJs1/EXHGZJvBLULY+mVu3qg1LbGfQelg+ayV+CJs0vX2wEtE6LK2p+tHlAOC2/2PbzA2gzLxEnx+HyrbQ2fnbqVCSa4QSsRY+AyVRABh15tqtAZIrTBs259+jw7x6yuY+XsX4qu7oUx+1QQoNDzZQ3QPIMEm5YqrvoPlE7VKfxc+yd0I1DkzcVlK8AUTeUUf4S+ezBjCZIzZMpj1ZF7oePjyVpWTPHomksjP4FTVSnp/S2dqjbGt4ofLgpwS6R/RxyuvwsiDDUuNSVH/qOZmEBmQZNNhnci0GN0Ma1jLMjTd73ZoAOLUnbUmRidQ5FfGdkrIZNzeHoLI12tkpzjHWxRgNVH2G9nVaJ4Ev7F2CGpDl72BjAwCBlgySw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(5660300002)(7416002)(66476007)(52116002)(7406005)(38100700002)(38350700002)(54906003)(8936002)(2616005)(956004)(2906002)(6486002)(16576012)(31696002)(36756003)(8676002)(186003)(4326008)(66556008)(86362001)(44832011)(316002)(26005)(478600001)(6916009)(31686004)(66946007)(83380400001)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2xobXYrNXpRaDc0dWZyVDNURU53blBoZmRhbnp4ZExMNCt1bGhqcG54WFZP?=
 =?utf-8?B?bVJNZVZlYjMzbkpCekdGYm0wb0NRQ200QmMrMGk5ekNWWU52VmxETm0yODVB?=
 =?utf-8?B?ekpUVFpzZTRzVFZyRTljeVJSQkE3bERUSTNiRWFYQVJLRldRVGtuOURsenBI?=
 =?utf-8?B?YTZrQnA0WTJaclI3RlNxZ1BvN0k0dmt3Uld1ZUFCeG9ZUDJ2eXlQbWYzc2pS?=
 =?utf-8?B?NnZQdVFHVk5xbktaTm5xUmR5YnlCV3JVN2NRK1ZFdEUzdDRUZGVrV1U3ZVhp?=
 =?utf-8?B?QjBYM0NrVlhZUVFXQUM2SlRxYWllckVzUWRwMG1USEpOdHFmZEF5T1ZBdTNu?=
 =?utf-8?B?T1pNNnRrU3JVRFMzNE9iY2ZSeUllUnFjTnpxL3JYK004Ykh5T1BlSHZXQkIz?=
 =?utf-8?B?dXFWcFgwdDBKb0ZleEhSWkRXQkdJT1dwSStQUDFPUCsrSTVPenVwSTBDYXFm?=
 =?utf-8?B?SnlkUlA5cXhDajVlQ2FkU01yTVV2djFzVit2eEJ2ZVo4N1A1MXJidy85QUVM?=
 =?utf-8?B?RG9vMEcwUkRPamZKZHhHd3NLRk5OUVdSaE9zcmRqa0Y5YnRQbklOYmhEeTdQ?=
 =?utf-8?B?b1YzZ0tZSjV5NmxWV3FSd2hXWUJwWG1yRlp1VGZDQmNJeGMvSmFFMUpkWlE3?=
 =?utf-8?B?M0ZIVEUwRFZ3U0NIMnNWdVZyNlV2V0pRK1JUSDZOUU9nTWRmVExRQjFYdTBh?=
 =?utf-8?B?WjhLdVR1U25Ld2VseU0wcSs4Ly9XelhwcnFxcXlSYU1RRVg4L0pVSWJNZUV1?=
 =?utf-8?B?TEhvWU5FMTl2MzR3eEpoV0FwbzNyQlNheGxMSVVybTZadURFakk1TURvMkRY?=
 =?utf-8?B?bm5zcjBCMTJXR0tNbEJSUnhQY055SDdxWjdKMVN3U01pVzRVN1BKMVdBT21C?=
 =?utf-8?B?WDZCc0pxWkZoc1QxVHplSGJRb3ptVlE4T3JrSWR1N0FQRW5lWVFBNzhieE1T?=
 =?utf-8?B?VWp6WTkrQzdFWUxiWVROVjA0clJoMVJ0dUt0dHBocGhiZlRaLzBXOVNKVDlD?=
 =?utf-8?B?MXA4Q2RLeUxrZytwSUVFL2RvQTNoN2pJQVhnMWZldm9HVjRSakQ2SmtoL3BJ?=
 =?utf-8?B?R0VZeFA1SjFSOEczM0dIOGdiVzZMUUd2QlhlSGRsYW5IdXF2U215WVg4VUlY?=
 =?utf-8?B?dmlOM0hWY2VqdnBKWitzbks2K1VqRlJqSzBuYkI3OUF0QjdlUGVwSlNHWDZ4?=
 =?utf-8?B?ZVRVbjFVU3N6RmtlbEp1NkNUdGpvdGNHUGJhWXJrR2FrL0hpbGN1cTB3dExr?=
 =?utf-8?B?QlZnUFBwMnlzcmJWU05kNU9VeGVWUzdLeWlXT2g1dU04NmIvNkMwaGRrOVJE?=
 =?utf-8?B?UXlmbkxsMWZ5WTZYbnVwaXQyUTN1eENTdTFCTWZNTDFMcEtUZzR3cFlhZFJF?=
 =?utf-8?B?TTRseURHRURtM01ZZldJU2hmWERqbWhhd2R1cEI1Rk5ZQ1VZYUxBRzd3Q1hv?=
 =?utf-8?B?MWNWVVUrQ3BISkI1Z2xNLzFDaUMxVlRUNmJaY0JQRFErN3Jxa3VrejZWZEZD?=
 =?utf-8?B?QkRDNGtiWjBEL3RWSmgzKzZyZ0pDYXRSdTFDMWk5emkzUEpkVlNtTkdaY0Zk?=
 =?utf-8?B?NDhucitteFlNNjJzK0dKbmYrS2gyUUo2RjdpRzUvRlVlMVIvK2MxTDNiTUxX?=
 =?utf-8?B?SHpqeVd6SmlkV3A2YjV6cmg3MXYvb2V2VWx3M3VzbU1sbHU0d1NNSVZIaTNV?=
 =?utf-8?B?QzA5bzZJMmhKT0xpbExEdEdQU1lsMytBSUZ0TnFCQVFQUXlEcFd2TnJNczZk?=
 =?utf-8?Q?ch10wM6Y0lOnqSpl7818hWl/oj4/DzkABojkvpm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfefd896-ee7d-4532-8a14-08d94ba7955f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 17:55:39.0202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHRuVJ2LK4TxHpaALoDEr+VhKXIa08KSECK5nkImgIR2dBz1erep+bagVV/BI0ax1qARfWof33O/o756dIwWtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2414
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/19/21 7:10 PM, Sean Christopherson wrote:
> On Wed, Jul 07, 2021, Brijesh Singh wrote:
>> Follow the recommendation from APM2 section 15.36.10 and 15.36.11 to
>> resolve the RMP violation encountered during the NPT table walk.
> 
> Heh, please elaborate on exactly what that recommendation is.  A recommendation
> isn't exactly architectural, i.e. is subject to change :-)

I will try to expand it :)

> 
> And, do we have to follow the APM's recommendation?  

Yes, unless we want to be very strict on what a guest can do.


Specifically, can KVM treat
> #NPF RMP violations as guest errors, or is that not allowed by the GHCB spec?

The GHCB spec does not say anything about the #NPF RMP violation error. 
And not all #NPF RMP is a guest error (mainly those size mismatch etc).

> I.e. can we mandate accesses be preceded by page state change requests?  

This is a good question, the GHCB spec does not enforce that a guest 
*must* use page state. If the page state changes is not done by the 
guest then it will cause #NPF and its up to the hypervisor to decide on 
what it wants to do.


It would
> simplify KVM (albeit not much of a simplificiation) and would also make debugging
> easier since transitions would require an explicit guest request and guest bugs
> would result in errors instead of random corruption/weirdness.
> 

I am good with enforcing this from the KVM. But the question is, what 
fault we should inject in the guest when KVM detects that guest has 
issued the page state change.


>> index 46323af09995..117e2e08d7ed 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -1399,6 +1399,9 @@ struct kvm_x86_ops {
>>   
>>   	void (*write_page_begin)(struct kvm *kvm, struct kvm_memory_slot *slot, gfn_t gfn);
>>   	void (*write_page_end)(struct kvm *kvm, struct kvm_memory_slot *slot, gfn_t gfn);
>> +
>> +	int (*handle_rmp_page_fault)(struct kvm_vcpu *vcpu, gpa_t gpa, kvm_pfn_t pfn,
>> +			int level, u64 error_code);
>>   };
>>   
>>   struct kvm_x86_nested_ops {
>> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
>> index e60f54455cdc..b6a676ba1862 100644
>> --- a/arch/x86/kvm/mmu/mmu.c
>> +++ b/arch/x86/kvm/mmu/mmu.c
>> @@ -5096,6 +5096,18 @@ static void kvm_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa,
>>   	write_unlock(&vcpu->kvm->mmu_lock);
>>   }
>>   
>> +static int handle_rmp_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
>> +{
>> +	kvm_pfn_t pfn;
>> +	int level;
>> +
>> +	if (unlikely(!kvm_mmu_get_tdp_walk(vcpu, gpa, &pfn, &level)))
>> +		return RET_PF_RETRY;
>> +
>> +	kvm_x86_ops.handle_rmp_page_fault(vcpu, gpa, pfn, level, error_code);
>> +	return RET_PF_RETRY;
>> +}
>> +
>>   int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 error_code,
>>   		       void *insn, int insn_len)
>>   {
>> @@ -5112,6 +5124,14 @@ int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 error_code,
>>   			goto emulate;
>>   	}
>>   
>> +	if (unlikely(error_code & PFERR_GUEST_RMP_MASK)) {
>> +		r = handle_rmp_page_fault(vcpu, cr2_or_gpa, error_code);
> 
> Adding a kvm_x86_ops hook is silly, there's literally one path, npf_interception()
> that can encounter RMP violations.  Just invoke snp_handle_rmp_page_fault() from
> there.  That works even if kvm_mmu_get_tdp_walk() stays around since it was
> exported earlier.
> 

Noted.



>> +
>> +	/*
>> +	 * If it's a shared access, then make the page shared in the RMP table.
>> +	 */
>> +	if (rmpentry_assigned(e) && !private)
>> +		rc = snp_make_page_shared(vcpu, gpa, pfn, PG_LEVEL_4K);
> 
> Hrm, this really feels like it needs to be protected by mmu_lock.  Functionally,
> it might all work out in the end after enough RMP violations, but it's extremely
> difficult to reason about and probably even more difficult if multiple vCPUs end
> up fighting over a gfn.
> 

Lets see what's your thought on enforcing the page state change for the 
KVM. If we want the guest to issue the page state change before the 
access then this case will simply need to inject an error in the guest 
and we can remove all of it.

> My gut reaction is that this is also backwards, i.e. KVM should update the RMP
> to match its TDP SPTEs, not the other way around.
> 
> The one big complication is that the TDP MMU only takes mmu_lock for read.  A few
> options come to mind but none of them are all that pretty.  I'll wait to hear back
> on whether or not we can make PSC request mandatory before thinking too hard on
> this one.
> 

