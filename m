Return-Path: <linux-efi+bounces-1015-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005EA8BAF54
	for <lists+linux-efi@lfdr.de>; Fri,  3 May 2024 17:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 682E41F22F13
	for <lists+linux-efi@lfdr.de>; Fri,  3 May 2024 15:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215EF481B7;
	Fri,  3 May 2024 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CyfQHxL/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317CA46BA0;
	Fri,  3 May 2024 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748442; cv=fail; b=cILcNgU9cvr1tLk3uNlgWXiRxN4IVDqOrg7iOIEtmCbS8GctqaTSAJLnkT84rfULwkjjMO2jAknwCZaJIWp2rFybARCkZUunghHaMuQnDK68WA1dQiNfv92voH2tpuLhzQzlcYRkULNWbw3kjHORbaMmPNR28vWI6yIElog/WUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748442; c=relaxed/simple;
	bh=/H+xcmsYyGUQ4iQbb6s5qb0GRQ13yuK78KzgMWbX7i4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OLk4V8xKoWHsbJh3xl3owVfPOno5GbaoY7BGyljC0PvDvS07VnIYTF+AMClFIO6hDXS/3ItMTcM3asxkGHBp6qojCRYluAkjbTyE+LHOclqvGYxFBRVGweovBndeuC0U1s5Oad6HRdTU3QXQvL6zw/ziU9dapND9jjDz13P0afg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CyfQHxL/; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714748441; x=1746284441;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/H+xcmsYyGUQ4iQbb6s5qb0GRQ13yuK78KzgMWbX7i4=;
  b=CyfQHxL/V3UCr7PeRJAiGBZTOCGDT3klVk2iyfgwHmLq2trXzN8WqdhK
   qQvlhumlKVWRUV0EAKB6kypRd4czK1suoJckHp5swBzk9EqBNfi27sQat
   +NQ2FaMAIz5lh/O3ssPw54gCkOOwOFsk2RkKMv47+kEI/UAQmKNYpG21d
   ex/KkTNHSQe5lqX9sSL2BONXl/N3M/7QyfjnULN1bedznHsw2wkL42C7j
   4M9Tgtealq7LL9w+kEvCWocQEczRfx5a0LxrgjattW33gIphlDzOEy0vo
   1LW3P0+UVYzPbiH7BtR4fZcsC7HnDRfVWwHbrVnpuGu8rWAjIDbu5q8Bs
   Q==;
X-CSE-ConnectionGUID: VyNomXuuSnOiOWv1kyplwQ==
X-CSE-MsgGUID: /HPPHWuDSP25sSLekqiCRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10685815"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="10685815"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 08:00:40 -0700
X-CSE-ConnectionGUID: FpUsqD5JRaW3ocx8YYbHTg==
X-CSE-MsgGUID: uNutJdOiT3iiTeUL6dnDlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="32150256"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 08:00:40 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 08:00:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 08:00:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 08:00:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAHuST9TgjhhLJX1UzLlQqUF5NpVYydEQZqhi6zZQSuW/Y726nf2py2Z7+y+eRqadjHAdlLyKBRMxAUzXNFbgaEvXp8PvupuJ4O7L3zyHAohTaNg21caVUyiA0E1ALs7eBdDiGcc4fC0FV0Aj8w0+Ua4VNSTTbQUUY2PjhMukCCCSLhKBp75dj2/KvuUKciUL16mJy0Frf7TSg4cEVZMWmLmiBlfKzIxhiEIca2f9PhSUQSyUnyHiGdN3yx/5A5nSK5NxvafvPPupdDsItUTcwQS1NePO6Xo10pJ5UQqtcHPUWObTRlOGJ+j6NKNAJ40YnIkHS2Ha/aGC8TW0UQOcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeApb+ITYQSwDRzKu+3Hy0NR3ba5JOGGwN6JHs0OJgQ=;
 b=hkfA2z5b8NZAYNbO/2k1ztXm7UQPWeKm1v9AMm4jigAqi0vBrGde+Cdn15urCM5ibiYUZrf5RygDg80DeXP2c3ciMLbs/n9yUfTwmKxmOuPOumjymnTxEcFSbOc21+adMxVsHiaupHarC6B5lOK410XKM18DoxtKMYH9kNmHT0+PFS0u5ZT8fWY0Lyp2BcKZ6iFEkGDKEB8iu9UnkzvaXPGjc9RxsFyM8NUVhsQsqS4dtbe2y+ggNEScbSqU5G2LHwdVKYt8EeCa4dg4b9tB5wGNlRMHYhw8xm3PfG1OnDp1cKtoySx696Ju+givpyQpaBcdJ2gWNpZEeJB5vgAZxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DM4PR11MB8203.namprd11.prod.outlook.com (2603:10b6:8:187::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.35; Fri, 3 May 2024 15:00:34 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 15:00:28 +0000
Date: Fri, 3 May 2024 23:00:18 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
CC: Ard Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, Vlastimil Babka
	<vbabka@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>, Chao Gao
	<chao.gao@intel.com>, <linux-kernel@vger.kernel.org>, "Hossain, Md Iqbal"
	<md.iqbal.hossain@intel.com>
Subject: Re: [PATCH v2] efi/unaccepted: touch soft lockup during memory accept
Message-ID: <ZjT8Agb5vUNUxuVo@chenyu5-mobl2>
References: <20240411004907.649394-1-yu.c.chen@intel.com>
 <ZiZ2yUI09QIrYr/4@chenyu5-mobl2>
 <CAMj1kXGdRkiLh+3DePZuejaqEphyP=gN6bnK6v08ueP3MP40EA@mail.gmail.com>
 <CAMj1kXHLGMXtD-Ad_1TKPmkrvppeNNtKUn-G5q4jr8ZKOab18Q@mail.gmail.com>
 <53exjhamp57x7brn2b5jxdpbzc3amv5i646gmgitnvwjgdwfrd@5v5qifom5tez>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <53exjhamp57x7brn2b5jxdpbzc3amv5i646gmgitnvwjgdwfrd@5v5qifom5tez>
X-ClientProxiedBy: SGAP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::18)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DM4PR11MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: 562c0bf2-1c3d-4f3c-c192-08dc6b81c54e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?THueSNnIK7oqYkVs9YDx5a2cM5EbH/8wpxcnzA8mnZ4NHD6cWUTu9qPIvT4+?=
 =?us-ascii?Q?fZ0/amoeEaerxVMMblEOCuyWZndfn4h5qUe6P2LOEX67YEdTgCFKk7R0N14y?=
 =?us-ascii?Q?rUH8iRu3HtO/xqlAcQ/zss2is7Zn1No8/QKgkN1a5enBp7q9y6zgZG+ldsov?=
 =?us-ascii?Q?i1Lc2oizzfBaiFh2RyFkX64Hz/q4iUosZqiRx7ttnXyIyWCOtuDscJ8wta6/?=
 =?us-ascii?Q?3bDfg0KVWuD58MaJ5/3CiORpFok7DIfJj9x86vcFxSIzu/xevtbbUwslu+9f?=
 =?us-ascii?Q?sR4+cIqDodewrnd9F1JQ4cexNQlgwgKN252EIe2CVd4F5CZhRLGNZ+Msnezi?=
 =?us-ascii?Q?wxIgvEBFzub075eH84r5dxud8PCrIBFHbrgXj5+tMw/yTgSk/O/aOJ8nQG+G?=
 =?us-ascii?Q?FllmloLixdga7dl7pm+vOXg/Uuq08ZR2PltTVeBCu0Y0TGdcLyBQtigMm2xO?=
 =?us-ascii?Q?qsW9mpVlEhq20yTmeHpvJ8nKXMTZbgqB03kv4u9WsNlGJqCchYkMNi4P+IIz?=
 =?us-ascii?Q?I/dDJt3r5VHXqTmMvBdNtk8tlF1FZLtGnj44XPTZcUXtFE1XXRwLTlp5/rrd?=
 =?us-ascii?Q?Cd2Yqgo65kebrUGWY+oT+pCPd+AZwERZLuwD77WBzbs6LmPh1MC/Pwq/Z2DM?=
 =?us-ascii?Q?3RzlGQ7T0iuVGK//f6UK3fak1qnUhfGOKTyqKbN8IXHVVLvQzJI7Pj2Mw1kd?=
 =?us-ascii?Q?znFCjdm50/78KixV2S5ToBK1zMBklcz2AT/sm39dD+levhXB4IQM686MNIkI?=
 =?us-ascii?Q?Akdg5X6KN+RNkQy7grLYevqp+RsPvVfterTShp8cQrR1L3ZvhgEoJEydRsgu?=
 =?us-ascii?Q?nhSX+PaaEBaODo2UDHHv2UOCtloYlInJ03EepitoOlddqsDZ8aTjnoKBETcm?=
 =?us-ascii?Q?ECScNQfdLhfaxFlQzA7goPMYleFDJOKGVV0K0TQbt4LZzbBPkiXt33bVhItp?=
 =?us-ascii?Q?CJn0LdxgFesP61NakZ2S2lALr3ng+rNmy5AlV6TGLd0qA91twhoMWOQ7e2Xm?=
 =?us-ascii?Q?lxlCP3DalgecDgp9Jmf52tvVTiIiXiN3WkQ/GWCLRy2hdpo0T6PJpnKNO6MY?=
 =?us-ascii?Q?luvFgT5lfoPvIDbFCHE5sXqO6ZGpTcbeBlIV3bdTX2Zgqf6tQ5+E8hVwNdhb?=
 =?us-ascii?Q?N87K2ReXCLwp7F5Cd4gDOdJ7L3vV46yRuETMIc4Lna4qCRFUUmcPnMQb9xb5?=
 =?us-ascii?Q?TuiIGDEU3m9dsMnUVIMmIrBrzDskKfzAAmbnUOq1OcRvisaSRie1pncWTJbc?=
 =?us-ascii?Q?brR+24wImMCgW5Ypm9zM43dtsu3T+8eVOyNtZTi0KA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rw+kd1JfWFPAevJ6xkICZk38LupEuz2kdziDs60sIRQ2l5T/dGVqEwzRJ49U?=
 =?us-ascii?Q?ssg0S76Vfgh+R3jGy3qI2kSDQ3eiB8i+xnJC+pMu/+X55IJpA4C1UBAmznsS?=
 =?us-ascii?Q?10LkGAbxQDDfyOUkerPoQFknj+zr8unp+Xpl5hnNeOswwZVJ4skFKtXIC6Hq?=
 =?us-ascii?Q?DnYAGVzZCPbG54vPmvUmijfoBiCpUTlDPhIE2yE1YiqBP/tUgK4Ds1bCvktr?=
 =?us-ascii?Q?CDknQcCaj3II1WQLtXdkh4GiBr+4YMU5bFd7nhXWO1+ehk5mIxyFr9llTW6x?=
 =?us-ascii?Q?Yt2RscuLXOSHSlG30Kbq4chqXBuQmS21ke+N/9IvBeor+xjddDScTvLV3gCD?=
 =?us-ascii?Q?F8jcO+0KAB6NFUw7Kb249kXyu09GyD4UoFK1BIKBA/xW5a+CCaWNag6e6CXi?=
 =?us-ascii?Q?Hn+wQs4xN5iPd8zI515R5lAapHpPeH50RlVkB36lvAx6ADF8Oazj1hLiC4aM?=
 =?us-ascii?Q?TPfDGcLdnd5alaiMC5cfwm51cyCOTCqQL+eWUJiCQ82ExbLG/iQrQ/fdq3st?=
 =?us-ascii?Q?/Ihx8+LcNwf2buQZrmbvtaNjn0wvWHmuEpLf2o7g8x9Yju7KTfNfL/RfExZh?=
 =?us-ascii?Q?j2WYRbBVSOmJdomWl4dCFiR3XrN1dL2vBM98COse0AFIqCCJ54bv7jBxztDX?=
 =?us-ascii?Q?cz+LWPjNSjHMsjxndPcgoXNf/3mVEa8aG4TbFkyLi8AEDqERL1woR/PAbKcK?=
 =?us-ascii?Q?RsbpmNxSAcZTuDOPNG43omElPzkac3trccAV+LBTKintw1j0bHmKVVW4t1oB?=
 =?us-ascii?Q?3JPhanG+eW3CsYbVUSgo6iq27RIqwRF1Q67bMmognHqfac6rbUDQwIKSogFu?=
 =?us-ascii?Q?fDiKaxa0Bx9bsa41Ki8Z/M9LycMTx5QptvND9kIuATJiCHN9meGuBDn0GCD8?=
 =?us-ascii?Q?XsGPSEiSJQmlaaKffmuU+UKNdK+TsXfCEP2KIvTyVg1IJdIPPDlG1Bl3Uoz8?=
 =?us-ascii?Q?M2XtKek8n11uFklQJ+gVPlZlMSDElIUuTfqKChOH0cuXilBws6C2/TTzkhrf?=
 =?us-ascii?Q?AZINL7eluU2sjullQZItc0M5inLMBYMA1Kd6lFGNm6jcL74D2Yw2aPS91glT?=
 =?us-ascii?Q?3IQTCeKzoLFQ9SJIOnRcuPqWymOSu6czcBNcGCNF8BcklpxhEsZ21a7kYkJj?=
 =?us-ascii?Q?oFWBKwd7uISxDCA55fI0ommOxcfIYV+jI8F4BuQfb1NPYKL4ONJ1evtoZDLC?=
 =?us-ascii?Q?ETxHYEgHMSPuoXI3S+aEL0PX1yVSbtmq3ML7KLECnZaqwg61jQpZ0bS0eNlT?=
 =?us-ascii?Q?Jiqb+SLgCjqJ1bKRmCOvmn5gQL+cZz5t2ROKagcQ8eBrrFZJPz5PmPVmOFY8?=
 =?us-ascii?Q?omtuIXD1TSZstmlMptE+hec9Gl36Ge4qzWJcFiTgUdMn8h09NVO0kjh33r+/?=
 =?us-ascii?Q?jf8WnTQ6aQNCqTQHU5TiOTGKEpTyCO8FKgURX8n3w/l4YYmeKeZjPbKtgynq?=
 =?us-ascii?Q?Orths3sBFWhVLgJmxsafJIsYlonlO3nwWPGUDigA9r1+bNb7694IPHoyzkru?=
 =?us-ascii?Q?12EQBPlhsmCZNxPBELyHGtyXTsggoCcJXCl35IN2YQPtTzN5qyzdd5uU/1XM?=
 =?us-ascii?Q?LhJ/sbuJmIdN7p89lFYNIye5Bv7vPGM0oxTNF9iA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 562c0bf2-1c3d-4f3c-c192-08dc6b81c54e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 15:00:28.7045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Prp3v7CvHpDbCo/mSjmMgN0Yu+Lwjr/tMdvQ70QfPu+IfgAdOEbqdXsnrt41t8vcAD2j+n0uFpGOeksiLfCMeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8203
X-OriginatorOrg: intel.com

On 2024-05-03 at 16:47:49 +0300, Kirill A. Shutemov wrote:
> On Fri, May 03, 2024 at 12:31:12PM +0200, Ard Biesheuvel wrote:
> > On Wed, 24 Apr 2024 at 19:12, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Mon, 22 Apr 2024 at 16:40, Chen Yu <yu.c.chen@intel.com> wrote:
> > > >
> > > > On 2024-04-11 at 08:49:07 +0800, Chen Yu wrote:
> > > > > Commit 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused
> > > > > by parallel memory acceptance") has released the spinlock so
> > > > > other CPUs can do memory acceptance in parallel and not
> > > > > triggers softlockup on other CPUs.
> > > > >
> > > > > However the softlock up was intermittent shown up if the memory
> > > > > of the TD guest is large, and the timeout of softlockup is set
> > > > > to 1 second.
> > > > >
> > > > > The symptom is:
> > > > > When the local irq is enabled at the end of accept_memory(),
> > > > > the softlockup detects that the watchdog on single CPU has
> > > > > not been fed for a while. That is to say, even other CPUs
> > > > > will not be blocked by spinlock, the current CPU might be
> > > > > stunk with local irq disabled for a while, which hurts not
> > > > > only nmi watchdog but also softlockup.
> > > > >
> > > > > Chao Gao pointed out that the memory accept could be time
> > > > > costly and there was similar report before. Thus to avoid
> > > > > any softlocup detection during this stage, give the
> > > > > softlockup a flag to skip the timeout check at the end of
> > > > > accept_memory(), by invoking touch_softlockup_watchdog().
> > > > >
> > > > > Fixes: 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused by parallel memory acceptance")
> > > > > Reported-by: "Hossain, Md Iqbal" <md.iqbal.hossain@intel.com>
> > > > > Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > > > ---
> > > > > v1 -> v2:
> > > > >        Refine the commit log and add fixes tag/reviewed-by tag from Kirill.
> > > >
> > > > Gently pinging about this patch.
> > > >
> > >
> > > Queued up in efi/urgent now, thanks.
> > 
> > OK, I was about to send this patch to Linus (and I am still going to).
> > 
> > However, I do wonder if sprinkling touch_softlockup_watchdog() left
> > and right is really the right solution here.
> > 
> > Looking at the backtrace, this is a page fault originating in user
> > space. So why do we end up calling into the hypervisor to accept a
> > chunk of memory large enough to trigger the softlockup watchdog? Or is
> > the hypercall simply taking a disproportionate amount of time?
> 
> Note that softlockup timeout was set to 1 second to trigger this. So this
> is exaggerated case.
> 
> > And AIUI, touch_softlockup_watchdog() hides the fact that we are
> > hogging the CPU for way too long - is there any way we can at least
> > yield the CPU on this condition?
> 
> Not really. There's no magic entity that handles accept. It is done by
> CPU.
> 
> There's a feature in pipeline that makes page accept interruptable in TDX
> guest. It can help some cases. But if ended up in this codepath from
> non-preemptable context, it won't help.
>

Is it possible to enable the local irq for a little while after
each arch_accept_memory(phys_start, phys_end),
and even split the [phys_start,phys_end] to smaller regions?
so the watchdog can be fed on time/tick is normal. But currently
the softlock fed at the end seems to be more easier to implement.

thanks,
Chenyu

