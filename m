Return-Path: <linux-efi+bounces-4189-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6B2AFCA1D
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 14:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 415A53A8F1F
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 12:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B016C2DA774;
	Tue,  8 Jul 2025 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6rJ0n2D"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F492D97A0;
	Tue,  8 Jul 2025 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976609; cv=none; b=sMcyh0MOJJiOx4IzN240OKJNrI0XrQDzrEa9aCNRxm2SNT6QUzcJNhh5lgbgVTaG4Y2MDw3WYAX7JfoGflG3lkAMQtKwxGPK4V3753KzeXnpeHVadZPjVRIW9x6f8a3cCHxg68+3vaIZ9KG/m9LToucWq6T2JF0lnGZoPBozWNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976609; c=relaxed/simple;
	bh=4D3e58+fDv4wnL0mp2ESwrJPKCLUyhnwLJUlNrL3WYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XlJexVb1T0GhNc6kBRJpaJtm+iJHUv6Uj4EKw0oznHb9w5hzHrqOdGSzThXGRIXawicrFragn6GUAr6tg91ZLy8S8HryjeUkUVIODD01otzU/eQUXUzY4PD3c8BvRk7UzSvE46OqkbUs1ZIODCJnUOs5L6/AYtyy6r05UYl0oRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6rJ0n2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB82FC4CEED;
	Tue,  8 Jul 2025 12:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751976609;
	bh=4D3e58+fDv4wnL0mp2ESwrJPKCLUyhnwLJUlNrL3WYA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k6rJ0n2Dk+sMpYJI78QqSEUU3+uUlsMBqtUaXFRdL2BmtHHhBXzuUAKvVCeCa4LIZ
	 /QDY6RFjRSToFvLKREyybxLMMezwv148Z6fIgV9SdtPvDH/9ZKVTbosmrkG4k2KXje
	 vNUlwAzt/OGsCvaWR8USqZJ/H8s26bM/1WuoRnOR5wRGOy5kpZtpapX9TbTBF1qNNx
	 o3DIc3TnNUyohOUzTKctq3JGlp++lXrTQaiOEwvxl3EsMhsyLvar5aRpmJovdb++po
	 iisl8ruI4epj+gbbfdd+5QcCJ0Z2GbYfUUWLhVcJhryoXI86za3QpxrkGLsgd0YfO2
	 sxPcsHnVUIjjg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32cd499007aso32026141fa.0;
        Tue, 08 Jul 2025 05:10:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXfLBFM5vXI75VjHq4Vc1e8kDSR59wqEpuDa7K4jv8p1NhCPbthVjtRo/XA8TNMf9RWGwrPvrOPi8kQsVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyek52L5AQoH74HgDFHiT/T/6GACQY+OUXvm5Gf+xf3LPcDknc5
	JtjmHXRUR9704r7wW1aHJ5X7rWi10sLkHOsY+IY0Lr89KKUzUQMnVLTvMmJ+kWoSj4kMvaHcD7X
	bheRooSv/UvheDI9npLJBoB+0gJbq4EQ=
X-Google-Smtp-Source: AGHT+IEpUTDRMnnqyxhAvvmWjcjCikmkzw4A/TXPHGaC6LVQ7BUpFBXytfDiRzUu7iWKv9L+8MfXJm4Q73VbvMwqON4=
X-Received: by 2002:a2e:b80f:0:b0:32b:719f:1260 with SMTP id
 38308e7fff4ca-32f39aa91f6mr7366821fa.9.1751976607238; Tue, 08 Jul 2025
 05:10:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708105559.603425-1-kraxel@redhat.com>
In-Reply-To: <20250708105559.603425-1-kraxel@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 8 Jul 2025 22:09:55 +1000
X-Gmail-Original-Message-ID: <CAMj1kXEvVT6BCOPuGRL8_v15c92-wzvp5wGBuh7pB6EYnhB4vg@mail.gmail.com>
X-Gm-Features: Ac12FXxNpj2y0l_V1h8-6pyTTP5yz8BJIAx2zn36NfLzkzIowlxRv1a5bSnzAZw
Message-ID: <CAMj1kXEvVT6BCOPuGRL8_v15c92-wzvp5wGBuh7pB6EYnhB4vg@mail.gmail.com>
Subject: Re: [PATCH] efi: add ovmf debug log driver
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-efi@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Thanks for providing implementations for both sides of this interface


On Tue, 8 Jul 2025 at 20:56, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Recent OVMF versions (edk2-stable202508 + newer) can write their debug
> log to a memory buffer.  This driver exposes the log content via sysfs
> (/sys/firmware/efi/ovmf_debug_log).
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/linux/efi.h             |   2 +
>  drivers/firmware/efi/efi.c      |  11 +++
>  drivers/firmware/efi/ovmf-log.c | 136 ++++++++++++++++++++++++++++++++
>  drivers/firmware/efi/Kconfig    |   9 +++
>  drivers/firmware/efi/Makefile   |   1 +
>  5 files changed, 159 insertions(+)
>  create mode 100644 drivers/firmware/efi/ovmf-log.c
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 7d63d1d75f22..55479cd8438b 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -439,6 +439,7 @@ void efi_native_runtime_setup(void);
>
>  /* OVMF protocol GUIDs */
>  #define OVMF_SEV_MEMORY_ACCEPTANCE_PROTOCOL_GUID       EFI_GUID(0xc5a010fe, 0x38a7, 0x4531,  0x8a, 0x4a, 0x05, 0x00, 0xd2, 0xfd, 0x16, 0x49)
> +#define OVMF_MEMORY_LOG_TABLE_GUID                     EFI_GUID(0x95305139, 0xb20f, 0x4723, 0x84, 0x25, 0x62, 0x7c, 0x88, 0x8f, 0xf1, 0x21)
>

Please make the indentation consistent with the preceding entries


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
> index e57bff702b5f..629a42e50b57 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -45,6 +45,9 @@ struct efi __read_mostly efi = {
>         .esrt                   = EFI_INVALID_TABLE_ADDR,
>         .tpm_log                = EFI_INVALID_TABLE_ADDR,
>         .tpm_final_log          = EFI_INVALID_TABLE_ADDR,
> +#ifdef CONFIG_OVMF_DEBUG_LOG
> +       .ovmf_debug_log         = EFI_INVALID_TABLE_ADDR,
> +#endif

You can drop the #ifdef here, given that the struct member is always declared.

>  #ifdef CONFIG_LOAD_UEFI_KEYS
>         .mokvar_table           = EFI_INVALID_TABLE_ADDR,
>  #endif
> @@ -473,6 +476,11 @@ static int __init efisubsys_init(void)
>                 platform_device_register_simple("efi_secret", 0, NULL, 0);
>  #endif
>
> +#ifdef CONFIG_OVMF_DEBUG_LOG

... and so you can use if (IS_ENABLED(CONFIG_OVMF_DEBUG_LOG) && ... here

> +       if (efi.ovmf_debug_log != EFI_INVALID_TABLE_ADDR)
> +               platform_device_register_simple("ovmf_log", 0, NULL, 0);

Use 'ovmf_debug_log' for consistency

> +#endif
> +
>         return 0;
>
>  err_remove_group:
> @@ -617,6 +625,9 @@ static const efi_config_table_type_t common_tables[] __initconst = {
>         {LINUX_EFI_MEMRESERVE_TABLE_GUID,       &mem_reserve,           "MEMRESERVE"    },
>         {LINUX_EFI_INITRD_MEDIA_GUID,           &initrd,                "INITRD"        },
>         {EFI_RT_PROPERTIES_TABLE_GUID,          &rt_prop,               "RTPROP"        },
> +#ifdef CONFIG_OVMF_DEBUG_LOG
> +       {OVMF_MEMORY_LOG_TABLE_GUID,            &efi.ovmf_debug_log,    "OVMF-LOG"      },
> +#endif
>  #ifdef CONFIG_EFI_RCI2_TABLE
>         {DELLEMC_EFI_RCI2_TABLE_GUID,           &rci2_table_phys                        },
>  #endif
> diff --git a/drivers/firmware/efi/ovmf-log.c b/drivers/firmware/efi/ovmf-log.c
> new file mode 100644
> index 000000000000..4af52adb57cc
> --- /dev/null
> +++ b/drivers/firmware/efi/ovmf-log.c

ovmf-debug-log.c

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
> +#define MEM_DEBUG_LOG_MAGIC1  0x3167646d666d766f  // "ovmfmdg1"
> +#define MEM_DEBUG_LOG_MAGIC2  0x3267646d666d766f  // "ovmfmdg2"
> +

OVMF_DEBUG_LOG_MAGICn

> +struct mem_debug_log_header {

ovmf_debug_log_header

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
> +static struct mem_debug_log_header *hdr;
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
> +       if (hdr->magic1 != MEM_DEBUG_LOG_MAGIC1 ||
> +           hdr->magic2 != MEM_DEBUG_LOG_MAGIC2) {
> +               dev_err(&dev->dev, "OVMF debug log: magic mismatch\n");
> +               goto err_unmap;
> +       }
> +
> +       size = hdr->hdr_size + hdr->log_size;
> +       dev_info(&dev->dev, "firmware version: \"%s\"\n", hdr->fw_version);
> +       dev_info(&dev->dev, "log buffer size: %lldk\n", size / 1024);
> +

llu

> +       /* map complete log buffer */
> +       iounmap(hdr);

memunmap()

> +       hdr = memremap(efi.ovmf_debug_log, size, MEMREMAP_WB);
> +       if (!hdr) {
> +               dev_err(&dev->dev, "OVMF debug log: buffer map failed\n");
> +               return -EINVAL;
> +       }
> +       logbuf = (void*)hdr + hdr->hdr_size;

space between void and *

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
> +       iounmap(hdr);

memunmap

> +       return ret;
> +}
> +
> +static void ovmf_log_remove(struct platform_device *dev)
> +{
> +       iounmap(hdr);

memunmap

> +}
> +
> +static struct platform_driver ovmf_log_driver = {
> +       .probe = ovmf_log_probe,
> +       .remove = ovmf_log_remove,
> +       .driver = {
> +               .name = "ovmf_log",
> +       },
> +};
> +
> +module_platform_driver(ovmf_log_driver);
> +
> +MODULE_DESCRIPTION("OVMF debug log");
> +MODULE_AUTHOR("Gerd Hoffmann <kraxel@redhat.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:ovmf_log");
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index db8c5c03d3a2..4563d0df170f 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -263,6 +263,15 @@ config EFI_COCO_SECRET
>           virt/coco/efi_secret module to access the secrets, which in turn
>           allows userspace programs to access the injected secrets.
>
> +config OVMF_DEBUG_LOG
> +       tristate "Expose OVMF firmware debug log via sysfs"
> +       depends on EFI
> +       default y

Please drop this - new features are never on by default.

> +       help
> +         Recent OVMF versions (edk2-stable202508 + newer) can write
> +         their debug log to a memory buffer.  This driver exposes the
> +         log content via sysfs (/sys/firmware/efi/ovmf_debug_log).
> +
>  config UNACCEPTED_MEMORY
>         bool
>         depends on EFI_STUB
> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> index a2d0009560d0..4770c7c4e3c7 100644
> --- a/drivers/firmware/efi/Makefile
> +++ b/drivers/firmware/efi/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_APPLE_PROPERTIES)                += apple-properties.o
>  obj-$(CONFIG_EFI_RCI2_TABLE)           += rci2-table.o
>  obj-$(CONFIG_EFI_EMBEDDED_FIRMWARE)    += embedded-firmware.o
>  obj-$(CONFIG_LOAD_UEFI_KEYS)           += mokvar-table.o
> +obj-$(CONFIG_OVMF_DEBUG_LOG)           += ovmf-log.o
>
>  obj-$(CONFIG_SYSFB)                    += sysfb_efi.o
>
> --
> 2.50.0
>
>

