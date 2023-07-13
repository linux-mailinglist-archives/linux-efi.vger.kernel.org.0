Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55865752521
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jul 2023 16:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjGMOaX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jul 2023 10:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjGMOaX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jul 2023 10:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C921734;
        Thu, 13 Jul 2023 07:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E0356154E;
        Thu, 13 Jul 2023 14:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C192DC433C7;
        Thu, 13 Jul 2023 14:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689258619;
        bh=yKg3BrYOhEU0HoGvk9xujQHP6Hs/dP9W7vE9y0jOZvI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hNfItrS+vw/Y0FVeVzGDTtXJ+ykLEXQIbdzajH2dm9qbIvXrMN45EJwQLxmlcArNB
         FHS6B/oCyhkwQEIOOV8nLFXSxRU9ljUarQTJ1KKAfL1moWvPH1Um7qY58L9ivmnewF
         Wrv3VsRb9e/HP7cNKdAjGGtk1UM1jsM6/y/7EcV3Pqg7tJNaoWTF/0ZGi8cNwdECWw
         g0S0l3/LQmxaP0EibEpJal+yLrZTENVhswUX6+3kF9Arg+uk4N8DpnEVvuBVsG8CbR
         PO3zjhcIBhTo7xzwLcKOUaHSzNvkItJnt/RHQItp0MznS1dLf2E8OvPjnS2xI4d+T4
         i9qIPZ4ZKeA6g==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so1385733e87.2;
        Thu, 13 Jul 2023 07:30:19 -0700 (PDT)
X-Gm-Message-State: ABy/qLZd/MxyuwcnjlGOLGiE0/JutxKpfP/xDxqd1f5xe2sTcs1eSvDR
        bc1xPhlno7wGca05OMgGewTcIIvdVoLFgqpG4uQ=
X-Google-Smtp-Source: APBJJlGlxWZZoHKUh1qZ4cTJNawILNp1lMHy551UBtT5FhCL83JxVCB2ypeJGrQ0vx6AVxSVUFAVTqLkZZ2JPODP2Mc=
X-Received: by 2002:a2e:9617:0:b0:2b6:de63:6d3b with SMTP id
 v23-20020a2e9617000000b002b6de636d3bmr1612128ljh.21.1689258617662; Thu, 13
 Jul 2023 07:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230713133401.116506-1-alexghiti@rivosinc.com> <20230713133401.116506-4-alexghiti@rivosinc.com>
In-Reply-To: <20230713133401.116506-4-alexghiti@rivosinc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 13 Jul 2023 16:30:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGUxGMtH9Zcc93H+KvXRqdrH-Lx4UsE+HSzxdwnN16fmw@mail.gmail.com>
Message-ID: <CAMj1kXGUxGMtH9Zcc93H+KvXRqdrH-Lx4UsE+HSzxdwnN16fmw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] arm64: libstub: Move KASLR handling functions to efi-stub-helper.c
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Alexandre,

On Thu, 13 Jul 2023 at 15:37, Alexandre Ghiti <alexghiti@rivosinc.com> wrot=
e:
>
> This prepares for riscv to use the same functions to handle the p=C4=A5ys=
ical
> kernel move when KASLR is enabled.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/arm64/include/asm/efi.h                  |   4 +
>  arch/riscv/include/asm/efi.h                  |   1 +
>  drivers/firmware/efi/libstub/Makefile         |   3 +-
>  drivers/firmware/efi/libstub/arm64-stub.c     | 117 ++-----------
>  drivers/firmware/efi/libstub/efi-stub-kaslr.c | 159 ++++++++++++++++++

Please just call the file kaslr.c

>  drivers/firmware/efi/libstub/efistub.h        |  18 ++
>  6 files changed, 197 insertions(+), 105 deletions(-)
>  create mode 100644 drivers/firmware/efi/libstub/efi-stub-kaslr.c
>
> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> index 4cf2cb053bc8..83a4d69fd968 100644
> --- a/arch/arm64/include/asm/efi.h
> +++ b/arch/arm64/include/asm/efi.h
> @@ -111,6 +111,7 @@ static inline unsigned long efi_get_kimg_min_align(vo=
id)
>          */
>         return efi_nokaslr ? MIN_KIMG_ALIGN : EFI_KIMG_ALIGN;
>  }
> +#define efi_get_kimg_min_align efi_get_kimg_min_align
>
>  #define EFI_ALLOC_ALIGN                SZ_64K
>  #define EFI_ALLOC_LIMIT                ((1UL << 48) - 1)
> @@ -168,4 +169,7 @@ static inline void efi_capsule_flush_cache_range(void=
 *addr, int size)
>
>  efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f);
>
> +void efi_icache_sync(unsigned long start, unsigned long end);
> +#define efi_icache_sync        efi_icache_sync
> +

Given that arm64 is the only arch that needs to implement this, can we
just keep the call in arch code? I.e., after
efi_kaslr_relocate_kernel() if it returned with EFI_SUCCESS?


>  #endif /* _ASM_EFI_H */
> diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
> index 29e9a0d84b16..c3dafaab36a2 100644
> --- a/arch/riscv/include/asm/efi.h
> +++ b/arch/riscv/include/asm/efi.h
> @@ -43,6 +43,7 @@ static inline unsigned long efi_get_kimg_min_align(void=
)
>          */
>         return IS_ENABLED(CONFIG_64BIT) ? SZ_2M : SZ_4M;
>  }
> +#define efi_get_kimg_min_align efi_get_kimg_min_align
>
>  #define EFI_KIMG_PREFERRED_ADDRESS     efi_get_kimg_min_align()
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi=
/libstub/Makefile
> index 16d64a34d1e1..5927fab5c834 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -67,7 +67,8 @@ OBJECT_FILES_NON_STANDARD     :=3D y
>  # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
>  KCOV_INSTRUMENT                        :=3D n
>
> -lib-y                          :=3D efi-stub-helper.o gop.o secureboot.o=
 tpm.o \
> +lib-y                          :=3D efi-stub-helper.o efi-stub-kaslr.o \
> +                                  gop.o secureboot.o tpm.o \
>                                    file.o mem.o random.o randomalloc.o pc=
i.o \
>                                    skip_spaces.o lib-cmdline.o lib-ctype.=
o \
>                                    alignedmem.o relocate.o printk.o vspri=
ntf.o
> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware=
/efi/libstub/arm64-stub.c
> index 770b8ecb7398..452b7ccd330e 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -14,42 +14,6 @@
>
>  #include "efistub.h"
>
> -/*
> - * Distro versions of GRUB may ignore the BSS allocation entirely (i.e.,=
 fail
> - * to provide space, and fail to zero it). Check for this condition by d=
ouble
> - * checking that the first and the last byte of the image are covered by=
 the
> - * same EFI memory map entry.
> - */
> -static bool check_image_region(u64 base, u64 size)
> -{
> -       struct efi_boot_memmap *map;
> -       efi_status_t status;
> -       bool ret =3D false;
> -       int map_offset;
> -
> -       status =3D efi_get_memory_map(&map, false);
> -       if (status !=3D EFI_SUCCESS)
> -               return false;
> -
> -       for (map_offset =3D 0; map_offset < map->map_size; map_offset +=
=3D map->desc_size) {
> -               efi_memory_desc_t *md =3D (void *)map->map + map_offset;
> -               u64 end =3D md->phys_addr + md->num_pages * EFI_PAGE_SIZE=
;
> -
> -               /*
> -                * Find the region that covers base, and return whether
> -                * it covers base+size bytes.
> -                */
> -               if (base >=3D md->phys_addr && base < end) {
> -                       ret =3D (base + size) <=3D end;
> -                       break;
> -               }
> -       }
> -
> -       efi_bs_call(free_pool, map);
> -
> -       return ret;
> -}
> -
>  efi_status_t handle_kernel_image(unsigned long *image_addr,
>                                  unsigned long *image_size,
>                                  unsigned long *reserve_addr,
> @@ -59,31 +23,6 @@ efi_status_t handle_kernel_image(unsigned long *image_=
addr,
>  {
>         efi_status_t status;
>         unsigned long kernel_size, kernel_codesize, kernel_memsize;
> -       u32 phys_seed =3D 0;
> -       u64 min_kimg_align =3D efi_get_kimg_min_align();
> -
> -       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
> -               efi_guid_t li_fixed_proto =3D LINUX_EFI_LOADED_IMAGE_FIXE=
D_GUID;
> -               void *p;
> -
> -               if (efi_nokaslr) {
> -                       efi_info("KASLR disabled on kernel command line\n=
");
> -               } else if (efi_bs_call(handle_protocol, image_handle,
> -                                      &li_fixed_proto, &p) =3D=3D EFI_SU=
CCESS) {
> -                       efi_info("Image placement fixed by loader\n");
> -               } else {
> -                       status =3D efi_get_random_bytes(sizeof(phys_seed)=
,
> -                                                     (u8 *)&phys_seed);
> -                       if (status =3D=3D EFI_NOT_FOUND) {
> -                               efi_info("EFI_RNG_PROTOCOL unavailable\n"=
);
> -                               efi_nokaslr =3D true;
> -                       } else if (status !=3D EFI_SUCCESS) {
> -                               efi_err("efi_get_random_bytes() failed (0=
x%lx)\n",
> -                                       status);
> -                               efi_nokaslr =3D true;
> -                       }
> -               }
> -       }
>
>         if (image->image_base !=3D _text) {
>                 efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base has=
 bogus value\n");
> @@ -98,50 +37,15 @@ efi_status_t handle_kernel_image(unsigned long *image=
_addr,
>         kernel_codesize =3D __inittext_end - _text;
>         kernel_memsize =3D kernel_size + (_end - _edata);
>         *reserve_size =3D kernel_memsize;
> +       *image_addr =3D (unsigned long)_text;
>
> -       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && phys_seed !=3D 0) {
> -               /*
> -                * If KASLR is enabled, and we have some randomness avail=
able,
> -                * locate the kernel at a randomized offset in physical m=
emory.
> -                */
> -               status =3D efi_random_alloc(*reserve_size, min_kimg_align=
,
> -                                         reserve_addr, phys_seed,
> -                                         EFI_LOADER_CODE);
> -               if (status !=3D EFI_SUCCESS)
> -                       efi_warn("efi_random_alloc() failed: 0x%lx\n", st=
atus);
> -       } else {
> -               status =3D EFI_OUT_OF_RESOURCES;
> -       }
> -
> -       if (status !=3D EFI_SUCCESS) {
> -               if (!check_image_region((u64)_text, kernel_memsize)) {
> -                       efi_err("FIRMWARE BUG: Image BSS overlaps adjacen=
t EFI memory region\n");
> -               } else if (IS_ALIGNED((u64)_text, min_kimg_align) &&
> -                          (u64)_end < EFI_ALLOC_LIMIT) {
> -                       /*
> -                        * Just execute from wherever we were loaded by t=
he
> -                        * UEFI PE/COFF loader if the placement is suitab=
le.
> -                        */
> -                       *image_addr =3D (u64)_text;
> -                       *reserve_size =3D 0;
> -                       return EFI_SUCCESS;
> -               }
> -
> -               status =3D efi_allocate_pages_aligned(*reserve_size, rese=
rve_addr,
> -                                                   ULONG_MAX, min_kimg_a=
lign,
> -                                                   EFI_LOADER_CODE);
> -
> -               if (status !=3D EFI_SUCCESS) {
> -                       efi_err("Failed to relocate kernel\n");
> -                       *reserve_size =3D 0;
> -                       return status;
> -               }
> -       }
> -
> -       *image_addr =3D *reserve_addr;
> -       memcpy((void *)*image_addr, _text, kernel_size);
> -       caches_clean_inval_pou(*image_addr, *image_addr + kernel_codesize=
);
> -       efi_remap_image(*image_addr, *reserve_size, kernel_codesize);
> +       status =3D efi_kaslr_relocate_kernel(image_addr,
> +                                          reserve_addr, reserve_size,
> +                                          kernel_size, kernel_codesize,
> +                                          kernel_memsize,
> +                                          efi_kaslr_get_phys_seed(image_=
handle));
> +       if (status !=3D EFI_SUCCESS)
> +               return status;
>
>         return EFI_SUCCESS;
>  }
> @@ -159,3 +63,8 @@ unsigned long primary_entry_offset(void)
>          */
>         return (char *)primary_entry - _text;
>  }
> +
> +void efi_icache_sync(unsigned long start, unsigned long end)
> +{
> +       caches_clean_inval_pou(start, end);
> +}
> diff --git a/drivers/firmware/efi/libstub/efi-stub-kaslr.c b/drivers/firm=
ware/efi/libstub/efi-stub-kaslr.c
> new file mode 100644
> index 000000000000..be0c8ab0982a
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/efi-stub-kaslr.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Helper functions used by the EFI stub on multiple
> + * architectures to deal with physical address space randomization.
> + */
> +#include <linux/efi.h>
> +
> +#include "efistub.h"
> +
> +/**
> + * efi_kaslr_get_phys_seed() - Get random seed for physical kernel KASLR
> + * @image_handle:      Handle to the image
> + *
> + * If KASLR is not disabled, obtain a random seed using EFI_RNG_PROTOCOL
> + * that will be used to move the kernel physical mapping.
> + *
> + * Return:     the random seed
> + */
> +u32 efi_kaslr_get_phys_seed(efi_handle_t image_handle)
> +{
> +       efi_status_t status;
> +       u32 phys_seed;
> +       efi_guid_t li_fixed_proto =3D LINUX_EFI_LOADED_IMAGE_FIXED_GUID;
> +       void *p;
> +
> +       if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> +               return 0;
> +
> +       if (efi_nokaslr) {
> +               efi_info("KASLR disabled on kernel command line\n");
> +       } else if (efi_bs_call(handle_protocol, image_handle,
> +                              &li_fixed_proto, &p) =3D=3D EFI_SUCCESS) {
> +               efi_info("Image placement fixed by loader\n");
> +       } else {
> +               status =3D efi_get_random_bytes(sizeof(phys_seed),
> +                                             (u8 *)&phys_seed);
> +               if (status =3D=3D EFI_SUCCESS) {
> +                       return phys_seed;
> +               } else if (status =3D=3D EFI_NOT_FOUND) {
> +                       efi_info("EFI_RNG_PROTOCOL unavailable\n");
> +                       efi_nokaslr =3D true;
> +               } else if (status !=3D EFI_SUCCESS) {
> +                       efi_err("efi_get_random_bytes() failed (0x%lx)\n"=
,
> +                               status);
> +                       efi_nokaslr =3D true;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * Distro versions of GRUB may ignore the BSS allocation entirely (i.e.,=
 fail
> + * to provide space, and fail to zero it). Check for this condition by d=
ouble
> + * checking that the first and the last byte of the image are covered by=
 the
> + * same EFI memory map entry.
> + */
> +static bool check_image_region(u64 base, u64 size)
> +{
> +       struct efi_boot_memmap *map;
> +       efi_status_t status;
> +       bool ret =3D false;
> +       int map_offset;
> +
> +       status =3D efi_get_memory_map(&map, false);
> +       if (status !=3D EFI_SUCCESS)
> +               return false;
> +
> +       for (map_offset =3D 0; map_offset < map->map_size; map_offset +=
=3D map->desc_size) {
> +               efi_memory_desc_t *md =3D (void *)map->map + map_offset;
> +               u64 end =3D md->phys_addr + md->num_pages * EFI_PAGE_SIZE=
;
> +
> +               /*
> +                * Find the region that covers base, and return whether
> +                * it covers base+size bytes.
> +                */
> +               if (base >=3D md->phys_addr && base < end) {
> +                       ret =3D (base + size) <=3D end;
> +                       break;
> +               }
> +       }
> +
> +       efi_bs_call(free_pool, map);
> +
> +       return ret;
> +}
> +
> +/**
> + * efi_kaslr_relocate_kernel() - Relocate the kernel (random if KASLR en=
abled)
> + * @image_addr: Pointer to the current kernel location
> + * @reserve_addr:      Pointer to the relocated kernel location
> + * @reserve_size:      Size of the relocated kernel
> + * @kernel_size:       Size of the text + data
> + * @kernel_codesize:   Size of the text
> + * @kernel_memsize:    Size of the text + data + bss
> + * @phys_seed:         Random seed used for the relocation
> + *
> + * If KASLR is not enabled, this function relocates the kernel to a fixe=
d
> + * address (or leave it as its current location). If KASLR is enabled, t=
he
> + * kernel physical location is randomized using the seed in parameter.
> + *
> + * Return:     status code, EFI_SUCCESS if relocation is successful
> + */
> +efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
> +                                      unsigned long *reserve_addr,
> +                                      unsigned long *reserve_size,
> +                                      unsigned long kernel_size,
> +                                      unsigned long kernel_codesize,
> +                                      unsigned long kernel_memsize,
> +                                      u32 phys_seed)
> +{
> +       efi_status_t status;
> +       u64 min_kimg_align =3D efi_get_kimg_min_align();
> +
> +       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && phys_seed !=3D 0) {
> +               /*
> +                * If KASLR is enabled, and we have some randomness avail=
able,
> +                * locate the kernel at a randomized offset in physical m=
emory.
> +                */
> +               status =3D efi_random_alloc(*reserve_size, min_kimg_align=
,
> +                                         reserve_addr, phys_seed,
> +                                         EFI_LOADER_CODE);
> +               if (status !=3D EFI_SUCCESS)
> +                       efi_warn("efi_random_alloc() failed: 0x%lx\n", st=
atus);
> +       } else {
> +               status =3D EFI_OUT_OF_RESOURCES;
> +       }
> +
> +       if (status !=3D EFI_SUCCESS) {
> +               if (!check_image_region(*image_addr, kernel_memsize)) {
> +                       efi_err("FIRMWARE BUG: Image BSS overlaps adjacen=
t EFI memory region\n");
> +               } else if (IS_ALIGNED(*image_addr, min_kimg_align) &&
> +                          (u64)_end < EFI_ALLOC_LIMIT) {
> +                       /*
> +                        * Just execute from wherever we were loaded by t=
he
> +                        * UEFI PE/COFF loader if the placement is suitab=
le.
> +                        */
> +                       *reserve_size =3D 0;
> +                       return EFI_SUCCESS;
> +               }
> +
> +               status =3D efi_allocate_pages_aligned(*reserve_size, rese=
rve_addr,
> +                                                   ULONG_MAX, min_kimg_a=
lign,
> +                                                   EFI_LOADER_CODE);
> +
> +               if (status !=3D EFI_SUCCESS) {
> +                       efi_err("Failed to relocate kernel\n");
> +                       *reserve_size =3D 0;
> +                       return status;
> +               }
> +       }
> +
> +       memcpy((void *)*reserve_addr, (void *)*image_addr, kernel_size);
> +       *image_addr =3D *reserve_addr;
> +       efi_icache_sync(*image_addr, *image_addr + kernel_codesize);
> +       efi_remap_image(*image_addr, *reserve_size, kernel_codesize);
> +
> +       return status;
> +}
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/ef=
i/libstub/efistub.h
> index 6aa38a1bf126..35337ea5056e 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -1132,6 +1132,24 @@ const u8 *__efi_get_smbios_string(const struct efi=
_smbios_record *record,
>
>  void efi_remap_image(unsigned long image_base, unsigned alloc_size,
>                      unsigned long code_size);
> +efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
> +                                      unsigned long *reserve_addr,
> +                                      unsigned long *reserve_size,
> +                                      unsigned long kernel_size,
> +                                      unsigned long kernel_codesize,
> +                                      unsigned long kernel_memsize,
> +                                      u32 phys_seed);
> +u32 efi_kaslr_get_phys_seed(efi_handle_t image_handle);
> +
> +#ifndef efi_get_kimg_min_align
> +static inline unsigned long efi_get_kimg_min_align(void) { return 0; }

Shouldn't this be EFI_PAGE_SIZE at least? Surely, the RISC-V kernel
image has some minimal alignment?


> +#define efi_get_kimg_min_align efi_get_kimg_min_align
> +#endif
> +
> +#ifndef efi_icache_sync
> +static inline void efi_icache_sync(unsigned long start, unsigned long en=
d) {}
> +#define efi_icache_sync        efi_icache_sync
> +#endif
>
>  asmlinkage efi_status_t __efiapi
>  efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab);
> --
> 2.39.2
>
