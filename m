Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF435A3609
	for <lists+linux-efi@lfdr.de>; Sat, 27 Aug 2022 10:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbiH0Ijd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Aug 2022 04:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiH0Ijc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Aug 2022 04:39:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD3FC00D9
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 01:39:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20C45614A1
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 08:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A68EC433C1;
        Sat, 27 Aug 2022 08:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661589570;
        bh=Eq+AYyhYBLXAd6lHX+27+KiKJAceoIJ7udLauirDVm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qIb31Sk/CrBelE/Z96Kb86gTEJ2YkV+piBE9tmu7ebpchJqFMIz6iH8jEEaVhFhdM
         hiyFKOvg/3cmeQ0nGXB4kbZ82O8Sf6ufJ+cekry6VUGn8SMLHPJuV3f5YXme3chjhX
         6LX23WlbPYkV7ONm7ODimpn2k2eldZitKMVjycHG2wz6PsoNspeh7rq5u+uRlmhYlt
         n3TIMaFesQcQwTX3ZxYcNIDpTQVxpj8kNoUWNg+eyTVeGase4LnsO0eg6p7Pnycvrz
         8aJEeUyIw3m0PGC/WlzEv/GpXUiGp2kZXrWnah2+V3YX+HGhJuYBzZ9wDQaQV7m5C2
         628f8OJFpm5pA==
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
Subject: [PATCH v4 6/9] arm64: efi: enable generic EFI compressed boot
Date:   Sat, 27 Aug 2022 10:38:47 +0200
Message-Id: <20220827083850.2702465-7-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220827083850.2702465-1-ardb@kernel.org>
References: <20220827083850.2702465-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; i=ardb@kernel.org; h=from:subject; bh=Eq+AYyhYBLXAd6lHX+27+KiKJAceoIJ7udLauirDVm4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjCdgUHKzcRzzsKLzEv2X1UzN/Gi7UMpaozCkoJnra gRq70zuJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYwnYFAAKCRDDTyI5ktmPJBpXC/ 4uVi7DFgWEjhdO4ee7TmWJ5MltpNdO1L1gpamn2XkpD7O8blENDdeNThgb4Ro4VBfIhF6NRgtRDnns RwkhK/d31oac37vNCYZcqGns5yFgQOE3K6jLb2cJW1fOtfHkQevrhb0giqd+QLDq9G2wf3pKFaPQoL 1hzYeYLsqJgw+Cn/SoUlIsFnXUe5zDvKjuzyqeZAWBysCzzD8bytVQqLUnxxlENkbQwDG25T98xwcw hfgKbweRi1UzWYPK1YtuURhidM87AKkmk2TUZWUwPppb2Wj3HxlolEDgcdh7p3AxzbRqnuTtEKj5+x 8j2wtNbRQCOQ5NqCAt+L2QeI0abk39ma62ZFV/bkzUJM3WegP0ugmb4Nna5xX1rf9s8k4UP5tnYO7a n49h/ba4nqRT8+InV847+uLGJNsT91A4ZbrNFprZxQNH0DGMK7HEdnIVsehSutKyOTmyluhBntRHCy 6Pivi59HrtQcCncZ8CVqCYwiQqoYfZsr6w1CNY95EVSbw=
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
 arch/arm64/Makefile      | 4 ++--
 arch/arm64/boot/Makefile | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 6d9d4a58b898..92676ccc6363 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -153,10 +153,10 @@ libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 boot		:= arch/arm64/boot
 KBUILD_IMAGE	:= $(boot)/Image.gz
 
-all:	Image.gz
+all:	$(notdir $(KBUILD_IMAGE))
 
 
-Image: vmlinux
+Image vmlinuz.efi: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 Image.%: Image
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

