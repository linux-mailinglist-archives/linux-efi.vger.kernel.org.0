Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2EB43CD674
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jul 2021 16:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239574AbhGSNjA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Jul 2021 09:39:00 -0400
Received: from mail-co1nam11on2073.outbound.protection.outlook.com ([40.107.220.73]:39948
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232249AbhGSNi7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 19 Jul 2021 09:38:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiha1TK7f5bY2vcpKgqszi+jOyv63cpvurtHyOjkQdduALcJS1wAf/R2Y3ydzgpvlmqcrxbr56+gxKez+kE+crQU8L+DrEHSyuNtry7G4SVjj31w4v9cCByEhkOYT8gwKcgT33HqqS2iBCt71f9PjDbCnUJckjFRw/Wm0vt1Sxyo8ipvBr6yyl5zlZXswJh8bG3m/cI1JziVjtjqUFD7gCLgM5etRddSngcFcjMcN0kwt4oq0suDzr5QYpSsWP5pyC1RQAR0Zr69PTE9iMAKGPfR04B5/uBUbHkhnzC8yXuUF1eK05vb4Pk2lvbH3OwOK5AeMsr3Xrf4ueJ+bB7YZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31M8AC3t/vwGL2Gt2xtSqoRfqszNmlUYcE+FfP3rUf4=;
 b=oHBzElI5/ZaT0MdcAA2OtdhWXCslQg+5o8InYjWCfm1n6YPQxUtYVMLKxGrZJtYbDGomGB3WOzmze02NMBvx/f0OMZiWhwJIKcZJYYFV/hhvbbuQtUdNPSZ1tbiXNmA3zXy0x3YCJiLpBhExeKtXnQVu/bA2vgD06dTLwB1bY52RYiNzDp+Du2GWzenfDpGeoYJ+qOdzC/GSdmRORySKeNLic7uL8U1KFZa1N3PmMP+y27PcX1nRdSgyg/yataHvDpepS/nUN3zLEEEJwSC7QFQ/eBv6I3odZemfXSPUkA6CxaIwQwBe8WojZWtRYxCre9KpAi4uHxoetQq6yG/1RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31M8AC3t/vwGL2Gt2xtSqoRfqszNmlUYcE+FfP3rUf4=;
 b=C7AFM90ndIfdkMnE9wxni0MHLBr7jkIjiS0+1L8LmFN2G/YZvj3k74GOSJUG1dWcIjP2WFR1ZYn42W/ZJ+YBC8qJfD4dBKNX1kYh2VsU5XPWZPK6JYeKVt39UMi522KW941Dmxd8MIUNRjxtFj9RgSQhqczqYOCVRPB7O20Mdh8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 14:19:36 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 14:19:36 +0000
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
Subject: Re: [PATCH Part2 RFC v4 33/40] KVM: SVM: Add support to handle MSR
 based Page State Change VMGEXIT
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-34-brijesh.singh@amd.com> <YPHzcstus9mS8hOm@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <b9527f12-f3ad-c6b9-2967-5d708d69d937@amd.com>
Date:   Mon, 19 Jul 2021 09:19:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPHzcstus9mS8hOm@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0117.namprd11.prod.outlook.com
 (2603:10b6:806:d1::32) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SA0PR11CA0117.namprd11.prod.outlook.com (2603:10b6:806:d1::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 14:19:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adce0cc2-db51-4871-8e09-08d94ac03c51
X-MS-TrafficTypeDiagnostic: SA0PR12MB4525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45256A936869B9AE6F9F9352E5E19@SA0PR12MB4525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttrDNoL3g2CLk7YEo2sdol/vgfEMbp+yIAiXkyEDtFZ2zsXU+AZqxk0SMKjIY1983ThUNw0Dem/vlYvUogl4tDLJgxaKj77kgMbp6X6PNSJ3we/e+wL7/tdqiaj6IssBeI4nu0lpocALomNGcNT60TK5aj5L4Y9WTK04cK952EiyhCJ68aioGtrI7hXiZv5nTDVoHBQcov/AeikJ8Kpie8oCJ81k5c80Y/C2z0IQciNx0HtPoc4SVC1Z8FjG8U8NlZhMgIlNHijRE3ygZoLS5Ytq+L3fHNH5OaM/xK3kvTMi7yiciz9NV92rKMTMuz0dZZT5wUWEKAOzdrJxRGdbYziHmHt0Qh57WqqT2dpeRyEIjkvcBrISupSjsL1CanVfLSoZuaSLvoHna/lVJrMUQy040VZpAMFmJc+2dx0CsX2iJWz/OCUOp2r/iFwuVx9SFl9i/BfdED9/E3GtMWIUzZ5IPtdQkAb7HD4k29NkcmdxZrvANlRsZisWIMuGKDWHkk6FK1oA3kUj6ZXpgV/4s0dh9UwW/MTot28ZY5ipLJjpOZ9RPM99F3Xajm62MC7AjqDc93tvMhXIpeFUyIJ7fXJB4XN6p7hb68gaTOKvXB1eU6H5ZDdr0MMyar6ubltIl30N1FUkv2iCHDCIeYdz/mm9kLBMzkasGlKYCJMxE5Nk8kTp+eQrknSptowb4MUScTDcPfXbMneH1RHLBr7prR+Rtd7zpY+9MOKh/nVZLA6Nfmn6I81L6GFs6r9imusOzGOywQ3XI9vxJgF7XHrFdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(31696002)(7416002)(7406005)(53546011)(66946007)(2906002)(66476007)(66556008)(83380400001)(52116002)(38350700002)(38100700002)(6916009)(44832011)(478600001)(86362001)(186003)(4326008)(6486002)(26005)(2616005)(31686004)(5660300002)(316002)(8936002)(16576012)(36756003)(54906003)(956004)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzNxKzdWUngzV2FNMXZ2SFFCRGNlME44ZjNHbW5QT3ZLRUhXRlEyY0dFS2h3?=
 =?utf-8?B?ZHFFNXh5UFpnTXBDS0l4dkZvakRFN2x4MnlYTnk4Vi9xamFhTEpVSmY4MmVy?=
 =?utf-8?B?dzk4Q2NEcThLdi9JbnN0SWNYSXg0dWtDVTBoRWlBL3dlVTFBckRDRFFOeS8z?=
 =?utf-8?B?YVhIbjV4K0dZTDBKbGhTZ3g3RjN5cUVib1lKUmV3WE5GYWptaStHVG5RRVZ4?=
 =?utf-8?B?UlErSEJvNU1VT3dyRXU1dXE3dnRUdjNsSFgzNnExdWRDcnRZdGk4bHQ2SlFB?=
 =?utf-8?B?SUszNjc4cmpmOEpBN3A0QWc4UDdzU296T2U3dFpXWU1ybkpQVy9JR25yS09H?=
 =?utf-8?B?dHdTZndLTGZvTDJDY0lrK2xxdDRmT0ZRa1kzYXlnT2NlTWk0OFM4OThXYith?=
 =?utf-8?B?SkdITVN6VStXQ0lSbGVCY2tvZEdTSEsxOVZNMWJTYTl5YkIrY3ZRdGJRR2dH?=
 =?utf-8?B?WWt6R0l5QU1Kd1VzampGZmhqNGZabi9xaG1LdVZZbVBiT0RoNWRhYzhoUVlo?=
 =?utf-8?B?ZlhBQzdEMkFqMDk5ZVpyMlpFd0pJeXV6SmUzV1JqSHhHN2RKNlV4S29UaHkx?=
 =?utf-8?B?ZUtLSTB0SWJsT3dzYmFERG5NOFVwV3pBcnNscEtUSW1ManpUV3lrWlFjZHl3?=
 =?utf-8?B?WGZvS25ia3F1NDhwc2xIWkV4RXBnMm1zTm1FbjlpY1NnSE1MaFowYi9oR3hz?=
 =?utf-8?B?T2RPTW5BZ284VFdLMlhwQndZcTVLRlVCamMxcU1BWlZWNW4ydERSZktweElx?=
 =?utf-8?B?czQ3WG5MeTkxM05pZ05ZT3JwZHVvYUMrdU1RNE1VLytRaVhXaVA2Z2VHQ2VW?=
 =?utf-8?B?K1JWeXpzR2NPQzFxUVVNcjBxcFBndzNtMkRzU3d4UldMazZoQzhZVDFWSzVJ?=
 =?utf-8?B?WE1INDcxZXl1MGlvYnNKVlpocEV1RGkxYUVocVJRUFV3S0pyUTFkNGpIUGgx?=
 =?utf-8?B?cHc3TmhSR0QzcmdxczUrQlA2akQ5SEFFWlZaT1hjNXJzSXRtYXZMWmtCUmRX?=
 =?utf-8?B?SEt1cWw5UzVwZmc2aVIyazAvRkxyTEQ0cDhUOHJBN0RxdU5ITnlWUFNxeTVR?=
 =?utf-8?B?VEpUV253d00wTVNGZmQ4TXZFa2p2MDFPRzRkTXlpbU84cEpZUUhTNVFUTkF0?=
 =?utf-8?B?NjF2dWRzcEhPN3Z6M1Y1NzhWVHdRK2hLUXd2VUlleDRwcFM4M1ZaL3FVc2tU?=
 =?utf-8?B?NEFwU25RaDNaQTViTEk1VDdjeFRJWnFrNVpWRkpLdEFOeVhxYXI2TEtIUHpG?=
 =?utf-8?B?c2xNd29JTlo5TC9JRlNNTllwU1pkN21WZWFSaHlKQ2NPNnVuajFIVGZ6eHNm?=
 =?utf-8?B?ODBCWENiOFFkcXFaNDIvOEllWUJPK0Vhd2prUnZ2Y0NyMXpZSHpmTkNnMjV6?=
 =?utf-8?B?NSttZG8rUEViZGVaYkhXQTJqRlJZNmUxV2JCckFuOVdscER3V1RhZC9EMEVt?=
 =?utf-8?B?WGMxbDRmZHZqSmlrQ1ZqRGJZcHJZVU5zMERJUlRQQUJieWEya0I0VFZpRXZT?=
 =?utf-8?B?TlUxTk5zcFIzYUNRQ1VDWWZmTzZwa3Uxbk1JOWk2TGZMV0cyNjFLaFRtZWl2?=
 =?utf-8?B?cUh5SThVTzZKeCtidHQ1ZUJEcFBDaURqVTJQY2Y2NkhzUWE2RXhDSFU2Zzda?=
 =?utf-8?B?RklZK1pVOVVWbTRyTklyRTUrUlhhdGsrb0hNSXpYcGlrdFU1OFYrZHlWbmdP?=
 =?utf-8?B?bXlsV2MxRHhXZTlJa1FQTmJwM1NUUTRhZitGV0ZNbWUvcGh2NklIZFAzckVu?=
 =?utf-8?Q?kCbn/MICJIcz5sXDByE87IqTG10IXHCm7RrqqGE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adce0cc2-db51-4871-8e09-08d94ac03c51
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 14:19:35.8648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qf/m0q/SgPChGcErYsuW1J0nZqdo+Osui7cPmdx0CM5L1vNoJzMamEHje3b0i4KyrvUQPPbLMlUurVFAhRNBgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/16/21 4:00 PM, Sean Christopherson wrote:
> On Wed, Jul 07, 2021, Brijesh Singh wrote:
>> +static int __snp_handle_psc(struct kvm_vcpu *vcpu, int op, gpa_t gpa, int level)
> 
> I can live with e.g. GHCB_MSR_PSC_REQ, but I'd strongly prefer to spell this out,
> e.g. __snp_handle_page_state_change() or whatever.  I had a hell of a time figuring
> out what PSC was the first time I saw it in some random context.

Based on the previous review feedback I renamed from 
__snp_handle_page_state_change to __snp_handle_psc(). I will see what 
others say and based on that will rename accordingly.

> 
>> +{
>> +	struct kvm *kvm = vcpu->kvm;
>> +	int rc, tdp_level;
>> +	kvm_pfn_t pfn;
>> +	gpa_t gpa_end;
>> +
>> +	gpa_end = gpa + page_level_size(level);
>> +
>> +	while (gpa < gpa_end) {
>> +		/*
>> +		 * Get the pfn and level for the gpa from the nested page table.
>> +		 *
>> +		 * If the TDP walk failed, then its safe to say that we don't have a valid
>> +		 * mapping for the gpa in the nested page table. Create a fault to map the
>> +		 * page is nested page table.
>> +		 */
>> +		if (!kvm_mmu_get_tdp_walk(vcpu, gpa, &pfn, &tdp_level)) {
>> +			pfn = kvm_mmu_map_tdp_page(vcpu, gpa, PFERR_USER_MASK, level);
>> +			if (is_error_noslot_pfn(pfn))
>> +				goto out;
>> +
>> +			if (!kvm_mmu_get_tdp_walk(vcpu, gpa, &pfn, &tdp_level))
>> +				goto out;
>> +		}
>> +
>> +		/* Adjust the level so that we don't go higher than the backing page level */
>> +		level = min_t(size_t, level, tdp_level);
>> +
>> +		write_lock(&kvm->mmu_lock);
> 
> Retrieving the PFN and level outside of mmu_lock is not correct.  Because the
> pages are pinned and the VMM is not malicious, it will function as intended, but
> it is far from correct.
> 

Good point, I should have retrieved the pfn and level inside the lock.

> The overall approach also feels wrong, e.g. a guest won't be able to convert a
> 2mb chunk back to a 2mb large page if KVM mapped the GPA as a 4kb page in the
> past (from a different conversion).
> 

Maybe I am missing something, I am not able to follow 'guest won't be 
able to convert a 2mb chunk back to a 2mb large page'. The page-size 
used inside the guest have to relationship with the RMP/NPT page-size. 
e.g, a guest can validate the page range as a 4k and still map the page 
range as a 2mb or 1gb in its pagetable.


> I'd also strongly prefer to have a common flow between SNP and TDX for converting
> between shared/prviate.
> 
> I'll circle back to this next week, it'll probably take a few hours of staring
> to figure out a solution, if a common one for SNP+TDX is even possible.
> 

Sounds good.

>> +
>> +		switch (op) {
>> +		case SNP_PAGE_STATE_SHARED:
>> +			rc = snp_make_page_shared(vcpu, gpa, pfn, level);
>> +			break;
>> +		case SNP_PAGE_STATE_PRIVATE:
>> +			rc = snp_make_page_private(vcpu, gpa, pfn, level);
>> +			break;
>> +		default:
>> +			rc = -EINVAL;
>> +			break;
>> +		}
>> +
>> +		write_unlock(&kvm->mmu_lock);
>> +
>> +		if (rc) {
>> +			pr_err_ratelimited("Error op %d gpa %llx pfn %llx level %d rc %d\n",
>> +					   op, gpa, pfn, level, rc);
>> +			goto out;
>> +		}
>> +
>> +		gpa = gpa + page_level_size(level);
>> +	}
>> +
>> +out:
>> +	return rc;
>> +}
>> +
>>   static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
>>   {
>>   	struct vmcb_control_area *control = &svm->vmcb->control;
>> @@ -2941,6 +3063,25 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
>>   				  GHCB_MSR_INFO_POS);
>>   		break;
>>   	}
>> +	case GHCB_MSR_PSC_REQ: {
>> +		gfn_t gfn;
>> +		int ret;
>> +		u8 op;
>> +
>> +		gfn = get_ghcb_msr_bits(svm, GHCB_MSR_PSC_GFN_MASK, GHCB_MSR_PSC_GFN_POS);
>> +		op = get_ghcb_msr_bits(svm, GHCB_MSR_PSC_OP_MASK, GHCB_MSR_PSC_OP_POS);
>> +
>> +		ret = __snp_handle_psc(vcpu, op, gfn_to_gpa(gfn), PG_LEVEL_4K);
>> +
>> +		/* If failed to change the state then spec requires to return all F's */
> 
> That doesn't mesh with what I could find:
> 
>    o 0x015 – SNP Page State Change Response
>      ▪ GHCBData[63:32] – Error code
>      ▪ GHCBData[31:12] – Reserved, must be zero
>    Written by the hypervisor in response to a Page State Change request. Any non-
>    zero value for the error code indicates that the page state change was not
>    successful.
> 
> And if "all Fs" is indeed the error code, 'int ret' probably only works by luck
> since the return value is a 64-bit value, where as ret is a 32-bit signed int.
> 
>> +		if (ret)
>> +			ret = -1;
> 
> Uh, this is fubar.   You've created a shadow of 'ret', i.e. the outer ret is likely
> uninitialized.
> 

Ah, let me fix it in next rev.

thanks
