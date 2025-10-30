Return-Path: <linux-efi+bounces-5261-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 050C8C2144E
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 17:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 821D934EA3B
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 16:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946362ECE98;
	Thu, 30 Oct 2025 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ihtnjiG7"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B590E2DF3D1;
	Thu, 30 Oct 2025 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842652; cv=fail; b=RsgjtYrblFLpcMT40iydEggYXtxgyNDB5rIkav5QdY6c+wfh++z1P5OEUaHnMyuE1PX9MBY1HLmnQQZDb1/O98GozjIw4FGZ7iQyK90QmaVmzaXtVw8AmQ5QGKg1U35aymJHUO9CtrGWUnHYaajx8YiXm+4yY18kRiOSbHR9Ql8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842652; c=relaxed/simple;
	bh=n3IRZvcTo3haXGz0X0ifnUh5t1hRKzmGv5lgsT/hgc0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QZ908W4FcM59z3G+7S1lIv7WqAuoz3cmK8cJtGxm7E0TLica1RA9EGmvv3XA/79xywz5nTvav+2daKUsqnLwudjRwPzD9WpbPkfaG/LzTIta6gJOJZw3bv30ZsxwlEZAivdQA2r1LBkLpuk57C38B0zxWD9Ugy1Akf1PRQIeTFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ihtnjiG7; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761842651; x=1793378651;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n3IRZvcTo3haXGz0X0ifnUh5t1hRKzmGv5lgsT/hgc0=;
  b=ihtnjiG7QSSXqyCj06XRv1j0iwITQChizmdhULBGx28cF8TPMdz6yKS8
   k0jeGVEZRC7QwS6ZhDjJDlwx+LaJafYo5iMjt7euiMgEW394rYVXGPCZd
   Cy9ixBFpaTU6uxDI8Q1kVyVh8C2yIeC0Gsi+8IRP3p5xvYSnAO3CS404H
   qwKrzug2XXRxxSwzxm27SbDSjj3tabOOI8k/ORmAdwhEhsoGuMey6Tmmk
   WKtYFbo6VfJnRHtuwXcfTbctvcQvBXzVNUndhYcA932VQ8EOmbnJmkFds
   hxuaYMHcfzCQerVy0SYCzrBiZAnqUcfVPEe9aZlwXtIeUWF+AxWg2r+mU
   g==;
X-CSE-ConnectionGUID: UtRWpBe4SNCtde/AzXYEXQ==
X-CSE-MsgGUID: 57onnrrOSnCyV37ZS2bU/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="74284476"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="74284476"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 09:44:11 -0700
X-CSE-ConnectionGUID: bXYxyYUwQNmt660TAHmUaQ==
X-CSE-MsgGUID: ViKScVYITH6O12mxqwK7Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="190076719"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 09:44:10 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 09:44:08 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 09:44:08 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 09:44:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFbiomJ/u/ADCymf+xo/R0XdaMLXtvwwnR9msS/78nUVfj06kB0ZO23xKPbC5P2IhcCbBMDOhk13jk+BkXT7aQIEA3fljbWVcNdBRL11vh+eMk5gX0RKDJB5tmTrDj+4bre5eAUo8ZtGNb0pn0pPWvHKiPZmAL1dvntUUFA9cYPOzKWWm4C43H7YIXu+sn7Bomve884rq2FR7rx1K+MfJz9eh10+tXyGsTTQCgbyaczFQSmtBRCm6eIlkv483v1DBEmkPpn5ePrJHOmCl9YZLbJOX9KcSyMeTSe/O/XzCWBNxdLQz0JD4Yk2PvSZAjgBa+Yjcpk6OYfHKEpPMNI6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmr3v1JmKd3e4hQOHRQ75h0V/qhQsfUNRbW1od3SJyA=;
 b=RnpXLUk4D4+IolByyBd8rw+VdtSmuZXkER3Eh3GooURCf8U+rRNWCUJ87qJwrqNk+6tgQ8kbU4U8N8+qpl8cAzo2YepFBMtYzK3MtZp6bzvTjBJa7tNgMgmKiw2Afwt48YzFlbS+QJIpdcedtcBRh2KUGd2ldcLQXYvbDg39V9qQMU09peCaevNzO/HU4JRNiLY2ZJHxdvszu/gl+XMyfXvZSTegELploG5XDG71NOyQ5re8aU9MwlkhMxOEg9F9CpBezzw7Rx1+iAW0nWaV4we7Vx30H2/4Da8OozIlb0UpyMHS7kT7WNeVeLn74s9dSOFZ+FVCvD1IQQ6BsJZltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by SN7PR11MB7468.namprd11.prod.outlook.com (2603:10b6:806:329::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 16:44:06 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 16:44:06 +0000
Message-ID: <d1b5698e-94ab-45a2-a472-4488895d55bb@intel.com>
Date: Thu, 30 Oct 2025 09:44:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 9/9] x86/cpu: Enable LASS by default during CPU
 initialization
Content-Language: en-US
To: Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "the
 arch/x86 maintainers" <x86@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
CC: Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, "Kirill A . Shutemov" <kas@kernel.org>, Xin Li
	<xin@zytor.com>, David Woodhouse <dwmw@amazon.co.uk>, Sean Christopherson
	<seanjc@google.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, "Vegard
 Nossum" <vegard.nossum@oracle.com>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Randy Dunlap <rdunlap@infradead.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, Tony Luck
	<tony.luck@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, <linux-doc@vger.kernel.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>,
	<linux-efi@vger.kernel.org>
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-10-sohil.mehta@intel.com>
 <789ADBB5-F7AC-4B08-B343-F23260FB8FBC@zytor.com>
 <13681100-ddc3-4ef0-bd13-744282324ff1@app.fastmail.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <13681100-ddc3-4ef0-bd13-744282324ff1@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::12) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|SN7PR11MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a31ade-7584-4fb8-afb0-08de17d38a2d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHc4d2ZTV2pVRUk0UEFROVdpcDV2TTl6K1QwbTYwdEdWbG5TMFZjRVdySWFY?=
 =?utf-8?B?OC9lOVJVbEF5SG5Ec1dPSzdneGczbW0yZGc5c1hqRmdTemIzeEVVdzNtWjI3?=
 =?utf-8?B?b3NwSkZyUmt1N0VCQ2xRejhzek4yRlpRRjFhbUZTUDVadWZ2UlJ5OUwwb0oz?=
 =?utf-8?B?eXV4eTFPWU5kQVBjdnlBZlR3Nlp2d3BtL1dHU2tKMU12c2lEMkNoeUNTNng2?=
 =?utf-8?B?T1Q3OVR3aDByTjZQRkpSaEFRTnFNaDhUN215dmRSeUJ4UFhGQnN1QldXbDYr?=
 =?utf-8?B?bWJTZGpyaGk1aHkrOERBU1ZORDJ0R1FPVmRsY3g0bDE3MkNVMHMxbzhZcmcr?=
 =?utf-8?B?bjlIRFZNbkd6aGxIWUY0Tk85SnZGWkNXUEZWMWR4a0dxQXJaTUYvNGJrUUZl?=
 =?utf-8?B?VnE2eVZyYmRwQnVWK0djRnBPOWFvOFBDY0NFV1FWMTFQYkVTMG9KZmVWcnQv?=
 =?utf-8?B?L1lxbVNWTVJqMkJRem16SGZUUTBzN3FybU8wNVZyR0N3U0o1YlBjUWxzWFFk?=
 =?utf-8?B?LzBUdDJsaEl4bHpwZ3hFajBTcVo5U1ZhN3dXa0JXMXVKTFBmTHhhRXR1dUFn?=
 =?utf-8?B?Nkt4dzNkNEpsMlVFWTlxR2s3OU5sTFVmVExFZXRPanJKWCtId0VVTkc3dFB3?=
 =?utf-8?B?cktrM0ZTRU5sWkhXeHgzTTFrUkVZdmhEdWdoaEpEbGVZQzJ3SEpDaUZUdFRJ?=
 =?utf-8?B?SlR5RXh4TnpZZHlJeHlRVGttZ2s1d3h0K2FUSW9iRTE3NXhadmtwREFyckY0?=
 =?utf-8?B?WGo1NEd4MmZBR3REQ3dxaTBoLytFNEVZSk9sY3haT3UvSzhwSjZjYVlnRlhr?=
 =?utf-8?B?TkkrdW9lOWVBeWVSVUN2V05YZkgyeWI4UWVrRmx5U1M4MjRVcHUycHMxNzZ4?=
 =?utf-8?B?NTIyc21kd2FTTkFRUSttT2VJTVdTSDlVYTV1aEFoMEc5aDZmVVB6SWJMMTlC?=
 =?utf-8?B?bUpSSldoSk9oWXRodnNRcjZrMlNvc3BiSTJwMHVzTC9rK29VWmg1OFFXNElS?=
 =?utf-8?B?QjhCS3l0SE1NWW1YNlZwbCtGVm1UeThORjIxbHFJTU5OSCtiOE4wNk1lTEVT?=
 =?utf-8?B?TzZmNmg4ZWxsenRhQi9OMXZBU1FWSGgwTzJiendjeWdjTCthc0dkeENBY3pM?=
 =?utf-8?B?OXdaWll5OHZ0OFBHNUVhTUxmeGpibnZqM1hqYVBOTHBCd0tKaFdsTlNNc0Iw?=
 =?utf-8?B?RU5ybGxLdGVyUVBsLzM3SWtLRmtBUEticGl2aWFrQXdNZjF2clIxV29udWMw?=
 =?utf-8?B?cjlPajYwZ09SS0dSY0NCY05ZdGk2ZFpyQnhvSk8vMHNSV25qVU5FUjRWN0J5?=
 =?utf-8?B?bEFpRjl5THpVdC9BbU1wN2E4NE5YNWxFVnlRNkhxUUtSZjJ5SjBqWVVoTFVO?=
 =?utf-8?B?bUtsazZCZWRwUmpCSVBLV01HZnp0dnhxNlNPMlJ1bytYenFlUmNGZklRSC9h?=
 =?utf-8?B?T2pEcnduUUpac0pybUlOSjRsU2pYOVVtZW5QSFJUY0dWWEgyQUpVcEM4TEQ1?=
 =?utf-8?B?cVN3REtvTUJoUjdlVFlaOEQvZHVxUXNYNXdLRlFURzhYeC9LcXZURng0dFlE?=
 =?utf-8?B?TXdHcGRlL3YycGJEaWgyclRHQWYvWlFpQ3FXMzY4U3NIbFNJSUl2d1IzMEZC?=
 =?utf-8?B?MkQvMUl3VzUrSmZicFVEL1A2SEpkb2kzU2pGaXY3bklYVUJpMkg5Nk0zM0Vt?=
 =?utf-8?B?Um1hZ29MeUNHcmpVMiszbTlZK3BzVnBZcFZDZGtMNVVPUEtJNnp2UGxmMVlj?=
 =?utf-8?B?ZnBPdnRaWkpMT0V1TVIxbzlud1p1a25VaG9KK2JzazdLbGxLdFk4RzZWUU9a?=
 =?utf-8?B?dzdVV1pkYzJtMmVYSVdIdnZFRHhBMXhDY3duUHlORURuUTFMNzVHKzFhNWk0?=
 =?utf-8?B?VzlaSGwrK1ZSdnMrZ0JHNTMzRWZxQkF2MW04c05sZ2JYR2pueERSSW1QZTQ1?=
 =?utf-8?B?OGZ5SEhqbklpcHFRejJaOEVOUGxPdE1ydXVlUi9zeUVCTGdIbngwSWNrWVV3?=
 =?utf-8?B?RFgvUEdqYUFRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDdCSHgxWEFFV2h2MS9OVDJ3NldJb2d3cWVacG5oeE9hTHdFcTFEZDVFMVdD?=
 =?utf-8?B?MWNVSTBVYWQ4OVpuYUhjdkl1bUNFbGdqbzViTkpWbW52M3o3UEZHREx5QWow?=
 =?utf-8?B?UTBNNXpjL2lpYXJrZ0w4azFXUzlnQUFiYzNyVkhobml6ekhBaU8yVVo4Um50?=
 =?utf-8?B?TDgxcHBmUDdrWlZnRGpvcDl2ZVJUczZ2aU8yWEY0Vk5NaU5IMTlBZjBzbUhu?=
 =?utf-8?B?L2V2YmFTY0JRSS92NFhEbStUMzMvSmR1cm5FTXlhYmRjeHFYblEyREF1Vkpm?=
 =?utf-8?B?REpTMzFuVFRaSjltRlJ0bHo0YkFJUHk3Y2g4aWtlemg3RXEvWGlRalRTdS83?=
 =?utf-8?B?eEZsNHA0ZXI3d2p5U0VQWk1aQlVCSWg2T2I5VDQwUG5oK1ZJck5YN2c5aXBa?=
 =?utf-8?B?Nmp1aW5yWFVkMWlRVFVBdXJrL25YMit4NVFZcW84QUE4T3h6dW0zZHRmaHAv?=
 =?utf-8?B?Tk01bzFHbG51ZkNJS3JXQyt4YTJLR1I2RUhDalhDOCtreEYwUlI1RldVT2RB?=
 =?utf-8?B?Y3V5clJhR2FlUDJuazZQelhEWVF3SlNubVpzYXFkanRzcTFHd01IQ3JpVi9E?=
 =?utf-8?B?dWVYMEtwMWZic2xoR3hkaWg0WVBWdVdDTkFZSHJ0QjFpQ2tkdUZxMWZybHlE?=
 =?utf-8?B?TzV2TzlPb3crNnBLdjdqN2xMZmlvOGpwNVJYTHBTc3dNNEVhM0JWdUpwZ3BC?=
 =?utf-8?B?aWsrZVpsc1BndkVXeFg3WkFTUGczVjlKVVg4bDZqNno0U1FBN3RhU3NLWU5F?=
 =?utf-8?B?T0FCQlFOcENRL0lRYXpuMjhjOGFxclZrYUtibkt2QnVrc0EvQXRGVU5WNWhh?=
 =?utf-8?B?RlZ2MUVuZENyZUtRQ2lNTzF6aHlYMFhUNms2dERsbFh3YmhHMW1LQXhNOWRX?=
 =?utf-8?B?MUlPMGNHa2hGMjNPWDdvWVZzYzMzUXg3UlA2ZzZuaDNKNVlhNStYR3hNcUY4?=
 =?utf-8?B?cmZ6cHNoWGNBNjdsVGNRMEpramh6bjN1NDMzalpOSVoySVRYZlF0VzJYN1du?=
 =?utf-8?B?dUppY01CRkoxZ3pNTGVwUC9SSHkrUlZnQ3FtR0hIUXVwNkJjNE9pNmU2VDFk?=
 =?utf-8?B?ZFpGUlNTK0tEc3N2N28wVW4ydURpLzBQZkhJUUZramwwS3hUL29pekdIVmRX?=
 =?utf-8?B?RWMzNUExRmFXaXZOMTg1Mjd4WE1kRTcwTmxMcCtrcUJncWlwZHcrYWVpVks4?=
 =?utf-8?B?TTY1dVJZQ1ByZG5kdHBuM21hNEp5RzZGUTRlc2NQWXM3Sy9UdkZUN0p3ZWJo?=
 =?utf-8?B?Nko3K3EvUW1XZFljc0lVbDlhditLWHBMazcybFFtdlN5OWRZc0JBMlRQK3p2?=
 =?utf-8?B?TGhhYm02amRZb2JKK1QvL0puajY4YUsvd1NsSnlYTGcyNnphVXNiMk1vWGcw?=
 =?utf-8?B?dnJyTWxXSUM2dFkzYzMrNWprNmJvWUg2N01FNFBEby9XbTdMZkNFaEYxdFpQ?=
 =?utf-8?B?cnhqQjB5U2NweTZqTHBLTlEwcWNvdC9XcHZTVlNQT3NkVU9jUFN6MDJVUzV1?=
 =?utf-8?B?dndxL09LSko0MWNzUk1lWWVkRGk2eG9QMGlBdWtSbS9BZHRzenhTeHI3NWVX?=
 =?utf-8?B?MXRJeXR4UVlwV1JSd2ZTaHdTNVBrWE5idlg0OUNSY2MraHdiZkRxa0xHdEYv?=
 =?utf-8?B?blF4bzdTQ1hxZlVNNmtRRU1ISVU3VnRyMEVqU1hvNUo4Vmh5Nm9NZ2h2QXV0?=
 =?utf-8?B?ZlYrSGl5VkgrSDRBY0JKSjdEZWlDNkRmY0pWYndNSWFRdFd5amJOM09aaXRN?=
 =?utf-8?B?QmF0VUwrc0VHSW9yU05sbHEyZEpaRlFkREtiYW1PejY3TmNuSVdCdS9SeDVE?=
 =?utf-8?B?NkF6Z3NLUThodzNQaFRmTHNOYmwydkhQRVlDTXBHSFFBUUpZOWZLU1ljUU1F?=
 =?utf-8?B?RW0zcm10NzNqSzMxRmtQcWRHNVhJSU5QdU9CUkIvY2pSOFpqTGQ0ak9qemNL?=
 =?utf-8?B?T2g3UGN0YXpKV1Vjd3FKTUltNUorRFpkbytkRU5JblRXZkI1OVhpTTN0OFNk?=
 =?utf-8?B?QW1wYnVoSlgzOXRlTXBCM2xoV05rT3BSUmpIZFhOUlh5ZFFCQUdxeEFUbWYz?=
 =?utf-8?B?TVFZa2Rja1ZUamJPT0xpbUpiWDZZOEFaOHNaWUorOEVFZ29YMmwwalZ1KzNG?=
 =?utf-8?Q?nAF8nf+ATrBGAeYmoEzeYw84P?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a31ade-7584-4fb8-afb0-08de17d38a2d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 16:44:05.8922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nkf4esKYUY6yeTRgUamg5ue5JfSWcWuRLaLkK6z+IDShQD/gOe4bU0HpnXwQrAbEcOuR/a4Wvqb1ngXZNA2nNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7468
X-OriginatorOrg: intel.com

On 10/30/2025 8:45 AM, Andy Lutomirski wrote:
> On Thu, Oct 30, 2025, at 1:40 AM, H. Peter Anvin wrote:
>> Legacy vsyscalls have been obsolete for how long now?
> 
> A looooong time.
> 
> I would suggest defaulting LASS to on and *maybe* decoding just enough to log, once per boot, that a legacy vsyscall may have been attempted. It’s too bad that #GP doesn’t report the faulting address.
> 

Unfortunately, CONFIG_X86_VSYSCALL_EMULATION defaults to y. Also, the
default Vsyscall mode is XONLY. So even if vsyscalls are deprecated,
there is a non-zero possibility someone would complain about it.

My primary goal here is to get the base LASS series merged (soonish)
with the simplest possible option.

I am planning to follow-up immediately with a vsyscall specific series
that relaxes *most* restrictions.

IIUC, supporting XONLY mode with LASS probably does not need complicated
decoding because the vsyscall address is available in the faulting RIP.

The spec says:
"LASS for instruction fetches applies when the linear address in RIP is
used to load an instruction from memory. Unlike canonicality checking
(see Section 4.5.2), LASS does not apply to branch instructions that
load RIP. A branch instruction can load RIP with an address that would
violate LASS. Only when the address is used to fetch an instruction will
a LASS violation occur, generating a #GP. (The return instruction
pointer of the #GP handler is the address that incurred the LASS
violation.)"

I attempted to do that in the last revision here:
https://lore.kernel.org/lkml/20251007065119.148605-9-sohil.mehta@intel.com/
https://lore.kernel.org/lkml/20251007065119.148605-11-sohil.mehta@intel.com/

On the other hand, supporting EMULATE mode during a #GP is a bit tricky,
which isn't worth the effort.

