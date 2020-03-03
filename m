Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0799817854D
	for <lists+linux-efi@lfdr.de>; Tue,  3 Mar 2020 23:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgCCWMN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Mar 2020 17:12:13 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35453 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbgCCWMM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Mar 2020 17:12:12 -0500
Received: by mail-qt1-f195.google.com with SMTP id v15so1343497qto.2;
        Tue, 03 Mar 2020 14:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vQx7FGziZfvZ+uJJoZ5T61fhrPtNY4KnIrK1LWeACyQ=;
        b=F2fHwcupiv+9VppG5BuYyxiA3sygvouUnZTyEbe4MafyardHB/vL6353Ly9WjviBRa
         eVyXoJCmpBNetNUcru9Pxkdf27DKy6P4AJG6Zy+ryl4WfzLhDLfdaImoXCpJEU2GtdxJ
         5xPHjnZCkDPjxKw/eWRpMlFouiniK55nVRSj2czKgtAXW6kL1Rwacgjy3yIKlnIILReE
         lSAjDrmhbP2K6ljafCGVvuIDnF/DYwD5ckcOQwMbbiiY3x2W2ljAf/tpTjkSxX6TBXjm
         49+h6EbTlydJR3P0tRKzqB4U5VmYvQDawxZtOuxoB/n2c4zEvxAkVg3HYs0namua0jOU
         zk2g==
X-Gm-Message-State: ANhLgQ0rhgTMWm3KZdCu73Xe4LgGl2qLwnJUZ427spMzAiSavqyQClCP
        lPXTZxXOo0bnfOiNads7U0E=
X-Google-Smtp-Source: ADFU+vshsB9lMkvhs9h+psMOIx/jhLBmuNrFpZxVybguzxUf9II1jZKtl8D8QMql12UAP4mzuoNLIw==
X-Received: by 2002:aed:308a:: with SMTP id 10mr6647996qtf.221.1583273529360;
        Tue, 03 Mar 2020 14:12:09 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id i91sm13267378qtd.70.2020.03.03.14.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 14:12:09 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] efi/x86: Remove extra headroom for setup block
Date:   Tue,  3 Mar 2020 17:12:04 -0500
Message-Id: <20200303221205.4048668-5-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200303221205.4048668-1-nivedita@alum.mit.edu>
References: <20200301230537.2247550-1-nivedita@alum.mit.edu>
 <20200303221205.4048668-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

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
2.24.1

