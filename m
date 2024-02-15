Return-Path: <linux-efi+bounces-552-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A972A855C03
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 09:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA834B2659E
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 08:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C267111A0;
	Thu, 15 Feb 2024 08:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nihSTvYX"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453091118F;
	Thu, 15 Feb 2024 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707984553; cv=none; b=NwfMCiDwZG4V+nQF9zwyASylo+0dW+h+/Aa1Y4O1yfFHy8MOutvmtGOIB3UZDue/YR95TD+mX4NTtf/PDtsXFZyXQAlS3Nv6Utc4qs/hOxLZDNLq7zfeTlkj6w/89jIUUOi7IdyjL95J16MIMhGcYHW0F7hyX7PEXNL5+lsskBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707984553; c=relaxed/simple;
	bh=iBhxtYQbpLfj3dlhxKI2geTS1BtCu4ErK/UQ/65GC9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNB9Z9QOMYZ7CW1tVv6008hIwkn6NKUumVod5ch5HW6UWUkbxN8m0L5DgRdtWNGt0t0GX0KQnWx88V/QaMqHVLuL5r4mC2y7OLkGYB2Bx9rs6KTbMZZnvHlyOyyEt9gzssw4qpHY3oqKeSIo2eyqusw+TJinPFCwZyZc6T4LUFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nihSTvYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6813C43141;
	Thu, 15 Feb 2024 08:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707984552;
	bh=iBhxtYQbpLfj3dlhxKI2geTS1BtCu4ErK/UQ/65GC9k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nihSTvYX3PqYfrp/Bdhm3OFoEXqstCjlXeLvJFPhV0bn04Gh5frQzRdTQFYuObeJN
	 FLs0y9nCyK06w+AgV8Mw2r5om9Vq1XLDrQrAdIZIawj2AYmScZD1TFkHrgcBzPQSKi
	 whkNmIjS9L4MswGi/Np4BkbqIUWwGn1gO7AZRj9BScBxPdsKcaSeGzD6cFC+4bfT7I
	 qpcmKEgXeLzPJswzqgZBbsDgqNXtHwfnHgz7xTMJ6X8PHyOx/dOFUwYipqeFuBm3Wf
	 3lA/1QZNJnjx4kcNQfjAv2lOqRDj2+LF6KcFMaQn3/zAeEWdRTMt/YltHpfGmZkRRG
	 scj1PwuNN3d8w==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-511976c126dso741250e87.1;
        Thu, 15 Feb 2024 00:09:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXno6ypJ2cFs8QFDruGUFMLrdp07P9xYV0oC89c/1RRGF0hHcm3YAcrbL6veJuf+QTxNwMLENSOD64zYsik0S1MDXIpsrc6iUIGIvIa1E6cd7qES7mwzoub1fLlMk0rsvmop3hulLmoC4ES6vzBUrOeKZzm8XsRc2wTY9NxrK5Zj3N260Jlurl4/uPmEzHYUUoXnWujPEFLMC2ue3s/P1Jcjnb
X-Gm-Message-State: AOJu0YyKDM9adFslKy72ivRkjsW79cEEl45v/Q+9htsSrGo7AbRO3PiE
	pu7kxLHfm6QU2KtgiNHM9GB9SdSLU9Ob1lnMZhCWuW4Ufru6u9nlhTEQO8yHOjU9Xln+hf2NcwE
	C3/PMmxnveP8gYtluFRE2/+ye7Tg=
X-Google-Smtp-Source: AGHT+IES5dFR/dEUVlJWfvtf3xciPB+7NHzjXGklMH5tK3nkOBEGAVCil/5i8S6vDeDjj+8Wg38DPkb9JJN4ATkctI0=
X-Received: by 2002:a05:6512:e98:b0:511:ac21:57db with SMTP id
 bi24-20020a0565120e9800b00511ac2157dbmr936557lfb.0.1707984550864; Thu, 15 Feb
 2024 00:09:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214221847.2066632-1-ross.philipson@oracle.com> <20240214221847.2066632-5-ross.philipson@oracle.com>
In-Reply-To: <20240214221847.2066632-5-ross.philipson@oracle.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 15 Feb 2024 09:08:59 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGaMfUAR85jpeS2JxcmWBbpkzroCVZOtwa3WDQwStDjMw@mail.gmail.com>
Message-ID: <CAMj1kXGaMfUAR85jpeS2JxcmWBbpkzroCVZOtwa3WDQwStDjMw@mail.gmail.com>
Subject: Re: [PATCH v8 04/15] x86: Secure Launch Resource Table header file
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

On Wed, 14 Feb 2024 at 23:31, Ross Philipson <ross.philipson@oracle.com> wrote:
>
> Introduce the Secure Launch Resource Table which forms the formal
> interface between the pre and post launch code.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  include/linux/slr_table.h | 270 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 270 insertions(+)
>  create mode 100644 include/linux/slr_table.h
>
> diff --git a/include/linux/slr_table.h b/include/linux/slr_table.h
> new file mode 100644
> index 000000000000..42020988233a
> --- /dev/null
> +++ b/include/linux/slr_table.h
> @@ -0,0 +1,270 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Secure Launch Resource Table
> + *
> + * Copyright (c) 2023, Oracle and/or its affiliates.
> + */
> +
> +#ifndef _LINUX_SLR_TABLE_H
> +#define _LINUX_SLR_TABLE_H
> +
> +/* Put this in efi.h if it becomes a standard */
> +#define SLR_TABLE_GUID                         EFI_GUID(0x877a9b2a, 0x0385, 0x45d1, 0xa0, 0x34, 0x9d, 0xac, 0x9c, 0x9e, 0x56, 0x5f)
> +
> +/* SLR table header values */
> +#define SLR_TABLE_MAGIC                0x4452544d
> +#define SLR_TABLE_REVISION     1
> +
> +/* Current revisions for the policy and UEFI config */
> +#define SLR_POLICY_REVISION            1
> +#define SLR_UEFI_CONFIG_REVISION       1
> +
> +/* SLR defined architectures */
> +#define SLR_INTEL_TXT          1
> +#define SLR_AMD_SKINIT         2
> +
> +/* SLR defined bootloaders */
> +#define SLR_BOOTLOADER_INVALID 0
> +#define SLR_BOOTLOADER_GRUB    1
> +
> +/* Log formats */
> +#define SLR_DRTM_TPM12_LOG     1
> +#define SLR_DRTM_TPM20_LOG     2
> +
> +/* DRTM Policy Entry Flags */
> +#define SLR_POLICY_FLAG_MEASURED       0x1
> +#define SLR_POLICY_IMPLICIT_SIZE       0x2
> +
> +/* Array Lengths */
> +#define TPM_EVENT_INFO_LENGTH          32
> +#define TXT_VARIABLE_MTRRS_LENGTH      32
> +
> +/* Tags */
> +#define SLR_ENTRY_INVALID      0x0000
> +#define SLR_ENTRY_DL_INFO      0x0001
> +#define SLR_ENTRY_LOG_INFO     0x0002
> +#define SLR_ENTRY_ENTRY_POLICY 0x0003
> +#define SLR_ENTRY_INTEL_INFO   0x0004
> +#define SLR_ENTRY_AMD_INFO     0x0005
> +#define SLR_ENTRY_ARM_INFO     0x0006
> +#define SLR_ENTRY_UEFI_INFO    0x0007
> +#define SLR_ENTRY_UEFI_CONFIG  0x0008
> +#define SLR_ENTRY_END          0xffff
> +
> +/* Entity Types */
> +#define SLR_ET_UNSPECIFIED     0x0000
> +#define SLR_ET_SLRT            0x0001
> +#define SLR_ET_BOOT_PARAMS     0x0002
> +#define SLR_ET_SETUP_DATA      0x0003
> +#define SLR_ET_CMDLINE         0x0004
> +#define SLR_ET_UEFI_MEMMAP     0x0005
> +#define SLR_ET_RAMDISK         0x0006
> +#define SLR_ET_TXT_OS2MLE      0x0010
> +#define SLR_ET_UNUSED          0xffff
> +
> +#ifndef __ASSEMBLY__
> +
> +/*
> + * Primary SLR Table Header
> + */
> +struct slr_table {
> +       u32 magic;
> +       u16 revision;
> +       u16 architecture;
> +       u32 size;
> +       u32 max_size;
> +       /* entries[] */
> +} __packed;

Packing this struct has no effect on the layout so better drop the
__packed here. If this table is part of a structure that can appear
misaligned in memory, better to pack the outer struct or deal with it
there in another way.

> +
> +/*
> + * Common SLRT Table Header
> + */
> +struct slr_entry_hdr {
> +       u16 tag;
> +       u16 size;
> +} __packed;

Same here

> +
> +/*
> + * Boot loader context
> + */
> +struct slr_bl_context {
> +       u16 bootloader;
> +       u16 reserved;
> +       u64 context;
> +} __packed;
> +
> +/*
> + * DRTM Dynamic Launch Configuration
> + */
> +struct slr_entry_dl_info {
> +       struct slr_entry_hdr hdr;
> +       struct slr_bl_context bl_context;
> +       u64 dl_handler;

I noticed in the EFI patch that this is actually

void (*dl_handler)(struct slr_bl_context *bl_context);

so better declare it as such.

> +       u64 dce_base;
> +       u32 dce_size;
> +       u64 dlme_entry;
> +} __packed;
> +
> +/*
> + * TPM Log Information
> + */
> +struct slr_entry_log_info {
> +       struct slr_entry_hdr hdr;
> +       u16 format;
> +       u16 reserved;
> +       u64 addr;
> +       u32 size;
> +} __packed;
> +
> +/*
> + * DRTM Measurement Policy
> + */
> +struct slr_entry_policy {
> +       struct slr_entry_hdr hdr;
> +       u16 revision;
> +       u16 nr_entries;
> +       /* policy_entries[] */

Please use a flex array here:

  struct slr_policy_entry policy_entries[];

> +} __packed;
> +
> +/*
> + * DRTM Measurement Entry
> + */
> +struct slr_policy_entry {
> +       u16 pcr;
> +       u16 entity_type;
> +       u16 flags;
> +       u16 reserved;
> +       u64 entity;
> +       u64 size;
> +       char evt_info[TPM_EVENT_INFO_LENGTH];
> +} __packed;
> +
> +/*
> + * Secure Launch defined MTRR saving structures
> + */
> +struct slr_txt_mtrr_pair {
> +       u64 mtrr_physbase;
> +       u64 mtrr_physmask;
> +} __packed;
> +
> +struct slr_txt_mtrr_state {
> +       u64 default_mem_type;
> +       u64 mtrr_vcnt;
> +       struct slr_txt_mtrr_pair mtrr_pair[TXT_VARIABLE_MTRRS_LENGTH];
> +} __packed;
> +
> +/*
> + * Intel TXT Info table
> + */
> +struct slr_entry_intel_info {
> +       struct slr_entry_hdr hdr;
> +       u64 saved_misc_enable_msr;
> +       struct slr_txt_mtrr_state saved_bsp_mtrrs;
> +} __packed;
> +
> +/*
> + * AMD SKINIT Info table
> + */
> +struct slr_entry_amd_info {
> +       struct slr_entry_hdr hdr;
> +} __packed;
> +
> +/*
> + * ARM DRTM Info table
> + */
> +struct slr_entry_arm_info {
> +       struct slr_entry_hdr hdr;
> +} __packed;
> +

These two look preliminary, so better to drop them now and introduce
only once you know what they will look like.

> +struct slr_entry_uefi_config {
> +       struct slr_entry_hdr hdr;
> +       u16 revision;
> +       u16 nr_entries;
> +       /* uefi_cfg_entries[] */

Use a flex array

> +} __packed;
> +
> +struct slr_uefi_cfg_entry {
> +       u16 pcr;
> +       u16 reserved;
> +       u64 cfg; /* address or value */
> +       u32 size;
> +       char evt_info[TPM_EVENT_INFO_LENGTH];
> +} __packed;
> +
> +static inline void *slr_end_of_entrys(struct slr_table *table)

typo 'entrys' ?

> +{
> +       return (((void *)table) + table->size);

You can drop two sets of parens here

> +}
> +
> +static inline struct slr_entry_hdr *
> +slr_next_entry(struct slr_table *table,
> +              struct slr_entry_hdr *curr)
> +{
> +       struct slr_entry_hdr *next = (struct slr_entry_hdr *)
> +                               ((u8 *)curr + curr->size);
> +
> +       if ((void *)next >= slr_end_of_entrys(table))
> +               return NULL;
> +       if (next->tag == SLR_ENTRY_END)
> +               return NULL;
> +
> +       return next;
> +}
> +
> +static inline struct slr_entry_hdr *
> +slr_next_entry_by_tag(struct slr_table *table,
> +                     struct slr_entry_hdr *entry,
> +                     u16 tag)
> +{
> +       if (!entry) /* Start from the beginning */
> +               entry = (struct slr_entry_hdr *)(((u8 *)table) + sizeof(*table));
> +
> +       for ( ; ; ) {
> +               if (entry->tag == tag)
> +                       return entry;
> +
> +               entry = slr_next_entry(table, entry);
> +               if (!entry)
> +                       return NULL;
> +       }
> +
> +       return NULL;
> +}
> +
> +static inline int
> +slr_add_entry(struct slr_table *table,
> +             struct slr_entry_hdr *entry)
> +{
> +       struct slr_entry_hdr *end;
> +
> +       if ((table->size + entry->size) > table->max_size)
> +               return -1;
> +
> +       memcpy((u8 *)table + table->size - sizeof(*end), entry, entry->size);
> +       table->size += entry->size;
> +
> +       end  = (struct slr_entry_hdr *)((u8 *)table + table->size - sizeof(*end));
> +       end->tag = SLR_ENTRY_END;
> +       end->size = sizeof(*end);
> +
> +       return 0;
> +}
> +
> +static inline void
> +slr_init_table(struct slr_table *slrt, u16 architecture, u32 max_size)
> +{
> +       struct slr_entry_hdr *end;
> +
> +       slrt->magic = SLR_TABLE_MAGIC;
> +       slrt->revision = SLR_TABLE_REVISION;
> +       slrt->architecture = architecture;
> +       slrt->size = sizeof(*slrt) + sizeof(*end);
> +       slrt->max_size = max_size;
> +       end = (struct slr_entry_hdr *)((u8 *)slrt + sizeof(*slrt));
> +       end->tag = SLR_ENTRY_END;
> +       end->size = sizeof(*end);
> +}
> +
> +#endif /* !__ASSEMBLY */
> +
> +#endif /* _LINUX_SLR_TABLE_H */
> --
> 2.39.3
>

