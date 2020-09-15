Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AF926AF96
	for <lists+linux-efi@lfdr.de>; Tue, 15 Sep 2020 23:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgIOVax (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Sep 2020 17:30:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728091AbgIOVaR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 15 Sep 2020 17:30:17 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A521A20809
        for <linux-efi@vger.kernel.org>; Tue, 15 Sep 2020 21:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600205411;
        bh=3gYVLqNilL45bDaPWqdnzceNBvrkqFHWB9O4MweYxrg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ATjOjUxf80RWkPW2J61V4iCIb2RbcWWilO/z5lqm43PriHKoqhIIeQ5rRG5Z9JxKn
         NuosIpFQPH6xgZj54lTkhylQ1xebch0/KKh+fIy4ETkjndfDM+Qt/966x0qiTidQhR
         WT2KYeLL5KUbgDF5uZGtRl4SSjkC+xdKAYii+caA=
Received: by mail-oi1-f175.google.com with SMTP id v20so602450oiv.3
        for <linux-efi@vger.kernel.org>; Tue, 15 Sep 2020 14:30:11 -0700 (PDT)
X-Gm-Message-State: AOAM5337wVNSo7mMhFIP0cuG8w85iYmRwTQl5dPKBjR3RjzqyMiGXv1p
        2J5795wzjQvurEkoKajd3AupPg1KcqTlvI+uoPA=
X-Google-Smtp-Source: ABdhPJzXhU3U1e1ehJ+PoZnSUglLAc+jBGomIDJW6e3f9IWfWomL+zorjqPK7I8EqxJnmsDDsKSuKtARXl1T7HLRyCM=
X-Received: by 2002:a54:4517:: with SMTP id l23mr1062885oil.174.1600205410990;
 Tue, 15 Sep 2020 14:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200914095706.3985-1-ardb@kernel.org> <CAKwvOdmSXm7cV3hB_Yp=DD0RwwDHtPzzDBU8Xj5kBREn3xqYdA@mail.gmail.com>
In-Reply-To: <CAKwvOdmSXm7cV3hB_Yp=DD0RwwDHtPzzDBU8Xj5kBREn3xqYdA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 16 Sep 2020 00:29:59 +0300
X-Gmail-Original-Message-ID: <CAMj1kXGuFFUyT48EYvzFmjCP4QZi_Sk_GpBrBCaHjP7HKLhjBA@mail.gmail.com>
Message-ID: <CAMj1kXGuFFUyT48EYvzFmjCP4QZi_Sk_GpBrBCaHjP7HKLhjBA@mail.gmail.com>
Subject: Re: [PATCH 00/12] ARM: use adr_l/ldr_l macros for PC-relative references
To:     Nick Desaulniers <ndesaulniers@google.com>
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

On Tue, 15 Sep 2020 at 22:32, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Mon, Sep 14, 2020 at 2:57 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > This is a respin of the adr_l/ldr_l code I wrote some years ago in the
> > context of my KASLR proof of concept for 32-bit ARM.
> >
> > A new use case came up, in the form of Clang, which does not implement
> > the 'adrl' pseudo-instruction in its assembler, and so for PC-relative
> > references that don't fit into a ARM adr instruction, we need something
> > else. Patch #2 addresses an actual Clang build issue of this nature, by
> > replacing an occurrence of adrl with adr_l.
> >
> > I have included my existing cleanup patches that were built on top of the
> > adr_l macro, which replace several occurrences of open coded arithmetic to
> > calculate runtime addresses based on link time virtual addresses stored
> > in literals.
> >
> > Note that all of these patches with the exception of #2 were reviewed or
> > acked by Nico before, but given that this was a while ago (and the fact
> > that neither of us work for Linaro anymore), I have dropped these. Note
> > that only patch #1 deviates significantly from the last version that I
> > sent out, the remaining ones were just freshened up (and their commit
> > logs slightly expanded).
>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Thanks for the series, Ard.  I was able to compile and boot the
> following with this series (and the fixup to 01/12 applied):
>
> $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make defconfig
> $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make LLVM=1 defconfig
> $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make LLVM=1 aspeed_g5_defconfig
> $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make LLVM=1 multi_v5_defconfig
>
> (So ARM v7/GCC, ARM v5,6,7/LLVM).  (Technically, the v6 is not
> booting, but it's not related to this series and fails to boot without
> the series as well.  Our CI on -next is red for an unrelated issue
> which is masking the regression).
>

Excellent, thanks for testing. Do you have any coverage for Thumb2
builds as well? (CONFIG_THUMB2_KERNEL=y)

> I was also able to build+boot the defconfig with v5 and v7 with some
> configs disabled and a few hacks with LLVM_IAS=1.  This series allowed
> me to get further in the build/testing, and I have a few new bugs to
> go chase.  If anyone's interested:
> https://github.com/ClangBuiltLinux/linux/issues/1154
> https://github.com/ClangBuiltLinux/linux/issues/1155
> so we're still a handful of bugs away from LLVM_IAS=1 with ARCH=arm,
> but we're steadily chipping away at it, and this series is a big help.
> Lest it look like there's only kernel fixes in this area, Jian's
> https://reviews.llvm.org/D69411 recently was a big help, specifically
> for ARCH=arm LLVM_IAS=1.
> --
> Thanks,
> ~Nick Desaulniers
