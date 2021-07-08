Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40433BF7C2
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jul 2021 11:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhGHJtl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Jul 2021 05:49:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39334 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhGHJtl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Jul 2021 05:49:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7907422134;
        Thu,  8 Jul 2021 09:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625737618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3WiGTxeJUD1NvAtf5DKhhhC7eQ4GrltVQ+LN36/PEG8=;
        b=q4jIuGMI+Buk5p0CN5J3qSUMsDcy7SDwRrVEU7wZuGpCt+y4ZxwJrYaLO9Ju1xj4/pVKxi
        uBx52mRL91aXDL+hNNQjDp0VgvW5Pml6L9/bW2da7nbOqC8FTKdxK78Ae/MZt6pfJGAS3F
        L1lLstH+9PK+oCaPeHYXUYzbQoz/YiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625737618;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3WiGTxeJUD1NvAtf5DKhhhC7eQ4GrltVQ+LN36/PEG8=;
        b=1Uw8t4cB9XmSPrIhI/OM4F2ugBDB+/05GtuF8mTZ+e1wAtw32+vnUkzHlKT05OcvKwyNOv
        5cOiKJVfR3EmmgDw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 457F0A3B89;
        Thu,  8 Jul 2021 09:46:58 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-integrity@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?Lo=C3=AFc=20Yhuel?= <loic.yhuel@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] efi/tpm: Differentiate missing and invalid final event log table.
Date:   Thu,  8 Jul 2021 11:46:54 +0200
Message-Id: <20210708094654.4157-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Missing TPM final event log table is not a firmware bug.

Clearly if providing event log in the old format makes the final event
log invalid it should not be provided at least in that case.

Fixes: b4f1874c6216 ("tpm: check event log version before reading final events")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 drivers/firmware/efi/tpm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index c1955d320fec..8f665678e9e3 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -62,9 +62,11 @@ int __init efi_tpm_eventlog_init(void)
 	tbl_size = sizeof(*log_tbl) + log_tbl->size;
 	memblock_reserve(efi.tpm_log, tbl_size);
 
-	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR ||
-	    log_tbl->version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
-		pr_warn(FW_BUG "TPM Final Events table missing or invalid\n");
+	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
+		pr_info("TPM Final Events table not present\n");
+		goto out;
+	} else if (log_tbl->version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
+		pr_warn(FW_BUG "TPM Final Events table invalid\n");
 		goto out;
 	}
 
-- 
2.26.2

