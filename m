Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC54128DF66
	for <lists+linux-efi@lfdr.de>; Wed, 14 Oct 2020 12:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgJNKvb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 14 Oct 2020 06:51:31 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:40788 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729152AbgJNKv2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 14 Oct 2020 06:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1602672685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ugQwd3vj8om8WZi9XuvKU62bPSdJzUn+86/IOgt+JOI=;
        b=MgQo44CPrkO3MVTVMBDqHgREyIJr0MVn01IZnCxs57QGwVxp0kMwES9IZFM2WJwBhWpPpb
        wNPDbtLU25p+jk6XcI4B/mGzKxvneQwzGxojKg4DnaqpR7bvXfaP6IL48xxF8Q0fxyJ/+Z
        U0rMEI8nNMtWK3RvepQX7rBSjHzp/wU=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-10-QbA4s-nlO5GdPTK_HWC2-A-1; Wed, 14 Oct 2020 12:51:23 +0200
X-MC-Unique: QbA4s-nlO5GdPTK_HWC2-A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0UiLFoKmn67jtrBM8NeKW8rohW6RI3Q5R9D981zPpfdkiJdGK+wZFbxy4w6P+TugGFCfsGU9tTtqxo96eAoa4THlBMgkAii5HVTkRrU8FzG8cpiiyAHuaixL6Dcp4lZFbd2WHBLB9KhYb6ZY0wh/Ap1CVx7DW8blAYWRC4Fy4eyG1wHx+Z9Hq1K6grpfIedFn4LtZ6xuIsfOkCITuF3ItMLn76PjtCmhx+l3XXSSrT7j2P9eUhHc9aUH0IewbbdVv6gw7/OxpDpDjhOfgO66CgvZ4RWQcmYVdOybalDLRjcAnnj6SHrWdv1fVNtXq1cX3k6BevwTW3Z8TyCX9xvfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugQwd3vj8om8WZi9XuvKU62bPSdJzUn+86/IOgt+JOI=;
 b=UOC0cIlOy5amVT5gDtZ30LuEtEG6BtHUwZpu+DeGjyTZzyjTMMVrn7vmco5wC/eN+FO5v2d/OXbfDA3NNUadQyP5ApReLET3e2fd7bupAw2q8fz4BJ+O/gApVpTw+2eLDv2/J2cjrOV3YXKWfa7hnLEtNtv+JOt9LksVWfHV6ldX0pXY46Je0JAOtV3CrAY1Oy8+JdWNl7NGYaOqW+eFGtYuYF25TK7VDUlxRpwgIsxnhxmFmnysDa59WvRo2IaObHvY2wIzSLbKpd51SKjeGEeEoFv+xM+AsPVMKpwIcpD98QqcdL1GBelIj67AFJP1i8/dJ9DFFQ8XVJWmFaUwQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com (2603:10a6:803:57::13)
 by VI1PR0402MB3823.eurprd04.prod.outlook.com (2603:10a6:803:19::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Wed, 14 Oct
 2020 10:51:21 +0000
Received: from VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::e922:583c:a9bf:66e0]) by VI1PR04MB4928.eurprd04.prod.outlook.com
 ([fe80::e922:583c:a9bf:66e0%6]) with mapi id 15.20.3477.020; Wed, 14 Oct 2020
 10:51:21 +0000
Date:   Wed, 14 Oct 2020 18:51:02 +0800
From:   Chester Lin <clin@suse.com>
To:     zohar@linux.ibm.com, ardb@kernel.org, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, samitolvanen@google.com, masahiroy@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-efi@vger.kernel.org, jlee@suse.com, clin@suse.com
Subject: Re: [PATCH v2 1/2] efi: add secure boot get helper
Message-ID: <20201014105102.GA9912@linux-8mug>
References: <20201014104032.9776-1-clin@suse.com>
 <20201014104032.9776-2-clin@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014104032.9776-2-clin@suse.com>
X-Originating-IP: [118.166.52.150]
X-ClientProxiedBy: AM3PR07CA0128.eurprd07.prod.outlook.com
 (2603:10a6:207:8::14) To VI1PR04MB4928.eurprd04.prod.outlook.com
 (2603:10a6:803:57::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug (118.166.52.150) by AM3PR07CA0128.eurprd07.prod.outlook.com (2603:10a6:207:8::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.13 via Frontend Transport; Wed, 14 Oct 2020 10:51:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf258fe1-7dee-4180-3de7-08d8702f1662
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3823:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB38231ADDFE5A97991AF424FDAD050@VI1PR0402MB3823.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wIbT1X/BRoCxvKjsI9U8b4E6kkTH+yWDXkubuhW3GD5943e0/aO8QRzQSEEtSeqHv9AWonIQkVYFvMyl58rAjCyB0+OgE+1kxi8GHHvdRK/puLi9UReiMDpNxVaLDc1txgpYIKuHKle3zQ4DQ5KPFmZi51BVim8zk9e7RL2URbOwkkDD807dNvneTPbbVh3C/1l3RtkM8gMqgL0r9cPoPDZsmrrZAwZJI4ELfEZgXgrSZ4Vi/2lAcsG00yz1rYbTGkAQtSZ1k1M+5Tqj9jdart5eKuy2g5tyVduk2pJrYtyAxw3BcPkbFkTGtM0NuscrSDPa7+qYUU5YuVaxJaP08nL6XhsBuRLljQlgG89mrFDo5lfNpEgLfm1bV2OjZ0Il
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4928.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(366004)(39860400002)(376002)(478600001)(55236004)(2906002)(66476007)(26005)(16526019)(66946007)(4326008)(66556008)(956004)(33716001)(86362001)(5660300002)(52116002)(316002)(33656002)(8676002)(9686003)(8936002)(186003)(7416002)(83380400001)(107886003)(6666004)(1076003)(55016002)(6496006)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: JGiWn0MGrX/lAnCOERR1A1oHJiyFe89aPq0CdGHEtTs3j5qkIv3rG6IaXnQ0cJhngw6m+aXGl9Fgst+gHX8Zy8vR2a4c/T6M7bSsn5CGpmpYTwD+zKGlIqF4bb71UzpiSJ3pcRjw7fBblfsq30nTvahaN7hkyTivtCCP7oMmr/eVQYECuRrHM9UNIzaamL/pY45njMeUIZnx6TbQIZF8X9rzBpGae9ZX+xytg239Dj5MM+RsWSq7C1TiaOm2CdDfsknHnfkATLMSH7ANXumOrAvxNkBxbFo8zTe5ZHqrenQsnAu0OMgb9DBxCCwApewDJRnSY9P/Rf1Bm6ljAQakrqHKT9F83R8YFGRE9EUXG4cRY6jX5ykdlc2hVq04zjplAJApowvWNTerCDxF4ZJXTNhCISxALsXWopgILpHUHGPJd5pKfCr7dJJ1wBZYTDOObAc0xCGZ9gBDLE6X9HxI7J7fNdrjT8ZLAM8CT4eX8+jcbfsTZh4N4EE3NI9sZj5l2rWdoke54csJD2veZoWeliea3bZEI7DGMTPWPidYEkKD1vHDSz+xJunSwbIZunKEsESdoql36/pSYq6IKfKZmUP63lWuq4p7QNxbZoz00eQ1YS22Ys8ISxQ7MwAZHbEDWd8/D96n1ZqYo+1zqruOoQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf258fe1-7dee-4180-3de7-08d8702f1662
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4928.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 10:51:21.8043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PoQzZ3nHUIlPO6LKt/0CKwLKVkzrmxfwvn1nNc2tbna1Qte8PPqFTBWXO3Y3BI3j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3823
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard and Mimi,

On Wed, Oct 14, 2020 at 06:40:31PM +0800, Chester Lin wrote:
> Separate the get_sb_mode() from arch/x86 and treat it as a common function
> [rename to efi_get_secureboot_mode] so all EFI-based architectures can
> reuse the same logic.
> 
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  arch/x86/kernel/ima_arch.c | 47 ++------------------------------------
>  drivers/firmware/efi/efi.c | 43 ++++++++++++++++++++++++++++++++++
>  include/linux/efi.h        |  5 ++++
>  3 files changed, 50 insertions(+), 45 deletions(-)
> 
> diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
> index 7dfb1e808928..ed4623ecda6e 100644
> --- a/arch/x86/kernel/ima_arch.c
> +++ b/arch/x86/kernel/ima_arch.c
> @@ -8,49 +8,6 @@
>  
>  extern struct boot_params boot_params;
>  
> -static enum efi_secureboot_mode get_sb_mode(void)
> -{
> -	efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
> -	efi_status_t status;
> -	unsigned long size;
> -	u8 secboot, setupmode;
> -
> -	size = sizeof(secboot);
> -
> -	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
> -		pr_info("ima: secureboot mode unknown, no efi\n");
> -		return efi_secureboot_mode_unknown;
> -	}
> -
> -	/* Get variable contents into buffer */
> -	status = efi.get_variable(L"SecureBoot", &efi_variable_guid,
> -				  NULL, &size, &secboot);
> -	if (status == EFI_NOT_FOUND) {
> -		pr_info("ima: secureboot mode disabled\n");
> -		return efi_secureboot_mode_disabled;
> -	}
> -
> -	if (status != EFI_SUCCESS) {
> -		pr_info("ima: secureboot mode unknown\n");
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
> -}
> -
>  bool arch_ima_get_secureboot(void)
>  {
>  	static enum efi_secureboot_mode sb_mode;
> @@ -60,7 +17,7 @@ bool arch_ima_get_secureboot(void)
>  		sb_mode = boot_params.secure_boot;
>  
>  		if (sb_mode == efi_secureboot_mode_unset)
> -			sb_mode = get_sb_mode();
> +			sb_mode = efi_get_secureboot_mode();
>  		initialized = true;
>  	}
>  
> @@ -70,7 +27,7 @@ bool arch_ima_get_secureboot(void)
>  		return false;
>  }
>  
> -/* secureboot arch rules */
> +/* secure and trusted boot arch rules */
>  static const char * const sb_arch_rules[] = {
>  #if !IS_ENABLED(CONFIG_KEXEC_SIG)
>  	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig",
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 5e5480a0a32d..68ffa6a069c0 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c

I hope you don't mind that I temporarily move the get_sb_mode() to efi
since I'm not sure which place is better. Please let me know if any
suggestions.

Thanks,
Chester

> @@ -1022,3 +1022,46 @@ static int __init register_update_efi_random_seed(void)
>  }
>  late_initcall(register_update_efi_random_seed);
>  #endif
> +
> +enum efi_secureboot_mode efi_get_secureboot_mode(void)
> +{
> +	efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
> +	efi_status_t status;
> +	unsigned long size;
> +	u8 secboot, setupmode;
> +
> +	size = sizeof(secboot);
> +
> +	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
> +		pr_info("ima: secureboot mode unknown, no efi\n");
> +		return efi_secureboot_mode_unknown;
> +	}
> +
> +	/* Get variable contents into buffer */
> +	status = efi.get_variable(L"SecureBoot", &efi_variable_guid,
> +				  NULL, &size, &secboot);
> +	if (status == EFI_NOT_FOUND) {
> +		pr_info("ima: secureboot mode disabled\n");
> +		return efi_secureboot_mode_disabled;
> +	}
> +
> +	if (status != EFI_SUCCESS) {
> +		pr_info("ima: secureboot mode unknown\n");
> +		return efi_secureboot_mode_unknown;
> +	}
> +
> +	size = sizeof(setupmode);
> +	status = efi.get_variable(L"SetupMode", &efi_variable_guid,
> +				  NULL, &size, &setupmode);
> +
> +	if (status != EFI_SUCCESS)	/* ignore unknown SetupMode */
> +		setupmode = 0;
> +
> +	if (secboot == 0 || setupmode == 1) {
> +		pr_info("ima: secureboot mode disabled\n");
> +		return efi_secureboot_mode_disabled;
> +	}
> +
> +	pr_info("ima: secureboot mode enabled\n");
> +	return efi_secureboot_mode_enabled;
> +}
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index d7c0e73af2b9..a73e5ae04672 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1076,8 +1076,13 @@ static inline int efi_runtime_map_copy(void *buf, size_t bufsz)
>  
>  #ifdef CONFIG_EFI
>  extern bool efi_runtime_disabled(void);
> +extern enum efi_secureboot_mode efi_get_secureboot_mode(void);
>  #else
>  static inline bool efi_runtime_disabled(void) { return true; }
> +static inline enum efi_secureboot_mode efi_get_secureboot_mode(void)
> +{
> +	return efi_secureboot_mode_disabled;
> +}
>  #endif
>  
>  extern void efi_call_virt_check_flags(unsigned long flags, const char *call);
> -- 
> 2.26.1
> 

