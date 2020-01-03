Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 796DB12F787
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jan 2020 12:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgACLkp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Jan 2020 06:40:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbgACLkp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 3 Jan 2020 06:40:45 -0500
Received: from localhost.localdomain (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3638821D7D;
        Fri,  3 Jan 2020 11:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578051644;
        bh=K/Vpxq9bymqTfdAJSTcXE+H+meoAXcrzQIb0UcJK45k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cfLUbEC7gpDcnJheUGq99EVH7M9j7DA3RyNKM8oqxvMnxY5FffMqqHm/BkDhLEG7p
         2+qSsROhTR+OiAyYWmCo58oU3mXfRHJoRChiavawTWBYqts8/m3oL3O7uekW+VJInI
         bDXDGOT9Q0fqQ210xVj7uYBHZiUTZJfYBSPewCQw=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH 14/20] efi/x86: remove unreachable code in kexec_enter_virtual_mode()
Date:   Fri,  3 Jan 2020 12:39:47 +0100
Message-Id: <20200103113953.9571-15-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103113953.9571-1-ardb@kernel.org>
References: <20200103113953.9571-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Remove some code that is guaranteed to be unreachable, given
that we have already bailed by this time if EFI_OLD_MEMMAP is
set.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 4f539bfdc051..b931c4bea284 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -850,9 +850,6 @@ static void __init kexec_enter_virtual_mode(void)
 	efi.runtime_version = efi_systab.hdr.revision;
 
 	efi_native_runtime_setup();
-
-	if (efi_enabled(EFI_OLD_MEMMAP) && (__supported_pte_mask & _PAGE_NX))
-		runtime_code_page_mkexec();
 #endif
 }
 
-- 
2.20.1

