Return-Path: <linux-efi+bounces-5374-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 807D3C3DB61
	for <lists+linux-efi@lfdr.de>; Thu, 06 Nov 2025 23:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3B23B1CCD
	for <lists+linux-efi@lfdr.de>; Thu,  6 Nov 2025 22:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35FB34D911;
	Thu,  6 Nov 2025 22:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G8h9g+X0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62112E2EF9;
	Thu,  6 Nov 2025 22:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469936; cv=fail; b=VLx72tAglc3+L8LE1WVsy/szG4RbrkFP/W0u4G1yxT4lTPQCLg9j6jgp9Gx9SYOee6IcAX3Hv1iuVkC9MRTrT7yYC3tSEL0epKr0o500hCXYdDnsTm301AmSjHbm4/+YJQXdnloPXcGfGxsY5YdrKjTTFJGkznyB7YfF9aUb6UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469936; c=relaxed/simple;
	bh=CPtti0tl5n655mF7/wlzppij1TuCIQI/PKRM0zXR52o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D5ZVYWjta+z8y9Clo7kH2hjtFKclfw7P9/k0VQ/gqAwYOPnrrB9rFpP4xb4DSdQy/RkeBVAUjzOr2qVHoPb8zdmfgPhSDGVnV4NX9yRJKIwssnuWtj9Aft8pOTQoJAwxSp9tIb6R2D2+A+vrJcgSl0L4K+t7g2PyDfC8tBosMlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G8h9g+X0; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762469935; x=1794005935;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CPtti0tl5n655mF7/wlzppij1TuCIQI/PKRM0zXR52o=;
  b=G8h9g+X05psLET2ad+hpvIYlz5OgO2olh4Ct/vBCXfLnr/roQhF3iHW/
   bwWtt1JedP1LbTqoz9acS1QejKUoFTS+GBJY0jtPcNS3zvEeCS2a6HcxC
   1YvpvRSF7H+8ewhXYX6zEhIroHqrWOulvcdpTcpVKZOg2v5JVYaT82lf/
   DQSp0M3Bel1v2kfJZHK5qirY0Ab4ORaZrcbymdLTiSxzmfX5necHDShLt
   HV/D6AR+fLPgebfPiXX/tcb6PaSVYb7v+fnviLzORRSKPGpas5j1Fqh6u
   Hin9KXHeImaxDLn39E9ywW/KXfhydQapLvN3PLyZioVPGsyiD5R/IT+Ul
   A==;
X-CSE-ConnectionGUID: TmkxK2F+TwiJzbEP6aRt9Q==
X-CSE-MsgGUID: vPkE2qawQam8BJxUvcHVjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="75309026"
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="75309026"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 14:58:54 -0800
X-CSE-ConnectionGUID: //K5qGMeSuGR6ZOgBaYStg==
X-CSE-MsgGUID: CYxmjywXTWawDHM2heOPGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="187606838"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 14:58:54 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 14:58:53 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 14:58:53 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.48) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 14:58:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgCio7ME5P6V/clYtSqn2F5ao+eGoEwCgtQHMniB2az3wrnwoz5No1os2fEPsqhr5v36F2X9m9PDkwrd2kllMzfzGwhymVQ4bH+ckrI4ccLCQm8rwUTbSFdQMffpHMugDtRg4eDHNNZrcSDO9zGY0kWVOawW6jFUTJl0WwpZCdag8pEhMaCoDrFR/M8d+ZMOxlVLrLs1jdsF83PcEG2SfuQGzEn/jWdsLSfOe4xP12ZPI3wrJ4Myd7BKi4X8gWK43DH+70htGushwHOlMQtuVjcXR+H2dtsSupKAYwmS2zQFgPzU1AcsfHB1MmEpq3cZl2Q7i4W3j04sSSjID7uaOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWq8Gt1gdmyqph8T0WiA/S9Umoo7XHlpYQ3Dhx4Zw+8=;
 b=hZVRxZbWz/NE20dVUzQWDfkfrMMEM5RDjSOO5t5VE6JMDSOd7Z7VJb6jBEdhhS8l5d0ls14rPBoMDA9px6Fg4o2V0iyWF37sgowdj+7gMiAMgpru/2YiAbV/LrLcSOM4cGICEI0q1E39MCR8HOzKfby2nCE2XKKQpNiDkjddy1ufBmkYTmohPIBizoN+bTOCc1lihmlUWDRs0U7TtXRovN4XID7cKq56PJeYaQ1rEfMXk9lcEZ93Kr3YpZyXlABWoDsDZpjZHdf+9aIHrVC7ZYQPcJ6r4KqZBI0zeSc1aUlcS6BVznWTwA++B91tbGkT88tkdbHHSULAFS1PW0TlHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Thu, 6 Nov
 2025 22:58:51 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 22:58:51 +0000
Date: Fri, 7 Nov 2025 06:58:42 +0800
From: Philip Li <philip.li@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Dan Carpenter <dan.carpenter@linaro.org>, <oe-kbuild@lists.linux.dev>,
	Francesco Pompo <francescopompo2@gmail.com>, <lkp@intel.com>,
	<oe-kbuild-all@lists.linux.dev>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] efistub/smbios: Add fallback for SMBIOS record lookup
Message-ID: <aQ0oIi6idr6z9IAr@rli9-mobl>
References: <20251102001411.108385-1-francescopompo2@gmail.com>
 <68a428fd-aad8-4540-a509-d33ba116b5b9@suswa.mountain>
 <CAMj1kXHZioMA21NM_Ddg+U0siyxzTkGWjYiY_jUNP=QXvu1jdw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMj1kXHZioMA21NM_Ddg+U0siyxzTkGWjYiY_jUNP=QXvu1jdw@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|IA1PR11MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c6af57-5f1a-47a7-a37b-08de1d880d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0YiB06iwYEnCuhJeJXsTRTbPop0DjaQeCS34RUqhd8B1SbMFY28HNv7F8VOV?=
 =?us-ascii?Q?89ASkctobPA4CH2G+OuXWMttywMjrrGFk31pzeNoSPkKLsXFxuKuWYaeyZ75?=
 =?us-ascii?Q?dklPGDx6nJwdEB39WmkxTRvh3UKgSDiJMEowOduxfhaOY0og24N5N+XF/1U6?=
 =?us-ascii?Q?XpStE5sSaOn81iEx1+ZeD5adCbQiyCjgM/5E6QTfxdO4JjG2XyfboXLLHbBm?=
 =?us-ascii?Q?8TrrHxS2/pm57fufbD8oPpLSP5+3cL+QDa81gjRFaoYrMPUcGPVrMN/pkbgu?=
 =?us-ascii?Q?BIPWi9/AnreeJP5ngX+6N2dMQp+NMGEVRBspQ6gzV4WgLsq67mlGyou8uiDV?=
 =?us-ascii?Q?yCWy7izurLikt2yU0D/cWlw1PyZve9B6ydxszWMA+JU7TRsezAnXHj3CC2PO?=
 =?us-ascii?Q?xVOdxztDMrchljiuBsU5cYSVwyTDl7e7+VWF9tsnjHtzywt5XdO1Jd5gONxq?=
 =?us-ascii?Q?wwYgyKHA0suoi3oX8Vy9Et0j4OMgVBzhzzhb4GFAB3D+xFTJW2hf3f/jz1vq?=
 =?us-ascii?Q?+1i+VDlbw6pjAsql9Vkn+OvpaPpSynlQa2YKs6ssZfbO8RGiiqHxYdTc8Nqp?=
 =?us-ascii?Q?wsL2zV9gUKZq3vAX4lSD0SPSBMn9UeQUHXZtv+XjT779LGarroekdyKxrffN?=
 =?us-ascii?Q?FPGgceP+5xAv1FunghMu5jcXxOy3o4c+gMN54/p5xsxP9qDv1tt9uDHNiv4o?=
 =?us-ascii?Q?YetC6VshbA9jo7IKiUAqWfZdwFGQs8crFPCr1iRXUnZxCrKmy8IXOtv8WwQc?=
 =?us-ascii?Q?dsUd18mlfocOC/cxY389BcWAzdf2J9vrX9oAbunmmskFbEeTuqAUpcdzh/p8?=
 =?us-ascii?Q?F1mdDjQIC60Ce0jo5OexX1DUWzJDtZ9MGkhuzUp9YZRclQqqlKzWYKtVMXy1?=
 =?us-ascii?Q?JUsvD1bAcjwXSOvWUv88+oqTKwjpIVujXAwMhPTBI5ggnGiQiaOU4jtpue3V?=
 =?us-ascii?Q?fT1+LA2N8gDXsZTD9aHalH1eDCHNw7h2HGnDheKjFvshISXFHLycppbyeugR?=
 =?us-ascii?Q?7j8DoZKzO3SlxhW1jkNPtoqa6wNSjA+BN85zMnRTaIc4BqOToMiQ7EnKogaH?=
 =?us-ascii?Q?pilRP51y8+pFeUjyDOqceCKzNtPljfVvbBA5+1CbH/L13zZDzbJ48dOTdtNr?=
 =?us-ascii?Q?2gVDnsiI2A7FGxVEItZhJzvPxQOiJSRHf1WQZu+7jR+1Dhw9xqYc0VMw1c39?=
 =?us-ascii?Q?hrQheQf76OHjbksPQb6V1tfkHEmfggdBPR5x9zs2fdFipoqqrPIM6F6KOutm?=
 =?us-ascii?Q?Bzmt7sou+DJD87M6QOPM8f75nnnxc6QNb0ZhbLENOrw9gfithdhel4i/J1tL?=
 =?us-ascii?Q?DpPPkV6XUN9IIZ2Dh0nGRRuiX6H+qpWEzq94Rmf6Hxh5DGaEEEI8m6DAEJ1D?=
 =?us-ascii?Q?EJr1P8vkfoHXAFINXUfOQqB3Czal+Rhb4GZqkUuhLZpFOdlslEvDxLWCCZg9?=
 =?us-ascii?Q?td7EIS6QOJ5JcFk4S74dbl/xuoTlzMfAOr5NaMeDYAAEKM7gEb8I1A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7pny5zQavwMYYS+QpyewH0DTEfrE+kKN10+AzFzm1DvbW2EB4KRpwxDzBABR?=
 =?us-ascii?Q?5Xth3nuxYlKtK7GkVXPXwa+yQqQPufbGHo4/+rAohNYTLPwBADtSM3oqf9rd?=
 =?us-ascii?Q?CyDgE80uaGVasH00SiE5edpFaV+qeSrEd9QrbDHcWGWCi0yw+TdoHgoRBqpP?=
 =?us-ascii?Q?b+azbrZXS2k4GoGbiaiULHtBrJAh3V2mHWfhGOKNmAGtZxt4xv8KUoTjLiqg?=
 =?us-ascii?Q?HUPxlJuFJZ0hFvfnsQBXo7QoyFgdjACLzOxkca0odXeWrs5KWg2qehtVtYhr?=
 =?us-ascii?Q?zB0FXGCh7ovewVKDi3uA88vPLwgJU8pynPJ6y04vH6PhKJdYlV0TOCHLvkTj?=
 =?us-ascii?Q?G/m80gYamcwPJ5jBaBifz5vsXDTLHF8Nl36+CNZ3D7p/xaohakC9JdoQYIK8?=
 =?us-ascii?Q?ID2xN/tBiFc27/NqrnmYj1lFI1WwqqEN86pVJJ5wx7gsi8YowWcD8cCiOvVE?=
 =?us-ascii?Q?hZfWQTzKmKkcsDOYMnMLlKzcAWuDfH88csZQ/rxknwd/z0pGYvAQQueo/2zV?=
 =?us-ascii?Q?QomUwXr+OAKMLju+sthPnhanXeuOqgDa0gtKtzd0qKdpzsKa2bK00wgv8sGE?=
 =?us-ascii?Q?Y1ay80wB8GMgaLAsBPD4nkBOaeuSByfRTqt+l56jpF8hWeHPcb+nTYqga42N?=
 =?us-ascii?Q?2TZkBUjqcu467WyWGjCxjtDE7r43G8HIOJUqw8Z8jyyiszvCJc8mI/nfS9pp?=
 =?us-ascii?Q?PKpE2Kb2ofQdPQHGqx9izrHrh+rhzHS14wfoZOVg6/ra2ABiuAEIZfHKdbPA?=
 =?us-ascii?Q?p9WjAzSTMB5mbNUcEUGK7XmjolMHLJ8rhV/2ANcqqKgVPgEKohpUjd2X3qt1?=
 =?us-ascii?Q?Y1Eq9ozyz25Ul3FhNTcUmHpOZ+s0KKJsU+pnRI5U4dY6kaAIoIuKYCX+Pxrs?=
 =?us-ascii?Q?rPPM4ds/aLB3moBBRFwHaB2i6F7n05qL853izkZtzhsWbD7ymuaUeZXZ2hsJ?=
 =?us-ascii?Q?1ENwtZDULM7P+14f+c6iaVsppDvAfPGEajc3iQcUYwoK7Kx+L8ngvzWIFwDi?=
 =?us-ascii?Q?P1o8j1ePdUUsLiSHBCWuXdxmymGwPOWdb8ZxHjqf5KUh0B4Kd8CC8vGRJ0aG?=
 =?us-ascii?Q?YdEfyh/Hq/TGqhtVdg79WUHsFT7U1m98350qdHQOXB5N6FvP3JwQeUZe/igH?=
 =?us-ascii?Q?mnddtaKyE8e5AGxvQeqalRt6aX34bATiYS2aiOZM4xlsxOshdMYgITCKZVeh?=
 =?us-ascii?Q?wqqpjaJ5yT3fCp+BVXfW7D3cCaoOOajiuV1TjQOwtZdD49mYfkNR6RM2N/WP?=
 =?us-ascii?Q?BJz+/bR1Oezf/t4lR9tPchpq+lBeUttvorzQ4hnnNO+UkpuJdHEgZmut3jz2?=
 =?us-ascii?Q?5zcPbcuiVmUDPICUT9RKPsOxzvgBfydk8c8pBm+KUnGq1i1kKhtPYaPkKpRO?=
 =?us-ascii?Q?Cmzm7cgNbrW8/fY4zVh0zmDmaONIHcLAyovFR3BcYC6UzTfV4iBf7RzIGoeO?=
 =?us-ascii?Q?3U0somC8wKL8Pizm/UcKjnt31ZA1lbkB+ycFFvz1epnYDpZYvIwO3OrjFJed?=
 =?us-ascii?Q?ApMBfzlk8G+hR5XKg4kdl0ynORnC4LsSpAIvMxYikN8YjPzyp5nk1utnSv0h?=
 =?us-ascii?Q?nRTJUtsZIA8nkZFI78QG45/ZOJOGqh0kQmDFXo34?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c6af57-5f1a-47a7-a37b-08de1d880d3d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 22:58:51.1262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BCGDIgP2APgJvx4/RUAQ13DtM5Tz6B0Sgb3+qon95DuJO0AvJObSl92cVAXytm3tBX3dURM1wx6WqTxHcoQMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6097
X-OriginatorOrg: intel.com

On Thu, Nov 06, 2025 at 06:50:12PM +0100, Ard Biesheuvel wrote:
> Hi Dan,
> 
> On Thu, 6 Nov 2025 at 14:08, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > Hi Francesco,
> >
> > kernel test robot noticed the following build warnings:
> >
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Francesco-Pompo/efistub-smbios-Add-fallback-for-SMBIOS-record-lookup/20251102-081803
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
> > patch link:    https://lore.kernel.org/r/20251102001411.108385-1-francescopompo2%40gmail.com
> > patch subject: [PATCH] efistub/smbios: Add fallback for SMBIOS record lookup
> > config: i386-randconfig-141-20251103 (https://download.01.org/0day-ci/archive/20251104/202511040131.8yGeRa6u-lkp@intel.com/config)
> > compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > | Closes: https://lore.kernel.org/r/202511040131.8yGeRa6u-lkp@intel.com/
> >
> > smatch warnings:
> > drivers/firmware/efi/libstub/smbios.c:55 verify_ep_int_checksum() error: buffer overflow 'ptr' 5 <= 14
> >
> > vim +/ptr +55 drivers/firmware/efi/libstub/smbios.c
> >
> > d45578057224c4 Francesco Pompo 2025-11-02  48  static bool verify_ep_int_checksum(const struct smbios_entry_point *ep)
> > d45578057224c4 Francesco Pompo 2025-11-02  49  {
> > d45578057224c4 Francesco Pompo 2025-11-02  50   const u8 *ptr = (u8 *)&ep->int_anchor;
> > d45578057224c4 Francesco Pompo 2025-11-02  51   u8 sum = 0;
> > d45578057224c4 Francesco Pompo 2025-11-02  52   int i;
> > d45578057224c4 Francesco Pompo 2025-11-02  53
> > d45578057224c4 Francesco Pompo 2025-11-02  54   for (i = 0; i < 15; i++)
> > d45578057224c4 Francesco Pompo 2025-11-02 @55           sum += ptr[i];
> >
> > This loop reads across a bunch of struct members.  We would normally
> > use a struct_group() to say that all the struct members are grouped
> > together.
> >
> > d45578057224c4 Francesco Pompo 2025-11-02  56
> > d45578057224c4 Francesco Pompo 2025-11-02  57   return sum == 0;
> > d45578057224c4 Francesco Pompo 2025-11-02  58  }
> >
> 
> Please report issues against the version of the patch that is actually
> in -next, rather than random versions from the mailing list.

Sorry for this, this is the bot issue, that i will update bot to try to filter
out such patches from mailing list to avoid testing them.

> 

