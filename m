Return-Path: <linux-efi+bounces-4715-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABADB5085D
	for <lists+linux-efi@lfdr.de>; Tue,  9 Sep 2025 23:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8B627B7876
	for <lists+linux-efi@lfdr.de>; Tue,  9 Sep 2025 21:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C7025BEF1;
	Tue,  9 Sep 2025 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q5TZh0mR"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E775C253951;
	Tue,  9 Sep 2025 21:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757454255; cv=fail; b=mji1z5BYeSwW1F78H7Dk3px46e5008EoHR0pZ5Bg8WhbdYRH4TqU+Z8BMMWIKP6fVWFMv03b2RGerJA0tvdjK3JEmuySz1gP5nUJdWI+xVVRymf6A/+SXKfWL9Y5Z1vBmVyoIqekfEQq5eia+6QnrRpk0ppBzGe7YYGm5/DzYBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757454255; c=relaxed/simple;
	bh=+YWfx+HhtLNhWuyAaNWAwKbFJzkBCZuy3UIF1HldTH8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZzwFftBx2gxphzZ4DQ6j7+I9RBWR/OdzmmDM19bNPR3A3ELu9QSklU2hBCLrEKixnLXWFjJekI6HV4FwylUuulEaYDDPFRSX6x9wgmwKKmi7Dy4zG9v2jx6RuSfPJIblHSxZALV6jIQaZNfaas7DfD4omH7WI03uO//2Nvr+GZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q5TZh0mR; arc=fail smtp.client-ip=40.107.100.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdNERtjfCF39RH41/y+LeO5ch2P9Z6vUcg6SqBFVScTtV5418e/4ZwX/G94+hd2Bn0OF228tC14h8DC57cwseM/gjI2sPoBqZiDs+lkR/g3yhzlBFwGPtgyzwQZfDQIbxV/XfbKIty/XFglXzqK6cISFwUkmFXex4DeluD1PDXct1IdKahp3Va6B2u4aiHgBi4jBLQvgrLb6cy7IdZeMsm6IgYWKRtHzDzfnAbuSItn3Fm8CSMcfHKWihzz8Y3iaLhBQ9fpJXb5lnT3HI9l0zwHAxGWXzXAoVRtrwKIkPiIDfOD65dDvpFstLPP2uhGvszPmhkP+8YAnJZYuRjMe1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4O8OLcB4pXBE9PuO2a6rEKbbM3jhnQKHyWwIulLwEDw=;
 b=rXY9pPimACFuRqTffU8zaht/bjqpffAZYMiADlQO94uoI8vE2YpjMdrDBEThLKaGaOoNpXSZTMDCroBw8xmDMxj4QQbSGWNe4wqA+C+zNTF4mfcDbAHMHTQfdDrIRgpQcYGmoqiU6KH/oAQL5LCI8thc6Mkxk7e0I7+tcrZcisTSePGIbmDZFC96/UNZmLe+ysH3rP0vCm7p0w+SKIROQCbhhXU+sYDuxANQFl+Vq9s2Zal61KOmbANK94BYfgjYiSJr9JOK1lqw/b/LiYeZ6p8vGpoDxZAjaoK2e6YAFE+sDADqvdCAMMJLht//A4rlKYLxPsEFoRky/B/Sq7iWtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4O8OLcB4pXBE9PuO2a6rEKbbM3jhnQKHyWwIulLwEDw=;
 b=Q5TZh0mRsqlI/rN3eHkyGKYW6CLFtFPjZb0OlBpDGHn2ATX2v71Udefj37pTBuWl6r2vRDBAyqv20x5yi/zrERbZdF4vQvy/h1Ru8LhSCkNX0bmAkSF8q+FP5yoZmRSsl2lAgafnTP/c8Y9ABh0fOAMJ4joT/lD35PLNEo/vq8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 21:44:11 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%3]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 21:44:09 +0000
Message-ID: <fbb24767-0e06-d1d6-36e0-1757d98aca66@amd.com>
Date: Tue, 9 Sep 2025 16:44:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 01/22] x86/sev: Separate MSR and GHCB based snp_cpuid()
 via a callback
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb+git@google.com>,
 Michael Roth <michael.roth@amd.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Kevin Loughlin <kevinloughlin@google.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Nikunj A Dadhania <nikunj@amd.com>
References: <20250828102202.1849035-24-ardb+git@google.com>
 <20250828102202.1849035-25-ardb+git@google.com>
 <20250828153317.GJaLB2vSvuR20WzgQV@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250828153317.GJaLB2vSvuR20WzgQV@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:806:120::12) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: dc8a9820-52c3-4dec-ea8e-08ddefea0249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0lqZDdqTDRXZi9zVmJHOFREUjBKdnhzTHdmUTFiNGtpUTdBbk5ka05WaElu?=
 =?utf-8?B?ZDZQM2o2eXJydnJrR0ZYRmdiM21WTmtPa3Z1c3paT2JscEJkcHdIZ2VCZk9x?=
 =?utf-8?B?SHNROVdqRnI5ZzJYNU5xYjRMOFZNSElxQzZsQ3ZXSjhFN0NmYkQyRmRFdXhP?=
 =?utf-8?B?M3RVRHBTeko2YnBJdEVzSHZZd2taVG5MR2VoRER0d0x5SVlLMTBEdUp1VlBC?=
 =?utf-8?B?Y2xSKytRWVRMclNiWkNzOEtBRE0rZCttN095NFhnSHlrTXZKdCt0c2kwdlM1?=
 =?utf-8?B?SVVrTWx0aHo4dWthVThCTml4aTJhVzUzZTdVM2tGbVV0d3BoVWxWWHlTSzM1?=
 =?utf-8?B?QXZhQS9tREFCekVaRGJYVDRDdkpZRXNJWTNaZDU0UThoZEdUQ05YRTZxcHpw?=
 =?utf-8?B?S1RJaVpRUEVRZHBFWnVFalhmZGdvYjJXM2RoYVNXeG1UVVArbzBONmxkMFBG?=
 =?utf-8?B?K1ZDUDRObmJ1alBIMCs0VThCb3pJZ2JEYmwrVjhMRlNicnBTelByR3BjOVdT?=
 =?utf-8?B?Mk1sVkVZM0gwNW1SMUk4MjZoVkFKaW5sSTNBSWVjUEkzZTRyRFl1dkxrTXUr?=
 =?utf-8?B?dElzN2JTaXQrSXRSWTBZdEhjbXErUUlsc24vL0llbDNoQnkzZjAycENNOXlr?=
 =?utf-8?B?VitHNDhMcFFyb0cvNGwzbFNUY1dwNlV5YU1jaDllVGRYYnpjQ25zQTViN1pL?=
 =?utf-8?B?T1h5bmg0cmJQV2JxTWRUWjdzSmtYZ1VaVTIyTEJJWno5SVFQZGZzUGZ1d2ll?=
 =?utf-8?B?T0lYWHg2SXlYWGtEQjJRMkwyenhKSW5BdThmYngrbEQwVFFIN0J4TXlVSHBR?=
 =?utf-8?B?VGdCUTJUN2U1R01hOWhtYkRMTDRhNVAxRVhnWVcrU0oxbTFLQkRRd01vNTQv?=
 =?utf-8?B?UWhBK3h0cFhlU3RDanpMMXY0ODZVWFVORE5nOWN0djBWQWR4RnBFR3hVTFpn?=
 =?utf-8?B?cllGVWtIY1dOWE1rUHl4U29RSFpTOHlRUjlid2hxQS9oU2lqbmErd0JUUUNS?=
 =?utf-8?B?dEdmVlY3OWJyNWNRU0xuTW54Vm0rQ21iQUswU29kU3ZBQ1FaeSt6QXc2a1J1?=
 =?utf-8?B?aGEyWnIreFBiRDBiOU1zQlJEUTJwZEVNcWdhNHpJc3ZXWGJhQzdmVUtKYVdk?=
 =?utf-8?B?Q2ZjR0hwUk91UTNlQ3Y4MHBxck9uYkJmU0UzeERsNUxpWkxiY05kWmQ0RURD?=
 =?utf-8?B?UmNZcEhvbVlzMVBwVnNNZE1WZW5HcERVcGI4UE96Q3hVcTNuMmNnV1B0U0sr?=
 =?utf-8?B?dEJCbnN1SUt0RVpzOTJMRUdUWjE2UXRWb05GS0JQbUdtaVJpMXQyU0RYWlU2?=
 =?utf-8?B?OHcyQ21GVmUzQ0VCQkx3QmZTYVNXbHZnKzJlVW9BSkpKUHFaa1R2YUdnTjRu?=
 =?utf-8?B?NlZiMWF6RkUzSWhqSzZEQmJYbWtRSi9wV25wVHROa2tpTE1rWW91T0ZXcVFm?=
 =?utf-8?B?bGVPMUozYlkrT0lzcTdoSzZYRUcyTFliNVMxNVlKb01rcnVFcFlBVFVHdFJK?=
 =?utf-8?B?cFNFbTJKTjFJR0dLd1JFSTVWTTltNVZRaTE0d3piOUVkQzFNT3g0WDRQN3dI?=
 =?utf-8?B?d3FnZE93L0h5b2xWdEhBSjlFYVNEWkd2VWk4eldoa2xwM0R1OXpoMmVhNG1q?=
 =?utf-8?B?UG9yZDlyZncxWlJiOU9icytxelBuQ2Q0N1pReDUvS25HK2ttSEs2b3hMV2tx?=
 =?utf-8?B?dFhlUXpKRFk3MUxmd3ZqSTNuS1RaejZQZDJuMG1qYXpXQ3lkbzhGR1hudXBS?=
 =?utf-8?B?amd1NEtkTFVNakZ4WVNERHFxVlFkZDhjNHkwOEU2dUZpR0pJVW5Bck80b3ha?=
 =?utf-8?B?QW5NRzF5ckl4QVh6WTcyazFRMnczQ0VpRE5Wdmx1V2h4SUQ0MFhGcGlXOGZI?=
 =?utf-8?B?ZWx6QUZ3MFVhQURwcUlJVnJhYWw5WnJxdmdaZlFlZXBGeFgrOWRxOWl2R1hI?=
 =?utf-8?Q?ZEvYJW5+xWg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tk41SE9IeVNmK2VHQWNwaU1wYXcxYlYzbU1ldjB3VWFzUGpTandWZCtORC9D?=
 =?utf-8?B?ajJFcTlDVmxsQnJQUEhzcHdDWkNhU3NZZ2Q5YzBnK0taRUJSZVJFUEpIWmRE?=
 =?utf-8?B?bnlZemVXbnAwREwreSs2ZC9TNDViaEZhNGJMZ1hUdlJFdzdld0huM1Vlek14?=
 =?utf-8?B?Z2wxSjVGMkV0TnVMWVJhckNwSE9UVWJVYUw1cDh4TTBQRWFsYUZZTXA0M1NQ?=
 =?utf-8?B?bkNkdmM5UDNwN3JJSHpDR2luMm1hbHFhWXRDNWVQTFBuZHFNajBlK0RvSjdH?=
 =?utf-8?B?TFVxc01tSC9ZWXRORURCUXd0Y0hZMTlYVW1RTmlWZWowMWQrZlVnUFl2ZUdq?=
 =?utf-8?B?MGUvVHQxNG9qenhJWVVsWFhaaDU2UWE1eGt2eGx6YlpodlpOdzFkd0JaTDF0?=
 =?utf-8?B?Tkw4R2lueStkTm9od1dKR214OFhvN25VZjV1N0tLWFhYWDY3VDlWRWJSa2cr?=
 =?utf-8?B?K1FwUUlKWkc2dGNOY0JTWGt3ZGZybUZOdloyVnVnL2piM0FHNU15WVBNNytW?=
 =?utf-8?B?VUQ1czJISVQ3SVZwamV3YWpjRWxoY2NZS00zSHNTek44alhISDZWeEY2S3ZV?=
 =?utf-8?B?RXFsYjFKTnYxNFA0cDkvQWpRbmZtVUdZa254LzRqeHc2U3BLLzVHMmgvSjR6?=
 =?utf-8?B?aTB0aTN3OGFMRy9ORFJvUzNhQVYyNnc5KzU1dVI4NjlhWkxOQmtENlpvTFVE?=
 =?utf-8?B?OEJpeUhMV1plUml1Sk9BdmYzK0ZmZmEzSUdZL3dqbzRWK0Q5K2ZySys1d0hU?=
 =?utf-8?B?MG5YRE92RjdDVW1oQjJMZEg5NVpXZkd2aUIwT0tmNUE1VDRCQTlQSkREbG1M?=
 =?utf-8?B?aEswekFzdjdLNlZXVkdzNkxKUHdpbjVVVjhrVFdaY0l2TFNPOFBRRGV3QzRY?=
 =?utf-8?B?eDQwM2N6RGFFclNPMlZib3pVQm4yUTdPemhMZTBoQlZyVWhHQ0ZocWx2MDFL?=
 =?utf-8?B?aEJ4MFZoMU4xTVRIS2dwaUg0YmI1V3lKeHR4RU9HYXVWcmVHc3lzNHhZMlhY?=
 =?utf-8?B?YU1jL2UyOXVqOXdoSEJiNFlYVlJLKyswc2huS1VzU2VYaDN0VWx0c3l1VmMv?=
 =?utf-8?B?c2s2L0thY0FBcVNZbFlRaHdrVEVZTkhaa3IzNlBkOUxnMkJNcW9kZFY3RWF5?=
 =?utf-8?B?aVdwV2tQdk1mTEpVenlpdFEycU9VLzYxcHdoS1l6T3UrQVg1ZnhLeGRjMWhZ?=
 =?utf-8?B?RGRweTZyMndiekxUODI3T2tUcFdzSmtoWTFVWXhIODFTdW50SVhJV2NXTnQz?=
 =?utf-8?B?dG5nQ2d1b1pCZ2dvSGs3aFNTUTZvRStERnNuQmIydWtFOXZOT2laVmIvc0NS?=
 =?utf-8?B?S2tlUDBlK2hYdWQ1Z1dSdThlYnN0MHFaK1VybEx3RXlUY2xvTzE2bWU5ZWY5?=
 =?utf-8?B?aC9WTlJnNC96NnU0TkE5RW5sRE1LSDJ2S0ZQUk95NDRyN3JaQmdwbVlkQTQ5?=
 =?utf-8?B?RU5yaGpNQllDRnVCS0lhOEZhMnF6SkNuaS9nVUZmNU1CUSsxOW91MHU3c1oz?=
 =?utf-8?B?OWNES1RlSFkyUTc2VmFhTzQveVpuQmY3ZzB0Z0xucUluaTJmTCtvOXFpclVB?=
 =?utf-8?B?K05LRzY1Z3VOUG1GRzlrMUd3WE8rOE41S1U4aUdmVXlST2MybXR1UWo0MUlJ?=
 =?utf-8?B?WmEwaWJyQUtsMmxYK1ZxNXdDU0doOHVMaWdTZmhaemhlY1h1MjF2TTUvelFp?=
 =?utf-8?B?MkY3QVdVbzhjM1EyRExsVjZYVlZRSWs3WVJ0eXNZdmZ3SFc5VzdhYXAzK09V?=
 =?utf-8?B?L0tTTE5OT1RsUDdDT0FaMktxb0VEWitkOXdlbTZYUDhVZjJLYlJBM3pGWTh6?=
 =?utf-8?B?SkRtTzk5N3pQcnREbHZYYlhONEVrQTZxaWtOQWRhaTR1V2syZ1ZNL0wvUmZF?=
 =?utf-8?B?MXI3eTlNMmZ6V0lZTVVEeWNnNmJ3b3ZmbklLdFpiYWo4SWh2SWliWVYzSFBa?=
 =?utf-8?B?TUsvZkRsbmQ3UENQcExDdlM1azZsN0RhWHlKYU9lSFhVdzNkWDFWVkw4Ym9a?=
 =?utf-8?B?SlhkL1FKMXFidFJ0UWt4Q2hZUXg0MUJXcDF3WDhHUXlUYlRIakt3aWo2cVJm?=
 =?utf-8?B?ejlqVDNydGtkY0wrdTVHK3kxeUhvQU15L2ZxMVJ0VWZlb2Q5QTllOVFaU1Jp?=
 =?utf-8?Q?oygGYU7QFHVG7aBU5CWA1qi4N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8a9820-52c3-4dec-ea8e-08ddefea0249
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 21:44:09.8612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfLv5kDenXtMGomMvX2qXx0XrgbR7E9SUhsgU2/xNvGiDqO/XNwmkjyE9Np/dpc20eYW/EHyM/h8U3x68i6sJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410

On 8/28/25 10:33, Borislav Petkov wrote:
> + Joerg and Mike to doublecheck me.
> 
> On Thu, Aug 28, 2025 at 12:22:04PM +0200, Ard Biesheuvel wrote:
>> @@ -648,7 +611,7 @@ void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
>>  	leaf.fn = fn;
>>  	leaf.subfn = subfn;
>>  
>> -	ret = snp_cpuid(NULL, NULL, &leaf);
>> +	ret = snp_cpuid(snp_cpuid_hv_msr, NULL, &leaf);
>>  	if (!ret)
>>  		goto cpuid_done;
>>  
> 
> So this code becomes now:
> 
> ---
>         ret = snp_cpuid(snp_cpuid_hv_msr, NULL, &leaf);
>         if (!ret)
>                 goto cpuid_done;
> 
> <--- tries to find the CPUID leaf in the CPUID table
> <--- otherwise uses the MSR protocol to read CPUID from HV and massage it

It only uses the MSR protocol for particular CPUID values in
snp_cpuid_postprocess(). If the CPUID leaf isn't in the CPUID table,
then it will set the CPUID values to all 0 and then call the
post-processing routine which may or may not call the HV.

The second call to __sev_cpuid_hv_msr() only happens if there is no
CPUID table - which will be the case for SEV-ES. So you can't remove the
second call.

Thanks,
Tom

> 
>         if (ret != -EOPNOTSUPP)
>                 goto fail;
> 
>         if (__sev_cpuid_hv_msr(&leaf))
>                 goto fail;
> 
> <--- and now it tries to do the same - do CPUID over MSR protocol.
> 
> This flow made sense before your change because it'll try to use the GHCB
> protocol but you're zapping that now so, IOW, you can zap that second call
> too:
> 
> 
> diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
> index ed88dfe7605e..fbfdfe0dce70 100644
> --- a/arch/x86/boot/startup/sev-shared.c
> +++ b/arch/x86/boot/startup/sev-shared.c
> @@ -612,16 +612,9 @@ void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
>  	leaf.subfn = subfn;
>  
>  	ret = snp_cpuid(snp_cpuid_hv_msr, NULL, &leaf);
> -	if (!ret)
> -		goto cpuid_done;
> -
> -	if (ret != -EOPNOTSUPP)
> -		goto fail;
> -
> -	if (__sev_cpuid_hv_msr(&leaf))
> +	if (ret && ret != -EOPNOTSUPP)
>  		goto fail;
>  
> -cpuid_done:
>  	regs->ax = leaf.eax;
>  	regs->bx = leaf.ebx;
>  	regs->cx = leaf.ecx;
> 

