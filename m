Return-Path: <linux-efi+bounces-4704-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72836B45CF9
	for <lists+linux-efi@lfdr.de>; Fri,  5 Sep 2025 17:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A465C0462
	for <lists+linux-efi@lfdr.de>; Fri,  5 Sep 2025 15:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97775309F08;
	Fri,  5 Sep 2025 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lRDZpA6o";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lRDZpA6o"
X-Original-To: linux-efi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010041.outbound.protection.outlook.com [52.101.84.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7B230B53B;
	Fri,  5 Sep 2025 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.41
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087153; cv=fail; b=QPwv1qVmoqg1m6R6cHXndrn8Wjp3q4zFTWlKQa1AoVlNZBJlXQ9vkV1kcJwUmDmrK6uBDpK3VUYhl1t0DSesnh8T/5ZhgUTeVBV8m4w1X02Oi5IeE3yml9CJgVxjK7JXzwUJ6Nfpexp62J3b7Rt/jDijSq00asTW9b+DDgLm/yg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087153; c=relaxed/simple;
	bh=1dIXeB6evzNQq/5+m1x1G5rHll9SJUtWLsBMvgpDI0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JQwr+6IXk6NIuLwVcFT3U0K0853eFUWQlXSlZZyTApFBkJwfJqTVO77nVVYf++BCgMNrcboSdlK6jFAWuAN/buR5radLYH1RjlG1R0S7LUH2R55gcAwsAykm7HD0KlCrjKVbE2MaoIc4Wjsj5CjxuoF0edSSr30pDioQo17+6zo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lRDZpA6o; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lRDZpA6o; arc=fail smtp.client-ip=52.101.84.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=E4C2C5nt81+qv0ErPFWGz4JHQM7PYXnY+enTbCgFdVgmyNmf2cK8Zv6lyE0pIVNOCu+fJxkdVIYkC64WVlv8L0DUnLITVcYCxR9zGJqXUOb1PpxRJnwHId9aR49d9+ckgKKSVatb9JVAjf0auG0sLqhhSmTGEH7Jho3nSkVOfDmU+S223J4tl7Ek4I5RGrFlxIQbJgEtsBKbjt0l0VpyGRxo8KV4FX0sBCC5X8EjTJlB5h7PT5Qd1Yxvks5QK0KoVkJwHHdr2l/MEHcuDiPWz5hfQtC7smxzFF7+JvKP5Oub0pH9bXJKBXTAHf+pNnvsMo3sG28lMJS6qboQyi1MqQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kml+z2YaOGVFQRRqN5Be1BeDW3Wx+k6y0RAjj7TZSeA=;
 b=Fkd0V97uTWbPnQEmpl7H0vDYPQtjl3CM/0F2CZ7+ATBLmJFz8G9r5JTh4d3BWCsDE+3/PAArN6V/LZSM/9gTvZAcnlqj6NbjBTGTWiRRcT1ADtPSXWOHXe2HmauuElmcrOiWnNQTAGKE2wdVyhlsoTytxk8+DYd+7xiX57so0rnm+a/k/lVLnG9lEQnHa+wQ+xINhadGSMhWQp2pS2koRXYE0eIKz+KaHN2jPpaCpZuciJkKW2xxZTu+AFnNq7Xc+lh0ZMGJNBSOcLJIXCF7JJmTwz0UfOx1Hw6pXUihoKJ1IURYdmxu4ze8RZXE+HcVuQlQCDYIJYx1VJ3oh1hgcw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=google.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kml+z2YaOGVFQRRqN5Be1BeDW3Wx+k6y0RAjj7TZSeA=;
 b=lRDZpA6odgv8ONgBEPBInl/RnaMkLVrgFHjSMlFHBDKixlx4t5lQ17yRJTqA64jaV504g1xqRymnXl8jq9PRy3RTB1ld/Ap7yAo6tVAIWPqjJR36fXRnCVS6EBDqCDYC90fxeQyFDdDrnu1Ejwk/8ggrWiTnRxFSpSacCit0pxo=
Received: from AM6PR04CA0069.eurprd04.prod.outlook.com (2603:10a6:20b:f0::46)
 by DB8PR08MB5356.eurprd08.prod.outlook.com (2603:10a6:10:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 15:45:45 +0000
Received: from AM4PEPF00027A67.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0:cafe::6e) by AM6PR04CA0069.outlook.office365.com
 (2603:10a6:20b:f0::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.20 via Frontend Transport; Fri,
 5 Sep 2025 15:45:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A67.mail.protection.outlook.com (10.167.16.84) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14
 via Frontend Transport; Fri, 5 Sep 2025 15:45:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3yYIsy7JUl7Hr+10ciTNKS+W71fDgXbegO2aNsbsL7M3N0p468H37A0wYE7xMemzL7w0am1laVsARicxbxB+CTwk6Aqq1QmYR3vxesM2u1xiKVsBEr2m6p5Db8vQmQBAlrXErOAk9TnIjiKlj1f8N937SaKM6zuJ8elCXxiDOuJWR70a//q1Kz0rBiTyDdfuSpVm03035GJqw9YzhXgKlasjs9x/7ssU8HxHC7HzTfmDyfWlZHV/rBT8WMiMOoaa8a11uN6ag2wHo909Id0t8VmEpm0kU7hXQTP0Sg7D06ZQEUW7NsjOsPmQy6DyfflJMVxK9IGFYIaDlrX1CKU4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kml+z2YaOGVFQRRqN5Be1BeDW3Wx+k6y0RAjj7TZSeA=;
 b=byrOjpiHnqYkKqqJ8rfF+TI64JypWXvlZWdeHuVJ7QF2hISu8bv4J7bhR0CReVyh3GJTAomN+tTwHUAbBh16dukqdjyWPZZgbWxMSw/anS49lmOVjzB6fqHOcdqwu5oKA6xAZNRqXLDLezw65fQZzr5FO5bAi0wJVEsYjgcH34nsyeVOGAvRmd7P6FKJ8HN3X6d1e6osPjwx/m/VOk8F9u62tR89vTtTRy1Jw4HcRjkBptk2EY3XiASz2w6XvLoohvnsHFHsgYWW52M3L0H8GYNyyB6qxvzX4zD6yOZwph+AAL0iy0+3aRbanvHJQPU1rwyB6fTk7Goa1ptb1ObMDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kml+z2YaOGVFQRRqN5Be1BeDW3Wx+k6y0RAjj7TZSeA=;
 b=lRDZpA6odgv8ONgBEPBInl/RnaMkLVrgFHjSMlFHBDKixlx4t5lQ17yRJTqA64jaV504g1xqRymnXl8jq9PRy3RTB1ld/Ap7yAo6tVAIWPqjJR36fXRnCVS6EBDqCDYC90fxeQyFDdDrnu1Ejwk/8ggrWiTnRxFSpSacCit0pxo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DU0PR08MB7541.eurprd08.prod.outlook.com
 (2603:10a6:10:312::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Fri, 5 Sep
 2025 15:45:12 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 15:45:12 +0000
Date: Fri, 5 Sep 2025 16:45:09 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/7] arm64: Make EFI calls preemptible
Message-ID: <aLsFhe/whtmKyFus@e129823.arm.com>
References: <20250905133035.275517-9-ardb+git@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905133035.275517-9-ardb+git@google.com>
X-ClientProxiedBy: LO6P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::19) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DU0PR08MB7541:EE_|AM4PEPF00027A67:EE_|DB8PR08MB5356:EE_
X-MS-Office365-Filtering-Correlation-Id: 8416a9a2-f256-4994-0431-08ddec934734
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?Pu0jQOJWrVj+730WjAOoAfMTIWXynW7JmjRQFRviPbK3wlRgtiF0+Z2fX+bc?=
 =?us-ascii?Q?bsVoA0zWGGb/0BNvovOdUHEgAdEFpmbKi0bgHnJSp9u35sAHtRQbxQ7Rihvz?=
 =?us-ascii?Q?iTdr1JK/JM0iOzGIWYw5keUnAPTcjw+G5hBwUQXhuXVNaPOpB0Q9kUmMwTxu?=
 =?us-ascii?Q?0l19UPgM+IdgnkbUPkZqoUhQO2WJahDHKacCWOfjaqMklrivWm0d3ouEX6J9?=
 =?us-ascii?Q?BhsMPklTfkVtCKIRLRym+1u/p9E/+FkizlfAsZQfSEFMO15ibwvPR7opoNa5?=
 =?us-ascii?Q?ySVUGlQMBHx8DQKbtOH4uSEBRHyS1nNuiTFWz3/ZEkg+5ejpKZt00289UVR3?=
 =?us-ascii?Q?sKOOVzCPBaa6vzCdDBwH4D7w68s6Llbdgb1lqcCmqTjW1FmlIA12l43bfYZl?=
 =?us-ascii?Q?n/Ga25UJyByBep+5plqf7h9s8yljnuYRySSY56HrVLfVy4SoUn2sIUpDUXnj?=
 =?us-ascii?Q?UJRNmviK76YiGo6+aKOhtqGzazJwxMLSwSS8lWgS2YWFAh72Yf9NAIkV4PBi?=
 =?us-ascii?Q?NG4wOs+IQyluxpOSYDUfwtLDmdcaYh9OThBavuixIvLNo/28f65WYbGOH4YO?=
 =?us-ascii?Q?vym697MHjzwNu30CxYtHTiz5G0YIRmlZUldT9MsMtHP6O1GH5Dhk5FwyX2kW?=
 =?us-ascii?Q?8fP9FhQcFsjhTXFDLz1kNRWYMRM5t2Fo8qb1cxfUjbfmwakL0dp1vX99GHLR?=
 =?us-ascii?Q?uFHD9Or+YyxGyFsWg2bRZlY5mqhPjtXJ7axPmvhxo8TTqRHqHLiZLjM/w1xj?=
 =?us-ascii?Q?5BVHaUz7EmGrZSOojjOOmiFYsFBJiMwbOhFLn0xwIK+jaOPzqgF5Ylq1TQGe?=
 =?us-ascii?Q?jqfTtpvrlqpk5W577gtIXHwaInTRmbYegMGm3G2Xtha4xXG7OkG5yfWxkuUH?=
 =?us-ascii?Q?a+I7Z5gdfkhFKtHpJ08Oh4bli/Nw6uhNsRyC2i4a54saWHoVcepj2oqRxg4q?=
 =?us-ascii?Q?+8bGTKE6tKKH6CSygTO55CVk/F3RWcn6ozI1Wrb6MrGgwRRcGlJ/j0jeCrIj?=
 =?us-ascii?Q?+3/TurN4I1s2SFVyY4m8ixZLtMoygVnhDlfl5+tLxgaSWbtzix/I3rNr+TwD?=
 =?us-ascii?Q?Sl/9HFPfWyAUs4avDoWU7huAIhARBOQPKoAo05xZEVd+JT6yNYGNMp1zZaee?=
 =?us-ascii?Q?q+JMUtmB7lcxsGDcXYBD6AwnOVHGWYGwtyFp2o6SluV87o6wOlXS0rB2I+3o?=
 =?us-ascii?Q?0FD8q40MA/+XzkRQeB4JoNQcpYlzv/3lAwXVYhnCq5Uqb5C3XotaWjIpJb8g?=
 =?us-ascii?Q?03m3DRRmwkV4HHrvgvXkROFF425H4OaubCSV5QyPO3KYiJT+1BURJPWynSLo?=
 =?us-ascii?Q?bQM4Rt+84hNpDaRLkbaj62SI7XMhaYCjVV2SgpYQ/+lF6Mb7GCruItF0Ti8+?=
 =?us-ascii?Q?2SXeurmHBbvwY+fhVSqj7XzHQCPzpdagAgMKGkPl8Be/I3g8t+sKStPROF3U?=
 =?us-ascii?Q?Z71KpOOTq78=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7541
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A67.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e718d70c-4d30-4e91-093c-08ddec933359
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|1800799024|14060799003|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9SaJ/bMdhXPniksqWp44yh6Q2TCgkgGBqgf8gK4t1unm+vJAO4nKIjgk34y3?=
 =?us-ascii?Q?ipZ5f8+oW6qvBHfBFr6RKfsWtBGM5YnzeK6MuZy3k1JSdPqmSO2vUocbWeyO?=
 =?us-ascii?Q?S6RIjC0ixb/SnOvX7juXtvv1hIb0lAtEAenm74/Gvn9hy7s0QFegx61H7FXq?=
 =?us-ascii?Q?0UoqupfaOasvLFU9xub28IopAWIDVB3D1fVdFVecns/79pQX5ffJDdfBq7m5?=
 =?us-ascii?Q?7pnuGI6LUSg6xezSczx/VucswHKb5Wrc9B0KtFliQ+nK3JxOxrs/MEKwl5oW?=
 =?us-ascii?Q?XB/apcmGHIN4PzbCCX6NG8mix3+T+m/1cKyDuzekKQDXwZUa06h8/+QXybVL?=
 =?us-ascii?Q?AWbCvIek5pysZ0tvUgRiwqyK0baziY4gfC7BykNDgRl03SIOuHYiVs43NcfF?=
 =?us-ascii?Q?AwWt2y9fb83K0FAiI54pghY25wh4c5DUD6Enp8r+7kgG+n2m3FWKDJFSL9Gq?=
 =?us-ascii?Q?vUFnygmDnCosqMV0z0ct94NDHRHZhizoMDfM2P4D2aW3mrXVf7tqBrIUnrbU?=
 =?us-ascii?Q?bBK0yltTYpHz6uuA2z0S1FF/4xUwzWmTZOk8ndKgsOyWpC0ewZKoaAQ6Css5?=
 =?us-ascii?Q?3KEZFA1jdeCtx/u1+xeW/SKKBe2HE+3uArcXhjGvPeTRis4scNOEzuGoOq8x?=
 =?us-ascii?Q?836JNJIIlSH9weUgJ2WOzLs1NQMr2gfD/whwBnnCDxIcM1uO7zT2A4KhQMvl?=
 =?us-ascii?Q?zvAskbW3wrZtZe9S5GvMGEEvWTFenV3D7tgBCqOFgYql2ah8p1KoZt6HIc/b?=
 =?us-ascii?Q?9RJQ7WLdlHBbiypH0Y5Wb6CncMsCwrAiWkY7SqfU/CgbLzYJvzsa07tn1sex?=
 =?us-ascii?Q?+YPTs7NOX4xJ+U2kBh2H599UpCwmHaiax/NCvFRppv6NfrmE8ein8TscMCT+?=
 =?us-ascii?Q?N3KJ2Ly/zdzXE8hbgH9mMGv9RxjlbM14DiBKavEITMcVDnZgRyG/6iok7MTf?=
 =?us-ascii?Q?01lZFydVTeB07mRqiOmY3r8GXU5Z4flXml45eaqisfcjIKuSVMmZim5ekJFB?=
 =?us-ascii?Q?JMivo6/LHRiuscreiJUMNTfBRvByq3WQFOj7QumVl9RalgPmBCCzmipQc1dc?=
 =?us-ascii?Q?A0cnlGzWKhOP1WcAGxpxjaFMNFVNwASrJZu6jfGemAlzNzZg5J5NtL1TASSQ?=
 =?us-ascii?Q?80Br4oklBPDnFzjK651lOFYmKPh95C1kF1orhKwtcV2/Fw7gG9IGPMZw9uJY?=
 =?us-ascii?Q?nM+G6yRja1Fi5LEwe20EjKmLx8Q+eL6vrelSZ1UCD1hRGOuZR2XLZcTv07dI?=
 =?us-ascii?Q?a8UIilMcV/T5nKkZeaRqVycG6gEdR8Kx76/EbEjDjgfV533XC8sTkJomjd6Q?=
 =?us-ascii?Q?PRBwTJbl2XJiKhc/3wSiJC7PpFqtifhMAOtuRteMB5qGqY1WjkcHoJWLZv6Y?=
 =?us-ascii?Q?Zhievtt/CboojmRx5n2nSqGy5SSv8I957YSeTtKI5t4Ej7qT9pytKRmAJgMK?=
 =?us-ascii?Q?pZ3lm4w4eFuHNnNln832+CpdntUDrQsbkByL57meter7eEmDQFAZkLOitTng?=
 =?us-ascii?Q?FVFnY+c0Vdoh2g/9BDAa08Tqcw0FWp/OSCNq?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(35042699022)(1800799024)(14060799003)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 15:45:45.4370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8416a9a2-f256-4994-0431-08ddec934734
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A67.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5356

This series looks good to me.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>

> From: Ard Biesheuvel <ardb@kernel.org>
>
> The arm64 port permits the use of the baseline FP/SIMD register file in
> kernel mode, and no longer requires preemption to be disabled. Now that
> the EFI spec is being clarified to state that EFI runtime services may
> only use baseline FP/SIMD, the fact that EFI may code may use FP/SIMD
> registers (while executing at the same privilege level as the kernel) is
> no longer a reason to disable preemption when invoking them.
>
> This means that the only remaining reason for disabling preemption is
> the fact that the active mm is swapped out and replaced with efi_mm in a
> way that is hidden from the scheduler, and so scheduling is not
> supported currently. However, given that virtually all (*) EFI runtime
> calls are made from the efi_rts_wq workqueue, the efi_mm can simply be
> loaded into the workqueue worker kthread while the call is in progress,
> and this does not require preemption to be disabled.
>
> Note that this is only a partial solution in terms of RT guarantees,
> given that the runtime services execute at the same privilege level as
> the kernel, and can therefore disable interrupts (and therefore
> preemption) directly. But it should prevent scheduling latency spikes
> for EFI calls that simply take a long time to run to completion.
>
> Changes since v1/RFC:
> - Disable uaccess for SWPAN before updating the preserved TTBR0 value
> - Document why disabling migration is needed
> - Rebase onto v6.17-rc1
>
> (*) only efi_reset_system() and EFI pstore invoke EFI runtime services
>     without going through the workqueue, and the latter only when saving
>     a kernel oops log to the EFI varstore
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
>
> Ard Biesheuvel (7):
>   efi: Add missing static initializer for efi_mm::cpus_allowed_lock
>   efi/runtime: Return success/failure from arch_efi_call_virt_setup()
>   efi/runtime: Deal with arch_efi_call_virt_setup() returning failure
>   arm64/fpsimd: Don't warn when EFI execution context is preemptible
>   arm64/efi: Use a semaphore to protect the EFI stack and FP/SIMD state
>   arm64/efi: Move uaccess en/disable out of efi_set_pgd()
>   arm64/efi: Call EFI runtime services without disabling preemption
>
>  arch/arm/include/asm/efi.h              |  2 +-
>  arch/arm64/include/asm/efi.h            | 15 ++----
>  arch/arm64/kernel/efi.c                 | 57 +++++++++++++++++---
>  arch/arm64/kernel/fpsimd.c              |  4 +-
>  arch/loongarch/include/asm/efi.h        |  2 +-
>  arch/riscv/include/asm/efi.h            |  2 +-
>  arch/x86/include/asm/efi.h              |  2 +-
>  arch/x86/platform/efi/efi_32.c          |  3 +-
>  arch/x86/platform/efi/efi_64.c          |  3 +-
>  arch/x86/platform/uv/bios_uv.c          |  3 +-
>  drivers/firmware/efi/efi.c              |  3 ++
>  drivers/firmware/efi/riscv-runtime.c    |  3 +-
>  drivers/firmware/efi/runtime-wrappers.c | 20 ++++---
>  include/linux/efi.h                     |  8 +--
>  14 files changed, 89 insertions(+), 38 deletions(-)
>
>
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> --
> 2.51.0.355.g5224444f11-goog
>
>

--
Sincerely,
Yeoreum Yun

