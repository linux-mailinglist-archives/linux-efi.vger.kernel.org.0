Return-Path: <linux-efi+bounces-2207-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6439D8C13
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 19:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C166D287B96
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 18:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CC91B6D0E;
	Mon, 25 Nov 2024 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KA5Lbb1J";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KA5Lbb1J"
X-Original-To: linux-efi@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2056.outbound.protection.outlook.com [40.107.241.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87331B3943;
	Mon, 25 Nov 2024 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.56
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732558568; cv=fail; b=dPDDpg4J//IRtn9eqK6jeELp3x8FbhyHMSt4SeCMhMqeHH9rhbJ4NZCyCszPuG4wREr9XmEHw+Gzq6hNAhZgEIAiHPkAbQaJjlf5H+gF+EESfLFPegBgiEbIIvLYMvwUnTb/QI1OOUDsjuHB4MqSyn0Vx/YUgVhzApRnqNIHf8A=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732558568; c=relaxed/simple;
	bh=3to7bnROxcdJ7UPgm6j4IqHmVtroLXL8I2+m2snwMMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r9HA3pO712W7kUaZh5/R+RP1OH/Nxe8bvXQXYMFH5qwGNswW1tnmu0RekrIk9Zg8e7Ip3Rvfu+x2rSsPXdtztzXtAyN1h2cYtjx6x2S6/G4eq+aW7nFsoIks5mcvhagnbcfJ1nmXjCXSQ4nXgVKkt0eT9jNgupNJhM+jBThUB70=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KA5Lbb1J; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KA5Lbb1J; arc=fail smtp.client-ip=40.107.241.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=BG02WFkwMTnZDerIOV7aOx8+MbbX36PErLvYMHtdpBHnYy2rvzPtzvmAFsUWpeeIc3zWiLiEAG6uXosPyiDk1ABsJPj7Oi8UYt8aXASuMMlTa0TzL1rHxGqhnUucVkGe77QmOLBiSeaPXPNXjMk722olg5sm8+CWydJznvC0ofolVL6P2BrWxe2A8l0MdDYXz4OWPXj6PjXRYLrapL0xEWp+bq4QV6xE+oNEAOAQXYAQzeVMoWzhroFAdXckIrwBwmW+9eoaI49bDxrvzjml+O28zunlqcTJvzEBcpNx10T08OoBBp0vGWQaO8e48QO6M6MCiZbDNe145F1zQ1CxdA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3to7bnROxcdJ7UPgm6j4IqHmVtroLXL8I2+m2snwMMQ=;
 b=hI/xt+zgxjT/t8kdG3i+y3v/NhfUsJeOdLEbsIZ4xbeILqZIXaAJMnr03iC/nN4IjUPGRWOlzj+LSmN+u2qD878C3eyt4HkClrH7v1unGNbt7zx+oj/rUtdcdHz48nkGNXr4wXLWaZdB00EmCRfGagD05Lg7NFBvkQ0AYYCAbogyEXaL4AFS32MpNr98E6z6OpxDAjqoKM7wYQRM9A7oVI1at6bma+7+TS018pyhVjfUBoIEgwwHEauMROSH8anqt5PR4RPrarod0cauEE4B/0yRLqTcY07+m5veExU6rTg+SRfW7i1AbtSRo4WhFUIYVE7SiVKs4qVPXP7WYOQPPg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3to7bnROxcdJ7UPgm6j4IqHmVtroLXL8I2+m2snwMMQ=;
 b=KA5Lbb1J0kvdqlvpRWqyauqsn8xoRPI//Kf5RFiAQ4uysZZ8sES2upY/GsQ8H2zz0AL7MQLEHyO5ZPWF+Dkcvhyee8A/55GKIZwYZYwDwo68LcmHvooqej3tREK5evjAi4X4BVy85slOaAY9iE8o42lN8bqBJoQcXGmRpZsU2dA=
Received: from AM6PR0202CA0042.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::19) by AS2PR08MB8454.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Mon, 25 Nov
 2024 18:15:58 +0000
Received: from AM2PEPF0001C711.eurprd05.prod.outlook.com
 (2603:10a6:20b:3a:cafe::de) by AM6PR0202CA0042.outlook.office365.com
 (2603:10a6:20b:3a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.18 via Frontend Transport; Mon,
 25 Nov 2024 18:15:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C711.mail.protection.outlook.com (10.167.16.181) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12
 via Frontend Transport; Mon, 25 Nov 2024 18:15:57 +0000
Received: ("Tessian outbound 99d3b165dfe9:v490"); Mon, 25 Nov 2024 18:15:56 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a85c8667282573d4
X-TessianGatewayMetadata: YYjayfv9iFl2aE2CAZjD+cXLNaGoeYkBctrn82VXoJrY2o0JrRRYnY/weWTL5PHPwOkRg+VpnTZADJBom+pRDO93z7og/IVqX8u+cLqz8H5TourjC7JnXBY7b5mrS3sIsl7LXqXU1b3/Bt7e56e/EQ==
X-CR-MTA-TID: 64aa7808
Received: from Lf15ac837755d.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9737CEE4-1DB4-4F8E-9ACA-B6B7DEAB8906.1;
	Mon, 25 Nov 2024 18:15:46 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lf15ac837755d.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Mon, 25 Nov 2024 18:15:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJnwKX4fjdKitsjFUdZbZbeeh2HuqxQZtj5O4g+VsczvR6Rci0yKD6vmZI42MiLaVi0PM+fSAAdCzd4NZPR+FfZbh9oKL4gpaNY8W22lG6h+fAPLOByBuYBelzuZEwH7KFEv8tQVTdXoIJS7HZ8DXhxF3DKL9IhUd1E5Kzkkw3r//p51tVGMizeg+jPl44RH1ev9EUD0n/HcmqHTxxghAKe5zXRXhyczwruS9+0+zRuam6i1Or1NIhtebU8pZ8U8ujrvs6yxvtGqP9OUE+fM+YN8nR+g61QOzm5iDALphNq1CJazrf+hKUNRYyGBugyADP7gpvZewLvevH/scCgIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3to7bnROxcdJ7UPgm6j4IqHmVtroLXL8I2+m2snwMMQ=;
 b=fuAQlj5m95cPieudTlgkLwS+nnIqCB/vttqsJvlfApwDx3wfB0/nlUGYo3xI3KI550ULnhhC5ewc7X6zqVKcjgYs8NefFr+ToH/nI+DH4g1OeQAnOpvOd5aS0zT54iFYXhtLn2xh1lmF0pRrVk4tlCZBwmHJCBM+PYVe3HZxKBhN6LU2sszcVO5MsrwNLKr9PWRJnkbAhut9+Z7bBqiKmNy0I78/Bup+9jNlziEzUti20ul82lDZ0LDjzuden1ck4t6Mdm+oHcGlvlgEgdqkNLx9z4tTI3jiUgboH+Plwij2ZUkG9iYh0xg+BFaJUHKaTO9Bh6jmn2/RVDWQZNjBhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3to7bnROxcdJ7UPgm6j4IqHmVtroLXL8I2+m2snwMMQ=;
 b=KA5Lbb1J0kvdqlvpRWqyauqsn8xoRPI//Kf5RFiAQ4uysZZ8sES2upY/GsQ8H2zz0AL7MQLEHyO5ZPWF+Dkcvhyee8A/55GKIZwYZYwDwo68LcmHvooqej3tREK5evjAi4X4BVy85slOaAY9iE8o42lN8bqBJoQcXGmRpZsU2dA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DB4PR08MB9192.eurprd08.prod.outlook.com
 (2603:10a6:10:3fb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 18:15:42 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 18:15:42 +0000
Date: Mon, 25 Nov 2024 18:15:40 +0000
From: Levi Yun <yeoreum.yun@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: broonie@kernel.org, sami.mujawar@arm.com, sudeep.holla@arm.com,
	pierre.gondois@arm.com, hagarhem@amazon.com,
	catalin.marinas@arm.com, will@kernel.org, guohanjun@huawei.com,
	Jonathan.Cameron@huawei.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2 2/2] efi/fdt: ignore dtb when acpi option is used with
 force
Message-ID: <Z0S+zP3u4781zNwo@e129823.arm.com>
References: <20241125170758.518943-1-yeoreum.yun@arm.com>
 <20241125170758.518943-3-yeoreum.yun@arm.com>
 <CAMj1kXG4A4h3=bZC6kSrwsZa7p4RZ-uN5N67pZUFLOQ2RJE64w@mail.gmail.com>
 <Z0S3wiugr0JML/cV@e129823.arm.com>
 <CAMj1kXFOdGaYiVWOyFEK+Lz97YdzAu+AWj5trZBTL+Xc_DXnmA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFOdGaYiVWOyFEK+Lz97YdzAu+AWj5trZBTL+Xc_DXnmA@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0409.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::18) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DB4PR08MB9192:EE_|AM2PEPF0001C711:EE_|AS2PR08MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: c818e769-a579-44cc-a3e0-08dd0d7d3560
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?+LuooSZVYk2VPTgrVck6HnCYmxrzvJM9/wy+XxtMrgL6kly9Hptlft3hN0zO?=
 =?us-ascii?Q?pzsU/C7rkVEM86MKOTRl+9igL+8ODEQwjw+t4Gzfar3wr9/LSUyvqlC6zOZp?=
 =?us-ascii?Q?VbQq+E8F/5gTscLxMFXWRPw2h98f1nre+WQ51rjR9mpuruGgZ5g7bUrKkLio?=
 =?us-ascii?Q?XY1h4qAU1BAKCO+R4ia6Vbzaw1W0aDLCM6DQ/dZvG82ftaVk8SX3wMU6p4EI?=
 =?us-ascii?Q?6nLo12TxKWxCS7/rxS1utwJBz9LEeQAuC22alWXMDJLheIpoa4AKKPN6CnfC?=
 =?us-ascii?Q?fm++aYxdnib2o0luSN8CrtkpA+3Xf8bQTczEn5UM8wVgC+CjmIankKKpiZjL?=
 =?us-ascii?Q?FfJ6JLsfm2YnhlX65sMtnPsooFuBZMC8Os7tf3aPZBy07kG18VlGkwNC+kCm?=
 =?us-ascii?Q?/TFxDWLNM3cOWCBlqvdQLOl1zAxpKuHfdByAXO6Xh6mpUQ1DM6e9vuduBUEa?=
 =?us-ascii?Q?CFiovcgEmnWArF1ajYPSjyOBTLyW8AZo8yCjnQDL1jCWSz2PKr9LJE521VJR?=
 =?us-ascii?Q?3+Gt+FWMnuRQeK7AgBNcUEwEEw37GS/mMGOLiaYjkjiyvRKVRaSczDjDN2H6?=
 =?us-ascii?Q?2APCe8xMTeWeHAVEauyUC61vzuEhi9aYHR5Af1i9HSIbWEpEpYDMJXYm20Kk?=
 =?us-ascii?Q?N7qZ9OLgsLN+YAPFzFkphQrCrBPluBFnntCVvSXyoRB3DG1n28UhT7LxxYus?=
 =?us-ascii?Q?/pmsH742akdB5R/BJpMtSgo43WIr7Ufc8Svs/yeHWnwixNYAuEMflcxYqPzk?=
 =?us-ascii?Q?K4CO6T8pP5jEQlXChg/NrKCgrYtTxi1q55EesX6WBHnBVhN2PfHA7r40Yc85?=
 =?us-ascii?Q?esYj3mE0O0sAotztNnvdpqi9FB0p0Gb8e3icd5pG7EC0mJTusDPHB2Iv3rl3?=
 =?us-ascii?Q?B4oP2lFeubTTTmXbva+5QnrVyEU12tZMV/KIeRTSASexf/JYBldKL8qLSaxG?=
 =?us-ascii?Q?VlvJ/HV0C+RRiN2PBEKlEtnZODzffZyKdbXzXEOGAFlM0CNOLHB+032sxP4F?=
 =?us-ascii?Q?K6EX9iVUVrClNkfi6gNle12ODws4y3popJgozIslgFXQIZwEHzZdJ+noqNYA?=
 =?us-ascii?Q?oSaGw6eJlIol7JCiLQFG8SKL2Sh5m/I2h3XV9EjJLY8rQ3t29sXhUsQgTJxO?=
 =?us-ascii?Q?4b9L/TyhfCTAiFVJNV4XO7BLNcV1DZNRTkaGKTEnLdjSkt1DdSTMS3yFdHEv?=
 =?us-ascii?Q?jXNloLCdkIwXE2wu+Z6UBMhK0rd/ZCP8RNdn1F+5gPt/DChA6yCev17zTJ6s?=
 =?us-ascii?Q?bxpiz4DDCgD56vB+Q9cIUPa5rh5m1ccZIoeQL6Xh5KblN0Ys/ln/r2Xpwlcd?=
 =?us-ascii?Q?JreQUco4DJGlGGzNIwgceQIyC75vB7qIm8hY1q+5HmvhFg=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9192
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C711.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f60c983c-6487-46b5-c984-08dd0d7d2c6c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|14060799003|1800799024|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5RM4MIBm69CsnMvtnyxtcN6KPSYL5BjNpnDTdayeD2lxFJ41Aiqgp5WwR0Yx?=
 =?us-ascii?Q?R4BgkfhL8hAi2UPFcDIbbQTjeN1SQN0DxcV2mvblzm8fEbPvQadN0mX/vlP3?=
 =?us-ascii?Q?5y1KaM2MEL/FaxeZ28vwvVfvzgy37YGBeIRj/ZzrQv7s7HF7Gw+cNk20kKR3?=
 =?us-ascii?Q?mG5JJRgdD3GvTRDh/J1pAFb511B0/gelfmTnnm0QJrxbW0kjZln+6ZGUyuO5?=
 =?us-ascii?Q?eJjJChhR9GYzXzLbSGN1+YpCfqLunpLr507Ss6h/K5BohxMmNoJHC872J8jo?=
 =?us-ascii?Q?snmzDH1POAXlP3anTcmixFkAPSTZL3+Jc485WtQ2GHfTCJYn5BmBqktKSmXQ?=
 =?us-ascii?Q?nkCOgUIKC6ufaHIXKESn7RNvm4OuKquR6r3HDIyU0HdoQvH/lDRBUaYd0Pms?=
 =?us-ascii?Q?g5S6c1z/qPhLeenwrGK0c8gk1d98+aPndLuZQ8wpbMRGoWdPAn1wkQOBZY+s?=
 =?us-ascii?Q?Cs9j9AdT0+t1Oz1ECco5rOIMpKVmiTarMmw9svqJBb82j+ygzhfU1dZYt0M+?=
 =?us-ascii?Q?o6+uX03sDOogOIAug2jQyq96ZYG0YIW/beshnPQyzsphNgCAuxap1sOnoz8N?=
 =?us-ascii?Q?gzDVnp621uGygpNNmFBAI6VQcUkfdOuW1SN3Tu2vlZFw8+uJK2KYKZg4XSdT?=
 =?us-ascii?Q?vEw1VU5j/ctixUycIwF1UTKSnaMawuKgrBEMd5CpQgZVRdIQJZ9xxTkvYZbH?=
 =?us-ascii?Q?lgvc2l/GMf3ptKbXa/8dvaZbTLBrJKJFxwarVu4QYtrokWnvhk/UnZztqbTl?=
 =?us-ascii?Q?pA7zZ/+A8wRtnN/8FxhgC4O6Lk/+o9D3COuf285LpEemHgiC5S0d2U9i2Ji8?=
 =?us-ascii?Q?Wl0mZExjFLxSsUk2MVjdFAMdf4nV4BT9BhFRQ4TEVamjKlf96j9eiE201FW6?=
 =?us-ascii?Q?smPC5n19H+OE8CleMV4k0v7a3CN5b9fimr8/zmsJTurAJ6/PL2faYlXeHcp8?=
 =?us-ascii?Q?mcoCJzbL8YE4xEc51aGjSdixR0VRQAKTe/IX2DBj/pnosvcbWpFeBr9Sk78D?=
 =?us-ascii?Q?S0V7Uv8PsLYTZyAnP7/xdYnC24yG9RYnuNgd0MfhLU32Q3qQpf+AWwqEE9RL?=
 =?us-ascii?Q?/PoEm8DdnP9SpIUhQOOl69fkcpwWsq0zo4/VHv9U+MXSfdMkynXfO2RjrleW?=
 =?us-ascii?Q?+fNu8slfkn2fvBvydgSB4kL26IUzMZv22xIhfofQrRD3sW4+oq9tvBdO43No?=
 =?us-ascii?Q?CIHR8xWHFtfXuLdYGUHzQeK0xERXn2KSBimrD6yfcrzJBn3xQi0x1yazPLt8?=
 =?us-ascii?Q?yXZ0kEVUliyaOAdQG516hhp8+ofZcrFVglh/bGUQ9jPu3xoemKp0/Q0Fh7aQ?=
 =?us-ascii?Q?VQz4WiV041WvRkrVQFII9xep16Uyzjwi2G5Y9RRmgM5nye3ymWc3zLDDPGjM?=
 =?us-ascii?Q?lPIIMga456z3W3Fjph8BBUUAEhN8+KeqRQ1YFc+f6Oa43vaxMyCeK7QQgGNu?=
 =?us-ascii?Q?FLteEn8gvyOaoivik97Ee/Rh2jOJegqC?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(14060799003)(1800799024)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 18:15:57.3452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c818e769-a579-44cc-a3e0-08dd0d7d3560
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C711.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8454

Hi Ard.

>
> The DT is not stored in a variable.
>
> If CONFIG_EFI_ARMSTUB_DTB_LOADER is enabled, it may be provided via
> dtb= on the command line, but I have little sympathy for a user that
> passes both dtb= *and* acpi=force, so this is a scenario that we can
> ignore.
>
> Otherwise, it is taken from a EFI config table, which is just a
> <guid,addr> tuple describing a location in physical memory where the
> firmware has placed a DT. If the firmware puts a corrupted DT there,
> the firmware should be fixed instead.
>
> acpi=force is intended to force the use of ACPI tables on a system
> that provides both.
>
> > also, although acpi= could differ from architecture, the force option's menaing
> > seems the same over architecture (ignore DT boot with ACPI tables).
> >
> > So I think the check the "acpi=force" option to prevent loading DT seems
> > good.
> >
>
> The EFI stub does not care about ACPI vs DT boot, and I'd prefer to
> keep it that way unless there is a good reason.
>
> Which real-world problem does this patch aim to solve?

Well. I had lack of explaination. In case of Juno platform, it loads
FDT from "Fdt" variable from the storage and install it into
configuration table with corrupted Fdt because of FDT stored in variable
storage was corrupted.

In that siutation, If it loads corrupted fdt, it prints error message
while sanity check in early_init_dt_scan().
This kind of error message would be confused to user because
user already specifies to boot with acpi table only with acpi=force
option.

anyway, what kind of way to install fdt into configuraiton table is not
matter. but when the dt installed in configuration table isn't valid,
it could produce the error message which seems violate user specified
option.

unless check the acpi=force to ignore DT, I think it would require to
check the installed DT in configuration table or passed should have
simple sanity check doen in early_init_dt_scan() so that error messsage
which makes some confusion for this situation.

Am I missing?

Thanks.


