Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D0E486B71
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jan 2022 21:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243985AbiAFUvE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jan 2022 15:51:04 -0500
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com ([40.107.94.59]:52192
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243992AbiAFUvD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 6 Jan 2022 15:51:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZ+pLzc8dPkE1Pry2NzOm7EHU9d2u5soMidy7cJO2ZQ7bcN/xEdhQ914LdwejbEnz22xZ7lenxPiuU9Y8KQU3xN7DMjejOTTN/xI76srbZbp7elW1pXdcUp6S4qMWFVHFbBG0wzwFc5nKdwMA63UQXxxCGkv779cc5uLdEABjnXeQyCWPzklPUZyV4LFM/z91kZ3AHHrr6dl77EhixIz0LKlto/H4wmeMBF7MBE31gWzrx5GGMVk8nUyBP/mEa8wMsnsrlqlj4zKLeazmAXzbyMHuSXDqY1BCHwbPsyZL4DKo80GV1IvTXImONJOgfUSbYn1wUpT6bSFpjePqZgw/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coqJMrBLSVlyYomoj08zUQx+rIVlaKWAofBhboH4tgc=;
 b=A2nPcTGrcQPzRiEEWFI6ZEpOkj1ITiFF/69MsGUw6ftSE1o0IJtLxz3CCjjV2I1MwIdy2BwkOJlk9SfxHIitqT0cllZJ01Jhr7np2ppg/FUt4iMRteho0bV6RHk/8m8vit6hKVirpzxi7bNW8v6GzpMKMJO6Qe40hLukA3SaAhZyc+iU+BtaxXi/+Yc3z+HOiycmR0oColK88ygy7R4AgP9dwbjD+Gu7t/uWRcMMz/XQ/O9hfLSmKG93AGAGBCQcHNBYCb9cTzjLMtpwawa6pp1DuiYgCWKFSpHn2eg1YTso6Qnadb0ur8RXsIJE/R6s7MQnWdUlue5X+hdXQA5w4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coqJMrBLSVlyYomoj08zUQx+rIVlaKWAofBhboH4tgc=;
 b=rmA1fkE7S467QUwn9YZivkFBmkkefUAI+0JqP+uJ7PeMkUlSp+sm22bv/ztgTpeY7iq7iilchcsgeNtJsIK5p7jje8Ayj8/OH9XDuUcPZdghec+EijtiDrwlUpIP89qiu9RHZtdveM/PFWZLrlwCFXaf58C8VZPVF5/+Ax4z3TI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5247.namprd12.prod.outlook.com (2603:10b6:5:39b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13; Thu, 6 Jan
 2022 20:51:00 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ccd7:e520:c726:d0b]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ccd7:e520:c726:d0b%5]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 20:51:00 +0000
Subject: Re: [PATCH v8 13/40] x86/kernel: Make the bss.decrypted section
 shared in RMP table
To:     Venu Busireddy <venu.busireddy@oracle.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-14-brijesh.singh@amd.com> <YdSKQKSTS83cRzGZ@dt>
 <18eadf9d-8e31-0945-ccf4-2cb72b8e0dd4@amd.com>
 <acba0832-9b11-c93d-7903-fff33f740605@intel.com>
 <444b6c78-c4d3-f49c-6579-bd28ae32ca3c@amd.com> <YdcpnHrRoJJFWWel@dt>
 <bf226dc6-4aef-b7c2-342d-0167362272ea@amd.com> <YddODkUvhbWbhS3/@dt>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <4c1067c7-a85f-79fe-38a8-2f68a94a358a@amd.com>
Date:   Thu, 6 Jan 2022 14:50:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YddODkUvhbWbhS3/@dt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:610:b0::11) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2232576a-d440-4832-8c11-08d9d1563f0f
X-MS-TrafficTypeDiagnostic: DM4PR12MB5247:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5247DC4B111E321E9C38117FEC4C9@DM4PR12MB5247.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mO9bNiWihNDXTZqksmJyqityQPTcW9e4xHIta8DetpEUC9zyg0RtfPgeYH6OE1v0wO2no2aXoP9lc2Q6m4Wup3l22QOWNWXVxmdOBYvggwlENpClh9CkWvqQJLl/TT3qtG9Net/NbbuaDdMXOdetmkagPpRr0GOLqNEE0qQ8d85clPblLHqyRGc+1cbgTYTkRFIjP0bJcC3omg+aGQ4DfQf3yPWeElhdTfIHGaN1LlAKJuf2vXoYBCh3T4TlcQbgQOWobtAtCjHhAylJpFgelvCAB/d74RCC6AE9h/kiY3DnoZBQQVRTqqqgWdfm+LEAyZJWZ5no1CYqd955g6OUAEI+2ogNu4xr9VnjpmNUYHwHovQcpwe/5otDU5pkbB8bF4NucFNzgLM+g6fIohs3E6saL+DJ30RUkvwYEmcOAwycOmaUyXSKubQ0a+uabotgtkbiN+dG6/MFi222w9sWrjE/z24eVojKawSTTpZkLMiNjVodq+LREeoPhXt57KJAp8vvQV3WZhMTtafDwRbcrFont+MAXge0NJz+hKCAmneDkAFa8nM3tBJp10zBwMu5YSi96/0nInJaRbPvSSRg7HTICxY4qvnXiG+nJzp0xri03Z713vdIEAHlHygJRPrezcphBkX8X1c7LVNzas+5+xXpwTZBFHtPrXZa43ToDk7HY6eN8YwET6Ak/ycEGKpAvDJe18Si83Tq725wEQCo39TOIeIfD9HMWNp0F0dwjDh6AyY87pPttITJho4Md1se
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(38100700002)(8676002)(186003)(4326008)(5660300002)(86362001)(6512007)(2616005)(8936002)(54906003)(66946007)(36756003)(31696002)(83380400001)(6916009)(26005)(53546011)(316002)(31686004)(66556008)(7406005)(7416002)(508600001)(6666004)(66476007)(6486002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVVybjRlVENtRHMzL1ZzdWIrRVFMRjlBOGpyOVVJNXVQVEZHTFlDbXl0NW9i?=
 =?utf-8?B?ZnhlL1FlL0lrNUdqWGlqdnVid1VCRFc5aFdFVTJvZmpKenBlTEN0QzdGUUZZ?=
 =?utf-8?B?YTk2bjAxelBXbS9hK2k2YnE3ZmJiRVZFR2pYVjA3WXF1WksxaDh6SW1BeHlK?=
 =?utf-8?B?VllDSkZBaUw3YVpBRVJzOW0zdi9jaXBhcE5zNUZRcTd4TXdPd0Q2WnVPclBS?=
 =?utf-8?B?RXZSU2hiZ2NQMkRldGpkVitZWkVNVk1oWVh5djcvYzBIQ3A3c1RrZkIwUWpy?=
 =?utf-8?B?MGZSeGdOU0dGbWdpbTdyTEhRdWpzbTRUV25PZ0dCdkczZTBoN2ZRS0YrdGJj?=
 =?utf-8?B?WmRVV05HeVdOc2FkNi9HbzR6ZkRzdWJndWUrUWJRc1hzd01NUHVMeTBjU2p6?=
 =?utf-8?B?YmJIUjVhNWV2SW8wSVBqY2VrMEJNaEtpVHYxMTN6RENkRC9mQXUvL2J5UzdK?=
 =?utf-8?B?N25GaUlqZ21FYi9BOTQyN1B0alNJcXZoK1Fpd05Ma2FZK1ZlSU9lSCs3YkFW?=
 =?utf-8?B?SFdTYlExYTlhSDhZK3M1NGlENDB6Q0tmcDFtUjVEWDJLbFdqaUk0SjNKMllJ?=
 =?utf-8?B?cmViM1FpMTdRL0QvM3craFM0d1lLcW4wcXJrQWtOMDVYT2RER3hpOHJxcXhF?=
 =?utf-8?B?SExIRExkVGZvTExsRCtac2h1YkdSbkZLcHNnY2dhdWlqNGJRTlNwRStaV3F3?=
 =?utf-8?B?alJJNFZyOUpQdlBzaSt3Slc1aXNOY3JFRzVodlJNdDVJdVJSdTBNNjJhdVNo?=
 =?utf-8?B?N3grYmNJa2xNblNuYlQvRkI3OHNIMGQ5VzYycXcxcmlNc0IwUVFvNEJSKzRh?=
 =?utf-8?B?YTcxdXVKR01RS1dwcDdnQVZ2NlM2YzZTM2xRSzZMYnNvcTN3SkhoTHNGbnFs?=
 =?utf-8?B?Y0tIclBIbzRtZms3SHZldkVVSXM2NEp1Sm9SSzVQL3kvRnRRVExKZ2tidEdw?=
 =?utf-8?B?UzhsbDhIbUtseDc5NWEvRTRlKy9lRjd0TDV5bzVmRDlvQ3d6NUFNcWpBZjRV?=
 =?utf-8?B?bm9jMWlXaEZxVVRGR0p1bE5DOEZlWldFaGFBSnRJUnhPSFZzbTYvN0QrdVo4?=
 =?utf-8?B?b3VyQktpNW1hTmZHU0dNaDRPa3RqM0w0VWU0dVI5THNxd3BHanBJcXNHRGtn?=
 =?utf-8?B?RTUxVGp4WXJNeUV4UllnbnFTUGhRdkxvUVhBMVJVV1ZKTDUrOXNuRnd4SmdL?=
 =?utf-8?B?bVRhbWJsbVgwVlV4TWRSL0JSRW4vZTcwKzZUaWV5WTdjR0ZPQnBXL2dTOW5s?=
 =?utf-8?B?cVAwelFNcFFFVkhCczNPT3NRbUVwaFJXQ0xFY09jVThvR1VRcWhWbzZNamlP?=
 =?utf-8?B?Mi9OY1AzbWpUSHFMek9US2JHNzNIS3dUeCtiSlMzazVCZDF2WitucEt4d3FR?=
 =?utf-8?B?bE5KRmI1NFRoYlhDYU9aOURwVk5jcGJWQTJkQXFlWUxhcys5enpPVVYrS1p0?=
 =?utf-8?B?cUpCRGpnOW1VOGxDczJtVjdUejNETGVPSS9DMjNuQkpkTVpIMisyUTRXSTFm?=
 =?utf-8?B?ZFIxdGZRR2JYeWlKd0JqNTVZRU9uMHF4R0NZT0YyOVVzSlJOaDVrMnRDekx2?=
 =?utf-8?B?T2hKSEJIdGxQWGF5SEIyakY5bElLNGdKTmlaczN2akRiYkRZYU8rbi9qKzIr?=
 =?utf-8?B?bXVBVVVqWWJRd2t6Mm8ySjFYL2dVSG9zbGZHOG5oRDQvL3F1emEyNU1ESkxL?=
 =?utf-8?B?S0FUWFZ1eVdUenpNVk9ua2VEQ2pvVnl6WW1mejRZUnpwekhxZ1FKTVVJK1pz?=
 =?utf-8?B?YnRkV2g1RnFBcGI1VTVhK2FySlRTUnFxZDBVbzgvSXlaRk91bVdudkQxTURF?=
 =?utf-8?B?ZEJGeStBSVRldE11U0FtY3hhU3JNWkpzVUNocnNHQlpSM3F6c05Sd0pNTjZT?=
 =?utf-8?B?NndxLzlzbE1UR0tRVThac1JJUDg2bWRKYmlCak16M29rYlYyTTllN2E0ODY2?=
 =?utf-8?B?NlJ6SjcvR1lSalArZWx5N1ZSb3dWaGkxekZySWVwb2JWNWxxcWIwaFlYalVT?=
 =?utf-8?B?L0JsWTVpcmplSy84QjVLcllKbFpjb1Q5TG9aZjRZQWNaTEdaUXF4YmJGditT?=
 =?utf-8?B?MzZwampLdFdaQ016cVlZdUV4eU9aUFlvazNhaXBDUjczK2U0bThiTEN3L0Fm?=
 =?utf-8?B?WDdNbFAveitXRUQxMGcyNGZsRGtGeHdjOU51TVBURzgrbWpEcTRTQlFnTXVY?=
 =?utf-8?Q?SihKnaCAJULa09ALyTGvpy4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2232576a-d440-4832-8c11-08d9d1563f0f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 20:51:00.6730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26eYZljRejg1wzq2R1hYQDqrfTLxj89YZ4DWrUINsD7c0lE4KCi8XpCFyB/aI3NyX51yiUXKcWCjYgVAKorbIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5247
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 1/6/22 2:16 PM, Venu Busireddy wrote:
> On 2022-01-06 13:06:13 -0600, Tom Lendacky wrote:
>> On 1/6/22 11:40 AM, Venu Busireddy wrote:
>>> On 2022-01-05 15:39:22 -0600, Brijesh Singh wrote:
>>>>
>>>>
>>>> On 1/5/22 2:27 PM, Dave Hansen wrote:
>>>>> On 1/5/22 11:52, Brijesh Singh wrote:
>>>>>>>>             for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
>>>>>>>> +            /*
>>>>>>>> +             * When SEV-SNP is active then transition the
>>>>>>>> page to shared in the RMP
>>>>>>>> +             * table so that it is consistent with the page
>>>>>>>> table attribute change.
>>>>>>>> +             */
>>>>>>>> +            early_snp_set_memory_shared(__pa(vaddr),
>>>>>>>> __pa(vaddr), PTRS_PER_PMD);
>>>>>>>
>>>>>>> Shouldn't the first argument be vaddr as below?
>>>>>>
>>>>>> Nope, sme_postprocess_startup() is called while we are fixing the
>>>>>> initial page table and running with identity mapping (so va == pa).
>>>>>
>>>>> I'm not sure I've ever seen a line of code that wanted a comment so badly.
>>>>
>>>> The early_snp_set_memory_shared() call the PVALIDATE instruction to clear
>>>> the validated bit from the BSS region. The PVALIDATE instruction needs a
>>>> virtual address, so we need to use the identity mapped virtual address so
>>>> that PVALIDATE can clear the validated bit. I will add more comments to
>>>> clarify it.
>>>
>>> Looking forward to see your final comments explaining this. I can't
>>> still follow why, when PVALIDATE needs the virtual address, we are doing
>>> a __pa() on the vaddr.
>>
>> It's because of the phase of booting that the kernel is in. At this point,
>> the kernel is running in identity mapped mode (VA == PA). The
>> __start_bss_decrypted address is a regular kernel address, e.g. for the
>> kernel I'm on it is 0xffffffffa7600000. Since the PVALIDATE instruction
>> requires a valid virtual address, the code needs to perform a __pa() against
>> __start_bss_decrypted to get the identity mapped virtual address that is
>> currently in place.
> 
> Perhaps  my confusion stems from the fact that __pa(x) is defined either
> as "((unsigned long ) (x))" (for the cases where paddr and vaddr are
> same), or as "__phys_addr((unsigned long )(x))", where a vaddr needs to
> be converted to a paddr. If the paddr and vaddr are same in our case,
> what exactly is the _pa(vaddr) doing to the vaddr?

But they are not the same and the head64.c file is compiled without 
defining a value for __pa(), so __pa() is __phys_addr((unsigned long)(x)). 
The virtual address value of __start_bss_decrypted, for me, is 
0xffffffffa7600000, and that does not equal the physical address (take a 
look at your /proc/kallsyms). However, since the code is running identity 
mapped and with a page table without kernel virtual addresses, it cannot 
use that value. It needs to convert that value to the identity mapped 
virtual address and that is done using __pa(). Only after using __pa() on 
__start_bss_decrypted, do you get a virtual address that maps to and is 
equal to the physical address.

You may want to step through the boot code using KVM to see what the 
environment is and why things are done the way they are.

Thanks,
Tom

> 
> Venu
> 
