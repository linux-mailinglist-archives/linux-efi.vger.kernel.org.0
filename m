Return-Path: <linux-efi+bounces-2906-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9B4A5600D
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 06:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18E83B0902
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 05:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2650A13D531;
	Fri,  7 Mar 2025 05:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ+lljTC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63077FD;
	Fri,  7 Mar 2025 05:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741325530; cv=none; b=mpYQacHk4veyvNQL5EWDx5EJk1rdUV/kbVFnSjgChYWAnUvXcJKSAHAK2G9ESLXalTJSE8nv6RhANJ5MnGXYR6I1wkC7Ei3LAQz8b5dIOuDP2GkTbxTv5av3jPg5MI8CbEJlLO5PHVFF5WX46jTLTXiE/FjQ9Vt0GF4IXhtuhzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741325530; c=relaxed/simple;
	bh=q/OGGBTCPmP4Udx/qeygD3cIJ2xnQNHrGdENR6SWJ/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRjlSSOlFHpa9w3hJg2D0bD1JIne7UU/MLVwzQnJZqCs2FzD+oZJko0vJZD4P8ifOgwC5a3IZa2d546A7btO+E/SKkA84LxyNWNK9wbGNKWfdA5neO6nRtl1JzdHk8/3R2RDXtqLi71LLFcBm4XATSfChhiKpOCH2g685zv9jdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ+lljTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B960C4CED1;
	Fri,  7 Mar 2025 05:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741325529;
	bh=q/OGGBTCPmP4Udx/qeygD3cIJ2xnQNHrGdENR6SWJ/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZ+lljTCxsj2RC3AiJcM+1C44pzG6kj6sIL8M9ApT74IXt2o7Zxf6rR8DOqeeltXH
	 sZvhmRU0yh0V+hw7mz1Cd4Oj423VvbMaDJ8xIN7qDfwr4kl9odHtvitat9IB6qy+pI
	 0p0R5gBoV9ROnGenLnQiNCUmBbzFT6vKV5OnBykkh5MGAgpjCp3KMy7hJ4nSuj22up
	 FFjYjmj68oyKK15hW23r5cqin3nB+oSTdy/or9sP6YQVz1eV5IxG4VOc50W+3MyVRK
	 v3mC7tkrrcaRogF8gftQqlNOSAwSsvFE0BXP/000lzqWOVYJpemUBnvie48nRAhNaT
	 9Y8OzTYP3Q4qw==
Date: Fri, 7 Mar 2025 07:32:04 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v12 03/19] x86: Secure Launch Resource Table header file
Message-ID: <Z8qE1B47InxE7n-v@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-4-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219194216.152839-4-ross.philipson@oracle.com>

On Thu, Dec 19, 2024 at 11:42:00AM -0800, Ross Philipson wrote:
> Introduce the Secure Launch Resource Table which forms the formal
> interface between the pre and post launch code.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Is this interface kernel specific or uarch specific? I'd just
explicitly state the context of the formal interface, that's
all.

> ---
>  include/linux/slr_table.h | 277 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 277 insertions(+)
>  create mode 100644 include/linux/slr_table.h
> 
> diff --git a/include/linux/slr_table.h b/include/linux/slr_table.h
> new file mode 100644
> index 000000000000..48d85d505a50
> --- /dev/null
> +++ b/include/linux/slr_table.h
> @@ -0,0 +1,277 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * TrenchBoot Secure Launch Resource Table
> + *
> + * The Secure Launch Resource Table is TrenchBoot project defined
> + * specfication to provide cross-architecture compatibility. See
> + * TrenchBoot Secure Launch kernel documentation for details.
> + *
> + * Copyright (c) 2024 Apertus Solutions, LLC
> + * Copyright (c) 2024, Oracle and/or its affiliates.
> + */
> +
> +#ifndef _LINUX_SLR_TABLE_H
> +#define _LINUX_SLR_TABLE_H
> +
> +/* Put this in efi.h if it becomes a standard */
> +#define SLR_TABLE_GUID				EFI_GUID(0x877a9b2a, 0x0385, 0x45d1, 0xa0, 0x34, 0x9d, 0xac, 0x9c, 0x9e, 0x56, 0x5f)
> +
> +/* SLR table header values */
> +#define SLR_TABLE_MAGIC		0x4452544d
> +#define SLR_TABLE_REVISION	1
> +
> +/* Current revisions for the policy and UEFI config */
> +#define SLR_POLICY_REVISION		1
> +#define SLR_UEFI_CONFIG_REVISION	1
> +
> +/* SLR defined architectures */
> +#define SLR_INTEL_TXT		1
> +#define SLR_AMD_SKINIT		2
> +
> +/* SLR defined bootloaders */
> +#define SLR_BOOTLOADER_INVALID	0
> +#define SLR_BOOTLOADER_GRUB	1
> +
> +/* Log formats */
> +#define SLR_DRTM_TPM12_LOG	1
> +#define SLR_DRTM_TPM20_LOG	2
> +
> +/* DRTM Policy Entry Flags */
> +#define SLR_POLICY_FLAG_MEASURED	0x1
> +#define SLR_POLICY_IMPLICIT_SIZE	0x2
> +
> +/* Array Lengths */
> +#define TPM_EVENT_INFO_LENGTH		32
> +#define TXT_VARIABLE_MTRRS_LENGTH	32
> +
> +/* Tags */
> +#define SLR_ENTRY_INVALID	0x0000
> +#define SLR_ENTRY_DL_INFO	0x0001
> +#define SLR_ENTRY_LOG_INFO	0x0002
> +#define SLR_ENTRY_ENTRY_POLICY	0x0003
> +#define SLR_ENTRY_INTEL_INFO	0x0004
> +#define SLR_ENTRY_AMD_INFO	0x0005
> +#define SLR_ENTRY_ARM_INFO	0x0006
> +#define SLR_ENTRY_UEFI_INFO	0x0007
> +#define SLR_ENTRY_UEFI_CONFIG	0x0008
> +#define SLR_ENTRY_END		0xffff
> +
> +/* Entity Types */
> +#define SLR_ET_UNSPECIFIED	0x0000
> +#define SLR_ET_SLRT		0x0001
> +#define SLR_ET_BOOT_PARAMS	0x0002
> +#define SLR_ET_SETUP_DATA	0x0003
> +#define SLR_ET_CMDLINE		0x0004
> +#define SLR_ET_UEFI_MEMMAP	0x0005
> +#define SLR_ET_RAMDISK		0x0006
> +#define SLR_ET_TXT_OS2MLE	0x0010
> +#define SLR_ET_UNUSED		0xffff
> +
> +#ifndef __ASSEMBLY__
> +
> +/*
> + * Primary Secure Launch Resource Table Header
> + */
> +struct slr_table {
> +	u32 magic;
> +	u16 revision;
> +	u16 architecture;
> +	u32 size;
> +	u32 max_size;
> +	/* table entries */
> +} __packed;
> +
> +/*
> + * Common SLRT Table Header
> + */
> +struct slr_entry_hdr {
> +	u32 tag;
> +	u32 size;
> +} __packed;
> +
> +/*
> + * Boot loader context
> + */
> +struct slr_bl_context {
> +	u16 bootloader;
> +	u16 reserved[3];
> +	u64 context;
> +} __packed;
> +
> +/*
> + * Dynamic Launch Callback Function type
> + */
> +typedef void (*dl_handler_func)(struct slr_bl_context *bl_context);
> +
> +/*
> + * DRTM Dynamic Launch Configuration
> + */
> +struct slr_entry_dl_info {
> +	struct slr_entry_hdr hdr;
> +	u64 dce_size;
> +	u64 dce_base;
> +	u64 dlme_size;
> +	u64 dlme_base;
> +	u64 dlme_entry;
> +	struct slr_bl_context bl_context;
> +	u64 dl_handler;
> +} __packed;
> +
> +/*
> + * TPM Log Information
> + */
> +struct slr_entry_log_info {
> +	struct slr_entry_hdr hdr;
> +	u16 format;
> +	u16 reserved;
> +	u32 size;
> +	u64 addr;
> +} __packed;
> +
> +/*
> + * DRTM Measurement Entry
> + */
> +struct slr_policy_entry {
> +	u16 pcr;
> +	u16 entity_type;
> +	u16 flags;
> +	u16 reserved;
> +	u64 size;
> +	u64 entity;
> +	char evt_info[TPM_EVENT_INFO_LENGTH];
> +} __packed;
> +
> +/*
> + * DRTM Measurement Policy
> + */
> +struct slr_entry_policy {
> +	struct slr_entry_hdr hdr;
> +	u16 reserved[2];
> +	u16 revision;
> +	u16 nr_entries;
> +	struct slr_policy_entry policy_entries[];
> +} __packed;
> +
> +/*
> + * Secure Launch defined MTRR saving structures
> + */
> +struct slr_txt_mtrr_pair {
> +	u64 mtrr_physbase;
> +	u64 mtrr_physmask;
> +} __packed;
> +
> +struct slr_txt_mtrr_state {
> +	u64 default_mem_type;
> +	u64 mtrr_vcnt;
> +	struct slr_txt_mtrr_pair mtrr_pair[TXT_VARIABLE_MTRRS_LENGTH];
> +} __packed;
> +
> +/*
> + * Intel TXT Info table
> + */
> +struct slr_entry_intel_info {
> +	struct slr_entry_hdr hdr;
> +	u64 boot_params_addr;
> +	u64 txt_heap;
> +	u64 saved_misc_enable_msr;
> +	struct slr_txt_mtrr_state saved_bsp_mtrrs;
> +} __packed;
> +
> +/*
> + * UEFI config measurement entry
> + */
> +struct slr_uefi_cfg_entry {
> +	u16 pcr;
> +	u16 reserved;
> +	u32 size;
> +	u64 cfg; /* address or value */
> +	char evt_info[TPM_EVENT_INFO_LENGTH];
> +} __packed;
> +
> +/*
> + * UEFI config measurements
> + */
> +struct slr_entry_uefi_config {
> +	struct slr_entry_hdr hdr;
> +	u16 reserved[2];
> +	u16 revision;
> +	u16 nr_entries;
> +	struct slr_uefi_cfg_entry uefi_cfg_entries[];
> +} __packed;
> +
> +static inline void *slr_end_of_entries(struct slr_table *table)

I'd document these functions. No need to go over the top here i.e.,
no need to have full parameter descriptions but more like

/*
 * Tell a short description.
 */

> +{
> +	return (void *)table + table->size;
> +}
> +
> +static inline void *
> +slr_next_entry(struct slr_table *table,
> +	       struct slr_entry_hdr *curr)
> +{
> +	struct slr_entry_hdr *next = (struct slr_entry_hdr *)((u8 *)curr + curr->size);
> +
> +	if ((void *)next >= slr_end_of_entries(table))
> +		return NULL;
> +	if (next->tag == SLR_ENTRY_END)
> +		return NULL;
> +
> +	return next;
> +}
> +
> +static inline void *
> +slr_next_entry_by_tag(struct slr_table *table,
> +		      struct slr_entry_hdr *entry,
> +		      u16 tag)
> +{
> +	if (!entry) /* Start from the beginning */
> +		entry = (struct slr_entry_hdr *)(((u8 *)table) + sizeof(*table));
> +
> +	for ( ; ; ) {
> +		if (entry->tag == tag)
> +			return entry;
> +
> +		entry = slr_next_entry(table, entry);
> +		if (!entry)
> +			return NULL;
> +	}
> +
> +	return NULL;
> +}
> +
> +static inline int
> +slr_add_entry(struct slr_table *table,
> +	      struct slr_entry_hdr *entry)
> +{
> +	struct slr_entry_hdr *end;
> +
> +	if ((table->size + entry->size) > table->max_size)
> +		return -1;
> +
> +	memcpy((u8 *)table + table->size - sizeof(*end), entry, entry->size);
> +	table->size += entry->size;
> +
> +	end  = (struct slr_entry_hdr *)((u8 *)table + table->size - sizeof(*end));
> +	end->tag = SLR_ENTRY_END;
> +	end->size = sizeof(*end);
> +
> +	return 0;
> +}
> +
> +static inline void
> +slr_init_table(struct slr_table *slrt, u16 architecture, u32 max_size)

E.g., what does slr_init_table() do and why and when it is called. Basic
shit.

> +{
> +	struct slr_entry_hdr *end;
> +
> +	slrt->magic = SLR_TABLE_MAGIC;
> +	slrt->revision = SLR_TABLE_REVISION;
> +	slrt->architecture = architecture;
> +	slrt->size = sizeof(*slrt) + sizeof(*end);
> +	slrt->max_size = max_size;
> +	end = (struct slr_entry_hdr *)((u8 *)slrt + sizeof(*slrt));
> +	end->tag = SLR_ENTRY_END;
> +	end->size = sizeof(*end);
> +}
> +
> +#endif /* !__ASSEMBLY */
> +
> +#endif /* _LINUX_SLR_TABLE_H */
> -- 
> 2.39.3
> 

BR, Jarkko

