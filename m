Return-Path: <linux-efi+bounces-1607-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CB4960764
	for <lists+linux-efi@lfdr.de>; Tue, 27 Aug 2024 12:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D40B1C22A56
	for <lists+linux-efi@lfdr.de>; Tue, 27 Aug 2024 10:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD1D19ADBE;
	Tue, 27 Aug 2024 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0l/v28V"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E9013B588;
	Tue, 27 Aug 2024 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724754503; cv=none; b=UgabDuaC+mzfkNRTx8ELoa+sNgDKqyjUFpcT2Tqk9cFpkDxiBEeZw4HpgTVL0NDy67RZmk/rcRXPBvKID3eb3wiJYuPsnfC7r7V6d1gKiW/uRwoQOAKpR1BxKB5rkdEOt6TgvEP2kaBp4vKcbiX6JykOYQFVVKiCHX08d7XvspM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724754503; c=relaxed/simple;
	bh=ITTElo/b0xmcXLky20o3aXYvQkQonQvee1/DzBHfgOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBOhRvvi0zTu18v/LcqbGj6ZbWrV7wg4CNoHR8rLkxQKqbrOqTrLSp8xF6ViklzXDnaEG4moeEso2m/H3wG5Y59UR/3upa/ESGLf0kIfHGugZ/ULXF1W/xbXvwNSTdpFFXiWRa018W3F1rxODV6yIKrgTzUi9BQ5MTD4m5B4tCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0l/v28V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286B9C4AF0C;
	Tue, 27 Aug 2024 10:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724754503;
	bh=ITTElo/b0xmcXLky20o3aXYvQkQonQvee1/DzBHfgOY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z0l/v28V7aAoV2n2ULTbT7WVve/56FzSdMbMfKLB6jCtUmD+Qi6t7T99lgqy28Tcg
	 YRtiAN+ZzGjiK6d8YSxe3LK7Hiiqy818OulFcG4lbshKrb4Qfd9pcEfgx9pZTmjxNd
	 fs51GyrtZoGTBnMHzu+XlKAvKYfiUVzaA/Rwnfxl2fDgxpoBrO2b8c5gIAlKhxkj2/
	 LdAICrf7XmrDQigKroyEDDLSLgEJfOwTUGRnr1vcxFg8/SMoMQmT3iiZTFBzdGbN0o
	 0XZgJ26nndoo3ksMg/X8SVymSv2o8INcbc9yyVrOaBw7+kfHLeF5o14bkILaMfAKy/
	 Q7yYhvMEOFCoA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53351642021so6154398e87.3;
        Tue, 27 Aug 2024 03:28:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7ezSuk3qLGFUTdtOwC9vGQ3pSb65MtV7frq9bwYdayyMWEV7DrrX7RkvVpWCOhoE3LcsbHhLVYWiq@vger.kernel.org, AJvYcCWA3CBQoh1VzI590XcVVSibMACl6r1CQlYGr5OEnESQ9+Md9nTGOb8DRUlg91hgIg7SRtKR+/53O2jK@vger.kernel.org, AJvYcCWRKjOzyiooEwSctpsVjm/pBTUX6MO898fTOfGoT+k/uK4N+XTN7QHsHg9JAF8Frb+H4QkP++dfp/KwkGg=@vger.kernel.org, AJvYcCXFKa8S0DPcfp21pIncN5Uun1ee+4RqvvPljB5/NwDIiSNpkSWESDsSjxni1KiN7709jZrmw+KzL9vl4qW7OcNB@vger.kernel.org
X-Gm-Message-State: AOJu0YzAsq+bDKGvoDAH+G/kRRE2QVyCr7JjInNWLJqYfiSqQPFALYqi
	Db1UL5zuIEU66BfwOo8XNT9o2oKIYWxRQJV7a/TqHdvx55KfG7c42sRhS9AGzOohaeT3CtZwCwz
	BxG6DrMIwl7/zbfr1/K4V0SJfcxg=
X-Google-Smtp-Source: AGHT+IEc4W3oYLEUVyAgQgD5lGc43eMGwkrzL5cq7+l4rmkv9sJdVmYWlyj3bwH/rt9Kls4pEV8Wy5JcfmVf76SJtlk=
X-Received: by 2002:a05:6512:1103:b0:52f:c5c0:2879 with SMTP id
 2adb3069b0e04-534387be5cemr9633786e87.41.1724754501384; Tue, 27 Aug 2024
 03:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826223835.3928819-1-ross.philipson@oracle.com> <20240826223835.3928819-21-ross.philipson@oracle.com>
In-Reply-To: <20240826223835.3928819-21-ross.philipson@oracle.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 27 Aug 2024 12:28:10 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEyStoqmvvQirxt_GXTnO2qQjOxtQGzHzQeCdRCYzT7uA@mail.gmail.com>
Message-ID: <CAMj1kXEyStoqmvvQirxt_GXTnO2qQjOxtQGzHzQeCdRCYzT7uA@mail.gmail.com>
Subject: Re: [PATCH v10 20/20] x86/efi: EFI stub DRTM launch support for
 Secure Launch
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org, 
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, mjg59@srcf.ucam.org, 
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org, 
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Aug 2024 at 00:44, Ross Philipson <ross.philipson@oracle.com> wrote:
>
> This support allows the DRTM launch to be initiated after an EFI stub
> launch of the Linux kernel is done. This is accomplished by providing
> a handler to jump to when a Secure Launch is in progress. This has to be
> called after the EFI stub does Exit Boot Services.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/firmware/efi/libstub/efistub.h  |  8 ++
>  drivers/firmware/efi/libstub/x86-stub.c | 98 +++++++++++++++++++++++++
>  2 files changed, 106 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index d33ccbc4a2c6..baf42d6d0796 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -135,6 +135,14 @@ void efi_set_u64_split(u64 data, u32 *lo, u32 *hi)
>         *hi = upper_32_bits(data);
>  }
>
> +static inline
> +void efi_set_u64_form(u32 lo, u32 hi, u64 *data)
> +{
> +       u64 upper = hi;
> +
> +       *data = lo | upper << 32;
> +}
> +
>  /*
>   * Allocation types for calls to boottime->allocate_pages.
>   */
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index f8e465da344d..04786c1b3b5d 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -9,6 +9,8 @@
>  #include <linux/efi.h>
>  #include <linux/pci.h>
>  #include <linux/stddef.h>
> +#include <linux/slr_table.h>
> +#include <linux/slaunch.h>
>
>  #include <asm/efi.h>
>  #include <asm/e820/types.h>
> @@ -923,6 +925,99 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
>         return efi_adjust_memory_range_protection(addr, kernel_text_size);
>  }
>
> +static bool efi_secure_launch_update_boot_params(struct slr_table *slrt,
> +                                                struct boot_params *boot_params)
> +{
> +       struct slr_entry_intel_info *txt_info;
> +       struct slr_entry_policy *policy;
> +       struct txt_os_mle_data *os_mle;
> +       bool updated = false;
> +       int i;
> +
> +       txt_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_INTEL_INFO);
> +       if (!txt_info)
> +               return false;
> +
> +       os_mle = txt_os_mle_data_start((void *)txt_info->txt_heap);
> +       if (!os_mle)
> +               return false;
> +
> +       os_mle->boot_params_addr = (u64)boot_params;
> +
> +       policy = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_ENTRY_POLICY);
> +       if (!policy)
> +               return false;
> +
> +       for (i = 0; i < policy->nr_entries; i++) {
> +               if (policy->policy_entries[i].entity_type == SLR_ET_BOOT_PARAMS) {
> +                       policy->policy_entries[i].entity = (u64)boot_params;
> +                       updated = true;
> +                       break;
> +               }
> +       }
> +
> +       /*
> +        * If this is a PE entry into EFI stub the mocked up boot params will
> +        * be missing some of the setup header data needed for the second stage
> +        * of the Secure Launch boot.
> +        */
> +       if (image) {
> +               struct setup_header *hdr = (struct setup_header *)((u8 *)image->image_base +
> +                                           offsetof(struct boot_params, hdr));
> +               u64 cmdline_ptr;
> +
> +               boot_params->hdr.setup_sects = hdr->setup_sects;
> +               boot_params->hdr.syssize = hdr->syssize;
> +               boot_params->hdr.version = hdr->version;
> +               boot_params->hdr.loadflags = hdr->loadflags;
> +               boot_params->hdr.kernel_alignment = hdr->kernel_alignment;
> +               boot_params->hdr.min_alignment = hdr->min_alignment;
> +               boot_params->hdr.xloadflags = hdr->xloadflags;
> +               boot_params->hdr.init_size = hdr->init_size;
> +               boot_params->hdr.kernel_info_offset = hdr->kernel_info_offset;
> +               efi_set_u64_form(boot_params->hdr.cmd_line_ptr, boot_params->ext_cmd_line_ptr,
> +                                &cmdline_ptr);
> +               boot_params->hdr.cmdline_size = strlen((const char *)cmdline_ptr);
> +       }
> +
> +       return updated;
> +}
> +
> +static void efi_secure_launch(struct boot_params *boot_params)
> +{
> +       struct slr_entry_dl_info *dlinfo;
> +       efi_guid_t guid = SLR_TABLE_GUID;
> +       dl_handler_func handler_callback;
> +       struct slr_table *slrt;
> +
> +       if (!IS_ENABLED(CONFIG_SECURE_LAUNCH))
> +               return;
> +
> +       /*
> +        * The presence of this table indicated a Secure Launch
> +        * is being requested.
> +        */
> +       slrt = (struct slr_table *)get_efi_config_table(guid);
> +       if (!slrt || slrt->magic != SLR_TABLE_MAGIC)
> +               return;
> +
> +       /*
> +        * Since the EFI stub library creates its own boot_params on entry, the
> +        * SLRT and TXT heap have to be updated with this version.
> +        */
> +       if (!efi_secure_launch_update_boot_params(slrt, boot_params))
> +               return;
> +
> +       /* Jump through DL stub to initiate Secure Launch */
> +       dlinfo = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);
> +
> +       handler_callback = (dl_handler_func)dlinfo->dl_handler;
> +
> +       handler_callback(&dlinfo->bl_context);
> +
> +       unreachable();
> +}
> +
>  static void __noreturn enter_kernel(unsigned long kernel_addr,
>                                     struct boot_params *boot_params)
>  {
> @@ -1050,6 +1145,9 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
>                 goto fail;
>         }
>
> +       /* If a Secure Launch is in progress, this never returns */
> +       efi_secure_launch(boot_params);
> +
>         /*
>          * Call the SEV init code while still running with the firmware's
>          * GDT/IDT, so #VC exceptions will be handled by EFI.
> --
> 2.39.3
>

