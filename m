Return-Path: <linux-efi+bounces-449-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF224845D0D
	for <lists+linux-efi@lfdr.de>; Thu,  1 Feb 2024 17:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B6A29A6DA
	for <lists+linux-efi@lfdr.de>; Thu,  1 Feb 2024 16:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61DF7E103;
	Thu,  1 Feb 2024 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZ912FLb"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2727E0E0;
	Thu,  1 Feb 2024 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804210; cv=fail; b=GgbqtBjl4/lqUxBDEy/5bZ1SFRV2o1oLOydpVJghvWlqjHLHqLW6kCuviUJlDYuQD9gXBDuRZnWeG96htMuj652EjvI86GnBOmpf0Q2+P4mwbIxD7Etv0+UgIJ+JnBrT05EdRsmFR/SCGY74KRPilUM40wDJfzlKnuhZi1quevg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804210; c=relaxed/simple;
	bh=vLkRy6M9UWdRi7ug+ci5VQgVnTqr46ZlqmQRkRvMMK8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LQDOctEL3mx6mWf4i25mtUjCAopLbfqcWUBnoPUJcVZIit1O86FPKKUq9k+yi1BHRQHZ/8SBN8TG7qgV1CWcsITzLGjZpGqbotgiGGAf2p+iA2O7V60uhJW/2++JoSbBnT56btIa0RrH+MVEnTEsuCjZnkozhZxVhIWNnZLslzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZ912FLb; arc=fail smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706804208; x=1738340208;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vLkRy6M9UWdRi7ug+ci5VQgVnTqr46ZlqmQRkRvMMK8=;
  b=XZ912FLb/xAKjP0eQICq1IpBqjTBRSes4O3a6Ev97rtGqxwo4AZhiKE0
   Xh7BYjiwx4xC3t6ryPQ4cW/Sj/yJhnG1EwQ5gsJXG4CxLK/JKOqlUBEX9
   qRlmhNXuNeLB9h+7o82/tGvm4twDTiG77k4ZygVuqvIb/h+Ns6FmHgmqB
   8ATOOI/QoY21SMMHCqXdvZJRaimSCfZUYDMDglQn2pgnoV8UVJ/ulFx0e
   fmFDOcZaGjWz7Ol0kbJ39Hdll+dqp303vquLCFZmY5v4eb8bjMFydQAjm
   BtDjP8OS+ec8OKENhTprsYxAoWGy+68I4kCkFPzt2RGyHkRHSDnCPUCIP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="468161852"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="468161852"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 08:16:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="908285494"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="908285494"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 08:16:44 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 08:16:42 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 08:16:42 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 08:16:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbWY3KoWfe8YHGPvqxzTXEe9e7XqG66UsbbI9CV8ic2zTphaxXoOGJo/wC8NnFMWiASVaiP+qOX8r/uDXjwDAkBXvWSrAHBO+KTK1LicBRPf0Zhr1xuDBz7tnJV0rQ/9jDcbyGwOJEKsJpBxR4yH+1WA5dtHYa955z+yUxVef5XiSUTkClliqy2t/VZq0YaT7+6lMvzaQvsAQhjBHzeFhGz3i8QAnacMH8tVDpP8gUIuKNQagcTiO6wGye0LNZRhSBCoDjEG+KhcxpyzeHd8OOWV4tEa50ajCs45n+RR1WQ96Z8Alm2fLwumUuJeiya38yyR2qz/zgUnZBl2wiPSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/yQmqqadenf1nYxoika5e5PU0/SI1bNELFvqXfCRTA=;
 b=egVxOB4tJlMA7ansXJI8UCgbpNIfykCo6XUcthG9L7UxdOMYirW6WGwIvrlF62TsJebU5TC+IXvZ34C58ikSVWlc5s8lPpLLytaKQiqGBKrANl4xyVAsPD+etaKaQvMl7K5xb12DVcDCC24N6cYaNMX5kReE7zDSOJod4DeQqN3b9SXgxqmzyGp8Fu3Jb/OawzO7jQYH9I86yEdtkgng9WMm93oDpC59SULAdJThMSJzyk7IcPNwZhT/W+o7m/2inGxbqFL1GVwix28nm1zTVW6KQsBD4njtjk15yLI8UcyyEDXpfgMcmJ9MjuHyIOr+WjF1r+dVejBPlIOMDaCLIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by BL3PR11MB6364.namprd11.prod.outlook.com (2603:10b6:208:3b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 16:16:02 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::c403:9b0a:1267:d225]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::c403:9b0a:1267:d225%6]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 16:16:02 +0000
Message-ID: <f3a3ad02-0bff-46bf-9fd6-c5b99fbc9ce9@intel.com>
Date: Thu, 1 Feb 2024 09:15:57 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 1/2] cxl/cper: Fix errant CPER prints for CXL events
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
References: <20240131-cxl-cper-fixups-v1-0-335c85b1d77b@intel.com>
 <20240131-cxl-cper-fixups-v1-1-335c85b1d77b@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240131-cxl-cper-fixups-v1-1-335c85b1d77b@intel.com>
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
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|BL3PR11MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 306e7f5b-7b9f-4973-f110-08dc2341158c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U05UM13nUJb8zd1n5bSDMOsI2oF49khHLI45vBiLFufslZ/3W6VlnuGOiGA9pGiyXWakkBW5YWC+c0ov56bY237CQdFYe/tj9h1GVjuqvhNYGJeJZzEKwIu6AAnUtmdepIWBSqUWpusXH7C1F94Sam5uTqPILbJGO1sl4wmcEt/WqXnE+9qE42HaXF5cMHWaGOZbOt0xznIkNfrwpT4JnqY+oGQXDsEmmxzTOvgBzrQ7rA6IrW5zIDsnUL+T+VTjuyBsNSGC5BTH1mkxeDpuHkH1Weia3dZliVm8BX+QfVqcz0jdQXo1WF7lwP7jloc/gNQpGtBtfypAg1ylC3tHeUjZD4fufoAtnGOmXsDuetCulJlCuoOGRtYo/+c/GeULjU7zgQAZAhQUgJTrYZwVTTQ+8lw/hgSUamGBZ8ilp6CV3FERAvz+DytAcBFlb9JEKbNTfYV/Qjrc/CVDwXAXIZyOq746Fw4dWZkhWblnuoKbdqK3R4tMu7mhNjZlalpyZWdckPdSgXLp+aTVJigIa3YOsVYFe2e6BI+ixUHvQ0LvAo6f5wKd94r4aVd5bcfAmI97vCV9ZQKPFWNd2eQLWzNS+8RqpRoaH//DPqhmCnHoaOFFL0lsDFOqJH7vq0NP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(8936002)(4326008)(2906002)(8676002)(110136005)(44832011)(5660300002)(31696002)(86362001)(316002)(54906003)(66556008)(66946007)(66476007)(36756003)(6506007)(6486002)(82960400001)(38100700002)(83380400001)(478600001)(6666004)(6512007)(53546011)(2616005)(41300700001)(26005)(31686004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3Z4Q3lvRWcraUxDK0ZvUDJpWThQM3YrZ2kwU2o1U1ErenNIakwrYVhpUnAr?=
 =?utf-8?B?S1IydElOMVhMcUdTZnZlUUt4Ris1M2ZFNnZRbGQ4ZCtEMmRSQWFzZ3h5bDBJ?=
 =?utf-8?B?NWFyRUd3c0RLQmdNcWFRUmgrZVF1eVVReDY2V1RkK3E1RCtUcWUzTU1IV2Vt?=
 =?utf-8?B?UVozbk9jY0IybjdsUFhlVmRLb1JZWHZMM3lNS2g4NFgwc0x3ZGZybmFSTndE?=
 =?utf-8?B?MTVlM1RzSk9pQWFjbDJjeUtKeCs3QTZkT1ZZQnI2bU9Uc2ozTUxLdnNyUHdv?=
 =?utf-8?B?VUplK2NxSHhvSlc5MDVlalJqdVQ2MnNvcWtvS3Q1a2M4UlkyWklaSjM3NTNQ?=
 =?utf-8?B?MnRJNU9BRXpUSndXeE9xVm5IRkFVcnBER1daVExyU0tZVm5BelUveC9vZVBa?=
 =?utf-8?B?SWUzZVpZYUdINkFXMjR3eVJ3SHdnWTBySTE2QVRHR0o4NzFUV2NEVjUrZml3?=
 =?utf-8?B?aFNXTE9FZ2tsa3lFS3JJcExvVjNCVU5BOUcyN0p4UVBtT3F1T3NXUW5tODcw?=
 =?utf-8?B?Qzh6ZkFqS2pZM2ZwREVaRUpYM0JpanBrcUgwcUliZlRlZktCOENiQkFOV2Ft?=
 =?utf-8?B?L09hSVBsd0xhZCtoNVlHRERGMVJ5VGQwMUtqTkwybVcvZll6ckxWWFd3RlN2?=
 =?utf-8?B?WEZlMEdkMlcvWVZPRVJTS240Vks5MHFqZDR0TzBiVE1QS2o4dEliT0x4SGRK?=
 =?utf-8?B?WWt0aVduM0c1bmpHZmlHODdDK0l1M1F0NGZ3QThHOXVlR1BPTzcwd0t0L3ow?=
 =?utf-8?B?b1ExOFEwL3BuZjVYNXhoOExIVkRhNHhYbGpxU2ZDYWpOU3BhL25BSW03c3NE?=
 =?utf-8?B?NE93SFFwelNGRmgyMFBma2IxTlREejJvS3hMYm9ZT3lZTHhsV3lpZ1hKZkV4?=
 =?utf-8?B?ME0rUGcyNy9jSHMwSUN3TUFIcTJUT0R0L2ZKN1A1cEh4U29SKzZFNnovaGRI?=
 =?utf-8?B?VG1jZDBEelhySnNTa1NHdk9rR05vVmsvZWZxYnRtbFR2WWliTjRWQlg0VW1B?=
 =?utf-8?B?WGN2VEt6dXNyTFE3VFRDMzVoQ0twZDR1WEZUaGovcjlNdFJ1WGE2SDBIb050?=
 =?utf-8?B?eGJSaTJGVHJzK0dBTi9CR1JLZ2hzL0k0WmkyUExMRVY3NTVoTXpOVloybWVs?=
 =?utf-8?B?ampHTW0yNWtMZ3FLVlFlWVd2UE9FSW5KUWR6ajdwL09pcEVLU3JKUE83WVlO?=
 =?utf-8?B?ZVJ1eHNEQ0x0bG9SMmdKSVlvbU9mVzFSbVdhYnFGMTFQMXhnbWJ3T3pOUUFq?=
 =?utf-8?B?VHhGbjFJaVVpUnZZb3BNQzlkWlpHeVBLQnEwS0tVMnZHK3U2ZjF0dEYrbUlx?=
 =?utf-8?B?YVQ0cXhlVFpOcndTMm9VUHdMOEdTWkZmbFZHdEthYmpPMmVkeFAvdGVGSlNa?=
 =?utf-8?B?U1NkZ3VWSng3UkphSnBpeVptTUpPRDRESGgvYTlSM0JyT3MyRzB0Y0VWK0hx?=
 =?utf-8?B?R2diNWZGM3VMRmJ1K2xIMHNRQ3Q4eWtFYXJYYnFUUy9mVW9pNzBlUmRVYmxL?=
 =?utf-8?B?UHdadWVGenhIdkVTQzQza01MZmhSdzBsOW85RVJyN2h1RG1KL2J6TkNLa0l6?=
 =?utf-8?B?TWNlSGtwTWRzS1I5ZTNWT2VOeWRtT0lEbVVZRlVjRmtmUDY5cGw1V2wwaUFO?=
 =?utf-8?B?TmR4RDBydk1TWGtvKytqYzRCK3d4N3BZZU9JVFIxSjZabms5L2JpR0tUY1JV?=
 =?utf-8?B?VTdaS2c0SWZxUjZVb043cGhKVU9ISWNXM0NadVVnTTBSUlZOSW5RUzA3b09l?=
 =?utf-8?B?MXNCNDl6REpUTjcvREZrRlE2R1ZwNFllbVp0cmV2VjFYcXRMc24rSjROaTcw?=
 =?utf-8?B?SWMxQlgwVHFqMnJtcXZ1K0VHM08zOGpPdGN3MlpMQ2xSdTBMMFVOUHhvTEg1?=
 =?utf-8?B?VnZPaUl6YzRzYzlHMzBEMldBeHowekhJeXFDaURVR0ZYb3o4dS9UNTdBb1pZ?=
 =?utf-8?B?ZmdGT1M1MitXd1ZTcW9jT2JvNmRvNkUyb21ZQTcyQ0J3blJEdTYzOVoyVEoz?=
 =?utf-8?B?STVZT21WVXV1bW5Fa1FjVUhKMkFqVFlzVG96dEIzN3dnZmc2YnIrRklDaCs3?=
 =?utf-8?B?VWJyWVRqZkJqVXcyK0pBNkdPamF2YlYvMHVhdE1Cc3l4RGRIZUJtb25EZGpm?=
 =?utf-8?Q?CYjW0kU9nRJP9ZvhcXcmZoiwq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 306e7f5b-7b9f-4973-f110-08dc2341158c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 16:16:02.2371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pKcliuqE0F4T3SX/pKhXoQX+UKWWV9LsmTGfxcxLbGHOonXnDeuV/5l+Ml6AC3d/hjWOYb+6jF90909FC1K0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6364
X-OriginatorOrg: intel.com



On 1/31/24 16:55, Ira Weiny wrote:
> Jonathan reports that CXL CPER events dump an extra generic error
> message.
> 
> 	{1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> 	{1}[Hardware Error]: event severity: recoverable
> 	{1}[Hardware Error]:  Error 0, type: recoverable
> 	{1}[Hardware Error]:   section type: unknown, fbcd0a77-c260-417f-85a9-088b1621eba6
> 	{1}[Hardware Error]:   section length: 0x90
> 	{1}[Hardware Error]:   00000000: 00000090 00000007 00000000 0d938086 ................
> 	{1}[Hardware Error]:   00000010: 00100000 00000000 00040000 00000000 ................
> 	...
> 
> CXL events were rerouted though the CXL subsystem for additional
> processing.  However, when that work was done it was missed that
> cper_estatus_print_section() continued with a generic error message
> which is confusing.
> 
> Teach CPER print code to ignore printing details of some section types.
> Assign the CXL event GUIDs to this set to prevent confusing unknown
> prints.
> 
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/apei/ghes.c    | 26 --------------------------
>  drivers/firmware/efi/cper.c | 19 +++++++++++++++++++
>  include/linux/cper.h        | 23 +++++++++++++++++++++++
>  3 files changed, 42 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 7b7c605166e0..fe825a432c5b 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -680,32 +680,6 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>  static DECLARE_RWSEM(cxl_cper_rw_sem);
>  static cxl_cper_callback cper_callback;
>  
> -/* CXL Event record UUIDs are formatted as GUIDs and reported in section type */
> -
> -/*
> - * General Media Event Record
> - * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> - */
> -#define CPER_SEC_CXL_GEN_MEDIA_GUID					\
> -	GUID_INIT(0xfbcd0a77, 0xc260, 0x417f,				\
> -		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6)
> -
> -/*
> - * DRAM Event Record
> - * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
> - */
> -#define CPER_SEC_CXL_DRAM_GUID						\
> -	GUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,				\
> -		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24)
> -
> -/*
> - * Memory Module Event Record
> - * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> - */
> -#define CPER_SEC_CXL_MEM_MODULE_GUID					\
> -	GUID_INIT(0xfe927475, 0xdd59, 0x4339,				\
> -		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74)
> -
>  static void cxl_cper_post_event(enum cxl_event_type event_type,
>  				struct cxl_cper_event_rec *rec)
>  {
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 35c37f667781..9b3884ff81e6 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -523,6 +523,17 @@ static void cper_print_tstamp(const char *pfx,
>  	}
>  }
>  
> +struct ignore_section {
> +	guid_t guid;
> +	const char *name;
> +};
> +
> +static const struct ignore_section ignore_sections[] = {
> +	{ .guid = CPER_SEC_CXL_GEN_MEDIA_GUID, .name = "CXL General Media Event" },
> +	{ .guid = CPER_SEC_CXL_DRAM_GUID, .name = "CXL DRAM Event" },
> +	{ .guid = CPER_SEC_CXL_MEM_MODULE_GUID, .name = "CXL Memory Module Event" },
> +};
> +
>  static void
>  cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata,
>  			   int sec_no)
> @@ -543,6 +554,14 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
>  		printk("%s""fru_text: %.20s\n", pfx, gdata->fru_text);
>  
>  	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
> +
> +	for (int i = 0; i < ARRAY_SIZE(ignore_sections); i++) {
> +		if (guid_equal(sec_type, &ignore_sections[i].guid)) {
> +			printk("%ssection_type: %s\n", newpfx, ignore_sections[i].name);
> +			return;
> +		}
> +	}
> +
>  	if (guid_equal(sec_type, &CPER_SEC_PROC_GENERIC)) {
>  		struct cper_sec_proc_generic *proc_err = acpi_hest_get_payload(gdata);
>  
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index c1a7dc325121..265b0f8fc0b3 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -90,6 +90,29 @@ enum {
>  	GUID_INIT(0x667DD791, 0xC6B3, 0x4c27, 0x8A, 0x6B, 0x0F, 0x8E,	\
>  		  0x72, 0x2D, 0xEB, 0x41)
>  
> +/* CXL Event record UUIDs are formatted as GUIDs and reported in section type */
> +/*
> + * General Media Event Record
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +#define CPER_SEC_CXL_GEN_MEDIA_GUID					\
> +	GUID_INIT(0xfbcd0a77, 0xc260, 0x417f,				\
> +		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6)
> +/*
> + * DRAM Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
> + */
> +#define CPER_SEC_CXL_DRAM_GUID						\
> +	GUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,				\
> +		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24)
> +/*
> + * Memory Module Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> + */
> +#define CPER_SEC_CXL_MEM_MODULE_GUID					\
> +	GUID_INIT(0xfe927475, 0xdd59, 0x4339,				\
> +		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74)
> +
>  /*
>   * Flags bits definitions for flags in struct cper_record_header
>   * If set, the error has been recovered
> 

