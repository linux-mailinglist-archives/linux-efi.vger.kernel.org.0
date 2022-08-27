Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B334B5A3604
	for <lists+linux-efi@lfdr.de>; Sat, 27 Aug 2022 10:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiH0IjR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Aug 2022 04:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbiH0IjP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Aug 2022 04:39:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D8DC12E8
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 01:39:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 046696131A
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 08:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F49FC433C1;
        Sat, 27 Aug 2022 08:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661589549;
        bh=HxToph8cCgHQ6c4CKL40Ys8Y/jwOmvFtR27Hg+iZj/U=;
        h=From:To:Cc:Subject:Date:From;
        b=S8hblle60Azfmteg8MGtOkV+7u4AKNBF+ZdRIIG5N1Sr7dE6PQ23ZMmpzview59IH
         gdPye6aYo7YtrA3WJERxekHMczOY+rEOh2sKl/tsK+/ApLoFgWNy8JMkJDxpaPzx6J
         iZ6KVcUhviFi56PgjCNL6GJs+b/s7mRwjDdqCl3s/BvGOx6YUFP32/wPjCyGcboT9I
         CM0lqz/B9C1oBkt7kPbvOuJ4wn6hNYfFsi/7ptHvtcMmzh0s6c+1P4E1jH5MOgEHnb
         JhYD4thdDq8DAAz2bZEqQYUeCstnH5nAWYvVOXK2VXJBQI8AWjzTCzxDKbs6W4GMAh
         aO4HB4YCOveuQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
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
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v4 0/9] efi: implement generic compressed boot support
Date:   Sat, 27 Aug 2022 10:38:41 +0200
Message-Id: <20220827083850.2702465-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6504; i=ardb@kernel.org; h=from:subject; bh=HxToph8cCgHQ6c4CKL40Ys8Y/jwOmvFtR27Hg+iZj/U=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjCdgKURKN5oZa/82DCEm8gzQqr60wAfJZe3TQ+hr3 pUblXfSJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYwnYCgAKCRDDTyI5ktmPJP8VC/ kBqVSIqOtp7iOOi1i3LGS4vFczSdvaKJBu6nOG7VJHDAcRt+Awns8/NbpftteJWjLMMZEx8arLVgVp bm03hVxQwzHax2X/kc9luvpMBQJ9pdEXSZ/z2BszsE6l1OC9KUlKno/yJjm8ACCFqgETAgJ6uuLwxB rR92SJjlyvf1Xy1fI3OEsqqrDNBayWbHSHsjHjIoML4M+cJDX0F8CQrEA2RjoirRy1Y65rmmI/vOVY 3wP0As1ZaRko9Kq4DQRMZJLKyZgfOivzJqcD0QvQAwDvOBpIhfQfnOKlZBa5GAPfyzOGcPrQiY0FH3 C2y978QNN0a1kU86zDXpy+El1MbKTHcL8jOqzO3cpkTGnoymcbIHO7gil2qfoYl/3kaKYIkMUwR0RZ D6wAvdo0QYV3mHRTqhYjlwQBKVeD4I2ETAgYaV9ccHv/jY4GmdHPdXNB6YjT0YVSdoPW+aedztZgmh JK5alBrXQxO5iLicShQsrB2qTUx4fE0JMfdiP6oVP1Huk=
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

Ard Biesheuvel (9):
  efi: name the ARCH-stub.c files uniformly
  efi/libstub: add some missing boot service prototypes
  efi/libstub: use EFI provided memcpy/memset routines
  efi/libstub: move efi_system_table global var into separate object
  efi/libstub: implement generic EFI zboot
  arm64: efi: enable generic EFI compressed boot
  riscv: efi: enable generic EFI compressed boot
  loongarch: avoid orphan input sections
  loongarch: efi: enable generic EFI compressed boot

 arch/arm64/Makefile                                       |   4 +-
 arch/arm64/boot/Makefile                                  |   6 +
 arch/arm64/kernel/image-vars.h                            |  13 -
 arch/loongarch/Kconfig                                    |   1 +
 arch/loongarch/Makefile                                   |   2 +-
 arch/loongarch/boot/Makefile                              |   6 +
 arch/loongarch/kernel/image-vars.h                        |   3 -
 arch/loongarch/kernel/vmlinux.lds.S                       |   2 +
 arch/riscv/Makefile                                       |   2 +-
 arch/riscv/boot/Makefile                                  |   6 +
 arch/riscv/kernel/image-vars.h                            |   9 -
 drivers/firmware/efi/Kconfig                              |  29 ++
 drivers/firmware/efi/libstub/Makefile                     |  21 +-
 drivers/firmware/efi/libstub/Makefile.zboot               |  70 +++++
 drivers/firmware/efi/libstub/{arm32-stub.c => arm-stub.c} |   0
 drivers/firmware/efi/libstub/efi-stub.c                   |   2 -
 drivers/firmware/efi/libstub/efistub.h                    |  35 ++-
 drivers/firmware/efi/libstub/file.c                       |  17 ++
 drivers/firmware/efi/libstub/intrinsics.c                 |  30 ++
 drivers/firmware/efi/libstub/systable.c                   |   8 +
 drivers/firmware/efi/libstub/zboot-header.S               | 139 ++++++++++
 drivers/firmware/efi/libstub/zboot.c                      | 289 ++++++++++++++++++++
 drivers/firmware/efi/libstub/zboot.lds                    |  41 +++
 include/linux/efi.h                                       |  13 +
 24 files changed, 699 insertions(+), 49 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/Makefile.zboot
 rename drivers/firmware/efi/libstub/{arm32-stub.c => arm-stub.c} (100%)
 create mode 100644 drivers/firmware/efi/libstub/intrinsics.c
 create mode 100644 drivers/firmware/efi/libstub/systable.c
 create mode 100644 drivers/firmware/efi/libstub/zboot-header.S
 create mode 100644 drivers/firmware/efi/libstub/zboot.c
 create mode 100644 drivers/firmware/efi/libstub/zboot.lds

-- 
2.35.1

