Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 550081770C0
	for <lists+linux-efi@lfdr.de>; Tue,  3 Mar 2020 09:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbgCCIG5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Mar 2020 03:06:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:46664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727726AbgCCIG5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Mar 2020 03:06:57 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1157820CC7;
        Tue,  3 Mar 2020 08:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583222816;
        bh=woSE0T1/mPucInnvKy6XmS0LeBbHNgQ0XzBMVOTpWvU=;
        h=From:To:Cc:Subject:Date:From;
        b=eC5sD1GgEQRRk2vfp8M+bmAbjqQQz1y88qRyuVlpEVV5F2d3J9073R/kUDaGaZj54
         Ii/vQ8yRwdDLgcH1tXozqebFdKrAa5yOmvXi24v/e+otS+u64C6G6+gc+WEmWFHVlM
         qaep8vOE1wvAMfoHJNPqXofQPMSRbYM17WuGvRK0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] efi/libstub/x86: deal with exit() boot service returning
Date:   Tue,  3 Mar 2020 09:06:48 +0100
Message-Id: <20200303080648.21427-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Even though it is uncommon, there are cases where the Exit() EFI boot
service might return, e.g., when we were booted via the EFI handover
protocol from OVMF and the kernel image was specified on the command
line, in which case Exit() attempts to terminate the boot manager,
which is not an EFI application itself. So let's drop into a deadloop
instead.

Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
As a side effect, this also fixes [0], which is as yet undiagnosed.

[0] https://github.com/ClangBuiltLinux/linux/issues/917

 drivers/firmware/efi/libstub/x86-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 7f3e97c2aad3..5c7480c4d379 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -344,7 +344,7 @@ static void setup_graphics(struct boot_params *boot_params)
 static void __noreturn efi_exit(efi_handle_t handle, efi_status_t status)
 {
 	efi_bs_call(exit, handle, status, 0, NULL);
-	unreachable();
+	for(;;);
 }
 
 void startup_32(struct boot_params *boot_params);
-- 
2.17.1

