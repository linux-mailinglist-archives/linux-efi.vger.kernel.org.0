Return-Path: <linux-efi+bounces-2721-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0594CA1A027
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jan 2025 09:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD6016D89E
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jan 2025 08:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B1B20CCE9;
	Thu, 23 Jan 2025 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FsOkzcsp"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A7B20C48C;
	Thu, 23 Jan 2025 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621885; cv=fail; b=QXO85R8At4vc3SW/XUfckUEcGxSfbswgfPqneXlZgeQ3YjZS5E//F4JQ8mz1F+E6axZ+JGXxFJcFwiKf+v6aOwrJjN4G9xt4A7/2LC9ns8Qlq6nAjBCiALvb5/P1N9yGbiMZ9bE3s5PfZ6TSFnrIrvUEev29zDVob+iF6/Lk7LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621885; c=relaxed/simple;
	bh=++cfuQyoaBkRfdS3D4GgQJwVBEAu3SoduSNuRIl757A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P1/QfJR2AU6InCAhdxM8i4gpjDyKaDZADb7PHGyGwyxWIQIjBtryjAPozbTnMtIO4icC1DZAebMXZTM5ESi7pFEV/dTJJL3S+eZkATAJHUO2J8mgJGzA7IZPKnFADM1oCfHtpW29hpm/toQ2xpaSxsFZ/+L9CiNVUub1WsffsU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FsOkzcsp; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTJFz/VkvijJD3t9klwmPr3HVjtsjnBP+oca6Cy4iD6uQjikvEAr0Xgnd6ysuvz1baiH8qaFkFY+MUxwJy4WAnQch72jk8hEmWfNe8Snv/aThxtPoNOcINejXnNc4OSzPC3QWatxfSWLK0Z3fStpayx4AshbgAGt4aXaAar8gcFTtV3kbWhIL0FwTJFEuiX0GMLXKy9Z8Fg48HHoZ5Wj+ISeMmfQWZWyAXmm5z61NR+33UTCCNLr8BuMSqhH6APn3DHMVvXEIf5PfHYDx9OHHWHLX1d79x5s8LnAGf0y/SVrkl+1eVGT6u9PjapcnLI+JbNhobDa5iq4Rq8qK5rf3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KV9e9lpC8CU/6QhWSY3aEj0BD391XhYnTxbJAK/Dnu4=;
 b=bJelcvs8/AUt0XTQULPhUMgT06lNWGCWGGSjPB5evo5iqW1w3v499qBJKqrjC2/X2DQhYhznvkSWh9CuYGnXvL9EpX+nKWponw7ZQ8V5JQOPoPgexqWue7Sl5Ye69DM50q6XSgNJD6pnloye9AM9BXx7iQQsLSiY9YkFRLZTkSKe3UmFaeGM7j5M5TZsJTSzC9BMqF5Mdy6Qx98TrUMox5DxhsTwNcbGRCJ3TGdFwHIccRVgikRFK9W3nk7h1wPRMbsLBoSAocmxdDXrHBSNy7dI/gZBhuE+bdlEfr2xSc5TBvO4QAW5yaqFZxXU670NVuRQYnFm98fhdz8SNvfxxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KV9e9lpC8CU/6QhWSY3aEj0BD391XhYnTxbJAK/Dnu4=;
 b=FsOkzcspU4Zp7J2hRea/KKyBRpckUj/2b1ObuTEZVvAlViC/aPLH726CCpsZdpdqa7sdykuTBAD3CvAELouoNBq5hZnRqCcIDGwRBHBLO/RcHdZA89Pp7UVyQ+cYLO6cGnl8ytKbNeZtEC50kBuKX/gtG8rFIv7cE8+2Ynu3jN4=
Received: from BLAP220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::25)
 by IA1PR12MB6140.namprd12.prod.outlook.com (2603:10b6:208:3e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 08:44:37 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::1a) by BLAP220CA0020.outlook.office365.com
 (2603:10b6:208:32c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Thu,
 23 Jan 2025 08:44:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Thu, 23 Jan 2025 08:44:37 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Jan
 2025 02:44:36 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v6 0/6] acpi/ghes, cper, cxl: Process CXL CPER Protocol errors
Date: Thu, 23 Jan 2025 08:44:15 +0000
Message-ID: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|IA1PR12MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: fab145b3-feff-4019-4930-08dd3b8a2b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?APwuGp36Blva52NIW27zds4dA72dxW11qEOw4esAczYkjNMSXhSP8Q5qSyhT?=
 =?us-ascii?Q?5o9et2BeS2G3qEFETwqjqhnXECBWa2r6so4BM3m91iu8N7RYFSQElHvC1wn8?=
 =?us-ascii?Q?ooalrMgDzH4mTjll2BhDltq+QMBAh8N53JTkO5nebFBSfrPJhyNXiQ7eVeiQ?=
 =?us-ascii?Q?2fYbtPW9FOR+mYyAzm9C763JvOVuocPdJQKxG/Mlbo8nOKo349JhDP91qdJQ?=
 =?us-ascii?Q?80mkn5BH4H0zaT8gSh9KrKC1NkBr8LBXUQu4pR+7TDbw+25jtZ5aflkAoG0D?=
 =?us-ascii?Q?HpWZIpJXb5xzzYYQCquEHFNimvK7PgbfkMsFYFaAzwnGKbx7Nx9SolVsdWs+?=
 =?us-ascii?Q?Ljg0qNcV6FD5QVF6YDhF6Co8wnvJrREyZTBNe9IMqSdN1hDk+ejxb1wlm0uL?=
 =?us-ascii?Q?KXFYy9mMYHiZhvdsJEwTVf8547tYV+ZavrbGuf1awCWiuJbLMPSgoe0X5AN/?=
 =?us-ascii?Q?26oKyqTQAtFCU1fstT0M1lL4b9zzrHzL4YQ92/do6ejLcZmg1gKoutDcTVA8?=
 =?us-ascii?Q?Z37C9aRYUHLS7LbZOCWMOYkSQfDY5aGW8yKy7QlGL9fFyda+sySjOaxTNQBy?=
 =?us-ascii?Q?z326UG/5FCjdRgUU78Jo1+Bja7FCcUD5ntWGXbusXlOglSONUUW/nEU3Fx9s?=
 =?us-ascii?Q?rg7/YYOMPjEScp1TZ0Qid0M1rTOJ6z/uPJFsVkNcrmvIPi3IXlQfgbOLJo7T?=
 =?us-ascii?Q?95VlVY/rpOx5dngxgSLG2dkyenoDzgiT7adMSJNmtwqc1jWdx1QQwr2bCWWr?=
 =?us-ascii?Q?Jes4C0Pn6iGVd9DlJP7EP6bMzV0hBQJ3oERA6pp8FZuuxiFZLqEWjqYqtRd5?=
 =?us-ascii?Q?JTqTqAHhzNYxV4Bnz2cNCazgad41fsinaShooKz+ZvUt+7xGR8kkzQ0q2RZQ?=
 =?us-ascii?Q?k/FSLsFFQ4THTV0rlEM2lOpExAgD6V0Z3VjEpyevFAJWSbbQoo/rOTrG4sWS?=
 =?us-ascii?Q?6LllNjLM5e1pDxC+B2M6XXKhXbOBR5tkQq7UelZx8cOvnU8d9QhawlZrWJvI?=
 =?us-ascii?Q?PEDLkZ2CW3yYuCdS4cHdtSIk9c6e+t/k3EDUUvQgbUYMTp4V1DpbC6J9ySSb?=
 =?us-ascii?Q?hAX4CZE0iuUQIxMU5nZgXIlBz3rNQg0xDaHRYHVpFsfocZ07YniYSSeenTqg?=
 =?us-ascii?Q?4D/DPsJJVQn8gTtcfP4oebsNeC4QV/MePQcFaENLCWAuBjUCFQ92FV/cpknV?=
 =?us-ascii?Q?80en4sNlhhZ051KMQaU2wEJpEcr5XIgUQzPOBVVZLf1WIBOQsr+DcCUPhdnG?=
 =?us-ascii?Q?eOnb145RWTgYFtH37WenMfcTirdu/Ni9HMifAy/FyA6trq/F7215JAsfAFPv?=
 =?us-ascii?Q?Hq6kpsUW/6zDW5ZH9QU9r14Oz4VvJz1VkOvqUkR7PUDWl4nIdKYhMmWRf68N?=
 =?us-ascii?Q?GcleJ4fZqgnJYdxBCMXb5rCRlD5DK5jNxjGdIGGBFrgKvSZYgR15CEGzuA+h?=
 =?us-ascii?Q?D+Ux+s6OSKqtkzKXe0CUOnj1t7hbIMFrHVKa/m/WVd3u5n06ll2+2/9tuqeV?=
 =?us-ascii?Q?k7sYexZPz/Qp2F0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 08:44:37.4887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fab145b3-feff-4019-4930-08dd3b8a2b5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6140

This patchset adds logging support for CXL CPER endpoint and port protocol
errors.

The first 3 patches update the existing codebase to support CXL CPER
Protocol error reporting.

The last 3 patches introduce recognizing and reporting CXL CPER Protocol
errors.

Link to v5:
https://lore.kernel.org/linux-cxl/20250114120427.149260-1-Smita.KoralahalliChannabasappa@amd.com

Changes in v5 -> v6:
[Dave, Jonathan, Ira]: Reviewed-by tags.
[Dave]: Check for cxlds before assigning fe.
Merge one of the patches (Port error trace logging) from Terry's Port
error handling.
Rename host -> parent.

Changes in v4 -> v5:
[Dave]: Reviewed-by tags.
[Jonathan]: Remove blank line.
[Jonathan, Ira]: Change CXL -> "CXL".
[Ira]: Fix build error for CONFIG_ACPI_APEI_PCIEAER.

Changes in v3 -> v4:
[Ira]: Use memcpy() for RAS Cap struct.
[Jonathan]: Commit description edits.
[Jonathan]: Use separate work registration functions for protocol and
component errors.
[Jonathan, Ira]: Replace flags with separate functions for port and
device errors.
[Jonathan]: Use goto for register and unregister calls.

Changes in v2 -> v3:
[Dan]: Define a new workqueue for CXL CPER Protocol errors and avoid
reusing existing workqueue which handles CXL CPER events.
[Dan] Update function and struct names.
[Ira] Don't define common function get_cxl_devstate().
[Dan] Use switch cases rather than defining array of structures.
[Dan] Pass the entire cxl_cper_prot_err struct for CXL subsystem.
[Dan] Use pr_err_ratelimited().
[Dan] Use AER_ severities directly. Don't define CXL_ severities.
[Dan] Limit either to Device ID or Agent Info check.
[Dan] Validate size of RAS field matches expectations.

Changes in v2 -> v1:
[Jonathan] Refactor code for trace support. Rename get_cxl_dev()
to get_cxl_devstate().
[Jonathan] Cleanups for get_cxl_devstate().
[Alison, Jonathan]: Define array of structures for Device ID and Serial
number comparison.
[Dave] p_err -> rec/p_rec.
[Jonathan] Remove pr_warn.

Smita Koralahalli (6):
  efi/cper, cxl: Prefix protocol error struct and function names with
    cxl_
  efi/cper, cxl: Make definitions and structures global
  efi/cper, cxl: Remove cper_cxl.h
  acpi/ghes, cper: Recognize and cache CXL Protocol errors
  acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors
  cxl/pci: Add trace logging for CXL PCIe Port RAS errors

 drivers/acpi/apei/ghes.c        | 103 ++++++++++++++++++++++++++++++++
 drivers/cxl/core/pci.c          |  62 +++++++++++++++++++
 drivers/cxl/core/trace.h        |  47 +++++++++++++++
 drivers/cxl/cxlpci.h            |   9 +++
 drivers/cxl/pci.c               |  59 +++++++++++++++++-
 drivers/firmware/efi/cper.c     |   6 +-
 drivers/firmware/efi/cper_cxl.c |  39 +-----------
 drivers/firmware/efi/cper_cxl.h |  66 --------------------
 include/cxl/event.h             | 101 +++++++++++++++++++++++++++++++
 include/linux/cper.h            |   8 +++
 10 files changed, 394 insertions(+), 106 deletions(-)
 delete mode 100644 drivers/firmware/efi/cper_cxl.h

-- 
2.17.1


