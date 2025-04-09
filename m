Return-Path: <linux-efi+bounces-3245-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B9BA81BFE
	for <lists+linux-efi@lfdr.de>; Wed,  9 Apr 2025 07:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC99D1B67BAC
	for <lists+linux-efi@lfdr.de>; Wed,  9 Apr 2025 05:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7711D86C3;
	Wed,  9 Apr 2025 05:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKIu+XW1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F0D1B6CE0;
	Wed,  9 Apr 2025 05:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744174874; cv=fail; b=bj8dYqcdGqoALpeAHYUoPnw77izLrlxTESCbBfJW60poKvKOsV9YFROPzEK/AIGxX+KQzdqAjO0ZYUWIit+kH9NDIXGFi/+xm9CPVwAyBCXCy9odSOFHBjyOAVXA84Swmmzr6qkVCifZt4CjOko10YrhH8+B0FQw+nV1g9yjLuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744174874; c=relaxed/simple;
	bh=OLyyJiGdt0H2K7BAu+Y4gNuDFaxHV2PECXXZM1Ut30k=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Psu1MnOplwM138Wh4axjRZ+Hf/ActiMO7XxgkBOiX3YTNjNpx784yjJGLqT99k5nTyRaiJLiZKZebLXfumGmTOQQE02BKWLgzgcv5JN6u+xVJFDdCUX23p9bZK9rLQrWHvN4UgIMcG4DqszWO3u8K4HE+8hoc+yX93xJBCg0HcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JKIu+XW1; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744174873; x=1775710873;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=OLyyJiGdt0H2K7BAu+Y4gNuDFaxHV2PECXXZM1Ut30k=;
  b=JKIu+XW1QpIyiQEgsnFabfwdyIeGVVYm/u/fbuGFazuAqcGsCmAklc4W
   ssvQTbNnD8S4PBJNnkJh42+FIh28YHCu8Tp20ODUw+IMzdP9CEfSL3t2p
   z0z7ZPqLj/fkZYCH6g0zFPXmWUHCpvBAfSpg/vXc5tMwHKw82C56Js37e
   +1L0ukEW+XI0UDAL9HEt4bht/raMsnXDp6m6+zTlcJ72SoUJq8ZqYHpcp
   06IvoIDVSvy1SiBKIDHLGWgB/6tZJyIcyHFd/fIgdMao4ym3HaKjRYYyw
   P8jOhg05RaS8BjDLvOfjGkYcY63HVuogeeH8Osa74XkEXypgBvbYmD/Bg
   w==;
X-CSE-ConnectionGUID: Z/daIDIKQf2imNom+GFbPg==
X-CSE-MsgGUID: BvTJa7gwTFqNyxrbXZEyJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="68111484"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="68111484"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 22:01:12 -0700
X-CSE-ConnectionGUID: BpfQ3jG9SoeupyunMVeWKg==
X-CSE-MsgGUID: UIZrQ2EPSwWPklzSDW+HXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="128320547"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2025 22:01:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Apr 2025 22:01:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 22:01:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 22:01:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOX2IFXjHomcX8wqYomPWN4ocXrbi9HCFLWAyj71SSC8yz103Qp3ts5SUW1C5mXBWXGhD/MQEAcbxDMTSq4k9PXoZtXVvyfXZOlLVb5Sb6qUUMatw5JhK/7UG49i8zexmjzQZr8wGpK6Ut391E/CAsBrJ5xeCW0dogr8PdKMx4r2E8pfiPqTF0qPwBWWYcXDMs2hd2siIG3Zs0bYeSZ+VxKcWmoEb4quxWKIfxhRCSPDCYgphEwjvNnqHPS9rCnmJaeRlZA79KP0PBo8HslspWkInC9UyKAimRYwfidZdCRIXk1HUny475PGSXaUQlKXHd7KbsVMrIN6hBFdLxMj0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLyyJiGdt0H2K7BAu+Y4gNuDFaxHV2PECXXZM1Ut30k=;
 b=PWPYLDZjMmDX7pgwxg4TOYO2OlABPMmjmpeqitcqCmCNo1yW3qcE0OVEYd8aeNDZaoJIcfYDazo94+zJ8a6Qld6PDRWSbkI/Z2qOZe/Coes3qg7D5Hq+qLT5reLbLneCrRpYRw0Rc24Gqme1fgvfMtxnT5vPqGWl8m/USErmyZyukybq0N6bxF/c3eSLfHuUm6mXceC5LAR+WKxjZhsx8nupuOU+eIuPr43NbwecR4YRVRUcaV3ZIr7zzAEcGaP7ORrupfZnaSfDH06JmWiH/HsAjDJ/jNzqFbYM78dLHCpCmQi3xG2rNVYNV9dUa45gTrarcko+pHfFH8M/moWXqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by PH8PR11MB6609.namprd11.prod.outlook.com (2603:10b6:510:1cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 05:01:06 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 05:01:06 +0000
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
To: "ardb@kernel.org" <ardb@kernel.org>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, "Saarinen, Jani" <jani.saarinen@intel.com>,
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "De Marchi, Lucas"
	<lucas.demarchi@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Build Failure on linux-next (next-20250407)
Thread-Topic: Build Failure on linux-next (next-20250407)
Thread-Index: AdupC4+navdR5MT6QjyjwFwBvkRUbg==
Date: Wed, 9 Apr 2025 05:01:06 +0000
Message-ID: <SJ1PR11MB6129DE70566C6FB5E73400C7B9B42@SJ1PR11MB6129.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6129:EE_|PH8PR11MB6609:EE_
x-ms-office365-filtering-correlation-id: 10bd588b-0b8a-41d3-aaa2-08dd77238900
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?az3gLTIdHDEADDFcdKyZPgGrUdvCGdImMCrM3ebQaEuO2uDUIaHPePIZAm?=
 =?iso-8859-1?Q?IniorLJR9Z81miZ+JlqxQiNs8II8tsWZZJ0QcjajTnVXePTQnKvVt6ptcU?=
 =?iso-8859-1?Q?g2XAaGZDY8dmnKcGkQAAmz+Gjva0/geQHM5E4vXgbgN1K+2gfcC2oSTf5H?=
 =?iso-8859-1?Q?3378pa8KHN3F+Wvg7c+vDjCnxvX+qKHDleTwGhBSWHQlLFBRVX1nwyeEDB?=
 =?iso-8859-1?Q?wTv9z8YEki/8x8VQwEDEqCgi1fbqVmGs0m2KpYL69PV5SLZfdPXEAWN02q?=
 =?iso-8859-1?Q?pP2tkxPpCfelfZxQhMYlfjFS2EjMi11q+F+r9rBkncNhZ//8HCUzbS1kAI?=
 =?iso-8859-1?Q?Vsrdv2pcrKJyf8GgfoYYSDOF4Y0PhIZldSKavAjKSiya6rHc8RAXnsYu6F?=
 =?iso-8859-1?Q?P5Y7TswvDodaa0nMdfaI9Dv+GkT2kuKMwxD/vuAa7Y9NDv77ZVYm823MB8?=
 =?iso-8859-1?Q?v+Ij/oz7Y87ZGD9i6Rp8wUdi66163pbqz65Uad0rx5HirpehDumyhk8OAU?=
 =?iso-8859-1?Q?OtgkUnp0FGtka7/ZpZSmVTRbTHVPF89tw4wLp5Cg48DY1LC5sW/+jrHK6e?=
 =?iso-8859-1?Q?WV72uswhZK9/yk8tTEfZYewuAgL+9e6ila710MBgv5kVfANfGMRwcMvNCU?=
 =?iso-8859-1?Q?gPxTm+G3GuYJOKE/dimFw3ZRWd/fJhxY8Sk+TfXhI0UQSz8vCGzpUE7I7m?=
 =?iso-8859-1?Q?bVNxAyMmQm7aq0lytSickIET7k/Ju51SWF1w5nRzEcEor4rXhWtz4WUGq1?=
 =?iso-8859-1?Q?gG9kUmzaxxNCpn3ALu6F/xYeYRXALPmjVBkvy4iJznKG5h3SIGq82FxU9y?=
 =?iso-8859-1?Q?mEEhG969Q5uSrZP3qEHO4qmEGHfHc1JR33Jr0I4IxAr/TDl59CVaya70BV?=
 =?iso-8859-1?Q?/re45OGAmdNPMgpYzSvSXh2eSl6BfzDQrqgcUCGbk56YdACW967/rgGi/m?=
 =?iso-8859-1?Q?IbieXbYUXTsWi1LvEO/abvaLnnMFnlIeBH8OAXGafnS6G1UqpksyDaHreI?=
 =?iso-8859-1?Q?zZQ+1gWZh1os8iW2R0SNfCzGijG3gJF9cCwqM+kaTghlsWohIGiEQWLnLG?=
 =?iso-8859-1?Q?6UmCKb8nk7rRZUc9qf2bv1GgaBRF6FM6WiB1AlnfMF05DVQjIms+bbypdC?=
 =?iso-8859-1?Q?AG57qgkgtU04s+MxsWFWjirTMEmFMMDZrvZJfQy/hkFp80QMeA9gVHjmRv?=
 =?iso-8859-1?Q?ybI3CJocLw6Pt7osyzgNH4CNGlMLmxNe9xzKPMtzeJb65lasOaKyLRwXow?=
 =?iso-8859-1?Q?B7AMQmP1U/s5OF+A5gQOesT8mIVcOrdN/gctCbw5GB3iPgu56HQcdI9t/C?=
 =?iso-8859-1?Q?1WcLEN4xOLSPQf6AQi71QQVZdaMpwDNRXAvv5c/JIvovo8ZFc41t1ad8pK?=
 =?iso-8859-1?Q?FIUFL5Y6dR077YNA+WWdXUgSr1sv/CTZWxunAC6qJFQi7vYvrwTJa+JZSG?=
 =?iso-8859-1?Q?6Gt0VB5tSG3+/C9QV4EWPZvQ9TpuIP9cWOXsuA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6129.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5Wvc8zg5Uzt12pkZuaIFGwSGr28E/nmBNZ7Lr3h5XIDgqhfE3s7GPWiyS1?=
 =?iso-8859-1?Q?zJ3SW1lhb4BaD7XVy0alA6rCZGUkgZdAbHDCYctezqXdTjqqn0F9cbfPt/?=
 =?iso-8859-1?Q?haIVpyw0UIWhXz80ok8F6+kWCUkG6snP/lkC5USfZ1sSfcEaRM671yd5M3?=
 =?iso-8859-1?Q?gReXe8qegTCm7b41ULlyXji8dG46tNIltv0UK9TiT085V2MA2c6GnGTHGi?=
 =?iso-8859-1?Q?WWkXdxqBl6MfakVJZsNAg1z+Rs39Z89ZoqgHUosl4TbNHgKXGN/ettpqWX?=
 =?iso-8859-1?Q?ZFSAtm56WKxiUvAzUUazJaDbca9+FV8tdRdUoe2WUJjq0CztLAQsFlUUaC?=
 =?iso-8859-1?Q?sA8jibbTkroZmwj8gm2WIgg0bBt/ll9g5UdTZwFNhZbSlrv0SHaPAAqsWz?=
 =?iso-8859-1?Q?unGhBbWfI/Qd8b998Eyr/0K4frOuP7Fngf/dj5+jXOTe//shp8pTVl0ei0?=
 =?iso-8859-1?Q?ekzFIDSOzMd5fcH9qri8JGubRnPjeUF8+4UQMmEHtPofmGDmo5an2X5aoH?=
 =?iso-8859-1?Q?10Qt3nsMSxeygIEqamt70leX5r6/5OrR0U4o3wz554jTv/heBj2piuMy9A?=
 =?iso-8859-1?Q?MjHOmZ77VL75v809uC+2YBqYKdWXjQ9bhSK/EMi9Tx9T/qC5MdteBnnPCt?=
 =?iso-8859-1?Q?uqjOAtAkNKHwo4Z1PJ3zkrqxuF8S5vIz5eGTRJbc2gDm9EqAEBLAWz3Wb9?=
 =?iso-8859-1?Q?PmaODSJcXEYfSGT/S7dmeeH9qDwAbHmgUj51ayFV/KhxZCZe1rSi14x67f?=
 =?iso-8859-1?Q?KlKDUX647zAziIUgUBAgyzF/hnzcpLjpNeMySPv3XecQrUgwrX4CjYQffW?=
 =?iso-8859-1?Q?F6FCp69FiWiJ27k5QvaLrl7QNumiJUKyOvwYTF2AWRglS/3CctlMMGo6oh?=
 =?iso-8859-1?Q?o/BlUfU7JTCXHoNWjXkpsi91FEiX4r82L9ZrJckqF4TzHDJQGmLL8Xn2d8?=
 =?iso-8859-1?Q?ho0alsAKJBG+LMv02DiJrdake1LBUfKLzWiFOie27r9XjobSaOHSbamIPJ?=
 =?iso-8859-1?Q?UA2nAlWb3MQCBMFhInryYcbLeGtqTqeaHDle/lDxhABdD5wSBDDnlkI7jP?=
 =?iso-8859-1?Q?jJXjQwH5UjDmzmT6dFqGngFU2PK2jLkowvZAYqy+euCXhhHK6TCbU95oRV?=
 =?iso-8859-1?Q?9+yW1lM0PR1PMrUVTfQWe9f7e1RsoAnSC2LYjspS7cWc/7XMD05vIBW/8+?=
 =?iso-8859-1?Q?RBuAppHypj3ju+lr0Qdx2fdHB8dO9HBp+/1iqu0IeyhA3Bh8YxttXQx78Y?=
 =?iso-8859-1?Q?29XBLi8oxCklOtIBzckLMgdsn9nsfvsuwoYmbeDi6uMdrlt7AUY9Jy6Bre?=
 =?iso-8859-1?Q?wB4Ulvffyfhi0RzW8khO+4E+Z/s2p2LFCotKPEzRVX2kSTlL81e9zQYokT?=
 =?iso-8859-1?Q?ME0zhsnTR2rsMEe/uefJop51VfGiN5aGvgrLF96HdeAfCib1JyZJ+Zcnap?=
 =?iso-8859-1?Q?P3smZ+QL48vhvqEpVeFGcU68MJ1FtXkwljNHmbEbrlcj9xfY9BfCOZss/2?=
 =?iso-8859-1?Q?0bfrZPLgI0tASTcv633c6e3CCCaota8YZKf0D6UgjRi0irVBFfmWwK5igy?=
 =?iso-8859-1?Q?U1vJSgnEbWquk3q9k0bBmBLNCV06VVTtqEFy4eyyaVZHkPjrPZ4+i8jpu2?=
 =?iso-8859-1?Q?ZfEy739LVmAU02tF0eheKMnXPXS0XcIz4VLwYPuO1855YdHPgnIJYb9Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10bd588b-0b8a-41d3-aaa2-08dd77238900
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 05:01:06.2037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9NDlMaYs6OJfEpoCqbNSGXfz0DsBGhUzvtPKmiymC+VWdch7WKCa+Nj6mdW8i82QsrKtxlJuId5PubdY3fCHioyvjwA5JpMrB7bLIHVowuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6609
X-OriginatorOrg: intel.com

Hello Ard,

Hope you are doing well. I am Chaitanya from the linux graphics team in Int=
el.

This mail is regarding a build failure we are seeing in our CI runs[1] on l=
inux-next repository.

Since the version next-20250407[2], we are seeing the following build error=
.

```````````````````````````````````````````````````````````````````````````=
``````
CALL=A0=A0=A0 scripts/checksyscalls.sh
=A0 DESCEND objtool
=A0 INSTALL libsubcmd_headers
=A0 AS=A0=A0=A0=A0=A0 arch/x86/boot/startup/efi-mixed.o
arch/x86/boot/startup/efi-mixed.o: error: objtool: efi64_stub_entry(): can'=
t find starting instruction
make[3]: *** [scripts/Makefile.build:335: arch/x86/boot/startup/efi-mixed.o=
] Error 255
make[3]: *** Deleting file 'arch/x86/boot/startup/efi-mixed.o'
make[2]: *** [scripts/Makefile.build:461: arch/x86/boot/startup] Error 2
make[1]: *** [/home/kbuild2/kernel/Makefile:2006: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2
```````````````````````````````````````````````````````````````````````````=
``````

After bisecting the tree, the following patch [3] seems to be the first "ba=
d" commit

```````````````````````````````````````````````````````````````````````````=
``````````````````````````````
commit 4f2d1bbc2c92a32fd612e6c3b51832d5c1c3678e
Author: Ard Biesheuvel mailto:ardb@kernel.org
Date:=A0=A0 Tue Apr 1 15:34:20 2025 +0200

=A0=A0=A0 x86/boot: Move the EFI mixed mode startup code back under arch/x8=
6, into startup/
```````````````````````````````````````````````````````````````````````````=
``````````````````````````````

We also verified that if we revert the patch the issue is not seen.

Another observation is that build passes when run on "Ubuntu 20.04", in con=
trast our CI systems uses "Ubuntu 24.04".

Could you please check why the patch causes this regression and provide a f=
ix if necessary?

Thank you.

Regards

Chaitanya

[1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20250407=20
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20250407&id=3D4f2d1bbc2c92a32fd612e6c3b51832d5c1c3678e


