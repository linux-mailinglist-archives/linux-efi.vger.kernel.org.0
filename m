Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AECD596D42
	for <lists+linux-efi@lfdr.de>; Wed, 17 Aug 2022 13:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbiHQLEV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Aug 2022 07:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239142AbiHQLEO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Aug 2022 07:04:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5579E543F5
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 04:04:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10832B81C94
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 11:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DC4C43140;
        Wed, 17 Aug 2022 11:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660734250;
        bh=9+ofsl/lYT2YsqupXZY+5H4l+P8l1Its507nAq1D/W0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y1Nzl/Al19tElg1vUByyt8bfpJQv6nIPaJGStdP4Hxxt0tgfAqdVHcwlOYPf3J1Du
         ulyoSCK0AQPuMu5hYZV0MDrESTPq+uKBr4XQsOF4piSoRCBmXd1VERiGgKBqh8JSCR
         N2049bijFKyebuZ+TWlA9rGluy19O7U5PmFzom8jLXCmaGFE5tAq2eW57itxKhMQi9
         yTpis8bNBrLgMsiNFRip+GBSb10p5b0JYSM0axB6bXkLYDXxMzu7WDS/h6u/L1+6Et
         fF5idqUB3ljx/Dh/UNF8pMuO6K2ZOu3VX6NxhnC8iVHV4Xp0qYc0r2aV6AwOvagVRl
         dHvWYt/qXxS/g==
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
Subject: [PATCH v3 5/6] arm64: efi: enable generic EFI compressed boot
Date:   Wed, 17 Aug 2022 13:03:44 +0200
Message-Id: <20220817110345.1771267-6-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220817110345.1771267-1-ardb@kernel.org>
References: <20220817110345.1771267-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1400; i=ardb@kernel.org; h=from:subject; bh=9+ofsl/lYT2YsqupXZY+5H4l+P8l1Its507nAq1D/W0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi/MsN8wIhbNTqYfvWhUEyy8iAqP2gZK1cpyI2H82N 1z0EFT2JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYvzLDQAKCRDDTyI5ktmPJOYMC/ 9yundKxAU9HHj6Dcyb1uKD2ErOlyWmh8YlYsXp/eOtIl9LUVWQ9ojFDGvkRItwocdLsvWJVTbm2rmU v+S5jmBOg6U2Gk0JotdEOIa4IIs9+Wd/xgbafbO9AHkLRP/NIFiA0NzcvQ5aZt07SuXVALT/3vO1YA HUELQnBGCykGIKYg80bgW5jo05YnTbREurpfT1PqwdH+vQm8OLwZIEpma01aqfugmSmg7dEPmrlbS4 g/MIB3dSiBAHCWSfia23kwcSaJGenwmuNYazVY8yEsswAlSbr8wQlMqgiB2ApnYF0j6/aKAk+MRU52 tJIV3Fof5vtE1WYV6GysQh1+fev01uhBglGPBOqbquq84Uztaw7sNf0yoViCEkAvEjH+HkI437Ie+B /e5qlsUrg4MDO3wYMl1WHRt1TOuqUCqzM+mnvJu1x4XyKR9ZHleHIF86yywCW5xcQUds/TSl2kmSpK LAk4DTzEREzXXE8dvNzhGJEs10cjFTEWp/pMHXbVj3NOA=
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

Wire up the generic EFI zboot support for arm64.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/Makefile      | 7 ++++++-
 arch/arm64/boot/Makefile | 6 ++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 6d9d4a58b898..6a8b81cfa648 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -153,7 +153,7 @@ libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 boot		:= arch/arm64/boot
 KBUILD_IMAGE	:= $(boot)/Image.gz
 
-all:	Image.gz
+all:	$(notdir $(KBUILD_IMAGE))
 
 
 Image: vmlinux
@@ -162,6 +162,11 @@ Image: vmlinux
 Image.%: Image
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
+ifneq ($(CONFIG_EFI_ZBOOT),)
+zImage.efi: Image
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+endif
+
 install: KBUILD_IMAGE := $(boot)/Image
 install zinstall:
 	$(call cmd,install)
diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index a0e3dedd2883..3e16bb85cdad 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -38,3 +38,9 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
 
 $(obj)/Image.zst: $(obj)/Image FORCE
 	$(call if_changed,zstd)
+
+EFI_ZBOOT_PAYLOAD	:= $(obj)/Image
+EFI_ZBOOT_BFD_TARGET	:= elf64-littleaarch64
+EFI_ZBOOT_MACH_TYPE	:= ARM64
+
+include $(srctree)/drivers/firmware/efi/libstub/Makefile.zboot
-- 
2.35.1

