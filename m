Return-Path: <linux-efi+bounces-366-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DB6827D79
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jan 2024 04:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B85F1C2343E
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jan 2024 03:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744ED4436;
	Tue,  9 Jan 2024 03:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z1MGxOFF"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1425610A;
	Tue,  9 Jan 2024 03:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RibDTEejnEotLMDlGnnjsXYCjpY1KKIGKxppee83gKwLHliVigftT90PKgDE1vfMUhkxGzF0EG1cN7wIQz4jabA5tubKmeZPt6CGkNDvfHybykUObNfuCFmII4I8FK9Kr69tWGikQ09iqTrapCuSBpRNGxPp7PLiy+G4Q6WkSl+lIqcQeap4zodWz8g5nR13yL8YVI6HdL+IiCjluYwOPY2bALyy3ZRicCtry9vFA5ppiu2OYdhCuCvkY7mGLBrRN0micBqIsGJRkOLP3uhsNcTDPOb50Ebj8OP/7vXq/0AndPIHBICBbCvxXx/52zHKqv0BgwYvEw0zL2JTgX94zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8k3DGAVpoQzu2sff/o2jzhbFOHaCHfsfIbB115iBXOk=;
 b=AKm/0a/NmsBuHKK+AnZn0ZE4NsX/PpeEAwDeRNNe+4pLZ9fD6o9cJGG0spMj3fya8ty5Gmr7wZ8XQ95P6NC6P5qK4iUdrZlqrzsZhwwHDHGFg/lCajrX0fvlybsYYIn1G1ceoaN47NM5KMxD74Q+o/VLfbwfaDk8wsc+wM7X/2ZvOuB0QZ4KFbJagfggOd7Dg7Oao9bM4IWQ6VB5RRViQLq7II4qk/7rBohsJDoV9HMwYj5rlweK5HCqsPrgtsuCOFiEYjNDnA9PFNLyPHr6sFxyZB0NWAVg1aPKyxsfxjMFwRuCqQnDb/w46HpnImfYq7E5QX88ndEdtgoGJMjCrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8k3DGAVpoQzu2sff/o2jzhbFOHaCHfsfIbB115iBXOk=;
 b=z1MGxOFFmLijET9b7YH3/hOdvodVJ2c3yltwBCQ95pyflal2mdK82keWFZkwVkldb3uC9pqLmwEXCuP23HLXdSmoCTuj6eefWfqI2URH13Sh7mQbrBHLmXBHVu5uJfU7kU+ZyjlHmse7lO6shtwTjiWYFfnmG09Gl+Wt5obLfQU=
Received: from BYAPR02CA0006.namprd02.prod.outlook.com (2603:10b6:a02:ee::19)
 by MN2PR12MB4552.namprd12.prod.outlook.com (2603:10b6:208:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 03:48:13 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::4) by BYAPR02CA0006.outlook.office365.com
 (2603:10b6:a02:ee::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 03:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.12 via Frontend Transport; Tue, 9 Jan 2024 03:48:12 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 21:48:07 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 2/4] efi/cper, cxl: Make definitions and structures global
Date: Tue, 9 Jan 2024 03:47:53 +0000
Message-ID: <20240109034755.100555-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240109034755.100555-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20240109034755.100555-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|MN2PR12MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de3f251-1605-4364-f025-08dc10c5cdb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	okBUEisLmZx/0n7PHOINmiq2l8Qr+LCeFa849CeE7ZS+7l80F8OTlXI/opESIAmYHkQ/fe1eEvsbfWCQcRkXkuhxSJNu8bPw/yuOJ8OCzPk0bC2o001sd2wfmYxpbx3wAh1dyNFWb7jVBl2rYmIYQC5JUcaE7hBdCRjnnZMeukrSIN4KMBwO8eFGRDDfi7oUDVSwjeNm0fzoNHUz9QFQ1xXxWfPWwIUmj2DBRNws5PgZIg3+wRwFPIzZW8Clfp5CY/orknmIZnKPjcwR5vPTwBF39t2c1QXRAL8ZW4yyOBJ3XP95SsM8NCpiDMNxsc4EB6Ae2Hdlrgfh4t42fp5q7DUr83A3x6yddopIMWsQp3pKkHAyBbpvpdQvhvUn9nUWX/tpLb6MULG4wZ8dHwtE1RbVqNjdRct9+H98jNwJw15WlOaILrcnkKAEfbZO7wivaJp+JUWgqNnPVJ8YHzwfT+7Q2SflLzEQ0Gq32oVC0rLqqCcZKjIgb5RqEsvQtuTnY5RsFyWaQn+4/R8CKLcwTFab8p8LXsZHBj//ZOmwWXkmT5D4j9Gl4kx+NZ1ZzKCDpBov8COeJIP1R4ZRiKo/vXeXvUivW2qpEpPHFa26ODuyYustC19hZGNLZAFv0KLJ0AhIB/20yX4nIrlhIP44ewmxXlLSMlNB4zbQhmldrkwwLRfDYEd4ftrzOo7wx2G3j7Jo9dyppmozUBCA4msr13dFTtScvSvcNdFcBXaSFoNlJ/WlLZC87aBODOgH8ViO95QEFdVQQE4p9F2E5QU3mQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(2906002)(5660300002)(8676002)(41300700001)(8936002)(4326008)(54906003)(36756003)(316002)(70206006)(70586007)(110136005)(478600001)(6666004)(86362001)(336012)(426003)(1076003)(2616005)(7696005)(26005)(16526019)(83380400001)(47076005)(356005)(81166007)(82740400003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 03:48:12.3943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de3f251-1605-4364-f025-08dc10c5cdb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4552

In preparation to add tracepoint support, move protocol error UUID
definition to a common location and make CXL RAS capability struct
global for use across different modules.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
v2:
	No change.
---
 drivers/firmware/efi/cper_cxl.c | 11 -----------
 drivers/firmware/efi/cper_cxl.h |  7 ++-----
 include/linux/cper.h            |  4 ++++
 include/linux/cxl-event.h       | 11 +++++++++++
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
index a55771b99a97..4fd8d783993e 100644
--- a/drivers/firmware/efi/cper_cxl.c
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -18,17 +18,6 @@
 #define PROT_ERR_VALID_DVSEC			BIT_ULL(5)
 #define PROT_ERR_VALID_ERROR_LOG		BIT_ULL(6)
 
-/* CXL RAS Capability Structure, CXL v3.0 sec 8.2.4.16 */
-struct cxl_ras_capability_regs {
-	u32 uncor_status;
-	u32 uncor_mask;
-	u32 uncor_severity;
-	u32 cor_status;
-	u32 cor_mask;
-	u32 cap_control;
-	u32 header_log[16];
-};
-
 static const char * const prot_err_agent_type_strs[] = {
 	"Restricted CXL Device",
 	"Restricted CXL Host Downstream Port",
diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
index 86bfcf7909ec..6f8c00495708 100644
--- a/drivers/firmware/efi/cper_cxl.h
+++ b/drivers/firmware/efi/cper_cxl.h
@@ -7,14 +7,11 @@
  * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
  */
 
+#include <linux/cxl-event.h>
+
 #ifndef LINUX_CPER_CXL_H
 #define LINUX_CPER_CXL_H
 
-/* CXL Protocol Error Section */
-#define CPER_SEC_CXL_PROT_ERR						\
-	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
-		  0x4B, 0x77, 0x10, 0x48)
-
 #pragma pack(1)
 
 /* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
diff --git a/include/linux/cper.h b/include/linux/cper.h
index c1a7dc325121..2cbf0a93785a 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -89,6 +89,10 @@ enum {
 #define CPER_NOTIFY_DMAR						\
 	GUID_INIT(0x667DD791, 0xC6B3, 0x4c27, 0x8A, 0x6B, 0x0F, 0x8E,	\
 		  0x72, 0x2D, 0xEB, 0x41)
+/* CXL Protocol Error Section */
+#define CPER_SEC_CXL_PROT_ERR						\
+	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
+		  0x4B, 0x77, 0x10, 0x48)
 
 /*
  * Flags bits definitions for flags in struct cper_record_header
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 6ce839c59749..3a41dd5723e8 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -141,6 +141,17 @@ struct cxl_cper_event_rec {
 	union cxl_event event;
 } __packed;
 
+/* CXL RAS Capability Structure, CXL v3.0 sec 8.2.4.16 */
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
 struct cxl_cper_event_info {
 	struct cxl_cper_event_rec rec;
 };
-- 
2.17.1


