Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C70D60148D
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 19:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiJQRRr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 13:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiJQRRp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 13:17:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC95E6E2D5
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 10:17:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADFA2B816B3
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 17:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3EDC433D7;
        Mon, 17 Oct 2022 17:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027061;
        bh=PlaDEvd8zykQGREaV0Mk+KGaPrUMeGQvwWVTc9qNF7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VkjdAHCiT7lR5paGmA7iP6dIhMa3QSVpBN+E3CijAZGL/0FL6/a9zb16PlibNN+lS
         fj1+FT2GWzs3uZ2sTX9Zthv2mwLc/xtgMLpglEWa/lZ4Ou7R4shbjF3b8kLeMD9FhU
         6oSsw5LzDNB44jqdLn2+f+Lxs4ffggP30lE/BdeWcMAvQ+J10ATXa/A6eWMfkNjxhu
         8xS4ScJnkQuoEVCBzrbKTEOJkcs2NQd7cZEoVs9tYUwbQCUxPQld9hkCu0Tqx687my
         OLl1Gm5WKmHZWyqO9iM8dEH7me5/xIfk0bJRja9SzQjCp9H1ZuliqyP/cyMPpSGM9U
         V0bNMnXYZtWIw==
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
Subject: [PATCH 07/21] efi: libstub: Deduplicate ftrace command line argument filtering
Date:   Mon, 17 Oct 2022 19:16:46 +0200
Message-Id: <20221017171700.3736890-8-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017171700.3736890-1-ardb@kernel.org>
References: <20221017171700.3736890-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1781; i=ardb@kernel.org; h=from:subject; bh=PlaDEvd8zykQGREaV0Mk+KGaPrUMeGQvwWVTc9qNF7U=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTY30W1MsnH29G4lZplKLFVUo15rqKPbIwLlwuyMx oPW88D6JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY02N9AAKCRDDTyI5ktmPJKINC/ 9hy5p1+l26jFrIeSQscsQPYrJVifbkrWPmZDijuhJQF5OmCimT7N4eQLWX3viAaHiqYCezz+uSpCby TNseOAlSroUaY2ix/Ia7cQm14qJE5RcTtoPU0S9GzNCDr38EZF/ym2ub6x88CDdEFkJwEtK2d+rvVM MVZj2szubhY9L0gN2ovsx6Xp4pV1BhQ2qkAxE27Sqd9GG/CegE66I01UWhrAWELT94RfJ3WyGcA7O6 e0kxPMsZEA4mE2FWvrVrxIQhpkK1CJXKoWlM1v3FcV/bSGBa9IipdNnUXarMH9VV9hVymQ4pkE3tCg yjtoOMBzSHv0GBstkLxUDlEtWDJFXxH39DmlUbIIVxF/vbIDmIbOrEx2oTmKtgHMZsAkcREKt8XZYx iZrOg6f2qMjlPIfKGNVTDrjDqL6aFNNb191HtmjSI4b6IHSW5cQFamZJAL5i5v6qD0oSRos/NFD1Zd y+GszaPLnqrlxEyWw40DcELOaDm08M2OIRVVXHfCROiAQ=
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

No need for the same pattern to be used four times for each architecture
individually if we can just apply it once later.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index efc8cefab889..5246d69d9abf 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -18,20 +18,17 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
-cflags-$(CONFIG_ARM64)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
-				   -fpie $(DISABLE_STACKLEAK_PLUGIN) \
+cflags-$(CONFIG_ARM64)		:= -fpie $(DISABLE_STACKLEAK_PLUGIN) \
 				   $(call cc-option,-mbranch-protection=none)
-cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
-				   -fno-builtin -fpic \
+cflags-$(CONFIG_ARM)		:= -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
-cflags-$(CONFIG_RISCV)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
-				   -fpic
-cflags-$(CONFIG_LOONGARCH)	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
-				   -fpie
+cflags-$(CONFIG_RISCV)		:= -fpic
+cflags-$(CONFIG_LOONGARCH)	:= -fpie
 
 cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= -I$(srctree)/scripts/dtc/libfdt
 
-KBUILD_CFLAGS			:= $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
+KBUILD_CFLAGS			:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
+				   $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
 				   -include $(srctree)/include/linux/hidden.h \
 				   -D__NO_FORTIFY \
 				   -ffreestanding \
-- 
2.35.1

