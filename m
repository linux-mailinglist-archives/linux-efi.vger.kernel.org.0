Return-Path: <linux-efi+bounces-5377-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B47C3EC4A
	for <lists+linux-efi@lfdr.de>; Fri, 07 Nov 2025 08:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 452574E55A3
	for <lists+linux-efi@lfdr.de>; Fri,  7 Nov 2025 07:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABA630BBA5;
	Fri,  7 Nov 2025 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FvOs8SEy"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E9530ACEA;
	Fri,  7 Nov 2025 07:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500994; cv=fail; b=I9tGw6gUtbfTxnHTiR6nq6TpCA2FSpcsSOJQwhO2CahG6AtjhjI4psQHJKiZttIaC8OGQ9eCUqgZ6JFIvrFZlifkefzuJAW20EydD8FhU2NpVoyegh0ib0vg5gcttTXXL7Tp+Jo2vOUqk6tx01jmOkTrJYKzmZMFSCFMBokAI8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500994; c=relaxed/simple;
	bh=B7X/xlysaQ8Zaag4ro+Ukd2irgcftMAKwyn+/rwY56w=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fQB4S0v1ouevJ0sj7h8BNdWKMZJwHq4liORasIQTnq+4w/mP939GR5bx9Q/COHwaBR3htL2ak27NG7psPr/3cksbH9hpHZR8fAwR7e62dRDPc+PZPopVhLj7TNVh8914trP3qqWNjRlZFIfJzdNq+FOhGUGml+eXvmtVMHOjSI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FvOs8SEy; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762500991; x=1794036991;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B7X/xlysaQ8Zaag4ro+Ukd2irgcftMAKwyn+/rwY56w=;
  b=FvOs8SEylJLwmVUoWu69dzrDLMfNCo2uB9Zzq/p8IiR3W6om8e1abgiW
   TfbI62VxBjvGiokWNvLtKqEbNWTMpFq93dp0d868JN0VLpSBFhEpSxaCU
   ZLsCRostohbXgitUG12pgUQN9TYPglwmfrQqqBtEo16t4ojeUVxx51/Pz
   idcKVuRYzawq3YpE9vQxiJObRCrLcKLd8zxjKgAWYJNP8iiEXbfa9KM9L
   6aRZiUs06guUxzlgYtkTaf6Qh2iTZ4uyXcktR7/KCE1LSu01g2+2hJdsL
   CQEhyuHjaBrhp+JEqFyUysuAjB326Cp2a9wg/nHlYnk7WuI8T0Y0IfamP
   Q==;
X-CSE-ConnectionGUID: 8fnAxJ5UR12ZiZxGMIZZmg==
X-CSE-MsgGUID: 7B94kwFATWOW1Wv80vNFzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="74940543"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="74940543"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 23:36:31 -0800
X-CSE-ConnectionGUID: C0Qk78zrTX+Vz8THZuatNA==
X-CSE-MsgGUID: xoyuoFISRQ6zutKbR255HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="218718702"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 23:36:30 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 23:36:30 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 23:36:30 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 23:36:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgX69P35hl+8/flySdM3nXftKq/WU7O0S9xD+XzZcB99DgmcHS8hstXAKhoKF+dwkTMs1frHazwHIAQyU7uSW9+O633Uw0puG2G2E0UZG6ArBZn7Z4i42+AW2NhhyvQ8SzAE9hy8aVBGBHpc6j8A4sUDk7iWMqfelDK/YaSQKhJ4JVoyv3spdHczZyD/kjk4xsSk7bJnS+5zXRlGd4R1hWZALT2R54XqU2a2MqIZBdkNK5CGCzNRCkwUQrKA4DU2be6bSmFWeAFl5nLIjA9E3uZyxXnCJukouRfkqYbOZ6F860PxH7AtT7/54dKGMk08/nfXxs8cLzYZTuuqagJrlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8QtthYA/CV0Nk08TJ1YZkQjXPAr8xR7If64VCJpYU8=;
 b=U+VHM+3JwNocpPTs12aQTEW93cltcGqbGx8yiK4Vnd6Jud554z1+Xhn5dJKsmXB899JVgbv00WSIusxyubIZA0LYIFQ161pjIfLfYF44khhPxnXS2FO+F6QAxNn3/lAx6OQkGJHcGeLl8ediphMiqYxywlIWBA//IksePnEjd1qI/sF6Hx5tNkQdU+Sin2VKkJNDfo1AXHKaiM0a+UlrGM0uqqFCV1kKmFDFbKONx+cR7yGH+qVxAn7NC/3sCX3rHWSLbv5LchaUCZkoY6mnqbupPGybxymASODoJ2MyMOYwh4ROqIoGq1A231Df3LsPSdOKqRYOMCoQMimwcX8TAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by MN6PR11MB8219.namprd11.prod.outlook.com (2603:10b6:208:471::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 07:36:27 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 07:36:27 +0000
Message-ID: <1b648c3d-2fc5-41fe-8c2b-71b63be3544f@intel.com>
Date: Thu, 6 Nov 2025 23:36:23 -0800
User-Agent: Mozilla Thunderbird
From: Sohil Mehta <sohil.mehta@intel.com>
Subject: Re: [PATCH v11 5/9] x86/efi: Disable LASS while mapping the EFI
 runtime services
To: Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
	the arch/x86 maintainers <x86@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
CC: Jonathan Corbet <corbet@lwn.net>, "H. Peter Anvin" <hpa@zytor.com>, "Josh
 Poimboeuf" <jpoimboe@kernel.org>, "Peter Zijlstra (Intel)"
	<peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, "Kirill A .
 Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>, David Woodhouse
	<dwmw@amazon.co.uk>, Sean Christopherson <seanjc@google.com>, "Rick P
 Edgecombe" <rick.p.edgecombe@intel.com>, Vegard Nossum
	<vegard.nossum@oracle.com>, Andrew Cooper <andrew.cooper3@citrix.com>, "Randy
 Dunlap" <rdunlap@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	<linux-efi@vger.kernel.org>
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-6-sohil.mehta@intel.com>
 <3e9c4fdd-88a8-4597-9405-d865fb837d95@intel.com>
 <cac58a25-eda6-4738-966f-a4e42818aa6c@app.fastmail.com>
 <27b6cafe-8cc9-4a01-af2b-3e847ff9aaa9@intel.com>
Content-Language: en-US
In-Reply-To: <27b6cafe-8cc9-4a01-af2b-3e847ff9aaa9@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::9) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|MN6PR11MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8711a0-7149-4661-08be-08de1dd05c3d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlNpKzU3Z3dyMzA5cnp6emJGN0NzQVAvYlU5bFVDNHptMjIxVnJLSTZRalJW?=
 =?utf-8?B?Y1psVStRSXJ4a3NFQzVlNU9DNzdZMlpTQStXQXlMcFljaHIwTjhjcHVsRnpp?=
 =?utf-8?B?S3RaWkQwMWE1Yk9pQmdBZzlWWGZmc2VpOE5nZThIRi9kRDJwYUs5R001SGMr?=
 =?utf-8?B?UXVsdDZHTEU1eXJhNVcxSmswUUdzd1lrRXJuVkt6aC8xbDU3UkFPMjRaMzFi?=
 =?utf-8?B?RUJQZk5HV3g2UmJIL2tvYmxCZ3NiMnliM1Y0VDdYblljK29BQ0NGbG5tVnB2?=
 =?utf-8?B?RnZBNDIxQm1ncUR0RHliOXJsODZkQ2pnVEp3THNia01JWXRBa3QzNnEyZ3o0?=
 =?utf-8?B?UHpkQmdscWNtNjFDTDFxRGVFS3VLckVLSW5DR2VLcUF0V0ptSDZtd25VYjdy?=
 =?utf-8?B?aTJJN09hanZNS0hqcFgwZWU0VTlKamg0cmVpQmRwbmFqeFBIcGw4ZU5yUmxL?=
 =?utf-8?B?aUNaMG9HTWVpcG83NlpERkhrcXQzWlJ4Y1FlTlB4RUQ5VllGc1BiZS85QjBp?=
 =?utf-8?B?ZUVTQW1Jc0t3R1lXNmxkRUpkLzNqYi9BMDRDRXcxUUYzYi96WjExazhBOVNX?=
 =?utf-8?B?NHdWcU1NWW9Jbnlmak1SZTBOQWxBdE0xLzhHQkhnWEFoNUlJU20xY3crYXBO?=
 =?utf-8?B?bXhNbm14anl3SkpDS09aYU5PTHlPV3VMNURnQzlQTHM0TnJ6bGZCQVMwREc3?=
 =?utf-8?B?UDR4UDFlRDQ3QzRZVTdPTmVxcFFpMjhEUU0yL2h5aGRoTnZVc1NlL0Z0aEpZ?=
 =?utf-8?B?MVNIdlNENytJajhLbXFWQ29YbW41WHY4Qi8yejBqUXNhM0ZkZ0lMVTdwZnVQ?=
 =?utf-8?B?ZGlJc1ZvU2FHSUhNa0VqMWx1bnJzUmhoR0FwdDNIa0paV3R0ak5mYysrZmw1?=
 =?utf-8?B?dUlpM29mNjl6bUx3SjVYTWxXS1hiSTcvL2lwRDY3bEcwVzR4czltQnVKbGZR?=
 =?utf-8?B?b29QakNieENDak5hc3JPMkFuYkFucW9lajA1K3JZRHJhN3gwcVB2UTBzeTdk?=
 =?utf-8?B?cllaWm5oUkR2WXJScWNGRkZnaktjWW9rc2E5QXgxeEhBTFBhTVFYMHJ1ZGVn?=
 =?utf-8?B?blNxc1lRb3pyMFN3THpuaHg1SzVGU3N0WmpYd2lSNlpZM0JYcjNIaE9JSC9a?=
 =?utf-8?B?UGYvWTJjNmVhYlJDRlNBUTFGTHZPZllNR1JGaDlGZjZ1ZlB3R2JvbjJhZFcx?=
 =?utf-8?B?UHNuWGxGR1pHczFzVzhoNXFHZ0NhUmFaU0w3VURtV2grYXNhL2dqQkJldk5Q?=
 =?utf-8?B?aTlObjR2NlZVbkJ6U05nNnNBTzJrSitkYjVEMUxxZTFxeVNUMloraWt4TWUr?=
 =?utf-8?B?SE5kNzhxVGRvUGNGUVBMYzVtY0lRVXZNQjU2eW1UZ1c2Ukx6emJ6Qmk5MWFR?=
 =?utf-8?B?cWNnUk5oOEdZS04zNG5hQU5Hak45d1JxeTZqclRoaDVZcjBWTFMxNUZBeDVT?=
 =?utf-8?B?ZUo4cVZQcnlidVYzQk1pMmdJeHQzbFB0eXkxQTlQUUhvVzJPSzRvRTNSbWY4?=
 =?utf-8?B?ODRyeDJkSnQxZHYraHVJbk42RVVGMDhJOGtEUldSMkE5bUNsUnJZNFEyTlVQ?=
 =?utf-8?B?Vi9sSEU3cjlPcWdnb1BYR0diYXhCdkFtb0NqbHowSDJreSsvemljMHV4djgz?=
 =?utf-8?B?RVR3UTVoTWxFd2ZnTHMydzY0eUJXZWtWUFMyb09jK2EvNmI0ZWRUYkMwWmsv?=
 =?utf-8?B?Q3d4WHpoR3ZXbXozeDlhTEIxQ0RFZ0J2OGlIcVgvcUJXQUcrQlBUQVVjNzli?=
 =?utf-8?B?SGJyTVh0cGNVM3d0a3lUTlVTOERtWVgxOUhlL3B4aHRaaDlyMmhxYTlOVVQx?=
 =?utf-8?B?dkE0KytnN05pL2hkMVZlZWFCZGJzM244RUdIQlNkdklHQm9PQTBRSjR5R1Az?=
 =?utf-8?B?Q0xua1FIeGwrbFFrVFdZRUxwZ2o0VEIvRVVYaTZJWGJ2TEQ4VmdQUU9iV0dQ?=
 =?utf-8?Q?C8Y40rKWaVS8H72MC6if3lG8LggIVpB0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGMrSjRLcEk2RVZQbjVPYWFhd25oVWZDdFBYSGZrZ2NMMEJia3RZSW0rTVBu?=
 =?utf-8?B?eHBzd1oyK3MxK0kvZVdKeDBWMlJYMFlnL0ZMVU9GR3F5ejZNOEpHY1l6TDFY?=
 =?utf-8?B?YUNwSDRwOE90cStPeHA1VWkrTmo4dXlDS2VBS2ZwSFlxVmh0SkZkNlV2cGhx?=
 =?utf-8?B?L3RqczZtYjRCeFo0bHFCdDlMOFF5ME8zdnRTOWZUanp1OXJJTitIcXBSZFZh?=
 =?utf-8?B?bXVlZ2NUTFBZMzNtNjY0M1lSSTQvTlZFVkdXL1ZvNVd6UExSejh4ajBLSkV5?=
 =?utf-8?B?YzgxaEEwWVBCdUp5NVFlRkJOSWQ2Qm1JQ2hwU2xmdnFPdEl2WmVnQ2k1SjNq?=
 =?utf-8?B?TlJyRXVhQlVXT2tSRG5MSHJhcGpBL3dvcTBCWmVwalozU2xKZ3ZEZGhmTkJ3?=
 =?utf-8?B?KzRwSlcramliT1ppMXFObW1oeExTR09ZUHYrTWVjKzFRUTRVUGcvM1pRSUVu?=
 =?utf-8?B?Z0NUWXNMV2piYUtxbmVHZldOeTJkai9FUk9ldHJpWTUvKzlwdE9BbzdyQklp?=
 =?utf-8?B?dE82UFAxZTJMVENibVJUUTZ1WDlGTVVGNVNEWWRZbExqcHhtcXFOemtxdVRu?=
 =?utf-8?B?aWh1RjQyc2VoM3kyc3dpQWZyeXp6emxja0dMWmsxTlArNWEvRDNUWlozZFNo?=
 =?utf-8?B?ejZQd3RIQlFOa1k0UTRwNWRWNWsxYUZIN0hIc2xGYko2ZSt0UDR0c25qSklJ?=
 =?utf-8?B?Z1ROYUdyZjBQbGxOV0dOKzdtRTAzN1RqbjJzZlh1ZndCenVRZHNiRlZHSjU5?=
 =?utf-8?B?enVtc0t3SW5mMUkxY1d6UlZUY2o1YURQbC9IaXo1Sm1zaXphRnR5bEhOWGlQ?=
 =?utf-8?B?bk1DR0VSZHl2R1g4aGIxZEtjZUJpb3FWdWFuR1JGZHpnN0ZJbUJvNS9yMi9K?=
 =?utf-8?B?cXY5L2RabU5RYnpRU09MVDd4a2NRa01naEVSbk9VRHNlM0JXU3JOajhKalRG?=
 =?utf-8?B?UVlJc3k5N3h0OVZmVmhyS0FZb2pvSG1KVjlQL1hhWHdoclBKcXNZTHFTajZT?=
 =?utf-8?B?Rk1pQlkrbnRGbWk0VS85STdGK3F0bktxcnY2Uzd4TFZYV2FFczFJeW5FK2lz?=
 =?utf-8?B?UlFqNEErN0dWUThPd3JvanhuOEhKRFRKOGkvbW50N0ozUnZ3c0JtMEluemF5?=
 =?utf-8?B?T3BqSHJIRjBCWUMxU1hWdE0ybWRHbzg1TmVBVXhsZUFIdWM5c0Y1WURDVENM?=
 =?utf-8?B?NThUdnNwM1pybG1STmNjVXY1OUYzRkdVbS9zcTVya2xtVUdSd2pWT1hDaGZj?=
 =?utf-8?B?UVZCeVliUTRMeW5jVFliQUhuMllLa2g4Yjk1Q1l0VEVFYXZveThJMzIySy9C?=
 =?utf-8?B?V0IrSVlzOCtYRHZrSFdPdWRsWHZheXhTbDdsMDN6eW95TDFtZCtuSHh5eElu?=
 =?utf-8?B?MTVZbVA4VC9TMndPcTQvQnVFZHpPNXRlWlo5aHk0MWVkYXNGaXM4NHhyRklP?=
 =?utf-8?B?Zis2b1JoWHhac0R3cm5PS2RxczlZcnFraFRCVi9URFgvL0hwUmpOMnNUVU1H?=
 =?utf-8?B?eFovTFN5dXJtaHZwRlpvVjhIWGJha2JlT3E1OHNDdWtMU0t0SUZXSjZVSkwx?=
 =?utf-8?B?WC9xUHlrL0pwMS9IZDhIVmhQcGl2TkdlQTJJWVJjTjN0SXhBejZnUUc0NjIy?=
 =?utf-8?B?RkZ5QjRXS2ZlcjZWcDhMSjBMNW9YaTVpdW51M3g0Vk41eTR5MWp6dHJJcmlM?=
 =?utf-8?B?ajJvaE1DVzBkbk9KU1lrNEttcmxnUHlvTUo5U0VzM0M3QVFZaTYvT1NoNlRP?=
 =?utf-8?B?N0ZGaUVpSWsxUnRHcUdqcXFVb0JJOFZxc2UvcmYzS09TMTRrcmJFQ2MzdkdK?=
 =?utf-8?B?aWgxNlh5cGZQM1R1ZVNnWWM4ZjJTcTNlYzhpZFl4a1dxeDNKZVpnYmthd1FV?=
 =?utf-8?B?R0Q3dmVvb3NtalpPQUY0MVFqWlNlYm5SUTI0eCtEZWhiUkVVSzk3aHFGcXRF?=
 =?utf-8?B?dE1CS1Vpa3hGRVQ2OUpmb0FSbDYxWVZFZ3M3UEU3VFpaUW1ybDVRQit1Sng5?=
 =?utf-8?B?YUYrazJmdVc4S0ZBYTFqNFhMdWcvODlEeW5nYlNlRm5tWFc3RXg4aHI3OVZp?=
 =?utf-8?B?cFJNT0Vadmk2MkVyZFdXWlZJalRpQjU0MitTYWUybGpkeThIT2ttYmZ2V2xt?=
 =?utf-8?Q?gXT6xmQxuDm9IoiuxcHRX5byo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8711a0-7149-4661-08be-08de1dd05c3d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 07:36:27.2856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ft2R7pJjz/JGS/69ERujhDVNRwLgxmIZRfvgok24bjjummDiCU8J3Bu3z/tRzLvr04i/a+iJcWpMn75ipayJnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8219
X-OriginatorOrg: intel.com

On 10/31/2025 12:04 PM, Sohil Mehta wrote:
>> Is there some way to be reasonably convinced that you haven’t missed another EFI code path?
> 
> We have been running the patches on internal test platforms for a couple
> of years. But, that would only cover the common paths. I'll dig deeper
> to get you a convincing answer.

In summary, the current approach could work for BIOSes that behave well.
But, the kernel makes lots of exceptions for broken firmware and odd
implementations. We would need extra guardrails and changes to support
those, or mark them unsupported. Please see my analysis below.

For now, I am wondering if we should disable the EFI support as
well (similar to vsyscall).

	if (IS_ENABLED(CONFIG_EFI))
		// Do not enable LASS

I think the rest of the patches are ready. I can post a new revision
with the above change to collect additional reviews/acks. Even though,
this would significantly restrict usage, it would make it easier to
review EFI support (as well vsyscall support) in its independent,
focussed series.

My analysis
-----------
After a 1-week crash course in EFI (mainly reading lkml archives) below
is my understanding. Thanks Rick and Peter Anvin for the pointers and
insights. I would highly appreciate it if folks can validate assumptions
and help with some opens.

1) Does LASS affect EFI BootTimeServices?

Contrary to my assumption, EFI_BOOT_SERVICES_CODE/_DATA could be
accessed even after ExitBootServices() has been called. For example,
early ACPI code in efi_bgrt_init() accesses it.

efi_check_for_embedded_firmwares() accesses this memory even after
SetVirtualAddressMap() has been called right before
efi_free_boot_services().

At a minimum, we need to disable LASS around these special cases or
enable LASS only after EFI has completely finished entering virtual mode
(including freeing boot services).

Ideally, we would enable LASS much later, right before enabling userspace.

2) How does SetVirtualAddressMap() impact LASS?

SetVirtualAddressMap() is the first and only runtime service call that
is made in EFI physical mode (at the lower mapping). After the call,
firmware is expected to switch all its pointers to the high virtual
address provided by the kernel.

If LASS is enabled, it needs to be temporarily turned off during
SetVirtualAddressMap() as done in this patch. Though, the resolution in
#1 would likely make this patch moot.

3) Would LASS interfere with other runtime services?

Unfortunately, some firmware tends to cling to the old physical
addresses even after SetVirtualAddressMap() and doesn't completely
switch over to using the new virtual addresses. To workaround, the
kernel dual maps all the memory marked as EFI_RUNTIME under a separate
efi_mm. First with a 1:1 map and second with the high virtual address.
See efi_map_region().

Also, some runtime services expect to access the First 4kb of physical
memory, which is also mapped 1:1 to avoid failures.

To avoid any of these corner cases, LASS must be toggled everytime we
make a runtime EFI call. Because efi_mm doesn't have real user mappings,
disabling LASS after efi_enter_mm() should be fine.

I am unsure whether the accesses are only data accesses, or could
instruction fetch happen as well. Based on that, we would need a
STAC/CLAC pair or a CR4.LASS toggle to disable LASS.

Writing to CR4 might be the safest option, because performance is not a
concern here, right?

4) What happens if an EFI runtime call trips LASS?

If a LASS violation happens with EFI, the system would trigger a #GP and
hang. For page faults, we seem to have introduced
efi_crash_gracefully_on_page_fault() to attribute the fault to EFI. Do
we require something similar for #GP?

My inclination is to add the helpful prints after we run into an issue.

5) Is there any other aspect of EFI that should be considered?

Please let me know if I have missed something.

Another approach could be to support only limited (well behaving)
firmware implementations with LASS. But, I am not sure how practical
that would be given all the quirks we have in place.

Thanks,
Sohil




