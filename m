Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C47326ADAA
	for <lists+linux-efi@lfdr.de>; Tue, 15 Sep 2020 21:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgIOTd1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Sep 2020 15:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgIOTc5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 15 Sep 2020 15:32:57 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AD9C06174A
        for <linux-efi@vger.kernel.org>; Tue, 15 Sep 2020 12:32:57 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a9so321628pjg.1
        for <linux-efi@vger.kernel.org>; Tue, 15 Sep 2020 12:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qxKJop9QMXTVBqn7Xak1Ua9rcBtw9SzcSG+L7X2qAGY=;
        b=T1U8Hwb3yNppuHXUMSl5cT87Yw3wdNNh6BU+/3P8TBxawB91bV79FOpRzXDj6Oi/cM
         GZI0XxWlDqohBPteYo5+7OJrfqaTWzua+UYAhx7x4tHd5kVW3FR16Go3f9iTFY+asXXU
         IfqBeYy1n2ENZvbNWbF4fwC8w6syBNwwYrEQbvzHMnKnh9sLr4oOeRxelY99EE5ZRhE5
         TT21Y6g0mkm31QGY2Nf7x2UTei2abic6okAUEgKgZi904r71pHmDC/OYLriIgnTKVPyA
         hTSxK+lh+VLWxuiviwpkM3Vw06/rZy4hOSReGTAG5LVojNxSKm+i8DWgX2kPvHurvdeo
         QtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxKJop9QMXTVBqn7Xak1Ua9rcBtw9SzcSG+L7X2qAGY=;
        b=Uvw+L9uPxdFT1FuQOUodv49+xVyZNY4cgXAbvDptuvhhpxIUGJNhGpte51oCmvmF2l
         DQJ0bP8v9xM0GhTr0Bs1crkAvBqRMhVRMvEo42iRxJXECWABhMatLEgIBelA/moUwcw5
         Y+zXXHxX5UGu4+xizDjJ6KKkRLiHmj3wWsAAqBhS01+Z/RrJ3NWkahftF77UKU+oCIjR
         IbkegSD3RzrOXTDFOM3K1Q0jSNs+RVOX/Z8PpdyBdp1rv9YvFuS7Jy1ts7wAmjrCd4xN
         2I6j5T3j2kHZBlenljxztgE3w+RoOFg0FrPxR5v3Iiwuk89nMTej+feBMYnDPwjVnM0n
         WgVA==
X-Gm-Message-State: AOAM532DptNyivbdBkvuDXgcaIolQLw6ovx6qbzbydA+zIxitSEHsTHH
        HPNNosCjcDZtIbQvlZmKIjZaMPbdToliqxs1KnVyQw==
X-Google-Smtp-Source: ABdhPJwGqyZY/AwYSVb5sBlD/kWfbnETm9q7j5edH7Jppja3ipeHMFmnU31OX6lY2uLbqs8VijTKZvy7D7R7tAVHMdg=
X-Received: by 2002:a17:902:c3d2:b029:d1:9bc8:15f8 with SMTP id
 j18-20020a170902c3d2b02900d19bc815f8mr19985449plj.29.1600198376175; Tue, 15
 Sep 2020 12:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200914095706.3985-1-ardb@kernel.org>
In-Reply-To: <20200914095706.3985-1-ardb@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Sep 2020 12:32:43 -0700
Message-ID: <CAKwvOdmSXm7cV3hB_Yp=DD0RwwDHtPzzDBU8Xj5kBREn3xqYdA@mail.gmail.com>
Subject: Re: [PATCH 00/12] ARM: use adr_l/ldr_l macros for PC-relative references
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Stefan Agner <stefan@agner.ch>,
        Peter Smith <Peter.Smith@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jian Cai <jiancai@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Sep 14, 2020 at 2:57 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> This is a respin of the adr_l/ldr_l code I wrote some years ago in the
> context of my KASLR proof of concept for 32-bit ARM.
>
> A new use case came up, in the form of Clang, which does not implement
> the 'adrl' pseudo-instruction in its assembler, and so for PC-relative
> references that don't fit into a ARM adr instruction, we need something
> else. Patch #2 addresses an actual Clang build issue of this nature, by
> replacing an occurrence of adrl with adr_l.
>
> I have included my existing cleanup patches that were built on top of the
> adr_l macro, which replace several occurrences of open coded arithmetic to
> calculate runtime addresses based on link time virtual addresses stored
> in literals.
>
> Note that all of these patches with the exception of #2 were reviewed or
> acked by Nico before, but given that this was a while ago (and the fact
> that neither of us work for Linaro anymore), I have dropped these. Note
> that only patch #1 deviates significantly from the last version that I
> sent out, the remaining ones were just freshened up (and their commit
> logs slightly expanded).

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for the series, Ard.  I was able to compile and boot the
following with this series (and the fixup to 01/12 applied):

$ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make defconfig
$ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make LLVM=1 defconfig
$ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make LLVM=1 aspeed_g5_defconfig
$ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make LLVM=1 multi_v5_defconfig

(So ARM v7/GCC, ARM v5,6,7/LLVM).  (Technically, the v6 is not
booting, but it's not related to this series and fails to boot without
the series as well.  Our CI on -next is red for an unrelated issue
which is masking the regression).

I was also able to build+boot the defconfig with v5 and v7 with some
configs disabled and a few hacks with LLVM_IAS=1.  This series allowed
me to get further in the build/testing, and I have a few new bugs to
go chase.  If anyone's interested:
https://github.com/ClangBuiltLinux/linux/issues/1154
https://github.com/ClangBuiltLinux/linux/issues/1155
so we're still a handful of bugs away from LLVM_IAS=1 with ARCH=arm,
but we're steadily chipping away at it, and this series is a big help.
Lest it look like there's only kernel fixes in this area, Jian's
https://reviews.llvm.org/D69411 recently was a big help, specifically
for ARCH=arm LLVM_IAS=1.
-- 
Thanks,
~Nick Desaulniers
