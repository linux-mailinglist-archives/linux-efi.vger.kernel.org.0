Return-Path: <linux-efi+bounces-961-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E84568ADB07
	for <lists+linux-efi@lfdr.de>; Tue, 23 Apr 2024 02:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3692856B1
	for <lists+linux-efi@lfdr.de>; Tue, 23 Apr 2024 00:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5919C18032;
	Tue, 23 Apr 2024 00:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bV67B3rV"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3C123B1;
	Tue, 23 Apr 2024 00:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713831380; cv=fail; b=lAiWEfdDt+oFB/hTvJRN1u7eJ5BMH6yFfl8Pr5fSDB/cMunLyPD3N3ZXogqi8IM8txeIh+c0Ht+HIiGL5V8GBVxpDZljSfcBZr8qn+imD3SJOcoBN7ReQkQb6y+umCCbreRfqZUNaVUrG1sZPC0plGz6XsrbvYBuh/8VgQaWxmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713831380; c=relaxed/simple;
	bh=d9J5qa3gdwhEIulk7Oh4Lr+s9OLOXFEQ9qwep9AT4Iw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y3Lv9v4ViimdtCn5YOOHNa2m9QB52PEEhvbCXN09CFS78EP3uYOmVlneeifpKYDej3HhhMi+Yk/o6jCt2ozb/DPB4xjyoTLjLBuS2vILwBaK3lAPJ/xhuuxLE+hgJ3+KjEFeYRIx9hnLotvtAELpnEXq3AFQpbnrIS8K9MNBRVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bV67B3rV; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713831378; x=1745367378;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=d9J5qa3gdwhEIulk7Oh4Lr+s9OLOXFEQ9qwep9AT4Iw=;
  b=bV67B3rVhSRLCMAlNodFMd+s8f7bY35aZKSZf8v0xd/zNAz2b/ITwlTW
   4M8OqdQVUK+k9zq618Z6vWRtRrV8cPaxFMy9smVfzcW27aOXFmwVJFXJC
   iFuh0rxymkvZxkV9QE3438ElSXDLfEj1pJm+LAVe4flO4F77/OBddFcf9
   U/WPjR4CD4n9x7q57Pef+tpc/AofJWkjcwSBAAXbdI9ObzozKF09Xl8NU
   nKAG94vRk/J/mieEZ+w9MQS9Sx75EHAKL19u1yx2My9axKTgHtIwsBw/d
   KtWa6SoMblyFbrurElACEhEEjln+TCCD714jANEHhx1iO9s+uFchNloyy
   g==;
X-CSE-ConnectionGUID: aCz5NmiTQyC8RTNOvtqvEA==
X-CSE-MsgGUID: Qr4Tw725Rsevfd3rbQ5Y+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9936905"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9936905"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 17:16:14 -0700
X-CSE-ConnectionGUID: 9e6AlsFxT2iw3SJAxFaI9w==
X-CSE-MsgGUID: C9ru4f1KQJ++mG6EM3PIng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24690040"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 17:16:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 17:16:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 17:16:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 17:16:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKJ/s1hDtsl82mtka0XsoyLzO9pfgZuW365g38N/zqHHHmHXTXeeScngit0h5B+UPsUugKGzuNROA5vSITlG4jA5/OcYR35uXTN1miMakbHNjfIWTnKa8kdoWE7GasCHYhgPtSICz+i785kSb14fczgYKCsESi8Bri71W91Y67S9QIZx1Ajp8MH6fRP29D+qiwTbxpQlqUufMWNwKOcmvrwCG8zd0yMRYtu2dkzasLRuSuay8v+aHG+gYQgortXAsoawe9DCmG7ubJPVZx6/6w+OT8bBaZ/XmYRnfn8av6dFBdW+YaslQfuvM91QQHDw2WZbJnmXYNiR1ztb8nuKnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnDYEplKJGBIl+rD9MSg2aLAodGdMxH5PHu95z8dTXk=;
 b=YuMH977HnUqgzbVJn203xF8Bj7ud6jmlHvi+WGCKxS8X2jzcKmoOxMiiZZpH7dWxjffx2eThCoUzBUfU6viCltqihFr1dkz7/4i/xsUrzoKQl0sgqfamlqKn6bZdm9QlzfSMx7oEiRFzU04YGJr0LO4BeLeengNZNkCgm4aNeuniB31uE9U8EJObQ2WBXxknOGhJqUyNSxeb5I4d/JqN9OnFffsb5v4lFwbfh1d56r80LzNd5W8Wn15J5sTTsQE6v0JPQRxsteGohRsZeOjZeKy9HW9/IFx0XGdnAc5MV1+Tq1xwc1BG5rAxheykhTZrYrut3wxsYYqcbj6CEvFTBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6357.namprd11.prod.outlook.com (2603:10b6:8:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Tue, 23 Apr
 2024 00:16:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 23 Apr 2024
 00:16:10 +0000
Date: Mon, 22 Apr 2024 17:16:07 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Jonathan Cameron
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
Message-ID: <6626fdc7b7e31_690a294a6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240422-cxl-cper3-v2-0-5cdd378fcd0b@intel.com>
 <20240422-cxl-cper3-v2-3-5cdd378fcd0b@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240422-cxl-cper3-v2-3-5cdd378fcd0b@intel.com>
X-ClientProxiedBy: BY5PR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::45) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: f42f7b13-f3f6-4dec-753d-08dc632a941c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ykLluWBnT4JiqL8TC8YFVPaozPD8HWHwJetL7mDpuu6p1C/ycJDZ7Bv+vJmC?=
 =?us-ascii?Q?l+UsrHfMdSysw7HzHD5d+OEllrYmoLp4ZVbtEILJkyDOMnNtqRDnp67cgUQS?=
 =?us-ascii?Q?05wmdZl/9kgYQ6HCEa+w3dDBsrvSbvZYc3LYzglHdaELt2UbampKlY7zOoc6?=
 =?us-ascii?Q?Hszg2IXIoXcPcRL2BHWWA8Abl7BRzBpK9F7OyLoVxPrCUJIVY+REZ3lILOAP?=
 =?us-ascii?Q?JmtKpuz/W4Ruvf7LcDxcTg3viv4ClRceG7ubt2XEykzcI4LtLSbrkJomJwDu?=
 =?us-ascii?Q?sjhyr94j58Mk3ualtP+ZU1gdxDx1tyChmDlnlY7R2WktgtmwZGGrUo+2j3rw?=
 =?us-ascii?Q?av5zYfqX6jR1chRg9tnP2XKadC5v9TIP0qF/a9YwDuyyQ46zFt0JeUxsGWp5?=
 =?us-ascii?Q?fiAOmeZ3Jx5dLfmtQC8f9yql/rqI+srH5YB2x8AELFWzhWtnLohy3/LTbk6a?=
 =?us-ascii?Q?tF/c+t8sdBbVXOgwNclMhtBsNPTbA1WogYUUiTPXlKo7O5s5+C/xSvu4wP86?=
 =?us-ascii?Q?KrE+UNjCHfv62BXpbM/IvvfOZs363iCeSgR8ZnEXtUvlwkj9tulFfIQj6fQt?=
 =?us-ascii?Q?V4nIwPwXXJSJXT7XuvzOeoK+Fiu3+0KdTXhZyDJGmG3Px3DIk+t+ihrlIh+v?=
 =?us-ascii?Q?cN7+7hDfwFN8xeiYdu7uwtP+tlTz5xx9rTJhNOCzH6jyGh19hz1FLTDwi7dc?=
 =?us-ascii?Q?mJhyiz8Vf9RLO03rve9cOU20TSVQGM7SkinOo2OEovJ1bVjthJm87h/U6lvg?=
 =?us-ascii?Q?VY+yeIBoHVqJXywPBqJthlflIaW8BTeWuVoo23adXSqsulnpT9ubNiCjwAZL?=
 =?us-ascii?Q?6BOPpjFhkqbQotCfEpEvwwaZEzgWtPQ9RTmwH+824KYXokXhOpgEz9kAYrly?=
 =?us-ascii?Q?3w75vB626Sq7sG1MpLICSZ7etTZRiu0LmzArtlUAr/bDaATgnDkbCzv8bvck?=
 =?us-ascii?Q?H7AaH2fh7XDsEDVEsu1/JNmQiZhXTttrtOOcmkavWda+Auoec9oVcIN1DgOQ?=
 =?us-ascii?Q?GuZMdrfZJMkl2v3VW5j3/Dcx6VZ5OJAg+pVO6IjNlYxEK9GpESl6c/C3QKFu?=
 =?us-ascii?Q?ys3VaAkpdEs7zj8XzlYATKBpzoBz1VmedWD7hkf03+NY0gCTSeFBXGSU9RHv?=
 =?us-ascii?Q?SQpfmFTUvlQCWuMAGOPij/MZqoQ+nDqvjjdOLQmbUFC2G9h+kNEbry9kyyZG?=
 =?us-ascii?Q?JYhfbakS4rRG55gCxM1lw9PQBCh/yZwtWFVnVKMdhHYb1ENxjsD97MEwWhuI?=
 =?us-ascii?Q?I9aN1x1qHlV23cxdHHfp9NgjMrwEozLMDGnEWFu6jA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nDdjVqjBFj8ebia1gXUQWRbPKeLS2OJosivMgTZXoicm6g3emh0hPjdqIGfQ?=
 =?us-ascii?Q?hUTWSQBEZWnRhT1nlbiqcMneomKxTpZ+CzVgcO9gIt+5740oLBGC1kesjuGc?=
 =?us-ascii?Q?hMX4m2WzOt0VwfO0z49tPiN8o0CS49WsmSojxUQzNVPAVQjNRgT/2CaGURL3?=
 =?us-ascii?Q?Jf9fFNlXgTQ2SiqNpekNKJTLQiZ6q7hiy1AMmXV5+ZPQ6aOyTYmajt17l3nq?=
 =?us-ascii?Q?eqeVwxHG/ePpbakEeKf8OPXAAVhE+cSABLoge+WU4yTeJ3awOe3TIcwUMeLn?=
 =?us-ascii?Q?nQ/gcquI+1kR9m4o0feNjj1T7Febfxk+1cgOk6c5xwzrZ5necqbmMRrOaHbr?=
 =?us-ascii?Q?zz+IZJAaSmF+c8byTet+ts2HS1XZObVuhhZXc7FrRqtnEp71qHGaX3+DLo0H?=
 =?us-ascii?Q?8MwcSe9VWz+NoGl9cgzy7RYUCjvhhgVrZA1S1/F0KzG5buTlIop7ZRE/6SU+?=
 =?us-ascii?Q?LqgOgh6v8RM3tEjXmRZnIwr1YyP6Ztus7s54lZph+feecipYwlwr6JYnhcCA?=
 =?us-ascii?Q?PdyO+SjWWGrP32cs3wLc5zyCkpn02QxnFZM5auWiWzFbXT9ZjRvhju7oi9ZR?=
 =?us-ascii?Q?oOptVFQ7VzooCBgI/iLbZUSChQBPetEe/OHBioGimn/M4pwC2llCLdQoN/Ae?=
 =?us-ascii?Q?ar52tcAuvWuURudIHUuE75cGIKrQdFHyeQyRGjJl9jdk1kHKd4qqL2oNrQp2?=
 =?us-ascii?Q?rXsNKzgq0InlHt+X1fJZtWxWgjO/nmZ37R1EdSrA1TUyiuQHzKCOX8qNZch2?=
 =?us-ascii?Q?VLgabRDcVUJklAv9I7fSuWiFA5wAA/GKcD2NzAIDYzk7y5J4CqHLeHgtYcqn?=
 =?us-ascii?Q?rRjrAo+bEh1ujX7urVt9vVytGJ5d2bzAlIrOYD4wPqo3Je3cHE6i98J4yvCc?=
 =?us-ascii?Q?QonPOUMsllkFIkrjdOLC07R4GQjiTX6yrGgQFhJmepKm3X8UOnheh5X3+2nG?=
 =?us-ascii?Q?UgmuIXT3AxNH398dMmZtoFGTkrXV/Ao2NoPEy67z+OIENgbzef7BydH6gG4T?=
 =?us-ascii?Q?qqxwm+E+F1hnLTM/61kAGjCgH/sv28ADJSuaLQoqb/dlr0s2F75Vvo0PS4zg?=
 =?us-ascii?Q?jtHe5TQ47QreByYG/JvRW+gIGt2NiEWiU40HilhZvA10us5hxOET4nloixkI?=
 =?us-ascii?Q?LeZAV1JcgginV/4wQjRzkXkutqXVG6DmkhOzScCoSwfP7q4go2YrxtYphX6E?=
 =?us-ascii?Q?BEvC66aMOW/btjiomyAD3tj6A8Wee2JnW/G8ubFsGazVImYlL9B/jMyAg4T3?=
 =?us-ascii?Q?W9/XZIQm1JcxZ4rBWxmUJastJyjkcyQzZb0/DC8s0z+gQQynjw0Ps2nNjrEs?=
 =?us-ascii?Q?HWMgv6BEwyG07dF5YC1eGQ1/WCPOhgDaRIqXWBlLlnirbNfO8vvOB5OjHxAX?=
 =?us-ascii?Q?1fg99r9eZsJG052Ugkn58JhKZ+ASouUiJ/86VitkJDw0mZoc21IZZjFomeCW?=
 =?us-ascii?Q?JbCG9xEZ/VUKechJzBtKE4zsSYv+QRDAKwWniRKoTzOnos7ylVzraBFYrcau?=
 =?us-ascii?Q?3yqSAAFM0erezfoMKVtx4cyR0+UCS6D7VvA4hjZ37dJ+HBpGEy9pevBMdC6v?=
 =?us-ascii?Q?NLvvvjSaRXHXW1KTddDnXQJ3IIHhSyIixvuMge3s7+wWlSX6orvyEPTZP6dc?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f42f7b13-f3f6-4dec-753d-08dc632a941c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 00:16:10.5475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iac60r7ngFy5dsw05S+O++IOTqgA/2mBdUyhxRIkI4Iyc8LSpDbNAIYV4/KKzMt0h57U8WxZHgwMJ89TyyciMEyKjBO/5WN1nFbi3QQ9TOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6357
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> If CXL is solely managed by firmware (including HDM configuration and
> event processing via firmware first) it is possible to run the system
> without the CXL software loaded.  In this case no CXL callback will be
> loaded and CXL CPER errors will not be processed at all.
> 
> In this case memory device and region (HPA) information is missing but
> omitting the error completely is not friendly.  Some device information
> is available the event.
> 
> Trace CXL CPER events if the CXL stack is not loaded.  A balance was
> chosen to decode only the CPER header as this configuration is likely
> rare.

I think the justification for this is weak and it pollutes the user ABI.
What environment cares about CXL RAS without the CXL driver? If such a
use case ever pops up it is trivial to revive this otherwise saves
carrying this and all the minor maintenance overhead it causes.

