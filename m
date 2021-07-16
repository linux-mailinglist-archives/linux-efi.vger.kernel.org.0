Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592D23CBF1F
	for <lists+linux-efi@lfdr.de>; Sat, 17 Jul 2021 00:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbhGPWTg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 18:19:36 -0400
Received: from mail-co1nam11on2054.outbound.protection.outlook.com ([40.107.220.54]:52369
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233454AbhGPWTf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 16 Jul 2021 18:19:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0YH3+c2jWryI6DLAK2rya7qCXAtaKSei+AStFUltHMgFIQgTEXPk+s9csMFHs/NC5iA2in3UgM5npDACVHG96yYAQk4+D4ILHcYvjajTyxB9jomAFJTIEoOtdoeA1WFBeNCOY0Gdt99OPDx0X6obuigmB5usKF+m4jhWGxvHG9se6n+I0eFljJkABkGDSC5pIgWiTImoh5VM3niuSQhYk8jA9/G9EDJxX5/k1RGg99AZ+z33maCfOgcmChWlPVqXcdo0kLq15DIH3hyMHEDLRPq5Ydy6sx+vjCpE3nQH00GL69Mvjil4ShpoPc6g6VOKZGUvYD56497uZeOVHYK3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/YQYG6JqQIqOkv5V1oUhlxOWa3jAAjt7lq47pIlx/U=;
 b=FfCTrjFbrUgbw5mGL/DAfG4C1PV2ivLolMe3U9V0lIpGN0oB4ZxADfs/7nrYLyRVeJjJvrUH8cBUdRfFjJzrkoTp+3QPzq3CTC1h+wtxHGY6mrVflYpmp5kFi/q0+fHWmZ4sXf/jkhd6bCE9vklwf5ClsPFFGFeIet9GGK0JIHImNRtFQJmTszx7ok10kB/XMsjr+QLDsazU6Nvnd+jVBXm3HLDe6MkjrF2DD9O+Qbo8mVpKMsqAobSD3p4LoMTJEO/7VtItqPgN6mKppO4QcxOd8uSHWDxFFcEtv72jxBMTmusiE0mZawXzlivJGy34SGGs/OX9Bmo6i6a1gnA45w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/YQYG6JqQIqOkv5V1oUhlxOWa3jAAjt7lq47pIlx/U=;
 b=Qk3QEibpJK1puS0jTCfzYZ7XBksX62LF1EVyuKEGSXLTsNx9UezczQ3bBJpIRM6JhWvgSS8zu5XxcWL61mUf+sjnjmiAf5F7vu1pFdt4QA9V6RVfS0jXXPghons06lHYP7zLSy6j1E25P5qPJ2up5IwKN5dFGiCbu667YiesOlg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2768.namprd12.prod.outlook.com (2603:10b6:805:72::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 22:16:37 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.024; Fri, 16 Jul 2021
 22:16:37 +0000
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
Subject: Re: [PATCH Part2 RFC v4 25/40] KVM: SVM: Reclaim the guest pages when
 SEV-SNP VM terminates
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-26-brijesh.singh@amd.com> <YPHnb5pW9IoTcwWU@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <2711d9f9-21a0-7baa-d0ff-2c0f69ca6949@amd.com>
Date:   Fri, 16 Jul 2021 17:16:30 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <YPHnb5pW9IoTcwWU@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SN4PR0501CA0100.namprd05.prod.outlook.com
 (2603:10b6:803:42::17) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SN4PR0501CA0100.namprd05.prod.outlook.com (2603:10b6:803:42::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.9 via Frontend Transport; Fri, 16 Jul 2021 22:16:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55d761ab-7b05-45ed-049b-08d948a760e7
X-MS-TrafficTypeDiagnostic: SN6PR12MB2768:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2768BA88D0D354DEFADB4569E5119@SN6PR12MB2768.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DdI9wTM5eEmFqRPZB7ctrY8K4wlo2zOyD9hMGC95zV3kM0GNwLF7yoExbpdSjmcQO/h3u4PEcgXMoASzMIPwdtFdd4OQWnXRA5C1yoCejKDGQmvGQFeTPTJVT1wc78AkE1qJ75dQhPFxgrEIRWcGynJeMi+XsepdZ1bJw6q24pIw3MQkOvHkYd8mwpaGphhr58cfjQgMBVrKB3tRUlsDkChYwjECjk/jcVnlxHg0iS0JHxrXMHloFW+jRJutZZm8hkXxg36D+F671/ES2Vn+JNb/ug21YnHmArQS0rz9hkC8ig+CZYZRMHn/XTBBKL1cgqBjdij8fLEpoiE7KdzDFrYsQKWBNCgCv5uT5hc2mgYhSaixpbkTxNfKDqwkGQlFA/HBX+gJ5u1TNFcpuJ0lUGEmHBjrbP1sB8jdUUzjio/lJ68AaRgtybJyB6+F/q9G7onRRtuV5ZYh3dKibFXzAZCZd/mmJbyhDvroBND6peOvVjo1NMzxNsYCP+k6fJPdmQm7MMUuhNRtH8zj/BOMsznvV0RKSP7jV/YXoZGVhOVQFsQYhyW5Kr25kj0a2qNAQj9Z4oaavRj5L3OPx7iA3JKep6A2KkxJiByZyGTclJ70tRZFTumWvrtoxjyIhpgSu7m7S2HS0cBitkfZxDNgfgaEd0qfETJm4k31CjrU2injzGrjPVcOpjE3ApnCvJqxf0K+ttakRRcAja0a5/QeCkj5Vb2yj4fiuNVUjoL2aIKoSc3123LKi0ljFKWzpT3k2s2mEcrigFFQgS+fo0WtMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(8936002)(52116002)(31686004)(5660300002)(86362001)(2906002)(66946007)(26005)(6916009)(6512007)(66556008)(66476007)(83380400001)(44832011)(36756003)(186003)(956004)(6486002)(478600001)(2616005)(7406005)(6506007)(7416002)(8676002)(54906003)(316002)(31696002)(53546011)(38100700002)(38350700002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTRjanRJTXRsMXp4emZWUkpiZFNTaXBpSlpzYnNuRVpzL3FjY0ZPUEYrUGJv?=
 =?utf-8?B?bjZHc2dtdXZTbGhiTTNwT3ROYmY2SHNFVEozQnR3RzFXM2piOHVTYU1jYlJj?=
 =?utf-8?B?bnJZRnNGbGYyNmtYellNUFVWTkRQOEpVcEdQVllpRkpLalkyTi9OT3hrc0Ez?=
 =?utf-8?B?R2hQNDJBTUgxZ0YyNHdicTFRdXErbjZ3U2pxNXBPZ1MraVdreTJwUk4wbUNN?=
 =?utf-8?B?aWF6dmdEZmJUTTNKV2J5NlUvRDJic1B2aXdSK3c3VU5DZ0RPY0c5ZS84NDhv?=
 =?utf-8?B?bGlzOTRjNWkzMXVpNkNTTTlMaDZwWGxESXA0UVA0ODFrQU5LTDUvZUxYYjZ3?=
 =?utf-8?B?dnpBb1NJT2F2WTFETWVtT3hTT2d3MTV6MmZuVkoxbk5lbmZvaDh6dk9jcmR0?=
 =?utf-8?B?bWtqQXRia0RlVDAzcWFDWWhiNDR6RVpjeE5qeEZLdTFNQnV0OE5sRkRubnhz?=
 =?utf-8?B?NUw3alJ3UnJrQXVCa0J3M3BaaVlTc1JJdEZnUkM4NStQRE1aTHVlWFN5ZEpy?=
 =?utf-8?B?dDhWcmpFcUU1aTdDTmpuY3JVc3cwYndVS1NDRDczd05jTkZRbG8rRUpFK05v?=
 =?utf-8?B?QkVxSEpqREk2Nm0wR3pvSnJrL3RERFcrWHVMVE5DRndMT1lOU1hkZjQwelEx?=
 =?utf-8?B?YnRaZnlOdHhPWDN0UHE3LzFIMkpPSGIyNzVJUjdsZ29tcjV3VkNHKzBpWkFH?=
 =?utf-8?B?NGxQM1N6aHlqd0pNcFpxMHVHcm1XQlZWUUsxVUg1TW1pWGlIcGx6YkhScVVN?=
 =?utf-8?B?QmVBN0JyWUFscW1Jck9GZXdVcUxFclBZa3pjVHRCVlh0cjNrTnFWSUNGM2hr?=
 =?utf-8?B?MjA5ZW9FMnRnTURWTWc4WGRJUDA0K2pEOUJOVjVFTWR6OWVNcFlPcE80dHV2?=
 =?utf-8?B?a1BIN3piN0diU3pnajBra2RtNVpBRmljQUhZNHFydkpnNlNoZ1VDVVM4Mitn?=
 =?utf-8?B?K2h2aXhmQnYraDJaa21LbkMwSnFyRFlKNnpYNTBacmJKcHgrdlJid1ZuK29H?=
 =?utf-8?B?WU1ieG1kZGhMQnBrWlNaeXE5cTk4czcySnFNZVJ1RllRSnNSNVNxNHh6Uytn?=
 =?utf-8?B?S2FBZTVZZXNsU1JSU3NQVThTWktPQmtmRGYyTlN4Ui92Zm91YWVnSzBCVHFJ?=
 =?utf-8?B?a25MakY4djVzRmtrUWlEUWMzMzFNT0dUdU9tYTlLRi9pVzhLWUdFMEpmR1ZY?=
 =?utf-8?B?TkhSNmdzL0Yxa3g5RUFIdFhFZko4b0h1b1JEMU92MTNHaWpRNTBDOEcyODNC?=
 =?utf-8?B?UE1HRytMU21VNUdEZTlEdjN6YjFKRG9LMjhWa3VWNXpESG9ETGFIaVllSkY3?=
 =?utf-8?B?elQ1YnlUOFcrNEZWVllVSE5EVDV5Vk4zL0ZRYnM1V3NkNk1RSThMR2FYQ0s2?=
 =?utf-8?B?a2NraXQ3L1ZjTzNPUnpsV2RhTE4yZkFNM1NGejJyU25WWGN1aTJuTUxMWklY?=
 =?utf-8?B?VFFkaW9iTHo5cUNTR2E3dkFzTjdRejhkZlhFcWpLVkdVZ3F6dzZTSmZVWmNK?=
 =?utf-8?B?R01vdGM0a2lkb0w4alpNYno5V3QzSHFTNlBJTXBxaDJZNk05dWN4ektteVNC?=
 =?utf-8?B?amRkTnkrQ3hrb1o5a0s5WGx0MkgwckZKL0p3UzdJWWNYd2FvUFJQSnNXemZI?=
 =?utf-8?B?VDArSmFmQ0NGNmM3Ni9rUWFpSStTZ0Y0cjV1YmtQdkdCUk9wRWlQOUUyWWh0?=
 =?utf-8?B?QjJtaEt2REViTGlPbVJ6ZzB4V0xrdEtsVUVlcUxROEd3Umc0R0FQcUZJd2lQ?=
 =?utf-8?Q?mSD6dExPVUldHAzKrOc1eJsbpiXHlsKAyVlH3x0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d761ab-7b05-45ed-049b-08d948a760e7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 22:16:37.3915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cv3SINbz63D4R5p71+vTdSG2QauU4fOlKTdQZVS3Clx/oUKshw737zO1fuJ2i5qfEjFnrWrmUrwNO+XkjOgNsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2768
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 7/16/21 3:09 PM, Sean Christopherson wrote:
> On Wed, Jul 07, 2021, Brijesh Singh wrote:
>> The guest pages of the SEV-SNP VM maybe added as a private page in the
>> RMP entry (assigned bit is set). The guest private pages must be
>> transitioned to the hypervisor state before its freed.
> Isn't this patch needed much earlier in the series, i.e. when the first RMPUPDATE
> usage goes in?

Yes, the first RMPUPDATE usage is in the LAUNCH_UPDATE patch and this
should be squashed in that patch.


>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>  arch/x86/kvm/svm/sev.c | 39 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index 1f0635ac9ff9..4468995dd209 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -1940,6 +1940,45 @@ find_enc_region(struct kvm *kvm, struct kvm_enc_region *range)
>>  static void __unregister_enc_region_locked(struct kvm *kvm,
>>  					   struct enc_region *region)
>>  {
>> +	struct rmpupdate val = {};
>> +	unsigned long i, pfn;
>> +	struct rmpentry *e;
>> +	int level, rc;
>> +
>> +	/*
>> +	 * The guest memory pages are assigned in the RMP table. Unassign it
>> +	 * before releasing the memory.
>> +	 */
>> +	if (sev_snp_guest(kvm)) {
>> +		for (i = 0; i < region->npages; i++) {
>> +			pfn = page_to_pfn(region->pages[i]);
>> +
>> +			if (need_resched())
>> +				schedule();
> This can simply be "cond_resched();"

Yes.


>
>> +
>> +			e = snp_lookup_page_in_rmptable(region->pages[i], &level);
>> +			if (unlikely(!e))
>> +				continue;
>> +
>> +			/* If its not a guest assigned page then skip it. */
>> +			if (!rmpentry_assigned(e))
>> +				continue;
>> +
>> +			/* Is the page part of a 2MB RMP entry? */
>> +			if (level == PG_LEVEL_2M) {
>> +				val.pagesize = RMP_PG_SIZE_2M;
>> +				pfn &= ~(KVM_PAGES_PER_HPAGE(PG_LEVEL_2M) - 1);
>> +			} else {
>> +				val.pagesize = RMP_PG_SIZE_4K;
> This raises yet more questions (for me) as to the interaction between Page-Size
> and Hyperivsor-Owned flags in the RMP.  It also raises questions on the correctness
> of zeroing the RMP entry if KVM_SEV_SNP_LAUNCH_START (in the previous patch).

I assume you mean the LAUNCH_UPDATE because that's when we need to
perform the RMPUPDATE. The hypervisor owned means all zero in the RMP entry.


>> +			}
>> +
>> +			/* Transition the page to hypervisor owned. */
>> +			rc = rmpupdate(pfn_to_page(pfn), &val);
>> +			if (rc)
>> +				pr_err("Failed to release pfn 0x%lx ret=%d\n", pfn, rc);
> This is not robust, e.g. KVM will unpin the memory and release it back to the
> kernel with a stale RMP entry.  Shouldn't this be a WARN+leak situation?

Yes. Maybe we should increase the page refcount to ensure that this page
is not reused after the process is terminated ?


>> +		}
>> +	}
>> +
>>  	sev_unpin_memory(kvm, region->pages, region->npages);
>>  	list_del(&region->list);
>>  	kfree(region);
>> -- 
>> 2.17.1
>>
