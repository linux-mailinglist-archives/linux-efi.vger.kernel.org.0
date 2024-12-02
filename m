Return-Path: <linux-efi+bounces-2248-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF219E0B3C
	for <lists+linux-efi@lfdr.de>; Mon,  2 Dec 2024 19:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49EA22826A8
	for <lists+linux-efi@lfdr.de>; Mon,  2 Dec 2024 18:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901031DE3C8;
	Mon,  2 Dec 2024 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dK/BqkoZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676251DE2A0;
	Mon,  2 Dec 2024 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733164933; cv=fail; b=XrSBelH/CmwCixFon5u5kwheMJ/Hb+KMk+Gou3fTv2i2lVpNKF9UTndsUKzB6SMdW+Z4XW4O0msOh6qo5k6TbH245TBKd3EVFDyNwAfD95VNdcL4ldRCk5P53QtBXLzaKuH117TNGocp02t+xM8/u3KK4xjoCN5p7gT9P+/bRgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733164933; c=relaxed/simple;
	bh=Hw3Zj1gLW+XydP5zBHaK777U17bQLuXT2KU4OZ1fbaQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ear4RkyPY7dPyaY4gtUrBShAD2QSWJkBqdcvjCx5sNca9SGY7O5oLxtDB5WNTvRYpYA0PJs+cG1jHEEhLzQiQ3+cugeXxgr5GIa8x6S1ErR5PX4ihavPAxJURwNbkl+UVanwctj55m8EGufjgds+tmD3pW+dRSeqSDZ2ashO+58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dK/BqkoZ; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733164931; x=1764700931;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Hw3Zj1gLW+XydP5zBHaK777U17bQLuXT2KU4OZ1fbaQ=;
  b=dK/BqkoZ/kzL6QsbOXdxU3zuz8q++hdtM864IxZ9huyNAsY5oPbdumrj
   saVDtTFZa20h4iIrMo33Y8LmBU5pSmGg8L6b6RdJZcwoVgmZch1WXqKy/
   aYoF2ay37sNfCAXeorkcu5096lYCx58dxFADyW8UR4fllo+XEU4YgIFzO
   091NFTMN+y0jeJu/Ib2D9qDyXxA6f00mwRrDSQIBZhmLHJ1e8DtmksCsI
   do/pyszmOUAeqdOxHTNdIour7aaV1FbZu64Y36lgK/6RBVQLxTg//XsNZ
   KIFp6Gp8Rpr6Z+9sUPMR5/hq8eMpkFaHUYqh2bwrobj5jhGtnRPQwJmcg
   Q==;
X-CSE-ConnectionGUID: yiJZSMjeTge5Y7A3Sub5Cw==
X-CSE-MsgGUID: lc/7xOMaToaFR3mPrySyAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33596420"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="33596420"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 10:42:09 -0800
X-CSE-ConnectionGUID: APSG7oAWR3mQCrqnQCC52w==
X-CSE-MsgGUID: nxKpyVSwSMa3V4524eZvwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="124122053"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 10:42:09 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 10:42:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 10:42:08 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 10:42:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXp3nkRi+v4FLtrCj4GDFpcBVzWYyxCmOBMspB6bQVloGllT2cBTkftwrv/N3hYeBOvf4luDy/n+F8ZB0k0DrXK2MT8ABxSCu2JcGm3be4niWXauT/8kMnbjn5nLlGGqIYN1tjQYJp1k82ZqPEDsiOr+d9OEK+fg70EoepnvH7SJ3m0w92ZChw/4mQb8qKp2bvGzIYsilH1owY1He++EfIwq7k2TKioXvIfeAfwy7rby5Ka/qAimVxRUL37K2Rs/NQgTqyMvbF4vSNOCYK6gmJ3pP8lKGgofgx2KhSZleMOVIhnJLbeUSvHb6lwu0vZlGzK4OYGg04QiFgqA9v7BlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEuq71mRzN9cEL70OBBPXjGRXL+2FrnU/hNgIQgjE3Y=;
 b=D7TNSB+Tg/pPpU8GITbjOcJ1zKSa+bihTHG8liggRpi7xZNychz+qKOM6iGUCVSkJgn9n6ZkYLlgTeA8ikAR5QqYWwsEWfzQ3LB76wKE1WnoyG0YozbmPZz2ehpUNPngIt75OB1dMlHpzKr2UIKjhVNGVEeESRhafkEmXcW0hLpVrpJQTYNJ7ulBCTBrlg1XMPQDbxyGIdthMbzVf0PXX+IIlC3PTKr8FjZjy3mwYXTywuaVes43jYXJDJxVezxS7Mi9wMiXRrz7jE7JwWlpvpI857N5HsKeZ5ecoXc0sQll4MVvyJswY7RMcQlAhwuNe6+AFhTewX7rRAvbOLwQCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB5795.namprd11.prod.outlook.com (2603:10b6:510:132::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 18:42:03 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.8207.010; Mon, 2 Dec 2024
 18:42:03 +0000
Date: Mon, 2 Dec 2024 12:41:58 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v3 6/7] acpi/ghes, cper: Recognize and cache CXL Protocol
 errors
Message-ID: <674dff76fcd_3cb8e02949a@iweiny-mobl.notmuch>
References: <20241119003915.174386-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241119003915.174386-7-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241119003915.174386-7-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4PR04CA0239.namprd04.prod.outlook.com
 (2603:10b6:303:87::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: d37dc98a-8191-44f4-a93d-08dd13010373
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dpBHgashDrsUZwi+sRcKQZMgkwJTOKecojhb3tsLNHPmUVEiYL5/duTDvlMx?=
 =?us-ascii?Q?4wNiR7Hv4LVLvbe11HkC+qtUjbgcJZa9HMif6uRH42wDLp2fDIho7g4XrZS3?=
 =?us-ascii?Q?+5XqW1Gyh0MZHjyg7OvCLcUDRvZbP8c5OaAUkekWllMKfBi0S+9O1ZTtde/A?=
 =?us-ascii?Q?q9X5SHUDfEQHpPsQA+t87zczmZFUeoWQFsxk4HrMvr0kIeUfoOxamswYSORL?=
 =?us-ascii?Q?ajH80lVYSEl6+a8Lk5FgxFAYonPEFUaAEjKDG2y4jwGWKgI1/exm85NRvDEu?=
 =?us-ascii?Q?wSQQTia26BB5ypue8EtZEeF1MznVrhNt/9s1FWa5iZ8Ureu+Xb95OtAHJriM?=
 =?us-ascii?Q?3VQHuqBrk4jswzM7aT0BORJckAxe8pTyZgaLorBhpptVPx+2/hD6VWIS+6O1?=
 =?us-ascii?Q?L9fbbbCZWtUeYWflFu5d115PT7o7HgTur/G7tDZ+uVHL+wrlEKt+UPGQEYEl?=
 =?us-ascii?Q?ZdI4yUOXl3ddnp6EKuQ8qNy3lQ1U6dUh6hsUbXB76D48Srh2keVrQlJFdNF/?=
 =?us-ascii?Q?5r4vD3MGgcU2DIpLJa9Ev6Eeh6JFaoyufym/LUoagyhTKjGn3yePONeNm0Yh?=
 =?us-ascii?Q?HFBfVXUZNn2XGoF4GfrVO1q6qz3ZZpaTfzoxC1YiHiIXEZwcSUNxdMomGX/w?=
 =?us-ascii?Q?aHsJfTvtpqNXXTZ/QZJIlnqeQ7XwtAs3qnTfLiYazuxPUve9/DWj0mrvSFye?=
 =?us-ascii?Q?rg1bugzPYNFRKG7g3VBlssysWBblzSHb3/hBlX9rIuSseeVEmY83D3WMxl88?=
 =?us-ascii?Q?WMgoH1OvDnxLcf8rY+Q7HMeUmxwHOIf0uwSNtpTtApVLxOJ0jl9CUkqBsnJN?=
 =?us-ascii?Q?2w6Qa8F+o5eVuwQfkhU6N8sZLGxdrk+mdQBV6mL5kUdCygd/iP/9Rmh2rall?=
 =?us-ascii?Q?FTOD7F9dN2hc8h+9evVZ4H2eh55IQ+55d5qcT9w8IBL5S5cv+4AF2ux2V/cb?=
 =?us-ascii?Q?cPX2X+JQC8N/tTf8vp+jHSE6AARt7ez345Dao0RI080c14ITfxqK11uuEe8Q?=
 =?us-ascii?Q?3v7fnboXoSXjCe+x2uM5dVe9qxM/7WPgIUUTdTn84mip0d62WYXnUH/r/ARb?=
 =?us-ascii?Q?jTRUMe4tLOqBupbzV0vtSPaSuzECy7aEDXyr9nXTM1AH8P+GzAjSXTXcLPsU?=
 =?us-ascii?Q?G8W/DgIn0ZhgqSiR57kBbgKsOiocFaUzVtoD0GILsuAcfkUvovM1fsLUSLpn?=
 =?us-ascii?Q?47UMHoOUNY5uhbLzeqdoGEDC7ywAeV1L9byN1M2ZM6zS8PKVS1fudfB2P/Xc?=
 =?us-ascii?Q?g3OALIYQ4jmrWrG5UqLRRAcIgOa+Pi3dicUsqrCQMNvn6ZIU2uToZb17Zy/P?=
 =?us-ascii?Q?LNxvwzJIAI68oAZ+UVJtKhmbdKNQRC6QQXGcw8SBZ4HokA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1G7yzHtoRbjAtRbMSTz7NoaFQ5x8+Vb+XuhCVdipc5iEwnJp9VIh6VOmW5Ue?=
 =?us-ascii?Q?u0h+8EkxwM9pZnoe7qt0gf5DJIGzQzigwgEL9OqbeITp9fymUI068aLOj0ir?=
 =?us-ascii?Q?IEnw/flx4bdbxaSvbhDC1VnuF9NDiJ2Ywte4RBL6HEDuC2P9VvRqCjhxLBpZ?=
 =?us-ascii?Q?hPTZf1dNubBwzaSFqle4lUhjrvmWftGOeOBeJu2PL5kfcV0eUpZulMwyopdR?=
 =?us-ascii?Q?DgHzMjaQRlBonvy9sGXDGZS4fN5XnnU/w85TvwOcjGDubC4mUdCp7jY0wmRQ?=
 =?us-ascii?Q?aAX8RzUdGye+FNxMb6hF8oCPksAAsoarIQJRsT1dd/OsuKBlL1Z1vARReuhQ?=
 =?us-ascii?Q?CmlcfFe6f5p1kHnHskeR8V0sNR64AdLjb7PIjdYY/Iyf5Z0fnpXVfpuDRNPK?=
 =?us-ascii?Q?KyjDpcMY48ryxtjZ/6RtUYkwGo7q6AIPINuPtejYSQagwOid8/kSVK3q3o2i?=
 =?us-ascii?Q?8ToSRzyBu+1csp72j3z4RLKY9NlWdMD86RPFkKGBsNSaQ/gtLSTN0FPCjjza?=
 =?us-ascii?Q?smK1qcgIWekt1kDEpn/jZvkhROK09uCByY24w47f9o+mt6MuUJkRWtVY874B?=
 =?us-ascii?Q?FyVrpxdDY2WQTqMwloYOr3oaqxGkhlRLpV2Hif4s4IvOvbfgG5MehmDALCIM?=
 =?us-ascii?Q?4MWEts6PP6Zh7/D9WOK+SJ/Xz6YjxDTqaKexQnJs/Z10C4wFbUMyv/0pE585?=
 =?us-ascii?Q?RAWQpBnvxw1DZ30onkbGX/4UADt6DIbNncf4olblb0zCY4y2aulBs9WO0XmV?=
 =?us-ascii?Q?sXuVpB3jPuLFWvO+0Z2qvvt0aRVtnn2qNzHJNtajA8ZlZjXWoWIZvIFAWfo1?=
 =?us-ascii?Q?kcgl27ELACVZfEjWDD+pkswfhPzUu/iTHQxylVLmcQkGXu9LYI7O1Llxt/is?=
 =?us-ascii?Q?RWl2hI6BR3o24yybBUiXKnXnmyTmn/e+Xc1VIj9Tm8ihYNDjFCmdX242C+zx?=
 =?us-ascii?Q?a2yIdKyTlesQucoRkS7KZxfXbtQ6koaWLkSdrJU/gZOcZ6NToBMHoxMgjLZg?=
 =?us-ascii?Q?JQMLkDPmtTjfYMpFmk0JLM0l13taYjjHU6AH8Rz7NHXwgk1D8dylua9ljKpy?=
 =?us-ascii?Q?TfSIjnD0VpBfiQv5tt5ajG3tB//qby7Og7h60qwZht9WQHa3qFpwJP+Fat2Q?=
 =?us-ascii?Q?zmA5McooHeQXwv9NoOzj/xsGCXcMUE0jJiXak9Sd2OxcSKjCM7xDcO85j0gQ?=
 =?us-ascii?Q?JsiA+kJnUbi7p3r5sGhk5vx/FuwU6GshfdrlLJUAaF21MnbmdvNsxCK6xg0T?=
 =?us-ascii?Q?hsC/5n/2EvwazF0L2uEpiYT7t20+0OYZ5etgeJDy8LIfIrDB/ggb2PyMN/d9?=
 =?us-ascii?Q?h1XkQwAGfF8SXNyGHixd8+UNNKuCkIeH4NhlX/AgKKrb42Lymh+fVZgYt6Zi?=
 =?us-ascii?Q?8stvZB3rYCaLV+yA5ESepZxKbfXifCWO/MW0Tw6c3ltPACQP7ENJjgkJVd+2?=
 =?us-ascii?Q?HcS/gPKRYm9pC1wi4YmvijvnFX+V1dqDQaO5jj/w7mv25uFAKLyQvNzVZ/4s?=
 =?us-ascii?Q?bgtpcM6nrvhFZniHhQFOuVblVyVomQjxJJNt/AJ0LsQoQTg0U/NNhHmiMFbW?=
 =?us-ascii?Q?tMuVTmu/LFF3WOXFCPW0gqJCQsH1ym6rXsAdWcEu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d37dc98a-8191-44f4-a93d-08dd13010373
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 18:42:03.2656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYvAl90R6gpjA/9pV+g+o7k6bhzTO30k3vOY0qivDomEHIbV0YIFPo4Qpmh95KvEzlxzrYJYr75LK1VEZBmp6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5795
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> Add support in GHES to detect and process CXL CPER Protocol errors, as
> defined in UEFI v2.10, section N.2.13.
> 
> Define struct cxl_cper_prot_err_work_data to cache CXL protocol error
> information, including RAS capabilities and severity, for further
> handling.
> 
> These cached CXL CPER records will later be processed by workqueues
> within the CXL subsystem.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/acpi/apei/ghes.c | 52 ++++++++++++++++++++++++++++++++++++++++
>  include/cxl/event.h      |  6 +++++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 62ffe6eb5503..6cd9d5375d7c 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -676,6 +676,54 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>  	schedule_work(&entry->work);
>  }
>  
> +static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> +				   int severity)
> +{
> +	struct cxl_cper_prot_err_work_data wd;
> +	u8 *dvsec_start, *cap_start;
> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
> +		pr_err_ratelimited("CXL CPER invalid agent type\n");
> +		return;
> +	}
> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
> +		pr_err_ratelimited("CXL CPER invalid protocol error log\n");
> +		return;
> +	}
> +
> +	if (prot_err->err_len != sizeof(struct cxl_ras_capability_regs)) {
> +		pr_err_ratelimited("CXL CPER invalid RAS Cap size (%u)\n",
> +				   prot_err->err_len);
> +		return;
> +	}
> +
> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
> +		pr_warn(FW_WARN "CXL CPER no device serial number\n");
> +
> +	switch (prot_err->agent_type) {
> +	case RCD:
> +	case DEVICE:
> +	case LD:
> +	case FMLD:
> +	case RP:
> +	case DSP:
> +	case USP:
> +		memcpy(&wd.prot_err, prot_err, sizeof(wd.prot_err));
> +
> +		dvsec_start = (u8 *)(prot_err + 1);
> +		cap_start = dvsec_start + prot_err->dvsec_len;
> +
> +		wd.ras_cap = *(struct cxl_ras_capability_regs *)cap_start;

Why not memcpy()?

Ira

[snip]

