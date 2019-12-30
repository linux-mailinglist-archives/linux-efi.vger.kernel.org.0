Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B872312D32D
	for <lists+linux-efi@lfdr.de>; Mon, 30 Dec 2019 19:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfL3SJp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Dec 2019 13:09:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:38770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbfL3SJp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 30 Dec 2019 13:09:45 -0500
Received: from localhost.localdomain (91-167-84-221.subs.proxad.net [91.167.84.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F23632071E;
        Mon, 30 Dec 2019 18:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577729385;
        bh=K/Vpxq9bymqTfdAJSTcXE+H+meoAXcrzQIb0UcJK45k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i59sWrsdL3IErTkDPiV9UQfrLazzYZRrSHnalAw7nwWSwW7kJ6blbtPaWQHVKgacM
         kRTrn+ptM1tBdAiUfcK3+BcQBCiiqdDSOiVJiIArDPpYih1mx6DvleYNH8Z7avmRMN
         VcMCHI4O0hRUDPVDkjGz7kt8NH36hSOOm83+D+zY=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 14/14] efi/x86: remove unreachable code in kexec_enter_virtual_mode()
Date:   Mon, 30 Dec 2019 19:08:34 +0100
Message-Id: <20191230180834.75601-15-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191230180834.75601-1-ardb@kernel.org>
References: <20191230180834.75601-1-ardb@kernel.org>
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

