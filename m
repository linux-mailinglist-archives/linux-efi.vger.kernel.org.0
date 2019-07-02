Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01A935D73B
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jul 2019 21:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfGBT5n (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Jul 2019 15:57:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35039 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfGBT5n (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Jul 2019 15:57:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id c6so2353820wml.0
        for <linux-efi@vger.kernel.org>; Tue, 02 Jul 2019 12:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjrk1pVZ4Z7w/ErEMaFb8Ofh57LYEsiHgRHQuL1k9jQ=;
        b=xKsvVdoNEKUDWzoCkkCp0p0HPi2cs65s65d4rVSag0owCl471Es8jrs0s+bxv5fJc8
         c/qrMkYNwSQr9Jx/9qVHo8VxJrgraT0nD2RZO86MhqoV0rOh4mOhqQl7XhBE3sXAOTAg
         GdjZBtgy0NHGQwLUWdNFGRUPKb2t84YuenPohVYoLrBePQbq0a7k4EF+8MgbVF8Oiv2Q
         pRuDSpFSTwCiiRuoArf2YUjAXp2xBx3ZRptjcm+gg6VOlv4uczRDTxOBKZZbdnLPhtih
         qtM8VhMHudddYQzhdrUXZTq0zbOPATobEpI821lQmM0PfZEKL7bXVmD4DCBYK90L33Zo
         zgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjrk1pVZ4Z7w/ErEMaFb8Ofh57LYEsiHgRHQuL1k9jQ=;
        b=qsCsrzgXrWNnEHO286b0YWG1aHcfUGyxtkHSbnhcI62EDp/mmyW+n1pCYJnkfYxs0P
         ytLK8gosTLHFMIIX5rWy0chSKiDEgmmtyKi3wlUgCUaTyTGHBX2cywyrhu0B2OTvSHCf
         kgUA5Z6e/8lELudjwAlix9ZVlya8t+bG4GSg53okhL2+e0XdKI6wm349Sszp57Sc9ID3
         oNsLMVxmhqN2NrW4AxKCFBkS/dlgFoNcD4KS9Sz5EnS6t51uiFqSSMKizdru+cNTPpUC
         o9ORIzaf39pSwtUiaX/VtmgLpyV2cqSQNuaeqDsMG1zJ/kW1I/o6eQJUw5DpSII1Mwji
         yOkg==
X-Gm-Message-State: APjAAAW0OgswABNfCHUGd8qw3/ZX6FmozLChRjB+LmjnHuuv3VlVTYsh
        18UyB+kr50URBJALf2I4vzOPYKXmHz8C6Y/ydD3vdA==
X-Google-Smtp-Source: APXvYqwXTe+zalUUafucq7Z++pdwadYJDLVeNDJV6Zv4Y+asgZgeSsVhybmr53RqnEI8Nop/g95ulyJQzoSjbIeSYB8=
X-Received: by 2002:a1c:b706:: with SMTP id h6mr4276899wmf.119.1562097459214;
 Tue, 02 Jul 2019 12:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190629112326.GA2366@localhost.localdomain>
In-Reply-To: <20190629112326.GA2366@localhost.localdomain>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 2 Jul 2019 21:57:24 +0200
Message-ID: <CAKv+Gu_T-YfsS2pQ202pEMFA+8CbVntTP8CbZTDXLpfaoRg-XQ@mail.gmail.com>
Subject: Re: [PATCH v0] Export Runtime Configuration Interface table to sysfs
To:     Narendra.K@dell.com
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Peter Jones <pjones@redhat.com>, Stuart.Hayes@dell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 29 Jun 2019 at 13:23, <Narendra.K@dell.com> wrote:
>
> From: Narendra K <Narendra.K@dell.com>
>
> System firmware advertises the address of the 'Runtime
> Configuration Interface table version 2 (RCI2)' via
> an EFI Configuration Table entry. This code retrieves the RCI2
> table from the address and exports it to sysfs as a binary
> attribute 'rci2' under /sys/firmware/efi/tables directory.
> The approach adopted is similar to the attribute 'DMI' under
> /sys/firmware/dmi/tables.
>
> RCI2 table contains BIOS HII in XML format and is used to populate
> BIOS setup page in Dell EMC OpenManage Server Administrator tool.
> The BIOS setup page contains BIOS tokens which can be configured.
>
> Signed-off-by: Narendra K <Narendra.K@dell.com>
> ---
> RFC -> v0:
>
> - Removed rci2 table from struct efi and defined it in rci2_table.c similar to
> the way uv_systab_phys is define in dmesg.
> - Removed the oem_tables array and added rci2 to common_tables array
> - Removed the string 'rci2' from the common_tables array so that it is
> not printed in dmesg.
> - Merged function 'efi_rci2_table_init' into 'efi_rci2_sysfs_init' function to
> avoid calling early_memremap/unmap functions.
>
> Also, a note unrelated to this patch - compilation error is observed when
> testing with make defconfig related to uv_systab_phys in
> arch/x86/platform/efi/efi.c. It seems like it needs to be protected with
> CONFIG_X86_UV in efi_tables array.
>

Yes, I noticed this as well. This has been fixed now

>
>  Documentation/ABI/testing/sysfs-firmware-efi |   8 +
>  arch/x86/platform/efi/efi.c                  |   1 +
>  drivers/firmware/efi/Makefile                |   2 +-
>  drivers/firmware/efi/efi.c                   |   4 +
>  drivers/firmware/efi/rci2_table.c            | 147 +++++++++++++++++++
>  include/linux/efi.h                          |   6 +
>  6 files changed, 167 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/firmware/efi/rci2_table.c
>
> diff --git a/Documentation/ABI/testing/sysfs-firmware-efi b/Documentation/ABI/testing/sysfs-firmware-efi
> index e794eac32a90..f7822c522a46 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-efi
> +++ b/Documentation/ABI/testing/sysfs-firmware-efi
> @@ -28,3 +28,11 @@ Description: Displays the physical addresses of all EFI Configuration
>                 versions are always printed first, i.e. ACPI20 comes
>                 before ACPI.
>  Users:         dmidecode
> +
> +What:          /sys/firmware/efi/tables/rci2
> +Date:          June 2019
> +Contact:       Narendra K <Narendra.K@dell.com>, linux-bugs@dell.com
> +Description:   Displays the content of the Runtime Configuration Interface
> +               Table version 2 on Dell EMC PowerEdge systems in binary format
> +Users:         It is used by Dell EMC OpenManage Server Administrator tool to
> +               populate BIOS setup page.
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 002078645969..6e1c1b0ce015 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -80,6 +80,7 @@ static const unsigned long * const efi_tables[] = {
>         &efi.esrt,
>         &efi.properties_table,
>         &efi.mem_attr_table,
> +       &rci2_table_phys,

Put #ifdef CONFIG_EFI_RCI2 around this line ^^^

>  };
>
>  u64 efi_setup;         /* efi setup_data physical address */
> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> index d2d0d2030620..db07828ca1ed 100644
> --- a/drivers/firmware/efi/Makefile
> +++ b/drivers/firmware/efi/Makefile
> @@ -11,7 +11,7 @@
>  KASAN_SANITIZE_runtime-wrappers.o      := n
>
>  obj-$(CONFIG_ACPI_BGRT)                += efi-bgrt.o
> -obj-$(CONFIG_EFI)                      += efi.o vars.o reboot.o memattr.o tpm.o
> +obj-$(CONFIG_EFI)                      += efi.o vars.o reboot.o memattr.o tpm.o rci2_table.o

Please introduce a kconfig symbol CONFIG_EFI_RCI2 for this, and only
include this file when the symbol is set. You can make it default to y
on X86, but for other architectures, it does not make a lot of sense
to include this by default.

>  obj-$(CONFIG_EFI)                      += capsule.o memmap.o
>  obj-$(CONFIG_EFI_VARS)                 += efivars.o
>  obj-$(CONFIG_EFI_ESRT)                 += esrt.o
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index d082d5b2fb84..429c676f53fb 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -363,6 +363,9 @@ static int __init efisubsys_init(void)
>                 goto err_remove_group;
>         }
>
> +       if (efi_rci2_sysfs_init() != 0)
> +               pr_debug("efi rci2: sysfs attribute creation under /sys/firmware/efi/ failed");
> +

Please drop this. You can use a late_initcall() in rci2_table.c instead

>         return 0;
>
>  err_remove_group:
> @@ -463,6 +466,7 @@ static __initdata efi_config_table_type_t common_tables[] = {
>         {LINUX_EFI_RANDOM_SEED_TABLE_GUID, "RNG", &efi.rng_seed},
>         {LINUX_EFI_TPM_EVENT_LOG_GUID, "TPMEventLog", &efi.tpm_log},
>         {LINUX_EFI_MEMRESERVE_TABLE_GUID, "MEMRESERVE", &efi.mem_reserve},
> +       {DELLEMC_EFI_RCI2_TABLE_GUID, NULL, &rci2_table_phys},

Put #ifdef CONFIG_EFI_RCI2 around this line ^^^

>         {NULL_GUID, NULL, NULL},
>  };
>
> diff --git a/drivers/firmware/efi/rci2_table.c b/drivers/firmware/efi/rci2_table.c
> new file mode 100644
> index 000000000000..796b93bb5e93
> --- /dev/null
> +++ b/drivers/firmware/efi/rci2_table.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Export Runtime Configuration Interface Table Version 2 (RCI2)
> + * to sysfs
> + *
> + * Copyright (C) 2019 Dell Inc
> + * by Narendra K <Narendra.K@dell.com>
> + *
> + * System firmware advertises the address of the RCI2 Table via
> + * an EFI Configuration Table entry. This code retrieves the RCI2
> + * table from the address and exports it to sysfs as a binary
> + * attribute 'rci2' under /sys/firmware/efi/tables directory.
> + */
> +
> +#include <linux/kobject.h>
> +#include <linux/device.h>
> +#include <linux/sysfs.h>
> +#include <linux/efi.h>
> +#include <linux/types.h>
> +#include <linux/io.h>
> +
> +#define RCI_SIGNATURE  "_RC_"
> +
> +struct rci2_table_global_hdr {
> +       u16 type;
> +       u16 resvd0;
> +       u16 hdr_len;
> +       u8 rci2_sig[4];
> +       u16 resvd1;
> +       u32 resvd2;
> +       u32 resvd3;
> +       u8 major_rev;
> +       u8 minor_rev;
> +       u16 num_of_structs;
> +       u32 rci2_len;
> +       u16 rci2_chksum;
> +} __packed;
> +
> +static u8 *rci2_base;
> +static u32 rci2_table_len;
> +unsigned long rci2_table_phys __ro_after_init = EFI_INVALID_TABLE_ADDR;
> +
> +static ssize_t raw_table_read(struct file *file, struct kobject *kobj,
> +                             struct bin_attribute *attr, char *buf,
> +                             loff_t pos, size_t count)
> +{
> +       memcpy(buf, attr->private + pos, count);
> +       return count;
> +}
> +
> +static BIN_ATTR(rci2, S_IRUSR, raw_table_read, NULL, 0);
> +
> +static u16 checksum(void)
> +{
> +       u8 len_is_odd = rci2_table_len % 2;
> +       u32 chksum_len = rci2_table_len;
> +       u16 *base = (u16 *)rci2_base;
> +       u8 buf[2] = {0};
> +       u32 offset = 0;
> +       u16 chksum = 0;
> +
> +       if (len_is_odd)
> +               chksum_len -= 1;
> +
> +       while (offset < chksum_len) {
> +               chksum += *base;
> +               offset += 2;
> +               base++;
> +       }
> +
> +       if (len_is_odd) {
> +               buf[0] = *(u8 *)base;
> +               chksum += *(u16 *)(buf);
> +       }
> +
> +       return chksum;
> +}
> +
> +int __init efi_rci2_sysfs_init(void)
> +{
> +
> +       struct kobject *tables_kobj;
> +       int ret = -ENOMEM;
> +
> +       rci2_base = memremap(rci2_table_phys,
> +                            sizeof(struct rci2_table_global_hdr),
> +                            MEMREMAP_WB);
> +       if (!rci2_base) {
> +               pr_debug("RCI2 table init failed - could not map RCI2 table\n");
> +               goto err;
> +       }
> +
> +       if (strncmp(rci2_base +
> +                   offsetof(struct rci2_table_global_hdr, rci2_sig),
> +                   RCI_SIGNATURE, 4)) {
> +               pr_debug("RCI2 table init failed - incorrect signature\n");
> +               ret = -ENODEV;
> +               goto err_unmap;
> +       }
> +
> +       rci2_table_len = *(u32 *)(rci2_base +
> +                                 offsetof(struct rci2_table_global_hdr,
> +                                 rci2_len));
> +
> +       memunmap(rci2_base);
> +
> +       if (!rci2_table_len) {
> +               pr_debug("RCI2 table init failed - incorrect table length\n");
> +               goto err;
> +       }
> +
> +       rci2_base = memremap(rci2_table_phys, rci2_table_len, MEMREMAP_WB);
> +       if (!rci2_base) {
> +               pr_debug("RCI2 table - could not map RCI2 table\n");
> +               goto err;
> +       }
> +
> +       if (checksum() != 0) {
> +               pr_debug("RCI2 table - incorrect checksum\n");
> +               ret = -ENODEV;
> +               goto err_unmap;
> +       }
> +
> +       tables_kobj = kobject_create_and_add("tables", efi_kobj);
> +       if (!tables_kobj) {
> +               pr_debug("RCI2 table - tables_kobj creation failed\n");
> +               goto err_unmap;
> +       }
> +
> +       bin_attr_rci2.size = rci2_table_len;
> +       bin_attr_rci2.private = rci2_base;
> +       ret = sysfs_create_bin_file(tables_kobj, &bin_attr_rci2);
> +       if (ret != 0) {
> +               pr_debug("RCI2 table - rci2 sysfs bin file creation failed\n");
> +               kobject_del(tables_kobj);
> +               kobject_put(tables_kobj);
> +               goto err_unmap;
> +       }
> +
> +       return 0;
> +
> + err_unmap:
> +       memunmap(rci2_base);
> + err:
> +       pr_debug("RCI2 table - sysfs initialization failed\n");
> +       return ret;
> +}
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index ac48db107214..ef74c7ec75bb 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -691,6 +691,9 @@ void efi_native_runtime_setup(void);
>  #define LINUX_EFI_TPM_EVENT_LOG_GUID           EFI_GUID(0xb7799cb0, 0xeca2, 0x4943,  0x96, 0x67, 0x1f, 0xae, 0x07, 0xb7, 0x47, 0xfa)
>  #define LINUX_EFI_MEMRESERVE_TABLE_GUID                EFI_GUID(0x888eb0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
>
> +/* OEM GUIDs */
> +#define DELLEMC_EFI_RCI2_TABLE_GUID            EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
> +
>  typedef struct {
>         efi_guid_t guid;
>         u64 table;
> @@ -1703,6 +1706,9 @@ struct linux_efi_tpm_eventlog {
>
>  extern int efi_tpm_eventlog_init(void);
>
> +extern unsigned long rci2_table_phys;
> +extern int efi_rci2_sysfs_init(void);

Drop this declaration as well.

> +
>  /*
>   * efi_runtime_service() function identifiers.
>   * "NONE" is used by efi_recover_from_page_fault() to check if the page
> --
> 2.18.1
>
> --
> With regards,
> Narendra K
