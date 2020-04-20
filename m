Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDE21B03AE
	for <lists+linux-efi@lfdr.de>; Mon, 20 Apr 2020 10:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgDTICS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Apr 2020 04:02:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgDTICR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 20 Apr 2020 04:02:17 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8682C22202;
        Mon, 20 Apr 2020 08:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587369736;
        bh=3xcya7M/sEvPLWNBKP6Q1scBZdGSUS616tgCh9F9c7Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MTffXFCO//iyqq/dquWfsII+EQEvkEl1aut2+SzUn9L92VGIKyAl+Zm4GLZNl0hc4
         TJCmR3MNkNjeRWVy80plCLzKyL2JfHIMnLkHphHzYUcoigLfmXVjVoyxaTEIz5DSVz
         L4kzv2fjHZ7yumEV6roTQ5RKVKgOPBYyBW1eJCiY=
Received: by mail-ed1-f50.google.com with SMTP id d16so6342413edv.8;
        Mon, 20 Apr 2020 01:02:16 -0700 (PDT)
X-Gm-Message-State: AGi0PuZXmOBedT5pfLif8VBhvZdqJSQyeo2HaMN8f6kowQUePh6JAkPl
        3tKXf4mTycR9QEnyVBW6fQ7Np0NNM5r/sB1MAL4=
X-Google-Smtp-Source: APiQypIyOH/ryBKZyU0X7EvYrtQRDAKgyCzCYUiTcPhGkK3tSg3xJVYiTIUYCQhCbMqDcQZB/6Mjik8RwtT83/1E2cQ=
X-Received: by 2002:aa7:c0d1:: with SMTP id j17mr12138364edp.308.1587369734880;
 Mon, 20 Apr 2020 01:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200415195422.19866-1-atish.patra@wdc.com> <20200415195422.19866-6-atish.patra@wdc.com>
 <CAMj1kXFRqTYr7_M_j6oN1-xnQ6V4uCYK49yAbjvrf1BB823Cng@mail.gmail.com>
 <CAOnJCUK3fqsR93ewYMUkanh+x1EJN_3QwkFjSDDZZr2MjzpnUQ@mail.gmail.com>
 <CAMj1kXFOkARJ9k81pu-LuHEd7H7AZRRrquzVN-WQ3J239JUZTw@mail.gmail.com>
 <CAMj1kXGv8XrXJ=Tx88O38a9UYM3iuBevg5NXRpMrny1XJZGB7A@mail.gmail.com>
 <CAOnJCUJOY_84eesRreVyEQKjL2awkehcFi5ydMv0USNeaFHd6A@mail.gmail.com>
 <CAMj1kXHLfXOp=JQhAeFx6oazFp=kqiS0TMTV06ZthTFg6QdzWw@mail.gmail.com>
 <b6a28d62be4d42319fca2adaad755612ef094667.camel@wdc.com> <CAMj1kXEQVdQ4ysMoyJk+ue7iZApLLgkhy65Fm7JDPOjNyETx9Q@mail.gmail.com>
 <CAOnJCUKZUNm_0xZtFyOxQMaust79Q0_m7gUS1eQPFkK29uyJMQ@mail.gmail.com>
In-Reply-To: <CAOnJCUKZUNm_0xZtFyOxQMaust79Q0_m7gUS1eQPFkK29uyJMQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 20 Apr 2020 10:02:03 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHpHnhOjYJaBvj5XhYnOzbH5MzBJePy7dDpd-S3s029CQ@mail.gmail.com>
Message-ID: <CAMj1kXHpHnhOjYJaBvj5XhYnOzbH5MzBJePy7dDpd-S3s029CQ@mail.gmail.com>
Subject: Re: [v3 PATCH 5/5] RISC-V: Add EFI stub support.
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "will@kernel.org" <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 20 Apr 2020 at 09:59, Atish Patra <atishp@atishpatra.org> wrote:
>
> On Mon, Apr 20, 2020 at 12:04 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Mon, 20 Apr 2020 at 06:20, Atish Patra <Atish.Patra@wdc.com> wrote:
> > >
...
> > >
> > > "If the preferred address is set as the base of DRAM, efi_bs_call is
> > > bound to fail as well because the base of DRAM is reserved by the
> > > firmware. So the efi memory allocator can't allocate at that address.
> > > Technically, it will work but it is no different than passing
> > > ULONG_MAX. So I thought ULONG_MAX will avoid the confusion.
> > >
> > > We try to allocate as low as possible so I am passing dram_base as the
> > > minimum address anyways. As the firmware reserved the first few KBs,
> > >
> >
> >
> > OK, so the preferred address *is* the base of DRAM (assuming it is 2
> > MB aligned). However, in the general case, you keep some firmware
> > state there (couple of KB) and so you typically end up at DRAM base
> > plus 2 MB?
> >
>
> Yes.
>
> > So first question: why does the firmware put this stuff at the base of
> > DRAM in the first place? Does it *have* to live there?
> >
>
> The firmware includes the RISC-V specific supervisor binary interface (SBI)[[1]
> implementation. As it is a RISC-V specific run time service provider,
> it has to be resident in memory.
> The arm equivalent of SBI would be PSCI.
>
> [1] https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc
>

I am not asking why it has to be resident in memory. I am asking why
it has to be at the *base* of memory.

> > Then, if the base of DRAM is guaranteed to be occupied, why not make
> > the preferred address base of DRAM + 2 MB ? (or 4 MB for the 32-bit
> > case)
>
> I guess that will work too. I was inclined to use low_alloc_above so
> that we ensure that the kernel
> boots from the lowest possible address given the alignment
> restriction. If the alignment restrictions are relaxed,
> in future, we just have to change the macro.
>
> However, I think calling relocate_kernel with a preferred offset
> (dram_base + KIMG_ALIGN) is
> better because it will always fall back to low_alloc_above anyways. I
> will send the patch.

Indeed. In the common case, it will just do the allocate_pages()
directly, which is preferred. It will fall back to
efi_low_alloc_aboce() [and do the memory map parsing and traversal
etc] only if needed.
