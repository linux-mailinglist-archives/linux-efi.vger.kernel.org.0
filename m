Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC8F272B93
	for <lists+linux-efi@lfdr.de>; Mon, 21 Sep 2020 18:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgIUQTE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Sep 2020 12:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIUQTD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 21 Sep 2020 12:19:03 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77911C061755;
        Mon, 21 Sep 2020 09:19:03 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id o16so15682945qkj.10;
        Mon, 21 Sep 2020 09:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TaDr80GYFcZAoIpTA3OojJ23kD8OgMWUV14tApxnAM0=;
        b=ME1Ww4vWvX5Y9FyAHHa52LnbtMd6gum3SrXIGxh1ipbQlFaw9P7DVmn/ke0j+YHqcP
         GWFvDKlSBEknk05WfxwegF6OhAlR67cavk4Nl+SSU0Ne7drOaL+0rc45Wxhi1ezv+/Sc
         j/JaV55a6z9ARAs5+xSLOnT8QImn1N4MAoBW0nXBKau+W9cGcO1KGhLvz/beHcBw9NSG
         r47UTP5xkQO3OHT+7IzqEm5ecoldJNbJzrq79oIWE7Fd+PxgE+H/6adEsFF2opCIxqmr
         b3z8uvATgBLGhFsH9y97dsIQwrKcpxwTLWp/qn+Dre3c6hU6FaZERkXz29wNDJ0GdTgF
         YiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TaDr80GYFcZAoIpTA3OojJ23kD8OgMWUV14tApxnAM0=;
        b=eOOP1uyno06f9UDgTCeRCuoAucUZuqXanARNwiMbF5ozOkNauALGmwFyahVk8ILMRD
         zrAwtV2Kv5/h52b7hOZQ/N/I8NJhEQM6L15cJFr55bdIefnBzgmTmciLtUki21SV/Gu+
         dvK4LcTjYpaxJdp7rTyNZvfv1rlF2w0sDZRCHNxfbAm/9YH2+B+zVEHiUhqYR0j6BorN
         9tOAiEdyxh9dtkZvpWsOd57lLHR/yx5MjdFdrXp7pB3drg7YEZ/YunOZPxILYV+LdtST
         BhXyQSrbq4NCls1AIllz7gfiXOVZD/QHXDeRN+SdgcbeDORHxj06ueiesa6ju7E0G8WJ
         OOww==
X-Gm-Message-State: AOAM532stO+YFbtkjFzQX37wKp8VQOFRVZ97XnZi89nLpjC0DlwoehTM
        SFkTN4duiGh0fX0PD88EMreWAIx7GLU=
X-Google-Smtp-Source: ABdhPJyJuwDAUIKAEys2wskNPAKM3FjUQ4ALQic4gO/HbOmW6tZI9OKbOgYmIPG0xX61Gn7b0M7gEA==
X-Received: by 2002:a37:a189:: with SMTP id k131mr583351qke.34.1600705142341;
        Mon, 21 Sep 2020 09:19:02 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v28sm3025301qkv.72.2020.09.21.09.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 09:19:01 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 21 Sep 2020 12:18:59 -0400
To:     Lenny Szubowicz <lszubowi@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org, andy.shevchenko@gmail.com,
        ardb@kernel.org, jmorris@namei.org, serge@hallyn.com,
        keescook@chromium.org, zohar@linux.ibm.com, bp@alien8.de,
        pjones@redhat.com, dhowells@redhat.com, prarit@redhat.com
Subject: Re: [PATCH V2 1/3] efi: Support for MOK variable config table
Message-ID: <20200921161859.GA544292@rani.riverdale.lan>
References: <20200905013107.10457-1-lszubowi@redhat.com>
 <20200905013107.10457-2-lszubowi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200905013107.10457-2-lszubowi@redhat.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Sep 04, 2020 at 09:31:05PM -0400, Lenny Szubowicz wrote:
> Because of system-specific EFI firmware limitations, EFI volatile
> variables may not be capable of holding the required contents of
> the Machine Owner Key (MOK) certificate store when the certificate
> list grows above some size. Therefore, an EFI boot loader may pass
> the MOK certs via a EFI configuration table created specifically for
> this purpose to avoid this firmware limitation.
> 
> An EFI configuration table is a much more primitive mechanism
> compared to EFI variables and is well suited for one-way passage
> of static information from a pre-OS environment to the kernel.
> 
> This patch adds initial kernel support to recognize, parse,
> and validate the EFI MOK configuration table, where named
> entries contain the same data that would otherwise be provided
> in similarly named EFI variables.
> 
> Additionally, this patch creates a sysfs binary file for each
> EFI MOK configuration table entry found. These files are read-only
> to root and are provided for use by user space utilities such as
> mokutil.
> 
> A subsequent patch will load MOK certs into the trusted platform
> key ring using this infrastructure.
> 
> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
> ---
>  arch/x86/kernel/setup.c             |   1 +
>  arch/x86/platform/efi/efi.c         |   3 +
>  drivers/firmware/efi/Makefile       |   1 +
>  drivers/firmware/efi/arm-init.c     |   1 +
>  drivers/firmware/efi/efi.c          |   6 +
>  drivers/firmware/efi/mokvar-table.c | 360 ++++++++++++++++++++++++++++
>  include/linux/efi.h                 |  34 +++
>  7 files changed, 406 insertions(+)
>  create mode 100644 drivers/firmware/efi/mokvar-table.c
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 3511736fbc74..d41be0df72f8 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1077,6 +1077,7 @@ void __init setup_arch(char **cmdline_p)
>  	efi_fake_memmap();
>  	efi_find_mirror();
>  	efi_esrt_init();
> +	efi_mokvar_table_init();
>  
>  	/*
>  	 * The EFI specification says that boot service code won't be
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index d37ebe6e70d7..8a26e705cb06 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -90,6 +90,9 @@ static const unsigned long * const efi_tables[] = {
>  	&efi.tpm_log,
>  	&efi.tpm_final_log,
>  	&efi_rng_seed,
> +#ifdef CONFIG_LOAD_UEFI_KEYS
> +	&efi.mokvar_table,
> +#endif
>  };
>  
>  u64 efi_setup;		/* efi setup_data physical address */
> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> index 7a216984552b..03964e2d27c5 100644
> --- a/drivers/firmware/efi/Makefile
> +++ b/drivers/firmware/efi/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_EFI_DEV_PATH_PARSER)	+= dev-path-parser.o
>  obj-$(CONFIG_APPLE_PROPERTIES)		+= apple-properties.o
>  obj-$(CONFIG_EFI_RCI2_TABLE)		+= rci2-table.o
>  obj-$(CONFIG_EFI_EMBEDDED_FIRMWARE)	+= embedded-firmware.o
> +obj-$(CONFIG_LOAD_UEFI_KEYS)		+= mokvar-table.o
>  
>  fake_map-y				+= fake_mem.o
>  fake_map-$(CONFIG_X86)			+= x86_fake_mem.o
> diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
> index 71c445d20258..f55a92ff12c0 100644
> --- a/drivers/firmware/efi/arm-init.c
> +++ b/drivers/firmware/efi/arm-init.c
> @@ -236,6 +236,7 @@ void __init efi_init(void)
>  
>  	reserve_regions();
>  	efi_esrt_init();
> +	efi_mokvar_table_init();
>  
>  	memblock_reserve(data.phys_map & PAGE_MASK,
>  			 PAGE_ALIGN(data.size + (data.phys_map & ~PAGE_MASK)));
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 3aa07c3b5136..3d4daf215e19 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -43,6 +43,9 @@ struct efi __read_mostly efi = {
>  	.esrt			= EFI_INVALID_TABLE_ADDR,
>  	.tpm_log		= EFI_INVALID_TABLE_ADDR,
>  	.tpm_final_log		= EFI_INVALID_TABLE_ADDR,
> +#ifdef CONFIG_LOAD_UEFI_KEYS
> +	.mokvar_table		= EFI_INVALID_TABLE_ADDR,
> +#endif
>  };
>  EXPORT_SYMBOL(efi);
>  
> @@ -518,6 +521,9 @@ static const efi_config_table_type_t common_tables[] __initconst = {
>  	{EFI_RT_PROPERTIES_TABLE_GUID,		&rt_prop,		"RTPROP"	},
>  #ifdef CONFIG_EFI_RCI2_TABLE
>  	{DELLEMC_EFI_RCI2_TABLE_GUID,		&rci2_table_phys			},
> +#endif
> +#ifdef CONFIG_LOAD_UEFI_KEYS
> +	{LINUX_EFI_MOK_VARIABLE_TABLE_GUID,	&efi.mokvar_table,	"MOKvar"	},
>  #endif
>  	{},
>  };
> diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
> new file mode 100644
> index 000000000000..f12f1710f5d9
> --- /dev/null
> +++ b/drivers/firmware/efi/mokvar-table.c
> @@ -0,0 +1,360 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * mokvar-table.c
> + *
> + * Copyright (c) 2020 Red Hat
> + * Author: Lenny Szubowicz <lszubowi@redhat.com>
> + *
> + * This module contains the kernel support for the Linux EFI Machine
> + * Owner Key (MOK) variable configuration table, which is identified by
> + * the LINUX_EFI_MOK_VARIABLE_TABLE_GUID.
> + *
> + * This EFI configuration table provides a more robust alternative to
> + * EFI volatile variables by which an EFI boot loader can pass the
> + * contents of the Machine Owner Key (MOK) certificate stores to the
> + * kernel during boot. If both the EFI MOK config table and corresponding
> + * EFI MOK variables are present, the table should be considered as
> + * more authoritative.
> + *
> + * This module includes code that validates and maps the EFI MOK table,
> + * if it's presence was detected very early in boot.
> + *
> + * Kernel interface routines are provided to walk through all the
> + * entries in the MOK config table or to search for a specific named
> + * entry.
> + *
> + * The contents of the individual named MOK config table entries are
> + * made available to user space via read-only sysfs binary files under:
> + *
> + * /sys/firmware/efi/mok-variables/
> + *
> + */
> +#define pr_fmt(fmt) "mokvar: " fmt
> +
> +#include <linux/capability.h>
> +#include <linux/efi.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/kobject.h>
> +#include <linux/list.h>
> +#include <linux/slab.h>
> +
> +/*
> + * The LINUX_EFI_MOK_VARIABLE_TABLE_GUID config table is a packed
> + * sequence of struct efi_mokvar_table_entry, one for each named
> + * MOK variable. The sequence is terminated by an entry with a
> + * completely NULL name and 0 data size.
> + *
> + * efi_mokvar_table_size is set to the computed size of the
> + * MOK config table by efi_mokvar_table_init(). This will be
> + * non-zero if and only if the table if present and has been
> + * validated by efi_mokvar_table_init().
> + */
> +static size_t efi_mokvar_table_size;
> +
> +/*
> + * efi_mokvar_table_va is the kernel virtual address at which the
> + * EFI MOK config table has been mapped by efi_mokvar_sysfs_init().
> + */
> +static struct efi_mokvar_table_entry *efi_mokvar_table_va;
> +
> +/*
> + * Each /sys/firmware/efi/mok-variables/ sysfs file is represented by
> + * an instance of struct efi_mokvar_sysfs_attr on efi_mokvar_sysfs_list.
> + * bin_attr.private points to the associated EFI MOK config table entry.
> + *
> + * This list is created during boot and then remains unchanged.
> + * So no sychronization is currently required to walk the list.
> + */
> +struct efi_mokvar_sysfs_attr {
> +	struct bin_attribute bin_attr;
> +	struct list_head node;
> +};
> +
> +static LIST_HEAD(efi_mokvar_sysfs_list);
> +static struct kobject *mokvar_kobj;
> +
> +/*
> + * efi_mokvar_table_init() - Early boot validation of EFI MOK config table
> + *
> + * If present, validate and compute the size of the EFI MOK variable
> + * configuration table. This table may be provided by an EFI boot loader
> + * as an alternative to ordinary EFI variables, due to platform-dependent
> + * limitations. The memory occupied by this table is marked as reserved.
> + *
> + * This routine must be called before efi_free_boot_services() in order
> + * to guarantee that it can mark the table as reserved.
> + *
> + * Implicit inputs:
> + * efi.mokvar_table:	Physical address of EFI MOK variable config table
> + *			or special value that indicates no such table.
> + *
> + * Implicit outputs:
> + * efi_mokvar_table_size: Computed size of EFI MOK variable config table.
> + *			The table is considered present and valid if this
> + *			is non-zero.
> + */
> +void __init efi_mokvar_table_init(void)
> +{
> +	efi_memory_desc_t md;
> +	u64 end_pa;
> +	void *va = NULL;
> +	size_t cur_offset = 0;
> +	size_t offset_limit;
> +	size_t map_size = 0;
> +	size_t map_size_needed = 0;
> +	size_t size;
> +	struct efi_mokvar_table_entry *mokvar_entry;
> +	int err = -EINVAL;
> +
> +	if (!efi_enabled(EFI_MEMMAP))
> +		return;
> +
> +	if (efi.mokvar_table == EFI_INVALID_TABLE_ADDR)
> +		return;
> +	/*
> +	 * The EFI MOK config table must fit within a single EFI memory
> +	 * descriptor range.
> +	 */
> +	err = efi_mem_desc_lookup(efi.mokvar_table, &md);
> +	if (err) {
> +		pr_warn("EFI MOKvar config table is not within the EFI memory map\n");
> +		return;
> +	}
> +	end_pa = efi_mem_desc_end(&md);
> +	if (efi.mokvar_table >= end_pa) {
> +		pr_err("EFI memory descriptor containing MOKvar config table is invalid\n");
> +		return;
> +	}

efi_mem_desc_lookup() can't return success if efi.mokvar_table >= end_pa, 
why check it again?

> +	offset_limit = end_pa - efi.mokvar_table;
> +	/*
> +	 * Validate the MOK config table. Since there is no table header
> +	 * from which we could get the total size of the MOK config table,
> +	 * we compute the total size as we validate each variably sized
> +	 * entry, remapping as necessary.
> +	 */
> +	while (cur_offset + sizeof(*mokvar_entry) <= offset_limit) {
> +		mokvar_entry = va + cur_offset;
> +		map_size_needed = cur_offset + sizeof(*mokvar_entry);
> +		if (map_size_needed > map_size) {
> +			if (va)
> +				early_memunmap(va, map_size);
> +			/*
> +			 * Map a little more than the fixed size entry
> +			 * header, anticipating some data. It's safe to
> +			 * do so as long as we stay within current memory
> +			 * descriptor.
> +			 */
> +			map_size = min(map_size_needed + 2*EFI_PAGE_SIZE,
> +				       offset_limit);
> +			va = early_memremap(efi.mokvar_table, map_size);

Can't we just map the entire region from efi.mokvar_table to end_pa in
one early_memremap call before the loop and avoid all the remapping
logic?

> +			if (!va) {
> +				pr_err("Failed to map EFI MOKvar config table pa=0x%lx, size=%zu.\n",
> +				       efi.mokvar_table, map_size);
> +				return;
> +			}
> +			mokvar_entry = va + cur_offset;
> +		}
> +
> +		/* Check for last sentinel entry */
> +		if (mokvar_entry->name[0] == '\0') {
> +			if (mokvar_entry->data_size != 0)
> +				break;
> +			err = 0;
> +			break;
> +		}
> +
> +		/* Sanity check that the name is null terminated */
> +		size = strnlen(mokvar_entry->name,
> +			       sizeof(mokvar_entry->name));
> +		if (size >= sizeof(mokvar_entry->name))
> +			break;
> +
> +		/* Advance to the next entry */
> +		cur_offset = map_size_needed + mokvar_entry->data_size;
> +	}
> +
> +	if (va)
> +		early_memunmap(va, map_size);
> +	if (err) {
> +		pr_err("EFI MOKvar config table is not valid\n");
> +		return;
> +	}

err will never be non-zero here: it was cleared when the
efi_mem_desc_lookup() was done. I think the initialization of err to
-EINVAL needs to be moved just prior to the loop.

> +	efi_mem_reserve(efi.mokvar_table, map_size_needed);
> +	efi_mokvar_table_size = map_size_needed;
> +}
> +
> +/*
> + * efi_mokvar_entry_next() - Get next entry in the EFI MOK config table
> + *
> + * mokvar_entry:	Pointer to current EFI MOK config table entry
> + *			or null. Null indicates get first entry.
> + *			Passed by reference. This is updated to the
> + *			same value as the return value.
> + *
> + * Returns:		Pointer to next EFI MOK config table entry
> + *			or null, if there are no more entries.
> + *			Same value is returned in the mokvar_entry
> + *			parameter.
> + *
> + * This routine depends on the EFI MOK config table being entirely
> + * mapped with it's starting virtual address in efi_mokvar_table_va.
> + */
> +struct efi_mokvar_table_entry *efi_mokvar_entry_next(
> +			struct efi_mokvar_table_entry **mokvar_entry)
> +{
> +	struct efi_mokvar_table_entry *mokvar_cur;
> +	struct efi_mokvar_table_entry *mokvar_next;
> +	size_t size_cur;
> +
> +	mokvar_cur = *mokvar_entry;
> +	*mokvar_entry = NULL;
> +
> +	if (efi_mokvar_table_va == NULL)
> +		return NULL;
> +
> +	if (mokvar_cur == NULL) {
> +		mokvar_next = efi_mokvar_table_va;
> +	} else {
> +		if (mokvar_cur->name[0] == '\0')
> +			return NULL;
> +		size_cur = sizeof(*mokvar_cur) + mokvar_cur->data_size;
> +		mokvar_next = (void *)mokvar_cur + size_cur;
> +	}
> +
> +	if (mokvar_next->name[0] == '\0')
> +		return NULL;
> +
> +	*mokvar_entry = mokvar_next;
> +	return mokvar_next;
> +}
> +
> +/*
> + * efi_mokvar_entry_find() - Find EFI MOK config entry by name
> + *
> + * name:	Name of the entry to look for.
> + *
> + * Returns:	Pointer to EFI MOK config table entry if found;
> + *		null otherwise.
> + *
> + * This routine depends on the EFI MOK config table being entirely
> + * mapped with it's starting virtual address in efi_mokvar_table_va.
> + */
> +struct efi_mokvar_table_entry *efi_mokvar_entry_find(const char *name)
> +{
> +	struct efi_mokvar_table_entry *mokvar_entry = NULL;
> +
> +	while (efi_mokvar_entry_next(&mokvar_entry)) {
> +		if (!strncmp(name, mokvar_entry->name,
> +			     sizeof(mokvar_entry->name)))
> +			return mokvar_entry;
> +	}
> +	return NULL;
> +}
> +
> +/*
> + * efi_mokvar_sysfs_read() - sysfs binary file read routine
> + *
> + * Returns:	Count of bytes read.
> + *
> + * Copy EFI MOK config table entry data for this mokvar sysfs binary file
> + * to the supplied buffer, starting at the specified offset into mokvar table
> + * entry data, for the specified count bytes. The copy is limited by the
> + * amount of data in this mokvar config table entry.
> + */
> +static ssize_t efi_mokvar_sysfs_read(struct file *file, struct kobject *kobj,
> +				 struct bin_attribute *bin_attr, char *buf,
> +				 loff_t off, size_t count)
> +{
> +	struct efi_mokvar_table_entry *mokvar_entry = bin_attr->private;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return 0;
> +
> +	if (off >= mokvar_entry->data_size)
> +		return 0;
> +	if (count >  mokvar_entry->data_size - off)
> +		count = mokvar_entry->data_size - off;
> +
> +	memcpy(buf, mokvar_entry->data + off, count);
> +	return count;
> +}
> +
> +/*
> + * efi_mokvar_sysfs_init() - Map EFI MOK config table and create sysfs
> + *
> + * Map the EFI MOK variable config table for run-time use by the kernel
> + * and create the sysfs entries in /sys/firmware/efi/mok-variables/
> + *
> + * This routine just returns if a valid EFI MOK variable config table
> + * was not found earlier during boot.
> + *
> + * This routine must be called during a "middle" initcall phase, i.e.
> + * after efi_mokvar_table_init() but before UEFI certs are loaded
> + * during late init.
> + *
> + * Implicit inputs:
> + * efi.mokvar_table:	Physical address of EFI MOK variable config table
> + *			or special value that indicates no such table.
> + *
> + * efi_mokvar_table_size: Computed size of EFI MOK variable config table.
> + *			The table is considered present and valid if this
> + *			is non-zero.
> + *
> + * Implicit outputs:
> + * efi_mokvar_table_va:	Start virtual address of the EFI MOK config table.
> + */
> +static int __init efi_mokvar_sysfs_init(void)
> +{
> +	void *config_va;
> +	struct efi_mokvar_table_entry *mokvar_entry = NULL;
> +	struct efi_mokvar_sysfs_attr *mokvar_sysfs = NULL;
> +	int err = 0;
> +
> +	if (efi_mokvar_table_size == 0)
> +		return -ENOENT;
> +
> +	config_va = memremap(efi.mokvar_table, efi_mokvar_table_size,
> +			     MEMREMAP_WB);
> +	if (!config_va) {
> +		pr_err("Failed to map EFI MOKvar config table\n");
> +		return -ENOMEM;
> +	}
> +	efi_mokvar_table_va = config_va;
> +
> +	mokvar_kobj = kobject_create_and_add("mok-variables", efi_kobj);
> +	if (!mokvar_kobj) {
> +		pr_err("Failed to create EFI mok-variables sysfs entry\n");
> +		return -ENOMEM;
> +	}
> +
> +	while (efi_mokvar_entry_next(&mokvar_entry)) {
> +		mokvar_sysfs = kzalloc(sizeof(*mokvar_sysfs), GFP_KERNEL);
> +		if (!mokvar_sysfs) {
> +			err = -ENOMEM;
> +			break;
> +		}
> +
> +		sysfs_bin_attr_init(&mokvar_sysfs->bin_attr);
> +		mokvar_sysfs->bin_attr.private = mokvar_entry;
> +		mokvar_sysfs->bin_attr.attr.name = mokvar_entry->name;
> +		mokvar_sysfs->bin_attr.attr.mode = 0400;
> +		mokvar_sysfs->bin_attr.size = mokvar_entry->data_size;
> +		mokvar_sysfs->bin_attr.read = efi_mokvar_sysfs_read;
> +
> +		err = sysfs_create_bin_file(mokvar_kobj,
> +					   &mokvar_sysfs->bin_attr);
> +		if (err)
> +			break;
> +
> +		list_add_tail(&mokvar_sysfs->node, &efi_mokvar_sysfs_list);
> +	}
> +
> +	if (err) {
> +		pr_err("Failed to create some EFI mok-variables sysfs entries\n");
> +		kfree(mokvar_sysfs);
> +	}
> +	return err;
> +}
> +device_initcall(efi_mokvar_sysfs_init);
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 73db1ae04cef..4a2332f146eb 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -357,6 +357,7 @@ void efi_native_runtime_setup(void);
>  #define LINUX_EFI_TPM_FINAL_LOG_GUID		EFI_GUID(0x1e2ed096, 0x30e2, 0x4254,  0xbd, 0x89, 0x86, 0x3b, 0xbe, 0xf8, 0x23, 0x25)
>  #define LINUX_EFI_MEMRESERVE_TABLE_GUID		EFI_GUID(0x888eb0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
>  #define LINUX_EFI_INITRD_MEDIA_GUID		EFI_GUID(0x5568e427, 0x68fc, 0x4f3d,  0xac, 0x74, 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
> +#define LINUX_EFI_MOK_VARIABLE_TABLE_GUID	EFI_GUID(0xc451ed2b, 0x9694, 0x45d3,  0xba, 0xba, 0xed, 0x9f, 0x89, 0x88, 0xa3, 0x89)
>  
>  /* OEM GUIDs */
>  #define DELLEMC_EFI_RCI2_TABLE_GUID		EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
> @@ -546,6 +547,7 @@ extern struct efi {
>  	unsigned long			esrt;			/* ESRT table */
>  	unsigned long			tpm_log;		/* TPM2 Event Log table */
>  	unsigned long			tpm_final_log;		/* TPM2 Final Events Log table */
> +	unsigned long			mokvar_table;		/* MOK variable config table */
>  
>  	efi_get_time_t			*get_time;
>  	efi_set_time_t			*set_time;
> @@ -1252,4 +1254,36 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size);
>  
>  char *efi_systab_show_arch(char *str);
>  
> +/*
> + * The LINUX_EFI_MOK_VARIABLE_TABLE_GUID config table can be provided
> + * to the kernel by an EFI boot loader. The table contains a packed
> + * sequence of these entries, one for each named MOK variable.
> + * The sequence is terminated by an entry with a completely NULL
> + * name and 0 data size.
> + */
> +struct efi_mokvar_table_entry {
> +	char name[256];
> +	u64 data_size;
> +	u8 data[];
> +} __attribute((packed));
> +
> +#ifdef CONFIG_LOAD_UEFI_KEYS
> +extern void __init efi_mokvar_table_init(void);
> +extern struct efi_mokvar_table_entry *efi_mokvar_entry_next(
> +			struct efi_mokvar_table_entry **mokvar_entry);
> +extern struct efi_mokvar_table_entry *efi_mokvar_entry_find(const char *name);
> +#else
> +static inline void efi_mokvar_table_init(void) { }
> +static inline struct efi_mokvar_table_entry *efi_mokvar_entry_next(
> +			struct efi_mokvar_table_entry **mokvar_entry)
> +{
> +	return NULL;
> +}
> +static inline struct efi_mokvar_table_entry *efi_mokvar_entry_find(
> +			const char *name)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  #endif /* _LINUX_EFI_H */
> -- 
> 2.27.0
> 
