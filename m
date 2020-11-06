Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3643B2A8DA3
	for <lists+linux-efi@lfdr.de>; Fri,  6 Nov 2020 04:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgKFDlw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Nov 2020 22:41:52 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:60952 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725835AbgKFDlv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Nov 2020 22:41:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604634107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IzUX7dJoiZtub8+W7Pt0eLi27bzQQw1LPYqAgkerhmI=;
        b=ha+R4pnGi3tBOXSPUJtOFdfndt8SzzgbQPZsqwHLP0TWX2s9bsbkpSd8J5W82nM9n33SAw
        9930G/NfCFrn8MDgQcTLKA+3QPekqEmh64IshC63jTCzLPIbZTtWbZCmxcHw4tm+QHMM03
        /sPLQAL7nI4vyaBQXg+gdCECjL99vJ0=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-6-O3Gspw6LMUajbsoHH9HMdA-1; Fri, 06 Nov 2020 04:41:46 +0100
X-MC-Unique: O3Gspw6LMUajbsoHH9HMdA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lG2vPSJSbnTGZpZDHhMe1OidiczGz9AdVTRvy2ITEE+ykfTVqe9jr4mkCSjGtfN9asjqD6MPCq53uMDEKS6AE5bcEmUT8YXZAfliVmR2T/YVYjHLWL4p7f8OmFNs1wgZJSHEYgiklRLIRF7hPh9HxG7pd4A8e88KWHcM8YHx/9X5EtLyakfX9skpavg7g8QSSVsas4YPIECSMEuN1j3/cDFpcpmTroIaqbPgSt5YdMjamWQqaswhFTMlvOd+kNms7Syia5DTp3cnaAoAb/Hx7XysVcrBm1JqAEVeizdO7JzcdFFRAPovxRtDER7z/3vT2m2cmYKkyj6TxgnMfOYJ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzUX7dJoiZtub8+W7Pt0eLi27bzQQw1LPYqAgkerhmI=;
 b=KDTZD45F87qPcfDPNZEvjKxSkdGixjD2u4T5ZTRDy8WYFLKYK4lXknrwN0izhGJBwH9ag5hdktapd8EqkXQHtSmos9kC4BHHIDLB8iqpEKi9SGdZJvNxNN2l+glJLvRfRlwXft3FwsEB1a/kevWyjIc+WCkwWwezhehEKBw0E0nkA08F2Cycb/03b85Kxrk4LHF65hCbQHhKsgfrTFbLHEKog46IiM14M5k7ngHS3rrEs7mym1wSQt447fXwAHm5n+akMEp4r3rp004y3gDarzfv2arM6annTbMFsDBUgndBqa5ZaZ/GTpk/1YjFVnFHrRe5Puo2jkTANyiL6eH+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com (2603:10a6:803:57::13)
 by VI1PR04MB4016.eurprd04.prod.outlook.com (2603:10a6:803:4a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 03:41:44 +0000
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::255b:d25c:3a2b:1e8f]) by VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::255b:d25c:3a2b:1e8f%7]) with mapi id 15.20.3541.021; Fri, 6 Nov 2020
 03:41:44 +0000
Date:   Fri, 6 Nov 2020 11:41:26 +0800
From:   Chester Lin <clin@suse.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, dmitry.kasatkin@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, x86@kernel.org,
        jlee@suse.com, linux-integrity@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/3] ima: generalize x86/EFI arch glue for other EFI
 architectures
Message-ID: <20201106034126.GA17818@linux-8mug>
References: <20201102223800.12181-1-ardb@kernel.org>
 <20201102223800.12181-3-ardb@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102223800.12181-3-ardb@kernel.org>
X-Originating-IP: [118.166.51.144]
X-ClientProxiedBy: AM0PR04CA0048.eurprd04.prod.outlook.com
 (2603:10a6:208:1::25) To VI1PR04MB4928.eurprd04.prod.outlook.com
 (2603:10a6:803:57::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug (118.166.51.144) by AM0PR04CA0048.eurprd04.prod.outlook.com (2603:10a6:208:1::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Fri, 6 Nov 2020 03:41:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4824d204-29a8-4812-f583-08d88205e0fa
X-MS-TrafficTypeDiagnostic: VI1PR04MB4016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4016B6E763BF3100E22140C1ADED0@VI1PR04MB4016.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:530;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GvlncoVWLYvKtmHpMpQuoZ0XlW56pfCnmor/l5cDc7DA1F4YZRhXmU2uQ998NQq2sCeZ8WVWfiQXRmLzqGCVkOBcxKoNhDzekFUfd/Yzw66vmoxVu6UZ7ZOgGbakIRfORMSxRwsYpO8TUysrLv1oJJ56kC+Os2n831mbFX1mN1eP2l4meLQ/tZrVoC8TmLDRtLjcjygWkbBzB9eniIsfhDjUQc7YwbZroTaDBOLpjqooqeoYQpiohizPWDdAZTsrCcNasvbJZx1aos4tcDxIcXEE4kaEkIjkknypADrEs6p4bp6OAxVh5LmZi7u6XiR/LEZujg40R6GgYGJIkiFY/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4928.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(346002)(376002)(39860400002)(478600001)(26005)(8936002)(6916009)(33716001)(316002)(6666004)(1076003)(86362001)(8676002)(956004)(7416002)(5660300002)(4326008)(6496006)(52116002)(55016002)(33656002)(9686003)(66556008)(66476007)(2906002)(66946007)(16526019)(186003)(83380400001)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +tuhGIsJtgjasyqUhAV0ljlelI7IJnyXkNWk49/Gj5tgGmwaC8pu8vtTedj8dxgnNbekV5KDfo0mkV83ovzdmUK7j8EfkWRB7hIiv4QOMRxsJRDueOG5yp7HVmidezCKpMtpj1j9A+p9ayJan9cnJaAMdfUB6BvqCT5kxLMCB/SFGtYlIhUrXZRRTJFztejsb5co1GkmsZpIGa3RMz1/OXt6XDm4DisFTThN1a/oD/wAkCHLSIAZjueTcFuBY6HpXpNskzuAkNdS9dxD88hDDNCsDI4a2aKzmFGGgjndzcsMR+fxJexKUutKIh0ffyef8g7OwGEtggF/oEWFTmHpCOsWeeXPuucC1J8IoRdiDDrQdQvxa0OHi+EGfSUmEC3Mym6jSYYajSz7TrRd3RElR+CvIzyJp2ZofapVToGkbewTb6XTET9QD8n1WRTYGq2vkCvKvMLEP7zecVgCcEgwx2QslbkX2UmgptfRyhawNnw0YJP30o7gr0E689L5Qqt7AdsTYLuXAU6tEiEh7EVi5WmFwjtcXeQMcoSwP4py2N6A9+FAp1Lyy+x0EI33X6xxqWVNPAv6k/XtVg3w3L/lsBb6eOYVoBiNtR98jQuJNfH+6Yu73b9i6+UpmlGWdBNWldEOdxjPRvK3kNYLC0RHO5dPK4KLKCxtWynpV0CJfuOGGgwspQcC4GokqG/Xqguo8zyWnMzQECADkaJs5tUQ7uDY7eMbKxq+/9uno5wR4BYyAyTwu7CS+D7wQHhND6Z+PTh3cX48317YPZoWiay6ZdsIdjMGfQuopPH1N2e9+BTbhC9MCAVB31kVOjPf2xQnK26WiISGDYXRPjBmOXmNhbLexEHyeJqqsQdpKg+mM31zhTkzY5x2DDAX9lAZhgSFrHrqLucuJhQYpEKYDDQCCQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4824d204-29a8-4812-f583-08d88205e0fa
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4928.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 03:41:44.0971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptY38Fs6vl0RmKtKL4VnjJHdmd58CLmO7kxyhxDTmeHRaACr11ChAYlwkGwLgP16
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4016
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Mon, Nov 02, 2020 at 11:37:59PM +0100, Ard Biesheuvel wrote:
> From: Chester Lin <clin@suse.com>
> 
> Move the x86 IMA arch code into security/integrity/ima/ima_efi.c,
> so that we will be able to wire it up for arm64 in a future patch.
> 
> Co-developed-by: Chester Lin <clin@suse.com>
> Signed-off-by: Chester Lin <clin@suse.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/include/asm/efi.h                                     |  3 ++
>  arch/x86/kernel/Makefile                                       |  2 -
>  security/integrity/ima/Makefile                                |  4 ++
>  arch/x86/kernel/ima_arch.c => security/integrity/ima/ima_efi.c | 45 ++++++--------------
>  4 files changed, 19 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index 7673dc833232..c98f78330b09 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -380,4 +380,7 @@ static inline void efi_fake_memmap_early(void)
>  }
>  #endif
>  
> +#define arch_ima_efi_boot_mode	\
> +	({ extern struct boot_params boot_params; boot_params.secure_boot; })
> +
>  #endif /* _ASM_X86_EFI_H */
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 68608bd892c0..5eeb808eb024 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -161,5 +161,3 @@ ifeq ($(CONFIG_X86_64),y)
>  	obj-$(CONFIG_MMCONF_FAM10H)	+= mmconf-fam10h_64.o
>  	obj-y				+= vsmp_64.o
>  endif
> -
> -obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)	+= ima_arch.o
> diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
> index 67dabca670e2..2499f2485c04 100644
> --- a/security/integrity/ima/Makefile
> +++ b/security/integrity/ima/Makefile
> @@ -14,3 +14,7 @@ ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
>  ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
>  ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
>  ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
> +
> +ifeq ($(CONFIG_EFI),y)
> +ima-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT) += ima_efi.o
> +endif
> diff --git a/arch/x86/kernel/ima_arch.c b/security/integrity/ima/ima_efi.c
> similarity index 60%
> rename from arch/x86/kernel/ima_arch.c
> rename to security/integrity/ima/ima_efi.c
> index 7dfb1e808928..233627a9d4b8 100644
> --- a/arch/x86/kernel/ima_arch.c
> +++ b/security/integrity/ima/ima_efi.c
> @@ -5,50 +5,29 @@
>  #include <linux/efi.h>
>  #include <linux/module.h>
>  #include <linux/ima.h>
> +#include <asm/efi.h>
>  
> -extern struct boot_params boot_params;
> +#ifndef arch_ima_efi_boot_mode
> +#define arch_ima_efi_boot_mode efi_secureboot_mode_unknown

I think this should be "efi_secureboot_mode_unset" otherwise the get_sb_mode()
will never be called. The others look good to me, thanks for your help.

Regards,
Chester

> +#endif
>  
>  static enum efi_secureboot_mode get_sb_mode(void)
>  {
> -	efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
> -	efi_status_t status;
> -	unsigned long size;
> -	u8 secboot, setupmode;
> -
> -	size = sizeof(secboot);
> +	enum efi_secureboot_mode mode;
>  
>  	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
>  		pr_info("ima: secureboot mode unknown, no efi\n");
>  		return efi_secureboot_mode_unknown;
>  	}
>  
> -	/* Get variable contents into buffer */
> -	status = efi.get_variable(L"SecureBoot", &efi_variable_guid,
> -				  NULL, &size, &secboot);
> -	if (status == EFI_NOT_FOUND) {
> +	mode = efi_get_secureboot_mode(efi.get_variable);
> +	if (mode == efi_secureboot_mode_disabled)
>  		pr_info("ima: secureboot mode disabled\n");
> -		return efi_secureboot_mode_disabled;
> -	}
> -
> -	if (status != EFI_SUCCESS) {
> +	else if (mode == efi_secureboot_mode_unknown)
>  		pr_info("ima: secureboot mode unknown\n");
> -		return efi_secureboot_mode_unknown;
> -	}
> -
> -	size = sizeof(setupmode);
> -	status = efi.get_variable(L"SetupMode", &efi_variable_guid,
> -				  NULL, &size, &setupmode);
> -
> -	if (status != EFI_SUCCESS)	/* ignore unknown SetupMode */
> -		setupmode = 0;
> -
> -	if (secboot == 0 || setupmode == 1) {
> -		pr_info("ima: secureboot mode disabled\n");
> -		return efi_secureboot_mode_disabled;
> -	}
> -
> -	pr_info("ima: secureboot mode enabled\n");
> -	return efi_secureboot_mode_enabled;
> +	else
> +		pr_info("ima: secureboot mode enabled\n");
> +	return mode;
>  }
>  
>  bool arch_ima_get_secureboot(void)
> @@ -57,7 +36,7 @@ bool arch_ima_get_secureboot(void)
>  	static bool initialized;
>  
>  	if (!initialized && efi_enabled(EFI_BOOT)) {
> -		sb_mode = boot_params.secure_boot;
> +		sb_mode = arch_ima_efi_boot_mode;
>  
>  		if (sb_mode == efi_secureboot_mode_unset)
>  			sb_mode = get_sb_mode();
> -- 
> 2.17.1
> 

