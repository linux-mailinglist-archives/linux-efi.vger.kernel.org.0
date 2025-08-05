Return-Path: <linux-efi+bounces-4512-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83379B1BA37
	for <lists+linux-efi@lfdr.de>; Tue,  5 Aug 2025 20:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99423B5928
	for <lists+linux-efi@lfdr.de>; Tue,  5 Aug 2025 18:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA21299AAE;
	Tue,  5 Aug 2025 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="a1OFZTql"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2090.outbound.protection.outlook.com [40.107.236.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F85298CA4;
	Tue,  5 Aug 2025 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419022; cv=fail; b=q+qcLcFSPaUqPITeTXN7wG3CXzlX2IJZsPAo4UzSht3Ym8zHUkiIW8Y5juKOHUKrykyKrH91nee7r7DCPgD9hZYlW6iSRPVLll+czWr9002mrP3pHKjIW2eGS6B3DHL2wF3RMSoQteGNk9ihV6BoO+AGwEOiaW5L32rSYikNkHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419022; c=relaxed/simple;
	bh=l2IcCZKMFHsU+78qrpF8wq+M2uaUHm8mgXQxBkFiYFo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=a+EDTnfCKIazleviR/HTTFbqsDyPf1hN3a+GAeFrXowgrcrTw93QMg/o7O+JE9zn89Ht7OjYa9pyKBCGmGYDbcCVSXu+SkNOz8bz55pYsSKVUf9PuiXEaVw/kV4UXhsICFOPrl1pPURvtdPYOLRom5U03SsVnVXi4JW61uGjdpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=a1OFZTql; arc=fail smtp.client-ip=40.107.236.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSA4Zw5awQ0inGtP51jObMaVeUFRlc3p4il74vNHf8fkxlbAcp4I0SSzKAzQteIW7Mh+VIioFtAqpGEVI5FvijowSRNKIA38PZiGKuOxb82W54YVaW6weXcdoFruZDC98bFIuxTKv7QR1bwMFfpDYmnf9SGeqVz43iVDd9zsXjg2H/Yr2Vl96ZkDfaTclmS8LwXef6co1Bc8JF2QBPCmCPPkctq2xM5GUkYgvd5ZbOBQcusUIRmEes40zMOEHHicSjBs+yFkDg/oRfj947H4ooa1ebAXQlkjQyJHt25VSfcVZMKBtMbNFpVgbxh+p0DMBJH43sluAU0BiDT3aWEhJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xszOMYoDKhbFOEu4dWUS9rjE6SsFxwzil9ervBF2JgU=;
 b=dEuW+xP9fjnQnhWa/n6pJ/jkVXT0lrPHvn+zXN0HyamcuGYZJfCCMfnm/EGYMnC7cptpvezcEGWZpb8Eri39wtLAC7ffkqK7C1UpuS82OEGIZiq0dUdklTI0GCMu3uQDMLvijhJShgkRpy5C8ggMQb+rgvZWATJLUeJIh0t4tzpYu/ysUAV3Sl+1QfWUGvF24jmkbeZfd0uzpHak7uMV4fyfP+J0RrpRZ0+vX6no5y8dahSmrEvSmM4+NFhovZSkhB5LG9BWIsbkuyg5xKQ+0HWaA3HZVOTsNwvfl1xU8eUByeR7jkRuAhfIBYidtACfjd8AMNX99krYMPxxqreTxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xszOMYoDKhbFOEu4dWUS9rjE6SsFxwzil9ervBF2JgU=;
 b=a1OFZTql+Q/sSwLRLJUWIkktLSpG6sS+yfa76PVHfpTOQDkcHOACHRO35r2ReAH0JGfEQYgLYnvhrSO6WcytseCugG8NGPaH90w0g4XKRCYGbh+iOYgFMWOu+t/FAIlyVxGMRh46CpTV/ZFSPWoSoGE4MOGqqTZgIz9TCOWhw3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 MN0PR01MB7755.prod.exchangelabs.com (2603:10b6:208:37e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Tue, 5 Aug 2025 18:36:56 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 18:36:56 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Date: Tue, 05 Aug 2025 11:35:38 -0700
Subject: [PATCH v4 1/5] RAS: Report all ARM processor CPER information to
 userspace
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-mauro_v3-v6-16-rev2-v4-1-ea538759841c@os.amperecomputing.com>
References: <20250805-mauro_v3-v6-16-rev2-v4-0-ea538759841c@os.amperecomputing.com>
In-Reply-To: <20250805-mauro_v3-v6-16-rev2-v4-0-ea538759841c@os.amperecomputing.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-efi@vger.kernel.org, linux-edac@vger.kernel.org, 
 Jason Tian <jason@os.amperecomputing.com>, 
 Shengwei Luo <luoshengwei@huawei.com>, 
 Daniel Ferguson <danielf@os.amperecomputing.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Shiju Jose <shiju.jose@huawei.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: CH2PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:610:57::40) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|MN0PR01MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9d41f4-3a58-4f8a-67bb-08ddd44f0e06
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUlORERCM2tEVnFXc1hHaS95WHp5NERYN0ovNlpxTG0yZExTNHZaMEo3MHZo?=
 =?utf-8?B?Tll6UGJUMUg3WjF0QzB5Y1ZHZmtiQ3g1SDd5RmUxcXBpNTJpOVJzUUhGZm1M?=
 =?utf-8?B?U2grbDkzbDBISE1DYmpjeit4VU1QNEgwSlVWQ1RBR2dNSXB4eW13b0FydFE3?=
 =?utf-8?B?SG9NTnhrV21jMWxQSTcrbmExRE9qQXIydzZUKy9XaC9CL1QxZXpGQWxycG9L?=
 =?utf-8?B?N1NXdld3a3pqaXYrVzNUdmhQbmppRHVha09aSmtLU2E1eXc3OEdBdEpPQzhD?=
 =?utf-8?B?R29IbzQ3L2xxdTMxcCtyY2FMUEdQT2R3NHZWazdKYXVscG85WGVXY1FyUmph?=
 =?utf-8?B?NkU4STBVWHFobjlpWGNVcDZ3ZFp3TkY4OUI5V0RRWndvcG9MQUJGVndzdW5s?=
 =?utf-8?B?akpsWU9ZSmVHRlNRTWtpSFNVMHhoOUtYOVNBSDlaRng4ejRoQlYvZVlUQU11?=
 =?utf-8?B?RUcxQzBnbkZVVVY5eURqTWk0S1M4azN4Qm53RzZ5SWdlRFJoY0EzQkc5eXcy?=
 =?utf-8?B?VVArTENaOWtXYTBJRTZVajdpV2VGVGlHaFVLdWJPM0lPME9HcVhTdENXRkx4?=
 =?utf-8?B?RE1KdXFVamJPYWJIdzRlLzlDVm9pQXBlNnErNHYyekVERjFEVmhBWmJnSHhu?=
 =?utf-8?B?ams2WkMrcDJraG9SMTJhRXNLdk1ucnExaHNmY05JNmdhWHNrd1MvbUFaSFVl?=
 =?utf-8?B?Qml6V2FEK0pXQVNiczRjTHZvbTBINDVocitYNjRkWklFTG91d2Q3WTJHVjRk?=
 =?utf-8?B?alp3YlBDTnowcEVLeHVicHhJblgvajNWRU9ZQUU0ajRlSVZpVnlidVFHNFFj?=
 =?utf-8?B?eWhkL2R4RDJCd2g0cDErUHkvMDlVd0xLZkRwUy9RWWdDcXREOW9nK20rVHlW?=
 =?utf-8?B?Zko2eGVKK3FQZ2tLQXArQisxL2NKMWlkdmhGMFlISXRONndpNXdLRmh4ZlhS?=
 =?utf-8?B?QmFwUEhjZFFUeFhCOXVGUGdaOVhqNCtpY0lBOHhZZFpiTnE0WWNzQ1lYdUYz?=
 =?utf-8?B?dXNUMkdWa0xSQ2lqTW94K2tGeFJtbjRYSmI1dk9BdUozc0NaQzNOdW5haXMx?=
 =?utf-8?B?bDhvazBsNFNMUkpaU25NVTZSNk1SM0QrY0JJcWhPZ2s1aCtLQzNUM1UwK0pW?=
 =?utf-8?B?QU9GaGo1Y1FFaGxrMm1rNW16R09seGhkNFdRZmppOHRZWENLcUxEMUQzUklK?=
 =?utf-8?B?c05neWJzSW1BWTNvcEFuazE5M3B2QlVhcVF1MEdvSHFTRkNJeEczbWx0cFBz?=
 =?utf-8?B?bHNGelEyamJEakRNY0RYZjVma3NxNlA2WG5pOVNVcTllRUVMZytBT3dWQ1ZJ?=
 =?utf-8?B?RHBrQVFnQnNabWI3ZGNhOW9SSGJaTU1pazRKWkFERjdXNTlTTWpuZkJIMkZo?=
 =?utf-8?B?Z3NTeER1eTFCR2VFWEs0cGpWQWtqTUVjbW9nTlArRFFNV2NzbmRHN0Frbzc2?=
 =?utf-8?B?SWk1OGt6TStHdVBKR056V1g4dThkVDNMVUpnMnpQY2RvM2ZTSzVDcm5DcjJ1?=
 =?utf-8?B?cHZQYU9hVkNPUnpTUlNNb2s4Sy9vdzBuUmFOVlovYzVORERZempkMjhXOXcw?=
 =?utf-8?B?N3pSZlNwWFVONzZ1MFRLSVdUU0Z5MEhydHdDaTdKWmVac0h1bm1nOWhaV3FO?=
 =?utf-8?B?MzVoWnVjNjdWZzRpNjJ0dHlqcmhpZlNjMHQ5UzQ1dGY5Y3B5aHBGQzMxQTNu?=
 =?utf-8?B?WjhCQ1dyWEZQUXp5cC8zVXN0L3VwS3oxdzRJRDBVTVVUU2Qxa1JyUmhaVmlX?=
 =?utf-8?B?RncrQ2F2OE1jNFg1Si9aVEorQTZORzFtM042V2o4V2hsd2R0RnNaVDQzS2l3?=
 =?utf-8?B?akhlVWFYUTBBZGtDWmF0V1J2Y2VBR1B2a0k3N3preGhCazlQMVEvcUxzUWdw?=
 =?utf-8?B?eWhjZUtOa0hBZW5qYjh5QStTcXZna1NLWDVZZmcyL2VBaFM5VDhGQ1JGbFI1?=
 =?utf-8?Q?74+48MZ7Gnw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGFKaDd2OHBTMTFlMEdaWTNjODk0QyswemVuVXdIL1BPb2Z4QTZOQUVmZDE5?=
 =?utf-8?B?T1RKQVFYaC9aMDVWeEJveU1NRm5DZ1lsb1owWjRpTXlGMk5tWWZvcnViSXhZ?=
 =?utf-8?B?NXYrWlliMytEUzc2ZVphc1U1aTViQzJTV05LMnJhOWRsbHIxSGVkRXc0eStC?=
 =?utf-8?B?Ym84VWhqOTRsSDFtVDFOckc5aVJmZGhzWHNHd0xOTEpqeXIrbGNQdXRpRG1r?=
 =?utf-8?B?czcyTnB2N0NXUWxyOGN1cnROK0FVQVpzc2I3UTNsUUtvMjE0eUdUb2VmbkR0?=
 =?utf-8?B?Z01PRjhhajM4MGk4Qm9pbWxrSDUyeGdMM2RtZTdlQmhjUGNUQUZJc1p4ZG9Z?=
 =?utf-8?B?MWhiL2MzMEM2eTk4NjE4SEZnOEtKMjdjRFJwdi9wZllIOEVoWGswekpXQUph?=
 =?utf-8?B?M0dKUW1aRG9sMG9HZFF0S1NwQzRBVHd1VnA2Z2llZFdVM1RjbkExNUdkcEll?=
 =?utf-8?B?N1lWZjc5OFJoT1pHbmFxQy9wTnA3ZXBOb0tFSlNvck5aU1BqRk5NVk5iQkJZ?=
 =?utf-8?B?amU4Y24wa0p4STJ5Tng2Q0p6S1NmOHJoeFBqSWJRSUpYSVJhQ253cmR2Z0pu?=
 =?utf-8?B?R1FkanpoMlV6aWxqVjNVaVNvQ3pqQzZJbldIdzN6dXVBUVVzZjJOWmlpQVds?=
 =?utf-8?B?alF6VXNoLzduTWJkSzFRUnI2bitoZnkxMnN5Z24xRzN6TVdYTHdzM2E0cXQ2?=
 =?utf-8?B?S1k2YUtERjVNQUllRlJiL2JNUGVmM1dBNUE1Rll6QkFEVmdvcmVWREQ1Wng1?=
 =?utf-8?B?c0RmcmR3dkRCV1hMKytlLzRQaXhWb1F2b3JSNVBrY2pKdkt5MFc1OHRaY2JH?=
 =?utf-8?B?Z3h1NmNvUllhb0YyeGVLUjYyMERNNGxnb3d4NUZpeWZPYUU2amhBYUQyMDEz?=
 =?utf-8?B?aHF6TTQrSGlVOHV0ejFHRDIyUmlSYlJCbGNleExGVWJTbXBDWkd0MktuNlJB?=
 =?utf-8?B?bGRXR0kxZ2FUZXJUWG8zYmtXb0lHejY0MlRXb3pvdG9QUDZnbWtLUExIK3RV?=
 =?utf-8?B?elpSeWo3Z3ZrZVFuT1prYzVRZjNmaUlySDNaWXpscVh4QzlOM05KOEoxcU5k?=
 =?utf-8?B?TXpNYTBMMzBxRFl6cDJpUWx5aTFRelYySUs3RHVCOXl1TlN5QUhPYVgrazNM?=
 =?utf-8?B?NjhQRng3T0FtZzRqaXE3UXJxaDkrTEhrZHdkbXByaEIxeHJDWERERUVTV3Bl?=
 =?utf-8?B?M2YrMXJEczNQL1orSGhSSGE0a21wbUNMaEsvdzFXY2NQMnlWRXJKT1o1cDVJ?=
 =?utf-8?B?b2R0NldRYWo2MW1vN1JhdWQ3Snl5bEN0L0prbktCUVVHcXE1d2l3ZTRYRnU5?=
 =?utf-8?B?TnQxL3hJS0RXSG1zSFBSYnFvbVg4OVVIKzYzcC9qWW1zcTRWVFk1UHBTN0lT?=
 =?utf-8?B?ZElsNXZxODZqNGlNak5qSWN6VlZkcHRtUVBndzhPcmRtN0UzVWdFbGk5V1lq?=
 =?utf-8?B?eFdSL01JdGJVYnFqL1U3V2ZkNkJCVzRnU041QmhMZEJGR250V0xvVGJTR2U1?=
 =?utf-8?B?OGRvK0sxNHovQkZ3UEh6enBucnpheWszSUxseGdYVFExRlZjMDF0UmVNNWMr?=
 =?utf-8?B?VFBaMFB1RGl6cTdIOG1kaHpDdVZUZGVhN2xVVDQvb0xlcjR6Tk50QWpsRThU?=
 =?utf-8?B?cGdSVk1KQ3dZaXU3ZURxZFRqZFFlTzUvcWJ4STNQVmwwT0lpbmN0encwcVZP?=
 =?utf-8?B?M3ZpQnpRZkNzb0E1MFUrZjJseDVkVGhzRnM5ZFovT29nZE5HZ1FLL3EveUov?=
 =?utf-8?B?WXBLb1ZNeFB4Unc1MWRNV3U1UENXakFFSTBVSmFvMkVhMnc4VEJlSWY3TkxR?=
 =?utf-8?B?SlJML0pqZkVKMTNzYTVPdGIzOXpMTmdRVno0bXZ6dHFJOExxWGpTclB1OC9T?=
 =?utf-8?B?VktDWHpMY0xHTEhBdWJweEpkTHV5blZicW5pa1ltNDZEQms4U3o3cFhnanFO?=
 =?utf-8?B?SUYzNUFnZGtRc2xQZkU0dVNVQVZTVjU3OVdjNFQrZjYvQld3RVAvNjZaNmdR?=
 =?utf-8?B?dWtJSVIvYXo1TW5Od0t5T3hsV3g5VWNLZlNLRkpVdW1xWDhtN0c2azZaajdh?=
 =?utf-8?B?MGx5enAwTzQrQThQNkdVdWN4Z1ZjU1lYQSt1TTdmZWhTMm9IaHdkMVk1Mkg5?=
 =?utf-8?B?Z0pZK0I0Z3VUcVFCaXlzK2xnell5UWNnNkx5ZHlyRlZETnRIM1VibGZUTjdi?=
 =?utf-8?Q?z4rgO6wOD9vnc9nM8MM8VDw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9d41f4-3a58-4f8a-67bb-08ddd44f0e06
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 18:36:56.2002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0Ci/xhQ3IdOtrmBPNwdLM+nzWi9siW5idxkc34COXarTu4opq/MFtLHnjt0a3bp4vFrTpK0KE0w4GmnmY1bdJdCbKfzDgA3zjd6gng7khahBtZkHE+M46nIwiOQRskb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7755

From: Jason Tian <jason@os.amperecomputing.com>

The ARM processor CPER record was added in UEFI v2.6 and remained
unchanged up to v2.10.

Yet, the original arm_event trace code added by

  e9279e83ad1f ("trace, ras: add ARM processor error trace event")

is incomplete, as it only traces some fields of UAPI 2.6 table N.16, not
exporting any information from tables N.17 to N.29 of the record.

This is not enough for the user to be able to figure out what has
exactly happened or to take appropriate action.

According to the UEFI v2.9 specification chapter N2.4.4, the ARM
processor error section includes:

- several (ERR_INFO_NUM) ARM processor error information structures
  (Tables N.17 to N.20);
- several (CONTEXT_INFO_NUM) ARM processor context information
  structures (Tables N.21 to N.29);
- several vendor specific error information structures. The
  size is given by Section Length minus the size of the other
  fields.

In addition, it also exports two fields that are parsed by the GHES
driver when firmware reports it, e.g.:

- error severity
- CPU logical index

Report all of these information to userspace via a the ARM tracepoint so
that userspace can properly record the error and take decisions related
to CPU core isolation according to error severity and other info.

The updated ARM trace event now contains the following fields:

======================================  =============================
UEFI field on table N.16                ARM Processor trace fields
======================================  =============================
Validation                              handled when filling data for
                                        affinity MPIDR and running
                                        state.
ERR_INFO_NUM                            pei_len
CONTEXT_INFO_NUM                        ctx_len
Section Length                          indirectly reported by
                                        pei_len, ctx_len and oem_len
Error affinity level                    affinity
MPIDR_EL1                               mpidr
MIDR_EL1                                midr
Running State                           running_state
PSCI State                              psci_state
Processor Error Information Structure   pei_err - count at pei_len
Processor Context                       ctx_err- count at ctx_len
Vendor Specific Error Info              oem - count at oem_len
======================================  =============================

It should be noted that decoding of tables N.17 to N.29, if needed, will
be handled in userspace. That gives more flexibility, as there won't be
any need to flood the kernel with micro-architecture specific error
decoding.

Also, decoding the other fields require a complex logic, and should be
done for each of the several values inside the record field.  So, let
userspace daemons like rasdaemon decode them, parsing such tables and
having vendor-specific micro-architecture-specific decoders.

  [mchehab: modified description, solved merge conflicts and fixed coding style]

Fixes: e9279e83ad1f ("trace, ras: add ARM processor error trace event")

Co-developed-by: Jason Tian <jason@os.amperecomputing.com>
Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
Co-developed-by: Shengwei Luo <luoshengwei@huawei.com>
Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
Co-developed-by: Daniel Ferguson <danielf@os.amperecomputing.com>
Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Shiju Jose <shiju.jose@huawei.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-section
---
 drivers/acpi/apei/ghes.c | 11 ++++-------
 drivers/ras/ras.c        | 41 +++++++++++++++++++++++++++++++++++++++--
 include/linux/ras.h      | 16 +++++++++++++---
 include/ras/ras_event.h  | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 99 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index f0584ccad451915a2679c17f2367461c141663c5..99e25553fc1320b2306efb751e12f2377c86878a 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -527,7 +527,7 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 }
 
 static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
-				       int sev, bool sync)
+				     int sev, bool sync)
 {
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 	int flags = sync ? MF_ACTION_REQUIRED : 0;
@@ -535,9 +535,8 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 	int sec_sev, i;
 	char *p;
 
-	log_arm_hw_error(err);
-
 	sec_sev = ghes_severity(gdata->error_severity);
+	log_arm_hw_error(err, sec_sev);
 	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
 		return false;
 
@@ -870,11 +869,9 @@ static bool ghes_do_proc(struct ghes *ghes,
 
 			arch_apei_report_mem_error(sev, mem_err);
 			queued = ghes_handle_memory_failure(gdata, sev, sync);
-		}
-		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
+		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
-		}
-		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
+		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
 			struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index a6e4792a1b2e9239f44f29102a7cc058d64b93ef..179b1744df71ee1eac28718628d550075c480cd5 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -52,9 +52,46 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
 	trace_non_standard_event(sec_type, fru_id, fru_text, sev, err, len);
 }
 
-void log_arm_hw_error(struct cper_sec_proc_arm *err)
+void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
 {
-	trace_arm_event(err);
+	struct cper_arm_err_info *err_info;
+	struct cper_arm_ctx_info *ctx_info;
+	u8 *ven_err_data;
+	u32 ctx_len = 0;
+	int n, sz, cpu;
+	s32 vsei_len;
+	u32 pei_len;
+	u8 *pei_err;
+	u8 *ctx_err;
+
+	pei_len = sizeof(struct cper_arm_err_info) * err->err_info_num;
+	pei_err = (u8 *)err + sizeof(struct cper_sec_proc_arm);
+
+	err_info = (struct cper_arm_err_info *)(err + 1);
+	ctx_info = (struct cper_arm_ctx_info *)(err_info + err->err_info_num);
+	ctx_err = (u8 *)ctx_info;
+
+	for (n = 0; n < err->context_info_num; n++) {
+		sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
+		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
+		ctx_len += sz;
+	}
+
+	vsei_len = err->section_length - (sizeof(struct cper_sec_proc_arm) + pei_len + ctx_len);
+	if (vsei_len < 0) {
+		pr_warn(FW_BUG "section length: %d\n", err->section_length);
+		pr_warn(FW_BUG "section length is too small\n");
+		pr_warn(FW_BUG "firmware-generated error record is incorrect\n");
+		vsei_len = 0;
+	}
+	ven_err_data = (u8 *)ctx_info;
+
+	cpu = GET_LOGICAL_INDEX(err->mpidr);
+	if (cpu < 0)
+		cpu = -1;
+
+	trace_arm_event(err, pei_err, pei_len, ctx_err, ctx_len,
+			ven_err_data, (u32)vsei_len, sev, cpu);
 }
 
 static int __init ras_init(void)
diff --git a/include/linux/ras.h b/include/linux/ras.h
index a64182bc72ad3f2b430c53c7a9e23e798a1c1fbe..468941bfe855f6a1e3471245d98df5ffb362385b 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -24,8 +24,7 @@ int __init parse_cec_param(char *str);
 void log_non_standard_event(const guid_t *sec_type,
 			    const guid_t *fru_id, const char *fru_text,
 			    const u8 sev, const u8 *err, const u32 len);
-void log_arm_hw_error(struct cper_sec_proc_arm *err);
-
+void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev);
 #else
 static inline void
 log_non_standard_event(const guid_t *sec_type,
@@ -33,7 +32,7 @@ log_non_standard_event(const guid_t *sec_type,
 		       const u8 sev, const u8 *err, const u32 len)
 { return; }
 static inline void
-log_arm_hw_error(struct cper_sec_proc_arm *err) { return; }
+log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev) { return; }
 #endif
 
 struct atl_err {
@@ -53,4 +52,15 @@ static inline unsigned long
 amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err) { return -EINVAL; }
 #endif /* CONFIG_AMD_ATL */
 
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+#include <asm/smp_plat.h>
+/*
+ * Include ARM-specific SMP header which provides a function mapping mpidr to
+ * CPU logical index.
+ */
+#define GET_LOGICAL_INDEX(mpidr) get_logical_index(mpidr & MPIDR_HWID_BITMASK)
+#else
+#define GET_LOGICAL_INDEX(mpidr) -EINVAL
+#endif /* CONFIG_ARM || CONFIG_ARM64 */
+
 #endif /* __RAS_H__ */
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 14c9f943d53fb6cbadeef3f4b13e61470f0b5dee..a6b7ac0adaff9dfeab05a0c75ed359930ae04479 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -168,11 +168,24 @@ TRACE_EVENT(mc_event,
  * This event is generated when hardware detects an ARM processor error
  * has occurred. UEFI 2.6 spec section N.2.4.4.
  */
+#define APEIL "ARM Processor Err Info data len"
+#define APEID "ARM Processor Err Info raw data"
+#define APECIL "ARM Processor Err Context Info data len"
+#define APECID "ARM Processor Err Context Info raw data"
+#define VSEIL "Vendor Specific Err Info data len"
+#define VSEID "Vendor Specific Err Info raw data"
 TRACE_EVENT(arm_event,
 
-	TP_PROTO(const struct cper_sec_proc_arm *proc),
+	TP_PROTO(const struct cper_sec_proc_arm *proc, const u8 *pei_err,
+			const u32 pei_len,
+			const u8 *ctx_err,
+			const u32 ctx_len,
+			const u8 *oem,
+			const u32 oem_len,
+			u8 sev,
+			int cpu),
 
-	TP_ARGS(proc),
+	TP_ARGS(proc, pei_err, pei_len, ctx_err, ctx_len, oem, oem_len, sev, cpu),
 
 	TP_STRUCT__entry(
 		__field(u64, mpidr)
@@ -180,6 +193,14 @@ TRACE_EVENT(arm_event,
 		__field(u32, running_state)
 		__field(u32, psci_state)
 		__field(u8, affinity)
+		__field(u32, pei_len)
+		__dynamic_array(u8, pei_buf, pei_len)
+		__field(u32, ctx_len)
+		__dynamic_array(u8, ctx_buf, ctx_len)
+		__field(u32, oem_len)
+		__dynamic_array(u8, oem_buf, oem_len)
+		__field(u8, sev)
+		__field(int, cpu)
 	),
 
 	TP_fast_assign(
@@ -199,12 +220,29 @@ TRACE_EVENT(arm_event,
 			__entry->running_state = ~0;
 			__entry->psci_state = ~0;
 		}
+		__entry->pei_len = pei_len;
+		memcpy(__get_dynamic_array(pei_buf), pei_err, pei_len);
+		__entry->ctx_len = ctx_len;
+		memcpy(__get_dynamic_array(ctx_buf), ctx_err, ctx_len);
+		__entry->oem_len = oem_len;
+		memcpy(__get_dynamic_array(oem_buf), oem, oem_len);
+		__entry->sev = sev;
+		__entry->cpu = cpu;
 	),
 
-	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
-		  "running state: %d; PSCI state: %d",
+	TP_printk("cpu: %d; error: %d; affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
+		  "running state: %d; PSCI state: %d; "
+		  "%s: %d; %s: %s; %s: %d; %s: %s; %s: %d; %s: %s",
+		  __entry->cpu,
+		  __entry->sev,
 		  __entry->affinity, __entry->mpidr, __entry->midr,
-		  __entry->running_state, __entry->psci_state)
+		  __entry->running_state, __entry->psci_state,
+		  APEIL, __entry->pei_len, APEID,
+		  __print_hex(__get_dynamic_array(pei_buf), __entry->pei_len),
+		  APECIL, __entry->ctx_len, APECID,
+		  __print_hex(__get_dynamic_array(ctx_buf), __entry->ctx_len),
+		  VSEIL, __entry->oem_len, VSEID,
+		  __print_hex(__get_dynamic_array(oem_buf), __entry->oem_len))
 );
 
 /*

-- 
2.50.0


