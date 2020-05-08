Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A911CB68F
	for <lists+linux-efi@lfdr.de>; Fri,  8 May 2020 20:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgEHSCt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 May 2020 14:02:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbgEHSCq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 May 2020 14:02:46 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B3AA24958;
        Fri,  8 May 2020 18:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588960966;
        bh=WTukNKpKjk8cOI4uPZY4UeJ1dYYW706w8hy+2fahylY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2UAI6X/nBupzoFacpraPzq49FlH9Q3AzcBI8fCBaPkDNc0e34yiKDRM4XSWxCsgMt
         7NUkshxZPIXSGAdbEP/8fOvH6oLyfLLFc3EIdqVrRT9sT+GxbQChkS+Z8li6a8utNH
         0DbdR1Ub7MW4aeX0l9eubwfIzD51KJnCTsiqJlsw=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Guenter Roeck <linux@roeck-us.net>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 10/15] efi/x86: Support builtin command line
Date:   Fri,  8 May 2020 20:01:52 +0200
Message-Id: <20200508180157.1816-11-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508180157.1816-1-ardb@kernel.org>
References: <20200508180157.1816-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Add support for the x86 CMDLINE_BOOL and CMDLINE_OVERRIDE configuration
options.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200430182843.2510180-11-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f1a134596b53..c84c5678e3e1 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -680,7 +680,6 @@ unsigned long efi_main(efi_handle_t handle,
 	unsigned long buffer_start, buffer_end;
 	struct setup_header *hdr = &boot_params->hdr;
 	efi_status_t status;
-	unsigned long cmdline_paddr;
 
 	efi_system_table = sys_table_arg;
 
@@ -739,9 +738,14 @@ unsigned long efi_main(efi_handle_t handle,
 		image_offset = 0;
 	}
 
-	cmdline_paddr = ((u64)hdr->cmd_line_ptr |
-			 ((u64)boot_params->ext_cmd_line_ptr << 32));
-	efi_parse_options((char *)cmdline_paddr);
+#ifdef CONFIG_CMDLINE_BOOL
+	efi_parse_options(CONFIG_CMDLINE);
+#endif
+	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
+		unsigned long cmdline_paddr = ((u64)hdr->cmd_line_ptr |
+					       ((u64)boot_params->ext_cmd_line_ptr << 32));
+		efi_parse_options((char *)cmdline_paddr);
+	}
 
 	/*
 	 * At this point, an initrd may already have been loaded by the
-- 
2.17.1

