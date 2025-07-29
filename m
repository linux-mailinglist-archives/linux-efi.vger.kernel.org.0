Return-Path: <linux-efi+bounces-4499-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 829CCB15229
	for <lists+linux-efi@lfdr.de>; Tue, 29 Jul 2025 19:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A532B189CC47
	for <lists+linux-efi@lfdr.de>; Tue, 29 Jul 2025 17:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0499E292B5F;
	Tue, 29 Jul 2025 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y3gtxEj2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB8D23DE;
	Tue, 29 Jul 2025 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753810804; cv=fail; b=Wb2MTJYWDGrtjP59Y5l2k94Ofi1x3t250hWj2ivXLCZob02XhtneDXz1xn65/kIVDMRxJVfA9kNLBbRuKu1/1hZiL+k/SnO43zAXMeNWocye5q196xQvR2ug1CeF8zarES9whrBGA+bKub1ETrNzZH6+ql2CWONTkyN3j3ZUYhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753810804; c=relaxed/simple;
	bh=8oICVhN/hUDmZcstO+SAtw5LHNspf4Vtgbd3SeV01lo=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=AGW6Bl0lwd89FFMpOoM6BNHxqe2Sw6c3GiTTvA2HuuKJFsGQO67ZFbcEdkMkV/BwWIoB2WIe26w7f01kUqk4U7s2WtrGcLOT+RFcdAQO953RA5DswyKhPANwDVFJHoflr2laFqZNc9g2by2yD9muJj7m4JCZBXIzwm62y9JlFVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y3gtxEj2; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753810803; x=1785346803;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=8oICVhN/hUDmZcstO+SAtw5LHNspf4Vtgbd3SeV01lo=;
  b=Y3gtxEj2k8bhGcDzjv+KDQ9No67N2xzJxEb1b133wjgPs/+4HwlA1zXH
   VWV5lnHMbbiCRyNQAA7ZX211Jv5A7Q22awzwp1HJ+8oxCdTxtVdgbX2nD
   KEVJ8yP2JNSWD/FOfIbnCcrniDNvUGX6yVUkqEGMu1Mngd9U/eFppsisd
   dpEui1p2XEwyWYhwk81w+HWNcHm7xm/dKiOLTsb7YvROamb3HOyr90Ed0
   yfOg93NHK5dL+qd/5/df67e1GxbGQK+4RH1Tm7DpOqgDuZiwhTxlikUnX
   SUC/fRJN+uA7GuWPpA8TJDzw2WdQduYHFDA947bZvaGF/vgJrjYtrJ9Vh
   g==;
X-CSE-ConnectionGUID: R7FmN0mHTG+51e9G1Ic7nw==
X-CSE-MsgGUID: rgApeFxJRaGQxsnOIHm0cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="56171731"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56171731"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 10:40:01 -0700
X-CSE-ConnectionGUID: wdgXvbFyTsyCiPgR5lCZYw==
X-CSE-MsgGUID: r/TRRz+PTF6ooizrooTazw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162480393"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 10:40:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 29 Jul 2025 10:40:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 29 Jul 2025 10:40:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.84)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 29 Jul 2025 10:40:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqAUk+RGK/dFyd2FovaHSbRZdlGQcTqy97Ce0aHygpf0DUkc0eINYOhgmJOGaEHvlGTmk6DawfSi7s1uqolA6gcUgCR9EeQCoT+V/2E8UUQdPOVbSPsYpFYSrrW7wh4GKF6cN3A1KmIDdIU5dVhTtiSWxlfvUk2qjz59QJlNdfsSNSJxmHA/umfpv1JKycmifN2nqg22jjLrYfr4G4RBVvMuYIzJMv81RnN+bw1X4r8B4Mkp6f3srccVnN9A8sBqSs2RjwqCLaPLLbmYEABWPwIcMQKsHTLLHwiZeidJtcWn5brB+iH3MIwi3TdPPbbaNrJWZbz30vW2/7dplJHD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1cVsUYJiS2sb8x9jNHiq/PS9fX9IGpNEE+V8gIQZvI=;
 b=MDskcn/52SR/mSp81G4+ezcvUYJwzJEX9/heaKqaMGbGSfEsF3OWN4riRVxuHMCsP0wxI8f7UCPsijvz3m5ctn6ujE/Acem4o2yt/1bv+4VeZSd7on9aXAS57IqDMz1FxwA5KAGdGq6Gj+5mbMX/7ldFfP4TULt4rm1k8O3c6Jpiymk9dF0MLfpX3RkTIYh838F0KbZqRQw/772G7JsaIEf3wuHGDNtKOgfcN+MGO1IJhp8IdEugw1OzZIWhsVmI0Ns6sN2QPeNi+fL4bNMZSPUXumxrkMXG5BJt+dwF7cOMzYAtmLTc3YM1m+C8S5aBIveldy5LHPsamMybSx6Lkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by PH8PR11MB7021.namprd11.prod.outlook.com (2603:10b6:510:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 17:39:30 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%4]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 17:39:30 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 29 Jul 2025 10:39:27 -0700
To: "Koralahalli Channabasappa, Smita"
	<Smita.KoralahalliChannabasappa@amd.com>, Marc Herbert
	<marc.herbert@linux.intel.com>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, Dave Jiang
	<dave.jiang@intel.com>, <tony.luck@intel.com>, Gregory Price
	<gourry@gourry.net>
Message-ID: <6889074f38d5e_48e510076@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <5c052302-8639-41ef-9d51-3814f2778674@amd.com>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-5-Smita.KoralahalliChannabasappa@amd.com>
 <074f5f77-7bef-4857-97fe-b68ee9b0afaf@linux.intel.com>
 <dfc6cedd-c125-4201-a98b-cbaa84a4f370@amd.com>
 <ef9c9418-2def-484a-89fb-b0235391ad83@linux.intel.com>
 <5c052302-8639-41ef-9d51-3814f2778674@amd.com>
Subject: Re: "invalid agent type: 1" in acpi/ghes, cper: Recognize and cache
 CXL Protocol errors
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::31) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|PH8PR11MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8edda2-7d0e-4f36-f306-08ddcec6df21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkxtZDdWR3J3NUY1QVRFMkx4YnYxaE5xcEcxdjV2Q3A4L1ltY1BhbzBZbGNV?=
 =?utf-8?B?QVhMQldwbm5SaTJmZlNKa2dDR0djamlDeFNOaU1UVFd6bXAvclRBU0ZpVDgr?=
 =?utf-8?B?MWFaSU9tZGRuc2hyb0oxZnNMcHN1MGloY3RRVzhQcVQzMmNjM0g0TWMzL0hQ?=
 =?utf-8?B?bWxsblJ0eUpGTmRvVW1FRy9vWU03WkN4SFRDT1Z3cnJlUzlKMlU3dVlQbWVC?=
 =?utf-8?B?di9neFJNRWZ4ZHl3dEoyZ1FySzliWFFCWmlFWFdtcWllMStuVnhLYytoaXkx?=
 =?utf-8?B?UlFsRG9vRkt0eTZ5T0svSVkvNS93cVZnRzNDRDJ5bjFLdmhPc1lVMGcwYjEr?=
 =?utf-8?B?MURFTE1oM204MGo5L0lweExzSUxGSlJQMVdTZWxRcnJONkU3c1VNZVQ5bzI1?=
 =?utf-8?B?aDJWVkxVNDJ6RnMvU0ozV1FPMHJsa3VESkZxRXZVYktnUXlabXM2Nk4zSGs5?=
 =?utf-8?B?OUlFTVl5a1lqaUh5MFpNZkQ0UDhKUDlhTHZNSDlZV1hwdVZVTkVQL2VMZFly?=
 =?utf-8?B?VFRmNTBqYkN6OHgyc3JNcUFuRG5JTU83dElOSExQbDFZTXQyam5GT1pzRjVH?=
 =?utf-8?B?RnBCMkZCZkNYT1BVQ1pTZnh2TE1nT3FmYzFDSnp4NDQ1VDlibHBHZ0pTeHNz?=
 =?utf-8?B?WFlsaXQ4WXZtMHJMaEdUQlhSYks1eFRMT2NBbExUZlI1aU5NeTZTb1VmcTZJ?=
 =?utf-8?B?WWhhTHBKaUtsMC85UU9xU2ZzNXU5S3lNNStvK1c5OUw5R2dEUUFYYTF4QVpX?=
 =?utf-8?B?eG5XUVhuTU1TTWorTW94bzRGL1EwanJiTTlNb0dhaXNFQzAwMXVxQ0tVb0Na?=
 =?utf-8?B?NGhWQ3NJQ2U0dFJtT1QxL0I1TU40QUVXZXR2b3VyWFhjYStBLzNWd3ZPUC85?=
 =?utf-8?B?eHMwTjNJaUNvVFNhdTNaMW8xMnlMbjJ1c21ZZmlXTWZ2bkhlTDVGdmRvSDVj?=
 =?utf-8?B?K1pubkVzREhmSmVXT1hFL1BZa0hDNXE5VFpvWHloRTRadTJFV2VmNWdFUEJn?=
 =?utf-8?B?S1NNU1JSZlFONXlQeSthR3BhRmN6TU02a1BRM1hMQ0ZKaTREZ1hpSkVieTl1?=
 =?utf-8?B?VUdtSG1FRGsycmpoU01qWXNVdTdNZFYyaWRzRVF0bmZuTlloZlowTjA3M0xO?=
 =?utf-8?B?WmNJS0JCK0hhYTJtN3VGNXkrMGpaajVMN1h0OHYrU1p0UmthOXNIY0RCLzdz?=
 =?utf-8?B?U3Uvb0ZXNlM0QzBqenJMejRhb0JLVFIyajltWEZveGl3dWhXYzNOTlZtZzNP?=
 =?utf-8?B?cUdFQkFlYnFsWmpFbzVLNk5GZEdvZTlpajZzS3c0b3kyYzJOUUdoVGpxL2RG?=
 =?utf-8?B?Qmp6Q2tNdHJRcDltM0xSdFF4VUtJV24ySFNIc3d0eTBPejBubW5LVVBNRTF5?=
 =?utf-8?B?T1UwNlltTEk1OFJibjhUY1BDZWZUNG1jRHpQN2daSVRSeURFd25MWXRWanAr?=
 =?utf-8?B?K0FTekZiTkl3dGwvZTFZWHBGdHVQSVdaNDFVeEdMaE13MEhMTXJEb1NJYUhZ?=
 =?utf-8?B?c2NFOEdaNTRlOVJNUzFCUDF0RDNYMkljMHRPNngwdWRRQjlMd01Iak41WU1C?=
 =?utf-8?B?eGtvNkVWSjcvSmQ5OEJpRVdDNHZRbmEvVWQreFkyZWxKeFVwcEZBY0NGUWJM?=
 =?utf-8?B?eXk3N1RmelJEYUtiZWJMK3M5TXhreW5uM053c0htc3A2UWdNc1d5S3B3d3JK?=
 =?utf-8?B?UFBiU2Q4OUpjMXBKdWc0SzVTcXlXUmlTWUltam00RS9Rb3dUaHZTWXZwbE5m?=
 =?utf-8?B?Z3NzRTFVT0l5ZERJbUllb1Mwc0VSNW4zNGgxck55d2xKUERZVkluYmlOU3F3?=
 =?utf-8?B?dXgzc3d0dGtwY0VRZWJFdVlvN2hVUTNMcnNmOFNyekN1ZThMYlRxejlNM2gz?=
 =?utf-8?B?ZGpRVU80RFdxaElBSUZuTHFQdkQzeEpCUmFIc1JoMUlsZnEyZThiSmg4cnZi?=
 =?utf-8?Q?8wzbj3I2p7U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0VZVWRaZGVTNjhCQjNDdWJBdVdnNEV4SzkzblNZUVpCb0hiaGd6aFRSOU9s?=
 =?utf-8?B?ZmtuUUtJQ0FWTFlDUERwYzdIMVJQU3RBR2dvR1ZteENIZVN5MGVzdEk0TDJS?=
 =?utf-8?B?TkFiRmx5aUVMK1U0MjZ6TUthVFF3a05EYmlWM0h1QUtlRVdRc2k4aGpTQThH?=
 =?utf-8?B?RnJUK3o5THE4SGY3d2xMWXFHYytYeHBPVHJFczFweGRCTEVwTzY2Sk10bVQr?=
 =?utf-8?B?N0ZHS2puSDRJSU9oWjRMMld2Y0RNVlJ3U2ZzWVM5UEF5ajZWcEJjdys3YUhJ?=
 =?utf-8?B?Q1p3RUMwdnJWcDFHZGd0UUNpY1pUVlpwSHh6Rm9WZFdpYTBYbDRDdkZlS3Bq?=
 =?utf-8?B?ZHRvZUpNTFRyQm0zWFJOZE5LMEI3Zk1oZkxqR3lPNDRnWEJ6RHViRnRMRWFq?=
 =?utf-8?B?MnFaVDdhMnpPS1lkVkh0T2puY05iNW5PQnlsQ2htUVI5dkJXcVRxcExKb3BM?=
 =?utf-8?B?WmhxbUtha05UTGRpZmdOcUE5RVZHYm0yY1QyQmJiRnNBRkNPQUZrWXRUZUk4?=
 =?utf-8?B?WWMvQ0JFQlVKWlN5Z0xtUFJueUc2d0RQY0xGYlkwUXluRjBRbmFYaENGeFNZ?=
 =?utf-8?B?Yk9PZHJ3L05Da0RTbzV2UHJzMlRPcnpaNWE5RVNQTHlXQkdudlRNUGRSTCtB?=
 =?utf-8?B?UHhuV0dRcUo5bzM3bUlEMXZnc25URmYxNDBBZ2pZcVUzWVBOY1dLN0dMUGhj?=
 =?utf-8?B?bkd3UWh2VDJNNElLM0lxTTBvRkRLKzI2TG8yTE15OElUVjBrc1FFWnViQ0xL?=
 =?utf-8?B?d0YycDF3dHJjK215OHovL1FmcEZFUnBYcG1scFNOTEdnN0JyVDJiejZQR255?=
 =?utf-8?B?R3p4eEZCTUxmSDdhNFhDNXFieUl6S2ptTEFnWERmYVdNZGkyUytQQm1WV1lO?=
 =?utf-8?B?ckZXWWptK2tLWHZoS1R6eDBPaStqVTl2UTAycXh2ZzRkeHMwbVdoUS8wTEI3?=
 =?utf-8?B?cVNPZGdHdmRsU2N1MUFvc0lUZk1rQWpPdmN2L1VkQ3lNeWdLRm5HRjM5Z0Ju?=
 =?utf-8?B?Y3ZXWkEwWHkzZWFwTlU2eGk3bndzWG4xYjRseG9aMGN5elNRd0FsMlZMelRq?=
 =?utf-8?B?NkM4V05mZ1laRDE4d2FCRXFRc3p5eVFldlptMWNNTXpwaTJRVzZNcmM4YTh2?=
 =?utf-8?B?WitFYzlLWVpENUlKUmtKRjFNNW4wY3BOMVpPYUxFdlBFU0hHRTJzb1NRZWZ5?=
 =?utf-8?B?Y2UwTkFEZUZtLy9DVlJtMUVtK0RqNmZKUERHU0RDSk9HVzFuRmc2L3JlVXJO?=
 =?utf-8?B?V2JDWkFjZUVLMTRUdlJ6M1E0NC9hK2NuTXZGTFBpempMSm1rTnRwMHBVOURC?=
 =?utf-8?B?aGM3QU9EM2RRc1c2K21EaFNlajU2eVB6K0RwUkhuUXVhU3JsMENoVnRsMEJ5?=
 =?utf-8?B?bXJyakxzd3I4SmVSeGQ2LzEvREdOM1hENkN1SXV6Yng0SzNPeWZITERMeFFL?=
 =?utf-8?B?MGYxUm9SWEthdWNhYmFJMm5HVmtQS1FnUXJQU210amF2Wm1hNDJTL1d1R3BQ?=
 =?utf-8?B?NGRKczVnVkRGNks2RnFXb0FSTWloMXRpOW5xYnMvMTlSWndwOU00MlpnWi9Z?=
 =?utf-8?B?RlloQTdzNFYxcTdlVDRxVTk2T0NnMFBBS0VxNmt5eVJpS3BYeGFkRTBaL3ZY?=
 =?utf-8?B?NG9mRk1ZV2tIZkR2N29YdFZVRVV4Tldpc3Uzd3Zxb0tkdUJnU0VLM016bTQy?=
 =?utf-8?B?TEtEelpvd0YwQmxsMkhnR0I1K2FQcW5ITm5pYVNiTnRML2FLNFBySTB6Z2xr?=
 =?utf-8?B?RGZrdGh2SWNQWEJLWXh3djZJSm5YZ0g0a09LN0ZnUURSNytBU204cDZ0RklT?=
 =?utf-8?B?YmpFTWRvRk93aDQ0ME5qaDExRjBoU2oyVEZidGVHbnlCRVFETUw3Zjk2VjMz?=
 =?utf-8?B?Q0QxcXcvQTBDVWVGWW1jajNwUEdFQm9UeDBFbTFPcWxZdVpRS01HUEhBZy9O?=
 =?utf-8?B?aXVRNTYrbkRlcVRCSWF1eU5nQ3pMQXFHdisrUVVKYkNvYzd6bXRiei9maGVV?=
 =?utf-8?B?RjJvTlJBWDNwTmZWSWIyUCs4UDZpNzVLcUNaYm1xNVEyY0dHckNQaUZVOHZW?=
 =?utf-8?B?aC9CNVB2dEJGUHFXc1pSSmZZOStkbzhRWm1aRWM4ZGx2V0h6eGVVeHRXSSt2?=
 =?utf-8?B?REtPc0MrckYvdmk5MDgyU3FlQW1BclY1cERnaS9MaWVYRTVVcEFab21lMDRj?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8edda2-7d0e-4f36-f306-08ddcec6df21
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 17:39:30.1257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6m0pRFO2SFVwMPkcKKTHDAvQlP55n8oLGILMyxBGplbSJahzZDcQzRlETrFMaxB20x0tgOn1hZqkqk7cvluJyV1/k6JQzuNwXhgS7u0roGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7021
X-OriginatorOrg: intel.com

Koralahalli Channabasappa, Smita wrote:
[..]
> >> I agree that a brief comment explaining this rationale would help. I'm
> >> okay if you plan to include a fixup for this along with the one for
> >> the device serial number.
> > 
> > If I understood you correctly, I think a different error message
> > would be much better than a comment. Like this?
> 
> Yeah looks good to me. Thanks for fixing this!

Wait, I was thinking to delete these messages. The rationale being, why
continue to harass the system owner indefinetly with the fact that their
BIOS is emitting kernel unsupported CPER records? The value of that
unactionable report is look. This feels like dev_dbg_ratelimited(), or
dev_warn_once() at most.

