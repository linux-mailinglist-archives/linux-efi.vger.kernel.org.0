Return-Path: <linux-efi+bounces-3452-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A85A9AD6C
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 14:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677A23A54AE
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 12:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC002237707;
	Thu, 24 Apr 2025 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZFhNcjZp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86352288C3;
	Thu, 24 Apr 2025 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497780; cv=fail; b=h1asQUwl84h0DG9z4QtSFfBLGDIV9etsDsnSfPMXGxLuo8YhYskDPYFzoH6Ryb9jLgqx6+NaNGiVL3Y/lY5Ndf+dG0uLvpSNglwOVvNCjcL1yXv3qB3TzIoZScdhTlZD0422tEBjC8E+wEDDcEYNuEvv71sIqI3FaZXshhdfwnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497780; c=relaxed/simple;
	bh=jNySl43K3iirpRyyifM7R4O4nOijbc6nNeXaOjisqts=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BHXgZ70IoaDnYP1032xASgRBcMoXIPpaqHbkEZg5qeQP3/KCBaN6UoPGz9MUfvcx4h0bRGoqPUZAyCeZAxaRpltkjQsxDhsv1+4T9MDmSrw1xKtSGTE9SucdsnBB6npMOcXGxx/6ufKLUpN79ceJqixRVjqAe3MHSBJYITr+DRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZFhNcjZp; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745497779; x=1777033779;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jNySl43K3iirpRyyifM7R4O4nOijbc6nNeXaOjisqts=;
  b=ZFhNcjZpz1uuiG6hIszioxV21emjEHNilX3tfi53KXUhEg6Rj12p3Xw4
   nd3XEWOeufN6cN+Mhe8iHiE8XI+7kNsOeesQt9cGGvo6XrCSTD9cr2J0a
   iNC2aUxzW9OpW7Nr36HR4JNOTODpkH8g/sRVyz+4Qn8xbEPR/oy++HQvW
   DGMgpOsxRKXvURq58ZwT2yztvP22tQU1UjWJq6MBRf+CkpNPFsQb/D3hp
   4d6jMwZC2l54BBp24a1UUFBJ70JLHnjRqj1lTyxVJ19A/WikvnTy+afkY
   D3c5DCT/YjNEmgXqbeS8co8Us0f9KmXRzNPGNmN6Fy19WUuur2RTp1fW1
   Q==;
X-CSE-ConnectionGUID: dro1vjdZQ86znhVyq/dMpA==
X-CSE-MsgGUID: cVFFgGRrTSStdPVbQ6sFKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="46999422"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="46999422"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:29:38 -0700
X-CSE-ConnectionGUID: 1E3c8c7NRq+4LiiI0WPzYg==
X-CSE-MsgGUID: ebGgnhH2RBOBuTP33w/LsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="132908297"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:29:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 05:29:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 05:29:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 05:29:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTCL9Y/5vp9YJgwMefJgqT97rGLWAspDjLZVX6eKyEMFRNZAWn+IJy7y/Sjz9T/1dEq1bieRMkmLSQweNGJsAWzd4u+bqTgDcmljG6EtfH+8/EiYd1aAgEDBctjiDgbrviy4k9scTnNBFggR47O0ncJ7IxL1JeLjK+dgPeAoWzZdxCk67vcb6V9riEBYezTrvn8HDCBT2jCmosD0EKdZQRaoyWZMYpDQ2SFlcXYodXNhl5liWjnhzCdld23Sc16TqitnJBAw9NEfvm9Dv6Y2EwHx6unJf1aktI8L6ieC6knl7totEdNvvhYxy4G5w2Mu64/TIoUfd8dLhjSvwb02YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNySl43K3iirpRyyifM7R4O4nOijbc6nNeXaOjisqts=;
 b=KB7EPMsWqEfHbEYOo8thjdxA7kPAnYhvQBnyEiJkfFruhncvvYhDYuzP2AjbHTBNr/Uww/xVJUuxfz/msea6+MuvcF4KBVyCUV4AbItkdfADV2bfADvhIJz9aY108OaCQUM6vkL9uyyLmTPuW6fef0q7be/GG+79gdEJd4RouoH6h7n4xPUpl3QbhHzcjgtvzShm3QKGE5l1cr3c+7o1CXIzCojbN+miVu1Hmj85NgrNHvvzwkg7RieHJ9GV8fjICBcOEOzjHxoutKt6fV/tPxSsiT1HYpsY98XWxE56WDLTkqsZci+BOZSlzXztrYKfeXXNckpYn0Ztln4hW00C9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BL1PR11MB6001.namprd11.prod.outlook.com (2603:10b6:208:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 24 Apr
 2025 12:29:18 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 12:29:18 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "x86@kernel.org"
	<x86@kernel.org>, "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "ross.philipson@oracle.com"
	<ross.philipson@oracle.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>, "peterhuewe@gmx.de"
	<peterhuewe@gmx.de>, "James.Bottomley@hansenpartnership.com"
	<James.Bottomley@hansenpartnership.com>, "trenchboot-devel@googlegroups.com"
	<trenchboot-devel@googlegroups.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"mingo@redhat.com" <mingo@redhat.com>, "Ghatraju, Kanth"
	<kanth.ghatraju@oracle.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"luto@amacapital.net" <luto@amacapital.net>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "dpsmith@apertussolutions.com"
	<dpsmith@apertussolutions.com>, "jarkko@kernel.org" <jarkko@kernel.org>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>, "mjg59@srcf.ucam.org"
	<mjg59@srcf.ucam.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "nivedita@alum.mit.edu"
	<nivedita@alum.mit.edu>
Subject: Re: [PATCH v14 04/19] x86: Secure Launch main header file
Thread-Topic: [PATCH v14 04/19] x86: Secure Launch main header file
Thread-Index: AQHbsttyyPZHG7nt802BE1VhSFOzvLOyw0SA
Date: Thu, 24 Apr 2025 12:29:18 +0000
Message-ID: <e2d00d7cc4cfc33a3b328fe8386f6d164bc46184.camel@intel.com>
References: <20250421162712.77452-1-ross.philipson@oracle.com>
	 <20250421162712.77452-5-ross.philipson@oracle.com>
In-Reply-To: <20250421162712.77452-5-ross.philipson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BL1PR11MB6001:EE_
x-ms-office365-filtering-correlation-id: d17489d4-2cb3-4ab9-7683-08dd832ba211
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NDg0UVNiMm9LL0NkWlBBWnpLTHF1azZqRERMVG9Kd3lEY1ZpOEJUU1FKa3pp?=
 =?utf-8?B?cFpqSTNIVy92M3pkM1dOYnBFKy9oUVp5dTF6cDM5SVZpa01BVWJsN2VaeEJu?=
 =?utf-8?B?NHorYUI1eGxtV3dLdkNzZFhYdDZOU1o4T1UyeE1zcXUwaWQ4QTIzMnpZcmV1?=
 =?utf-8?B?Tk53SUVQYWdXYnlTRjNVcFYyaUpycVFDelhydVc1cGR4ZTZwSDA2TkVZQ2w5?=
 =?utf-8?B?OWNHZDgrVUpSVEs3WmltNkZBSzM3cjNJYjJKSlU2L211eUpnM0Z4b0NsVUhs?=
 =?utf-8?B?aHZVc3hkU2M4RzZMSUhRT3pNVHRvQXhtbFBZK0ZBRldHVHJTMjFhOE1mam9v?=
 =?utf-8?B?bW1Zb2htbWpxT2NhbW94T2VNZG9PdU5WbmpQZjNISGRFZzluOG1rRjBtTXpL?=
 =?utf-8?B?OFA1Q01paTRGYmpDTHlRSUFLRFR0QTFqUFB3WEJKUWpzL2hsWkVnZEFmOEcz?=
 =?utf-8?B?TkltZnFpdnBZMHNNTTVDU0F4bEN0NWFaajdMM2lZSmpUQ3kvMjhOaExZZGJh?=
 =?utf-8?B?T2U5b2htZWFNMm1QOGJ4R25hZTlSNW5wblVvSk1oY1pGc1Juc29KVmxWQ1Fa?=
 =?utf-8?B?V25QQnpMT29rVllQeGdhVzEwQnJUNmx5UWhtMEQrUDBqR00wclovUEd6c2RL?=
 =?utf-8?B?alNBSkxRYllFeU5UYTdzVVBQSWhsT1p3WStPVExabzlZKzlnRkgrSU1LaHp0?=
 =?utf-8?B?UXdlQnEwSmlYNEs3OEovOExuRWc5OVNNZkxqd1hUSnVORk9VYjE4Sy9XRy9P?=
 =?utf-8?B?UkpzbkdEVS9sNGZSNVE0N0J6ZDcvL3VwV3pXQ3FFOHJzbnJpU0ROWXNYOG9R?=
 =?utf-8?B?Q3gvQ2wrOER0WmhHcGJQelZzMWQ3TVBVVitZc09DQ0VoMnllVmFXT05RT0pi?=
 =?utf-8?B?Q25FOVpjWEx4Q0tCVVlqKzVpM2tOTWsxTVEvWkRTV2ppeDZpK0hVZ1ZEa000?=
 =?utf-8?B?VjNpSENsa2dUalMxRHhYb0NKLzZ0N1dsMXJPdytUZ2N4WGhadFJwWXVJaDNP?=
 =?utf-8?B?YUNCdzZ2UlJuWWhYZ25wMjRjb08rQTVYRzQ0UEQ5M3dNakZSWkJjS0VwZ2gx?=
 =?utf-8?B?K0pHYkQ4b0E5TXErU042NXVrVTZjNjNJZ1M0RUZpQzRxaTdyVW9hL0dxMkkx?=
 =?utf-8?B?YlFZWXJ4dlRMVkJ0Y0RkY3FHU21vVXdXdXlUbUNCZFdnUHovRE5RV1VOdm9y?=
 =?utf-8?B?WU5XTjJFV1FSNjhxTHdhQ0FWcGdUQ0dPWHZuWkFmQ3lqYzZjK085QkFGM0h6?=
 =?utf-8?B?KzBMaW9NaW1IV2NVTW1OcGlGVlBWbUtQSTlyNmNNN1RLVXZrMFJJYS8xbXk1?=
 =?utf-8?B?NjRIZUhnNmlrbFc3VU5CN0lrN0hiWkhNbFRrTWQ1MlVySks0QlJaSHROZzR1?=
 =?utf-8?B?YzZheHRmN0JJek1DczJxem5ua1ZZU1ZIa21IbmpyREYwVW42Nndrc3VFREYx?=
 =?utf-8?B?dFMwbDViNjBEWmVmbEtzUGtlL3F4alNMODRLZkFnZURoajVBcGFBL2ZYcEJz?=
 =?utf-8?B?ZnY4S0pHUXVpN2FveXY3ZEViRGFoc0tQd3ZuT2xvRVdWL3QwaDBYMElhaHBU?=
 =?utf-8?B?QWhFcjlSU205a0Q5WDVGYVdTRVpLY3V6OFQ5NGdTTTNyTW9aTTM1by94d3NQ?=
 =?utf-8?B?MFlLb3d4cElTazJXQ0xBTlFCTVJpU1R4SHpPQjBmdFJ5NE1ZVFBBMEFidVA5?=
 =?utf-8?B?eldJbDRZZUFCbmc5WVVlUzlNY1hQLzErRzNLeTZsekhQSTZIMUticGtKUEVX?=
 =?utf-8?B?aU8zV3FlVmsxbmlxbkNhNFRwWDFodGEvVEJhbU9IcUg0eGY0QjV0d3ZYYnFV?=
 =?utf-8?B?R25GVEdpVzI1aWY3NnBWSUVHbDdxNkpsbStzVGx4T3FlYjh6V3NEV01uemhT?=
 =?utf-8?B?Y29iUHRhL1Z6b1BuNHI1UnZGL2ZnY0RKVnFZZkVCWFIydjB1YTlOQlJWNzFH?=
 =?utf-8?B?cHg2VFVHUjlTQ1F3Y0ZqbkdlM0RvV2U3TUFGdUpBeWdMUzNXMnVSSGtpMG1M?=
 =?utf-8?B?cDFreE16N05RPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHhLRzR1MDlqRklTNWtLTVBEQmw1aHI0cEg2NmIwVFpmSnhvcytYM1pkWS8z?=
 =?utf-8?B?SWFuRlpIRkF0VjJEQmNTTHNQWHhZQ1pybzFsb0hKL3NxMmdyMEgrWk52TWtB?=
 =?utf-8?B?Uk40YVBEamlFd1NRWnFmTUJrdXgxaENNeERIZW9aeXQ0T2lFNFNiVVE0SzBG?=
 =?utf-8?B?NmpSaEU3YkJwdVpxMmN5bWU2SlMwWXkwdnhFcU5oeFJSdUNCTTlxNnlBLzJB?=
 =?utf-8?B?QWRYUHVzb0x2NkdIK0VIVjFwUHgxZGV3ZG40d3RJSExUUXgzUEZqdXBwVWgv?=
 =?utf-8?B?VjdyZkc1NzFsb0xod080ekgzVStqSlYyWkNLMTZ6aTBhbGg3S2VhOGJ5SlFB?=
 =?utf-8?B?TzJyVVNyTVlHZEFFY3FvVDk5UWJid3ZDVDVoK2lVQ3NPWWE0TkdFRkxpUnlC?=
 =?utf-8?B?ZlUwRjFoRUhGNDAyQkdnUGduajNsamlHV3FQL2w0V1BMcjRjRTdNeVdrQUtN?=
 =?utf-8?B?TThhNkNZcnJvZDA1L1l3V1l5UXVCRDJHZUZJMWk5S2RCbDJwelpUS0I0SHBX?=
 =?utf-8?B?WWhzT3cxUEU1TEkrUGNwNGhYcXRjY3N4S1VjOUtoakdrMjJ2TVFlWmhyK25h?=
 =?utf-8?B?YlR6OE5DT215RjMraHg3aWJTTWhtcWNxcXhuS3FlTWhyRGRjTGNiSTBNWkc5?=
 =?utf-8?B?Zk1ZajBrdmNOdXFKSTROVkJaOGNkb3BtRkhvZFMralNGTU1zNjYzazNaNTRk?=
 =?utf-8?B?MnNTU0xURG5TM1pXZ09oV2VaYVVjeEJCUWdOVEJ5NWh2cTJzMUgrNEY5K1dj?=
 =?utf-8?B?WFUybTh0M0E0V2FHT00yMTdSKzByZVBFZ3RJNWErQk1QMWR2TTh5WFk3VU1p?=
 =?utf-8?B?LzFKc2E4N04rVks2bStNb3AyODZ0T2VhNno3endDeEVFUFk4MkdHRmY2VWFN?=
 =?utf-8?B?aHhFMW9CbWVBalI3TFUwNUh3QWUycDJmQ21nQ25ROUMxd2QrSlpjV1pKSXh1?=
 =?utf-8?B?a3JtQ1RHRHBGUlFWT2xiRmo3dEpUTG1kYVppVjc4SkZRbGpVVWd5ZW5LQ2V3?=
 =?utf-8?B?bndvTTRUbk1teEFaY2JWdDFsc3FKZmozWGlHclZacW0zdlpPczNFUnJ1Z0FP?=
 =?utf-8?B?eUlYd0hJeWR5T2g4MjNmSUtWYmlwODhGMDhvWklKcGVWYXgxaHBHdzdjNE9t?=
 =?utf-8?B?T2ZTZUdaQ091Si95dWwvaFhqT05Ma0FORDdGNFlsZzV0VHJ5NkgrWXZOOUxB?=
 =?utf-8?B?WGlhRWg0b2FYSkJiWjQ2RkFucy90UWt6NS93aDdxa0U4bSs1cEcxaUIycWtu?=
 =?utf-8?B?Q2xmdVBlTE1OS0NtWDR5eVZ6TXpWSUNEQzUwcGpNM3duaW9TdDByeUFEVDcw?=
 =?utf-8?B?YmMxdWd4MnpxMG1kZ2dmMzZYanpTbEpwU01NdzAwa0NpMTdZTEdJNU1wSnNI?=
 =?utf-8?B?Sm9ueWhZTW9kM3FzQW5oc0VyYjA3OTVsZWRQNzN3OWpEM0JHdkYzdjlkbjIz?=
 =?utf-8?B?cTRZTFhVOFdTcDA5eEZJMG91WVJFRjZzMGhYTi90NzBEQ3FndVNwaVlTeElM?=
 =?utf-8?B?aWFOVkg0eU0vdVlvZ0h3WCtJczFLT2orcWIrMzZXODE5UEpJZzdVRUNVMVZi?=
 =?utf-8?B?WTk3djFBRlNpd2k2cG5vYWlCdlVlNWJEMkFTSndlTUltc29LUVdab2JqNHp3?=
 =?utf-8?B?R3lWUHkvS1NSSDQwcStMUGduM0dSZ240QTFOZVh3RXlPMHhVTU1lcjJNNW5m?=
 =?utf-8?B?NVhSUWMvcnZPcEx4RWdmbUpYbjc4QXB1ZmZEanlpZVlFdHpsTUc5YW9QMFZi?=
 =?utf-8?B?QTRTZ0xYK2RpR1hBWml0QkVzY2NLSkloS3JzMXVYWVdicXdPVDc3NXZRSEtU?=
 =?utf-8?B?VG42RkxYeEVEbDhZaW45UDd6UEJPMlozQjFEREd3L0FKSVluakNSSGMxb1pU?=
 =?utf-8?B?eENIZGxYZjV6Q0hWL1psb0lhTncrOElEOUpDNi91eWYyalBpcFVmMnpZNEZo?=
 =?utf-8?B?b0VkeDVNTkpVaGVkaFZxWi8zMmcyQ1RuSnhNdERicHJsVFQ5NkJHdGo2ZnZ6?=
 =?utf-8?B?c2E0NXZwVmR4eFNCWlNLNGN5ZGtBOS9PTkV4aVZXNWh4K2ZnajVqSGcwWmhZ?=
 =?utf-8?B?UmtmTjNscSs5aGFDcUo0bTlyUUgzU1hwVU1KNzRjWG5rSGtSUG9GaloxY2R5?=
 =?utf-8?Q?VQN80uBLoRQ/0oh6sz0gNLjtx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68E7D840E685884A87000CB3FB53B256@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d17489d4-2cb3-4ab9-7683-08dd832ba211
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 12:29:18.2136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HwFGLX/lVW4/3IN2JVznpb+v1A+uctJS17Rpek/Peqj9Hr+3Ha7PuXIY9d9rNRb2j+PKLrvs+w4hRzL+bmNLdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6001
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTA0LTIxIGF0IDA5OjI2IC0wNzAwLCBSb3NzIFBoaWxpcHNvbiB3cm90ZToN
Cj4gSW50cm9kdWNlIHRoZSBtYWluIFNlY3VyZSBMYXVuY2ggaGVhZGVyIGZpbGUgdXNlZCBpbiB0
aGUgZWFybHkgU0wgc3R1Yg0KPiBhbmQgdGhlIGVhcmx5IHNldHVwIGNvZGUuDQo+IA0KPiBUaGlz
IGhlYWRlciBmaWxlIGNvbnRhaW5zIHRoZSBmb2xsb3dpbmcgY2F0ZWdvcmllczoNCj4gIC0gU2Vj
dXJlIExhdW5jaCBpbXBsZW1lbnRhdGlvbiBzcGVjaWZpYyBzdHJ1Y3R1cmVzIGFuZCBkZWZpbml0
aW9ucy4NCj4gIC0gSW50ZWwgVFhUIGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBEUlRNIHN0cnVjdHVy
ZXMsIGRlZmluaXRpb25zIGFuZCBmdW5jdGlvbnMNCj4gdXNlZCBieSBTZWN1cmUgTGF1bmNoLg0K
PiAgLSBEUlRNIFRQTSBldmVudCBsb2dnaW5nIGRlZmluaXRpb25zIGFuZCBoZWxwZXIgZnVuY3Rp
b25zLg0KDQpMb29raW5nIGF0IHRoZSBhY3R1YWwgY29kZSBpbiB0aGlzIHBhdGNoLCBzZWVtcyA+
OTAlIGNvZGUgaW4gdGhlDQo8bGludXgvc2xhdW5jaC5oPiBpcyBJbnRlbCBzcGVjaWZpYywgZS5n
LiwgVFhUIHNwZWNpZmljIG1hY3JvL3N0cnVjdHVyZQ0KZGVmaW5pdGlvbnMuICBJdCBkb2Vzbid0
IHNlZW0gdG8gYmUgdGhlIHJpZ2h0IHdheSB0byBvcmdhbml6ZSB0aGUgY29kZS4NCg0KRS5nLiwg
Zm9sbG93aW5nIHRoZSBjdXJyZW50IHBhdHRlcm4sIHdoZW4gd2UgbmVlZCB0byBhZGQgc3VwcG9y
dCBmb3IgYW5vdGhlciBUWFQNCnNpbWlsYXIgdmVuZG9yLXNwZWNpZmljIHRlY2hub2xvZ3ksIHdl
IHdpbGwgbmVlZCB0byBhZGQgeWV0LWFub3RoZXIgc2V0IG9mDQptYWNyby9zdHJ1Y3R1cmUgZGVm
aW5pdGlvbnMgZm9yIHRoYXQgdGVjaG5vbG9neSB0byA8bGludXgvc2xhdW5jaC5oPiBhcyB3ZWxs
Lg0KDQpUaGF0IHdvdWxkIGJlIGEgZ2lhbnQgbWVzcyBJTUhPLg0KDQpDb3VsZCB3ZSBtYWtlIDxs
aW51eC9zbGF1bmNoLmg+IG9ubHkgY29udGFpbiB0aGUgY29tbW9uIHRoaW5ncywgYW5kIG1vdmUg
SW50ZWwNCnNwZWNpZmljIHRoaW5ncyB0byBzb21lIHg4NiBoZWFkZXIocyksIGUuZy4sIDxhc20v
aW50ZWwtdHh0Lmg+IG9yIDxhc20vdHh0Lmg+Pw0KDQoNClsuLi5dDQoNCj4gKy8qDQo+ICsgKiBF
eHRlcm5hbCBmdW5jdGlvbnMgYXZhaWxhYmxlIGluIG1haW5saW5lIGtlcm5lbC4NCj4gKyAqLw0K
PiArdm9pZCBzbGF1bmNoX3NldHVwX3R4dCh2b2lkKTsNCj4gK3ZvaWQgc2xhdW5jaF9maXh1cF9q
dW1wX3ZlY3Rvcih2b2lkKTsNCj4gK3UzMiBzbGF1bmNoX2dldF9mbGFncyh2b2lkKTsNCj4gK3N0
cnVjdCBzbF9hcF93YWtlX2luZm8gKnNsYXVuY2hfZ2V0X2FwX3dha2VfaW5mbyh2b2lkKTsNCj4g
K3N0cnVjdCBhY3BpX3RhYmxlX2hlYWRlciAqc2xhdW5jaF9nZXRfZG1hcl90YWJsZShzdHJ1Y3Qg
YWNwaV90YWJsZV9oZWFkZXIgKmRtYXIpOw0KPiArdm9pZCBfX25vcmV0dXJuIHNsYXVuY2hfdHh0
X3Jlc2V0KHZvaWQgX19pb21lbSAqdHh0LA0KPiArCQkJCQkgY29uc3QgY2hhciAqbXNnLCB1NjQg
ZXJyb3IpOw0KPiArdm9pZCBzbGF1bmNoX2ZpbmFsaXplKGludCBkb19zZXhpdCk7DQo+ICsNCj4g
K3N0YXRpYyBpbmxpbmUgYm9vbCBzbGF1bmNoX2lzX3R4dF9sYXVuY2godm9pZCkNCj4gK3sNCj4g
Kwl1MzIgbWFzayA9IFNMX0ZMQUdfQUNUSVZFIHwgU0xfRkxBR19BUkNIX1RYVDsNCj4gKw0KPiAr
CXJldHVybiAoc2xhdW5jaF9nZXRfZmxhZ3MoKSAmIG1hc2spID09IG1hc2s7DQo+ICt9DQo+ICsN
Cj4gKyNlbHNlDQo+ICsNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBzbGF1bmNoX3NldHVwX3R4dCh2
b2lkKQ0KPiArew0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgc2xhdW5jaF9maXh1
cF9qdW1wX3ZlY3Rvcih2b2lkKQ0KPiArew0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW5saW5lIHUz
MiBzbGF1bmNoX2dldF9mbGFncyh2b2lkKQ0KPiArew0KPiArCXJldHVybiAwOw0KPiArfQ0KPiAr
DQo+ICtzdGF0aWMgaW5saW5lIHN0cnVjdCBhY3BpX3RhYmxlX2hlYWRlciAqc2xhdW5jaF9nZXRf
ZG1hcl90YWJsZShzdHJ1Y3QgYWNwaV90YWJsZV9oZWFkZXIgKmRtYXIpDQo+ICt7DQo+ICsJcmV0
dXJuIGRtYXI7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBzbGF1bmNoX2ZpbmFs
aXplKGludCBkb19zZXhpdCkNCj4gK3sNCj4gK30NCj4gKw0KPiArc3RhdGljIGlubGluZSBib29s
IHNsYXVuY2hfaXNfdHh0X2xhdW5jaCh2b2lkKQ0KPiArew0KPiArCXJldHVybiBmYWxzZTsNCj4g
K30NCj4gDQoNCi4uIGJ0dyBpdCdzIG5vdCBjbGVhciB3aGljaCBwYXJ0IG9mIHRoZSBjb2RlIGlz
IGNvbW1vbiBjb2RlLiDCoA0KDQpMb29raW5nIGF0IHRoZSBhYnZvZSBjb2RlLCBpdCBzZWVtcyB0
aG9zZSBmdW5jdGlvbnMgYXJlIGNvbW1vbiBmdW5jdGlvbnMgY2FsbGVkDQpmcm9tIGNvbW1vbiBj
b2RlLiAgRS5nLiwgc2xhdW5jaF9maW5hbGl6ZSgpIGlzIGNhbGxlZCBmcm9tIGtlcm5lbC9rZXhl
Y19jb3JlLmMsDQp3aGljaCBtZWFucyBpdCBpcyBhIGNvbmNlcHQgaW4gdGhlIGtlcm5lbCBjb21t
b24gY29kZSBhbmQgbXVzdCBiZSBhdmFpbGFibGUgZm9yDQphbGwgQVJDSHMgKEkgaGF2ZW4ndCBy
ZWFkIGhvdyBvdGhlciBmdW5jdGlvbnMgYXJlIGNhbGxlZCwgdGhvdWdoKS4NCg0KQnV0IHRoZSBu
YW1lIHNsYXVuY2hfc2V0dXBfdHh0KCksIHNsYXVuY2hfZ2V0X2RtYXJfdGFibGUoKSBhbmQNCnNs
YXVuY2hfaXNfdHh0X2xhdW5jaCgpIGFyZSBxdWl0ZSBJbnRlbCBzcGVjaWZpYy4gIFNvIGl0IHNl
ZW1zIHRvIG1lIHRoaXMgcGF0Y2gNCl90cmllc18gdG8gc3VwcG9ydCBTZWN1cmUgTGF1bmNoIGF0
IHRoZSBhcmNoIGFnbm9zdGljIGxldmVsIGJ1dCBpdCBkb2Vzbid0IGRvIGENCmdvb2Qgam9iIGF0
IHRoZSBhYnN0cmFjdGlvbj8NCg==

