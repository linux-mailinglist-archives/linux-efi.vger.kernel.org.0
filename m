Return-Path: <linux-efi+bounces-4746-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C147CB557AB
	for <lists+linux-efi@lfdr.de>; Fri, 12 Sep 2025 22:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7635EAA19A8
	for <lists+linux-efi@lfdr.de>; Fri, 12 Sep 2025 20:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F411A211A35;
	Fri, 12 Sep 2025 20:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ecW4poqz"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FE72DC76D;
	Fri, 12 Sep 2025 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757709367; cv=fail; b=GlRUqHj88LazDyjA2m/RKgb6jKiVv5osIAcisEailuTzvHQYf/R3d1PFq+FoDNPx3BgSJXw988FeKTw6l6snyBOc/ywtWbBuLkt2m69b4kS/BeGYNQUgBRvy0jlvhDbI7XFZTXwDs9LG0zqd8sVn6uke1v0bv8gIblimAoEIn1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757709367; c=relaxed/simple;
	bh=mh9qQag0Fi5XO0SRXRj0skHAba9oKk4Nkk8zKm3MFoA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NP5UWY/x/6X2KN8jjc6X7Y4C85lwC4KtSCuK2pfAlbhokrZrrzEtbyg7v/Kg6DkOAMz9/kxe22rOSUulbcA8P81YblCMMF+S32+7q+L5G73UO8cC0QpfXbBuaOkE7DT+mTghIZaNYkf6zrt+hRWtDsati395nHGssMlJImcj4E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ecW4poqz; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0twCfMNlxmV8rIJmL9oedoyTvtAFFfRnDiU9hGU7F/Q+vpXflsKmmlNCkIL6kj80RgXOu9auG08DQicfo5KowFubKttRHF6mQOk82bQlkBnEs97QNvdnqaGPfh4S6eeDp3x/5XuUx9ZDcOuco/HsFjpVI3z7+E20BvHZ8vKfBfuTuPVuskbqpJ412V9N8/ilLqOKDa6gW6rwZxjhw9hQgcpGF1jsH97wBcETRnpc9nCHuHBhPyh2SjD+nVbTUJvvGJajRC1MHJQooiVRz07UnjRL+BBYqBbFRHXQ9dYybGV7XqMgNVg59DXLIMKavZILjjjlxkkY/VRFIwOByBcnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bfqnl+H42l3Iq9mbj698nFahwkklG5kFk+f+eCPOpFo=;
 b=KQBnKeUUDD/hqwuCM/AlzIEwcm5FKB1le33IytDpb30/UaCEhRAc339mXJNy0xZzKtLO4Y7As35SgImz0aBeBXxUtdi8FRh0AJTFKcY5a0dNNx4ghdWnXfqZmQeLGZhr+GtWJZLJaL7V3vmqkRFkKlOz2X0xr6DQ//DjL1MpQF3lQKJQwSs9BNWSAyDZsya0Dnz0hcUcxGY2OH/fNaldwiv7b0pV0PYZA8E+5mZ+uWrvHMSiijW+lJffKNa6BM6r8AlOTrC2OBNEx8yWe1yjs0PqSa+ksTZTEvH+xxqO/2m0IS3ojQDWcWGYtK+wgxfIH+cka2IqKv4wWOcu339HSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bfqnl+H42l3Iq9mbj698nFahwkklG5kFk+f+eCPOpFo=;
 b=ecW4poqzkXSAwpWpLwD4DTYjPo318ASMWVuzzibyy4pHa+K7UvZUbyP2V8BMa1n1KSFtL5ogwsOVZ5b07+5SQ4zzNjAkVyM6sRlA6euBi1MyfJAglIDyVpdfRG7BDUkmDkCHHCv1vAIYl5LimtnXwFiiW9LkRat+FiKdnSJOWF0=
Received: from SJ0PR03CA0054.namprd03.prod.outlook.com (2603:10b6:a03:33e::29)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 20:36:00 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::88) by SJ0PR03CA0054.outlook.office365.com
 (2603:10b6:a03:33e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Fri,
 12 Sep 2025 20:35:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 20:35:58 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 13:35:57 -0700
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <ardb+git@google.com>
CC: <ardb@kernel.org>, <bp@alien8.de>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <thomas.lendacky@amd.com>, <x86@kernel.org>
Subject: Re: [PATCH v4 3/3] x86/efistub: Don't bother enabling SEV in the EFI stub
Date: Fri, 12 Sep 2025 20:34:43 +0000
Message-ID: <20250912203443.16159-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909080631.2867579-5-ardb+git@google.com>
References: <20250909080631.2867579-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|SJ2PR12MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: a6583635-b69c-42f8-4a61-08ddf23bfb01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0r9/XcMO67hzJ493yJL8RjHh9yMvcMEd7wXE+Jh+o+KM5kPbxj8U/BhGPZzJ?=
 =?us-ascii?Q?C8w0ZbLjwKmNKw9dBadbveCO3K1ZpAAfHXOPTpxGF+HUQVHRFtbNxN7tzWtG?=
 =?us-ascii?Q?qtCtVosKxfltT+Khm2TeIFo6zeH3xCsZ32W/fIyy9MwrZhlymQNHbnsy/SDk?=
 =?us-ascii?Q?v60Zx3TbzBT8WPyy0bvUL0jbnFi+AN516TGH0afq6WDF/mQh3wWTnUXJ7NS0?=
 =?us-ascii?Q?fF3Nc9d6MbEOZOTb/G7CNigntInuhJMVNX9f8NyomdEQzHNW8giHjUstYET/?=
 =?us-ascii?Q?59jEZk1Hrnn3CwHmfjpvlImnhlXag7ge96K+95+FztS000zAzUtn21O7QtGg?=
 =?us-ascii?Q?SSTqNTW1pt4l7Fwzaes4eNoFR1OkTsxm1uA3vwqL9eejQ0idw8oRuKY7MkHH?=
 =?us-ascii?Q?A16vdZmapr6mIrECMnKIUladzsXMBbD6fMoCCFdH7FlYp/dRWN7+vW+YayiS?=
 =?us-ascii?Q?XMOqEDpBU5SmdQsu6dd5eRukC7chw+JnrMBZglHcHSXjftTOWsTY83OddVDR?=
 =?us-ascii?Q?k+T/Kf+J9IJkBwBN16ct0lXKPD2BOnqbXmot1o5U4fbmqtOVsJmfp1PYS6g2?=
 =?us-ascii?Q?2Ake3uJ/N3tTduJWA+yn5XE5fT4R8kUDjdlb0BFUS0Z98+Y/+ZbMh1znghEK?=
 =?us-ascii?Q?081Pur+HEjAtuGPkr8S5RLfbxwNb7lA+lKe2a6mEIKBYjV5XEFcxSXK1LUZ0?=
 =?us-ascii?Q?fZNzp+aRt9XiHJkUyhjkvwo31t86DWadD2rz26e2O2iGIw46q0Py1KJaORqY?=
 =?us-ascii?Q?8DbI9KVIKe6l+JMsyyaycjuHiVq+6pvuaHzgyaEvB/xLmIuVxQOLvF1HstQx?=
 =?us-ascii?Q?2feBVYLpY53jjc9t6ktrjMeR4/dI9230dQHDPujX8b1mhb2SbXBWr5w+gyK5?=
 =?us-ascii?Q?qU5tLQickTCBGO0OTFiDVTc+URiwzOsTQjEJIHxXuw2On/Pi7MK6H1uXCiab?=
 =?us-ascii?Q?ggdypCq/2aMuvTJ5JyslMaz5vplO0XT3s6p6LoG0EPcE7PoWA/nZx5sXdsyn?=
 =?us-ascii?Q?A1b+uLLc/sqQJNu/wqhAbGnrjl25/tCuPRV1eN9u1teng8iyP21VxvGOiczF?=
 =?us-ascii?Q?GoHTNGwkA54obR1qMJREWhwbuXPw2QiTP9liycNV7KZbVCmiaafGAH4RLH3o?=
 =?us-ascii?Q?UqlrFOiKIffpriOxdAFS6Gp16BP1PKJ5HUJS28kUJOf/xCCgTsaJRF9beF7t?=
 =?us-ascii?Q?UtQRj3WS46m7VUKkOXK8kvjbkvg4CosSI4/+Mp45jHBiUbLdPJF6bmIjSGtE?=
 =?us-ascii?Q?KjQxRUVmwR5fpkxfMLaMzELzXcAnurmnWcW77gPbguNteO76LbhsaJ0sOyuX?=
 =?us-ascii?Q?M9/pceXcqomOlKsH18CXgPlk3WjHGz4WKgNANJlCZWG7X8BxpLc9fX1WzrkG?=
 =?us-ascii?Q?rpw+KBFJbm73ObDajhc9/s96yeA8bPJVtg6VhrGVJ5Qx1eQlzF2wPtCTmZZ9?=
 =?us-ascii?Q?irjNrfaS7zdiJbAJhWQeh6nJ8KRweBgLO4ENvUezV7f88TIU0/lEO+kDTPFN?=
 =?us-ascii?Q?bIbGyG90AP6iHZiMYf8Ny1ze6tmvfLDbaBkm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 20:35:58.3283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6583635-b69c-42f8-4a61-08ddf23bfb01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884

From: Ard Biesheuvel <ardb@kernel.org>

>One of the last things the EFI stub does before handing over to the core
>kernel when booting as a SEV guest is enabling SEV, even though this is
>mostly redundant: one of the first things the core kernel does is
>calling sme_enable(), after setting up the early GDT and IDT but before
>even setting up the kernel page tables. sme_enable() performs the same
>SEV-SNP initialization that the decompressor performs in sev_enable().

>So let's just drop this call to sev_enable(), and rely on the core
>kernel to initiaize SEV correctly.

If the EFI stub no longer boots the core kernel via the traditional 
decompressor and jumps straight to it, there are some specific things 
which i see are being setup by the decompressed kernel before passing
control to the uncompressed kernel such as calling sev_prep_identity_maps()
as part of setting up the identity map: 

From sev_prep_identity_maps(): 

The Confidential Computing blob is used very early in uncompressed
kernel to find the in-memory CPUID table to handle CPUID
instructions. Make sure an identity-mapping exists so it can be
accessed after switchover.

Won't this setup in identity mapping be needed to find the 
in-memory CPUID table as this won't exist if the EFI stub boots
directly boots the core kernel skipping the decompressor ?

Thanks,
Ashish



