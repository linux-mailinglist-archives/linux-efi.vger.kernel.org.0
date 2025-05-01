Return-Path: <linux-efi+bounces-3516-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02058AA59B5
	for <lists+linux-efi@lfdr.de>; Thu,  1 May 2025 04:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D0407ACC49
	for <lists+linux-efi@lfdr.de>; Thu,  1 May 2025 02:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9201EDA02;
	Thu,  1 May 2025 02:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="e18jDyPp"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2104.outbound.protection.outlook.com [40.92.19.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8E0182B7;
	Thu,  1 May 2025 02:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746066968; cv=fail; b=mvIt/ibzj8e2uqwaMLEVHAJiLfj0qKAe9Nj2dB9pzCtF2DAXY3OIv8G1pYE4e/aXr31GRGI07QFrPIZTtD4aBT3Onk4nsndDeddGafJFpYOBZknZTKOVl0nWQKNhdU6WpKz2EPXb7x8sgGE1jyAgSXfTY3wccYRO4kRGqGjDtW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746066968; c=relaxed/simple;
	bh=FPn+GIcUZNPgnaW7VUId+m0fP8aCfMucU3otKcdXc+g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aWZpWjomH7ZYuc7qfA+7tibO6kQQFSgNwYfQ4+NE+wKCXPZyRx2YDC10vXN8NQE46il4gl7+xnUwv4O/tUf5BLdwwaFoqOwLDYwqSxjmAlJwSkSubNzxhFuEN732OnJNomdbXa2u3kd+53oCTk3F1dj8Y/luIN+QoJCkDsAtyQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=e18jDyPp; arc=fail smtp.client-ip=40.92.19.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEtiMkzNvqSguCbmPLOT7rq8ygtANnufrmTdP+/FmxPuEGsKWWHJnLe4IwL0Am86ISn+ulYdaJ1n5ZpUxdt2Y+OYfhjTU7Oaor9+nw0Sqf4CDa3u5Tbw0OkbjWhpj7+t25nz3I6c3+iP/zJQCh71AzkBzd0XsiH/YycSwvmqww4g4xdpsXZe2LIifSRv/SkeM6ymvTVZoXP0Z657jWvT5Pv6ZhaGSPXLGZAkZQ3CHpDwHFNXyZvVpsHaDCrcWfeD7GVIghXnMRh7CrL6yMg/oPHIzEcQwfwl+H2tSBQ3n/XkO8c1I7Mf42qEM/f73HgG/QEjasQFxoTkXwOUfJe8/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOQxgja8pLc8uD4WLV/2Q5gnjfnoJZrwTKZdgQkYvGo=;
 b=T0lstZkNmHpo8TEktnmYuyW9bljvwnWarhJrsuB0uBVePkjNynE940O/SJ9I9WLY+G77yur8uMTAG/Snd4SN8Q2Kud6zC+JN0qzjDh8vdlPYjbQsGF11QbsNk2ykwrjVblK3UydZdgRvYKLZm0s0S+jZQw8oQcv07ruswJdZ/ngLHeKFZiFrt4m7CvCMMC09rDSISdI+De6znZZqc3GuJem6BFLtwgyV7im3GvYP3j4zeKJX9vfBnqiEACSOvb11l0Kj4pUTeCZSu3yUALBQCQoWSuPqDQbp6yi4PRV/um+wwLKS9RllTsSavGLYwv10G+FqSwo7o7Hn5M7bPowDng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOQxgja8pLc8uD4WLV/2Q5gnjfnoJZrwTKZdgQkYvGo=;
 b=e18jDyPpsvXj5C3kMIWvd5x5wO3+66TswzgGO0ULy7v3enDp5ZeWD2YMmDRVLIyIrtsw3W9dhyjUXtDkjM4YBht9WRVnSIx2z8bLEIknly4NHAu840aYznOpTozMiZmdjQ0rK/nT4sliLmDC3ajktRDSmC2A3qLSPCKz5ak5l/coAKtHqGsFhk/Uj993+Q6UDcJHViZIaW81QFDOHr0fYsl5+UmM4vlqWTDcHgRPAmFS2vUIz0bo9hRsiqp7pCOY7DQHDpOCSTDp8CHgvyy0tTGI9lasv8TA1QeuGrh3p9CNj4Z6IKsNHNSsJzHEh0D14f9//WoS+p2lnOaf+uurJA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7350.namprd02.prod.outlook.com (2603:10b6:510:1a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 02:36:00 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.008; Thu, 1 May 2025
 02:36:00 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Peter Zijlstra <peterz@infradead.org>, "x86@kernel.org" <x86@kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "ardb@kernel.org"
	<ardb@kernel.org>, "kees@kernel.org" <kees@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"samitolvanen@google.com" <samitolvanen@google.com>, "ojeda@kernel.org"
	<ojeda@kernel.org>
Subject: RE: [PATCH v2 11/13] x86,hyperv: Clean up hv_do_hypercall()
Thread-Topic: [PATCH v2 11/13] x86,hyperv: Clean up hv_do_hypercall()
Thread-Index: AQHbucNhtk1R9xG02ECXQhZM+VxrDbO9BT6A
Date: Thu, 1 May 2025 02:36:00 +0000
Message-ID:
 <SN6PR02MB4157ACEFEFE3E856CB93BC1AD4822@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250430110734.392235199@infradead.org>
 <20250430112350.225006522@infradead.org>
In-Reply-To: <20250430112350.225006522@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7350:EE_
x-ms-office365-filtering-correlation-id: ab161025-9d52-4b7a-0fbe-08dd8858e90a
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmpI8tRyoOXaSUmOkLVCBKastdec7Sl/8qoecdZ5K/B6vYUpgVrcp6pUtqWBuGLZ2frpDQH01zcvTGXbKCMcKCObmGTI3Ay9jdo9TQHyiT/RtNjior1d2qtIycZpuMrMKUVutnatvbA0gAX2nUNC+AmRStzNbLbVaHJ4mqdHpuNCTiDh1SmD89HDQ6jsP7FyH48RzAma6dmNGMqton665q9pGAF+iWVRbpxCyhr/7Fgz1YoUzpEBX11xjM4t03PeHGrhJgKoeplEwCLEYFg7pvJjXsaEMmIx4jSz/OwZA6X2NT3I4rg0bmAUMqcGYhvmxLP0+PQUKrVaksgsEtFLKaHy3OoD7MnP4T6xqCI06flsUOfueMiaCsfgb3VZCzvJVtFEF2AZenNiXb/ebaYLJbAXbrbcvDfpl1R9n2ZfHKzKia4IRTtlvdeyxuG+Cjs7riHLvo9mKufPBQtsSjf2XbjMvgeADX2SHCCbVLUos9jvSHEQYeY7/DgeambN9rYix3Ere/4TBVRNIfDHhXxFCGoXP+p+av2uzF40kXJh7AYUagYhVVBOiSocdQVcLUfsf2k8SifTKffw8+1c1C8aMp3RzAzzjPPZ/FOnF7PCPOnJS8ts+LHzGvIxIJNcE+qXnfWarFjsQDo/HaoRuj5UIrvC09y3kdO4gDkUWezGIf0szuJf3KGDxpW5l/VuKlGEIQ3LTtPMU87JswWGAj/VOz7gPc6RqCXyanbU9rVD8+6XsC9ZVh2SOnOfT6DMOPdYSG8=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|461199028|19110799003|8060799006|15080799006|3412199025|440099028|41001999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dyZtzvRF4y+YYJ7FvOCR+bCy6esL+bgf+fHohk1UCsVCbhVChq6hmr1D2CW8?=
 =?us-ascii?Q?tJxaeDBid7figiJErsGRMn5wWynPCyDpuSi9VV9D+lCB9oKXBDvE/32/gn9f?=
 =?us-ascii?Q?O0jFmxx5sa+YYc2THTdYct+0HESrLyAAPNVI/KPGs06UaGIkbJ8EsmUfVM0s?=
 =?us-ascii?Q?WuqX5cKB9nOBDiOBfv2lsppCdLU1JxUUosgGr8gcLQ0pnX0AXgCdwl+dRWXX?=
 =?us-ascii?Q?wmwNUIHmDc2pht4NzkQyEn8KVLX5BNfakSfHZn8nOM1YqYvV1ya8LlTL1A3K?=
 =?us-ascii?Q?SYhvpSX9d7UsvA/uqhhKr1bpRUwlAgkbx2/PS+8y+MGp2GN803Ff/HOoRVyk?=
 =?us-ascii?Q?KEOKLamz8nxJZB9AMP4GoNYsomZZiLYKAX7cw1ysG+G+0pdCCASVfJa5zFxg?=
 =?us-ascii?Q?wDsKj2Hy6KuPsUhFKmRz53B+j3of6y6u4Vkji6BG0zVhqIvYkWVDOMiCh0ix?=
 =?us-ascii?Q?Xt7ArGzmtWgSOk1nHWEFd9i10gVbaEmre6u3gNh2JhChMoGyoiWEUJPgtBbX?=
 =?us-ascii?Q?yyHyZzECjtGvE4rbF57vIzh6pw3m5Khstgep69GkW38r2uwWBdSkFwZKa03K?=
 =?us-ascii?Q?gkiZ9tclPaxO1qs9k9eE3Ukem+0vF38/ZxESe3tu9xZ0s3dgZV3H1XPrz9LD?=
 =?us-ascii?Q?tJ3/yKEzk8pE/kZsnMolUAimuqPAl4O1nVahx/BQfwm/h+aqyQvA2bUn7cqf?=
 =?us-ascii?Q?3P3jJXL7HaYPhFjI520nhLjmPGVGBl4br9ISHV4LykLt0yZrj3xokjudIFEH?=
 =?us-ascii?Q?eDRuZIIz6cNzu6FRfckZBQmYawUdaBcvVTQPVbz+ZoR3QaBC4zbWCNagVI/F?=
 =?us-ascii?Q?xHffsL/KYyYb4bNibiFN7MzGtK41+MnCVwSdMNHV+KnemjWtaFu+wwMILSb0?=
 =?us-ascii?Q?OEOceQrRsqG1x9TWwQ16Ud7qSun/bgNLhhP9irOiATRevYWkZ8asPM8uk532?=
 =?us-ascii?Q?aRTm5THnpkkDl9305NN/EkhIEpYqrE88JOvn7AeJ2cHVxCro7Y1cjAgUUlMm?=
 =?us-ascii?Q?j8Fy07ye8/kQDghZAf++jkYokn7NaFlfFnOYhu5TaVaLjyKrIxbW2Qpjpkg7?=
 =?us-ascii?Q?IxDk3Po+Y/caOOzhEtKGhzdzeiZSJeLvc/CdoFpbMgR07wTrQEY8uTajPWTa?=
 =?us-ascii?Q?MkES4xC8B9Cn?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YZKVEXZmD2KcNR9Vixqjk6W5bG35vtvleZejGvt/LmP+D+0Mw0Wbt7F8wN67?=
 =?us-ascii?Q?Lau2/viq9bAXHFOAfh+J0zBSN+qn75Mk1EzrS8tup/G4A7Cs1xBWBon6ObMj?=
 =?us-ascii?Q?srW6lWPK3WJ6cdWNS2ScbMI82/4VFEXq0bqPhwv3r3OpTayVP93dUNYn8ECI?=
 =?us-ascii?Q?V9jGgir1Wms3qU1dN+YjPMKBV9ZtImJZ1kY5VYQxm1WBDiCiBEpGKAk4X0yL?=
 =?us-ascii?Q?sZWKR5K9Cfbee29szuTbPgmDOUSQZzNUj+ji56/dWq+QIYXV+6oQMxSyNkOa?=
 =?us-ascii?Q?f/K51XwW3TsvZLyStykUan3edfKFD/2RZmKtUJmHYqA7rTXWNV1VxLCi0jbH?=
 =?us-ascii?Q?eTRZiYAU25E0Gm0tmP1sF7T7g8sCH8eB4HM28sCADwuXfMCIUv0rw7g/wQh1?=
 =?us-ascii?Q?hHsFKBEy+GrRV/rBbqWPGPzq7HY/8RxwG/lYzBOv4VbuGEgS3LFQLR09wWPZ?=
 =?us-ascii?Q?/6hCg49+a+oFEJ3cLNRZKzok+6IhGy/UcHz2qj3agqbixgS+ZGOmf7cd5Nq4?=
 =?us-ascii?Q?VIk15veCjnZVzeetlV74B62wsd9YA00OYVuy9oxe/p45JRFvhZiMtzeyBeVo?=
 =?us-ascii?Q?srUL6pFz/IB7n2tXX4YJNuS3U+O/sZeINaUB5k1fxn3PaPzG4ahvlyD5v32k?=
 =?us-ascii?Q?2O5TITZytZS60YR+xm1DHlwmyqts7RLGeuPye1O/P6sLMD8tUbm4+EmTtKSV?=
 =?us-ascii?Q?r/oALlym3bRMRD0OZC8NnUW0IJnXG3C2JmQeUSwXp5RFHae3m0GDW0/pf8Qb?=
 =?us-ascii?Q?QaVKgAkbXcND0CvBsl5g4qBxtKNtHXstj+CaX1SzbIttQtpIGVuF4XpcuD7/?=
 =?us-ascii?Q?0W6TNupzaNc9jGK4pzLoX2rU+9EkY7YWEI52zsQWJLUv8flPaqYSmvMJCMu5?=
 =?us-ascii?Q?yWL4BM1C68v/eZkUhEFi+M48eEIWkuxhX6Ay6sgyLk6AI4iaiwx/5a92jkel?=
 =?us-ascii?Q?igpDcGV59PlaPI7KK5Mk51t97y/hoHP/QlZKn6TjrYeWrLHB8+jA3BkRpojr?=
 =?us-ascii?Q?eZGOSHbpzhET+5OwpA7GAV/CnRsCzxuUp5YDwDIU0p2jzHA2lw1+ETZxFvY6?=
 =?us-ascii?Q?ibBEFZel3FjFFdf5gwiOOstwY1LARMdB39LspQ+60phRPRHA+ZcZBYDFkwHw?=
 =?us-ascii?Q?AR6ZLPkrdrx9SZcyNWvmbHTX/bemQWrwBoSuXBNEjFqHHPw9qjObZmYw2/87?=
 =?us-ascii?Q?emo8STnoGKPWhVmBMlJVBPPIhtOqoD18xxK3NCfTgE894XaLavhC3tLrB6M?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ab161025-9d52-4b7a-0fbe-08dd8858e90a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2025 02:36:00.4404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7350

From: Peter Zijlstra <peterz@infradead.org> Sent: Wednesday, April 30, 2025=
 4:08 AM
>=20
> What used to be a simple few instructions has turned into a giant mess
> (for x86_64). Not only does it use static_branch wrong, it mixes it
> with dynamic branches for no apparent reason.
>=20
> Notably it uses static_branch through an out-of-line function call,
> which completely defeats the purpose, since instead of a simple
> JMP/NOP site, you get a CALL+RET+TEST+Jcc sequence in return, which is
> absolutely idiotic.
>=20
> Add to that a dynamic test of hyperv_paravisor_present, something
> which is set once and never changed.
>=20
> Replace all this idiocy with a single direct function call to the
> right hypercall variant.
>=20
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I've done these tests on Hyper-V VMs with this patch series. My focus
is the Hyper-V changes in Patches 11 and 12, not the other changes.

* Normal VM boot and basic smoke test
* TDX and SEV-SNP VMs boot and basic smoke test. These VMs have
   a paravisor
* Normal VM taking a panic and running the kdump kernel
* Normal VM suspending for hibernation, then resuming from
   hibernation
* Verified that IBT is enabled in a normal VM. It's not offered in a TDX
   VM on Hyper-V when a paravisor is used. I don't know about the case
   without a paravisor.
* Building a 64-bit kernel with and without CONFIG_AMD_MEM_ENCRYPT
   and CONFIG_INTEL_TDX_GUEST.
* Building a 32-bit kernel (but I did not try to run it)

TDX and SEV-SNP VMs without a paravisor are not tested, so updating
the static call, and the new direct call path, has not been tested for
TDX and SNP hypercalls. I don't have a hardware environment where I
can test without a paravisor.

Tested-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  arch/x86/hyperv/hv_init.c       |   20 +++++
>  arch/x86/hyperv/ivm.c           |   15 ++++
>  arch/x86/include/asm/mshyperv.h |  137 +++++++++++----------------------=
-------
>  arch/x86/kernel/cpu/mshyperv.c  |   19 +++--
>  4 files changed, 89 insertions(+), 102 deletions(-)
>=20
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -35,7 +35,27 @@
>  #include <linux/highmem.h>
>=20
>  void *hv_hypercall_pg;
> +
> +#ifdef CONFIG_X86_64
> +u64 hv_std_hypercall(u64 control, u64 param1, u64 param2)
> +{
> +	u64 hv_status;
> +
> +	if (!hv_hypercall_pg)
> +		return U64_MAX;
> +
> +	register u64 __r8 asm("r8") =3D param2;
> +	asm volatile (CALL_NOSPEC
> +		      : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> +		        "+c" (control), "+d" (param1), "+r" (__r8)
> +		      : THUNK_TARGET(hv_hypercall_pg)
> +		      : "cc", "memory", "r9", "r10", "r11");
> +
> +	return hv_status;
> +}
> +#else
>  EXPORT_SYMBOL_GPL(hv_hypercall_pg);
> +#endif
>=20
>  union hv_ghcb * __percpu *hv_ghcb_pg;
>=20
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -376,9 +376,23 @@ int hv_snp_boot_ap(u32 cpu, unsigned lon
>  	return ret;
>  }
>=20
> +u64 hv_snp_hypercall(u64 control, u64 param1, u64 param2)
> +{
> +	u64 hv_status;
> +
> +	register u64 __r8 asm("r8") =3D param2;
> +	asm volatile("vmmcall"
> +		     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> +		       "+c" (control), "+d" (param1), "+r" (__r8)
> +		     : : "cc", "memory", "r9", "r10", "r11");
> +
> +	return hv_status;
> +}
> +
>  #else
>  static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
>  static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
> +u64 hv_snp_hypercall(u64 control, u64 param1, u64 param2) { return U64_M=
AX; }
>  #endif /* CONFIG_AMD_MEM_ENCRYPT */
>=20
>  #ifdef CONFIG_INTEL_TDX_GUEST
> @@ -428,6 +442,7 @@ u64 hv_tdx_hypercall(u64 control, u64 pa
>  #else
>  static inline void hv_tdx_msr_write(u64 msr, u64 value) {}
>  static inline void hv_tdx_msr_read(u64 msr, u64 *value) {}
> +u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2) { return U64_M=
AX; }
>  #endif /* CONFIG_INTEL_TDX_GUEST */
>=20
>  #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -6,6 +6,7 @@
>  #include <linux/nmi.h>
>  #include <linux/msi.h>
>  #include <linux/io.h>
> +#include <linux/static_call.h>
>  #include <asm/nospec-branch.h>
>  #include <asm/paravirt.h>
>  #include <hyperv/hvhdk.h>
> @@ -38,16 +39,21 @@ static inline unsigned char hv_get_nmi_r
>  	return 0;
>  }
>=20
> -#if IS_ENABLED(CONFIG_HYPERV)
> -extern bool hyperv_paravisor_present;
> +extern u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
> +extern u64 hv_snp_hypercall(u64 control, u64 param1, u64 param2);
> +extern u64 hv_std_hypercall(u64 control, u64 param1, u64 param2);
>=20
> +#if IS_ENABLED(CONFIG_HYPERV)
>  extern void *hv_hypercall_pg;
>=20
>  extern union hv_ghcb * __percpu *hv_ghcb_pg;
>=20
>  bool hv_isolation_type_snp(void);
>  bool hv_isolation_type_tdx(void);
> -u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
> +
> +#ifdef CONFIG_X86_64
> +DECLARE_STATIC_CALL(hv_hypercall, hv_std_hypercall);
> +#endif
>=20
>  /*
>   * DEFAULT INIT GPAT and SEGMENT LIMIT value in struct VMSA
> @@ -64,37 +70,15 @@ static inline u64 hv_do_hypercall(u64 co
>  {
>  	u64 input_address =3D input ? virt_to_phys(input) : 0;
>  	u64 output_address =3D output ? virt_to_phys(output) : 0;
> -	u64 hv_status;
>=20
>  #ifdef CONFIG_X86_64
> -	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
> -		return hv_tdx_hypercall(control, input_address, output_address);
> -
> -	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
> -		__asm__ __volatile__("mov %[output_address], %%r8\n"
> -				     "vmmcall"
> -				     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> -				       "+c" (control), "+d" (input_address)
> -				     : [output_address] "r" (output_address)
> -				     : "cc", "memory", "r8", "r9", "r10", "r11");
> -		return hv_status;
> -	}
> -
> -	if (!hv_hypercall_pg)
> -		return U64_MAX;
> -
> -	__asm__ __volatile__("mov %[output_address], %%r8\n"
> -			     CALL_NOSPEC
> -			     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> -			       "+c" (control), "+d" (input_address)
> -			     : [output_address] "r" (output_address),
> -			       THUNK_TARGET(hv_hypercall_pg)
> -			     : "cc", "memory", "r8", "r9", "r10", "r11");
> +	return static_call_mod(hv_hypercall)(control, input_address, output_add=
ress);
>  #else
>  	u32 input_address_hi =3D upper_32_bits(input_address);
>  	u32 input_address_lo =3D lower_32_bits(input_address);
>  	u32 output_address_hi =3D upper_32_bits(output_address);
>  	u32 output_address_lo =3D lower_32_bits(output_address);
> +	u64 hv_status;
>=20
>  	if (!hv_hypercall_pg)
>  		return U64_MAX;
> @@ -107,8 +91,8 @@ static inline u64 hv_do_hypercall(u64 co
>  			       "D"(output_address_hi), "S"(output_address_lo),
>  			       THUNK_TARGET(hv_hypercall_pg)
>  			     : "cc", "memory");
> -#endif /* !x86_64 */
>  	return hv_status;
> +#endif /* !x86_64 */
>  }
>=20
>  /* Hypercall to the L0 hypervisor */
> @@ -120,41 +104,23 @@ static inline u64 hv_do_nested_hypercall
>  /* Fast hypercall with 8 bytes of input and no output */
>  static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
>  {
> -	u64 hv_status;
> -
>  #ifdef CONFIG_X86_64
> -	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
> -		return hv_tdx_hypercall(control, input1, 0);
> -
> -	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
> -		__asm__ __volatile__(
> -				"vmmcall"
> -				: "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> -				"+c" (control), "+d" (input1)
> -				:: "cc", "r8", "r9", "r10", "r11");
> -	} else {
> -		__asm__ __volatile__(CALL_NOSPEC
> -				     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> -				       "+c" (control), "+d" (input1)
> -				     : THUNK_TARGET(hv_hypercall_pg)
> -				     : "cc", "r8", "r9", "r10", "r11");
> -	}
> +	return static_call_mod(hv_hypercall)(control, input1, 0);
>  #else
> -	{
> -		u32 input1_hi =3D upper_32_bits(input1);
> -		u32 input1_lo =3D lower_32_bits(input1);
> -
> -		__asm__ __volatile__ (CALL_NOSPEC
> -				      : "=3DA"(hv_status),
> -					"+c"(input1_lo),
> -					ASM_CALL_CONSTRAINT
> -				      :	"A" (control),
> -					"b" (input1_hi),
> -					THUNK_TARGET(hv_hypercall_pg)
> -				      : "cc", "edi", "esi");
> -	}
> -#endif
> +	u32 input1_hi =3D upper_32_bits(input1);
> +	u32 input1_lo =3D lower_32_bits(input1);
> +	u64 hv_status;
> +
> +	__asm__ __volatile__ (CALL_NOSPEC
> +			      : "=3DA"(hv_status),
> +			      "+c"(input1_lo),
> +			      ASM_CALL_CONSTRAINT
> +			      :	"A" (control),
> +			      "b" (input1_hi),
> +			      THUNK_TARGET(hv_hypercall_pg)
> +			      : "cc", "edi", "esi");
>  	return hv_status;
> +#endif
>  }
>=20
>  static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
> @@ -174,45 +140,24 @@ static inline u64 hv_do_fast_nested_hype
>  /* Fast hypercall with 16 bytes of input */
>  static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 i=
nput2)
>  {
> -	u64 hv_status;
> -
>  #ifdef CONFIG_X86_64
> -	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
> -		return hv_tdx_hypercall(control, input1, input2);
> -
> -	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
> -		__asm__ __volatile__("mov %[input2], %%r8\n"
> -				     "vmmcall"
> -				     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> -				       "+c" (control), "+d" (input1)
> -				     : [input2] "r" (input2)
> -				     : "cc", "r8", "r9", "r10", "r11");
> -	} else {
> -		__asm__ __volatile__("mov %[input2], %%r8\n"
> -				     CALL_NOSPEC
> -				     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> -				       "+c" (control), "+d" (input1)
> -				     : [input2] "r" (input2),
> -				       THUNK_TARGET(hv_hypercall_pg)
> -				     : "cc", "r8", "r9", "r10", "r11");
> -	}
> +	return static_call_mod(hv_hypercall)(control, input1, input2);
>  #else
> -	{
> -		u32 input1_hi =3D upper_32_bits(input1);
> -		u32 input1_lo =3D lower_32_bits(input1);
> -		u32 input2_hi =3D upper_32_bits(input2);
> -		u32 input2_lo =3D lower_32_bits(input2);
> -
> -		__asm__ __volatile__ (CALL_NOSPEC
> -				      : "=3DA"(hv_status),
> -					"+c"(input1_lo), ASM_CALL_CONSTRAINT
> -				      :	"A" (control), "b" (input1_hi),
> -					"D"(input2_hi), "S"(input2_lo),
> -					THUNK_TARGET(hv_hypercall_pg)
> -				      : "cc");
> -	}
> -#endif
> +	u32 input1_hi =3D upper_32_bits(input1);
> +	u32 input1_lo =3D lower_32_bits(input1);
> +	u32 input2_hi =3D upper_32_bits(input2);
> +	u32 input2_lo =3D lower_32_bits(input2);
> +	u64 hv_status;
> +
> +	__asm__ __volatile__ (CALL_NOSPEC
> +			      : "=3DA"(hv_status),
> +			      "+c"(input1_lo), ASM_CALL_CONSTRAINT
> +			      :	"A" (control), "b" (input1_hi),
> +			      "D"(input2_hi), "S"(input2_lo),
> +			      THUNK_TARGET(hv_hypercall_pg)
> +			      : "cc");
>  	return hv_status;
> +#endif
>  }
>=20
>  static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input=
2)
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -37,10 +37,6 @@
>  bool hv_nested;
>  struct ms_hyperv_info ms_hyperv;
>=20
> -/* Used in modules via hv_do_hypercall(): see arch/x86/include/asm/mshyp=
erv.h */
> -bool hyperv_paravisor_present __ro_after_init;
> -EXPORT_SYMBOL_GPL(hyperv_paravisor_present);
> -
>  #if IS_ENABLED(CONFIG_HYPERV)
>  static inline unsigned int hv_get_nested_msr(unsigned int reg)
>  {
> @@ -287,8 +283,18 @@ static void __init x86_setup_ops_for_tsc
>  	old_restore_sched_clock_state =3D x86_platform.restore_sched_clock_stat=
e;
>  	x86_platform.restore_sched_clock_state =3D hv_restore_sched_clock_state=
;
>  }
> +
> +#ifdef CONFIG_X86_64
> +DEFINE_STATIC_CALL(hv_hypercall, hv_std_hypercall);
> +EXPORT_STATIC_CALL_TRAMP_GPL(hv_hypercall);
> +#define hypercall_update(hc) static_call_update(hv_hypercall, hc)
> +#endif
>  #endif /* CONFIG_HYPERV */
>=20
> +#ifndef hypercall_update
> +#define hypercall_update(hc) (void)hc
> +#endif
> +
>  static uint32_t  __init ms_hyperv_platform(void)
>  {
>  	u32 eax;
> @@ -483,14 +489,14 @@ static void __init ms_hyperv_init_platfo
>  			ms_hyperv.shared_gpa_boundary =3D
>  				BIT_ULL(ms_hyperv.shared_gpa_boundary_bits);
>=20
> -		hyperv_paravisor_present =3D !!ms_hyperv.paravisor_present;
> -
>  		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
>  			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
>=20
>=20
>  		if (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_SNP) {
>  			static_branch_enable(&isolation_type_snp);
> +			if (!ms_hyperv.paravisor_present)
> +				hypercall_update(hv_snp_hypercall);
>  		} else if (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_TDX) {
>  			static_branch_enable(&isolation_type_tdx);
>=20
> @@ -498,6 +504,7 @@ static void __init ms_hyperv_init_platfo
>  			ms_hyperv.hints &=3D ~HV_X64_APIC_ACCESS_RECOMMENDED;
>=20
>  			if (!ms_hyperv.paravisor_present) {
> +				hypercall_update(hv_tdx_hypercall);
>  				/*
>  				 * Mark the Hyper-V TSC page feature as disabled
>  				 * in a TDX VM without paravisor so that the
>=20
>=20


