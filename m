Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150BE5B4520
	for <lists+linux-efi@lfdr.de>; Sat, 10 Sep 2022 10:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiIJIMN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 10 Sep 2022 04:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIJIMM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 10 Sep 2022 04:12:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C6484EF1;
        Sat, 10 Sep 2022 01:12:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24E066115A;
        Sat, 10 Sep 2022 08:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A16C433C1;
        Sat, 10 Sep 2022 08:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662797529;
        bh=0DxQy5CttLgojIPCKyl5ZWyJOoAHRG4YOaNwSG82daM=;
        h=From:To:Cc:Subject:Date:From;
        b=JcqqcXGhGuSiWqICxMxMoELzg7CfhoRJnsduKxf3EG8N87Q8HCMmlznWQfcXW6qYk
         TPU6j9SO3CjdQmrmuuBQhLSxnUEH3r64Xjq4vz8TvptSh2AcMRsS97sNQ9ErXL5rNb
         Zm9+Km+pIQ/VgUnjJ1D6hmOo7AkXQkyuLcaC/TFTjZDGmYZQQBcuJkcQOYUtlEOfBb
         IabSBy+Gzil8+PbrU2nSBwn6Sn6ozIlVqlhGz5xf0BataUN2GHTKJ8RzByGQs9Qe4X
         5wH5p1NDOJ7drt6Nz2H6sMfimVI7g+xvEonxAjD+ivgXgdIaSRUr7I3Nv8TJ7rPol+
         Ht4KQxIgxXgPA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
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
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v5 0/8] efi: implement generic compressed boot support
Date:   Sat, 10 Sep 2022 10:11:44 +0200
Message-Id: <20220910081152.2238369-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7437; i=ardb@kernel.org; h=from:subject; bh=0DxQy5CttLgojIPCKyl5ZWyJOoAHRG4YOaNwSG82daM=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjHEa9K6XmcUMI0fvxsU29KDHZbD1WjarndMtbnD2A peWjacSJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYxxGvQAKCRDDTyI5ktmPJMJtDA CWayoJHowEBPOn0VBVgwp0VNNdKO8tJiS6Z1udXEfSac/n+ry+Ram1S+FnsioF/tK06Pvlet3Mb4/Y P/efv576LtWDm8IV8fsrbiWgOLO45A68lMxj4j7Mga9PucgV1Cbkw6apdS/SWReuBq0WeU4dOnSs1e sjmJUCKduTDB1cC+pzG9YIJ6ZgOYtQr1G/hpJdAPwrZlu2HgUxBZMmewYicgBvG+krUoEZGPztxGSq 2pT9MX5o6MDiyFKo8u+joiKwtNRnREv/L0XQOuhHFjArFOSeC10mrX+VsiIN4clX51LnByXrlQ1c8c KvSlPlx5XRug6lykl1sH6Z6/BmDfZsu4hxudNgaAPjoArmJ6+ANRcdX5aqhEzcmTcTCRN4ohAhiYTy fCBQNnFNNgQUnH9lPoO24IaZxgFCpozcsf0lSdaKNlNBm7i90TTWxh7sQjh2Oze4cojVUGP6HPz7uJ oPPf3yb8kU13AyCVUWHHIGt01/sMQ5UYHnQ5lSDVIDbIU=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Relatively modern architectures such as arm64 or RISC-V don't implement
a self-decompressing kernel, and leave it up to the bootloader to
decompress the compressed image before executing it. For bare metal
boot, this policy makes sense, as a self-decompressing image essentially
duplicates a lot of fiddly preparation work to create a 1:1 mapping and
set up the C runtime, and to discover or infer where DRAM lives from
device trees or other firmware tables.

For EFI boot, the situation is a bit different: the EFI entrypoint is
called with a 1:1 cached mapping covering all of DRAM already active,
and with a stack, a heap, a memory map and boot services to load and
start images. This means it is rather trivial to implement a
self-decompressing wrapper for EFI boot in a generic manner, and reuse
it across architectures that implement EFI boot.

The only slight downside is that when UEFI secure boot is enabled, the
generic LoadImage/StartImage only allow signed images to be loaded and
started, and we would prefer to avoid the need to sign both the inner
and outer PE/COFF images.

However, the only truly generic and portable way to achieve this is to
rely on LoadImage/StartImage as the EFI spec defines them, and avoid
making assumptions about how things might work under the hood, and how
we might circumvent that. This includes just loading the image into
memory and jumping to the PE entry point: in the context of secure boot,
measured boot and other hardening measures the firmware may take (such
as disallowing mappings that are both writable and executable), using
the firmware's image loading API is the only maintainable choice.

For this reason, this version of the series includes support for signing
the images using sbsign, if the signing key and cert are specified in
Kconfig.

The code is wired up for arm64, LoongArch and RISC-V. The latter was
build tested only.

Changes since v4:
- make CONFIG_EFI_ZBOOT user selectable again, and turn it on by default
  only for LoongArch
- set KBUILD_IMAGE to vmlinuz.efi if CONFIG_EFI_ZBOOT=y, so that make
  targets such as zinstall and bindeb-pkg do the right thing
- throw an error is BSS was not cleared by the loader - this is needed
  to detect broken distro implementations of LoadImage in shim and grub
- add vmlinuz.* to .gitignore on the various architectures
- switch back to defining uncompressed_size as 'extern __aligned(1)' so
  that the compiler will perform the unaligned access as appropriate on
  the architecture in question - this requires the latest binutils on
  LoongArch [0]

Changes since v3:
- add support for XZ and ZSTD compression
- deal with exit data returned by StartImage()
- use LoadFile2 based image loading instead of passing the raw buffer -
  this way, the provenance of the data is more visible, allowing us,
  for instance, to deal with initrd= on arm64 transparently (this means
  that systemd-boot on arm64 will work unmodified provided that the
  [deprecated] command line initrd loader is enabled in the kernel
  build)
- include LoongArch support
- rename compressed image to vmlinuz.efi on all architectures

Changes since v2:
- drop some of the refactoring work to make efi_printk() available in
  the decompressor, and just use fixed strings instead;
- provide memcpy/memmove/memset based on the UEFI boot services, instead
  of having to specify for each architecture how to wire these up;
- drop PI/DXE based signature check circumvention, and just sign the
  inner image instead, if needed;
- add a header to the zimage binary that identifies it as a EFI zboot
  image, and describes the compression algorithm and where the payload
  lives in the image - this might be used by non-EFI loaders to locate
  and decompress the bare metal image, given that the EFI zboot one is
  not a hybrid like the one it encapsulates.

[0] https://sourceware.org/pipermail/binutils/2022-September/122713.html

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Peter Jones <pjones@redhat.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Atish Patra <atishp@atishpatra.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Xi Ruoyao <xry111@xry111.site>
Cc: Lennart Poettering <lennart@poettering.net>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>

Ard Biesheuvel (8):
  efi: name the ARCH-stub.c files uniformly
  efi/libstub: add some missing EFI prototypes
  efi/libstub: use EFI provided memcpy/memset routines
  efi/libstub: move efi_system_table global var into separate object
  efi/libstub: implement generic EFI zboot
  arm64: efi: enable generic EFI compressed boot
  riscv: efi: enable generic EFI compressed boot
  loongarch: efi: enable generic EFI compressed boot

 arch/arm64/Makefile                                       |   9 +-
 arch/arm64/boot/.gitignore                                |   1 +
 arch/arm64/boot/Makefile                                  |   6 +
 arch/arm64/kernel/image-vars.h                            |  13 -
 arch/loongarch/Kconfig                                    |   1 +
 arch/loongarch/Makefile                                   |   4 +-
 arch/loongarch/boot/.gitignore                            |   1 +
 arch/loongarch/boot/Makefile                              |   6 +
 arch/loongarch/kernel/image-vars.h                        |   3 -
 arch/riscv/Makefile                                       |   6 +-
 arch/riscv/boot/.gitignore                                |   1 +
 arch/riscv/boot/Makefile                                  |   6 +
 arch/riscv/kernel/image-vars.h                            |   9 -
 drivers/firmware/efi/Kconfig                              |  38 +++
 drivers/firmware/efi/libstub/Makefile                     |  21 +-
 drivers/firmware/efi/libstub/Makefile.zboot               |  70 +++++
 drivers/firmware/efi/libstub/{arm32-stub.c => arm-stub.c} |   0
 drivers/firmware/efi/libstub/efi-stub.c                   |   2 -
 drivers/firmware/efi/libstub/efistub.h                    |  35 ++-
 drivers/firmware/efi/libstub/file.c                       |  17 ++
 drivers/firmware/efi/libstub/intrinsics.c                 |  30 ++
 drivers/firmware/efi/libstub/systable.c                   |   8 +
 drivers/firmware/efi/libstub/zboot-header.S               | 143 ++++++++++
 drivers/firmware/efi/libstub/zboot.c                      | 296 ++++++++++++++++++++
 drivers/firmware/efi/libstub/zboot.lds                    |  43 +++
 include/linux/efi.h                                       |  13 +
 26 files changed, 732 insertions(+), 50 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/Makefile.zboot
 rename drivers/firmware/efi/libstub/{arm32-stub.c => arm-stub.c} (100%)
 create mode 100644 drivers/firmware/efi/libstub/intrinsics.c
 create mode 100644 drivers/firmware/efi/libstub/systable.c
 create mode 100644 drivers/firmware/efi/libstub/zboot-header.S
 create mode 100644 drivers/firmware/efi/libstub/zboot.c
 create mode 100644 drivers/firmware/efi/libstub/zboot.lds

-- 
2.35.1

