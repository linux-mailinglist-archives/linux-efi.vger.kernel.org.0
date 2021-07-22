Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59763D1E02
	for <lists+linux-efi@lfdr.de>; Thu, 22 Jul 2021 08:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhGVF2b (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Jul 2021 01:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhGVF2b (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Jul 2021 01:28:31 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5C8C061757
        for <linux-efi@vger.kernel.org>; Wed, 21 Jul 2021 23:09:06 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id jx7-20020a17090b46c7b02901757deaf2c8so4067995pjb.0
        for <linux-efi@vger.kernel.org>; Wed, 21 Jul 2021 23:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=JGZNlAbWwH8KnKtTTLQVUHCmfrYBjCcYZGAw8CpDvDY=;
        b=1evNGewArFpgG6ErFTJdQbJ3CgYm4mc2jK3DWn0rs7MMNuV61pPUXSYiijX0XfcXeO
         Te0ApunX5CtjlgRjmzUUZGDGaa4UJZMB1cvrno8V0pXCa8BLwkYiperEM0pDWx1mB3wL
         g/ar3PmfYDbuLzviAwHxbolEbwotsdsu5Ck2R0iwGhT9dtrBeuUTJApheQ+xzmWWEmBp
         aXoLLEaGEo/MX7tPz0MoAyV7di0Ph2EpTcXoc6wIdU7LgghMLNRF3B8XjfMY6TLl9seC
         RxjPXBSy9om7Rfa5/jqspLJPCCTxxg/H7Bv8NcsRV2hmGhl54PQ6OmpYbYzP9YgWVSah
         aA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=JGZNlAbWwH8KnKtTTLQVUHCmfrYBjCcYZGAw8CpDvDY=;
        b=lJIU6Je39GFJmq/0ZTbDkIk4HQcuA2p/vUv5yHHlbpf3PKoK+dR2L3tX5/Eiqlcs+5
         b0mLPD539zn1xbQRM6jfLRiILsz/j7dZ7HWwJFwSZVDlickr8xuVRT8oKh+/yAa+hg9+
         0DV50W6i3YLR013fhdoYx91jH45xmLtUAajuzNYjQVksShd4+2iC57kABTEsxYVWObxw
         b6DBkiRtIVQ7GHD4UyuqZ1Yw+fothLpORqrwcjbABl4N0JcmsuIPutZkVSHpkHIZj/HA
         JQBWSdwpJP99/KPt/CUzBzK6ciSkqF8zgVBtogRt89omKgvxnrvQOukURhyS47jGOZAe
         1jyg==
X-Gm-Message-State: AOAM532npT0McFt56dOkBFo+SGqtornu0K0AlHfReNJINgXKQc7AzisC
        vvZzCgSZnuWAyN8vswVxQS3l3w==
X-Google-Smtp-Source: ABdhPJwbH8JkdIu9/4V/l6vl783ox75sPe2K7cYNoJWAhro5WSE2yrNRSmzunbrlu3M2pVUVp8RyMw==
X-Received: by 2002:a17:90a:bc84:: with SMTP id x4mr7324526pjr.236.1626934145393;
        Wed, 21 Jul 2021 23:09:05 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v69sm29927398pfc.118.2021.07.21.23.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 23:09:04 -0700 (PDT)
Date:   Wed, 21 Jul 2021 23:09:04 -0700 (PDT)
X-Google-Original-Date: Wed, 21 Jul 2021 22:58:55 PDT (-0700)
Subject:     Re: [PATCH 1/1] RISC-V: load initrd wherever it fits into memory
In-Reply-To: <20210629134018.62859-1-xypron.glpk@gmx.de>
CC:     ardb@kernel.org, schwab@linux-m68k.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Atish Patra <Atish.Patra@wdc.com>,
        linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, xypron.glpk@gmx.de
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     xypron.glpk@gmx.de
Message-ID: <mhng-34467fe7-5a31-4c88-a5ad-6dea683fcfeb@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 29 Jun 2021 06:40:18 PDT (-0700), xypron.glpk@gmx.de wrote:
> Requiring that initrd is loaded below RAM start + 256 MiB led to failure
> to boot SUSE Linux with GRUB on QEMU, cf.
> https://lists.gnu.org/archive/html/grub-devel/2021-06/msg00037.html
>
> Remove the constraint.
>
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  arch/riscv/include/asm/efi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
> index 7542282f1141..649ab513dc99 100644
> --- a/arch/riscv/include/asm/efi.h
> +++ b/arch/riscv/include/asm/efi.h
> @@ -33,10 +33,10 @@ static inline unsigned long efi_get_max_fdt_addr(unsigned long image_addr)
>
>  #define ARCH_EFI_IRQ_FLAGS_MASK (SR_IE | SR_SPIE)
>
> -/* Load initrd at enough distance from DRAM start */
> +/* Load initrd anywhere in system RAM */
>  static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
>  {
> -	return image_addr + SZ_256M;
> +	return ULONG_MAX;
>  }
>
>  #define alloc_screen_info(x...)		(&screen_info)

Thanks, this is on fixes.
