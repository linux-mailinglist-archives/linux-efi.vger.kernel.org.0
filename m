Return-Path: <linux-efi+bounces-4988-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62830BC26CD
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 20:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA7494F00F2
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 18:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560B02E973C;
	Tue,  7 Oct 2025 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LrbTweLZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51531E25F9;
	Tue,  7 Oct 2025 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759862607; cv=fail; b=uwQCJ1PTSQrhcZ/SAu6aKUHBZzRzWUP5S+qoq9gpWZbtQuA3QJlq7cLkHeWlYP9U96rpS0Xb5gj8JrNaCm6+jt09WlEvvKyjdPdNVCc0tcu3cKNo1TxRh45oZ1ZDegb+E/1ayTt776z9pc5/WgJbm6Ae5POQXfebrLRMqKLwUs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759862607; c=relaxed/simple;
	bh=YMzz/fjmVHoh3/YIqpVkthKaJQJTuKBrfWl9UTIto3U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pwpFSEfQGRY6Nva1ipDF1EvNvO0DJktFBt59rRSpTty+lagGFbJLl3LHuoNdsBzmCDrU6JrARf5whsXdG+P41OqKdryVTTvVnGZ6IKpxAMT3yrw6rtf7mhBdi8DvUgnmwnI+3mXV+p+1DZ8ljG4fPe56NGcMvBLWHliblsP6iTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LrbTweLZ; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759862606; x=1791398606;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YMzz/fjmVHoh3/YIqpVkthKaJQJTuKBrfWl9UTIto3U=;
  b=LrbTweLZG2C4pBUJq+iak0JXSGBIbpOFEw5pyVutjD5OjM5XG1xxh/xN
   0h53Aq3q+yRMHdvFkgEwylFZtMLzc6bpuXdczH2lZ0LXu5ynkFtUH4l32
   Bus09K2DNUS1pAXaqq/TJtOFXAx6Ups+qY5vlEACYJDxT2dlCzrUsKYse
   qriP1yZfeXPpW0KAOt023djMv3Sn4D4fKFojuZ8/W76cGYrBfGQsWyuuu
   PL2p91WFhGniHEIgsK/F+aW7/njHog66I6MEGN1P3ZnniIr57Hzxr3c62
   QpzSXGsDcwzbP4vAHvx1uO/7c0yj0SYCZPD1+WlRYoZjmY/MNhEf1XVUh
   A==;
X-CSE-ConnectionGUID: wY67S9sTSZOwQazuZWz2WQ==
X-CSE-MsgGUID: 0Ea83vVMR+Wl5ZpYlu8Lxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="62214474"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="62214474"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 11:43:25 -0700
X-CSE-ConnectionGUID: CtN6LbO0Qdi+9Z8gLvZIkw==
X-CSE-MsgGUID: C3UP2PzqQRGsw/JoyDKJKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="185517103"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 11:43:24 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 11:43:23 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 11:43:23 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.70) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 11:43:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3yZy8mUbcbeULTvb6MgPcInZ9FLzTOoYTCvNEnKBp6CXzHAzhDdJctGfe4Cew4GQJp7y0gV7mO/qF+PgJmB8/DrKnTl45ECe0sdoQqGJmZfScGa0/2yjMI06v6oKIfaDyz6CwC9U8zQKgIpy/vwTL8yUYArS1kRbas6s3jMWRxRf65ugyJQheiJx735Eg92mK+Wy6T/vHDXACT9urlEp7+UcQIqywGPTbjeFYA9e6rodchbFBv4ON0N6z1f34vGbBGlz9Zbb0ewtDa7wBCdkKviqAc/IGBej4mu+G2T/Q2RYiRjWFYB9CF+W3WxGj5KK9ERz/fRVpMkfysQJlnB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMzz/fjmVHoh3/YIqpVkthKaJQJTuKBrfWl9UTIto3U=;
 b=lw+zgWfaklmC/JyZqLhgeWi0KWCNtnqaUjJJ6fpOcNu4K6ocbDMLguhlNNcKthNik0APDExbGkBSbk/LiRKDxx6I7cTCibalEvnZSCvBQgKj2rlLSCSx3uZQ9Hh3REnsyIpgIgpL0ypHl/RHxT5eNeAjzistCJsYSQdFrGalxojSo13l3cUUMtI3eKAJs/p8p7aiZuQ4YARMXQm8LpfGF3o7iU5riUJ+UUQvm7raySEZSS15zqCUmpvNDJyMtPwQD9FbGlQ6U5i2V0MMELNzlMsvxteOo93TnAcF15rVCW3Ki9XhNyCFSATozHR77guDNXh2jUb+4rFQ801X53XqAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH0PR11MB5284.namprd11.prod.outlook.com (2603:10b6:610:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.18; Tue, 7 Oct
 2025 18:43:16 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 18:43:15 +0000
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
Subject: Re: [PATCH v10 11/15] x86/vsyscall: Disable LASS if vsyscall mode is
 set to EMULATE
Thread-Topic: [PATCH v10 11/15] x86/vsyscall: Disable LASS if vsyscall mode is
 set to EMULATE
Thread-Index: AQHcN1cw+9uZZ/w1Gku8EMLteerOULS3BcqA
Date: Tue, 7 Oct 2025 18:43:14 +0000
Message-ID: <d43291be3ae1873870e4b85da35ab81dd10f88ff.camel@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
	 <20251007065119.148605-12-sohil.mehta@intel.com>
In-Reply-To: <20251007065119.148605-12-sohil.mehta@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH0PR11MB5284:EE_
x-ms-office365-filtering-correlation-id: 2165b9b6-9348-4882-26cf-08de05d15ff8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aExMdGFJRGpqQjhjVnlGT1NMbmJ0ZWRCTkdpdTFPaWZGZUF0amhlQlhBNkF3?=
 =?utf-8?B?L2J0NDZwQWZhV2QreVJPQi9jNE40MnlxTXhXeHI4Ylc4ZlUzVFRSdmJ6TEJv?=
 =?utf-8?B?YWpucDRvbW4rQ1JqRlVweGt3UTNIR2EvUU1VN051RjM2Z1R6ZlJlbS91ZWt2?=
 =?utf-8?B?WFVzU1BtSTAydDFBbDJ3MEY3V0xpMzBMUkMrQlYrbEZVSW1SZnMzby9aSzF6?=
 =?utf-8?B?OHo4QnNZQncvMUdrRmlUYk96OXp4VzBOeHdpUzVDSXd0a3lvK2NaVnErZldG?=
 =?utf-8?B?ZWUvU28xZkhnSHk2SUNVd21ndyt4M2VPd25vcnh5cXlMYjRYM0VSRVQ4dFJz?=
 =?utf-8?B?d0JWNUQvQ2p5Ukt5dWIzTmE3RkI0L2dRU3J2Y1kvM1o2MDdDZk42ZDAyVHJS?=
 =?utf-8?B?dkJBOGoybGtzSzdMeVM1d29ESERKZFNGTlozWjh4cW5wWTlnNThYbVBJQVBs?=
 =?utf-8?B?QlN6YkkyZGxXMjBlcTYzM1MvZHZSYitRMldFdnhvQ3VuTDFSK08zT2VxZmgr?=
 =?utf-8?B?cGtTVVMwcFAydE80ZFJRcFZlcmJVTmdPWUJJWjIzMWhOWFoxQ0g4b3RKejdv?=
 =?utf-8?B?UUlmamFCdlhCVWlRQkVIN2hEellQblBpc1dWRjVhN1NXakJGTEZ3clpHZGlL?=
 =?utf-8?B?WDJxMUlIdWRkS1IyVk5YeUxoRSs0bENwMWMwazI0VTBGWXJpTzlnRnZueXFF?=
 =?utf-8?B?bWlwNysxN2xoK2pZSG1rQ0xiS3c3bGxuNVpEMElJOWdGSVREd1lzSEFGU3Ju?=
 =?utf-8?B?MkJBbzM4RExuSEZBVk92NDVIREtGNlRuODRxdTl5OUM1MVRDV3RRNG1pbk9F?=
 =?utf-8?B?ZGpaTk1qYWhSWnYxUDU3L25PWWx6Y1Y5bnJKOE9xRklLTkhad2dDTkhCakg5?=
 =?utf-8?B?WlVMQUMzd0JZVWlWM0c2dFNZaVhKSzB3aEpLMk5lTVdzYXZ1NVRpZ2hOYU0r?=
 =?utf-8?B?NDVjMDRiS21iTDAyaDN4c0JxeDdiNDhUdEsvUFdMZ25TYjBWbWh5OVR5SlRx?=
 =?utf-8?B?NzZsM1M0UzBHNThoRnJVWVJXTUJzWjFEM08zb25YOGoyR2J0dlAxT2dLVXpP?=
 =?utf-8?B?dUU2dSttOEgrU1d3YVBZRTBPV3g1bzZHR3RnalJiZ2tmUzJGRXJ0UTBLb3Vz?=
 =?utf-8?B?bFJmOS9RZWM4dW8xZ1ZVdkVTZXlHMDlqZzVrMEFtaTNoK0R6SURoYTVrSmtS?=
 =?utf-8?B?VEgreCtFb3BDM2Q0VVlMNElTcnR1Wkt5YkNXTlc2cmQ4VFhVa3kzdGUyb0N5?=
 =?utf-8?B?Rkt0MTQ0SkJ1K2FNL3lVVXF0NnRQaDNNaSsrRnF3bEN2UW1lVURvU0prS05D?=
 =?utf-8?B?eGNtSFA1UjZ0WkExT1Yrajk2Yzd1VXA2SW1ydmt3UzhuMjl3alo3Wm01Z2tp?=
 =?utf-8?B?RWRUNFpkZU9INjk1M0tYaDBRM29CTjduNVY0UURjRTBzYUVnb28yb1JtYWVF?=
 =?utf-8?B?bHNKenoyeS9RT0hFcTgrZVdWaHJQTW9Kb2Exb2pudnBHNVgyd1VVZHpaSC93?=
 =?utf-8?B?ZGRwTTNCVm9hV2swY1VtZDNUYzdUOHJpOVRETDhNbHRmYmZ5SXRLaGV4aENL?=
 =?utf-8?B?VWZhT3BBSUlpUHNDV3R4NlZZd0Yxc3UvajlnRExRN2k1NzJQUlkwcXF3MXIv?=
 =?utf-8?B?SGs4K0VXdDlCUHlxZ0RrRVE4TjNRcEpYb0c4ZUY4RXVYU1RGUzg1RFhCV1lk?=
 =?utf-8?B?Y3AvbGlaTmFuZnZnUWUyVnFRNnFIMlNiMXlpNE90ZFA4UzA3VlZCWkxFTXNG?=
 =?utf-8?B?SUw2S3lnTFQ0QWt2TnZLU0d3aU5PakVobG1Lbk0zbVgvNmhIOG9hM3pEbjdX?=
 =?utf-8?B?SGJuY2F6b1hDQnBqdDlxcXY0OWlPTVpWdXVRTllWT0p5VFFCOGRKMEp4bTlJ?=
 =?utf-8?B?ZjJwRnBtU09WNm9JMXhPNHhDRFVOQ3ZwSXJ3RjdqTEhvd3lUcmRPSGdvVUpk?=
 =?utf-8?B?QjQxdnV2ZXdWUWdiSjU5UVBUSU16eUtlSkxldnpPbzV5aFZtVzJNdUM5aU00?=
 =?utf-8?B?bjVtSDJHdlJvK1FxalhOQ24vYk4xTVFHL3VFWG9HYUE2RDdkeUh0cC9xWFZL?=
 =?utf-8?Q?KeScjf?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzNSb3JyWEtWY1NnVmF0bDJpMGtVanMvenFuaFNHNnpiK3Y0amFqWWg4UHB0?=
 =?utf-8?B?cFdxUVVybk1mRnRSclNrTUc3cDhMbnErVStZbW1ZRisybk1jbFRjYjNsMHhp?=
 =?utf-8?B?SU5LbExTTERrZDZvVGQ5WTJDcUdueDh5Z3hwMzRocG0xWUpaalZqNjE4UEZT?=
 =?utf-8?B?TlQwL0FRZ1VkUTV4WENLOHo4MU10bmkwN0dERHJYRnVFWHVnQ1FmWFlSclFB?=
 =?utf-8?B?NitEQzJrMkZHK3IycitOdHZlZHB5NXE1V0hBcm5DdER6c0xJSVh4SlovdHZz?=
 =?utf-8?B?dUR0NENOM1IrMG9VLy9aSEh4YUpVaU5BK2hkeUpCYkUzSmcyRDFmaEc5aGhn?=
 =?utf-8?B?ckRRZjlSVzZDRHFwRVIxUEtXKytodGlFMzI5aHQ5RVRkTi84VXlvL0Y4bDcx?=
 =?utf-8?B?bFdSeWNWUHNKSVRuT1QxMjRkL2h6eDEzbW1CK3AxdUk5M09zUzdLd0ZsazRw?=
 =?utf-8?B?NHU4bzVaZ2pyUk5CemxkdXE5V3l2WXdDUVlvQ2J5SnZOcWtSVzFtbS9kQU0x?=
 =?utf-8?B?OHJrUEF2bnRFSTNLTCtPYVEwOU9pSVIweXd4dzV0L2VKOTFiZ3NQZVF0SHE1?=
 =?utf-8?B?TFNzeVpSVkFvQUdlUGtMdHdTcE1TdG0vL0t4cXZsaVhFZGpZNEVKNnFuLzlG?=
 =?utf-8?B?MGxhWi9yUkVVMGZZUVFzOVQ3UkRiZytXM1AwSUFFV3NIV3k1MFVZVlA3ejdw?=
 =?utf-8?B?anpoTTRiL1FtaUMrYnlUclN1K29oMFJJcENpNjJ6NjY4THBsTGVlYzBhR3ZU?=
 =?utf-8?B?NnVNZ0tscW9iWTcvbVp6NGdpanNnQ0xDT3c2aWYvSnRIKys3eGtkVzlJb284?=
 =?utf-8?B?YmdGMklYMlV1VWp2YlduNXRRL3l2elBYTU41VkwzMmZKRUZEVEcrdFBUWkRa?=
 =?utf-8?B?VVVxaTduQjZyK3BDdkpjTEtqTlhsbVFGamZGTEQzRjBhZzlQcVFVR0gvUC8v?=
 =?utf-8?B?NlBrZGI0SFgrSnIzNzRZRDIvNzB6SXFMUFVkamtHSVYzZVZOZnUzZmMxZEdi?=
 =?utf-8?B?Z2Y3VjE4VlJFc0ZlUTA2bVhndDR3T2NBODYvZ3BxUnBlRll2aXY5MWxKQ1RG?=
 =?utf-8?B?bW5MUThMUnk5QzlXRkx6dmtLaFJBaDcyU2d4ZTQxTEZUMXh0RXRCcjJpWnN4?=
 =?utf-8?B?WGRXRjlVT1FCeHJUMHA5MU1DcmxtcmF3bm13SkhZNnNGWlRRMHVOTk5hQXc0?=
 =?utf-8?B?VHhKUmhrZWFLdGNpSWdkMUtEN3lWSHpwS1piSjlhWlROb1JiWFVYSEZSbW9P?=
 =?utf-8?B?MzVZMFlCdm5mQVZ2am5rWWFOZ2MzZDJJOTZhWmw4bW42TEVuNWU4QjdHc0U2?=
 =?utf-8?B?S2lhaVg4ejlQUlZjSlhrdHNEWEhtWWw3ZzlzZmYycXNmMC9HdStpNkk2Rjcw?=
 =?utf-8?B?M1M2RWxtQzdMTnJudXFzTmtnZHlMSUd3c3BnOGxrK1NwTGZnd2hEc1FEaFps?=
 =?utf-8?B?ZmI2SXRJbnB3MGc2Y01NRVgyaGlzbHljcDgwYVNMUWo0QlpDK3R6V09UbWl4?=
 =?utf-8?B?NkJqL2pIWEQ0QUFzWU0ybklHOWNUbEY5SlY3OTFvdVdzZ2M5blBRRm53TEp6?=
 =?utf-8?B?ZVIxYXYrdDBMZFVJMnBPTlFxbWlVVXpTYUk2VUMwWFpTb3Rzc3Y2MmZsN3RT?=
 =?utf-8?B?aHU0QjNLemJ5V3N1dm5KaThrbDNmQUtlVzU3NzI3NmtLc3lwSHRoZVhVVnJG?=
 =?utf-8?B?V28va3ZUVHgxQW9oamgvck5zNXhOMWxHZERIaVV2UWtDVDZhdTdUQlNmV2N4?=
 =?utf-8?B?RTVjT2RmaWNvMFZ4UndjZ1E0UXJaQ2VoUkljKzkwN3I2NWpSa1M5RGR6SjVy?=
 =?utf-8?B?K2RUVEVUS21yQWdDM3FQQzlONnhCZEorRVpYT3FRSXlsVHNYeWdPOHZZY3hH?=
 =?utf-8?B?WTVRLzhnSUNKdGFHU3NVa3pIajN1M015bGdSU0VIenZtUXJiYVhQaExtYnd5?=
 =?utf-8?B?Z3FTaTJCOGRKeDYzQ0VyYnpxOGRBNzJFU2VnZS82MEtKM2ZNa055RStudnh3?=
 =?utf-8?B?c1JIOWU3c2dFRE8zTW0yVHhiUTZhOTBoTzd5eEdEeFRxcXk5WmJoT3V3REtF?=
 =?utf-8?B?MEhBVGRzc3A5alEyZGFVVVJGTFhDRlFxVzRTdXhmU2wzZjlMVkRWTzVkWFJE?=
 =?utf-8?B?L0NhUmV6NTBHWHRSU1JsRFQzbHIwK054VjBCcjI1bVAzNHFkbm1WNlkvdHNJ?=
 =?utf-8?B?NXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAA053BE69A04A459132A0F5700EC8BB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2165b9b6-9348-4882-26cf-08de05d15ff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 18:43:14.9490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pmLPFe7+FDZ6tq2k2CV7Fju23J370HZfURDmtrPrUhYBsAE8De5RqOqvkuTp0BAICwiRkT7SyUEFQh5yKC/hCO8j+f/ds2PggjI+TYioTD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5284
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTEwLTA2IGF0IDIzOjUxIC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
VGhlIEVNVUxBVEUgbW9kZSBvZiB2c3lzY2FsbCBtYXBzIHRoZSB2c3lzY2FsbCBwYWdlIHdpdGgg
YSBoaWdoIGtlcm5lbA0KPiBhZGRyZXNzIGRpcmVjdGx5IGludG8gdXNlciBhZGRyZXNzIHNwYWNl
LiBSZWFkaW5nIHRoZSB2c3lzY2FsbCBwYWdlIGluDQo+IEVNVUxBVEUgbW9kZSB3b3VsZCBjYXVz
ZSBMQVNTIHRvIHRyaWdnZXIgYSAjR1AuDQo+IA0KPiBGaXhpbmcgdGhlIExBU1MgdmlvbGF0aW9u
IGluIEVNVUxBVEUgbW9kZSB3b3VsZCByZXF1aXJlIGNvbXBsZXgNCj4gaW5zdHJ1Y3Rpb24gZGVj
b2RpbmcgYmVjYXVzZSB0aGUgcmVzdWx0aW5nICNHUCBkb2VzIG5vdCBpbmNsdWRlIGFueQ0KPiB1
c2VmdWwgZXJyb3IgaW5mb3JtYXRpb24sIGFuZCB0aGUgdnN5c2NhbGwgYWRkcmVzcyBpcyBub3Qg
cmVhZGlseQ0KPiBhdmFpbGFibGUgaW4gdGhlIFJJUC4NCj4gDQo+IFRoZSBFTVVMQVRFIG1vZGUg
aGFzIGJlZW4gZGVwcmVjYXRlZCBzaW5jZSAyMDIyIGFuZCBjYW4gb25seSBiZSBlbmFibGVkDQo+
IHVzaW5nIHRoZSBjb21tYW5kIGxpbmUgcGFyYW1ldGVyIHZzeXNjYWxsPWVtdWxhdGUuIFNlZSBj
b21taXQNCj4gYmYwMDc0NWU3NzkxICgieDg2L3ZzeXNjYWxsOiBSZW1vdmUgQ09ORklHX0xFR0FD
WV9WU1lTQ0FMTF9FTVVMQVRFIikgZm9yDQo+IGRldGFpbHMuIEF0IHRoaXMgcG9pbnQsIG5vIG9u
ZSBpcyBleHBlY3RlZCB0byBiZSB1c2luZyB0aGlzIGluc2VjdXJlDQo+IG1vZGUuIFRoZSByYXJl
IHVzYWdlcyB0aGF0IG5lZWQgaXQgb2J2aW91c2x5IGRvIG5vdCBjYXJlIGFib3V0IHNlY3VyaXR5
Lg0KPiANCj4gRGlzYWJsZSBMQVNTIHdoZW4gRU1VTEFURSBtb2RlIGlzIHJlcXVlc3RlZCB0byBh
dm9pZCBicmVha2luZyBsZWdhY3kNCj4gdXNlciBzb2Z0d2FyZS4gQWxzbywgdXBkYXRlIHRoZSB2
c3lzY2FsbCBkb2N1bWVudGF0aW9uIHRvIHJlZmxlY3QgdGhpcy4NCj4gTEFTUyB3aWxsIG9ubHkg
YmUgc3VwcG9ydGVkIGlmIHZzeXNjYWxsIG1vZGUgaXMgc2V0IHRvIFhPTkxZIChkZWZhdWx0KQ0K
PiBvciBOT05FLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU29oaWwgTWVodGEgPHNvaGlsLm1laHRh
QGludGVsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNv
bWJlQGludGVsLmNvbT4NCg0KPiAtLS0NCj4gdjEwOg0KPiDCoC0gTm8gc2lnbmlmaWNhbnQgY2hh
bmdlLiBNaW5vciBjaGFuZ2VzIHRvIGNvZGUgZm9ybWF0dGluZy4NCj4gDQo+IEV2ZW50dWFsbHks
IHdlIHdhbnQgdG8gZ2V0IHJpZCBvZiB0aGUgRU1VTEFURSBtb2RlIGFsdG9nZXRoZXIuIExpbnVz
IGFuZA0KPiBBbmR5TCBzZWVtIHRvIGJlIG9rYXkgd2l0aCBzdWNoIGEgY2hhbmdlLiBIb3dldmVy
LCB0aG9zZSBjaGFuZ2VzIGFyZQ0KPiBiZXlvbmQgdGhlIHNjb3BlIG9mIHRoaXMgc2VyaWVzLg0K
DQo=

