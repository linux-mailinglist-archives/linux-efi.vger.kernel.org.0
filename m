Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54B859301D
	for <lists+linux-efi@lfdr.de>; Mon, 15 Aug 2022 15:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiHONmg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Aug 2022 09:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbiHONmg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Aug 2022 09:42:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA3C13E8D;
        Mon, 15 Aug 2022 06:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A44E60EEA;
        Mon, 15 Aug 2022 13:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CBDC4347C;
        Mon, 15 Aug 2022 13:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660570954;
        bh=ihsoHw6swMHBcNjKbyZ/awdMFSUepCqZnSAEI50Meig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s3Qgne5tMHtSYVZIfOSWj4TY9OrPPsIF5MoQbfD8INVfCiqbQ0b5T+Q6lS8wHmQB7
         mtQC0AlFY0xn/oYeE3qgtgxOC55QnWe0mQMObc7PleL9DqbD2mnvVwmtRB6yryHGws
         1Hm4K/NLG0kD6MKTIO02rDJ18ngEJ/Dyo8wtgLJ/SGoAOx5j1JyzVJpJiuMMrFDlXx
         Hyp4G39EsNtBbthgesNM9p5sNNq/Ba+QGGOY/EGUkI2HsA4rL8LQijgnjb9MRXM38d
         4h6OnxHfDelpNyGWME4zA2H4Io7+jnxbT+uSRc29YlsPNo5yFfdISKuuaI8OK5NwmJ
         FC5tD9hLrB+Xg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH 2/6] efi/x86: simplify IDT/GDT preserve/restore
Date:   Mon, 15 Aug 2022 15:42:19 +0200
Message-Id: <20220815134223.740112-3-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815134223.740112-1-ardb@kernel.org>
References: <20220815134223.740112-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1667; i=ardb@kernel.org; h=from:subject; bh=ihsoHw6swMHBcNjKbyZ/awdMFSUepCqZnSAEI50Meig=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi+k00ml/9VAQVR9pgiopOTiemTPgJVpwdMjY3KsGG 3S+k64GJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYvpNNAAKCRDDTyI5ktmPJOU2C/ 91l5W5RmN4Cm1/0M/iQwd4tn4wFfqVvBHRDsHkMdCNV3iaqlvdoQ91nQ3iflP8hy8Q6IilQ5s6mYPa DkvmTpnt6vvpSYV3YvGjSiywMAM9swZtcO6LAMvn220ktZ1zPZ9+Ywyj7KsfqbIdVuJ5+XYYpg1muW x8RkpM3+DWFSoulH5hqpB4Bk2gZyT1Zli+5Vviy2jpVG7m9V7Ag8Yc6XnOXo8TB0jFLadcmrf2TlG2 RvRkR+5PSasKbIIB3prAGU/kbX5EOqpg0NzRixJFNoKeXWlrLuJN+q2mgiRsZodp3XfeenqJenOL77 wvZ3eiBdjfAYONq6ZThF+lveF8362moZzhKQqjuhw9GJkt7Ra+3oyMWKRK/ranmqp4rjeWYsF2M1y3 Owr4nGM7zv91D0FdsBspjKWw+Cgf5BIbRUs36COp7znGBPc391YL8bjIL7t7/edJ4QgF9+THuVChbJ Ukrbw0oxW2Yuty/FJekpsqpWyLNPEypdK+bJWn5A4CeuA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Tweak the asm and remove some redundant instructions. While at it,
fix the associated comment for style and correctness.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 6fd7ac517c53..a0f217c8ab38 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -94,24 +94,20 @@ SYM_FUNC_START(__efi64_thunk)
 
 	leaq	0x20(%rsp), %rbx
 	sgdt	(%rbx)
-
-	addq	$16, %rbx
-	sidt	(%rbx)
+	sidt	16(%rbx)
 
 	leaq	1f(%rip), %rbp
 
 	/*
-	 * Switch to IDT and GDT with 32-bit segments. This is the firmware GDT
-	 * and IDT that was installed when the kernel started executing. The
-	 * pointers were saved at the efi32_stub_handover entry point below.
+	 * Switch to IDT and GDT with 32-bit segments. These are the firmware
+	 * GDT and IDT that were installed when the kernel started executing.
+	 * The pointers were saved at the efi32_entry entry point below.
 	 *
 	 * Pass the saved DS selector to the 32-bit code, and use far return to
 	 * restore the saved CS selector.
 	 */
-	leaq	efi32_boot_idt(%rip), %rax
-	lidt	(%rax)
-	leaq	efi32_boot_gdt(%rip), %rax
-	lgdt	(%rax)
+	lidt	efi32_boot_idt(%rip)
+	lgdt	efi32_boot_gdt(%rip)
 
 	movzwl	efi32_boot_ds(%rip), %edx
 	movzwq	efi32_boot_cs(%rip), %rax
@@ -185,9 +181,7 @@ SYM_FUNC_START_LOCAL(efi_enter32)
 	 */
 	cli
 
-	lidtl	(%ebx)
-	subl	$16, %ebx
-
+	lidtl	16(%ebx)
 	lgdtl	(%ebx)
 
 	movl	%cr4, %eax
-- 
2.35.1

