Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2A6A96D3
	for <lists+linux-efi@lfdr.de>; Thu,  5 Sep 2019 01:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfIDXGe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Sep 2019 19:06:34 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42847 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfIDXGe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Sep 2019 19:06:34 -0400
Received: by mail-oi1-f193.google.com with SMTP id o6so185976oic.9
        for <linux-efi@vger.kernel.org>; Wed, 04 Sep 2019 16:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fPGlApJedR9ZlVJjdafhv84/4vyY9iY2SBzxkWrf+aE=;
        b=sZ3iPctEONosT8HUcQGHu1IfcW3Zkt4mdO1y77F3HgTdvsgdWO/naaes7xI902buLm
         q48o3P8RkTtwadnqB1FdwnC9cFexqOixI79xn51jq8RfNABH8ZNvGWH/aN1fh1bgOfpr
         DPlSaxNwdbhTu0lhjQIDTfy8t3JMcE1hiZOJ+pxDGYTBHPtbQbSIX2iF4u0GnPNQP5Jg
         fx3SEbHTKKOJAZb44KE/CDYrsNIspSiz3mrLqveJX7OFrZs+sMflCiUALiRjB1eESIiq
         X1jBPTJRpyIlGZ3gyKYquR8hbPUfxssqGGyTTkNnCGkqBZjyyfysOk+9qg8bJvFLl44u
         vhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fPGlApJedR9ZlVJjdafhv84/4vyY9iY2SBzxkWrf+aE=;
        b=Qs7of/dNbzKcNHylfPQCG/TzoR6vQVWLlH0oNuE7mF/4VoGrLtwgkehAexsfg4634B
         Y7inTwXxD04r5SFRT23a9qLKiaamUqMkUApGFaTre2XkelRwlUHrDQhrQ3+iSkKrPkTw
         sCrCU0sx3h1XkWKF/iRdCa8GKdUwpK20bCh5u3N7npuhKc9z5jp7GYXlIV/jL1/d6LJs
         z1XPcRbaPtWg+YY9syJ7V3V6mfhPc06MrYmqqFykT9Smk3+oNNyKNr6Rlk+ApyXVkgqJ
         RRRgbafBUhTbMnYtFP0nCa9wk4ZoIySjfIwlSIXgFM45rcPR2BatsJyNpeTm5V51fWNV
         dMug==
X-Gm-Message-State: APjAAAWIuV4AiV8ysl5obh5mo4oQO+TdJRTzXgW2cjXeYR7l+XJj9zOz
        YNb7B4m1QgkJ1MJh0HEFTpr6znhVfKZexcWz4SmysA==
X-Google-Smtp-Source: APXvYqyr0prgWp/wSQkEi4jUdqbC5DWMV3RU/mJQ0hu4Sojqx0a/gdmDymFGtUNxILbNiRRO4fYjmE5YAuVh8QIuFVM=
X-Received: by 2002:aca:4b05:: with SMTP id y5mr391946oia.70.1567638392628;
 Wed, 04 Sep 2019 16:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <156712993795.1616117.3781864460118989466.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2329745.bCNtynFxEq@kreacher>
In-Reply-To: <2329745.bCNtynFxEq@kreacher>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 4 Sep 2019 16:06:21 -0700
Message-ID: <CAPcyv4ggOXjzaYZb4qCMQQL-Xf3fbZqKzqHTUBins_fv3=cEbw@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] EFI Specific Purpose Memory Support
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        kbuild test robot <lkp@intel.com>,
        Andy Shevchenko <andy@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Sep 2, 2019 at 4:09 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Friday, August 30, 2019 3:52:18 AM CEST Dan Williams wrote:
> > Changes since v4 [1]:
> > - Rename the facility from "Application Reserved" to "Soft Reserved" to
> >   better reflect how the memory is treated. While the spec talks about
> >   "specific / application purpose" memory the expected kernel behavior is
> >   to make a best effort at reserving the memory from general purpose
> >   allocations.
> >
> > - Add a new efi=nosoftreserve option to disable consideration of the
> >   EFI_MEMORY_SP attribute at boot time. This is also motivated by
> >   Christoph's initial feedback of allowing the kernel to opt-out of the
> >   policy whims of the platform BIOS implementation.
> >
> > - Update the KASLR implementation to exclude soft-reserved memory
> >   including the case where soft-reserved memory is specified via the
> >   efi_fake_mem= attribute-override command-line option.
> >
> > - Move the memregion allocator to its own object file. v4 had it in
> >   kernel/resource.c which caused compile errors on Sparc. I otherwise
> >   could not find an appropriate place to stash it.
> >
> > - Rebase on a merge of tip/master and rafael/linux-next since the series
> >   collides with changes in both those trees.
> >
> > [1]: https://lore.kernel.org/r/156140036490.2951909.1837804994781523185.stgit@dwillia2-desk3.amr.corp.intel.com/
> >
> > ---
> >
> > Thomas, Rafael,
> >
> > This happens to collide with both your trees. I think the content
> > warrants going through the x86 tree, but would need to publish commit:
> >
> > 5c7ed4385424 HMAT: Skip publishing target info for nodes with no online memory
> >
> > ...in Rafael's tree as a stable id for -tip to pull in, but I'm also
> > open to other options. I've retained Dave's reviewed-by from v4.
> >
> > ---
> >
> > The EFI 2.8 Specification [2] introduces the EFI_MEMORY_SP ("specific
> > purpose") memory attribute. This attribute bit replaces the deprecated
> > ACPI HMAT "reservation hint" that was introduced in ACPI 6.2 and removed
> > in ACPI 6.3.
> >
> > Given the increasing diversity of memory types that might be advertised
> > to the operating system, there is a need for platform firmware to hint
> > which memory ranges are free for the OS to use as general purpose memory
> > and which ranges are intended for application specific usage. For
> > example, an application with prior knowledge of the platform may expect
> > to be able to exclusively allocate a precious / limited pool of high
> > bandwidth memory. Alternatively, for the general purpose case, the
> > operating system may want to make the memory available on a best effort
> > basis as a unique numa-node with performance properties by the new
> > CONFIG_HMEM_REPORTING [3] facility.
> >
> > In support of optionally allowing either application-exclusive and
> > core-kernel-mm managed access to differentiated memory, claim
> > EFI_MEMORY_SP ranges for exposure as "soft reserved" and assigned to a
> > device-dax instance by default. Such instances can be directly owned /
> > mapped by a platform-topology-aware application. Alternatively, with the
> > new kmem facility [4], the administrator has the option to instead
> > designate that those memory ranges be hot-added to the core-kernel-mm as
> > a unique memory numa-node. In short, allow for the decision about what
> > software agent manages soft-reserved memory to be made at runtime.
> >
> > The patches build on the new HMAT+HMEM_REPORTING facilities merged
> > for v5.2-rc1. The implementation is tested with qemu emulation of HMAT
> > [5] plus the efi_fake_mem facility for applying the EFI_MEMORY_SP
> > attribute. Specific details on reproducing the test configuration are in
> > patch 10.
> >
> > [2]: https://uefi.org/sites/default/files/resources/UEFI_Spec_2_8_final.pdf
> > [3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e1cf33aafb84
> > [4]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c221c0b0308f
> > [5]: http://patchwork.ozlabs.org/cover/1096737/
> >
> > ---
> >
> > Dan Williams (10):
> >       acpi/numa: Establish a new drivers/acpi/numa/ directory
> >       efi: Enumerate EFI_MEMORY_SP
> >       x86, efi: Push EFI_MEMMAP check into leaf routines
> >       x86, efi: Reserve UEFI 2.8 Specific Purpose Memory for dax
> >       x86, efi: Add efi_fake_mem support for EFI_MEMORY_SP
> >       lib: Uplevel the pmem "region" ida to a global allocator
> >       dax: Fix alloc_dax_region() compile warning
> >       device-dax: Add a driver for "hmem" devices
> >       acpi/numa/hmat: Register HMAT at device_initcall level
> >       acpi/numa/hmat: Register "soft reserved" memory as an "hmem" device
> >
> >
> >  Documentation/admin-guide/kernel-parameters.txt |   19 +++
> >  arch/x86/Kconfig                                |   21 ++++
> >  arch/x86/boot/compressed/eboot.c                |    7 +
> >  arch/x86/boot/compressed/kaslr.c                |   50 +++++++-
> >  arch/x86/include/asm/e820/types.h               |    8 +
> >  arch/x86/include/asm/efi-stub.h                 |   11 ++
> >  arch/x86/include/asm/efi.h                      |   17 +++
> >  arch/x86/kernel/e820.c                          |   12 ++
> >  arch/x86/kernel/setup.c                         |   19 ++-
> >  arch/x86/platform/efi/efi.c                     |   56 +++++++++
> >  arch/x86/platform/efi/quirks.c                  |    3 +
> >  drivers/acpi/Kconfig                            |    9 --
> >  drivers/acpi/Makefile                           |    3 -
> >  drivers/acpi/hmat/Makefile                      |    2
> >  drivers/acpi/numa/Kconfig                       |    8 +
> >  drivers/acpi/numa/Makefile                      |    3 +
> >  drivers/acpi/numa/hmat.c                        |  138 +++++++++++++++++++++--
> >  drivers/acpi/numa/srat.c                        |    0
> >  drivers/dax/Kconfig                             |   27 ++++-
> >  drivers/dax/Makefile                            |    2
> >  drivers/dax/bus.c                               |    2
> >  drivers/dax/bus.h                               |    2
> >  drivers/dax/dax-private.h                       |    2
> >  drivers/dax/hmem.c                              |   57 ++++++++++
> >  drivers/firmware/efi/Makefile                   |    5 +
> >  drivers/firmware/efi/efi.c                      |    8 +
> >  drivers/firmware/efi/esrt.c                     |    3 +
> >  drivers/firmware/efi/fake_mem.c                 |   26 ++--
> >  drivers/firmware/efi/fake_mem.h                 |   10 ++
> >  drivers/firmware/efi/libstub/efi-stub-helper.c  |   12 ++
> >  drivers/firmware/efi/x86-fake_mem.c             |   69 ++++++++++++
> >  drivers/nvdimm/Kconfig                          |    1
> >  drivers/nvdimm/core.c                           |    1
> >  drivers/nvdimm/nd-core.h                        |    1
> >  drivers/nvdimm/region_devs.c                    |   13 +-
> >  include/linux/efi.h                             |    4 -
> >  include/linux/ioport.h                          |    1
> >  include/linux/memregion.h                       |   23 ++++
> >  lib/Kconfig                                     |    3 +
> >  lib/Makefile                                    |    1
> >  lib/memregion.c                                 |   18 +++
> >  41 files changed, 584 insertions(+), 93 deletions(-)
> >  create mode 100644 arch/x86/include/asm/efi-stub.h
> >  delete mode 100644 drivers/acpi/hmat/Makefile
> >  rename drivers/acpi/{hmat/Kconfig => numa/Kconfig} (70%)
> >  create mode 100644 drivers/acpi/numa/Makefile
> >  rename drivers/acpi/{hmat/hmat.c => numa/hmat.c} (85%)
> >  rename drivers/acpi/{numa.c => numa/srat.c} (100%)
> >  create mode 100644 drivers/dax/hmem.c
> >  create mode 100644 drivers/firmware/efi/fake_mem.h
> >  create mode 100644 drivers/firmware/efi/x86-fake_mem.c
> >  create mode 100644 include/linux/memregion.h
> >  create mode 100644 lib/memregion.c
> >
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> for the ACPI-related changes in this series.

Thanks Rafael, is commit 5c7ed4385424 on a stable branch that Thomas
could merge, or Thomas, is this all too late for v5.4?
