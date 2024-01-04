Return-Path: <linux-efi+bounces-335-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC27824876
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 19:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5C71C21F88
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 18:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A8828E21;
	Thu,  4 Jan 2024 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGVoQv3c"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A456728E1E;
	Thu,  4 Jan 2024 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704394764; x=1735930764;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Vb8vz/HoY1iDoXi740eVHYvXpN+0AljwvAZGlxxkPnQ=;
  b=mGVoQv3cqqTdxe/T41cRUx/yHL0mapCxQUUuLkte2puek0jLPiOwLsbA
   jzP+EQYVX7RoWN/zDLFeijxrdl6HdADLFM2F8AdgFPNgY9/QqSvTOA+Ei
   jTGR2zMLd+gYWvnApwCDonlyChlGLoRWBEFYYTwncOOlIqzEOkRiNmEKN
   0rQzna/Cbt7NT6oQESycxcW2gte29cnfULZp6d9OZp5LNnYI1ypuoj9ej
   SGeG5imrPxuiWBILzNuQk6ldFQQaYWsjJLhI40ZR+/emLGJXaxxPOnZ8Z
   jhsj3/PAuzfkGyhgi+jrhcMF4IMagrb+81UVv4VMlP5cEKDnLYfhiSFYI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="401121776"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="401121776"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 10:59:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="780506633"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="780506633"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 10:59:23 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 10:59:22 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 10:59:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 10:59:22 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 10:59:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnPYstqIqZe41d+zM3wvRei8Yb9OszfWAMw1926A+Wp0tAxFurCotk1wKpX0T8DXlxQ+Rt3Cw8epode/V5y5IwCHwUx2GsbWcXR3XCmZ6JW0aeWmKQhGiYHo3O61cCEgUCnKHp58Yoo9jGjQqIYo0jfmFjQpOg6MpUhgNUwDSClv3yDdjDAeYeNmJF2Um6imrP/D9vWgkbMNZzBmbSqhX00ytQPqHNgpAMg/mr58vpBRUjSSbhlJyaOBzUaTJnlx8vO1Nox7lz9BdcP2lG64F6Oc7vFAXsHqgV6j02JliPBOl44camz5D2iG8alYyI2BedGIrzYnj9jHzt2IhfqdAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHyfDF8cqwCV0HxbEdB3maW7oeEr3sSgSnbOwmqNY/c=;
 b=AK3AlaofzZ6iAddoH935/ztEa2cu/QbAwFPnRvJ3hsSNaBroOZsT6ix4vNJMbrHUgbKZ7gzF2HdYJ1O1MWRSpeYkima0oMy4t7wHlMGZijhS0j8rAXKm0TVF7bUkgH2DNtwG/PbeHPJeI7rt6g9BDDq+CzZ2if9x0GvMO6OJ+IsXhvJdmmqbuX/sJG+hZSnqIi1o46cnGjvlDgPiY60/AE74cIEyBcQzXgfmgHq5gppiFKI/MdJEVUGTyenSA94+OAwFuBHjaxK9E4iRiySFifeDRT0g1JByfTvlayqtVppyqUiq4UvJQ9MxdrMl/RvGGp8AyKY0Bz1si3ilFCArKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6536.namprd11.prod.outlook.com (2603:10b6:930:40::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 18:59:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 18:59:19 +0000
Date: Thu, 4 Jan 2024 10:59:16 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v5 8/9] PCI: Define scoped based management functions
Message-ID: <65970003ee9ef_8dc6829412@dwillia2-xfh.jf.intel.com.notmuch>
References: <6595f9eec5986_be70229443@dwillia2-xfh.jf.intel.com.notmuch>
 <20240104183218.GA1820872@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240104183218.GA1820872@bhelgaas>
X-ClientProxiedBy: MW4PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:303:16d::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1ec9bd-0592-41e4-e17a-08dc0d57417a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: paI0+82Sp3d2eNU5Ba63huE5LMNRYEaGHwkmtjW8BHS7vZShtS4lPl7p+9AkFyLXcekPf9scIZD5HfnfWOMtZhrZQppVCpLpphzVq2nLIRz+HAMV2gUPHb4lpheCRREh/i2b0ivb3Ie0UUeW4/VpdpUcdAJaUr9Y5mNSAZJNwjbMTbk+mVe9TlialoVnj2aj22b2axhHaWLhq/IJ39hoolnsPMXUJM5ssw/n9kMebJ2vqdSuIago09pAiAqEvRvxwHOHYpnikZfyHdIp77l2cLKsuPU3vxAqzh7InqFFyPorzf+LSJ+96kihQYKPP5UoygI7cZwBdXrwNdfWutxgnyxPIPOjpq5qCqpudJvEtuWlwZatMitWVBJsf76RJgB0/e+2I562xLcOlm/EzejnmQ3k3t5rsRYw+q0I7SMB6U8rel1o/jbGkscpNtTnSKgTWRctoYha9/TXVtVaOxvcDot8CtZrWgLQpQKYMiuU9vdlnj61TFZ+R1PidwiD+k5q80hDmLmpPTETFtVk/oApBckuJ5B3z4Zo4Q91BGxKkJMTtGtfVUbSrKrVcmDwpv6/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(110136005)(26005)(38100700002)(2906002)(82960400001)(41300700001)(8676002)(316002)(8936002)(54906003)(6666004)(478600001)(7416002)(4326008)(5660300002)(66476007)(66946007)(6506007)(6486002)(9686003)(66556008)(6512007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qyw/CCrSROKclACNcSddqsY0sQnSQ18QfxNvW1A/t5jXWZW50W0r0EePX50D?=
 =?us-ascii?Q?He6mDVvPlALe8nm6xcfpoklqo3J6kKZpeadXPwFsFfXQc4DzCcBNbRdGuIEn?=
 =?us-ascii?Q?k5b+YmdpwRzk/oUZGW0MaSgJfcxExqJOdf5yS+YkE6/pA4JOFz3OWCduWwAg?=
 =?us-ascii?Q?6z34M/zrA6BY9iG5RrHEmp1l/UofT6/KdXWlEwb/r9tSv7cNcsmRRZkYfWMl?=
 =?us-ascii?Q?WmQRwCVUbENebXsd1h+hOjw6m0w0KWuoQjGCyhHfOzceFIOotagP2lTaFtVS?=
 =?us-ascii?Q?/fotBs5n0I0554ikl/O6hilDnue4ounor7gVhT8lWxefTPF42vjjM3Exzy/W?=
 =?us-ascii?Q?ljrbYk1eKJjul1NQW3jVV2Zm1aEV5VpegOKphX8ocuq9TmaA4RYCSDVBBI4G?=
 =?us-ascii?Q?jeFkmpm//3AU/ye2flZ5G4X95gGopSFayhr3FrqEL7ej9Q/MKH/yY7UiJeXp?=
 =?us-ascii?Q?7UZh9yIErtFra9Oixu+h1UgH+xH5fuhTLd+xno1xxGDD3mdFuFo+PH3oWtuv?=
 =?us-ascii?Q?QAb5567vx2EOUaKsAfgU/SoP1MPq8awdKrujqeOAFA5k7iR1kawCMtgtCk58?=
 =?us-ascii?Q?3sGSKTp/CZTve1Lgsbq0X8yHw7EuBgzYgnGISS3mvh3I7UJS7DmSA36Ld1n9?=
 =?us-ascii?Q?isIqvQ8S64YaPePWzPzpxB9f+4UhcbvSlS7qYySFjKAT3cG/NwKTlsQs22AH?=
 =?us-ascii?Q?UKf+iaqFjL8qdDsMnmc9Mq6XQVtTpmYVsNh4DGtsWUNsQo1heRG9GM+HtR8D?=
 =?us-ascii?Q?eu+lwfK1RFgzquNScKAoHZu+6qhYhNFWj5LOLAEi5RrdkCw+RrJNFiL6Idgs?=
 =?us-ascii?Q?aVy6xJRba73B9mD0iSbiE7klJ9p2TA5GtiCsjHHmDmB+zblRCRY1+cWeat6V?=
 =?us-ascii?Q?Bnn47yi9RWElP8s1DmiPJy0x7I+KTc1oLqrmApz8tOL0zO+sM5ahKQLZ6Dkk?=
 =?us-ascii?Q?lmZm9O/QQzW99664zu9JM/FzcC6MTKDMbzPBExL06SrV4Vp9tDbfrNepwibP?=
 =?us-ascii?Q?KjiRhJhrGt4wSoTohiKitHQVn0ZSLNv1k+p+AsFahqYSPK8E2ip0dJ5LWKxq?=
 =?us-ascii?Q?PV2avvwQGuNvw2MeOCrNpnGLA6ziabiUovPyE1Hb8tvDx3087hlrwv2LG0Vd?=
 =?us-ascii?Q?ryshYxv/hhuHi6ImjJ7kJohF9LuHrA0BAHSaw9rvHICAUI92ZoX6vTqm8JSe?=
 =?us-ascii?Q?QKh+jIYq6V8j3/MSSm/+wGXhA4+Zv5NOqeqDgOGems5v90K0DpyPV4P4j86Q?=
 =?us-ascii?Q?6wkcaeEE5J+p+1WuBBDkVJ6j2tuVcY/JaDbzIQwgbFj1acOK3XyxnMgjA5k9?=
 =?us-ascii?Q?QsOQ1dzGrm1lEJhsmyvi9+fhAiwsIjb5RXPiytM7w391vRPuXBLROAgiLcSu?=
 =?us-ascii?Q?SP4tRj3eCKBFVeYDWDHCb7WWueDLShRBEWotcqG5nm6Bbhe1sqqpQFGU2mqB?=
 =?us-ascii?Q?U4L+mOIlMGM9TStyKxAkpHnmdITyuPUoFyXrEAtQWwsjON98cMIoZ6KCHPPu?=
 =?us-ascii?Q?doPdBwpyy4EsMjpGtl69FiShfsdCB8VPJck+rdv5s1lcORuqEnqi1iajnAYC?=
 =?us-ascii?Q?WGEwyBXgrRPYV+9FBI2eaAc7eKsjUhpYYgOoBNtWowNWjg/FD18hT59fxTDN?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1ec9bd-0592-41e4-e17a-08dc0d57417a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 18:59:19.3214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RU90qYfWcT36or7Wo6n0Tqo6nwEQcKVIf/IfGgyHS+fAw4Cub3PYTVo3WDXsBlZlr0VeleBB10p4QnROlMvRUAB4UEBUL5HogLJGsIpPvHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6536
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
[..]
> > ---
> > PCI: Introduce cleanup helpers for device reference counts and locks
> > 
> > The "goto error" pattern is notorious for introducing subtle resource
> > leaks. Use the new cleanup.h helpers for PCI device reference counts and
> > locks.
> > 
> > Similar to the new put_device() and device_lock() cleanup helpers,
> > __free(put_device) and guard(device), define the same for PCI devices,
> > __free(pci_dev_put) and guard(pci_dev).  These helpers eliminate the
> > need for "goto free;" and "goto unlock;" patterns. For example, A
> > 'struct pci_dev *' instance declared as:
> > 
> > 	struct pci_dev *pdev __free(pci_dev_put) = NULL;
> 
> I see several similar __free() uses with NULL initializations in gpio,
> but I think this idiom would be slightly improved if the __free()
> function were more closely associated with the actual pci_dev_get():
> 
>   struct pci_dev *pdev __free(pci_dev_put) = pci_get_device(...);
> 
> Not always possible, I know, but easier to analyze when it is.

I tend to agree, but it does lead to some long lines, for example:

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4fd1f207c84e..549ba4b8294e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -975,15 +975,14 @@ static void cxl_cper_event_call(enum cxl_event_type ev_type,
 				struct cxl_cper_event_rec *rec)
 {
 	struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
-	struct pci_dev *pdev __free(pci_dev_put) = NULL;
 	enum cxl_event_log_type log_type;
 	struct cxl_dev_state *cxlds;
 	unsigned int devfn;
 	u32 hdr_flags;
 
 	devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
-	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
-					   device_id->bus_num, devfn);
+	struct pci_dev *pdev __free(pci_dev_put) = pci_get_domain_bus_and_slot(
+		device_id->segment_num, device_id->bus_num, devfn);
 	if (!pdev)
 		return;
 
...so I think people are choosing the "... __free(x) = NULL;" style for
code density readability.

> 
> > ...will automatically call pci_dev_put() if @pdev is non-NULL when @pdev
> > goes out of scope (automatic variable scope). If a function wants to
> > invoke pci_dev_put() on error, but return @pdev on success, it can do:
> > 
> > 	return no_free_ptr(pdev);
> > 
> > ...or:
> > 
> > 	return_ptr(pdev);
> > 
> > For potential cleanup opportunity there are 587 open-coded calls to
> > pci_dev_put() in the kernel with 65 instances within 10 lines of a goto
> > statement with the CXL driver threatening to add another one.
> > 
> > The guard() helper holds the associated lock for the remainder of the
> > current scope in which it was invoked. So, for example:
> > 
> > 	func(...)
> > 	{
> > 		if (...) {
> > 			...
> > 			guard(pci_dev); /* pci_dev_lock() invoked here */
> > 			...
> > 		} /* <- implied pci_dev_unlock() triggered here */
> > 	}
> 
> Thanks for this!  I had skimmed cleanup.h previously, but it makes a
> lot more sense after your description here.  
> 
> I think a little introduction along these lines would be even more
> useful in cleanup.h since the concept is general and not PCI-specific.

Ok, let me ponder an update here.

> E.g., the motivation (avoid resource leaks with "goto error" pattern),
> a definition of "__free() based cleanup function" (IIUC, a function to
> be run when a variable goes out of scope), maybe something about
> ordering (it's important in the "goto error" pattern that the cleanups
> are done in a specific order; how does that translate to __free()?)

The __free() callbacks are invoked in reverse declaration (FILO) order.
However, as I say that another reviewer recommendation falls out. Be
careful about the variable declaration order diverging from the init
order. 

I.e. save the reader from needing to wonder if there are intra variable
init order dependencies by making it clear that init order ==
declaration order.

> 
> But the commit log above is fine with me.  (It does contain tabs,
> which get slightly mangled when "git log" indents it.)
> 
> > There are 15 invocations of pci_dev_unlock() in the kernel with 5
> > instances within 10 lines of a goto statement. Again, the CXL driver is
> > threatening to add another.
> > 
> > Introduce these helpers to preclude the addition of new more error prone
> > goto put; / goto unlock; sequences. For now, these helpers are used in
> > drivers/cxl/pci.c to allow ACPI error reports to be fed back into the
> > CXL driver associated with the PCI device identified in the report.
> 
> This part is also fine but doesn't seem strictly necessary to me.  I
> think the part about error reports being fed back needs a lot more
> background to understand the connection, and probably only makes sense
> in the context of that patch.

Sure I can trim that out and just say that the CXL driver is one such
occasion where a new goto for pci_dev_put() and pci_dev_unlock() was
about to be introduced.

> > As for reviewing conversions that use these new helpers, one of the
> > gotchas I have found is that it is easy to make a mistake if a goto
> > still exists in the function after the conversion. So unless and until
> > all of the resources a function acquires, that currently need a goto to
> > unwind them on error, can be converted to cleanup.h based helpers it is
> > best not to mix styles.
> > 
> > I think the function documentation in include/linux/cleanup.h does a
> > decent job of explaining how to use the helpers. However, I am happy to
> > suggest some updates if you think it would help.
> 
> Thanks, Dan!
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks, Bjorn!

