Return-Path: <linux-efi+bounces-4192-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93970AFCB63
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 15:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE0D179E2D
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 13:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5222DCC1B;
	Tue,  8 Jul 2025 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRBoa4DV"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812DE26B08F;
	Tue,  8 Jul 2025 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980027; cv=none; b=dEE8tqLmVC9utPVsI7z59cryJ8fCdP9tJjm+Ha2WJ57E87HZXqrMvG1MZEnqfNFgrXeabbENIkkwywOu2tSHnJhyewiAAhgPSfK8lL73LWA2o8DQKCopNEk9AtUfvknFQrDOUhCvhEGK2otOtvGg9CTMRKyr9GPy+PhEtWEaBkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980027; c=relaxed/simple;
	bh=qjHSjSZpG0XgrFa9GwoBXtP4tEd6WDJUqjQ71FzFAV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBQlwaHzIX7B7Md3Kt9qVYiM1e7C4Xk5Lf55l3MRzgFkVgnzGDi037W0bUK4Lk9uiTNOE46kIKuONyDZCOv7imXmCyPbh1sFDoDCESr9byeI5VK0YmnNs0S5SRksK6JdHxg8M9LJZE1Pw86qYHFZy3DqIxjYjaLmEozMGKg2EqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRBoa4DV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5C4C4CEED;
	Tue,  8 Jul 2025 13:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751980027;
	bh=qjHSjSZpG0XgrFa9GwoBXtP4tEd6WDJUqjQ71FzFAV0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jRBoa4DVOg2i14uDh0yhmomk0xBCac7n9DDKGSHh7nAwbc0Zv2Q1PrLsI5TzIb0SR
	 f7G7XjmfdmxfozQXjwTb/NKsIq66um+EtkJlqT+D4kMR1Q/eZ32I4lIpdq4Ufr5/Dd
	 DAgPwyFIQfod0/jBpQQ1dQOGrQ+S+cObSdQ2lVWZO5yjb8TCo5pJFbW8zOFrxdrXLB
	 wfnuRz4rNe+yfnK0DifLXCdX+UCBsMR9wB4rhjt/KXiUeIgU2kNseu1VZm8f8clcMd
	 X8bqGzd5827jHt965r0zyz5KRc91hM/rfIW9/IYinn224ZVh5Ecz2+tTVPRSrB3Hkd
	 kasGxEPHKIycw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-555024588a8so4153848e87.0;
        Tue, 08 Jul 2025 06:07:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWf0V9sAJdxpdRg5gz5dzN79mIKo2GfAhGQFyJR8lypPB/UxhaRqB6AKET0Uq4Uy5M2baNwCXlTRZW0Z+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyouOeRQYIiW0kQ6dKouUQlN3/0IUn1k2SYj3ixtYcPHS/1bo9v
	kxpqbqU3g3BpUC0DXq3f/Edk+NUPG5snJMgyxdebKHFT4kfgxpleTSHRNhqtD0z21CaaJc2s4Fb
	PmCARb9LxXRZuXhCIZ4yBa54dHqkfJng=
X-Google-Smtp-Source: AGHT+IFjk/sBnLxfc0iWR7GPZGWkE/ngpAY6qKbaruKSn6p6LpdMKl4PxFHLnqyKMYOIDCScqjWgqqVgQ1/YnX9riyA=
X-Received: by 2002:a05:6512:3186:b0:553:a30b:ee0a with SMTP id
 2adb3069b0e04-557a1dcaf60mr4922746e87.24.1751980025283; Tue, 08 Jul 2025
 06:07:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708125624.734132-1-kraxel@redhat.com>
In-Reply-To: <20250708125624.734132-1-kraxel@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 8 Jul 2025 23:06:52 +1000
X-Gmail-Original-Message-ID: <CAMj1kXHd6__0Hcu1UyK+1obsK3bNsQh=1uBVWoaNsX1iTLx6CA@mail.gmail.com>
X-Gm-Features: Ac12FXzcV00tX7zwjLMQ47psM0w_bZGkrVozxYKvYGTupnmiZzxKZycvfJ2RwpU
Message-ID: <CAMj1kXHd6__0Hcu1UyK+1obsK3bNsQh=1uBVWoaNsX1iTLx6CA@mail.gmail.com>
Subject: Re: [PATCH v2] efi: add ovmf debug log driver
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-efi@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Jul 2025 at 22:56, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Recent OVMF versions (edk2-stable202508 + newer) can write their debug
> log to a memory buffer.  This driver exposes the log content via sysfs
> (/sys/firmware/efi/ovmf_debug_log).
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/linux/efi.h                   |   2 +
>  drivers/firmware/efi/efi.c            |   8 ++
>  drivers/firmware/efi/ovmf-debug-log.c | 136 ++++++++++++++++++++++++++
>  drivers/firmware/efi/Kconfig          |   8 ++
>  drivers/firmware/efi/Makefile         |   1 +
>  5 files changed, 155 insertions(+)
>  create mode 100644 drivers/firmware/efi/ovmf-debug-log.c
>

Thanks, I've queued this up now.


> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 7d63d1d75f22..a71830608422 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -439,6 +439,7 @@ void efi_native_runtime_setup(void);
>
>  /* OVMF protocol GUIDs */
>  #define OVMF_SEV_MEMORY_ACCEPTANCE_PROTOCOL_GUID       EFI_GUID(0xc5a010fe, 0x38a7, 0x4531,  0x8a, 0x4a, 0x05, 0x00, 0xd2, 0xfd, 0x16, 0x49)
> +#define OVMF_MEMORY_LOG_TABLE_GUID             EFI_GUID(0x95305139, 0xb20f, 0x4723, 0x84, 0x25, 0x62, 0x7c, 0x88, 0x8f, 0xf1, 0x21)
>
>  typedef struct {
>         efi_guid_t guid;
> @@ -642,6 +643,7 @@ extern struct efi {
>         unsigned long                   esrt;                   /* ESRT table */
>         unsigned long                   tpm_log;                /* TPM2 Event Log table */
>         unsigned long                   tpm_final_log;          /* TPM2 Final Events Log table */
> +       unsigned long                   ovmf_debug_log;
>         unsigned long                   mokvar_table;           /* MOK variable config table */
>         unsigned long                   coco_secret;            /* Confidential computing secret table */
>         unsigned long                   unaccepted;             /* Unaccepted memory table */
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index e57bff702b5f..3161f918ce53 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -45,6 +45,7 @@ struct efi __read_mostly efi = {
>         .esrt                   = EFI_INVALID_TABLE_ADDR,
>         .tpm_log                = EFI_INVALID_TABLE_ADDR,
>         .tpm_final_log          = EFI_INVALID_TABLE_ADDR,
> +       .ovmf_debug_log         = EFI_INVALID_TABLE_ADDR,
>  #ifdef CONFIG_LOAD_UEFI_KEYS
>         .mokvar_table           = EFI_INVALID_TABLE_ADDR,
>  #endif
> @@ -473,6 +474,10 @@ static int __init efisubsys_init(void)
>                 platform_device_register_simple("efi_secret", 0, NULL, 0);
>  #endif
>
> +       if (IS_ENABLED(CONFIG_OVMF_DEBUG_LOG) &&
> +           efi.ovmf_debug_log != EFI_INVALID_TABLE_ADDR)
> +               platform_device_register_simple("ovmf_debug_log", 0, NULL, 0);
> +
>         return 0;
>
>  err_remove_group:
> @@ -617,6 +622,9 @@ static const efi_config_table_type_t common_tables[] __initconst = {
>         {LINUX_EFI_MEMRESERVE_TABLE_GUID,       &mem_reserve,           "MEMRESERVE"    },
>         {LINUX_EFI_INITRD_MEDIA_GUID,           &initrd,                "INITRD"        },
>         {EFI_RT_PROPERTIES_TABLE_GUID,          &rt_prop,               "RTPROP"        },
> +#ifdef CONFIG_OVMF_DEBUG_LOG
> +       {OVMF_MEMORY_LOG_TABLE_GUID,            &efi.ovmf_debug_log,    "OvmfDebugLog"  },
> +#endif
>  #ifdef CONFIG_EFI_RCI2_TABLE
>         {DELLEMC_EFI_RCI2_TABLE_GUID,           &rci2_table_phys                        },
>  #endif
> diff --git a/drivers/firmware/efi/ovmf-debug-log.c b/drivers/firmware/efi/ovmf-debug-log.c
> new file mode 100644
> index 000000000000..d4fec178fa9f
> --- /dev/null
> +++ b/drivers/firmware/efi/ovmf-debug-log.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/efi.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/kobject.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/sysfs.h>
> +
> +#define OVMF_DEBUG_LOG_MAGIC1  0x3167646d666d766f  // "ovmfmdg1"
> +#define OVMF_DEBUG_LOG_MAGIC2  0x3267646d666d766f  // "ovmfmdg2"
> +
> +struct ovmf_debug_log_header {
> +       u64    magic1;
> +       u64    magic2;
> +       u64    hdr_size;
> +       u64    log_size;
> +       u64    lock; // edk2 spinlock
> +       u64    head_off;
> +       u64    tail_off;
> +       u64    truncated;
> +       u8     fw_version[128];
> +};
> +
> +static struct ovmf_debug_log_header *hdr;
> +static u8 *logbuf;
> +static u64 logbufsize;
> +
> +static ssize_t ovmf_log_read(struct file *filp, struct kobject *kobj,
> +                            const struct bin_attribute *attr, char *buf,
> +                            loff_t offset, size_t count)
> +{
> +       u64 start, end;
> +
> +       start = hdr->head_off + offset;
> +       if (hdr->head_off > hdr->tail_off && start >= hdr->log_size)
> +               start -= hdr->log_size;
> +
> +       end = start + count;
> +       if (start > hdr->tail_off) {
> +               if (end > hdr->log_size)
> +                       end = hdr->log_size;
> +       } else {
> +               if (end > hdr->tail_off)
> +                       end = hdr->tail_off;
> +       }
> +
> +       if (start > logbufsize || end > logbufsize)
> +               return 0;
> +       if (start >= end)
> +               return 0;
> +
> +       memcpy(buf, logbuf + start, end - start);
> +       return end - start;
> +}
> +
> +static struct bin_attribute ovmf_log_bin_attr = {
> +       .attr = {
> +               .name = "ovmf_debug_log",
> +               .mode = 0444,
> +       },
> +       .read = ovmf_log_read,
> +};
> +
> +static int ovmf_log_probe(struct platform_device *dev)
> +{
> +       u64 size;
> +       int ret = -EINVAL;
> +
> +       if (efi.ovmf_debug_log == EFI_INVALID_TABLE_ADDR) {
> +               dev_err(&dev->dev, "OVMF debug log: not available\n");
> +               return -EINVAL;
> +       }
> +
> +       /* map + verify header */
> +       hdr = memremap(efi.ovmf_debug_log, sizeof(*hdr), MEMREMAP_WB);
> +       if (!hdr) {
> +               dev_err(&dev->dev, "OVMF debug log: header map failed\n");
> +               return -EINVAL;
> +       }
> +
> +       if (hdr->magic1 != OVMF_DEBUG_LOG_MAGIC1 ||
> +           hdr->magic2 != OVMF_DEBUG_LOG_MAGIC2) {
> +               dev_err(&dev->dev, "OVMF debug log: magic mismatch\n");
> +               goto err_unmap;
> +       }
> +
> +       size = hdr->hdr_size + hdr->log_size;
> +       dev_info(&dev->dev, "firmware version: \"%s\"\n", hdr->fw_version);
> +       dev_info(&dev->dev, "log buffer size: %lluk\n", size / 1024);
> +
> +       /* map complete log buffer */
> +       memunmap(hdr);
> +       hdr = memremap(efi.ovmf_debug_log, size, MEMREMAP_WB);
> +       if (!hdr) {
> +               dev_err(&dev->dev, "OVMF debug log: buffer map failed\n");
> +               return -EINVAL;
> +       }
> +       logbuf = (void *)hdr + hdr->hdr_size;
> +       logbufsize = hdr->log_size;
> +
> +       ovmf_log_bin_attr.size = size;
> +       ret = sysfs_create_bin_file(efi_kobj, &ovmf_log_bin_attr);
> +       if (ret != 0) {
> +               dev_err(&dev->dev, "OVMF debug log: sysfs register failed\n");
> +               goto err_unmap;
> +       }
> +
> +       return 0;
> +
> +err_unmap:
> +       memunmap(hdr);
> +       return ret;
> +}
> +
> +static void ovmf_log_remove(struct platform_device *dev)
> +{
> +       memunmap(hdr);
> +}
> +
> +static struct platform_driver ovmf_log_driver = {
> +       .probe = ovmf_log_probe,
> +       .remove = ovmf_log_remove,
> +       .driver = {
> +               .name = "ovmf_debug_log",
> +       },
> +};
> +
> +module_platform_driver(ovmf_log_driver);
> +
> +MODULE_DESCRIPTION("OVMF debug log");
> +MODULE_AUTHOR("Gerd Hoffmann <kraxel@redhat.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:ovmf_debug_log");
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index db8c5c03d3a2..ac0a03ec3452 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -263,6 +263,14 @@ config EFI_COCO_SECRET
>           virt/coco/efi_secret module to access the secrets, which in turn
>           allows userspace programs to access the injected secrets.
>
> +config OVMF_DEBUG_LOG
> +       tristate "Expose OVMF firmware debug log via sysfs"
> +       depends on EFI
> +       help
> +         Recent OVMF versions (edk2-stable202508 + newer) can write
> +         their debug log to a memory buffer.  This driver exposes the
> +         log content via sysfs (/sys/firmware/efi/ovmf_debug_log).
> +
>  config UNACCEPTED_MEMORY
>         bool
>         depends on EFI_STUB
> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> index a2d0009560d0..8efbcf699e4f 100644
> --- a/drivers/firmware/efi/Makefile
> +++ b/drivers/firmware/efi/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_APPLE_PROPERTIES)                += apple-properties.o
>  obj-$(CONFIG_EFI_RCI2_TABLE)           += rci2-table.o
>  obj-$(CONFIG_EFI_EMBEDDED_FIRMWARE)    += embedded-firmware.o
>  obj-$(CONFIG_LOAD_UEFI_KEYS)           += mokvar-table.o
> +obj-$(CONFIG_OVMF_DEBUG_LOG)           += ovmf-debug-log.o
>
>  obj-$(CONFIG_SYSFB)                    += sysfb_efi.o
>
> --
> 2.50.0
>
>

