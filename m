Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CA15A360D
	for <lists+linux-efi@lfdr.de>; Sat, 27 Aug 2022 10:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiH0Ijq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Aug 2022 04:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiH0Ijp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Aug 2022 04:39:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDED4C00DE
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 01:39:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E893B80E6F
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 08:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A06C433C1;
        Sat, 27 Aug 2022 08:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661589581;
        bh=sH6dY5v0mM/ic1eNT4y8rVIIH57brMb+dlbN5USUsGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ilB/TiCHlYrccfH4ftOVIZyiQ1R4GuB6Zzj6V62nI1cFvZJjbZ2BrxizvtUuJSWv2
         qv69idXKo0XHBOi90VDTVQ+4eVUmnz+ku+am34CD92RaR/FAf3+ezOpaKSTehKLxv7
         bD/5rmLfjmr3xb1mN1/jYzvsTWb15YC1TKMHDU7ha6IziH5rx1e72bFOySV481c9fs
         2sTMhbSYsMLduGZAsl2/Hr1oSlMRENTyPnURmh0tWi2hH235YiMgtdtwjgVwDIeS0o
         pdmgn3KisTuZHfCO2YWE3okS5y6Ui+bst1oUJBEMVihKMSM3umYa+8Phveb53ikDo3
         q131HO9kP+VKQ==
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
Subject: [PATCH v4 9/9] loongarch: efi: enable generic EFI compressed boot
Date:   Sat, 27 Aug 2022 10:38:50 +0200
Message-Id: <20220827083850.2702465-10-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220827083850.2702465-1-ardb@kernel.org>
References: <20220827083850.2702465-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174; i=ardb@kernel.org; h=from:subject; bh=sH6dY5v0mM/ic1eNT4y8rVIIH57brMb+dlbN5USUsGw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjCdgZe58oCT+uliiLX0A73mYuVZIQDkhOOxyhxeYb GFHXPeyJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYwnYGQAKCRDDTyI5ktmPJGSiC/ 4ndYoo9PleCRNDXglXythl1gKZCj5w9cQPak/RFMXLJvfXzmSkSqVqDWGTb7RMtpYDp5+2yD6kenF8 /GM7ua2KKAQK+V3kLO05uiCLzQk4sh8JNSg2VbRtwCBh3HFujB5/V9PiHgC2JFeX/p2qs1YzXVQCHH 43v9SfXfeDFTbyD0XUuDXmNzen2umTBZYT1TbxWg6R23U91qU5V2R9YhPTUwkSWxlJcDSzKS6QFw1J wgI+0uEC51slTzJ1h7uUWhthwei7+n+n+jfI6Kg+tCFlQQ8NiuWv8y4bbsiv3dnnP0glE71pxdlPqd bb8R0hO8RJwCruCl+IPOJA0JUunDBtR9FBMFyb58VNIKcChL/LAAcC1Nr0plhfwPoG9gXAW6eUxbZR ebL5ivdXrV39fHRZxY68CNQvFdWq7a4XnRtxeWAPu9VYkqHMjao1CafQbgxWJOVq/8LphAdv1r/xfx oaiGoDJUzVDzIjTq3cy6DJH/mfWcjt9cwHebdga0w/4v0=
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
 arch/loongarch/Makefile      | 2 +-
 arch/loongarch/boot/Makefile | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 4bc47f47cfd8..7051a95f7f31 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -93,7 +93,7 @@ vdso_install:
 
 all:	$(notdir $(KBUILD_IMAGE))
 
-vmlinux.elf vmlinux.efi: vmlinux
+vmlinux.elf vmlinux.efi vmlinuz.efi: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(bootvars-y) $(boot)/$@
 
 install:
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

