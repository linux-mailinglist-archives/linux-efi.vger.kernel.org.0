Return-Path: <linux-efi+bounces-912-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3248944CA
	for <lists+linux-efi@lfdr.de>; Mon,  1 Apr 2024 20:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16A7CB21335
	for <lists+linux-efi@lfdr.de>; Mon,  1 Apr 2024 18:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE8A4EB24;
	Mon,  1 Apr 2024 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OI2QE8B5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U7g6B7Cd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639C84E1C4;
	Mon,  1 Apr 2024 18:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711995991; cv=fail; b=aa7OdtV3eX1+4h+KuSbaNT2+Th0wwvOUa5LlCFmaIs/2SNnIU/cJdWTGOtUK811E0ZnNQVx263IW8Osw1hSqKSx1v4La00f8FKr30FnmT1L19ulrTfLPr7KM2X52iSUsqVzM6PE/dzxobwdX212rg8i/QYmV4vEpCYDbme2vIJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711995991; c=relaxed/simple;
	bh=uVOgijIR/G5kr4uv+vH5d3yyTBekCQihCQfB1rTAEl4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YDKDUdvWUxACp+c74EfQs2z6/87wAFpP1RUZbb9Ytb+c98U9cSWDyZlMZINtaKGAX+Ixr4TgObxNzPP8Aoapli4iH/CniAJSnmOKttFNLtk34QKYGh1NU+IBvXm9exmHiJSz7DKFfX4blVO+zfj44M3ixsQdmkCSxiO8zq0vEyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OI2QE8B5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U7g6B7Cd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 431Hmkqr006790;
	Mon, 1 Apr 2024 18:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=mkeIhTYz9rm/I64hJFx1pJpvqo6enyKR4yhS1YpUTaw=;
 b=OI2QE8B5UjwvVgxgbtoDRIgvqO9nL4/nDYgCATDHbzgW+ItEf6xIlO7/x8ce0Yt4B+Th
 bcaaQQRUwIVMd6uMbMQqqY0F1LP7aiwLlD58iAv7j0u7ePvZcmciPbBVMCiax99RSVUo
 oUuSmB2yIJrWvJwte9jmiOauikfrhApEwAjwyG4e6ssFeVoYrkQ6jw+Y1nHuiPd0taW1
 sDzmKws2QCCNDFZfD1BwhKDUjLCjsH5bSeKYk0Q8RCoHvK0dKOtaa2nRtYysmaDcfTjG
 E8Bwe9Dsvot+RQ3L2zwHzaGDHll7A17+MZgz68QR3ZtfHGOXyH12xlZW3nYXvGn1782u fw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x69nck0ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 18:25:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 431HIDig021403;
	Mon, 1 Apr 2024 18:25:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x6965yrjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 18:25:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSBLo3+hPkShgjcdQTIfu1R7JmIP9OL3CUj6i34qrgtp46vZBVMndIYIgw3+gshxYSJQALDJS+lCrdGIG6awyBLhYd/5T8bCzHT/KnaL6Y4tVCGoMPKDNSrZf87RmqURcib1Odug2gBoOHQqzP57RWrLGMTzGjxr4WQ+5OfPr89k3Ql4eIrVt5Gj9+0zC/841z4yLDsADSg7RkCLRtthXk3pIkdpVKIH5LYJ4q7LfiirtE5g4ul7oHBb/l3XYvXoQd1UvWRVdGXcbwch7S5+osKIXmbInYYCbgDVzGOCM6Uoa7qZK3k4H7ooU1MSqBxrlt1pCT1umXf9uTwJ5UB0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkeIhTYz9rm/I64hJFx1pJpvqo6enyKR4yhS1YpUTaw=;
 b=aPOCDDFuq7FXXo2E10jaGMmNoUkR7sfsXiuGV/9R9geFpf3uc4hC9NnXseXVEcFfs1chJ5RbBXNZ+erfrrvT8yJxFlsC+Yz7M7eN7KMnGs0HGfquu1AJK533201rqCRYmnE1sbUsGHxKxo9bLlOqd3XFCWpn/tMipZvDgfXRwF1L5Vwa1AK77f3MLMkqZGFXm3ZGTo4uuhClVuK1ujBT/Jq/6xNi0Q2J2WwtOK/suBzZsYcBfbakQJd7ryHD0TEFBouOZTw05zzijJUpSqYsAIMIwiEKYKCd3iriJKsuxibemtkv3mb4/t/msd/9hKCkVyKb6TWuFtZ/2L+XGr/HyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkeIhTYz9rm/I64hJFx1pJpvqo6enyKR4yhS1YpUTaw=;
 b=U7g6B7CdUNCIGsdo4Wkbhy0hwKbONbpMHCFwne+hcKze+NU4FIaj8l8EU5NbD6WDjHrOv+9sD1IR+wY2UU6Zy793m6qlKlIWdUURoQZmsii+DOLsuAHcBEDDQGGg91wAOoCsaKerCkuwmMD+7rXnGY+AyjyiHzTHwNfEkyoclvE=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 DS7PR10MB7376.namprd10.prod.outlook.com (2603:10b6:8:d9::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.33; Mon, 1 Apr 2024 18:25:29 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::2f49:6cae:c52a:7d8e]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::2f49:6cae:c52a:7d8e%7]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 18:25:29 +0000
Message-ID: <057e658c-ace1-4568-a680-139f724ecabe@oracle.com>
Date: Mon, 1 Apr 2024 11:25:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/15] x86: Secure Launch Resource Table header file
To: Kim Phillips <kim.phillips@amd.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-5-ross.philipson@oracle.com>
 <8d543a15-af62-4403-b2e0-3b395edfe9e4@amd.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <8d543a15-af62-4403-b2e0-3b395edfe9e4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::7) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|DS7PR10MB7376:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Iewv2/At+nIPOIVNV7m31wA5vAE51vZaoDQtFlaSIBrfp30PpRJh8Y6L0GdzvVmLgkPEreUG3eOozbiWCqEhk6I7Hu1ZdFWL8KBUw6wBtcP5cD+cwTB29YJZRJpVCwoXxEobfVF3nyEa8p6P/eM49owo7lMdZQOYGfvm5RXJnEK/DXNIqGkzPebPpmz/L8Y/MqKsI9nHHrHQss2W+lHr1/wXl9Imrq8bVnPMcUvoL2pwJHlWA5VuNIOjVdKgkJQkRaf8jNKz7biog/EVW/UYZ2/8EthYKwr5S4G7syTB7pXvMikvcn4XCRAZCSkqrtO81AsPMcPOQr6IlQqYoMOtV1WKgesSA4dtbZrblQlfj7PRHLmZoUNd3Qo9ZeUXmERJK7l2z5jH3bYrcU1deFQXffOQ9X7WM7RfubXjrSyV+i81IR3HM7IBAguqyx8KEhv0cFYsuH/99Lth+L1xXqPUAsUb/ksWGSw4Z5rj5eLX502X6mTwNZ8PdAiwuWz3ZbKckZ03LeBwrYipDjiCezXy9fulixWN1Jw1AcbvtHSYEi70pu4SuCCz8IDOL11Ys/+uHZre3OyR+lI15KGUxH90kCKAUYTXbLurehJ33dYAayM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dUE4OFVOWUYvclBlRDJmWEFtSjA5NHVlbWxLUG1COFExaDNZQ1Y5UlZuemlP?=
 =?utf-8?B?eGNjVUprRU1td1VobzhENUdpSm9TZGpVMVlGcERZa09ET3VIYmp6MXd1S0g3?=
 =?utf-8?B?UXBtb216QXgxbXRyRkZZQzg3ZFhhUC9xYzNub0JFSEZuZndWZlhXWTNBWXBv?=
 =?utf-8?B?WW84M2VRMXZMalEyTzhGcTNhZDRDT0k4bDcxK29IRElwZktxOTNBNFVoTDkv?=
 =?utf-8?B?NnBENmdMakU0RlhXY2RLQW1kS0ZVUVIyTzhJM0JPdllWZW90aGRhbk5qSXhL?=
 =?utf-8?B?OVA4R2dGbGpuWFBpdTBTN3IvTWw1VlNLNTdQRjBXRWNHQnMwV084eDVTL1R3?=
 =?utf-8?B?YlE4eWRidmZMV1lSdThhb0N2OWxwVURjMzFHZUhKY2ZyYVFHTTV4dndkd1ZM?=
 =?utf-8?B?ZnBoRHhGQ01Vay9HTWNyZktncVN6ckxWNVc5cmpNZWxDeTVZaUlqZHd4OWpm?=
 =?utf-8?B?Qi96NDBNTXJLVjRjaGRBRm9LZU9qU3Q5c0NRQ1JVWDAyU2tzelZzTTJ2RUlF?=
 =?utf-8?B?Q1pnQXZFRkZ6YnZieXRGUEJ4eW1TcE41VXBqWFVhbVV2WGxUWDVKa0Z6dDdV?=
 =?utf-8?B?b0JHZjBaZW9RcVZiT1pzRUhjTVI5Z0R1bGJIbHFkS1d5andxMk9TcG1ac05j?=
 =?utf-8?B?aEJRWG94Uk9jY1pTN2FOWTYwTWN4dzhYQWw4Z2JFdFJUbTVBMHhKbTQrYXBS?=
 =?utf-8?B?bFJMcCtIZXp5SWtRZ21oMzdTMHVBNGlVU25wL1VLcW5ydGhHKzFucnI5Szd5?=
 =?utf-8?B?OWdJNkRJZUQzU2RobUs5SnFEY3lLUDZyVGtxSXdYdGNsNFNZVGwwdEt5SWMr?=
 =?utf-8?B?TVlyQkYzeStOblI4Y1RHUFAzQktJWjVhU0UyUGpVSDQrTkhNbXVNdURzekNC?=
 =?utf-8?B?cDBzNGltbDk2OUs2bDh4ZXJubDZFZVdZcDZobjJuUWorazVjcEgydG83cXJX?=
 =?utf-8?B?eVErcTZzYUxhRVNnLzZaZytJcHUvSmpvY2pkTGZXRzd2aVVpSkRvQ1JteTAr?=
 =?utf-8?B?eUZGMVJFWWkraTRlcjRVR2lzN0xQRy85U1J5YW0zOEkrMWFUbnFJWm9jaXgw?=
 =?utf-8?B?cDZENGJ2TDJxdmJzQXllcTFINmszRk1zcjNJQmFsSm5aVVpaVmloeitUYjd5?=
 =?utf-8?B?UzZwbGw3ZDIrQzBITHU4N09yazgvdGwzZEY3ZWxMSTg5b3d4cWZPOVVYY0dK?=
 =?utf-8?B?cG1KNEJ6YW1hQXgxZ2FwR1BweFlpeVo5cHBaMnQxc3pFUjVRVjlMSWZzUnJj?=
 =?utf-8?B?V3FXYUs4Z01tUHdDTngwT2c3b2FHNjhBb0hvOWNOK0hzU2YvblEvWkV3eHho?=
 =?utf-8?B?b1k1SGpYUmRNbkJXQWhvQnJQdWFFbTVyUVZHZjY0Q1BjRjVkczlUNlM0SExB?=
 =?utf-8?B?VlZJL2xUa3hpcVlJN1dUSEc1WlNkd0tsWDArcHYvSmtLcUNYV1htNHcwNE9n?=
 =?utf-8?B?YUZhcHpmVHZtVWFQUlZDSm9NRk1TSDVMNldabnpUbFRuQ1lYdWQ2ajJkWXFJ?=
 =?utf-8?B?V2lLWHdGdk44QmRqRmZZV1ZUNnh4QjRPejJ1THgrL3N4NzRSYWlUWVpJbmYx?=
 =?utf-8?B?YlZwN0g1VzdqR25YZ1IvS0RYZEhodDlFVGcwVStuVVc1djltSTh0d015OExM?=
 =?utf-8?B?OGJtejU5YlI2ZTg5Wm1FNWJPN25Cdy9paVZnTDViZGVHcUVYRklJd1I1SmlJ?=
 =?utf-8?B?ZUM5cDA0UXloRFZHcFVGcWtjZjZxbjJkRVMxblA4VytCdlA5dDlYeDR4UTl1?=
 =?utf-8?B?NnhzdUZmbFpVdFVGSXYyTjlvVjdEVVI5WVVSSUNmNXZDMFNQd2pOMTU1dThw?=
 =?utf-8?B?YkMyNnBVUHU5VERlTkJ1N0MrRDRhRXFhV0RXWWtOdE9XSU9VZFdZSzhOU2xE?=
 =?utf-8?B?a1NhaDZQNE5xS0ZHZUR5MlVkdTFlZ1hGTkRESWJlSC93V0xBMjZPWDRLWWs2?=
 =?utf-8?B?VXExaTdRS0twQ29OcmVOSW4rbEpKUWdJcFZvcGVCWFNFT1V0QUtlYVMvS1B4?=
 =?utf-8?B?SmwvWjZqL3NtcCtHTExTdDdEOXZZZ3VWTWQzTU5tL21rNktqb1NBYldlZ090?=
 =?utf-8?B?ZVJKZ1EvODBuVmIzWXlubElqT3VsSkc3UmJjeVk1blFKU1RueXY5SUlCQzFO?=
 =?utf-8?B?NkYrMUNiQURtYlNGblltZHQrck1GdTNSWEZhTmtRdGwvaGdYQkdGTTNSZWJh?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	S9r7LJRGxwiP7wC5nEqL22qUtiiR5NVEw5L3u9iMG+L9tcbZKb6Pv8stVhEOiS+qrLn2nf/jy/cLhzVQj+8vyHeM+a3hOh/te+MnWTpmlNBouUdrzoHq9ONSjG+yXlFbEWlOrezmvJjSD88Tyx+rsVcfM32MTzz6CRM0QCi1ct2ckVhjBY4FE1hKMgvJkjfndcwzJrMgkHw79sIm+lPMgc3uCPh3flZwmvTS9L5lKegijlfduRBBHDxx2yhC87nSQytb+ggHl7taiHJBnPiqZFc7PUmnlj6pEPFwoEMl8oM0sb1Gg2MXwRJ8TCCXiGIhydDlG5lfNhwm/lVOpNiCZgnT7oykvax0WUyUYasLlxCdwQbaDyIi9V3s2q8O+rj6KCVBb98Gdr8RxllceCv7lWCZWkDGOQ+HltGw9G4V/atNDASOGIA9B2ac+J7jIFbkwHY3ib6pZEF8k71Pyl9NN+xb57nYFmWkFl46XS7xtXDGNWtvUxebQoxvg5Iic2e9Y7CibeJHRKvF0zdYHAwpeHN0LrBd6LqZ3eE1dUmZKX6syRod12PbHqaLsLtAhRL0ugjHJ7TP8Ex700M1gqrWUKy7xkXjd/YwJyOfnGEpE9g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1599437f-2256-43a1-5545-08dc52791bdf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 18:25:29.2999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+ukDAL8kZxOjgUQ0h0aneGbiXowsUJwqLIXBZo7T1+pPcieF0KqkohlSBEGoU/GfQ/rnj9v8V0AlsfICExH0JgfIVm/N2vE+NfX4dzh4c8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7376
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_13,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404010129
X-Proofpoint-GUID: Pn8mDkIsajD76dI205M2KByOOA3-I1U3
X-Proofpoint-ORIG-GUID: Pn8mDkIsajD76dI205M2KByOOA3-I1U3

On 3/29/24 3:38 PM, 'Kim Phillips' via trenchboot-devel wrote:
> Hi Ross,
> 
> On 2/14/24 4:18 PM, Ross Philipson wrote:
>> Introduce the Secure Launch Resource Table which forms the formal
>> interface between the pre and post launch code.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   include/linux/slr_table.h | 270 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 270 insertions(+)
>>   create mode 100644 include/linux/slr_table.h
> 
>> diff --git a/include/linux/slr_table.h b/include/linux/slr_table.h
>> new file mode 100644
>> index 000000000000..42020988233a
>> --- /dev/null
>> +++ b/include/linux/slr_table.h
>> @@ -0,0 +1,270 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Secure Launch Resource Table
>> + *
>> + * Copyright (c) 2023, Oracle and/or its affiliates.
>> + */
>> +
>> +#ifndef _LINUX_SLR_TABLE_H
>> +#define _LINUX_SLR_TABLE_H
>> +
>> +/* Put this in efi.h if it becomes a standard */
>> +#define SLR_TABLE_GUID                EFI_GUID(0x877a9b2a, 0x0385, 
>> 0x45d1, 0xa0, 0x34, 0x9d, 0xac, 0x9c, 0x9e, 0x56, 0x5f)
>> +
>> +/* SLR table header values */
>> +#define SLR_TABLE_MAGIC        0x4452544d
>> +#define SLR_TABLE_REVISION    1
>> +
>> +/* Current revisions for the policy and UEFI config */
>> +#define SLR_POLICY_REVISION        1
>> +#define SLR_UEFI_CONFIG_REVISION    1
>> +
>> +/* SLR defined architectures */
>> +#define SLR_INTEL_TXT        1
>> +#define SLR_AMD_SKINIT        2
>> +
>> +/* SLR defined bootloaders */
>> +#define SLR_BOOTLOADER_INVALID    0
>> +#define SLR_BOOTLOADER_GRUB    1
>> +
>> +/* Log formats */
>> +#define SLR_DRTM_TPM12_LOG    1
>> +#define SLR_DRTM_TPM20_LOG    2
>> +
>> +/* DRTM Policy Entry Flags */
>> +#define SLR_POLICY_FLAG_MEASURED    0x1
>> +#define SLR_POLICY_IMPLICIT_SIZE    0x2
>> +
>> +/* Array Lengths */
>> +#define TPM_EVENT_INFO_LENGTH        32
>> +#define TXT_VARIABLE_MTRRS_LENGTH    32
>> +
>> +/* Tags */
>> +#define SLR_ENTRY_INVALID    0x0000
>> +#define SLR_ENTRY_DL_INFO    0x0001
>> +#define SLR_ENTRY_LOG_INFO    0x0002
>> +#define SLR_ENTRY_ENTRY_POLICY    0x0003
>> +#define SLR_ENTRY_INTEL_INFO    0x0004
>> +#define SLR_ENTRY_AMD_INFO    0x0005
>> +#define SLR_ENTRY_ARM_INFO    0x0006
>> +#define SLR_ENTRY_UEFI_INFO    0x0007
>> +#define SLR_ENTRY_UEFI_CONFIG    0x0008
>> +#define SLR_ENTRY_END        0xffff
>> +
>> +/* Entity Types */
>> +#define SLR_ET_UNSPECIFIED    0x0000
>> +#define SLR_ET_SLRT        0x0001
>> +#define SLR_ET_BOOT_PARAMS    0x0002
>> +#define SLR_ET_SETUP_DATA    0x0003
>> +#define SLR_ET_CMDLINE        0x0004
>> +#define SLR_ET_UEFI_MEMMAP    0x0005
>> +#define SLR_ET_RAMDISK        0x0006
>> +#define SLR_ET_TXT_OS2MLE    0x0010
>> +#define SLR_ET_UNUSED        0xffff
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +/*
>> + * Primary SLR Table Header
>> + */
>> +struct slr_table {
>> +    u32 magic;
>> +    u16 revision;
>> +    u16 architecture;
>> +    u32 size;
>> +    u32 max_size;
> 
> Do these need to have their endianness specified with, e.g., __le32?

The working assumption was this would be handled by the way the pre and 
post launch code was built for a given platform.

> 
>> +    /* entries[] */
> 
> Instead of the above line, a legit 'entries' can be enabled using:
> 
> DECLARE_FLEX_ARRAY(struct slr_entry_hdr, entries);

I just declared these without the macro. See below...

> 
>> +} __packed;
> 
> You'd have to move this above struct slr_table which would need it:
> 
>> +/*
>> + * Common SLRT Table Header
>> + */
>> +struct slr_entry_hdr {
>> +    u16 tag;
>> +    u16 size;
>> +} __packed;
>> +
>> +/*
>> + * Boot loader context
>> + */
>> +struct slr_bl_context {
>> +    u16 bootloader;
>> +    u16 reserved;
>> +    u64 context;
>> +} __packed;
>> +
>> +/*
>> + * DRTM Dynamic Launch Configuration
>> + */
>> +struct slr_entry_dl_info {
>> +    struct slr_entry_hdr hdr;
>> +    struct slr_bl_context bl_context;
>> +    u64 dl_handler;
>> +    u64 dce_base;
>> +    u32 dce_size;
>> +    u64 dlme_entry;
>> +} __packed;
>> +
>> +/*
>> + * TPM Log Information
>> + */
>> +struct slr_entry_log_info {
>> +    struct slr_entry_hdr hdr;
>> +    u16 format;
>> +    u16 reserved;
>> +    u64 addr;
>> +    u32 size;
>> +} __packed;
>> +
>> +/*
>> + * DRTM Measurement Policy
>> + */
>> +struct slr_entry_policy {
>> +    struct slr_entry_hdr hdr;
>> +    u16 revision;
>> +    u16 nr_entries;
>> +    /* policy_entries[] */

... for example
          struct slr_policy_entry entries[];

>> +} __packed;
>> +
>> +/*
>> + * DRTM Measurement Entry
>> + */
>> +struct slr_policy_entry {
>> +    u16 pcr;
>> +    u16 entity_type;
>> +    u16 flags;
>> +    u16 reserved;
>> +    u64 entity;
>> +    u64 size;
>> +    char evt_info[TPM_EVENT_INFO_LENGTH];
>> +} __packed;
>> +
>> +/*
>> + * Secure Launch defined MTRR saving structures
>> + */
>> +struct slr_txt_mtrr_pair {
>> +    u64 mtrr_physbase;
>> +    u64 mtrr_physmask;
>> +} __packed;
>> +
>> +struct slr_txt_mtrr_state {
>> +    u64 default_mem_type;
>> +    u64 mtrr_vcnt;
>> +    struct slr_txt_mtrr_pair mtrr_pair[TXT_VARIABLE_MTRRS_LENGTH];
>> +} __packed;
>> +
>> +/*
>> + * Intel TXT Info table
>> + */
>> +struct slr_entry_intel_info {
>> +    struct slr_entry_hdr hdr;
>> +    u64 saved_misc_enable_msr;
>> +    struct slr_txt_mtrr_state saved_bsp_mtrrs;
>> +} __packed;
>> +
>> +/*
>> + * AMD SKINIT Info table
>> + */
>> +struct slr_entry_amd_info {
>> +    struct slr_entry_hdr hdr;
>> +} __packed;
>> +
>> +/*
>> + * ARM DRTM Info table
>> + */
>> +struct slr_entry_arm_info {
>> +    struct slr_entry_hdr hdr;
>> +} __packed;
> 
> Shouldn't these three structs be added as part of their
> separate per-vendor enablement patches?

They got dropped for now. They will be introduced as they are needed. 
For AMD a platform specific structure would probably hold the address of 
the SKL which in AMD terms is the Secure Loader Block.

> 
>> +struct slr_entry_uefi_config {
>> +    struct slr_entry_hdr hdr;
>> +    u16 revision;
>> +    u16 nr_entries;
>> +    /* uefi_cfg_entries[] */
>> +} __packed;
>> +
>> +struct slr_uefi_cfg_entry {
>> +    u16 pcr;
>> +    u16 reserved;
>> +    u64 cfg; /* address or value */
>> +    u32 size;
>> +    char evt_info[TPM_EVENT_INFO_LENGTH];
>> +} __packed;
>> +
>> +static inline void *slr_end_of_entrys(struct slr_table *table)
>> +{
>> +    return (((void *)table) + table->size);
>> +}
>> +
>> +static inline struct slr_entry_hdr *
>> +slr_next_entry(struct slr_table *table,
>> +           struct slr_entry_hdr *curr)
>> +{
>> +    struct slr_entry_hdr *next = (struct slr_entry_hdr *)
>> +                ((u8 *)curr + curr->size);
>> +
>> +    if ((void *)next >= slr_end_of_entrys(table))
>> +        return NULL;
>> +    if (next->tag == SLR_ENTRY_END)
>> +        return NULL;
>> +
>> +    return next;
>> +}
>> +
>> +static inline struct slr_entry_hdr *
>> +slr_next_entry_by_tag(struct slr_table *table,
>> +              struct slr_entry_hdr *entry,
>> +              u16 tag)
>> +{
>> +    if (!entry) /* Start from the beginning */
>> +        entry = (struct slr_entry_hdr *)(((u8 *)table) + 
>> sizeof(*table));
> 
> Back to the 'entries', the above line can now be made more readable:
> 
> entry = table->entries;
> 
> That's just one example, this flex array simplification can be made
> in other structs in this series, too.

This one may have escaped me. I can take a look or if you want to submit 
a PR, the working v9 branch is here:

https://github.com/TrenchBoot/linux/tree/linux-sl-6.7

We have a format that we use for commit messages to make rebases easier. 
It was documented somewhere but I can't find it right now. It should be 
obvious looking at the existing commit though.

Thank you,
Ross



> 
> Cheers,
> 
> Kim
> 
>> +
>> +    for ( ; ; ) {
>> +        if (entry->tag == tag)
>> +            return entry;
>> +
>> +        entry = slr_next_entry(table, entry);
>> +        if (!entry)
>> +            return NULL;
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +static inline int
>> +slr_add_entry(struct slr_table *table,
>> +          struct slr_entry_hdr *entry)
>> +{
>> +    struct slr_entry_hdr *end;
>> +
>> +    if ((table->size + entry->size) > table->max_size)
>> +        return -1;
>> +
>> +    memcpy((u8 *)table + table->size - sizeof(*end), entry, 
>> entry->size);
>> +    table->size += entry->size;
>> +
>> +    end  = (struct slr_entry_hdr *)((u8 *)table + table->size - 
>> sizeof(*end));
>> +    end->tag = SLR_ENTRY_END;
>> +    end->size = sizeof(*end);
>> +
>> +    return 0;
>> +}
>> +
>> +static inline void
>> +slr_init_table(struct slr_table *slrt, u16 architecture, u32 max_size)
>> +{
>> +    struct slr_entry_hdr *end;
>> +
>> +    slrt->magic = SLR_TABLE_MAGIC;
>> +    slrt->revision = SLR_TABLE_REVISION;
>> +    slrt->architecture = architecture;
>> +    slrt->size = sizeof(*slrt) + sizeof(*end);
>> +    slrt->max_size = max_size;
>> +    end = (struct slr_entry_hdr *)((u8 *)slrt + sizeof(*slrt));
>> +    end->tag = SLR_ENTRY_END;
>> +    end->size = sizeof(*end);
>> +}
>> +
>> +#endif /* !__ASSEMBLY */
>> +
>> +#endif /* _LINUX_SLR_TABLE_H */
> 


