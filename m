Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2CC733126
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jun 2023 14:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344788AbjFPMZl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jun 2023 08:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344594AbjFPMZk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Jun 2023 08:25:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1761A30DE
        for <linux-efi@vger.kernel.org>; Fri, 16 Jun 2023 05:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686918293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fuK/Vx5FhYSKQ6dBWyz0e+umzd/d5Enk+wef1tRSFRg=;
        b=BbUF7DWy3ap07OJ9XJ7QEh0W06/zjViEqhCjAkgfwytcy/E3WHvs5DbZcUbjFxOwmTjDNG
        PHgL86KYOnZ9nCNZZWJPED7elI8VGmcrKz8llaXWmxsc/FPG+K1WvvGrcH8ZzBheB5DxVI
        46svXUOQsKP1gjdHJBw/8MnL9BHm1QQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-3hSa6Ml1PdGbCb8apjH6zg-1; Fri, 16 Jun 2023 08:24:51 -0400
X-MC-Unique: 3hSa6Ml1PdGbCb8apjH6zg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3268785A58C;
        Fri, 16 Jun 2023 12:24:51 +0000 (UTC)
Received: from localhost (ovpn-13-2.pek2.redhat.com [10.72.13.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F12842166B25;
        Fri, 16 Jun 2023 12:24:49 +0000 (UTC)
Date:   Fri, 16 Jun 2023 20:24:46 +0800
From:   Baoquan He <bhe@redhat.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, ardb@kernel.org
Cc:     x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        dyoung@redhat.com, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <ZIxUjkYK4k5gpC7p@MiWiFi-R3L-srv>
References: <20230601072043.24439-1-ltao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601072043.24439-1-ltao@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 06/01/23 at 03:20pm, Tao Liu wrote:
> A kexec kernel bootup hang is observed on Intel Atom cpu due to unmapped
> EFI config table.

Ping!

The issue is observed on Lenovo ThinkEdge mini PC owning 'Intel
Atom(R) x6425RE' cpu, and reported by Lenovo engineer. On the machine,
kdump kernel switching will hang immediately w/o any prompt. Tao added
debugging info to finally position and find out the root cause.

Could you help check and consider accepting it or comment if there's
any further work Tao need do to correct or improve?

Thanks
Baoquan

> 
> Currently EFI system table is identity-mapped for the kexec kernel, but EFI
> config table is not mapped explicitly:
> 
>     commit 6bbeb276b71f ("x86/kexec: Add the EFI system tables and ACPI
>                           tables to the ident map")
> 
> Later in the following 2 commits, EFI config table will be accessed when
> enabling sev at kernel startup. This may result in a page fault due to EFI
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
> 
> This patch will make sure the EFI config table is always mapped.
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
> +
> +	if (efi_enabled(EFI_64BIT)) {
> +		efi_system_table_64_t *stbl = (efi_system_table_64_t *)kaddr;
> +
> +		mend = mstart + sizeof(efi_config_table_64_t) * stbl->nr_tables;
> +	} else {
> +		efi_system_table_32_t *stbl = (efi_system_table_32_t *)kaddr;
> +
> +		mend = mstart + sizeof(efi_config_table_32_t) * stbl->nr_tables;
> +	}
> +
> +	memunmap(kaddr);
> +
>  	return kernel_ident_mapping_init(info, level4p, mstart, mend);
>  #endif
>  	return 0;
> @@ -244,10 +271,10 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
>  	}
>  
>  	/*
> -	 * Prepare EFI systab and ACPI tables for kexec kernel since they are
> -	 * not covered by pfn_mapped.
> +	 * Prepare EFI systab, config table and ACPI tables for kexec kernel
> +	 * since they are not covered by pfn_mapped.
>  	 */
> -	result = map_efi_systab(&info, level4p);
> +	result = map_efi_tables(&info, level4p);
>  	if (result)
>  		return result;
>  
> -- 
> 2.33.1
> 

