Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C6E1B7667
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 15:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgDXNHZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 09:07:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728349AbgDXNHY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 09:07:24 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4DB82084D;
        Fri, 24 Apr 2020 13:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733643;
        bh=rspLT0jEFuKk+8InswzVszPuHwWF31+D+jC6L7vwmz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sYFlRO6jWEY3RG+Kv0wINRYb/ec4eP7uzJIq0tAy0RmMFoPHeAI2kxKJChwADxCoj
         Lugi496iid7DBICoC+stgTEpiaWC9TkE6yzy6gedmR5h+90t43VFeA8QesiNc5nxgd
         Evp5Ln89iaNOTMM7jQu52O5QlhOBrL5WqnTFMG0c=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 33/33] efi: Move arch_tables check to caller
Date:   Fri, 24 Apr 2020 15:05:31 +0200
Message-Id: <20200424130531.30518-34-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Instead of making match_config_table() test its table_types pointer for
NULL-ness, omit the call entirely if no arch_tables pointer was provided
to efi_config_parse_tables().

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index e49c0b6db988..48d0188936c3 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -525,15 +525,13 @@ static __init int match_config_table(const efi_guid_t *guid,
 {
 	int i;
 
-	if (table_types) {
-		for (i = 0; efi_guidcmp(table_types[i].guid, NULL_GUID); i++) {
-			if (!efi_guidcmp(*guid, table_types[i].guid)) {
-				*(table_types[i].ptr) = table;
-				if (table_types[i].name[0])
-					pr_cont(" %s=0x%lx ",
-						table_types[i].name, table);
-				return 1;
-			}
+	for (i = 0; efi_guidcmp(table_types[i].guid, NULL_GUID); i++) {
+		if (!efi_guidcmp(*guid, table_types[i].guid)) {
+			*(table_types[i].ptr) = table;
+			if (table_types[i].name[0])
+				pr_cont("%s=0x%lx ",
+					table_types[i].name, table);
+			return 1;
 		}
 	}
 
@@ -570,7 +568,7 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 			table = tbl32[i].table;
 		}
 
-		if (!match_config_table(guid, table, common_tables))
+		if (!match_config_table(guid, table, common_tables) && arch_tables)
 			match_config_table(guid, table, arch_tables);
 	}
 	pr_cont("\n");
-- 
2.17.1

