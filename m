Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944EF611B66
	for <lists+linux-efi@lfdr.de>; Fri, 28 Oct 2022 22:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiJ1UKi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Oct 2022 16:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiJ1UKe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Oct 2022 16:10:34 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DE6399DA;
        Fri, 28 Oct 2022 13:10:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WayNZEKhrmGPeFygy4THggbbAtnVnm6HEvN9YRwj0fPlVTKhfbu11Zt+iuh/VpGUQcNlFvVqlB9SzQlPRrbC6UIZRi3B2eeXkdzjictOOQcfYKhU+M7VgS730sjRI4M7Twag2kjbqLygwkQAqyw/ije89tXrZMGVxAdjflE6FX3XrXN2hVfsrRRaDuf+h7CwppZe6WL2IcELshVYBSebghyTF/9/uiqodj+/yS14UPnvYfF2d2JKVkZIzqP7nmFwaNPMDFOKt61b5FKatvGiT572jwpvkoCLuy9VrBKeMpoa9XmYkKyvnVgRdU5R5xo2JbxXQ3jX8xNlCA3R6CHdzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+5mLxQLApmSYzu+RktqGIY3usjtzz52iKTXmJ9Th/A=;
 b=AujPN5dTGteZJV15pw3RlYla1DAXE08t10/mQDqYQWmcyCJlNMQetGqLiikDpRBFj4e02oN7eK5pgPz7LuZIBwKE4+S9106SuEPKw4N9BxaEA2hWNTAVHrr9OOCtRlf2NMFbRCsU2/qlPus47y66Q2EgMSyy+UCK87DbvDCXtW1NSNnXHXy2a5nHQtbAVkcqZNTX3qIMcL7x3rNZ0xK+OKr0VcXn546ElPa6+YJqV86S3kzEEphMP8N0QrumZ50SreSbLBGQEL+d+YCZjJcLhWW6XN8JarQINPYCXz3w5tgswPY3bs5tUIegWipfRSrkiLGVyAmNazjikQ50v8km3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+5mLxQLApmSYzu+RktqGIY3usjtzz52iKTXmJ9Th/A=;
 b=eQnXN+bUI2vTAFq1D8XjdfTSsxoKEKgtvwzOLANxTORS1tU1WTGs85UCMx67m8ppIXbjql51WexHSoh+uYt81/1WGUVHnK2a07bobN4QESNOWJ76C/EQd5ckAtkmc51qOptzmANeHxzLdSbz2EbwzIKBY2jhhA6NDlcvTR+b/58=
Received: from BN0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:408:e6::32)
 by MW4PR12MB6951.namprd12.prod.outlook.com (2603:10b6:303:207::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 20:10:11 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::aa) by BN0PR03CA0027.outlook.office365.com
 (2603:10b6:408:e6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.29 via Frontend
 Transport; Fri, 28 Oct 2022 20:10:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Fri, 28 Oct 2022 20:10:11 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 15:10:09 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-efi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 1/2] efi/cper, cxl: Decode CXL Protocol Error Section
Date:   Fri, 28 Oct 2022 20:09:49 +0000
Message-ID: <20221028200950.67505-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221028200950.67505-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20221028200950.67505-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: dbe99514-a7e4-4949-4667-08dab9206b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RF1650gGx55kclIKXCzYbSF8sCCqskU2/ClHYZPAhBtJdYwoLtGexr6waWFe0octBm+p6dPSH1B99yD3MBqLjbzl2m4jbQcdqWn66QXZ3NDF94MUalz4jMESisXbVKA0xufjDj0jOQMNBiTPIe4c6qU6cSayFb5S8Tn8vvKaOhQktKa+/XfLqt18gsIplVw7txNyv8VUGGnWwto9X/5lO/mGXP+qz59UR5kyYdXDiZfJRGOoggE7JTidPdr+y9kCwNjYWp9jle7GxR9K+yS7AUanp5zcUR1EumRa8vV3qQbmkgr7CHfNI2V5bxWMecWpeT5ixjUtSIaFWhyC80O9Myi82qG7tOVjESfP51iGEWhqBcBJuw5OcDG0zNs2KgbQNNe92H1Yrt6USCSN2zag9vPT4Eq4iMMSHRvwQKsZS89n7jm/cjWbKz+iOfGouFlu34eelF+kZaxsBIq8BC+FM8ylOclCCtyH/VGk4po9hGL4WxXKkL28tsSCNs2PQPHw+EMB1szBKxgx38arPriGoiQ/6OdS6RIwhtsGncN9EOumjhmS52tINPWxJGmDVVTA8M3fCqMxXjwu9uOI1VDx9DZwHw2kobahGewwbVawNP6cVOO0Uklx3IUuog65c16tEP3NnYPX5jH0OZVMLH766r7jzlkDlflk6EoEMbjtk0E0sjhBcvtbMNCW8r468Pi+p1sg8Mqp3R9EUmIFBF5ul5dRyHK/lIk3M+uFZciZChKN2x/tBbTY/Ih9avgULq+RjzpfbnpxYKhs4rjx3ivgospqMrhGxR/nmRTVofsHTnCxJWY6C0+Q06l1rnG1gXzA
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199015)(46966006)(40470700004)(36840700001)(7696005)(36756003)(8676002)(26005)(356005)(2906002)(8936002)(40460700003)(86362001)(36860700001)(82310400005)(4326008)(5660300002)(81166007)(82740400003)(6666004)(40480700001)(70206006)(478600001)(7416002)(70586007)(41300700001)(336012)(83380400001)(426003)(1076003)(47076005)(2616005)(316002)(16526019)(186003)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 20:10:11.2526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe99514-a7e4-4949-4667-08dab9206b15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add support for decoding CXL Protocol Error Section as defined in UEFI 2.10
Section N.2.13.

Do the section decoding in a new cper_cxl.c file. This new file will be
used in the future for more CXL CPERs decode support. Add this to the
existing UEFI_CPER config.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
v2:
	Added all fields for decoding. Printed DVSEC and Capability ID.
	Added additional CXL Agent Types based on UEFI 2.10.
	Named the unnamed union to agent addr.
	Changed field name from agent_addr -> rcrb_base_addr.
	subsystem_device_id -> subsystem_id.
	Commented why different union elements are relevant.
	Provided other comments wherever necessary.
---
 drivers/firmware/efi/Makefile   |   2 +-
 drivers/firmware/efi/cper.c     |   9 ++
 drivers/firmware/efi/cper_cxl.c | 152 ++++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper_cxl.h |  66 ++++++++++++++
 4 files changed, 228 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/efi/cper_cxl.c
 create mode 100644 drivers/firmware/efi/cper_cxl.h

diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 8d151e332584..4f332de54173 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -19,7 +19,7 @@ endif
 obj-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= fdtparams.o
 obj-$(CONFIG_EFI_ESRT)			+= esrt.o
 obj-$(CONFIG_EFI_VARS_PSTORE)		+= efi-pstore.o
-obj-$(CONFIG_UEFI_CPER)			+= cper.o
+obj-$(CONFIG_UEFI_CPER)			+= cper.o cper_cxl.o
 obj-$(CONFIG_EFI_RUNTIME_MAP)		+= runtime-map.o
 obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)	+= runtime-wrappers.o
 subdir-$(CONFIG_EFI_STUB)		+= libstub
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index e4e5ea7ce910..181deb9af527 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -24,6 +24,7 @@
 #include <linux/bcd.h>
 #include <acpi/ghes.h>
 #include <ras/ras_event.h>
+#include "cper_cxl.h"
 
 /*
  * CPER record ID need to be unique even after reboot, because record
@@ -595,6 +596,14 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 			cper_print_fw_err(newpfx, gdata, fw_err);
 		else
 			goto err_section_too_small;
+	} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
+		struct cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
+
+		printk("%ssection_type: CXL Protocol Error\n", newpfx);
+		if (gdata->error_data_length >= sizeof(*prot_err))
+			cper_print_prot_err(newpfx, prot_err);
+		else
+			goto err_section_too_small;
 	} else {
 		const void *err = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
new file mode 100644
index 000000000000..6c94af234be9
--- /dev/null
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UEFI Common Platform Error Record (CPER) support for CXL Section.
+ *
+ * Copyright (C) 2022 Advanced Micro Devices, Inc.
+ *
+ * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
+ */
+
+#include <linux/cper.h>
+#include "cper_cxl.h"
+
+#define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
+#define PROT_ERR_VALID_AGENT_ADDRESS		BIT_ULL(1)
+#define PROT_ERR_VALID_DEVICE_ID		BIT_ULL(2)
+#define PROT_ERR_VALID_SERIAL_NUMBER		BIT_ULL(3)
+#define PROT_ERR_VALID_CAPABILITY		BIT_ULL(4)
+#define PROT_ERR_VALID_DVSEC			BIT_ULL(5)
+
+static const char * const prot_err_agent_type_strs[] = {
+	"Restricted CXL Device",
+	"Restricted CXL Host Downstream Port",
+	"CXL Device",
+	"CXL Logical Device",
+	"CXL Fabric Manager managed Logical Device",
+	"CXL Root Port",
+	"CXL Downstream Switch Port",
+	"CXL Upstream Switch Port",
+};
+
+/*
+ * The layout of the enumeration and the values matches CXL Agent Type
+ * field in the UEFI 2.10 Section N.2.13,
+ */
+enum {
+	RCD,	/* Restricted CXL Device */
+	RCH_DP,	/* Restricted CXL Host Downstream Port */
+	DEVICE,	/* CXL Device */
+	LD,	/* CXL Logical Device */
+	FMLD,	/* CXL Fabric Manager managed Logical Device */
+	RP,	/* CXL Root Port */
+	DSP,	/* CXL Downstream Switch Port */
+	USP,	/* CXL Upstream Switch Port */
+};
+
+void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err)
+{
+	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_TYPE)
+		pr_info("%s agent_type: %d, %s\n", pfx, prot_err->agent_type,
+			prot_err->agent_type < ARRAY_SIZE(prot_err_agent_type_strs)
+			? prot_err_agent_type_strs[prot_err->agent_type]
+			: "unknown");
+
+	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS) {
+		switch (prot_err->agent_type) {
+		/*
+		 * According to UEFI 2.10 Section N.2.13, the term CXL Device
+		 * is used to refer to Restricted CXL Device, CXL Device, CXL
+		 * Logical Device or a CXL Fabric Manager Managed Logical
+		 * Device.
+		 */
+		case RCD:
+		case DEVICE:
+		case LD:
+		case FMLD:
+		case RP:
+		case DSP:
+		case USP:
+			pr_info("%s agent_address: %04x:%02x:%02x.%x\n",
+				pfx, prot_err->agent_addr.segment,
+				prot_err->agent_addr.bus,
+				prot_err->agent_addr.device,
+				prot_err->agent_addr.function);
+			break;
+		case RCH_DP:
+			pr_info("%s rcrb_base_address: 0x%016llx\n", pfx,
+				prot_err->agent_addr.rcrb_base_addr);
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (prot_err->valid_bits & PROT_ERR_VALID_DEVICE_ID) {
+		const __u8 *class_code;
+
+		switch (prot_err->agent_type) {
+		case RCD:
+		case DEVICE:
+		case LD:
+		case FMLD:
+		case RP:
+		case DSP:
+		case USP:
+			pr_info("%s slot: %d\n", pfx,
+				prot_err->device_id.slot >> CPER_PCIE_SLOT_SHIFT);
+			pr_info("%s vendor_id: 0x%04x, device_id: 0x%04x\n",
+				pfx, prot_err->device_id.vendor_id,
+				prot_err->device_id.device_id);
+			pr_info("%s sub_vendor_id: 0x%04x, sub_device_id: 0x%04x\n",
+				pfx, prot_err->device_id.subsystem_vendor_id,
+				prot_err->device_id.subsystem_id);
+			class_code = prot_err->device_id.class_code;
+			pr_info("%s class_code: %02x%02x\n", pfx,
+				class_code[1], class_code[0]);
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER) {
+		switch (prot_err->agent_type) {
+		case RCD:
+		case DEVICE:
+		case LD:
+		case FMLD:
+			pr_info("%s lower_dw: 0x%08x, upper_dw: 0x%08x\n", pfx,
+				prot_err->dev_serial_num.lower_dw,
+				prot_err->dev_serial_num.upper_dw);
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (prot_err->valid_bits & PROT_ERR_VALID_CAPABILITY) {
+		switch (prot_err->agent_type) {
+		case RCD:
+		case DEVICE:
+		case LD:
+		case FMLD:
+		case RP:
+		case DSP:
+		case USP:
+			print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4,
+				       prot_err->capability,
+				       sizeof(prot_err->capability), 0);
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (prot_err->valid_bits & PROT_ERR_VALID_DVSEC) {
+		pr_info("%s DVSEC length: 0x%04x\n", pfx, prot_err->dvsec_len);
+
+		pr_info("%s CXL DVSEC:\n", pfx);
+		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, (prot_err + 1),
+			       prot_err->dvsec_len, 0);
+	}
+}
diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
new file mode 100644
index 000000000000..86bfcf7909ec
--- /dev/null
+++ b/drivers/firmware/efi/cper_cxl.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * UEFI Common Platform Error Record (CPER) support for CXL Section.
+ *
+ * Copyright (C) 2022 Advanced Micro Devices, Inc.
+ *
+ * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
+ */
+
+#ifndef LINUX_CPER_CXL_H
+#define LINUX_CPER_CXL_H
+
+/* CXL Protocol Error Section */
+#define CPER_SEC_CXL_PROT_ERR						\
+	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
+		  0x4B, 0x77, 0x10, 0x48)
+
+#pragma pack(1)
+
+/* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
+struct cper_sec_prot_err {
+	u64 valid_bits;
+	u8 agent_type;
+	u8 reserved[7];
+
+	/*
+	 * Except for RCH Downstream Port, all the remaining CXL Agent
+	 * types are uniquely identified by the PCIe compatible SBDF number.
+	 */
+	union {
+		u64 rcrb_base_addr;
+		struct {
+			u8 function;
+			u8 device;
+			u8 bus;
+			u16 segment;
+			u8 reserved_1[3];
+		};
+	} agent_addr;
+
+	struct {
+		u16 vendor_id;
+		u16 device_id;
+		u16 subsystem_vendor_id;
+		u16 subsystem_id;
+		u8 class_code[2];
+		u16 slot;
+		u8 reserved_1[4];
+	} device_id;
+
+	struct {
+		u32 lower_dw;
+		u32 upper_dw;
+	} dev_serial_num;
+
+	u8 capability[60];
+	u16 dvsec_len;
+	u16 err_len;
+	u8 reserved_2[4];
+};
+
+#pragma pack()
+
+void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err);
+
+#endif //__CPER_CXL_
-- 
2.17.1

