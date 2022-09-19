Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2F55BC156
	for <lists+linux-efi@lfdr.de>; Mon, 19 Sep 2022 04:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiISCWg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 18 Sep 2022 22:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiISCWg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 18 Sep 2022 22:22:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 234F813F1A;
        Sun, 18 Sep 2022 19:22:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C065613D5;
        Sun, 18 Sep 2022 19:22:39 -0700 (PDT)
Received: from [192.168.122.164] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B0F33F73B;
        Sun, 18 Sep 2022 19:22:32 -0700 (PDT)
Message-ID: <a7bb4b9f-61bf-c951-19a6-5b099c399524@arm.com>
Date:   Sun, 18 Sep 2022 21:22:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 0/8] efi: implement generic compressed boot support
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20220910081152.2238369-1-ardb@kernel.org>
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20220910081152.2238369-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

With the BSS "fix" in grub for fedora/rhel, this is now working fine for 
both systemd-boot and normal grub2, as well as booting directly from the 
UEFI shell. Given both the magic number and the bss fix were merged at 
the same time I don't think anyone should ever see the bad bss message, 
at least not on the above distro's.

I've largely been testing this on the PFTF/RPi4, and in a libvirt 
qemu/kvm env with/without ksan/etc on a mostly fedora configured kernel. 
Hooking this up to kinstall makes sense and works, although i'm not a 
big fan.

So, its looking good. All thumbs up here :)

Tested-by: Jeremy Linton <jeremy.linton@arm.com>


On 9/10/22 03:11, Ard Biesheuvel wrote:
> Relatively modern architectures such as arm64 or RISC-V don't implement
> a self-decompressing kernel, and leave it up to the bootloader to
> decompress the compressed image before executing it. For bare metal
> boot, this policy makes sense, as a self-decompressing image essentially
> duplicates a lot of fiddly preparation work to create a 1:1 mapping and
> set up the C runtime, and to discover or infer where DRAM lives from
> device trees or other firmware tables.
> 
> For EFI boot, the situation is a bit different: the EFI entrypoint is
> called with a 1:1 cached mapping covering all of DRAM already active,
> and with a stack, a heap, a memory map and boot services to load and
> start images. This means it is rather trivial to implement a
> self-decompressing wrapper for EFI boot in a generic manner, and reuse
> it across architectures that implement EFI boot.
> 
> The only slight downside is that when UEFI secure boot is enabled, the
> generic LoadImage/StartImage only allow signed images to be loaded and
> started, and we would prefer to avoid the need to sign both the inner
> and outer PE/COFF images.
> 
> However, the only truly generic and portable way to achieve this is to
> rely on LoadImage/StartImage as the EFI spec defines them, and avoid
> making assumptions about how things might work under the hood, and how
> we might circumvent that. This includes just loading the image into
> memory and jumping to the PE entry point: in the context of secure boot,
> measured boot and other hardening measures the firmware may take (such
> as disallowing mappings that are both writable and executable), using
> the firmware's image loading API is the only maintainable choice.
> 
> For this reason, this version of the series includes support for signing
> the images using sbsign, if the signing key and cert are specified in
> Kconfig.
> 
> The code is wired up for arm64, LoongArch and RISC-V. The latter was
> build tested only.
> 
> Changes since v4:
> - make CONFIG_EFI_ZBOOT user selectable again, and turn it on by default
>    only for LoongArch
> - set KBUILD_IMAGE to vmlinuz.efi if CONFIG_EFI_ZBOOT=y, so that make
>    targets such as zinstall and bindeb-pkg do the right thing
> - throw an error is BSS was not cleared by the loader - this is needed
>    to detect broken distro implementations of LoadImage in shim and grub
> - add vmlinuz.* to .gitignore on the various architectures
> - switch back to defining uncompressed_size as 'extern __aligned(1)' so
>    that the compiler will perform the unaligned access as appropriate on
>    the architecture in question - this requires the latest binutils on
>    LoongArch [0]
> 
> Changes since v3:
> - add support for XZ and ZSTD compression
> - deal with exit data returned by StartImage()
> - use LoadFile2 based image loading instead of passing the raw buffer -
>    this way, the provenance of the data is more visible, allowing us,
>    for instance, to deal with initrd= on arm64 transparently (this means
>    that systemd-boot on arm64 will work unmodified provided that the
>    [deprecated] command line initrd loader is enabled in the kernel
>    build)
> - include LoongArch support
> - rename compressed image to vmlinuz.efi on all architectures
> 
> Changes since v2:
> - drop some of the refactoring work to make efi_printk() available in
>    the decompressor, and just use fixed strings instead;
> - provide memcpy/memmove/memset based on the UEFI boot services, instead
>    of having to specify for each architecture how to wire these up;
> - drop PI/DXE based signature check circumvention, and just sign the
>    inner image instead, if needed;
> - add a header to the zimage binary that identifies it as a EFI zboot
>    image, and describes the compression algorithm and where the payload
>    lives in the image - this might be used by non-EFI loaders to locate
>    and decompress the bare metal image, given that the EFI zboot one is
>    not a hybrid like the one it encapsulates.
> 
> [0] https://sourceware.org/pipermail/binutils/2022-September/122713.html
> 
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> Cc: Peter Jones <pjones@redhat.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Atish Patra <atishp@atishpatra.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Huacai Chen <chenhuacai@loongson.cn>
> Cc: Xi Ruoyao <xry111@xry111.site>
> Cc: Lennart Poettering <lennart@poettering.net>
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> 
> Ard Biesheuvel (8):
>    efi: name the ARCH-stub.c files uniformly
>    efi/libstub: add some missing EFI prototypes
>    efi/libstub: use EFI provided memcpy/memset routines
>    efi/libstub: move efi_system_table global var into separate object
>    efi/libstub: implement generic EFI zboot
>    arm64: efi: enable generic EFI compressed boot
>    riscv: efi: enable generic EFI compressed boot
>    loongarch: efi: enable generic EFI compressed boot
> 
>   arch/arm64/Makefile                                       |   9 +-
>   arch/arm64/boot/.gitignore                                |   1 +
>   arch/arm64/boot/Makefile                                  |   6 +
>   arch/arm64/kernel/image-vars.h                            |  13 -
>   arch/loongarch/Kconfig                                    |   1 +
>   arch/loongarch/Makefile                                   |   4 +-
>   arch/loongarch/boot/.gitignore                            |   1 +
>   arch/loongarch/boot/Makefile                              |   6 +
>   arch/loongarch/kernel/image-vars.h                        |   3 -
>   arch/riscv/Makefile                                       |   6 +-
>   arch/riscv/boot/.gitignore                                |   1 +
>   arch/riscv/boot/Makefile                                  |   6 +
>   arch/riscv/kernel/image-vars.h                            |   9 -
>   drivers/firmware/efi/Kconfig                              |  38 +++
>   drivers/firmware/efi/libstub/Makefile                     |  21 +-
>   drivers/firmware/efi/libstub/Makefile.zboot               |  70 +++++
>   drivers/firmware/efi/libstub/{arm32-stub.c => arm-stub.c} |   0
>   drivers/firmware/efi/libstub/efi-stub.c                   |   2 -
>   drivers/firmware/efi/libstub/efistub.h                    |  35 ++-
>   drivers/firmware/efi/libstub/file.c                       |  17 ++
>   drivers/firmware/efi/libstub/intrinsics.c                 |  30 ++
>   drivers/firmware/efi/libstub/systable.c                   |   8 +
>   drivers/firmware/efi/libstub/zboot-header.S               | 143 ++++++++++
>   drivers/firmware/efi/libstub/zboot.c                      | 296 ++++++++++++++++++++
>   drivers/firmware/efi/libstub/zboot.lds                    |  43 +++
>   include/linux/efi.h                                       |  13 +
>   26 files changed, 732 insertions(+), 50 deletions(-)
>   create mode 100644 drivers/firmware/efi/libstub/Makefile.zboot
>   rename drivers/firmware/efi/libstub/{arm32-stub.c => arm-stub.c} (100%)
>   create mode 100644 drivers/firmware/efi/libstub/intrinsics.c
>   create mode 100644 drivers/firmware/efi/libstub/systable.c
>   create mode 100644 drivers/firmware/efi/libstub/zboot-header.S
>   create mode 100644 drivers/firmware/efi/libstub/zboot.c
>   create mode 100644 drivers/firmware/efi/libstub/zboot.lds
> 

