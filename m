Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70DD1B1DD2
	for <lists+linux-efi@lfdr.de>; Tue, 21 Apr 2020 07:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgDUFGU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Apr 2020 01:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725795AbgDUFGU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Apr 2020 01:06:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26639C061A0F
        for <linux-efi@vger.kernel.org>; Mon, 20 Apr 2020 22:06:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k13so13713173wrw.7
        for <linux-efi@vger.kernel.org>; Mon, 20 Apr 2020 22:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T22n9ZgIUDB3iwAvu4Bq1V9WbDX7+F8NlJ84vbdyBpU=;
        b=TbbEcTtbkUhu5j2yaYH+f+uFPiIpZ3yBjYVhCleGgNsF1aO4CgYh+UrghN6KBPBQcT
         IgpjQfPvPR6qPJN8AcPFeMzbjZxCPnbtdVHHHGMaGyO69yqPxQxRY7/l5L8NfejCVxIb
         wVPpsjcTehCzi4zdDmGXRhGX3uNGF+JmfmzQkUQExl0RbRk/bxjggB830/4xJrQlUMoE
         Ck3FVQ8pguhwrBJHadOAhR4PSQ2Hr/E3VFGt0+imcpMzUH7vhJePvH5s/42uFtQF1Kd6
         Hl4dXHcvKSlIPs1a7HK3qH4h1h8NVBPk+1AuCoHJbvG1pyNDHSsouqLo7zPDvtZu8NaL
         iGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T22n9ZgIUDB3iwAvu4Bq1V9WbDX7+F8NlJ84vbdyBpU=;
        b=P6v1ScCIPkdtv5me9bUIOmvfdCnAO8uyazDfhuM3lbe0TdGXgckn86XRe0uTTGiyFg
         gz1i+xBcXH+dZpMOmF3w+1PEGqcxE5UQZ6gP+f7kOMDfK9Lkg5F6Ez4Aur4mJ2ctDpcO
         WTsUBXmn36QqjBFlc4pdJUj9tAmj2UDEc2QjUhVLaYnWsXtYcl4orjfbRKgaOHeM1f+h
         A9eEvRjRFOzNSuK3pbiHlRiByDes3gKXOHWD3n3OzbqZBB/3WD6B5pbn4p6MkQBIxAdG
         BlorwULnumtAV4DpehMWF3qklmWrb4aVQIGDKYFhCM2SUnI9HvDFM8on7tvrKhIopd+F
         6NsQ==
X-Gm-Message-State: AGi0PubllH5+QcbmJ+VXAq+8znS6cneFnAqWs6CfBP5WPSEVhfPecfHW
        JwgMhvDHWsE3H67Hllzyyc3eR8gKzKSwL5PKebwB
X-Google-Smtp-Source: APiQypJdeYoX/nAoBxN2T6KVPr0GIDpVnjQRxKWUzukLBPcV1cQk8qEU5rEoNiNslRHmr2WT5DXNuroelRKk35B9rcI=
X-Received: by 2002:a5d:4443:: with SMTP id x3mr21644255wrr.162.1587445578746;
 Mon, 20 Apr 2020 22:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200415195422.19866-1-atish.patra@wdc.com> <20200415195422.19866-6-atish.patra@wdc.com>
 <CAMj1kXFRqTYr7_M_j6oN1-xnQ6V4uCYK49yAbjvrf1BB823Cng@mail.gmail.com>
 <CAOnJCUK3fqsR93ewYMUkanh+x1EJN_3QwkFjSDDZZr2MjzpnUQ@mail.gmail.com>
 <CAMj1kXFOkARJ9k81pu-LuHEd7H7AZRRrquzVN-WQ3J239JUZTw@mail.gmail.com>
 <CAMj1kXGv8XrXJ=Tx88O38a9UYM3iuBevg5NXRpMrny1XJZGB7A@mail.gmail.com>
 <CAOnJCUJOY_84eesRreVyEQKjL2awkehcFi5ydMv0USNeaFHd6A@mail.gmail.com>
 <CAMj1kXHLfXOp=JQhAeFx6oazFp=kqiS0TMTV06ZthTFg6QdzWw@mail.gmail.com>
 <b6a28d62be4d42319fca2adaad755612ef094667.camel@wdc.com> <CAMj1kXEQVdQ4ysMoyJk+ue7iZApLLgkhy65Fm7JDPOjNyETx9Q@mail.gmail.com>
 <CAOnJCUKZUNm_0xZtFyOxQMaust79Q0_m7gUS1eQPFkK29uyJMQ@mail.gmail.com> <CAMj1kXHpHnhOjYJaBvj5XhYnOzbH5MzBJePy7dDpd-S3s029CQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHpHnhOjYJaBvj5XhYnOzbH5MzBJePy7dDpd-S3s029CQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 20 Apr 2020 22:06:07 -0700
Message-ID: <CAOnJCUKpLg8EzyaQ59kGVx0Fwfb--T9M2GuBSAAPdoTZfxHSbQ@mail.gmail.com>
Subject: Re: [v3 PATCH 5/5] RISC-V: Add EFI stub support.
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, Anup Patel <Anup.Patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 20, 2020 at 1:02 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 20 Apr 2020 at 09:59, Atish Patra <atishp@atishpatra.org> wrote:
> >
> > On Mon, Apr 20, 2020 at 12:04 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Mon, 20 Apr 2020 at 06:20, Atish Patra <Atish.Patra@wdc.com> wrote:
> > > >
> ...
> > > >
> > > > "If the preferred address is set as the base of DRAM, efi_bs_call is
> > > > bound to fail as well because the base of DRAM is reserved by the
> > > > firmware. So the efi memory allocator can't allocate at that address.
> > > > Technically, it will work but it is no different than passing
> > > > ULONG_MAX. So I thought ULONG_MAX will avoid the confusion.
> > > >
> > > > We try to allocate as low as possible so I am passing dram_base as the
> > > > minimum address anyways. As the firmware reserved the first few KBs,
> > > >
> > >
> > >
> > > OK, so the preferred address *is* the base of DRAM (assuming it is 2
> > > MB aligned). However, in the general case, you keep some firmware
> > > state there (couple of KB) and so you typically end up at DRAM base
> > > plus 2 MB?
> > >
> >
> > Yes.
> >
> > > So first question: why does the firmware put this stuff at the base of
> > > DRAM in the first place? Does it *have* to live there?
> > >
> >
> > The firmware includes the RISC-V specific supervisor binary interface (SBI)[[1]
> > implementation. As it is a RISC-V specific run time service provider,
> > it has to be resident in memory.
> > The arm equivalent of SBI would be PSCI.
> >
> > [1] https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc
> >
>
> I am not asking why it has to be resident in memory. I am asking why
> it has to be at the *base* of memory.
>

Sorry. I misunderstood the question. I think it is kept at the start
of dram to accommodate
embedded systems with smaller memory. It was also easier to manage at
the beginning of
the memory because all other next stages in the boot process just
ignores first few KBs of
the memory. We also did not have a memory reservation scheme back then.

Having said that, this parameter is configurable for each platform in
OpenSBI. In future, this restriction
can be relaxed if a platform vendor wants. IIRC, linux kernel can't
use  the memory below the kernel start
address (where PAGE_OFFSET is mapped) because of generic mm code limitations.

Added Anup (In case he wants to add something to this)

> > > Then, if the base of DRAM is guaranteed to be occupied, why not make
> > > the preferred address base of DRAM + 2 MB ? (or 4 MB for the 32-bit
> > > case)
> >
> > I guess that will work too. I was inclined to use low_alloc_above so
> > that we ensure that the kernel
> > boots from the lowest possible address given the alignment
> > restriction. If the alignment restrictions are relaxed,
> > in future, we just have to change the macro.
> >
> > However, I think calling relocate_kernel with a preferred offset
> > (dram_base + KIMG_ALIGN) is
> > better because it will always fall back to low_alloc_above anyways. I
> > will send the patch.
>
> Indeed. In the common case, it will just do the allocate_pages()
> directly, which is preferred. It will fall back to
> efi_low_alloc_aboce() [and do the memory map parsing and traversal
> etc] only if needed.



-- 
Regards,
Atish
