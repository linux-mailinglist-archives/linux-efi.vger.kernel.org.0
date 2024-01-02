Return-Path: <linux-efi+bounces-287-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A70D0821E63
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 16:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526501C22247
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 15:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627CF14F8B;
	Tue,  2 Jan 2024 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TsxJTumu"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C552B14F61;
	Tue,  2 Jan 2024 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Scsfsv1JHdzG9rd565b0WydYDfK3cJtq8SjB+lbmDRtgGwhFqXF/qAxOCRwOBiFWTRdfJeqnxQXdsEiRHrwHdZNZ9xR5coNUHnX9/fznzOVuM6APS2OSqkLXEBjdsnFfz8r/srbKEN1BFocKO4nhjxdmSnOnuzJTmhKodvT418147BY/Ii/li4MnrA8Uv5VZhllFK03FT+mxerdcIEt8sMsOt4yvVlAzDpkW0Wb8Qb0uodK6fmVuaeAQinGpDBiSD9po90lW3Yu9FSlKpmjGYjvqN2tBea283M96eSYQy5j7kFfnZFimnDY6/xy5aAe5TdH5tn8332Sula84E1BUAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCf6i0pQ13Se4kCA/oDvgCU5ej6KAv4znZ0KXb0YPaI=;
 b=U1e2es49raOKNf5wv9kPRSZQMlw38BvifnJ1LiFGqtj1ozML3GcAf5Yi+lWqUZ5J6v/Q2NZhCkNL0bpQEgnWDdy575w3c429BgTFRRTYI9ziTp8k9LXj+03lfzgn5aecsxTMczLmy/4mla8i/o6MgNLVYKlCykuc/IakLq5mmsIL1IkMKdLZ/50vGl6lFAa+XGOg3hrMmT9ioFQCf3bDNrhTG6fEb8kxCYGgux7Um17SOeFghWQdGkf10ZF6XP0mpfOnvQGcYGJ4l5UrZdEANCHVd8dKCBoQ7Yc/y8WWUHcIsTRcdHbx7hYC2hrOLHVSB7tKOMzk7rrHz96mrNs/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCf6i0pQ13Se4kCA/oDvgCU5ej6KAv4znZ0KXb0YPaI=;
 b=TsxJTumuwLv996ASvsAiCcpanyXg+niikOV7LcNmbQl7Vpm/mSa+pNQXigQF9FM/Sj59BflzXeOtE5zkXn4ZEEQryBvhTRFuGtlnpBnMP/TJ/q4jkIR0axLLol3gEu+rz8R8oEjL4cYMATVZs1QflswdetM8ikHm3l4juBugaiE=
Received: from BY5PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:1e0::20)
 by SJ2PR12MB8927.namprd12.prod.outlook.com (2603:10b6:a03:547::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Tue, 2 Jan
 2024 15:09:47 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::6e) by BY5PR03CA0010.outlook.office365.com
 (2603:10b6:a03:1e0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24 via Frontend
 Transport; Tue, 2 Jan 2024 15:09:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 15:09:47 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 09:09:45 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH 2/4] efi/cper, cxl: Make definitions and structures global
Date: Tue, 2 Jan 2024 15:09:31 +0000
Message-ID: <20240102150933.161009-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240102150933.161009-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20240102150933.161009-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|SJ2PR12MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: b387f06e-0676-476c-f94b-08dc0ba4dc04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vyv0GAP6DSQFTHq42Jc5wxlJW6EJ2jkxr1CPKknTO5EE986eKSJh3YBdgtnA2Io4zHIU6RVmQLREF83K0fbj/U7UO5e7hIAXLG4Ugpm2Ze+BuKmrUtKn31UOAawB9EXIkrB0uAuHdpt3mNrElA/nZElEbmhLEDLHdxanpIZNtmnhQEEA7UA7e/T1cX21X4I5YOUov5OASntkzdBLFXPDqwXIo1uH5yCE5ogJ9I2oPfbjZVGphREz55ddJ/hOvWnN9iHAs06P4TOG1thiI++FZStAM2TyfXDWd7A3odpcxe8CGmMfs9Nun6zyDkTocGo0vw/8ChePVvuaooPZVYfq4PK7EOI0eEbIEKjet/9HzOWQFbOKGvM1ch7ZMjLgUaQDPe38Two1GG3YOlHSktg9W1mXNYOGMrTGdlaUwHoFRT3m1xxSKcZEDkV+oFJgH3NBCy1o1KH6+idhWoWw8egCbrcbWiPt+GkLZ58TpVJciZTZErhnRWpxQXiEeXdNesx1ROe/wwefddtPoOK4CeT7z/DgGKJaQ0/qXzzjGvO4KgCd/9guDmxe5qTQmLF+e939BawJU/rXU9/Loka10LIeIIAmnaUWICSAtX5JnRkrIc/Xxwvh8UHKVD+yKCufmCXYZCTzSbIwnalpvXZtxIXqfTKeu+YOxysop9SugmAQDw73a3u4NSysr/tElVdPwP2T2DxAaW4tYjR/kPJvEaLPvf6gSq1daGb9XjYhMpKxRqkYxLuVzfp/dFg5J1g5seZuOIP7zIn/z1v2zNJM/7tKQA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(4326008)(8676002)(2906002)(8936002)(83380400001)(336012)(16526019)(26005)(1076003)(426003)(5660300002)(81166007)(2616005)(356005)(36860700001)(478600001)(40460700003)(7696005)(6666004)(40480700001)(47076005)(82740400003)(36756003)(41300700001)(70586007)(70206006)(86362001)(316002)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 15:09:47.2373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b387f06e-0676-476c-f94b-08dc0ba4dc04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8927

In preparation to add tracepoint support, move protocol error UUID
definition to a common location and make CXL RAS capability struct
global for use across different modules.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
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
index afa71ee0437c..90d8390a73cb 100644
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
 struct cxl_cper_rec_data {
 	struct cxl_cper_event_rec rec;
 };
-- 
2.17.1


