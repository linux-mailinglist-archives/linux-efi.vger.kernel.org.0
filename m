Return-Path: <linux-efi+bounces-5319-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBE8C26AA5
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 20:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 429034E4540
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 19:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2A2277013;
	Fri, 31 Oct 2025 19:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eFYBrfqg"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418C019E968;
	Fri, 31 Oct 2025 19:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761937457; cv=fail; b=nglyhHv8Iz2OVH9mNOZXYvsThmT2N+uQLOsgwFtB5ZABLcNFix6R2oiEQtURIRBxbykhFi6vr0BSt88l0gSmtdqC7yagHcedUUSIq9tBef6TiYE3++6xWTPyoitU0NpIpCQwCUts6tSEdSXejK6UNe4VbtBdf2Uu4UUxz/t+/Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761937457; c=relaxed/simple;
	bh=Om4Vx2xrhM/wPr/m+jkIeD9TNDnovJ9rpBN+mqK/Cu8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gEMMzdl9BbISQahCujAca5RSH9hzi/8uzqSVlbCXwOwJjMvPA6TBPHIWcW/9cP1uKaEQo5ldSI349kLo0YoPG+lQGGHLTmSfgDkBXolbKLaNC9uo5OGMTWK9AVMSc/8yPZ0al0jhjoUPWLxcau1+D+0hiQb+5pl8DFkD4UVjQUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eFYBrfqg; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761937456; x=1793473456;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Om4Vx2xrhM/wPr/m+jkIeD9TNDnovJ9rpBN+mqK/Cu8=;
  b=eFYBrfqgRpzbJGPz/PqhRpcKwcSJlkhM68XLIrLNIL4EoFji2lRdCmkH
   VDRHFkypchP4ad70G3sDCFFUkvSALnpvOR86GPj7dUiwC4gAyZ6e2z1QR
   MoqHjpehaibjRiu3ip+zWdM2RX7KJmaz1e2euyG4F9hk7YMydddRCpwO2
   sFkxK+1IHj/+puqxcuZSNkLvqIroZzGvvMFSew1mjA/nj+AtDBT67nJ7E
   kcqB1ZuXuFWbhkS8EORMUm5vtnR2srbASn+tMmsPRVABGnBcgXNsKL6F7
   XQ0WV0+24JFnKxnJqQpvnyX1yVjgypTECJaq9IwEGfMOWaIkCWirdCUA8
   A==;
X-CSE-ConnectionGUID: MgZnkHTRTou44ip8HW79jA==
X-CSE-MsgGUID: yU50FRBNTF+Ad5QY6FvEDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="64256145"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="64256145"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 12:04:16 -0700
X-CSE-ConnectionGUID: rJ1Ok5OZSMmx5XAqcAso7w==
X-CSE-MsgGUID: CVfgrta5StGX9PaSbVvl+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="185526273"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 12:04:15 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 12:04:15 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 12:04:14 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.41) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 12:04:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0qiqE3xbATAB1DtuUDEjF2vswoBtoTc9nj0FhtcHlvgkt8f+fSSwW8p/iAXlkB75FWsfC68FD7olEJxSL2GjDlgeFMq6i9FUEz12ikXhCtfhGv/BrD3wuzbHQixSFyfR5O3sp/C3NWf9fyT+3XekUnYMDQzkx2i/3rR8Dq4TG9KqAGEHjiuWWy7Fdud0mFi7Us2v33rhHPOx0XxDgHHpJg5CGyBzjvJdwrqvRhvgnBcLaYynLOjEdA44GLqRwExNmoX2zRd+LWe/fqzPCjGHT00kZ/l44rB0uhB37Ys5ADgaKKxlkyWE3AzsbvZmY6VbtX4vGRYI2ZPLNbNS19LgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Or1HsdEIk1iqV0gLqSYW8yTlz6wKtr52yzymecRrPpQ=;
 b=d76BO87hjfptgvnCQ2EhaAm+/ekocCAyZu+cXMM1Pf5PKsCH3LjQG3cW+toQMrkm1mhjKLdqVAbMN9NaI1c+kKBMTQH8FgsCsGoeuzLbeVxR2mG13cHOZVDbaBovStgaizJ/W6A7HSrVTFEs1IoNVQMA1zV4B4EeppBxNZnwuxf+ikvGD30w6P/1na4uTy0XYUgs0AoMg02MxcJasYcwHdMlIfFVwUV6+hMHQhk9fQ6JTJie1yC9svrUALi6vBv/Z+jkoeza8VloqPCGvHDVf0TwJjfEqwWp5448f6ldCgFGavMPDmOq29UDRnKNAdzTTdLwELirFManM/hghQh6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB7989.namprd11.prod.outlook.com (2603:10b6:510:258::13)
 by MW3PR11MB4697.namprd11.prod.outlook.com (2603:10b6:303:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 19:04:07 +0000
Received: from PH8PR11MB7989.namprd11.prod.outlook.com
 ([fe80::752b:acc8:a52:38ba]) by PH8PR11MB7989.namprd11.prod.outlook.com
 ([fe80::752b:acc8:a52:38ba%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:04:07 +0000
Message-ID: <27b6cafe-8cc9-4a01-af2b-3e847ff9aaa9@intel.com>
Date: Fri, 31 Oct 2025 12:04:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 5/9] x86/efi: Disable LASS while mapping the EFI
 runtime services
Content-Language: en-US
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
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <cac58a25-eda6-4738-966f-a4e42818aa6c@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::34) To PH8PR11MB7989.namprd11.prod.outlook.com
 (2603:10b6:510:258::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB7989:EE_|MW3PR11MB4697:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f1a490-0ebc-4688-392f-08de18b043ed
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDlDRXlidGltZkQrcGhLeXZJSDFkYmNkL1k4UmFXZVA3WDhFcnE1Y3kyMGtH?=
 =?utf-8?B?UVZhOGVMbm9pQllpTFRjYStsS2lQYXIzQUNtMGY4SVJFZE5DdTdTelFhcU1P?=
 =?utf-8?B?c2tuRXNIV2lGd29SalU3R3hOdUt4SzB6Q3RxbUt6ZkRLVDIzTWZQVVpLZ1dB?=
 =?utf-8?B?eXdmdDRCSkRQbEQwbzZkSThmL05uSkxjcEtHT05EUENNODcwb0MzTWN5S2ph?=
 =?utf-8?B?MTRtbXJoVXU5eUtRcU9JWnlmTWJZSVJSYlBFOS9qUXFRM2dNUFhsYnNwMFBS?=
 =?utf-8?B?bTVXVW9RVUZQcndGcE5TTG1oRWI1Q056NHNGMmhpQlhiRGJxSFpGQzJMckJR?=
 =?utf-8?B?cGR0TEEvS0JwMER1SlZNeFpnOGgwQ2xKSWlNV3NBZE9QMkF6VURiQjhuRmxl?=
 =?utf-8?B?aXRIclRZRGoxcXJOQTBPeStYd3A0T1lWbXBtbUdYd0RVaDBLUUdUR1gzUThI?=
 =?utf-8?B?NUpYK3F1bXQrR0pXdU1iQkszOUhOejFMTm9tRk9zUUMxVzl3cExLd3Y2cnh4?=
 =?utf-8?B?ODAvbGRYR1VZa0NQdG5DcUlrUFliTEdwb1hZNitIa3FEdVc2cTNveWhOOVZa?=
 =?utf-8?B?Mld0OUMyK0hnSy81R0RvbXBOYTRDOVF2YXdoaDdFT3oyL1E4cGg2Z3pocVk3?=
 =?utf-8?B?SzNLYlBKMXdLR2xVMGY4TTVoRzltV1BWQitlTnVnOWUrKzBTb3J3RklaMElz?=
 =?utf-8?B?QUY2blIvaFkvVW1RMW1VSWxWYTdLZkQyQkVLOHBuendqMXJIQm5TT2d2c2Zv?=
 =?utf-8?B?cWFjSU11TlNGMGI3UmowOFdWZ1B3RXlCUXZvU2J1OWxIUXNzc3g2ZUFyUE5D?=
 =?utf-8?B?VzQzUXFWNGwydG9NcFpOeUlOTkx3MmsvcGUxWG5PQ2R1ZjRKSENHZ0VVdVQ2?=
 =?utf-8?B?WjVYUml1cmdkSDlRZTBoVnNYVjhEVXRtTll4ZlRlWlNpdmZGS09RdnB1cDFp?=
 =?utf-8?B?SkhwaFBJbWRBWG4xU1pBbnVEQzdRNXQ5c0U2bkg5NlhzcXI0RUwyS3g4Wjgr?=
 =?utf-8?B?SVM2VGFMdERBRE44U3NNYS9YSHZTQzQyTGducTR3Z3Z0RXUrOGdwTGtJcm5l?=
 =?utf-8?B?TE85RWlYaXM2NEg0Zk9yZ1k3Z0JnU2YvQXlJOGxUbml3NEtocG1LZ1R4TDNV?=
 =?utf-8?B?NHRvMUZXbVYxb2dvL202YzY4a052RXZucVROU05iZ1FpU3hORFBEZ3J3cWFO?=
 =?utf-8?B?QTJjak13Nyt5Sk53a2lXVmhMcmtwWS82RTJRSE5MQXlocTM1akVSeGxtQlBx?=
 =?utf-8?B?d2JwcVNQRFUzYnJZa2FEUjRSeVdtTzQwa2w2SEpLQzJmR21MU3lpWlFrNW1M?=
 =?utf-8?B?VmRoVUEybStYRklTVzBsT00ySFlxc2d1MUZBeHZ5MllkSzdUc3JucTZzN21K?=
 =?utf-8?B?dWxhb21aVDhtcnFPOWwrdzdIL1E0blZKUzN2RVRQSjhkS2t0SG5IVHRqZmVt?=
 =?utf-8?B?czBhdGZLbGVnOVAwYytLT1VhV0tlbHdFTXdFNU1XMmc4UERIR2hwczVST3ow?=
 =?utf-8?B?YkJQb0dPaVpJejEyTHYrVzA3OGNmNUVYbVI3M2FVU083MWJSMFE0VFlpSWdz?=
 =?utf-8?B?dnVUaHlVTk41QTN1aFlRL0JvU08vN2o5YmpwU09VanBMVkFRQ3NualBIQkZG?=
 =?utf-8?B?SmZQK1pyRXNzUU04dFdyRXdoOUxHQlhEdDJPc1VaSzBIU1QxV0s5dDQvVkNn?=
 =?utf-8?B?QnpOWlF5RngvYlBxbXVEME9DbENHSjBwWG1pcWRuZ04zaXBidW9ERjZGVEdm?=
 =?utf-8?B?enl0U3lFOHgzbFF6cmZ4WnRCLzhBOVU4T3QvanpZaU9odUZNc1JONlBCQVdh?=
 =?utf-8?B?ZEVLL040SGd2ODA0L3kwRGtVWCtpV1pUUDlFRmlYeFRFZVhlUjRMQUxMb1cx?=
 =?utf-8?B?bWZDWEtBTjltNnlxbU5GZGI4Lzg0VCt4Tmk3bGJyVndqMUh0L3hwUzE0UmdE?=
 =?utf-8?Q?h8S+M+k/cp8BU3BlFAJzmTVkc0o6WM5J?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7989.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2UxbDZ1eGZya1NHSEVHVWNBd2hNM3pjOG5Nb1QzK253bHcraklQT05qTDZF?=
 =?utf-8?B?TEVsOW11dTVtOHQvNE53c3FacURTQlowK3pLUlg4dFBhUkNlNDdjNnlqVEJH?=
 =?utf-8?B?SWkweCtkeDl4dm5wQ0lMcXVKdFVuWDdMTU5JOEhtSVNWa0NwQnd4TDJDSjNJ?=
 =?utf-8?B?Mm5pK0RuRlFMd1lCZFYyamdZYmRVNzNEM3dlOGlSanpmRTZ3blJ6aFNwNVJx?=
 =?utf-8?B?YlNGQUMyWFg0YjRQMTRhaHBud0tqREhxVkZwaGN5Mm5mREM0c0QrRXBBekor?=
 =?utf-8?B?TFpLSURoRmljcE96c3ZoZ3FFbkR0czZ3WHJGYVhlcXRoR05HYlZTU2ZBZVpE?=
 =?utf-8?B?cG5FenJEemdweWlJa2Z3K0N6VGVCQ3RyR2k1T294UmNxK2JZV1FLSTAvU2JD?=
 =?utf-8?B?TTJmLzZlQmYzSkNTOHhvOXhZdmQvRWpxaVlkQ0RDTDU0czJLdCs4RThFUTBQ?=
 =?utf-8?B?SS9ybnUvNy90TEM4ZEErL2g5VzhkbEYrVm5jZlBZV01WeDJhT3BFb3JPQkRw?=
 =?utf-8?B?QVFYZnNXbHRWTjhtZ1QyM04wWDR5QTRJRzh6WUE1U0loVWN5UnJicHh3aW0y?=
 =?utf-8?B?RnVzWk91NVZMaER4V3o3OTZ5NjAvNW9MRUFCYkdsSzJ6WjN6UkUrYmEvd0lY?=
 =?utf-8?B?bUFmbXV2bGNvZmo0dlh2YUViRE84QUpkUFhpSmhPaW5ka2daR295bW1SRXZK?=
 =?utf-8?B?L3pYSHUxUXFBVElNMEEwaFp1Y29HSWVVazI2MnNCaUlCWFphK2dGamFtbUNz?=
 =?utf-8?B?ZVp4T0gzV0hseXBlczVjdmZFbHMrVUdUNENaMWlJcmlvUlVlTS9lS2NrTWVp?=
 =?utf-8?B?UFpNSDZMMXF2V2VDanNoOTIzY1BDZU5wUWZtNmJsNHgydEpVTVlPdUpWWWRJ?=
 =?utf-8?B?RklpUCtSd3FMYWFsQngrWVpGblJlRHQ0cnE1Vk0yblh3UUpEZjN4Vldwb0Nr?=
 =?utf-8?B?ckRtUFVNYUloTTVTcUpic0xlbDlaWnZaNnhsYlI0QjJFc1RaYjZhdmNlNmU0?=
 =?utf-8?B?NVprdFdaZTA2eGhPM20rK3ZCY1QvMExhTm90dStVc2hFNUM2QklvS1dPcjZ5?=
 =?utf-8?B?VGNVTXA1WllSNmszYVRHa0txdXMwME5yUTNzNGtBOXdMTTJGTTEzTmlEb3NG?=
 =?utf-8?B?ZXhFb1MyQkdqQUptL0hhazVQVy9Rb1NndnpiSUQzdS8wUldQMlU1ZEE5M0Mw?=
 =?utf-8?B?Z1c1c2xiTjJUMmo5cno2N0oyT3Vya2VSMFphRkZMNU5OWnFUenpZQ3VhL2t3?=
 =?utf-8?B?d2lmT2lBMFdMZFJVbmlHWk84NUFqbHQwckV0cmcwU1Q3b2wrNE45U0Nsdy9P?=
 =?utf-8?B?VHd3eW9IZjRMeTVOS2QvL2Rxb2FSUUNFZnpwaGVjSGRBQnFhTEpPaDAzQnp3?=
 =?utf-8?B?TXIyazVhc05BbU9jVW84VDhKYVF5UkxnSDdVTVZjdVJmTURiVmFzeHBhZzYw?=
 =?utf-8?B?NGcvQ1NlS2xpUDJhQkk0OU1xRm43OFc1c0o5TytQYmxrc3ZmdlVmUnRubWds?=
 =?utf-8?B?NWxITy9JZTFnVDRuTjhFTld2a0lsbWdMMUx0SmlQdGxPWmZLc2dyRTVnanpN?=
 =?utf-8?B?VEVLR0tYTVRDcWFEMFhpNkxCUXFtV1lTa2Y5eUg1NkREaUwxQWJrVzYwR0FQ?=
 =?utf-8?B?WUVzWVpwMzcyVFk2YmJvcnpnUTM0blJpL1BHbk1yaHZNdUtkZDdDUWlqaVpR?=
 =?utf-8?B?SUMzNWR2Zm1zamVPbWtyYlRXN1l0TFgwZDluT3BwQ2gwSGRXWUJ2V2d5REtm?=
 =?utf-8?B?RDRyaVNnNE5xdVcwQm8vMXAyTWNLZlBNUG1oVXpjNVI0eXZ6eVVZbk14ekU5?=
 =?utf-8?B?YVY0SmdYZktxNmVIYXdaU20rZEs1S0dZeDR5ZkJMbTNCRVlkMmVWOWVOc1Nj?=
 =?utf-8?B?NTkrbHZ3eDVIQ2kyeTVNSDAxejZWN0FVQkl2NVJ3WU5oeGh6NHJxNFc1Q3Fn?=
 =?utf-8?B?VzZmNE02Z3RjQWQweE51UUlWZEdPS0RqTTRNbG1ZMTBjQ2c5ODF3NWRhUWNa?=
 =?utf-8?B?eHBad0dIV2Y2bm5RNW5VRHRrWXNjNXhNMHVMYmlaeVNkRndWNTlGMGowQ3FY?=
 =?utf-8?B?Ly9ZLzd2S09mSDBnbU01NjBIRTF1ZE5BR3g5MElhQjN3Um44LzdsUFVZay9X?=
 =?utf-8?Q?4XSPQ6ivJx5u2mNW+F8tNvRYK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f1a490-0ebc-4688-392f-08de18b043ed
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7989.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:04:06.7714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+GAsBKZF1vekNrT6u3dJF66KoLddvzoENCFWwW5nXfLnCiG7dCV9ZdltpxjVZ4gbALBNeu0IYWGh2eA5Sfo7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4697
X-OriginatorOrg: intel.com

On 10/31/2025 10:38 AM, Andy Lutomirski wrote:

> I have another question: why is this one specific call a problem as opposed to something more general?  Wouldn’t any EFI call that touches the low EFI mapping be a problem?  Are there any odd code paths that touch low mapped EFI *data* that would fault?
> 

I assumed EFI is running in physical mode before this.
efi_sync_low_kernel_mappings() is called right before calling
set_virtual_address_map(). So, this is the only call that happens at the
low mapping while switching to virtual mode.

But, my EFI knowledge is fairly limited. I am realizing that there are
some assumptions built into this patch that I may not be aware of.

> Is there some way to be reasonably convinced that you haven’t missed another EFI code path?

We have been running the patches on internal test platforms for a couple
of years. But, that would only cover the common paths. I'll dig deeper
to get you a convincing answer.

