Return-Path: <linux-efi+bounces-368-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFB7827D7F
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jan 2024 04:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7733028537C
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jan 2024 03:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E156422091;
	Tue,  9 Jan 2024 03:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g8hBj9h2"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6386103;
	Tue,  9 Jan 2024 03:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYlENBw1BCAuJLPpdXtPPApooNkpCMs7DhQx/KfhasU/wWQQWBfE/73YE10yVjcJxFskgiRYV0Stl8GHbXuKoksggcjsDf4CT4Gh3ZflKL48tSw3k2eS8PdvfszQJn/3RIiVaRqHoq9uE5gU4NBTMYsBXbLbv4//xmC4X/WZ4Nj7KAqyorEI3igoMpNgNfFMqxOSgS2eeyDCtnIFVzjzchItZ6iFVV714GYzXYtO6CDIbzVQGTE0onF0L1ygX+JG3pculXMM6q+g0/0zegW07+GuQa7YYz3esG03ZfFf67GrchuheFQ4nsdpGgTEuan8WFaAEcdOIXviI29Kejy/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+lZ6Hck4PZRU6EFtX0mGE39ZKzSIU72woekA5a9KdU=;
 b=S2ClJTzjePiiiwFpPLx4ZOZIqU/kGu2VutPRy0l+vF2K7Yem1nDvSmcu7kKLNP1EdeJyvw0/ON6tuLIAaSERWFWzvmTXU2xbSYxEfGE8E94wYsdw7t+71D18LcbiV1KKOuXYqzDaaiNGQoCCee2qVdiAxYAFKbraDaK6zvL7QxSAY8R7o1Jp9aphJPG1ofIXMz9/s+jXO1UtdUYCxs/ZDt37nhVMuDakGWIE2sR7ZWIDgOkxrpsQVHr2qlGBEjIFxbhr+Zsie7f7xsXtEQr/KyjG6S9yV4mb5KBOaW3iQ7QenzFJVi8Wsh5e/RAb6nZMgm1bLgpVnf/QXpfYguV4Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+lZ6Hck4PZRU6EFtX0mGE39ZKzSIU72woekA5a9KdU=;
 b=g8hBj9h2P3fYnDDqReqlB1SY4t1J7aYqGsLYp4dnnpTPLLa+6LGxPrl823TaGyljTMgkyfF9ifIH4y/9nxY8GE1ehRIL2Fnf7NqwJHlemWdqeK22hEz1FcRPj8ASzIPNmMq7SFCyeDRCEBSeNfhsfaMwdskYXYPBgCanr97eAq4=
Received: from BYAPR02CA0027.namprd02.prod.outlook.com (2603:10b6:a02:ee::40)
 by CYXPR12MB9442.namprd12.prod.outlook.com (2603:10b6:930:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 03:48:12 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::95) by BYAPR02CA0027.outlook.office365.com
 (2603:10b6:a02:ee::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 03:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.12 via Frontend Transport; Tue, 9 Jan 2024 03:48:11 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 21:48:06 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 1/4] acpi/ghes, cxl: Create a common CXL struct to handle different CXL CPER records
Date: Tue, 9 Jan 2024 03:47:52 +0000
Message-ID: <20240109034755.100555-2-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|CYXPR12MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: 03470624-80b6-47d5-08d5-08dc10c5cd50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8cijwS1MLX/Z7O/MZyDOG9iMtfxYfZq2ez7p6jdMlN5+PCaPZkiT9Q1X2lBz/NJKsWYc3LlqbGbQt6T2A/gakXZbKwbqJCzlCQzXzOrmQj7iTiYQzlaJ3thKGFB/8QVz6iJAbr0VOzYEc5YXerQRicp2l/6GXwvLA6c9zVZqcX49rCjCTr1VYMAL6nltHl7tk4Yhn7hDDf1kkPCMh6HJFHWLHI2j6FJk75DyDlQBGb76Z5KGPsWkgTGRbKHg4NDRiMS337YJDuaNdLiv2IFVZN3T7rzQC907UM4BsaU7UIw9ZisnvPxMY9wRBntlrzaZPI7M+496fs/8+ULNw3a1D8dXPl2fZ0SXEvNdoQMmklsl1SCTYvZK6IHGOAv2fPFTnc644rTMxoXIzAffPl8iqZU/yrc0XjOrWK3RBrT2hnyfkHL8BUPvVN8NBIlJ9/ilocyJsEVDVjuumjE2JxtA+1Tq4KfoLIlEgWV3ZZ4cYevJhNeePIAQOIoBtkoUMZJ4NVyyDdK+H65L/BEtDcxuToceCZQUdHA5hwaaoDu17bYekXm+TRF8jxeJn49No9ECNiqT6hcYg5PpU1z+CyPQR6+IUGhHQU36AO3v9aR2aOxMRV2WLTuOGROjTe++WOf5pvw6E3hoxBwgw5mnYso+CGjipsV0L5eHlerPaa4yT7f02ST1skRy2WzkGfmhH/85tfx59tca6JblKSMcT4dbJB1UQ/dF4bsZXdrvmgNx4h6bxCVIG5XBARJYLw+SB/orHj1iBgl5MjKdAJxF3hBQog==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(36840700001)(46966006)(40470700004)(2616005)(1076003)(336012)(426003)(26005)(478600001)(6666004)(7696005)(47076005)(36860700001)(83380400001)(41300700001)(5660300002)(8936002)(70206006)(54906003)(110136005)(8676002)(16526019)(4326008)(70586007)(316002)(2906002)(86362001)(356005)(82740400003)(81166007)(36756003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 03:48:11.6600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03470624-80b6-47d5-08d5-08dc10c5cd50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9442

Currently defined cxl_cper_callback interface between CXL subsystem and
GHES module is just confined to handling CXL Component errors only.

Extend this callback to process CXL Protocol errors as well. Achieve
by defining a new struct cxl_cper_event_info to include cxl_cper_event_rec
and other fields of CXL protocol errors which will be defined in future
patches.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
v2:
	cxl_cper_rec_data -> cxl_cper_event_info
	data -> info
---
 drivers/acpi/apei/ghes.c  | 6 +++++-
 drivers/cxl/pci.c         | 8 ++++----
 include/linux/cxl-event.h | 6 +++++-
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index aed465d2fd68..60b615d361d3 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -693,6 +693,10 @@ static cxl_cper_callback cper_callback;
 static void cxl_cper_post_event(enum cxl_event_type event_type,
 				struct cxl_cper_event_rec *rec)
 {
+	struct cxl_cper_event_info info;
+
+	info.rec = *(struct cxl_cper_event_rec *)rec;
+
 	if (rec->hdr.length <= sizeof(rec->hdr) ||
 	    rec->hdr.length > sizeof(*rec)) {
 		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
@@ -707,7 +711,7 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
 
 	guard(rwsem_read)(&cxl_cper_rw_sem);
 	if (cper_callback)
-		cper_callback(event_type, rec);
+		cper_callback(event_type, &info);
 }
 
 int cxl_cper_register_callback(cxl_cper_callback callback)
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b14237f824cf..1ad240ead4fd 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -972,9 +972,9 @@ static struct pci_driver cxl_pci_driver = {
 
 #define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
 static void cxl_cper_event_call(enum cxl_event_type ev_type,
-				struct cxl_cper_event_rec *rec)
+				struct cxl_cper_event_info *info)
 {
-	struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
+	struct cper_cxl_event_devid *device_id = &info->rec.hdr.device_id;
 	struct pci_dev *pdev __free(pci_dev_put) = NULL;
 	enum cxl_event_log_type log_type;
 	struct cxl_dev_state *cxlds;
@@ -996,11 +996,11 @@ static void cxl_cper_event_call(enum cxl_event_type ev_type,
 		return;
 
 	/* Fabricate a log type */
-	hdr_flags = get_unaligned_le24(rec->event.generic.hdr.flags);
+	hdr_flags = get_unaligned_le24(info->rec.event.generic.hdr.flags);
 	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
 
 	cxl_event_trace_record(cxlds->cxlmd, log_type, ev_type,
-			       &uuid_null, &rec->event);
+			       &uuid_null, &info->rec.event);
 }
 
 static int __init cxl_pci_driver_init(void)
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 17eadee819b6..6ce839c59749 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -141,8 +141,12 @@ struct cxl_cper_event_rec {
 	union cxl_event event;
 } __packed;
 
+struct cxl_cper_event_info {
+	struct cxl_cper_event_rec rec;
+};
+
 typedef void (*cxl_cper_callback)(enum cxl_event_type type,
-				  struct cxl_cper_event_rec *rec);
+				  struct cxl_cper_event_info *info);
 
 #ifdef CONFIG_ACPI_APEI_GHES
 int cxl_cper_register_callback(cxl_cper_callback callback);
-- 
2.17.1


