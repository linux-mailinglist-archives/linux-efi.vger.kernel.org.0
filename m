Return-Path: <linux-efi+bounces-1362-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4EC91E9DC
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 22:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D1F91F21C8F
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 20:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D8916F8E0;
	Mon,  1 Jul 2024 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nO2q6GM0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4837171640;
	Mon,  1 Jul 2024 20:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719867274; cv=fail; b=lv5RXOA7ZDhW7hfIFd84l943p0G6E2OYVBybhRurUP9cxiMOqX19IPM6+t8074E3afzmMmPUjkRRNalM+0MId0PddE5TdCKx3PctnxnGKtpMipt//CNnEQo7pWAl2hUrz/0rNNWCsAO4TO3Ub3YsfFsquiZbwtfgIEyVX2FBpxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719867274; c=relaxed/simple;
	bh=2RifocVBOKZDD2CwIlURh8qMuqZFrGAs7UQzByPmnkg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fMs4sqWJOe4SDm0B9vGjvNbhrfRt2LKEUcGBfdwsGUlPwx+PppjHrMWbJLZteVikz+Bi60YhIAXyfNlAyupWnara8mM+x5tvrR6I+cYmVAK63SP6cPK2/Hbaq+tiAyfUYcqENqLh9k/++ZHzYr4qQnDG12qjKS9uPVo4oqLv6o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nO2q6GM0; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719867273; x=1751403273;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2RifocVBOKZDD2CwIlURh8qMuqZFrGAs7UQzByPmnkg=;
  b=nO2q6GM0wS+Qv3PP/sxlyhPQlqu1Fmkms63JWbzM3MuGBSa3GoiAScXW
   d78ZtgkkaMUpQbO7AdpTyEGd4CFETdQKumbIrIZUhydjwf6jxEWQYILDd
   fkopFv44llIIfccHAlmN4vbI1/rF43DkYThkoE1/ZZcdQRsfvZSMsJexI
   ECA2CncpgBgKRkMzN6TE2V7OCWIgSmd9PbXQtPoJDhvbKlIOxQs6PP9iV
   0nG+2R30o6OAdG2ONwCryBGTohmUe4XXH88gRTSDPbqdkv3wPXCo0RWWj
   1YZRRz6q+ehuhI3WtUu2q9NVYuCTTllgGYfoNsb8JUx5gU9sJSlHmb9bH
   w==;
X-CSE-ConnectionGUID: 7e/MCsRuS4+2sgdvm1r5Zg==
X-CSE-MsgGUID: hDgbcN2XQy2QIdK6YWQc+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="17150793"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="17150793"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 13:54:32 -0700
X-CSE-ConnectionGUID: bsHRWFdbRHOJXpDIv4PsCg==
X-CSE-MsgGUID: 4cWJtmx6S5etLgbg98uoow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="45555544"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 13:54:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 13:54:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 13:54:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 13:54:29 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 13:54:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etDfzqPPFo3XvpGxgclgb+baWXT8tHezwsApxihXkVcojJI3JX9cgV2mltSnl9ybAkhTVoxy+/CfU/tah5Wp86eNRHWe8Z4bY035wcqGFOO3k0etVL9fd2G8P3mSwslpcP6zD2KR/67lsWnASHo/a7eV3WkYwcXqJDYZDaM7vYm0jHc9Bjz2B8S5AGV4ujNz5/3nWvlQ0eQ+yZcm+EMc9CicwkrpQ3pFtmZJNOYhHzVZSJGaHINF0ytk3t/YcDv+LoVOiXZkvbQf752U2reJBDoD/wdJ/O6qy+4A/bExi7y/VyVNYFd/JPuQHcC1Io79UK2Shocjc+HLCCuZ30BDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uE8p6MvYC9JKBamN5vt2WTyxm40P0z2z8oS3zC+4SvY=;
 b=md3tahCLKo2ooH20M0+iuaAXbFWvJk9JIajFib1CgWRoPPsfZJHnxjbTgG6kjC/ezM9gj4MHN3mg4hRFndVy8nCBIbEcSzZJ171F/NqHsExExncxHoOKiZE8EGQugqH8GkGLVM+DXZ8NK54tuCWtXkbPUBLPhaPKWO746lKBlhhAzRl6xZMIyTs5Xq7lwIBt2Z3fPrF4CoWhfv1i1cjmxuLW8r5W8m1GRThVf/iSmgEupwoFuOlZcsVrk84FOu0o0mhrt5rVdQ1+ciBKvMiIIGL7nDKmLPPwrvrhN03xE/0EFqJrcfajBbApMQSZMzX6OpwdWlUPRULGDOQjmt1WMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Mon, 1 Jul
 2024 20:54:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 20:54:27 +0000
Date: Mon, 1 Jul 2024 13:54:24 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Tony Luck <tony.luck@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: Ard Biesheuvel <ardb+git@google.com>, <linux-efi@vger.kernel.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <dyoung@redhat.com>, "Ard
 Biesheuvel" <ardb@kernel.org>
Subject: Re: [RFC PATCH] x86/efi: Drop support for fake EFI memory maps
Message-ID: <6683178094c32_5639294c7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240620073205.1543145-1-ardb+git@google.com>
 <66830ebdb7f0e_5639294f5@dwillia2-xfh.jf.intel.com.notmuch>
 <ZoMUnSaqORagM_Y2@agluck-desk3.sc.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZoMUnSaqORagM_Y2@agluck-desk3.sc.intel.com>
X-ClientProxiedBy: MW4PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:303:8d::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN6PR11MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 06a11011-9fe3-4b4d-3ea9-08dc9a0ffee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CSIRJO8G6lX9Ldfvqs0KEeo1HKa9J9zOQNUrrC5ZGudPj/F/nodqLeHfz+gZ?=
 =?us-ascii?Q?LN3hiGV0Yg+jXVCQh9FytVkxFiFY4uuGdOhXf3/ay4djVnxFke5IebuVNeNF?=
 =?us-ascii?Q?8X6i6FhOHF8WYv+5FCeeytsoQrE5sVkU1TT0Odk9JsEowv/y6weawr38zjqE?=
 =?us-ascii?Q?ABS65NUr2UPjbw5/yvPgvneY0hAfCfu4n+t/18LbD8f272UcvuJ4wkMTRdR3?=
 =?us-ascii?Q?2Vqpa0vLssoC1+bbbnfDg8aI9U8wmzOQAex/qk3E+rBzNmrKp1DKT4xU80lE?=
 =?us-ascii?Q?U1dpnlRJXDHmiDUu7qhCoSg9rKD7GJYXFUqHsiHj2exAu8YNh8KV0uvS+95z?=
 =?us-ascii?Q?9zF9s2Agweb3rJj+Q7Z8p4hypxxJmnqiBU+Lu4ybFMetQ90Gs4X+pRxkwSRj?=
 =?us-ascii?Q?qQssTSJXRfrr9iEa627EmnlJ+RRLnxCQmlQ1hkUQwCYM5147vfG+DWm9Uige?=
 =?us-ascii?Q?U3q2R/ALa7H6XzO3YXEByjb4UUwNqvafc3sSKDUhysodeM7f6vWpz671KPTW?=
 =?us-ascii?Q?F8KXADS0zsk1o1qrmUWj+xx1z6CxSY7CwQMU/vx29R57PVNzjRtyFHpzpOL1?=
 =?us-ascii?Q?0voGu1A55cEMXpn5fG1te8JO78d4jRmdofqUgMaIUHTjFB4ztQoSIeLVlBC1?=
 =?us-ascii?Q?EXjA6ob9WajgJ0b0UZkL6/+QmKzPv+xcOFxuGFXDoT9KRh3WDZx+qVRpQsCx?=
 =?us-ascii?Q?BGPPDpm3p/vf75C4ttWkvqarX5kZjbEYCdBmBELIqmZKxTbJTNdotAOond2X?=
 =?us-ascii?Q?967m7/KUzLwnVNWOIDcGDIC3qlFKWVUwEJvuzaXt0HFd9pP+NqXgwroz5i9j?=
 =?us-ascii?Q?uwAvKthq3UDOw9eo7v14prPXQ8Ea9CuhwMO91O+sNmFQewfBrCGANcTSbMSt?=
 =?us-ascii?Q?zNsqrW4LsB8QSCMMnDP3IeHEeaJd0eZaIKu4Oxw3SOwvH6S42f+y8jgOXdLy?=
 =?us-ascii?Q?rtiqCGQ4OAFmUIA9YpQPS09WWsVhwcPTNBozBh78NI2T0WSQCdjJ+9k7p62/?=
 =?us-ascii?Q?TZNFCLCBrsWP+NLuwlkkFkHdQYh+FP98rE9n/JtJtWe75T/27xHUfIV5nWO8?=
 =?us-ascii?Q?4RVbYD8Ngr+GGK7Gi24Mifo25vuHd+Os2UqpFP0JFZmD/gky3sV7nokzegqc?=
 =?us-ascii?Q?nCAHtOjNulZuKBePIlH5f3AK52UNOV04JCRHZvgDZTC8BN0/K4E+AKwZiezR?=
 =?us-ascii?Q?wpQAs5YJlkHruFSQk8+W80DhpMwXuAF6ZeNDBDvWKZSzpZj8UH4EGbVGJsk8?=
 =?us-ascii?Q?PCj1rzBtOL++aJHwZqgXK72f6yO6B21ua5yJSWTE8QnYo4lK0RmGcKo2GYqa?=
 =?us-ascii?Q?gvA/fwdLN06GlNgnETiiQ/6Fz1UAX8UeQOZFXDnsofm+kQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2TMzNdi7r3kcPFsZZ8PcIj3iBV3fYrRtt4sJLms+iSFOAD8fZsewkgiblHER?=
 =?us-ascii?Q?8EEUSEGt7v67uZ7jcODr/TqOSV5mzfYn+ZFE+FC0KWLsOLK5bktbL6suyg1F?=
 =?us-ascii?Q?TlR2BJ6Z8Th+nBmlnDCeiHNJwUz+ofa3QF5NN3NFEIIHicfnjcgg9SIGkHKN?=
 =?us-ascii?Q?/goOyhGJ33mWuZLUrluUSkFcSMeoCjuDYy7Nfs7K61SA3l92i6XnSMWt2tpu?=
 =?us-ascii?Q?sbJ2ntuVdXLM+LUwog1JPl4lgg6WKMFxZovhwD5kLGcsJZijkSbN7XhLlLm+?=
 =?us-ascii?Q?oRcOjYL6BiO6cu0CZbHuXuQeuJsI8CrjPDBU+Ha30vgEi9qw4xl+C5Qbmnd/?=
 =?us-ascii?Q?Z2dcbj58YhmNCGqTpeilZq9a8gIawlVwvfsh94IBb7f9zhKAmCAObCxfD/cg?=
 =?us-ascii?Q?n7TzwqGTPNj1iSmAN1YDOFy95aR74yuOXXEakCUPS5Z4WEbllHO5gWfrwxvf?=
 =?us-ascii?Q?uWOh4jUGQxFFFikP6St/vJNmRTbz5snI44W/2uX4c8A2e3zT1Kgbcq8vfvSW?=
 =?us-ascii?Q?BLRYVaSGvU2EdR1sjNXfVpuWaovFZiEwgu1QvwpzG7ecXE8XPxevRjxkKnUi?=
 =?us-ascii?Q?nvUcAoEk1wy61H95eGlM7u2MHQFBozqRI72x4Kwv7W8YNVV6s0Zz2Xgc9SUD?=
 =?us-ascii?Q?GycWdqv84aSb9IfBTojz6mZKI+YbNSXKooJzl012jFzlhZ+brhgMtLEnyZ5P?=
 =?us-ascii?Q?HXhkxShV5blEKM+e1d6WCk1JKHanjlgKmoKQHBPEjGh5P8YS7zhbqsH0ZDKi?=
 =?us-ascii?Q?oBuLXNZtfDONUBkn0EWKRvnDg93CxNQgxbdm+qSRcnGgRdKBeBY3KWuXbGvO?=
 =?us-ascii?Q?AkUVwKHy4Uv656McjOeZJhbQI2Cc0M5zb7eJJOUQql1VpJ/VMylm68b5/AwU?=
 =?us-ascii?Q?pi51/Xguk/01adcyFypgnejHSyG/ELwZGY+v1OyuwkCLY2CfDDXdkmDi0ECF?=
 =?us-ascii?Q?qhVNKccEPt9vkCaOBkH7KnCoK2z/PZ3XUDqtDuiTkrloo1ZSkcsgjzMh9uKg?=
 =?us-ascii?Q?WAiKLPPD4UlQTGXMHs8hkA0JhERUs4Pz9Tt7DNlHekMEyJlgi5KXnpUJU2im?=
 =?us-ascii?Q?A93/clxqF2LMAV/kz7tJsQLtpusxLr6w6fVBtmmfHGnUEgDu/ATjGo4A+8Yg?=
 =?us-ascii?Q?+pJi6BFesxsltYmI4MvVb4HFIkPNLhFnHugqm2NBT9IO1/+qMbXx4xpmwcxH?=
 =?us-ascii?Q?mXC9yV3DrGe7xsOdIHvDAxCPJ6WjuEx/0kBxllP6pJXJSnBeStYaX+cWrxfX?=
 =?us-ascii?Q?NkMtciv4emSrZNfol0+nAH5BU7QtVbKvB6JJfaQuZtFLrKqqTZeaqB8WmOtr?=
 =?us-ascii?Q?vRSgvXeJJQmqbaSZQLojo3m6kNlP9l1UEkD894mBAsBrLBJRO7Wm1jLRP+iO?=
 =?us-ascii?Q?0pnGuWEdC5RvDHDKZezuYi7uzZRos96ay1TAS6aUpCqe/5/dlmIghobe3MBb?=
 =?us-ascii?Q?icMU2OJWArh8B0cltNvvq+s51Ii7bE2SjQYMgzyS7w7T0uHroCojCFbNy87N?=
 =?us-ascii?Q?hj+D230UDRkYwbz/CEvIbmk6pI7gQi5NDome14Ls1JhAzVFedMv2rgl/2jQ1?=
 =?us-ascii?Q?BfxwyZBOM7gCyJnOSV0hzBtkLKPy6tMJ0wh4RCOZv/ZI8GhEA/89G9YIZh75?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a11011-9fe3-4b4d-3ea9-08dc9a0ffee0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 20:54:27.2296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODk9nstXV8E5VibEXW1PW+mZumAAZPqqcGsa7EmHWQFwsm0bYpDbwi8cqUEhUuYzloHoF8k5EN1hjE2QgidyM5p3DVt6WYicNUnGFqlmMP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8220
X-OriginatorOrg: intel.com

Tony Luck wrote:
> On Mon, Jul 01, 2024 at 01:17:01PM -0700, Dan Williams wrote:
> > [ add Tony who may care about the more-reliable removal ]
> 
> I don't think I care about removal the fake options. I have had
> systems that support real "more-reliable" memory for many years.

Ok, lets remove it and see what happens. I recall now that the major
policy knob that users may care about is efi=nosoftreserve, and the
ability to specify efi_fake_mem for testing purposes can move to memmap=
on the assumption that kernel-devs are much less likely to specify
broken settings, or at least can pick up the pieces.

Ard, you can add:

Acked-by: Dan Williams <dan.j.williams@intel.com>

