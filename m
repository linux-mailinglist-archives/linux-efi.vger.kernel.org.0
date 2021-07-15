Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864033CA38C
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jul 2021 19:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhGORH7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Jul 2021 13:07:59 -0400
Received: from mail-dm6nam10on2049.outbound.protection.outlook.com ([40.107.93.49]:23392
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229566AbhGORH6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 15 Jul 2021 13:07:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPde9tS2Fex8UrYCRkPwfUcim0ZtR6OCY0yi436RuW/wur4xjcMIPRmjrJlfTkS4qW253Eae59HMq8wSsovlc5cKRTLbgZrbzeoIUDLxC8hssZD4F9J082JtY0vZAlm3joH6JMH86Uoe+l4ZF4k3/J2jdDL2+G+CwetmI+MRx4RzI7lIAT3igs5mWHpLNkpcCpHG3zN9T9OKSQh/c0O3Oe8KCd+1HdfmvdyIPzPAdAi1jGPlybbqMP/XrH3s8Fm3QxgtyBPF6tUFppqHIRDS6qTfHY4D12FtPtcTP5AkxzGkL4/EOMs8n5lCeSC2uL3NR6twfw88ze8clUyGJGXyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPz4dbfGXn7Y8IxUX7EdLiWUhqJ8TjGtm559N/aElH4=;
 b=TMxsqfIgDEScEAa3G9dtPsKZL3rN06PCUCi7U4G8LHe9g6JKzl22rm1ZkcK6MozrPYpyvhPYtRbfQlAIm77GSuzp86qLwgiz+uJgxAv0nkQTvSEa3w9Ep+SSJ/QfxgUzY8yZEm/WD2AGAeQFBtd9g52Zp8btU0K2pgLNQpsh2uxrdMB6EF7mhPEXo0AgqCQUPZqs4tXae379W797lbQaeVYce56Ub4ktJl/2tS+Q8Cu8vtfNNTXjRQXHYN4mMJyXgeIJX4Q+Tae8GLFwki5LDwPqlRcae+pJWaGmGIynbUNow64iKTNYrw6ZNMT1Lna87VmPkNLXPXGM6ICaMgJfrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPz4dbfGXn7Y8IxUX7EdLiWUhqJ8TjGtm559N/aElH4=;
 b=Ywz+lFwN739ndtOfxZ4E4tUSQL1DAdmYXGgnj6gjJq9Wkz4eGHJ8Uw8dn6W9VgMsv/ynnWWTYqGm5RcDSyeAaIBvWAF51rki6hwjb/2CzjiXU77uZ1rU9sk+OmNKoxx41Ek77lfxqCQmihc2oBcJZ7PUUcP9tLXOIX6+vjjJn3I=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM8PR12MB5397.namprd12.prod.outlook.com (2603:10b6:8:38::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.23; Thu, 15 Jul 2021 17:05:03 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 17:05:03 +0000
Subject: Re: [PATCH Part2 RFC v4 01/40] KVM: SVM: Add support to handle AP
 reset MSR protocol
To:     Sean Christopherson <seanjc@google.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-2-brijesh.singh@amd.com> <YO9GWVsZmfXJ4BRl@google.com>
 <e634061d-78f4-dcb2-b7e5-ebcb25585765@amd.com> <YPBYMiOB44dhhPfr@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <02dc78a6-9aa7-cb0f-af48-aed4c4a94f6e@amd.com>
Date:   Thu, 15 Jul 2021 12:05:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPBYMiOB44dhhPfr@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0057.namprd02.prod.outlook.com
 (2603:10b6:803:20::19) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by SN4PR0201CA0057.namprd02.prod.outlook.com (2603:10b6:803:20::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 17:05:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de651d38-134e-48d0-5f36-08d947b2b006
X-MS-TrafficTypeDiagnostic: DM8PR12MB5397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB539749E74A63938ACDBD456CEC129@DM8PR12MB5397.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3HhZOd+j41zVwJ5IWRGUmbHeYzx5sipQT6VEWSU0jGvItpbqXYdqkr2S/0x774PHcWOsXhE8/jKYwDffH79GR/IY6OhgDD4n45LRYf8G6Vb61IAA3RYigZSqa26Rhg3quFqZVvQXtpg+balbyYFZYPn1INTSmfjcWFaW0u8OBZY5fDSFaIOYC1rpMRMoTjk81Xcb46bWg/fCgaqHpXydlcGOlu+U83ZavWiIGrr4hvyrt+EVMbK4aBP1W3cT7/1Ac5XbTdW2MTgfvDfzQoIMsIT9v1NDjhXfA1yK7qN6ZdRfG1NbERiY89bz3DZgo80ooimu0apNsPzqaMIW+MUc+M6o3CbA8oicX/iz31we4U57OYUhYb05skmA/gl4KyrukQIAv0EnQ2FTNuqu4e5iDyRysyQD8vVEBTFlh20MJdJ9ECe0atHo3SkOIgv4DIvlfe/DjEZZk1kz6j7ub9Tl7GU8AXmr5vEir7mjCcimeJyRcOFilhrH69uRlsVEvIvecbboOXLfo8fzypTzuRGpb1nqhG/0BiGQJhBj5jICSAzzGULOBNLzvE0WLDX0HJmECMzIu+pi/XxKdhxr0OJ20QTMRutuSkMiXRlhAgDh+4JRZWfRngD4D22I35fLvbvu44kORcO5pQrpZMFpwKtyDpkCaBW8gLnQvKvq9Lqd6aMLw/1JUUxrvC6PI25ER7yP1T3OokE+28GeMf7JtW4yJM9EXdWAfxkzHSCkd+t2yU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(478600001)(38100700002)(36756003)(53546011)(31696002)(26005)(6486002)(2906002)(86362001)(316002)(186003)(31686004)(16576012)(54906003)(6916009)(4326008)(7406005)(7416002)(83380400001)(8676002)(2616005)(956004)(66556008)(66476007)(8936002)(66946007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnhEb0tQSnk3YXNhRHJwWnJLZVgzS09zYUpTZ3hvS2M5MFNKY3VKUmx4RU1p?=
 =?utf-8?B?aFFEeUZoOGY5RGZSNkcxT3hxSGpZazEwNWJudDJMbmdISVA2dS9IZEhtVllC?=
 =?utf-8?B?cXlxSHF5K3dyNUQzZUI2VXYvaVNxdEVJWlFqR2NCazlpdnR1RTVVZWNWYzh3?=
 =?utf-8?B?R2diK00ybDlKQUpkRkxoTHY2TWdnd0M2Z0dKRFBwekg3bWFmeHFxUG5xd0c0?=
 =?utf-8?B?YS81QjVKbGZFY1ZKN0xVeFh6bnBMaTBueEt3L1RiaGp4ckhRMktSaUpGS1k0?=
 =?utf-8?B?aWlHWGhzVC85S1EzdjRnd2U5cnRCWHlTdjhYQy9rZlhrcUUyR1JBYlFyVGZs?=
 =?utf-8?B?K3Z4Unh6WllNUkU1dHQwOE5CNW1yM0hXbmxXaytmOTVqd08zamNab2xNMGNN?=
 =?utf-8?B?NENHWFg5R0ZPYU5ZRUNVbDBTMjZxa08zOHRYOXRXcVRoVXZZTU56VDZnaklk?=
 =?utf-8?B?ODZrUmgvL0dWWUZoUVJETXJrTUtDbHIyanJKTHEzUlJVOTlVRXJLMS9DeTFx?=
 =?utf-8?B?YkhJeU5xMmJmbzNxKzhHNURudjNYRFhqUWE1RFdhWC8zbGl5dHh1SDl6U0pw?=
 =?utf-8?B?ZXRLRjJYdWRkalRuTWVVcE8zbmhFK3MxQjBHUjNEWUs2NWx2L3phWGI0dVFN?=
 =?utf-8?B?QzlVNmxZYmF5cnB0N0lNUEJjQVVPQnI3Qm0zSHNGY3FZYXhuWmY2Vld1OEQz?=
 =?utf-8?B?Z3NjVFg5ZzJQNnRQNlUxWGswd1ZMY3FsOEVPZjlMRS9la1R1WXNiRGlmRi8v?=
 =?utf-8?B?bnNwMDdaTWoza1Jyd1M4NHVwbW5Ib0N1Ly9uL0F4SGVIdDczbHdNZjZXSjJP?=
 =?utf-8?B?M2VhUDlYZVRHR09FT1dPeTFKR1JWN0NDbmhiTms0aTZ2UFg4OFJJNklUaVhG?=
 =?utf-8?B?U1Y1VXFyZmZRQzZCNzdPSDA3RnZ0RXhFaCtTcXhSUmp4a280WWJ4ZVhUdUJl?=
 =?utf-8?B?SlRCeVgyQlVZd0EyVm9IWEwyNUc0d0ozSm9zbWV4OHYwNXovalYwbUNWRHJC?=
 =?utf-8?B?eGN5eHBuQVhyVlhFNnJJNDBZOTh5YUZzeTFFN3d3ZWRFN25KYVlsYWtYTUdi?=
 =?utf-8?B?R1FOajNRS3NnOGxra0Y5cUhUZlBoTnQrVlVPRkZBak85bXJTaFpmOU53aWls?=
 =?utf-8?B?aFJBbkxDOW9Db3YzYm1CblRHQ3lwZzVpWk92dmlZSUxFQldOUlhyd2ZwQkJT?=
 =?utf-8?B?UmovdS9tR2VtTWVBMzliY1ZRL1NaeGdMbXZYRGdHU3JJNGdDWEpZQ1ltdmc0?=
 =?utf-8?B?UEdIQm1jZHAram93Y2xtNmtxOFVJdUZwMkV0NC9ZTmFlVDZaZENmSmdNY0Q0?=
 =?utf-8?B?Y0hCNDVmVm4yUFZZWGR2S1EvRDg2aWphK0FHbittWTIrTmh6a2wrc1M1aHV4?=
 =?utf-8?B?YTRWLzk0cWFIcUY2RXpSQWtnRzhlelR3R2l2K3k3Sll4aE9xL2FOWHFoWjJ6?=
 =?utf-8?B?OW94RDBwa1hUcXh3Q3c2VFVjZ1cyaEFvM0dtd24xZGl4L3N1OWhxV1piNldM?=
 =?utf-8?B?eExXNmo2dmYyMHVPeWxsZ09hT1NjcU9jbmtuclVCZktvRmRnbk5ZOTU1TnlN?=
 =?utf-8?B?Q1U0T3hyampqT1oveGlqNUk2UEpkY1puYW1DK0hnUjhBbUVBbHNSbmN3eE8z?=
 =?utf-8?B?UVVkOUJzV3M0YzIyeDBHNDhadnMzU0lNaVhLdnQ0QmY1RW1vQlNKbU1SSzhn?=
 =?utf-8?B?OFdRZmNidUNZUXZSUHhESndwQXJaV3dDdXVqZy9SSkVHWUxIUWRXQlpBUjZm?=
 =?utf-8?Q?rBahteqVtYOad+gEMAe/ufz7k5XWEZpY1fo9cEy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de651d38-134e-48d0-5f36-08d947b2b006
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 17:05:03.6069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5yFBVDCMzOi0gtO3XZYOW0kKXGRcMUChlRXS3V+J+iJ6KSUGl5F5gELkSz3HNsVskIGGSmEQnN8Kfz5lLaWCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5397
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 7/15/21 10:45 AM, Sean Christopherson wrote:
> On Thu, Jul 15, 2021, Tom Lendacky wrote:
>> On 7/14/21 3:17 PM, Sean Christopherson wrote:
>>>> +	case GHCB_MSR_AP_RESET_HOLD_REQ:
>>>> +		svm->ap_reset_hold_type = AP_RESET_HOLD_MSR_PROTO;
>>>> +		ret = kvm_emulate_ap_reset_hold(&svm->vcpu);
>>>
>>> The hold type feels like it should be a param to kvm_emulate_ap_reset_hold().
>>
>> I suppose it could be, but then the type would have to be tracked in the
>> kvm_vcpu_arch struct instead of the vcpu_svm struct, so I opted for the
>> latter. Maybe a helper function, sev_ap_reset_hold(), that sets the type
>> and then calls kvm_emulate_ap_reset_hold(), but I'm not seeing a big need
>> for it.
> 
> Huh.  Why is kvm_emulate_ap_reset_hold() in x86.c?  That entire concept is very
> much SEV specific.  And if anyone argues its not SEV specific, then the hold type
> should also be considered generic, i.e. put in kvm_vcpu_arch.

That was based on review comments where it was desired that the halt be
identified as specifically from the AP reset hold vs a normal halt. So
kvm_emulate_ap_reset_hold() was created using KVM_MP_STATE_AP_RESET_HOLD
and KVM_EXIT_AP_RESET_HOLD instead of exporting a version of
kvm_vcpu_halt() with the state and reason as arguments.

If there's no objection, then I don't have any issues with moving the hold
type to kvm_vcpu_arch and adding a param to kvm_emulate_ap_reset_hold().

> 
>>>> +
>>>> +		/*
>>>> +		 * Preset the result to a non-SIPI return and then only set
>>>> +		 * the result to non-zero when delivering a SIPI.
>>>> +		 */
>>>> +		set_ghcb_msr_bits(svm, 0,
>>>> +				  GHCB_MSR_AP_RESET_HOLD_RESULT_MASK,
>>>> +				  GHCB_MSR_AP_RESET_HOLD_RESULT_POS);
>>>> +
>>>> +		set_ghcb_msr_bits(svm, GHCB_MSR_AP_RESET_HOLD_RESP,
>>>> +				  GHCB_MSR_INFO_MASK,
>>>> +				  GHCB_MSR_INFO_POS);
>>>
>>> It looks like all uses set an arbitrary value and then the response.  I think
>>> folding the response into the helper would improve both readability and robustness.
>>
>> Joerg pulled this patch out and submitted it as part of a small, three
>> patch series, so it might be best to address this in general in the
>> SEV-SNP patches or as a follow-on series specifically for this re-work.
>>
>>> I also suspect the helper needs to do WRITE_ONCE() to guarantee the guest sees
>>> what it's supposed to see, though memory ordering is not my strong suit.
>>
>> This is writing to the VMCB that is then used to set the value of the
>> guest MSR. I don't see anything done in general for writes to the VMCB, so
>> I wouldn't think this should be any different.
> 
> Ooooh, right.  I was thinking this was writing memory that's shared with the
> guest, but this is KVM's copy of the GCHB MSR, not the GHCB itself.  Thanks!
> 
>>> Might even be able to squeeze in a build-time assertion.
>>>
>>> Also, do the guest-provided contents actually need to be preserved?  That seems
>>> somewhat odd.
>>
>> Hmmm... not sure I see where the guest contents are being preserved.
> 
> The fact that set_ghcb_msr_bits() is a RMW flow implies _something_ is being
> preserved.  And unless KVM explicitly zeros/initializes control.ghcb_gpa, the
> value being preserved is the value last written by the guest.  E.g. for CPUID
> emulation, KVM reads the guest-requested function and register from ghcb_gpa,
> then writes back the result.  But set_ghcb_msr_bits() is a RMW on a subset of
> bits, and thus it's preserving the guest's value for the bits not being written.

Yes, set_ghcb_msr_bits() is a RMW helper, but the intent was to set every
bit. So for CPUID, I missed setting the reserved area to 0. There wouldn't
be an issue initializing the whole field to zero once everything has been
pulled out for the MSR protocol function being invoked.

> 
> Unless there is an explicit need to preserve the guest value, the whole RMW thing
> is unnecessary and confusing.

I guess it depends on who's reading the code. I don't find it confusing,
which is probably why I implemented it that way :) But, yes, it certainly
can be changed to create the result and then have a single function that
combines the result and response code and sets the ghcb_gpa, which would
have eliminated the missed setting of the reserved area.

Thanks,
Tom
