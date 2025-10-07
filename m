Return-Path: <linux-efi+bounces-4996-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3724FBC2DDA
	for <lists+linux-efi@lfdr.de>; Wed, 08 Oct 2025 00:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A897A4E5FE9
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 22:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E7F23BCF0;
	Tue,  7 Oct 2025 22:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJ/ZD3vf"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C892917D2;
	Tue,  7 Oct 2025 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759876135; cv=fail; b=uZKVYNdBeVWXsgB+txzsaU9uy50h8X7kP6Tz0CDIGImeFvqsuuqchYPb273Mrp+aJTNx8S+mgChNkQRg+wWCKNTyZYtIlrH8b2vh8jWsACcgmqmZaW5VgEHoYgNdZQx7WpFy6G4hgpPgPfUBdKkkDxGvDaIFvDbPdOR7V7FJSsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759876135; c=relaxed/simple;
	bh=kCJ1LXFo4scA1Vm0rxZxtWA89LzYA433ERkiuibwxDM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PFvtjUqBe8/EG+w8Tq9z/fswq1dI+qBI3HcpYDLtlfFD9dZIhXAHSCBzqWIIU4DUrj4VH8dVLT7qDd7/7xwtDc58qqYAs89KuxbZqU3Cmh3ElRXQqT8J1LnTtz23Vz21lST2sIxviSoxWkZ2uD0baSCVQq649h/vLEnbld+wPb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJ/ZD3vf; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759876133; x=1791412133;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kCJ1LXFo4scA1Vm0rxZxtWA89LzYA433ERkiuibwxDM=;
  b=XJ/ZD3vf6GXshI0U6YPabyYz661qthmX5wnwEn/FqGwrAxbElWlB3dmo
   uuupNx2dFJioLM7NgoxUx5Z5nK/n0am9pnVqQjNaiaxcEr/fJtsypo0WV
   BOZVGXeKQeGoZRjEOVQwriEsJAoDpbmQFC8dbZOAQ9mxryLDKVNqKI2YD
   KixixHpaDXp018g3dUjKCCoEagBT2/SwhP/nqksSnqoX0zrenH/1OkzA4
   ws7BTPgMlcx4oS39xpxloYlGma/fiL6OnvJTjHSNaZMTgQfM7bHOAv9Cz
   ZXRQAy1rrrQaC28XLqXR+WQ9Pg0VBUhzyXzspIS0Qpws2UA9rH0I2tTZ1
   Q==;
X-CSE-ConnectionGUID: 6cVIBj4uSXWJHc8ibed9kg==
X-CSE-MsgGUID: ZmQrz1viT7OuZ4A8jvF8kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="61773823"
X-IronPort-AV: E=Sophos;i="6.18,322,1751266800"; 
   d="scan'208";a="61773823"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 15:28:52 -0700
X-CSE-ConnectionGUID: kRmeqvJjRgGS2Aazd3czjQ==
X-CSE-MsgGUID: RuuGgF1hRxa9+WMG4P/20Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,322,1751266800"; 
   d="scan'208";a="211230805"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 15:28:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 15:28:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 15:28:50 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.68) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 15:28:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xce9KPKipaGGoJZ6dU5laZwPtjfHUxqHgF1nDYQmptl/nZ8cdH1kElBLVOpwAOwlZNKpKlElXmvwEATz6NGwk3MCOiiEknu2Bm6sAvQMqGEcG5t5RyBtihaH6IG5aKliK6zHaEheK86ZhxQBnOD13o0a/vA0fYBQd6PnGQ+1ZCnrwzV5em2pTJENLDxJimPK+dHjJ71bf10KEOgjyY1Ar8ex5VDvzBJejgkrSHKwYQyVLHHCX0vM7lBMg5U+K+8IXpmUZGCngqjn3kwA7LVLWm3ufPUZ9d1nY7LvzVD8i4BVK4Wn0Q1LC3krPXH5GkKDMMne9JFGYHqjpXCa+LA9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9l1Hs11RNNRNDgvyKyv1BWNqCCo1aFKsVD2yZjRXJk=;
 b=mBep8oBORxtIWvEAAp/IRC1+NBTImPZRkWa4uzhd6PvDxvhZejq6aPpcYmzHSUa+VOf+K38G83/IcGjVRcSjRngYykz792f1EmB19X+5KCVrAToncMEuJxm89pOPouksCI+cZlwRD5tA2W03ehm+b0WlxyBViKS5HobJAJBf9MyuvZcX2YBSpNOye7TQ9ysJNKEhb1pF9pe6I1HsynVaceoAffXiVgL2pjDE5hOczV6vj6ORGiLkaNLZ5mKghISkU9smyvVhaulfDQALVyAMvv2MJD/r4fWpXb5NjpJCvmj6QVVvyn97fTfWKNwNsYE3u7deFwLLkUpglgKmHQBc5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by LV8PR11MB8559.namprd11.prod.outlook.com (2603:10b6:408:1e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 22:28:43 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 22:28:43 +0000
Message-ID: <07cce6e1-db01-46ad-9848-80cc96f3b468@intel.com>
Date: Tue, 7 Oct 2025 15:28:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/15] x86/alternatives: Disable LASS when patching
 kernel alternatives
Content-Language: en-US
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
	"luto@kernel.org" <luto@kernel.org>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "Luck, Tony" <tony.luck@intel.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "vegard.nossum@oracle.com" <vegard.nossum@oracle.com>,
	"xin@zytor.com" <xin@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-4-sohil.mehta@intel.com>
 <9240edbe689108f920d4b0c5c786278aea47d1d2.camel@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <9240edbe689108f920d4b0c5c786278aea47d1d2.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::27) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|LV8PR11MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db16b85-d8cc-404d-602a-08de05f0df78
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejh6V3pCcFdhU0tHeWFGRDdKTEZVa2dUSlc1bUlhWG9UUWNlTFRDczRYMGc1?=
 =?utf-8?B?Y09JS0FMZ21FTVdqWEllQ2xkZkc4Z3dvMTVsWk94aWdoOVJsb2p1Zm5pQ3Vm?=
 =?utf-8?B?eVZDbFNRU0Q0dHFjeUtWOWJPR2QxaDI4bVZubDFPQXJYTnQ0bm1NSVdvUUtp?=
 =?utf-8?B?NmdESnVFY1J3L24rMUNFbFhWUnoxM1dSUGNHTUlvQmZXcWhWa3ZqY1ozWVox?=
 =?utf-8?B?Q0dKWXpUbTB1Q1N6UzBsdkRLcUlnNXNsbENURjY1NVpYY2JGQUJDT0x4bUpY?=
 =?utf-8?B?VTgwTi9NeW5HaGpkaEQyczR3b3I5ZlJTb2k1YWNDd3J2cE5oVUVNR1loOE9r?=
 =?utf-8?B?a3hwSFdWclJ3S01CZkxDSm5vWDY3UFhJeGJTWnk3d2NBb3hCNDRWdm1SUkNI?=
 =?utf-8?B?RnV3MUs4aTBPZHNZaW5wVWNyVThFTUhxMlV0eE8xSjdTclRGZ3hPcnIyb004?=
 =?utf-8?B?QU5keFRrQ2JDM1ZXN1hQbWw4ZVNZTW5mV0NuZjg4cnZpZ2VGUGxqci9LRUEy?=
 =?utf-8?B?ZFRZQ0g4TTRKaVAzQ0dFQnUxd0JvRjhLS0pnV09rTlFEcmFSREJ3V3JVeGhE?=
 =?utf-8?B?UVlQblFZcGM1S1dqOXNXTVBCRUVUVWRLVlNnTlIrQTlOdURvSTJ6UTljTDdn?=
 =?utf-8?B?RHByM0dZVjQxWFFlQlVSRmZ2VVFZaXkxaFZxNkZBYnVmTkpkVVdnZkJpQUZt?=
 =?utf-8?B?ZU1qRm15bC94QmZIM2FJRUV6RkEwTlJCOUM2aHd0ekY5Um4zN2w3Q3RRWDZz?=
 =?utf-8?B?S0pyNWZsb00zVVR6ZHRQZ2pRU0pPNTNuTEZ1L2k0US9hNjVYQkt3RFBLVE04?=
 =?utf-8?B?Z0FTdU9PcnNuMmtsbVNTbHIzeUV0c3NJR0Z6Wmk3eENZelh5eFdGTjQ4T3hB?=
 =?utf-8?B?RXhhdUpxdzhlWThXMy90eU5vaE9yUi9BWHVoT3FIQTUrSHVpRktEYzUrM1pO?=
 =?utf-8?B?RUh2YkwwWDJyeThjMmV2NVJyUDFZRFBaM1ZJQklvVlA5MGkvWElWL2JXZmVv?=
 =?utf-8?B?OWIrVW9DL2ovQVdENHhHaVUrYVFiSFFadlNTdjZPRnVUcSt6cERJYU8wSG5m?=
 =?utf-8?B?V0puYWVsZjQvZkxheSttZGRvMlBFcVllQXR0eGIyVHZpcVluNFBXeGY0T3pj?=
 =?utf-8?B?NXFOSUFGZGhCR2tTMFJCRFZBMWhwM3YvUDB0UEkxMlBvVFl0TGxoQW9oN0NS?=
 =?utf-8?B?MWU4S1ZUK1d1aVduVTlZYzN2Qk8wdm4yM2xkU3FVZGVZS2RyR1N2TCtXTzZY?=
 =?utf-8?B?QXhJT0t5c010NkpyTUlyZXF5L1pLa2hEaWFQekRkQVA0UW14SE1kMDJHQUNo?=
 =?utf-8?B?cktESzJJRDBEQng2UytCMEw1U1hiTXZBSDdMRVNrZjRGaXRYUXYrbEZ2c3lM?=
 =?utf-8?B?S2RPVVozQTlWeVQ1NEg0QjFFM0pUYlBoSUIyTnBPUXBjTGNPN3BPYUFncDdn?=
 =?utf-8?B?QzFTdDBXaXVZd2tLT1BsL1poenpsWStMUXhQSndHK2RWSDJpQmlVbGpUdzVG?=
 =?utf-8?B?alk1WEtZM0VSRjlHSk1hUnpnRG9OT25FT3VHSGU5cnJNQzRVL1d5OTI3OXZt?=
 =?utf-8?B?Tjg0SHE0Uno0ZUVsY0RxUXVCbXQybDZmQ1ZEREhnT3hBOTZvY0Zzc3BHOFAw?=
 =?utf-8?B?OHMzSldYQnJDeGJTeEJWdmlRWENPVTVrcHpybFVzZ3NFT1hoTGdTTjdYZm9P?=
 =?utf-8?B?L20wbVdiZFhzRHVWTS93SkN0ZnRNZllzZkRDQzBrTmlnMkYzYWdobmQ1Umli?=
 =?utf-8?B?TC9FQ3BiZUJmTU9qUU04aFNYTEhTT0dMZi9wcnp4K1JTTXlzWWpNRDcxSjha?=
 =?utf-8?B?aXNSZDc5UUx5UzVlNGowK3VqZFQyWWRRQVhnY2I5QnRYQ3RnRmpsSlZydUVr?=
 =?utf-8?B?VEtjZzlrQlo5MVVtUzFLdHoxdFcrRWFGN2Y2SC9Ta3llaDJpOGJxK0ZLRm9Q?=
 =?utf-8?Q?NJhFvVTxR7A1fQXLW6UFE4oGwBOL+bbh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzM4blpUYjdqRUNiYTRHdTAxYWtjWG0wQ1hrN3RaVHFOUXFYRE0vcVlvcVFM?=
 =?utf-8?B?bWs1TDZPck1tOHFzVmljY0xlRGxlajNiVkI2QVVMN1Bqdnh1UUFBbUw5Mk93?=
 =?utf-8?B?MzZNMjBDTFRiTVBwWGs3bUQ5SHY3bzVXdHZQMDkrSGpmcFpnUzJzaWYvTGdL?=
 =?utf-8?B?ZWdTS2pEM1FPSW1yZXY5NTUxbFVWY2NEaTBJRTZTeStOREhoQkVHaUxUSXhH?=
 =?utf-8?B?R3plRnJHMUxTTnZrdGxkalZheGE1R04zRVRKbzQ5dDhEQmVON1Rrc2dBVkxr?=
 =?utf-8?B?RmNBUW1WaVlKUUVsTWhpc0xFZnFubURhNTRmMGdIeDNuY2RBcUF2SFVSNjVT?=
 =?utf-8?B?YXhMUkFZbEhjK1Rta2xTdUJlMGkvN3M3SmhEMEtvcWVVcDI5eXExZk1wdmox?=
 =?utf-8?B?L1J1L2IxampydEdiN0FHK0s5MkkvemM5WmtjT0tCdkZ5Rit3MTY2YXgzdG1q?=
 =?utf-8?B?UFQrNFJHNGhjUEpoaStyZ05uNy9BTnZ0TGZnaG5VdEcyZEtnazFEb0dIY09F?=
 =?utf-8?B?Smo4MDFSMjB1UFdTaDErMXJGRkRnL2M2MmZXWHZSY1JQbkV0U3VONm5YLzJH?=
 =?utf-8?B?RzFqRk80YTFQMVdlN2FtRGxoRVlJWkVhTVE3ZjgzUG55S2Q2YldLNlB1Y1dO?=
 =?utf-8?B?QVcrL1FqdWNFV3VPQndzZlcxdFFwK0tsVVl3d09ieW1jN0ZEVlM4MDdDUjVv?=
 =?utf-8?B?d0pGSkNuQ2RtKzB5KzR3MzVRNHczdy8wY0lSRXdIaldlbEJzRTdUc0NlazA1?=
 =?utf-8?B?UXZUUklNbHhTWDdScjlSOGZKbXkrRjBCWDl5WFJMNVNaUXhJZmM2SDRTUVhZ?=
 =?utf-8?B?cDBhemhBZWtzeHA4YnZzdmZLL3kyL1F4RjBDdmZWYUpYUUxidHdiczhnSWoy?=
 =?utf-8?B?LzVuOFY0U0xHb2ZBaDRsekhnOGFudm1XRVVXUy9HY1M3aGRrYnV4b0g0SklL?=
 =?utf-8?B?amtpQVJwQnNVcmo5aDJOOFFkMFUzbm5oOS9YbjFKQTFSb0dONWZkcG5MVHls?=
 =?utf-8?B?alRoL05xOXhSVVhBcDhaUlc5cVJEbFQxZlFTMEhDVzQyU08rMnZITyt4dmZj?=
 =?utf-8?B?UVNNMEs3Q3dNWWYzVXMwZHVNUGxzUm1LWXR4NFNvRHBSN1RFMTBCSTZxSHRm?=
 =?utf-8?B?bkJ2SW9uUDJ1K0l3cm9ScEtMeVVDRis5bHUxTGlXeEZTU1hqdU1zNnhkQ3VE?=
 =?utf-8?B?Z1Q3NHU4NDFkT0VEanZnSSs4S3ZtUlAxeGdxNmt1dm5GNDdGeWZuQ3dJb0J0?=
 =?utf-8?B?OVVUVFNQWWR6L3B1YjdNRjZxVTFOSndqa2U3cTJ6cW05OC91b0VvdmxCaGh0?=
 =?utf-8?B?ckhWTSszMkdtOTdoYnFUNllBZ0xycnhrTTlJcjVaeStSQ0hGR0JSTHMzRElF?=
 =?utf-8?B?N2NVWndPU2dod2xZa2dheHJLbVlvNUh4OHZ4NVFiUlQwQUNnQjg0MkJ3SGVw?=
 =?utf-8?B?RW9YeFVWd2syYU9mT2FScXM5RFdZMnRPcnA0RDkvbk1velpWM1RxZEtPdk5s?=
 =?utf-8?B?TmpRajdRY2xyUmJCQ1NDQ3Z5MFVSU1pvamJ5UDFzUGRCV2g5U05yOHphWVh5?=
 =?utf-8?B?ZjNxZEN4MDg5cW96eHlwVVJOZ0g1VmRwaytMRmZwcnpXRlRxOHpJakpGcmZP?=
 =?utf-8?B?MlVVZ1dvUGp4Q08zUTZ4b2J5TGZPcVJVYTNaemtURDVDdWIrOGpEaU9wOE92?=
 =?utf-8?B?VXNNU2xYWDg4ajQrVXZFL1JBaHlIWEpCYnQ0eUc1SWhaS2hMMmF2em1SeWR3?=
 =?utf-8?B?L1g5L250K3o5dVo2YW1JVmJwZlhaVEpWakF2M2E2eTVEcUZ0cmNNVlkrVWZ5?=
 =?utf-8?B?cHZReE1tM3NXSjB4OGY3ak8rRi9HM1JtWDYxS1UrQ2J1NFpKbzZUejQvUUR1?=
 =?utf-8?B?OXdJdmp6ZWtFNFRYTHpnbXQvamMyOHFrNC81cHJINU15d0R2RXYrczdQUVdF?=
 =?utf-8?B?dmxWMXR4Wnk0Mk5mS3FJTUZNM1NwRjNhanBNdEVPUkxVU3RWcm56OGMwNGR6?=
 =?utf-8?B?bVlMekY1RGw4WS9PaWVxdGk0Qk52Ykw4ZTVxemllaDBiTGdER3dCWnVFMkxL?=
 =?utf-8?B?blNwZGUzVUhoMVNtSHBFNDYrRXJ3T21QRkswNXBla2pXbXhtU2dzcWtxR1ZK?=
 =?utf-8?Q?W6p5R3pFGiz9k2nsoqjxPLjI8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db16b85-d8cc-404d-602a-08de05f0df78
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 22:28:43.4502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkTN1F/4GzoKbDXmJHDucA4ZFzF121o3lvHtuBTWCVEsNNbSceMI6W0L6bSfcDEZ72misb4++HJaK9JYcQZ1mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8559
X-OriginatorOrg: intel.com

On 10/7/2025 9:55 AM, Edgecombe, Rick P wrote:
> It's not just used for alternatives anymore. bpf, kprobes, etc use it too. Maybe
> drop "alternatives" from the subject?
> 

Yeah, I was just being lazy. The file is still called alternatives.c and
that's probably what most folks are familiar with.

How about:
x86/text-patching: Disable LASS when patching kernel code

> 
> The above variant has "a barrier is implicit in alternative", is it not needed
> here too? Actually, not sure what that comment is trying to convey anyway.
> 

Yes, the same implication holds true for the LASS versions as well.
I assume it is to let users know that a separate memory barrier is not
needed to prevent the memory accesses following the STAC/CLAC
instructions from getting reordered.

I will add a similar note to the lass_clac()/stac() comments as well.

> Not a strong opinion, but the naming of stac()/clac() lass_stac()/lass_clac() is
> a bit confusing to me. stac/clac instructions now has LASS and SMAP behavior.
> Why keep the smap behavior implicit and give LASS a special variant?
> 
> The other odd aspect is that calling stac()/clac() is needed for LASS in some
> places too, right? But stac()/clac() depend on X86_FEATURE_SMAP not
> X86_FEATURE_LASS. A reader might wonder, why do we not need the lass variant
> there too.
> 
> I'd expect in the real world LASS won't be found without SMAP. Maybe it could be
> worth just improving the comment around stac()/clac() to include some nod that
> it is doing LASS stuff too, or that it relies on that USER mappings are only
> found in the lower half, but KERNEL mappings are not only found upper half.
> 

LASS (data access) depends on SMAP in the hardware as well as the
kernel. The STAC/CLAC instructions toggle LASS alongwith SMAP. One
option is to use the current stac()/clac() instruction for all cases.
However, that would mean unnecessary AC bit toggling during
text-patching on systems without LASS.

The code comments mainly describe how these helpers should be used,
rather than why they exist the way they do.

>> /* Use stac()/clac() when accessing userspace (_PAGE_USER)
>> mappings, regardless of location. */
>> 
>> /* Use lass_stac()/lass_clac() when accessing kernel mappings (!
>> _PAGE_USER) in the lower half of the address space. */
Does this look accurate? The difference is subtle. Also, there is some
potential for incorrect usage, but Dave would prefer to track them
separately.

I can add more explanation to the commit message. Any preferred wording?
Also, the separate patch that Dave recommended would help clarify things
as well.

>>  
>> +/*
>> + * Text poking creates and uses a mapping in the lower half of the
>> + * address space. Relax LASS enforcement when accessing the poking
>> + * address.
>> + *
>> + * Also, objtool enforces a strict policy of "no function calls within
>> + * AC=1 regions". Adhere to the policy by using inline versions of
>> + * memcpy()/memset() that will never result in a function call.
> 
> Is "Also, ..." here really a separate issue? What is the connection to
> lass_stac/clac()?
> 

The issues are interdependent. We need the STAC/CLAC because text poking
accesses special memory. We require the inline memcpy/memset because we
have now added the STAC/CLAC usage and objtool guards against the
potential misuse of STAC/CLAC.

Were you looking for any specific change to the wording?

>>  static void text_poke_memcpy(void *dst, const void *src, size_t len)
>>  {
>> -	memcpy(dst, src, len);
>> +	lass_stac();
>> +	__inline_memcpy(dst, src, len);
>> +	lass_clac();
>>  }
>>  



