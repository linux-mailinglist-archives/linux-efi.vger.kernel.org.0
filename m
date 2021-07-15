Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF503CACBC
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jul 2021 21:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238667AbhGOTne (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Jul 2021 15:43:34 -0400
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com ([40.107.223.54]:60802
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245539AbhGOTlb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 15 Jul 2021 15:41:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuP69Ru45dhIt7jtyMD//Qy2SbtXoVVj2z4bnPY+wMcZmJnitaLVJAFB5SVTgdUqyJ33K2tYM1L1sD/kYhPERdZhvvE88u/D2BFvL+x2QykjnHbObKhaTq5Jk6NOx4tLOgqlmavPQTJNbRAQ64jRpUSCTb2Qkv8EqcGXfBzMHDlWTlckD6a4eBFS8aYAK8Bv3NaJaRNrzqW693nI2VULMrmf92JeziwkyxgW+YLbIe/b2/1pGOFZ8LKL7lBsnnQGMrB6pz6PMB1XxF8u0Ibvv081MDsEEy+YmWwxxKE1BynIJWE4RI9deb7TVfGSKjsJgbjUKK/BMnhl3sp7bmeU+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVZlJd1oJufLuBcXmBludLFPkB5cjQA1jHkU3TciHWQ=;
 b=mz3SwE8sRRM+pA6xLUVY+FhYyPIeheW1g9eNyegjcjtN+gdg4aSh96DveTXSSPGJPSfgEFm8coOBXp/zTQF6OKcgNBSdlEkxORQ1XFt85lr9UpvrgRR3tO0FpGY26IX4pxAQNGSfCfn2mAHkUMLCwFPt1L3vB240IlGhzksJ24TJrVuzgRuelP/V0E7kTpceNcWrDbRzeaQhakopVxObALaEHiXEWt1PK/SpE8cf6YV9w7KnwsnExtgHnT97SRLc114BWpQAs6k3yKC+pUtHIR8PJniu6PfoDXUgPFQBeBmrURCuS2+WKUPlZtuGNSimnXSyD1jRh6UczB05OCH6DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVZlJd1oJufLuBcXmBludLFPkB5cjQA1jHkU3TciHWQ=;
 b=wjaP5AlHTQl4TU9+ua2EqityEW1MTTPU/+z+uNk43bLsYRuxe83ePXO+OOOWuj9Pg6CGTx3s1gJdeAWii7X1k0hKI74fgKe3pK9351pJxYo4QjT5htAt1pxjP6X2qEbxivOgZCeUBoN8jLeiXTO2fIgk7B7u9kVQmoq4Hy2GsxQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2510.namprd12.prod.outlook.com (2603:10b6:802:28::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Thu, 15 Jul
 2021 19:38:33 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 19:38:33 +0000
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
Subject: Re: [PATCH Part2 RFC v4 07/40] x86/sev: Split the physmap when adding
 the page in RMP table
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-8-brijesh.singh@amd.com> <YO9kP1v0TAFXISHD@google.com>
 <d486a008-8340-66b0-9667-11c8a50974e4@amd.com> <YPB1n0+G+0EoyEvE@google.com>
 <41f83ddf-a8a5-daf3-dc77-15fc164f77c6@amd.com> <YPCA0A+Z3RKfdsa3@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <8da808d6-162f-bbaf-fa15-683f8636694f@amd.com>
Date:   Thu, 15 Jul 2021 14:38:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPCA0A+Z3RKfdsa3@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0021.prod.exchangelabs.com (2603:10b6:805:b6::34)
 To SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN6PR01CA0021.prod.exchangelabs.com (2603:10b6:805:b6::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 19:38:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a12b5b72-de1e-423b-3690-08d947c821c4
X-MS-TrafficTypeDiagnostic: SN1PR12MB2510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2510D0CC3C7D667B3AE40191E5129@SN1PR12MB2510.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y7D+I2ZpGmnjFEOIwu64DtPz/qVuteyNrsroGIPo84fX3hB7xU/awf6ckqXzLW35x1m10gneaMySZPtpYuIfFvxgppkEjODWsochMVTaotiU0wl0ZpE+n/FsU8eSjJd8DT8Hc3qbHyzhAGc7mHpHt0Ta2w9gD+4yLEtMDm6gPBlYUVFmLGQ9qd4ntfrB4iBS5jQhGvc/tY+gGl291E8OLAl4DTGAvtwueFetaxpAfZacZYNHlipRSvAj57DwgHPa5VlLfDmAxavVuJq2I0uNIljebSViaqJcDzgu9/hgXRD0ehI1+4ZCpoFVQg1ei5ub8GPusoqe/8+J6nXeJVRHK3wvYoRIIwNzJXOvO7gElnBWIXZNJmKNz3DR0yA4o2E1oPj4jxBJIwiOrCTaISQoCoNfgxH6dpclTnRcaOrQeBYeZFc0uFD2qmfbF11iU0sB31KAgQMbICaBoMHJ7F24ky0Cu77M1+iE49pJxsfeYV3xPOVFfqiqLwSZUcW+s9ao2W+8y06T87eWJ2J/wFoQIOgPDjshJJZT7+jaHtMCZpZGyhg92o1A2ttfSE2gq/wxrRryaFPd4wZUvKMNPrfp/QNu0RDkHkSC32/iM9kun8iaojfJqWJGVX9cqWz9tW+ohaFb4MqRVYcwwD37Nr5ydBbhofrQFaDgrAvv2+NwSSwjZ8EjLxQjfO1/LnZL01J5ao9EQtTbxm3UGmk7yt4G7CxTh5DT+plcYuijEQrbzbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(316002)(16576012)(4326008)(6916009)(6486002)(53546011)(5660300002)(31696002)(66556008)(66946007)(66476007)(36756003)(54906003)(86362001)(83380400001)(8936002)(8676002)(26005)(2616005)(956004)(44832011)(186003)(52116002)(478600001)(2906002)(7416002)(7406005)(38350700002)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1dkbHdyb1hWSEpkTm5ZSnNaWjdqNHB5emV3bWJZMWFpNDRlaGY4M0YvY0Q5?=
 =?utf-8?B?dVFsVXFJOXJBVGx1SGp5VVVlMFc3ZXcrTDlHNlVCaEpFaDRxR2xrTEYyMCtH?=
 =?utf-8?B?UTcweGpRaHZnbVlkd1lGRmhHbG9HaC9jZlJiQkhuODIyWDFyR1N2L2dIZEhx?=
 =?utf-8?B?Y09KYm5SbHdYMmxJdHIybnV5aDAxbDYxMm1mM0pBN1M4VFR3MFI5R3JaQWdK?=
 =?utf-8?B?SE5Mai9GTUEvb3UybmhmU0tkVWkwbC9rMndDeE85aUZRVUsvcU9RVjlIWGRN?=
 =?utf-8?B?Yk5PMHRSWHA4TFY2RjRCciticlRhZUFJMzYxYVdJanlhcW1xQlNnWklkS2NX?=
 =?utf-8?B?a3NLVm85VFExM3NXZlpVak1XbnZvcG1TaHp4SjhWSGxiMWFrVEJyd241REpR?=
 =?utf-8?B?cEU3RkdlZXpjR0F2K2VhemJQYVJxUWllWEpYTFdsak52QjVONmtpUFRrbHRo?=
 =?utf-8?B?dXdYQTRzaUNTNjlmN0hVSXFzL0g3Nmlvd3Nlb1RMbVQvZGFDUXVVNDNpNlBi?=
 =?utf-8?B?M3l4aXlpRDRrOVBIODZZNFc2UnkxMk1aOVBPSWFLcUoxK0ZhSGFiV1YxVjBj?=
 =?utf-8?B?Q3V0aVVoakhLUWZPMDVSazh3WGZLeUNTSExiL2Q1RXZ3b0plcm9QRG9iaDJt?=
 =?utf-8?B?bkVqUHdJdkRmR2lTNzhwYy90cmpNazNML0JaRDBGcExsRTdMUGQ2a3d6ZHVt?=
 =?utf-8?B?dHdXSHRYSGNrbmlPenJMVnJPTnNrajNpaHVpa2xhRVJuc092enIxcHBmMDBn?=
 =?utf-8?B?NTdoMlNlbEtkZ3lFSnRxOWZuNHM4dWVYMElNL2dYbnJtN20xcmNZWC9TWE85?=
 =?utf-8?B?OFZSc1RKSG9UY0x3bWlSZDNqd2Fia0VTT3hWTk1rcms3MmZ6UnBBRDVZUkts?=
 =?utf-8?B?MWJwcEdpN1RPakVjMzRDcTZ5dlBUbDRUSGlMcVFaVGhHSmxaUHdGb0JzeDZF?=
 =?utf-8?B?MTNwbGFIa1h0aUh0TnRTMXc0ZCt2SEw2S3o3bWZVVWVWZVVNNkt5UDZMWGRB?=
 =?utf-8?B?QXBHVC95WmhNUFAvdWcrQkI0OHppZU8zbW5oRHNMTnBPcm50ek1maTRWeG83?=
 =?utf-8?B?VERNT1owdVhGMEF5cmVYMnRPY2h0dmpPSHRlU0JRbTJYNHZvZDBVdWxid1dI?=
 =?utf-8?B?L0VVdHh1NGNLUlY2TWRmS0haRUo1cG5rekxLY205ZlRrdW1WbkJOWDdtYWlG?=
 =?utf-8?B?OXN1YTQ0YmgzOTRvdVJ2eUtUVUlneVdBWXNyL0lrRUx2Und6VG1RdkhteHRH?=
 =?utf-8?B?T1AvU3htMDlyRmtOS1hWcnBXeElZcU0xb3d1MllFRm5aTG5UQjV0dUJ3TFJQ?=
 =?utf-8?B?cktteHhMakRFMU85Wll6QldlcmpKOXZDOHN1eDhmSGZEQWZiQTNPVnBVSTVM?=
 =?utf-8?B?c29GUlBISUFvSE5SVFVNMkxYUldBYWFkK2VqSm1pOGlCM1pnaWNXSEhDbTd6?=
 =?utf-8?B?R0pCMFFYbnlweVhNdGVsb2t0TExyc1F5Q0FTTUdaNVdCa0t4N1RHNWZqU3ZJ?=
 =?utf-8?B?S0M5Y1dnUTExa0t2MnFpbDBYZWNsbzNScDhyeEgvd0lkeFpWRFdUWk1SVVZ4?=
 =?utf-8?B?ZjRPZTEvSEZ0MTlMMlg1Q2d4Rm1raktEQnh4UXY0VlJCeTFHam1yaFQ3dTl2?=
 =?utf-8?B?dmJoUkZON1p0WUZiN1lNb29aejlCaGVoQ282MGJjT2tZRi95MUJPelM1THM2?=
 =?utf-8?B?eWZDc2Y4UXV2azEvMWp4NHc0ZkMyeHo0SDZBK2FWemEvVStSeWJTbW9wRkZ6?=
 =?utf-8?Q?JoQ6nAGdNc9V+ECYQLQIHC9C7DfzFx5U/oGxdsI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12b5b72-de1e-423b-3690-08d947c821c4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 19:38:33.7383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZnMpKrAI72s2Ensn1fylPyxtAaU9S+2yo+RErgc0vhF1aAgsiREtlAS6GVXgR1duUn025XD7GIDKXqG41na4Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2510
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/15/21 1:39 PM, Sean Christopherson wrote:
> On Thu, Jul 15, 2021, Brijesh Singh wrote:
>> The memfd_secrets uses the set_direct_map_{invalid,default}_noflush() and it
>> is designed to remove/add the present bit in the direct map. We can't use
>> them, because in our case the page may get accessed by the KVM (e.g
>> kvm_guest_write, kvm_guest_map etc).
> 
> But KVM should never access a guest private page, i.e. the direct map should
> always be restored to PRESENT before KVM attempts to access the page.
> 

Yes, KVM should *never* access the guest private pages. So, we could 
potentially enhance the RMPUPDATE() to check for the assigned and act 
accordingly.

Are you thinking something along the line of this:

int rmpupdate(struct page *page, struct rmpupdate *val)
{
	...
	
	/*
	 * If page is getting assigned in the RMP entry then unmap
	 * it from the direct map before its added in the RMP table.
	 */
	if (val.assigned)
		set_direct_map_invalid_noflush(page_to_virt(page), 1);

	...

	/*
	 * If the page is getting unassigned then restore the mapping
	 * in the direct map after its removed from the RMP table.
	 */
	if (!val.assigned)
		set_direct_map_default_noflush(page_to_virt(page), 1);
	
	...
}

thanks
