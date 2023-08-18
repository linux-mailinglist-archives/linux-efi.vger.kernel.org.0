Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E26780CC6
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 15:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377275AbjHRNpX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 09:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377289AbjHRNo5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 09:44:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5A33C2F;
        Fri, 18 Aug 2023 06:44:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E1B966DF3;
        Fri, 18 Aug 2023 13:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036D1C433C8;
        Fri, 18 Aug 2023 13:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692366294;
        bh=7AgmzUMEbQ4q0yWpLInOQxXscQWeFd85vyZx1/xzwk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C0CB4lSRoUdKRQc1mqOdIZLJwdcCx/fBMjF813KLDJneWPNDkTDMPnx5HJH5j7Kkw
         JVRmTD3FpRiIXcyTu0hKouFR4M9YdDFGDqPkcseZk4/VZkAJT4YwIZPrf3Er3I84Oh
         +DPPdstkV12Ym8PGAM1QzP4ajIhRSahGSHQ5pxuM9OUmiBxveWMDHbaivyg7FEnraO
         R451STsbKBKupthOluGN8TqVCUS3F2h/8y2K2b+ouhGHV0U8valqscuWLaj15C7iEh
         AGv3+rKMSpi0HJ3mB++RioNF0Mq/l1OflH8huN/H++djHKEnWrta6CE7vAb+8dtQLm
         W6lBZWo9B8oEA==
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
Subject: [PATCH 04/17] x86/boot: Remove the 'bugger off' message
Date:   Fri, 18 Aug 2023 15:44:09 +0200
Message-Id: <20230818134422.380032-5-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818134422.380032-1-ardb@kernel.org>
References: <20230818134422.380032-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2992; i=ardb@kernel.org; h=from:subject; bh=7AgmzUMEbQ4q0yWpLInOQxXscQWeFd85vyZx1/xzwk4=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV+6Tzz+5EtxvJ5KyctFXv7Yp3ej++sWpVTpi1sv/F76 mt/JvatHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAi6rIM/2yvtK18c6+zx+D5 rOlc6tmr1BM3/88JP90fpxP1c4kWy1qGfzqH7zHyzIst//ytTn7BVfPpqt+MFt5dfet5kBzLzW9 mkqwA
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

Ancient (pre-2003) x86 kernels could boot from a floppy disk straight from
the BIOS, using a small real mode boot stub at the start of the image
where the BIOS would expect the boot record (or boot block) to appear.

Due to its limitations (kernel size < 1 MiB, no support for IDE, USB or
El Torito floppy emulation), this support was dropped, and a Linux aware
bootloader is now always required to boot the kernel from a legacy BIOS.

To smoothen this transition, the boot stub was not removed entirely, but
replaced with one that just prints an error message telling the user to
install a bootloader.

As it is unlikely that anyone doing direct floppy boot with such an
ancient kernel is going to upgrade to v6.5+ and expect that this boot
method still works, printing this message is kind of pointless, and so
it should be possible to remove the logic that emits it.

Let's free up this space so it can be used to expand the PE header in a
subsequent patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S | 49 --------------------
 arch/x86/boot/setup.ld |  7 +--
 2 files changed, 4 insertions(+), 52 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 8c8148d751c6d22b..b24fa50a98986945 100644
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
index 49546c247ae25e97..b11c45b9e51ed90e 100644
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
+	} =0xffffffff
 
-	. = 495;
 	.header		: { *(.header) }
 	.entrytext	: { *(.entrytext) }
 	.inittext	: { *(.inittext) }
-- 
2.39.2

