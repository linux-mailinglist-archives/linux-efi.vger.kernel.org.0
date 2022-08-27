Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A206F5A360A
	for <lists+linux-efi@lfdr.de>; Sat, 27 Aug 2022 10:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiH0Ijg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Aug 2022 04:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbiH0Ijg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Aug 2022 04:39:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E14ABCCE2
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 01:39:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CAA5614A1
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 08:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B07C433B5;
        Sat, 27 Aug 2022 08:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661589574;
        bh=dXr2U4KNSvu9NXXzFFvAEerp4KLDWPpQp4G37Yrxduw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oPdn8FnqntrJqRqTxyWOjgPp4RAoFxTRZIM7Stmbmy7TG03se4wSgAmAGBhPAS3+Z
         CsDnd0n3xCf4AaPa/eK2H2AAqyMxPZ9gl2GnhrMAKLfnYUKUCNxjuEIjRR59kfuZWe
         324fHa1yJ1Ylroy26I5wL6+5RDreB/6O9U5i/6ScERuUl0vQA9GJG76hlPls0PNIV0
         zjRfAT8vJdcC/CdMOag/E41A/RYri1FFRF4EykceN8hhDO1AiFC1zHMduRL3QkbS4H
         eBshooLB2iaGYcKTutm6Y+BiwE1HgQElH70Ixy8TArJFx+ib+5dnswZKp5pjC976G+
         noW6/AfHxURuQ==
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
Subject: [PATCH v4 7/9] riscv: efi: enable generic EFI compressed boot
Date:   Sat, 27 Aug 2022 10:38:48 +0200
Message-Id: <20220827083850.2702465-8-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220827083850.2702465-1-ardb@kernel.org>
References: <20220827083850.2702465-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=ardb@kernel.org; h=from:subject; bh=dXr2U4KNSvu9NXXzFFvAEerp4KLDWPpQp4G37Yrxduw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjCdgWh5IRWHOtFI19PpFhvvLHNKFanNQWcGMnMThJ 0OvUFrqJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYwnYFgAKCRDDTyI5ktmPJEdnC/ 9OvNdYvgsaAlP8LRNNGrodPGp87HcG7Y9/QumXH2AzAbUAu8yDrA8HEzNQ1iBVMvMpoSkpuORsraBY 4DKD6WGm1ufL+aC5lRPY0Tjge9MS+h+10JH00n8aNo1UXs5JYgP2Tf/QO1Am4Bex3KiREbaBPhGRHd 8R+E6xPqNTS3K2hsfMYIuRXqdeCkffi7hePdlVd+cfgLd62aRzaFvZKdynhxx9bpGOElMzmPaAyFml vUlDtXZHfjcpjFdY8S6FZKELL6UO5iVCqAcxv4PKWRBCWTOTVuQOSwZz7nRwPxmNKCkG+igeAl+TfR hie58Am1VDKS+/dfSX9LyL7e2C7DO0qjv/gqpw65/iolQj4Tx/rPenlNGgACCypc+uIbofiU8DG599 tu67u2rNdMfIdO47IYUS6zurgJ3juf+zyPBU6ns0kz06elAEpnxeoApBGcmWUN36DNZE+rTMvIvXEu NYL6CENaaIiAGaG9H1sfBlAAGyZPKnbUd+Enh+5UWG9/A=
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
 arch/riscv/Makefile      | 2 +-
 arch/riscv/boot/Makefile | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 3fa8ef336822..ee9c24db082c 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -139,7 +139,7 @@ else
 KBUILD_IMAGE := $(boot)/Image.gz
 endif
 endif
-BOOT_TARGETS := Image Image.gz loader loader.bin xipImage
+BOOT_TARGETS := Image Image.gz loader loader.bin xipImage vmlinuz.efi
 
 all:	$(notdir $(KBUILD_IMAGE))
 
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

