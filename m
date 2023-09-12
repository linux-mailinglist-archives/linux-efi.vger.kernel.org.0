Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD29C79CAE5
	for <lists+linux-efi@lfdr.de>; Tue, 12 Sep 2023 11:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjILJCQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Sep 2023 05:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbjILJBj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Sep 2023 05:01:39 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0226E10EB
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 02:01:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58fc7afa4beso63289427b3.2
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 02:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694509295; x=1695114095; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U9NX1eydLNVgshySZmGjlq5b77lgR7szWd7VFgL+D3U=;
        b=C0xPLuufuvl7kiWJRzV3g+tm2SoPvFQh/KPjCEK+pHQGsnBwa7MiOcpYAndaj6NozO
         jMzGALPMLhL6Y3t5zqj1aCnNhrh4w7QMh+Zimza6f8E5rg+IF8WOLVrxFazXT8P5YV2/
         5smX4Par+98w1Oyp90elBxJ5vYYXrBdsFtaEtTMjmPVJcZfWJnHFiYw48S6ZvynPL2Fh
         r8RtOX7Iwvr/8GU1yzsv2Bllv9pSTsJIkMqNpW6DkglK9XkZy9HDnXzWaeWsg+TehOa2
         Kn26O8/Z6pDuI8R5bf8RVfza47vqFlaHTzjUxdVAAwvFEl0YO3MydhLS0QCk8Hw4PILz
         lVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509295; x=1695114095;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9NX1eydLNVgshySZmGjlq5b77lgR7szWd7VFgL+D3U=;
        b=T5NCKL8mmTfmFOeBWqYySmBzgWC6fA+dBwnFr6hpn6IG+GZyhYoFGIVtgMBtIVhKS3
         U3/ognckJLOQSgIdH4eP6gVWDV+kID4sX2P2kdib3LAX1JOXHlBpw0wK1lZtdvgCY/1x
         STtnXlYj56jWZg77P/eiIBbJnTiDalgfe4jTWpIw8wza5DbeV/U2GOH1DBawljOt68ji
         hEFXFwXFoBLckrjiKcG9ZqdQuVMrIE64DzLtn+IPsEVDRxhif8s3d8R+abJZlahj6fQ5
         c1AZy9yt7uBpntNuoeCYjoT2N/5OCwypqACUyfhLLVCjMZBXmL1TXaqhk6ZXdgXyDZS3
         0BAQ==
X-Gm-Message-State: AOJu0YyRkD/JEpDRcLM3e8Ilo9Fbuzy1dAT0RxOE3bImtMOtMrDNbcS0
        kj0OFKjzC/Grlv6E3dETO1PgakcY4du4ECNorGF8cOTB5sLBAdOmPNWYBURTXnO78YqW3lqNQ+d
        Tq++6G4Jl6JmpAQFkFMpihb0JLrA3wdQ16UXmXwbmnK0yCwHnlmVBc44R8w8w
X-Google-Smtp-Source: AGHT+IEnERJWZjy5mzckGIkwIDZUhD120pg3gqwSReHPT0G1jRnLKEsjoPrumVHoHlPZ1296s7AtPZYr
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a25:bb88:0:b0:d7b:8acc:beb8 with SMTP id
 y8-20020a25bb88000000b00d7b8accbeb8mr283729ybg.2.1694509294977; Tue, 12 Sep
 2023 02:01:34 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:00:55 +0000
In-Reply-To: <20230912090051.4014114-17-ardb@google.com>
Mime-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3047; i=ardb@kernel.org;
 h=from:subject; bh=C3Y0JXoFsDu7p0NCuFXkHN3nsg72k1sfp0MTO1muukQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVB40ToruN3lO8c3lF80q2mY/G0N02PllxzCJiv0bv5X
 +iFLx9ed5SyMIhxMMiKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJzPFl+Gfy0+pN1D1OT3vG
 pI1rZ3gpH1fYGxL8aPp8nYvCHivOvFnH8E/9oP+PaWwn7OKPfm96br+6X4FD6Yvq1Jl6nG/nlC6 crMwBAA==
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912090051.4014114-21-ardb@google.com>
Subject: [PATCH v2 04/15] x86/boot: Remove the 'bugger off' message
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

Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S | 49 --------------------
 arch/x86/boot/setup.ld |  7 +--
 2 files changed, 4 insertions(+), 52 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 8c8148d751c6..b24fa50a9898 100644
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
index 49546c247ae2..b11c45b9e51e 100644
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
2.42.0.283.g2d96d420d3-goog

