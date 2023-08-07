Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF54772AD7
	for <lists+linux-efi@lfdr.de>; Mon,  7 Aug 2023 18:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjHGQ3V (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Aug 2023 12:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjHGQ3C (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Aug 2023 12:29:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C411BF3;
        Mon,  7 Aug 2023 09:28:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 989D561F1C;
        Mon,  7 Aug 2023 16:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8036BC433BB;
        Mon,  7 Aug 2023 16:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691425703;
        bh=35ydgYIIKoLxZL2vz2F8XVJhO0j9D3mjWHEuMrtQ7Ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ssqE4t2IQ41OEktqZdVAF4gYDntvq/TfpZG5+4tT+PJasiKss/fje4B5BgpfsYF7n
         MaFyt4IqJr+ZxsWT6iSGlV17EZnLlhs3dsdIVfrHWTT1CNcy67APEFTMnbSq+Sizel
         XuSK6ZIytlOqjmyxGkNGFOPTYPQUMLOZGv1/yc+quuuc15EtrxgI0l8HUZGa+kwYH0
         2DTkMi7EqFWOdL9iycADY2XsLvvRZBMuhnQP9M7UnLFgrl4sTyH9z1Y0sWunkL+I5x
         OqAtt2s6eygHtBSQ6JrrKZqUe3AkbPoWYKyMhB4553DzBU5aGjHVmUgu2HIPe3LRsn
         0FGB7kJMfqHtQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v9 20/23] x86/decompressor: Factor out kernel decompression and relocation
Date:   Mon,  7 Aug 2023 18:27:17 +0200
Message-Id: <20230807162720.545787-21-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807162720.545787-1-ardb@kernel.org>
References: <20230807162720.545787-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2968; i=ardb@kernel.org; h=from:subject; bh=35ydgYIIKoLxZL2vz2F8XVJhO0j9D3mjWHEuMrtQ7Ck=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeWidMqCOW4KNUnqByqPOCZ13eQrkfQ6c6z99LL6qz3rP l+M8PzUUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZyOIKR4cihX7sM/n+x1dhr 5FEZpFN5teWZrnqXveXiD4VrSl3iFzMyTL4/M9NERzP14xXZa7uYbwZsM17Yufj6dfsPvkkm/7v iGAE=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Factor out the decompressor sequence that invokes the decompressor,
parses the ELF and applies the relocations so that it can be called
directly from the EFI stub.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/misc.c | 28 ++++++++++++++++----
 arch/x86/include/asm/boot.h     |  8 ++++++
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 2d91d56b59e1af93..f711f2a85862e9ef 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -330,11 +330,33 @@ static size_t parse_elf(void *output)
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
+	if (__decompress(input_data, input_len, NULL, NULL, outbuf, output_len,
+			 NULL, error) < 0)
+		return ULONG_MAX;
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
@@ -354,7 +376,6 @@ extern unsigned int input_len, output_len;
  */
 asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 {
-	const unsigned long kernel_total_size = VO__end - VO__text;
 	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
 	memptr heap = (memptr)boot_heap;
 	unsigned long needed_size;
@@ -463,10 +484,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 		accept_memory(__pa(output), __pa(output) + needed_size);
 	}
 
-	__decompress(input_data, input_len, NULL, NULL, output, output_len,
-			NULL, error);
-	entry_offset = parse_elf(output);
-	handle_relocations(output, output_len, virt_addr);
+	entry_offset = decompress_kernel(output, virt_addr, error);
 
 	debug_putstr("done.\nBooting the kernel (entry_offset: 0x");
 	debug_puthex(entry_offset);
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 9191280d9ea3160d..4ae14339cb8cc72d 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -62,4 +62,12 @@
 # define BOOT_STACK_SIZE	0x1000
 #endif
 
+#ifndef __ASSEMBLY__
+extern unsigned int output_len;
+extern const unsigned long kernel_total_size;
+
+unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
+				void (*error)(char *x));
+#endif
+
 #endif /* _ASM_X86_BOOT_H */
-- 
2.39.2

