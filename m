Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367ED1FBE76
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jun 2020 20:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgFPSuy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Jun 2020 14:50:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728561AbgFPSuy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 16 Jun 2020 14:50:54 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11CE120707
        for <linux-efi@vger.kernel.org>; Tue, 16 Jun 2020 18:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592333454;
        bh=O7vZuAmkBHyDfvXKfV7YeS+ulDpkeBw8K2YeQuTOSKI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cq5UcLyY4Rhm5B8kOgVPyoA0Az/5xswFziXVt0OczUOvTq2P+Ll51IhJALVBMn04t
         L6oBJoglxV/Bg7RIqbu1v5r67EGd8hHdWlTg5nwy/BwdQVCqng91gAEnPkiBvNMvQj
         E2whKvW5NoNxnsSlcuk39c+xZGgeT9LhjAUgKBkY=
Received: by mail-ot1-f49.google.com with SMTP id 97so16794539otg.3
        for <linux-efi@vger.kernel.org>; Tue, 16 Jun 2020 11:50:54 -0700 (PDT)
X-Gm-Message-State: AOAM532OWhzj9Q3clplUzOZlYzv8I9lp9jKFjCD8Z8bmW6twSgnV8s19
        TNKu/aponMy9vX0Wwt9x/5FgBmmrkfz1aM2ubdM=
X-Google-Smtp-Source: ABdhPJxf/WqnONE16PqSfk11D474c0CwMMwZR2b6YqvQ3YBmuDiWdHZapBSW4vfN6yL1bmkA3F9LYKcMPtyaAHwcDvk=
X-Received: by 2002:a9d:42e:: with SMTP id 43mr3696498otc.108.1592333453354;
 Tue, 16 Jun 2020 11:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200526170226.2371024-1-nivedita@alum.mit.edu>
 <20200526170226.2371024-2-nivedita@alum.mit.edu> <CAMj1kXFGubFssfb1K_KUGXHhwF1X-vsL+ENYHU4EtbEXCTsQXw@mail.gmail.com>
 <20200615155605.GA672028@rani.riverdale.lan> <20200616184830.GA1581658@rani.riverdale.lan>
In-Reply-To: <20200616184830.GA1581658@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 Jun 2020 20:50:41 +0200
X-Gmail-Original-Message-ID: <CAMj1kXELi+siUDH6g+_B3t77x3exobj2b1qQ-W4RMVY_DK1dhA@mail.gmail.com>
Message-ID: <CAMj1kXELi+siUDH6g+_B3t77x3exobj2b1qQ-W4RMVY_DK1dhA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/x86: Use firmware stack for mixed-mode EFI stub
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 16 Jun 2020 at 20:48, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Mon, Jun 15, 2020 at 11:56:05AM -0400, Arvind Sankar wrote:
> > On Mon, Jun 15, 2020 at 11:58:43AM +0200, Ard Biesheuvel wrote:
> > > On Tue, 26 May 2020 at 19:02, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > The UEFI specification requires a 128KiB stack during boot services. On
> > > > a native mode boot, the EFI stub executes on the firmware stack.
> > > > However, on a mixed-mode boot, startup_32 switches to the kernel's boot
> > > > stack, which is only 16KiB, and the EFI stub is executed with this
> > > > stack.
> > > >
> > > > To avoid any potential problems with running out of stack space, save
> > > > and restore the UEFI stack pointer in the mixed-mode entry, so that the
> > > > EFI stub can use the firmware stack in this case as well.
> > > >
> > > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > >
> > > This does not apply onto v5.8-rc1, and I was going to take it as a fix.
> > >
> >
> > This was based on the runtime-relocation removing patch series (see
> > cover letter).
> > https://lore.kernel.org/linux-efi/20200526170226.2371024-1-nivedita@alum.mit.edu/
> >
> > I can rework it to apply on mainline if we decide this patch could be
> > useful.
> >
> > > However, are we sure this is safe? Do we have a ballpark figure of how
> > > much stack we use in the stub?
> > >
> > > This is one of those things I am reluctant to change, given that we
> > > are not sure that firmware implementations conform to this, and IA32
> > > firmware was not designed to boot a 64-bit image (which might use more
> > > stack space?)
> > >
> >
> > The EFI stub code itself doesn't use much stack. The largest frame is
> > 720 bytes and the rest are below 300, so it probably doesn't even reach
> > 4k. The risk is really that inside the firmware it uses stack space more
> > liberally given it can assume it has 128KiB available. A safer
> > alternative would be to switch to the firmware stack only when actually
> > calling the firmware, inside the mixed-mode thunk.
>
> So one thing that mostly mitigates this is that the boot heap, which at
> this time would be unused, is right below the stack and is at least
> 64KiB in size. Taking that into account we really have 80KiB of stack
> available, so this might be fragile wrt future changes but right now
> it should be safe to run on the boot stack.
>
> >
> > Also, this patch fixed up one other small issue, which is that when we
> > enter via the compat 32-bit entry, we will call efi_pe_entry with a
> > misaligned stack (0 mod 16 instead of 8 mod 16). It gets correctly
> > aligned once efi_pe_entry finishes and calls efi_stub_entry though, so
> > most of the stub will still execute with proper alignment.
>
> Should I do a patch just for the alignment thing then?

Yes please. I am about to send some fixes to -tip so I'd like to
include it. The other issue can be dealt with for the next merge
window, and we can do some light testing first.
