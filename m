Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81ACB726577
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 18:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241510AbjFGQIE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 12:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241433AbjFGQID (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 12:08:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4571BE8;
        Wed,  7 Jun 2023 09:08:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifj9B+5LAOmSFTdSbXwgNKlT2EFSAzmTzJ0P8xgcyRJBTXjBu9lsnStRy68r0tOMkhi769z1HyZ8+jyKbEwDfRvPhUDwC2H2JDygnhIsH29KCuV7OBrMoWCKeaj6R6LHZdnceeOpW4Lzs4Bv87KJXYbRCbZIvpkuDUHmAxNTtqsM6lqJH0a+ff0nZlnppeWMICpiL0wpkywEs/HtyILuETKpIrjhQ5X0Unv4JRV0XZMVKqDXINovPuma1JllUF22iI1MGcQ9fdG2y4Xiv/bdTNyf2oDmrRuAefc4rh9P4zVC3r38pVyCi+0wbJVuH1uWIuZMcoHqb4KLzvcfP8l1sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkNxMqzOzQQHjfcx+Za2pPwIXpIXTiVwwRNnDFclpkM=;
 b=QwHKulHO33E/ByNNKq8B1EnlDjFoOf+52c7nkR6NqmqHXyRHY5QdgxtL98baPLGTQ/2bm1X1B1BeqCz8PE7zpThjDWREsRtcDXQPrWoKl5krjrr8+Crl/qKtqVMpGXsQAaQqC8baCPQ8Iy6fZxALfzcifMex0Ze3QeCV6ttH8EHVqxf+pyBX0vtAYJMfIxTMB0g1oihDpBEG/Zx2OF0peYh5ZO3ucjJIx81GbRJf4kr8C9UK+Lq/4UHnrlaZ1GHuwu5LINjDpF4GJX9vTGdOO7Vomui8fFmY0CC2V416brVY1wlT3uuZcNIiOjLFPSZ06t5WuhQkv8HuAfZFXw6D+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkNxMqzOzQQHjfcx+Za2pPwIXpIXTiVwwRNnDFclpkM=;
 b=1wd9ExsjTu/52349kL8yhXdcpqahWYnFUKfISjEpZrB4S+SFI1CdCBwaO4W20CwGaVoMpJsyigH/juA0sbW5l64Th8h1dFCscHyXETu9lVV5pcb3s8TAhXgKy33I1v/f0Mpt87CjFqmEqsIvvLqGq1mLvOawyAyNvGrQI9DR8Do=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BL3PR12MB6641.namprd12.prod.outlook.com (2603:10b6:208:38d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 16:07:56 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1629:622f:93d0:f72f]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1629:622f:93d0:f72f%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 16:07:56 +0000
Message-ID: <46f93827-630a-32f0-555d-aa51a2fd2a60@amd.com>
Date:   Wed, 7 Jun 2023 11:07:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 19/20] x86/efistub: Perform SNP feature test while
 running in the firmware
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
References: <20230607072342.4054036-1-ardb@kernel.org>
 <20230607072342.4054036-20-ardb@kernel.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230607072342.4054036-20-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|BL3PR12MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2fa6f2-441a-4c0c-c16d-08db67715b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZfYnM4d/KFjaatt+LC0kn9E3l9F0umugWRWW+ai3Zy8sgkKFmoa1qpUvwWM6CvvxidBL7Huch5v+9gWPDMMXfRlQ1v0G2wb+MP7HwK59jx7oqZFkbX/KJ1Pa6lu0DTFHTXKuUzhGr0nO/Hddu+4GDilGjJTqHbyRsbtFb6t5PifipTWFVVCHGkBhPWw+ugYhug5Gb0XCjoD7AaZnl+nLn5Z4RJZJTbbgYTso9XwRxAN3tWT0zD7+M55Gsgh9bnfU8+Vbaqcq5tLcsqYIro4LoQeh1449fiKxWIjkAhNv5TY3v5aRjBMR2bXxVOuRci5Vt2kAAr/5eu+zU+map9HvD/Luf7h+sXCh8V1c8Mwk+xxqhst+03nGMZNlrPH6cd/BRoJh9s/9UDx3vCvVn0DwN6X+onwyfRZbxICXRwo9xwmHHrV7ALjRg2Hur9yp04DHJNtIBd7QTWu/wV+r8UKqblvnH6ivbXKmEoHlTsgC8dpUsGAhegvzu8AaZk7NXwMJ3lbw6WfQ9tbvMSl2hUJ2JvIxbrGtNL3QvDdzF95tFAdnFDs4VGgSpyXd8PZpz4mXIa/gfgMZ6hqCkCkMDVZ1aKPCOoMznrryeQTWZ+van8f0nk493caT7keedI21iRFyTInohGOSKHc2JgHyGAfmCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199021)(54906003)(478600001)(316002)(8676002)(8936002)(41300700001)(38100700002)(66946007)(4326008)(66476007)(66556008)(2616005)(186003)(6486002)(6666004)(83380400001)(26005)(6512007)(6506007)(53546011)(31696002)(86362001)(5660300002)(7416002)(2906002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXdVZ1p3RXk2VWdoQm4vYzBRSFRGUlBUQnVXR3lGQzNKUm1JUUJhOEV3NU9m?=
 =?utf-8?B?MVFzUXE5RURrNVFaWlZyKy9DWGQwdURXcEpzTG85L3VlWndHUW5rcmJwZHVS?=
 =?utf-8?B?NHBxd3pEK2Y5N2FuYlI5bElYdGdJR1A1VWpuQUdzWERKeXpKbk52K00yTElS?=
 =?utf-8?B?dXdOSW1sTmw3a2g3RlZaT1M5ZkZqb2F2UFE1aUVpSXp0UFVpVXNmYVBTK2w1?=
 =?utf-8?B?RmJBTk9vVk4xOCtEQVVmMkRaeDdHUi9YUzZuQXBlKzAvR3lIc1M0WFFGNmJS?=
 =?utf-8?B?VHpYWGZOengxMytnV1gyT3c3SUYxWnAxOERDVlVpUXE0MjlBUGFSaHkxaWZx?=
 =?utf-8?B?VU5tMU84dzdoNVJuZFJkdFlaTGc4Q0swN3FJN3NDS0VaeHRUbzYvVHlud0lX?=
 =?utf-8?B?RkN5MnFQSTBYR29DY1c5RXZGaHgyV3FINDF0M0wrWHlNejhwMytEekJlVEU2?=
 =?utf-8?B?aTJZMEdTSEZ6RlV3VkxjTDVYbzFRVnFadDduWjVoK3lkZVhjaldFclJPUUJU?=
 =?utf-8?B?Yjh4cG1GN0dUNHdFcVgrNE5nVDNkWGhhczhDTmpmZG1lakVKcHJOU05NeExM?=
 =?utf-8?B?aGpLeHFaeFVPVDZZV2wyZm9nVFFQTk9JSkplVVQ1WkhNWmNFSGxKTEdSa29J?=
 =?utf-8?B?ZVBuVDFjU0pYcjljUCtBcmU1V1VWUzNjWWxkeTMzYi9zTkxxL2NFVUVqRFlB?=
 =?utf-8?B?aklocWkyaVJ3SmRVUlJMRjU4QkRwMUdvUVhsR0xueG5hczczcDBVS1B3UWtU?=
 =?utf-8?B?WDAwU0dwdVE2a01VbEZIdDUwMjR6WXdFMkU4U2Qzc2JrcHlqd29ZQldEUUFM?=
 =?utf-8?B?R3BJZmd4clo3WVBzZU5hcjVKWjFSeXFLaEFsL1FVNDFrbEp6NUl1RnNoNXNw?=
 =?utf-8?B?S2FBM1hWcmgxVGQ3aXo1elQ2N1pjR2pEclN5OVJDWjhxaUZsVWxla0pReGJQ?=
 =?utf-8?B?MXVQOHJpeTVaTU12TFpzNVd6NnJoZmgwVW5wOGIrQXJoV3c5ekZmeFViTlVX?=
 =?utf-8?B?QlFpem1OL0xJYVJOdWpLOFh3QUlvVmFxeC9qREowRndvVFFLSzI1dUprWXdO?=
 =?utf-8?B?dEM4bkdybjlXZVU3Q3grWmlya05PeWI1U09xdHl2OUE4Z1VyUElHL2pINmM5?=
 =?utf-8?B?UU5DYkpuajkrWWJTNGN3dktxMTN5SFN5YTc1azR4eGZEcks2Z2NNMFozT1pk?=
 =?utf-8?B?UjluUVJHKzVaK3BOaUpqanB4ZUpYK3VjOVdWT0dMZnhjWCszQ0NteEh6NWNP?=
 =?utf-8?B?bE96d2RYd1V0NnUvSWwwdnBSckNNdUxwVGFJUGlCUnR1VUFaZU5Qbm0xNklP?=
 =?utf-8?B?TSthUnZyZEEyUFZuMFB5VXJhV2JMM3NuNFZZcktScENsZUdDdmVvbUVTdWc3?=
 =?utf-8?B?akMzUnREMmllaTN3aEFFa25ndlNIckFpN1VOd0tXSXVnNksxQkpXbFFGanlk?=
 =?utf-8?B?V3pZa2tnRHdQaHZFQUpkZ05MbGlEaG5hVC9rdnBXdEg4d3JhK3FlbTRiSmtj?=
 =?utf-8?B?S3JURExZR0ZNZWthMWFTMjUvTjdIeGJvNGdhYXlUWit1d2VGOFlkQ0hDbUhI?=
 =?utf-8?B?NDloOXdMa1Vma3BRcVM2Tmd2RjBtQ1U1enZNNWFPRitHOER5Yk5CQkxWTEo4?=
 =?utf-8?B?YmVkMzlSU2NSMkFOQkhnOG05MTQxK3hQSDB1UXRIb0FFNlppTTdWcWRGL2JG?=
 =?utf-8?B?MG41QzFLdi9FOW1KcEdmc216Z0RMdzVITUt2d1dUdU1jdzU4YjFxZ2lGd1FT?=
 =?utf-8?B?MEpTdzJoN0lJc3ZvalM1bFRCeUx0eG1QTFdtY2pwOThnSW9uajgweE9ZeWtR?=
 =?utf-8?B?QmY4T012M01IVElsNVA3eHFFNmp4U3RmYVcrNldrc1hpNXp4SXczSlRXTHJy?=
 =?utf-8?B?SHgvNjBiYlpKSmV5K3hsM0J5cnBkQ0NUVjFIVzBxN2hsYmZIODkwUGpNK1pz?=
 =?utf-8?B?WHFKbEhLcFkwWGllYmFRbE5oS1BtZC9ERXJ3Vy9yMmFqdy93M041UjJJTWlt?=
 =?utf-8?B?RG5QOHNZQmU2R0ZMeVc4ajlNdHVMMTBTOGZlYVhQVDRmc3djRFYybkc2VlIz?=
 =?utf-8?B?bmZzeDZxL0FWR24rekhja1FoaE5vOFF6OTQ3elpYTm95Nk1Kcmxxenh2bW1q?=
 =?utf-8?Q?66/sKanQ4KR+F/8x5e0K8rcsj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2fa6f2-441a-4c0c-c16d-08db67715b2e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 16:07:56.3647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ClXHN1GGaYsJ3jfdhEy4gY0v+FHsVFs/Orys9bvaebkAc8tIJfn5KZ78Usf+NNgCc3YliIXBHkloHHsXzrLAwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6641
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

On 6/7/23 02:23, Ard Biesheuvel wrote:
> Before refactoring the EFI stub boot flow to avoid the legacy bare metal
> decompressor, duplicate the SNP feature check in the EFI stub before
> handing over to the kernel proper.
> 
> The SNP feature check can be performed while running under the EFI boot
> services, which means we can fail gracefully and return an error to the
> bootloader if the loaded kernel does not implement support for all the
> features that the hypervisor enabled.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>   arch/x86/boot/compressed/sev.c          | 71 +++++++++++---------
>   arch/x86/include/asm/sev.h              |  4 ++
>   drivers/firmware/efi/libstub/x86-stub.c | 17 +++++
>   3 files changed, 62 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 09dc8c187b3cc752..9593bc80c9c6b89d 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c

...

> -void sev_enable(struct boot_params *bp)
> +u64 sev_get_status(void)
>   {
>   	unsigned int eax, ebx, ecx, edx;
>   	struct msr m;
> +
> +	/* Check for the SME/SEV support leaf */
> +	eax = 0x80000000;
> +	ecx = 0;
> +	native_cpuid(&eax, &ebx, &ecx, &edx);
> +	if (eax < 0x8000001f)
> +		return 0;
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
> +		return 0;
> +
> +	/* Set the SME mask if this is an SEV guest. */
> +	sme_me_mask = BIT_ULL(ebx & 0x3f);
> +
> +	boot_rdmsr(MSR_AMD64_SEV, &m);
> +	return m.q;
> +}
> +
> +void sev_enable(struct boot_params *bp)
> +{
>   	bool snp;
>   
>   	/*
> @@ -410,37 +447,13 @@ void sev_enable(struct boot_params *bp)
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
> +	sev_status = sev_get_status();
> +	if (!(sev_status & MSR_AMD64_SEV_ENABLED)) {
>   		if (snp)
>   			error("SEV-SNP support indicated by CC blob, but not CPUID.");

This ends up checking the CPUID path because if SEV isn't advertised in 
CPUID the returned status value is 0. But it also checks the SEV_STATUS 
MSR as well. So I think you can remove the SNP / SEV_STATUS check at the 
end of this function (since that check is identical to this now) and just 
update the message to indicate not CPUID or SEV status MSR.

The sme_me_mask should probably be cleared at this point before returning, 
too. Or, alternately, in sev_get_status(), you can update the setting of 
sme_me_mask to based on MSR_AMD64_SEV_ENABLED being set in the SEV_STATUS MSR.

>   		return;
>   	}
>   
> -	/* Set the SME mask if this is an SEV guest. */
> -	boot_rdmsr(MSR_AMD64_SEV, &m);
> -	sev_status = m.q;
> -	if (!(sev_status & MSR_AMD64_SEV_ENABLED))
> -		return;
> -
>   	/* Negotiate the GHCB protocol version. */
>   	if (sev_status & MSR_AMD64_SEV_ES_ENABLED) {
>   		if (!sev_es_negotiate_protocol())
> @@ -460,8 +473,6 @@ void sev_enable(struct boot_params *bp)
>   
>   	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
>   		error("SEV-SNP supported indicated by CC blob, but not SEV status MSR.");
> -
> -	sme_me_mask = BIT_ULL(ebx & 0x3f);
>   }
>   
>   /* Search for Confidential Computing blob in the EFI config table. */
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 86e1296e87f513b7..081c39b0e8d0d208 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -207,6 +207,8 @@ bool snp_init(struct boot_params *bp);
>   void __init __noreturn snp_abort(void);
>   int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
>   void snp_accept_memory(phys_addr_t start, phys_addr_t end);
> +u64 snp_get_unsupported_features(u64 status);
> +u64 sev_get_status(void);
>   #else
>   static inline void sev_es_ist_enter(struct pt_regs *regs) { }
>   static inline void sev_es_ist_exit(void) { }
> @@ -232,6 +234,8 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
>   }
>   
>   static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
> +static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
> +static inline u64 sev_get_status(void) { return 0; }
>   #endif
>   
>   #endif
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index abcd5703e9f3f980..1015ef883f5850a4 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -15,6 +15,7 @@
>   #include <asm/setup.h>
>   #include <asm/desc.h>
>   #include <asm/boot.h>
> +#include <asm/sev.h>
>   
>   #include "efistub.h"
>   #include "x86-stub.h"
> @@ -790,6 +791,19 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
>   	return EFI_SUCCESS;
>   }
>   
> +static bool have_unsupported_snp_features(void)
> +{
> +	u64 unsupported;
> +
> +	unsupported = snp_get_unsupported_features(sev_get_status());

This will also set sme_me_mask, but I think that is ok, since on error 
things will terminate, otherwise sev_enable() should update appropriately 
later.

Thanks,
Tom

> +	if (unsupported) {
> +		efi_err("Unsupported SEV-SNP features detected: 0x%llx\n",
> +			unsupported);
> +		return true;
> +	}
> +	return false;
> +}
> +
>   static void __noreturn enter_kernel(unsigned long kernel_addr,
>   				    struct boot_params *boot_params)
>   {
> @@ -820,6 +834,9 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
>   	if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
>   		efi_exit(handle, EFI_INVALID_PARAMETER);
>   
> +	if (have_unsupported_snp_features())
> +		efi_exit(handle, EFI_UNSUPPORTED);
> +
>   	if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES)) {
>   		efi_dxe_table = get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
>   		if (efi_dxe_table &&
