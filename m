Return-Path: <linux-efi+bounces-372-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC885828EA2
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jan 2024 21:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A2E3B2441B
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jan 2024 20:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308AA3D986;
	Tue,  9 Jan 2024 20:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+U+sYG4"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF6B20E7;
	Tue,  9 Jan 2024 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704833381; x=1736369381;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qtw3Z0TUKYafzadEngViQzX7/Qgpr3136C4ygM6g+iY=;
  b=M+U+sYG4Bx3F+QK529Syy79c9F33NAaZYmvnMRXl330aYy32bBO2JFcz
   5Z+E555Q0uif9QxPgJP/Cs/u+T01Cg/noKb6+sEVzSCLo2e8Li8XcsEMH
   K+ubAwL+n0X47YfAgzRURMoMGaBRtwFMCLTjKe9ch5X5HpafP7tYEWpMG
   iEk6I0iMJ9o/nGP5wXdBl37H4vTOpSi1lV69Z1yYI+6OQxmnmz/HQE5gf
   X7fz4yLrl32JxhiqmtIAvtgWoSlatTz4DNYSiuvFXSZcUZeZokGm8ow5O
   rJz9aul710edXDqQGk2RWwi0a7DylRdoQPziarN+Gi3MmIL9bcwP7abB7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5680802"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="5680802"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 12:49:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="24019027"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 12:49:33 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 12:49:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 12:49:32 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 12:49:32 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 12:49:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWcEoTYWQrGiDlvvpjbvo9kG0WNJP2CQnkWZKrukIi/Gps+HgOawNdvJrRl+IJCcrFIrcEhKg6hUv3gnnfob1F5dbEy2GYLtMhuglI0WknMm4pY0lOY1vm2h/TM5sJ4p2BWhLMl0Xt1H6k+/nZyAzy7KCYNuX35RqHmJCdw0hSDmbhdGil1MfE8gyUEu447UT0sohaRcTNvm1idKdeg86oeqAgKV+ONihnWoiVBXc7K6kvOu7Xpqsl4VA9aZgjjBxkKToml++3NmzpO5il3cd8XmtAj0J81N5dS2R45TIyjMYn7cydQDPiO6uw9uc3Pr4uTOBljquWG2AyfGx9rEbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFcdr9SeWyYqhGoweaW5w5WmSWFQNEcspgaQmVxEgr0=;
 b=Kk4ModgXUW7Ttrf7pimeybib34YRmpwkAq6ggqqDJiExTsKpWjKbC7q7O+SxCXiFCHg1uLm5VbmuELsf2OZQvfrf8hz8M9iU3/+oEvg5V/3xp2Ue6J7VQgNlVmZ+0ir1PW6cTjHoApBQH7XuhpuuB2r44K8TP7Ti1sGksSELxhWGSXNm/BXm8KO0ErrDe/6wCinGhsXJI5VUXBOsLTV6Ieg42rXdSWXM6tNUB1kno+LZrTWsAc2k2v9vzoTVUij2emfF8uuLzHD4XuTzyEOMIuLuTxKWJa+yFLw1F7WDPUqcywkOrA29UUmc88RXnYFSG+hOcUPoRzd0pqskhvaOgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6978.namprd11.prod.outlook.com (2603:10b6:510:206::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 20:49:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Tue, 9 Jan 2024
 20:49:27 +0000
Date: Tue, 9 Jan 2024 12:49:24 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
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
Message-ID: <659db15452090_24a8294f4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
 <20240108165855.00002f5a@Huawei.com>
 <eefc5888-4610-8e39-61ed-2d84e9ebf255@amd.com>
 <659caa8da651c_127da22947b@dwillia2-xfh.jf.intel.com.notmuch>
 <659cb0295ac1_8d749294b@iweiny-mobl.notmuch>
 <659cb684deb2d_127da22945a@dwillia2-xfh.jf.intel.com.notmuch>
 <20240109160435.00004a4a@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240109160435.00004a4a@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0288.namprd04.prod.outlook.com
 (2603:10b6:303:89::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 46875dc2-763e-453c-d15a-08dc1154784f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/Kv4s3weWS8/UMFZqfr3NkyOE8pWg7+aQDyic6EImcF6sVhiH6c1fUZ/ivGHnxDcg8IyWlNICUJnzgnKA79ayCJirZcORyL9G1I34ud66znSah3quLV0HdjBBnWvcBQ0rHe2Q//EvZ18SbD0bC1LV911czF22xFBw5FBXJa8Y0u8CGqUmkarauYRfdvHUqgdQkgii/qfKdOUrBDqbbkGCmXMDwrjxRniozS4XK0/t5+darHLaPGXT3L6A+N6upadf6HOfJ38gaJFrm9/R04rfLAMaCig+KDbEub3bCMFJif+VADSP813+fO1T+ooXf8wRjMnbYoXkmaMEA0h2LXLCrP939LjFbN/loYAhvuah/p2gOnRzUfJxDtI7AD6L1Yse2GSdj6A12BogMoaco2U0TwwLnSO9XFGnQdsQz5gjj2dSKXcHl7cFJAKrfQ8Hs8sSgkdOhIlGGuzRHZ/aRiPvvZrGitWsX0G3ZepfH8AGChSaX92Ico3sH8X8/rGfKGQj7zqnebU/UmkrCCWJbSs9QbAqfCg3d9NCg0Hw9g7MjJUGNbzqrb/B8r8pJJuArxd7VvZPEGB/d+r9kboez0L8n8UmgzMQwQtmLGN5CYKlUWfKpErYnC7g93IIJMKc00
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(26005)(53546011)(6666004)(6512007)(9686003)(478600001)(6486002)(6506007)(41300700001)(5660300002)(7416002)(54906003)(316002)(83380400001)(110136005)(66476007)(8676002)(66556008)(8936002)(4326008)(2906002)(66946007)(82960400001)(86362001)(38100700002)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bAXvCkCG9fn4VXSyhTUhv66MmSwKP2aYEwneSLnHFtxyn5GHJ338M7gn09pQ?=
 =?us-ascii?Q?ALg+bt9VZQQQ7IyNMdUHmOIzAYELihIbpI75q4oaqzRnahWTV9ayXBfU6MyN?=
 =?us-ascii?Q?hY/6AO6wZ1hDZqRna+jjpzzbyn8mFBRpG0qFofXyRPYx/12RrE8MMGfq4ZYM?=
 =?us-ascii?Q?58xtjqe3S3fzaGPGB4L0QX2EVfdyVs9bQ86DCOjDWT8zNM/ypef5OHFHL0ez?=
 =?us-ascii?Q?/7LVAnGopJM0iUtyAKmDZBUxZ86C0iSNiPPhbkbFOkXNRHcGRqmxa3O8DeJJ?=
 =?us-ascii?Q?9j4+SwRn+MLifxbHm+Ku4lWZp00S2diTbPkub6K84fY2x+7VicoyoiICJk+J?=
 =?us-ascii?Q?4MbZbZ7EiTaB0ma4CLa2ntY1ikp45F4bCvM+I1arBP7kIQKjphi/jA593+r9?=
 =?us-ascii?Q?YIk2M7WcOSLZlh4Rhc/G4IqxsCxogjYBrh20nGDfBRN5JqxSZq8fprichBQO?=
 =?us-ascii?Q?c5MWCLIcILuCQIzV8sniHSI7iAISq/a6l5CGYBFG9+ILZzVPn1Z5mc0+N3x9?=
 =?us-ascii?Q?KKwWRdQltRFQHXXZpW8hFLTVpo3W6AoDfyBs87wWAMmB3kBnhsOSXWwAhXPN?=
 =?us-ascii?Q?7YjfGoBWpmJonfNHGyOD5z5a8XlKDDk9/iSJYqh6dVvwniDqHrrsP2ZFlACg?=
 =?us-ascii?Q?lmjrhgA16kOSd41TvidMOewwCrKPytKI9OLQLJzmXtfBuGPv+/Y+pQT0/1/v?=
 =?us-ascii?Q?S4lnst1afAxI7kPsOJUWeS+pDdOPnOVnakUp5lcj39EclQKOQzSrX3djwpYl?=
 =?us-ascii?Q?VR0GU31lFiI1jmi6WowX4ki25O+L1YMJ93W8Vmt8JbFrtwPrwc5KKWU1UQsy?=
 =?us-ascii?Q?Ngz9x8QiEKqViqjLAb7U8ndI1RYv+fIBrcPQvP7tIlyUas5j7uEpj5sUzaFl?=
 =?us-ascii?Q?W2xlBWvc2uNh5vSLldy7hku8YXgtk9SVf7UJKYqXNnZESNQa7JZcZ7fYWT08?=
 =?us-ascii?Q?55SQ2d75llgRnAqx0xhzVMdIZI1y7T0GQLUxW5P22Sj3Us/Iwj/R3uvmBPCO?=
 =?us-ascii?Q?i5GUxF0xXssulJGUxR5rXw3f1sfJU5CYVnTIdISWLAPqKHqg5fyMg0LP+e7d?=
 =?us-ascii?Q?1DXlXH1cOJDTvQcPV0WlcdBTpp8tcybLIRIRa1VLzNxESjlOSvqWzY+4l/CM?=
 =?us-ascii?Q?F03mXqhAXIDj9gEIYfIqd7jlGrtXowjwJPK9SVYcXVdMgPZuwCHFLEhE+GqP?=
 =?us-ascii?Q?lCpLxGkC0cXe3GEZTbL/GrvZKfPMStTMhjDLNg0xDQ0wqu8pgJXUc+aXNASt?=
 =?us-ascii?Q?PXpRl2iCtnAfKY2PT2iAeKKQjChsdUYLEnqFfzYvvrG73z6zwcU0Ec4SKws7?=
 =?us-ascii?Q?eDttHW8WD36jaKoFLqsO/NCYwugIHRzPoiTkZ+iIQTuj3z0O+TRwuG+k6ZJD?=
 =?us-ascii?Q?+71jQY7dx3z2j5v7qMP+gyjARm3Y+R+fgvXvUIZDlpzANK+eqdQ85ekQ7TZi?=
 =?us-ascii?Q?an7CrerbeFin4C4iuFBkgGgshZwq4TPN9u4VwSNuIn0dFN38VNF35+ULlDme?=
 =?us-ascii?Q?q4wDSZtefIQkTUzz+q54S/T1wIb+4MAqU/dr88lKbMGVwE1Kcr7mfWsIAuPM?=
 =?us-ascii?Q?DFS9ScMG34Chi4hURrJEufEV5qazL+sW2VvkJBs+Ljp50cNfJ6OY/WVrS2Wi?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46875dc2-763e-453c-d15a-08dc1154784f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 20:49:27.4699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPlnTtcAMXThN5DyMqGXrIjC401S4ftaUTf7BURbTJe3uMdbV4avetOjqU2QENzD6yZT/XaANrsjP5usJ0uWMnu3M+vX2cNC4g+RCoJB8R8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6978
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 8 Jan 2024 18:59:16 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Ira Weiny wrote:
> > > Dan Williams wrote:  
> > > > Smita Koralahalli wrote:  
> > > > > On 1/8/2024 8:58 AM, Jonathan Cameron wrote:  
> > > > > > On Wed, 20 Dec 2023 16:17:27 -0800
> > > > > > Ira Weiny <ira.weiny@intel.com> wrote:
> > > > > >   
> > > > > >> Series status/background
> > > > > >> ========================
> > > > > >>
> > > > > >> Smita has been a great help with this series.  Thank you again!
> > > > > >>
> > > > > >> Smita's testing found that the GHES code ended up printing the events
> > > > > >> twice.  This version avoids the duplicate print by calling the callback
> > > > > >> from the GHES code instead of the EFI code as suggested by Dan.  
> > > > > > 
> > > > > > I'm not sure this is working as intended.
> > > > > > 
> > > > > > There is nothing gating the call in ghes_proc() of ghes_print_estatus()
> > > > > > and now the EFI code handling that pretty printed things is missing we get
> > > > > > the horrible kernel logging for an unknown block instead.
> > > > > > 
> > > > > > So I think we need some minimal code in cper.c to match the guids then not
> > > > > > log them (on basis we are arguing there is no need for new cper records).
> > > > > > Otherwise we are in for some messy kernel logs
> > > > > > 
> > > > > > Something like:
> > > > > > 
> > > > > > {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> > > > > > {1}[Hardware Error]: event severity: recoverable
> > > > > > {1}[Hardware Error]:  Error 0, type: recoverable
> > > > > > {1}[Hardware Error]:   section type: unknown, fbcd0a77-c260-417f-85a9-088b1621eba6
> > > > > > {1}[Hardware Error]:   section length: 0x90
> > > > > > {1}[Hardware Error]:   00000000: 00000090 00000007 00000000 0d938086  ................
> > > > > > {1}[Hardware Error]:   00000010: 00100000 00000000 00040000 00000000  ................
> > > > > > {1}[Hardware Error]:   00000020: 00000000 00000000 00000000 00000000  ................
> > > > > > {1}[Hardware Error]:   00000030: 00000000 00000000 00000000 00000000  ................
> > > > > > {1}[Hardware Error]:   00000040: 00000000 00000000 00000000 00000000  ................
> > > > > > {1}[Hardware Error]:   00000050: 00000000 00000000 00000000 00000000  ................
> > > > > > {1}[Hardware Error]:   00000060: 00000000 00000000 00000000 00000000  ................
> > > > > > {1}[Hardware Error]:   00000070: 00000000 00000000 00000000 00000000  ................
> > > > > > {1}[Hardware Error]:   00000080: 00000000 00000000 00000000 00000000  ................
> > > > > > cxl_general_media: memdev=mem1 host=0000:10:00.0 serial=4 log=Informational : time=0 uuid=fbcd0a77-c260-417f-85a9-088b1621eba6 len=0 flags='' handle=0 related_handle=0 maint_op_class=0 : dpa=0 dpa_flags='' descriptor='' type='ECC Error' transaction_type='Unknown' channel=0 rank=0 device=0 comp_id=00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 validity_flags=''
> > > > > > 
> > > > > > (I'm filling the record with 0s currently)  
> > > > > 
> > > > > Yeah, when I tested this, I thought its okay for the hexdump to be there 
> > > > > in dmesg from EFI as the handling is done in trace events from GHES.
> > > > > 
> > > > > If, we need to handle from EFI, then it would be a good reason to move 
> > > > > the GUIDs out from GHES and place it in a common location for EFI/cper 
> > > > > to share similar to protocol errors.  
> > > > 
> > > > Ah, yes, my expectation was more aligned with Jonathan's observation to
> > > > do the processing in GHES code *and* skip the processing in the CPER
> > > > code, something like:
> > > >   
> > > 
> > > Agreed this was intended I did not realize the above.
> > >   
> > > > 
> > > > diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> > > > index 35c37f667781..0a4eed470750 100644
> > > > --- a/drivers/firmware/efi/cper.c
> > > > +++ b/drivers/firmware/efi/cper.c
> > > > @@ -24,6 +24,7 @@
> > > >  #include <linux/bcd.h>
> > > >  #include <acpi/ghes.h>
> > > >  #include <ras/ras_event.h>
> > > > +#include <linux/cxl-event.h>
> > > >  #include "cper_cxl.h"
> > > >  
> > > >  /*
> > > > @@ -607,6 +608,15 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
> > > >  			cper_print_prot_err(newpfx, prot_err);
> > > >  		else
> > > >  			goto err_section_too_small;
> > > > +	} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
> > > > +		printk("%ssection_type: CXL General Media Error\n", newpfx);  
> > > 
> > > Do we want the printk's here?  I did not realize that a generic event
> > > would be printed.  So intention was nothing would be done on this path.  
> > 
> > I think we do otherwise the kernel will say
> > 
> >     {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> >     {1}[Hardware Error]: event severity: recoverable
> >     {1}[Hardware Error]:  Error 0, type: recoverable
> >     ...
> > 
> > ...leaving the user hanging vs:
> >  
> >     {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> >     {1}[Hardware Error]: event severity: recoverable
> >     {1}[Hardware Error]:  Error 0, type: recoverable
> >     {1}[Hardware Error]:   section type: General Media Error
> > 
> > ...as an indicator to go follow up with rasdaemon or whatever else is
> > doing the detailed monitoring of CXL events.
> 
> Agreed. Maybe push it out to a static const table though.
> As the argument was that we shouldn't be spitting out big logs in this
> modern world, let's make it easy for people to add more entries.
> 
> struct skip_me {
> 	guid_t guid;
> 	const char *name;
> };
> static const struct skip_me skip_me = {
> 	{ &CPER_SEC_CXL_GEN_MEDIA, "CXL General Media Error" },
> etc.
> };
> 
> for (i = 0; i < ARRAY_SIZE(skip_me); i++) {
> 	if (guid_equal(sec_type, skip_me[i].guid)) {
> 		printk("%asection_type: %s\n", newpfx, skip_me[i].name);
> 		break;	
> }
> 
> or something like that in the final else.

I like it.

Any concerns with that being an -rc fixup, and move ahead with the base
enabling for v6.8? I don't see that follow-on as a reason to push the
whole thing to v6.9.

