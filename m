Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83A3A14EA15
	for <lists+linux-efi@lfdr.de>; Fri, 31 Jan 2020 10:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbgAaJb6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 31 Jan 2020 04:31:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38915 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbgAaJb6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 31 Jan 2020 04:31:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so7763383wrt.6
        for <linux-efi@vger.kernel.org>; Fri, 31 Jan 2020 01:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mLBGb2WLyQpefTEAk03UvXKClrNpUQiN8+wISdHHFbI=;
        b=a5F+1HDfZlExmh7lDtMNM/s530e3sB6zYdvuadskEirmhDEMhnkPsxVMamYDE45JdT
         h5m0Mf3oxM/rd5cmE5cZQZwGiRmePE1NFgax2WjDcycNhWQjiO+B69wuZbTF3ch3CEF1
         fZ6hUEoHi4RKv0NsNatdnvuPhl0Ew5VrIoBX8v9HBn0UyEb3uGuDzV4DjRvwYJu4e8LY
         pwQH7xKdKjqUkP2nTvwGYCXVcrhWfzxPv5qH5EHdoL933pVPKC6DUm+vAPMsJHAPNhlj
         tX6trAjvzZggVGn5KXV4ak2fSCNvFdjA7GB0R8QvgECVknj3J/8F6ADECP9dJpxOYldo
         ONvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLBGb2WLyQpefTEAk03UvXKClrNpUQiN8+wISdHHFbI=;
        b=aSA2l+s/6dqbbFtGcnAgRvxLTsHfvAI2aSq/NJ/vsBaOEIKl2CO0TGC3tuQnfdDvFs
         xFs+i1Mir66CX2k9gzhLMMall4ndPQDQF9NZ01g7O4Jt222Oqcvm5EbYlCZrwLWNHsry
         CCdSG8F9PReqryKsUjNYBGgW4JePWjyJc0L0vzmHhTPw0xMqWX4haGocnx+a+oyBkM/t
         rMIlXjGQM9tdadJSTxsNUuTmTTZulY73G06o8/BfVfMye8t6U4hqBUvfUEDm92sxHl07
         8jKGSyk2dtMzl3ZWfv3FOM469x/ha8uDLLAisohWkAf37fRCqYwnN1lzTRlSRK0Z7SXi
         +GNw==
X-Gm-Message-State: APjAAAU+tuE5ZMmyNcGkoMSr8upX+rfGpgyBb9lEhJ9auhObY1lboJEU
        h2kaeJrgABLbf6Qf1Y7FPY3ECBiv9bb1nCUon2tzdQ==
X-Google-Smtp-Source: APXvYqzqlEnx4eFKjz2TemEprz/twMb6givxLylEaVIreeVs2/5dAN19bg3GFI8/ZEMr8gvUry2uF/c16tsXjSGkcDs=
X-Received: by 2002:adf:fd8d:: with SMTP id d13mr2250754wrr.208.1580463115772;
 Fri, 31 Jan 2020 01:31:55 -0800 (PST)
MIME-Version: 1.0
References: <20200130200440.1796058-1-nivedita@alum.mit.edu> <CAKv+Gu8JGC21R+ngSYtVxFDF7m2nvX=Opo1fkvdFSq-Fz_7B_Q@mail.gmail.com>
In-Reply-To: <CAKv+Gu8JGC21R+ngSYtVxFDF7m2nvX=Opo1fkvdFSq-Fz_7B_Q@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 31 Jan 2020 10:31:44 +0100
Message-ID: <CAKv+Gu_xw+0dJipX073ErZmJz7RVSn2ZK3SzK3HUDYhJoEOQyQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Remove 64-bit GDT setup in efi_main + doc fixes
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 31 Jan 2020 at 09:42, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> Thanks Arvind, this is good stuff.
>
>
> On Thu, 30 Jan 2020 at 21:04, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > For the 64-bit kernel, we do not need to setup a GDT in efi_main, as the
> > next step in the boot, startup_64, will set one up.
> >
>
> This seems obvious, but I need a nod from Ingo or Boris before I can take this.
>
> > This series factors out the GDT setup into a separate function and
> > restricts it to the 32-bit kernel. The memory allocation for the GDT is
> > also changed from allocating a full page via efi_alloc_low to the
> > required space (32 bytes) from alloc_pool boot service.
> >
>
> Can we go all the way and simply make this
>
> if (IS_ENABLED(CONFIG_X64_32)) {
>   static const struct desc_struct desc[] __aligned(8) = {
>     {}, /* The first GDT is a dummy. */
>     {}, /* Second entry is unused on 32-bit */
>     GDT_ENTRY_INIT(0xa09b, 0, 0xfffff), /* __KERNEL_CS */
>     GDT_ENTRY_INIT(0xc093, 0, 0xfffff), /* __KERNEL_DS */
>   };
>   struct desc_ptr gdt = { sizeof(desc) - 1, (unsigned long)desc };
>
>   native_load_gdt(&gdt);
> }
>
> (and drop the #defines from eboot.h that we no longer use)
>

Playing around with this a bit more, I think we should go with

if (IS_ENABLED(CONFIG_X86_32)) {
  static const struct desc_struct desc[] __aligned(8) = {
    [GDT_ENTRY_BOOT_CS] = GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
    [GDT_ENTRY_BOOT_DS] = GDT_ENTRY_INIT(0xc093, 0, 0xfffff),
  };

  native_load_gdt(&(struct desc_ptr){ sizeof(desc) - 1,
                                      (unsigned long)desc });
}


> > The final two patches are doc fixes to clarify that the 32-bit EFI
> > handover entry point also requires segments/GDT to be setup, and that
> > for 64-bit mode we don't have any special segment requirements (the
> > 64-bit doc currently is just a copy of the 32-bit doc which isn't
> > right).
> >
> > Arvind Sankar (8):
> >   efi/x86: Use C wrapper instead of inline assembly
> >   efi/x86: Allocate the GDT pointer on the stack
> >   efi/x86: Factor GDT setup code into a function
>
> Given the above, I don't think we need the separate function, but if
> we do, please drop the 64-bit code first, otherwise there is much more
> churn than necessary.
>
> >   efi/x86: Only setup the GDT for 32-bit kernel
> >   efi/x86: Allocate only the required 32 bytes for the GDT
> >   efi/x86: Change __KERNEL_{CS,DS} to __BOOT_{CS,DS}
> >   Documentation/x86/boot: Clarify segment requirements for EFI handover
> >   Documentation/x86/boot: Correct segment requirements for 64-bit boot
> >
> >  Documentation/x86/boot.rst              |  15 +-
> >  arch/x86/boot/compressed/eboot.c        | 174 ++++++++++--------------
> >  arch/x86/boot/compressed/efi_thunk_64.S |   4 +-
> >  3 files changed, 85 insertions(+), 108 deletions(-)
> >
> > --
> > 2.24.1
> >
