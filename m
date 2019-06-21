Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 194C54ED2E
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2019 18:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfFUQfz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Jun 2019 12:35:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34562 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfFUQfz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Jun 2019 12:35:55 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so1522724iot.1
        for <linux-efi@vger.kernel.org>; Fri, 21 Jun 2019 09:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dKTdCuCSP8V6GjPTIJsjMOpgEE5NubnrBrZpsS7QJzY=;
        b=Dao2cGd5O0woBujoW5lCzz2CfHoEbsVlklU705XKbgJB25dB3YHUB8JqsC+ZtmrSiv
         ZVZVO3nJYa8HlQTag5mjy/KWqCz56vcDO/9KNtamNzkfBAR3X1CWrIRxjTuJYc8EuPov
         7hhnd5CFfDFmKb72mEiBmrrqcDcyIKF1IcdZxOFWAietdUmePjEgEsEULrXzckYSTy19
         2YB9adk4/wQM5gJBvTdgjpTv3gctQXGA7sOUft/T2AMDpgjZ4DWIGOvgJ2vHe382lnMY
         MI9XhItxIqQ1w/Gz4daumzkiVMEEh3IWlcEGWnsu6xuEJj4HoGThPMwlatl4u/vWAG14
         gYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dKTdCuCSP8V6GjPTIJsjMOpgEE5NubnrBrZpsS7QJzY=;
        b=QCAklKz98JOpfYOyXqp3SfHE1aZP53EnVQvDcuQKEcSH+tCwiVbzzg0JNEvNY1bXgy
         9PNtf1VGQVe9XjXaorOj3KghNHUoDuKErzukdKspTLOazQ/nWrmrGqrtYh+O284cyhh9
         BGlHpA4vLpw/EmOgh5E6Ix8IPMxkrzBZrt7eV8zbmmf6+KO/3EYRnJ+Y8rJj8hKa+kUL
         PMVhDH8B8J3uKU/896mqoTf4Ra9fCB8o7IApYTTgsNqQHiHLeQ9bcUleFspZst5rJK1+
         Mb7n3ayWxhZAYpB5/uxSplZqycHU+xfbS75PgS2m8e0qYMQnqYS/gKWEMowv7AHUxUpX
         cnIw==
X-Gm-Message-State: APjAAAWoheeAsUmqd7aIh3I1QsI+LFV90h81YLh4NzLFBRaBzClH/6Mn
        icYxEhtbxEMVo0YyaR4vsg1Mp3u7rQ+Up/C3VVjAfw==
X-Google-Smtp-Source: APXvYqz0sr4TTsK82haHRje57QEhNee1Tn+Nt/pKidLQSueIPeI3hrWEXUcZ6ib3b40tir6ihdFufjFff0spqPRurIU=
X-Received: by 2002:a6b:7312:: with SMTP id e18mr151594ioh.156.1561134953469;
 Fri, 21 Jun 2019 09:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190617101134.GA2242@localhost.localdomain>
In-Reply-To: <20190617101134.GA2242@localhost.localdomain>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 21 Jun 2019 18:35:42 +0200
Message-ID: <CAKv+Gu_MYJ=EWOphS=dBG8PJqPjG21J9SGrynD2r60SOemttUA@mail.gmail.com>
Subject: Re: [RFC PATCH] Export Runtime Configuration Interface table to sysfs
To:     Narendra.K@dell.com, Peter Jones <pjones@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(+ Peter)

On Mon, 17 Jun 2019 at 12:11, <Narendra.K@dell.com> wrote:
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
> Hi, the patch is created on kernel version 5.2-rc4. It applies to
> 5.2-rc5 also. If the approach looks correct, I will resubmit with RFC
> tag removed.
>

Unfortunately, we cannot implement a  generic interface for dumping
config tables, since there is no generic method to record the length.
So I don't have any problems with doing it this way.

I do have some comments, though.

First of all, do you know which memory type is used for this table? (more below)


>  Documentation/ABI/testing/sysfs-firmware-efi |   9 ++
>  drivers/firmware/efi/Makefile                |   2 +-
>  drivers/firmware/efi/efi.c                   |  20 ++-
>  drivers/firmware/efi/rci2_table.c            | 148 +++++++++++++++++++
>  include/linux/efi.h                          |   7 +
>  5 files changed, 184 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/firmware/efi/rci2_table.c
>
> diff --git a/Documentation/ABI/testing/sysfs-firmware-efi b/Documentation/ABI/testing/sysfs-firmware-efi
> index e794eac32a90..cb887b5e10cb 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-efi
> +++ b/Documentation/ABI/testing/sysfs-firmware-efi
> @@ -28,3 +28,12 @@ Description: Displays the physical addresses of all EFI Configuration
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
> +
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
>  obj-$(CONFIG_EFI)                      += capsule.o memmap.o
>  obj-$(CONFIG_EFI_VARS)                 += efivars.o
>  obj-$(CONFIG_EFI_ESRT)                 += esrt.o
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 16b2137d117c..2fe114ff8149 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -53,6 +53,7 @@ struct efi __read_mostly efi = {
>         .rng_seed               = EFI_INVALID_TABLE_ADDR,
>         .tpm_log                = EFI_INVALID_TABLE_ADDR,
>         .mem_reserve            = EFI_INVALID_TABLE_ADDR,
> +       .rci2                   = EFI_INVALID_TABLE_ADDR,

Does this really need to live in the efi struct?

>  };
>  EXPORT_SYMBOL(efi);
>
> @@ -73,6 +74,7 @@ static unsigned long *efi_tables[] = {
>         &efi.esrt,
>         &efi.properties_table,
>         &efi.mem_attr_table,
> +       &efi.rci2,
>  };
>

AFAICT, this table is only used by memremap_is_efi_data() to decide
whether a page should be map as unencrypted, and if the address is in
boot services data or runtime services data, the test will already
success, regardless of whether it appears in this enumeration.

>  struct mm_struct efi_mm = {
> @@ -384,6 +386,9 @@ static int __init efisubsys_init(void)
>                 goto err_remove_group;
>         }
>
> +       if (efi_rci2_sysfs_init() != 0)
> +               pr_debug("efi rci2: sysfs attribute creation under /sys/firmware/efi/ failed");
> +
>         return 0;
>
>  err_remove_group:
> @@ -488,6 +493,12 @@ static __initdata efi_config_table_type_t common_tables[] = {
>         {NULL_GUID, NULL, NULL},
>  };
>
> +/* OEM Tables */
> +static __initdata efi_config_table_type_t oem_tables[] = {
> +       {DELLEMC_EFI_RCI2_TABLE_GUID, "RCI2", &efi.rci2},

Please drop the string. We don't have to print the presence of this
table in the bootlog since it has no significance to the OS itself.

> +       {NULL_GUID, NULL, NULL},
> +};
> +

Do we really need a separate oem_tables[] array?

>  static __init int match_config_table(efi_guid_t *guid,
>                                      unsigned long table,
>                                      efi_config_table_type_t *table_types)
> @@ -538,8 +549,10 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
>                         table = ((efi_config_table_32_t *)tablep)->table;
>                 }
>
> -               if (!match_config_table(&guid, table, common_tables))
> +               if (!match_config_table(&guid, table, common_tables)) {
>                         match_config_table(&guid, table, arch_tables);
> +                       match_config_table(&guid, table, oem_tables);
> +               }
>
>                 tablep += sz;
>         }
> @@ -627,6 +640,11 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
>                 }
>         }
>
> +       if (efi.rci2 != EFI_INVALID_TABLE_ADDR)
> +               efi_rci2_table_init();
> +       else
> +               pr_debug("EFI RCI2 table address not found\n");
> +
>         return 0;
>  }
>
> diff --git a/drivers/firmware/efi/rci2_table.c b/drivers/firmware/efi/rci2_table.c
> new file mode 100644
> index 000000000000..b18354d5b81e
> --- /dev/null
> +++ b/drivers/firmware/efi/rci2_table.c
> @@ -0,0 +1,148 @@
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
> +
> +int __init efi_rci2_table_init(void)
> +{
> +       rci2_base = early_memremap(efi.rci2,
> +                                  sizeof(struct rci2_table_global_hdr));
> +       if (!rci2_base) {
> +               pr_debug("RCI2 table init failed - could not map RCI2 table\n");
> +               return -ENOMEM;
> +       }
> +

Do we really need to do this early? And is it guaranteed that the
memory will not be given to the OS for general allocation?


> +       if (strncmp(rci2_base +
> +                   offsetof(struct rci2_table_global_hdr, rci2_sig),
> +                   RCI_SIGNATURE, 4)) {
> +               memunmap(rci2_base);
> +               pr_debug("RCI2 table init failed - incorrect signature\n");
> +               return -ENODEV;
> +       }
> +
> +       rci2_table_len = *(u32 *)(rci2_base +
> +                                 offsetof(struct rci2_table_global_hdr,
> +                                 rci2_len));
> +
> +       early_memunmap(rci2_base, sizeof(struct rci2_table_global_hdr));
> +
> +       return 0;
> +}
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

What is this random checksum function? Which algorithm does it
implement, and did you check whether we already have a library
function for it?


> +int __init efi_rci2_sysfs_init(void)
> +{
> +
> +       struct kobject *tables_kobj;
> +       int ret = -ENOMEM;
> +
> +       if (!rci2_table_len)
> +               goto err;
> +
> +       rci2_base = memremap(efi.rci2, rci2_table_len, MEMREMAP_WB);
> +       if (!rci2_base) {
> +               pr_debug("RCI2 table - could not map RCI2 table\n");
> +               return -ENOMEM;
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
> index 6ebc2098cfe1..3a3f37ee5c48 100644
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
> @@ -997,6 +1000,7 @@ extern struct efi {
>         unsigned long rng_seed;         /* UEFI firmware random seed */
>         unsigned long tpm_log;          /* TPM2 Event Log table */
>         unsigned long mem_reserve;      /* Linux EFI memreserve table */
> +       unsigned long rci2;             /* Dell EMC EFI RCI2 Table */
>         efi_get_time_t *get_time;
>         efi_set_time_t *set_time;
>         efi_get_wakeup_time_t *get_wakeup_time;
> @@ -1712,6 +1716,9 @@ struct linux_efi_tpm_eventlog {
>
>  extern int efi_tpm_eventlog_init(void);
>
> +extern int efi_rci2_table_init(void);
> +extern int efi_rci2_sysfs_init(void);
> +
>  /*
>   * efi_runtime_service() function identifiers.
>   * "NONE" is used by efi_recover_from_page_fault() to check if the page
> --
> 2.18.1
>
> With regards,
> Narendra K
