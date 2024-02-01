Return-Path: <linux-efi+bounces-450-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A1E845D10
	for <lists+linux-efi@lfdr.de>; Thu,  1 Feb 2024 17:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419B329ABE1
	for <lists+linux-efi@lfdr.de>; Thu,  1 Feb 2024 16:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A411615DBA1;
	Thu,  1 Feb 2024 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PL9muSyw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F827E118;
	Thu,  1 Feb 2024 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804217; cv=fail; b=gWBsn+jFywi/p7cqPoQgx+nfmcOqFNocOXNrvkKGQ8stEUbLosvWy/HsEu3Rq0vVl06eoTsoyNtiDH4nUMtC6jav2JPJrpYh6kMxtFjnQyUR8kUZlCq+ck8JXQO+PJBF9vHvDu8agPQeoMP1O48sE32J41wM4PwBKRaMOXEY7no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804217; c=relaxed/simple;
	bh=M81fzPMjLW8GJ9y16q028C2YZ43vBP3xt+foreww5K0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RBqfflcPIAC6i8AeAv6a+cc/dslIw5C+rTWOdeMOuXDK2uzEm5HyUDEX5NUjtVBihePVNwebHEwUYdBcptQiPmWRJjWGeRRkYL9h/RCH0hawMe1+uvrFR/DUJzUcvCSkV9mQbe6SUBAKPP+idHoHk/+jOqFgC0JyZj9CZONqa+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PL9muSyw; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706804215; x=1738340215;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M81fzPMjLW8GJ9y16q028C2YZ43vBP3xt+foreww5K0=;
  b=PL9muSywjsPmYSa3ngVMqORBSVzJYw7h5aupm2AnnFYZbXVoQx1Nbyl6
   vrv1dyjevaeu9MkoZYDDX/71A59m9MqAEL8VNpA6+/MK2KNdGzE7vk54r
   bmERY6yn1hx6HZNW3pnzNVx637iYHWBtjzK3norKKHKGr2+D9GOVZB2l6
   hFB6jQstKdRvksMAtvl5hrSvkFN3AOWhxbGjQuwuZoF+SVGaWWOFdDsFZ
   2estx3/IadDAHAyt9xBj5fT7LTRertBKNAN7NxboIJTWQUQtK5d9P0Uss
   93Un9vp5bHBV6AX9DbzpMNWs+LDfz7m28Sd40unq265evQa+4W4tQAP6y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407646894"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="407646894"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 08:16:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4445841"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 08:16:54 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 08:16:53 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 08:16:53 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 08:16:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oN2OBCmCSObbG5egpb+vqgJ9YGw4+yFoZjdUOhMJAoXAKveTho7Kt7kl9/H+NQGYzms8sn4qOu637ZfztjUeofWSXHLdSTlRoO+hvBB+cGJ5CFsF4MtvZ/NdTZZeenqMuq9l0F8mkOtnAPXj0kxHmiQajFFGaVsS5SJqCpU5XxkwivvJS4G3D0r1uTtX/vb+x4RKxyZ7YTItoiYS+IgBcvzwwEVhHultv1bIDF2vqyZxqUy8X9PykfUXbxrCaceDEl5AWOV7RfkyJKbIKaHw3VieK+bvCwtp/ZK1ToXAiPP4zXzlauqPkc/PrOkxY2fUd856dALvnsbwGmRCMU5/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4csDFnzMbz2mhPQjN2WvrxiuxxyHxQSxefHYCYm2W6Q=;
 b=ip8yNTqxNYF+r3kW00WNHtChuspLRx6XKkRZ2aSEilcUWpY9XZ2kGog8Ndqzuz1h36FPWvg7zl0OWaSg4zQOf+ybOYuRMxDNlZ7iULTHFtPBC9E11fo0cyP2GH35sM+02Y3KC0tkFSWLX5+s0JF5a4cQZ51HGts7HkKQShMLG08HCpchO04209zYnxeipwCL4MUS4PAbXlCoL7s5XqhntE0jvAQYIg/tgWrRR6SNYz8AoVhJBncMVbwYFsN/hbJK2eYs+a2OFAJcmCXPwAt9touVYtWzqawrWlA3+ffsdmoJBIMeHKdKf9LVxn72djmrWuNiKVDs36OE3xRSHPxYdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH7PR11MB7718.namprd11.prod.outlook.com (2603:10b6:510:2b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.28; Thu, 1 Feb
 2024 16:16:51 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::c403:9b0a:1267:d225]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::c403:9b0a:1267:d225%6]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 16:16:51 +0000
Message-ID: <e51824ae-ac3b-49d6-ab2d-add4c91c2c76@intel.com>
Date: Thu, 1 Feb 2024 09:16:49 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 2/2] cxl/trace: Remove unnecessary memcpy's
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
References: <20240131-cxl-cper-fixups-v1-0-335c85b1d77b@intel.com>
 <20240131-cxl-cper-fixups-v1-2-335c85b1d77b@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240131-cxl-cper-fixups-v1-2-335c85b1d77b@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0068.namprd05.prod.outlook.com
 (2603:10b6:a03:332::13) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH7PR11MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 178403f1-1704-40e5-3589-08dc23413308
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QEQPdot8qce3FrhZ1W606kn3pfVVKH7+HO+BFjRzpWMCqbmeSHdomTxXW+aEN1D76hoCySsWakf6p+fhNVf5iss8pWPpCJXZywoNWQSyRtsHRdtuCJC2SFwvmNinekuV7Y9jh0liEMcmNmOQQmxEApORSIwaCxaTXVsM6/LbeWxHEbSo7a1j6RwCh5ekB/EyL+chstrgYv2TOjaR2y1cCso9Rdd25iJAUXOFh8DivgOuh6KHau7dX+j8W2gXym/2vs13qakjiHasHJCB/0Q3mWs+lA8eUgSP1yuucQE/wS6kkzfdCC2l3NQmrFW6FMv/qElzPYLEwOKMtC5zGB3fU8Nv3BNPoEqlh3CoIck94QHeJNlzJfTZxBXmPGcTV2WgESGVqrE3gHeC6GNBZJtGvEfWO6VcEGnG61Ra9ycS93MJs/a6OYH/54V6XC0gGAhxWbyXN2rm9ZmqfPMr03JFEBVS9ZVEjY7TCkmTPoGiQfhDwkCTdQstR+4Ar2QilXtpbv64L2LKv91qjLUjPbsU+Gu7cigCHHpSt8wi15kfJXzY0wvFbJwbHlCfOd7rBnltkZTxzA+ga0dvIDDyimlfShdb1a6yiD9KN8PDUT7c63U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(26005)(41300700001)(2616005)(31686004)(6486002)(966005)(36756003)(478600001)(53546011)(6512007)(6506007)(83380400001)(82960400001)(38100700002)(86362001)(2906002)(31696002)(5660300002)(66946007)(316002)(54906003)(66556008)(66476007)(110136005)(8936002)(8676002)(4326008)(44832011)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1JYODJ2RXhBYnY1ZHZHbmUrSEdaQzJGYVFaUVNFa3Rua2V0eWo5a2dPWEts?=
 =?utf-8?B?dkRSbW4wNTdVRVdjUm53cmd0SVFua0lYOUpzVXJ6aENjTDVXamdPdm4yMm1G?=
 =?utf-8?B?cGhMMFFRdlcvNCtGNDl1ekJWZ3dibGV6RVZ2c1J4dUJEcjBnRUFSb2E0RE5O?=
 =?utf-8?B?bE4rbkgwNHlqWXVlZDFyUkh0UjQ5Q053UzZOMTZCSktSTmVRWjI0UkNid3BB?=
 =?utf-8?B?VCtHV1lBb3lBSlRuL3BEeVpEQlN5cFBtc3FGMkM5a0FaZ0ZuSWxCY05nV2Jh?=
 =?utf-8?B?VVI4MS9iWFFvUERMbGJxTG5PRW1nbFgxcjczQitkbU1yWTQ5RmNMYlkvR1FM?=
 =?utf-8?B?TnAvQ0QwYXdrMEs2NDdxN3dWclJjRVR3aVdjZGlXbFRLNVJIaGNua3I4NWVy?=
 =?utf-8?B?KzZneS96TEM3VDZxb3MzREZ0a0QraHRxdVFydjFFZmQrakttckJtMGZBQlhO?=
 =?utf-8?B?MXRwem5EdzFLbDFRNXpaWU9yTTNtNTlRRHcwa2N4OTJuNmhzeThxOStEVE5W?=
 =?utf-8?B?RlRwck1xV0ZUd05iS3RhRk1UTklxQ3JOQzNtMWl1TjBFZk91WmROS0VkcjZn?=
 =?utf-8?B?bHF3ZndMNG45RlpQZkUyQjEyQXZIUjRGa3kzOGQ0SEY2UU5naG9rTWFBN0ZR?=
 =?utf-8?B?djNBSGhVUnZmMkJCMmdjRHYrMjJhQ0VIRCt1cVZFeURvVGtNcWdzaGhJS3ZC?=
 =?utf-8?B?cWMyaWN0RGhSZ0VCWVh4US9NaUl3N2dWMjhzTk8yWFA2cytUTmk1Y1RMZnY4?=
 =?utf-8?B?RnNOTXF6YXE3UWlKWUtFVStSOUVlTnlYeUFQL2ZVQ1NBNzFpTUlEZlppdk5Y?=
 =?utf-8?B?QnllblFxSFJ3YXl4R2JDZ1FTL0R5ZWtQZVI3V0xycXdTTXFkRlFvZTRXN2lP?=
 =?utf-8?B?cHR4Z3FCQzRqNkxLNUxBd2l3d3hweEZQQXdxbGo4U0FXM2dwY1p4QzVGcWZz?=
 =?utf-8?B?Vng5NS9vNEk0QTJ4Qkh0QWVZRXlGc0xybFNESXJQbXdrUWcxVjNRaFFCbTNq?=
 =?utf-8?B?WU5OREVrTzB2MGxud3lDQzZJcUI4OUFQUE1mcFd1VXNua0JGQVFycW1ZWVNM?=
 =?utf-8?B?VW9JbTh1eU9WMnFYcTlZRjlzZTV1ejNFTDBoZjIxd29uV3NHdExnYjVFdEly?=
 =?utf-8?B?ODFRSUIwNW1GdG9UTVJTUy91cEEwMWhzbU1IQkQ4MWkrQ0NnOVFyaWRQZmpK?=
 =?utf-8?B?ZWo0RGtvUm5JVWxOOWdJbHpWODNjdnZXWW9vV0k1UXE1NEYyTEVNU2RpUEx6?=
 =?utf-8?B?TmNrMzBpWG43TDg4WjVoRkxiMCtlWWI1WkQ2Q2dmL3JDaTFDcTV0eFFHTTRF?=
 =?utf-8?B?WmFBMVBNNW85alFqZkFEZXpsc2MzOGJZbXZ6VjArWGRXaDBKaVprRGlJWjU2?=
 =?utf-8?B?RmFkRmVpTXFVT2pZdG5OWURmWG9LZlZrYUoxc0VaY0twejhMYXBUbkxGd0VI?=
 =?utf-8?B?YXFNU24vT1dlc082YW55WUc4M3c1MmVVcHA1SUJqOUJhZ2pEdWlwQVlHd1h0?=
 =?utf-8?B?QnlhWkE5Vm5oT2duMG9LaytGbDBRMVRrc1g2Ylh2QXM3MUx2WmtxME5palQ0?=
 =?utf-8?B?YzNnL2RzeFozWjEwR0VmZFpuVGhUNno3Y2FUYnFXaTdlU1RFMVhRMFFGanRK?=
 =?utf-8?B?VklZdVRkYmwzdmF6dXJkOUlmcW9mWWp4dlZ1UnByOS81NXgwQUp5YTNHcWJx?=
 =?utf-8?B?MnoxQUJ5U3FBbitmYTJoaE1jVWdDOEF0QXJMNjBRZ1h3ck1mQ1VYOEtOWTVm?=
 =?utf-8?B?YmM3QnBCZmYxRCswRDYvV2pCSEljbG5HZGZORXF1NXF1eHhNZjNVL0sxSGtW?=
 =?utf-8?B?bFc1L1BsM3o4b21pZ2JTVlpZRElObnZVMktBSkZHNkdRRkg1VUtDQXJkTU1h?=
 =?utf-8?B?TUF6bUxjdXBOYW9jNG9hOVBjZ1JTb1owWEdjaUszUjUvNURCSmdQRmlvOUdX?=
 =?utf-8?B?ZTFPVEpJUG12dzk0U2tUNndIM0VQL21tVTQ2TSs4bWpHUW1tam9DbjdKME1s?=
 =?utf-8?B?NGc4MjViZ3pjd2tzYnZBOUVab2FxSHhDKzdwRHBNY2dmWDExbUhVNmdDQXpt?=
 =?utf-8?B?Sm9Cd3J2L282S3FYY1laTS9SaHBDUDBtU2tzV2hEcXNreDhNalZQWjZJWGZs?=
 =?utf-8?Q?tyFMFDNLB/IEosy8VxIdOsLhJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 178403f1-1704-40e5-3589-08dc23413308
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 16:16:51.8339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYbCTd/sK8Tlvq/NMZIX/dotAKhXrvMvmgYCwnjwzv9Cnn6clzc6stbokvZDh/6idAF5wTiEINbSBJuafM9jOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7718
X-OriginatorOrg: intel.com



On 1/31/24 16:55, Ira Weiny wrote:
> CPER events don't have UUIDs.  Therefore UUIDs were removed from the
> records passed to trace events and replaced with hard coded values.
> 
> As pointed out by Jonathan, the new defines for the UUIDs present a more
> efficient way to assign UUID in trace records.[1]
> 
> Replace memcpy's with the use of static data.
> 
> [1] https://lore.kernel.org/all/20240108132325.00000e9c@Huawei.com/
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/trace.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 89445435303a..bdf117a33744 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -338,7 +338,7 @@ TRACE_EVENT(cxl_general_media,
>  
>  	TP_fast_assign(
>  		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
> -		memcpy(&__entry->hdr_uuid, &CXL_EVENT_GEN_MEDIA_UUID, sizeof(uuid_t));
> +		__entry->hdr_uuid = CXL_EVENT_GEN_MEDIA_UUID;
>  
>  		/* General Media */
>  		__entry->dpa = le64_to_cpu(rec->phys_addr);
> @@ -425,7 +425,7 @@ TRACE_EVENT(cxl_dram,
>  
>  	TP_fast_assign(
>  		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
> -		memcpy(&__entry->hdr_uuid, &CXL_EVENT_DRAM_UUID, sizeof(uuid_t));
> +		__entry->hdr_uuid = CXL_EVENT_DRAM_UUID;
>  
>  		/* DRAM */
>  		__entry->dpa = le64_to_cpu(rec->phys_addr);
> @@ -573,7 +573,7 @@ TRACE_EVENT(cxl_memory_module,
>  
>  	TP_fast_assign(
>  		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
> -		memcpy(&__entry->hdr_uuid, &CXL_EVENT_MEM_MODULE_UUID, sizeof(uuid_t));
> +		__entry->hdr_uuid = CXL_EVENT_MEM_MODULE_UUID;
>  
>  		/* Memory Module Event */
>  		__entry->event_type = rec->event_type;
> 

