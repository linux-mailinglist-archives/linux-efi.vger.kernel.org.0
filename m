Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF88B1A49A3
	for <lists+linux-efi@lfdr.de>; Fri, 10 Apr 2020 20:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDJSD2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Apr 2020 14:03:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgDJSD2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Apr 2020 14:03:28 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1524A2166E;
        Fri, 10 Apr 2020 18:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586541808;
        bh=o0yeAwze3E3yQZjTgN3vUEWdpFnF9kATlOjFbphUIn0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=US8ZGxZuPDUoyG4JkipL7zQrcRduZoNiSOSbZRkJidv8UK+m8T6QyT4VufLfHhvaV
         yM3oyc16cOkv1yNRuZ+6CwMLG5W4PInU1mNd4D/RdeUWJCrdhXcy3lvVlZ4k+3w/wb
         5vkQl5u0rdYfzgkWASLcBxuC92WL9hgdjnmqcGvs=
Received: by mail-il1-f179.google.com with SMTP id f16so2536959ilj.9;
        Fri, 10 Apr 2020 11:03:28 -0700 (PDT)
X-Gm-Message-State: AGi0PuYeXNx2CIPkJ91l7t6BTYmAMmR0wIymVwgqif8O43poAavLvsy0
        s1zMA8M4iJqSKiL9ZhOVyI5+AH+RnUZ+bk7UlBc=
X-Google-Smtp-Source: APiQypLHRcH2nfPxGMXwHRSRFz4Cu01FXq0ykDqS0zUjNuXtsLVA4Hm/sdM6EGDI3c333cVMLvEBp0/FdT2wKJ/Y4js=
X-Received: by 2002:a92:dcd1:: with SMTP id b17mr6283867ilr.80.1586541807369;
 Fri, 10 Apr 2020 11:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200409130434.6736-1-ardb@kernel.org> <20200409130434.6736-4-ardb@kernel.org>
 <CAMzpN2gJWwVun1Kp6vGuza9LM5KpB=0EwsP8x8eOJQuDGh38Hg@mail.gmail.com>
 <CAMzpN2jFbf8k99pWaTYRBmSB+iNAKYsufjEhqO6Vv0qxAcHyGA@mail.gmail.com>
 <20200409210847.GA1312580@rani.riverdale.lan> <CAMj1kXFhtK=FRDKBE5OtenNEtpK=kVwyo+0nqJZ_K80RmtYxEg@mail.gmail.com>
 <20200410151612.GA970420@rani.riverdale.lan> <CAMj1kXGMNMdgjinYNgrN2wGRFG4rKE2YHo-=3s4Ofv2KPUMqKQ@mail.gmail.com>
 <20200410180123.GA1155098@rani.riverdale.lan>
In-Reply-To: <20200410180123.GA1155098@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Apr 2020 20:03:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGW6V8Zif7-95MbivNgtDoufVt=uMDtYuFvEJCzOub+sA@mail.gmail.com>
Message-ID: <CAMj1kXGW6V8Zif7-95MbivNgtDoufVt=uMDtYuFvEJCzOub+sA@mail.gmail.com>
Subject: Re: [PATCH 3/9] efi/x86: Move efi stub globals from .bss to .data
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Brian Gerst <brgerst@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Gary Lin <glin@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Sergey Shatunov <me@prok.pw>, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 10 Apr 2020 at 20:01, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Fri, Apr 10, 2020 at 06:03:38PM +0200, Ard Biesheuvel wrote:
> > On Fri, 10 Apr 2020 at 17:16, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Fri, Apr 10, 2020 at 10:20:42AM +0200, Ard Biesheuvel wrote:
> > > > On Thu, 9 Apr 2020 at 23:08, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > >
> > > > > On Thu, Apr 09, 2020 at 04:53:07PM -0400, Brian Gerst wrote:
> > > > > > > Can we use the -fno-zero-initialized-in-bss compiler flag instead of
> > > > > > > explicitly marking global variables?
> > > > > >
> > > > > > Scratch that.  Apparently it only works when a variable is explicitly
> > > > > > initialized to zero.
> > > > > >
> > > > > > --
> > > > > > Brian Gerst
> > > > >
> > > > > Right, there doesn't seem to be a compiler option to turn off the use of
> > > > > .bss altogether.
> > > >
> > > > Yeah. I'll try to come up with a way to consolidate this a bit across
> > > > architectures (which is a bit easier now that all of the EFI stub C
> > > > code lives in the same place). It is probably easiest to use a section
> > > > renaming trick similar to the one I added for ARM (as Arvind suggested
> > > > as well, IIRC), and get rid of the per-symbol annotations altogether.
> > >
> > > Does that work for 32-bit ARM, or does it need to be .data to tell the
> > > compiler to avoid generating GOT references? If that's fine, we don't
> > > actually need to rename sections -- linker script magic is enough. For
> > > eg, the below pulls the EFI stub bss into .data for x86 without the need
> > > for the annotations.
> > >
> > > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> > > index 508cfa6828c5..e324819c95bc 100644
> > > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > > @@ -52,6 +52,7 @@ SECTIONS
> > >                 _data = . ;
> > >                 *(.data)
> > >                 *(.data.*)
> > > +               drivers/firmware/efi/libstub/lib.a:(.bss .bss.*)
> > >                 _edata = . ;
> > >         }
> > >         . = ALIGN(L1_CACHE_BYTES);
> >
> > No, we can add this to ARM as well, and get rid of the
> > __efistub_global annotations entirely.
>
> Cool.
>
> >
> > We'll still need .data.efistub for the .data pieces, but that is a
> > separate issue.
>
> You can avoid that by using an archive specification like above. i.e.
> adding
>         drivers/firmware/efi/libstub/lib.a:(.data .data.*)
> to the .init.data output section will pull in just the .data input
> sections from the EFI stub into the .init.data section.

Sure. But the ARM decompressor linker script currently discards .data
before this point in the linker script, and relies on this as a safety
net to ensure that no new .data items get added to the decompressor
binary (which runs after the stub)
