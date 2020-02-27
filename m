Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32A2B17229F
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 16:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgB0PyZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Feb 2020 10:54:25 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:36377 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgB0PyZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 27 Feb 2020 10:54:25 -0500
Received: by mail-qv1-f66.google.com with SMTP id ff2so1757048qvb.3;
        Thu, 27 Feb 2020 07:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nN5StkZhBPB1bomAet4pyT21cw9J/HKtdZwKDjPE0eg=;
        b=rvLmXyZA/IxBS1OlS3qfN8VToBe8emDsE+K8JoTaGl1JKc33elugYxpKdpPxVbFnPh
         8Ph2lPelrcldDYtbLwP4KWQNLuYW5jRQeRxbJ4W5FtcvJBViIfPHTzmk9kJyu8xyJTUn
         kz+83cmMFpIYqPv2I/AbU4aT+VIp9mKjpI3Qa0sAFkeUay03MjeGpQ/mU6AORIlPYheh
         zdYYU5XcJFWuFt6VCeBgEzNLraQG9Atoyk+pAzAmsetEuY0uBvDXTIwQDSA02oyoCnBo
         JC/m0HQdJs8LyWbLAIiqQujUbBakz6MzqmBmbDgXA7aKRHmvVSJWIt1EX+R71ztEc0Si
         iHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nN5StkZhBPB1bomAet4pyT21cw9J/HKtdZwKDjPE0eg=;
        b=HA27MA8gB9TK9XVO8qLO2mp0bTBUEaT2QKmTF6WvzJC1eLYUeb7LJB0nzyDBIIkqMd
         V84mTIOXLXLw30MWdbpF7UOqXUyGTWATh5VqQ0URFK6JpX77dxkpRFWKDkk5Hmpgfruh
         dBSflWXmZmmbBPM1O8a0+/+XheuTqTEDaCs32gsDQ7evt5/hrwuM+WBEKA4VSm7WrICl
         pA/PRQA+0lCX2v2KrVqWubX0isMyXQBlGwbN+q4fFrLLMuqTZuD4AGlCm/Xo1cEGkDp3
         u8xMrdHXyD+PaksMRE+6sc0XdprHnnxAbo0PY6Rbv/J5kKvrQS0llIrEr/+AgsIHbOPW
         C54A==
X-Gm-Message-State: APjAAAWHCnzlzZ5FzJE5Nzd3tYdzKruflCj7SjNI3TH0EJqsu31LeauA
        4V3/1Mf5h7aehj5uOqfjNbk=
X-Google-Smtp-Source: APXvYqzrUJfmfU6iKq2qxt23kKeEvf1D0g3jKD0dYzq5Ct834YUIZuQ/t8akVLD9C3g1MSGYhqDgdA==
X-Received: by 2002:ad4:57b1:: with SMTP id g17mr287092qvx.167.1582818864130;
        Thu, 27 Feb 2020 07:54:24 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v9sm3221613qkv.79.2020.02.27.07.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 07:54:23 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 27 Feb 2020 10:54:22 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 1/1] x86/boot/compressed: Fix reloading of GDTR
 post-relocation
Message-ID: <20200227155421.GA3507597@rani.riverdale.lan>
References: <20200226204515.2752095-1-nivedita@alum.mit.edu>
 <20200226230031.3011645-2-nivedita@alum.mit.edu>
 <20200227081229.GA29411@gmail.com>
 <20200227151643.GA3498170@rani.riverdale.lan>
 <CAKv+Gu8BiW6P6Xv3EAPUEmbS3GQMJW=eRr-yygRbForaGDQyyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8BiW6P6Xv3EAPUEmbS3GQMJW=eRr-yygRbForaGDQyyw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 27, 2020 at 04:21:32PM +0100, Ard Biesheuvel wrote:
> On Thu, 27 Feb 2020 at 16:16, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Thu, Feb 27, 2020 at 09:12:29AM +0100, Ingo Molnar wrote:
> > >
> > > * Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > > Commit ef5a7b5eb13e ("efi/x86: Remove GDT setup from efi_main")
> > > > introduced GDT setup into the 32-bit kernel's startup_32, and reloads
> > > > the GDTR after relocating the kernel for paranoia's sake.
> > > >
> > > > Commit 32d009137a56 ("x86/boot: Reload GDTR after copying to the end of
> > > > the buffer") introduced a similar GDTR reload in the 64-bit kernel.
> > > >
> > > > The GDTR is adjusted by init_size - _end, however this may not be the
> > > > correct offset to apply if the kernel was loaded at a misaligned address
> > > > or below LOAD_PHYSICAL_ADDR, as in that case the decompression buffer
> > > > has an additional offset from the original load address.
> > > >
> > > > This should never happen for a conformant bootloader, but we're being
> > > > paranoid anyway, so just store the new GDT address in there instead of
> > > > adding any offsets, which is simpler as well.
> > > >
> > > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > > Fixes: ef5a7b5eb13e ("efi/x86: Remove GDT setup from efi_main")
> > > > Fixes: 32d009137a56 ("x86/boot: Reload GDTR after copying to the end of the buffer")
> > >
> > > Have you or anyone else observed this condition practice, or have a
> > > suspicion that this could happen - or is this a mostly theoretical
> > > concern?
> > >
> > > Thanks,
> > >
> > >       Ingo
> >
> > Right now it's a theoretical concern.
> >
> > I'm working on another patch, to tell the EFI firmware PE loader what
> > the kernel's preferred address is, so that we can avoid having to
> > relocate the kernel in the EFI stub in most cases (ie if the PE loader
> > manages to load us at that address). With those changes, the required
> > adjustment won't be init_size - _end any more, and while fixing it up
> > there, I noticed that it could already be the case that the required
> > adjustment is different.
> >
> 
> Do you mean setting the image address in the PE/COFF header to the
> preferred address?

Yep. I'm doing that and then making a few adjustments to the PE entry
code and head_* so that it can decompress starting at image_base instead
of startup_32.
