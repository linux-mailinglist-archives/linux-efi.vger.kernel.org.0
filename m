Return-Path: <linux-efi+bounces-6127-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJKFHe06j2nHNAEAu9opvQ
	(envelope-from <linux-efi+bounces-6127-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 15:53:33 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B9533137472
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 15:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40E4430405E3
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 14:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4F43612E6;
	Fri, 13 Feb 2026 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=edgeless.systems header.i=@edgeless.systems header.b="DUXUognN"
X-Original-To: linux-efi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020075.outbound.protection.outlook.com [52.101.69.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21D1361DB0;
	Fri, 13 Feb 2026 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770994342; cv=fail; b=lmOdwdqwTe+83kNqOms6YREPiREy1KcPJeWcy2jWpAzNKF8CnfEqwTxMYea+9w46qyuG/bT0ZF4QHnK3qyc23gJdEaIX268OyGbdeqXobYQSGxqgzpM4Ob/4LRXXO5Okx4QAYlPtPU/s+QbQX8eLeHVAmfu5FG//97teIlnZJY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770994342; c=relaxed/simple;
	bh=lEu1gQA2zD8vRgouY/j6Ux6SK6vmZfvATG1gC/+KL2k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lZXrJa2yWztUYAHVd+bpMlgW9WI8j7QPo7G2z9T5Oujmz+Plq1F4FKvPqiiU0NDiLGVfKRqwHXk0LwN4bRYEOxhVrKPADhSGj4jjx4QuN7zGBcsZu64u2OvFSjQTWUaRK96mEPQ6yLAZHnxLeWyEXG3oLjq4s9PCKCPfkMEQdqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=edgeless.systems; spf=pass smtp.mailfrom=edgeless.systems; dkim=pass (1024-bit key) header.d=edgeless.systems header.i=@edgeless.systems header.b=DUXUognN; arc=fail smtp.client-ip=52.101.69.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=edgeless.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edgeless.systems
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aU0Dq3+ssVdlVjA7XWCU21uyq3QMIbx9trtrurAhIJ1sw1azyOcbYaDy+hR0Jl9IcaEMVFJ9nZCNhm05s5XV2Z+XwVwJx4VUIxGb1Uh41WYLYGC66zl6dgXHCvW3cjPyVDTqNwHhfDNn7365MmlSDVOfn/dcb13opDIyUTjrhv5G5h+Ltr8Ln3yPKc8IkevObzeS41rjjLZ8sTThERj9eFwGTVQ3GdYfXsJoSi1JejcnOWTUekUbhYOhIK96jyLELBNzPHCXpx7m5YAWjfj10dE+oTTrfTGl4eO2CGk4K0y82qMVJbr6a/h0CmY+SddKYcd2gkaTxcWCPVP0DBd15g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4UNUqWE3Z2LrVrky8Ftinwh5IkAqxFkK83jWABB8yQ=;
 b=E77GTVy0x2Pvk9jc2v0qy76jiXL/eVLn6FZ0Hj6jdFz1EwaqnxRynOiDt0V6SvClb6uPfs1L6smPyacCD3vmKBCmB/zu+aKXFK66gk0vTRSqwMiONJwKk2CxWI+OyzpVo7CiO3M0TUPKEhiEVYeOkWQyf7QXrvIpX9ttnm7ps1DaWkUzYBwoc7HNbSb4slT4ZcDVGahZeYe4F5/9b/aS34Pp7DcJXnu7y+qbbsX6rzL8vd0RGL5wfRg2+U2h++XWn5vsBBOl+iAcL/uguKKdGf0850afAuFJRujD7WyTPn63bKvODppQmBp9jFxpUPohd7gcGPFqRWqRx9I2lvclWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=edgeless.systems; dmarc=pass action=none
 header.from=edgeless.systems; dkim=pass header.d=edgeless.systems; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=edgeless.systems;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4UNUqWE3Z2LrVrky8Ftinwh5IkAqxFkK83jWABB8yQ=;
 b=DUXUognNCPcqRUsrQYNqwOASj7zeu+62QNqbTovYuE7gzwLuwfcsqRwyhNP9E5pyP11DUvJbruwES9rkhd9/0DxuHDKinXNogHbHguZrCcmy6UTyalPB24tw2DVCzMN2bDirIN0FQOM/UBezesj82gxV2Z+qEQewC+6wwqhAwuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=edgeless.systems;
Received: from AS8PR02MB9459.eurprd02.prod.outlook.com (2603:10a6:20b:5a3::12)
 by VI2PR02MB11045.eurprd02.prod.outlook.com (2603:10a6:800:277::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 14:52:16 +0000
Received: from AS8PR02MB9459.eurprd02.prod.outlook.com
 ([fe80::815f:fa6d:197c:2470]) by AS8PR02MB9459.eurprd02.prod.outlook.com
 ([fe80::815f:fa6d:197c:2470%6]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 14:52:11 +0000
Message-ID: <bca9631a-b41d-417b-9be5-8c8989728ea3@edgeless.systems>
Date: Fri, 13 Feb 2026 15:52:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Fault during memory acceptance for TDX VMs with certain
 memory sizes
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, ardb@kernel.org,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Weiny, Ira" <ira.weiny@intel.com>, "Wunner, Lukas"
 <lukas.wunner@intel.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <c2632da9-745d-46d8-901a-604008a14ac4@edgeless.systems>
 <b6f00f31-ab39-4a76-b758-b3cfb1b0dfbe@intel.com>
 <cf37b7df-1265-411c-8aac-f82c3732fde9@edgeless.systems>
 <aY8Quu2WJG5HB3PP@thinkstation>
 <5a0fa6d2-f138-4360-bf02-5478eda4b495@edgeless.systems>
 <aY8y6uCyejTXTejt@thinkstation>
Content-Language: en-US
From: Moritz Sanft <ms@edgeless.systems>
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=1
X-Identity-Key: id2
Fcc: imap://ms%40edgeless.systems@outlook.office365.com/Sent
In-Reply-To: <aY8y6uCyejTXTejt@thinkstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZRAP278CA0001.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::11) To AS8PR02MB9459.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a3::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9459:EE_|VI2PR02MB11045:EE_
X-MS-Office365-Filtering-Correlation-Id: 67de1ba1-ae8e-45f9-0390-08de6b0f77d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emQvK3N1RFVLZ1NCZmZiKy95WHA2M1lHTjA3Y0hseGZDQmZIUUJrNDNocFoz?=
 =?utf-8?B?VnByelFuTURtekh6TWQ4Tm9HOE4vcHQ4SnVUUXVpM25jTGUvdXR1cXlUNFRh?=
 =?utf-8?B?d0xaMjJHV2JZem9BTTVrM2JQTFROblI5cXJjNGQxN2tHeGxJVFdYd2xqeVRR?=
 =?utf-8?B?UjVqR0x1NUZWV2RHYVY5eFRkREpNQ1RucFZUTW5yUjA5Tk05RGFUOUZQRytQ?=
 =?utf-8?B?OGU0cFBLVXR4OUFtYWRYbk5vRWRPNWg5MnpIUUZWaWlsdEdncStjVVQvUHdn?=
 =?utf-8?B?NHVSalAxamJVMmo2eDI1U3E3RkIzc0J3TnNyVnZuU3MvZEFjZ3YyUG1ZREJG?=
 =?utf-8?B?YVBxNVdFL2d4UlRJaEgzQWMzeUpueXh0R1hERGo5SFFKRkFlKzBiZTJmZmFF?=
 =?utf-8?B?RmtFSkh1YkUwS0Evb2pQa080Mm13cjFkak94bFlKTTBrUzdEREFEUzFKSmdn?=
 =?utf-8?B?cHhSeWdVUzFrZDF0NlRRMkJBU1cydWxQY0JZOE5LODVqUUlhTkhYUFJEd3dK?=
 =?utf-8?B?U2NvbmM0SjRpNVZKM1A5ejJNV2UwRXN3ZXZ1NjFXRUt1T2p5ZW5mUC9LRXVw?=
 =?utf-8?B?MVZFRys2QS9MUUNKRVpNOGZYeFNFbGlUOEhLU0VNUjJhN3pvRExjeVc3M1cr?=
 =?utf-8?B?TnQ2WTgrWlJ5MkRrcVdzc2xLR1BIOU40MFcxSm1RalpRS2UwMDJhWFlRM1Fx?=
 =?utf-8?B?SWExanpISC9mWTZHTVM2MWJEUmxFYlROaHZWcTByNmFlZ294T2VuUVhyZ1RU?=
 =?utf-8?B?eHlQZnlQTWdEaURQUUJOREVhWFlwV1NGRzlNQUlZd09UbERXeFFWZGlSTnhQ?=
 =?utf-8?B?UGRnZWxvMTJvTnhlY2w1S2t2M2pGQ2hNd0FNWXhvRzBLbFMxQ1BVVGpXL0Zq?=
 =?utf-8?B?ekhGTUVIT3I4NEFNNDRmSGxLbUQ4MkJyUkVTTmx3S0N6VUovVVpMOXZ2QXln?=
 =?utf-8?B?d3JWNWIvNjA4YnZRbUhVU1B5RkVhblFTVW9SaTU3QVY0c09LdnJEazRjVyt0?=
 =?utf-8?B?MUVwdS9XSnZCaldlajdhSVhFRHVLWVFuT0pQa0hEeHcwTU9jR0hRT2FPYzdI?=
 =?utf-8?B?M25HeHBGRW8vZTZuTlpnWVA4cVdOV1FyMTZFUVpPNVJ6SjE1Q2JneG40Wmlm?=
 =?utf-8?B?RHdVaHhpanYxUGM5czkwYjhyQnBpSnQ1TGx3MjloVUZ4bU9JSjBmTzg2eDFp?=
 =?utf-8?B?d0YwWC9OSk5mQ2ExRG9ZVFJ0K1NqenVDSnQ0M1BQQUtVclpGT01rNmJNWWlE?=
 =?utf-8?B?TWpxOFZxenU1VHdjcEozcXYzaWFodHBvU1RIY0NlVjY5d1hHUzR1aVBZbXBZ?=
 =?utf-8?B?Z2dKMDhtY1lEY25vUGVnbzlwY2M1dTR5Zi9zeVNVSGRmWkF2U1RCL3RyY1FU?=
 =?utf-8?B?VmYxMjAveVlabDR0MzFvRlBQZmUwR0t5SUYycGkycXl3aXYxYWFUcDI4Yml2?=
 =?utf-8?B?TnlmL0UvNVZBUjhRcW9OeER2RUhIaUthYzVOcmltckZKaUo2dk0xK1Zmc2ZC?=
 =?utf-8?B?dkNDUU01MVlGOWNpQVlnRHZQcFhJZ2RoR1NxMEloaUpReENTTHJ4a0VUVGFR?=
 =?utf-8?B?S1o3VG8yQzVsSnRBdWxjcDZhaGJPVDdFR0crNjloemhWWTdFOUVoY2k1eE8y?=
 =?utf-8?B?TDd0bWl6U1lEUjRaTTRGZ2VJT0tkNExieDJpckR4bGtOdWdTcGU3Ynlxb3I1?=
 =?utf-8?B?MGxlamprYlp6clU1bkN0bmE0MHIrd2hrOUpmT0RQcUszcDcyOWwwT1ltVlRw?=
 =?utf-8?B?QkcrZE9xZGFpZEttaHZPRlQrQnVJM1VDS0JaUXFEZTRwb1FORTRWc0ZXaEpm?=
 =?utf-8?B?U2FGakxvRG5wM29JSVpaNE9rTm40UVF6dWt2YWV1cm9aWnRjQ0JlcjF3Z2ZL?=
 =?utf-8?B?WnNVdHd3TWFORWQvSVprSTBhOWNmR04yRlhpRU1uWmZUWWp2ZHVGSWVlNi9a?=
 =?utf-8?B?RWFDRGRsbXFZMEpVVy84YTFPTkRUZWhDSHIzdi9aZHEwZTdFVWVwREc1QzV1?=
 =?utf-8?B?KzB2QXhrOC9qRWphbTNxblpGdDZqRXZWTkJlZmVBQnNiVlJodVdid2gySGp1?=
 =?utf-8?B?ZFpUbXRid3dEajU4SDdvY1Avc0I2ZjYyS3MyclpLM2dwWnVWSlIrVGl1bHRV?=
 =?utf-8?Q?xpmM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9459.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmN6TjZjWEhXeWVjZHBicGtKSDQ5S1FUWlUxZ3Y3OHM0YkhydlV2RFlGaFFj?=
 =?utf-8?B?RGdUNWVmd3NkMGpyTWJIR3VXZXAxS2t6UE8rNDJQc2dPdW1tRVNwaHlkQTYy?=
 =?utf-8?B?eVdyTGdpRUZRK0h0WkZTUWcxZGxONHhnMC9ldEVFY3JqOTFDaGdnY0d5QzRT?=
 =?utf-8?B?TUNIZkRDTWRJZktsV3p5VDJmaE43dzlhZkNobW0vTk9BVnNRRmRHTTRSMHNH?=
 =?utf-8?B?bU9VMmNQK1d1aVJSZlpTbzM3LzhhZzBLNEZIZHR4cy8rTDFEZWowZTcxV1I1?=
 =?utf-8?B?aE9GOXljbHRCbkhvSHAvYlJRZHRQSGdaZ0dhWXA1SThsb2pNdGFJbVpqcThn?=
 =?utf-8?B?NjA0T2FZNXppQ2lKVXhzVTVVZldGYVhkc0hLbHhUdENXQVkyNUs3Q3NQMkl5?=
 =?utf-8?B?Tlc2WSt1cWwrSHJlU0p1VXJiNnQwTzgyTTd5V2prTXdjWjZUcVh5czBCdUpI?=
 =?utf-8?B?RXFCSjh1b1h3c3dRQlY1NVVHcE9XTFhnaWh2SVBHM1dpMUFCSmVFcjkyVDJh?=
 =?utf-8?B?TFdnRVEyZHcxb2ZvSElCNFhSSXpkZkFOOFBHSkRqMmk2RHErakUvcUpmVU5m?=
 =?utf-8?B?ZVVVVXZwajdEMzcybzFtWFVKRDMrc2tEa0M5aFRVM2lWT1RmZ01obUdwWE10?=
 =?utf-8?B?QUJDc0ZOVGxKamdGZHpVeS9vRXg4akRoMnFsaFByWVdaU3YxVUQ0bFhyUVM3?=
 =?utf-8?B?c1pnbytseVZTZnhhQ0dyaWZtUFMzVWtqRGtIMitHc2pXR2RNZWs0RGN2bGV6?=
 =?utf-8?B?ZUJpbzhPUGxzbTB3NEhJZkhLeDg2TndRTlNUTlpPcVVDci85S2xNNDhURFRk?=
 =?utf-8?B?ZnkyUEY2dGNyQmhrUStUQmJ6cElhZTRlOXJiY0lXamhtNExVYjJLTmZPWGRX?=
 =?utf-8?B?SC9lcytwSmE1WS9QR05Kb0xNbkJrTnNoU2YrWlNsMC9FeXlKb0pZUWMzeUV2?=
 =?utf-8?B?NzNzbk5ESCt1RVJDU2dOYmluWW5iOVBSYnVOU1BmT0p0Z3JhOWRSV011bWR0?=
 =?utf-8?B?L2xlaUtxUHVHNUZIblQ1a251SVQ1ZHlIdTUzWUNtOGVJaGVqVXF2WHEveXBm?=
 =?utf-8?B?SUdDN3JGOStwdnV6NDJuZVdhWnV6Mm1NM0R3aEREN3ZCRE5SNVJuZ1A3V1Zk?=
 =?utf-8?B?YzUyb05uSHFmQldHYUVub2NRbHg3c1g0Q0ovS0k1VTd5V0RDVTdDYkNWTXNr?=
 =?utf-8?B?WnlHb1Z2blVqSjk1aVFsOENUdFkxdnBoN1NlbXBOOGI0TEZqcThtbW5YdzFF?=
 =?utf-8?B?QmZiNTRnWmxDTm13dFQ5QnYwbEQwK3FUOWRlVWdHdndxWFIrSElFR0w1Y3hN?=
 =?utf-8?B?Q1lzemcydytBVUJZdGRWS3RmbFAzS0FwcWxtZUhEMWNPSEt0UWlPU3I3MDhQ?=
 =?utf-8?B?VkIrWWszbmZ4amd2U1V5WWZhdzdZUklmN1pCcWFnQ2xQeWZYeHpMV3RYZlpX?=
 =?utf-8?B?dzh1QTFPZXM4TjkzemtwZCtMaVlPRURnUXVXM1VZbTJJQzBZNlpjQUZIRHgz?=
 =?utf-8?B?cjNNSVM0Sm85S1Q0MWdEZzllMndwWSt6VVI2dzF6NEh1MGxjMFNtRlNFeXFH?=
 =?utf-8?B?azh6R2tnT1FMTFphREJCQzk2dlFTU2lNRkFhYkl6ZTI0eHkvZTA1YzBZa0hB?=
 =?utf-8?B?Nmw2OGJhS3ozemNPaEVGa3d1OFkvSXhNWGhBMld5TVVjWHhDaGN5enU5V1h1?=
 =?utf-8?B?ZVR6SU00WkphajY1RHFxMCtvR0lrQVdrb004ZFlWSWRsOVNCM0RBc0pUaldV?=
 =?utf-8?B?YmtlS2hzYVc1K0sycUdYYWlnTmNRbWdKaXh5S3hxaWprSnpMcE1hb2VKdzIv?=
 =?utf-8?B?VEZnc2FENHFzN0RRL1FuQ2JzUitMN2trQjlZZTg1OTFJZUsvUTRHWVRpbWh3?=
 =?utf-8?B?cUVoZEh0aVZpcDJDeVJMd1hyRlBkK1VuRDR1bjFVZlZVSXhDMDdSK2pMUlpo?=
 =?utf-8?B?MElWa2tZUHV2czMrdXg0cGVwa3EwbE5ua29zcFpVN0VUUUlOTks5L2VoL05w?=
 =?utf-8?B?eXZQQldQZ3UxcWNjaGNEZDVEZHBCcWhyZjQwRCtDZmhOMkRHeFJaaWdlemkr?=
 =?utf-8?B?MnRBTUF5TWdGSDEvc2ZFYklRZERodkV3clcrUjRSUXVQZmcrMlZKTVRhNTZ4?=
 =?utf-8?B?a1pCa2VzY0Q0N01DaEVNL0hDWlRoeGZSR0FoSUlrRHZsVmhPRHUwRDBWbW9O?=
 =?utf-8?B?cXoxVisvbTBQbmx6NFNZNnQvVlR1eGxaQ1NGVkRlTEJBQStsMkNaTkorVTFw?=
 =?utf-8?B?RGdGNmNES2xmeVBScHlGbnduRFJUNUVTaTJmQ1dVVTdlWUtDRjBoenJoZmNz?=
 =?utf-8?B?SHFJU21VSFI1L0JkRlJNSEFlQ1hyU3VBV3F3NEhnempRSWtPTmdkZz09?=
X-OriginatorOrg: edgeless.systems
X-MS-Exchange-CrossTenant-Network-Message-Id: 67de1ba1-ae8e-45f9-0390-08de6b0f77d3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9459.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 14:52:11.3100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: adb650a8-5da3-4b15-b4b0-3daf65ff7626
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCprvThLdIKFvdde9dpAtGLr44V+pIxLd7kwf49AiGzJbqRCrbOPeZzlIOb6dpnRn2g8wATCO4XCKlmYdrPjSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR02MB11045
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[edgeless.systems,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[edgeless.systems:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-efi];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[edgeless.systems:mid,edgeless.systems:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ms@edgeless.systems,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-6127-lists,linux-efi=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[edgeless.systems:+]
X-Rspamd-Queue-Id: B9533137472
X-Rspamd-Action: no action

> What about the patch below. It seems we under-reserve memory for the
> table if it is unaligned.
> 
> I still think that we need align start/size/end to the PAGE_SIZE in
> accept_memory()/range_contains_unaccepted_memory() before doing anything
> else. Otherwise (end % unit_size) check is broken. But it seems to be
> unrelated to the problem you see.
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 111e87a618e5..56e9d73412fa 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -692,13 +692,13 @@ static __init int match_config_table(const efi_guid_t *guid,
>  
>  static __init void reserve_unaccepted(struct efi_unaccepted_memory *unaccepted)
>  {
> -	phys_addr_t start, size;
> +	phys_addr_t start, end;
>  
>  	start = PAGE_ALIGN_DOWN(efi.unaccepted);
> -	size = PAGE_ALIGN(sizeof(*unaccepted) + unaccepted->size);
> +	end = PAGE_ALIGN(efi.unaccepted + sizeof(*unaccepted) + unaccepted->size);
>  
> -	memblock_add(start, size);
> -	memblock_reserve(start, size);
> +	memblock_add(start, end - start);
> +	memblock_reserve(start, end - start);
>  }
>  
>  int __init efi_config_parse_tables(const efi_config_table_t *config_tables,

Thanks, this patch seems to fix the problem causing the panic. The VM 
boots as expected with this.

Please let me know if any more information is required.

Best Regards,
Moritz Sanft

