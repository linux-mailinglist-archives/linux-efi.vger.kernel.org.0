Return-Path: <linux-efi+bounces-5020-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0936EBCE53F
	for <lists+linux-efi@lfdr.de>; Fri, 10 Oct 2025 21:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192CC19A6A83
	for <lists+linux-efi@lfdr.de>; Fri, 10 Oct 2025 19:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CAF214A97;
	Fri, 10 Oct 2025 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HQwRABaU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F13B34BA53;
	Fri, 10 Oct 2025 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760123016; cv=fail; b=NhSl9a9gXQRsOSCwZGsRw6ph2mQtJNl6Els+ElJq7hwe138uyDjE4P8FWpBXWJYGk0lg9Qzgx8hwza9ZptZT5zM8nxZ1DgCbPn6xby7aXOdt6CPH2rn1x3ez/g0Hl5JSBc/iOULQE7SrMnF6XDwCA+Qp09twE87yOPZdVZIwMl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760123016; c=relaxed/simple;
	bh=JNBfFETD0/tLb/NrqrJl5WSEHNLMt4CvBNVGcv7EHks=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M1jR9L227lrY4D2uuKwPq1i044b+NPCDBfHlyWeq/ufgqZcVJK+N2pKaEFersqZWijoN4bElesTXoWkUe/26ru0VQvurhyAV7OHWEKmIagSqEvyunyvQhwYm4IVfraoZgSwSde7CBNz3n2jM3grJwM4kFn/19J3fzfG9Eya20Zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HQwRABaU; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760123014; x=1791659014;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JNBfFETD0/tLb/NrqrJl5WSEHNLMt4CvBNVGcv7EHks=;
  b=HQwRABaUuPj7jWRVUWXVGZQiYUntcE7XvnTqyW9xUL3Bnj6wNXBKBBGA
   L8gFGH9ASqOPEZhv4cpkd0Abql29vDlZhFOjz9w8rIWWfzxU7htof8diH
   +HsNrS2DGOLpUIEF0vc7s26hyM242V/w+PSmOyrgCxxQ5tmY6s86dl2Dn
   4YnligZS2GU6nhfrYyxzkDFrbwQbWChKSuc4wecuVnECT6U49JLel3p3y
   Vu447ejC+IvqiVXka4VJKupk4ZF9ZQnmrDWXkDb6MfjyNTwuiXFGc22+W
   yqmHG/DxPqww/d/XhZ/2dxiQk97EUMT5c/33oQ5Yggkj1ScUKc7InCenw
   A==;
X-CSE-ConnectionGUID: JXCkLZwkSL6EF3FVV7O1Kw==
X-CSE-MsgGUID: IMMoGdVZTDKubbj/haFKUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="72602392"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="72602392"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 12:03:33 -0700
X-CSE-ConnectionGUID: uR+Z4/qMQIGgVJ7PhvKMKQ==
X-CSE-MsgGUID: inE2vF1qSwWZK0geo7t6WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="185067248"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 12:03:32 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 12:03:31 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 10 Oct 2025 12:03:31 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 12:03:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAV4vqq+asezVnQn3Z9Qq4VD85dbaeNC35BmQ7ed5hWK7qTISv+Oy5e7ANOvq8T5LGMSBFfbX40rfzTsbZPeUS2bjCOP/KHPBljcFTYWggsiu/usFFU/xJ8ArC71oUXYxp7lgNAvdtgQQmJPLTaVJ43dcI5UQVukI1b9ihpFEswZwEQAK6x4xWQC47MGJVBzC0iV0cmFxH8uG+XYV9MHEqcDNA0wgxF75fHJtiDSIIcHzRUqNdQum3X8PfBExjOFi3zhNVVAetrLb4aTf49unGKB7dTNVX/KJD4puvIYMQEQtETwyudE3YW9u0Y/F1J05o94c+mwACloGJ8FcAEA/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyQZxPn1wuRc65SQ9bL0Aufi/j8fdhRehR+6o/JshxQ=;
 b=k1+D0AoonWZC5gLfKfmN2aQumVrP86sHkgeB7S1BKqEXA8rbqqkeLNpq9ASiwTWrOX7ASGB6+0XGzSDM+zF5CKNTLXEzEm+D8LRKrbWS0QszFfIUni91zmMlUen+ldPIeaJngq0qeAk/B3cT7903O9YlhHUP4vuqVCboFz4pF18TfgC2NlRHQpUGEEYd6CLMXYeBjbXDvWG+bIAzI2lROeGW5zlF2JfmnhFOuKGRGxsfTqoh3QtHSfR+bZLysSIkiu9jDYSzoNl/LvdoNFHzxSZg8UkdikxyFxmJzFGqakZwbV0g8dQ5mESwYZXjWFpZtUDAnvezl66MItQkmEzBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by MN0PR11MB6232.namprd11.prod.outlook.com (2603:10b6:208:3c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:03:27 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:03:27 +0000
Message-ID: <2dfba3fa-64f8-494f-a4da-46934f21d10d@intel.com>
Date: Fri, 10 Oct 2025 12:03:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/15] x86/cpu: Set LASS CR4 bit as pinning sensitive
Content-Language: en-US
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"luto@kernel.org" <luto@kernel.org>, "david.laight.linux@gmail.com"
	<david.laight.linux@gmail.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"vegard.nossum@oracle.com" <vegard.nossum@oracle.com>, "xin@zytor.com"
	<xin@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-5-sohil.mehta@intel.com>
 <e873d2b06a18b69e246f8011c556259d21c7e022.camel@intel.com>
 <7635c45d-97b3-4773-95db-e61ad872ce22@intel.com>
 <66212761b9ef76b209e83e08c9258b76f51dbebc.camel@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <66212761b9ef76b209e83e08c9258b76f51dbebc.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0286.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::21) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|MN0PR11MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 1514ee2f-f23c-4e58-f6c7-08de082fb1f2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzF2UG8yenBVV0pDT2dSSHRKand0cXhpR2drQXU4bWFUdzlYeWxlMGl4QUpt?=
 =?utf-8?B?eGhOQm12QVJhSWs2NXpOajNCQjNIL1U5R080c09pWTM0RlU2d2l4cnVNRW5T?=
 =?utf-8?B?QjJRa0lUNHRVa2U0NEZtTUlXdjVhb1YwOUp2bGR4aGE4cm5zOVNjdjRtbHRs?=
 =?utf-8?B?eksyT1d0RmhScnQxUjFoWTEwQ3pTZ2R4ajVQY1lzdk85NHFoWU1CUVpNTU5F?=
 =?utf-8?B?R3J1TmZVRTVLQUxPYW9VTnJkUVAvbERUYVpMT2Z6RnROYTd2R3lHL015THFi?=
 =?utf-8?B?dlRuRE9EQytQaXg2RmtJYStES0tJQ2tBdkhFUjVINTRNOGN0WE53MlRVOU9w?=
 =?utf-8?B?eFl3YnVOT3FOajNnUVdNMHRpb2NLU1RiYWg5NkFKWUt0RjdqN1ZxckNDN0lh?=
 =?utf-8?B?b2dScDZSZFRlVmFSazd4aGJITHNZWU5FcHk2L3lrTXp4bVU2SXhKOVY2N3lG?=
 =?utf-8?B?M0Q4Y0ZzaEpCZTdNRzZ6SGsrbzNoOVdDZUFJajcwQm5JR0pDRVdiSzlNclZ0?=
 =?utf-8?B?ZWg0dk1ubTl2cEdjRDd2Q0RNZmhwSWVLK0IxK0ZhVFNMK1lqWUhqdEJPbzYx?=
 =?utf-8?B?cGNOWjMwVjMrRlk3WVhWVThpUW5ldEVSL2ttdXNpSFJPWkR1b3lRSWFXWE96?=
 =?utf-8?B?MWVxbkJEVEEyYXVpYW1PbE5MUTZrMlJVTENuUUxCbENBK2lrd1lTbmEreHIw?=
 =?utf-8?B?ZkdKV0VhV3VYaUFrWFI1TWVOYm9tbGJDWFJtT2ZTbGsyMnBTUnVFUVAzT2RH?=
 =?utf-8?B?WUcrUEhYNHhPbmN1L2ExMm9OdlBqL0FaaEc0ZHZJNEpFNGVsZjlMTXQ1OSs5?=
 =?utf-8?B?WDUycWRFOXp6UEpsNlovSDdpUTVJU3d0VUZJZmlTODhBK25QMlF0ZVk1cEd3?=
 =?utf-8?B?T0tiZkJpZmE5ZnR0Q1poYlR5MkV6WFNSZUtDVzhDRjhaMWJlc1JLekRGdlQ4?=
 =?utf-8?B?S0ZsTThBem90ZHRUSWo4VFd2K1dmTmVIaDIvQ3JpeDJuQlc2ZkVKWjhKcGNh?=
 =?utf-8?B?UDdjaTNhZThNWFJSKzVNbWU3ZitjWEZzd3RXQllNVkl3ZVZFZllxYzFVaEdZ?=
 =?utf-8?B?dFVFQzJnU1I0TDBxVzd2MDJlWlNxVmhHdm14bW5pTFBXZzJSOWc4d3EvOTVI?=
 =?utf-8?B?VXZmaXE4MDhJNjZ6bUV1UzJaMitnOG1VdXJJVnBxRWtnL2Zpb0RkdXVSU2dM?=
 =?utf-8?B?bDlXWFJxNmF3RUVaeDhZZlRZaElsbWlnbHQyNkpBNEJuV2RYRmt0M1g3eHhw?=
 =?utf-8?B?Mk1HbTQ4T1graHZoOGtSWERBcFF0WFNQd3RXVDM1VGNGdVhnVUdiYUpYRnVy?=
 =?utf-8?B?c09BRGtXVENuVHFNZHZ0cWcyVm5Da2doUGJ0c3N6d2o5MGhIcENPazVuWHBR?=
 =?utf-8?B?K2pISStPWnRnbU5qVWc2Z1FHVTRjMndHUlJsTXljYkswMmkvejI2R3ZXekVH?=
 =?utf-8?B?T1g3S3hSNzM5UU9GRXoraUl2U29zeUhLSGgzWU5LWHBuaHFnRkl4bzhoSkVW?=
 =?utf-8?B?a29heGVkUHdqbDlZOCt3bGdHYTl2UWhRbE4wR0FPc1AxdTVlMUpGWXlCOFdE?=
 =?utf-8?B?Z1lvWThnTVpCajAxTjIrK05xMVBxSVhzT243eEhDMW5LUEF5V0JQWW1HQkZr?=
 =?utf-8?B?T2hiaWFYVGpJb1F3ZVROVUt5bHRrSWpzZHZGdlVFQ2kvWWNhYTNmMTltaE5x?=
 =?utf-8?B?enlLSHhtUWJtaTE3RWM4U3RNS3hybHlvYXFBdUJvZkFxZUxuMDdXR2lBVWxY?=
 =?utf-8?B?bUNNVjZyWG1EaXFLQ0tCTDlvVlFPcGxGMHNBRlhadUxKV1N5Zkkvc3Y0VDVX?=
 =?utf-8?B?R0lJZHZ0REsvUjJBMUpBdDR2dmV0Y1BaQ1VSMVVDQ0VhYXFnSUNYcnRqdmZj?=
 =?utf-8?B?aGhEaWZ6QnBtSnJBTktYa1JwVFNUalJ4MXlISzVjUXJNdVdsZmc4ZDJOYXd0?=
 =?utf-8?Q?sGtCsXYPYHqgsCfiuyt24mFKx07u/VOG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2ppZE9pWDVIWW1Zb05ySzZ0SlVERVlZWnpWTW1LTWVsTEhYeGEzd2lKeVZi?=
 =?utf-8?B?QldXYndZMDR2RDBzamt5dnlRSHFTOUcwN2dtZFZIZFJ2VEtQVlZVd2JPM2lE?=
 =?utf-8?B?eUVyYXVuZTRRNzU5aUx4WVdGY3JLSlFxUk55aXF3SWU5RzVDWkxuY0ZtSmtR?=
 =?utf-8?B?QkorRzBRdkZ4ZkRLY2VEcllhVkNBc0ZpQjVBVGp5SFNPWEpWL2FoeWptSm9G?=
 =?utf-8?B?WkRxK3YzeFhOKy9QcmNMNU55MXJ2N1lnaXp1YkF4cE1vTVdBZk9QbHNwZy9u?=
 =?utf-8?B?cGZMdFJQTXNZTSs1MmNORDlVeVVXeFpkRWI2RSt4TUVLY05PUkdMWDdPdHFH?=
 =?utf-8?B?YUVuM3hCWmlJTTI0WUtxSE1Fck05Q1daenJUMXl3V0UyeHo2c1IxZUVKN3Qr?=
 =?utf-8?B?NnNXTnQzbmVZc3lDWU43enFJbGNrbG1FN0JYemh2Vms5MG11MThlcGFQNkgz?=
 =?utf-8?B?UVR0YU43TWxSeTJKc2JtcWpzZU9CYmpuTDlLamt5dndlZjFHRXlBOUxYbzB5?=
 =?utf-8?B?YW13eHc1NFVoUmV0azFFamk0RjQ5UTNPUkdjNFRyMkZFOUdoOUJQSnQrRGRP?=
 =?utf-8?B?eDBrUEZhVXhybkNCc2dGUnpVQVUvWXRKNVNaNm96Vy9jbldKVVRiZnJuNzZh?=
 =?utf-8?B?UHFReWVFa3oyWENKYmhQalpsc2k2ODV4ZUdsRmFUNWpzMHhYYnlFc3pzRUpJ?=
 =?utf-8?B?YzFtS2dwZEpTSmV5bXY5Y2dmNWpleHFEdHRjY1lFOHBwcHpvRjhXVEYzbEdY?=
 =?utf-8?B?UElOTVNxcUNITURiYmdiSHoxajg1WkowbzBWN3d6ZXdLUmloZzNnVHFUQTFQ?=
 =?utf-8?B?WURTM0plbDh3RDV4RTVKZ0ltMjlobk42WVB1bUdWN1FMR1gzVG5XQVhDMS9X?=
 =?utf-8?B?bjB5QmRHSkVxdXV4K1MzWDhEbWxWeDRyeDUwNEQ4eDRZcitqbGhCUjk2Vm8r?=
 =?utf-8?B?cWpxaWRDVWppRGRTZU1FUVlLbXROQ0E3Rk15eTlhcUlnU3ViODZWbGxvVFpF?=
 =?utf-8?B?Yy9sc1VpOFE2WHFONGMwNVdXekl0UDFOU052b04vVEpzUU9OWStQT2Y5Ym0y?=
 =?utf-8?B?WjJZK3VkWTBYWDhTdnU4eDdJa2Z2OFpKbStmS1AzNW03ekk1dUZKck1UTHpS?=
 =?utf-8?B?anRyaUVYL0pLRHRFVlJGelpmUFBvTURyaXRJRXZqVzg5c1BOL0JuanZuV2lB?=
 =?utf-8?B?Rk9wMk1Xd0Z5WkZ5MDMyRGFUWVhuM0VIemZEblkzSGpjRWNnN2ZCRURmZCtv?=
 =?utf-8?B?b3p6cUNjRmkzVzVITmlTemFJZ0E4MkRMb1R4U3NkSVc1Ukh0MjFvaDR6bS9S?=
 =?utf-8?B?RC9hNEJPTUJkbjFaY3RoUXpJeEkyNGhrRldjSU52U0VJY2tzVXJ6N1M5ajA5?=
 =?utf-8?B?UmoyNm5RWGZCQ0hGTmkvVkVCaStoa1J6TGxHSUg4N25zMXRoOUhJdElJT1No?=
 =?utf-8?B?MEJRWkpYbFlMWWxEVHYzQVVtRXpUa2lsclJlL0ZsUi9ZbVNTanRRYW5NWHhs?=
 =?utf-8?B?Q3ZQWnB1T21rVDkxZlhlMUxjalB5ZXl1ZzQrT1drUXFNVTlZR0pQK3c4T3ZY?=
 =?utf-8?B?V2gxZUU0enp3WUxIbFNxOE5nUTU2ZmQ3MC9ZTmdEVEYxMEVPT3ViMWdJU2NR?=
 =?utf-8?B?Lzg3azlRV0FJOXFNM1prQXBOMkRtU1ZnaDhoelB6dHh3NDVQTFhPN3p3MFV4?=
 =?utf-8?B?Zy9rSGVGODF3MExiUlF2ay9HTU5FVG82T0tRQzFlaHlWeXNGb001blFlMmJa?=
 =?utf-8?B?Y0F4V2RVK1YvK1ByQWpLMVZJWFFCRXY3Zy91QU42WXZHb2VHanc1WTExRlpx?=
 =?utf-8?B?VWtjcHdMZVFGaStTUzg3YUIreDdoQXB2UWVpSzROTTJtMi9teGRnQWo3ZEZm?=
 =?utf-8?B?bEhDTW5iNi9BcDV1cS81amo2QTd6d3RBdEJmcWozUkxkaWdTcHhHcnZRRUVx?=
 =?utf-8?B?K3hHaXR1S3VHejh3Zld2ekIvQ2dFSHMwcjVvNExSYkNmRWNqMGJFUG4xQlRx?=
 =?utf-8?B?ckxPZFdiTDNveUtZTDNVWmVxbk9QZFkxYUt2eFBiMUZQTmxSR3YvaXZVa045?=
 =?utf-8?B?aXFtNXF6cG5hODZlalBSYWFoQ3o4aW1DU2hCYjRvajJYaGpnVW1nOWdOTFhw?=
 =?utf-8?Q?krC92sm2wRqwKBAnrMO6mOYCd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1514ee2f-f23c-4e58-f6c7-08de082fb1f2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:03:27.7182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JD/QGOG6GZKOKLpkr5Ni+5Hwe866cePRh4JBdyDdNN8PqoAQvJdactznrmyVjbGqzt0fJRtZjCxyiU4L5jDHzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6232
X-OriginatorOrg: intel.com

On 10/8/2025 9:52 AM, Edgecombe, Rick P wrote:
> And unlike the other bits that just got added easily, this
> one required infrastructure changes and extra patch. So wondered, hmm, is it
> worth it to do the extra patches?
> 

Yeah, I reconsidered its usefulness as well.

Though, adding it to CR4 pinned mask is a net positive, even with the
extra patch. As part of the pinning enforcement, we get the warning if
LASS is turned off by accident. The bit gets reprogrammed automatically
which, even if not useful, wouldn't harm in any way.

Also, the changes to defer CR pinning enforcement seem to be useful
independent of LASS. Plus, the patch turned out to be simpler than I had
imagined.

> Yea, I agree it would be good to get a warning. The write may be triggered
> accidentally by a kernel bug. I agree with the patch, but just commenting my
> reasoning for the sake of discussion. Maybe we can tighten the reasoning in the
> log.
Will do.

