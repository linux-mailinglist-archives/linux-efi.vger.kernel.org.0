Return-Path: <linux-efi+bounces-4497-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6183FB14EB0
	for <lists+linux-efi@lfdr.de>; Tue, 29 Jul 2025 15:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872A418A0986
	for <lists+linux-efi@lfdr.de>; Tue, 29 Jul 2025 13:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6181C3BFC;
	Tue, 29 Jul 2025 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AoX8U2EJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345611B2186;
	Tue, 29 Jul 2025 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753796916; cv=fail; b=UQfqR+03zIsMOpS5Nq8DZ4+8ZBA2uppwwpD1H7/f6RaD0BehJuGwSNxg/Nmdx6P7iyWO+bCQemNu28aR6M5+gPdRE8AP6z1+HQueiWaHZODLrtzxF6PIQXxUvUJvM2btAMiTMtL2aq3ThWmKVW+QHSXkHCg4i89u7VI+EAEkJbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753796916; c=relaxed/simple;
	bh=SyGGO4mTT8JR1eXYfEdd7LNBAhA4fAp583ZDlg3Ufgg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VQHkvU2KsKu1ELvVONTpX6zOCvA+y6mZJB/WtBk9glAk27LPX451pWBS4WdpS+RHz/+qNR1YmCzXB+LKkbWbNn4wkXB8vSaYtpWv/r4tlvzAj9nlnv8AHN1G9MDcPAQkMKwMToqykvChJU0Gj+bmSTOmpDGJHZKgVe64pdpfUFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AoX8U2EJ; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jH6s9InwnwSU+ZlgJQXopuzdkMJStHG2+UNIohJEDv12qL8pxa/TOLr6eEE3DgLNbdsPtB/d8phTpW2JhcwPWtiKxHw4Ezqug/Ru+xrwNFIAyIWBCJv2+Bj18gMtGeloTsJ//zpO++qxM8DeeGWVbqSZcoKIqsCy7UBT1TDUAZlroa07T3s+Sc+7LC/YUp4+2SbZAMuthgqHZy13aw/c6w7uQ43vS0VETXaG067ZwDrZeMwUJKe/9cpfaY//zr1TSSxreF3X49xwBOK0Gb+8o2xwUAp91BDacrC5SBQWg9upCD96fkAOdDMcpeAFtVo8NFpL3YGRT1SIDHNVcHZ9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dj4ZEMsRknSNWKMrkNcHIePyh79r8Czg7Bjjbs3+tG4=;
 b=k0USfbtuMQSztC4e1+BtS0ctxd/s8wtI8SrN1xmwHtqQG+6LHVemTxE0hvDhza1jM/aIOuVnwtINl+NJLk44TsWmTNkSAnBXBWgbrrf+vxKvnZboKCQAdUFkE+dszUheUpST/fwz0vNkl4KACNIsoQb+E/JayAtiJUeWDSgYf1YA0JOjhkMrexZ7j0cxJD3d29AVAwwEmFSwNMqjT5PLScHLzIID8WivXjEwfttHt9Cau0WFiQ+HX9kyznFHmoVEK4GhZ/HFiwlRKrsqtr5b4BsGmlhYR6jaVcoqdtyHz+tR5uQnVZMmrZcSXcA4pQIUoaiKBFFY69yOJJ34Jm88lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dj4ZEMsRknSNWKMrkNcHIePyh79r8Czg7Bjjbs3+tG4=;
 b=AoX8U2EJ/Gsi398v+fSToEFOS6L9VtxfckqNQry/pyhlkU/LzcvD+aq4tKjjfCixuBeE1SR8RmDNwUXFBmrdgdBmiq1eC2S/HvDiT3Q6vjyzU1K1FFy7MJNDj5Nd4ObO2mxUtCyaY2OUCv4t+UH3B1xZRNEcAQAWV5dhvc3qIfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH7PR12MB9150.namprd12.prod.outlook.com (2603:10b6:510:2eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 13:48:31 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%6]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 13:48:31 +0000
Message-ID: <6bf4402b-7a16-d111-a5a1-fbf15edfd7b9@amd.com>
Date: Tue, 29 Jul 2025 08:48:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 03/22] x86/sev: Use MSR protocol only for early SVSM
 PVALIDATE call
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Nikunj A Dadhania <nikunj@amd.com>
References: <20250722072708.2079165-24-ardb+git@google.com>
 <20250722072708.2079165-27-ardb+git@google.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250722072708.2079165-27-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR14CA0066.namprd14.prod.outlook.com
 (2603:10b6:5:18f::43) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH7PR12MB9150:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d82282e-cf9b-4e56-e819-08ddcea69ab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckFiR2lDZldReWdqcUtiTlAxSmd2OXN6UGpzM1RRNmFFaW96Z0lKdnJ2bkVX?=
 =?utf-8?B?clhQd2xhVkhTNzR6OGJqMXRDejVZek1zNXpMRnQxb09QQndXbFBEYVRwcEd0?=
 =?utf-8?B?TTZ0Zm9LRW1OUGlIaDZHeHZMNWVTcXY2U05QSXlIRTd1eGpDalkwUTd1TW90?=
 =?utf-8?B?U2cxcmlra3FPRGZZcmRBYlVCdEp2TnlFY3NFbFk3Tklwa3lCdTNiQ3JYRUdX?=
 =?utf-8?B?YVlHaWZ1SmNld2VBbDNRcnp6VEEvU1BYY1VZM2JhYnpzcTVtN2lKc2hmdGlS?=
 =?utf-8?B?UTlFS2tuSk1RRnhuU3dRVGI1NGliZWNRMFFzdlBtOUNsbzFaN1dIS0lZV0FE?=
 =?utf-8?B?bFByRFIvRmtpeE9zVWZRNTBVY1N6L0VQMXBwRlgycjRhQ3RvQVhLV2dmOWpt?=
 =?utf-8?B?a2pNMDM2Q3Z2VjQ3QkNDb3RWUzl1bTZOeEtwK2hLcjV3QmM5MkxkaEU3c3VS?=
 =?utf-8?B?Ky9VVlU3WC8vNC9GdE50ZStpWDRoMkRCUlFjVHRNSXNEVXFCY3U5QnZGVW9z?=
 =?utf-8?B?NHBnSVJUQkdhclpEM1lPM1hpeElCNWN6OWRPV0ZBL1AwUjBjY09yYkR5UEpM?=
 =?utf-8?B?akt2N3cyanNmdVBWT05HeUVzY0FyRnRNM3FZWHhENFRVRVpKS3dIWWdqZEF3?=
 =?utf-8?B?WUNOMG1jcWJuVkFoZGVQWUZsekVhbUtSeXhVV05nSUlTZW9KU2NnR0Y5ZGlH?=
 =?utf-8?B?VGpvWFkyVFNLRGVSa2Z4bHNOTy9Vc2VoTzRWQ2lrYjlKR3EwQXdWQTFGTVox?=
 =?utf-8?B?Q3FWK1Nuc1dCZ3Y0T3U1aFZrSkFmd2J4UXRpeFd2TEFkeGFhdE9kYmlWRG9X?=
 =?utf-8?B?eHFOdVdmTG15K0cxcy92T1psY0U2ZTdXai9iejg4cXVrU1FJdlRqZkZab1NZ?=
 =?utf-8?B?SU5tVjc5N2ZvejNLTndkTmxhOHIxTDQwVXZMdFdkTm4xUFAxVnRHMm9mdGVO?=
 =?utf-8?B?Wk4rRlprUnMyaTUySWc1Z1dCczlqdGl3SnFIS25KT1hRTHRvWWcxSW5vK1dq?=
 =?utf-8?B?QTZ1a2hIdVB4WDJBQUVIUENwL2xVVWpTK0JzZkZtUGtoa3BGakZQcDB3emps?=
 =?utf-8?B?ZGhiN0VRM2lIYWRrVnNLZzhxbFNneW1wVHR3OE9WQ0ZOaEwzMXdzS2V5ZGg4?=
 =?utf-8?B?OVU2WlVhRW9SZEdmWk0xczltMGVxOURJTzRTMXk3SVRwVUFaTzVRTUNsTWRk?=
 =?utf-8?B?YlVhZzU2RG1NdlNvc2tYVVJLeGZCblA4MkwxNVBKVTRVaW1hSm8zQTdrSjY1?=
 =?utf-8?B?T28xWHFtODRGNkRzbHhmTnpjc04xNTNOTkN1SXBqVUZmWm5RYTl0S21GUkkz?=
 =?utf-8?B?RVQ1STdZTmZoanh4eWJpZmJkYXIxeFB1ay9xU3ZFTTltemN5MkdqRDlENkJq?=
 =?utf-8?B?N2ZEOGE0djBFRXNMZnZqQUlXOWkxa28rTUNscWJkcUVQMnNGSDBCQ1U4RnUz?=
 =?utf-8?B?aW5xcW5XNnBITUEzWVJXbkE4Umo3cnAwYmY4NVNqUHh5LzZkMGNlK0trejJC?=
 =?utf-8?B?emhZTnMvK2p6RjA1MWRyYUxVblJpWXFQdHBNaFdodHhWSHdSUEIrQytyOFJz?=
 =?utf-8?B?RWtEdXFXa1dYWm16dzBpS0tFTW8xL0JJcldpamNCbzJHVW5LYmxHbFlOTEUz?=
 =?utf-8?B?SllobjZ5Q1Ntc0d1TlpZT0EzRHhsTXNCMlRjYm1uVEtZYThqVXNUUG9lUWJI?=
 =?utf-8?B?RWVTRmhDemVuZC9ReFdzUUJtRzBkOHB5MTA5U29KMVg5MkkvclhJcEpiUVI3?=
 =?utf-8?B?bStKZi96NENJQTZEblBYQ3R2b0daSGYwREozZlRrWHpEMnptc0RmT0pJaVhT?=
 =?utf-8?B?ek5CL01JbXNDZ004WS81SmdaRkVKNnhjMGtLaU1abnhqazVweUp1QWpuZHJX?=
 =?utf-8?B?WEhIN2dIT21DUnBrQXNTVVNSSXM3dXFzZEJnVmR2WVdZU0JBSURWOVFXejJx?=
 =?utf-8?Q?1i9f5KjtZB8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zmw1MnBzbUJLNUx0WHYxM3ZUbm9wZ2R6WUNIcWF1Ykljc2xMTkNkV1RET0o4?=
 =?utf-8?B?NzJQS2pvMXdVWnlYQ1ozS3Q3VnpDenI4TmFsQ2tPQzBOeXdaWjg0UU0wUUhJ?=
 =?utf-8?B?bitXL08rcWtsRmlXTDk1SnZwaGltcU5LMEVRZ28vNUdDOVhmTi80aFU2RUNy?=
 =?utf-8?B?a3BBTi9EVEw1TzhJdERDRUJ4QzZ5TWtucmFHZzlsR0t6K0I5N1dieVc0Mnp0?=
 =?utf-8?B?SlVpM2ZiNWlkNU1ldTMzWk05cmU5VG1KNFNveFlKNCtDMktCR0w0dmhDWGFx?=
 =?utf-8?B?THhzcm1ybzM4bm9wU29LN3ZQRTU2VjBYRTNYRlRUZlNTR0svQTJuYlBmamxB?=
 =?utf-8?B?d09UdGlIUlpvU2dNL0VrRzZ4MXZVWVpWTHJxMTNScktzS2tkRGVNc1Jtdnl6?=
 =?utf-8?B?K25YOS9mZ0JkTXJCNnZMd0kzZS84V1dUY1RzeUNSa3RXc1U0RU9mMVdYbGtO?=
 =?utf-8?B?THo5SXhSTTFRYklweDQrT1QwRUcvaSt0a3RqVzFYVVVuUzVVK01HcCtDcTBo?=
 =?utf-8?B?VWVVNEN1dWhMY08yQURLWGgzbEZ6cnM1eHU3bXFBbFc0bkdoSExRZ1p5SEZx?=
 =?utf-8?B?N2s0ZDEvMFpMN3ozUWJXa3k4ZTZvM09velBUUnprNWxkbkdMUEQvSGRvTHVQ?=
 =?utf-8?B?NjFSK0xvbGh1RzE3cnp6YU1LRS9rdml2VHkwak90aVdIN2ozV0FHSEI1VHhm?=
 =?utf-8?B?WmNRZWdWcGUxRFpQOTA1Tk11b2luNVN3RUs0UU9VK3pEMFpiL3liR3d0ZTdL?=
 =?utf-8?B?d2YyR2hTcW9ubjZyUXJKR29DTFZXLzJuN1hBNk1Nd3VEZjJrTXpnWjgwYzR3?=
 =?utf-8?B?Z1Nmem9icUExSXlvQk4vYU1ubWpOamNrbU5XUGdjay82cEV5ZmZBU0ZxWjNZ?=
 =?utf-8?B?bEZuaXo3eTBDbExwa2RpMG9WT29sUGhyZmFVWEZKd0tna3lsM2xvUDZLMjIx?=
 =?utf-8?B?VGxROHN0aVpBNjZLRVMvM056K2Y2R3FQalFMaHZVTTNrV3dlbTdtbVJTL2ZX?=
 =?utf-8?B?dzdGNkZMNVpjT1pGUmNRSDFta1FNcFA5Um9hb1FKdHVqbW9tUEJWb1ZxTHFF?=
 =?utf-8?B?N1NMb3krclg1aHFqYWowdk5BWWx4cCtObnNLWnl3QWhadXpndVVDMGgzSUx2?=
 =?utf-8?B?Nlhxek1HNFlWUVFSZEs3SENZSHdQd2ozWGVzekV2WC9jUEZ0UGpaTkFoeTRi?=
 =?utf-8?B?ZTRMdUpCTGUvQjZoYkNWeEVBNkF2ZVB2aS9TcXhJMXc1aW02aUdOdkVzZ2p0?=
 =?utf-8?B?RUVKZFNnWGY4U1BQbE1TTG1vTHFXSThSN2VCQVQxaHZ4MWswSEtyV0QvNHBw?=
 =?utf-8?B?dUNZYjlzOTdtTG5QdkNJbkdReDVtdkRwYzFMVTlRellHWUNSYkJ3NGxJcXI3?=
 =?utf-8?B?Y3FxbjVlUk5UWWpoYTR4WUQvVENOZ2tsZXlrdUtwVFZyT2hXUGxvZll1dmNY?=
 =?utf-8?B?VGJVSm85VzhOMVNaOFk4N09yZENzRlV5WjZFbTZTUnY5bUpQZzdTNG02akNk?=
 =?utf-8?B?THo2TW5ib2dJMmthOXNlOElkZjExZ2xNNjc1SDY2dG93TUdHMWwwRWdaODc1?=
 =?utf-8?B?cE9xdG5qREZFNnhSQlJ2MW9kTTB2VE80dFgwMVNiRmVDaXJEMlZwS2JBbzNJ?=
 =?utf-8?B?K0N4dWhiNmdJblJEVDBQRDFsTVA5OExVcVdiT0JndTZyUytpUS9IZ2xxaGN0?=
 =?utf-8?B?RmxWV25EQzZzTG81Q2FCVGV0UzcrS3VnRzQrSStVSUtocm5FdzI5VGh3MVpJ?=
 =?utf-8?B?NTVJWmVJR0IzRVRndnhsTWNSWnlHZ3BZZFB4c0M0cStLR2Q4SWN1Wk9kN3Va?=
 =?utf-8?B?ZHBUbmJiV0J3RmJBY2RoZ0ZVajBYTGtBMG5WQVB5UnZIUDR1Um5aekFVZmxW?=
 =?utf-8?B?Y0xldTh6SzBUdkNnNWlSWjlkTnlWVVg0SmNFblNLTmxOYTBjdWwyZHlpbVpn?=
 =?utf-8?B?RTBDOW8rRzR4SG0wTEpDSVNBdlRSSi9LKzVyVG5nTUw2MytxMkJSUXRoNE1I?=
 =?utf-8?B?aE8xdVp6QU45b2ZZMkQ3L3NQR1c1M09uNDg1eHNrcWlSK1dweXFVbnpCQThP?=
 =?utf-8?B?bmVhbWlUdk5XVzh2bCs1VHJ4eTFzSFNKMmJBRXB4S1hGb0JvY3hwYlV5ODFn?=
 =?utf-8?Q?BxKkFLIVRq9lugL1969UqAzmO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d82282e-cf9b-4e56-e819-08ddcea69ab2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 13:48:31.3834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4I3bFIfH5OXrfzSwNZMT88JkMG1rVP+JBNjO8jG1nYxwBKJOTJ0FdOJtRY7+hWO7Mc2jbOZpDSjiMqmqDhktDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9150

On 7/22/25 02:27, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The early page state change API performs an SVSM call to PVALIDATE each
> page when running under a SVSM, and this involves either a GHCB page
> based call or a call based on the MSR protocol.
> 
> The GHCB page based variant involves VA to PA translation of the GHCB
> address, and this is best avoided in the startup code, where virtual
> addresses are ambiguous (1:1 or kernel virtual).
> 
> As this is the last remaining occurrence of svsm_perform_call_protocol()
> in the startup code, switch to the MSR protocol exclusively in this
> particular case, so that the GHCB based plumbing can be moved out of the
> startup code entirely in a subsequent patch.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/boot/compressed/sev.c     | 20 --------------------
>  arch/x86/boot/startup/sev-shared.c |  9 ++++++---
>  2 files changed, 6 insertions(+), 23 deletions(-)
> 

