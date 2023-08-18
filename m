Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06370780CC4
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 15:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377257AbjHRNpY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 09:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377303AbjHRNpE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 09:45:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F3E3C3C;
        Fri, 18 Aug 2023 06:44:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A981B66DF3;
        Fri, 18 Aug 2023 13:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FA1C433C9;
        Fri, 18 Aug 2023 13:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692366298;
        bh=ZPAhqjwxE/sskeygZ8pPFIw9ZGF696+JeFy5DBEGMD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ctcKeCjeTqGKSDJnrmhYeHe4bPrMvhKv02wqeQ2slFTSofmQ+O1Ppurfq5CjmFVxu
         49/LBYrczUzaT8T2Oemggj+t60L8jpH0MHWwzWsaqEbqtTZzdEON8jU2lQZi6zXPft
         cyVhBReIJ3TeDmX+xyKVo4eHmnJ+TID/j78yR3c1rtPjvgccQ/dmCioHa+rBy01rXS
         S8oHBcl/AzRzC1Z19Tb1brqSTPSZjaQMCnwgeHTfJBd6L9SBdawVYw1KHi+vCfUUXe
         eiS5GSbtARTpz0GlEEAZVLchrLTbpw8SqA6y1ZbvoYYayIzphrCrpnT4sSIHwYCIEx
         +tWUYa3PtUW8A==
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
Subject: [PATCH 05/17] x86/boot: Omit compression buffer from PE/COFF image memory footprint
Date:   Fri, 18 Aug 2023 15:44:10 +0200
Message-Id: <20230818134422.380032-6-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818134422.380032-1-ardb@kernel.org>
References: <20230818134422.380032-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5235; i=ardb@kernel.org; h=from:subject; bh=ZPAhqjwxE/sskeygZ8pPFIw9ZGF696+JeFy5DBEGMD4=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV+6QLXfr+EHMspFTEpk+Tl4qJ6t8nez/qUKW99R3f7T 1PRZfc6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwETO32NkeLuCI/4307Tm61c/ lbfP42yansBw5fWUWa9WeEkElryqWM3I8H7ti3r+iG3301UnFt1bdOZoVmXF96WOrqpTpx36v6T qAycA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Now that the EFI stub decompresses the kernel and hands over to the
decompressed image directly, there is no longer a need to provide a
decompression buffer as part of the .BSS allocation of the PE/COFF
image. It also means the PE/COFF image can be loaded anywhere in memory,
and setting the preferred image base is unnecessary. So drop the
handling of this from the header and from the build tool.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S      |  6 +--
 arch/x86/boot/tools/build.c | 50 +++-----------------
 2 files changed, 8 insertions(+), 48 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index b24fa50a98986945..a87d9133384b0986 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -90,12 +90,10 @@ optional_header:
 #endif
 
 extra_header_fields:
-	# PE specification requires ImageBase to be 64k aligned
-	.set	image_base, (LOAD_PHYSICAL_ADDR + 0xffff) & ~0xffff
 #ifdef CONFIG_X86_32
-	.long	image_base			# ImageBase
+	.long	0				# ImageBase
 #else
-	.quad	image_base			# ImageBase
+	.quad	0				# ImageBase
 #endif
 	.long	0x20				# SectionAlignment
 	.long	0x20				# FileAlignment
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index bd247692b70174f0..0354c223e35492b6 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -65,7 +65,6 @@ static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
 static unsigned long kernel_info;
 static unsigned long startup_64;
-static unsigned long _ehead;
 static unsigned long _end;
 
 /*----------------------------------------------------------------------*/
@@ -229,27 +228,14 @@ static void update_pecoff_setup_and_reloc(unsigned int size)
 #endif
 }
 
-static void update_pecoff_text(unsigned int text_start, unsigned int file_sz,
-			       unsigned int init_sz)
+static void update_pecoff_text(unsigned int text_start, unsigned int file_sz)
 {
 	unsigned int pe_header;
 	unsigned int text_sz = file_sz - text_start;
-	unsigned int bss_sz = init_sz - file_sz;
+	unsigned int bss_sz = _end - text_sz;
 
 	pe_header = get_unaligned_le32(&buf[0x3c]);
 
-	/*
-	 * The PE/COFF loader may load the image at an address which is
-	 * misaligned with respect to the kernel_alignment field in the setup
-	 * header.
-	 *
-	 * In order to avoid relocating the kernel to correct the misalignment,
-	 * add slack to allow the buffer to be aligned within the declared size
-	 * of the image.
-	 */
-	bss_sz	+= CONFIG_PHYSICAL_ALIGN;
-	init_sz	+= CONFIG_PHYSICAL_ALIGN;
-
 	/*
 	 * Size of code: Subtract the size of the first sector (512 bytes)
 	 * which includes the header.
@@ -257,7 +243,7 @@ static void update_pecoff_text(unsigned int text_start, unsigned int file_sz,
 	put_unaligned_le32(file_sz - 512 + bss_sz, &buf[pe_header + 0x1c]);
 
 	/* Size of image */
-	put_unaligned_le32(init_sz, &buf[pe_header + 0x50]);
+	put_unaligned_le32(file_sz + bss_sz, &buf[pe_header + 0x50]);
 
 	/*
 	 * Address of entry point for PE/COFF executable
@@ -308,8 +294,7 @@ static void efi_stub_entry_update(void)
 
 static inline void update_pecoff_setup_and_reloc(unsigned int size) {}
 static inline void update_pecoff_text(unsigned int text_start,
-				      unsigned int file_sz,
-				      unsigned int init_sz) {}
+				      unsigned int file_sz) {}
 static inline void efi_stub_defaults(void) {}
 static inline void efi_stub_entry_update(void) {}
 
@@ -360,7 +345,6 @@ static void parse_zoffset(char *fname)
 		PARSE_ZOFS(p, efi32_pe_entry);
 		PARSE_ZOFS(p, kernel_info);
 		PARSE_ZOFS(p, startup_64);
-		PARSE_ZOFS(p, _ehead);
 		PARSE_ZOFS(p, _end);
 
 		p = strchr(p, '\n');
@@ -371,7 +355,7 @@ static void parse_zoffset(char *fname)
 
 int main(int argc, char ** argv)
 {
-	unsigned int i, sz, setup_sectors, init_sz;
+	unsigned int i, sz, setup_sectors;
 	int c;
 	u32 sys_size;
 	struct stat sb;
@@ -442,31 +426,9 @@ int main(int argc, char ** argv)
 	buf[0x1f1] = setup_sectors-1;
 	put_unaligned_le32(sys_size, &buf[0x1f4]);
 
-	init_sz = get_unaligned_le32(&buf[0x260]);
-#ifdef CONFIG_EFI_STUB
-	/*
-	 * The decompression buffer will start at ImageBase. When relocating
-	 * the compressed kernel to its end, we must ensure that the head
-	 * section does not get overwritten.  The head section occupies
-	 * [i, i + _ehead), and the destination is [init_sz - _end, init_sz).
-	 *
-	 * At present these should never overlap, because 'i' is at most 32k
-	 * because of SETUP_SECT_MAX, '_ehead' is less than 1k, and the
-	 * calculation of INIT_SIZE in boot/header.S ensures that
-	 * 'init_sz - _end' is at least 64k.
-	 *
-	 * For future-proofing, increase init_sz if necessary.
-	 */
-
-	if (init_sz - _end < i + _ehead) {
-		init_sz = (i + _ehead + _end + 4095) & ~4095;
-		put_unaligned_le32(init_sz, &buf[0x260]);
-	}
-#endif
-	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16), init_sz);
+	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16));
 
 	efi_stub_entry_update();
-
 	/* Update kernel_info offset. */
 	put_unaligned_le32(kernel_info, &buf[0x268]);
 
-- 
2.39.2

