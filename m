Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A966ED2F6
	for <lists+linux-efi@lfdr.de>; Mon, 24 Apr 2023 18:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjDXQ6A (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Apr 2023 12:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjDXQ55 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Apr 2023 12:57:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B169001;
        Mon, 24 Apr 2023 09:57:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9798862241;
        Mon, 24 Apr 2023 16:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D69EC4339E;
        Mon, 24 Apr 2023 16:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682355465;
        bh=80bWD8npnkuVdzVziNnGYFO9rJkT0AdFSNVqiqvnJ4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E1RCSpsjHiZufMimPQXIKjI1Rd7JXm1nzXIjU7toafrFxGf14xUaSsVI/aU8VIhXZ
         ZVSb1E+hriEiFuChg/TyF8QAi2Z5Vh1OHfZBd2RgWwC2sYCJup/ArslKHadweS+x+T
         iNK2roTV3Likh8n8HFbiWRzGHkW31sZw4reoGshv9665aYovbzpw6nsn1B2wwb1OEw
         WczIpVy5Ix0ugaHFW1Ap93ZmKm6XwvmhgvkOB5ZSB+ZZz1uVbcMybR0KkcTB7I0G/s
         2vf6DsT1NcsVKkM5y76RR2F++WAUyiaGTX8vch9IOu+B7NM2b5Ziba2CUmxVEcdeWJ
         wTJAFM5oFSCDg==
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
Subject: [PATCH 2/6] x86: decompressor: Factor out kernel decompression and relocation
Date:   Mon, 24 Apr 2023 18:57:22 +0200
Message-Id: <20230424165726.2245548-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424165726.2245548-1-ardb@kernel.org>
References: <20230424165726.2245548-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2351; i=ardb@kernel.org; h=from:subject; bh=80bWD8npnkuVdzVziNnGYFO9rJkT0AdFSNVqiqvnJ4w=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIcVty4eg9+zBkWuPvC9QTSiJrTg46/iut40+2dxbTRK4l s8P/1zeUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbCvYThn1YNx+8Vp3bP1g2N UH02oW6PrcKcuR4sp+6ss5YxibFhE2b4HyU253qBj/5N9gOTTvbJKt/w/Chy8jOrXUysrFH39XU tDAA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Factor out the decompressor sequence that invokes the decompressor,
parses the ELF and applies the relocations so that we will be able to
call it directly from the EFI stub.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/misc.c | 27 ++++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 3b79667412ceb388..0fa5df49ce14f196 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -330,11 +330,32 @@ static size_t parse_elf(void *output)
 	return ehdr.e_entry - LOAD_PHYSICAL_ADDR;
 }
 
+const unsigned long kernel_total_size = VO__end - VO__text;
+
 static u8 boot_heap[BOOT_HEAP_SIZE] __aligned(4);
 
 extern unsigned char input_data[];
 extern unsigned int input_len, output_len;
 
+unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
+				void (*error)(char *x))
+{
+	unsigned long entry;
+
+	if (!free_mem_ptr) {
+		free_mem_ptr     = (unsigned long)boot_heap;
+		free_mem_end_ptr = (unsigned long)boot_heap + sizeof(boot_heap);
+	}
+
+	__decompress(input_data, input_len, NULL, NULL, outbuf, output_len,
+		     NULL, error);
+
+	entry = parse_elf(outbuf);
+	handle_relocations(outbuf, output_len, virt_addr);
+
+	return entry;
+}
+
 /*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
@@ -355,7 +376,6 @@ extern unsigned int input_len, output_len;
 asmlinkage __visible void *extract_kernel(void *rmode,
 				  unsigned char *output)
 {
-	const unsigned long kernel_total_size = VO__end - VO__text;
 	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
 	memptr heap = (memptr)boot_heap;
 	unsigned long needed_size;
@@ -458,10 +478,7 @@ asmlinkage __visible void *extract_kernel(void *rmode,
 #endif
 
 	debug_putstr("\nDecompressing Linux... ");
-	__decompress(input_data, input_len, NULL, NULL, output, output_len,
-			NULL, error);
-	entry_offset = parse_elf(output);
-	handle_relocations(output, output_len, virt_addr);
+	entry_offset = decompress_kernel(output, virt_addr, error);
 
 	debug_putstr("done.\nBooting the kernel (entry_offset: 0x");
 	debug_puthex(entry_offset);
-- 
2.39.2

