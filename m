Return-Path: <linux-efi+bounces-4982-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0C9BC252C
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 20:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59C63A3961
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 18:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCD52135D7;
	Tue,  7 Oct 2025 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TTJLHlKE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB9345C0B;
	Tue,  7 Oct 2025 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759860456; cv=fail; b=Z0MMfwrdUPG18H9L0B7NNW6RpOJPyLZCtjGtBleUK5mjnUw8fiqMtXDHjf8hLFPyn44Fn2ON5lflUlfeixQAUWUiVLnqMTqwDNi2kaM5zm+GmQpc/4yaFhKdio7qWnwpnxmkOhgouUOdQ2otRytg2/bFTF6jY01j4AL/2o/pgdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759860456; c=relaxed/simple;
	bh=7R/YJ6c9iirC5rDtw6PIm2tG/hERH4nAcJlvgoT1dEg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tNw795ZkS2mCJFAps7Sg7JgymJi4g0AGYqBPxZ0Pssul0LQ8eiWPk7+ikj1HRbUGI1XI4/Q8ZodQ7omRkgEbPXL0TqT85Kd/1s55eBVDSu2d0GYmxy7dr1lH1UseaWS5aGdCbymUIcrxZM3WXDGjIGubQ6075RfDGrYxLyomHUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TTJLHlKE; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759860454; x=1791396454;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7R/YJ6c9iirC5rDtw6PIm2tG/hERH4nAcJlvgoT1dEg=;
  b=TTJLHlKEipybRR4oaXzSm1wDHH4xN++ZkzAH8qgzBbz0/yCdbviaC1aA
   QN+6kugkYCH7xIxFP6aeX91ivnsFv4rYqEgA4Mh/6pe+TnBS4Phfm0ri5
   XyqhckT2IxaKxKQjLepU8G9cTRsNWUx2o+lywoccN44hIaMDNDr4XTH/y
   ipaf2w9t5bgOtl1kvsAKf4iYxwGwXFUTWMh+Na2YYlRmRGnofU5Ud844J
   DL0EWkCDdccHKEVv7mLl7SpY4SqfRoNs7xykab889FLR7C+j8tIm+npcf
   pLjfNwSZuIQwqmEk1o9M4It6DVUMdVkTnlfq40RtO5+efL9mFT4RFCokR
   g==;
X-CSE-ConnectionGUID: GmNFyu23SbepfthqGP0WYA==
X-CSE-MsgGUID: oWSaZNfHRamADQsoF0/AXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="61083916"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="61083916"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 11:07:31 -0700
X-CSE-ConnectionGUID: SkkyjoUbRkSsf0JAwQDrkQ==
X-CSE-MsgGUID: WDBwJpDHT3m91SdokQC0cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="185501827"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 11:07:32 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 11:07:29 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 11:07:29 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 11:07:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HT11bmQgt4j8wlzIRuiGhGTjzUr9FEjG985fgUsE0ZU5nmcm05+KhWeEsxIteJLAXVv9X3N/rNB5E84aLWbqz1xRsvMCXOYie0cSyc8hSauUOPOUndhGC0jGtIZPxILBSRSkxzZIvbWf5ZPJIocUnkZZbyv+lSw+qnQjDN4nKoRgUEmDT1lqAeOKbmT5WzJ35MEuZkt6nLN1qFd3PPHkpYfeSI45eSRzeff2+VsAEYs8Ay3HkOh1gmJHRP/cwobY/WmzHAVAGg6q/pO4ZIY5zABVG427I+2ApH1Obf/5A6NEH+DngbK9Udt2EnN0Z6TGoYHbFBlVcpW8xEZTqZVSFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7R/YJ6c9iirC5rDtw6PIm2tG/hERH4nAcJlvgoT1dEg=;
 b=b09KKsxkN/8V8nwt0d1LNSmyFaXMwwqf0V2yQgI8vIzEkbTRtqWrUP+sdsaz4EuHJmyWOSRcPgojLh7UIIxESzK4fdtoDTSwNMbDsNThmudnS05EACmGf1oPPKDb5snGXX3m0kP4ImiWm6SeQ1az5Cmx/77OmSg5Mu9GM3/rPkTANvz0pKE0DfTDAW7w7ze6+qu9avT/OFxLl3KbYu9VnuvJg5oXVwPR5B+rG7aMC8NWAumCQqxLl4dJtgG5OA7PnF0jaFXhELTYJljFZ9JkLySXTI3MzPFtGJNAquW23cvFNzg0z/l03AVMyCwkYCNNKDcHBiAEvlhr2zrmPaptxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB7622.namprd11.prod.outlook.com (2603:10b6:8:144::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Tue, 7 Oct
 2025 18:07:20 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 18:07:20 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "tglx@linutronix.de"
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
Subject: Re: [PATCH v10 12/15] x86/traps: Communicate a LASS violation in #GP
 message
Thread-Topic: [PATCH v10 12/15] x86/traps: Communicate a LASS violation in #GP
 message
Thread-Index: AQHcN1cyrAHrruq9jUqLS4MX5MY77bS2+8KA
Date: Tue, 7 Oct 2025 18:07:20 +0000
Message-ID: <b8876f149adfcd47e60a0a6e1640b97c321e6a74.camel@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
	 <20251007065119.148605-13-sohil.mehta@intel.com>
In-Reply-To: <20251007065119.148605-13-sohil.mehta@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB7622:EE_
x-ms-office365-filtering-correlation-id: 52dc2b62-f268-4085-46de-08de05cc5bde
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QXNDVy9lM2ROd1A4ajVsUk1KU2FzdDNVbU5RUlN3VHpjaUdOZ2oxcmFSMElE?=
 =?utf-8?B?eWV3diszbThzWnJHVXYxM1BjQmJDZjlCZnhraDkybFlQbFpLdkI2NzJERXZ4?=
 =?utf-8?B?Zkc0enc0Z0Yzd2VqWmJpQjNidlZSeWVpUUxXaCtrNVlMWm54Ym1WZWU1bWhG?=
 =?utf-8?B?Ri93MlNxZE5TNUVwUzFlSXZXcHVVQ1BsVU9VRk1KcjI3azNUTGU1NHE4NmFk?=
 =?utf-8?B?dlVUUEFmN3VtVUJXUDhuanE2RjM0cUZxUDZsbGd2aURaYlRtVktYcTlNdyth?=
 =?utf-8?B?UHhhNGhDdEZkSG5uSTF5RzhMbGcxRFpQVW15aVVrOGZUa0wxNHFKcTM1eGxz?=
 =?utf-8?B?dTljMlkvbGpOSjRMamtidVlrZWNWalN4SU9kYXI0eitTMXNwQXBFWEJZcitG?=
 =?utf-8?B?SitlK3dXaXViM005V1ZzVHM3T3cvV3J5MVR6a091QjJiOXZqL1NjeUpKbXFO?=
 =?utf-8?B?Q2VPeXBWaTk3WlR6cCtTdzZjOTRPVnhWK2lUbzlGbUxRd0YrVnNZVVkzWXBY?=
 =?utf-8?B?TWErcFV5T2J3czNLaWJwNkpKL1czYjd4STc1TENWN3c3Ni8xczRPVWg0TG5y?=
 =?utf-8?B?NExLVTZQNlArQ2hxVlBGM1JqUVhpc3B1dWxLZEtudGthSEZyVGhIVWF4TjI5?=
 =?utf-8?B?NjZ4eC9hVGhEdis5ekxQTm8xenpRQ0paeVBDNFd5YWpUVnZFMmVraERFNXlJ?=
 =?utf-8?B?VFdZTTJvd2VpQW9uNTN1SHhQMzQzWE4xOEluV0tDajJBVkI2aEFOUTBUWUZT?=
 =?utf-8?B?ZTg2VS90NzM0Q0xsakc1R2ZITnFONXV2MU1xaDJURUNnYXFwbUpCaTU3c1Vh?=
 =?utf-8?B?QTcvSGJQdFZoM0c5RHhsT2pvTzlEbEJTZFAvb0RKUFFrTklrbnZBTDRod0Jj?=
 =?utf-8?B?SVlBYVYxWFM5ZnB5cWpUd29JRnhHMG03Uy8wd3ZacFFsczVLSmg4bnlSWUJa?=
 =?utf-8?B?MjlHTTVBNG5XWHptVVM2RXpzUDJCTHJlTGZQT3dtUHZpaHUxc1gydHU1WGN1?=
 =?utf-8?B?bSt6cEFlbEZnbktTU2ZpSkMxZlF2OVdNcGhYR3pIZXlIcHg3eEtVeEJRZzZx?=
 =?utf-8?B?andsTitRMXVqNXhxempkbVBCZUU5eTYxWXNMSVdKSEdDYVRhNDRhd1hZMHZE?=
 =?utf-8?B?MTZIbVZsM3A2YTJCWjJXb25ZcHZvQmtLeHJNUnJ3WVVmWDY1eHp2WjZnOFJq?=
 =?utf-8?B?empQRkNNb0JxbCs3Qzlob2xGZER6T3RhQk5WeHAwcWdRQ3BObkRFdTNZS1R4?=
 =?utf-8?B?VDZUWmsvc216U0dQQjBVRkgyY01pMU1Cekl5bEkwRkNpZ0VjeXlxWGlySDBr?=
 =?utf-8?B?SXFEVVg1cFp1ZXhaY1I2T0haZGFSNG1yNGIxL1NaeGEyOVd3eXpqdHlEOEpO?=
 =?utf-8?B?VnRmKzBMOGhPaUdHai9JaHpZRGtLRmNpOW9PWFRSYnhiLzQzQ1dwankyeC83?=
 =?utf-8?B?Y2NDQkg0dXo4aVhyZFA1bWdmdWVjOVYvWVRuNHk1NE1zN1Roa1cxTkR3enZk?=
 =?utf-8?B?TFV3NDR5NFIxaXdqWDBiVjhMQ0lSK0VablFEcStuUmI3SHV6MGp4VEZTY0Fx?=
 =?utf-8?B?ajV3MG91ZUJUWlYxRkd0SWJva0Q0Vk9TaXc1WnhrckhyOFhYU25VWmtuTFZU?=
 =?utf-8?B?b3QwMXQ0c1gwSGg2aHRXR0MxUCtvSkxUcGs3ckx6eDZlazVzamNHZGtTT3pP?=
 =?utf-8?B?ZXRjNkRrRVkvSW5Pd2hCZGwvSEs2NEhYRVBlY3g4WkJsMGZZT3dzZ2VtTjlB?=
 =?utf-8?B?bWJnU1BHZFBEakpyalQ1YTc3SjEzQWtHUGJkTlVKN24zWjdEZmhPck91emQ5?=
 =?utf-8?B?MU4wME1sTk1wT09XdE9CTzNBSlRCeTM3REJFc1NyTmdCUXVqcHZwRUJ6cktY?=
 =?utf-8?B?ejRnMGEwaFpvYklNM20rcGc3aEt4aVE3MlBjR3dwOWllalhpcmk5MzdWMFZR?=
 =?utf-8?B?Wm1EVXVnY0xSVW1CQVJLd3pqMit6cEl0UDR4KzBuTXVtSTZiakRmcUdweDh0?=
 =?utf-8?B?TElpK21BTTd4dld5Y0VoZFgySWwxRlRQUWVxM1hrM0RNTHAwNldHZXhhTUFH?=
 =?utf-8?Q?7UbwHL?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tm12ZmZLTlphNVRhb2dqQkl2bUhMYWdZbldZV1VRSXBiUjd6VlQweFdwSW9m?=
 =?utf-8?B?bitZUElLREJGeUJUMXJIcmZRRDZNRW5sQWoxbWwyLzFLdWU2U3d0citaUDhm?=
 =?utf-8?B?UWg1aGRHVnhnU1ZZSHUyVmdMMVc4NHdlRmJZcS9oaVFVV3hlc0FnY0cvdXFN?=
 =?utf-8?B?STVYYmJhaHY0eUx0M3ZRb3VGeEMvN3dsS1ArYUVEcUVPKzhTWnV6ZGhORFR6?=
 =?utf-8?B?Vjk5a1JzSENrd3k4dGFvS2NNSmdXL2ZWbzNkMjhFMlBSdHN3VHF4WEFpeFYy?=
 =?utf-8?B?Sm9kV3BsaVh3dHhrUFRMYzFYSzJYSS9iMndldGZ3WHczVjhuaGNESFlWWVh1?=
 =?utf-8?B?ZjB1d01EVTNNa1hVeHNlTTVQT0FiQU0xM2EwNzI0VVRGQW1zUnZGT1FXTk02?=
 =?utf-8?B?V3BJcUlzVkhTS2cvL3FWSVlMRVZtb1crMzJ5QW94dXRyaW00TEhMc1MxbFJa?=
 =?utf-8?B?UzVBS3Rlb2NFeERGVHpOelg1QnBHeHFaTzFjb2FvZFk2ektvUUlzVmlLU3pq?=
 =?utf-8?B?S0VDN3RpdDNQM09iWGNIYVQ0YlM2UG5rZERZNjRLbjROMUNsc3pLM3g4ZERW?=
 =?utf-8?B?aDNZSTBFa1BpVUdGc0Jsem4rVzdQdUdRVGo4Z3Y3NVlWWTVBWmwvZmRpUlNa?=
 =?utf-8?B?MGdsTkUyaHBXNGxuSEVXOWRkeWpNclVabU5qRkNVWTdtQm16anp1czVxdlY2?=
 =?utf-8?B?cTNoRE9mNHJXYndlVE5lcG55M0JlT3ZHQjBPbEZjU04zZ1RucGszMjBicFdw?=
 =?utf-8?B?N3hleEltQ1o5YUwxOE4vQ1d3WXpZV1BGWHlVWEZtV0x6ZDIva3g5bys4Y0lC?=
 =?utf-8?B?SVA1SVAzTlZGU3AvaHJSUk51S2o3ZFZwRXVDaGI1eEt0ZUxuT0h4VXJVN0hv?=
 =?utf-8?B?bjlhUEN1dzNaTysrS1lzK2gwU0hhSGdUaUlibWdyTGVjbzRGNWxrcnFaVGxZ?=
 =?utf-8?B?N01FRUVkb3NnbW1hUm4rM0dNYS9Ga24rckRqaVJFYWtYK0hZNElkZ0pybzVQ?=
 =?utf-8?B?Zk8zaGRMQ3lDY3BMb3NqSVhZRUNVVDFXNzVCOVFzMis5bVJoaGhmdDNVVm1p?=
 =?utf-8?B?RmtCQW5TNGZyNERBMytQS1B3aW1yTFJUYWloQUFmY1VOVmg3VktldXl6VjZW?=
 =?utf-8?B?ZkovQ3pFTWp1TGhWTGxZSEJGWnNsS2FzbGpYN2xocWhSR2ZGWlFuRWVVK3N4?=
 =?utf-8?B?bW1zbUs1ZW0rbzM0OE53aUlFVVNUOTNmQTY5N1U0NDc3bW9Ib3IzcXc2a3hj?=
 =?utf-8?B?L25aV212T0lZR252bUVrdCt2UGMvRW14ZXl1Sk9USUJmb1doT01pbGdFc3Vy?=
 =?utf-8?B?UnNoN1B3MHZDZU5pNWsyQkFBek5rdC9vSFVDcyttWXoxWUdlYUk5K0tkN3dG?=
 =?utf-8?B?YjlQUjdhYnlBNVEwNnNtWC9WcDQva3ZiM05CWituZTRtaWdQbDBjVjRVcEJN?=
 =?utf-8?B?aGJ5ZU5tTUVCNENXTFdyd2lrN2FMWWxJUGNVK0xtcFdZcGFYWVphemRBbW5W?=
 =?utf-8?B?V1RsUFdyTW4vSVdBc0JTdzRQVnIzSWk0NW9HemF6cDJPQjhVcjVVanhsYk9G?=
 =?utf-8?B?K3lTVFdNeEQzS1RGdUZqWitINlR3UFVXQ1Y4VGtQNE9ZTHppRTQzODR4N216?=
 =?utf-8?B?MEZpVnNKTHovTWdQdllJK1FVMHdDL2REeUI0WCtQNnMvcm9RRUlONkk4cTE4?=
 =?utf-8?B?dFJ3KzlneTByM00xanFLQkhTMEZtZUt6TFhQdVN3MEpoTUErL2xOWTcvcjZn?=
 =?utf-8?B?WUVTOWFQRHZRaHN3dk5IU2JqN1hJYXlOOWwyaTIrOHdpejRVM0owRTRmYXBT?=
 =?utf-8?B?NG9sZytnM1RNS3hrcFRTTGoyUm1vT2dReE4wdXdlTDlGZTJ2dUJLbDV2aTRF?=
 =?utf-8?B?WGpCNzFVMDhUQnorUG5pTWVwMFl1SFlXemdocnBMdlkyWWhzeHJsTVZ5R0lL?=
 =?utf-8?B?am4vSkkrM0JUejdmT1c0blo0L0tUdVUzbFNJY2VSOWE1NkFVUE5Kb1FNaEZR?=
 =?utf-8?B?aVFlQW1QRm5sN0V0VGk1VHZCdElvalRHRXUrTFIyS3U2clcvYjFhWnUzZTVI?=
 =?utf-8?B?MllPb2V6MWxXRmdvWmZReVF3QUlYVlVUMytJaWVYVkhNeDhzanBabERteUNU?=
 =?utf-8?B?YTBmQ1FiMW9GbE44MDFsM2JHYitZUXkzME1reDBXb1hiV0ZlNURTanJiWWIv?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38C44E9452EEFB45B4177B348AC39DCE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52dc2b62-f268-4085-46de-08de05cc5bde
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 18:07:20.5547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nzkl5SvKUPUkrN9HaIVR8T09XVjtmbSGxAgGHeSKayrV3GzUnVA+rgSrbl6atbRcc+LI61MyfWtvx2vvZdKZxQfWlJYOxrx4EkDcTVkcrmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7622
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTEwLTA2IGF0IDIzOjUxIC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
RnJvbTogQWxleGFuZGVyIFNoaXNoa2luIDxhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwu
Y29tPg0KPiANCj4gQSBMQVNTIHZpb2xhdGlvbiB0eXBpY2FsbHkgcmVzdWx0cyBpbiBhICNHUC4g
UHJvdmlkZSBhIG1vcmUgaGVscGZ1bA0KPiBtZXNzYWdlIGZvciBhICNHUCB3aGVuIGEga2VybmVs
LXNpZGUgTEFTUyB2aW9sYXRpb24gaXMgZGV0ZWN0ZWQuDQo+IA0KPiBDdXJyZW50bHksIGEga2Vy
bmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSB0cmlnZ2VycyBhICNQRiwgd2hpY2gNCj4gcHJp
bnRzIGEgaGVscGZ1bCBtZXNzYWdlLiBCZWNhdXNlIExBU1MgZW5mb3JjZW1lbnQgaXMgcHJlLXBh
Z2luZywNCj4gYWNjZXNzZXMgdG8gdGhlIGZpcnN0IHBhZ2UgZnJhbWUgd291bGQgbm93IGJlIHJl
cG9ydGVkIGFzIGEgI0dQLCB3aXRoIGFuDQo+IExBU1MgdmlvbGF0aW9uIGhpbnQuIEFkZCBhIHNw
ZWNpYWwgY2FzZSB0byBwcmludCBhIGZyaWVuZGx5IG1lc3NhZ2UNCj4gc3BlY2lmaWNhbGx5IGZv
ciBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEFsZXhhbmRlciBTaGlzaGtpbiA8YWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogS2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGlu
dXguaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTb2hpbCBNZWh0YSA8c29oaWwubWVodGFA
aW50ZWwuY29tPg0KPiAtLS0NCj4gdjEwOg0KPiAgLSBNaW5vciBpbXByb3ZlbWVudCB0byBjb2Rl
IGNvbW1lbnRzIGFuZCBoaW50cy4NCj4gLS0tDQo+ICBhcmNoL3g4Ni9rZXJuZWwvdHJhcHMuYyB8
IDQ1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC94ODYva2VybmVsL3RyYXBzLmMgYi9hcmNoL3g4Ni9rZXJuZWwvdHJhcHMuYw0K
PiBpbmRleCA1OWJmYmRmMGExYTAuLmE1ZDEwZjdhZTAzOCAxMDA2NDQNCj4gLS0tIGEvYXJjaC94
ODYva2VybmVsL3RyYXBzLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL3RyYXBzLmMNCj4gQEAg
LTYzNiwxMyArNjM2LDIzIEBAIERFRklORV9JRFRFTlRSWShleGNfYm91bmRzKQ0KPiAgZW51bSBr
ZXJuZWxfZ3BfaGludCB7DQo+ICAJR1BfTk9fSElOVCwNCj4gIAlHUF9OT05fQ0FOT05JQ0FMLA0K
PiAtCUdQX0NBTk9OSUNBTA0KPiArCUdQX0NBTk9OSUNBTCwNCj4gKwlHUF9MQVNTX1ZJT0xBVElP
TiwNCj4gKwlHUF9OVUxMX1BPSU5URVIsDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgY29uc3QgY2hh
ciAqIGNvbnN0IGtlcm5lbF9ncF9oaW50X2hlbHBbXSA9IHsNCj4gKwlbR1BfTk9OX0NBTk9OSUNB
TF0JPSAicHJvYmFibHkgZm9yIG5vbi1jYW5vbmljYWwgYWRkcmVzcyIsDQo+ICsJW0dQX0NBTk9O
SUNBTF0JCT0gIm1heWJlIGZvciBhZGRyZXNzIiwNCj4gKwlbR1BfTEFTU19WSU9MQVRJT05dCT0g
InByb2JhYmx5IExBU1MgdmlvbGF0aW9uIGZvciBhZGRyZXNzIiwNCj4gKwlbR1BfTlVMTF9QT0lO
VEVSXQk9ICJrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIiwNCj4gIH07DQo+ICANCj4g
IC8qDQo+ICAgKiBXaGVuIGFuIHVuY2F1Z2h0ICNHUCBvY2N1cnMsIHRyeSB0byBkZXRlcm1pbmUg
dGhlIG1lbW9yeSBhZGRyZXNzIGFjY2Vzc2VkIGJ5DQo+ICAgKiB0aGUgaW5zdHJ1Y3Rpb24gYW5k
IHJldHVybiB0aGF0IGFkZHJlc3MgdG8gdGhlIGNhbGxlci4gQWxzbywgdHJ5IHRvIGZpZ3VyZQ0K
PiAtICogb3V0IHdoZXRoZXIgYW55IHBhcnQgb2YgdGhlIGFjY2VzcyB0byB0aGF0IGFkZHJlc3Mg
d2FzIG5vbi1jYW5vbmljYWwuDQo+ICsgKiBvdXQgd2hldGhlciBhbnkgcGFydCBvZiB0aGUgYWNj
ZXNzIHRvIHRoYXQgYWRkcmVzcyB3YXMgbm9uLWNhbm9uaWNhbCBvcg0KPiArICogYWNyb3NzIHBy
aXZpbGVnZSBsZXZlbHMuDQo+ICAgKi8NCj4gIHN0YXRpYyBlbnVtIGtlcm5lbF9ncF9oaW50IGdl
dF9rZXJuZWxfZ3BfYWRkcmVzcyhzdHJ1Y3QgcHRfcmVncyAqcmVncywNCj4gIAkJCQkJCSB1bnNp
Z25lZCBsb25nICphZGRyKQ0KPiBAQCAtNjY0LDE0ICs2NzQsMjcgQEAgc3RhdGljIGVudW0ga2Vy
bmVsX2dwX2hpbnQgZ2V0X2tlcm5lbF9ncF9hZGRyZXNzKHN0cnVjdCBwdF9yZWdzICpyZWdzLA0K
PiAgCQlyZXR1cm4gR1BfTk9fSElOVDsNCg0KVGhlIHBhdGNoIGxvb2tzIGdvb2QuIEknbSBub3Qg
c3VyZSBob3cgZmFuY3kgd2Ugd2FudCB0byBnZXQgaGVyZSwgYnV0IGFuIGlkZWEgaWYNCnlvdSB3
YW50IGl0Li4uDQoNCkFib3ZlIHRoaXMgaHVuayBpczoNCg0KCWlmIChjb3B5X2Zyb21fa2VybmVs
X25vZmF1bHQoaW5zbl9idWYsICh2b2lkICopcmVncy0+aXAsDQoJCQlNQVhfSU5TTl9TSVpFKSkN
CgkJcmV0dXJuIEVYQ19OT19ISU5UOw0KDQpJZiBjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFU
VVJFX0xBU1MpIGFuZCByZWdzLT5pcCBpcyBpbiB0aGUgbG93ZXIgaGFsZiwgd2UNCmNvdWxkIG1h
a2UgYSBwcmV0dHkgc3Ryb25nIGd1ZXNzIHRoYXQgaXQgd2FzIGEgTEFTUyB2aW9sYXRpb24uIEkg
Z3Vlc3MgdGhlIHNhbWUNCmFyZ3VtZW50IGNvdWxkIGJlIG1hZGUgZm9yIHRoZSBjYW5vbmljYWwg
Z3Vlc3Mgd29yaywgYnV0IG1heWJlIGNhbGxpbmcgYSBOVUxMDQpmdW5jdGlvbiBwb2ludGVyIGlz
IG1vcmUgbGlrZWx5Lg0KDQo+ICANCj4gICNpZmRlZiBDT05GSUdfWDg2XzY0DQo+IC0JLyoNCj4g
LQkgKiBDaGVjayB0aGF0Og0KPiAtCSAqICAtIHRoZSBvcGVyYW5kIGlzIG5vdCBpbiB0aGUga2Vy
bmVsIGhhbGYNCj4gLQkgKiAgLSB0aGUgbGFzdCBieXRlIG9mIHRoZSBvcGVyYW5kIGlzIG5vdCBp
biB0aGUgdXNlciBjYW5vbmljYWwgaGFsZg0KPiAtCSAqLw0KPiAtCWlmICgqYWRkciA8IH5fX1ZJ
UlRVQUxfTUFTSyAmJg0KPiAtCSAgICAqYWRkciArIGluc24ub3BuZF9ieXRlcyAtIDEgPiBfX1ZJ
UlRVQUxfTUFTSykNCj4gKwkvKiBPcGVyYW5kIGlzIGluIHRoZSBrZXJuZWwgaGFsZiAqLw0KPiAr
CWlmICgqYWRkciA+PSB+X19WSVJUVUFMX01BU0spDQo+ICsJCXJldHVybiBHUF9DQU5PTklDQUw7
DQo+ICsNCj4gKwkvKiBUaGUgbGFzdCBieXRlIG9mIHRoZSBvcGVyYW5kIGlzIG5vdCBpbiB0aGUg
dXNlciBjYW5vbmljYWwgaGFsZiAqLw0KPiArCWlmICgqYWRkciArIGluc24ub3BuZF9ieXRlcyAt
IDEgPiBfX1ZJUlRVQUxfTUFTSykNCj4gIAkJcmV0dXJuIEdQX05PTl9DQU5PTklDQUw7DQo+ICsN
Cj4gKwkvKg0KPiArCSAqIElmIExBU1MgaXMgYWN0aXZlLCBhIE5VTEwgcG9pbnRlciBkZXJlZmVy
ZW5jZSBnZW5lcmF0ZXMgYSAjR1ANCj4gKwkgKiBpbnN0ZWFkIG9mIGEgI1BGLg0KPiArCSAqLw0K
PiArCWlmICgqYWRkciA8IFBBR0VfU0laRSkNCj4gKwkJcmV0dXJuIEdQX05VTExfUE9JTlRFUjsN
Cj4gKw0KPiArCS8qDQo+ICsJICogQXNzdW1lIHRoYXQgTEFTUyBjYXVzZWQgdGhlIGV4Y2VwdGlv
biwgYmVjYXVzZSB0aGUgYWRkcmVzcyBpcw0KPiArCSAqIGNhbm9uaWNhbCBhbmQgaW4gdGhlIHVz
ZXIgaGFsZi4NCj4gKwkgKi8NCj4gKwlpZiAoY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVS
RV9MQVNTKSkNCj4gKwkJcmV0dXJuIEdQX0xBU1NfVklPTEFUSU9OOw0KPiAgI2VuZGlmDQo+ICAN
Cj4gIAlyZXR1cm4gR1BfQ0FOT05JQ0FMOw0KPiBAQCAtODM1LDkgKzg1OCw3IEBAIERFRklORV9J
RFRFTlRSWV9FUlJPUkNPREUoZXhjX2dlbmVyYWxfcHJvdGVjdGlvbikNCj4gIA0KPiAgCWlmICho
aW50ICE9IEdQX05PX0hJTlQpDQo+ICAJCXNucHJpbnRmKGRlc2MsIHNpemVvZihkZXNjKSwgR1BG
U1RSICIsICVzIDB4JWx4IiwNCj4gLQkJCSAoaGludCA9PSBHUF9OT05fQ0FOT05JQ0FMKSA/ICJw
cm9iYWJseSBmb3Igbm9uLWNhbm9uaWNhbCBhZGRyZXNzIg0KPiAtCQkJCQkJICAgIDogIm1heWJl
IGZvciBhZGRyZXNzIiwNCj4gLQkJCSBncF9hZGRyKTsNCj4gKwkJCSBrZXJuZWxfZ3BfaGludF9o
ZWxwW2hpbnRdLCBncF9hZGRyKTsNCj4gIA0KPiAgCS8qDQo+ICAJICogS0FTQU4gaXMgaW50ZXJl
c3RlZCBvbmx5IGluIHRoZSBub24tY2Fub25pY2FsIGNhc2UsIGNsZWFyIGl0DQoNCg==

