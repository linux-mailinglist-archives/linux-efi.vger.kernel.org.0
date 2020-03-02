Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1BCE17608E
	for <lists+linux-efi@lfdr.de>; Mon,  2 Mar 2020 17:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgCBQ5R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Mar 2020 11:57:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:51302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgCBQ5R (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 2 Mar 2020 11:57:17 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C43742465E
        for <linux-efi@vger.kernel.org>; Mon,  2 Mar 2020 16:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583168237;
        bh=Rl4Y+FKJZ07cu7tnpiZX3HBhxfOMhi3eofy2/idg9pI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IGt2LFhuNtND1KUEJ7iwPF56n9xate40cL3N5mLsXlkkLrN717o6RJR2rUtPIt/P3
         IwYTFG+lvC6BeuLJGwsKpANo42qItGTmFd+vkGaLxtfFbjJugiLRKkJCnZIFTj7by+
         NGd0fH6jSC/0/Ms0J/ZcOEUDMsUwn8W6sZJRyrag=
Received: by mail-wr1-f54.google.com with SMTP id x7so675439wrr.0
        for <linux-efi@vger.kernel.org>; Mon, 02 Mar 2020 08:57:16 -0800 (PST)
X-Gm-Message-State: ANhLgQ0ooefQfIESgVYBkmmPElJ797Du+jKSr0Gp/LcoTtCw/ec9zDNk
        gujlQWIICZpHR9TAQ9gTnzDC4fMUPc4w14PVWoFZNQ==
X-Google-Smtp-Source: ADFU+vtI5zaph+t1b2eMlFX6QKqVThmtz4xwh5jwBYKynJ3C9dOTh2GTpL1Z8kmQuRabDYaPETt4VI8cPo2lgnSi5zQ=
X-Received: by 2002:adf:f84a:: with SMTP id d10mr536294wrq.208.1583168235249;
 Mon, 02 Mar 2020 08:57:15 -0800 (PST)
MIME-Version: 1.0
References: <20200301230436.2246909-1-nivedita@alum.mit.edu>
 <20200301230436.2246909-4-nivedita@alum.mit.edu> <CAKv+Gu9RRDidiJ8WAnSta1kZoioFU_ZLxwGPQuhepd9N23HUJw@mail.gmail.com>
 <20200302165359.GA2599505@rani.riverdale.lan>
In-Reply-To: <20200302165359.GA2599505@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 2 Mar 2020 17:57:04 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-8HeNaRYZNtTHr1_VF1aH=BRKF4CaeyP-PPfHNQN2paA@mail.gmail.com>
Message-ID: <CAKv+Gu-8HeNaRYZNtTHr1_VF1aH=BRKF4CaeyP-PPfHNQN2paA@mail.gmail.com>
Subject: Re: [PATCH 3/5] efi/x86: Make efi32_pe_entry more readable
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2 Mar 2020 at 17:54, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Mon, Mar 02, 2020 at 08:49:17AM +0100, Ard Biesheuvel wrote:
> > On Mon, 2 Mar 2020 at 00:04, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> ...
> > >         call    1f
> > > -1:     pop     %ebp
> > > -       subl    $1b, %ebp
> > > +1:     pop     %ebx
> > > +       subl    $1b, %ebx
> ...
> > >
> > > +       movl    %ebx, %ebp                      // startup_32 for efi32_pe_stub_entry
> >
> > The code that follows efi32_pe_stub_entry still expects the runtime
> > displacement in %ebp, so we'll need to pass that in another way here.
> >
> > >         jmp     efi32_pe_stub_entry
>
> Didn't follow -- what do you mean by runtime displacement?
>
> efi32_pe_stub_entry expects the runtime address of startup_32 to be in
> %ebp, but with the changes for keeping the frame pointer in %ebp, I
> changed the runtime address to be in %ebx instead. Hence I added that
> movl %ebx, %ebp to put it in %ebp just before calling efi32_pe_stub_entry.
> That should be fine, no?

But how does that work with:

SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
    movl %ecx, efi32_boot_args(%ebp)
    movl %edx, efi32_boot_args+4(%ebp)
    movb $0, efi_is64(%ebp)


?
