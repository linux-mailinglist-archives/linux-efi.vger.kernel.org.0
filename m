Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1145073938F
	for <lists+linux-efi@lfdr.de>; Thu, 22 Jun 2023 02:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjFVAJw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Jun 2023 20:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjFVAJp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Jun 2023 20:09:45 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DB1D3
        for <linux-efi@vger.kernel.org>; Wed, 21 Jun 2023 17:09:36 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-543c692db30so5155852a12.3
        for <linux-efi@vger.kernel.org>; Wed, 21 Jun 2023 17:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687392576; x=1689984576;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPCjWQuh0tMubZzzG3kZbKYTL4R1/Hyq1qgdTGl4eLI=;
        b=MJFZFMsHmr01OG2VNsbcorKDHR/vf8xMKy5enKEXfwqs7HCBtGpP7Nc7/h079s754A
         /qudvs/X1buT/gSM133Ua1jBrcqB1/QIh3I8CxhYIU4fN1+WQGl8m/6GGAdVu+NBd82e
         s1ZxoS+R9OpUPRCoxLPF/80e9K3x8AqYqzWtSr9s3nHpklaLwzL5iM9GhOBBlyox4TBl
         qJu1aHiE4E8Sy1Td1qsTlbz7ib+pw3BZbZ6ZdPg/W1TRNAhYuFanVGwQjICxj4GhlBGu
         pCWvy2TYBojkD6FOvZYMUzUnThgcUHfDhsk4miI0CTBr6OQMmLRHF54+PxIGyP5TMaE9
         4MxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687392576; x=1689984576;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPCjWQuh0tMubZzzG3kZbKYTL4R1/Hyq1qgdTGl4eLI=;
        b=U0XtIYQ9zeMnt/3ODK544fY9I4RBcB4t2s65Ok3kjJswQwaZqoyDyzFElW5AfcQSln
         AxD6Zv4Paa8bzt/MevqFA68HA5AHZldR3pnpCd3CSP2FZfudXAIJu2ygJIRD7s8zstje
         h/AZ41E9bImySpokbfGPrC6UNrtk2wUknOasHO6q8n0Jw+GVn+SGGxnzS7bDuxiK+aKy
         ZYDJ4X/6XI5kVBDRopEV0VeSz9beY1w0lW/m8UGcbvsmsM+HoUYhdRu9J2X8Bij8L8oR
         hXrJHtqyYEKH71Se/6e7zvQEN/CvABZMEjMnm0m4ZDdSiPEYktOfOddABxNtypus3aCI
         DfNA==
X-Gm-Message-State: AC+VfDz5plDUdbHUY0b+NyQemCDj2rQS0xpngk+TNTAjtnw2Xq+cA4OC
        yWCqkbLPaeTtykgK6XY+RPbyDwywzws2QnSqjW4=
X-Google-Smtp-Source: ACHHUZ4Btzr1xeO/iX9cHkLZZjSPO3a2rNBzXJNf8ixnyKeGhNl8zc6BsoRgI7UHfigPu4sBdmhRdQ==
X-Received: by 2002:a05:6a20:7290:b0:120:1baf:e56e with SMTP id o16-20020a056a20729000b001201bafe56emr14880065pzk.19.1687392576167;
        Wed, 21 Jun 2023 17:09:36 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id n11-20020a170902d2cb00b001ab01598f40sm4037924plc.173.2023.06.21.17.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 17:09:35 -0700 (PDT)
Date:   Wed, 21 Jun 2023 17:09:35 -0700 (PDT)
X-Google-Original-Date: Wed, 21 Jun 2023 17:08:56 PDT (-0700)
Subject:     Re: [PATCH v3 0/5] riscv: Introduce KASLR
In-Reply-To: <20230606123242.20804-1-alexghiti@rivosinc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alexghiti@rivosinc.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alexghiti@rivosinc.com
Message-ID: <mhng-665efaa0-223e-411c-9c96-4ce1fba5396d@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 06 Jun 2023 05:32:37 PDT (-0700), alexghiti@rivosinc.com wrote:
> The following KASLR implementation allows to randomize the kernel mapping:
>
> - virtually: we expect the bootloader to provide a seed in the device-tree
> - physically: only implemented in the EFI stub, it relies on the firmware to
>   provide a seed using EFI_RNG_PROTOCOL. arm64 has a similar implementation
>   hence the patch 3 factorizes KASLR related functions for riscv to take
>   advantage.
>
> The new virtual kernel location is limited by the early page table that only
> has one PUD and with the PMD alignment constraint, the kernel can only take
> < 512 positions.
>
> base-commit-tag: v6.4-rc2
>
> Changes in v3:
>   * Rebase on top of 6.4-rc2
>   * Make RANDOMIZE_BASE depend on 64bit
>   * Fix efi_icache_sync and efi_get_kimg_min_align which were undefined
>     in x86 (and certainly other archs)
>   * Add patch 4 to fix warning on rv32
>
> Changes in v2:
>   * Rebase on top of 6.3-rc1
>   * Add a riscv cache sync after memcpying the kernel
>   * Add kaslr_offset implementation for KCOV
>   * Add forward declaration to quiet LLVM
>
> Alexandre Ghiti (5):
>   riscv: Introduce virtual kernel mapping KASLR
>   riscv: Dump out kernel offset information on panic
>   arm64: libstub: Move KASLR handling functions to efi-stub-helper.c
>   libstub: Fix compilation warning for rv32
>   riscv: libstub: Implement KASLR by using generic functions
>
>  arch/arm64/include/asm/efi.h                  |   4 +
>  arch/riscv/Kconfig                            |  19 +++
>  arch/riscv/include/asm/efi.h                  |   4 +
>  arch/riscv/include/asm/page.h                 |   3 +
>  arch/riscv/kernel/image-vars.h                |   1 +
>  arch/riscv/kernel/pi/Makefile                 |   2 +-
>  arch/riscv/kernel/pi/cmdline_early.c          |  13 ++
>  arch/riscv/kernel/pi/fdt_early.c              |  30 ++++
>  arch/riscv/kernel/setup.c                     |  25 +++
>  arch/riscv/mm/init.c                          |  36 ++++-
>  drivers/firmware/efi/libstub/arm64-stub.c     | 112 +------------
>  drivers/firmware/efi/libstub/arm64.c          |   5 +
>  .../firmware/efi/libstub/efi-stub-helper.c    | 151 ++++++++++++++++++
>  drivers/firmware/efi/libstub/efistub.h        |  18 +++
>  drivers/firmware/efi/libstub/riscv-stub.c     |  28 ++--
>  drivers/firmware/efi/libstub/riscv.c          |   5 +
>  16 files changed, 332 insertions(+), 124 deletions(-)
>  create mode 100644 arch/riscv/kernel/pi/fdt_early.c

I'm marking this one as changes requested as well as LKP is pointing at 
some build failures.  It also touches libstub so I'd really prefer an 
Ack, but folks might not be looking with the build issues.
