Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13843C5F92
	for <lists+linux-efi@lfdr.de>; Mon, 12 Jul 2021 17:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbhGLPqo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Jul 2021 11:46:44 -0400
Received: from mail-dm6nam11on2071.outbound.protection.outlook.com ([40.107.223.71]:63798
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233648AbhGLPqn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 12 Jul 2021 11:46:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYaiNzuehDezsAchzqllv2y3Bghwmnqz6zFgMajQMebjYD800RaZINqO8cAGzNwJXJ7G7StG0R3epFfOnlIytXkFRlu7BJhT/Fc+txLC7GwJoA1li4HMG4FAldphMUkzlkoiFyBnH47gR+/ddN3SDFtwkjOgLHx/DlFaWuSUExyxEMg99F9IPn1jkhs/GdhU4Dm900+60BLTfz/rNVsvstUqfVwiainwxuJrbLuD7IOdmeh3qGbg5DFc6nc/lBqME/4CwR81E+P6FbUbrFIqWMQXEqQpOc7UQrA23ft2wOstD1yEjpWD9otbML2PJWhGYQqaKywG9Ea0YyBQ4mcnrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhZMqfmdvvHgDadJ5qKwIEnnwTxAFLEDjplxDEWClgo=;
 b=j9RAp+IKQNprN1h6eoZQzZOLd01T4ixnlj4ddqqC9Il+laKhVc3p2klsJpUUz66m0C7Xk2b6N0WHdATYqG1T8kwFIAGtlf9vNl/FvaVmCpKuo4zdrDn/xJkOqrChC0RpclVydFh/lO3VLiwMmrc49nEhCfb0A0jfN8uSA9+YSdZ++cGCVmZ9wLmtb3pvZMlbN43l1V7MTPuqYD5oIHJtYq//XOsMpGUh3jDgu01GIaKZZyaBvwFWdeipR/tR+gVwiBF8wGAcbcBf8mUZIKbh3tmEmCpbnp0P0vgDZloarXBPlikpjKZBeanFeF/9vAe35QBJ+E6LG7L21jORYo2cNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhZMqfmdvvHgDadJ5qKwIEnnwTxAFLEDjplxDEWClgo=;
 b=5ShUy4gAS5Jylbm+g0UdvaH/CywZrKyAPc5trGrp6WSijHNTHrUdQNvD4RtrC32RidNB5eHN+qYbOAdYCORGjKOdTdGgbWP3X0qsISqOL5fI4J479qEhpHxyk0feU4oJT02P8/+tq7KJOH/VujsCp5l7U0o5fXzmbtgFGfY6x88=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB4672.namprd12.prod.outlook.com (2603:10b6:805:12::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Mon, 12 Jul
 2021 15:43:52 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 15:43:52 +0000
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
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <2b4accb6-b68e-02d3-6fed-975f90558099@amd.com>
Date:   Mon, 12 Jul 2021 10:43:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <3c6b6fc4-05b2-8d18-2eb8-1bd1a965c632@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0152.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SA0PR11CA0152.namprd11.prod.outlook.com (2603:10b6:806:1bb::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Mon, 12 Jul 2021 15:43:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c880322d-f5c8-40b8-a976-08d9454bd962
X-MS-TrafficTypeDiagnostic: SN6PR12MB4672:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB467203570B027D0CC7C3436CE5159@SN6PR12MB4672.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v/6jgsvITKYPdR3twnWbnMUit7aFF08L8l6jsHw2OAXAA5qTaRSPdnVW3L8p2A/7N6GCPDRWvCfXSCTd2r5OTXVX7MYZiKUTddl5qJXcqIidzx/VK82Q87ZUlH9RfPxlL6dm/XWCA2crBgDv0SQF6eC1EPlt0sCmEyqTblgxBmQaFiLOGquwvOog6dl1pHwppPFvWEjE79QOHuK//r717XaPCkcZkTZszwoOkN+D0cwsBjQIML2oGjf/25FmzjHpORRDs92TMtI2GaroYGdlv0j6AFRMSdAwX3luMuIz+88s7BTGH9FwKW1fnt/ZU/YPFdhipaiMQBO8joJymn0+pmXL6qWOcAwAgp/47wGqFxto+hjFNr9VwlRBxWvTM0whpwgFPhdpRB25XkTyZqUkJAeAXpBPONj02AxvNhtsfxCxeDs11v3Cmzp5ss/BOGONvhsjvbe0mSsqYm+kYMgz7rEztzGWNhfmc38ILmTcOGVHAmUAYhf0zvPMdgiP+jLe1HK5Sb9YW/2whwAek/la7KRiZ/TtqQPrbdOJAlUFw0DJM9VAuIXflljjWxH9ylN9BivjWTJHYb8AYLaRblQA6z74QaQnvtAt8f9on/F1Mk1INU7c2C8JzwnYvdOR4P+x7f93BmgpUBfT3bvmYIz9xDOG8PiWoxTJwdP4DLkcgz2duvbO8JScH9w8y2m6SeQAd9cszVNWz6OjzNBruJmlK0SuF46v2oXDrjSA5neduWl131k56n/NVcuqJL3IZMnxEuB2nC1ImjZ5zvJzCmZvNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(53546011)(86362001)(2906002)(52116002)(31696002)(44832011)(956004)(2616005)(478600001)(8936002)(16576012)(8676002)(316002)(54906003)(4326008)(7416002)(7406005)(6486002)(38350700002)(26005)(186003)(31686004)(36756003)(66556008)(66476007)(38100700002)(66946007)(5660300002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUxoQytoVTlXOGRhUlVGazhMSzJaOGhXRjVQK3cyejBJR0tDdWx0dkFyL3Vz?=
 =?utf-8?B?L0FBYjUxbnN5OURlQlhLdjJOendnclpnZHlMNUVFbEM2S0dTOVBDUUd6QlpN?=
 =?utf-8?B?WDJ5Nk9MWkg5cjVaa1RQVWRLRjZ6MUtSYkgxUTVlRWZxait2R0tERkJ6Y2sx?=
 =?utf-8?B?cmhBQUJsT3hmbkZzV3Y5a2FPMmEweUpYc2x4Ty9uREJpSnZqdWRUNjA0dExN?=
 =?utf-8?B?RitiV2xCZHJoZjBLZm5JckUzNS81aDU4RERqajJPdHhLNTQwMGc4SjRiYkZO?=
 =?utf-8?B?NDNxdFFqQ3dPZzZlMEpCaHE4Slh1SDNsbG9mbWtHUHNIa1FDYkdXUVI0LzF2?=
 =?utf-8?B?QkpJU1V0aVRvUWNuRWE3Q0MybkNVWkp6Wjlwd2Jvd3ZHMFJBcUxraktsd2JF?=
 =?utf-8?B?b0QrS1VScmU0WVJvSFN4Zmg3eTlUb1dtQm1wRWQvNitTMUNFUm42eEpZWUFI?=
 =?utf-8?B?QTRlVW1TQjcwV3FwbkJGVDJIUy9HQXRsbnpodDYzQ3BWc3NDRDR6Y3lzd2l4?=
 =?utf-8?B?VWd5d1U1aHdybFp0dllPdm9yRkxwRTZpU1RFbU42V0hPSTFQUFlPRHMrRlVZ?=
 =?utf-8?B?b0hVV3RVcHNOcXNKNVBXMnpUd05KZ2JSb0M0ZWtIZ0RVcnZPVHZ4UUx6WHgw?=
 =?utf-8?B?T3FHS2JOOGZjbnA5YWpRVVVqZVV5KzhmMExmY3JTZ2kxZkQ5MmxZT1ROelJu?=
 =?utf-8?B?cmducnJKQzFrUnBEOUFDSVQ4SUdoM2p6VGFoVmVSeXlYVE5sL2Z1U2ZVNVNN?=
 =?utf-8?B?dEY3OFczSDQzMVdTbXc5LzBwRUYyWjhYMU1PVi85NG5Ic2RPSThRR29qQzh6?=
 =?utf-8?B?eTQ0YW85OG9WSHhEVmtUalBiUWZDRjZUcTFBZzIrVzJka2U4VWp5bURiN2xF?=
 =?utf-8?B?eVhnUEIvbFFSa1hBSHZ4MlY4MXRqRmw3UW5UaVRvdWkzbEI5N1NoNDJTaFlq?=
 =?utf-8?B?SXMvbUxrcWU4bnV5d3RhVHAzMjdlV1lRbjZCTU50eTc1eHVqZGpHczZzREdo?=
 =?utf-8?B?NmJLZlVleFc2Mm96QXAvZzRkbUVCWUUzTTc4Ny9NaDF2T29vT3ZXYk1aZjI5?=
 =?utf-8?B?VHh5VVdHdnRla0IzbWMrVGFIVW9XTkJhUXl3WFhnQU9TcFNQZ21xUldFeVBr?=
 =?utf-8?B?VExsZGxyZmd5Z2F3WGowcWdqYXFMNUhtdzhQcEFVZWlqalpQRVdmcVpCa3Jl?=
 =?utf-8?B?QnFLYW1ON3Y0bzVSNU1NbEFJUlBFMGpsZmJKYkoxWCt0Z2cwR1ZacW05LzVZ?=
 =?utf-8?B?VjNpNnZJL0RpUUp0MFNqejFneHRQMGxSblFhd0ZWUUFzRmh1ZG9JVWE0b080?=
 =?utf-8?B?Z09oMVBsWHVVbEREMHQ3SDlPaFBrOGltK05sd3VYcFhZUWpBV3FSWDB2UWVF?=
 =?utf-8?B?MGdWU1ZLc1hxZ2JtNWx0Q09uOWFmZnR4bWRCMThuYXpnM2Y3Z01MdGp3cjlh?=
 =?utf-8?B?Tk41a1ZXSGUwVGNjb2I0c0dyY2FIaFRBWlQ5WEFxdENhRE03ZTRvM2dDcjM5?=
 =?utf-8?B?bTc0cjY1cnNoblNhK3BjME9rd1Nyd2o0UXVjanFIOGNKZE10bjB5K01wY2hu?=
 =?utf-8?B?dmxaYlJ4QjdtMWNabzM2aFRCQnYvd3VSUWlBMlgwdGtmRFNrZzc2YUJUTUJp?=
 =?utf-8?B?N2lnVDdCWWZkY2xHY3dneFpkbXgzUUI4VS9XLzJmTzAxUkQvRHpPNnAzSjlD?=
 =?utf-8?B?N0dUOVZoVUpQdTEydzQyemRvakNLdkYweVhxbzMyeE91QVlEUTl4M2dQRTFR?=
 =?utf-8?Q?RxDpm3tkCEE2sX9+yBNtW+jI7LRiRwY1aH+YoXK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c880322d-f5c8-40b8-a976-08d9454bd962
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 15:43:52.5009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5LYYdAmnYwMfFC4OvFg1fqq3rot/HaaJTml/FxvV60f7wS4Z8sHD26yOVMzZaUnSrAurkK6n5zVjjJrQviMAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4672
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Dave,


On 7/8/21 11:16 AM, Dave Hansen wrote:
> 
> "SIGBUG"?

Its typo, it should be SIGBUS

>> +
>> +	if (unlikely(!cpu_feature_enabled(X86_FEATURE_SEV_SNP)))
>> +		return RMP_FAULT_KILL;
> 
> Shouldn't this be a WARN_ON_ONCE()?  How can we get RMP faults without
> SEV-SNP?

Yes, we should *not* get RMP fault if SEV-SNP is not enabled. I can use 
the WARN_ON_ONCE().


> 
>> +	/* Get the native page level */
>> +	pte = lookup_address_in_mm(current->mm, address, &level);
>> +	if (unlikely(!pte))
>> +		return RMP_FAULT_KILL;
> 
> What would this mean?  There was an RMP fault on a non-present page?
> How could that happen?  What if there was a race between an unmapping
> event and the RMP fault delivery?

We should not have RMP fault for non-present pages. But you have a good 
point that there maybe a race between the unmap event and RMP fault. 
Instead of terminating the process we should simply retry.


> 
>> +	pfn = pte_pfn(*pte);
>> +	if (level > PG_LEVEL_4K) {
>> +		mask = pages_per_hpage(level) - pages_per_hpage(level - 1);
>> +		pfn |= (address >> PAGE_SHIFT) & mask;
>> +	}
> 
> This looks inherently racy.  What happens if there are two parallel RMP
> faults on the same 2M page.  One of them splits the page tables, the
> other gets a fault for an already-split page table.
>  > Is that handled here somehow?

Yes, in this particular case we simply retry and hardware should 
re-evaluate the page level and take the corrective action.


> 
>> +	/* Get the page level from the RMP entry. */
>> +	e = snp_lookup_page_in_rmptable(pfn_to_page(pfn), &rmp_level);
>> +	if (!e)
>> +		return RMP_FAULT_KILL;
> 
> The snp_lookup_page_in_rmptable() failure cases looks WARN-worthly.
> Either you're doing a lookup for something not *IN* the RMP table, or
> you don't support SEV-SNP, in which case you shouldn't be in this code
> in the first place.

Noted.

> 
>> +	/*
>> +	 * Check if the RMP violation is due to the guest private page access.
>> +	 * We can not resolve this RMP fault, ask to kill the guest.
>> +	 */
>> +	if (rmpentry_assigned(e))
>> +		return RMP_FAULT_KILL;
> 
> No "We's", please.  Speak in imperative voice.

Noted.

> 
>> +	/*
>> +	 * The backing page level is higher than the RMP page level, request
>> +	 * to split the page.
>> +	 */
>> +	if (level > rmp_level)
>> +		return RMP_FAULT_PAGE_SPLIT;
> 
> This can theoretically trigger on a hugetlbfs page.  Right?
> 

Yes, theoretically.

In the current implementation, the VMM is enlightened to not use the 
hugetlbfs for backing page when creating the SEV-SNP guests.


> I thought I asked about this before... more below...
> 
>> +	return RMP_FAULT_RETRY;
>> +}
>> +
>>   /*
>>    * Handle faults in the user portion of the address space.  Nothing in here
>>    * should check X86_PF_USER without a specific justification: for almost
>> @@ -1298,6 +1350,7 @@ void do_user_addr_fault(struct pt_regs *regs,
>>   	struct task_struct *tsk;
>>   	struct mm_struct *mm;
>>   	vm_fault_t fault;
>> +	int ret;
>>   	unsigned int flags = FAULT_FLAG_DEFAULT;
>>   
>>   	tsk = current;
>> @@ -1378,6 +1431,22 @@ void
> (struct pt_regs *regs,
>>   	if (error_code & X86_PF_INSTR)
>>   		flags |= FAULT_FLAG_INSTRUCTION;
>>   
>> +	/*
>> +	 * If its an RMP violation, try resolving it.
>> +	 */
>> +	if (error_code & X86_PF_RMP) {
>> +		ret = handle_user_rmp_page_fault(error_code, address);
>> +		if (ret == RMP_FAULT_PAGE_SPLIT) {
>> +			flags |= FAULT_FLAG_PAGE_SPLIT;
>> +		} else if (ret == RMP_FAULT_KILL) {
>> +			fault |= VM_FAULT_SIGBUS;
>> +			do_sigbus(regs, error_code, address, fault);
>> +			return;
>> +		} else {
>> +			return;
>> +		}
>> +	}
> 
> Why not just have handle_user_rmp_page_fault() return a VM_FAULT_* code
> directly?
> 

I don't have any strong reason against it. In next rev, I can update to 
use the VM_FAULT_* code and call the do_sigbus() etc.

> I also suspect you can just set VM_FAULT_SIGBUS and let the do_sigbus()
> call later on in the function do its work.
>>   
>> +static int handle_split_page_fault(struct vm_fault *vmf)
>> +{
>> +	if (!IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
>> +		return VM_FAULT_SIGBUS;
>> +
>> +	__split_huge_pmd(vmf->vma, vmf->pmd, vmf->address, false, NULL);
>> +	return 0;
>> +}
> 
> What will this do when you hand it a hugetlbfs page?
> 

VMM is updated to not use the hugetlbfs when creating SEV-SNP guests. 
So, we should not run into it.

-Brijesh
