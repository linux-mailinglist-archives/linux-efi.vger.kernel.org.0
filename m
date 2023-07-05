Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C7B748AAB
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jul 2023 19:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjGERfe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jul 2023 13:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjGERfc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Jul 2023 13:35:32 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5EB1BDC;
        Wed,  5 Jul 2023 10:34:59 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E2251EC059E;
        Wed,  5 Jul 2023 19:34:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1688578461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MEGOnUUJklrhitbV4ruvcKvARnIEQPaD/80tSn75pgY=;
        b=DfAWS0S8ha7gru/HpM2t1Jhwl9N1jSdZb6qL4M8Poc7Viil3gU0jDY/y4tia9rSI3KGD/7
        riBZWamT+cCQom+CFOIal5mxycuotfBzcdlnRr81kP8U3QGYXoSUmRZ2aUUQYhm4yWkxFs
        6VGqFtzoFsoRa1VN6Lbb1aat0GJw/M8=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O2FxcyoDZwkQ; Wed,  5 Jul 2023 17:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1688578456; bh=MEGOnUUJklrhitbV4ruvcKvARnIEQPaD/80tSn75pgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IC9K9a/L4pfqPiVykF+jA8SdbsCF3hdLrmsA+YP0Ewc94yDOk+O+JWhOijaXDiYY6
         aT6HVMh8DlOVWXNneGj7PeSxseBFc8t04yE4T629V5ksuEVhksc1twpneKhNpGva6u
         MBRNmlh+vqnH0lTELQmjfdNbMO+eyXr6Ck7zrJztIpS+BhbYmsjEdUycg3Fm1UB9ZN
         dcm/9xvTlPF43QDL85v6NDrp/brCYopWXGLtnT+hjD2kLAIlpP/xL0W7a97PmdcPyD
         dP50292ZFcdkUfngK/8F6cgfYdmsp16noYN81GRK7oVXKkfTLwl70e+GEPWI5PcuRh
         59GpzilrVN8Qe/CQDuloXstmx9yij9ZJXy/nXD4Jnvcl4jBfQWAZtRYe+wymirWSnT
         eAMpfKCzFpD2G0mb3vIK9l5H5WUYAYypCrOz2Ox0oXKRXaHmRZnxw6KHl10JR1YVzn
         buhfzky46506lOt2mrCAHQ9r1xpZovpUxZ2ttYkG9aqCs5jO44rdCK5CfQBv1ze9Nc
         vCbXsOh5kH4Mal6k9lr8ThYItcO06lFTf6cuYl+L6MSreIwMftWa6AT7MJy8gqPcrn
         eb+GyIlQg2lGB6krdtNm9uiPwWFY61neTH2OfZYwSgWGpLdQZQlMvl1V7HN9nHvtnT
         BJudhAcMzqcGAiGg4PnuN24Q=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A7A9040E0191;
        Wed,  5 Jul 2023 17:34:04 +0000 (UTC)
Date:   Wed, 5 Jul 2023 19:33:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tao Liu <ltao@redhat.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, bhe@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
References: <20230601072043.24439-1-ltao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230601072043.24439-1-ltao@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jun 01, 2023 at 03:20:44PM +0800, Tao Liu wrote:
> A kexec kernel bootup hang is observed on Intel Atom cpu due to unmapped

s/cpu/CPU/g

> EFI config table.
> 
> Currently EFI system table is identity-mapped for the kexec kernel, but EFI
> config table is not mapped explicitly:

Why does the EFI config table *need* to be mapped explicitly?

>     commit 6bbeb276b71f ("x86/kexec: Add the EFI system tables and ACPI
>                           tables to the ident map")
> 
> Later in the following 2 commits, EFI config table will be accessed when
> enabling sev at kernel startup.

What does SEV have to do with an Intel problem?

> This may result in a page fault due to EFI
> config table's unmapped address. Since the page fault occurs at an early
> stage, it is unrecoverable and kernel hangs.
> 
>     commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME features
>                           earlier during boot")
>     commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
>                           detection/setup")
> 
> In addition, the issue doesn't appear on all systems, because the kexec
> kernel uses Page Size Extension (PSE) for identity mapping. In most cases,
> EFI config table can end up to be mapped into due to 1 GB page size.
> However if nogbpages is set, or cpu doesn't support pdpe1gb feature
> (e.g Intel Atom x6425RE cpu), EFI config table may not be mapped into
> due to 2 MB page size, thus a page fault hang is more likely to happen.

This doesn't answer my question above.

> This patch will make sure the EFI config table is always mapped.

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.


> 
> Signed-off-by: Tao Liu <ltao@redhat.com>
> ---
> Changes in v2:
> - Rephrase the change log based on Baoquan's suggestion.
> - Rename map_efi_sys_cfg_tab() to map_efi_tables().
> - Link to v1: https://lore.kernel.org/kexec/20230525094914.23420-1-ltao@redhat.com/
> ---
>  arch/x86/kernel/machine_kexec_64.c | 35 ++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 1a3e2c05a8a5..664aefa6e896 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -28,6 +28,7 @@
>  #include <asm/setup.h>
>  #include <asm/set_memory.h>
>  #include <asm/cpu.h>
> +#include <asm/efi.h>
>  
>  #ifdef CONFIG_ACPI
>  /*
> @@ -86,10 +87,12 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
>  #endif
>  
>  static int
> -map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
> +map_efi_tables(struct x86_mapping_info *info, pgd_t *level4p)
>  {
>  #ifdef CONFIG_EFI
>  	unsigned long mstart, mend;
> +	void *kaddr;
> +	int ret;
>  
>  	if (!efi_enabled(EFI_BOOT))
>  		return 0;
> @@ -105,6 +108,30 @@ map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
>  	if (!mstart)
>  		return 0;
>  
> +	ret = kernel_ident_mapping_init(info, level4p, mstart, mend);
> +	if (ret)
> +		return ret;
> +
> +	kaddr = memremap(mstart, mend - mstart, MEMREMAP_WB);
> +	if (!kaddr) {
> +		pr_err("Could not map UEFI system table\n");
> +		return -ENOMEM;
> +	}
> +
> +	mstart = efi_config_table;

Yeah, about this, did you see efi_reuse_config() and the comment above
it especially?

Or is it that the EFI in that box wants the config table mapped 1:1 and
accesses it during boot/kexec?

In any case, this is all cloudy without a proper root cause.

Also, I'd like for Ard to have a look at this too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
