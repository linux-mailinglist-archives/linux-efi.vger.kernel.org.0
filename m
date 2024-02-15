Return-Path: <linux-efi+bounces-556-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1F7855D56
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 10:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77AA284513
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 09:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D511B7EA;
	Thu, 15 Feb 2024 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d03AaO80"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92514199AB;
	Thu, 15 Feb 2024 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987677; cv=none; b=GpRJUAaereD2G1q58uWKJhBPEPTddceIvTFQkXsyKU4Q+VnHk8bnR199Y1QSW7haX5YOeBxGhqunQaHp1XfBsQmgcHidNmPTzJsKw4hV3QsTfAxKZIG2XlM8sJH05jY4cGTLwezUwvQCgDPpoB32yFsmc6JMccWsNh4MIAWB3i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987677; c=relaxed/simple;
	bh=SiUIHayVYcHe9bkFxdrXvjU/ru0D8DtTz59xRaJtJBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcVVy5ZILHgSmqPUVkqvkC/iYxDaMWDu0xfiAvLW3r4aEoQYd0l2npd5v39LGoqlnCUs7LEqwi2CEgw3h/2gAE6Uv8HroLxFg2zzgH2ihtsTO8Kq4VrrnFh0FPifpmH3h9m3Kst4rGbQaCGqS2Cus56HMFliE6VJCLTB6U0sWRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d03AaO80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D62AC43390;
	Thu, 15 Feb 2024 09:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707987677;
	bh=SiUIHayVYcHe9bkFxdrXvjU/ru0D8DtTz59xRaJtJBY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d03AaO80PMznAQ1ygGgl4bP0JD/qWg8lwUAYD+Cd0KOAbgw27sPii/DOLCtE9wDv7
	 kgjhC5bdEAdt+IPU9T9VwDKHOmfzmcl/NVCU5ed4BO78QZjSy9MOH3YX6y49OcHyT0
	 nqkOvzjulchPTBi1+5V9FTsIiarwJANjG+ZTThceD2MUbOALEivnzP6D57dXeKgzLM
	 VWgtPxQ13aFGJmFZYynLjEZ/zZcdFnFTNe+L4X1YXFlHVSm9v/RLHNr5SVYYaUrbAJ
	 3e4+THnFEVAhZ+kaFSSbZETU2qEWz2cPDi0kWcg3Wrqd7ZAOO/3iGWcgUZK+i6bCs8
	 POayKDFk0TKow==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51182ece518so715354e87.3;
        Thu, 15 Feb 2024 01:01:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWP7CX7KVF10AhNKyV+NjbqXfw3cHQMgUjpOGEejdFNOTRdFHEyo4LA2rkbOdgVMoB+eY4PJsfmbGfi5aRrNDTpLSB65yiMQPl08qKZCnakrZ06jAxVyeGMqOUZJ0XoHZROriWMUr6fLDfhcZ0dKO10Inu1LAflxtQkdLgCNcXy1YeyfJyXt5xISJx1RxJcXn+Hx9jRT1RX4e16L79ophtu8A3n
X-Gm-Message-State: AOJu0YwSXx2fa5GdVOS9r9CSfaaF5jt42OxzXcXTueJgZ71ViTR8xcbc
	pCXqMNppsSMiUF6E7B6seYQUxFqjwzBXEnS+c7YNwKrUnkTHMLSabZ2rm3OHtGYU1rjGMKy+06n
	nnqFmli6g5EpNmr7bahnLQTdbt+U=
X-Google-Smtp-Source: AGHT+IESsSC82ZPO7zHm75aViouaK3gACXPSL8wbxHFLyvmlDJHekLM2uaQ5vnuSYH17EGhdPcRUbgpXLJsKGUFiH2M=
X-Received: by 2002:ac2:4946:0:b0:511:6ec9:d380 with SMTP id
 o6-20020ac24946000000b005116ec9d380mr904187lfi.30.1707987675245; Thu, 15 Feb
 2024 01:01:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214221847.2066632-1-ross.philipson@oracle.com> <20240214221847.2066632-16-ross.philipson@oracle.com>
In-Reply-To: <20240214221847.2066632-16-ross.philipson@oracle.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 15 Feb 2024 10:01:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF3k_c4Wn9GU+NC_+_aYfDpAzAUnfR=A4L_T+re1H3G=w@mail.gmail.com>
Message-ID: <CAMj1kXF3k_c4Wn9GU+NC_+_aYfDpAzAUnfR=A4L_T+re1H3G=w@mail.gmail.com>
Subject: Re: [PATCH v8 15/15] x86: EFI stub DRTM launch support for Secure Launch
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, dpsmith@apertussolutions.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kanth.ghatraju@oracle.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 23:32, Ross Philipson <ross.philipson@oracle.com> wrote:
>
> This support allows the DRTM launch to be initiated after an EFI stub
> launch of the Linux kernel is done. This is accomplished by providing
> a handler to jump to when a Secure Launch is in progress. This has to be
> called after the EFI stub does Exit Boot Services.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  drivers/firmware/efi/libstub/x86-stub.c | 55 +++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 0d510c9a06a4..4df2cf539194 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -9,6 +9,7 @@
>  #include <linux/efi.h>
>  #include <linux/pci.h>
>  #include <linux/stddef.h>
> +#include <linux/slr_table.h>
>
>  #include <asm/efi.h>
>  #include <asm/e820/types.h>
> @@ -810,6 +811,57 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
>         return EFI_SUCCESS;
>  }
>
> +static void efi_secure_launch(struct boot_params *boot_params)
> +{
> +       struct slr_entry_uefi_config *uefi_config;
> +       struct slr_uefi_cfg_entry *uefi_entry;
> +       struct slr_entry_dl_info *dlinfo;
> +       efi_guid_t guid = SLR_TABLE_GUID;
> +       struct slr_table *slrt;
> +       u64 memmap_hi;
> +       void *table;
> +       u8 buf[64] = {0};
> +

If you add a flex array to slr_entry_uefi_config as I suggested in
response to the other patch, we could simplify this substantially

static struct slr_entry_uefi_config cfg = {
        .hdr.tag        = SLR_ENTRY_UEFI_CONFIG,
        .hdr.size       = sizeof(cfg),
        .revision       = SLR_UEFI_CONFIG_REVISION,
        .nr_entries     = 1,
        .entries[0]     = {
                .pcr    = 18,
                .evt_info = "Measured UEFI memory map",
        },
};

cfg.entries[0].cfg  = boot_params->efi_info.efi_memmap |
                      (u64)boot_params->efi_info.efi_memmap_hi << 32;
cfg.entries[0].size = boot_params->efi_info.efi_memmap_size;



> +       table = get_efi_config_table(guid);
> +
> +       /*
> +        * The presence of this table indicated a Secure Launch
> +        * is being requested.
> +        */
> +       if (!table)
> +               return;
> +
> +       slrt = (struct slr_table *)table;
> +
> +       if (slrt->magic != SLR_TABLE_MAGIC)
> +               return;
> +

slrt = (struct slr_table *)get_efi_config_table(guid);
if (!slrt || slrt->magic != SLR_TABLE_MAGIC)
        return;

> +       /* Add config information to measure the UEFI memory map */
> +       uefi_config = (struct slr_entry_uefi_config *)buf;
> +       uefi_config->hdr.tag = SLR_ENTRY_UEFI_CONFIG;
> +       uefi_config->hdr.size = sizeof(*uefi_config) + sizeof(*uefi_entry);
> +       uefi_config->revision = SLR_UEFI_CONFIG_REVISION;
> +       uefi_config->nr_entries = 1;
> +       uefi_entry = (struct slr_uefi_cfg_entry *)(buf + sizeof(*uefi_config));
> +       uefi_entry->pcr = 18;
> +       uefi_entry->cfg = boot_params->efi_info.efi_memmap;
> +       memmap_hi = boot_params->efi_info.efi_memmap_hi;
> +       uefi_entry->cfg |= memmap_hi << 32;
> +       uefi_entry->size = boot_params->efi_info.efi_memmap_size;
> +       memcpy(&uefi_entry->evt_info[0], "Measured UEFI memory map",
> +               strlen("Measured UEFI memory map"));
> +

Drop all of this

> +       if (slr_add_entry(slrt, (struct slr_entry_hdr *)uefi_config))

if (slr_add_entry(slrt, &uefi_config.hdr))


> +               return;
> +
> +       /* Jump through DL stub to initiate Secure Launch */
> +       dlinfo = (struct slr_entry_dl_info *)
> +               slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);
> +
> +       asm volatile ("jmp *%%rax"
> +                     : : "a" (dlinfo->dl_handler), "D" (&dlinfo->bl_context));

Fix the prototype and just do

dlinfo->dl_handler(&dlinfo->bl_context);
unreachable();


So in summary, this becomes

static void efi_secure_launch(struct boot_params *boot_params)
{
        static struct slr_entry_uefi_config cfg = {
                .hdr.tag        = SLR_ENTRY_UEFI_CONFIG,
                .hdr.size       = sizeof(cfg),
                .revision       = SLR_UEFI_CONFIG_REVISION,
                .nr_entries     = 1,
                .entries[0]     = {
                        .pcr    = 18,
                        .evt_info = "Measured UEFI memory map",
                },
        };
        struct slr_entry_dl_info *dlinfo;
        efi_guid_t guid = SLR_TABLE_GUID;
        struct slr_table *slrt;

        /*
         * The presence of this table indicated a Secure Launch
         * is being requested.
         */
        slrt = (struct slr_table *)get_efi_config_table(guid);
        if (!slrt || slrt->magic != SLR_TABLE_MAGIC)
                return;

        cfg.entries[0].cfg  = boot_params->efi_info.efi_memmap |
                              (u64)boot_params->efi_info.efi_memmap_hi << 32;
        cfg.entries[0].size = boot_params->efi_info.efi_memmap_size;

        if (slr_add_entry(slrt, &cfg.hdr))
                return;

        /* Jump through DL stub to initiate Secure Launch */
        dlinfo = (struct slr_entry_dl_info *)
                 slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);

        dlinfo->dl_handler(&dlinfo->bl_context);

        unreachable();
}


> +}
> +
>  static void __noreturn enter_kernel(unsigned long kernel_addr,
>                                     struct boot_params *boot_params)
>  {
> @@ -934,6 +986,9 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
>                 goto fail;
>         }
>
> +       /* If a Secure Launch is in progress, this never returns */

if (IS_ENABLED(CONFIG_SECURE_LAUNCH))

> +       efi_secure_launch(boot_params);
> +
>         /*
>          * Call the SEV init code while still running with the firmware's
>          * GDT/IDT, so #VC exceptions will be handled by EFI.
> --
> 2.39.3
>

