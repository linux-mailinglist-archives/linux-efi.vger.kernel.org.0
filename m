Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A574711EA2
	for <lists+linux-efi@lfdr.de>; Fri, 26 May 2023 06:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjEZEJB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 May 2023 00:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbjEZEJA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 26 May 2023 00:09:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63643183
        for <linux-efi@vger.kernel.org>; Thu, 25 May 2023 21:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685074094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=281L+8rYh29YkUcSLnBXVJo3LDjuwmSmWQA4O0K9HTQ=;
        b=FJ8iIgSvYNlHhiQFCQ1YHkzFuRjCUTiI3pu9Lgv4xYSQPfG5Duyfqcgkb2fqVjfAajU/ZW
        5gvA9TONF0Ktquc1ve2NoYK3qIis//FycXFTNxvmN6y30uz6xytbE9YYMDnCtH0tSM9p58
        lpUlA4W09xE4Miiz3fXLK/8kvJ89t2w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-fezvmrDnPGGsIsfT4Pzcaw-1; Fri, 26 May 2023 00:08:10 -0400
X-MC-Unique: fezvmrDnPGGsIsfT4Pzcaw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 905F58032EF;
        Fri, 26 May 2023 04:08:09 +0000 (UTC)
Received: from localhost (ovpn-12-35.pek2.redhat.com [10.72.12.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82B05492B0A;
        Fri, 26 May 2023 04:08:08 +0000 (UTC)
Date:   Fri, 26 May 2023 12:08:04 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Tao Liu <ltao@redhat.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <ZHAwpL3wbKX9sWep@MiWiFi-R3L-srv>
References: <20230525094914.23420-1-ltao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525094914.23420-1-ltao@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Tao,

On 05/25/23 at 05:49pm, Tao Liu wrote:
> A kexec kernel bootup hang is observed on Intel Atom cpu due to unmapped
> EFI config table.
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
> In this patch, we will make sure the EFI config table is always mapped.

Nice work. While you may need to rephrase above sentence, x86
maintainers don't like log with the 'this patch,' or 'we'. Please refer
to 'Changelog' part of Documentation/process/maintainer-tip.rst and
improve it.

> 
> Signed-off-by: Tao Liu <ltao@redhat.com>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 35 ++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 1a3e2c05a8a5..755aa12f583f 100644
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
> +map_efi_sys_cfg_tab(struct x86_mapping_info *info, pgd_t *level4p)

Can we call the function map_efi_tables() since we will map efi system
table, system config table. If you need add another table mapping here,
what would you call it, map_efi_sys_cfg_xxx_tab()?

Anyway, not very strong opinion as long as x86 maintainer likes it.

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
> +	result = map_efi_sys_cfg_tab(&info, level4p);
>  	if (result)
>  		return result;
>  
> -- 
> 2.33.1
> 

