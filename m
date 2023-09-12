Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9F179CAF8
	for <lists+linux-efi@lfdr.de>; Tue, 12 Sep 2023 11:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbjILJC4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Sep 2023 05:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjILJB5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Sep 2023 05:01:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E7A1706
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 02:01:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b5a586da6so72362607b3.1
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 02:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694509313; x=1695114113; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VKh367hgmQvZD8a+n/+xOMhd8K9Jz3TJJTXcd9sGb+U=;
        b=ou8mb1n8R8OfOF8DpWyJTPJjPaHy9UxdkmUcIvkT+Txd5BeGnOBv9fWe3XzLcyHJy8
         gZL3Z9u7ZTCcvm3oARPD/dmE6P3ubLa986xCYhfHRQSA8IWHVQkiWZ8tsGdMyAONI+71
         jTLbBUrXPEPlkV4g7xZ/uueK9l5SE8DGM0+0kH0/f8YB35X+XTgiSxV4DbnbsyC8wmAT
         V+1ZrzkgoD8zyXZIX4l0CTq9M6VBokzPrlXwnwkwiJEZacVu67CQaLRaoXwdYIwE2bZ8
         XfjCzKxi4tNcd/2VcwvyOozrLfa+0lApg2nFLMsn6Dc3RX1pGne3v940Y3UrD6MR8Ddp
         n4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509313; x=1695114113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VKh367hgmQvZD8a+n/+xOMhd8K9Jz3TJJTXcd9sGb+U=;
        b=MmP39pwhxLQ5xS2eHhWfxbRCqMwufrXOWCvMsgg7ZSxNAw9AMmUbnBdfdV5IHrDlIx
         Wf39uzMUoJLZF7StIdzCNb3AAqBcyyf4rqFW9nKSMHJQVn6hfPzIWO71rJvnVVnhm1sa
         4ihHElptcQFCxJNfJ1eNJ3Qm8T2OiTULdLRvA4C4OOCedtgsZyGSlJU5mmKJ24epmrvE
         JsGDf6cCjZiRunB0HusyEXo1iYDZdHHP7zWRiVqemhkrhTYYxZJFAahq6Ozh5/tgXODn
         FXW/mXDkadWbjViA4SCTCYqnaCyDsI7tiYreEWOqZz+C018CQah0KOThUFuaCJ23yxhC
         ozkQ==
X-Gm-Message-State: AOJu0Yzv6jpQ5K+Qv+zERNjttDPnEBHETitSmNbcIiBtfqHMI8NHn7Gg
        3qEMfuyALCsedqbV8b5KuCj9r19b21CqrZBcnvFRQSIEswFDL0ceR/4C3Jv71DxSZ9vwWYsMBu9
        E5LQjDaLONaN4wTodCO64unIlGsnRUmp9KxZ2ibHHsGG4vkicSJ5EZAg2iFLc
X-Google-Smtp-Source: AGHT+IHwI0wHd6qPiDSN8OHNFljMj0VCSDsMSABYq2GJME5mvkxJkGZ0iTOYF3Z8sPZrkQJa2D9Zqzef
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a81:c40e:0:b0:58c:e8da:4d1a with SMTP id
 j14-20020a81c40e000000b0058ce8da4d1amr61791ywi.2.1694509312588; Tue, 12 Sep
 2023 02:01:52 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:01:02 +0000
In-Reply-To: <20230912090051.4014114-17-ardb@google.com>
Mime-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5004; i=ardb@kernel.org;
 h=from:subject; bh=+O/KFdhMJMnIogIj3fdlcqOX6X2/aP+6Tar/b+0W/54=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVB46KSnd5N17n3tPfuFGZf7fRs36pVBsa7Eq2S0g/P+
 CX8UUago5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzkMhsjw31Ws41CYrt4tKQu
 CtRPdEjfxbx39gx7q1VFOqk5cwwecjEynOTWYdZWnFDndK35rH7PrlXXbmoodPnF+fOzxdjxrsx kAgA=
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912090051.4014114-28-ardb@google.com>
Subject: [PATCH v2 11/15] x86/boot: Derive file size from _edata symbol
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
index 4ff6ab1b67d9..5326f3b44194 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -47,6 +47,9 @@ SECTIONS
 		_data = . ;
 		*(.data)
 		*(.data.*)
+
+		/* add 4 bytes of extra space for a CRC-32 checksum */
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
2.42.0.283.g2d96d420d3-goog

