Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402446FA093
	for <lists+linux-efi@lfdr.de>; Mon,  8 May 2023 09:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjEHHGT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 May 2023 03:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbjEHHFo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 May 2023 03:05:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447441A130;
        Mon,  8 May 2023 00:05:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5200561F9A;
        Mon,  8 May 2023 07:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AB2C4339E;
        Mon,  8 May 2023 07:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683529504;
        bh=KZW/tFXMGGOj2MJEPl8J+2P+ukf3gwy/b1cibtTCM2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uf9hBgxspbXNuKRQ9B4q9XpoSMSLjSdoiefyJe+4fLr53ld0LEmyMir5tgEUB+8HO
         ihtNDLO99Om+BN0l2EIaNTf28T38A89nuurh4Gq3ZO3PSnmnqo/ZkhanANhpiL6Lv9
         VnANpc7xZKswhVu5JOXoEFrli2SWP33nVNvKuJEu4U9fHphQwbNSJroipu138ygFdl
         TLvsrMCWbbwAtB3gMlal2hivCmn0Gg3d+4q0UTVIBYt0bC9L2EAD/JexgStlSV55P4
         TCGcfpc95pAelaMk0qrm9VKUEWJvD0uL/5EDqRU4UAg/NkbHdY+2yz/52L2sKz39LD
         I0wHIywDBkyfg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 20/20] x86: decompressor: Avoid magic offsets for EFI handover entrypoint
Date:   Mon,  8 May 2023 09:03:30 +0200
Message-Id: <20230508070330.582131-21-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508070330.582131-1-ardb@kernel.org>
References: <20230508070330.582131-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804; i=ardb@kernel.org; h=from:subject; bh=KZW/tFXMGGOj2MJEPl8J+2P+ukf3gwy/b1cibtTCM2Y=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVi3qGjnOc+6p4w7IvRl16U8PaWTNCHn46utT2aORHdY S+ytyzuKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABORXMXw39s9e6/ke4FMA8+V s61Wbzs+zTLtwNnHa0ULH04/23lGnI/hr0BX3XSPOGfOzRmrq3Y6v3kzfRLr0od2gr6O1vvU25t DWQA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The special EFI handover protocol entrypoint offset wrt to the
startup_XX address is described in struct boot_params as
handover_offset, so that the special Linux/x86 aware EFI loader can find
it there.

When mixed mode is enabled, this single field has to describe this
offset for both the 32-bit and 64-bit entrypoints, so their respective
relative offsets have to be identical.

Currently, we use hard-coded fixed offsets to ensure this, but the only
requirement is that the entrypoints are 0x200 bytes apart, and this only
matters when EFI mixed mode is configured to begin with.

So just set the required offset directly. This could potentially result
in a build error if the 32-bit startup code is much smaller than the
64-bit code but this is currently far from the case, and easily fixed
when that situation does arise.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index b7599cbbd2ea1136..72780644a2272af8 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -282,7 +282,6 @@ SYM_FUNC_START(startup_32)
 SYM_FUNC_END(startup_32)
 
 #if IS_ENABLED(CONFIG_EFI_MIXED) && IS_ENABLED(CONFIG_EFI_HANDOVER_PROTOCOL)
-	.org 0x190
 SYM_FUNC_START(efi32_stub_entry)
 	add	$0x4, %esp		/* Discard return address */
 	popl	%ecx
@@ -455,7 +454,9 @@ SYM_CODE_START(startup_64)
 SYM_CODE_END(startup_64)
 
 #ifdef CONFIG_EFI_HANDOVER_PROTOCOL
-	.org 0x390
+#ifdef CONFIG_EFI_MIXED
+	.org	efi32_stub_entry + 0x200
+#endif
 SYM_FUNC_START(efi64_stub_entry)
 	and	$~0xf, %rsp			/* realign the stack */
 	call	efi_handover_entry
-- 
2.39.2

