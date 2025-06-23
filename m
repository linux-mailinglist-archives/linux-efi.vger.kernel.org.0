Return-Path: <linux-efi+bounces-3918-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF615AE4AF4
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 18:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8F03B54D1
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 16:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305D3275B0E;
	Mon, 23 Jun 2025 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jrR+sVcn"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C6AF4F1;
	Mon, 23 Jun 2025 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695938; cv=fail; b=IJyoat7eaxpy+MZ7RZVuh1KTqIK8PLLod2pelhQplLghMUhG1k1TzV/2dP1FDbIrHK8VqVq1sjOqeMx8CM9VpsFmJdI2WFkobDhl8Z5cU/1az/wwoY6FuO4r4ZqC3Peh0MZkESRcBkkJm3+0mHOj1SYC7ar7WYh+BntfFrJxp78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695938; c=relaxed/simple;
	bh=41UIpM++tM83/JxOcaXJdq6ayy0+7XnHr5l6NSakQU0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=paGzv0ZFvcnvB+ui3BB/3vR9V0ThyumgoW1WU4/zLpV4ak4d9GyUz0PFoQOva/TLm3+Nkh9Tg4m6AiDn8S+xq384XF6CJ3r28aSox4356ujQmsYZ/uYGhg8MDLAJJ8qL+E03OqHo7IveF0goJKuv7o6fI+xMnj3/V+gdwzCRB/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jrR+sVcn; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750695936; x=1782231936;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=41UIpM++tM83/JxOcaXJdq6ayy0+7XnHr5l6NSakQU0=;
  b=jrR+sVcnI+jmRcKhRs7qb4H9Z0nOPxyvhC56XNfgBW457GUYrApUCR4H
   PFOF4ZSM1ODeYtSFd/gpIaTpESgdJd32HmYpbmW60I+5lVobJfaWBvuHj
   n0fNRoZnpcJ+QJ9uZr4537Cxh1G5ya13ektccCaHfAjsz0SbH36c50Oqb
   uZAz78KnexZiAN1GD4tBLZhHiS18DZHLSdOL58PQR4SqqvgvCekiXyu1z
   r4nEtnm5HwcMEZKcmu/nGtOBSnUNWfsrosfiBOrQ5siIhGsQf81s2aU/K
   +LtZ8eysYCWm8vc8z2ps7sNSEJe0beYvmIi/JhxP6vKBsqWjyiD8Rc3qo
   g==;
X-CSE-ConnectionGUID: K7dGfSVzToO1mv31ALmKPA==
X-CSE-MsgGUID: TKGr+Up+QYCrJI6+Q5BIvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52138784"
X-IronPort-AV: E=Sophos;i="6.16,259,1744095600"; 
   d="scan'208";a="52138784"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 09:25:31 -0700
X-CSE-ConnectionGUID: +7OcvpZ2Qz+kTZAmGaUgIQ==
X-CSE-MsgGUID: o1wF/0GWSAGZ29ZkSUjo0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,259,1744095600"; 
   d="scan'208";a="152341391"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 09:25:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 09:25:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 09:25:28 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.89)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 09:25:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3CpeqQ4A+W8yhg9bE3jxdkY8GjDB57855hamYAJ08GL1LtohSk7ANkuQrUz9Nu8FZZcoBbn4xg7nFydoYjHpTlfQIhFgwdur//fTo/Fi8T2XOwIC5c495Fp0gZ+8yDoffwvRtvVOQ7VnZj9xJcbus2K5NublG2ohRfBtr0IapICnlrx6o6F3WiKk/x+LdI4we9Xm1PyziBkfHOBoNRunzXqGVd2WP/rpoz/yO/7/zk4khJaLLOK/EfSSIN55WiGNSmW2ggKggs0G1a0lZPfXhs2ItfVe+mrFLrYnV2kBLW9u/xIQQwz1Nme2NDBo7E2H5ma4icvRS+uuaEg0KXp7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41UIpM++tM83/JxOcaXJdq6ayy0+7XnHr5l6NSakQU0=;
 b=K5+pq7N7XFa4Z+WN6VVfbjomt1X/Vfbde2KkdLKgikMD8U6CZSOAoKgzlKj3vItdoBX2NKqCoguHyfngZE13e7ZED9CW/SCzQjGaGF85kms/+3W83Wehw7gRNlDtjeQFTdQinyaZ9CzV6uu3ESd3I3nqjwHRZfq/SNzeRVJd6fNEluKPeLi7Y/z/+HjA7hJrRxvOG8XrdaaeGfobezjARiAHcJZKaMV68xsySGzU5UflBmbzsWqfl2HQelQ0e0TwMvPi+HkHS1anX9z404Z+4qSFYVw5tz5VvLQeHf5/jH5StT+pRU923mrgV+c4fWfHvdnJzzD34L9qrMBU3NtF7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY5PR11MB6485.namprd11.prod.outlook.com (2603:10b6:930:33::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 16:25:24 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 16:25:23 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>
CC: Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>, "Pawan
 Gupta" <pawan.kumar.gupta@linux.intel.com>, Daniel Sneddon
	<daniel.sneddon@linux.intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	Sandipan Das <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Alexei Starovoitov
	<ast@kernel.org>, Hou Tao <houtao1@huawei.com>, Juergen Gross
	<jgross@suse.com>, Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook
	<kees@kernel.org>, Eric Biggers <ebiggers@google.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>,
	Changbin Du <changbin.du@huawei.com>, Huang Shijie
	<shijie@os.amperecomputing.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Namhyung Kim <namhyung@kernel.org>, "Arnaldo
 Carvalho de Melo" <acme@redhat.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "Yian
 Chen" <yian.chen@intel.com>, Andy Lutomirski <luto@kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>, "Li,
 Xin3" <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, "Brijesh
 Singh" <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, "Alexey
 Kardashevskiy" <aik@amd.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>
Subject: RE: [PATCHv6 01/16] x86/cpu: Enumerate the LASS feature bits
Thread-Topic: [PATCHv6 01/16] x86/cpu: Enumerate the LASS feature bits
Thread-Index: AQHb4erCSBDI66dtY0W/I0p+M+8Xt7QMWp4AgAACu4CABJQ7QA==
Date: Mon, 23 Jun 2025 16:25:23 +0000
Message-ID: <SJ1PR11MB6083AE2EF85FB5D2FE39D4F0FC79A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
 <20250620135325.3300848-2-kirill.shutemov@linux.intel.com>
 <248e272c-79ec-4c11-a3a8-dff1de2147c0@intel.com>
 <adaf2d81-75b5-4f02-99ea-03ea0f1a5a96@intel.com>
In-Reply-To: <adaf2d81-75b5-4f02-99ea-03ea0f1a5a96@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY5PR11MB6485:EE_
x-ms-office365-filtering-correlation-id: 561228f3-f2a3-4b01-577f-08ddb2728e37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aHhJUDZwS3dSKzc2Q1l1ZUxreDJDck9nTFdxYTlRM3FUVzAyU1ZHU1V3TENa?=
 =?utf-8?B?Uk5GS3ROU0ozRnJiUlhlK3BkU2RjU2hWV3FZSWVzbGRQWXRrRzZRd0NDeVpt?=
 =?utf-8?B?SjRNZTNNT28zcTBPRW1td2JJSEdITWFLbVoxTDd6UStHQzJha3hSRXZsOVlT?=
 =?utf-8?B?bStyby9UWkdsLzVGenNOMEp1L0h5UVNFL0VZTUVZaFZGVC9nNndxTzZwTzdM?=
 =?utf-8?B?WDUyeEltN1FlQW1lb0gvMytFTGhQeElXS1o2L1l2VjNxWnFMS2ZEMUFKRXN5?=
 =?utf-8?B?QTIvQlNtZEJPSEV4ZUlBK3AyR1c1NHRNVnplR3N6dldQS0lVK1VpdEdIN3J6?=
 =?utf-8?B?OHZtRStqbFZ5QiswQjNFV2FDT25CYVIwTEZVVkdkK3FyemJCRzhEQ0hsNE95?=
 =?utf-8?B?dEV1UU9NclltajFhNTNkbWRmRFdKalZQOXhwYmVHTzViRlRzQ3lwRk0xd2Vs?=
 =?utf-8?B?MGNWUHpxTjl5c0dyKytXMXRkR1dpRnpFRFRvaFhqbnJuYWJxWTBrUERLRGhh?=
 =?utf-8?B?eWxQdlpYajF2UXdES3pTWjRNdFlBODFwVVdVOVJKelk5ZFFiUnRQaVpjVUUw?=
 =?utf-8?B?MTBVd3JucmFmdlR3MjMxcFhaN0FSNC9TcExxcmNrUDcvem5SS1FLMStiT1FQ?=
 =?utf-8?B?ZzF5ZUk5QStIYnJBcW90Mjl4eXNxVUd0NlluWFFxZnVKVVNkSEtVdWRxd1p0?=
 =?utf-8?B?MDN6ZGhsUHpYVW40SG4vY2hKVSt6OFArVm00bVJuQW5jWFpEOWZMbFA5YmlH?=
 =?utf-8?B?RHpPbXBZeUFXc0tzUmJyN0g2Q2lrOTJKcVBCSVRwdmxiSEUzUWlQUGZ4cE9q?=
 =?utf-8?B?MVRDUkk0OHBsYmpuN2JEYjFYb050UldJZXhYMy8wWGU4cFhsVjdmZ2xMempn?=
 =?utf-8?B?a09LZ0t6QmdkQndqVVRrMjIraWZxUm1tcitiNmhVMnZFTVBqVUdwSTNaRUQv?=
 =?utf-8?B?NmNPR0NRSGlmRWZXTHh6TVBhUSs3d0xHcFJieDN5M2ZzLzA2RGY4Mm5jNVlp?=
 =?utf-8?B?UzhBU3M0cWRsK29JNTVrdGJ6UlJOWEtHdnpzaTBhdmMzWFlLRUUzUlVkZkxV?=
 =?utf-8?B?bzErZ09tZFNPWHNiUjNjd3ZlSEVMNk9EVlFjamd1RnVxbElvK3NCa2xXWnBI?=
 =?utf-8?B?bnB4eXdBOG1qd01QK1RHSFJpTnV4RmhKcndqdUcwRHpScHZGdU1XZnljUUNv?=
 =?utf-8?B?cForOVJacTB3cmplTzBjN3hqd1FRUnd6cEpTcGZlblZXamowUUtWM0pYd0Fv?=
 =?utf-8?B?bHpxb0VlSGduNUNybjBaVm9YMGZvY2xYM0xjMU1IUGZONXJaMloyNUxBRGlF?=
 =?utf-8?B?QkZ3NmY0K3lqdE8yV1BWRGNRaDRxWjJ3eGdkZmlKaURob3FZa0E0MTlpckRl?=
 =?utf-8?B?cld6T3BlT2R6KzROZFk4bncwZHNpMVA4K0h3RW9rc2MzZkdVMnI2VUdaWVdU?=
 =?utf-8?B?OFB6UzFjQUdJNXppYkVtZ0ZjNXpRVzlidngvb2pPeWFvaitKTWIzaTB5T2FC?=
 =?utf-8?B?bXE2K0VLMFZjaVZaQncrSURscVdwUGo5cTU2RFRONzdJQ1ZHQWdDeWxIeE1m?=
 =?utf-8?B?Zll5Mk8yVFpkTHEwYWZ4d3lYL0cwdTJDOHFBUDBsL0wrWVd2Y1ptY0ZmN0hm?=
 =?utf-8?B?bE9odzRWVGwrR1A2eGhHM20vY2lBZk1BTGQra2F2U2llRm9ZUVU4THNrWkdW?=
 =?utf-8?B?T0RKZFpPdHk3OURFQTBCK1UyZ2tuMzYvM1l2WlY2blpwK1p0T1dXc08xRTBx?=
 =?utf-8?B?eFNNRERXN2ZHQ2lLS0tPZ2l3UmxxbWdPcUpqVUNUOUJOQ1FRdjNnUXJmUWFX?=
 =?utf-8?B?QmwrK0xMSmFZZElFLzlSSW1hZnJ1eUc2bXZXUGxtb2RjY052eEJGZkVjZ3ZE?=
 =?utf-8?B?RGpGMTdTVnNkdUZVUGw2YWUxbXJXQmlEdTNHWUNmS29MWnZwL2c3T05jaEYy?=
 =?utf-8?B?MXRxaFpHQ3VLNExSbTRaVitJRDRtT3htQmIzeUtJbmxNS011QmNpQ3ozZG1G?=
 =?utf-8?B?dXRZeW95aHN3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0NQeTh1ajllbGkvYXF4Y0dMMzJrblpSL0l3bml2ZG8zSkppRENxbkQrclhK?=
 =?utf-8?B?SzhPaVUvemE1SXoxVGh2eEJCajZSdmp5T3V6S3hWNS9pZWw3WXM5M0VHQ0VU?=
 =?utf-8?B?bC90ZWJNd0FBczc0c1c4d3VTUXVrRDh1ZmkxeEpEYjFJZmh3UzZBQ0loN0NY?=
 =?utf-8?B?bGtQT0ppZHZQY1JtWWNyVGdzOEdqa2k5Qjl4bzMzTUZiNkhQQllQTzI1eG05?=
 =?utf-8?B?bGF3eVM3VmlRVy8zZkZzK0xrVXQ1RU1MOE50alFFSzk1RTc0ZE9sNVp6bmVF?=
 =?utf-8?B?djlwbnVIS1JkSTBraFdyRE4wbTJTQ3BWN2NlcDk3bFJoTXV1ZlNIRWVjOXVV?=
 =?utf-8?B?Z25ZNnZHcGVqWi8zbUZocDFPYnp3c0RYenJVZ0JWQkJYZ0JQT1JPTlNwSDNi?=
 =?utf-8?B?OExURXphekhhNG9JNVYrWHhVTE1EQ3gzNWNXcVFyQ3ZRRTZwcTRBb2gzYUJk?=
 =?utf-8?B?aDFUR1VwWUdUNFpGWWlPYXZLc0ZkUHFFT3NzSGJ6REl4SkE0aWx3aHByeFRD?=
 =?utf-8?B?ZTkwdkFTblVLdVFWK3RsVjVmQnVKc2tEdzVpL2lxOUVSeFZHVk5xZWY4bjY2?=
 =?utf-8?B?TVEwTFVhUmkrU3BuNUFwWmI1bG5ncXBzdTJleHhqK05aMnE4OXBXVWdvMjh5?=
 =?utf-8?B?dlViU2paWU5ZU3VJdmRVeVE4QXRtRkllaVB6bXVvdmROWFV2NXE3UVdnb29z?=
 =?utf-8?B?Y2lHN3E5ajZXRGNCdG5WN2d6UVNCZHNsVEo2MHZTL3N1L3BDZGhBdjkrTUlT?=
 =?utf-8?B?WTMwc083WUNvRXplVVZmTGFONlFNdGtGTldMUEFYa2NEVTM4eDRPWXhMdEF4?=
 =?utf-8?B?K1dSL1NzbXp6K0c3YjgyeTlTZlVtMmc0LzF3djd6L05DMllReko5YXdsMjFs?=
 =?utf-8?B?UzJPb3Nia1FFQ1N1QXlacmR6VkkyeXpJMHF1d05maThUdFNBQTAwVEpLbzRo?=
 =?utf-8?B?K1JFVlBINlREeWRJbk5KZWV5MWpIQW1JTCt1UnpXemV3V2srNHNoQlhDNm1s?=
 =?utf-8?B?a3JDTEZ4eXlyNnFPaDVIWTQ1dWd4TWdxYTBGM1lwMUNqVkFsTjhLYmJnK1dH?=
 =?utf-8?B?N2ZNbW5vbllCcS9oY3dBR0lCdlNiUlU4blMxdTFsWDJ3UU9WWitHajBJcWow?=
 =?utf-8?B?MWUyb0xlbng0LzdkVmVJSExwM2dVZE44dGFEYnp5VnJndkJqU2xDRjdTc0R4?=
 =?utf-8?B?VE1WY21jZlVhZy8yaTJvYkd6S0tPK0Q0MlQ3Q0dwRVpEcU41bE95ci9RUC82?=
 =?utf-8?B?a253bTdicjRZYkp2dXhiYk9WK2p3S2xZZmY4M0JpQktqUHJRZ1dQZFBlSGJB?=
 =?utf-8?B?ajZtc1R3WGFxbnVBaHNyNXluNUExcXR1RW13dElINUFBcVRQcDY2ZG9kYStk?=
 =?utf-8?B?L2VVWDJac0RCQVR5cTlNa3FySGp3VUJYMVFTaWJYZFV4dmxNcVhQRDlVeUdT?=
 =?utf-8?B?Rm9IeGN2MFhFTE9LUjBIUWQ4eDlaMUxUcEFIM2NQQytEM2M3cmMrOGtkUnFP?=
 =?utf-8?B?T04yWngveXYyaXBYQU5Qb3l6aHhxRXN0VUxrSUkwQVYrQVdHUGgyRjd4L25p?=
 =?utf-8?B?c3g5Ni95WDJzYUdmWVNFeWpEV2Vib3VkdFFOaEYxeEdMMG5QcXZGY1gzSW9G?=
 =?utf-8?B?KzI1TXV0SmpFRU5mZVpNcVVVcDRtbHBYdTBxZUdZZldqeis3U3dxRVZPa1F0?=
 =?utf-8?B?YkFId1llWHhYRURFL3IvVWc0andlSHRJUHZOaGVwa0ZuTDQ5ZG9ob1dodElY?=
 =?utf-8?B?Ym9ZNktyU05yZW9BbHhnK0U2WEFLOGovOFcrOWNxMXF6QmxxREJBSHlGVnJS?=
 =?utf-8?B?TkhyUElhZ0dMSnBLNitGUHliTWNWMDlkYVVTaXhjclp3eHFvYTQ1Z0IveFJv?=
 =?utf-8?B?bGFtUUhrd0l0UFpIdE5qbFZsNmdWdVNwV1JsNUU0ak84Z2kvSTZaSUVkV1Ra?=
 =?utf-8?B?YlIySDVWeGE2d3ByTGVWZXBZNjIvNWhjeFRnMzFrR0k1OWRhNjA5VVN5V0pm?=
 =?utf-8?B?U0dPZkNlMFVOZGxhS3VicExzNm9DVkJIcWttOEZzcHkyVVZiOHJLS0pRcXk2?=
 =?utf-8?B?VGN1SmNXUGdUSkNUTnFDQWwweFNDVktFTjk0elA2ZjdGRnA5TTFkaUo1azg3?=
 =?utf-8?Q?1WHh3kifihOqCqlU6rhK+T5uz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561228f3-f2a3-4b01-577f-08ddb2728e37
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 16:25:23.8173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ug7/id1vMz0FQvuLvmD86d/K7FpAmnPmsi2ePMLnt4SsURZ+YjySmWWwwtoFETZFhBnoR5rqRuTDB/djLoN6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6485
X-OriginatorOrg: intel.com

PiA+IGZ1bmN0aW9ucy4gQnV0LCB0aGUgZGlmZmVyZW5jZSBpbiB1c2FnZSBiZXR3ZWVuIGJvdGgg
b2YgdGhlbSBzZWVtcyB2ZXJ5DQo+ID4gc3VidGxlLiBDb3VsZCB0aGlzIGJlIGVhc2lseSBtaXN1
c2VkPw0KPg0KPiBMb2dpY2FsbHkgdGhlcmUgYXJlIHR3byBjb21wbGV0ZWx5IGRpZmZlcmVudCB0
aGluZ3M6DQo+DQo+ICAgICAgIDEuIFRvdWNoaW5nIHVzZXJzcGFjZQ0KPiAgICAgICAyLiBUb3Vj
aGluZyB0aGUgbG93ZXIgaGFsZiBvZiB0aGUgYWRkcmVzcyBzcGFjZQ0KPg0KPiBJZiBpdCdzIG9u
bHkgdXNlcnNwYWNlIGluIHRoZSBsb3dlciBoYWxmIG9mIHRoZSBhZGRyZXNzIHNwYWNlLCB0aGVu
DQo+IHRoZXJlJ3Mgbm8gY29udHJvdmVyc3kuIEJ1dCB0aGUgcHJvYmxlbSBvYnZpb3VzbHkgb2Nj
dXJzIHdoZW4geW91IHdhbnQNCj4gdG8gdG91Y2gga2VybmVsIG1hcHBpbmdzIGluIHRoZSBsb3dl
ciBoYWxmIG9mIHRoZSBhZGRyZXNzIHNwYWNlLg0KDQpXaHkgZG9lcyB0aGUga2VybmVsIGNyZWF0
ZSB0aGUgbWFwcGluZ3MgdG8gcG9rZSBrZXJuZWwgdGV4dA0KZm9yIEFMVEVSTkFUSVZFIHBhdGNo
aW5nIGluIHRoZSBsb3dlciBoYWxmIG9mIHRoZSBhZGRyZXNzIHNwYWNlPw0KDQpJbnN0ZWFkIG9m
IHNwZWNpYWwgIndlIHJlYWxseSB0byB3YW50IHRvIGFjY2VzcyB0aGUgbG93ZXIgYWRkcmVzc2Vz
Ig0KY29kZSwgd291bGRuJ3QgaXQgYmUgZWFzaWVyIHRvIG1hcCB0aGUgInBva2UiIHZpcnR1YWwg
YWRkcmVzc2VzIGluIG5vcm1hbA0Ka2VybmVsIHVwcGVyLWhhbGYgc3BhY2U/DQoNCi1Ub255DQo=

