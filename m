Return-Path: <linux-efi+bounces-963-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70258ADCB6
	for <lists+linux-efi@lfdr.de>; Tue, 23 Apr 2024 06:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED2A282372
	for <lists+linux-efi@lfdr.de>; Tue, 23 Apr 2024 04:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544EF1CA9C;
	Tue, 23 Apr 2024 04:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jaO+dXmB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5935C1CAB3;
	Tue, 23 Apr 2024 04:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713845448; cv=fail; b=pCh8k2GEUjxaZm6vfT9K8vxREDAZ/ybi7ndan5H3WJyIq/9jKqE0f0m8ho9l6sYic7v0tNxJwNO6F7qmMTfOz/Fxo61/6lz79ICCBS5gPBsvv0G9YUq6F2ey7r91cvRJz1sqpZnZPMq4obyveLLVdxJqzxqXXmlgAWSmHRJT0YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713845448; c=relaxed/simple;
	bh=a2zlWg9hJrVpddiTYQAzU7DsiIt+VxlVh5bp6r1zULk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zn5bRufP3oafBe4fn/te27QHBvRyUO5ynBjDuRy9e7O6OhxdbO5vaIDDys1pEhSRjLLZEOZJkHZGDe27YeR7i7SFNhDVEO0W5Xt6cuXt+TN+x8SxEPtnBOSXwnCY5p8l5J1OnMj6gieWcvcGTIRevTRFpEmkwP/J3of0RywLj4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jaO+dXmB; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713845446; x=1745381446;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a2zlWg9hJrVpddiTYQAzU7DsiIt+VxlVh5bp6r1zULk=;
  b=jaO+dXmB5ziF8y4PFt8zbgnRKXtJOe4I9qhfm4nTJXM0VouHkK7YDj+M
   yWJV/+cBwReBjSrvjrpltAYfJZXcWv0WR5Xt406ZuYoDxfJfBj/6P9Vg9
   K9IwV7a/G/ccTfNFyP9tOoo8BFDZDOrZmfIOzYLTkpeOwL/nOTHbQ/z6Y
   cJq1s2eySkx+6RAR+Meq/mysx5JzDKez9ciwdAlmBiFw/mYmOHTNlzPii
   wuvyjR1AbkEfBJerwD+ojvC+NXM4BjJ+B4ZcHMCIx2nC1K4zOzX9KiIOx
   xwOSZXjM7U3wc9z3B11472ZG9RqOIcBAJ458ij4F6umOGTxsxmpyHPxZO
   w==;
X-CSE-ConnectionGUID: 6ZajD/6HTuKqt28kdE7yIQ==
X-CSE-MsgGUID: zpgHnfAaTGK0rJtjlawOMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9265862"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9265862"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 21:10:45 -0700
X-CSE-ConnectionGUID: Xu4EmRAITCKi9Pot+gOUNg==
X-CSE-MsgGUID: a5/UfIi0St2al9GHChwkwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24746873"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 21:10:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 21:10:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 21:10:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 21:10:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfQJ99QC7gPty3rflY9kX7vH6kr6g8eU7/usYFXSsI/hoR6OYJvnQGL4tsQV4m9oO91mYOHAVFi3limpx+YHHrk57EK3IJIZVsVnRgWDlZZuOBwyHXY9COh5KvmxbSdhK+v4nLfLE7Hpmxbd/R/3JD9krscnmRfRKbYyxdX6CFT6wf+bmhmGpMpKNNdYI9GrE8R5WSlmRGxJmAUZlZQ7ylESLrLz+kbEthEE/XiZxWAgiP9Lg/VPDSxkJiGD6DNbsG3ufb94xGAh53zJIVovbbg9q+4ZLzHMQ3lM0xByhMoOECvwo4rNdEfm37jqpvbphVx7u59Rx++vm50hz+xOcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOJHvR4naXGVwuT3Lh8AliCHwqPRipzSAsJ+MNtWUEM=;
 b=IJ40Iq0PmWewrD9+A1EsskBMqGMCpe9BbbYtp3G0PBjFIQqnvmF/rq48pmaRinZ8GWNVuYT2DfuRgCFiah/ClJ56X0YkOd11nlwurmZ3n8M9qYR/eIEkptuSi64zfd3wxan1E+zBbzkey/nNH+zU2iKe1HSm9OTFDryCo5F2K2+ieqlAkxp8s/eqYdXbIMvqdU+aZbkQLX/3uQ8hwb+0SXvw4BMueuD9tB6PN85tBod3dtfCRS5tBnvhpmhBj58vZGAfnQL2zJ+rmVrqsgmZB3ahMeRtEx/MXLGHkUzmU6akMVuECt/NH9yHqCKN2SD01kOxhPsT58wsJrW0QAGK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB8668.namprd11.prod.outlook.com (2603:10b6:8:1b6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Tue, 23 Apr
 2024 04:10:36 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.020; Tue, 23 Apr 2024
 04:10:34 +0000
Date: Mon, 22 Apr 2024 21:10:29 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>, "Borislav
 Petkov" <bp@alien8.de>
Subject: RE: [PATCH v2 3/3] ras/events: Trace CXL CPER events without CXL
 stack
Message-ID: <662734b5cd6d4_bbee629455@iweiny-mobl.notmuch>
References: <20240422-cxl-cper3-v2-0-5cdd378fcd0b@intel.com>
 <20240422-cxl-cper3-v2-3-5cdd378fcd0b@intel.com>
 <6626fdc7b7e31_690a294a6@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6626fdc7b7e31_690a294a6@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR05CA0160.namprd05.prod.outlook.com
 (2603:10b6:a03:339::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB8668:EE_
X-MS-Office365-Filtering-Correlation-Id: 57594fd5-797b-43c2-5e04-08dc634b5287
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hVO4XaMZZ/tU9BkQx44TUchmCfSw8I97CfwsuEO65E8JwRvmcQJeBCzxYqYA?=
 =?us-ascii?Q?ztlqZKpHhSeom3AZe02HjksvNpIIDU/mharQh+jwQd33oWVFsg4UuW7TvhEb?=
 =?us-ascii?Q?YX1H2WxsqZlH/ieUdqLlAv74AKVbG2QROq7Z7TjqkqoLZOFMASooOaT69CNq?=
 =?us-ascii?Q?oSEky+i+igld0CP+XbjfZB6U5g3ufzdKySBe27XheuUg2y/Sb1bPfrtER0KY?=
 =?us-ascii?Q?9bMqe8kWcgiAHONsp0/xJVDlP6RwMiu/5kTu2uBxdlnNKDEmrXzjouAyzAL7?=
 =?us-ascii?Q?TJ+NVm3q2Qww6rIxbOxFk/syG/FscY75GGd9lxgUjVxMTQPSJPgwqnCYCmuw?=
 =?us-ascii?Q?RPwWQt+QoAZg6njhsEfl/nIF+lsmjzvHSaF7MdxzfVxs5T49XNmQDXAitiVv?=
 =?us-ascii?Q?3/OKg6tiEYzvvnu8XIrIvNB+dsmXVWDyCl6S+nVqoE87qQ+yz9O0LaeyCTga?=
 =?us-ascii?Q?iVk6cYDsCL8wpR7wMKt49h6p7QfEHm2oCEo/XR+xl62N27Hl7u8GmRRzVeEL?=
 =?us-ascii?Q?ZkAzT54bVkxDeBjMLhCB8uj2BJrl2NdO/2rQjcAVFeOFQaqYII1FcbKFCVwT?=
 =?us-ascii?Q?E+fmJAXQ/VM63eyuQbidG9AckR/aJKO+mYaWOdqW9durXWgIaXgadEPcdZcz?=
 =?us-ascii?Q?R4M1HLeES8CCKGNx7LWZaTB5wWSLxx88vyKEzBjbp5lZeDE2WMPfuSQ0/O4o?=
 =?us-ascii?Q?RD+F8s4tnfNWbDOoj7wkt6FpYhRHnc0pdc6Y6VGoB4iESVziytVvTZpGcYFc?=
 =?us-ascii?Q?Jan+U+/Vd98cCK7WYOJaDnL7/oI+2NTMEmdrZrnGcMR07W7r1GdGD0DXX+5j?=
 =?us-ascii?Q?6NqSYnBrub5a8dbg0UQnhTgDBjWHwvmaXdklv4cBtleQ9IGkJISoe/sy+D1x?=
 =?us-ascii?Q?5y3eb0C+oilSS+r5L2vFiLoQL8AnrpTD3yhDRd1ErnzjPAEweXYMXgp3dzJG?=
 =?us-ascii?Q?V7QltnRMwFa+ynh4ugV3PUH5cJypm5sjbDSv5UtP7Lr1aPWh2Qt/UzBmDHsN?=
 =?us-ascii?Q?lBL3+iTiTR9rwFXjWqrfkQtw3VuZt9ovI0/RkLkbLihFYDjf3SbLthEjFlGQ?=
 =?us-ascii?Q?7TZzfQEUkVfEPHuWtVILUqDJqmMzbMU5dSl6PyPrzmNVSE4z6sRxeybDJidg?=
 =?us-ascii?Q?rUMYmaCZxdLZj1ljPUy6dRCmTHmEE2JV7Q1C30eJ3kApQiDJOGNLrk7S1fDR?=
 =?us-ascii?Q?S8g+32KccUuiLm3xhSezWsg7FDPUU8MAGKIigTNtU2nAhRIgczxJyg/6a9Gl?=
 =?us-ascii?Q?OKpFd50JxQ6R4rj3Pm8qrUauQgnb+HFW/LtCID1L8A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AM12P3qKTOS03L3oxaMND8sqfMPsZTvcnhiW9/jYXh5cLF9HD7AufwU3Jp2S?=
 =?us-ascii?Q?Y1POGoc8hW08xT5+0EjAMNKu5iEfUk48VmkfB/mUb35QyeARr7Qtx5wnuOcK?=
 =?us-ascii?Q?p30W9W1jAEq/reUX8tlX/VPkDC46dT5H4p0y8BX+pq2k+iQ8p9WCpyxIiZaD?=
 =?us-ascii?Q?A2+Lva/fbYVe9Y5B/kvja0o9wFkkWFMiv2KfyKwuVtP1/fSOoaBjpS7rTlID?=
 =?us-ascii?Q?zLo8F8PHXClL6xVTbw5OWqWvLCTWGenawT3ExFU+ro9+PGdpN684rrVFjBp+?=
 =?us-ascii?Q?hi4PBzrRw6xkwAEORgnK/1u+mIrsBUWs1+5QyBosO2flOgqgC4zcCBworcUZ?=
 =?us-ascii?Q?08Ab0hsjzmNR6MGyxe4dsvmzyEhSrx+1ixrQ2tzcBt0hc7wGK/WDeJYU3dPp?=
 =?us-ascii?Q?N8S2TUm6n18FBxTZDlEzFcanhXxpsFwmr0pFo5rqhL7wMaPTLrewWnnfraJn?=
 =?us-ascii?Q?c8vY1i3Tls5EvffGnej9miXGm0jSdZ324tiSsSLBpJdQoMa0quM7pD86CClQ?=
 =?us-ascii?Q?Qfxzr0kQkLZXBag3j2vN7PP3LUQfdjZfHAgFxxLIriNoVvohBVL3JU+SRQZ3?=
 =?us-ascii?Q?RiYNcocPDSU7LdF9rRNT6NucmJWtWdA1SKTe7wL406yfBC08arSYTU9SBRiN?=
 =?us-ascii?Q?XMOGu17b17z0i0X5rram9NmPabrK8MMSghKBPVCDfJNKD8e4jzoVF5S5Xpic?=
 =?us-ascii?Q?mv8juK/GDqr68vTkSC0TcXH2RZxvSC4hqm/8VXUiv5EX73Cjt+IRtLP93ynG?=
 =?us-ascii?Q?eH6fqdnTJs7Kwfsma5Nd8/hydCCyic9FtEI5ZAjj3g36wVOBFqDHsNYSca7u?=
 =?us-ascii?Q?bnQgTBu3o3twgwj5PEWYRzz0WRZ185IKqn8dWQAAtb+IG7+a4rujs2QTgP60?=
 =?us-ascii?Q?aq2WoU093k2Q1N8b0v8C0wdFDFPNrvkxy7Mawf48MBM7nKO+QD1FCEWw3NQA?=
 =?us-ascii?Q?su2G/H6QCYAV9HvTcPKFxevXKCTxp1qv8bHgU7ggFANhytbJxOyajbzc10x2?=
 =?us-ascii?Q?tC+Ewf+G5mTA+ph4VGob7x9R/o2FVdZIXg9OqGrK8GcVVKKel85/7fwr1uws?=
 =?us-ascii?Q?GnYGuSUZgvFf2DTrw5G3bmU8ATUSLjzUNBVOKKn8elo5Rc7gycIoAM+92hN+?=
 =?us-ascii?Q?LtXyxdPwOkZ/8MYWwxpD4kxa53+6JgHTxKggwIhj2Bp2tihVX7sWtsesFfOJ?=
 =?us-ascii?Q?zi0mWCUePZ9etkhOz8iiTXT2ztZd57w0ySreiQTBQYVVx34/wbn4q+BpUHDz?=
 =?us-ascii?Q?2nm5XsA7UpHUR2T62nRB7mBcWUZqqhGPZbUsuWsmD54aQ0KAJDAqXj2xkt7C?=
 =?us-ascii?Q?diiFGzDVHiW1YIMMIGdFyOmj2HC2ZxgE71HEgYkyFCOSes9+zjeVpDUtUNzp?=
 =?us-ascii?Q?bK8Llf/m6V8R5RZSj/ENoT90nCgyznxpBXmo2Qmgx5wvSIZzFIFd4oBwTOG+?=
 =?us-ascii?Q?eEXSnWtQ5pgc6edYl3sB3MNsH+1CJl/xyZ5whoiJStrwu679NrO5f4TNKz8B?=
 =?us-ascii?Q?8t7kBWBXPVVsYG8HbjJlJ2ZEkeKUdA3ILZXN5qnngkxgIiHF8VfXwm0pCPdc?=
 =?us-ascii?Q?4DV0Ts+xpkkoBlhZxMSBwOSbuI3Rfw3row4yBfyb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57594fd5-797b-43c2-5e04-08dc634b5287
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 04:10:33.9749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrXbKiuEcvtcxk830/FMX7CEKY7QcrmQyxJb3SLjmzG81rXh24AaLDPJwZAQw8ZVLE5Xcobii6Vgg9xD+ur3gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8668
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:
> > If CXL is solely managed by firmware (including HDM configuration and
> > event processing via firmware first) it is possible to run the system
> > without the CXL software loaded.  In this case no CXL callback will be
> > loaded and CXL CPER errors will not be processed at all.
> > 
> > In this case memory device and region (HPA) information is missing but
> > omitting the error completely is not friendly.  Some device information
> > is available the event.
> > 
> > Trace CXL CPER events if the CXL stack is not loaded.  A balance was
> > chosen to decode only the CPER header as this configuration is likely
> > rare.
> 
> I think the justification for this is weak and it pollutes the user ABI.

Do you want me to drop this patch or slim the tracepoint down even
further?

Looking at this again I feel like 

	54ce1927eb78 ("cxl/cper: Fix errant CPER prints for CXL events") 

Was a mistake.  PCI AER errors are both printed in
cper_estatus_print_section() and again printed/traced in pci_print_aer()

Why should CXL be any different?

Ira

