Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1CC596D46
	for <lists+linux-efi@lfdr.de>; Wed, 17 Aug 2022 13:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbiHQLEG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Aug 2022 07:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbiHQLD7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Aug 2022 07:03:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCBE50073
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 04:03:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70BD2614AB
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 11:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B13C433C1;
        Wed, 17 Aug 2022 11:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660734234;
        bh=vxk1LY//tCgSW926i0slQiwtTUg7I+PuhcgmvlcYSv4=;
        h=From:To:Cc:Subject:Date:From;
        b=CDTTEXfUSkYgI8mtGjpdLw81bmllp+PjvZhjhfxJkQLucwYTc6PTATvFWLOoZaUSn
         ly/eUGq+j6+f+1H8oFXbnxZIGKx9F5ebIICAgkYj7wko9NGCQWldMQT+8QToUU06fE
         hdbV3oMgWJTlQJi0/2Ky58Bk5rV29I+IlqB9oV3mQrR+0HqSg2vj8FcwLpRX2mLU1E
         wXCfrKWKeN7sYKJ9wncsrjnIeX34AtsivXodrV0acYaYUdngtjGcrAO0SfkYjsvygm
         BXf4ymaCA3v0jL97l9PDxoRAb5rmZIz1tzF9gOYhLjM9A5iXg5E1nJFe1OPZj+NPv1
         JP7vMcxSC+/IA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v3 0/6] efi: implement generic compressed boot support
Date:   Wed, 17 Aug 2022 13:03:39 +0200
Message-Id: <20220817110345.1771267-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5104; i=ardb@kernel.org; h=from:subject; bh=vxk1LY//tCgSW926i0slQiwtTUg7I+PuhcgmvlcYSv4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi/MsCJjOn5St/w2MUJDO7L2MngA7RW+1RJjU3C/31 VHV61F2JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYvzLAgAKCRDDTyI5ktmPJMvwC/ 41YMYh+Igi46OfRTGTonuhlC28rRAZblcAH92QDHa6AtcJc/aQC1KKIma9qgDjypeUKU/hMzU+EizT 9KfcGIuIEJ0+9jRlbw1h8UQyuIooN5R44xf5p9EEmKfSurTzrMLOa7nnh/+/4aBbubdCr2HI5lJh4/ pvGRG61PekPjLm7jpRQwPRfL26FLNVRYODig0jfFg/z0/eAzsq1y7dmmQ5EqdI9THba+Da+yPcDcFS 2NrldEIJgge77tZBxnZJmPHlvhxqCYKFeRGhoYSh/3r6S2TM3wN9DVue0OATZAOt+Yfaoiaaoyq7c7 TiRnrQqw5Tk40Cz6haN1/2Op3jPFLv85mJycdQLE3JEjtywJKl0CGwvDUWtvrgvVfadkTLWmXkQvvU pQKC+hF75wEcNSm2A7P30/s32jM+HVhJBlgYKRaeUkLEfr0Z86yAOg7oOVzDoWKalsf6D9Uou6F19J MsKLHWI9aZnqE5VpSpbc/huwhrEW7fvdHL0O1SfY2GWJE=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

The code is wired up for arm64 and RISC-V. The latter was build tested
only. I also tested the code with the upcoming LoongArch EFI stub
support, which built correctly (using binutils 2.39) but needs some
additional work before it will run as expected.

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
Cc: Lennart Poettering <lennart@poettering.net>
Cc: Jeremy Linton <jeremy.linton@arm.com>

Ard Biesheuvel (6):
  efi/libstub: use EFI provided memcpy/memset routines
  efi/libstub: add some missing boot service prototypes
  efi/libstub: move efi_system_table global var into separate object
  efi/libstub: implement generic EFI zboot
  arm64: efi: enable generic EFI compressed boot
  riscv: efi: enable generic EFI compressed boot

 arch/arm64/Makefile                         |   7 +-
 arch/arm64/boot/Makefile                    |   6 +
 arch/arm64/kernel/image-vars.h              |  13 --
 arch/riscv/Makefile                         |   5 +
 arch/riscv/boot/Makefile                    |   6 +
 arch/riscv/kernel/image-vars.h              |   9 --
 drivers/firmware/efi/Kconfig                |  31 ++++-
 drivers/firmware/efi/libstub/Makefile       |  11 +-
 drivers/firmware/efi/libstub/Makefile.zboot |  69 ++++++++++
 drivers/firmware/efi/libstub/efi-stub.c     |   2 -
 drivers/firmware/efi/libstub/efistub.h      |  12 +-
 drivers/firmware/efi/libstub/intrinsics.c   |  30 +++++
 drivers/firmware/efi/libstub/systable.c     |   8 ++
 drivers/firmware/efi/libstub/zboot-header.S | 139 ++++++++++++++++++++
 drivers/firmware/efi/libstub/zboot.c        | 101 ++++++++++++++
 drivers/firmware/efi/libstub/zboot.lds      |  39 ++++++
 16 files changed, 453 insertions(+), 35 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/Makefile.zboot
 create mode 100644 drivers/firmware/efi/libstub/intrinsics.c
 create mode 100644 drivers/firmware/efi/libstub/systable.c
 create mode 100644 drivers/firmware/efi/libstub/zboot-header.S
 create mode 100644 drivers/firmware/efi/libstub/zboot.c
 create mode 100644 drivers/firmware/efi/libstub/zboot.lds

-- 
2.35.1

