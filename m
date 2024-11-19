Return-Path: <linux-efi+bounces-2173-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BC79D1CA0
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2024 01:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631202825A5
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2024 00:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195E51D554;
	Tue, 19 Nov 2024 00:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xpNosrC6"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C522AD4B;
	Tue, 19 Nov 2024 00:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976773; cv=fail; b=r8OXc1mxrPhrepMZqzdpEl/OIl8Mn/PE1Gs0PCoR6Gn97gRg1s4dvr84i4yuSq5QhiytYQDWAxp9MsFXmUYqxWmX8dPeJqVESjpPlDt/PL/OxrxVnLLAcy1Kl9F4Ji7HjpQSPRceModi99uWUAIxyrygLONMv7+IE65qu5VMcyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976773; c=relaxed/simple;
	bh=xevecpJPjINvi3ZaLxeNKDHouEUWIqEG8Fg7YiuwSbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yi2K7mCxf6RVC/sKTW5e180WFYXIBuPnnIMolDrsj/ohk9Fe209oq8aNW/+ho4rmO7mGGDjt6GKml4JKuBgdMMlDL/DW7AXK47+jOT/SaH8HfXB2qe2zURHruhPwnjXQe3wz45YWy8FbaSmA4EoDx+nSMLh9UNzSioi/FYFaS7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xpNosrC6; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMoSWtbTmqasm/4rF+qw+WIxC/cGJvsYSnMxTiQSw6gEvg+6t7LzARyBVS5Tco9KHHi29JMEqrgy39qoaNLy/DuvUljnHHUsKrD/+p3YBCS4UsDsBkSBYo+het0irPcDTQ+VCSs8UWLdF1VFEkL5RKWoU9TyIu+tiC6yKBPlSb6b6UzdMWj9Z1KXzLpMaskZ2RiWYy7kylZz1nvGIWoyrdQgsYSmap28o7vYcgLv3uBK03PMzsCVt0w/esu8yBbsxzbtlBibZpzoe0UeEmoPzyPEI63jMf5/fIjzNMbDGjfRXd/zXp8uAZfCODshWVecyz/4vCwu/k/3N045u4cwMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zQIBz+47OqiDnEKvRI36bBP4W+/g4/b3gJ6i5hh6wI=;
 b=NyLdIfkrL6hOXC7819eIdjLMFEoZfOO/KhXvOSBBXJUIPX+zqbdyumF0LvLat55nJ/8Ym6KMvew/sz6l8H7vArzjy3zRf54Xb2XDmE5sJGVsy34HRMWkv0B9+U20ZrNKBqSE7t47v53Z+neBBBxMuwprNZrsTdyfNDQuV5xbKtluMG9nAeMsxJU9UPQcR/KNHSjFA03TpJA30u9h93vg7D7TeuFdp+ZAfkvqOwGPoIt8kABzdOQW7H7Oy8+f5SA/U1coQ0liQHV248aLXCSaOA5UlXYHE1we7uBpa4LwuSXJqidak310LhSthrfidu0XWtsFO7pBslAJOo6aw2lkXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zQIBz+47OqiDnEKvRI36bBP4W+/g4/b3gJ6i5hh6wI=;
 b=xpNosrC67wAdj1M3EUDO/e5bG+EDZlO9p3elXJou4gbWV3HKLke1Tnl41NewjE7tHthvzvUBAGADlEdCAqQmpoX3jqaUJXMtBtTtKbvkBJPs3ut6KvYkBXmqYROZf6xc1Tnm9MUeBkTJiygf8LDrPoO+I6sm9TKs2aMiRNH9n54=
Received: from DM6PR10CA0032.namprd10.prod.outlook.com (2603:10b6:5:60::45) by
 CH3PR12MB8877.namprd12.prod.outlook.com (2603:10b6:610:170::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 00:39:29 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:60:cafe::dd) by DM6PR10CA0032.outlook.office365.com
 (2603:10b6:5:60::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Tue, 19 Nov 2024 00:39:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 00:39:28 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 18:39:26 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v3 4/7] acpi/ghes, cxl: Rename cxl_cper_register_work to cxl_cper_register_event_work
Date: Tue, 19 Nov 2024 00:39:12 +0000
Message-ID: <20241119003915.174386-5-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241119003915.174386-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20241119003915.174386-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: 07205ac9-2fe9-48f0-a968-08dd0832a080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gh50Yc3q94jd5vblHHbtuxabCrUhV8PtX+MXsx+eAmVitzHsePWH+TjFVNnM?=
 =?us-ascii?Q?TUm4/wZppx1ZtXJoqmksGFG3CPQCI2sD4BC8JfJqPUqOuCn2e82IK+PMoivI?=
 =?us-ascii?Q?DVTX/W0+0pWeqN81z+KbC36zG8HQyZIv799CFzcVotD1MA6y7/bP1OYYKBgL?=
 =?us-ascii?Q?sU7gNgOitLu5ok30q2UQ0oBrGZxinnnW9ndCVkUawBxhg+FKfQejT98iQ6G0?=
 =?us-ascii?Q?0XRd5l3zyVLsaWfqcwP1M8KaCJpQbKV1l9SIpORl2JpY0OlO1sv+fDI7LXn9?=
 =?us-ascii?Q?nerxxoKP3AyV3YCCMWmL4jCiK7vAJuRPaljg0J5UUnj7n/wLo07hWFKrYbga?=
 =?us-ascii?Q?LY6eXlOzEI20MDwrzvA5JutVxd/XgEytyWp6JtZ2T983Kyht9Gd+1TPogF8C?=
 =?us-ascii?Q?ryxQ6+uxoHFPKMiaCmx/HYDrhcz8cbNq50sb+6CbbMOfV1iJNaLxwscZCZWP?=
 =?us-ascii?Q?8vavKhFq4BIX/ZYTy3GeO04w8hzlsIAklkzL8qKSMh3tny82pV80R/rDSUdH?=
 =?us-ascii?Q?MAgAhR6a7Ex0Rm1Q3YkcE2IP5diQPPOMOhURDosa7mLgOQZwjIczfvAMTYVb?=
 =?us-ascii?Q?YCFFa7mPDJTMVfcTyatEb2E65gZUqSzF4BpfNZVIEXYQUI1heKosrJqOuXYW?=
 =?us-ascii?Q?T5dL6ZXa4Sg3bU9o9OvD3lb4+l0bXEJwR2daY5pEud2u9NK/DwSqxW+2sBHN?=
 =?us-ascii?Q?l/q1t2vJXCkCHFlYIV8Ro1Zfv8CQBqnSqrcXXYMP9MJlN8X8+O4jua08j1HK?=
 =?us-ascii?Q?jI6FFSU36wjot3D6hZwQRWx1A9fj2mPwjEyIhtnUQMsxkINXt1mL5Vc5iUlq?=
 =?us-ascii?Q?zv/cUHv77RiA5V0kLdAx1h3fM+nKLZztK2Kfl/63Av0ZZztWdv3MpawTLRGY?=
 =?us-ascii?Q?8FuE7iUtwbgQxJGZm2Q+oSFZAckc/1jpxH5x62AB6pIqNBefiSLtxYOFHH0I?=
 =?us-ascii?Q?3dplS8RSVWDOmJt0ON90BLsc4/isXESdCwfFujSaAv8L1LpCNVTfcrnY7wnH?=
 =?us-ascii?Q?jc82b9FR3sGk1XN96lZvoK74dNKIjpTTu78Wk05Rev2KGVt44pi2vuNWmgL4?=
 =?us-ascii?Q?3l34FdTHwTt3jDPVuC1/wZU5yCZmbiOEddZX5Jdym36UTIZvtL8P/ZgyzGiC?=
 =?us-ascii?Q?e3oU3LABqvpKGtMHIalF9h5CA6q336NnRfRszgMUaQrTTZaWv3qOlz/LO/nH?=
 =?us-ascii?Q?N07AVnkncQoSu+Nrf0nC9n2C1P0EguHmTIUj10pWR8NFER6lBan6DB/Uvrnf?=
 =?us-ascii?Q?oKDIAy8nxtqn0oyp4HjzofVf5qM4238qDxyqXL5+oNcPyMFSlrWlgA1rYNxr?=
 =?us-ascii?Q?FFpns2q4fFuVMyX5z5n1doYbHXC9RQMRrjBat2vD+sM1oLk3WJPqsgEbS49m?=
 =?us-ascii?Q?m9MZaqj6qI8cYlVeE+Im/uPYkSL+v36AzuwsgY8ZtFwLVRikGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 00:39:28.9558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07205ac9-2fe9-48f0-a968-08dd0832a080
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877

Rename cxl_cper_register_work() to cxl_cper_register_event_work() to
better reflect its purpose of registering CXL Component Events based work
within the CXL subsystem.

This rename prepares the codebase to support future patches where
cxl_cper_register_work() will accept generic pointers for Protocol Error
workqueue integration.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/acpi/apei/ghes.c | 8 ++++----
 drivers/cxl/pci.c        | 4 ++--
 include/cxl/event.h      | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ada93cfde9ba..082c409707ba 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -717,7 +717,7 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
 	schedule_work(cxl_cper_work);
 }
 
-int cxl_cper_register_work(struct work_struct *work)
+int cxl_cper_register_event_work(struct work_struct *work)
 {
 	if (cxl_cper_work)
 		return -EINVAL;
@@ -726,9 +726,9 @@ int cxl_cper_register_work(struct work_struct *work)
 	cxl_cper_work = work;
 	return 0;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_cper_register_work, CXL);
+EXPORT_SYMBOL_NS_GPL(cxl_cper_register_event_work, CXL);
 
-int cxl_cper_unregister_work(struct work_struct *work)
+int cxl_cper_unregister_event_work(struct work_struct *work)
 {
 	if (cxl_cper_work != work)
 		return -EINVAL;
@@ -737,7 +737,7 @@ int cxl_cper_unregister_work(struct work_struct *work)
 	cxl_cper_work = NULL;
 	return 0;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_work, CXL);
+EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_event_work, CXL);
 
 int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
 {
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 188412d45e0d..88a14d7baa65 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1075,7 +1075,7 @@ static int __init cxl_pci_driver_init(void)
 	if (rc)
 		return rc;
 
-	rc = cxl_cper_register_work(&cxl_cper_work);
+	rc = cxl_cper_register_event_work(&cxl_cper_work);
 	if (rc)
 		pci_unregister_driver(&cxl_pci_driver);
 
@@ -1084,7 +1084,7 @@ static int __init cxl_pci_driver_init(void)
 
 static void __exit cxl_pci_driver_exit(void)
 {
-	cxl_cper_unregister_work(&cxl_cper_work);
+	cxl_cper_unregister_event_work(&cxl_cper_work);
 	cancel_work_sync(&cxl_cper_work);
 	pci_unregister_driver(&cxl_pci_driver);
 }
diff --git a/include/cxl/event.h b/include/cxl/event.h
index 66d85fc87701..992568b35455 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -233,16 +233,16 @@ struct cxl_ras_capability_regs {
 };
 
 #ifdef CONFIG_ACPI_APEI_GHES
-int cxl_cper_register_work(struct work_struct *work);
-int cxl_cper_unregister_work(struct work_struct *work);
+int cxl_cper_register_event_work(struct work_struct *work);
+int cxl_cper_unregister_event_work(struct work_struct *work);
 int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd);
 #else
-static inline int cxl_cper_register_work(struct work_struct *work)
+static inline int cxl_cper_register_event_work(struct work_struct *work)
 {
 	return 0;
 }
 
-static inline int cxl_cper_unregister_work(struct work_struct *work)
+static inline int cxl_cper_unregister_event_work(struct work_struct *work)
 {
 	return 0;
 }
-- 
2.17.1


