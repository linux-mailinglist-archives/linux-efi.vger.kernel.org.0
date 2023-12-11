Return-Path: <linux-efi+bounces-184-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2569980DF17
	for <lists+linux-efi@lfdr.de>; Tue, 12 Dec 2023 00:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDCF228261C
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 23:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B829B56455;
	Mon, 11 Dec 2023 23:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UowaUFPj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6CAA9;
	Mon, 11 Dec 2023 15:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702335699; x=1733871699;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5Dbm3VLYUqwS8gGeI/UtJwpMYKRBB4ZOJl3ntA97nQs=;
  b=UowaUFPj1Lms4VVkXMy+nWIdv0QC/IdPDpdpb/F2SXndtbSHAmsu1vxT
   XDugWHbzjiCRTaPstAm/4b0kJeFSEgLDH7zZMJ2QOtzKhdPfpN/ooo5bJ
   l7Bf3QlLCoqgBPCQ/HXTCu52hI22EhjooxhuzIGzwYWSLUh5UMrvZrQ8R
   vdNKu+MNeiIxmnbUE3UvJ4fiKn0AEJs17e25wfUFNK4ZtIUwZce504ULS
   ioV3Jt7aUzR4HhpqrPXRGh951zQzJq4GLw4zxS9Xg1HxXpIxCJfFqZZMr
   jnUSokNOFk/By1kmaOIKCO8+SbY/448aNn3PhS1TUvZ4+/ASDSpiksMVr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="480919093"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="480919093"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 15:01:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="863976111"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="863976111"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 15:01:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 15:01:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 15:01:37 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 15:01:37 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 15:01:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QobaBbAYaOPmW2Y7s1xLIuh24EZjvwzaXoKX2Jvvv7vNl40eEYegH+F9zxi7sfZXm60ebKoEut2AByPjd1DPCuLXACQg32UK/+41ujMm+BAPwX9EHAAm5cpBZ0qdyuG7ss6UquJlcl6/z9pAtTl+cUgTuoMAJBu0z13bTY61/8o3TC3dyjswRFzvu5AYej3+PuaNoSzcQTN1E6nFhFHYNOYX2FmDkm5bsQRQzwVuQEuPHEie2hU27gTr+iPskpc6H+NhXxQlDuUPa8TzqhJB0bILa1iGk94M3W/is82n7JUuAQd2AyWWN7ueQPRlHLHnASbLFSHk1NoK/6H4MZsveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/9fTSoDqddcKjgK4Z4QfCZQi/KgGPqf5povjywNEz0=;
 b=mY9onMuHH/Ogy+HJ1/7RhEZT54dsvsKVeBjqr/eBJfPc7wUnRJpgf774FJJJQCCcbgBQsEAZaCoO0trvrza5Yv58Qqv+9sFmyJ8DwpsNA6ZsVIlST8f8UPi3xivLAKB9FOfhSdk+Of696KL2ZOCixWDzFnadaRC/X2M4vbYXxq2K5ZcX/QtrcfEZwspoYqMvbRM3Gv5MAuPubIvDF6b8RkCPoRfa1j4QzPR6+HJrkJQ1bnpeKZXCZnFsBvQpIjrkigWUUoYiJdInlX36jlOM+KACULkHl8mQoEMV4EMktZKtH+i0R7Np3hiajyIqeHOc926c7KIvt9K5+BZBqZQRwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB4813.namprd11.prod.outlook.com (2603:10b6:a03:2df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 23:01:33 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 23:01:33 +0000
Date: Mon, 11 Dec 2023 15:01:29 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH 6/6] cxl/memdev: Register for and process CPER events
Message-ID: <657794c952e19_2090d82947c@iweiny-mobl.notmuch>
References: <20230601-cxl-cper-v1-0-d19f1ac18ab6@intel.com>
 <20230601-cxl-cper-v1-6-d19f1ac18ab6@intel.com>
 <657279a68c270_b991294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <657371eec6ac5_1e7d272948d@iweiny-mobl.notmuch>
 <65738e9fc239a_45e0129476@dwillia2-xfh.jf.intel.com.notmuch>
 <65775c98e0b39_1f2db42944f@iweiny-mobl.notmuch>
 <65775ffa7e529_a04c52941d@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65775ffa7e529_a04c52941d@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB4813:EE_
X-MS-Office365-Filtering-Correlation-Id: ab346321-2471-447b-905d-08dbfa9d1e47
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pdt++FOe6SoZkSS1u/HPoU0nxLvivGKnTTBSW8fagJNckbXuGo/RyW+DOvO++Ye/tFJgJAWz95qFEse3j6vqD4WdqtDQY7hKlQcc1FSlykMe9ZB87dik67E1IfzsKVc3TPRQvGx8+11yV4XRFk56MpmpcarJTMAXCF5fvtEkUiypD1PzK8QeN8VulAaNWyoQFRHmb+CbjMEIiLH8TAU+T5WE1ufa0ad86e5r1CGXAKLOR6GrpgwRVQfR6n78fFjVUIV6Dzx/PAfnGgOplsAW1aBho1EsYjwLzQyoehW9INop3VyPPyG+NvvGhuEEFuJU5OrVsd/fllfVw2qyyCMtqmzYNkUcbfnRGKx4m6F19vL7r6W507ZWkMlRec+eifVyhAyLd6vXbCGx9SwzvfF6z7gt+gSWbHxwmJ9jxHp5RVD8sMpHvVSBfBpt6ofeAVbHUanaSSxxxJZHuBfMwvmR15xJox1JzhKb2OjHXu9A0Wa66XYh5gQPmwU9yIQeDQrNqRKFNN5K/Pyqtok/4QQn4jiivPBZKdZJRat+U8Jg2Ylms9G8UWMXMVWbxCthEAxS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6486002)(107886003)(478600001)(6666004)(26005)(6506007)(6512007)(9686003)(82960400001)(86362001)(38100700002)(41300700001)(5660300002)(54906003)(44832011)(66476007)(2906002)(66946007)(110136005)(4326008)(316002)(66556008)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+7B2qvW1wy9r5u4Hg0m+JIRrqXuDlnNar5An6LkeIYwi3HLCtUUM+/UrB5r6?=
 =?us-ascii?Q?UK2wwlnen9OMAbSuEZljTk1grK+/Zx74ltWOAJGyfWznO7NALSaKKg08gc7K?=
 =?us-ascii?Q?i8zvDdnUMyoYKcVA25tXzcwzMtLC5GsmRff3QoBnL7FkKu9gXYgZoCNqoFI6?=
 =?us-ascii?Q?HX66oMIlbWAgQUwPhGHVbbtl6iPpFTmm444Zwa9RBa1W/VjCRqQ+jtnzjyVn?=
 =?us-ascii?Q?0crLSnIO9g+U46seokk6AgAITmpJlGdA96No4juBQuPqpN9iaaLvRcZ8PYoe?=
 =?us-ascii?Q?79IFRMkJHhChvw7b4WLir9szx1i+1lU0QjW5Sq16ZXSY+WF605MKRdWhu0dv?=
 =?us-ascii?Q?4IKylSk2ZDcQhb+PK780eizZz6m3quLr7Hyfv7wcOJ/7P/ZqY0HnWrguA8y0?=
 =?us-ascii?Q?+yxSd8sNufPTEKdrUD82k1xQzncWiF/QaRyApqhjChOb09s1twceWjqbNTBj?=
 =?us-ascii?Q?tUSZcCuVF8lRNfLV6Na1N80Z7DGBaKN7ujtRxU+XoQmxxt0aXW7r0xUDqp0T?=
 =?us-ascii?Q?6OPGhBijV+N7Sf0TY9aOGdlBedtsmkGtKyLMCJgJ+bV+kVc6tQqC0iZOmhoY?=
 =?us-ascii?Q?ohfmQRGN8xyQzucf/vB2GMk+tfae09/mzjNkZlOR43xdPe7YHoj29Le7DhAJ?=
 =?us-ascii?Q?i2uoMujCW03I4hsbdipAZxshZSNh3BeuOI0BVCy73dy9KSewrcZ05qPmL66e?=
 =?us-ascii?Q?1FW1sjfblprHDV12+CrK5mcCx+u9zAGM4Ypm3Dcy1LwrsUeJlU9VGq5yhRVp?=
 =?us-ascii?Q?JhshtRnZEmB21+tqSJd0HIY4RcPqfDuy0/dPIiP63G0S7W77jx6oPO3hD6Zm?=
 =?us-ascii?Q?J/4qbYA9wi+87X3sVvGFwQ6vJi/3Sjkzj9+DhaOS6VcmnDotJOtgyNlE+Kp9?=
 =?us-ascii?Q?+yRy/wNzyoeDRpAk7P3v+cbLIk8E8D4zzidqN3ZuVvqXqE/BLw3ahlohBgfW?=
 =?us-ascii?Q?U8fRldHLNxkv8PT0jeVaqCLalRZQQS56F7dXaifYEPS5ApVra+OTUyU3QaXA?=
 =?us-ascii?Q?1oh1OzadoecIzeixeTkW0zrf3+xmh70YaUxqlE7Zd8KDOcyTzMYrSFN9c9fP?=
 =?us-ascii?Q?3hwMzG4jecuJ5Ii+Zf1ojq9uTUaSAyJ5cSxrQrAtaQWoOcS0rIIbg8HC0qKx?=
 =?us-ascii?Q?/hVjSZBFDy1M+D1+kjj2k5XTK5q39m78d147ZMIlezIYxpwhsEd7IAlHk1QS?=
 =?us-ascii?Q?Sd5ROdF4nMASSJ6l31l2AzlMCXnJxjtUqnC0QWSQqH6ryln7dVI27ryHh9ik?=
 =?us-ascii?Q?Mqh531HmTUttwMrYWVO/8HzbOf7IYbAuntstyzEquLk9R893/Pl0sSakY9yK?=
 =?us-ascii?Q?n9S3Mvxf7yTlrr7oSHOA/IAw5jd68ewQIQtJJf9kRYiweWvM6OvppXvdHNh3?=
 =?us-ascii?Q?XcMHIHO6akJz4n5VL74NU08mz/vKZM9FPTwcYHgOxydj5dwYtlSIlUkHFcwC?=
 =?us-ascii?Q?ooxX/IC6Yggae5etRoYYKygfleIPRxrdTrRg+ho/twDszqnjVBXyQl8nlG6B?=
 =?us-ascii?Q?ysBwK4senu9oeLRyehnQ/bvVFWTQsmNe1oLXs6Yb6LTx6Sv6w0rJEy1eJNOK?=
 =?us-ascii?Q?UM2pcYJJGz6Bj3+P+IgFUksI3uLo9dRDy2as+GMR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab346321-2471-447b-905d-08dbfa9d1e47
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 23:01:33.3563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zSfkQPq0+L+cAwK7VVgtQyGHCnoAJWvGA0TTpQbUP9fWM2OQR5FsaFDtP/wniV34mQzgkuaMfSm1BAhyodFdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4813
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:
> > Dan Williams wrote:
> > > Ira Weiny wrote:
> > > > Dan Williams wrote:
> > > > > Ira Weiny wrote:
> > > > 
> > > 
> > 
> > [snip]
> > 
> > > 
> > > > #define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
> > > > static void cxl_cper_event_call(struct cxl_cper_notifier_data *nd)
> > > 
> > > Is struct cxl_cper_notifier_data needed anymore, just pass the record
> > > reference?
> > 
> > I think so because the type of record is ID'ed by the GUID which is not
> > part of the common record.  So the notifier data adds the cxl_event_type
> > enum.
> 
> Ah, yup, but then I wonder if CPER can just do the GUID to type enum
> lookup and keep the CXL side GUID-free? I.e. just pass the type as a
> separate argument.

Just saw this after I sent V2.  Yes the CXL side is GUID free, has been
since an early RFC.  But the data structure has the event in it.

If you want I can change the callback signature but it seems reasonable to
me as it is in V2.

Sorry for not catching this before I sent it out,
Ira

