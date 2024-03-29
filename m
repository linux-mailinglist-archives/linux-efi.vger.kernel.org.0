Return-Path: <linux-efi+bounces-907-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCFA893460
	for <lists+linux-efi@lfdr.de>; Sun, 31 Mar 2024 19:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0B91C23382
	for <lists+linux-efi@lfdr.de>; Sun, 31 Mar 2024 17:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8667B15CD6F;
	Sun, 31 Mar 2024 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QMl5bUwl"
X-Original-To: linux-efi@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3693C149C76;
	Sun, 31 Mar 2024 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903384; cv=fail; b=q5veqYFzcCe53F1j8mfknbnGbzwh/6JkXIDOuqwp5eZmlxiCKf+hJU3D1UgyhmdVLWapRGgjV9rcGeG4JDixY2Tf0R28Kv83Icsa/a7M9PknOfQzrJGyEIvKsdS8itqNmm+DbH7kxI941qf4u2JoFRmLiqeF4l0TfhP6zvuCGXI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903384; c=relaxed/simple;
	bh=+qwRVQtAUFwc+mzfaMAXarOygq0dR3IZtuet68K/Fyc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uLrgf27e7yJ/U50ZLEDBFtSOWeJ9cm4cyPu6TMaVzKbK1HDVu6IRE7PPY1YzgMQPy+Qy5lOM2TwvkauYlumsX4eDJlNnKIT327UqLUDB7Y5O6G7uenEVVZSVLZUj2lGNSS3GvYpMNCjQXaBVsU2erD8zi2Q8r6S44RNxRBlMvhA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QMl5bUwl; arc=fail smtp.client-ip=40.107.237.95; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id DFBCD208B2;
	Sun, 31 Mar 2024 18:43:00 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 98DUCs2OV7rM; Sun, 31 Mar 2024 18:43:00 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id C692F20847;
	Sun, 31 Mar 2024 18:42:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com C692F20847
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id B911D800060;
	Sun, 31 Mar 2024 18:42:59 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:42:59 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:43 +0000
X-sender: <linux-kernel+bounces-125479-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoALkmmlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 21628
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125479-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com D68E5200BB
Authentication-Results: b.mx.secunet.com;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QMl5bUwl"
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
Content-Transfer-Encoding: 7bit
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
> 
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
> +#define SLR_TABLE_GUID				EFI_GUID(0x877a9b2a, 0x0385, 0x45d1, 0xa0, 0x34, 0x9d, 0xac, 0x9c, 0x9e, 0x56, 0x5f)
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
> +	struct slr_entry_hdr *next = (struct slr_entry_hdr *)
> +				((u8 *)curr + curr->size);
> +
> +	if ((void *)next >= slr_end_of_entrys(table))
> +		return NULL;
> +	if (next->tag == SLR_ENTRY_END)
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
> +		entry = (struct slr_entry_hdr *)(((u8 *)table) + sizeof(*table));

Back to the 'entries', the above line can now be made more readable:

entry = table->entries;

That's just one example, this flex array simplification can be made
in other structs in this series, too.

Cheers,

Kim

> +
> +	for ( ; ; ) {
> +		if (entry->tag == tag)
> +			return entry;
> +
> +		entry = slr_next_entry(table, entry);
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
> +	table->size += entry->size;
> +
> +	end  = (struct slr_entry_hdr *)((u8 *)table + table->size - sizeof(*end));
> +	end->tag = SLR_ENTRY_END;
> +	end->size = sizeof(*end);
> +
> +	return 0;
> +}
> +
> +static inline void
> +slr_init_table(struct slr_table *slrt, u16 architecture, u32 max_size)
> +{
> +	struct slr_entry_hdr *end;
> +
> +	slrt->magic = SLR_TABLE_MAGIC;
> +	slrt->revision = SLR_TABLE_REVISION;
> +	slrt->architecture = architecture;
> +	slrt->size = sizeof(*slrt) + sizeof(*end);
> +	slrt->max_size = max_size;
> +	end = (struct slr_entry_hdr *)((u8 *)slrt + sizeof(*slrt));
> +	end->tag = SLR_ENTRY_END;
> +	end->size = sizeof(*end);
> +}
> +
> +#endif /* !__ASSEMBLY */
> +
> +#endif /* _LINUX_SLR_TABLE_H */


