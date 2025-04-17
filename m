Return-Path: <linux-efi+bounces-3353-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB152A92295
	for <lists+linux-efi@lfdr.de>; Thu, 17 Apr 2025 18:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4B417A2C1
	for <lists+linux-efi@lfdr.de>; Thu, 17 Apr 2025 16:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28268254867;
	Thu, 17 Apr 2025 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NTPFOw10"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6973025335A;
	Thu, 17 Apr 2025 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744906898; cv=fail; b=WwTsdtm8HUSdkvPHvdtuV8NEJMsaXiGrAaujdgMTYA3wYqiy4X8jcWc83dixsAUlheK0JKCwrOCGIFz7+vqpkVGzX8OSB565Z4HCPF6MiCMGQFHctzML3Du+T/zeHb1+FWgZVEzAmH6r3g9FBdRcWaMRKUTrLD5otGb2AgK4ce8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744906898; c=relaxed/simple;
	bh=GzAhXaiBu1jGW+/ZzPtMc4ZP4n3CWYWMZCXmed3TwSk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sobRR0JremN77zT8DCC5CedkSfyrRLMvTxHK9fpeYIDQHyzgZzS6zXF/UXA7W9c83L56poBlR3EqbHue7DerwITsmwYtte67RLt/GE/wF4s5ey0yLc5/XrZ+ZvwSQAvPeUjBrTlOAMwr6esz0TSCYCrtGXlsZ1HHcy+PS/3v0DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NTPFOw10; arc=fail smtp.client-ip=40.107.102.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNYbTrjQdUk/xvlunAwbg80dRNoMECg+NIR9k4wIRsZrFt6cj5qHwXwG7Fdc4sv+zUVbrj2o8+NnjTmDDSf3eyBmVdHW6+w5j6jwFBc3h6szx+YVEzv6VtCvseCjOMJh8xBm44uwWXaB/4QrRqHxQaX0SMkV2OIFbMuZBGwOqraUm/kyF/BYFGm3m1FprmP4JhL9jh0tBeMUN7od/NUaIapk3Tz/8ak272oRGEPERBiIvQLqsD0oOu+B4ARwMOLF8mT7zSmN8FH78RGLgmDy6Nuq8rKmFwUBMCIXWBxyW2o1y5mUNreF0cUFc/rfkERTdGR8lU3dye6B1ewZ+L0Jpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6GpVj3aO9O84Q1dge/kL0AhceqbB8xUxMH7a78LyIQ=;
 b=QIWq6bl5uZYQw/S3EbvTx5vmPcNqsSfNEj2rIguLimpaeHWH66PfWJs8wfSi662sXMqjz7UWpwD7mG54vMARPPy66UtP6RizxhGxZXDzA2xw4svD4werJ9AEzYLd3rmXPu4oUqMpQU/75fcTuDMTmjFqBA/3eMVUt6hMPunZI+jvpctPGeSpWMbE6R+FzO3CzI6sNQX4POdep6Jic4XdIP4ZMoLC1uxGV+m67fHrzf4FoW6q6pYbKtzus7xLDY484Q7MDL1WEdFmzi+Ce4pYwn2+CVQG7TLM9zZZhjmDf6TJ7mtY3npG2DZKjdGqcXmLQWSaziBHsg1LCtCVL/+/QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6GpVj3aO9O84Q1dge/kL0AhceqbB8xUxMH7a78LyIQ=;
 b=NTPFOw10+nYLA1YPnW6veE/P/nV5jC9yH5NAeWmbfgJD+KRw1Tyl0kw+L/sox7zk3ey86CDSI3lL7yvT8UI8gEDEyYf4Bxt2m+LkqjOAL2mpkwhvfyD4q+rbEgaKSxLpZ7tmTMvO/W1CCnkZ8uBnlPeBW42iJQ6ddFv7hquhdSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH7PR12MB9152.namprd12.prod.outlook.com (2603:10b6:510:2ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 16:21:31 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 16:21:31 +0000
Message-ID: <96762dec-616b-b906-02b3-e006d43a8535@amd.com>
Date: Thu, 17 Apr 2025 11:21:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] x86/boot/sev: Avoid shared GHCB page for early memory
 acceptance
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb+git@google.com>,
 linux-efi@vger.kernel.org, x86@kernel.org, mingo@kernel.org,
 linux-kernel@vger.kernel.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 Kevin Loughlin <kevinloughlin@google.com>
References: <20250410132850.3708703-2-ardb+git@google.com>
 <20250411184113.GBZ_liSYllx10eT-l1@renoirsky.local>
 <CAMj1kXEqWxokyJf_WUE5Owwz3fO6b-Wq8sSNxFmMVAA+Q47uPQ@mail.gmail.com>
 <3f2b0089-a641-1e0c-3558-0a8dc174d1ec@amd.com>
 <CAMj1kXGvLQwea2J0E72tMhY-9iDCTmQm3drrHCTLyZ=hCP_iAg@mail.gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAMj1kXGvLQwea2J0E72tMhY-9iDCTmQm3drrHCTLyZ=hCP_iAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0020.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::21) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH7PR12MB9152:EE_
X-MS-Office365-Filtering-Correlation-Id: b42530ad-a884-4581-953a-08dd7dcbea17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTJOMlBCVUdHMjRzeDRPTGIrWVJnV2ZHMjdMeXgvT0N4aHdKYXpXVjVmZzZN?=
 =?utf-8?B?SjNpWHVWUFZkU0FLSFJ5YjczNzYzWmJwVk81d1Q3MktFUXY1R1Bpemlab2ZY?=
 =?utf-8?B?K0hYWWJCMmRZNCtCbTd4T3UvKythdVh0RVI0OEhOdlhlZXJvOEdOakRNb2Iz?=
 =?utf-8?B?dm80dmZTaFRtTUFJZFpHR1VLdEFsLzZIOVBsUjdkaCtEek13VE5TNXdVdy92?=
 =?utf-8?B?ZzRLY3J4Zm9wT1RDNEFpejBUc0NMZGM3UEFjSEQwWHNoL2pCM0lpT05YK3Zp?=
 =?utf-8?B?cG0xV3VRMFhFQUdZVUtxa3R6R0ZIZVhjUmZtUUxpck11bksxOEtSbEhkOVNx?=
 =?utf-8?B?Rk1kdVpWVFNURjlRSk5uZGdvUmd0dTd6TURHa2wwUVZOSHdkOUU3MUxOVWRy?=
 =?utf-8?B?akd5K3FicHBuZTBzWHdmenU5M0xNZXFWWHU0RG5XTmxVOThKdUtNelFZMG4x?=
 =?utf-8?B?ejJkcWtJTUk0bFZmWURBeXVRODJxV1piT3c4alhMYWNaaU5KbEJTZ2JORmNy?=
 =?utf-8?B?YUJlSmtnMzNQTm9TU2pPbmFsd0pvSkVsQ3pRMXNRSFYvRjB1dzFOWmxhckNK?=
 =?utf-8?B?REJuRmtFYjljdGkwWDJrTXFGSldSZCtqY3pTdzkyb2FkSndJQnhjU2xxTW9s?=
 =?utf-8?B?Wkh1dmFFcElwd21NSk9uUnVtencvV0Y0OW0rZ0VsTmJUR0djbUNiTnNFQytD?=
 =?utf-8?B?ZHB1RHRrSUtvZFdNdmJVcHBpQWdvNjZ5R09Idy9sUER2NjYxOHFDYkhKL3FE?=
 =?utf-8?B?blRvUmdyYitDQmU2Wmk2RnA0YlFQTFdvQm1sSWZ6ejJhU0poMTFCZnd4cVdY?=
 =?utf-8?B?Y2RJNjd2aThSdms2cW1xUnowQ1E0cEJKTjE2bWxpWDE5ZU5RRURRdjJOcEFx?=
 =?utf-8?B?ZW01TmdENDdTbW5kcXdVUEs1MlZCckdGNnB6R0VlKytiSjE1R1k0NjN2SEM2?=
 =?utf-8?B?YitsYnNUM1dac09FWXd6QllsSXM2NWdDUWpXQWhES2ttWUZvRzREMGRqaHBX?=
 =?utf-8?B?SHJjRndCMWN5djl2TVk1MHNnSUI1SXBtUEZHZHRma1lVWVZUN2VWTkZjTTQ5?=
 =?utf-8?B?Y0VMdlZCb3Ria2NCY05kbnl3SHZWbW5Gd2w0S0x6NnBHdlg2Qithdm9xaVcx?=
 =?utf-8?B?aHZtT1FLd25JNUk1SWcyenNVY0FIQTg1Q3U0cWRTSnhYRnZtckVjMDhPQzR1?=
 =?utf-8?B?STBMYVJaTjhXRmFmdzhzQmFCOEpBZGNreDZTMlh4Q3pVcUtyMG45ajhkTHBK?=
 =?utf-8?B?RzVDMk5EOVJESW9XcjhKVXpua0p2dmI3RnNkZUtJOU5DOHBvZjhsb0ZUK0gz?=
 =?utf-8?B?d2VoZ0N4RTR4Y2ttTno2RFc1bFpRT1E4ejRVUWxqUllaUDJzenMrV3hibHcv?=
 =?utf-8?B?Q25OUkRJNURZRmZ4bjFtV2VmSHBNbENCZHNUK2toTDBaUmdiK0YzNG1Ndlkx?=
 =?utf-8?B?OVMrSjFMZ1NPOEg4ZlhtQWgwZTduWGQzSjZsb3JIcHVndE5EZUcwcGJDc01r?=
 =?utf-8?B?Slc0ZE9mNldWcy80QzYwU3hhMU1wc0ZhSGN0YUV6Wjc2UUwrRWxQUmtWWUM3?=
 =?utf-8?B?ZkdubHlJQ01sWG9Ed3l4V2EzWHN3cnBmVVBVR3J6dUx6NUd5QklvVklXSW5r?=
 =?utf-8?B?RzJFQjAycW5CUkZoT0d3Z2tpR2x0eXNHd2x6dEtQaDR6WE00cWhHemJ3TGhB?=
 =?utf-8?B?RDRzOWJDYTlGQ21pZGxpQXlhdFpKVWVnVTFaTStJTDJ3czFLRStaclRKNFNU?=
 =?utf-8?B?UzVEV0k1UFBYZ2NsYkZscC9LU0E4aG5KUVE5dWowWFFLaEZ4b1dGUnlPWWJQ?=
 =?utf-8?B?NGlTbzNTbmVkMnNSYUlCcHpoUFY1YWhMU0dkcXZFNnM0WUNUL1hRdlBiTmFP?=
 =?utf-8?B?R0RWQzlVZXJDekIyU2tHTnI4aTFORkpPREd6M0pIVGdMOEFMV0YzVkpTNUQ3?=
 =?utf-8?Q?gFrfxE0wohE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEg0cGhkK255ck5mbUZmNEV3aHhaR1E0Tno2NTltdWc1anRKL08rY2lRUytq?=
 =?utf-8?B?dlphWFo1NEE4bE9XakgreTZxWFlOZUpYNmZLM2l1bHpYeXg5R2MzRTVkNnND?=
 =?utf-8?B?TUxWbms3ZzVBVGhQWWJLS0s2YjlrN25VaDhudnJRVDEvTTJDQnd2cUFxL0tE?=
 =?utf-8?B?VXJteFhpWWd2YTFZdlRzaFZ4OHA0UEoySFowVk05MjJaL2o4RHhDOE0vRmE1?=
 =?utf-8?B?UW5QU3Bha1BsSEhLZzlsRXlWYURMVW9xc2xyT3FKY3JDdjh4MUVsYTFaVWFF?=
 =?utf-8?B?NTZSYmVZT3hjYXBSc3ZoNlVkSjdEcGpRNmtIaXpWeWJ0akdabU95Uzhha21z?=
 =?utf-8?B?eGlFUUVwM2ZLQVozK1ZoVXdMRytLMXp6ZTA3M05KTmpHbzlyM0EvUzZVVVVM?=
 =?utf-8?B?N21COFQwbUlXcTdXOE9lVXpxUEgzZUdFcnRuUDlDL0x1TTZZYnVhT3lwM1Rm?=
 =?utf-8?B?UUdrQXVmVXA5LzJmeThlc2duNUNFYjRUeHRFa2tSU3BiZjN5OUJiREdubm9O?=
 =?utf-8?B?QWRQYWhVckYvWXRnZ0FSZDR4OXpwaHgzVk1HTml0VnhZcDZoM2x1UkV5MzFP?=
 =?utf-8?B?VGhZNXhTcFpPWUFBQUZHaCsrVGd2NFh0WW1TUUhsT01WSFRYSHNnVDFxRGdY?=
 =?utf-8?B?a3ZjS3YybkppOHhrN05qc2RyS0ZvVytjNG1LaG0wT1Y1b2pLOFQ5OW5KdXBG?=
 =?utf-8?B?QThhdFNoc2UxQjZHTmcyL0hkMFptTi9GZ3AvZkNYc1JLdk9iOUZtekJNVVlF?=
 =?utf-8?B?Q2t2MUdVVS9aRkZDQW56VW9xQW8vbWo2MUdscnNVMEpWclA0bExYbVRrL3di?=
 =?utf-8?B?Mkkvc2hSUGlpa2JqV0ExNUU2UUpjNDJPV3dwdkg1V01ybU5NYXhJU2ptbUtt?=
 =?utf-8?B?dVg2ejVQeE1oazBNOHo3RUc4NWFmZWhIaXdJYXZQYktvdkpkS0NpaStUbmVk?=
 =?utf-8?B?c3lNdHBxelJ1VFNJWllrZXMrMkNRTHpmZmwrbWQ5dXV1eGtRNmpJSUYvb3RB?=
 =?utf-8?B?VHFUakNkTHlHaGo4WlpaaTdRSnFOT0dkSkxBLzU3TERUM2p4aEM1Rm1MMTQw?=
 =?utf-8?B?eDFVWjFKcEdzdk1OcGlGSkdhNVpvRXBaT1BCbDY5aHIySDNaeEoyOTJiajlC?=
 =?utf-8?B?aFVDR3hVOEwvc2RYN2Y5MmxMYy8vekdoL3hGTm1xSHA5c2V4d3VlOU56YTJu?=
 =?utf-8?B?SDNhZ2FlMUpzUjRVYWt1TEgzQXVUWDRSdW1JZlVsU2k5YUQ1Vmd4RWtGdExu?=
 =?utf-8?B?bHB6S3JRSEhla0dqUTA4R251cGNBWjVjeEhCM2N3R2tRM1U2a3o5RVRlRlFy?=
 =?utf-8?B?eDExUytPOGF1Si9Jd0dZVndVbms5RDcwWkZSYWxqa1hrTytEMnUyM2hWbGVz?=
 =?utf-8?B?REtvRUVQWlNkc2RjNVhIRTMydE1ZYUlyYTdrSzRCaFlySGJjdVlEZ0NvTVor?=
 =?utf-8?B?R2dHUVI0V0dSQjBubjJjUGtzL0FFVUdJek9jUWswMHdYNTR4TTdhd3h0SEZC?=
 =?utf-8?B?NlkxRkx6cm1VQ3JuQWJPWWtJZkR4R1h1d29oOGcyQzZwY3MwOUdMSDQxSC9h?=
 =?utf-8?B?bncwcEs1NVBUMWtlV1ZHOS9JajdlUFZmODAvL3I3WmJlM3JOb2tLMXI3ZFJz?=
 =?utf-8?B?aXFKWm9kb29aUHpCaXMxbHI5cnNzNkJJKzhDWW1xZkNWcjdqT3lVU0l1MGZ0?=
 =?utf-8?B?L0d2N2gxblVBSytOZlFzZlVXQVlaaXpPRVBrSlJIdnVuRis5R1J5eE9KUlBF?=
 =?utf-8?B?UFF6aTBRNjFWTVZUZmM5aHJtWlU5bGIrcTBxYkxLUTdmNWluS2NrdUFqQnZw?=
 =?utf-8?B?cHJMN09tOUE5K215QnpiRThVVmlVUSsvdllRcm0vMlp5WmJhTmYyNkVhRXZn?=
 =?utf-8?B?OTQxbUdvcGZnSkNBOUlTRHRTWDFhbzJKQ2h3Q28xSkpGbnNlMTZzU00rbm9w?=
 =?utf-8?B?MzZ4Z2V0aCtGQmhiWWowa1lSTU05Zi94M2RjUkdvY2ZtMlFKZ3BsbHRWNG15?=
 =?utf-8?B?cFhEdlRQZ1Jjcno3MC9pUFNRZElLdklqVWtlOVhsd0F6K2tSS3hOT2s2NTFW?=
 =?utf-8?B?WkpJWUZOVWNucm1yVXFJaVFBeWtnOFEwNm51bVJvY25sWHlteStQc0ZRcGU5?=
 =?utf-8?Q?8E6YjIpKi/iuLZSkN3I1hl/1M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42530ad-a884-4581-953a-08dd7dcbea17
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 16:21:31.7026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DEKgu2ypiGFFdu0/uYPOkJ8ENLH2rz8Zk01PviJwTh2ZTR0uJgBsP/y90FBG8hRA5PZteSh3iudsJ9+vaPv4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9152

On 4/17/25 11:14, Ard Biesheuvel wrote:
> On Thu, 17 Apr 2025 at 18:08, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 4/11/25 14:00, Ard Biesheuvel wrote:
>>> On Fri, 11 Apr 2025 at 20:40, Borislav Petkov <bp@alien8.de> wrote:
>>>>
>>>> On Thu, Apr 10, 2025 at 03:28:51PM +0200, Ard Biesheuvel wrote:
>>>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>>>
>>>>> Communicating with the hypervisor using the shared GHCB page requires
>>>>> clearing the C bit in the mapping of that page. When executing in the
>>>>> context of the EFI boot services, the page tables are owned by the
>>>>> firmware, and this manipulation is not possible.
>>>>>
>>>>> So switch to a different API for accepting memory in SEV-SNP guests, one
>>>>
>>>> That being the GHCB MSR protocol, it seems.
>>>>
>>>
>>> Yes.
>>>
>>>> And since Tom co-developed, I guess we wanna do that.
>>>>
>>>> But then how much slower do we become?
>>>>
>>>
>>> Non-EFI stub boot will become slower if the memory that is used to
>>> decompress the kernel has not been accepted yet. But given how heavily
>>> SEV-SNP depends on EFI boot, this typically only happens on kexec, as
>>> that is the only boot path that goes through the traditional
>>> decompressor.
>>
>> Some quick testing showed no significant differences in kexec booting
>> and testing shows everything seems to be good.
>>
> 
> Thanks.
> 
>> But, in testing with non-2M sized memory (e.g. a guest with 4097M of
>> memory) and without the change to how SNP is detected before
>> sev_enable() is called, we hit the error path in arch_accept_memory() in
>> arch/x86/boot/compressed/mem.c and the boot crashes.
>>
> 
> Right. So this is because sev_snp_enabled() is based on sev_status,
> which has not been set yet at this point, right?

Correct.

> 
> And for the record, could you please indicate whether you are ok with
> the co-developed-by/signed-off-by credits on this patch (and
> subsequent revisions)?

Yep, I'm fine with that.

Thanks,
Tom


