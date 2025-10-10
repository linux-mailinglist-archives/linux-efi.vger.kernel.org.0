Return-Path: <linux-efi+bounces-5021-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 380D1BCE8BF
	for <lists+linux-efi@lfdr.de>; Fri, 10 Oct 2025 22:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B190C35415A
	for <lists+linux-efi@lfdr.de>; Fri, 10 Oct 2025 20:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13BE302170;
	Fri, 10 Oct 2025 20:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKDE+kia"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF143019A5;
	Fri, 10 Oct 2025 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129168; cv=fail; b=gnyGGEyeHx02XqQsdPyGdxfvSmllyRQi5ktbA7h/Wko84lKQdgoaxx7Wl3j3DrhWhNIXTOShTz0VJgGq7Ku2rMosl2fCx6pWSX9ExWBJjIkQeHosM0Ze0Ucl4Qtvk3CJJGy/3dxoKw58qDcStyaMrNtewFsZDa6mlpAsr9VKRcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129168; c=relaxed/simple;
	bh=dgCkxQvBRBjaNopvf/skNWs19//0QQkU/UmgmEZm8RE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VOPb+UfxwvVjOs+0kJFT0Ei7c0txp3HJ5IDcM60VuPkG+Bq0WVw5x8bC5obufevx+4GKQcsou/fZnhxqy0iK2X4DK51z2HpHVtSqtj2e5QBfTDiHmwpMPwgqbKKoQSWdwXYNegyOrDzrkMo8CZSklnVaVgiqYAySszDn2eHfjyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eKDE+kia; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760129167; x=1791665167;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dgCkxQvBRBjaNopvf/skNWs19//0QQkU/UmgmEZm8RE=;
  b=eKDE+kiaiDyIYLIR9NsuL5awiY9sN+Sac4lbNGlwUiuI5CIpdmRpaPUU
   SMN347TvD7R0PMv6dbPJcWJICKbfJHbR2Qai7yJr0XF6nSmZRiT1SM1K2
   I3zdko/n7NKx+AwT6a7qWhejsGsh7jAdAGRxKDUwCFr1Q3cBom9dAmtAy
   WdbaMJEUvG7Vq9SVCG7yjzZnlK+4eyH7cE7roVgsLYZj5zGozMo3U8BDA
   9Dr9ykv/BYwe0Eg0CWKI3optQu/oy1AgTUiUtswTbOznpfkpUccffDc0L
   rWRF/UbC4QFp+gT7EIo4wHQr1J6FiSJt9XZwTu0RhROSfcCMgHAx0tm8P
   w==;
X-CSE-ConnectionGUID: ZNqX/oWkRuOYCvigMPws6g==
X-CSE-MsgGUID: Lx7R6OAgR8S/UViCRd8a7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62055920"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="62055920"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 13:46:06 -0700
X-CSE-ConnectionGUID: jtHAFFhDQeSGjIGuuZi0PQ==
X-CSE-MsgGUID: F795F/MeTxeqLFqKtZTirA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="211715630"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 13:46:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 13:46:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 10 Oct 2025 13:46:05 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.61) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 13:46:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tcu2X028Y+3TiauSqeK2GSDgg3WIvbMAz8jdqG7Q2KRUtCGLrfpJI0bsrLaTH/9zG//cOwEg+vZucwwz7y/venFRCWOJNqoWQwBcMErPAcWJALc+m5q1JceeUYJ/ERjAIOPH5yJZSdVQwbGNonTJjLlWR0SB9KhBe40Jp4FWMF7lR/h/o03NnMRAFD+GbzkqV/y+7lzy/k84aeoWFSwdwL1Q8QUSTqkROoWSIcycU/ITIebZyDXCycBgdFnD1Z/CjYyDkVVGUCwsZaxEbheFP5z2bnVB5EKOpBUgUiXVtXTXK8DxMIePKWxMGo9XkC532V3++XPfhXQwS6z2Gnv9QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vzXA90PeUyIjCRu6EgnLnRWC38hMixtlcb+fuMjgdI=;
 b=TBZousBRIkEBBOLebF8iVxkPlr72GFlpQiDZWzO87aN5uCgggLC9YXvjya1bOe9VwR38LfPgB8zmsHbDjOjlEz5vU6vpLkKQ78dV4w63w3PSDe2GsOgR/yG0wuNOmwdlseFoRYI4jXZVgg6YrehgU1wtqNQqcJ2kw34pKwesNSNhkKCZCNOBNNY7pE0636+Y4RqRlr+TXACWiDKVKM97pXnLXFraSSE1gEIkG6JYGa4olNJbaqFF2ghUUQaGwy7m750u3DErFhWWGBX+CqJdgst5F4rZGZNijNZ3bjih3WSqTNgLa7c9IilonvScQytyN5yxjf8Wz9CAUqcFJ64+3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by PH7PR11MB6427.namprd11.prod.outlook.com (2603:10b6:510:1f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 20:46:01 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 20:46:00 +0000
Message-ID: <8a324a4d-f135-496d-9718-19ac2a7f6af1@intel.com>
Date: Fri, 10 Oct 2025 13:45:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/15] x86/cpu: Defer CR pinning enforcement until
 late_initcall()
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
 <20251007065119.148605-6-sohil.mehta@intel.com>
 <171d197d80701224b83e707948ae5e0a33e27b28.camel@intel.com>
 <6a71fb30-32f2-4847-b4da-e52b67433ce0@intel.com>
 <14038b019ba53dec91ba6718802504580848879b.camel@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <14038b019ba53dec91ba6718802504580848879b.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0020.namprd21.prod.outlook.com
 (2603:10b6:a03:114::30) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|PH7PR11MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: 612f9ec9-afd5-4cb2-b910-08de083e0575
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFJXaXVPL20yZkdKZ1FUMGZVODNHcVltbUtiVS85WGRCMjdXNWhsOVZrUDBn?=
 =?utf-8?B?WU1hUjF3RGsraGx3MHlydkFjdTJKTFVXSkQrVkVNeTFCOHBmYlJwUVpIRFVn?=
 =?utf-8?B?RmdWNWlGVlNsNzVaNVQ3dS84a0hsWCtRNXc3ejlrOXpybDNkS1ZrY1RqT0pU?=
 =?utf-8?B?dE1sVHFNOGhUSTI4U2JoMmJWZ1dCbTNhSUowQ1V1T2llNEZsZE5paVZUSzUr?=
 =?utf-8?B?UU5KbjN2dFZqM0xjaS80ODd6QXM4c0xPVC9sM3ZtQXdqeFF2aCtqM3RacnJq?=
 =?utf-8?B?WW9XTnFpYlk1ei9PNG1IL3VYaExlZXBtN0lmaThYNEIyczRqN25yRWx1aSts?=
 =?utf-8?B?YmdsaFBZSHlsUzZUaUVPcjNIaytvaG8vb2Z0RjJXcUtUWXZGcWs2bVVIT3F1?=
 =?utf-8?B?NmJHTkxXNGNZanUxQ2gxTlo1VjdSeHlNeERsRDZoclNhVkZxd1YvSFFyYlF3?=
 =?utf-8?B?RmVUbFc5L3B1MUJ1NmE4Qlh2WXBtanIzWUtTbUhnRUJUOEE4RDU4V0NNSXI3?=
 =?utf-8?B?cGZ6alNkdDdlMWtzUXpVR1NpdjRQcUdjOTNQOGNERU96ck5QMXVlSjNRRHdZ?=
 =?utf-8?B?WTBXSmVHZVphUThEdE81WlpDNDZmdExwZmhETzhlblhCTVN6ZHlTd2pxdGJw?=
 =?utf-8?B?Sy9UMWlieDgyUWVtM0FkeExTL3dEdVdmOGxzTG9vSUJKVkxYVWc1N0pFWmZR?=
 =?utf-8?B?aGhIbThGUDFOcWxYNmZBc01pOGhPSXNoeU5nQlRjODBESm9CVkZaZjRuL1JT?=
 =?utf-8?B?Vzl4ckoyZ0hBajZ3Zk4rUW4xbEtPYWlpdWF0d0MvbjRjUmFiMlBTQXBTV3FG?=
 =?utf-8?B?MXZuSjFkTWQzUk53SGpDNXM1Q1ByWmQzUnE3THArcFE3dlA3dXl0b210enhu?=
 =?utf-8?B?WkRZaGljeUp5SmJ1clZJTkxYb3NDK2tzRE52KzZVa1UxUXlwS1VCRUlZRFlj?=
 =?utf-8?B?NzZwUDNwRjQ3aHgzNVlSMFN0dDBIUnRPSU5renpmWmpVWmI4NW1keGMrUnQw?=
 =?utf-8?B?bVd6VjBBVS9vRHZMa3ZxcXJlY2EydmRReUEyd2hZd3hlL0MrdkFBWEdzcUtD?=
 =?utf-8?B?djhuZ1EzZE5UeXZ1Y3BNdzVJRGV2MEtKbzJXUUNHMkczTWlJVGh1aitQTlFT?=
 =?utf-8?B?Njc2SVVob3lZQWtFRjNzbWFNcjg5bHllV1JlSEpTN2FCVEs4d0tEcGRrRDRP?=
 =?utf-8?B?VW8xbVdxc21xL3FjczNTNy8xWUxIcXZtTXVLSVFxaEkvY0xBNHZOb3BaTWhV?=
 =?utf-8?B?cmNTSGhsNXZ4VmNhQW1CNVloOVh3VlNvMUg1amwwelZlQmo2N2lQMjk3L3o5?=
 =?utf-8?B?djRLMWJkMTVmNHZETzBxRk1VYnNMaXhNeHlBcm5lNVZMOFhIeHJ3OVR2VFVR?=
 =?utf-8?B?c2xYY2lDZDJmYmRpbGtVREhFSDdLWUVTWEdlci9PQmNGOWw5elMrV1J0R0tk?=
 =?utf-8?B?b1o4VGJXbFA1WHNBTXZuWEc2L1YwOE9tWkNPb2F0cnFCeCt3R3RKaVNsMEll?=
 =?utf-8?B?ZUh0ZTIxYjgxUndJem5aYXpnTkdhZDlwUG1WWlBqME91dnBsNnk4VGIvbmNW?=
 =?utf-8?B?cFgyZDlVV3pWWFVaZTZNV3dsejljTnROcURKWUJaTXIzNnAvVkdodmZIVUE3?=
 =?utf-8?B?TGVOV2FrU04rVmF0aGZjUVRTanNOMjh4YWV4S3o4QTlZbkF1Z3k2RE5YSjhu?=
 =?utf-8?B?bWVXelpmU3UxbTlTNjZoTUJIbkhNZ1hCZVJGUnlTWEhIa2VFWWY2bStLS2N3?=
 =?utf-8?B?UzlCaXIrUVcrNVkvQng5KzNERmd4eTVHNFM5KzZucjdNT3pXOWRRRjUrRWNo?=
 =?utf-8?B?SFNTeDc4VDJIYnFTNUVFdjNDR0g4MWZkVXhZZ1BkTVJxQUJ6cDF1d2hKMXpS?=
 =?utf-8?B?RUducEVVTEZkYnRnOFh5UHJ4Z0tuOVUwL1Ricld0U2x4dm1lTVpkVk1rOUZx?=
 =?utf-8?Q?CESJEIhNCurYK8kGFCGoLmNq8AASx16h?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWtLTXNLMzc0Q3RnbTZTejA5cFRsNHVDakRtRlRRbEJ6TWh4dHh0V3d6Yk1w?=
 =?utf-8?B?TzVTZUk4b0VCaDJGSTBnSURkT21JOGxHQk1TZHI3WHFlRllmRm1QRk9TS3ly?=
 =?utf-8?B?bnhla20vV1prYlkzNW9yYUN4SlZJNnFpNzMrZzJqbUVtQ2xtTXREajVJT1Jv?=
 =?utf-8?B?UXlyNEdoT3ArRkFsK0pRNlAxa1orT1g2YS9LQVZQNFYyYVVVRlRKSDh5am9y?=
 =?utf-8?B?NC9lSGNiVjQybFFldnV4MnB4TGVDOU1kaTFpZkFsRmNjUXlKaGZPTjlwNWRm?=
 =?utf-8?B?UDZReUZURFhHQU1oSDNRblVBNHAzdE5JNkZvVmlwZlV1WTk4d2xjYjc1Mmc5?=
 =?utf-8?B?c3VhOXhrUEF1dzQ0SUJFK2dObjMyUDdtZVNIN3gyR3pLa3Nsb0NUK1dtK3pF?=
 =?utf-8?B?ZWRwSlhuYkNMMUd0ZURhVjlBdnZ3SXpaVFVTaFVWUTNEbDBaWFBCTEtHWUtU?=
 =?utf-8?B?TVd1U3JsSUZnZFVWQzEyc2N5YVRQV1RjSW82b29ndkVKZ2gyOFFkY2g1c0NB?=
 =?utf-8?B?SXY1b2FJb0M1WmpOdC9jUHIyenZYd1B2ajVPRXo1TmdWT3IrS1JFc3lubnJr?=
 =?utf-8?B?WkJoQmlJOHRIVklzVkdCWklNMFFsc21sM1ZMSjRVbjljOHczbFJNOTE4UjFL?=
 =?utf-8?B?bDY4ZWsycHhwWmU0djlNMTRJMkJFdWxzUjF4VVVrYjlOTG5Xc001T2JMY3F6?=
 =?utf-8?B?dE1NVkt1bEFaWjdtWUp4QUtWb21JRUcwVzRzNlBkQnNRNktzemsvTG82UzFL?=
 =?utf-8?B?U08xR2FWSHFvOEgzckZXaFpQVi9kcnlPMWQ1OEFVOUhZU09EYXVXNGh4dkp4?=
 =?utf-8?B?b0Y2dW50R2k1Ymg5eDM2aGNBa0NxVWdwOVhHWnhCUzNjZjhORHZ0bTJHaGNT?=
 =?utf-8?B?Z1U1WnRURFBKSVZORmE2M3dac0paVjBTUmZOVHNGV3dKOFJKRzNIcDcyaVZ2?=
 =?utf-8?B?b0ZDd3phZTNkVzdPcC8ydHNyTnVwUS9DYkdoZzRGTlZMZ1prazkweUtpaXVq?=
 =?utf-8?B?QzVsdHRqcm1qRnQvbjQyazI3RnR6MmNKeXdxWmxEbHlzcmlaemZNUVhGNGla?=
 =?utf-8?B?anRNVnBjRVFHQXlrVEd4SE9uYit5eUJGMkw4Rk1yWC9WN1R2UklxNHh5UGpB?=
 =?utf-8?B?Q1RZd3ZsaTBmWHFYUTNzM3lERm9ieEhWSXZzTXg1WCtKbURrbkFaaUtGbzgv?=
 =?utf-8?B?ZXQrK0FqYUhvaXNBSXhiR203Tmw3cVlmWHZXR0wxU1FYYVRSa21CWXRKcVAx?=
 =?utf-8?B?WjZkS0ViNTR3QThtY3A2b1hPTklOblpxbFRkb1FweHZtRXFDSFM1UEhIZEVq?=
 =?utf-8?B?ZGZ4Y3FESTlJaGJqTWU5YmlGWWdvY3hPb0pOd2FnNjNNT1E1dmdqc2ZVeHBM?=
 =?utf-8?B?M1Uwa1YvNkxaSDRjNC9tRWIxczU2RmUzM00rRjZkWnFVYUI0NVloQ0kvVldS?=
 =?utf-8?B?SGZqcElmMjMwajd4bTVONHZhMjJ1RVc2RVZ1U3J0RnN2Q0dBK2cyK1J0UWo0?=
 =?utf-8?B?eElsRWlxeHMyQkYxMVJYMXdFbDB0K2N0Wm1MbUJZVEVCbkY5REhRcjlrTURr?=
 =?utf-8?B?TDFGSnk0VGhPZmltNy9UY2tLaGM1VlpHRE1WVHFZa0VEWjN0MnJLaDRYT25a?=
 =?utf-8?B?SnM3dFNxMXN5bGM0YU1PamZSVGVLbzMvME5sR0hJN0hFaG5iVmtlUTQyZFZk?=
 =?utf-8?B?a2JUOUpNTGhMN2dRSVcrbmN2VWVmWjFDcGc5TUM4S1dOUTdvZCtBd0g0b1ZM?=
 =?utf-8?B?WFZnN1ppRS93THR6UHRzZ2tZZXczVVN1KzNSNFpPRlByRmMwU0hXOEJPRThU?=
 =?utf-8?B?dmFlemJ3MFJ1SGxPbGdVYVRpY3Y5UG5WR2tYS1JoZ0IzNkR1eGdXRW5kZEtk?=
 =?utf-8?B?eFdYUWJPcUhuVFZEVjFGbERGb3VIOHhNNitPMU42SGdiaTc4NStRdEJHeFdM?=
 =?utf-8?B?VzN3Vk1mTXlDdUNBNlVkclVidWpzbnYzK1ZUbWk4VHRscGRkYTYycGpqdlJS?=
 =?utf-8?B?Y2tFT0pZY0ZGMjRXSXZjamgxYnpIN2NrZ3N4eXpNMWlTTjc0S2kzUVQ0VWJZ?=
 =?utf-8?B?VmowSWgzRjYyL3hGRW0rbkNvd1BiOTZkTGhLays0ZXZwRTJFR0U0ZUh3RlY3?=
 =?utf-8?Q?J/aJ45ufHh7G050bYtJdwfsQ0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 612f9ec9-afd5-4cb2-b910-08de083e0575
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 20:46:00.7243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJYbUamdOcJN1fD6l1YK/vQSg9JMZDbjKOw4jCuBce6JDEerc9kiM36QUTZ8czQeurKCOdy19lCLnWMRcYYd3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6427
X-OriginatorOrg: intel.com

On 10/8/2025 10:36 AM, Edgecombe, Rick P wrote:
>> cr4_init() is only called from APs during bring up. The pinned bits are
>> saved on the BSP and then used to program the CR4 on the APs. It is
>> independent of pinning *enforcement* which warns when these bits get
>> modified.
> 
> Sorry, still not following. How is it independent of CR pinning enforcement if
> the enforcement is still taking place in this function. And if we don't need to
> enforce pinning, why drop the branch?
> 

It depends on how we define "enforcement". The pinned bit verification
as well the warning happens in native_write_cr4().

When APs start, we need to program *a* CR4 value for it. Currently, with
early CR pinning, we use the saved pinned bits on the BSP along with
X86_CR4_PCIDE. Because cr4_init() is only called during boot, the static
branch is always going to be false with deferred pinning. Your
suggestion implies that we only use X86_CR4_PCIDE as the initial CR4
value. It could work, but I have some doubts because CR4 initialization
has had multiple issues in the past.

Not directly related but see commits:
7652ac920185 ("x86/asm: Move native_write_cr0/4() out of line")
c7ad5ad297e6 ("x86/mm/64: Initialize CR4.PCIDE early")

As we discussed in another thread, CR pinning has expanded beyond the
original security related bits. They have become bits that are never
expected to be modified once initialized. I wonder whether we could run
into issues if the initial CR4 value on the APs doesn't have one of the
pinned bits set. From a cursory look, everything should be fine (except
maybe FRED). I could give it a try.

But, is there a preference here? There is no additional cost of setting
the pinned bits because we definitely need to program X86_CR4_PCIDE. Do
we set the pinned bits along with that, or wait for the AP to go through
the init flow and set them one by one?



