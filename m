Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D236B720A67
	for <lists+linux-efi@lfdr.de>; Fri,  2 Jun 2023 22:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbjFBUit (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Jun 2023 16:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjFBUit (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Jun 2023 16:38:49 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B6FE43;
        Fri,  2 Jun 2023 13:38:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bpa1Qz8mQ48C+tccseUuvXb5rPNdxiKz2H7pDe+qr8ge9MaZwwXWPpH+bhkbtT6uXIqnbaz+KPZ05C+kvbYDVKB730aEPzOY7pswfB1ESD2G+k7tvuPG5LSIMcEKr4c1VnjGrgV8ls58RPfXCiK711LmKROrrmzAE6BKal8vRZrSgXqz1F6RZ+tuUjzXBelG/ckyOvvLFLqDpoPLgx7LPkSaoY4h6z9TvjyIqQc/PfjVKQug6kT2YpeLPUWMm85ZQgWEP2Mwt6O885v7TJiQXSYw8jjCd0hXa1nbUGkDd+hif/Gkp06QClw1HHMNPQcbHXCHQWWRWwGtYvRdf4nT6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8K/2jshE2AUW/bld4yiVdQivxkt4H5/Bftkbr8/0BM=;
 b=Sfl1KSJgJ8lGOZkLYCvo3rBgkLNDpGhbIosNQXmDp5WzEKsLcvxI90hViaFD0ijq+pbpdmSTUzr+7d0G/8VhNzyWM1DN29J9UTWP5q4GTnrzgsCub7r39s1LI8DKooKxM9RADYpVMedvswRZ32YwZrl+zijtay3jEWd6Q8e70KhqrE8efP/45sfMfmuCOWR+zmNMMuGwutvqQq9EmwnO9F+ZYMa3HNuyMhcDvt/rsLZG9o3nl2O7oBWQ2mvADFfDvQ4T9hN21h7lMqdsxs5inRmfAxWMkijczUyMrWcGA4euIgYmvQw1UwZVuf+ySdFuowaymSYOGmF+Vm4fiO5TsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8K/2jshE2AUW/bld4yiVdQivxkt4H5/Bftkbr8/0BM=;
 b=fN+l+ww83MZmqz0dDQNlXt1AUdMuJJves74vb5uBGj7D1DdpnhkRIBNEvp08EltBqKAYpqX4xc1FBw8959G4FN0l51xPuo3CV29/ViKCLsOBiHvYEcpQSp1rqffQcPSWpV2qibJC8b7wPCMNgdgpr/i8vV63DfyO5GmgeAACACs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26; Fri, 2 Jun
 2023 20:38:41 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::61f6:a95e:c41e:bb25]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::61f6:a95e:c41e:bb25%3]) with mapi id 15.20.6455.026; Fri, 2 Jun 2023
 20:38:41 +0000
Message-ID: <bfe5bbac-37e2-6728-606a-c652bafad6b6@amd.com>
Date:   Fri, 2 Jun 2023 15:38:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 20/21] x86/efistub: Perform SNP feature test while
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
References: <20230602101313.3557775-1-ardb@kernel.org>
 <20230602101313.3557775-21-ardb@kernel.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230602101313.3557775-21-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0011.namprd21.prod.outlook.com
 (2603:10b6:805:106::21) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c42311-6a08-42dc-c6f6-08db63a959cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4S+yBP1juQV/xSQpWrfmR4iC7Cr9AbT9/mT6+9IgFNf+ZfvqW4M42ecTfJDy0xVD9jfi8R2HllynFugZj6s8MwF5xe2FN8FlAysCwwVDGnTGnZCKvWdPegG9HVCJSjL/wAcRnuYioAZuyDLBbQyzsHUGVcmBShjXXZVNfbhTZ5WThrfB3j0n37Fp2byTdbhEd2fPOLppPYoYu6RM0VtnKFRj1F0D2gL4PBRcsp09lbLbe3PQRntdDDEonFQbbreD+lXcBXHrRHCpR6FVNCm6B3eV2CIDAiWtooSgHLYuIhW+fRKdG7Z8zoLA4y+TKn0RT0kHc4k1mjgQZwuKmniFdTinUz1ATq79p1UjitksKBGgDy7MY+NVTz7jCpVUSHueRBiiHE4wBWg7MD2H6hPD0xR6RvJ9rTmMabiKwbtyvwf2e+M+FZsubOLhMQue7KfOhbj6oYcneorjmQ2rv8pnV3RbIsMtjlS85eAApVecW6WfSsjDAw6zPCtGg/Pcw/aluwneZEYF74Mcs8tFdtH7WZ0FkUPekAXxTERf81ZMXN3kDcT/vLDpvp5TaSDZAM/dk2b3KhUTwLQOwMaY6xfjbI7QACHTAQEubiFvtGEwkrLKlNBBZIxzgtyj87MU2DkKXqW/kQFu99UX8GCogaJmLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199021)(36756003)(2616005)(83380400001)(2906002)(86362001)(31696002)(38100700002)(6486002)(41300700001)(316002)(6666004)(5660300002)(8676002)(8936002)(478600001)(54906003)(66476007)(66946007)(4326008)(31686004)(6506007)(6512007)(66556008)(26005)(53546011)(186003)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUxTM3BVRkRRK0lRMC9FMDhodVdpTmtQN1A1eXZKek1WOWhSL0tVNm5ISVds?=
 =?utf-8?B?QUFPUTAvTXBnakltdG8zbXIxSjBadzIzZ0FIODFOSFhPdTJSblRub0VPcnF3?=
 =?utf-8?B?WFFwNDNnM0szWWhZcGw3YWpLM1ZlRHBLRUZ2OHlxUUpnckFEaU5UZHJ4aUZ6?=
 =?utf-8?B?R1B6aFFFcFlOcFppb1pJRDJqSnJ6RE1vb1J5UGxWZnBDRnZWTHlrdHFwTHpj?=
 =?utf-8?B?N2twcGVCZGFvUURhaGM1K2p4alVTcVFRRHZDMmF6Qnc5UmM5aUh6b0gwQ21y?=
 =?utf-8?B?WmM1RWJiSktDOVdoQjBVemlaVVBRZk9NV25qcHE5YnJ3SUJNZ0Q2V1ZVVzZV?=
 =?utf-8?B?N0F3VlhJNUdNR2t6NDB3VHhWejN5cXZ1Skh4a1p2QUNSanhiYndrZW9INi9s?=
 =?utf-8?B?VktydWw2djBVSGZyaXIrTHk0RmcyaVRBNEozNWlOWlQrK1k2YVk5UEV3eG9E?=
 =?utf-8?B?Y2ZFMjZIUGlLcS9NSzMwNU42MXY4YTVsRmlvUW5zVzVtNkhwbXUyL3VLSjI5?=
 =?utf-8?B?T1dKVitPUVIrUG1EblJqYmpNYlpuMy85KzdQdWlhalVmM3pvZk8xMFZSakJ5?=
 =?utf-8?B?QWJQK1BZTFgzMTZrVE4rbXZyZ3hhR0pxWDI4RDQyQjFwSktIaE5xRTZHbC9x?=
 =?utf-8?B?YnM1YVZPbDlwSm9SelZqbStPY3d2OWhZa0NCSkVtZExoMkVsSXF0Q2h3SE5x?=
 =?utf-8?B?ZlBOUXU0K3hLWW4wODRNcHkvcVhSV2pIQStuQStycDNHcTRQYjU3NDdHcElh?=
 =?utf-8?B?cm5qT09oWEcwYjU4Z3hYYjNkbloxYk4xbmRUWDNBb291VXFGZkxLcXNmbG83?=
 =?utf-8?B?ZnRLU1FyMlpqZlFJTHJpWEpmQWgrNTFIYmt5QmFPZ2REMzJnQnZ0UHBZQ2E2?=
 =?utf-8?B?MTBiRFE4VUtmbHcvK3NHOTM2TGtabXFJQmxWekpLL25JQlBWUHExRk5kVmdi?=
 =?utf-8?B?WER4czRQeXhaMDN6MmV6MEk0RXlTeERFOWQ1QWRBRkw5V05KTndQalRsNEMy?=
 =?utf-8?B?cVlFVkZpQTVvd3c1cWFBeXQxN24vY3BycEZsT29NVXQ2TnplL3BOQ056UTVK?=
 =?utf-8?B?aDlIcVIzNWZoanNDR3hYalhoeDhZV2psVE8wdWpzOVZmNWxWdDErL1ZoRDhk?=
 =?utf-8?B?RldraUc0aWQ1NFdrRnVFM280V3I4dlpxQ1hkQitpRWNDNzVpaUw3eWp6TzVM?=
 =?utf-8?B?MkJ3TDh3VVQ3Q000Ym9NS1VZbXgySFk0TzYvS2dkTHJSNCtGdTlMUWpYOG9D?=
 =?utf-8?B?VVA1N0s5L1RTa0tZVWNSRUxvTjRTS0F5QkdPQjVFdFBsdnNES2lsN2FQallO?=
 =?utf-8?B?NHQyVlhCUVRyK1dUNkVIWjJkNDVxcytlUU9BY0RmRHlKWHFrMDAvZFozSDVK?=
 =?utf-8?B?QlFvNXd2OHBNU0NsdkxFU1dBZGdmL0YyWW9oWUVsZlZYcjZKNnpJc2xpZ2Qw?=
 =?utf-8?B?Z1RDN1ZIR0tnWG14TGR1Zk5NdGZ5MmJpWTRKbjNpd1NUMzE3MFpmeG5nZWlx?=
 =?utf-8?B?RTdIekJrMmRRUlFKNkhYQm55SWUyNEJjWlRWRlIrS3ZjOWZRUE5KN0p0OWpQ?=
 =?utf-8?B?YmpQSjBKWHJodzJvQWZFOVNtaGEyQjMramxpcW1HcVorcmV4eE1LYWJReFo4?=
 =?utf-8?B?ZHhNNzJXYWZkZjFuU0FKVkhFcllQTlQ4aEgvVG9QZTB4T0ZaL0R6cHdmbHFF?=
 =?utf-8?B?WmkwMjl5Mm9XZTVJOGh4MndGLzhzOVBEZGt2ZjMwZ3NkV2NlTitIeXUrenhN?=
 =?utf-8?B?N2FrNys3eDlsNS9HeGd5bFdsMllVbVpaQ2pDTW4yQkM2WG9RelpjREE2blhn?=
 =?utf-8?B?U3p6eGM1ZXhSYVBvd3hvSjNlM09abWlCS203YnAzUVRBcTNzeFNtekVGZ3dU?=
 =?utf-8?B?NWZFUGNTZ3ZqZFZJci91QUdSSUJzbkowUUt3a05HU0E4cW10ZmZDem9LTEZs?=
 =?utf-8?B?NW5OdXVuVkZYSHNWYkZxMTZQWk94V1lZYmIvbUxWeWptZWZqRUJVWnJZSEhY?=
 =?utf-8?B?L1BuZWZ6TUxraGFGLzFDd01wVHF3TXQrNlR2by9yb3dubVdYay9JQTU1OG9i?=
 =?utf-8?B?U3YvUjVqWTBhOE50ZTVvZ0NkVVNSREZSN3NCZytjRTUyRHU5cC9ZTTVEQ3RR?=
 =?utf-8?Q?NqMs8H00/+NZEVqv8jzK77zjg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c42311-6a08-42dc-c6f6-08db63a959cc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 20:38:41.2166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlCBZG+8Z61VBP/r3BG/J7Ch47BxFQDv6TaoPIV/nBYyNgTduPHWqf1YPMvErEikSagdZ4F0l3g95j5azb8PdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254
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

On 6/2/23 05:13, Ard Biesheuvel wrote:
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
>   arch/x86/boot/compressed/sev.c          | 74 ++++++++++++--------
>   arch/x86/include/asm/sev.h              |  4 ++
>   drivers/firmware/efi/libstub/x86-stub.c | 17 +++++
>   3 files changed, 67 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 014b89c890887b9a..be021e24f1ece421 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c


> +void sev_enable(struct boot_params *bp)
> +{
> +	unsigned int eax, ebx, ecx, edx;
>   	bool snp;
>   
>   	/*
> @@ -358,37 +391,14 @@ void sev_enable(struct boot_params *bp)
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
> +	/* Set the SME mask if this is an SEV guest. */
> +	sev_status = sev_get_status();
> +	if (!(sev_status & MSR_AMD64_SEV_ENABLED)) {
>   		if (snp)
>   			error("SEV-SNP support indicated by CC blob, but not CPUID.");
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
> @@ -409,6 +419,14 @@ void sev_enable(struct boot_params *bp)
>   	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
>   		error("SEV-SNP supported indicated by CC blob, but not SEV status MSR.");
>   
> +	/*
> +	 * Check for the SME/SEV feature:
> +	 *   CPUID Fn8000_001F[EBX]
> +	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
> +	 */
> +	eax = 0x8000001f;
> +	ecx = 0;
> +	native_cpuid(&eax, &ebx, &ecx, &edx);

This causes SEV-ES / SEV-SNP to crash.

This goes back to a previous comment where calling either 
sev_es_negotiate_protocol() or get_hv_features() blows away the GHCB value 
in the GHCB MSR and as soon as the CPUID instruction is executed the boot 
blows up.

Even if we move this up to be done earlier, we can complete this function 
successfully but then blow up further on.

So you probably have to modify the routines in question to save and 
restore the GHCB MSR value.

Thanks,
Tom

>   	sme_me_mask = BIT_ULL(ebx & 0x3f);
>   }
>   
