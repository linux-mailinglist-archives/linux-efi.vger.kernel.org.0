Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C06317D285
	for <lists+linux-efi@lfdr.de>; Sun,  8 Mar 2020 09:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgCHIKW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Mar 2020 04:10:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgCHIKW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 8 Mar 2020 04:10:22 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 634DC2173E;
        Sun,  8 Mar 2020 08:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583655021;
        bh=rN3pVi6vb7RD9V3f/+mRYikZsk3O/aOcSpSlsYQSHGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FDy05dQLoZC60ordL4gxXUb2JzvVbKkDG+sdDYJi8+Qft/AOgyJkl05BlPyZuKBEK
         IuJmORppFyv2Sx4jSZgsZh76XhK88DW9Dci3yO3Fy2HeIIHlCBvmZDmm/VjJ8z3T7e
         GU/L0UHAigNALVcq2/aeSy/D80IG7kMM/UIPdtdw=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nikolai Merinov <n.merinov@inango-systems.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH 21/28] efi/x86: preserve %ebx correctly in efi_set_virtual_address_map()
Date:   Sun,  8 Mar 2020 09:08:52 +0100
Message-Id: <20200308080859.21568-22-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200308080859.21568-1-ardb@kernel.org>
References: <20200308080859.21568-1-ardb@kernel.org>
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
Tested-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20200304133515.15035-1-ardb@kernel.org
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

