Return-Path: <linux-efi+bounces-5997-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 775DDD25955
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jan 2026 17:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A3283013EFE
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jan 2026 15:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B62E3B8D4C;
	Thu, 15 Jan 2026 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yoOsjCWX"
X-Original-To: linux-efi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8D43ACA62;
	Thu, 15 Jan 2026 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492717; cv=fail; b=TSiEt5t8mIFVU+DfJw9O85+zGx3euVyA42vrQg667AqcbGDyGSBs2EykViV2NyhzzYdO66IgIHjvNqBgijSLsrMrFhcL0XtwZEzSn6hgxE+a4nbEktC5cQngQc+UMyGLT7U0QY/X90HjdWcIcqX+gnkOZWYc6BwIPmNLi3dnFNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492717; c=relaxed/simple;
	bh=ny6Y3XZbe4GhcQgC2/euPtCvQi0K2eKyJGQUaZnUazE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uVXDHQj0WUPCUDhNbac4Jw03luq8064waOXqAvM5l+I1F/jO4gYctqOeHyuauvvq0bDqcNLvs3XShKxtw/TnDU44Q1EctnS73RGdpv2VhU8PhNIQ1BJpI+MrzrnOeXBNVJ0U1ulHxxfc/bMpgPjHxZKhxmAa+xwT9tZ1SgcT/q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yoOsjCWX; arc=fail smtp.client-ip=52.101.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdrcscu86pefir6hlnQsIuwih5RiDiEmpSfhbcnbuTxS9azkJCIaBFEsCTKw36YdnLlM6ix4N2QZ5IiU31Z9fw19RQPz20B5d6DiOqj9v/+6CHQ82HhVeIng7HxCuWA7ykdzUmoh3F5kus8TkALVOV7zUDRJosJ0CtkEBRptMSa0ZwsxlGdY+LPwvSXiN+WXlbDmHVvs6SkfG8MAao2M0AJ45rqg9LH8Q+hf7SLiLQcY3yVF3z75eAg+k8fbgmYJnTnbcz5hDHo3zVRd9QtqL5REIb8zhUApdyVKTCNN5n61EAWimxgNflDahNJIMQoG1EfL9p5hc/agwFL9Q3kA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ny6Y3XZbe4GhcQgC2/euPtCvQi0K2eKyJGQUaZnUazE=;
 b=CAWYlzrfRJcA2I4mg6MJtuPX+qRfzNtSxaUC5wuPrXaNjxydbaabAt7/bfF/mRBsjdPjxp3J8HwJvm8b2ONdfCAbicZtGGGVMKlyXFaalJqYy5ieRM39pS6DQ3qxr0Z6cOy7w95ZD5BHnJBzVopUYalJXvqB0wP7KADfySrToStYwia3AM3SOAks6xUMD0YsdyXQf2KeOYGoycUJeTRYXjHDEb2BIZD5ZIr5/ZNWrkFokfYLmALllEIDXc+TjwlxGysaxVQy2ZxK4FpqLaJjVuJl62CWD2Oig10wpIUYrBSKKm31rzvafH/6VvWL1LK4a78ZI7QJ6xTdQsrmbqxVEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ny6Y3XZbe4GhcQgC2/euPtCvQi0K2eKyJGQUaZnUazE=;
 b=yoOsjCWXqOnIaBkwgZndsIB6MQX1cK99N8i+gPz37mAiVUBNAdZHoTRIwsPrycj6x5PDn39pznLtJIDmCQEll27oEUGNJvERuhh7sc1H6uVRNgMhTM4wZ1QUwW9fOaTpRcp45AnxPUUwKBLk9aZ1jV+FrVRjgGz0FRTHpKCDMe8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 15:58:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 15:58:28 +0000
Message-ID: <9025bacb-c7ed-4d21-b826-0cb0bf4311ac@amd.com>
Date: Thu, 15 Jan 2026 16:58:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Recover sysfb after DRM probe failure
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, Alex Deucher
 <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Ard Biesheuvel <ardb@kernel.org>, Ce Sun <cesun102@amd.com>,
 Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Dave Airlie <airlied@redhat.com>, Deepak Rawat <drawat.floss@gmail.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Hans de Goede <hansg@kernel.org>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Helge Deller <deller@gmx.de>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Lijo Lazar <lijo.lazar@amd.com>, linux-efi@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lucas De Marchi <lucas.demarchi@intel.com>,
 Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Maxime Ripard <mripard@kernel.org>, nouveau@lists.freedesktop.org,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>,
 spice-devel@lists.freedesktop.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, virtualization@lists.linux.dev,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
References: <20251229215906.3688205-1-zack.rusin@broadcom.com>
 <c816f7ed-66e0-4773-b3d1-4769234bd30b@suse.de>
 <CABQX2QNQU4XZ1rJFqnJeMkz8WP=t9atj0BqXHbDQab7ZnAyJxg@mail.gmail.com>
 <97993761-5884-4ada-b345-9fb64819e02a@suse.de>
 <9058636d-cc18-4c8f-92cf-782fd8f771af@amd.com>
 <4ee824d5-8ea0-4ae1-8bcb-5f8cbae37fc8@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <4ee824d5-8ea0-4ae1-8bcb-5f8cbae37fc8@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0301.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: c40f6f14-90de-41c5-23dd-08de544eec2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHN0SWN0N1dkZjFWbm1naVY1WFJKbW1HUWR0R2lmQm91SVBOUjZ5ZnE1TlJC?=
 =?utf-8?B?eEhiZGNFMURjek1GT3VYelZ1alNCOUtMVGtrU3JtbkdYN1VGelhXaTFmazFN?=
 =?utf-8?B?alkxUWgvckNJRVBldGYzY1Yza3lhV0h5eHRXUXUrNFdnckIzMEoyTFBJK0pU?=
 =?utf-8?B?eXcwbmlzdWtBUmFwQXdkaERFNEJKRnBiSTFXZUd1Zm9Cd255NGZPREFCV0hM?=
 =?utf-8?B?SjdsZ2lVTzJGZHBpeHhEdzhZdnErTFMxZ0FVVUlzVzNic0RmUjBvVmZaaURC?=
 =?utf-8?B?clkrbU9EeEE5MlV4ODRGN0tqRFQwcWxLNXdLZHFKamNQekw0L3VuMmZ1dXJR?=
 =?utf-8?B?UTBSM25VZi8xa2wxblpLQ0ZxaWRab0lCMU14L3grdGNHZ3ZLdVNZazNBbkVC?=
 =?utf-8?B?U2JpbHFlRExrbnhBbXpUUytiaWphV0x4WnpoaHQraDZIa1BDT2ZTVWNTbjc2?=
 =?utf-8?B?WUxRMHNCYW9Lc3pOMmU4aFdHZmViMFRnL1FZZDV6Q2E3UGtVNi9mR1VEaEtS?=
 =?utf-8?B?eHlrQndVQWJ5OVZYclBpaENUYTBzdW0vTTRzR3A0VEIrSUtManVDb3k5aEs0?=
 =?utf-8?B?ZDlUdlY5a0o5dkcvUDNsNlNBaDJUaXU4dmJldCt4YnY5aHRwZVRJSGpyKzFW?=
 =?utf-8?B?czRTM0JEYkFaWm02dFJGZzRVYnFETXFISDBHZXJISkxmRDM4UVRFVklpdWVz?=
 =?utf-8?B?QllCWWM4cDdWb09kOGNQRzUwV3hIWXU1T0ZiSG1nbGdxeHl0QkxWcmpML091?=
 =?utf-8?B?WlhuTk1jK1c1YTlySjZ4QzRodXVTcGxIS1lqL0lZa0hCaDNmNmNjTkhNL1Yy?=
 =?utf-8?B?aEpWVkc2UGJRK2w4WmphRTRoejh2K2d5aUV0R1JzVGNDN25RRllIYWhRcUVn?=
 =?utf-8?B?L0RaZjZPVGw5cWJxUlpldEZ2VHJ3ODI5Q2JudWZKOU11Lyt0Zk5ybTJIUFVY?=
 =?utf-8?B?VHBsMWMrVTM1ZjV0Q2h5Q2s2alFYYVl2RGcvTFhoUGk4VDI0SWNvVUVUVGs2?=
 =?utf-8?B?cjhzQk4ybFR4UzZsTXJuMHl3R1llK3RkUEJ6dDk2YXo4L1dtd1l0UXNFVm5K?=
 =?utf-8?B?TFhTY1BLOEtHN3BtTTFTb1A1c1BITGZiWDFIQlBTMURmdGh4VFF0dGJNNFdN?=
 =?utf-8?B?a2Q3eDljM2daK0ZXNWYxYnJwalFjNmtiTHQ0dllMRmxWa0N1MUJTNEJwWVlr?=
 =?utf-8?B?d3JLeDBNSUxId2lDNVZGdC9PNnNFYmZMNld0VGpvdUF1a0hlVXVrMnZ5ZGRL?=
 =?utf-8?B?aXRlR0kyY1M1QWtkQTZYcG1WTzJOdnRQNDk3Y0xXdUFOUmJIVFMvMndFb3Fu?=
 =?utf-8?B?UHJjaGxuU004VXJzVC95S2tkRVVKT3lMeThrNlVPZjRScEZMRkdVRXEwVTZl?=
 =?utf-8?B?RHg5QmUzTGFXblZtRE5YVFdDa3o0eXdvVUNxYjJ2OFFhcEsyaXl2UHBNSUQv?=
 =?utf-8?B?RUxXWlNlWkFFTVVydEExREFiQ08wdldTekZVNDY4ajJYNGx6OHY5WTcwZFQw?=
 =?utf-8?B?aW5vVzFSMG0vSlR2Vi8vNTU4RkwyN3NDc051ektOd01pdnlzdjRTanMvbDAz?=
 =?utf-8?B?QU11MXV6MDFWdWhuSHFqR1Iwb0FCdllyTzZPanA0dmpDTVdTTFBsRUdhRHdj?=
 =?utf-8?B?UUJDbngvTnN6YWR2cXNWdEl1b0k2NmV5bWlRd084MW8wQTBvN3IxeE1qY2Ux?=
 =?utf-8?B?aTZyZi9XQUNPMFZkR1BBSm1KN0lDZVd5RDNBcmJVSXhCMFlMNmZnT0Y3TjRt?=
 =?utf-8?B?ZU8zVkgxdTJ3TzN4ekJ4Y09JNWFKb1ZvSEJpRlZQeHc1TWJOaENzZm9hYUhx?=
 =?utf-8?B?ZmJDcjV4Vm5GMmFYN1M5Q2pjV0hXVTFocW81MkxiWVF3OTFkUWZCRHpDSktr?=
 =?utf-8?B?OVdtVXcycjdNVG9vTmk0WHhURVh0YjJCdFVUZGhNMU5PWGdtVW00eCtxOVU0?=
 =?utf-8?B?ZUYrSkMraE1xZXM3MWdLYSs3RnBTN3lUMEg3NjEwcHgzc1JCc2s1c3lhS3Zy?=
 =?utf-8?B?ODMwSlJoTnZRNVZmSFoybWRCcnJPMWhNQ3RQZ0RCdGR6N1ZZd3BzQnhxUWNv?=
 =?utf-8?B?N3Z3WnlBdWN5MFdvOGswZXFYb0Z5eWpMT1JKVkRuY0JSK095alVjSjdjaWVR?=
 =?utf-8?Q?45Bk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0l6SFlIREFkYllKUDZxUGduemhZd2R4QlY2LytQRCtkTFROSzdDWE04eFBj?=
 =?utf-8?B?VUhPcGVvOXMrMWpFSnh2bmtvKzF3aEYxRWVtNEJLbmRMQ1JmZUpSVjMvOUR5?=
 =?utf-8?B?c1g1cmgwSE42OGRRSHUyUzhaNXFUa0dVMDhCNEhNdnN3azlkVW5NbmxpOHJH?=
 =?utf-8?B?MU9jclNiYWRSdnpGVkxkWFZISHNrd0xjaTg1SEJRbzAvQ2xqcHl4MUMyelh1?=
 =?utf-8?B?bnlPUW1YZUVRWSt6bU5PRVYrTWp4VHQvOVIwOFlJVlplNWhrT00rWU0ydWha?=
 =?utf-8?B?VFhoTElZeU9tN0Vya0ozc244OTFaUHBzeU55V2VBN2ZwUUtJTnpPSDVsN1JP?=
 =?utf-8?B?NXdkeStMdnU3TFJNRWxyK0pBK2s4VjVXKytnYm02TVNtY1BVTDliRmVnUWpv?=
 =?utf-8?B?S2Rqbmtrc2NIMUFkdkQwOU9sb1YvbHB5bHNWUjk1cjBEQjhKeUVSdHRVOVdE?=
 =?utf-8?B?aVBHOGhoVkFidkZlMHhWU0xDSi9jQXlHNnFPeUxpem5SYTFUTHlWRldFbDVI?=
 =?utf-8?B?cGU4RkxNVFd5bXV1UW5uQVhxQXczZW93ZGErTFdGcEZNZTZNTjVSY04zUHZZ?=
 =?utf-8?B?QUsrM0JBSGkvOVJtY2s2eXY2UytEYytmVTh3TVBpSzI3NmloRkgwYnIvWkVQ?=
 =?utf-8?B?VjcyK0NkODBzL1RjbXBJSkR2RkM1YldTb1NOYWFKQ3BkTitlMDBpUklEbGsz?=
 =?utf-8?B?N0ZDRGpzS3ROV2ovb3Yrb09HQzFTRXd0cjRiNTc0bDF4NnFOd3JicEkxSTdZ?=
 =?utf-8?B?Qms4UlByNkZ5eXpyNUhIRVpCSTZQSVU0YmQ4R0FQd2NtZFJVZXBuYVZRTVpP?=
 =?utf-8?B?NHlqbnRQWklFL2JwM0NnVjdwQlRvblFsYUpMRTZOSC91eTFDNVBoUEg4RnVP?=
 =?utf-8?B?YjFsVk9ZM0M2bS9YZHgvNDcvYmpXZFN1UHR6Z3ppbEp5V2dqeVpZajdlRCtk?=
 =?utf-8?B?Sk1LcGQvdTM3V1BvRUpFZm9IMzZBSkFhR0gxaWlDTWs5V29wVGMwZWN3QWNJ?=
 =?utf-8?B?Yk5tNEQxVmhqcy9BL0syN1lTZk9ZTS9uL0lWZWZWQ1daSWFnRWdKK0FmRldl?=
 =?utf-8?B?cGpPTEN4STBQS1l5ZmdkRGdCL3JSblV5UitiY2hrZFN4eWhia2M0MWo4Z3Rv?=
 =?utf-8?B?Mno2YXo5VlFMRlRtVGNhV3hzUFBGZ3VUTDNURk5TdzBreHJlSzBSajZGRU54?=
 =?utf-8?B?NXNSTlBKRDM0d2dBYlJaVjBJUURoQU5mSmF4Nk1GalVER2J5TEN2Y2pzMVZW?=
 =?utf-8?B?R29pZWZ1ZHBlR2M5KzMzb295L0Q2aEthaTdWNG11OEhNd1VSbG1VM3JLamNK?=
 =?utf-8?B?YXhPbjNxSEJnUjE5YmVEcjkrRG1HVTZEQkFaR1BCYmxLUFFGWUtvM0Q4RjJ6?=
 =?utf-8?B?YUMxdkxacXVwQ2o3L2MydlZkekE1dFJFeEVDNk1zZ3pjNFdRdGxFUUdIemRl?=
 =?utf-8?B?VThxUU56eXJrbGtoTmM4Z250bkwyVTJlYjRlVmR1RHJUNkZVbVBpcTFHSGxK?=
 =?utf-8?B?RWFDR2tTQ2tZeWp1WFJmTWhkMkh5djVzSHZBSFI0STR4M1Y3OUxGd2pELys0?=
 =?utf-8?B?SE5JVCtJRVcwZndJWHYxQkljRWN3LzZITGU0a1BrM1NvSjRrNmgxK2VxSVl0?=
 =?utf-8?B?VXV4UUZGeWtIRm9yelBWbzFCbnhjNFh3dnpNeGYvOEMwR1VQdGN0WUVWK3pn?=
 =?utf-8?B?RFJxU0xtdUFZQUFDdGU0UVBQSFNwdzBQWldVS3puMjBRS0t3WE1lVDNYRVo0?=
 =?utf-8?B?dXBSTi85ZExGemJCWVFFM0tlWnpCekxyeDV1QmJNVGU1NlBIcW03UDdFRncx?=
 =?utf-8?B?NDEwTzd5djZLTUM3S3BzVWFuOGFGTFdtdzBNaSs0ZkhWSkxQeWFkdUF2QWI1?=
 =?utf-8?B?WS9GNTJMUGEvNjNwTkpPemF6aE5PUjFKUkxSS04wd1g5QVM4dGtPYS9ZRlhI?=
 =?utf-8?B?MHRaL2pGRWo0U01SU3VEWnZXRlRnMURmMmVweGxzYk4rSU9MVWlLYjBsV0F0?=
 =?utf-8?B?RFFFQUNWb2RwUUYrWWlkbmhsSkVJTGVrWktGaUVtMFBENG5GOVdiL1NaVXhS?=
 =?utf-8?B?cGNoeUFzeDcvSEd0eE1CbmRBZk5ndDkvcWNVYTNiK1dsd3FCa0hMNUpZSHNu?=
 =?utf-8?B?RXVOVFhCYXRvZzB0aEQrNDNWblFBY3Z1eXRhUjFNeWMwdU0wcm1CRHJNTDZ3?=
 =?utf-8?B?K2hxbnRFeHcyQldSUVZ2djAyTUJRa3pLM3hXR294QUhjUUtGc2xER0ZOK1Ba?=
 =?utf-8?B?ZHdudm9nTTZhY1BtUWlxYTFMVm1zZlB4dS94NmRyZkZacUdnaFRkMCtyQTU5?=
 =?utf-8?Q?Ht3SFRPKSW0RPC+RU0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40f6f14-90de-41c5-23dd-08de544eec2d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 15:58:28.3850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxoOeCQliB0W2zqtxJhhW9V5fZh8He/NZl4fJJ/x6mPQ98GeRDJz7uBYLkkgoC8B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237

On 1/15/26 15:54, Thomas Zimmermann wrote:
> Hi
>=20
> Am 15.01.26 um 15:39 schrieb Christian K=C3=B6nig:
>> Sorry to being late, but I only now realized what you are doing here.
>>
>> On 1/15/26 12:02, Thomas Zimmermann wrote:
>>> Hi,
>>>
>>> apologies for the delay. I wanted to reply and then forgot about it.
>>>
>>> Am 10.01.26 um 05:52 schrieb Zack Rusin:
>>>> On Fri, Jan 9, 2026 at 5:34=E2=80=AFAM Thomas Zimmermann <tzimmermann@=
suse.de> wrote:
>>>>> Hi
>>>>>
>>>>> Am 29.12.25 um 22:58 schrieb Zack Rusin:
>>>>>> Almost a rite of passage for every DRM developer and most Linux user=
s
>>>>>> is upgrading your DRM driver/updating boot flags/changing some confi=
g
>>>>>> and having DRM driver fail at probe resulting in a blank screen.
>>>>>>
>>>>>> Currently there's no way to recover from DRM driver probe failure. P=
CI
>>>>>> DRM driver explicitly throw out the existing sysfb to get exclusive
>>>>>> access to PCI resources so if the probe fails the system is left wit=
hout
>>>>>> a functioning display driver.
>>>>>>
>>>>>> Add code to sysfb to recever system framebuffer when DRM driver's pr=
obe
>>>>>> fails. This means that a DRM driver that fails to load reloads the s=
ystem
>>>>>> framebuffer driver.
>>>>>>
>>>>>> This works best with simpledrm. Without it Xorg won't recover becaus=
e
>>>>>> it still tries to load the vendor specific driver which ends up usua=
lly
>>>>>> not working at all. With simpledrm the system recovers really nicely
>>>>>> ending up with a working console and not a blank screen.
>>>>>>
>>>>>> There's a caveat in that some hardware might require some special ma=
gic
>>>>>> register write to recover EFI display. I'd appreciate it a lot if
>>>>>> maintainers could introduce a temporary failure in their drivers
>>>>>> probe to validate that the sysfb recovers and they get a working con=
sole.
>>>>>> The easiest way to double check it is by adding:
>>>>>> =C2=A0=C2=A0=C2=A0 /* XXX: Temporary failure to test sysfb restore -=
 REMOVE BEFORE COMMIT */
>>>>>> =C2=A0=C2=A0=C2=A0 dev_info(&pdev->dev, "Testing sysfb restore: forc=
ing probe failure\n");
>>>>>> =C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
>>>>>> =C2=A0=C2=A0=C2=A0 goto out_error;
>>>>>> or such right after the devm_aperture_remove_conflicting_pci_devices=
 .
>>>>> Recovering the display like that is guess work and will at best work
>>>>> with simple discrete devices where the framebuffer is always located =
in
>>>>> a confined graphics aperture.
>>>>>
>>>>> But the problem you're trying to solve is a real one.
>>>>>
>>>>> What we'd want to do instead is to take the initial hardware state in=
to
>>>>> account when we do the initial mode-setting operation.
>>>>>
>>>>> The first step is to move each driver's remove_conflicting_devices ca=
ll
>>>>> to the latest possible location in the probe function. We usually do =
it
>>>>> first, because that's easy. But on most hardware, it could happen muc=
h
>>>>> later.
>>>> Well, some drivers (vbox, vmwgfx, bochs and currus-qemu) do it because
>>>> they request pci regions which is going to fail otherwise. Because
>>>> grabbining the pci resources is in general the very first thing that
>>>> those drivers need to do to setup anything, we
>>>> remove_conflicting_devices first or at least very early.
>>> To my knowledge, requesting resources is more about correctness than a =
hard requirement to use an I/O or memory range. Has this changed?
>> Nope that is not correct.
>>
>> At least for AMD GPUs remove_conflicting_devices() really early is neces=
sary because otherwise some operations just result in a spontaneous system =
reboot.=C2=A0=C2=A0=C2=A0
>=20
> Here I was only talking about avoiding calls to request_resource() and si=
milar interfaces.
>=20
>>
>> For example resizing the PCIe BAR giving access to VRAM or disabling VGA=
 emulation (which AFAIK is used for EFI as well) is only possible when the =
VGA or EFI framebuffer driver is kicked out first.
>=20
> Yeah, that's what I expected.
>=20
>>
>> And disabling VGA emulation is among the absolutely first steps you do t=
o take over the scanout config.
>=20
> Assuming the driver (or driver author) is careful, is it possible to only=
 read state from AMD hardware at such an early time?

I'm not an expert for that particular stuff but I strongly don't think so.

Basically the VGA emulation is firmware which "owns" the CRTC registers and=
 might modify them at any time unless it's turned off first.

So you can't even use data/index pairs of registers etc...

> We usually do remove_conflicting_devices() as the first thing in most dri=
ver's probe function. As a first step, it would be helpful to postpone itto=
 a later point.

Well from what I knew that won't work in a lot of cases.

I mean what we could do on non-AMD HW is to remove the conflicting driver, =
play with the HW and if we find that this didn't worked reset the HW using =
a PCI function level reset and try to load the EFI or whatever driver again=
. But that has a rather low chance of working reliable I would say.

The problem with AMD GPUs is that the PCI function level reset is broken to=
 begin with (which already caused us tons of headache in the case of pass t=
hrough).

Regards,
Christian.

>=20
>>
>> So I absolutely clearly have to reject the amdgpu patch in this series, =
that will break tons of use cases.
>=20
> Don't worry, we're still in the early ideation phase.
>=20
> Best regards
> Thomas
>=20
>>
>> Regards,
>> Christian.
>>
>>>> I also don't think it's possible or even desirable by some drivers to
>>>> reuse the initial state, good example here is vmwgfx where by default
>>>> some people will setup their vm's with e.g. 8mb ram, when the vmwgfx
>>>> loads we allow scanning out from system memory, so you can set your vm
>>>> up with 8mb of vram but still use 4k resolutions when the driver
>>>> loads, this way the suspend size of the vm is very predictable (tiny
>>>> vram plus whatever ram was setup) while still allowing a lot of
>>>> flexibility.
>>> If there's no initial state to switch from, the first modeset can fail =
while leaving the display unusable. There's no way around that. Going back =
to the old state is not an option unless the driver has been written to sup=
port this.
>>>
>>> The case of vmwgfx is special, but does not effect the overall problem.=
 For vmwgfx, it would be best to import that initial state and support a tr=
ansparent modeset from vram to system memory (and back) at least during thi=
s initial state.
>>>
>>>
>>>> In general I think however this is planned it's two or three separate =
series:
>>>> 1) infrastructure to reload the sysfb driver (what this series is)
>>>> 2) making sure that drivers that do want to recover cleanly actually
>>>> clean out all the state on exit properly,
>>>> 3) abstracting at least some of that cleanup in some driver independen=
t way
>>> That's really not going to work. For example, in the current series, yo=
u invoke devm_aperture_remove_conflicting_pci_devices_done() after drm_mode=
_reset(), drm_dev_register() and drm_client_setup(). Each of these calls ca=
n modify hardware state. In the case of _register() and _setup(), the DRM c=
lients can perform a modeset, which destroys the initial hardware state. Pa=
tch 1 of this series removes the sysfb device/driver entirely. That should =
be a no-go as it significantly complicates recovery. For example, if the na=
tive drivers failed from an allocation failure, the sysfb device/driver is =
not likely to come back either. As the very first thing, the series should =
state which failures is is going to resolve, - failed hardware init, - inva=
lid initial modesetting, - runtime errors (such ENOMEM, failed firmware loa=
ding), - others? And then specify how a recovery to sysfb could look in eac=
h supported scenario. In terms of implementation, make any transition betwe=
en drivers
>>> gradually. The native driver needs to acquire the hardware resource (fr=
amebuffer and I/O apertures) without unloading the sysfb driver. Luckily th=
ere's struct drm_device.unplug, which does that. [1] Flipping this field di=
sables hardware access for DRM drivers. All sysfb drivers support this. To =
get the sysfb drivers ready, I suggest dedicated helpers for each drivers a=
perture. The aperture helpers can use these callback to flip the DRM driver=
 off and on again. For example, efidrm could do this as a minimum: int efid=
rm_aperture_suspend() { dev->unplug =3D true; remove_resource(/*framebuffer=
 aperture*/) return 0 } int efidrm_aperture_resume() { insert_resource(/*fr=
amebuffer aperture*/) dev->unplug =3D false; return 0 } struct aperture_fun=
cs efidrm_aperture_funcs { .suspend =3D efidrm_aperture_suspend, .resume =
=3D efidrm_aperture_resume, } Pass this struct when efidrm acquires the fra=
mebuffer aperture, so that the aperture helpers can control the behavior of=
 efidrm. With this, a multi-
>>> step takeover from sysfb to native driver can be tried. It's still a ma=
ssive effort that requires an audit of each driver's probing logic. There's=
 no copy-paste pattern AFAICT. I suggest to pick one simple driver first an=
d make a prototype. Let me also say that I DO like the general idea you're =
proposing. But if it was easy, we would likely have done it already. Best r=
egards Thomas
>>>> z
>=20


