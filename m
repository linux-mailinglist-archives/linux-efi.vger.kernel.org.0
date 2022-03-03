Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2304CC488
	for <lists+linux-efi@lfdr.de>; Thu,  3 Mar 2022 19:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbiCCSDA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Mar 2022 13:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235597AbiCCSCw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Mar 2022 13:02:52 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFB81A276F;
        Thu,  3 Mar 2022 10:02:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNhBF8KSTqiNeOacBBz9dkg6tSkVqBMik1McMSzaOOygdPSYslEDmyXisS5vCdP9uv7AGHP4RNUhFgcmXjmhMdYC1CueN+55cj4BeBrwS/tNJffELbeZZ+VjMe7cZEnui4/nGsiFOxXXvm5DxUDWaIQtD8OFo00MYF6zdAM1+D6G52xIYwNcL+YJ2TGGLfvBNQKkrRvBr2nIuCGmZF27WIDWKwZ33p01YRl+gWjyNKw/OSvr9kY+3Hu47/713mdWkejrioEmDJJ991A//mAQgoVrYbgMekuMQXob/ZUUTpWR6lqXCISz3542zFsQUqRFRD55s7uWCIsY6JvvMnmXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qciY0PruJUL6w2bIQLQsiuO9bECgQvOcxhgr76koAA=;
 b=ZrdFidmRrl91O9GpuyDUO4pnn/cGCqLmhVRI9Istd/Av/KsKIC/VdWl5+6ZSg4qFJ+5zc0kDysTOEygLQyPFP2tyvJxv88Ilt2k/6Ha9d4kwKouJ0A9iJMcXF0Nk77fSEC0yL+S2KDF1m3nvM22D8iq8UjcABErEXA2qJNHgQoti6TVEOlCut6nFcQXDxNPJUhLSEh6UTx702UMitpxG/853/24D01rSBlhzWNIOcNKswOOsuroQZUyM9HrgvIl1VbldWy3qS+zKsUrvQwHqq2krZQ/z6k+j5EeIvHCLfb4TOJW9Kv+nOoyE/oYeLCSah18qHC8BQ12WtHBkJcom6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qciY0PruJUL6w2bIQLQsiuO9bECgQvOcxhgr76koAA=;
 b=wTuK9ui16Eg0dVnv+qdePQ/T4pq4mch5QwhEqqVhMkZpUhtq0GEIojzGbtaZs86aSEvniq05OlXjFQdsFjmMMXWL4F99PDYCJoMrmyhE5Xu1RnSlrc5t/Q8LWrWVX13DFokb/n05X8HLuZMshnoYOxlL1NhOL42u1EE6ppZcqhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) by
 MWHPR1201MB0063.namprd12.prod.outlook.com (2603:10b6:301:4d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 3 Mar
 2022 18:02:02 +0000
Received: from DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::15e2:e664:c56d:4d91]) by DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::15e2:e664:c56d:4d91%5]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 18:02:01 +0000
Message-ID: <25cd29d7-df95-14ad-2fa6-0f4876544789@amd.com>
Date:   Thu, 3 Mar 2022 12:01:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     brijesh.singh@amd.com, Thomas Gleixner <tglx@linutronix.de>,
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v11 22/45] x86/sev: Use SEV-SNP AP creation to start
 secondary CPUs
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
 <20220224165625.2175020-23-brijesh.singh@amd.com>
 <5ca2583b-a873-fc5d-ece6-d4bdbd133a89@intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
In-Reply-To: <5ca2583b-a873-fc5d-ece6-d4bdbd133a89@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0026.namprd16.prod.outlook.com
 (2603:10b6:610:50::36) To DM6PR12MB2714.namprd12.prod.outlook.com
 (2603:10b6:5:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2770561-10b1-4bae-2190-08d9fd3fead6
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0063:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0063F3E7D200B5403EE2CFE9E5049@MWHPR1201MB0063.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pZGI/saW/k06qWUkOkA9MjMtadYOWuME4KXw65H/9pN3j+0hyNj+tzV0mh6jvNjfmbn2KXNbItaAEGNDguVfhXNhfsoRaAi5MQqBWAaH/ibLaVtcw2uFReiLoWSnHg9AwL/uqhdifoTCVa+FNcrFPfJOjlDfjxmNhUBvQJsNOpWX3VgdppmM8/1y4o7dHbKJYFVJqNauhbr27fi8+Lb2o1BMJpuQvIu1SAlxPatxqsGUHIpWWWLvKVuBw/Y6QGAEz94EYh+gQINhGarLUCLnxI0hX8DThKfokhMOki1f4fY5t0q7LdQcyc1dvQmnRbr6rwgY8xvRM/JUqPBH/I7DUJhuCqzt++dpNwlaSyBJdB8z98+8hxdZsbWtnCsdG2HQ9ELJ7yNnaIK+YxAuhtiOjjpT1l2jQkcpfUh6KEL4+DlxFVQsE+paezCS4B8JBOLD43xjYP1vxLNAXBAcQ1Ye/nJ+RdZwD890KZreeVTZnmPIz52XPXOZ6ezgjJ/LRfzYyRv/u3YboPp5e+wHbAmFSXiCVE3r6SFE0isCxeXgkeHedOBdg5XKZZS1ZHKpY+dIgQXLgcv6renoeqlgYs0nMEmaux0b19mBvxOpFAZ7RvdsH0e0dwby+MRe4Z6xm6SCfJAth8M2oFgd0svGyxynkIfO2rXphTTHDRun3tV+j6lqj5aivJmKklkl4tUnv8WwU2t29/CTT3kma26nJOJKyzQMpZAAlTH/ZHkVJ0fiOsJwam2SRimLR4AAp9o3qheG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(508600001)(86362001)(4326008)(66476007)(66946007)(316002)(66556008)(8676002)(54906003)(8936002)(5660300002)(44832011)(31696002)(38100700002)(6486002)(7416002)(7406005)(6512007)(6666004)(2616005)(6506007)(53546011)(83380400001)(36756003)(31686004)(186003)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjdzbGtDcG1DVDc3cXp3WmFRZmRQeGFHT0s4ZFpIU1JGSks1OU1pYS93cjNl?=
 =?utf-8?B?a3N3TFdBb0tNYXNxdTBkK1FVdjdDUlhVeUFsUFNJZ3FxRndtaWNoRUozWmJL?=
 =?utf-8?B?U1M5c2luVnREa1d5b3JuQ2RYcVpDSmVtY3BGYW84amF2Yy85dktPTXQ0ejFT?=
 =?utf-8?B?dWswK09XRFp5bWhQNEljOEdhc21XVkZJcEkzaDR4UXRZb3RGRUlobUczbHA0?=
 =?utf-8?B?Z3p5Z0V4dlI2R2dlVWRYZWR6S3pkU1c1N1FIR0ZNYXFvQ0lheXlXbi9NamRO?=
 =?utf-8?B?aVdqSnB0aHZjK21uYUZ3MVBLZ3AvMU1aaWV6RmtPTlEweWN0RlZmc2FyekhF?=
 =?utf-8?B?eWFhaDl3ckYzd2QzSllEcElPdi9ZZzMwSUpOVFIyMGFLdGxUM3dYOTNJSWpW?=
 =?utf-8?B?Tk1wTXFmZExzRDF6MGNIeW11RVo4WEZIZkVPRVErc2liekxpdzlxWCtSK0lD?=
 =?utf-8?B?eThPVjhTK09UVFN0dnpkRmZGMStvNHFtL3RSaXU2L05ZQzhxYVVzM25Bb0VW?=
 =?utf-8?B?cTVTU0dqUWJKMDNWM3ZxbC9UZlRUQkVWN1YwdmRPaUxFTkp1MFIyVFJQaXV0?=
 =?utf-8?B?MVhCYVV0MnZNMXdqUUpQZHRLVzJSYkt3TDZta2tzcU5vc1I4WFkvbGp2Mlh1?=
 =?utf-8?B?Z3UxdFZ0MmhWZ3Q0VGkxWEZMWEFZWElVQVNlUU91M0wxTDA5MWhTYVN1Zytq?=
 =?utf-8?B?TjE4azg5ZXF0WExNT0dHSkczZFdaNmJOdjl5ek91bHFxZDloR2V2RVp4cTZH?=
 =?utf-8?B?TzNxQVI4TEpOaU1aNi9SSkFKRXdpcGJWRGlmQjhpbnl5RlNTYzQ2Z2JzanRK?=
 =?utf-8?B?UnpSWkM5eTFSNTlZWUJqcjllcSt4dllNcHJVY1pjTE9BYlRKTGJBWVp4aUVm?=
 =?utf-8?B?dzcvR1VqSHdZWVU3WHkxUVJLaEZXaEFIS25BRUltVGR1eGNxbjlVNy9iTjlo?=
 =?utf-8?B?VUllcC9OaXpqWnlsYnFBNWJUSktoRHU3engvUGxNVUNwTEpnN2FTZmppUC9T?=
 =?utf-8?B?bUFTYi9aVCs5UzIvWlh2T1g5Ky9XUS91b3YwNW9UaGpuODc3UlQxckhRMnR0?=
 =?utf-8?B?bHowZERwWlM0SU9tay80enA1YjJ3WTB5WWdNT1JySC9KVzRyY3BPbEhWbDNm?=
 =?utf-8?B?WUYrckRGUHdLbjlDRmZNcXhHWUFwSXVsVmhyRmJ0V0c0dTFXSXFvcnNTZWJD?=
 =?utf-8?B?bHhzL1R4c2tqbXBFQXJieXZiQm1kdEZ2cjBDUXpHQUZHaXJTSFJpUU53UnNI?=
 =?utf-8?B?dU96eVo1REc2NVk0YXZKeTNrYXFocmNZVnAxVkl6VXhqUktZTG5xYU9Mdjlp?=
 =?utf-8?B?WUN6bm9BaTF0Rlk2eUx5SGwrWVdJV05XSDZkK0l4VjNocDFldkJhOFZhRklQ?=
 =?utf-8?B?YVNWZHNJczI2L1hIRkpKMTQyQWUxTVhPcGJyT0JWK1d3RHFxMkRoVWl4eWQ4?=
 =?utf-8?B?VmNkM0RyYXBjTjhudENvUE1jQ3VhQVRDdmNSajFrN244djNnMkl5bFZzMFV6?=
 =?utf-8?B?N2VnVXZSS2syOU0vT3g3azVtVmw0dWRzandHK1JzS1lXR1h6cjJQVzRKMGpR?=
 =?utf-8?B?Z2RSa2lPQkZwSnVkRzdPbnhpVk9PYjB0Zi82TVcrZ3VOd1BKSno4M29IOEZY?=
 =?utf-8?B?N2ZSdGxMUnFuQWFtZjNZaUhxY1hDMFc3QmZjUHhlUEs1T2hkZExYckNqdUVM?=
 =?utf-8?B?OUhkemppWEt1MGhYVDZ5OFpRRGFNMHZnamFJWkFhdG9sT3lkUDhXUjNFM1Fu?=
 =?utf-8?B?dEh5RXpZbFkrMlJYazNwVmtlVytHU3lONVRaTmFZcVg2VVQ4eUR5RXZCbDE1?=
 =?utf-8?B?YjdaWGx3eE5mL084YnZkTEN6YXhBV3Roamd0MkpMclo5Ulk1d2w0dS9lRlFu?=
 =?utf-8?B?c0hmaVIyVklJQzNDSzZWZmZtZEpYbE4xSHRoVGNLL0UvNHZpWGk3WUdWbnM3?=
 =?utf-8?B?bmU4Y0VoQnk3T1BjZ0ordCsrZVFhVEFUekNPaEd5cytsZG1PcFJ5Qm8yRi95?=
 =?utf-8?B?ZDdmNEVsR2VJRWpMZGxoenlFaVdjQ3Z0ZXRtTW9IMkpjVytOM1pJd05SdnVj?=
 =?utf-8?B?NGk4SC95d0JQVHRweTBoMlhiS1JHYW96M01hSkIxSFlQZDVCT0trbGtPamN1?=
 =?utf-8?B?ZGpVRExzSXI5THhXd3BMVm82Q2pvdFlkOGpha1hoYVdZMTdzMS9WSXVtWS9a?=
 =?utf-8?Q?JoMUBBMzGsaUd9Hmw5eS0Tk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2770561-10b1-4bae-2190-08d9fd3fead6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 18:02:01.7273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FiagLtvt31eXv5LTDZ8N2eKqbkzHKOGS+6C09xHXcT5op6Im7dArysQvM5JQtvZ1Hu9+6EghueS7QhwzVrb/sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 3/3/22 11:09, Dave Hansen wrote:
> On 2/24/22 08:56, Brijesh Singh wrote:
>> +	/*
>> +	 * Allocate VMSA page to work around the SNP erratum where the CPU will
>> +	 * incorrectly signal an RMP violation #PF if a large page (2MB or 1GB)
>> +	 * collides with the RMP entry of VMSA page. The recommended workaround
>> +	 * is to not use a large page.
>> +	 *
>> +	 * Allocate one extra page, use a page which is not 2MB-aligned
>> +	 * and free the other.
>> +	 */
>> +	p = alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO, 1);
>> +	if (!p)
>> +		return NULL;
>> +
>> +	split_page(p, 1);
>> +
>> +	pfn = page_to_pfn(p);
>> +	if (IS_ALIGNED(__pfn_to_phys(pfn), PMD_SIZE)) {
>> +		pfn++;
>> +		__free_page(p);
>> +	} else {
>> +		__free_page(pfn_to_page(pfn + 1));
>> +	}
>> +
>> +	return page_address(pfn_to_page(pfn));
>> +}
> 
> This can be simplified.  There's no need for all the sill pfn_to_page()
> conversions or even an alignment check.  The second page (page[1]) of an
> order-1 page is never 2M/1G aligned.  Just use that:
> 
> 	// Alloc an 8k page which is also 8k-aligned:
> 	p = alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO, 1);
> 	if (!p)
> 		return NULL;
> 
> 	split_page(p, 1);
> 
> 	// Free the first 4k.  This page _may_
> 	// be 2M/1G aligned and can not be used:
> 	__free_page(p);
> 	
> 	// Return the unaligned page:
> 	return page_address(p+1);
> 

Ack, I am good with using your version.

-Brijesh
