Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2E4593021
	for <lists+linux-efi@lfdr.de>; Mon, 15 Aug 2022 15:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiHONmt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Aug 2022 09:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbiHONmo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Aug 2022 09:42:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CE2222A0;
        Mon, 15 Aug 2022 06:42:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B125D60EEA;
        Mon, 15 Aug 2022 13:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663B4C433C1;
        Mon, 15 Aug 2022 13:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660570963;
        bh=mHYMYrIKhs9U0wXjWKzNqvRMitC+0l4qNZV7fWk7X8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VKcNmBvorVi7XDkCZ6ypaWxnVix/M79KptntCH+5gHdVcRJHl9eNcK5XyPKsTo8p7
         vSuVXxbzpFc9GENxrwzyc5v6PsnZ+ZUYXbc705cO3Vh7P8nQnZOw6t7F9X1xg+xx5V
         T5exjegKAtMw+HgybEDJFW5McFrTzZqUK+uObNV5D6Hc07jsOR5UrQiBHK88RpqnKA
         4skailrizrDkOlFJbL8u4/YcwjB6PWa3GBbGdA8Et8E0aAY47pKgdzB8e3XCRL+46Y
         PUqoGKmSgzYwFjj2hV9JNynsC4VUMiBG/NbrOmXXi688TU24K86Nq8YNx4s2nyGW7M
         slxbQKJveGcFw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH 6/6] x86/compressed: only build mem_encrypt.S if AMD_MEM_ENCRYPT=y
Date:   Mon, 15 Aug 2022 15:42:23 +0200
Message-Id: <20220815134223.740112-7-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815134223.740112-1-ardb@kernel.org>
References: <20220815134223.740112-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1567; i=ardb@kernel.org; h=from:subject; bh=mHYMYrIKhs9U0wXjWKzNqvRMitC+0l4qNZV7fWk7X8M=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi+k09OC8dA12snNY5CsnCDOCSoEbARxyPgRitEQ9A EENMbKqJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYvpNPQAKCRDDTyI5ktmPJPuRDA CFy5SUFN+rIB8khTuctSqQ+qiQ+BInWcd3OnU22o9KjiUukfDLxa7ZWG6yfDm6RlOVBPDJsoJAnOFx ChINmEdO2oWXogc0rRpdCdOP5LZpra2kew6rEPsqL2Tnr4EyHVorr1lvY0iOO1FtqSWAn7P0UZqgxb VUSCb1qkYPTvIBbOUL6yqcvpbv/Y3pdw3R2RvVrjdPND6elEWikpvSnLK2WH3RkiRVnBdWldBNdBUw nKv2yvNzMaO1lwv3VmoLfekzCQpeIBfYNNH5OwxC72fFcolAJQo7NXVComHa7C+YLmg90mdwtCn5rz b3g4Tv9Wad5USLH/YN2mo1c5hQRUFxq70181GVpg78xwn8qBT6K9qQIFV6hzv2ReVLiN7+T42WIuJ/ zSqWSLKwq8Htl3ltigQu3Fhh9bfHPGLgi89z8nxPVn6Sg4v2cTBB6VV2tE43MBKgEnyvnUS9Q9yR/l ZQUIf+X8o96y3VNP2trMA6v4l3q5cCJnnh08R1EPHNydM=
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

Avoid building the mem_encrypt.o object if memory encryption support is
not enabled to begin with.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/Makefile      | 2 +-
 arch/x86/boot/compressed/mem_encrypt.S | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

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
index b4a116283bd9..fad0978d6799 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -56,8 +56,6 @@ SYM_FUNC_START(get_sev_encryption_bit)
 	RET
 SYM_FUNC_END(get_sev_encryption_bit)
 
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-
 /**
  * sev_es_req_cpuid - Request a CPUID value from the Hypervisor using
  *		      the GHCB MSR protocol
@@ -312,4 +310,3 @@ SYM_DATA_START_LOCAL(boot32_idt_desc)
 	.word   . - boot32_idt - 1
 	.long   0
 SYM_DATA_END(boot32_idt_desc)
-#endif
-- 
2.35.1

