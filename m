Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2603CBDE6
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 22:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbhGPUpC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 16:45:02 -0400
Received: from mail-dm6nam10on2060.outbound.protection.outlook.com ([40.107.93.60]:42720
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230256AbhGPUpC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 16 Jul 2021 16:45:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwQA0jnH8ALoYpBZLSD/rM6M2rovGu8jrZiJWqz+2ztN5oSMf96073wJ3htwwbDyOi1G1+nSakbFqNO/h0gZ+zZFbjuLuWKE5KXGZdWbZEvBxQvRot00aXYo52jCkFAW5qey/N2ymiHF8527EfAtrcm+S4m/oJPfd3ZZE77C7eILJwmXIBYzENp3iXuk2O6gLcRP5Dz0+oT6BnE0fN7hzb1tqVB2nytQPvjYLvl+9I/l5MPmPMXplQJLodYUUZaDqs5wS+kLb/8QOyjGtLY6SHLmSG3037yoA6z0jjFV5LGsFxV8J+BwLJrJ9WCQlZJYCfdGn963pNZ3KnF0qOSOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6pxJb0M+vjs5Se44Cc/kGKcGOZespwu3Y56dswvmKc=;
 b=e5Dcxml+FWCYDGVJVZjylIXc9/oh3WkS0i3muoaJ/zMozlHAMGAtSAfeAt5FIFQJzMu/4IEQOlQc0VZ3mb973ixceZSFHlmylB1qeTdIxxk+D2x+xsa+XVcxuRFZM7jbCJHL6YigoCdPvyZyHeezCxwOUG2sUhhWEI7CPrxUHzI9oOxkmaITABWTsCdmaZTBlkMFiXzwgoDaIp6kbgmJIf9oAhNVdOxWHKex9PyQBqQa9PUvSFeavOMO4o4Cyj5QhQijV2MNE+Nzh8duZ2ndSWBw7xKR6NHAdV+Xa848R4eKTRuknHLTlCyZN/0cmzAJI9tS9Qv0btuugR78VZyOEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6pxJb0M+vjs5Se44Cc/kGKcGOZespwu3Y56dswvmKc=;
 b=4abK2fLYvTVuZKersbPVFbYiwTvQmPU1WzHI0DDdZ3XAklFSS2db2qcXmHyZoO3C/eZGrtYuhW4nJJ3H+Eb8fzU0+7e9hDtuBBl3Ebui4tmFc5ZLFWg5YGnphb1hDliI9sXBqCUfeB6JSAn0g+qeycS5PGcuhMREL6KNcNS98No=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 20:42:04 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.024; Fri, 16 Jul 2021
 20:42:04 +0000
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
Subject: Re: [PATCH Part2 RFC v4 27/40] KVM: X86: Add kvm_x86_ops to get the
 max page level for the TDP
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-28-brijesh.singh@amd.com> <YPHbxAVbuFk6Xtkj@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <1ed3c439-a02c-7182-b140-32cddd5e4f34@amd.com>
Date:   Fri, 16 Jul 2021 15:41:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <YPHbxAVbuFk6Xtkj@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SA0PR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:806:d0::14) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SA0PR11CA0039.namprd11.prod.outlook.com (2603:10b6:806:d0::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 20:41:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0540dbf5-4c7b-42c9-0c7e-08d9489a2b62
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45574EC7EBFD69A7AFF336F3E5119@SA0PR12MB4557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0NHTlrIcTfQhbZh/M459Ou+zumx/m6pPPQJnhM+aAWZVRtZ2TD73lqr/V6d4lWxC40sJJ8eCNo9IaWwvjs2adUMAPsE3klm+gvZNB6HBOTgpTqSXNBcZ/zY2EbkPhDfzvHERSXuhh6hd6HcIxWPgMRRILxnwSSSwdFSFML+eJ49KTZcrzK7T8s9HT2UFHlFjiRAKBTpIq8RzKedy82se0BO9PDVK07ds2fPiQQyJECeFDtJ+cxDjPhvQSlBtTmLtCSxBdlDPTyGBoSyD62eG4fKpO+tiWdt9Skd0eQcYMxJvY2OdNGFOMl2IfjvEUYeIGSnxY+BVBNoFxB3kSyciI4Vcq4a5kFwxtNJ7lkBdG++ri0wdUpBw6QMshL0h7tiK6EJbMmjir/d9R/noXfWPb/6hAD2CqSNmBIK9BezAEezyyt67TuUzXlJpTCc6K76FBy+fvrNgQYCVhdX1tXcY9J3vmdUakTeniRnLjmhPi1nL9zcjPvZUqgZSyzK9d3f2OXDuS8FhEr1ikm0me6b/myKpOJDGFDAA7aalGo4U2vmvuz/sMKN1mcNDEgi47nQ3NrlEQkyXL5NMNcoOthkFQkTuOd+kgxFweUNwsOeriCVV0qhnjL9AY9DdERJxq1PfwxBHThKSLwKmKYt2qnm5nLlQf11mwWLNChoyIOki34NQsMV5YP99/8Bi07SpkVbUzOeNJLsfqKhwSihGRAHW8ao0Iwo94NMflFzy+9mJwOoeSqPIbCMY5vCimppxP215wib6U0FUdhK8bR2DSezB6mYf7gAMDYAYTAhkqzTJUGB8AQ2IbRywUvGPtvIpc2AD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(6486002)(8936002)(186003)(6512007)(7406005)(30864003)(38350700002)(36756003)(26005)(38100700002)(956004)(5660300002)(52116002)(7416002)(478600001)(31696002)(44832011)(66556008)(66476007)(6506007)(83380400001)(31686004)(4326008)(8676002)(86362001)(2906002)(2616005)(6916009)(316002)(54906003)(53546011)(66946007)(15583001)(45980500001)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TURmVWR3eHhNdy94MGxpUExjMU1wYU0xOU5EaU1BcWNmLzY4UEFZUmtOZ1Zx?=
 =?utf-8?B?OXZGZjc4LzZnd2RnRFNhNWlDRUhDYXdvcW44S0w0Skd1S3RpK2k1b0QyR1JF?=
 =?utf-8?B?QUFIR01vcFFOUWhFV0RtQUlGcG5VWndZaXVraEdpVk93amFoeHF5YjZrQitt?=
 =?utf-8?B?MGlIR3p4dzczKzRwVmhHSjNJNjQ1VlZoWUMxMUVadUhBc0V2eDVRbEVaVy9j?=
 =?utf-8?B?TWtHVzErbVdTZms3QjhpZ2UxQ29TWDAwUEJJa0pxVWFSMGFNcWNySDFxc2oz?=
 =?utf-8?B?eHdxTTRyRENLMExoVVNhSUVtSGRiaUN0cmlCTnZWbmdpYnlNNVpWTDg5N0Ro?=
 =?utf-8?B?NHgyQnVuRnI3NzZraGxWZ1Jnd2o3VWNCN0lEcTArZ3VYMlloYkNUZ25YU1Na?=
 =?utf-8?B?a0J2bVYwVjBFdTY5WGVVT2xUU1FlcjNSNTBld09GN3o2ZVhwOUlmSUZoSUNC?=
 =?utf-8?B?MUpRTE5pemd3RnM4NlBBblBGKzNDODhoanhFY3IwUGYyTEVDcDc2UGxmVHhO?=
 =?utf-8?B?ekRDTlVuZTAwVjJ6VkNqY2I0WUZuUjFEUXZtbTRVV1l0WHBuLzdUaDQ3bFNs?=
 =?utf-8?B?YTQwOUc1QytadW5IYjFMN3ZqaWJEZlpxdmp2aCt1YzEzVEZvekh0bG1MbVlR?=
 =?utf-8?B?Uk45dnF6M0VOdE4yUjVvR09jdlhqaDJRU1VvWCtXZnRpQzUwbTlKeThTdXlX?=
 =?utf-8?B?cEtRNG5jOFpXeFJLcG01UGtiMktmcjRZaUlDZkR6bzZqS2FiTCszdlc1MGEy?=
 =?utf-8?B?WXFwODY1bkdMdzJZS0RYREdYZWtiR3pzMzlNVGprSStVcytCdjZCTCtybldn?=
 =?utf-8?B?emU4SXpMZW1TbFBGcmN5bVNxd3IwUENobGUzNUFSS0o4M3o4aE5TaTlqdGJh?=
 =?utf-8?B?RE9tMStZRVBSbkMyOTdsQVRxMzBWb21McS9qdFg1Z21nTXhOcnpia0dVQk1D?=
 =?utf-8?B?R0h0akh5RUFETkhqalpuamZDNmF3L1FXYmJqUFgwKzFaWWkrSTMvVVF4bTJt?=
 =?utf-8?B?MDRoT2FYYVlVbEh3TlhSYWJZQno2N0lWNmk1QWdMMWNUa2xFZHUzWThhcWRF?=
 =?utf-8?B?Z0NlUC9LaWx3bXN5RVpobHVwWVBMaEV6Z0xLaEhLb0xsSTE4eVZkbGRHYXk3?=
 =?utf-8?B?KzV3MEd1eUpobG5aTXc3U0RuUFZmWDVHa2pUK2JDMEZ1ZjkwbjdRZUczSStu?=
 =?utf-8?B?NW5iR0p0K2xXVUtVaVVqMzFyMGpud1JjMmdaZlBwbE1uZG9TYU5Pa2RQdjY4?=
 =?utf-8?B?emxHS0pwV2dLL29KZmE1NWRFb3FHTzJVY1gxOTJZU1JTNjg1aG9vd2liS2Iz?=
 =?utf-8?B?Sy9ZSi9Cb1M4NklldjFJcVlsVnN5WWZJUmF4dzhFL01wMVlWN0ZpWlJ4Rk1o?=
 =?utf-8?B?Sm5DM1hEZzZ0b3p5ZCtuUUJjRjlzbmhZVVJUOUVLTlF0Z3BDT2JnZldERzkz?=
 =?utf-8?B?TTZWZUpQbmFHWXhHdXNJdnhxVFo5L3hiSEM4OG9hWXI4Ny9XVC9LdFhUOWpt?=
 =?utf-8?B?THk1QzcwTDVyQUpUdFhtV05nMFJUaGtkRXNzRGlWSDFTbG5pc05mOFM2NmI1?=
 =?utf-8?B?S2IrTFVFYUl1T3ZueTZobTg1blhXMjdUUUpjSU5vek9wUXFTU0d3aFl4ZHRX?=
 =?utf-8?B?Mkl0eFpyMjAvODduSlZGY2lWSlpvNkRTU1NsWjY3NmtCcVJMdm9wSjlBbm96?=
 =?utf-8?B?UFJTNGk5V2VVTFNWU0J2RDZPVlpPeUJQUUFycnJ2ZTlaSTFCS1R2Vll5SEcz?=
 =?utf-8?Q?5Ba7g30T7VAcQyZhvLiztgFm95PMxs6GcDU058X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0540dbf5-4c7b-42c9-0c7e-08d9489a2b62
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 20:42:04.3203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqbH8MOLAk7zH5UlDz3ByWZRPVdULDS3eXUQ8qCp2rjudYMK1zkSVydiYJXjCTxnBgIv4OOWOCAj6F1yHVr5Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4557
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 7/16/21 2:19 PM, Sean Christopherson wrote:
> On Wed, Jul 07, 2021, Brijesh Singh wrote:
>> When running an SEV-SNP VM, the sPA used to index the RMP entry is
>> obtained through the TDP translation (gva->gpa->spa). The TDP page
>> level is checked against the page level programmed in the RMP entry.
>> If the page level does not match, then it will cause a nested page
>> fault with the RMP bit set to indicate the RMP violation.
>>
>> To keep the TDP and RMP page level's in sync, the KVM fault handle
>> kvm_handle_page_fault() will call get_tdp_max_page_level() to get
>> the maximum allowed page level so that it can limit the TDP level.
>>
>> In the case of SEV-SNP guest, the get_tdp_max_page_level() will consult
>> the RMP table to compute the maximum allowed page level for a given
>> GPA.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>  arch/x86/include/asm/kvm_host.h |  1 +
>>  arch/x86/kvm/mmu/mmu.c          |  6 ++++--
>>  arch/x86/kvm/svm/sev.c          | 20 ++++++++++++++++++++
>>  arch/x86/kvm/svm/svm.c          |  1 +
>>  arch/x86/kvm/svm/svm.h          |  1 +
>>  arch/x86/kvm/vmx/vmx.c          |  8 ++++++++
>>  6 files changed, 35 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index 188110ab2c02..cd2e19e1d323 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -1384,6 +1384,7 @@ struct kvm_x86_ops {
>>  
>>  	void (*vcpu_deliver_sipi_vector)(struct kvm_vcpu *vcpu, u8 vector);
>>  	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
>> +	int (*get_tdp_max_page_level)(struct kvm_vcpu *vcpu, gpa_t gpa, int max_level);
> This is a poor name.  The constraint comes from the RMP, not TDP, and technically
> speaking applies to all forms of paging.  It just happens to be relevant only to
> TDP because NPT is required for SNP.  And KVM already incorporates the max TDP
> level in kvm_configure_mmu().

Noted.


>
> Regarding the params, I'd much prefer to have this take "struct kvm *kvm" instead
> of the vCPU.  It obviously doesn't change the functionality in any way, but I'd
> like it to be clear to readers that the adjustment is tied to the VM, not the vCPU.

Noted.


> I think I'd also vote to drop @max_level and make this a pure constraint input as
> opposed to an adjuster.


Noted.

> Another option would be to drop the kvm_x86_ops hooks entirely and call
> snp_lookup_page_in_rmptable() directly from MMU code.  That would require tracking
> that a VM is SNP-enabled in arch code, but I'm pretty sure info has already bled
> into common KVM in one form or another.

I would prefer this as it eliminates some of the other unnecessary call
sites. Unfortunately, currently there is no generic way to know if its
an SEV guest (outside the svm/*).  So far there was no need as such but
with SNP having such information would help. Should we extend the
'struct kvm' to include a new field that can be used to determine the
guest type. Something like

enum {

   GUEST_TYPE_SEV,

   GUEST_TYPE_SEV_ES,

   GUEST_TYPE_SEV_SNP,

};

struct kvm {

   ...

  u64 enc_type;

};

bool kvm_guest_enc_type(struct kvm *kvm, enum type); {

    return !!kvm->enc_type & type;

}

The mmu.c can then call kvm_guest_enc_type() to check if its SNP guest
and use the SNP lookup directly to determine the pagesize.


>
>>  };
>>  
>>  struct kvm_x86_nested_ops {
>> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
>> index 0144c40d09c7..7991ffae7b31 100644
>> --- a/arch/x86/kvm/mmu/mmu.c
>> +++ b/arch/x86/kvm/mmu/mmu.c
>> @@ -3781,11 +3781,13 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
>>  static int nonpaging_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa,
>>  				u32 error_code, bool prefault)
>>  {
>> +	int max_level = kvm_x86_ops.get_tdp_max_page_level(vcpu, gpa, PG_LEVEL_2M);
> This is completely bogus, nonpaging_page_fault() is used iff TDP is disabled.

Ah, I totally missed it.


>> +
>>  	pgprintk("%s: gva %lx error %x\n", __func__, gpa, error_code);
>>  
>>  	/* This path builds a PAE pagetable, we can map 2mb pages at maximum. */
>>  	return direct_page_fault(vcpu, gpa & PAGE_MASK, error_code, prefault,
>> -				 PG_LEVEL_2M, false);
>> +				 max_level, false);
>>  }
>>  
>>  int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
>> @@ -3826,7 +3828,7 @@ int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
>>  {
>>  	int max_level;
>>  
>> -	for (max_level = KVM_MAX_HUGEPAGE_LEVEL;
>> +	for (max_level = kvm_x86_ops.get_tdp_max_page_level(vcpu, gpa, KVM_MAX_HUGEPAGE_LEVEL);
> This is unnecessary.  The max mapping level is computed by factoring in all
> constraints, of which there are many.  In this case, KVM is consulting the guest's
> MTRR configuration to avoid creating a page that spans different memtypes (because
> the guest MTRRs are effectively represented in the TDP PTE).  SNP's RMP constraints
> have no relevance to the MTRR constraint, or any other constraint for that matter.
>
> TL;DR: the RMP constraint belong in kvm_mmu_max_mapping_level() and nowhere else.
> I would go so far as to argue it belong in host_pfn_mapping_level(), after the
> call to lookup_address_in_mm().


I agree with you; One of the case which I was trying to cover is what if
we do a pre-fault and while generating the prefault we can tell the
handler our max page level; The example is: "Guest issues a page state
transition request to add the page as 2mb". We execute the below steps
to fulfill the request

* create a prefault with a max_level set to 2mb.

* the fault handler may find that it cannot use the large page in the
npt, and it may default to 4k

* read the page-size from the npt;  use the npt pagesize in the rmptable
instead of the guest requested page-size.

We keep the NPT and RMP in sync after the page state change is completed
and avoid any extra RMP fault due to the size mismatch etc.


>>  	     max_level > PG_LEVEL_4K;
>>  	     max_level--) {
>>  		int page_num = KVM_PAGES_PER_HPAGE(max_level);
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index 3f8824c9a5dc..fd2d00ad80b7 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -3206,3 +3206,23 @@ struct page *snp_safe_alloc_page(struct kvm_vcpu *vcpu)
>>  
>>  	return pfn_to_page(pfn);
>>  }
>> +
>> +int sev_get_tdp_max_page_level(struct kvm_vcpu *vcpu, gpa_t gpa, int max_level)
>> +{
>> +	struct rmpentry *e;
>> +	kvm_pfn_t pfn;
>> +	int level;
>> +
>> +	if (!sev_snp_guest(vcpu->kvm))
> I can't tell if this check is correct.  Per the APM:
>
>   When SEV-SNP is enabled globally, the processor places restrictions on all memory
>   accesses based on the contents of the RMP, whether the accesses are performed by
>   the hypervisor, a legacy guest VM, a non-SNP guest VM or an SNP-active guest VM.
>   The processor may perform one or more of the following checks depending on the
>   context of the access:
>
>   ...
>
>   Page-Size: Checks that the following conditions are met:
>     - If the nested page table indicates a 2MB or 1GB page size, the Page_Size field
>       of the RMP entry of the target page is 1.
>     - If the nested page table indicates a 4KB page size, the Page_Size field of the
>       RMP entry of the target page is 0.
>
> The Page-Size bullet does not have any qualifiers about the NPT checks applying
> only to SNP guests.  The Hypervisor-Owned bullet implies that unassigned pages
> do not need to have identical sizes, but it's not clear whether or not so called
> "Hypervisor-Owned" pages override the nested page tables.
>
> Table 15.36 is similarly vague:
>
>   Assigned Flag indicating that the system physical page is assigned to a guest
>   or to the AMD-SP.
>     0: Owned by the hypervisor
>     1: Owned by a guest or the AMD-SP
>
> My assumption is that all of the "guest owned" stuff really means "SNP guest owned",
> e.g. section 15.36.5 says "The hypervisor manages the SEV-SNP security attributes of
> pages assigned to SNP-active guests by altering the RMP entries of those pages", but
> that's not at all clear throughout most of the RMP documentation.
>
> Regardless of the actual behavior, the APM needs serious cleanup on the aforementioned
> sections.  E.g. as written, the "processor may perform one or more of the following
> checks depending on the context of the access" verbiage basically gives the CPU carte
> blanche to do whatever the hell it wants.

I'll raise your concern to the documentation folks so that they clarify
that the page-size check is applicable to the SNP active guests only.


>> +		return max_level;
>> +
>> +	pfn = gfn_to_pfn(vcpu->kvm, gpa_to_gfn(gpa));
>> +	if (is_error_noslot_pfn(pfn))
>> +		return max_level;
>> +
>> +	e = snp_lookup_page_in_rmptable(pfn_to_page(pfn), &level);
> Assuming pfn is backed by struct page is broken, at least given the existing
> call sites..  It might hold true that only struct page pfns are covered by the
> RMP, but assuming pfn_to_page() will return a valid pointer here is completely
> wrong.  Unless I'm missing something, taking a struct page anywhere in the RMP
> helpers is at best sketchy and at worst broken in and of itself.  IMO, the RMP
> code should always take a raw PFN and do the necessary checks before assuming
> anything about the PFN.  At a glance, the only case that needs additional checks
> is the page_to_virt() logic in rmpupdate().

I agree. Dave also hinted the similar feedback. In next version of the
patch I will stick to use the pfn and then SNP lookup with do the
required checking.


>> +	if (unlikely(!e))
>> +		return max_level;
>> +
>> +	return min_t(uint32_t, level, max_level);
> As the APM is currently worded, this is wrong, and the whole "tdp_max_page_level"
> name is wrong.  As noted above, the Page-Size bullet points states that 2mb/1gb
> pages in the NPT _must_ have RMP.page_size=1, and 4kb pages in the NPT _must_
> have RMP.page_size=0.  That means that the RMP adjustment is not a constraint,
> it's an exact requirement.  Specifically, if the RMP is a 2mb page then KVM must
> install a 2mb (or 1gb) page.  Maybe it works because KVM will PSMASH the RMP
> after installing a bogus 4kb NPT and taking an RMP violation, but that's a very
> convoluted and sub-optimal solution.

This is why I was passing the preferred max_level in the pre-fault
handle then later query the npt level; use the npt level in the RMP to
make sure they are in sync.

There is yet another reason why we can't avoid the PSMASH after doing
everything to ensure that NPT and RMP are in sync. e.g if NPT and RMP
are programmed with 2mb size but the guest tries to PVALIDATE the page
as a 4k. In that case, we will see #NPF with page size mismatch and have
to perform psmash.


>
> That other obvious bug is that this doesn't play nice with 1gb pages.  A 2mb RMP
> entry should _not_ force KVM to use a 2mb page instead of a 1gb page.
>
>> +}
