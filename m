Return-Path: <linux-efi+bounces-4725-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8B4B5187F
	for <lists+linux-efi@lfdr.de>; Wed, 10 Sep 2025 15:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9411C830B6
	for <lists+linux-efi@lfdr.de>; Wed, 10 Sep 2025 13:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F629320A3C;
	Wed, 10 Sep 2025 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2Xz6lmIw"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21C5320A29;
	Wed, 10 Sep 2025 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512659; cv=fail; b=IJCjo7S+JTJWnVz8K+zSHgkg1NOBjgvLHRzJ8vCOojblBOrjqcNpY+P/JmhGJfQUtRk5Vlr1LMzGgq6aX7PXWcwv/2wk0sSno8vPvk0xdjqwRXzYCS2SBERd4ebBvICVDt+EqVRoGoj6yEu1hm8p9WA7JfXweyIJTzQbhfrBvz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512659; c=relaxed/simple;
	bh=T5KwrfI6hCSwR7PtjWiVEShNWJKrGbqIH3czB09PDDU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nqemWIfZbIP5G42rfjaD3l1p5yfRyvRTNwTLCHzxV/4xAKaHxrQG5WlJSRWCn0vkvRsxtzAtXyKZHrAjaxQpbBqsED4atnF1bK9/BbBAQmjzn5BhWwdKPwXReskbjBfdJcCdHLNQpYaC5QdhqZHHEjHE3mhdyVGrQ7T5E6M4bQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2Xz6lmIw; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiohqANYrzRRFk9ybQZU82KV4H+aNB3A5fcaWl84n/W7DkpLyCl2IazhM8n8yZzw8K9+I+YbrKgACenzoonZnPxztWmYvFAySp217EQ98wjtdhy4CtxWUE2KTZ7hvDL3PTaqopuaOjDXLBIvVArB23wIJFxG6PFUUJG3Iy0rGqtu0nK9sleGU2TqYR6Rr4OBiRVv+zYPQ6dbfB947nyHf2evtlhZO2i6fJPHhNp+J/TZjUnm/JB+1oLnvhEQexMoVTjAkyPPDaXNFIHBatjx+FWCwaAm27sGlYuWCfsp5hTp6XUoABRn1N/ufw2R04lxbLBpgfWV2sAULfefx+ajdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2OxWzQMWMtK/H5JgqI8YfBIaqdrAkRNnpg5juY3EwU=;
 b=koZ7Tu1RKL5OqUJ3OxYJKfqLQYlgZfnt12QF/RXCj2jCSg9K+Evln65+8ia8Bpog9JLqdfriVWwM0+oFvi/bJIhiRTZ7JMwFEt1I2wf1E0xSkWPOY0ioGBWANw4j0KsuZ+w/fxHtHCSkusSEiP5WX1W0Q7CbpupS5zJYvB85JVwHy5J2WfzCEF4ywIkAJSqBZVvTaY3tbpSJ8CZDMDTOUdqf3A8kBbhhcPrzFZ2Bw23Xqv7+67RSBw9Dysj9+hkxU4Hd0YT1iwMyr5dkxEVCPf70nGy1spZYf8e/a5ornW0fLvVMvNr2ge0paeVf5xzmEAmB6G4P0mddyCuBIjSoPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2OxWzQMWMtK/H5JgqI8YfBIaqdrAkRNnpg5juY3EwU=;
 b=2Xz6lmIwDn6pnH8bWh0Z8nTDW7uZeBfbhK86HJYW6kfR/TWnid3QB7CylfxW0lgczGbfsOVPpah7pZNLLria/sl3gEB31Ci/tgjj4OFIXXSgBX5vnyA5hVzco9RrLbVKZisAgJwdYbAqXVrbjMGw5lMi2h+6a6ukGs7taZGA8zQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 13:57:31 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%3]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 13:57:28 +0000
Message-ID: <4914b8ad-6a9e-75df-4f57-13529ca9b58d@amd.com>
Date: Wed, 10 Sep 2025 08:57:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 01/22] x86/sev: Separate MSR and GHCB based snp_cpuid()
 via a callback
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, Michael Roth
 <michael.roth@amd.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Kevin Loughlin <kevinloughlin@google.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Nikunj A Dadhania <nikunj@amd.com>
References: <20250828102202.1849035-24-ardb+git@google.com>
 <20250828102202.1849035-25-ardb+git@google.com>
 <20250828153317.GJaLB2vSvuR20WzgQV@fat_crate.local>
 <fbb24767-0e06-d1d6-36e0-1757d98aca66@amd.com>
 <20250909222045.GDaMCoPUqawgEenBsF@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250909222045.GDaMCoPUqawgEenBsF@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0175.namprd13.prod.outlook.com
 (2603:10b6:806:28::30) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: bba8f1d5-757a-4c15-a849-08ddf071facb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXRmREpETUhMOFVSRjN0MUl6S3N1UDIvV3JEdHdLTHN2eUlhY1hOQXlHakxm?=
 =?utf-8?B?eVBpMzlQRzd2Ti9lcWpsQ0xWRUtqeDA2aWZERkRLbklZaDdkM0o1dTNoZjc0?=
 =?utf-8?B?ajVXQ2YwQk8yUUZ5cmJGbm94RlpWNUMxVnpJU1VXVm8vTVFkYXQrcHIzMG1M?=
 =?utf-8?B?RUtyT2o0MWJNOVNrU0ZCUmUyZVNoTzZEdWs0TFFpY2tHbEgyQy82c1J2M1VR?=
 =?utf-8?B?UDYzSmVrZk1ydGNlcXlWM0I2SUUvNm5OdG1JNEtubkhwRGlnaHY0UUk4K3RI?=
 =?utf-8?B?d1RJcUgyY0xXOTZIRHBZbVJ1Vml5N0R4bmNUandzemhTcXpSNDR3TFZmU2hs?=
 =?utf-8?B?RzU1TUhrR0xia2NwMXBHOU54bk5EbmhlZjltdWlxR2ZlOHh4VEtscjFpaWN0?=
 =?utf-8?B?aW5tZHNmNElsYlloZExDTHdKNDIrQmVLSFNXVlFXZ1czdC9XOWwvalBRZ3Vz?=
 =?utf-8?B?Y1RiTGVPZGJhYzF0UW9pQW1hK3E3QzRsUFVybTRIakZwbVFxUWtQNXhOVEND?=
 =?utf-8?B?dWhEMjVqYnllYTBKTzc3dzVDQ0w2Zk1ieFBqanl0cTdtVXBBUnl1Mm96RkhC?=
 =?utf-8?B?d092bzk0SC9LVHNXSUEvVFZXKzlLaHF1LzFEN1ZDMUZSUENwWHFuWGF1T2xU?=
 =?utf-8?B?SUZwRW1UbXBaNG9tNVNrQWdueVNPL3JTRk5rZ20xRjJsNk5OSEJXaUVXSVhI?=
 =?utf-8?B?VEIzZDdZSHBHbjd6bThEK2s0ejl4QlpkQ051K2Z2bk4zRVdONUgyaFdKQWFV?=
 =?utf-8?B?ZWhzeDNrdFZxUG4yTVVXT0tFem55MVJrQm1YZjZjU1hra1pzK2V0djZqRXU3?=
 =?utf-8?B?elhMSGFzaW5zWStncnpkVW11QUROTEdNdTBiSnN2SkYzR0VHUkl1UWZpOExq?=
 =?utf-8?B?Zm9aZjVDV3ZVc2lMS3NNcE4xZXlvT2FNOXF6VjBzaWo0N3VpdTBlZFQwT3ZN?=
 =?utf-8?B?bGx6WVZKdkM0a0RQTTRybkJEajlvSG5qdUFiV01YRWxEM0pUYklDcjlENTRU?=
 =?utf-8?B?aEp4a1lDZm5VZ2VucjBtV2VlUjVxVlY1OGdCVVFnK0Zkd0thYUYwdkxlSDRs?=
 =?utf-8?B?UUJkL1dPczdEZFNoZ0w2c1NQV3BReG43VFp3eFEzV0U2TW1Sb25QeWhpSGFE?=
 =?utf-8?B?N0tOQXZwTzNrVGlmWVBIQVZ1YXZzZjdud2tkQVNOU21BZ3FXQWVibXNFWk1P?=
 =?utf-8?B?M29Eb3l3UUVDbHlFcXNkZFpJY2ZhUmd3SFh2OEdkLzNjYVh0WTZ5Q0x6MXg3?=
 =?utf-8?B?VDJqM1YrelF5ZXEyMXN5K2ZVbHpZcklSQVVDVEc3eDd5SDV3dGhQMDNTSVNL?=
 =?utf-8?B?SWZhQWVkYUJZdEg4WUo3emhkUGRMcGxRYzVuUkkwVGRNYTZWeXdNOStPTEZz?=
 =?utf-8?B?UDJXVFZPWjlBTGp6VFZoc2RZeldMVkcyYWpPT3dTTzVmRkF2aHNUOE1uNVp2?=
 =?utf-8?B?SHZvR0I1MWsvOER5QytPYXIydFVYVkk5SnppT2JzVWVEUk1RZWttUVVWUTBq?=
 =?utf-8?B?T2pYdkFsKzh2ckdaSWZGWUxvZkJKTDcvOTNXaXVnZzNOQ0N1ZFR4N3oxSlVx?=
 =?utf-8?B?ZlZ6TUlmaEhUODFUZmliQVFpVzF6R1NsM2ZJQ0JWV2NlaVQ4RWZONDNUSllW?=
 =?utf-8?B?SmNScEpXVnBHVTA2eWpOMDZqK1dQamprbmpBRVRvbzhWcFhkZSsyR0s0L3dJ?=
 =?utf-8?B?YzU1VWl2SlhFcUFhOFJiMTE5ZmordThuMUpSRGw0ME9QL1V4TzBvWWxDS1ZU?=
 =?utf-8?B?QVRTUkR0TzQ4TFluaVc3REtJaEJhaWlqWElFdGNzQkx6QVZiV0d3S0lrQXhS?=
 =?utf-8?B?NEpRVVVJa29MQ0k5dnhidGw5eTdmdktDOTMwVDcvU2xyWGZNcGZpOEdCVVJw?=
 =?utf-8?B?OU9aWmJheVBOWDFJYzJHV0JqT3o0RGlSekREWUVueVNnMDJacHdXcHFUYXpK?=
 =?utf-8?Q?wZuwKPfyEnM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDJSbnU5Rm9HVlJpaGVhTzdQNENBckcrdC9CajFoaVFrMnZRZ0FxanBlMlJz?=
 =?utf-8?B?N1psTEo5d3oyelFTRUdQR1A4Tk5EamQ3bGUzSjlPa3Y0OExOczVhVCtVVGkr?=
 =?utf-8?B?VnllN0w4bFVGRHFrUDljTm5pU0VxY2dIWlNNN1labEJwR0dGYzdicng2U0Ji?=
 =?utf-8?B?RmhOajlqUmZzbzhPQXlmeFZxdmJGUEtpcHJqUWFTR2JEZG5qSWRKQjdqYUJ2?=
 =?utf-8?B?dzdKU2tPSlNSaC82RGFpSDJ0YlE3QkxqZUE1WUcwWWlIRUJMSkRUamwydVZq?=
 =?utf-8?B?YlEyN3o5YlZqRTZlT1hQM2c0c2s2dE9RdTd5emFUVFZqQ3JqelRkeGZNaXdu?=
 =?utf-8?B?eFlKRWlEZmN2Vld1RTIxZ3VPcVB6ekVDcFhFT2xxMnhYZXBvcDB3KzRWRThQ?=
 =?utf-8?B?ZnZZamRIYVNoL0ZSZHBQblFhazRFalVYK3RDVGQ5aExBRllRUjV1eXNVSG5H?=
 =?utf-8?B?dVkyaE0reFV1U25mUEE4L3o5UW5paHpFNi92ZUZNdW1ZZFJ4alNWMy9OWlV2?=
 =?utf-8?B?UDYwZWRDS3NpLzdQYmZBcHc4ZitvQU50WUZ4Z2FITWdpTGhXZkV1SERSZkZH?=
 =?utf-8?B?WUI5TmdYemVOK3FZWVdIMDVGTjVPSFRId3lqeWRoTkcxSnRPZFc5QkpjaHFt?=
 =?utf-8?B?SXZPdm1TaWV6V0tNZ3lIMDkvL3V4dGU5TUZtMjkwTXVoeVRyTUMxeXBpNDM5?=
 =?utf-8?B?NHBNOWJKd0JGV0ZETG9OWCswK1RaK1c5bDBUWU9wOTMvYWJrVnRDTFFMYzll?=
 =?utf-8?B?WWlqRDY0bHRnMlR1NHV6MlhXaElRVGFQVXNGTlVHOWhNNVBZZmtJa2g4WGRY?=
 =?utf-8?B?aGFVdDV1dnE5UEFwaDZIUVVMbHlveUZWK1FxbUxtdldCc0xwSVRVbkYyakNV?=
 =?utf-8?B?aFlJT21SbmJ2Z3JJUXJxclE5TWN0SmhCTFY5SFRJUlZaaVZMTk85S2RTYVRa?=
 =?utf-8?B?VGtINTlYampIbGM3WTJlUHhQR0VBdlBsR1hXeXo0WTdyMW5WaU9oaVFwNEp5?=
 =?utf-8?B?L0FpdFBZR0dFd200ODhtQW5CUnB4dVpGK2N6V1FCbVlXVzljZW1NMFFUS3hj?=
 =?utf-8?B?NkRPRGw4RldialNaS2d2NjNzZjR6dEd4RWt5RUQ1UThyd28vN1MwdzhpRWpJ?=
 =?utf-8?B?WGdaZ1Q1TWFPQXlsUUJzUktFS0dyYStBT0NFVjY3RXJqWFQ3TmEwNm8xRHVU?=
 =?utf-8?B?Q3dpdmwra09ma0RxdWhzWmJHcjEzbmVWS2hsRHBlSG05TkEzZjJaaFF2bWJO?=
 =?utf-8?B?dkVyQVNnZGpaR3BjeS9VRnF5TXo5NEY0MFZvM2xpQnZJbTZKd2tYd1NmeDRR?=
 =?utf-8?B?UUwvL3l5eTRQVnVlZ3o0N1diOUMxeUR5bDFpeXNpRG1IcWxEN1UwSXVwaWlo?=
 =?utf-8?B?SnYwWmZXQzh4Y2ZvMGQwRklHRmRIdTgzVzNjQ2Fzb0RMQTVPRXBEdldrN2li?=
 =?utf-8?B?UmNadWlYVGxSS1BMaU1DMW9kQkVUaHJGSGlrREVIaDQ4SXR6L25LeER2bk5x?=
 =?utf-8?B?djNlaExoQW91enRNMFJXVERFUjU1Q2tzK1FEa0hBZFd0dDJlTTVaWVlNOHc4?=
 =?utf-8?B?TTllQ2xiOTRNdEhyRGdzZFFybHlHK2NXRTdlL2lnYXFlWU9VRllvaUt4cW41?=
 =?utf-8?B?ZGx3dUUvMDNrb0liUlRUZkZMSFQwTWgzTGk4TzZUOWxFR3VZUmtQUXBTWFpZ?=
 =?utf-8?B?SzFnTzAzL2xqTG9mWlpJdnBDS2tlNzYxR2JkcXp2NkROOHV3bVp3ODJyZWFI?=
 =?utf-8?B?NGFHRzNsRnI4UUpscVJVOHE0WmZ1QkZ0aCtXcVVXZVdPai8zVE5Od3RMZnQ1?=
 =?utf-8?B?TjJCUUVMTXFUb3N3WGJDR0oxVTRxczF4d2tRRmdWYzlOdktOZVZRZ0tMMGM3?=
 =?utf-8?B?NFpKTFVHTkpPci9vZ2lGakxpVlQvNlFGSVVrMVBPbTBGc1J4MnV3eHhNU0hL?=
 =?utf-8?B?ODRxcWdQa0NYdTQyamNSTXlMOGM1VFUrS3J1UlhaV3NJMGtkdmw1T0M5UU5v?=
 =?utf-8?B?TUhUVkxoZ2JiTFE4WGF6WThTY3B1ZXdwaW5nQUxvWkZWZW4wb0Q4SU1jNUh2?=
 =?utf-8?B?V2hGZmtuaS9lMHhvdjJIUURWVFIyZU8reXpUYjZ0d2FhV2srQ2xEa2dPKzcv?=
 =?utf-8?Q?vedOTj9CvHOAAvMYASrFAXjI6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba8f1d5-757a-4c15-a849-08ddf071facb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 13:57:28.8354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1yRJsYwRJF+jpq2SO55HK+7BTWaUq3NF13vEqb4IUcphRKT6aU7/V4fCA/E9AgCkDvESk2/FjoJppKuBQddhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013

On 9/9/25 17:20, Borislav Petkov wrote:
> On Tue, Sep 09, 2025 at 04:44:07PM -0500, Tom Lendacky wrote:
>> It only uses the MSR protocol for particular CPUID values in
>> snp_cpuid_postprocess(). If the CPUID leaf isn't in the CPUID table,
>> then it will set the CPUID values to all 0 and then call the
>> post-processing routine which may or may not call the HV.
>>
>> The second call to __sev_cpuid_hv_msr() only happens if there is no
>> CPUID table - which will be the case for SEV-ES. So you can't remove the
>> second call.
> 
> This needs to be turned into a proper comment, at least, and stuck above it as
> the situation there is clear as mud. Especially after the dropping of the GHCB
> protocol call, which makes the confusion even more probable...
> 
> I'll do it tomorrow if you don't beat me to it today. :)

Something like this?:

diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 08cc1568d8af..eb7a7b45f773 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -458,6 +458,13 @@ void do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 	leaf.fn = fn;
 	leaf.subfn = subfn;
 
+	/*
+	 * If SNP is active, then snp_cpuid() uses the CPUID table to obtain the
+	 * CPUID values (with possible HV interaction during post-processing of
+	 * the values). But if SNP is not active (no CPUID table present), then
+	 * snp_cpuid() returns -EOPNOTSUPP so that an SEV-ES guest can call the
+	 * HV to obtain the CPUID information.
+	 */
 	ret = snp_cpuid(snp_cpuid_hv_msr, NULL, &leaf);
 	if (!ret)
 		goto cpuid_done;
@@ -465,6 +472,10 @@ void do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 	if (ret != -EOPNOTSUPP)
 		goto fail;
 
+	/*
+	 * If we got here, we're an SEV-ES guest and need to invoke the HV for
+	 * the CPUID data.
+	 */
 	if (__sev_cpuid_hv_msr(&leaf))
 		goto fail;
 

> 

