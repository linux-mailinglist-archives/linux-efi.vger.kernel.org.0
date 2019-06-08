Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C580F39B80
	for <lists+linux-efi@lfdr.de>; Sat,  8 Jun 2019 09:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfFHHU1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 8 Jun 2019 03:20:27 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55677 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfFHHU0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 8 Jun 2019 03:20:26 -0400
Received: by mail-it1-f194.google.com with SMTP id i21so6107314ita.5
        for <linux-efi@vger.kernel.org>; Sat, 08 Jun 2019 00:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NRFU6E8aoY/NG8zu/5ScI8y9YPKuPdWK6EZGoPFt9Ck=;
        b=NDyg19KRBwWKCsuIiFvg9iRfAOK0BFmH02/xvBLHZXW8TjkcbUXa07UNeCGFNRcVSQ
         8RbFmVpFH1UV2N+/j05HX8NIJQJMtjsgEKFE86KKcUhlfShKCx8Iz8dbQ9Vsx6tckJ5T
         rS+m/g1NYezNDmc1RO4A3Sgo+UodJa8hGFvDUEImNfqv0n+QszCBKoGTKvUhISzRtwkA
         Xb1wAh6WTP39KnlTRX4OirLbaYKQbvdRLkSl+jZyYeOtzDdqjdwK37E0w6E6cb4CmU/O
         DCw//CheJdpE6T4DkIGFn5i6qQUWUaZYBqkDJxVbCvsO0AZmxviK0yDSf2JLaX3ABS1p
         82Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NRFU6E8aoY/NG8zu/5ScI8y9YPKuPdWK6EZGoPFt9Ck=;
        b=smJ/rdE5AKaO83guG/QnqVtDlNKZpn9DZRwIxNFJ80czL3pFgixvo9VbSpKD2gIrig
         ucUEBylapbStZGd4kh4elzMfMSh2RjyY+tFkgDxmlvwNVdZ8iKBMnmMlTJ1mfgUpMrcR
         aXyrcZLPsHOq1OW0n/PtnNKCt4u6Pjl2DRTbeJVKUiAozLddxCzDuhAhnkQIXjyiwAsa
         /xbBq1OIpjxr4Tyg1QbtPhwEfp5rCi907Sq+GKly9nHlj8loxzh+UIdlcTqvU/EyCWpD
         BI5n7V36maH5Wrxs2m46DCAV9eY2UJWdmi/de/FWOxt6j+pvVpl5cJyJ1NXnwir9QjoN
         LHbw==
X-Gm-Message-State: APjAAAU5FXD45wx1qN14PkWll+YB5jO1szq6OJdX1Lt9k22qKL4bj7eb
        ogkehl3nn0ZB5awYZZ1zdWBBGOdm5qF71AktFx+EVw==
X-Google-Smtp-Source: APXvYqwnMZ8z1ON6onK6aLjM8baTZPCff6UnkQu1+3vja3H65nm9+6f6XC126h9UoGCw6NSPIu5HIfQvokO9SnkaUhk=
X-Received: by 2002:a24:4f88:: with SMTP id c130mr6512194itb.104.1559978425951;
 Sat, 08 Jun 2019 00:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <155925716254.3775979.16716824941364738117.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155925718351.3775979.13546720620952434175.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu-J3-66V7UhH3=AjN4sX7iydHNF7Fd+SMbezaVNrZQmGQ@mail.gmail.com>
 <CAPcyv4g-GNe2vSYTn0a6ivQYxJdS5khE4AJbcxysoGPsTZwswg@mail.gmail.com>
 <CAKv+Gu83QB6x8=LCaAcR0S65WELC-Y+Voxw6LzaVh4FSV3bxYA@mail.gmail.com>
 <CAPcyv4hXBJBMrqoUr4qG5A3CUVgWzWK6bfBX29JnLCKDC7CiGA@mail.gmail.com>
 <CAKv+Gu_ZYpey0dWYebFgCaziyJ-_x+KbCmOegWqFjwC0U-5QaA@mail.gmail.com>
 <CAPcyv4jO5WhRJ-=Nz70Jc0mCHYBJ6NsHjJNk6AerwQXH43oemw@mail.gmail.com> <CAPcyv4gzhr57xa2MbR1Jk8EDFw-WLdcw3mJnEX9PeAFwVEZbDA@mail.gmail.com>
In-Reply-To: <CAPcyv4gzhr57xa2MbR1Jk8EDFw-WLdcw3mJnEX9PeAFwVEZbDA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 8 Jun 2019 09:20:13 +0200
Message-ID: <CAKv+Gu_OcsWi5DqxOk-j6ovc0CMAZV37Od7zA5Bs4Ng5ATQxAA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] x86, efi: Reserve UEFI 2.8 Specific Purpose Memory
 for dax
To:     Dan Williams <dan.j.williams@intel.com>
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

On Fri, 7 Jun 2019 at 19:34, Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Jun 7, 2019 at 8:23 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Jun 7, 2019 at 5:29 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> [..]
> > > > #ifdef CONFIG_EFI_APPLICATION_RESERVED
> > > > static inline bool is_efi_application_reserved(efi_memory_desc_t *md)
> > > > {
> > > >         return md->type == EFI_CONVENTIONAL_MEMORY
> > > >                 && (md->attribute & EFI_MEMORY_SP);
> > > > }
> > > > #else
> > > > static inline bool is_efi_application_reserved(efi_memory_desc_t *md)
> > > > {
> > > >         return false;
> > > > }
> > > > #endif
> > >
> > > I think this policy decision should not live inside the EFI subsystem.
> > > EFI just gives you the memory map, and mangling that information
> > > depending on whether you think a certain memory attribute should be
> > > ignored is the job of the MM subsystem.
> >
> > The problem is that we don't have an mm subsystem at the time a
> > decision needs to be made. The reservation policy needs to be deployed
> > before even memblock has been initialized in order to keep kernel
> > allocations out of the reservation. I agree with the sentiment I just
> > don't see how to practically achieve an optional "System RAM" vs
> > "Application Reserved" routing decision without an early (before
> > e820__memblock_setup()) conditional branch.
>
> I can at least move it out of include/linux/efi.h and move it to
> arch/x86/include/asm/efi.h since it is an x86 specific policy decision
> / implementation for now.

No, that doesn't make sense to me. If it must live in the EFI
subsystem, I'd prefer it to be in the core code, not in x86 specific
code, since there is nothing x86 specific about it.

Perhaps a efi=xxx command line option would be in order to influence
the builtin default, but it can be a followup patch independent of
this series.
