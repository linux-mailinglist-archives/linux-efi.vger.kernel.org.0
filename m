Return-Path: <linux-efi+bounces-1919-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2734E993E50
	for <lists+linux-efi@lfdr.de>; Tue,  8 Oct 2024 07:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87D0CB21E19
	for <lists+linux-efi@lfdr.de>; Tue,  8 Oct 2024 05:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2161713AA2A;
	Tue,  8 Oct 2024 05:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f7WfLWej"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E0E13959D;
	Tue,  8 Oct 2024 05:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728365241; cv=fail; b=Ep2LIqr8jFVjn4yK0EhRBlF7Rb4UBGITlrHIlEIMVbMrHmjWohNWZvRtw61FUUs+TV2H3s187c6Hhljfc0E90424+IDQ1xU7ScTjp+iP2Q3SnQk+mh1WJvwHz46bgCddaMY6lY1Pbx8nwCm8slvdbAeTz/Tk6yn1LjTPJB54zOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728365241; c=relaxed/simple;
	bh=8EW5QZikvYfWdnFGyzkVVe/YXeEmmV57AtXywd6Dbls=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I+WOdoiOsa/HyDkUStAGOkhbyHKzBR7TMi3uoJMLm7Oczzy+A8wFMUfMPuA8VyQDq4aJVlWaLHeYvnIl0Ks+33OAc2Kx4ooMznE40hKqAAR/4pc5F89mH7G5EmcZdCTByUs4TkGRT0m6rdh+4jTV1edqYQEsZHQB7gYsihNwBdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f7WfLWej; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728365239; x=1759901239;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=8EW5QZikvYfWdnFGyzkVVe/YXeEmmV57AtXywd6Dbls=;
  b=f7WfLWejcnBn70Y85F93F2b9kIzpuHeZ0i9ToNg4Ku4JK+434IVqDFAj
   FwfyithO5pZHVGj0jylL1WfUfuQqOaDN0zrOICGc2K3ZGEFhJ4fgGwS9H
   lpNgk+sMjd+veEZHUjF/F4GmZtUxcqrgKxdu2PqEF1ukDydKtFTElBr4H
   C2KLVgzSLxlRBmmSVdYSUfcUm6C+8OsW3oNvdNetA45b4u5y99lIQo1sv
   hdi1IMDJD9SBTMufl81p9oLEXmYikiDbFFoDQez1pzRiH4LsSjDH20PFW
   GYAPsXKp7hWLsoRM7d8LH6ydrJXbGhsv1mExJm6DUcEZwKHd7mpdWJraV
   A==;
X-CSE-ConnectionGUID: z/3aW73cRB+f0ihAbc6DZA==
X-CSE-MsgGUID: UZ0kcisfQxO16LQTStPPQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27480524"
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="27480524"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 22:27:18 -0700
X-CSE-ConnectionGUID: v1Nq73+jQwaCD0Kk2a0SQw==
X-CSE-MsgGUID: VJRQfFEZRqm2H9tqYx9Ofg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="80494965"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 22:27:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 22:27:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 22:27:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 22:27:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 22:27:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHDkIvBTjuFRb5uKQJPYr/Mo1AIP4JpLjoKQrNIwjXJGKATiYKxxHt85KUfnSdyggo/BMlLk+YhoQdnn6y8PF3G/0A/hH1/dfkNJaEfqWnf6kjnkUwHheYX/VAA9vSHwEprCVfTM0UIFXHsOPQSz+P00F23Kc6MJO9d0XiNYApawo14yEcZ9X2q8klAV27mBDvayvR49Gtvxq4K8T8GNw8GHKscdrk/pIAEOrnFAbhF4r2YgLMRbQv159LTNQg05CK8V90mnYwi583stO66VOBXshWT97k3cj/YW1qO+eUChXoMu41gBCMkcKvbgW17NvXKd2pu/Vq8C5HR9iLySjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EW5QZikvYfWdnFGyzkVVe/YXeEmmV57AtXywd6Dbls=;
 b=wSFZ+1aMhvJuSRMEt8lBMTQRW1KAMo2SJ1Y8w6ENNIjEqXxno4gtsG+ZWsuUeUJORmFZ53vSU/gDCySXomdz8bj9U6rEnCKXL71ADl6tTsG18JttYmOoNKBwhcyolp3tHb+H1xaDoMeITtIw8Ufz/oLAZJlJMkVgHBlCUeF9uYUFr5b25woeGjEuQDyupN7b+EDTDhPpEeik+ZluAhart1KL3LexabnokRnzV+TdeGe3gWzYmKM6EEtJHdO9Oj4nuz2amChoKgvRkAATegisCuaXoPwrz9PL/7tkgeovP2jw3iv14hrvxaCwO5b6kFwdfk6V6UEZhmmldZa847eUTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by LV8PR11MB8485.namprd11.prod.outlook.com (2603:10b6:408:1e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 05:27:12 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 05:27:11 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "mochs@nvidia.com" <mochs@nvidia.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "Ko, Koba" <kobak@nvidia.com>,
	"ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 1/2 V6] acpi/prmt: find block with specific type
Thread-Topic: [PATCH 1/2 V6] acpi/prmt: find block with specific type
Thread-Index: AQHbGAWCkzZMb5smI0+GvUEEnSnd3rJ8VWYA
Date: Tue, 8 Oct 2024 05:27:11 +0000
Message-ID: <34324fae08418e663b47daaf05bc37c6273e4911.camel@intel.com>
References: <20241006153611.1165482-1-kobak@nvidia.com>
In-Reply-To: <20241006153611.1165482-1-kobak@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|LV8PR11MB8485:EE_
x-ms-office365-filtering-correlation-id: a4e11ce8-29d8-4723-8c7a-08dce759dc99
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aFdpamNBTGE5dnVkWWRwNW9wWVNyeHlscEtBWGRrMWMya3JBVlR6NUNKZWM4?=
 =?utf-8?B?R1AzWjhBWnBQMXlJSndlT1oyV2srYTliLzZQSE15YzZQeU52VmoyeW8yN1Rl?=
 =?utf-8?B?SFRmNnBlYnBTZDBUL1RHNCsvMGprUlNIaUZXdVFPc2pGTG9XM2ZVNy9yYzdX?=
 =?utf-8?B?dlFxNU9sV0ZuNTlucWUzSEVYdTc2amNxaXlVY1VQazdLcllkVEM2VGxXV2pl?=
 =?utf-8?B?VFNWZWpsUW9xL0JqSjN3UkdFRmNxTlplWnE3Ri84dk9qN0tZbXVOWEhOcUdi?=
 =?utf-8?B?WDN0WnFmbWZLZGxxakJySkl4RFZka1RFb3Y2RHVkYU5lY3ZPVGFYL0grdEM5?=
 =?utf-8?B?WXQvQmJIR09PWHlEdytaTjM3cWU4WXdYWmNvZWVvNG01dDlMYXlmSXUxanZU?=
 =?utf-8?B?TzBJeGlsUjNja0hseTZMSG1vcnlYNkdreFpiSzEwQURDNkh1Vko4QVUyL2kz?=
 =?utf-8?B?c0pXbFN0N1JIWWhYVndkTGYzandQNms3QkxIZEsyYXZqTkc5dy83NEtyZTEz?=
 =?utf-8?B?eWdZdnVWOXh3b3c2MW5pMm8zZ00reFJaYWdHR1lFMjBPR2REWVkwTGZBbnVE?=
 =?utf-8?B?MWVYVnFETVBXK3JFK3NFQ2NDSHE5VTBOMFcyVlZMZEsvcmxPYmRQRHNNVWNE?=
 =?utf-8?B?V3JJTW9sL0lhNmovRHpaNW84b0U4V2UydXk1Zm1McmFKcmhia2xUUndHSHNp?=
 =?utf-8?B?WE1EZ2Z6TGF3dGhTbXpJZjY2OS80cHJNMzAzSm9oWU5RdkVWRmhHYUF2WjJq?=
 =?utf-8?B?b3FKR1V4MEhIaTlrcDdWVm05dmEwbFJ0NEVJY3VIbS8rN0ZqeHlmcHl4ZDU1?=
 =?utf-8?B?WFZzOUtZTlFzUnAvTko5bk4vRUxZTnluUTFkNjRnRldFUExYZVY3VlNxdVR5?=
 =?utf-8?B?VlpRaXNCYTloaHFFWElRVVNwOEp3WUU5VjlOUThqYnRlN2RPZTNxSi9rRWFa?=
 =?utf-8?B?YVQ3V080bFFCSDdub3JmUGNRNUtha2xCdjNzSmd5M3BKMDYyNDdJUFpQL2Mw?=
 =?utf-8?B?d21jUG9XKyszejZKR0V2RlpTMHhFdXhlZTJCY2E2RmZYdVZFbVJaaUhRalAv?=
 =?utf-8?B?aUg2eTljWnhodWU4SWlmN3VyR1MzK2VrMHZrYkQ3Y1J5VHRudTYzdUdsbjN1?=
 =?utf-8?B?YjY1MGdPRGxJMitMNVZHaVROaGdqcFgrQXgwZlJhOGdYUitCTFFDOWFNTFZi?=
 =?utf-8?B?MDhVRUEzNjBzYTI4WmJET3pWeVRqak9EMk9HellNTnFJKzg3RXhROCtKOGRw?=
 =?utf-8?B?blJ4V2Q5UlZnZG5zdHNzZEwzTGQwblNMWEQyYi9qQ293UEVhNG9zaEtZR2lT?=
 =?utf-8?B?R282R3pwNnplVXdoM1Z2UEpxaFJVUG54VjIwT3NqcmgwWjBvMnFKNzg5RGtH?=
 =?utf-8?B?RjUzUE9vTGo0ak9ESmw2aDFjakh5aGdWOHhsYk0vSHUxOUl3NjNwNDl2QndS?=
 =?utf-8?B?UHFJWU45YWxFRmhRZXE0UHFjRENLNFNmWEN4TkFtQWlSbjdDditUR3QvZzE3?=
 =?utf-8?B?Sld0M1RSTDAzMklOVVlmOGxRK1RiN0lkVFRTQTRPN2t3cHliTlVoQzdWZFRx?=
 =?utf-8?B?NnJheWRhQ0VHYmZvTWlwbXlZZVdqUlRPNnZ5YWpEaVhPMXMwWXJURkJZV09H?=
 =?utf-8?B?SWpqVEd5T1l6ZENlcnVJdFZwT2hZajk0cmxNbHF2Z0lzQjhYQldsamU2RUd0?=
 =?utf-8?B?SFB3RjRoMkRocS80SUhVaTczWG1zVjd3QzBVejBWdnVWd1A1NnBYa2xyYjRw?=
 =?utf-8?Q?vah/QYOxVH+/36tNj8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vk9PQ20rczc0b3FCZzZKWnZETTZ4SHBTd1RUdUFpdVlQblBMRVJ4SW51RGdr?=
 =?utf-8?B?bWF4ZEIwUy9QRWpObEdmNklsOXlXcTdBYWFYZXRqZTBBWitLM3pYYlRHWnRY?=
 =?utf-8?B?U2tHbm92dDhDa2srZ3FNZkNDTVFUNlVUaE9zNUdWZjE5TU83WVBEYWtZMFZT?=
 =?utf-8?B?ZHBQUWZEV3JGV05hT21kUm44ZXlaZGpBdE05MjkyMVF4cWxhd1B3czBnOExq?=
 =?utf-8?B?RzYwdHg3MFQ5RVMrVTB4OXhpVFJsU3NYR2Z4ckJENEFSUHR1bnNueDJtUkt1?=
 =?utf-8?B?TFk3bDkrbnRwOVZKeDVJaGpiKys5N1RpT0p6cWhxWnVpMG0xT3ZBclpRT1FN?=
 =?utf-8?B?NDhIUUpPTUN0UFhyZkc2T2pTK1JTL1k5Smwza3pLaXJXVTludzAzNytGTWtT?=
 =?utf-8?B?dlNoRHBaUlc5b2tzL0lpMUNUaGRTbDN5OVJHTkg4Mmt3dDVsdXgreS8rdTZT?=
 =?utf-8?B?UkI4dGE0Q3FqNmJ5K2JZMkZnbXdFcGJCVmIwQkxoWk56Vzh5Zm00clFKNGNx?=
 =?utf-8?B?YTVwWkh6T1huY1M1SzJQSkZhVU9VT0xVdEJ4Y0dDbWlUb1pPdTFKN2ZoeHRL?=
 =?utf-8?B?WGh5NTZDeXpoNEtKTUdoaHE5bFpFSHB2UVUreEliNEZHazE1MHlDVUZqR1BH?=
 =?utf-8?B?SkFwcHB3NlFhMEExWm1GOE5sN3I4c2IrRUc1UWR5VXRwUjFWK3Y2ejJXSWY2?=
 =?utf-8?B?ZnBLTlFxK0dFMW9IbFFpQ2FDZGsyOVRSczBtWEIyUnJQRktmN05XYXZ1N0du?=
 =?utf-8?B?RnVZeHgvN1owZkswZnM0VWliM3RxUmFtWkZmR2VWbzJ3cS9GMFNnaXEvTlR3?=
 =?utf-8?B?Q0o0K1BnV1pNL3J4bEc3ZVNUTWFtMHR4OXBvT2c2R0ZDN2R2ZXRNdUFsRDNQ?=
 =?utf-8?B?cExBZ252Ti9EMjNJZ2gwTm41RWpXZGNJcXBoenVKOTFsWVpRSmhpb3dRSTgr?=
 =?utf-8?B?Tk5pQzdpT3Z0WCtJN1VMaC9lVSs2SWpVdDBUc24yQm1UWkNONXRpZGF6bFRN?=
 =?utf-8?B?bk45MS8wUllwaXlRNCtEdFBLVFdkN085SHJmTFhrZFppNDhCdk5UUmtrM2pZ?=
 =?utf-8?B?cnZxSTVRdkJWcXNRU3BKTUdNT3dnOENSUnlYNlVyV3A4U2RxVnNYL3JoVG51?=
 =?utf-8?B?MTBjUTZ0MURTV2tMM3RUTnJ4YlFjakVPOHBXeHd6ZW5TM3IrNDY0anFPNnor?=
 =?utf-8?B?djBSUE9YeXJNZ0VmSzQxRXgzVjN4cDNwVkFldG5tRXZFanpxRVBUNmttZkg4?=
 =?utf-8?B?ZzFBcTdNNlpTYkJpRXNUa01EaXZxQ2NmNUg5eVpuYmpkWHRqWjlnSlcwUWF6?=
 =?utf-8?B?SC96QVZ1czFKY1JwbEtwSE54d0hiSE50Rk5mWFRvR2tZcklZaEhwc29LZ2pI?=
 =?utf-8?B?MnVCVXoyMzZYSTJkV2xhajlDTjA5LzNsVGwrN3NOeDY0TWUrZm1pY1BvSTdq?=
 =?utf-8?B?OVZzalk1d000UFFCekxQdloxVEZ3TkhxeThvTFg0Umg0UnE4VHEwSm1PbWJQ?=
 =?utf-8?B?QjhObUc2a0NERHRjVkphVUN1UGdySFZ6TVZxWVJjc0VLT0IyOEZEano4UHpR?=
 =?utf-8?B?eDE4Y2hjR2Z1Ly95SWJjb2ZrMlZMM0RLWVJuNlhwUGN4bWtJeHhLQkdyTGlu?=
 =?utf-8?B?S3UrbWU3cUFZOFNONDBJZkR1dDQ3ZnRCdndXRVAxaGFqRmt3KzhMbkhtbmhE?=
 =?utf-8?B?cVkyNjFOS3Q2ekJDRncyTGdUWFpybFdHbzgwYTM1MWVFTkFoYy83MDZXSE0x?=
 =?utf-8?B?ZHF0VUFDa2RPSVdpMHBYelV1eXNMQ3NoUUordktGbVhaYnlJYUUvcDlmVEN4?=
 =?utf-8?B?VklsVEZWR2RJVXNOWExsa1FmOTRKUElNUndBNnZlcmRLc3dUZlpSZHpHclJE?=
 =?utf-8?B?NmRSczVZY3FLM0tCL3Ayd1pKTFdza2d2eTJCbzRTTFRoUjY5dHNUTGZWbXpD?=
 =?utf-8?B?WGI3RS9hRGlpWWpBQlVjYUVjeTh3WDFOak5KUVhnOFJId3kyZFFzaExIcnpR?=
 =?utf-8?B?SkdnWXYySWYyZDNjRTBiQkVUZVVOSnBPeC9aVTNVTzh2aHJrUlpheDB6ZURo?=
 =?utf-8?B?SmNBU0kxeWxkMnp1cER2Z2dkV3JFNFUrQWFabyt6K0hpc1Awc1IxbnpQZGZr?=
 =?utf-8?B?THhybU5JUzlhcUN4OTRmY1owWHJ1ZUZQYnJXOUNESUYwWjlvSUZ4UTQ3RU5h?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <602EB5F16243F647AC0C453B0BE7782D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e11ce8-29d8-4723-8c7a-08dce759dc99
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 05:27:11.8310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 450AaPXuq6s+vlgPRca2Ojdgoz1egBNwNHmtNJ9Q72WkMNwYZZSVUUeth9haRuzWR3g6CIm6xeHDm8dlYQpJpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8485
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDI0LTEwLTA2IGF0IDIzOjM2ICswODAwLCBLb2JhSyB3cm90ZToKPiBGcm9tOiBr
b2JhayA8a29iYWtAbnZpZGlhLmNvbT4KPiAKPiBQUk1UIG5lZWRzIHRvIGZpbmQgdGhlIGNvcnJl
Y3QgdHlwZSBvZiBibG9jayB0bwo+IHRyYW5zbGF0ZSB0aGUgUEEtVkEgbWFwcGluZyBmb3IgRUZJ
IHJ1bnRpbWUgc2VydmljZXMuCj4gCj4gVGhlIGlzc3VlIGFyaXNlcyBiZWNhdXNlIHRoZSBQUk1U
IGlzIGZpbmRpbmcgYSBibG9jayBvZgo+IHR5cGUgRUZJX0NPTlZFTlRJT05BTF9NRU1PUlksIHdo
aWNoIGlzIG5vdCBhcHByb3ByaWF0ZSBmb3IKPiBydW50aW1lIHNlcnZpY2VzIGFzIGRlc2NyaWJl
ZCBpbiBTZWN0aW9uIDIuMi4yIChSdW50aW1lCj4gU2VydmljZXMpIG9mIHRoZSBVRUZJIFNwZWNp
ZmljYXRpb24gWzFdLiBTaW5jZSB0aGUgUFJNIGhhbmRsZXIgaXMKPiBhIHR5cGUgb2YgcnVudGlt
ZSBzZXJ2aWNlLCB0aGlzIGNhdXNlcyBhbiBleGNlcHRpb24KPiB3aGVuIHRoZSBQUk0gaGFuZGxl
ciBpcyBjYWxsZWQuCj4gCj4gwqDCoMKgIFtGaXJtd2FyZSBCdWddOiBVbmFibGUgdG8gaGFuZGxl
IHBhZ2luZyByZXF1ZXN0IGluIEVGSSBydW50aW1lCj4gc2VydmljZQo+IMKgwqDCoCBXQVJOSU5H
OiBDUFU6IDIyIFBJRDogNDMzMCBhdCBkcml2ZXJzL2Zpcm13YXJlL2VmaS9ydW50aW1lLQo+IHdy
YXBwZXJzLmM6MzQxCj4gwqDCoMKgwqDCoMKgwqAgX19lZmlfcXVldWVfd29yaysweDExYy8weDE3
MAo+IMKgwqDCoCBDYWxsIHRyYWNlOgo+IMKgwqDCoMKgwqAgX19lZmlfcXVldWVfd29yaysweDEx
Yy8weDE3MAo+IMKgwqDCoMKgwqAgZWZpX2NhbGxfYWNwaV9wcm1faGFuZGxlcisweDY4LzB4ZDAK
PiDCoMKgwqDCoMKgIGFjcGlfcGxhdGZvcm1ydF9zcGFjZV9oYW5kbGVyKzB4MTk4LzB4MjU4Cj4g
wqDCoMKgwqDCoCBhY3BpX2V2X2FkZHJlc3Nfc3BhY2VfZGlzcGF0Y2grMHgxNDQvMHgzODgKPiDC
oMKgwqDCoMKgIGFjcGlfZXhfYWNjZXNzX3JlZ2lvbisweDljLzB4MTE4Cj4gwqDCoMKgwqDCoCBh
Y3BpX2V4X3dyaXRlX3NlcmlhbF9idXMrMHhjNC8weDIxOAo+IMKgwqDCoMKgwqAgYWNwaV9leF93
cml0ZV9kYXRhX3RvX2ZpZWxkKzB4MTY4LzB4MjE4Cj4gwqDCoMKgwqDCoCBhY3BpX2V4X3N0b3Jl
X29iamVjdF90b19ub2RlKzB4MWE4LzB4MjU4Cj4gwqDCoMKgwqDCoCBhY3BpX2V4X3N0b3JlKzB4
ZWMvMHgzMzAKPiDCoMKgwqDCoMKgIGFjcGlfZXhfb3Bjb2RlXzFBXzFUXzFSKzB4MTVjLzB4NjE4
Cj4gwqDCoMKgwqDCoCBhY3BpX2RzX2V4ZWNfZW5kX29wKzB4Mjc0LzB4NTQ4Cj4gwqDCoMKgwqDC
oCBhY3BpX3BzX3BhcnNlX2xvb3ArMHgxMGMvMHg2YjgKPiDCoMKgwqDCoMKgIGFjcGlfcHNfcGFy
c2VfYW1sKzB4MTQwLzB4M2IwCj4gwqDCoMKgwqDCoCBhY3BpX3BzX2V4ZWN1dGVfbWV0aG9kKzB4
MTJjLzB4MmEwCj4gwqDCoMKgwqDCoCBhY3BpX25zX2V2YWx1YXRlKzB4MjEwLzB4MzEwCj4gwqDC
oMKgwqDCoCBhY3BpX2V2YWx1YXRlX29iamVjdCsweDE3OC8weDM1OAo+IMKgwqDCoMKgwqAgYWNw
aV9wcm9jX3dyaXRlKzB4MWE4LzB4OGEwIFthY3BpX2NhbGxdCj4gwqDCoMKgwqDCoCBwcm9jX3Jl
Z193cml0ZSsweGNjLzB4MTUwCj4gwqDCoMKgwqDCoCB2ZnNfd3JpdGUrMHhkOC8weDM4MAo+IMKg
wqDCoMKgwqAga3N5c193cml0ZSsweDcwLzB4MTIwCj4gwqDCoMKgwqDCoCBfX2FybTY0X3N5c193
cml0ZSsweDI0LzB4NDgKPiDCoMKgwqDCoMKgIGludm9rZV9zeXNjYWxsLmNvbnN0cHJvcC4wKzB4
ODAvMHhmOAo+IMKgwqDCoMKgwqAgZG9fZWwwX3N2YysweDUwLzB4MTEwCj4gwqDCoMKgwqDCoCBl
bDBfc3ZjKzB4NDgvMHgxZDAKPiDCoMKgwqDCoMKgIGVsMHRfNjRfc3luY19oYW5kbGVyKzB4MTVj
LzB4MTc4Cj4gwqDCoMKgwqDCoCBlbDB0XzY0X3N5bmMrMHgxYTgvMHgxYjAKPiAKPiBGaW5kIGEg
YmxvY2sgd2l0aCBzcGVjaWZpYyB0eXBlIHRvIGZpeCB0aGlzLgo+IHBybXQgZmluZCBhIGJsb2Nr
IHdpdGggRUZJX1JVTlRJTUVfU0VSVklDRVNfREFUQSBmb3IgcHJtIGhhbmRsZXIgYW5kCj4gZmlu
ZCBhIGJsb2NrIHdpdGggRUZJX1JVTlRJTUVfU0VSVklDRVNfQ09ERSBmb3IgcHJtIGNvbnRleHQu
Cj4gSWYgbm8gc3VpdGFibGUgYmxvY2sgaXMgZm91bmQsIGEgd2FybmluZyBtZXNzYWdlIHdpbGwg
YmUgcHJvbXB0ZWQKPiBidXQgdGhlIHByb2NlZHVlIGNvbnRpbnVlcyB0byBtYW5hZ2UgdGhlIG5l
eHQgcHJtIGhhbmRsZXIuCj4gSG93ZXZlciwgaWYgdGhlIHBybSBoYW5kbGVyIGlzIGFjdHVsbGF5
IGNhbGxlZCB3aXRob3V0IHByb3Blcgo+IGFsbG9jYXRpb24sCj4gaXQgd291bGQgcmVzdWx0IGlu
IGEgZmFpbHVyZSBkdXJpbmcgZXJyb3IgaGFuZGxpbmcuCj4gCj4gQnkgdXNpbmcgdGhlIGNvcnJl
Y3QgbWVtb3J5IHR5cGVzIGZvciBydW50aW1lIHNlcnZpY2VzLAo+IEVuc3VyZSB0aGF0IHRoZSBQ
Uk0gaGFuZGxlciBhbmQgdGhlIGNvbnRleHQgYXJlCj4gcHJvcGVybHkgbWFwcGVkIGluIHRoZSB2
aXJ0dWFsIGFkZHJlc3Mgc3BhY2UgZHVyaW5nIHJ1bnRpbWUsCj4gcHJldmVudGluZyB0aGUgcGFn
aW5nIHJlcXVlc3QgZXJyb3IuCj4gCj4gWzFdCj4gaHR0cHM6Ly91ZWZpLm9yZy9zaXRlcy9kZWZh
dWx0L2ZpbGVzL3Jlc291cmNlcy9VRUZJX1NwZWNfMl8xMF9BdWcyOS5wZGYKPiBGaXhlczogY2Vm
YzdjYTQ2MjM1ICgiQUNQSTogUFJNOiBpbXBsZW1lbnQgT3BlcmF0aW9uUmVnaW9uIGhhbmRsZXIK
PiBmb3IgdGhlIFBsYXRmb3JtUnRNZWNoYW5pc20gc3VidHlwZSIpCj4gU2lnbmVkLW9mZi1ieTog
S29iYSBLbyA8a29iYWtAbnZpZGlhLmNvbT4KPiBSZXZpZXdlZC1ieTogTWF0dGhldyBSLiBPY2hz
IDxtb2Noc0BudmlkaWEuY29tPgoKClJldmlld2VkLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0Bp
bnRlbC5jb20+CgotcnVpCgoKPiAtLS0KPiBWMjoKPiAxLiBmb3JtYXQgdGhlIGNoYW5nZWxvZyBh
bmQgYWRkIG1vcmUgYWJvdXQgZXJyb3IgaGFuZGxpbmcuCj4gMi4gcmVwbGFjZSBnb3RvCj4gVjM6
IFdhcm4gaWYgcGFydHMgb2YgaGFuZGxlciBhcmUgbWlzc2VkIGR1cmluZyB2YS1wYSB0cmFuc2xh
dGluZy4KPiBWNDogRml4IHRoZSAwZGF5Cj4gVjU6IEZpeCB0eXBvIGFuZCBwcl93YXJuIHdhcm5p
bmcKPiBWNjogdXNlIEVGSV9NT01PRVJZX1JVTlRJTUUgdG8gZmluZCBibG9jayBhbmQgc3BsaXQg
Z290byByZWZhY3RvciBhcwo+IGEgc2luZ2xlCj4gcGF0Y2gKPiAtLS0KPiDCoGRyaXZlcnMvYWNw
aS9wcm10LmMgfCAyMiArKysrKysrKysrKysrKysrKysrKystCj4gwqAxIGZpbGUgY2hhbmdlZCwg
MjEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2FjcGkvcHJtdC5jIGIvZHJpdmVycy9hY3BpL3BybXQuYwo+IGluZGV4IDFjZmFhNTk1N2FjNC4u
OTcwMjA3YmM4ZjRhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvYWNwaS9wcm10LmMKPiArKysgYi9k
cml2ZXJzL2FjcGkvcHJtdC5jCj4gQEAgLTc5LDggKzc5LDEwIEBAIHN0YXRpYyB1NjQgZWZpX3Bh
X3ZhX2xvb2t1cCh1NjQgcGEpCj4gwqDCoMKgwqDCoMKgwqDCoHU2NCBwYWdlID0gcGEgJiBQQUdF
X01BU0s7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgZm9yX2VhY2hfZWZpX21lbW9yeV9kZXNjKG1k
KSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChtZC0+cGh5c19hZGRyIDwg
cGEgJiYgcGEgPCBtZC0+cGh5c19hZGRyICsKPiBQQUdFX1NJWkUgKiBtZC0+bnVtX3BhZ2VzKQo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoKG1kLT5hdHRyaWJ1dGUgJiBFRklf
TUVNT1JZX1JVTlRJTUUpICYmCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAobWQtPnBoeXNfYWRkciA8IHBhICYmIHBhIDwgbWQtPnBoeXNfYWRkciArCj4g
UEFHRV9TSVpFICogbWQtPm51bV9wYWdlcykpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcGFfb2Zmc2V0ICsgbWQtPnZpcnRfYWRkciAr
IHBhZ2UgLSBtZC0KPiA+cGh5c19hZGRyOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqB9Cj4gwqDCoMKgwqDCoMKgwqDCoH0KPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsK
PiBAQCAtMTQ5LDggKzE1MSwyMCBAQCBhY3BpX3BhcnNlX3BybXQodW5pb24gYWNwaV9zdWJ0YWJs
ZV9oZWFkZXJzCj4gKmhlYWRlciwgY29uc3QgdW5zaWduZWQgbG9uZyBlbmQpCj4gwqAKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGd1aWRfY29weSgmdGgtPmd1aWQsIChndWlkX3Qg
KiloYW5kbGVyX2luZm8tCj4gPmhhbmRsZXJfZ3VpZCk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB0aC0+aGFuZGxlcl9hZGRyID0gKHZvaWQKPiAqKWVmaV9wYV92YV9sb29rdXAo
aGFuZGxlcl9pbmZvLT5oYW5kbGVyX2FkZHJlc3MpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBpZiAoIXRoLT5oYW5kbGVyX2FkZHIpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcl93YXJuKCJJZHg6ICVsbHUsIGZhaWxlZCB0byBmaW5k
IFZBIGZvcgo+IGhhbmRsZXJfYWRkcihHVUlEOiAlcFVMLCBQQTogJXApIiwKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjdXJf
aGFuZGxlciwgJnRoLT5ndWlkLCB0aC0KPiA+aGFuZGxlcl9hZGRyKTsKPiArCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0aC0+c3RhdGljX2RhdGFfYnVmZmVyX2FkZHIgPQo+IGVm
aV9wYV92YV9sb29rdXAoaGFuZGxlcl9pbmZvLT5zdGF0aWNfZGF0YV9idWZmZXJfYWRkcmVzcyk7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghdGgtPnN0YXRpY19kYXRhX2J1
ZmZlcl9hZGRyKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcHJfd2FybigiSWR4OiAlbGx1LCBmYWlsZWQgdG8gZmluZCBWQSBmb3IKPiBkYXRhX2FkZHIo
R1VJRDogJXBVTCwgUEE6ICVwKSIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY3VyX2hhbmRsZXIsICZ0aC0+Z3VpZCwgKHZv
aWQgKil0aC0KPiA+c3RhdGljX2RhdGFfYnVmZmVyX2FkZHIpOwo+ICsKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHRoLT5hY3BpX3BhcmFtX2J1ZmZlcl9hZGRyID0KPiBlZmlfcGFf
dmFfbG9va3VwKGhhbmRsZXJfaW5mby0+YWNwaV9wYXJhbV9idWZmZXJfYWRkcmVzcyk7Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghdGgtPmFjcGlfcGFyYW1fYnVmZmVyX2Fk
ZHIpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcl93
YXJuKCJJZHg6ICVsbHUsIGZhaWxlZCB0byBmaW5kIFZBIGZvcgo+IHBhcmFtX2FkZHIoR1VJRDog
JXBVTCwgUEE6ICVwKSIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY3VyX2hhbmRsZXIsICZ0aC0+Z3VpZCwgKHZvaWQgKil0
aC0KPiA+YWNwaV9wYXJhbV9idWZmZXJfYWRkcik7Cj4gKwo+IMKgwqDCoMKgwqDCoMKgwqB9IHdo
aWxlICgrK2N1cl9oYW5kbGVyIDwgdG0tPmhhbmRsZXJfY291bnQgJiYgKGhhbmRsZXJfaW5mbyA9
Cj4gZ2V0X25leHRfaGFuZGxlcihoYW5kbGVyX2luZm8pKSk7Cj4gwqAKPiDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIDA7Cj4gQEAgLTI3Nyw2ICsyOTEsMTIgQEAgc3RhdGljIGFjcGlfc3RhdHVzCj4g
YWNwaV9wbGF0Zm9ybXJ0X3NwYWNlX2hhbmRsZXIodTMyIGZ1bmN0aW9uLAo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKCFoYW5kbGVyIHx8ICFtb2R1bGUpCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBpbnZhbGlkX2d1aWQ7
Cj4gwqAKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKCFoYW5kbGVyLT5oYW5k
bGVyX2FkZHIgfHwgIWhhbmRsZXItCj4gPnN0YXRpY19kYXRhX2J1ZmZlcl9hZGRyIHx8Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAhaGFuZGxlci0+YWNw
aV9wYXJhbV9idWZmZXJfYWRkcikgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgYnVmZmVyLT5wcm1fc3RhdHVzID0gUFJNX0hBTkRMRVJfRVJST1I7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gQUVf
T0s7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiArCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBBQ1BJX0NPUFlfTkFNRVNFRyhjb250ZXh0LnNpZ25hdHVyZSwg
IlBSTUMiKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbnRleHQucmV2aXNp
b24gPSAweDA7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb250ZXh0LnJlc2Vy
dmVkID0gMHgwOwoK

