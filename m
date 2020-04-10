Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76DC21A4A1E
	for <lists+linux-efi@lfdr.de>; Fri, 10 Apr 2020 21:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgDJTED (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Apr 2020 15:04:03 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:46213 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgDJTED (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Apr 2020 15:04:03 -0400
Received: by mail-qv1-f68.google.com with SMTP id bu9so1383686qvb.13;
        Fri, 10 Apr 2020 12:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SFkGxqtAivlmP1kSIm6+6p6UaAADFeDKZ3fmGmbrPP4=;
        b=EMTd2UMAl56Aemho4y1bPbJP5nBQMSLteXHIQIuIoWFmlW+IfWompuKnPq5ZVm3NF4
         YIvi+8si+Q2/+Vn3qYeXOOJbZMolHK5gP5aonBIqNIUKpudyfdVgQW995QZm0eRUy3dR
         hlZMzpHcE2S5LmkO9p/kJn45N2v8Gx3LaoKth2eDuG7RhTH7fm27HVET9z9GjtkODUBF
         zdneMxSsONEF4yOWJzB9QH6+rC3n1M6oNx1Jv0g23xla2S0PlBlCptRsYGHxYZ61Dibf
         FP6OGkl2PriY92WGTrvoF3V5fSeib0ztAJYxt5ZtLvhY32NIAHMP4s1Q95+eSrYexaAF
         2L+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=SFkGxqtAivlmP1kSIm6+6p6UaAADFeDKZ3fmGmbrPP4=;
        b=qV5xjcL+BsGM5kPihWNitbo5R7ri338XrZBIp6GeArnuSqw00KVn5xCSIeMGIBDA+F
         oLXr4drkMuN+WPuzqmo/Wo+Y6rYNMgqWLgi9Y8w4icVfGH/K3GmHesthAm9VdpZ+AnM5
         0/S5GR4DwYeRKHlNAKRSzlk5hbwz90WkIVx6OJuykaMEvJiQaRAvAZAbIeHaSShV0Fk1
         Jxi3CdUaVoZ8FFaB3nC4567/OI/H9Nb3pcVmXEFLoLlWHNIps/fGLJjJH6lh8vSAmfLS
         stcKoBPLB8CsbWAvLZzYaH4KqmXCdDk02UDC+kP/60ec5ec9CEk43WpsnSbk9sYoayoJ
         w8yQ==
X-Gm-Message-State: AGi0PuavPCtOl6xIh8UVpxRXQKK40XG7lBYAlpDcE8VAGSRpr//DLTGC
        VrkfaIabqle0I8t16sYQP3M=
X-Google-Smtp-Source: APiQypJzbuvJQY0FtqjCzRMUlWsREiod30TngxIzTSzHMubOcr9lZ6n1DSaYCUYJOwXIohn4nIbwZQ==
X-Received: by 2002:ad4:43c1:: with SMTP id o1mr6566948qvs.56.1586545439433;
        Fri, 10 Apr 2020 12:03:59 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id q7sm2202362qti.58.2020.04.10.12.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 12:03:58 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 10 Apr 2020 15:03:56 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Brian Gerst <brgerst@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Gary Lin <glin@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Sergey Shatunov <me@prok.pw>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 3/9] efi/x86: Move efi stub globals from .bss to .data
Message-ID: <20200410190356.GA1213308@rani.riverdale.lan>
References: <20200409130434.6736-1-ardb@kernel.org>
 <20200409130434.6736-4-ardb@kernel.org>
 <CAMzpN2gJWwVun1Kp6vGuza9LM5KpB=0EwsP8x8eOJQuDGh38Hg@mail.gmail.com>
 <CAMzpN2jFbf8k99pWaTYRBmSB+iNAKYsufjEhqO6Vv0qxAcHyGA@mail.gmail.com>
 <20200409210847.GA1312580@rani.riverdale.lan>
 <CAMj1kXFhtK=FRDKBE5OtenNEtpK=kVwyo+0nqJZ_K80RmtYxEg@mail.gmail.com>
 <20200410151612.GA970420@rani.riverdale.lan>
 <CAMj1kXGMNMdgjinYNgrN2wGRFG4rKE2YHo-=3s4Ofv2KPUMqKQ@mail.gmail.com>
 <20200410180123.GA1155098@rani.riverdale.lan>
 <CAMj1kXGW6V8Zif7-95MbivNgtDoufVt=uMDtYuFvEJCzOub+sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGW6V8Zif7-95MbivNgtDoufVt=uMDtYuFvEJCzOub+sA@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Apr 10, 2020 at 08:03:15PM +0200, Ard Biesheuvel wrote:
> On Fri, 10 Apr 2020 at 20:01, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Fri, Apr 10, 2020 at 06:03:38PM +0200, Ard Biesheuvel wrote:
> > > On Fri, 10 Apr 2020 at 17:16, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > On Fri, Apr 10, 2020 at 10:20:42AM +0200, Ard Biesheuvel wrote:
> > > > > On Thu, 9 Apr 2020 at 23:08, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > > >
> > > > > > On Thu, Apr 09, 2020 at 04:53:07PM -0400, Brian Gerst wrote:
> > > > > > > > Can we use the -fno-zero-initialized-in-bss compiler flag instead of
> > > > > > > > explicitly marking global variables?
> > > > > > >
> > > > > > > Scratch that.  Apparently it only works when a variable is explicitly
> > > > > > > initialized to zero.
> > > > > > >
> > > > > > > --
> > > > > > > Brian Gerst
> > > > > >
> > > > > > Right, there doesn't seem to be a compiler option to turn off the use of
> > > > > > .bss altogether.
> > > > >
> > > > > Yeah. I'll try to come up with a way to consolidate this a bit across
> > > > > architectures (which is a bit easier now that all of the EFI stub C
> > > > > code lives in the same place). It is probably easiest to use a section
> > > > > renaming trick similar to the one I added for ARM (as Arvind suggested
> > > > > as well, IIRC), and get rid of the per-symbol annotations altogether.
> > > >
> > > > Does that work for 32-bit ARM, or does it need to be .data to tell the
> > > > compiler to avoid generating GOT references? If that's fine, we don't
> > > > actually need to rename sections -- linker script magic is enough. For
> > > > eg, the below pulls the EFI stub bss into .data for x86 without the need
> > > > for the annotations.
> > > >
> > > > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> > > > index 508cfa6828c5..e324819c95bc 100644
> > > > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > > > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > > > @@ -52,6 +52,7 @@ SECTIONS
> > > >                 _data = . ;
> > > >                 *(.data)
> > > >                 *(.data.*)
> > > > +               drivers/firmware/efi/libstub/lib.a:(.bss .bss.*)
> > > >                 _edata = . ;
> > > >         }
> > > >         . = ALIGN(L1_CACHE_BYTES);
> > >
> > > No, we can add this to ARM as well, and get rid of the
> > > __efistub_global annotations entirely.
> >
> > Cool.
> >
> > >
> > > We'll still need .data.efistub for the .data pieces, but that is a
> > > separate issue.
> >
> > You can avoid that by using an archive specification like above. i.e.
> > adding
> >         drivers/firmware/efi/libstub/lib.a:(.data .data.*)
> > to the .init.data output section will pull in just the .data input
> > sections from the EFI stub into the .init.data section.
> 
> Sure. But the ARM decompressor linker script currently discards .data
> before this point in the linker script, and relies on this as a safety
> net to ensure that no new .data items get added to the decompressor
> binary (which runs after the stub)

Ah.
