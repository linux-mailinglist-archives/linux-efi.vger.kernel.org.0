Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBFB3CD683
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jul 2021 16:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239968AbhGSNnl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Jul 2021 09:43:41 -0400
Received: from mail-mw2nam12on2089.outbound.protection.outlook.com ([40.107.244.89]:2113
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231789AbhGSNnk (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 19 Jul 2021 09:43:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqPHyHIiddxKlYth22ZMxGC8bIk3pcNB8wxttj1ALLYPMpZxVCNvH0aWnt1N1KXpRH8CeN1QiSWGkGnoc72e2szg1vJm/PQRUFG56pZ2bKvUv31hKOJa26epm+50RwutdhPI/UjUF4nrYdOorgD6BiicidbApNizPVyzMNKHYKP2Ny6dhHHQk4VO+fzKNvNFmom9XWDP2IC/T+5O2/YiwBPmhMF+2jjCwPoeQVs+Z+aFqTf3E6kxfiuj8B4Bo/0WFf2TK6uiBUsVPV9KQz0qgwLcJGR7z8YjdP1bnLLiAOMu+viVWHkZ5V8I/1DfGU+jy754Y70C85J8zGtoXzKt2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GKURgwHZLy/+xuETOoszdBBmBI1n4sbyuDE24jxkm0=;
 b=XQpguF2BAJ1QRuhmzXM9MXfU0zbF8TEB0c7R5COhsy+4+YoCSbXRxEVT0rbdwc7FC+LdUNfm+G5aA7xCB6Cx1bPtb9PCsvv958PPoBKTAtAe9k1xiYXS5UOr407CuInTpNcPdWG8JgMcTQf1DuFA4BpCtIGVYsZ8Z/+d8buZB55VhRXjaPw0pRC+osB380wLjBdkpkVkT+cCAaMZsuJLGNjp9sMnQIbQqXf28Mymt8OLc3aV8ymUGH6i4Y7Pj8K118/QmHwmfY11ZiBPuC6Y6v/FoHpo16xZivBxKgGOCuQjPlqpupuZJ9iPG6qAsO6p1FqtzV3sHxSeUYoxOBoZXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GKURgwHZLy/+xuETOoszdBBmBI1n4sbyuDE24jxkm0=;
 b=mL6rrmVg0l1SQrFUC3IenluUYdMb8kjkLTLlPVsVx4/j+Mum+u2sJfCYeERhOsF282V286bpWbp8nm68Ku0QWDGS5idq2rDI6bLBoDOgZUIuxAy91XKFSBWhRaKTiZOpTQWSn4jWuPfsqGzdRb3H5/YiP5A9r5zgBy9Pkacjp54=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Mon, 19 Jul
 2021 14:24:18 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 14:24:18 +0000
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
Subject: Re: [PATCH Part2 RFC v4 34/40] KVM: SVM: Add support to handle Page
 State Change VMGEXIT
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-35-brijesh.singh@amd.com> <YPH2qRkkG6m0FT2X@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <54f916af-1d10-4a8e-1e14-cd261d407dd2@amd.com>
Date:   Mon, 19 Jul 2021 09:24:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPH2qRkkG6m0FT2X@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0801CA0003.namprd08.prod.outlook.com
 (2603:10b6:803:29::13) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN4PR0801CA0003.namprd08.prod.outlook.com (2603:10b6:803:29::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 14:24:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 715e5e0c-ae4c-4a34-b2a4-08d94ac0e473
X-MS-TrafficTypeDiagnostic: SA0PR12MB4592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4592B12177F676540CFCA995E5E19@SA0PR12MB4592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1snQXtS4NjZluEU7Vku0RCtK1GJZmPoCjr66FSIGsKBFIUht7C0HCicVFlDKtC6U2xdZFkDI5lmdEyIWonQgV9edvWb4YtpTohSsng4by6N2T4eCKorV9BhGCs8DvuZW0NL0mH+m0p8qVHAvjxKZRNiJnHj2n9lnWYe5vkYtfhBufA33hTTsPv3UwXEihfrtyv81pqcsyObqLSV1XhhrhnmBLOj6e6gt5F659IdtxvyhclSt4ZrlwgdZuphPMLHcub9K3u7F1YSzcCqpyS+1x6eP57aui0fQSBDsw4YVfPN2lcIp/RlC9HtNgn4jyLyTJWAqHjerPWd9gYeCkqlJAWcxzEh7PvuDF8CmjzaOfm6beE3UR1eEXcMoqreE5n3s4iOmKI4rH0YmusJwrGwrd6zhTUz4SD8a4LRXe5piqZOxIKw6wtze4e6b7Mm/m7Y6VXIqr5LwDyyJEpMUU+AUufPQQW9SisGpzwjZYsTz/LsHyKh1PzvCxKJFNhaoeESXJTsOiYCqRd0go4Eg+rQEQT/Gj2K8FbcDqaMqKlCdjK2Igh6mfan3M6Sd6qOP/XNtbNAXAB7NlnkxGCSf+B/T7alJO+ivBWGvgSYEbIqLAqWChA2PYEM/E9jfiDNeimU/R+CdiC1wIX+44hDStKtC1g/i5NCmwTtcTeIDhZykaHYJ6d+CFR8/N9SCW/iJ8sEI/llt6XgvWm3FCKaZhY41iTHeIxBxQHa77+02IBsIPFalVJH7fznxGWoSlRwrSb9or3/pGMdEuimKBxZsPD9tAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(8936002)(6486002)(8676002)(38350700002)(38100700002)(956004)(66556008)(66946007)(5660300002)(66476007)(2906002)(44832011)(31686004)(2616005)(31696002)(478600001)(36756003)(26005)(6916009)(16576012)(316002)(4326008)(54906003)(83380400001)(53546011)(186003)(52116002)(86362001)(7406005)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXNVdzYrMEk1aU0vVHk1bjZKWUxMMEprOUdQLzlzUDRldDFKMG5uNUEzckhv?=
 =?utf-8?B?TGlyZFhHcS9ubytEUitFdnpXbFNhS1hqTFJqWXdFM3l0VjN3eUVWRFZYVFBs?=
 =?utf-8?B?cEcxTDR6Q3QxVlNuaXJVOWIvZVdZc3pVVTF0MVErZHJXNFR5emhZV1JzL1RT?=
 =?utf-8?B?RElKTXIrdnZIdlhKMUVnbFJjK3VWRXFzUWNXbGxxQkZwbk5UcGwrZk83U2tG?=
 =?utf-8?B?WldiVFZhVW93M0RCK0JZKy9qc1publhJc3dLMzltODF0cy8ycTVydDgxcmx2?=
 =?utf-8?B?SmZqbTJkUks5cFIzNzNzK09oOHRWVmZ5ajVwTnVlc200OW9La283a1lnNEh1?=
 =?utf-8?B?VUdCbnRXOGloRDZldTBRREdQb2RidXlrME1HNGlvdDhtL2xZd05ON293K1VY?=
 =?utf-8?B?UnBoZm0rODdnb2tOQ1J1Ty9ZVFdWa0p1eDl4QXlIZ3RVL3NyUUpOREszQ3Yw?=
 =?utf-8?B?QnNWRnFMcnB0d3VOMWN2cFZWblhGbnJGckJqZ0h2cXlJdkpDSkFJaGp4V3hr?=
 =?utf-8?B?TTREazdpZU5xaHRsMkZVa0xGR3FrT0Q4RStSb09UaVpkVTdmWG5aNWswVDNJ?=
 =?utf-8?B?ZUt5blIyTCt5Uzd2ZDJ4OHJwL1gzRnFzbnl1R0Y5QVpZOVBpK2ZWZ2FhV2ky?=
 =?utf-8?B?eHkxMnVvTnk4Mk5IOTQyNTZFRHBkREx2Ui9LZ3BRMEdMamZxWXY4TC8yblJI?=
 =?utf-8?B?aGw4bFJRME0wVmswVndxUHZYYWRvYWVTdkVsZGFOR0U1Q3N5L0dJUEZNK3l5?=
 =?utf-8?B?R1VrWmkvS3BVVHRkWkNuRjJCeUo0M1lMQlRVa2VVR0FLalpiUWNFUE15ai9N?=
 =?utf-8?B?S0VTM29FUSt5RnZXSXBtYkI4WjhBOHczdFQ5Z21Kckhkcm9XMGdyYVdzc1k5?=
 =?utf-8?B?dGxVQ05rQ045bXhJRkczRFh5L3owaG8yaVdzZHp4MGZPTEVLNk5TN3lGdEw4?=
 =?utf-8?B?VkxzMTIwczlqdXN4eWNEYXZ6eEVzcmdaUWtRbUxxcjhsS3VLai9xWE85Zzly?=
 =?utf-8?B?b1JjQUJ6SzNjckZ4aTE3SG82djJHNTBTbEgvQzJ0RmdyL2VnUy9teGdVUmlY?=
 =?utf-8?B?YzRVVU9TdHMrZGJKT3orOEZFS1UyS2d0akhSZ3E2enA4bFJkQWhtNjRjR1Qw?=
 =?utf-8?B?NW40ZXNHckZVWVArZldLWm1wTFQzcHYydHRMeWlBdW90WVBnSmYvQmdVeFpH?=
 =?utf-8?B?clVxWGY2RkswcE5EQzIrM25pdmFiZXlId1RzMmlxSGNEMll0UTNTYzMxSy96?=
 =?utf-8?B?VnhxalMyeFBFM1NJTWN1dVVvbzJmTGZwUVdENEY3NXlDSXBaYjd5TXA0N0dO?=
 =?utf-8?B?bkx2QlA3VkFyZHZIRWR3YlZjTDYxM3FZNW5VTldyM3pNSnd3eHQ0c0lhOFhr?=
 =?utf-8?B?bXR0SjJCeW1sV3NBRjRTYjFJWTd0Rit0ZFJiVWlGLzhGQWltZjRBK3FQdnVq?=
 =?utf-8?B?Q2hPTVlra0h6NTZSeEc5U000bWppMVlKWUlEdFg5WnlPdTQzalBrTkFhWkQz?=
 =?utf-8?B?VW5RVWYrek5wTjczUHcwMU44OHdGZkJWc2R2WVNaVEFtQy9CWTVPRmx2cDNY?=
 =?utf-8?B?MTBZNEdxY3VDQ0E0azlyNXAwVmM4QWV0UXFYTFVwQXloK0x4Z1NpeWcvbVpW?=
 =?utf-8?B?Y1dFWjJYRHQ5bE5aYlBLR2xyTWJsZ0NYSzlhTDBzZmVIUE5XOWYrUDRaL3V3?=
 =?utf-8?B?U21oRTRBOFFBOW1HNTJqYlNlblk2T2x3Z3djUUJMc0xBSmdEUHlldlpkamhi?=
 =?utf-8?Q?+PkUGv2ihQbwK7rVCjrB0beIA4f2bPPWhKFUgpI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 715e5e0c-ae4c-4a34-b2a4-08d94ac0e473
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 14:24:17.9997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcBxFMluTgAXFeoe+pyLR9zsheARIare/i/jnldP1Wk2VVdwZWxJRhqM8cTDtmdcnsGmlfbHmXVXyXuLkLTwoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/16/21 4:14 PM, Sean Christopherson wrote:
> On Wed, Jul 07, 2021, Brijesh Singh wrote:
>> +static unsigned long snp_handle_psc(struct vcpu_svm *svm, struct ghcb *ghcb)
>> +{
>> +	struct kvm_vcpu *vcpu = &svm->vcpu;
>> +	int level, op, rc = PSC_UNDEF_ERR;
>> +	struct snp_psc_desc *info;
>> +	struct psc_entry *entry;
>> +	gpa_t gpa;
>> +
>> +	if (!sev_snp_guest(vcpu->kvm))
>> +		goto out;
>> +
>> +	if (!setup_vmgexit_scratch(svm, true, sizeof(ghcb->save.sw_scratch))) {
>> +		pr_err("vmgexit: scratch area is not setup.\n");
>> +		rc = PSC_INVALID_HDR;
>> +		goto out;
>> +	}
>> +
>> +	info = (struct snp_psc_desc *)svm->ghcb_sa;
>> +	entry = &info->entries[info->hdr.cur_entry];
> 
> Grabbing "entry" here is unnecessary and confusing.

Noted.

> 
>> +
>> +	if ((info->hdr.cur_entry >= VMGEXIT_PSC_MAX_ENTRY) ||
>> +	    (info->hdr.end_entry >= VMGEXIT_PSC_MAX_ENTRY) ||
>> +	    (info->hdr.cur_entry > info->hdr.end_entry)) {
> 
> There's a TOCTOU bug here if the guest uses the GHCB instead of a scratch area.
> If the guest uses the scratch area, then KVM makes a full copy into kernel memory.
> But if the guest uses the GHCB, then KVM maps the GHCB into kernel address space
> but doesn't make a full copy, i.e. the guest can modify the data while it's being
> processed by KVM.
> 
Sure, I can make a full copy of the page-state change buffer.


> IIRC, Peter and I discussed the sketchiness of the GHCB mapping offline a few
> times, but determined that there were no existing SEV-ES bugs because the guest
> could only submarine its own emulation request.  But here, it could coerce KVM
> into running off the end of a buffer.
> 
> I think you can get away with capturing cur_entry/end_entry locally, though
> copying the GHCB would be more robust.  That would also make the code a bit
> prettier, e.g.
> 
> 	cur = info->hdr.cur_entry;
> 	end = info->hdr.end_entry;
> 
>> +		rc = PSC_INVALID_ENTRY;
>> +		goto out;
>> +	}
>> +
>> +	while (info->hdr.cur_entry <= info->hdr.end_entry) {
> 
> Make this a for loop?

Sure, I can use the for loop. IIRC, in previous review feedbacks I got 
the feeling that while() was preferred in the part1 so I used the 
similar approach here.

> 
> 	for ( ; cur_entry < end_entry; cur_entry++)
> 
>> +		entry = &info->entries[info->hdr.cur_entry];
> 
> Does this need array_index_nospec() treatment?
> 

I don't think so.

thanks
