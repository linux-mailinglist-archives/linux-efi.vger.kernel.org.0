Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C876B5B452F
	for <lists+linux-efi@lfdr.de>; Sat, 10 Sep 2022 10:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiIJING (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 10 Sep 2022 04:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiIJIMq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 10 Sep 2022 04:12:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED75C87698;
        Sat, 10 Sep 2022 01:12:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F16346115A;
        Sat, 10 Sep 2022 08:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5963C433C1;
        Sat, 10 Sep 2022 08:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662797558;
        bh=0ouOP9xoTyJITAHyjmd8EH9dpexRXhxT+Iu2CyWbYy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uTjLsKgqX4XgLP7eSw0YZ90daypxBIDpGt7QPTKfv2sOxzcERUydbu0rue603CG3t
         hJA0stKux6PRL2dD+TkB4RXwcQ90jqBaE6eY8vHMvWlGOGtOVSJEUOG4jm09hS6LmX
         nZ06ulaXoiRviEzl2LmBOpjjkZFXnGqG0EUJNus5yZti6EeOrTbxH+OisdmYQjosei
         PvH1Neq2XeyF5XvNt2bpmcjKH62K1M7Ees8VrfUffxQj9gQyGARqvrKOHlOWN5Ssel
         cc0zoWQFtaHWrwT0xnMQGWPhqQQ5rwNd/vuNcnfJIxwHyzsa2HSvMXjUzyMHyKtAs7
         0O4v8QKO+4hrA==
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
Subject: [PATCH v5 7/8] riscv: efi: enable generic EFI compressed boot
Date:   Sat, 10 Sep 2022 10:11:51 +0200
Message-Id: <20220910081152.2238369-8-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220910081152.2238369-1-ardb@kernel.org>
References: <20220910081152.2238369-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1646; i=ardb@kernel.org; h=from:subject; bh=0ouOP9xoTyJITAHyjmd8EH9dpexRXhxT+Iu2CyWbYy0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjHEbGB0Nn9/B7FM1mxtDBajVOlkYZ+FfmjrQThfjS iiauInaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYxxGxgAKCRDDTyI5ktmPJKdoC/ wMslwiCbB31366kUv9bXKX1pHHEq8Hs8mYWyHuPRLsV1z35J+nLhUciUF2gQsF7gXh7Kwugree/Gbz Xkwj8HZFplsRLN0BvvrU/WRZQFMmFAQJMh1BavDk2PlVCxIYXM1YGBATfuPG5sYGlmAV1FkxuxkAl+ by/j6GcydAkvWwSIj5onum8WGptJRp5iKHSlbMk8mX/bN+tpa45zue0H8FVnlo5F64erQaTB7904ho //Hd4XpUlPWvcSx2q4n7wywXBvUAPrIcvRy/WxXNXXxMs9yXOkzT9tMBWQCoZDjDG+QEH4IcAwc9cP jH2s6E2/tLOvQGK40nLjZ7s/KkDVKy2S+OfpnriiL7o0QgTZSUHg+b8b4F6oet62kSBK5GuPQSb0/5 lRa8dnwNHoWc6CIzKm2+HEsAukTWUQPTPTz889UgsF4qYssn7zm0yQM0u91dC9PrYBImV/J1GTkuO+ 4e0eXWSVYB/rZn3d9pC67BXkz50pgALmkYA7He4l6NhSA=
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
 arch/riscv/Makefile        | 6 +++++-
 arch/riscv/boot/.gitignore | 1 +
 arch/riscv/boot/Makefile   | 6 ++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 3fa8ef336822..d63295e21373 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -136,10 +136,14 @@ ifneq ($(CONFIG_XIP_KERNEL),y)
 ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_CANAAN),yy)
 KBUILD_IMAGE := $(boot)/loader.bin
 else
+ifeq ($(CONFIG_EFI_ZBOOT),)
 KBUILD_IMAGE := $(boot)/Image.gz
+else
+KBUILD_IMAGE := $(boot)/vmlinuz.efi
+endif
 endif
 endif
-BOOT_TARGETS := Image Image.gz loader loader.bin xipImage
+BOOT_TARGETS := Image Image.gz loader loader.bin xipImage vmlinuz.efi
 
 all:	$(notdir $(KBUILD_IMAGE))
 
diff --git a/arch/riscv/boot/.gitignore b/arch/riscv/boot/.gitignore
index 0cea9f7fa9d5..e1bc507e8cb2 100644
--- a/arch/riscv/boot/.gitignore
+++ b/arch/riscv/boot/.gitignore
@@ -4,4 +4,5 @@ Image.*
 loader
 loader.lds
 loader.bin
+vmlinuz*
 xipImage
diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
index becd0621071c..d1a49adcb1d7 100644
--- a/arch/riscv/boot/Makefile
+++ b/arch/riscv/boot/Makefile
@@ -58,3 +58,9 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
 
 $(obj)/loader.bin: $(obj)/loader FORCE
 	$(call if_changed,objcopy)
+
+EFI_ZBOOT_PAYLOAD	:= Image
+EFI_ZBOOT_BFD_TARGET	:= elf$(BITS)-littleriscv
+EFI_ZBOOT_MACH_TYPE	:= RISCV$(BITS)
+
+include $(srctree)/drivers/firmware/efi/libstub/Makefile.zboot
-- 
2.35.1

