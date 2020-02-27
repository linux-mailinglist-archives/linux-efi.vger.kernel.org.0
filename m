Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8010171195
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 08:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgB0HiN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Feb 2020 02:38:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:39170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbgB0HiN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 27 Feb 2020 02:38:13 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96E0820732
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2020 07:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582789092;
        bh=F+Q2c6CKBvCCLd6gPZtgMtKHiKZ9PAjxkOOavH0QcWQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Je5tXZOsvR7+AoojtH/Xx6RadOcC+EofwhyA0bnlEcKAgZzv6UPxwp6ecKxXcNo/d
         vilLPZ7wkr5OQ2x13vYYeAbs3xTsG6VtACoDnWKKi+OF735NQ/ebXycnDOTFIT3nB5
         N/b3ggEpiayWUNaDUQDlR45ebA93RWE+I/JTVbWQ=
Received: by mail-wr1-f46.google.com with SMTP id u6so2055797wrt.0
        for <linux-efi@vger.kernel.org>; Wed, 26 Feb 2020 23:38:12 -0800 (PST)
X-Gm-Message-State: APjAAAUC1Zfl9ozOoJWiC+UvJmeLSzkj7rbUX19VXbQ6GqxwD2HaOVt1
        9Ov5EWXDDAGd6s6ixPgadPnZUBDE67yEFVfGd3GHVA==
X-Google-Smtp-Source: APXvYqyvlNRK9fuUWUshdcZO4hReejFVydRr9936dN3OW+yU5ChFJb9dWeJSoSbVJxrPM/gMIzU8Gi8qoZdpxS0NKks=
X-Received: by 2002:adf:a411:: with SMTP id d17mr3212242wra.126.1582789091068;
 Wed, 26 Feb 2020 23:38:11 -0800 (PST)
MIME-Version: 1.0
References: <20200210160248.4889-1-ardb@kernel.org> <20200210160248.4889-14-ardb@kernel.org>
 <952796db5423caf21c411c6f5629f32882f55b29.camel@wdc.com> <CAKv+Gu_eJvZn8a45t5Hr23+QQySJOBaBwSsxW7dkYCoVPO4RPw@mail.gmail.com>
 <00a157796e420dbc8dee08ae2592daecde8bb07b.camel@wdc.com>
In-Reply-To: <00a157796e420dbc8dee08ae2592daecde8bb07b.camel@wdc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 27 Feb 2020 08:38:00 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_NZA8u4QU=KjwNgseWh4=hHWpxDwgn79S1ortj+cSB9g@mail.gmail.com>
Message-ID: <CAKv+Gu_NZA8u4QU=KjwNgseWh4=hHWpxDwgn79S1ortj+cSB9g@mail.gmail.com>
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

On Thu, 27 Feb 2020 at 00:35, Atish Patra <Atish.Patra@wdc.com> wrote:
>
> On Mon, 2020-02-17 at 09:37 +0100, Ard Biesheuvel wrote:
> > On Mon, 17 Feb 2020 at 02:17, Atish Patra <Atish.Patra@wdc.com>
> > wrote:
> > > On Mon, 2020-02-10 at 17:02 +0100, Ard Biesheuvel wrote:
> > > > get_dram_base() is only called from arm-stub.c so move it into
> > > > the same source file as its caller.
> > > >
> > >
> > > Just FYI: riscv efi stub port is also going to use get_dram_base().
> > > However, I have renamed arm-stub.c to generic efi-stub.c so that
> > > arm,
> > > arm64 and riscv can reuse it. Thus, Moving get_dram_base() into
> > > arm-
> > > stub.c works for riscv as well. I will rebase my patches on top of
> > > this
> > > series.
> > >
> >
> > Thanks Atish. I was hoping it would turn out like this, which is why
> > I
> > am pushing this series now.
> >
> > I haven't looked at your code yet, but please avoid using the command
> > line based initrd/dtb loading routines. I am proposing a cleaner way
> > to provide the initrd from firmware [0], and dtb loading by the stub
> > should not be done in the first place.
> >
> > [0]
> > https://lore.kernel.org/linux-efi/20200216141104.21477-1-ardb@kernel.org/
>
> Sorry I missed this email earlier. Yes I am not using initrd or dtb
> loading from U-Boot command line.
>

If you use arm-stub.c mostly unmodified, you will be using initrd=
command line loading, and it would be better to disable that, and only
enable it if there is a request for it (which I doubt will happen).
