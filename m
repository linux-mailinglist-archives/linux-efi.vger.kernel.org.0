Return-Path: <linux-efi+bounces-4488-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEEFB13DD1
	for <lists+linux-efi@lfdr.de>; Mon, 28 Jul 2025 17:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FDDF189BDF5
	for <lists+linux-efi@lfdr.de>; Mon, 28 Jul 2025 15:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802D526FA76;
	Mon, 28 Jul 2025 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ile+x3hU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812811A76DA;
	Mon, 28 Jul 2025 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714943; cv=fail; b=SCyegCzRt2QymVbfyyAKQHr844X8X8jVHWE1UaaF4bgeWmjBS+B6c4J+2n9+7u+wEhYLm+5qbVLCiCWlahzYAvzXDd18NiPHUD01IseXmV0e3Cexm61nPVjLmHSF1zbLYArUaxoau9RUcuW3CVWXFDzCmkrH2Ntgfly4g7XKqPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714943; c=relaxed/simple;
	bh=X644JIXfHeuXMQCmc6a52Qt0j/Hv5/VFjyZT6qRef80=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=GO8xlDXGKUt5pP+/4kfRmqOSyBV5Vgmh/HQlE64d5VvSnMNX8RZinZ3gExNo/G/7y1M47UhvNOlZ6nYLwY2Jhjbhy0cVKujuQKa9YkAzSvTQpXdQT5I94+Su2BDkU/+60ySApR2jBRyX1VsRzqKs+uOPRvHV7f3dWhXmmtYIL/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ile+x3hU; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753714942; x=1785250942;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=X644JIXfHeuXMQCmc6a52Qt0j/Hv5/VFjyZT6qRef80=;
  b=Ile+x3hUyYeWgRDrhwUsLryUi7+oDQzfNw1CvQXyTH7Smdx4oRq9PE8B
   6zIXPnFJRDIIU7luFagsfrIQUYqvCXccPmPuC3pPy+hCL2mQB9cqrkt93
   0rO5w0NS82hOwD4zIM2WyIKRQP2DiPOPBqHmhOOTETlKV+DdCicc63kuR
   +fKmtxUwrSHDxIFaRR9l8EPLJuvxclEF8Lauz2mUDRJF38QKp3gZGQU0V
   GefnoP/4jDRNu+N17nByM5nfJVU7l6FwUEsN5Z0aRM9UsNuE5AflXyKb2
   b77se6TvU6yCgxKEy3QcKvKBdjJfiIPprbimmXL/RYtDZV8JUobFwpO9a
   A==;
X-CSE-ConnectionGUID: iqaSO6WPQ6K1LM4bQWJIqQ==
X-CSE-MsgGUID: 5WSBW0MvQiSHBzjhJehEsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="73550717"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="73550717"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 08:02:08 -0700
X-CSE-ConnectionGUID: HENFtM1vTZajitmVE6tGsw==
X-CSE-MsgGUID: ElLIFsAnRrOWEsMcPxOarA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="163212526"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 08:02:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 08:02:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 08:02:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.80)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 08:02:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQ4QltbWA3z49No7xlsuThastzI9FROVadGfcrJCFxnO51EH5NENVFFSivV52BpdtjnWY3BdqsBvh6DcUJIwDDx3zFnfLQ9xrvqFwpXFOm54bE8RsLLvrnWOHFkwjgxBrLeoubt1MfXO+yS3vdKXYiTyz3BVyo2dYLgxqXblcdPzjvVX4CgUJXFtSuEgxzve8tAZz73Vvy145nQkbZvUoahy4WFUf+/PoxzP4nSLPf+sdz6x7OXBFO0YNX37EIROvmuOOAOv4oRsypN63hejBC6w5viKs3zsrpeyVDCjTTfG/lO4eW1iv/fN1TwwSh9AcZDJ6aZTBvx75MAMYbvJQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUQQ84JoJaE3ne2eZ2mEA4q5wkp0mVSuvdlwSAbYhB8=;
 b=OYzDjkmleHvHdmGSOI94vgq1j0mMGIVdEvvcSn0OwMFSyH/B8Bcc1INphkTuIcJ1qh/inDupg5xv0hlN8pyjJxHk+SOsxePnhFJvlzPlIj/S28Mgd7IE7+MeHp3ZGVWmbh2yWgY1Xqn+PneIJynZoPmKa/3CxAB35EaYIFR4j7kPKOpalL3fpxu/9z/bktOCpIFLald9erXEb3SB1rsM2fwZwjMoT1ChxGbUA3NRcyC818vJf8XEfXwXq8PIyXn8085E5B/6PHOSxc3OzLG4drd26n/E8SFVfGjsTVymDPhZ2Vxg01zL7NxOVh3LFapU07YaJWuXIRmOc2tU9bSt2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7371.namprd11.prod.outlook.com (2603:10b6:610:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 28 Jul
 2025 15:01:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8964.019; Mon, 28 Jul 2025
 15:01:47 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 28 Jul 2025 08:01:36 -0700
To: Marc Herbert <marc.herbert@linux.intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, Dave Jiang
	<dave.jiang@intel.com>, <tony.luck@intel.com>, Gregory Price
	<gourry@gourry.net>
Message-ID: <688790d087cde_119681005b@dwillia2-mobl4.notmuch>
In-Reply-To: <8e67a97c-530d-4a1c-ab72-3992a6c5db83@linux.intel.com>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-5-Smita.KoralahalliChannabasappa@amd.com>
 <074f5f77-7bef-4857-97fe-b68ee9b0afaf@linux.intel.com>
 <8e67a97c-530d-4a1c-ab72-3992a6c5db83@linux.intel.com>
Subject: Re: "invalid agent type: 1" in acpi/ghes, cper: Recognize and cache
 CXL Protocol errors
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 403bf97c-09bf-4c44-23f2-08ddcde7acc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkdXeXIxU1JxK2dVYytYSDNsOVFOUi91c05lN1FmNXp4QjJCNG1LOWZRdjdP?=
 =?utf-8?B?cTJGMGdKRmFoTzNwRXBPMUx3WXZjUGdnWlp3RVA2SDl5SmJBVVVCY2h3SVRk?=
 =?utf-8?B?NS9DWGRRWThPYVh3NnIrOXN5eGFsSlRJVUo1K1JKM09rUWFrNXdpZnNCRFc2?=
 =?utf-8?B?ZUVZTUlOQzZYVjJPUnNudTdFbjZxekxmVTdudFVBY21xditFdlR0SGtob3B2?=
 =?utf-8?B?a1RGcVNRMExiU2piVWNRZHFqWi82VjEwR0NyWmFaRm02WVo1OHhkQW8xSjQr?=
 =?utf-8?B?VDlneEtCcGJWYkx4WWdrdzFtdFczNVRTQkZkWjJnbngxb0NMalVvalFYYWhL?=
 =?utf-8?B?aWExWGZuTFIrQk5RYnZXaE1qSlNPSVNManVRcXgvekljUEx0MG1ENkJScFBM?=
 =?utf-8?B?UWo2dGk2aHhzLy92N2tvNjU0bEQyaTlGY2FNRnFPSVZRbXM0RjhFU2ZFQmVF?=
 =?utf-8?B?a1dOVGdDY2NWUFdLaVI4R1d1RHFzYWc2ek53WjlaYjVpNmdQYmxOUFNtaHlp?=
 =?utf-8?B?RHUzKzBycERMU3F1TThadnBFaDBmZ1pFV3JNbWF2MHY5aWFYZ0o3RXQzTWlE?=
 =?utf-8?B?YnBaN1dPSm4rSWJiRWQ1c3duWWg5UlMrcE1XTStOc3VLUHV6VDlwcDBrYnVr?=
 =?utf-8?B?TndXNDZGc0V1c0t3aUU4cVFaQlVoOWxBbHpWVEZReCtaRk9KQnRBRU9KK1ZD?=
 =?utf-8?B?NVQ1M25Dc0NZUFk4QTBTcW1FTmptYmd3cHQyUjljUG95cUJ3VjBvd1BIN05i?=
 =?utf-8?B?dWVaSlpWNzR1NmNRUVM0dHJJa3U1VUg1bzAzc2xZalRvM2RSRUx6VWk5WW5C?=
 =?utf-8?B?Z3lFWnRpeGc5WGlYNEdGSStkSis4S1NzcStjak5lRXRyVm5KbGNoN1lQK1Bo?=
 =?utf-8?B?cGxRZTVBNU00VCtTVnVsQjU3R3Azem53R0M3bVNwT2N4YnV3UC9iOEVqOFQr?=
 =?utf-8?B?SVBVTDlhbmtvT1JKazZmKy9LQjhWSk9UNlR1TnZpd1dUZkI2em5YYkVTbXN4?=
 =?utf-8?B?RndxK3hMazZSbVBhSWQzZW1WSHhSRHQzcnlPbEFUdDh4bnlRSURBaGM4ZHRK?=
 =?utf-8?B?YzI0cXNwbURiLzJSUUwvVFdRL2VrNngybFVHdDg0MElRdjhiRW45NXZPdVhR?=
 =?utf-8?B?MTZhcmtSV3I4OTRDc2Zoc2FGR2VLZmU5MGNUNWFnSTU0Z1VaTTZWaFNSZGhD?=
 =?utf-8?B?a0pCQmw4SUUvQkNaOHF4WkxsSVlpM3pCTFJvVkNLZkhFQ013M3hvNHBmcWhP?=
 =?utf-8?B?VHZwMkpWVFgwMlMzNHZiRkhGcVpwUnI0OHYrajFHQ05yeG0yV2cyZUNYWHRB?=
 =?utf-8?B?U3pNbWpxc0Nja29Qekd6WEhnRitOOFg0YTJHbmpPRG00eHZEUHcwVzZ4ZDgz?=
 =?utf-8?B?VTlCN0QreXdjU1ppM1dad1dIWlZyQ2ZuVkFUTGZBN1BnRmlBZDBwNzFHSTht?=
 =?utf-8?B?L0x2Ui80TkwvVlp0endlS2xKcTJLOFZDcWRXYjVhMW0ydGFleGthMUIxRHhi?=
 =?utf-8?B?WEVyV0tFOEhzZUxSRDhXa0NJelZTZ3p2dy82TVVycHk2dXpIci9Qa2dBWERj?=
 =?utf-8?B?OFM4ZC9DSjVYYVZVNjNwL3Rid1F6Wkp3VWZaNEVrbkRWYU1vVjl3U0FFNlly?=
 =?utf-8?B?ckJzcVZZYytrcUZ5cnVnMFhlSW9FRWlrK1hRMDZEalhRZFhoMUVWSFhQSWdR?=
 =?utf-8?B?ZlZzWXFmWTVSN2Y2M3ZNYUF2S0pEaHpNWjhXRzdzQmhKNmJKOHlkc0c5Tk1r?=
 =?utf-8?B?b2tIWUZGR09xM2FoUXBpa3QybEQ3b1lZTmEyTzR2SkZ0a2hrQlUrYy9sM21F?=
 =?utf-8?B?RitNZkVHQWEzWHVDMVR4NzQ0ZVR2d2FXa1Q3R2lkeXozSlBucWhsWFhKdmxG?=
 =?utf-8?B?bm5XVXhuNjRoRFRBSU83UHdWbmF4cXhGOEhXdlI0VVdraGVKNElqenVHYTd6?=
 =?utf-8?Q?r3AY2P//Mcc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFRwSTgvZ2RmdlF6c1NHZnpVcWtiUFR2em1NRXdYS0hEc28xdlltekJCMkV4?=
 =?utf-8?B?UFJ6Z2ZOL1NNSVJoVTVFdmcwRG5mMVlWeDNWNllWVFArdlAwRjZEbmJRNVds?=
 =?utf-8?B?NjJLTFpNcmtjYzhFVE9XZlFnK3djNmdENHpCOWZTVEhFY2o2OEJ1M2E5ZEg1?=
 =?utf-8?B?ZlVtNllPK3I1WUdlL0tnZ0hiU0FpUHJWOGovaDFFVDlIRHlZSWxmZzQ1WXk1?=
 =?utf-8?B?RFlzUGdveDFvT3ZrMmsyWGNMcGZPL3JaRlBUc2ZTTzVVNmNEM2JGUEdLVmVq?=
 =?utf-8?B?Qm43d1BiS0c2WnZ1dVNxTXRkL2hMK3Nsdlo3Zm9jNEQ2bDF0NmEzSUcwWFUx?=
 =?utf-8?B?MWdrMlIvQkM2Z1Z0eXE4TU5jR3RLVmMzc2lWcG5lRWFla3c2dHBjdU1DUTl3?=
 =?utf-8?B?cVNzcXcvOFEzUU1TbzUvMlZXVWo2U2dNQ1A5M1FwSjJyejVtRElNZFV3bFlJ?=
 =?utf-8?B?QUsrRyt1eXQ4TnZHNEVvOXlCSXhEZ1EvUk1hVEJvOWwyYUpXK2FxQlJoSWF1?=
 =?utf-8?B?K25FSUVvbVZnTmZFYzd5MmdRamhKQjVEZUoyT21jTnExZldCeUJoME1oNU9m?=
 =?utf-8?B?SUlmdFlsejNUWXF6Y1g5YXJCLzg1bGFCREs4djhVUkhJZEJnM24yRjV2eFYr?=
 =?utf-8?B?QlloNE4vT3ZvUU9EaVJGWEFXRjg0ZkhMS01KVW1sQkoxVklMc0UrblJzdWxJ?=
 =?utf-8?B?NkVLUUswdWk1NXBIZjkyQzB0ZHRyN0dpUlRXckFNemRpWW1PWm5LUDQwUExH?=
 =?utf-8?B?THBUQWpsaVVOR0dvakh6QWoxcHd0NENPdmw2cE8wak9HNzY5MVlSTGVHa0dB?=
 =?utf-8?B?L1NKNE5McnhiclFUTU5aUmZOOWJiZnZ6N0VDYkdHT3ZBbnhqc1JEczdRT0Ro?=
 =?utf-8?B?TnJIVjBRSEZ3dVdQRHFNZzdZeDN5eFdtTzlvQlkvWXQ1TlNqZlpBalYvSXFz?=
 =?utf-8?B?NkQ4c3RxVjNhdkpxV1FxU2l1VFE0UlpKcWRjQXdRY3lZRTByanMyU0hESlRx?=
 =?utf-8?B?Z1FIRzlLRll1c2VtbmxPRTB2d0dwUkhKb2pTYTVjNUxiM1NsTUZRWmZaMXpz?=
 =?utf-8?B?cGhpTmtSWVEzV3l1SWUyQWZZV3VkZVFoYkx2em8xaHRtZjJoTzJjR1h5NXZk?=
 =?utf-8?B?aDlpVk9uZVowNlFmUURXcmtkUlpsd2oxVGxBSUxSMzMrcEgxVEdwdXhVU3B0?=
 =?utf-8?B?WS85dW1manRESXlILytpSTUxZ05zUzY5RkFJdmtNNXZ1OVN4RlJHOGJpVWtz?=
 =?utf-8?B?MVJNbW1MM0tNMHdUUzZyZ3ZTSnRzcjFsMjBJWGtQS2prK1FSZEFuaEVycnlL?=
 =?utf-8?B?YVY1T0MzN0pCQmROcVJkNnY4dE5iOEZzNWM4djFZOEZJVWlFUXJtOExwMHda?=
 =?utf-8?B?Z3UxNHM1dzM2YWFUVzZtTE5BazJTdWJqb3lGK1FidHhYcVAvZU92eVdjQzhP?=
 =?utf-8?B?bHg3RXFRVDFvZ0tDWGxEdUUyVkxGUDAwMnhHYjFBQ1NtQnRzRjZselpHUXVt?=
 =?utf-8?B?MDBlV2V6NDJsNUhwR3J5TzN0azNlVlRKWjJpQUl3SnVIZDY2QWFkZU9pWGdB?=
 =?utf-8?B?WmZzUlhxVEFLVExsV0poS1hkUXhMVmE1eWlLN1o2dEdmNWNzSTU0S3lML3lr?=
 =?utf-8?B?bnUwWS8vTGhJc3VGQzcxMG5BTUN0dGs5MHZsNnphQk9WSjc1cEJjSFYrNTZ3?=
 =?utf-8?B?cTRDYnJ3NWhCbUNNT0NFUkE1eTgwZTE2OEhBckNDdzZRQjE1UDI3QXdjeXlW?=
 =?utf-8?B?cFVwcUVLbEhrZHp5Y3ZoZTlxWWdTYnEzaTlqTlpQZTgzcUtpQUdOVk1pcUM5?=
 =?utf-8?B?YVE1aHpON3VnUmxJbGNneTBQQXJkRkRuTi9Jdkc1d1pTSXRELzJBT1NaS0lu?=
 =?utf-8?B?ZGFaakJKRWxTZjFhSkR1c0djTy9ETkNiYlNtSFdNS0FudzR3MkJ1S3FaOUJk?=
 =?utf-8?B?cWliTUZOWi9WNVIxZ0ljUEZycmsyejE4WHkvS2NvTnh3RHF4ZWcxbG5mZXdx?=
 =?utf-8?B?YitiRHorSmNTV0pEZktzWW9ZNGlka3UxT29wemtXOGFnL3N3UnRMZFlsVEpS?=
 =?utf-8?B?Y3FwblhCZGdlcHN4aC9PNnNqNUl1YzB5OUpGdnFXbElBYXJQbTI0eHMwVFNP?=
 =?utf-8?B?OUNONlJiU0RnVVBMTmxVR09RbHc5elpHdUtyTzBEMlRKQTgvWVczL1p1MGtt?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 403bf97c-09bf-4c44-23f2-08ddcde7acc2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 15:01:47.8571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcZzBHFhvzC15FFeOZHM+fFEpPi+8MHQfJnkYIz46ChI1/9Hxi93ACbsUva9FlNTpKSKuzyC9gaWuCrf73DWBc1OgZfNbnV+xSncIeKONBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7371
X-OriginatorOrg: intel.com

Marc Herbert wrote:
> On 2025-07-22 12:24, Marc Herbert wrote:
> > Hi Smita,
> > 
> >   The code below triggers the error "invalid agent type: 1" in Intel
> > validation (internal issue 15018133056)
> 
> The same test case also triggers the other, warning message "CXL CPER no
> device serial number".
> 
> I heard that "device" serial numbers are only for... devices and that
> even then it's not always mandatory. So maybe that other message should
> be downgraded from warning to the "info" level?

Agree. Care to send a fixup series?

This is a benefit / endorsement of your test updates [1] to catch
unexpected warn/err.

[1]: http://lore.kernel.org/20250611235256.3866724-1-marc.herbert@linux.intel.com

