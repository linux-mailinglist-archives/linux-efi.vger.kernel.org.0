Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D1A1B856A
	for <lists+linux-efi@lfdr.de>; Sat, 25 Apr 2020 11:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDYJzL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 25 Apr 2020 05:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgDYJzL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 25 Apr 2020 05:55:11 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBA812071C;
        Sat, 25 Apr 2020 09:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587808510;
        bh=cFCb6ouVsRKlwXUJyAVxrlbNXmEFn9jU+rjADB6sKDA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v4eWhID3u6oMR1TCD9C2GRkOvzExTDKctrBW8x+Zm8rAufeSFrBSk6aIl2GNZ+R3N
         ay4sNtLTFHsyPF/KbFI/P/THHSCnz3LzZhj712PPIKzNScNyeqFB1t5nAuqtl0bYiV
         fHXlo5QRuM9ph3M1cFXuygI5knfNTscN/hhdUxwY=
Received: by mail-il1-f171.google.com with SMTP id f82so11680925ilh.8;
        Sat, 25 Apr 2020 02:55:10 -0700 (PDT)
X-Gm-Message-State: AGi0PubNyuVzxlCisTrLLXp1qyDnVBUyzbDomJFUyTXRU6Bn8KmicFvn
        +ot2yhXT3e+grpL13VS8qGY5YgsQX5ZW65+mPBI=
X-Google-Smtp-Source: APiQypLZtLKycOIzKTEYuJq4H3b7SltxSSmrEey2TDNOZqtmGbqzGMnCBRhtXICyYR3C/t2dUY5Lwx2OOjasIxJ5xjg=
X-Received: by 2002:a92:aa0f:: with SMTP id j15mr12758968ili.211.1587808510181;
 Sat, 25 Apr 2020 02:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-b521aadc-a209-48d6-886c-957c87f97367@palmerdabbelt-glaptop1> <8bf726ff-2f25-e8ba-17c7-2abf450b7c72@gmx.de>
In-Reply-To: <8bf726ff-2f25-e8ba-17c7-2abf450b7c72@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 25 Apr 2020 11:54:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHNcyVnEsB71KPjZEcPuCT9KCctbOJW8nOC5uy2GYLtLA@mail.gmail.com>
Message-ID: <CAMj1kXHNcyVnEsB71KPjZEcPuCT9KCctbOJW8nOC5uy2GYLtLA@mail.gmail.com>
Subject: Re: [v2 PATCH 1/5] efi: Move arm-stub to a common file
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Will Deacon <will@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 25 Apr 2020 at 11:48, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 4/21/20 9:19 PM, Palmer Dabbelt wrote:
> > On Mon, 13 Apr 2020 14:29:03 PDT (-0700), Atish Patra wrote:
> >> Most of the arm-stub code is written in an architecture independent
> >> manner.
> >> As a result, RISC-V can reuse most of the arm-stub code.
> >>
> >> Rename the arm-stub.c to efi-stub.c so that ARM, ARM64 and RISC-V can
> >> use it.
> >> This patch doesn't introduce any functional changes.
> >>
> >> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>
> The code being moved has some problems:
>
> The ARM stub ignores the return value of efi_setup_gop().
>
> drivers/firmware/efi/libstub/arm-stub.c and
> drivers/firmware/efi/libstub/x86-stub.c both call LocateHandle() before
> calling efi_setup_gop(). I think this should be moved to efi_setup_gop().
>
> I guess the issues can be addressed in some follow up patch.
>

Yes, I suppose this could be improved a bit, so patches welcome, as usual :-)
But I don't think it has any bearing on a patch that renames the file.
