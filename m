Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65825B4532
	for <lists+linux-efi@lfdr.de>; Sat, 10 Sep 2022 10:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiIJINS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 10 Sep 2022 04:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiIJIMx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 10 Sep 2022 04:12:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC2B89820;
        Sat, 10 Sep 2022 01:12:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B37D9B80A1F;
        Sat, 10 Sep 2022 08:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDABC433D7;
        Sat, 10 Sep 2022 08:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662797562;
        bh=lwtkWqnCdC5DTCxRNKDZAmqT7xFGdg5/mD/OyTi+jns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZOdk3K0+fDQSXUkVV1UQVNrKkF1z8VQ6IrRebarYpJKGMhIIDynbV00pEBvpcWFmd
         VJzD7vjT5pcn/L9XYHw4UvjYf8LVH9ZvOr8yt15syG7AGhnXifpWmopBXwUHSdxVss
         /vqExpAel4cYuMHw4XKkKRbaarz8vLoNphuAwFfyfu4WX46MfuBxLc6nRVHq4zF1Ax
         oCNhJf/MQ/4YHX0D1Hio3LI3p/dxJNCfwwuPki071rG+Ip1n5cjRFcOV/IrefGaUju
         LeDc4EUuXjurHcERtalJCfsqfs9XFYbaAHjpGyVf2eVLFZ/uYCR5mH9fNDgZMnxtb/
         npXste2NcsNZQ==
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
Subject: [PATCH v5 8/8] loongarch: efi: enable generic EFI compressed boot
Date:   Sat, 10 Sep 2022 10:11:52 +0200
Message-Id: <20220910081152.2238369-9-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220910081152.2238369-1-ardb@kernel.org>
References: <20220910081152.2238369-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2133; i=ardb@kernel.org; h=from:subject; bh=lwtkWqnCdC5DTCxRNKDZAmqT7xFGdg5/mD/OyTi+jns=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjHEbHfhsOWC6jY9/BchEKckyY8ye89Us81pOZvd6I L0O/jheJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYxxGxwAKCRDDTyI5ktmPJHjpC/ 9PvwfHLVyV0gx543xJ5aj4rBRcRSIT4OzOblDa0pQC7alXcteRi8zXtxqMIClOF/fRR7HSGL9OQboo /Ar/6F8I8a9KV6h9sNHvXjbskBYyKgRCClAd4En7AXgFKHMTNxqgjaC9v0p+08bgbQeydxvBCai3cQ QMxx0WwWc3EphmiSZ0qvEqIvvbvpiSealSogkU/3iQDSimCQnMNbz/KwBVNwhzcWkSdJhSiRy/aYlv J+T7mGNGhmKibk3CIxGnwr18XZVtvcoyt+psuBvIjncvaKOfL4yEXDW1wwqcNdtRkrZodh2NjGGDNm 2hWVmS/y/iAIfvM8SQ+t8jI7GcLYlwfYPDQzWaJGlff6Cudh6KPWr4EfodCkaQkkHJ1cXlN7tzVuOf 4GXm7IVOIjutmPpxx8QoZgVP0X5f9emhSDvpGgdIJdVaU0m6N/1ShIRPNyCIBFiWMVwN262gGluvgP 0yQtENAuDQtau0At5ub3UBxUl2pZm0SUJFlpMEcRUl4zI=
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

Wire up the generic EFI zboot support for LoongArch64

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/loongarch/Kconfig         | 1 +
 arch/loongarch/Makefile        | 4 ++--
 arch/loongarch/boot/.gitignore | 1 +
 arch/loongarch/boot/Makefile   | 6 ++++++
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index fca106a8b8af..f960dbbfb62d 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -55,6 +55,7 @@ config LOONGARCH
 	select BUILDTIME_TABLE_SORT
 	select COMMON_CLK
 	select EFI
+	select EFI_ZBOOT
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 4bc47f47cfd8..357ed2a771bf 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -10,7 +10,7 @@ KBUILD_DEFCONFIG := loongson3_defconfig
 ifndef CONFIG_EFI_STUB
 KBUILD_IMAGE	:= $(boot)/vmlinux.elf
 else
-KBUILD_IMAGE	:= $(boot)/vmlinux.efi
+KBUILD_IMAGE	:= $(boot)/vmlinuz.efi
 endif
 
 #
@@ -93,7 +93,7 @@ vdso_install:
 
 all:	$(notdir $(KBUILD_IMAGE))
 
-vmlinux.elf vmlinux.efi: vmlinux
+vmlinux.elf vmlinux.efi vmlinuz.efi: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(bootvars-y) $(boot)/$@
 
 install:
diff --git a/arch/loongarch/boot/.gitignore b/arch/loongarch/boot/.gitignore
index 49423ee96ef3..e5dc594dc4b6 100644
--- a/arch/loongarch/boot/.gitignore
+++ b/arch/loongarch/boot/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 vmlinux*
+vmlinuz*
diff --git a/arch/loongarch/boot/Makefile b/arch/loongarch/boot/Makefile
index fecf34f50e56..4e1c374c5782 100644
--- a/arch/loongarch/boot/Makefile
+++ b/arch/loongarch/boot/Makefile
@@ -18,3 +18,9 @@ $(obj)/vmlinux.elf: vmlinux FORCE
 targets += vmlinux.efi
 $(obj)/vmlinux.efi: vmlinux FORCE
 	$(call if_changed,objcopy)
+
+EFI_ZBOOT_PAYLOAD      := vmlinux.efi
+EFI_ZBOOT_BFD_TARGET   := elf64-loongarch
+EFI_ZBOOT_MACH_TYPE    := LOONGARCH64
+
+include $(srctree)/drivers/firmware/efi/libstub/Makefile.zboot
-- 
2.35.1

