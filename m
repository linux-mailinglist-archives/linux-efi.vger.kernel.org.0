Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBD059FED4
	for <lists+linux-efi@lfdr.de>; Wed, 24 Aug 2022 17:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbiHXPwk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 24 Aug 2022 11:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236946AbiHXPwj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 24 Aug 2022 11:52:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0251372FC9;
        Wed, 24 Aug 2022 08:52:37 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9859329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9859:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 34B1D1EC056A;
        Wed, 24 Aug 2022 17:52:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661356352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PBu2N2uipsqYRGU8bx2yq7gJv2+9Y2U5mdyTj0+/pTM=;
        b=NB6YSRe/Ed3rUtDV9uiZDCWOh1AmqVaLjJr7swohSQBgEXc9Ml8+K+1qPwkVzabBT+Lz+T
        0msrtdaC0S4A2mcX1OGqoxMuRHKbJNsW4RW5QLHEAY54tdqwlaA3FCXV6qpt2FqWjsiKmf
        lRgsjSTC8LFhYEx4jgXYcDjls9XERvQ=
Date:   Wed, 24 Aug 2022 17:52:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jia He <justin.he@arm.com>
Cc:     Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-doc@vger.kernel.org
Subject: Re: [RESEND PATCH v3 4/9] EDAC/ghes: Move ghes_edac.force_load to
 setup parameter
Message-ID: <YwZJP25sfKcfw9eT@zn.tnic>
References: <20220822154048.188253-1-justin.he@arm.com>
 <20220822154048.188253-5-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220822154048.188253-5-justin.he@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Aug 22, 2022 at 03:40:43PM +0000, Jia He wrote:
> ghes_edac_init() is too late to set this module flag ghes_edac.force_load.
> Also, other edac drivers should not be able to control this flag.
> 
> Move this flag to setup parameter in ghes.
> 
> Suggested-by: Toshi Kani <toshi.kani@hpe.com>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  5 +++
>  drivers/acpi/apei/ghes.c                      | 24 +++++++++++-
>  drivers/edac/ghes_edac.c                      | 38 +++++++------------
>  include/acpi/ghes.h                           |  7 +++-
>  4 files changed, 46 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index d7f30902fda0..a5f0ee0d7727 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1593,6 +1593,11 @@
>  			When zero, profiling data is discarded and associated
>  			debugfs files are removed at module unload time.
>  
> +	ghes_edac_force= [X86] Skip the platform check and forcibly load the

So there already is ghes.disable which is using the module param thing.
Why don't you do that too?

> +			ghes_edac modules.

"module" - singular.

> +			Format: <bool>
> +			default: false (0)
> +
>  	goldfish	[X86] Enable the goldfish android emulator platform.
>  			Don't use this when you are not running on the
>  			android emulator
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 9c52183e3ad9..e17e0ee8f842 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -94,6 +94,26 @@
>  #define FIX_APEI_GHES_SDEI_CRITICAL	__end_of_fixed_addresses
>  #endif
>  
> +/*
> + * "ghes_edac_force=1" forcibly loads ghes_edac and skips the platform
> + * check.
> + */
> +bool __read_mostly ghes_edac_force;
> +EXPORT_SYMBOL(ghes_edac_force);
> +
> +static int __init setup_ghes_edac_load(char *str)
> +{
> +	if (str)
> +		if (!strcmp("true", str) || !strcmp("1", str))
> +			ghes_edac_force = true;
> +
> +	if (!IS_ENABLED(CONFIG_X86))
> +		ghes_edac_force = true;
> +
> +	return 1;
> +}
> +__setup("ghes_edac_force=", setup_ghes_edac_load);

Why all that?

Isn't specifying

ghes.edac_force_load

on the kernel command line enough? I.e., you don't need to parse the
passed in option - just the presence of the parameter is enough.

> +
>  static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
>  
>  static inline bool is_hest_type_generic_v2(struct ghes *ghes)
> @@ -1517,13 +1537,13 @@ static struct acpi_platform_list plat_list[] = {
>  	{ } /* End */
>  };
>  
> -struct list_head *ghes_get_devices(bool force)
> +struct list_head *ghes_get_devices(void)
>  {
>  	int idx = -1;
>  
>  	if (IS_ENABLED(CONFIG_X86)) {
>  		idx = acpi_match_platform_list(plat_list);
> -		if (idx < 0 && !force)
> +		if (idx < 0 && !ghes_edac_force)
>  			return NULL;
>  	}
>  
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index bb3ea42ba70b..6a2b54cc7240 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -54,10 +54,6 @@ static DEFINE_MUTEX(ghes_reg_mutex);
>   */
>  static DEFINE_SPINLOCK(ghes_lock);
>  
> -/* "ghes_edac.force_load=1" skips the platform check */
> -static bool __read_mostly force_load;
> -module_param(force_load, bool, 0);
> -
>  static bool system_scanned;
>  
>  static struct list_head *ghes_devs;
> @@ -437,23 +433,12 @@ static int ghes_edac_register(struct device *dev)
>  	mci->ctl_name = "ghes_edac";
>  	mci->dev_name = "ghes";
>  
> -	if (fake) {
> -		pr_info("This system has a very crappy BIOS: It doesn't even list the DIMMS.\n");
> -		pr_info("Its SMBIOS info is wrong. It is doubtful that the error report would\n");
> -		pr_info("work on such system. Use this driver with caution\n");
> -	} else if (force_load) {
> -		pr_info("This EDAC driver relies on BIOS to enumerate memory and get error reports.\n");
> -		pr_info("Unfortunately, not all BIOSes reflect the memory layout correctly.\n");
> -		pr_info("So, the end result of using this driver varies from vendor to vendor.\n");
> -		pr_info("If you find incorrect reports, please contact your hardware vendor\n");
> -		pr_info("to correct its BIOS.\n");
> -		pr_info("This system has %d DIMM sockets.\n", ghes_hw.num_dimms);
> -	}
> -
>  	if (!fake) {
>  		struct dimm_info *src, *dst;
>  		int i = 0;
>  
> +		pr_info("This system has %d DIMM sockets.\n", ghes_hw.num_dimms);
> +
>  		mci_for_each_dimm(mci, dst) {
>  			src = &ghes_hw.dimms[i];
>  

This hunk...

> @@ -478,6 +463,17 @@ static int ghes_edac_register(struct device *dev)
>  	} else {
>  		struct dimm_info *dimm = edac_get_dimm(mci, 0, 0, 0);
>  
> +		pr_info("This system has a very crappy BIOS: It doesn't even list the DIMMS.\n");
> +		pr_info("Its SMBIOS info is wrong. It is doubtful that the error report would\n");
> +		pr_info("work on such system. Use this driver with caution\n");
> +
> +		if (ghes_edac_force) {
> +			pr_info("This EDAC driver relies on BIOS to enumerate memory and get\n");
> +			pr_info("error reports. Unfortunately, not all BIOSes reflect the\n");
> +			pr_info("memory layout correctly. If you find incorrect reports, please\n");
> +			pr_info("contact your hardware vendor for its in correct BIOS.\n");
> +		}
> +
>  		dimm->nr_pages = 1;
>  		dimm->grain = 128;
>  		dimm->mtype = MEM_UNKNOWN;

... and this hunk look unrelated to what this patch is doing. What are
they for?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
