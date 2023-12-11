Return-Path: <linux-efi+bounces-175-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB2D80DAB3
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 20:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33C2281F7F
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 19:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08AC52F64;
	Mon, 11 Dec 2023 19:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MtQsnBrB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE89C2;
	Mon, 11 Dec 2023 11:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702322187; x=1733858187;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vp3n54VIH/8lz5K1hOpqIdXWwGS8uIgnbwnujeOP4/0=;
  b=MtQsnBrBPAMnvpFpMY3hr1doUZjT0RlskFVPu/3mZy7BwDwO+dG+zLXK
   qn0iQHjiLoqpyms81Oo7ns7UshC96NjrOoEqzsAWrkEGXG5TKNmH9DuMH
   g0MisKCncLvD/Vb2lE4OLq4fd1VRkmcqNxpMBcVLkTMxQQGEKORO5LVeo
   TUoHKSzVENEIhnjhCAZoXOKljHM2IcbU+KQtZWuXl3PaXztbgf7kdLijo
   AueT/aQJ2RsrjD6Yp4UQ6LVaK7XUPVxs4X78R1RViBMnVstoTAP2mtt3J
   JzblQtsx05BBJSW5bBwuAOeVecZfeBLXVsdIFsJGrYqlRvdil0eXOfqJ/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1817725"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1817725"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 11:16:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="766495034"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="766495034"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 11:16:25 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 11:16:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 11:16:25 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 11:16:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2l5QATGjwv9i3GbUw19Y7R64Q/wpvH2pqYZSZsuXKIQZOtXkvcqefIm+SdxO/1F2DJBcB6Cz7ZYxdsNpvcSGJalkwnighU9oseSlQcdeEQ7lX14hveXYb4Jjd3rmJ2wbXjOmYgl9jnXBd3NrTnO2jCpYZkBwJav0GrbFN0cnoEKPsXpIb8mId34Q/E2xkInidszNO0xWm4k+69lXQjbxxQWTufPfYXurBfVf5hXpivS5LdqUmRGE5xhI6EAUMWz2fvBQkf8pHoZJn34jr77ib+M6ZSfMEQAGvKAHt8QNOLTr4on6gmcUCDRDSouGCKIh0TqXYgbc/zXoRx8rG4dDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwwggZw/0Hgkq3+HTOtuswsR7SZ5QA1+amu7gRwQ1lI=;
 b=YafB8+NUjylbArl9MXvzF+pIi+mPmYVXOKv26nsPoYNMrAzjZOZTXl0TqE2gv2RBnRW7a1ereUqenXYvdY4hmP1nGKOf9ge/eQgdz27kFsfYJQCul9W/hRlr1Rq8bjMP0YIdLSHLKy38JRMdgSGAQpUtPFvuGeiYZEuEK2jOeKCr4ajjV/TE9phRQTUjIPViLWrUI9DXz04XD+Fg1hw0pEufeNi9UaFoIcuccGr7Q5x/rMpImwfDvjiC0V1TzhweK16oxbbgt+tfYO2tjhOGktaLn1Xzg6DNRuddbcwDRjDT6x2AaKXLj48qhJOLwXMacdLMzQ0EITiVq9rMTceD2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7914.namprd11.prod.outlook.com (2603:10b6:610:12c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 19:16:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 19:16:19 +0000
Date: Mon, 11 Dec 2023 11:16:10 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH 6/6] cxl/memdev: Register for and process CPER events
Message-ID: <65775ffa7e529_a04c52941d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230601-cxl-cper-v1-0-d19f1ac18ab6@intel.com>
 <20230601-cxl-cper-v1-6-d19f1ac18ab6@intel.com>
 <657279a68c270_b991294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <657371eec6ac5_1e7d272948d@iweiny-mobl.notmuch>
 <65738e9fc239a_45e0129476@dwillia2-xfh.jf.intel.com.notmuch>
 <65775c98e0b39_1f2db42944f@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65775c98e0b39_1f2db42944f@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR04CA0149.namprd04.prod.outlook.com
 (2603:10b6:303:84::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: a7323144-0ee6-4fba-67d2-08dbfa7da785
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pOYEj+WypYczIPT+Ow7Kq2Q7DrE7GTUwmVOzcHftDULE8SmC3smBf5KhCLrHzTCI8XRlF3TSn+bsIol8idRFKIN+IJhWPqYH37R28R0O11XV2l950HiYgTzkdNvtY43Dzuv7JdPf5a8gXJ5SzUhdAMppKgQb05WKYpo1OXX/mrOrslM2v2HSOwUQo3Xci3JebpWi7LI7Bv8s0nmCtE/oJFhtpskdWEUj6hDF7nscJbHCuTSZ0eEe+HuPBi/RtcJ3UCQiVhncktSur4xLylQJowlW/oRfDwga8/zGpIlWJtlivoHYruFJX8rybMGq9xKmH0SAV7KC2A0beEpivhWAvYVJLVB1idiRuZiE4j8Efo8NLMjNuPvbzQ80z3fENWhY7k/dBXSZeqz9gRvpQS4zMh36TTucqNRjlWU8W2eKVQdSxZaoKW86JafsWQwIt6mnze46+Zc9ZHyHe3vE5Hif3m7gTqwm0J/GUWgcsXsT2VM2AdTAhf2L5ep4JF230YaomTF+Zc61uFJvQuypLeLUYtgzYlqAnYnLhygZuRSr3E/2Ee6YM3TtOavymhycriKR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(107886003)(478600001)(26005)(6666004)(6506007)(6512007)(6486002)(9686003)(82960400001)(38100700002)(86362001)(41300700001)(66946007)(54906003)(5660300002)(66476007)(2906002)(4744005)(316002)(110136005)(4326008)(8936002)(66556008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?brhrYrZ7jsIHzQD3OvQ2o3ZzV/D9eTBtmfinml70G9rt9+OxBOiFXyhDQ1bE?=
 =?us-ascii?Q?uzAiXF0Srv6+km9j9A92PzsNdUA/o8SN3mxmxLMQ5bh7hViT/NhSyAv3J0Ud?=
 =?us-ascii?Q?8rNTHWvauaV/PCqPxqf/Wf87oltyQm0eYTU3r3iV6QXO4WwUSFtftxg2UxoI?=
 =?us-ascii?Q?+dVmCFY/bnlVYgVAXAazOmQWf86yqVvE2POyz6NO8FeTl2o6j2fgZrs25IpG?=
 =?us-ascii?Q?DdwwzptLvGhFywzTPgmWo2mcn7iWS/zm9jKweCDmdjBNcNEqkOaRgDYC92ay?=
 =?us-ascii?Q?q9F0m1mQattjliTQkK6mNfU6VwOU6FzcT7nOCnMdfj3TC2FZr6UPokvW3PqH?=
 =?us-ascii?Q?EUBI1aW33orK9NUj/9U29zM5KT+Qlapdl6qwhybRYQd/lJce7NVLUFdoNs4y?=
 =?us-ascii?Q?2/PmESD32WQPH+QAbF9kMsswAdIDFBu4kFvV8birmOTS8N95Nf6Fu03NumbI?=
 =?us-ascii?Q?Mf0vzOMIeVZs9gkp2e4j0ncGT//VCAAuLDTcpCwsvYzr4SJT564YHnMtmR06?=
 =?us-ascii?Q?7WW5VwRHDaOFn3mRL3Oot7i0ZbpS8OOe/iqBa/IVWh9ozNpkkw93b6xkhrgO?=
 =?us-ascii?Q?GG8RggqmznQEF1KoAnuuawUuQ0XdzBO892D/G/6by1ZOuVfjZVB+6YB3tnWg?=
 =?us-ascii?Q?L5GBrsqwVm1Sqo0JF8LbfvVVsh1/u0fY1rf+cTCv3B/Xec2Jva5n71vXJWt1?=
 =?us-ascii?Q?VpIoQ3t0YAoQhM3PRMAPbzL28VOhwvnE5xS+4mhIIrypyy6sdBUWaPi8EUsR?=
 =?us-ascii?Q?OgH4jhwruA0m6bg/3DgbnFxATV5V3Av7R0cMdUhutCONv6Bf90ij5erexGGb?=
 =?us-ascii?Q?+iOhNCGbKtQePiQLmyfymugAqPEHOFIX8kAIBKP1j2f/E1gEZEOg5TbIIA1x?=
 =?us-ascii?Q?6ka9lstlDT9z4fmoitL1bntevlYHV2mziKDQkHeOyVe0rDqmVzSgpkZjZG3U?=
 =?us-ascii?Q?SOP1/gdwD9zQXvg+361+6l1vJcdinK4Z9POCY9zQn9oFJz3C2JxO0VyhL3kT?=
 =?us-ascii?Q?dUE4uDzQJPSVYBAPioQo+GgU3N7f5qjyEFJWWgvyv04PCwROocT5Pdm/IiZk?=
 =?us-ascii?Q?/B2a/Pgn4SfgkjeMjmV7584tq9Qk4L5fh0URhBFCwjRjYcVcqWXnmwgBd1ft?=
 =?us-ascii?Q?kXYZ5yIi4S6aAA0yOncEo++ftJ7nSFPqGPY1XffmDxjTrZBGl1JoqMTV7Atv?=
 =?us-ascii?Q?S9swmw/AkCJZXb9mbSZBeBQ6vBwBHUOrd5E8CiyKMM4Ra5TwKXMhy2FbgWzA?=
 =?us-ascii?Q?6g1Ad0BbD1oVGTDCeCRfGZVJSfOhrmSe8cxV9iMCnDgkgiTAoJYTPeupBJH3?=
 =?us-ascii?Q?p6aFDIxPMCNI4Xk1RVraKL8aPCnYnoVuZ76J0hhMX9HfpY/lI2efOXqTlQTh?=
 =?us-ascii?Q?cGUrvTGm44T9YiXLH6k6dJtz662/gtSiUO2pvOd4xWsP4lYja0ejcVuMq1Tp?=
 =?us-ascii?Q?pStRa00meMmSdyiADY3azFLooKXLwsElsIGCqXh57FPqI9WWNl3yHNJnO5NL?=
 =?us-ascii?Q?7b/XO89c0FPPcdzyd10zlSRP23MBJ4P6cM5bniJanalV9JSmKP1rHOAaqUXH?=
 =?us-ascii?Q?Fy1JnOIfXfFg7T6FP6VH+LGEz8D84mUswQOfMC1IpOZ6MWX8NoE2eDXQpWJ1?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7323144-0ee6-4fba-67d2-08dbfa7da785
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 19:16:19.3929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JE2P7gShV+qXW4yObM+JDMKTVmpEpm3mxWOoVsNay2GO8w6jmrZVudgcJJRO+k3Ek9mFE6FCxyLUgxySo0XtnO1zF7XTFvF5sETn1xWIPng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7914
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Dan Williams wrote:
> > Ira Weiny wrote:
> > > Dan Williams wrote:
> > > > Ira Weiny wrote:
> > > 
> > 
> 
> [snip]
> 
> > 
> > > #define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
> > > static void cxl_cper_event_call(struct cxl_cper_notifier_data *nd)
> > 
> > Is struct cxl_cper_notifier_data needed anymore, just pass the record
> > reference?
> 
> I think so because the type of record is ID'ed by the GUID which is not
> part of the common record.  So the notifier data adds the cxl_event_type
> enum.

Ah, yup, but then I wonder if CPER can just do the GUID to type enum
lookup and keep the CXL side GUID-free? I.e. just pass the type as a
separate argument.

