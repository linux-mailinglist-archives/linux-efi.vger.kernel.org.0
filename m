Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E993812B286
	for <lists+linux-efi@lfdr.de>; Fri, 27 Dec 2019 09:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfL0IEQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Dec 2019 03:04:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37187 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfL0IEQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Dec 2019 03:04:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so12792085wru.4
        for <linux-efi@vger.kernel.org>; Fri, 27 Dec 2019 00:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DSiI8++NH656x/9lr0M0slZESemw5f2GZIJ+HDb33ZI=;
        b=m7MOOCItKadLMV2n9POMoPWTfFxfamg0fRiY1ze/9O+d5Gn32WfG6yVs8KUfUqEugJ
         YimBFJmXoVMd+RFzT50/9IklgGXfp7RRvywwdUyiccSG33myvsWm4wL1eVHNfq9sm7G2
         5hfYfNO8YI7PXM4ui8MVRI2IPOxAH93KdCKfIxAbvWfr47XEbOzmShnIJ8RG4ttxbsY1
         SPO5XNupmshLmf7MAc+uE6/lbM1zzrHiXhx4kxAv1dqlM71d81jBPFN7lbxgCNltDX6Y
         s7qkzQIas/Ij9ir8Q3ewoBf54PfBFcwkTy6vcZegtlVYI4ddCsHSULwBf2GYuunH2JQT
         AYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DSiI8++NH656x/9lr0M0slZESemw5f2GZIJ+HDb33ZI=;
        b=L9bONT+nD46hkN9umUULiJ4x/AmH97BBTjSu1+dscH8bDYPq+kXLXqUQt/dxuhRfOd
         HeywT9vNr/JViWcrCR+I+7Wjo9vToL/eZx9tIhdK4Tw+dS9I0HRsp68s/+kGLzRrsUuA
         2WVhUrgRHJLInWV1QGdG7Q0e5N1LbGqqAQ7zvO6N/EarHjuEwB8XTMXZELSCUSHi0fqG
         S7zX34K5JEHU1jm/34fdmnNGHTlK65p/MfWM8nIWN7i6mwB6fK5jU9lh+M6fxEI74QeV
         tQr1fdzzkqTlzzz8vURWfq3mL5AHjDl0mITCWf/mre/I8vDJA5QuLz6obmlNsS/ZverU
         Spgg==
X-Gm-Message-State: APjAAAVKxC0RrnmhLuaPoqXgwalJvP5bf3R3Inq2q0jd+HCBuyaJTPoD
        Lm2zhyErQxdfsluHuKc49YMOpSv6W98j6iJrDbqNAw==
X-Google-Smtp-Source: APXvYqzWfpKs0791QBCF8VJpOwsVXPNqslRiR4gTn7I/iuKwzCTvA7oM+mPM06qmxx/5MM3QWwZzptSxVSsNL+BFDPE=
X-Received: by 2002:a5d:6652:: with SMTP id f18mr50883142wrw.246.1577433853447;
 Fri, 27 Dec 2019 00:04:13 -0800 (PST)
MIME-Version: 1.0
References: <20191226151407.29716-1-ardb@kernel.org> <20191226151407.29716-4-ardb@kernel.org>
 <CALCETrWUv57ry+oy-65DSAOA62YM5okKMomFXHWgm_-5hUqTYg@mail.gmail.com>
In-Reply-To: <CALCETrWUv57ry+oy-65DSAOA62YM5okKMomFXHWgm_-5hUqTYg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 27 Dec 2019 09:04:15 +0100
Message-ID: <CAKv+Gu9QAanaouhRgz265ia-Vgf-zEYXNXxLVrunV-RjCGKbtA@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi/x86: simplify mixed mode call wrapper
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 27 Dec 2019 at 03:56, Andy Lutomirski <luto@kernel.org> wrote:
>
> On Thu, Dec 26, 2019 at 7:16 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
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
>
> The %r11 trick makes me a little bit nervous.  I can imagine a 32-bit
> firmware implementation clobbering r11 by one of a few means: SMM bugs
> (unlikely -- this would probably kill the system even outside of an
> EFI call) or, more likely, if some code module is actualy 64-bit.
> Maybe we shouldn't be worried about this.  More comments below.
>

I'll put it on the stack instead, just to be safe.

> > diff --git a/arch/x86/platform/efi/efi_thunk_64.S b/arch/x86/platform/efi/efi_thunk_64.S
> > index 3189f1394701..7357808d3ae8 100644
> > --- a/arch/x86/platform/efi/efi_thunk_64.S
> > +++ b/arch/x86/platform/efi/efi_thunk_64.S
> > @@ -28,11 +28,17 @@
> >  SYM_FUNC_START(efi64_thunk)
> >         push    %rbp
> >         push    %rbx
> > +       movl    %ds, %ebx
> > +       push    %rbx
> > +       movl    %es, %ebx
> > +       push    %rbx
> > +       movl    %ss, %ebx
> > +       push    %rbx
>
> I realize that you haven't actually changed any of the below, but this
> code has issues.
>
> You don't actually need to save %ss.  Loading KERNEL_DS is fine.  0
> would almost be fine, except that AMD CPUs have some oddities and the
> fallout would be subtle and annoying to debug.
>
> The kernel does not strictly guarantee that the selectors in DS and ES
> are always valid.  They're fairly likely to be valid when running
> syscalls, but code like this should not bet on it.  And the EFI thunk
> is missing exception handlers when it reloads them.  So the right
> thing to do is probably to get rid of all the segment handling in the
> asm for everything except CS and to move it into C, like:
>
> unsigned short ds, es;
>
> /* DS and ES contain user values.  We need to save them. */
> savesegment(ds, ds);
> savesegment(es, es);
>
> /* The 32-bit EFI code needs a valid DS, ES, and SS.  There's no need
> to save the old SS: __KERNEL_DS is always acceptable.  */
> loadsegment(ss, __KERNEL_DS);
> loadsegment(ds, __KERNEL_DS);
> loadsegment(es, __KERNEL_DS);
>
> __s = efi64_thunk(...);
>
> loadsegment(ds, ds);
> loadsegment(es, es);
>
> Want to make that change?

Sure.
