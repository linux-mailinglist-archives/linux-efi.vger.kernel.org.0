Return-Path: <linux-efi+bounces-379-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7998290E7
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jan 2024 00:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E95F02867CA
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jan 2024 23:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CF737159;
	Tue,  9 Jan 2024 23:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LsQSeA7/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101EA364C1;
	Tue,  9 Jan 2024 23:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704843520; x=1736379520;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xy0vNyWK4NMphtKtF5Twl8XhFt2Jybju4y2NE85IJ2E=;
  b=LsQSeA7/FyhbypPUCEUEPTwLbJzyWwwKoHY0iVlwrqOXEJDl2m10/vyR
   hAfjAXTMDNhdSRIQ2x/f0tryx109FDv0eKf/4EiKiJQNX8I40eifw7pW0
   1sNWvv95OCuCTwuT5EbOlu5dF2uoKKnxad8YaKv7CyTTtPg2BMv29KAua
   1ZCIUTssTFcM4ksF0V3X/LdCPHswkn2STshYbFFBZ/7PUmRxVYiv09c8r
   8DGUMdGH+jMTldDqaaqUVVxUqdtYhlJNxbGbndwM3mDX7WKVqQ7LiThnC
   i7+YcpYC5ekbHWxV4VdIliviLde28NZzT8qiqOdMhLUD7wlGAiKjft/rE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="429540143"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="429540143"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 15:38:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="16440408"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 15:38:39 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 15:38:38 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 15:38:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 15:38:33 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 15:38:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBwSRoli9t51/FyLltbYTZmDsiSSwBXsao9lebyv72AyFMGffT2FhfM3v/2teZC+XxwECtfdN/AIROteOQ4m170zxEFnSSszdvgkOb8B3vPDZxMCLY57aTqH1wErVmbDIQWCKNUoqyp4d2PA5J59t90txtSAA7kUODtgKjt9v4cxdl+zVJ7dU0sraWFUdQk3/KQb81z5jmTaI/k8vWDuHGiB7+TpGsBWhvRveNwdHMJAIkZz9ZPyNqkJ+u+Pax5TMg8yYtO6YiMGRCORavfH/Bt1SHGBlif2x5GhWbsePtzmqNy+UZG2Ic12gjvfOBnKGXaaEJ9/ePlJG/1/0Q0PMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCUsgw683MEk1qoTGdyKY23MukXkcH4UVwcKzxuLlTE=;
 b=S6xvyYLL+gYk9H/OnKr2mkjx53lC3uaqHJIOnwzBahUBG+DCnHcpAfad61RrdiPtsuvA1TbeEtBmQ428Hp5rMdzkLy2AzTQvnTiiqNyFDxI7OiIfFIMjpkKzPCGNm/HIu9ioJIAoWXyWW6lf/KTA9h6l74OWqKF67F1yhdbJePCwETpsyC8SDwwnSUF0gyC3s5AA9t8H76SesaX9OHkFJ/XHfx2Ydnnuvb6J8whKbDPpxhabwmbr772k9XCEEXOPsbnjLfQySyuHfDGtMrzkMyVHGN55yCbMkfNptczmVzx3jjTsyDwoLE0JW0BRjcwVWj+j6wm8JXciZ6K90i+8LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4692.namprd11.prod.outlook.com (2603:10b6:5:2aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Tue, 9 Jan
 2024 23:38:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Tue, 9 Jan 2024
 23:38:31 +0000
Date: Tue, 9 Jan 2024 15:38:28 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5 4/9] cxl/events: Remove passing a UUID to known event
 traces
Message-ID: <659dd8f467dbe_5cee29456@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
 <20231220-cxl-cper-v5-4-1bb8a4ca2c7a@intel.com>
 <20240108132325.00000e9c@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240108132325.00000e9c@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0098.namprd04.prod.outlook.com
 (2603:10b6:303:83::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4692:EE_
X-MS-Office365-Filtering-Correlation-Id: e008c351-e8f5-40b6-5421-08dc116c169c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: swhF1E+ZXEjMmLaQGJNV+MkcrLxndGZzeBcQHQ3Lc+XVvqFeb13mbKHqdEcbVN29axjL5m08V44guXZjWqmTM1SM+hmPWpg794WAXMxQQfaIZq37hV80EhzJoKTLZTHTNDq3jPmD2rHRTClJnX4tgLVYzdkO9Yh9evBfjHjLjC+yrzoCAEVBZNoGP5cHfOwPRAGSJak8hmkYZNrKh2rU1uFehltqdp3dLNbvOJPrCL+5bs8uylre+eWlelqU1dCyxT2TVojpgBgUzKwhTDJtanD6rvJMJ2J0QFwUs2x8JQozdFGeXv1gluFkoXuY5M+4jrhDQyn4ON/Cw6769VoT4SbrxOdVYskwIeugHDKRIqtvz3hU//4v0yy4E1ANS4Kk34DE/xSNmvrJGHj4EYFO/oaOo03RCyl/j4ikUnHC+YzvfcuFdmY4hIh4prOKMtyysVNu7eUSsyQwAf7f2LbzIPcM+0XPZ1qrxIUnBhuqmxhpb5Yxv+eEXnFE1RdQvFeVVMEDJQnhdpxZm+tDtcw4pouC4EVufFvnKiFg8Uju7TpYjrAZlfRcEVYz5Np45Cdf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(6512007)(9686003)(26005)(86362001)(38100700002)(82960400001)(5660300002)(4326008)(6506007)(6666004)(8936002)(6636002)(316002)(8676002)(66476007)(66946007)(110136005)(54906003)(66556008)(2906002)(41300700001)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zjL5qcbEYB11XxGe2Lrvk1EjizsoANnFXq4lpM0gf7YFVeCLTDyOgReGmcAO?=
 =?us-ascii?Q?Lz53jmyHqMtHEExJ4KmwZKhFW5eSJAbp03VEgrmFgJkOhS6VUdOXKx0x/89M?=
 =?us-ascii?Q?x3EEovggsnJfQTFdYupSVft/IhOLe0tQBMcuKT5ttmRuNA4bB+VkZq0mBej3?=
 =?us-ascii?Q?afDNkbsdpLTfENjAMsms7fUh+vZYsoifdcS7LLd/SObJmiCXD/T4guVACZOS?=
 =?us-ascii?Q?HyOozFh9fXDjj3EtkfqA1Sx87BiHjRBJpuQDf4AajFooEku92iENp4GIzpOn?=
 =?us-ascii?Q?QniCDzJ3CCdA6ceIcxTb/tVv1Mk0iufcX8NJMPuavYTEkfBNfCYQORb06sF3?=
 =?us-ascii?Q?JA142m51UZSbItSB3OY+BiKZal1tfwUnNwIlqIWUyrUB9j0GVJb57EnjcZjr?=
 =?us-ascii?Q?/ADxsIvIzWLB909kluxbRpCSrdim7Wx6pqsDPczTfb61hALhDYmitV9+LAO5?=
 =?us-ascii?Q?h04QZJiPu3TSP1DKcnIOuC8r2DT06KUXdQKs457mhkgSI3G04/Snqless6HY?=
 =?us-ascii?Q?ZjUkcVPauYR26RPKzgDXduDEAIwzTn0ZvVk4TjVVxQcG00NCundzqK2zRCq0?=
 =?us-ascii?Q?50bjUKVxSJJaorl05BdVqrCIokDFOK/IjKrMt3dIg8y7DCRdrkWmoDMSSYnw?=
 =?us-ascii?Q?G6s1jOFkJxCGzyf7LJqavJXXPrKkwl+asHY05wrSY17h1f9k5iG0FN8cSUYa?=
 =?us-ascii?Q?MGAf46767049jky+Xis5ioy0FCg1Kwh8SxjSIqwlUDF6/8jv0sVmyLDeTCjO?=
 =?us-ascii?Q?JhVTDlb7vFIH4976/OsUQqsA703qTleP2HY6gPxWyEg2miiIZY4MO04Hhu4r?=
 =?us-ascii?Q?VEydK2zYtuW3IwO26K8Rr0QNh05OCQDAlQASlCGDPOyzqSEd406Zg1eZafU8?=
 =?us-ascii?Q?7wmOY5TE5ajPuR5OgBVZzcB5jlsYoYiZ06vkI0S55MDSWuGFsFi/bHpbOINu?=
 =?us-ascii?Q?WKI71ArbPnUItb7P03yMvx3gzRPyd5LEXtldsXtQsMxbOTbMP7u2s028F73G?=
 =?us-ascii?Q?CoM/VM7STEun1ZmSE1sGVU3oD93Ob3rvLts2+gu3QhAw9coOrYi0UUxAFiuj?=
 =?us-ascii?Q?X0gdbAeDSKiX5lnxpM3dZpoMWfjdyiEc6b3QgK8j2OdJEB+z7Ysl21l+bWDB?=
 =?us-ascii?Q?OoxQ4OBjt47PU7ueSg7khcqAhu+E44G3AUPMPbwBPywtCoeak5rE7VkU9JYo?=
 =?us-ascii?Q?ZjQHtSSui+Frdp2sVn2jWkfAaeWbyCviC6WP+viqR29krRoXWZkxVSqcUJz+?=
 =?us-ascii?Q?9+j7GCBDGtwSBUkTKN3JJbkqqxN0pBAc9kmxn6FwgtPIPQ9JavJZkwdcCnD3?=
 =?us-ascii?Q?OKmIwsSTusLHyIvZzzsQzc7H2xpoyFKoi67aHCZOpfOmInTwZCTATJTBcGQd?=
 =?us-ascii?Q?X1qDeE56DhGE1cHs5y4JCmXQfe6G3dl24kgsUxgRe8Ll3/z0gT/QLSp3oUU6?=
 =?us-ascii?Q?Ta2tEhzi7On2M+A6Cv30tFCTbRsWp0OscHhRfoQXV8KubsyIdAcpsGJnI2sK?=
 =?us-ascii?Q?emldZa8LssuqhmBcwVqJuxCGQTwVJPDgu8Ljf3nqakDPh4Y20Jb4ELJWW10F?=
 =?us-ascii?Q?6nl5vP6wIVondAOt2mak2fMWGBVZEeynO94z/73g+KWaSEvE0dDfI7EOAeu6?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e008c351-e8f5-40b6-5421-08dc116c169c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 23:38:31.5054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LjgvFO66wWqzduMiGxpJuhO6mHJRk83MQOmAsdrn32z5jS+6qBK5lIIhPnx/dnaUGpQRa1dfGSMV4c5f/pBf7pI8gYokh78UNHUtTD1+6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4692
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 20 Dec 2023 16:17:31 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > The UUID data is redundant in the known event trace types.  The addition
> > of static defines allows the trace macros to create the UUID data inside
> > the trace thus removing unnecessary code.
> > 
> > Have well known trace events use static data to set the uuid field based
> > on the event type.
> > 
> > Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> 
> >  	TP_STRUCT__entry(
> >  		CXL_EVT_TP_entry
> > @@ -422,7 +424,8 @@ TRACE_EVENT(cxl_dram,
> >  	),
> >  
> >  	TP_fast_assign(
> > -		CXL_EVT_TP_fast_assign(cxlmd, log, uuid, rec->hdr);
> > +		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
> > +		memcpy(&__entry->hdr_uuid, &CXL_EVENT_DRAM_UUID, sizeof(uuid_t));
> 
> Hmm. Why not
> 
> 		__entry->hdr_uuid = CXL_EVENT_DRAM_UUID;
> ?
> 
> Compiler should be able to squish the stuff in the define down to data as as the
> UUID generation logic is pretty simple.
> 
> I've not emulated the cper records for these yet, so not tested that works beyond
> compiling.

We can follow on with this conversion later as I see other usage of uuid
copying in trace events (bcache for instance). Although I probably would
not replace it with straight assignment and instead use the uuid_copy()
helper. Otherwise, why do {uuid,guid}_copy() helpers exist?

