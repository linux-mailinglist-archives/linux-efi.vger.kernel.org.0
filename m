Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17F2B12B28B
	for <lists+linux-efi@lfdr.de>; Fri, 27 Dec 2019 09:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfL0IFq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Dec 2019 03:05:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35367 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfL0IFq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Dec 2019 03:05:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so7686555wmb.0
        for <linux-efi@vger.kernel.org>; Fri, 27 Dec 2019 00:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1mPYbH6xZ5CeWY+SMngsRfNebXSKoepwGF0VuFmgje0=;
        b=fHBEuV0a410Pt9x+QQYJb6onOr+7bspJ2y0abmJhlhSUGbSFLmCIRg54/ptfLw72JB
         l9EEQfVMD3AYNOye8+4rwEESHj3pUXzIZqvrqfguWkUI4fmeHAp4l+68AuSXNeIMHAcw
         UCUcABgr0M3OgptUrMnF7ZYJ/cUY9hax2v2Vd5UBILPlr2k3AISoIvu1xEgT/r1dAu7g
         desEvlPOjUMPIdgAmBSU8V0CGRCDeQH9oVk1DjKcgHmcB5t0sSmH3j2OgDaQX4/dYf58
         /oHdu4KJbLarYWVVhiCdAgqFEhF/PhDlPp6fuiEMKj3RdTOlDW3tf1e5c0HquPSEqAFc
         9COg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1mPYbH6xZ5CeWY+SMngsRfNebXSKoepwGF0VuFmgje0=;
        b=CRTSATtKXXLuGUq41QPqKg40aMLR+GAaTff/AEaT13SMtKgTLnb45L24Z9AitfdhYN
         V93wt7Of0xVF3dSR/OBHwDdvesIaRJ9rC3Wr3OYqrt75fXIs2lej4DHMtFM3Yvreld7k
         z/bljJOBft5WitXHLvtB0Y8TJSZRJdD0TB8+MWNfaEDTOWbdarMCydDfHs0E6Zk1Udco
         PnqrY3q7bIWCf7e3BC7Bh8UgVwFGLtT7R9k3OQomzlg1Sy0zIAXpdFiLeoYDshlA08yc
         r2w2xNYsjC4HdbiT+WeAPcnc0OLpf53OPG/crRQTJ9l9dVeiqj/I8wFC4m9brD+Icl55
         M3vQ==
X-Gm-Message-State: APjAAAUls1Yn6j961QDaQix752RMAKrMe55cMXUlL8gFQf9cnJFrhStt
        7N5/Uuk5iBtlcONNQp6pi6eHj/1TCmgqqftH8wXU1g==
X-Google-Smtp-Source: APXvYqyX9oWxCyXtqXtgD3peoD7VZdDkJMrVkQbmXMu6wYDgUzZG046ALmXgjonBxjBWN4pW0IqyB9mFynh3KtJdMbE=
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr17235241wma.95.1577433944020;
 Fri, 27 Dec 2019 00:05:44 -0800 (PST)
MIME-Version: 1.0
References: <20191226151407.29716-1-ardb@kernel.org> <20191226151407.29716-4-ardb@kernel.org>
 <20191227043424.GA435594@rani.riverdale.lan>
In-Reply-To: <20191227043424.GA435594@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 27 Dec 2019 09:05:46 +0100
Message-ID: <CAKv+Gu_xDqN-AyB=tp-JZWn6Ksv3cvpkgDhPL2NfiWTMEQNo1A@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi/x86: simplify mixed mode call wrapper
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 27 Dec 2019 at 05:34, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Dec 26, 2019 at 04:14:07PM +0100, Ard Biesheuvel wrote:
> > Calling 32-bit EFI runtime services from a 64-bit OS involves
> > switching back to the flat mapping with a stack carved out of
> > memory that is 32-bit addressable.
> >
> > There is no need to actually execute the 64-bit part of this
> > routine from the flat mapping as well, as long as the entry
> > and return address fit in 32 bits. There is also no need to
> > preserve part of the calling context in global variables: we
> > can simply preserve the old stack pointer in %r11 across the
> > call into 32-bit firmware, and use either stack to preserve
> > other values.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/platform/efi/efi_thunk_64.S | 106 ++++++--------------
> >  1 file changed, 29 insertions(+), 77 deletions(-)
> >
> > diff --git a/arch/x86/platform/efi/efi_thunk_64.S b/arch/x86/platform/efi/efi_thunk_64.S
> > index 3189f1394701..7357808d3ae8 100644
> > --- a/arch/x86/platform/efi/efi_thunk_64.S
> > +++ b/arch/x86/platform/efi/efi_thunk_64.S
> > +     /*
> > +      * Convert 32-bit status code into 64-bit.
> > +      */
> > +1:   btrl    $31, %eax
> > +     jb      3f
> > +2:   mov     %r11, %rsp
> >       pop     %rbx
> >       movl    %ebx, %ss
> >       pop     %rbx
> >       movl    %ebx, %es
> >       pop     %rbx
> >       movl    %ebx, %ds
> > -
> > -     /*
> > -      * Convert 32-bit status code into 64-bit.
> > -      */
> > -     test    %rax, %rax
> > -     jz      1f
> > -     movl    %eax, %ecx
> > -     andl    $0x0fffffff, %ecx
> > -     andl    $0xf0000000, %eax
> > -     shl     $32, %rax
> > -     or      %rcx, %rax
> > -1:
>
> Is it worth optimizing the conversion? The entire high nibble is
> significant according to the spec. It probably doesn't matter except in
> one potential case: according to the spec, transitioning secure boot
> status to setup mode by deleting the platform key is allowed to return
> EFI_WARN_RESET_REQUIRED and AFAICT this can take place after
> ExitBootServices?
>

In theory, yes. But all this code does is move the top bit from bit 31
to 63, which should be fine to convert any return code you may receive
from a runtime service.

> Separately, it might be worth considering moving the status translation
> into C instead of asm for the version in
> arch/x86/boot/compressed/efi_thunk_64.S -- there are (at least) three
> protocols that have methods that don't return efi_status_t:
> DEVICE_PATH_UTILITIES, DEVICE_PATH_TO_TEXT and DEVICE_PATH_FROM_TEXT. If
> we ever want to use them (eg for debugging), it might be worth having a
> thunk that doesn't mangle the return value.

Good point. I'll put that on my todo list.

Thanks,
Ard.
