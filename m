Return-Path: <linux-efi+bounces-1856-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 402E098B196
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2024 02:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40D7282CBC
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2024 00:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615666FBF;
	Tue,  1 Oct 2024 00:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rYO6+huR"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78DD28F4;
	Tue,  1 Oct 2024 00:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727744009; cv=fail; b=VnKeKbaJDtWYp56oqt1nbAgeYWLmYj9oBZooPcCUGe8w2qAVlXlI2Z+yx+XYDojlx43LupFHI27NtrQPQKs9QS3+dppvvNX+i0Cixt2+tRfqruwNmeijzeau5PglQdej5PbvN4RShks/Z/BXRBPt9x/ZntyaNtZJFMZAOFbxTe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727744009; c=relaxed/simple;
	bh=DcpxxQUmj0UXcM0cAj183SKiqRKtSG3g99+usCYbhNI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kyB8AtIaaeHnbGBwxq7LKQ7Vxt4+/uQ/k1cZ/Zq+o2L0AfEjNT3ay02fe4WS1++fYvJhB66DNVX6loj6DR3X2xqaAzehyGb9E+N6tu0c+ea9UXPIlstH88nQnng7TWlSBvwyR4vdkZ05wiHDToLFnyVzAa1hg29XZ4cCPn/tzXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rYO6+huR; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/zbcOc7madQ6AvXJOn+5IcO/bPxsLIt6iOhIKJFqUh62p6xoclw13TjcaFIv+UCBcxhcY5JuFXe8iX3724r3WL5p+cAkEDrfNhziOxYnw06z3FA7oXgPHqPG6DqfoImsHUvIpOO7n18jNStDzXvB1GuZanc9Uqe0nY7pVsnx/46NzxEHAqggQtW9JKKU3Ih1TXC8pxzhRsAoMCBXumraA76VW62KwEcmjNiTEYgyk5g9WvLAWLoV6/GWTMmlxkOBjqJzU6ALYE0uSgZ92S/1G0lUWWO9/wjFvyQAvJa6XDb2A/T5nSOph2+WH/998Jv2csT2qrL+/+98laP3ZtsZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjjNlcw9MrFByRen5X29MSzF+cvea7+OxzDyNM5XA5Q=;
 b=Usgn7MoNbd7KnH1Cq5T9fMSXQiIXJgZ9CnkOgbn3UtM/UTnBwR+AQchVD56BcdYSHKAwVvOBvdBchZn/8SqNNJn7PJ1H5pn3G4R3zoY3dlm6UYNvz1pQb3soscrdvIefUYnilzm7fzChcSCNUHprz9zi3VSrx8gwT9enYRcpCxso8Dt+eO7w/CPhXk6L8TTfrzhbYMhf+zyS3Xpg0SPYIrTquURELp8MpTf+qgvLo1WZQ44PTLU5mFTF5gK+5aG6v7KNABL6b/IqTDjRG/yivmNfaNZQs0DAHS3hnxTVdud2it/JM5tTejWSEpI9pjElAFmQreURHm8fIKh2r66kTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjjNlcw9MrFByRen5X29MSzF+cvea7+OxzDyNM5XA5Q=;
 b=rYO6+huR+q8p4TJIHRrgsNJzCzV1KoKHYwSebl/YcMHCsfQ/eDed6fgQOe1Tc+UTlLBrqzEdW9wSxK5m/dMtcPx+lGJg8uEHc/IzMrxhV1IwmLoqXrDzYCe0eKd5GthBR8WIIQW+cDA1h2nOldm0oc1B/Fde42nb7ms40/hN1os=
Received: from BYAPR11CA0048.namprd11.prod.outlook.com (2603:10b6:a03:80::25)
 by MW4PR12MB7432.namprd12.prod.outlook.com (2603:10b6:303:22d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 00:53:23 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::aa) by BYAPR11CA0048.outlook.office365.com
 (2603:10b6:a03:80::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Tue, 1 Oct 2024 00:53:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 00:53:23 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 19:53:04 -0500
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
Subject: [PATCH v2 0/4] acpi/ghes, cper, cxl: Trace FW-First CXL Protocol Errors
Date: Tue, 1 Oct 2024 00:52:30 +0000
Message-ID: <20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|MW4PR12MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b25759-bbd2-4013-c9c6-08dce1b3738f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mwazgTePOW4STs/JWjjGTbEalptL1hh3t8fKrird2W9dNW0zeQ0isQc3nMyz?=
 =?us-ascii?Q?1+HdKsGkXIRf2oT72y94S14E6LWDAVVksEG9wgclOAAE4DC4/W7lX4UW9HZ6?=
 =?us-ascii?Q?yucJQ00UmohzugEP3XBbNm+bOqjEeyS7Slnme8Fwyq4HilSiBrXD67RIX9jP?=
 =?us-ascii?Q?IS4B7CrsG0qUr3nb10Sn1WoUpsP8X0zpsuQInpxTOHj32rTxAal5VAbLko2e?=
 =?us-ascii?Q?K5+dDMXbAdwp0a8Da+SXP+6d5O4A0UAkrnr1l/PpDLsxZnvOBXAv+/FeSkro?=
 =?us-ascii?Q?nJ13cjY3SkOxDGaxraiYqUnUzRM854G+feUfqyxVg7utO9Iu5ZrNZ9qMJXx0?=
 =?us-ascii?Q?kD/wmis4CACkWNGokACw/NvECB07kjlz9+Drau4voP4NtGGC0rFWJ8pxyiPs?=
 =?us-ascii?Q?OuP0n+mOwaODhWJYBiTRaS8lPJPYfjQXrGri28zTz6IVaCw7LLCm2BIrWp1h?=
 =?us-ascii?Q?rEiCg9c6R04IHa2FlP65VNop8rxi+Rxe86yQdoCHQt/bRcehNcFRwXFSSoGJ?=
 =?us-ascii?Q?zrzl2MHqx8l7YnNpUcWuD/IzGMjUUOIsTTbX//CkDmoD/In1lrF01jwTGc0Y?=
 =?us-ascii?Q?HInL1FV1U0GacyFcU6H+ZdT9AxhjB789V9K3Tij9dRSUHL8yun6iMgazqu8F?=
 =?us-ascii?Q?FuqcAD2ju6miYtsz8/8PdFCj67jxaB6KuyM1KQVbjDMTY1WqUuHBsTYBmS8D?=
 =?us-ascii?Q?BN1bvEUhJ/WH8S/yXAbLIqUun0NuoJXVRKlaKSmT4ePJxf+KTDn0eVXFfi65?=
 =?us-ascii?Q?TwVl1Mu3ovgBezkGREth62Aq0VZWgMtcttD2J8dCapjwwIBIBTyMBKZDztiy?=
 =?us-ascii?Q?xs2bsTVrkngcwN1/5uX+MVocvGfqtTtTLBTc3ioIHOuYty7uRa6oZzyS902F?=
 =?us-ascii?Q?0xAZeK+7BoelEr20frJyYVqTDSiLqUiRQh8FS4TSOhxrkbfdBbBAvOG1fkWn?=
 =?us-ascii?Q?AgywneSDZ71gKp6sZLO89cx8qH+cdboRGzyNFasxvfos5o8oK2n5qca6N7HZ?=
 =?us-ascii?Q?DPnUDgcVppADLt+DcHszkKho7C8iHQBVYcpIBjkr3gbFTV73ujSE6/mwZdra?=
 =?us-ascii?Q?y3pf0ul0qxoyzpQlfc3dMcX4z3MauhUTIzMgeDKumwGj1Ln4CBWpHQyXpaA/?=
 =?us-ascii?Q?EmguezKqbfPodbzgmS4dPkQCkTaoWOgh8+4raQz50Axc8+ZM37kTn41FtGEB?=
 =?us-ascii?Q?Rf6ugWkGITLowHZCPrrI5XznNfDrMKmLtpKMKksMSb0Nx1t4PG+wmldCzQnq?=
 =?us-ascii?Q?qcQiKmYiE/GCq+rgg9QLzTb0jjcbgMeoICzpVzEp5EoMnSziNM1wQHikz+U6?=
 =?us-ascii?Q?EClY5ue0Vq6QrIlY82DKAPo910eJvbXkzEfGwmDGcFQEfNRpmAGUDqzz24Cn?=
 =?us-ascii?Q?njq2tvDvBzx698JUm4WgjgroN2gY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 00:53:23.2560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b25759-bbd2-4013-c9c6-08dce1b3738f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7432

This patchset adds trace event support for FW-First Protocol Errors.

Reworked the patchset to reuse the work item written by Ira for handling
CPER events.

I understand this patchset also schedules the cxl_pci driver to look at
potentially "non-device" errors as Terry's port error handling patches are
under review. However, I'm also fine to just confine it until FMLD as of
now. Looking for feedbacks here.

Link to v1:
https://lore.kernel.org/all/20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com

Smita Koralahalli (4):
  efi/cper, cxl: Make definitions and structures global
  cxl/pci: Define a common function get_cxl_devstate()
  acpi/ghes, efi/cper: Recognize and process CXL Protocol Errors.
  acpi/ghes, cxl/pci: Trace FW-First CXL Protocol Errors

 drivers/acpi/apei/ghes.c        |  24 ++++++
 drivers/cxl/core/pci.c          |  24 ++++++
 drivers/cxl/cxlpci.h            |   3 +
 drivers/cxl/pci.c               |  52 +++++++++----
 drivers/firmware/efi/cper_cxl.c | 126 +++++++++++++++++++++++++++++---
 drivers/firmware/efi/cper_cxl.h |   7 +-
 include/cxl/event.h             |  38 ++++++++++
 include/linux/cper.h            |   4 +
 8 files changed, 247 insertions(+), 31 deletions(-)

-- 
2.17.1


