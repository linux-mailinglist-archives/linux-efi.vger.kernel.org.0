Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8904B7CE72B
	for <lists+linux-efi@lfdr.de>; Wed, 18 Oct 2023 20:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjJRSsb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Oct 2023 14:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjJRSs3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Oct 2023 14:48:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7570E118;
        Wed, 18 Oct 2023 11:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697654907; x=1729190907;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MftMNrnJsse1n2yysCjZkei1g2R0flk4Bx32/3V6nI4=;
  b=X8NI8ychsmgU1NuiE1QPshAsUnW6iAikxa/z/EhK9ej2aZEQdZJHGLSe
   v6xR4X8ruLaXKS+8nFR7PVhCJSyxB+njndWixVXRAzhHDehO/hEQNlm5S
   wviLUIFe2vXHr1TafCjl+2NIgVuxMDrZLbezDvyfEbMr6pH/zpzenjX2R
   SpXDcMP4OGLnV4sHzezxitnSEUhi8QnFIYMrCW3F/LJCKP2HxdJ0Tli33
   6/qf9LxMjvztI9QbyJoCFK4paTCQuxyy+o22arSstJSz09k7vza7Vj1Jj
   f737+m+/PG+9M7dVjS8u1rFYFdItmpPnW1/up7kY90GeXTpNkZPwZCXM8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="388945480"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="388945480"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 11:48:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1088058993"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="1088058993"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 11:48:22 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 11:48:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 11:48:22 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 11:48:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2J4YtduSEJq1kETms5bFvu9RrtikrgG51b90KwT08kNlB6Cs5k1mMpT9S0m17sIS7aFJymsVw1llwHhfCKa5/pWGRTydhaiJd2hRfhk3wjo13iVz399RvRg2aNDDQg0m1yJFcnoNgplhF13at57gzfX9fUfnDGSG7awfVA6JpbwNNKqHqjiFqQr0r+vFEjalIfpu3qHlPW8PTOqdmy9WreC0+lbSlDABKMCQagcM8rYdoV6Dnf3OjCMjLWzuDAz2WC1l4ooRKWtJdrTS9MoPXvn9SYorZDNfEXkwcsQQS27jZO2R3jrnF5ifMDLFKnw877kNsxwabw/FidNMGo1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Twif0fTjvZN5P51oM1oMiYO3OIc3OBUeVXhTYJaBSo=;
 b=EJRPpeNY08KXgKLmTCfhrlhEgXWOMWWRCXJlm/vrxR3PMw8Xr0zNNwAeHHkyjlmcT5coYB5b7r1MWWkB6tZ8TP6I+Ekl9iO7dSKKa2ov6MVhvohcN8Jf5+S1VJwKGVtB1e83H3BKe93V8XJP2/rKnylde26G2HVBTEjOcyCOKqcx5hZuHSpctDTIz4HX08+upYHwD4C3L9NH3Mw4lOy/NZ8m6pztnzwUN8dYITEXqkPBJQQqXVUM1KTHvfjjM1tOwV2Y92IgNy+11iZUOiXClo+wy5l501/w1JeSKRv7zQgboy0/xtbptRGBADyqM76BTHdWuwuNEx/EteI6NFZAIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7788.namprd11.prod.outlook.com (2603:10b6:8:f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 18:48:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::7978:1ba5:6ed0:717d]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::7978:1ba5:6ed0:717d%4]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 18:48:20 +0000
Date:   Wed, 18 Oct 2023 11:48:17 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC:     Ira Weiny <ira.weiny@intel.com>, <linux-efi@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH 1/3] efi/cper, cxl: Decode CXL Component Events General
 Media Event Record
Message-ID: <65302871abbc6_725832944e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231012230301.58500-1-Smita.KoralahalliChannabasappa@amd.com>
 <20231012230301.58500-2-Smita.KoralahalliChannabasappa@amd.com>
 <65288e68de994_2347eb294c2@iweiny-mobl.notmuch>
 <d5882c60-6636-f651-2886-02c433f77ae1@amd.com>
 <CAMj1kXFsqRuge48Ji5bujgBz_rzbPcLiN84dbXnRytH3yyJPjA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMj1kXFsqRuge48Ji5bujgBz_rzbPcLiN84dbXnRytH3yyJPjA@mail.gmail.com>
X-ClientProxiedBy: MW4P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d1af02-3770-4cc1-4e59-08dbd00acc52
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JaRCU1V3h4KYBl08y0uKt06gnS81uffCCpSSdwm8bMHyQSkBzEZXWr+hHkIfqTcGn7MwZBLc0U+EKVD2BiFQOu3DUDfuHk1KKM56r9f+yYWXK7ov9s4m7RUbRcba52sMD038CY32OKwJe4DN2+C16+APWtLfvlMFQaRR9P0Qis0Q6lzAuBS18Gmz5zRIK3tzu6RibYUdXR9cbHucu93q+aJd43jQuGbUAyd1r/Go0MDWMZG7FAOC6dReHCzUZk4NIq8dg0LUBU6zEzF+jJ69aL2PiqPGXh2EwfTB2b0YjSfTFnSRaLxqvgvJlAo/Gd3in4cLnsrMVqclvfiGu82MaBQtR0b3KoxOypqMejsJ9g38kI8R+r0hwbPXESzrxom8icDsHtSEI19Y9+QBu9qL95UZxYOP4bCAljt+5ox+fkdww5PYSK0PkL+al4B9Zo4vaHWfe9DREXwC51m5lCLeKUT3EOpq6mW+vTqyUDTUFtpXcODQlPJkqKzuR5LCDfkrhSSiqFr8R6ZRkD320V+LHsSiLvPiXADsWRApHbSpjodcBOPUKbDS2tJZNuIEw2B8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(5660300002)(41300700001)(2906002)(316002)(86362001)(26005)(8936002)(8676002)(6666004)(66476007)(54906003)(66946007)(66556008)(110136005)(53546011)(4326008)(6506007)(83380400001)(38100700002)(478600001)(9686003)(6486002)(6512007)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SnY5gQpNvKIOw24rm3uOpp5iodPsc4B0JBIfqo/8pII9N9UeobzFVsUCG7TD?=
 =?us-ascii?Q?prQFTWaIXPPASL348OS1hSUMxREk8IqIZXIYQrp8UVJHRz7CLcxpQit+h3aI?=
 =?us-ascii?Q?KO8oE2OGixKi8x8JbsBdmbcXjIbXOX48It0oP3r75q57BHMZtia3l/V3F4Xb?=
 =?us-ascii?Q?uktpXiPsvGMnw5W3MTCZ2fNjIdXu04FGL3y113m45qWX6sJHEqNGR1v+Cc1J?=
 =?us-ascii?Q?PC6zzfZsuHI8Mt5z6/12f60git9NdhgxQR6tTIsjwB2IKcXIk4S2Hfs4mJvp?=
 =?us-ascii?Q?giXoftqsg5ryoJl4QRUyEefPeuRz9CxxK8YsWJ4KfVmHmZ+Ddd9czfO9qSsS?=
 =?us-ascii?Q?ny8avcEGFjU2dy2zJ0QCy75VKmdi3wWcpsUwlCQHS/l3w2IIaNcwwbuz5C54?=
 =?us-ascii?Q?NKz2FT2VFXfDLxMn3o7gzOqnMoivFe6pPrbxmEYB+MFqW8e9MIVdAjr8TV8h?=
 =?us-ascii?Q?yzRMdOJ/su6ModW6REdU8wVmO86U0cHBExbfSb9p2yO0f2DO2KdSn4sNtxjt?=
 =?us-ascii?Q?cCkIYdMK1T+igYN4FQ9MabEkOQTuwKEZ2lfbIANyxGNcvd1sr/fh/pjdE1/+?=
 =?us-ascii?Q?jvwc92VL6jl8ENIB+t2DgtsmOCrLf3FaIMALun+ih/2i7sR8emFlot5PqNJK?=
 =?us-ascii?Q?gCuSC3wyr/617v9o5JM3bl8aNc8ufMc686nCCy8g3r/3+gZlwF5VFO5tv0iA?=
 =?us-ascii?Q?552vB8viuEco0whPisL2mkuuK+qFmr53bvLnAoAH+9eZ+LnJKPFvc9El77wU?=
 =?us-ascii?Q?2+4eIwxtbdt2IndfOctYpaW947yp3KerTF1t773LznXLF/hSgoG7bG1dUSdO?=
 =?us-ascii?Q?HjcbQXsclBzia9SC/AlAgfID71QVbNAt1NtGZDhfv+h+aCjoiq/MSchjyEJ8?=
 =?us-ascii?Q?E1SXJPbhTfB1qELJk0W+0Sg1xlrV0RHJVLkRTi1Rfjeroz62okM969mMJWhp?=
 =?us-ascii?Q?aKkCxksk5tjs6fCdgmlaSvXsan1EN3ijFMKMwZSaMkAqu+S5OGgmBepbfAEB?=
 =?us-ascii?Q?njxcgKXEC4qBULW6sKhX/yh/i7fGDppPgc20yxsawzbIa5Ty0iovsS9Q8t74?=
 =?us-ascii?Q?ulQTQsUWINGOhwv6EvEF7UacDEUN75Qy77qIGcNHUce/FnQoH52338rwwYNf?=
 =?us-ascii?Q?XPD7A1wN63u5rXyiW6e7mhlO4gpJMdAltqs7ehCydlO03mC2sdeUz06y+w3D?=
 =?us-ascii?Q?fFDRrfsWfQ1vg84m+XK30z8X6Pg3v3MdHmyBqP0LTPFEsmQ5cRF6PzO50xKY?=
 =?us-ascii?Q?vwyJ49VORbfjzozLCVhV0LSd0JXNjBHgAhQz5yygbGRBPm+5Dm1JPEQOZipd?=
 =?us-ascii?Q?HIdmp+0X8e8fR43Z7KwIzlHa4O5q3QmcS3JrUhGhs1nizm5+uRU+pk1H1vlp?=
 =?us-ascii?Q?1vlCI1lq144mnt71YqDp6wNWQVBD1raQL99ovCW2vr4KAx9vaq/0dIu9in9V?=
 =?us-ascii?Q?JfX3ZbRX6JCsdQraXNBv9SkI0pgKII8dfbk3LkHZVzV0JVCLRWFv6sLy3qi0?=
 =?us-ascii?Q?qiUoV9SMWlo5QjnoT5rSKDCZtZPhLodh4brL8oAeMI0njzHJ7T8pse/mJFcr?=
 =?us-ascii?Q?FD9JIQGZrgwhrLiS9DNhyWF20E2gcs/NSKi6N+CL0tojmOLlQtqqmEW945dY?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d1af02-3770-4cc1-4e59-08dbd00acc52
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 18:48:20.1472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PD6y63pWGkwIWOfN39ntd0ruREWZFxBmUHwHqvpXpG+wA+iy4GTrkW8KbmmRn3LriV0GhE66yj7OzXsJyANawTurAWHv5WBaio4vKKtMOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7788
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ard Biesheuvel wrote:
> On Tue, 17 Oct 2023 at 22:52, Smita Koralahalli
> <Smita.KoralahalliChannabasappa@amd.com> wrote:
> >
> > Hi Ira,
> >
> > On 10/12/2023 5:25 PM, Ira Weiny wrote:
> > > Smita Koralahalli wrote:
> > >> Add support for decoding CXL Component Events General Media Event Record
> > >> as defined in CXL rev 3.0 section 8.2.9.2.1.1.
> > >>
> > >> All the event records as defined in Event Record Identifier field of the
> > >> Common Event Record Format in CXL rev 3.0 section 8.2.9.2.1 follow the
> > >> CPER format for representing the hardware errors if reported by a
> > >> platform.
> > >>
> > >> According to the CPER format, each event record including the General
> > >> Media is logged as a CXL Component Event as defined in UEFI 2.10
> > >> Section N.2.14 and is identified by a UUID as defined by Event Record
> > >> Identifier field in Common Event Record Format of CXL rev 3.0 section
> > >> 8.2.9.2.1. CXL Component Event Log field in Component Events Section
> > >> corresponds to the component/event specified by the section type UUID.
> > >>
> > >> Add support for decoding CXL Component Events as defined in UEFI 2.10
> > >> Section N.2.14 and decoding Common Event Record as defined in CXL rev 3.0
> > >> section 8.2.9.2.1.
> > >>
> > >> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> > >
> > > [snip]
> > >
> > >> +
> > >> +/*
> > >> + * Compute Express Link Common Event Record
> > >> + * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
> > >> + */
> > >> +struct common_event_record {
> > >> +    u8 identifier[16];
> > >
> > > I interpreted the CPER structure as not having this identifier here.
> > >
> > >  From Section N.2.14:
> > >
> > > "For the CXL Component Event Log: Refer to the Common Event Record field
> > > (Offset 16) of the Events Record Format for each CXL component."
> > >
> > > This implies that the data coming from the CPER record starts at length.
> >
> > Thanks for pointing this out. According to Spec, you are right. Our
> > records did show up the identifier. Hence, I added that field. We should
> > probably fix it from our end.
> >
> > Meanwhile, I'm taking a look at your patches.
> >
> 
> Thanks
> 
> Once you've compared notes, can you please let me know how to proceed?
> I will not consider Ira's patches or yours for merging before that.

Ard, I have a higher-level question. If these CPER records get routed to
the CXL subsystem to be emitted by code that is shared with the
native-driver record-retrieval mechanism, is there still motivation to
parse and emit them to the kernel log in the EFI code?

The difference with these CXL memory error records vs other records like
CPER_SEC_PLATFORM_MEM is that the record contains device-local addresses
that need translation to be of use to other system-software and that
translation needs topology information that the CXL subsystem has
enumerated.

So, my proposal is that the final form of this enabling would emit the
record for CXL to consume, but otherwise not emit it via printk().
