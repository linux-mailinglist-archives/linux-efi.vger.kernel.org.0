Return-Path: <linux-efi+bounces-4716-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DC6B5085F
	for <lists+linux-efi@lfdr.de>; Tue,  9 Sep 2025 23:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF4A4E7C15
	for <lists+linux-efi@lfdr.de>; Tue,  9 Sep 2025 21:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744B5231845;
	Tue,  9 Sep 2025 21:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OXHW+Umy"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF14A22156B;
	Tue,  9 Sep 2025 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757454334; cv=fail; b=VyUSWhtVIVXmaIp3QQPtfVtfqcM+wKrtXfvL9zw4xKPCAYCeG0lALSTaC9aTbdSoHQU1C5riVn7FjCYkz3crr5zheS+rIkGOEfscCclVp6wNaZghry7eUp6aMYdMo3sZ65eI1AEauQfYWrGhXILeCXij+M597vjpCkFJu9X3xyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757454334; c=relaxed/simple;
	bh=Y7c/48FoDA9PVSsg+R0FtUFiHYqe5XN/2qUSBNBg89U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GSY2hAOYcQz03kFwIjrRbOAupW5cA70tYXXSl8iQMEIRpbAmuFLATlpC9qwUs21sanV3LV3K+38PmzMZrzaLFdJWeVTLfQZcLBYEJRwMzRDlUTdzRy34bqpI4Z3k/JlsVGcbAFe5ThW+vDjH8EzAjxEJJqppQ+P7+wgeK/q1F9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OXHW+Umy; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4Xvv6wke9z7ZxcRmo/qxoBMxOotvGn7TAa+LWA1ljNhF+CDxdy9ncY6WQmFVCszS3CG1VAYlXZB1P8qKmFll9j4Kc8+xgj+pEC22AC5EvFF6fJ5zHgW1aB9hijRZBRQTVpeqb65EdZFbqJFIEfk8MzajqO5ZsDb1Rha5h6rvHTJtZTF/dMlD1j3UkjrcnkTIGAJNL7rSwQDeZmihyBjW6Tq2pxa3QiqFF3kg+ImCx/7SoPhbUKm1+noPdpFjGiMvBy2K5kfsV+UIKGPQPh1tbFNnwOSQTWoWCvPyWjcKR14epzjhbv3EqsPnIjG+AcTYQ9rvpumZvZpho0wJRDFqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbMJBVZyYxmHGizgNCatpFX7e8oWkzgDqop8UzKxcuc=;
 b=OiU3YxZ1pAn8X8sZ1U8mo7I44P6FiANVlGHR8RpHxSpMCVxOneCS596rW7FFi9PaBmOZlnvmJrF3eaefBKmQt+xfUSPzmY5dqim1yW160KuD8L9QEH16uSNYAv8yGk/1HkgrgYWw9cNeSMnzf2pNHS28Fj3P33U1bRq76Pnn7IR0RJr/q2LzeOVgphmHDnuqlHsUErGRV2vV58rhMU3tdPIOjxoxbNKt061HN39PXBVYPq0Df9qWpSZlX+/kUCASrZFz4UtKMEL35fjwctM7XiPcTiI8Q3HbKFSdnhIs4QCTDi2pDTXEOMVZ0g0Z48wuYUb78Ou0LjNOgMo7NGIdvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbMJBVZyYxmHGizgNCatpFX7e8oWkzgDqop8UzKxcuc=;
 b=OXHW+UmyzrIcT5MsJa8MefeDlhY+1WEfQCgu/RMCeh6tre3vX6jlWRIyropOsqHlDNtk4ihMhbQ9IhKIOy63kg+/g/KH/NL+a9OOClxNl/eZ3LE7hV4PBQCY/qhwmKRjZvegePlNZzAwcBvHuv5IEtcoapXhtX/+pXH19KQbJtg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SA1PR12MB8858.namprd12.prod.outlook.com (2603:10b6:806:385::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 21:45:30 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%3]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 21:45:30 +0000
Message-ID: <f82d0b0d-641e-7961-67e2-c4d953b9a3d9@amd.com>
Date: Tue, 9 Sep 2025 16:45:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 01/22] x86/sev: Separate MSR and GHCB based snp_cpuid()
 via a callback
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, Michael Roth
 <michael.roth@amd.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
 Ingo Molnar <mingo@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Nikunj A Dadhania <nikunj@amd.com>
References: <20250828102202.1849035-24-ardb+git@google.com>
 <20250828102202.1849035-25-ardb+git@google.com>
 <20250828153317.GJaLB2vSvuR20WzgQV@fat_crate.local>
 <CAMj1kXFa5j2AoUWNvOmfBrQxg_hjwwPrCZSKickNwYjZ8RxkVA@mail.gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAMj1kXFa5j2AoUWNvOmfBrQxg_hjwwPrCZSKickNwYjZ8RxkVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:806:120::33) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SA1PR12MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: 907bf5ed-a913-43cc-06dd-08ddefea321f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1ZTSWRhOWluYVg0S2pZTCtWQ21RZ3FXQk5aeWt3RDMyVksxc0FLWUNBaExs?=
 =?utf-8?B?UEtad093c2pXUjllRGdVNENGMEZQcVdHQjZJcHNWWVM1VWpPbUV6cU1TcitW?=
 =?utf-8?B?OUxld1lwRlhjaVVnaWdxUGlCbTdmRDNXYmFHVVNTcUdVWWMzU00vOWhPbTFm?=
 =?utf-8?B?RXNCeWhYd0JvRUJuV29vMWlPbmZ4ejVFOG5KODc5bFIxbjQ5RS9QY3RvY0Iy?=
 =?utf-8?B?V3hJVzBPVVNEd1E1WFNvbUQ4N3Z3RStpYnhnZk4zWVRpYVJjU09TRzlJVEdR?=
 =?utf-8?B?eG9yditaeUpFRnFDZ2NnbjdyOHlxZ3I4d0xxekFydk0xTWNZMjlGbnphTHFz?=
 =?utf-8?B?NmtpU1EwQkhpZ2p6TFQxZ25GOXppdlRPQWpEUExMd0o2N3dyaUhpL3RyUzI3?=
 =?utf-8?B?cmV6NzNCaUNFK013ZVhhdVBsUmJtZCtmdEtKRVhraVhXTnRRZXQxWjR5aW9y?=
 =?utf-8?B?MDlicWU2dkV6WFBHMjFiSjRscXpsWkNtcHNmRS9SNkJBYm56SlVtWWRqdkg5?=
 =?utf-8?B?MVBibENJV0RWcHdBVVhVR2p3Sm1SbG1oZDJqb2pRMUd5S3NhSEN1UC8wbEo0?=
 =?utf-8?B?cGk5Z3VTQ0FGSFh4eGRWWkZNcEJVWkNmN0gwaC82ZENCU0UxM0V6N0QzV0lW?=
 =?utf-8?B?VDlHRC9zZlJIODJ6bzMwYmRqVk9YKzA3SVRvZEx0b2dNZ01oMWFqSFpOOTlm?=
 =?utf-8?B?MGRHeVBIU3Bxa0k0OE43RDFhZVJmd2NMZGRZOWJuZ2FjUlJoUVpXMDZNKy9V?=
 =?utf-8?B?d1lTRXJnd0g1QldPZDdtaGxFelVEVllnSGNJaThBdjRwUGdDYnhMdkxaUjdD?=
 =?utf-8?B?c1NaSGRvNEozNEdzaWRQN2h5b0wzU0pTTTZSZEN3eFd3bHJxd0RLNmNrVTly?=
 =?utf-8?B?cGR6aFY5Z3YwR29RVWJJa05yVkRNYm02Y256ZWhTaitzK01NWWNLdEwvRm1H?=
 =?utf-8?B?WWFQSS9ENi9YR1BCeHkxNEREd0lQSlQxT1g2ZW5Gc3Z6VkkwVnN3aU1uZHF2?=
 =?utf-8?B?SWZRRnp3RUJFUTJWU29aYTJXWnI2SmR4bnpZRkNPYVVQTnovU29EbWpmME95?=
 =?utf-8?B?S1NPSmMzWllVRjRZYkpHZXNtSEtLNHhwMXUwTXRRMEM5STZtUEorU3NEQUZZ?=
 =?utf-8?B?SSs3Y21YWjNETTlZOEpBZEtnRFp5ZnhCYm5EQlVjaFRySkx6UWR0ZXdKdDJu?=
 =?utf-8?B?WUgvVEtqb1E4OTBNaElHMG5Kcm5PekU5cUw0TjAzcHp1U1lYcTl4WG9Pdi9n?=
 =?utf-8?B?MzIrbWI0NVhHZE1aUTNmclZqNlhKWkVuNndlRTlJWEdOOGpzTnh5MmRqZCtw?=
 =?utf-8?B?ckU4OUlRMFVHKytNc1RaOWtPN3E2VUs3TzQ3b1J5RWtlOXJnbFJET2dsWHMx?=
 =?utf-8?B?UWd4a28yREkxTVl4S29yams4YmZYVzNPTndGT3NrS0ZQMzkrbThFWXZKQmIr?=
 =?utf-8?B?SThaUTZwU2s2aGVyQ3p2UGhKNmtuY2lVM21zSXZqMXBnUUdqZmdKWlI1aXFh?=
 =?utf-8?B?SW5GbVplTXNpaWtOTSs1amd1S0RxR1ArdWM5K0djT0pMcG5KQ2N5VGhzZVpx?=
 =?utf-8?B?aDROVHJIMjR4Q2RQTy9uUjRHN25vNnFidUQ2NzdBazkwOS95b09YajJEQ0pt?=
 =?utf-8?B?YTBjU3BsekhNMExUaTRZeDFZR01DNHdSYVFRUkdEZnhLa2pQOGxUc0RvYzFi?=
 =?utf-8?B?N2UxK29jaXB1UWNFYUp5VWRWQTU2eFZ5dEVESkYvaHdRazcySDhHZHFkNWhT?=
 =?utf-8?B?S3JpcDkzSlNldlc4OW0wRThCTm41TUVSNjQ4dExqd0NvRktuMmlIZCsrclZy?=
 =?utf-8?B?ekUyOEc3REpDZDdDSW8rTDBhR2hQRktoYmxaQXd0cVpseWQreFgwMllwRDV1?=
 =?utf-8?B?VXFVMks2NHVtQnFxb05LNGZkWlJNNVdtbGJSaG5nQkR4Rk1OWmk2aGtJTHhj?=
 =?utf-8?Q?d7UqadlsLJU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enhTYzVOTGc5Q2ljY1VIZndkNS9DUnVSMndHSndZemFVZzZ4WGdFL3FPUUpG?=
 =?utf-8?B?UkJ3Y1RpTkkyTmlKbGdlR1EvN2hidjhKODB5YnBWU2Q0SDR4eWtNcGs5V202?=
 =?utf-8?B?em9ibFpkNndON29rS05jWnQ4Tm9NYTNXMVQwUHdqRFNSM1ZtZHFVQzJnVVo2?=
 =?utf-8?B?eXRoNmJLRWtpSGtSaDZ2V0pZV1pzMjRDTkJwblExcFh3ekJyVE15TEdjWXVI?=
 =?utf-8?B?MHd5anlNbDRmVzlIVkhWYmJ5cjl1dkJreDBocjhZN1dwUkZSTzhJQUJ6L0Ev?=
 =?utf-8?B?aEIvRk1naU9vQmNIeSt3dVJZdVZZNUU5alVmUVVKUWRmRFBGVDVnMkNLVjRo?=
 =?utf-8?B?dzdFbjhMd1k2MElEYXFHcnNYN1hlSk9ZMis2OXdSd01DVEZyVFI3bUV6aEdP?=
 =?utf-8?B?em9RTXFOblJleHI4MEJvVWJTMXJLTmZoelFaTXNEdW56VThmdURHYjZnNnpP?=
 =?utf-8?B?TVdFbU1RdU83ZjRmMWRnMDJqbUg3MzltWUEvV2JvcU90RW1SemVQb3ozenVM?=
 =?utf-8?B?UmJ6dWtQbkdNMDk1NmdNVXN0cy9xQlZxZ2E2a1h6aW1BYU8wUklsOXIzVldx?=
 =?utf-8?B?RkRObEJBenZTOWZrOEpVUXdHLzJMZldtWnNKWlc4R2paamYwVllhL05GNEhn?=
 =?utf-8?B?ZWdxTlRObnZEd2oxYWRrYThoUzBDMVVoUEdWTHNVbEx0NDA1T0xKV3VjK2Y3?=
 =?utf-8?B?a2FGNnI4TVFhV1cybU9yYmJEd0IvMFpYZTF0V3lERmQ0aGthSWJ2MmRma2F2?=
 =?utf-8?B?Q08vM0s5OTBYcnVxdTNMRnZ5aUh4TXc1SUV0ODdDUkhWMGtEWmMwb2dzakVm?=
 =?utf-8?B?djRuN3RUZ2pqYTV2YTNEcTY0TFlTemtSVFpkSnd5amhWV2d6OHhCa1FQUWc2?=
 =?utf-8?B?YUFySDhYMjBSQ21LKzF3bUVxTHNsWHR0RFBJeTBFK0xxSFgrNkJ0czkrN1U3?=
 =?utf-8?B?ZlJPS0pVaUpqTXNBemtUMlJBOGh6eDFTMVZwY0puNG90VUY4VnM0OW92TTEv?=
 =?utf-8?B?VUJjdGFqZTZjRmVJUGsvOFAwWUdXWHdadlRYWllYQnU5M0svK1JOU2pwdWlw?=
 =?utf-8?B?Q3phSmFrMEVuVU85YWtZU3lxT1h4M0VyMXplanlrdndCL0EvTkdadnRQd3NT?=
 =?utf-8?B?dUptMFBmcmhBZnFURU1DZ0dTVVc3eXpJMkJockplMXRtUFhIWnhSWjhpVnRJ?=
 =?utf-8?B?ZGRuUTQ2QlNCemV0SWxjRXZBNEdtMDBhdi9GQnZGM05YcXdWU3NKS1Q5eGNG?=
 =?utf-8?B?TnZqZFBRUDc1cTZNTS8wOGZ6SEs3bVFPR3ZhNVF4SGhnN0VIckV1bURpdHQy?=
 =?utf-8?B?UFFjNlVKTllOTkJ2YTZ0V2RhY2R1WFlXWStNQ04wMUVMeVlYOExSY0dXL2Na?=
 =?utf-8?B?aXFodVpucThMeklhOHZBdjNnWk41NHZtSmQ0Q0FtaWhhdnRBelViNVBnb21I?=
 =?utf-8?B?emxZR09XWjNqcFl2aWt3cVNveHZLVnJGU3g2TS8rSFhaMHpyN2pYWkVVTFVI?=
 =?utf-8?B?RlpxMnJDNzlHQ3E3bUkra0lKV01sREljUnhqbThBbW5aQkMyUFVTc2tWOXJw?=
 =?utf-8?B?dklNYVJWUlhubmI3a2dwU3paQUdIMWg1TGE4WmtUWk1YdldCV1JJNno5OVZU?=
 =?utf-8?B?NUoyVEhydDlUVGorNVc2VU85YTZDWndMK0ovZ0JRRFJDeFVONzU5ZnJ6S09L?=
 =?utf-8?B?b0w2T01RdzRmSTc4T1RPSk5oRWJaNWd0Sm5ocEM2MmJVYlArQzhoOTlGRkxv?=
 =?utf-8?B?cjR4eUFHR25kU0Nwc3JRdW9sRlN1dWw5czNESm1pQkl2cERQb2FxTjRPM2No?=
 =?utf-8?B?MkpKbTRiaEJUbzNGaFZoeFBuNFBEK1NnV0VoWUlNaVhrMVAvNzNCQ3VValBw?=
 =?utf-8?B?Z0ZBeFAzd1BrWkZXUU9uRmNvQ01pVzBrV21WKzR2L3k4aVk5b3lEMWQxa0Mx?=
 =?utf-8?B?aEU2SnVKVEpobWxScmRwbllxeENLRWNJUHNlR2Q4cVRXd1dneUl3VTdWTjND?=
 =?utf-8?B?dmNSYnJUNTlEajQxeFBEUTdqYi9HZVg4Z09jTGV5bWEwSWhNSm1ESFhFMUlR?=
 =?utf-8?B?blFZQ2c4OWdScnNTZGJSQXZPc3lKOUt3c0ZoOG9BZDFWOFpsazV1TEgvMHRu?=
 =?utf-8?Q?UMhKCD1hMswCvPO4L3m8Ibmyg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907bf5ed-a913-43cc-06dd-08ddefea321f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 21:45:30.0375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RV/kQoF47kf6vQZyggeoITIGbY6oVPFn45CF5T6ONEd/JZQ91bb+Glg4yIIiDGBp73Omc6TGkWuP1yATB7zRXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8858

On 8/28/25 11:14, Ard Biesheuvel wrote:
> On Thu, 28 Aug 2025 at 17:33, Borislav Petkov <bp@alien8.de> wrote:
>>
>> + Joerg and Mike to doublecheck me.
>>
>> On Thu, Aug 28, 2025 at 12:22:04PM +0200, Ard Biesheuvel wrote:
>>> @@ -648,7 +611,7 @@ void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
>>>       leaf.fn = fn;
>>>       leaf.subfn = subfn;
>>>
>>> -     ret = snp_cpuid(NULL, NULL, &leaf);
>>> +     ret = snp_cpuid(snp_cpuid_hv_msr, NULL, &leaf);
>>>       if (!ret)
>>>               goto cpuid_done;
>>>
>>
>> So this code becomes now:
>>
>> ---
>>         ret = snp_cpuid(snp_cpuid_hv_msr, NULL, &leaf);
>>         if (!ret)
>>                 goto cpuid_done;
>>
>> <--- tries to find the CPUID leaf in the CPUID table
>> <--- otherwise uses the MSR protocol to read CPUID from HV and massage it
>>
>>         if (ret != -EOPNOTSUPP)
>>                 goto fail;
>>
>>         if (__sev_cpuid_hv_msr(&leaf))
>>                 goto fail;
>>
>> <--- and now it tries to do the same - do CPUID over MSR protocol.
>>
>> This flow made sense before your change because it'll try to use the GHCB
>> protocol but you're zapping that now so, IOW, you can zap that second call
>> too:
>>
>>
>> diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
>> index ed88dfe7605e..fbfdfe0dce70 100644
>> --- a/arch/x86/boot/startup/sev-shared.c
>> +++ b/arch/x86/boot/startup/sev-shared.c
>> @@ -612,16 +612,9 @@ void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
>>         leaf.subfn = subfn;
>>
>>         ret = snp_cpuid(snp_cpuid_hv_msr, NULL, &leaf);
>> -       if (!ret)
>> -               goto cpuid_done;
>> -
>> -       if (ret != -EOPNOTSUPP)
>> -               goto fail;
>> -
>> -       if (__sev_cpuid_hv_msr(&leaf))
>> +       if (ret && ret != -EOPNOTSUPP)
>>                 goto fail;
>>
>> -cpuid_done:
>>         regs->ax = leaf.eax;
>>         regs->bx = leaf.ebx;
>>         regs->cx = leaf.ecx;
>>
> 
> This seems plausible but I'm not sure I understand 100% why this
> fallback logic was introduced in the first place, so I'll defer to the
> experts here.

The fallback logic is for supporting SNP guests (which will have a CPUID
table) and SEV-ES guest (which won't have a CPUID table).

Thanks,
Tom

