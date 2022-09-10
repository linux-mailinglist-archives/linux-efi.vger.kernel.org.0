Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5475B452C
	for <lists+linux-efi@lfdr.de>; Sat, 10 Sep 2022 10:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiIJIMy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 10 Sep 2022 04:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiIJIMj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 10 Sep 2022 04:12:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3E4868AC;
        Sat, 10 Sep 2022 01:12:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D592C60C01;
        Sat, 10 Sep 2022 08:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C67DC4347C;
        Sat, 10 Sep 2022 08:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662797554;
        bh=GuY8276n/eRax8D4bN0N+JvUa77cwpfHICfgt9doQ1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=stQqAy1gyraU9bRDfAFnVamiw1VRMdBu7IPx1EvA2EDnWH61QnCkVGJ8NLhEA89G+
         F9Rr5CJygeXjkOpesQ2vptfRolRDOcuFAPe6fqVqH1DDio0rpXZE9zkE4PMBGNp5gJ
         2SL2ghVUEA2OH8MMOzkjPxmjcQ64xmioza/6Ft9SkKAR01bPfykYvNDup6L439jDMA
         lX1DDRYsRCd7Ow58H9qqf/559otFyk9xjh/v/kHbdprLgAE8vUJSbpfMDLHuc+vprv
         bnhWGdzgE/muly+j9rIhvLcSM9MnYnSGW2wGWIrBgfzhKz4Zu7KhHlpgTrkC5BQ0sw
         9Wf7zXkf5KQ1g==
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
Subject: [PATCH v5 6/8] arm64: efi: enable generic EFI compressed boot
Date:   Sat, 10 Sep 2022 10:11:50 +0200
Message-Id: <20220910081152.2238369-7-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220910081152.2238369-1-ardb@kernel.org>
References: <20220910081152.2238369-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642; i=ardb@kernel.org; h=from:subject; bh=GuY8276n/eRax8D4bN0N+JvUa77cwpfHICfgt9doQ1c=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjHEbF8hJQ56ln/A/CC0taX3RBGiOeGIn/epSviNNT QJsSLjyJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYxxGxQAKCRDDTyI5ktmPJL8EDA CTUabsOcQV2xcWs4ccVK9JFyN0ArpMIc1LF7Ms9VYhLgxfPjQeZKNqdd2P7EU/Bvap6NsAwP85miC+ T5oXg9W6gGNd5hZ4bun9/72wXu1F1x+icitwh0nyFzeUcCUsaWpESFV9JWjgCKbewl3XIcmgDMqrlU O9GDST5OloaKjDFI2dhu1QeJYlqfclvyms/+AE9DOMvVWVEstMaTLvht0ols+p/82V0pdWxOB+oC7b zRfp+EZanT+oqL7CCIzqWQVPf3KIJaVhKTTd8PXduutM9t4C7+0o1W8RqLUrFHCVcLTJqGSP341sng 0Vd016ChIJqsNQxZUOBEPWODEyXmghiLCKNq3LHRXKoAy4tRg757PBPUzTtGtJ0B9wnnVDC1S2/pq8 Yqgqdul0Ge0ZCJgaRU9Su4iHwbbZObmaCGFh/t/BEhG9CKaK/s0J+cJNh3KBoD5MeLyovsbbh+KjKz lem/Xo2Av03S1nfBB+YA+AU2Gu/FIIrDR3AqsI2EdnH7k=
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
 arch/arm64/Makefile        | 9 +++++++--
 arch/arm64/boot/.gitignore | 1 +
 arch/arm64/boot/Makefile   | 6 ++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 6d9d4a58b898..a82bb3599094 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -151,12 +151,17 @@ libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
 # Default target when executing plain make
 boot		:= arch/arm64/boot
+
+ifeq ($(CONFIG_EFI_ZBOOT),)
 KBUILD_IMAGE	:= $(boot)/Image.gz
+else
+KBUILD_IMAGE	:= $(boot)/vmlinuz.efi
+endif
 
-all:	Image.gz
+all:	$(notdir $(KBUILD_IMAGE))
 
 
-Image: vmlinux
+Image vmlinuz.efi: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 Image.%: Image
diff --git a/arch/arm64/boot/.gitignore b/arch/arm64/boot/.gitignore
index 9a7a9009d43a..af5dc61f8b43 100644
--- a/arch/arm64/boot/.gitignore
+++ b/arch/arm64/boot/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 Image
 Image.gz
+vmlinuz*
diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index a0e3dedd2883..c65aee088410 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -38,3 +38,9 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
 
 $(obj)/Image.zst: $(obj)/Image FORCE
 	$(call if_changed,zstd)
+
+EFI_ZBOOT_PAYLOAD	:= Image
+EFI_ZBOOT_BFD_TARGET	:= elf64-littleaarch64
+EFI_ZBOOT_MACH_TYPE	:= ARM64
+
+include $(srctree)/drivers/firmware/efi/libstub/Makefile.zboot
-- 
2.35.1

