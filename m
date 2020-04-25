Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C081B856E
	for <lists+linux-efi@lfdr.de>; Sat, 25 Apr 2020 11:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDYJ55 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 25 Apr 2020 05:57:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgDYJ55 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 25 Apr 2020 05:57:57 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A57F12071C;
        Sat, 25 Apr 2020 09:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587808676;
        bh=Gx4DdGrKg0fE3BrKnN/CFjspd7+pDgAdzeyUs+KfyQg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TWP+UrFyLLUZlNWtNRfo8qxlzlJTYjlYY7KDH/144oI+IhpV2emGEl31UV7Fnwhgm
         +NDSSmk8CU1M4IBh9xqKVpqIq0f5lEH9RfZ33ToBjGHb+vMLO8j/X5CX1TwwniZT+X
         +vEn8XP2rK61ARLBxv/DSfsspwPw0c1tPB4b2SjI=
Received: by mail-io1-f41.google.com with SMTP id p10so13140622ioh.7;
        Sat, 25 Apr 2020 02:57:56 -0700 (PDT)
X-Gm-Message-State: AGi0PuaOtYverzJjBxXEvgqSZAeo/RY4bEkT3jGWFMrNtP4W55jnuXna
        06iO8g0ZhEd6f+ljEXY5PHZjnztFzebuaWRM1Qw=
X-Google-Smtp-Source: APiQypKP7AhLgFeZOKjhExS5K0cfjNDs9Q+1ANtnVwXW7d1hsAxDTDxynkkvFYFWI7WCzE2+02kpATNKLdB2c9SAnFs=
X-Received: by 2002:a5d:9b8a:: with SMTP id r10mr12620527iom.171.1587808676091;
 Sat, 25 Apr 2020 02:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200424130531.30518-1-ardb@kernel.org> <20200425082747.GA94804@gmail.com>
In-Reply-To: <20200425082747.GA94804@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 25 Apr 2020 11:57:45 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHSRfS3+PBWDZWBHCuidTKTAFb8c0Apfyw-1JrTbH=CRg@mail.gmail.com>
Message-ID: <CAMj1kXHSRfS3+PBWDZWBHCuidTKTAFb8c0Apfyw-1JrTbH=CRg@mail.gmail.com>
Subject: Re: [GIT PULL 00/33] EFI updates for v5.8
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 25 Apr 2020 at 10:27, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > Hello Ingo, Thomas,
> >
> > Please pull the attached changes into tip/efi/next. There is some
> > coordination going on with the RISC-V tree this time, so please take the
> > patches in this exact order, and apply them onto v5.7-rc2 so the first
> > three patches can serve as a shared stable base between the efi/core
> > branch and the riscv tree.
> >
> > The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:
> >
> >   Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next
> >
> > for you to fetch changes up to 4eb8320bd1aaa7e69d039f2c251735e3ef0b9a38:
> >
> >   efi: Move arch_tables check to caller (2020-04-24 14:52:16 +0200)
> >
> > ----------------------------------------------------------------
> > EFI changes for v5.8:
> > - preliminary changes for RISC-V
> > - add support for setting the resolution on the EFI framebuffer
> > - simplify kernel image loading for arm64
> > - Move .bss into .data via the linker script instead of relying on symbol
> >   annotations.
> > - Get rid of __pure getters to access global variables
> > - Clean up the config table matching arrays
>
> >  27 files changed, 895 insertions(+), 574 deletions(-)
> >  create mode 100644 drivers/firmware/efi/libstub/alignedmem.c
> >  rename drivers/firmware/efi/libstub/{arm-stub.c => efi-stub.c} (96%)
> >  create mode 100644 drivers/firmware/efi/libstub/relocate.c
>
> Pulled into tip:efi/core, thanks a lot Ard!
>

Thanks Ingo

I guess this means you didn't spot my remark regarding patch #3, which
needs a Kconfig depends tweak for x86. I'll send that out as a
followup patch.
