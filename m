Return-Path: <linux-efi+bounces-4248-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2616EAFEB50
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 16:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1624A546C46
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 14:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165802E041F;
	Wed,  9 Jul 2025 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pGgkqWQH"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75584272E7C;
	Wed,  9 Jul 2025 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069692; cv=fail; b=rGNKkFTLddP/FyzB/wnVmhZcSMWGoiOzKQkBJgUA01HjP6UsOMLbpDsEATPvqWSGAVnZ00Ji5qi3uZecgcLfdPufBi72kLnHbN+baMmb2vtqs1FxJ7yhv9ZiCFzkgIN46NcWW6blFmA7zbuJN01JE7mkMCYW56XuqaybEZajBz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069692; c=relaxed/simple;
	bh=HWvWrk5LvvuJsUChA4fWZsrKMFulhYKVFOGDhGlrcR0=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oIxmTaTMo1KMKV4HS4M8IPIuG+2ByuYiS6gXvdoRWU/8iVmwQGQZ6Yy19r6DtbxwguvFv77D3UklcS+DrdiWC3jQRTGEgw6VcVbPET56qv157fHHxCrba6HmwBDLcgck4yxNJYwmhyDlqNzNEhuhGEESns/y7D5chS+AmuCsqLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pGgkqWQH; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyfcqogUTzd5mwyEaAaWUG6qLTOpR+jaqrUaKOlqymDfage0rNhIjf2a99Z2HFO6Nck1k8o84Y0uIPKqBYTdXYpJj0jZ+sBrMpprlEp3UfG97vA7fEB6M8zOkepn8lPfhzoXcuzOH/PJOYpBCqeONgOiI9k2iffkawM2DOGACD0I/UnlgdtwCAEpYjSwHxob0phS5QmrVb648uty1Xj6WDRVIUCoShKM21X03XC3c/k9HLwQomnMoPLuEgM4VwbaQlEt/Y+rCksom+XymbghWTYTysliXM9xm0sQinoL0XDg4vTtsgaS6Nu6UWG/rNDvJ/2cqskiIlPYhC3aHPpoSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWvWrk5LvvuJsUChA4fWZsrKMFulhYKVFOGDhGlrcR0=;
 b=vDFEqwu8r1hIf+t/O+lUflehx3iTPKpB/yz7JBNdAqyMzHkjp01lGwcFH0Pd8mudkCVzYKnAZzCPuAT2uWhBiB4xEDUnrud8rfjnHufNv7Zkf4sYXKpnxp+G+GYbXisEXcsO2NrsSxwEtIvuyf4EawMHv7LhBKldyYYb84OSucr/DDJXId6af15SIvG0xvyeW57uqAZNwnLP193Q2CMwwSLX242riBAV7usHLHxBPHf7Qy1tCYqCFHHMxK5tLFD5j6/RLYcZiHednAkiJmOJTOR6r4LJbnV8YGVfiwLLUGA1NdiBF5RvXfkvqfdYpiV4a+LmuxCdQ5Dp3AhPWejcHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWvWrk5LvvuJsUChA4fWZsrKMFulhYKVFOGDhGlrcR0=;
 b=pGgkqWQHG2xaRygJi0ev2ry6IC0nGfgn/NcHEADIn2M2GoLJ/BGmRXCyuggcp1jCC9z38s56YjKtGopME52HYsEbzhh4Rlc3F/czeGvA1V96IETXOKA1s7uk/0pHHhm1c/jcLdthTj8rglyR6exO5MydS+dsCt54ngiuuzGDbj8=
Received: from BN9PR03CA0065.namprd03.prod.outlook.com (2603:10b6:408:fc::10)
 by SA5PPF80B25317E.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 9 Jul
 2025 14:01:25 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:fc:cafe::d9) by BN9PR03CA0065.outlook.office365.com
 (2603:10b6:408:fc::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Wed,
 9 Jul 2025 14:01:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 14:01:25 +0000
Received: from BLR-L1-NDADHANI (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Jul
 2025 09:01:21 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: Ard Biesheuvel <ardb+git@google.com>, <linux-kernel@vger.kernel.org>
CC: <linux-efi@vger.kernel.org>, <x86@kernel.org>, Ard Biesheuvel
	<ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar
	<mingo@kernel.org>, Dionna Amalie Glaze <dionnaglaze@google.com>, "Kevin
 Loughlin" <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 00/24] x86: strict separation of startup code
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
References: <20250709080840.2233208-26-ardb+git@google.com>
Date: Wed, 9 Jul 2025 14:01:17 +0000
Message-ID: <85v7o1v4ya.fsf@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|SA5PPF80B25317E:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b60e94-5414-4418-fb2f-08ddbef117d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JtrYLvyIVgCFZUiBjOLa2A+IKmNfpG6/4cUgelmJpTsrXtUIjoq0fF88vUAV?=
 =?us-ascii?Q?ux8TU/mi7A1EMQnYKP2NEGTd1MfwU0TtiWEYvXlj4XOJpWjQHJFfJ/XRbojU?=
 =?us-ascii?Q?A1+yt/4dwsx9pqbex9OpGVCKxoiiemlHxpmAxWDYucB+fqbW42XUlZr6kgjE?=
 =?us-ascii?Q?SZjERmqgxTXTHEZZvzTsQBeU/sGu37uM0R6/GSMGmvO9RhrFxCvMXyhhE3EQ?=
 =?us-ascii?Q?HsxaevK2VM4SJLD0uh20zq4/GSVw841yjQfrXJxjf22ErRpcneV0x82M34s4?=
 =?us-ascii?Q?dmsAJ0gtcsLP3na+Z7GkSA4Azo3VIL4npWcPEfKZFkUl47glFGtLGHpG9YFL?=
 =?us-ascii?Q?wHuwQaViCb9qBs8tdCTMD0sxXr9T6mVkCoAvxDeIuVQ2/EsO1HIzJC1jgT+3?=
 =?us-ascii?Q?RuvXNo9juHXay3Ps/eDwTbSXXcvloLFZJDqu8M4iL4OswYWMSqYHNhifrS/Y?=
 =?us-ascii?Q?CZkPDNbF0Y0dXOfsTNl87BWoXptaM7Ym06vRgoFQcz4yxfHKtH+sK2pbqzC9?=
 =?us-ascii?Q?f8epSjkycnRkI5udOYGR0AfgDMw7FzahOjtfaOR5glmK5GUGgxk1OnYAgdNA?=
 =?us-ascii?Q?lhhEnNI0NWrQcRQiA8GNwkZALIAvdIt1rdto6QiqxvnH34dKfGORULbAwiPC?=
 =?us-ascii?Q?MLy83lQTCMQLjv4THxJi1gw/80RvFQIqL87CWor9U+InFoZd6Mrk4jr5w/aF?=
 =?us-ascii?Q?kblMdXJsoToGJShA1uk5VpTWKlewRbNcZasslbaJDT3meZfarHjIZF7burQk?=
 =?us-ascii?Q?UQFSOZt2h3TueGhPz1O0pRfwNACrRqh22U2HA1i2qyC3EUL1LRQbEzkgYDnV?=
 =?us-ascii?Q?A9QqkeYDdCH7NTcJtHkPLXGcu7BR0nl7Ygfu1dBZKPGJrv5cYMf9ZkuJQVy3?=
 =?us-ascii?Q?VM0tDDPLiRjePWIYBoglttSBotv/RIQlSoR+WDcht6zN4ej3BCDREc5wZvAj?=
 =?us-ascii?Q?+J7OS8hK3FYOz2+82R6RzbY/xJYHinQAFSqMSLZOBufMeefs9gJKLQtHK78Z?=
 =?us-ascii?Q?BoLrXWhs877+4lOFFebVDzRvkApyJ+RX7AZoWfU1A589DGJMBmql/VeB9g2L?=
 =?us-ascii?Q?e5heJYqjZ4oU6e4OqmtDZQOncSEuNG67L5POniw0+kT3jxRCi90PVgGSYTFe?=
 =?us-ascii?Q?PoAOJnGdVV3RV0IGGCdeU6qpjUzv1kHHBe6QtynvXQD4eTbpBAKshikUUEyi?=
 =?us-ascii?Q?8rbFshkxYLnx4IDgqQ8v7uv1tUbuJmrOnCPazPzqKhZEU0bpigz/AuiAkacQ?=
 =?us-ascii?Q?zYNkgo/EGq3ACEFvJq815ST8cYFZlYsxi8kOJ+JB6Sn6ISGSofIgppmrXuiK?=
 =?us-ascii?Q?GjvHR8FOWs5RY6jDZg3sWUcbBJBGbqkr/rGnLLWnTVKXEoegNz5SwlOINvJa?=
 =?us-ascii?Q?Z4xfRG8CWkn/OzR3TVzeBYg2SgVA1mHahxNYPoJq6kRGBHJuK5ROeagp1chf?=
 =?us-ascii?Q?rqUuVmgu/Hcrn33RKjKhVxZaXhqyY1FsRv7pH9EXBP0GgLsT7x1EOcaql6Rl?=
 =?us-ascii?Q?U32EWzey/GJ4Qbv4sX6afQSpuBL9SgH7QlXQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 14:01:25.2032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b60e94-5414-4418-fb2f-08ddbef117d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF80B25317E

Ard Biesheuvel <ardb+git@google.com> writes:

> From: Ard Biesheuvel <ardb@kernel.org>
>
> Build tested defconfig and allmodconfig
>
> !!! Boot tested on non-SEV guest ONLY !!!!
>
> Again, I will need to lean on Tom to determine whether this breaks
> SEV-SNP guest boot. As I mentioned before, I am still waiting for
> SEV-SNP capable hardware to be delivered.

This series breaks SEV-SNP guest boot, bisect points to patch 12/24
"x86/sev: Unify SEV-SNP hypervisor feature check". If I revert this
patch SEV-SNP guest boot fine. I will continue debugging it further.

Regards,
Nikunj

