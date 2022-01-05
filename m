Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39960485AD8
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jan 2022 22:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244535AbiAEVjb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jan 2022 16:39:31 -0500
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com ([40.107.94.52]:55329
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233366AbiAEVja (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 5 Jan 2022 16:39:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSOai9XmCERE0wRhhVp5UbUwgjvDYYoyBcSN3T0MxOCUKbQdn3n0tOJUoj+UPQkexF6JhvirLdlFA0d00CGCsAZld2JyMc1lLj7P9AvuOY2gUwgWEsHcHM4ImsnGdeE0QLsakKHKJLDrKnBGxpSijYBqlpBVWaDd2O7okZLBvHE3F5mdZOgYv3XEl3k6hq8vkh50G/Er3gQZK/Gs9wQa3o5cynjOkeJjwT0Q4NDXu9y8CMYTM4uj2D3rFCacDL9EUh5OM8figWeDjqlpQC4CyB3le6LYX/GFivVbeyknnL9GfyrwVEgxgZuvS9cOs4N2YH9d6eEnU2KPkHd7Wk6KvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lw8jDW2tXefaWp7g240AwPgDmoJeyI+G52VvkcPUahs=;
 b=IubpVFZTRakLCjqsLZAVgC41C61vZSVknggT1KSN9D2FUgA5iMzaGDJmb5shay+5isSRLkIOECeoJNNHxlBm7Drse1O0jddMQC+bfFn14KetuhBhhKRf9/tZt6u5R8n0BpAywGm82x4/t2GqY+WItobpLciqhTS0tc+vA3q4u+LR9HhgKWoXCzokrFg4nCDXrwOvDWJ3aYsaj4b/09AfPsi9pKXrLWTCn8MoN8LrjyfDWEnfcvir70+vU9JS1DOCH7gRarCIBm8ei0S7NTMCt4afz1lDyAnSh0gsTdLGlASpt6BjVELC+09mAboqBShhikmyA5XjfWdvLaPUb97+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lw8jDW2tXefaWp7g240AwPgDmoJeyI+G52VvkcPUahs=;
 b=H+qEjfKkMQqZv32+VW0zwt809nzowQKvi8d8OzUFngaLhi0V0XtuUgQBoEXhxlHgoY1mlznMYLU1YNhYe7XJWIWegO/WVgcRQqqh5yMaw4CWkmiY3vAmaguiuV+oRCQ7YeGrUPT+YZHlmLCVmZ7FSBSDa6svdbKlEhq8C1R8Pks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2687.namprd12.prod.outlook.com (2603:10b6:805:73::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 21:39:27 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c%6]) with mapi id 15.20.4844.017; Wed, 5 Jan 2022
 21:39:27 +0000
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
Subject: Re: [PATCH v8 13/40] x86/kernel: Make the bss.decrypted section
 shared in RMP table
To:     Dave Hansen <dave.hansen@intel.com>,
        Venu Busireddy <venu.busireddy@oracle.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-14-brijesh.singh@amd.com> <YdSKQKSTS83cRzGZ@dt>
 <18eadf9d-8e31-0945-ccf4-2cb72b8e0dd4@amd.com>
 <acba0832-9b11-c93d-7903-fff33f740605@intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <444b6c78-c4d3-f49c-6579-bd28ae32ca3c@amd.com>
Date:   Wed, 5 Jan 2022 15:39:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <acba0832-9b11-c93d-7903-fff33f740605@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0029.namprd18.prod.outlook.com
 (2603:10b6:610:4f::39) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f708ec2-1854-49f5-157f-08d9d093d91c
X-MS-TrafficTypeDiagnostic: SN6PR12MB2687:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2687A31F929E37D1EE51F5AEE54B9@SN6PR12MB2687.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qxpXhC6JGjsKSMk/lmMuOfSjYVrGqaxnXDH6cq+Ev7Otr59LMEKy5/77J+i2g5omS5A2lTDG15gbTGVw7/8vt988Qoxv0ohi7VG0+JXDXNs9uvGHIxwfyxRH8DOEjx3jXoBUf5WjZDvqdutrKHx7RsE2xi2E5EfZpWeNFat/VfJ3g3jKzpCj5G4Mn6dMh8W0TrbtIuJEhO0cM34uvcHPmmOKPmWwX1IZ74pdKai+1DfkyOMhFfE5Z5/IwridI/5YxmmGcpwzH4XSsfSCPbwrzn6Fq7nj3Lyvl6mJwYgziM45XI80NHXL/HWtK5vqFh+DbKDJkZPth02mvK2mKywzD+u8mx8lYDg5DiU433GWwzyyhvoiqWjuLxJOS3VjHdjCZQjD49Xy31XS6KvGOxDlViwTrECEdYfrdY3AO9rA8EaUSssSKiAavrnqlI03SKGlSyMcH6eTvpMABDqHLYMjDdAmoRT5Aai0dyBs2wCX0k0tgSdyNOapvQf90XCr0+5xy4x/xCa08+op7aVL2L+00uxSNsbBnLV96dOfWeBb4UF8+rafCOf5wnADlwgiCKiL8K4bxYwTLNcB6GFw5+5WdBIAZrRkfgXd0EgjqfmmOlsHDtzPPI5iBDp5AHZruZwed26A9vw+ceeN+u4F7XmNEVkyhJljLWoQp3dEFuWwJRl4CjHJ0aBUU9Pi5+6oa6QFIjyX12ZIqN7girGAIaRKPnjBj+vDrkWHrhdrD6vmuTrmQBHlynV0wGEyQwFOUWw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(66556008)(66476007)(66946007)(83380400001)(54906003)(31696002)(38100700002)(36756003)(53546011)(316002)(31686004)(4326008)(86362001)(186003)(8936002)(110136005)(7416002)(7406005)(8676002)(4744005)(6486002)(6512007)(508600001)(6506007)(5660300002)(44832011)(26005)(2906002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDVsOEZGOTQxRmVzR1hwN09BVDhRNlJTeThQak5EaGsrTE5MN1ptUkFpcVR6?=
 =?utf-8?B?UVZzbU1VWmJRbVJjZ0lBd1BvS2FhUVZ3ejE4WlNkM200VWx5Yk1ndHloZDcr?=
 =?utf-8?B?N1lTRGkvcVcxQy9qZHVFVXBqZnVrWTY5SEhwU0VOZ2p6UWFtcjJiQkt2QW42?=
 =?utf-8?B?bGpiWU93NTdwOUh0UEJyV0xVOEhSaWZoOVhibitrbVZvWURVQW9EaldnZmxk?=
 =?utf-8?B?UG9xcyt0NmNKQnJYR2R1Z2l2S01OMHhZS1FKUEl4akJiQzJ6YzZsMzlsU0dk?=
 =?utf-8?B?eTVmVzZpZjR1ajVHUnJsdGR0a0ExVmNGVXA2Kzk2L20vSk5USnIxTTJ2VGRY?=
 =?utf-8?B?MjhZZ3ZsQ2JWZ092bEMzOG9kdDlTckpUd3lkUTk1ckZYUWpYVlhFNDgxbzBC?=
 =?utf-8?B?T054N2VMaGR5a0FybXh4cis4aTlGaVNTZnlMU0taWStPeGplbG5yeVBDZDFH?=
 =?utf-8?B?UWtHUHlLOFNRdDAwcDk1UGZOOXUrUmNEbEgrZko1NEdNTDZuUjFtRkNieVo4?=
 =?utf-8?B?enpnV0g5dUQrdjZleG9GMkxZcXp5N1I3NjFaOGlpWm91K0UzUjM1aTV4Z1hD?=
 =?utf-8?B?R251MkxlUm9IOHNzN3BINy80VFJRRjY2bEw5R2ltY3NGTGNVK3dRenNLSCs5?=
 =?utf-8?B?TnhMVVFESGZlOTBHSXNrbzRDVGUyZUdZcnZoTTFXbEdTb3g2RWpNTDRHei9v?=
 =?utf-8?B?dE0zeVNEMEh4R2VGM1Iyek0vZ09OZS81WkJnUElnNWpCNWRQZ0Z5VjNMbkdF?=
 =?utf-8?B?QzhGZWVrZGhjNmRwVk5ZSnpnMW5QOGVObEk4YWlQQWN3MnYzTlJlMmpENjZ0?=
 =?utf-8?B?aFB6bDlqQ0lmZ1BYSEc5dFZrUjhZY05TWFp6SGZ6WWhIMXBvZ2JsK1ZsMU1P?=
 =?utf-8?B?Ym9LWjZTMkcvcll1VlBjcEtwemNkZ2hrL1h0aEo5SjZVTngxajhteGxhNm00?=
 =?utf-8?B?RStTRVh4SGJtRmJLN09TS1U0MThRZ2hFemljMHNYd0VUWUQ2Q2JPSzdlL1NX?=
 =?utf-8?B?Y2VFTXJ0VjZvNzRxbVdzeHFZN2NUNnVUM2crRi9tUXllZ1haUWR1STRvUHRx?=
 =?utf-8?B?VjdzL1lDeFE0MmJNVVQ5cVBKaVlkSXc1TEs0aEhVaXVYWi9vKzYvdUV6a0E2?=
 =?utf-8?B?Z21jTGlkQmQrUm9FS3AxUysvVjFmVVNLYW1oTEhhelNzUXhzSVdFVDVGemJh?=
 =?utf-8?B?YXFrc1VPelAvWUhiLzI2UlZsQkJnNmVlNFhiM3Q1WGZkaU56MlhKQ3pNQTJD?=
 =?utf-8?B?WGxVOFpvNSsvUXJmVVZHTnpXWlllVFFhSll3T2pCVEY5Z1NOWGdsYmEwTlZN?=
 =?utf-8?B?SUFnWEZLbU1CMnJZWC9RbmQ5MldnU3ppQUxmaEdyNHBQdG02aisvN3p0cVZH?=
 =?utf-8?B?MlNDelM5b3VXMTlXTmFkVFE3L0hoMGVHcUFGSjk2ME1mdFlmUzBHOVFkTy80?=
 =?utf-8?B?VHBzek5TMUcveFhIUUZ5VVJ4YjJGVDJNYml5Z2ltMWRlczRPbkp0QVdJVnNl?=
 =?utf-8?B?ZzBuWkdrb1NWWVhMZVhpM0x0eHFGaWNGK2U5VFptOUJDaENFMzhLeFhYZkFD?=
 =?utf-8?B?dHZHRkZXVlFsS3dlMVFSRVd2WmZUc2drSTNHRnlrZmVTSDlxZ0p4WUtlZHpI?=
 =?utf-8?B?YTNUMW1YZm5oTlVUMDQxeDJUTms4YkJzTUVubWliRFlwN3pNQmtaK3VkbjVE?=
 =?utf-8?B?dVJTTGR3VXkzY0o3ek1WVFVOUHAwdk13eUNkVXZMSWlES3UwTTFtZVVFUjZV?=
 =?utf-8?B?QjY3cmt6Z0YzeXVxOTRNdWFoS3hUR3ZnU3hySzlaZHhjYTRDTVpqNFJ1N0Z5?=
 =?utf-8?B?OWRraFNySkFHWk85VDdOYXNGV3RnNklOUmFBZWhQeUpWS0hZeWd3VWdQcmNa?=
 =?utf-8?B?U0wwN0FEK1UwS0Z0RkFqTHVhdUNKeFNvVmc5QytKeGtKOFRFRzJaVG5ETFpP?=
 =?utf-8?B?aVozc0MxQnhmSE45Rnh2UXIwdi8zY3poYk9SUk0zN05aOGcvbjZlM0NQSmVl?=
 =?utf-8?B?bGp0UUNCSXQ0M05KQ2Rqd3QvTkNlSE0rbVpQTjludVRNZkExNzdmQ1ZMQnJC?=
 =?utf-8?B?VUtHVndSZ3h4Q3VGOVYwQi9IN3VBM1FzbVFiV3FzTEhNZGoraXNraER1blBK?=
 =?utf-8?B?L0xzVGJXYndUKzJGNGh4YXhLK2Jqa0dsVmk1eHB6N1d1QldlTHp4YmVnSFFv?=
 =?utf-8?Q?U+GsxvNhfKLkrO+ak1UdlnM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f708ec2-1854-49f5-157f-08d9d093d91c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 21:39:27.5359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMeyWrZZls7cRi9IMFhGiJ5cvoga+ZMWo9YL3/B31R3jL7W1me0U8sg9prZcG7VOPXq0omCx+MUpYo26/N9Vjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2687
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 1/5/22 2:27 PM, Dave Hansen wrote:
> On 1/5/22 11:52, Brijesh Singh wrote:
>>>>           for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
>>>> +            /*
>>>> +             * When SEV-SNP is active then transition the page to 
>>>> shared in the RMP
>>>> +             * table so that it is consistent with the page table 
>>>> attribute change.
>>>> +             */
>>>> +            early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), 
>>>> PTRS_PER_PMD);
>>>
>>> Shouldn't the first argument be vaddr as below?
>>
>> Nope, sme_postprocess_startup() is called while we are fixing the 
>> initial page table and running with identity mapping (so va == pa).
> 
> I'm not sure I've ever seen a line of code that wanted a comment so badly.

The early_snp_set_memory_shared() call the PVALIDATE instruction to 
clear the validated bit from the BSS region. The PVALIDATE instruction 
needs a virtual address, so we need to use the identity mapped virtual 
address so that PVALIDATE can clear the validated bit. I will add more 
comments to clarify it.

-Brijesh
