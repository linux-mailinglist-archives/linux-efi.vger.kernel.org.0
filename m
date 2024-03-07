Return-Path: <linux-efi+bounces-757-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3493874CD2
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 12:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A052848B9
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 11:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E08E8563E;
	Thu,  7 Mar 2024 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKmO+tKJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E9A31A6B;
	Thu,  7 Mar 2024 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809252; cv=none; b=dvm7n8ElOfV0iX5aX95ixVlzVXsUpSv1wu7tYV+gWDuxOaCSzR2ZPNG8Q4u5K8HDGNCIYm4EbFhlOL8vI42/y8t6H21oCEgcXtS0Vp5ESnBQdgPXEodDMHG2OJ+70q4ZD62vgvn8tsJst9gxuX9L3xwTWpPJJYxDoNlDHdUDIMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809252; c=relaxed/simple;
	bh=2srlf9ydqNNrrFB5EuLcASZHo+Kr5YFVq2nvvdfqvqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1cUTlMkITjIXQKawB/PchVM8NLee18dGHAPvQY7TWkVs7vAZMzar6Av2OI5bEk3aYXD45etPw0b1QhHgZBMq4oBR3mgjgFr7tls6Y2BwLoh2BwKPmU69fP3dGQ7tl64aRZ4i1+ZVcqQgE5cuRzXOtqguqEr8gwxUK6UCev1zp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKmO+tKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9DFC433C7;
	Thu,  7 Mar 2024 11:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709809251;
	bh=2srlf9ydqNNrrFB5EuLcASZHo+Kr5YFVq2nvvdfqvqw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bKmO+tKJ/1YQQr0/VIfw/hwyUuDcDVmE8Xr+X09NbD3m6vup/kJ7F7uioHQTS7Kz9
	 hQnIoUTa6Mj4wgjC6uiCtJ9T0RKKH7i2A/0+5SvyAZ3Cg6G0wc9WuL3P6Y3ERq05xi
	 iWYNxcNORNwHdgQMc0oUjszSPSZKvji/hau++X6YhCZHirPh7ujTUwmg/DQFUxqJnC
	 BougHGudyy21ivSHBewZLEsAZyrQ3GBLXVkPklkHP1+HkUNwu7WjP/DQDW5mcg8m33
	 9t68U/wWQ2Het/PxZ+Gs0Iec3QwqjVjGQ3KKHCqkJRX+He03/tl7InvLXgjFnKhZju
	 YYaVN8Vcz8iNQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51340e89df1so743535e87.1;
        Thu, 07 Mar 2024 03:00:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUlhB51Ky7ZIqyt7edvtAWpbwBg0KTWNBMx9OBXIHRXUASMHiYLbdwDDcRNYvJ7jucrle8JewhYUFkj1xDYzdLDVAeI8nikl0IY
X-Gm-Message-State: AOJu0YxqvwRmV4DOe011azqLybykPVI1JfwxX6Bwe+OsBxh4q6z4NuhN
	PhKA7Ixr6IoJOYTrFaiIYps8ff8ic70eV02I2zKZv/NCty9uYLEJkBjFQTVIBVzGgz0Oe03BQzN
	p4xzOPiBwBy8bSPrtVqOMRwzbrRY=
X-Google-Smtp-Source: AGHT+IGV8i7TFek29fxBdK51QG520w2M1NKZWOoV5ynz9gcTXt09JyCjzQToUkh2vicgw3X/8DaYefI7A5gjjn2BEyM=
X-Received: by 2002:a05:6512:234b:b0:512:fdb3:7a9e with SMTP id
 p11-20020a056512234b00b00512fdb37a9emr1278036lfu.31.1709809249630; Thu, 07
 Mar 2024 03:00:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307083154.346542-1-haibo1.xu@intel.com>
In-Reply-To: <20240307083154.346542-1-haibo1.xu@intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 7 Mar 2024 12:00:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGF_PNLYsLugQnm=gW08XuLEbd_C0-4YYzkH1aYRGSaYg@mail.gmail.com>
Message-ID: <CAMj1kXGF_PNLYsLugQnm=gW08XuLEbd_C0-4YYzkH1aYRGSaYg@mail.gmail.com>
Subject: Re: [PATCH] riscv: dmi: Add SMBIOS/DMI support
To: Haibo Xu <haibo1.xu@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-efi@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, sunilvl@ventanamicro.com, xiaobo55x@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello Haibo,

Some notes below.

On Thu, 7 Mar 2024 at 09:18, Haibo Xu <haibo1.xu@intel.com> wrote:
>
> Enable the dmi driver for riscv which would allow access the
> SMBIOS info through some userspace file(/sys/firmware/dmi/*).
>
> The change was based on that of arm64 and has been verified
> by dmidecode tool.
>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  arch/riscv/Kconfig                   | 11 +++++++++++
>  arch/riscv/include/asm/dmi.h         | 29 ++++++++++++++++++++++++++++
>  drivers/firmware/efi/riscv-runtime.c | 13 +++++++++++++
>  3 files changed, 53 insertions(+)
>  create mode 100644 arch/riscv/include/asm/dmi.h
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0bfcfec67ed5..a123a3e7e5f3 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -918,6 +918,17 @@ config EFI
>           allow the kernel to be booted as an EFI application. This
>           is only useful on systems that have UEFI firmware.
>
> +config DMI
> +       bool "Enable support for SMBIOS (DMI) tables"
> +       depends on EFI
> +       default y
> +       help
> +         This enables SMBIOS/DMI feature for systems.
> +
> +         This option is only useful on systems that have UEFI firmware.
> +         However, even with this option, the resultant kernel should
> +         continue to boot on existing non-UEFI platforms.
> +
>  config CC_HAVE_STACKPROTECTOR_TLS
>         def_bool $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=tp -mstack-protector-guard-offset=0)
>
> diff --git a/arch/riscv/include/asm/dmi.h b/arch/riscv/include/asm/dmi.h
> new file mode 100644
> index 000000000000..a861043f02dc
> --- /dev/null
> +++ b/arch/riscv/include/asm/dmi.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2024 Intel Corporation
> + *
> + * based on arch/arm64/include/asm/dmi.h
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +
> +#ifndef __ASM_DMI_H
> +#define __ASM_DMI_H
> +
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +
> +/*
> + * According to section 2.3.6 of the UEFI spec, the firmware should not
> + * request a virtual mapping for configuration tables such as SMBIOS.
> + * This means we have to map them before use.
> + */

You can drop this comment, it is not really accurate.

'Requesting a virtual mapping' means the memory is mapped by the OS
into the EFI page tables before calling a runtime service, so that the
firmware (which runs under the OS's memory translation regime) can
access the contents.

SMBIOS tables are informational and for consumption by the OS only,
not by the runtime service implementations themselves, and so they can
be omitted from the EFI runtime page tables.


> +#define dmi_early_remap(x, l)          ioremap_prot(x, l, _PAGE_KERNEL)
> +#define dmi_early_unmap(x, l)          iounmap(x)
> +#define dmi_remap(x, l)                        ioremap_prot(x, l, _PAGE_KERNEL)
> +#define dmi_unmap(x)                   iounmap(x)

Why not use memremap() here? That will reuse the linear map if it
happens to already cover the region.

> +#define dmi_alloc(l)                   kzalloc(l, GFP_KERNEL)
> +
> +#endif
> diff --git a/drivers/firmware/efi/riscv-runtime.c b/drivers/firmware/efi/riscv-runtime.c
> index 09525fb5c240..c3bfb9e77e02 100644
> --- a/drivers/firmware/efi/riscv-runtime.c
> +++ b/drivers/firmware/efi/riscv-runtime.c
> @@ -152,3 +152,16 @@ void arch_efi_call_virt_teardown(void)
>  {
>         efi_virtmap_unload();
>  }
> +
> +static int __init riscv_dmi_init(void)
> +{
> +       /*
> +        * On riscv, DMI depends on UEFI, and dmi_setup() needs to
> +        * be called early because dmi_id_init(), which is an arch_initcall
> +        * itself, depends on dmi_scan_machine() having been called already.
> +        */
> +       dmi_setup();
> +
> +       return 0;
> +}
> +core_initcall(riscv_dmi_init);
> --
> 2.34.1
>
>

