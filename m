Return-Path: <linux-efi+bounces-2177-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 605169D1CA5
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2024 01:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212FE28269B
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2024 00:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E752445C14;
	Tue, 19 Nov 2024 00:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q8FW+b04"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C5F20328;
	Tue, 19 Nov 2024 00:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976774; cv=fail; b=jhbVlabwKjq+5rv6gu+wZJRy7OQOLdcT/GHVPy54+ZJrqYuxkoDgTixcFTQrDhQtLzlr802IB8PD5fuXUxsXS0OU0N7bUK6HyOau2cmbVBVvXgRa01U/yWjLZLNbHmesmhlZZ//mcKxZHicBhEx5xiSi4FErPEPWfXZ7mGl4PaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976774; c=relaxed/simple;
	bh=9v81WZmZ/T2poKWZAMxeQf1HUmSbnJ2SqMaPAlC5dLE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZcpXwCW3ReRD2vqDafAELNg+0lyv0Fo1T0AaEJGbnd3NtRr8WWyfuuoa96DE6ZjelQUMAMh0p2G2T3UpVx4ForTJ4ieuq/+nWRKOUP0spKiFyQU/z4FSBwzKTyvm4gOO72XeaNM3qTKqgcbifEs2iP2A9eevll967rkvqiPlYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q8FW+b04; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTITgkr2rBOsW2W5f9hA3HaMvVVERRsITdutGwZF7N5X53CEGy4CUSNTRnajd89SJ8v1iNIgq/1CUCLocsyBKJEJwIAH+iaIBaGol1UlhMS9l+/0Qnm92R4qiXHreBHw+O2YTsVFVh8BIbU/DTC7McwyS4POd7A9EfNw1BCT+S46aYnDBgEvUGmUcgnPjvvDakiC9Qn1o/JFXCvWURxDRkNqe+bz0xQfp1mWS5Za2XgR1svLH1Wm1mUV9p3tjDO0tEnG9qtDksETXF2Ys7seA/0Z7lWmKZcnFAJpOUco8TI8yIJAiHMw7k9ET/9ky8A8l5iYI7tHYgAjtD1i62Abgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pGk3pbn3bep9eghYVDP2ymR7MxQhQPU+Njsnmv5iBU=;
 b=rHZP12gQr3Coh8i1w4nPlcZxh0WlJ1PJZSgSAyyW7nVFvjDUujkvKI4KZPxcF7n9ztaoBCJv6lWsRjGk7fRASS9VAsIOCMi5bMqauh0YpAfa8XK2sZzXyzPYw8wuAKsX8IrvpgGFc4SJY68wEifbJtib/XRu/eQYwIAGvsAfZhZavJdahQYbHcfeF5b18Ug3VWa1JVMOrMxUjjkr2z51be/CUScfNmzxKng5Gc4AsMUkR00qhCeyrpIWTG19iLOojcwBxUreKKC915goBGngGP8FK0e5YqcOvj9kJ0YEyPU8W3jG2hxfKYzVY67UirNu84aqL9XLzrR2ksjJBmF14g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pGk3pbn3bep9eghYVDP2ymR7MxQhQPU+Njsnmv5iBU=;
 b=Q8FW+b04mR+hnT+g/s6Al7DQx1HB69i65VzF7QYGA7LrEP0EhKTZVjy4wB6kXF67Xyw1xQRGbZE43bScwo9jQKbuW6sEByvg+TUQxldAa3zxo+vbP0f0alIWzvJPaJLbzwPmB01eHQsfqXXZ/MKqLzUqBfQ6bo/vDK3QXK2qoVw=
Received: from DM6PR10CA0014.namprd10.prod.outlook.com (2603:10b6:5:60::27) by
 DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.21; Tue, 19 Nov 2024 00:39:30 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:60:cafe::d8) by DM6PR10CA0014.outlook.office365.com
 (2603:10b6:5:60::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
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
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 00:39:29 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 18:39:27 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v3 5/7] acpi/ghes, cxl: Refactor work registration functions to support multiple workqueues
Date: Tue, 19 Nov 2024 00:39:13 +0000
Message-ID: <20241119003915.174386-6-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|DM4PR12MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd0046d-6f5c-46de-6b25-08dd0832a0c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lQeXPwnYuf9zxQD8ctEG3t0+xyAxhWb2xiq5Qy37VGWwgyTTugIlDmFwJMXy?=
 =?us-ascii?Q?REfmnt+nil44SyuF6jmu661E18gBlvXI3egrUgA26+LlZJE/vIz83cQJ9b0I?=
 =?us-ascii?Q?xecGU4qXS6mkE2aZwkSEk0F4fyooLbmwmvdommiN00gQnCvVPE7Fh1f8aHev?=
 =?us-ascii?Q?inD/hFg8jpbc+wXqfC9OHzla3ldVOiQOd/a4QCZ38PN18v31h3jfmC85lHzD?=
 =?us-ascii?Q?BlkU3rjeAdYURY1siGBLEnvITReD1UcUcvKQBgg8DxVW0Xe5d0PdCmsjcmCS?=
 =?us-ascii?Q?bvKiO+U9jXpEvIFA8kwvdugAmj7w6sKX0o2Mw9Qs8C35eCBHsmbuu/LPXbKs?=
 =?us-ascii?Q?c316GJPRKaAuJL5O5XHPg4pfUvBJvfYzigUk3/yqcgCPLJ8TepqNgOwMKYjO?=
 =?us-ascii?Q?bXIEbRKYAZbp1wbDQtVTkjqzxL17gMV4btRoP0CqyE75tNyRitB2z8xQlMgf?=
 =?us-ascii?Q?KY4K316Ky5nggqjgLzuudoBxMb4/xJAofRTdtf49sgOc8fE21wFsN9BMMMSv?=
 =?us-ascii?Q?KpEA4LkxBKeoU3ZG5mSxk9hQiGgzdVe6uD4+3QuCJeTJEN7hD4owwX955nFX?=
 =?us-ascii?Q?QJWzfsdpgMGU74iOsFpE8dgmHSQ5LQfAx9JBj8cVQ6pulz9c3H4l998yNQ+5?=
 =?us-ascii?Q?4F/r6JYVm7V0wQZkUeBb+Fh1rZ9NcpS4TatChHa2VRgZ0SpvCCF/pJxdT/+Y?=
 =?us-ascii?Q?DxpYHj1JcSveR1knVDTtbrPZEMcY+7Z0imqRAMieSrgC3tv/Y6HblYupY+E8?=
 =?us-ascii?Q?7489I0nS3y12Ceo6VIZba0hjX5KHXR5cF7RkDeyOIpsK8s8fc3TcN/6vk6V8?=
 =?us-ascii?Q?Degp/wXbKAo/AePOYZxSgecAg7qF83K7n4pSTiDx809xmh8+98O4y3u4YYlt?=
 =?us-ascii?Q?S0LXH4TmkTJnaMTB6F7+CfSqJX38fQEyIZnElHBIQ4SPsrF4sE/jg7GjwQxk?=
 =?us-ascii?Q?ds4wbpaLFvPduGC1HqmfagvAMo/3GD6OkynsnqZV6qlGFI94dWvj1c+Inexp?=
 =?us-ascii?Q?rugSDas0cC5U7F+oD62gkBzKb3cG0j7uE35DhvXJqTG8WfpfP11nbeDaoxl7?=
 =?us-ascii?Q?LYGHoPgatoQzYLg0FhCTGAACIh0b83He9T13EuAC8UpscIsBO1t/VI93O0VU?=
 =?us-ascii?Q?EBxnM4XBNcebp9SsMCTc2S/NSBxivhmGh4R8KrfxYFUzOsf4ffrGH9pqV6TM?=
 =?us-ascii?Q?hFnVSW5B0iGDmzDMmZecQZWBOE/iFo4tMGvgxGiV3jptNhq5MFjLT+GDmFuT?=
 =?us-ascii?Q?Yqdt1K0Wz8nHHs3be79TgEGY37hjvtfCGjVB9PXQpiN8QLhHf1WYMNxMqasZ?=
 =?us-ascii?Q?j7LYP6zYaHEMSzvZfWEol8V0lUc/9zRVbTdvzeUOCOM/CtbWMa9nrMNT5rAP?=
 =?us-ascii?Q?4/dfOkrWWvtnVrDlvG39NtOyCPYfK4kZZDGi18nGeG7mn/Fr3w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 00:39:29.4089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd0046d-6f5c-46de-6b25-08dd0832a0c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769

Refactor the work registration and unregistration functions in GHES to
enable reuse across different workqueues. This update lays the foundation
for integrating additional workqueues in the CXL subsystem for better
modularity and code reuse.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/acpi/apei/ghes.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 082c409707ba..62ffe6eb5503 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -717,26 +717,42 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
 	schedule_work(cxl_cper_work);
 }
 
-int cxl_cper_register_event_work(struct work_struct *work)
+static int cxl_cper_register_work(struct work_struct **work_ptr,
+				  spinlock_t *lock,
+				  struct work_struct *work)
 {
-	if (cxl_cper_work)
+	if (*work_ptr)
 		return -EINVAL;
 
-	guard(spinlock)(&cxl_cper_work_lock);
-	cxl_cper_work = work;
+	guard(spinlock)(lock);
+	*work_ptr = work;
 	return 0;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_cper_register_event_work, CXL);
 
-int cxl_cper_unregister_event_work(struct work_struct *work)
+static int cxl_cper_unregister_work(struct work_struct **work_ptr,
+				    spinlock_t *lock,
+				    struct work_struct *work)
 {
-	if (cxl_cper_work != work)
+	if (*work_ptr != work)
 		return -EINVAL;
 
-	guard(spinlock)(&cxl_cper_work_lock);
-	cxl_cper_work = NULL;
+	guard(spinlock)(lock);
+	*work_ptr = NULL;
 	return 0;
 }
+
+int cxl_cper_register_event_work(struct work_struct *work)
+{
+	return cxl_cper_register_work(&cxl_cper_work, &cxl_cper_work_lock,
+				      work);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_register_event_work, CXL);
+
+int cxl_cper_unregister_event_work(struct work_struct *work)
+{
+	return cxl_cper_unregister_work(&cxl_cper_work, &cxl_cper_work_lock,
+					work);
+}
 EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_event_work, CXL);
 
 int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
-- 
2.17.1


