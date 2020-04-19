Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E92D1AF982
	for <lists+linux-efi@lfdr.de>; Sun, 19 Apr 2020 13:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgDSLBx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 19 Apr 2020 07:01:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgDSLBx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 19 Apr 2020 07:01:53 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46F9E22244;
        Sun, 19 Apr 2020 11:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587294113;
        bh=kW2dYKHy6Rmn05kDsrQDFAxNy6S03Bfwkek3m0DJMek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=15xPdBd8mUyVdH3VAuS1Cjh7XFDSmyTnoaqXO7cmSPrOqUDbZQIKcMjXki3K9qHA6
         r+iR7OOW74cvoKdYtUAcDSHkkZdUg6AcyGMCFCM2Xg51UV2o18prUaPWsZvxTrauef
         TDFD7lNPufx7eL6H6TAYiJXFtB+lpQCyxxxKciGw=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 2/2] efi: move arch_tables check to caller
Date:   Sun, 19 Apr 2020 13:01:45 +0200
Message-Id: <20200419110145.1052-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419110145.1052-1-ardb@kernel.org>
References: <20200419110145.1052-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Instead of making match_config_table() test its table_types pointer for
NULL-ness, omit the call entirely if there is no arch_tables pointer
was provided to efi_config_parse_tables().

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index e49c0b6db988..2930b4c154f6 100644
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
+				pr_cont(" %s=0x%lx ",
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

