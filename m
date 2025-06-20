Return-Path: <linux-efi+bounces-3890-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D520AE25EB
	for <lists+linux-efi@lfdr.de>; Sat, 21 Jun 2025 01:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0927A1BC032A
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 23:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23A723B637;
	Fri, 20 Jun 2025 23:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CPfOn6Za"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A42E56A;
	Fri, 20 Jun 2025 23:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461041; cv=fail; b=kKWdZda5MtUjrD87RID3QuL9NQhuH9T+4SI8lpEncS7PW3BWYFTjR+60ohrhjuy2yuBgzEZP5COHRvD6bc1i0jslyw+PqseKtm8n8nWVVQxV7PIoh4lRf6owfuSbkOMPu/9D66zRXscDa8T5uFryvfM4odv+qFHpJiXrs/mItN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461041; c=relaxed/simple;
	bh=UCdd6GF0yRHSG7MHW6NOShBvwbR2kOyKIUbR4wsqEe8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L781M8eLrY7Lm0tRRVJVbGk2cSuxF9GxnQMlChd7mnNPmNQBxd/rtDoYRQOP6nl105dhQHlTJT2nFkAGlosVLTzHPgCEwmEIjMTd5cPl3IZ2fBhqiIK+8hhQTUFl4cuRIyZaYHU9r9zEvHiPFxmHMAmu8X8XXA07E6QHJv4A9es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CPfOn6Za; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750461040; x=1781997040;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UCdd6GF0yRHSG7MHW6NOShBvwbR2kOyKIUbR4wsqEe8=;
  b=CPfOn6Zacd+ouqVw9D9vXN2CWshu8Z+2+YOunmET9Z2uv4FpzjxXTcsa
   3lxQH1kXqU/hurbC5/O1jSslY3je403Wq+ig41x+yuhsLlqUbf1rc//e0
   S8ZSp9vBC+o/vlPcanuPGOkS87Ps0e+txsoN0mhpf3E5Po7xmz6QOu3Te
   savfY9Cg6d5FlseGU/V5GhMXxjUoKcH0gxURSOpiN0kru/JtQGlwsY2be
   EnhZ4XkMmnkdCn3zvztV5GKchaesH5mpcJ4ICFhxZrtgyaN1/SaxDUJxQ
   RkknbsVAhXpewErnb4BXL7DQsW/gPLYnvsyxtZu4KqkTBIdtXdWlGXpwh
   Q==;
X-CSE-ConnectionGUID: dPKk7jsoTcq2Z7kfPqcM/w==
X-CSE-MsgGUID: tBkwyIj7To6S3wo4GsiI3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="56409220"
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="56409220"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 16:10:38 -0700
X-CSE-ConnectionGUID: ecT9U75xTu2F0qbVCiHRqA==
X-CSE-MsgGUID: Gexqxg0PQ+2J5+jIfivmTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="174641842"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 16:10:37 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 16:10:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 20 Jun 2025 16:10:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.86)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 16:10:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6rp4SbJ3pxQYTavPjJnN61gwWSIoXVUQM23MIAF67BdFvUaVJ6a+nAYVGxQ6Rq1MMJFh/+VNxn3FsqPIFxDwdoZV5Z8xwFakDWeJG/FsOH4583Dml5fMjuR77v9bHYW6YvsA29xUgtFsnBdtlS9VdXTQP6SBWyUMnedeZdME5FhAvIzv9wu35a/Axs38aRVF6toHEJnD7I0BqAvHrQTPQO9yCBtmqd7b1vdPdEzjcoYr7IroEK6my0nEHxa/apEQ/L7/vQc6GGhjzWM6bZX0tOp8wX9LUR+W//wqniaJdVa7N3gomYZ6OAtxNuWd8bFEOD5Dn+bFqudVaZX4bGD4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/eL8UlePeVWWhwyYCEJ2+5zhfqaE6juG9eYj9G1FRo=;
 b=Cr6wT8fPSkAWpYs50StUD3ZgAD77KwHKCicebnmKwGWz7EFZgHiXz3lxGHv9pyosJxbEYr7YapDAt7lqs9RJY5Q+rr/08UjShl096n+JLNt6At7Vy4LZ1/Q3D11HXLa4VvSdiKwC41MHRfbVOK8IZzyEkXWubu7SKrw3pQ9i/CEB29rRp1nWGr/Yya0ZLmEwhH9NkxYlHQA2nLRKkmXxkl77NJPcVFAwKy76fv0eRWok48l6+hvsg3Wi0lG3CxWpr6/NdWBLNZcYsMGPlN/AcwlNjvde3doy1uO8HhFMtFfK09LrjuUkOTMRFgPxun9aryfpJSfHUW0hV4//msQPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SA1PR11MB8319.namprd11.prod.outlook.com (2603:10b6:806:38c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 23:10:20 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%4]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 23:10:20 +0000
Message-ID: <eaae7338-df88-4fc5-953e-3e0584bd5380@intel.com>
Date: Fri, 20 Jun 2025 16:10:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 01/16] x86/cpu: Enumerate the LASS feature bits
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>
CC: Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>, "Pawan
 Gupta" <pawan.kumar.gupta@linux.intel.com>, Daniel Sneddon
	<daniel.sneddon@linux.intel.com>, Kai Huang <kai.huang@intel.com>, "Sandipan
 Das" <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Alexei Starovoitov <ast@kernel.org>, Hou Tao
	<houtao1@huawei.com>, Juergen Gross <jgross@suse.com>, Vegard Nossum
	<vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>, Eric Biggers
	<ebiggers@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Masami Hiramatsu
 (Google)" <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>, Yuntao Wang <ytcoode@gmail.com>,
	"Rasmus Villemoes" <linux@rasmusvillemoes.dk>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>, Changbin Du
	<changbin.du@huawei.com>, Huang Shijie <shijie@os.amperecomputing.com>,
	"Geert Uytterhoeven" <geert+renesas@glider.be>, Namhyung Kim
	<namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-mm@kvack.org>, Yian Chen
	<yian.chen@intel.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Peter
 Zijlstra <peterz@infradead.org>, "Ard Biesheuvel" <ardb@kernel.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, "Josh Poimboeuf" <jpoimboe@kernel.org>,
	Xiongwei Song <xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>, "Brijesh Singh"
	<brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, Tony Luck
	<tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
 <20250620135325.3300848-2-kirill.shutemov@linux.intel.com>
 <248e272c-79ec-4c11-a3a8-dff1de2147c0@intel.com>
 <adaf2d81-75b5-4f02-99ea-03ea0f1a5a96@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <adaf2d81-75b5-4f02-99ea-03ea0f1a5a96@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0334.namprd04.prod.outlook.com
 (2603:10b6:303:8a::9) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SA1PR11MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: de4fb062-f5ea-406d-85a1-08ddb04fa0e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmVseXpSSERxTjAwTHA4S2x4eEVYY0pBY2dmVVNzN1RoVjZpSUNubGV0UjJX?=
 =?utf-8?B?bWxSSTNNczlEK25TeGJXS2dtV2NOZGV1c1AyOGRtTll5VVppSnEzNExmbVVt?=
 =?utf-8?B?ZDZDcW55VS9heWhUQ3dkZzVKWCs0UENGMDFpdzJQeWpuSFFib3JoeDFpY1dH?=
 =?utf-8?B?ZzRxTFpTOC9OYXUxNFEvbHhDSkxsYVZPOVhFeTNGZ2JsS3psZU9kKzdnUUYw?=
 =?utf-8?B?ZXhuOU94Rys4TVhuUUo5dWpmTWRGaFMxKzdSa3kxbW9LU3J0cWgxTFZoWnEr?=
 =?utf-8?B?aGFRdXh6R1RWS05GZWtSMXJkczEza3pJSit1dFNsUzFFUkRJUzNNU1orRlow?=
 =?utf-8?B?UmsyRitTUnZjN1FjSXdUQzJ5ZVpJYTl0YmhZQXVLZit2L0ZwZ3dPMkpVVWxV?=
 =?utf-8?B?aU1Eenc5elptc1RPejJCa0J4dFVkZ0dwY3hOQXZLWHI5MG1DVGQvWDZXNzFq?=
 =?utf-8?B?eHBjdStrQmM5Y1dtUnE3RWhPMFlyWlkrZ2pmZkdGZEd4akFpcm12WjZGSDBJ?=
 =?utf-8?B?ay9ZU2ZPYXNhRXo2RFdMR0lyT1VCQ01FQWw2UTVRa2VHNU9DUUI1TlZvNEh3?=
 =?utf-8?B?OS9CVlplNTNyZ2prWUpCTmxZNmNNaVd6SzA3cU1kTzRxMFpaSEVnZklTRjgw?=
 =?utf-8?B?UTBvRTl2SUZxWGtaVjN5dWlEZWR4bXJLSGdRWktHNXdMYjhGKzB4WldoZ1NL?=
 =?utf-8?B?bDZsTDJmZnUzRHovSGpFV3liVDUzMzQxSXVLZXJaZFdZNE5YTnVob09XZ2xJ?=
 =?utf-8?B?d0VucGxrTkVjdkdtem1NSGdSdnIyUTlWb2ZuTlVJaFVJczRMRHpYNzJFUHQ3?=
 =?utf-8?B?RE83eGhkU1NrTVpiWS9zTmZVNDhFVzdqRjRFVzI0YnVOWEYxK3Nhd1ltdHdV?=
 =?utf-8?B?VkxrZWVKZVJYdjhGUC9pTW5ld0NNbmY4cmFEOXVLVGlDWDNrbTN0c3c4UmJI?=
 =?utf-8?B?ZHZiaXAwMFJkQi9RY1p0UkVtV2IrbzFDdmZzViszZXRCUThiVHArcjd2dEV5?=
 =?utf-8?B?UkM4QmUvNldIYlZkY1kyVW1kMXdrc0lMWG9FTVA3R2lhY3dZaDV5aVFJVUJN?=
 =?utf-8?B?YlNtdUl5NjRob1A2NkNIK1dDbFZ2UmsyOEJJZ3g4MHIrRlNqTjB2Ym9yNUpW?=
 =?utf-8?B?V0RKeHdaSmdtcVFHVlFMVkZrNVFWdkpOUmtPU0VIRWJHaTZrWWc1MkVvR1Ri?=
 =?utf-8?B?YU15VCtMWUVlSFZnOVU5VUhhV3hRdGFyKy9VM0lBTmZsMWpialI1Z1Rnc1cy?=
 =?utf-8?B?S3ZpOFFEbjlDdGZOWmR0ZnI1T0dhWHkwb0IySUpwMVVHU09NY3BzNVJNY2Ns?=
 =?utf-8?B?QjBJbW5kQjRZUEw3UWlaQmM3eVdNamRrbUphVDdBVlppMkxEdkM1Zm40dEVq?=
 =?utf-8?B?cjV4amIvMUhXMFBaVW9EcUJuTGxYKzVpdmJtb2VzYWRaQmNNQ3QwSU16Y2pH?=
 =?utf-8?B?VWpLb2VJT3ZPbTJ5amxvbUtiYllmak9OZkgwYXAraUlLbTVJaGZhZVhUaUlk?=
 =?utf-8?B?bzhpUFVsWlZFRjRJSXZwcytNbmV1UzNEekxmZitKSmljR2o5N240cVdqdG1r?=
 =?utf-8?B?K0liakxDR0E5dm5GZXN0SWZsS2t6dGN5aEZ6M3dGTkttTUZmUkFzRVlRU3dQ?=
 =?utf-8?B?MUpra3I0VDJOOUpxQUNLa0lFQjZwTi9rd3g2MTdLVUc4QUtYUGk3NjBEc2Nk?=
 =?utf-8?B?eExJU0twNksveVpmQnhqZllldTk0S0V0Tkl3eURBNVZaa3psOUQ4UXd6NGp6?=
 =?utf-8?B?aW5DNFVVNXUrZzByMk43c1pIdllUSGN0ZVBBOHZyMHpnOTZJZ1MrTWRHNUNi?=
 =?utf-8?B?SjNOQktpMzFkRXNCQWpnSTNNQ1dyYUhvMUo0WUxiamZjUW5PaUlIK0hsWHYz?=
 =?utf-8?B?cmRSZVhpRXdScllTamxTZkNxUE5kVkFTaEFLbk10QzdtY2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NCtBeHNvRXh0RDA4WmIvK05JWjVSSTVJam9BTkMxZ2hUSnc3MVhrSTQyV2Fs?=
 =?utf-8?B?dStVMVdmeXVPRWlPc0pHajVDam91VktvcUovWHZSODd0SGJUZnlYbzl0cHVF?=
 =?utf-8?B?Tk9jbHZURlZ4WlJqVVVZdkdaZXY3aGhEd2xsMWlMOWFteUx1QVVsWE1zL1FG?=
 =?utf-8?B?Vm5YZy91TUlFRFZDNDVWRjh1K1V2bXF0cGYwclFCMWM4MGtxM1dFSHF1R2tN?=
 =?utf-8?B?YXhXZXFXQ2I3dSsyKzZZdWgxbTJ6T01qeGZaM2xQcldwTU01V0hZYk5mcm1F?=
 =?utf-8?B?VUxYbEQyaE9ibjVMY3c1bWRwZGtkajRWcjlwbXFEOFhhcmJRenNVSzdybXl4?=
 =?utf-8?B?OTR5MkkwWWdIbGxCNEtxeUR3RmtDd3M5Uy9lNDcvUWVNYVBWNWNLR00wNHBp?=
 =?utf-8?B?NDUvNldFSlhrbUgzcGdLVzl3L1V4SS9QekRjNnY1RXJNVElvQm1YeGZUTnNW?=
 =?utf-8?B?eEI0bU5udVBSOFVmc3NjSjZ4ejd4YnZSc21RanBVd0xWYlIyRHd6N3MydjdC?=
 =?utf-8?B?WDQ3QjZpelo3QWp0NzExQjNPYkpsQzllQjZzOWd6NEd4MTlxSm9wajRoT0dN?=
 =?utf-8?B?SFVSMU9rMnN0M2EyZjRsSkVzT29EaWNSdUhzZzNycW1wMHhXMU4wUTlqekJJ?=
 =?utf-8?B?SkZZY0VuNzlNbEY4VjhtYUw4ZzM1WkpDdEdNRW1VdjBIZEs0cDRrWHlRdGZX?=
 =?utf-8?B?eVRHQ0pPeXd2c0dRQkF1d0VjMmgyazc2SEJaN3BBSVhUR3VGRStqNFB4QzUr?=
 =?utf-8?B?M2p6Z01YYjlRSm4rR0dBNS9BaklUa0hMM2NBbHpldmFxRDBrS1hpTzAvVWUr?=
 =?utf-8?B?TFlZT3poWnFLdWJyV0hKZTdpb21mbUhNOWVRME02NXBYQmRmQnVkRE9BVmtj?=
 =?utf-8?B?WVNrR3pJcVArZjJKTCtPclllUkF0L2RQVnE4SVNXQXBxOU81WE1QZEJwQ0FK?=
 =?utf-8?B?Vmh4R1FhamdGVGhXWXZQRzVxQ0JFWXVBMDl5MmhEMlYzUHV0Q1Y4RllnMXVD?=
 =?utf-8?B?VDF0QzVYaUtQcGU4ZnE3K09OK0hWSHlGYmNGVUZaOHFuUEpiUUgzajFlbWg2?=
 =?utf-8?B?UHVvOVJIeElmVnZ0L2Q2eUY2Yk94OEhQUVpzb2VQT0QrNWNCRXQ0Y2l4MkRa?=
 =?utf-8?B?dkcrdVZHUkhTUzMza2ZxMHEvSXU5WVgxZmlZWTg4eW9MODB1U0ZQRXZxKzhp?=
 =?utf-8?B?dE5xZTJHT2NySnNGbU5vZlMrQnVEUHJJOEM3dlp3SVZGd3J5K05ZemJHNHFU?=
 =?utf-8?B?RkUzTlQ2V3hZamwzN3NoYVR4Z3hOeHBHL3B4M1NFTjMvUmZkL0hFSTlCaElU?=
 =?utf-8?B?K09QYVB5MmJlUHYzcHk0VG4xbFhLd2VEUllzSWNDVko1RnpoWWsvUWlWeHJU?=
 =?utf-8?B?YkozMGlCbzJ0MDJydHpHbCtUbU94czVCTFM1T2JuUmtaL0R6dGdEREw2Sm41?=
 =?utf-8?B?VkJhSzVZRWx3N0lRZ3g4N0kvK0hnbnBhQW1zcnorb2EwSmVYc2o0Rkh1TUpY?=
 =?utf-8?B?S1BLUmxWM2p3ODFkUjBTTUs3ZG1xeUFBMWV4dWNYaDVoaENGWXo4UUhNZ2Fo?=
 =?utf-8?B?ajI5OXdJVzc0S2I0L2ppM0tzRlhveVNweHFBd3RzQXMvVThOOGtHRXhOTEtj?=
 =?utf-8?B?aEJHUDNhd00xNCtjWTU3b2FWbTRnQ0pVaXZmcW9ZLzVuTVl4WjZqRlNrR1Er?=
 =?utf-8?B?Vkl3c0FoY1VBZXpRUVlDRDBZRmt3aHlNQ3FLMWJxalFrc0EyUUhOY0tKM0sr?=
 =?utf-8?B?TlVKK3dmV3FUL3NiWWRxSmdrWW9uR2plL0RBY21zQmxhdDZ1TE1RdndxY0tN?=
 =?utf-8?B?OHd3aGU3T0tnRUc3eUo0STFtT0l4WEg5bVF0TXZ6cGhGK0pGRjJlS0VURjgw?=
 =?utf-8?B?bHcyb2d4TlJxWTVYUjZmdHhHSE5Hc1BtRlk0eEMvMWtVVEMrdXlrS1V0bkNa?=
 =?utf-8?B?TTBlN3paL1I2MVZEdXFuY3htUjlON0NWaWNmZ01JeVptSnpZV1BZY0dpR2Y5?=
 =?utf-8?B?UUlYSmpSaUltVWdtRUpFRFhNdDBoelM4YmZxa0xHTWRzdXg2bXc5eElNZlow?=
 =?utf-8?B?WTJFbEh5N1hUYVcwQnQ5T0R3cFphTVhlN2RWTzBYRldUZ2I4UnBKYlkxQ3ll?=
 =?utf-8?Q?B1oJYNjOY2PQs7HXPDgMAfXPw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de4fb062-f5ea-406d-85a1-08ddb04fa0e7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 23:10:20.6482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GaM8LjGCdwpKvmdJV3Rf9VvY58XfKJMFQhaYXXLs10dycfdbe4dHFCpERWNk3/dKsSJHgIfD6rgg7mGM6jvoWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8319
X-OriginatorOrg: intel.com

On 6/20/2025 11:24 AM, Dave Hansen wrote:
> On 6/20/25 11:14, Sohil Mehta wrote:
>> @Dave Hansen, you had suggested separating out the SMAP/LASS AC toggle
>> functions. But, the difference in usage between both of them seems very
>> subtle. Could this be easily misused?
> 
> Logically there are two completely different things:
> 
> 	1. Touching userspace
> 	2. Touching the lower half of the address space
> 
> If it's only userspace in the lower half of the address space, then
> there's no controversy. But the problem obviously occurs when you want
> to touch kernel mappings in the lower half of the address space.
> 

Makes sense. If we decide to go this way, we should capture some of this
thinking into the kernel comments. I find the current wording very
ambiguous.

> I want to preserve the "stac/clas" meaning as just "touch userspace".
> 
> The new functions should be for "touch the lower half of the address
> space" alone. Maybe it should be:
> 
> 	lass_disable_enforcement()
> 	lass_enable_enforcement()
> 
> The only downside of not having stac/clac in the names is that it's not
> obvious that they have an impact on SMAP because they're named to be
> LASS-only. 

Yeah, the reverse is also true, where the SMAP specific clac()/stac()
toggle LASS enforcement :)


