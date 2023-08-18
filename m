Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F0C780CC7
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 15:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377281AbjHRNpY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 09:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377356AbjHRNpP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 09:45:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DDD3C35;
        Fri, 18 Aug 2023 06:45:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 438CC6377E;
        Fri, 18 Aug 2023 13:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2FBC433C7;
        Fri, 18 Aug 2023 13:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692366304;
        bh=2RDy+W/bBz8r/G8wx1n/R7eiKUx6glvcr3j1Qzz9c44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nZMC3I9RTRSpEMY6srqglIe7t//9k7QF0ztFy0LN5qdkdG0roZrpLklM6PJV1wEAI
         H78c2U+UGJN2D2UhgiT9VdHGGd3/9NssZudGoXYmbB2yBa7vqY++Bu1a+TDrelkSCA
         0Pls3tpGVqEhJJ73VOR0eztM8nWdOA0FVmmpOVARGFBzvaXDqHReYHbhG0gnTPSd/z
         MFRMRmcZodd1CH/ZG9M6r9NQvy/HEzLgC7eMPaUfn8dv6zJDtD9si8uxj6r6kIptqX
         KuebsCionpHdJmoHgfexfWcrUH0CBTsKUSQin4t7s9K2gl2rK2rtGuAem4L7RN5lCq
         +1erXE0NioIaA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?q?Marvin=20H=C3=A4user?= <mhaeuser@posteo.de>
Subject: [PATCH 07/17] x86/boot: Grab kernel_info offset from zoffset header directly
Date:   Fri, 18 Aug 2023 15:44:12 +0200
Message-Id: <20230818134422.380032-8-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818134422.380032-1-ardb@kernel.org>
References: <20230818134422.380032-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1967; i=ardb@kernel.org; h=from:subject; bh=2RDy+W/bBz8r/G8wx1n/R7eiKUx6glvcr3j1Qzz9c44=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV+6eKQvl3RMq6L3yTPWfc2U9yA48aPqXIsc1lTny6Xv eh//FtxRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjItK0M/5NaeMJ+3N7Lccmc Q+Oalsu8mkfzcsXYPG/sXvl9S9u30O0M/10/PFn3wtY4rUPRtcrv1US5O2oP5eu902a+Ern5vjv YlQ0A
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

Instead of parsing zoffset.h and poking the kernel_info offset value
into the header from the build tool, just grab the value directly in the
asm file that describes this header.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S      | 2 +-
 arch/x86/boot/tools/build.c | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 6059f87b159d0e14..5575d0f06bab1918 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -526,7 +526,7 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred load addr
 
 init_size:		.long INIT_SIZE		# kernel initialization size
 handover_offset:	.long 0			# Filled in by build.c
-kernel_info_offset:	.long 0			# Filled in by build.c
+kernel_info_offset:	.long ZO_kernel_info
 
 # End of setup header #####################################################
 
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index efa4e9c7d7135ba7..660627ea6cbb46f5 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -59,7 +59,6 @@ static unsigned long efi32_stub_entry;
 static unsigned long efi64_stub_entry;
 static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
-static unsigned long kernel_info;
 static unsigned long startup_64;
 static unsigned long _end;
 
@@ -339,7 +338,6 @@ static void parse_zoffset(char *fname)
 		PARSE_ZOFS(p, efi64_stub_entry);
 		PARSE_ZOFS(p, efi_pe_entry);
 		PARSE_ZOFS(p, efi32_pe_entry);
-		PARSE_ZOFS(p, kernel_info);
 		PARSE_ZOFS(p, startup_64);
 		PARSE_ZOFS(p, _end);
 
@@ -422,8 +420,6 @@ int main(int argc, char ** argv)
 	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16));
 
 	efi_stub_entry_update();
-	/* Update kernel_info offset. */
-	put_unaligned_le32(kernel_info, &buf[0x268]);
 
 	crc = partial_crc32(buf, i, crc);
 	if (fwrite(buf, 1, i, dest) != i)
-- 
2.39.2

