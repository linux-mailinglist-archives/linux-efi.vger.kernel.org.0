Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAB61B66F7
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 00:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgDWWnc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Apr 2020 18:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgDWWnb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 23 Apr 2020 18:43:31 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAABEC09B042
        for <linux-efi@vger.kernel.org>; Thu, 23 Apr 2020 15:43:31 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 18so3756957pfx.6
        for <linux-efi@vger.kernel.org>; Thu, 23 Apr 2020 15:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=N/UJzAr5dtehQTHBzXy34ZuA/CAq9RTQL58DIHmSsDU=;
        b=jxWUUAHcZRLKkUCvwG3LxBUbKC0Gy7M7XkL63S5P+Xc5a3iB/dxyTwjsaiq4YSnhnt
         nIliNPSoyS+0tv7rEPxJKt7d8S1w6c/T+RHiHtG22tL7VE5ho57cXV+QrFES49a64tsJ
         BZ6PVIAu3W3xz8b0WQzrCxrf2DoTSi8VGlPxqsH9j/2/nJE3pj8A+EKCsXYC+jH4qEf8
         Gg37qlnOEK3/IALDBKMZVl9POHEbSulN/OrRyrTizHNo2f30rBVjCawgISMTyrBzimDB
         3YiXkmmIIMeQo17eMp9Tfm9Kz7wNhm1YB7QQ8LZX2coRgsw2xGX2ODlWk32ivaBvC1cU
         ZnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=N/UJzAr5dtehQTHBzXy34ZuA/CAq9RTQL58DIHmSsDU=;
        b=N18u0PGUQESxc2FWSWZdQeeb1mnV/YGmeK3A7XtBAHr7H0G3bEIV44RViWqhv8r0vP
         lC/30CglOnDY0KyJvnBiYdpcih+UU6v5UEL3a+zuXlaY8jRXCMMvegxY6KYOcoUjoM75
         qGewMy6F8NVTr2FQoGBSo8oBOwTlFT04+JQNB43znFf7jJ8IY53B1jRQfCTk2I5JDjic
         BTULyb5HD+ggZXI8+03LWNUp6Kimlu5Pl+mHWHbeFcLsdKOIUlNYmO4C+v8jZKSRyo2y
         hvdwjoNfTiQjLwk0TKQbU6VQOMBdCmiGpkOz313TXIQ4oz7LQRJtvMCPQk6GxKoG2SU2
         GRpg==
X-Gm-Message-State: AGi0PuY3+hGtIwvkmKLRd7KbdYnqrUrNmcP2PUjfD3/7JQKbXGcikKJd
        rstNusoLboEKATyTrmfEc5KGtxJ5W4n5hA==
X-Google-Smtp-Source: APiQypK+qFJjBWZIM4JseuejIHzEpgez/1Eb2rNDWCq0/ARVphGcY6JqUI7zr0Fw6Lx1kMeyag+eTA==
X-Received: by 2002:a62:25c6:: with SMTP id l189mr6346111pfl.28.1587681810670;
        Thu, 23 Apr 2020 15:43:30 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id o9sm3280699pje.47.2020.04.23.15.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 15:43:29 -0700 (PDT)
Date:   Thu, 23 Apr 2020 15:43:29 -0700 (PDT)
X-Google-Original-Date: Thu, 23 Apr 2020 15:43:27 PDT (-0700)
Subject:     Re: [PATCH v5 0/7] Add UEFI support for RISC-V
In-Reply-To: <20200422172414.6662-1-ardb@kernel.org>
CC:     linux-efi@vger.kernel.org, ardb@kernel.org,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ardb@kernel.org
Message-ID: <mhng-f9b51803-74ca-494c-8433-59911c657b2f@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 22 Apr 2020 10:24:07 PDT (-0700), ardb@kernel.org wrote:
> This is a rework of Atish's series [0] to add EFI stub loader support
> to the RISC-V port. The purpose is to split the code in a way that makes
> it amenable to being merged via different trees during the same cycle.
> While at it, I added a patch to disable initrd= loading for new ports,
> given that it is deprecated and replaced with a method based on a
> special UEFI device path.
>
> My changes are logged in the individual patches.
>
> I propose to take the first four patches via the EFI tree, and expose
> them via a stable tag so that the RISC-V maintainers can merge it before
> applying the remaining patches. That will ensure that both trees remain
> in a buildable state, with working EFI stub support on the riscv branch.

Works for me.  Thanks!

>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
>
> Ard Biesheuvel (1):
>   efi/libstub: Make initrd file loader configurable
>
> Atish Patra (6):
>   efi/libstub: Move arm-stub to a common file
>   efi/libstub/riscv: add arch specific efi.h header file
>   include: pe.h: Add RISC-V related PE definition
>   RISC-V: Define fixmap bindings for generic early ioremap support
>   RISC-V: Add PE/COFF header for EFI stub
>   RISC-V: Add EFI stub support.
>
>  arch/arm/Kconfig                              |   2 +-
>  arch/arm64/Kconfig                            |   2 +-
>  arch/riscv/Kconfig                            |  21 ++++
>  arch/riscv/Makefile                           |   1 +
>  arch/riscv/configs/defconfig                  |   1 +
>  arch/riscv/include/asm/Kbuild                 |   1 +
>  arch/riscv/include/asm/efi.h                  |  41 +++++++
>  arch/riscv/include/asm/fixmap.h               |  18 +++
>  arch/riscv/include/asm/io.h                   |   1 +
>  arch/riscv/include/asm/sections.h             |  13 +++
>  arch/riscv/kernel/Makefile                    |   4 +
>  arch/riscv/kernel/efi-header.S                | 100 ++++++++++++++++
>  arch/riscv/kernel/head.S                      |  16 +++
>  arch/riscv/kernel/image-vars.h                |  53 +++++++++
>  arch/riscv/kernel/vmlinux.lds.S               |  22 +++-
>  drivers/firmware/efi/Kconfig                  |  15 ++-
>  drivers/firmware/efi/libstub/Makefile         |  22 +++-
>  .../efi/libstub/{arm-stub.c => efi-stub.c}    |   0
>  drivers/firmware/efi/libstub/file.c           |   3 +
>  drivers/firmware/efi/libstub/riscv-stub.c     | 109 ++++++++++++++++++
>  include/linux/pe.h                            |   3 +
>  21 files changed, 436 insertions(+), 12 deletions(-)
>  create mode 100644 arch/riscv/include/asm/efi.h
>  create mode 100644 arch/riscv/include/asm/sections.h
>  create mode 100644 arch/riscv/kernel/efi-header.S
>  create mode 100644 arch/riscv/kernel/image-vars.h
>  rename drivers/firmware/efi/libstub/{arm-stub.c => efi-stub.c} (100%)
>  create mode 100644 drivers/firmware/efi/libstub/riscv-stub.c
