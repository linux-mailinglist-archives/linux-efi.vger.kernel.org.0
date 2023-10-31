Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989837DD46F
	for <lists+linux-efi@lfdr.de>; Tue, 31 Oct 2023 18:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344282AbjJaROA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Oct 2023 13:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346014AbjJaRNt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Oct 2023 13:13:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CA4DA;
        Tue, 31 Oct 2023 10:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698772427; x=1730308427;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NjJ67+RGeyc1aboXfZVgmCKDhiwHuo4PxuFtb33xW/4=;
  b=M0voZJjB0eIgmmG+78bb4mdLe/+lP2YF5ZRec82Xtzv4dhCPnG9VQoYt
   GkSRrA4ymNdz1m1HWlTya5h2UDVuOnFeUSPxIIZ64UKSHqHVBUugd8bwp
   LPL0LxSqlqlQ65X4lskz8+sYDrvE/eGAJHA1Hb/iLZiN1EJ3Vuz9L/GtB
   B1zsO8ruUkQvVjP49AhXB979ymu1pgSQHg1SL4F+nHU5OUbyDcoqc0seJ
   QIfX92IwMaZtanmaoVIpH2/DS1gZRHfIX11iCqp/1PZvhEfjmCxlKr8ln
   hL0EE8yHrBiF22N5NU7Ucs4IcLUx7OCHvQ8Okb+yqdXPKSgi79Kstvge3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="368542252"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="368542252"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 10:13:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="8384271"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 10:13:47 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 10:13:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 10:13:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 10:13:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coCmPgBstIau9DIjqaXUPSl+/G/+rSFMprDachKJi1NZbQYoL3ji0AjrhcKBgD0RA4QpmHVU7tV3kPYXN5IgR8YxM1MdU/e+lSQbCUIdHbkmW47a2dloTNHm/Sprpbre+A7sgWZCEpYJBm4uv0AkqQtOk20MBq4v/mjQhawoafkTahM6qb6FPnzhLFbw2dgZtfF/nbZ5WUbxZscTp29w3vZ6Z68ZFfMAaL6NxaYBdw3VQPfgVgJ49Z4ycUYKmRkuH6hHKeUYQs5R+Xz83LPCiTKfp0W86paKcwP7/RIunVs32/MbKiY6s/iVSYhDnijVxTFJD8zcb6rhmGTSzjNS9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szu+z/TqVc4TgRTFplogEH8d5BJk/94Hoy81ndyqCPc=;
 b=IViu/b4/0z1tljl3i0879OFULoY82H0tfzbiAu8Yk8pJL75yAP3LFI3Ul2039StBmPVssHGcKsyouxYwakvAgSDg/NTenGbWMDQOCtPFEKQATkp93kKPUYeUm3L/I2nn1iKUUb3rx/9GLqX/uCYHFLCegf3DOQ2y18Zft/6l63ZQPO6NZaCIgsikSOynj5aZiUVYxuY2n3M9pNxIdULH6Rf5Ad/0swtciETU2otOYa55eYFsd5J8JhHzdi+blr6IkzptJnsiRyIjOY+Q1ljk/vlNfDx4AtF/jdMlzkIUZbvBf11Ck/4/bSOsFudmKYD/islZsV4ZQCpc4Mx1HOOHsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB8273.namprd11.prod.outlook.com (2603:10b6:510:1ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 17:13:43 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6874:74cc:1c23:7f1c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6874:74cc:1c23:7f1c%4]) with mapi id 15.20.6933.028; Tue, 31 Oct 2023
 17:13:42 +0000
Date:   Tue, 31 Oct 2023 10:13:40 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ard Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: RE: [PATCH RFC v2 3/3] cxl/memdev: Register for and process CPER
 events
Message-ID: <654135c4f3e0_2e75b2949e@iweiny-mobl.notmuch>
References: <20230601-cxl-cper-v2-0-314d9c36ab02@intel.com>
 <20230601-cxl-cper-v2-3-314d9c36ab02@intel.com>
 <653aee8ad2717_780ef29418@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <653aee8ad2717_780ef29418@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR01CA0028.prod.exchangelabs.com (2603:10b6:a02:80::41)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e4d141-bec0-46ed-0280-08dbda34bb9f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IW9DryTBvSpq/A50OgF0nne5s+k+aRjGdfyt+WJF8Kr/1/TrMKh6J4A/y2B6TG+T7BNnzW6Llfhy3aXj1EiV/ISR8LdU514ylaQfiVH8v1f4V1BFBISBCKyVu5gnxsiaHnWPGuYbn79D5b6s8shhutWP7xZOxPgyWloE6yntSRLSxYdi18QvJhsi3cChVLBybvVFpqnRoqd545Xw/cxj7CaEtIJ0+Y95D8HUsgXq/H08mc65Lr6OFy276vmgyzp4k3ZSLoXRdfzz0TtyjSCexMFzfvpCRFKblqESqJhy4O9v9FiCCjQEmhKzrNXQE3x0Umzx6r4b9mqRqc6aHSeOcs4ev3JCVMCnrPb0cXAwwyC2XPY6F34rVqtuZ92GNYtwCWW97YLE/Zcbxc3q82lnDqxm8VYgrVBw3baOWxLY1R6MFvGWHsYVEzpB2alCULdHcjDsl0o2GYCcGcBEcOl5pr9xeT/cbeTqkIwSUcXoFyOo088JeXYosrzFXyXq4KBcQ9lLJmoYfsd4PZAXNXWHoEx/9LXp2FjO1ILKDZyo7QT7RZ8PhusXgt3TG7P77MAt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(86362001)(82960400001)(2906002)(107886003)(6512007)(9686003)(6486002)(41300700001)(478600001)(8936002)(8676002)(4326008)(44832011)(83380400001)(26005)(6506007)(5660300002)(66556008)(110136005)(316002)(66946007)(54906003)(66476007)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dirKpfbRGxrRXfu2Q0yiG7OuAZI+RWyB4/OjEQ9teuNfbhrnDA7MdpEqHNpW?=
 =?us-ascii?Q?F34kcMoG6IFh+jVtWgtbpQ4gdpePSpGKUG8rdgH904zVuBiJmO4huTyz7PnG?=
 =?us-ascii?Q?vCUnZ8DhlWUYijyKfX0b/iCxsSNsR42FzTPiGz/FbTtw8qTNsYvsFY49am94?=
 =?us-ascii?Q?TmBLkT1tFliBBwSICIcL05D/27wcQSSzJtUcUgegl/wTsXLco3dFxzrqx0Pf?=
 =?us-ascii?Q?Gx4InAhgEb4P0WEYBwX6DtNP/13qPU3N/Y1NY+27A5RoCrId2GddAg5UqEyt?=
 =?us-ascii?Q?CLx9s+124UnmXxqqR8+MCFfeEHr0zofScpF59q2dA21h+Pl+ZrS2ZRQnpnIS?=
 =?us-ascii?Q?XU7+0ZdrGBtDjOpTL3b/XH79no37mczLZlPgovKyMrxKq3K58gTKp14K8FAR?=
 =?us-ascii?Q?Bpe9cZKFpXxVZfbqWWtO7sopxwx8RwRSRiVBZOwhsFK5StBLrYOm1n7Jj3q/?=
 =?us-ascii?Q?F9c5TkiiK32ynPy0brg6LZ7vYCcsgfGJcW8vc4GCM6OwlW8hV1Nf+AkvcFQT?=
 =?us-ascii?Q?VoBdVwXN6q/4GybMYx5xlxHv5Y96Qyehaq0wNO+36T8mczaGBbLoDQTk+0/h?=
 =?us-ascii?Q?Mo1CCQqwJKc9+GfRCMmppj/7k7XDwMvxD160xAusyXjybrpuaWnK9z0Hc6j3?=
 =?us-ascii?Q?31XvcCXgdGjgpG4v/F2S1ww7IKfSi3+P+JexYdN3+9AkzVID4dod89iRkqt0?=
 =?us-ascii?Q?4t8elhkxxO9fQEUub4LAj4CfjX0PvDur6sGeQM4DQtSF7KBrtcH1xdwbpBmR?=
 =?us-ascii?Q?/jkx4QXEiZ50PUhK6OgXs0OoI97LK/XiBuJQoRkHaA3f2q7KX/zhW8xQfUk2?=
 =?us-ascii?Q?sUZHm7P/KeY7cT8Gbl6ha71Xt3exVe2eAchlBIWJR/64GilcDAYHGPBe0t4f?=
 =?us-ascii?Q?S9ZScAsMfSrYIC3mB8y+zSRMg0G53j0RSjK0Ng5xv+yJ8QWedGH0mRRufUtu?=
 =?us-ascii?Q?tvgUL1k2T0FbcStBChkC7UF9ofu+EtUcui9WOhOaZ0hll/fEiTMu5wLq04mS?=
 =?us-ascii?Q?3b/xe/VY5U717yTG3TrFbBIVqfOlWe0L9aM6MM21ZoDF7KK9E1Syb0OXqzhb?=
 =?us-ascii?Q?qA2Q7w8rqjSC3FbRksX2NYbEjW/rsj6DVwfnvBgmfTLXIsqB1WO6ZiOSHzDq?=
 =?us-ascii?Q?rDn+NzYeK45iGrrXbzMsIWPMVxIJ6voM1fyAMxSoxhReQ+IUINpDxksGZwSn?=
 =?us-ascii?Q?1vdcAlC3ZFd8fv5VyCwCeDAhysHZ3Lz6BJlXtiTZpgh501aC5TjSVuXHhutc?=
 =?us-ascii?Q?KSonVnIYj4DKAqckFK4aMxhkMRP3Cu1xY3j5CJgAFNWC4MzrH9tzzITzUMpH?=
 =?us-ascii?Q?mLXY2ZDVSnFBKahHnku29fXpQo6vfMWFQav1xMAWj0ungPU9qV6dQaZ2z+Bz?=
 =?us-ascii?Q?g3rjUQaXt8SD+8mu3RFThgh7FdJRaIdbx/s4Jz9ztO/3RCz/3p4fKJ3UX8tF?=
 =?us-ascii?Q?L+sUv/k9/sl42EwgW5Hn3q6CCDbuG63UEwosOhhjEmXIHQzxIK375Mzh1B9V?=
 =?us-ascii?Q?nGaHJIz6O5lefi6+fvaht5AIqREJ80rOdEKN18CkTQo+DNRGwT2uf8qneGei?=
 =?us-ascii?Q?EjU09hz6nWBPdxzQaPZUrQHjEtJY5OJi5Mka8f3H?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e4d141-bec0-46ed-0280-08dbda34bb9f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 17:13:42.6780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peH7Eb4KBcspi7iWDn3PTxbrO7iLnJqS1s2J90S7dm9Bvo8kZPCuNFdXqzs9OLNO1WbbV/UhwzL1koqiHCaIew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8273
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Dan Williams wrote:
> Ira Weiny wrote:
> > If the firmware has configured CXL event support to be firmware first
> > the OS can process those events through CPER records.  Matching memory
> > devices to the CPER records can be done via the serial number which is
> > part of the CPER record header.
> > 
> > Detect firmware first, register a notifier callback for each memdev, and
> > trace events when they match a device registered.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> [..]
> 
> The changes requested in patch2 cover all of the comments I currently
> have on this patch, just one more cleanup below:
> 
> > +#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
> > +int cxl_cper_event_call(struct notifier_block *nb, unsigned long action, void *data)
> > +{
> > +	struct cxl_cper_notifier_data *nd = data;
> > +	struct cxl_event_record_raw record = (struct cxl_event_record_raw) {
> > +		.hdr.id = UUID_INIT(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
> > +	};
> 
> Just do:
> 
> 	struct cxl_event_record_raw record = { 0 };
> 
> ...and the compiler will take care of the rest as initializing any field
> automatically initializes everything else to zero.

Not quite sure what I was thinking.

This works better but I think I can avoid needing this initialization all
together by reworking the structures.  For now I have made the change and
I'll see how it falls out.

Thanks,
Ira
