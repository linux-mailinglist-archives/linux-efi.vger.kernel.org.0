Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00DD6B90E7
	for <lists+linux-efi@lfdr.de>; Tue, 14 Mar 2023 12:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjCNLCZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Mar 2023 07:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCNLCT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Mar 2023 07:02:19 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A33E97496;
        Tue, 14 Mar 2023 04:02:02 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 08C8F40737D3;
        Tue, 14 Mar 2023 10:23:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 08C8F40737D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678789405;
        bh=/G8EQcMuvoVva9B2NhxYrS7VpQJwJ20TsfMLy4yHCGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EsQPifEkxWI0lhr8YJW1z0mKcjtHOfMworR2rAhyguUaQK0XDCHu7j7z3f3onPrCN
         rou8zOZC2nl94G7DoWdNi7+JWZqbyeMyqqqrl9ka0j/TDMUNkzJVIbafDDnWWJu+It
         izKgBPvz6UM2I58hWctjYUyQAryxA9Bu9TEBfS/A=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v5 21/27] x86/build: Add SETUP_HEADER_OFFSET constant
Date:   Tue, 14 Mar 2023 13:13:48 +0300
Message-Id: <100717e1adf0cb3ca27d4305df48ea5ce385022c.1678785672.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678785672.git.baskov@ispras.ru>
References: <cover.1678785672.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add and use SETUP_HEADER_OFFSET constant in tools/build.c for
readability purposes. It equals to the struct boot_params offset in
kernel image.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/tools/build.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 84d5a5cc7756..476ef05f16fb 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -51,6 +51,8 @@ typedef unsigned int   u32;
 #define SETUP_SECT_MIN 5
 #define SETUP_SECT_MAX 64
 
+#define SETUP_HEADER_OFFSET 0x1f1
+
 #define PARAGRAPH_SIZE 16
 #define SECTOR_SIZE 512
 #define FILE_ALIGNMENT 512
@@ -473,7 +475,7 @@ static unsigned int read_setup(char *path)
 	if (file_size < 2 * SECTOR_SIZE)
 		die("The setup must be at least 1024 bytes");
 
-	if (get_unaligned_le16(&buf[SECTOR_SIZE - 2]) != 0xAA55)
+	if (get_unaligned_le16(&buf[SETUP_HEADER_OFFSET + 0xD]) != 0xAA55)
 		die("Boot block hasn't got boot flag (0xAA55)");
 
 	fclose(file);
@@ -509,6 +511,7 @@ int main(int argc, char **argv)
 	unsigned int kern_size;
 	void *kernel;
 	u32 crc = 0xffffffffUL;
+	u8 *setup_header;
 	u8 *output;
 
 	if (argc != 5)
@@ -520,9 +523,10 @@ int main(int argc, char **argv)
 	setup_size = read_setup(argv[1]);
 
 	setup_sectors = setup_size/SECTOR_SIZE;
+	setup_header = buf + SETUP_HEADER_OFFSET;
 
 	/* Set the default root device */
-	put_unaligned_le16(DEFAULT_ROOT_DEV, &buf[508]);
+	put_unaligned_le16(DEFAULT_ROOT_DEV, &setup_header[0xB]);
 
 	/* Map kernel file to memory */
 	kernel = map_file(argv[2], &kern_file_size);
@@ -537,13 +541,13 @@ int main(int argc, char **argv)
 #endif
 
 	/* Patch the setup code with the appropriate size parameters */
-	buf[0x1f1] = setup_sectors - 1;
-	put_unaligned_le32(kern_size/PARAGRAPH_SIZE, &buf[0x1f4]);
+	setup_header[0] = setup_sectors - 1;
+	put_unaligned_le32(kern_size/PARAGRAPH_SIZE, &setup_header[3]);
 
-	/* Update kernel_info offset. */
-	put_unaligned_le32(kernel_info, &buf[0x268]);
+	/* Update kernel_info_offset. */
+	put_unaligned_le32(kernel_info, &setup_header[0x77]);
 
-	init_size = get_unaligned_le32(&buf[0x260]);
+	init_size = get_unaligned_le32(&setup_header[0x6F]);
 
 #ifdef CONFIG_EFI_STUB
 	/*
@@ -562,7 +566,7 @@ int main(int argc, char **argv)
 
 	if (init_size - _end < setup_size + _ehead) {
 		init_size = round_up(setup_size + _ehead + _end, SECTION_ALIGNMENT);
-		put_unaligned_le32(init_size, &buf[0x260]);
+		put_unaligned_le32(init_size, &setup_header[0x6F]);
 	}
 
 	total_size = update_pecoff_sections(setup_size, kern_size, init_size);
@@ -581,8 +585,9 @@ int main(int argc, char **argv)
 
 #ifdef CONFIG_EFI_STUB
 	/* Copy the setup header */
-	memcpy(output + setup_size + efi_boot_params + 0x1f1, &buf[0x1f1],
-	       0x290 - 0x1f1 /* == max possible sizeof(struct setup_header) */);
+	memcpy(output + setup_size + efi_boot_params + SETUP_HEADER_OFFSET,
+	       setup_header, 0x290 - SETUP_HEADER_OFFSET
+	       /* == max possible sizeof(struct setup_header) */);
 #endif
 
 	/* Calculate and write kernel checksum. */
-- 
2.39.2

