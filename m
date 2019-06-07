Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B58FD39354
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2019 19:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbfFGRes (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jun 2019 13:34:48 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46916 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729629AbfFGRes (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jun 2019 13:34:48 -0400
Received: by mail-oi1-f195.google.com with SMTP id 203so1962848oid.13
        for <linux-efi@vger.kernel.org>; Fri, 07 Jun 2019 10:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQDn4Bg8QjtLfMA6U30U1R3x+u2Sc8pJdpkvrhwxItg=;
        b=TiqYN4ZIeJIcZdyH76CPw/HVLGladFFX1TaVyA8d+bt91TPBoOj+Wl/qYIgyST2If0
         5Q53pA2tQdlIrIXAbCxchjf9ns3sci6CtmdDvUYrvO+YD3Ve5aaBvSMa9VMxmPhN4j3W
         Tn6nVuiG9Y78xQgJXKnl+5bg5ke1pBLB1GlQupAgv6HIX0F0U/aM7XPLV9VOXad4g4Lf
         LMgAgdHX6fzBlIhsSuKFqXCYO1qbZHMxYrPREEUVIDtZdlVAsMCCpwK3xKS/Lk71Awcd
         0pVr2y0nBr1ueHaxoR1TDFfUyDNALDL/sX3kpjnRhqFMhc9LDiPs7+I3miDoeZpWxW9D
         0NOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQDn4Bg8QjtLfMA6U30U1R3x+u2Sc8pJdpkvrhwxItg=;
        b=qzUgvOcAC0pHnH39mwuOiCFdFzysKcwtUWAQ5BJr9UneYEypCQRWp7PwjBqdlhVbqU
         a+rdgLIPJrNZf7t9P5ZHJPbl/k9K0xf5MdLvKp2OdkcSljnok1MRV1LPcftAU6EoOFC8
         d4XPSKsdRw1ZU3mUnohLQq/II85b3FUoBQNrqxuag6JS3AuKqfTQrbewxrx5Z79flIx8
         nHEnOy2a8PirIQSclJtOQAVsAT1uAVMcRCOfTYSa+QJyLiQpiFEne8dnZeuyoTfxFRNv
         ZgVDWx+ZYVa8wD9a3IVrejtfLkb0rzo6mMcPwTcjU8/ClQQVjK99CyYOG3DrU5yT4R1p
         1n/A==
X-Gm-Message-State: APjAAAWJFZOylOpoPvngSvKyAsYIVYa+kqNJkN0I0SQATkaWj4kj59D2
        6oXSDxf4iurTHExFXpn6DVY9TCUnbFkwWoAquCwKvA==
X-Google-Smtp-Source: APXvYqwxRH9b7zfmNokXa/MJtvxICynfiQZqc9XkLddgj7G1h1cazph56bWLcewkRjUHU4E05igOxqptPTcARwRwv5E=
X-Received: by 2002:aca:ec82:: with SMTP id k124mr1785826oih.73.1559928887822;
 Fri, 07 Jun 2019 10:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <155925716254.3775979.16716824941364738117.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155925718351.3775979.13546720620952434175.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu-J3-66V7UhH3=AjN4sX7iydHNF7Fd+SMbezaVNrZQmGQ@mail.gmail.com>
 <CAPcyv4g-GNe2vSYTn0a6ivQYxJdS5khE4AJbcxysoGPsTZwswg@mail.gmail.com>
 <CAKv+Gu83QB6x8=LCaAcR0S65WELC-Y+Voxw6LzaVh4FSV3bxYA@mail.gmail.com>
 <CAPcyv4hXBJBMrqoUr4qG5A3CUVgWzWK6bfBX29JnLCKDC7CiGA@mail.gmail.com>
 <CAKv+Gu_ZYpey0dWYebFgCaziyJ-_x+KbCmOegWqFjwC0U-5QaA@mail.gmail.com> <CAPcyv4jO5WhRJ-=Nz70Jc0mCHYBJ6NsHjJNk6AerwQXH43oemw@mail.gmail.com>
In-Reply-To: <CAPcyv4jO5WhRJ-=Nz70Jc0mCHYBJ6NsHjJNk6AerwQXH43oemw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 7 Jun 2019 10:34:36 -0700
Message-ID: <CAPcyv4gzhr57xa2MbR1Jk8EDFw-WLdcw3mJnEX9PeAFwVEZbDA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] x86, efi: Reserve UEFI 2.8 Specific Purpose Memory
 for dax
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kbuild test robot <lkp@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 7, 2019 at 8:23 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Jun 7, 2019 at 5:29 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
[..]
> > > #ifdef CONFIG_EFI_APPLICATION_RESERVED
> > > static inline bool is_efi_application_reserved(efi_memory_desc_t *md)
> > > {
> > >         return md->type == EFI_CONVENTIONAL_MEMORY
> > >                 && (md->attribute & EFI_MEMORY_SP);
> > > }
> > > #else
> > > static inline bool is_efi_application_reserved(efi_memory_desc_t *md)
> > > {
> > >         return false;
> > > }
> > > #endif
> >
> > I think this policy decision should not live inside the EFI subsystem.
> > EFI just gives you the memory map, and mangling that information
> > depending on whether you think a certain memory attribute should be
> > ignored is the job of the MM subsystem.
>
> The problem is that we don't have an mm subsystem at the time a
> decision needs to be made. The reservation policy needs to be deployed
> before even memblock has been initialized in order to keep kernel
> allocations out of the reservation. I agree with the sentiment I just
> don't see how to practically achieve an optional "System RAM" vs
> "Application Reserved" routing decision without an early (before
> e820__memblock_setup()) conditional branch.

I can at least move it out of include/linux/efi.h and move it to
arch/x86/include/asm/efi.h since it is an x86 specific policy decision
/ implementation for now.
