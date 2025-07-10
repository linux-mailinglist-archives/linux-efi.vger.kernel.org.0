Return-Path: <linux-efi+bounces-4272-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A1BAFFB96
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jul 2025 10:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6B577B731C
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jul 2025 08:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEB1286889;
	Thu, 10 Jul 2025 08:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sar5fLI/"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0A22877E1;
	Thu, 10 Jul 2025 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134566; cv=fail; b=n0ZROBcIqIhZt4SERkDGXHKTVcQ20TN1aWncB/LdAJ/MIwPaPSsTQhrUXwyRjPeAxaroZuQ5qHFuCju4BSuEhbwKkADyYHmI2Xs6cfI6mRoSXUa3P7rCj6rsB/U8c/k2TjmLbTPxhPpanEHsKsDWsOs8NhndNC/D/CVNAELroB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134566; c=relaxed/simple;
	bh=mUY911TRFzj6QicxyFw6xg5n8lpiNeXyT+rWsYuEQ2I=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b73iyEHkIlT8QwfBujkEbIxMhqkSaVAWQZX4PQgJPopJpWwn75eE3gYahyM/JHUpdMydliusp/WRJuBMOR4h57qmDHkjxyBVeT78cuFSIuGFwqhGdJGNsMKLLy7K8V+U/ZXlKqSmsRCoj/dDRtvuXOjNlp8DqrM9uRVEDjT/EGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sar5fLI/; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqFNOox1LmMGCklSjsBK6QoEpth4/BeQqdzLAC7G0DzDkMNS9Gh2Av+17Ga5GFAVTjkM/l1t6sjy0PNQL8+mjovqe0xSdsAPbWu+JVek8lBxGEY5stM/SIQbSP9tByX6PmjmGBScDR8t1MAxZCASUZhqPGCSlG/8tcjHPePWjdm4NS6KZli+NOCEOvSeVYpt3hUTaZjUNfkq/UYyPEeGmzC2sEUGRmoDNNV9gxRCzvZj6FDdkGMsr8nxv+IOMlgjM4gM7Y1gsCDBTsY1LB0q4Ole4tA1ChEnfxk225xGIdmaDE0PTLbHs/DvsDRJ1nDb77mcIQqySyLdz//lKTuD+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUY911TRFzj6QicxyFw6xg5n8lpiNeXyT+rWsYuEQ2I=;
 b=qb/YvhnJWVTPJcKb75pQYWC/EgIOfrGIqHqj6NxiXFArB78+/MILJgHHenRik6NShSX/onWEdLOWr5Dl9u6Q6lHDE5ptTJ4qen59g4lLD46QNBnbYsBgugeEFUzi/Qj/9lWWaKOyiJSUOGAcoww+dedSTNhUonr66hX0auLcRsoKJOpYKOJ90bfah0CRepq6fiV4EZUrCs99d/mYKanqm1ZBmnGs24OfDuGgUWHttmINxbVYgtSWaUsbWVWSuQuKcPRIuopxPzqFtmWHge9twPRNRWO3zJg4Swibnp+vdqL80ITDrnCg/NupkG6htSdHHysz0+9itt5IAxgRVMFNJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUY911TRFzj6QicxyFw6xg5n8lpiNeXyT+rWsYuEQ2I=;
 b=Sar5fLI/nF6L40k3FX5dHefXTKktEVFRA5RrU55PxTibMfiQMYJrCzd5g+db0C6NFyPhG0yro7ttN1lP/9uIj/4xEFNarq4LQqj9Go55Cr/XkSJGlrsjcCbkeLr+V7PVaEiEllgSeki1/nXJRDtmo0VdL/IDLDFU2dqy+GKrzos=
Received: from BYAPR07CA0088.namprd07.prod.outlook.com (2603:10b6:a03:12b::29)
 by SN7PR12MB6741.namprd12.prod.outlook.com (2603:10b6:806:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 10 Jul
 2025 08:02:41 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::d4) by BYAPR07CA0088.outlook.office365.com
 (2603:10b6:a03:12b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 08:02:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 08:02:41 +0000
Received: from BLR-L1-NDADHANI (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 03:02:37 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-efi
	<linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>, Borislav Petkov
	<bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, Kevin Loughlin
	<kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Josh
 Poimboeuf" <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 12/24] x86/sev: Unify SEV-SNP hypervisor feature check
In-Reply-To: <CAMj1kXHZhFQ0DQWGDXtX4+-RWUFgyfL1qJh4hCONdi29NeBzhQ@mail.gmail.com>
References: <20250709080840.2233208-26-ardb+git@google.com>
 <20250709080840.2233208-38-ardb+git@google.com> <85qzyovfov.fsf@amd.com>
 <CAMj1kXF73myE9sKos5j9ErZi14ExDQBDZvp8PEhG3K4PELQrSw@mail.gmail.com>
 <85o6tsv8m2.fsf@amd.com>
 <CAMj1kXHZhFQ0DQWGDXtX4+-RWUFgyfL1qJh4hCONdi29NeBzhQ@mail.gmail.com>
Date: Thu, 10 Jul 2025 08:02:29 +0000
Message-ID: <85jz4gv5gq.fsf@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|SN7PR12MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db0eedf-175a-4084-13a2-08ddbf8824f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f0MCOha3JGPnqJ25+wfWPjRNC2JbuIALvRPSvDx731EtmaSajjFgEolCrKqr?=
 =?us-ascii?Q?Pfd1gV5OfbicAUVBo8bXdMIMENNQ39AAOgKpm9T229Ni7g23or4Zq1LuDi/S?=
 =?us-ascii?Q?NomWEkJ69+MoDOZXbM0tVXSFLGxs6NnVj7JeD09YycmpU8wD8k9r8BkUZtYe?=
 =?us-ascii?Q?H7eSXcEgxIhj1wNNPnJeWtWBNzdnbYtfOYFSndM9W4gLzuAT0+QVJDMDvQ7q?=
 =?us-ascii?Q?0MCgpY5c2BbQkjpHG3fPcBfv70xX3Gez2l/XPSS4eW6vRVmYCBiDCUdU4zVp?=
 =?us-ascii?Q?uYA7RXkaAIuwBVdrnFMsPBZ6vK9DDRRJt8Fg6emGiU6YLqSqqpwGGQzc+ZWV?=
 =?us-ascii?Q?QvoyGdzyZFFo5ocLnhI5A2EpFJB8u33KFm+dErb2pFW1cdcedcO4H5kp581K?=
 =?us-ascii?Q?JUzB2o8Q7jHUSghpcSaFe7uJpt4ztbXlhtXN8TuX6fJnpJDYx4yNB3WWIiOs?=
 =?us-ascii?Q?5e2mM72VSg5nqL3RTrYX40qBqX5q8KL77vwDqH0HDcfVzPXjy9ZgLnFtR6rS?=
 =?us-ascii?Q?NJWYWcbzInxT2qcZWpDcpzI1qDhi6W91rKEcv771iebDs5+QLajU2aD1aVrj?=
 =?us-ascii?Q?H1suO377BRn+LXI8a7WslJJ+1iZAv8UD9um02NPqt+R+vdIgRdW+G8V+yh74?=
 =?us-ascii?Q?Wuh4Qbj1NP9XbQQp78KD8Xi4wqDAA/gx7Olsn4MyDQKnXt8xYIPVN5SC9sym?=
 =?us-ascii?Q?GEHJUF9KndBJC+vBKgJ3eKfSV27FlxBaUn3pWzEFPZ6E2NvnxcuYcoAuL2AN?=
 =?us-ascii?Q?hRYpjYdJJoL3r//iuLuPXsPYj3Lx9TPoGs3z+Ukl9yQay7DW0BLL7baFV0Lz?=
 =?us-ascii?Q?8gqWw2c1W+9H/obCBgvmDg0mphV15ryb4smxH5xB2JUaGekqO1G2cq5ROyNV?=
 =?us-ascii?Q?9qIGPRqKm2faIM2fKqp0fcShO1NWSaDeEh1COMD4zA0jwp56gnY+5SBhsQxT?=
 =?us-ascii?Q?ua07Q65EzyNdeXGGgDvppPZjvyRSh8TkFoK7SGqJaHlpIHOTjF9XuxqrWtXi?=
 =?us-ascii?Q?gCBWeV4yaOes3wMl3tcdVd67GQNliS1WeGBDbgOpc9Ow2jVsEyZ0peVs8GAr?=
 =?us-ascii?Q?seeW7oG7EJr5M8yzwACGcQ5RhO2cbHR7XsbMg02rnNFtAHPZKYitvfnGX3sz?=
 =?us-ascii?Q?fh4ADxtBGjtfxkGAOyM6sii8NoFOxXwdzXTN2v00L/uoq/K1AM53QomrQJEG?=
 =?us-ascii?Q?JBpgqC018tUJ8GGqSAlPgTXrhlqLU4KAXCmUgkx+dHr1l4Z8dCjeFJEDIFVo?=
 =?us-ascii?Q?v68xq53UPpZQd0K4hwU2CGAeYje/37LQFqy6SS16xjN3l8G1cWTB42bKrhTO?=
 =?us-ascii?Q?qL7d77zNihwexx+vV+HfSuwY/AYfgmpF0VeZQNUnrz493yVK2l8wh1v2AIoJ?=
 =?us-ascii?Q?JR4vgDvIQg5s78H4TUUoC9/kHRJQrlHIdn+vS5c+Uz9A+RgH9rWjobfruMzz?=
 =?us-ascii?Q?w7RXytP0LyKTFNZQuLgZUexef+VodpXxT1WqmGpToKS4HVha22MfIBEgOGFk?=
 =?us-ascii?Q?p62yJas3Z8kjzkfJFaIpEHl3JCV7Y3ADebnZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:02:41.1623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db0eedf-175a-4084-13a2-08ddbf8824f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6741

Ard Biesheuvel <ardb@kernel.org> writes:

> (please keep the CCs)

I hit reply instead of reply-all, thanks for including all.

Regards
Nikunj


