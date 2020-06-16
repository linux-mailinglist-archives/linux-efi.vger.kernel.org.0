Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A1E1FAAE9
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jun 2020 10:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgFPIQb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Jun 2020 04:16:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgFPIQa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 16 Jun 2020 04:16:30 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34B87207BC
        for <linux-efi@vger.kernel.org>; Tue, 16 Jun 2020 08:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592295390;
        bh=zM0bjNs8fisP91Kce+QVAGhJeDSr7Rq/g+kEHGH1VNo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=y1zC8BcHYB5UOh/8AXGYMtfEwhXQ5UfZHXG1OYtVpMZMDROP3i2gx3roiLQAGttDv
         I948qG85GLYJnzPbRfF1ztdzRWzU+6vmpvLEcoP9jEVHqYca55kUXBNmf/BNQDKeJK
         +fdnDUbV5nxQMStoN0YEHVLDxPaHeH4ux4dIwjHY=
Received: by mail-ot1-f53.google.com with SMTP id n70so15300213ota.5
        for <linux-efi@vger.kernel.org>; Tue, 16 Jun 2020 01:16:30 -0700 (PDT)
X-Gm-Message-State: AOAM530Tu8ogLFAxzmISfEM1xvG/ddvEGzCP8Jr9yObF3zhvUTXUKBl5
        UMRwTzKxSTMtpkKI4MqYzw94NhLHWQq3yqzCFjM=
X-Google-Smtp-Source: ABdhPJzEgdhWfPhyNgDCjzdpTHBrt2Mm2gVPfonS7qfRnMS8h+g4/1mnYJDFHD+/niYUHhVHX1hzvJVAOY6rmeGaE9c=
X-Received: by 2002:a9d:5a12:: with SMTP id v18mr1469821oth.90.1592295389542;
 Tue, 16 Jun 2020 01:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200422172414.6662-1-ardb@kernel.org> <20200422172414.6662-3-ardb@kernel.org>
 <CAMuHMdXZM7XYBt=2dJFJi+xxe2HOh43KzSkxGoMqaaC_kc_P-g@mail.gmail.com>
In-Reply-To: <CAMuHMdXZM7XYBt=2dJFJi+xxe2HOh43KzSkxGoMqaaC_kc_P-g@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 Jun 2020 10:16:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH3HgmqrEct1ANNNZqb3R+YNpvp+TDkjF7b=1MYFtNa3g@mail.gmail.com>
Message-ID: <CAMj1kXH3HgmqrEct1ANNNZqb3R+YNpvp+TDkjF7b=1MYFtNa3g@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] efi/libstub: Make initrd file loader configurable
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 16 Jun 2020 at 09:55, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ard,
>
> On Wed, Apr 22, 2020 at 7:24 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > Loading an initrd passed via the kernel command line is deprecated: it
> > is limited to files that reside in the same volume as the one the kernel
> > itself was loaded from, and we have more flexible ways to achieve the
> > same. So make it configurable so new architectures can decide not to
> > enable it.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Thanks for your patch, which is now commit cf6b83664895a5c7
> ("efi/libstub: Make initrd file loader configurable")!
>
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -124,6 +124,17 @@ config EFI_ARMSTUB_DTB_LOADER
> >           functionality for bootloaders that do not have such support
> >           this option is necessary.
> >
> > +config EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
> > +       bool "Enable the command line initrd loader"
> > +       depends on EFI_GENERIC_STUB
> > +       default y
> > +       help
> > +         Select this config option to add support for the initrd= command
> > +         line parameter, allowing an initrd that resides on the same volume
> > +         as the kernel image to be loaded into memory.
> > +
> > +         This method is deprecated.
>
> So why the default y?
>

Hallo Geert,

Every time I try to disable something like this, someone pops out of
the woodwork to explain how the feature is so vitally important for
their highly bespoke and vertically integrated boot flow that it has
to be enabled by default for absolutely everybody.

But patches welcome :-)
