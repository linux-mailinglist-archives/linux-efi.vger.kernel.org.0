Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5FA780CDC
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 15:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377306AbjHRNp5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 09:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377311AbjHRNpc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 09:45:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B723590;
        Fri, 18 Aug 2023 06:45:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62B5D61977;
        Fri, 18 Aug 2023 13:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0744C433C8;
        Fri, 18 Aug 2023 13:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692366317;
        bh=U1EXI1fzEpmikIDVB6kaNJZr9EWOdxZEAwrcc4mhTpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B9CXjW7xm4GPt9Z3Gjyswa+vSpbINSA+YIBP+6fV8XFe4YJgPRZ7v02fpm8NmHszg
         ACubY0UzAHAtakw/q7oDtjMA7WIkKgiDxySMIjsURvXVUYYQAwFsIP1/H5HezByta0
         pmJpYv+QM7CCAACATMJTk9BnCMLI/hO5LGLhuWigMr3tdg80SevEtmmKLpDmkQfGpW
         aV99/eZiHpcT4C4/B/tvjswSu0hB09SXHJZoSDRn2jSUA6w8PBOmJ/SG6TJBxTsdbq
         QELtduhjdeo6kUBtS7qHpnPer2QB0SGje39saNCmOD4Z+u5iv3YF8YEZ2yT73k/+vs
         g7JN/g51Df/Tw==
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
Subject: [PATCH 11/17] x86/boot: Use fixed size of 16k for setup block
Date:   Fri, 18 Aug 2023 15:44:16 +0200
Message-Id: <20230818134422.380032-12-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818134422.380032-1-ardb@kernel.org>
References: <20230818134422.380032-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4435; i=ardb@kernel.org; h=from:subject; bh=U1EXI1fzEpmikIDVB6kaNJZr9EWOdxZEAwrcc4mhTpc=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV+6cqOpIkaCi5H2BZMWCXEI5SrEOvosyOk5oXnmvX2q dwa9sUdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCIGNgz/VDKV1yxKvnzrUOVX gaB1If/fmS5PF6mdfcB/7q5HbqKX3zMy7Fm2cMJe45szvNbINRV+WiFhaiTg2Vkz4dTZFYuju3N WcAAA
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

The setup block contains the real mode startup code that is used when
booting from a legacy BIOS, along with the boot_params/setup_data that
is used by legacy x86 bootloaders to pass the command line and initial
ramdisk parameters, among other things.

The setup block also contains the PE/COFF header of the entire combined
image, which includes the compressed kernel image, the decompressor and
the EFI stub.

This PE header describes the layout of the executable image in memory,
and currently, the fact that the setup block precedes it makes it rather
fiddly to get the right values into the right place in the final image.

One complicating factor here is the variable setup block size, and given
that we will need to round up the setup block size to page size anyway
in a subsequent patch (in order to be able to use different permissions
for .text and .data), let's round it up to a fixed size of 16 KiB and be
done with it.

Note that Clang does not optimize for size as aggressively as GCC when
using the -Os option, but it supports -Oz for this purpose, so pass that
if the compiler supports it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/Makefile      |  1 +
 arch/x86/boot/header.S      |  6 +++++-
 arch/x86/boot/setup.ld      |  1 +
 arch/x86/boot/tools/build.c | 12 +++++-------
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 0e98bc5036994715..be1e8b94c93afa4a 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -69,6 +69,7 @@ KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP
 KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
 KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
+KBUILD_CFLAGS	+= $(call cc-option,-Oz)
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n
 
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 72744ba440f6ea09..bef9265173757a5a 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -36,6 +36,10 @@ SYSSEG		= 0x1000		/* historical load address >> 4 */
 #define ROOT_RDONLY 1
 #endif
 
+	/* The setup block has a fixed size: 32 * 512 == 16k */
+	.globl	setup_size
+	.set	setup_size, 0x4000
+
 	.code16
 	.section ".bstext", "ax"
 #ifdef CONFIG_EFI_STUB
@@ -231,7 +235,7 @@ sentinel:	.byte 0xff, 0xff        /* Used to detect broken loaders */
 
 	.globl	hdr
 hdr:
-setup_sects:	.byte 0			/* Filled in by build.c */
+setup_sects:	.byte (setup_size / 512) - 1
 root_flags:	.word ROOT_RDONLY
 syssize:	.long 0			/* Filled in by build.c */
 ram_size:	.word 0			/* Obsolete */
diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index a05dcaa4b74cd9f8..f1c14616cd80390d 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -57,6 +57,7 @@ SECTIONS
 	}
 
 	ASSERT(_end <= 0x8000, "Setup too big!")
+	ASSERT(__bss_start <= setup_size, "Setup image size too big!")
 	ASSERT(hdr == 0x1f1, "The setup header has the wrong offset!")
 	/* Necessary for the very-old-loader check to work... */
 	ASSERT(__end_init <= 5*512, "init sections too big!")
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 06949754316458ce..665ce7241542e475 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -40,12 +40,10 @@ typedef unsigned char  u8;
 typedef unsigned short u16;
 typedef unsigned int   u32;
 
-/* Minimal number of setup sectors */
-#define SETUP_SECT_MIN 5
-#define SETUP_SECT_MAX 64
+#define SETUP_SECT_NUM 32
 
 /* This must be large enough to hold the entire setup */
-u8 buf[SETUP_SECT_MAX*512];
+u8 buf[(SETUP_SECT_NUM+1)*512];
 
 #define PECOFF_RELOC_RESERVE 0x20
 
@@ -360,8 +358,9 @@ int main(int argc, char ** argv)
 
 	/* Pad unused space with zeros */
 	setup_sectors = (c + 511) / 512;
-	if (setup_sectors < SETUP_SECT_MIN)
-		setup_sectors = SETUP_SECT_MIN;
+	if (setup_sectors > SETUP_SECT_NUM)
+		die("setup size exceeds maximum");
+	setup_sectors = SETUP_SECT_NUM;
 	i = setup_sectors*512;
 	memset(buf+c, 0, i-c);
 
@@ -388,7 +387,6 @@ int main(int argc, char ** argv)
 #endif
 
 	/* Patch the setup code with the appropriate size parameters */
-	buf[0x1f1] = setup_sectors-1;
 	put_unaligned_le32(sys_size, &buf[0x1f4]);
 
 	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16));
-- 
2.39.2

