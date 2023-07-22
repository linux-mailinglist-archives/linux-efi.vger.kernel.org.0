Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463BC75DB36
	for <lists+linux-efi@lfdr.de>; Sat, 22 Jul 2023 11:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGVJNP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 22 Jul 2023 05:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGVJNO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 22 Jul 2023 05:13:14 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3BD26B0
        for <linux-efi@vger.kernel.org>; Sat, 22 Jul 2023 02:13:12 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3173ae9d243so288279f8f.2
        for <linux-efi@vger.kernel.org>; Sat, 22 Jul 2023 02:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690017191; x=1690621991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90hguqNLWAB5Tg7IXOPxbKvsJDpUexP5sblj5YfS1c4=;
        b=a2cX/VvekgZwARY2mw5YFq7Gs79dE/o0nH/QXfPm1mFdAQTfO0flCAgp6TbagGfAy/
         z6GtCxqeLB1LDmETA5IzgqV06dFriGJAjviu+I7daSttshGrRTu9uzC1Y5jm5JFplnIm
         e+zd61KTncpGTnQuJUt79XJfMdEDXM8OZABjyl5F4MLZqb+uMdk1wo3dCQ7WNUe8lUvE
         uxhXeLrCfNxhn2S6+RShOnz8P54G0L2mCEd0LiMGztZVqR34024APeNC7EDU2hBpiAPe
         k3tUUJ4KjVMyzhOGS5NH7cNrGp/HkhIg9PB09Pfc9nNJPV0MMDQMJkoIrHBJcTuAwaSc
         9yXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690017191; x=1690621991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90hguqNLWAB5Tg7IXOPxbKvsJDpUexP5sblj5YfS1c4=;
        b=ftwxx4LfQbl5q/sv5Q/DSGuxT/i2RGXHUUyJfP6TN827GCQUYbefyAkbbClnMr303u
         KKPw1R+4POY5l88lBi7DIuqfzjoVJQgzwwEfY1FcyTzqZF21SRha3Sj2pDwSOBWRZ1nj
         p90HEbmheWXpc9WOozUuTOnZ6Q0nJZ/CZKI7IALqHMpmTbiNbU+4Ze0OQEXvycDIuvls
         v+82O/wYhCB/2f9fv9jwApSdi04zWj0otghSgJyPW0+Ujc/FAgi7aCvup35KfS8xSfcM
         SoYJNt18Wf2fhZfA0/hcNrHIL+9TvVI9rrGLFLQrvoo/yDRq9ISgnoggrHL/9lWW2DMT
         Iqsw==
X-Gm-Message-State: ABy/qLZNuKdMh/XbTXtZH9pJV3ocPZFH78HL7A3tlbHEfTc9bZRcqb/l
        RbuWSf2ps8B5tmZ4wJ6CEBwSvIMMlIJLBDBKHoQweA==
X-Google-Smtp-Source: APBJJlEibOiYX/6faVn4fO1/KobyWpGl6LGzvO9QSJSFMS16MweUt50h4CNsSh/YBfyxwTQPgzEh1iP6nArFbd7iKVU=
X-Received: by 2002:adf:cd02:0:b0:314:55cd:ec6b with SMTP id
 w2-20020adfcd02000000b0031455cdec6bmr2902166wrm.71.1690017190809; Sat, 22 Jul
 2023 02:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230721074850.310644-1-alexghiti@rivosinc.com>
 <20230721074850.310644-4-alexghiti@rivosinc.com> <CAMj1kXGV4OZaccBxMFDnZXLKAow63dYFtZMy4GpTMq5nEssgFA@mail.gmail.com>
In-Reply-To: <CAMj1kXGV4OZaccBxMFDnZXLKAow63dYFtZMy4GpTMq5nEssgFA@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Sat, 22 Jul 2023 11:13:00 +0200
Message-ID: <CAHVXubiZx=tZt2P=ezQ0nfvsmY6DzKpw0X+w7gag3J+X=UsxQQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] arm64: libstub: Move KASLR handling functions to kaslr.c
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Fri, Jul 21, 2023 at 4:41=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Fri, 21 Jul 2023 at 09:51, Alexandre Ghiti <alexghiti@rivosinc.com> wr=
ote:
> >
> > This prepares for riscv to use the same functions to handle the p=C4=A5=
ysical
> > kernel move when KASLR is enabled.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/arm64/include/asm/efi.h              |   2 +
> >  drivers/firmware/efi/libstub/Makefile     |   3 +-
> >  drivers/firmware/efi/libstub/arm64-stub.c | 117 ++--------------
> >  drivers/firmware/efi/libstub/efistub.h    |   8 ++
> >  drivers/firmware/efi/libstub/kaslr.c      | 159 ++++++++++++++++++++++
> >  5 files changed, 184 insertions(+), 105 deletions(-)
> >  create mode 100644 drivers/firmware/efi/libstub/kaslr.c
> >
> > diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.=
h
> > index 4cf2cb053bc8..46273ee89445 100644
> > --- a/arch/arm64/include/asm/efi.h
> > +++ b/arch/arm64/include/asm/efi.h
> > @@ -168,4 +168,6 @@ static inline void efi_capsule_flush_cache_range(vo=
id *addr, int size)
> >
> >  efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f);
> >
> > +void efi_icache_sync(unsigned long start, unsigned long end);
> > +
>
> This needs to be in efistub.h or you are breaking the build on other
> architectures (including RISC-V until the final patch of the series is
> applied)
>
> x86 also chokes on the missing efi_get_kimg_min_align() so something
> should be done for that as well in this patch.
>
> Alternatively, you could add kaslr.o to lib-$(CONFIG_ARM64) only, and
> add it to lib-$(CONFIG_RISCV) too in the final patch.
>

Sorry about that, I was so focused on the linking errors that I did
not see those warnings...I'll go with the solution you propose rather
than introducing stubs like v3 did.

Sorry again and thanks,

Alex

>
> >  #endif /* _ASM_EFI_H */
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/e=
fi/libstub/Makefile
> > index 16d64a34d1e1..d363c806e87d 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -67,7 +67,8 @@ OBJECT_FILES_NON_STANDARD     :=3D y
> >  # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
> >  KCOV_INSTRUMENT                        :=3D n
> >
> > -lib-y                          :=3D efi-stub-helper.o gop.o secureboot=
.o tpm.o \
> > +lib-y                          :=3D efi-stub-helper.o kaslr.o \
> > +                                  gop.o secureboot.o tpm.o \
> >                                    file.o mem.o random.o randomalloc.o =
pci.o \
> >                                    skip_spaces.o lib-cmdline.o lib-ctyp=
e.o \
> >                                    alignedmem.o relocate.o printk.o vsp=
rintf.o
> > diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmwa=
re/efi/libstub/arm64-stub.c
> > index 770b8ecb7398..452b7ccd330e 100644
> > --- a/drivers/firmware/efi/libstub/arm64-stub.c
> > +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> > @@ -14,42 +14,6 @@
> >
> >  #include "efistub.h"
> >
> > -/*
> > - * Distro versions of GRUB may ignore the BSS allocation entirely (i.e=
., fail
> > - * to provide space, and fail to zero it). Check for this condition by=
 double
> > - * checking that the first and the last byte of the image are covered =
by the
> > - * same EFI memory map entry.
> > - */
> > -static bool check_image_region(u64 base, u64 size)
> > -{
> > -       struct efi_boot_memmap *map;
> > -       efi_status_t status;
> > -       bool ret =3D false;
> > -       int map_offset;
> > -
> > -       status =3D efi_get_memory_map(&map, false);
> > -       if (status !=3D EFI_SUCCESS)
> > -               return false;
> > -
> > -       for (map_offset =3D 0; map_offset < map->map_size; map_offset +=
=3D map->desc_size) {
> > -               efi_memory_desc_t *md =3D (void *)map->map + map_offset=
;
> > -               u64 end =3D md->phys_addr + md->num_pages * EFI_PAGE_SI=
ZE;
> > -
> > -               /*
> > -                * Find the region that covers base, and return whether
> > -                * it covers base+size bytes.
> > -                */
> > -               if (base >=3D md->phys_addr && base < end) {
> > -                       ret =3D (base + size) <=3D end;
> > -                       break;
> > -               }
> > -       }
> > -
> > -       efi_bs_call(free_pool, map);
> > -
> > -       return ret;
> > -}
> > -
> >  efi_status_t handle_kernel_image(unsigned long *image_addr,
> >                                  unsigned long *image_size,
> >                                  unsigned long *reserve_addr,
> > @@ -59,31 +23,6 @@ efi_status_t handle_kernel_image(unsigned long *imag=
e_addr,
> >  {
> >         efi_status_t status;
> >         unsigned long kernel_size, kernel_codesize, kernel_memsize;
> > -       u32 phys_seed =3D 0;
> > -       u64 min_kimg_align =3D efi_get_kimg_min_align();
> > -
> > -       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
> > -               efi_guid_t li_fixed_proto =3D LINUX_EFI_LOADED_IMAGE_FI=
XED_GUID;
> > -               void *p;
> > -
> > -               if (efi_nokaslr) {
> > -                       efi_info("KASLR disabled on kernel command line=
\n");
> > -               } else if (efi_bs_call(handle_protocol, image_handle,
> > -                                      &li_fixed_proto, &p) =3D=3D EFI_=
SUCCESS) {
> > -                       efi_info("Image placement fixed by loader\n");
> > -               } else {
> > -                       status =3D efi_get_random_bytes(sizeof(phys_see=
d),
> > -                                                     (u8 *)&phys_seed)=
;
> > -                       if (status =3D=3D EFI_NOT_FOUND) {
> > -                               efi_info("EFI_RNG_PROTOCOL unavailable\=
n");
> > -                               efi_nokaslr =3D true;
> > -                       } else if (status !=3D EFI_SUCCESS) {
> > -                               efi_err("efi_get_random_bytes() failed =
(0x%lx)\n",
> > -                                       status);
> > -                               efi_nokaslr =3D true;
> > -                       }
> > -               }
> > -       }
> >
> >         if (image->image_base !=3D _text) {
> >                 efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base h=
as bogus value\n");
> > @@ -98,50 +37,15 @@ efi_status_t handle_kernel_image(unsigned long *ima=
ge_addr,
> >         kernel_codesize =3D __inittext_end - _text;
> >         kernel_memsize =3D kernel_size + (_end - _edata);
> >         *reserve_size =3D kernel_memsize;
> > +       *image_addr =3D (unsigned long)_text;
> >
> > -       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && phys_seed !=3D 0) {
> > -               /*
> > -                * If KASLR is enabled, and we have some randomness ava=
ilable,
> > -                * locate the kernel at a randomized offset in physical=
 memory.
> > -                */
> > -               status =3D efi_random_alloc(*reserve_size, min_kimg_ali=
gn,
> > -                                         reserve_addr, phys_seed,
> > -                                         EFI_LOADER_CODE);
> > -               if (status !=3D EFI_SUCCESS)
> > -                       efi_warn("efi_random_alloc() failed: 0x%lx\n", =
status);
> > -       } else {
> > -               status =3D EFI_OUT_OF_RESOURCES;
> > -       }
> > -
> > -       if (status !=3D EFI_SUCCESS) {
> > -               if (!check_image_region((u64)_text, kernel_memsize)) {
> > -                       efi_err("FIRMWARE BUG: Image BSS overlaps adjac=
ent EFI memory region\n");
> > -               } else if (IS_ALIGNED((u64)_text, min_kimg_align) &&
> > -                          (u64)_end < EFI_ALLOC_LIMIT) {
> > -                       /*
> > -                        * Just execute from wherever we were loaded by=
 the
> > -                        * UEFI PE/COFF loader if the placement is suit=
able.
> > -                        */
> > -                       *image_addr =3D (u64)_text;
> > -                       *reserve_size =3D 0;
> > -                       return EFI_SUCCESS;
> > -               }
> > -
> > -               status =3D efi_allocate_pages_aligned(*reserve_size, re=
serve_addr,
> > -                                                   ULONG_MAX, min_kimg=
_align,
> > -                                                   EFI_LOADER_CODE);
> > -
> > -               if (status !=3D EFI_SUCCESS) {
> > -                       efi_err("Failed to relocate kernel\n");
> > -                       *reserve_size =3D 0;
> > -                       return status;
> > -               }
> > -       }
> > -
> > -       *image_addr =3D *reserve_addr;
> > -       memcpy((void *)*image_addr, _text, kernel_size);
> > -       caches_clean_inval_pou(*image_addr, *image_addr + kernel_codesi=
ze);
> > -       efi_remap_image(*image_addr, *reserve_size, kernel_codesize);
> > +       status =3D efi_kaslr_relocate_kernel(image_addr,
> > +                                          reserve_addr, reserve_size,
> > +                                          kernel_size, kernel_codesize=
,
> > +                                          kernel_memsize,
> > +                                          efi_kaslr_get_phys_seed(imag=
e_handle));
> > +       if (status !=3D EFI_SUCCESS)
> > +               return status;
> >
> >         return EFI_SUCCESS;
> >  }
> > @@ -159,3 +63,8 @@ unsigned long primary_entry_offset(void)
> >          */
> >         return (char *)primary_entry - _text;
> >  }
> > +
> > +void efi_icache_sync(unsigned long start, unsigned long end)
> > +{
> > +       caches_clean_inval_pou(start, end);
> > +}
> > diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/=
efi/libstub/efistub.h
> > index 6aa38a1bf126..b1a1037567ba 100644
> > --- a/drivers/firmware/efi/libstub/efistub.h
> > +++ b/drivers/firmware/efi/libstub/efistub.h
> > @@ -1132,6 +1132,14 @@ const u8 *__efi_get_smbios_string(const struct e=
fi_smbios_record *record,
> >
> >  void efi_remap_image(unsigned long image_base, unsigned alloc_size,
> >                      unsigned long code_size);
> > +efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
> > +                                      unsigned long *reserve_addr,
> > +                                      unsigned long *reserve_size,
> > +                                      unsigned long kernel_size,
> > +                                      unsigned long kernel_codesize,
> > +                                      unsigned long kernel_memsize,
> > +                                      u32 phys_seed);
> > +u32 efi_kaslr_get_phys_seed(efi_handle_t image_handle);
> >
> >  asmlinkage efi_status_t __efiapi
> >  efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab);
> > diff --git a/drivers/firmware/efi/libstub/kaslr.c b/drivers/firmware/ef=
i/libstub/kaslr.c
> > new file mode 100644
> > index 000000000000..be0c8ab0982a
> > --- /dev/null
> > +++ b/drivers/firmware/efi/libstub/kaslr.c
> > @@ -0,0 +1,159 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Helper functions used by the EFI stub on multiple
> > + * architectures to deal with physical address space randomization.
> > + */
> > +#include <linux/efi.h>
> > +
> > +#include "efistub.h"
> > +
> > +/**
> > + * efi_kaslr_get_phys_seed() - Get random seed for physical kernel KAS=
LR
> > + * @image_handle:      Handle to the image
> > + *
> > + * If KASLR is not disabled, obtain a random seed using EFI_RNG_PROTOC=
OL
> > + * that will be used to move the kernel physical mapping.
> > + *
> > + * Return:     the random seed
> > + */
> > +u32 efi_kaslr_get_phys_seed(efi_handle_t image_handle)
> > +{
> > +       efi_status_t status;
> > +       u32 phys_seed;
> > +       efi_guid_t li_fixed_proto =3D LINUX_EFI_LOADED_IMAGE_FIXED_GUID=
;
> > +       void *p;
> > +
> > +       if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> > +               return 0;
> > +
> > +       if (efi_nokaslr) {
> > +               efi_info("KASLR disabled on kernel command line\n");
> > +       } else if (efi_bs_call(handle_protocol, image_handle,
> > +                              &li_fixed_proto, &p) =3D=3D EFI_SUCCESS)=
 {
> > +               efi_info("Image placement fixed by loader\n");
> > +       } else {
> > +               status =3D efi_get_random_bytes(sizeof(phys_seed),
> > +                                             (u8 *)&phys_seed);
> > +               if (status =3D=3D EFI_SUCCESS) {
> > +                       return phys_seed;
> > +               } else if (status =3D=3D EFI_NOT_FOUND) {
> > +                       efi_info("EFI_RNG_PROTOCOL unavailable\n");
> > +                       efi_nokaslr =3D true;
> > +               } else if (status !=3D EFI_SUCCESS) {
> > +                       efi_err("efi_get_random_bytes() failed (0x%lx)\=
n",
> > +                               status);
> > +                       efi_nokaslr =3D true;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * Distro versions of GRUB may ignore the BSS allocation entirely (i.e=
., fail
> > + * to provide space, and fail to zero it). Check for this condition by=
 double
> > + * checking that the first and the last byte of the image are covered =
by the
> > + * same EFI memory map entry.
> > + */
> > +static bool check_image_region(u64 base, u64 size)
> > +{
> > +       struct efi_boot_memmap *map;
> > +       efi_status_t status;
> > +       bool ret =3D false;
> > +       int map_offset;
> > +
> > +       status =3D efi_get_memory_map(&map, false);
> > +       if (status !=3D EFI_SUCCESS)
> > +               return false;
> > +
> > +       for (map_offset =3D 0; map_offset < map->map_size; map_offset +=
=3D map->desc_size) {
> > +               efi_memory_desc_t *md =3D (void *)map->map + map_offset=
;
> > +               u64 end =3D md->phys_addr + md->num_pages * EFI_PAGE_SI=
ZE;
> > +
> > +               /*
> > +                * Find the region that covers base, and return whether
> > +                * it covers base+size bytes.
> > +                */
> > +               if (base >=3D md->phys_addr && base < end) {
> > +                       ret =3D (base + size) <=3D end;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       efi_bs_call(free_pool, map);
> > +
> > +       return ret;
> > +}
> > +
> > +/**
> > + * efi_kaslr_relocate_kernel() - Relocate the kernel (random if KASLR =
enabled)
> > + * @image_addr: Pointer to the current kernel location
> > + * @reserve_addr:      Pointer to the relocated kernel location
> > + * @reserve_size:      Size of the relocated kernel
> > + * @kernel_size:       Size of the text + data
> > + * @kernel_codesize:   Size of the text
> > + * @kernel_memsize:    Size of the text + data + bss
> > + * @phys_seed:         Random seed used for the relocation
> > + *
> > + * If KASLR is not enabled, this function relocates the kernel to a fi=
xed
> > + * address (or leave it as its current location). If KASLR is enabled,=
 the
> > + * kernel physical location is randomized using the seed in parameter.
> > + *
> > + * Return:     status code, EFI_SUCCESS if relocation is successful
> > + */
> > +efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
> > +                                      unsigned long *reserve_addr,
> > +                                      unsigned long *reserve_size,
> > +                                      unsigned long kernel_size,
> > +                                      unsigned long kernel_codesize,
> > +                                      unsigned long kernel_memsize,
> > +                                      u32 phys_seed)
> > +{
> > +       efi_status_t status;
> > +       u64 min_kimg_align =3D efi_get_kimg_min_align();
> > +
> > +       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && phys_seed !=3D 0) {
> > +               /*
> > +                * If KASLR is enabled, and we have some randomness ava=
ilable,
> > +                * locate the kernel at a randomized offset in physical=
 memory.
> > +                */
> > +               status =3D efi_random_alloc(*reserve_size, min_kimg_ali=
gn,
> > +                                         reserve_addr, phys_seed,
> > +                                         EFI_LOADER_CODE);
> > +               if (status !=3D EFI_SUCCESS)
> > +                       efi_warn("efi_random_alloc() failed: 0x%lx\n", =
status);
> > +       } else {
> > +               status =3D EFI_OUT_OF_RESOURCES;
> > +       }
> > +
> > +       if (status !=3D EFI_SUCCESS) {
> > +               if (!check_image_region(*image_addr, kernel_memsize)) {
> > +                       efi_err("FIRMWARE BUG: Image BSS overlaps adjac=
ent EFI memory region\n");
> > +               } else if (IS_ALIGNED(*image_addr, min_kimg_align) &&
> > +                          (u64)_end < EFI_ALLOC_LIMIT) {
> > +                       /*
> > +                        * Just execute from wherever we were loaded by=
 the
> > +                        * UEFI PE/COFF loader if the placement is suit=
able.
> > +                        */
> > +                       *reserve_size =3D 0;
> > +                       return EFI_SUCCESS;
> > +               }
> > +
> > +               status =3D efi_allocate_pages_aligned(*reserve_size, re=
serve_addr,
> > +                                                   ULONG_MAX, min_kimg=
_align,
> > +                                                   EFI_LOADER_CODE);
> > +
> > +               if (status !=3D EFI_SUCCESS) {
> > +                       efi_err("Failed to relocate kernel\n");
> > +                       *reserve_size =3D 0;
> > +                       return status;
> > +               }
> > +       }
> > +
> > +       memcpy((void *)*reserve_addr, (void *)*image_addr, kernel_size)=
;
> > +       *image_addr =3D *reserve_addr;
> > +       efi_icache_sync(*image_addr, *image_addr + kernel_codesize);
> > +       efi_remap_image(*image_addr, *reserve_size, kernel_codesize);
> > +
> > +       return status;
> > +}
> > --
> > 2.39.2
> >
