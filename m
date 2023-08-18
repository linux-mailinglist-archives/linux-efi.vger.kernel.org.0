Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB4B780CCF
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 15:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377327AbjHRNqH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 09:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377418AbjHRNps (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 09:45:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8956444B3;
        Fri, 18 Aug 2023 06:45:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16C2061977;
        Fri, 18 Aug 2023 13:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AEBC433C9;
        Fri, 18 Aug 2023 13:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692366337;
        bh=INeT2bz+nsdJxKnWRpvYL1tZqsSn+67UUbdpodL5gq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Df1bGc7/pEqADP1AFPZV2kyi2uNH1D2ddiCKnOvfHxC3cyy1tModjJ69e0cDCVLyz
         FB6kxPOwvGdngHUpPa6XEMwFC3lQgnJZGFqV/fifVb1MpK/xqGz1AVYXtDIrnC95EC
         KdSSj7vv7l6qdvINo5b7IzlWF9ZoC3VXd1qJCVFGGTpQ02pQBOjZPvDAF8dhMz5El0
         xWpfzJG70ySDS7a4rWuStsDQR32Qxxyq1ZTdzucXhqnIAINF6q9DecnGnVpVx0Nb7C
         qXfo7Zop8CAOHupJurBXpAFj9/5/CH7p7RsNt/6+EI+NOWY5BdSlZI3XyobV1qs1gU
         M5Q7b06xEOU+Q==
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
Subject: [PATCH 17/17] x86/boot: Drop CRC-32 checksum and the build tool that generates it
Date:   Fri, 18 Aug 2023 15:44:22 +0200
Message-Id: <20230818134422.380032-18-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818134422.380032-1-ardb@kernel.org>
References: <20230818134422.380032-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12032; i=ardb@kernel.org; h=from:subject; bh=INeT2bz+nsdJxKnWRpvYL1tZqsSn+67UUbdpodL5gq0=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV+6WbOHvm1rbETljfdXsEZVndNozHuYsCDlX6ntPO13 12cefhzRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIzm5Ghp+FwkXzYnZsq81Y X8fI2R6oVLl44q2+4ysXZFckMOu9aGdk+J6gcVKlziDdbGWJ9fWQL1lHBafx1+7zq207J6HWutm fAQA=
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

The only remaining task carried out by the boot/tools/build.c build tool
is generating the CRC-32 checksum of the bzImage. This feature was added
in commit

  7d6e737c8d2698b6 ("x86: add a crc32 checksum to the kernel image.")

without any motivation (or any commit log text, for that matter). This
checksum is not verified by any known bootloader, and given that

a) the checksum of the entire bzImage is reported by most tools (zlib,
   rhash) as 0xffffffff and not 0x0 as documented,
b) the checksum is corrupted when the image is signed for secure boot,
   which means that no distro ships x86 images with valid CRCs,

it seems quite unlikely that this checksum is being used, so let's just
drop it, along with the tool that generates it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Documentation/arch/x86/boot.rst        |  10 -
 arch/x86/boot/Makefile                 |   8 +-
 arch/x86/boot/compressed/vmlinux.lds.S |   3 +-
 arch/x86/boot/tools/.gitignore         |   2 -
 arch/x86/boot/tools/build.c            | 245 --------------------
 5 files changed, 4 insertions(+), 264 deletions(-)

diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
index cdbca15a4fc23833..bdcd2bebb2fe10be 100644
--- a/Documentation/arch/x86/boot.rst
+++ b/Documentation/arch/x86/boot.rst
@@ -1028,16 +1028,6 @@ Offset/size:	0x000c/4
   This field contains maximal allowed type for setup_data and setup_indirect structs.
 
 
-The Image Checksum
-==================
-
-From boot protocol version 2.08 onwards the CRC-32 is calculated over
-the entire file using the characteristic polynomial 0x04C11DB7 and an
-initial remainder of 0xffffffff.  The checksum is appended to the
-file; therefore the CRC of the file up to the limit specified in the
-syssize field of the header is always 0.
-
-
 The Kernel Command Line
 =======================
 
diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 18548e351ffb4867..51f70500d38a10ae 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -48,7 +48,6 @@ setup-y		+= video-vesa.o
 setup-y		+= video-bios.o
 
 targets		+= $(setup-y)
-hostprogs	:= tools/build
 hostprogs	+= mkcpustr
 
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include \
@@ -77,11 +76,10 @@ UBSAN_SANITIZE := n
 $(obj)/bzImage: asflags-y  := $(SVGA_MODE)
 
 quiet_cmd_image = BUILD   $@
-silent_redirect_image = >/dev/null
-cmd_image = $(obj)/tools/build $(obj)/setup.bin $(obj)/vmlinux.bin \
-			       $(obj)/zoffset.h $@ $($(quiet)redirect_image)
+      cmd_image = truncate -s %4K $(obj)/setup.bin; \
+		  cat $(obj)/setup.bin $(obj)/vmlinux.bin >$@
 
-$(obj)/bzImage: $(obj)/setup.bin $(obj)/vmlinux.bin $(obj)/tools/build FORCE
+$(obj)/bzImage: $(obj)/setup.bin $(obj)/vmlinux.bin FORCE
 	$(call if_changed,image)
 	@$(kecho) 'Kernel: $@ is ready' ' (#'$(or $(KBUILD_BUILD_VERSION),`cat .version`)')'
 
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 3df57cdf500375f2..48d0b51845571e7e 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -48,8 +48,7 @@ SECTIONS
 		*(.data)
 		*(.data.*)
 
-		/* add 4 bytes of extra space for a CRC-32 checksum */
-		. = ALIGN(. + 4, 0x200);
+		. = ALIGN(0x200);
 		_edata = . ;
 	}
 	. = ALIGN(L1_CACHE_BYTES);
diff --git a/arch/x86/boot/tools/.gitignore b/arch/x86/boot/tools/.gitignore
deleted file mode 100644
index ae91f4d0d78b56af..0000000000000000
--- a/arch/x86/boot/tools/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-build
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
deleted file mode 100644
index bc2585df100572bc..0000000000000000
--- a/arch/x86/boot/tools/build.c
+++ /dev/null
@@ -1,245 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  Copyright (C) 1991, 1992  Linus Torvalds
- *  Copyright (C) 1997 Martin Mares
- *  Copyright (C) 2007 H. Peter Anvin
- */
-
-/*
- * This file builds a disk-image from three different files:
- *
- * - setup: 8086 machine code, sets up system parm
- * - system: 80386 code for actual system
- * - zoffset.h: header with ZO_* defines
- *
- * It does some checking that all files are of the correct type, and writes
- * the result to the specified destination, removing headers and padding to
- * the right amount. It also writes some system data to stdout.
- */
-
-/*
- * Changes by tytso to allow root device specification
- * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
- * Cross compiling fixes by Gertjan van Wingerde, July 1996
- * Rewritten by Martin Mares, April 1997
- * Substantially overhauled by H. Peter Anvin, April 2007
- */
-
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-#include <stdarg.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <sys/mman.h>
-#include <tools/le_byteshift.h>
-
-typedef unsigned char  u8;
-typedef unsigned short u16;
-typedef unsigned int   u32;
-
-#define SETUP_SECT_NUM 32
-
-/* This must be large enough to hold the entire setup */
-u8 buf[(SETUP_SECT_NUM+1)*512];
-
-static unsigned long _edata;
-
-/*----------------------------------------------------------------------*/
-
-static const u32 crctab32[] = {
-	0x00000000, 0x77073096, 0xee0e612c, 0x990951ba, 0x076dc419,
-	0x706af48f, 0xe963a535, 0x9e6495a3, 0x0edb8832, 0x79dcb8a4,
-	0xe0d5e91e, 0x97d2d988, 0x09b64c2b, 0x7eb17cbd, 0xe7b82d07,
-	0x90bf1d91, 0x1db71064, 0x6ab020f2, 0xf3b97148, 0x84be41de,
-	0x1adad47d, 0x6ddde4eb, 0xf4d4b551, 0x83d385c7, 0x136c9856,
-	0x646ba8c0, 0xfd62f97a, 0x8a65c9ec, 0x14015c4f, 0x63066cd9,
-	0xfa0f3d63, 0x8d080df5, 0x3b6e20c8, 0x4c69105e, 0xd56041e4,
-	0xa2677172, 0x3c03e4d1, 0x4b04d447, 0xd20d85fd, 0xa50ab56b,
-	0x35b5a8fa, 0x42b2986c, 0xdbbbc9d6, 0xacbcf940, 0x32d86ce3,
-	0x45df5c75, 0xdcd60dcf, 0xabd13d59, 0x26d930ac, 0x51de003a,
-	0xc8d75180, 0xbfd06116, 0x21b4f4b5, 0x56b3c423, 0xcfba9599,
-	0xb8bda50f, 0x2802b89e, 0x5f058808, 0xc60cd9b2, 0xb10be924,
-	0x2f6f7c87, 0x58684c11, 0xc1611dab, 0xb6662d3d, 0x76dc4190,
-	0x01db7106, 0x98d220bc, 0xefd5102a, 0x71b18589, 0x06b6b51f,
-	0x9fbfe4a5, 0xe8b8d433, 0x7807c9a2, 0x0f00f934, 0x9609a88e,
-	0xe10e9818, 0x7f6a0dbb, 0x086d3d2d, 0x91646c97, 0xe6635c01,
-	0x6b6b51f4, 0x1c6c6162, 0x856530d8, 0xf262004e, 0x6c0695ed,
-	0x1b01a57b, 0x8208f4c1, 0xf50fc457, 0x65b0d9c6, 0x12b7e950,
-	0x8bbeb8ea, 0xfcb9887c, 0x62dd1ddf, 0x15da2d49, 0x8cd37cf3,
-	0xfbd44c65, 0x4db26158, 0x3ab551ce, 0xa3bc0074, 0xd4bb30e2,
-	0x4adfa541, 0x3dd895d7, 0xa4d1c46d, 0xd3d6f4fb, 0x4369e96a,
-	0x346ed9fc, 0xad678846, 0xda60b8d0, 0x44042d73, 0x33031de5,
-	0xaa0a4c5f, 0xdd0d7cc9, 0x5005713c, 0x270241aa, 0xbe0b1010,
-	0xc90c2086, 0x5768b525, 0x206f85b3, 0xb966d409, 0xce61e49f,
-	0x5edef90e, 0x29d9c998, 0xb0d09822, 0xc7d7a8b4, 0x59b33d17,
-	0x2eb40d81, 0xb7bd5c3b, 0xc0ba6cad, 0xedb88320, 0x9abfb3b6,
-	0x03b6e20c, 0x74b1d29a, 0xead54739, 0x9dd277af, 0x04db2615,
-	0x73dc1683, 0xe3630b12, 0x94643b84, 0x0d6d6a3e, 0x7a6a5aa8,
-	0xe40ecf0b, 0x9309ff9d, 0x0a00ae27, 0x7d079eb1, 0xf00f9344,
-	0x8708a3d2, 0x1e01f268, 0x6906c2fe, 0xf762575d, 0x806567cb,
-	0x196c3671, 0x6e6b06e7, 0xfed41b76, 0x89d32be0, 0x10da7a5a,
-	0x67dd4acc, 0xf9b9df6f, 0x8ebeeff9, 0x17b7be43, 0x60b08ed5,
-	0xd6d6a3e8, 0xa1d1937e, 0x38d8c2c4, 0x4fdff252, 0xd1bb67f1,
-	0xa6bc5767, 0x3fb506dd, 0x48b2364b, 0xd80d2bda, 0xaf0a1b4c,
-	0x36034af6, 0x41047a60, 0xdf60efc3, 0xa867df55, 0x316e8eef,
-	0x4669be79, 0xcb61b38c, 0xbc66831a, 0x256fd2a0, 0x5268e236,
-	0xcc0c7795, 0xbb0b4703, 0x220216b9, 0x5505262f, 0xc5ba3bbe,
-	0xb2bd0b28, 0x2bb45a92, 0x5cb36a04, 0xc2d7ffa7, 0xb5d0cf31,
-	0x2cd99e8b, 0x5bdeae1d, 0x9b64c2b0, 0xec63f226, 0x756aa39c,
-	0x026d930a, 0x9c0906a9, 0xeb0e363f, 0x72076785, 0x05005713,
-	0x95bf4a82, 0xe2b87a14, 0x7bb12bae, 0x0cb61b38, 0x92d28e9b,
-	0xe5d5be0d, 0x7cdcefb7, 0x0bdbdf21, 0x86d3d2d4, 0xf1d4e242,
-	0x68ddb3f8, 0x1fda836e, 0x81be16cd, 0xf6b9265b, 0x6fb077e1,
-	0x18b74777, 0x88085ae6, 0xff0f6a70, 0x66063bca, 0x11010b5c,
-	0x8f659eff, 0xf862ae69, 0x616bffd3, 0x166ccf45, 0xa00ae278,
-	0xd70dd2ee, 0x4e048354, 0x3903b3c2, 0xa7672661, 0xd06016f7,
-	0x4969474d, 0x3e6e77db, 0xaed16a4a, 0xd9d65adc, 0x40df0b66,
-	0x37d83bf0, 0xa9bcae53, 0xdebb9ec5, 0x47b2cf7f, 0x30b5ffe9,
-	0xbdbdf21c, 0xcabac28a, 0x53b39330, 0x24b4a3a6, 0xbad03605,
-	0xcdd70693, 0x54de5729, 0x23d967bf, 0xb3667a2e, 0xc4614ab8,
-	0x5d681b02, 0x2a6f2b94, 0xb40bbe37, 0xc30c8ea1, 0x5a05df1b,
-	0x2d02ef8d
-};
-
-static u32 partial_crc32_one(u8 c, u32 crc)
-{
-	return crctab32[(crc ^ c) & 0xff] ^ (crc >> 8);
-}
-
-static u32 partial_crc32(const u8 *s, int len, u32 crc)
-{
-	while (len--)
-		crc = partial_crc32_one(*s++, crc);
-	return crc;
-}
-
-static void die(const char * str, ...)
-{
-	va_list args;
-	va_start(args, str);
-	vfprintf(stderr, str, args);
-	va_end(args);
-	fputc('\n', stderr);
-	exit(1);
-}
-
-static void usage(void)
-{
-	die("Usage: build setup system zoffset.h image");
-}
-
-/*
- * Parse zoffset.h and find the entry points. We could just #include zoffset.h
- * but that would mean tools/build would have to be rebuilt every time. It's
- * not as if parsing it is hard...
- */
-#define PARSE_ZOFS(p, sym) do { \
-	if (!strncmp(p, "#define ZO_" #sym " ", 11+sizeof(#sym)))	\
-		sym = strtoul(p + 11 + sizeof(#sym), NULL, 16);		\
-} while (0)
-
-static void parse_zoffset(char *fname)
-{
-	FILE *file;
-	char *p;
-	int c;
-
-	file = fopen(fname, "r");
-	if (!file)
-		die("Unable to open `%s': %m", fname);
-	c = fread(buf, 1, sizeof(buf) - 1, file);
-	if (ferror(file))
-		die("read-error on `zoffset.h'");
-	fclose(file);
-	buf[c] = 0;
-
-	p = (char *)buf;
-
-	while (p && *p) {
-		PARSE_ZOFS(p, _edata);
-
-		p = strchr(p, '\n');
-		while (p && (*p == '\r' || *p == '\n'))
-			p++;
-	}
-}
-
-int main(int argc, char ** argv)
-{
-	unsigned int i, sz, setup_sectors;
-	int c;
-	struct stat sb;
-	FILE *file, *dest;
-	int fd;
-	void *kernel;
-	u32 crc = 0xffffffffUL;
-
-	if (argc != 5)
-		usage();
-	parse_zoffset(argv[3]);
-
-	dest = fopen(argv[4], "w");
-	if (!dest)
-		die("Unable to write `%s': %m", argv[4]);
-
-	/* Copy the setup code */
-	file = fopen(argv[1], "r");
-	if (!file)
-		die("Unable to open `%s': %m", argv[1]);
-	c = fread(buf, 1, sizeof(buf), file);
-	if (ferror(file))
-		die("read-error on `setup'");
-	if (c < 1024)
-		die("The setup must be at least 1024 bytes");
-	if (get_unaligned_le16(&buf[510]) != 0xAA55)
-		die("Boot block hasn't got boot flag (0xAA55)");
-	fclose(file);
-
-	/* Pad unused space with zeros */
-	setup_sectors = (c + 511) / 512;
-	if (setup_sectors > SETUP_SECT_NUM)
-		die("setup size exceeds maximum");
-	setup_sectors = SETUP_SECT_NUM;
-	i = setup_sectors*512;
-	memset(buf+c, 0, i-c);
-
-	/* Open and stat the kernel file */
-	fd = open(argv[2], O_RDONLY);
-	if (fd < 0)
-		die("Unable to open `%s': %m", argv[2]);
-	if (fstat(fd, &sb))
-		die("Unable to stat `%s': %m", argv[2]);
-	if (_edata != sb.st_size)
-		die("Unexpected file size `%s': %u != %u", argv[2], _edata,
-		    sb.st_size);
-	sz = _edata - 4;
-	kernel = mmap(NULL, sz, PROT_READ, MAP_SHARED, fd, 0);
-	if (kernel == MAP_FAILED)
-		die("Unable to mmap '%s': %m", argv[2]);
-
-	crc = partial_crc32(buf, i, crc);
-	if (fwrite(buf, 1, i, dest) != i)
-		die("Writing setup failed");
-
-	/* Copy the kernel code */
-	crc = partial_crc32(kernel, sz, crc);
-	if (fwrite(kernel, 1, sz, dest) != sz)
-		die("Writing kernel failed");
-
-	/* Write the CRC */
-	put_unaligned_le32(crc, buf);
-	if (fwrite(buf, 1, 4, dest) != 4)
-		die("Writing CRC failed");
-
-	/* Catch any delayed write failures */
-	if (fclose(dest))
-		die("Writing image failed");
-
-	close(fd);
-
-	/* Everything is OK */
-	return 0;
-}
-- 
2.39.2

