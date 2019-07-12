Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8562F66455
	for <lists+linux-efi@lfdr.de>; Fri, 12 Jul 2019 04:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbfGLCWU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 11 Jul 2019 22:22:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2263 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728815AbfGLCWT (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 11 Jul 2019 22:22:19 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7CC8D66BCFCD34EAECC9;
        Fri, 12 Jul 2019 10:22:15 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Fri, 12 Jul 2019 10:22:04 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
        <ying.huang@intel.com>, <ross.lagerwall@citrix.com>,
        <ard.biesheuvel@linaro.org>, <lance.ortiz@hp.com>
Subject: [PATCH 1/1] efi: cper: print AER info of PCIe fatal error
Date:   Fri, 12 Jul 2019 10:20:17 +0800
Message-ID: <1562898017-27166-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

AER info of PCIe fatal error is not printed in the current driver.
Because APEI driver will panic directly for fatal error, and can't
run to the place of printing AER info.

An example log is as following:
[ 3157.655028] {763}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 11
[ 3157.663610] {763}[Hardware Error]: event severity: fatal
[ 3157.663612] {763}[Hardware Error]:  Error 0, type: fatal
[ 3157.663614] {763}[Hardware Error]:   section_type: PCIe error
[ 3157.680328] {763}[Hardware Error]:   port_type: 0, PCIe end point
[ 3157.680329] {763}[Hardware Error]:   version: 4.0
[ 3157.680332] {763}[Hardware Error]:   command: 0x0000, status: 0x0010
[ 3157.698757] {763}[Hardware Error]:   device_id: 0000:82:00.0
[ 3157.698758] {763}[Hardware Error]:   slot: 0
[ 3157.698759] {763}[Hardware Error]:   secondary_bus: 0x00
[ 3157.698760] {763}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x10fb
[ 3157.698761] {763}[Hardware Error]:   class_code: 000002
[ 3157.698825] Kernel panic - not syncing: Fatal hardware error!

This issue was imported by the patch, '37448adfc7ce ("aerdrv: Move
cper_print_aer() call out of interrupt context")'. To fix this issue,
this patch adds print of AER info in cper_print_pcie() for fatal error.

Here is the example log after this patch applied:
[ 7032.893566] {24}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 10
[ 7032.901965] {24}[Hardware Error]: event severity: fatal
[ 7032.907166] {24}[Hardware Error]:  Error 0, type: fatal
[ 7032.912366] {24}[Hardware Error]:   section_type: PCIe error
[ 7032.917998] {24}[Hardware Error]:   port_type: 0, PCIe end point
[ 7032.923974] {24}[Hardware Error]:   version: 4.0
[ 7032.928569] {24}[Hardware Error]:   command: 0x0546, status: 0x4010
[ 7032.934806] {24}[Hardware Error]:   device_id: 0000:01:00.0
[ 7032.940352] {24}[Hardware Error]:   slot: 0
[ 7032.944514] {24}[Hardware Error]:   secondary_bus: 0x00
[ 7032.949714] {24}[Hardware Error]:   vendor_id: 0x15b3, device_id: 0x1019
[ 7032.956381] {24}[Hardware Error]:   class_code: 000002
[ 7032.961495] {24}[Hardware Error]:   aer_uncor_status: 0x00040000, aer_uncor_mask: 0x00000000
[ 7032.969891] {24}[Hardware Error]:   aer_uncor_severity: 0x00062010
[ 7032.976042] {24}[Hardware Error]:   TLP Header: 000000c0 01010000 00000001 00000000
[ 7032.983663] Kernel panic - not syncing: Fatal hardware error!

Fixes: 37448adfc7ce ("aerdrv: Move cper_print_aer() call out of
interrupt context")

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/firmware/efi/cper.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 8fa977c..bf8600d 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -390,6 +390,19 @@ static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
 		printk(
 	"%s""bridge: secondary_status: 0x%04x, control: 0x%04x\n",
 	pfx, pcie->bridge.secondary_status, pcie->bridge.control);
+	if (pcie->validation_bits & CPER_PCIE_VALID_AER_INFO &&
+	    gdata->error_severity & CPER_SEV_FATAL) {
+		struct aer_capability_regs *aer;
+
+		aer = (struct aer_capability_regs *)pcie->aer_info;
+		printk("%saer_uncor_status: 0x%08x, aer_uncor_mask: 0x%08x\n",
+		       pfx, aer->uncor_status, aer->uncor_mask);
+		printk("%saer_uncor_severity: 0x%08x\n",
+		       pfx, aer->uncor_severity);
+		printk("%sTLP Header: %08x %08x %08x %08x\n", pfx,
+		       aer->header_log.dw0, aer->header_log.dw1,
+		       aer->header_log.dw2, aer->header_log.dw3);
+	}
 }
 
 static void cper_print_tstamp(const char *pfx,
-- 
2.8.1

