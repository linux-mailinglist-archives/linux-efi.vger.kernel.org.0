Return-Path: <linux-efi+bounces-310-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF638236B5
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 21:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD841F23A88
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 20:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBCC14F63;
	Wed,  3 Jan 2024 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fG5yr02I"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE11D522;
	Wed,  3 Jan 2024 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704314450; x=1735850450;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vBFViuDIoZhlKsYQzcvzJ+KUEfuL/Qq5ElgFOcRgBLI=;
  b=fG5yr02IgeDmrMS7G8nepg0DDiAEs7qI5mcay5ap5MKhZJS3x8Q0DApm
   rrzo9LDM3Uc5ZA3wn4b1YP3bA+LIARUPh+hDhd3G9XKE7HpUN03AtAtZG
   C6VTRkJxliUKdosrIxz71YTGnxE8VWKHHgisQ0O1ZVAVJHXwOcyu6w6zM
   YSMua0ruk4eWsad+8fsdN9Mh+tEBM0CfNz7jd8SL5O7aHfoKWNpt9Gf3z
   CAx6D01ZhM3cAABsRTT7sum2RHwZfbUgjo0ikeFnKIOsK/kk4tEcD4M7R
   8pqe8bZNC8QiDqo+hOPYTVaeYxfS4+GbUgKyc21vwBAodNA35Z/gLWEQ7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="483244082"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="483244082"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 12:40:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="14601652"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 12:40:49 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 12:40:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 12:40:48 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 12:40:48 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 12:40:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBijK9WPHli44ruZR9zpJdDsbLYmLE8S16DvVaqb4mLWtjay9x8MUGa/ryzt6v9n2ogXhR/4UOqoDJoA3yjlG6mKkDhW63XnwoJaDaZWGmA7TqxAmRaZpTldpZamHSSR8jexIUlbbbJZPSe6ygvVFgTiL8m/ff2zyfENal26P/en7Vp6uhFCDWmcmEHQX3prz3eRETZDG4a+/hB2SdV4O9vmtDInXezXEsIWn7r1MFyob0d0M9MObmtJwDEWJ8Cz7q4xAM7GBl8r2q+PSNwn9KVR6y42ybu+IHaozMpWz3GImlhOW4q51w70FBXFNU3KgyhVd5v6cKvT/6BPSuYsDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOiuO8H60D1TZ9v8znbNPhFkhIXe5ey0/BPHQrJsGqM=;
 b=eGqgn5MXqHOrEhbhunkZQm2PC/WYV89KS7tBWDwJDmbPeLa84UQDaha8p1ot9m7Zh01wYDsUhqzfMmVU3Wy9/BiJtQgG4+gs49DV2q0mqy36GNU5ll81zWD6eSc63jPICwTj37mo5wjfRyTkWxj0Kn9ko5dA9JpHg3PlwQJ5a3WW4cbnKVy4RaJfm1NUDc7onb4kPvjUmo49yd9SJapzC3fkAIGGtb/H/PwdY7bMLPKMtABHKr8yiIzHExTq8nMNnG2Z+6gU/V1FZtMtSzG55aKZ4a1M3WRc9F2BlGz7SIVtWTMW7qscASvwBQ7moe4eizX6PMTuipEd4WqIgjERbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA0PR11MB4622.namprd11.prod.outlook.com (2603:10b6:806:9c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 20:40:40 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 20:40:40 +0000
Date: Wed, 3 Jan 2024 12:40:36 -0800
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
Message-ID: <6595c64488aa3_230829485@iweiny-mobl.notmuch>
References: <20230601-cxl-cper-v4-0-47bb901f135e@intel.com>
 <20230601-cxl-cper-v4-5-47bb901f135e@intel.com>
 <7ec6d2af-c860-9b05-7eaf-c82f50f8e66e@amd.com>
 <65674a71ef4d0_a1b25294e4@iweiny-mobl.notmuch>
 <20231213171351.00004579@Huawei.com>
 <657a2ff3bcc0b_25c9c7294ab@iweiny-mobl.notmuch>
 <20231219171210.000078a6@Huawei.com>
 <20240103175047.00001a55@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240103175047.00001a55@Huawei.com>
X-ClientProxiedBy: BYAPR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA0PR11MB4622:EE_
X-MS-Office365-Filtering-Correlation-Id: d1487bdb-fb89-4f38-dc45-08dc0c9c3fcd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H6Q0fnfV7B3iQp6Lhq2Q4ynPhF6uhKHqIAgP3eRrUdmPNXi/K6iJC1+GNtqzDlukr3b/e1MYYorEEKT5qA8BocW7sdcTVdl75cQU458lv54eBjZhWvEaABg4c+M1tgm3RkJl670gVzbfaBNkhr1VImZUWKVo8nLWHfP6bmPmiR/mphZOgqsugFk8s2USAOuKmmNmh/8b5KdygtLk1SRD4/0yPMyyjh14aRQbpB9R80qWfIOJsNEVm1SKRh0xup7xGxPQWVdgGLbxBxdGyMa3ZDlIg2BR7EIX/MiAVe1ySjkT1W2u5eLyeVjX5/X1XOMBGhreB0ZqLdpHIaXYcCeHRrVScjPGbz/nn1Xs6zDaPDTN81SiHjMeoE/+e2UUHOMv6Hdsg+0jXImimdLeUD/UhbmQwexD03SCv1PUIc/URu5W0wTPW6uQJnNyGiJpwk7uwvwopjrM6exWqPL6lOoD7Ir9nl/HDHFY+XzkpDfqcnXxMVs1vhJNw1AfIpYSY/FQ63K9n1O6i+72QjHPbD7IIgM2Y5gG3S/6U+EOVCW124L0jR/yzp66JAh2LhRZ1bBX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(66899024)(83380400001)(26005)(2906002)(41300700001)(82960400001)(8936002)(316002)(8676002)(54906003)(5660300002)(110136005)(6666004)(44832011)(4326008)(6506007)(66946007)(6512007)(6486002)(9686003)(66556008)(66476007)(38100700002)(478600001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JpsFxOb/cW1X6z/wxXfZPZckLvzadfaOgyfT6nd53pBl8fyMKSrSIMnzqV35?=
 =?us-ascii?Q?vl72RexVHKjHe9O/+oeUQCxWnsPoDQ5KPJveUIcUBUjo3pj2AqV1BZEoTl4K?=
 =?us-ascii?Q?i+NBbaSmzdT3lZXknvX7ow3fW4WPAwE8p/b/aPwzD1M3wFway9bJvAfG2zQQ?=
 =?us-ascii?Q?BlvzR5SaN6BXvKG0k/zqyiZ/kv1zsjBUGS7rK1TLDwV8ZvgtSnXFAC1A2WQq?=
 =?us-ascii?Q?WJrY5xd5GJoaFUzOCkZ1WhmcTsNYN2kvk4TEMNtUeO8d8bNJUosdnCitRGgO?=
 =?us-ascii?Q?ulWwmqi6uDpj4/2GgJu1H/wh00zmkr7csB/6TGfqyZF9EBI/oZRK4xshwOUr?=
 =?us-ascii?Q?FhenNPAyuLy8CdQOZMHbWjUzFUym5BiOQm1qyL3VPnVVL5UB7BLx337MC80Y?=
 =?us-ascii?Q?FfX45gP0xrMog52vFba77MYCRUXwVZrebrtl0lzUcB5wPMhdvqL8nIV+8dsg?=
 =?us-ascii?Q?EI7q7U7Sl/Ynjlpd9tsotZ+lntTn1K9EAqtdvfIxT/aB4GaCK7QmHuDv1W+4?=
 =?us-ascii?Q?GAOrnRY6hr5RnUbucIoGrb5zgz8g5bMKwlSlppvHLNf53ofZQVmURNi9jSEU?=
 =?us-ascii?Q?qx5bsh9v0ZACnB5q9p/dFvwNogRUuXqTn3HaO1Y9UdKWR/YXLZFa+KsiMCAQ?=
 =?us-ascii?Q?TCf3Nad7+SvreF5gF3fes/tHSnUA9ZTnMA4N/7NRfI3tf29AdSMAb018OSik?=
 =?us-ascii?Q?nkImHltjaed/pwD+vxc4NNls8U+yBVFpYoDyADFHPm6HQOTPI3l9hE/66qAL?=
 =?us-ascii?Q?oC7+4OHKc+1BKC22z7ceNGDvYInLpVbRJmMa+j5QW83nS/6G+ynXuiaTC+4P?=
 =?us-ascii?Q?rsK+CE6g/mSmv8JlMKOzu8dLasMGU+Z8sdNnl96fbA8RnJOSInm4l7gkgvzk?=
 =?us-ascii?Q?ehQPaPPuA2nKZlQrQTmHMnjnLV923G5lJk+jgpXUX6XOEMiIp0t44leUZQjg?=
 =?us-ascii?Q?sBgrWMjPuUdKKT7Llb2jp029nKBJtdOMghoeDkwrTpkmoJ4ZNILshArZ+YjF?=
 =?us-ascii?Q?wXVOdUbB98W03P1p2MsmvrphTAYYE0ioBWI/C+YLmAw+rFxd3JwauIjGJpXM?=
 =?us-ascii?Q?LQhaxJAS6TyyuKHL3CHVGEttIKcth6p3D+5hpZLTerjEKlqXmXIV2y7pXEqO?=
 =?us-ascii?Q?EMCVZuwYz08Yfchs+ZZvESw63NKv4SkKAaBpsDDV7gVSP6KdycEBz2Y2Eu//?=
 =?us-ascii?Q?9ePDVAlXA65qD5q16h0CODJ0W7JEL1W7z0RLCkOFy+FQQDdRHFpFu7fhwfqA?=
 =?us-ascii?Q?8b8CZ4gjK5bLcoX6y3Ml+bliTj+8YzPnGU9BIodTzNnolqPQcPFI3H1MUTYT?=
 =?us-ascii?Q?AKrq+5IhUGcLWEUMyJOy6tdOy773iJykVsAly9OPgLFTnTEJJ9aUE/Js587o?=
 =?us-ascii?Q?xYt8aMKqAfgjWjPxvRzVG0jBK+1klUGlP5n8Qhd1008tORMur1EXXAdApH5h?=
 =?us-ascii?Q?oM5+jeUguCeJnxO23mH9j5j6I7guvLmkXG0DOe8MOrB0pHA+rmrOkYXVUC6o?=
 =?us-ascii?Q?UAY5oQNMBpxHJRS+laW5VLOPbMfWPKZTac4qYMGQg5dZVh8neA0ZbxnIDHeE?=
 =?us-ascii?Q?uT1p7hY8FawT8DyN6b66kwmEKNULodUvNcse4lTx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1487bdb-fb89-4f38-dc45-08dc0c9c3fcd
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 20:40:40.6566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGM2A51i/euRgJMlmqwjU5lhZ7UNmmDX/hrmW4vYpzWLqFyEEU0oOFmMoLy7Y58ziE9XVwLusLuvWu2HNNNX8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4622
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Tue, 19 Dec 2023 17:12:10 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Wed, 13 Dec 2023 14:28:03 -0800
> > Ira Weiny <ira.weiny@intel.com> wrote:
> > 
> > > Jonathan Cameron wrote:  
> > > > On Wed, 29 Nov 2023 06:28:01 -0800
> > > > Ira Weiny <ira.weiny@intel.com> wrote:
> > > >     
> > > 
> > > [snip]
> > >   
> > > > > > __packed attribute just for cper_cxl_event_rec still fails to properly 
> > > > > > align structure elements. Looks like, __packed attribute is needed for 
> > > > > > all structs (cper_cxl_event_devid and cper_cxl_event_sn) inside 
> > > > > > cper_cxl_event_rec.
> > > > > > 
> > > > > > Seems easier to use global pragma instead.. I could test and obtain the 
> > > > > > output as expected using pragma..      
> > > > > 
> > > > > I did not know that was acceptable in the kernel but I see you used it in
> > > > > cper_cxl.h before...
> > > > > 
> > > > > Ok I'll do that and spin again.
> > > > > 
> > > > > Thanks so much for testing this!  I was out last week and still don't have
> > > > > a test environment.    
> > > > 
> > > > Easy to hack into QEMU :)  Hmm. I have a CCIX patch set from years ago
> > > > somewhere that does similar. Would be easy to repurposed. Looks like
> > > > I never published them (just told people to ask if they wanted them :( ).
> > > > 
> > > > Anyhow, if useful I can dig them out.    
> > > 
> > > If you have a branch with them with a somewhat latest qemu that could work
> > > too.  
> > They are ancient and based on GHES emulation that got reworked before being
> > merged. I had a quick go at a forwards port but this is a bigger job than
> > I expected. May be a little while :(
> 
> Working again (embarrassingly I had the error source numbers reversed due
> to a merge resolution that went wrong which took me a day to find). I'll flesh
> out the injection but it will basically look like normal error injection
> via qmp (json records) with a bonus parameter to stick them out as via
> GHESv2 / CPER rather than AER internal error.  I've not figured out how
> to wire HEST up for x86 emulation yet though so it's ARM virt only for now.
> (HEST isn't created for x86 qemu machines whereas it is for arm virt with ras=on)
> Obviously that emulation is wrong in all sorts of ways as I should be dealing
> with firmware/OSPM negotiation and setting the messaging up etc but meh
> - it works for exercising the code :)
> 
> On the plus side I get nice trace points using your series and Smita's one.
> Quite a bit of data is 0s at the moment as I'm lazy and it's the end of the day
> here - I'll fix that up later this week as I can see 'everything' in QEMU
> and the register values etc are already handled via the native injection paths.

Thanks for the testing!
Ira

