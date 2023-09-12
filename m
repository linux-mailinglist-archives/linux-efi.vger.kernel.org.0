Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F74379CAE4
	for <lists+linux-efi@lfdr.de>; Tue, 12 Sep 2023 11:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjILJCS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Sep 2023 05:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbjILJBm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Sep 2023 05:01:42 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7B210F2
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 02:01:38 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-401d9abf21cso44365835e9.0
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 02:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694509297; x=1695114097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fe+/cU9QRFOgu9GR9ilVdqMZbBq1lerXnHnsmRtv0H4=;
        b=YJoGIzx2xv6fF76kQnFEf5B6eO1nIDRBvinjs+npO2z2r+8M1YLlMAQFgRTpqQtG5M
         AacTY4SiXUmoX48LTyEUzvjY3Koirci1ab5ALEvgm1JIOX++MD7T3pi/R35hLw4whhO/
         2o6I8FdViErsJa7CKVO+RNSDvKChQIKsZqYBc1SY7hJyWB447o8/joWvzzf7ZjDm0rYN
         4Lrh7RkvCJ2tQrrUKLp1BH2oMUs4TVWtTTbC0gpYBrjOK+J7KH/mSc8ANTHHXAFTTKVT
         hTDZb3eH+FE/ZVQeqvKXuAaWPUIclgPPLq6VAXS1NKl/7XLpsc8HCkgsBihVF3rHEeKJ
         sfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509297; x=1695114097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fe+/cU9QRFOgu9GR9ilVdqMZbBq1lerXnHnsmRtv0H4=;
        b=HeEVRsJ+njuy0t59wTnZpXC/a7NCekOfPLjGmSzm9c9mgZm8KBQg2C+ay/D7m3Vnc3
         iXAmMbvbXDjU80zH1IK0jNyRB5cnHKN2arrQ7CRDhMSZ/Ooq3xD42VDGSCOKsUqB+8A0
         sTsRaR1EJyYz0wW8yZWojCHfcQQQFFHJYCfZbKxgMFnS6NBQGsSyKQM80u3Wdbf8OduE
         6d9KPc+I8uepPLQyENQLb5Bmj/l1i5a9jzpKsMmS2lDnflrfG6YR1wWbbEsSuKnUdFOS
         cITOyLUY0PhLOKin8OpxZuC1diMnGUrxmHto1ArcNXx95xVxDlZm7xOOjtArlaW6TlAQ
         JEVw==
X-Gm-Message-State: AOJu0YzfkOtbBTpxD/w4xv8ft7jS0FmTmuKCWTiuQ/0a9TZQI0RqHNG/
        tegXcoFLNHF2jNU03G+bHr7WJKtw+11DF+LvIXdNKjCZ9QHVEMJqMziJ/0cglpdc1FhlgxHN2rF
        ERYopyshTN8V611dpcwun0JYsjt5X15i3OLxlcFF9Fc4Y65tJFppzQUwPuYOb
X-Google-Smtp-Source: AGHT+IFU2h7tClDmAtRVWp+NUQEbamdyRXRXHAQRTZbmFrofGwJL81SORIFeYDnT+doGzNqsxYdr2YkV
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:180b:b0:31d:3669:1c57 with SMTP id
 m11-20020a056000180b00b0031d36691c57mr136857wrh.7.1694509297239; Tue, 12 Sep
 2023 02:01:37 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:00:56 +0000
In-Reply-To: <20230912090051.4014114-17-ardb@google.com>
Mime-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5240; i=ardb@kernel.org;
 h=from:subject; bh=wBN5p9iqf+zXksMG8YvWV0u77eSyD0wh6+R0/IxKHqc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVB4yT3BsEV2T3uV2as43gkvCqwcY+CmPKvCv15TaUtb
 +60Wfp3lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgInskGJkeDgxQPP6+rfbDx88
 kqpnGlQiJ6uiGLdrkX7l/PNzO4WYvjMyzBQ8Eh5bp/5KecW+kKzti8Wn6Kuvspny6kWFVlL9nhQ /HgA=
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912090051.4014114-22-ardb@google.com>
Subject: [PATCH v2 05/15] x86/boot: Omit compression buffer from PE/COFF image
 memory footprint
From:   Ard Biesheuvel <ardb@google.com>
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
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

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
index b24fa50a9898..a87d9133384b 100644
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
index bd247692b701..0354c223e354 100644
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
2.42.0.283.g2d96d420d3-goog

