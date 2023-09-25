Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089127AD230
	for <lists+linux-efi@lfdr.de>; Mon, 25 Sep 2023 09:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjIYHpT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Sep 2023 03:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjIYHpQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 25 Sep 2023 03:45:16 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B87A1A5;
        Mon, 25 Sep 2023 00:44:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Vsmvt3._1695627886;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vsmvt3._1695627886)
          by smtp.aliyun-inc.com;
          Mon, 25 Sep 2023 15:44:47 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, robert.moore@intel.com
Cc:     linux-hardening@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        xueshuai@linux.alibaba.com, baolin.wang@linux.alibaba.com
Subject: [RFC PATCH v2 8/9] ACPI: APEI: ESRT: print AER to report serialized PCIe errors
Date:   Mon, 25 Sep 2023 15:44:25 +0800
Message-Id: <20230925074426.97856-9-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
References: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Introduce a new pstore_record type, PSTORE_TYPE_CPER_PCIE, so that
serialized PCIe errors can be restrived and saved as a file in pstore file
system. While the serialized PCIe errors is retrieved from ERST backend,
print AER information.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/erst.c | 15 +++++++++++++++
 fs/pstore/platform.c     |  1 +
 include/linux/pstore.h   |  1 +
 3 files changed, 17 insertions(+)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 786d46c767ee..e0c44ea46acc 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -27,6 +27,8 @@
 #include <linux/mm.h> /* kvfree() */
 #include <acpi/apei.h>
 #include <acpi/ghes.h>
+#include <linux/aer.h>
+#include <linux/pci.h>
 #ifdef CONFIG_X86_MCE
 /* only define CREATE_TRACE_POINTS once */
 #include <trace/events/mce.h>
@@ -1077,6 +1079,19 @@ static ssize_t erst_reader(struct pstore_record *record)
 		record->type = PSTORE_TYPE_CPER_MEM;
 		arch_apei_report_mem_error(0x2, (struct cper_sec_mem_err *)rcd->data);
 		atomic_notifier_call_chain(&ghes_report_chain, 0x2, rcd->data);
+	} else if (guid_equal(&rcd->sec_hdr.section_type, &CPER_SEC_PCIE)) {
+
+		struct cper_sec_pcie *pcie_err = (struct cper_sec_pcie *)rcd->data;
+		unsigned int devfn = PCI_DEVFN(pcie_err->device_id.device,
+				  pcie_err->device_id.function);
+		struct pci_dev *pdev = pci_get_domain_bus_and_slot(
+			pcie_err->device_id.segment, pcie_err->device_id.bus,
+			devfn);
+
+		record->type = PSTORE_TYPE_CPER_PCIE;
+		cper_print_aer(
+			pdev, AER_FATAL,
+			(struct aer_capability_regs *)pcie_err->aer_info);
 	}
 	else
 		record->type = PSTORE_TYPE_MAX;
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 4e63ac8be755..40a062546fe4 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -52,6 +52,7 @@ static const char * const pstore_type_names[] = {
 	"pmsg",
 	"powerpc-opal",
 	"cper-mem",
+	"cper-pcie",
 };
 
 static int pstore_new_entry;
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index d18ecaacd1b5..e63f51e9c22e 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -42,6 +42,7 @@ enum pstore_type_id {
 
 	/* APEI section */
 	PSTORE_TYPE_CPER_MEM		= 9,
+	PSTORE_TYPE_CPER_PCIE		= 10,
 
 	/* End of the list */
 	PSTORE_TYPE_MAX
-- 
2.41.0

