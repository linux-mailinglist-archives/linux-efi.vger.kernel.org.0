Return-Path: <linux-efi+bounces-1951-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE4C99B6C6
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 21:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93165B21D65
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 19:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F2F1448DC;
	Sat, 12 Oct 2024 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LY4QK2R5"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C88364A9;
	Sat, 12 Oct 2024 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728761904; cv=fail; b=Z2dayWUcbIokKT5tI/+6DGb32Yo9a8m6rK0OSuibPTT6/N8byBG0dNwNeuONMGbK14vysFR/b3+mXhodAGGK9brUPjvMxkcVdIb8MxkfoYeSSwwBWw9qJ38j3bBJlrszgwpHLqLqdy/fNNxMDqmrYXFVv+bbOF6uvKbevvHcsYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728761904; c=relaxed/simple;
	bh=Hlh69dcZoJU4vihHKmnISvItCLLdZj0CMhl1l9r7uKc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SzjThrwQKTx7ZYlIh4XyausFslvlGAhY5fe7ovp2owTmxO1U7H18o6TuF+/fhsNqzxV/LCPPVVRiK9kwtz0gudDh/1Eu5qL/xCbWaFKMVuh61cam01gy2lyX/wJIq+jmzp4+fh1u5UWB0hbxwqx2OOULfdE6Y/BizWzJof081j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LY4QK2R5; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MA61fY0ed63/UC2Iu++wHRrdaVhKC0/5uDcJlAQbN7bKKvCoUlTP+Sl6bODXTfpJOIyBNoVw6xEdu5Rt9wm59eI7q9q7qGi9T3Pc6UY3UuHnvIcw9vOQwrbe7fHyMsp2kJze46gfmnEDAgC4WKDZqc8a7+hUy0XTPwytkiM/6DcHMtSHQ+rKqBMZ2Di4cYsUuLPUXphuZLIx3AjwZIS2MRl20O+MsuUhBV2vVECx9CI/QNPane8l0dIhATRkuezyQ1MYYSuQDOw8OIBhxLjp8UsWoitOaElumqWiteHRksyJMgl0FTzvY6PE2ezEcPJRrpRDS+XxMJ+CW/GRR+99DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIcaGLRrh35QQEtrQtUFJFRU2L+beLlISA0fov5cgJ4=;
 b=ES/bkl6qXbQFFCQZDfL1J2X1D7rjfQQjBErCYOrrZIbyfZByrO6B5lys1SDKa7Yp21qHdxSq1hXLDKQLY0iK+fmoA9hId4NVKeBepEXoumQXOooF8gdzLfE9GYviBWA+xrzcRSXy76bTD5bAOpWdHoOf49oBr1NcE2YOdMhIA/BfMxnaakvPYQ96Vwwq++JFXAm2Ki1k5eC+y3KKcvHvZjIrw3UVKE4yiWlkrkTdFOzrZVHu9ZQ29jOUuYMeruxX/eLXCeBgYTYwxvHrnYTDvdir8yX2DLepCww4/LL2o/75x0Af86zplNo4j6J1Lj9QMPeou1nbncufTrJUx8fQPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIcaGLRrh35QQEtrQtUFJFRU2L+beLlISA0fov5cgJ4=;
 b=LY4QK2R5mpGVmzvBo4zaUPGixYlaayV5SMgL5CKwks00gtN0QjDgldb4ElEclgDVprD5I0Jgck6NICu019P0JPS96sN57/5KcKrPsEFrMdmrXQbWB8rAxwsUwJ9oJAhXmy6KLvqx/oGTuebJzcnjGq4NHfd6KKGqae5rMHpdBQjnL9Nn9UIBZAHbOSdF/rIdZy4Y2WBhXkJ53ZU59ni7A1K5ggY/URXEHe188IADJ52Yw1NMhS1EeaHMIw7WZbqHNmaCTrWJIo/Iwhr3BaJpD66RJii2DZ4spmYf38M44Niq+QUdwJxVpiKizKYqvPtTOUzuRgNffy9fyz0R03a4Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14)
 by DM3PR12MB9435.namprd12.prod.outlook.com (2603:10b6:0:40::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.21; Sat, 12 Oct 2024 19:38:16 +0000
Received: from IA0PR12MB7579.namprd12.prod.outlook.com
 ([fe80::da98:f83b:ca75:64d5]) by IA0PR12MB7579.namprd12.prod.outlook.com
 ([fe80::da98:f83b:ca75:64d5%7]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 19:38:16 +0000
Message-ID: <21b2162d-bb6c-4aa9-b747-d9bb2e6d6402@nvidia.com>
Date: Sun, 13 Oct 2024 03:38:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8] acpi/prmt: find block with specific type
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Matt Ochs <mochs@nvidia.com>, James Morse <james.morse@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>, linux-efi@vger.kernel.org
References: <20241012191612.3586797-1-kobak@nvidia.com>
 <CAMj1kXE2D56oYP4mPzBxCzjiUH34HfhnWeBcbzL_gYWdvy0j7g@mail.gmail.com>
Content-Language: en-US
From: Koba Ko <kobak@nvidia.com>
In-Reply-To: <CAMj1kXE2D56oYP4mPzBxCzjiUH34HfhnWeBcbzL_gYWdvy0j7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0119.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::34) To IA0PR12MB7579.namprd12.prod.outlook.com
 (2603:10b6:208:43c::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7579:EE_|DM3PR12MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a48fd19-c58d-4866-5cae-08dceaf56ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vml0MlNJS1BLU2YzTXA3S3pGTlFoZGcxNWtLSnU1VmZGUStJVlNlbHk0NzVS?=
 =?utf-8?B?V1ZLU09ITitMWkVyODN0Z1E5WjVUMEhqL1VPOGR4UHdIZzA4S0UwT2hiTXRs?=
 =?utf-8?B?UTVycndPbm5va2JRbEJrVWgyWWt1bEhWakJHWitaaFBIRzhSdXJXZW9nT0pk?=
 =?utf-8?B?R2dVdWFrakg3UVVCaVhLTWdRY1NJdG8wQXpwWUU0ZXJXMnBQOVUvbC9ZUU1S?=
 =?utf-8?B?ZGJFVFhsbGI5SThnaDdjVVpsTXpTNW1jc2k1ZjZuQ2dOYklFaWRVcmpRaU5K?=
 =?utf-8?B?VWJQTDBySnVOcVhDM1puK0dBWW5ybzRWRHdyTm1GZ0w5ZzFKUHFtb1FUMy9V?=
 =?utf-8?B?RVRYdXdJVk5mQXU1Y3Q2V0R1cnVNNHhuWXljVnZtTVFONGcvcFIvaitNTlVD?=
 =?utf-8?B?ajFWZGsvWDJBelhheWZVT0NxSFk4U2NaVlBBZFlTT1lqZEpJSU05MHgyN3Vl?=
 =?utf-8?B?NzVyNnZ3WWtROExkUUlsMWs5bW1RT2FLMGdPRHNUL1ltT3liUlhRcEo2NXBs?=
 =?utf-8?B?TitCcnRoYWEyMVF4Y0ttWkpUL1Y4RjFxQWFjZGhkbTRNR3E0WjJyRWtwWGlr?=
 =?utf-8?B?VkI2YTA3WkkyK2hkSDJCUWp4YVpWbGxKMzlmc2xPWFVyYWpaeUVTcVpHTU1p?=
 =?utf-8?B?SldVc2RoZkVGNkNwMTRVOU9MMjZ6YXpQM3lHSGNOZzhER0pzaUdzd1BkUDVI?=
 =?utf-8?B?Mk9hdmZMK0d4dTE0Q1E5eXoyaHFLeUNVK1pyZmpYYTFnUjJmdnY0N2IvTDRN?=
 =?utf-8?B?L1hwRUkyck4wTzFkTWt0Y25WamlJbjhvTFhxUDNGNWFObHhQY3ROQlZZbCt5?=
 =?utf-8?B?N25yY3RzZE5kT2d6SGkwN2lNeklyaXFUK1pNNys5TlBsRVZITjRyUXZna3NO?=
 =?utf-8?B?Y2xNMXQycUtVajFHSHA5L0Z1Y3cxRkNkZFlKVmhxaTFpZ2JVeGREY25YNWJ1?=
 =?utf-8?B?cng0ZTU1RzFJaC9lU0k4ckFzMzduaU1iZmdVeU4xUEZycDJRVjhnT0tFTzFD?=
 =?utf-8?B?MytqbUdSaEd3cE9YMVBqclZGTTlTRHhkbTJhdW45eUlBVWxtbjhUNkMxdnhR?=
 =?utf-8?B?b3NwNzBYa2F2dnQwU09tQzhZQ1dlQ3FsQ0E5UjIzR0o3amh2dlBLMnZsS2xB?=
 =?utf-8?B?YjJYemJkVjR1U3ZGZ3BJLy8yUTFrdS9ienVDcDQxblgrWFU4V09GTDY1Vm5k?=
 =?utf-8?B?b21oNDFJbDhzQVM1Z2lkRC8yZXhZa21OeUFmWjExc0ZvZnpXR2NWbUpsRFMy?=
 =?utf-8?B?SDd6YmxNMkwyZC9jTTRqcytXYTlWS3VnZVE3VGZMTmhzS0tMeVNmUXd2VUZ2?=
 =?utf-8?B?NVI1Q0ozVE4waTJwV3gwdU5sSURHdFY5elROOTlVRE90V2tTL21yclZFdm1B?=
 =?utf-8?B?MkhpcUl1SlVUU0ZpSThhcHI0TzFqYkVtRWJPOHd4Umgvc2NyWjRmTElwMjVo?=
 =?utf-8?B?VjNzd2s3VkxZM2VpRnlyU1VYUzhGZWRpYXd1cE9pQ3c2RHhLR2NmRXVwdjN6?=
 =?utf-8?B?K1RWNkI4R0N1aDJWa21sSitZM2l6blZEUHQ1alpiYmtad1E5RVFRK3kxekpv?=
 =?utf-8?B?UGdMOUdDRDBFZm9mY2xpZXNuL0pCcGplOXNrdzc4S1ZYb0J4SEFjZ3JNSTBH?=
 =?utf-8?B?Q3loWHpVWXBUZGpsS3NvOFJ6V2F4UjQyOUdyWkZOMk82WkxtYldsUzEwOGpo?=
 =?utf-8?B?WElpV0JVWFYrMGNSUWcxQUtnbjFPTVZncnBVSkxXRHpXYzZNV3NNMVN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7579.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmsyR2tuWHBHNldkSVEzMFJLblkwVENQazdhbGRXeFZUSERNY25HclBMWWJ4?=
 =?utf-8?B?WGFRZmRZTkxoRE5rS1FqUXZxdDFKTi9oYkRSUDAxNGg4YXVVZmpKNGdJRy8r?=
 =?utf-8?B?ais2NUp3V1poTG4rN0lKZWJwU3hnZ2Vjc1A2ckpuQkdteU1hQk9FNVBHVmUx?=
 =?utf-8?B?d1dtSHp3NU9mVVZCZ3BXREpDQTkvTmw5MWwwNjlHemt0VTQyM1V1bVZ1aDk0?=
 =?utf-8?B?cC84OVo2V0NMb2taQWJHR2VoTlFBU0RLelNXQ1NnbmdwVzdwT3dubjJIb1RY?=
 =?utf-8?B?Uyt5cmRKR2JjQnNrWkRBN1phVWFYeGxFRVJGd0NoU3BnekcyQ281UlB6SWZK?=
 =?utf-8?B?elM3V1FHdXZJdk84ckRqcW5PMkJkTWY5Mjd6TGZ2c1JydDd0bzVGZGFYNk5w?=
 =?utf-8?B?QmNaYVRRV1g4aWwzbmxqdUJ4V2F0alptNm5oZE1sdzFVSWVLRSt4K0hNOE9O?=
 =?utf-8?B?MW1hU0dFaC9BUVRpOUNFOTdCWTN0a2FXSmJsNU1FSjczZ1Y3NUZtbUZpUHFM?=
 =?utf-8?B?SWd5TUpjWUNXaDA1dldQV291WEdqUnRETjJ0TWluaFVKZmYrdE1jNlgyNmc2?=
 =?utf-8?B?NWFXVjlDb2R2T0NPc0lZSnBQbkg1Yjl1R2tTaUVtVVpRSjg5ZDV1K013akF4?=
 =?utf-8?B?QUM1eElEQ29KVDlHYWhGQ3BHck5nWmpGRHdtWVBlUVMvVzhkUW9qOUZWa1cy?=
 =?utf-8?B?NlBjN1lNRVZmT29pVjdzTWh6UkhORkRHUkt4cWd0MjhrQ1ZLeWl3S29WVzZI?=
 =?utf-8?B?MUd2TkZYaDcwaHNLRWtzQXUwY0wxRm5ISkpvNDU3T1lXUnRnaGtldkI3aW9m?=
 =?utf-8?B?V2dnT2tPa2pjcS9QM1cxdFFwS1pYaFluREJ1OXhhSm92Z1h3WDloK2RWeDVh?=
 =?utf-8?B?OEVJZDJRNWpIa3drc29Vd0hMNzZUWEEzSlNvejQrYm83TEhENHJzaTJYR1I0?=
 =?utf-8?B?STFKL2xlOUNoazYwV0VuaTVBQ0dUOUM4bVRYUXRkMytVVkoyRzZFYy85bDYy?=
 =?utf-8?B?WWVqRFF3MWtsdUIyV1JFVWZFUk1zdVc0Q2hUWEtWNlBWOVcyTjJ6NmNHWTlS?=
 =?utf-8?B?S3poWS9KQ1N1L3RFYmhLaS9tbEhqRm1DV245bkdqRFBtc3NIVE5pMVkxY2Zq?=
 =?utf-8?B?TjczRmxwbFd1VG56enY5alBlT1JWc29rZHN4Q3VVbmhMQ0k4d0J1YjVzNnBm?=
 =?utf-8?B?TmxLd2tTRzdEQXRtUzhkYjAwQ2cvdnU1MjdSL2gxRHZPOCtReVc4cmxwek5W?=
 =?utf-8?B?QWpkTnd1MDVsbXJqSjhXbmNGZEdqQ2sybGpuc0tldGRpbE9iYmZmaHo3cWZn?=
 =?utf-8?B?ZktHQWpKdTcxbFdXeDZvYlFid1B6dEpoVWZ1THZ1dHZ1N2I2azRlTndOcjA1?=
 =?utf-8?B?cFRoMC9GUFhnMEJIRW9IaVRIZEppOGplRXFnYk1XT3hSZ2c2MFVsVVpiSFJJ?=
 =?utf-8?B?RG15dDMwTkVVMk1JU1JNRnUwSnRCNGIwakxKKzIwMUlEZ1pENjJEeDFNanNr?=
 =?utf-8?B?UTcvRS95eHovSXhBMDNLV0Z0cVBMYXhpb3BGNFl0RXVKYnhqL1JKNlNWSERU?=
 =?utf-8?B?NWJWV2hZWXR3UFROZG4wMmNrMGNqWW1yT1o2YWM2TTlIM014bTJtVGgvbWZE?=
 =?utf-8?B?ME5JVmNKWXFiVFZFUURLSXYxV2dkTld0WTQ0c0toNnBVV04xcVVxZFEzQTZ0?=
 =?utf-8?B?V3dnelhtNWxrL2tmd1dDbm5yV283SGhYa2h0WkRDNzFVMnM2NmFCMEZaNmNr?=
 =?utf-8?B?R0JzTEZEb1RPQ1Y4WXYydndRYUpySFRnMW9DME9HVkdka0sxYTcyb0pZNjVY?=
 =?utf-8?B?ZEcyYmJVN2FtY2Irc0svYkxEaFJkcllKci8zQ3c5S1ZOanFUazN1T0dnODdD?=
 =?utf-8?B?NTcyK3NneU5kWFcxanhTUnF2cUszcDNoZUpLVWFQVW54S3pmUGdQMk1IdzJV?=
 =?utf-8?B?Tmw4THpoWFNaeHc5b3V3N1dVcWhrREtOcm5HNmQxVDVrbzkzdXdzN0EvNzg2?=
 =?utf-8?B?UHFFSDFDakFOV1VWRVpzSW9QV0tQVlJ4T3BSdGc1OGV4VDVzbnhrMnVTcW1h?=
 =?utf-8?B?UUc1QXdMRFQ0eVpwT3RuSkErRTJLaEFKWVJMRCtoZmNsd2YzVzBTRVlHd0tD?=
 =?utf-8?Q?LVlZ542TzHdl+bkXwKTqeaY5c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a48fd19-c58d-4866-5cae-08dceaf56ae2
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7579.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 19:38:16.2246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6onUqMzxBP8Np1EONbgaW90xJpxE5XpcpMyGK0auBG3DWqip3qVETnvTW0GIOlr9ozSvbIhEqe9v/fkwD2Ejbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9435


On 10/13/24 03:36, Ard Biesheuvel wrote:
> External email: Use caution opening links or attachments
>
>
> On Sat, 12 Oct 2024 at 21:16, KobaK <kobak@nvidia.com> wrote:
>> From: Koba Ko <kobak@nvidia.com>
>>
>> PRMT needs to find the correct type of block to
>> translate the PA-VA mapping for EFI runtime services.
>>
>> The issue arises because the PRMT is finding a block of
>> type EFI_CONVENTIONAL_MEMORY, which is not appropriate for
>> runtime services as described in Section 2.2.2 (Runtime
>> Services) of the UEFI Specification [1]. Since the PRM handler is
>> a type of runtime service, this causes an exception
>> when the PRM handler is called.
>>
>>      [Firmware Bug]: Unable to handle paging request in EFI runtime service
>>      WARNING: CPU: 22 PID: 4330 at drivers/firmware/efi/runtime-wrappers.c:341
>>          __efi_queue_work+0x11c/0x170
>>      Call trace:
>>
>> Find a block with specific type to fix this.
>> PRMT find a block with EFI_MEMORY_RUNTIME for PRM handler and PRM context.
>> If no suitable block is found, a warning message will be prompted
>> but the procedure continues to manage the next PRM handler.
>> However, if the PRM handler is actually called without proper allocation,
>> it would result in a failure during error handling.
>>
>> By using the correct memory types for runtime services,
>> ensure that the PRM handler and the context are
>> properly mapped in the virtual address space during runtime,
>> preventing the paging request error.
>>
>> The issue is really that only memory that has been remapped for
>> runtime by the firmware can be used by the PRM handler, and so the
>> region needs to have the EFI_MEMORY_RUNTIME attribute.
>>
>> [1] https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
>> Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion handler for the PlatformRtMechanism subtype")
>> cc: stable@vger.kernel.org
>> Signed-off-by: Koba Ko <kobak@nvidia.com>
>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
>> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
>> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>> V2:
>> 1. format the changelog and add more about error handling.
>> 2. replace goto
>> V3: Warn if parts of handler are missed during va-pa translating.
>> V4: Fix the 0day
>> V5: Fix typo and pr_warn warning
>> V6: use EFI_MOMOERY_RUNTIME to find block and split goto refactor as a single
>> patch
>> V7:
>> 1. refine the codes and commit description as per comments
>> 2. drop goto refacotr
>> V8: Fix 0day and cc to stable
> 'fix 0day' means nothing - please describe what the actual change is
> compared to the previous version.
Thanks, will do it in v9
>> ---
>>   drivers/acpi/prmt.c | 27 ++++++++++++++++++++++-----
>>   1 file changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
>> index 1cfaa5957ac4..552442bc10fd 100644
>> --- a/drivers/acpi/prmt.c
>> +++ b/drivers/acpi/prmt.c
>> @@ -72,17 +72,21 @@ struct prm_module_info {
>>          struct prm_handler_info handlers[] __counted_by(handler_count);
>>   };
>>
>> -static u64 efi_pa_va_lookup(u64 pa)
>> +static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
>>   {
>>          efi_memory_desc_t *md;
>>          u64 pa_offset = pa & ~PAGE_MASK;
>>          u64 page = pa & PAGE_MASK;
>>
>>          for_each_efi_memory_desc(md) {
>> -               if (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)
>> +               if ((md->attribute & EFI_MEMORY_RUNTIME) &&
>> +                   (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)) {
>>                          return pa_offset + md->virt_addr + page - md->phys_addr;
>> +               }
>>          }
>>
>> +       pr_warn("Failed to find VA for GUID: %pUL, PA: %p", guid, (void *)pa);
>> +
> 'pa' is not a pointer so don't treat it as one - please drop the cast,
> and use 0x%llx as the format specifier.

