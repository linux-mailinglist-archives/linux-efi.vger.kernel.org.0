Return-Path: <linux-efi+bounces-365-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEE0827D7A
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jan 2024 04:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB6DEB22BDF
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jan 2024 03:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C5B4418;
	Tue,  9 Jan 2024 03:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nr5O4Ks2"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7031B6104;
	Tue,  9 Jan 2024 03:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/cD2lQoB6pR9vUq3XyV8I7Canidwe4SstK1eOW3n23uGbUJvDs6OtWjwTiEtz8tep6+B1uhLFBFo95UeYBPQBFxNgpHCuFfbrMvLT97sJpv4CWb356XK1qvCPg/yftl30toqtIxK9BfTwKEPZ6fgkhgZMwdCiqPZgCenLEBxkIwtb4Z7PfKaen4aqsggGI5iU1PiTFH0GJL4853HSVUuwgLFlwJD4X4P9B5NnrTUJ51qO053k17/hnARtMXuBRwrRVanXKGH7oxS4aryrnHJGXKumfi1nHYPCYIkPcikS/DbjHSqSzcvuLjZqLVQAr01yvcPJpEZ1bfIcoPZS/VMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xw6Z29H1fS7gYqeMPH9VO4ZOwPu1poHxRZobEqOdXF4=;
 b=bENQmBiv7vSdyi5OEgtU+Wzx9seH3pJsGW6sbSFyV4cAmJ/cHs8uY3TD4zesx3jhaSSNXIFZKRI7Tr4pp4jOwv4z+JJe567xGOGGSZzq6yjLMdPvWgs2PczfA5ubBzmL8MVrI9r8PiWBa8jveyEJ1whbWbgMqqYp+kVBDnTwj+6aiSqdsfbkm8SqX+hm9Ybcy9LNK6MJm18OpoB1Eor+q+OZ/4uvMftMvGGhySMZ/OEHXYlJ1SKghT0tlB73JLEuDkMPoHUNKVetZvxv8JYfRYI1h3y7RwNaUV16kv8XIFFEtX8JIE9jB3U4xTr67jG82q15f0IkPPLfRPBtdaKDBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xw6Z29H1fS7gYqeMPH9VO4ZOwPu1poHxRZobEqOdXF4=;
 b=Nr5O4Ks2yrhFtkFK2KSkCAJa3PB5+b2n4n+ICaeb8Dl7gy6jjC3qs+010VmKKWMlL9ohVz+oSSVhZS2mo1p4nLq4U26989qWRdAYYAhSobed1+7LNTCk/u5M2oRd3Z4QnYTkZpjxuDT7vReeZ5B/5Gght1qntxA44LlgNsBrIfA=
Received: from BYAPR02CA0012.namprd02.prod.outlook.com (2603:10b6:a02:ee::25)
 by DS0PR12MB9398.namprd12.prod.outlook.com (2603:10b6:8:1b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 03:48:10 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::75) by BYAPR02CA0012.outlook.office365.com
 (2603:10b6:a02:ee::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 03:48:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.12 via Frontend Transport; Tue, 9 Jan 2024 03:48:09 +0000
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
Subject: [PATCH v2 0/4] acpi/ghes, cper, cxl: Trace FW-First CXL Protocol Errors
Date: Tue, 9 Jan 2024 03:47:51 +0000
Message-ID: <20240109034755.100555-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|DS0PR12MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a594de-ec7d-4d21-2bd4-08dc10c5cc0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PadBaYllaiUdavgyV2cKYjVOvXBACR8QPKmYZTkKeuk2pTNufIQjTj4WUtkYKFxRnQjsahVRpZJUNp5ODIBy1etVy82FMH+VlK2zDYytv9vCQKh41/EiXkh/NzlnADaF6LFC6xYQOkFgQE8yXLQVO7oraUogyeUfTJbYBIKTnM7jvzEfk4rtZ9spZJMKbxGdJ19g21m3xacT0L5kcSWmCBZ4V+tJAjAephGj1JZWqieMiKymf+J7xOXZ7liWtDSpYjVOXGkA7/tWQqamC2HL9SFNMz7ooBHPjjg6lKx79pMtQ+LtpMXjr76tT5tqCMMliKbiCOFQcbSc/es1GQhRjx4IFhqtRfofSQlf68zyUaA2KJf9b1zc/qlrFusrNYxbIpsK7+tI+Vt71ncyhOd1T8etir6xHsjBFxVW6cZpgJ1nLeCKqM/SB4AnEut7CZTSSnqWazu4ZTYM04HuouBQLvGwXVbbUGJ7oKlHETVup5BgXkyaxPhky11Dna9OKVeZ/4/HgmCiSmKoPsonLC3ddqEbxiklb8FGECetJqSIAR2hLZGyY+n28woKsi5Ty11QzMzFluJI6Z++OmyEYGGmslwu0j3PUXH4tiamDeYpuOYCxG9XYG4U7qbFX/ZcGmOqULl3VnQKF8dZytnBeF6fhfAMXSwxfaL51wsxtBaUuoDjR4ecY1bb0U961Qm6VrGXITmQVKrV09sUT098rGhlHrEeRKv90haLTf1vMsb/fb1Xdd+/Ne2cEyjeLb2N27PC3zwxz9w9grXCLw/O1sQSJDZRVEutyY2/CoupO2SJ4eA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(83380400001)(41300700001)(70206006)(70586007)(36756003)(81166007)(356005)(86362001)(82740400003)(36860700001)(47076005)(16526019)(426003)(336012)(1076003)(26005)(2616005)(966005)(2906002)(5660300002)(54906003)(316002)(110136005)(6666004)(7696005)(478600001)(8936002)(8676002)(4326008)(4744005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 03:48:09.5662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a594de-ec7d-4d21-2bd4-08dc10c5cc0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9398

This patchset adds trace event support for FW-First Protocol Errors.

This series depends on:
https://lore.kernel.org/linux-cxl/20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com

Link to v1:
https://lore.kernel.org/all/20240102150933.161009-1-Smita.KoralahalliChannabasappa@amd.com

Smita Koralahalli (4):
  acpi/ghes, cxl: Create a common CXL struct to handle different CXL
    CPER records
  efi/cper, cxl: Make definitions and structures global
  acpi/ghes, efi/cper: Recognize and process CXL Protocol Errors.
  acpi/ghes, cxl/pci: Trace FW-First CXL Protocol Errors

 drivers/acpi/apei/ghes.c        | 22 ++++++++-
 drivers/cxl/core/pci.c          | 29 ++++++++++++
 drivers/cxl/cxlpci.h            |  3 ++
 drivers/cxl/pci.c               | 13 ++++--
 drivers/firmware/efi/cper_cxl.c | 79 ++++++++++++++++++++++++++++-----
 drivers/firmware/efi/cper_cxl.h |  7 +--
 include/linux/cper.h            |  4 ++
 include/linux/cxl-event.h       | 31 ++++++++++++-
 8 files changed, 166 insertions(+), 22 deletions(-)

-- 
2.17.1


