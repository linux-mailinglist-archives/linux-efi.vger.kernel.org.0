Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E8B7DE7DD
	for <lists+linux-efi@lfdr.de>; Wed,  1 Nov 2023 23:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345207AbjKAWAQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Nov 2023 18:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345559AbjKAWAN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Nov 2023 18:00:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6D212F;
        Wed,  1 Nov 2023 14:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698875985; x=1730411985;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oGyCeXryWTPGAF6OmHU9gyu8SRadYVdK/4wo+9vlkZE=;
  b=Kcqt+8syEI9wJPVALoQ0q2+4WzF0h5dAPCDT1xhfxhEmX7buzLmE/JoT
   DCEk+xUtfbQwC05JD50MF/ryhM/gEuCHKAAM1aayDda8xZAnQkoPIodII
   mMMu8Qp5bFU8IHX8UaCBR+9k3yaMzdd96o+4UdHwWjIo+rLT6aWm6A4va
   u3qqV3kUBIt9mj1phxLMEL9+tb7A6ue/UuYYJvl4VRvKYq/FfXphQmVQ4
   XGvJaCZuYkP/wh8CYouQ9dfAodUQE0gI0E45iWt12cPSq+G+YLva1OqZl
   CeO88CM/sQ/AV2O4aArjjvPPxK48dbD1d18C2pDLggt8DMVkrBYdQ9dr/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="392460146"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="392460146"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 14:59:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="790211768"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="790211768"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2023 14:59:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 14:59:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 1 Nov 2023 14:59:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 1 Nov 2023 14:59:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AguNrOet0zuserKLt2Qg8hIELm27myjA3caNfGfKstOuaxt9VW4zMGTZ3kY7+UUEqrUX1dqA3wNt55H+yI5OzcKo9pjNv7ZPn9UEVFcpkrs6gGW5MVn7gw+xTfpFbekvDHvyS2O7mnDav/RFn4W7Qt2KBl1qlk/qbrx2RSmypJXHZkzaIR2jOcvYcTwp7Ns6tLyiqJ2/wBQcmXJxrCDDuJSYLDl10mM0VNV8fl43AX94sio7mhjGJ9sLy8kW4tCMQrPL3RFUIQswI+RanGgBfUZpQCwPLSve2HXYbkSvz8WFjIFKMUU0yzUrLos7cZGuD1OW4BKjdpdlyn/U5tLzEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjBYohj+AKy5Fs+4t11Cu/qxdGcL8pF38CMYyyvNALo=;
 b=hQ1jljWxHdSAk93rTiYHdiNAzRx0Cy1WI5TpbqfFK3hFi6/dVcCgXtHJ/NF0KZkfDKJs7EvcAhLZuB0BcrmBvVlSyK+SVzi3xCDghXdhSGrCRMKl0rmwGp9tO1EApOg/R9a49sYlYwfyoD+RWl000cSouHKcfWZ49pAFxUkk/WGGFENve59gSjDMlbvGfhxVrhTNkDtaiLFDw7BrgBWx/xMDJQ8gYvSKd8R480KgYOfPAL5SUNx72gBaTFj8c8J1BYYjcdGWKHBgL0OW8Yof4yZGEp422qrAovQaJoijCHoYd4VDLt0D47M5KQaIngKs/J5wcWdHDRgGxc0CPxqHBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL3PR11MB5681.namprd11.prod.outlook.com (2603:10b6:208:33c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 21:59:06 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d3b2:2f2:701e:e8c7]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d3b2:2f2:701e:e8c7%4]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 21:59:06 +0000
Date:   Wed, 1 Nov 2023 14:59:01 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
CC:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ard Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFC v2 3/3] cxl/memdev: Register for and process CPER
 events
Message-ID: <6542ca25d2fb7_435c1294aa@iweiny-mobl.notmuch>
References: <20230601-cxl-cper-v2-0-314d9c36ab02@intel.com>
 <20230601-cxl-cper-v2-3-314d9c36ab02@intel.com>
 <81b90308-fdb1-3686-33a3-1e7ec42a7ef8@amd.com>
 <6541c795e39b_2e75b294e0@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6541c795e39b_2e75b294e0@iweiny-mobl.notmuch>
X-ClientProxiedBy: BYAPR11CA0052.namprd11.prod.outlook.com
 (2603:10b6:a03:80::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL3PR11MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c03d86-7379-4f85-89e1-08dbdb25c451
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PnSvNvI4Oy/BqM0u1vYJkgy8Zc4Ve0fra3sKEdE5yPj45ZddmBcu3kgaQ+iT72K223w4hgWcYbevkHwM3Xetc9H2ezqaev3tTEJgol5JGhayuTwFTaD3ZBQFf1m7Fy0D29+5KF0hSXEm3+QgYdbeyj6QxWxUmC5MTTsWp0WGuqL7Dzn6FRZg3hQ8dDtyP/UbyLeGKjtIlObzjBdR22hzolCiIXMgtS+tqJdP+7JPTkuiHA1HBjgzzZFOoIK2hSjMjJ5vUjjoK4v1/d8+4PG5fTSjRP95N9yrvljTmRCRLaQhv3rNqzweo5zv0bPr2NPys+DcDYFGfCeiOv2ZjYD4x9nun4702/8Ifq62RchkybLRUQ6nqzP2PowK8cIdBezigrqeZ2R16WgDxnDbFnWrDAWb++VShfsSFP4FDlmx9qAKIp1RqIjTjzdgjj37Ak+IfcrQWAy8RwuBRHooay50BoVEpixjhPaYGxZitMkyWYsJTdSiFkbVL9cNcmJathlASRBQwzL5Nr6ELonXKFzd8Ou8/H1St8w/lEyABTELqgQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(66899024)(9686003)(6512007)(26005)(478600001)(86362001)(82960400001)(2906002)(38100700002)(83380400001)(4744005)(5660300002)(6506007)(6666004)(8676002)(8936002)(4326008)(66946007)(316002)(54906003)(44832011)(66476007)(66556008)(6486002)(41300700001)(966005)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TzH3+4gvkXtgn6tFHDkbwGEAd0aw/5XN0eupBUlEW/136SeVqc5GnTLVUQzv?=
 =?us-ascii?Q?+fQTGq2odN0naNijfz3tFv10p2CceVZh0k2Pt29eSANEn0FrIdcPTO3VfcLi?=
 =?us-ascii?Q?b82TzBIIaAwrE6HUR9a1NBOMZcqSysVt6ZQKi2XVg3n0ZptsoR93+Jv6IFgi?=
 =?us-ascii?Q?77vVqBBM3dWXbGvzM21Bqf4YlhdL41YTmkkEG3cjTt5gmlzQ8NCc3/cXEYMd?=
 =?us-ascii?Q?VL+/rG2H7EW1LW/tD9ZqKYi1sUHxU3A2ve3YgFvEMVEOewgOC58FScqpgD/e?=
 =?us-ascii?Q?7r15RMJ9NH+2BXnuFZXEc1SFfJ0n9uwz5aPTC2AYsHJ94Td9sy7E26ZZ8kNT?=
 =?us-ascii?Q?yQQ6MPvkfkc5Qcuq5mpRNDUPsUaCUHhOF40NzaZ92Uc7ygVuGskamBquW/OD?=
 =?us-ascii?Q?G5exzDbQSZ6APLokmEJ63owzbpNcYJ04p80UjOwUePQWCjLWvLVF6s/n2lBB?=
 =?us-ascii?Q?28loozS4sIau79I7qP6irA+i9QlvpTK0UjQnqwYgO/BVHy2Q1JHR5cKL0wGG?=
 =?us-ascii?Q?HoAyzm7ds0oKLJwjuZj+XjAd+T6JW4nQlnzJatUUNj09f+wRv+8KIbwckGzX?=
 =?us-ascii?Q?OFVp5MPkTx8thcW5H7KNDyt0SnBRJc+iYqgs+321B2m0XMVB6QFjLNI5hp5Y?=
 =?us-ascii?Q?k4MXvt07y3S9TPRYlGQLPJiXUqQY1HC3EqWHk8F/phiE/ljjprAAPMBRv5xK?=
 =?us-ascii?Q?aY6vLWGpxm7ngw+xJp29RAVzOG/dVW0LkVRsF7z7pJBpyUKesF9PVMlMHDf+?=
 =?us-ascii?Q?7P6tKCokhH3L5lEIS1UhBc08Ugrt5prxqyDTuQ9HV39pr4oZSAvEHICoDwJ5?=
 =?us-ascii?Q?76XdH0rTH70yMAqWJ6JLigz2hc9ZOHzkZGfOzTx7KUbUIHKWOiryL3LA1XDQ?=
 =?us-ascii?Q?RBcHoThm+ioL7o7Te6xLv6y9iNYkcji2q+SmDwOfUJeUlpXy3HBu8j3aokkN?=
 =?us-ascii?Q?RVx3Uh1woAySyQDZ/rfH+9l/sbTu70wbd43ITSYP9HEvcexrqZr+/cbyyfle?=
 =?us-ascii?Q?Qp97Q+6iaPeSGNw+oeFQGz1sHRTY4Mn2CpohWGfvgdywcOg0Pkzd5n8SXPRc?=
 =?us-ascii?Q?GZfFkGvBYx1hnLUnFGBiHMcZv2A8yzRhOpyzh5u6GJz4OGfkon79/09iOtyI?=
 =?us-ascii?Q?s2mOuTzhuSQqXT4Yln/O+QMfBzG3LXksPnuFwagZgHsEU6unsiLiZD4TQ3C9?=
 =?us-ascii?Q?RlbAv1aNy5eZXorbTcr55/l812bl/k0pF3ndCbrNgeFgbOFkW7ePiTPVB0j+?=
 =?us-ascii?Q?/XX8T2ojeSUHTEPd8BU5skJzGerUZAFyOjosU4wJe8snoa93K2L+CDCz69DP?=
 =?us-ascii?Q?/5PO5vMDHybfc9medaWalWF64P/WzZvJn/oanez8e5zg1wZGH07QfnZJIy5u?=
 =?us-ascii?Q?RsCYIZ6Dqh1pfmG8VBPwpWuysOUm7zvLhJduoKRuttZ67zcm/2MK6ZYflWo8?=
 =?us-ascii?Q?l3ERQQ1xGAqWTvfnmXPTihJFBoQ3rhO95B2JK+FNZaHTvwKWUTYOqUJkPePK?=
 =?us-ascii?Q?boF9JguS2DOQ7w4gPgF71NbI7sU7/4NSXE7jcQH8SGLHYMqF8GGj5zv4m2ee?=
 =?us-ascii?Q?Hug7TnhJ06470IGXw+3d4a3P+88wn7ioVWH++FTB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c03d86-7379-4f85-89e1-08dbdb25c451
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 21:59:06.8075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYq5cvTwomV0X5Sai175ryO72nFEPa5LZwb1b+lJ5DnDcaWxqqnHrEqRrOIR09PBTcyFekIX1xPpcXvQm5g7NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5681
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ira Weiny wrote:
> Smita Koralahalli wrote:
> 

[snip]

> > I think we should copy into each 
> > field of struct cxl_event_record_hdr individually starting from length 
> > by pointer arithmetic (which is definitely bad, but I cannot think of a 
> > better way to do this) and then do memcpy for data field in struct 
> > cxl_event_record_raw..
> > 
> > Any other suggestions would be helpful as well.
> 
> Based on Dan's suggestion to share the structures this memcpy can be
> avoided altogether.  Let's see how that works.

memcpy was removed.

> 
> > 
> > I can make these changes and validate it on my end if that works..?
> 
> Any testing would be welcome.  I don't have a test setup readily
> available.

Sorry this took so long but I have a new series with the
headers/structures re-aranged along with the other changes.

https://lore.kernel.org/all/20230601-cxl-cper-v3-0-0189d61f7956@intel.com/

Thanks,
Ira
