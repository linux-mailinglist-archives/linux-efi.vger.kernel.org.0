Return-Path: <linux-efi+bounces-5006-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011C9BC62A0
	for <lists+linux-efi@lfdr.de>; Wed, 08 Oct 2025 19:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27063A70D1
	for <lists+linux-efi@lfdr.de>; Wed,  8 Oct 2025 17:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0422BF007;
	Wed,  8 Oct 2025 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZUfzvEVv"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531ED2BEFF3;
	Wed,  8 Oct 2025 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759945013; cv=fail; b=PHheRkzf3pWBVB0TimayjjpRUHWW5aLvX+9lTfaquRkctk489oVTUdFhACCjBnzFNBeAdKye9gKKMf+qoFGyaUYvGJsD+UlrYgH68MHhyEwFIWVoRAMMnJ+oGAi08ZfVHvQ9VZGNTkDQHrSywZXrjVuZ/VK1UkiwPoOGKAFCPC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759945013; c=relaxed/simple;
	bh=hf0VYeMMnWrNJFZdwDnYZblXpMCrwgeltrcYDH54PtU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M4CtxuzNtVCgOtABTxWhpV+W8pKM9cLuWn/tPH56+JxE7wEC/wjTOLzTDEP+mWaaEHe2iaK+VzCWfG9UIRnwg0OElzj/RtnK7f8+66efH62jG6dkafzR8tZRPwnsWDcUSVhWiakhwqG3UwHgXtrMohsj6lL2JKMQ5DST7kB7rKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZUfzvEVv; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759945012; x=1791481012;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hf0VYeMMnWrNJFZdwDnYZblXpMCrwgeltrcYDH54PtU=;
  b=ZUfzvEVva2Ja8vu2QtJBQMAPA86cznBoRhxR8pl/+933l0CvnTG/Yf2P
   +rCPr+Nbn/icU7vVk25NnoOMwH+opXDpUWzRSp8/qtCmMj6fBX5H2txYe
   J5Bp7fuW9gxrbzHzW1o/AzHwD/Egb2nzSm6pkXVJ8UuDiCrBY5RtxndHF
   zikf1AT5I4orgz0c/WWAYyf/jWBGX+t6txO6CLhPN+x1Gyj5vVUxY+zgH
   p1oqMnKDrsfzEWozseLFH1CpNdV9qZs7CAPAndpnnWgYwQpDbvYY3JnQm
   6aSLME5I0obqPUrDDzi3V+7G2NaGC/9nUZ3QmhDMs5c7NuAoXPFIsDMtJ
   A==;
X-CSE-ConnectionGUID: fchycRqgQoiukGlL77/EOw==
X-CSE-MsgGUID: Awo6ma/UQ/a+rr+dVf1jdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="65789451"
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="scan'208";a="65789451"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 10:36:49 -0700
X-CSE-ConnectionGUID: 6jjLGhCNRg+0GcA11Q92qw==
X-CSE-MsgGUID: IkjW8D/jQnOdpBlGIrpgmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="scan'208";a="180426447"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 10:36:48 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 10:36:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 10:36:48 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.67)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 10:36:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZaoZTX8DbIb7YQ8HlarZFLtvrCOXgygvOsLFAH3KsieNN9eBK+kEbtzviQawyTYY5F3QsfYQvplnEnc0wnLOLXUDYfC487HxEpwEST8vL9MsrEx+qxLGuZZH74BRuUyqcIJ/h4gx+dh5hehfORV65Np3m9nQMLWA5Uo9hDmxgSV3vw883dPZyUEZ2MHISUye0wrJbcY6fxl4cA6RAnjBXlYf5nCtu459FC2Y+Zxp6AbJYaW5VrslKWB/srMoVcOkwBlO1At/97sTkoctDEyzMTuIW5B+0sVu9rKTHlrT3c0YlqDgqrI1v53S/CfGFEk6Bp3YQreCqdJzA1OeHFfng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hf0VYeMMnWrNJFZdwDnYZblXpMCrwgeltrcYDH54PtU=;
 b=tl0Lv42wIvIrw5Sx5DOcYu0FyljPQ4BwgL7NV/vVJ5xOMjTTgLQAIkMyIAKFYCUxGyzrfkiZ0qM3J6GlugbeORRON3qMd+YBeJECuJQ5K0QEKw6yZgm+f+arqL8IBW5FxSJ44XfCxiy1Wlf+IKzKXnl+xBj0VcaGyWd2HEpdyB3f9l266rdMmb9YXl7v0SgbJ9NCGw87q5vPxU/Wy15TyTXs+IQv8Z0qn/HGhkjh/uKVgQ4GXavEDTZAQo33QRaaI4o2LZaQyvtw5zET5VPBqEvHmtsVJeEF/0aW2tWbcpLsnrPBqH8kn2Ax6XaD4ZxQe0qCTns9/dscROUmGQTnXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5970.namprd11.prod.outlook.com (2603:10b6:8:5d::6) by
 MN2PR11MB4728.namprd11.prod.outlook.com (2603:10b6:208:261::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 17:36:38 +0000
Received: from DM4PR11MB5970.namprd11.prod.outlook.com
 ([fe80::e9b1:6f0f:1a91:2c79]) by DM4PR11MB5970.namprd11.prod.outlook.com
 ([fe80::e9b1:6f0f:1a91:2c79%7]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 17:36:38 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "tglx@linutronix.de"
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
Subject: Re: [PATCH v10 05/15] x86/cpu: Defer CR pinning enforcement until
 late_initcall()
Thread-Topic: [PATCH v10 05/15] x86/cpu: Defer CR pinning enforcement until
 late_initcall()
Thread-Index: AQHcN1cvY6j1K81lp0qBDTHAPM2QU7S274OAgABfjwCAATZxgA==
Date: Wed, 8 Oct 2025 17:36:38 +0000
Message-ID: <14038b019ba53dec91ba6718802504580848879b.camel@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
	 <20251007065119.148605-6-sohil.mehta@intel.com>
	 <171d197d80701224b83e707948ae5e0a33e27b28.camel@intel.com>
	 <6a71fb30-32f2-4847-b4da-e52b67433ce0@intel.com>
In-Reply-To: <6a71fb30-32f2-4847-b4da-e52b67433ce0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5970:EE_|MN2PR11MB4728:EE_
x-ms-office365-filtering-correlation-id: a6110093-6aa7-4ac2-0125-08de06913c6c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RWx0dWlyYXp1UHIwczAxazh6K3JIZVVWc2NYbHJONDNzaXR4bjBiRTBXZ0ty?=
 =?utf-8?B?Y3RhYk1RbjRYZ3VXOFpXTlZFUmRWZEFHZWtjaVdyZjdOV0UzV3lXMEFCOGhJ?=
 =?utf-8?B?MWJSNk5zbDFWVXA4dWVLN0Vnby9HWjd4SUJHVzQ5UktXMHdWajVqL2o4NG1T?=
 =?utf-8?B?NDNadmxuSmM5YnQwdHd6eHY1WVJRcUlGQXllVDBncldqQ3JpRzI5SE04bG1w?=
 =?utf-8?B?U2RjYlFGL1BYMmpaMUpCVFlkbmlzUHRROXJJSU1CYk5RVkdjbzVIWm9NZ0tv?=
 =?utf-8?B?MzFjdFBCUzNKZFh0YWk1MHN2TG5EcGxPNFFpS0NCR3JYMWJuenhTaUEvKzJL?=
 =?utf-8?B?cHhXZXNzZzBISGlyQU9HOHVobG9SblYwWlpFYUl0RGpvRFVDYjVaZXdaTTds?=
 =?utf-8?B?SGpjckhITzNYOVU1N3lpaWVneDAwSUJZU2szM3pHb0k2ZkhEcjE0bmlnR3RH?=
 =?utf-8?B?RkhUNklOc0tGUm13cjJCR2p3NDN6NFV4eFRvajBpUHpBdk9VdkZPRnJxSUN5?=
 =?utf-8?B?SWs3bTJTeWVKLzBDS3JMdlIzcWpPNHl1QzlGNVhWdG1SZkdrSEthTmlmM3Yy?=
 =?utf-8?B?Q0hUY3c0Z3JTSnZvK0dMa08xMUJBVW5yNnM3alduV1ZObGF3QjVVa29oN1VM?=
 =?utf-8?B?QmVMMi9SMDJ1VDdIdHJHeHVWMDk3N1dpekxtZkt4aG5qSy9QN0QrNUIwaDMz?=
 =?utf-8?B?TTI1N2VsakZXdFpyaC9DbzNqK3dzMVhMeHVIWXdONm85VGR3VVc2UGZuSDMx?=
 =?utf-8?B?cWZscDRiSDNBanc0MjFiMGtNVWFUbE5NWFB1d2pUVlR2TUtRUTlLdnUvQ3lP?=
 =?utf-8?B?b0Y4SGZKUDNTWS9VajFKZ0puQkNHTno3VXUrVE5LUk9XWnV4L1k0Q3F4ek9m?=
 =?utf-8?B?T0czMWpxZUd4N0lHN3ZmNnFTTkkzcXE2UXNwS3NzRS90WTUrNHBBNXJBbGtW?=
 =?utf-8?B?bm1nN1NYMVVIREd0S1NKY2IxQ1FlQXlIZldJeGlmRFlyTzhsTlBpZExSemZG?=
 =?utf-8?B?RmtSMkZzVUl3SkJZRXU0cHRJYjFEQS9NTEZDR3ZCRVFhd3pXMS9IbmFrV0Ey?=
 =?utf-8?B?S0ZtOTFFS2x3Yjg1RE9PRUdndU5YeGVYMGdPTU9LYVdvOTdpL1VRT21RbVN5?=
 =?utf-8?B?U29TaFh4LzVFNElIV3V2UVZtNmpwWVN5VE9MSU1Ca2JaMHRFTTR6SzFtN2w4?=
 =?utf-8?B?bStML2hvdExkam5sSjFmVnN3WG9PQVdMcmpRQ3pIeDdKam9CU2dzbGZQa2hZ?=
 =?utf-8?B?cW9mZVFTaHl4SlI1OVQzem1sSHpWZUY0blpoU1loT0E3RlJacmxPNmFaUm1y?=
 =?utf-8?B?c1lMTk52ZWdCbjBIcGRFWFQvV1BHTEcvZVlKQ2dodXJtWkdxT29lb2lucnRO?=
 =?utf-8?B?WjZFRm9SV2hrMmJHcHhQaEp3Z05mVWdacFdybmQwQm5QR2o3Z05iYjlpRzZI?=
 =?utf-8?B?Y1lZY0tmem1SZG96d2IrL29ZUUJRUlFaVUpxeGZmUGczOHgySUNzT2NhRVdi?=
 =?utf-8?B?NjFWRWJmZ1JETm1LN0h2TTFWMFI4c0YvNEg3WktHRkpFeXhnK1hZaHZpZG1K?=
 =?utf-8?B?VzNDTVpQVWl6UWFxUHl5Q2l5MENiRmg0S1c4Zk5LUXVWNERUWGxjVkxVdXYx?=
 =?utf-8?B?OHp2NDI5UmhiclFqMXpYZWJFMVVUNlQ3Mm1EQWp0YVQ1SnlQTjlyeGZSZWdG?=
 =?utf-8?B?QXBWbXR5elZjWmxHUUN5ZjdhWDBaSDA2aW51VThpVjFGYm5FekU1NktMczdS?=
 =?utf-8?B?dC9oZEpNY1p3Yi9paU9yWm1pazZ0ZGZETUhUcDZ1MC9hSnZyMy9pQ0VsYktr?=
 =?utf-8?B?UTBuZG9DelNaSkpqcmNLVjBwcHBkT0NXcUMxV0R0YTR3dUlyWHlQbHBsMFdi?=
 =?utf-8?B?NzZXRk42SElnZXRsTm9TaFJYb0Q0d0VBdWx4QUtlTHZHVllsOHUrVzBPVFBn?=
 =?utf-8?B?TnFKZFVqckl2dmpYc2ozMWFITHZJcldzYWdEd1hkc1lGWVFQWTZIZllLQmJG?=
 =?utf-8?B?ZzdjRlQzZ0t1bTBDZ3RSUWhEbnpZNWRkWXFJUUtnbkxxSlV0ZE4rbVU0N1pv?=
 =?utf-8?Q?/MXAPO?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5970.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0lwYlFXbi9WRFVZckZsYUNBNVdQVHZ4RU9VK2tZY0J1eUo1NlYvZHJWMkd2?=
 =?utf-8?B?dmpPVG03THgyRVFURG43K25YNU4xUytNbnBQOVUwSzE0VG41SVFBWGMrb0Zp?=
 =?utf-8?B?UzNibEhtQ3NaRUorSDRaZlJqeWkxblpjUnY1Q3dEY0ZxYk51WVhHR0VOdFpP?=
 =?utf-8?B?Si9tNVNDcDc0S0ZkWW5YeWpScit6U1NXV0hvQUJqUi96UlhQUXdibmhickw1?=
 =?utf-8?B?R21GMGpKVGZ4Q1JndlVReDZXejZkdFRVZ29DYWZmVXhGL2VRTS92d0JZRWpG?=
 =?utf-8?B?N1BpVnQxbGNrOG1Ya3dSM1BnTjVyYlBEc2lYb2Y1T29hR1RvNUtYUXlUellS?=
 =?utf-8?B?b1JlQnJXcHByRi9BTUoycGJSTnNUdjJRV202WnpkQXZjelNiS2Yva21sMU5u?=
 =?utf-8?B?M1l6VVpQRSs3YVZUcEpqSmxPOXpZMWhOWC9ibzdoRzVLaTYxZ2RpTXIzTzla?=
 =?utf-8?B?RFJTMHN5SmlqOHpsV0hhVG5rWnZhMllZdUliU3JXNU1lcU9FUjdOSERpYmJ5?=
 =?utf-8?B?b3daZ3RzWGUvdkpXOEsvR1hjWHZObHgzdXFuNzJlNVYvU2VQMUlXaHVhZzU5?=
 =?utf-8?B?YVFFbHVXQ2NJajI4Sm5Vd0hYeENJZ2NHcCtrcnpWL0k0M3UyTkVIWjM2VUVk?=
 =?utf-8?B?d2RGNjBkTnd3aDlVVmgyb3U3Qkltd01VZXo4V3ltQ3VMMmVrRUtMSTk5YW1s?=
 =?utf-8?B?ZGVWUXA1TS81dU1QcnJCSVNaa29NNy9GamJNSk5iNS9vaEo0Vlp6ZEdLNUxY?=
 =?utf-8?B?OXQvYWNWSENkZ2tuRGdVZFJBNGErbExOUkhWRTY2MVNDRnJST1J0R3dmcExn?=
 =?utf-8?B?TU4xMkt2SytuSGpSYThiZko5WUVyODJGREtSWXd2TFZPTy9ycExaTGt4bXFy?=
 =?utf-8?B?OHN2NFpwd2ZoNG0vakxBRTAyaTQ1Tm80L01CYjdiSWhtbzFDWHladjBFNTAz?=
 =?utf-8?B?dng2TW1YWWtUbGdyaUhwNWdtNTczNzk1MXFrU3dkTzlUaWpSNUNGNkIrTzkz?=
 =?utf-8?B?YS9WaHVtbTh6V0t0OXB0T0w4MHdSSW5yNFM4dTU1RGxjOEVEbUZ5OVVpbDdt?=
 =?utf-8?B?aE03cG1ZN2cwMHpCTHZmR0N2aTR3Uy9aWDlDSlFlcWhmY0VaQm5jTWExL1lM?=
 =?utf-8?B?WXMxNklKNXNFSm0yVkIzUWVGNFZmTW5nOTdZWkhzNlRjbC9iUXVUZWlLVHVB?=
 =?utf-8?B?dEE0L1pYT1JlSlBPcVNndHN3UDJINldrSEV6cXRvdVBKbDkrTXJxeGZVU1pQ?=
 =?utf-8?B?TVZNYmJnQXl4dFE5cWNJd1pZeWdveXNYN2RPbDB2amZrWlV6WXhTVjBhTXRu?=
 =?utf-8?B?UlVhL3JYNE9SYkI2d2Job0JQeTNLRmJHbFdaYVpPQy80Sy9FRnpIZTZOMFVV?=
 =?utf-8?B?enZKSk9wdWpsMVcrdlA3NlBoejlxUXNkaXFrZmo5bDdNa2hQWXhXUi9DcFQv?=
 =?utf-8?B?MmM0NVhNU0lkSTE4RVkzQWtkUGhuUm5DRVRWbllPeUY5amMwdmxpVG9LQmx3?=
 =?utf-8?B?SUEzSUpLUDBmWCs0UlN4bjJwdUR5YmVQcEdYSEtxcW1lL2lUOHd2bFZhZ2p0?=
 =?utf-8?B?cjl6L3BoQUd4dGV6cGUxUFZmKy9IRnJ2MWhEMUFNbmVoekU4QWJSR0ZRMVhW?=
 =?utf-8?B?U09EcnJpZTdrYkxHeEFlT2lqVGlCZHhkYTNKWGNSNWRUek16WFJrb3d3NWxr?=
 =?utf-8?B?SjZ2WDM0ekhHOHVscFpBM0F2VEtPQkVONUFnbmc3QUpseit6ZVR5REVFWk1u?=
 =?utf-8?B?OEVUb3dpWk8rbEVYN3k3c0IvV3pRanZjMkhlS0JjYmMyTzBOZmRhQWE5WHZK?=
 =?utf-8?B?SWRBb1IvTXkvZEZxVlhBSVpYdDdBUVNVYWFJcENCS0Z6N1ZiKzhaT1ppQWJ2?=
 =?utf-8?B?c1FnSzlEaHl5cWlmTGF2WmdZZ2RYOHpQTUV2UkIxK1AxWHVyQzRadVBLMDFM?=
 =?utf-8?B?eFB6ek8xMDJJeUtuZzM0WVVlb0g1ZDlrdERYMkRtZW5FTXBJWE5qZlhPbHAx?=
 =?utf-8?B?MzBmWXcrRVR6ZGl0WjFzdmU3ZTNNL05wZGdacC85U2piU2tLYzI4dHp1Tk45?=
 =?utf-8?B?aUNuV0RLTk5KeDAwalJaZ1Q5Z1BPSWIzcG0xOW9pbnlNeGxZL3VJSCtQSzBC?=
 =?utf-8?B?RmJuTHd3aXh5b0hWTktLWnR5Y3NWNFFTNC96bU9CNkhzY0F2RHhwcG05TEJH?=
 =?utf-8?Q?bWImz7PGT+RupBi544HRosM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A354784D9F02B840877C6539FF2FC7D4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5970.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6110093-6aa7-4ac2-0125-08de06913c6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 17:36:38.6744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hN9TyMgZUv6KaM/llc4uBjMfYNhltRun6JkNSpXskaby0z+bxo1309kZzsqecdW3KYUIdDrBSWhMtsqob0TxHC08mBRpUl0+mOtWVN2j1b0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4728
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTEwLTA3IGF0IDE2OjA1IC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
T24gMTAvNy8yMDI1IDEwOjIzIEFNLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90ZToNCj4gDQo+ID4g
DQo+ID4gV2h5IGlzIG9ubHkgc2V0X3ZpcnR1YWxfYWRkcmVzc19tYXAgcHJvYmxlbWF0aWM/IFNv
bWUgb2YgdGhlIG90aGVyIG9uZXMgZ2V0DQo+ID4gY2FsbGVkIGFmdGVyIGJvb3QgYnkgYSBidW5j
aCBvZiBtb2R1bGVzIGJ5IHRoZSBsb29rcyBvZiBpdC4NCj4gPiANCj4gDQo+IEFGQUlVLCBlZmlf
ZW50ZXJfdmlydHVhbF9tb2RlKCktPnNldF92aXJ0dWFsX2FkZHJlc3NfbWFwIG1hcHMgdGhlDQo+
IHJ1bnRpbWUgc2VydmljZXMgZnJvbSBwaHlzaWNhbCBtb2RlIGludG8gdmlydHVhbCBtb2RlLg0K
PiANCj4gQWZ0ZXIgdGhhdCwgYWxsIHRoZSBvdGhlciBydW50aW1lIHNlcnZpY2VzIGNhbiBnZXQg
Y2FsbGVkIHVzaW5nIHZpcnR1YWwNCj4gYWRkcmVzc2luZy4gSSBjYW4gZmluZCBvdXQgbW9yZSBp
ZiB5b3Ugc3RpbGwgaGF2ZSBjb25jZXJucy4NCg0KQWgsIGxvb2tpbmcgaW50byB0aGlzIG1vcmUg
SSBzZWUgdGhlOg0KZmZmZmZmZWYwMDAwMDAwMCB8ICAtNjggICAgR0IgfCBmZmZmZmZmZWZmZmZm
ZmZmIHwgICA2NCBHQiB8IEVGSSByZWdpb24gbWFwcGluZw0Kc3BhY2UNCg0KSXQgbG9va3MgbGlr
ZSB0aGUgc2VydmljZXMgZ2V0IG1hcHBlZCB0aGVyZSBpbiBhIHNwZWNpYWwgTU0uIFRoZSBjYWxs
cyBzd2l0Y2ggdG8NCml0LCBzbyBzaG91bGQgc3RheSBpbiBoaWdoIGFkZHJlc3Mgc3BhY2UuIEJ1
dCBJIGFsc28gc2F3IHRoaXMgc25pcHBldDoNCiAgIC8qDQogICAgKiBDZXJ0YWluIGZpcm13YXJl
IHZlcnNpb25zIGFyZSB3YXkgdG9vIHNlbnRpbWVudGFsIGFuZCBzdGlsbCBiZWxpZXZlDQogICAg
KiB0aGV5IGFyZSBleGNsdXNpdmUgYW5kIHVucXVlc3Rpb25hYmxlIG93bmVycyBvZiB0aGUgZmly
c3QgcGh5c2ljYWwgcGFnZSwNCiAgICAqIGV2ZW4gdGhvdWdoIHRoZXkgZXhwbGljaXRseSBtYXJr
IGl0IGFzIEVGSV9DT05WRU5USU9OQUxfTUVNT1JZDQogICAgKiAoYnV0IHRoZW4gd3JpdGUtYWNj
ZXNzIGl0IGxhdGVyIGR1cmluZyBTZXRWaXJ0dWFsQWRkcmVzc01hcCgpKS4NCiAgICAqDQogICAg
KiBDcmVhdGUgYSAxOjEgbWFwcGluZyBmb3IgdGhpcyBwYWdlLCB0byBhdm9pZCB0cmlwbGUgZmF1
bHRzIGR1cmluZyBlYXJseQ0KICAgICogYm9vdCB3aXRoIHN1Y2ggZmlybXdhcmUuIFdlIGFyZSBm
cmVlIHRvIGhhbmQgdGhpcyBwYWdlIHRvIHRoZSBCSU9TLA0KICAgICogYXMgdHJpbV9iaW9zX3Jh
bmdlKCkgd2lsbCByZXNlcnZlIHRoZSBmaXJzdCBwYWdlIGFuZCBpc29sYXRlIGl0IGF3YXkNCiAg
ICAqIGZyb20gbWVtb3J5IGFsbG9jYXRvcnMgYW55d2F5Lg0KICAgICovDQogICBpZiAoa2VybmVs
X21hcF9wYWdlc19pbl9wZ2QocGdkLCAweDAsIDB4MCwgMSwgcGYpKSB7DQogICAJcHJfZXJyKCJG
YWlsZWQgdG8gY3JlYXRlIDE6MSBtYXBwaW5nIGZvciB0aGUgZmlyc3QgcGFnZSFcbiIpOw0KICAg
CXJldHVybiAxOw0KICAgfQ0KDQpCeSBsZWF2aW5nIExBU1MgZW5hYmxlZCBpdCBzZWVtcyB0aGUg
a2VybmVsIHdpbGwgYmUgY29uc3RyYWluaW5nIEJJT1NzIHRvIG5vdCBkbw0Kc3RyYW5nZSB0aGlu
Z3MuIFdoaWNoIHNlZW1zIHJlYXNvbmFibGUuDQoNCj4gDQo+ID4gPiBAQCAtNDc2LDggKzQ3Niw4
IEBAIHZvaWQgY3I0X2luaXQodm9pZCkNCj4gPiA+ICANCj4gPiA+ICAJaWYgKGJvb3RfY3B1X2hh
cyhYODZfRkVBVFVSRV9QQ0lEKSkNCj4gPiA+ICAJCWNyNCB8PSBYODZfQ1I0X1BDSURFOw0KPiA+
ID4gLQlpZiAoc3RhdGljX2JyYW5jaF9saWtlbHkoJmNyX3Bpbm5pbmcpKQ0KPiA+ID4gLQkJY3I0
ID0gKGNyNCAmIH5jcjRfcGlubmVkX21hc2spIHwgY3I0X3Bpbm5lZF9iaXRzOw0KPiA+ID4gKw0K
PiA+ID4gKwljcjQgPSAoY3I0ICYgfmNyNF9waW5uZWRfbWFzaykgfCBjcjRfcGlubmVkX2JpdHM7
DQo+ID4gDQo+ID4gDQo+ID4gQ2FuIHlvdSBleHBsYWluIHdoeSB0aGlzIGNoYW5nZSBpcyBuZWVk
ZWQ/IEl0IHJlbGllcyBvbiBjcjRfcGlubmVkX2JpdHMgdG8gYmUNCj4gPiBhbHJlYWR5IHNldCwg
YW5kIGtpbmQgb2YgaXMgImVuZm9yY2VtZW50IiwgYnV0IG5vIGxvbmdlciBkZXBlbmRzIG9uDQo+
ID4gZW5hYmxlX2NyX3Bpbm5pbmcoKSBiZWluZyBjYWxsZWQuDQo+ID4gDQo+IA0KPiBjcjRfaW5p
dCgpIGlzIG9ubHkgY2FsbGVkIGZyb20gQVBzIGR1cmluZyBicmluZyB1cC4gVGhlIHBpbm5lZCBi
aXRzIGFyZQ0KPiBzYXZlZCBvbiB0aGUgQlNQIGFuZCB0aGVuIHVzZWQgdG8gcHJvZ3JhbSB0aGUg
Q1I0IG9uIHRoZSBBUHMuIEl0IGlzDQo+IGluZGVwZW5kZW50IG9mIHBpbm5pbmcgKmVuZm9yY2Vt
ZW50KiB3aGljaCB3YXJucyB3aGVuIHRoZXNlIGJpdHMgZ2V0DQo+IG1vZGlmaWVkLg0KDQpTb3Jy
eSwgc3RpbGwgbm90IGZvbGxvd2luZy4gSG93IGlzIGl0IGluZGVwZW5kZW50IG9mIENSIHBpbm5p
bmcgZW5mb3JjZW1lbnQgaWYNCnRoZSBlbmZvcmNlbWVudCBpcyBzdGlsbCB0YWtpbmcgcGxhY2Ug
aW4gdGhpcyBmdW5jdGlvbi4gQW5kIGlmIHdlIGRvbid0IG5lZWQgdG8NCmVuZm9yY2UgcGlubmlu
Zywgd2h5IGRyb3AgdGhlIGJyYW5jaD8NCg0KPiANCj4gPiANCj4gPiA+ICANCj4gPiA+ICAJX193
cml0ZV9jcjQoY3I0KTsNCj4gPiA+ICANCg0K

