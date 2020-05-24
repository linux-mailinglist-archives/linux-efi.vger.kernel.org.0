Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E002B1DFDB2
	for <lists+linux-efi@lfdr.de>; Sun, 24 May 2020 10:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgEXImb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 24 May 2020 04:42:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbgEXIma (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 24 May 2020 04:42:30 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0557F207D8;
        Sun, 24 May 2020 08:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590309750;
        bh=sf8z0UjiPnonog6GK0bHV0LN7Xmm1JvGEb55h0+rYNs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BxG96CXUPSWUmRNkHl6HjVlkGh5/eUa8JFBIpmAn6/z/e3e5rsfje3HBa/AFqIJeJ
         aRGGqDsqnHSWjuxf2Xulqf3hsrSXGfhESLUQ2Ruu9ZqBhI2e8FUphT80zRfAwItRtb
         0wsByv02WtF2m5TjW0yWcNDpsaXa8YRMM9uBT6Ds=
Received: by mail-il1-f174.google.com with SMTP id m6so14864877ilq.7;
        Sun, 24 May 2020 01:42:29 -0700 (PDT)
X-Gm-Message-State: AOAM531LHen/5xiHqa+pgh33h8lqc9EKzmSIwnZhYf1KE0k+BBOa8sDv
        K6vCtNAbtqOk0jsFgRkmmcnyze8w0jAEaLjVBhU=
X-Google-Smtp-Source: ABdhPJyQ6Fg0YcOCssHHZTIP7zDTGlLO2oy6Gg5BafA6ko2vA4QKybLI4tw5YiFQmK1RXGgS64RfRq5TqWmiZIEVPho=
X-Received: by 2002:a92:3556:: with SMTP id c83mr18361004ila.218.1590309749379;
 Sun, 24 May 2020 01:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200523120021.34996-1-ardb@kernel.org> <20200523120021.34996-4-ardb@kernel.org>
 <20200523151758.GB1189358@rani.riverdale.lan>
In-Reply-To: <20200523151758.GB1189358@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 24 May 2020 10:42:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH6ekEbY9TVT+_3NmrGVdGO0yUVx6hvtu4Z-4+AMT0+WQ@mail.gmail.com>
Message-ID: <CAMj1kXH6ekEbY9TVT+_3NmrGVdGO0yUVx6hvtu4Z-4+AMT0+WQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] x86/boot/compressed: get rid of GOT fixup code
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 23 May 2020 at 17:18, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Sat, May 23, 2020 at 02:00:21PM +0200, Ard Biesheuvel wrote:
> > In a previous patch, we have eliminated GOT entries from the decompressor
> > binary and added an assertion that the .got section is empty. This means
> > that the GOT fixup routines that exist in both the 32-bit and 64-bit
> > startup routines have become dead code, and can be removed.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> > index 60a99dfb9d72..d91fdda51aa8 100644
> > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > @@ -43,9 +43,7 @@ SECTIONS
> >               _erodata = . ;
> >       }
> >       .got : {
> > -             _got = .;
> >               KEEP(*(.got))
> > -             _egot = .;
> >       }
> >       .got.plt : {
> >               KEEP(*(.got.plt))
> > --
> > 2.20.1
> >
>
> I think you can get rid of both the KEEP's here as well?

Yeah, they seem fairly pointless to me to begin with, given that these
contents are created by the linker on the fly, rather than passed
through from the input objects.

I'll drop them.
