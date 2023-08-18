Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F1C780CC3
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 15:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348157AbjHRNpW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 09:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377267AbjHRNox (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 09:44:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA6D3C27;
        Fri, 18 Aug 2023 06:44:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A0706687F;
        Fri, 18 Aug 2023 13:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2330C433C9;
        Fri, 18 Aug 2023 13:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692366291;
        bh=VFCtgicdCB5WbvZIDPnW6Rc00lf0AfjRC33aK0Uexlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nxp6rUosmdsXfryUMDJUKqhXQb9G76zM98qr/Q9ZohfW0xn0JV70D1wi6fCzTQtyL
         zaHovjpW8JMfs1VH6eFDXgnn2e5P3AqzTqz06eeCJNeURENVyqS1M+vg9KTGmh99p5
         CqC+P/vRZbgvyX/s2cwr8Z7ppmi5veoi6/dtEE+psu3f1yQELphNY696BfKImaclIm
         oY8nIOTYwD6txUg3echc8NNEkOP3v/JnEs00TPcy0YsKk2wmPmda6zooiRGWivC87Q
         Q2QxISEZuO2nw6Omffj1SeamC37L4DLfLxXmq820Svv0ivZ9mOSxyMLdokDrjf65EG
         zgS0T7fIiqsBA==
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
Subject: [PATCH 03/17] x86/efi: Drop alignment flags from PE section headers
Date:   Fri, 18 Aug 2023 15:44:08 +0200
Message-Id: <20230818134422.380032-4-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818134422.380032-1-ardb@kernel.org>
References: <20230818134422.380032-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1801; i=ardb@kernel.org; h=from:subject; bh=VFCtgicdCB5WbvZIDPnW6Rc00lf0AfjRC33aK0Uexlo=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV+6ex/V75qu3KIP9DcrrY5+fna3Z/eunX9uTnroljxZ WflzKfyHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiFrUM/2xY5xpLfrstvOz9 3uIstYiJGyJymHyX+UpuW59oF5vg7MjIMIv91W2p9yvlG9pSX6ob8H2MtMksVxFjeWwgw2xkMbO FDwA=
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

The section header flags for alignment are documented in the PE/COFF
spec as only being applicable to PE object files, not PE executables
such as the Linux bzImage, so let's drop them from the PE header.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index b04ca8e2b213c6e6..8c8148d751c6d22b 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -209,8 +209,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_CODE		| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_EXECUTE		| \
-		IMAGE_SCN_ALIGN_16BYTES		# Characteristics
+		IMAGE_SCN_MEM_EXECUTE		# Characteristics
 
 	#
 	# The EFI application loader requires a relocation section
@@ -230,8 +229,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_DISCARDABLE	| \
-		IMAGE_SCN_ALIGN_1BYTES		# Characteristics
+		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
 
 #ifdef CONFIG_EFI_MIXED
 	#
@@ -249,8 +247,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_DISCARDABLE	| \
-		IMAGE_SCN_ALIGN_1BYTES		# Characteristics
+		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
 #endif
 
 	#
@@ -271,8 +268,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_CODE		| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_EXECUTE		| \
-		IMAGE_SCN_ALIGN_16BYTES		# Characteristics
+		IMAGE_SCN_MEM_EXECUTE		# Characteristics
 
 	.set	section_count, (. - section_table) / 40
 #endif /* CONFIG_EFI_STUB */
-- 
2.39.2

