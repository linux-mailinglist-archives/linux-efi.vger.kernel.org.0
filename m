Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7943CFE19
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 17:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbhGTPFc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 11:05:32 -0400
Received: from mail-dm6nam10on2052.outbound.protection.outlook.com ([40.107.93.52]:50465
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239888AbhGTOeo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 10:34:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQqVsdyN5qA/gsfIBdVV1+zpx7q5KN0vnlrYNHpWMJLehiScu40UAuxlDDKS1bPvLwB0F9uLheYrHF6adKYH5TBLrLCyJni/dCdLOr1lWSCcMfnq9SlZYTLMgwmwL8X4b8rdhFXfZz3mAJmMF7LCbDTo1FV16Gnay6fFQ6PTvoUlaN/XMSsW3ixGAlhumI6SKo6pyJxk2WOXdQzwx7RLDD3P1OUrQyRKix+ASsA3bCITmT2BGkOji8I96n1WanGyWQhhDgkEmWV36ZRLOs25p1uGTLhl8MCWBpEz54BixpBY/ghSj1pjvS3M/nIw2VbK4DJ9qkJeoGMFkpahkyw06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTgst8U5HGd8fa4h78KgvbfawLz9emEzbOPzAeE0J38=;
 b=YWrjoacL/UtMlXo8LoiRQnGP+yZ20CuGQ5KgOiljGMrhlCdipib6BZbRqahVH1ER0Fo0FBfTp1j+4tgjtSYdTJnJs4SrKHL487KecQhAeGN+TyccKGfZXRIuyj7pQa3KI5CmkcJTQ+OpbkY76ZZCfhm1J0qKq9O6tUEZK0AX3rdmBTIN5w7c90wPt28abm5zrgxXrLh6D1TNlQBCJRVBcnhwNOq5ZmZQ9sAPp3HVl05+Koa6dcuRWoJuaZlXMsXO4+9KXKBd6w5qQpPF3BwGYAuzSfk4b8OIkr8uhHbbhJ7EfNXh6+uS0U1bGcWHHAh5mv2OroSfcoqsghThSzAiHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTgst8U5HGd8fa4h78KgvbfawLz9emEzbOPzAeE0J38=;
 b=LcPF5x2OsDjTrRrvcru25gE4Ui2HVQSqxLUde6uVbCh6OMMz/5ms4+1/DpOuT/6JyXJmfnscbpkvGsFFWB654UDJCfgWfgmztrWV/6kU150dWSQlMb+s9ti9iRuVQJj/252fFMnqILtT2m9equzFYVRkHqKBCGXib7I9idNkBuc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Tue, 20 Jul
 2021 15:15:20 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:15:19 +0000
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
Subject: Re: [PATCH Part2 RFC v4 35/40] KVM: Add arch hooks to track the host
 write to guest memory
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-36-brijesh.singh@amd.com> <YPYLEksyzOWHZwpA@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <1f65ccb2-a627-8631-7638-d02186f7e1bc@amd.com>
Date:   Tue, 20 Jul 2021 10:15:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPYLEksyzOWHZwpA@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0170.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::25) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SA0PR11CA0170.namprd11.prod.outlook.com (2603:10b6:806:1bb::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:15:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eed7d445-ca15-452d-8aec-08d94b912fdc
X-MS-TrafficTypeDiagnostic: SA0PR12MB4592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4592F514E01D86926B4DBB06E5E29@SA0PR12MB4592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KqkfqpO4QiGdrTulybgw/CCbYjcDaSzlksB0B3geox8MuOn436W2krgRPDUNlh8XcluquGx4iyXb9fl1qcPaqPA2PxDYVkUXqmGiDOfz8mm67zwOMtCaKPcWXeFnZEm/t25nYkY5CYMDwINLeZrd7SBYpn55muVberaWNfLfkeoR2AlHgvKGfCPLxVVIxIspz6q/YlvXVecEQ6i+vm9+YSGriSK0yUKkQkHOVt9JjDAt7Nxu3KMSWDlet5vPy3B2ySN86aZe3IwSwPaen9vWTQ+LRsVGPSwYOYmWhyqlCrhM1ByD38wMctEMyxYVqeoyEGL01vLLm/ZpbDag2flVNkappeIDz94BCN3W2r31OR3j9AHu2+7ltp79KDj8NxCa7Co8icnYvPRaSNdj0mg83KxQj27brB6YMT8FrqKl+Rtjc7TOkGGy6WD8Xqd0a/HDyeIUYwTxDuwEjho7A1yN4iJt/9a8nqAs8vKNjEIsvLxJqxjLizzkntbBbcbZr2S8yEiby6MgD9G9RkuP998D17c6sBDPd7/n99ebuz9+mfq9c9xw0nAYePTHIrsVFaR0AJk+eR/EfHYZVT29vQnMRKTluE2Ydy+vT2GjUGWqCO7c/8Pab2zh1qOWHigTNqG0yT+jzmOupMqfPhrds8sFGeM5G6sw44hA7u+LT9ATSPRGXYrl/xyaPtLBBvufbTNVSZgFLkcQyRu3fBsM2lLrOENUoa9o2Swl8CkoKROSdgTuvIXvTQD3wY+e3qGf7+I+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(31686004)(66946007)(7416002)(956004)(2616005)(54906003)(6916009)(5660300002)(52116002)(478600001)(53546011)(4326008)(7406005)(66556008)(66476007)(8676002)(86362001)(2906002)(16576012)(316002)(186003)(8936002)(83380400001)(36756003)(38350700002)(38100700002)(26005)(31696002)(6486002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TktCUlVMTHovNmNwcnhTUERxU1JSK1Rjd1h1UWRYRjdlM1lESlBJdndHOVY5?=
 =?utf-8?B?Q2NyTDFqZUNPNW85MFYzbGdFemZwdkQ3RHNWNkxkSzZlTEZyWkpMbEtseFA0?=
 =?utf-8?B?ZGxlVjRHS0h4eXovb2lVd2l3V0F1c1hycHRaa1d4MGRlNkhkOXplSEh3TzBF?=
 =?utf-8?B?LzRRT2l1VnVadXhlbkV3WUtRUkdXQnRIWkNMN0gwamIrRU1PaDNPUjQrN0Ja?=
 =?utf-8?B?bEsxNXN2b1NvTTJJcWU2MloxK1ZSbjYrRlNzL1MvU3VtWUhTdHVQZTN5S3Az?=
 =?utf-8?B?QzdlSFhCZWd3M0hNcnlrRFMxN0ZXa3VlYmo3S1pSem5aZEF0ZDVqeTcyTkxQ?=
 =?utf-8?B?NXlRNGNtblI0U3BNSFd4S0xXc2VTd1NlRDVKdWN1UllYTjZmcG1QZk8wVS9M?=
 =?utf-8?B?UzJZem5rb3JhS1pUcHVqYmRqOEQ4MUFJZllCZnFRcmowSU90alJTVUJTTlZn?=
 =?utf-8?B?NXlremRiWGx1K3V6OTBRMXd2aFgxM3ZQZjIreHlIUTlkRkpIMDA0WXMwNVN0?=
 =?utf-8?B?Qlp5bWIyRnNKSUU5cUl1TVh0ZzZtMUl2OTVvb2MvU2xiZ0Rob0RXV2tQL2hN?=
 =?utf-8?B?U3VIdDl5VVB3d3VwNzJPSTgvVTBTQzIwQWtJQUZMdGRqSGlRZEZBcmJrQnM5?=
 =?utf-8?B?M0lWeTRLM203ejlVMnFVdlFENVlNcGRocmhZeStUTXltUUlsdjRMM2tlRkEr?=
 =?utf-8?B?WHBNRnJwb2Ixd0FRclVWcWpmZ1hKcGtYWFV5eGw5VjM0RHByMUxJOXVMYWs2?=
 =?utf-8?B?bDQrUGs2K0MvOEFwY21PU001bkpadGRBOGF0VHdUbmNtSngvTy8weGdpTUs2?=
 =?utf-8?B?QXp1dWlMaTlYUEJUeDlhNkI0bzJHbHlleGR6TldBTEp2SzBSdnZXYno5b2RX?=
 =?utf-8?B?WCt5c0dra2JRUWoyZVFXZUN1bDVOQ3RRb3RwYndsMVdvN0xvaFdVVkZMMkl0?=
 =?utf-8?B?SVIvNm1lWmZIdEZxdTd0em0ySTducWNrVnpKbFRRdEFWY1pIdDhITmZFWU1Q?=
 =?utf-8?B?V0ZRTHl6UDBxaE1FOTdqVXkzT2NBU1JPbGdPdVovWVBWQm5VejZIdWZKVG9W?=
 =?utf-8?B?dHRLallXM1dHY0M1b2dZNnh1aW91ZzQvZVQyMEFUeTdaaGZnM1VMSkdjR1pB?=
 =?utf-8?B?eDlPM1EzT0g3aGF0dGZGZWFlR0Qybk5GVFNvZGVtUmpzUDJaZks4cFRSK1I1?=
 =?utf-8?B?cHYxVWFEcWpxT29VUmMxZ1gxcyt3SytyV1FJaER6ckcvTFphb0dRZ3pnaWRt?=
 =?utf-8?B?QzBrWmlrdjZ1Q2hVd2Z2TktWMnVITUJvT1JoVnhid0hhNEJpNVkwTWl2bU1H?=
 =?utf-8?B?OEpRNkUzaXN4WTE2c2laSmFaWEszUXcwY2hOSXZRR0k1bVF2b1IwUnN4VXd3?=
 =?utf-8?B?TitSZW9BQzNhZkRVY2V4a0FBOGlndFU3aU1VZERSWUtFTnhhMzdQbGQrWWdj?=
 =?utf-8?B?Zm1nZXBkWlVqM3VQSDJVNmY1MDlQMnhBWlVCSHl6aW9idjUvQXdDVGVhV2p4?=
 =?utf-8?B?R2JFUjFlTUNJcjdVaHpyd3AzTGxqWVMvMzd2R1RNRlhWWkNsU1BYM2JudHBB?=
 =?utf-8?B?d3puMnpYSzNzdXhLRDFoTkFGWUlSUzZmQ1JTbjQ0RFdCL1NycmdqRCtSWXNt?=
 =?utf-8?B?bGJiRGtGUG5BZW0vSXVDSU9kNVk3SFZJbkRYdFc2RFFBVEZzeVJPc1dLUGlK?=
 =?utf-8?B?N1B1Sm5nRTNnTmQ1UWl2dE1JaklvVGkvKzY0M0hQYlA1Q1MxOW85RUtNdjJr?=
 =?utf-8?Q?zgprbwhv0F+AGBLNgRyjdsrpSVCQL1I6yPB99dk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed7d445-ca15-452d-8aec-08d94b912fdc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:15:19.7807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOJWzogUwb3x2Jr0DcuWXwk8tm7R+PWjcPKt8yGLpX37pycvJmYx7EdlDiXZInH/STGHFp+3AOkN61oSvSGzxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/19/21 6:30 PM, Sean Christopherson wrote:
...>
> NAK on converting RMP entries in response to guest accesses.  Corrupting guest
> data (due to dropping the "validated" flag) on a rogue/incorrect guest emulation
> request or misconfigured PV feature is double ungood.  The potential kernel panic
> below isn't much better.
> 

I also debated myself whether its okay to transition the page state to 
shared to complete the write operation. I am good with removing the 
converting RMP entries from the patch, and that will also remove the 
kernel panic code.


> And I also don't think we need this heavyweight flow for user access, e.g.
> __copy_to_user(), just eat the RMP violation #PF like all other #PFs and exit
> to userspace with -EFAULT.
>

Yes, we could improve the __copy_to_user() to eat the RMP violation. I 
was tempted to go on that path but struggled to find a strong reason for 
it and was not sure if that accepted. I can add that support in next rev.



> kvm_vcpu_map() and friends might need the manual lookup, at least initially, 

Yes, the enhancement to the __copy_to_user() does not solve this problem 
and for it we need to do the manually lookup.


but
> in an ideal world that would be naturally handled by gup(), e.g. by unmapping
> guest private memory or whatever approach TDX ends up employing to avoid #MCs.

> 
>> +	 */
>> +	if (rmpentry_assigned(e)) {
>> +		pr_err("SEV-SNP: write to guest private gfn %llx\n", gfn);
>> +		rc = snp_make_page_shared(kvm_get_vcpu(kvm, 0),
>> +				gfn << PAGE_SHIFT, pfn, PG_LEVEL_4K);
>> +		BUG_ON(rc != 0);
>> +	}
>> +}
> 
> ...
> 
>> +void kvm_arch_write_gfn_begin(struct kvm *kvm, struct kvm_memory_slot *slot, gfn_t gfn)
>> +{
>> +	update_gfn_track(slot, gfn, KVM_PAGE_TRACK_WRITE, 1);
> 
> Tracking only writes isn't correct, as KVM reads to guest private memory will
> return garbage.  Pulling the rug out from under KVM reads won't fail as
> spectacularly as writes (at least not right away), but they'll still fail.  I'm
> actually ok reading garbage if the guest screws up, but KVM needs consistent
> semantics.
> 
> Good news is that per-gfn tracking is probably overkill anyways.  As mentioned
> above, user access don't need extra magic, they either fail or they don't.
> 
> For kvm_vcpu_map(), one thought would be to add a "short-term" map variant that
> is not allowed to be retained across VM-Entry, and then use e.g. SRCU to block
> PSC requests until there are no consumers.
> 

Sounds good to me, i will add the support in the next rev.

thanks
