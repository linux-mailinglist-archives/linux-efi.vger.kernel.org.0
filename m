Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B991C596D47
	for <lists+linux-efi@lfdr.de>; Wed, 17 Aug 2022 13:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbiHQLEY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Aug 2022 07:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239138AbiHQLER (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Aug 2022 07:04:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D6A52E7C
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 04:04:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 678B9B81CC2
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 11:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4959DC433D6;
        Wed, 17 Aug 2022 11:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660734254;
        bh=8IAJ0ZQrulsaPBLmhj3ziWJ6mZQt2SMXAvZ7QS0nG24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V3TRiajrs05cwLyxXwsSzz/NH8snY8Gac2nP3zw0aUg9pR1gigN58M2NEAwIxt5c8
         iuZNCK3BI3aHlvyPrQkPCDfLxX1gZN7nc+Q80YnjwFkSzfbCmxvUsj64pNMgBaPflR
         nV+75bXTEg8Cw/R8CsYjB1+ceePhDWc3hvJoX2v5NmcrLxCoB1e9xJgMmTaUMCSKNJ
         eU/8jj7txUQ/Y/ZXPB+oLeOGc6V8jCAGusv26R3BBbEa/kg/+kLjD7dpD8WXCOM3xb
         oZg0ahDK2KqZyxYEi6AoVmgSh7oI/HBlZnIWBoxQCdH2tQQOXsCCCI91xxmB9zOafE
         c9bkKSHq0BdrQ==
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
Subject: [PATCH v3 6/6] riscv: efi: enable generic EFI compressed boot
Date:   Wed, 17 Aug 2022 13:03:45 +0200
Message-Id: <20220817110345.1771267-7-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220817110345.1771267-1-ardb@kernel.org>
References: <20220817110345.1771267-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1200; i=ardb@kernel.org; h=from:subject; bh=8IAJ0ZQrulsaPBLmhj3ziWJ6mZQt2SMXAvZ7QS0nG24=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi/MsPOCIYdhgRvcW6uwKzfxp5TtSdl6L7YsvEuI23 SfpyFj6JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYvzLDwAKCRDDTyI5ktmPJHmzDA C/8mxrYSs+Ew1Ho63n634wqspGqrCXwePQArdpWTKfBkqRTz7tppFW41dVsF6uEbzC8X5JTrX0K8Yd QgK3/QwyBLX4Mu3qq1iNM9r8J0fnpHjGkV9gncudwdofESj8i0Kq3k58z2SibRf/qBD9wpWMbyCTS/ mtVYm6Z24FSXDUvoP/qa2XlF2Bt2N1CZN7Ga4v6nhgyqL2ZzmeOM3jCJWe0UZvbkS12sC/VOX5RGJ7 TLXuErECXo9LQ17zl1KHFCjVu9pQdUtz6Wem0yURIMIan5/HIw47JzEpo5GJLcvsCETl1/btVt8+Zx CgtUpz+CDSKep1DN0542RGSCYoyAUcSf9TTJnZ7aBZGtmt16XU5kWNzY3hf8a8pedxdPZmYZSPk3kI VGCAm3yQ9e2SHUoszehe/jlMJEGIlkBOLo+lwS4ijEK+jqWGyt30enPGFo2WaV3Fsctdut7Irh+044 +VE+OkLDho4fCFDsK+/aRPfzkEHcvqZDYA97tCLYdWt5Y=
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

Wire up the generic EFI zboot support for RISC-V.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/riscv/Makefile      | 5 +++++
 arch/riscv/boot/Makefile | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 3fa8ef336822..23f1b934c825 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -150,6 +150,11 @@ $(BOOT_TARGETS): vmlinux
 Image.%: Image
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
+ifneq ($(CONFIG_EFI_ZBOOT),)
+zImage.efi: Image
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+endif
+
 install: KBUILD_IMAGE := $(boot)/Image
 zinstall: KBUILD_IMAGE := $(boot)/Image.gz
 install zinstall:
diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
index becd0621071c..82970c4a91b5 100644
--- a/arch/riscv/boot/Makefile
+++ b/arch/riscv/boot/Makefile
@@ -58,3 +58,9 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
 
 $(obj)/loader.bin: $(obj)/loader FORCE
 	$(call if_changed,objcopy)
+
+EFI_ZBOOT_PAYLOAD	:= $(obj)/Image
+EFI_ZBOOT_BFD_TARGET	:= elf$(BITS)-littleriscv
+EFI_ZBOOT_MACH_TYPE	:= RISCV$(BITS)
+
+include $(srctree)/drivers/firmware/efi/libstub/Makefile.zboot
-- 
2.35.1

