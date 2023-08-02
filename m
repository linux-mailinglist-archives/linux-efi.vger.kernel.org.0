Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4840C76CEF8
	for <lists+linux-efi@lfdr.de>; Wed,  2 Aug 2023 15:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjHBNkq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Aug 2023 09:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjHBNkp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Aug 2023 09:40:45 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1A8B2;
        Wed,  2 Aug 2023 06:40:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8WljQOQxK9b0GZ0iII5ysIUJBr6SD1I3VdPcLIoGcvIypnYRZthiyR498jkVQ12llb5Prz4n/ZK3uHPfGJiqFEfmax6M5XpdMzLxSAX9mnRWy4yMHPcTuUXWWpPoI2dyEpoZaAJ9JGNcZ4jCQMNQeYwaSJswVRXqWWIIMtEmBpMLtwerSvBoHVBBIB7nUhh+lJwS+1/q5YNVzT8A24i5UlZr+p4Rqd0+5ghM7BMYhWAXlbFOb9kpdvZZcKMQx0ohXxP3/KGLUQ7fAfTlTf3Wxy6BBaQ5Pr7xti1Zaoo0DXjveRvNloU6RGL1LNVl9QnCVJTUSLzxCeJvXC4PE3vtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nk4KmDGnp5iaaRJ3PgPhBw1OOYGVIyxGLYIfDHj4X64=;
 b=fjmePEJVCXxTj8aAkyEEa+53irZotEKo9DyQiPWameTgC7cBHBS1WWbY0XS9+oeg+k+usocgUps2PuaSmvWAJSSaonKD86wwThY86sp3f5VR0S1yygDR9nK2ucOrbQzkIOaPbSI1z7UcTKv/nkE2C8Pg77NcrNr2vdUpokF5tpUDna2aPzD9ETBAoSNThWWWE9IWKIl2w5iOAwsm/1glnQP0eY2/m2gsI4GyTkDJUI7+E3aZ3NgHD3fAjJAB2BdE/l1gW6jA4AsXFFkSOsTnFzvmAWkM+W+k4n/703VH20eIP9WYRPtKfPPwBbrdERRCCi0jaoCUj+va8+BTqCY+Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nk4KmDGnp5iaaRJ3PgPhBw1OOYGVIyxGLYIfDHj4X64=;
 b=uiRt9i3OMsUmh/1in6BlAG4i6812Wh1dfIsAu9OtbRdvNVr8SPQKYE2jCv+CtMYZHvU4SOQQi+B/XOIaSMMRKM9VbjGtjTOaQK6zWBxrK9SJYhuUG/sZD0L/7rNfRWKb+3PLJjady2lDVTZbVn79FAgzhQmNUrdknnEJRx/nHkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 13:40:39 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 13:40:39 +0000
Message-ID: <99cb3813-1737-9d10-1f24-77565e460c55@amd.com>
Date:   Wed, 2 Aug 2023 08:40:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To:     Borislav Petkov <bp@alien8.de>, Tao Liu <ltao@redhat.com>,
        Michael Roth <michael.roth@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, bhe@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
References: <20230601072043.24439-1-ltao@redhat.com>
 <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
 <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com>
 <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local>
 <CAO7dBbXJv9JzDbSa-DLT03+osYCQXNUXFwz63gbq=NGDxEVyEA@mail.gmail.com>
 <20230728165535.GDZMPzB/ek5QM+xJqA@fat_crate.local>
 <CAO7dBbVyuLHH6RfdVQkU5ThXaJ-F4yvFAYD1PDNGkOpph9xvnA@mail.gmail.com>
 <20230802093927.GAZMokT57anC5jBISK@fat_crate.local>
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230802093927.GAZMokT57anC5jBISK@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:806:23::7) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d2b93d0-b45b-48cb-1698-08db935e0eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4lrjUegf8k1XwmCHzwwRfVngpiZlp3UPnQfPbTLaDdg0TwfwZhr56dgTNBhXPraypT+RgcJxbUc4LlKpMvuviZs9crHbsipYtqxwRqNoYX0G3703OSK/597mGrHbIFjVccNrxtwi3ubUT7+xhULg4qdt/xEMD49JkOEeVGnKA7mDRfwulUBXsqAwWE+wuZNtA2c/ch0kRtgf0w94c8eIT9DlKuNyJvcoNeEygeWRK5fIowRII5IZD6vwEMQzI6asUZWzSd/EHqcWeeG9VMI6rDP3TKxQH6r8wUNjcCzU1dbsI++CslCpRTiCX5aB+SjzAD7sQXdP8BWaT1wpubH5sk62VgN/ks/A0dArrRxXW4B31jYOyympjp049nwf/Puq3AZmdA3BkR3lq9Ujas/fWuywbRbTuronRbN0Ce+WPOozczw5yCU9jH3p0TGT0HkmLi5cp+FFLORwpJGcmfuOBJrO9DspUqlfAqGrSUENACPhNfdxUB2CdZnc9CSmr86IEJcKdWPbrDqBPDid5T2cs0SZW/sjAmoMbeW1p6sNoBvyLuvUiAp4g8/UUrRFpdE5H35hdNowb34elgISUqGlXwluuSVq3VvXh6ZV9xSVAEx31+pcJ98c/nDvHlPXztw0k92taukYLOMMs814EH0Akw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(31686004)(6506007)(53546011)(38100700002)(26005)(110136005)(478600001)(8936002)(5660300002)(7416002)(8676002)(66476007)(6636002)(66556008)(4326008)(66946007)(6512007)(966005)(31696002)(86362001)(316002)(41300700001)(6666004)(6486002)(2616005)(186003)(36756003)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3krc3pwMTkwUThwc3FwSkFIN1NYaXRqUElPYnp1a0RvL0JYVjVIKy9oeXB6?=
 =?utf-8?B?TjhvY0QwaCtiUHVOaVR0K25qaStmcWpoSU0xUmJpSmt0Rk9XWGZGbWh6dlh3?=
 =?utf-8?B?REU5RjQ3aldBZm1YejYrTTdSNlZzSnM3Q0hFVXgwUXdPOVJac0o0UnY2QUN3?=
 =?utf-8?B?Vy9BT2RrVVY4V0hPcVZXUkU0NVRPSjB1Rmp6V041R1NKeEJsRjlrMDU5MDB2?=
 =?utf-8?B?YVRZWmpMcGkxZ2tEQ3pvZUtMYm9wekM1UW04ZEV5Nmhud0NqQ1Rzd1JURFlm?=
 =?utf-8?B?TGtPemZlaUJ4R1BPQmQybGpPaXlldGhrRmdFU0VnVlg4bGkybk9UWUd0aW92?=
 =?utf-8?B?WG15WDNFZnpWeEpJTmVOaktDOThBR2pPNXNoSmtoRHRHWjhWbnVDY1h4c0Fv?=
 =?utf-8?B?QlBPQk9pWmJCLzdGWGhGKzJTMFcxVnNPZ3pEVmdBbzVIWEZ0Nk9abE9SSzl4?=
 =?utf-8?B?OFFOU2o4Nnk0YjJuYXVKQlRZK2xYNEgvdDVPeW4yZnRwQ1BFTFFCcVdsbk4z?=
 =?utf-8?B?WDNJSjcrNTBJRXdDTm14VDFSdDdQODZoWURCajlFYVdZTFByWFRhcDBRcHBN?=
 =?utf-8?B?R3VaU2tGSCtSWXFpSnVsSzZxM1FBTVpBN0gxRDFUMmowN2xpSEpVbXpNYk1B?=
 =?utf-8?B?YVdqYWNnZ3hSOVVjeXJ4Ky9rZnRwQ3g5K3FnbG5NRXMzakhabGVyUmR2VmJi?=
 =?utf-8?B?SGlVc2hhZ1NMN3RKVkgxNU94dTBCaUxmd3hmTElNWExXSUxoRDJqL0VsWGpC?=
 =?utf-8?B?QTBURHZtM2dMNWk0YVhiWHpKdnVFaG1CVlNzZS9ZZHNhd3NpL0FWcHRwNG5K?=
 =?utf-8?B?OGZ2bVU0Zmg1SDR3T3NyeXNpN29ORnY5ZXpYK0VobktGYVlaaHhtbVQyVEg3?=
 =?utf-8?B?bnZoNHgzQ3RkNzNadDcwMTY0dXlHTEU4MTE2bUZRWXpZUm9lVmczcGhSMlNr?=
 =?utf-8?B?eUtIaVBVRUVKMlFOeit6cUFWVUwyL1VaNlJ4cmJkaGN2bEI1SmFseU9nQUN4?=
 =?utf-8?B?RmJHTWgzeWovOW00d0oxZUpiOG82Zm5vbHdnM2I0Wm56TnVZL0toeXIwbk5r?=
 =?utf-8?B?RW5RbUtwcklkWC9zNEZLZXNvN3JpS2JOZnQ0U0ZvN3EyTlJlS01mTkMwVjcx?=
 =?utf-8?B?SDMxL3k2N21NL2I5REFFL0hGVnJnMC9hb1pwT0g0TlZwa0k0bXI3eVFXdm1t?=
 =?utf-8?B?MDRUUnRPTVpaanBOKzNBTGxjeHhqa0xZRzZuaUxsbnNGODhkTG1MaEkyTVNW?=
 =?utf-8?B?NG1XNFBGOUd3dHdGMS9ORktoVTFsVTUycml5Q2RqNWRvVTZTQ1RPU3R1TnAr?=
 =?utf-8?B?VFZHZmRobEhMWUVxaEZZZnNSNnBtWEkxWk1vNG5RR1JTaUZrOU93L2JpNU1j?=
 =?utf-8?B?UXU2czJ0WlhCcXFCK29qeVRkS3ZneHY1cHc5SnZ2QWRvNWU2QnI1RDQrT3dB?=
 =?utf-8?B?aXYvYUhyaHRwT3luUmN4aXF6N0o0M2RlMXJKSlluMkNXd1NIVFRyZ1FjWnBh?=
 =?utf-8?B?QTdwTXpPcTNQUUVSTFhpRTBNZkZrSEl3cFpSOGUrK2pzNVVsb29NVGJ6cEJD?=
 =?utf-8?B?S0w0Q0h6Y1lReUJCMFNka1ZXLytZLys5QXA0MC9keHFQd3Rya0U5ZmdEbUZB?=
 =?utf-8?B?RU9BOHpkWW83T2RuY3I1N3FrN2pVKzZUazRjSytrVm1HcHBrSlZhOW5DOWRm?=
 =?utf-8?B?MmlZVDd2dURQeGM0eWw0Uzg0dkd4dnJiclFPWjViT2creTM0SHVZZmhSb0Ez?=
 =?utf-8?B?eDhiMmY4bDhMc3dVdWRRdXdsOUs2VFl5d2c0dXRLQzU0TmdFTUNoQ3c4V2xz?=
 =?utf-8?B?cmpmNTJGK2UyWFJVMnFPdG5GRHQ0OUZEd0lOTGg5bGcyVk9maE5EbDVkUmQ1?=
 =?utf-8?B?YnVZZEhFZHFOK3hlem4yVWRjVnp0WTVVVHc3USsrYmUvSjhIU284eklLMlM4?=
 =?utf-8?B?TEJQWlk1d1RQRHhERkNNZFZsODJycG9pNDc4UnBlczFiQ01RaVVyZlJ6V21W?=
 =?utf-8?B?Z3plSGlHZjVyWXRGanpGWGJibm5lWFMxMVV3bDNwK1IwdUpKOXpLblllSk9Y?=
 =?utf-8?B?Q3NwWW54L21oYitEZUJSem0vVHRMaTZMdmRVbTVNWFlNa1dHd0lVVDR2RWRw?=
 =?utf-8?Q?iyq4fooAmZPB0BuV92guUI7ks?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2b93d0-b45b-48cb-1698-08db935e0eee
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 13:40:39.1847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMYyjdpaTXlEAUix3SS9NEHULYrhiDd1LJSsQOYRYWr2o5Gt2dvBlVlRApOOnr3Z3rR/ueDB56QP5wnyT3h3Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/2/23 04:39, Borislav Petkov wrote:
> On Wed, Aug 02, 2023 at 04:22:54PM +0800, Tao Liu wrote:
>> Thanks for the patch! I have tested it on the lenovo machine in the
>> past few days, no issue found, so the patch tests OK.
> 
> Thanks for testing!
> 
> Mike, Tom, the below ok this way?

Short of figuring out how to map page accesses earlier through the 
boot_page_fault IDT routine, this seems reasonable.

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> 
> ---
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Sun, 16 Jul 2023 20:22:20 +0200
> Subject: [PATCH] x86/sev: Do not try to parse for the CC blob on non-AMD
>   hardware
> 
> Tao Liu reported a boot hang on an Intel Atom machine due to an unmapped
> EFI config table. The reason being that the CC blob which contains the
> CPUID page for AMD SNP guests is parsed for before even checking
> whether the machine runs on AMD hardware.
> 
> Usually that's not a problem on !AMD hw - it simply won't find the CC
> blob's GUID and return. However, if any parts of the config table
> pointers array is not mapped, the kernel will #PF very early in the
> decompressor stage without any opportunity to recover.
> 
> Therefore, do a superficial CPUID check before poking for the CC blob.
> This will fix the current issue on real hardware. It would also work as
> a guest on a non-lying hypervisor.
> 
> For the lying hypervisor, the check is done again, *after* parsing the
> CC blob as the real CPUID page will be present then.
> 
> Clear the #VC handler in case SEV-{ES,SNP} hasn't been detected, as
> a precaution.
> 
> Fixes: c01fce9cef84 ("x86/compressed: Add SEV-SNP feature detection/setup")
> Reported-by: Tao Liu <ltao@redhat.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Tested-by: Tao Liu <ltao@redhat.com>
> Cc: <stable@kernel.org>
> Link: https://lore.kernel.org/r/20230601072043.24439-1-ltao@redhat.com
> ---
>   arch/x86/boot/compressed/idt_64.c |  9 +++++++-
>   arch/x86/boot/compressed/sev.c    | 37 +++++++++++++++++++++++++++++--
>   2 files changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
> index 6debb816e83d..3cdf94b41456 100644
> --- a/arch/x86/boot/compressed/idt_64.c
> +++ b/arch/x86/boot/compressed/idt_64.c
> @@ -63,7 +63,14 @@ void load_stage2_idt(void)
>   	set_idt_entry(X86_TRAP_PF, boot_page_fault);
>   
>   #ifdef CONFIG_AMD_MEM_ENCRYPT
> -	set_idt_entry(X86_TRAP_VC, boot_stage2_vc);
> +	/*
> +	 * Clear the second stage #VC handler in case guest types
> +	 * needing #VC have not been detected.
> +	 */
> +	if (sev_status & BIT(1))
> +		set_idt_entry(X86_TRAP_VC, boot_stage2_vc);
> +	else
> +		set_idt_entry(X86_TRAP_VC, NULL);
>   #endif
>   
>   	load_boot_idt(&boot_idt_desc);
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 09dc8c187b3c..c3e343bd4760 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -404,13 +404,46 @@ void sev_enable(struct boot_params *bp)
>   	if (bp)
>   		bp->cc_blob_address = 0;
>   
> +	/*
> +	 * Do an initial SEV capability check before snp_init() which
> +	 * loads the CPUID page and the same checks afterwards are done
> +	 * without the hypervisor and are trustworthy.
> +	 *
> +	 * If the HV fakes SEV support, the guest will crash'n'burn
> +	 * which is good enough.
> +	 */
> +
> +	/* Check for the SME/SEV support leaf */
> +	eax = 0x80000000;
> +	ecx = 0;
> +	native_cpuid(&eax, &ebx, &ecx, &edx);
> +	if (eax < 0x8000001f)
> +		return;
> +
> +	/*
> +	 * Check for the SME/SEV feature:
> +	 *   CPUID Fn8000_001F[EAX]
> +	 *   - Bit 0 - Secure Memory Encryption support
> +	 *   - Bit 1 - Secure Encrypted Virtualization support
> +	 *   CPUID Fn8000_001F[EBX]
> +	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
> +	 */
> +	eax = 0x8000001f;
> +	ecx = 0;
> +	native_cpuid(&eax, &ebx, &ecx, &edx);
> +	/* Check whether SEV is supported */
> +	if (!(eax & BIT(1)))
> +		return;
> +
>   	/*
>   	 * Setup/preliminary detection of SNP. This will be sanity-checked
>   	 * against CPUID/MSR values later.
>   	 */
>   	snp = snp_init(bp);
>   
> -	/* Check for the SME/SEV support leaf */
> +	/* Now repeat the checks with the SNP CPUID table. */
> +
> +	/* Recheck the SME/SEV support leaf */
>   	eax = 0x80000000;
>   	ecx = 0;
>   	native_cpuid(&eax, &ebx, &ecx, &edx);
> @@ -418,7 +451,7 @@ void sev_enable(struct boot_params *bp)
>   		return;
>   
>   	/*
> -	 * Check for the SME/SEV feature:
> +	 * Recheck for the SME/SEV feature:
>   	 *   CPUID Fn8000_001F[EAX]
>   	 *   - Bit 0 - Secure Memory Encryption support
>   	 *   - Bit 1 - Secure Encrypted Virtualization support
