Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B4F634114
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 17:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiKVQMR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 11:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiKVQLi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 11:11:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EAB74AA5;
        Tue, 22 Nov 2022 08:11:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB0526178F;
        Tue, 22 Nov 2022 16:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F21C433B5;
        Tue, 22 Nov 2022 16:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669133468;
        bh=WhXdkD4dUeFlbCa2uQ7/WXKYDJLeVqOD82K+vPxNRBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XP2d5Vn5IhYOWUComKlIB6Z9cXXN/cA51C1aeGE9gGN8yeNbmQRq1ICdueb71n0lH
         obE7QRwE3PL44uUF9iCUvBppYz/p3rsCzWPsPAOnMa/cjNsCIlQwIsrJKVa7mptG6J
         3K0iR9VKg97H5GHa10EkGRiPp4/jy9qoW+kyovoGqWrewCTfC+PVBlCtoVtrtnNKrF
         hP46x1yNmA4pxsd08Hlxx0jM1nJ+jpcVyJIImgIdBTbOwnDnBYMj+gMEVXZT646uQI
         vNWOzqoeSG2rOb2eLvu9krtCbJPnR8tf105bt+sEt9SiYVAD9DOlL3fOZnZ3JYa/ob
         3Ha6DFMdavgKw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v3 16/17] x86/compressed: only build mem_encrypt.S if AMD_MEM_ENCRYPT=y
Date:   Tue, 22 Nov 2022 17:10:16 +0100
Message-Id: <20221122161017.2426828-17-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221122161017.2426828-1-ardb@kernel.org>
References: <20221122161017.2426828-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513; i=ardb@kernel.org; h=from:subject; bh=WhXdkD4dUeFlbCa2uQ7/WXKYDJLeVqOD82K+vPxNRBU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjfPRmkT6ecGA/cAN7llRJkxgNCUnGuU4XlPtqQLSt MJfoSUKJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY3z0ZgAKCRDDTyI5ktmPJIROC/ 47FixYSC5DsCya9EY2tPWjzFOO3btlyqulJ0T+UDx2P378vfkSo7epzYht6hTrbu0eyKl8sbBbOJod HOzI5it103YIBtch6jbzm+ecyPY/6Liuku1ipJgc7uCOmfoHVUWa4/2CUinI0+lPqV2ZQmOlPXw9eS VeowN57ItdpLsaYa4kph88PLKON7dl7eZlIAi/lATz1moiBiuiHHo+HUQBQw+V6NW0feamxq7zD+cS XLotitFVa3AccaAAzAI1Pw960takGXHX7h+fVe60wZVHwI9LedRUcESNqpnjZKqZpPkvdotIQsyHaW 78iubNh1PsE8xpHF1GlcaCqaMg1iXb652wywgjIySJg8lmIAo5dM8hUUPtTRUHb69VOQJnYDiv/O8Q 7WnF4vfyjCRDhMqSy+ofLnqY2SS+flxH/p/8TTX+afsj8e63dc/WmCfIjPqfU955GIg2Flj1oSPi1S DVK98PcqjDCeIfDfwDzWB3sEh/W64p5dt4vTlomv+Qc3Q=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Avoid building the mem_encrypt.o object if memory encryption support is
not enabled to begin with.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/Makefile      | 2 +-
 arch/x86/boot/compressed/mem_encrypt.S | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index cd1a6295b957ea1d..3dc5db651dd0a197 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -100,7 +100,7 @@ vmlinux-objs-$(CONFIG_RANDOMIZE_BASE) += $(obj)/kaslr.o
 ifdef CONFIG_X86_64
 	vmlinux-objs-y += $(obj)/ident_map_64.o
 	vmlinux-objs-y += $(obj)/idt_64.o $(obj)/idt_handlers_64.o
-	vmlinux-objs-y += $(obj)/mem_encrypt.o
+	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/mem_encrypt.o
 	vmlinux-objs-y += $(obj)/pgtable_64.o
 	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/sev.o
 endif
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index e69674588a31c81f..32f7cc8a862547e4 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -307,7 +307,6 @@ SYM_FUNC_END(startup32_check_sev_cbit)
 
 	.data
 
-#ifdef CONFIG_AMD_MEM_ENCRYPT
 	.balign	8
 SYM_DATA(sme_me_mask,		.quad 0)
 SYM_DATA(sev_status,		.quad 0)
@@ -323,4 +322,3 @@ SYM_DATA_START_LOCAL(boot32_idt_desc)
 	.word	. - boot32_idt - 1
 	.long	0
 SYM_DATA_END(boot32_idt_desc)
-#endif
-- 
2.35.1

