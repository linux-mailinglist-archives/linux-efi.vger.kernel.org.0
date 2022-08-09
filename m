Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD69858D52B
	for <lists+linux-efi@lfdr.de>; Tue,  9 Aug 2022 10:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbiHIIKr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Aug 2022 04:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbiHIIKr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 9 Aug 2022 04:10:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50567BF7B
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 01:10:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E18F8612E6
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 08:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588A0C433C1;
        Tue,  9 Aug 2022 08:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660032645;
        bh=811jnPqLnkp6atI8McTN6peGWiDf8Xq+/StSpgTNa58=;
        h=From:To:Cc:Subject:Date:From;
        b=tPDUzTfu+Cwd+9AJd9TgPPdrSaZFf855qIoGPXO5aD7Crz2gQAf4kCIvoyOj226Tb
         /f1Mku4UTyUmazt2c6fJCRSJrOO3THduDA2VTMP0j1u/ymFrrFN/fdgb1Xk+noeZlL
         lxed5jnNtYFfZEykMTX5xwoCIxUhoWWCRnEjYbC1n+Rw/Vvoo28IyQohnVNuJgvKa1
         kUBsLWhGb8p2NQH+Pg16QFxKM9VHWJivVjvg/yBHM5M+x35E4WtbZupjihoRKlAsFH
         jQszVAqYMOVHy6p8BNQQuNYu5CxESiGaOPtKUmvxPWH1DYg9ijYXBEmUX+5aEUocJG
         VcRtduf2Vf5lw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
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
        Lennart Poettering <lennart@poettering.net>
Subject: [PATCH v2 0/6] efi: implement generic compressed boot support
Date:   Tue,  9 Aug 2022 10:09:38 +0200
Message-Id: <20220809080944.1119654-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4138; i=ardb@kernel.org; h=from:subject; bh=811jnPqLnkp6atI8McTN6peGWiDf8Xq+/StSpgTNa58=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi8hY5pLxBBkQN7Pgapqn8GV+srZmd1WQVdtvu4rx6 g/inUdSJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYvIWOQAKCRDDTyI5ktmPJMhHC/ 4/rCJm7EWWFrNv+7iWmV9KagQAodZLOHEmzRypY3QcVUQTC8/UhZ5mp8BNvtsUmPSQ119eWs6lJl5Z IwnCGg+W3r52YAUv+hXg5xJacnAcu6ir6U+5gcCxN6DtYwBHIVWe9KkDM40h2bAA8i3EFNbJV/3d6f CLRh60Ed2/WNK5w1Rr0FHf2S6z6+ravmBMBSFOW818z8db4bTBYYgc24teZO1XxtzymoBlyR2EwTCZ sisQzM2jDH01bo4K+TeZp3zC04fLEfN5lgXRp+0bqh7Nk4BMBf6MtwEtJUVAFaHyrvwDDVlTNT6uA4 +/qm1LeNwIM3Q0PM56G6IeYJ5l2FsJy/IUpIRK9QrHo1EinL0ruQIay7ldxbZA9IvhtfVrM91S+97R bKgKTK9Gowxoq8Kt+Jg0a+oVR8glsw8kBSHPAbJt881SPYXXU2KJZBf96ugFSkUGn7yOOq08s7c+DJ 0fj90ddne5ZHuxfwzSTZ4Z5+4BC9/8tef9SCGp42t1b7Q=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
started, and we prefer to avoid the need to sign both the inner and
outer PE/COFF images. This series adopts the EFI shim approach, i.e., to
override an internal UEFI/PI protocol that is used by the image loader,
to allow the inner image to be booted after decompression. This has been
tested to work with Tianocore based EFI implementations on arm64, but
u-boot will need some interoperability tweaks as well, ideally just a
protocol that exposes a LoadImage/StartImage combo that the decompresor
can use directly to circumvent the signature check. (Note that EFI apps
have full control over the CPU, page tables, etc. so having code that
circumvents authentication checks is not as crazy as it sounds, given
that the app can do anything it pleases already.)

The code is wired up for arm64 and RISC-V. The latter was build tested
only.

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
Cc: Lennart Poettering <lennart@poettering.net>

Ard Biesheuvel (6):
  efi: stub: add some missing boot service prototypes
  efi: stub: split off printk() routines
  efi: stub: move efi_system_table global var into separate object
  efi: stub: implement generic EFI zboot
  arm64: efi: enable generic EFI compressed boot
  riscv: efi: enable generic EFI compressed boot

 arch/arm64/Makefile                            |   5 +
 arch/arm64/boot/Makefile                       |  12 ++
 arch/riscv/Makefile                            |   5 +
 arch/riscv/boot/Makefile                       |  14 ++
 drivers/firmware/efi/Kconfig                   |   9 +
 drivers/firmware/efi/libstub/Makefile          |   7 +-
 drivers/firmware/efi/libstub/Makefile.zboot    |  30 +++
 drivers/firmware/efi/libstub/efi-stub-helper.c | 141 ---------------
 drivers/firmware/efi/libstub/efi-stub.c        |   2 -
 drivers/firmware/efi/libstub/efistub.h         |  12 +-
 drivers/firmware/efi/libstub/printk.c          | 158 ++++++++++++++++
 drivers/firmware/efi/libstub/systable.c        |   8 +
 drivers/firmware/efi/libstub/zboot-header.S    | 144 +++++++++++++++
 drivers/firmware/efi/libstub/zboot.c           | 191 ++++++++++++++++++++
 drivers/firmware/efi/libstub/zboot.lds         |  41 +++++
 include/linux/efi.h                            |   2 +
 16 files changed, 633 insertions(+), 148 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/Makefile.zboot
 create mode 100644 drivers/firmware/efi/libstub/printk.c
 create mode 100644 drivers/firmware/efi/libstub/systable.c
 create mode 100644 drivers/firmware/efi/libstub/zboot-header.S
 create mode 100644 drivers/firmware/efi/libstub/zboot.c
 create mode 100644 drivers/firmware/efi/libstub/zboot.lds

-- 
2.35.1

