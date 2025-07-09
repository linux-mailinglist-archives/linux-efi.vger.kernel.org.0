Return-Path: <linux-efi+bounces-4199-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F91AFDD94
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 04:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1B31896FB7
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 02:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B300B1C32FF;
	Wed,  9 Jul 2025 02:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lrfOdlQK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05052EC4;
	Wed,  9 Jul 2025 02:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752028871; cv=fail; b=t08OuDsPInlwCeeFzh+qaveHGMXzAYhpQnjyl8uXEwbsANPM6/wgujZWe5eYwblgdTFaWT3UeJVnJpfYoKgQi4l7b79avH+oCAPMHVAAhAQgzhqjMhlwp8df+las4GwFU1WV1eP/QF/e5VcPUT/b7NU2b9LNvJYm1vnGDkhBGt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752028871; c=relaxed/simple;
	bh=ZOhbRFE6Dhdlp0oa4bybWZ6+ukO0R9pdEaFntFJqfF4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cmpY/eBcny1TuAe6SQ6hQy4IJOW/kS6zYvlDMGxOwI6kE+JZ593ectH661SKgIkR5ZIuucDVetDG42dhEwzTnDhmdfK3zXl7SeX/TxkfNwfY68nY/mksGx0OKr0h4j9dc1BUD5aJW9hgS39Qi0CVtR+dYtGm2/U8IO5ZoiJKQyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lrfOdlQK; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752028870; x=1783564870;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZOhbRFE6Dhdlp0oa4bybWZ6+ukO0R9pdEaFntFJqfF4=;
  b=lrfOdlQKd3latM6i+qebfBQmSzFT2IKk3dxQp5nrLOYwF+6wHVEjU2ES
   /X9nkzMP5QQtv8CckE4VcXdGygpzEYYGSJlrTAagepTHQyPRC31PdGq+9
   rJrD66/JrxXIa1XA7YmKp8tjS2Qc8t6+/CfgpnVo65J8eNt6bQqCJMCh9
   S6nCkMQZjfarpjhRh14aby+ufi24KXUOcyPVWr2DO5ZZpOACxx5fTDiQj
   kazvyt/McJK70IQHcH0sm9oUWEnr486f/RE89o+BVByYZ6SvMhif/osDh
   pv+yOMy60jt3K3SHsVZCitzBmsA7kX0LgyJl37NdXrZBRgMAZrhsJhXz/
   A==;
X-CSE-ConnectionGUID: 1YVfGHEQQ62W87ksr7AVtQ==
X-CSE-MsgGUID: eLennuJlT16WbMiH1sbMlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="64863263"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="64863263"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 19:41:09 -0700
X-CSE-ConnectionGUID: K+uWsFadRlCLn4xd8j6/uQ==
X-CSE-MsgGUID: ni4WnarTRr6r3tWnFPmzXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155771015"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 19:41:09 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 19:41:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 19:41:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 19:41:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtMdjV5Xd8IMP+CWNkNf39sSo+IHRUBhUjPPhvsoc9pITyLLe8pSkylaZF86Mq73+booWNSLeF2luE4dJLLOB0eEuhDf4ZQh6OvhaQLvPejXFf1ysRUBkDRnd0qgMVOeo8k8LJ26O92262ZXxsOv1z52Z7KFrHkCsH4De0zYQbXH08vjOnDnqLVMC6NZiHoMmkQgkV4La2ap4Ouqdy7JkaofImlMAcA77YRi16W+iCpguRgZceU7z0+qx4SipRhunIguteaFf2s78nPeyotVSL2BoN7s8GVdXRZmjwiynuE14G3e+HjbIFalJZnIwjGxWbFy7W5GI6MD034r1cqBZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7kSkK58lz5VE3F0kOoED50iK/BRVBzS4WNxe3yQnXY=;
 b=LLpxBmr7C4OmsfbASujQoKgJKBC2NumyBOHInOWSMXla7yt8kb8fBIf9ijxV8UVqyMqo0UKu2tankxxLgDse/H2aoIiOmCNdeqyvKL9b0HC3Iw9KB9XroSb0si8ZZtrCSuBd2AyX3Ui1H0wuc2hZv2+FoNwHBdS3DFshJoK4tvL4Db5hbU24pKG4Sr4pYn7/D3lz5ZWjFN8Sj62sgp1gA3KZ6wpVKPDbitJxMxp8J0tH8M4yZesfKV6Jv5Xl6UZS4V6bb+M1Im7NBE3Hu9cGeMYKO7NEKXF42Ce4csIMh80+Z/CkoG6MzJauku5Nl9xPlgkiRAqaLDguSIgWDW94ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SN7PR11MB7708.namprd11.prod.outlook.com (2603:10b6:806:352::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Wed, 9 Jul
 2025 02:40:38 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 02:40:37 +0000
Message-ID: <a14155b7-65ff-4686-b6ba-a6900549864c@intel.com>
Date: Tue, 8 Jul 2025 19:40:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 11/16] x86/traps: Communicate a LASS violation in #GP
 message
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andy Lutomirski
	<luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>, Xin Li
	<xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh
	<brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, Tony Luck
	<tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>
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
	<linux-efi@vger.kernel.org>, <linux-mm@kvack.org>
References: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
 <20250707080317.3791624-12-kirill.shutemov@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250707080317.3791624-12-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:a03:117::25) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SN7PR11MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: ef749e73-af4a-4907-d77a-08ddbe91fcaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3hlUzJ5dnZBYlY4b3dEWGZEdzQyZUJtYkhETU03NHRBeWpwbjY4eUkyNGF6?=
 =?utf-8?B?V3lQenAwYlFNTmpGMzFzTitTV056Z0crVzhVdDJ5a1Y3MmVUaHd1RENQK091?=
 =?utf-8?B?ZXM5Z0VKNmc2SklGZ0daZFpCL1JPeUlTdTFObW8vR1JHTkVHSS80UkZXWFEz?=
 =?utf-8?B?MjQvbmZaUm5BdnFPS242aXJNdUpub3Y5WjdkZit0Q2Iyd3pOUE80VzJ0b1k4?=
 =?utf-8?B?YnVLZnVwOVNiMFZMQlYrRnU5dFlobUoxQ0FZYXdHczFnNy9uU0RubFhPaElm?=
 =?utf-8?B?dWpXK2t2UmxqRXJWRURxQmRycm5hc21tMmZSQUkreWxTR095SjAvTDdqTVJH?=
 =?utf-8?B?Ym5tNFZPTWoyN1NuYjdJRHU2Q0lrVWFOeGhkN1plZzhkZWg1UDVLUi9TdUpC?=
 =?utf-8?B?dnVqR1ltaWFPaURaaTJubEhid3BSQVFaaWh0b1dNQTA2Y2dnMXpGMWtIRzdy?=
 =?utf-8?B?YU4rbk9PaDRrZGdzaDM5YjZiRjQ3S0dkcGxuS2xxVHJEVWpkd0JWVnd2SGpj?=
 =?utf-8?B?NTdJZnN3K0NNcDVBNUh5Wjc5bDBraXgzK244eUxFMEdsK3pocEk2dWVYV0No?=
 =?utf-8?B?WEZ3czErVG96UFJ5MHY5UCtjdFk5SXdxaFloeXQxZ1JXYnNBTm1leVpVVEVF?=
 =?utf-8?B?VzJiUEpLY3N0Y1B5aVcvbW4xS3poWE80bkpBa0h4Y3EzZ2JSUXV3WXJOR0dO?=
 =?utf-8?B?V0kvTUJkTFFUSXo4U0svWDQxZ3h0VzBva2FWZy85dW8zcXdaYTZHdnpSbkJw?=
 =?utf-8?B?dldVZlA4SVlvQm1tWDM0ZUVNNmNPcHptN1NNb1hieEVVMEZndlYzVk5SbHlD?=
 =?utf-8?B?K2V0OWZxczZDeWp6R3hueDM2aXFnVDNJcGtRL05tUmhlTlFKRkFkdVJMZ0lj?=
 =?utf-8?B?YlUxcVd2K3h1bWFEdDhWQmRrQ0RaN2JhSDFGNG4wNnlYTUxNYkRjM1ZaZksv?=
 =?utf-8?B?TW82UFpRbHZRUUo2bkUwcWE3ZFRjUHIwRjlmZTJFUE43eWdIL05nRGphOTFy?=
 =?utf-8?B?V0JlRnBvaGxEL3VPcDE0cmRNbEs4MzdPQ01XUnl3cGtqelJkdzM5b1U5NXpy?=
 =?utf-8?B?b0YvRzc5U2dzM0FvNjdOb09peTFoZnowZnVQVTFRUEtPMkU5OGExS1dIaGhM?=
 =?utf-8?B?MmtZZnIzWTJCZGJScWM3Q29pdk9XaVdFUHhQeWpSUTJHWitzQktrOHFhQmw2?=
 =?utf-8?B?ZG5LNlNpRUhLWXJGZU0yN21MbG8rWDZjcnMyS1BHdWJYMTFwVEZLZlozUFdU?=
 =?utf-8?B?TEwvb0JHWXJ3T01MTXdkYUJrc1RGRnpUdnB3YUJ6eWZqd2hOMFFvZGM4NGk3?=
 =?utf-8?B?MUJZSkQzSGNONjh1NEJMOTRBL0xkRlhTV3l6MW9FNW5UZXFFalc1OThTWGxi?=
 =?utf-8?B?dXNxTmNaTkVyUElUcm1nSTF1TC9JTCsrNTRrMmtVRkJBNFpta0Iwck5rd3Q4?=
 =?utf-8?B?dVJTZmF4V1NBbFJqRUpldExZYnZ1bVhrSWl6b2E2bm82NUNNcS9ySWRlSU9o?=
 =?utf-8?B?c01sSGxlZUpZdmF6NW1yQ0phQlJHNExhaDRGVk1ta2Rrb3VsakVkaE9WYVNp?=
 =?utf-8?B?clBuR0h4RVpjTDRqTENwSE1YOFpzYWpIZTVTcmVNVHJHRlYwdnhNZisreWts?=
 =?utf-8?B?TFBFL2EvWFNrOFEza3ZnYUhSdHVPYXY4UnNmbVNUT0MwWjRZdEFlUGppSEhF?=
 =?utf-8?B?S2t3OGpONElKbVYvb21WcUpIckF6VnRHeFVNZUJ3bUt0dVFQZ250Q3E5elRP?=
 =?utf-8?B?K210N0MvbEgxemg3aDRISlNGNjIxSDBDL2ZIeVp1TmhVMXNtcU5DaE8yVndu?=
 =?utf-8?B?dHhOU1Q2WWlSbjY2U050TWV5Tk4xY1Rld01ud2s5bjBwM2ZDb2pBeXE2eith?=
 =?utf-8?B?VzRzQXJNdE05TmF4ZzVUYWNSVmxLV3pPZW9aZnY2d2RsakQvWi95TjRCcVlV?=
 =?utf-8?B?KzdRRWVvQ0JDd0VlcHBiN1pDZUVaUkI0cVFsd3h0OGtHQXNuVEZXbGdFV3Mv?=
 =?utf-8?B?ZUIwMXV1NUFRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cExhME5SR3RncktrZHdhcThwdU5EdmJmV0Vna1BYZmZIRHRmYTFlRHA3MVF2?=
 =?utf-8?B?TVdNdXcySVoyTTREUm9pbWZTK0w2VTdtcXFHUmhub05Ld3pJVTVuZDRiU0xC?=
 =?utf-8?B?RjZyTjI4aWlOS25LcC9sMWNRdFhtVDFwSkppVjhVcXhlQnhIaXJlWFFrazUy?=
 =?utf-8?B?bnE0d2Zia1NsTTViSVR1K0ljN0Mxa1lOME8yTXUzcy9pRFNvUW5NZjBwUHR6?=
 =?utf-8?B?dWZrZ1loNExXM0hzYjBFaGg2MjJUdHpzMVVmdFNpcUMzQUF3OGFwK1l4QzhN?=
 =?utf-8?B?UG1QRnVsdUlUbVV1ZjVXTG5EbExCT1ZXS2Z0bllwMGNHUEpla2QyNHpHeFEr?=
 =?utf-8?B?ZzdmT3ZmS3NwWUFrbXRSd2U1c2YraXpUTXc1ejY0WmJ5bElyVTk0ekFYeGxp?=
 =?utf-8?B?MDdpcnhtNmlZYmp4UlZGWkd4V1k0N2NWYVhDM0h2enVZL1FOZXZVbGNzTmVt?=
 =?utf-8?B?MFpaNG5mODkxSDg3cjJYUzVuZVE0bXVUZG81dmVwK2VsNEFwbm5JZWNiZEQ0?=
 =?utf-8?B?N1NtSFREUVlBOTZDcUsyK0FsaGFBaXVqL1hqckpSeWU5UEFZZUxBME5sS3l6?=
 =?utf-8?B?cW94eFhkSnBITjlMSHVabTJ2WWdoaHEvRG5jM29VOUIwSFFNdnRtYW5wQjRm?=
 =?utf-8?B?WEFiWDllNlBobU9CYTBhR1QvNXV4YXJvTUNZTW5YL3RJZkZUSE04M25jOGIr?=
 =?utf-8?B?RFZJdmpsaVh1ejlOM083WTJWT29KUFI0aEl2eXQ0TVJRN2N6ZEJ5RFJvdmhT?=
 =?utf-8?B?RzFsdkZNZGpxY0pwUjNSV0dUekxBUndubVdFNm51SWUxTkwvVkFVZzhOREhv?=
 =?utf-8?B?VG1WamY5ZVNLM1EwKzVFbVNSU2JkM25aYUlhY1lwZTk1N1RlTnkrc3JybXBB?=
 =?utf-8?B?WStDNmxMVlpjSkgya2NKMmROblZkVkdRT2c3UXgxVVFIZVRYbEN4MTdzT1JI?=
 =?utf-8?B?aDVlcmdRR0RtK3NEa0xDa0oxWEJsbThGN2plaHVUalZCc2pFS3VNK2RGZWlY?=
 =?utf-8?B?K3JJN1hTRXlzajlUUHFrRUsreWh1cmw5YUdjQVZ0cW9JUDBjeVFCQ3ArQ2lN?=
 =?utf-8?B?YVVYSEp1Q3VwbXVNbWh4THJKYWtqa3Fqc29FSHNKRnEzU0txY2ducnV2VnB1?=
 =?utf-8?B?ZkJ0amtqeTVRTWtHaWo0UFlkYms3WGs3Mk81R0FXYlo2d0w4M3hJeWN2L2hs?=
 =?utf-8?B?ajBrL3Y0M2ZhVE1wZzdpME1GRThkbXgrUTM0QnpvV2RQWGJiTXRtMFhtb0Uw?=
 =?utf-8?B?M2dvZ2FSeHovb0x3R3FnQnlZQ3UrVUF1aCtZVzdXdEtQQ3FBY242L1dHYUEx?=
 =?utf-8?B?bXh0YzVxcmRtM1JEZ3ZYSXg0ZklDaXRsSmdrb1BPSjFQWk4rMm9ObVZaY3d0?=
 =?utf-8?B?dy9aY1N4NERwQzAyZmN6SGlkRFJHSS9qRnNrbDh4bFZyVDZTV09TWFVZQUw5?=
 =?utf-8?B?WFBEWHhQMTRNUjNFU2wvWGV6cUIzOWNYcE0rb0V1Q3ZwbXdQNktxVXl3ck82?=
 =?utf-8?B?Q0I0RHNhT1BiOC9YeDdBRlVIeTF0S0podEw5YkxFU2YyUVFrZE9LalIrT2JD?=
 =?utf-8?B?Z1BMUlpVSitxd0dnRUw5NDk0bEc0aDlYbnZFeXZTdXEvTnBhcnJQUDM0enNG?=
 =?utf-8?B?amgxaHVnSHp1d253SHRqWGY3UzJieXRpRzRTaHRoZFNqWVNUT2FPajRrTU1t?=
 =?utf-8?B?QUpTM1pkVlVQeFd2YmNQU1RGOW1ZRkxmZFY5V2tXWEFCWDFDNlh1S2lieXlw?=
 =?utf-8?B?dkRSckpvc0pqQmRBdFBRbGF2T1grdjFTUklSWDRQaWpnUDNJQ3BLNUxWQ1Q4?=
 =?utf-8?B?RjNXQTVpcWU5MWE3N1FpUDVYL0xYcjNxT3VWR2E3NGFrbnRmQ2d2dU5lTk1i?=
 =?utf-8?B?ZTVaaExMWkEwOHY5eG4zUm9UVGsybGVKVEhTUklQRnlRMCtTZTROTmV5byti?=
 =?utf-8?B?b1RuaEcxZEE1YlIxbVdGajhRZFY3cWhkT2NZZlVnZ0dZa2x3NWMyY2ZWYm4r?=
 =?utf-8?B?RlhSUFl5OVZYSmd6UWFDZjdpeS9MK3FKbHNraFI3cVl4NElVTGdUQTB6ZlRv?=
 =?utf-8?B?TzBSZjZlN1dadTNzYjR2VXBnaUlwTk0zZEJnUzdLbElySm9mQXZKaG42VC9S?=
 =?utf-8?Q?Oy2eb+Q0ssnOGwy3PHzEVDYJB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef749e73-af4a-4907-d77a-08ddbe91fcaf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 02:40:37.6687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAd/Z32G0o2h3anGgSnvzUy1JYValzs/+v4d3LTng7GmwYssFqscig/RyhROS49WlQrARP9NDItiMsFLOjjCMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7708
X-OriginatorOrg: intel.com

On 7/7/2025 1:03 AM, Kirill A. Shutemov wrote:
> From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> 
> Provide a more helpful message on #GP when a kernel side LASS violation
> is detected.
> 
> A NULL pointer dereference is reported if a LASS violation occurs due to
> accessing the first page frame.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/traps.c | 41 +++++++++++++++++++++++++++++------------
>  1 file changed, 29 insertions(+), 12 deletions(-)
> 

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

A nit below.

> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 59bfbdf0a1a0..4a4194e1d119 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -636,7 +636,16 @@ DEFINE_IDTENTRY(exc_bounds)
>  enum kernel_gp_hint {
>  	GP_NO_HINT,
>  	GP_NON_CANONICAL,
> -	GP_CANONICAL
> +	GP_CANONICAL,
> +	GP_LASS_VIOLATION,
> +	GP_NULL_POINTER,
> +};
> +
> +static const char * const kernel_gp_hint_help[] = {
> +	[GP_NON_CANONICAL]	= "probably for non-canonical address",
> +	[GP_CANONICAL]		= "maybe for address",
> +	[GP_LASS_VIOLATION]	= "LASS prevented access to address",
> +	[GP_NULL_POINTER]	= "kernel NULL pointer dereference",
>  };
>  
>  /*
> @@ -664,14 +673,23 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
>  		return GP_NO_HINT;
>  
>  #ifdef CONFIG_X86_64

Might as well get rid of the #ifdef in C code, if possible.

if (!IS_ENABLED(CONFIG_X86_64)
	return GP_CANONICAL;

or combine it with the next check.

> -	/*
> -	 * Check that:
> -	 *  - the operand is not in the kernel half
> -	 *  - the last byte of the operand is not in the user canonical half
> -	 */
> -	if (*addr < ~__VIRTUAL_MASK &&
> -	    *addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK)
> +	/* Operand is in the kernel half */
> +	if (*addr >= ~__VIRTUAL_MASK)
> +		return GP_CANONICAL;
> +
> +	/* The last byte of the operand is not in the user canonical half */
> +	if (*addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK)
>  		return GP_NON_CANONICAL;
> +
> +	/*
> +	 * If LASS is enabled, NULL pointer dereference generates
> +	 * #GP instead of #PF.
> +	 */
> +	if (*addr < PAGE_SIZE)
> +		return GP_NULL_POINTER;
> +
> +	if (cpu_feature_enabled(X86_FEATURE_LASS))
> +		return GP_LASS_VIOLATION;
>  #endif
>  
>  	return GP_CANONICAL;

