Return-Path: <linux-efi+bounces-2882-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34111A4EE74
	for <lists+linux-efi@lfdr.de>; Tue,  4 Mar 2025 21:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523D2169A1D
	for <lists+linux-efi@lfdr.de>; Tue,  4 Mar 2025 20:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DE3202C2E;
	Tue,  4 Mar 2025 20:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bjjshZne"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF6E1F7561;
	Tue,  4 Mar 2025 20:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120442; cv=fail; b=t68XND/NMy5CLNqtOdWde7ZuFeXbXWz6wT0OjS2rFRiljH1QJyKf0sbRq//lhUrlIaab6W7wy9kaLTboQKkSICNg78kKaSCGGDKTYx3O6g3enbinbs8IlGteYbmiYQus2mpCEnAGe/uzoJjasPBXb3OJQoTvAdyDwPs7cdam+kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120442; c=relaxed/simple;
	bh=9OOopWLGhOOpXjUtSWQDa+qbEfxCYmEzfrFwM2R5mnQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hhs9lBnKdxpxiHh+ImKlS4dqwd2q8TJq59OX9bRiSbLNwF5V2X9OkV25Sh4p5PNowuFU22DGq0DqVz9cqbBVFDGas2JTWcpT6hBGa0xEafuAovMxOT6NeC9APCjk2UwOtOgMBNQp7MRQt23nm6riNvQotWP/xTmHQ1fBQy4apFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bjjshZne; arc=fail smtp.client-ip=40.107.212.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpFfmjTeMABty2PKnKKPZP2OfyWLpeLQKO0eNzsEox3GnpiAKZGptDBneZ96Yx9uiOOKXZYm5aARXkasd5H+eKmIQP6Ggb8ySsG2Wq+mcGipTjMIfhYpArkCuo9kADmGuv51uSpHiRqlG78+4HzuiWMVirFPdLAvqYCFOBJ6Z7N/s51/rsaRCOXveU6IWsCzaUhsenyYiwkwt+yai3wb8XYCyf4J8veFJ32c9WD/ZW3EsmMm/RYgj92y9Hyxr2CO9emW0J/onHM5Zx3JXtLF6kNFTLcD337N1hgKmk8pcRwIiFlqK8mj3Ma2USBzK5xRVuL9hdnMm0aXkBbNgujT+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2Fcm0Q18clYXDFSmx00SkqT849cJmkY+5kU2dn3Ci4=;
 b=VMZWmNh5QhYqIkVXdjsCVV8MOyT48qcIKy1pUvgtusJf42r/Tav13iMexhqwE8ApBz+fuva1VzNCr6f/o7v5buDeG8xQwVEZhJyiI2OSGp5kZNHBGbWvpN1863rGxmRbhrqL9TkOUDIRcawCsPfCpgL+zMbTHM2GZyNQym8PYj4i6Z6npBRmUFLA/I94jU8WuMWZUp4UNec9KJjKEKYLVXiYUVt6WievORlBb1+kcuCYEAs43smoT4wks2NUstDyrOrC0ju/3B0WtfQ3egO0OK3qirPxRFm6DNENkZwUzBc3d7lhuE9KXH7lD2hMh/HLMPrepzKXk5s5+UqHE6fwEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2Fcm0Q18clYXDFSmx00SkqT849cJmkY+5kU2dn3Ci4=;
 b=bjjshZneSvzRY7+Uc1sOYdyMu9/xCf9unh9xmJa71f8oEY/d6QUBARA8krAve4WMvqzAg0W4cd2qdK3ICgS/tIqa2+4fK12HWM6UOSVG/d2caC24fXKcNeGv9kZ49wRk/wCyaiufmW5cxf7erqVHsUOWtnmG6UQ/MpOKLa1XcZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by CY5PR12MB6177.namprd12.prod.outlook.com (2603:10b6:930:26::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Tue, 4 Mar
 2025 20:33:58 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 20:33:58 +0000
Message-ID: <19fd5db5-cc52-4f05-8ecc-64a4eea3b9a1@amd.com>
Date: Tue, 4 Mar 2025 12:33:56 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] cxl/pci: Add trace logging for CXL PCIe Port RAS
 errors
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>
References: <20250226221157.149406-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250226221157.149406-3-Smita.KoralahalliChannabasappa@amd.com>
 <Z8dM80wy5Q8UQomz@aschofie-mobl2.lan>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <Z8dM80wy5Q8UQomz@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR20CA0022.namprd20.prod.outlook.com
 (2603:10b6:510:23c::22) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|CY5PR12MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6efdf2-4d60-4101-56a9-08dd5b5be41c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wk1CSVdiS3JLS1ZiVjBFSVFrSlBxQVFsdmovNkxWakhmRlJqOVhEMDRBR3Ar?=
 =?utf-8?B?anZFYmlRd1JJVXAya2xwVDJzczhzRTc5WUxDQmo1RjdoV1F3Q3g4K0FwdjJx?=
 =?utf-8?B?Q1RjeUpEUnQwaERUdjJnRjB1YmxiMjlwOGdDTzRSNE1yWFUrVkwzSlM5anhD?=
 =?utf-8?B?UllJdlNrMHU1M1JaZ1lsblhyZjhRbGpud3hhTng0Z3QvU3A0M2JLd05OaE83?=
 =?utf-8?B?cTk0OUphd0RQZ1FGb1hEKzZHL3d6ZklwMmpYc3pwR012blpEN1BHbUVCbk1Q?=
 =?utf-8?B?ZVA2b1EybkdGZXFBTHREdTdwWnpEeTRtWlgrVEZ6bjkvWUl4RXFwaGM1MlY1?=
 =?utf-8?B?dzRVQTFSVklaa1YzemMwOENPL1J3bXpHVjU5MzUyaU15RVJwTEZ3cnhJYUJa?=
 =?utf-8?B?NlV5anRNLzhubXdVUVAzVk1EV2NrcWVGb1QxbWpuSXVzWmpjcGx3U0VxajdT?=
 =?utf-8?B?bFNJOGluY2lDV3Y3eE5VVkZDRzhTSWFFeHB6NStSQ2poSnZMWkVnNTVpQUhF?=
 =?utf-8?B?U0JsN3QvOThwaWl2Q05vaDZ1Z21VVG5iWDNNRWRxUXRPR3BBMlVZcGpjbFA1?=
 =?utf-8?B?bDJUOGlvZWJzYzJKWjJQeThUWEVjcnhJVGRudm9jM2ZmYURxT1RwQTNaTUZO?=
 =?utf-8?B?eURYV080aENBSmVwa0UvdG1IZXIwSmVJcGxYamdmRThCVWVieHF0N1EraC9H?=
 =?utf-8?B?aEorSGZ2ZCtkVGg2Q0R5aEEvYndLRDFncFU1KzFINFgvTnFsYml1RUZGWjRB?=
 =?utf-8?B?T0pqS3hnOU5XSzN1NXcxZmJqWGU3Mk9Ud3E5dkRCMTdaME1WQ0JxQ1dibjZj?=
 =?utf-8?B?RDBHSU4rb3dGUjFoOWJicTZUSHNlU2N6VTgvZ21NMURTSmZWdm9qV0dCQ3Rj?=
 =?utf-8?B?ck1SaVIyVk9SVGpYaVNLK1pCNmc0ck4xUWoyWDZrNXBTemE4MmRVT2NLRU5y?=
 =?utf-8?B?eE84Q3FiUXFSWC84V3dWSTZmTDJDck9Lc2wrWWt6K241T2RXUVZVOTI3azU2?=
 =?utf-8?B?alJjZWMvNUlmY3plWVMzdFFmMldqVnFQekZ5dFBzQ0VucTRzVjA0TUJBSHB3?=
 =?utf-8?B?WW44YjlESDFROWJQUW5janlkNEJzMmxNTE5DamlkcmFaSlUyYkxFL2NvR2ov?=
 =?utf-8?B?WXl3eDRvNXdwOTMwdzB1azFhYVVqaVpDbmpnTkdxWC9Wckd6c3NCUmN0TUlz?=
 =?utf-8?B?VzIzb2FwU21ESHZBRUtpY1VvUFYyZmVXL05VT0s4QmNmRERQdHJQaG9zaTRi?=
 =?utf-8?B?ZWo2bWpITjVQQ1BzMlB1blViRXg0dXVIQXRrMDNqdkFKT2ltMkhEQ0lUWEhC?=
 =?utf-8?B?MDlOYUdZdjZDd3Z3Z2NWRytJR2tFTVQvNVlMaG9CYkpSdk5qMGlyeVlVSkJl?=
 =?utf-8?B?U3creVZueEdBMndQNUhMUUFOT2IvTHBtcE9CNDYxNWUrbFZncDl3eEZob3dV?=
 =?utf-8?B?VTdKYmlTQm16SUQ5T3RZWTVyMjZMc2ZLUDFRbnZmY2lqcDNuMUdmMVh3VWMv?=
 =?utf-8?B?T0F5Vm1YdlZoMVJGbUlKVlcvc1VuczF0SEhucUd3K29qT0t6M2dyN3pqMHk0?=
 =?utf-8?B?bHhsc3V2bDJvMmQ3andsS2FMME5vaVVRRHhNZDJQd2FjK1JjcGlmb1NBSWtZ?=
 =?utf-8?B?aDB4NXpJZHJ3eWp0UXpjV25OaDhqdWdjSExheDhURnM1Zmg2bjdwUEg2Y2s5?=
 =?utf-8?B?b0oyK3pvaUtESStSSkt3b1NYTGtMMG44UlpUdisweERIVW1vOVdySTlOTE44?=
 =?utf-8?B?Kzl1NkRJVnNHTHdrVUZRNEFqZU14RWNObUYrWnJINFAzM3k4ZUpmYnRBVTNS?=
 =?utf-8?B?RDFxZTNrMENvN0gzSjgrUmZZWEZBNGQ3V2lWcGZRWXFFM2pGMmdqUklDbnhI?=
 =?utf-8?Q?VeHJkEErCsX/w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1NnRkNjbWFXMTIzV3NNWkxXL0dWWEsweW8xdlI2aGRrcHljaG8vUW9oR1FW?=
 =?utf-8?B?K09laFZJSXNiRCtlaUhqK2JDUjRqeUh4WnVzaTFFV1llUkdCbXh6U1dHRUxi?=
 =?utf-8?B?WkhuejhndVFFSlI0TGdLQmZwQVlGQlhZNm5hY3FlSko2M1dZUHYwYUNBZllQ?=
 =?utf-8?B?RGdJL2JPci9xcDVDOVdXbU85dUVnV2dVTjNLcXhTRmhqMk01aGlzUFNKaFBo?=
 =?utf-8?B?SHpsbHh1SzlTK3M5a0xyTWZXaHhnd3paWGQ4cXBtSE53SXRCOGIwZmQ5ckNL?=
 =?utf-8?B?cld1ZWFuWGVMSzRqMkgwdnhoL1ROK003d1pKbnRKZmw0MGl5YXdoSlU3UXJF?=
 =?utf-8?B?ZGNLdzRmNHp4NHlzVzdsQlpMMTZzbm0wSjFQVmpXclVmZDdObWZBSFZZTVpN?=
 =?utf-8?B?cUF3L2VZV2p4WE9DTlVHVllXK2pGSUFwOSt2REVkVGYvT1lKa09ITUFxR1c0?=
 =?utf-8?B?R2MzZWJ2RTZ4SUdsak9WcWFaVkw4K2g3eXNldVBjbHZ5NkV4eE1lUWI3UXY4?=
 =?utf-8?B?SU1aMUdHTW5ua2gyNnZXRDVKQStUdE5acmZOMWY2SGpCVTRyUExFN1hVdFhm?=
 =?utf-8?B?b0IwV0dueEF1MTBvZnk0WDlNNGhvaG9MdXdOZkxZVXp0OHZwQlErcTczeVJK?=
 =?utf-8?B?cXFqQkRtSGdUT2VwdHpPanhhZDZIUUdWYTErUko5WEtKM010Ti9pc21TSzJr?=
 =?utf-8?B?Y2Q1a09mOFp4b2VhczBWVEwzdnQrY0toTW93Z3RjUkZhMjBzWUpaMWloWnc4?=
 =?utf-8?B?SE82V1g0c3lZZUd1STZ0K2FTQlFIdFNuTTFMMkdYdU9wVmRCOGh0Q1gwK01z?=
 =?utf-8?B?dHExUTBtLzlHcHNZQlpWK2JiUENYeDEzQnlYV0ZhUG16U3hhbjlnSStnMTVE?=
 =?utf-8?B?K09jL1BRdWhuWHUxeDJpZUZzdzB5Nnk0TTlEeTQweWQ1UnA4YWZ1OVVFN3B4?=
 =?utf-8?B?QUxaOFA3TUdrUjVFaUZUTys4NG1la1N5YjVZbmpCbExSM0xpcnlJYTBKZFJH?=
 =?utf-8?B?Y2R5SDFjUy9ybnZEWmlMSVVrWU02dUJHKzNDa01xTHphbExmRnppeTdSdDM2?=
 =?utf-8?B?Mk85di8ySldIWXh2ZWhPK3lZTWNWQlB1QjFJbTVUa1hkMHJ6S0F2eCtwWk9p?=
 =?utf-8?B?aFU1SUNBcC9VNittWUthR2hCK0UzYzNON2tuNTEycElScVdCZ1FoZmpJVXI3?=
 =?utf-8?B?emx5ZFc0SnNrTmcwMC9aMmpRempvdzQ5RnBGR0p1N3VWWWNNaHNLS3M5RE5k?=
 =?utf-8?B?UjRvZzNxODRCeTFVbDNEL3pBYTlRcU5zbi9MQ2ZacmdxcURsN3gxRWE3eVpC?=
 =?utf-8?B?dnBvRDJTUUdFak4rVWhJTTB2Qk44Um5SRjRVM1JaQ2pvOFpLSGtSZUNvT0Nv?=
 =?utf-8?B?OW9YZWI4UHg2Y2xNWFVLNTF2dEFXUHZ3QXNZTEEvNTFreW9KUlpSdEFuSGw3?=
 =?utf-8?B?eUFxUzkyRjdVb1ZOZmk3ZmlMS1BGS00zcVc5aGhQN2FMS1JyOEwwR21kRkFx?=
 =?utf-8?B?di91M3lkTnE5Z2VZSjdsVGFJOGJ0QkpPek45T2tyYTlUYUxhaEswcm5GbUlQ?=
 =?utf-8?B?cGgrNUo0SzYweS92RzRiandJQTFtdmNJaUJYM0E4WnRreFNVbnNwRDh2amFH?=
 =?utf-8?B?cTVhTmxFMFNqUnpGckZSQllUbStBckF1bWVRYkdlcUIyOWgvaFc4TkJweHF2?=
 =?utf-8?B?M2hYQ1JmRFdxMVBqSnBKalQ0UitTb1hKb211ZGJ0SCtLQ0J6bUV2bHRORXF6?=
 =?utf-8?B?Q1FlUWNiYXN2YmU2N0hKeTRuVkQ1MnFvQ1I4ZE5MMTJvN3pXRm8zQzRxckdB?=
 =?utf-8?B?c01MTmN5ZWVMVjZObURXNFA1RkNzUmZsRzJMM3prOGZXSTl6b1pSeko0NEdu?=
 =?utf-8?B?YVBHZTVSdkM5Skp0TisvSFNKbXpDYzBwR0k3alNiRHZaR1Q1cExRU3JGMUlv?=
 =?utf-8?B?QTFhbS9WS254ZVFkTFdZb1hBVzB1cVR3cXdlZFAyQ3gwRnBFZmtiazVESFBZ?=
 =?utf-8?B?Z2tHL0tWaGZ3dmhqL2xZVVA3R1BiV0RlM1dNdlY0aStHWmFKQjJXeENjZXpv?=
 =?utf-8?B?UmVzZ0lwSFZ6Ty9LNFkwNm1POGc2RkxNTSt5SURKU2xFNUlxcHNRRW00dTRW?=
 =?utf-8?Q?5ozmesk/pKcU/CV2WxnjB2mSQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6efdf2-4d60-4101-56a9-08dd5b5be41c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 20:33:58.5797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKasC6p5jkWmCtccPWmIrVI6sfMMvtIL4QbsE8Sgz86bblqxu+H7J92ifSAxt0/PRPO1wxzxWy/g7eHoCko7kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6177

Hi Alison,

Thanks for the review.

On 3/4/2025 10:56 AM, Alison Schofield wrote:
> On Wed, Feb 26, 2025 at 10:11:57PM +0000, Smita Koralahalli wrote:
> 
> Kind of a nit, but since these are exposed to user space suggest
> matching these names now.
> 
>> +++ b/drivers/cxl/core/trace.h
>> @@ -48,6 +48,34 @@
>>   	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
>>   )
>>   
>> +TRACE_EVENT(cxl_port_aer_uncorrectable_error,
>> +	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
>> +	TP_ARGS(dev, status, fe, hl),
>> +	TP_STRUCT__entry(
>> +		__string(devname, dev_name(dev))
>> +		__string(parent, dev_name(dev->parent))
> 
> Above devname, parent

Ok I'm planning to keep as device and parent. Let me know if wording 
"host" is preferred over "parent".

Thanks
Smita
> 
>> +		__field(u32, status)
>> +		__field(u32, first_error)
>> +		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
>> +	),
>> +	TP_fast_assign(
>> +		__assign_str(devname);
>> +		__assign_str(parent);
>> +		__entry->status = status;
>> +		__entry->first_error = fe;
>> +		/*
>> +		 * Embed the 512B headerlog data for user app retrieval and
>> +		 * parsing, but no need to print this in the trace buffer.
>> +		 */
>> +		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
>> +	),
>> +	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
> 
> Above device, host
> 
>> +		  __get_str(devname), __get_str(parent),
>> +		  show_uc_errs(__entry->status),
>> +		  show_uc_errs(__entry->first_error)
>> +	)
>> +);
>> +
>>   TRACE_EVENT(cxl_aer_uncorrectable_error,
>>   	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
>>   	TP_ARGS(cxlmd, status, fe, hl),
>> @@ -96,6 +124,25 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>>   	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
>>   )
>>   
> 
> same thing below -
> 
> 
>> +TRACE_EVENT(cxl_port_aer_correctable_error,
>> +	TP_PROTO(struct device *dev, u32 status),
>> +	TP_ARGS(dev, status),
>> +	TP_STRUCT__entry(
>> +		__string(devname, dev_name(dev))
>> +		__string(parent, dev_name(dev->parent))
>> +		__field(u32, status)
>> +	),
>> +	TP_fast_assign(
>> +		__assign_str(devname);
>> +		__assign_str(parent);
>> +		__entry->status = status;
>> +	),
>> +	TP_printk("device=%s host=%s status='%s'",
>> +		  __get_str(devname), __get_str(parent),
>> +		  show_ce_errs(__entry->status)
>> +	)
>> +);
>> +
>>   TRACE_EVENT(cxl_aer_correctable_error,
>>   	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
>>   	TP_ARGS(cxlmd, status),
>> -- 
>> 2.17.1
>>


