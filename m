Return-Path: <linux-efi+bounces-4239-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4D9AFE5AF
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 12:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5545A487925
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 10:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4EA286416;
	Wed,  9 Jul 2025 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVtfvPJj"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834AB267B89;
	Wed,  9 Jul 2025 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752056703; cv=none; b=LtUGOWz+ecKhk2DlBiP7d9q31JkYRjdgEUB1Iu9QtNMzgqv3ED4yqgU4spHurx+GL9T2lkiM8EJ7NuhdcB71j0fM3wX9pgqdioLcIE2dhjkfCYGAUBdSRDMsPx2A1njlRncdPitN16PJwIEyGtLKaMIFC/SU1QghpVPJF/X0cy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752056703; c=relaxed/simple;
	bh=8LUv/0s0n4RqsGAF/zzmGMPqcd+r1IGUCSnQ8ff5g58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQHeJ0Q8LBGt6xfUP91wSmRHkLrKSwdnmKTjBwt+M4Kes6/XsWGaGwXYdnAmfWiIVpq0hFKdd1rUZUzX1/WPTjvrRmUnpzHXXIQYfM14kbVq//0hfXG1MbLNEXY6fzJBSZdm+dFKHqxRqyNg18uNCTekAaXmokQ/6hmugScRVOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVtfvPJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042B5C4AF0B;
	Wed,  9 Jul 2025 10:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752056703;
	bh=8LUv/0s0n4RqsGAF/zzmGMPqcd+r1IGUCSnQ8ff5g58=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kVtfvPJjsMJ4jr4M0j3v/Jf4FIaAD9Vq3BvWiuwBBpJ5vQWpwFBcCrYUew4wogT3X
	 23x7yY2s5BJ57GMJkH9G5KM1vYcXGVFN7XaAm/EmipcXR8SyRfc/YFSPWfVrBOUqqA
	 Nkj5fqzCNm+f7oH51+81xGu8oaBMSDolR1f4CmhMoZeY6ecn2nhpxyZVvujIc7MiVr
	 Jfg5XHP8/V4Cqpqt1ChG9ukx8TMZr16F2DEz2CJoTW6GfBy7picR6zAgw9zMGnXuq0
	 D4xkl9qjZCGcx656Km3Qi12LbbCayi3P/dO2MRV1a0tXG2ZsoKqzCGic1s7hJq+kqp
	 gk+1Wt6s379aw==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b50f357ecso45572241fa.2;
        Wed, 09 Jul 2025 03:25:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVXajB1wkyOIFP/wtstQcBzx6pJurtCfyOjcvdFqozljjo/HheXF+DIE6xMBHLJQHcPUL8KQKH05Dm8Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaQ/bvBaWbtK7uNGCF8GD+i77VV+oyHfI8v7zlOaK/bvA8mkui
	mL/Ckane2TW7JYXvv6JvdmB1SaZrn9lKPPG9DWw/WAIBGoktqjK8MlnOxRNs2ojRaUikSnKeWQR
	63Wi1BosPOfBTLdjpCnU3FCx/DlD8jWo=
X-Google-Smtp-Source: AGHT+IHFvMJC7B63KOGoVOhDNYjSSMFfkl0DxIR/SDS7zzt6KWE0NSGnrmNLi6qb9iJUy0E20FiSaOjGuaOSDbJDrOk=
X-Received: by 2002:a05:6512:1094:b0:553:3332:b661 with SMTP id
 2adb3069b0e04-558fa8ff8ddmr524478e87.26.1752056701282; Wed, 09 Jul 2025
 03:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709101119.927808-1-kraxel@redhat.com>
In-Reply-To: <20250709101119.927808-1-kraxel@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 9 Jul 2025 20:24:49 +1000
X-Gmail-Original-Message-ID: <CAMj1kXG_fy6Bye46_6J-tidY8p5PgLOtUMdvvF24QGqHbAPwdQ@mail.gmail.com>
X-Gm-Features: Ac12FXxiKn_Q1qX1z1FUKmHDluGRr77z4of0FwFD3S9gy_qM7_XDnwhyG1zSymQ
Message-ID: <CAMj1kXG_fy6Bye46_6J-tidY8p5PgLOtUMdvvF24QGqHbAPwdQ@mail.gmail.com>
Subject: Re: [PATCH] efi: remove modular option for ovmf-debug-log
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-efi@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 20:11, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Flip the driver from tristate to bool, so it can not be built modular
> any more.  Also drop the platform device boilerplate, simply call the
> probe function directly instead.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507091432.rbbrjGoU-lkp@intel.com/
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/linux/efi.h                   |  2 ++
>  drivers/firmware/efi/efi.c            |  2 +-
>  drivers/firmware/efi/ovmf-debug-log.c | 43 ++++++---------------------
>  drivers/firmware/efi/Kconfig          |  2 +-
>  4 files changed, 13 insertions(+), 36 deletions(-)
>

Thanks Gerd. I'll fold this into the existing patch instead, so we
don't break bisect needlessly.


> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index a71830608422..f6da5c226fda 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1346,6 +1346,8 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
>
>  umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n);
>
> +int ovmf_log_probe(unsigned long ovmf_debug_log_table);
> +
>  /*
>   * efivar ops event type
>   */
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 3161f918ce53..1ce428e2ac8a 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -476,7 +476,7 @@ static int __init efisubsys_init(void)
>
>         if (IS_ENABLED(CONFIG_OVMF_DEBUG_LOG) &&
>             efi.ovmf_debug_log != EFI_INVALID_TABLE_ADDR)
> -               platform_device_register_simple("ovmf_debug_log", 0, NULL, 0);
> +               ovmf_log_probe(efi.ovmf_debug_log);
>
>         return 0;
>
> diff --git a/drivers/firmware/efi/ovmf-debug-log.c b/drivers/firmware/efi/ovmf-debug-log.c
> index d4fec178fa9f..b292f35109b6 100644
> --- a/drivers/firmware/efi/ovmf-debug-log.c
> +++ b/drivers/firmware/efi/ovmf-debug-log.c
> @@ -64,38 +64,33 @@ static struct bin_attribute ovmf_log_bin_attr = {
>         .read = ovmf_log_read,
>  };
>
> -static int ovmf_log_probe(struct platform_device *dev)
> +__init int ovmf_log_probe(unsigned long ovmf_debug_log_table)
>  {
>         u64 size;
>         int ret = -EINVAL;
>
> -       if (efi.ovmf_debug_log == EFI_INVALID_TABLE_ADDR) {
> -               dev_err(&dev->dev, "OVMF debug log: not available\n");
> -               return -EINVAL;
> -       }
> -
>         /* map + verify header */
> -       hdr = memremap(efi.ovmf_debug_log, sizeof(*hdr), MEMREMAP_WB);
> +       hdr = memremap(ovmf_debug_log_table, sizeof(*hdr), MEMREMAP_WB);
>         if (!hdr) {
> -               dev_err(&dev->dev, "OVMF debug log: header map failed\n");
> +               printk(KERN_ERR "OVMF debug log: header map failed\n");
>                 return -EINVAL;
>         }
>
>         if (hdr->magic1 != OVMF_DEBUG_LOG_MAGIC1 ||
>             hdr->magic2 != OVMF_DEBUG_LOG_MAGIC2) {
> -               dev_err(&dev->dev, "OVMF debug log: magic mismatch\n");
> +               printk(KERN_ERR "OVMF debug log: magic mismatch\n");
>                 goto err_unmap;
>         }
>
>         size = hdr->hdr_size + hdr->log_size;
> -       dev_info(&dev->dev, "firmware version: \"%s\"\n", hdr->fw_version);
> -       dev_info(&dev->dev, "log buffer size: %lluk\n", size / 1024);
> +       printk(KERN_INFO "OVMF debug log: firmware version: \"%s\"\n", hdr->fw_version);
> +       printk(KERN_INFO "OVMF debug log: buffer size: %lluk\n", size / 1024);
>
>         /* map complete log buffer */
>         memunmap(hdr);
> -       hdr = memremap(efi.ovmf_debug_log, size, MEMREMAP_WB);
> +       hdr = memremap(ovmf_debug_log_table, size, MEMREMAP_WB);
>         if (!hdr) {
> -               dev_err(&dev->dev, "OVMF debug log: buffer map failed\n");
> +               printk(KERN_ERR "OVMF debug log: buffer map failed\n");
>                 return -EINVAL;
>         }
>         logbuf = (void *)hdr + hdr->hdr_size;
> @@ -104,7 +99,7 @@ static int ovmf_log_probe(struct platform_device *dev)
>         ovmf_log_bin_attr.size = size;
>         ret = sysfs_create_bin_file(efi_kobj, &ovmf_log_bin_attr);
>         if (ret != 0) {
> -               dev_err(&dev->dev, "OVMF debug log: sysfs register failed\n");
> +               printk(KERN_ERR "OVMF debug log: sysfs register failed\n");
>                 goto err_unmap;
>         }
>
> @@ -114,23 +109,3 @@ static int ovmf_log_probe(struct platform_device *dev)
>         memunmap(hdr);
>         return ret;
>  }
> -
> -static void ovmf_log_remove(struct platform_device *dev)
> -{
> -       memunmap(hdr);
> -}
> -
> -static struct platform_driver ovmf_log_driver = {
> -       .probe = ovmf_log_probe,
> -       .remove = ovmf_log_remove,
> -       .driver = {
> -               .name = "ovmf_debug_log",
> -       },
> -};
> -
> -module_platform_driver(ovmf_log_driver);
> -
> -MODULE_DESCRIPTION("OVMF debug log");
> -MODULE_AUTHOR("Gerd Hoffmann <kraxel@redhat.com>");
> -MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:ovmf_debug_log");
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index ac0a03ec3452..eb1bff6968a5 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -264,7 +264,7 @@ config EFI_COCO_SECRET
>           allows userspace programs to access the injected secrets.
>
>  config OVMF_DEBUG_LOG
> -       tristate "Expose OVMF firmware debug log via sysfs"
> +       bool "Expose OVMF firmware debug log via sysfs"
>         depends on EFI
>         help
>           Recent OVMF versions (edk2-stable202508 + newer) can write
> --
> 2.50.0
>
>

