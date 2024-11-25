Return-Path: <linux-efi+bounces-2209-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C819D8C68
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 19:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7FF8281B48
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 18:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3161B85D0;
	Mon, 25 Nov 2024 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UUen3gmo";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UUen3gmo"
X-Original-To: linux-efi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9045E1B6D1E;
	Mon, 25 Nov 2024 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.42
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732560485; cv=fail; b=b/hi4pffXFp6m8lCWSBSGYAT7c8wlziUOk3GoL6LnfnCdOQujnVZo8ECtmy4FJCp2LAWbEUWWcvn5SEetIfFcjmkG1M+UWE4S/D6swO9CTaPW+DyNsBtcSh60DTmLSy4ZMNXmISYX6a4cuk5pMkmEUqlwcfnUAQvsnyfcUhvEMc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732560485; c=relaxed/simple;
	bh=S+PyKJi+aTy+Alx3BxS1pS1wtn4JbZn6q8rhoZVTqyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qGqvmAqlHaUznhheuN7SEkiRdCAhoC0vQlh1pLiyvXna42CHAe2zawELtenI3byCs/K62+F5jPZr7CIqTLaqVBGA7mKj2NNidET/DEshwhM+G1HDBJ7Oy5WbcFgaygRz+hSi+X1cmM2ApyW0rIoSXFgErTT1tw8R9M/V0xVNLrI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UUen3gmo; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UUen3gmo; arc=fail smtp.client-ip=40.107.21.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XuLKVfXTdKVS9vKVUhLVQHNe+kuOtanDfNpCkPvhL99i3Q9W+sd/VdeprHpqxv+cusDTl2CxDKJ8q2MZVOv+wXQ8TX17ltcm55REhjvfCUfFrJzCrTw0c0qRR82yQnYKKIZYG/4/WO+eteYpWXyDXCl3UMpCrVnjEV2UHbNXOfQ7J2tkSbZvlyqHVD79fvA0H3sQhGJZzmLlY3Mg0H7R/akplrUJYBcavQwaaLVagJzrxfeMrGRmwlDBxxiv4VSvsGvYjHaaUdzKmBaps8VBO9tkTWFh4s+hshV9F4CZREWRW6W/Cu1iGGJGuDvajLp1qZ9j6BTaDoJ9SkiAHv7xvA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+PyKJi+aTy+Alx3BxS1pS1wtn4JbZn6q8rhoZVTqyA=;
 b=PKCiTL3jxVTyksBbT2QKaYB+296+PSDS1p8UT8mLNQnMggWQoy39E7lvqNf8Vb2XZIrnhZCpBRK72EG5FyLr6PofqubAN9AhGvKbTXgowJyUQY5FFyelWVUpWZASRC5BJ+79ImbTrbY5CZZisf0U2AqF2t8NuFd3Muq0B/7uBVQo1RH5JKzlIVzB7trDHubPq2G0kUxZ2QkFxkwiYAD9Fl1W8k4+9vxjTgYzPhpryL0Zz4ZelWmbR4yNP+83yOF49uDWU+8mguTP1B0LxGSmOg8kBAJh3C/6c6kpFmsstY3DdAnC0z8U0pohLZBg3QbDqJjXJIWDYytgIadjYthEtA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+PyKJi+aTy+Alx3BxS1pS1wtn4JbZn6q8rhoZVTqyA=;
 b=UUen3gmoNxQnAVRVrd1wTmwcjhLRB4LMvL+uUtiSY/bNW/3MblAxF9AJKL7+rkKasbhRdB8mkuli8gp6cCtKFqvsE+jyvqBiDQesI7MehVFb5p1bwvHLy6/kvVHBAV+auMdn1D9qLvuHbPZlJLQElHRNPrka8iI1kNfJ8gZkt18=
Received: from DU7P190CA0023.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::25)
 by GVXPR08MB10985.eurprd08.prod.outlook.com (2603:10a6:150:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 18:47:56 +0000
Received: from DU2PEPF00028D00.eurprd03.prod.outlook.com
 (2603:10a6:10:550:cafe::39) by DU7P190CA0023.outlook.office365.com
 (2603:10a6:10:550::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend Transport; Mon,
 25 Nov 2024 18:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028D00.mail.protection.outlook.com (10.167.242.184) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12
 via Frontend Transport; Mon, 25 Nov 2024 18:47:56 +0000
Received: ("Tessian outbound d013e61db77e:v490"); Mon, 25 Nov 2024 18:47:55 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5680d3a1c8097d7f
X-TessianGatewayMetadata: zTFRKwTlBNpvI6vADNslsTZRf8gDwQS8StOpmV0mqlUFFycGB5hH+0TlLRNcTQtC2qQvteZMbLbQb5lF4kUT/uv0rTVwji1brfCGItJu8DDG7RKFQQ+4+yvulpJqI028ps9T8cW7D8f98ukqZrfxDw==
X-CR-MTA-TID: 64aa7808
Received: from L12b98ffba7f3.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id BD128D3F-9A23-4011-88FB-B7E019F66716.1;
	Mon, 25 Nov 2024 18:47:44 +0000
Received: from AS8PR04CU009.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L12b98ffba7f3.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Mon, 25 Nov 2024 18:47:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5pBBgi8z/2/AbsAn6ZvRHQNMgbVgPf6thdtqbd6rOzkNAspx/5xH1ARgXRsJS+d4uoloiAe86LSvWq/j7z43jVcK00Ls6YW4HpOAyB+JWF60UL9ndoLZG9ITqbPKlFkH9mYqcvq7xGm65ZyvxEzq22M3cfyFe36EVTC8p+7LrKwhZ1m3b0SHosSSu1F9CU7JSGDjkwvFzfQ9BNV6PeqGqsrAf76QEF+3dGBDRtEMR3fsUpeWaSR19EVl70+ALoWPEt57iLDXJ9xSYVG8WZqR8Tx12tqSn9hxWBeA19ePKQc6qzp/SCC2x95C4+qCs7QRAiPD0nKPH+asrjOid/lrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+PyKJi+aTy+Alx3BxS1pS1wtn4JbZn6q8rhoZVTqyA=;
 b=gxBzFhrQHyUPZ9Za/jF+xtSW5GLLp0IAHlyAdV8GEe2bb7mp0IuJ2keHXGRaCQVLgIY8FxJ2btSe+xkVgCE69uXR+o56fQHGnTCekqlSL7Vo+DS+EdHA/5MMiMvSFoCCbm0HOSeUQYCKhEXAgDMxb0mqYSI0g52HPyPocBtGZI6TkXJ1/VhvJ0r+CtraS3m38qc81o6cubyKYAEANZROK4YNynkp5RLJYYKdlHwP9Qpo4vCawX79f5Y5E4UzY8Qi4/ertvl1488CDrPYEYLmrdzHOSV/Qs8AsWXtCzyU30A/OHpoWzwVdBk0SesqjMlTcaAgKr3roMLCQ/ExWM/ACw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+PyKJi+aTy+Alx3BxS1pS1wtn4JbZn6q8rhoZVTqyA=;
 b=UUen3gmoNxQnAVRVrd1wTmwcjhLRB4LMvL+uUtiSY/bNW/3MblAxF9AJKL7+rkKasbhRdB8mkuli8gp6cCtKFqvsE+jyvqBiDQesI7MehVFb5p1bwvHLy6/kvVHBAV+auMdn1D9qLvuHbPZlJLQElHRNPrka8iI1kNfJ8gZkt18=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS2PR08MB8670.eurprd08.prod.outlook.com
 (2603:10a6:20b:55d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 18:47:41 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 18:47:41 +0000
Date: Mon, 25 Nov 2024 18:47:39 +0000
From: Levi Yun <yeoreum.yun@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: broonie@kernel.org, sami.mujawar@arm.com, sudeep.holla@arm.com,
	pierre.gondois@arm.com, hagarhem@amazon.com,
	catalin.marinas@arm.com, will@kernel.org, guohanjun@huawei.com,
	Jonathan.Cameron@huawei.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2 2/2] efi/fdt: ignore dtb when acpi option is used with
 force
Message-ID: <Z0TGS+EA8JlO3WXq@e129823.arm.com>
References: <20241125170758.518943-1-yeoreum.yun@arm.com>
 <20241125170758.518943-3-yeoreum.yun@arm.com>
 <CAMj1kXG4A4h3=bZC6kSrwsZa7p4RZ-uN5N67pZUFLOQ2RJE64w@mail.gmail.com>
 <Z0S3wiugr0JML/cV@e129823.arm.com>
 <CAMj1kXFOdGaYiVWOyFEK+Lz97YdzAu+AWj5trZBTL+Xc_DXnmA@mail.gmail.com>
 <Z0S+zP3u4781zNwo@e129823.arm.com>
 <CAMj1kXHysummq5dG==gOmQr2DgtU5Ee0_tJbjGagRJniAee1vA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHysummq5dG==gOmQr2DgtU5Ee0_tJbjGagRJniAee1vA@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0186.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::13) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS2PR08MB8670:EE_|DU2PEPF00028D00:EE_|GVXPR08MB10985:EE_
X-MS-Office365-Filtering-Correlation-Id: fa38b554-48bc-497a-6aa2-08dd0d81ad04
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?x4GB4MiWrPYGZIn4NeN14jxirAF9kGNGCEWETVphABs9FiwyMJz7jlVbNp6f?=
 =?us-ascii?Q?lbwSr0MaILNWeoJobRE5OJPyaKnHA8bWYBDb5adOdu4/Kj4kEqIOK9AF39I4?=
 =?us-ascii?Q?PzgP8bPC+Vv+4l7IjzjJWZli9jis5S9ZRilOGjKoDwJdA8SXFsCD+IELwZ82?=
 =?us-ascii?Q?SNMlIb4KTuXvXeOViyYugCtemYUA3UGb/TQ5/SoPKl2rXTU1WQsHxTJ5O/N0?=
 =?us-ascii?Q?Q+EH21HE2Ja4D8lh7jYkvbGAOSYJfI37h78E9d7vPgAhEjE57bEKn21f4yme?=
 =?us-ascii?Q?odrrpuK+zG2jN7g7R6/3kST/DuazH9jjbOTOoVG1MTvQScUHUQCc3WLsImin?=
 =?us-ascii?Q?obrBTR/dAr98ztNV7SJumFgpG2nkXoDpyue4U6eHB2CTo+R6hKGC1YfNlLQZ?=
 =?us-ascii?Q?xz2nozXbkoKSrId0+fCbXRYmJY8umffixboCKEEof2aCI1Ytiv1hDY4SzsXW?=
 =?us-ascii?Q?qWMFoZDj+1RI3673K2kAJ6KzTNg3Fr8ePxOPFDE7UZgD3jwuMdvYaUg9JrMI?=
 =?us-ascii?Q?j9vT/31EXYPno1VqE1MPMLzQ9YyGzagiXxj5EEEOMZKorJYQQNtezxq3zKhB?=
 =?us-ascii?Q?DlUjRHxinT4yA/5G0U41sKbaP3P5oAHySdNhhaKVKwr7BIkGk4t/Io1KkyyY?=
 =?us-ascii?Q?JM6ZHieBl22VZLdC/qcVz1E36W/46KkuyuqCOxPk/fc9qfqrNxEH4FxOrrK1?=
 =?us-ascii?Q?APqLSnKNNeGHkudb2ZPlZGBtYegbTLWIMAcH8hkQfPM5F/B0sy2TRkdBA0XI?=
 =?us-ascii?Q?tJixS4S2F1bhgQoyGIQ9iffBiichJaxXjds4O7VM6u454cmifRJjUkwLnpAR?=
 =?us-ascii?Q?Hl/LJGaknNe5l8RGw9lK5oCohwJGRyCfUTKYWkCRETLOETV7n7UnAWEaOAet?=
 =?us-ascii?Q?00EppJct/TGCFroBApvMzZvdtmTq6JUsgPndmhapjoDT8SCnEK/6ZIEofIrT?=
 =?us-ascii?Q?qrYAhdnYfEe4pE4xwzU/RS6LzyHT9XhHyiwcZa5eN+Pnnka/yaATYYSuFPD+?=
 =?us-ascii?Q?XRcdMadxSjV+JhvOJtdezOQiKZ0Le8RXv0mKM9K8oAhz0DKVjgxLnxjy34uu?=
 =?us-ascii?Q?3nsgvYBVTdiqgDuGbfo8XXQPntkutj6cy6P/UDzj2hNnSeMGrl+qbyih2dAW?=
 =?us-ascii?Q?ZF3URXSd3DFAO3ZKaIANIsRijjfYM57hfaIjW2NxxSRy/OJM5ses+SK+Cn4N?=
 =?us-ascii?Q?rnAls7eQ/bamJw5HR2Pe83BOapI8f6jU+2db/PKIIIAz1dmnknu1aR7UTkVg?=
 =?us-ascii?Q?2nw1m7gpysus7p4Z7FI8zWafB/D4K7v5+o9w3niJNzPz+IQT4yyxc4fY1SHn?=
 =?us-ascii?Q?hZEUNswhgcn8+E1dYwhPGY4y/hI1aHgI3gYRGG8agPF1nA=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8670
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D00.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7d3d4ec7-78b9-4235-e772-08dd0d81a424
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|82310400026|14060799003|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PZHKhkCkFf9Ul3xHYtzHIawz6SIbsewpKydOLLs+ZdasWW8zJUCUrES3K3fm?=
 =?us-ascii?Q?SctVNdkSIsEe/dVSz8RC2uVekNcaP2RGypXKMuPyiKtugZgYukD3v6Pd3U9y?=
 =?us-ascii?Q?i/8BSxarHccBMVkjhTXAzfMjbNlyYBLjC1900HA2l71YgrPQNCwmSV8YDr2+?=
 =?us-ascii?Q?aLdf9b/4DSN5lhqh0Nfwkd22sSNQh6af0Lc+/FKRQ1tHBnMq9U1/6nlIVi2T?=
 =?us-ascii?Q?xyh6jvpnxWsqx0Bcst+9+iZxg+sBfgGhZJ5lzZ/vRQk1E6lPyCfB7JXgx7OL?=
 =?us-ascii?Q?a/NisYGe+qXnZOeX2AXegoOb/z8lBCXxOHGz7HrA19Z7YwhwrUYDWkqqoFQ8?=
 =?us-ascii?Q?WK/U76dbO52mWHUl7gW7qPWJVVy7mD7viOE5cvsgVjnm2ygyEcJ1AWvSlTcD?=
 =?us-ascii?Q?OUAzK8hw5nQhTw8REpCOyIwuWO2LQOpr1d5BA3Kwc9GYrPgUjwKKThnBIjkO?=
 =?us-ascii?Q?sPrmr5nicAmObz5ghg5PL/jip2xZvUiRD69FjmQfqIncRvLqIq0u1B7Aoc5k?=
 =?us-ascii?Q?sYykWG1QWSQeLQ3kcWUXFMVaCRgudC12eBGSqzrOoKvMD4feSkILXjKQ6oX8?=
 =?us-ascii?Q?PB0v5BcU72/wxC2ALG9PYcDhqF8ZwPxh/lisOtJV+hCCirRAIkTaTfqnZdqR?=
 =?us-ascii?Q?CwdUitdzNkX31M8s0yBZb8tserl/BTt7ut3nK5s4Q2jNWnIzrkLJTCZKMYmV?=
 =?us-ascii?Q?nznrvjknmatIRxjrCcJB8SgJKvcgK5THTz2Sp3208oAjotIhNC8ua64Qhhv6?=
 =?us-ascii?Q?X8B68Nrt6pVQnJi8EaL1u8wsJIhCkqjpGAuu2BUsZZPB/dL+YWp7pdbkdrIA?=
 =?us-ascii?Q?P+R5DQaBg7xmzNDGJ7jDSH+Shoz84rxuUafMoFdaoNEZUf0H0QbHcVNW2Vix?=
 =?us-ascii?Q?Qb0ouALdkqO00vdlujXE7fJou4veMdUa9Fu/CTunssfvO39d6hfvwabtkyND?=
 =?us-ascii?Q?2stEYADW//McuM2GEUbvJrRwd0rQuaMw+Bl9IOUGELz9/2TtbN1p3vYmY6ar?=
 =?us-ascii?Q?VA1dePebAL3B+QiHwsbaegqfTJiV2JM8vZYM0V47BIDDqnBm4BxvSRiPjAxB?=
 =?us-ascii?Q?KHmxJNLnlXis7O7LuoVpAayhL4z16HAp4az8VCfeh/GrfXh+NZ3IE2Uevwww?=
 =?us-ascii?Q?9coJsXWLx04M2gsR4WHTsyA7V8zoHEo7ie5vZ63PRjlHi0PcWYO+F8AXak/A?=
 =?us-ascii?Q?uJm1DXu1ouca9ui8ebBhQWMYGg8jjm8OzmKHTotb69tBBWazHaDGIRkLpUpC?=
 =?us-ascii?Q?HDASkJLix2dRgb5d8sUFB1S5Gn1BuLIZ5IhVO7L6mMkKlQaYpi+wksDsbNXi?=
 =?us-ascii?Q?zPYDFXij/5n4AevJ/28nJP42nma125NsjILHBd0JpnqlzNaWRjT3hdtVn6qP?=
 =?us-ascii?Q?8Wv1tw5XjiYmQqs3EEgO6FAJx4DWPZS1Fmr8NqUD+b/s+ZCbOso5M01yJBcv?=
 =?us-ascii?Q?aSHaTQ9Cy1p5kOCEBXLtsG3zUlnpIxlc?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(376014)(35042699022)(82310400026)(14060799003)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 18:47:56.1012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa38b554-48bc-497a-6aa2-08dd0d81ad04
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10985

Hi Ard,

> Thanks for explaining the issue in more detail. Juno is a development
> platform with a highly unusual boot stack so I don't think we need to
> accommodate its quirks in the upstream kernel.
>
> And I still don't think this is something worth fixing in general.
> Even if the machine description should be taken from ACPI tables only,
> the DT /chosen node is always used as a conduit by the EFI stub, and
> there are cases, e.g., for initrd info or the kaslr seed, where this
> information might come from the bootloader, such as older GRUB builds.

But suppose the DT loaded is corrupted (i.e.) no property for
"#size-cells" in root node.
In this case, uefi properties in chosen node will be installed in
"corrupted" root node.

my suggetion is not to check "acpi=force" option but verify dt which
loaded via dtb= command line option or
via configuration table in efi-stub code before updating
fdt with uefi properties in chosen node so that prevent generating error
message.

Am I missing?

Thanks

