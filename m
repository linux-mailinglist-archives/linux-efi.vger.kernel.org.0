Return-Path: <linux-efi+bounces-2204-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D62079D8B98
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 18:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2849D161F04
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 17:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7CA1B87C0;
	Mon, 25 Nov 2024 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VKx23wiN";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VKx23wiN"
X-Original-To: linux-efi@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F23C41C92;
	Mon, 25 Nov 2024 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.67
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732556766; cv=fail; b=Dchtg0v0oCHyz7cK4CkMBmJEd2WOzKdrbvJtQ1O8k8yAiqzXXvh468BIBk+jKToYPS5xcrYMmLZ2a2RySgP+BaFTu1ZnrbEvV4I9uv9ntN1h4EeFpcJy9TKPSgl4nElrW0uHzd4TV0imDs7WhVmY15837sezV8IXwCMY6rIWyX8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732556766; c=relaxed/simple;
	bh=r8boKGVrlj4YP0gCCEwVR/29ay+2+KupxaHaJjjhE2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PB8HbSU2OFlGeWdyVnH9tnYgF+W/4NKCXZBQSAaBlaCXTULriPO/4L9hhTi2ZJ+vqPXwDU45npi07+l5s6yq2ILG5ATBvPdTTE/30p1beofsw4706BaaY4RR0E0NUBGr/y5MFGBeSNqFUehG7zVlBTZvNpgv/XJQfl93HobJREA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VKx23wiN; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VKx23wiN; arc=fail smtp.client-ip=40.107.104.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QhBBNgKQ7/YH5HKMJtA1IrkQNLaBm7Ii/hbB3yUO7VbljV3KA4oiJn6JnIOUSoxOyQvHM2ljy9Ki4GBQ6PA1PJk9KNjkNZJKy68u45cIct5ukX8zyNfmuBykHKOjxEWd4Uu7J7s0b/2miqfzysfrr3AuxwJ6HOMvzjhG8anNJSIHQB97fT9IpSQqLlcGp/RSIhBT1aD0J5rNnUnhh50jKT5slL0FRsEG0YOtyXvCkAI+F+hBDwb3+qJcxvFrnV3+CkYXpviQ+73pBQhyNqC3rYCzskTRSCdDvEImOkrRw73h3phXCxCC4dlYtHLdX1UjH370Pbhzo7tqOlpcM8N38g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8boKGVrlj4YP0gCCEwVR/29ay+2+KupxaHaJjjhE2w=;
 b=tjA1BvT0U7Xtw53Eh24qTXykse4Bgqs72YewbMb4im89L1yx7nQtqg0DPonb3CySyZW0a2fgTr9vxJDMErW9ZNaLVunjn/UdSlV6M8/Lt3CRrbuu1vPipIf5sC2lAgCMH7DJ9vlFaWQnhY4JnLHhBAb4eCEVQ/34aNIpPewx/Jn83GSjQw7NG3nj50YD2xkNer63/cwipoScffPNfvWW1MUS3mz7/XbcxNoreg8/i/AHwiq0fQ/MeDoAH9en5kzKClRyqwdI8ExM0oW1kAs7B9FU9kqnzYv/52fNk0Iw6H7NEAZWjpNmQET3GBCS1mipYToKOlh4Jxtqh7HdI2wSfA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8boKGVrlj4YP0gCCEwVR/29ay+2+KupxaHaJjjhE2w=;
 b=VKx23wiNDBKJqhLIfEXEG89aqPyvc7AN+ELaujTuSDbIomzJEFR5kGDJZoWSk0zdipo7tb3wkI9TjT5Ly7ahIpxhbir6QHxkmzGJK2I/q2Oht6r368/ejmp+m2pNUfEMmqu8qID4t0XpBir6el6p85GXDkbI93xiFbqJwegWv5U=
Received: from DU7P251CA0012.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::18)
 by PAWPR08MB9686.eurprd08.prod.outlook.com (2603:10a6:102:2e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Mon, 25 Nov
 2024 17:45:58 +0000
Received: from DB1PEPF000509EF.eurprd03.prod.outlook.com
 (2603:10a6:10:551:cafe::5d) by DU7P251CA0012.outlook.office365.com
 (2603:10a6:10:551::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.21 via Frontend Transport; Mon,
 25 Nov 2024 17:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509EF.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12
 via Frontend Transport; Mon, 25 Nov 2024 17:45:57 +0000
Received: ("Tessian outbound 23e15691b630:v490"); Mon, 25 Nov 2024 17:45:56 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 136df599f3b04c8c
X-TessianGatewayMetadata: yE2Jk0e5nXYqrFLg+VEzfW8Sm0VNBm7Xp2XdxVrwoqbKZBwBA1TKLjBPdJaKVEHS0sBJlfDNEzmIIMBnD09SIOqQGtK0ciJkprtX9wUNSWRHB527oqGumZcQRWHJefj9gluu9S3GNtQswkQfBLZnHA==
X-CR-MTA-TID: 64aa7808
Received: from Lf966c29ef734.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 44FDFEFD-DE6D-493F-A996-5DC04F362456.1;
	Mon, 25 Nov 2024 17:45:45 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lf966c29ef734.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Mon, 25 Nov 2024 17:45:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBBoPhb5Gki7SXRGArizI7zeSP21QKf5NVVkU5+qCUw/lvGFCWZeNiyEUiojP5U+Wwcha+UE81n45mk8miFugQYGS8axorvjyEXnxk+um4BrwRknUwMpTbAIK19csP4TuE+x/NwaKTlO1e3VupbywQ92ziIy/ncZn7YWC0C4CwkDMdh+ujMs5UGylokBaPxkamm5TKux8kDkzScCVyrihUweYKqFTaHyIBRf/26HexK4bIyqOi3LdQ53xQ0iaknBn4T9yYHSJBhhq8SHPquJ7Nu2+Ou5PeVBji5E2SO164+egkUez+xOMQa6AugujeF3dHKExQTpWlg8ygdReDuRvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8boKGVrlj4YP0gCCEwVR/29ay+2+KupxaHaJjjhE2w=;
 b=cSnScOcB59yIeaH6SshDvDSd8IcljLBPSaAHkOIjZvLbsJQNh8P5P83T9diygjobdirieaOeuXI8uTlUAuGFzrpe0RuRuju5eZ3Fnlh85KHy7MNX5g4euI/PlC4TDzBHVd5JxrBm13Npt+19Hdjz9SsoDfkCkyxyCLQZS8rqrj3aZ4meo1MkuUfYx4Gxd7WfBm5+YANvZ8aiRZpLW8Wb/YhIVaTatkUPGGGxUYEQd3jdmm/9lSTiT2tvbiJGO7gHSOTOuo8MDOssdWIfsTk5J9dRyF4CFxuNvskk70a7J2i6UhyA1qlP33OgeaXQDOUlcNhHVK5Hvp7BTKaVcnSStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8boKGVrlj4YP0gCCEwVR/29ay+2+KupxaHaJjjhE2w=;
 b=VKx23wiNDBKJqhLIfEXEG89aqPyvc7AN+ELaujTuSDbIomzJEFR5kGDJZoWSk0zdipo7tb3wkI9TjT5Ly7ahIpxhbir6QHxkmzGJK2I/q2Oht6r368/ejmp+m2pNUfEMmqu8qID4t0XpBir6el6p85GXDkbI93xiFbqJwegWv5U=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV1PR08MB8450.eurprd08.prod.outlook.com
 (2603:10a6:150:82::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Mon, 25 Nov
 2024 17:45:41 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 17:45:41 +0000
Date: Mon, 25 Nov 2024 17:45:38 +0000
From: Levi Yun <yeoreum.yun@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: broonie@kernel.org, sami.mujawar@arm.com, sudeep.holla@arm.com,
	pierre.gondois@arm.com, hagarhem@amazon.com,
	catalin.marinas@arm.com, will@kernel.org, guohanjun@huawei.com,
	Jonathan.Cameron@huawei.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2 2/2] efi/fdt: ignore dtb when acpi option is used with
 force
Message-ID: <Z0S3wiugr0JML/cV@e129823.arm.com>
References: <20241125170758.518943-1-yeoreum.yun@arm.com>
 <20241125170758.518943-3-yeoreum.yun@arm.com>
 <CAMj1kXG4A4h3=bZC6kSrwsZa7p4RZ-uN5N67pZUFLOQ2RJE64w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG4A4h3=bZC6kSrwsZa7p4RZ-uN5N67pZUFLOQ2RJE64w@mail.gmail.com>
X-ClientProxiedBy: LNXP265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::16) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV1PR08MB8450:EE_|DB1PEPF000509EF:EE_|PAWPR08MB9686:EE_
X-MS-Office365-Filtering-Correlation-Id: 3446a957-a4a8-4708-b739-08dd0d79044f
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?Qa29XnwI/wgqfCV689aSzpAv+MSvwpT5uusEvHjx2NnC9wssLserOrO3tth+?=
 =?us-ascii?Q?n6MENwzlG6J/ZsIwh65SttUq6OSy6NLlo6Q0zegkJX2F4oGG7qTBgoD1XL+b?=
 =?us-ascii?Q?2V94jx8WJTybAjkk/gtue5mqPmGfLbqel1dFIjCcHV+FrakV9Z+FNpCT/B8u?=
 =?us-ascii?Q?dLvU89PGwQaEYBiYibKEvUTsm093LOYexXhGexwQ53nPXc70JQsrx0EdP19h?=
 =?us-ascii?Q?H6e2trqlu9DutfQ30I2EUTA/Io/iA3VfokvlCTpsL7ijATTpX1PXxqEhnpO/?=
 =?us-ascii?Q?NmUf9ux9al6Wjy0aWu43Q4YvXvF0ecHIMKL9uP4zib1+mfEqf+gYo052FsNF?=
 =?us-ascii?Q?PxwJydjqEvqg5u4hSb6ilSs3CCyIVAIdA6opaJNUx8YfIdn2dHJUhtvSLdFL?=
 =?us-ascii?Q?4i7mGb9oyC6Fn4JGxAnHO+tI9OI6/mZsJQwvI71HscPEWmUE9LByAOZZ+Zif?=
 =?us-ascii?Q?Zwe0ZTpl9NvR35SAjdUpQ07P3vJqG2YvcdJ9CNmtxeD0N0inLEVEH/2UNUYG?=
 =?us-ascii?Q?Day4UC40NCixPBetk/Sox1Ji2jdhLjCS9Jogmirs2ULfmCH0H4Wxk5iENJZv?=
 =?us-ascii?Q?qzHVkKQSWXlCa1KjgfuyI9IvLSKQxZliGNTHw1zOeBwIYmVkLJORQUl6IAH4?=
 =?us-ascii?Q?aoLVkF4ST6899NEfXJMO1yPh8vmwtdmrr84UJ5EuEKXRzjmHuKHIsFWT3Fe/?=
 =?us-ascii?Q?qRJ8+QEOus1l2hrtB9YCW6bRQADt0XH85o0Jtij5mB1WbNi1vY90c60iOvAJ?=
 =?us-ascii?Q?WG2xIL2CPm/70XOgGYrR7tUzCq2zBKkBIJxI1EVsy9S8qi1NdaWJ2cEWAP+2?=
 =?us-ascii?Q?XepUBJTELlt3UV8F1B4iv4x6ezeVGsJtXf3QGKgbQnqaFP/q7gifNDqcN+Rg?=
 =?us-ascii?Q?MdXspv3d7I33kJzTsgw4ePOjBidv58eUULaGPrOU9M5Gmdm2GYWk+q+CwgMZ?=
 =?us-ascii?Q?+1Y2tkGVeDDfAHIx/OSC+n2CG6GQQFAK9y11Gzl9VQyshOFs4WSP50lCmxjh?=
 =?us-ascii?Q?S/ANllea8gD7LJ4K9Be/vcrR0MtOCZy510VA8VX3w4sfrwrwHS6Xphzxa54g?=
 =?us-ascii?Q?XUK1HNC6ihzUY04oLc54YVbpMhlcTPitfxQpKjKkPMjGzmHxTkgOCT4f5mC8?=
 =?us-ascii?Q?G1zksdwSE+lVbzGlYsLx3fl+MNdsQsH+i0A56TQAIOTO8v8oDxGBm9gPwZWK?=
 =?us-ascii?Q?9tBWZ1Vpbs2hTsylrJldw2oVUCZ9UB/4Krv/Uc8ylhXgft97XqEiRotJFGEL?=
 =?us-ascii?Q?SBH8LWLVDRiRqIYUi5OjlNHsbeqOOcR4C6uMR1peh8dERgdAr69IzedYyMNx?=
 =?us-ascii?Q?bLCf86cEwHg/DQDiCm9cY7Zx/BJXA7M6Ow54BIV5wk4epg=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8450
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d8809dd9-3722-4401-5b14-08dd0d78fab7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|14060799003|1800799024|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LuMSwVA7NpvXXrKfxhonRSQzkacaTjnR861nw4k7gKKic9Jh57T19E7eJ3nB?=
 =?us-ascii?Q?yYi/mqOYCC5rxyH5YTkqipmKQbEE+i3W2bxYrIYLnQY/fAdP/lpenTLXDoUZ?=
 =?us-ascii?Q?4Ar5rdtkWImj56xOJ7+AGoLA7ojCUTFcyl8IZYhhXjhm2vmEVt79IyElHvTE?=
 =?us-ascii?Q?XH1NYUVYM1mbJ1s7jQdfQuJRCpO5aFhLm+wB2CCOJWyRIjp1FAe/I2abhG65?=
 =?us-ascii?Q?YO+ni+XDZReyaDF3gqhlegyLqFJ5SZn+dPcKXUYF7rli8DVqbVMse/omCyY0?=
 =?us-ascii?Q?rVOi4ry2o0wmBIlqJv4VcM3QcZDcCN7IlYnhbWudP5p3PNCR5LfLqBFZmDaH?=
 =?us-ascii?Q?//gWvsyP02599n/bGgv2pjZ8zwsaZ/Th4BnRfrkiQ9MPwt1hdLxL4eRv8woB?=
 =?us-ascii?Q?vnp+en7LIb2bShefqOW7blKCZWTwk0Pf3Z89WP85HxgHIZ1hGmeH/uGxAFOX?=
 =?us-ascii?Q?CqpzL6qKfwBqxnnOh4AsTDe0/iiZgCpdCLvJDvc3hGTNZqXiWWiqzXQs3mpv?=
 =?us-ascii?Q?HnK4adUefNw6nK1g1kEh0eA6mYNBgpCFCpVBqMPwIKFNjvSTvPhUi7OuyMF2?=
 =?us-ascii?Q?76O2LaFPLqGdbrYbo/tbc52fndIZOzpadkrLGG4SUhoIs7XrU5nLZsQQ2T7x?=
 =?us-ascii?Q?AuqypAa8ZG5Fnwb+UwMBHyTuuwFQgaOkkUYCrYiU7mfF+V2T6CKvNCbdNz1n?=
 =?us-ascii?Q?4vnYrUVVqV1B47iLiRDxUmTNCuvbGdUJYm3ssAkQsJW1d9+neTz4EJvVIM8i?=
 =?us-ascii?Q?FrQgFYuFGwtj3kys8awBS66a5YVBsTzYMDzbP34tn4NID3d76YV0E7OFkHvx?=
 =?us-ascii?Q?sFeQQ4eZheR+3YzgnuLcnkrQlEqb8jycLaEHZirRH3H+Wc7bTqX1++fqn8gn?=
 =?us-ascii?Q?0qji8Ae+vwsIknD9hV6OGEmG822DnEN5ofCkXhClSH0adCX5aS/Yejyh4Y8H?=
 =?us-ascii?Q?1hZSZ6g2zDDe5zlhclgnFUel+O86oWUb5pknQ+W3OqTD6xMzfThX/rfclTMk?=
 =?us-ascii?Q?DkB1t9JcZYkN2ZP7DV6im+Kv3IiCXdKox7vA4bTcrIc+oawd247MPk2kaoJ4?=
 =?us-ascii?Q?AndHEcm20Cf2einFjspRJzDEBvyjaVpWYcvCtxur6bf9Z5RPwY6ClZkF+0Si?=
 =?us-ascii?Q?tvkEDpMGmKIVzHo0YOw0x9fCu6+IfbfaPyaqT6RRyE2qqrL6A1Gdzpf9l91f?=
 =?us-ascii?Q?Ht3NnIsNjs7mPZq4zz+PB4acpAEEBc4OTAYtedwBGQXtk1SWbG0mwZLpt0Ii?=
 =?us-ascii?Q?vQah0ZOWcf+IGTaIxzQDwn9qWY/N/s2cI4JY88ciQSP3K+hkzliFchv/xhBK?=
 =?us-ascii?Q?E2IS4Z5wWWinH0DZxvxtjSB/uK8vBugbGCo/YGbP7Pn2m6u5u9R868BBiZ6w?=
 =?us-ascii?Q?OERgUokwrXL+mzunHl9PZ/eVOwPbe4IPT7H9G6cC1sOWW0XRFJ5R6qIJV11A?=
 =?us-ascii?Q?4LCOx0xynE92NuxYSaJW92rgQaVRbhYv?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(14060799003)(1800799024)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 17:45:57.0546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3446a957-a4a8-4708-b739-08dd0d79044f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9686

Hi Ard.

> I take it this is working around buggy firmware that passes both a DT
> and ACPI tables, and the DT in question is broken?
>
> If so, this should be fixed in the firmware. The EFI stub does not
> reason at all about ACPI boot vs DT boot, and I would prefer to keep
> it that way, especially because this code is shared with other
> architectures. For instance, the meaning of acpi= could differ between
> architectures, or they may not implement ACPI in the first place.

What I concern is that It doesntt necessary to check DT
otherwise if the FDT variable in variable storage's contents is
corrupted, it would complain while it check in early_init_dt_scan()
thou the dt isn't used in boot process.

also, although acpi= could differ from architecture, the force option's menaing
seems the same over architecture (ignore DT boot with ACPI tables).

So I think the check the "acpi=force" option to prevent loading DT seems
good.

Am I missing?

Thanks

