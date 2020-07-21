Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB0222775B
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jul 2020 06:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgGUESf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Jul 2020 00:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgGUESf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Jul 2020 00:18:35 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B14C0619D5
        for <linux-efi@vger.kernel.org>; Mon, 20 Jul 2020 21:18:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so19781747wrw.1
        for <linux-efi@vger.kernel.org>; Mon, 20 Jul 2020 21:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pvGyIvK+jrRG641iFQvvM5qkEd++webDM8jQoP8KAeg=;
        b=uBaNnnrbr/RkUKhJ8oRD3GenYZDoDi3q/cqa9bMRN3VnTE7n0oVpoEM5ltsbsNG8Mm
         YcZInye9jRD0m9OFGBAkKqGWKhFHt8PV0DNN4kVcv9nfxOyCwTQh2MH+0lATLa8FrwiB
         ZtX2A8eEdOIhIHU8iLdL+xj18YaTplTCST6hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pvGyIvK+jrRG641iFQvvM5qkEd++webDM8jQoP8KAeg=;
        b=VXnj3+HtQcPLMxIkV+B+nm+YXEOcH6QVwnmDTQjeDmz2FMng5xNff91GMuxE2IMU64
         Qz3+M9KlvxYQkmIzt5X38iUXqgECT2VL4FlIRBecsm1fjk73HlxaPzzOin3smu3NydB/
         +P1zPUNDlpI1/C7KvopbtNd961QEQCqv3NrIPla8JYxNDRIWCnGwIqJ0pnq8otO+KpFU
         Wyze7YBQP/QT7NZuXnx9MguW20/Abu5DhzydVfQqe8+g477Fo3UCYVkE1LACf2EdncjU
         cff5T5DPZm3/YpmTroDmPredgjotTgzcseyvFdfTwExt7gKqOS4U62356GoSHEfH5ndv
         6VUg==
X-Gm-Message-State: AOAM531Amq9QezMDsocCm9kg+mJyBQC4oELwU+qG+niHsqfFaYxxsEet
        VD+l24DtC96Ts1k49nuSUS433NYb7DGpF0YcvOgy
X-Google-Smtp-Source: ABdhPJyUUhI7rmyfgcUYhyAD8KTuWvoSFWEvFQf8q1YY7LKIYYImAXJmzUf5VpYShW70wWOsiDP1Rz6WLyDpwhLoHxY=
X-Received: by 2002:adf:a35e:: with SMTP id d30mr11992031wrb.53.1595305113513;
 Mon, 20 Jul 2020 21:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200716234104.29049-1-atish.patra@wdc.com> <20200716234104.29049-2-atish.patra@wdc.com>
 <CAK8P3a2EesjQAs-YGrCO=cYfUVWFQ3CbJfVXJx3qZjCS_XW+wA@mail.gmail.com>
 <CAOnJCUKF-tfN-fHyRcjyAMnYVzQqp=_CLa2F4TQNO7jA4infoQ@mail.gmail.com> <CAK8P3a3iUdoOZrORz+aeXYiO35Lp8snrCkxSUPAY6Fh2EinaOw@mail.gmail.com>
In-Reply-To: <CAK8P3a3iUdoOZrORz+aeXYiO35Lp8snrCkxSUPAY6Fh2EinaOw@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 20 Jul 2020 21:18:21 -0700
Message-ID: <CAOnJCUL2X9mK41iHLCg1_rtj7JS4p41hqXfmd=hyxK=2t5QQog@mail.gmail.com>
Subject: Re: [RFT PATCH v3 1/9] RISC-V: Move DT mapping outof fixmap
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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

On Sat, Jul 18, 2020 at 2:24 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Jul 18, 2020 at 3:05 AM Atish Patra <atishp@atishpatra.org> wrote:
> > On Thu, Jul 16, 2020 at 11:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Fri, Jul 17, 2020 at 1:41 AM Atish Patra <atish.patra@wdc.com> wrote:
> > > > +#define DTB_EARLY_SIZE         SZ_1M
> > > > +static char early_dtb[DTB_EARLY_SIZE] __initdata;
> > >
> > > Hardcoding the size in .bss seems slightly problematic both for
> > > small and for big systems. On machines with very little memory,
> > > this can lead to running out of free pages before .initdata gets freed,
> > > and it increases the size of the uncompressed vmlinux file by quite
> > > a bit.
> > >
> > > On some systems, the 1MB limit may get too small. While most dtbs
> > > would fall into the range between 10KB and 100KB, it can also be
> > > much larger than that, e.g. when there are DT properties that include
> > > blobs like device firmware that gets loaded into hardware by a kernel
> > > driver.
> > >
> > I was not aware that we can do such things. Is there a current example of that ?
>
> I worked on a product in the distant past where the host firmware
> included the ethernet controller firmware as a DT property[1] to get around
> restrictions on redistributing the blob in the linux-firmware package.
>
> For the .dts files we distribute with the kernel, that would not make
> sense, and I don't know of any current machines that do this in their
> system firmware.
>
> > > Is there anything stopping you from parsing the FDT in its original
> > > location without the extra copy before it gets unflattened?
> >
> > That's what the original code was doing. A fixmap entry was added to
> > map the original fdt
> > location to a virtual so that parse_dtb can be operated on a virtual
> > address. But we can't map
> > both FDT & early ioremap within a single PMD region( 2MB ). That's why
> > we removed the DT
> > mapping from the fixmap to .bss section. The other alternate option is
> > to increase the fixmap space to 4MB which seems more fragile.
>
> Could the original location just be part of the regular linear mapping of all
> RAM?

No. Because we don't map the entire RAM until setup_vm_final().
We need to parse DT before setup_vm_final() to get the memblocks and
reserved memory regions.

I'm not too familiar with the early mapping code myself, so it may not
> be possible, but that would be the most logical place where I'd put it.
>
>         Arnd
>
> [1] drivers/net/ethernet/toshiba/spider_net.c



-- 
Regards,
Atish
