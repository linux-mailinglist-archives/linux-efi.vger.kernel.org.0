Return-Path: <linux-efi+bounces-4978-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFB2BC2321
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 18:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B0FAF34F9B4
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 16:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6331B54652;
	Tue,  7 Oct 2025 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EfbwOuL8"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A991FDE09;
	Tue,  7 Oct 2025 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759856136; cv=fail; b=glZseOkfsIOPZuULRzrf/qsMr+upTtKQ/tMiXDKFSwO8gYnS6kXQvwcdbeYE3X5H1dbYweeZhxIMZmV1lU3xUvlSfHpf1dZJR9Sre2pz5iH9mk08mZnM+Y+T53uw08dJHVIexqf91Zm2eMPPYuAcD7B11L9PenTCAZ/1m2lrp9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759856136; c=relaxed/simple;
	bh=PCmgNeScmJlfjEF7exLjdWCY6n/jJDljzFy/2pdzQsw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rCBUXCTiY0dntxj/tqlZ2ZYfCyYFXYeMxtuXUBctvGUoc/7OfGKjVGSmVnNyEk3u/hazqzb0bYKJ/0yOmZoZrQiA40t3aXzh+Ii3kTNm6EhIvfwQ6gveaJkYtZh5/qLWNJD1CGcSxkrHidsA1ZWbf06MXPUI5qNhfGMoYf18zJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EfbwOuL8; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759856134; x=1791392134;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PCmgNeScmJlfjEF7exLjdWCY6n/jJDljzFy/2pdzQsw=;
  b=EfbwOuL8chKjUhpcQKo80YzTDIemucMNXCvWaW8gqjnrC1qWXfG5536h
   0+adGX85kT6HUg34+e4fUDi9DuGeR5PI7lhrNklX3z9idpIchAMDd8XZi
   y/fIFYwpRmxs8JTZ2zEzv1jD+wOPO5tg9rT7HjLDOA0rtD10i8mj7stdE
   K1z+4Pxm2vRlmzRlg5e8pNJzyNcV/6LQHddpEIo+jcaCf0fjuH36ovuj0
   7GIsJZK+9IfyTn5HpVZjtT+8iu7bW+nd/DIt3Ih87sjmXuN6I8Ul7usKD
   zltN5ic1LYD/hf0qNuO3uWXpYpyeGCeepzqsvE1O5sIGxpAg6tsTDydbf
   Q==;
X-CSE-ConnectionGUID: Oj1EtFv8SVO7uZk1jhk2Mg==
X-CSE-MsgGUID: VK4ioSfWRdqqllPVF/FU6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="62079296"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="62079296"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 09:55:33 -0700
X-CSE-ConnectionGUID: 4fVGJGRFSkerllSNAz9Yvw==
X-CSE-MsgGUID: xH51nuoKRTWbAg8O0Xc7Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="184474051"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 09:55:32 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 09:55:30 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 09:55:30 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.5) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 09:55:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsSPAxmHbOZCwbkZ9BAKppRtA95wo0oTh6kTswWBX9NRH0BkTMZbPGYJlqRpJjdYv0Cre900wlcCQP+b3Poz9sBq4jEu2boE8Rf6N62vPwpQxY9O6aj4BftnDDirTY7OPleiZUB76ZWJAGDdGSo2Lb7c+nVuTD0HW+IaoFJm9dixF3smBuPnBKq4Khf17jAqlJPKAarVWqfaR12jtKWFhDcpXZ1ABHFQqAFaGuCoi+gWu5C+SCh5xPrurqrpjcLNN2SvcgHXdzPXu79Gl8OX7y4q9M7I8gKyIFYkv4+sTAnd1PNr5dJTNowOPz0F1vhzPIGIUvXzCNOaaDIkml/gcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCmgNeScmJlfjEF7exLjdWCY6n/jJDljzFy/2pdzQsw=;
 b=M0z+ll0qqm7W4cZ+h0GirjLx1kuN0p9wrJ0VkvDhRXfvfo26qlLnFL1yl6tZg3f2fgpQ2r4xvlpSEQZQwSoHE3RjrNbvfD/bSVKTLnVycRq1NkqjtEEUwyIZ5Dznu0bJXg43TE1BSrx77yKbGnlSZPtV/pVMouuBWmtZ0w+AaWWlzOkrCnVJT3jo06Bg2q0lQZOv+qNqPGFqWpkPG9knGMo5C0Fo6alL3MdOhP2bVpDvVUfdihnO/8ovY/Uj9gkgiVs2ygmvhIpSK4BSUTLb3D/f5CQFYdxcHpSi2tSvrcnM6qtEQTC66nNLorNnEveBeJSe6QzZbqPDxZ+rL3l5KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by LV8PR11MB8745.namprd11.prod.outlook.com (2603:10b6:408:204::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 16:55:24 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 16:55:24 +0000
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
Subject: Re: [PATCH v10 03/15] x86/alternatives: Disable LASS when patching
 kernel alternatives
Thread-Topic: [PATCH v10 03/15] x86/alternatives: Disable LASS when patching
 kernel alternatives
Thread-Index: AQHcN1cvIlCMw/NuHEiY4j7oPv0k3LS256gA
Date: Tue, 7 Oct 2025 16:55:24 +0000
Message-ID: <9240edbe689108f920d4b0c5c786278aea47d1d2.camel@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
	 <20251007065119.148605-4-sohil.mehta@intel.com>
In-Reply-To: <20251007065119.148605-4-sohil.mehta@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|LV8PR11MB8745:EE_
x-ms-office365-filtering-correlation-id: f5b92564-f733-47e4-c8f1-08de05c24f32
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?N1MrSkZZL2FsTmdLUDJOREhXcXVDOEtMcEtiVVE4YVhZa0hEMCtSQmVGZmI5?=
 =?utf-8?B?Uy8zVGhGNnBOSWs1SnNWOHZNUUwvbEprVVRyTmE0MFk0cTN2Z2gyREUyK0VM?=
 =?utf-8?B?bk9VOUhLNmVKdkZneHBxbnhQS2VTWGdYckVWQy9ZQU5FNkhHU0FrSENLbUJF?=
 =?utf-8?B?STlLdDFYM08rU3lOOUpIMGVJOFZiNytqWmxhN29BYVN6elpXdVJVbGlvb2Zm?=
 =?utf-8?B?bm92Mys4dUQzVXZTZzdqdG5ZV0tpalUvTE9pUU5HeDhLaGViZWFiZ2VkYXFN?=
 =?utf-8?B?TXplYm1paUFoVjVwamFQeGRTdDF0NlhPclhzcTUvTzVTR2RCemp0dmlZaHdh?=
 =?utf-8?B?SHh1Q1dKRXdIdlR1bVh0SllpV3pFR2Frb3Q3Y1N1Q09iekFSdkJxNXNTMlJP?=
 =?utf-8?B?eXZIMnJQbm1va2Z5V0J2MzRpdUJPSnFwT3N3UVpzTERhL05qUndXVnpoMVE1?=
 =?utf-8?B?VXFxMjVzN2Y1cURNOUVMajB5TWZ4dVhrZ3JRR0JWbkhNZWlxbHJzL0VXZkpF?=
 =?utf-8?B?Z2Q2Smd1Q0hyODFZZCtOUGxyT3RPbk1oUzlxYUkxOE1iSkpRTlNRbkFoNzBo?=
 =?utf-8?B?ODAxKzhuMUNVcXI2WGxDUWhrSWZ4V0ovV3AyUndCUmxZbUloYm9lSFk2Umxa?=
 =?utf-8?B?TEh3RGFaNGx0TDUza0srWUFkWS9tWFNYa0ZkeXZnV0I4N2dZZ1h0anhNNlY1?=
 =?utf-8?B?dWlRckYvNXFMWlBMUmxXR21JZ0k3SDljeGR1ZVpoMnFJdENxN1lNNldKbmxJ?=
 =?utf-8?B?dXZYb2o4ZDBFdFpkMTJTK2x2RWRxTlZ2MWJNU0tRa1JPNndIV2dVY3I2TXoy?=
 =?utf-8?B?YmwvaC83UW00TnhGTlYxLy9PaW5JUk85SVV0L21rRFR4aG9rVGttUjhvZkNC?=
 =?utf-8?B?aU9PZFZEQUEzb0x6elcrdWxJQ2E5U2xRMUE1SXhyTExGZ3ZWZTJaT0s5Zno5?=
 =?utf-8?B?RFZuSlE3cG5ibHJjVm1SdlJpQ1ZtamlrcVVFMFI5VWFIY0pLbDZOb2RTSnFI?=
 =?utf-8?B?cFhrTW4vcFhyR2poTDJLbEdkREhaaXNyWGZvV0JQUGpDNFFBSU1zYW1nK1BC?=
 =?utf-8?B?LzJiQ1RmNERKRkI1N0d6eWpLa2tFZWlvempJUytrS2lxLytiQXdZaXhiaFE2?=
 =?utf-8?B?T2RnSVhJNytrUzRkYkI5bzlZaFB3Wkh4ZHcvRGdiU2JMejYzd1hGNGxjYmFu?=
 =?utf-8?B?UmgrYlVVUUFPbktLVmszeVVpTjJpeVFId2dobWRJZUMvT3ZLL0pWY1Q4K3Jm?=
 =?utf-8?B?SlU1RCs5aXY3REpFa05zWFEyWEZOc3ZmV3IrYmRnaGNpaW9oRjFpb0lzRHFJ?=
 =?utf-8?B?dSsybkR0SndwT0d6LzV1OUhRN2VEbUZvWUZUNEVqMUlraWNBbTlvTHNGVzc2?=
 =?utf-8?B?Ry92TXUrNm91UjVxZTFHd0ZDOUdpZ2U2VldQVDJCbm5HUTh2VVFDbEtSMkdW?=
 =?utf-8?B?YjFEVCtHbWNwRkVnNkxiRDNiaWVUMlZpYmdDdU9MM1ZtVi9QUllTOHhUTkZM?=
 =?utf-8?B?Qkg0TjlnUFJubGRHUWtyT21NeFArVUZ1eDZ6Rk4rN05ON3FIKzhxVGZaR1Bu?=
 =?utf-8?B?d29wT241YS9QdlYwcFNoWlBmN2pONWNXK1F5M20wUEtsZ1J0V0NRQW5nVWE4?=
 =?utf-8?B?SnB2VVhUTjRKTEVJazlLcmZQai85UXg3NjNqMW9BUDNOVVVPUDJmNGxrTEY5?=
 =?utf-8?B?OUl5aWFKMlhxYTg3Tko0Mlc0WUo2Z21rZWNxNXdkLzBTQjAxakR4SXkyaWRB?=
 =?utf-8?B?MjV6ejV3aEVuVk5ldnFYemwvaHlsY3YyT1prTktMRGRUMGRBZjljZW1QSGJu?=
 =?utf-8?B?MkxkTENJYWZiWTdpTENMQWZFTCtPY2VEUi9jM0hDaU15TnBrVUx5MVFZcE1z?=
 =?utf-8?B?d2M2b1p4WngvT2dRR01Wbk0vMC9KRWJtaGpLTGtFUTlKc0RjdjJ1eDYwOWh4?=
 =?utf-8?B?NmY1OXNwUkxhZ21zMTYxWS94WFptSWU3Q3RrZi9Zb2VXckFPZmJXL1BXUUxw?=
 =?utf-8?B?bHlpYmhDWjgwQncxWVVTTGsvL2ZQWEVwb3pRZ0hLZG5zWVpxQnNqUjN5VUEz?=
 =?utf-8?Q?iohqgo?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2lLU1VWZXo0MldaZ3h1T2NzcHNNVFhweGFob0d2Ry9nWFl5eGxyNFMwTHIr?=
 =?utf-8?B?YWhVOUJUSGdQRU9pWExqdTlQU25WYlFXU2lEdnN1QzJFM2o0VHBUcTFvK2Fv?=
 =?utf-8?B?TWlXTitzcU8zckJmblpNZnNQREVRb3pyK05tQUgvTlhvNXYrUTVwbHVRODh3?=
 =?utf-8?B?N1lRTFRIVmgyUjVJZUJLWFF4NnVjcEEwTnIwV2hyUjMxekFDY09rTUU2dms3?=
 =?utf-8?B?Yy9FSVdrTU1mVGpNNC8vcXlUUGFyVGtOTHNVNDhydFYwenQ2RnZQbjNXbENh?=
 =?utf-8?B?MjkvQlpKVmVNUnU1RXRtWGVteXFWaWhEUWpTTjJwaXhmV3NvaDJsMS9SaTR6?=
 =?utf-8?B?VGZzUkdWUS9ybTVWT1grdkpBYmNwemtZUnY0ZkpQRWI5cVFzNVFvVkRiZkhF?=
 =?utf-8?B?eUxZdmF4Rzc2RGYweGJqT3VvMnNteXZZVTFPQS9URlFTVlVVbkJBUjhQYXhF?=
 =?utf-8?B?VTh0K2kvbnZVV0VIWmFIWWVzdjg4bGkvTEtWS05oejQyYlV6cG1ZQnc3cEJB?=
 =?utf-8?B?NnZEZW5GemlpY1V6aXFZckxsSzVjQUJJbEYySkd4Ni9tcGxoTmdkeTRBMzMv?=
 =?utf-8?B?SjdzeUxuUk9QK09iVDdpQ1FQZWp0V3ZaK3ZCM0RvblE2TlpWKzVCcTdza2Fk?=
 =?utf-8?B?clRIa2wydjBYK2t4anBaZGc2YllvakttVHRPTGhyOTNWRndTWGpMc25vZ2Y0?=
 =?utf-8?B?dDF4K1JqdW1lY0Z5dFV3RFdweGZ3NmVhNWEyVnVJSTJNSTkyOGxPWXYrRExM?=
 =?utf-8?B?cDRlWDlyMEpnQ2tzNzRhUU9KYTJ2WncwT0VIaEJ4VERpN3Frbnp3cFJTVTht?=
 =?utf-8?B?encwRUJjc1IwcVhNbjZOenRReEVtMU9BQkVJYTZaS1J4ZU1GY3h2dUNWSzRO?=
 =?utf-8?B?RVFJWDdlNnJpWkFETWtCTVhDd3FXNjRITzVWM3JKaXorOWVqczFWUnN4SXUx?=
 =?utf-8?B?aVYvaW4yUGRrTzRjamJFS0UrVUxCSEVDZjQzV3hMZnRCajZIeTk2N1hDWmJu?=
 =?utf-8?B?cUVaVm02T296SkRTR3pYQVJNRXJTL2FKNXg2aGJJS3QwOWFMc3BJdjlaYmNy?=
 =?utf-8?B?TnA2dnM0cHI2OVNGV09FYlAwR2FCYklJb3hLS3V5TkRXcmxJRWdxWkV6akg2?=
 =?utf-8?B?dUZUZHVXVS85b0NTbXp4SnJWZmpMR216bUlPdFBhaVZ2Nloxb3RSY002Nk9n?=
 =?utf-8?B?QkpKb0lOK2RGQThaMjBjN3lTT3ZKOHZJYnE1NDlJais0OVRWWlpVRXEwVU9M?=
 =?utf-8?B?N3VvUzBtNEEybi9mM0pqWFJZajN3OXA5WU52dzc0YlpOUnpZMVY5c2ZSSkcr?=
 =?utf-8?B?a0NyRkRHNy9Sdms4MjFiMTZPaWN5d2hOMUY2ZE40YkM2QW1MdTZ0bVhrdURJ?=
 =?utf-8?B?TDl5cFZJNThMNEJmeTU3aG0xdnFtZWsxMjU4K1ZqNk4yakwxVEJ3Q05xQ3hT?=
 =?utf-8?B?a2U1V3dzV3JvVVZla1loS2doM3grSGx1RFI0bXd5UG5HZWpFWGJWUUtXc1Az?=
 =?utf-8?B?UjdhSTBDMzVCVHRmWUlSM2tqTXd4ZE95c0Uyc1c4U2ZmVXVXUTBzb1ZNdHo0?=
 =?utf-8?B?VGJaZ2d4djhwUUNTcW1BajV2UTJYYjdrWk5mcUhJbU1FRzk1L04yR29nejFr?=
 =?utf-8?B?R0o1WXhUZTFrNG12ckFaS2E4K3NuL2FoeEQ3azA1QmR6bkhyaEd2WVhkZWRa?=
 =?utf-8?B?VXRwVlR4RGdpK3VDNTlrdFVuclFkeGlVMyt0aVFBcnhyZzRDZitjNHRqWE9x?=
 =?utf-8?B?QWpVbEg0VHFIeUl4TFNBQVROUzZiaU9MNUdVdFdXSCs1UldreWc3TVpySlIy?=
 =?utf-8?B?THBHV3NBTy8rK0VVWGlIUVh4bFQ0Z1hucUw1UVIwcldDY1dHL3RCQ050dEJj?=
 =?utf-8?B?OTNXZWh4dGRSc2VoUzVFZUhnVC9peE5BVjN4UkVoTVZZMU9TR2ZSU1R3cm9B?=
 =?utf-8?B?S2ZxMTdDRHRXRkZWMmZKNVdMV0tZRHBUTEJibEtEaDNROXBDTUhOMzc0RXFq?=
 =?utf-8?B?cC93dm5uVHlZTENpcW51Z2VYV0FmVE5xczVYMXMwdnl1TUR6RjVDUXJCeDM5?=
 =?utf-8?B?eHlBVnZCMmNZcFNUVzlyamdCTHlDMnVObGNNVFhRc2dHdU5QTkp0Yks5MUJ4?=
 =?utf-8?B?SlR4ZlZVdDFzdEtiSnlWd0d4S1RZckhVTnhXMDlRRXRPUHk2c3F4a2JIQmdH?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C62A730FF6C154F8451E3F0F385AF3A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b92564-f733-47e4-c8f1-08de05c24f32
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 16:55:24.3494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +HjHDg0tYucJfQa9rvDeXDYIG41MahEmFvDx4cMSs68UikUwWyQDgGrOXCdgFht/qkJZAIxbHioy879gjo+XEbPgKZdnItJL774nRzKD8cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8745
X-OriginatorOrg: intel.com

SXQncyBub3QganVzdCB1c2VkIGZvciBhbHRlcm5hdGl2ZXMgYW55bW9yZS4gYnBmLCBrcHJvYmVz
LCBldGMgdXNlIGl0IHRvby4gTWF5YmUNCmRyb3AgImFsdGVybmF0aXZlcyIgZnJvbSB0aGUgc3Vi
amVjdD8NCg0KT24gTW9uLCAyMDI1LTEwLTA2IGF0IDIzOjUxIC0wNzAwLCBTb2hpbCBNZWh0YSB3
cm90ZToNCj4gRm9yIHBhdGNoaW5nLCB0aGUga2VybmVsIGluaXRpYWxpemVzIGEgdGVtcG9yYXJ5
IG1tIGFyZWEgaW4gdGhlIGxvd2VyDQo+IGhhbGYgb2YgdGhlIGFkZHJlc3MgcmFuZ2UuIERpc2Fi
bGUgTEFTUyBlbmZvcmNlbWVudCBieSB0b2dnbGluZyB0aGUNCj4gUkZMQUdTLkFDIGJpdCBkdXJp
bmcgcGF0Y2hpbmcgdG8gYXZvaWQgdHJpZ2dlcmluZyBhICNHUCBmYXVsdC4NCj4gDQo+IEludHJv
ZHVjZSBMQVNTLXNwZWNpZmljIHN0YWMoKS9jbGFjKCkgaGVscGVycyBhbG9uZyB3aXRoIGNvbW1l
bnRzIHRvDQo+IGNsYXJpZnkgdGhlaXIgdXNhZ2UgdmVyc3VzIHRoZSBleGlzdGluZyBzdGFjKCkv
Y2xhYygpIGhlbHBlcnMgZm9yIFNNQVAuDQo+IA0KPiBUZXh0IHBva2luZyBmdW5jdGlvbnMgdXNl
ZCB3aGlsZSBwYXRjaGluZyBrZXJuZWwgYWx0ZXJuYXRpdmVzIHVzZSB0aGUNCj4gc3RhbmRhcmQg
bWVtY3B5KCkvbWVtc2V0KCkuIEhvd2V2ZXIsIG9ianRvb2wgY29tcGxhaW5zIGFib3V0IGNhbGxp
bmcNCj4gZHluYW1pYyBmdW5jdGlvbnMgd2l0aGluIGFuIEFDPTEgcmVnaW9uLg0KPiANCj4gT25l
IHdvcmthcm91bmQgaXMgdG8gYWRkIG1lbWNweSgpIGFuZCBtZW1zZXQoKSB0byB0aGUgbGlzdCBv
ZiBmdW5jdGlvbnMNCj4gYWxsb3dlZCBieSBvYmp0b29sLiBIb3dldmVyLCB0aGF0IHdvdWxkIHBy
b3ZpZGUgYSBibGFua2V0IGV4ZW1wdGlvbiBmb3INCj4gYWxsIHVzYWdlcyBvZiBtZW1jcHkoKSBh
bmQgbWVtc2V0KCkuDQo+IA0KPiBJbnN0ZWFkLCByZXBsYWNlIHRoZSBzdGFuZGFyZCBtZW1jcHko
KSBhbmQgbWVtc2V0KCkgY2FsbHMgaW4gdGhlIHRleHQNCj4gcG9raW5nIGZ1bmN0aW9ucyB3aXRo
IHRoZWlyIHVub3B0aW1pemVkIGlubGluZSB2ZXJzaW9ucy4gQ29uc2lkZXJpbmcNCj4gdGhhdCBw
YXRjaGluZyBpcyB1c3VhbGx5IHNtYWxsLCB0aGVyZSBpcyBubyBwZXJmb3JtYW5jZSBpbXBhY3Qg
ZXhwZWN0ZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTb2hpbCBNZWh0YSA8c29oaWwubWVodGFA
aW50ZWwuY29tPg0KPiAtLS0NCj4gdjEwOg0KPiAgLSBSZXZlcnQgdG8gdGhlIGlubGluZSBmdW5j
dGlvbnMgaW5zdGVhZCBvZiBvcGVuLWNvZGluZyBpbiBhc3NlbWJseS4NCj4gIC0gU2ltcGxpZnkg
Y29kZSBjb21tZW50cy4NCj4gLS0tDQo+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9zbWFwLmggICB8
IDM1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ICBhcmNoL3g4Ni9rZXJu
ZWwvYWx0ZXJuYXRpdmUuYyB8IDE4ICsrKysrKysrKysrKysrKystLQ0KPiAgMiBmaWxlcyBjaGFu
Z2VkLCA0OSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2luY2x1ZGUvYXNtL3NtYXAuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NtYXAu
aA0KPiBpbmRleCA0Zjg0ZDQyMWQxY2YuLjNlY2I0YjBkZTFmOSAxMDA2NDQNCj4gLS0tIGEvYXJj
aC94ODYvaW5jbHVkZS9hc20vc21hcC5oDQo+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3Nt
YXAuaA0KPiBAQCAtMjMsMTggKzIzLDQ5IEBADQo+ICANCj4gICNlbHNlIC8qIF9fQVNTRU1CTEVS
X18gKi8NCj4gIA0KPiArLyoNCj4gKyAqIFRoZSBDTEFDL1NUQUMgaW5zdHJ1Y3Rpb25zIHRvZ2ds
ZSB0aGUgZW5mb3JjZW1lbnQgb2YgWDg2X0ZFQVRVUkVfU01BUA0KPiArICogYW5kIFg4Nl9GRUFU
VVJFX0xBU1MuDQo+ICsgKg0KPiArICogU01BUCBlbmZvcmNlbWVudCBpcyBiYXNlZCBvbiB0aGUg
X1BBR0VfQklUX1VTRVIgYml0IGluIHRoZSBwYWdlDQo+ICsgKiB0YWJsZXMuIFRoZSBrZXJuZWwg
aXMgbm90IGFsbG93ZWQgdG8gdG91Y2ggcGFnZXMgd2l0aCB0aGUgYml0IHNldA0KPiArICogdW5s
ZXNzIHRoZSBBQyBiaXQgaXMgc2V0Lg0KPiArICoNCj4gKyAqIFVzZSBzdGFjKCkvY2xhYygpIHdo
ZW4gYWNjZXNzaW5nIHVzZXJzcGFjZSAoX1BBR0VfVVNFUikgbWFwcGluZ3MsDQo+ICsgKiByZWdh
cmRsZXNzIG9mIGxvY2F0aW9uLg0KPiArICoNCj4gKyAqIE5vdGU6IGEgYmFycmllciBpcyBpbXBs
aWNpdCBpbiBhbHRlcm5hdGl2ZSgpLg0KPiArICovDQo+ICsNCj4gIHN0YXRpYyBfX2Fsd2F5c19p
bmxpbmUgdm9pZCBjbGFjKHZvaWQpDQo+ICB7DQo+IC0JLyogTm90ZTogYSBiYXJyaWVyIGlzIGlt
cGxpY2l0IGluIGFsdGVybmF0aXZlKCkgKi8NCj4gIAlhbHRlcm5hdGl2ZSgiIiwgImNsYWMiLCBY
ODZfRkVBVFVSRV9TTUFQKTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIF9fYWx3YXlzX2lubGluZSB2
b2lkIHN0YWModm9pZCkNCj4gIHsNCj4gLQkvKiBOb3RlOiBhIGJhcnJpZXIgaXMgaW1wbGljaXQg
aW4gYWx0ZXJuYXRpdmUoKSAqLw0KPiAgCWFsdGVybmF0aXZlKCIiLCAic3RhYyIsIFg4Nl9GRUFU
VVJFX1NNQVApOw0KPiAgfQ0KPiAgDQo+ICsvKg0KPiArICogTEFTUyBlbmZvcmNlbWVudCBpcyBi
YXNlZCBvbiBiaXQgNjMgb2YgdGhlIHZpcnR1YWwgYWRkcmVzcy4gVGhlDQo+ICsgKiBrZXJuZWwg
aXMgbm90IGFsbG93ZWQgdG8gdG91Y2ggbWVtb3J5IGluIHRoZSBsb3dlciBoYWxmIG9mIHRoZQ0K
PiArICogdmlydHVhbCBhZGRyZXNzIHNwYWNlIHVubGVzcyB0aGUgQUMgYml0IGlzIHNldC4NCj4g
KyAqDQo+ICsgKiBVc2UgbGFzc19zdGFjKCkvbGFzc19jbGFjKCkgd2hlbiBhY2Nlc3Npbmcga2Vy
bmVsIG1hcHBpbmdzDQo+ICsgKiAoIV9QQUdFX1VTRVIpIGluIHRoZSBsb3dlciBoYWxmIG9mIHRo
ZSBhZGRyZXNzIHNwYWNlLg0KPiArICovDQo+ICsNCg0KVGhlIGFib3ZlIHZhcmlhbnQgaGFzICJh
IGJhcnJpZXIgaXMgaW1wbGljaXQgaW4gYWx0ZXJuYXRpdmUiLCBpcyBpdCBub3QgbmVlZGVkDQpo
ZXJlIHRvbz8gQWN0dWFsbHksIG5vdCBzdXJlIHdoYXQgdGhhdCBjb21tZW50IGlzIHRyeWluZyB0
byBjb252ZXkgYW55d2F5Lg0KDQo+ICtzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQgbGFzc19j
bGFjKHZvaWQpDQo+ICt7DQo+ICsJYWx0ZXJuYXRpdmUoIiIsICJjbGFjIiwgWDg2X0ZFQVRVUkVf
TEFTUyk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZCBsYXNzX3N0
YWModm9pZCkNCj4gK3sNCj4gKwlhbHRlcm5hdGl2ZSgiIiwgInN0YWMiLCBYODZfRkVBVFVSRV9M
QVNTKTsNCj4gK30NCj4gKw0KDQpOb3QgYSBzdHJvbmcgb3BpbmlvbiwgYnV0IHRoZSBuYW1pbmcg
b2Ygc3RhYygpL2NsYWMoKSBsYXNzX3N0YWMoKS9sYXNzX2NsYWMoKSBpcw0KYSBiaXQgY29uZnVz
aW5nIHRvIG1lLiBzdGFjL2NsYWMgaW5zdHJ1Y3Rpb25zIG5vdyBoYXMgTEFTUyBhbmQgU01BUCBi
ZWhhdmlvci4NCldoeSBrZWVwIHRoZSBzbWFwIGJlaGF2aW9yIGltcGxpY2l0IGFuZCBnaXZlIExB
U1MgYSBzcGVjaWFsIHZhcmlhbnQ/DQoNClRoZSBvdGhlciBvZGQgYXNwZWN0IGlzIHRoYXQgY2Fs
bGluZyBzdGFjKCkvY2xhYygpIGlzIG5lZWRlZCBmb3IgTEFTUyBpbiBzb21lDQpwbGFjZXMgdG9v
LCByaWdodD8gQnV0IHN0YWMoKS9jbGFjKCkgZGVwZW5kIG9uIFg4Nl9GRUFUVVJFX1NNQVAgbm90
DQpYODZfRkVBVFVSRV9MQVNTLiBBIHJlYWRlciBtaWdodCB3b25kZXIsIHdoeSBkbyB3ZSBub3Qg
bmVlZCB0aGUgbGFzcyB2YXJpYW50DQp0aGVyZSB0b28uDQoNCkknZCBleHBlY3QgaW4gdGhlIHJl
YWwgd29ybGQgTEFTUyB3b24ndCBiZSBmb3VuZCB3aXRob3V0IFNNQVAuIE1heWJlIGl0IGNvdWxk
IGJlDQp3b3J0aCBqdXN0IGltcHJvdmluZyB0aGUgY29tbWVudCBhcm91bmQgc3RhYygpL2NsYWMo
KSB0byBpbmNsdWRlIHNvbWUgbm9kIHRoYXQNCml0IGlzIGRvaW5nIExBU1Mgc3R1ZmYgdG9vLCBv
ciB0aGF0IGl0IHJlbGllcyBvbiB0aGF0IFVTRVIgbWFwcGluZ3MgYXJlIG9ubHkNCmZvdW5kIGlu
IHRoZSBsb3dlciBoYWxmLCBidXQgS0VSTkVMIG1hcHBpbmdzIGFyZSBub3Qgb25seSBmb3VuZCB1
cHBlciBoYWxmLg0KDQo+ICBzdGF0aWMgX19hbHdheXNfaW5saW5lIHVuc2lnbmVkIGxvbmcgc21h
cF9zYXZlKHZvaWQpDQo+ICB7DQo+ICAJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2tlcm5lbC9hbHRlcm5hdGl2ZS5jIGIvYXJjaC94ODYva2VybmVsL2FsdGVy
bmF0aXZlLmMNCj4gaW5kZXggNzlhZTljYjUwMDE5Li5kYzkwYjQyMWQ3NjAgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gveDg2L2tlcm5lbC9hbHRlcm5hdGl2ZS5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5l
bC9hbHRlcm5hdGl2ZS5jDQo+IEBAIC0yNDA5LDE2ICsyNDA5LDMwIEBAIHZvaWQgX19pbml0X29y
X21vZHVsZSB0ZXh0X3Bva2VfZWFybHkodm9pZCAqYWRkciwgY29uc3Qgdm9pZCAqb3Bjb2RlLA0K
PiAgX19yb19hZnRlcl9pbml0IHN0cnVjdCBtbV9zdHJ1Y3QgKnRleHRfcG9rZV9tbTsNCj4gIF9f
cm9fYWZ0ZXJfaW5pdCB1bnNpZ25lZCBsb25nIHRleHRfcG9rZV9tbV9hZGRyOw0KPiAgDQo+ICsv
Kg0KPiArICogVGV4dCBwb2tpbmcgY3JlYXRlcyBhbmQgdXNlcyBhIG1hcHBpbmcgaW4gdGhlIGxv
d2VyIGhhbGYgb2YgdGhlDQo+ICsgKiBhZGRyZXNzIHNwYWNlLiBSZWxheCBMQVNTIGVuZm9yY2Vt
ZW50IHdoZW4gYWNjZXNzaW5nIHRoZSBwb2tpbmcNCj4gKyAqIGFkZHJlc3MuDQo+ICsgKg0KPiAr
ICogQWxzbywgb2JqdG9vbCBlbmZvcmNlcyBhIHN0cmljdCBwb2xpY3kgb2YgIm5vIGZ1bmN0aW9u
IGNhbGxzIHdpdGhpbg0KPiArICogQUM9MSByZWdpb25zIi4gQWRoZXJlIHRvIHRoZSBwb2xpY3kg
YnkgdXNpbmcgaW5saW5lIHZlcnNpb25zIG9mDQo+ICsgKiBtZW1jcHkoKS9tZW1zZXQoKSB0aGF0
IHdpbGwgbmV2ZXIgcmVzdWx0IGluIGEgZnVuY3Rpb24gY2FsbC4NCg0KSXMgIkFsc28sIC4uLiIg
aGVyZSByZWFsbHkgYSBzZXBhcmF0ZSBpc3N1ZT8gV2hhdCBpcyB0aGUgY29ubmVjdGlvbiB0bw0K
bGFzc19zdGFjL2NsYWMoKT8NCg0KPiArICovDQo+ICsNCj4gIHN0YXRpYyB2b2lkIHRleHRfcG9r
ZV9tZW1jcHkodm9pZCAqZHN0LCBjb25zdCB2b2lkICpzcmMsIHNpemVfdCBsZW4pDQo+ICB7DQo+
IC0JbWVtY3B5KGRzdCwgc3JjLCBsZW4pOw0KPiArCWxhc3Nfc3RhYygpOw0KPiArCV9faW5saW5l
X21lbWNweShkc3QsIHNyYywgbGVuKTsNCj4gKwlsYXNzX2NsYWMoKTsNCj4gIH0NCj4gIA0KPiAg
c3RhdGljIHZvaWQgdGV4dF9wb2tlX21lbXNldCh2b2lkICpkc3QsIGNvbnN0IHZvaWQgKnNyYywg
c2l6ZV90IGxlbikNCj4gIHsNCj4gIAlpbnQgYyA9ICooY29uc3QgaW50ICopc3JjOw0KPiAgDQo+
IC0JbWVtc2V0KGRzdCwgYywgbGVuKTsNCj4gKwlsYXNzX3N0YWMoKTsNCj4gKwlfX2lubGluZV9t
ZW1zZXQoZHN0LCBjLCBsZW4pOw0KPiArCWxhc3NfY2xhYygpOw0KPiAgfQ0KPiAgDQo+ICB0eXBl
ZGVmIHZvaWQgdGV4dF9wb2tlX2Yodm9pZCAqZHN0LCBjb25zdCB2b2lkICpzcmMsIHNpemVfdCBs
ZW4pOw0KDQo=

