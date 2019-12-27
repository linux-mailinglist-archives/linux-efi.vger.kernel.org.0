Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8F2112B9D2
	for <lists+linux-efi@lfdr.de>; Fri, 27 Dec 2019 19:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfL0SN2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Dec 2019 13:13:28 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37675 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfL0SN2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Dec 2019 13:13:28 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so8852201wmf.2
        for <linux-efi@vger.kernel.org>; Fri, 27 Dec 2019 10:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qlBgU5bOhYWiNQgHz4lAqhmQ8GRjYhNhLw+Jcq2XTQk=;
        b=qQyYKvv7c4A3D4Oo7vZhjiuoh8b/ZLUBU8gMkmm0JHMctjBGQemrEmscvWBdMPRPF3
         RsunjA3oxeJC2BLpzVBu0CpsWCEhKFpsENmPTUH4o01JIvdp0PNrXuGMnkdmOvveGtZs
         +B8WKTWVAjj77mHvYFWG6O2Fdt0WGiaz8CI1wlLnSHiBO5hKiOynwBZxvX+HejXQ4XUX
         8edrAp7MhnPy3s/fUkX0+coNHfhY7vmPDlXJiAtIShXJxqsKLujPfVq6SjvxSvbH6BPh
         721Qpa27AmfAfVO6stn86Epef2VLw7m491JkFkEHA0bGLd5Cxu7XuDKUHBPUWXFGUqCM
         0Enw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qlBgU5bOhYWiNQgHz4lAqhmQ8GRjYhNhLw+Jcq2XTQk=;
        b=tsFjOYWwuKcuNcLi1hWSLK+eTRVk1P18G8TR6JWiatdy3o/yqC6GUvZ0hJxJ0MrIvI
         Sy8yAH+ERVqyHLDZRAEUHkaUhvKxExe3vHD+nzPl9wHtn1KWFP3PQJDiPjxnveMErcKX
         UNQPbsB7YBdzGGAC7rXzokC5k1q7gy9qQToo83EKbvKblohnu0R4ONwtGlNa5mLtP+bc
         HwkqHDsX0BSUbGizuyrYOAovjLRHjEKHNnwY3v0F+8QPopL4NkcgfQB/T+EIYU4nCgej
         EJLfpUm4Ldk2NGFsm7v7ZB946Ggyri2OudgQs69FL6Bbv3MtZKVCSwNEWRaSvyEPWBec
         lslA==
X-Gm-Message-State: APjAAAVzMR4G17ewUR3/37Mes2/n0rIOgHCGpWIFAJloJ73YwFX94XND
        sv3ICoB37t2ewhx3nWZhBvj/PuvmuTfOPGTi7cyc1kdXsEk=
X-Google-Smtp-Source: APXvYqw2hDwlMV14spbKc6uQ+fMI5Fxl8HyXZutuhAQ6oyavw5UGnBMMVSmDLfVkzOHcVtHE6hyrHZuGaetisN3VFdw=
X-Received: by 2002:a1c:7901:: with SMTP id l1mr19897144wme.67.1577470406338;
 Fri, 27 Dec 2019 10:13:26 -0800 (PST)
MIME-Version: 1.0
References: <20191226151407.29716-1-ardb@kernel.org> <20191226151407.29716-2-ardb@kernel.org>
 <20191227175155.GA584323@rani.riverdale.lan> <20191227180855.GB584323@rani.riverdale.lan>
In-Reply-To: <20191227180855.GB584323@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 27 Dec 2019 19:13:28 +0100
Message-ID: <CAKv+Gu-LeDgMFU-Hfuc7wDgNRmq2n0goJTuK6f8oahB_MGCc-g@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi/x86: simplify 64-bit EFI firmware call wrapper
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 27 Dec 2019 at 19:08, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Fri, Dec 27, 2019 at 12:51:56PM -0500, Arvind Sankar wrote:
> > On Thu, Dec 26, 2019 at 04:14:05PM +0100, Ard Biesheuvel wrote:
> > > The efi_call() wrapper used to invoke EFI runtime services serves
> > > a number of purposes:
> > > - realign the stack to 16 bytes
> > > - preserve FP register state
> > > - translate from SysV to MS calling convention.
> > >
> > > Preserving the FP register state is redundant in most cases, since
> > > efi_call() is almost always used from within the scope of a pair of
> > > kernel_fpu_begin()/_end() calls, with the exception of the early
> > > call to SetVirtualAddressMap() and the SGI UV support code. So let's
> > > add a pair of kernel_fpu_begin()/_end() calls there as well, and
> > > remove the unnecessary code from the assembly implementation of
> > > efi_call(), and only keep the pieces that deal with the stack
> > > alignment and the ABI translation.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/x86/platform/efi/efi_64.c      |  4 +++
> > >  arch/x86/platform/efi/efi_stub_64.S | 36 ++------------------
> > >  arch/x86/platform/uv/bios_uv.c      |  7 ++--
> > >  3 files changed, 11 insertions(+), 36 deletions(-)
> > >
> > > diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> > > index 03c2ed3c645c..3690df1d31c6 100644
> > > --- a/arch/x86/platform/efi/efi_64.c
> > > +++ b/arch/x86/platform/efi/efi_64.c
> > > @@ -84,6 +84,7 @@ pgd_t * __init efi_call_phys_prolog(void)
> > >
> > >     if (!efi_enabled(EFI_OLD_MEMMAP)) {
> > >             efi_switch_mm(&efi_mm);
> > > +           kernel_fpu_begin();
> > >             return efi_mm.pgd;
> > >     }
> > >
> > > @@ -141,6 +142,7 @@ pgd_t * __init efi_call_phys_prolog(void)
> > >     }
> > >
> > >     __flush_tlb_all();
> > > +   kernel_fpu_begin();
> > >     return save_pgd;
> > >  out:
> > >     efi_call_phys_epilog(save_pgd);
> > > @@ -158,6 +160,8 @@ void __init efi_call_phys_epilog(pgd_t *save_pgd)
> > >     p4d_t *p4d;
> > >     pud_t *pud;
> > >
> > > +   kernel_fpu_end();
> > > +
> > >     if (!efi_enabled(EFI_OLD_MEMMAP)) {
> > >             efi_switch_mm(efi_scratch.prev_mm);
> > >             return;
> >
> > Does kernel_fpu_begin/kernel_fpu_end need to be outside the efi_switch_mm?
> >
> > If there's an error in efi_call_phys_prolog during the old memmap code,
> > it will call efi_call_phys_epilog without having called
> > kernel_fpu_begin, which will cause an unbalanced kernel_fpu_end. Looks
> > like the next step will be a panic anyway though.
>
> Do we even need to save/restore the fpu state at this point in boot? The
> mixed-mode code path doesn't appear to be saving/restoring the XMM
> registers during SetVirtualAddressMap.

That is an excellent question, and I was hoping Andy or Ingo could
shed some light on that.

I tested without and it booted fine, and it does seem to me that there
should be very little to preserve given how early this call happens
(from efi_enter_virtual_mode() which gets called from start_kernel())
