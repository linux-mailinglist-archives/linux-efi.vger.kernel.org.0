Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19BC3C1599
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jul 2021 17:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhGHPEy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Jul 2021 11:04:54 -0400
Received: from mail-mw2nam08on2076.outbound.protection.outlook.com ([40.107.101.76]:31809
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231708AbhGHPEx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 8 Jul 2021 11:04:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U82LR4d5BK5DyhhB2IelzTUB+5HQ2B8WI18kRf54f97gUWhdvkpKpF0P9OZC7+hsuBG70EnXk9XtjZ2HDKcOIIh3UkBUQhO3DQJr2dyaW2fdSrb1d2gauZl8/Ik/6vTdjCeQwiID2yy9G9qEIjH1zsnQXxXIvyvYzNkIy1sl5eyMBC6Om7WhCCbxeiDq5B8baSIonL9oAYaZrG5p+SERQo2iVO+YxxMk4EeWikKOB8HG1sSe132cGqCjwg8gdbnfLGVDqCKRk8L2saMn+W80/AXf0CM0wFIDZpWHR7tydXK/QCw9YaMjlJkkD6S3iIKjLPvqUuL4+oYUI/d57lB70A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMAXVBYMdEBmB6tRHJbSAjDzuqyy1kEtEiuWSb9ZoMI=;
 b=iZ5IFYOqD6CkG3oN8OaJj24ivH1E4ZHLGwBk2f2yzcg1XTjQpVuuMihdGkIjFVujIM5ISvACWgspq8q97VHtOVPh1aoHojBDrU++ahaMKmWId5+8JtEEs9/Jr+OVR76WmbJcwyUn15uGuqkdDz/j1qCbFwotguC7wcXw1Gm9NmWrvE82hSq7JSABLcv+vl+u/xDiVHJdUqmxv9gS4OvxqtEgRY6Xi5js80wLls9M8SQTuuOjXr3yostSKTa1bJBoMd9DOuDHeHVjmKGZjpxBaETznTNl1GBGbQwi+QdCpsHtO8zxxY0tVuOSPRRuAUprMyix2e/+/WmM+/eo5H6Lew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMAXVBYMdEBmB6tRHJbSAjDzuqyy1kEtEiuWSb9ZoMI=;
 b=r3Imie368jRUPK+L5MnGTphLVulRaTjhmmHxLQ2yJiT2QdvBsV428ib1cnYkyNy3temRHu55pXkva2+05URs9v0QcgJcwtVRv5JfLXrxEBoEiMCXR9NlSJ0tgJ+yu16PWQa8I2Ta4BAf/CUKpGBJZmy73YfYLbkJ320sYHBOo1s=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Thu, 8 Jul
 2021 15:02:08 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4308.022; Thu, 8 Jul 2021
 15:02:08 +0000
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
Subject: Re: [PATCH Part2 RFC v4 09/40] x86/fault: Add support to dump RMP
 entry on fault
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-10-brijesh.singh@amd.com>
 <cb9e3890-9642-f254-2fe7-30621e686844@intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <0d19eb84-f2b7-aa24-2fe9-19035b49fbd6@amd.com>
Date:   Thu, 8 Jul 2021 10:02:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <cb9e3890-9642-f254-2fe7-30621e686844@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::19) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SA9P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21 via Frontend Transport; Thu, 8 Jul 2021 15:02:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8e847d5-d7b5-424c-17fb-08d942215afd
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB455779163AA4BCEE6409C994E5199@SA0PR12MB4557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9bfBF3q9N3YRfwlTV9Wkgn/vs3h+07cO0N5tSXSui9IB5DKIzb7RS+N5Dc/C9zZrCuL2f3zcA4dWb1Qfmy22MWbMfM2NuFcLKwTTp2VeskptO9Q0TRvUP5Pd0Cz4O/w4gZhnxGU+0zR0WV1JMP09PFhwDAkYT39nXIN9zuj49G5xqj1Iwh8MC0sAIkcvKdqzrHzO3205+nRoamV38Hz3I0+f1iRJPl+FiKNUdkREYNkjPcCfi/ebceXV1QNf91Cxm+7aBL3xL8fqNkMkZkRDBYPvDpDprSjpOGaPMWb50C28962jvb1xIKJSU07YVPjjO/FKxx80CszHI2D+l/485BJWCMC4J0zlQZcsmFBqzD1+TSZL103gPjdiGqqBvqsLXAh3UrnRH8Ml/tP1LIcbUEfDuqvg4DqA7cVcQOPaMUPsPeOcOU36yGSCx3WP8wYXtqUe5eDSd1XRSpyC9LVZtOC12X5544vV0NAvkcoYey2JhaTFmZa4YBfK5PGkI1TW2mCwTGVlFWaeKAspEg5ceHCw3QMUwuvVvHTFT1uPeQEQVcbNeTtWTtCHDimMMV7K7udKmOMQBTqNjI7RaKvxibA6NW6XVPvwGSHsmrS0YubMx2G1CnUcMds336BS9YlTjfAIRgryuDpQdtOIhfzMYBVR1lRK7nGKOtQQQrWYt7e4PpfrPXK2xJE0CbMGbwxM0YI9N/5mncNJEa4LPCqQveNr7JNdVvFdTtpvcJ9fVtmQd+ZWh8ZLehPjy0UimmKOkdHOds7/bHKMxzyhZ6Qybqs8Fqg6vdFrSejnmBSk9EE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(31696002)(8676002)(2906002)(7406005)(7416002)(66476007)(8936002)(956004)(44832011)(53546011)(26005)(66556008)(52116002)(2616005)(36756003)(186003)(6486002)(83380400001)(16576012)(86362001)(54906003)(5660300002)(4326008)(31686004)(316002)(66946007)(478600001)(38100700002)(38350700002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWZnTTZaS2ViZ1I3NFIyKzlwa1g0YWZyd3BjLzRnVWFsVjlLNVdWOURiMVhK?=
 =?utf-8?B?M0ZXTVc3cGZMNFRtRWxET1BkRU1ZZ091NXFNenVOTVA1QmNCYWhPcUdCTCtN?=
 =?utf-8?B?N0lWNnYxZzRrZWVLYzRDUzRSckxyaE5KTWh4QnBQZlJNbG9aTk1QczcyRy9t?=
 =?utf-8?B?OGNXYmF3V1Rnc0Y0d3RLQTFkQXlFZVVPOEliaHFUNE41L1NRM0wzekVRYlAz?=
 =?utf-8?B?bHhYTUU1NlkxRkJtY05FYUZYcVA5TjNvTEpFNHovejZCbFg5c0ZRa3hlcUJu?=
 =?utf-8?B?VjN6ZVZoeFJMR3RqWXZacldidFhhTWFqZjhxTVZ6VHB2cFloR2hGdXVGY3k2?=
 =?utf-8?B?RkpmNWJVWW9BdXcyNUVUL25LeGcwdUsxNTNWR0YwK0I4dGhnKzVKTk5zZGRo?=
 =?utf-8?B?UTQveGpjUlB5V0svSGtpK0s4Q256TnJXUmhBR2thSk1JTHBHbis5anArcmhi?=
 =?utf-8?B?OXFJeTU2RW40c3NweFRNZGtFZC94OUNkd05xQVJ0aU9xcXZGYlZFdDg0TDM0?=
 =?utf-8?B?d1crZlVMY2FqeU9IS1NmcytobGQ0U1RsUHRveTR6c1FFN1RyR1Y5bXVMNEJG?=
 =?utf-8?B?eTFJcXQ4QWd2dHJiNEVEUVVjWDdQTzlrelNZbFdrKytVcVdMM3ZZNWczNVNs?=
 =?utf-8?B?SXp5T1NpOWM1T2xxRGZXSUdkdWZSUnZvRFBtTUM0Rnl0UkxJRjBiL3RxOE5M?=
 =?utf-8?B?Z3ZYSW95WWpSOGdQUEpxTDA2Z09WZVR6VGFHSkxOY3NsR295SlY3RUN3dkpG?=
 =?utf-8?B?ODNEQk1ta0VXdFkvWEN3ZnQ3QktvMUFlUjdiQXFZaktDWjdmYm0zOUN5MW9k?=
 =?utf-8?B?a3dpaE9jVE9LQlVkN1pSNW93MEtGWW1lcCtFenl6SG11N0VJTWt2aDNvY0xk?=
 =?utf-8?B?SUk1RHgyL2MvTzBCejZScmt2QW1iS3hOSmhRWjRZOUNKZlVaZGpjS2VsaURP?=
 =?utf-8?B?YmJCRDVIcXhscFRWR2k2OW9UcGFaSExiSFQ5cnhpYWNuSU5ZSys4ejhkbWxo?=
 =?utf-8?B?NlVUN01rSEFJUzhQVmtCdEJ5Y0VpSXM4aUlSd2pndDZRVklRcDY5b1U4U1J6?=
 =?utf-8?B?UUsyNFJoU05VeGxHUkwvSVhkMUxlUVdydUlCMjl0SWFTOWVqMnc3dm1VVmdQ?=
 =?utf-8?B?cmdZTG1vQy8rZjlSdEZJeGplQTk3MDF1VzlscUlNdTNRTkFhY2w5a0QrSXZJ?=
 =?utf-8?B?a0xOamVhQW40U2kveGxxdWorTmN5ampkTWtVd2xGTzBCRGRHVFM0Uk4zd21r?=
 =?utf-8?B?b1JzZWo5SUk0YmNsYVNHcW9YQjQxTTdZTktLWlVOYk9nT1pCYXJyOXpqS2Fp?=
 =?utf-8?B?NXNNV1JiOXJDeXF5TWFDOHUzTnJJcitOYkpmSCtUdVlVQm52U0V1bmM2QzA5?=
 =?utf-8?B?Y05aa0pickE1QkNyVFlKS2R1TU53bCtKSHplVjNabzJQMUdZOHFGSVE1aE5k?=
 =?utf-8?B?N0RxZFY0ck5VQmZ5Um1vVlRKYVVUYzNkMTdpUTR1RXdNb08rL0QzcG1rVENR?=
 =?utf-8?B?VzhvaEd1Z05HSUJYMXVVQlJWUEtMQ0lDL0UyYXBsTElxL2tRcHZ4QkV0dW9v?=
 =?utf-8?B?cmx6MnJ0Mlk0WGdOTEUzcVQwOGFxNWtydnNOT0F2S0RYWTcvWjVUZVdHNVNn?=
 =?utf-8?B?cE1UdlFxWCtSWEczTlRMbUZVaGR4dmRMVHRRS09QbTdUeGJKdFF5ZmhMbmlC?=
 =?utf-8?B?OW9SRmlEZWZQVVA2cFdvNk5BZ3NTZDdNWjZ3cVp1d1Y5Y0poZXBhSDZHL3pL?=
 =?utf-8?Q?5ta+Kw3A1HN01aYBOmBcrwWTQRTJct5Jt445ys3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e847d5-d7b5-424c-17fb-08d942215afd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 15:02:07.9824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJbGrOB7KDFmeXsyUkbHHRfYTL4aJBEvk2qwFAfzxUIOFtOmuRCoGBtwwzMoTTCHfxs6rXHiYeicsXofG9Zk0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4557
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Dave,


On 7/7/21 2:21 PM, Dave Hansen wrote:
>> @@ -502,6 +503,81 @@ static void show_ldttss(const struct desc_ptr *gdt, const char *name, u16 index)
>>   		 name, index, addr, (desc.limit0 | (desc.limit1 << 16)));
>>   }
>>   
>> +static void dump_rmpentry(unsigned long address)
>> +{
> 
> A comment on this sucker would be nice.  I *think* this must be a kernel
> virtual address.  Reflecting that into the naming or a comment would be
> nice.

Ack, I will add some comment.

> 
>> +	struct rmpentry *e;
>> +	unsigned long pfn;
>> +	pgd_t *pgd;
>> +	pte_t *pte;
>> +	int level;
>> +
>> +	pgd = __va(read_cr3_pa());
>> +	pgd += pgd_index(address);
>> +
>> +	pte = lookup_address_in_pgd(pgd, address, &level);
>> +	if (unlikely(!pte))
>> +		return;
> 
> It's a little annoying this is doing *another* separate page walk.
> Don't we already do this for dumping the page tables themselves at oops
> time?
> 

Yes, we already do the walk in oops function, I'll extend the 
dump_rmpentry() to use the level from the oops to avoid the duplicate walk.


> Also, please get rid of all of the likely/unlikely()s in your patches.
> They are pure noise unless you have specific knowledge of the compiler
> getting something so horribly wrong that it affects real-world performance.
> 
>> +	switch (level) {
>> +	case PG_LEVEL_4K: {
>> +		pfn = pte_pfn(*pte);
>> +		break;
>> +	}
> 
> These superfluous brackets are really strange looking.  Could you remove
> them, please?

Noted.

> 
>> +	case PG_LEVEL_2M: {
>> +		pfn = pmd_pfn(*(pmd_t *)pte);
>> +		break;
>> +	}
>> +	case PG_LEVEL_1G: {
>> +		pfn = pud_pfn(*(pud_t *)pte);
>> +		break;
>> +	}
>> +	case PG_LEVEL_512G: {
>> +		pfn = p4d_pfn(*(p4d_t *)pte);
>> +		break;
>> +	}
>> +	default:
>> +		return;
>> +	}
>> +
>> +	e = snp_lookup_page_in_rmptable(pfn_to_page(pfn), &level);
> 
> So, lookup_address_in_pgd() looks to me like it will return pretty
> random page table entries as long as the entry isn't
> p{gd,4d,ud,md,te}_none().  It can certainly return !p*_present()
> entries.  Those are *NOT* safe to call pfn_to_page() on.
> 

I will add some checks to make sure that we are accessing only safe pfn's.

>> +	if (unlikely(!e))
>> +		return;
>> +
>> +	/*
>> +	 * If the RMP entry at the faulting address was not assigned, then
>> +	 * dump may not provide any useful debug information. Iterate
>> +	 * through the entire 2MB region, and dump the RMP entries if one
>> +	 * of the bit in the RMP entry is set.
>> +	 */
> 
> Some of this comment should be moved down to the loop itself.

Noted.

> 
>> +	if (rmpentry_assigned(e)) {
>> +		pr_alert("RMPEntry paddr 0x%lx [assigned=%d immutable=%d pagesize=%d gpa=0x%lx"
>> +			" asid=%d vmsa=%d validated=%d]\n", pfn << PAGE_SHIFT,
>> +			rmpentry_assigned(e), rmpentry_immutable(e), rmpentry_pagesize(e),
>> +			rmpentry_gpa(e), rmpentry_asid(e), rmpentry_vmsa(e),
>> +			rmpentry_validated(e));
>> +
>> +		pr_alert("RMPEntry paddr 0x%lx %016llx %016llx\n", pfn << PAGE_SHIFT,
>> +			e->high, e->low);
> 
> Could you please include an entire oops in the changelog that also
> includes this information?  It would be really nice if this was at least
> consistent in style to the stuff around it.

Here is one example: (in this case page was immutable and HV attempted 
to write to it).

BUG: unable to handle page fault for address: ffff98c78ee00000
#PF: supervisor write access in kernel mode
#PF: error_code(0x80000003) - rmp violation
PGD 304b201067 P4D 304b201067 PUD 20c7f06063 PMD 20c8976063 PTE 
80000020cee00163
RMPEntry paddr 0x20cee00000 [assigned=1 immutable=1 pagesize=0 gpa=0x0 
asid=0 vmsa=0 validated=0]
RMPEntry paddr 0x20cee00000 000000000000000f 8000000000000ffd


> 
> Also, how much of this stuff like rmpentry_asid() is duplicated in the
> "raw" dump of e->high and e->low?
> 

Most of the rmpentry_xxx assessors read the e->low. The RMP entry is a 
16-bytes. AMD APM defines only a few bits and keeps everything else 
reserved. We are in the process of updating APM to document few more 
bits. I am not adding assessors for the undocumented fields. Until then, 
we dump the entire 16-bytes.

I agree that we are duplicating the information. I can live with just a 
raw dump. That means anyone who is debugging the crash will look at the 
APM to decode the fields.


>> +	} else {
>> +		unsigned long pfn_end;
>> +
>> +		pfn = pfn & ~0x1ff;
> 
> There's a nice magic number.  Why not:
> 
> 	pfn = pfn & ~(PTRS_PER_PMD-1);
> 
> ?

Noted.

> 
> This also needs a comment about *WHY* this case is looking at a 2MB region.
> 

Actually the comment above says why we are looking for the 2MB region. 
Let me rearrange the comment block so that its more clear.

The reason for iterating through 2MB region is; if the faulting address 
is not assigned in the RMP table, and page table walk level is 2MB then 
one of entry within the large page is the root cause of the fault. Since 
we don't know which entry hence I dump all the non-zero entries.


>> +		pfn_end = pfn + PTRS_PER_PMD;
>> +
>> +		while (pfn < pfn_end) {
>> +			e = snp_lookup_page_in_rmptable(pfn_to_page(pfn), &level);
>> +
>> +			if (unlikely(!e))
>> +				return;
>> +
>> +			if (e->low || e->high)
>> +				pr_alert("RMPEntry paddr 0x%lx: %016llx %016llx\n",
>> +					pfn << PAGE_SHIFT, e->high, e->low);
> 
> Why does this dump "raw" RMP entries while the above stuff filters them
> through a bunch of helper macros?
> 

There are two cases which we need to consider:

1) the faulting page is a guest private (aka assigned)
2) the faulting page is a hypervisor (aka shared)

We will be primarily seeing #1. In this case, we know its a assigned 
page, and we can decode the fields.

The #2 will happen in rare conditions, if it happens, one of the 
undocumented bit in the RMP entry can provide us some useful information 
hence we dump the raw values.

-Brijesh
