Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0A07273D3
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jun 2023 02:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjFHAnw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 20:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFHAnu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 20:43:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1D826A1;
        Wed,  7 Jun 2023 17:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686185024; x=1717721024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WEWSKZELo0XeZV4Jixe/V3pNjtPKx/p2uQSSvSJno+I=;
  b=FISM0pu/VHUnHd05OWIBZjQW43BnHNwr9zirXwPJv2avukI0Q+Bs7Xjw
   xj3eM60523Y1zqh2qsKb3iFNIubkUCVSPT3Q83RkzlisMoLXZteHkclxc
   kYoSn9ANc2So1TotRL6EDTz4gDrzI/K55A4Wc6ansFuxUjwvxvypdreaN
   d/yiiP6SqbIYKcnQPISzSVybMVTpPYCoBQBfDs9ykSitpRn1phVMVKWIS
   2iQkO1hW3yaGX/98L/+X5xwJ+a/KzJkJ+SL3tFYlI0EzxVz2i6GPIYB2U
   xTv/LBBo31ca+5xh3vSZkiKd3mzXNNPUnsxuvjpkkNRCGbdRROCJeTvgd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="336779894"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="336779894"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 17:43:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="709753476"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="709753476"
Received: from yjiang5-mobl.amr.corp.intel.com (HELO localhost) ([10.144.161.97])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 17:43:43 -0700
Date:   Wed, 7 Jun 2023 17:43:42 -0700
From:   Yunhong Jiang <yunhong.jiang@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v5 13/20] x86/efistub: Perform 4/5 level paging switch
 from the stub
Message-ID: <20230608004342.GA4340@yjiang5-mobl.amr.corp.intel.com>
References: <20230607072342.4054036-1-ardb@kernel.org>
 <20230607072342.4054036-14-ardb@kernel.org>
 <20230607201924.GD3110@yjiang5-mobl.amr.corp.intel.com>
 <CAMj1kXE7nW6ED1CmCd-by5HC7oqFAZd4=-ky_Kx_g6Br28PNhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE7nW6ED1CmCd-by5HC7oqFAZd4=-ky_Kx_g6Br28PNhQ@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 07, 2023 at 10:31:43PM +0200, Ard Biesheuvel wrote:
> On Wed, 7 Jun 2023 at 22:19, Yunhong Jiang
> <yunhong.jiang@linux.intel.com> wrote:
> >
> > On Wed, Jun 07, 2023 at 09:23:35AM +0200, Ard Biesheuvel wrote:
> > > In preparation for updating the EFI stub boot flow to avoid the bare
> > > metal decompressor code altogether, implement the support code for
> > > switching between 4 and 5 levels of paging before jumping to the kernel
> > > proper.
> > >
> > > This reuses the newly refactored trampoline that the bare metal
> > > decompressor uses, but relies on EFI APIs to allocate 32-bit addressable
> > > memory and remap it with the appropriate permissions. Given that the
> > > bare metal decompressor will no longer call into the trampoline if the
> > > number of paging levels is already set correctly, it is no longer needed
> > > to remove NX restrictions from the memory range where this trampoline
> > > may end up.
> > >
> > > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  drivers/firmware/efi/libstub/Makefile          |  1 +
> > >  drivers/firmware/efi/libstub/efi-stub-helper.c |  2 +
> > >  drivers/firmware/efi/libstub/efistub.h         |  1 +
> > >  drivers/firmware/efi/libstub/x86-5lvl.c        | 95 ++++++++++++++++++++
> > >  drivers/firmware/efi/libstub/x86-stub.c        | 40 +++------
> > >  drivers/firmware/efi/libstub/x86-stub.h        | 17 ++++
> > >  6 files changed, 130 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > > index 16d64a34d1e19465..ae8874401a9f1490 100644
> > > --- a/drivers/firmware/efi/libstub/Makefile
> > > +++ b/drivers/firmware/efi/libstub/Makefile
> > > @@ -88,6 +88,7 @@ lib-$(CONFIG_EFI_GENERIC_STUB)      += efi-stub.o string.o intrinsics.o systable.o \
> > >  lib-$(CONFIG_ARM)            += arm32-stub.o
> > >  lib-$(CONFIG_ARM64)          += arm64.o arm64-stub.o smbios.o
> > >  lib-$(CONFIG_X86)            += x86-stub.o
> > > +lib-$(CONFIG_X86_64)         += x86-5lvl.o
> > >  lib-$(CONFIG_RISCV)          += riscv.o riscv-stub.o
> > >  lib-$(CONFIG_LOONGARCH)              += loongarch.o loongarch-stub.o
> > >
> > > diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > > index 1e0203d74691ffcc..51779279fbff21b5 100644
> > > --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > > +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > > @@ -73,6 +73,8 @@ efi_status_t efi_parse_options(char const *cmdline)
> > >                       efi_loglevel = CONSOLE_LOGLEVEL_QUIET;
> > >               } else if (!strcmp(param, "noinitrd")) {
> > >                       efi_noinitrd = true;
> > > +             } else if (IS_ENABLED(CONFIG_X86_64) && !strcmp(param, "no5lvl")) {
> > > +                     efi_no5lvl = true;
> > >               } else if (!strcmp(param, "efi") && val) {
> > >                       efi_nochunk = parse_option_str(val, "nochunk");
> > >                       efi_novamap |= parse_option_str(val, "novamap");
> > > diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> > > index 6aa38a1bf1265d83..06b7abc92ced9e18 100644
> > > --- a/drivers/firmware/efi/libstub/efistub.h
> > > +++ b/drivers/firmware/efi/libstub/efistub.h
> > > @@ -33,6 +33,7 @@
> > >  #define EFI_ALLOC_LIMIT              ULONG_MAX
> > >  #endif
> > >
> > > +extern bool efi_no5lvl;
> > >  extern bool efi_nochunk;
> > >  extern bool efi_nokaslr;
> > >  extern int efi_loglevel;
> > > diff --git a/drivers/firmware/efi/libstub/x86-5lvl.c b/drivers/firmware/efi/libstub/x86-5lvl.c
> > > new file mode 100644
> > > index 0000000000000000..2428578a3ae08be7
> > > --- /dev/null
> > > +++ b/drivers/firmware/efi/libstub/x86-5lvl.c
> > > @@ -0,0 +1,95 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +#include <linux/efi.h>
> > > +
> > > +#include <asm/boot.h>
> > > +#include <asm/desc.h>
> > > +#include <asm/efi.h>
> > > +
> > > +#include "efistub.h"
> > > +#include "x86-stub.h"
> > > +
> > > +bool efi_no5lvl;
> > > +
> > > +static void (*la57_toggle)(void *trampoline, bool enable_5lvl);
> >
> > As an ack to my comments to another patch, would it makes more sense to rename
> > the trampoline parameter to newcr3 and pass the address of the new page table,
> > instead of the trampoline start address?
> >
> 
> Perhaps, but please realise that my goal here was not to invent an API
> from scratch. There was existing code that I made minimal changes to
> in order to be able to reuse it.
> 
> If this needs further changes, you can always send follow-up patches.

Sure, will do that as follow up patches.
> 
> > > +
> > > +static const struct desc_struct gdt[] = {
> > > +     [GDT_ENTRY_KERNEL32_CS] = GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
> > > +     [GDT_ENTRY_KERNEL_CS]   = GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
> > > +};
> > > +
> > > +/*
> > > + * Enabling (or disabling) 5 level paging is tricky, because it can only be
> > > + * done from 32-bit mode with paging disabled. This means not only that the
> > > + * code itself must be running from 32-bit addressable physical memory, but
> > > + * also that the root page table must be 32-bit addressable, as programming
> > > + * a 64-bit value into CR3 when running in 32-bit mode is not supported.
> > > + */
> > > +efi_status_t efi_setup_5level_paging(void)
> > > +{
> > > +     u8 tmpl_size = (u8 *)&trampoline_ljmp_imm_offset - (u8 *)&trampoline_32bit_src;
> > > +     efi_status_t status;
> > > +     u8 *la57_code;
> > > +
> > > +     if (!efi_is_64bit())
> > > +             return EFI_SUCCESS;
> > > +
> > > +     /* check for 5 level paging support */
> > > +     if (native_cpuid_eax(0) < 7 ||
> > > +         !(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31))))
> > > +             return EFI_SUCCESS;
> > > +
> > Do we need to check the need_toggle here instead of at efi_5level_switch and
> > skip the whole setup if no need to switch the paging level? Sorry if I missed
> > any point.
> >
> 
> No. There are reasons why firmware might run with 5 levels, and switch
> to 4 levels at ExitBootServices() time.

The need_toggle check at efi_5level_switch(), "need_toggle = want_la57 ^
have_la57", should cover this scenario, right? If we check need_toggle on
efi_setup_5level_paging() and it's false, then we don't need the setup in
efi_setup_5level_paging(), right? I don't see the  la57_toggle() called on other
places.

Or I misunderstand your response?

> 
> > > +     /* allocate some 32-bit addressable memory for code and a page table */
> > > +     status = efi_allocate_pages(2 * PAGE_SIZE, (unsigned long *)&la57_code,
> > > +                                 U32_MAX);
> > > +     if (status != EFI_SUCCESS)
> > > +             return status;
> > > +
> > > +     la57_toggle = memcpy(la57_code, trampoline_32bit_src, tmpl_size);
> > > +     memset(la57_code + tmpl_size, 0x90, PAGE_SIZE - tmpl_size);
> > > +
> > > +     /*
> > > +      * To avoid the need to allocate a 32-bit addressable stack, the
> > > +      * trampoline uses a LJMP instruction to switch back to long mode.
> > > +      * LJMP takes an absolute destination address, which needs to be
> > > +      * fixed up at runtime.
> > > +      */
> > > +     *(u32 *)&la57_code[trampoline_ljmp_imm_offset] += (unsigned long)la57_code;
> > > +
> > > +     efi_adjust_memory_range_protection((unsigned long)la57_toggle, PAGE_SIZE);
> > > +
> > > +     return EFI_SUCCESS;
> > > +}
> > > +
> > > +void efi_5level_switch(void)
> > > +{
> > > +     bool want_la57 = IS_ENABLED(CONFIG_X86_5LEVEL) && !efi_no5lvl;
> > > +     bool have_la57 = native_read_cr4() & X86_CR4_LA57;
> > > +     bool need_toggle = want_la57 ^ have_la57;
> > > +     u64 *pgt = (void *)la57_toggle + PAGE_SIZE;
> >
> > Not sure if we can decouple this address assumption of the pgt and la57_toggle,
> > and keep the pgt as a variable, like la57_toggle, setup by
> > efi_setup_5level_paging() too.
> > Asking because with the Intel X86-S
> > (https://cdrdv2-public.intel.com/776648/x86s-EAS-v1-4-17-23-1.pdf), no
> > tramopline code is needed since the 4/5 level paging switch does not require
> > paging disabling. Of course, it's ok to keep this as is, and we can change
> > late when we begin working on X86-S support.
> 
> We can make further changes as needed. The current interface is based
> on the existing code.

Sure. Will do the change in future.
