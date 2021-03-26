Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6C034A357
	for <lists+linux-efi@lfdr.de>; Fri, 26 Mar 2021 09:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhCZInQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Mar 2021 04:43:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhCZInM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 26 Mar 2021 04:43:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A266619BB;
        Fri, 26 Mar 2021 08:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616748192;
        bh=auPK4qEVEfZq7Im80hPIJ7nXvIOJt1yosAJO7vVnmqw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HjhYLnV1E+BKpuQI57WIVzVYJf2ey6I4NdgPGJUERWrr5XQNsYDypxVnH9WzQWFZX
         PZEnCkshDSFnOpxNSo/fI/mtNa4ealAhVg9P3mCpo2UI1NI5y6UxAUgChGB3in59s6
         QevFFiJ4JO03XPPrKtsEJquehCyq4j1tKxtAon4aKR5dKpNy/xgR5g9zi5/oAlHVmu
         ZXEdy86G0rsnybM4g5zgkGi6yYdfeRwTO9XIRdAESlYODGttO1iMLNU/a0Ie4BlFka
         nP+nAW8aANaTPRob3nZ4osjVAmoWjeHPzdlzWuvRgqM2YByp3RV9ael57BW19/zbID
         pVYYvJu2khblw==
Received: by mail-ot1-f41.google.com with SMTP id l12-20020a9d6a8c0000b0290238e0f9f0d8so4539486otq.8;
        Fri, 26 Mar 2021 01:43:12 -0700 (PDT)
X-Gm-Message-State: AOAM531jlIZQPqeeDDrq/cWskZW4FJSw0Xv2H77guJJFHSlFY7rgJlIn
        ZJRXwOuADl37o0Ang2sWUlD7hs2mRpme1QTJZ10=
X-Google-Smtp-Source: ABdhPJzI2WTeyRDqOC8veID600gsE1CYAWT0Q7qkgo4BS/jpCmDSH1tHOEx7obxOOMH2gj4SDAF3VxYacMH7IiNqnyQ=
X-Received: by 2002:a9d:12cb:: with SMTP id g69mr10624384otg.77.1616748191665;
 Fri, 26 Mar 2021 01:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210326000435.4785-1-nathan@kernel.org>
In-Reply-To: <20210326000435.4785-1-nathan@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 26 Mar 2021 09:43:00 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHhdw2EDmsuM0KHXcbKVNSPjrYkTYELHGShDN5NhAkvOQ@mail.gmail.com>
Message-ID: <CAMj1kXHhdw2EDmsuM0KHXcbKVNSPjrYkTYELHGShDN5NhAkvOQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix cross compiling x86 with clang
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 26 Mar 2021 at 01:04, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi all,
>
> This series fixes cross compiling x86 with clang, which was initially
> brought up by John here:
>
> https://lore.kernel.org/r/cceb074c-861c-d716-5e19-834a8492f245@gmail.com/
>
> I have picked up that patch and added the same fix in a couple of other
> places where it is needed.
>
> I have tested this on an ARM based server with both defconfig and
> allmodconfig, where the build now passes.
>
> Please let me know if there are any problems.
>
> Cheers,
> Nathan
>
> John Millikin (1):
>   x86: Propagate $(CLANG_FLAGS) to $(REALMODE_FLAGS)
>
> Nathan Chancellor (2):
>   x86/boot: Add $(CLANG_FLAGS) to compressed KBUILD_CFLAGS
>   efi/libstub: Add $(CLANG_FLAGS) to x86 flags
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

>  arch/x86/Makefile                     | 1 +
>  arch/x86/boot/compressed/Makefile     | 1 +
>  drivers/firmware/efi/libstub/Makefile | 3 ++-
>  3 files changed, 4 insertions(+), 1 deletion(-)
>
>
> base-commit: 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b
> --
> 2.31.0
>
