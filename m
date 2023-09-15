Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C357A2473
	for <lists+linux-efi@lfdr.de>; Fri, 15 Sep 2023 19:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbjIORR0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Sep 2023 13:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbjIORRM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Sep 2023 13:17:12 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F64183
        for <linux-efi@vger.kernel.org>; Fri, 15 Sep 2023 10:17:07 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c240e637aso6578877b3.3
        for <linux-efi@vger.kernel.org>; Fri, 15 Sep 2023 10:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694798226; x=1695403026; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dns2e/ei4HJSlkg9p+qs7vYRajpuivxlD+SN4Zxl2pk=;
        b=pqpk2r9XYHF+apKjWTnl/WWsCOmsuUnMtJa/Na2vk6HgEx4DwaIzYZ/5YQvWFG+bQf
         tZ2Ogf+JRHstddgdgFrMNM0pC3ZwN7Jj+KPXEB8FDZijW6DnpmV1lLV66aaFHcmzCw/l
         nmM0lyh1Am4TqwjxFgYC3m4ejm8ZKT7JSBZhI68FjkXc2UBOQwoz6D72W7y7aIUt1J6b
         H1iRD2M7Z6RHUW6W/6UoVtG5beFy+g1l/ewqL9usGtjilh+ZqywszlHQoEjlIwcII/k1
         ZBnMXwjSe/ZldqPsOJnpT6EApQTdT/zxZPcfl/AlQde/fRpqBp5zYLX3+UrYxnOkY3vZ
         GVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694798226; x=1695403026;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dns2e/ei4HJSlkg9p+qs7vYRajpuivxlD+SN4Zxl2pk=;
        b=RHwIlwgQpKH5N/pmMTA1cHIkBJqfx/YjON1ORJd4w+a/0He8Ye3qDo5KM7KaaYpXAr
         eAq6SyEV9eMTMZTAs5C7+5QRbbtIy+mtHsdv8jNsoVgviDKaGUd3kSUu0mdXpLueBQ5g
         j7htlZGqK1n4i6X8VjjQ53aFiMXhOZ01ARlGKM+D7Dvb8dXgNppwulhi4sVLiry3P+O2
         cwaQ447ltaf2eJ60t/RrJjL922qWO+vwJclJCgdj5WqBbwLWRFuGhhalSZTGIBZ2q2IG
         FUEtH2UpV+NjlZn6+nwRo7oYpuaoJv0HjgSEeQKI4h6neF9RQuR5ns96Ehzs6ePPny+p
         l/ng==
X-Gm-Message-State: AOJu0YzdU/TYfzQria2IET0/jIfHK5WzvHGU0ptUEiA0HyNupm8ZT9Qj
        VP95RnmGdOyNghO7Fknt4tL0mudJO9fRocHDWych6564y45puG6Cg4vJKNBm/TaY8pb8T6KkjxZ
        DTXJ85Hsi2EeanThwGilLPPYr/6sj2R2JTEJE/g76pBzPByrpdC83GxUWBDwD
X-Google-Smtp-Source: AGHT+IHLYL8pZ9okrcG3wXehu9nmH1Z33BBwmEsvO4umKO/EgeDtMVmWiIqhuzTiuT2DYjHRN0TVE4Ud
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a81:ad41:0:b0:59b:ea96:8875 with SMTP id
 l1-20020a81ad41000000b0059bea968875mr54512ywk.2.1694798226304; Fri, 15 Sep
 2023 10:17:06 -0700 (PDT)
Date:   Fri, 15 Sep 2023 17:16:28 +0000
In-Reply-To: <20230915171623.655440-10-ardb@google.com>
Mime-Version: 1.0
References: <20230915171623.655440-10-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5004; i=ardb@kernel.org;
 h=from:subject; bh=el53dGhwvl4Ez0cZfyU3upsy6TEtXMx3UHruCwXxMPY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVlYo5J9+M7uWI7vxu/lDir/0upt0H11td3znGrynsqa
 sPurXDrKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNJ5GL4H3NT3Yk9tfppY83Z
 U9P6D+n0pX9eMrs6aV3TtP/X5h7e4szIsGWZyPTt1gVrQxTs1nLM3mshu2yH3E4Ro1/x06crve2 LYwEA
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915171623.655440-14-ardb@google.com>
Subject: [PATCH v3 4/8] x86/boot: Derive file size from _edata symbol
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

Tweak the linker script so that the value of _edata represents the
decompressor binary's file size rounded up to the appropriate alignment.
This removes the need to calculate it in the build tool, and will make
it easier to refer to the file size from the header directly in
subsequent changes to the PE header layout.

While adding _edata to the sed regex that parses the compressed
vmlinux's symbol list, tweak the regex a bit for conciseness.

This change has no impact on the resulting bzImage binary when
configured with CONFIG_EFI_STUB=y.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/Makefile                 |  2 +-
 arch/x86/boot/compressed/vmlinux.lds.S |  3 ++
 arch/x86/boot/header.S                 |  2 +-
 arch/x86/boot/tools/build.c            | 30 +++++---------------
 4 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 0e98bc503699..cc04917b1ac6 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -89,7 +89,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 
 SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
 
-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_edata\|z_.*\)$$/\#define ZO_\2 0x\1/p'
 
 quiet_cmd_zoffset = ZOFFSET $@
       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 4ff6ab1b67d9..b688598db28e 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -47,6 +47,9 @@ SECTIONS
 		_data = . ;
 		*(.data)
 		*(.data.*)
+
+		/* Add 4 bytes of extra space for a CRC-32 checksum */
+		. = ALIGN(. + 4, 0x20);
 		_edata = . ;
 	}
 	. = ALIGN(L1_CACHE_BYTES);
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 06bd72a324c1..34e9b35b827c 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -233,7 +233,7 @@ sentinel:	.byte 0xff, 0xff        /* Used to detect broken loaders */
 hdr:
 		.byte setup_sects - 1
 root_flags:	.word ROOT_RDONLY
-syssize:	.long 0			/* Filled in by build.c */
+syssize:	.long ZO__edata / 16
 ram_size:	.word 0			/* Obsolete */
 vid_mode:	.word SVGA_MODE
 root_dev:	.word 0			/* Default to major/minor 0/0 */
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 745d64b6d930..e792c6c5a634 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -52,6 +52,7 @@ u8 buf[SETUP_SECT_MAX*512];
 
 static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
+static unsigned long _edata;
 static unsigned long _end;
 
 /*----------------------------------------------------------------------*/
@@ -308,6 +309,7 @@ static void parse_zoffset(char *fname)
 	while (p && *p) {
 		PARSE_ZOFS(p, efi_pe_entry);
 		PARSE_ZOFS(p, efi32_pe_entry);
+		PARSE_ZOFS(p, _edata);
 		PARSE_ZOFS(p, _end);
 
 		p = strchr(p, '\n');
@@ -320,7 +322,6 @@ int main(int argc, char ** argv)
 {
 	unsigned int i, sz, setup_sectors;
 	int c;
-	u32 sys_size;
 	struct stat sb;
 	FILE *file, *dest;
 	int fd;
@@ -368,24 +369,14 @@ int main(int argc, char ** argv)
 		die("Unable to open `%s': %m", argv[2]);
 	if (fstat(fd, &sb))
 		die("Unable to stat `%s': %m", argv[2]);
-	sz = sb.st_size;
+	if (_edata != sb.st_size)
+		die("Unexpected file size `%s': %u != %u", argv[2], _edata,
+		    sb.st_size);
+	sz = _edata - 4;
 	kernel = mmap(NULL, sz, PROT_READ, MAP_SHARED, fd, 0);
 	if (kernel == MAP_FAILED)
 		die("Unable to mmap '%s': %m", argv[2]);
-	/* Number of 16-byte paragraphs, including space for a 4-byte CRC */
-	sys_size = (sz + 15 + 4) / 16;
-#ifdef CONFIG_EFI_STUB
-	/*
-	 * COFF requires minimum 32-byte alignment of sections, and
-	 * adding a signature is problematic without that alignment.
-	 */
-	sys_size = (sys_size + 1) & ~1;
-#endif
-
-	/* Patch the setup code with the appropriate size parameters */
-	put_unaligned_le32(sys_size, &buf[0x1f4]);
-
-	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16));
+	update_pecoff_text(setup_sectors * 512, i + _edata);
 
 
 	crc = partial_crc32(buf, i, crc);
@@ -397,13 +388,6 @@ int main(int argc, char ** argv)
 	if (fwrite(kernel, 1, sz, dest) != sz)
 		die("Writing kernel failed");
 
-	/* Add padding leaving 4 bytes for the checksum */
-	while (sz++ < (sys_size*16) - 4) {
-		crc = partial_crc32_one('\0', crc);
-		if (fwrite("\0", 1, 1, dest) != 1)
-			die("Writing padding failed");
-	}
-
 	/* Write the CRC */
 	put_unaligned_le32(crc, buf);
 	if (fwrite(buf, 1, 4, dest) != 4)
-- 
2.42.0.459.ge4e396fd5e-goog

