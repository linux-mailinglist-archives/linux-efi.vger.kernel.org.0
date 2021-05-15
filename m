Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896043816CA
	for <lists+linux-efi@lfdr.de>; Sat, 15 May 2021 10:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhEOIPt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 15 May 2021 04:15:49 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:48111 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230426AbhEOIPs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 15 May 2021 04:15:48 -0400
Received: from localhost.localdomain (ip5f5aeee7.dynamic.kabel-deutschland.de [95.90.238.231])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id BC5B161E64784;
        Sat, 15 May 2021 10:14:31 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/efi: Log 32/64-bit mismatch with kernel as an error
Date:   Sat, 15 May 2021 10:14:04 +0200
Message-Id: <20210515081404.6334-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Log the message

    No EFI runtime due to 32/64-bit mismatch with kernel

as an error condition, as several things like efivarfs won’t work
without the EFI runtime.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 arch/x86/platform/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 8a26e705cb06..147c30a81f15 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -468,7 +468,7 @@ void __init efi_init(void)
 	 */
 
 	if (!efi_runtime_supported())
-		pr_info("No EFI runtime due to 32/64-bit mismatch with kernel\n");
+		pr_err("No EFI runtime due to 32/64-bit mismatch with kernel\n");
 
 	if (!efi_runtime_supported() || efi_runtime_disabled()) {
 		efi_memmap_unmap();
-- 
2.31.1

