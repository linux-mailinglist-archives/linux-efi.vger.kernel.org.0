Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2F281760BB
	for <lists+linux-efi@lfdr.de>; Mon,  2 Mar 2020 18:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgCBRJt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Mar 2020 12:09:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:55146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbgCBRJr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 2 Mar 2020 12:09:47 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD99424676
        for <linux-efi@vger.kernel.org>; Mon,  2 Mar 2020 17:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583168986;
        bh=wOOJalJ6H53XXQk1DAauUesmJQFNORcTG2bDbS4jTOI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sBlRkkgxt6D2/JozMgjWEI09F+LrMw1oMwtTu/eWsPxGikV+EZyIU832PuFwNMuZR
         EsEQ0Pid29Fz4t0caF+nnxrMfGseFnOZgerLycnpy+UDXCcgU55njWpdZgfiA1RUgZ
         9bQ2Nm80zXEBPQbkvUVs1i1HKpv1GMSDUURHuJ5M=
Received: by mail-wr1-f48.google.com with SMTP id x7so735673wrr.0
        for <linux-efi@vger.kernel.org>; Mon, 02 Mar 2020 09:09:45 -0800 (PST)
X-Gm-Message-State: ANhLgQ0dGsVCZ4vlEUysT6EkTF8H/1XJyNG51TwYLKsdn1xUGZd2K20s
        bioTjPB4JCQy20DfjWKdg2hOMMRY5B+F/l5RpgPTDw==
X-Google-Smtp-Source: ADFU+vulOOyRBC0j8mmKmW/9sKyLi7JLKHuZJbI1cY4csL1kVUSZ58d6JD2kDoI8OSDSrqqv0eu9kTb7HeKZb9iJbEQ=
X-Received: by 2002:adf:e742:: with SMTP id c2mr563486wrn.262.1583168984232;
 Mon, 02 Mar 2020 09:09:44 -0800 (PST)
MIME-Version: 1.0
References: <20200301230436.2246909-1-nivedita@alum.mit.edu>
 <20200301230436.2246909-4-nivedita@alum.mit.edu> <CAKv+Gu9RRDidiJ8WAnSta1kZoioFU_ZLxwGPQuhepd9N23HUJw@mail.gmail.com>
 <20200302165359.GA2599505@rani.riverdale.lan> <CAKv+Gu-8HeNaRYZNtTHr1_VF1aH=BRKF4CaeyP-PPfHNQN2paA@mail.gmail.com>
 <20200302170205.GA2937123@rani.riverdale.lan>
In-Reply-To: <20200302170205.GA2937123@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 2 Mar 2020 18:09:33 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_2JBC5mx=4xqz3Rfr=m8O3RBh8j5Yxfot_W5RJ6AsrYA@mail.gmail.com>
Message-ID: <CAKv+Gu_2JBC5mx=4xqz3Rfr=m8O3RBh8j5Yxfot_W5RJ6AsrYA@mail.gmail.com>
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

On Mon, 2 Mar 2020 at 18:02, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Mon, Mar 02, 2020 at 05:57:04PM +0100, Ard Biesheuvel wrote:
> > On Mon, 2 Mar 2020 at 17:54, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Mon, Mar 02, 2020 at 08:49:17AM +0100, Ard Biesheuvel wrote:
> > > > On Mon, 2 Mar 2020 at 00:04, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > ...
> > > > >         call    1f
> > > > > -1:     pop     %ebp
> > > > > -       subl    $1b, %ebp
> > > > > +1:     pop     %ebx
> > > > > +       subl    $1b, %ebx
> > > ...
> > > > >
> > > > > +       movl    %ebx, %ebp                      // startup_32 for efi32_pe_stub_entry
> > > >
> > > > The code that follows efi32_pe_stub_entry still expects the runtime
> > > > displacement in %ebp, so we'll need to pass that in another way here.
> > > >
> > > > >         jmp     efi32_pe_stub_entry
> > >
> > > Didn't follow -- what do you mean by runtime displacement?
> > >
> > > efi32_pe_stub_entry expects the runtime address of startup_32 to be in
> > > %ebp, but with the changes for keeping the frame pointer in %ebp, I
> > > changed the runtime address to be in %ebx instead. Hence I added that
> > > movl %ebx, %ebp to put it in %ebp just before calling efi32_pe_stub_entry.
> > > That should be fine, no?
> >
> > But how does that work with:
> >
> > SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
> >     movl %ecx, efi32_boot_args(%ebp)
> >     movl %edx, efi32_boot_args+4(%ebp)
> >     movb $0, efi_is64(%ebp)
> >
> >
> > ?
>
> Why wouldn't it work? Before this change, efi32_pe_entry set %ebp to
> startup_32 (via the call/pop/sub sequence), so efi32_pe_stub_entry was
> entered with %ebp == startup_32.
>
> After this change, the call/pop/sub sequence puts startup_32 into %ebx,
> and then I copy it into %ebp just before branching to efi32_pe_stub_entry.
> So everything should continue to work the same way as before?

Ah ok, so the sequence

   call 1f
1: pop %ebp
   subl $1b, %ebp

happens to produce the value of startup_32, which is obvious now that
I think of it, but it wasn't before.
