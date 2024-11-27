Return-Path: <linux-efi+bounces-2222-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0579DAE8B
	for <lists+linux-efi@lfdr.de>; Wed, 27 Nov 2024 21:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC7F281AD3
	for <lists+linux-efi@lfdr.de>; Wed, 27 Nov 2024 20:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E9F1FBEBE;
	Wed, 27 Nov 2024 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S/J/DNp/"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A37A16132F;
	Wed, 27 Nov 2024 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732739753; cv=fail; b=LX5msFjAobxQeZtvbA84mvPVLDy2tYJRbUw4ZYjqc1Y9QB2q8FotWHwKC6xorsYLFqjqPvOtLXCQyEJ3IBKNLIqVtfvCkC5w5P4ET2adxio4vCAaRtmNN1fUcmpHdvhwjnfjcFGk/j42ckgNKGuT4uE+pwbfWNE3R1pkOApBUhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732739753; c=relaxed/simple;
	bh=uAFz0ZYQCSMJTvWyHtatfkImTqjg7gLTPZXwV1RDObc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=r6E4FKZnXXRHSY83fCmAdN5tlKz+m3PPTuoNSq/GOrpFF8d2dFjr+ZDmw6x+HNEPuINVpsmyoniST4z0TFNr2FAeua4pNzOuqslUs97B16k8/BQSJwB6zD+7TjKvWLixGz3n/pRhbeMvfnDBoGJ4qDM26qMEQqCBkwfcQ9hioaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S/J/DNp/; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dc6lyUmy1XVkY7eNzqQ1h0ZYtsj78WDLFiQtOr5ejhMPdrXOJIGF2ys0IOE6SDow+OKtQTDXh9i2oKx0SJSwVcyH+/TgVry77uKbYsoDgZYrP9OubjFMX11hHxFbgUaaARwkDy9i4PfV56i2/5qZYZ5ecs/gW/2sDAHlWN+idQ86+WYT8/6snCUvAKbQCVUDfvFTsLv5AFGjQGmtLvLom6JRVtSrR8W+064oPSySlIFpDagVcvXjsdsJvNm49UjxT6NUFrM8Ypjt9K+WMHpxR5a6Dt023EG6LrPEMIvz8xLhzxe9j1mFSpzBFBkR+D4AdsNNiRWlMGK1yfNyBYeTWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ywJS06fbWkqfDKP0ff0TMoNGGmjmBiq6wOOMD3ii48=;
 b=K102Uq+IgUf2QWiOp5OZSTTg/zYbCGgpTKpZvG54eO+Hxg57Q/FDQB9qUz+xsGd4JTmlYwkEtu9uub3YCdkUPktCd+Ta5LJuDVBk83q0ySn2fed1pugEOV4K8L3Fiw8LGhcqGXpzT1Dqv5cGmdP9H2OjdMe9WntT3cDns6n2JAdTqAWYergMwBiw8AeJnO8UzMUwCKQ34wAS5C0Nj8TLwjM6e1iIiS2L1P8VSHwoQ80HevuV8Ht0tOoM2vv7Fq1hSLwVKGDxUGmyKMcHlyxtJofBu/Q4DBNI3c6dZf7LMd4FJPjDZsecXppBIoMuFoBWQgo/ASXtOF5nsuOdDOj4CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ywJS06fbWkqfDKP0ff0TMoNGGmjmBiq6wOOMD3ii48=;
 b=S/J/DNp/+22rbpRzue4ULSlOV5IBqH41k/XhQgVXkBeIzrRXhZA1+OAZ6ciqRU5D1Rs5QsikPPDdsm9yReAwBD1+lyN/teXnsYPpRxDr49E+19Y9ukwnibHq41cH89xlzHwXgSohWd0GxjoLg9kCraNi8hMoAtq7Qqk5oIeprrk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 20:35:48 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%6]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 20:35:47 +0000
Subject: Re: [PATCH v3 7/7] acpi/ghes, cxl/pci: Process CXL CPER Protocol
 Errors
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>
References: <20241119003915.174386-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241119003915.174386-8-Smita.KoralahalliChannabasappa@amd.com>
 <20241126160527.00005c2d@huawei.com>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <ac098bd3-f7dd-ca57-8010-13e843d9f1d0@amd.com>
Date: Wed, 27 Nov 2024 12:35:44 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20241126160527.00005c2d@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0083.namprd05.prod.outlook.com
 (2603:10b6:a03:332::28) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: 58786404-532e-4044-f8cc-08dd0f231338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3V4SGN4UUw2bEViVUw5MDR3bE1oWjlyMDBkUXNiejNlcEpaZU1mcjdEVzVa?=
 =?utf-8?B?RmJQZ2ZJdU1ESzNUM2U3U1RKRjVrQWFFdld2djJ0NUw2M2JrazhIeHpSYVJl?=
 =?utf-8?B?NXl4V2dmRWNRaVl3VDVsSi9pcUhnSTBhcnBIa3I4Nk9ZLzdZdVBLbG1OeGNi?=
 =?utf-8?B?NzZoQjMxenNGd01iVFJzLzQxcitzdWFuaUx5Qk9CMFYwRDVtRCtLeTBBUUUv?=
 =?utf-8?B?cndNbUJvYXJiM1JUYktVV3VVbFhXQ1Jlem5pTnExMnUxUHRFdmF0SDhmbWd4?=
 =?utf-8?B?NnZzc2VWaGdwQUROQXc3VTVtc1AxNi9SZTVPQ1N6QjFkRlJ3UHlYZ0RjTEJ2?=
 =?utf-8?B?RVI3TnBaRE9UUW02OFJVNEFHZUZZUUgzWDhFMXVLWmVFbG4xdTM2NDdadHBW?=
 =?utf-8?B?cnpVTld2NzNiN0s1c0dZZXBZblh4VmNtZmdCTTRVV3VZSnc0T1poQzd3TXc0?=
 =?utf-8?B?d2x4OFJLZWQyWEJsVnBHQk9NVXcrK1lVcVNodjRmY200N3F0VHpBekthWkov?=
 =?utf-8?B?bkp2OXpBRUxHSEJ5VXJWMFZydUFFTUN6eVMyWjBBU1N5eTVSZzdEa1NrZ0NN?=
 =?utf-8?B?VUxCOGZtY2IvM1dQa0FieHRsNElydlJpOXYza3ZFNkloVE5KSGNTTzFveFps?=
 =?utf-8?B?RlBjN2IyanhleE96d3hJeXA1UEc4MU1TakN0RmtxSUJ1WEFLT0pCbDAxREda?=
 =?utf-8?B?TEgvUHFKWkxYaGd0NFp4a0h1SlYrZXRKZUxhWTIvTjg0S1lCUVdreDlxMXBC?=
 =?utf-8?B?Vlk0VHNBRkE5dWtUTCtXaGFZY3JkZjVzSXZOSC9PeXBEb0NWQnJRNjRCcXp6?=
 =?utf-8?B?MlU0QWJCTlRlWWV0azdDNDlTTGZ1aktzZkx1b2UyV3dJdXZjZDNtTUZmWXps?=
 =?utf-8?B?S2xnNGZOcW1Ob1poOWZwSnV1dzMzeU9nVzBLdXZkQ2haeUdhYk1KN25DekNS?=
 =?utf-8?B?cVR1emN4RTFEVnFPNXcrak5kRlhZTFNLRGlSMEZNSG9DOGZrc0dlL3hUS3E3?=
 =?utf-8?B?emhxVVE3aGo5YW1tS0dHSE9aUml0M3NseDZCeHNIRmRndWxLYmdJaHVMR1pr?=
 =?utf-8?B?S2JxeWpzTWVob0RXcHUvWVRnMTRaKy9WbVdVNzdmOWw5TGtKS1hkd21rYW1V?=
 =?utf-8?B?djE1VDN2UE16aDNjYW9XVG5PN3RndG10cTN1TGNwRFBRbG1CVlVxdTlhMWgx?=
 =?utf-8?B?V1ByZEw2UjBUcGYvS0EyYzRzZXJCV1RTVmtqWktyRmFuejJ0N20ySXdwblNx?=
 =?utf-8?B?NHB3TFRCbWNxOW1Vek0zRDNjZWM3d1VGblpkNlhVdGlQYjJITUZLRlNJUVVR?=
 =?utf-8?B?ZEp2T0dMeUhWWUFSd2x0UUN0R2VLNGxDWlIxcU9vbUZYS2w5VDJBaFAvR1pn?=
 =?utf-8?B?Qmlad21YZXRhUVJNSWc3dlljaWpyM2dxTTE3aDdScW43TFZmL1c3RU10V0hI?=
 =?utf-8?B?Ti9hSFB2RmVpdUR1TEZocDVwaVcySDNZcmtqRlVtWE9vK05KODR1ZGdSaXdv?=
 =?utf-8?B?SG5VYWlQY3hzWUZIak1Ndk9ROUswRFJRWC9US2VqckdmVmxaNEw4WW5sNWxa?=
 =?utf-8?B?bGwvYk1kb1l0QTBnRVgrWXBJOElWbWtyVmRORG03VVFoV2FEMHFtRXh6RDlT?=
 =?utf-8?B?UnRFUDgrMHJrSFVPbzlHS09CeU1BWEV1blk2THY3cDQweFhmV2FFYlhiOU9J?=
 =?utf-8?B?TUwrZlcxTnhCRDd4WFNJaGMrZDdPakhHNWRQcGVzbWNQQW5MOWt6bFhMdlJa?=
 =?utf-8?B?ZmVJT20wMEltcy9sYmNDb1ZlZy9IcW90S3NCdGRrK0dVeXNiNUUxKytXaWt2?=
 =?utf-8?B?RlFzMmhGQmZRVDFad2ZmZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVZlQTRQQm8xem8wazRCRldXSC9JdHRFUmlKRXRpYWlSNlNoOWpiam50OEF0?=
 =?utf-8?B?ZTdsMEVaWWFXd0IzTEZKNmlWMTRYb2RhUU9lTVYzVTBvMVhUTmFyUkhyZ1hr?=
 =?utf-8?B?Q1BKc2FiWXlyazZkbEEweXUwSURjQU5tREdsY0lnYkVweHI1azlVUnY5RGJP?=
 =?utf-8?B?NEhtaFdLd2RhWThBZkxoaGxaOUFJRlBhWDBtK2JVeG90aWlHRmllNTBWaUF0?=
 =?utf-8?B?RFlaZU1BUVJjMkJZTVppbldsL0FMVWYzanNJSWNQT1VIRkVkc2NFWUhoTURh?=
 =?utf-8?B?RmwrS1pmTlVxQXhINmo3V1loU2hUeE9TaHByOFRwZ08rYWs5eXZtSGMyaGVH?=
 =?utf-8?B?a0hib2RjMmRSWVJJV2hPZ2ZTUERpMktHSzJUSWR1TmI5dlpmSWx1NmYxdlVM?=
 =?utf-8?B?UkJ0MGV6dzJnZkFSSWRkenNRZ0YzbXB6SGVIT2poVTJ0QWpXMEdnTnBKaFFM?=
 =?utf-8?B?NUVqekJ2MHdKU2dna1RoZDUvQlJnTW41UEJWWmJlOTlYY3NYdk9KSDB0bGFE?=
 =?utf-8?B?S2Vua2o4S1NZY2VjQTI5cXVkSlBNanJJaS9SaGlUVEo0MG5IS0FnenhndzBM?=
 =?utf-8?B?dmV6U05SM0xucUxnVUI4eGcxSm4vRVBQb2FmQ2hDdytIamZFdDd3NHQzQ3VQ?=
 =?utf-8?B?bjB5aTRpV2pORnlxdS9EdnJXaFRiVTFLZUM4SXpMOWFVbFFMTk40bGMxcmxJ?=
 =?utf-8?B?Yk1IcDdBVVYxU2U0TzNIN2lHZEJicjJCZW5QblpXZWRjcDlOakNjTUhvSzJL?=
 =?utf-8?B?VGlYdjgxTDJ4Z0kwWGZDUVlyV1RLSHhjSmlIbmhNcU9jR1I5NCtDZi9ybXZK?=
 =?utf-8?B?bEx3NzJsWFRkdzhlc3lmUWZMWjBHSnJWS3hZcmZIY1NXQ0NPdWF3MHBOWlJH?=
 =?utf-8?B?Q2h0Q2hxbTBIZGFXa3BzaFA1V1hnUkVESG10VDhYVnloWGlIRHlKV3J5Mmwx?=
 =?utf-8?B?MktnalVVQ29XSklVNlZybVRmbnBNMlMva3k3eEUwcG50R3o5UXYzL04vRE5z?=
 =?utf-8?B?bWEwbkg2RVorcTMybjR0REJSYnkreTJXWlJkdVhQTk55SlY4aUtHaUFaT2k3?=
 =?utf-8?B?czY2cExRUDNPTUxKWGJsNkpjcGtmOTBLU09jdUJMVW81cXMxREVVaFVxbEhh?=
 =?utf-8?B?QysxdktuQ1lyVjRiN3E3SVA1TXo2Y2dSWXdSaWcwRlowdmczRWkvTGltY0dl?=
 =?utf-8?B?SzZrT0FtMDU1UkFucWVpRnhoTVNPemd5WFBQWlhmTDgwR1ZLUVdCS2VaK3Ay?=
 =?utf-8?B?MXdidW05SHdXTTdERVFmUWk0L1FoZEhHcGJBZUxWL3hZaWcwWWh4d21xRDlE?=
 =?utf-8?B?RVpLNXkwU2RCSFp1Sk1VVTFKRjFYL1lxMS9DNm16MHA0cUhFcFAzSVVxanVB?=
 =?utf-8?B?YXF0d1VkemlYZ0JoNTQ0azJQeERHYlpkR2xhZUZmV0NSME10RVpOUWU0YmJn?=
 =?utf-8?B?OEIwazlPaTRsU2hmZTF0Wm1xcCtsZUI2VEhSenhRSzRlWE1EaklUL3JKTWxQ?=
 =?utf-8?B?THVmTzBuZkJDQ0ZwVXB3L3pvNElJclQwUWlZRmwwY1pEUENZOHhUVTE2Z1Fk?=
 =?utf-8?B?dVdlb0IwR0NyUFRUeWw5TWRkbm8wQkZOQ2o2QWxDY1BJNk5JTGxualpQVmhB?=
 =?utf-8?B?MVI0dXZFY0wxT3lydHk5QmJuN2pQMHVxQk1ySkxZVncyams2dWVMYTlVSVBh?=
 =?utf-8?B?RjY0UlFsZE9lWWpkYVZnU2NBMGxxY0MrenZSR0swd2VCMEZyeWtrVTJQRjlW?=
 =?utf-8?B?bzVObHJvNVp1cE1WMDEzdlI5cFltTlhGdzBZNlNPZDdsWjArb2RpbDhRRUJN?=
 =?utf-8?B?Vy91TEIrUHlneWdiQUpZU2kwVXhMSzRSNzVHMHZ2WDV5MWVQQ0FUYWJoQnZa?=
 =?utf-8?B?UXhKWm9Pa1ZyUHpoOHNPWFNmT2VGb2M2RWJUNmlrSWR4alZIdExuaHpTOTl0?=
 =?utf-8?B?MFRLWXBCT09oTkFEYWVPdGwrTmRsRjBnSThOMGVGZVZ6TnRlRFg3dk5kZVJy?=
 =?utf-8?B?Zk9nQ25SeGRVN2lyNmQrWno4cG9oWTI2WkhsakxsMUdPZDZ6NUhHMzYzUldE?=
 =?utf-8?B?b2F0QVNLTzhxNG51bzMxcDNyUms1U2JleVplQ1JNT1MzWnFoanR1c2lwWW5a?=
 =?utf-8?Q?B9V3JbTaqtcfuBk7P8kXAgGM0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58786404-532e-4044-f8cc-08dd0f231338
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 20:35:47.8794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3pcg332OhIN3Xv/3qeG+DLo6APvfUMLp0x/73pB0jVCRGr2Ggu92/2R1ERmpNf2oeCX0AYKSODTDtPoTjBxPRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131

On 11/26/2024 8:05 AM, Jonathan Cameron wrote:
> On Tue, 19 Nov 2024 00:39:15 +0000
> Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:
> 
>> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
>> CPER records. Introduce support for handling and logging CXL Protocol
>> errors.
>>
>> The defined trace events cxl_aer_uncorrectable_error and
>> cxl_aer_correctable_error trace native CXL AER endpoint errors, while
>> cxl_cper_trace_corr_prot_err and cxl_cper_trace_uncorr_prot_err
>> trace native CXL AER port errors. Reuse both sets to trace FW-First
>> protocol errors.
>>
>> Since the CXL code is required to be called from process context and
>> GHES is in interrupt context, use workqueues for processing.
>>
>> Similar to CXL CPER event handling, use kfifo to handle errors as it
>> simplifies queue processing by providing lock free fifo operations.
>>
>> Add the ability for the CXL sub-system to register a workqueue to
>> process CXL CPER protocol errors.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> 
> A few minor comments inline.
> 
> Thanks
> 
> Jonathan
> 
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 4ede038a7148..c992b34c290b 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -650,6 +650,56 @@ void read_cdat_data(struct cxl_port *port)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>>   
>> +void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev, bool flag,
>> +				  struct cxl_ras_capability_regs ras_cap)
>> +{
>> +	struct cxl_dev_state *cxlds;
>> +	u32 status;
>> +
>> +	status = ras_cap.cor_status & ~ras_cap.cor_mask;
>> +
>> +	if (!flag) {
> 
> As below. Name of flag is not very helpful when reading the code.
> Perhaps we can rename?

Okay. May be flag -> is_device_error ?
> 
>> +		trace_cxl_port_aer_correctable_error(&pdev->dev, status);
>> +		return;
>> +	}
>> +
>> +	cxlds = pci_get_drvdata(pdev);
>> +	if (!cxlds)
>> +		return;
>> +
>> +	trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_corr_prot_err, CXL);
>> +
>> +void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev, bool flag,
>> +				    struct cxl_ras_capability_regs ras_cap)
>> +{
>> +	struct cxl_dev_state *cxlds;
>> +	u32 status, fe;
>> +
>> +	status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
>> +
>> +	if (hweight32(status) > 1)
>> +		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
>> +				   ras_cap.cap_control));
>> +	else
>> +		fe = status;
>> +
>> +	if (!flag) {
> 
> Why does  a bool named flag indicate it's a port error?

I will rename it.

Or may be use an enum to explicitly define the error type 
(CXL_ERROR_TYPE_DEVICE and CXL_ERROR_TYPE_PORT).

Or may be split the function into two distinct ones, one for port errors 
and one for device errors.

Let me know your preference or any other suggestions here. I will change 
it accordingly.

> 
>> +		trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe,
>> +						       ras_cap.header_log);
>> +		return;
>> +	}
>> +
>> +	cxlds = pci_get_drvdata(pdev);
>> +	if (!cxlds)
>> +		return;
>> +
>> +	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
>> +					  ras_cap.header_log);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_uncorr_prot_err, CXL);
>> +
>>   static void __cxl_handle_cor_ras(struct device *dev,
>>   				 void __iomem *ras_base)
>>   {
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 4da07727ab9c..5e4aa8681937 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -129,4 +129,10 @@ void read_cdat_data(struct cxl_port *port);
>>   void cxl_cor_error_detected(struct pci_dev *pdev);
>>   pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>   				    pci_channel_state_t state);
>> +
>> +struct cxl_ras_capability_regs;
>> +void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev, bool flag,
>> +				  struct cxl_ras_capability_regs ras_cap);
>> +void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev, bool flag,
>> +				    struct cxl_ras_capability_regs ras_cap);
>>   #endif /* __CXL_PCI_H__ */
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 88a14d7baa65..e261abe60e90 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -1067,6 +1067,53 @@ static void cxl_cper_work_fn(struct work_struct *work)
>>   }
>>   static DECLARE_WORK(cxl_cper_work, cxl_cper_work_fn);
>>   
>> +static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>> +{
>> +	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
>> +				       data->prot_err.agent_addr.function);
>> +	struct pci_dev *pdev __free(pci_dev_put) =
>> +		pci_get_domain_bus_and_slot(
>> +			data->prot_err.agent_addr.segment,
>> +			data->prot_err.agent_addr.bus,
>> +			devfn
>> +		);
> 		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
> 					    data->prot_err.agent_addr.bus,
> 					    devfn);

Noted.

> 
>> +	int port_type;
>> +
>> +	if (!pdev)
>> +		return;
>> +
>> +	guard(device)(&pdev->dev);
>> +	if (pdev->driver != &cxl_pci_driver)
>> +		return;
>> +
>> +	port_type = pci_pcie_type(pdev);
>> +	if (port_type == PCI_EXP_TYPE_ROOT_PORT ||
>> +	    port_type == PCI_EXP_TYPE_DOWNSTREAM ||
>> +	    port_type == PCI_EXP_TYPE_UPSTREAM) {
>> +		if (data->severity == AER_CORRECTABLE)
>> +			cxl_cper_trace_corr_prot_err(pdev, false, data->ras_cap);
>> +		else
>> +			cxl_cper_trace_uncorr_prot_err(pdev, false, data->ras_cap);
>> +
>> +		return;
>> +	}
>> +
>> +	if (data->severity == AER_CORRECTABLE)
>> +		cxl_cper_trace_corr_prot_err(pdev, true, data->ras_cap);
>> +	else
>> +		cxl_cper_trace_uncorr_prot_err(pdev, true, data->ras_cap);
>> +
>> +}
> 
>>   static int __init cxl_pci_driver_init(void)
>>   {
>>   	int rc;
>> @@ -1079,13 +1126,21 @@ static int __init cxl_pci_driver_init(void)
>>   	if (rc)
>>   		pci_unregister_driver(&cxl_pci_driver);
>>   
>> +	rc = cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
>> +	if (rc) {
>> +		cxl_cper_unregister_event_work(&cxl_cper_work);
>> +		pci_unregister_driver(&cxl_pci_driver);
> I'd switch this to a goto style for error handling.
> 
> 
>> +	}
>> +
>>   	return rc;
> 
> that is
> 	return 0;
> 
> err_unregister_event_work:
> 	cxl_cper_unregister_event_work(&cxl_cper_work);
> err_unreg:
> 	pci_unregister_driver(&cxl_pci_driver);
> 	return rc;
>>   }

Noted.

Thanks
Smita
> 

