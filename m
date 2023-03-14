Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2C86B8F9E
	for <lists+linux-efi@lfdr.de>; Tue, 14 Mar 2023 11:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCNKUW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Mar 2023 06:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjCNKTp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Mar 2023 06:19:45 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59887F00A;
        Tue, 14 Mar 2023 03:19:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 3DBBE4076B53;
        Tue, 14 Mar 2023 10:18:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3DBBE4076B53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678789084;
        bh=j2kZQmzUqdi3zhtw0tkhtxK/VKJCq3JmQiY/uVoEKHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NpFrixFWG1iFqDpPLr7f263x9c1RhgWCRKZiOh99sBVmdfKSyHAgUpasPXp33Jw1X
         Z/zjd2Gy6Efx3eraPCF4Re9w6WSvcSuL7kKsiwWZF90iX7ZadfIQrwBUSQOzVOAOUf
         CR0qRWQABkxTAwmmQ/rXmqJFR+Fu5/gQ4shfpFHU=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
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
Subject: [PATCH v5 17/27] x86: decompressor: Remove the 'bugger off' message
Date:   Tue, 14 Mar 2023 13:13:44 +0300
Message-Id: <805cba4e05928d1ec9c661ac8a750a6c4871132c.1678785672.git.baskov@ispras.ru>
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

From: Ard Biesheuvel <ardb@kernel.org>

Ancient (pre-2003) x86 kernels could boot from a floppy disk straight from
the BIOS, using a small real mode boot stub at the start of the image
where the BIOS would expect the boot record (or boot block) to appear.

Due to its limitations (kernel size < 1 MiB, no support for IDE, USB or
El Torito floppy emulation), this support was dropped, and a Linux aware
bootloader is now always required to boot the kernel.

To smoothen this transition, the boot stub was not removed entirely, but
replaced with one that just prints an error message telling you to
install a bootloader.

As it is unlikely that anyone doing direct floppy boot with such an
ancient kernel is going to upgrade to v6.4+ and expect that this boot
method still works, printing this message is kind of pointless, and so
we should be able to remove the logic that emits it.

Let's free up this space so we can use it to expand the PE header in a
subsequent patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S | 49 ------------------------------------------
 arch/x86/boot/setup.ld |  7 +++---
 2 files changed, 4 insertions(+), 52 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 9338c68e7413..d4e16edf1198 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -38,64 +38,15 @@ SYSSEG		= 0x1000		/* historical load address >> 4 */
 
 	.code16
 	.section ".bstext", "ax"
-
-	.global bootsect_start
-bootsect_start:
 #ifdef CONFIG_EFI_STUB
 	# "MZ", MS-DOS header
 	.word	MZ_MAGIC
-#endif
-
-	# Normalize the start address
-	ljmp	$BOOTSEG, $start2
-
-start2:
-	movw	%cs, %ax
-	movw	%ax, %ds
-	movw	%ax, %es
-	movw	%ax, %ss
-	xorw	%sp, %sp
-	sti
-	cld
-
-	movw	$bugger_off_msg, %si
-
-msg_loop:
-	lodsb
-	andb	%al, %al
-	jz	bs_die
-	movb	$0xe, %ah
-	movw	$7, %bx
-	int	$0x10
-	jmp	msg_loop
-
-bs_die:
-	# Allow the user to press a key, then reboot
-	xorw	%ax, %ax
-	int	$0x16
-	int	$0x19
-
-	# int 0x19 should never return.  In case it does anyway,
-	# invoke the BIOS reset code...
-	ljmp	$0xf000,$0xfff0
-
-#ifdef CONFIG_EFI_STUB
 	.org	0x38
 	#
 	# Offset to the PE header.
 	#
 	.long	LINUX_PE_MAGIC
 	.long	pe_header
-#endif /* CONFIG_EFI_STUB */
-
-	.section ".bsdata", "a"
-bugger_off_msg:
-	.ascii	"Use a boot loader.\r\n"
-	.ascii	"\n"
-	.ascii	"Remove disk and press any key to reboot...\r\n"
-	.byte	0
-
-#ifdef CONFIG_EFI_STUB
 pe_header:
 	.long	PE_MAGIC
 
diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 49546c247ae2..31419b7c9c3f 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -10,10 +10,11 @@ ENTRY(_start)
 SECTIONS
 {
 	. = 0;
-	.bstext		: { *(.bstext) }
-	.bsdata		: { *(.bsdata) }
+	.bstext	: {
+		*(.bstext)
+		. = 495;
+	} =0xff
 
-	. = 495;
 	.header		: { *(.header) }
 	.entrytext	: { *(.entrytext) }
 	.inittext	: { *(.inittext) }
-- 
2.39.2

