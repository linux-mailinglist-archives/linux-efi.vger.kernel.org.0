Return-Path: <linux-efi+bounces-2249-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82D29E0B4C
	for <lists+linux-efi@lfdr.de>; Mon,  2 Dec 2024 19:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98BAC282AEC
	for <lists+linux-efi@lfdr.de>; Mon,  2 Dec 2024 18:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FA11DE2AD;
	Mon,  2 Dec 2024 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FutWxi4O"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8993F1DE2AB;
	Mon,  2 Dec 2024 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733165331; cv=fail; b=QeaPzeVuB3+LkKDeffZ9KAPeZRS7GiJnI1tZNukKL3oDF6An2yTf7F0eXvcl6382LobSzxOaA8+l6vKm3SZBjM1xhV0zfte2hfQvX+iKJsKLL3YkLvgDr+d2rwWfIJPjR9zYnNfl7ji6fsp0mIdHD3PzTHeU9/dVUT+nTY7b+xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733165331; c=relaxed/simple;
	bh=g4lkCXQdDq1eIu88rwzh378KrfG1wOYZ7GXPLpsL9PQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xj8j3xKyg7gq0P7BvT9+9stMbDtcmxwgNYduMx+ehrhhZRfwA+U7zUV040weKOssZiInB3CTjSpPCht4yarFZCej2MRIPQCGR7Ps8J2cEyQGp4z7Vh7d2MV1jCgOZ1HcsbegyGj++ydxiLJOHAfsm/rlbVqCNb7stvLsMYiSIxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FutWxi4O; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733165329; x=1764701329;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=g4lkCXQdDq1eIu88rwzh378KrfG1wOYZ7GXPLpsL9PQ=;
  b=FutWxi4O93gTM6y1UFYpeoe4Hig/SAm9d5/lhvRn9JPcC0kORshg+F3U
   HLJR9sVZhhUk20KEEhof1FpYg3tqEZgdyOP6D3kVbMH7oWc8koJx+9+vA
   ZQF1oGLkBmt0Lk1rYsE6e2NRcZcoBYzPBYSEcuKln2m1sKlAGi0dzDuAW
   E24BqZ7EEYx6/P3Uny2wBjUUvbGK6i3nWYuw5ENqwk9KPWno5w9B0ScY/
   YDsX3klFqaoYfvcweGy87KpUnSaifyiSUIo4xn41ls0elFMpGLphP4rzh
   AvNqgzBuXImkc+E2Qicv4E67PFFLJWA6sGn4+tnamZfILtm7zUXR3ip8c
   A==;
X-CSE-ConnectionGUID: hQomrVP9Sja1jB6RFJ9b6g==
X-CSE-MsgGUID: WkU8s1mlS3iJQLEpal9ovw==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="32701194"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="32701194"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 10:48:49 -0800
X-CSE-ConnectionGUID: lBldKPLGRxyx++f2CLTJ2A==
X-CSE-MsgGUID: GXwzJasqQjGHc495gQTXTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="93365704"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 10:48:49 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 10:48:48 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 10:48:48 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 10:48:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0m3Dz92a9iFok1iRnHQ2CEVMnlfb41QWugxINrcX7PK/SEZ4YLLdFlFmc5HPQBcRaB6TUkayPj4QurYl0A0SfsjcPbkGUths48iMi1+JAu3Xe10S2Sj/1tpdqhly9YBhh6DuSbDFbKUOKO3KEKl1yPjI8C4FMZVuknOBnZRnvmol7MSefQFvvK+s6RkX+qUjYLaKmI1t4+AIiebElKsMMDRWCCRjeCL26P02J2ayxEUE0GGfkmxEb9eB8k2/TObNr4gp9bgUXlAnxxO7/cc6/kindqpCViaAn5Ovt26v5nPsm6l9+tXLFze+I2daH0HV+uY+xFqClb8XVyMaz+dAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAiH2WOJ8SognvTDBBLAg/D5bgXYOreFRhLpu3zTwZI=;
 b=vQPnBTx4w3sURaEIp4DDg8BTdpeCEmnEGdki/ZkoR1/GI/5wO2D6TgOAE8R8oPzO1X2Lneqhjvf7ErMBGfvPRv08YteoocCG5imm/CDFrOQN3emNTfTggcdifg6xN1mZNPdAivFtmQBEqSCknMEQSyiWhCdh08DxLCoOHlv9z1sa/7ROpr0k19tTJwrsMm15gAXpe2FcNkZ97Tzx+BqWIz/Y98BHu06SxeEfG7bGMUpkuS68ZM0lfrNKr+H8QfH6lGXPV1btp/hBZ8+i1Mk0wVingTu7yCOca9odoxlLTBzZhDUxfSisqQQ3ta5yyeBpydXPDAK/JU/DYU0er8QcGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN6PR11MB8194.namprd11.prod.outlook.com (2603:10b6:208:477::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 18:48:40 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.8207.010; Mon, 2 Dec 2024
 18:48:39 +0000
Date: Mon, 2 Dec 2024 12:48:35 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
CC: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, "Terry
 Bowman" <terry.bowman@amd.com>
Subject: Re: [PATCH v3 7/7] acpi/ghes, cxl/pci: Process CXL CPER Protocol
 Errors
Message-ID: <674e01034ca7a_3cb8e0294b0@iweiny-mobl.notmuch>
References: <20241119003915.174386-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241119003915.174386-8-Smita.KoralahalliChannabasappa@amd.com>
 <20241126160527.00005c2d@huawei.com>
 <ac098bd3-f7dd-ca57-8010-13e843d9f1d0@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ac098bd3-f7dd-ca57-8010-13e843d9f1d0@amd.com>
X-ClientProxiedBy: MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::11) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN6PR11MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 043dc1c6-fd78-4323-076b-08dd1301efde
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zq6iPNyxQ+jM3vbqbxR0cGN7vSvFy4UTCREmDdJ2T+NDspj8wQFiPwmlFrss?=
 =?us-ascii?Q?SpYBJNnUOsiv1FUuZcZMlb0J0j6thBIrnED/k3Ki+hxjC3+5d5xOrMJ+7epZ?=
 =?us-ascii?Q?FMUT0ZmSe8/2JvOVMsUNP27xBZCelaBaBQKbhfN3gx7i7m4WN4dWtqSU03SM?=
 =?us-ascii?Q?qz7gWAYAtNRUW4n2CMqg+IbgEgqMQ/F+H8xeyQ7hzboM3dHaqPAvbyrBGCVW?=
 =?us-ascii?Q?TgVrS+Zyf7NtLaROBeopiML1s6wz/XdMp+muaSYcMQJVTNNd+UYnAI/ZUrmj?=
 =?us-ascii?Q?ofmUrTXJMGT6UQ84fJ6gyrBGxsNzeWSf3pZrSSdXNHeQkzIH+XM0nZ/hU8L4?=
 =?us-ascii?Q?e7jxUboPWreylO89ZhvNtbTuk8Ek1r547E7nYk0DLOfZylD+4cDJasMKt5+z?=
 =?us-ascii?Q?TR/ZHHBWuO8cUIiQSM0onUGaAR9IkFmq9KL1oL5wm/gG/TlrBcI58Sl+jax2?=
 =?us-ascii?Q?0vJU1W8orPnqsLI/KoSOCwteluCdDRE1Sz/b8pqzm6Accn0KGefYUr8q6IhF?=
 =?us-ascii?Q?sW6NVOTDkkDBbXZS0IESwFcGLhsCGGSXfCilFC5ID18aiGIlqMjQqezd6Dae?=
 =?us-ascii?Q?yctOrK+CGjWqG7tv/eCX+z6ukAoHb1f+NDTXWj59IpuSzVZw9gNNx7NdiI+w?=
 =?us-ascii?Q?iVd/dQYmQnpZCiViqgsn4vXPjlMMLWxk2bkp+68o3Dc8LehNxZO95GJVVzg7?=
 =?us-ascii?Q?nsbqk2gb/vjj3DdsCgOndaWe1oDbl6AJ3vIKcxYY6vaAPhvoO/7/6fV4HRSY?=
 =?us-ascii?Q?oFuLUfYeE1hrhgE+IJnzke3PhwfGsYNu72x0SnbJBlYxCsV62JmE0F881Hwe?=
 =?us-ascii?Q?jUffQoIEJjzGRZ3PASsZc3VDaI9/plPapAPfpIPNxGqDtxDTIia3RLQMPF08?=
 =?us-ascii?Q?sWU4nzrfqHS43bfvHC5mxm9zx/Ub8Vu4W6Y/Bw1i0ETFvTWVLBezG20Mz3Bu?=
 =?us-ascii?Q?TXL3UvlfGh/tNn9BZZsvkWW61VbKqUhkJ2UMGrYAPR+LM1AyxYJnUijhYY3U?=
 =?us-ascii?Q?h+0EqhuP46L4FtixmkwvL/Uh7ZxULYhqkdxzDC0qdaiceI10Le2joSCwh3Br?=
 =?us-ascii?Q?rfXjxinDwy/frpbtw41UtXP0SgMyg1WB3B4eD89aTQ3M7wvfG6CrhpGJ9n0w?=
 =?us-ascii?Q?J2bJUK80F0JyUSyOrJrKP4vfdlcq+9uCB2pt94qZKulIl0G7R3cA3zA/VSQG?=
 =?us-ascii?Q?pjxbP4zV3KkLMxAc1hgPq8JEoumjkDLXali5iEh0EesVAxeIbVFXbR4/U6JY?=
 =?us-ascii?Q?OVOOluQ53MHoZU4Mn6jhkvl1bW8pwiYy7ylAc+Y0Ono2Ko+6Mx8HZbwS/KkH?=
 =?us-ascii?Q?pd6/iFoNenyZWv5dLnfjEFkFUL9HBoQiEqDMZ0+/Zsp5hw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lySke7E43FkdC3jQD8RI1VtZ5gGzK9KdQPUiG7amHXVt2Zod1MoJ/qTJtpqm?=
 =?us-ascii?Q?C7dVSNK0UhfL1I80HfHV3FtPhp61xB6cHwWv41H5Re5jGzFLTYXqDVCyweMs?=
 =?us-ascii?Q?dv22tAm0Ak5kttxluq+WId/IGiNy8YS1JtrsgUCnj7VJ0CyGOoVz9kYSLi02?=
 =?us-ascii?Q?PuDdRapt+7QSBFfAmlYNcGPxdQS6uCYAGO7S2dUZlb1m+njtUoMefOOz4ctX?=
 =?us-ascii?Q?IVGhIodV3JAwtAf5WOOh/DgxXvLWWnqNgolFc7XNQzgrtjTxsmJusJ8ct9ah?=
 =?us-ascii?Q?xgZbkWnQ7HA1Jp5GeWWeiaXEs79NOJhi5gJBmWHPCN7beihWVeF0tBxucHBh?=
 =?us-ascii?Q?n73+RrXlv/CiAwW/3X2puMIUL8wQj4K5GeMqXFS1GzhrnZAJIqSzu8xPa+VZ?=
 =?us-ascii?Q?2QfZvF7ojNfpnSH8Y5oBbsc2mGJg7OY0tgtZHbcheG/gbL20hHu6I4MIauQV?=
 =?us-ascii?Q?bpKamibUiDS2JWruEFzoHTd3peUS9I0NzR8FHzOpF79+X4wPX0tZ+wLRMr8l?=
 =?us-ascii?Q?UAcObm9NG4u8X43RLnvw3RESTBiUd0GE44x2NN/5PEkh0lpSa1W5qEUotoB9?=
 =?us-ascii?Q?CkxfrDFxlcIPGl7dKxerNRyJiOZx9/PIZjnq/EOMLZ7wSKLSkTz40AF2H7XR?=
 =?us-ascii?Q?8bn377FB/Q0shDwaCT78I/1GSSot0HGfEF3xzHse2S8dnIKhNg3SFK5ddf8K?=
 =?us-ascii?Q?b5bEvx0MR5/tTsYQKPoaeSSL2QFE4fqJhzp7JX7vQBrHMrVPv+LBy670Adf9?=
 =?us-ascii?Q?LHXEJBcVcgWobc/sk+i8ATl3Cg3by2cpVSM8wlkT/GElT6Iic7np6s8MsczA?=
 =?us-ascii?Q?7gOqBrwYwtPx0JD9S+K58czoQyKA3JnKbNd7WY08H7ehUjFWWoVKAoMxvElS?=
 =?us-ascii?Q?8+ZosamgzA1LOjndJx8cA/HVb5Nwrp5De2LOrTlg3F52GeG/DAImTh8qbNz0?=
 =?us-ascii?Q?oDivqDx5SlpkCs7fInTCYYLt83T1bZ8eLqMznXdF0JvpAa77HHedtcRSei/e?=
 =?us-ascii?Q?Mo1rzkxZLJ4C1EKFnBo5mIGXEBwP6pW5udDiGuU1zfT2rVTk29ID3ZZpFNVR?=
 =?us-ascii?Q?pLEtQgkctnQVg5KvK2IEeU9uTczXy7Ws+zslu6MdzF/WnC2KX+PZ//0x9/1W?=
 =?us-ascii?Q?dM+E9MsepOhn3CvYNS2e/KgFA7WnEIEOA/sNVTfzaDYLO3xgtQc2+eG8wc5Y?=
 =?us-ascii?Q?byaA3M9lygtNPvEPWFnu6vVNm5Ao0WWUXzoR3I2LtstC3hExV94J4/jvvwB5?=
 =?us-ascii?Q?J1FDe2Dng7+5HE7FM/ZrezzLFHVzBuxmVUEgS33dDaxKoa2rrfl07ER2JCyG?=
 =?us-ascii?Q?CYVPF7Q2mV2hi8PhnVER2Kr7HRy110iongvy3yxTHmNmsGZQOIxoIQQgOOFc?=
 =?us-ascii?Q?LPi4AXhUVOt4RUhxGkg0Wc9Qub+a0WjN1kl+p3pNdGauTQRDdLeM+GBXVoAs?=
 =?us-ascii?Q?HplaQha1Zl+mvAkPdLe1AIPtKKNMWrqc4AZ3D6yqfRCYK3lMBPSWR0wTWWh8?=
 =?us-ascii?Q?KSIfddKfWH3WRGobEtoUCtzmayu9M74zJ90hWVjjRwKtw29OwZDyX9kVnT3L?=
 =?us-ascii?Q?xIxrf53fl3eSv2mQAsN6JBAhIMZgdSVlj3/J2Npq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 043dc1c6-fd78-4323-076b-08dd1301efde
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 18:48:39.8183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cl1hpumPf2XxhTuVj7Z/d/bnpGNJRhLZj4B6PhBtdUt2i2oTrMT1LV/IQry2mAAzF+PcmJoBdspBp1t99DQ8yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8194
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> On 11/26/2024 8:05 AM, Jonathan Cameron wrote:
> > On Tue, 19 Nov 2024 00:39:15 +0000
> > Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:
> > 
> >> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
> >> CPER records. Introduce support for handling and logging CXL Protocol
> >> errors.
> >>
> >> The defined trace events cxl_aer_uncorrectable_error and
> >> cxl_aer_correctable_error trace native CXL AER endpoint errors, while
> >> cxl_cper_trace_corr_prot_err and cxl_cper_trace_uncorr_prot_err
> >> trace native CXL AER port errors. Reuse both sets to trace FW-First
> >> protocol errors.
> >>
> >> Since the CXL code is required to be called from process context and
> >> GHES is in interrupt context, use workqueues for processing.
> >>
> >> Similar to CXL CPER event handling, use kfifo to handle errors as it
> >> simplifies queue processing by providing lock free fifo operations.
> >>
> >> Add the ability for the CXL sub-system to register a workqueue to
> >> process CXL CPER protocol errors.
> >>
> >> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> > 
> > A few minor comments inline.
> > 
> > Thanks
> > 
> > Jonathan
> > 
> >> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> >> index 4ede038a7148..c992b34c290b 100644
> >> --- a/drivers/cxl/core/pci.c
> >> +++ b/drivers/cxl/core/pci.c
> >> @@ -650,6 +650,56 @@ void read_cdat_data(struct cxl_port *port)
> >>   }
> >>   EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> >>   
> >> +void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev, bool flag,
> >> +				  struct cxl_ras_capability_regs ras_cap)
> >> +{
> >> +	struct cxl_dev_state *cxlds;
> >> +	u32 status;
> >> +
> >> +	status = ras_cap.cor_status & ~ras_cap.cor_mask;
> >> +
> >> +	if (!flag) {
> > 
> > As below. Name of flag is not very helpful when reading the code.
> > Perhaps we can rename?
> 
> Okay. May be flag -> is_device_error ?

I had the same question about 'flag'.

> > 
> >> +		trace_cxl_port_aer_correctable_error(&pdev->dev, status);
> >> +		return;
> >> +	}
> >> +
> >> +	cxlds = pci_get_drvdata(pdev);
> >> +	if (!cxlds)
> >> +		return;
> >> +
> >> +	trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_corr_prot_err, CXL);
> >> +
> >> +void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev, bool flag,
> >> +				    struct cxl_ras_capability_regs ras_cap)
> >> +{
> >> +	struct cxl_dev_state *cxlds;
> >> +	u32 status, fe;
> >> +
> >> +	status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
> >> +
> >> +	if (hweight32(status) > 1)
> >> +		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
> >> +				   ras_cap.cap_control));
> >> +	else
> >> +		fe = status;
> >> +
> >> +	if (!flag) {
> > 
> > Why does  a bool named flag indicate it's a port error?
> 
> I will rename it.
> 
> Or may be use an enum to explicitly define the error type 
> (CXL_ERROR_TYPE_DEVICE and CXL_ERROR_TYPE_PORT).
> 
> Or may be split the function into two distinct ones, one for port errors 
> and one for device errors.

I would vote for 2 functions.
Ira

