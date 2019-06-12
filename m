Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C156841EE4
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jun 2019 10:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405677AbfFLIUX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Jun 2019 04:20:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:49338 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404384AbfFLIUX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 12 Jun 2019 04:20:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 01:20:22 -0700
X-ExtLoop1: 1
Received: from btian1.sh.intel.com ([10.239.216.137])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jun 2019 01:20:21 -0700
From:   baofeng.tian@intel.com
To:     ard.biesheuvel@linaro.org, linux-efi@vger.kernel.org,
        jeremy.compostella@intel.com, ming.tan@intel.com,
        qihua.zhuang@intel.com
Cc:     Tian Baofeng <baofeng.tian@intel.com>,
        Luo XinanX <xinanx.luo@intel.com>
Subject: [[efi boot control]] efibc: Replace variable set function in notifier call
Date:   Wed, 12 Jun 2019 16:18:10 +0800
Message-Id: <20190612081810.26526-1-baofeng.tian@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Tian Baofeng <baofeng.tian@intel.com>

Replace the variable set function from "efivar_entry_set" to
"efivar_entry_set_safe" in efibc panic notifier.
In safe function parameter "block" will set to false
and will call "efivar_entry_set_nonblocking"to set efi variables.
efivar_entry_set_nonblocking is guaranteed to
not block and is suitable for calling from crash/panic handlers.
In UEFI android platform, when warm reset happens,
with this change, efibc will not block the reboot process.
Otherwise, set variable will call queue work and send to other offlined
cpus then cause another panic, finally will cause reboot failure.

Signed-off-by: Tian Baofeng <baofeng.tian@intel.com>
Signed-off-by: Luo XinanX <xinanx.luo@intel.com>
---
 drivers/firmware/efi/efibc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/efibc.c b/drivers/firmware/efi/efibc.c
index 61e099826cbb..35dccc88ac0a 100644
--- a/drivers/firmware/efi/efibc.c
+++ b/drivers/firmware/efi/efibc.c
@@ -43,11 +43,13 @@ static int efibc_set_variable(const char *name, const char *value)
 	efibc_str_to_str16(value, (efi_char16_t *)entry->var.Data);
 	memcpy(&entry->var.VendorGuid, &guid, sizeof(guid));
 
-	ret = efivar_entry_set(entry,
-			       EFI_VARIABLE_NON_VOLATILE
-			       | EFI_VARIABLE_BOOTSERVICE_ACCESS
-			       | EFI_VARIABLE_RUNTIME_ACCESS,
-			       size, entry->var.Data, NULL);
+	ret = efivar_entry_set_safe(entry->var.VariableName,
+				    entry->var.VendorGuid,
+				    EFI_VARIABLE_NON_VOLATILE
+				    | EFI_VARIABLE_BOOTSERVICE_ACCESS
+				    | EFI_VARIABLE_RUNTIME_ACCESS,
+				    false, size, entry->var.Data);
+
 	if (ret)
 		pr_err("failed to set %s EFI variable: 0x%x\n",
 		       name, ret);
-- 
2.21.0

