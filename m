Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEB5475AE7
	for <lists+linux-efi@lfdr.de>; Wed, 15 Dec 2021 15:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243562AbhLOOnk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Dec 2021 09:43:40 -0500
Received: from mail-mw2nam10on2075.outbound.protection.outlook.com ([40.107.94.75]:9120
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243559AbhLOOna (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 15 Dec 2021 09:43:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rkvhhox/6nog0kpclCGcplqJoWazXdBtP08Q4gWVLcsvhDvX0YDBBj8+5qEzFRHNV4qRL6g5Iuz/d0HOnKAKPqBLtkmr9M6/3LcwUqenC+yIhwnhPadAi4PdpLMYubfS2MUuyd/C74pBS/5J6YzH7g6TZnesAXBlbjqGZco+8xND+PNzWuSpGdVB9ruvm4ugM1gccNKZFD+rzEvRBcjDYPbf0CIPKow1bKMPt9cW4LnDn/9o4aCbgzAHqppDBxjUaQOeY9fNRleTPI2CgV2RDh92ns7PYcI9t/iOFvkAIzO/MXVBOjTD1hLHu+YmrzedMP/h7cc0hRzqaxtES+2Zbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3v4e58583NXeUwQKK3/t33Rq6PdSQSzsnCsMzq5MXLk=;
 b=hC5YjvtfZdVoNMK035G9zMU7/AKoBHA1Jk7LDyHDe00Qf0AQi3pK5JrNK0U8DeWrHdEsd/kKenc14taAgZruCE6pOks1f2Yq4bUzSW+VaYoD0fmwvbwzGVy7m6xzyBMfZ6Ogm/7HMUqjCldyVNYakw6HnVt4H+uV/g8DJIPsF286EmR9akqfOm5baVIQbMbA267BlFmFGplUQKLsRM/AcRQn3kjfGax5KDYx1E9opf3+BO21idzt5Xni6QQ7PcFIEdS7UXxBtupP8jmpNtknhALtOXvZecoLaiNLVjBzbz5hMW4uXav6umrAdaWQ+jZ1IwiJmq8DxbCUfZPybasfJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3v4e58583NXeUwQKK3/t33Rq6PdSQSzsnCsMzq5MXLk=;
 b=tD7ovi8zrydRdep3WVRDpT18H7agcIWG+NklrICfmUvJsb4/F/VLQI+pXMZFQ2gdVvSINwXycRcsWOFsnIVIF02mtx77TP5fsCxDVCoM0+ikdrjPGGcs5epMGk5+EH+Fo1jaN4Lo8gNS762uYKGgPtGoicbYS5Gxiix7jpRfIUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 14:43:27 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a%3]) with mapi id 15.20.4734.028; Wed, 15 Dec 2021
 14:43:27 +0000
Subject: Re: [PATCH v8 01/40] x86/compressed/64: detect/setup SEV/SME features
 earlier in boot
To:     Venu Busireddy <venu.busireddy@oracle.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-2-brijesh.singh@amd.com> <YbeaX+FViak2mgHO@dt>
 <YbecS4Py2hAPBrTD@zn.tnic> <YbjYZtXlbRdUznUO@dt> <YbjsGHSUUwomjbpc@zn.tnic>
 <YbkzaiC31/DzO5Da@dt>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <b18655e3-3922-2b5d-0c35-1dcfef568e4d@amd.com>
Date:   Wed, 15 Dec 2021 08:43:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YbkzaiC31/DzO5Da@dt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:610:cd::32) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by CH0PR03CA0117.namprd03.prod.outlook.com (2603:10b6:610:cd::32) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 15 Dec 2021 14:43:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58073085-6048-4159-6fdd-08d9bfd940cf
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB524832735F6AD86703927CD2EC769@DM4PR12MB5248.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zfmq1QCpE6wk7mMhHEhr71eFSVsaTV4qACWS/83XlShmtsUce0HiNlIs02IEdr3N80togOh1rGVMPMD4eWvIhudcVJWgJPGQ2O0FXOgU2gUPTwoCZOSZipmzA9ULNQPcgw9QmKhQ7hjGV+v+LM4bd/WkJrl2IcYcFGHDqosV4AGUihNVrLzb1FLc4ddf4kbRdYSZi9j9vuZYDiePkU92H2FScAaHdNLcZZ2s2Z5i7hzYM4T5BncFTYo2aDW2u5uRoAsGlkSed4ejt2iHG/8hNUwqhwx8Q8xo0muEgXrINBYEHAhWvMjH/s5IoFAmyj252Da4kfMzmzyGC6YZJaXYzHq3zXjPL6MAITFBpP26wTBJRUKmOUL2b002Ql2u4SNqG3WQ8r7h4qASpmU49AFPZ2Zjr7prbsqNlBOpb8jMAgSz5szlEvRYCRxW+Iutqnf6rkp0UFwD3qvPjYfgxL9XATJM6VzBaotkxv+QXyxD7UNXenpy3K2ymuXRAdPss3oQVCfXdBv+RBpXI/V7vnYObDAkPAVk1mEajXWxkrGvHnMJp8dvacepCWiPZyPecljBoraE0AlszPNr8NSP81IFheV0D8auJs/AKm/mn42IVjGqc5AQwiB/0UoTi0U0PvV4ow7IbsxE0Iv9H9GYhmNSgPsUZyvtGsAQip/a+z2HYRl+1S/ZKN2gdARtPBHxfkwv6qPJpBYJJbuXuS7hB5KIWgxiN/y2QjPJZn8xc/gM/npxYrkoBY4xb+m6ytncJNqSZuGbuOFPyC5oXVxEMpXkI8Bv69ygcVzZ/2fPq3Ia4WmN1AfhKHBN2HaKQZh13FbG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(38100700002)(4001150100001)(86362001)(956004)(8936002)(36756003)(2616005)(83380400001)(31696002)(26005)(186003)(53546011)(508600001)(8676002)(54906003)(7406005)(4326008)(966005)(31686004)(316002)(110136005)(16576012)(66556008)(45080400002)(7416002)(66476007)(66946007)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTBVMlVxdWF6elZGVTZLWmFzZkRSaEVyaUlxMEZIaXVBTTNmTTBZUmdHa1lQ?=
 =?utf-8?B?WmJ0eUZrYnpmSkVNRFNiU0lySTd0SWtxV0ZaWWNPV2VzdGV4TWRWYlMyWXVw?=
 =?utf-8?B?c0F5ZFpicHRlSk1IU1lTa1JkdlA5OTk1MjFNU0RHREd6eTlpbFpyd0dld1ZF?=
 =?utf-8?B?cTYwODltZ25xN2I1d1V5eXh2WDkvOWdydUErRytXTytCZE1KNDEvTmxMMFVa?=
 =?utf-8?B?Z0Z5eURkZmk2a1RHWVdRSUZ5cVR2MW5KU0tuUnN5b0pRM0tQMVNxN2lTd0Fz?=
 =?utf-8?B?Y1JxbTh2ejhnM0VKWmx0MkplckhDOCs4REFOUWdJZ0MyczJIQk5hcFJ2ODJz?=
 =?utf-8?B?UndxdXMzRGR3ZjNwUUJ4cjRPM1NLMmZnM2xzY0x2cENxUnZEY1FxZ0NTRm5j?=
 =?utf-8?B?RXZVTEJtcW9jQjVuWFE3QTFHTCtZbE9uUTFxRVdmNHZCaFBWeHlMM3ozVCtM?=
 =?utf-8?B?Ukxqb0Q3WUJRSGd4d2draVVYemptRWtvZTZaSWxVS0V6U1pwZmRDQjg2cTgx?=
 =?utf-8?B?b05xVitqL2xLWURpV2E4eWY4MkdsNEh6Um82ZjVjR1l4U2tOQ1lHL0l0ek13?=
 =?utf-8?B?dGZRMlJ4KzJScEFNSXdzdkNZeXIrd0NvZ1Z6SHMzMFJLSEFUSUdwNXVpcnJn?=
 =?utf-8?B?dUhTZDJnbWZ2SUNNZ1ZkWkFReHc5dnJmajJWeHRic0VJaVdiNXJKaTNFSkRB?=
 =?utf-8?B?b2VObFFUczZsOWs2OG1JR2Mrbk5vMXBLdnJLenFueUdNWHJ0TnJmR0pqZFlp?=
 =?utf-8?B?TFkxZnZKTDZ5OXYzSjRiZVFPYmg4MDZoeGFkQ3R2QlFObU1Kd21HcTkxc2l6?=
 =?utf-8?B?RERmVTlXR0NsZ1NLMHA5QXc1UHBTdXFWT3FYN1ZnZ3A0Q01uV1RtOWJnOENU?=
 =?utf-8?B?N2cvczlJY2FiWThhNExaRkVESi8rQ0I0TFZQTDM3N1RJRXc0bU5MaEg3b3V6?=
 =?utf-8?B?ZStSRXE4Q1NhZ2MvUG1BczRsSk1qeElpRkpDY1cvM3lDNVhrTkJyRzg3MlVq?=
 =?utf-8?B?ZzN6ZjdLRC9MV3Q1SkRhK2RFK0VXU29MWHAya3hCbFY0WitjUE15OGNuRmtU?=
 =?utf-8?B?VDF0VzBWR3UwelU0M0swT0x2Z08xaXI0Z1hRTWwxZnUzWGtFOHJ1aWIvWFc2?=
 =?utf-8?B?OFoxNmFnWW9oZlh6Z1BibFpUWnVSQ0UvTTVUK0pLUTZ1UGdYVmEzNjN5enNI?=
 =?utf-8?B?eURnNEs1bllRZzl6d2Nmb2xJNDNsYytiMFFsVHg5aGNYSUJDcXBJbWVpQWg3?=
 =?utf-8?B?d1V2VEVQbmpKWllCdTFnUHJ2aEtldXhWeDlFWkJ5QmhxKzNNUktjVlFXbWdx?=
 =?utf-8?B?eDlYWmM1Z2RxZ1FMZWFnTHFaUFZyQi9yYlBEbXpiVFBTc042dk5wbGJuaTkx?=
 =?utf-8?B?NXNKbkYzY2d1SXZ2amN5MG1ackdvbVlDT0FXbDdqVy82Y2lWZTY0YmJmQW85?=
 =?utf-8?B?R1NGdkhCZENIK3BkaFJKdHFpTjA3c1VkL1R5YW5JVXBMbkpJVW42S0Zncllp?=
 =?utf-8?B?ak9nRVA4OE9MUHdkNm5wSkF2dzVMTE1KbTZTc2Z2RmlEUFd3VDZYYmhoakNF?=
 =?utf-8?B?MUNuQTNaK0dneVB0aXM2SHlyUi96ckhOcEp3OWg3R0ZjTmVkUWZuMGtQY3NK?=
 =?utf-8?B?Q0h0cGdJQVk4RlU5ckZUM29RYk05TUdDUWFSN2dHTWZMZHhRT2w3VFRkNTdt?=
 =?utf-8?B?ZDNJVHF0OHNUYTkvN0E4SU5JUE1wYUF1MmpxcE9CL29uMVFuZXZrYUhqYk8w?=
 =?utf-8?B?bjcvaGRraVJMbDBod3NCT0xHVlBVVnVobmdjem4rOVJUcGpoT0xRZDA1RGg3?=
 =?utf-8?B?aXJ4MDZmbTVEWXRSa2J6ZmFCZTVuR2FwWE5KWWkweFUzNCswRzRRNFZHZ1d2?=
 =?utf-8?B?N3VUcVYwMkRZU1c3K3EzZVlxQjlRb2c2U01tSUJtQnZ1SUZ5anpnR3lRWFNO?=
 =?utf-8?B?K25uWHhTbVdGbVYrem10bkEzWTlUNVQ2ZGRaQ0NQM0JlRTY0dUk2ZzYxUWlE?=
 =?utf-8?B?WitBcHJSZzFXS3BCZWkvODUwL01HUkNqZ1ZkNy8vVWN0Q09zNXRsMFROMmVC?=
 =?utf-8?B?L0lneFRnU1pnQ1BaMi84WUxiL0xTcEZ2anZFR3FRQk9zYmpHNkQzWFVUVzVH?=
 =?utf-8?B?dUZEQ2wwQ0RkSWQ4TXFWdG1xQU5ZSWx3TkJESm04YUFsbUp1anJadXdoNDZi?=
 =?utf-8?Q?yhpssnqioh6gdv7DYocImfU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58073085-6048-4159-6fdd-08d9bfd940cf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 14:43:27.5846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mkc/zvoRz9mVxccxjyEcIluOCULpoAq+07OmALBopd77N9Ebeb9zKIwKqT+NgpFFAQf3sFSOb1+wGgug3VQqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5248
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/14/21 6:14 PM, Venu Busireddy wrote:
> On 2021-12-14 20:10:16 +0100, Borislav Petkov wrote:
>> On Tue, Dec 14, 2021 at 11:46:14AM -0600, Venu Busireddy wrote:
>>> What I am suggesting should not have anything to do with the boot stage
>>> of the kernel.
>>
>> I know exactly what you're suggesting.
>>
>>> For example, both these functions call native_cpuid(), which is declared
>>> as an inline function. I am merely suggesting to do something similar
>>> to avoid the code duplication.
>>
>> Try it yourself. If you can come up with something halfway readable and
>> it builds, I'm willing to take a look.
> 
> Patch (to be applied on top of sev-snp-v8 branch of
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FAMDESE%2Flinux.git&amp;data=04%7C01%7Cthomas.lendacky%40amd.com%7Cbff83ee03b1147c39ea808d9bf5fe9d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637751240978266883%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=D8t%2FwXY%2FYIl8aJXN%2BU7%2Flubln8AbhtdgB0f4DCNWp4w%3D&amp;reserved=0) is attached at the end.
> 
> Here are a few things I did.
> 
> 1. Moved all the common code that existed at the begining of
>     sme_enable() and sev_enable() to an inline function named
>     get_pagetable_bit_pos().
> 2. sme_enable() was using AMD_SME_BIT and AMD_SEV_BIT, whereas
>     sev_enable() was dealing with raw bits. Moved those definitions to
>     sev.h, and changed sev_enable() to use those definitions.
> 3. Make consistent use of BIT_ULL.
> 
> Venu
> 
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index c2bf99522e5e..b44d6b37796e 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -291,6 +291,7 @@ static void enforce_vmpl0(void)
>   void sev_enable(struct boot_params *bp)
>   {
>   	unsigned int eax, ebx, ecx, edx;
> +	unsigned long pt_bit_pos;	/* Pagetable bit position */
>   	bool snp;
>   
>   	/*
> @@ -299,26 +300,8 @@ void sev_enable(struct boot_params *bp)
>   	 */
>   	snp = snp_init(bp);
>   
> -	/* Check for the SME/SEV support leaf */
> -	eax = 0x80000000;
> -	ecx = 0;
> -	native_cpuid(&eax, &ebx, &ecx, &edx);
> -	if (eax < 0x8000001f)
> -		return;
> -
> -	/*
> -	 * Check for the SME/SEV feature:
> -	 *   CPUID Fn8000_001F[EAX]
> -	 *   - Bit 0 - Secure Memory Encryption support
> -	 *   - Bit 1 - Secure Encrypted Virtualization support
> -	 *   CPUID Fn8000_001F[EBX]
> -	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
> -	 */
> -	eax = 0x8000001f;
> -	ecx = 0;
> -	native_cpuid(&eax, &ebx, &ecx, &edx);
> -	/* Check whether SEV is supported */
> -	if (!(eax & BIT(1))) {
> +	/* Get the pagetable bit position if SEV is supported */
> +	if ((get_pagetable_bit_pos(&pt_bit_pos, AMD_SEV_BIT)) < 0) {
>   		if (snp)
>   			error("SEV-SNP support indicated by CC blob, but not CPUID.");
>   		return;
> @@ -350,7 +333,7 @@ void sev_enable(struct boot_params *bp)
>   	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
>   		error("SEV-SNP supported indicated by CC blob, but not SEV status MSR.");
>   
> -	sme_me_mask = BIT_ULL(ebx & 0x3f);
> +	sme_me_mask = BIT_ULL(pt_bit_pos);
>   }
>   
>   /* Search for Confidential Computing blob in the EFI config table. */
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 2c5f12ae7d04..41b096f28d02 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -224,6 +224,43 @@ static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
>   	    : "memory");
>   }
>   
> +/*
> + * Returns the pagetable bit position in pt_bit_pos,
> + * iff the specified features are supported.
> + */
> +static inline int get_pagetable_bit_pos(unsigned long *pt_bit_pos,
> +					unsigned long features)

I'm not a fan of this name. You are specifically returning the encryption 
bit position but using a very generic name of get_pagetable_bit_pos() in a 
very common header file. Maybe something more like get_me_bit() and move 
the function to an existing SEV header file.

Also, this can probably just return an unsigned int that will be either 0 
or the bit position, right?  Then the check above can be for a zero value, 
e.g.:

	me_bit = get_me_bit();
	if (!me_bit) {

	...

	sme_me_mask = BIT_ULL(me_bit);

That should work below, too, but you'll need to verify that.

> +{
> +	unsigned int eax, ebx, ecx, edx;
> +
> +	/* Check for the SME/SEV support leaf */
> +	eax = 0x80000000;
> +	ecx = 0;
> +	native_cpuid(&eax, &ebx, &ecx, &edx);
> +	if (eax < 0x8000001f)
> +		return -1;

This can then be:

		return 0;

> +
> +	eax = 0x8000001f;
> +	ecx = 0;
> +	native_cpuid(&eax, &ebx, &ecx, &edx);
> +
> +	/* Check whether the specified features are supported.
> +	 * SME/SEV features:
> +	 *   CPUID Fn8000_001F[EAX]
> +	 *   - Bit 0 - Secure Memory Encryption support
> +	 *   - Bit 1 - Secure Encrypted Virtualization support
> +	 */
> +	if (!(eax & features))
> +		return -1;

and this can be:

		return 0;

> +
> +	/*
> +	 *   CPUID Fn8000_001F[EBX]
> +	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
> +	 */
> +	*pt_bit_pos = (unsigned long)(ebx & 0x3f);

and this can be:

	return ebx & 0x3f;

> +	return 0;
> +}
> +
>   #define native_cpuid_reg(reg)					\
>   static inline unsigned int native_cpuid_##reg(unsigned int op)	\
>   {								\
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 7a5934af9d47..1a2344362ec6 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -17,6 +17,9 @@
>   #define GHCB_PROTOCOL_MAX	2ULL
>   #define GHCB_DEFAULT_USAGE	0ULL
>   
> +#define AMD_SME_BIT		BIT(0)
> +#define AMD_SEV_BIT		BIT(1)
> +

Maybe this is where that new static inline function should go...

>   #define	VMGEXIT()			{ asm volatile("rep; vmmcall\n\r"); }
>   
>   enum es_result {
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index 2f723e106ed3..1ef50e969efd 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -508,38 +508,18 @@ void __init sme_enable(struct boot_params *bp)
>   	unsigned long feature_mask;
>   	bool active_by_default;
>   	unsigned long me_mask;
> +	unsigned long pt_bit_pos;	/* Pagetable bit position */

unsigned int and me_bit or me_bit_pos.

Thanks,
Tom

>   	char buffer[16];
>   	bool snp;
>   	u64 msr;
>   
>   	snp = snp_init(bp);
>   
> -	/* Check for the SME/SEV support leaf */
> -	eax = 0x80000000;
> -	ecx = 0;
> -	native_cpuid(&eax, &ebx, &ecx, &edx);
> -	if (eax < 0x8000001f)
> +	/* Get the pagetable bit position if SEV or SME are supported */
> +	if ((get_pagetable_bit_pos(&pt_bit_pos, AMD_SEV_BIT | AMD_SME_BIT)) < 0)
>   		return;
>   
> -#define AMD_SME_BIT	BIT(0)
> -#define AMD_SEV_BIT	BIT(1)
> -
> -	/*
> -	 * Check for the SME/SEV feature:
> -	 *   CPUID Fn8000_001F[EAX]
> -	 *   - Bit 0 - Secure Memory Encryption support
> -	 *   - Bit 1 - Secure Encrypted Virtualization support
> -	 *   CPUID Fn8000_001F[EBX]
> -	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
> -	 */
> -	eax = 0x8000001f;
> -	ecx = 0;
> -	native_cpuid(&eax, &ebx, &ecx, &edx);
> -	/* Check whether SEV or SME is supported */
> -	if (!(eax & (AMD_SEV_BIT | AMD_SME_BIT)))
> -		return;
> -
> -	me_mask = 1UL << (ebx & 0x3f);
> +	me_mask = BIT_ULL(pt_bit_pos);
>   
>   	/* Check the SEV MSR whether SEV or SME is enabled */
>   	sev_status   = __rdmsr(MSR_AMD64_SEV);
> 
