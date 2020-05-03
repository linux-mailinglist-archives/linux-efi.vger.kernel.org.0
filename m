Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0A21C2DD9
	for <lists+linux-efi@lfdr.de>; Sun,  3 May 2020 18:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgECQL0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 3 May 2020 12:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728665AbgECQL0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 3 May 2020 12:11:26 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2912520757;
        Sun,  3 May 2020 16:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588522286;
        bh=kMwOGtCAJASEPsfvYBAKqgbEH2mxZkJEsxIUNF9WCHc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KiIozO2XKHAqUQGFX5ObUTW/Qb8ykRUciV4QjSyFo/dcuDA5GH3Em89oX2aMITe8M
         ugzBS9WW5u1MUq0d2lCXHIrzWWIWNcyi3Xmu1f5giFa5TBNOL/y+s5njPF79PKOoX7
         g4apTW9Ujqm1TkSgoLQZ2oBQFZDItrsEMK08CNl0=
Received: by mail-io1-f44.google.com with SMTP id d7so4910488ioq.5;
        Sun, 03 May 2020 09:11:26 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ5kw/l0EdWYDTl3kTjodCCbwDO4Hlb+T6x+QCX9qLz8Mg9fdr0
        dAF0YaS8jdN74uDR+HiQf+P8Kg7HeksCp6rK5ro=
X-Google-Smtp-Source: APiQypKCq/06E5d6skoEysLKVp/ZGOsn9LUOEYM7bPrPVvwAu6PK1ArHCj/14zTc3HOfjo1kWTKG83bFOIokVEh4HxI=
X-Received: by 2002:a6b:ef03:: with SMTP id k3mr12070303ioh.203.1588522285507;
 Sun, 03 May 2020 09:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200424130531.30518-1-ardb@kernel.org> <20200424130531.30518-4-ardb@kernel.org>
 <20200503150906.GA57805@roeck-us.net> <20200503160943.GA718804@rani.riverdale.lan>
In-Reply-To: <20200503160943.GA718804@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 3 May 2020 18:11:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE3XTMjryJzBMVCujXy=kQYasKAr-Rb5ZKuqC7oWaePdA@mail.gmail.com>
Message-ID: <CAMj1kXE3XTMjryJzBMVCujXy=kQYasKAr-Rb5ZKuqC7oWaePdA@mail.gmail.com>
Subject: Re: [PATCH 03/33] efi/libstub: Unify EFI call wrappers for non-x86
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 3 May 2020 at 18:09, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Sun, May 03, 2020 at 08:09:06AM -0700, Guenter Roeck wrote:
> > Hi,
> >
> > On Fri, Apr 24, 2020 at 03:05:01PM +0200, Ard Biesheuvel wrote:
> > > We have wrappers around EFI calls so that x86 can define special
> > > versions for mixed mode, while all other architectures can use the
> > > same simple definition that just issues the call directly.
> > > In preparation for the arrival of yet another architecture that doesn't
> > > need anything special here (RISC-V), let's move the default definition
> > > into a shared header.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > This patch causes an immediate reboot in linux-next when booting
> > in qemu with an efi32 bios. Bisect log attached.
> >
> > Qemu command line:
> >
> > qemu-system-x86_64 -kernel arch/x86/boot/bzImage -m 1G \
> >       -no-reboot -snapshot \
> >       -bios OVMF-pure-efi-32.fd \
> >       -drive file=rootfs.ext2,format=raw \
> >       --append 'earlycon=uart8250,io,0x3f8,9600n8 panic=-1 root=/dev/sda console=ttyS0' \
> >       -nographic
> >
> > The same command succeeds with OVMF-pure-efi-64.fd.
> >
> > Bisect log attached.
> >
> > File locations:
> >       https://github.com/groeck/linux-build-test/blob/master/rootfs/firmware/OVMF-pure-efi-32.fd
> >       https://github.com/groeck/linux-build-test/blob/master/rootfs/x86_64/rootfs.ext2.gz
> >
> > Guenter
> >
>
> The issue is that efi_is_native is an inline function on x86, not a
> macro, so the #ifndef efi_is_native is broken.
>
> We can either turn it into a macro, or add
>         #define efi_is_native efi_is_native
> in arch/x86/include/asm/efi.h.

Indeed. Fix here:

https://lore.kernel.org/linux-efi/20200503154507.82880-1-ardb@kernel.org/T/#u
