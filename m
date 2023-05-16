Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBC5705578
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 19:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjEPRxf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 13:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjEPRxe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 13:53:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E951FD8;
        Tue, 16 May 2023 10:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2BB663587;
        Tue, 16 May 2023 17:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0A3C433A0;
        Tue, 16 May 2023 17:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684259608;
        bh=a2ifXHJlCzZ7fXlXoYXgs2q6a5zzIutso94ZvQboeso=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hJl9GZ+sb0iuUpKarA02VRglVD5IR2fwl12vNU+iYt9qC2tE0TO+YeogAVIhErsr9
         Er4ZEXGS+Y27wCq+QJLNsMTBFoluJNJniFbpoIWiqLkJUNJJ+WXXrhpyj0fowh8auV
         JvwhfoVaYO+YLQAPSDnOSnlRni9L4+pm/2wC2z6ua7mNH26heDZ0bP1NtBRmGQRMqk
         2A6cpBvDs+Pb9N7/G5uLSN+ZyDwa3MbJdibwkDNbQcl2jn8x63qPs5SWAZ03f1B9ad
         SYqok92VPm3KnG7wl4KsO161fZErnhcu97PFb+t0/sbVH9wxnVMQPRDzRYkckPnD6e
         RWhoHWurbOVZw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f00d41df22so5915175e87.1;
        Tue, 16 May 2023 10:53:28 -0700 (PDT)
X-Gm-Message-State: AC+VfDxAQqfCpJLUnEf+f88BXshjJRKltU7alALShx2v6Qb0vKtKWIKB
        nz1oXgBFMEgq2aBxJpoZabImiD+GdqBfIdsLaaM=
X-Google-Smtp-Source: ACHHUZ5ARZjoh/sEOupnf6Ud2vyHyDmSbqEofwZeCRjVjDNEbsz8182UYVgEkYurW952Bmhd3xM52lXSBnu1CGC9XeI=
X-Received: by 2002:a05:6512:1584:b0:4eb:412f:9e0e with SMTP id
 bp4-20020a056512158400b004eb412f9e0emr10739000lfb.26.1684259606205; Tue, 16
 May 2023 10:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230508070330.582131-1-ardb@kernel.org> <20230508070330.582131-10-ardb@kernel.org>
 <20230515141408.37aoipn4jfu5qcdd@box.shutemov.name>
In-Reply-To: <20230515141408.37aoipn4jfu5qcdd@box.shutemov.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 May 2023 19:53:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHeoE8QATnCUS_WmcUjWTHtv7q1VGHAV3UVxDykrytc9g@mail.gmail.com>
Message-ID: <CAMj1kXHeoE8QATnCUS_WmcUjWTHtv7q1VGHAV3UVxDykrytc9g@mail.gmail.com>
Subject: Re: [PATCH v2 09/20] x86: efistub: Perform 4/5 level paging switch
 from the stub
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 15 May 2023 at 16:14, Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Mon, May 08, 2023 at 09:03:19AM +0200, Ard Biesheuvel wrote:
> > In preparation for updating the EFI stub boot flow to avoid the bare
> > metal decompressor code altogether, implement the support code for
> > switching between 4 and 5 levels of paging before jumping to the kernel
> > proper.
> >
> > This reuses the newly refactored trampoline that the bare metal
> > decompressor uses, but relies on EFI APIs to allocate 32-bit addressable
> > memory and remap it with the appropriate permissions. Given that the
> > bare metal decompressor will no longer call into the trampoline if the
> > number of paging levels is already set correctly, we no longer need to
> > remove NX restrictions from the memory range where this trampoline may
> > end up.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  drivers/firmware/efi/libstub/efi-stub-helper.c |   4 +
> >  drivers/firmware/efi/libstub/x86-stub.c        | 119 ++++++++++++++++----
> >  2 files changed, 102 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > index 1e0203d74691ffcc..fc5f3b4c45e91401 100644
> > --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > @@ -16,6 +16,8 @@
> >
> >  #include "efistub.h"
> >
> > +extern bool efi_no5lvl;
> > +
> >  bool efi_nochunk;
> >  bool efi_nokaslr = !IS_ENABLED(CONFIG_RANDOMIZE_BASE);
> >  bool efi_novamap;
> > @@ -73,6 +75,8 @@ efi_status_t efi_parse_options(char const *cmdline)
> >                       efi_loglevel = CONSOLE_LOGLEVEL_QUIET;
> >               } else if (!strcmp(param, "noinitrd")) {
> >                       efi_noinitrd = true;
> > +             } else if (IS_ENABLED(CONFIG_X86_64) && !strcmp(param, "no5lvl")) {
> > +                     efi_no5lvl = true;
> >               } else if (!strcmp(param, "efi") && val) {
> >                       efi_nochunk = parse_option_str(val, "nochunk");
> >                       efi_novamap |= parse_option_str(val, "novamap");
> > diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> > index a0bfd31358ba97b1..fb83a72ad905ad6e 100644
> > --- a/drivers/firmware/efi/libstub/x86-stub.c
> > +++ b/drivers/firmware/efi/libstub/x86-stub.c
> > @@ -267,32 +267,11 @@ adjust_memory_range_protection(unsigned long start, unsigned long size)
> >       }
> >  }
> >
> > -/*
> > - * Trampoline takes 2 pages and can be loaded in first megabyte of memory
> > - * with its end placed between 128k and 640k where BIOS might start.
> > - * (see arch/x86/boot/compressed/pgtable_64.c)
> > - *
> > - * We cannot find exact trampoline placement since memory map
> > - * can be modified by UEFI, and it can alter the computed address.
> > - */
> > -
> > -#define TRAMPOLINE_PLACEMENT_BASE ((128 - 8)*1024)
> > -#define TRAMPOLINE_PLACEMENT_SIZE (640*1024 - (128 - 8)*1024)
> > -
> >  void startup_32(struct boot_params *boot_params);
> >
> >  static void
> >  setup_memory_protection(unsigned long image_base, unsigned long image_size)
> >  {
> > -     /*
> > -      * Allow execution of possible trampoline used
> > -      * for switching between 4- and 5-level page tables
> > -      * and relocated kernel image.
> > -      */
> > -
> > -     adjust_memory_range_protection(TRAMPOLINE_PLACEMENT_BASE,
> > -                                    TRAMPOLINE_PLACEMENT_SIZE);
> > -
> >  #ifdef CONFIG_64BIT
> >       if (image_base != (unsigned long)startup_32)
> >               adjust_memory_range_protection(image_base, image_size);
> > @@ -760,6 +739,96 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
> >       return EFI_SUCCESS;
> >  }
> >
> > +bool efi_no5lvl;
> > +
> > +static void (*la57_toggle)(void *trampoline, bool enable_5lvl);
> > +
> > +extern void trampoline_32bit_src(void *, bool);
> > +extern const u16 trampoline_ljmp_imm_offset;
> > +
> > +/*
> > + * Enabling (or disabling) 5 level paging is tricky, because it can only be
> > + * done from 32-bit mode with paging disabled. This means not only that the
> > + * code itself must be running from 32-bit addressable physical memory, but
> > + * also that the root page table must be 32-bit addressable, as we cannot
> > + * program a 64-bit value into CR3 when running in 32-bit mode.
> > + */
> > +static efi_status_t efi_setup_5level_paging(void)
> > +{
> > +     u8 tmpl_size = (u8 *)&trampoline_ljmp_imm_offset - (u8 *)&trampoline_32bit_src;
> > +     efi_status_t status;
> > +     u8 *la57_code;
> > +
> > +     if (!efi_is_64bit())
> > +             return EFI_SUCCESS;
> > +
> > +     /* check for 5 level paging support */
> > +     if (native_cpuid_eax(0) < 7 ||
> > +         !(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31))))
> > +             return EFI_SUCCESS;
> > +
> > +     /* allocate some 32-bit addressable memory for code and a page table */
> > +     status = efi_allocate_pages(2 * PAGE_SIZE, (unsigned long *)&la57_code,
> > +                                 U32_MAX);
> > +     if (status != EFI_SUCCESS)
> > +             return status;
> > +
> > +     la57_toggle = memcpy(la57_code, trampoline_32bit_src, tmpl_size);
> > +     memset(la57_code + tmpl_size, 0x90, PAGE_SIZE - tmpl_size);
> > +
> > +     /*
> > +      * To avoid having to allocate a 32-bit addressable stack, we use a
> > +      * ljmp to switch back to long mode. However, this takes an absolute
> > +      * address, so we have to poke it in at runtime.
> > +      */
> > +     *(u32 *)&la57_code[trampoline_ljmp_imm_offset] += (unsigned long)la57_code;
> > +
> > +     adjust_memory_range_protection((unsigned long)la57_toggle, PAGE_SIZE);
> > +
> > +     return EFI_SUCCESS;
> > +}
> > +
> > +static void efi_5level_switch(void)
> > +{
> > +#ifdef CONFIG_X86_64
> > +     static const struct desc_struct gdt[] = {
> > +             [GDT_ENTRY_KERNEL32_CS] = GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
> > +             [GDT_ENTRY_KERNEL_CS]   = GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
> > +     };
> > +
> > +     bool want_la57 = IS_ENABLED(CONFIG_X86_5LEVEL) && !efi_no5lvl;
> > +     bool have_la57 = native_read_cr4() & X86_CR4_LA57;
> > +     bool need_toggle = want_la57 ^ have_la57;
> > +     u64 *pgt = (void *)la57_toggle + PAGE_SIZE;
> > +     u64 *cr3 = (u64 *)__native_read_cr3();
> > +     u64 *new_cr3;
> > +
> > +     if (!la57_toggle || !need_toggle)
> > +             return;
> > +
> > +     if (!have_la57) {
> > +             /*
> > +              * We are going to enable 5 level paging, so we need to
> > +              * allocate a root level page from the 32-bit addressable
> > +              * physical region, and plug the existing hierarchy into it.
> > +              */
> > +             new_cr3 = memset(pgt, 0, PAGE_SIZE);
> > +             new_cr3[0] = (u64)cr3 | _PAGE_TABLE_NOENC;
> > +     } else {
> > +             // take the new root table pointer from the current entry #0
> > +             new_cr3 = (u64 *)(cr3[0] & PAGE_MASK);
> > +
> > +             // copy the new root level table if it is not 32-bit addressable
> > +             if ((u64)new_cr3 > U32_MAX)
> > +                     new_cr3 = memcpy(pgt, new_cr3, PAGE_SIZE);
> > +     }
> > +
> > +     native_load_gdt(&(struct desc_ptr){ sizeof(gdt) - 1, (u64)gdt });
> > +
> > +     la57_toggle(new_cr3, want_la57);
> > +#endif
> > +}
> > +
>
> Nit: I would prefer to have the #ifdef around whole function with dummy
> function for !CONFIG_X86_64 case, if IS_ENABLED(CONFIG_X86_64) is not an
> option.
>

The latter is not an option because 32-bit has no definition for
GDT_ENTRY_KERNEL32_CS.

Personally, I prefer having only a single function declaration.
Alternatively, we could move this code to a separate file and only
include it in the build on 64-bit. That would allow the use of
IS_ENABLED() at the call site, as the calls would just disappear from
the object file on 32-bit builds.

> Otherwise:
>
>         Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Thanks.
