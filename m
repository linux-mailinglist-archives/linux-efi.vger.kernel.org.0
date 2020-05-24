Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495061DFFBC
	for <lists+linux-efi@lfdr.de>; Sun, 24 May 2020 17:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgEXPOb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 24 May 2020 11:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgEXPOb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 24 May 2020 11:14:31 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF56FC061A0E;
        Sun, 24 May 2020 08:14:30 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f5so6382512wmh.2;
        Sun, 24 May 2020 08:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oziPQ2XbXOvI/olxc4gQtwWvXNbQonx0M809pCxssE8=;
        b=VxCPXpELeZl8kz/PBPmi7B032uBR5oPR1bicbh/3Qv5VmPfgZnbxCBIPNr/qHqJyCj
         2oFRQHwAZmsVA3ZI100YaPrhOHPzcu1hb3eZuLyk3aIIBKppNAErDxW/wvWDmiAnYecU
         WXV38XVh6Q9yZOoAKpeS8xPWzPG0QtDndCJQHCfX9toOV++IXYdmKlR6ExoFfgzqA4qk
         tME2M8s+Po5PxnZD9xzC6h9RNlcKl7W4E7DK5TjWqPOeJn78QVSSLvlkHzHffHAkKF4W
         SqlC74pTAZXwGBdYOTbQA02XUKa1mTDfIgTnvMUTeK5EAqgBJq3eIyJ/kX4EoSrjyckt
         Jy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=oziPQ2XbXOvI/olxc4gQtwWvXNbQonx0M809pCxssE8=;
        b=jYV3gT3ydS5SXHxnS2gpfuKx/q9FjMu/m9q7SyPvVD7ZlbI4MfPy+Q0uoU1RKtcv8C
         WrAdRCATyCPQ9d9GaxzdQm4fXjZJcaNlfj/cq44FxhujTrGApZKac7CUaUw67pwlATIM
         JFFa/PnV6g53E90PhXDDf+2bqoR1qNTSagTW/4uRZpWrfccZMlpt0M75UDFf8nXaQefz
         Js5osjUkLIQA04Gpseg/0YKaxSp95+BojmLerRq6M0FmX/1FmX1l58Cr3S2ichd337WY
         hrGljq9t0kxe0uuvcMvmjStNa26pqv9bv7xHSgpfR6jRhWgjw98pikVMzTt2dtlrE4ys
         gG2A==
X-Gm-Message-State: AOAM53211n7nYx+OfM50+UxLWqmp9ACfGn6xtohhjghNzvO8hoEbV+Jc
        E5snHeRLwwtMMamHp4mnGYyE8oin
X-Google-Smtp-Source: ABdhPJzrqh4z4YD46R8QPVHIiEf6MfWwUUAEBC74EIlhA9p7YwURUOV7Ilc65q4gA2PKfs1nbxz0Cg==
X-Received: by 2002:a05:600c:293:: with SMTP id 19mr22369589wmk.71.1590333268550;
        Sun, 24 May 2020 08:14:28 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id q15sm14588318wrf.87.2020.05.24.08.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 08:14:27 -0700 (PDT)
Date:   Sun, 24 May 2020 17:14:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v2 1/3] x86/boot/compressed: move .got.plt entries out of
 the .got section
Message-ID: <20200524151426.GC11617@gmail.com>
References: <20200523120021.34996-1-ardb@kernel.org>
 <20200523120021.34996-2-ardb@kernel.org>
 <20200524150841.GA11617@gmail.com>
 <CAMj1kXFy8XebtAhAnO3fn3UBOsLR65KJ2GOLhC2PJmB8BKEe7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFy8XebtAhAnO3fn3UBOsLR65KJ2GOLhC2PJmB8BKEe7g@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> On Sun, 24 May 2020 at 17:08, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > > The .got.plt section contains the part of the GOT which is used by PLT
> > > entries, and which gets updated lazily by the dynamic loader when
> > > function calls are dispatched through those PLT entries.
> > >
> > > On fully linked binaries such as the kernel proper or the decompressor,
> > > this never happens, and so in practice, the .got.plt section consists
> > > only of the first 3 magic entries that are meant to point at the _DYNAMIC
> > > section and at the fixup routine in the loader. However, since we don't
> > > use a dynamic loader, those entries are never populated or used.
> > >
> > > This means that treating those entries like ordinary GOT entries, and
> > > updating their values based on the actual placement of the executable in
> > > memory is completely pointless, and we can just ignore the .got.plt
> > > section entirely, provided that it has no additional entries beyond
> > > the first 3 ones.
> > >
> > > So add an assertion in the linker script to ensure that this assumption
> > > holds, and move the contents out of the [_got, _egot) memory range that
> > > is modified by the GOT fixup routines.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/x86/boot/compressed/vmlinux.lds.S | 13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> > > index 0dc5c2b9614b..ce3fdfb93b57 100644
> > > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > > @@ -44,10 +44,13 @@ SECTIONS
> > >       }
> > >       .got : {
> > >               _got = .;
> > > -             KEEP(*(.got.plt))
> > >               KEEP(*(.got))
> > >               _egot = .;
> > >       }
> > > +     .got.plt : {
> > > +             KEEP(*(.got.plt))
> > > +     }
> > > +
> > >       .data : {
> > >               _data = . ;
> > >               *(.data)
> > > @@ -75,3 +78,11 @@ SECTIONS
> > >       . = ALIGN(PAGE_SIZE);   /* keep ZO size page aligned */
> > >       _end = .;
> > >  }
> > > +
> > > +#ifdef CONFIG_X86_64
> > > +ASSERT (SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
> > > +     "Unexpected GOT/PLT entries detected!")
> > > +#else
> > > +ASSERT (SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc,
> > > +     "Unexpected GOT/PLT entries detected!")
> > > +#endif
> >
> > Cool debugging check!
> >
> > Minor consistent-style nit:
> >
> > s/ASSERT (
> >  /ASSERT(
> >
> 
> ok
> 
> > Optional: maybe even merge these on a single line, as a special exception to the col80 rule?
> >
> >  #ifdef CONFIG_X86_64
> >  ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
> >  #else
> >  ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) ==  0xc, "Unexpected GOT/PLT entries detected!")
> >  #endif
> >
> > But fine either way.
> >
> 
> SIZEOF(.got.plt) <= 0x18
> 
> could be used as well, given that the section is either empty, or has
> at least the 3 magic entries.

This this has bitten us before, so I think the precise assert is better.

Two-line version is OK too.

Thanks,

	Ingo
