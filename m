Return-Path: <linux-efi+bounces-2755-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9256A29CF8
	for <lists+linux-efi@lfdr.de>; Wed,  5 Feb 2025 23:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC10188460E
	for <lists+linux-efi@lfdr.de>; Wed,  5 Feb 2025 22:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E056821A453;
	Wed,  5 Feb 2025 22:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DD15rUK4"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031E921772B;
	Wed,  5 Feb 2025 22:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738796322; cv=fail; b=Jzzh0YsU0wA+/12qeelmNWI9F/owqZBghhguACpHXUBjXH3I5OQGKP+A96r8ZnkG8UjVm5bvjc2YeJ9tmoDZR+Qm/R/9hQeFNS4QiBv3V0Nfhe9lrnriTMVMIqqMC15btdS/D4NzNCA075M7QM/YTl+NoJcW6GW3ygO4hpvGOT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738796322; c=relaxed/simple;
	bh=au7Asywiay+6QHdqts0aNZ17/lJ2WGYWjTnMJTCJq1o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hqObg3o1Es7z2UjH1/3+JvTEkBNUFSQIS6MD6FsT2oqVJuD32TCZhi3f7lXJKXdK6I58dMb3BGPJ9+V7tLeUGCcDo2SUa94Fshl5gOMMOSDhnFmfHDvRyUXFV6Pu0LpRDTsReWatY+JmI3KfhIKPatBDjCiyBW2d1q6vo1yhqjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DD15rUK4; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738796321; x=1770332321;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=au7Asywiay+6QHdqts0aNZ17/lJ2WGYWjTnMJTCJq1o=;
  b=DD15rUK4fc9y1CvZknkjFOaEJMGswiiaAV1xidtGNDSEaDLuFBwzhFj5
   Baq1hozhtBjBJQk/qpZTHZ0VXmryP7Kbuk0JfcqH6J6Kz1pWfzzqbUDuj
   WJzRYS2nnUu3+BRef5In2lio6zuqeU+r00UfWsRCgtmc3hxNkoZBopVLW
   bL0Qt7kU1FsOuQTHoBnY0UY6VaU4Bn+kXc35yEcWeEF4vkiS/Lka1tYoW
   SAJRoZRRENUy0ac4Kid41OuPVQyqworDfJLT012cXvzEXSqtHsLumdj/N
   MHgZirtv/hwJHLeUh/rLKZYdXP0kKbQv9TO3kOMOdPGh6xcqrDSe/eTPg
   g==;
X-CSE-ConnectionGUID: pww2LFU9QISd+qrGQZLEXQ==
X-CSE-MsgGUID: 7knKCau3QSqCe5HxYh4Q7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="64738978"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="64738978"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 14:58:39 -0800
X-CSE-ConnectionGUID: KE3HjlWMR4+UejrNCbPTkw==
X-CSE-MsgGUID: YTEFyRyIR+Wy5NatD51jVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="116036057"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 14:58:39 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 14:58:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 14:58:38 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 14:58:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJY/ySEvXrBZQwYh0hCyx8wFMOeZJsmd4DMDZb+rYZvhgrsYTpfU+P1MFIPBLschB0FI5lr4eAFwmzQ4jemj3WYSP8evYUCiQrGzuFwnqVyHiRpMvm/8xn4Ku4HLWz7LJlvQR/tikoGLAZvxMbF39aGyCfKKU1QPIQNKJXkXW16Ams0dK5OMZkfnJGjXPze6RYlL032B7ftWcx68snKnbh4+PI+Fw9D4a8hJztWrmvaJTCY0zQQBreSGAfXuJT6Xp7cGQ8jjQCnvKolgYHIfOOrdPCCe/LCBmngTn/IfZkStZO46uYsXBgYFTtr/ocUu+MnBogStFnBm41c4MA6lmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5Gqklw3jrnbDFBgWuPLt18Cbr/BtuxJOiJcV35xitA=;
 b=MyJp692z07kdyaLflbvKIfmFvF60fy4MSzg3RYK5gFXtMgX7YGkcrrwspnAHBZheA9XGq06juZpX4VAJRnQES5DXsRS0SeaaQZiFWLbm/G1wi587rNXRS/LzRN+XeHY4Cl/3HxZzGGoFnQFWwHd2XL0uWa4wYyxOw7PKg9VKCdnLRNNljwgIvIMgOYjGCJbbgqoBNo8rBQr736av/wTxjYcbucr5gQLidakWK1wZJ/N369c+fUmSvd0wQoAVkHIBQAHf8ptp/W9YZ6I/hqPa9jdPwRoUAlKaAh0yEPlFoxixHvb2pMhfCVDQS76OOEK1zDP2BuGgf0VjRlgi3wn1dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4936.namprd11.prod.outlook.com (2603:10b6:510:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 22:58:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 22:58:36 +0000
Date: Wed, 5 Feb 2025 14:58:33 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v6 5/6] acpi/ghes, cxl/pci: Process CXL CPER Protocol
 Errors
Message-ID: <67a3ed1947d5b_2d2c294a9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-6-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250123084421.127697-6-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4PR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:303:8d::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b81ee2-f542-41a5-a8b5-08dd46389f2d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cQM2dcK314SvzZncamv82gfwvrtc86InSFYSvKW2T4xoms0X2gx6na2vwlCQ?=
 =?us-ascii?Q?36MepR8roilVmQ7lSwt87KTOezN9mzMB4lKeBJk6LfqxxQ3gfU0Zc8/dIMbJ?=
 =?us-ascii?Q?qZdlx+nYWX//Fe7n0LUdndi+ePC8MVTj6dq6F0+nj8puJzlV4nt3sgO6n40H?=
 =?us-ascii?Q?ltEc0MA9ryVoeRCilArgEouKDWyfWWKV6vNQVvfwGUsUdZFfa2kx/670UO1p?=
 =?us-ascii?Q?NtJa23u1V8XSfpxPr69kwsAhfyTJfdflWfOU9H3qvaqE2BXUEJHXQZThORmn?=
 =?us-ascii?Q?xBh4eLP88uUMuYNwlFpVET42RmVH8cPffgUl/4sTmsjOpeJxH2C9njaASKTs?=
 =?us-ascii?Q?75eXCw3EvuJ3h9I7zkLusU6SvO113H1Z16+HegMMld/rNZE8Qs+CErGYVG7W?=
 =?us-ascii?Q?O0TLpGnvd+swNhymxPZfeh9WsD8ubXoVkSGYtBNJmpruOQhBd0YKqZTnTWYF?=
 =?us-ascii?Q?uLVyHmbFRgTGg7LNpe7B0omj/fW6JRHUX2Rj8hd0dUP44KeTKVtC9iiBO/Q5?=
 =?us-ascii?Q?rrEcoGwJkujjs/e8pyQJYQRppD05Kf4RIgZB5f1KUQhWOgEhvaLG12XPOHtj?=
 =?us-ascii?Q?E/Hpn8VqQcOOtO3RC67ObMrcZ2pzTW22bR+HApA+3aTyZGeuwvrC00YTLArK?=
 =?us-ascii?Q?2pDDL+z4YZuL58yReBVdPN2vUcT+/pG7kArnfnQ7OVwHAqCPCYpOGrnIaDy9?=
 =?us-ascii?Q?ZMeKCpJ7SRChcA1Fy6sEK4kfHGOiNWS12XoQNyoAydYh8C/TAwiqpCwn4Vz8?=
 =?us-ascii?Q?H/DfdSyZL1J73BxtnRfvAWkZjWyGc933cd6caY6gWHK37sOTB93zJzxvyMBY?=
 =?us-ascii?Q?pu399zifz/zVM4wYhcRWvZsOzPjqyiMKSdg//XATPvHu+vlnpAV8Qgyr+INZ?=
 =?us-ascii?Q?EPKZQUCpN+ckJe/CC4fs1Di/mwlcw+G9HBQNJpBMfZ6cApOe7TFHWuWaD0Uu?=
 =?us-ascii?Q?/J4cKlo7bI72/rpu/JQ3M32V0vCh5qc5X6B/7hLxhauvHtV4kqRQ/eTpm0oZ?=
 =?us-ascii?Q?XJdOY5yj/5K4EMX2EB9wXqkC/PcQAqOBGXJyNMeSXKhdutTa6m3oVCD4zWiC?=
 =?us-ascii?Q?QDUHots2JG52p0ShmBd6g1BkibCsbHzZG95QWumVuYjRypLR2jaaCr6urfTf?=
 =?us-ascii?Q?QznZTg3n8L8kRz7qJ3ew4/mkBUQrEwc2GhK+kVXB7E6AzRUDDWV1t+Dugk+w?=
 =?us-ascii?Q?GsR3Zbbp8h06KWCougujAUzE7a55tW5J1922skYcDtvWOYJte1sSQqZOqpuA?=
 =?us-ascii?Q?rmlkrN/JAP6d9bjbtEOa1LBlh5APPSTOqy/b4f+pjQqTPGsi+R1+EXZ1qhKJ?=
 =?us-ascii?Q?eLHJz+NDAO17NvNpXTzSNcF+9DbIydeSB4ecqX9r1Scg0jOXWxZCZ33GWVOz?=
 =?us-ascii?Q?9ID89LEu8WBhDQBZGauKU2oKmUhi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M8aU0BXyMJGeMzmnxYhk7cm2mlwD4pgWUFfpxJCuX3co37+nSudT7KQnVghI?=
 =?us-ascii?Q?n+DEfx/Hx/oXJTjJ7/9QtpOhqZjXn2YCg1OwOxhFLItfJsD0USRm6lwBiqLf?=
 =?us-ascii?Q?Pt8x97JfQCSHPh4WBBc2Z1bp48eIPebd2cLZ976TGqV+kEVhLFIuh9CqyJwD?=
 =?us-ascii?Q?Am16a30HfGpp1HCR8YXJWQGD4ZqS7jj9aNMEhFFmVDhInO5avR3HGUXDRqZK?=
 =?us-ascii?Q?I2rkIgcJAhTX0YxVLbQz0OM4WC+vZ6Dj9kcCrOl2WC8hZtSrCBUfDOBhX0xF?=
 =?us-ascii?Q?d/sIe0xQT5eMp6vzPDt70DLAMfQL/7xGPiHQAmokqnltzFfzHKtU/pzrDMuW?=
 =?us-ascii?Q?LFowsyZI7XPzU8U+poLkzKsnICbbWEGtGcTMgk4msB7DOPIXz0aI/AckDqAH?=
 =?us-ascii?Q?8h918bDtR8d/pHqRM8xYxs2PND5BNvWJp3xWZGoHV1CNQ1jGuuZPffQrSO7J?=
 =?us-ascii?Q?hhzNQoCgjZSb+GKTPY0C2pEZPD4x3iiMkRaJI44TakPJ6/PNDRWQ7qj8v6/z?=
 =?us-ascii?Q?p6g1j/OxJUO0d8Te/kgvTq2kdX2YCxOgdef4M7vgyVk6O4OZ2GMJBWWbusfl?=
 =?us-ascii?Q?n2nEZKfY5wxD8XwruPDJPAgOjAOET+UXdh9MFDWFa0aXGWH5tVyIbzkztTeb?=
 =?us-ascii?Q?QOk7C9v9+G5QyoFBLTpVIqUz9K4aHMP5tJuhE2zW2S3Gktb6YlmB+DHaPF+l?=
 =?us-ascii?Q?wni0Tm0SH4MUSM8rG/lFTsI3P/Xeq5WDNaj+VgWjofEENqF8xLS/LpXMh8Mp?=
 =?us-ascii?Q?ce/QOxahBkcYN6NUmKdVY2ZG1jNvLuUtr/JI9M7+SxVUG2rg1/jdxdNjbBKO?=
 =?us-ascii?Q?dmpwmoiLZVG8TXyUcHwjPqWwBvGkYJUB79EIDQncWYSjiJO3oe8MEJ/MLv2E?=
 =?us-ascii?Q?PGPK0E17T4S+jOsFyCu0A8YTOo9vmgvkcIGOSB7LsrL8kXL44zljaWoJfXP4?=
 =?us-ascii?Q?feX8ZJ4RzZJncAtBL/7cT7iC5tiiMeaRN1fMJrqyBCpo8CbqhI2wN29uL4vu?=
 =?us-ascii?Q?GdknLofqSZgstt2eNjZkzF3by1Mr/ILl9YfAiU+Xwz5n3cMhyCHfnuqvtYQ2?=
 =?us-ascii?Q?Vwa3zUljJf2spLueEohe+XbFGzqFpUOHooOs9KGddh129s/YKMVqqMoyvC3M?=
 =?us-ascii?Q?670Cktt1b/EICy0QiAeSMGvbjJeTKLIKrEBjlH923WgkWXOChwL3Yc54dj4V?=
 =?us-ascii?Q?QcyMQpQlKyozWQLpYhCTe4Vrsho3hKSGftmk4qzXqj7nuSBWYZzFJZMFnin9?=
 =?us-ascii?Q?kiBeoicPehhBi9sbAZPTo5n4M1HqXx+Lw/u0nd/Ib+FKwetA2nnbiFLWvhf4?=
 =?us-ascii?Q?lTxgWnDMYOfC99r3mk2njNdVZKfxKZ/9I45ThcDtCokC16yXJQ1xCHHAzSx0?=
 =?us-ascii?Q?lGZo8kdHPr5SyeyOexw7npokzFp969ICP3SemSnETNERuw8vJnKp2/A2vbCt?=
 =?us-ascii?Q?McCgj2548bE3Eh8/+idN/HdwXKUiI7xG2M3liBrE05U0AH7wzAAtk6SloB6R?=
 =?us-ascii?Q?6rserdrFU4APEwGPAy/6HRHzW5MCFHxDssPw09YBF2pZcrLVc6o5Qc5Vi2JS?=
 =?us-ascii?Q?jbO+SvaUhegw03BA4wbp2vzWGgRuU9nsjbyjErJUdtR51YYHulBpjuON0cc+?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b81ee2-f542-41a5-a8b5-08dd46389f2d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 22:58:36.0806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKpSEVCBpeFpXwGLkWPWigVlAg0melw3JG0314juPbnMw+rAoh6hM9kQBfLDsVhkmGoZ+69EcIP645zNTVrt+gJrgKh2H3gjz11PEpdBwg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4936
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
> CPER records. Introduce support for handling and logging CXL Protocol
> errors.
> 
> The defined trace events cxl_aer_uncorrectable_error and
> cxl_aer_correctable_error trace native CXL AER endpoint errors. Reuse them
> to trace FW-First Protocol errors.
> 
> Since the CXL code is required to be called from process context and
> GHES is in interrupt context, use workqueues for processing.
> 
> Similar to CXL CPER event handling, use kfifo to handle errors as it
> simplifies queue processing by providing lock free fifo operations.
> 
> Add the ability for the CXL sub-system to register a workqueue to
> process CXL CPER protocol errors.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> ---

This patch confuses me. The plumbing to route CXL component error
records back to the cxl_pci driver was motivated by the driver having a
significant amount of context about component state and code to handle
OS first reporting of component errors from the device mailbox.

Protocol errors are different. They implicate various ports where the
cxl_pci driver may not have any additional information to add.

I feel like this patch makes more sense after CXL protocol errors become
a first class citizen in the core, and that generic CXL protocol error
tracing lives in the core, not a cxl_pci driver callback.

So, similar to how aer_recover_queue() traces all PCIe protocol errors
and optionally lets endpoint drivers recover the link via
pcie_do_recovery(), a cxl_recover_queue() is needed. That would be the
place to land general CXL protocol error prints and optionally call back
into drivers to add more device specific color if necessary.

I am ok with the CXL core centralizing all protocol error processing
like the built-in PCI core, but the generic CXL memory expander driver,
cxl_pci, is the wrong place to handle system wide protocol errors across
all device types.

I expect this is new infrastructure that we will get from Terry's
patches, but please do challenge me if you think I am missing something.

