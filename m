Return-Path: <linux-efi+bounces-5488-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1070BC53986
	for <lists+linux-efi@lfdr.de>; Wed, 12 Nov 2025 18:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2569E4ED134
	for <lists+linux-efi@lfdr.de>; Wed, 12 Nov 2025 16:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69AA311C3F;
	Wed, 12 Nov 2025 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqnTEEf3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3048D1F4176;
	Wed, 12 Nov 2025 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964309; cv=fail; b=PcOCTl2gdlZ168z2Ta4g5JmL/tymkMkun0oIkSk+6cVlhGi70fEblUBFq+Qyod3jzUjL0jLBc1I8623g5R98n0O/dWRLxtpxaSlatMx9pYrMX0F+QFO+pXktUGdpGRzK+i41ynwbRmIaMux8lZiIyg/Jkoupv9KqUjf+l1Fy8nM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964309; c=relaxed/simple;
	bh=ipuxt4kdN+v6DdFOJhUshIJ5lPVpPVpJcXQj1Nm5GNI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LwfmH+zUkKUuKawDPpNNBUdNt1MYtAylqMVr200m2ABQk+pcrFaDKN/t2tPH2z+N3RWKxvDoCd6TRWUxCW/betfSB61141XSlsSeIuGqtYMnKhPYGygErfC+rXuNc/UpRDY7hZ4U7ckInHjLpH5kOu54T4MFttdVJBuG1IRC5ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AqnTEEf3; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762964308; x=1794500308;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ipuxt4kdN+v6DdFOJhUshIJ5lPVpPVpJcXQj1Nm5GNI=;
  b=AqnTEEf3LMPtNo43NVa/uJWiHJjAvTOBF4T+c+lYV7ovYg1gyGwn9zDg
   SoxfohIHo6mQweaV9CJEyOSVWNjZDKxISVfUd19NInmEQj82N55AKZ/nZ
   hpy98HLUJraF5LWNmeEoWv4cLzb4pdXKiR4KsP1FnZ371Bk/uc6trC2Eq
   sHkQGd0sEifRaJhije61LIvoTKDZKhXqAA+Nl07zOiB9W8GZURYN+GerL
   6xudzsksx2vhLl5LtY6+fIGWRB9384nBQeEVppvv1G3hEOX+Z8npzL1QN
   duKd3PNDEe5aEDqxg1AsgfegPdDXPgqm8bslArofxOEDK/ZgnkGuAgQEc
   g==;
X-CSE-ConnectionGUID: /8zGb/YYReiemzLj7JuZGg==
X-CSE-MsgGUID: mF/UbVtyQ56HtcGurNsOvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="68881689"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="68881689"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 08:18:27 -0800
X-CSE-ConnectionGUID: g4IYrR3oT2CVwf7phC5mZQ==
X-CSE-MsgGUID: 1J2vZwJySoWyXcWDzFcVzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="194238044"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 08:18:27 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 08:18:26 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 08:18:26 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.40) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 08:18:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SoBygBH6ktLuk+Ocnk2k4Um4M2uZbuzwKBzrShtZ5+VBmPqekWVVS8MFypdZPqLjk9hopX4U1NzVWZLdCA7A0hTCpgdJ+mdGfwzUcU4mph+sRy0vt5s1iX+zNzi608X2GE/XNj+uLRNzHl6IDt94sS9bVwoJwLqjElFQI5mry1HLci7t0C1iXY5phPtkeZoE1As3rj610M4Xri235cxSRxeqLrtE3cm0oKp7nq3+xgZrxn1Do1ldcZ22ZrLmGo07n3oTnD4FMkG2QsnMEeDtCg1I3lC/i7cv0vEq6CmY3r+SOSTtTcOPkHv88ZM+sHKUywcumyU5CmR+uI7owLOoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbaEOnaw0rbtffPCcd7+M6XFFN5Ge7JJY9igDTwXGmQ=;
 b=r1OGPahUcXx8Xan3feDZXCEBvC7/ZeajVdJgEhzlKA3pWS+5k54DHzZ4Nx5GZcKYZSYNGYAlOcLW3bMwIghv8TKpMvRew/oaOr5mDul9kAI5hBTYzbTX7gljDyHFFjO5KrS7tvsK/9Hi830OSMIgJ9Z7KTPU6S5Gw41NZtkba0HItema9bSGET7MVBeqxn3LmXqE+0GSySBiIYEcHl0j9YfruReFmHFnt4krQ/LY0VRZ8GNqnk8jQLRTNW4YmlvcT5Azt7D4Q2ocHYl5FwMdzNU+MxRFrWbn/Jh3DnznD09aasWS+b5hy5ZBEkc60eyGxh61pgZ13w4g0RtorNCpRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by SA2PR11MB4908.namprd11.prod.outlook.com (2603:10b6:806:112::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 12 Nov
 2025 16:18:23 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 16:18:23 +0000
Message-ID: <6ab6e4d3-0caa-41e6-8231-2f3f45949876@intel.com>
Date: Wed, 12 Nov 2025 08:18:20 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/9] x86/alternatives: Disable LASS when patching
 kernel code
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
CC: Dave Hansen <dave.hansen@intel.com>, <x86@kernel.org>, Borislav Petkov
	<bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski
	<luto@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, "Kirill A . Shutemov" <kas@kernel.org>, Xin Li
	<xin@zytor.com>, David Woodhouse <dwmw@amazon.co.uk>, Sean Christopherson
	<seanjc@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Vegard
 Nossum" <vegard.nossum@oracle.com>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Randy Dunlap <rdunlap@infradead.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, Tony Luck
	<tony.luck@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-5-sohil.mehta@intel.com>
 <29f2d16f-361f-475c-957e-0ebcefcd1a8c@intel.com>
 <CAMj1kXHvfgMqFncvP5A6ed=2qEPkNkS8ecoM6iXMect51Tpz4w@mail.gmail.com>
 <7c26ae81-3495-457b-9f64-f5b2e169a63b@intel.com>
 <DDEF6164-D1E6-4003-A251-804738CB59E0@zytor.com>
 <CAMj1kXGyTo=4Va1PevMQyCauEKSutfSPo6je0Ps09TabhTe4zQ@mail.gmail.com>
 <E9396874-5D2D-413D-A5D1-A28E4D429C51@zytor.com>
 <CAMj1kXECkKeDUDdjmrQjcYk=2Y5ydTV2L1Pg73X7uCC-=DC9Ww@mail.gmail.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <CAMj1kXECkKeDUDdjmrQjcYk=2Y5ydTV2L1Pg73X7uCC-=DC9Ww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::33) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|SA2PR11MB4908:EE_
X-MS-Office365-Filtering-Correlation-Id: 0877688b-9675-4641-9bbb-08de22071a0e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWpNaWc3cWNVcmRTak51L3ZnMU9VWGFseUZWbENNS1RJNFpseHR3b2NyUGNF?=
 =?utf-8?B?ME1aaStaQWVCOFJta3hKZmRla0UzM1RhZ2lZTEp0OU9wejNDK1o3OGxudEdC?=
 =?utf-8?B?ekhpZDhhandSM0d2S0RsRDBlRzRFUExjZ1NwYlZmVHc1MGxGR241dStndXJT?=
 =?utf-8?B?T1A1VTkxNU95OHpVT2JuYjl4N1AzWnBDUnpMTVp6QWtOekE4MUYxU2FRMWxQ?=
 =?utf-8?B?T21zcHJNRGdrTC9SbWcrOUNEb1h5cTBabkJoWWtyK1FpRkZiOWdXQ2pKczIv?=
 =?utf-8?B?Z2l3ZXEwMkxWU1VpU21weTQxcUR6UUtvWU01NmIvdDgrazhERkJhdElEMC9J?=
 =?utf-8?B?WGtZOVhtTGdLYnpKaTI5L0J0S2xrOWd3MERVeGNqTjRUM05ZOVVJU1BmWnhy?=
 =?utf-8?B?TDdDbERlOVUySkR6VzE4bmRIb1BPK2JqdUJGQ3RraXVicEJlYlVVL3o4L09r?=
 =?utf-8?B?Z3NNN0ZsNjQrU0ZCZTNoY0M5Z0t6WmJxTU1TSjNaQWJFYzJvRXRyV3ZFdWNE?=
 =?utf-8?B?UEsyQnRrd0tmczY0SjFRS2QyQTBaazRaTW9Za24vTUQxaUFscUZTOXJQZlcv?=
 =?utf-8?B?VUxsRFZwQlpzRmc2SFlERHJGa0UrUnBNZCs5YWdUdjhNN1RENHFzam45aDBR?=
 =?utf-8?B?NGFqUEtCSy9hMDA4OE5iWFQvQm5MdUNQbEhsSW5uWmNwQ1NoMXVsOEJIVUpK?=
 =?utf-8?B?SStiWGpZSmFDczBERE4vUCtGNms0eFZ0Uyt2MmJoMDlRNVRCM04vaDBaZUlD?=
 =?utf-8?B?U3F0aDRCUTVhRlJFeFk1ZUk4bTB5aGEwd2xNbGNRYkRnVU5kWFI5Q0tqc1lQ?=
 =?utf-8?B?UTBzOUF0TjJrMngwMEtiRjVXbFBwL3JQaTVmV3JabllXS0xZVGYyWXVxdGJi?=
 =?utf-8?B?YkFweDdqZ2E2enlwVnY2SHVRTkNFY0FyUmRZeTBCVGt3ZFU1cCtON3ZPc2t2?=
 =?utf-8?B?b28wOVhrbHBZK3k0Z0Y5cEJSUHZGM0RsY2MrL2NUUHNzcVZGRU9jL0xIOVVG?=
 =?utf-8?B?ZW14SnowSUR3TldsVisxOHRjUEVzZXh1L29JRWhmVXdYMmhIWnVCTCtDMzJw?=
 =?utf-8?B?S3d3Z2tHYmJVY3ArZ2NiOVlmV2VVRE8zMVhnQ1hCSkE0RW9mVmI2ZzFwSWEw?=
 =?utf-8?B?V2c5NlJjWWtDaDRtNERJdkN0Rk51RmRRa0llUFd2aGZIbGZ6WTYwZk5aVkVG?=
 =?utf-8?B?dGdSV0pvMXBoWTE5c2hTeVUxemkrQTBvYnJPeHpxaVlHWnJTYlI4Nk4wQ09r?=
 =?utf-8?B?RnRVaHd4SVlyRTNSZnlEMEtacjFsbGxuSzV2TmV2b0l1eU5QSzg5TVQyaE5j?=
 =?utf-8?B?Ymk4eFR4OHN5c293b2VVUGx0T1E3ZUF1S0pJRzgvbi80ZlFaNllFL3dFMy9G?=
 =?utf-8?B?VDRKSnJrVEFrMXJMVlkzZ1ppV21jOXp6cDd2YkNPeFpsOWZmMEJLN3pPNEsy?=
 =?utf-8?B?cXlXbHBrWnJPT1dTKzlzU1pGeGlyUVk3YUFFVHRXZnZnVy90Vk9yMWIrZXh1?=
 =?utf-8?B?QjZpbVphZDVueXlxODFLTFJnc0gvU01LNit0Q0QvZi81U3ArSWlHZ2JsK0xX?=
 =?utf-8?B?TFZKZHE5dTBNd29WeWZTancrN2JvL0xuc3hYMVhXMVlxM2lKbCtQcFZ2VDJz?=
 =?utf-8?B?QVNHLy9IUEZCSzlRdWo4MzB1ZGE5Y0R4Tk9iUEd1Nnc3cE5KSFQ4TW5sZGRt?=
 =?utf-8?B?SkhYVEY4d0dLWDlFM000cmpjbTRDVXMrTG8vZXdYRUkwdENRdGxVWSt5emZs?=
 =?utf-8?B?L3hVR2dRQ0tHYzY3SnRib0ZiQXRRZ0NCL0J6a0dBdWxIWndIanZFZTdQbUFl?=
 =?utf-8?B?UG5zdFZHcUZFNzY2MHJOMVNISWJQM2hzVm1Bdk5YUEtvdnVhTElDSHI1QVd3?=
 =?utf-8?B?QmRxQzBjSGFTY0hqUXQ0ckN6QlY4Z1hqUTVyQW1pb3o4bHJXaTRBQ2N0aWFx?=
 =?utf-8?Q?cjwS8+L8SRDafvKAq/RBYGZUmb92vT+Y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXZJUUVDZnJhamxYendTSGtTazlneHhVRHVsYTMrdTNaRlc2SnlyQVJjMVR3?=
 =?utf-8?B?S29pOHFyMU8xNXdQd1NlanlReEdiem5yVDVrQTdoS0V4clRjNTRTMkpHcTdQ?=
 =?utf-8?B?UUVKUm00bTNaTHJPV291SnBqN3JGZnhralZ0Vk1zV2doaXlLaE12eEE5cyt5?=
 =?utf-8?B?SzJwczNNZytkdzFrWVZiYis0Ry9jbkpkalRZM3R0ajFDd1VIWkIzM01yRVp0?=
 =?utf-8?B?WGJ0eUQxYTZVa3diN1NnWGNuVnQzVFBxVk5MOXFhbDJ2R1ZYRHlESllSd3pT?=
 =?utf-8?B?WHgzU1NST1h4OWpralNRWmlPM3lzVG96OUVkdDBEZTF1VUU2ZFZWdGUrQ3Nh?=
 =?utf-8?B?Z29GSnJCRU0rMTdhSi9LRFIwcGloYVZKQ2Rqa2VKaW5TV2xybkpQdmJyaTlN?=
 =?utf-8?B?VVhibzRUa0ZWOXFGQjNpNHpqVlBuUkpGQ25QcGxELzBqdjZhbDgwU1FDZnFT?=
 =?utf-8?B?NkVla2FUem8xM2ovWXhrTzAyMDJYTXhiVDJnNDRvMUlGeGdQOFdSNUVheHZj?=
 =?utf-8?B?RVREcHNJY3Q2UDUycnlQcE9XdTFiRHJXYm9xRmRDRklMWHA2aGZUeWFxYWNX?=
 =?utf-8?B?ays5dkh4N282a3NiMHR2RTEyUGtJRnpKN0JGNVRHQVB2RCtxdnAvYjBCK0xo?=
 =?utf-8?B?Vm1lZFZHN3czL0ZKUTF6c0lPWEk4WlFoZS90K3BQSWtkaFNET0w3SzZwcDFM?=
 =?utf-8?B?STJadnZrai9RQTFiTWxnajFUOFBQZy9GQTNpWjdCM0tSeE1hay91cmFLQTNx?=
 =?utf-8?B?YlkvWjFaejI0RCsvaXFzeTRCWGhpdXNwcGFMeEtPOWZjeWdScFJaNFNUZGlN?=
 =?utf-8?B?akU2Y3dBeUkzWnJGeStiVHlzdUM5MXBhNU9HUzhkNUtxVE5Ob0pWREJmOEk4?=
 =?utf-8?B?dnNwRHpPWGg5bXJLREhac0FJam93YmpDK2ZVQXRHTThIajlETmdZbHZZNUda?=
 =?utf-8?B?d1psb0owYzl0L0F5ZVpEQ1dFZFRxMktIK2ZCdDI1S1EzQXhoR2F3RWFFTXBB?=
 =?utf-8?B?VXZOWi9FTXVCSUg0S3NCVWN3YjQzWGU0TGltUWl4cURGNXBIYXJwdDNVcFox?=
 =?utf-8?B?ZVdWMmdjUkdTeVFoV2Y1U0lhMk1nVlFVZUg5enU0czR6aGlVMmRrNFBrRzRS?=
 =?utf-8?B?L1dXM0VTaUVqeTlhTHpTaStXdkFIbjV5bDNrUkxFZHJkanlWRFNoeEUyZ2xE?=
 =?utf-8?B?QnlmVE5Uc3RlUDRBa2Y0YVRObklnczExZFRiTzFQODJaNHllWUZGN29HN0pk?=
 =?utf-8?B?RXJWQzZvLzBQdE55WEJiOC9KeU5YeFk2MytMU1RjT09vcmNZYlJ0WXdMQ0dQ?=
 =?utf-8?B?TmlNYk40NnR6QWl4dndIV2FaR29qZkVpNGdHTndReWY5emhSK0l0T1ZKclVZ?=
 =?utf-8?B?YkFRYjFvd3hyMEtCVGk0S3h1TXd0YzA3cW9VaFFRMzlqS1lsZTEreHh2a2Jw?=
 =?utf-8?B?VDgyanA3V0s1NVovR1hLRzR0V2JJaHlqM3B2ZVpqU211U2pvbldZTytDa2Rs?=
 =?utf-8?B?eHRtMGNLaVcvVWU1ZHl6a3huVXNnQ0FtTXg4U0xsZGNmeVBEaWNLTllZNTMz?=
 =?utf-8?B?bkZUTDZXeEtOSkpsYTBxTUMvMzgxODNGUWdCR1paTHpSc1VhNEdqR2VOcUhR?=
 =?utf-8?B?ei9PQmhNdVpqTVF0THdXSUJTMUhXNmpvS2xMREhKRTZyRVV0M2NVbUdxalNh?=
 =?utf-8?B?QUdvMFUxbGtNTC9JdnFiaGx0VHcvRlF4Y3JGWVBPOEZoY2MwRXg5SERCWGtO?=
 =?utf-8?B?eVJrOHB0MW1rVWZVcy93eGhxYXRrTE51S2VzYnNlUkpGek1TRHRma0t1MUZt?=
 =?utf-8?B?WnlVaHBsQ3ArUVBIRWo0ekhXcm1HS3VVdjFOa0N0N3dxT1F1T0lvZjhNbWVG?=
 =?utf-8?B?anUzVGJtSkJPaGp4bXhKUG05cG1hckVqZ3lSYWtMZXVNSzlxQXBLZ3RlRFdJ?=
 =?utf-8?B?N2V2VTBKQTk3YmUzL25lSnBEN3BRbGptY2FGb1RDQTRyNnlWM1NJaVB6aHp0?=
 =?utf-8?B?N1pFV1JhT2pmRUdtUlZSZFpDUmNWNm01VzFSd3lZYVlobW9aN3c4c1VsSXha?=
 =?utf-8?B?MkNXakMvWXBrV3FaeThKMjNsZ2I5NnY1bDlQWnNISEZKdVhVTVhyTkRmcTdY?=
 =?utf-8?Q?M1kGWv2Woh3SELD6lHxrc6iJ+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0877688b-9675-4641-9bbb-08de22071a0e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 16:18:23.2159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpFMLbzLuxorCv18e6mvl4T5U2AlwE1eC8eYIbhlZnjLSq21H0U2xZTR4ZvHuI9Dv2P5Uwa0IngGJ8HG2A96lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4908
X-OriginatorOrg: intel.com

On 11/12/2025 7:28 AM, Ard Biesheuvel wrote:

>>> d) calling SetVirtualAddressMap() does not result in all 1:1
>>> references being converted to the new mapping.
>>>
>>>
>>> To address d), the x86_64 implementation of efi_map_region() indeed
>>> maps an 1:1 alias of each remapped runtime regions, so that stray
>>> accesses don't fault. But the code addresses are all remapped, and so
>>> the firmware routines are always invoked via their remapped aliases in
>>> the kernel VA space. Not calling SetVirtualAddressMap() at all, or
>>> calling it with a 1:1 mapping is not feasible, essentially because
>>> Windows doesn't do that, and that is the only thing that is tested on
>>> all x86 PCs by the respective OEMs.
>>>
>>> Given that remapping the code is dealt with by the firmware's PE/COFF
>>> loader, whereas remapping [dynamically allocated] data requires effort
>>> on the part of the programmer, I'd hazard a guess that 99.9% of those
>>> bugs do not involve attempts to execute via the lower mapping, but
>>> stray references to data objects that were not remapped properly.
>>>
>>> So we might consider
>>> a) remapping those 1:1 aliases NX, so we don't have those patches of
>>> RWX memory around
>>> b) keeping LASS enabled during ordinary EFI runtime calls, as you suggest.
>>
>> Unless someone has a code pointer in their code.
> 
> That is a good point, especially because the EFI universe is
> constructed out of GUIDs and so-called protocols, which are just
> structs with function pointers.
> 
> However, EFI protocols are only supported at boot time, and the
> runtime execution context is much more restricted. So I'd still expect
> the code pointer case to be much less likely.

But, that still leaves the stray data accesses. We would still need to
disable the LASS data access enforcement by toggling RFLAGS.AC during
the runtime calls.

Can we rely on EFI to not mess up RFLAGS and keep the AC bit intact?

