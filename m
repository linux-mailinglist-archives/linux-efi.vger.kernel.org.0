Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD555C0066
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 16:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiIUOzD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 10:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiIUOys (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 10:54:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9FC1A07A;
        Wed, 21 Sep 2022 07:54:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A0365CE1D79;
        Wed, 21 Sep 2022 14:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0B3C433D6;
        Wed, 21 Sep 2022 14:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663772077;
        bh=o0vOap9iIN4E2+BoQRyEvyx6kjfq+JQHm6p7vOAdphQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CydRzpRM6uWJd794U0eoO1hyIAmaszkW0nCLn8rZFPMBDK+BVKUQoET6lHBsdDuN9
         9EtzHt9Odwdgy7nIxKPuDvBFLkCOIiuc8GCrICH7/Yys1pPdD5B7uoWP2Iw3lK8cfE
         lbhIbWJHUv9t+z72QEP34my90cIsZss1+MSDu3MPnu/q5VpPNSnr0KmJBwJbFCsAVn
         iNP45aQYeMQ7eikKvy6NOhXVu3OrEfIDH8fBf5iJ34J+0TB6qMYrL/+3nzjtS25X7T
         GWkk7P7mgvs/IpY7SV0YPhuzqbDWJX7F8KBTlbgQ3o+nD71ywHTPz8IZhCTuewjRJm
         +k8h9IvkAMzKg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 04/16] x86/compressed: efi-mixed: move efi32_pe_entry into .text section
Date:   Wed, 21 Sep 2022 16:54:10 +0200
Message-Id: <20220921145422.437618-5-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220921145422.437618-1-ardb@kernel.org>
References: <20220921145422.437618-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1945; i=ardb@kernel.org; h=from:subject; bh=o0vOap9iIN4E2+BoQRyEvyx6kjfq+JQHm6p7vOAdphQ=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKyWJixTl48qDMM2yLff5o3nACI0mWOfouqzJ3uNp AsZzdvqJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYysliQAKCRDDTyI5ktmPJN8lC/ 0a/BUrkVxZiA1BltDvFqMgNFWU+KA2Ek0RXT/49vnQGfCZknlrv5MnPH8Q1BkGjhyYsFLJSffyaKTY wWKyVqmoXZ92uruEvWcxH6eaWCRP5CBTbBRcb/uxP5Uvt5bomfzc6cmLV7Dczqi/C9FkrOk3+LvHfV 8nOb3O7Af56X6pOcUDrxTdoxAQRJu6BV8goclbK5+OT45J1M3lCetieTMXDK/Kc+ZfRhH0pmkIRM6r KZhgv98EhSXO62U7AkUbN4JshSNPS8ig4Oe8UmUdSQaQuai+4Yl2xjLl4HDuM58DICT/A6yoY+91XI A1IzFi6ojQEsYhezOeUyXs+V0YeEoPNW19w8UcMFZOSV1Rws/pqVARNiD5maIHFDIB0sLmRTqRw8nV i+fYaUeGeVqm1Mr4pteDXtfKRaHlIvQEiB9Glmyb52gKBz5pwnFuqSx6b94aCmAnM6ltrpcI8cwhVh 3MewTsqtSoZUP1sVRlaX7GQgyR+ahpl/qvFk93AyQ8IFg=
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
index b51f0e107c2e..9ae6ddccd3ef 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -757,7 +757,7 @@ SYM_DATA(efi_is64, .byte 1)
 #define BS32_handle_protocol	88 // offsetof(efi_boot_services_32_t, handle_protocol)
 #define LI32_image_base		32 // offsetof(efi_loaded_image_32_t, image_base)
 
-	__HEAD
+	.text
 	.code32
 SYM_FUNC_START(efi32_pe_entry)
 /*
@@ -779,12 +779,11 @@ SYM_FUNC_START(efi32_pe_entry)
 
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
 
@@ -813,13 +812,13 @@ SYM_FUNC_START(efi32_pe_entry)
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
 	jmp	efi32_entry
 
-- 
2.35.1

