Return-Path: <linux-efi+bounces-831-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 067F988059F
	for <lists+linux-efi@lfdr.de>; Tue, 19 Mar 2024 20:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBEF01C22803
	for <lists+linux-efi@lfdr.de>; Tue, 19 Mar 2024 19:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8853A1DB;
	Tue, 19 Mar 2024 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ouxU6D/P"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431EF39FD8
	for <linux-efi@vger.kernel.org>; Tue, 19 Mar 2024 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710877586; cv=none; b=iPBbj5xL2wFObi/y5t1GjrW2lzkHGXKEZaOjzMvC7YLjd9NgRE0OQ9QwxzDP4SBSGu9c5+/SpjwC2x0LRW4/Nv/P/UxQ7ep+yEUiYlM6O4n4+p8uWeLs7m6hsmvTbVXuSyuJndRoCpqNG+wlmDdnqhthnnAuxujWtpyD0ZYJWl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710877586; c=relaxed/simple;
	bh=E0laA+maX+3WM1LAyUqrdePpnPI8sjcd5w4HIpjLOas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWAKHi0vuM1hXgejDqlPHSLzf4VpkI4louc7JSD6ldhD66fJX3E/yGg37qt/+pKHX/J+pp0MF3YzePgvLOrfR+Vhjwm0bT/hc+c0GOEvaZg5chgwaxrPAz6WzVXCg0d8u8QN+/8+mnHQTcx7k7+N4tmJEFJb5eQzrOdBdSAJoIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ouxU6D/P; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6a9fafacdso4934621b3a.2
        for <linux-efi@vger.kernel.org>; Tue, 19 Mar 2024 12:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1710877582; x=1711482382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2KQUlQtO0GZQ94WgTKWt7iDIjBKiCX2QYDYayr502WQ=;
        b=ouxU6D/PMlDYIeusihbrYssUUTSyxio6DXaFkt9aMmSqyZGXrooq7iEkWde1p0wI6U
         mpA2NP46BTRyj2CBsAk0R2AS9hj61VAm8stOUTeIS8u2hqxiYqBo6klOnL07Xvaxt6eu
         F+8CSOrRsYd8hAEOP7WF6eKRCYsFMfuCqQT69LOK1kSsQitr4/U6Hzk3Y7dHqm7EqSp2
         OV31i/wSVLF/67h/2yTdGmvKqY6+107BjEtyW7CGShQt34BXTIR3amgplkuO9dx6915u
         iTDVAYZa3OMwrjvUD4K0k8mjqtBacot1tIDD/e0W0WMU+8Odz+8nYoiH++8rIfqfjzqo
         sYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710877582; x=1711482382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KQUlQtO0GZQ94WgTKWt7iDIjBKiCX2QYDYayr502WQ=;
        b=aw5ru/h41xivZTC+cykSMIzOowwzhy/HG/Z0VxBz1GcvMq6S7aw3L2OTWxPoHDsDh6
         McHa671ZbG89MgdfbsolTF9C0U3ySERwrCcZhJRlq2SzedevzZ48i9khkccs2wTkX3fx
         bb9iuO9irHueXKCbNlw8nrhPh0JthbV3ITaLeVBBiYWJrQvRrxnfrsq+sDUmEkHhOimW
         jYRB7LLg0PH4ytD8qXMekUAHGEENzgBE9luJWwbXC2WLkpBvZpqpB5JtvNuPoy4HS8LQ
         6JIXLIydJ7NA8yr0ePhkz35kU1KglFx/FIzvJESVhNJ8QcZvhQ10nHfa71cXNaN9yVUF
         Zt0A==
X-Forwarded-Encrypted: i=1; AJvYcCUIPuoqihG33b7Yy8cCghhr2AjmVxK66MLcKsT61gqgq6HyaS//SbSI1KcmvDQ0lrWyJSSf3WDk60PEyKr7zvx5UTYlYgkVDa2c
X-Gm-Message-State: AOJu0YwkAjMPwn8b7T2iqYz+yKt1Xg5EO8ExC9N7TenYkFmqubnOuiiF
	XVR/7NgIQHaZZcRadLZt2SWAoFlZaN2wwvmMsdEi5VuLUId+vm4GGO9hd12bEGnOv4A/oBsK6aJ
	3
X-Google-Smtp-Source: AGHT+IH6Fr5ZQEaEEHnSwEVcf9F4d8R5mfhqSyj3jB2/xuGnf1ofBEDsSI4KPtl9LfuHjq/4erJvMg==
X-Received: by 2002:a05:6a20:d045:b0:1a3:579f:2c5c with SMTP id hv5-20020a056a20d04500b001a3579f2c5cmr9441879pzb.53.1710877582405;
        Tue, 19 Mar 2024 12:46:22 -0700 (PDT)
Received: from ?IPV6:2601:647:4180:9630::546? ([2601:647:4180:9630::546])
        by smtp.gmail.com with ESMTPSA id v14-20020aa799ce000000b006da96503d9fsm10149006pfi.109.2024.03.19.12.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 12:46:22 -0700 (PDT)
Message-ID: <7d69fac0-4cd1-4db6-b19f-fb5a418549ab@rivosinc.com>
Date: Tue, 19 Mar 2024 12:46:20 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: dmi: Add SMBIOS/DMI support
Content-Language: en-US
To: Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org
Cc: aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com,
 xiaobo55x@gmail.com, ardb@kernel.org
References: <20240318020916.1299190-1-haibo1.xu@intel.com>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240318020916.1299190-1-haibo1.xu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/17/24 19:09, Haibo Xu wrote:
> Enable the dmi driver for riscv which would allow access the
> SMBIOS info through some userspace file(/sys/firmware/dmi/*).
> 
> The change was based on that of arm64 and has been verified
> by dmidecode tool.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
> Changes since v1
>    - Change to use memremap/memunmap for dmi_(early)_remap/unmap
>      definition(suggested by Ard)
>    - Minor clean up for comments (Ard)
> ---
>   arch/riscv/Kconfig                   | 11 +++++++++++
>   arch/riscv/include/asm/dmi.h         | 24 ++++++++++++++++++++++++
>   drivers/firmware/efi/riscv-runtime.c | 13 +++++++++++++
>   3 files changed, 48 insertions(+)
>   create mode 100644 arch/riscv/include/asm/dmi.h
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 8ebafe337eac..3639151cb4ef 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -952,6 +952,17 @@ config EFI
>   	  allow the kernel to be booted as an EFI application. This
>   	  is only useful on systems that have UEFI firmware.
>   
> +config DMI
> +	bool "Enable support for SMBIOS (DMI) tables"
> +	depends on EFI
> +	default y
> +	help
> +	  This enables SMBIOS/DMI feature for systems.
> +
> +	  This option is only useful on systems that have UEFI firmware.
> +	  However, even with this option, the resultant kernel should
> +	  continue to boot on existing non-UEFI platforms.
> +
>   config CC_HAVE_STACKPROTECTOR_TLS
>   	def_bool $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=tp -mstack-protector-guard-offset=0)
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
> +#define dmi_early_remap(x, l)		memremap(x, l, MEMREMAP_WB)
> +#define dmi_early_unmap(x, l)		memunmap(x)
> +#define dmi_remap(x, l)			memremap(x, l, MEMREMAP_WB)
> +#define dmi_unmap(x)			memunmap(x)
> +#define dmi_alloc(l)			kzalloc(l, GFP_KERNEL)
> +
> +#endif
> diff --git a/drivers/firmware/efi/riscv-runtime.c b/drivers/firmware/efi/riscv-runtime.c
> index 09525fb5c240..c3bfb9e77e02 100644
> --- a/drivers/firmware/efi/riscv-runtime.c
> +++ b/drivers/firmware/efi/riscv-runtime.c
> @@ -152,3 +152,16 @@ void arch_efi_call_virt_teardown(void)
>   {
>   	efi_virtmap_unload();
>   }
> +
> +static int __init riscv_dmi_init(void)
> +{
> +	/*
> +	 * On riscv, DMI depends on UEFI, and dmi_setup() needs to
> +	 * be called early because dmi_id_init(), which is an arch_initcall
> +	 * itself, depends on dmi_scan_machine() having been called already.
> +	 */
> +	dmi_setup();
> +
> +	return 0;
> +}
> +core_initcall(riscv_dmi_init);

Reviewed-by: Atish Patra <atishp@rivosinc.com>

