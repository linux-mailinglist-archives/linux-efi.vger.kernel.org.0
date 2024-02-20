Return-Path: <linux-efi+bounces-598-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4110485C452
	for <lists+linux-efi@lfdr.de>; Tue, 20 Feb 2024 20:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E3E1C2412F
	for <lists+linux-efi@lfdr.de>; Tue, 20 Feb 2024 19:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7D313473D;
	Tue, 20 Feb 2024 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QlX6fLE5"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E53912F5BF;
	Tue, 20 Feb 2024 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456186; cv=fail; b=GPNkQmJpfCnXhpe73n0/tW28zTz4xa74oVX8Li/41iWRZAWlfR9pKIO63Wa8/egNdNOmOs+H5FE82GBoJA9jKE6UpihdjUlt+CcgMuGUjQp7+f4bRUVtyGbzCfpQLu/cUj8NYdFC8RirzBrpRNHdATznT6UEfCQO2udnOadu2V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456186; c=relaxed/simple;
	bh=7XIFN4NS7TQ7hfu4JTpLGwTa1MkcAF731IY0mKtkPDA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iVHAUcyxLPjOgF2fPZosjqVMF+EkydwFWUk6xdk+ucr9l6qgPo7DY3vcX8KAiBOjukzfP7ySoh1PeiwX7HRi0nloFCb4IbGatbC9mXwaC2cHNvvIaEjlU6ZCzw8m0FdjvWwYsJKyvuUJNUGw5h8x3x+tlFsGiQBN4YwXPQuif34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QlX6fLE5; arc=fail smtp.client-ip=40.107.102.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONdr0biyzddykYZDghS1WQHk837ADsyJp5l5Hqy46F/vjTklgt97WQf05sVcTvOqcZokEyzRwFeDU5J9q23Zqp+DXMtD/PKkz4dxLdMBO4xWg9e6/CAZ32It6UM6detT0jYWPcoNFQ5XZROiFHZsQCj+EmaTCULKZ0zTFXgSxDuzpjNePyWAmvXRisM0DkXmV9jzfXdn5UAP2iV0N2pZmqRyXQ3Y49tzXeFTFVqgalMUsEBLAsozMH9ajPPRjHNModqq8bu1hEJtbzKSn0DQ3GpJv3872zhbxWD8La1ml6Pegcjaf5mHTy7+KYs1I9XO4lZnTMlNLlKdMWSXzJYopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gelVehWMHiBg1MgbQlhCxB/yBfSxG/zn2lh33iBLVmU=;
 b=juZ3cKYH5nc4Bf7wL3r7i8mQ5WODbWtv3vSIj/PCRw/1L4py67A+oR2xu6OlFnwrDVNOWweN2RsRfUS15MnvLE6FUtQU/Q35/Hja0mTrYxkffWvi5RaX70QoFavUSIbWIg48lQpol2xq5DUWLZG96rk+eCP0WvLdNMf67tlOpPr+MXjxspQHucagTuhYO9iw8ulLurgdzxKUIageyl3kMN+n9falY+LxGjO9eqOoHIFxVIa39Uqps+rIF72U2vTBiv0airI8dX8ufUsZyicX0KO/QX2gHUrOm5QfyBpjK1PN+v1P47AWJ0YgfP6PzHaM7utMI8LZkXd3cneb5sif7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gelVehWMHiBg1MgbQlhCxB/yBfSxG/zn2lh33iBLVmU=;
 b=QlX6fLE5uRH/eT+QfL+l+DjW9gAZScVSxxorav/HoVJFr7tRKwwOzb9aNjMs/PjXmutwxJUURv4w2OjHImyuykvdMAfzSZaMtb6va/GWca+gRpB+CG+l3C70L4Oq16ytxQyxclSX7mH/YAzbtmXpDTFULAFoCe9UdPZfAu2cu4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 19:09:42 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::9eec:d188:63a6:1c61]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::9eec:d188:63a6:1c61%6]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 19:09:41 +0000
Message-ID: <cd80d0bf-f28f-45ab-974e-79d50f35764f@amd.com>
Date: Tue, 20 Feb 2024 13:09:37 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/mm: Do not zap PMD entry mapping unaccepted
 memory table during kdump.
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, luto@kernel.org, x86@kernel.org,
 ardb@kernel.org, hpa@zytor.com, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org, peterz@infradead.org,
 adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 elena.reshetova@intel.com, jun.nakajima@intel.com,
 rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, seanjc@google.com,
 kai.huang@intel.com, bhe@redhat.com, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, anisinha@redhat.com, michael.roth@amd.com,
 bdas@redhat.com, vkuznets@redhat.com, dionnaglaze@google.com,
 jroedel@suse.de, ashwin.kamat@broadcom.com
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <cover.1708390906.git.ashish.kalra@amd.com>
 <a0bf771e1472eb1a6a241acd2e16c98ab8ac9253.1708390906.git.ashish.kalra@amd.com>
 <ictdanmnsdn4qnzg42ett6om4r6qzypmxdc5spjwa2g5gz2s7p@drh7hoqdj4sc>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <ictdanmnsdn4qnzg42ett6om4r6qzypmxdc5spjwa2g5gz2s7p@drh7hoqdj4sc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR21CA0006.namprd21.prod.outlook.com
 (2603:10b6:5:174::16) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|SA0PR12MB4429:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c540ca8-ff72-4c8d-64cd-08dc32477dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y6j1aYU2xO4SpAOgtKRNWmPtI983K8G0gJVev0sB6hLpVQ4eAl3FUta+EdvyFHlIV+OOfEiV9VbSSErfFvRS6oTSWnJmMafXE5Yxq+f8ukc4yvkCPseIgRoUp+RBmrE9h2GkbenEG8EcmIqpIa8ZD7NqR8VyiEPucpxo/RR7P00D5Eemhuo5Hh7FhuMZA4y8qVR2uSa7d5+C+OaqGruYvTi5ARM6ZdRqTEo9Uo3jqjxPb0CfATUIcRuzB9Xl9qrpKnedjP3vpqMDNwS49IQIMUTrBnB6A2G5Sfs5DHbKtKXetTDdQzCLDwIXea4RvBcX96KhQv/5twsmT9NQXJ6j3qzzi9yKzbLI43B4GllhKKoEJkf+CQbthMXy9/4YPgT9s7NdkDDC55eqQ3tDK23/s6DHvtLPXaq0ErlLEgYQ6JL1GOfTpWav7c4mNGoNiiZnVmbZXIoaCdmVCM3zrqxzt/nDRO8Z247uMkMqw3tOa2Wt04xnSVu9NXRLdrUm9O+Wp5/gHGbmEAG3FF/4+akxz3dyJxhWE4G9n4P2gvAygIU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Um9uaW9peDUyTGcrdVl4RG9Nc0VDZytYMmNzaFR5MFIxSGdFVU5tcjl3YkJ1?=
 =?utf-8?B?Uk1DenVZaFcxZnRSdjc2Qk9MdnNJbzdVYmJQeTU0dFhjeWZEdUpBb1k1Ykt3?=
 =?utf-8?B?V0VoUDArQXBITlBsd2Y4Z3JVVUlEOGFiQkFCaVhsTVQvSXE1azh6cEZ4ajdB?=
 =?utf-8?B?dSszOFV3cllURUIyUDZGcnlTMUo5bnB5VHVNUVZNSmVyL1hETmhScUpOaXRV?=
 =?utf-8?B?U0NtUTdKMnJDbXA0bVZGK3Ava09WR1UySjdDelRDWjF4Lzc1V2hUbFNVMXVR?=
 =?utf-8?B?VXRFRXdKVkZoS3FsNjFpdTZ3dFBtb3BLNDU0TFJ2clBwMVcvd081WVpiMmZs?=
 =?utf-8?B?Q3hHTyt1eW56QUlhbzhpMiszMWVzcEwxQzJKTFNLWk8yck40UEdzcWFOMGJr?=
 =?utf-8?B?SW91MitXbVV6ZlNxYjlGMTU4ZEdNS05GWlB2QnVGUmltTmc3Q1VGWVE1L3h3?=
 =?utf-8?B?aS95azJQQUxIZzdKQ3g4VGRLeEFjNnk1Tk9IaTJSV0ZpMHBicmM0WVFuSnBo?=
 =?utf-8?B?WkNKbGZyNVpjWWpSMDJ6dFh5eXBBb3EzazFnaXIrMEJuejkxVzMzMnBTNCsv?=
 =?utf-8?B?djZzaHV1UmwyQTZSb2JLNUZvOHVlTkJkc3EzNmxITEFXRXhidmcyMmlmd1Rk?=
 =?utf-8?B?THBqN1Ztb0NWWVFwdFp6QkdZT3prZUJxVTREUkx5b1dvNloxQm50clJWY0dK?=
 =?utf-8?B?UHdPS2F3TTNJdllLeEhXUVNZRTJRMjVqSVZaNzhCSVBhUUpLeDV4Zk5YZnlo?=
 =?utf-8?B?RHNJdEhZTU0xNXNrUnlsRDhDVTdvamlaNlluSkZXSDBTQXdvZUVuZ0tGTDJl?=
 =?utf-8?B?dVE2ZUhYYzRhSHJMTHMxUTBNYjROREMwc0EwVXN5S1RrTmJOMmI5VXVFNHRV?=
 =?utf-8?B?WkdHT0c3WC9aN2J1THo1clR0OWgyWkt3ZzNHUGNYejdtVEk1UW84ZkVpcEFP?=
 =?utf-8?B?UUNqbDZlVFVWYUs4VEhZZWVRUzB4M2x3Mko5M1lRVHF0eHF5MU5IUmpsK3Ir?=
 =?utf-8?B?N055NlVmalFKRmZ2MGxxN21vdTJIOG5VbkdUQXJrR0tmWlZkUTBkdk5yRlNP?=
 =?utf-8?B?NWVtR1U0anRETWtNdHI3Z2U4TUtwTEkrZ2l0aTlTcWM3RHIwSDVXeVFQSjRK?=
 =?utf-8?B?VVZVSkdZbDYwN3hkNkNDUjJBbytrQjJOTHgrVk8zR3dwOTFmL2VWRy84cXR1?=
 =?utf-8?B?eEtDZndlWmNLVnBaTkx2RkN1dXd5Y0hkY1ZmamxxR1Q3ZE5OdEhXbHFpemJP?=
 =?utf-8?B?OFdBZHkwZExBZU9iWXh6ZXFtampQZG5sRURuczBGN1A2YWFFdlM4ZElsSytu?=
 =?utf-8?B?cGdRZzRmSXlKamZ2SXlWdXNwMmxBT3dJcDloMzRWaFUrTkdjemJSVE5mc3Vv?=
 =?utf-8?B?N005RWR4NnpwSk5UUGs3WVpZQVpEVzJyQml0VFlraWp5eWIxbFhwdEcwanFX?=
 =?utf-8?B?aWVISUlRcXArQ1FpS2FYMENWQkRWNHp0a29mRU5ub28vVGQ2aTBXYnBlcVBY?=
 =?utf-8?B?ejdVZ2R3czJOOFErcUtyNCt5M3QrRWRSTElQV2c3dFl2R3pISmpvTFo0MkxD?=
 =?utf-8?B?NG5iUHo1Zi9rN1hKaGpwOVJ3dkcyMCtKZmkweDlJQXRtY1lMcUs0ZU82TG9k?=
 =?utf-8?B?WnNKSjVybkVHeHA2cWtFZ2dYYXhJOTcyUFRBWUx4ZG5oWmJoejF0ZEJMYW5F?=
 =?utf-8?B?bGxtNUJkSTJTSmV3WHZTSjRyTmV6NVcyRlhQUUhDcnI1ZG9DYUNTZ0ROSVRz?=
 =?utf-8?B?TFNJN1MyM3dpdzRpdEcrbnA5aVpVS3pkMC80UmVoQ2YwSGhOZWU2b2M0ZzlR?=
 =?utf-8?B?WG5rd01zQVZyTmFiQlZKU1QzczZrUVZyU2d5VDltRGUxUThyRkhQK3RKR3RX?=
 =?utf-8?B?cFlkb09iWVVsaFNXclhiZGh0aEtmYmVSVmlIaFlFTnRqckcxMjBucE01b0Fv?=
 =?utf-8?B?c1JiSkV6T0VkVFYzN0xINndFMUd5NmdrTGFJODdNS21Oei9Pb2JUbWZlSUIy?=
 =?utf-8?B?dzNtREIyeDF6T2tueTBjS25haXR0ZnZtVWJ1cVpVSWxWNjBhQzVxbVJIQmJD?=
 =?utf-8?B?M0w1SVdvQzZzYWRxdmhIRU5mS0lOZUhrV0lSUkg5d09qTzE1RTdGSzRUeHoz?=
 =?utf-8?Q?3qOD/oSv1fJ3EulYRxR1IpD+T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c540ca8-ff72-4c8d-64cd-08dc32477dfb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 19:09:41.8952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfXesa3yprvcV+qLkD+demF/zZWZinF288e9gcbrd6F2u2QhmrKCXZCpZSuUvLgduOyMzE2+GfIHFjeFFvqRFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429

Hi Kirill,

On 2/20/2024 6:42 AM, Kirill A. Shutemov wrote:
> On Tue, Feb 20, 2024 at 01:18:29AM +0000, Ashish Kalra wrote:
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> During crashkernel boot only pre-allocated crash memory is presented as
>> E820_TYPE_RAM. This can cause PMD entry mapping unaccepted memory table
>> to be zapped during phys_pmd_init() as SNP/TDX guest use E820_TYPE_ACPI
>> to store the unaccepted memory table and pass it between the kernels on
>> kexec/kdump.
>>
>> E820_TYPE_ACPI covers not only ACPI data, but also EFI tables and might
>> be required by kernel to function properly.
>>
>> The problem was discovered during debugging kdump for SNP guest. The
>> unaccepted memory table stored with E820_TYPE_ACPI and passed between
>> the kernels on kdump was getting zapped as the PMD entry mapping this
>> is above the E820_TYPE_RAM range for the reserved crashkernel memory.
>>
>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
>> ---
>>   arch/x86/mm/init_64.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>> index a0dffaca6d2b..207c6dddde0c 100644
>> --- a/arch/x86/mm/init_64.c
>> +++ b/arch/x86/mm/init_64.c
>> @@ -524,7 +524,9 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
>>   			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
>>   					     E820_TYPE_RAM) &&
>>   			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
>> -					     E820_TYPE_RESERVED_KERN))
>> +					     E820_TYPE_RESERVED_KERN) &&
>> +			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
>> +					     E820_TYPE_ACPI))
>>   				set_pmd_init(pmd, __pmd(0), init);
>>   			continue;
> Why do you single out phys_pmd_init()? I think it has to be addressed for
> all page table levels as we do for E820_TYPE_RAM and E820_TYPE_RESERVED_KERN.

I believe i only discovered the issue with PMDe's (phys_pmd_init()) 
because of the crashkernel reserved memory size and the E820_TYPE_ACPI 
physical memory range mapping on my test system, but you are right this 
fix needs to be done for all page table levels and i will add also the 
fix in phys_pte_init(), phys_pud_init() and phys_p4d_init().

Thanks, Ashish


