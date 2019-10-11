Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36D63D430D
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2019 16:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfJKOiV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Oct 2019 10:38:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45433 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfJKOiV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Oct 2019 10:38:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id r5so12174336wrm.12
        for <linux-efi@vger.kernel.org>; Fri, 11 Oct 2019 07:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S3EXoewC8ZPtCv9nLggU0Zj9HWKeOk6ECJdLQvDSMxo=;
        b=UTdlK9x/vx8fveM4Ymm5qY3K5Zb9V6o6M4vzALGQPrWOzHaFr6hvnm1jwW8LrcgH7J
         dpkccxBxhP9m8hDIRPMZin+5PXvypVS8n97J3rneeBef1ZG1+KubdkC7TXVXeICgWVvk
         cTMHpkLRKWNC633al8dBhpTAazgDabazAr51o+/FiidGXKR4Z1J7yUtbfCZCBkiJWB79
         +33riSqX4ipriuOycPRBzA9fb+hzoUYV6oLVEFaRmAS3cB5pOy9PrmWv/AkKWW75+qqX
         p1nUobztl20ad++WMJf+rmyLxzoG4qfMXgOJTv4PalN8qrL+5aTzco5Wu6Ss2XSvpY7o
         63gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S3EXoewC8ZPtCv9nLggU0Zj9HWKeOk6ECJdLQvDSMxo=;
        b=XabgTF0lyTdzWvXin3+D1YOWGVDuGi3lZGT/WTWBA2DuGczY/0A702Bf3rBm0B3YSw
         oEykuRfEKrg33Y4dAgGVLfKrwSzmhViqEHMdEqQUFm56Ph7IIxIaJLEzq8By2/41fLR4
         VC/lu4LB1Zmvur2jTFQtnr0ZabugkXbewScrbdeFQBlF6hGApGledQ4Jglk6TBdb3+yV
         pqYGMKnIzRsKBJbHRiwn9hrDf1qr7ak9JhJeHMwbU3zDCQuTXvEDbipBnni3+QeB07Pb
         xOU65KGuqNN9Z/hgSDMajX5m2XRN9lDuyJ9FBmzsE0mhh8WMnwCMNt0cM/S+GCzuf3Yz
         28wA==
X-Gm-Message-State: APjAAAW7LAPsjA/KAKR3zKaXbfe4h95LSuR/CWSl62CbnZxwmY6zGG19
        IvpsfyysYc0GVnmeZ2AuvmNknsw02wpi4yAzdKqtlg==
X-Google-Smtp-Source: APXvYqxsxEzAf/2w0nVbCqmd0KII4ILHESmIMwZwa+BBIHCY8a/Dd5SoqYe5uWe55StmwOKEHhwCbkAbdrk1X0NHzh8=
X-Received: by 2002:a5d:6b0a:: with SMTP id v10mr12774249wrw.32.1570804698063;
 Fri, 11 Oct 2019 07:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <157066227329.1059972.5659620631541203458.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157066230358.1059972.1736585303527133478.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu8ih2RffZHdwAnHZicL_v8CxV9WnCy+uA1jSSyh58xapA@mail.gmail.com>
 <CAPcyv4iQ5Np3dDH=-a_7gPnWKBCHXGit2PN-h=Jw_eqj7Lb2BQ@mail.gmail.com>
 <CAKv+Gu9co_FTVYWNZsXF0H+fV1K76pZX4Yv11ANE6NwDBT3pBQ@mail.gmail.com>
 <CAPcyv4iCpA_a7272HXVwBY3NqR1RbyuoXbQOPWG2xFHgqN8-iA@mail.gmail.com>
 <CAKv+Gu-EOaEmiT_ZA8RBatWAWNVXnNgv-wLJSp5b-zhvof3D6g@mail.gmail.com> <CAPcyv4jHTrrfNnBNw_H_4wGWGsg1QF1582BcN-078K5KCBhNBA@mail.gmail.com>
In-Reply-To: <CAPcyv4jHTrrfNnBNw_H_4wGWGsg1QF1582BcN-078K5KCBhNBA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 11 Oct 2019 16:38:05 +0200
Message-ID: <CAKv+Gu-Y+0KjUj91N1WFZK=vR6CUKCtiNbQtYMxn2vY1Wh-_dg@mail.gmail.com>
Subject: Re: [PATCH v6 05/12] x86/efi: EFI soft reservation to E820 enumeration
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kbuild test robot <lkp@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 11 Oct 2019 at 16:35, Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Thu, Oct 10, 2019 at 10:52 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Fri, 11 Oct 2019 at 04:39, Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Thu, Oct 10, 2019 at 11:41 AM Ard Biesheuvel
> > > <ard.biesheuvel@linaro.org> wrote:
> > > >
> > > > On Thu, 10 Oct 2019 at 20:31, Dan Williams <dan.j.williams@intel.com> wrote:
> > > > >
> > > > > On Wed, Oct 9, 2019 at 11:45 PM Ard Biesheuvel
> > > > > <ard.biesheuvel@linaro.org> wrote:
> > > > > >
> > > > > > On Thu, 10 Oct 2019 at 01:19, Dan Williams <dan.j.williams@intel.com> wrote:
> > > > > > >
> > > > > > > UEFI 2.8 defines an EFI_MEMORY_SP attribute bit to augment the
> > > > > > > interpretation of the EFI Memory Types as "reserved for a specific
> > > > > > > purpose".
> > > > > > >
> > > > > > > The proposed Linux behavior for specific purpose memory is that it is
> > > > > > > reserved for direct-access (device-dax) by default and not available for
> > > > > > > any kernel usage, not even as an OOM fallback.  Later, through udev
> > > > > > > scripts or another init mechanism, these device-dax claimed ranges can
> > > > > > > be reconfigured and hot-added to the available System-RAM with a unique
> > > > > > > node identifier. This device-dax management scheme implements "soft" in
> > > > > > > the "soft reserved" designation by allowing some or all of the
> > > > > > > reservation to be recovered as typical memory. This policy can be
> > > > > > > disabled at compile-time with CONFIG_EFI_SOFT_RESERVE=n, or runtime with
> > > > > > > efi=nosoftreserve.
> > > > > > >
> > > > > > > This patch introduces 2 new concepts at once given the entanglement
> > > > > > > between early boot enumeration relative to memory that can optionally be
> > > > > > > reserved from the kernel page allocator by default. The new concepts
> > > > > > > are:
> > > > > > >
> > > > > > > - E820_TYPE_SOFT_RESERVED: Upon detecting the EFI_MEMORY_SP
> > > > > > >   attribute on EFI_CONVENTIONAL memory, update the E820 map with this
> > > > > > >   new type. Only perform this classification if the
> > > > > > >   CONFIG_EFI_SOFT_RESERVE=y policy is enabled, otherwise treat it as
> > > > > > >   typical ram.
> > > > > > >
> > > > > > > - IORES_DESC_SOFT_RESERVED: Add a new I/O resource descriptor for
> > > > > > >   a device driver to search iomem resources for application specific
> > > > > > >   memory. Teach the iomem code to identify such ranges as "Soft Reserved".
> > > > > > >
> > > > > > > A follow-on change integrates parsing of the ACPI HMAT to identify the
> > > > > > > node and sub-range boundaries of EFI_MEMORY_SP designated memory. For
> > > > > > > now, just identify and reserve memory of this type.
> > > > > > >
> > > > > > > Cc: <x86@kernel.org>
> > > > > > > Cc: Borislav Petkov <bp@alien8.de>
> > > > > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > > > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > > > > > Cc: Darren Hart <dvhart@infradead.org>
> > > > > > > Cc: Andy Shevchenko <andy@infradead.org>
> > > > > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > > > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > > > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > > > > > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > > > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > > >
> > > > > > For the EFI changes
> > > > > >
> > > > > > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > > > >
> > > > > > although I must admit I don't follow the enum add_efi_mode logic 100%
> > > > >
> > > > > I'm open to suggestions as I'm not sure it's the best possible
> > > > > organization. The do_add_efi_memmap() routine has the logic to
> > > > > translate EFI to E820, but unless "add_efi_memmap" is specified on the
> > > > > kernel command line the EFI memory map is ignored. For
> > > > > soft-reservation support I want to reuse do_add_efi_memmap(), but
> > > > > otherwise avoid any other side effects of considering the EFI map.
> > > > > What I'm missing is the rationale for why "add_efi_memmap" is required
> > > > > before considering the EFI memory map.
> > > > >
> > > > > If there is a negative side effect to always using the EFI map then
> > > > > the new "add_efi_mode" designation constrains it to just the
> > > > > soft-reservation case.
> > > > >
> > > >
> > > > Could we make the presence of any EFI_MEMORY_SP regions imply
> > > > add_efi_memmap? That way, it is guaranteed that we don't regress
> > > > existing systems, while establishing clear and unambiguous semantics
> > > > for new systems that rely on these changes in order to be able to use
> > > > the special purpose memory as intended.
> > >
> > > In fact that's how it works. EFI_MEMORY_SP is unconditionally added.
> > > Other EFI memory types are optionally added with the add_efi_memmap
> > > option.
> >
> > That is not what I meant.
> >
> > Why not behave as if 'add_efi_memmap' was passed if any EFI_MEMORY_SP
> > regions exist?
>
> Hmm, ok, on the assumption that any platform that is modern enough to
> specify EFI_MEMORY_SP likely does not need the opt-in?

Indeed.

> I can get on
> board with that. It's also simple enough to undo if it causes problems
> in practice.

Yes, and we'll only have one code path to reason about here.
