Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED8501735F9
	for <lists+linux-efi@lfdr.de>; Fri, 28 Feb 2020 12:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgB1LVX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Feb 2020 06:21:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:55546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1LVX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Feb 2020 06:21:23 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4341D2084E
        for <linux-efi@vger.kernel.org>; Fri, 28 Feb 2020 11:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582888882;
        bh=UdTJgjEkFrekTJdyfPSyNniuUqPsPdCXDJhlN9tKGGc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WFc4IAN3eqyspBo1JbUiltnYpiERrQZiICQJfvx3GWzn2o0zlR/J8ZncZlNvVoRUC
         +wGLtzj2xAHJHFF8CwJ9aI4cN31YfuloFbJqB/JRpwTYvOntUQLoDZtnM4CT5Jba08
         k/J7M0MbhH4ahLgtRj4JD0yG1J1+Fjn1QaDsuExs=
Received: by mail-wm1-f53.google.com with SMTP id t23so2817805wmi.1
        for <linux-efi@vger.kernel.org>; Fri, 28 Feb 2020 03:21:22 -0800 (PST)
X-Gm-Message-State: APjAAAVDxU7Wytgl4nEU/eP0K7jpZeMXGHHooAOqqT2yk5vjVsZst8Tl
        Q0bUX4UFaV8mSJG+jhxz8jRXeYH5HvX+jlS6laN1Rg==
X-Google-Smtp-Source: APXvYqzjJz/p5hix51s8RaxNfNki0V8UbdgQMaKdXwIkKS8BO4ij4pFPm0BOcMmmP/GK73WeYb1NdaVZF0VJMg5GF6E=
X-Received: by 2002:a1c:bc46:: with SMTP id m67mr4297197wmf.40.1582888880767;
 Fri, 28 Feb 2020 03:21:20 -0800 (PST)
MIME-Version: 1.0
References: <20200228100244.10979-1-ardb@kernel.org> <20200228100244.10979-3-ardb@kernel.org>
 <20200228111450.GA36089@lakrids.cambridge.arm.com> <20200228111920.GB36089@lakrids.cambridge.arm.com>
In-Reply-To: <20200228111920.GB36089@lakrids.cambridge.arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 28 Feb 2020 12:21:09 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-f5Bxv7C8yG1-bbQ5f0_e5W99nEiQYiXSOdr2+WJOHDg@mail.gmail.com>
Message-ID: <CAKv+Gu-f5Bxv7C8yG1-bbQ5f0_e5W99nEiQYiXSOdr2+WJOHDg@mail.gmail.com>
Subject: Re: [PATCH efi-next 2/3] efi/arm64: clean EFI stub exit code from
 cache instead of avoiding it
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 28 Feb 2020 at 12:19, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Feb 28, 2020 at 11:14:50AM +0000, Mark Rutland wrote:
> > On Fri, Feb 28, 2020 at 11:02:43AM +0100, Ard Biesheuvel wrote:
> > > Commit 9f9223778 ("efi/libstub/arm: Make efi_entry() an ordinary PE/COFF
> > > entrypoint") modified the handover code written in assembler, and for
> > > maintainability, aligned the logic with the logic used in the 32-bit ARM
> > > version, which is to avoid cache maintenance on the remaining instructions
> > > in the subroutine that will be executed with the MMU and caches off, and
> > > instead, branch into the relocated copy of the kernel image.
> > >
> > > However, this assumes that this copy is executable, and this means we
> > > expect EFI_LOADER_DATA regions to be executable as well, which is not
> > > a reasonable assumption to make, even if this is true for most UEFI
> > > implementations today.
> > >
> > > So change this back, and add a __flush_dcache_area() call to cover the
> > > remaining code in the subroutine.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/arm64/kernel/efi-entry.S  | 18 +++++++++---------
> > >  arch/arm64/kernel/image-vars.h |  2 +-
> > >  2 files changed, 10 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/arch/arm64/kernel/efi-entry.S b/arch/arm64/kernel/efi-entry.S
> > > index 4cfd03c35c49..d5dee064975f 100644
> > > --- a/arch/arm64/kernel/efi-entry.S
> > > +++ b/arch/arm64/kernel/efi-entry.S
> > > @@ -19,7 +19,8 @@ ENTRY(efi_enter_kernel)
> > >      * point stored in x0. Save those values in registers which are
> > >      * callee preserved.
> > >      */
> > > -   mov     x19, x0                 // relocated Image address
> > > +   ldr     w2, =stext_offset
> > > +   add     x19, x0, x2             // relocated Image entrypoint
> > >     mov     x20, x1                 // DTB address
> > >
> > >     /*
> > > @@ -29,15 +30,14 @@ ENTRY(efi_enter_kernel)
> > >     ldr     w1, =kernel_size
> > >     bl      __flush_dcache_area
> > >     ic      ialluis
> > > -   dsb     sy
> > >
> > >     /*
> > > -    * Jump across, into the copy of the image that we just cleaned
> > > -    * to the PoC, so that we can safely disable the MMU and caches.
> > > +    * Flush the remainder of this routine to the PoC
> >
> > Minor nit, but could we please say 'Clean' rather than 'Flush' here?
> >
> > Even better, we now have __clean_dcache_area_poc(), and can use that
> > too.
>
> ... or if that's better as a subsequent cleanup for consistency, that'd
> also be fine, and needn't block this patch.
>

Thanks Mark. That sounds like a worthwhile improvement to fold in.
I'll need to add the __efistub_ alias for it, but I'm touching
image-vars.h in this patch anyway.
