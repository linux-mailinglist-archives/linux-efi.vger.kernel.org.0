Return-Path: <linux-efi+bounces-906-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFED89331F
	for <lists+linux-efi@lfdr.de>; Sun, 31 Mar 2024 18:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC711F2656E
	for <lists+linux-efi@lfdr.de>; Sun, 31 Mar 2024 16:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989BA152199;
	Sun, 31 Mar 2024 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QMl5bUwl"
X-Original-To: linux-efi@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005FA757FB;
	Sun, 31 Mar 2024 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902492; cv=fail; b=QS6QCT/weA7zlXUuX3tQsXH/n9aBYcLqqpKIV/oJO0DqEXOkugXhy3wY9vL9ksu378yAdCBrIHc52S9hx38N9TFZuIuWaOwJqwrSvVK5uxW1LakzRwTblvdIbwjB4X1viqKpS0eqb14qCBZWTQxafswrXtoU0HpK0i3SRZcNJy4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902492; c=relaxed/simple;
	bh=TJLEmBKTyUHJSLtbEEE/kGBu3MlXQPtp/VYO30wLKPY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kJ8gIG+44Amq1Np+wLAIzshjtGBuWpK/0a5sHVMrt/cp3Ov++FzlAhc4qasogPKb9BVkgd/AOyrmJKH0uYPMkBJSOVVUlJDOeABRqjrmbPbQm/9w6UhriaRt2jRsxs5HYgHZDjIryewGpUNbwq4S+GbzDJY/A6ym9+RjQYeDQ1s=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QMl5bUwl reason="signature verification failed"; arc=fail smtp.client-ip=40.107.237.95; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 7D07520820;
	Sun, 31 Mar 2024 18:28:07 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id na5_6u64Yrpt; Sun, 31 Mar 2024 18:28:05 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 43085208CC;
	Sun, 31 Mar 2024 18:28:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 43085208CC
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 32F94800056;
	Sun, 31 Mar 2024 18:28:05 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:28:04 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:35 +0000
X-sender: <linux-crypto+bounces-3085-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAhZPp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgBjAAAAjIoAAAUABAAUIAEAAAAcAAAAc3RlZmZlbi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 29238
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=linux-crypto+bounces-3085-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 09F3320883
X-Original-To: linux-crypto@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.95
ARC-Seal: i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711752070; cv=fail; b=iT73yaJATXPF6TexZMUEAV2/sxEWzNiLK5TUnvPX0Cy2E14qbaNwPyBNeqaglJ//Jx+6uFKjnxeQq+z+nMgdQg7F1U37PDX1ZUB+DIlOCzOGWxC06t1YWT90Ew/eW+Rh3ApI8I72qztLjrFodKVarmzb+wwckGDk0XXy7Qh/CJs=
ARC-Message-Signature: i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711752070; c=relaxed/simple;
	bh=+qwRVQtAUFwc+mzfaMAXarOygq0dR3IZtuet68K/Fyc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G29ZIU+yv38ZuTtXNi+N8C9Zhwjmp44eIvzsKJgCft7KwIkeThqwQKY9NS8L4PwEr46ODNkpxKhj/5OKv8BT1YCNoJfs/awO/a9KJkRV+vJZaAlNqOJlgGXBdjfLBdz3f3I2QS98P/ZBr6R+qHJydYb7baxyGFy6LT11pI9R0o0=
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QMl5bUwl; arc=fail smtp.client-ip=40.107.237.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkkM76oyZTz2Q2LpBR6pBvhemX3+VK0fBLimXRngfvWCLdPfuoYo/vDDc9RbYD4UJCpFX6s1jEACDTyMlHtRFRtONzRJPjfA5pmccOwplO8CEa6s0ovxM9Hl35Er48H48WBDOpZd1uPtQB3DDta7kBsPc3EIceVFUm/Gm1wTOx55QotP37QBX1KD8mX4WMa0LZynfQjnkStLhLnWXcdQwsSPer6kiUjqteQovSGXfh7YMRVKbeMRw21NQro0Qy+gQ/LA6DPgby5/cQICN4eDyYN95UrX4YKucYI2oBsPICG3c8q8kvw9fCtKbZwnr1grISQQtUC1KNVzYdiMagOGFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lm2yVCaf9RoiDruxpEx206c6phucY5FX3RMdmFeXZ9k=;
 b=RDOAGF7+Ik4xDCrKfFjYUaCEgFCp8rPLEoyGEJGfpLOXNIa7YWeEWzZ1VotCI/ZUgTSOVN6QiqcPcDBe5GBx9DmXLKN4YMa19/hFyoPmXJz6oq65UWNMaTUYLl0AXj/clPXTRfxyopcl4hYjwIcO71g4dftgFJvWksN77W1OGtqxvf8pbLNnC0Zgx3QmEOw2m5F4R8LYVLl/bBFar8vjgNGERX4KUT1jJPql2hneEZv8TzpArkgEtYh2C0+YAbEHtbkVjmyx76VGDNFvy3BkIlL1Pl871ZsykDD0NONy0TJd+zaD5o2zx4yCgWb8Y8juLnwrKvehR4dlgdslxCuzqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lm2yVCaf9RoiDruxpEx206c6phucY5FX3RMdmFeXZ9k=;
 b=QMl5bUwlMCq6WdH4tCDHxZVKXNBku4/gXeVQ0tOLa0L6+pc48BPHNHT7qZrod8KvPGtXue3FRb7oTQXlMpourqiZouj8qHTvXYQHCn2cmmywW2ROkv52VRi3CV/u471+HApu4l8pEYs1PhJ1Ycjjvse/PRcpKPKO/VLPR5Dq27w=
Message-ID: <8d543a15-af62-4403-b2e0-3b395edfe9e4@amd.com>
Date: Fri, 29 Mar 2024 17:38:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/15] x86: Secure Launch Resource Table header file
To: Ross Philipson <ross.philipson@oracle.com>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-efi@vger.kernel.org>
CC: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <hpa@zytor.com>, <dave.hansen@linux.intel.com>,
	<ardb@kernel.org>, <mjg59@srcf.ucam.org>,
	<James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
	<jarkko@kernel.org>, <jgg@ziepe.ca>, <luto@amacapital.net>,
	<nivedita@alum.mit.edu>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <kanth.ghatraju@oracle.com>,
	<trenchboot-devel@googlegroups.com>
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-5-ross.philipson@oracle.com>
Content-Language: en-US
From: Kim Phillips <kim.phillips@amd.com>
Organization: AMD
In-Reply-To: <20240214221847.2066632-5-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SN1PR12CA0079.namprd12.prod.outlook.com
 (2603:10b6:802:21::14) To DS7PR12MB6263.namprd12.prod.outlook.com
 (2603:10b6:8:95::17)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6263:EE_|SJ1PR12MB6217:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hkl8K+NUU2xWpYzCX8iWlZCRIWfimJSM5pZ+gyjCjEOSL9P3Rn9yyjmZPpvXl3BxjwRv/Cuh5ARzlvVKIDJQNknQ+d9K98CwpJ6AG1WgKw8W/W1P4HYReUgaauK+aeb3mU2y61lAnHTQ3UutFp9RR5La01iCOkdNx7tX7tHj64Xn2m0lZdu4aahAw7jDi8kiVarGCtHi1SYN93JWcJeGfur9hrKFPBXEq5qyZe2qrUjzW1RBkE0EU1dA20+IEQacqFdX2s9hq/KatEZz5elGbJ2HvS67b239PYcUDEuXxQD7QK3UMILH8ejMlh2k2rRZmnLykNRbEuw7fCSlAT1OwinM80debtnCjVK+99ISveNjFJ0rqFqcc7Z1SKr49EbuiI/pSO2qOrPXjIoMi0LOM38OU4IDG+QzFFHpfVfu85RQg4dvDdMW2HpVnpQzwlwK5OAJhZ/ox3f/OhAizj7rmhbmSY527shjIkG3d6wbLA7LKaUdzB/8JZPGalCjvDkLwH1OmNE8fsgsIy/RSZpf127efi7ROacRLZCh6SJPGWdyuT4UkObzNajAtVe7PDGRWLhPpXCpCYFawvQEJIX0VT3//a/59t0c7N7YZghjEOrjaxif3qE6/rjtvCOKfdwGKU9p5gNTL1MSzSYO/V1ZmMdyRHtgaN+HY7oYjlH9QKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6263.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHlDbnV5TnB2SlVNYjVRbUlLRUh0eEVBZkkxMlg5dmMvRDJLRGZ6cXV3Qngr?=
 =?utf-8?B?aWhIdTNkVHUwQThydWlDU081WGd5TUF5U2ZoamVIcWx4UHJxTVJzLzNXd0xw?=
 =?utf-8?B?MmdVUkx4OFJRNW9TUllwOXY1WlZIcDdubEwzWmY5WlZ6WUpOK0RlRE9ocjhD?=
 =?utf-8?B?K0RhWll1eHlLOE0vMVhHNU5pVTlDUkZCK04xemlheFZGbDVONlVodmZvVjg4?=
 =?utf-8?B?UEZRS09TYkUzN0hIL0hidVBjdjV6RWYwZE1oT1VPVGJmd2Q2bGZmaHMzdUlx?=
 =?utf-8?B?V1d2UUxYNzRlTkliMTVqd3B1VldjOGJVTDZxZG5KNC9yUk5KSXFYSGlXSUNH?=
 =?utf-8?B?anFvN21Xam5zYjZqeEZlc2NaQkJZV0hWOTVzT1ZMaUppejdNYlErNWlyM00y?=
 =?utf-8?B?dE9BU0x6dUpycWUxUERQTTA0cEF4bzEwczIyYzFaT05GV3NHS1d3SHo4aExQ?=
 =?utf-8?B?TG5CSkNJTS9URC94YlAxbHRkRW5oSXRpZENrQnJ6V0RrbTBBU0RDSmY4N2dm?=
 =?utf-8?B?RkQwN3dtK3M4V3JYdlFVM2RSdFJja3NEVFQ4ZTMvTFZvMm9KcisxZk83QVJU?=
 =?utf-8?B?b1NQOG5naURkeWNjeFlwaWtObytydytpT0xpMDlZd2V4cnpVNHR0OVlETmtn?=
 =?utf-8?B?TDhETUxicVJSTW1OdUpiQ1BCZ2FMUVczUFhDSW1UeXNZbnR6ZDVBS0NtM0JH?=
 =?utf-8?B?MzFUeGt5SUM2YnRwOXp2WDI2WW93TEdoMytIS1RyN2N1QXk0RitHaWtIZXZw?=
 =?utf-8?B?QTRLcVZzUlFtRG1JSE56VFhjY2dFZEhuUDUvK0pOeC9vYVpVaUN0YTh5Nm9E?=
 =?utf-8?B?RUs5TDQyWTc2RmlDM0NkTks2ZTZIU1ZWMFNER05XOGh0amxYbTRZUjhlWlcy?=
 =?utf-8?B?aWh4eDZlMGNETTRSVFF4dU5BMDJZMW9hdk9NZzhVdDNtck9ncWdGYWNyaDJl?=
 =?utf-8?B?ZXlIY0V0V05ibHBBTnAwOTVNQmFrai9KNDFyUlA5bzhPQ1ptT2UyL3dIUk4w?=
 =?utf-8?B?WWhxa01Mb21pTk5iQ3NvMmxvSHBqald4dng2WXdkTUZEenptUTNVenV6VFVa?=
 =?utf-8?B?M3NkM2RTRS9tTEFEZFVxdHpQMVc5RlpncnhZRnB0SXJNUmlLRTFZQlA3Z1BQ?=
 =?utf-8?B?ZnF3UDN0Um1NR0h2cVZGdWIwUTEvdjkyVEUrSCswL01PdTZWSEhpeG1EKzBt?=
 =?utf-8?B?UGtBY1lhckVQaWhRK0dZSVpuMXlnMmtxSHAyZ0p0bzdyakJHQzlWNjVyalY4?=
 =?utf-8?B?Nk1rUzc2Z0cydFl4elJnOEJreEhKY1dYd2h2R1R1djJzc0FEUVU2U05UYzhM?=
 =?utf-8?B?UG1pKzRiK2RLNHIzbFA1aGJGaDlRanVZZlFIVkViVzZlMWFpcFUvZ0t5UVlO?=
 =?utf-8?B?ZnBwcW1qQ0RRK0tHcTdFQjM2d2t6MWxYajJtYkNjSlQwODFHSWhTcUhwOENP?=
 =?utf-8?B?Q1VGc2VvNWd0cjYwd0p5VXl4bmFsRFBrOTYrellCOG4yWkNrTi9YdkNlVUpp?=
 =?utf-8?B?ZS9Dekp2KzB4ak4rQktURzNpT0FkaC82bFlxK1F1VjV4QTdyajh4Qlp3UGd0?=
 =?utf-8?B?MWIvUEtydWhzS0VBMExSY1AvZDkvYzNyOGVudUNITExPcHI4RERSUHh0RHBT?=
 =?utf-8?B?Y2MvSjBBclFXNnNDZ0g5QjhSRTJTb1gvOUxkRFczRWpMc29iQWF3QzN0Rzcv?=
 =?utf-8?B?OXdFa2N2OEFaOU84eXZMZ1pOTUljM0tpbDJKOWxsR1h1OE1pRWpTeTMxVU42?=
 =?utf-8?B?RmRwRnhydzVCTEl6a2ZIWmxkTzBSUjBnbDRtbXZVSTVKT0crK1huN1dLMTFu?=
 =?utf-8?B?ZEo4UzlaRmErOFRDUVNTWVQybUhGelhhNjdwZTM0c0NGeDF0ZVdBZmgrWDd5?=
 =?utf-8?B?ZnRKNXpsSTR0NkdZZkxPTWRRTmFJRGRyc0oxT1hOVWJpR3hRM0FzSS8vS0Fi?=
 =?utf-8?B?RzJiZ2xCUTM4dmcrWWJ5NG1xZCtTOXRKNVFXWm1GREZGdlJYbkh4M3c2ckk5?=
 =?utf-8?B?MGxIQnJuYXJpbmQ5THFCTjZqUzkyTEtpbjF0K3hvdk5teWVNMXJJbHNoLzdN?=
 =?utf-8?B?ZnFvU0t0YVlnUnJuUzBDVUVWZ3JKWFZGQVFUQVF3NFAyeVlyaEFNRTdxcll4?=
 =?utf-8?Q?zvdhYQzh59VITtzKjJgRMSRq2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fcf4d61-e37a-4595-254c-08dc50414fbf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 22:41:02.2410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilGgkrAbN/QGxCRDsFAVzxGCrnuii09s15bGN/0TY5T4fJ/decyRW+CsMzueQ3DxrQoL7F9fC4wqSyBOwuyPuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6217
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hi Ross,

On 2/14/24 4:18 PM, Ross Philipson wrote:
> Introduce the Secure Launch Resource Table which forms the formal
> interface between the pre and post launch code.
>=20
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>   include/linux/slr_table.h | 270 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 270 insertions(+)
>   create mode 100644 include/linux/slr_table.h

> diff --git a/include/linux/slr_table.h b/include/linux/slr_table.h
> new file mode 100644
> index 000000000000..42020988233a
> --- /dev/null
> +++ b/include/linux/slr_table.h
> @@ -0,0 +1,270 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Secure Launch Resource Table
> + *
> + * Copyright (c) 2023, Oracle and/or its affiliates.
> + */
> +
> +#ifndef _LINUX_SLR_TABLE_H
> +#define _LINUX_SLR_TABLE_H
> +
> +/* Put this in efi.h if it becomes a standard */
> +#define SLR_TABLE_GUID				EFI_GUID(0x877a9b2a, 0x0385, 0x45d1, 0xa0, 0x3=
4, 0x9d, 0xac, 0x9c, 0x9e, 0x56, 0x5f)
> +
> +/* SLR table header values */
> +#define SLR_TABLE_MAGIC		0x4452544d
> +#define SLR_TABLE_REVISION	1
> +
> +/* Current revisions for the policy and UEFI config */
> +#define SLR_POLICY_REVISION		1
> +#define SLR_UEFI_CONFIG_REVISION	1
> +
> +/* SLR defined architectures */
> +#define SLR_INTEL_TXT		1
> +#define SLR_AMD_SKINIT		2
> +
> +/* SLR defined bootloaders */
> +#define SLR_BOOTLOADER_INVALID	0
> +#define SLR_BOOTLOADER_GRUB	1
> +
> +/* Log formats */
> +#define SLR_DRTM_TPM12_LOG	1
> +#define SLR_DRTM_TPM20_LOG	2
> +
> +/* DRTM Policy Entry Flags */
> +#define SLR_POLICY_FLAG_MEASURED	0x1
> +#define SLR_POLICY_IMPLICIT_SIZE	0x2
> +
> +/* Array Lengths */
> +#define TPM_EVENT_INFO_LENGTH		32
> +#define TXT_VARIABLE_MTRRS_LENGTH	32
> +
> +/* Tags */
> +#define SLR_ENTRY_INVALID	0x0000
> +#define SLR_ENTRY_DL_INFO	0x0001
> +#define SLR_ENTRY_LOG_INFO	0x0002
> +#define SLR_ENTRY_ENTRY_POLICY	0x0003
> +#define SLR_ENTRY_INTEL_INFO	0x0004
> +#define SLR_ENTRY_AMD_INFO	0x0005
> +#define SLR_ENTRY_ARM_INFO	0x0006
> +#define SLR_ENTRY_UEFI_INFO	0x0007
> +#define SLR_ENTRY_UEFI_CONFIG	0x0008
> +#define SLR_ENTRY_END		0xffff
> +
> +/* Entity Types */
> +#define SLR_ET_UNSPECIFIED	0x0000
> +#define SLR_ET_SLRT		0x0001
> +#define SLR_ET_BOOT_PARAMS	0x0002
> +#define SLR_ET_SETUP_DATA	0x0003
> +#define SLR_ET_CMDLINE		0x0004
> +#define SLR_ET_UEFI_MEMMAP	0x0005
> +#define SLR_ET_RAMDISK		0x0006
> +#define SLR_ET_TXT_OS2MLE	0x0010
> +#define SLR_ET_UNUSED		0xffff
> +
> +#ifndef __ASSEMBLY__
> +
> +/*
> + * Primary SLR Table Header
> + */
> +struct slr_table {
> +	u32 magic;
> +	u16 revision;
> +	u16 architecture;
> +	u32 size;
> +	u32 max_size;

Do these need to have their endianness specified with, e.g., __le32?

> +	/* entries[] */

Instead of the above line, a legit 'entries' can be enabled using:

DECLARE_FLEX_ARRAY(struct slr_entry_hdr, entries);

> +} __packed;

You'd have to move this above struct slr_table which would need it:

> +/*
> + * Common SLRT Table Header
> + */
> +struct slr_entry_hdr {
> +	u16 tag;
> +	u16 size;
> +} __packed;
> +
> +/*
> + * Boot loader context
> + */
> +struct slr_bl_context {
> +	u16 bootloader;
> +	u16 reserved;
> +	u64 context;
> +} __packed;
> +
> +/*
> + * DRTM Dynamic Launch Configuration
> + */
> +struct slr_entry_dl_info {
> +	struct slr_entry_hdr hdr;
> +	struct slr_bl_context bl_context;
> +	u64 dl_handler;
> +	u64 dce_base;
> +	u32 dce_size;
> +	u64 dlme_entry;
> +} __packed;
> +
> +/*
> + * TPM Log Information
> + */
> +struct slr_entry_log_info {
> +	struct slr_entry_hdr hdr;
> +	u16 format;
> +	u16 reserved;
> +	u64 addr;
> +	u32 size;
> +} __packed;
> +
> +/*
> + * DRTM Measurement Policy
> + */
> +struct slr_entry_policy {
> +	struct slr_entry_hdr hdr;
> +	u16 revision;
> +	u16 nr_entries;
> +	/* policy_entries[] */
> +} __packed;
> +
> +/*
> + * DRTM Measurement Entry
> + */
> +struct slr_policy_entry {
> +	u16 pcr;
> +	u16 entity_type;
> +	u16 flags;
> +	u16 reserved;
> +	u64 entity;
> +	u64 size;
> +	char evt_info[TPM_EVENT_INFO_LENGTH];
> +} __packed;
> +
> +/*
> + * Secure Launch defined MTRR saving structures
> + */
> +struct slr_txt_mtrr_pair {
> +	u64 mtrr_physbase;
> +	u64 mtrr_physmask;
> +} __packed;
> +
> +struct slr_txt_mtrr_state {
> +	u64 default_mem_type;
> +	u64 mtrr_vcnt;
> +	struct slr_txt_mtrr_pair mtrr_pair[TXT_VARIABLE_MTRRS_LENGTH];
> +} __packed;
> +
> +/*
> + * Intel TXT Info table
> + */
> +struct slr_entry_intel_info {
> +	struct slr_entry_hdr hdr;
> +	u64 saved_misc_enable_msr;
> +	struct slr_txt_mtrr_state saved_bsp_mtrrs;
> +} __packed;
> +
> +/*
> + * AMD SKINIT Info table
> + */
> +struct slr_entry_amd_info {
> +	struct slr_entry_hdr hdr;
> +} __packed;
> +
> +/*
> + * ARM DRTM Info table
> + */
> +struct slr_entry_arm_info {
> +	struct slr_entry_hdr hdr;
> +} __packed;

Shouldn't these three structs be added as part of their
separate per-vendor enablement patches?

> +struct slr_entry_uefi_config {
> +	struct slr_entry_hdr hdr;
> +	u16 revision;
> +	u16 nr_entries;
> +	/* uefi_cfg_entries[] */
> +} __packed;
> +
> +struct slr_uefi_cfg_entry {
> +	u16 pcr;
> +	u16 reserved;
> +	u64 cfg; /* address or value */
> +	u32 size;
> +	char evt_info[TPM_EVENT_INFO_LENGTH];
> +} __packed;
> +
> +static inline void *slr_end_of_entrys(struct slr_table *table)
> +{
> +	return (((void *)table) + table->size);
> +}
> +
> +static inline struct slr_entry_hdr *
> +slr_next_entry(struct slr_table *table,
> +	       struct slr_entry_hdr *curr)
> +{
> +	struct slr_entry_hdr *next =3D (struct slr_entry_hdr *)
> +				((u8 *)curr + curr->size);
> +
> +	if ((void *)next >=3D slr_end_of_entrys(table))
> +		return NULL;
> +	if (next->tag =3D=3D SLR_ENTRY_END)
> +		return NULL;
> +
> +	return next;
> +}
> +
> +static inline struct slr_entry_hdr *
> +slr_next_entry_by_tag(struct slr_table *table,
> +		      struct slr_entry_hdr *entry,
> +		      u16 tag)
> +{
> +	if (!entry) /* Start from the beginning */
> +		entry =3D (struct slr_entry_hdr *)(((u8 *)table) + sizeof(*table));

Back to the 'entries', the above line can now be made more readable:

entry =3D table->entries;

That's just one example, this flex array simplification can be made
in other structs in this series, too.

Cheers,

Kim

> +
> +	for ( ; ; ) {
> +		if (entry->tag =3D=3D tag)
> +			return entry;
> +
> +		entry =3D slr_next_entry(table, entry);
> +		if (!entry)
> +			return NULL;
> +	}
> +
> +	return NULL;
> +}
> +
> +static inline int
> +slr_add_entry(struct slr_table *table,
> +	      struct slr_entry_hdr *entry)
> +{
> +	struct slr_entry_hdr *end;
> +
> +	if ((table->size + entry->size) > table->max_size)
> +		return -1;
> +
> +	memcpy((u8 *)table + table->size - sizeof(*end), entry, entry->size);
> +	table->size +=3D entry->size;
> +
> +	end  =3D (struct slr_entry_hdr *)((u8 *)table + table->size - sizeof(*e=
nd));
> +	end->tag =3D SLR_ENTRY_END;
> +	end->size =3D sizeof(*end);
> +
> +	return 0;
> +}
> +
> +static inline void
> +slr_init_table(struct slr_table *slrt, u16 architecture, u32 max_size)
> +{
> +	struct slr_entry_hdr *end;
> +
> +	slrt->magic =3D SLR_TABLE_MAGIC;
> +	slrt->revision =3D SLR_TABLE_REVISION;
> +	slrt->architecture =3D architecture;
> +	slrt->size =3D sizeof(*slrt) + sizeof(*end);
> +	slrt->max_size =3D max_size;
> +	end =3D (struct slr_entry_hdr *)((u8 *)slrt + sizeof(*slrt));
> +	end->tag =3D SLR_ENTRY_END;
> +	end->size =3D sizeof(*end);
> +}
> +
> +#endif /* !__ASSEMBLY */
> +
> +#endif /* _LINUX_SLR_TABLE_H */

X-sender: <linux-kernel+bounces-125479-steffen.klassert=3Dsecunet.com@vger.=
kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAPDFCS25B=
AlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURh=
dGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQB=
HAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3=
VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4Y=
wUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5n=
ZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl=
2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ0=
49Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAH=
QAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5z=
cG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAw=
AAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbi=
xPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQ=
XV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1p=
Y3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmV=
yc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAh5Pp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgBkAAAAjIoAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 29326
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 23:41:33 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Fri, 29 Mar 2024 23:41:33 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id B6FDC2032C
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 23:41:33 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.85
X-Spam-Level:
X-Spam-Status: No, score=3D-2.85 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIMWL_WL_HIGH=3D-0.099, DKIM_SIGNED=3D0.1,
	DKIM_VALID=3D-0.1, DKIM_VALID_AU=3D-0.1,
	HEADER_FROM_DIFFERENT_DOMAINS=3D0.249, MAILING_LIST_MULTI=3D-1,
	RCVD_IN_DNSWL_NONE=3D-0.0001, SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001]
	autolearn=3Dham autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (1024-bit key) header.d=3Damd.com
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2ehXfJaQBnYJ for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 23:41:32 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.48.161; helo=3Dsy.mirrors.kernel.org; envelope-from=3Dlinux-kerne=
l+bounces-125479-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com D68E5200BB
Authentication-Results: b.mx.secunet.com;
	dkim=3Dpass (1024-bit key) header.d=3Damd.com header.i=3D@amd.com header.b=
=3D"QMl5bUwl"
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id D68E5200BB
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 23:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 735C8B22E9E
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5D713E02F;
	Fri, 29 Mar 2024 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (1024-bit key) header.d=3Damd.com header.i=3D@amd.com header.b=
=3D"QMl5bUwl"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12=
on2095.outbound.protection.outlook.com [40.107.237.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157B128DCA;
	Fri, 29 Mar 2024 22:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dfail smtp.client-ip=
=3D40.107.237.95
ARC-Seal: i=3D2; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711752070; cv=3Dfail; b=3DiT73yaJATXPF6TexZMUEAV2/sxEWzNiLK5TUnvPX0Cy=
2E14qbaNwPyBNeqaglJ//Jx+6uFKjnxeQq+z+nMgdQg7F1U37PDX1ZUB+DIlOCzOGWxC06t1YWT=
90Ew/eW+Rh3ApI8I72qztLjrFodKVarmzb+wwckGDk0XXy7Qh/CJs=3D
ARC-Message-Signature: i=3D2; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711752070; c=3Drelaxed/simple;
	bh=3D+qwRVQtAUFwc+mzfaMAXarOygq0dR3IZtuet68K/Fyc=3D;
	h=3DMessage-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=3DG29ZIU+yv38ZuTtXNi+N8C9Zhwjmp44eIvzsKJgCft=
7KwIkeThqwQKY9NS8L4PwEr46ODNkpxKhj/5OKv8BT1YCNoJfs/awO/a9KJkRV+vJZaAlNqOJlg=
GXBdjfLBdz3f3I2QS98P/ZBr6R+qHJydYb7baxyGFy6LT11pI9R0o0=3D
ARC-Authentication-Results: i=3D2; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dquarantine dis=3Dnone) header.from=3Damd.com; spf=3Dfail smtp.mailfrom=
=3Damd.com; dkim=3Dpass (1024-bit key) header.d=3Damd.com header.i=3D@amd.c=
om header.b=3DQMl5bUwl; arc=3Dfail smtp.client-ip=3D40.107.237.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dquarant=
ine dis=3Dnone) header.from=3Damd.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dfail smtp.mailfrom=
=3Damd.com
ARC-Seal: i=3D1; a=3Drsa-sha256; s=3Darcselector9901; d=3Dmicrosoft.com; cv=
=3Dnone;
 b=3DBkkM76oyZTz2Q2LpBR6pBvhemX3+VK0fBLimXRngfvWCLdPfuoYo/vDDc9RbYD4UJCpFX6=
s1jEACDTyMlHtRFRtONzRJPjfA5pmccOwplO8CEa6s0ovxM9Hl35Er48H48WBDOpZd1uPtQB3DD=
ta7kBsPc3EIceVFUm/Gm1wTOx55QotP37QBX1KD8mX4WMa0LZynfQjnkStLhLnWXcdQwsSPer6k=
iUjqteQovSGXfh7YMRVKbeMRw21NQro0Qy+gQ/LA6DPgby5/cQICN4eDyYN95UrX4YKucYI2oBs=
PICG3c8q8kvw9fCtKbZwnr1grISQQtUC1KNVzYdiMagOGFA=3D=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Dmicr=
osoft.com;
 s=3Darcselector9901;
 h=3DFrom:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-A=
ntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Ex=
change-AntiSpam-MessageData-1;
 bh=3Dlm2yVCaf9RoiDruxpEx206c6phucY5FX3RMdmFeXZ9k=3D;
 b=3DRDOAGF7+Ik4xDCrKfFjYUaCEgFCp8rPLEoyGEJGfpLOXNIa7YWeEWzZ1VotCI/ZUgTSOVN=
6QiqcPcDBe5GBx9DmXLKN4YMa19/hFyoPmXJz6oq65UWNMaTUYLl0AXj/clPXTRfxyopcl4hYjw=
IcO71g4dftgFJvWksN77W1OGtqxvf8pbLNnC0Zgx3QmEOw2m5F4R8LYVLl/bBFar8vjgNGERX4K=
UT1jJPql2hneEZv8TzpArkgEtYh2C0+YAbEHtbkVjmyx76VGDNFvy3BkIlL1Pl871ZsykDD0NON=
y0TJd+zaD5o2zx4yCgWb8Y8juLnwrKvehR4dlgdslxCuzqQ=3D=3D
ARC-Authentication-Results: i=3D1; mx.microsoft.com 1; spf=3Dpass
 smtp.mailfrom=3Damd.com; dmarc=3Dpass action=3Dnone header.from=3Damd.com;=
 dkim=3Dpass
 header.d=3Damd.com; arc=3Dnone
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Damd.com; s=
=3Dselector1;
 h=3DFrom:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-S=
enderADCheck;
 bh=3Dlm2yVCaf9RoiDruxpEx206c6phucY5FX3RMdmFeXZ9k=3D;
 b=3DQMl5bUwlMCq6WdH4tCDHxZVKXNBku4/gXeVQ0tOLa0L6+pc48BPHNHT7qZrod8KvPGtXue=
3FRb7oTQXlMpourqiZouj8qHTvXYQHCn2cmmywW2ROkv52VRi3CV/u471+HApu4l8pEYs1PhJ1Y=
cjjvse/PRcpKPKO/VLPR5Dq27w=3D
Received: from DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17)=
 by
 SJ1PR12MB6217.namprd12.prod.outlook.com (2603:10b6:a03:458::6) with Micros=
oft
 SMTP Server (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_256_GCM_SHA=
384) id
 15.20.7409.33; Fri, 29 Mar 2024 22:41:02 +0000
Received: from DS7PR12MB6263.namprd12.prod.outlook.com
 ([fe80::b286:7d11:bee0:2d37]) by DS7PR12MB6263.namprd12.prod.outlook.com
 ([fe80::b286:7d11:bee0:2d37%4]) with mapi id 15.20.7409.039; Fri, 29 Mar 2=
024
 22:41:02 +0000
Message-ID: <8d543a15-af62-4403-b2e0-3b395edfe9e4@amd.com>
Date: Fri, 29 Mar 2024 17:38:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/15] x86: Secure Launch Resource Table header file
To: Ross Philipson <ross.philipson@oracle.com>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-efi@vger.kernel.org>
CC: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>, <mingo@redhat.com=
>,
	<bp@alien8.de>, <hpa@zytor.com>, <dave.hansen@linux.intel.com>,
	<ardb@kernel.org>, <mjg59@srcf.ucam.org>,
	<James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
	<jarkko@kernel.org>, <jgg@ziepe.ca>, <luto@amacapital.net>,
	<nivedita@alum.mit.edu>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <kanth.ghatraju@oracle.com>,
	<trenchboot-devel@googlegroups.com>
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-5-ross.philipson@oracle.com>
Content-Language: en-US
From: Kim Phillips <kim.phillips@amd.com>
Organization: AMD
In-Reply-To: <20240214221847.2066632-5-ross.philipson@oracle.com>
Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0079.namprd12.prod.outlook.com
 (2603:10b6:802:21::14) To DS7PR12MB6263.namprd12.prod.outlook.com
 (2603:10b6:8:95::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6263:EE_|SJ1PR12MB6217:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hkl8K+NUU2xWpYzCX8iWlZCRIWfimJSM5pZ+gyjC=
jEOSL9P3Rn9yyjmZPpvXl3BxjwRv/Cuh5ARzlvVKIDJQNknQ+d9K98CwpJ6AG1WgKw8W/W1P4HY=
ReUgaauK+aeb3mU2y61lAnHTQ3UutFp9RR5La01iCOkdNx7tX7tHj64Xn2m0lZdu4aahAw7jDi8=
kiVarGCtHi1SYN93JWcJeGfur9hrKFPBXEq5qyZe2qrUjzW1RBkE0EU1dA20+IEQacqFdX2s9hq=
/KatEZz5elGbJ2HvS67b239PYcUDEuXxQD7QK3UMILH8ejMlh2k2rRZmnLykNRbEuw7fCSlAT1O=
winM80debtnCjVK+99ISveNjFJ0rqFqcc7Z1SKr49EbuiI/pSO2qOrPXjIoMi0LOM38OU4IDG+Q=
zFFHpfVfu85RQg4dvDdMW2HpVnpQzwlwK5OAJhZ/ox3f/OhAizj7rmhbmSY527shjIkG3d6wbLA=
7LKaUdzB/8JZPGalCjvDkLwH1OmNE8fsgsIy/RSZpf127efi7ROacRLZCh6SJPGWdyuT4UkObzN=
ajAtVe7PDGRWLhPpXCpCYFawvQEJIX0VT3//a/59t0c7N7YZghjEOrjaxif3qE6/rjtvCOKfdwG=
KU9p5gNTL1MSzSYO/V1ZmMdyRHtgaN+HY7oYjlH9QKA=3D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;I=
PV:NLI;SFV:NSPM;H:DS7PR12MB6263.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS=
:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =3D?utf-8?B?WHlDbnV5TnB2SlVNYjVRbUlLR=
Uh0eEVBZkkxMlg5dmMvRDJLRGZ6cXV3Qngr?=3D
 =3D?utf-8?B?aWhIdTNkVHUwQThydWlDU081WGd5TUF5U2ZoamVIcWx4UHJxTVJzLzNXd0xw?=
=3D
 =3D?utf-8?B?MmdVUkx4OFJRNW9TUllwOXY1WlZIcDdubEwzWmY5WlZ6WUpOK0RlRE9ocjhD?=
=3D
 =3D?utf-8?B?K0RhWll1eHlLOE0vMVhHNU5pVTlDUkZCK04xemlheFZGbDVONlVodmZvVjg4?=
=3D
 =3D?utf-8?B?UEZRS09TYkUzN0hIL0hidVBjdjV6RWYwZE1oT1VPVGJmd2Q2bGZmaHMzdUlx?=
=3D
 =3D?utf-8?B?V1d2UUxYNzRlTkliMTVqd3B1VldjOGJVTDZxZG5KNC9yUk5KSXFYSGlXSUNH?=
=3D
 =3D?utf-8?B?anFvN21Xam5zYjZqeEZlc2NaQkJZV0hWOTVzT1ZMaUppejdNYlErNWlyM00y?=
=3D
 =3D?utf-8?B?dE9BU0x6dUpycWUxUERQTTA0cEF4bzEwczIyYzFaT05GV3NHS1d3SHo4aExQ?=
=3D
 =3D?utf-8?B?TG5CSkNJTS9URC94YlAxbHRkRW5oSXRpZENrQnJ6V0RrbTBBU0RDSmY4N2dm?=
=3D
 =3D?utf-8?B?RkQwN3dtK3M4V3JYdlFVM2RSdFJja3NEVFQ4ZTMvTFZvMm9KcisxZk83QVJU?=
=3D
 =3D?utf-8?B?b1NQOG5naURkeWNjeFlwaWtObytydytpT0xpMDlZd2V4cnpVNHR0OVlETmtn?=
=3D
 =3D?utf-8?B?TDhETUxicVJSTW1OdUpiQ1BCZ2FMUVczUFhDSW1UeXNZbnR6ZDVBS0NtM0JH?=
=3D
 =3D?utf-8?B?MzFUeGt5SUM2YnRwOXp2WDI2WW93TEdoMytIS1RyN2N1QXk0RitHaWtIZXZw?=
=3D
 =3D?utf-8?B?QTRLcVZzUlFtRG1JSE56VFhjY2dFZEhuUDUvK0pOeC9vYVpVaUN0YTh5Nm9E?=
=3D
 =3D?utf-8?B?RUs5TDQyWTc2RmlDM0NkTks2ZTZIU1ZWMFNER05XOGh0amxYbTRZUjhlWlcy?=
=3D
 =3D?utf-8?B?aWh4eDZlMGNETTRSVFF4dU5BMDJZMW9hdk9NZzhVdDNtck9ncWdGYWNyaDJl?=
=3D
 =3D?utf-8?B?ZXlIY0V0V05ibHBBTnAwOTVNQmFrai9KNDFyUlA5bzhPQ1ptT2UyL3dIUk4w?=
=3D
 =3D?utf-8?B?WWhxa01Mb21pTk5iQ3NvMmxvSHBqald4dng2WXdkTUZEenptUTNVenV6VFVa?=
=3D
 =3D?utf-8?B?M3NkM2RTRS9tTEFEZFVxdHpQMVc5RlpncnhZRnB0SXJNUmlLRTFZQlA3Z1BQ?=
=3D
 =3D?utf-8?B?ZnF3UDN0Um1NR0h2cVZGdWIwUTEvdjkyVEUrSCswL01PdTZWSEhpeG1EKzBt?=
=3D
 =3D?utf-8?B?UGtBY1lhckVQaWhRK0dZSVpuMXlnMmtxSHAyZ0p0bzdyakJHQzlWNjVyalY4?=
=3D
 =3D?utf-8?B?Nk1rUzc2Z0cydFl4elJnOEJreEhKY1dYd2h2R1R1djJzc0FEUVU2U05UYzhM?=
=3D
 =3D?utf-8?B?UG1pKzRiK2RLNHIzbFA1aGJGaDlRanVZZlFIVkViVzZlMWFpcFUvZ0t5UVlO?=
=3D
 =3D?utf-8?B?ZnBwcW1qQ0RRK0tHcTdFQjM2d2t6MWxYajJtYkNjSlQwODFHSWhTcUhwOENP?=
=3D
 =3D?utf-8?B?Q1VGc2VvNWd0cjYwd0p5VXl4bmFsRFBrOTYrellCOG4yWkNrTi9YdkNlVUpp?=
=3D
 =3D?utf-8?B?ZS9Dekp2KzB4ak4rQktURzNpT0FkaC82bFlxK1F1VjV4QTdyajh4Qlp3UGd0?=
=3D
 =3D?utf-8?B?MWIvUEtydWhzS0VBMExSY1AvZDkvYzNyOGVudUNITExPcHI4RERSUHh0RHBT?=
=3D
 =3D?utf-8?B?Y2MvSjBBclFXNnNDZ0g5QjhSRTJTb1gvOUxkRFczRWpMc29iQWF3QzN0Rzcv?=
=3D
 =3D?utf-8?B?OXdFa2N2OEFaOU84eXZMZ1pOTUljM0tpbDJKOWxsR1h1OE1pRWpTeTMxVU42?=
=3D
 =3D?utf-8?B?RmRwRnhydzVCTEl6a2ZIWmxkTzBSUjBnbDRtbXZVSTVKT0crK1huN1dLMTFu?=
=3D
 =3D?utf-8?B?ZEo4UzlaRmErOFRDUVNTWVQybUhGelhhNjdwZTM0c0NGeDF0ZVdBZmgrWDd5?=
=3D
 =3D?utf-8?B?ZnRKNXpsSTR0NkdZZkxPTWRRTmFJRGRyc0oxT1hOVWJpR3hRM0FzSS8vS0Fi?=
=3D
 =3D?utf-8?B?RzJiZ2xCUTM4dmcrWWJ5NG1xZCtTOXRKNVFXWm1GREZGdlJYbkh4M3c2ckk5?=
=3D
 =3D?utf-8?B?MGxIQnJuYXJpbmQ5THFCTjZqUzkyTEtpbjF0K3hvdk5teWVNMXJJbHNoLzdN?=
=3D
 =3D?utf-8?B?ZnFvU0t0YVlnUnJuUzBDVUVWZ3JKWFZGQVFUQVF3NFAyeVlyaEFNRTdxcll4?=
=3D
 =3D?utf-8?Q?zvdhYQzh59VITtzKjJgRMSRq2?=3D
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fcf4d61-e37a-4595-254c-08dc5=
0414fbf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6263.namprd12.prod.outlook.c=
om
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 22:41:02.2410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilGgkrAbN/QGxCRDsFAVzxGCrnuii0=
9s15bGN/0TY5T4fJ/decyRW+CsMzueQ3DxrQoL7F9fC4wqSyBOwuyPuw=3D=3D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6217
Return-Path: linux-kernel+bounces-125479-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 22:41:33.7810
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 693ef732-a9f2-4f1a-c89c-08dc=
504162a4
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-dr=
esden-01.secunet.de:TOTAL-HUB=3D0.440|SMR=3D0.346(SMRDE=3D0.035|SMRC=3D0.31=
0(SMRCL=3D0.102|X-SMRCR=3D0.311))|CAT=3D0.092(CATOS=3D0.012
 (CATSM=3D0.011(CATSM-Malware
 Agent=3D0.011))|CATRESL=3D0.039(CATRESLP2R=3D0.019)|CATORES=3D0.039
 (CATRS=3D0.039(CATRS-Index Routing Agent=3D0.038)));2024-03-29T22:41:34.22=
9Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 21081
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.008|SMR=3D0.007(SMRPI=3D0.005(SMRPI-FrontendProxyAgent=3D0.005))=
|SMS=3D0.001
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAZwOAAAPAAADH4sIAAAAAAAEALUZa3Pa=
Vlayedv4GTvNdr
 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
 m9SCg3Iz4JQ+AoJ85ZShiMWpoQKAPvw2hKowskf47QchyTTOCKwc8V
 nzCFFoVyI0q4QnIzAs4SJRXfvQdCaTZb87I9n5SrlEVwTC8JR0k4V8
 HAFKqaE8bdFYDkwP/+uEs4i9IynPiUw1maonOkzzIvN2LuewaCm42a
 6RGuTjVwE3IsB59yPjD2/w+bSqyrni4AAAEK4AE8P3htbCB2ZXJzaW
 9uPSIxLjAiIGVuY29kaW5nPSJ1dGYtMTYiPz4NCjxFbWFpbFNldD4N
 CiAgPFZlcnNpb24+MTUuMC4wLjA8L1ZlcnNpb24+DQogIDxFbWFpbH
 M+DQogICAgPEVtYWlsIFN0YXJ0SW5kZXg9IjIxMSI+DQogICAgICA8
 RW1haWxTdHJpbmc+cm9zcy5waGlsaXBzb25Ab3JhY2xlLmNvbTwvRW
 1haWxTdHJpbmc+DQogICAgPC9FbWFpbD4NCiAgPC9FbWFpbHM+DQo8
 L0VtYWlsU2V0PgEM/wM8P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW
 5nPSJ1dGYtMTYiPz4NCjxDb250YWN0U2V0Pg0KICA8VmVyc2lvbj4x
 NS4wLjAuMDwvVmVyc2lvbj4NCiAgPENvbnRhY3RzPg0KICAgIDxDb2
 50YWN0IFN0YXJ0SW5kZXg9IjE5NSI+DQogICAgICA8UGVyc29uIFN0
 YXJ0SW5kZXg9IjE5NSI+DQogICAgICAgIDxQZXJzb25TdHJpbmc+Um
 9zcyBQaGlsaXBzb248L1BlcnNvblN0cmluZz4NCiAgICAgIDwvUGVy
 c29uPg0KICAgICAgPEVtYWlscz4NCiAgICAgICAgPEVtYWlsIFN0YX
 J0SW5kZXg9IjIxMSI+DQogICAgICAgICAgPEVtYWlsU3RyaW5nPnJv
 c3MucGhpbGlwc29uQG9yYWNsZS5jb208L0VtYWlsU3RyaW5nPg0KIC
 AgICAgICA8L0VtYWlsPg0KICAgICAgPC9FbWFpbHM+DQogICAgICA8
 Q29udGFjdFN0cmluZz5Sb3NzIFBoaWxpcHNvbiAmbHQ7cm9zcy5waG
 lsaXBzb25Ab3JhY2xlLmNvbTwvQ29udGFjdFN0cmluZz4NCiAgICA8
 L0NvbnRhY3Q+DQogIDwvQ29udGFjdHM+DQo8L0NvbnRhY3RTZXQ+AQ
 7PAVJldHJpZXZlck9wZXJhdG9yLDEwLDA7UmV0cmlldmVyT3BlcmF0
 b3IsMTEsMTtQb3N0RG9jUGFyc2VyT3BlcmF0b3IsMTAsMDtQb3N0RG
 9jUGFyc2VyT3BlcmF0b3IsMTEsMDtQb3N0V29yZEJyZWFrZXJEaWFn
 bm9zdGljT3BlcmF0b3IsMTAsMztQb3N0V29yZEJyZWFrZXJEaWFnbm
 9zdGljT3BlcmF0b3IsMTEsMDtUcmFuc3BvcnRXcml0ZXJQcm9kdWNl ciwyMCwyNg=3D=3D
X-MS-Exchange-Forest-IndexAgent: 1 4705
X-MS-Exchange-Forest-EmailMessageHash: 9294DE99
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

Hi Ross,

On 2/14/24 4:18 PM, Ross Philipson wrote:
> Introduce the Secure Launch Resource Table which forms the formal
> interface between the pre and post launch code.
>=20
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>   include/linux/slr_table.h | 270 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 270 insertions(+)
>   create mode 100644 include/linux/slr_table.h

> diff --git a/include/linux/slr_table.h b/include/linux/slr_table.h
> new file mode 100644
> index 000000000000..42020988233a
> --- /dev/null
> +++ b/include/linux/slr_table.h
> @@ -0,0 +1,270 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Secure Launch Resource Table
> + *
> + * Copyright (c) 2023, Oracle and/or its affiliates.
> + */
> +
> +#ifndef _LINUX_SLR_TABLE_H
> +#define _LINUX_SLR_TABLE_H
> +
> +/* Put this in efi.h if it becomes a standard */
> +#define SLR_TABLE_GUID				EFI_GUID(0x877a9b2a, 0x0385, 0x45d1, 0xa0, 0x3=
4, 0x9d, 0xac, 0x9c, 0x9e, 0x56, 0x5f)
> +
> +/* SLR table header values */
> +#define SLR_TABLE_MAGIC		0x4452544d
> +#define SLR_TABLE_REVISION	1
> +
> +/* Current revisions for the policy and UEFI config */
> +#define SLR_POLICY_REVISION		1
> +#define SLR_UEFI_CONFIG_REVISION	1
> +
> +/* SLR defined architectures */
> +#define SLR_INTEL_TXT		1
> +#define SLR_AMD_SKINIT		2
> +
> +/* SLR defined bootloaders */
> +#define SLR_BOOTLOADER_INVALID	0
> +#define SLR_BOOTLOADER_GRUB	1
> +
> +/* Log formats */
> +#define SLR_DRTM_TPM12_LOG	1
> +#define SLR_DRTM_TPM20_LOG	2
> +
> +/* DRTM Policy Entry Flags */
> +#define SLR_POLICY_FLAG_MEASURED	0x1
> +#define SLR_POLICY_IMPLICIT_SIZE	0x2
> +
> +/* Array Lengths */
> +#define TPM_EVENT_INFO_LENGTH		32
> +#define TXT_VARIABLE_MTRRS_LENGTH	32
> +
> +/* Tags */
> +#define SLR_ENTRY_INVALID	0x0000
> +#define SLR_ENTRY_DL_INFO	0x0001
> +#define SLR_ENTRY_LOG_INFO	0x0002
> +#define SLR_ENTRY_ENTRY_POLICY	0x0003
> +#define SLR_ENTRY_INTEL_INFO	0x0004
> +#define SLR_ENTRY_AMD_INFO	0x0005
> +#define SLR_ENTRY_ARM_INFO	0x0006
> +#define SLR_ENTRY_UEFI_INFO	0x0007
> +#define SLR_ENTRY_UEFI_CONFIG	0x0008
> +#define SLR_ENTRY_END		0xffff
> +
> +/* Entity Types */
> +#define SLR_ET_UNSPECIFIED	0x0000
> +#define SLR_ET_SLRT		0x0001
> +#define SLR_ET_BOOT_PARAMS	0x0002
> +#define SLR_ET_SETUP_DATA	0x0003
> +#define SLR_ET_CMDLINE		0x0004
> +#define SLR_ET_UEFI_MEMMAP	0x0005
> +#define SLR_ET_RAMDISK		0x0006
> +#define SLR_ET_TXT_OS2MLE	0x0010
> +#define SLR_ET_UNUSED		0xffff
> +
> +#ifndef __ASSEMBLY__
> +
> +/*
> + * Primary SLR Table Header
> + */
> +struct slr_table {
> +	u32 magic;
> +	u16 revision;
> +	u16 architecture;
> +	u32 size;
> +	u32 max_size;

Do these need to have their endianness specified with, e.g., __le32?

> +	/* entries[] */

Instead of the above line, a legit 'entries' can be enabled using:

DECLARE_FLEX_ARRAY(struct slr_entry_hdr, entries);

> +} __packed;

You'd have to move this above struct slr_table which would need it:

> +/*
> + * Common SLRT Table Header
> + */
> +struct slr_entry_hdr {
> +	u16 tag;
> +	u16 size;
> +} __packed;
> +
> +/*
> + * Boot loader context
> + */
> +struct slr_bl_context {
> +	u16 bootloader;
> +	u16 reserved;
> +	u64 context;
> +} __packed;
> +
> +/*
> + * DRTM Dynamic Launch Configuration
> + */
> +struct slr_entry_dl_info {
> +	struct slr_entry_hdr hdr;
> +	struct slr_bl_context bl_context;
> +	u64 dl_handler;
> +	u64 dce_base;
> +	u32 dce_size;
> +	u64 dlme_entry;
> +} __packed;
> +
> +/*
> + * TPM Log Information
> + */
> +struct slr_entry_log_info {
> +	struct slr_entry_hdr hdr;
> +	u16 format;
> +	u16 reserved;
> +	u64 addr;
> +	u32 size;
> +} __packed;
> +
> +/*
> + * DRTM Measurement Policy
> + */
> +struct slr_entry_policy {
> +	struct slr_entry_hdr hdr;
> +	u16 revision;
> +	u16 nr_entries;
> +	/* policy_entries[] */
> +} __packed;
> +
> +/*
> + * DRTM Measurement Entry
> + */
> +struct slr_policy_entry {
> +	u16 pcr;
> +	u16 entity_type;
> +	u16 flags;
> +	u16 reserved;
> +	u64 entity;
> +	u64 size;
> +	char evt_info[TPM_EVENT_INFO_LENGTH];
> +} __packed;
> +
> +/*
> + * Secure Launch defined MTRR saving structures
> + */
> +struct slr_txt_mtrr_pair {
> +	u64 mtrr_physbase;
> +	u64 mtrr_physmask;
> +} __packed;
> +
> +struct slr_txt_mtrr_state {
> +	u64 default_mem_type;
> +	u64 mtrr_vcnt;
> +	struct slr_txt_mtrr_pair mtrr_pair[TXT_VARIABLE_MTRRS_LENGTH];
> +} __packed;
> +
> +/*
> + * Intel TXT Info table
> + */
> +struct slr_entry_intel_info {
> +	struct slr_entry_hdr hdr;
> +	u64 saved_misc_enable_msr;
> +	struct slr_txt_mtrr_state saved_bsp_mtrrs;
> +} __packed;
> +
> +/*
> + * AMD SKINIT Info table
> + */
> +struct slr_entry_amd_info {
> +	struct slr_entry_hdr hdr;
> +} __packed;
> +
> +/*
> + * ARM DRTM Info table
> + */
> +struct slr_entry_arm_info {
> +	struct slr_entry_hdr hdr;
> +} __packed;

Shouldn't these three structs be added as part of their
separate per-vendor enablement patches?

> +struct slr_entry_uefi_config {
> +	struct slr_entry_hdr hdr;
> +	u16 revision;
> +	u16 nr_entries;
> +	/* uefi_cfg_entries[] */
> +} __packed;
> +
> +struct slr_uefi_cfg_entry {
> +	u16 pcr;
> +	u16 reserved;
> +	u64 cfg; /* address or value */
> +	u32 size;
> +	char evt_info[TPM_EVENT_INFO_LENGTH];
> +} __packed;
> +
> +static inline void *slr_end_of_entrys(struct slr_table *table)
> +{
> +	return (((void *)table) + table->size);
> +}
> +
> +static inline struct slr_entry_hdr *
> +slr_next_entry(struct slr_table *table,
> +	       struct slr_entry_hdr *curr)
> +{
> +	struct slr_entry_hdr *next =3D (struct slr_entry_hdr *)
> +				((u8 *)curr + curr->size);
> +
> +	if ((void *)next >=3D slr_end_of_entrys(table))
> +		return NULL;
> +	if (next->tag =3D=3D SLR_ENTRY_END)
> +		return NULL;
> +
> +	return next;
> +}
> +
> +static inline struct slr_entry_hdr *
> +slr_next_entry_by_tag(struct slr_table *table,
> +		      struct slr_entry_hdr *entry,
> +		      u16 tag)
> +{
> +	if (!entry) /* Start from the beginning */
> +		entry =3D (struct slr_entry_hdr *)(((u8 *)table) + sizeof(*table));

Back to the 'entries', the above line can now be made more readable:

entry =3D table->entries;

That's just one example, this flex array simplification can be made
in other structs in this series, too.

Cheers,

Kim

> +
> +	for ( ; ; ) {
> +		if (entry->tag =3D=3D tag)
> +			return entry;
> +
> +		entry =3D slr_next_entry(table, entry);
> +		if (!entry)
> +			return NULL;
> +	}
> +
> +	return NULL;
> +}
> +
> +static inline int
> +slr_add_entry(struct slr_table *table,
> +	      struct slr_entry_hdr *entry)
> +{
> +	struct slr_entry_hdr *end;
> +
> +	if ((table->size + entry->size) > table->max_size)
> +		return -1;
> +
> +	memcpy((u8 *)table + table->size - sizeof(*end), entry, entry->size);
> +	table->size +=3D entry->size;
> +
> +	end  =3D (struct slr_entry_hdr *)((u8 *)table + table->size - sizeof(*e=
nd));
> +	end->tag =3D SLR_ENTRY_END;
> +	end->size =3D sizeof(*end);
> +
> +	return 0;
> +}
> +
> +static inline void
> +slr_init_table(struct slr_table *slrt, u16 architecture, u32 max_size)
> +{
> +	struct slr_entry_hdr *end;
> +
> +	slrt->magic =3D SLR_TABLE_MAGIC;
> +	slrt->revision =3D SLR_TABLE_REVISION;
> +	slrt->architecture =3D architecture;
> +	slrt->size =3D sizeof(*slrt) + sizeof(*end);
> +	slrt->max_size =3D max_size;
> +	end =3D (struct slr_entry_hdr *)((u8 *)slrt + sizeof(*slrt));
> +	end->tag =3D SLR_ENTRY_END;
> +	end->size =3D sizeof(*end);
> +}
> +
> +#endif /* !__ASSEMBLY */
> +
> +#endif /* _LINUX_SLR_TABLE_H */


