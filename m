Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 944A7160559
	for <lists+linux-efi@lfdr.de>; Sun, 16 Feb 2020 19:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgBPSYF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Feb 2020 13:24:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbgBPSYD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 16 Feb 2020 13:24:03 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1234B2465D;
        Sun, 16 Feb 2020 18:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581877443;
        bh=M6CtQIWxWimc9CTNa99EsOazRYurLdEN+0lz9EbRkzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HF+fSYYCHuFY90WdfozOQ/Gg+MLB1ebGPUlwlpGiC5OyQbuTT7J7qecISnVTyY8Fz
         w7Z1mlXr2uRiv6VsFCnhx8poDOo8eS3nvWJQA9Hw/NeTHiAOqiPapXEntfifvNZvo3
         hoes4JQxVBBy9jejNEh4C6g5Oiox3GkIeL9mvBl4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        x86@kernel.org
Subject: [PATCH 10/18] efi/ia64: switch to efi_config_parse_tables()
Date:   Sun, 16 Feb 2020 19:23:26 +0100
Message-Id: <20200216182334.8121-11-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200216182334.8121-1-ardb@kernel.org>
References: <20200216182334.8121-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

IA64 calls efi_config_parse_tables() via efi_config_init(), which
does an explicit memremap() of the tables, which is unnecessary
on IA64. So let's call efi_config_parse_tables() directly, passing
the __va() of the config table array.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/ia64/kernel/efi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
index 81bc5031a115..3b5cf551489c 100644
--- a/arch/ia64/kernel/efi.c
+++ b/arch/ia64/kernel/efi.c
@@ -531,7 +531,10 @@ efi_init (void)
 
 	palo_phys      = EFI_INVALID_TABLE_ADDR;
 
-	if (efi_config_init(arch_tables) != 0)
+	if (efi_config_parse_tables(__va(efi_systab->tables),
+				    efi_systab->nr_tables,
+				    sizeof(efi_config_table_t),
+				    arch_tables) != 0)
 		return;
 
 	if (palo_phys != EFI_INVALID_TABLE_ADDR)
-- 
2.17.1

