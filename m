Return-Path: <linux-efi+bounces-377-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180948290D7
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jan 2024 00:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9981C24FC2
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jan 2024 23:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0AE3E47F;
	Tue,  9 Jan 2024 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jo6W5Z73"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AE63E47B;
	Tue,  9 Jan 2024 23:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704843014; x=1736379014;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=j8/OzEp8DQqrYhogl/TzVjoKgAipuRRWQf93S5tDwpc=;
  b=Jo6W5Z739LfWXZ8VzHfQCe6/45Rhs9dNz8/yTpUWrWhdJtGpM3Bo6SZf
   yFwfjNZttdUrnHPpwgWuKkc8YYDwBwm30YQwvpT87AJW/abrkDr/Px9YR
   u5xcHvNRHBQKfQASeSKXdvzBLG+7ia3GHCEoEs82JrpIjJ94g/tmOR8aM
   Q9G3E6dV5HWgz1kqwU+mlMhmoG7OwBUh7UtfB1TQPWW9e4oEij8JPwnTU
   Qd48ZQdCKt1m7bkcyhh+LNzmyLwzfUX84OBoT/4jFLpO8Wp33AKHqk4WQ
   sM/4LR4hOHOulNmg1i1I5tvAy26mnV3erEV1JM9OazNHZGHwCsmpGT7de
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5439578"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5439578"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 15:30:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="775027967"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="775027967"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 15:30:13 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 15:30:12 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 15:30:12 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 15:30:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwnRWFT0E9hGABdEaAGtPaDAYB2pAmLB6N06LRt6KkLLbE+98/PBMaJvYF15Ncg7NWttrRUewfJa6enC/CmtGqkpv2vZnMwWEuRpJkpPLEpLwx6iphAK8Lb4KuVqvTVPqa1jFqcIreVdRf1yhdZje5KSPVoPFotgV3Blqs6eAodFnbYZZhcnCpCpoi4Lq+Ng0I7O0lOeQAyaoqDJasm9Y0AjEHyV8LhNoC3hPKrOfe5a2iN8vht1DvuYA5amm1IteIb+sVgFZB9lnpW23waEiQnV3CiTWGdcREpfTqbQ2EoYKCMza6sCqNGh1cN1mttHqMm4JSVWhIAyd/eVicCQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0LzNRVGHOgEFjvFHSxROdw+O6tJwnkRSrXE5StFEnk=;
 b=fXac9Qjq51tOq6+z0jadrqrsLKg65PRAs9QhghbEWsD8VoMIHv1WWFPIXOxDseUkSquizN6bTYzImVBHwOuIhbYlucxVPChOmeApuvGNj3S+UcckwVb5hGIMcJ2EPWh2y57AmHedYAVWAkg1+3+WQHz2aqZK098ECdnfZtT5Bs+626lbKYw9ffF7SHJ8tuElrSllKW4Q+kbrA2QJtZUi4HFv4ONI4DCQHllOQNApo6tjQpnKnSe900Nd8IZ4gqD59IMSD+WJSQr0qpusOqlFpTdnQbkqNRjvP4zyAzodLAGmQbsHM+10l7ahCyOaLj+m48yQ5bhmtnwtIriLrtI0zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4692.namprd11.prod.outlook.com (2603:10b6:5:2aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Tue, 9 Jan
 2024 23:30:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Tue, 9 Jan 2024
 23:30:10 +0000
Date: Tue, 9 Jan 2024 15:30:07 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: Ira Weiny <ira.weiny@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 0/9] efi/cxl-cper: Report CPER CXL component events
 through trace events
Message-ID: <659dd6ff5ee1_24a8294d0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
 <20240108165855.00002f5a@Huawei.com>
 <eefc5888-4610-8e39-61ed-2d84e9ebf255@amd.com>
 <659caa8da651c_127da22947b@dwillia2-xfh.jf.intel.com.notmuch>
 <659cb0295ac1_8d749294b@iweiny-mobl.notmuch>
 <659cb684deb2d_127da22945a@dwillia2-xfh.jf.intel.com.notmuch>
 <20240109160435.00004a4a@Huawei.com>
 <659db15452090_24a8294f4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <659db15452090_24a8294f4@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW2PR2101CA0025.namprd21.prod.outlook.com
 (2603:10b6:302:1::38) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4692:EE_
X-MS-Office365-Filtering-Correlation-Id: 783ba6a3-8822-4cd6-0da6-08dc116aebf8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j16f9U0eB7ovc5ci6XD6JWcKMxZ00Ko9HQ+OG5IfuqM0r/lo8TjnjtWsvqe82jYAFrEHgEPa5Zu+/ciyZgly+Oikee/ooIkPExpfBCTDJXJ/Q/FxwlToMG83PBCsxYn70Up4gw7JhR0NToI6Efsl6v2Tcp3nr2/NXW4NB2R9wR/i1i/eG9kDy2FP29LRBxOMcSx1pH41wdvwiqHBeKIkSCksNwJh4Hz4lVQ0YtihjDDnQRthtIJpwvCVT+BUrJx3875CUUBHfchwB6q2L39GhNzSWOJ/iqqekFgACj2DRL/EOcZ/X/SUX0aOO21+BEkw/zU0WhuWuxAPRJARuxEIhiQpB3jfZo+lz73aw2dl4SZIdWK3AAAXXw/f1IOqjCKJNlqO/ogHLU+XjowBRoHhT+rTB2gkO1gYns7rluAfxEJGm0TKHWSEjjzAc+3TLLfCyaU8rnUgYqEpyUaGDqQSIPyrvCPwyFtcTXYetooPWYkqDTHaf3HG4stCI93xhUP223G57JYB1I22mP1QU6yXhBeTHnl46mOkKTk11LS12bWWX1wQfb9izZ+3l0LKLWBzsvuHHO80o7xBRQGYxZnj0tGHGz/7dSnPm23FVcgB1wiAKRDl4vmRjzVhG/8w5UZS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(6512007)(9686003)(26005)(53546011)(6666004)(6506007)(4326008)(5660300002)(7416002)(41300700001)(2906002)(478600001)(6486002)(66476007)(66946007)(54906003)(110136005)(8936002)(8676002)(316002)(66556008)(86362001)(82960400001)(38100700002)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vAphurHumljhni2anBow98iLvhnQEThGEMQAhhVbxcRLLuUBb+Xxvi9/IkkC?=
 =?us-ascii?Q?BQOw9/4Q/ybl53N3tWokcF/KMAOTH/NqJAsuc9a4jbS5UJ4D6+ncqvjmZw1+?=
 =?us-ascii?Q?z7Xw/qWWgH88qO7nngP7biCPbLW/wXI3rbxfTt4Vkcula8BgGTE4VVQFsPPu?=
 =?us-ascii?Q?HLaZynWAhOk6leiGZUd3s4XDZtPj53EdWvPUZZ3ZQyLkUF4MDLeSaQsDkkw0?=
 =?us-ascii?Q?D4DToZDZnw+G1BdwGeyPmRmeG/f6YoGNYbrzRFR2rIStNOwwJhvZYFYThi1r?=
 =?us-ascii?Q?4OEuIE1H9bO3inG6GhNIYCgImX/9axf9gGrJjL2nRMqmXtsdEejuVKXYRZLJ?=
 =?us-ascii?Q?ReHDBhNp7UaRhX8YH2V1Z3qH3KHgMO9YguhZXVux9swczgjCST8NsQlChqVJ?=
 =?us-ascii?Q?3nAUKKVNf3rinySi2TT+TNA5hLtd/yHYtN84YE/ugiawl6YL1wuNkX2QeMFB?=
 =?us-ascii?Q?80pAGJmecXzUSiwr2BP+BurpGy1INktcgylXQLuJNyNiVz746ZE3qnNekgwF?=
 =?us-ascii?Q?Vi7u73p6BNPX1wR1pRBvRtWZDHUhj7fzLfPuSU/bgETnU/hD9uBNKO+mYnxj?=
 =?us-ascii?Q?lVSw1te3Nh+ubAZJwfXRdyA/ecglE4d7IIApbh8oA7jJg6QKNyPoAK7cMkcf?=
 =?us-ascii?Q?K51nsc2D1cO0cmOa0+aPenFL3Gwt6/FqpaeHF/4VEVWly2BIqjJGu3MUfJex?=
 =?us-ascii?Q?26AFtruNYVUm6Fn/UVYoYh9dfzZW//Snl8ade3gQi+o+djq4gspL2uPCdHjp?=
 =?us-ascii?Q?6a70ZhXoY7KIK7eG4dWJNVJGVseIA1DP4oipbLhUQ4qG3i6LGq4HQ+RWsfW5?=
 =?us-ascii?Q?Yzkjp1PDnk81VU6SD+lx7myvEGCALU8bHxBqMzq00FCmqY2ugPl3f+KWKKWi?=
 =?us-ascii?Q?ThMvVItMG8+3pSCq5otXTucTQRG6pFdU/tOc3TJ3iosJ22xdi0YrgNZn+/ce?=
 =?us-ascii?Q?PwVS0ri4X1JaL8Q2+7YKwEt+7uuTot2BAQLVEvIU2JLqF+iAkkQgLapJX0Sw?=
 =?us-ascii?Q?bRhoVmagTK2c4aNJubdx32vFRt7wyFtGUSVLYUkmK+ZgnY9M5pT0A3FUbRxT?=
 =?us-ascii?Q?XvwuKH5WBRrfMzJ7pWow+9FC1KNmYljSQJe6RAP5c6/oMOvBjFb8p/M7Oakt?=
 =?us-ascii?Q?sQqrlfbsZGH+gfuSMHbsgjsnISDC8/1+nDe3quSWNEkNdNACcfGW4Ka45r63?=
 =?us-ascii?Q?kJStwEo7fIRye9amsX0zi+8IZ5aBHQxWArzdSN2YtdgtIwzr9fOuNricBetl?=
 =?us-ascii?Q?IAHi1WqGJ/QPQZjieqvXUE+6w63NI35ssb+zjIlBtaaeZ172OP7bs8DgbES4?=
 =?us-ascii?Q?+12Il3aqo2FbwduFcIL03wYxaks8DBHiw/lg7prWNpDypUaPN3oJFXbGi+t3?=
 =?us-ascii?Q?Bt4GKDOFsIDMVUD4MjuASSU+OL0beiTB6Z5ZUst+QzogDVlgYMNo+Rq3I937?=
 =?us-ascii?Q?s8XmRRy+9qK9jowAfQ8rT51iahFgwOiufAESkdk1MLpNW2YeykSVLSMdu1Iw?=
 =?us-ascii?Q?ZbNI5ZWcHS6Dqpc1ocncXACUT+PRU3EevJT0RI5mk3RE0Eu256Ntll32KuLx?=
 =?us-ascii?Q?DaC92B1HbprvgEm0uxjOlmKEs8nHENr/YaLRArw9Q78660DWB8/kS8qJb/Js?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 783ba6a3-8822-4cd6-0da6-08dc116aebf8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 23:30:10.4155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3MVIveuyPRY6IwxG7PMAY6ujeUQAigWFbBPWMSILm1Hh/rDaZAitwK2By0skP/92hsVHC6maxCwRY4HzLosrBRpwq+kA1kfrBzOWHquow8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4692
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Jonathan Cameron wrote:
> > On Mon, 8 Jan 2024 18:59:16 -0800
> > Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> > > Ira Weiny wrote:
> > > > Dan Williams wrote:  
> > > > > Smita Koralahalli wrote:  
> > > > > > On 1/8/2024 8:58 AM, Jonathan Cameron wrote:  
> > > > > > > On Wed, 20 Dec 2023 16:17:27 -0800
> > > > > > > Ira Weiny <ira.weiny@intel.com> wrote:
> > > > > > >   
> > > > > > >> Series status/background
> > > > > > >> ========================
> > > > > > >>
> > > > > > >> Smita has been a great help with this series.  Thank you again!
> > > > > > >>
> > > > > > >> Smita's testing found that the GHES code ended up printing the events
> > > > > > >> twice.  This version avoids the duplicate print by calling the callback
> > > > > > >> from the GHES code instead of the EFI code as suggested by Dan.  
> > > > > > > 
> > > > > > > I'm not sure this is working as intended.
> > > > > > > 
> > > > > > > There is nothing gating the call in ghes_proc() of ghes_print_estatus()
> > > > > > > and now the EFI code handling that pretty printed things is missing we get
> > > > > > > the horrible kernel logging for an unknown block instead.
> > > > > > > 
> > > > > > > So I think we need some minimal code in cper.c to match the guids then not
> > > > > > > log them (on basis we are arguing there is no need for new cper records).
> > > > > > > Otherwise we are in for some messy kernel logs
> > > > > > > 
> > > > > > > Something like:
> > > > > > > 
> > > > > > > {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> > > > > > > {1}[Hardware Error]: event severity: recoverable
> > > > > > > {1}[Hardware Error]:  Error 0, type: recoverable
> > > > > > > {1}[Hardware Error]:   section type: unknown, fbcd0a77-c260-417f-85a9-088b1621eba6
> > > > > > > {1}[Hardware Error]:   section length: 0x90
> > > > > > > {1}[Hardware Error]:   00000000: 00000090 00000007 00000000 0d938086  ................
> > > > > > > {1}[Hardware Error]:   00000010: 00100000 00000000 00040000 00000000  ................
> > > > > > > {1}[Hardware Error]:   00000020: 00000000 00000000 00000000 00000000  ................
> > > > > > > {1}[Hardware Error]:   00000030: 00000000 00000000 00000000 00000000  ................
> > > > > > > {1}[Hardware Error]:   00000040: 00000000 00000000 00000000 00000000  ................
> > > > > > > {1}[Hardware Error]:   00000050: 00000000 00000000 00000000 00000000  ................
> > > > > > > {1}[Hardware Error]:   00000060: 00000000 00000000 00000000 00000000  ................
> > > > > > > {1}[Hardware Error]:   00000070: 00000000 00000000 00000000 00000000  ................
> > > > > > > {1}[Hardware Error]:   00000080: 00000000 00000000 00000000 00000000  ................
> > > > > > > cxl_general_media: memdev=mem1 host=0000:10:00.0 serial=4 log=Informational : time=0 uuid=fbcd0a77-c260-417f-85a9-088b1621eba6 len=0 flags='' handle=0 related_handle=0 maint_op_class=0 : dpa=0 dpa_flags='' descriptor='' type='ECC Error' transaction_type='Unknown' channel=0 rank=0 device=0 comp_id=00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 validity_flags=''
> > > > > > > 
> > > > > > > (I'm filling the record with 0s currently)  
> > > > > > 
> > > > > > Yeah, when I tested this, I thought its okay for the hexdump to be there 
> > > > > > in dmesg from EFI as the handling is done in trace events from GHES.
> > > > > > 
> > > > > > If, we need to handle from EFI, then it would be a good reason to move 
> > > > > > the GUIDs out from GHES and place it in a common location for EFI/cper 
> > > > > > to share similar to protocol errors.  
> > > > > 
> > > > > Ah, yes, my expectation was more aligned with Jonathan's observation to
> > > > > do the processing in GHES code *and* skip the processing in the CPER
> > > > > code, something like:
> > > > >   
> > > > 
> > > > Agreed this was intended I did not realize the above.
> > > >   
> > > > > 
> > > > > diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> > > > > index 35c37f667781..0a4eed470750 100644
> > > > > --- a/drivers/firmware/efi/cper.c
> > > > > +++ b/drivers/firmware/efi/cper.c
> > > > > @@ -24,6 +24,7 @@
> > > > >  #include <linux/bcd.h>
> > > > >  #include <acpi/ghes.h>
> > > > >  #include <ras/ras_event.h>
> > > > > +#include <linux/cxl-event.h>
> > > > >  #include "cper_cxl.h"
> > > > >  
> > > > >  /*
> > > > > @@ -607,6 +608,15 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
> > > > >  			cper_print_prot_err(newpfx, prot_err);
> > > > >  		else
> > > > >  			goto err_section_too_small;
> > > > > +	} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
> > > > > +		printk("%ssection_type: CXL General Media Error\n", newpfx);  
> > > > 
> > > > Do we want the printk's here?  I did not realize that a generic event
> > > > would be printed.  So intention was nothing would be done on this path.  
> > > 
> > > I think we do otherwise the kernel will say
> > > 
> > >     {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> > >     {1}[Hardware Error]: event severity: recoverable
> > >     {1}[Hardware Error]:  Error 0, type: recoverable
> > >     ...
> > > 
> > > ...leaving the user hanging vs:
> > >  
> > >     {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> > >     {1}[Hardware Error]: event severity: recoverable
> > >     {1}[Hardware Error]:  Error 0, type: recoverable
> > >     {1}[Hardware Error]:   section type: General Media Error
> > > 
> > > ...as an indicator to go follow up with rasdaemon or whatever else is
> > > doing the detailed monitoring of CXL events.
> > 
> > Agreed. Maybe push it out to a static const table though.
> > As the argument was that we shouldn't be spitting out big logs in this
> > modern world, let's make it easy for people to add more entries.
> > 
> > struct skip_me {
> > 	guid_t guid;
> > 	const char *name;
> > };
> > static const struct skip_me skip_me = {
> > 	{ &CPER_SEC_CXL_GEN_MEDIA, "CXL General Media Error" },
> > etc.
> > };
> > 
> > for (i = 0; i < ARRAY_SIZE(skip_me); i++) {
> > 	if (guid_equal(sec_type, skip_me[i].guid)) {
> > 		printk("%asection_type: %s\n", newpfx, skip_me[i].name);
> > 		break;	
> > }
> > 
> > or something like that in the final else.
> 
> I like it.
> 
> Any concerns with that being an -rc fixup, and move ahead with the base
> enabling for v6.8? I don't see that follow-on as a reason to push the
> whole thing to v6.9.

I will put it in -next for soak time and make an inclusion decision in a
few days after I hear back.


