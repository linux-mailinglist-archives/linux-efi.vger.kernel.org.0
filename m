Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15811227BC2
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jul 2020 11:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgGUJa4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Jul 2020 05:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGUJa4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Jul 2020 05:30:56 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F9CC0619D8
        for <linux-efi@vger.kernel.org>; Tue, 21 Jul 2020 02:30:55 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so20502826wrw.1
        for <linux-efi@vger.kernel.org>; Tue, 21 Jul 2020 02:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R+EF85aNDdODINrCfjjd0Lfuv95jSgpJvxBVPXo7UEI=;
        b=yY/akW2D9+GrY1oKN3c5+dEliD4OkQM7F6PBHq+jxAt2+MgNVNgHxD8r/+H4hPWZp7
         C6QNv/0wFMcXxVoU3TCemQtIbqkOS+zrtNK1Y3W9/SUy1XdL4jbRdKft5mJ77z/BPakH
         TRk7m1nXqDlBfEq2paJClFRCVqFNLQp9Q5w6FvRmxQfD/BsJ8NskgIwBqJSC5msTA4Xp
         /dPdMrboPhqh06qZbYrGbe/LnpvGSNTJlrfRctFCk5uVc/hp7RpbjH7DcmtUpXQaiP6I
         Zghs3hCBJZfGnwUBK0nuRl6+I9AoSqXtCQRveCQ8KX9MH8VTc+oRbDCFJBxzrXW1ETJW
         qg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+EF85aNDdODINrCfjjd0Lfuv95jSgpJvxBVPXo7UEI=;
        b=Mr7mnRQTQdmL/g297nB+LqIhK5XqDXLs9EU0wqo+fL6VzEyXxm04z7FUpj4NqoKy0n
         A79VRNNdaSl8GnS/mG6dXvLaVC6T0HMTWHmnDkrCj5YXEBwmWkQY+hrO/9rXCNs4jb6H
         13Kyt54dQ3PFtstvILrB/tvS6qRQ2BrtFPUtJKxWNfbNJfkdqCfVoVcVDMqzmKMTdB/u
         yjDWjf2vcsZsbjkgg7BHaE65t6+Ds1qR/wmkh+Ha6AQYgsjhfQTj1ljCuzPUKouyjpuV
         Yp/WKwfaVj1WeUQX3bdUseCJMsND4P9p1NJ+XzTwuc1NWDqj/og/QwTDB6xgNLHXPhvD
         cHAA==
X-Gm-Message-State: AOAM532RIgYTDTpQHXHZqZGgD+e3V01MU6z0HWWRke7gwOtss0GtBYTi
        KkAzeNuVYd2xJOenkTM+JkeVeeRuMgu6jKN9Mob2pQ==
X-Google-Smtp-Source: ABdhPJyEHJcpxpIsrSRwyhLOvolFk/1JMt5qF29yZtthuuwIDXna9yG5CaRZAoAVzWcNKbHQE3jBtSCRybazpe/ZsxU=
X-Received: by 2002:adf:de12:: with SMTP id b18mr27796440wrm.390.1595323854198;
 Tue, 21 Jul 2020 02:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200716234104.29049-1-atish.patra@wdc.com> <20200716234104.29049-2-atish.patra@wdc.com>
 <CAK8P3a2EesjQAs-YGrCO=cYfUVWFQ3CbJfVXJx3qZjCS_XW+wA@mail.gmail.com>
 <CAOnJCUKF-tfN-fHyRcjyAMnYVzQqp=_CLa2F4TQNO7jA4infoQ@mail.gmail.com>
 <CAK8P3a3iUdoOZrORz+aeXYiO35Lp8snrCkxSUPAY6Fh2EinaOw@mail.gmail.com>
 <CAOnJCUL2X9mK41iHLCg1_rtj7JS4p41hqXfmd=hyxK=2t5QQog@mail.gmail.com>
 <CAK8P3a3e3SBtTocpkCybKRjkBJG26G-8YdiroJbZLZYq9f0yfw@mail.gmail.com> <CAMj1kXH53V3Vu8Lq4yzSCn5ZSxn65KiVbt91PUPhkBRO6vuRSQ@mail.gmail.com>
In-Reply-To: <CAMj1kXH53V3Vu8Lq4yzSCn5ZSxn65KiVbt91PUPhkBRO6vuRSQ@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 21 Jul 2020 15:00:41 +0530
Message-ID: <CAAhSdy3XYYaDTC293C9pQRHMz99XGoXr1HDcGv8Zi=9Mto0BHg@mail.gmail.com>
Subject: Re: [RFT PATCH v3 1/9] RISC-V: Move DT mapping outof fixmap
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Atish Patra <atishp@atishpatra.org>,
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

On Tue, Jul 21, 2020 at 2:32 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 21 Jul 2020 at 11:57, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Jul 21, 2020 at 6:18 AM Atish Patra <atishp@atishpatra.org> wrote:
> > > On Sat, Jul 18, 2020 at 2:24 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Sat, Jul 18, 2020 at 3:05 AM Atish Patra <atishp@atishpatra.org> wrote:
> > > > > That's what the original code was doing. A fixmap entry was added to
> > > > > map the original fdt
> > > > > location to a virtual so that parse_dtb can be operated on a virtual
> > > > > address. But we can't map
> > > > > both FDT & early ioremap within a single PMD region( 2MB ). That's why
> > > > > we removed the DT
> > > > > mapping from the fixmap to .bss section. The other alternate option is
> > > > > to increase the fixmap space to 4MB which seems more fragile.
> > > >
> > > > Could the original location just be part of the regular linear mapping of all
> > > > RAM?
> > >
> > > No. Because we don't map the entire RAM until setup_vm_final().
> > > We need to parse DT before setup_vm_final() to get the memblocks and
> > > reserved memory regions.
> >
> > Ok, I see how you create a direct mapping for the kernel image, plus
> > the fixmap for the dtb in setup_vm(), and how moving the dtb into the
> > kernel image simplifies that.
> >
> > I'm still wondering why you can't do the same kind of PGD mapping
> > for the dtb that you do for the vmlinux, creating linear page table
> > entries exactly for the location that holds the dtb, from dtb_pa to
> > dtb_pa+((struct fdt_header*)dtb_pa)->totalsize.
> >
>
> On arm64, we limit the size of the DT to 2MB, and reserve a pair of
> PMD entries adjacent to the fixmap so we can map it r/o statically
> using huge pages without using fixmap/early_ioremap slots. (Using a
> pair of PMD entries allows the DT to appear at any alignment in
> memory, given that PMD entries cover 2 MB each on 4k pages kernels)

The arch/riscv is common for both RV32 and RV64. On RV32, we don't
have PMD due to only two-levels in the page table.

Although, I like the idea of two consecutive PMD mappings which are not
part of FIXMAP. The RISC-V early page table is totally different from the
final init_mm page table. I think we can do two consecutive PGD mappings
in the early page table at lower addresses (quite below PAGE_OFFSET). I
will play-around with this idea.

Regards,
Anup
