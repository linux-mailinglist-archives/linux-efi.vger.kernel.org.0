Return-Path: <linux-efi+bounces-681-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC53086EB7F
	for <lists+linux-efi@lfdr.de>; Fri,  1 Mar 2024 22:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422A01F236F4
	for <lists+linux-efi@lfdr.de>; Fri,  1 Mar 2024 21:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3B758ACB;
	Fri,  1 Mar 2024 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T7Iw8edK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C7758ABA;
	Fri,  1 Mar 2024 21:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709330011; cv=fail; b=qRs3TChmLvlQxSDJetzPfV7Tp7d90xOSNUdQgCiTQvrnJGxccw7Cgq6QqjQ41U26sA+1gTGRj89P7UMkksKr/T8gWAgW7agbOTKg5c3il2gfJtURFz/ON22jgwj3qASR1f/xdfBeQv4R2HLjclGxA0P0tDX5P9vy859NEEwTazY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709330011; c=relaxed/simple;
	bh=qteBVFBiOG/NYtnjgDoBrLK067aj+dPf/2Nm/7ew6sY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TtQdtIDmeGfcXddOL9JDShvv+PaaWzdGYjAn4DGWAAP9ibllSIC/si/zJYzBcWA/VlMNfIYBBVLTYHMqDWwFuchBNQFPU84E0Y4QV5bPLIKB5b1j9+EIb1ZG1Q2NKZAGcykej4oHwF0GS1QNvSr64mNXWfufoC8bJEZL8chQuh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T7Iw8edK; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709330009; x=1740866009;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=qteBVFBiOG/NYtnjgDoBrLK067aj+dPf/2Nm/7ew6sY=;
  b=T7Iw8edK0CmyP6MkqneNY5QZAXkvOjJf8wYmwI6ARjHYt3wMYNYKaHkc
   /YGjYjY2hs8zhrNN69g+gVaAm1gWsnrh2puyuk1GdLjSM2+ej3HrmMRvR
   Z/TO3B3GzI5ahk8SN8nllIt+yEb66UsGfjzKm/8T/cq+zQR5As9Ey+8+e
   tCjm7nJtvIT8R2yJv341B5GDgdDvAsSsqS1z9eEh3d8a49wR+gmsUAzP7
   /TL0ofCFseirU5QjSkoF0VPyrGq4uAF4WGqRZrzDgo5kACfFGZ5O8XVOh
   Zagt5TD9nE5INitxZRTGQfMPjPN9qwSjbkR1hKf3fdmRmw4jDVTzh5I0L
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3740914"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="3740914"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 13:53:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="8270820"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 13:53:29 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 13:53:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 13:53:27 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 13:53:27 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 13:53:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TO/4JvRDOpmK+ZZue+3W4iALf+kcXJBtGp0snp2n/LLNdLjFpUT0wxroepJJFGRVgRJfJls8i3y4Jx9cRlew0DIcWh+TwDewYVJIyP8fsGEebWjTXFpy7FZTZGyakX4PJPMKGzA9H4OYjPdTmEL3R6eCZQR8R07yTEA1mqFKySirWP/+nlrxGAVQNNjupixUP7CbPlrcTn1bCCRHSv/5fdZEB/ia//Ejk5n3Mrj01idkxHNw+XBtYeP6r5mMvJB514Lbebhrtq9CK26Sp0PEXlc8tnIQDp6q0dDm4RXvlE5C057g9DTYdsa6DDHmrmjtCO1bUfxYXlFtlQNjXuS73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKXWTNKUHGs8RfKFbhsqDDUjZca5COzb5Z/zGEaoVyA=;
 b=BPg1tiIoz29Y7DVtgX2KMRKykciuKop5IL9TNyFLaLnncZ6DIGBebcoVohbzV6sYxcN4nxuTDCRpvGiWwK3tplVxQJaCYA2qjKGgzsvqVQ6xyqqgKfm8hZpm9qECsTeMuPjb6/KBDNMFdp2bx1M0jeacE34CJDEkSqoOXaW9zv4oOMqDSFD/Sx5HD3tN5Q6Y/wG2/wtcnoV+3lTXYmZOn+JHQNosjUb0kZsnvA59GT8E0pXLWP0WwFMsAo0+VrR2iUbYd6OWT40mER0YWVG5IpdJ3nlBYjN2uJmLPn+Oq2I52CEUsXDcO8B9Z0KSI9eLA/nC22KTrz8rBGzRbeFoyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB6781.namprd11.prod.outlook.com (2603:10b6:806:25d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Fri, 1 Mar
 2024 21:53:25 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7339.024; Fri, 1 Mar 2024
 21:53:25 +0000
Date: Fri, 1 Mar 2024 13:53:21 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 1/4] cxl/event: Add missing include files
Message-ID: <65e24e516d330_314b33294f@iweiny-mobl.notmuch>
References: <20240228-cxl-cper3-v1-0-6aa3f1343c6c@intel.com>
 <20240228-cxl-cper3-v1-1-6aa3f1343c6c@intel.com>
 <65e238631fd64_3651e294c0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65e238631fd64_3651e294c0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR03CA0238.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: f95ed3f1-1283-4f98-6d44-08dc3a3a055a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wMT60yYLs7GTD98VDbkiAaPPf8giK/avAh7ahHzyPvwv4s0wT2BtknsHDpeDY/hV0kbwjE8f4hA8LNaYj7ViquqyOa4CmroUziMzHBhBZ0x5kKYpG/jV9ybcL8QWcbtnD4DcuEdzzvRuW8V1xgy6ZZd+oZLCGDIs334RrJefegoybNd1O0vJXYx2+CytXcmQo9wDMWitqff1qrjT1nJgW+66VnW6U/VVJ8qn6TiOdu5CetVvfCMU5uepFJBua1EM733r7h2SIjg9p/34GxAYo+T3Sl8FQ5SfKZJyeFpS8kGYLQS2CyGDhosuPCspAuUYjyMdnyufNkFhtI1v5FUveGk1ow2BbJetoRZZVrH7K/dWccXohPAqyVupYRMomRUw/d8ex00VLFOkaILfAolCC0TFopG5DxsCA/oy817OkeoDXKpRPzokElE6Onu93mKSXkV4bXYYsvqTag8Qx+vEaiPR/t0N7wQDNc6pOvd+Xvn5ybzLDdBFY6kWxqZwRA0/7wl2Pchi5niCjlpSkIs1GwexIzkDvpbO7yKTEj2tGKcsha2w1ymmEzRBf38pAnB4VBF+JX3F72FT2nGeAeYm5AjC43iJd8N81RiF71UmcC3+cmvUgk7VTjQIlLJtkeDl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHBnNms2Rm1MYUw0S21nbXZRUG15cWpOTXFEYTBlMkZnbmgycUIzZUhHYnQ2?=
 =?utf-8?B?QlFDRmdKZlhuMDkzWFBTRytEVE9mZlB0UXUvM3RiRFViR1hFTS9qamJIYkU1?=
 =?utf-8?B?RUMxVzN4d3NYUk9iYUhXdlBkRjI1OFVUY3crMFlwTDBya1NVeHFqZkF2azdw?=
 =?utf-8?B?TjJJWmMyMWUxUHhjcDVweFhnSUhoKytNUTM5c3F3RDNUbHBaNzRwdHQ5RlRP?=
 =?utf-8?B?bER0eU15SFBvK3lRSG1WOVdqVjJzUENBMmVPMWhUUkdpYzBDalBaUmZoWlE5?=
 =?utf-8?B?M0RrWVNxWUZqNnRicXRiVDZBK0VUOVVIdTFPUE9EMFFPbkhLRy9ZQlhmQ1Nu?=
 =?utf-8?B?azVpaDFpWXpNeUdUdXVnc2RvUnQxNTdVSlVuT3JLODNXU1pCb0I3aXFpdXVx?=
 =?utf-8?B?cG5NMTRZbStQUGc3cjgydGphWlRYdTRzeGJhRm5QYWVrZlcxd2VxcTdoNm1O?=
 =?utf-8?B?K1BlSUlhcDkxSTBWZ2tkY2tacmdKWkd1TS9zL2VJeHg3U1duYU42MDZ4UnFZ?=
 =?utf-8?B?UzlkWm5oSmNtMUNxS1lPSWY4UENtSytaK2JGbFVZVnNESmplcDQ3R3N2NTd4?=
 =?utf-8?B?UWVMV0VUaDFvcjFwYU96S2ZpakNOZ2E4eVdFYzlRVjI4eGtKczdkYkdIc1Bz?=
 =?utf-8?B?eFZhSEFQZWlBeUF2ajRseXpybVI4N3ZkSlhXY3N1NFI2cHkwNXl6VzBxbTF6?=
 =?utf-8?B?VjNGWDcwYmYycTlTWElhTEV3Yjk1TGJzbVlwbXpyTjhnUi9Rd3RmekJVZm1i?=
 =?utf-8?B?QnJReUFLNG1Ld3RDUlczaXpEdEVNRHBNZksxeVExZ3FNcjM4K2Jud0tEdlRz?=
 =?utf-8?B?M0lRNHptVWxaNHc1M3lMbWU1OCtud2pXcHBTWjlPY2RHdldMWi8xbFRyRXdS?=
 =?utf-8?B?cmtBSVJETkZDa3hTNnB1N01OdzQxdGdqbS9sN016dWtNVEdsbi9rcys3L29m?=
 =?utf-8?B?U3JIZUdlUnREQkV4ck1Sdi85aVV6dGhPQ0F1OUJJck8ybVRtNDlPU29EbWxW?=
 =?utf-8?B?NDVZMlNXOEtIODQ1OXVwaHlWUzVtRmlPOEsvT2JCVGpvUGNYcU4xbHluRFVO?=
 =?utf-8?B?SGsrYUJpNmt0Rkh3aUJuUFdVbTZTUkl4cFc0eGFjTkdXSnd6RFBLUjVNdlNX?=
 =?utf-8?B?QkYzWGhsL2pXRVFSaUhzV3Bva2s5MWVoL3ROOG9ZWml2OXNkLzROUDZFckJC?=
 =?utf-8?B?YkNqczU5SW5UbE5aMHhYanpIZG9lQ0lDeXVudDVneXZPSVllcXBzS0xYaU9M?=
 =?utf-8?B?OHBpMHE3a3FrakEzdHZ5a0Z2dWtXVGsvQy85azlvdVBTd0FEQ1pSd1JaUExY?=
 =?utf-8?B?SVJGVEE2MnRNWjJoeUJTUzdqTTRLV0IrUTFjMW9GMWFZQnNPemxqM3J3ZHRW?=
 =?utf-8?B?TUt3ODkycytPdGZVUldEL05NR0p4SW5KTEM2aUd6OTh6WDFZbU8ydUxEeFJp?=
 =?utf-8?B?M3NPMHYyYlVXWGdlS1FiN3B2QjBXTVdTZ3hNZXF6K2phYnhIeXdQQ3ZkVzly?=
 =?utf-8?B?eFNWRi9wMjRhK3VWQ2J3Q0l3YjJTOFV5VWZxT2poditqMUQwNVFaQVBtdnJT?=
 =?utf-8?B?TDc2T1NKcXdwMG1OMFhmTWtvNmtQVDNSbjBpdThZSlRCN2xBU0dCRDZueGxO?=
 =?utf-8?B?Z3ZxS3NTTW5nRmo5ZlRYK0o4RTNJeGg1SWk4QTJuVmpzVVlRMFVpZVpPMVhG?=
 =?utf-8?B?VW9PbXlWYTh3UWxyQ1FhUTQ1STJaTFFZMURPUkl5MTFQdWVtQkFWZEFJdTBl?=
 =?utf-8?B?RWRmN01wdHBvV1lwMDFNdllMcXJ4NlUrY0RabHBsTUJZNVF6MkxEUmt6RmpV?=
 =?utf-8?B?NVNwRWREQTRiTE9NOGFHei8yUGtpOU5qK1RlaVIxeGd5NUpPUkVYc1dlc0F1?=
 =?utf-8?B?MXBmSUJZNVd0OWgxMy9BRG0yMEVvQW1iMzhTZCtOcCtaNXN2WGVicGF3U3A4?=
 =?utf-8?B?eFI1MXB6S2p5YnR4QkVxOTkwVTlUZTJ2Z256ZWlxZHE5RXpMUGNjVHJvMDZD?=
 =?utf-8?B?dXNKZHBpa1hEQ0RJYkRNU2JpL0RwUHc3dUZ3eUM4ZnY3M1RENWlMb1NsLzA2?=
 =?utf-8?B?S1ZYQ3NKUlZtZVU1ZDIrT3p5UW82eFlDQ3JuamZZcGEwUDljVkVXakk4dVZG?=
 =?utf-8?Q?1xjEWhfsnUYyIvBx/8FUlkqUB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f95ed3f1-1283-4f98-6d44-08dc3a3a055a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 21:53:25.3191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qRMEIEw1PeBUnfcmhatIfT7DH4j/JdH9SRdeZhP7wJmggZmunCOoYZ8DQXQCQ5G2s9nKbAfHtzvM0kNqzHfmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6781
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:
> > Additional event testing using the cxl-event.h header revealed that it
> > did not include the correct headers for the types used.  Compile errors
> > such as:
> > 
> > 	include/linux/cxl-event.h|11 col 9| error: unknown type name ‘u8’
> > 
> > ... were seen.
> 
> Were seen where? Should this have the trio of Reported-by: Closes: and
> Fixes tags?

As I said after this in the commit message:

	"Omit the fixes tag because this does not cause any issues until
	the header is used again in other code."

I'll clarify it was seen when I used cxl-event.h in the testing code and
this happened.

Ira

