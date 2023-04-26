Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD7B6EF809
	for <lists+linux-efi@lfdr.de>; Wed, 26 Apr 2023 17:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbjDZP5z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Apr 2023 11:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239482AbjDZP5y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Apr 2023 11:57:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 197674495
        for <linux-efi@vger.kernel.org>; Wed, 26 Apr 2023 08:57:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B55051FB;
        Wed, 26 Apr 2023 08:58:36 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1C933F587;
        Wed, 26 Apr 2023 08:57:51 -0700 (PDT)
Date:   Wed, 26 Apr 2023 16:57:42 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org
Subject: Re: [PATCH 2/2] efi/zboot: arm64: Grab kernel code size from zboot
 payload
Message-ID: <ZElJ9hMDSLsvwmDh@FVFF77S0Q05N>
References: <20230426141103.2464423-1-ardb@kernel.org>
 <20230426141103.2464423-3-ardb@kernel.org>
 <CAMj1kXFxXctBtodMub9Pfjx9-dAaTtFhn=3DxmYLatjMhv8zTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFxXctBtodMub9Pfjx9-dAaTtFhn=3DxmYLatjMhv8zTA@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Apr 26, 2023 at 03:20:43PM +0100, Ard Biesheuvel wrote:
> On Wed, 26 Apr 2023 at 15:11, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Instead of relying on a dodgy dd hack to copy the image code size from
> > the uncompressed image's PE header to the end of the compressed image,
> 
> 
> > let's grab the code size from the text_offset field of the arm64 image
> > header after decompression, which is where the arm64 specific EFI zboot
> > make rules will poke the code size when generating the zboot specific
> > version of the binary Image payload.
> >
> 
> Apologies, I failed to update the above when I changed the actual
> patch. It should read:
> 
> "let's grab the code size from the symbol that is injected into the
> ELF by the Kbuild rules that generate the compressed payload".

With the corrected wording:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
> 
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  drivers/firmware/efi/libstub/Makefile.zboot | 14 +++-----------
> >  drivers/firmware/efi/libstub/arm64.c        | 19 +++++++++++++------
> >  drivers/firmware/efi/libstub/efistub.h      |  3 +--
> >  drivers/firmware/efi/libstub/zboot.c        | 15 ++++-----------
> >  4 files changed, 21 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
> > index 1b101d9076fd49e5..89ef820f3b34483a 100644
> > --- a/drivers/firmware/efi/libstub/Makefile.zboot
> > +++ b/drivers/firmware/efi/libstub/Makefile.zboot
> > @@ -24,21 +24,13 @@ comp-type-$(CONFIG_KERNEL_ZSTD)             := zstd22
> >  # causing the original tools to complain when checking image integrity.
> >  # So disregard it when calculating the payload size in the zimage header.
> >  zboot-method-y                         := $(comp-type-y)_with_size
> > -zboot-size-len-y                       := 12
> > +zboot-size-len-y                       := 4
> >
> >  zboot-method-$(CONFIG_KERNEL_GZIP)     := gzip
> > -zboot-size-len-$(CONFIG_KERNEL_GZIP)   := 8
> > -
> > -# Copy the SizeOfHeaders and SizeOfCode fields from the payload to the end of
> > -# the compressed image. Note that this presupposes a PE header offset of 64
> > -# bytes, which is what arm64, RISC-V and LoongArch use.
> > -quiet_cmd_compwithsize = $(quiet_cmd_$(zboot-method-y))
> > -      cmd_compwithsize = $(cmd_$(zboot-method-y)) && ( \
> > -                          dd status=none if=$< bs=4 count=1 skip=37 ; \
> > -                          dd status=none if=$< bs=4 count=1 skip=23 ) >> $@
> > +zboot-size-len-$(CONFIG_KERNEL_GZIP)   := 0
> >
> >  $(obj)/vmlinuz: $(obj)/vmlinux.bin FORCE
> > -       $(call if_changed,compwithsize)
> > +       $(call if_changed,$(zboot-method-y))
> >
> >  OBJCOPYFLAGS_vmlinuz.o := -I binary -O $(EFI_ZBOOT_BFD_TARGET) $(EFI_ZBOOT_OBJCOPY_FLAGS) \
> >                           --rename-section .data=.gzdata,load,alloc,readonly,contents
> > diff --git a/drivers/firmware/efi/libstub/arm64.c b/drivers/firmware/efi/libstub/arm64.c
> > index 8aad8c49d43f18e0..446e35eaf3d9434c 100644
> > --- a/drivers/firmware/efi/libstub/arm64.c
> > +++ b/drivers/firmware/efi/libstub/arm64.c
> > @@ -9,6 +9,7 @@
> >
> >  #include <linux/efi.h>
> >  #include <asm/efi.h>
> > +#include <asm/image.h>
> >  #include <asm/memory.h>
> >  #include <asm/sysreg.h>
> >
> > @@ -88,9 +89,10 @@ efi_status_t check_platform_features(void)
> >  #define DCTYPE "cvau"
> >  #endif
> >
> > +u32 __weak code_size;
> > +
> >  void efi_cache_sync_image(unsigned long image_base,
> > -                         unsigned long alloc_size,
> > -                         unsigned long code_size)
> > +                         unsigned long alloc_size)
> >  {
> >         u32 ctr = read_cpuid_effective_cachetype();
> >         u64 lsize = 4 << cpuid_feature_extract_unsigned_field(ctr,
> > @@ -98,16 +100,21 @@ void efi_cache_sync_image(unsigned long image_base,
> >
> >         /* only perform the cache maintenance if needed for I/D coherency */
> >         if (!(ctr & BIT(CTR_EL0_IDC_SHIFT))) {
> > +               unsigned long base = image_base;
> > +               unsigned long size = code_size;
> > +
> >                 do {
> > -                       asm("dc " DCTYPE ", %0" :: "r"(image_base));
> > -                       image_base += lsize;
> > -                       code_size -= lsize;
> > -               } while (code_size >= lsize);
> > +                       asm("dc " DCTYPE ", %0" :: "r"(base));
> > +                       base += lsize;
> > +                       size -= lsize;
> > +               } while (size >= lsize);
> >         }
> >
> >         asm("ic ialluis");
> >         dsb(ish);
> >         isb();
> > +
> > +       efi_remap_image(image_base, alloc_size, code_size);
> >  }
> >
> >  unsigned long __weak primary_entry_offset(void)
> > diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> > index 148013bcb5f89fdd..67d5a20802e0b7c6 100644
> > --- a/drivers/firmware/efi/libstub/efistub.h
> > +++ b/drivers/firmware/efi/libstub/efistub.h
> > @@ -1066,8 +1066,7 @@ struct screen_info *__alloc_screen_info(void);
> >  void free_screen_info(struct screen_info *si);
> >
> >  void efi_cache_sync_image(unsigned long image_base,
> > -                         unsigned long alloc_size,
> > -                         unsigned long code_size);
> > +                         unsigned long alloc_size);
> >
> >  struct efi_smbios_record {
> >         u8      type;
> > diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
> > index 63ece480090032c1..e5d7fa1f1d8fd160 100644
> > --- a/drivers/firmware/efi/libstub/zboot.c
> > +++ b/drivers/firmware/efi/libstub/zboot.c
> > @@ -50,8 +50,7 @@ static unsigned long alloc_preferred_address(unsigned long alloc_size)
> >  }
> >
> >  void __weak efi_cache_sync_image(unsigned long image_base,
> > -                                unsigned long alloc_size,
> > -                                unsigned long code_size)
> > +                                unsigned long alloc_size)
> >  {
> >         // Provided by the arch to perform the cache maintenance necessary for
> >         // executable code loaded into memory to be safe for execution.
> > @@ -66,7 +65,7 @@ asmlinkage efi_status_t __efiapi
> >  efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
> >  {
> >         unsigned long compressed_size = _gzdata_end - _gzdata_start;
> > -       unsigned long image_base, alloc_size, code_size;
> > +       unsigned long image_base, alloc_size;
> >         efi_loaded_image_t *image;
> >         efi_status_t status;
> >         char *cmdline_ptr;
> > @@ -91,13 +90,9 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
> >         efi_info("Decompressing Linux Kernel...\n");
> >
> >         // SizeOfImage from the compressee's PE/COFF header
> > -       alloc_size = round_up(get_unaligned_le32(_gzdata_end - 12),
> > +       alloc_size = round_up(get_unaligned_le32(_gzdata_end - 4),
> >                               EFI_ALLOC_ALIGN);
> >
> > -       // SizeOfHeaders and SizeOfCode from the compressee's PE/COFF header
> > -       code_size = get_unaligned_le32(_gzdata_end - 4) +
> > -                   get_unaligned_le32(_gzdata_end - 8);
> > -
> >          // If the architecture has a preferred address for the image,
> >          // try that first.
> >         image_base = alloc_preferred_address(alloc_size);
> > @@ -140,9 +135,7 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
> >                 goto free_image;
> >         }
> >
> > -       efi_cache_sync_image(image_base, alloc_size, code_size);
> > -
> > -       efi_remap_image(image_base, alloc_size, code_size);
> > +       efi_cache_sync_image(image_base, alloc_size);
> >
> >         status = efi_stub_common(handle, image, image_base, cmdline_ptr);
> >
> > --
> > 2.39.2
> >
