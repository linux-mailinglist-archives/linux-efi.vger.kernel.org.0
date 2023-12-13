Return-Path: <linux-efi+bounces-207-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A6781216D
	for <lists+linux-efi@lfdr.de>; Wed, 13 Dec 2023 23:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671061C21280
	for <lists+linux-efi@lfdr.de>; Wed, 13 Dec 2023 22:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4298182B;
	Wed, 13 Dec 2023 22:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g3LpNoR9"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DA4BD;
	Wed, 13 Dec 2023 14:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702506492; x=1734042492;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=62MDjZa1Cos8zcMZfKNfMWi+0bxB9KSEvOJcOW5kMZg=;
  b=g3LpNoR9Ae8DeP0obNVniA/Vq0+PakUB0U+JjCC/FpWSAWb0WxhtuNuF
   Jk+bzfRdJlz1huGLe5fWI3WQro2/aidqnM3UA/1ww+vF2yE33cfiF64ro
   5gknHNTBVev4rm9X1WTF/Qbvl3VLuyH5l30q+K9M4pZCT/n0zAmYEe6oE
   IcNCF0aZEXT+D6sX3oXgIsL4whdTxgSXkiEi3OtittpScL+9WN8FValyR
   CUev9tJX0yVFAGC0+YTkQvyoqAuObFv98nby5ZF8N+ZoxlvPy1GxEVITw
   PVhPKcBpS6jiQCkFjv6MPRKNHSBurTzACKFtylhDz2SESKhUHam1m7YTH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="374541691"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="374541691"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 14:28:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="774111372"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="774111372"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 14:28:10 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 14:28:10 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 14:28:10 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 14:28:10 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 14:28:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0SigSkwz2Frkk0L7kB0TB1VAG0fLCFys2qJfhtyFpza5DyzAol3kfc39RtiRgIAyfmBIErRMdjKW0dtH9VWl2bIksTDCuTrrUYXzcgOZtpYVHMTI2D/KXlYe3qR+8rRN7hj+xnAF2xNV2jBqctd+o2hAaLp4oa0a8G0mk+ToF1PGxNe/yvsiVVlMck7Zy2XQWzrQuIDHwjSDIVXfcNYgjWBG6mbl9MAjevfUV5h1nhWIAzGKWNYObInkrIfHwAvEN5TqHU4i+QMTCeCYJmT9bhTWKEdDG70avNxiWZ//7m5pZSm3Nx8iBwWK83olK2V/L4ok6xXsKYW6NPVMWPAkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqQyG86O/S/FOXcD7lSa2kJyYmq7OfnM02CtkQ4F/qo=;
 b=WNM6s6Jpj6UJiIixYYL58q+3yz8/TSsaPc12oDAmuDUsMzMsj3GWOLfwXrh76QYYh51Bf+b5JFPa1SfYStKuH9BEhGfaq2VjDNK7k1Nb6S2gDhI5yyp0blOGD4pgZ/YXJq1JbiGBmrxbg5tNO4ZyfY+idPrXjIK2vtkPAS5YaCNhLakSHd6hUFLcmnR2ZjGfjCnY9ogzg8qaZ+fA3gDwvKvRFlsKaQfOVtxmSWaza56jn0MYSenpTJupPffaeetYtAUC2Pi95YtSqcmleF9OaDFE21wCSZRNKzAcNyLK7HN+c0549qIuYjiVL9QmhkHhiwu8BNe7A9ynFpGF1zggCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY8PR11MB7687.namprd11.prod.outlook.com (2603:10b6:930:74::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Wed, 13 Dec
 2023 22:28:07 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7091.028; Wed, 13 Dec 2023
 22:28:07 +0000
Date: Wed, 13 Dec 2023 14:28:03 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Shiju Jose <shiju.jose@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFC v4 5/6] firmware/efi: Process CXL Component Events
Message-ID: <657a2ff3bcc0b_25c9c7294ab@iweiny-mobl.notmuch>
References: <20230601-cxl-cper-v4-0-47bb901f135e@intel.com>
 <20230601-cxl-cper-v4-5-47bb901f135e@intel.com>
 <7ec6d2af-c860-9b05-7eaf-c82f50f8e66e@amd.com>
 <65674a71ef4d0_a1b25294e4@iweiny-mobl.notmuch>
 <20231213171351.00004579@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231213171351.00004579@Huawei.com>
X-ClientProxiedBy: SJ0PR13CA0056.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY8PR11MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c1a3ace-f9cd-4b3b-9a36-08dbfc2ac7b8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6JkuWLRDHy3kDApQgkBRVwq7V+HAoob78o+d69nE71ISk8uJ546pGThJAQGtIM8JF2wjJD0eq9t6EZ5J4ZyON0pG5wahOwT2WKFaiVTt27/EdxIXbtw42riX5G8ZwwxqGlN7nYY7bBYMGPEpMVYh5r5EtHSOTindSg3wOgqbhNGxmhGWprHqQNqFZ8kY1ybNz9LKBdDw7OxdBAAMRKRx+Wf//X/MLyyecdJm0Kb4JhDjMmYw/FQVtS+Os+J98pgvUCb9tOEVwWLYxGHALjZJTDICFR8y029U3oRIRzcWn0UctAT7oh2EVP3gU6mDfbEbHJCiyrTm2MZiEp/iFLXymjnOTLl/ZNHvGeRzvTtksgY74Nz0dgx9SwSHAQ5WrRmbMMJjQT2f1GlFKLdXRS8GSE6XU7aeP2HFIUVPDtu3wUZ4I6Kq/rBhOvmWYquqzFOgYUotj8rlrFIvgO/q60k0bjJJRVjhYXbbGFUqFdCzNaybug8aFndy9jzaCLvIDyiErn7APVh9HRTx5rGxu23it7ZgBEaI12346GC0nAyB40BkKCNQvZAvzsi6iBQMdX8b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(86362001)(4326008)(8676002)(8936002)(44832011)(316002)(5660300002)(41300700001)(6486002)(478600001)(6512007)(9686003)(26005)(6666004)(82960400001)(6506007)(83380400001)(110136005)(38100700002)(66946007)(66556008)(66476007)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fwWjiUfk6UVshTWJ9RpNZJmnYgF5kd++vyqkTMDrTgf93xDeP9UAkPLw62uB?=
 =?us-ascii?Q?UliXldWz5upmmXRNF/wuS46ww35T0yE0sDOlIKkMTC92VtyTEDcCYIQ4/8o7?=
 =?us-ascii?Q?vR5jGK1bKsbDutkS7iGD5CI8SjjjwMPJuPbL8eWOacXKeT/eb/O8+iR9iYXO?=
 =?us-ascii?Q?YlQynnX+DiX17vf+FdaQU/XfPYOFqVDJWAFyo5v+7w7HIAJNs06L3VNLSm6x?=
 =?us-ascii?Q?idWUtsqaid72Cl/z38+2DlzVYbCUnAT6/VR03Xrm0iSYUYpHsTceummbhgLs?=
 =?us-ascii?Q?s4uG8zwSCkls8a/HQmFHw58gmQCufbqLqByC4FMuTHijtgMxRiM8LybHwmES?=
 =?us-ascii?Q?POvtpch0XaSQSUwNEW0CTS2ttbPeQOV8nUsiJdWKFbtogke+sgb215okFbVU?=
 =?us-ascii?Q?1moywFwxXMynaNR74Y9ZKm6YYqapvfkWe35GKHUsnLeD6uF+2asR6tamVIaQ?=
 =?us-ascii?Q?MVS7LsgGK//Wv4HxuHdLzfuqyRL5W1LtT99WrU5W1TpR8Cwe/V6X6924btKk?=
 =?us-ascii?Q?M63i87IQOTESYP4mGlTUrkpvnQKy0YIbHZlE8OfjV67OpEoCgsn5/XoUeo9q?=
 =?us-ascii?Q?VitvTMFkhwEkFZDjrkk5CUONXtvfnJA/MUfuy5LwB5F/VdRSpXVhjNKKTicV?=
 =?us-ascii?Q?aKPVEVsI/PABZKSCTrpc48zKVTdTFnsIBYoh//pSsLFEwMiaINZjX+vn12q4?=
 =?us-ascii?Q?pnJxHZGcEM0ikVaEfE0uGhBk0C7PuDiV99fkc/csur56P1fh86sH0bC+eEYy?=
 =?us-ascii?Q?vwW7a79GjtOU+CxeC8cLmbt+Tj8V8fcKlEvYwvOIwRG26CThFJhnGCNFNkyv?=
 =?us-ascii?Q?BZZiaPX9xUR76ddUMlCz8Z9RnliKZrtKUAmzt8bTArl7EJz3zckUeCWohyOG?=
 =?us-ascii?Q?zq6XdRKAN8wZrvKLj1KsmcET1EFhK6/5u8K44MKHdz/perq4xAPtgbsGS8zB?=
 =?us-ascii?Q?wAv9rlDqpAg2NxEXhV2/6rDrLTlY6eiBCzj5K16PIxAb22ZTIPdDXFgz1Ur4?=
 =?us-ascii?Q?4kHqpRAa7IIKj9YuPQqmTdbVj3yZQZ/isSPquYAz4/Sc9DzWUjijEoSfuFbe?=
 =?us-ascii?Q?GXPf6uAvbVN1LGn3ugRJpn7HyX3BhfP15VesZN8tz/oYThrxRoYkS7WjMApc?=
 =?us-ascii?Q?DVfzQAgmUgYaM75rQM2OoOtYQ1ZNjGdHNnnWl9fsfe2GhdcX0BIW9Zxfgotz?=
 =?us-ascii?Q?QeaJTt//OZMtdgHCDvKRVX4ghGmt29+2+5nclFT6oBlGP4329taBOcKWW4tN?=
 =?us-ascii?Q?HwPquvR15QJyYMLNNxjHyPWRIXOBUrmX/8zVpY93GAswp3sSo5ledZG5CujU?=
 =?us-ascii?Q?QdP+hKUzIyHlReKi+aVIbOWHr5Pqsgz36Mf2fz+Ec4dlM47aikZ0NarhuVTO?=
 =?us-ascii?Q?wiG13k/ehAftC7GJ17N6XSCLkq3vB1tVQqUSETWBUDMLYQg7hSu+1zpdsOq4?=
 =?us-ascii?Q?84DzN1kDU48Hh/MVCp55OyKaSQRFWA6rlxGgbE6gCZybPRAQz18RKvuiDS1+?=
 =?us-ascii?Q?+pRQWma674Qvh+sj6g88OdDuRO32LtCydd3jmuMzMp7oRfysR/9AQQUGU3wb?=
 =?us-ascii?Q?nrAl5AHJtUVPFPcXFc5fNv9cS0/sOiI4CKhwPhfv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1a3ace-f9cd-4b3b-9a36-08dbfc2ac7b8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 22:28:07.4101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oeJij8eccGH5qdukUWmMa3ooGu2WrunQtKz0Wp8XGTUJ1NonKiOKrwqI/Ge3GEknFgvq2FqgBj5MXCF44oJ8lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7687
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 29 Nov 2023 06:28:01 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 

[snip]

> > > __packed attribute just for cper_cxl_event_rec still fails to properly 
> > > align structure elements. Looks like, __packed attribute is needed for 
> > > all structs (cper_cxl_event_devid and cper_cxl_event_sn) inside 
> > > cper_cxl_event_rec.
> > > 
> > > Seems easier to use global pragma instead.. I could test and obtain the 
> > > output as expected using pragma..  
> > 
> > I did not know that was acceptable in the kernel but I see you used it in
> > cper_cxl.h before...
> > 
> > Ok I'll do that and spin again.
> > 
> > Thanks so much for testing this!  I was out last week and still don't have
> > a test environment.
> 
> Easy to hack into QEMU :)  Hmm. I have a CCIX patch set from years ago
> somewhere that does similar. Would be easy to repurposed. Looks like
> I never published them (just told people to ask if they wanted them :( ).
> 
> Anyhow, if useful I can dig them out.

If you have a branch with them with a somewhat latest qemu that could work
too.

Ira

