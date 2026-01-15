Return-Path: <linux-efi+bounces-5994-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44383D25028
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jan 2026 15:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B04A730A2A20
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jan 2026 14:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C987F30BB8E;
	Thu, 15 Jan 2026 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MULS9Li5"
X-Original-To: linux-efi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289E82F069E;
	Thu, 15 Jan 2026 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487968; cv=fail; b=dDGVsxUBgD5ZzhcvDZz4XW5olw4kOxQnb9TSh0jWIHJlWkyTKLbf3idL0lPrKxkO9U8Nzdha7c1zvhaAY8d0w7IXeK6qkHrXXdP3o6VWf9O5yXjgmU8onZG8DvqxinO1z2AiAFpv8WnWFdzeo6jJTtPvC3tzsUuXfgSOHAFsths=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487968; c=relaxed/simple;
	bh=T6GLTIia9mKd0cnIZJSFemaG8kWFXaIIqI1KznDE3M8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WhvANJTq6NPLkZK1peHsjBhcjh5xauTRo2bJMpD+PDAYUWlK3t7PLAUHHeGh6zaLjXQLcbXvbKN/oM4oK8ZdfjCQ8R2LhpsxpGAxwfpNkn0liVUiQ8+AX9sU6mAWzfJKcEEZ2GRGLqXuhxYcXFvMkV+KyZlWxpO/tE8lErSstD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MULS9Li5; arc=fail smtp.client-ip=52.101.62.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSd7ZKKeUa8iQDG2VidCEQzQVthg4DI1MorZmCkFipHZ6wq14YENWb77nj3VHYjnWeA6Ar49kkSlNNmDwIENIR7LdMuzhiyMYZO8GlfbhKzhcXAYYsXfQxN+Pe7NTVjpR8X9Mn5z06aFnb/OtJLiibOxLEBrGb1c7cOp65HkA1km2pHNnpo2z8KGkEKVSxMSmx7ok+8K8J4eBqAwxucCcwdtB3VDWxzRUa1yZ7Th2/VfXgh/bBnTF5EPpiYYvrp0mPCOVspCC5aBJOM5nnvZAVI57/wpbJe10MZ78Fm4063hrX1nBiYgMDcns1dnarQqmnT9yr8cSSXjdMVcnj/CTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6GLTIia9mKd0cnIZJSFemaG8kWFXaIIqI1KznDE3M8=;
 b=XrkjyLlqR7ZNqfrqRkukbKu/V3kyKCMrdd44dQa7/OVtLo3C0HD+orsmssWcV0AfcFn+YM7SyFQ9ceOZbDRNBuJ+QFUnbwhmwsF/hl3/USAxVF0ehzg7LR0sxNofMG1WtLfWjLub6nnjfy/xw0Np9BYPObhhxJS3fiF6tf59B8qwLNHiyOb098BREnhv5jc3aaR/p1yEaFfq/jup+MzKE0ha1NSjhiih8CLxeiyZhjwSNRO3fLPkJNr/KbO5Ob35HWeYPeqLasrsXQJb4Y26uhm+19XSsMEwnU/05XDXgVppe8C/lYEiiq6xOQjszQx8baJIg8SHJfERQKxsH8VY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6GLTIia9mKd0cnIZJSFemaG8kWFXaIIqI1KznDE3M8=;
 b=MULS9Li50O7OdjOnKHR9aAg037h9q8E0qAPHfRYZH4SpE9d0EOjV/+D3m/5Jwp5O1UQlGxSEff53O0PiyxEiqbqj0oCf0f2jt+q6PRyBvHSCyXX1Sh3/uOG2P7uwzpXfp5grZwY6WdblZVf5QO4wzalHblcumeQC9V0jfB4atqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7628.namprd12.prod.outlook.com (2603:10b6:208:436::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 14:39:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 14:39:13 +0000
Message-ID: <9058636d-cc18-4c8f-92cf-782fd8f771af@amd.com>
Date: Thu, 15 Jan 2026 15:39:00 +0100
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
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <97993761-5884-4ada-b345-9fb64819e02a@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 4314b057-eac4-4aba-9e88-08de5443da1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHQzekZMRHg4cjY3YTVUVUl4MmcxQVNKOTJUb04wYWxvSXRKdk9SWVJtN0d0?=
 =?utf-8?B?SXlIYTFpYU44ZWdTWmI4cGVHYllMNms4NGFuL0V6eEJQVHhnSi9Fajc0VER4?=
 =?utf-8?B?MXU1bU5raEZwUURieEN2MWlHdWVFMUVzN3d0R2RQcFBMTUVPVmI2UDI4QVpv?=
 =?utf-8?B?dlphWWVpL3QzWGQwVU00NE4rbjR4Vm9YQjRJN1Vja0VHOFQ2OTZxdmFla1ZT?=
 =?utf-8?B?eXZuNlNMYUZ0M2xhbkZFanB3aG1leVpxQlJDRktka3JOWG0wZ2M3bWhKTXBK?=
 =?utf-8?B?SGZ0QkEwNkxBTE9lZlBQOUtvU3FiV3ZmaGR0eXNQSi9QdW5ESUhuT0VvRzNy?=
 =?utf-8?B?eWJlVjVDSGlCd2dHN2VMZ3FTaE1TckhEUXhRVFpINjhVamRDTU1mbHVWZjBN?=
 =?utf-8?B?MmxRWVhPd1lmQWdvUjQ0ZWxmV296YzkwZ2lSNjlZcUFsdUNkZG1La0MwY09P?=
 =?utf-8?B?Z1picUNDNUVONFkxczI3enhXMXZjQmhRVEVSWXM3Sm9zSjg0SWwyOW52b0g0?=
 =?utf-8?B?a0F4WTlsendBVDVvaThWVnNuSWowT1diT0VxYTg5Tk5aNGlKQ2FwbGRvSUVV?=
 =?utf-8?B?T0NGOERDeU1YWjFPNUk4NURXdkVIRkltWmR5TWhzNUd3UVhVUEJEZ3B0MHFT?=
 =?utf-8?B?VHh5MmViSkZzL1Z6S1NvSjVaaVVxVG1aeFhzZlNqRDlUUThiQTgxZmRLRUVY?=
 =?utf-8?B?YUozMFZoeXExa2lxTzJzVzZ4cVhRWnlLa0NmZzZOd2MxU0xTbHBlbEFJbnpU?=
 =?utf-8?B?dkJzRDY0UTZrY21IM3RZaERyaU9LdnFNd2h1bk5LYzhvQnRKbTVXMWdwQllF?=
 =?utf-8?B?Nm5mWmlPWE5ySTFDdTFUUXRtMkpPMUdabjA4MllMdDBGZ0JCeTNRL2djN01M?=
 =?utf-8?B?dmF5dXpJS1ZtdU45YTBVTWo1YUhhZ09PTmo4anA5SzZHV1lyQ0d3RDM1N3ZQ?=
 =?utf-8?B?cUJ0cjVucXBsUG1ZdU1yTkdPcE5FQ1dHYUh5dDBwMERwS3ZmNDl2M0VEamVr?=
 =?utf-8?B?Uk5TMkF0S1hUZWxDaUQ4YU9EYkdnYk96cEJJTXdBS1VVOW1YZFY2cG9Ja2NR?=
 =?utf-8?B?cXVzYktNZ2tNZXRYc0Qwek81NzAxN3p4SHl2aXdsZUs5UWRGQTZSSndYQXRv?=
 =?utf-8?B?N1dNVXRadmlVaEFLbXFFcU1RalNqald1U2JQblpoSFpNV1A2d1UxZ283TElI?=
 =?utf-8?B?d0prN1lVQU0zbmdzNVo3LytQcU54OTNVTlB2MSs0OE0vVjZudlRxSnVWKzNE?=
 =?utf-8?B?WjJVc0VyeXpWUDMzeXhROEZxaUZmRWxValJObFB1K1dBUXFLQWpPRVRBRlFp?=
 =?utf-8?B?dmJaUmU1S3pqRGc0ejB6Q2YzVm9WSWNaeUZrWnJpMVhNbmR4Uit4eERjMlFV?=
 =?utf-8?B?QlBDNktvYzdveWpsMXM5NElqbXQ1OURwU3ozcnZWK1ZWN04wbVZmS2NQWEdv?=
 =?utf-8?B?TUluUWRGWmZIS2JNNHJBRWhjVGd5TVFoeDVEQ2lHTzBXNGRnZEpGUUVEclBG?=
 =?utf-8?B?d0pFcW1tTWc4WjFQSjFPazZWVG1tbVMwQXA0M3ZldzhMKytGdE1qWHR1RkMz?=
 =?utf-8?B?RmNxTENmSEpmNVJFaVdVeVNqNHBsQkQwa0tHREZBcTQ0T2lka01zTmdGU0g5?=
 =?utf-8?B?TERHT3MwVFpMc0tMSUlRdU91VTRBdGxOTXN1ZTkrMm9pTmdCMUZReWRoelVr?=
 =?utf-8?B?M2gvT3JYRjJDNXVGMHJvSXJRSjNEVGlhSzlwdkhQTjZjTndrUzFxZlVlUHlK?=
 =?utf-8?B?TCtiU01QK3FiajZmaUw2YmFsTUxrcTdNNHlqUmhyZEZlNk1hVUZ0Q21LeHdI?=
 =?utf-8?B?b2hYczAxY0U3d1FlOFN4Mk1VRlgvcitkaFFWMnJxMGMzMUsxdTJMeWpBOFls?=
 =?utf-8?B?QWx0RDgzOG5OSzdhbU5lWWNjSGRlanh3a0NVZmJhY3I1U3dNcW9lYWM4V1Ey?=
 =?utf-8?B?cjJBZlc0SlZkd0RCM2Y1V0JoL3VleTR4MEYzd08rbUY3UFBOc1pUUG5DRVpa?=
 =?utf-8?B?ancwOENSU2FpZ241QnpWbWN1WGN0WFZWbW5SRWI0dTgwVkxrTzE0UHF0MU9E?=
 =?utf-8?B?U2txZG40cVNXc3doVmZkUTkybm50bGI3SkwweHVZT3pJWXcvb2dnMkdPYlpF?=
 =?utf-8?Q?1Hf8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Smo4N2pHVGdVR0NEa3NDbEVNaTlpWWJ3dGhSdXFidDEvU29ValRYdzZ2SW13?=
 =?utf-8?B?SzA4RUFvTGVjRE94dG4wZmQ0S0NqemRsVGpHdVdrTU93Ympyd1lSNHQyQ3JI?=
 =?utf-8?B?a3I1UmxQOWY2M1VUWlo5NDJ2bEhlSVlLKzVMd2lyQnBrVENGOWQrckhIMEJT?=
 =?utf-8?B?VDJFZU92cGhuSFRqY3R5MC9reXpISlNWNkp1S1ZJaFdDVGR4WkJHQ01Jcmtt?=
 =?utf-8?B?RzluVGdWc3p5ejJ6S0pwd1liVVF5STF1OURKMWkwdXJ3OVVld1pjR1BPUGJ0?=
 =?utf-8?B?RDIxWkJ5T1RYK09aQ09SSUllbzhYSjVuem55YXRnUHFPQ0c5cnRjenlTdmZn?=
 =?utf-8?B?YUFMSFlXM1o2STVEUmVrTmFJaEdHdWkzRWgrSGtKenhXNlZDMmc3cWd6N3Z5?=
 =?utf-8?B?N0NmMnM1Qk5LaEp6UGNIa0pCbGhnNkkzaE14UEJaV1IxQkVZdEJJN0dWemZ0?=
 =?utf-8?B?d1pDeEx2OFNnd3I3dE9HUjZnTExpbGZid1RTVmZUV2x6Zm8vK0trVkQ1RG51?=
 =?utf-8?B?S0ZRUGxSWmQ1TFF4TEJ3SDNsaXNrQ200dVNrY3N3L1F2bGc2OWkyYVdRbEJU?=
 =?utf-8?B?U2VSa2lNeVpDbDlZam5BemgvZ2JiS1l2VmRkOVA0b3VuZFNzdzNGeGc2M1BC?=
 =?utf-8?B?anFMY0xLTU5QOFozQWs3a1dJRTdaM2Y4RHFvL0lQYWRrVUt6S0pCL0tpYkdw?=
 =?utf-8?B?WXpJeEF2SnVINjRmZ1FOYU5XcGZTYnVuYWNEaG93WkVEZE50ZHZKbWk3SXJ1?=
 =?utf-8?B?V0xabkpmeW1xeTZTOWgrNWdEYmlBMHBrcjZxWkNaY3lZVHNOQnZ6OXZNR1ly?=
 =?utf-8?B?NHhQTm5rWWJNWEV0RVJxZlhZZXU4OUFPNi9VdWcvL0FaQ0pwRGo5NFhjUDhk?=
 =?utf-8?B?SDBwTXBzdERQRnhMeVZ3SlBKQURQdTM4WnkxUHJuQ05ud3ZYV1dSaTAxU09B?=
 =?utf-8?B?T2NQa1hJZnhTa3ROWEN4YzM3aE1wK01xS2pkUWllOXYzTlFMYWp2M3QrMnFi?=
 =?utf-8?B?UytJOThoSTVUMHpPbjg4QjRxNCtNTk94bnRudUUwR29rWUZTOUlnL0lyZWdV?=
 =?utf-8?B?NkVpdCtFRXBxTnF6SVppU1pWREZGRTg0d1B6a3o1S1ZqVC9jLzBLZlJKS3Y3?=
 =?utf-8?B?M2hBUVhYQklKazNiRjQ0c0xRaGJOVG8wMU9UTGlnM1BBOUh5MUV1bWpFWldx?=
 =?utf-8?B?VC9YYTdRUTVWQXZ2blpoOWRuZGcrQU5VV25SMDZPWGZXYUZWSEtnbDZiazJi?=
 =?utf-8?B?UzVPZml3cEk1UkRRZmJGN1B2Z3hVcEhDMmg2a2tIMnRqMWRGUTVoNkZtY1BY?=
 =?utf-8?B?enNSaDZ0MkVRQ1lmRkxTMkRHZnlGL2RaUkV6Y2pMWm1FU2tYM00veGc1V1pV?=
 =?utf-8?B?eVc3TzMzL1AyQVp2YkYxdjdKS1Vld1hNNmthNWM0UTAvK25YNm1TSHE4WXdl?=
 =?utf-8?B?eVc4NEc0TnRjTW9ISHJqTlpaTG91T2gyb3FieHpwK1BZYXVhZXhFVEl5QnRl?=
 =?utf-8?B?Y1QyeW5GQWhqcVdLNVdMc1lKNUY4UEpnV1puR0RPNFNMSWZOelhjZnFPczcv?=
 =?utf-8?B?Y2kzTGdCeEVuRFR4QkJlWEEyVUF2QmU5Qm1NVTlyTTV4L2dUS21NZEVMV1NE?=
 =?utf-8?B?cmE0VkdIN1k3T2I4ODVaZHpBOVl0dDF3cXR2Uy9GT29sTUtSUy9oOXBBMzhZ?=
 =?utf-8?B?ZGhEZ3pMZmpVMjVyNUJnOFRYdm1COEVJeGcwZy93djF4ZzkxeVg5UjJOOVVt?=
 =?utf-8?B?TWFCYWw2TUlBZU14M09RdGV3WjQza2dXdEJiNHZ2OU5rVm1HRmJJN0loRXZq?=
 =?utf-8?B?YTN5UWVKZGFlUFNlZ0tBQXRQRVZidHMrN2tnaHdWaW52QXhyb3dpMm5ZWWlX?=
 =?utf-8?B?c1FITjVMMXdERjZlMmFVdUs4Vnc5RUhQU2UvSEJFc1Fzc2dVVGtSTG41QXVr?=
 =?utf-8?B?REREVjVZTGVuSkpoQS9rZ09zY3Y0S3A4Tng3QmcydHlYZ3lqYXZ1cHNwamVl?=
 =?utf-8?B?bDMvK0ZxTERoWW1ZaGFqNFd2TWVaSkVSb3ZMQUFMYkVPcUg4Z1JtVWoxYlQz?=
 =?utf-8?B?bmYydWxCWk40QTM5WjlldFd0QlZkcXlveUdqcmczNk5PTWovUVUyVlcrT0ov?=
 =?utf-8?B?a29xYXV4YzdIY1pQVWdWcHoxMUZQRTREVzdRdHhLdXdjOHEwVXZTbFV6WFN6?=
 =?utf-8?B?ZmdKc2Fwc2sxV3BRNm9lTVFwNGNkRDRPbFFZcGFOeC9sS1UycDFrNXROckNy?=
 =?utf-8?B?a1JwNTBtTUtCUzc3Uk1nZnNORFM4czVpSXBYVzdtemdON080ck1zSDhHTnJD?=
 =?utf-8?Q?2ME/JpxcXAEvnzpXVS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4314b057-eac4-4aba-9e88-08de5443da1d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 14:39:13.5343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5lH4lQ34hFXrYd7MuXg9KWxYQU0kZJ+nvvXcKBeN/ajb4e+Jh6EqJqaQz0rMRr3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7628

Sorry to being late, but I only now realized what you are doing here.

On 1/15/26 12:02, Thomas Zimmermann wrote:
> Hi,
>=20
> apologies for the delay. I wanted to reply and then forgot about it.
>=20
> Am 10.01.26 um 05:52 schrieb Zack Rusin:
>> On Fri, Jan 9, 2026 at 5:34=E2=80=AFAM Thomas Zimmermann <tzimmermann@su=
se.de> wrote:
>>> Hi
>>>
>>> Am 29.12.25 um 22:58 schrieb Zack Rusin:
>>>> Almost a rite of passage for every DRM developer and most Linux users
>>>> is upgrading your DRM driver/updating boot flags/changing some config
>>>> and having DRM driver fail at probe resulting in a blank screen.
>>>>
>>>> Currently there's no way to recover from DRM driver probe failure. PCI
>>>> DRM driver explicitly throw out the existing sysfb to get exclusive
>>>> access to PCI resources so if the probe fails the system is left witho=
ut
>>>> a functioning display driver.
>>>>
>>>> Add code to sysfb to recever system framebuffer when DRM driver's prob=
e
>>>> fails. This means that a DRM driver that fails to load reloads the sys=
tem
>>>> framebuffer driver.
>>>>
>>>> This works best with simpledrm. Without it Xorg won't recover because
>>>> it still tries to load the vendor specific driver which ends up usuall=
y
>>>> not working at all. With simpledrm the system recovers really nicely
>>>> ending up with a working console and not a blank screen.
>>>>
>>>> There's a caveat in that some hardware might require some special magi=
c
>>>> register write to recover EFI display. I'd appreciate it a lot if
>>>> maintainers could introduce a temporary failure in their drivers
>>>> probe to validate that the sysfb recovers and they get a working conso=
le.
>>>> The easiest way to double check it is by adding:
>>>> =C2=A0=C2=A0 /* XXX: Temporary failure to test sysfb restore - REMOVE =
BEFORE COMMIT */
>>>> =C2=A0=C2=A0 dev_info(&pdev->dev, "Testing sysfb restore: forcing prob=
e failure\n");
>>>> =C2=A0=C2=A0 ret =3D -EINVAL;
>>>> =C2=A0=C2=A0 goto out_error;
>>>> or such right after the devm_aperture_remove_conflicting_pci_devices .
>>> Recovering the display like that is guess work and will at best work
>>> with simple discrete devices where the framebuffer is always located in
>>> a confined graphics aperture.
>>>
>>> But the problem you're trying to solve is a real one.
>>>
>>> What we'd want to do instead is to take the initial hardware state into
>>> account when we do the initial mode-setting operation.
>>>
>>> The first step is to move each driver's remove_conflicting_devices call
>>> to the latest possible location in the probe function. We usually do it
>>> first, because that's easy. But on most hardware, it could happen much
>>> later.
>> Well, some drivers (vbox, vmwgfx, bochs and currus-qemu) do it because
>> they request pci regions which is going to fail otherwise. Because
>> grabbining the pci resources is in general the very first thing that
>> those drivers need to do to setup anything, we
>> remove_conflicting_devices first or at least very early.
>=20
> To my knowledge, requesting resources is more about correctness than a ha=
rd requirement to use an I/O or memory range. Has this changed?

Nope that is not correct.

At least for AMD GPUs remove_conflicting_devices() really early is necessar=
y because otherwise some operations just result in a spontaneous system reb=
oot.=09

For example resizing the PCIe BAR giving access to VRAM or disabling VGA em=
ulation (which AFAIK is used for EFI as well) is only possible when the VGA=
 or EFI framebuffer driver is kicked out first.

And disabling VGA emulation is among the absolutely first steps you do to t=
ake over the scanout config.

So I absolutely clearly have to reject the amdgpu patch in this series, tha=
t will break tons of use cases.

Regards,
Christian.

>> I also don't think it's possible or even desirable by some drivers to
>> reuse the initial state, good example here is vmwgfx where by default
>> some people will setup their vm's with e.g. 8mb ram, when the vmwgfx
>> loads we allow scanning out from system memory, so you can set your vm
>> up with 8mb of vram but still use 4k resolutions when the driver
>> loads, this way the suspend size of the vm is very predictable (tiny
>> vram plus whatever ram was setup) while still allowing a lot of
>> flexibility.
>=20
> If there's no initial state to switch from, the first modeset can fail wh=
ile leaving the display unusable. There's no way around that. Going back to=
 the old state is not an option unless the driver has been written to suppo=
rt this.
>=20
> The case of vmwgfx is special, but does not effect the overall problem. F=
or vmwgfx, it would be best to import that initial state and support a tran=
sparent modeset from vram to system memory (and back) at least during this =
initial state.
>=20
>=20
>>
>> In general I think however this is planned it's two or three separate se=
ries:
>> 1) infrastructure to reload the sysfb driver (what this series is)
>> 2) making sure that drivers that do want to recover cleanly actually
>> clean out all the state on exit properly,
>> 3) abstracting at least some of that cleanup in some driver independent =
way
>=20
> That's really not going to work. For example, in the current series, you =
invoke devm_aperture_remove_conflicting_pci_devices_done() after drm_mode_r=
eset(), drm_dev_register() and drm_client_setup(). Each of these calls can =
modify hardware state. In the case of _register() and _setup(), the DRM cli=
ents can perform a modeset, which destroys the initial hardware state. Patc=
h 1 of this series removes the sysfb device/driver entirely. That should be=
 a no-go as it significantly complicates recovery. For example, if the nati=
ve drivers failed from an allocation failure, the sysfb device/driver is no=
t likely to come back either. As the very first thing, the series should st=
ate which failures is is going to resolve, - failed hardware init, - invali=
d initial modesetting, - runtime errors (such ENOMEM, failed firmware loadi=
ng), - others? And then specify how a recovery to sysfb could look in each =
supported scenario. In terms of implementation, make any transition between=
 drivers
> gradually. The native driver needs to acquire the hardware resource (fram=
ebuffer and I/O apertures) without unloading the sysfb driver. Luckily ther=
e's struct drm_device.unplug, which does that. [1] Flipping this field disa=
bles hardware access for DRM drivers. All sysfb drivers support this. To ge=
t the sysfb drivers ready, I suggest dedicated helpers for each drivers ape=
rture. The aperture helpers can use these callback to flip the DRM driver o=
ff and on again. For example, efidrm could do this as a minimum: int efidrm=
_aperture_suspend() { dev->unplug =3D true; remove_resource(/*framebuffer a=
perture*/) return 0 } int efidrm_aperture_resume() { insert_resource(/*fram=
ebuffer aperture*/) dev->unplug =3D false; return 0 } struct aperture_funcs=
 efidrm_aperture_funcs { .suspend =3D efidrm_aperture_suspend, .resume =3D =
efidrm_aperture_resume, } Pass this struct when efidrm acquires the framebu=
ffer aperture, so that the aperture helpers can control the behavior of efi=
drm. With this, a multi-
> step takeover from sysfb to native driver can be tried. It's still a mass=
ive effort that requires an audit of each driver's probing logic. There's n=
o copy-paste pattern AFAICT. I suggest to pick one simple driver first and =
make a prototype. Let me also say that I DO like the general idea you're pr=
oposing. But if it was easy, we would likely have done it already. Best reg=
ards Thomas
>>
>> z
>=20


