Return-Path: <linux-efi+bounces-830-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488F7880333
	for <lists+linux-efi@lfdr.de>; Tue, 19 Mar 2024 18:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB79A281DDF
	for <lists+linux-efi@lfdr.de>; Tue, 19 Mar 2024 17:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE1625619;
	Tue, 19 Mar 2024 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8uGJ0Hi"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8831B25601;
	Tue, 19 Mar 2024 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710868476; cv=none; b=cFUb0eaWzjg7TYFG7WZ3YxZJAx6/AgoNETl4y6QVhy/3N7QJFavd9/2ukAX7sNtSEHT+kBk0QC3h687M+Il/+U+yk0+ay1CxWmSGtkrSXET1Z2jFo0V3xvQ7UjlLxV3ikREKMg4SH9IpxK/vXMAOYM3TrZpSBz563ZdHeBLnWpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710868476; c=relaxed/simple;
	bh=k/GfgwRI/ijf/uVg7xWos3W1r9MkqyAZbqmhnCW/Ze0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhK9URd5UXZEI27sc/7PMevXkTAZ48X/0ylVx6Ebpfm11Wp8QTUVhPbLCAo898pQrre6ckAnZkGjdReiSfoI1P95x2EvW38HS/xuzPtooN741lhjpeDEctI3TBc+vr/XRScXq99WnmxRS3C/AUk0mHLfqonZfPeBRPuZ3HhwtuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8uGJ0Hi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0E3C43394;
	Tue, 19 Mar 2024 17:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710868476;
	bh=k/GfgwRI/ijf/uVg7xWos3W1r9MkqyAZbqmhnCW/Ze0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H8uGJ0HiJrClx6+giK7xETCTfdfIs1lhiGAu8IYK6EkWDgJkDJT/ydBAhl5L9u/Kq
	 uaN94tScqQYSegWgwm8XKrg8TTqyYkg+jfp2utHf/rPAIKMd78TQbCOQADWMYnxcut
	 +KPMXKbQCFpY5jpcvW05SKB1KpmBmrlJoFB5y6UlmC3wl7Vi4av5KPt1WlF7WX+rWI
	 5k7u7aJXyyiiHYn9iCcO86maZUxarp0xHp0ACD4G8+NPbFrTSrASjPCkGthpPzO/Le
	 yjq46To9zprEnNJXVOSCWIMz7byabwmYQcvJ4fUnCA635ZzwxlB4s98BFizdnchpSE
	 eBuVbjmIk7+Sg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so77294801fa.3;
        Tue, 19 Mar 2024 10:14:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXIfb9aVWv+6N/cT8sU2oZ8SNd82l7PTLBI7S+TJGJk890u9J+PdBkAsLRGa0RTXXmKy5WcmkJmn2z9PHKaXEAwTBlR3u5FdEnb
X-Gm-Message-State: AOJu0YxSYArFoG07oLJ/h/pJEuorPpEK6IBQ7/CUF1XnQ778ikxKL+d5
	jDQP5Do5nipZlMEDcV9EoX/pAjLd6HjvDmZ5bH2Q5ZFpmryJG4r/8Zfu/yBLjcSH4uRE3be8Dk/
	ior1bqyJjJJ/dLUATFOoFqChD4tI=
X-Google-Smtp-Source: AGHT+IE2/6PMvryTfamN52aeDVNlffaly/Fn9IiQOIf0JucEaMGEOMlPO5PEM+e3k5q/g7FBsZx272U/H8lbFbyol/Q=
X-Received: by 2002:a05:651c:387:b0:2d4:22a6:cb15 with SMTP id
 e7-20020a05651c038700b002d422a6cb15mr1982908ljp.25.1710868474544; Tue, 19 Mar
 2024 10:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318020916.1299190-1-haibo1.xu@intel.com>
In-Reply-To: <20240318020916.1299190-1-haibo1.xu@intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 19 Mar 2024 18:14:23 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFgohP_dOCxbmem_5ZWiFs5KmYFOPkj3uAZWhumBfOWFQ@mail.gmail.com>
Message-ID: <CAMj1kXFgohP_dOCxbmem_5ZWiFs5KmYFOPkj3uAZWhumBfOWFQ@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: dmi: Add SMBIOS/DMI support
To: Haibo Xu <haibo1.xu@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-efi@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, sunilvl@ventanamicro.com, xiaobo55x@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Mar 2024 at 02:55, Haibo Xu <haibo1.xu@intel.com> wrote:
>
> Enable the dmi driver for riscv which would allow access the
> SMBIOS info through some userspace file(/sys/firmware/dmi/*).
>
> The change was based on that of arm64 and has been verified
> by dmidecode tool.
>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>


> ---
> Changes since v1
>   - Change to use memremap/memunmap for dmi_(early)_remap/unmap
>     definition(suggested by Ard)
>   - Minor clean up for comments (Ard)
> ---
>  arch/riscv/Kconfig                   | 11 +++++++++++
>  arch/riscv/include/asm/dmi.h         | 24 ++++++++++++++++++++++++
>  drivers/firmware/efi/riscv-runtime.c | 13 +++++++++++++
>  3 files changed, 48 insertions(+)
>  create mode 100644 arch/riscv/include/asm/dmi.h
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 8ebafe337eac..3639151cb4ef 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -952,6 +952,17 @@ config EFI
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
> index 000000000000..ca7cce557ef7
> --- /dev/null
> +++ b/arch/riscv/include/asm/dmi.h
> @@ -0,0 +1,24 @@
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
> +#define dmi_early_remap(x, l)          memremap(x, l, MEMREMAP_WB)
> +#define dmi_early_unmap(x, l)          memunmap(x)
> +#define dmi_remap(x, l)                        memremap(x, l, MEMREMAP_WB)
> +#define dmi_unmap(x)                   memunmap(x)
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

