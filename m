Return-Path: <linux-efi+bounces-5936-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC08CF43BC
	for <lists+linux-efi@lfdr.de>; Mon, 05 Jan 2026 15:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C26223005F19
	for <lists+linux-efi@lfdr.de>; Mon,  5 Jan 2026 14:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F219E30AABC;
	Mon,  5 Jan 2026 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cQ9vZv8M";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cQ9vZv8M"
X-Original-To: linux-efi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84D53A1E72
	for <linux-efi@vger.kernel.org>; Mon,  5 Jan 2026 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767624627; cv=fail; b=fL6Dt8wAnQw5bOFnXCUZr4GOjgcXON2RmB5PHCQW9RNl2ttp9yDuRBhGViTXqBcj5EJtFI1HuIKke02yItG40Q+EmmvbiedyIKlZhZl1rHSwv1fXCdipaj9UcXrKEstxOtTjuCVuOJ9MbOZ0D2Zhfj4v9GxoTCPkZJ9c3eNS2pY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767624627; c=relaxed/simple;
	bh=bsf5zsV7ewmfdAef67IFWiToGCbIMDy6HhPFH5OQbLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sNRo7qNbXCFEXKQpTqEzmRwGlCe23rGpMTUgRdIsMHc4EVbC2lJvo1OP5HAX2zeymcRcAGIDun1QC7MQW5kJdX6+aN1ijKT/4ED4SRKeB/1lSFxTZqr7DA9OYE8NrvGbjjibQ6iGibyag+b4QUm56glS0Ea0q/tsv7we2UZwGe0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cQ9vZv8M; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cQ9vZv8M; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=rb/nv+9GT9SyfVdSHQZMd8vPQ1CaTS05I5nQUnqyRlOeTFTW0ykPQl5Lex/5h8zK+j39XaHwWulmEcRLEz5iHirEv52sONAww0yLzVna2/JCcUXJk6AzKNT5EQ30rZXReZIe/FxgfK9JILvKw7vC/ok1McxFuSLIFyQZ3VJIDbflOeEfyrNZ1bmAzaDepkqv1Nwwd+nNWfgBWF+BdO6YEUS0cJKHqG9g7Xi3e6glvlY4UvlCX3Kmb7NsjK58Vpyd+59fcJtNTo9/kLhMtx/IhxYPYeuCPfXGZ9v3cexTFfjdVxFGhkR6y04HHGSPFkU0uorne2PokEoWB3bpuBmPIw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPOi0ltjpHpUlu0zw5I4NwGLj+xVsPpMDnYDnVYVy64=;
 b=ak66TBD4xnufojlbp6Wp/XqKGoyfBuo+3K4vYKeCqev/mfArK1oKFnjkzFidQ8JfaqjUJiRjCnJuEPLyxlS/R1ubkoTSnMhVdvm29zbcYoYV+nNok3u7WI6X63G9TbiZths9rurzuccrnnvp/0esElu85Zm+6VloOMTwgQaCxA3p6SMQRlbq/IAyUBVcXEa6zHpRp2Vqxmj2le0nNofHbzw83968kp1mHqLXxOSZflSNqKhMbBCHU0K4adlIIr2+NjC6SLrz47dLUM6vZMSzKCUAwGsUqa4GQ3OvFvTGzSYBE34lHA7X98/q17cqMKJlRqtUInUJOEghxXv0pwGtbA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPOi0ltjpHpUlu0zw5I4NwGLj+xVsPpMDnYDnVYVy64=;
 b=cQ9vZv8M/hiWAzYIrdpPFy72URfzwJcXCMxaE29fSVQ92rbyqDTvcz5fkLzckQJHYm6TOCTuqMpz3ZY4LFLTIOFNTRYgaCyVgLeY9pVC0+koli82hJ69MClorUO7IDuePBQU0ecJfTNn/CrFI+6drPEIqzDDh46KiXkGormGvsM=
Received: from CWLP265CA0412.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b6::23)
 by DB9PR08MB11473.eurprd08.prod.outlook.com (2603:10a6:10:60f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 14:50:21 +0000
Received: from AM4PEPF00027A62.eurprd04.prod.outlook.com
 (2603:10a6:400:1b6:cafe::3d) by CWLP265CA0412.outlook.office365.com
 (2603:10a6:400:1b6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Mon, 5
 Jan 2026 14:49:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A62.mail.protection.outlook.com (10.167.16.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1
 via Frontend Transport; Mon, 5 Jan 2026 14:50:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYCKTjKXUz0BWO5JESKkkVK4eQl6RliYFry8sLjHMmiNEQ7Hek0YOQd/xAh+J5KCeWv48/uGQIoZNxkUx/hI5b5lXdMjx9OO3XYEBvyd3SLs4emqhHU7b2mBp2jambZZGuDKf0CYS/mAz/oPuHG0g421Aae1GqF01tOzExRE8aEdxlWiRfzTLTe4XeRyuTwthA8NWq+NFyjjgweWrplgKwRef5bFCBPlUpugB84odNWDtCL+1xQ5USE8TbywuZwLFjXxtlb7Af1FKE8ZWoDg8E7w47FsjpjM23CiNj5FAOYum92S7CnOhgYEFjVU9650b0kpjf++9WR+DYSsrrILRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPOi0ltjpHpUlu0zw5I4NwGLj+xVsPpMDnYDnVYVy64=;
 b=IFjh163iBE1gSvjI+2NcqaRKYjqisac/ptJCk/dBD/YWY0bCs03MuqHN6OWoO7eswh65fIfZ7Li5gwjT5BXFGmEpkrYN8+NNq1yHCU1gnS+ieutTttv15gm6NQ3RrY6oYBSSCzx0Si5oeET4qpszZ8vLokKFDv9krqG6LpjsifIK9Jtla8Ihp6JGGG8PBVHA+92pPtSjHFfCvEcJ2ewCLwPVAFMqDWm8c+zvZJZtMQ0oTGwGKUuba4aNO3ppswHYFtJQWC6NBqcI1kvWN21PL9IlBkOdtX8mI909DEXmd4ztkV082qrARNMdhA3l5/06XKbNs/M8SM0GmWYR2VBLyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPOi0ltjpHpUlu0zw5I4NwGLj+xVsPpMDnYDnVYVy64=;
 b=cQ9vZv8M/hiWAzYIrdpPFy72URfzwJcXCMxaE29fSVQ92rbyqDTvcz5fkLzckQJHYm6TOCTuqMpz3ZY4LFLTIOFNTRYgaCyVgLeY9pVC0+koli82hJ69MClorUO7IDuePBQU0ecJfTNn/CrFI+6drPEIqzDDh46KiXkGormGvsM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PA6PR08MB10526.eurprd08.prod.outlook.com
 (2603:10a6:102:3d5::16) by PAWPR08MB9854.eurprd08.prod.outlook.com
 (2603:10a6:102:2e2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 14:48:04 +0000
Received: from PA6PR08MB10526.eurprd08.prod.outlook.com
 ([fe80::b3fc:bdd1:c52c:6d95]) by PA6PR08MB10526.eurprd08.prod.outlook.com
 ([fe80::b3fc:bdd1:c52c:6d95%5]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 14:48:04 +0000
Date: Mon, 5 Jan 2026 14:48:01 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Ben Horgan <ben.horgan@arm.com>
Cc: linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ardb@kernel.org, catalin.marinas@arm.com, will@kernel.org,
	Mark.Rutland@arm.com
Subject: Re: [PATCH v1] arm64/efi: Don't fail check current_in_efi() if
 preemptible
Message-ID: <aVvPIdREAdweYqZf@e129823.arm.com>
References: <20260105135847.1585034-1-ben.horgan@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105135847.1585034-1-ben.horgan@arm.com>
X-ClientProxiedBy: LO2P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::14) To PA6PR08MB10526.eurprd08.prod.outlook.com
 (2603:10a6:102:3d5::16)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PA6PR08MB10526:EE_|PAWPR08MB9854:EE_|AM4PEPF00027A62:EE_|DB9PR08MB11473:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a3f68d-0af8-40dc-3289-08de4c69bf6f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?zs5njY5RZ4B+j14lF+DgRzr5A5AE9G6qcX8b4eDjSoZ2YMhVI8ac6PmAsCLo?=
 =?us-ascii?Q?6M7ZkOzG/VHeAHLMhXY8xmIsTQ7aZNNM7uDdNgC1MpNvKIoy92WDt4CJx8aN?=
 =?us-ascii?Q?eRY3j13Q0a6FXPyQHjVD+kKqh4FbUeFfViMswpUGQIz8H5oIxSa+Vyq1R10Z?=
 =?us-ascii?Q?ToUe7Fc/ORKDNEcqEtSqwVB8R2yMr4XYC/HqL2tX/mQfCUAzvrOHWUxuiSkF?=
 =?us-ascii?Q?zrQ857eN3+F6z/Nu1nOUm84vZD9tA0C1KT1DZ3TdN2mSLtih9HROiJV1C5mr?=
 =?us-ascii?Q?b9JekQkWwW6Cy4ZI9GgCK26IIl+i0Bf1b+35n0GVdLnqeXv+KZUyjyGemru7?=
 =?us-ascii?Q?ge7Zyh3W89Mf7J7Ix37vnzpLohIZZTNWdsD4w+B4QysTxvftRFqbl6hd7A87?=
 =?us-ascii?Q?e6quzjcnwUtu6pkR5Z/nqe675w+MY4xSHSsGsPAhldAvyohHvdaQ1nyQXDIG?=
 =?us-ascii?Q?ixXXzLfexQxCHtVdalQr5SO802S/5u3uJlk6jW6+i/Q/e1NQzlHCbrTTrOn4?=
 =?us-ascii?Q?vgkIl+Xs1A/E/qc5CLVkxn9cjcyTa7xN9dBRDZZ2T1uh+64Xmr5oDu/NzKN6?=
 =?us-ascii?Q?R7aPJ7NPsZUznJqZZ6kGEpEflF60CkL42JhmzZRvNljyxuSQpU1T+av3vOb8?=
 =?us-ascii?Q?dMuQ4DosnpYuYc7ab/d0Bqk4Lc6zh0ttnAsXziqVkupwHC8ut/Q4R/wQ98V1?=
 =?us-ascii?Q?GV3zaB4e3Rdh8WP21sRFNMNsG+vzX5+eYEMGA9R0FIpfTeQi2Rl/6HOyAGAp?=
 =?us-ascii?Q?7qvO8/q/Ti9U4G6kP6FvHjn3e0FVoFfvtbTRNYeTAQwI4eawhlZ0T43dJhMr?=
 =?us-ascii?Q?Q8ilyc3/gMzgsYlwWn94LoNx5ukxPQ0Y+EtkYKg/nRFLPJ8CbXTkdyzQsvch?=
 =?us-ascii?Q?Z5ZBe6TrjD1+mhqmb6R7sB1Z8Hp0CZm/QjsFzLbDLGLKIcE7KuC8rpwdEuGy?=
 =?us-ascii?Q?JkP34g8O0m4sIG3LiV4pAozDALTilVD4WZ2ogx1gFfKyH9MRChaIXlIyX930?=
 =?us-ascii?Q?dtP+ndSS/1qfy69mXszGaFVDEOy6EYFFxOi2fJ07rG8PB1Tvh5eFSqYkQy42?=
 =?us-ascii?Q?tQ8x83rUsQNyZPh+p9yoYuossB+7iJfnG8B0UfktuoX0OkaR4u2/jQDup9Gs?=
 =?us-ascii?Q?PTpDaP3q2jZWFS1SgDRj6udUm6kyMuV9+BwtwmotRXyEZeTCjaJanBwpakcL?=
 =?us-ascii?Q?WQzs4N48trArYHKaVgWTEyiwZ8e6maaYKRl+EPDT2B7YM3h/FQ4yNEHSSlwf?=
 =?us-ascii?Q?Wkae0nC6WaRuSmTSaooFDszI5bdkpjHh0nJKaJ7nNi5T5N6PbgmQ35F7f3Kh?=
 =?us-ascii?Q?bakvHbSR2s43rPiekze/WpXMAVKaeU7Cr9Mi3JcYEX3U4BUSP54jo1CeLKt8?=
 =?us-ascii?Q?lA8Ct929ICuitxm+tNHNA1kxU2yA7Ib5PeStG0hcNtEPB6QQmqPVghOELeL8?=
 =?us-ascii?Q?mG2Ll5p6o+dlmTMjhbDkbp3O5zKYc5Jy?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR08MB10526.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9854
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A62.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8c9e89aa-fef7-42c7-ddd5-08de4c696e3a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|14060799003|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V6nPDVAhjgG2NGAx6HwSTj1YX6XWLIDfDzDQnTRbKgeMluwU7Ot4ArF52/Ys?=
 =?us-ascii?Q?V3Kis9BBHlQks++fScs+GOmllq7ZQO8/vmHvw63IL2p91mJoMmq22AUDvLxs?=
 =?us-ascii?Q?I7YlfbgPS8evyV/1RkFIJcmeBZm55cHXHpwOP7XReIQ4pFkYq8K9tmEsw6Nq?=
 =?us-ascii?Q?B0IIcJWkyvbc9vASJfkwyNG8s/YvpQG6UCM7/4DmLN/Y3379xffwQry1hVUq?=
 =?us-ascii?Q?XW+o39MGXSnQPQ+9UBz1BuDDN+fSPq3HL2ePDbalX8Uy2Jz2PxL6bnElrrLY?=
 =?us-ascii?Q?EHMIsTLQdS46LYgfSWw09BV2mMMcXac+0MhfNVXblTqTiy3M+Nt4tqQPZQlP?=
 =?us-ascii?Q?Ikilub+Evzt0+BSlF0sRkb2BckGYonYh30zK8NNvyktgnOaCoSgF5O8ZG72f?=
 =?us-ascii?Q?Q3jhBhpO8Wa69PdgAsDuOOJg1UeY0l8XhnSsoQemqfVc1PrgVIO6xCP63OBb?=
 =?us-ascii?Q?RENLXcQ+TOshLTRCgB596q9QzTIbyrn/1CFj90cYsOHeuwyDvk8GJlsRQdtD?=
 =?us-ascii?Q?gZ42UTUyernRPxmvjKFIV0R54f+BwdfDUOhVzk8juCmMo4wZ5+JtbN3L18dl?=
 =?us-ascii?Q?C+8P1uZwffE4OjuaWAQTNthZVW3tvo7cmieeaUXYgIoPDrSp8mkeJQyIpy6w?=
 =?us-ascii?Q?+J+q0s6xNB9WuXGNUtuD1lgyJzCo0qbYiqZvs3bnk/klm5UaEh3TH/uoamhD?=
 =?us-ascii?Q?p1aVb0Zmux21YQFJDc7CDe+SdNKiW2q0RG2Oqluovw5dph/GGzfc3lPmFaZk?=
 =?us-ascii?Q?enBwv5aP4RH9xLovFKSB/EjTjMtZWb15rccYrJU0pZ68N4xCI0ZSYafOJP7y?=
 =?us-ascii?Q?Y7ZMTcBjUgziRaPGHQIuygwYAgtbAUW3L78pA0O3o6K6QCTR6bSdpaT68IV3?=
 =?us-ascii?Q?AwpQMxqpgUv4E98e3Mtc3brYMwnbah8Br4rzUB/z5tb8nMfuD/FwbqNP3KK9?=
 =?us-ascii?Q?0SzGK4/vrcVwsSXeKGcJwAgxss8Bi4/PEWNrFQ7wLYtgHlAS7lrLVXd8r9Xq?=
 =?us-ascii?Q?eRHvxJpppg6GxNu+KwP5xwHVLYyPDMf5G4CYHL6TLcdnFJHLxa+WVcs7xlQs?=
 =?us-ascii?Q?jHTzbS/4WXGLn/ADBC7m8or1g4ZdzfqpqM0pt3n0SQg6pyH4YKWwQBvyEhMX?=
 =?us-ascii?Q?62LGYRT5cy2Yz/7/d5Q+Ea24aHz639Fc9X3/T8kmBMPtqywYTYiGMYUYmSAy?=
 =?us-ascii?Q?EYb9S5RcwGvJbOynk7+djAko31zrD/Gl2wMJjpjwgGgzrzhi2NDB4Xv2Ky3u?=
 =?us-ascii?Q?8u81/tfvsKHkqFI94RL0AheiRwt659nsQGGJ9+AYdx3mGCy1ZmvkSULcxvQK?=
 =?us-ascii?Q?Ep03hXhMs8dPeqzYgxBbgHAlbuJC1tislJCi+d01rbBBgKU0NJGWEqE1fcsL?=
 =?us-ascii?Q?ZHVDM6djTGZriYXJmgo+S59RkurBl+AgyL4sR8QxHPQXYx9NSDQnWYDqrYm1?=
 =?us-ascii?Q?eQAbVZpUs+R2S5ZnDCTAcw38FG1Nf/PALdBS65D73yffyxjyzyQehpxqOqI9?=
 =?us-ascii?Q?9/cdMlUvQ5FogE8YaMTC/lW68zQKjl4fUxZLAgCNFBJzWYw53e5icXI9dmvc?=
 =?us-ascii?Q?jN0gWKFFKyH73U8V3Bk=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(14060799003)(35042699022)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 14:50:19.9317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a3f68d-0af8-40dc-3289-08de4c69bf6f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A62.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB11473

LGTM. feel free to add:
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>

> As EFI runtime services can now be run without disabling preemption remove
> the check for non preemptible in current_in_efi(). Without this change,
> firmware errors that were previously recovered from by
> __efi_runtime_kernel_fixup_exception() will lead to a kernel oops.
>
> Fixes: a5baf582f4c0 ("arm64/efi: Call EFI runtime services without disabling preemption")
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> On the partner platform I was testing on this issue caused the boot to fail.
> ---
>  arch/arm64/include/asm/efi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> index aa91165ca140..e8a9783235cb 100644
> --- a/arch/arm64/include/asm/efi.h
> +++ b/arch/arm64/include/asm/efi.h
> @@ -45,7 +45,7 @@ void arch_efi_call_virt_teardown(void);
>   * switching to the EFI runtime stack.
>   */
>  #define current_in_efi()						\
> -	(!preemptible() && efi_rt_stack_top != NULL &&			\
> +	(efi_rt_stack_top != NULL &&					\
>  	 on_task_stack(current, READ_ONCE(efi_rt_stack_top[-1]), 1))
>
>  #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
> --
> 2.43.0
>

--
Sincerely,
Yeoreum Yun

