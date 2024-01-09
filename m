Return-Path: <linux-efi+bounces-362-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DBC827CB2
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jan 2024 03:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB85D1C232D4
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jan 2024 02:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE21B187E;
	Tue,  9 Jan 2024 02:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQlKWalB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA1E186C;
	Tue,  9 Jan 2024 02:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704766101; x=1736302101;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=x2FOR1b6jDbvfFc9ktuVCUN3VnLefJZz7OEXXYxXoV0=;
  b=EQlKWalB3450X9+2tDgRb1wtHsWxB+XP5lJk20a6J5SwacDfmMKnsZuN
   v5+x5VgAUM9P+Llc9DnY53b9evDBcUk6J3CSUqt9Ng/PCvUQjOOgX9IS1
   rmw4jExfqqIFgvW5EwkCrMsYXgC9auxXrC4meTdOnunCk6DAg+JFKBaZa
   8r097GPJvyQ2ydn3j82uc429HEsOimLeNH8KM6ESRcLB0WFQlcUlP0WXO
   17weq6Ba1yvFH8tgbzKOQRm8uGNHc0yI0GJ00EkdGdLT91CdPQAfq4PjU
   YVAMxG+/IXASyU/EyNRPJ5U6wrmKFKw5WO6GyFe8OiizwH1DiAnLVdSX7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="388499905"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="388499905"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 18:08:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="23721525"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 18:08:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 18:08:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 18:08:19 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 18:08:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kElbPUzyJeleJaihyY56uPhvA1d2wb8oD9PF4t2Wkfn8ChZGmzho6j7t+D/CBn/h9gHFanzqLYUDyega4LpmR3yGKPM+KgloAlj1fZmIuPoGS78wVlrgc1ga2+++ckAKBHCe1FatMjjgBbZmBJlDGp30FtNodI3y/RKUxmr7ZEgjkrXtO7xdmyhLgC6ezai4POE2DM3MVOhtfvvPxXNkO0miLSX68wp9z32Jsd1oJT69oTis5a5T1EYV/Gu1WFBpSz1B7CcOslkpDBChSwTuSZqhYLg4XxWwgrJbJbrpftPEN+N3Hawq3Ph7SvZRoKEcOqo6CRIKeycgTKVYMDVW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/X2/bRlMvk21ZH77OQ8CuYaMwo9l/Z/m0Co+qA8imgo=;
 b=D/1udAQDnk5et5cd0Nx6v+0weiLmc0ixnlAS0Pbhr6T/ZvN8R+yFNQenzsHGddWOZo1++m/VLMy9s6bTFyr6LY2apbSRPq21VRTSnh861NT0agbcBwHnOaSz11FcioeZdk5IaJvHgGs50qGUFfE4S9T9ggZcqiJWQRk6fxe5RPDK2Hd/+t3sLmwljZlh2yrhbTrjc0RKiMW84vc3JFTZ2hC0TJLO2hiDv95r9VInPV45oiMREf6ZyJKYhm2zg83w8+raneQAMAFybSR9XqzQOz6PXzEla/rdh2rK1yvYHJvjL0oDKqW0WyoSzHyTIQx53om630qWpTpTS4U9Uc39ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6289.namprd11.prod.outlook.com (2603:10b6:208:3e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 02:08:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 02:08:17 +0000
Date: Mon, 8 Jan 2024 18:08:13 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ira Weiny <ira.weiny@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Shiju Jose
	<shiju.jose@huawei.com>, Yazen Ghannam <yazen.ghannam@amd.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>
Subject: Re: [PATCH v5 0/9] efi/cxl-cper: Report CPER CXL component events
 through trace events
Message-ID: <659caa8da651c_127da22947b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
 <20240108165855.00002f5a@Huawei.com>
 <eefc5888-4610-8e39-61ed-2d84e9ebf255@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <eefc5888-4610-8e39-61ed-2d84e9ebf255@amd.com>
X-ClientProxiedBy: MW4P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d3762a6-23db-453b-b2ec-08dc10b7d805
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TOXQ/NEphllwbkPfakfG6kdeuoEQbiuD+SCbYRjGS1zhIFzI963lUBly8YCnBcS/x549E+pnmCu07H5ll2asCDxeu7v77Tf36IvL9OKcUKplIO7iNZInCpgVxudSHJIYEeqvlnG2P3mmKuIRHQDYDq6PJllT6cSIEaQ/bSsjJrP1sqL9qlba5YD0FWdGdM4LWeWxobcJDX4l5dde24hh0YSpAdSmhyIdYwuU6O1nMdIp3QAr3K0RK9T2vxB/CfOmxseaMn/btb5wIJSqyZrdRqJfov9h14MJkG6QutCcC41Ons1cFUGdkpgYneLgxRd8dkjtkAlR3FqhhUK+PnYmIKcKy8dpZ3EmYM2o3M29NeQzXrBSvNxQhtl46gaZsUUZrlSkFZXfBITgYOgB6PQZBGlviLRZBFUUjWOBbgkbM3cxE/IoAUMRi5Txk11IvwZzDV8z9EON/JoITSzYSH5UY0fn7npWlzlndK6L7rD4UdiP8XVMU3bM6yrb68EoA8EwNG6vc3IcYFa1TSunBXsOhyDrx9a0BRCPKU1D4h0JrTlcsLkzR24CtvDUUta3aqQLq5PrvQpaK0plzz+1lZEJBJhQyESGDvME3sESNPYHXxDLiljMntDlPGjn2Vg/CeLz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(376002)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(82960400001)(86362001)(38100700002)(83380400001)(6486002)(26005)(53546011)(478600001)(9686003)(6666004)(6512007)(6506007)(66946007)(66476007)(110136005)(54906003)(6636002)(316002)(8676002)(8936002)(4326008)(66556008)(5660300002)(2906002)(7416002)(41300700001)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5arirFYx0epNs7yIF6NHEiSiCuOUNV0MI0LKkZmiKbT624DLp7VPvcM54gwp?=
 =?us-ascii?Q?tSCf5n0aqKRUKnPlk3iMcXimFbwAGYUe+3obCgfjeLKhjyy0ZKLmXGGaut4m?=
 =?us-ascii?Q?SRQ8tsTLb4B+4VU16u+OMDbUtj6XHMobsUb7O6ugqi1e87NE382Hn2IqEn/C?=
 =?us-ascii?Q?ZYhs/H+dS1Xl8+O+OJMwxKWhZnxDWWXaijbPyGHrZxYYI0/hCo9I5JKxx3Va?=
 =?us-ascii?Q?HPvYZxFf322fO0tIWUuNuvyts6HZLnQqDTYTxtL9iwixOMtA7Et1jfH34FOr?=
 =?us-ascii?Q?rBuzCkUzfBuTA54taQSzT69rYkgNBm20/JM8bKK3GrY8Zve3z1FZVvThQlAl?=
 =?us-ascii?Q?5fh0BUKqiK7C8p2TBHOJjJXwSq4i2lTTqK6yKaF9xeX3EpGeaKvbanxEuPzE?=
 =?us-ascii?Q?7Im5/QrOEDe7AgixqhSDShUPBXLavchJLZ57a0R1Vy2nkpmJlLu3SPwYBg39?=
 =?us-ascii?Q?JXg0WqHDinpxc/3wFkJ+ZIEC5VkDCHzpOQ+S0Azcivof5D+/BZqkWZ9JxdCv?=
 =?us-ascii?Q?x5fXMTFNT2+ITEp+M39m4p7XW1tcfEf/lfRBaM7scCMWKhojWHi/RzNtQLG4?=
 =?us-ascii?Q?pIz8j3epnNEJ//g3ArYYiOpAKXCQHvM06CglltWcxXU1mQu40pZsUlVn0H8A?=
 =?us-ascii?Q?DUoyklsvmkL+0cNToDsbbqNDtIW2n6EXJOtBnXAo+Za4SBpCZMhLgxVen0FX?=
 =?us-ascii?Q?JeEVj9plarUX6S5Gg9Y04hzNoWEVLmJ4Rk5eYIjfYNfvE5vvJm2DBLWf2A4+?=
 =?us-ascii?Q?QdY5GLSe4E+UT5UNGjLa/eJtEmg648O3yBXdmuNYdJvPEYTcctmShXY9rS+x?=
 =?us-ascii?Q?4lVGoemjv/a4oGPv0MUGx+IY2pZpbT9evGRciFUuO9q/K6XnI06Lal0CSBUj?=
 =?us-ascii?Q?yyzwvLHyNiVvA+20tHsDarRzqMCtYaqb9ZyJ8BGfcBLVFvDPpy85YVHf64Jn?=
 =?us-ascii?Q?El7qV8jhev1D7a/1ACRzMRmHqbMPmQOGzWxJV736vBQxlSglbIVLurRR/EN8?=
 =?us-ascii?Q?bS/QMbLh9Wxprl5jKRiwc8PkgFZIgwAnh4FbajenJVNY3GWF4ina241A7Lml?=
 =?us-ascii?Q?W0vin/IWqH3rwCUs7mFIa2UKtrMdi+uePAIdGugZhl9VaJ70KBX9HI/IJin7?=
 =?us-ascii?Q?gblgGSuru+gbHMZqmSTJHUGDVbCAJ3Ts5M0EbicavO0gXoKumL+q6MJMAVR7?=
 =?us-ascii?Q?WSHWorWf1w35aQngzEkGuyzCEnwxQx4AyCK7vSOoUr9sCFURpip+dyRL88mV?=
 =?us-ascii?Q?cWitKeWd3zgfBWeGamGm4P3ZxAy3RajGm7KFsnpmShineLWGp4LZXt+3QWWj?=
 =?us-ascii?Q?RQReUDz55tP5IwToddzukL29Zqi1xf7KbOpLPsR7leFu96iGwc6MlWgv7w2r?=
 =?us-ascii?Q?inv2U+stDCl6V0vpguy9tvsjyZf5UxPsoUFwueJaUwoDLUsALvh5QT/nA88u?=
 =?us-ascii?Q?52qrkMlKuKLrTAiz1amLSuS+VJfOllIhnATZFoucfmKy0sKDaio6Ngc86i+D?=
 =?us-ascii?Q?pRfLRMb2RdVU4YjI8kskSWFfkZCMHrWXOnTLTgjWK84j9IRxnBjtmdlNGIJ2?=
 =?us-ascii?Q?Xgqx1mfWdmQD3tkRaXLH4ZdkziQ2OxgW5FOuP2PffcijL63mJmbcZNqAXKQQ?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3762a6-23db-453b-b2ec-08dc10b7d805
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 02:08:17.1158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TOFrmqj+tgqcEM4BoyqA2dBkeMaOeZf2yoh7d9hi6yzJFPrBnYMS6nyNL7f0FdcdJVf7XDJDkyRxi4lKGsVX9Q85W+a+M6w+s+q0ddMvwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6289
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> On 1/8/2024 8:58 AM, Jonathan Cameron wrote:
> > On Wed, 20 Dec 2023 16:17:27 -0800
> > Ira Weiny <ira.weiny@intel.com> wrote:
> > 
> >> Series status/background
> >> ========================
> >>
> >> Smita has been a great help with this series.  Thank you again!
> >>
> >> Smita's testing found that the GHES code ended up printing the events
> >> twice.  This version avoids the duplicate print by calling the callback
> >> from the GHES code instead of the EFI code as suggested by Dan.
> > 
> > I'm not sure this is working as intended.
> > 
> > There is nothing gating the call in ghes_proc() of ghes_print_estatus()
> > and now the EFI code handling that pretty printed things is missing we get
> > the horrible kernel logging for an unknown block instead.
> > 
> > So I think we need some minimal code in cper.c to match the guids then not
> > log them (on basis we are arguing there is no need for new cper records).
> > Otherwise we are in for some messy kernel logs
> > 
> > Something like:
> > 
> > {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> > {1}[Hardware Error]: event severity: recoverable
> > {1}[Hardware Error]:  Error 0, type: recoverable
> > {1}[Hardware Error]:   section type: unknown, fbcd0a77-c260-417f-85a9-088b1621eba6
> > {1}[Hardware Error]:   section length: 0x90
> > {1}[Hardware Error]:   00000000: 00000090 00000007 00000000 0d938086  ................
> > {1}[Hardware Error]:   00000010: 00100000 00000000 00040000 00000000  ................
> > {1}[Hardware Error]:   00000020: 00000000 00000000 00000000 00000000  ................
> > {1}[Hardware Error]:   00000030: 00000000 00000000 00000000 00000000  ................
> > {1}[Hardware Error]:   00000040: 00000000 00000000 00000000 00000000  ................
> > {1}[Hardware Error]:   00000050: 00000000 00000000 00000000 00000000  ................
> > {1}[Hardware Error]:   00000060: 00000000 00000000 00000000 00000000  ................
> > {1}[Hardware Error]:   00000070: 00000000 00000000 00000000 00000000  ................
> > {1}[Hardware Error]:   00000080: 00000000 00000000 00000000 00000000  ................
> > cxl_general_media: memdev=mem1 host=0000:10:00.0 serial=4 log=Informational : time=0 uuid=fbcd0a77-c260-417f-85a9-088b1621eba6 len=0 flags='' handle=0 related_handle=0 maint_op_class=0 : dpa=0 dpa_flags='' descriptor='' type='ECC Error' transaction_type='Unknown' channel=0 rank=0 device=0 comp_id=00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 validity_flags=''
> > 
> > (I'm filling the record with 0s currently)
> 
> Yeah, when I tested this, I thought its okay for the hexdump to be there 
> in dmesg from EFI as the handling is done in trace events from GHES.
> 
> If, we need to handle from EFI, then it would be a good reason to move 
> the GUIDs out from GHES and place it in a common location for EFI/cper 
> to share similar to protocol errors.

Ah, yes, my expectation was more aligned with Jonathan's observation to
do the processing in GHES code *and* skip the processing in the CPER
code, something like:


diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 56a5d2ef9e0a..e13e5fa4df4b 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -666,30 +666,6 @@ static cxl_cper_callback cper_callback;
 
 /* CXL Event record UUIDs are formatted as GUIDs and reported in section type */
 
-/*
- * General Media Event Record
- * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
- */
-#define CPER_SEC_CXL_GEN_MEDIA_GUID					\
-	GUID_INIT(0xfbcd0a77, 0xc260, 0x417f,				\
-		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6)
-
-/*
- * DRAM Event Record
- * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
- */
-#define CPER_SEC_CXL_DRAM_GUID						\
-	GUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,				\
-		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24)
-
-/*
- * Memory Module Event Record
- * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
- */
-#define CPER_SEC_CXL_MEM_MODULE_GUID					\
-	GUID_INIT(0xfe927475, 0xdd59, 0x4339,				\
-		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74)
-
 static void cxl_cper_post_event(enum cxl_event_type event_type,
 				struct cxl_cper_event_rec *rec)
 {
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 35c37f667781..0a4eed470750 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -24,6 +24,7 @@
 #include <linux/bcd.h>
 #include <acpi/ghes.h>
 #include <ras/ras_event.h>
+#include <linux/cxl-event.h>
 #include "cper_cxl.h"
 
 /*
@@ -607,6 +608,15 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 			cper_print_prot_err(newpfx, prot_err);
 		else
 			goto err_section_too_small;
+	} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
+		printk("%ssection_type: CXL General Media Error\n", newpfx);
+		/* see: cxl_cper_event_call() */
+	} else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
+		printk("%ssection_type: CXL DRAM Error\n", newpfx);
+		/* see: cxl_cper_event_call() */
+	} else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
+		printk("%ssection_type: CXL Memory Module Error\n", newpfx);
+		/* see: cxl_cper_event_call() */
 	} else {
 		const void *err = acpi_hest_get_payload(gdata);
 
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 17eadee819b6..6d9a7df88d4a 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -1,12 +1,31 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_CXL_EVENT_H
 #define _LINUX_CXL_EVENT_H
+#include <linux/uuid.h>
 
 /*
- * CXL event records; CXL rev 3.0
- *
- * Copyright(c) 2023 Intel Corporation.
+ * General Media Event Record
+ * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ */
+#define CPER_SEC_CXL_GEN_MEDIA_GUID					\
+	GUID_INIT(0xfbcd0a77, 0xc260, 0x417f,				\
+		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6)
+
+/*
+ * DRAM Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
+ */
+#define CPER_SEC_CXL_DRAM_GUID						\
+	GUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,				\
+		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24)
+
+/*
+ * Memory Module Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
  */
+#define CPER_SEC_CXL_MEM_MODULE_GUID					\
+	GUID_INIT(0xfe927475, 0xdd59, 0x4339,				\
+		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74)
 
 struct cxl_event_record_hdr {
 	u8 length;

