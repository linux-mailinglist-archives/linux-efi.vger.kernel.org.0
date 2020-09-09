Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B6C2637DD
	for <lists+linux-efi@lfdr.de>; Wed,  9 Sep 2020 22:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIIUwz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Sep 2020 16:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgIIUwz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Sep 2020 16:52:55 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CC3C061573
        for <linux-efi@vger.kernel.org>; Wed,  9 Sep 2020 13:52:54 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m5so2933400pgj.9
        for <linux-efi@vger.kernel.org>; Wed, 09 Sep 2020 13:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=PtXzKIm23zRtpuuZ6ilAcjx2516RE2gxhsCv7WC6GB4=;
        b=aYA2xAElEsVNsIm8zIjfEUq1XOOrrHdFmq3Npts8cQkZZmm1R4FWaqkHUlt3OUzc5V
         1UAJLfVo+X8HW6b3oKeJdd2ojpERZ30EVy5lNuJXEIm5fOIog6B3ntH9Xr/OvKxbCSKw
         xFHYAYbjy3X80U2DAtVaA46kkwoiyFABj0AyRtChOsp0cMPbR/rIj1KPFIO0jaJNRAhi
         tAPaUi4Dv3nr+JRwnFqqGUDbKGkPr/lG6gXnT04apN5PFuczpdELUiP1BHxM6+I29mDs
         aECOsRo+sAipniUvwvyr5nBUTqbiSDs1fuh6ISK4+7lz8UwkAl9agBNZjMGQ/dfzT0RR
         nSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=PtXzKIm23zRtpuuZ6ilAcjx2516RE2gxhsCv7WC6GB4=;
        b=RIMfqtJ/alBr74SEntLOA//8pJqbuUKni4PJW2Fnh93xg5vDJqshI7xT/kxzGwaczX
         ouYG7Pj2oTfGBNm+CPLtUoIDgWcyCCDvZNCpqkAghtY1GZoAJo+/AUzr5UrC19ergePC
         Vw3uzoeMna0UtJXLqKxq7DbqCvC7gZtzqRUGg5iIEqy8ZP1sK/I/EvsklNQq+MHySPTl
         Q1EEZy8/UG5M0LazszF+oixBCJpmOKarQWTCG9j08eRd8FxW0SIUFSKYxPjde2xfEiOh
         VMwA5sDfKd38FfzOOdMFKbYFneRzkR6Gi2yDKVcJ8AnU2Fq8EsfAI8L7Q9+2ZpFA/dBY
         cztA==
X-Gm-Message-State: AOAM530fJRTyRXxAdqCImrBAhJXvq5SsyoGaNdAdHIpjEgT/8ZZh48Qs
        Pc9ysAieGL6O+ZJoafpqEpemnWY4dTvWmT6D
X-Google-Smtp-Source: ABdhPJxIkM60LhoRwBkumw7TyEYGP8+pANRD/tXAlO+U7HJ6Qa12lLibyeMtceMdRqNBoeXnlPTjXw==
X-Received: by 2002:a62:3641:: with SMTP id d62mr2315115pfa.82.1599684773346;
        Wed, 09 Sep 2020 13:52:53 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id j19sm3576058pfi.51.2020.09.09.13.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 13:52:52 -0700 (PDT)
Date:   Wed, 09 Sep 2020 13:52:52 -0700 (PDT)
X-Google-Original-Date: Wed, 09 Sep 2020 13:52:50 PDT (-0700)
Subject:     Re: [PATCH RFC/RFT 0/3] efi/libstub: arm32: Remove dependency on dram_base
In-Reply-To: <20200909151623.16153-1-ardb@kernel.org>
CC:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ardb@kernel.org, maxim.uvarov@linaro.org, xypron.glpk@gmx.de,
        Atish Patra <Atish.Patra@wdc.com>, jens.wiklander@linaro.org,
        francois.ozog@linaro.org, etienne.carriere@st.com,
        takahiro.akashi@linaro.org, patrice.chotard@st.com,
        sumit.garg@linaro.org, Grant.Likely@arm.com,
        ilias.apalodimas@linaro.org, christophe.priouzeau@linaro.org,
        r.czerwinski@pengutronix.de, patrick.delaunay@st.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ardb@kernel.org
Message-ID: <mhng-8fe8da11-e991-494e-bfc7-fd3e563dad75@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 09 Sep 2020 08:16:20 PDT (-0700), ardb@kernel.org wrote:
> Maxim reports boot failures on platforms that describe reserved memory
> regions in DT that are disjoint from system DRAM, and which are converted
> to EfiReservedMemory regions by the EFI subsystem in u-boot.
>
> As it turns out, the whole notion of discovering the base of DRAM is
> problematic, and it would be better to simply rely on the EFI memory
> allocation routines instead, and derive the FDT and initrd allocation
> limits from the actual placement of the kernel (which is what defines
> the start of the linear region anyway)
>
> Finally, we should be able to get rid of get_dram_base() entirely.
> However, as RISC-V only just started using it, we will need to address
> that at a later time.

Looks like we're using dram_base to derive two argumets to
efi_relocate_kernel(): the preferred load address and the minimum load address.
I don't see any reason why we can't use the same PAGE_OFFSET-like logic that
x86 uses for the minimum load address, but I don't think we have any mechanism
like "struct boot_params" so we'd need to come up with something.

> Cc: Maxim Uvarov <maxim.uvarov@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Francois Ozog <francois.ozog@linaro.org>
> Cc: Etienne CARRIERE <etienne.carriere@st.com>
> Cc: Takahiro Akashi <takahiro.akashi@linaro.org>
> Cc: Patrice CHOTARD <patrice.chotard@st.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Grant Likely <Grant.Likely@arm.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Christophe Priouzeau <christophe.priouzeau@linaro.org>
> Cc: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> Cc: Patrick DELAUNAY <patrick.delaunay@st.com>
>
> Ard Biesheuvel (3):
>   efi/libstub: Export efi_low_alloc_above() to other units
>   efi/libstub: Use low allocation for the uncompressed kernel
>   efi/libstub: base FDT and initrd placement on image address not DRAM
>     base
>
>  arch/arm/include/asm/efi.h                |   6 +-
>  arch/arm64/include/asm/efi.h              |   2 +-
>  drivers/firmware/efi/libstub/arm32-stub.c | 177 ++++----------------
>  drivers/firmware/efi/libstub/efi-stub.c   |   2 +-
>  drivers/firmware/efi/libstub/efistub.h    |   3 +
>  drivers/firmware/efi/libstub/relocate.c   |   4 +-
>  6 files changed, 47 insertions(+), 147 deletions(-)
