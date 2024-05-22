Return-Path: <linux-efi+bounces-1059-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A71C8CC3DB
	for <lists+linux-efi@lfdr.de>; Wed, 22 May 2024 17:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4BB1F22ECF
	for <lists+linux-efi@lfdr.de>; Wed, 22 May 2024 15:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A361C6A8;
	Wed, 22 May 2024 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ow+TUh+C"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C441823B5;
	Wed, 22 May 2024 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716390544; cv=fail; b=T9cQ96KTiW5UWmaps9frwvZJkSN8N07G/OkzF88e4pIq7Tej5ubM9A+uN0YMEacxG7jZJ57As7H9yNhzldSg53qTObV9AcN7PzlLUGZZtWd+NQkVd2PQ9lLagIquQAHAHt86UlLzCbIv2+h0kJLhxkcOIkuEZZdZ2R6Q++TwzLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716390544; c=relaxed/simple;
	bh=9wDG5uIm+GKm5hNG4g2p2pi3nCdSHc9fX1OmFOIcdPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4FABhezOUOz3OSNqItM76h6YCCjASGmT5JSpyeKiTou47dWuukXYfaN3kQe3GIVEOhIgl9B6at+XtLaq3cAAo2r0kgnBo3EGRWBOchmlcif/xP5+waDERY2qhw8ukM5vY4lV61MN7tTStJcF7Yr/71U02hbiCRH6OjDIVkJ1qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ow+TUh+C; arc=fail smtp.client-ip=40.107.101.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBJOEXlW4H5YWZ0BLOwo7peMevUG4fMycWMn2tMUQo36srWqEx/xNKm92mSQBGJBWYf0VR1viYwtCROGP3HivDZ34njcc3AqaJWiD10ET/Qtt99TMPm5Y9FxWg31r9xzMUn2xPmJ7AIw7q8tb0J5qiGxkldbmnveVvMoLqxuq3IS8qmtyQ6RXQi9Rtv9JpHtXj1DWkTi0SuaJWQH/rQBacyB3RihqGeykF4ZfMSpsZx9VtYX1VBHXvsdevrQGQriFd0WW6h1d2VmlLEsn+QeG4bOa7yIVKIEYj3lXw1USFzPC91pquDQjwvYrnodG8zYbmXDd4o6rZN98JLXPvXhMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jGZSy/AYP2hfv8US9yDArHf1ZDsQ9rREt4C5UY7hUE=;
 b=SOB4RK+wpyd4Dxxywpb4jQaEj2mRosIXHAY6UyCKqRzlyLsbbKP1GQfu5oJkWlHCzx6XhMnqpRlJ8zu6h6HA258afX/mSbKPEZHalp1/a/YHPtJV573vbs5WnHx+d0WhsSV9aUSLwwKw4Y5bImxuEYRBBj421xlWfDFcNOW59iMr8A3SHZbyGvfVOigjtDAKn1aV0A8yCYBP2AZNmaIg/veiG3VaEBEZNkp6iwali4s1q+TQccegaVMLXrlbmuQ9VAyK57ugqYpfsjdGGZxxuiRT0EEP+I6S9wYVsQYF8d8WYJNG3HA/81E7J+XcMRC2WbYQVD7AI335QMQZSwdeUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jGZSy/AYP2hfv8US9yDArHf1ZDsQ9rREt4C5UY7hUE=;
 b=ow+TUh+CLnol89enZT65OHAEgP43fVACBSdP/QsO/PvsQ593YVxOd7hFuKAKkxsV3Mtv3gB8uq/B7nL7/jkZ7jb4GW/m7dS6KWU3+o2fSLBUKi/y88+Abc4N3IwZhQHLVQq1iu8BeG6Z/DtEYrUgMoyO7j6V584DI+z4jVl2+9c=
Received: from BN6PR17CA0045.namprd17.prod.outlook.com (2603:10b6:405:75::34)
 by SN7PR12MB7107.namprd12.prod.outlook.com (2603:10b6:806:2a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 15:08:58 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:405:75:cafe::5d) by BN6PR17CA0045.outlook.office365.com
 (2603:10b6:405:75::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Wed, 22 May 2024 15:08:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 15:08:53 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 22 May
 2024 10:08:52 -0500
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
Subject: [PATCH 4/4] cxl/pci: Define a common function get_cxl_dev()
Date: Wed, 22 May 2024 15:08:39 +0000
Message-ID: <20240522150839.27578-5-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|SN7PR12MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aaf3023-9191-4657-099b-08dc7a711856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kTZ5hqIc5bwzp5nIpGjiohCp/V6JZDWKOdS6GYbiUYuAwwfR0RVCHYCrjZUF?=
 =?us-ascii?Q?kF2s1iYZBOMrdzqDSTkEu+sNLBu1J7GMWFnUqHTWHxa1QSZOgSYw6+ByXGXx?=
 =?us-ascii?Q?U2zUtGvCdYfQW47NmfoXlls05Q/XkBnv5us1j3bJcmC1ceODycT1TQRkjbm+?=
 =?us-ascii?Q?boOWwemu0pC4ljpStPhke6G0/otQOxemvgA+QBtMgG0X+BnTHKY7cnhb8pIB?=
 =?us-ascii?Q?8DylDjaQ/H72si+ywnpg0+AjHIIJnIX1RsEunZ//tR4it3tg6vn7SNQy9wEO?=
 =?us-ascii?Q?o9fU9b6i2j/U5lqNBvErbrzqaw8XW2+0a0DkpPzL5i3sdJzHHMmPThXfOBV1?=
 =?us-ascii?Q?mZy/sEXmiPtNBm075MiDPh+h6wH/mcCRAjMPxBPfc4GwCWKjobI9KQ8H8qds?=
 =?us-ascii?Q?Dejh3/CKjszVLqAf4DR+xF8yz1TuA7IGK0WueA43ww4GoU7YLq0IasEiFXWa?=
 =?us-ascii?Q?q2gxnl9R4DdTd1RuWh017Vc2UbokKwVVBcMvax4pHwKrlRWNaCDa4AUTNK6g?=
 =?us-ascii?Q?2+z3i5Nqq/GgoXIFEDiKPdlgawUF2jQM7Ym2G5PRrPrbsOSbq6OWRxKlylRz?=
 =?us-ascii?Q?cYo5ALAqqP9zLqhNPWEQ0Tv23yAyN9JHuAFntqKw5yJaKP993WRxU1uqmMNH?=
 =?us-ascii?Q?NKpTdh598lNjW8UQzIqKuwrGAELKlZw9SqA2kB1OhStMqWtTvGsGjao7TJLi?=
 =?us-ascii?Q?aTaMEXVxMde9cpmCtUDsEKzAAo1c7aECVy9ZRx3oIvF3j3OwCcbeN1lc2e4l?=
 =?us-ascii?Q?i9XKRCF359ouAZyF6WSALTcscmoQWZlwjGJx1FopWVMVYXbo1Z8zAAj2YOmP?=
 =?us-ascii?Q?NVYTBEhMRNlXsCkA/AkNJkm0o8d5arhoauHeD1g8OLQH4L893ipq1c5a/KfV?=
 =?us-ascii?Q?cDZJ99h3XG+v9QGxFUngPDiHyquaaX62bNTwmHSjyDo/jW2UChJxx4BWcTww?=
 =?us-ascii?Q?tYSiYSSyZj7BUgoKFttC9mQum21tTnWZ9vIRIl3ceXQs77HdPV7kvfehUcOJ?=
 =?us-ascii?Q?JxkdJuN1EmnN4CBrROiGq/7BqGN3wSylhwqs1eLG2K6anYsXaWJG7gGSygfu?=
 =?us-ascii?Q?DI/bYw3jnRtMi9xbGvULHImpL0FJp0BbhNxAu6j+EGPbHMK5c1hBUQHm+kPb?=
 =?us-ascii?Q?y0EU6NOtrBqGIJU9hTBa+rzlJ2VOW/kOpuYWuDrv7mBc8bC8550PQVBx2Ali?=
 =?us-ascii?Q?kIyBXwRqw6godfR1Y9QuIMKvjbmjT5J+IH4DhJr/N9DLSvheAah2DhdEEdQU?=
 =?us-ascii?Q?dgESqAwaHQlC1w9p0bQqwoerhXHhsCHvk/4FWFRyY/MGJVH6ksDlbAuR8TIp?=
 =?us-ascii?Q?CqufYvVO+phImAu9f49fuP61pjF08VJMWFEIEjnoQXc9MMHY5cCu8gXlKgNg?=
 =?us-ascii?Q?uzGKBSI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 15:08:53.7483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aaf3023-9191-4657-099b-08dc7a711856
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7107

Refactor computation of cxlds to a common function get_cxl_dev() and reuse
the function in both cxl_handle_cper_event() and cxl_handle_prot_err().

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/cxl/pci.c | 52 +++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 3e3c36983686..26e65e5b68cb 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -974,32 +974,43 @@ static struct pci_driver cxl_pci_driver = {
 	},
 };
 
+static struct cxl_dev_state *get_cxl_dev(u16 segment, u8 bus, u8 device,
+					 u8 function)
+{
+	struct pci_dev *pdev __free(pci_dev_put) = NULL;
+	struct cxl_dev_state *cxlds;
+	unsigned int devfn;
+
+	devfn = PCI_DEVFN(device, function);
+	pdev = pci_get_domain_bus_and_slot(segment, bus, devfn);
+
+	if (!pdev)
+		return NULL;
+
+	guard(device)(&pdev->dev);
+	if (pdev->driver != &cxl_pci_driver)
+		return NULL;
+
+	cxlds = pci_get_drvdata(pdev);
+
+	return cxlds;
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
+	cxlds = get_cxl_dev(device_id->segment_num, device_id->bus_num,
+			    device_id->device_num, device_id->func_num);
 	if (!cxlds)
 		return;
 
@@ -1013,21 +1024,10 @@ static void cxl_handle_cper_event(enum cxl_event_type ev_type,
 
 static void cxl_handle_prot_err(struct cxl_cper_prot_err *p_err)
 {
-	struct pci_dev *pdev __free(pci_dev_put) = NULL;
 	struct cxl_dev_state *cxlds;
-	unsigned int devfn;
 
-	devfn = PCI_DEVFN(p_err->device, p_err->function);
-	pdev = pci_get_domain_bus_and_slot(p_err->segment,
-					   p_err->bus, devfn);
-	if (!pdev)
-		return;
-
-	guard(device)(&pdev->dev);
-	if (pdev->driver != &cxl_pci_driver)
-		return;
-
-	cxlds = pci_get_drvdata(pdev);
+	cxlds = get_cxl_dev(p_err->segment, p_err->bus,
+			    p_err->device, p_err->function);
 	if (!cxlds)
 		return;
 
-- 
2.17.1


