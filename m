Return-Path: <linux-efi+bounces-5906-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC2CCCD2CE
	for <lists+linux-efi@lfdr.de>; Thu, 18 Dec 2025 19:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DDF93003FAA
	for <lists+linux-efi@lfdr.de>; Thu, 18 Dec 2025 18:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E10223DD5;
	Thu, 18 Dec 2025 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MVqmp1AJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oNu+JlM1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CF419CD05;
	Thu, 18 Dec 2025 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766082636; cv=fail; b=bVs+l/O8GqvB+3kgn4spqLJJvjmtcjbuyZcCVSlEg2iKr/shKux92/XbMND1VvPc3Ix2NUrNer5e2qxSEDYnj9ykJJKze7WyimZt9JpKfRVz5HragKBqgMuT28RzR5IkOZ98FJZyTP02HMFUxf3gW0+q/2EIu0tDEbhGWSJOltU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766082636; c=relaxed/simple;
	bh=QWNBR1mnupLA87QcsI/D+9QjkfhWM5kNyBKzJGpc9vQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JoUBFP41CTsmzvZK0bAa5QlzcB0+QNbMOLxffUsmsOtZwpvKVRSzqM0ubq4+wFdAwxZiUTwAkKr+xOnQDhOYsUR5PZZjp/YHA7UMAN+QkrdqcQRS1C2D7WZv+mr/M3oiEKc9g/p0JABnn17F3vrDAnnACcLSvychis2w4yBBHy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MVqmp1AJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oNu+JlM1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BIHfulo1798666;
	Thu, 18 Dec 2025 18:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=T5jAUnb4v7l7ueAOcVYgKgB7FmcJ3ymTNcMHkklaVzI=; b=
	MVqmp1AJ9pyLcXu5p+a4TwHFISgcDNjpOl9Ubxfrk04BhYKPQS3gUBn4PTOy5Uof
	uL4oa4vjD/eyWHKc7hpU+0WLJGsMcWbJXsumA0ZklIzDr/DHpO5/GU+lZ1Oh0Gkw
	/r/mMp/neQkk3p8RRRCegh26+b5JGbprEOZaCZlBqIYRCJ5nF0mOXqSocWequN/g
	gkjr+I7jUpJalJdX0dKv0xQYPBOTycbD+W6VXfExXBCHad2ER1eaWpBGjNcChb+c
	/3rbe40Gd3OMQQ93p+ThXI24u7uts8Huu3jnmhTqjzckYWyukRFdU56oNvHbS+08
	OrKCa0q77dQUlApVUGob3g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b47qps7ew-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 18:29:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIIGBfw022658;
	Thu, 18 Dec 2025 18:17:18 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012003.outbound.protection.outlook.com [40.107.200.3])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkpa04y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 18:17:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CoGwxv8lF9V0ac3zl+50cKzYAXXMEyC2I7LRs0xWKtuoIqRcoIOxD2gedUKG6l4OHcV4craxPBl79W/cUeVbyuxX7WIpoM6D7ZquAzbLM+6sIZjaxAkDfInS8rJhx1yM9mJKeGpcLP1lvAZK4D98pKEFytZT+ouBuA8ukOakSynaGfoQW3FnFYDecjmpMSSBFC20QrkaB/CFLAVoMk2IBxxFxWG1gboOMyjOgtfyKf+BgNmOsUF8HGFL7M9W93SfzhHmPdHItjfXuWeBESOExob2WGRhq339baumFsAUIRqhWqe2GoQHEMmyxih5Xhfd6i5rumeF6Y+/Y9nMN36foA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5jAUnb4v7l7ueAOcVYgKgB7FmcJ3ymTNcMHkklaVzI=;
 b=q0Oa+1s9giJCZixDTGWbEsjLLdJDWls73O5hZt+72JIjHKwqYvDtDaj+X1CkrHb3BbPlLZhwueDq2Vj2+sXelwBPQKau61KhB7/cK4puu00ua4GqCEasmGsZJYxGgTN7YIVTJEeIr4PXJ5s5TW+Kzyk51Mgg64lHqADWuzI5E3VkfcJrH9mSZ+OsZVGEfUoa5MPFNvynREW4sCwxaO2PrEF3zCJjaqP9Cs6Oj/+I1pV831ISwP7757jXl0xM8Cc6qpDw/JgmZ8f9NcVDNxGfXRNUYSCNwX5xomJodVX8qud4QkYfvpwg36x/PF36R0ePKZZjSkPwZIvO8GSa7UkNfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5jAUnb4v7l7ueAOcVYgKgB7FmcJ3ymTNcMHkklaVzI=;
 b=oNu+JlM1AkKpDWliMPh8fa6lUsSYIl0f/EJGA9BFLTEmONUf7QdCnmmNj9LS84CbWiYQ2cmA7/+Ae5fbeZPE1evzLhnrKwbLsM4f/LvRsyj1GALe5TZc8y8CH7Y66Jckmjg4HlXxYoIMLD/wKbjXeXL9cqpck2m56NcdrnB27Q8=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 SA1PR10MB997712.namprd10.prod.outlook.com (2603:10b6:806:4c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 18:17:15 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 18:17:15 +0000
Message-ID: <2c0074fa-4f58-4895-9c2e-e1fca59d3bdb@oracle.com>
Date: Thu, 18 Dec 2025 10:17:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 16/28] x86/txt: Intel Trusted eXecution Technology
 (TXT) definitions
To: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        iommu@lists.linux.dev
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <20251215233316.1076248-17-ross.philipson@oracle.com>
 <6ddb3366-31a8-4d18-a553-908a035f7cf2@intel.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <6ddb3366-31a8-4d18-a553-908a035f7cf2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0112.namprd07.prod.outlook.com
 (2603:10b6:510:4::27) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|SA1PR10MB997712:EE_
X-MS-Office365-Filtering-Correlation-Id: 511ada56-0dc3-4a2e-59cd-08de3e61abe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlRoVUU4MXgrbXY1QS9iV0RKaHpxcllzNjhMV3M5eUE5UUhJZGdnSGxmQnNF?=
 =?utf-8?B?anY5bnVaYmpIVzJCU2wyQUk4YW9OU214emUzUlBpd01FZTQrRmIyQUhDQVVv?=
 =?utf-8?B?dStZVERQTDltY1JXbHBNQjFHcDBEUk9RSUxJU2xJNVNaMTNYbFhVSDdXVFRv?=
 =?utf-8?B?Mi9zMk5WbklBeTQvcUpQZTJvczZ6REtENWdnaHE3ZWcyejJ0NmZweWhod1lI?=
 =?utf-8?B?UW9xSURkRDVZN0MrSDdRaDFKb1I2UW1MQXU0cTJ3T2w4TnlwUFUwc1FGV29W?=
 =?utf-8?B?WU9sYXhEc2w3YWl4UDBJcm1uajN5bmVXWDdpRlgwdnZFUjI0ZHdSNnd1bEo2?=
 =?utf-8?B?bzVUSG5XK1BYbWN4TGJVYlozSWg4UkQxa0N4akFUc2dZLzNNcGVmSGl0WmtV?=
 =?utf-8?B?SEhPMGNQNzdZZDJjV05WVHNmM1Z2S1RMbkE2NGRZVWJUOWYrM1dXMFcrekRF?=
 =?utf-8?B?MWpDK2xBY0NPMWo4bjdBVC9rZU5rejR6VTVmdzgxWmJURzh6RUhRTkU2RXhK?=
 =?utf-8?B?eFVuUExldDhBRHlOQXo0YUMrbncwTGMrYndzQnB3Y0dDQTJ1WU94K0d3M0w1?=
 =?utf-8?B?TjNwOVRpRTR2eFdKTGZyRnQxQWJqWnkzaHJSdUtxT2o4RUNLTFV3Y2NwNHZz?=
 =?utf-8?B?Unp3dE9ReFN2RkVuanQrS3gwZG5iT2ZmVW8vN1ZNYkNHQkFzdzc2OHlLWWF5?=
 =?utf-8?B?N3BXcW9qZ3R1WktjbzBUWG1IK3lieUIrY1hvN3ZtZnhZNGx4YVBjNDIrYUor?=
 =?utf-8?B?REw3YjZiNHBwenpIbTI0VGVsZ2VlTmZXV3VnT3V5c2ZaWHoyR01jbFZjL1c2?=
 =?utf-8?B?QzUxa0hFZ05SQjcrdklRQWVITjRCQUUzYlZRZWZUVDVLWTZJQktuZUhQVjJl?=
 =?utf-8?B?blJFZlQrZUxnRWk4V1lyUkM4N3FHRVppdHI4aU9vbkIxTEU3dHF4emI1Y1h4?=
 =?utf-8?B?d0FoMWxzQzZBcVJHdi9nSlBxTlgyZUNnQm9NM3YwMEdkSnZLZGVMT1orYWlh?=
 =?utf-8?B?TW8zNWI2NGJRbnpIVDlCUzRHb0ZEellSZFJNaXdyK0JhOWdmNUdrV25lNXNE?=
 =?utf-8?B?Tmd1RGE4cjFQZlFrelB1a2xWQmgxZVRyUHFJajNsR0VJZk9OTW4rK2g5b3hk?=
 =?utf-8?B?blZreVhBNDhrdEp2cVpzVzZRYnB2TVptMU1VcEhYOW1ZVXlSZ3pWc0c4Szl3?=
 =?utf-8?B?NnhDeWJFZVQxWTMyYmJBMHc1WGJCQVRsK0Focm5GeDFncHJ2TUVtMU4weDhG?=
 =?utf-8?B?c0FGd0d6ZjNvNHlQVjN0a1VYVlA1SklwNis2ektRRkJKa0RvZTEydXhIOWlt?=
 =?utf-8?B?S21jMkp2NUJZdmlCRTMrZ0RhRzh1S0FJeDgxaXVCZTh6ZVJCeUFEWGtmN3k2?=
 =?utf-8?B?b2xXR0s4SXBaeUdXQWRzanc5ZmxObVpzZ0xSbW9JMmZmYVM3cklyeFpjakJz?=
 =?utf-8?B?K3FidFlWb0pLU2Z6Nk1KazNueWFsMVR2d2NEQWttdUJCY0RBY0lYMHNHMTVN?=
 =?utf-8?B?WHBtTjlVcUFlSUNhMmtrUGQvemFoM296Q0JyMkE4VUppckZ5SVdKRVBkMkR4?=
 =?utf-8?B?WGt2Sks1N0ZZWG0xcjM4dm9hK2trVVhjeTJ4MnhLTXRHb2VxRE9QdkF5aklX?=
 =?utf-8?B?dW80MTZ0eUFJMlFGZURzUExKb01wUlVWUFpwNjZScDBSODBVWXQvQUlmNEN5?=
 =?utf-8?B?N3A2YytLTndYRDhLZnNtcGF4VC8wRTZ1RmJUeDg4cWkvNlpVWGQ5OHAyNGtU?=
 =?utf-8?B?NXhxSmdkK2s4bzBpUjB3ZVNQZWpHR1BOcENLT2dabi9rSTZVMzlWTTdsYjJF?=
 =?utf-8?B?YVFWaVBMaC9DMGU5ckp1Yld0c0J3OVhSSmYwaHB5MGlGSGM3SktzTlYydzlD?=
 =?utf-8?B?RnpvMDlPWFV1d1J3UHhEL2JnTkNYK3RrQVVWdEh1N252V1dFTWZNbDFJZWY1?=
 =?utf-8?Q?+PURR13/RH5wFiV4xO+wjBBvBHzyGcQb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEdHcE1ZRHExdm43bDhRSEhsV0UrQ3FsS2hkMmFUNGE4djVsVzZSbFNEQTJL?=
 =?utf-8?B?S2tPUm0vZVhvanRrK1Fibk15cEt6dkhUcHJGaTVCTW9XTTlYQlpCNDFIY1Js?=
 =?utf-8?B?b2lHb0F3NWRIQTNNbW9jWm42RzhlS3QxOEhDT2NFdVBaY1IxdHlkalQreUUw?=
 =?utf-8?B?cUY2azZjSTdndzdUR09UQXZXQkw5ZEdtY1BMQ3VJR0UzamdIYW54Smo3M05z?=
 =?utf-8?B?UG9jMHF4K21iZitvb20rWHVJLzc1WjVmdUpIenFBanpsbG9zSlFzNVF2L3dp?=
 =?utf-8?B?cm9EZnFWZkpqa3lSbUt2UkYrQmhRSVFLODFDYXNuanhCS040enpacngzY1Vv?=
 =?utf-8?B?UTJFZGEwcUlycGUrelNwSGFzWHY4ZkFwai9VWXZsOXEyNUFSdHZiZEtQYUhw?=
 =?utf-8?B?blBxWlBGdmRMeS81dlZ3cEIrMUZRSDBVemJ0clZmZDVoOWg0Q1hVTE5rN214?=
 =?utf-8?B?dzE4WTNaY0ZqNDQ4NXIwRStLVkdxMW96Q1FHZzJidHh3d2FuNkdtamhzR1BR?=
 =?utf-8?B?QU00THkrZzRwZStyN3MyU1hVRDkzaEp0Myt5bng0Um5samxnN0xlWFRnZjV1?=
 =?utf-8?B?dXZYY1ZjWXBNWGRxOTVGaVRGVjRDUVpKRjdXZ1p3cnJOellKR3psYWN4cUpv?=
 =?utf-8?B?OVo3VjFJQk5ocEM5ZVNpdExyVWxMSGtKaUFWUXlpenJaL1BWMXJ3bTNMR1ow?=
 =?utf-8?B?NkJXTHZ2ZW9kbVpMM2tHZmZENWg5N1JXTUFITjFCNzZPWGVrZGtDQ0EwZ0RO?=
 =?utf-8?B?b3J6aVlhT1FPbmhXQjBGTzVOVGZTaitJbXluUVdzOUQyTHcxRDRjSEdaNFNh?=
 =?utf-8?B?bUpkelh5R0hQVWg2WFBOYWVJZHJVRldQMmt1ZnozTlExOGNLUG5oRWs5TkQ4?=
 =?utf-8?B?S3lpclZMczgyMnBTNFhKcjA2WDdVVjFVelBJZ2ZwV1ZCMTFhODdHdWRDKzVV?=
 =?utf-8?B?QjAraUo3WUtXM21aa09rdGRxSG9qOHFQbG1pQU81VUdDSVZqVXZ3eERkUHJN?=
 =?utf-8?B?ODI1L0ZnSnI4dEoyaUxFSzlBMDNvenNXVldKM09RaWNWMk95aEZScGIyYy9I?=
 =?utf-8?B?SHQ2RkZqK3pFUnVCbGtGNnZyZHNhOFIwdGFSd0UwWExaekg4Y3ZKaWdua2Rn?=
 =?utf-8?B?TVpIS25TWjNQUG1venJmWlFGSFRjTEVoblkybWFMTlNFakN1SFQ1K1RYWUFr?=
 =?utf-8?B?YXJINUlhVmlwTHoyK2dNRGlHOFZsMm93TnlwOG1IeEE4U1M0QlUzalA4SlZQ?=
 =?utf-8?B?YUJuUWNtRE9qUmYvYWpMZENQNGFaQy83SnZGTWVWN1pYeHRVQXVWemZkSHB1?=
 =?utf-8?B?N1ZwZ2swTW9XaTJOU3ljZzZwVVZXQ1UxVE5NT2ZhWmJ2emlhUjlMRlZkSXFt?=
 =?utf-8?B?VldlelEyOXFybGh4SHJucXJDY1NqSkpJNXpLMzNqSU94eWYzRzhTZ1FHY3Er?=
 =?utf-8?B?RWVWVnZFYTRjbzU1SXBpaTllVjRkR2lxSUFYQUFkbVZhTlBkWnU1YmFUMGFw?=
 =?utf-8?B?dWRkYzNmd0NjS2U5VE1CS1EwMmJjQ0N1QVJYeHJBUiszdXJUMHd2OXpPSUVu?=
 =?utf-8?B?Y05ENUtjV2I3dU1lTGlVdUdxZWwweTIzcTg4aGNWVkhHbHdoRFhvVnB2NVh0?=
 =?utf-8?B?N3F4MTg4VDdXQUJmeE1qS3BxUGx4MjNuTjNpbS9PcDNQUHVOY1QzUnlqejkx?=
 =?utf-8?B?UkVReUM5eTArOXhuZmFsdEN3Y0RrWXlUTEdUNVNpbnN1bFNsNjR0RTNzdEt1?=
 =?utf-8?B?alZwakIxMGF3L2FQc1BwUkREb0Ztamwza210R2craTJXeVd4TEpjOFJFbUV5?=
 =?utf-8?B?Q2NGQ3FXdzVBZzBaazExTm56a2dmVzZSM040WGZrZ0oyZGtDcXczZWNqQ2lF?=
 =?utf-8?B?WnBIajFZb1hmS0xwTVdZcjVNTy9nZjZQNmpiLzhRVFhjcTBVN28vZ20yT2h3?=
 =?utf-8?B?VUNjMEpja0ZxSE5KMEtGMHU2YzdtVHFhQllHNDNSZ1FIVkFOdkJOSkQ5ejhV?=
 =?utf-8?B?VFdmZGY4VHArSFJrNHdOREZnL2VMWGpOV0JZQkhLQ2dsZVZwV3ZVYWR6R092?=
 =?utf-8?B?SkV2Y2pDZDkxK1pSazZuRnZHRmtPazZPeEY1MzFtT3NLUHRTTkd0VTB0NHAx?=
 =?utf-8?B?Wmlvb1E5YTcvSldtb1JCbk5OY2ZvSXZDa2orQk1HZk1wOXVBbHJET3hZbXNT?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AIjesjXwESdWUEneKk+NozF5Wnpl0sWjNIsZM1UBvgTMgAXGwF2b32P1L05FeducZBklBMZ7TMGI81XcMYdUmpu5pJ+P77onxaTX3ZFuR5kn2XoA5ewBXJxLpfDKacigsxIrn8+IMPdJ2BXuUxES0MJaKHEJhLUYLmAqJrMApnO7LtPZCY0Celga56meV8WLoo5qG7gys5drNBb6v5us7adiwCDePTr8DYb2PORCdIXYhK1+esWsBwlY56XwQ96k2BnVT1Nfb7L+aArVoG+m1p+yJ+8MtY3DYDf5OUyFsOHogH3ZBV90B4aB092pRCWgK6WFhHx01hi7q+I9F69Qq4aybDu5lfYCUr7g12VTEUlxWr4U1dCcgZBWUL7eWHhPJpSIl7Qbcmfox1+XzVee3SejxxmCN+w61bLqnhmi8B7VcgmiTM2D/Jx1RILlUTZswpKyDDh2gDrx2rD2ieuqcivCAjeaok8uk/U+M7Ko9kMGcPVx0DEcaK+z9TP4i9a29vFTU0KrSPUB+13mpPoMg+wbwgNCpe302okVBBBK25xR8ehzsoMp7nd1FKhZlW3LYLjeR5E1BUbDsF/566v+irLx404BZ3fs7nWa27a5yuI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 511ada56-0dc3-4a2e-59cd-08de3e61abe3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 18:17:15.1398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XcNAr+JLWpiREsdlugA4zxUAfoG8j2qt6waY2stx58nQ85uHBWmJCNQSWVe/Dt0pZDrNtBcIdjR2PmzM9+EbYb/Ub7vRSgsUkIj9stmLyjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997712
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_02,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512180151
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDE1MiBTYWx0ZWRfXxhut1fLSUUba
 v1POaANuoWzOzJsdx7oOiNiMBMax84IVc3+vj+520A2bRPqcUtQxJnfp81CCeNPlEkTOL4PLpoU
 hSNbgtTVLV86FcE0vvwt9qnayhvTfsVXoNxqVDpmn3FkyLTcWAdD9RDMJ7bzzXDkJ5fC3jUXIjQ
 hkwCjpLIbeuCxJbeWIy2vfmHGLFzwLeFu9+ecSQD9OvwBCFbskwZPdD9j7ILrXz1b0n5yt4oQs6
 POZ3dSdu8vbxL07wWZEZ7Qu9I8MiB5DuAKfcUuWwtKNzYME2BGQYY9rCS5fh8mTzdoiNRBoVAf3
 WmKwXolImc7sxok/mHtLqS/0gtdhm6x6BNhpTFIRBGe2YJdhK8ajzHopVnzM7Cu4GNQ5az1AFCx
 oTYRBH71vTCrMyo0B5Z0dcXx2wbM6T/7LnJtlwwLRLUOjoMz97k=
X-Proofpoint-GUID: AD-jzlLSmfZ1RK31M_82gIC1usJJSCiU
X-Authority-Analysis: v=2.4 cv=ePkeTXp1 c=1 sm=1 tr=0 ts=6944480a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EjwGXyRj3iqX5iog8PsA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13654
X-Proofpoint-ORIG-GUID: AD-jzlLSmfZ1RK31M_82gIC1usJJSCiU

On 12/18/25 8:34 AM, Dave Hansen wrote:
> On 12/15/25 15:33, Ross Philipson wrote:
>> +static inline void *txt_sinit_mle_data_start(void *heap)
>> +{
>> +	return heap + txt_bios_data_size(heap) +
>> +		txt_os_mle_data_size(heap) +
>> +		txt_os_sinit_data_size(heap) + sizeof(u64);
>> +}
> 
> So each one of these walks through the entire table?
> 
> Maybe I'm naive, but wouldn't this all be a lot more sane if it was just
> parsed *once* into a table of pointers?
> 
> enum {
> 	FIELD1,
> 	FIELD2,
> 	FIELD3,
> 	MAX_NR
> };
> 
> void *parseit(u8 *heap)
> {
> 	void *ptr_array[MAX_NR] = {};
> 	void *place = heap;
> 
> 	for (int i = 0; i < MAX_NR; i++) {
> 		// The buffer starts with the length:
> 		u32 *size_ptr = place;
> 
> 		// Consume the length:
> 		place += sizeof(*size_ptr);
> 
> 		// Point at the data:
> 		ptr_array[i] = place;
> 		// Consume the data:
> 		place += *size_ptr;
> 	}
> 	// along with some sanity checks
> }
> 
> Then, to access FIELDs you do:
> 
> 	struct field1_struct *f1s = ptr_array[FIELD1];
> 	struct field2_struct *f1s = ptr_array[FIELD2];
> 
> Yeah, it means keeping that pointer array around. But <shrug>. It's also
> not about performance. That ^ is a billion times easier to understand
> because it lays out the "heap" logic in one place. You don't have to
> recurse through half a dozen helpers to figure things out.

That is an excellent idea, we will do that. I may be able to use the 
same the index scheme when I do the early remap operations too. That 
walks the heap each time but does not have to. It just wants a pointer 
to what to map.

Thank you,
Ross



