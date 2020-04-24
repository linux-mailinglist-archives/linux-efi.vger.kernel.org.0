Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DF31B7650
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgDXNGo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:06:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728060AbgDXNGn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:06:43 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1044520728;
        Fri, 24 Apr 2020 13:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733602;
        bh=cbhyVDwE4Etg/RVG0jr5m9rTNPZAlv0ilHyvhuYcPwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zIutlQ+Uj4DRaTUlv+1CutM6H31NCVu+SX/FHwpqKTD1J+2lO8fATnedsF3OEfwz7
         OKCueDnkbX708uhMl/wm4Y14ubKZda4MuxeORTmTIC65oYuVYN8e8B91lw8ZvuLZL2
         wtEIS5l4q6DKfLacps3wwIsx/We7iMmSM5uGe7mA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 14/33] efi/gop: Add prototypes for query_mode and set_mode
Date:   Fri, 24 Apr 2020 15:05:12 +0200
Message-Id: <20200424130531.30518-15-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Add prototypes and argmap for the Graphics Output Protocol's QueryMode
and SetMode functions.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200320020028.1936003-11-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h             | 4 ++++
 drivers/firmware/efi/libstub/efistub.h | 6 ++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 8391c115c0ec..f59cba117dcb 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -307,6 +307,10 @@ static inline u32 efi64_convert_status(efi_status_t status)
 #define __efi64_argmap_load_file(protocol, path, policy, bufsize, buf)	\
 	((protocol), (path), (policy), efi64_zero_upper(bufsize), (buf))
 
+/* Graphics Output Protocol */
+#define __efi64_argmap_query_mode(gop, mode, size, info)		\
+	((gop), (mode), efi64_zero_upper(size), efi64_zero_upper(info))
+
 /*
  * The macros below handle the plumbing for the argument mapping. To add a
  * mapping for a specific EFI method, simply define a macro
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index d9ad8582dbea..321244ed20a4 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -314,8 +314,10 @@ typedef union efi_graphics_output_protocol efi_graphics_output_protocol_t;
 
 union efi_graphics_output_protocol {
 	struct {
-		void *query_mode;
-		void *set_mode;
+		efi_status_t (__efiapi *query_mode)(efi_graphics_output_protocol_t *,
+						    u32, unsigned long *,
+						    efi_graphics_output_mode_info_t **);
+		efi_status_t (__efiapi *set_mode)  (efi_graphics_output_protocol_t *, u32);
 		void *blt;
 		efi_graphics_output_protocol_mode_t *mode;
 	};
-- 
2.17.1

