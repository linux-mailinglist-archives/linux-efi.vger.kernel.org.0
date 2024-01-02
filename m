Return-Path: <linux-efi+bounces-286-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E095821E60
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 16:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3BB280FBC
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 15:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9F214F6A;
	Tue,  2 Jan 2024 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VDgPd76j"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19EE13FF4;
	Tue,  2 Jan 2024 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BS7PopijizYniOcuHsdMjgxfLb8pD+13B8d7hRm/oWuO7lhRIj2fVN/GeXv2INApk+juzuABrPHOwfvCkepJFhZUcmK9nmhHAYfADN1kbQIw7YBtaUjOsGHFjDeXe8Ykyrgqw5NWOcfmmTt/1fNDjeJz00QV4tPW3kJYfTBiysphA3d93tTkqF1mMsuz/uI4+L0BSwijOrHD66yeTCwXBwPUgAfdPOw1Wnbu/TAnkN79zaf5x9/eqafVxOwwsxvOtFTY/pRJt+50WrzAvrffLXrMbBvN/71Oe3AgCdQ6on0xHpHdPsMrQ+CtXpy6wbvZr3uN46ZJ52STs4SSTMrPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrRTEe2QfuROLsMOjgmdBEJJF0cyaIww9z0gIjgksRg=;
 b=Oeg8mKvZWpdaNSu166Lnpr6VFUZ1EKihPXU+E96zW4QSGihX2KYWt0nDhACtBd784azhLMqlg5JA9yufumppDVLti6llkSxI9BCZZYi+0I7OEMs5bYuvPZ3B7uXj/Q2leKC5JhtolVb5kl5yHBMS8KhIjPYIrnZxS02HV7nNU+KiJcRXQ7Bb5q+SFhgWNJTsM9vmrABivlmw3WK5apasCb4e5cTVFoVzXxdtcy2iloSA1+3SixO56QYdsrMWvvOdx5F5fy+ksqSHmdaqbSEvs94/fUnT79fHRSO2BfVqGVrlPTITeRuYAJEi6/qh4glDPJFHXfqbBg3Ib54sxIpEuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrRTEe2QfuROLsMOjgmdBEJJF0cyaIww9z0gIjgksRg=;
 b=VDgPd76jXFaeyk5rFAnadCBRBpNxSmHwbccGNU5F4/8E1rVDcDDeQl8H1Hr98tkIXisJxn4F//GU3LrCjekOspLUEKR3zbCMdX7xC+CSemWlLCof16Et1MKeMcQmE0rtwPQ++5LXh9gtOeuzxtQHRxpxcjUWSmi/afZ15RLh/DA=
Received: from BY5PR03CA0017.namprd03.prod.outlook.com (2603:10b6:a03:1e0::27)
 by BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Tue, 2 Jan
 2024 15:09:46 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::96) by BY5PR03CA0017.outlook.office365.com
 (2603:10b6:a03:1e0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21 via Frontend
 Transport; Tue, 2 Jan 2024 15:09:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 15:09:45 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 09:09:44 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH 0/4] acpi/ghes, cper, cxl: Trace FW-First CXL Protocol Errors
Date: Tue, 2 Jan 2024 15:09:29 +0000
Message-ID: <20240102150933.161009-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|BL1PR12MB5063:EE_
X-MS-Office365-Filtering-Correlation-Id: 1045f04d-f522-4244-b4ac-08dc0ba4db1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VbB6E+kUlKyLTKEUMYNtn8zpeZOXsQKxQ3AlNx/zwWjtEXGBwIAyuhwEB/7yBmHptiHg/MNGyclbosL03Q+oS339sSXhywkw/+l7SxiM6eYP7k5n5V93LdGNTZwxrvJ9NO8eeWl6/nutnlvZ06ptZ8KMmPUVdzjs9+Fjg+L1P4iRDvHDPff1xnrUk3ue281M3/npaJtGLSiwo6Mbz6oDZxKkswkY1HaJRqtuohJbWlzr6v/0vHq5wirZvw7bTzqJUtApFHALISBHI9x6DG82jpSWfqDr5R2TSYHAgwexH4TPjt6/hgbfIC+Nx8Sdr3ggYyfUemLuqXVpeolE0cRtLKD+84UFtYjHysAh1/7tsH1RhLqDHiI0oEcRBFwr59xmAMKmLENzuFaSb9hRB+fkvT4g5+jCs774268jc83R+AhWUAEZ++M3hxbmK/cLV7ta07x076Db2Wpzz1zZDLGJ5o7ljj0eizlv7yzXgCFKgHEv63ve6iCkvmfup49EGwal8AiEciY+/9gBcGT/lYl0f4QjhtK4cEw+U3RowFVM9QV3RaYbvQLtKLjLxml0H1tykOhkctxCTBeFvm/Vh6jKhTaPRhA4xs1bOJ7tWLCxNThUM/CvektR6wMs6XjI8KV5F2+5mvMrBczSSjk76OSDULveYqVePpXx+ExVriUaS1dH+5X/yyioYOGo95U9gkYrunw3S5gX4rTwy+uB4W4nZXBliz2tqEgDHCOANQE15oFZyVunIzPTBWPV1HXbBxx7
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(36756003)(6666004)(70586007)(70206006)(7696005)(86362001)(356005)(336012)(16526019)(426003)(81166007)(1076003)(83380400001)(2616005)(26005)(41300700001)(47076005)(2906002)(4744005)(5660300002)(4326008)(966005)(478600001)(36860700001)(82740400003)(110136005)(54906003)(316002)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 15:09:45.7217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1045f04d-f522-4244-b4ac-08dc0ba4db1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5063

This patchset adds trace event support for FW-First Protocol Errors.

This series depends on:
https://lore.kernel.org/linux-cxl/20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com

Smita Koralahalli (4):
  acpi/ghes, cxl: Create a common CXL struct to handle different CXL
    CPER records
  efi/cper, cxl: Make definitions and structures global
  acpi/ghes, efi/cper: Recognize and process CXL Protocol Errors.
  acpi/ghes, cxl/pci: Trace FW-First CXL Protocol Errors

 drivers/acpi/apei/ghes.c        | 26 +++++++++++++-
 drivers/cxl/core/pci.c          | 46 ++++++++++++++++++++++++
 drivers/cxl/cxlpci.h            |  3 ++
 drivers/cxl/pci.c               | 13 ++++---
 drivers/firmware/efi/cper_cxl.c | 63 +++++++++++++++++++++++++++------
 drivers/firmware/efi/cper_cxl.h |  7 ++--
 include/linux/cper.h            |  4 +++
 include/linux/cxl-event.h       | 24 ++++++++++++-
 8 files changed, 164 insertions(+), 22 deletions(-)

-- 
2.17.1


