Return-Path: <linux-efi+bounces-960-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 536C28AD9D8
	for <lists+linux-efi@lfdr.de>; Tue, 23 Apr 2024 02:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E151F23546
	for <lists+linux-efi@lfdr.de>; Tue, 23 Apr 2024 00:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D48159581;
	Mon, 22 Apr 2024 23:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SfykuU1N"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9F315956C;
	Mon, 22 Apr 2024 23:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830099; cv=fail; b=FLrU+mUDFgTMBbTPfjtJrfAXmnTa00qc0Da8Som9cSoTsTQdr3LheEuB1yEdsYwyDPc6f3aoqcF49IL/GQt5AIbClNCWMLk3es4KXHN/ME/MHJNRsoCqfRslQS9znRVnne0k6ARE6Eh0SiVm9+nTXy024WqMf+lHgresqdlg1QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830099; c=relaxed/simple;
	bh=NmgzSJY4v6AsJyQwrFgGaHku+KOtEVRVKVdsDStVurM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uiiYdwsVwLtNiBJaYLlLvoGT58WKT3OCj4L3ox65MRbgStpiSxxk4LUtn3VYOhHotQkwjNtIvybu+2Bcxjai4df/p+ubSQ97lRieGm9bGOjAgY7j8gDCRuhQ86U/sJN/RlkAMsM8TnGq/wq+2KoDM/SUtIiYtn3HB3BnbO7+xr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SfykuU1N; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713830097; x=1745366097;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NmgzSJY4v6AsJyQwrFgGaHku+KOtEVRVKVdsDStVurM=;
  b=SfykuU1NRuxdlnleWvJN6jAsmtAPcpQHLIjGe/qu1QU9wza8CJ2OV9v7
   TgZjrtTVUSXLFc8d+1FfwvIYO8G1x1QKScjX+eNADr7KF4PglECzMetxz
   u3Hy/N/Rm4zXAPGCDA5d5XTDm6k5hPX6n9DtxylqZUf46hQhEn6haCRTv
   kKygxesnBhbzwDpS5O9ZXLFsvhTcsGWyVmuN1NCtvQvwHijcZZJ5wkMD/
   zBIWNufjISIXC7rEoMB+8rvFArTWm6fRK1ZQQk+377McnI23ebgpKnQDg
   NyHKq+6d2lzJS94H7jJYfU8k+xZOmtM0aaoTj5u+F5EQypiEY+PMYw/45
   Q==;
X-CSE-ConnectionGUID: GM/dvas8SRWuqz1BFHa0ag==
X-CSE-MsgGUID: TrVqYytEQRSMfnAXJ5NloQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="20006214"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="20006214"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 16:54:55 -0700
X-CSE-ConnectionGUID: Dmbqb1egSv6epqnVgpvShA==
X-CSE-MsgGUID: 7qRIa1AFQbybGKIGrnDxYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="24158870"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 16:54:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 16:54:54 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 16:54:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 16:54:53 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 16:54:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5lKtbZ0v6p8h1oK811Hb34x6fX4pUkl4ZPmod2voyeUqlndKAhsyrTtKe7OmhfaQnAa+FOAyBzr2K6KnoEoM9LmtnMIspeAOlO+NQr88z7YMxLvyVcZL5vGUUtLu/00sA7S5NoOgL3Qf4OllZ10uPl++PqBwDX4hQ+PNHSzgySaovMeUHEpjq0+VNbAvbtA0/Jzg0+/F9C/abwErb2sqlc6lSlYMhYeVIb3l8XN/CRizxvryXFx33IAHkl8LygQ1mfShWAK3s0JC3QWnKwq4v6tP5cIrMi67UvwZi+8fTmkRNecL1RlVCNw8SHZK6AsjjfWCFulXjNBD6S5BI7FaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioE1fx6t11uNAtoRmine3fjbkAMStgor8BpqAItnyKQ=;
 b=CKKnEemyX4PbOfJrAt5jCeIuGDok/2osvhyO4f/v4euBVK3MFY8evkNfPDSwCTPPk/DLuMQOyqjjvV3ZUf12ZiCDGhVWBcUNeDOwKjUYViCZt15y7NCOEqqs2eM8jPHymapNTylFwdUjcjp4LnAkKWM+FRKZ1ZaqZkp1DfhdpSf4OaJcQHjeHY/txd36UDIY/vdNjPfnKRle2DNTyh9uvyj7ug98joucWiqdaF8Oqr//+MqbywmE8T65UCaccrEuWoDitVMvXyAppTZ3r6J59BTgcTME3iwFpdhU+vjQeZ2WrKntSQgMhhbgTAwXjBJAOomQUrsiI7vpgAQbWSOEzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6094.namprd11.prod.outlook.com (2603:10b6:8:ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Mon, 22 Apr
 2024 23:54:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Mon, 22 Apr 2024
 23:54:51 +0000
Date: Mon, 22 Apr 2024 16:54:49 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>, "Borislav
 Petkov" <bp@alien8.de>
Subject: RE: [PATCH v2 1/3] acpi/ghes: Process CXL Component Events
Message-ID: <6626f8c9404f2_690a294d8@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240422-cxl-cper3-v2-0-5cdd378fcd0b@intel.com>
 <20240422-cxl-cper3-v2-1-5cdd378fcd0b@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240422-cxl-cper3-v2-1-5cdd378fcd0b@intel.com>
X-ClientProxiedBy: SJ0PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: 04600170-488d-4d9a-011f-08dc632799ea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G30xuYxorecZEe0IUzEUeVQS7JwbeQuoW5PRtsgLdvxZ+TPgsph1hB9InaTr?=
 =?us-ascii?Q?TxXjX6mclzsjOQ7vD5W3Pb8LDnEydaE1GHucMDChxZd2WE8eyNLduk7TuzYv?=
 =?us-ascii?Q?SmmFuT5PHNToHKqi7PyY9jF8NwqlIanh0TUgiQvdOv35n3EJk4qvazAEv8Cp?=
 =?us-ascii?Q?F6nySMhwM+GdU5mN8b/T7JjDaBzx9sOFMcK+Mr4DgO+Ko0CEv3OaQpVhzH0Z?=
 =?us-ascii?Q?14tIXmi+VgNNWaf3nYSejLCcsH4lE43F2RSGrOyNutJlouCO2IuFmyzjBJie?=
 =?us-ascii?Q?2vmDfm9DaFXutyuDlO+OvpuDD5gKU4yCVWn4oDlnxxNfbadJN5q6zbQoVzXa?=
 =?us-ascii?Q?U87almg8xcjZ9lvXdjcktjPNR4QfM9iGgzMQpfAS2E9ODkHA+atg1F5zT08Z?=
 =?us-ascii?Q?wBCJiVPI+MrpIiRp6SwolpjFbrrh8d6jPWvqvSjDWHVUG/8UaXKhS0U51Bj9?=
 =?us-ascii?Q?HKb3An8D8c11AZnBD5l75vnHez+RKsBedcWiz+VZND1ol55xegdZuCFVXLMk?=
 =?us-ascii?Q?6W4GuMsq8uje5wMfclPWW1230DKpXadkNoxdDUwWx8Q3+eE+Q79eIuvjyW1J?=
 =?us-ascii?Q?NZynE/VOwFCuq5fQ+d8/4RZv20YhiFy9kGFK0Mi7jzORAEWxl4buikzOXCBT?=
 =?us-ascii?Q?tFC4nQ3RI+nkspWGNUHik7jlBj7u8WVXYN+kURAiaOtcjZ7PxF4gSQdIJSKA?=
 =?us-ascii?Q?aVrLO9/4m2CWaBhTe9YdBQdN66fycFICEgAyihM3sqNBWG+CmfLQNMJahKt8?=
 =?us-ascii?Q?DMR/pR3YDh9TNeHhMSIUXMneenE/nW6RcjYF62DDItoSmda+r7LzJGw17PDp?=
 =?us-ascii?Q?VfSnS5KdJrRH/zMbNG2taFNI8+aIaQs6qxQal1o461V99wbf7dmL4kSKgfzk?=
 =?us-ascii?Q?NEfp/qzo2PhdCWWxL9MyGuQfeEws7t3FFrj9Knw5CIPXiDR6oTR78VOxtL3t?=
 =?us-ascii?Q?Xqqcu7MEgl0SeWRivjUURQbSDqxX/l5gd/GuKj8JzfF0zK6bACLgNOOERflG?=
 =?us-ascii?Q?F/N1p2vccnPLg2XwaPWY7nr0ubxLdCupBDX8PBx+fiBzXwP69xRGy/WaAdDA?=
 =?us-ascii?Q?ZdyJlkTKFokfbw3iMsxVreyzWEnWK2LN1UGD9eBt4bQYYmqJwiEHWZwwSe1c?=
 =?us-ascii?Q?tkXGNjp9/U7s8okWO+Oux+TQNvNvrlANX3CazJawZwD9A22HfNQfClu1fb3l?=
 =?us-ascii?Q?kouaNM3nchDUJtupl4kfDaxgp9+uZ5nCFZS6RqOiMQQvIAU0asGaeD8sBUVb?=
 =?us-ascii?Q?I+p2gRb+tNt6RqmpOYZxMTw7TDS8+7gwsQLW5ppqjOtNdQD74tCpGnDWxGdj?=
 =?us-ascii?Q?a1s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6LYVGwG4jsdrNHkBrvY7nDn+4qJNXARfzZXUchMq8OzTMnhJ2erwmQfELGNl?=
 =?us-ascii?Q?JUxjGDTCzag57XrByPXOc9cdFi1v7j3hNR+AuOq8RGFR87RYxIpO2U/Eylmt?=
 =?us-ascii?Q?WtTdTmKKZgnRrf7dRk1QrwNp12VaTdot5TA5JRlE1t1Ud0rscbdoaqESThlw?=
 =?us-ascii?Q?rQbybUiVC/hddvlSIWdiGadSMZkDcqAl++ajnPEz29XG89UGC5pe9/ZFKXpc?=
 =?us-ascii?Q?6F+/mFpAhGapsJ9wkFqAWFPWH7hC+GpbMaY/8HzZg4K2wUtOftC2Oax4SLAn?=
 =?us-ascii?Q?ALOdCOvm1WRzbttmwbOOmQUUYZ2D/PZW/UPEq59mKwDZgnVCRzinr00d+Awn?=
 =?us-ascii?Q?v4jPEzFs0tR045FZwjsVFo0qABc3axxWtLyZz+OIi8Xe0P5n2nzKVy+qU7lT?=
 =?us-ascii?Q?uvO098WXQbjH2Q0i76IyYVhogo1byjbxPyzy7u6HUZBIDAzL38OJbYhJfZn4?=
 =?us-ascii?Q?jmWdUroM+xqQQVcY7sXLVvce8ypazecxnwggd7VG5CGxtDC8LpqMFojRReiy?=
 =?us-ascii?Q?Uscnc8fFaioeVoGFpn7yW/mYWx8nfKK2hSqYXgL79zCGZ08McOaMiI+jbU+5?=
 =?us-ascii?Q?1a001vevlviOc9RCMg/4AkmBMuLI2i838a2FQ0MgnGClBs6rssDBudwXAglV?=
 =?us-ascii?Q?bI6hUfq/Up/4QORCR3nqteUfpg8Qe8ZHy97IMnHgil++lFBcQMVaqomosqcW?=
 =?us-ascii?Q?7jn5Mz6xhj+sDWd/tKFmUIcEpahDFk9TGAvC2G9qbtfMDcdqPE4mhWSeIN32?=
 =?us-ascii?Q?npVVXGCJVda30BqRNKDj67lJ+QEGqSNRXvfauhi+L/THqPemaBMKKtbH9kYQ?=
 =?us-ascii?Q?dm27Nr+/55JJ6QxVHJqvXIJljsXTCFAVkMAK47Ekm/ofOuB3aFd6opw1ulcg?=
 =?us-ascii?Q?5TtJzVP7pjhRD0Nwcy4i8x1/CiaAVHNO4pLtMCoc+a2N/HHpLpapRf+kZaaw?=
 =?us-ascii?Q?6dQAxX7yjZ9JMSVV5Nwb8xOyD7M3QZYX1vfxUUzSVYBwv80L5GrdteR9xH39?=
 =?us-ascii?Q?+q6E9Vu8JXhEeF7ur/lx4ifFfVTU0jd9Wc5yNaZn46JnPBEr2+XjFgYvItJ8?=
 =?us-ascii?Q?AZIZlBdqBQTg8pIR9gdihqa59nnA5cLScGIiB4XGRSyxwITDYGi5ocgoe5IF?=
 =?us-ascii?Q?yXUgbdMF9wPrKuga/w3dpCxewjPV4ak6xDj65iPPFPitL1qij+gKT8mSIXlc?=
 =?us-ascii?Q?C3ZUvdxGPQiBSe2efqZy8NpK6a8NUebSacRnQS1mWMvdz2ynRb8+KcH+vw64?=
 =?us-ascii?Q?wY4mXNvxZ6gnL6Ejz9WfVnt/t5j0IDbsMTQ182EdcvaqBDCNTPhXzKvsRM+i?=
 =?us-ascii?Q?7Lr75KecfKXx9milL25iwA+l5M3aMQXrst1WfqyoONBGU844QYyQypn9YBY+?=
 =?us-ascii?Q?lv6/vsy1qX4DUvorXyXPLltVH4mtW6jnfBcgQngEredfElqo8FPDYy1aq+TM?=
 =?us-ascii?Q?BpeZc8a0CUeiDHRwSbrG8nVO7f+ctuJCHDnLuWuPB24yn2fzoFrA3qAT8Dtq?=
 =?us-ascii?Q?Tnkc9HB59HZVPSiOrZy0Ew6EkdqefOiOYMbILSft0eyKRFxXDG+C+GvkzoZO?=
 =?us-ascii?Q?jbufjFOGeWC82m2sdk5fQ7tf8VD3JZn5TLxnQcOB7nnGndXFrEU9HUAc+YJw?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04600170-488d-4d9a-011f-08dc632799ea
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 23:54:51.9034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szV6XLt/INKNbLKvCGShhcHLXTwgc2rftVlcVHdoq9+mDwwBG1nnpbDvar/FrnnV6TCh8b37WdLeTFMQEO7JQammdx6TxScIjoLuCnP1JFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6094
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> BIOS can configure memory devices as firmware first.  This will send CXL
> events to the firmware instead of the OS.  The firmware can then inform
> the OS of these events via UEFI.
> 
> UEFI v2.10 section N.2.14 defines a Common Platform Error Record (CPER)
> format for CXL Component Events.  The format is mostly the same as the
> CXL Common Event Record Format.  The difference lies in the use of a
> GUID as the CPER Section Type which matches the UUID defined in CXL 3.1
> Table 8-43.
> 
> Currently a configuration such as this will trace a non standard event
> in the log omitting useful details of the event.  In addition the CXL
> sub-system contains additional region and HPA information useful to the
> user.[0]
> 
> Add GHES support to detect CXL CPER records.  Add the ability for the
> CXL sub-system to register a callback to receive the events.
> 
> The CXL code is required to be called from process context as it needs
> to take a device lock.  The GHES code may be in interrupt context.  This
> complicated the use of a callback.  Dan Williams suggested the use of
> work items as an atomic way of switching between the callback execution
> and a default handler.[1]
> 
> This patch adds back the functionality which was removed to fix the
> report by Dan Carpenter[2].
> 
> [0]
> Link: https://lore.kernel.org/all/cover.1711598777.git.alison.schofield@intel.com/
> [1]
> Link: https://lore.kernel.org/all/65d111eb87115_6c745294ac@dwillia2-xfh.jf.intel.com.notmuch/
> [2]
> Link: https://lore.kernel.org/all/b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain/

Minor, but this can be reformatted a bit cleaner:

Link: http://lore.kernel.org/r/cover.1711598777.git.alison.schofield@intel.com [0]
Link: http://lore.kernel.org/r/65d111eb87115_6c745294ac@dwillia2-xfh.jf.intel.com.notmuch [1]
Link: http://lore.kernel.org/r/b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain [2]

> 
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes:
> [iweiny: clarify commit message]
> [djbw: remove local wt]
> ---
>  drivers/acpi/apei/ghes.c  | 124 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/cxl-event.h |  18 +++++++
>  2 files changed, 142 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 512067cac170..cdcfdf6ebe81 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -26,6 +26,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/timer.h>
>  #include <linux/cper.h>
> +#include <linux/cleanup.h>
> +#include <linux/cxl-event.h>
>  #include <linux/platform_device.h>
>  #include <linux/mutex.h>
>  #include <linux/ratelimit.h>
> @@ -33,6 +35,7 @@
>  #include <linux/irq_work.h>
>  #include <linux/llist.h>
>  #include <linux/genalloc.h>
> +#include <linux/kfifo.h>
>  #include <linux/pci.h>
>  #include <linux/pfn.h>
>  #include <linux/aer.h>
> @@ -673,6 +676,112 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>  	schedule_work(&entry->work);
>  }
>  
> +/* CXL Event record UUIDs are formated as GUIDs and reported in section type */
> +
> +/*
> + * General Media Event Record
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +#define CPER_SEC_CXL_GEN_MEDIA_GUID					\
> +	GUID_INIT(0xfbcd0a77, 0xc260, 0x417f,				\
> +		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6)
> +
> +/*
> + * DRAM Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
> + */
> +#define CPER_SEC_CXL_DRAM_GUID						\
> +	GUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,				\
> +		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24)
> +
> +/*
> + * Memory Module Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> + */
> +#define CPER_SEC_CXL_MEM_MODULE_GUID					\
> +	GUID_INIT(0xfe927475, 0xdd59, 0x4339,				\
> +		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74)
> +
> +struct cxl_cper_work_data {
> +	enum cxl_event_type event_type;
> +	struct cxl_cper_event_rec rec;
> +};
> +
> +DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, 32);

Any comment on where that "32" comes from?

> +static DEFINE_SPINLOCK(cxl_cper_work_lock);

Needs a comment on what it is specifically protecting.

> +static cxl_cper_callback cper_callback;
> +static void cxl_cper_cb_fn(struct work_struct *work)
> +{
> +	struct cxl_cper_work_data wd;
> +
> +	while (kfifo_get(&cxl_cper_fifo, &wd))
> +		cper_callback(wd.event_type, &wd.rec);
> +}
> +static DECLARE_WORK(cxl_cb_work, cxl_cper_cb_fn);
> +struct work_struct *cxl_cper_work = NULL;

Initializing global data to NULL is redundant, however this feels like
one too many dynamic things registered.

cxl_cper_work and cper_callback are dynamic, but from the GHES
perspective all it cares about is checking if work is registered and if
so put the data in the kfifo and trigger that work func.

It need not care about what happens after the work is queued. So, lets
just have the CXL driver register its own cxl_cper_work instance and
skip defining one locally here. Export cxl_cper_fifo for the driver to
optionally reference.

> +
> +static void cxl_cper_post_event(enum cxl_event_type event_type,
> +				struct cxl_cper_event_rec *rec)
> +{
> +	struct cxl_cper_work_data wd;
> +
> +	if (rec->hdr.length <= sizeof(rec->hdr) ||
> +	    rec->hdr.length > sizeof(*rec)) {
> +		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
> +		       rec->hdr.length);
> +		return;
> +	}
> +
> +	if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
> +		pr_err(FW_WARN "CXL CPER invalid event\n");
> +		return;
> +	}
> +
> +	guard(spinlock_irqsave)(&cxl_cper_work_lock);
> +
> +	if (!cxl_cper_work)
> +		return;
> +
> +	wd.event_type = event_type;
> +	memcpy(&wd.rec, rec, sizeof(wd.rec));
> +
> +	if (!kfifo_put(&cxl_cper_fifo, wd)) {
> +		pr_err_ratelimited("CXL CPER kfifo overflow\n");
> +		return;
> +	}
> +
> +	schedule_work(cxl_cper_work);
> +}
> +
> +int cxl_cper_register_callback(cxl_cper_callback callback)
> +{
> +	if (cper_callback)
> +		return -EINVAL;
> +
> +	guard(spinlock)(&cxl_cper_work_lock);
> +	cper_callback = callback;
> +	cxl_cper_work = &cxl_cb_work;

Per above this would just become cxl_cper_register_work(), and then the
lock makes more sense as a cxl_cper_register_lock.


> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_register_callback, CXL);
> +
> +int cxl_cper_unregister_callback(cxl_cper_callback callback)
> +{
> +	if (callback != cper_callback)
> +		return -EINVAL;
> +
> +	/* Avoid guard() because cancel_work_sync() can sleep */
> +	spin_lock(&cxl_cper_work_lock);
> +	cxl_cper_work = NULL;
> +	spin_unlock(&cxl_cper_work_lock);
> +
> +	cancel_work_sync(&cxl_cb_work);

Also per above, moving the responsibility of cancel_work_sync() to
caller also brings guard() back in play here.

