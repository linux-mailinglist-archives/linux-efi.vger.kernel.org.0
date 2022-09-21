Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EC35C007D
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 16:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiIUO4I (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 10:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiIUOzo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 10:55:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A56E3DF3E;
        Wed, 21 Sep 2022 07:55:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEA28630B7;
        Wed, 21 Sep 2022 14:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B6DC433C1;
        Wed, 21 Sep 2022 14:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663772105;
        bh=GRNNjfUheFArH6xmtKiNIrGEgX9ISMmOlJTsXW58G4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QpQax4iCtvqh4Pjn9EIgCg6fV8z7Huc8qi3177mlVPjdX/5j102xc8lnXi1FuZJ7n
         7QiDK90wxJ5NvsRlmpBOtCYLcF0MJntbkfLTsBz47dR+PYt2grC/O9CPS8ofiDxDg5
         x4ZRgXj8sesitU17ieNGiS/RoMg29lOzVpVyTEUG0o3GuuhdK34QNbSzmc6cVGh9N6
         +O4uu1NMNi9VxULOKqmn9LryoIUGk7JvjjVdkpSBEwyhiqQnRTg2rVBjzeJDbE0AHZ
         FwO15MHP5ulW17hog/83B6EV6DxgT4+pZAqxcPNzIWid7BV1ZBxpl/JczN+r3BNc/e
         GiwqG2Vp5keJw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 16/16] x86/compressed: only build mem_encrypt.S if AMD_MEM_ENCRYPT=y
Date:   Wed, 21 Sep 2022 16:54:22 +0200
Message-Id: <20220921145422.437618-17-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220921145422.437618-1-ardb@kernel.org>
References: <20220921145422.437618-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1495; i=ardb@kernel.org; h=from:subject; bh=GRNNjfUheFArH6xmtKiNIrGEgX9ISMmOlJTsXW58G4w=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKyWdPEfMguby108NnEU4ECQAoQlEPvzEoskygBGm DmjkjkGJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyslnQAKCRDDTyI5ktmPJHaCDA CBzRJ/f+ONa/8lKnHtS45mqVY0PNhPpMcNSIF0rWi9pYZ7/owkxS6suGK6sB1Eoh6ADuyp7zG58INx 1k8WV6Sqw7aXPtCwZS2ORxNr6tUMHuV2nbT8NHDaZ+8XIm/nydZDX2upasFV5cecjiVe2atUNRJyPR b04oXqIelv8CLa6HrWFgch9TUR4vzD8i/G7lZ9ukgnTp6kJECePzPtltF4fGG6QvvEECo69gTWSRYw bJ7A8ITo8jWzr8cmkFzvxo4/Dxqi3QJ26Sx/0Er9ufnelgEmzFEZMidBMloB4lv2QT927M3RiDsRJA +pZ59SWDLuAFXSfksxO3Hkp5oVrlIHHjdfiv/qOJqnc1IBBi8CJcuS25sc+EZUlYoGTzrI66JlZtNB aj4+y0rV/dVNow5ES+J37PFYbuaEUeCeHboe58aTzolli32VmgS+Hr7IKVmhYiZF2TID3aY7m9FhPB pU1IKq0LjYG9Y6ObussierX2LdMbDMYULxPYzldFJbogI=
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
index d6dbb46696a2..9aad9ddcf3b4 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -99,7 +99,7 @@ vmlinux-objs-$(CONFIG_RANDOMIZE_BASE) += $(obj)/kaslr.o
 ifdef CONFIG_X86_64
 	vmlinux-objs-y += $(obj)/ident_map_64.o
 	vmlinux-objs-y += $(obj)/idt_64.o $(obj)/idt_handlers_64.o
-	vmlinux-objs-y += $(obj)/mem_encrypt.o
+	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/mem_encrypt.o
 	vmlinux-objs-y += $(obj)/pgtable_64.o
 	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/sev.o
 endif
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index e69674588a31..32f7cc8a8625 100644
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

