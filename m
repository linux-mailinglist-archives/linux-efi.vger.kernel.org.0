Return-Path: <linux-efi+bounces-622-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5899385E918
	for <lists+linux-efi@lfdr.de>; Wed, 21 Feb 2024 21:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5FB1F247B8
	for <lists+linux-efi@lfdr.de>; Wed, 21 Feb 2024 20:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BCA3A8F5;
	Wed, 21 Feb 2024 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GIKY2JW8"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D772E53A1;
	Wed, 21 Feb 2024 20:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547725; cv=fail; b=arQJKqPUiUdhl66SJCcNidoTavqFWzQSWtJaZ9Y1C+gGN2wYQwviWuqMEOEPzkEhSGNC/vDESLnd/meSiAttQeH40n2eElpJwOn6okWWPNyQNZ83XJ/b0JTxGgSlOY6zQ85shBq1Jcr0JKktCOIhW8JV+33KC9QUar+/9srHAtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547725; c=relaxed/simple;
	bh=oVqHVLE43s8a8BvC7MtwXAqegcv0nHI4Uh+rE+gVgIg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mR5w1bbwMNpqCktUpUZto18K/70kEbuMJGJ6YS4XYgkHCAVejPp7O4ruahlxbawD8umcxrFa0NS3ApSzxH81OJIN68GTdkNay6CezOkJvXNnIY44ILk7ZsXleR4gQ5byRFZ8F3dAMvwtGrch21imQvQYejfV9D4wQCD3g+MYjiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GIKY2JW8; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBWeoF0ANznDENHLW0W62qggrdaMFb5X5aeoLQJyxD4mRrT3cFTeaFULpBIptSHa6Zwx/rdOnYO40463vB4cpZXIPuTdijYSt/IEvkofEgLf8nqCExYBmn+uejzvd8IVqOoypcAeVTF6XiJEngNEXgVlvNfoOAxIHsZUFGXLaCMU21aYB2sd5GsSGGKvAnqlS5HsIPye3hxHME0uR7uY+k8qZNZwiotrYq+m8CKFY7jYDzfAi21280IdSu0tUD+5+gLIExTbe4S46iMB5sBzjmtzMRO0aN6FUg9l5XsfTUcYNXZdV0NP13IGinjPeCmCZBeHLjPxIdJ+ul5kcCilrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNaMl4xaQq2oMAgXnAb6K4woZRQioUn7wE08kHb/uEk=;
 b=Aald+7n/aE/dRaUlrAHK3nUI6CXSI4xEwG/9O4Vg8Gkdagfnv46c/ha65qt2I2B+RgPuLSy+fj0luUcsy7jSWlGHGm98BEgZXoSrJmaSu0q4RvGFbK7wJD4Ef5BqRERKad7BVF9IBpPAfe5mjkkqcjDnFnF7ndD8wfuhyF5QlqAzeldK0rwo4OvzrWaMuf4o0v0c5lxvw1gORmXymYaWt+nvfhg633rYAuhIvXMdcmMHOeUgIypPVL9dWAe3lV5CTxr3fasBoVsY8JNQH2Fcj9gF7LT3F+t4LNqzoR6MaNsvMLN8lNvCQ3b3mnnYXZ76A9vaULfKIESl5bqOfFRoTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNaMl4xaQq2oMAgXnAb6K4woZRQioUn7wE08kHb/uEk=;
 b=GIKY2JW89aPwkO3vDuaByZurp03Vd0SI/K7MCVYiyy5r51z9fHhssDbst85xRVzvUy+URTnGmTMnz4ouUFXnAowLN1wHsRd4bBzjLGjX30s1JP7awQJkvZunSD1tIbGkLc4H1mFkvP8+R4qLrjKFJ0MYWR7sFpzDXyKyjHaoYx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 20:35:18 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42%4]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 20:35:18 +0000
Message-ID: <97a7d69f-03e1-4ecc-a0ce-10bfe148509c@amd.com>
Date: Wed, 21 Feb 2024 14:35:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/snp: Convert shared memory back to private on
 kexec
Content-Language: en-US
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 luto@kernel.org, x86@kernel.org
Cc: ardb@kernel.org, hpa@zytor.com, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org, peterz@infradead.org,
 adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 elena.reshetova@intel.com, jun.nakajima@intel.com,
 rick.p.edgecombe@intel.com, seanjc@google.com, kai.huang@intel.com,
 bhe@redhat.com, kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 kirill.shutemov@linux.intel.com, anisinha@redhat.com, michael.roth@amd.com,
 bdas@redhat.com, vkuznets@redhat.com, dionnaglaze@google.com,
 jroedel@suse.de, ashwin.kamat@broadcom.com
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <cover.1708390906.git.ashish.kalra@amd.com>
 <aa633d7439885da7e54c41db07d65f8e177bcf51.1708390906.git.ashish.kalra@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <aa633d7439885da7e54c41db07d65f8e177bcf51.1708390906.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0208.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::33) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: df9e654d-041a-42bb-dbac-08dc331c9dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7+ah7FxhOBouG5VKzId9DWKmCQW1i4qdh9mVmoirAzDAs58K3jrHGVHfAyVl1BZwnLXXQ2yY1ZZhW2meNtb0alJeBPCUV4r2EszWorKhAo0kVkLWcLaOfg1ZX1/9mvWXip+rpleGDRaY7u+ego4k1QEWvbz/ynQ9weYyAH79m0SdDnnV20+nPVSGCA0jWnqZ10J9UrUq2mT4LBdwL1uJsMdvZry6xZJfPRZp6PAO2QNrI51/SkRxEdTAG2oZh6SjRPuu3TMG+MjDOrQL6FyQjA1trKwd3Qo5owvTNmJu2oey3Sf5SPkr/8YS/w/mOI12izsg+7jG59xul127kgwXX5hBiRJVb8w78fDhsZ0kmUwKjNIV4uKQBvlkpPAxidfu+iHykDb5eKci0UHqnoyzcECSZFH9SX6x/X8C6y2w2KcHqHqcBsIXyoov2pRim9fjrXAdc746Aqob8ZXvJDFnF98ZlAH0ktTXHFopJimiDbiEs70ylHDOdAdBFMOqPt0jibyv+4ETKR90kHcyRyJfTm4GWk8dsl3oe/NS3KW5Ra0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amFkaTc1SkpRcG5zSlltb0UzM2VmcURxWHJxay82d3JtZ01XTGxCMUlLQ1pL?=
 =?utf-8?B?bjhCZFl3cVREWVlDRTNzR3hZeW1lMFJyVlZxSGpTczBtUnhUcTN2cC9yeXY5?=
 =?utf-8?B?N0pQZy9CVmw1ZldKbG56Z2ZyZzlsY0hMdGpLYmZKRFpnTjlXMFRjVEhxTkdN?=
 =?utf-8?B?MERYeWRjZ3oxR05HRGlBSVdqSXNMY3VUWFUrYWJvNEtXSEZLQXNaRGpYMHdt?=
 =?utf-8?B?ZHRXQVNtWlNic3pPb0JCeG5DeUVPK0lFS1NqNGxPZHBERlFraUQydUJEZktE?=
 =?utf-8?B?dnA1c2NXNDE5SDN1eFN2WDVsT3A0bUx5Qm01b3NwSzA1c0l0bUo2ZHFIQXp2?=
 =?utf-8?B?YmlPUHF5eTlJT0t3RjBaSkViYjVPVUZ2cjZsN1FuNlNWL3dGeHJkNlJCenBC?=
 =?utf-8?B?OENpWU15UEs1M2Fac0VhMDhVVXhUWjkra3BNbmRnQ3V6NlVhUjRkUmVMcmY0?=
 =?utf-8?B?KzFhcUp3TEN2eEFBMFQ5aTFGWDBYemdxUWgvdVJUOTNyeGxzU0tNVDB4SkxR?=
 =?utf-8?B?T08vdFZWMjZRY3dJZWhMSHp5VUN6UGFEV0sxMVlrUUl1dHNvNVJPa2NONTJK?=
 =?utf-8?B?bTlSWWFYNVpWQ29ld3U0U0tFbWZXd1YxTStuRjl4ZnM3elA1cmdnNEVnSE5l?=
 =?utf-8?B?TWhtYnlHSE14ZlVNU1VNbzJKUmVSMzRPb3RBeGpxb0xVWUh0VzAySG1HSUdL?=
 =?utf-8?B?UnM5THl2dXVxcDh1d2gwNTF4ZXMwZ1Y0WEM5K3E3VlFNNkRuTmhZcGJrQmtX?=
 =?utf-8?B?MUNPKzBPYm4yVFFtVWxBTVhteXcwRjZoMDZESisvbi9TVCs0cVIwN1pIeUNB?=
 =?utf-8?B?b092eVJockRuQzdFSnVxT01XUGdvU3VVY0k3VGJ0d1VtaWdMVll0N2NQb1BL?=
 =?utf-8?B?TTZzTU01ZEdiZnV2NW5CRHJTaXVkRTM1dWJVeEhGZDNYMVdhTVJ5b3N6M0hY?=
 =?utf-8?B?ZWttZ0Q3R1dRbWR3TmxGL0FRWlMrRHVTeXpVbWw4Qk44TllRK1JFRHhpdnhi?=
 =?utf-8?B?UjdUVGh6Qk41WG1TRVNJZXVyQXdCYnNHeEZ3b0FBeFdFTUowVHhKNzdhYks2?=
 =?utf-8?B?cFVxZGpPeitBMnFtU1JyQTQ1SEJhbVZSRjdJc2JGUUFQNy9Ydm41US82MjZt?=
 =?utf-8?B?U3JEMHppTW40V0FhSWVBZktUWitjRHliRHdHNFFnWC8yUG9INERNOUhXMHJD?=
 =?utf-8?B?S0pVUHB5ZCtEM0pMS2JNbGY3OWptWDVoUEFoYWFVVC9kVFV2NXJSc3lLMUJK?=
 =?utf-8?B?dU01VS9xZm84REhiVi9lcy96S2xiemlXd0w4elZXTExMYVZUMUhKM0ZBcUlU?=
 =?utf-8?B?d00rWm1qR0Y1UzBxNVM4UHNzS2lRV0FTb2JWOGlkUkxXOVU0V2hsaVplZ2lY?=
 =?utf-8?B?YWd3RHhNWDBLaGR6djlCVmQ4RGEvcExkcXV4bzY3SXNOTTZ1ZUY2MEFXNjRa?=
 =?utf-8?B?b0VyTWJmZ1J6dWZqNUFZRUlTdkRXMFpYS3pqWHg0WmUxY28wUVRFNUJIQUxJ?=
 =?utf-8?B?R2dWVTk5Tkx1RHcvM1hReHhHK3VQbStlSzBzTEliQithT1pqUUxNbFRSeXk3?=
 =?utf-8?B?c0pteXFiSHZKOE9zQ2xGdW90T1lqa2ZEZnd1dlJITHdLVlloNWdPY2h2aXcw?=
 =?utf-8?B?R3lOWTI1ODluNGVJcDZkM3AxTDhnZEdLYW55OFkvckNMc09xUDdPOGJIdnBh?=
 =?utf-8?B?RkNEVkFycDVBVldKY0VpWXJVZWtQaDVncWhwbEprMjV1NEl6U01scUZFQ2lk?=
 =?utf-8?B?d0FuU2I4TEtRaXo3OHl4dUx1L0NXMERQcjdBbE5hVlRWYnN2eEViNlFhS3hw?=
 =?utf-8?B?bndaRmZ6ZGpEOTczUU5PeHpMYXJ6NHdIMGN6OW9jSlE3SkZWNmYwMEhLZitn?=
 =?utf-8?B?WkRJaFJBcFZYZ2dpalhqVGZ6dCt2dEV4bThlb1RPbitWbFphNFZWQkFTZTdG?=
 =?utf-8?B?RVo2ZFNkU09pTWp1MUJIMEhMcGVwYlc3S3ZkQzB0NXFmQ3k1M25pTzlWWFo4?=
 =?utf-8?B?L1lIRm50MlVXZnhxc1FFTnBxOTlnMmpHR0JSUUdJZHIwMXRxdmoxNzJ2d2pP?=
 =?utf-8?B?MkNndVFDT2RqVC9OSVFJUHAvUUdCT3JHcVQ2SG55RURmQ0V3Skl2QUlLS1hG?=
 =?utf-8?Q?15bpf8KJ3Yl5sQ9HkUd3yVd13?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9e654d-041a-42bb-dbac-08dc331c9dbe
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 20:35:17.9764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oC25yFDSHFO9oVVX5xGAPiLpG9lTgr1PhZrqkTaysemzHY3UlM0VzR31oNHlreKCjmYuY2XPon8GaNWz/fG2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399

On 2/19/24 19:18, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> SNP guests allocate shared buffers to perform I/O. It is done by
> allocating pages normally from the buddy allocator and converting them
> to shared with set_memory_decrypted().
> 
> The second kernel has no idea what memory is converted this way. It only
> sees E820_TYPE_RAM.
> 
> Accessing shared memory via private mapping will cause unrecoverable RMP
> page-faults.
> 
> On kexec walk direct mapping and convert all shared memory back to
> private. It makes all RAM private again and second kernel may use it
> normally. Additionally for SNP guests convert all bss decrypted section
> pages back to private and switch back ROM regions to shared so that
> their revalidation does not fail during kexec kernel boot.
> 
> The conversion occurs in two steps: stopping new conversions and
> unsharing all memory. In the case of normal kexec, the stopping of
> conversions takes place while scheduling is still functioning. This
> allows for waiting until any ongoing conversions are finished. The
> second step is carried out when all CPUs except one are inactive and
> interrupts are disabled. This prevents any conflicts with code that may
> access shared memory.

This seems like this patch should be broken down into multiple patches 
with the final patch setting x86_platform.guest.enc_kexec_stop_conversion 
and x86_platform.guest.enc_kexec_unshare_mem

> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>   arch/x86/include/asm/probe_roms.h |   1 +
>   arch/x86/include/asm/sev.h        |   8 ++
>   arch/x86/kernel/probe_roms.c      |  16 +++
>   arch/x86/kernel/sev.c             | 211 ++++++++++++++++++++++++++++++
>   arch/x86/mm/mem_encrypt_amd.c     |  18 ++-
>   5 files changed, 253 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/probe_roms.h b/arch/x86/include/asm/probe_roms.h
> index 1c7f3815bbd6..d50b67dbff33 100644
> --- a/arch/x86/include/asm/probe_roms.h
> +++ b/arch/x86/include/asm/probe_roms.h
> @@ -6,4 +6,5 @@ struct pci_dev;
>   extern void __iomem *pci_map_biosrom(struct pci_dev *pdev);
>   extern void pci_unmap_biosrom(void __iomem *rom);
>   extern size_t pci_biosrom_size(struct pci_dev *pdev);
> +extern void snp_kexec_unprep_rom_memory(void);
>   #endif
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 5b4a1ce3d368..dd236d7e9407 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -81,6 +81,10 @@ extern void vc_no_ghcb(void);
>   extern void vc_boot_ghcb(void);
>   extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
>   
> +extern atomic_t conversions_in_progress;
> +extern bool conversion_allowed;
> +extern unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot);
> +
>   /* PVALIDATE return codes */
>   #define PVALIDATE_FAIL_SIZEMISMATCH	6
>   
> @@ -213,6 +217,8 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct sn
>   void snp_accept_memory(phys_addr_t start, phys_addr_t end);
>   u64 snp_get_unsupported_features(u64 status);
>   u64 sev_get_status(void);
> +void snp_kexec_unshare_mem(void);
> +void snp_kexec_stop_conversion(bool crash);
>   #else
>   static inline void sev_es_ist_enter(struct pt_regs *regs) { }
>   static inline void sev_es_ist_exit(void) { }
> @@ -241,6 +247,8 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
>   static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
>   static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
>   static inline u64 sev_get_status(void) { return 0; }
> +void snp_kexec_unshare_mem(void) {}
> +static void snp_kexec_stop_conversion(bool crash) {}
>   #endif
>   
>   #endif
> diff --git a/arch/x86/kernel/probe_roms.c b/arch/x86/kernel/probe_roms.c
> index 319fef37d9dc..457f1e5c8d00 100644
> --- a/arch/x86/kernel/probe_roms.c
> +++ b/arch/x86/kernel/probe_roms.c
> @@ -177,6 +177,22 @@ size_t pci_biosrom_size(struct pci_dev *pdev)
>   }
>   EXPORT_SYMBOL(pci_biosrom_size);
>   
> +void snp_kexec_unprep_rom_memory(void)
> +{
> +	unsigned long vaddr, npages, sz;
> +
> +	/*
> +	 * Switch back ROM regions to shared so that their validation
> +	 * does not fail during kexec kernel boot.
> +	 */
> +	vaddr = (unsigned long)__va(video_rom_resource.start);
> +	sz = (system_rom_resource.end + 1) - video_rom_resource.start;
> +	npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
> +
> +	snp_set_memory_shared(vaddr, npages);
> +}
> +EXPORT_SYMBOL(snp_kexec_unprep_rom_memory);
> +
>   #define ROMSIGNATURE 0xaa55
>   
>   static int __init romsignature(const unsigned char *rom)
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index c67285824e82..765ab83129eb 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -23,6 +23,9 @@
>   #include <linux/platform_device.h>
>   #include <linux/io.h>
>   #include <linux/psp-sev.h>
> +#include <linux/pagewalk.h>
> +#include <linux/cacheflush.h>
> +#include <linux/delay.h>
>   #include <uapi/linux/sev-guest.h>
>   
>   #include <asm/cpu_entry_area.h>
> @@ -40,6 +43,7 @@
>   #include <asm/apic.h>
>   #include <asm/cpuid.h>
>   #include <asm/cmdline.h>
> +#include <asm/probe_roms.h>
>   
>   #define DR7_RESET_VALUE        0x400
>   
> @@ -71,6 +75,13 @@ static struct ghcb *boot_ghcb __section(".data");
>   /* Bitmap of SEV features supported by the hypervisor */
>   static u64 sev_hv_features __ro_after_init;
>   
> +/* Last address to be switched to private during kexec */
> +static unsigned long last_address_shd_kexec;

Maybe kexec_last_address_to_make_private ? Or just something that makes a 
bit more sense.

> +
> +static bool crash_requested;
> +atomic_t conversions_in_progress;
> +bool conversion_allowed = true;
> +
>   /* #VC handler runtime per-CPU data */
>   struct sev_es_runtime_data {
>   	struct ghcb ghcb_page;
> @@ -906,6 +917,206 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
>   	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
>   }
>   
> +static inline bool pte_decrypted(pte_t pte)
> +{
> +	return cc_mkdec(pte_val(pte)) == pte_val(pte);
> +}
> +

This is duplicated in TDX code, arch/x86/coco/tdx/tdx.c, looks like 
something that can go in a header file, maybe mem_encrypt.h.

> +static int set_pte_enc(pte_t *kpte, int level, void *va)
> +{
> +	pgprot_t old_prot, new_prot;
> +	unsigned long pfn, pa, size;
> +	pte_t new_pte;
> +
> +	pfn = pg_level_to_pfn(level, kpte, &old_prot);
> +	if (!pfn)
> +		return 0;

Not sure this matters... a zero PFN is a valid PFN, it's just marked not 
present.  This seems a bit overdone to me, see the end of this function to 
see if the more compact version works.

> +
> +	new_prot = old_prot;
> +	pgprot_val(new_prot) |= _PAGE_ENC;
> +	pa = pfn << PAGE_SHIFT;
> +	size = page_level_size(level);
> +
> +	/*
> +	 * Change the physical page attribute from C=0 to C=1. Flush the
> +	 * caches to ensure that data gets accessed with the correct C-bit.
> +	 */
> +	clflush_cache_range(va, size);
> +
> +	/* Change the page encryption mask. */
> +	new_pte = pfn_pte(pfn, new_prot);
> +	set_pte_atomic(kpte, new_pte);
> +
> +	return 1;
> +}

static bool set_pte_enc(pte_t *kpte, int level, void *va)
{
	pte_t new_pte;

	if (pte_none(*kpte))
		return false;

	if (pte_present(*kpte))
		clflush_cache_range(va, page_leve_size(level);

	new_pte = cc_mkenc(*kpte);
	set_pte_atomic(kpte, new_pte);

	return true;
}

> +
> +static int unshare_pte(pte_t *pte, unsigned long addr, int pages, int level)

Maybe a better name is make_pte_private ?

And if you are only returning 0 or 1, it begs to be a bool.

> +{
> +	struct sev_es_runtime_data *data;
> +	struct ghcb *ghcb;
> +
> +	data = this_cpu_read(runtime_data);
> +	ghcb = &data->ghcb_page;
> +
> +	/*
> +	 * check for GHCB for being part of a PMD range.
> +	 */

Single line comment.

> +	if ((unsigned long)ghcb >= addr &&
> +	    (unsigned long)ghcb <= (addr + (pages * PAGE_SIZE))) {
> +		/*
> +		 * setup last address to be made private so that this GHCB
> +		 * is made private at the end of unshared loop so that RMP
> +		 * does not possibly getting PSMASHed from using the
> +		 * MSR protocol.
> +		 */

Please clarify this comment a bit more...  it's a bit hard to follow.

> +		pr_debug("setting boot_ghcb to NULL for this cpu ghcb\n");
> +		last_address_shd_kexec = addr;
> +		return 1;
> +	}

Add a blank line here.

> +	if (!set_pte_enc(pte, level, (void *)addr))
> +		return 0;

Add a blank line here.

> +	snp_set_memory_private(addr, pages);
> +
> +	return 1;
> +}
> +
> +static void unshare_all_memory(bool unmap)

Unused input, looks like this can be removed.

> +{
> +	unsigned long addr, end;
> +
> +	/*
> +	 * Walk direct mapping and convert all shared memory back to private,
> +	 */
> +
> +	addr = PAGE_OFFSET;
> +	end  = PAGE_OFFSET + get_max_mapped();
> +
> +	while (addr < end) {
> +		unsigned long size;
> +		unsigned int level;
> +		pte_t *pte;
> +
> +		pte = lookup_address(addr, &level);
> +		size = page_level_size(level);
> +
> +		/*
> +		 * pte_none() check is required to skip physical memory holes in direct mapped.
> +		 */
> +		if (pte && pte_decrypted(*pte) && !pte_none(*pte)) {
> +			int pages = size / PAGE_SIZE;
> +
> +			if (!unshare_pte(pte, addr, pages, level)) {
> +				pr_err("Failed to unshare range %#lx-%#lx\n",
> +				       addr, addr + size);
> +			}
> +
> +		}
> +
> +		addr += size;
> +	}
> +	__flush_tlb_all();

This is also mostly in the TDX code and begs to be made common and not 
copied... please figure out a way to do the "different" things through a 
registered callback or such.

> +
> +}
> +
> +static void unshare_all_bss_decrypted_memory(void)
> +{
> +	unsigned long vaddr, vaddr_end;
> +	unsigned long size;
> +	unsigned int level;
> +	unsigned int npages;
> +	pte_t *pte;
> +
> +	vaddr = (unsigned long)__start_bss_decrypted;
> +	vaddr_end = (unsigned long)__start_bss_decrypted_unused;
> +	npages = (vaddr_end - vaddr) >> PAGE_SHIFT;
> +	for (; vaddr < vaddr_end; vaddr += PAGE_SIZE) {
> +		pte = lookup_address(vaddr, &level);
> +		if (!pte || !pte_decrypted(*pte) || pte_none(*pte))
> +			continue;
> +
> +		size = page_level_size(level);
> +		set_pte_enc(pte, level, (void *)vaddr);
> +	}
> +	vaddr = (unsigned long)__start_bss_decrypted;
> +	snp_set_memory_private(vaddr, npages);
> +}
> +
> +void snp_kexec_stop_conversion(bool crash)
> +{
> +	/* Stop new private<->shared conversions */
> +	conversion_allowed = false;
> +	crash_requested = crash;
> +
> +	/*
> +	 * Make sure conversion_allowed is cleared before checking
> +	 * conversions_in_progress.
> +	 */
> +	barrier();

This should be smp_wmb().

> +
> +	/*
> +	 * Crash kernel reaches here with interrupts disabled: can't wait for
> +	 * conversions to finish.
> +	 *
> +	 * If race happened, just report and proceed.
> +	 */
> +	if (!crash) {
> +		unsigned long timeout;
> +
> +		/*
> +		 * Wait for in-flight conversions to complete.
> +		 *
> +		 * Do not wait more than 30 seconds.
> +		 */
> +		timeout = 30 * USEC_PER_SEC;
> +		while (atomic_read(&conversions_in_progress) && timeout--)
> +			udelay(1);
> +	}
> +
> +	if (atomic_read(&conversions_in_progress))
> +		pr_warn("Failed to finish shared<->private conversions\n");
> +}

Again, same code as in TDX (except for the crash_requested, but I don't 
see that used anywhere), so please make it common.

> +
> +void snp_kexec_unshare_mem(void)
> +{
> +	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> +		return;
> +
> +	/*
> +	 * Switch back any specific memory regions such as option
> +	 * ROM regions back to shared so that (re)validation does
> +	 * not fail when kexec kernel boots.
> +	 */
> +	snp_kexec_unprep_rom_memory();
> +
> +	unshare_all_memory(true);
> +
> +	unshare_all_bss_decrypted_memory();
> +
> +	if (last_address_shd_kexec) {
> +		unsigned long size;
> +		unsigned int level;
> +		pte_t *pte;
> +
> +		/*
> +		 * Switch to using the MSR protocol to change this cpu's
> +		 * GHCB to private.
> +		 */
> +		boot_ghcb = NULL;
> +		/*
> +		 * All the per-cpu GHCBs have been switched back to private,
> +		 * so can't do any more GHCB calls to the hypervisor beyond
> +		 * this point till the kexec kernel starts running.
> +		 */
> +		sev_cfg.ghcbs_initialized = false;

Maybe combine the two comments above into a single comment and then keep 
the two assignments together.

> +
> +		pr_debug("boot ghcb 0x%lx\n", last_address_shd_kexec);
> +		pte = lookup_address(last_address_shd_kexec, &level);
> +		size = page_level_size(level);
> +		set_pte_enc(pte, level, (void *)last_address_shd_kexec);
> +		snp_set_memory_private(last_address_shd_kexec, (size / PAGE_SIZE));
> +	}
> +}
> +
>   static int snp_set_vmsa(void *va, bool vmsa)
>   {
>   	u64 attrs;
> diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
> index d314e577836d..87b6475358ad 100644
> --- a/arch/x86/mm/mem_encrypt_amd.c
> +++ b/arch/x86/mm/mem_encrypt_amd.c
> @@ -214,7 +214,7 @@ void __init sme_map_bootdata(char *real_mode_data)
>   	__sme_early_map_unmap_mem(__va(cmdline_paddr), COMMAND_LINE_SIZE, true);
>   }
>   
> -static unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot)
> +unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot)

This change shouldn't be needed anymore if you modify the set_pte_enc() 
function.

>   {
>   	unsigned long pfn = 0;
>   	pgprot_t prot;
> @@ -285,6 +285,17 @@ static void enc_dec_hypercall(unsigned long vaddr, unsigned long size, bool enc)
>   
>   static int amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool enc)
>   {
> +	atomic_inc(&conversions_in_progress);
> +
> +	/*
> +	 * Check after bumping conversions_in_progress to serialize
> +	 * against snp_kexec_stop_conversion().
> +	 */
> +	if (!conversion_allowed) {
> +		atomic_dec(&conversions_in_progress);
> +		return -EBUSY;
> +	}

Duplicate code, please move to a common file, along with the varialbles, 
such as arch/x86/mm/mem_encrypt.c ?

> +
>   	/*
>   	 * To maintain the security guarantees of SEV-SNP guests, make sure
>   	 * to invalidate the memory before encryption attribute is cleared.
> @@ -308,6 +319,8 @@ static int amd_enc_status_change_finish(unsigned long vaddr, int npages, bool en
>   	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
>   		enc_dec_hypercall(vaddr, npages << PAGE_SHIFT, enc);
>   
> +	atomic_dec(&conversions_in_progress);

Ditto here.

Thanks,
Tom

> +
>   	return 0;
>   }
>   
> @@ -468,6 +481,9 @@ void __init sme_early_init(void)
>   	x86_platform.guest.enc_tlb_flush_required    = amd_enc_tlb_flush_required;
>   	x86_platform.guest.enc_cache_flush_required  = amd_enc_cache_flush_required;
>   
> +	x86_platform.guest.enc_kexec_stop_conversion = snp_kexec_stop_conversion;
> +	x86_platform.guest.enc_kexec_unshare_mem     = snp_kexec_unshare_mem;
> +
>   	/*
>   	 * AMD-SEV-ES intercepts the RDMSR to read the X2APIC ID in the
>   	 * parallel bringup low level code. That raises #VC which cannot be

