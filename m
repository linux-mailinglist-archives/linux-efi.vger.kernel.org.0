Return-Path: <linux-efi+bounces-288-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6967821E64
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 16:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5781C221DA
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9064714F95;
	Tue,  2 Jan 2024 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jBydjWTa"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E884D14F76;
	Tue,  2 Jan 2024 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tp8cIMTk1X5QkLMki05loigo/pQQRHFlPlf6jRs6e2poZ3K2vuw1ODVUVriyemM5kdlY0/P1OXfmUQJu3TzRSadJxPTTPvLVBoxRyG+1xjsnpnjocI/+rifukDVW6bgoFOSKSUtXREQLNGfxudZ8TwgkeSnt+mjkcngsCK2i70lb9hCO/K3FQkGRd9tc/q3lhCpf5rqPONEF+Dl9eV54DC/3h4+2wbb/nGwyKlWlcveumJeMiie3u/ok/Z+XNU4460LHdRF+QvPSKBJipH9aH+MkI02qLz3NHx3SvQhNFM8aPwytJRucRa2jQQageFYp6Yp2thK2AXo5DPtl7llKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uIXByfuXZNhqufR/2BVURLNCfcT7j5BNP3N+9t8hhA=;
 b=l4MmFaiMpJccPTxT5ilxBXC1djU229vdaIO1j8Sabc1dT2ADbtXUws3WpsDwl8WWA3PSI7pQogGGK8DtAYZerSdtPZUSnMCIurK2/a/3v4mkLuwvZsq/dTo6coU0Siiyc1Y97NyeOxPLXulK9nhe97z1k2sXRtrM1PjiVM4g6sZ+IP3lg/ubiWjyzyKvGQgemmU212T2rO32eNB7eSs8UNPEYCXr8DMVCT1jnIloicuRWEX0mkwBKJohAY7U59duj5/MiwTWQFn+EAvI7DGOC6hdr/bMbg3isRNGtB9rYUPhkOqjv6Rowj/B8WLyL2ltFr7RhL7Y5iooB2FPmxLktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uIXByfuXZNhqufR/2BVURLNCfcT7j5BNP3N+9t8hhA=;
 b=jBydjWTaZrFypZ42UoRrd5yWRjKWvBu+xf+m0PiORr24+W0T1FzxNh/7zXO5ALlkuC0koWzQg48LoxIv20GX3gpv2JEj8+mNerkQS1/3NFhp7cXl0iAb7BvS/2UyodXKxbgnQ2Evv6p//GK6YbMrdZyyEqhn3bRWvhZxEld3N80=
Received: from BY5PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:1e0::33)
 by SJ0PR12MB5471.namprd12.prod.outlook.com (2603:10b6:a03:300::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 15:09:47 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::4) by BY5PR03CA0023.outlook.office365.com
 (2603:10b6:a03:1e0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21 via Frontend
 Transport; Tue, 2 Jan 2024 15:09:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 15:09:46 +0000
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
Subject: [PATCH 1/4] acpi/ghes, cxl: Create a common CXL struct to handle different CXL CPER records
Date: Tue, 2 Jan 2024 15:09:30 +0000
Message-ID: <20240102150933.161009-2-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|SJ0PR12MB5471:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b2ff009-4d8c-48a3-c0c4-08dc0ba4dbcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pp1IhMiSufChTnXtid1+68dIVlxZRHsih/93eyMKO2RyxQmiDfUIifr1QoW+/Tw3RIWBEQtdwdHJrfmH3QnxPRP5eerfh+xc9ONJYbZ1Wk+YeHPH3ukQLN6SJowpvKIlTbLQiarV4f/lxk/AS3sTUy3q105J4G4tWJrPgkm3lBgNeOAMiikmY9uTVey9ycdEYRE6q2ZqAWX893km0lB40kBbg1hTe0UdBdTsfvGuXBLUFqdJ6fFq5cRyBrJIOppFBYDiYbOlWpwAZ5F7bS1BJn2LKL3wVu4KE//vkVNTwjhkC4e2usHzrIjPWdeuYwMoHoSGqIug4OWpCXCsynyU3PHS0ZCp4bo2POnMYlINv4cEjkbjEMP4qJkwJZ62AmjQq6baB95zdpQXLoE++a/YRiyn+2oydj7k5My5ghcJj8FBZcAYj2B/3c21/2HZqdfJCRzyznpg1NMp9+XH7VJH/S3oRABkpzHkFJlPUkp6UAH6OHRnFKrgcr9/eV6pfmAwiGFfVFFVny0nAcy87RYLLDJnNvgZ/YFtBIxeX77T1fbRhb10bm8v5zubBdLcPkRZw+WXRgZiBrlobods1Q/jIbF4CHt7rQz5Zih0eVqgA7BOzCYs6ALA3ei0miGLKpVH0rzu7t1RslUPpuiNPQTHSgiVGKmgY4QnECq33iHV0dp9LdP90Ew/UnNx7fMGuIFzAdFgdokcziOdX7qKmWTD8K6NM1Np7+QaKd0DFHaFNMMPGDv58QnhniwelkhZbs60GO7ApOHoJEIvlGEb0wdahA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(82310400011)(186009)(1800799012)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(2906002)(8676002)(8936002)(4326008)(5660300002)(36756003)(54906003)(316002)(86362001)(478600001)(40460700003)(40480700001)(41300700001)(7696005)(6666004)(16526019)(1076003)(426003)(26005)(2616005)(336012)(356005)(81166007)(47076005)(70206006)(70586007)(110136005)(82740400003)(83380400001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 15:09:46.8623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2ff009-4d8c-48a3-c0c4-08dc0ba4dbcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5471

Currently defined cxl_cper_callback interface between CXL subsystem and
GHES module is just confined to handling CXL Component errors only.

Extend this callback to process CXL Protocol errors as well. Achieve
by defining a new struct cxl_cper_rec_data to include cxl_cper_event_rec
and other fields of CXL protocol errors which will be defined in future
patches.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/acpi/apei/ghes.c  | 6 +++++-
 drivers/cxl/pci.c         | 8 ++++----
 include/linux/cxl-event.h | 6 +++++-
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index aed465d2fd68..d6a85fbc0a8b 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -693,6 +693,10 @@ static cxl_cper_callback cper_callback;
 static void cxl_cper_post_event(enum cxl_event_type event_type,
 				struct cxl_cper_event_rec *rec)
 {
+	struct cxl_cper_rec_data data;
+
+	data.rec = *(struct cxl_cper_event_rec *)rec;
+
 	if (rec->hdr.length <= sizeof(rec->hdr) ||
 	    rec->hdr.length > sizeof(*rec)) {
 		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
@@ -707,7 +711,7 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
 
 	guard(rwsem_read)(&cxl_cper_rw_sem);
 	if (cper_callback)
-		cper_callback(event_type, rec);
+		cper_callback(event_type, &data);
 }
 
 int cxl_cper_register_callback(cxl_cper_callback callback)
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b14237f824cf..7edbd53357e5 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -972,9 +972,9 @@ static struct pci_driver cxl_pci_driver = {
 
 #define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
 static void cxl_cper_event_call(enum cxl_event_type ev_type,
-				struct cxl_cper_event_rec *rec)
+				struct cxl_cper_rec_data *data)
 {
-	struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
+	struct cper_cxl_event_devid *device_id = &data->rec.hdr.device_id;
 	struct pci_dev *pdev __free(pci_dev_put) = NULL;
 	enum cxl_event_log_type log_type;
 	struct cxl_dev_state *cxlds;
@@ -996,11 +996,11 @@ static void cxl_cper_event_call(enum cxl_event_type ev_type,
 		return;
 
 	/* Fabricate a log type */
-	hdr_flags = get_unaligned_le24(rec->event.generic.hdr.flags);
+	hdr_flags = get_unaligned_le24(data->rec.event.generic.hdr.flags);
 	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
 
 	cxl_event_trace_record(cxlds->cxlmd, log_type, ev_type,
-			       &uuid_null, &rec->event);
+			       &uuid_null, &data->rec.event);
 }
 
 static int __init cxl_pci_driver_init(void)
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 17eadee819b6..afa71ee0437c 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -141,8 +141,12 @@ struct cxl_cper_event_rec {
 	union cxl_event event;
 } __packed;
 
+struct cxl_cper_rec_data {
+	struct cxl_cper_event_rec rec;
+};
+
 typedef void (*cxl_cper_callback)(enum cxl_event_type type,
-				  struct cxl_cper_event_rec *rec);
+				  struct cxl_cper_rec_data *data);
 
 #ifdef CONFIG_ACPI_APEI_GHES
 int cxl_cper_register_callback(cxl_cper_callback callback);
-- 
2.17.1


