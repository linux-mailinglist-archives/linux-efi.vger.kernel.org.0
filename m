Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C81671A3494
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 15:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgDINFV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 09:05:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgDINFR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Apr 2020 09:05:17 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 199E820B1F;
        Thu,  9 Apr 2020 13:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586437517;
        bh=ENj9gyIpSdOm3HFxFqSOAiP74yf1INHrcxCTQAxSIvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MlGEIh4lVXQBNPeZ75l1plhLEDzJDaoZ5zHV3xV2OeL6DNR6/k2Tv3BLq+fdpHpzT
         UINzVsyZ19zzkfjlvxJ8PXf76PJ+yXReKS/Y+apLTWLt1iYAbWzgtcyOJb0TCOJJ41
         5TJJEmsoMEDRyqEaJ3j2Iya7I0rSV1UbKEBgu7So=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Gary Lin <glin@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Sergey Shatunov <me@prok.pw>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 8/9] efi/x86: Fix the deletion of variables in mixed mode
Date:   Thu,  9 Apr 2020 15:04:33 +0200
Message-Id: <20200409130434.6736-9-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409130434.6736-1-ardb@kernel.org>
References: <20200409130434.6736-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Gary Lin <glin@suse.com>

efi_thunk_set_variable() treated the NULL "data" pointer as an invalid
parameter, and this broke the deletion of variables in mixed mode.
This commit fixes the check of data so that the userspace program can
delete a variable in mixed mode.

Fixes: 8319e9d5ad98ffcc ("efi/x86: Handle by-ref arguments covering multiple pages in mixed mode")
Cc: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Gary Lin <glin@suse.com>
Link: https://lore.kernel.org/r/20200408081606.1504-1-glin@suse.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 211bb9358b73..e0e2e8136cf5 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -638,7 +638,7 @@ efi_thunk_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 	phys_vendor = virt_to_phys_or_null(vnd);
 	phys_data = virt_to_phys_or_null_size(data, data_size);
 
-	if (!phys_name || !phys_data)
+	if (!phys_name || (data && !phys_data))
 		status = EFI_INVALID_PARAMETER;
 	else
 		status = efi_thunk(set_variable, phys_name, phys_vendor,
@@ -669,7 +669,7 @@ efi_thunk_set_variable_nonblocking(efi_char16_t *name, efi_guid_t *vendor,
 	phys_vendor = virt_to_phys_or_null(vnd);
 	phys_data = virt_to_phys_or_null_size(data, data_size);
 
-	if (!phys_name || !phys_data)
+	if (!phys_name || (data && !phys_data))
 		status = EFI_INVALID_PARAMETER;
 	else
 		status = efi_thunk(set_variable, phys_name, phys_vendor,
-- 
2.17.1

