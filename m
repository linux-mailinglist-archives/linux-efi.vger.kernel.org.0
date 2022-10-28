Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21288611B6A
	for <lists+linux-efi@lfdr.de>; Fri, 28 Oct 2022 22:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiJ1UKj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Oct 2022 16:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiJ1UKe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Oct 2022 16:10:34 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E56E3A480;
        Fri, 28 Oct 2022 13:10:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGyisMAvyQjQTFPBzryCTFGGEAQcqJ9/BfujaimghMq5H5deW8LlsZcb8NbXau1Z+b5eONWSxvT+bY0YZ6Z7nxmAaQ9Qq+vyLMdy1Qv+fYrZ5v/Sz81pS/sjU+b/6DF+lnUkV0lD18PyPmlyfN5oPe+ypP2Lw9I3VWK0R4l16pYwpchY0NC5H/FG6WFJ0y6DfEu50sMZ30Huigt2BULOKMpgQxAnP9Lmen/u+kjaMc1I4eQnep8+BfU3oysEX0tS8J2/dCIIKLtr9PH7KtdsS7YNLfTeJ9IpbQwCnxFOVNAX+/nUJWjAG1enLXO5ectlmKg09bAY3YsSpWG5FerTGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgIks/5e2L7SGL75n5XQmVcEliBuicbNwe2cZ/I2nPo=;
 b=aTg2RGCCROg0uPlDy3oAsEbLYxyeRbmnV0tnCUCAMesenheNZJyZtZ1fdrHM2XdauAGJRAphzprTPZtFxBUZt3fC/4n2yi0glprYSRMwWGep2haeE+3EXvfYKdfSygAIk0+btI21Ci+Blh/kMggKX1bsYwEcM3+/0De8adZyhOb0K3XKqae+uZoB6mFFO+5RQQEU6bjtFeiM3BHP4wBvwNaeH+ORUhFu5K//CAcj+JaiIFUqTJOg6q687AvycAqVgaPt1rjrAg2eFjRVaKHs4rL16Qpeq/tUMsq2VPB2gxItbiC1waQLBI+Ncv3b3AkFWm2tNdxuH8ZZYicaTUQenQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgIks/5e2L7SGL75n5XQmVcEliBuicbNwe2cZ/I2nPo=;
 b=kCjXAJSw1/qeH0MvsrL4flDa5f4EADY1Ym+bw32cNof+pXXyRZN5VVsclZn7n0dqWVtMqCaTdzr8ZapSWddFM0pyewSMcQliRtGG9xP5fmg45MsZ8sMCxIloU7t5bKf8/vH9qzo2LasynhxNQ2wUMXVLnHcZzwfmOEi4dHm1B0Q=
Received: from BN0PR03CA0009.namprd03.prod.outlook.com (2603:10b6:408:e6::14)
 by SJ0PR12MB6688.namprd12.prod.outlook.com (2603:10b6:a03:47d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Fri, 28 Oct
 2022 20:10:12 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::39) by BN0PR03CA0009.outlook.office365.com
 (2603:10b6:408:e6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.29 via Frontend
 Transport; Fri, 28 Oct 2022 20:10:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Fri, 28 Oct 2022 20:10:12 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 15:10:11 -0500
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
Subject: [PATCH v2 2/2] efi/cper, cxl: Decode CXL Error Log
Date:   Fri, 28 Oct 2022 20:09:50 +0000
Message-ID: <20221028200950.67505-3-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|SJ0PR12MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: bacefbf0-b8c1-4eac-6310-08dab9206bb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZkjeZJTboYrnWgOELcfkqQBwOnJlqR7/oZexOWQeEM8UDvNVgNY/sUMv3LAjsCmz/awNKzSyAYQTLzV4PtVLpxgrJfI4byxTsHXUs/uuSiYC5nE9GFLKtmaPwe8q2RSHJHzZ4+e8Xv4wj/CfGYzHmG04x4o9ybaMyuz0sHsiWj44vwwEQqNXPEPF+Ubysv7smA9bZRUFOyHg1c4rO/zSlt/HZORfkmXVBA7rFfobgIQFoMLXO0/FVmxHBHF7seU6Z+hTOvq9lwZ9A+fWkGcKO43HwijC7kwlkimIpKL3L0Vo4uPDSluxMPhEyhMFQ/+JNG12aVGHpQBAQ5733Vkj7au4rATsUE2PCqVezs5etL5woV56vOuxsoB3QTIVjAIasjGeUMuErn2LStkREM83T7UQukRMpxWcb3TCehVe4+QOVTAxNjkEB7jiCBSMOCmWES1BrXPcQQJ4BLc5NQIlJEu8cY+nus4lcEIe6bDkVFZUU5nxStl4vAX9wReaYFGTWVzhpY2+PSc7IHPFUg2m0xmtwsEIi8kVUR0BLg8qf820qTyjANd48rJ3nwnAWi/J89xAv58e4+AZUO8GB4yBeS7rSJ9hmvE+TiPhvUq9NNkIWAY1PqytepcD3ypi7cNuTxgwSL5p73eyqwfrdBHLzUOlvlNXRsh6Xo/6xpzxT3Kv2j8eUyyhNQUDjDVYArpoqnJLnGt5JVMxJ++ggGlWfYRklb6al+tKyOUn+Fn4XGZcZTe7KVnoASqx9OahShSIqIFFV41sZ2DRVgSXK3Fw2OUHSe4UISyc8rjYGCWeGR46mp5JF2d2QiGi7GmyGQJs
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(7416002)(40480700001)(2616005)(16526019)(70586007)(81166007)(70206006)(5660300002)(7696005)(186003)(336012)(426003)(36756003)(36860700001)(478600001)(4326008)(86362001)(8676002)(1076003)(47076005)(82740400003)(8936002)(41300700001)(40460700003)(110136005)(82310400005)(54906003)(316002)(6666004)(2906002)(356005)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 20:10:12.3150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bacefbf0-b8c1-4eac-6310-08dab9206bb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Print the CXL Error Log field as found in CXL Protocol Error Section.

The CXL RAS Capability structure will be reused by OS First Handling
and the duplication/appropriate placement will be addressed eventually.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
v2:
	Printed all fields separately.
	Printed cap_control.
	Prefix cxl_.
	Provided the reference.
---
 drivers/firmware/efi/cper_cxl.c | 27 +++++++++++++++++++++++++++
 include/linux/cxl_err.h         | 22 ++++++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 include/linux/cxl_err.h

diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
index 6c94af234be9..53e435c4f310 100644
--- a/drivers/firmware/efi/cper_cxl.c
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -9,6 +9,7 @@
 
 #include <linux/cper.h>
 #include "cper_cxl.h"
+#include <linux/cxl_err.h>
 
 #define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
 #define PROT_ERR_VALID_AGENT_ADDRESS		BIT_ULL(1)
@@ -16,6 +17,7 @@
 #define PROT_ERR_VALID_SERIAL_NUMBER		BIT_ULL(3)
 #define PROT_ERR_VALID_CAPABILITY		BIT_ULL(4)
 #define PROT_ERR_VALID_DVSEC			BIT_ULL(5)
+#define PROT_ERR_VALID_ERROR_LOG		BIT_ULL(6)
 
 static const char * const prot_err_agent_type_strs[] = {
 	"Restricted CXL Device",
@@ -149,4 +151,29 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
 		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, (prot_err + 1),
 			       prot_err->dvsec_len, 0);
 	}
+
+	if (prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG) {
+		size_t size = sizeof(*prot_err) + prot_err->dvsec_len;
+		struct cxl_ras_capability_regs *cxl_ras;
+
+		pr_info("%s Error log length: 0x%04x\n", pfx, prot_err->err_len);
+
+		pr_info("%s CXL Error Log:\n", pfx);
+		cxl_ras = (struct cxl_ras_capability_regs *)((long)prot_err + size);
+		pr_info("%s cxl_ras_uncor_status: 0x%08x", pfx,
+			cxl_ras->uncor_status);
+		pr_info("%s cxl_ras_uncor_mask: 0x%08x\n", pfx,
+			cxl_ras->uncor_mask);
+		pr_info("%s cxl_ras_uncor_severity: 0x%08x\n", pfx,
+			cxl_ras->uncor_severity);
+		pr_info("%s cxl_ras_cor_status: 0x%08x", pfx,
+			cxl_ras->cor_status);
+		pr_info("%s cxl_ras_cor_mask: 0x%08x\n", pfx,
+			cxl_ras->cor_mask);
+		pr_info("%s cap_control: 0x%08x\n", pfx,
+			cxl_ras->cap_control);
+		pr_info("%s Header Log Registers:\n", pfx);
+		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, cxl_ras->header_log,
+			       sizeof(cxl_ras->header_log), 0);
+	}
 }
diff --git a/include/linux/cxl_err.h b/include/linux/cxl_err.h
new file mode 100644
index 000000000000..629e1bdeda44
--- /dev/null
+++ b/include/linux/cxl_err.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022 Advanced Micro Devices, Inc.
+ *
+ * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
+ */
+
+#ifndef LINUX_CXL_ERR_H
+#define LINUX_CXL_ERR_H
+
+/* CXL RAS Capability Structure, CXL v3.1 sec 8.2.4.16 */
+struct cxl_ras_capability_regs {
+	u32 uncor_status;
+	u32 uncor_mask;
+	u32 uncor_severity;
+	u32 cor_status;
+	u32 cor_mask;
+	u32 cap_control;
+	u32 header_log[16];
+};
+
+#endif //__CXL_ERR_
-- 
2.17.1

