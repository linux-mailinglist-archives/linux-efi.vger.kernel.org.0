Return-Path: <linux-efi+bounces-2206-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526069D8BD0
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 19:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3582AB308EE
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 18:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5391BBBD4;
	Mon, 25 Nov 2024 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rYAZmfN0";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rYAZmfN0"
X-Original-To: linux-efi@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41361B87F1;
	Mon, 25 Nov 2024 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.55
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557591; cv=fail; b=ALRpyagP1d9EHEK/5V+bk8OyBtSb1kT9t45tvh44LFaon/FGVohaoIPydMezHCu7GUKKpkaTxKbqEGYdkCftlwtlKrUwSqSR7x3lolnUPL021hq95wDQpzAkFVZM6bpus65X3WEh1JoijDEHcCsbh/hmsjj0zD5tolbBizazZIY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557591; c=relaxed/simple;
	bh=IX1YRl27HA9TAGWRseSqFk+YAz+W3EWG3+oJXUWwiXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ExMvrbCFWt8is6BAbKjjSyKjpwsCGYNU3zZtY6j4c5y9y/VS8/IrngcvkQQFVOvPN9Bwbl/+0t0oX7sTlyd1Omxayvd4W/Vo3vh23BU9uytqM5pXGrivRsTkUN/v6dKwF99h6Qw8Q4lPmnjaw7VGfSVBOWtyV+8peyp87N9dRRo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rYAZmfN0; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rYAZmfN0; arc=fail smtp.client-ip=40.107.22.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ymUJed9VNW9eJ+0IoBg9MTwUkJdVBwWJkxqJucdtoUzv80Kiu/lDcsxATtHFrn2JS01qqfJJLQsLEEVE5Lc2oTO7oju19NGbJX8eLcwKPkEVqSJ5Q8hgo0y5GevJShpBGwE1GsOIbCqIcOyWq2TJGYcNDvVytdtcJoUskLmhpXmZwc5utXcINPx3Xnn/QC96eYFrFiGnsVwKc730vezkefUKk2tlGhM+PwbuYC216o5m3J+XIJbikiLJ1/KzKgEjJB3amMWesxJhLVFVssbiMBlCo4n2GkYz/3jabGCWBTAM11GqAVtOdhwXM3SMVHF2z+c/9G1ETfakiX+GW/r/ZA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IX1YRl27HA9TAGWRseSqFk+YAz+W3EWG3+oJXUWwiXo=;
 b=gw08o/Bzc9sUi115BkREMKBIM385e//1En/kBrw6CDv6kpip5htAKBzLCxarzJAjis/mo6z9xmWrOjn7+7cCZ7kfVdLWmnAcR9hXqFxL4e4LmbQ//E2XGVkPv3xZIW6P+D/FooiMt2GNURI2y83GQq8EO6uWiaHeFT9Gutcy0O3sdtWve0yVEKJx4j9Wi9ox6FBzzOSmOu4j2r4sCmBFOwitPzpRkHTfJQLt5w+GP36yrK7hSui5TKTDUm6C7xcMOCiSL7d2q26l1wsV04Ri0yg7ZjCro6CbA/aW7DonH4Fk+Xk89cnSbB3eH6LyZjiwu+lh/6s2QGJzjYcn9NkGSw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IX1YRl27HA9TAGWRseSqFk+YAz+W3EWG3+oJXUWwiXo=;
 b=rYAZmfN0oXTQKqhG8z4F1phwE4sCQCA/uK8o9MeYP4yJCwHrO1CAB0yz27d7aCLh87UpKDCa7cq7ngz6E8JwLpcudUe1SM4zrysIGKmoNfJjD7OHxjawsG/KIZUnb1lhqBCaBqVTvQbNMosJB2piCisezu9Z0h+inrCwBTTYgwM=
Received: from AS4P189CA0022.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5db::6)
 by DB9PR08MB6697.eurprd08.prod.outlook.com (2603:10a6:10:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 17:59:44 +0000
Received: from AMS0EPF000001B3.eurprd05.prod.outlook.com
 (2603:10a6:20b:5db:cafe::f0) by AS4P189CA0022.outlook.office365.com
 (2603:10a6:20b:5db::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend Transport; Mon,
 25 Nov 2024 17:59:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001B3.mail.protection.outlook.com (10.167.16.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12
 via Frontend Transport; Mon, 25 Nov 2024 17:59:44 +0000
Received: ("Tessian outbound a09d3701ea63:v490"); Mon, 25 Nov 2024 17:59:43 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f1a39ea5cc6cdcb2
X-TessianGatewayMetadata: QD21NpZ33VEjVC7ckO4TP+iRUlPtTfLAofaMR4frFdpd3SS+41PDnDzIM+OoRAz1h2ql7PGcO+X6GWx6IqAfIKG+bLzecpGO4M5a23mVQ9JOCcLV6dr+GPk6Ff7jf4WSSeOdPQicjGVz3Rim+uyzoQ==
X-CR-MTA-TID: 64aa7808
Received: from Ld65a3acf902f.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 066076E8-058D-4EE1-B4F7-9F7794C4AF39.1;
	Mon, 25 Nov 2024 17:59:37 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Ld65a3acf902f.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Mon, 25 Nov 2024 17:59:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ui7ZONCW419R4OhHMPWU5t/F1F9gvnWjj6ppuPt5zZFhOeMVoaj9f2MgFZpUsh2XyR46P8JXAjjbCUN6Jk/7IqUk7ieA479lGF/BVKmzGQdHxas4QJpRP0TIuAEJhG5yYuEtBoKWtfEBXtiVr6FAXgTD7JtJ6IrKOaogpGiX5sHXYuAXwsGZkgcyS0qHuJV9FJAFkUg3k9CLnMq4IOIBFoG2DXKVtuYO0Ab2jjpTZ1FZxdn/H+aWvu1kUr+vtBzc/7LTKsxo0hcKIckbM6lfoD0u3s3CAOxtc7Ws4apVxVJJP+16jXQS5EGJiZiNL4scNdBZ67yd/Ch1F1ciYeS4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IX1YRl27HA9TAGWRseSqFk+YAz+W3EWG3+oJXUWwiXo=;
 b=VljsxbYBfi/YK5xg3BP/o10rCX2baPY6Yv4DGIWVp00X//I6UXMJXo+Xo2KIwW9dZC6y/Z9P7/VsGoOXOPCajOp6aYYosBO/PlkyxtFY47Rf8OYSvLwn5mn6HAeu89+HMFBqCCEI+JGmZJXRAqTHbzZ7HT5s05XfzCu+QruuC96VM12dLlnGAXaZp0B0D3V8hO3yPgSQKOE3ZGbKxpoL+UWSwvoq4IvN23JCo3Ni8PVSY+wRBGI/lO8oVYpCgMiU5hX4MxL7VT7TymtLYPRNnn9UJfP07hfr7xkjGaRoZQD8b8sVSpHvDl7Eooz7v7fwAhpgIVTJNYcpEMwIJtEhPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IX1YRl27HA9TAGWRseSqFk+YAz+W3EWG3+oJXUWwiXo=;
 b=rYAZmfN0oXTQKqhG8z4F1phwE4sCQCA/uK8o9MeYP4yJCwHrO1CAB0yz27d7aCLh87UpKDCa7cq7ngz6E8JwLpcudUe1SM4zrysIGKmoNfJjD7OHxjawsG/KIZUnb1lhqBCaBqVTvQbNMosJB2piCisezu9Z0h+inrCwBTTYgwM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DB3PR08MB10333.eurprd08.prod.outlook.com
 (2603:10a6:10:436::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 17:59:34 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 17:59:34 +0000
Date: Mon, 25 Nov 2024 17:59:31 +0000
From: Levi Yun <yeoreum.yun@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: broonie@kernel.org, sami.mujawar@arm.com, sudeep.holla@arm.com,
	pierre.gondois@arm.com, hagarhem@amazon.com,
	catalin.marinas@arm.com, will@kernel.org, guohanjun@huawei.com,
	Jonathan.Cameron@huawei.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64/acpi: panic when failed to init acpi table
 with acpi=force option
Message-ID: <Z0S7A6uOHpXZbxfy@e129823.arm.com>
References: <20241125170758.518943-1-yeoreum.yun@arm.com>
 <20241125170758.518943-2-yeoreum.yun@arm.com>
 <CAMj1kXGBnYQi05qh0QZk2hVLjVhS774-nT=HLdL_kW1d7nxMVg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGBnYQi05qh0QZk2hVLjVhS774-nT=HLdL_kW1d7nxMVg@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0437.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::17) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DB3PR08MB10333:EE_|AMS0EPF000001B3:EE_|DB9PR08MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: 3972a702-5c1f-4298-5d43-08dd0d7af14d
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?ZnZs8VdSw/pd1mhDxeY2z3kWZJJe5y5MKIkKDVLq+cecaOnfZIr8naGgDhxu?=
 =?us-ascii?Q?FkWboYRD66kYwaQVacKYHaPC0fuddHPXDDJDjjIUen5qwUIpcewC4J0fCd61?=
 =?us-ascii?Q?bvbSceNNpg3Y6oh95u3VOZyNLk8WshLcz0WKwa4FNj5Ki4d1UoTCmRz/yDdI?=
 =?us-ascii?Q?lK1FlTGOnTU2Et+eK9RnML7nwOQdxZBioYIPx+dJ4vP1FyH4kN4AJbWXLTqw?=
 =?us-ascii?Q?PETwWnZtLJh7G2SQPkh/0nm8hBlw7C1wAoypoqowZTu0hPzk/7qx44xuKZRr?=
 =?us-ascii?Q?Gqsu5sIswMqQWXIxAe5sp4kqo9Pw96SNzDXYjFNDrmi3KU3VxDhlNlemMzNO?=
 =?us-ascii?Q?4Kkr9oulcT6T8k+XYmI0pTJP5/D49oy07HO+JPbP8DMjLPKkcWgeOnOdnNY0?=
 =?us-ascii?Q?vcqgKDQL1yNIEMo++IG/njaVlTMuDGt1bRzxdL0CrxbXAKcn8C1xF1v71Sik?=
 =?us-ascii?Q?l3SIZXXZyZPIEIlSxVzOuIrGveHKSRYEI8w6sjp8SwB0dlQF2w4DSKX2Ha1H?=
 =?us-ascii?Q?BpfdtUniZShxLqNbaoqjKKu8qxVcwwyVs4hzHnYAVkVPRcs1yBujfVLyO3sU?=
 =?us-ascii?Q?uf5Wra8GYy92myLS0sYzY/zkGcbsZSrfdWmngVG71WCWwsiJbHTJMAjNvRbU?=
 =?us-ascii?Q?YBCoYhDuUBpyJqIMe0D++h/376zVMwgjSr16rKuN4gOeQEB0Naf7Jh3lxKwx?=
 =?us-ascii?Q?fiz3QyX5VoAqmxkX2EnM01siTxP75NmgFWKrDw0pajNpK/+PNjYJg8DZxfzf?=
 =?us-ascii?Q?xP9njqfdPXBTHc5qSuknqm1asYtrwADXNwMX0pamR/iFN2pAO+C3BgUPB7+J?=
 =?us-ascii?Q?s4xOU26zTrK+Air9ctJESwY0/gxpOai+7G3ozIwCCCFWK1DI/XUtps7KmYUx?=
 =?us-ascii?Q?7LtLoL73y8U1wW2ugaub3DcJ02IoCnQrnia4iBfW8aYdKSRT9QhcJN5WSUHX?=
 =?us-ascii?Q?g4/hwNe2jHFEmx6hGyFpB0XHFfa+n4gulN4Lp709PUPqNGAPUscwpWO2vcxl?=
 =?us-ascii?Q?VVP1xvGGBW4ni218p0SazAD7850hBpY4BN/jKTh5f2IB+uBAIbzbg3tsre0C?=
 =?us-ascii?Q?SYW5Qx/yVZm0ApsfyDsd0MbESbuHESX4P9me4aUEbLEW8VVJxGngXbwKwL8L?=
 =?us-ascii?Q?szcfaDsMXHxyaqZlhwVz0a+6Ry6pM1+hQQGW3Y0KG99HF+GRB7B97DRR0b4L?=
 =?us-ascii?Q?E6CUIFyJj07QFRm7motO6iAqUnrrRN9rz6QIBi/k4RQFtyIgswG5GeWIu/W+?=
 =?us-ascii?Q?ZrHkGLnv3YDvAEmb6cbhCk05rlbjKSSQmjcfhsmkYNnfNNq/+whIP8LePrur?=
 =?us-ascii?Q?xN1XJpiS40RXDWrPTY3DMd59NHXpHjUbHUSndoSSfUVfrw=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB10333
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	056e270d-5e5b-4cc4-0bc5-08dd0d7aeb14
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|376014|36860700013|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MBYtvZQG5gOB+BFLSsWegaoVtGs6XsUo12THsmK0Ve+/8hFK/ICFWbmPuQNu?=
 =?us-ascii?Q?AIAxl1youoxR9mWXL4CuJaqfP3YtUqymtXhCzoi+CXU5vRnG7Y8jRJpsLgGq?=
 =?us-ascii?Q?keO81GP3SeivPIWumvSYZXiTyU5LG6gXXiZkzmq9HPDdp1qFYEhhgkizpYm0?=
 =?us-ascii?Q?eKFYDXHOh9bQZZF+4matrOpedmhw95brV63qI8pYowbM5vsEkZoKtXqp3h+X?=
 =?us-ascii?Q?w2z/TZ7WBL6QZvFOKbFuMteGGFmPOyWBnsgsnfL5VYIxIeCanrs1vtmnyENs?=
 =?us-ascii?Q?06bJ9Pm6JlwysP3i/iYd5xamuy/2cbAbFkkFxVi0cJQ+Sm8y4fzJqQpAsPu+?=
 =?us-ascii?Q?7vi9aYpJ+JPx0Hq33VM1ArmeONxeLzHVRofjPV+IAqA/Phr+G1fIbRivmmUd?=
 =?us-ascii?Q?9GvOnXEoAo1FO+TsRIZ0N0eV25njM6W+BjVNxurjKHEEIJecxxkq1MSZyRUM?=
 =?us-ascii?Q?ajO7+AAknoHlW9OyAczrsfw7tz/cCovjgW6ODUaieduo/JJQXRLJwhcE9S5Q?=
 =?us-ascii?Q?s6LEpNf6wpoemHVRj78n3grDlTXkg5JzNizQDTw6hXWZ7hqKgIMmljjQTBzh?=
 =?us-ascii?Q?Hm1O5zsVRed23eGEkJqhl+wdXec3515mZJxmkOWqJLHnoLECkh8zM8s7tjf3?=
 =?us-ascii?Q?eXRh5BomEUdiV0LMZM1Af7+pBdEhOYF8/UZjIod9Hk0z8GU+7sTy9/mCTi/p?=
 =?us-ascii?Q?bMfNRwTethe+tEeHE2ZbtLFWNI31SZ5GpsRH7Xl3YB5xSOsH1rJ2oEwpccFw?=
 =?us-ascii?Q?U4W7Kgv8q8DFypf72a0lWD+L9tnBDfq5MsDecyTugI7I8JACMtFZGPaguTOT?=
 =?us-ascii?Q?wXehZnhy3IXBkk/iBxSi+4zFT3QYvEkyNLsgrwEvIZNWkdBuZfnqMbbybE18?=
 =?us-ascii?Q?Y5fEGCDDn6YTwX/G0qvjm7BZpkCu1PSplI9Lwi7V35BaYSiYg2gh2zzTZ+pv?=
 =?us-ascii?Q?00LjnKq9X48HQcDxm67Kt2Zk9YBVX+IRjhXjm7toDTlM7Tf4qBjnQWmst4bh?=
 =?us-ascii?Q?Ra7YpEY5HvcL99Teh8RV2fpXKjOIfjZg9s+LsUB/bWJdCx9ABvyZPs9WgRTI?=
 =?us-ascii?Q?amc+AFGGU15CBF86CJfSgm/zU2wTbKI7e40brndSkaS7a8IDqPRH7pQ6acl8?=
 =?us-ascii?Q?vnxU8uMLZqjxID/WQPAf7Fe4rNLAvvn44aM0h+EZKxEup0h3/Teqj1ahZX6k?=
 =?us-ascii?Q?n82RiB3xQ4Hs6IqP5iHBsZqo9+IIPG6h/V3Zoi/3aYAAxE7vWB/jYuaq2yRo?=
 =?us-ascii?Q?Jqa6RCRULhkk/JN6XeM4cMfH7RK0Drq7fQJMwmX8xrktPHwM+0VzYtrF3LXS?=
 =?us-ascii?Q?2hLkhmxXum6Q0o1pFqcQqFD7MMiud5OJgbNtP1i5MlBXcn51dOehqvCPqNSW?=
 =?us-ascii?Q?IqvhWasG5Lre7FmqJcyv5Djy/UttGEZFc2+dZxjhh6UNIaouPszEBoxZ+j9I?=
 =?us-ascii?Q?WY4zsGj4l9hsHX+Lfy3YFGgaDBe9MApv?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(376014)(36860700013)(35042699022)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 17:59:44.1403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3972a702-5c1f-4298-5d43-08dd0d7af14d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6697

Hi Ard.

>
> Calling panic() at this point does not achieve anything useful,
> though. Without ACPI tables or a DT, the only way to observe this
> panic message is by using earlycon= with an explicit MMIO address, and
> it might be better to limp on instead. Is there anything bad that
> might happen because of this, other than the user's wishes getting
> violated?

IMHO, the most weird thing is progressing boot with acpi table although
it failed to initailise. in this situation continuing to boot maybe
dead in unexepceted places. I think it would be better to prevent
futher progress by calling the panic() in this situation.


