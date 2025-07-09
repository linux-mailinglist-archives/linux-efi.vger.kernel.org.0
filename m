Return-Path: <linux-efi+bounces-4255-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BA7AFEE11
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 17:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11EF21C42573
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 15:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830A82E9721;
	Wed,  9 Jul 2025 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QJRU/Hhb"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855442D2380;
	Wed,  9 Jul 2025 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076241; cv=fail; b=IXD8vK7Job89wCs+0jlsUD1XX7NKSam2Q499xf87sfUZncg/qKktMvnhxCUefPvrCpdgk6WJfTDyYSwNZnxe36vwwx7PVYGLFDS/Yx1zj4WcEGXMEP/f867mwSPjjna5onvSU/fVfIWPPWLhA/5oSICOoOZp07g1ADWqtTu8POI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076241; c=relaxed/simple;
	bh=gyTWaAeED7gdB9lK5SBKvi/raTyIXzXu2kdGZMFNxCc=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=Hf0eyj91hadEgh3DB1vr5jCvdF8DszHUahQt4lXW0hg/jqQtLU2DOx6oNJL1s/JDuUmQG3cq22UyNtIXa9pdt5aywnZIcJAdfRRMyywRVEw2UoO1zGaaFy8ByItmn0F1oDi24ESIm8IlLpIjs073Cvh4LF6Jz8SwXzoGBPE7Jsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QJRU/Hhb; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yku28jVabHKPd2rcxgc041ftYf5CGMcn4K33AikyrIbHKKI8GDIuxxmh7iYH+ejrUtRqKp0VAlMvGIM8Ioe7113UyOQDhJKjbkDVQluWZJ0Lt0eW4E2m8gYUvRvyFdUiv/XnkfFz5+15pMyLLD/ThOqQfgmneyieJQDcaPNGh6ORg67ZbNUTMj5Z8//Mfh25iMnMm2SGhndxZfxs+R+/3bOsa7+ftHJ9Jb3SAUdSpMEZ06hTNezs3YfxraeEbbkQNN0SoeON/jr33WqT7pjilRynodzfvsZ7dUtjFLEG+RIet2YVShKnwHkam5B2Whe5XBO04QWqNaBoAmn0IJ7d4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+SazlK3o4qhhnQ0oSZzVVCrYcYGh6HeXd2q65t9rfA=;
 b=ryaN6s5vD0Z7Rx/ZbNXVy9tbQFZDldboniztBVX2Mm5PsS1HtPtvtT8s3/tgWuDQP9M3oLd055P9nD+xtdZZSapcrpB487TmoL0DXCTbjvzGLAJNmkAtKqrfOBOsjCTkGeH61/HqBioPSs9gYnSc3VY9JzenAYI21yL5wcaje0IBJGhTSUe0BcX4aNaWkRh9WVfJLCYDy81gAMkK6FJg37BUUF1DQNa/HWqlfL2hc8ZNZ36z8E3izupJZsrSjY5fCvwImNbovvqy79rhy0XBMG6nGr6r31EM3suQutp+sMJ1ewQydSuM9L1CLfoEv1bMk6loUcU5w9KsMddc9OjxCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+SazlK3o4qhhnQ0oSZzVVCrYcYGh6HeXd2q65t9rfA=;
 b=QJRU/HhbmLJgx5cQ0RjPC63t5qhjhRTSLgcUdK/R9sqNqxSpaJTFn5CpMYp+KmeBRkzOFGdZonooLg9bnORfGBd/uAg0KM72raaBEoiz4goxfFGHVp0/hUJ4gLyOTtgV2ZgNfY984SLum6EOWQ2OGXrLMuzqTvwu3LD7lLuTHc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SJ0PR12MB5662.namprd12.prod.outlook.com (2603:10b6:a03:429::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 15:50:34 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8901.023; Wed, 9 Jul 2025
 15:50:33 +0000
Message-ID: <439d28fd-357e-cc1a-4ad9-092c63899673@amd.com>
Date: Wed, 9 Jul 2025 10:50:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, Dionna Amalie Glaze
 <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <20250709080840.2233208-26-ardb+git@google.com>
 <20250709080840.2233208-29-ardb+git@google.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v4 03/24] x86/sev: Use MSR protocol only for early SVSM
 PVALIDATE call
In-Reply-To: <20250709080840.2233208-29-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0050.namprd12.prod.outlook.com
 (2603:10b6:802:20::21) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SJ0PR12MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e0c7958-8ac8-4f0a-4e5c-08ddbf0056e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2FENkQxOThLRE5jejNUdUt3TnFmSkJTZlFMaDYxUmplK0s2WCtJUGVPOWNV?=
 =?utf-8?B?cnR4dUxLelh6YW16VmszWEpJMDl4QmJtU0orOXMxZURzK3VDZ0sxZnRMN0dD?=
 =?utf-8?B?TDA2UVFwTEVjT1B3L0lCbUJEQUtFb2U4TFU0ZldsVUMzY1NHb29GbE43cjFh?=
 =?utf-8?B?UmJuTXoybVpod0RwSm9Cb3lUdU92ZG02NVRXWmxPQWRuZEoyTGJlZEREM2Rk?=
 =?utf-8?B?NmdCYVhhSE1TVUMzMDJDTDdaVUtDUndQWVVRK2ZOR09XMWY3ZlZlL1c5eGpl?=
 =?utf-8?B?Z0NmK1k5b1phT04zUk9kUjhLSk9rZllPSHRxOXhTeUNGREMreHRUdWNRUEJI?=
 =?utf-8?B?M0xJbGR4dkZWWHR3enEzWnFrZ1Z2ZGx3MjlLWEFwZlVVWVd1ckdacGFobkhQ?=
 =?utf-8?B?RHZVSVhveWREQ0FHcWo4N0xYQnVFWHo3MThVZzZ2ajRaalZkcUZZbE5sU280?=
 =?utf-8?B?T1JZN2FJV3ovMWtyZjIvRkJLc3BWN2V6TExRQlhsZWFnVUdVRHBHZFF5N3Mr?=
 =?utf-8?B?RGJhc3djKzBhUzRZRThsa25nclc3VzN0L2dzbGVuZ3R4YjZNVUxYbW9YbFNX?=
 =?utf-8?B?Y3dNNFk5a2d0STd2U3RhVUluTnZ5bzZvYmxQcm9PandhVXo1YUd5c1poUXIw?=
 =?utf-8?B?d3Rob1M3TDlIUmlFaW1Rd0w2Y012RHlMcDk0K1Z0WjVKT2tTai9VK1gyQTVF?=
 =?utf-8?B?dUI0Q2dwcUR5dk05QWRKT0VhelpsWjh3Y1M1V2p4N3M0QlhTUmkzclkrdW14?=
 =?utf-8?B?VEtPWndSMjBncjJkcWtJTjErZ0ZVQWpJMWVsd2FFUzBEeTh2c3AxNU1Pbm5x?=
 =?utf-8?B?RDhkcG10bm43eENhYXR0dWVBT1htODNEb05WWEptd0huN2FScUNSd2NWU203?=
 =?utf-8?B?clhYcUFGWEJTem1Ma3BwRlNnUkI1MG5EdnV1ODlyZ2p2MFF1SGpNMkIwZnlz?=
 =?utf-8?B?aGpwanNHNUZrYWRQYVcyOGNHRTBwR1Y3U0U2Q2lBcEVjUk1kdkNwQm1CM1lz?=
 =?utf-8?B?TTBuNGx1Yyt2QVpQRDVjc0Y5YlJnaE44VlVGQ3gwVk9vS2lHMEZGeFd1NnQv?=
 =?utf-8?B?QzBkN1FmajBMRFFCVXZBc3Jyb3BjTklkV0tCVVZQeHh4SjNWczBZMjBrZlFk?=
 =?utf-8?B?MlNDWUVrdWhWeXlUK2RnVWh4SlJ6eDZ1ZklTQjF0NXJud1RURGM2dFpDcklp?=
 =?utf-8?B?RkF0RzQ3aER4akloamloU29vUVV5ejh2QkVicEZmMlN0cWFEcmJlcnlnSyt4?=
 =?utf-8?B?c0lDMjJ0MTdDQ2gweWxGTjBSa09DcWhJWUo4MFFMVDZLMlpERHBXZ2NkSFYx?=
 =?utf-8?B?bUE2NG9mRmZRbk9DQyt0ZlFkblhFaGZ6NGNaZXZibExVc2I1aXNaajF3cTJY?=
 =?utf-8?B?NXBwdjE2ZWRBOTE5R0x1NHA1dVJRT2U3YVhVNXdic3ExcWV3TmRrTEF4VXlG?=
 =?utf-8?B?c3NqTjBtcGR5S2pqcTc0R056NHlNUW5BU056R1I2TzVFYW5HVzMzV0pJaHdI?=
 =?utf-8?B?K3Z5WTQwRHF5dDBpK1hHNFE4Nk1uUTlLczdQUDRwYkxZNllLamprTElTQ2k3?=
 =?utf-8?B?SFZOWkdza0l1MlF6bVNMRFY2bXRhZnFrekN0eVMwRDF2LzFyZDBNcGpxSU1P?=
 =?utf-8?B?WGhNM3dxb0ZwVTFzL1lDODcrclljK0VrUWZmalJZcEU4L0dSY2pRS1dsNjkw?=
 =?utf-8?B?TzlCZGIva3Q1ajhHM2ZmM3FBTS9rSDJ3dnhsb0JnYlQxak9JbVlDbTZtei9x?=
 =?utf-8?B?dXA0ZGx2dys1NXNBcTFpVFVQT09DWUNGZDhJMTV5ZnBDSk5qTk1BdDVpTXpS?=
 =?utf-8?B?bENNTE5RKzJIc1g2cURUdVR1OFArUUNiaG1WRHI1WmFyaTQyV3cyUU85R2Ru?=
 =?utf-8?B?T2Z0N3ZLN0dTdytCd0VwMTAraTZmWU5uVXJ5cVBob2hHZFRGcU5qL0xvSFcx?=
 =?utf-8?Q?LfEO2QieMss=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnRFZEFTQWZhcysrL0s1RmcxOG4rckpRTjRkSk1RM3dNQzN4QzQ4NW1FMVgv?=
 =?utf-8?B?dGJUSXUzNlg3QUVWYjZaVU55ajlFN2VXSnhjb2hVTDRJV1Q5aU40UGl1Y29K?=
 =?utf-8?B?dGI0R0t3NGM4WXozeHd3UlUxNEFxdlpYQnRYNXkwLzl0T3JENGo3enlmREZh?=
 =?utf-8?B?d2xmdXgwdkpJcDBUYzUyK1pQNUJXWmhOa0Y0VmIrRXMzVGR1SUt1eVVmSngr?=
 =?utf-8?B?cnVzUDFGeHhrTktteG5Mak5zVDQrRWZzVThPMHlOOU1EbHVLVVZyUHhrNm52?=
 =?utf-8?B?T0pFT3N0Ui84WDN4cWg5WTVxaGllWHZpVXhlWFFzUndLMlllR1cyK1A2RldT?=
 =?utf-8?B?Y1pLMnZvY2tuRHlxQXNOZktRTkZCVkJSM3oxaUxYS2xzekV0eVh3emZRdURQ?=
 =?utf-8?B?QkZUdkNDdm1zdGVxblF2aGx5bWVuRzZGd1I5aThOUjhuNmdQZk1ZL1B0ZERL?=
 =?utf-8?B?L1FROTdhbnJqazlYSlUxQVVzU0xpSHErWDhvS1k3dFBMOWV2Rzl1SWZ1cVVh?=
 =?utf-8?B?Rk54KzdzWE1OSWg1LzAxV096dHhlUldRdy9BelB2WUV3cThZbTh6TzRISmRr?=
 =?utf-8?B?eU9maXFQZ3MxeXV6dnpoaWo3VDZFNDR0OG5McG8zL0pNTFlJcVZEdFZ3SCtZ?=
 =?utf-8?B?Y3ZTQ0ZSdWN1dEljZndNdkduSE5ZaDliT0VYSFc0UlJFNkVBVTFtZUhVYnFJ?=
 =?utf-8?B?L1FxNUVUclNkckNEOHllaExyNTd3R3Vqc2ZWa3F3bk5YOXczeCs4d0V3dXYz?=
 =?utf-8?B?RnF0RFQrejlIM0drV1hkeXZCejlDTmNCelo3YSthTERRRXF0NmpJQVpxVEY2?=
 =?utf-8?B?RzNqVmYvWWp3cXhCdFJUVUh4bThldVFZbkcxVU83bFFKWmFteG9tY3lUY1hJ?=
 =?utf-8?B?NThGN1M3WUZKQy82TmxLcFY3blRobGV0TWdQK3dlTW1XR0RVZ29nOFRIN3Zu?=
 =?utf-8?B?YWJJRDlFTmZDbWtIS0VrQmpsK1g3VHRLWHlHQ2pISDJMWTV5Vmp4OTFJMTVC?=
 =?utf-8?B?dlk4N2pGZW9rUTVnZ3diMVVMNWw1cEM2Tk9ONVhXam13bnJvYi91QXliRGRy?=
 =?utf-8?B?YW9KcVV3MEYxWktkRG1DYkEzNXljazJ0dWc5R045WEhqZHJBVEFMbmd6ZXpj?=
 =?utf-8?B?MkZrSUpiMCtSSUZ6bTNQdkhSTW9YK2xJM0dGVjNIcXpGYi9IbldmT2ljdU0z?=
 =?utf-8?B?ZVpZVTdoMmdMMC85UmN2VGFmSVhJUmZpSzQ0Tm1BVEdCdlJCOTgwVGxaQmhC?=
 =?utf-8?B?dmRjR2c0SVBpUDVPeTY0Zy85WFBjZ0xSdVdsTUNOWENxVzlWbkZpSjJ4bS9V?=
 =?utf-8?B?M2djRmVaQ3l2UExpZGh2YjBGKy9va2E3V0w1LzNkYXZFZVJ5WGVES2ROajA5?=
 =?utf-8?B?bXpxWW5KQURMNXVpdlNubVFpejJhMW5RZjllbG1lTEhpVXRkUVpVRWtUYjJl?=
 =?utf-8?B?ZlBMMXFSQ2k1MW5OUjdRUHFpMklHeWVKc3lqc3hvZFBpNGdyMGEyU2ZXSlpa?=
 =?utf-8?B?Z1JaZC9iV0R4aHVLdkl3L01pcjc2T0JTRU5sUVd4QTd6RktDbVJONVdaMThC?=
 =?utf-8?B?SG5OMUVSWTgwZDY4aU5BSjFJYlVxa045V25reDVPWUNMWSsralVNVWlCRENW?=
 =?utf-8?B?QThjdUpMczNNdGs4aGV6WlBPWXF3M01FNGdSVUF2YkFTWFNoVzMvOGtMR20v?=
 =?utf-8?B?QTk2Rk1UVFlDQ1B5VVM4ajBLUE5EdTRkWlVlWEJXUnBZblk3NlRieWg0SFVS?=
 =?utf-8?B?NnExZ1k4OUFnS3h3eGFqbkMxNjlnLzd0cmVUZndCWndyR01tRjhKT3czVzhX?=
 =?utf-8?B?QldmRzNhTXpHUDJHeGl3aThVRDJkZGtIdVRTL2ljc3c2cm5DWWp0dFlGR1Ns?=
 =?utf-8?B?QlUyeUF6T0pvc0t2Y29QV09jbVdEQjk5NEIwWTJRdjhSMkp2WkYzSTRJNWZG?=
 =?utf-8?B?ZkxQbEFuTmFvMnQveDJnNGx2YnVlNVlzOE9BbzBWYUNxc0toTDR2akZUUDVy?=
 =?utf-8?B?QjAxOXF5UHpYTWkyU1JHNkR3bjljcUppZDVDdTdLWWw3QkJnN0U5VklNQUhP?=
 =?utf-8?B?UGdjL2JnZ1VISERVNXl2eWRLNGQrOEtYWHlwcnpEUzBqdFQxRkpiUXJlakxK?=
 =?utf-8?Q?LrSN+tNmEN3EPD0NR3V4Qqjmz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0c7958-8ac8-4f0a-4e5c-08ddbf0056e4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 15:50:33.7021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OimGCAFYkpQJbj/mYp5+Z2pVCPoz+bknFnkzSLZ/9HsTLfrPM/4r2qzuAWxZzPby9CMWcIG0Yuw9AakUis3REw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5662

On 7/9/25 03:08, Ard Biesheuvel wrote:
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

With some comments below.

> ---
>  arch/x86/boot/compressed/sev.c     | 20 --------------------
>  arch/x86/boot/startup/sev-shared.c |  4 +++-
>  2 files changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index fd1b67dfea22..b71c1ab6a282 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -50,31 +50,11 @@ u64 svsm_get_caa_pa(void)
>  	return boot_svsm_caa_pa;
>  }
>  
> -int svsm_perform_call_protocol(struct svsm_call *call);
> -
>  u8 snp_vmpl;
>  
>  /* Include code for early handlers */
>  #include "../../boot/startup/sev-shared.c"
>  
> -int svsm_perform_call_protocol(struct svsm_call *call)
> -{
> -	struct ghcb *ghcb;
> -	int ret;
> -
> -	if (boot_ghcb)
> -		ghcb = boot_ghcb;
> -	else
> -		ghcb = NULL;
> -
> -	do {
> -		ret = ghcb ? svsm_perform_ghcb_protocol(ghcb, call)
> -			   : svsm_perform_msr_protocol(call);
> -	} while (ret == -EAGAIN);
> -
> -	return ret;
> -}
> -
>  static bool sev_snp_enabled(void)
>  {
>  	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
> diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
> index 992abfa50508..1bb4b522dfaa 100644
> --- a/arch/x86/boot/startup/sev-shared.c
> +++ b/arch/x86/boot/startup/sev-shared.c
> @@ -753,7 +753,9 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
>  	call.rax = SVSM_CORE_CALL(SVSM_CORE_PVALIDATE);
>  	call.rcx = pc_pa;
>  
> -	ret = svsm_perform_call_protocol(&call);
> +	do {
> +		ret = svsm_perform_msr_protocol(&call);
> +	} while (ret == -EAGAIN);

There's no comment here, like in the previous change, about why we are
using this method directly. Can one be added?

Also, this makes the second place where this do-while call to the MSR
protocol is used, maybe a common function would be good to have now.

Thanks,
Tom

>  	if (ret)
>  		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
>  

