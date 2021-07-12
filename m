Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650A53C602A
	for <lists+linux-efi@lfdr.de>; Mon, 12 Jul 2021 18:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhGLQOs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Jul 2021 12:14:48 -0400
Received: from mail-dm6nam11on2056.outbound.protection.outlook.com ([40.107.223.56]:63456
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229521AbhGLQOr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 12 Jul 2021 12:14:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBBjirCmpCJXVN3JcJpmQW4qKm5lHfoL2Tls7h8rjKCfVFv3nAm4AsL2z25scVUw15kQgjXqvOLujCySCdgIUHwenlud8arMCrdZhXf/Di/cPFhnt1WzuQfr1VfnxUedyM7SHExLA72KdrCxOoLnMsDKwIPT2CfJU3czqQvZNJnHYWtwrn7z+tscnGlOgXbeq5GhxmOsk4yuemBTp0rsr977arZmSe7Lfstw2cVEY6LgNRHhSrJuC+IJDP/Z55cQX3Ffag1AgaztO65hEumlPveJRnqEEq2JaLhQYbAVjDGzZ8QAfpzP35dLu/00qLAP3B2ptZdVs7Zy/6Ar7zzQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjH+t9r5dGq2ez+Y1e3/bFov/C/Hw6PhMsJnM4Y9c00=;
 b=G6o9/4B7MEhWBHJjp78Cp5Qac4sKuUCNpaC6vcCqU8kLZCRq20EBDn4J8QCwYIeWsxrewc9lK0uW8VIo3dJ2gRW0BZRJ5S7r/vDb9G7eiuqBU4F26+j9RcFdFseGJDA1UpldiIsa05pYUXURHxmUJV01MmCU4qHVm/xZV3yFtJT/Z6vjnwLOpBWxclDQK7Q9OhnNlPzu54IVGnMQzI202UI/Kd1kL2RohjK1XB4N0sHaGUmRvFo8XC7eqQTN5h4slmHU27eb9PxRWlccbT2/HQBtEFtZDiofblFn2HSoXD3OaCzu+EjXaEbXufc80OqhCEjiFirniDvjoj0siun7+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjH+t9r5dGq2ez+Y1e3/bFov/C/Hw6PhMsJnM4Y9c00=;
 b=a2oHQqJjxMLuevMtTX5dJh0ADzQygoxzOKRRd0bZSkE6MMhxRoAQ2/6HsqBjTWWVAXEja+SPL8g26BcK5At9DPy4KlnfLn4mWNlXcL7EplHDUgT1KfRDrmPhMcRQ/OEJvNz8UxjHgMO2muA/r0e4roJrGnyg2FTX0PXvayV9Eyo=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2832.namprd12.prod.outlook.com (2603:10b6:805:eb::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Mon, 12 Jul
 2021 16:11:56 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 16:11:56 +0000
Cc:     brijesh.singh@amd.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
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
Subject: Re: [PATCH Part2 RFC v4 10/40] x86/fault: Add support to handle the
 RMP fault for user address
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-11-brijesh.singh@amd.com>
 <3c6b6fc4-05b2-8d18-2eb8-1bd1a965c632@intel.com>
 <2b4accb6-b68e-02d3-6fed-975f90558099@amd.com>
 <a249b101-87d1-2e66-d7d6-af737c045cc3@intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <5592d8ff-e2c3-6474-4a10-96abe1962d6f@amd.com>
Date:   Mon, 12 Jul 2021 11:11:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <a249b101-87d1-2e66-d7d6-af737c045cc3@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0201CA0065.namprd02.prod.outlook.com
 (2603:10b6:803:20::27) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN4PR0201CA0065.namprd02.prod.outlook.com (2603:10b6:803:20::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Mon, 12 Jul 2021 16:11:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e41cf51f-3c88-49e3-985a-08d9454fc538
X-MS-TrafficTypeDiagnostic: SN6PR12MB2832:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB283288A27D9FDF0BC689A5BBE5159@SN6PR12MB2832.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fyX3ABzB8jUPi201kUPyYsah2YYGr1BenWPf+MmyjFVnVMyodN72BTZe95R7pkMtSWKmurvNnT+rT8Z+bzzTrI8i6Ro/kum3fHZGD00GFqYxtMFLVPbiOCm+T4wLoYSq9tp9wgNw/WfvwMFZrwGpub6nffME+iWtNE1JnvyjzFFPrlMEuCjRfjM8L04whQQr4kjNaM00JQpy5N9L949yIwlGsg3H6yKz6pWGQawqy5e9ZUVU5cYbxEmxNc/msW2bPiPTeWWkDCwzh0WQ3pxVhfBoLG2QbN9jadTQL9zXqVF7NamUQujCrEqvMx6uAx7oy20/LxKQj0FJoGhcz0D+/ueqO0Fnccz6AQ8vNzwaVW6NOiDT+m8eM0h9SRjQvViCofW+kYswkTbg3IN1K6amR2DB3y7G+MpvNEbvlv/I1HvUu9RbKOMB1ObfCVu391D0j0AzItqW/uQua7U0IK/ePCfeFzp0B/+QhCN4LxPXFIB317/QdFWpgEMyOM0+BhH1pSIYLCXJCmkZre99cyb0lB5v0Bwn5xoYhZQENTG1HC2ZhpeIyD7vrQlYTOhRqEfYmoGwbIRwHVKQJzIbPF7WzkWp5hGi79BLw/jm9clWSod3OjLTr116766xu2dwK95fNrhhE4NKd8nfch0gHPuK5fqKPOcK9cxiINVU/xARt6s7C4eWU2OIkX996Ox9aLQ5LUkKCVT+Ma5r4qnzstS+maJH9+isZS1EMx66dignZIP7U0LirDlYi4rEmHpyyZMb2/Gt6g9P2SkB1iL7ykEKkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(36756003)(4326008)(2906002)(8936002)(52116002)(5660300002)(8676002)(53546011)(86362001)(6486002)(44832011)(7416002)(31696002)(7406005)(16576012)(26005)(31686004)(2616005)(956004)(186003)(478600001)(66946007)(316002)(83380400001)(66556008)(66476007)(38100700002)(38350700002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUdjekZiMXVQSDE1akJYUXFFVEJCUzQ0cjVvQ3dpaUNhWTVQeGVHWFI5OExw?=
 =?utf-8?B?UkYra0JYYkJyM0JVdUt6RGxxdmluait3bCtJODFnblBGcFJpcDd3RklUWThL?=
 =?utf-8?B?VHhEbWJWd3VZYUdWWW1VM1lPTU9uWWdzajloS2FGRjFCeTBreUtJRms5cEpZ?=
 =?utf-8?B?ZmRWejZ1OEE0eHJjaVlITWJjYmF0Mk9DdGNHNjMwdFlkNC9zbzBHM2R3cUh3?=
 =?utf-8?B?c3luUXg5QUVnVnlUTVgrWisycy8wdDNtWXZuWjh4RzNwY0ZvekxMT2NBcm14?=
 =?utf-8?B?MmExT1ZlWGZLOEUwdUM3dzFRbVNKT09JVThtMGsxOHozZ3VYaFo2MDBqVXdw?=
 =?utf-8?B?UzkwV2RNT2JYMUMyc2Z1TGh3Q3MyN3Z3MDZwU0V2WmFYdHpmc0ZSMEV2SWF2?=
 =?utf-8?B?NHhDMDVxcDJuK2pPb0g5K3J4TWlCY3k5RHdsNnVLV3pOQnl3Y2ZPWGtPaWRE?=
 =?utf-8?B?bm9Oem83YmJlRUVHbnZsZzY5QTFLazYzK0tQeUpVTjdXNytzR0k4aU5EcVMr?=
 =?utf-8?B?YTF2SzFsbGFpeUFkU0lPa0lTZFBBa2owK2MyWUtLdHNBT3dJM1FNMm9MbmNV?=
 =?utf-8?B?RTNvT2l2cHBqR0dSUG9oelpCQ2VLVmdBM0xIcGd0blpRTE96QXJKSzFwSXln?=
 =?utf-8?B?R2svT0hWN1lEYkd4R25SYmI5ejl0UHVvQ2Y2b3FLejBXNnByLzJUWjhROVN6?=
 =?utf-8?B?eTQ3bVlRUDl0Njl5L0liVU5kVGhSdzAxeVZoVGVpMFhYRUpTVXhGOXhzNWQy?=
 =?utf-8?B?YXdnY0Q5S21HNk9GYVBHVlNHR2MyTEovRUJjVVdSeWRtS3B3S003cFdrNTNJ?=
 =?utf-8?B?ZWgyOFBiQ2pmSS9mUWoyRVlvNklZTjNwY1VOVVFSZm9pZkVqc05vT0dOb3lu?=
 =?utf-8?B?SVdaSzRKaEllWU1pM29BN0NjeUZZR01RRitWUnhVNXJrbHRURG14MnZVOEtM?=
 =?utf-8?B?bElvOTBuajIxTW5rSURuay9aNEdGUFQvckJ5RDUvc281a0l4VkZBSHBud0tu?=
 =?utf-8?B?VVF1MWdMdVZMcmU5c0Eweno0ai9YbjY0ZGJFaGJLVFdhc3oxN2ZrbGN6UC9M?=
 =?utf-8?B?K3FRcjlaUUJjWERnOFdTQTUxY01nRVJXK3dYTmpmaFlGR0tvVU5JLzhKNVow?=
 =?utf-8?B?b01JUWFGMUVoZ0Y3TUc5cmJ0TmptMWNhR242VVhDUFBla2h4MEZUR3FjdnFl?=
 =?utf-8?B?QzREQkNTTUo0M1FmdE9pWmJ5OXRlcnNDWkVYYWZ0YzdKZFpvVno1bVF4WGs4?=
 =?utf-8?B?Mk45THVZUHo0eHlaWUJ1eWJjTCttSHowTFlNdGcwWElLbmVsV2NCWnFaTzdR?=
 =?utf-8?B?NFdpSW9ieFRqV1EybEZEbXpLUzYvQ2FPcFZidDNIbGxCM3A2cmI5a2NuV0Jv?=
 =?utf-8?B?RVBxYzc1TzJrbTVjbHBZU3NWLzJrYWJGb1BmaCtDNER5aWw1T3BpNENtd3Vi?=
 =?utf-8?B?a3RRYjlHOXNxR05aUjN3bnRyVTZGbWRYZmtvdFdWTG5FMG5BNloxOHNKQnR6?=
 =?utf-8?B?Wi8yMkhVMFJwWW5Fc3ZaSkRoNFZkTjFLVExDbStmK1h1N0tGNlBlQ1B6V3hS?=
 =?utf-8?B?YjBjSDlmWGFJaVlsT3BPNWdZemhpLytoR3o5c21ibG9OcFdCYkZNZU10d0dO?=
 =?utf-8?B?eWg3SEdpK1VPZkZ4RENFbzZxS0NoQW5TL3ZhQ1hiVkJmM01vc2J6UG4xdFp4?=
 =?utf-8?B?aVZqR3o1SmRyWWRtajMwVHdEdGt6bWpneVdmeUxJbFppcmpaTGp3bnQzRkFC?=
 =?utf-8?Q?SeZ1TwOTTM2KLgO8QngkHopSAQOnTIR5/x1ocYh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41cf51f-3c88-49e3-985a-08d9454fc538
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 16:11:56.5418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmBQGVfdthSPCUJKuApvkfYFauUfNjy6SVjAfhVppFjZYsgrAgP6uwb+8ldXBWfWER+yrxNfNv8apnQIClOG4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2832
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/12/21 11:00 AM, Dave Hansen wrote:
> On 7/12/21 8:43 AM, Brijesh Singh wrote:
>>>> +    /*
>>>> +     * The backing page level is higher than the RMP page level,
>>>> request
>>>> +     * to split the page.
>>>> +     */
>>>> +    if (level > rmp_level)
>>>> +        return RMP_FAULT_PAGE_SPLIT;
>>>
>>> This can theoretically trigger on a hugetlbfs page.  Right?
>>
>> Yes, theoretically.
>>
>> In the current implementation, the VMM is enlightened to not use the
>> hugetlbfs for backing page when creating the SEV-SNP guests.
> 
> "The VMM"?

I was meaning a userspace qemu.

> 
> We try to write kernel code so that it "works" and doesn't do unexpected
> things with whatever userspace might throw at it.  This seems to be
> written with an assumption that no VMM will ever use hugetlbfs with SEV-SNP.
> 
> That worries me.  Not only because someone is sure to try it, but it's
> the kind of assumption that an attacker or a fuzzer might try.
> 
> Could you please test this kernel code in practice with hugetblfs?

Yes, I will make sure that hugetlbfs path is tested in non-RFC version.


> 
>>> I also suspect you can just set VM_FAULT_SIGBUS and let the do_sigbus()
>>> call later on in the function do its work.
>>>>    +static int handle_split_page_fault(struct vm_fault *vmf)
>>>> +{
>>>> +    if (!IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
>>>> +        return VM_FAULT_SIGBUS;
>>>> +
>>>> +    __split_huge_pmd(vmf->vma, vmf->pmd, vmf->address, false, NULL);
>>>> +    return 0;
>>>> +}
>>>
>>> What will this do when you hand it a hugetlbfs page?
>>
>> VMM is updated to not use the hugetlbfs when creating SEV-SNP guests.
>> So, we should not run into it.
> 
> Please fix this code to handle hugetlbfs along with any other non-THP
> source of level>0 mappings.  DAX comes to mind.  "Handle" can mean
> rejecting these.  You don't have to find some way to split them and make
> the VM work, just fail safely, ideally as early as possible.
> 
> To me, this is a fundamental requirement before this code can be accepted.

Understood, if userspace decided to use the hugetlbfs backing pages then 
I believe earliest we can detect is when we go about adding the pages in 
the RMP table. I'll add a check, and fail the page state change.

-Brijesh
