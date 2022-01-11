Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C8548B94A
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jan 2022 22:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243972AbiAKVWH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jan 2022 16:22:07 -0500
Received: from mail-dm6nam11on2042.outbound.protection.outlook.com ([40.107.223.42]:59200
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229775AbiAKVWH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 11 Jan 2022 16:22:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDN041WbNDkb+x4djXMpKCN8NixNxdmJrH9Wl8fxeaqlwqcWrRp9hZq8or2lH5qKFpUZoiZHrQW1mJQrNgEiuYb3Rg3zbE0f52diEKHioyE5ao6YoA4XTugMdumcNIYZKxeZ9D7NFMa95JLEMIOjIFiLBYjVTvjTgDWVvxD1y8sNeTfuMLOUsq7Ays21TBCOY1mjHmS3roZODdHiVG+X9SzeytOBXLs7Ps5OjxJ91X6dVc3Bfa801fWYu6oqZJsM9p9MbINlToNQ/SfbMiTAn1wh0hmOaYRDuEE1KnNZQuh3XFgH+g8JdNnfKkMbAub3ISS4S6ZSsajCeUejVahJPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=donxccRMsY++XFMpR0QB05NljtrlH1Oqq8GJcbA8zjs=;
 b=K2oy0j+KOB2opK67tu+TgMBFiAkS3GFVX4g2SrqqLGccar6om459x1TQC4iO7zx8EMt++jcXa6Nvljfqf4zhEPpRhPXME96NXfgwMy1QZsqp3HiNwXYO3rpWFihLUPNwKHruZAQW9W+bqaAC6O/kU9s6YIEkHFiKgc2WTkN7TRKpfYEldHSk4ne41wN7g/sDl4QDvxkfDMz6ag+aU+x4r8CbxZwxRmWmb3XhivWwQ12huzpjagZ4/Wd9RXwRi7owsmdn4uqQT8DJ+zV2EUYH/Cvior3+MnxFLT8Rv+KFQQN1T2c9jiSDprCWq1IbX95UGSqMEMrBIOfSHwq0+uuaNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=donxccRMsY++XFMpR0QB05NljtrlH1Oqq8GJcbA8zjs=;
 b=44Su6e9GasxZPwe0KGzz/jPA1d9aj7oVuzqNzdZqwIxbplTMvAiD9eCBHy89IbkfDDagk8te4Cy8CQWhKszjNC7/BfU/Ej40HCsi6kIUMjQa4QGqAI6z0JFHGqYRo6fS01tUKtW7M9yelj0LqDL2M6fzhdEk0fKUO7QAtY+nRwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) by
 DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Tue, 11 Jan 2022 21:22:05 +0000
Received: from DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::940f:16cc:4b7f:40]) by DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::940f:16cc:4b7f:40%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 21:22:05 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 12/40] x86/sev: Add helper for validating pages in
 early enc attribute changes
To:     Venu Busireddy <venu.busireddy@oracle.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-13-brijesh.singh@amd.com> <YdOGk5b0vYSpP1Ws@dt>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <7934f88f-8e2b-ea45-6110-202ea8c2ad64@amd.com>
Date:   Tue, 11 Jan 2022 15:22:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YdOGk5b0vYSpP1Ws@dt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0365.namprd03.prod.outlook.com
 (2603:10b6:610:119::13) To DM6PR12MB2714.namprd12.prod.outlook.com
 (2603:10b6:5:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b457931-2d7f-4945-0179-08d9d5486a61
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB36574A93EDDDB8CC0571A86AE5519@DM6PR12MB3657.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iBAdx7I+N3eQBnMws05BZSfy9EIJL4Rqa6TUwC2TbUoaGLzcnfHU6pe7C4bcRFz2Wtk1ojwnjjezjrxQ26efAKO++y+M8lY51S+UiFd1Aii9cHTXoJJJiS9x1pTGsqZsWCJM8By6AgukshBt5owkzPu356Lh6L1BMRJCNVEV3uIxjOFEZzCPHu6zgHUI0EJoM1/0YjIwXgq4UdzgW8AICCHS+w9vZ04EpymmpbdtoSjf3XM8qZi/wzOtjz8W0JAv+L8G+yQgXLHk+MRQDKglGqkago+QMmlSDVTnWF+beMSuGz9DvG7sr/33sJM1gZG3AreZmAxiDs5ewJUxRM9CkjDxF4pJB21bGYcFxls1Rv+EVHPlWR7B5O1YuSgluuvUM5XMto2R1V3BK1xKoB8hQNt49Rc+MNX7E9UXJHyHV8ezwQjjdzUHjg0pBtf8BgeqZYyScVqOt+vqVcBD4dpJQs/fGg6VIb8pIsDI7/wUVZoP4F3Ajh9pWlH7BByCSh6GP4QjaBMkkvp/NvJv7apeuYimVXAvz1UDqfYFpRkqPFzaRBQG97mIIFlIVi76zEWR4mzv8gSDm3PRfW5HQA52ODy9kZm9+aIyXoWu1RgfsxRSad7O0I9JzwzGTAx5Yt/YDCeQdmNfcIfHczze8HBeCxx5Rq+kv8Bwum6tHMTqRcyYntrZg3re0akF7wicSN1traPfBGlNfiP2Wd0cB51Xr9W6wSwMjJXHXg+iMc4IvP8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(66556008)(8676002)(44832011)(66946007)(36756003)(31696002)(6512007)(4326008)(66476007)(5660300002)(508600001)(6506007)(2906002)(53546011)(83380400001)(2616005)(316002)(54906003)(8936002)(38100700002)(86362001)(7406005)(7416002)(6666004)(186003)(6916009)(31686004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE1WTmx5RTVCWm1xR25xdWRraUIyazhLcVRXUGJtWDBCMUdESEdlYzNGTXBR?=
 =?utf-8?B?ZTgxWmoyelQ5L2o1QTBVZkFMTTdiWjFPM3JIcVk0ZkFzZ1R4NVRabVJDaUQr?=
 =?utf-8?B?d0wranZCOC9jUEFtUXRtTkZwWHB6WGQ5eFl6Szd5VTB0em9aZmtTR3lBVWhL?=
 =?utf-8?B?a3RhMGZoYndHeHk2aS9NbGhrUHBWeDlvRnNVbUlNb2VMOHhEQXpIR0U1NTVq?=
 =?utf-8?B?dmRXSGRZRFhuRkMzTmNITWtUZFV3YlJYRzlxOEdCeG5ZY1c3dFcxM1R6K3Yx?=
 =?utf-8?B?bWlPMnVUcyt1WXY1d1V2emZpaEUza1lHQVVPb0FKcmNRS2d5N0JoTW43ZnZy?=
 =?utf-8?B?TzVLMjFjU3JWR1pTZ3J3QzVKTDdzcnVMdXEwQmtFRWowRUZnNVR0YWpFdkht?=
 =?utf-8?B?dk1PajA5SS9tdUtxN0V1M3VRcHc5UUZkSE1LLzJub3BsRExNanJOYTNLeGxE?=
 =?utf-8?B?MmZ5bFJEb0U2Sk5tRk4wQUFSRkppMTIwSlI0VlFzVnUrYzZBTCtxTFlrdWtC?=
 =?utf-8?B?N0ZkdUxDbmVxcGRMME51QnlTWFRiaDU3T0dRMW9UR2FMQnNQRzJ2UUxoTUJs?=
 =?utf-8?B?a3ZDY1l5T3ljSFdLaXpJbHVVbnFlbnhKdlhESGJPYzEzaFVyTXRyK1NqbGsr?=
 =?utf-8?B?OFRlSWRHNm16YmlwdWtnUnFUYlNyeGVtT25jTlZuWXhLTG51b2U2WkUzakFX?=
 =?utf-8?B?SmgwdnB6SEp6TEZYZFBPUmw0KzMzTTdsNDNEYks0U3FqZERVVmE4R014dU5H?=
 =?utf-8?B?c2FDenVIT2VyMUhNREpNTlpVM2gyU25iMkFlNjQzT0xIeU5FVHJLUmxUbDBH?=
 =?utf-8?B?aElTbmh5bG5jZWtSQ2RtdFhhOTB6M3FZa01SbUF0cnFVdXUrOThpSmgrNHBL?=
 =?utf-8?B?dlFmTGlVaWg0N2xIYVRBTVFhOGR0WDJDVmwzT2RxVXpXTDZuZlZTbFFiTTNj?=
 =?utf-8?B?YUtaNkNPckx5bnc1UGZuUms2N2VUTDVmR2duQURibllNaUNteC9JbUQ1VGdr?=
 =?utf-8?B?Rld0NjZlQlllVUJ3cExaQ2QrRkRSblJYZ3pLUEp0UUxwNjdLdFRPdVN1Wkxz?=
 =?utf-8?B?c3pjbXlNbkZaUWxsS3RvMG8wamx4ZHVHZkVydW5ocytNRzB4T000S0Q3RHRs?=
 =?utf-8?B?WEpuNEtjR0p2V1EzZktmdnlLdllZdFVCU0JITmh3dVNlbDVsOGpTb2U5NkRj?=
 =?utf-8?B?YnpwSUlaSXFIbHBaUTFWTTRNRGE1dVlHZlk1WndnSldjSXNMUVMvamdUZFU5?=
 =?utf-8?B?U1F2ZnZsOUVvWFgwYncyNjdWUjFwN0svMk9ZS2g5STJPSDZnY3kwMWkzeVVN?=
 =?utf-8?B?S042RWZzTi81VCtDYVkzNVNWYXV5Vm56L3pFc0kxanU0SVI0YzJuMC9kQWZz?=
 =?utf-8?B?NkUzZXhxazJaK3lLSGVvNkNXRFQ1ZWM2SzZISzNPT0w0M3R2TkRhMmNvSE1P?=
 =?utf-8?B?bzJLYTYwSG42WGpCeERRSTVTWHU2UDRveTZvK2Q5RW9uaWdPYWZoVnMrKzQ3?=
 =?utf-8?B?RURxcEd0RmtlbVRFTjQ5a3pRbjQ5Q1IrSk8vNitpQnZOaGdWSE56VVUvNGVE?=
 =?utf-8?B?WXhwS3lqTzVxUW5ESDVJZnVSNVlyYWZUalk4c3JPZWJNSVlCU0Zyd2x3UFo0?=
 =?utf-8?B?N3NOS2RRQ0lWdkxBa0VVakFZelY3bk1FcVpTNlNLSHRtTU1oa1hid2R6UWw4?=
 =?utf-8?B?MUFDS1Y4VDlZSTZielR2cHNGSWpqcDYwcUQxSmgxYnkyaWRwejZJQmdESmRP?=
 =?utf-8?B?TXJMais3QktvZE50WHhtQnp5dFlWaWt6dUNRL3U2NEdPTWttUHF1YUJ5TlBr?=
 =?utf-8?B?VWxaNW5nS3VzWmV2WEdqbUU2TUFvMktJTHV1VXROL2xqdUVQWkNTejRTaU1K?=
 =?utf-8?B?TzJFRE5OWFNtWHR5SEQ4QXcrcnNZeTJydDVaWExuanYrV0dpY1h4eU1SVTVL?=
 =?utf-8?B?bUJsOWV1Tk8xbkJianNDNlJDZVE0a0Vtc2ZKaEF0VCtFY21udGg4eHJvNWoz?=
 =?utf-8?B?bDlvMVBkeXY1TDFpR1FZemRPK2c3VGlZSjNZQUNNSUdDWk5pWENuR3VsRDg1?=
 =?utf-8?B?K1RINTVHaHVJQndYcjN1UFc1ejdEMVl6UWxYeGpCVGxZODc2cGZDMWJYYlAy?=
 =?utf-8?B?Z3g3b3NCM2d4QUs2UU03VW9DWUVscHNGWnJyaGRoZ2ppeTBZYjQvR1hKN0pR?=
 =?utf-8?Q?kJY3A1BXP44cT/SIwaTsYPE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b457931-2d7f-4945-0179-08d9d5486a61
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 21:22:05.1239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: om7doy0CEe4nW7XmSMPuHgE1bJk/z1NRnO9d+Qd84TUlNMOqj4GagvweT8Q50hkK7V1v2G3iaho6mf/lkMld1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3657
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Venu,


On 1/3/22 5:28 PM, Venu Busireddy wrote:
...

>> +
>> +	 /*
>> +	  * Ask the hypervisor to mark the memory pages as private in the RMP
>> +	  * table.
>> +	  */
> 
> Indentation is off. While at it, you may want to collapse it into a one
> line comment.
> 

Based on previous review feedback I tried to keep the comment to 80 
character limit.

>> +	early_set_page_state(paddr, npages, SNP_PAGE_STATE_PRIVATE);
>> +
>> +	/* Validate the memory pages after they've been added in the RMP table. */
>> +	pvalidate_pages(vaddr, npages, 1);
>> +}
>> +
>> +void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
>> +					unsigned int npages)
>> +{
>> +	if (!cc_platform_has(CC_ATTR_SEV_SNP))
>> +		return;
>> +
>> +	/*
>> +	 * Invalidate the memory pages before they are marked shared in the
>> +	 * RMP table.
>> +	 */
> 
> Collapse into one line?
> 

same as above.

...

>> +		/*
>> +		 * ON SNP, the page state in the RMP table must happen
>> +		 * before the page table updates.
>> +		 */
>> +		early_snp_set_memory_shared((unsigned long)__va(pa), pa, 1);
> 
> I know "1" implies "true", but to emphasize that the argument is
> actually a boolean, could you please change the "1" to "true?"
> 

I assume you mean the last argument to the 
early_snp_set_memory_{private,shared}. Please note that its a number of 
pages (unsigned int). The 'true' does not make sense to me.

>> +	}
>> +
>>   	/* Change the page encryption mask. */
>>   	new_pte = pfn_pte(pfn, new_prot);
>>   	set_pte_atomic(kpte, new_pte);
>> +
>> +	/*
>> +	 * If page is set encrypted in the page table, then update the RMP table to
>> +	 * add this page as private.
>> +	 */
>> +	if (enc)
>> +		early_snp_set_memory_private((unsigned long)__va(pa), pa, 1);
> 
> Here too, could you please change the "1" to "true?"
> 

same as above.

thanks
