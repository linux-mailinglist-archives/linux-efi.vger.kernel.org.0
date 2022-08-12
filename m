Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AA159126E
	for <lists+linux-efi@lfdr.de>; Fri, 12 Aug 2022 16:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbiHLOqR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 Aug 2022 10:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiHLOqQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 Aug 2022 10:46:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428E998CAB;
        Fri, 12 Aug 2022 07:46:15 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98b3329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98b3:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C8CD61EC054C;
        Fri, 12 Aug 2022 16:46:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660315569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rE25dEst67ND0DTXuiElw5hjh014xb/IHS7uqD6DMbU=;
        b=UhaR64dVHe/vueO54aqMqv+0IcGVJhTwv6YEzhrFmUAP90R9of/rC+AqbJ3h6rspeF5fcu
        W2ubYggayFzIBiRjB/9BimTnQ5sxbuu9qpLeoDqz0bNdJiDOH6kbKO0EbT6HGckDRP+7aM
        t5rCpNrBXFq47MhnslddMr4SJmVgQpQ=
Date:   Fri, 12 Aug 2022 16:46:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jia He <justin.he@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, devel@acpica.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, toshi.kani@hpe.com, stable@kernel.org
Subject: Re: [PATCH 2/2] EDAC/ghes: Modularize ghes_edac driver to remove the
 dependency on ghes
Message-ID: <YvZnrTrXhRn8FV3I@zn.tnic>
References: <20220811091713.10427-1-justin.he@arm.com>
 <20220811091713.10427-3-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220811091713.10427-3-justin.he@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 11, 2022 at 09:17:13AM +0000, Jia He wrote:
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d91ad378c00d..ed6519f3d45b 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -94,6 +94,8 @@
>  #define FIX_APEI_GHES_SDEI_CRITICAL	__end_of_fixed_addresses
>  #endif
>  
> +ATOMIC_NOTIFIER_HEAD(ghes_report_chain);

static. You need function wrappers which call the notifier from the
module.

Also, why atomic? x86_mce_decoder_chain is a blocking one.

Also, the whole notifier adding thing needs to be a separate patch.

> @@ -1497,3 +1504,37 @@ void __init acpi_ghes_init(void)
>  	else
>  		pr_info(GHES_PFX "Failed to enable APEI firmware first mode.\n");
>  }
> +
> +/*
> + * Known x86 systems that prefer GHES error reporting:
> + */
> +static struct acpi_platform_list plat_list[] = {
> +	{"HPE   ", "Server  ", 0, ACPI_SIG_FADT, all_versions},
> +	{ } /* End */
> +};
> +
> +struct list_head *ghes_get_devices(bool force)
> +{
> +	int idx = -1;
> +
> +	if (IS_ENABLED(CONFIG_X86)) {
> +		idx = acpi_match_platform_list(plat_list);
> +		if (idx < 0 && !force)
> +			return NULL;
> +	}
> +
> +	return &ghes_devs;
> +}
> +EXPORT_SYMBOL_GPL(ghes_get_devices);

And yes, as Toshi points out, the other EDAC drivers - sb_edac, skx_edac
and amd64_edac - should call this function in their init functions so
that it can get selected which driver to load on HPE server platforms.

Also in a separate patch pls.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
