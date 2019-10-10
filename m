Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFB1BD306A
	for <lists+linux-efi@lfdr.de>; Thu, 10 Oct 2019 20:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfJJSba (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Oct 2019 14:31:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33639 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfJJSba (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Oct 2019 14:31:30 -0400
Received: by mail-oi1-f194.google.com with SMTP id a15so5814815oic.0
        for <linux-efi@vger.kernel.org>; Thu, 10 Oct 2019 11:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NlpMtJuEn229jdoiy4a5lSiNwCR7W2uBuMkIb+tS29o=;
        b=ITKQdXgp39L1atnLKS6bIayQ9Oqf6ZZELR9iAOK+L6XNZQ850R0k4Wq+C591V98Nfl
         eOoLYUEr529lnsG7t+CJqDOS5QKMvY3XrF/SK6+tXNJNg9BD4lbBMGkxTzS4SKyjAfE0
         xn569nIeqCMhNH4Y4rymaQEIHqH3V4m13e6nSsG5/FZXD9RZfFwMJB/hw6j/PKD3ZN/T
         djeRQXbH/RMf0D99jQQukYrMlxitWBZJXoV4zOuD12m3Dx19MOOY6ReMOh+CphTJycow
         Kw4sFaD4DJMEw5ZE07VFRdG2QdsYJ/yuG3REItWbHzEMRGeorpswB7PBjNsPdMSJLG68
         yf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NlpMtJuEn229jdoiy4a5lSiNwCR7W2uBuMkIb+tS29o=;
        b=YEIZxrBgSRv/HfBYVBhrUnezU4ldEKKIhp62C5yu2TvYpmSN8vJSA+K3OZ8Pz+kaVg
         c+8CYNGTlEQhOK+LNooDAqA45TgubNStDi5Xik9KwQpuEEQE1/vKIHlZGgiNtXzALa16
         PMMtj65EoTL5KMOwjulVfGnFsIaN4c9dQkPq9t0v29ByCR/kvHjYjMbSV9crZVlrooZB
         9Rwk9TzpzTpCXFoOP0pN4UyW7U/YUTo+e3fBT/l/4eAXe8oTygQRf7oIrDcwOnHIexaL
         HbvrZ/TNDaC0sOa9G3Dyso6MqgQ/pM/LxlJ5YO87b6tG79Fg9MZTIIPnfIzg+1/K8Ajd
         uD/A==
X-Gm-Message-State: APjAAAXYQPnvc4TQrSDzEzn96ZnaRog0aBzdxLLr2Qhk8gnYDCFxt/o9
        7ddQCSLIzyousp3gRncmoZlVHx3qpV16F6GdChRehQ==
X-Google-Smtp-Source: APXvYqwfCh4W4PaSkjW/YpvNKY4Zzd3H20YtYmvM1Mygk9eFcMO2ybDevOXVp5f75aYzxtnTqkn5gtQosFy/farxU40=
X-Received: by 2002:aca:620a:: with SMTP id w10mr9068177oib.0.1570732289023;
 Thu, 10 Oct 2019 11:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <157066227329.1059972.5659620631541203458.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157066230358.1059972.1736585303527133478.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu8ih2RffZHdwAnHZicL_v8CxV9WnCy+uA1jSSyh58xapA@mail.gmail.com>
In-Reply-To: <CAKv+Gu8ih2RffZHdwAnHZicL_v8CxV9WnCy+uA1jSSyh58xapA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 10 Oct 2019 11:31:18 -0700
Message-ID: <CAPcyv4iQ5Np3dDH=-a_7gPnWKBCHXGit2PN-h=Jw_eqj7Lb2BQ@mail.gmail.com>
Subject: Re: [PATCH v6 05/12] x86/efi: EFI soft reservation to E820 enumeration
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
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

On Wed, Oct 9, 2019 at 11:45 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Thu, 10 Oct 2019 at 01:19, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > UEFI 2.8 defines an EFI_MEMORY_SP attribute bit to augment the
> > interpretation of the EFI Memory Types as "reserved for a specific
> > purpose".
> >
> > The proposed Linux behavior for specific purpose memory is that it is
> > reserved for direct-access (device-dax) by default and not available for
> > any kernel usage, not even as an OOM fallback.  Later, through udev
> > scripts or another init mechanism, these device-dax claimed ranges can
> > be reconfigured and hot-added to the available System-RAM with a unique
> > node identifier. This device-dax management scheme implements "soft" in
> > the "soft reserved" designation by allowing some or all of the
> > reservation to be recovered as typical memory. This policy can be
> > disabled at compile-time with CONFIG_EFI_SOFT_RESERVE=n, or runtime with
> > efi=nosoftreserve.
> >
> > This patch introduces 2 new concepts at once given the entanglement
> > between early boot enumeration relative to memory that can optionally be
> > reserved from the kernel page allocator by default. The new concepts
> > are:
> >
> > - E820_TYPE_SOFT_RESERVED: Upon detecting the EFI_MEMORY_SP
> >   attribute on EFI_CONVENTIONAL memory, update the E820 map with this
> >   new type. Only perform this classification if the
> >   CONFIG_EFI_SOFT_RESERVE=y policy is enabled, otherwise treat it as
> >   typical ram.
> >
> > - IORES_DESC_SOFT_RESERVED: Add a new I/O resource descriptor for
> >   a device driver to search iomem resources for application specific
> >   memory. Teach the iomem code to identify such ranges as "Soft Reserved".
> >
> > A follow-on change integrates parsing of the ACPI HMAT to identify the
> > node and sub-range boundaries of EFI_MEMORY_SP designated memory. For
> > now, just identify and reserve memory of this type.
> >
> > Cc: <x86@kernel.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Darren Hart <dvhart@infradead.org>
> > Cc: Andy Shevchenko <andy@infradead.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> For the EFI changes
>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> although I must admit I don't follow the enum add_efi_mode logic 100%

I'm open to suggestions as I'm not sure it's the best possible
organization. The do_add_efi_memmap() routine has the logic to
translate EFI to E820, but unless "add_efi_memmap" is specified on the
kernel command line the EFI memory map is ignored. For
soft-reservation support I want to reuse do_add_efi_memmap(), but
otherwise avoid any other side effects of considering the EFI map.
What I'm missing is the rationale for why "add_efi_memmap" is required
before considering the EFI memory map.

If there is a negative side effect to always using the EFI map then
the new "add_efi_mode" designation constrains it to just the
soft-reservation case.

It seems for historical reasons the full EFI memmap requires explicit opt-in:

200001eb140e x86 boot: only pick up additional EFI memmap if add_efi_memmap flag
