Return-Path: <linux-efi+bounces-6128-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH8UMfw6j2nHNAEAu9opvQ
	(envelope-from <linux-efi+bounces-6128-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 15:53:48 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 425FE137480
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 15:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6513308F140
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 14:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A13B3612C3;
	Fri, 13 Feb 2026 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=edgeless.systems header.i=@edgeless.systems header.b="dIXpr58I"
X-Original-To: linux-efi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020119.outbound.protection.outlook.com [52.101.69.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F297260D;
	Fri, 13 Feb 2026 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770994349; cv=fail; b=gEGUG+kY/ChPG39Jzmbcw/ofnTeJQSNv6696mASjhyco/NfTb8Gwqg4FXfNbMVcre1b3+dJ/zlBD5EH7O9RakjJM03tXbS9yvY5TUtbejOhAduCZk7kIUMkB3RKNcsVG3L4TK1qzbnsAeBS6b2GwSehLa9hFSZjNC0VtigCdRQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770994349; c=relaxed/simple;
	bh=lEu1gQA2zD8vRgouY/j6Ux6SK6vmZfvATG1gC/+KL2k=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lplMn54lEIvGBDXqL7lqN5xa8fuRQGyb/Q1R+0nLrCSVJVs4G68iG29Ug4n6EhJ6ImmWV2fMfXLEa7FJridAHToIEquFAoyN7007YFID2A0H2cDuG8e938IgkKU4bWej/42+ZOESgY1st2a0flmr/stFE32m3TLpNG8UAoLdDY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=edgeless.systems; spf=pass smtp.mailfrom=edgeless.systems; dkim=pass (1024-bit key) header.d=edgeless.systems header.i=@edgeless.systems header.b=dIXpr58I; arc=fail smtp.client-ip=52.101.69.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=edgeless.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edgeless.systems
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XA2BHQO5tXxwKxg8VVF4vJVubY109kgsbGpZfKiVo10DXTIxuLQRqr1M8wAbZOrMnIdH/iBWJ3Pz6cBuHPWb+UqZoFBMNu38oV4eQn/NRP2ZIQk1qf277lmN2mzsU8XmjIOaYmjdPVoOkVhs0Gt+OPwyzWBb9UP7FFIBUWR1s4oVfiMOz77J9JvMMRV/1CHb/VvNxTO70P7QUJ/Rf67TybnJosfSBLCbO2GLVvo1+0Kkoh3UdNDo7Sy7CsuyA2x6Is+PkGW4Tx0vPwyfOPi+VKRNc8/J5n4+OscPnEoR2G5oDEa6SUporuNKydBNzirCMe7bvt1nuDPrcq3S7DlMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4UNUqWE3Z2LrVrky8Ftinwh5IkAqxFkK83jWABB8yQ=;
 b=yRAUv8REUdz10lg/gWj3ySuSClmSUEEc7Ll6pncbiyJc57tA/ZdmsomgmBLVitWgMqNg6TgCDrcemPXGtG/5kcbp8VtEkfRlVQTtvCxXMhRsbLS+KtS2p7zwBh1RAp2s5f9KVlxuuBPjTJiIyWfw2VVjqZ1OkmvKOVGOeQ2FDFJduGSE9o5nkZ/CIfy21P8r0MrVhkVTiu2v2NOIT1yhYTeaxuTDEv1fRnpXeRwSQvMp2J6x+8awIQHvfB2MDWM+gptCPgkJQ6hku2vHynu9jZdDbvWOezuxrh5Hlh/aHVcbSutHcO1U3v2dw5MAXCyjYUyKtnz6GAlK/GbOxCh3yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=edgeless.systems; dmarc=pass action=none
 header.from=edgeless.systems; dkim=pass header.d=edgeless.systems; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=edgeless.systems;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4UNUqWE3Z2LrVrky8Ftinwh5IkAqxFkK83jWABB8yQ=;
 b=dIXpr58IGQft19k9O5v0HMH2iAuWK9gB6jmpYWCi6+zjSnxIndmsM8sAg1VZTuwBO8IInjY4K/ZCosr9lNAIRqObJhObl0X1CmTvH/5KkqFhvUVUXoohi6EhiPAdUe6haaPITyDCuyWl5hrD93Vx6iyGC8CmBOIq7Ik/CA5uk4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=edgeless.systems;
Received: from AS8PR02MB9459.eurprd02.prod.outlook.com (2603:10a6:20b:5a3::12)
 by VI2PR02MB11045.eurprd02.prod.outlook.com (2603:10a6:800:277::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 14:52:25 +0000
Received: from AS8PR02MB9459.eurprd02.prod.outlook.com
 ([fe80::815f:fa6d:197c:2470]) by AS8PR02MB9459.eurprd02.prod.outlook.com
 ([fe80::815f:fa6d:197c:2470%6]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 14:52:25 +0000
Message-ID: <144d3a8d-1b65-4f96-ac77-0b46e249aefc@edgeless.systems>
Date: Fri, 13 Feb 2026 15:52:24 +0100
User-Agent: Mozilla Thunderbird
From: Moritz Sanft <ms@edgeless.systems>
Subject: Re: [BUG] Fault during memory acceptance for TDX VMs with certain
 memory sizes
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, ardb@kernel.org,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Weiny, Ira" <ira.weiny@intel.com>, "Wunner, Lukas"
 <lukas.wunner@intel.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <c2632da9-745d-46d8-901a-604008a14ac4@edgeless.systems>
 <b6f00f31-ab39-4a76-b758-b3cfb1b0dfbe@intel.com>
 <cf37b7df-1265-411c-8aac-f82c3732fde9@edgeless.systems>
 <aY8Quu2WJG5HB3PP@thinkstation>
 <5a0fa6d2-f138-4360-bf02-5478eda4b495@edgeless.systems>
 <aY8y6uCyejTXTejt@thinkstation>
Content-Language: en-US
In-Reply-To: <aY8y6uCyejTXTejt@thinkstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0041.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::10) To AS8PR02MB9459.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a3::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9459:EE_|VI2PR02MB11045:EE_
X-MS-Office365-Filtering-Correlation-Id: b1e8ee88-d4c1-4645-74d5-08de6b0f8026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVN1ZVB3NGFGbzRpd01aYzMvWE1UN3UraHVrYUg3S21XSEpLM3dVeWdDSWpN?=
 =?utf-8?B?eUg0VUFLSis3VzRENTRrc1BLNjliRm9ORmRWbHFLU24xc1QvT1BjdW9OamV5?=
 =?utf-8?B?UHNXcUlHVXhOd2g4SFN2YUZQcnNyemhvOVlSV1JFOE1kNXd1M1FZWS9XNThn?=
 =?utf-8?B?UEJ5ZSszdk9wR295bFBNQWl6THNjRkV6L2FtdHFTSmFkT3ZzaVVHZlhVZHRQ?=
 =?utf-8?B?TExsb0ZtWmdzNHpUT2tZWkhwVHhBNTRYakg5TmRLb1pJc0w3YWhFOTZxbE1H?=
 =?utf-8?B?UzJRWVdwTWpiSENyc3dXRDYyWWtqczd4enU3L3FTaEg2ZmlEZjdUOE1NU2JK?=
 =?utf-8?B?a2VVSjc1TVdGeTdYblV1SEtJQVBodkw5aGRnckZseWpwbFR3UG5pQnFzTXFP?=
 =?utf-8?B?WitwbTdjQmFEYUFuK2ZQSmFkVUlnUzJLSEQxOWdEV09sRHZCMGdLbENkaUdq?=
 =?utf-8?B?YlA2TENCYXZ3bFMyb2UyeDd3MHEwbzI3VHk2Y1dBVEJYUkxPUEFsQkkySHlr?=
 =?utf-8?B?SGo4TEhxb25CeUdHQzhOREJSbE5OcmFaVWZCVHNSYzhLNWVQUDQyOEVUQVlU?=
 =?utf-8?B?QUEzbHQ0L25JbFY3M3JFTkxUa2hzYTVWL2Rma2RDclA2ZFNLUDcySENMUlEr?=
 =?utf-8?B?aS95QWpJQjJxSkUvQ0Q0MThndWhKSXh6bEdBWkxpMHAvQ0J0VVFkQUpDNGNa?=
 =?utf-8?B?d1NVMUZ3NW9WRVU0dkU4aE5rK0t6a2x0ejJKUTZWYzBGS2d2M0paenJwblgx?=
 =?utf-8?B?QVdhaWtjOENlSk1hNXdVSmdHWjE5YkpjazA0ek83TXNoemFiYmIveW1LNmpL?=
 =?utf-8?B?N21PTExmSDV1ZU0zWnFNaXJyWEJteW45ejRmQUxHTnA4T3ZuTFV3YU9zYlVO?=
 =?utf-8?B?WDZEaFAvdkcrWlFvR0I4blBvVWl0V2IwRWkyMFRuUmUvNHNFYzZWaVhxYzVH?=
 =?utf-8?B?WHJOMTlvYUZYYVYxc3N5TE9JTjdkZy9WWk5jbU1ZZFVHRW1EZmdXZUN6a0VB?=
 =?utf-8?B?RzMvdVVLMXlsREhOYlRSM010dXg1NEUxSHJ4Zi9tV1ZWZTdseTlXSzZFbk42?=
 =?utf-8?B?elhWRzNhdFZjM0NIdGdvenpXeUxBblFuaVBtWURWSk1iU290czVJK2piQUwy?=
 =?utf-8?B?VjBVWXhITnFkYWVHZ2FYdHlFZThhRExBZUVLQWJqLytxNUorZ1lhNXZDY2V5?=
 =?utf-8?B?VDlwU3QvOFlyNWUwQmZBVnA4Tmt2eFhvZW9QaFdrWmUvSjB1SXBwaVBMUG9m?=
 =?utf-8?B?UE1iY0RTQXhUVktPMWlUeW1TTVBPTnIrWWJicWVZbm9FOUVEeUdSbzBjSS9V?=
 =?utf-8?B?NzhjS0YyNC9LdkxWbzZRL1Urd3d5OW53bHo2eUVzSjl4VTlZRklUeE1RcFZS?=
 =?utf-8?B?KyszeG5lSUxPK1pIQ0FCU0FvR3hoR1JyK3FURzUwWjlxRitHaUxJa0lIZWdk?=
 =?utf-8?B?djJSSHczTjhweUZONUM5TVFvRzQrODRLUksyQTZMa1l2Z2RKd29lcWRkbkln?=
 =?utf-8?B?MUxYZkRkYmh6SmpxWTJaK0xaYzNOQWhDZHJJNVZ6VDFwL0dSWVNUUC9QY0Jy?=
 =?utf-8?B?aXgrYzFJRDJxWE1UenJIZFpMUnAvK1JJMmVyNy91OVFhb3VNWUxHcHdYN3hO?=
 =?utf-8?B?R3JDMDc1TzAxWXAvekU3enpxNUo5aGRUbVRNQUFEWlVxZDdmei92Q3prdGNI?=
 =?utf-8?B?eFIzSkEwMSsrc0twWi9xVDN2aVp4L2FWRzIreGpHcHR1a3lDUTNXRW5kbVBt?=
 =?utf-8?B?ZHhDd1NicWFxd29XcUJacjEya3BXQnh4SEx3VGpZOTBEMWpRWE9oeENZN2dL?=
 =?utf-8?B?QXVQVmVDalNTUVo4QWlnZmtNbHkwdC9XTTJjWnR0WXdsQWl1UFF2VkdwajBE?=
 =?utf-8?B?VUhPTkJleWdER0o3bDNac3ZyZkxPYllKcW4zcEpUVTRUejZiZHpUbmZiQU9V?=
 =?utf-8?B?Qk9UTzVjNXdjK0dqb2hTTGszcmh4M0JPNVgvZElhOVFHVVgwb2d4cHZXWVd6?=
 =?utf-8?B?ZTJVTVpjcEhtcjN5NzdDSzQxVmhMWEtoUktDWjFSL1JmVEI5T3NTV3E1Qys4?=
 =?utf-8?B?UUM5WXByeUZSWUlMZEZ1UmpadGZhd21iOXZoWU1aajF5OERJOVd3QTBvV3ZC?=
 =?utf-8?Q?41bo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9459.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzFoQ0FjSElLSkpmYlY2STNvdTM1Q1BvT2JCQ2tZS09XTjNTTnVib3dHbTdi?=
 =?utf-8?B?Z2xxZTk5cGFrWUZCa0ZnNlMwYmFHc1o5M2NMUjZKVERYalduV2V2UnNCdFNO?=
 =?utf-8?B?YUQwT015bkl3UU1mN0YxZUU3eFRMbDl3Z2hxSnJKaVRrSFEwVWJ6Ylg4VzF1?=
 =?utf-8?B?d3BUSXRUUHJBOVhURGtXVUV5OGVTM3VyYUpyVWpGbW1kTFdWUnZQaDBwemR3?=
 =?utf-8?B?TjZUTVdVMFE4RUQ5RVhwOFpuRzJ2WEptT0RXNWZuRGV4eHorWkNQalcvRUlP?=
 =?utf-8?B?L0pyTXVZQ3E3byswU2daYXBaWGpxSDlmVHpaSStZVUdUcVprME9KOUw0K2xX?=
 =?utf-8?B?VWU1Z2R5UkF4MlRSRFNIZjN4N2x6cDI2OXJNZUhtbmJGbnI1ODQ2eVZBOGJY?=
 =?utf-8?B?WGRDUWVrUU01YkxONVRPS1pQTzlVVUlXWmFWamdFM1lOb3JHOE5ha1FnRXly?=
 =?utf-8?B?V0hFLzVkNW9VSTE4VS9OUE1ab1NuTU94ai9RcEZPbzBiYW5XYks1VGFvSU9T?=
 =?utf-8?B?Z1lab3NGQ1dWUlBMaWNKbWtCdS9Lb1BiWDZld20vQ0YwcXl1bUdZQklLUElV?=
 =?utf-8?B?N0xnVUg1ZEVnTys3Ty9EREVMNnpsZzR6YXdOcVZDTTk2S3FSc2dldFJTNGFK?=
 =?utf-8?B?ekJ6TEVhUHdiaEhtNHk1N3djYUt2dUxZZHhNRXNSemVVNHBYMmpuOTFXUjk3?=
 =?utf-8?B?OFJoNWdUSk1TVVlpdFV4NWhJUDZNaVpzWUZ2bkwxV0pMRlkrblJYeTNJWjA0?=
 =?utf-8?B?Y040eFNiWDdQTlh1d1NsRHM1QWp0T1R0V2NQK01iSEhrREI0VElpMVdKOTEv?=
 =?utf-8?B?RVgvTnlUbXNNRzY1VGZyTGR6QnRMWEVuOGYyQytKTmkyc0JsWkI0T1pzeWUx?=
 =?utf-8?B?YVVJUitwdTBtWTFkRkdjY1RzQktDamdQQnhKYlhkVGhTM2E0SjNuVTJveFA0?=
 =?utf-8?B?YU91d0JZaE0wcThodWxVVGVJeHZOcGg3VTRqZlVWTE1NTUlybWRad3huTjIz?=
 =?utf-8?B?ZmIxdSsvWUVFTC8weThtdS9FQVk2NXVpK1VQNGtwUHlSOHFNQW5OU3hWSDZL?=
 =?utf-8?B?VnRsMjVsR3dkeXdSMmRnNW02TEZNcTFjWXdlc25TeVBaeUJOL1Jsc2RoSnly?=
 =?utf-8?B?NFpYU2dsK1dLU3NRM3BPcEoxZ29aeGN0MkxNZ1BYT1JJaGViK1hIMHEyTU5m?=
 =?utf-8?B?ck4wWlQzOGRTQTVvOGREQUd6eDRGcVZ4aXRSTm5qaUQxRmlpTnlnd3dtdS8r?=
 =?utf-8?B?L0hGV2tCMGEzUjFCQUpsdkVRU1dVajg3U05XZlpPSHlIM0xkV3dDOHEwVWpK?=
 =?utf-8?B?RXZoYUdBNDdRRk5NS1AvS1JKbGFQeWJQVnhXMllWK05tZG5iM1VoL3ZjVVNk?=
 =?utf-8?B?L0hXcnVHc0tLc1VBWEYwU3FjZ09kYU81YVM1eUNyV01hV2JoMUdJWW5WYWpm?=
 =?utf-8?B?ejN0ck8zN2tpM2p2YVE3WmM4enpsczRnZlVBRW9PUEcyOGl0d1k3dllKcFA5?=
 =?utf-8?B?U0ZPSmQ3K0JWZC9BZjRYUjhWTklhUk5ENkJQWjYzREV2ajB1eEZZNmRMT2NS?=
 =?utf-8?B?azYvcWJBN1NEM05HYndhN3VZellDM3JZRjNOR0ltYm11TUlzeElzSXJwekpi?=
 =?utf-8?B?SUFnK1VDQUtpUytiQzFYYlVhWG81YmdSTTkybnZ0RkthdGF0MU1JNCs4RGc3?=
 =?utf-8?B?QXJ6UjJxSndNRytiRGx2OCsxNTFwU1pNL3lSZmJRVVltanl6dTlSWjhYOFlU?=
 =?utf-8?B?b2xZU055NW10c0M2SW9LUzhaRjRqY29UcXVDTmVjMXYwZExBRGlpejNTUHhP?=
 =?utf-8?B?NWwwVFkzT1FzZkZOWUx0S2cvbS8zQW5SekFjUkpCWE0yVnpobVkrNWVFZkFY?=
 =?utf-8?B?aWE3OU1ZMkRLSGRtVWhORlBSblVYTGFucEpvSVNMZTZvb1kvcW9SUW5la3RC?=
 =?utf-8?B?dk42NFRmZURYSEs0Vll4NVBHbS96VXFoS3l3RWFWL1Q0WlVSb3dxdDFGaUFT?=
 =?utf-8?B?TUdzWDB2Z3dGSEdyUGxGU1FqTWxaeW1jKzVIOEF2cGtQbmFNLzgrVjlQcXdm?=
 =?utf-8?B?ZDFLRVlGWjE3T3d4OGY0cXUyeU5oenJsUG9sVU5Dbm8wUmtSaEtjY09qb0tP?=
 =?utf-8?B?Yk8vK0lwVy9GK3dCNUo3SmZSYVJUOTVGejBmeklCcEdDTS9iR3Y4dWUxTlQ5?=
 =?utf-8?B?V3E0RU1KcEpLUDJiaWhWNzhFQlRZOE9zOUJRaEZ6WWMyL3RFYXltTjh0cklB?=
 =?utf-8?B?RzBEZDN4YWtmblZXRHpob0hxNW1neXJpODBRS0Y0TzN3VXI4b0NueWZoOWVo?=
 =?utf-8?B?TGloTXI3bm1lQ3oyaFlUVmVmRWJuNldaNjdLQmpSb3dINkw3NUFZQT09?=
X-OriginatorOrg: edgeless.systems
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e8ee88-d4c1-4645-74d5-08de6b0f8026
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9459.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 14:52:25.2678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: adb650a8-5da3-4b15-b4b0-3daf65ff7626
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBiBCOt5Sikike0EtGpB4xHlElhj4Y+AXt2jRFOoK783P9sKvIvX6liOvjLPLvDyicfnMHKHmhD35hIIK9EtNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR02MB11045
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[edgeless.systems,reject];
	R_DKIM_ALLOW(-0.20)[edgeless.systems:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[edgeless.systems:mid,edgeless.systems:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_FROM(0.00)[bounces-6128-lists,linux-efi=lfdr.de];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ms@edgeless.systems,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[edgeless.systems:+]
X-Rspamd-Queue-Id: 425FE137480
X-Rspamd-Action: no action

> What about the patch below. It seems we under-reserve memory for the
> table if it is unaligned.
> 
> I still think that we need align start/size/end to the PAGE_SIZE in
> accept_memory()/range_contains_unaccepted_memory() before doing anything
> else. Otherwise (end % unit_size) check is broken. But it seems to be
> unrelated to the problem you see.
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 111e87a618e5..56e9d73412fa 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -692,13 +692,13 @@ static __init int match_config_table(const efi_guid_t *guid,
>  
>  static __init void reserve_unaccepted(struct efi_unaccepted_memory *unaccepted)
>  {
> -	phys_addr_t start, size;
> +	phys_addr_t start, end;
>  
>  	start = PAGE_ALIGN_DOWN(efi.unaccepted);
> -	size = PAGE_ALIGN(sizeof(*unaccepted) + unaccepted->size);
> +	end = PAGE_ALIGN(efi.unaccepted + sizeof(*unaccepted) + unaccepted->size);
>  
> -	memblock_add(start, size);
> -	memblock_reserve(start, size);
> +	memblock_add(start, end - start);
> +	memblock_reserve(start, end - start);
>  }
>  
>  int __init efi_config_parse_tables(const efi_config_table_t *config_tables,

Thanks, this patch seems to fix the problem causing the panic. The VM 
boots as expected with this.

Please let me know if any more information is required.

Best Regards,
Moritz Sanft

