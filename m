Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835CA3D1564
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jul 2021 19:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbhGURHJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Jul 2021 13:07:09 -0400
Received: from mail-bn7nam10on2050.outbound.protection.outlook.com ([40.107.92.50]:36164
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236730AbhGURHI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 21 Jul 2021 13:07:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+mejGQFJJL5vL2BmkNXn0upqC4xjku7QJnaEcihMW+sdRZw+i1J3t+Zgjd6/w9N5fGGgJPcxClEegt9tLivKuEDtE5pJsblf+b8rpjp0y+k0GFkLVsWYGwYsiI0Bzr/SURJ2PKUCA8etRQksi/QAfuawoqAZMh+cTu7i/NZzWjVWXADyaQHJ+U9rCIs39yRFBuNfb17mk0nY71Y3zF/hNz6kdX4158Qua9B1l8iMw7FKAPbrHuIBdXyej83iF0ssRDdNXfOw42M6wr7y0T9+DozRuj8+4N23SAq6RGsrYxrJA1oUHtjno4XR/Hx3RUXA5WQzjZRdTAp5I4nNzhgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kW7iSb02mEQalrzLxky9ItXvsPtu0nCHxxRkjljDSS8=;
 b=WCzJ2mV16irxbKwxYJwUfprnReFzPUZiO7zQt3qPFMb4JVNYO6Gr1ziAHEekHQmjcw3TKTpm84p49epkwVq4IZZjsDzfwmOSeO9TQeX8ke4srGtbyOz9Ry3qWoKO8J1zKWJlsq9xskqQ5vAc2OTXrfgiixJvKpX1ckwnXDMkZ8JE9ZEcGH+jqPgu3uHAr04j7M8qfwL5ISzIjFQhc+wVY1cmUI0PU99sfL+Q8R3Omt2fOAAoxgIbpYX6dC0aPUKJeDqJQZ943P/9jeQEAmmtAaGqDLzonhMsvyRI505YfzYFVdAKW3kP/Tjzy8ng7iZPjn9KQrVlh26ppc9Z4Blc+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kW7iSb02mEQalrzLxky9ItXvsPtu0nCHxxRkjljDSS8=;
 b=qACAczkcgJh16w67H4xzimOvTn6synaOrrzIoWmb0ldzkn8HqSQEuVO7we/OJkJ3hzoJj2bl5QoeFCwydD/i4Gee59Q7U7sn96OVBzc/sf4yAhhFSuFS5ZhJHAu+3QizDCp8CE9L41fPhnc/L067xsbAWC+LO9cJLw+2AQp13zE=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5392.namprd12.prod.outlook.com (2603:10b6:5:39a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.32; Wed, 21 Jul
 2021 17:47:42 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 17:47:42 +0000
Subject: Re: [PATCH Part2 RFC v4 40/40] KVM: SVM: Support SEV-SNP AP Creation
 NAE event
To:     Sean Christopherson <seanjc@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
 <20210707183616.5620-41-brijesh.singh@amd.com> <YPdjvca28JaWPZRb@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <c007821a-3a79-d270-07af-eb7d4c2d0862@amd.com>
Date:   Wed, 21 Jul 2021 12:47:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPdjvca28JaWPZRb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CP5P284CA0079.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:93::12) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by CP5P284CA0079.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:93::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 17:47:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 751c7e9d-ae12-440d-f412-08d94c6fa389
X-MS-TrafficTypeDiagnostic: DM4PR12MB5392:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB53929BC14EFD33E8BDD5AD9BECE39@DM4PR12MB5392.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fPT7d9KpPcxWhifUvvzGL0WCzeShDvf6GipjiRrq3eJ5ENcXWdjyuaa/ERpYL7iP4Kw4cCQtSKfFO6NMDK6OsnmjdN4SKOwEcqZB3fg4joiYXhYAExB562KH/XLEGcA6l74hMMG0WJoK5w5nxyz9mY5Y5aYTAZzp+b2zkPWR6e2SOaBhDSpZDISHfPMBHTO4+TDaWzI0YJH3il5G/C68c1UOc3QzjiEiNoSICsTJwx0Z2QNpeRmxQyBs6nAkXTAhwjjPmJ4w1cgI7aumzlt2gKV/HIjmCLMd/KNQFPpA72gdb26nTQawFYdD3uDR382gSrCWcGx8iaGVSZBAErovGhbHwjt4QnqQmXqY84uwKwjblk7YODawYekMTWUVyiTXvzjlmhMvZ8CXkMmEOZblVMWRcUFjdUAJHQD5LtAWHXXLAB23nK80vgePDpe2AGb/Ux1z/o28qCogxybOh9kqGXIS3Tv+5UOmhuVYsj07eT3P0eh8o/BQ13CEVqV5u5kNhFLMjONvSPhYybZnMVAAJxKLa+Fv+zLqwmVgoGoHfybotyIDcJxCxRuLU4u8eCu5kfheCXv/n/ncI/dTuwrijuw3qHIXXHgmn2wFCjAxHlqvkil0vrgEib/XpxIGDHN/9m1n0E77oRvjDSP/g3/riJjXJjH6mB86oz1d3mnI3L6FgA9OSy8WUDwfjj60k1RuPlbvddz3Pw9fwHEiMYHCdyqB8YUTQ345Qn7VdiYIv+btsc1KnZxxVMQhC5Eb8HgT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(16576012)(7416002)(110136005)(7406005)(4326008)(316002)(8676002)(54906003)(86362001)(8936002)(66556008)(31686004)(66946007)(66476007)(2906002)(2616005)(956004)(26005)(30864003)(186003)(6486002)(53546011)(38100700002)(478600001)(83380400001)(6636002)(31696002)(5660300002)(6666004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0pMODB2QzA2QW82RDlSYmdOUHcwS2EwWHhDZjNZS1ZJb0VFRGh4UEtWUmtM?=
 =?utf-8?B?WS9lS2twV25nV2lmd2xNMG83Qm1MbnA1QjhpWmR3RXVMcHZpTjVlZ2s3bFM3?=
 =?utf-8?B?L1pXYmw3OTc0Nm9hbitIVUhHRVRBZW0vTHBId1Bud3NiakNPK3kzTm51aUZE?=
 =?utf-8?B?cEhEOWUwTEdJM1lLOG5mU3NHbmx4SUJ4WEU2K3dUb2phVk04U01zdDZHREpZ?=
 =?utf-8?B?T1ZCbkloVmE3SEFpOGVkdm5SMmd4TzY5MVI5QlVJU1BpUGhWbFM5a2J3QmJ2?=
 =?utf-8?B?WHVEQUJQRTIyRzFiOTV5cHlVdno4MS96eWdVT3AyNldrcW0vVXdYN3RNaFU3?=
 =?utf-8?B?SFRsYU91NjErMEFqRzRQemZ0M3pRVGRpNGY2djBuQ3hVVjJkZVhhRUx3cDk2?=
 =?utf-8?B?ZGZyOWpmZTl6SExMSUV1ak5HeVFPTEJNUUNjSmptS0JpYTJnVXRIVUZwaElr?=
 =?utf-8?B?WGdPa3U4Q0R4UXkvYzdIQ3hKZ2d0WVpnMmUyQVhkSzNWMVN2NmpLekYwNEpH?=
 =?utf-8?B?WStYQjQ5RGZucUJYUEYzOGFLWE94em1MSUNPQ0wzMDQxSkU1MmhGZDdTRE5L?=
 =?utf-8?B?T2VlQjQxSy9JOVRiaHZUOVZ1eFhOd20rQzFpOTBxbzVBbVA4MkN4ZlZycEhT?=
 =?utf-8?B?QUlzbnJHME1TdDV2b0UxT0QySkEvcnlzTEtqbkJKK2tjMnBLN2g5YVNJZkhX?=
 =?utf-8?B?N2dmbkl0TFVmcmdEdVVVT2dxOHRtSTlBc1UxeWI4V1BGUWVWWFFsUkx4VDJ6?=
 =?utf-8?B?SjNmc3ZJY1FGTmxIbTFjeUpHWUZ1SnUxcWJtOVdnb21jdDJkWnVEU3dKMVhO?=
 =?utf-8?B?clY4MHgyWGhiNUFwbm9WSElpMjF0elZiV1NmTkdXUnhwMndGU2V6VUI0MGxn?=
 =?utf-8?B?V28vWnliR21WbTRHZ1I2NGRUbVE1NW5Sanl5eUtLckE1WDRGRWREUWI2bUQv?=
 =?utf-8?B?c3cxUGpUNU5aQUlsNjRmODY0cFhBMmVGRC94dEhEdGIydEJiay9OaXBwYXlh?=
 =?utf-8?B?SHpUYWZkdWYrS0xISHVJemNhcUFISWdrUlNJcndoQnAyT05LVG1JaW1CRkJO?=
 =?utf-8?B?QXFBNEJZY1o2cUxjd2ZxNG5aL0RjZmdhR25EVy8yK3dBZGpBbW5NMFJVUkI3?=
 =?utf-8?B?WE1mbU9NM3k4Vzhkb1ZZMHE1cW9vNFUrNThyaW5mVHVQdm53dERSbFFnRHhZ?=
 =?utf-8?B?ODlReGYraVVQNzhDNFVhN01od0hXL0JkUm4raUYzOWhiVEg1QzJhQzR6a2Q0?=
 =?utf-8?B?Mk1yTXhRZEN5OGdOVEJIcXJlc1dkRGE5QWxqQmFtZFhBOTRpT0ZTcld1Njl4?=
 =?utf-8?B?V2MzcjZ4QmM3YTMwYjdhR2FNbnU1dXlpZmpIV0g5R1JlMmRvcTAxVlczcXUr?=
 =?utf-8?B?akp4UGh3STk0VmxQU3NoS1dwTjF4bHI5N1dYZjRsM2ZXZjhXUXlNdnZ0cHM4?=
 =?utf-8?B?c3BsT3NEWS81em96WUJnY01mN1FrcUxkUnJacDZkN2ovRDRQUFRsY2JPbHI0?=
 =?utf-8?B?bXVyMkV4aWVPbHVjMVpSaXB3Y0dxYnFyaHJOTmVidlFjZXMvVmxvWXNsSVVO?=
 =?utf-8?B?T0p3SjY1S2hnQ1oxWU9saFl5dGlSMit0ME9ScHhlSTBhOHE5RmpOc3Z0cTZN?=
 =?utf-8?B?M3RTRlhpdWw4LzhNQTgwdUptMnBnZU1xc3FtZ1FHMGxmV0RUbjN0NThiYVRN?=
 =?utf-8?B?UHVkUFcvRGJuVjdxeFRrcHd6UGluanRuVDJLUXlmL3dGWngxZW55TXZTQ0pJ?=
 =?utf-8?Q?okSBorE9fbp6AVx2XFAo2jYqqDyZdGVSi6RUC3f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751c7e9d-ae12-440d-f412-08d94c6fa389
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 17:47:42.3521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrAxynW98ncip57KLNkqzqHEwbM0RQrN/FsqXG9B4GuI8gyAdH5Mprcca5DpTDQI/K+0TMApGkwISPcRJMTJOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5392
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 7/20/21 7:01 PM, Sean Christopherson wrote:
> On Wed, Jul 07, 2021, Brijesh Singh wrote:
>> From: Tom Lendacky <thomas.lendacky@amd.com>
>>
>> Add support for the SEV-SNP AP Creation NAE event. This allows SEV-SNP
>> guests to create and start APs on their own.
> 
> The changelog really needs to clarify that this doesn't allow the guest to create
> arbitrary vCPUs.  The GHCB uses CREATE/DESTROY terminology, but this patch and its
> comments/documentation should very clearly call out that KVM's implementation is
> more along the line of vCPU online/offline.

Will update.

> 
> It should also be noted that KVM still onlines APs by default.  That also raises
> the question of whether or not KVM should support creating an offlined vCPU.
> E.g. several of the use cases I'm aware of want to do something along the lines
> of creating a VM with the max number of theoretical vCPUs, but in most instances
> only run a handful of vCPUs.  That's a fair amount of potential memory savings
> if the max theoretical number of vCPUs is high.
> 
>> A new event, KVM_REQ_UPDATE_PROTECTED_GUEST_STATE, is created and used
>> so as to avoid updating the VMSA pointer while the vCPU is running.
>>
>> For CREATE
>>   The guest supplies the GPA of the VMSA to be used for the vCPU with the
>>   specified APIC ID. The GPA is saved in the svm struct of the target
>>   vCPU, the KVM_REQ_UPDATE_PROTECTED_GUEST_STATE event is added to the
>>   vCPU and then the vCPU is kicked.
>>
>> For CREATE_ON_INIT:
>>   The guest supplies the GPA of the VMSA to be used for the vCPU with the
>>   specified APIC ID the next time an INIT is performed. The GPA is saved
>>   in the svm struct of the target vCPU.
>>
>> For DESTROY:
>>   The guest indicates it wishes to stop the vCPU. The GPA is cleared from
>>   the svm struct, the KVM_REQ_UPDATE_PROTECTED_GUEST_STATE event is added
>>   to vCPU and then the vCPU is kicked.
>>
>>
>> The KVM_REQ_UPDATE_PROTECTED_GUEST_STATE event handler will be invoked as
>> a result of the event or as a result of an INIT. The handler sets the vCPU
>> to the KVM_MP_STATE_UNINITIALIZED state, so that any errors will leave the
>> vCPU as not runnable. Any previous VMSA pages that were installed as
>> part of an SEV-SNP AP Creation NAE event are un-pinned. If a new VMSA is
>> to be installed, the VMSA guest page is pinned and set as the VMSA in the
>> vCPU VMCB and the vCPU state is set to KVM_MP_STATE_RUNNABLE. If a new
>> VMSA is not to be installed, the VMSA is cleared in the vCPU VMCB and the
>> vCPU state is left as KVM_MP_STATE_UNINITIALIZED to prevent it from being
>> run.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>  arch/x86/include/asm/kvm_host.h |   3 +
>>  arch/x86/include/asm/svm.h      |   3 +
>>  arch/x86/kvm/svm/sev.c          | 133 ++++++++++++++++++++++++++++++++
>>  arch/x86/kvm/svm/svm.c          |   7 +-
>>  arch/x86/kvm/svm/svm.h          |  16 +++-
>>  arch/x86/kvm/x86.c              |  11 ++-
>>  6 files changed, 170 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index 117e2e08d7ed..881e05b3f74e 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -91,6 +91,7 @@
>>  #define KVM_REQ_MSR_FILTER_CHANGED	KVM_ARCH_REQ(29)
>>  #define KVM_REQ_UPDATE_CPU_DIRTY_LOGGING \
>>  	KVM_ARCH_REQ_FLAGS(30, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>> +#define KVM_REQ_UPDATE_PROTECTED_GUEST_STATE	KVM_ARCH_REQ(31)
>>  
>>  #define CR0_RESERVED_BITS                                               \
>>  	(~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_TS \
>> @@ -1402,6 +1403,8 @@ struct kvm_x86_ops {
>>  
>>  	int (*handle_rmp_page_fault)(struct kvm_vcpu *vcpu, gpa_t gpa, kvm_pfn_t pfn,
>>  			int level, u64 error_code);
>> +
>> +	void (*update_protected_guest_state)(struct kvm_vcpu *vcpu);
>>  };
>>  
>>  struct kvm_x86_nested_ops {
>> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
>> index 5e72faa00cf2..6634a952563e 100644
>> --- a/arch/x86/include/asm/svm.h
>> +++ b/arch/x86/include/asm/svm.h
>> @@ -220,6 +220,9 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
>>  #define SVM_SEV_FEATURES_DEBUG_SWAP		BIT(5)
>>  #define SVM_SEV_FEATURES_PREVENT_HOST_IBS	BIT(6)
>>  #define SVM_SEV_FEATURES_BTB_ISOLATION		BIT(7)
>> +#define SVM_SEV_FEATURES_INT_INJ_MODES			\
>> +	(SVM_SEV_FEATURES_RESTRICTED_INJECTION |	\
>> +	 SVM_SEV_FEATURES_ALTERNATE_INJECTION)
>>  
>>  struct vmcb_seg {
>>  	u16 selector;
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index d8ad6dd58c87..95f5d25b4f08 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -582,6 +582,7 @@ static int sev_launch_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
>>  
>>  static int sev_es_sync_vmsa(struct vcpu_svm *svm)
>>  {
>> +	struct kvm_sev_info *sev = &to_kvm_svm(svm->vcpu.kvm)->sev_info;
>>  	struct sev_es_save_area *save = svm->vmsa;
>>  
>>  	/* Check some debug related fields before encrypting the VMSA */
>> @@ -625,6 +626,12 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
>>  	if (sev_snp_guest(svm->vcpu.kvm))
>>  		save->sev_features |= SVM_SEV_FEATURES_SNP_ACTIVE;
>>  
>> +	/*
>> +	 * Save the VMSA synced SEV features. For now, they are the same for
>> +	 * all vCPUs, so just save each time.
>> +	 */
>> +	sev->sev_features = save->sev_features;
>> +
>>  	return 0;
>>  }
>>  
>> @@ -2682,6 +2689,10 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
>>  		if (!ghcb_sw_scratch_is_valid(ghcb))
>>  			goto vmgexit_err;
>>  		break;
>> +	case SVM_VMGEXIT_AP_CREATION:
>> +		if (!ghcb_rax_is_valid(ghcb))
>> +			goto vmgexit_err;
>> +		break;
>>  	case SVM_VMGEXIT_NMI_COMPLETE:
>>  	case SVM_VMGEXIT_AP_HLT_LOOP:
>>  	case SVM_VMGEXIT_AP_JUMP_TABLE:
>> @@ -3395,6 +3406,121 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
>>  	return ret;
>>  }
>>  
>> +void sev_snp_update_protected_guest_state(struct kvm_vcpu *vcpu)
>> +{
>> +	struct vcpu_svm *svm = to_svm(vcpu);
>> +	kvm_pfn_t pfn;
>> +
>> +	mutex_lock(&svm->snp_vmsa_mutex);
>> +
>> +	vcpu->arch.mp_state = KVM_MP_STATE_UNINITIALIZED;
>> +
>> +	/* Clear use of the VMSA in the sev_es_init_vmcb() path */
>> +	svm->vmsa_pa = 0;
>> +
>> +	/* Clear use of the VMSA from the VMCB */
>> +	svm->vmcb->control.vmsa_pa = 0;
> 
> PA=0 is not an invalid address.  I don't care what value the GHCB uses for
> "invalid GPA", KVM should always use INVALID_PAGE to track an invalid physical
> address.

Right, I'll switch everything over to INVALID_PAGE, which will also cause
an error on VMRUN, so that is good.

> 
>> +	/* Un-pin previous VMSA */
>> +	if (svm->snp_vmsa_pfn) {
>> +		kvm_release_pfn_dirty(svm->snp_vmsa_pfn);
> 
> Oof, I was wondering why KVM tracks three versions of VMSA.  Actually, I'm still
> wondering why there are three versions.  Aren't snp_vmsa_pfn and vmsa_pa tracking
> the same thing?  Ah, finally figured it out.  vmsa_pa points at svm->vmsa by
> default.  Blech.
> 
>> +		svm->snp_vmsa_pfn = 0;
>> +	}
>> +
>> +	if (svm->snp_vmsa_gpa) {
> 
> This is bogus, GPA=0 is perfectly valid.  As above, use INVALID_PAGE.  A comment
> explaining that the vCPU is offline when VMSA is invalid would also be helpful.

Will do.

> 
>> +		/* Validate that the GPA is page aligned */
>> +		if (!PAGE_ALIGNED(svm->snp_vmsa_gpa))
> 
> This needs to be moved to the VMGEXIT, and it should use page_address_valid() so
> that KVM also checks for a legal GPA.

Will do.

> 
>> +			goto e_unlock;
>> +
>> +		/*
>> +		 * The VMSA is referenced by thy hypervisor physical address,
> 
> s/thy/the, although converting to archaic English could be hilarious...

Heh, I'll fix that.

> 
>> +		 * so retrieve the PFN and pin it.
>> +		 */
>> +		pfn = gfn_to_pfn(vcpu->kvm, gpa_to_gfn(svm->snp_vmsa_gpa));
>> +		if (is_error_pfn(pfn))
>> +			goto e_unlock;
> 
> Silently ignoring the guest request is bad behavior, at worst KVM should exit to
> userspace with an emulation error.

You'll end up with a VMRUN failure, which is likely to be the same result.
But I can look at what it would take to exit up to userspace before that.

> 
>> +
>> +		svm->snp_vmsa_pfn = pfn;
>> +
>> +		/* Use the new VMSA in the sev_es_init_vmcb() path */
>> +		svm->vmsa_pa = pfn_to_hpa(pfn);
>> +		svm->vmcb->control.vmsa_pa = svm->vmsa_pa;
>> +
>> +		vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
>> +	} else {
>> +		vcpu->arch.pv.pv_unhalted = false;
> 
> Shouldn't the RUNNABLE path also clear pv_unhalted?

If anything it should set it, since it will be "unhalted" now. But, I
looked through the code to try and understand if there was a need to set
it and didn't really see any reason. It is only ever set (at least
directly) in one place and is cleared everywhere else. It was odd to me.

> 
>> +		vcpu->arch.mp_state = KVM_MP_STATE_UNINITIALIZED;
> 
> What happens if userspace calls kvm_arch_vcpu_ioctl_set_mpstate, or even worse
> the guest sends INIT-SIPI?  Unless I'm mistaken, either case will cause KVM to
> run the vCPU with vmcb->control.vmsa_pa==0.

Using the INVALID_PAGE value now (and even when it was 0), you'll get a
VMRUN failure.

The AP CREATE_ON_INIT is meant to be used with INIT-SIPI, so if the guest
hasn't done the right thing, then it will fail on VMRUN.

> 
> My initial reaction is that the "offline" case needs a new mp_state, or maybe
> just use KVM_MP_STATE_STOPPED.

I'll look at KVM_MP_STATE_STOPPED. Qemu doesn't reference that state at
all in the i386 support, though, which is why I went with UNINITIALIZED.

> 
>> +	}
>> +
>> +e_unlock:
>> +	mutex_unlock(&svm->snp_vmsa_mutex);
>> +}
>> +
>> +static void sev_snp_ap_creation(struct vcpu_svm *svm)
>> +{
>> +	struct kvm_sev_info *sev = &to_kvm_svm(svm->vcpu.kvm)->sev_info;
>> +	struct kvm_vcpu *vcpu = &svm->vcpu;
>> +	struct kvm_vcpu *target_vcpu;
>> +	struct vcpu_svm *target_svm;
>> +	unsigned int request;
>> +	unsigned int apic_id;
>> +	bool kick;
>> +
>> +	request = lower_32_bits(svm->vmcb->control.exit_info_1);
>> +	apic_id = upper_32_bits(svm->vmcb->control.exit_info_1);
>> +
>> +	/* Validate the APIC ID */
>> +	target_vcpu = kvm_get_vcpu_by_id(vcpu->kvm, apic_id);
>> +	if (!target_vcpu)
>> +		return;
> 
> KVM should not silently ignore bad requests, this needs to return an error to the
> guest.

This can be made to return an int and then follow standard VMGEXIT processing.

Which reminds me to get a GHCB discussion going on returning some other
form of error besides exceptions.

> 
>> +
>> +	target_svm = to_svm(target_vcpu);
>> +
>> +	kick = true;
> 
> This is wrong, e.g. KVM will kick the target vCPU even if the request fails.
> I suspect the correct behavior would be to:
> 
>   1. do all sanity checks
>   2. take the necessary lock(s)
>   3. modify target vCPU state
>   4. kick target vCPU unless request==SVM_VMGEXIT_AP_CREATE_ON_INIT

I'm not sure... the guest is really trying to do an INIT-SIPI type of
action and if they don't do something correctly, we don't want to leave
the AP running in its previous state, hence the kick, so that it will end
up falling back to UNINITIALIZED state.

> 
>> +	mutex_lock(&target_svm->snp_vmsa_mutex);
> 
> This seems like it's missing a big pile of sanity checks.  E.g. KVM should reject
> SVM_VMGEXIT_AP_CREATE if the target vCPU is already "created", including the case
> where it was "created_on_init" but hasn't yet received INIT-SIPI.

Why? If the guest wants to call it multiple times I guess I don't see a
reason that it would need to call DESTROY first and then CREATE. I don't
know why a guest would want to do that, but I don't think we should
prevent it.

> 
>> +
>> +	target_svm->snp_vmsa_gpa = 0;
>> +	target_svm->snp_vmsa_update_on_init = false;
>> +
>> +	/* Interrupt injection mode shouldn't change for AP creation */
>> +	if (request < SVM_VMGEXIT_AP_DESTROY) {
>> +		u64 sev_features;
>> +
>> +		sev_features = vcpu->arch.regs[VCPU_REGS_RAX];
>> +		sev_features ^= sev->sev_features;
>> +		if (sev_features & SVM_SEV_FEATURES_INT_INJ_MODES) {
> 
> Why is only INT_INJ_MODES checked?  The new comment in sev_es_sync_vmsa() explicitly
> states that sev_features are the same for all vCPUs, but that's not enforced here.
> At a bare minimum I would expect this to sanity check SVM_SEV_FEATURES_SNP_ACTIVE.

That's because we can't really enforce it. The SEV_FEATURES value is part
of the VMSA, of which the hypervisor has no insight into (its encrypted).

The interrupt injection mechanism was specifically requested as a sanity
check type of thing during the GHCB review, and as there were no
objections, it was added (see the end of section 4.1.9).

I can definitely add the check for the SNP_ACTIVE bit, but it isn't required.

> 
>> +			vcpu_unimpl(vcpu, "vmgexit: invalid AP injection mode [%#lx] from guest\n",
>> +				    vcpu->arch.regs[VCPU_REGS_RAX]);
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	switch (request) {
>> +	case SVM_VMGEXIT_AP_CREATE_ON_INIT:
> 
> Out of curiosity, what's the use case for this variant?  I assume the guest has
> to preconfigure the VMSA and ensure the target vCPU's RIP points at something
> sane anyways, otherwise the hypervisor could attack the guest by immediately
> attempting to run the deferred vCPU.  At that point, a guest could simply use an
> existing mechanism to put the target vCPU into a holding pattern.

It came up in early discussions and so was included in the initial draft
of the GHCB SNP support. There wasn't any discussion about it nor any
objections, so it stayed.

> 
>> +		kick = false;
>> +		target_svm->snp_vmsa_update_on_init = true;
>> +		fallthrough;
>> +	case SVM_VMGEXIT_AP_CREATE:
>> +		target_svm->snp_vmsa_gpa = svm->vmcb->control.exit_info_2;
> 
> The incoming GPA needs to be checked for validity, at least as much possible.
> E.g. the PAGE_ALIGNED() check should be done here and be morphed to a synchronous
> error for the guest, not a silent "oops, didn't run your vCPU".

Will do.

> 
>> +		break;
>> +	case SVM_VMGEXIT_AP_DESTROY:
>> +		break;
>> +	default:
>> +		vcpu_unimpl(vcpu, "vmgexit: invalid AP creation request [%#x] from guest\n",
>> +			    request);
>> +		break;
>> +	}
>> +
>> +out:
>> +	mutex_unlock(&target_svm->snp_vmsa_mutex);
>> +
>> +	if (kick) {
>> +		kvm_make_request(KVM_REQ_UPDATE_PROTECTED_GUEST_STATE, target_vcpu);
>> +		kvm_vcpu_kick(target_vcpu);
>> +	}
>> +}
>> +
>>  int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
>>  {
>>  	struct vcpu_svm *svm = to_svm(vcpu);
>> @@ -3523,6 +3649,11 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
>>  		ret = 1;
>>  		break;
>>  	}
>> +	case SVM_VMGEXIT_AP_CREATION:
>> +		sev_snp_ap_creation(svm);
>> +
>> +		ret = 1;
>> +		break;
>>  	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
>>  		vcpu_unimpl(vcpu,
>>  			    "vmgexit: unsupported event - exit_info_1=%#llx, exit_info_2=%#llx\n",
>> @@ -3597,6 +3728,8 @@ void sev_es_create_vcpu(struct vcpu_svm *svm)
>>  	set_ghcb_msr(svm, GHCB_MSR_SEV_INFO(GHCB_VERSION_MAX,
>>  					    GHCB_VERSION_MIN,
>>  					    sev_enc_bit));
>> +
>> +	mutex_init(&svm->snp_vmsa_mutex);
>>  }
>>  
>>  void sev_es_prepare_guest_switch(struct vcpu_svm *svm, unsigned int cpu)
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index 74bc635c9608..078a569c85a8 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -1304,7 +1304,10 @@ static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>>  	svm->spec_ctrl = 0;
>>  	svm->virt_spec_ctrl = 0;
>>  
>> -	if (!init_event) {
>> +	if (init_event && svm->snp_vmsa_update_on_init) {
> 
> This can race with sev_snp_ap_creation() since the new snp_vmsa_mutex isn't held.
> There needs to be smp_rmb() and smp_wmb() barriers to ensure correct ordering
> between snp_vmsa_update_on_init and consuming the new VMSA gpa.  And of course
> sev_snp_ap_creation() needs to have correct ordering, e.g. as is this code can
> see snp_vmsa_update_on_init=true before the new snp_vmsa_gpa is set.

I'll work on that.

Thanks,
Tom

> 
>> +		svm->snp_vmsa_update_on_init = false;
>> +		sev_snp_update_protected_guest_state(vcpu);
>> +	} else {
>>  		vcpu->arch.apic_base = APIC_DEFAULT_PHYS_BASE |
>>  				       MSR_IA32_APICBASE_ENABLE;
>>  		if (kvm_vcpu_is_reset_bsp(vcpu))
> 
