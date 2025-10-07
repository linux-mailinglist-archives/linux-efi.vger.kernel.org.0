Return-Path: <linux-efi+bounces-4986-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CD2BC266A
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 20:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E30A402107
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 18:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06682E974E;
	Tue,  7 Oct 2025 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULgjIGzT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031652E9746;
	Tue,  7 Oct 2025 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759862256; cv=fail; b=SXjvbOjzAc8iBN+LE2gZ/t4g+vu3Q1gt+94UKDzqux9ybNi9o3CbTc19VmewyqoDR7UIeddUgtIhn8lLJw/OTWIsUiAry7gypyALT6O4Xp/uUbsKS7x6Mw/HKbhZBoWUh9IcXkRAH0Ds5soYT1l7ckbLS5FfBYxUHHGUaWW+Sw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759862256; c=relaxed/simple;
	bh=FgUZi8Dgjv0ne8stuUaTXV7RFBFj7ISAlLLwnpazmfk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=savr5IhL21YjKEI7VOqWNaUiJQwnZx2incqO+X24IPPD5eU4scoHJZsF5PdbYoEw4fFJ6z2P5oBoq7X/An1woAYmt0V0xbA9RlnEyz87jZQNWwlk5HH/AZaPH5LyYwS1v9/3hypfoTseBuCToPlri6ny6erMDoVHOGYWdgrkyPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ULgjIGzT; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759862255; x=1791398255;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FgUZi8Dgjv0ne8stuUaTXV7RFBFj7ISAlLLwnpazmfk=;
  b=ULgjIGzT0GdgV51bO5ln6gFGrdY3X5yGw72gxUD4HhN7LOdzAPtz0pSN
   8p9P7KKXlt527zaCigLlynPxrdMhnvuh0QN09u7JzYCnapaizt7AQQdOV
   2mJn38IpRiHwIncwC+ZRch/tB1unwuXdh9nMOm4f/SLUJCltJaSDWVw63
   gboR3UMQ6O1QFJM8jchHDcOwtSskhZD20dSSFqpn0GZQ0OFTltRn0G3aD
   mzKqJ/Ifg0iI+QREl3ibr5jmy6eiexlYCUusOSUuZy2TYsqRh9xvBM1No
   dEvK6/IDW9MXr3skIDLHBX3CmrZwiY1TDBI4TJwcSV5DprstGZC2tfyBC
   w==;
X-CSE-ConnectionGUID: tT2N5weRRWm4wBc0TWB7CQ==
X-CSE-MsgGUID: 49vKaQhcRrikHQBk+/4Raw==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="61086235"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="61086235"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 11:37:34 -0700
X-CSE-ConnectionGUID: a51aTnrqRvSf/oHMJHdrfQ==
X-CSE-MsgGUID: ZckFtNi4QLiw2wFFsmHIXQ==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 11:37:34 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 11:37:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 11:37:33 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 11:37:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dF4j1H+kraisOySvTV1nHcfbgjFj+lzgEn3mpxqJAGCyb9g/tolJaIUYpUdanhgEiETsrr2a50I7Lz09o/fh72MqedEBWhnpD5cFEP2MUoWp3yXRLlYFByEsViOVullZKDsqKDTmm+yoGzdmMhApeldAEa555gztdsivv/yJCG54vgPDyNRR/vP3v4JXuJZU6VCvQaRa1x37gEhxosOCBsKvXhsUQIibgWHbwdHDYYtnUvAobzww86NREgofR95H6zkFGXMKBUEJurHkzDug38rj4yukZS+FbttA2+gPa7nfRJATuWi1imZhcYdinPqxlaFs3REKtmBECTu5BD5qmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgUZi8Dgjv0ne8stuUaTXV7RFBFj7ISAlLLwnpazmfk=;
 b=Fa+7a7H49eJ1LWG/dpjx9Lk/wGIw84RKC3oDzBSKkx+UOs6BJTp+mX/6J0AgWMEQtoqDOXGoBVfI6NlYgXfC4rRXVUtpGD6va4iT1ISPWOdHkSINPG+RTTkn4Vw8ZT28v0al/ZDwMnZoZy/XnumDUVgIio64fgfZe9k3kMg2NJWsZTDeEGzXafov/Ll+Wh/TnFRcoMbojS80Spvfv+2oXINN29MRM7pB+f8q2RHCn6nu7t/GhxxOX0QM2sMq09fCGJg4KgzaUjMy75Vu2TQQ8Y7kQEZ+Wqm5JZoesht3aODqcCtX9XZrS4/7MZaZWXD/Z3buQf+hji0IGwnzP/kCiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA1PR11MB6992.namprd11.prod.outlook.com (2603:10b6:806:2b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 18:37:27 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 18:37:27 +0000
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
Subject: Re: [PATCH v10 08/15] x86/vsyscall: Reorganize the page fault
 emulation code
Thread-Topic: [PATCH v10 08/15] x86/vsyscall: Reorganize the page fault
 emulation code
Thread-Index: AQHcN1cybBcaoDcZbUCUg2EjTwKZL7S3BCwA
Date: Tue, 7 Oct 2025 18:37:27 +0000
Message-ID: <a33d59c7add98dd9ef352ac95178821dbcd0ce0e.camel@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
	 <20251007065119.148605-9-sohil.mehta@intel.com>
In-Reply-To: <20251007065119.148605-9-sohil.mehta@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA1PR11MB6992:EE_
x-ms-office365-filtering-correlation-id: e4222b11-4537-4b9a-3d09-08de05d090f8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?d2ZwY1kxQlU5di9yQ1hqYjJwa3FVeVJ4QklyOGVSNjl4WEp5UmRFODJDWjhJ?=
 =?utf-8?B?UWlSUWlOd0J3aFpzMDlPMGgwQkRZKy9PY05RZVZTQmE4ZHY4S2ZGcHIvK3kr?=
 =?utf-8?B?a0NBNXdQUzhuU0gxNWkzY0t1clA2RzEwdzNXNTE5bTJ6OFRWZjFmODZ1SllY?=
 =?utf-8?B?VmJRUWhRYW1ybUN1MVVnTC90NDlHOHZTWXNlVTI3SEp1VVFWcGpwbngxd0VX?=
 =?utf-8?B?OWVncytWU1EwQmVFMjhsaEt1Wk5XRHBxK0V6QnY0OE5Yd3o4YUFaZVhzL0ta?=
 =?utf-8?B?NUpnU0lsajBTZXpWZ1V1dVdrZFpDa3NGMUNiVUkxdk1NbjI5YXJkRVY3QlpG?=
 =?utf-8?B?OW9heEVEd3pqaFFLcHVraGRtNXkxRUpGbkhFM0pFOTZJM3JTZUVyTXZRY0Na?=
 =?utf-8?B?N0hLNnllYXBOTi9EdjFqRm5MRFhMYW9VRkF6RTk1Vi85alpsa2hIS3Y3SHNm?=
 =?utf-8?B?VEE3Vm9Mcld3OXdtYUc3T2g4QXRvbE16NEN6cVhHdWhFQzdxTzgrWWxIRklE?=
 =?utf-8?B?WGUzcW5yT1lnOFBwNFJQTlluRVBrUE1HeERLVU4yWlFHYzF4T0FVR09Jdk9G?=
 =?utf-8?B?dWFCb3Myb2o5WklhREhrSEJTaHI4ZDRtcGZxaHkxU2FxN2hRVFlRaTNHd3Vo?=
 =?utf-8?B?OFRrZzFyeFJhQm9PNCsvVm5leVMwZVhTREovTmZHVnEvT2JQZkplMHBTbUNz?=
 =?utf-8?B?TUd5TTFsakJtc3Z5ajB5V3hCRVhlUXRYaTVQRnFWRGRaOWJCN1h1RDB0Zzlv?=
 =?utf-8?B?WkM0bjNlWlhxcE4rck9XZ0NRRDVVYm9UR296Z2lmcFlEMzUyWFROaHJzMEQz?=
 =?utf-8?B?d0VlMmlEWGJQWkJDaFFUVEd1ZStBZXpLRVFmbnlDKytaSkN6SUUvNElQZktV?=
 =?utf-8?B?SmVweitHQTc5bExOZVQ2V1ZOVFZLeGxhR3JtZllMK2VJV1pjY2RIeC83UkhG?=
 =?utf-8?B?M2xJQXdnTTd0R0lMU1ZSMjAvbi83RUQyeU5wbFFoUEppODlHaHdUVHZ1VVBs?=
 =?utf-8?B?am01VE02dHVtUlZ0c253RzR5S0wrL2FNVGcveWtkK05MYS9rY0k5QXdsNGNY?=
 =?utf-8?B?a2o2dm5yNGx5SDRWYk5jWFBML0ExZCtaV1BSYTgzckdBMVlGZjAxNXV4Q0p5?=
 =?utf-8?B?d3JCajZFd0xlQndzYWN3Z3FxbjJhOEVaQ3ZJN3VWN1RQTVV3V2VsMlRNTG9Z?=
 =?utf-8?B?K05HaVRwMXMxQURCSHNyTkdUVXZCQzA1MkxMeWx3L3NMbXA2b3FKVGk0d0Jt?=
 =?utf-8?B?eGpoMjl1czROYWZoVWYvY0hRNjZ6NG41QldHQ3ZUMXRzU0dCOHlJRW1Cbitj?=
 =?utf-8?B?K2R0bHdZVis4NDlqZG9KVktUVGNSVzB6VitydWtzMUlrZU52N1NMMVNuTU1r?=
 =?utf-8?B?MHd6YkdCV1dMNTUrUm52Ti9vVUtObHdIYndUL1ZPUStScEZNNWdFTVkxVDB5?=
 =?utf-8?B?bXQvQkZJOU9iVjlYbVQzWFVPQTlWZWNkd1ExbXAyU2sxWmJvbFZHMk1Tb2Vo?=
 =?utf-8?B?MGhTR3BoQ1Bpb01XUjVIRFh1Q2ZiWml2WUJWb0ZYakkvcTdnUlhnVlkyTTVm?=
 =?utf-8?B?b09GazV2UG9aZjNGQ1lFZm1qUG8xS2JhVUl3bU51N25OZ3dDdjl4WFE1aXgr?=
 =?utf-8?B?T01UZlBWbE53dVZWTVpvVjY5VEFrT1NuamlmV3NoVmZQNmsxUjJWQ0JFaGJ4?=
 =?utf-8?B?ZUpaNjdYSGlUaWFDN3JDNkdmM3E1KzV2cExZbTFyTWVGWnZuVEd0cklUZVlj?=
 =?utf-8?B?WDJrTjJ0bVg3U2N0SUw1K3JkcVY2MUJ2Q0N3c1BNdUtRQXcvaXJWMlcwcDNV?=
 =?utf-8?B?SjJTWC9ydGNWcC9VN05QNlA4L0JiVkJPMit6cGtWd0VibGNLQWw4UksrS3VU?=
 =?utf-8?B?YS9XV3NsYzlzMlpQTU1pczhzM0RCd0l6bnJHYllXVE01WFlqYlU0ZHpoL2hO?=
 =?utf-8?B?azhDclN4V3VVbUNHR2hJUVRDbWxNdm1QN1cyUFF2MFp6Q1Fpdyt2eUtZcGpH?=
 =?utf-8?B?Z0I0Ni9vNEp1SS9EOGNWUVdlVmdYTDdRa1MxUFFmTEZ3T3V2OUNnZG9lSk5q?=
 =?utf-8?Q?XKTRoW?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1YzQTkzYnFDMDlCajJ6RFN4V05rcks5MjQyM3hMcS9JNk1PZGVwRzJaOXRv?=
 =?utf-8?B?UFcwQ3RmMzJFMjZiQkpaUUd4SGVudnhqRnh2aU9GSFBKa3R1S1B2U0E2Z3Ev?=
 =?utf-8?B?c1JQRW9UWHRVMkEycUg4aXRFU25IWDA5MVRqTU9ndU9oWHl4bHhNZzJBUVdx?=
 =?utf-8?B?R2JRYklkT1lkTDcxU2tHTFNObVlUQ24xZ2UrSTgvd2tNemNqNDQvQTVMdEJD?=
 =?utf-8?B?YVBzYnBneGo2dFJRTFlCMzh4SmFXdXBlUVlTUnhtUS9mRmJEeCtRWEExbG1F?=
 =?utf-8?B?UEM3aDhHVlZha1UvSUM1V0ZDTk9WVUhrT3NHNzd0bVlSbzhBM2Q0Z2duWnVV?=
 =?utf-8?B?VXZ0WTVwVUxwSzR6MTFvc3dsU2NHYlhJbi8zeUV0S1p1ZFFvWXBhNG1yNi9m?=
 =?utf-8?B?OVUrZmZiOWZXWkg1bXlzWWlXTTJYOWEyRW00L1JicFlxdG5FaVhoRUtWOTNW?=
 =?utf-8?B?U09qdmhRdGtIL3dRRzRzZGJLUGVVdTVDYlpjL2F4SkFkOG5EUGEzdGhmaFJZ?=
 =?utf-8?B?RlVlUnlVcFdzT0xTcEtKNXJhUXRZZDFRNVd3V283SEZyVXNLaWtBL09DS1Zz?=
 =?utf-8?B?UlZWdmRNQnlRUnRwVVl2MHNWZWQ0YVlDczcrNks2bjdDT0hkUVhlaEI5am94?=
 =?utf-8?B?YzlrRnc1S3dHb0o1ZFl4N2JuOWdTeFNGa3cvUjJ3M2NwZ3QvaUsrMHk2MXVH?=
 =?utf-8?B?WmJlNDBveFhvdVN1ZnRVajhXOWt5YXI5NTh6b3lXT0tTOGVLb012ZnBtZ2NM?=
 =?utf-8?B?VVk2eGFWNCt2R0dyd1RCTnkycEpFeHdncjd5Zk14a0l5bWV6VjJ6b2I4MXkw?=
 =?utf-8?B?YXU0Q0pwM3pZSGZMcThTZ0F6bmZray9uL1ZPRnpxNnE3U0F0V2Y1TFlNNkFV?=
 =?utf-8?B?SVZVMUJKeDhCZGhPTjNWcTExOU5UckhSNG93aXNHMHhLRDJGaVpYUUNOM1Qw?=
 =?utf-8?B?d2s4emRYOFB2WWdEcFFhc1NHSm90U0ZIV25HSkJnVnl6elpOSk82ak50WWV5?=
 =?utf-8?B?RjJkODJXcmdQcGxPM1ZsS0VGakJTdVVJMGQxMmhDZmh3Y1BzMXZGVEoxNlU1?=
 =?utf-8?B?VFMwaGVZZ1ZDRnExYlM5cFo2QkZzUmVmNWF1N1pNZjNDMlJUWTJiSHU3UWJJ?=
 =?utf-8?B?UzIvMHA2ODFDMnMxVkVKei94WlJuUWlkZU5OQ0ZLaTBBWERFUE80ZFRiWFYx?=
 =?utf-8?B?VU5oN0NsYzhIRGVLM2JqN2paTXFHTGJnM1NhV1dDT0c2S1g3NnVSbngvTWlV?=
 =?utf-8?B?NXJTbG1acmR5ek1jeU1SOFNCVmhqbjU1U1V6QlIxdUVidnVlQ0kwRXlOdE5W?=
 =?utf-8?B?WG40WEJQQ2tJekdRdTZMa0pDUU5EdEV1dUVnQkJ2ZnZZbnF2UVFVSWYyRG16?=
 =?utf-8?B?NEdPekVkQ2lJa3RucUdrQkhlT2UxNHl5V20rVUVEZ3MzeHltRlBvYW1WM0la?=
 =?utf-8?B?ZWt1c1FkT1hQTHFrN01TT1pmSUlUM0VLZ1RZNTZXMzhtYWpYd0RkM2VNdG1z?=
 =?utf-8?B?OXViaWx3UzNzUXB3S3NFMG9HdlZuM0lMU0UrcVNhWEdZaEpQYlZRdExRVmMr?=
 =?utf-8?B?YkdEdTBOaGJ0OW52NVhzUDIzekhONzhWNVIxNHd0WVplaXp6djFLK1pYVTV0?=
 =?utf-8?B?ZXV3L2szYWdsVWpWKytrbnh2VlVIMnhxSDlKVEhFRVc1MUFQNFQramc2cmtq?=
 =?utf-8?B?bWJvS1o3Z2pjTEh0TzBER0RUcUlZMVlibGpCdWZqU25PMWduV1B6aEFCQ2c4?=
 =?utf-8?B?WVJFRlhwR0xiZ2Vpd3YzSElkc015ekNMd01oZS9sT1NBK0FyTTZRSTV0R3Bl?=
 =?utf-8?B?aDZqYmR3cUI1OHFOVGhOK0lPdE9WT1lYbktVNTJ3Y040cy9lZERlY1JiV3hB?=
 =?utf-8?B?T0RmR0pOczVrckwydG1BK2VrM2ZnVW1hdjBvVitoSDVkUFI5dmVoTTlYMlVJ?=
 =?utf-8?B?SndTUmVnSXlpRXVDRFdLb2F2VlBNS2J5SVlwM2had0tlTHFvaFZOeFR2eXAv?=
 =?utf-8?B?cjVkYXlzSFZJdWdkcFJUSVhobmQ5T09wQkNjZW5sR3VMWWU3TGlkMmxvSndS?=
 =?utf-8?B?czZTUE9FT0VMYjF6bkFFNFN4anRSZTZ0NGZJZnYvWEI5eU9majlreG54U2Jv?=
 =?utf-8?B?WityRkF0bFQybVN2bnpiNEZSb25MNVlhQ1pQT3p1WTVMZG1xdmZBUkRCbW5Q?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE8585DDF93D2946BB3EE023CB139708@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4222b11-4537-4b9a-3d09-08de05d090f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 18:37:27.6260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ToHGqajKAAeRr2v06hM98+/vZXQsr7slWDQd6TS5DvPWcrqz7RPCpyH5zHIDDLxrDpNeKpa8fJcNl+J0nJbiCSnY1iyUCwe1NBIJUyNPs9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6992
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTEwLTA2IGF0IDIzOjUxIC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
U2VwYXJhdGUgb3V0IHRoZSBhY3R1YWwgdnN5c2NhbGwgZW11bGF0aW9uIGZyb20gdGhlICNQRiBz
cGVjaWZpYw0KPiBoYW5kbGluZyBpbiBwcmVwYXJhdGlvbiBmb3IgdGhlIHVwY29taW5nICNHUCBl
bXVsYXRpb24uDQo+IA0KPiBObyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZC4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFNvaGlsIE1laHRhIDxzb2hpbC5tZWh0YUBpbnRlbC5jb20+DQo+IEFja2Vk
LWJ5OiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPg0KPiAtLS0NCj4g
djEwOg0KPiAgLSBNb2RpZnkgdGhlIGNvZGUgZmxvdyBzbGlnaHRseSB0byBtYWtlIGl0IGVhc2ll
ciB0byBmb2xsb3cuDQo+IC0tLQ0KPiAgYXJjaC94ODYvZW50cnkvdnN5c2NhbGwvdnN5c2NhbGxf
NjQuYyB8IDYzICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPiAgYXJjaC94ODYvaW5jbHVk
ZS9hc20vdnN5c2NhbGwuaCAgICAgICB8ICA3ICsrLQ0KPiAgYXJjaC94ODYvbW0vZmF1bHQuYyAg
ICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDM2IGluc2VydGlv
bnMoKyksIDM2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5
L3ZzeXNjYWxsL3ZzeXNjYWxsXzY0LmMgYi9hcmNoL3g4Ni9lbnRyeS92c3lzY2FsbC92c3lzY2Fs
bF82NC5jDQo+IGluZGV4IDZlNmMwYTc0MDgzNy4uNGMzZjQ5YmYzOWU2IDEwMDY0NA0KPiAtLS0g
YS9hcmNoL3g4Ni9lbnRyeS92c3lzY2FsbC92c3lzY2FsbF82NC5jDQo+ICsrKyBiL2FyY2gveDg2
L2VudHJ5L3ZzeXNjYWxsL3ZzeXNjYWxsXzY0LmMNCj4gQEAgLTExMiw0MyArMTEyLDEzIEBAIHN0
YXRpYyBib29sIHdyaXRlX29rX29yX3NlZ3YodW5zaWduZWQgbG9uZyBwdHIsIHNpemVfdCBzaXpl
KQ0KPiAgCX0NCj4gIH0NCj4gIA0KPiAtYm9vbCBlbXVsYXRlX3ZzeXNjYWxsKHVuc2lnbmVkIGxv
bmcgZXJyb3JfY29kZSwNCj4gLQkJICAgICAgc3RydWN0IHB0X3JlZ3MgKnJlZ3MsIHVuc2lnbmVk
IGxvbmcgYWRkcmVzcykNCj4gK3N0YXRpYyBib29sIF9fZW11bGF0ZV92c3lzY2FsbChzdHJ1Y3Qg
cHRfcmVncyAqcmVncywgdW5zaWduZWQgbG9uZyBhZGRyZXNzKQ0KPiAgew0KPiAgCXVuc2lnbmVk
IGxvbmcgY2FsbGVyOw0KPiAgCWludCB2c3lzY2FsbF9uciwgc3lzY2FsbF9uciwgdG1wOw0KPiAg
CWxvbmcgcmV0Ow0KPiAgCXVuc2lnbmVkIGxvbmcgb3JpZ19keDsNCj4gIA0KPiAtCS8qIFdyaXRl
IGZhdWx0cyBvciBrZXJuZWwtcHJpdmlsZWdlIGZhdWx0cyBuZXZlciBnZXQgZml4ZWQgdXAuICov
DQo+IC0JaWYgKChlcnJvcl9jb2RlICYgKFg4Nl9QRl9XUklURSB8IFg4Nl9QRl9VU0VSKSkgIT0g
WDg2X1BGX1VTRVIpDQo+IC0JCXJldHVybiBmYWxzZTsNCj4gLQ0KPiAtCS8qDQo+IC0JICogQXNz
dW1lIHRoYXQgZmF1bHRzIGF0IHJlZ3MtPmlwIGFyZSBiZWNhdXNlIG9mIGFuDQo+IC0JICogaW5z
dHJ1Y3Rpb24gZmV0Y2guIFJldHVybiBlYXJseSBhbmQgYXZvaWQNCj4gLQkgKiBlbXVsYXRpb24g
Zm9yIGZhdWx0cyBkdXJpbmcgZGF0YSBhY2Nlc3NlczoNCj4gLQkgKi8NCj4gLQlpZiAoYWRkcmVz
cyAhPSByZWdzLT5pcCkgew0KPiAtCQkvKiBGYWlsZWQgdnN5c2NhbGwgcmVhZCAqLw0KPiAtCQlp
ZiAodnN5c2NhbGxfbW9kZSA9PSBFTVVMQVRFKQ0KPiAtCQkJcmV0dXJuIGZhbHNlOw0KPiAtDQo+
IC0JCS8qDQo+IC0JCSAqIFVzZXIgY29kZSB0cmllZCBhbmQgZmFpbGVkIHRvIHJlYWQgdGhlIHZz
eXNjYWxsIHBhZ2UuDQo+IC0JCSAqLw0KPiAtCQl3YXJuX2JhZF92c3lzY2FsbChLRVJOX0lORk8s
IHJlZ3MsICJ2c3lzY2FsbCByZWFkIGF0dGVtcHQgZGVuaWVkIC0tIGxvb2sgdXAgdGhlIHZzeXNj
YWxsIGtlcm5lbCBwYXJhbWV0ZXIgaWYgeW91IG5lZWQgYSB3b3JrYXJvdW5kIik7DQo+IC0JCXJl
dHVybiBmYWxzZTsNCj4gLQl9DQo+IC0NCj4gLQkvKg0KPiAtCSAqIFg4Nl9QRl9JTlNUUiBpcyBv
bmx5IHNldCB3aGVuIE5YIGlzIHN1cHBvcnRlZC4gIFdoZW4NCj4gLQkgKiBhdmFpbGFibGUsIHVz
ZSBpdCB0byBkb3VibGUtY2hlY2sgdGhhdCB0aGUgZW11bGF0aW9uIGNvZGUNCj4gLQkgKiBpcyBv
bmx5IGJlaW5nIHVzZWQgZm9yIGluc3RydWN0aW9uIGZldGNoZXM6DQo+IC0JICovDQo+IC0JaWYg
KGNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfTlgpKQ0KPiAtCQlXQVJOX09OX09OQ0Uo
IShlcnJvcl9jb2RlICYgWDg2X1BGX0lOU1RSKSk7DQo+IC0NCj4gIAkvKg0KPiAgCSAqIE5vIHBv
aW50IGluIGNoZWNraW5nIENTIC0tIHRoZSBvbmx5IHdheSB0byBnZXQgaGVyZSBpcyBhIHVzZXIg
bW9kZQ0KPiAgCSAqIHRyYXAgdG8gYSBoaWdoIGFkZHJlc3MsIHdoaWNoIG1lYW5zIHRoYXQgd2Un
cmUgaW4gNjQtYml0IHVzZXIgY29kZS4NCg0KSSBkb24ndCBrbm93LiBJcyB0aGlzIGFzIHRydWUg
YW55IG1vcmU/IFdlIGFyZSBub3cgc29tZXRpbWVzIGd1ZXNzaW5nIGJhc2VkIG9uDQpyZWdzLT5p
cCBvZiBhICNHUC4gV2hhdCBpZiB0aGUga2VybmVsIGFjY2lkZW50YWxseSB0cmllcyB0byBqdW1w
IHRvIHRoZSB2c3lzY2FsbA0KYWRkcmVzcz8gVGhlbiB3ZSBhcmUgcmVhZGluZyB0aGUga2VybmVs
IHN0YWNrIGFuZCBzdHJhbmdlIHRoaW5ncy4gTWF5YmUgaXQncw0Kd29ydGggcmVwbGFjaW5nIHRo
ZSBjb21tZW50IHdpdGggYSBjaGVjaz8gRmVlbCBmcmVlIHRvIGNhbGwgdGhpcyBwYXJhbm9pZC4N
Cg0KDQo+IEBAIC0yODEsNiArMjUxLDM3IEBAIGJvb2wgZW11bGF0ZV92c3lzY2FsbCh1bnNpZ25l
ZCBsb25nIGVycm9yX2NvZGUsDQo+ICAJcmV0dXJuIHRydWU7DQo+ICB9DQo+ICANCj4gK2Jvb2wg
ZW11bGF0ZV92c3lzY2FsbF9wZih1bnNpZ25lZCBsb25nIGVycm9yX2NvZGUsIHN0cnVjdCBwdF9y
ZWdzICpyZWdzLA0KPiArCQkJIHVuc2lnbmVkIGxvbmcgYWRkcmVzcykNCj4gK3sNCj4gKwkvKiBX
cml0ZSBmYXVsdHMgb3Iga2VybmVsLXByaXZpbGVnZSBmYXVsdHMgbmV2ZXIgZ2V0IGZpeGVkIHVw
LiAqLw0KPiArCWlmICgoZXJyb3JfY29kZSAmIChYODZfUEZfV1JJVEUgfCBYODZfUEZfVVNFUikp
ICE9IFg4Nl9QRl9VU0VSKQ0KPiArCQlyZXR1cm4gZmFsc2U7DQo+ICsNCj4gKwkvKg0KPiArCSAq
IEFzc3VtZSB0aGF0IGZhdWx0cyBhdCByZWdzLT5pcCBhcmUgYmVjYXVzZSBvZiBhbiBpbnN0cnVj
dGlvbg0KPiArCSAqIGZldGNoLiBSZXR1cm4gZWFybHkgYW5kIGF2b2lkIGVtdWxhdGlvbiBmb3Ig
ZmF1bHRzIGR1cmluZw0KPiArCSAqIGRhdGEgYWNjZXNzZXM6DQo+ICsJICovDQo+ICsJaWYgKGFk
ZHJlc3MgIT0gcmVncy0+aXApIHsNCj4gKwkJIC8qIFVzZXIgY29kZSB0cmllZCBhbmQgZmFpbGVk
IHRvIHJlYWQgdGhlIHZzeXNjYWxsIHBhZ2UuICovDQo+ICsJCWlmICh2c3lzY2FsbF9tb2RlICE9
IEVNVUxBVEUpDQo+ICsJCQl3YXJuX2JhZF92c3lzY2FsbChLRVJOX0lORk8sIHJlZ3MsICJ2c3lz
Y2FsbCByZWFkIGF0dGVtcHQgZGVuaWVkIC0tIGxvb2sgdXAgdGhlIHZzeXNjYWxsIGtlcm5lbCBw
YXJhbWV0ZXIgaWYgeW91IG5lZWQgYSB3b3JrYXJvdW5kIik7DQo+ICsNCj4gKwkJcmV0dXJuIGZh
bHNlOw0KPiArCX0NCj4gKw0KPiArCS8qDQo+ICsJICogWDg2X1BGX0lOU1RSIGlzIG9ubHkgc2V0
IHdoZW4gTlggaXMgc3VwcG9ydGVkLiAgV2hlbg0KPiArCSAqIGF2YWlsYWJsZSwgdXNlIGl0IHRv
IGRvdWJsZS1jaGVjayB0aGF0IHRoZSBlbXVsYXRpb24gY29kZQ0KPiArCSAqIGlzIG9ubHkgYmVp
bmcgdXNlZCBmb3IgaW5zdHJ1Y3Rpb24gZmV0Y2hlczoNCj4gKwkgKi8NCj4gKwlpZiAoY3B1X2Zl
YXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9OWCkpDQo+ICsJCVdBUk5fT05fT05DRSghKGVycm9y
X2NvZGUgJiBYODZfUEZfSU5TVFIpKTsNCj4gKw0KPiArCXJldHVybiBfX2VtdWxhdGVfdnN5c2Nh
bGwocmVncywgYWRkcmVzcyk7DQo+ICt9DQo+ICsNCj4gIC8qDQo+ICAgKiBBIHBzZXVkbyBWTUEg
dG8gYWxsb3cgcHRyYWNlIGFjY2VzcyBmb3IgdGhlIHZzeXNjYWxsIHBhZ2UuICBUaGlzIG9ubHkN
Cj4gICAqIGNvdmVycyB0aGUgNjRiaXQgdnN5c2NhbGwgcGFnZSBub3cuIDMyYml0IGhhcyBhIHJl
YWwgVk1BIG5vdyBhbmQgZG9lcw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20v
dnN5c2NhbGwuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3ZzeXNjYWxsLmgNCj4gaW5kZXggNDcy
ZjAyNjNkYmM2Li5mMzQ5MDIzNjQ5NzIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUv
YXNtL3ZzeXNjYWxsLmgNCj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdnN5c2NhbGwuaA0K
PiBAQCAtMTQsMTIgKzE0LDExIEBAIGV4dGVybiB2b2lkIHNldF92c3lzY2FsbF9wZ3RhYmxlX3Vz
ZXJfYml0cyhwZ2RfdCAqcm9vdCk7DQo+ICAgKiBDYWxsZWQgb24gaW5zdHJ1Y3Rpb24gZmV0Y2gg
ZmF1bHQgaW4gdnN5c2NhbGwgcGFnZS4NCj4gICAqIFJldHVybnMgdHJ1ZSBpZiBoYW5kbGVkLg0K
PiAgICovDQo+IC1leHRlcm4gYm9vbCBlbXVsYXRlX3ZzeXNjYWxsKHVuc2lnbmVkIGxvbmcgZXJy
b3JfY29kZSwNCj4gLQkJCSAgICAgc3RydWN0IHB0X3JlZ3MgKnJlZ3MsIHVuc2lnbmVkIGxvbmcg
YWRkcmVzcyk7DQo+ICtib29sIGVtdWxhdGVfdnN5c2NhbGxfcGYodW5zaWduZWQgbG9uZyBlcnJv
cl9jb2RlLCBzdHJ1Y3QgcHRfcmVncyAqcmVncywgdW5zaWduZWQgbG9uZyBhZGRyZXNzKTsNCj4g
ICNlbHNlDQo+ICBzdGF0aWMgaW5saW5lIHZvaWQgbWFwX3ZzeXNjYWxsKHZvaWQpIHt9DQo+IC1z
dGF0aWMgaW5saW5lIGJvb2wgZW11bGF0ZV92c3lzY2FsbCh1bnNpZ25lZCBsb25nIGVycm9yX2Nv
ZGUsDQo+IC0JCQkJICAgIHN0cnVjdCBwdF9yZWdzICpyZWdzLCB1bnNpZ25lZCBsb25nIGFkZHJl
c3MpDQo+ICtzdGF0aWMgaW5saW5lIGJvb2wgZW11bGF0ZV92c3lzY2FsbF9wZih1bnNpZ25lZCBs
b25nIGVycm9yX2NvZGUsDQo+ICsJCQkJICAgICAgIHN0cnVjdCBwdF9yZWdzICpyZWdzLCB1bnNp
Z25lZCBsb25nIGFkZHJlc3MpDQo+ICB7DQo+ICAJcmV0dXJuIGZhbHNlOw0KPiAgfQ0KPiBkaWZm
IC0tZ2l0IGEvYXJjaC94ODYvbW0vZmF1bHQuYyBiL2FyY2gveDg2L21tL2ZhdWx0LmMNCj4gaW5k
ZXggOTk4YmQ4MDdmYzdiLi5mYmNjMmRhNzVmZDYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L21t
L2ZhdWx0LmMNCj4gKysrIGIvYXJjaC94ODYvbW0vZmF1bHQuYw0KPiBAQCAtMTMxNiw3ICsxMzE2
LDcgQEAgdm9pZCBkb191c2VyX2FkZHJfZmF1bHQoc3RydWN0IHB0X3JlZ3MgKnJlZ3MsDQo+ICAJ
ICogdG8gY29uc2lkZXIgdGhlIFBGX1BLIGJpdC4NCj4gIAkgKi8NCj4gIAlpZiAoaXNfdnN5c2Nh
bGxfdmFkZHIoYWRkcmVzcykpIHsNCj4gLQkJaWYgKGVtdWxhdGVfdnN5c2NhbGwoZXJyb3JfY29k
ZSwgcmVncywgYWRkcmVzcykpDQo+ICsJCWlmIChlbXVsYXRlX3ZzeXNjYWxsX3BmKGVycm9yX2Nv
ZGUsIHJlZ3MsIGFkZHJlc3MpKQ0KPiAgCQkJcmV0dXJuOw0KPiAgCX0NCj4gICNlbmRpZg0KDQo=

