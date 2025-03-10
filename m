Return-Path: <linux-efi+bounces-2956-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7CCA5A873
	for <lists+linux-efi@lfdr.de>; Mon, 10 Mar 2025 23:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13B63AF0C2
	for <lists+linux-efi@lfdr.de>; Mon, 10 Mar 2025 22:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEE440BF5;
	Mon, 10 Mar 2025 22:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bVBAfl9J"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475A41E834E;
	Mon, 10 Mar 2025 22:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741646339; cv=fail; b=DdZXXUozF9aOIsU4AgamiVWPXjmcqyRq7TqhzBTbH9nsUHPQsgPZ1lZSDLaj73tc/yQ7xXy7rFOgFgLs8NYlaPr3a6tltcXX60l5ggWckP1KySyb/k/fmuR/SRtkUTrCCkRsMBS8LtX0MMQeVBIyH27TpX4eiAirZU6RLfB9oDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741646339; c=relaxed/simple;
	bh=IlRvQkWraukyF5zrbgUP6Ugbp5B6Qh0ndzc57FWYoDQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AYkf3NyheMSLsdpy+pLjGdgazIV5EdGTQ7sRHRAZ67zft8Tc3qFI/rahyk/D7YFbTjih/rxuxsjFjvxk9wr9zlIhYFiJKf2wfTV4dwdPb8FhjPdHGiWu3RtQURK0/mEFZvL5zA+eMSDy24R5fv/WS7Dh+QyKTgwYt5MfZzYqkcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bVBAfl9J; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlGPEvJAr66nD8d4acLiX7sCO1pzje+jQ4wL/YPUyanpdB0p/iHqGSAbDOh5D42Fk1W9JCBqFNxYT7C8JeDa/YsISwbilwch1jxBmBoxl7/eVLKjOw1aLkLDwOwPACgN2P0+HYjkVt5+UIRkc3bZjRKziwZ2O/UcV9wizg22kOFIBv/Z9nOWSdFQzVhKkq+uu8BYdT7tbBlmvhLqTKqgCZZtGi18yCnSUMmMFFwYKcluPc/7X6Tp+GDM7jEW5OhpAAZGUn9BMj7hYY3UjPZYO6EjoCU1pq0GtVvSkpNCQF1Th6FfcqEWx1kEglj7lLRj4QO/uOVM1Y/zClX+7s4cYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWBp5qH6MEpvNNtEZBlSISK6RSQCQpNJqXhhoQP8jTY=;
 b=DXYRClzq7gfbkaJC5yUf3D+CMXaxZC00oxqgr2YLPny41cY06Bu2vyyyVTqKE1f8HKOJly53h+Xn52m6cAa6QMr0l5HODZy91s0UNOTe7QjbfFS5u58tdUALpvI8DSlY8tLO6Ezn8ncrZCvyAE9eIQYi7v6ss90pvE0HtH1Ef0ehutqs5PjWJ2w6pSasKVhQ5O3xhTSLZX40aB9nGpBpiQBDV+vJdLWxuCbbP5bJWRdJaNBbJZwZKxUQwhGjiDD2Mib51DGM2syC0qIn9iXb0Gcql3YUtGq8GZ+t8CPjNqgmNq0xa4abEqnnERWQJryLZss3nyOYX5by1dlNRQNxvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWBp5qH6MEpvNNtEZBlSISK6RSQCQpNJqXhhoQP8jTY=;
 b=bVBAfl9JT/Wxi+cBM1Tpa4TKdmmEwbgOGw8+7laXsAZLLkv9kXPZ7gE6S8H8eTGZLJPJqI4PlFUIUQkDvJD4FBs9EPwF+RdoLoV0Q0SQdBHDeEOb9Qcp+z+XiRtSd9NDLmiL63dj4aT8xkYcn8+4NxM1XnQPRb/fMawVazIe63U=
Received: from SJ0PR03CA0046.namprd03.prod.outlook.com (2603:10b6:a03:33e::21)
 by IA1PR12MB8585.namprd12.prod.outlook.com (2603:10b6:208:451::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 22:38:54 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::d) by SJ0PR03CA0046.outlook.office365.com
 (2603:10b6:a03:33e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 22:38:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 22:38:54 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 17:38:52 -0500
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v8 0/2] acpi/ghes, cper, cxl: Process CXL CPER Protocol errors
Date: Mon, 10 Mar 2025 22:38:37 +0000
Message-ID: <20250310223839.31342-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|IA1PR12MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b733a9-990a-415e-9d01-08dd6024567e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NezVZ3DW/LY5O8o75Yy/nbsC3/NMd2GFhpDpTtZi0wcMux62DzyfhDxbbpXe?=
 =?us-ascii?Q?GQAPn5gkW6uKnQ9B8GGsqzh/gsGbW1kj/HIbEbcI5cksom+YTiQTbeq8dmus?=
 =?us-ascii?Q?2VRgINzHMSHdrk/0XmVAW3+PakvmnuFlbxbgpTgxmFmWQNxjZzzwLOrSwHXa?=
 =?us-ascii?Q?agWxIe+kvpHzbQ8OgeiPtaWWwrdEGx4Fm362U1BECY1SQ6jeH8UzF139kAbb?=
 =?us-ascii?Q?nuVDyHmEVKOTwXeQqUtMXXI7S5K9oS00Luah2Sf/mfnpR9Salec0BRyw9xbX?=
 =?us-ascii?Q?qMr1lxdf7DIa6wrjvgfn6dIxSCkWfVZWbn9ETTFvJZmX2mig9llCDtWL6AvJ?=
 =?us-ascii?Q?xG0VKQotJxWVyLXkxi+SNoIWOKA2TOymtV1W11pmHu5dihTnT4ulcfvXYHW2?=
 =?us-ascii?Q?gjS6MCwd5vadoeWN8uRXkIiBcYUvg6txuUGWPE0SyMK4dLQTjyU1kajJ2kep?=
 =?us-ascii?Q?LOA9FrN5K7c5zlS5u9Ez4bTlqx6nQG8GDnPXXapB7hIzaE0LZ+KeGH/fBLsO?=
 =?us-ascii?Q?q1kPvkBlk/0d2OT5LrMQxhIkoRB6D43BQFVtZOZ4fszVBK+lVMvG74t7f58l?=
 =?us-ascii?Q?K5yXrVkIrAmy6rCicTkHFZfU7B2UziIKUQj7C1IJAZY5LYWbUuR+m7M4wVvR?=
 =?us-ascii?Q?B6wP++JLqx+Yzt9vX59cew7aWMsuLs7pVshLYA8Oixy6rpy84I9hldUjMuf4?=
 =?us-ascii?Q?d3/orW6ZOCDsKGn1SycIg6CfNKZjC1ZFuwGqeZfzcLc3YYSoTyrKCX5rjUn6?=
 =?us-ascii?Q?fdqZQfqy5LXr2cr/aBwmmHtDwrJ5UBKLvbc+gG2bCsub/X2DVPtuD29ci19H?=
 =?us-ascii?Q?hLXcixEpKXEzEGcQ7PdvgIWAon3tzuRjyiidXP6CtijfSbGv7fqzu0I5v4I2?=
 =?us-ascii?Q?5cor4f2ZLaSx2XQttdNy0Wu/6u1j6tW//dGETFwYaoHh+GyScXz7cf+H9ei1?=
 =?us-ascii?Q?kmeGUJ/dsAxBn7JuNYhFfcXhd3C9UJA8LHWNZ/YMflyznnp2GcjOc20hsQlG?=
 =?us-ascii?Q?QncOiu9ltHWc/iWVfjgUf+aiqR5GfQxZQMkz6/gxGgPoWsbABacG9KePi1zm?=
 =?us-ascii?Q?JCkrzwHFi5AI0usAb2mW9lo/ypreoNZ4+AQGEJJb/sCEK/93/e5T6XfgdGzz?=
 =?us-ascii?Q?oPF5PMjv+mS3031RVse/BWusQrFQG+0oAjwr3T7522P/gWvdb9fAJl5GhIzk?=
 =?us-ascii?Q?a0dY6kJRm6NVxwXLezuv43rn3VV1TA+MtoLRa7ODOmfKHfoNjPO+iBGjoXd+?=
 =?us-ascii?Q?71kf161mQjKLO5XWmJLNzsW69JCCKifC2JHJUh2VYWt6YjiPYdEhQKbmxI1D?=
 =?us-ascii?Q?uSwZlpUFsRegxHokk/tB0YuklQaDbx6oWT4VbA7z8HwKb0Eu5i3cLZYA/m2y?=
 =?us-ascii?Q?xPDtYhjstCP0F00nkG1G49U51Ptx6CvY9wpoh7mB0dfbEfSLVy+D9sUEXX6i?=
 =?us-ascii?Q?TZ0ZHcm/Yy4NRJI1c6ow3b1z96qaOdbOTdbOpyKOVoOQf/5qvaO3SRd1Vqho?=
 =?us-ascii?Q?wVkDOOS3LbB7hT0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 22:38:54.0987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b733a9-990a-415e-9d01-08dd6024567e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8585

This patchset adds logging support for CXL CPER endpoint and port Protocol
errors.

Based on top of cxl-next.

Link to v7:
https://lore.kernel.org/linux-cxl/20250226221157.149406-1-Smita.KoralahalliChannabasappa@amd.com

Changes in v7 -> v8:
[Yazen]: Moved guard() after !pdev check.
[Ira]: Included ras.o in test build file.
[Alison]: Naming consistency: devname -> device, parent -> host.

Changes in v6 -> v7:
Reworked to move registration and protocol error handling into a new
file inside CXL core. (cxl/core/ras.c).

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

Smita Koralahalli (2):
  acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors
  cxl/pci: Add trace logging for CXL PCIe Port RAS errors

 drivers/acpi/apei/ghes.c  |  49 +++++++++++++++
 drivers/cxl/core/Makefile |   1 +
 drivers/cxl/core/core.h   |   3 +
 drivers/cxl/core/port.c   |   7 +++
 drivers/cxl/core/ras.c    | 123 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/trace.h  |  47 +++++++++++++++
 include/cxl/event.h       |  15 +++++
 tools/testing/cxl/Kbuild  |   1 +
 8 files changed, 246 insertions(+)
 create mode 100644 drivers/cxl/core/ras.c

-- 
2.17.1


