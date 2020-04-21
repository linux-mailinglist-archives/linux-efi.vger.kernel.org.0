Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D531B30AB
	for <lists+linux-efi@lfdr.de>; Tue, 21 Apr 2020 21:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgDUTwL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Apr 2020 15:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgDUTwK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Apr 2020 15:52:10 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EF9C0610D5
        for <linux-efi@vger.kernel.org>; Tue, 21 Apr 2020 12:52:09 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t11so7279286pgg.2
        for <linux-efi@vger.kernel.org>; Tue, 21 Apr 2020 12:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=neTotun9xvyLxtrGYKrhEcqeY2lnlgT841hPhcr3iwk=;
        b=RvXhuxReyrpoxbZ3nHgXGf/SZuUU7csTsLgM+H0XcLuiRX4Vx3Pe9iHu4NgZhAfwJi
         c8Ok4DlFPTrlxLeuqhZD8SBj7dgBJnq3a+6LO6ENQsEHXqIS4VP2q2xq1NHi+g0kgnSR
         vAoZkntCGW3OpDOA0/1UwQPtGdiCRGCLAi4akCNn9tnwcH1h+fykVG/1xembcWHNgtUV
         wf0ZimevjRlfwlUXkxqh5SiwMq8+cCTNnosyY6XoPaLx+iN7bGKTBDVYGf9J00dW9z/X
         DFR7NMxeB+Jxd6v3E/do3uYVzaiYT7FSHfrshpXtVYbUxYqE1zndC9PWgUA6WNllQ+WZ
         MVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=neTotun9xvyLxtrGYKrhEcqeY2lnlgT841hPhcr3iwk=;
        b=G73ZsEadEJB1TIntmHtlhVpOmTK84HMBzS5zNEVOYv6ms68o6tCzV7yXVx1ExhJxky
         4xd863KnPxFQ8Y4FEYQSKbYK0nQV2ryuxezdQ3B9jZUGmnxGfhLd+ubfxU+qTXCODVNX
         zRAKtoiJsZ1RvkKHdL+BoG/HToGZorJpe5k0zLEgZU48VPMNoxdTT5t0ThgmuAuCK0zJ
         yOsr3whatX5YaR8RPsdeLNLlv5r5E35X5Pso917Qv5PWK1+BWMVzLjjTNk6dxxetkRq3
         pvzBF3VlO/tsUvaS/83d2mf5rhvxWGJIhfwJeDVt6mpj6PPo3tZou4EBS/bEP1dfYdRM
         NYMg==
X-Gm-Message-State: AGi0PubIvf7vhgWggXpBLyhLBJrlkLS/c8aheI2tX48C1MSwBiYJIzAs
        88WyMar5Pzek9md9vIvtKPMVvA==
X-Google-Smtp-Source: APiQypKmTOXNZB7xwi87IfFfpxa8Nzp6hEUEvM5xoGvvGASLbuaDC0up054cw6JLM4XxzFHBeJCEfA==
X-Received: by 2002:a63:3306:: with SMTP id z6mr22822734pgz.147.1587498726451;
        Tue, 21 Apr 2020 12:52:06 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p24sm2784468pff.92.2020.04.21.12.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 12:52:05 -0700 (PDT)
Date:   Tue, 21 Apr 2020 12:52:05 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Apr 2020 12:47:58 PDT (-0700)
Subject:     Re: [v4 PATCH 1/3] RISC-V: Define fixmap bindings for generic early ioremap support
In-Reply-To: <20200421033336.9663-2-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        ardb@kernel.org, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, masahiroy@kernel.org,
        xypron.glpk@gmx.de
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-613ec31b-83df-4a01-998c-e2d682787c1b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

I missed that there's a v4 now, so I'm jumping over here

On Mon, 20 Apr 2020 20:33:34 PDT (-0700), Atish Patra wrote:
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

Just so it doesn't get lost (the patch is the same)

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
