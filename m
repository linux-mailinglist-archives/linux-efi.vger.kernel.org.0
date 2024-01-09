Return-Path: <linux-efi+bounces-364-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F43827D24
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jan 2024 03:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6D31F228F5
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jan 2024 02:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF1723D5;
	Tue,  9 Jan 2024 02:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ptqe1+YU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18265665;
	Tue,  9 Jan 2024 02:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704769164; x=1736305164;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mvPYvDO9D0A1Asp+XCA1uea7BlnjeGWWDvA1PiifPMk=;
  b=Ptqe1+YUz32AhWpcL6LZHhq4mtZEuh0xFd8YARCR6vSic9833ht0tKky
   FygDA61BLhwtDZyMYArblRlBRWK5rZDUPI9iJWvWlCZLiHW1Cko7n7Dmu
   Uqpc8QfNU5BGg+EdjgxBQ5y5RWsIs4hWXwlRmtjKVKX6EsaxUr5J2JBvq
   eezlIRZDPzV/hwLQDXe8vYP0RubxfGwOu2Ci9xp2VBJwifGfD25EdeWL7
   2Rs8SkU+9an5hz2z/LapHrEuvC9Ql/9f7gVJas3WjuwM0VJSf55hEaJIL
   UOTmzoWs9MGXHkbelj0ZFC1mxLhHTIXKx5SiRNi2z8GtW46/w9KPkFDM/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="396936788"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="396936788"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 18:59:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="30007114"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 18:59:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 18:59:22 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 18:59:22 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 18:59:22 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 18:59:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmG43l9a6U+Wip8jaXT2tldKbxN1mCTIv+sqWLqOuL72luvesT0AJlmLxTYguG3ngfnxw3omH6kwrwYL6VElZ5T8qQkEpjCX8v1nPx/86imqpGtjD1mL9d9v1s00YhgjbBGpJ9atsg73uWC0ngc9xORtaD4GWjT/8z5VLhGbmhCFjmBWCR0IjSPc2d2GkQHY9Zl7zb+jDeovW6MKCsRT2t1cMWQiM5OSGJMBxlvVK/esTiMLWc/pMsT0NoCcR7e2x3Pu+BMUiByiV32g2kCY1N3N+Ux+nSltSi+NeUR8iiQt11WhTsXa020BC05DYMbDw6J6qafJOLkjb6VMCoNhPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ew4dPwY3KBRmfbtsVOlLYRmxGvLT5MM1kcl/Ba2BvnA=;
 b=XYdInzJnZkwS1G3sawPhq7TpabnV1g6YLiD7YOrNQTd30cMUTMBHFE+UuE/SjqDhue0oeAR4mFVy+NXLTIVwBFrd7TJ1sTEFGKWbM4EEm7WXZA53qX0rkUAlXUy/lIa01qtL70O954E0EeFwGxGUyI2xm/H70OSQ6FX36wpiKRMm6Yn07bldeGX/f+lY0l3faMDjjRZJseepn6zxIggawT5gt6z2cw3G2XZMAzVRkO5wYbcBJWe6G1QI7JlMG/lJuqfRl5MawXGGkbQwEeNrEJhYV4EwX+WoePXWWU6Xu14nUwVzAoJz81MtSgUdM2oobrhllH7JtlC6ZHjKj4cuhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6563.namprd11.prod.outlook.com (2603:10b6:510:1c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 02:59:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 02:59:20 +0000
Date: Mon, 8 Jan 2024 18:59:16 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
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
Message-ID: <659cb684deb2d_127da22945a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
 <20240108165855.00002f5a@Huawei.com>
 <eefc5888-4610-8e39-61ed-2d84e9ebf255@amd.com>
 <659caa8da651c_127da22947b@dwillia2-xfh.jf.intel.com.notmuch>
 <659cb0295ac1_8d749294b@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <659cb0295ac1_8d749294b@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:303:16d::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: 69ef4e86-4a40-4d8b-b8d2-08dc10bef9c2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/m0bMxNfRP47Vai/AacIKyws/rgH5RaFMe4dB/2ZtiP08TaSmTe7EKMXm706eS/OtkC9fD5EvlNs2pgcTDewxy8NZaYATRrw8OASkC94QVOO4jopbr5KIaWGsSK/Pj0eH3KLM5c3a3TxQyOzuXlpsRVhJeHqBqj+SRpOke16V7BXVgq2eTFs9fP44kCobJWTYNdAWW5vEwoMWDk5XUgu6JunroElg6qvHcWFA0fO3ZKeDlhv5GACORNKrdk1l+zK9gW5vOLRy0DwH83WGyOkDL74xq5Uq0BdwbvqIi+UmnF/sLGf2rcsFzldX/9VXf9LigZY2d6pnYjYCTSSRzy+afIbClZLD/Wbg9pTLmfFXmX4YAAwqMP4LnyuNhvIiho5JSxjB3J0HIzVN3omyN9N4hiurwb5oSetzheJZ3k2KLUdM7kPHHbYGeXAOBRSDSqhY9Ys7EICNOOeEKvvmvnLL08r7RC85LTvQq7xCAxw7aubRXg7ZpR7uzt/7LS8XutmPRBLY+13ra/yyAGu+rYZANV3RSo/dlYbkYjyxn98EyKZQFiGLx/XilYsw03xgWw+koMq3RNsxKqpcSNH3a4pDlkyMyawvwXkMqLmTshTD2+m/MXymBZow1GWCK8X2Wa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(26005)(6666004)(6512007)(9686003)(53546011)(6486002)(478600001)(6506007)(83380400001)(316002)(2906002)(5660300002)(41300700001)(7416002)(54906003)(66556008)(66476007)(8676002)(110136005)(4326008)(8936002)(66946007)(38100700002)(82960400001)(86362001)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T0gKZR8/VGsvvfO/Fz0mb/0N/8H9OKsoP/J6hN+85A/tO9x0iZW4se3uXmtA?=
 =?us-ascii?Q?dxyTfp1InmQDbCyFs6ECmvB+AUGd96hv8O6DJLTWlTNBZCQoXiBLnpxOHFiG?=
 =?us-ascii?Q?mdhPOSKSKyBtiU8TU64R8yXJcSO1RKCDArArIXONMurv7L18S3S8fz3sUa9f?=
 =?us-ascii?Q?yXyED+o8ysbGsaeg0MUVdekNlHhuL1Ek+jPunqDobB4Gqtw8c8bDXeD8WhTv?=
 =?us-ascii?Q?IIERD0bb7Flte9ijWsqykOBYxqBSYc9kDz+X7xrsDZ4buFgzjWvylsaTgFGn?=
 =?us-ascii?Q?yBiIiOzMjmcLVzsigW7aEHijtJ/aLyNjdk7EGTfEHXLWY4pXNs4wGXzDo/vQ?=
 =?us-ascii?Q?5R+Y/Nc7Akr2ejNXgl2vbHcRKTcujfTrpCWZ0uYlA25LkDZpFNAVaIYh9uLf?=
 =?us-ascii?Q?Z+/0M5ZUvfq6n6mCqNENW9KzAxiFVFGyyi+kY4oau/PhPUPNFtspNijGmmYK?=
 =?us-ascii?Q?mhkvAQiwvK+y3A1QqSswHQe56BYfNPGLHLKQWRLY/VwaVzVfeyLfKOz43Aii?=
 =?us-ascii?Q?lLEWf9d2rBsiD8r8pf5BOj+dUmNmWx5OSNA7u1OwVXuCdX5wxR4aKMfinlos?=
 =?us-ascii?Q?AXxcqfJG6xBmUZyLXuG1WMymTtnr3ZO/aAkceOTEJ9seGQoH2NQnQ7UeuXrR?=
 =?us-ascii?Q?5avr75/nYcU3HBcRc/uaG0oNsBaCNQkLPhCbpimwSv8MOySVaySXf/v2r7o1?=
 =?us-ascii?Q?n9oAJOLN/vm7AZ0fkW2idMaXCB3ak/yrTUoi4/obrBlkb5vdvkKPUJTVhfMv?=
 =?us-ascii?Q?LTBOCyy9vbAhiFcHdo0v8YlOPG0KRv58VuQHGADZlBAvaMaeybpnVsbXrAvR?=
 =?us-ascii?Q?BSzlWnKv/G46s8LYZgQdhlcD//wlV+axipzZbOFCJO5lviMBJMOJoxNIGwGq?=
 =?us-ascii?Q?CkapUQ6NCy8iwkjgZ+rwcVdMAM3NlXbVeiT+2R6tgID3LbvbKF0N5QOHaw1n?=
 =?us-ascii?Q?WMimyn4EUs0S636urXB/PzLE+R7u6lASgdBds3GuYpCbAWnFEs1MZVqYjpWH?=
 =?us-ascii?Q?W7PmPVh/GawsREMaDtnP6LZlYIlCmZMUbNst/TUz6MrI6L8ZobB+lQtkWDZ/?=
 =?us-ascii?Q?sZi3xOZB763LXb1ElgLTQH77ChWoG3oTRaRMmSss7fGmt0m//oAJhVua/4yG?=
 =?us-ascii?Q?Yr2tZ5pFMS7FHaXWfnl+GDtAO58e5ZnNHJ70vz/l2ryyg2YbJffPt0s0MP6I?=
 =?us-ascii?Q?rXqeAtOxuGPPIODvcewrKXG4fhalES/4UPZc+OkSMuUaTbTH2HvN3yI+/4UA?=
 =?us-ascii?Q?4QzIWXE+Zq0Sxuw+mN8wMWLyHkgABPKd2P5oQSjvPOadFUkOFjpvD0QUkK8z?=
 =?us-ascii?Q?kfRVT6kMZgpJvWlw/xpmC7H8fzm73OVHD+YgpRpig3LSDTHChcJdNKltv2uw?=
 =?us-ascii?Q?ZEjXnfKMP8VYKseT+NnCFljekKFoz+r8dj1XOHO1tw4jHj2/Ru3+aKOgWMQS?=
 =?us-ascii?Q?py58bcgkStdtWYI+jnkFwX8hNMVVcnJ29MFwTO5BapZSJ0oV6LXwegvYg5+L?=
 =?us-ascii?Q?c9OmR8y4iRrp0ww11AFSfuUn7JL+YURxLhsZXQb67xaZBYQ3ZhCzE3jOAM31?=
 =?us-ascii?Q?/GUNXuq3fPyASKJu5lEBDnDRr/MylUlNeGeThvmBSfLBhJwm+YiMmj3etO/F?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ef4e86-4a40-4d8b-b8d2-08dc10bef9c2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 02:59:20.1556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBiSNEj+PES4AQb+C1DfYzASvLTeprm9xSGYUQAyPhyMpRyd2ko1ZSgKrqUhUF6bMFVzjfCl06zJqupBiBEB+uj5/J4b4GHWyf4nhr80eHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6563
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Dan Williams wrote:
> > Smita Koralahalli wrote:
> > > On 1/8/2024 8:58 AM, Jonathan Cameron wrote:
> > > > On Wed, 20 Dec 2023 16:17:27 -0800
> > > > Ira Weiny <ira.weiny@intel.com> wrote:
> > > > 
> > > >> Series status/background
> > > >> ========================
> > > >>
> > > >> Smita has been a great help with this series.  Thank you again!
> > > >>
> > > >> Smita's testing found that the GHES code ended up printing the events
> > > >> twice.  This version avoids the duplicate print by calling the callback
> > > >> from the GHES code instead of the EFI code as suggested by Dan.
> > > > 
> > > > I'm not sure this is working as intended.
> > > > 
> > > > There is nothing gating the call in ghes_proc() of ghes_print_estatus()
> > > > and now the EFI code handling that pretty printed things is missing we get
> > > > the horrible kernel logging for an unknown block instead.
> > > > 
> > > > So I think we need some minimal code in cper.c to match the guids then not
> > > > log them (on basis we are arguing there is no need for new cper records).
> > > > Otherwise we are in for some messy kernel logs
> > > > 
> > > > Something like:
> > > > 
> > > > {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> > > > {1}[Hardware Error]: event severity: recoverable
> > > > {1}[Hardware Error]:  Error 0, type: recoverable
> > > > {1}[Hardware Error]:   section type: unknown, fbcd0a77-c260-417f-85a9-088b1621eba6
> > > > {1}[Hardware Error]:   section length: 0x90
> > > > {1}[Hardware Error]:   00000000: 00000090 00000007 00000000 0d938086  ................
> > > > {1}[Hardware Error]:   00000010: 00100000 00000000 00040000 00000000  ................
> > > > {1}[Hardware Error]:   00000020: 00000000 00000000 00000000 00000000  ................
> > > > {1}[Hardware Error]:   00000030: 00000000 00000000 00000000 00000000  ................
> > > > {1}[Hardware Error]:   00000040: 00000000 00000000 00000000 00000000  ................
> > > > {1}[Hardware Error]:   00000050: 00000000 00000000 00000000 00000000  ................
> > > > {1}[Hardware Error]:   00000060: 00000000 00000000 00000000 00000000  ................
> > > > {1}[Hardware Error]:   00000070: 00000000 00000000 00000000 00000000  ................
> > > > {1}[Hardware Error]:   00000080: 00000000 00000000 00000000 00000000  ................
> > > > cxl_general_media: memdev=mem1 host=0000:10:00.0 serial=4 log=Informational : time=0 uuid=fbcd0a77-c260-417f-85a9-088b1621eba6 len=0 flags='' handle=0 related_handle=0 maint_op_class=0 : dpa=0 dpa_flags='' descriptor='' type='ECC Error' transaction_type='Unknown' channel=0 rank=0 device=0 comp_id=00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 validity_flags=''
> > > > 
> > > > (I'm filling the record with 0s currently)
> > > 
> > > Yeah, when I tested this, I thought its okay for the hexdump to be there 
> > > in dmesg from EFI as the handling is done in trace events from GHES.
> > > 
> > > If, we need to handle from EFI, then it would be a good reason to move 
> > > the GUIDs out from GHES and place it in a common location for EFI/cper 
> > > to share similar to protocol errors.
> > 
> > Ah, yes, my expectation was more aligned with Jonathan's observation to
> > do the processing in GHES code *and* skip the processing in the CPER
> > code, something like:
> > 
> 
> Agreed this was intended I did not realize the above.
> 
> > 
> > diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> > index 35c37f667781..0a4eed470750 100644
> > --- a/drivers/firmware/efi/cper.c
> > +++ b/drivers/firmware/efi/cper.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/bcd.h>
> >  #include <acpi/ghes.h>
> >  #include <ras/ras_event.h>
> > +#include <linux/cxl-event.h>
> >  #include "cper_cxl.h"
> >  
> >  /*
> > @@ -607,6 +608,15 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
> >  			cper_print_prot_err(newpfx, prot_err);
> >  		else
> >  			goto err_section_too_small;
> > +	} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
> > +		printk("%ssection_type: CXL General Media Error\n", newpfx);
> 
> Do we want the printk's here?  I did not realize that a generic event
> would be printed.  So intention was nothing would be done on this path.

I think we do otherwise the kernel will say

    {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
    {1}[Hardware Error]: event severity: recoverable
    {1}[Hardware Error]:  Error 0, type: recoverable
    ...

...leaving the user hanging vs:
 
    {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
    {1}[Hardware Error]: event severity: recoverable
    {1}[Hardware Error]:  Error 0, type: recoverable
    {1}[Hardware Error]:   section type: General Media Error

...as an indicator to go follow up with rasdaemon or whatever else is
doing the detailed monitoring of CXL events.

