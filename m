Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 842272C795
	for <lists+linux-efi@lfdr.de>; Tue, 28 May 2019 15:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfE1NOx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 May 2019 09:14:53 -0400
Received: from mailgate2.uni-hannover.de ([130.75.2.114]:56978 "EHLO
        mailgate2.uni-hannover.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfE1NOx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 May 2019 09:14:53 -0400
X-Greylist: delayed 983 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 May 2019 09:14:51 EDT
Received: from kolab.sra.uni-hannover.de (kolab.sra.uni-hannover.de [130.75.33.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailgate2.uni-hannover.de (Postfix) with ESMTPS id 2DB8D2206;
        Tue, 28 May 2019 14:58:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at sra.uni-hannover.de
Received: from lab.sra.uni-hannover.de (aerobus.sra.uni-hannover.de
 [130.75.33.87])
 by kolab.sra.uni-hannover.de (Postfix) with SMTP id DD1F43E0622;
 Tue, 28 May 2019 14:57:59 +0200 (CEST)
Received: (nullmailer pid 2217 invoked by uid 20018);
 Tue, 28 May 2019 12:58:26 -0000
From:   Lennart Glauer <mail@lennart-glauer.de>
To:     ard.biesheuvel@linaro.org, dvhart@infradead.org,
        andy@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lennart Glauer <mail@lennart-glauer.de>
Subject: [PATCH] x86/efi: Free efi_pgd with free_pages()
Date:   Tue, 28 May 2019 14:58:05 +0200
Message-Id: <20190528125805.2166-1-mail@lennart-glauer.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch fixes another occurrence of free_page() that was missed
in 06ace26.
The efi_pgd is allocated as PGD_ALLOCATION_ORDER pages and therefore must
also be freed as PGD_ALLOCATION_ORDER pages with free_pages().

Signed-off-by: Lennart Glauer <mail@lennart-glauer.de>
---
 arch/x86/platform/efi/efi_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 08ce8177c3af..acad22a44774 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -222,7 +222,7 @@ int __init efi_alloc_page_tables(void)
 	pgd = efi_pgd + pgd_index(EFI_VA_END);
 	p4d = p4d_alloc(&init_mm, pgd, EFI_VA_END);
 	if (!p4d) {
-		free_page((unsigned long)efi_pgd);
+		free_pages((unsigned long)efi_pgd, PGD_ALLOCATION_ORDER);
 		return -ENOMEM;
 	}
 
-- 
2.17.1
