Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDB55C006A
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 16:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiIUOzM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 10:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiIUOyu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 10:54:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073A121240;
        Wed, 21 Sep 2022 07:54:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5987D630C3;
        Wed, 21 Sep 2022 14:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE108C433C1;
        Wed, 21 Sep 2022 14:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663772084;
        bh=uI/n1D/cboZT1jrtlffhHbdFUWjlSPDxuGUAYiDSWp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aofb6ZGc0NlP1mav4bY9tR+fAre3QiyThbzf/mqFTKExtrXUeoGD7+iOb876HLx4u
         whVKqCt63R9muN9kh9i6hbsZiWcXwHn9dIIQ5TfDouq4PN5qBFuqZtOhE6Cp8z8pqQ
         ei7/PGwFAdwpOEzOr/vP+sTVvlAO2AfgQslUViNPYpQeILnhZNnF/smCKYyRWLZf4P
         4cni3MO3SyYbIRwogTBzP2X5H25kdqRhUeU7OW4w7cxu+qsQDckZkCUNGzGTuyiREe
         dNMBYdUDvrerh0ySBjQhA2C7aNxfStDuOGO5mn5JN8e0RJ0V0DlrcmDAOBQ+rL+Rwp
         I0Lrt1Rc6hGHA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 07/16] x86/compressed: efi: merge multiple definitions of image_offset into one
Date:   Wed, 21 Sep 2022 16:54:13 +0200
Message-Id: <20220921145422.437618-8-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220921145422.437618-1-ardb@kernel.org>
References: <20220921145422.437618-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1844; i=ardb@kernel.org; h=from:subject; bh=uI/n1D/cboZT1jrtlffhHbdFUWjlSPDxuGUAYiDSWp0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKyWOkJsMuTut8aXD0VKY/3aaMzcCi2kAHJoYZMSc ha/CFGOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYysljgAKCRDDTyI5ktmPJB4xDA CilFP5qGKXtfvEdsj3hI9ZDF/Xc5Rxk+VVdUnxCFKtG0MyYI0gMNV1SGoczAStX6FAp4v0f9JGZheJ bP3cUyrmNVRKaO6bvsSPoIH151T7POy9KzKk9N/LbAjESZndTao6zA2qo2/cZ8fagS8zKgcCjvsOb7 xIex3Gt8tjdRdY5qn+zkfxnvPmBcZNc5CHMMzJ9sysX+22psqDD8DDxtnXm3CRKeg9GA1hbnzJK99a w9uWo6z385p4KxlXYiJ0PVx/m80FmOBxrdRWTQkhiWd3Met2KBhd+8kYXtnyFwMUT2Cu6IcJXdQL9O iGqyYCpodRbKcFgChbJer1E/7lzgcY5EatNZE+8QTzQipx8vTu3Max4j/ZS0PPSDT15oPmLnZj1y5q 8/jexT19dIorbhARwslSJS2+iikvbpGfHcMbsC273DH1Z2huNKr7RRx0slLZJ6rmqnEQUOO6IzvpE9 gqNe8BzWJWYJKkuLq13Vd+AQVbW7ss9iJMlhXJIGFUdAw=
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

There is no need for head_32.S and head_64.S both declaring a copy of
the globale 'image_offset' variable, so drop those and make the extern C
declaration the definition.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_32.S      | 4 ----
 arch/x86/boot/compressed/head_64.S      | 4 ----
 drivers/firmware/efi/libstub/x86-stub.c | 2 +-
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 3b354eb9516d..6589ddd4cfaf 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -208,10 +208,6 @@ SYM_DATA_START_LOCAL(gdt)
 	.quad	0x00cf92000000ffff	/* __KERNEL_DS */
 SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
 
-#ifdef CONFIG_EFI_STUB
-SYM_DATA(image_offset, .long 0)
-#endif
-
 /*
  * Stack and heap for uncompression
  */
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 8da2396a35a8..90b119fbef58 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -718,10 +718,6 @@ SYM_DATA_START(boot32_idt)
 SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
 #endif
 
-#ifdef CONFIG_EFI_STUB
-SYM_DATA(image_offset, .long 0)
-#endif
-
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	__HEAD
 	.code32
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 05ae8bcc9d67..9083ccc1d46b 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -23,7 +23,7 @@
 
 const efi_system_table_t *efi_system_table;
 const efi_dxe_services_table_t *efi_dxe_table;
-extern u32 image_offset;
+u32 image_offset;
 static efi_loaded_image_t *image = NULL;
 
 static efi_status_t
-- 
2.35.1

