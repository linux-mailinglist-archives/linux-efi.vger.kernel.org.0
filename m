Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988851B302F
	for <lists+linux-efi@lfdr.de>; Tue, 21 Apr 2020 21:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgDUTTo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Apr 2020 15:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726245AbgDUTTm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Apr 2020 15:19:42 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5AFC0610D5
        for <linux-efi@vger.kernel.org>; Tue, 21 Apr 2020 12:19:40 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kb16so1785149pjb.1
        for <linux-efi@vger.kernel.org>; Tue, 21 Apr 2020 12:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=hPVhiHCru66F7M87+182p9Tvtpc85gfkzQRDqIRO1ko=;
        b=r3C7ZPWnB+/BSMYac/cFV6GVQaCwnWAzI9frvjDJLQJR9jPwOhTonM3kEUjmpl4L+j
         a3b25Q+Me2vR+TR33Cc9mp0t9k9AFV03JP9k6k2XYvuWbYyCHCZOWQGB3RYjMjGPpdsp
         pr/Br9+xNw0bAaHb5zRMaYp0pSBSk3qkO7dyjVI54G40sbnt7iz3w1dHKBtMKl8Pqn0k
         0rkFqLQ3FwTIn86ZUeObV+i+tZgjpGexmA5F+2PaDHBsF126dAzWbuh2xb6KYqkJKrGl
         NVkZWpY0UrIl5iMLGM7D1P8IU6mGulUTyns47YhRZWP2kGD/vnVFoDzu9sXDhTS0X4vQ
         W2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=hPVhiHCru66F7M87+182p9Tvtpc85gfkzQRDqIRO1ko=;
        b=J88ntgUUuo5U5XXzMqHCLxvfn0Xczgu6mgzwl0tp5zVpxN5VPx4YKd65rf6vkyO+/F
         2L78rDrr19l2r1UcesbN0rgsMcyhV7ykFOk6m6gTbUYANmJLQmlu74ErrktQlukAqCrW
         sBIx5JAGBCirp4DSfOoJiIawOZTkMzhZDfYQ43RzUykQJo0x/MT/xuMr1sHv8WMnBsue
         WawdmIi5OCEdAb5emwBmSyw00odgXduSOCFQyKvaMniSFEixfVh1cXoMno52ByyzCXzn
         Qv4sT1tTVGgWGn1h9F7ytg7kQ38QkFfCFZ+Onqr+cFyDqB0ZEzNrFRsfUho/4WxM8zvi
         L+JA==
X-Gm-Message-State: AGi0PuYkAQjY6cr0iRzQZLMSsNpnH2P+fLnBzhZ6YATT8Y3qeXqsaGQ6
        UhOxFNvI7b7jEznUpy+IGF+RjQ==
X-Google-Smtp-Source: APiQypJtA1GPjuyjU1rDoIKjs5ei8Wc2RGLVpz0+8Vkr8sWRjn179ks5m9kyaVeEtaU2mYrSUVbc1g==
X-Received: by 2002:a17:902:aa94:: with SMTP id d20mr22883245plr.313.1587496779466;
        Tue, 21 Apr 2020 12:19:39 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b11sm2934507pgj.92.2020.04.21.12.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 12:19:38 -0700 (PDT)
Date:   Tue, 21 Apr 2020 12:19:38 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Apr 2020 12:19:13 PDT (-0700)
Subject:     Re: [v2 PATCH 3/5] RISC-V: Define fixmap bindings for generic early ioremap support
In-Reply-To: <20200413212907.29244-4-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        ardb@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        catalin.marinas@arm.com, Greg KH <gregkh@linuxfoundation.org>,
        mingo@kernel.org, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, masahiroy@kernel.org,
        linux@armlinux.org.uk, will@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-bccab71a-2ee1-4f4b-a7c3-90c1340e525b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 13 Apr 2020 14:29:05 PDT (-0700), Atish Patra wrote:
> UEFI uses early IO or memory mappings for runtime services before
> normal ioremap() is usable. This patch only adds minimum necessary
> fixmap bindings and headers for generic ioremap support to work.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/riscv/Kconfig              |  1 +
>  arch/riscv/include/asm/Kbuild   |  1 +
>  arch/riscv/include/asm/fixmap.h | 18 ++++++++++++++++++
>  arch/riscv/include/asm/io.h     |  1 +
>  4 files changed, 21 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a197258595ef..f39e326a7a42 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -68,6 +68,7 @@ config RISCV
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select HAVE_COPY_THREAD_TLS
>  	select HAVE_ARCH_KASAN if MMU && 64BIT
> +	select GENERIC_EARLY_IOREMAP
>
>  config ARCH_MMAP_RND_BITS_MIN
>  	default 18 if 64BIT
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> index 3d9410bb4de0..59dd7be55005 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> +generic-y += early_ioremap.h
>  generic-y += extable.h
>  generic-y += flat.h
>  generic-y += kvm_para.h
> diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> index 2368d49eb4ef..ba5096d65fb0 100644
> --- a/arch/riscv/include/asm/fixmap.h
> +++ b/arch/riscv/include/asm/fixmap.h
> @@ -30,6 +30,24 @@ enum fixed_addresses {
>  	FIX_TEXT_POKE1,
>  	FIX_TEXT_POKE0,
>  	FIX_EARLYCON_MEM_BASE,
> +	/*
> +	 * Make sure that it is 2MB aligned.
> +	 */
> +#define NR_FIX_SZ_2M	(SZ_2M / PAGE_SIZE)
> +	FIX_THOLE = NR_FIX_SZ_2M - FIX_PMD - 1,
> +
> +	__end_of_permanent_fixed_addresses,
> +	/*
> +	 * Temporary boot-time mappings, used by early_ioremap(),
> +	 * before ioremap() is functional.
> +	 */
> +#define NR_FIX_BTMAPS		(SZ_256K / PAGE_SIZE)
> +#define FIX_BTMAPS_SLOTS	7
> +#define TOTAL_FIX_BTMAPS	(NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS)
> +
> +	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
> +	FIX_BTMAP_BEGIN = FIX_BTMAP_END + TOTAL_FIX_BTMAPS - 1,
> +
>  	__end_of_fixed_addresses
>  };
>
> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index 0f477206a4ed..047f414b6948 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h
> @@ -14,6 +14,7 @@
>  #include <linux/types.h>
>  #include <asm/mmiowb.h>
>  #include <asm/pgtable.h>
> +#include <asm/early_ioremap.h>
>
>  /*
>   * MMIO access functions are separated out to break dependency cycles

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
