Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB3E2D95AD
	for <lists+linux-efi@lfdr.de>; Wed, 16 Oct 2019 17:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405014AbfJPPeJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Oct 2019 11:34:09 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45658 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405019AbfJPPeJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Oct 2019 11:34:09 -0400
Received: by mail-oi1-f195.google.com with SMTP id o205so20390425oib.12
        for <linux-efi@vger.kernel.org>; Wed, 16 Oct 2019 08:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G90VE6Bb79yrLS89Bw4MQZLt0drlBNa3zWUFgpxEWOI=;
        b=uzHk9dGFu+BAuJu/jtkKm6PdKsAv0v77ftSf7INtWEGZjbXW3nuTCxWxyYcqXcc55N
         jn0j3vZlbS1hafkC3P6q2PLJjZ+cBv7yG02yXBzE4o/EpvIP+rWjtbzCBmHxQklSqVW6
         w8cOvr8XhtpNmSUh9hJqRfAadi7PWIZlUCGPCzpzhwQ/TXEDz/BxmYVjIrBKajenkdig
         8nMWV6tB+HL8OjfWIixlDMG2FWnnWQNzSdshV4/OskfzQZwxlWGzkhEjFDC4AGd7lvNs
         KhFF7eBo0szAAqTn0GyTNc3kb/1ZjJYNU5joeqawzfyRL5e08lkXX85BPwhn07w7DeYA
         jlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G90VE6Bb79yrLS89Bw4MQZLt0drlBNa3zWUFgpxEWOI=;
        b=p15eKK0uYaLvc6wvB54EQHsbvH21SZ5WsJhqxuCzGA9DDJtYaCw0EkQnNNolqa8x9e
         PlTp1j9F9KUsexQZKJjJNmS4OrxF+IpHzDE3k7mf33gqf5P75yUfB153AbNQ0sCuvJxo
         xkyTd894E4Onkd+Axz2m+wm3gH9KtBDsw4guL+R29X78kedHUD9Cm8kT4apuHaqjc3ak
         EmjDSF91a5Xkr3nuVqAQlIpwPXxPaCnoWURsd7hhcMI3zH1tPabGomOlY8ph4+odLtrO
         XCJX/Ai9PorDGCFsW4odiqH7wSOWN6dFTyjZ7taIuf501StJ6c4ZRAKShpL2/BLwkFqi
         a7dg==
X-Gm-Message-State: APjAAAXyp25fMe1fW97b8ucJLkBfhHCW88CoKsjVwMsL2TkBF3HhWEG8
        j/fdRXrChECksYt/6xEyyWIexAag7fEutnN5VNMPBA==
X-Google-Smtp-Source: APXvYqygwnr+NecDP1fO//HKzbSWX/belmW/bO18EhsuZZpxpYur8ANa264H/buC7850NnONeKoGNuvCNmNeaHqB1sA=
X-Received: by 2002:aca:6087:: with SMTP id u129mr4144470oib.149.1571240048086;
 Wed, 16 Oct 2019 08:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <157118756627.2063440.9878062995925617180.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu-dxRjANWfDGAaxCtGr_UxVt=c1Byb3zKRM9EuudpqNEQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu-dxRjANWfDGAaxCtGr_UxVt=c1Byb3zKRM9EuudpqNEQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 16 Oct 2019 08:33:56 -0700
Message-ID: <CAPcyv4gBSX58CWH4HZ28w0_cZRzJrhgdEFHa2g8KDqyv8aFqZQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/12] EFI Specific Purpose Memory Support
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Keith Busch <kbusch@kernel.org>, Len Brown <lenb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Darren Hart <dvhart@infradead.org>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kbuild test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Lutomirski <luto@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Oct 15, 2019 at 11:55 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Wed, 16 Oct 2019 at 03:13, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Changes since v6 [1]:
> > - Collect Ard's ack / review on patches 5-7, but not on patch 4 since it
> >   needed a non-trivial rework for linker error reported by the 0day robot.
> >
> > - Fixup "efi: Common enable/disable infrastructure for EFI soft
> >   reservation" with a new dependency on CONFIG_EFI_STUB for
> >   CONFIG_EFI_SOFT_RESERVE since the efi_soft_reserve_enabled() helper is
> >   only built with EFI_STUB=y and the support depends on early reservations
> >   to keep the kernel text from landing in the reservation.
>
> As far as I know, GRUB on x86 still boots without the EFI stub by
> default (i.e., using the 'linux' command instead of the 'linuxefi'
> command), so even if you build the stub, it is not going to be called
> in many cases. Is that going to be a problem?

It only becomes a problem if kaslr decides to land the kernel on top
of the soft-reservation. However, I think it's ok to say that if you
need the reservation to be honored in all circumstances, arrange to
boot in EFI mode.

>
> > This also
> >   moved the IS_ENABLED(CONFIG_EFI_SOFT_RESERVE) check into the header so
> >   that the stub does not try to link to __efi_soft_reserve_enabled() in
> >   the EFI_STUB=n case.
> >
> > - Rework "x86/efi: EFI soft reservation to E820 enumeration" to always
> >   add the full EFI memory map when EFI_MEMORY_SP ranges are found. This
> >   simplifies the logic to just add the full EFI map rather than try to
> >   tease out just the EFI_MEMORY_SP ranges. (Ard)
> >
> > [1]: https://lore.kernel.org/lkml/157066227329.1059972.5659620631541203458.stgit@dwillia2-desk3.amr.corp.intel.com/
> >
> > ---
> > Merge notes:
> >
> > Hi Ingo,
> >
> > I'm still looking for Ard's ack on the revised patch 4, but otherwise
> > feel like this is ready for your consideration.
> >
>
> Patch 4 looks fine to me,
>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks for the help.
