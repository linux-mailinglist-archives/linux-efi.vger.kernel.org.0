Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCAB601485
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 19:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJQRRU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 13:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJQRRT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 13:17:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EEF6E2D5
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 10:17:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B5B6611D8
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 17:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC47C433D6;
        Mon, 17 Oct 2022 17:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027038;
        bh=VONHlqBF6jJ7zbfGqBrKGB+8E0OoP1Lhi/+6ppYG+R4=;
        h=From:To:Cc:Subject:Date:From;
        b=L9y99z3MfEiMUBEJauKovdlYoHYMRpTBXQDCAEmoxTruV5ROaUwBXRAADMThKwICQ
         ZIHsoc+K7xCq0Cfwz/vsQX1bOnmSYJUcqEVbB1k3/6rACpW8tCMb/hJYNL5cZ0a1Yb
         D9inPkuhTRmMGpc36JAKDrkFkHqfUmYZczilaBnUdZzlnxOAM++F0ZYH328BDeGuOs
         G5XYkqwS0zk+A37a/XQB4c30FLk7FD9b8rWnZO8IM3jaW3shLCcL97bKyQZ4EzTzSO
         XtiYWILiFTK9zc1vwfaScOoijJ6/dQeVMv18wV9R4QW+vDa9czVYIH1BNem/Fj0kst
         Aak8tfh//Gt3A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 00/21] efi: Combine stub functionality with zboot decompressor
Date:   Mon, 17 Oct 2022 19:16:39 +0200
Message-Id: <20221017171700.3736890-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6421; i=ardb@kernel.org; h=from:subject; bh=VONHlqBF6jJ7zbfGqBrKGB+8E0OoP1Lhi/+6ppYG+R4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTY3o8G4lAfDJzKkYEsnYI1bEzitzTfmJVVF0HHYf wFwtedyJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY02N6AAKCRDDTyI5ktmPJJ6CC/ 9ztk1lY4pDb1cBGORVhukeowIHwU7pMAK7D68OGZnI0C+liV96UaSRdBFn7I3aDPDiE2/tdUh1sUwR E81E0JB/Xj3yTT1za3pzLJN3g29tCbBr/Wp0Dv1DDhxEDT7Gi3WObY/t/Zc/HmIkhQc3oQX2b31tIt mfW10FiCCiwzM9bfTCeRatZvNQW/yKhv5RTP0DOxfvz3kLSxTr7qf8FlZa9klOE4vKIojF6S1w5d7l UrKwM9iHDKaDZVeV9Qu01clyywbOnv/VKeeRHGu7vagd1pv1JlXKcRkmKRkFy20lzkDFap/wbbNs+U FeCIxM/RnepcNX+HmuF1cIKEXmKsXXG+otJ3mRGUID7ONLbyKpzvDr/kT6xrDTIUcvA9LZlMsYu+c4 s+zwseSCkuBTDi8WK2JDaOp5YpdML8f3tiEDfBUyjXzEs8+KMmOhJVrJVLYccyU1dh6RJ/3p77GmPO FhU1CFD8KqnF1dYDJCEGW+jarpPI/NLhbY/frXjpBD7Bw=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI zboot decompression code that has been merged into v6.1-rc1 is
fully generic, and relies on the EFI stub inside the encapsulated image
to implement the actual EFI boot sequence. While this works fine, it has
some drawbacks that we might prefer to fix:
- executing the EFI stub of the inner image requires that it is signed
  if secure boot is enabled, which is a bit of a hassle, given that
  signing the image must occur during the build;
- decompressing a PE/COFF image and calling LoadImage() on it means that
  it gets copied again, and potentially yet another time if the
  placement does not meet per-arch requirements.

Given that the zboot decompressor and the EFI stub are built from the
same set of objects in the libstub static library, we can make things a
bit simpler, by incorporating everything the stub does into the zboot
decompressor, and only handing off to the decompressed image after
ExitBootServices(). This removes the need for signing the inner image,
and allows us to decompress the image directly into the intended
location in memory.

This involves some refactoring, to remove the dependency on symbols that
are only defined when linking directly to vmlinux, such as string and
memory compare routines, and section boundaries of the core kernel.

While at it, remove some functionality if it's not worth the effort
making it work on both code paths, such as the EFI properties table, and
the randomization of the UEFI runtime regions.

Since image signing no longer needs to occur during the build, let's
also drop the support for invoking sbsign during the build on both the
inner image and the decompressor. (I intend to send that patch as a fix
for v6.1 so we don't add zombie Kconfig symbols to a LTS kernel)

Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Peter Jones <pjones@redhat.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Atish Patra <atishp@atishpatra.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Xi Ruoyao <xry111@xry111.site>
Cc: Lennart Poettering <lennart@poettering.net>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>

Ard Biesheuvel (21):
  arm64: efi: Move dcache cleaning of loaded image out of
    efi_enter_kernel()
  arm64: efi: Avoid dcache_clean_poc() altogether in efi_enter_kernel()
  arm64: efi: Move efi-entry.S into the libstub source directory
  efi: libstub: Remove zboot signing from build options
  efi: libstub: Drop randomization of runtime memory map
  efi: libstub: Drop handling of EFI properties table
  efi: libstub: Deduplicate ftrace command line argument filtering
  efi: libstub: Use local strncmp() implementation unconditionally
  efi: libstub: Clone memcmp() into the stub
  efi: libstub: Enable efi_printk() in zboot decompressor
  efi: loongarch: Drop exports of unused string routines
  efi: libstub: Move screen_info handling to common code
  efi: libstub: Provide local implementations of strrchr() and memchr()
  efi: libstub: Factor out EFI stub entrypoint into separate file
  efi: libstub: Add image code and data size to the zimage metadata
  efi: libstub: Factor out min alignment and preferred kernel load
    address
  efi/riscv: libstub: Split off kernel image relocation for builtin stub
  efi/arm64: libstub: Split off kernel image relocation for builtin stub
  efi/loongarch: Don't jump to kernel entry via the old image
  efi/loongarch: libstub: Split off kernel image relocation for builtin
    stub
  efi: libstub: Merge zboot decompressor with the ordinary stub

 arch/arm/include/asm/efi.h                     |   3 -
 arch/arm/kernel/efi.c                          |  31 +-
 arch/arm64/include/asm/efi.h                   |  15 +-
 arch/arm64/kernel/Makefile                     |   9 +-
 arch/arm64/kernel/efi-entry.S                  |  69 -----
 arch/arm64/kernel/image-vars.h                 |   8 -
 arch/loongarch/include/asm/efi.h               |  14 +-
 arch/loongarch/kernel/efi.c                    |  24 +-
 arch/loongarch/kernel/image-vars.h             |   8 -
 arch/riscv/include/asm/efi.h                   |  13 +-
 arch/riscv/kernel/image-vars.h                 |   6 -
 drivers/firmware/efi/Kconfig                   |  22 --
 drivers/firmware/efi/efi-init.c                |  21 +-
 drivers/firmware/efi/efi.c                     |   5 +
 drivers/firmware/efi/libstub/Makefile          |  30 +-
 drivers/firmware/efi/libstub/Makefile.zboot    |  53 +---
 drivers/firmware/efi/libstub/arm32-stub.c      |  37 ---
 drivers/firmware/efi/libstub/arm64-entry.S     |  69 +++++
 drivers/firmware/efi/libstub/arm64-stub.c      |  49 +---
 drivers/firmware/efi/libstub/arm64.c           |  61 ++++
 drivers/firmware/efi/libstub/efi-stub-entry.c  |  65 +++++
 drivers/firmware/efi/libstub/efi-stub-helper.c | 143 ---------
 drivers/firmware/efi/libstub/efi-stub.c        | 140 +++------
 drivers/firmware/efi/libstub/efistub.h         |  15 +
 drivers/firmware/efi/libstub/file.c            |  18 --
 drivers/firmware/efi/libstub/intrinsics.c      |  18 ++
 drivers/firmware/efi/libstub/loongarch-stub.c  |  89 ++----
 drivers/firmware/efi/libstub/loongarch.c       |  80 +++++
 drivers/firmware/efi/libstub/printk.c          | 154 ++++++++++
 drivers/firmware/efi/libstub/riscv-stub.c      |  96 +-----
 drivers/firmware/efi/libstub/riscv.c           |  98 +++++++
 drivers/firmware/efi/libstub/screen_info.c     |  56 ++++
 drivers/firmware/efi/libstub/string.c          |  95 +++++-
 drivers/firmware/efi/libstub/zboot-header.S    |   2 +-
 drivers/firmware/efi/libstub/zboot.c           | 307 +++++---------------
 include/linux/efi.h                            |   2 +-
 36 files changed, 972 insertions(+), 953 deletions(-)
 delete mode 100644 arch/arm64/kernel/efi-entry.S
 create mode 100644 drivers/firmware/efi/libstub/arm64-entry.S
 create mode 100644 drivers/firmware/efi/libstub/arm64.c
 create mode 100644 drivers/firmware/efi/libstub/efi-stub-entry.c
 create mode 100644 drivers/firmware/efi/libstub/loongarch.c
 create mode 100644 drivers/firmware/efi/libstub/printk.c
 create mode 100644 drivers/firmware/efi/libstub/riscv.c
 create mode 100644 drivers/firmware/efi/libstub/screen_info.c

-- 
2.35.1

