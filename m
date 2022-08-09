Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C42358D531
	for <lists+linux-efi@lfdr.de>; Tue,  9 Aug 2022 10:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239000AbiHIILL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Aug 2022 04:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239093AbiHIILK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 9 Aug 2022 04:11:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42478B7D1
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 01:11:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8D80B811E0
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 08:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C3AC433B5;
        Tue,  9 Aug 2022 08:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660032665;
        bh=0HGizh+6WTk/QYodTT+bl2etkYKDNHiWCQesR+ZiuPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lLpOFbjiH0gJipvClu/2rhmb+Cozywih1hBUgQRfThgwaC/QwITVzx0CFEuiirsGo
         9VQX+hes0nPvtcIimXbewjYIcwnwnaMy2HspJ+n9Hz3IyEyxbuvvLDJdSxUsqeHB68
         Y8pBeT10e0J7G/WCNJIqJLp/jGWP4CwmdVlJ4luQrwJHo917GEaQHW58fd5t32rykY
         jSmsJu5jBLQaA7Dv3WzufKVSv3zoFkTTUCJKB7c26or2ssDUxuIX/X5xarZM9zpxcU
         J7S10Pc1+oHGwpAN33k1HgZ1o3w9qFYkqf3W2TR+9L7sFkOQQ464hG/jtaWtgVZ1P1
         IkyWPyEyYuxWQ==
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
Subject: [PATCH v2 6/6] riscv: efi: enable generic EFI compressed boot
Date:   Tue,  9 Aug 2022 10:09:44 +0200
Message-Id: <20220809080944.1119654-7-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220809080944.1119654-1-ardb@kernel.org>
References: <20220809080944.1119654-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1555; i=ardb@kernel.org; h=from:subject; bh=0HGizh+6WTk/QYodTT+bl2etkYKDNHiWCQesR+ZiuPE=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi8hZG4yeSVhX+lZWCL9jaXmjxJ3Ka4jm4YSufGjCa 8fIZOjKJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYvIWRgAKCRDDTyI5ktmPJBe4C/ 4yQVL6p6LlS2HXP2Z1a4lfvRvcFQBwxyE97zrs19a/Wl0KqF/GXGsyMhF8ZgcTyYVACg+0rBCS505K sTHj9S//QR+gg+d15ja5jG+TfFdndfITZ8uZZHTyUAphFLdStiYAsXRK58NXlXXGlUMGc892YnE/G3 /s2Ae6Aq/S+eztEXFMM6g/isy36Z/KWjC8BToyeMc8NqjuK9i8mochX7s4cybNBqlDrEITB+npxL7x Dn1Je5DnzqYJleIiaiYcrdJbWNIN/hfPIVDOTv8o6S8FQfTWfY+xEck9wIwBcTiJodRpaM+uRfl0tE iy7JJtqKjG+yjnbeLrl3cTyj/ANTXIYNkXN9fbzWyQfjx6X2oCiEzYO12BPbTpeSOQMnfUgmtzYBRs xB7khZ5B7kwyvbhCAGRcewXjhq9DjIUkJW/qR1nLlxfJo9Ji1W+kXMOX2uuI25Dgm9Y3QhmErX2Bz+ NcsHghpnJusPfAvjzeIGwp2GhF5pwSVE60EyvU9Gp32I0=
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

Wire up the generic EFI zboot support for RISC-V.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/riscv/Makefile      |  5 +++++
 arch/riscv/boot/Makefile | 14 ++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 81029d40a672..c30ea65ec877 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -142,6 +142,11 @@ $(BOOT_TARGETS): vmlinux
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
index becd0621071c..60cd319685ea 100644
--- a/arch/riscv/boot/Makefile
+++ b/arch/riscv/boot/Makefile
@@ -58,3 +58,17 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
 
 $(obj)/loader.bin: $(obj)/loader FORCE
 	$(call if_changed,objcopy)
+
+ZBOOT_PAYLOAD		:= $(obj)/Image
+ZBOOT_BFD_TARGET	:= elf$(BITS)-littleriscv
+ZBOOT_LD_FLAGS		:= --defsym=__efistub_strnlen=strnlen \
+			   --defsym=__efistub_memmove=memmove \
+			   --defsym=__efistub_memcpy=memcpy \
+			   --defsym=__efistub_memset=memset
+
+ZBOOT_EXTRA_OBJS	:= memcpy.o memset.o memmove.o
+ZBOOT_EXTRA_DEPS	:= $(objtree)/lib/string.o \
+			   $(objtree)/lib/ctype.o \
+			   $(addprefix $(objtree)/arch/riscv/lib/,$(ZBOOT_EXTRA_OBJS))
+
+include $(srctree)/drivers/firmware/efi/libstub/Makefile.zboot
-- 
2.35.1

