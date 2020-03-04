Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 568DF179177
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 14:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgCDNfc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 08:35:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728278AbgCDNfc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Mar 2020 08:35:32 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4605B21739;
        Wed,  4 Mar 2020 13:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583328932;
        bh=rD/RLdHaqHSk/2MHT+fXfbGTwVbs3PkeczaiqlZzx0k=;
        h=From:To:Cc:Subject:Date:From;
        b=NmkvI1e1JhPITTGxUOfPrTlcw4HGBKC8E/csJrtCUghAUfng980+yhfAKUoQhc0ER
         YX3wMSxBpcgorYZQjB0Suh6JfvPkp0ZZf1l4JB2QK+X0nn2DJIWOn/aVJ2iX2BfPlc
         bPgnQPHmJbBViyBQ8envrVUUpCgLbOR8XL8j2/ww=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux@roeck-us.net, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH efi-next] efi/x86: preserve %ebx correctly in efi_set_virtual_address_map()
Date:   Wed,  4 Mar 2020 14:35:15 +0100
Message-Id: <20200304133515.15035-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit 59f2a619a2db8611 ("efi: Add 'runtime' pointer to struct efi")
modified the assembler routine called by efi_set_virtual_address_map(),
to grab the 'runtime' EFI service pointer while running with paging
disabled (which is tricky to do in C code)

After the change, register %ebx is not restored correctly, resulting
in all kinds of weird behavior, so fix that.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi_stub_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/efi_stub_32.S b/arch/x86/platform/efi/efi_stub_32.S
index 09237236fb25..09ec84f6ef51 100644
--- a/arch/x86/platform/efi/efi_stub_32.S
+++ b/arch/x86/platform/efi/efi_stub_32.S
@@ -54,7 +54,7 @@ SYM_FUNC_START(efi_call_svam)
 	orl	$0x80000000, %edx
 	movl	%edx, %cr0
 
-	pop	%ebx
+	movl	16(%esp), %ebx
 	leave
 	ret
 SYM_FUNC_END(efi_call_svam)
-- 
2.17.1

