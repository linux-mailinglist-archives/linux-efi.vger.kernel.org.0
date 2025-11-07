Return-Path: <linux-efi+bounces-5389-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398FFC41854
	for <lists+linux-efi@lfdr.de>; Fri, 07 Nov 2025 21:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5333A3390
	for <lists+linux-efi@lfdr.de>; Fri,  7 Nov 2025 20:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E907C2F8BDC;
	Fri,  7 Nov 2025 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O4/CjM0j"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81E8257829;
	Fri,  7 Nov 2025 20:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546117; cv=fail; b=V35oZImscqHSRlfUQJKh/QdTf1Vq60tGJna9DIeQy+MaIl2KKQfxfeZUMHK8F7ARKrW8LGLZ8qkdz1lA8e2z+UT/dw+6mx+XIDldT9nB8WE2H8Y2Ur9JCQRIV2JZjggkyq7eyB5iCJaoVOjp/0HKRJVn+UxwfqNAue6+eu8xn0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546117; c=relaxed/simple;
	bh=qGGC6MTExqx1VkcLeOBry437PbZYcqhygT8oLi1K/mk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PbmpqOSo6Hf+nKCOqJYlbfx5VYcHI23pmNCDxHPz2g9cQ6qHB3En/mBXAAmCTwIn25hY263+V0T/poRrkMXr1/Fi+Xjc/HO1pdyVbPm9PGdV3fiCmZCDV3wxqcZJCjjtc4juKlvLFcZaahjbXbGAGgCMe1B8QQJA5ENJEqduNhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O4/CjM0j; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762546116; x=1794082116;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qGGC6MTExqx1VkcLeOBry437PbZYcqhygT8oLi1K/mk=;
  b=O4/CjM0jHCfkp64bTNAZparH9gMMzd4PwzMidQcmh2eKcheCt6gYQgv+
   Y9w81PQJfvDZ+pqvT81StlBq0S8lnsiESlW6rqXv1dwBcX9HE665eKY3B
   GUOo++ZIo/DziOlCZZklwBj1nBfYizEdhTeMYofP+xHnXMnCK1W6nEeiZ
   So887RkxtvBdiwuLcLOLV3GgRLLx7kxkImPRcwfQqKk0kfx2b98dhYMiH
   aWFDm5FBqOLmlOVAKHxqTKqiRxKPKjJrWD0Xtz5QttKE2LEWTClQ2bVgg
   qTqclgblMc9C9eCvVY/VBxm07d9hiHgdQISqhChK285FNT/rvDzGoHBSG
   w==;
X-CSE-ConnectionGUID: s+lamsgqQTyKjvY0ULUQPg==
X-CSE-MsgGUID: HB+TjVNvSDioo7g9SfzE8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="82327835"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="82327835"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 12:08:29 -0800
X-CSE-ConnectionGUID: XzfCMskdRQasYoyT9PXbtA==
X-CSE-MsgGUID: 48vLbUSzRjmYJL6huVoWsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="192218439"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 12:08:28 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 12:08:27 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 7 Nov 2025 12:08:27 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 12:08:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZqiBlwfVxpk+hyMXUSZcnvOuGurzc+64YdUUc35r4vvhVYx/OpLXb4iL/6+a83BI1LmFFNtlnLGH5FXuwpSDKCeXveonjmC3SYfB2MS8ZP6eKnUG0cG1TqfiGiasL818/uS7CfAt4NDSY2NBZE3BPe7Gu4mfFBGbzOSU41j1Zd5BLrlw2iZaNafOft5+OfbncwcRBx89mAEMs+cUh/IHemtGg97Kv2XG90XFN6dGl3T7CJgaaQwqDpYlbz0BoPPGGt9ddhiVAlrq2oewaMNzkoedcYySJIlHqqL8MyYZ5bJ+vcFpsjbdLKPwZHhOuji2Nk7u0E/UyXkjGblgvZZkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjV1aKVPGJOwatrJbyaD66A79TESRxe1IfUeblSEesg=;
 b=M8hZWhkDxwgpmzAXk1XsWnHEzAccTGxt5AD1JcNsAX+hmg4KNVuHyeJj04SM5g5Wrvpmxrs6iZPeLFs/RI4j0TbRITgPJTr2BBdhcAqyS5zIlfI/qpoHVpnZWMVTbigU+h5t786OXQ7lavDhAG6pFMyj7jFBDkOxSNhFoTV/Rz1DWVhuT1mKyOZQkgDa2Mok2yDw1Cye1KqXMxqvJvWspNKwytU1QPZ3Mec4wv9bQBVk2mPdvEpn+siUzaMOo88k9a1yeBEj4rQN5bKgnXhfxkvY+Qq7zAWyvmajDH86+6bthVw1rvhsFe7DhEGMrdJDl6IcRnmW/M+c+zMKuKh5sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by SA2PR11MB4937.namprd11.prod.outlook.com (2603:10b6:806:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 20:08:25 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 20:08:24 +0000
Message-ID: <bbb68600-eea9-45d8-90d1-bc4619186a4d@intel.com>
Date: Fri, 7 Nov 2025 12:08:21 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 9/9] x86/cpu: Enable LASS by default during CPU
 initialization
Content-Language: en-US
To: "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
	<x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>
CC: Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>, "Josh
 Poimboeuf" <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Ard
 Biesheuvel" <ardb@kernel.org>, "Kirill A . Shutemov" <kas@kernel.org>, Xin Li
	<xin@zytor.com>, David Woodhouse <dwmw@amazon.co.uk>, Sean Christopherson
	<seanjc@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Vegard
 Nossum" <vegard.nossum@oracle.com>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Randy Dunlap <rdunlap@infradead.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, Tony Luck
	<tony.luck@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-10-sohil.mehta@intel.com>
 <789ADBB5-F7AC-4B08-B343-F23260FB8FBC@zytor.com>
 <d20a5e9d-dc0b-4bd2-89bb-95dbded8a581@intel.com>
 <255724be-a6d8-4aa6-94f9-1e6ffba3a3cc@zytor.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <255724be-a6d8-4aa6-94f9-1e6ffba3a3cc@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::16) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|SA2PR11MB4937:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b96c425-cabe-4f8b-e8af-08de1e39686a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTlUWWljSVpZVWx2Mll4dG9pRVhZWEo5bDMyVTlRQlBBOVNiL09YdFRHWEJH?=
 =?utf-8?B?MU9CbGNSaTlWYzc2TUJhZ2IrRzNmdWJhODZkTWUzZjZ0WGtLaTVaL05tVnoy?=
 =?utf-8?B?SllhQWNjcU5JNXlFakJpWjFxdXAxa1YzbVVNSUR5czA3eER3bHhCVTBMaE0y?=
 =?utf-8?B?N1BXU1hWRkFhb2xuMXF0dFBUd1lIUGptWEswYXRZZSt0ZUwwVlVuUnBTTlRC?=
 =?utf-8?B?Y29qS0w5NHRyMW5QYS9NNlJNTUhKczdMdVZaUXBlclRISEJ2SUdhV2RrM3F3?=
 =?utf-8?B?NU5rRk9ZRjFSU0MzMFA1Tm51ZmFzS3lZcTY5dUNWbmJ1WitvY0l6VVBiWFE3?=
 =?utf-8?B?V3N3TE9jN0k0UXFKRjhONmlPMUtmQ3gxT3NUY053ZnZPRk5kQkl5N0xScklG?=
 =?utf-8?B?MTlxU3lSMDhKdGVLdnNldkE5b0ozbTMvMzhEelllNWJTNVVtYU9nbVJMdFZH?=
 =?utf-8?B?UU5PVlNhb3FCTkM1bnoxZ3EvZGwzV2EyL05MQWxTaDk3VWVsQlJPYXJ2cFg2?=
 =?utf-8?B?TTdKOThJMGJKamRlaWJaSU90cFJvSFE5Z1ZqUmJBUHVwcmR0OHNibG5NZ2d1?=
 =?utf-8?B?M0hiNFJwdjJ3RHlnQlM5aUVWSUxnellWdGRaaFdVRmNCajR5SkttbURxTHcw?=
 =?utf-8?B?YlptMTY2UjhtRU1KMUlnZFJqSWxIY0taSTNVdXV5RzZ3bzhrMGhMTXpHM1RF?=
 =?utf-8?B?UjkweHRlL2Rhb3hpZWlRY0I4emRncUZPbnZKQTZZMkZzZ205aFJMdjFScHZx?=
 =?utf-8?B?MTY4ejRtU2ZoNjByczVXQk5OejZra25QbWxEYjBaYmRoUWhKc2F4YllsSlF0?=
 =?utf-8?B?RENHNjJVOGZTOC9XME9iTkJrL3JSSk9CWHo4SlhEZXpnUHQ1a3ZKQ3ByMWxp?=
 =?utf-8?B?djdCenFZZERIRDhjcno4SUMzbmp3RTd5REc4Sm5hNEgwd013K2FhR0U1ZFFW?=
 =?utf-8?B?NmZPb3Q4Mys1YUVTV2p0VDM2YWdaZUtHbm8vNlRSSTFoaGRwY0FIWnNaVk4w?=
 =?utf-8?B?YWpSZ0JQOWd1RXJ3UXQwTlEzN3RQWHJLSjZkL1VyeGRRSkFqVWZqckwralM3?=
 =?utf-8?B?SkNuY3BwVzhUd01iN0hFb0xIZ0pLZnNRWWkxN0FLN1pJZURWVW9YVktZdE1R?=
 =?utf-8?B?UGh3RExNNTN5NktiZ1ZVeENPbW5zRVpYa08vRXk2dzBLR0RUd2N5K0tvajRB?=
 =?utf-8?B?UFRHeWREbW5SUlZ2SC90U1hsbUE2cExXOHd0RFVqbGYvd01MM2RHVVA4UkRj?=
 =?utf-8?B?S1hNTGNVL2c0YWhMWHdHd0ZkaFpqTERVSDBXZnlEblpHQVdXRWw2MXBLNndo?=
 =?utf-8?B?d3RxZkNaWWM1Nk5tREhjeHl4TWNlWUNXRDhVRUxSNndtd0NtK0t2UDNEaWhB?=
 =?utf-8?B?WUMrOUQ1MHVVL0E2NEtyZ0VacFNkWGJTZTh3QU9tWHlBT0tkNEFLWWdWWHdp?=
 =?utf-8?B?d1RpMXlwcDF6NWp3Z3dGNFIycnAvazJEUHJ3QWxwdXc2bDFPTmcvSnR2WWZ2?=
 =?utf-8?B?R3FONjBncmZJNm5FaWZET29kaElZeTUzSURCUGE1elRyRHRxTmNHNC9Ga0s2?=
 =?utf-8?B?ZVMxWHRxT0lZVXNsNkpRejJyejN3YXJYNW03RTNPL2kvQW1pbVd0M3BkREVk?=
 =?utf-8?B?d01taXJLQzI0eGlKdHZKVHdkb1l2RkhzK1U3WnZxQzhrZktHUE9acm1mdjQv?=
 =?utf-8?B?UXBIV2dEL2ZCcm8yZFBMV3hTUmJlUEo2aW8yQi9mcWtOSXJtZndtanNLL3NZ?=
 =?utf-8?B?TmNKOEhkMXB3ckpHaTlYcTgwUE9UQnNNNHJhaWNkdjBZOXJZckdwVDh5YVRj?=
 =?utf-8?B?eHNDK0dhL2FWaHdOZ2JCdjVnTWMrSkh6WVB1M1pwdGtkNTRnY1Y3Ujh6dmdG?=
 =?utf-8?B?cVJxbkhyd0lERkdwWWVRN2luOERCcUFuWm4rV3B0bFM2VUg0aTR1dm5VOGYv?=
 =?utf-8?Q?sf5F0b9r6ZtpnycQt7PSOCnO6lZgMAkq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFJpMHdtTU5IUXNOdGJGayt2LzZNano1bzVvYUFVSDcrTnBlQlJtSVl5UldH?=
 =?utf-8?B?ckJRTGYyV1hnVHJHU2NCaDhSZElTVCtkeGVwOU5pRlJmaEFUTEVTaXNwMDJB?=
 =?utf-8?B?alpkTWNGTTlqNDhaRS91TzByTVdwamY2a0xjZUdzcTRzZnhOa0VHZ3VMRDN3?=
 =?utf-8?B?dERFOTVtMk45NGpLS3ljK1ZBKys3d0N2SHhqZ1NXQW1POVBGRFNSckhLN0hE?=
 =?utf-8?B?aVcvcmhNdDAxdUZHRzhQOUwvNzNTQjh5TWZFRjI3a012LzMwZzJUREtna2du?=
 =?utf-8?B?R01zMFRFQjZ4Zk1KVkREUFlmbi9vM3RTb3REbGpXNFJ4UVRNNXVUTlhQK0RH?=
 =?utf-8?B?WVNOdXRCU04rdEZmM3VJaWp6M1pYcjBHeFNzNmZTS01ZTG82V2duS245UjRE?=
 =?utf-8?B?bTBQTTVlOVZIa2tHMUQwVmYwQzVHajJiNTk0YlhwNU1paW85NGVrY2NvalN1?=
 =?utf-8?B?T090MG56YTliMTdKM3NtWWlrRWJ6VVM1UFlsWGRmM1cyMFdxd2QxYjJBYS8w?=
 =?utf-8?B?NzJCTmpxanF6VFNCb05QWFNjQlcxVGtEaDU3L0VHWDZQaDlBK1V6a0N6Z2VQ?=
 =?utf-8?B?Tjl0dDZsVTJvTTV1ZFgxcnpvWHppQkVTbjVtNzVOWHdNVERWNzZrb05ES25K?=
 =?utf-8?B?VVFXNXJNM3RoeDZFY1NVZXJHd2tuWkVUU2xwN2hqMFo0UldKeXRNZXVUM0pO?=
 =?utf-8?B?ME50MUlWL2RBUWRFTjJlZnRHelNkY2t3aVdpRmQ1UjRkWDBCTjB1L2FGWjNS?=
 =?utf-8?B?bXdIaG9BWDVjZmZmNWQrQUJoSHBwR0NGTjErVEgwT3UzbWxkc0hiVHFxWXk4?=
 =?utf-8?B?L3cybzJyeThVazFQdkdEc1VLdmRZVTRrdHp1cm9HMUppdUo1QVN1aTdKRVFG?=
 =?utf-8?B?NUUwd2pncTZVZWdHVitqNmhYU2Q0ZGRDZzNDTEZNOFhmUzZSM1dKZ29xN2Vj?=
 =?utf-8?B?OXFtZWM4T1Yxcll5MWlrcEppRGwweS9ZTmZERUZCdHIyNlRlNk1NeEdLMkxX?=
 =?utf-8?B?ZXJFdmY2YThpOEZrTkFFSC9XZnNaMUl4QithU1JGNFljNmFOQVZ3V0JWSEVk?=
 =?utf-8?B?Z0pjOUtvRFROeEJFd2dhQVBLNERxb0NucWtqSXozRGRGQ2I3amFaZ1gwaDRx?=
 =?utf-8?B?VHFucWExR3ZxVGl5d3BYTnhHMVhicGVYYi9WakVxS1p5MWdCN0U0U0IxNWxh?=
 =?utf-8?B?Ym9nWjJqQS8rVTZuT2lEbTdsbzhyc0RDZ3ZRdVVQdTdueE1sQ1oxaUttTWZV?=
 =?utf-8?B?eUZJeVBnQUhKaHhSSTM1eDUwZG9icXFPUE93bUV0L0JRRDhYVXR2Z3g4K3ZN?=
 =?utf-8?B?YWQ1ejdSL3c5K3VIellHV1gvclhIcy8rU2c5Zm1FWTVRL1QvRThmMUMvMzhl?=
 =?utf-8?B?ZE9VZXRLbEw1T3VrZ29YSlVwODZqbVpEeDZ5dHo4UXpURjU3RGgwUVV4aGNU?=
 =?utf-8?B?STFpTGVLemprWEt4WFpKWU96emNQOUZkRHRGNkxNSFJFNTljM3BodXY2NzJl?=
 =?utf-8?B?QWFJS0ZhUVdudDBnY0RVZGJWcmRxUzg5cGJnRE5MZzJScUgrcEtIZ3VEamdn?=
 =?utf-8?B?UkJUcThtaWE3ODY5ckdoWXdMditpOXdhSUlzOVN5RkNuVWJyTUtMLzgyNThD?=
 =?utf-8?B?RVRvalYzb3dZbCtkd014NUFHZWlkMmF1NXFwY3BBMGVtblF6VDFPT3d5S1l6?=
 =?utf-8?B?UUtzYVNEU1E0TjdPNThHa05ROTNidlAzdmxlcnJXSTZvODJ5TkQvZnZKOVpK?=
 =?utf-8?B?eGtxaDRvZUpwVFRPMHlwZUZXLzhpTitvOVFSVzVqbEVEWnBwUFhnQ1lYSHEr?=
 =?utf-8?B?Wkw0emlFVHhnZ295RHlkR3RBTUJuajJtUEsxcEZ1UmtDUWxQeERRSWE3WjBS?=
 =?utf-8?B?Mk15NGZyRDRWQVRGZVdwaE90L2FhaTRjYW9Fc1kvdXljV3FHUXpEa05ERUY4?=
 =?utf-8?B?OW9WUmZwR3g5TEp4d3Ezd04rQWZuRVZiU1REQk1yaVRFdHFYeWtwRlF0OG9j?=
 =?utf-8?B?N1ZUSW84WlRFSjF5aFF2R25zNVZMZk1CY3FSOHNjakZTUy9sdUJkcEFKZXRw?=
 =?utf-8?B?bXlkSHdVVjZYcFlSMUt2QzREbmlQRlkvdUJyVzRMUzlTdGxRS3lRaTBnT1JO?=
 =?utf-8?Q?hYyjMHrlAmIwWrE9wDFY211w1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b96c425-cabe-4f8b-e8af-08de1e39686a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 20:08:24.8702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NW8pw32gh2DxmjJfxv6Epom+pFT+N01/g+WeJwLUM5N53ogWSEMVzHJvpWZ/oNY03Lt5VgYY2B+IXKUMRu3qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4937
X-OriginatorOrg: intel.com

On 11/7/2025 12:01 AM, H. Peter Anvin wrote:
>> I asked Sohil to start throwing out all the non-essential bits from this
>> series. My thought was that we could get mainline so that LASS itself
>> could be enabled, even if it was in a somewhat weird config that a
>> distro would probably never do.
>>
>> After that is merged, we can circle back and decide what to do with the
>> remaining bits like CR pinning and vsyscall emulation. I don't think any
>> of those bits will change the basic desire to have LASS support in the
>> kernel.
>>
>> Does that sound like a sane approach to everyone?
> 
> XONLY vsyscall emulation should be trivial, though (just look for the magic
> RIP values, just like the page fault code does now, too.) The FULL emulation
> mode is completely irrelevant these days, so I don't think it matters at all.
> 

Yes, the actual change is quite simple. But along with minor refactoring
and updates to code comments and documentation, it ends up being a set
of 3 to 4 small patches.

> EFI handling is similarly straightforward: just disable CR4.LASS right before
> calling EFI, and enable it on return. As long as we are *already* in the
> efi_mm context, it is perfectly safe to disable CR4.LASS, because there *is no
> user memory mapped at that point*.
> 

At a minimum, We need to defer the initial LASS enabling until we are
truly done with the boot services memory, i.e. efi_enter_virtual_mode()
has completed (including efi_free_boot_services()).

Also, there is preference for deferring LASS enabling until userspace
comes up. Again, all of that should be simple enough but ends up adding
to the patch count (touching 20 now). It was getting difficult to get
the reviews/acks from experts in all the impacted areas.

Dave's suggestion of splitting the series makes it easier to merge the
base set and get focussed reviews on the missing features. My plan is to
promptly follow up with the EFI and Vsyscall support to make LASS
enabled by default.

> These two things should only be a few lines of code each, and I don't see any
> reason to further elaborate them at this time (to handle FULL emulation, or to

Yes, there is absolutely no need to support the full vsyscall emulation.

> take a LASS trap inside EFI to write a shame-the-vendor message; if we wanted
> to do that, it would be better to make that independent of LASS and empty out
> efi_mm entirely.
> 

This seems to be the takeaway of PeterZ's interaction with Ard. Though,
I agree, warning about misbehaving firmware should probably be done
separately and independent of LASS.

I'll send out another revision of this series without EFI next week, and
follow up with support for EFI and vsyscall soon after.



