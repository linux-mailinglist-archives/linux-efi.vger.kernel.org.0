Return-Path: <linux-efi+bounces-5830-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B00A4CB272B
	for <lists+linux-efi@lfdr.de>; Wed, 10 Dec 2025 09:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FF0A30069B1
	for <lists+linux-efi@lfdr.de>; Wed, 10 Dec 2025 08:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0452FF677;
	Wed, 10 Dec 2025 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHPF88pQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7328026D4F7;
	Wed, 10 Dec 2025 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765356071; cv=fail; b=TPCTEf7AzE1/AUOxVcJiIN6PgT5SVM/SAkscPZvbVT3/YDXVE1QnoSwPVPFADnR9HXkZ8iCwfhemKBwl6TwmwwNZBwyuumeVkCY7a7H/+uczHNBp6xFE9+V5oCRgqvMYwroiNsQTY+ugVDGmy0c4B8Si791humGQfHyG6Eqrulw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765356071; c=relaxed/simple;
	bh=8whvhjf68ky6YOc2qdDF8BRhZMgtB+hFGxTbEfwax20=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PVEuScsADQkLzw1QwHqtVHUUgi0x2lFxxaUm741RWgkAZQpUXr3R9AAtfD60ELKFO2L+/x5yHVlItKLOxrhJVapx47EPe2HO5x4f1CmRTVJA/boqh3NiKKbVBE3+AZOEJ0rkEh+1UMPpcO/bExWbqpsuUMhp80wOcOkaNmYZbk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHPF88pQ; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765356068; x=1796892068;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=8whvhjf68ky6YOc2qdDF8BRhZMgtB+hFGxTbEfwax20=;
  b=bHPF88pQNPHONPAwJiDh2Lz+ydEaWdClxvnNgbi24vfIxccQN5eXnexy
   tiBpzthZuuSaDB8vcRxwBAy5z4zIFe8M9MFMUTY7EEI/dMn/nPyBd6Vk9
   d5SneygvHb4/prJuPwUgL4ZtH93yYJXK+J3vL74u2b4SW8J2KI/QUppnr
   ppjrx/lHUxeAOY0Rr47HbE6MreAqdRXXnb+/j52H6T2e//m6mRf6UEd4t
   Il2IziEi8jk4HGWINHrrm0J7WU2SLaY0H+7UtddWV33Lkwl+5jAkGc1od
   TJS69l4OYzyQLtutFuCWxzYNmrzhYlaaQcBu0cVpXxvC6evfR94rmKBpM
   A==;
X-CSE-ConnectionGUID: QM6hM8vqTbWQutejEIqc9A==
X-CSE-MsgGUID: KBEeD99dQDCKHMGJhUQqPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="78685043"
X-IronPort-AV: E=Sophos;i="6.20,263,1758610800"; 
   d="scan'208";a="78685043"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 00:41:07 -0800
X-CSE-ConnectionGUID: s65oSgymTGinV/ZegZ6aDQ==
X-CSE-MsgGUID: HoeJZKqVTH2zVExbJx9nGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,263,1758610800"; 
   d="scan'208";a="195525717"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 00:41:04 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 00:41:03 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 10 Dec 2025 00:41:03 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.8) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 00:41:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OoBMnzLlBtMdJtYV1sbPCJjIqxNVn2xRKTPSAyrR9/DZxM/sV9BKcoHguSvH9dLHBWjvXGrc0+8qyrp/g5pKFzRGC8p4g6tffcNXMFYWeKxM+H86xh2G25oUs7ZNZ7q+0jkz6To37BMDP1eaj5cMbYq+mMWGkiSmO13dml9HRvIvUCAhkX2+CJ7CjO0QMJWbiPo34KsYfdVFWcIiM2fiZvxhxMQ8cmfjXYjMaTRN9IvjgaZUdm7fv0siiM1dVNiWDlwtxYUHuUQ0JsIPOsP7s+uKlev9+tzcIwFG+DVXUBaI/OqY3VLPc0e9VDJMKHWd0bA0SZdxpOREF3NfPfWIlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gv1JajfhybCZc8afVeyNNYXxJ2R8HGrNNgpcvGDg1Mo=;
 b=NxHq4Nqu5OIITJB0ekUURsItoBQuldwOBfF1g/vSVix8QcWvTG+2uHHZ2O6nhnRmNY8qyAsWBnMR/vyUoXBjvfVr7W5e8RARxq4jZwcZdLMqY9NiqzUO3XYCayFNdBmw4b2f+oNeYc3wzn91owoLUiKy7/sFwibHNuEhH9H+JJUiwxzNxteP1mVRkUoSJ13BXdBuYAovL6VvoQ0cH5dPzYagTJPpDffJaaDngCHtW6s6rk379uuKchJR2eJ2+a5Y9QkWGXm7xxjjKmvlh+zkJxVvHrC2Vh9yRhw97fsPjfXiDwBwAm0qfSOS6iZamB/o1R+OH95Gaamd2jEVRM95MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6932.namprd11.prod.outlook.com (2603:10b6:510:207::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 08:41:01 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 08:41:00 +0000
Date: Wed, 10 Dec 2025 16:40:50 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Val Packett <val@packett.cool>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-hardening@vger.kernel.org>, Kees Cook <kees@kernel.org>, Tony Luck
	<tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, Val Packett <val@packett.cool>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] efi: pstore: Support late setup with TEE-backed efivars
 ops
Message-ID: <202512101632.a94de49b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251203042850.14210-1-val@packett.cool>
X-ClientProxiedBy: KU2P306CA0009.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:14::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e5bf3c-099f-48b5-a2fb-08de37c7d8c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ChAG55NkX8G+sLU/ve/FxZmSqNuN8W3fYpIhBz9/+RghIb2TxXzC2SwSSPXW?=
 =?us-ascii?Q?CdGGC0jicu3J+qMGVGSHiamt1Lwr2GqfLK1lG4OJPYO3iQ2333odDyv3FCtl?=
 =?us-ascii?Q?4uJEi0Q2vLIjlSd9bG/JdRXuTeUEz+loh0XViX68R8JK0iN1fMZxkY404rOR?=
 =?us-ascii?Q?zpOlX2DGtQ89BzlEFIGD6FF5QoBFNlxqOMP+OJdiyyncKFBnOv4XDVxchyfn?=
 =?us-ascii?Q?pkhKeaXGajv6cazvW64dQEG06CPEDh/672+yAawPc2k7PtO2kXQInmZ8wafo?=
 =?us-ascii?Q?abCrkbPzArmoQvJlYZpo8Ra28EoliBH5RLkSGpvwZE4GtsmrgtGkWuf26kD0?=
 =?us-ascii?Q?ukFr5JmUA9Ry8le9KGDLj1Pd9TzI/Vap8kjvFyXLXvJyV1usieLrZq8flC/n?=
 =?us-ascii?Q?8rz0NaC0jpm0708ILjkbnLaN+gfXtvzBDgbMe2bqBlSGD1vvOrQ4aJVlLewl?=
 =?us-ascii?Q?qeKv/b0DoVqtBHhMQX4AgNr76V6rBSVyzml+diiG/nU+McoM1n7fWZiALB+o?=
 =?us-ascii?Q?Hnw9lx6Wvbp881BXie/0NRnCi+UZfik8oV2hft+xQB9+5CWzsU+OUBD8z2aa?=
 =?us-ascii?Q?XrWRiQgzFBYlCocBDjWAxMeBmPC7ueMhy0qj+eSf6tz5EfU7SaHKMzvByabC?=
 =?us-ascii?Q?GJ/WY3QHcmOjMUi7wMV0K4yxOxNlTIUs+cjMm7haxlWxrcj5etyqSSr8maLo?=
 =?us-ascii?Q?oWS4zxuVnyfGTHM2cACz53tnfYRtSFcZsNc807oDhbGkUBOThRehGH/Mb52y?=
 =?us-ascii?Q?5psCRFjISwai+lpiOeGyqbfzu9Udfcb0OzGFkKlVXJ1GRY6coEzKZfH17R0g?=
 =?us-ascii?Q?kyxzDmHi8VLaJHzX71UIFGyaiYyo5imw1iD6eeHZuD/OLN319Bp7O2Udysy9?=
 =?us-ascii?Q?NuUcvmJ6eU7x14OLchqBh8kIOk5Vav50L5x3Ixqw4TDLJoIGSX5Fah9pMFza?=
 =?us-ascii?Q?YOJW3sB0ywj6pErdXVJnTMCFinL5eI6Us+owcKIxz7VAIbXMPzOyfFXBR91L?=
 =?us-ascii?Q?1Rk73jb7tL44pblZsEt+PuyVAQAU6Vk4v9CH00kJ4ETK66PapF4yCNdaJM2Y?=
 =?us-ascii?Q?K1lZbUHeTzQFPbGPAxDuHDL2gTXPp1PGPRHcHsxB+KesIYMSpFjtRMsYp2o4?=
 =?us-ascii?Q?+cio5Tw3zSOxSjBiSeguc+vsHQdGCXYZlLjq4+09l1YF1G8EJ2G10cColox9?=
 =?us-ascii?Q?aLs0SFvkRIbsk5qu6jn0hieU5rae8VIvSyBXQdlpvk3dN9vvnXpcQ9gqV+Ln?=
 =?us-ascii?Q?TUgcYllxhakWTmAXS/gourorcTrlZZnnAxzPPdgJwbh6nk9cmR+sxv+VHwuT?=
 =?us-ascii?Q?6VWi4l/cajBtQYjVoEzJf0L8suCi/zgdkSMjAI9VBVeJMasponpkroJLS0Iv?=
 =?us-ascii?Q?0iIQpeYgmMW1XEDhEGG/6scGQwDmZvxDr26POENHDYq1MTFCSMKFRqIPpled?=
 =?us-ascii?Q?av21/afv0LYkLi9LB6I1O75oM+06xkNhrSSVKJ1DIRD1FWI5nqs+HQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QpOvhAKtHO7Xk7ZylS3xtRDzJtSrQcwPx0+ysra6uemY0bN1QLqth7nLVqZg?=
 =?us-ascii?Q?z9odPJ+h0pvmFhLtOBIgZEZ1Xn/ff2KgwCH4YwQKvt1/4IZLfP37lL3V/s5E?=
 =?us-ascii?Q?5gfvCtjGTDsFulwjCeDx+iP0aLCtucXbFtjWW0QTkw4uz9+pqppld559rBNu?=
 =?us-ascii?Q?kXMOa7dSg6NHL2wRhmPvhl4DRO1ljBVMjuqIQNl85w+EZ7GlSwayHpS/Wn/q?=
 =?us-ascii?Q?RixqPEKFGUlHYJxDvrWn7H1IOAvcdGL1FNCVUDI166r0mthS65wjUKLgWXwh?=
 =?us-ascii?Q?FZLoXELIluYTDmv13B8zR/NedLANRmwq0SZbU/ZIA6g88kj9T8AGOKCpGQlG?=
 =?us-ascii?Q?upzHMzryUKoUgFK2w4dA9XNuW3Sq6OujEUP72YlW4KW4ng5sTS0lPVSST0B8?=
 =?us-ascii?Q?l77mQNtf/784LxTI+WL6CTCMlsdwt5IO1BVpst5YsI7aH+UcBTDtNP1iUVfg?=
 =?us-ascii?Q?C2GB+seyEK5Vl6LaPByZhXduMv6bni9NmYCJ7+/96UvMCJ1E0jy4O/2zuUCH?=
 =?us-ascii?Q?TQWWOIlLmtZ3yKGk9IHImoNyh/iEsgF8lx5upO72ZaFx0JdQrML1F6yLCExX?=
 =?us-ascii?Q?bxWMp0carutZgg4tYFsxx2GAiKcUNaMXs5hWd+BMqE6u7pOHEe0hvlXWNv55?=
 =?us-ascii?Q?gmW8bOB5KAlT1FuNtOoXbT2KnMQS+VuhTloqWdOvl0O6UtQPtdPKz8zVpPnb?=
 =?us-ascii?Q?M7BmtHG5bnNnyQbDz1H3eXjL1QKtdZPZYERFfvZoo7l439YpaWT+nzTFnStv?=
 =?us-ascii?Q?hsBo0BxwZGbMdEr0dZixjehJP67doKTYupmak6xnDyMP0696Io4F/dTGimSN?=
 =?us-ascii?Q?pHd5f7d694KHNjDT/ZqXqW6hU0R56WNhnaMT8apkRuzWRDk4cwwXCUKEFXKy?=
 =?us-ascii?Q?G2QP5gIpiRCvtvSJEn9Ifu3a7q1xxsJnkgLDseHFByLSlA1NL2UCQh6xqcjE?=
 =?us-ascii?Q?0LGvScGXx4hQYtNrq8j+JHF07CoJfKIV+19aFqbmp0VG/vJNL2MvvB+2mh+j?=
 =?us-ascii?Q?YBiB/c3KwsCGkCcvajwoPQKgUI9l+WcRSKFjBQwk8vy6veLOdierRK0YMQAu?=
 =?us-ascii?Q?IPqNWAIKsWrHDu/B/FlCY+4S+HLtiT3zzNrZYzIKhoMqtAu6Xa49J9a2JSaH?=
 =?us-ascii?Q?U4NcWORF66N1q8xtk1/PBPmutPxLeMl3/D1vPEeb5VSWyfcDlHcpA9yEtb7L?=
 =?us-ascii?Q?eGwSgSG4oHz+p7zBmLHkJpJIPtrV2R/zzvg4Gb9LhRa8o84maYg46Dc27GoL?=
 =?us-ascii?Q?41aypbNXzlW49VzMqmA/VmmHdd7EilsFR8cNlc14sCr7D6H1JH9BIUlm3q00?=
 =?us-ascii?Q?vV1knqLZNqzVcyLSkfCx5MurEMYCAAQ3zsvBLC7kWqUmD3Yikrmp6h849b7K?=
 =?us-ascii?Q?WFrsgFj7E+BaV1XmS0UEkOONrTa3KxInLeu2gj8JmPE5l1R2mL0kGUUU47fo?=
 =?us-ascii?Q?pfIxscHJBIJd+chmVVKsKOG4FkwKEufKKSk9ewRvUfETATupk5Pf6BQWfC8F?=
 =?us-ascii?Q?0jWobwNyiEkvex/r0qvA9V7vqllfSVnm/fMkFuFXdwyW19X53hAv7W+HCd8H?=
 =?us-ascii?Q?EDYn1/rdALz/ScEiq2MfOgCVQXm7v8SEs/cne6+IZ9zRxsc5rdCIThfUXqbk?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e5bf3c-099f-48b5-a2fb-08de37c7d8c2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 08:41:00.8888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ci7aSAFXaqTZDQGIGq5jkDZgWygGyqHeyY3p+6n74Od96eNDhv3PB7HfWgmivJm9nnthQIo9GrJ29PH8oWL5dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6932
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/locking/rwsem.c:#__down_write_trylock" on:

commit: 6f473fefec79a8ba24013a5676a93934ee5ac922 ("[PATCH] efi: pstore: Support late setup with TEE-backed efivars ops")
url: https://github.com/intel-lab-lkp/linux/commits/Val-Packett/efi-pstore-Support-late-setup-with-TEE-backed-efivars-ops/20251203-123406
base: https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git for-next/pstore
patch link: https://lore.kernel.org/all/20251203042850.14210-1-val@packett.cool/
patch subject: [PATCH] efi: pstore: Support late setup with TEE-backed efivars ops

in testcase: boot

config: i386-randconfig-015-20251207
compiler: clang-20
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------------------+------------+------------+
|                                                         | b692553573 | 6f473fefec |
+---------------------------------------------------------+------------+------------+
| WARNING:at_kernel/locking/rwsem.c:#__down_write_trylock | 0          | 18         |
| EIP:__down_write_trylock                                | 0          | 18         |
| WARNING:at_kernel/locking/rwsem.c:#up_write             | 0          | 18         |
| EIP:up_write                                            | 0          | 18         |
+---------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202512101632.a94de49b-lkp@intel.com


[    7.731121][    T1] ------------[ cut here ]------------
[    7.731800][    T1] DEBUG_RWSEMS_WARN_ON(sem->magic != sem): count = 0x0, magic = 0x0, owner = 0x0, curr 0xc0288000, list not empty
[    7.733282][    T1] WARNING: CPU: 0 PID: 1 at kernel/locking/rwsem.c:1339 __down_write_trylock (kernel/locking/rwsem.c:1339)
[    7.734420][    T1] Modules linked in:
[    7.734903][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.18.0-rc2-00002-g6f473fefec79 #1 PREEMPT(none)
[    7.736185][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    7.737529][    T1] EIP: __down_write_trylock (kernel/locking/rwsem.c:1339)
[    7.738173][    T1] Code: c1 92 28 c2 bf 39 3e 26 c2 0f 44 fa 57 50 ff 71 04 56 ff 31 68 dc f4 35 c2 68 fe 5b 35 c2 89 cf e8 81 d1 e8 ff 89 f9 83 c4 1c <0f> 0b 39 ce 0f 85 4b ff ff ff e9 4f ff ff ff 0f 0b eb 8b 90 90 90
All code
========
   0:	c1 92 28 c2 bf 39 3e 	rcll   $0x3e,0x39bfc228(%rdx)
   7:	26 c2 0f 44          	es ret $0x440f
   b:	fa                   	cli
   c:	57                   	push   %rdi
   d:	50                   	push   %rax
   e:	ff 71 04             	push   0x4(%rcx)
  11:	56                   	push   %rsi
  12:	ff 31                	push   (%rcx)
  14:	68 dc f4 35 c2       	push   $0xffffffffc235f4dc
  19:	68 fe 5b 35 c2       	push   $0xffffffffc2355bfe
  1e:	89 cf                	mov    %ecx,%edi
  20:	e8 81 d1 e8 ff       	call   0xffffffffffe8d1a6
  25:	89 f9                	mov    %edi,%ecx
  27:	83 c4 1c             	add    $0x1c,%esp
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	39 ce                	cmp    %ecx,%esi
  2e:	0f 85 4b ff ff ff    	jne    0xffffffffffffff7f
  34:	e9 4f ff ff ff       	jmp    0xffffffffffffff88
  39:	0f 0b                	ud2
  3b:	eb 8b                	jmp    0xffffffffffffffc8
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	39 ce                	cmp    %ecx,%esi
   4:	0f 85 4b ff ff ff    	jne    0xffffffffffffff55
   a:	e9 4f ff ff ff       	jmp    0xffffffffffffff5e
   f:	0f 0b                	ud2
  11:	eb 8b                	jmp    0xffffffffffffff9e
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
[    7.740468][    T1] EAX: 58e1ae7d EBX: c33977c0 ECX: c33977c0 EDX: 00000000
[    7.741422][    T1] ESI: 00000000 EDI: c33977c0 EBP: c0293bf0 ESP: c0293be8
[    7.742277][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010296
[    7.743199][    T1] CR0: 80050033 CR2: ffd38000 CR3: 02b87000 CR4: 000406d0
[    7.744043][    T1] Call Trace:
[    7.744429][    T1]  ? blocking_notifier_chain_register (kernel/notifier.c:264)
[    7.745251][    T1]  down_write (kernel/locking/rwsem.c:1591)
[    7.745755][    T1]  blocking_notifier_chain_register (kernel/notifier.c:264)
[    7.746473][    T1]  efivars_pstore_init (drivers/firmware/efi/efi-pstore.c:258 drivers/firmware/efi/efi-pstore.c:306)
[    7.747059][    T1]  do_one_initcall (init/main.c:1283)
[    7.747623][    T1]  ? last_attempt_status_show (drivers/firmware/efi/efi-pstore.c:299)
[    7.748291][    T1]  ? local_clock (arch/x86/include/asm/preempt.h:95 kernel/sched/clock.c:319)
[    7.748949][    T1]  ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91)
[    7.749590][    T1]  ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91)
[    7.750218][    T1]  ? sched_clock_noinstr (arch/x86/kernel/tsc.c:271)
[    7.750828][    T1]  ? local_clock_noinstr (kernel/sched/clock.c:272 kernel/sched/clock.c:309)
[    7.751477][    T1]  ? local_clock (arch/x86/include/asm/preempt.h:95 kernel/sched/clock.c:319)
[    7.752042][    T1]  ? ktime_get (include/linux/seqlock.h:226)
[    7.752565][    T1]  ? kvm_clock_get_cycles (arch/x86/include/asm/preempt.h:95 arch/x86/kernel/kvmclock.c:80 arch/x86/kernel/kvmclock.c:86)
[    7.753268][    T1]  ? ktime_get (kernel/time/timekeeping.c:295 kernel/time/timekeeping.c:404 kernel/time/timekeeping.c:826)
[    7.753775][    T1]  ? local_clock_noinstr (kernel/sched/clock.c:272 kernel/sched/clock.c:309)
[    7.754393][    T1]  ? clockevents_program_event (kernel/time/clockevents.c:336)
[    7.755098][    T1]  ? tick_program_event (kernel/time/tick-oneshot.c:44)
[    7.755720][    T1]  ? hrtimer_interrupt (kernel/time/hrtimer.c:1916)
[    7.756331][    T1]  ? irqentry_exit (kernel/entry/common.c:?)
[    7.756993][    T1]  ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1052)
[    7.757704][    T1]  ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:80)
[    7.758306][    T1]  ? irqentry_exit (kernel/entry/common.c:?)
[    7.758860][    T1]  ? sysvec_call_function_single (arch/x86/kernel/apic/apic.c:1052)
[    7.759562][    T1]  ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1052)
[    7.760261][    T1]  ? handle_exception (arch/x86/entry/entry_32.S:1048)
[    7.760967][    T1]  ? __get_immptr (arch/x86/lib/insn.c:632)
[    7.761517][    T1]  ? parameq (kernel/params.c:81 kernel/params.c:91 kernel/params.c:99)
[    7.762011][    T1]  ? __get_immptr (arch/x86/lib/insn.c:632)
[    7.762540][    T1]  ? next_arg (lib/cmdline.c:273)
[    7.763050][    T1]  ? parameq (kernel/params.c:90 kernel/params.c:99)
[    7.763551][    T1]  ? parse_args (kernel/params.c:153)
[    7.764127][    T1]  do_initcall_level (init/main.c:1344)
[    7.764819][    T1]  do_initcalls (init/main.c:1358)
[    7.765347][    T1]  ? kernel_init (init/main.c:1485)
[    7.765895][    T1]  do_basic_setup (init/main.c:1381)
[    7.766432][    T1]  kernel_init_freeable (init/main.c:1597)
[    7.767049][    T1]  ? rest_init (init/main.c:1475)
[    7.767587][    T1]  ? rest_init (init/main.c:1475)
[    7.768125][    T1]  kernel_init (init/main.c:1485)
[    7.768686][    T1]  ret_from_fork (arch/x86/kernel/process.c:164)
[    7.769276][    T1]  ? __switch_to_asm (arch/x86/entry/entry_32.S:704)
[    7.769852][    T1]  ? __switch_to_asm (arch/x86/entry/entry_32.S:704)
[    7.770427][    T1]  ? __switch_to_asm (arch/x86/entry/entry_32.S:704)
[    7.771001][    T1]  ? rest_init (init/main.c:1475)
[    7.771535][    T1]  ret_from_fork_asm (arch/x86/entry/entry_32.S:737)
[    7.771957][    T1]  entry_INT80_32 (arch/x86/entry/entry_32.S:945)
[    7.772338][    T1] irq event stamp: 108765
[    7.772712][    T1] hardirqs last  enabled at (108773): __console_unlock (arch/x86/include/asm/irqflags.h:19 arch/x86/include/asm/irqflags.h:109 arch/x86/include/asm/irqflags.h:151 kernel/printk/printk.c:345 kernel/printk/printk.c:2858)
[    7.773432][    T1] hardirqs last disabled at (108782): __console_unlock (kernel/printk/printk.c:343)
[    7.774123][    T1] softirqs last  enabled at (108714): __do_softirq (kernel/softirq.c:657)
[    7.774782][    T1] softirqs last disabled at (108699): __do_softirq (kernel/softirq.c:657)
[    7.775441][    T1] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251210/202512101632.a94de49b-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


