Return-Path: <linux-efi+bounces-2623-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C075A10625
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 13:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A95169874
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 12:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C98028EC8D;
	Tue, 14 Jan 2025 12:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h1OaEupL"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECC822DC3A;
	Tue, 14 Jan 2025 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736856292; cv=fail; b=WEpzX0hGbATV2iDZZpfnmyUUSDBQ81fQOw7kbN1KlXpsmHeH6ybyGTQkABctW8aOZKpGMeF+nXEzh+KSJPLPH+84ZOw98cAeQBwQlygS0qA0kOlxJAhwp+M/8hxig2BQsrtEdAV6WUGhvr9YlQCqQ3BymLQXO+L9acEm1Kau0tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736856292; c=relaxed/simple;
	bh=hvshpgr6Eb3o/bd3So59b7iKH6+uAM9vBuvckvvbh/Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b9lbrJWNKnd06cXZcr1FtQRUy+KljOgB/9KxSjWdNdC0cxk8NeFujxvx3yk2GS++Qk4l36ltEFKVJX+lz33V0x2lPT05mbARqtY0j3/SecZEvoBgE5LZrlKwMfT55u7xphtLxTlHbQK8Kv9HQ+0ft3Ozg+KxFpMK8WMcsMEw3lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h1OaEupL; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRwd8TqSyF/HUu7QM4NWV8PmVhp9Mz2aE89Mw4ScBf/H2Zmxy5/mfqphbbdbDMmFpKMvy64OX0dDZ9y6dcrnPN04a29Cvr8os17Mkzocj29hCLEIthu4j1MUWm77y/QKzPJ3387zdzdEhKU8mGpXOyeToRVxFqQJr4VM2DzlbJlZL0uoiSCdm7+Pco/uqYXqX9ok0YSDlrz3HC+Wu3aXDomuJV2gmfAGbdbMaZrpu7P1I3Tph+FgwQTRdkRNvMEKHhrqzIPr/sNLm8MxfexUnR/CCj3tql0hCp7MXrnAlGWCxzeEp13b5lIa4yuiP17hxem9qVz4IQGHGgHXaQmCnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYL/Wkh68jYlwTZc1W56isBS3osIjeWjP8b4rqelGVk=;
 b=Wc9fyXZY8TGhyL6owuPdXw1SXg0PexiSO3eLr9nQAVrat3nqGJCkFQjsmFKMvtvjFxRyrxXsfDHaXnscovqX+x4B2Il6Em1sdSCcsB3yQkfBOnPvZ6fyccb6FUV6AJxoMq/XzDfgvnYHFoFaEiP47XvxZEWUhn312OAtgNJ/t0cwvoRVFBkSeS6g3jwc3dHiFNW8/MiI90MWKLg0SFBIXcD71S/OqrsDxiqjlfWLCqPU6gbTjG7T/XjSmuiNskvw0vFLZrl28HGh7MD7R9TI9JONsuZKr760wQpbXAdTLUZ6a/jvGmonoLB9wgLdYtMntzMGS/DNPfJnhAc1luqukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYL/Wkh68jYlwTZc1W56isBS3osIjeWjP8b4rqelGVk=;
 b=h1OaEupLMoEfR4036njb3rEO55Ep9m9eO2Bl94etA9npRcMqrm1JKO+djnaK9abuiYlhaL+vq3/NTBS9HQbQEZciemZyeMpnBc8xTbBRzpOhhYotyiKwBNcoM570DQXFVf3E/9b0r+677JFcbyzeyLav+qkX61gNek9gUi8UAQs=
Received: from SA1P222CA0116.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::20)
 by PH7PR12MB5952.namprd12.prod.outlook.com (2603:10b6:510:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 12:04:41 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::cf) by SA1P222CA0116.outlook.office365.com
 (2603:10b6:806:3c5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Tue,
 14 Jan 2025 12:04:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 12:04:40 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 06:04:40 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v5 0/5] acpi/ghes, cper, cxl: Process CXL CPER Protocol errors
Date: Tue, 14 Jan 2025 12:04:22 +0000
Message-ID: <20250114120427.149260-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|PH7PR12MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd8bc52-818f-4779-5a1d-08dd3493a048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D+4fBkK9v7ujCmRM1cc0uHqbexe2QJz1Fb6nfctpXW+VOocUNx5s9nQkSkIQ?=
 =?us-ascii?Q?uLHFKd7vN813pTVXvlRRj9coJHtTFvkeJ5hGUXhUyCX0eRMjsiQipJoQJxHA?=
 =?us-ascii?Q?mxYKpYbUEc6FLSSq74iTmyNGYCzMw9HISbzlfbcyb5Ukybh/qDynfExpopFe?=
 =?us-ascii?Q?ABiUpVFVwcB6lLqCJp7JF1GSE3S8oIufJj3yWysC3led+DGg5Rm0uXh/hSAW?=
 =?us-ascii?Q?vBXjxkx29EQRKaJEeovBMaUr6uexmFbGfai9czaQtbBVTqwukPPaTNBg999c?=
 =?us-ascii?Q?JoVjOy2kA2Hp8j6/A2NXjXrlk+ViksniRA7CmPJLWRRO+cJvFrFhsY4sIxlc?=
 =?us-ascii?Q?DHJV74Zfbn+tNjFGUpxYSXWIqrsFCrcssidmjsJ/vCJ47iJm6IJVT6JXAwXf?=
 =?us-ascii?Q?91/1lu5ylNZwchdApBHcM/nmrqfCP8wuxAtqGzEsRzI5Hx3V/PBJWWJZsa1s?=
 =?us-ascii?Q?fEeAaZptdi9goVsxroirMYtE5PdS5UkdhO/TzD6T0iHrIN69Xdi0g5u0zxaK?=
 =?us-ascii?Q?+DcmMSESM1FCahQX7K0Pf7IQXdgQrPJsY6jKscnjp+ynJm280U/Ozn3z9Dyv?=
 =?us-ascii?Q?B5Y0B3uqEdD5RN1pka1BcWn1MQvyRYpPMCA4q7BdN7Q7aEtSliw/ronCqHwg?=
 =?us-ascii?Q?Z+mosBCRocJQeRBFOTc3hKNLg5f64J1KONS2MHtmIHEa1Mfp48nz0R1X4CAL?=
 =?us-ascii?Q?OlSo8xL8fXobXoTlsBtp5NutBD3AFXyhzcwVzpKAmaFE7WRltAnyDHeXU007?=
 =?us-ascii?Q?T9ANPT00mAlA60BZtkQr65XzmPO3rz4ZFQuviPzY254e6Nt05sFLg10WeTA1?=
 =?us-ascii?Q?bOAJ9kSq+PJOdz/Eiip/XZvOK+6MgsNrg85MhYby+IUPStJkTVnxky1wRLH8?=
 =?us-ascii?Q?4AOHajtvcz4cHTemdshLakJH/1PUxwCzFYLaw0BG8lrPXg6CQB8HcOiyQDuG?=
 =?us-ascii?Q?DQ0mf2GiYMbWjBOKyNi1wZ3yDGTHAtjdrxyMfHMx3mYnriCZIoQt+jdHyGCq?=
 =?us-ascii?Q?JvXln4OC2Nt85CC45Ju7s+jwbL9g7SUqRDf8jE6yEN/vElKFvajPnmI3owsD?=
 =?us-ascii?Q?YO9doU/ILft0hedpgbXMFzqOHwHq3vXu3313eAQkhJElW6xn7ZDvtsDlPiIL?=
 =?us-ascii?Q?gXNZij2birclHKXmHAMvtUB8RMrXn9pOs9uAvVkB9hvAo4ry1uZDGeo3636I?=
 =?us-ascii?Q?g2XWBY/SKtKCuXH17pwdjqz1kBYEh/PKzrJ05hjzOhLtQb+4k2sUrhRWaAZd?=
 =?us-ascii?Q?HedHPGbnZzHK8u9MY3o2+gHMiugsubkOJ5ga+ZjEFAB8EKJpVEYwH/mgS3TT?=
 =?us-ascii?Q?pAowGQ5ib9IKyG2AK/0vYaCKf7+5I7Wxqy+6ew/EjkFwfTICgWLs0lND9LLK?=
 =?us-ascii?Q?F5BENDSGNQOA0qsfQPYtDtJEGlIjwr369XSjCIdyKjYnrNpIfQ9YHRZw56eu?=
 =?us-ascii?Q?JvYwpaEQpuI6VHYKeP/Qx2vPzP1yqF1rrwchDXqx2ZSaKox1YDFqHcptAetE?=
 =?us-ascii?Q?c4rJCgHt9hzEZGw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 12:04:40.9630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd8bc52-818f-4779-5a1d-08dd3493a048
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5952

This patchset adds logging support for CXL CPER endpoint and port protocol
errors.

The first 3 patches update the existing codebase to support CXL CPER
Protocol error reporting.

The last 2 patches introduce recognizing and reporting CXL CPER Protocol
errors.

Should be based on top of:
https://lore.kernel.org/linux-cxl/20250107143852.3692571-1-terry.bowman@amd.com

Link to v4:
https://lore.kernel.org/linux-cxl/20241217022032.87298-1-Smita.KoralahalliChannabasappa@amd.com

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

Smita Koralahalli (5):
  efi/cper, cxl: Prefix protocol error struct and function names with
    cxl_
  efi/cper, cxl: Make definitions and structures global
  efi/cper, cxl: Remove cper_cxl.h
  acpi/ghes, cper: Recognize and cache CXL Protocol errors
  acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors

 drivers/acpi/apei/ghes.c        | 103 ++++++++++++++++++++++++++++++++
 drivers/cxl/core/pci.c          |  62 +++++++++++++++++++
 drivers/cxl/cxlpci.h            |   9 +++
 drivers/cxl/pci.c               |  59 +++++++++++++++++-
 drivers/firmware/efi/cper.c     |   6 +-
 drivers/firmware/efi/cper_cxl.c |  39 +-----------
 drivers/firmware/efi/cper_cxl.h |  66 --------------------
 include/cxl/event.h             | 101 +++++++++++++++++++++++++++++++
 include/linux/cper.h            |   8 +++
 9 files changed, 347 insertions(+), 106 deletions(-)
 delete mode 100644 drivers/firmware/efi/cper_cxl.h

-- 
2.17.1


