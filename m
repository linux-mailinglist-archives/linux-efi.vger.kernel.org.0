Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A474F17D280
	for <lists+linux-efi@lfdr.de>; Sun,  8 Mar 2020 09:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgCHIKM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Mar 2020 04:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCHIKL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 8 Mar 2020 04:10:11 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 668F02084E;
        Sun,  8 Mar 2020 08:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583655010;
        bh=t0zvztmSKZBoKnmOYnVnakURJ8XSfvQMNh6AI9EG5U4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HTgQG5AXw5GRdnhwSuCXacqg1T8fwvrsfRvDN7h/XavfpT75YOP3jQUC8HXm3r8S1
         syj1PmSvVHIhQvV1l9dcjcuEi/mpKvHCY1I1vmo0Hc8go6UbLTIlW0Nb72Og7kMlFy
         3SuLGoaJHpGSO/MTR/gmgGARKeXDzGU2Ws74gWzM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nikolai Merinov <n.merinov@inango-systems.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH 18/28] efi/x86: Remove extra headroom for setup block
Date:   Sun,  8 Mar 2020 09:08:49 +0100
Message-Id: <20200308080859.21568-19-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200308080859.21568-1-ardb@kernel.org>
References: <20200308080859.21568-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

commit 223e3ee56f77 ("efi/x86: add headroom to decompressor BSS to
account for setup block") added headroom to the PE image to account for
the setup block, which wasn't used for the decompression buffer.

Now that the decompression buffer is located at the start of the image,
and includes the setup block, this is no longer required.

Add a check to make sure that the head section of the compressed kernel
won't overwrite itself while relocating. This is only for
future-proofing as with current limits on the setup and the actual size
of the head section, this can never happen.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200303221205.4048668-5-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/tools/build.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 90d403dfec80..3d03ad753ed5 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -65,6 +65,8 @@ unsigned long efi_pe_entry;
 unsigned long efi32_pe_entry;
 unsigned long kernel_info;
 unsigned long startup_64;
+unsigned long _ehead;
+unsigned long _end;
 
 /*----------------------------------------------------------------------*/
 
@@ -232,7 +234,7 @@ static void update_pecoff_text(unsigned int text_start, unsigned int file_sz,
 {
 	unsigned int pe_header;
 	unsigned int text_sz = file_sz - text_start;
-	unsigned int bss_sz = init_sz + text_start - file_sz;
+	unsigned int bss_sz = init_sz - file_sz;
 
 	pe_header = get_unaligned_le32(&buf[0x3c]);
 
@@ -259,7 +261,7 @@ static void update_pecoff_text(unsigned int text_start, unsigned int file_sz,
 	put_unaligned_le32(file_sz - 512 + bss_sz, &buf[pe_header + 0x1c]);
 
 	/* Size of image */
-	put_unaligned_le32(init_sz + text_start, &buf[pe_header + 0x50]);
+	put_unaligned_le32(init_sz, &buf[pe_header + 0x50]);
 
 	/*
 	 * Address of entry point for PE/COFF executable
@@ -360,6 +362,8 @@ static void parse_zoffset(char *fname)
 		PARSE_ZOFS(p, efi32_pe_entry);
 		PARSE_ZOFS(p, kernel_info);
 		PARSE_ZOFS(p, startup_64);
+		PARSE_ZOFS(p, _ehead);
+		PARSE_ZOFS(p, _end);
 
 		p = strchr(p, '\n');
 		while (p && (*p == '\r' || *p == '\n'))
@@ -444,6 +448,26 @@ int main(int argc, char ** argv)
 	put_unaligned_le32(sys_size, &buf[0x1f4]);
 
 	init_sz = get_unaligned_le32(&buf[0x260]);
+#ifdef CONFIG_EFI_STUB
+	/*
+	 * The decompression buffer will start at ImageBase. When relocating
+	 * the compressed kernel to its end, we must ensure that the head
+	 * section does not get overwritten.  The head section occupies
+	 * [i, i + _ehead), and the destination is [init_sz - _end, init_sz).
+	 *
+	 * At present these should never overlap, because i is at most 32k
+	 * because of SETUP_SECT_MAX, _ehead is less than 1k, and the
+	 * calculation of INIT_SIZE in boot/header.S ensures that
+	 * init_sz - _end is at least 64k.
+	 *
+	 * For future-proofing, increase init_sz if necessary.
+	 */
+
+	if (init_sz - _end < i + _ehead) {
+		init_sz = (i + _ehead + _end + 4095) & ~4095;
+		put_unaligned_le32(init_sz, &buf[0x260]);
+	}
+#endif
 	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16), init_sz);
 
 	efi_stub_entry_update();
-- 
2.17.1

