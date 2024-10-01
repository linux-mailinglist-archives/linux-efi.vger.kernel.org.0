Return-Path: <linux-efi+bounces-1858-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B70698B19A
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2024 02:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3541C223A1
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2024 00:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7092868D;
	Tue,  1 Oct 2024 00:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pjt9HjSb"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADA61C693;
	Tue,  1 Oct 2024 00:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727744014; cv=fail; b=M0bFO+wE5ysiN43QEhp3WS/j9+EOMgiQ3v4KR4Z7cdM5wIg0ykbujGm9bI8krJl4Iu4TPO0umZYDQI6yEBrKFVO0vHvtFDFEa0mpWWyGqtArB5nEMYxGA+culKNasybja5SZ8MMYkL+mKYI8bt00uUjPmxoaooUweMu9LeHYvV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727744014; c=relaxed/simple;
	bh=0o97FpLM8GbLFnnWWbfVHqUvsZyqL28J8hkhOxArgHM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p+pV9mNoX4CL1aKkEjl0D9E0rCCUAgkOLl1bp56YdY2hTP+v4xfMc5LWM/UjT8lIWJpWTvDU7J7TeU2Dc8MO6T+TSPshMX+xEyGM+N660SsNeUUZQX3Qb7qnuSxsNvIeHPKov/aJ722keYDyetx2wyyLGfTcF40c/OHwYzWK7jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pjt9HjSb; arc=fail smtp.client-ip=40.107.100.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ShiK1ZxKwBexMTfPfx9QpGttfiaiWlwmUIXtmoHvWU0JooyOPRBUJcBA9MC8rO/SkhwtnpAXLB967j95mBsrUQZN8yksSyWOSTtoo5bErWaZyhwLfIPCBg5Sz8+Cmfh+OB+L+ZC9sg8guCQYDSVK50m2HDEfO3pAvbIGDHLL/lwZTG6bDc5d2gLxxlihG7qiYWgksNrrxnOR3x7RUrhmssLvFjvHmiaUNK+Jou4Lxh/t80R+Vfe3KtczG5iTupaZUqkg6gfjy7qyH+ySKaLx2I0jZFcU327SBgyVnt5l946qfNbkRuQL8DzXeyw61bZya1KSndGVCYb34oRsbxXbbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wOpDXuU+oQ/QD/oJDgCn4/FIjHkTyJ/5g/uqTeiyeI=;
 b=hJqSUvPmnnkpIjgmTmuoOWjrFYSHpRMRTeS9kuyX1+RYsARiQB5oTrzsKFqNFzevmJ+Kd2rZ/mL4dkQTamVVz6FkQ/68tB2xu8lz4QT2Jw5E6tmp9dH0BCPZIWH64RHSocAfrsBl7k2d/8Pon7rhYJuS8HJ7s9oRMg+3iRiGocNMSKZtPzLYLh8t8hWWpF1Nv5aVXaTDyCrvgVYHjODUvDLdd6xm0ZbkvdkCD2KdJq+HogTniNIZ2bbWiwWL6oJzNWsA/qv/w/VRMPS5wQa9+LkznSGQx7MVPLcUlLtEKn/ei/P8GSMRjY3yNtNMO3tChaMYuZGtzLmSHXjtiPFNXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wOpDXuU+oQ/QD/oJDgCn4/FIjHkTyJ/5g/uqTeiyeI=;
 b=Pjt9HjSbV5jpfCgs7WwQlkvMIQGjsbNHZXWrvmE/AsPRhl+C8rOIiRnZME5kJT8LnCRGScYL5b4E3VVV2ZdtmUD4kxjVn1SZfH2LLiyly+57Oq5ZOmWjfsujHG3SJ176gDeMKMVpy8yW30hodMAkcpMLr6S0p0DOKtjhZcw/OZk=
Received: from BYAPR05CA0011.namprd05.prod.outlook.com (2603:10b6:a03:c0::24)
 by LV8PR12MB9360.namprd12.prod.outlook.com (2603:10b6:408:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Tue, 1 Oct
 2024 00:53:28 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::41) by BYAPR05CA0011.outlook.office365.com
 (2603:10b6:a03:c0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Tue, 1 Oct 2024 00:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 00:53:26 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 19:53:21 -0500
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
Subject: [PATCH v2 2/4] cxl/pci: Define a common function get_cxl_devstate()
Date: Tue, 1 Oct 2024 00:52:32 +0000
Message-ID: <20241001005234.61409-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|LV8PR12MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: 038b02c9-fa2e-4b78-635e-08dce1b375a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RaAJGGEAg1ZiU5VAKsQxVJA8VhICxh7hFeILiD8KuuJHNRU1MSf+zolRTS0v?=
 =?us-ascii?Q?vgQmvxIVeYuhyC7NOBG6BdTX7b7NXPMYsRb2aGdrllUCBihPKiax05KrdcOM?=
 =?us-ascii?Q?xNNP8PCdAIja58jT2pIWlehPZavlzFLDmd33Lw2Vp+hjV2iKVIfkv5qfN5OF?=
 =?us-ascii?Q?qlS1/rx1KSqRwBZXeh5ta8q3v4YVKkGxuv2BTKWkNIrM2UmCDXOFXG30JFUv?=
 =?us-ascii?Q?91BW1WETogwQQRMv4d+9LlcVV3zwrmWizljHFbDqOr2ghVH/HeYZ+nacW1Mf?=
 =?us-ascii?Q?iq22pWyKG8Z3R0TUaw3dQk7bA6kkOaBLRArflmUMyK5Ox0ItqMgRX9mD7Muz?=
 =?us-ascii?Q?lSLei1U2NJz6BWEbHDkdMhspXb/Kyp6HJ4zcegsrKIanrUDHrxiwKrZyUDAh?=
 =?us-ascii?Q?ksV3IQB4u1Eha9V3+XoLjXMzX64j2mYzRqyLHz+fisFp/KOX1DklX5zj8uAb?=
 =?us-ascii?Q?pO+CO5Ld3KtgqTiC125pVz/yU2sl0wjhM2tYRYuLrgDUxNi59i/r5P798DBH?=
 =?us-ascii?Q?a6U2OhXqwGunuDgmvuysO6MdhDntsXGuMr8nUuk80+HQ274U4CrmAzEiteht?=
 =?us-ascii?Q?LTqoWek0RhUWx4hznVZ9y8qqt2t5OIimmlHiew4nA1ELV/7GpUOIgSaiHv+h?=
 =?us-ascii?Q?53wrFPcGQKTyRqSU2nE1AbinUaMGTeMe9m+N5448KZWCU+5qGUDx5nBZFH+G?=
 =?us-ascii?Q?+9u7YigS+iZ0iUrd5rMA5CjnKU0/oewg0Ls8QAUzSeR9IoUmE4AqDbltMsp+?=
 =?us-ascii?Q?+BhS9Q7JoMA2c4Evvl7mHrZF4XfrxPTiG4FBMwnVG3skA7s7RjuDJeviPejU?=
 =?us-ascii?Q?hgbsPOo66sQftUjGdqMJYQBHXtAUQ22UsmF+3+Pu5yqpZ3weiLbHZnkiXFD5?=
 =?us-ascii?Q?oZ2SBKzEX/3iFSRASq58CEg5P7l2H4EUGou2N20NckoAs1C5i7qARL2XFPap?=
 =?us-ascii?Q?Jot8uNu05gBZMLqJFgop5Oyru/BOmdF31wsy36J2b8D6dyT5mvaPf67beFKt?=
 =?us-ascii?Q?VkYd7uTscPV0naM3cFZZo20GXqgzbzZa6ATjkasus7YvrBUYgG5l4rNhn1/g?=
 =?us-ascii?Q?+zhN3PURBpjNrQmdWIcJ1K0auFjnTN2Le4Gbpnyh9sez7Kp4RCA6dQ6g7QIH?=
 =?us-ascii?Q?EifMrwWnHexzufSwazUikrwA9QFhbM/l4lav3yvG672ZEHkl92YUbYF/uDpy?=
 =?us-ascii?Q?S/wU8P1qUyKM2xNAiOqYivtc5aHWr3iGckpqk5IajKZKyfkiW9GNLThmB/sw?=
 =?us-ascii?Q?NVhZRqTDZmO5pvGtQImqZBoQ8pQQYXovKOQuAgOQPgSBpTnl/JJPVPmN8C7X?=
 =?us-ascii?Q?Al5cCWhgiJlBlKD+QBc7tGx+85QsZkjRDVTLoGOQhlMv4PWOBHEBXmztjFFV?=
 =?us-ascii?Q?Cgicwv2ByViT5Yal9o0O2+fn+iWu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 00:53:26.7530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 038b02c9-fa2e-4b78-635e-08dce1b375a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9360

Refactor computation of cxlds to a common function get_cxl_devstate().

The above function could then be reused in both FW-First Component and
Protocol error reporting and handling.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
v2:
	Refactor before adding trace support.
	get_cxl_dev() -> get_cxl_devstate().
	Cleaned up get_cxl_devstate().
---
 drivers/cxl/pci.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 37164174b5fb..915102f5113f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1021,32 +1021,38 @@ static struct pci_driver cxl_pci_driver = {
 	},
 };
 
+static struct cxl_dev_state *get_cxl_devstate(u16 segment, u8 bus,
+					      u8 device, u8 function)
+{
+	unsigned int devfn = PCI_DEVFN(device, function);
+	struct pci_dev *pdev __free(pci_dev_put) =
+		pci_get_domain_bus_and_slot(segment, bus, devfn);
+
+	if (!pdev)
+		return NULL;
+
+	guard(device)(&pdev->dev);
+	if (pdev->driver != &cxl_pci_driver)
+		return NULL;
+
+	return pci_get_drvdata(pdev);
+}
+
 #define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
 static void cxl_handle_cper_event(enum cxl_event_type ev_type,
 				  struct cxl_cper_event_rec *rec)
 {
 	struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
-	struct pci_dev *pdev __free(pci_dev_put) = NULL;
 	enum cxl_event_log_type log_type;
 	struct cxl_dev_state *cxlds;
-	unsigned int devfn;
 	u32 hdr_flags;
 
 	pr_debug("CPER event %d for device %u:%u:%u.%u\n", ev_type,
 		 device_id->segment_num, device_id->bus_num,
 		 device_id->device_num, device_id->func_num);
 
-	devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
-	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
-					   device_id->bus_num, devfn);
-	if (!pdev)
-		return;
-
-	guard(device)(&pdev->dev);
-	if (pdev->driver != &cxl_pci_driver)
-		return;
-
-	cxlds = pci_get_drvdata(pdev);
+	cxlds = get_cxl_devstate(device_id->segment_num, device_id->bus_num,
+				 device_id->device_num, device_id->func_num);
 	if (!cxlds)
 		return;
 
-- 
2.17.1


