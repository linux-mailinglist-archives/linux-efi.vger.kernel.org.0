Return-Path: <linux-efi+bounces-678-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE5586EA36
	for <lists+linux-efi@lfdr.de>; Fri,  1 Mar 2024 21:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0131F24DAD
	for <lists+linux-efi@lfdr.de>; Fri,  1 Mar 2024 20:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF743CF7C;
	Fri,  1 Mar 2024 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBY61QM3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE093C47C;
	Fri,  1 Mar 2024 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324399; cv=fail; b=FWmYpjGoiQL9NnvnJVblWMZWCZ2+0PWTFE28AQUOfFRoZDHLqpWbZirLPIkdiWId90XR3h1RkVH8q/uOUEPfgrSiuqxwct2AxvjWKGEhDNt2G9K/ReUBMuG0EkVsOH0fU43EWhh83EhVtTi3m7zrhre330TB8z56LIG8/I/56bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324399; c=relaxed/simple;
	bh=jNQxyuQhhzJrLbOXttWQ9hLnjYj5UFESzvu6IO3etek=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GwzUhw3z5IJ0/MjwgVQar+HVFLc6U+O/wLckyfKG39s+6W8qMfYYDE8532cLCTeXPUWEieR3OyiiN9JXpwWRXjArhTTM9WIZhnQoLESH+wcE7bGxj1VRNxf11xZFSXtlBuenh4se88pyo8z204ZZwCFqVBfKNrLlDY+M3nFLlMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BBY61QM3; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709324395; x=1740860395;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=jNQxyuQhhzJrLbOXttWQ9hLnjYj5UFESzvu6IO3etek=;
  b=BBY61QM3dEc1m4SCJfE/kIwODgBGpamhpePyyVoukdD34nszRgcTVyOS
   KatwVyeYYlSUFaQuNQ1XsZ7qf1bberS22TpIWkH/5gAEm/YUs3UykkHa8
   5Fc4/l1pKMXV5AVBbnO92KsmP7OyF5UmzShjIQR5XDaky3M8FpZu2vtdY
   rnlIvPS10NkVwVfeGn5AuyO4Q0nqIH8kbDL+6D2JOJt2dbantea4sVYbw
   58p8gEqiZdAcFChO46k+S9tr4VlWviRWMUaLNzjsQ9RuzCQ12J7vKuvku
   RkzThClEAAah2IjkGScZEySsRNw1oTria8tOlO5riGG0dDrMwppOtZAUL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="15026554"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="15026554"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 12:19:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="8737180"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 12:19:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 12:19:52 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 12:19:52 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 12:19:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQdjtZDkzDp0DZklfwOhz1ILy4qmugL6rkDMDDlc37zwE824T7/CQQgPHmIMNImebR5m4qM336JErTGGB7EmyFnL/A4oZYXoTLjxGZZGeVq8q1rhTq6DwWXvUyDnrWO8ZNeHXLTAxRRwMBXu7zhQqoAoGQS3BChUlyMTWUnIOa/6qTnwDPqs7R/K7Sn9dRN5kxtFgN6410Uu3XQ9MK8L6jq109EX1uen9AQPCK8TozrmYw9xIRtSPIF0rFp/EVp4RLmtJGp9oRn7DgwbIGbDefaU+TpBfDGC6ab3MZF4spOh4U4n3PaOUQdwLaTHvb2+RmBIcXWWzLSvh7AkIr7yyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rws2F1pKsZn2k3t5g7kgsiZFOq83AiCncsR1jYBHITs=;
 b=gGiz25fxQbs5F7BAxJwInZOXKp88EKDZ6+JG+BK6QuYms1l1ArWmjg8K+UbP9QUl1mac7tSG+1qYV7ElMmJ4co9Ye/trA6HXkenAEfm1gNfTXTrP1s5CmDE6IzvOScaZ9qek2fPJYF/x2L5sojge6TnsT+1FZ6zUWAgYNp89D+/ICc9m29WXQKqZvVrlXY57cmBU4QTZgDVK2+GTkf4sLOJClqHdNwL73ipiIk8MWShO7gvXcy7QtLrFjtwxKdjiLHP2cUPQqTWSQveHVJX41jmHdkyj23LC+sZAz7SEAA/yCwBs/YD2mWk37Tp/xhckwhvwwvgWexhB9CiyE8Dpbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5328.namprd11.prod.outlook.com (2603:10b6:5:393::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.18; Fri, 1 Mar
 2024 20:19:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Fri, 1 Mar 2024
 20:19:50 +0000
Date: Fri, 1 Mar 2024 12:19:47 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 1/4] cxl/event: Add missing include files
Message-ID: <65e238631fd64_3651e294c0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240228-cxl-cper3-v1-0-6aa3f1343c6c@intel.com>
 <20240228-cxl-cper3-v1-1-6aa3f1343c6c@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240228-cxl-cper3-v1-1-6aa3f1343c6c@intel.com>
X-ClientProxiedBy: MW4PR04CA0039.namprd04.prod.outlook.com
 (2603:10b6:303:6a::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5328:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ce4df7-4443-43fb-a929-08dc3a2cf26d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/K8nKNh+t/0AD2niT5Ib2/v1Xgtf3/iTYy5LiWFvd/tVnsr4wzeAABTCi70FbqcD0VTjJNlPw/IDkSe3CPxFID0b6Qlxb2ZTrl6/kLxggiBD76EeVMdkAKjVSpDHnfQRTAnfMgDE9V+wEYupLXcLXNB+fTmFhncMzXYyLoKEgks5sYFOpb6ychj8j0Oj05uUTRYiNF3sv1oQMLLOb2Atq+JSoEZFf0Ub0cvdwWQN8rY+JtTS/wisl0+SqLHK6WezvCtgf5HGn2CKQMNvdFC1C+b0ce7bKETMe7omuS9w8yf2YhOxOtpTDaspbbr+gcWiQ0oMffFJswHBPwQEnr+kTuCTfRUCz9YMNBQwXWSbuyUeQQspeQYMwKlVGS2ercjeiygim71F64kh47c+t5M9ebHd6pBiP19Ma2CDG/Mvb8kILB1WnrK1B0HzWrou8a7XjNqlPA0gZHiqLiHUhC6MVdRB2Y3/3FiOtkJ6xrt87/WWmioOALumkee6/kecuwK9P/mMWDLq5gEgEdkbpMkh5G2LjnBZs574Yaq5zV68O87+mxdiHc9a1kkL5Jid+5JZZhyQcNOxlbNGoNEP48TQSxaMIgUJODLBgfqxE3K8b/fkALO5T8zBsXeG4yu1cR70axZFJQpF3OfzligP9CiMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWxXaEdTeTl6MlFQaGJ6Z0hINnUrZXp1eGhKR1hYMWhEcHU1NEFWelNENGFJ?=
 =?utf-8?B?ay8rTVp1aHVhQmtBZTljZjBiZ3dKSGo0Nmhiay80OU5jdXdIeko4R2pNL1Zt?=
 =?utf-8?B?dXY3VFFZcUxZREdPUjJ4b0lFUnhqWVkrZ2tXN0hmNnZ3SEppQ3VhemZsS1JQ?=
 =?utf-8?B?YVN1RkRQRmZWTnJHbTl2VDBhT2t6L2E0OUs0bi9ZZ0pWNGQwcUVrOTBPVjZL?=
 =?utf-8?B?SEZERjVkbEdmdWpUYjVLbWJhaVJ5d0FKQzFWMU1NdjdGQnZUWWRXbFlPQWRs?=
 =?utf-8?B?UHZUVkQzT0xWYjBXUFdualh1Y2NWWlVlOE96b0I0aFdCakN0MWd4azIvWVRV?=
 =?utf-8?B?cnpHTU1Eb1hTcHhuOU9SeVJMdDlQWjkrOFJIaWMvb0ZvekRoYWVmS3RZSVVF?=
 =?utf-8?B?KytGbVJoanQ4VzZZak9uUDM4ZEZYSW9YYlZ0K2ltVFpYa1JhY2ZrNlNFOTBt?=
 =?utf-8?B?ZVhMS3M5VkpVNzdwVnI0TmxuOHVsT3I4YXpzdGFvN0lOZjBTaUZWTE1SQk40?=
 =?utf-8?B?Ni9aMVRsVTI0WlVYM05qUjRuZGJTcnN4dGwzanVpQXU0dDhhNVFDcVpDMEhK?=
 =?utf-8?B?bFc0WGVIMUp6aE5rV2hCRUt3ekgrQjVUS3BtUXpJNmliSVBMZk5iVTBVczA3?=
 =?utf-8?B?dUx1ZSswOURCelA0Mmg0TTB1SVNGTmNXZFBiNlhmbzFFdWxZbE1WNFJlR09z?=
 =?utf-8?B?Nnd1QnBUeDl0cEdRODNEQklsYVpYb25WdHhTSGJvZ24xZWUxamV1S1o2c2ZU?=
 =?utf-8?B?cEZYeUVXblpHQllKa3dTZVI2bTN6VjhJR0pqTVprUUFsVXliUVlRMXhtT2lU?=
 =?utf-8?B?aG1DU3hMeE9ldEUrR3RLVG5TUWVTTWl6dHZzbGJNei82VHJsREUvWlZXcm1s?=
 =?utf-8?B?TzM5V0ptTVdIUWl1M2hNdUdDZ1pqN0Q5RFhtV1VIcHBsejV5S2NuYjB3T3Bp?=
 =?utf-8?B?NmNCOS9jWHlUSDhlbjdqSTJMV0xZOXMwUjJmUFczUHNXaW5uSEJzcXVJcE94?=
 =?utf-8?B?a1RoMG5RZTNjTVZNQlNxZFdpcWczS1hhbVN6dVp2QkxYektxTm13MUtrZDNE?=
 =?utf-8?B?dG84T2tCTEFDK01GcU5QSkhrVFUwWStpZXkvb2lYQm5IRkxFNEVSQzZCN3F4?=
 =?utf-8?B?TzlXYVhOU1h2TUZ0WHZYS3FnV0xJNVVKZE5obzNYYi9Jd3JhUGF1UG51SWdJ?=
 =?utf-8?B?b0pDZHNoc3QxbTdlNXVXblNpYWcvSWlXR0JyT3hYWVo3dGMzZGZSV2NyY1pL?=
 =?utf-8?B?TC8rMGJtaHhES3YxeWZIT2EzR0I1V2dsNU5IQ2MxazBZVzlyWHlaazJFeU5G?=
 =?utf-8?B?MHM5c3Y3ZG16cDFTQjNMb09Mb01CRUZuVGVtUlE5Rnp0UFpDS09NTkdPaCtT?=
 =?utf-8?B?a0dUOHIzREdKWmJ4QS9td0dWeml1R2k0eGtjNFlxdGx6c3RNOG41RTBjK0Yr?=
 =?utf-8?B?MlBWZi9LaUJyL0NUSVZlZ3dXNEpRNWlqSkdYaVNCeW5HY2I0TkIwSDBiU1lu?=
 =?utf-8?B?Q0JaL0lRRWxaTWp1MXBIRXR3VmUzSzVucDBrbUxydUdCUXBiZkd4ZTFmRDls?=
 =?utf-8?B?aDd4NnpuL2ZZSFBlRGVOZlNZN0hqYlBsY01tMEh6NWlWd0hvM3cwMnpDTWp6?=
 =?utf-8?B?TXZ1b0V1NnBKZFg4ejVkc2d6Y3lNb2tBWTNSdmFnVitMZmc2MHpKVmJpYm54?=
 =?utf-8?B?ekU5Zkt1czN3b2ZNUjNWaFhKd1pxWXQrUCtJTkk4Yk5IR0pZVkhFdjNjZm5U?=
 =?utf-8?B?b1BFL3VLNXVIK3ZnUVlMbnFRUi9sRFJIYzdDT2VIK3Ewc3ZDcytEb1YyUmlE?=
 =?utf-8?B?V3FlNjRqNUx6bjlIOHRyYWQ3NDdmcVZkcVZFY2llS3lBeWxSQzdTT2JsTEc3?=
 =?utf-8?B?Rmx3ek9Nd01EbHpkMDJOa2RQWWhsZFM2N29jYlJ0Z2w0ZCtJamdQcUhWaHdN?=
 =?utf-8?B?Z3kwbm9OMVp5UUh5cmt5b3JVOXBxQ0NmMmdNckhuZ2hwTVE4QldwRFk4OTYy?=
 =?utf-8?B?OFJqak9lbWJvWGlBSkNjQTZBU0VTcGVrSEZqbkRxVFF5ZFczOEFyK0VhYmJj?=
 =?utf-8?B?clAwdE42aDYwUlp3ZUhPTTdwaHhUYkljMVoxZVkrOThjdjJuMWozS0EwNFFY?=
 =?utf-8?B?RFZkNVdHcW1CKzU2blRUK09yQTYya1p0Uk8vQjV4WkJUdEpKOXBwVy9BOG9S?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ce4df7-4443-43fb-a929-08dc3a2cf26d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 20:19:50.1837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SD/C2WztTbzib1Nwqlqw+ghhsIthcfSpfnkdoclkPYAN3xKIpJC579c3o7RomMSevqKBHEi+HLMcTA1yjYDFH1F14yyeRHCwSDRcg9vBv1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5328
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Additional event testing using the cxl-event.h header revealed that it
> did not include the correct headers for the types used.  Compile errors
> such as:
> 
> 	include/linux/cxl-event.h|11 col 9| error: unknown type name ‘u8’
> 
> ... were seen.

Were seen where? Should this have the trio of Reported-by: Closes: and
Fixes tags?

