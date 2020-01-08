Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8165D13469F
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2020 16:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgAHPsF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jan 2020 10:48:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54098 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgAHPsF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Jan 2020 10:48:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id m24so3001877wmc.3
        for <linux-efi@vger.kernel.org>; Wed, 08 Jan 2020 07:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KrHsQAP0a9eh1NM9sOVdFPeaeyaEh108A3v2h0i3x0E=;
        b=be/0HgREopOPW+2tP9ai/6DG9k194a1evqoodK9bIBc3vz7RTuMFmpvx7YvMURM5+j
         /WfI9/uYzboJbd4o0O0nLDJ9+DcfHOY4/XH6QArnNld2yqZas8y3GJqdqqy1reHM3uMs
         M0dIbzPeNLNZrbUYAHWfYJEsssmZPAGKUi0ggzMFLAxOg86ZjaZifHm0/KHB+isTebos
         bHnq13duf8YWMA+Zhg/OuOjEy86QXkuphb9cZXKwnkcQIuumgHLIPPjMQDnC9bD66Lox
         018PiSNZ1dXZhSEWycjVxWW7z+2AeT6M8LODMD+KI0/cY0Lz2dWIhYD3vFGVpuiqu7LO
         s4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KrHsQAP0a9eh1NM9sOVdFPeaeyaEh108A3v2h0i3x0E=;
        b=E4ouVDG2RYTY8QiPb76GtZ4Mw9bEqmm/BkWU/vmKeGXzNqh1q+cbDEbPj4O+557usy
         5XA632ck2wa0tBCjlQAOL8DF4w3F1rJ7bhv8vzpWgQcy9/KBkNw+ZrrN0SYf9gosFxGE
         mazETvxEhuDwo8M43I1TFOU3ivt1ykL62/iinImMs3AJW0iLAaEsYFEH3ZQ2VU1cRNFO
         AQCnGZn3WbCwYzUERasoqs3dBJXRK72GIcMkcKH0W1k2J22YCsUHrlkVPWBbRnUtksmO
         MYdiy37baYKFl5VGuCWUw7wFSXCocaYCHLrKdHecA0feuugeqTNjB19FsCwpNa7gZZYn
         3GnQ==
X-Gm-Message-State: APjAAAUEiJLc0WbxEWufsK5HoCMpS/XzwQxH3olUT1iyw+J2DNTkJpnE
        pUc+QfNltit4i/2euxeA1xOWRtaRkN/Jt6Z1Kcukdg==
X-Google-Smtp-Source: APXvYqwKFiQyMCwL4AAPWd45y4MGjnhAiXJlP/5iP6Dw1GbxR2/pOuvKAU+O8dyrtdNHiAG2Ca7K6Fn60xTPEWb6G2A=
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr4477316wma.95.1578498482821;
 Wed, 08 Jan 2020 07:48:02 -0800 (PST)
MIME-Version: 1.0
References: <20200108102304.25800-1-ardb@kernel.org> <20200108102304.25800-3-ardb@kernel.org>
 <20200108154031.GA2512498@rani.riverdale.lan>
In-Reply-To: <20200108154031.GA2512498@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 8 Jan 2020 16:47:51 +0100
Message-ID: <CAKv+Gu8AOukQL3qokt+Rz3PKBRWWnSULGUr=+yxg_HPM8-uodw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] x86/boot/compressed: force hidden visibility for
 all symbol references
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 8 Jan 2020 at 16:40, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Jan 08, 2020 at 11:23:03AM +0100, Ard Biesheuvel wrote:
> > Eliminate all GOT entries in the decompressor binary, by forcing hidden
> > visibility for all symbol references, which informs the compiler that
> > such references will be resolved at link time without the need for
> > allocating GOT entries.
> >
> > To ensure that no GOT entries will creep back in, add an assertion to
> > the decompressor linker script that will fire if the .got section has
> > a non-zero size.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/compressed/Makefile      |  1 +
> >  arch/x86/boot/compressed/hidden.h      | 19 +++++++++++++++++++
> >  arch/x86/boot/compressed/vmlinux.lds.S |  1 +
> >  3 files changed, 21 insertions(+)
> >
> > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > index 56aa5fa0a66b..361df91b2288 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -39,6 +39,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
> >  KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
> >  KBUILD_CFLAGS += -Wno-pointer-sign
> >  KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
> > +KBUILD_CFLAGS += -include hidden.h
> >
>
> This should be added to drivers/firmware/efi/libstub as well in case
> future code changes bring in global references there?

The EFI stub already sets the hidden visibility attribute for the few
external symbol references that it contains, so it is not needed in
the context of this series.

In the future, we can revisit this if we want to get rid of the
various __pure getter functions, but that requires thorough testing on
other architectures and toolchains, so I'd prefer to leave that for
later.
