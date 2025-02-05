Return-Path: <linux-efi+bounces-2754-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F417A29C85
	for <lists+linux-efi@lfdr.de>; Wed,  5 Feb 2025 23:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E995166E99
	for <lists+linux-efi@lfdr.de>; Wed,  5 Feb 2025 22:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324311FECBC;
	Wed,  5 Feb 2025 22:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pt/2PXt9"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EF7207A18;
	Wed,  5 Feb 2025 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738794105; cv=fail; b=IAumhY7Hy+i8RkxX5UIyMAY/dafevKk4he4dxL8rvrECGlLFELZna4ir5BOSUmPxVZBtpfDuhNOoKZrUHVcBy7VgsISraOSJb1JzBHI+Hbz0cT6eZlKYP3upZMbiYD6UsA2c4nddmR/BvjWquEVgUQaExtXlRARdLmZpcmCVUPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738794105; c=relaxed/simple;
	bh=vbRTnfY+7QSYeSNOF3/AX3hYwRRQ2tOf6HvcipiO6fk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bygr+D9bTzdFQqfIwqr8ZgvEmPz4vKrZDswDea3And7HeEf393cPGC47JGQMjudc+YnYJLr4/0OO1kDrxFegIi8aFTyShxNrTTJQ39NFH8qkwCU1EVAnNyCSYMVicOM1fWiDwSulpwZx//z+rMQernfhcikjlMW657peYrrbm9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pt/2PXt9; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738794103; x=1770330103;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vbRTnfY+7QSYeSNOF3/AX3hYwRRQ2tOf6HvcipiO6fk=;
  b=Pt/2PXt93DUamVGjwPQ5tJaOB2S8YAqWXgS/hiB3u4mtfevHAfIlXKeM
   9oyxtK+GFsINIWHwhng6ms7jXpNnnUf6EQc7Vsb1WFhuR1dAB52dJtG31
   8HUgHJ0kDu4y3etC9Gt0nD3kdoBg1bWQsBcI7PQM/3XFptyGwRweL1pEG
   oK07m+bP7NqtfRJQDZ2pn1lPHkGr5cfdwlZeZ0pe++60DkGrNSslkbBlI
   9ZQGXG77uvkUqhwIVzro2M7s3dCHSJQ0KzsUs5sGDPKo2ftCyKql8U3wp
   szT4xjMzrx7byNmkhbaefVLM0oAva9Pc9KfBF7r6h0Y4x4ciYU1En/YCV
   g==;
X-CSE-ConnectionGUID: 8CDeMa3FQkKZSQl8r9CBcA==
X-CSE-MsgGUID: eScUoK9wSS2wIK6lQzTcag==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39407274"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="39407274"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 14:21:41 -0800
X-CSE-ConnectionGUID: 2Z2eHev/Qm+b2SGiLKWIYg==
X-CSE-MsgGUID: trqswswtTymO7PUEPT/gmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="110925544"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 14:21:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 14:21:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 14:21:39 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 14:21:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljVI8H7HqQU/ddre//3IWR0qhXpi0Lq1QIeMc3T+FnBKsjM0mLc9HH9q4hle+Wp4mV5IiiW/HB90YvQ3vMKHbbPjrOec6jXPfwwcVQO/0NMyUyrj2aPS48tVQkm34q7FTD9fD06mpByPqem5bdhY3d6Qm7CHDXFTkULE9Tya/C97LotB3W39zSTvW83yd5esY23g/GWrYCNOE15ULtNt5DBwh9vnvsfA3ALeTUdsP1wotCUeFdp1U9rJOpfPk1RygvQ6uUuVMs3fZ69GdtyIOr+7fnONFBSFnHQGBWjALbAP2A2gig/e11CkdG+opFKLDj/EJ5xi+2tAcnSisJup9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrSTEIehk1NsVm/aGNytfzzQztwmQ+ZkIPhYbxhVBNE=;
 b=Bjeu9IXETAOjqnI5m9AD5oMKCvbuDBtoPZV75pQbSGxGd0Udqr3qKbE2cCAyf9JXFbUHZHZu880WGw4f72Ahbnbi5YmyXURhq2zrFeJegE47O895odcv2GFdnd7ki1dBxNZbrXpcwICW+i4FFjTwgWGZvhb0sOqWSM5ga5XtddeYBT3YOMZxnFyyw9vMBYgigKBfqs4X88AFqnpHoveBVRur+BsVtE0vYUBgcDUv6QZiqjfvfl3DmZ91/nuiK4HT6UUjw7ymFcv13FuB5EFGnSWkkx+N+NFnvuTxhjgNmvel40t5xTq+pkb6sN4ziop0XScXkrg9d+FS62CY/No3CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ1PR11MB6153.namprd11.prod.outlook.com (2603:10b6:a03:488::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 22:21:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 22:21:37 +0000
Date: Wed, 5 Feb 2025 14:21:34 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v6 4/6] acpi/ghes, cper: Recognize and cache CXL Protocol
 errors
Message-ID: <67a3e46e2d0ac_2d2c294d9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-5-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250123084421.127697-5-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4PR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:303:8d::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ1PR11MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 280023d2-fd1c-46e2-c9bc-08dd46337495
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PkBD/LGLw8srYX0gaMd3UCXdmPO52/edHQDjZqPh61b5GSKhLj5wMpIjTjuY?=
 =?us-ascii?Q?PN+N/e/pqMyv23cRkPVwPjyevnmxEzAVgMckITKyXPS+H4Zg1tvCpLnEF/gI?=
 =?us-ascii?Q?pa6O1iE4IiAL1pqyL/HqkgbloiFOkn38uZNOOK83uWkhipd7TZQEe91AJ3yG?=
 =?us-ascii?Q?t/JHGzelAx+7ID8yh0WNyMglkhq8cJO+T4XIS2GX1pwk2N/tlxdmeOo7TtbM?=
 =?us-ascii?Q?mRiOr3owTLDpsH668UmH6R/bF31T1lHwJVwq8XeJsZwmxLoKPrI/cowxL5VR?=
 =?us-ascii?Q?LbvDKQwHzMoz5+ZfklT3/8N1jikvxrkFT+jG7OQ1lGJuUK4wGC7kkPP6iCq1?=
 =?us-ascii?Q?7xJXGmRDO6tnRSgRCqyxNjrUvnKHDEtitSd4P0R0rinu8HcSTktVHTmmDulW?=
 =?us-ascii?Q?oGmBGjAOIMUnAd4gl6uHXaEOG80llmeDTCWyjjvQCnGbwx9P4bB8ahUAlehS?=
 =?us-ascii?Q?diiCbVcoUx6Ae4H8RebH6I9pxV3SPZ75bKnzpR3l+LGLvwe7UhyrLXeWmEGe?=
 =?us-ascii?Q?+fNSnoY79Xf6TNBf3iOEzo5C1tKvaSigs3tZK6Edr2kMdJI8yqi1hYoK2B7T?=
 =?us-ascii?Q?GY1zYXfYRLpPafqDVG+Pm7o+P099mLN1FzqtQG6UFgJQ1o0eGSA729bUdiJq?=
 =?us-ascii?Q?9E9WbQZiTlepxnblLuBF/j6O09EKYDNecImN9xdU70/DteLb8XgkyJfNoY7q?=
 =?us-ascii?Q?u5cw5a/zkbos6sH0OFtL/kQ4tHuA7DeVrLbeZvSmDBW9Hqa9S4mKfx6tVLq7?=
 =?us-ascii?Q?j0O0X7RzekAj15LtI3T5RC876r9axEwAGecQFmcnQuV5Mf8xLs2knYGfCC/1?=
 =?us-ascii?Q?gnhCfdnxLNDSGpyCmiJWw5jLXC+7mbRasBASPCmVhBpXmXT/xa9KKVtBjSvr?=
 =?us-ascii?Q?MK+kVBv4//djOeHE9vuf+DvULTeFue2IkQztQvVIxFLYIBcWGQJmCSiQbonC?=
 =?us-ascii?Q?r+mKmDUu8qcxfYetCoUWH7dIJR2kgrQqTLc1ziYQEalsiG+K3AXfOnj+4nOO?=
 =?us-ascii?Q?S+y/pTHo1maUjt87DHkwlM58Fq+eyloBd0k5cSXA4W9LqIn3nrSusKEj6plU?=
 =?us-ascii?Q?wljJ7puTWfr+AcWRcxmv3NJj9UkD7SFq0UhEurcFcuzaJVjHexFxk/aHzmne?=
 =?us-ascii?Q?9bfrW0Q9uSu0dDzQb2b3BEGuAwcLa9UUrzdDSPYQLXOk4er69A8enH++xSJO?=
 =?us-ascii?Q?S7NSadfLqHIlH1HFe2rlVsC+ul1ZcfLD9XHyiFHrls654G8iJT7CwrNwCEqI?=
 =?us-ascii?Q?10YP06fMvXHkhJ7NsPCv2vWgU+GrJhTYxVua2hSZ3GMJUQJ0BqbzOeW64jyT?=
 =?us-ascii?Q?uyQ37Z0ip1XJtZZ1ebKyJG9yaxTsn+lXwAcoOaig/lN0QGT/Z+PuJTkQAcUS?=
 =?us-ascii?Q?FCUs/Gu/MKqlDAq8Psu7v6qDFHcT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i5QcC/YbcW5uUn4X+loWfFJ3tDQFFgol/0DJ5QNbwm1xW2PC94K0rsVADF+Y?=
 =?us-ascii?Q?k3rELDfaatC0sZICo+yLSZXAaduX2kj5WQ0qnZKPptmvhAUiE9B8aFHVQfpl?=
 =?us-ascii?Q?A/gUYetUIOrmf/HpywZPjqeknkrxJHKXBASqnCwR9f0gF5OBkDHeHgFwfvvi?=
 =?us-ascii?Q?e5p/P5V7w9C253D8gzBJ0cAT8e7pOo7QGq4nHRowt98V9Sr7N0DjO4G83AAK?=
 =?us-ascii?Q?K3RfUuvVe0cK/E8icoZDWkAO6crx2OyZrl2GtwP6UMEln4IXBtzF0fBAWYlk?=
 =?us-ascii?Q?7Myx5+eXhCPh5jRulvykkZOcpaUe+nsqUKY54nrQfBbS07c7D7jzrEtmiZgg?=
 =?us-ascii?Q?SmN5hOTurX1JFspT5jsYZjWiGz9H9J2yl87mPtw9P9z4XIUgyapfiOQHvArt?=
 =?us-ascii?Q?3qYPSiG29tpYi5U0j/TYEGq6RiqpE4//HFJFkE9NlsrHM0/YBQZ7KkDqz0SO?=
 =?us-ascii?Q?u8r5JGLP3FyW5E6mYHT6uNBwMUeJW5xJOnNGDO4QTKY04W6spOtqv9kEIacU?=
 =?us-ascii?Q?WWa7C7cCpZVCVPA27G94Dso+Im5NtqFZJo+RBY2Bir0lQOcAI0XyizOJfxgu?=
 =?us-ascii?Q?0cWg6DYPd2hC7t10KdsfKif3jUxkCeEyRMpd+hgMNAh15vI3fURf9inU1h1J?=
 =?us-ascii?Q?xim5bqF17cNIslNfjyF4NkkvFSY4nbQP3tXtSlnnNUAJR8Cv13O6AMFnQvxh?=
 =?us-ascii?Q?Crrb9DQflqmOWDRmfGSjbdBX8bCIMvO4wfEBea8+NZEWgxv7rsf9KORdohqb?=
 =?us-ascii?Q?SVn8sI154mFfC8LwKhLKoFE6tV5v3KPtVIFzz7OzIOyUMAdii8pzkLhB8/1T?=
 =?us-ascii?Q?vDk+2nCQdGMNsMUSMab1qfd00d1JmNMICARuozmoEsa6oSNvIf7GmwKfcjq8?=
 =?us-ascii?Q?5FZwEo5diwjcbK/baiKTeslEo1Ov0XQFIeMWvgnZ5FEy7n3h+H87YIs7Kryl?=
 =?us-ascii?Q?LMU9te6l86mCe/EsKjXN7s4dir6WqjF6rtxkF3RRhFOagfxEP4XcGbDa1zBt?=
 =?us-ascii?Q?qcT6oZT3J7wYWuhgGQ+tTO8tq2ok2JN9V5nvf3C8LaaiePq0TMiXGmNf6xWx?=
 =?us-ascii?Q?6hdJdrUjPRXWuxIvqDCErHL1t2ashZzWSR45m0Uvk9mu70/Hy7/Uv2hDUlFz?=
 =?us-ascii?Q?jFuCLwuKHvRiSeh4Wo1I3Js0iXmQ6AiIt8yaAwoymoeJz7iSLVwGub38kzWV?=
 =?us-ascii?Q?YchdjVG4emOgvfaYOGqTyGgyKHYakX+Go6zL6AxsKpE4NTRUFgCOQPiniZc4?=
 =?us-ascii?Q?pk0TFBqvqPEdVl8Vigfqs+V0FJXFfGQENw2It94a59r8TpOSVNCUe54fFusw?=
 =?us-ascii?Q?r8Lli6UmhYbpnONcp+vDoLIBuitZTUBPeo/Mfvu01mlOMj1nCFOMRPwSJjCn?=
 =?us-ascii?Q?r2TlXUWotu7Pk2lS44guaHCHuTLRuzyGcFKK0l9H4MDWMkYqb2EvsVAGF7+0?=
 =?us-ascii?Q?ihGv6IkjMBtfIA0GvG/AW7//JfTttZVevMgALVPgMm97eQp5tuNyzklmaE4R?=
 =?us-ascii?Q?Gp7AeY7TgGG6OJjD0i+9U54AKjLIp3YjlDj5pPhuasgviLGVOYHfqFWbuI5o?=
 =?us-ascii?Q?pUo4dZBHUnm5HuXAT0h8GImWKYn/PeNsXonXo96KaPgSTbsUyhyVPBe0OVqx?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 280023d2-fd1c-46e2-c9bc-08dd46337495
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 22:21:37.1735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsqglDzygYcSfaPLl1vwn4Se3jwG8qa4ErNUOScDJMHT8/ZwLQ1HToLxv3qrC95rcaXEr75ngRbxTBxCcCdgFTP9N77sic2/s72rLz7PnrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6153
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> Add support in GHES to detect and process CXL CPER Protocol errors, as
> defined in UEFI v2.10, section N.2.13.
> 
> Define struct cxl_cper_prot_err_work_data to cache CXL protocol error
> information, including RAS capabilities and severity, for further
> handling.
> 
> These cached CXL CPER records will later be processed by workqueues
> within the CXL subsystem.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/acpi/apei/ghes.c | 54 ++++++++++++++++++++++++++++++++++++++++
>  include/cxl/event.h      |  6 +++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index b72772494655..4d725d988c43 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -674,6 +674,56 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>  	schedule_work(&entry->work);
>  }
>  
> +static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> +				   int severity)
> +{
> +#ifdef CONFIG_ACPI_APEI_PCIEAER

This is ok for now, but now that there are two of these functions I
would not say "no" to a follow on patch that moves ghes_handle_aer() and
cxl_cper_post_prot_err() to a new:

   drivers/acpi/apei/aer.c

...that gets conditionally compiled instead of this minor coding-style
nit. Certainly if a third instance like this arrives, a new aer.c
becomes warranted.

> +	struct cxl_cper_prot_err_work_data wd;
> +	u8 *dvsec_start, *cap_start;
> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
> +		pr_err_ratelimited("CXL CPER invalid agent type\n");
> +		return;
> +	}

I notice that the component event prints are not ratelimited, so a
follow-on patch to add rate limiting to cxl_cper_post_event() would be
welcome to match what you have here.

