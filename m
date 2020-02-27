Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A10161711B2
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 08:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgB0HuN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Feb 2020 02:50:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727661AbgB0HuN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 27 Feb 2020 02:50:13 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A97CF2467F
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2020 07:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582789812;
        bh=c2j8niD0WBvQHxvZLxsxysTWIGySGk8uZ3byhSe6WZg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HQUHPPX18owldGAQr8eYW1t8u5cmA+T6bx8Av/nYuOhdSp/3ejwEx3hWNSUUnp5i2
         p8/DmEiwz/Nmf0yvonFlco4SkUXHRWsRRcWWUwvfTtC9PyCEhPyqKF539tXRHPhhy+
         7/FcZIvnFkJjanep229PP97KKY8pDL718G86JFAM=
Received: by mail-wr1-f49.google.com with SMTP id z15so2086864wrl.1
        for <linux-efi@vger.kernel.org>; Wed, 26 Feb 2020 23:50:12 -0800 (PST)
X-Gm-Message-State: APjAAAW14LtMHEb9mvHS/quA/ZtuqLxtjr+oSY2ufOsVI/0DV2oczVdn
        q59KAI12fsD6IQKnPW1C5X+M4SfrwQBCtptUKtk5pw==
X-Google-Smtp-Source: APXvYqypoH6rhFjIaD4IentJ0Uj+tOOoXA72O3neO2bsIRgQvkEpevXdPA770gRtxDSxaZTOoYGulBnn4TXvKDjigwo=
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr3378672wrw.252.1582789811076;
 Wed, 26 Feb 2020 23:50:11 -0800 (PST)
MIME-Version: 1.0
References: <20200210160248.4889-1-ardb@kernel.org> <20200210160248.4889-14-ardb@kernel.org>
 <952796db5423caf21c411c6f5629f32882f55b29.camel@wdc.com> <CAKv+Gu_eJvZn8a45t5Hr23+QQySJOBaBwSsxW7dkYCoVPO4RPw@mail.gmail.com>
 <00a157796e420dbc8dee08ae2592daecde8bb07b.camel@wdc.com> <CAKv+Gu_NZA8u4QU=KjwNgseWh4=hHWpxDwgn79S1ortj+cSB9g@mail.gmail.com>
 <be1a9d0f835bf4c47a6902181ce23bf1d2c85826.camel@wdc.com>
In-Reply-To: <be1a9d0f835bf4c47a6902181ce23bf1d2c85826.camel@wdc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 27 Feb 2020 08:50:00 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_f8pZAEkvuXFr5KSjY-vJqJ8MrgA-ckZ0HKfZDT6g0fg@mail.gmail.com>
Message-ID: <CAKv+Gu_f8pZAEkvuXFr5KSjY-vJqJ8MrgA-ckZ0HKfZDT6g0fg@mail.gmail.com>
Subject: Re: [PATCH 13/19] efi/libstub: Move get_dram_base() into arm-stub.c
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "nivedita@alum.mit.edu" <nivedita@alum.mit.edu>,
        "lukas@wunner.de" <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 27 Feb 2020 at 08:48, Atish Patra <Atish.Patra@wdc.com> wrote:
>
> On Thu, 2020-02-27 at 08:38 +0100, Ard Biesheuvel wrote:
> > On Thu, 27 Feb 2020 at 00:35, Atish Patra <Atish.Patra@wdc.com>
> > wrote:
> > > On Mon, 2020-02-17 at 09:37 +0100, Ard Biesheuvel wrote:
> > > > On Mon, 17 Feb 2020 at 02:17, Atish Patra <Atish.Patra@wdc.com>
> > > > wrote:
> > > > > On Mon, 2020-02-10 at 17:02 +0100, Ard Biesheuvel wrote:
> > > > > > get_dram_base() is only called from arm-stub.c so move it
> > > > > > into
> > > > > > the same source file as its caller.
> > > > > >
> > > > >
> > > > > Just FYI: riscv efi stub port is also going to use
> > > > > get_dram_base().
> > > > > However, I have renamed arm-stub.c to generic efi-stub.c so
> > > > > that
> > > > > arm,
> > > > > arm64 and riscv can reuse it. Thus, Moving get_dram_base() into
> > > > > arm-
> > > > > stub.c works for riscv as well. I will rebase my patches on top
> > > > > of
> > > > > this
> > > > > series.
> > > > >
> > > >
> > > > Thanks Atish. I was hoping it would turn out like this, which is
> > > > why
> > > > I
> > > > am pushing this series now.
> > > >
> > > > I haven't looked at your code yet, but please avoid using the
> > > > command
> > > > line based initrd/dtb loading routines. I am proposing a cleaner
> > > > way
> > > > to provide the initrd from firmware [0], and dtb loading by the
> > > > stub
> > > > should not be done in the first place.
> > > >
> > > > [0]
> > > > https://lore.kernel.org/linux-efi/20200216141104.21477-1-ardb@kernel.org/
> > >
> > > Sorry I missed this email earlier. Yes I am not using initrd or dtb
> > > loading from U-Boot command line.
> > >
> >
> > If you use arm-stub.c mostly unmodified, you will be using initrd=
> > command line loading,
>
> Do you mean the code path enters to "initrd=" loading part ?
> I think that code path has a minor issue where it prints even if the
> there was no "initrd=" supplied in the command line.
>
> "Loaded initrd from command line option\n"
>
> This happens because efi_load_initrd returns EFI_SUCCESS in absense of
> command string as well.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/tree/drivers/firmware/efi/libstub/arm-stub.c?h=next#n281
>

Ah, thanks for pointing that out.
