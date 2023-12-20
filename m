Return-Path: <linux-efi+bounces-269-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF3181AB37
	for <lists+linux-efi@lfdr.de>; Thu, 21 Dec 2023 00:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72599282FAD
	for <lists+linux-efi@lfdr.de>; Wed, 20 Dec 2023 23:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286834B133;
	Wed, 20 Dec 2023 23:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AkpK/phf"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C34D405D0;
	Wed, 20 Dec 2023 23:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703116119; x=1734652119;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+tP6gY3aKGpOlzTwc4CBQeCUpKtNATIzF/wlzAbXCxg=;
  b=AkpK/phfBosCPdzcNj/oqyX7pnZWauRXc4Cr4sd6EGynlRAdVBMJkDf0
   4Fu8NEyWMG1xfNidKOwp5fmZrWDJUx5mG2jChqVZE4Z2qi4C/oEPm9UuA
   rCcIrnm+fiBc/p83u1ZjtQPpijVlK6E9bL4TtUU6hinhbi7UEHymy6rFk
   6ny+xyZSvzv9EWpqqNhHVicxYoRmGkwYueI/eRefF6Urp5OC9T4LtZxKm
   1Wa6ibuf2Jy51NwPlOa0A//GhbBYVOM1yU7I51B1rjPN7OR9DCcgigeSO
   ZE8Pj1JHpfNQc3PCjVUtTJd66seZIhgCWwpoNXhKNl7P2jZsRw0bmlQ3X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="427039457"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="427039457"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 15:48:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="726244143"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="726244143"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 15:48:37 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 15:48:36 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 15:48:36 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 15:48:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6pYoPtwrtHuImAKDdBHW5pXzJOYh37n7x24jw5G8aL2/XHLE+2AXLlN9gSsHURHN5sHFanFu/xItHuLP5mFzzXRVkG9OcB3KbsZV3XxDQFpQnOsmXCzAoYmvi4Rg4OakPOVZGADY2Ner52T8QGzHQU9LVFfuR6GZUGtGfgzQv9nVpID8gaSPmAs1Q0/ANnZezhjvYKqPEATcwFgEQzGEChpJIJhGL2OPA4NeYvfO0Byi12shhpKFYFOoY3A+exqxXRDKbTlk8N2e/+/eqWFH3c1oGG4rkh1bSA3wEpMng/CjOk1CsPKUOYQ/2M6PeLXsFBjpl0fLvpQIX/Zp0berg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvD5zvzCTQD1JAawlV0zg2m/v9dIY4LF5ozfaq7guNw=;
 b=LWzAd/iDiVxN5XtBYq8v3kgylrQiy0miHYaYIqL8c/40I5WLSz/u2wGfYqwusiD0EonZngzDxx4LCG98788epR3UU+5PcnhthqPf62JhsY+DOQHKSDZXz6pdMJniES3SkEtrpxLARzkBCY/l/pHCpyx8Yz1FzeQkqiAXcg7d+ycvfVZ1XFopNIHyl4klHG0XKFJ/T0vr0GmZxAnRQUZoTNCugTtBALIMyZOTzO7wMOHnaRiJtiJIrgZndlqRgmUlcTcFMNjYrbuPp3CNbGgXKnfEft7nv8c5GCPTzXNf7CrpbKRRSinmpyMofZIEEbPKfOLyQzMZ5UafFaFOJf6Rrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB7542.namprd11.prod.outlook.com (2603:10b6:510:28b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 23:48:34 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 23:48:34 +0000
Date: Wed, 20 Dec 2023 15:48:29 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Shiju Jose <shiju.jose@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFC v4 5/6] firmware/efi: Process CXL Component Events
Message-ID: <65837d4ddfd0_34d57294cb@iweiny-mobl.notmuch>
References: <20230601-cxl-cper-v4-0-47bb901f135e@intel.com>
 <20230601-cxl-cper-v4-5-47bb901f135e@intel.com>
 <7ec6d2af-c860-9b05-7eaf-c82f50f8e66e@amd.com>
 <65674a71ef4d0_a1b25294e4@iweiny-mobl.notmuch>
 <20231213171351.00004579@Huawei.com>
 <657a2ff3bcc0b_25c9c7294ab@iweiny-mobl.notmuch>
 <20231219171210.000078a6@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231219171210.000078a6@Huawei.com>
X-ClientProxiedBy: BYAPR05CA0077.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: b87e4194-48e9-4be3-cb37-08dc01b62dc7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jyB95js5K7JP2oR7IeN+Sto7oVjyFqLi+aU4kquQ1QNQ2DN+H73dGQOZ5Hcww9ynnUAIeAoAA2sfNXmpEzyqPAx2PwM0E0R+wIyRaCFvaEGO4+EDS88Q/P42P0cqtCZrn+3gJgh3hBwtnrqFSes9nnW7JJxrhidadhNEJ1RYOFLGdjN33EzVFEllKijdxXkN2CYrwoQ7hyTBgkMq9uOwTG4+U3z8/1V3cfi818OfLgdBrj+w4pVjpoIU5YORm+A6cNm4+qsErDrgTFqk7ibUgeVsXCNfs7J9/PZ7Zr9N9fSARekYs4eqJ+PT+xkmMVO+qIk4MJtCru0uslWGeXHKgaEt/8st/wpXgnHviTExfRGupnPuditZeBjZUci/SxcsrdVKfCE4GNi9iYX4k1uNqE17mREMGumuFG0+zzm6zqAG5HLFD5+IZuM5bhyv3xDnKQJnjMuf9wVuK/kkkQ5uNvZKiGETaigPlxZhJufEV6H1QYD9q0iwIVcxJYGwh87RqTTp6XYLXBAgrx2k4bEgHZI5dLKC2hFuSrgG16Jq73zzyuNm+QBsUnDbNWvKrcsI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(376002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(6512007)(41300700001)(44832011)(66476007)(316002)(478600001)(9686003)(110136005)(86362001)(54906003)(66556008)(66946007)(6666004)(83380400001)(6506007)(5660300002)(26005)(4326008)(8936002)(6486002)(2906002)(8676002)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0UIafOHthSRe4KrmTpMkgZF03cPIWM+JSL+E+Goy8HwnyPTLmufyJnuWek8o?=
 =?us-ascii?Q?gMbOiBJRrezLqcNik3UTJLpiheqC+Sscdm/mgaBWbZ4izoyHzQXMP1Upx/z9?=
 =?us-ascii?Q?6L1IzOohtNKLrjF2JbNEeuISgIglHXR/Xir5rfE5N0Ti7T8UCxIhtl0KXfiV?=
 =?us-ascii?Q?T/+jJAU7xyHsfS6+aCmUrzy20JUOokN+i9fQ6cjSak2dVfbucOHOZDK6XnLJ?=
 =?us-ascii?Q?7l2/fWyZLRu0pAcTRhnmsDstAdplkp9eM3ZnUOsh5xn9yxFAz8HXtBGj03AF?=
 =?us-ascii?Q?vRYSszX/FSLaELGhMKY9Ojm5qupykvXDoPVPWY2LOj8AeXQwO+vkivNz/e0X?=
 =?us-ascii?Q?H1tgyS1BU0+UTfpderSwrQlzIcPzm7TimSTq2g4mPn74sfE/2T48OYfKxs8B?=
 =?us-ascii?Q?yToeG4yJN8zyhyVKAgWDVyEhspcZeti2ZNyZ+VMJajrKVbtsy3Ummx2Q9usv?=
 =?us-ascii?Q?jKLFMZOZ4zPH9uiA+RV7JyPCYDy5zt40R0FrpDpc2BR1TW4rll5vzvk8FYD4?=
 =?us-ascii?Q?ndtcuyYDrRUlLgxAs42vWhDZUT/M/FPXOSCCEr+ca1zhiGUDtnQHZjU7q2+k?=
 =?us-ascii?Q?Jr9F7GNA023iSM1GthBggDs0qbz4r16Ign40zePqfc7cv+d8Pik+zz0FM42L?=
 =?us-ascii?Q?KDJA2dNg9P8pXtfH/gHiVOXa6bKK2b5MNwvfHWnQoI1do8X369raUt3jaWki?=
 =?us-ascii?Q?b05XBBzWsxFFL3+8Ondv4E4qY7qeq4ATv4DLd1NU9aM1bTOuFczYdPXgq77O?=
 =?us-ascii?Q?uwR6rl6FAU7CN6mRZGTvDXXkUTBKz/q2BGVObseGi2KaNqzwJW7mYh1UNF/X?=
 =?us-ascii?Q?c022XfDPqvsCbIYq3hBvC+ehxam+sHnD5se+XkBMP+ba3aZhuXg6I/3uTQU1?=
 =?us-ascii?Q?PuHf8ZAtEKAwnjLr4PzLpt++8Yjz5bnX47L+lqZEvw8l4wASZ6/rVhYHqvDi?=
 =?us-ascii?Q?yakA3TjVBzoy8Eb45xSXtF0ZLRWO3o2EWpDQ+8TfD01EdhtkObrdVNfNm0nZ?=
 =?us-ascii?Q?hZNOv3aqXQj4ru8EO4bFWyGGFo+lwA3fLVegb/ZLADUKQCYYTO5q5yx/ss+t?=
 =?us-ascii?Q?6fDyFA2IwuR0e66nwAJ2630xNYbLsK8o8bvmZ19P353Pvyg47Qz6qJvA7PqJ?=
 =?us-ascii?Q?CSNqpi9jsL/WBfs+Tm/Hj8gXfqiBKZmTVxcDytOwj6aTszTH1kovKupz3PHs?=
 =?us-ascii?Q?a61dBo4hYvbpHPhZLlZRKQpusyK3KQpdIsNKbm80VwYxrrXGNSQT7vRRJ4b6?=
 =?us-ascii?Q?lD/X6ezeAZeAGusy1J8KJ+j5Ft+PKswuIyC1ziIzLTcmgCY4rOqWFJTyghMh?=
 =?us-ascii?Q?XY/WI2kVplifxxs6pjmCuZqk65pYws2SQY4iOQhyAhlTPJtEv2443QERBbYf?=
 =?us-ascii?Q?MgZ7KuxZbv1DcPOVRhlD8GZK9mNdeihSNn1O3b2XNxkZ7DF9a3SLn1MsClAB?=
 =?us-ascii?Q?2bv0Ooo7pqS/8t0NY7pJ2jprHSHxuxx1XuLmyQiEFt12636ncz4xL1hmP/nv?=
 =?us-ascii?Q?3NoZGl9HIDtz+mYYUfg2uTOcLqZyUIPQdVPeM+c3ddqPvMWGupCAru+Jv7RZ?=
 =?us-ascii?Q?jmXkFtgo5NylRPe8lBtSX6Iz2bluGYNU7kRqzijH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b87e4194-48e9-4be3-cb37-08dc01b62dc7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 23:48:34.6344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCZgeCTarxgiO/AuKZL4ggcDs6XfhPPeEUlOlyWMdykJhri32OqCWu4/Ri0silEt5HT58YN0vewbKBkpV7Y1hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7542
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 13 Dec 2023 14:28:03 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > Jonathan Cameron wrote:
> > > On Wed, 29 Nov 2023 06:28:01 -0800
> > > Ira Weiny <ira.weiny@intel.com> wrote:
> > >   
> > 
> > [snip]
> > 
> > > > > __packed attribute just for cper_cxl_event_rec still fails to properly 
> > > > > align structure elements. Looks like, __packed attribute is needed for 
> > > > > all structs (cper_cxl_event_devid and cper_cxl_event_sn) inside 
> > > > > cper_cxl_event_rec.
> > > > > 
> > > > > Seems easier to use global pragma instead.. I could test and obtain the 
> > > > > output as expected using pragma..    
> > > > 
> > > > I did not know that was acceptable in the kernel but I see you used it in
> > > > cper_cxl.h before...
> > > > 
> > > > Ok I'll do that and spin again.
> > > > 
> > > > Thanks so much for testing this!  I was out last week and still don't have
> > > > a test environment.  
> > > 
> > > Easy to hack into QEMU :)  Hmm. I have a CCIX patch set from years ago
> > > somewhere that does similar. Would be easy to repurposed. Looks like
> > > I never published them (just told people to ask if they wanted them :( ).
> > > 
> > > Anyhow, if useful I can dig them out.  
> > 
> > If you have a branch with them with a somewhat latest qemu that could work
> > too.
> They are ancient and based on GHES emulation that got reworked before being
> merged. I had a quick go at a forwards port but this is a bigger job than
> I expected. May be a little while :(
> 

Let's not waste the time on it then.  Dan and I would like to get this
merged in 6.8 if possible.

Ira

