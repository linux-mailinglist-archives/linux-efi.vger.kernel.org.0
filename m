Return-Path: <linux-efi+bounces-4598-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E117B32DCD
	for <lists+linux-efi@lfdr.de>; Sun, 24 Aug 2025 08:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626881B60E5D
	for <lists+linux-efi@lfdr.de>; Sun, 24 Aug 2025 06:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC56221270;
	Sun, 24 Aug 2025 06:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IgCndufW"
X-Original-To: linux-efi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013067.outbound.protection.outlook.com [52.101.83.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F3C26AF3;
	Sun, 24 Aug 2025 06:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756018068; cv=fail; b=YS3MA1YareVGQBnSfddl6AkA8l9BlUfXK9P6U5Apc1TBUYwZZ9rnJ2aZX3ceU2vsiXDKHzlrzcECNUKP8LjD/vFCK3cPmEg1tWTXaM1x9hq7o3BcX0OFlTF4XgtE58XN8q/nmdHDX+O2mW6OqEh8X/JAlGPGYvLjb3QVEQG2tCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756018068; c=relaxed/simple;
	bh=/h9ox0dDNQIj7gLhw4rinz7t5XrydQ4l6Oq4mioKhbg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EDuLryBgw1C5vmR6BeIgvyw4v+Lxc3UXjIDmD2dYv+a6vNHfsapsVCLEHC5I2oDx6vDSq8kVMqZZ2FcFLCWCtbILIXeoDG7BMk5KYXGHtwREuGlO7JHDlFjLb5MjKzvtTw2wANo6vTyM2WLhUewGzXb+U8Z0e29U913BeVW2yRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=IgCndufW; arc=fail smtp.client-ip=52.101.83.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvZRbVJiy1TndClY9GWyb6rx8bf8YL9c/aeM7vO5wIJAI9l74HQ5kPRWEn3BMfq4Kgfevwi4opwO0jVa427jORaocQkXZCe9aX3QedLZVx/coys//ER06TFKCvJQgjIWLsupxhwk8itkfIWhcul3TFIFiVzI57YZzC+Xwq/v9V3kI0SN7IwPC8PAftjHviBZHXdICXwqCzpjJSSj+YXfxc8/W5tujaYiJTOKDReimcyHB6bp+AHlGYsokYuCYtQXSKD5Hs+K280cfI0y+6d23JxlzMa3vaSyXBlYl7RHwVl1zWIgiAadWjuWA1Pb5FNd5rHx8MVqKbxpYsj7Unz95g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCq5bduMrepJJ4LmMMoDq9PDl4jOwap2vCuF+PJrGXQ=;
 b=hR8Vu8/F+qYOVxXOIIKKD69auHlBS9qKyGO/LWE8hcB0kCzKsE82gMg4FTP0lfkZyjdAxwyDNwVBGugdsRDwbxYwcYwUm9SVde3V3XLYMwAit06AItDFayjbyf1OqvSH72bO3g86w4XA3OFKQpUlDCDScHEkruAiuaSJlqfKhCHEduL5qSlMhRkGxVZAuCk5Di1OxA3ndGyCTv6NZ5eSlGeL8zIa5R8gWQV5DPhxzfLuxYfDRW7DaM/MASxs/jJCWC2RWRxicxzye5/Kd1ni286ltwmGHwCmxx02+4r1yRxbDevbO5CdEWAwPrzAPRa8nzKtCllyuJa+IT4E+vIR1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCq5bduMrepJJ4LmMMoDq9PDl4jOwap2vCuF+PJrGXQ=;
 b=IgCndufWrLsTS/kO0MoSff1CTdmcQmvtiBovhlvheQa0s7djtbthT8paqz4qd5+qgbwMP8i8YHmEmQgrJkCLBbSgE9o4NKkrnB5UzTgqpCpWhGHSPQ7jIR7cniVX4AAakK5B0hoGfyjSSLGH3krvVhPnq56aKCtZG0PT9C04u6Hjy2fhkv1At8eIngk6lCYYIL14I5XBGkvqFt87JJ8txb1iIoo3NFUHF3iEe3tzfrN1QyyCnMK6e8NlIQUvpbRen/tV0ZcdGJkEsSVfV7guqaEoT+pXkGBe26Sipr4g7Vp6JagvnmMWhb+N/xsrCeLBFMY7NFJcbtoVMc8pFTZlSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6079.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:570::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Sun, 24 Aug
 2025 06:47:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9052.019; Sun, 24 Aug 2025
 06:47:43 +0000
Message-ID: <09cb03e4-21f3-418c-98f2-66004cc3080f@siemens.com>
Date: Sun, 24 Aug 2025 08:47:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efistub: Lower default log level
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Aaron Kling <webgeek1234@gmail.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250708-efi-default-loglevel-v1-1-12b80db5af16@gmail.com>
 <CALHNRZ9T0dHzbXBUdBa4hE-Ao8ebeLLPRX+1ThkuLT+Rp8_Jeg@mail.gmail.com>
 <CAMj1kXEwyaHUkO5aO-sL3YAN=qRoSTuotHMRpBDLX9BhERnN=g@mail.gmail.com>
 <45692a2c-ba3d-45a2-9ab1-cf6982dbf788@siemens.com>
 <CAMj1kXG=zG8j+cr0gNMpkKRvdekqMR-EiEkMHiFgRvbaWy9aKg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAMj1kXG=zG8j+cr0gNMpkKRvdekqMR-EiEkMHiFgRvbaWy9aKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e04734c-edca-4170-12d9-08dde2da2090
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFNvU3p0UmlpM0hEN25DY3cyNHE3OEdtZ0QyMGdhTEdQWVNHQWxMNkRZS1lw?=
 =?utf-8?B?cTB1RVlEc0hLWmNqRFlHcDBNcThJVi94K2JmK2d4ZmJZL1Fya0wxc3ZSUTRl?=
 =?utf-8?B?L2JMSGZmVlVpT0hOZ0hSRmxmVzJSbm1Nb0pIWHpGMTFFUzNxcnkzS2tEemZt?=
 =?utf-8?B?NUc2Q0YyeTRsUmZBQ1VxaTVidGJTYXdFcmJkRExURnlhVStCMXora3djUDkv?=
 =?utf-8?B?WjNXKzhMa3dhL29TOGJoaGRWRk1uZVRFNUVpbnFjbThZNTdXb25uTzJqUXlW?=
 =?utf-8?B?NGlaQkxGSnNLTEQrbzREcHVvS01sc0Q0TjVhbEErYWQxK2NoUDlsS1IyZnFG?=
 =?utf-8?B?N3JoS2p2dTEzTGZtZ1Z3Nk5wWTV2amtjYTVmdVpUSnlkOWVrSlN0Tk4xbjND?=
 =?utf-8?B?U2dkTlZOS3lSNVA5NkpwVTcrYlJQSGhJQWROWjcwODVDOWVhdlN4bmkxT3hh?=
 =?utf-8?B?ZCtGdFlaZkg1UjI1TTdqQmJTOTRxZjd0eERSMFFUVHphY0xlT09JYklJS1hR?=
 =?utf-8?B?MlRwR25kV2RPS3JCcXAzSHRMY2NYZlZxUVdkTlRhZ0MvcW5NQmJxcDdON1E5?=
 =?utf-8?B?eFdyZXZ5bjlnenJFbHM1Sk1yL3lwMTVvSHJHOVNMdGQwUFk1M0RzY2JsQ09x?=
 =?utf-8?B?S3o5bVcrM2ZsNkxnT0JUVjVJOEw3SjhLM3dueWhCV2p1cWh6MDl4TzhvYjRL?=
 =?utf-8?B?UTU4K0hEcEhoTDhwK0dLZWxYVW5tdVczN0lzbmxMbmM4WEp5MGZndURrUGV5?=
 =?utf-8?B?dmRKVk8rT0UyUHNPQ2tMZVpMSXFlTTRYWUxKMHpuNWlUMzN2NEVuOWNROFJt?=
 =?utf-8?B?RzJpVDhpWUpISDdmaXM2bUJkOTFhaEpVT3FLZXNRWWdyNDgrcXV3aFdobGFX?=
 =?utf-8?B?S25mWlo3cXE4L1JLbG5QZW5SRUt5ak9CYmRJc3E5cm1peHcxWnJsT2p3RW13?=
 =?utf-8?B?V3I2L1RUMDNQbEJwK3JUS2VjQXRtTm4zNElDRS9rc3lMQW1mYmdnaWpXTlZa?=
 =?utf-8?B?R0U5WHNXRWYvYk9IS2hFaytoT3JBU2RzbnZzblRKOE9nVkJ2N01nTVVjODNN?=
 =?utf-8?B?VXZaU0NRR20zV3NyZ2FYNlY2MlRjcXNrSEFKQXIzNXpiTnVvdHZGT3g1US9k?=
 =?utf-8?B?endVdXAvaFFjak42VTd0OEdNRUV1WDgybU93RXk1ZWJ6dDZYQ3Axd0x5TE90?=
 =?utf-8?B?TTVPc0prUElWMG1qdVFmQmNYUHFrU3Z2S1JCa1BpeStVVE9wTHp0U09XOUlH?=
 =?utf-8?B?bVVvZlF5QjNVaDYrOWRqeWI3VG1tclVidkllTFNhRGdFZ2liVkpVaFQ4bXlX?=
 =?utf-8?B?YzFIZ0ZVbW02d1NpZm8xSEl6YS90d2FacWJTNUtubFc4bjdtSkt3QkV5ZHZE?=
 =?utf-8?B?NG5mNDBFTUI3Y0szckxGbVdjekdKQThoUjZDOGUrd0dEbXo0eHp2OWExSjBt?=
 =?utf-8?B?OEJDYWNMTlgzZUZzMlErUTZub3BmOUR3UUJjMzZMcS96V3NsZWpuVGxiR083?=
 =?utf-8?B?dm1vYVNBMy9PcGxLK2g0MXRIbXQ5MUlIOFhtNlJkd3hNRWh2NUZMVk5aQUdy?=
 =?utf-8?B?Qks4T2cyclFSY2dYTHd5ZHpqYWE4R3dJM0N2Z3hxL1JBOEE4MDZ2dHpEcnNy?=
 =?utf-8?B?UTBMUjhNZ2E5WXFCY1IwcUdrdVNaNnZyU00veEg2YjluK0lGMncrMjI5LzBv?=
 =?utf-8?B?bnpITnh3bk9HVXlEM0dhZHhnVmFZdEJPMjZvUU5ISlJTRU45d0RvVnUwdVQr?=
 =?utf-8?B?RndrcTRFK2RsYVNPbTJzQjhsZUdWLzNCT1NxN0RGZzRzRVFFcHdRMHlTRU94?=
 =?utf-8?B?NUVCTTBWbm9OdU1YbHJ6Y0tQbUlPS3BxZ1MreXBML2h4YkFsemNrY1ZRN1B1?=
 =?utf-8?B?RVdIbE5IMHJ2WG5ENldpN3g1bklnR3hJY2h2Ym9reTdvemhoazhGb2UxK1VL?=
 =?utf-8?Q?OQTv9SX0DTU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlNmRzhrOGJ1N2FHbnRuSU5hU3ZWTm1Mb0dZUUZSVFJIVnZsRjdocFJjZWlI?=
 =?utf-8?B?SlZ4Qkx5a0Z1bFo1dDQxdWpxeTRPWlQ5bjlCNWZkMHdIT1ZUclRLaXNxdm5s?=
 =?utf-8?B?cDF5VDdudklzcEgzK3ZNeE9Dd0NuaW55N2ZWZDdhSExsSTNvSWVqSGFlMFJr?=
 =?utf-8?B?K3pleFVlaVBYdURUUnEzVmhtQ1NpWUIzOWJMWUdPY0VNSDZicFNlbnVySEFh?=
 =?utf-8?B?SmVmemc1OERxS2Rhem0yTjhGZ3U0QXBkV2dHbmZHazBCa3EyRTlZdm9TY3Jl?=
 =?utf-8?B?MFhTUGNEdzl3SUhQR0dPUms4SFdQa1UrekhGSjNNVE9Ob2JJSFBtSzVIVDAw?=
 =?utf-8?B?YVJrZVVqQi9wVkJ3SXZzSHJBZ25WbXhqOXQ0UGVMN0NaMGN4bmdyTUYwb1dY?=
 =?utf-8?B?NG5aMFNLZyswc1BTRVNHTGk1aUNRR29IUGlJZjQ0eXZYam93d2t0VHNwWWtO?=
 =?utf-8?B?eEdsaHFWUzk4RGdERjdnREp3YjZGM0w2QmwrQ2QwQXpvQW8zMC9IbDBHQjJW?=
 =?utf-8?B?NXNObEt0Zk0vb0pCcCttV0hQVWE2cXpzNWcwNm14SEwrYld5cUEyNDRuU1N5?=
 =?utf-8?B?Zm15bms5ckFtNEZHeHNDMVF6L0ZSSmpXTWJvay9IZkNVQlorUFJPT2hjTlk0?=
 =?utf-8?B?VHNzZXVrSGIrSWdSWTRwS0wySjVBU1JJSytTc3ZRYmdUL3JqZmNFNG80bzJ6?=
 =?utf-8?B?MVA2aHNUcG1CYnBPTVpsVGpHTU16SHlVN0g3UUNLYU94MnlLY3ZkQVQybXJz?=
 =?utf-8?B?aDNmeHdIbmxVMkVVVFNsUUtHTmNsRXNUUjBjcmRpVTdUK0YxK3ZVVkQxaWhv?=
 =?utf-8?B?VCttVWNuL2pOV0tTaUEwdXZScE5lVkgwU1U4LzdHS2dzclEySGxSbWVsWkpn?=
 =?utf-8?B?MnlLWTA0WDQxaXFLRkJuaEh0dlppOFdRMW56d21peFp5MXNSNklwT0E3ckps?=
 =?utf-8?B?c0hNT0oza080NVAvanBZeWFpM2dzai9IRTFLbUVlVStsZ0dadTQzZTFSNUZ6?=
 =?utf-8?B?ZUphQlM3N1IvNG9UZ0NQd3U3SEVPcHNRWXNtWk5heGlvVHRINlBnUkttSDZv?=
 =?utf-8?B?YzhFbUExa2YvYmFXMGtQclBDZzJlZTVPQmpTN210QTNOUmZJRGRKSXVySTds?=
 =?utf-8?B?R2drU1lTS3kvUmhNalVQbDA5UDRkdkFCbkZ2QVBwcDRsenFNSWFLaGF1bTIr?=
 =?utf-8?B?QTIyR2M5LzNXbkEvWDV3RTBhNVJOVlV6ckRxeWRMWms2QmdndzF1S2FpOURU?=
 =?utf-8?B?VllZRGpGbmExdDYxMHZFdVdrRnpXS2ZWaHp3elNCbXY3djdhOC94ZjcxZTh5?=
 =?utf-8?B?VzI1N21sVnVZT2lqWU11WUhsZDc5bU9tYTltZldIcW9sS2REYkJhcnRzYUpY?=
 =?utf-8?B?VjhLc3M4NExrM0ZFK0dUZlNjcVN6TEJJSTZrZ0hvNkozaitYSzBrRGJ4YXQv?=
 =?utf-8?B?eFF2akVacFhTSDRhMGhTL3pmUU1JSkxCVFFmQXY0Z0t2azUvNE1wVktva1hn?=
 =?utf-8?B?c3BGaFpKM0Jxb2M2TThGZTRLcCtaalFMVWRqV1pKZU11cEFpZHF4TERXcEF3?=
 =?utf-8?B?b1FpMG15S3k5RmF1eTA4ZmVmajFpNXRxQW5lUE5xRnVaUWUvbVNtVXJQQXJx?=
 =?utf-8?B?TlBFcEdkcGx5cklUcDliZndKQSs1c2pUZHJIaCtYcUV2ZnAvc2F1YW9ESUh0?=
 =?utf-8?B?dVp4aUtvL0xuV21WbjZuVHZoTmx0aUlPU0tEMlozeGpzQjE1amh0ZXFkL3B1?=
 =?utf-8?B?UnhYNjhJaDZ6ajNrbEVEYndGK0VXSjRxMEhRc0VwSjZKVkNOK2cwRGU5eEEy?=
 =?utf-8?B?QXYyQ3Jja0k5akt1bDJlZWNiN25FcmpZcmh1b2N6L1kyZmdHbXkzWWNBYjJE?=
 =?utf-8?B?TkJXWkx2L2xUV2VUNG5LSCtRdlZDKzJhbU9XTnlheUtBM1NmWEpBL0lCL1Y2?=
 =?utf-8?B?Z3FBNTFjNXlVZTYrdWE0THUzNThVSDBKRWM4ZFQya1c1M3pOWTNsdmk3dzZ4?=
 =?utf-8?B?R3F0QjNDUG5lRXI0empwWlVnaHNoV0RzRjUrc052bE1UZ3k4UlRQb3RjNTJp?=
 =?utf-8?B?MzF6TEpCa2RLTUV0dkRmZWZpckhwSlJDSkFDU25naGlDVzBXUTNrRk9pb1VE?=
 =?utf-8?Q?/vf+/L+TswTkW9yYfgJM0gIlZ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e04734c-edca-4170-12d9-08dde2da2090
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 06:47:43.7299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fiqS6cvD7VusPUrGLrEVRQQCIz4igJFy7b2obtVygEyVOAZltNyy5s4mgx0lr9+LgGDC69Br2FwJemf+AJk1HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6079

On 24.08.25 02:31, Ard Biesheuvel wrote:
> On Sat, 16 Aug 2025 at 16:52, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 15.07.25 03:35, Ard Biesheuvel wrote:
>>> On Tue, 8 Jul 2025 at 17:31, Aaron Kling <webgeek1234@gmail.com> wrote:
>>>>
>>>> On Tue, Jul 8, 2025 at 2:30 AM Aaron Kling via B4 Relay
>>>> <devnull+webgeek1234.gmail.com@kernel.org> wrote:
>>>>>
>>>>> From: Aaron Kling <webgeek1234@gmail.com>
>>>>>
>>>>> Some uefi implementations will write the efistub logs to the display
>>>>> over a splash image. This is not desirable for debug and info logs, so
>>>>> lower the default efi log level to exclude them.
>>>>>
>>>>> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
>>>>> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
>>>>> ---
>>>>>  drivers/firmware/efi/libstub/printk.c | 4 ++--
>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/firmware/efi/libstub/printk.c b/drivers/firmware/efi/libstub/printk.c
>>>>> index 3a67a2cea7bdf1aa215d48dbf9ece4ceec6e4c28..bc599212c05dd746a9c54abbbe61a4bf70f1a8c4 100644
>>>>> --- a/drivers/firmware/efi/libstub/printk.c
>>>>> +++ b/drivers/firmware/efi/libstub/printk.c
>>>>> @@ -5,13 +5,13 @@
>>>>>  #include <linux/ctype.h>
>>>>>  #include <linux/efi.h>
>>>>>  #include <linux/kernel.h>
>>>>> -#include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
>>>>> +#include <linux/kern_levels.h>
>>>>>  #include <asm/efi.h>
>>>>>  #include <asm/setup.h>
>>>>>
>>>>>  #include "efistub.h"
>>>>>
>>>>> -int efi_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
>>>>> +int efi_loglevel = LOGLEVEL_NOTICE;
>>>>>
>>>>>  /**
>>>>>   * efi_char16_puts() - Write a UCS-2 encoded string to the console
>>>>>
>>>>> ---
>>>>> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
>>>>> change-id: 20250708-efi-default-loglevel-4da5a36cac87
>>>>>
>>>>> Best regards,
>>>>> --
>>>>> Aaron Kling <webgeek1234@gmail.com>
>>>>
>>>> This patch was originally suggested a few months ago [0], but as far
>>>> as I can tell was never queued for merge. Since I'm also hitting a
>>>> case where this is relevant, I'm sending this in to bring attention
>>>> back to it.
>>>>
>>>
>>> I've queued this up now - thanks.
>>>
>>
>> And how can I get back the loglevel info? It seems I can only choose
>> between notice, silent and debug now. And the latter two only by also
>> touching the kernel's loglevel.
>>
>> I'm particularly missing [1] in my UART logs now which is helpful in
>> understanding this essential system state.
>>
> 
> Hi Jan,
> 
> Is efi=debug too noisy for you?

Yes, also because it affects the kernel even more. I'm looking for
"efi=info".

I don't get the reason behind this change anymore as well. If you have a
splash screen shown, weren't you booting with "quiet" before already,
thus also without any stub messages?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

