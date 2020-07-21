Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8CD227B56
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jul 2020 11:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgGUJCw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Jul 2020 05:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgGUJCw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 21 Jul 2020 05:02:52 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FF2F22C9C;
        Tue, 21 Jul 2020 09:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595322171;
        bh=H4sR2N24637FuvcXN7OsFonQ4tJiLJ5HJGUm63XkrCY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SF717i3ruwvvsB00BOLFc80n9scQYuZQ1PdLipTsltsFjejsLVQu/vt3AYsQii5pi
         U337BVficYv7cKmD9zTy/tjxaMLdR1//QRHaLpL41jlIYwcx4G9C/4B3NUiPJDZoFu
         CmQhhHmpC2cY9eXZPYGIoPLabzrTI8njiISCUfrA=
Received: by mail-oo1-f52.google.com with SMTP id t12so3778316ooc.10;
        Tue, 21 Jul 2020 02:02:51 -0700 (PDT)
X-Gm-Message-State: AOAM532RRoonY9DwZeZjswyLga/P5UgfJlil4fCkDg9PE0IG0+nG1PyL
        Bnzgqa9gwbOSkvl7LjWwxJOX9kV6VxBmZ7s6d2U=
X-Google-Smtp-Source: ABdhPJxTRlrnT+ydEM3pK3cWrhrvw/wbjW+JnumS5WS6Rxoc8K1cIu7KOklEbd+we69/kFrM//djif/Xf4zfAGSx86g=
X-Received: by 2002:a4a:b006:: with SMTP id f6mr23179936oon.13.1595322170629;
 Tue, 21 Jul 2020 02:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200716234104.29049-1-atish.patra@wdc.com> <20200716234104.29049-2-atish.patra@wdc.com>
 <CAK8P3a2EesjQAs-YGrCO=cYfUVWFQ3CbJfVXJx3qZjCS_XW+wA@mail.gmail.com>
 <CAOnJCUKF-tfN-fHyRcjyAMnYVzQqp=_CLa2F4TQNO7jA4infoQ@mail.gmail.com>
 <CAK8P3a3iUdoOZrORz+aeXYiO35Lp8snrCkxSUPAY6Fh2EinaOw@mail.gmail.com>
 <CAOnJCUL2X9mK41iHLCg1_rtj7JS4p41hqXfmd=hyxK=2t5QQog@mail.gmail.com> <CAK8P3a3e3SBtTocpkCybKRjkBJG26G-8YdiroJbZLZYq9f0yfw@mail.gmail.com>
In-Reply-To: <CAK8P3a3e3SBtTocpkCybKRjkBJG26G-8YdiroJbZLZYq9f0yfw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 21 Jul 2020 12:02:39 +0300
X-Gmail-Original-Message-ID: <CAMj1kXH53V3Vu8Lq4yzSCn5ZSxn65KiVbt91PUPhkBRO6vuRSQ@mail.gmail.com>
Message-ID: <CAMj1kXH53V3Vu8Lq4yzSCn5ZSxn65KiVbt91PUPhkBRO6vuRSQ@mail.gmail.com>
Subject: Re: [RFT PATCH v3 1/9] RISC-V: Move DT mapping outof fixmap
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <anup.patel@wdc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 21 Jul 2020 at 11:57, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 21, 2020 at 6:18 AM Atish Patra <atishp@atishpatra.org> wrote:
> > On Sat, Jul 18, 2020 at 2:24 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Sat, Jul 18, 2020 at 3:05 AM Atish Patra <atishp@atishpatra.org> wrote:
> > > > That's what the original code was doing. A fixmap entry was added to
> > > > map the original fdt
> > > > location to a virtual so that parse_dtb can be operated on a virtual
> > > > address. But we can't map
> > > > both FDT & early ioremap within a single PMD region( 2MB ). That's why
> > > > we removed the DT
> > > > mapping from the fixmap to .bss section. The other alternate option is
> > > > to increase the fixmap space to 4MB which seems more fragile.
> > >
> > > Could the original location just be part of the regular linear mapping of all
> > > RAM?
> >
> > No. Because we don't map the entire RAM until setup_vm_final().
> > We need to parse DT before setup_vm_final() to get the memblocks and
> > reserved memory regions.
>
> Ok, I see how you create a direct mapping for the kernel image, plus
> the fixmap for the dtb in setup_vm(), and how moving the dtb into the
> kernel image simplifies that.
>
> I'm still wondering why you can't do the same kind of PGD mapping
> for the dtb that you do for the vmlinux, creating linear page table
> entries exactly for the location that holds the dtb, from dtb_pa to
> dtb_pa+((struct fdt_header*)dtb_pa)->totalsize.
>

On arm64, we limit the size of the DT to 2MB, and reserve a pair of
PMD entries adjacent to the fixmap so we can map it r/o statically
using huge pages without using fixmap/early_ioremap slots. (Using a
pair of PMD entries allows the DT to appear at any alignment in
memory, given that PMD entries cover 2 MB each on 4k pages kernels)
