Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066CA6340FB
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 17:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbiKVQLF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 11:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbiKVQKr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 11:10:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82DD73B9E;
        Tue, 22 Nov 2022 08:10:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5480D6178F;
        Tue, 22 Nov 2022 16:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF810C433D6;
        Tue, 22 Nov 2022 16:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669133441;
        bh=Ff5jCPG7xec1bYIqVhOuQrRSDrmeAGMIZG5Ihg2Q08o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uQ+tTtbAAF3gK1Z6QRv+7Rua8R7XrcZdrvKax7QpETrOgkP1VQlxLolXvht/ciO8O
         d+de/y8s3jBkTNAC13F/qQKQxm+QbyHXfSwWk0YIn3cDSkC//L5Rji0brkgNYn4e4E
         rpTPnuiEMdujYFmubTEaNXeamv7qe0L8fZt9YPIvcqrdjbu1BRkkWQzfW8v9YI0Oqp
         rkX/rU+toIj0kaSvENvVtvgBODb8DbqLkEexk2c3RTrPyIo50DDjj4CWesYeEzVKvi
         ufg3ZjWJRXAqKgGaS90MAijfmzwZhO2M89xSkmIqPtBVAQuUndSOwXioZlhfcICXll
         C2TH6rT1Zl8Ug==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v3 04/17] x86/compressed: efi-mixed: move efi32_pe_entry into .text section
Date:   Tue, 22 Nov 2022 17:10:04 +0100
Message-Id: <20221122161017.2426828-5-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221122161017.2426828-1-ardb@kernel.org>
References: <20221122161017.2426828-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2019; i=ardb@kernel.org; h=from:subject; bh=Ff5jCPG7xec1bYIqVhOuQrRSDrmeAGMIZG5Ihg2Q08o=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjfPRU1Ky0OuKT3C0YzcqKH54TQ0hcBdzSXviTD0O7 qRY21+aJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY3z0VAAKCRDDTyI5ktmPJAIKDA CjCnzWb+eCyL4Ncuo9hhAheTq2FnzM8m9qA7gAzdx5U8kOyllXOxNTzHBlEKOy3R9VBbrrMuMXO8iD /tL5oTNLSNF2G3jrz7f3broaBBy6YDICuj7a173PMQbObuhCavTAp+iTn7ktiPokRPhYSFBreNORHp lOdy48mVsL4blMjJ7JbjUBHoVt53G0j3GMg69PzfcYUk7dhTXJ5S+x+ik/kGVMlGi8kotybbZ/SQgD EuC7EXoRQKvFp3TO/K3J1DI9vFghLvg2CZaa9m3d8SfSk8NCOq75eRZN+49YQ19Gs/3ZgkU1t9E/xZ aVBXM7A6CQV7vmDrajWyEHwVhN6artR4sM9U5v18gzPLl3ZsyszB6W2Je2qeVV7b++rOee3qPweOBB EMRhA5IrRzcUtG9RiCPK0ZvsVIGypyORoDC49E6TJOzwjAZPzptFRfXu7r3/HV7iR1ED5RHPqjmafL 9aUa3WCOk4fVkJMrFDkVwitBSaX8qyHlZtk4Wv9rUaQzU=
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

Move efi32_pe_entry() into the .text section, so that it can be moved
out of head_64.S and into a separate compilation unit in a subsequent
patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index b9dbc8127038c315..8192ab1c308567ce 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -778,7 +778,7 @@ SYM_DATA(efi_is64, .byte 1)
 #define BS32_handle_protocol	88 // offsetof(efi_boot_services_32_t, handle_protocol)
 #define LI32_image_base		32 // offsetof(efi_loaded_image_32_t, image_base)
 
-	__HEAD
+	.text
 	.code32
 SYM_FUNC_START(efi32_pe_entry)
 /*
@@ -800,12 +800,11 @@ SYM_FUNC_START(efi32_pe_entry)
 
 	call	1f
 1:	pop	%ebx
-	subl	$ rva(1b), %ebx
 
 	/* Get the loaded image protocol pointer from the image handle */
 	leal	-4(%ebp), %eax
 	pushl	%eax				// &loaded_image
-	leal	rva(loaded_image_proto)(%ebx), %eax
+	leal	(loaded_image_proto - 1b)(%ebx), %eax
 	pushl	%eax				// pass the GUID address
 	pushl	8(%ebp)				// pass the image handle
 
@@ -834,13 +833,13 @@ SYM_FUNC_START(efi32_pe_entry)
 	movl	12(%ebp), %edx			// sys_table
 	movl	-4(%ebp), %esi			// loaded_image
 	movl	LI32_image_base(%esi), %esi	// loaded_image->image_base
-	movl	%ebx, %ebp			// startup_32 for efi32_pe_stub_entry
+	leal	(startup_32 - 1b)(%ebx), %ebp	// runtime address of startup_32
 	/*
 	 * We need to set the image_offset variable here since startup_32() will
 	 * use it before we get to the 64-bit efi_pe_entry() in C code.
 	 */
-	subl	%esi, %ebx
-	movl	%ebx, rva(image_offset)(%ebp)	// save image_offset
+	subl	%esi, %ebp			// calculate image_offset
+	movl	%ebp, (image_offset - 1b)(%ebx)	// save image_offset
 	xorl	%esi, %esi
 	jmp	efi32_entry			// pass %ecx, %edx, %esi
 						// no other registers remain live
-- 
2.35.1

