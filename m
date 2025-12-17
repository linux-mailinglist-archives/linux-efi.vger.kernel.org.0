Return-Path: <linux-efi+bounces-5896-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C54CC9428
	for <lists+linux-efi@lfdr.de>; Wed, 17 Dec 2025 19:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E88573064E7E
	for <lists+linux-efi@lfdr.de>; Wed, 17 Dec 2025 18:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC953358C0;
	Wed, 17 Dec 2025 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wp4qMCsN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ru9ivok/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811912957C2;
	Wed, 17 Dec 2025 18:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995178; cv=fail; b=d0++2VU/k26XGCupVSxHj1O4M4IQyb/ZMZVcZ6Yn3zYfDFm1Febn0WMXKVy3VNps00a8WEZPyvEYOYiYgrqMGgjYkhMUxARm+EWSUw7M7bYKO/L1GHd9wRSoNPOawinYaDvVmk3KNjZseWzPSwXejmOnnJlBEntWV9k/zANJ3Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995178; c=relaxed/simple;
	bh=IEzi6jHXhADfaNI5y+vewM+eHk7wMflSdpAXPEYfBuc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GSmZDZ2lIvCD4Xr9AqNQC92g7ntiEzN4wCFdgI6XgXk/yzbSXGWYn7MNo2FEFun6P/wmCPC+VNndN2JRTUDCr1K2uIGVuAUX4YACtHFmZwkhjUM0qo7/y8PXcuthoZLMOJ4plcEvXp7VDJ7jOrdsgt3+6bupKbcHLGhQ91yCjaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wp4qMCsN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ru9ivok/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHH1Xib3071708;
	Wed, 17 Dec 2025 18:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=aoBVEXPlHbeRmsr/a1g+mHxak89huPGsJBG9c6KEXiQ=; b=
	Wp4qMCsNUN3mXc267HnSHXUo20p5LlFfY/hk/JJfT3XqITGlMZf9sCarDwKWL2y3
	JN1WMWkkxiS0arF10606VlsY9IHSyae2f8J1t/Bd5rWnltwZ1Q0Lq9gjCEeoH/xt
	Sv6SwbZfMtHmtfZCglE5JfG2ml4x2HJLSe91aHKF09vYfmBlS54EDSYkFdBg++AX
	OYwD/ZLhTcANQP/+oMHgtlIhdL0vLE/wfR5uHEpt2OACjRVDk5Sujh90dW8iTWs1
	NsSi35r2BbolmWNpYordAd8QZ1fP7e2EpHKs0idSra0rDMZTr+PMOnQsT54NWm0n
	EHA7nY9mDzrfHX36iqkhfA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b3xa2rdyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 18:11:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHH7C0k022552;
	Wed, 17 Dec 2025 18:11:53 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010051.outbound.protection.outlook.com [40.93.198.51])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkmwe9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 18:11:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCkmSRVOFHUwI/+qLtVfD6x748qcTyp1CV9GMZyS25rqEiCH7RB5TcrOVgmoVbjxRGW1HLaEnXzlWHT4Hhv3f0VASOql0b5Erhd4ErFj/AE5CGMx1vfgd6KygOxOi7XZAwNvWIZ7v0sFNwOtyjOqrXXxkxWgLCYqbQ+LeqOE3gs4zAn8psQfM+HV6jktvgIELCjWiTTIjxlPHu1gi68ogi0IgrUjUmwf/aQPOGmO+gUxusKgvwww/SETyRZpGSoD8LU4xSpyyBkKHWgPdttD/uedj70ORslpGH/j+eAvjWt1XxVz82MZsbv7Z3aK9T6Im3xbMvyfFBRtKbkaqqqBkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoBVEXPlHbeRmsr/a1g+mHxak89huPGsJBG9c6KEXiQ=;
 b=DMmc2LplIfTmkiXsyac1NGwfK4ksCJxGVfBTEk14jrezE3FCuQfIlHmIPsXKRacJnG+5hOGj2LI1m0qlz8H/qDY9mP6Lv7STgOkwoMXoAeVKSTRePgV5NRacDyUhR9hALqGCA0uS0zNIwkBXIj3fu3vea2hNJYLpxbE3ePYjgXh3HvsxX/3RRrxD3eZYmzYwqfGJczivfmbMM30gXTgXzVMNnNGGVZGzCiwmDLsZkiPEOMQuNe7zeU4vb3RpjnZXZSJGxC8u5EogMD3GUVQh1/AGxjShPJ3HESQ8Lr0ZUE+zk2kCPdiXXNBCLIyYYkq4o7V8ZkriKhHkA5OSiPD/Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoBVEXPlHbeRmsr/a1g+mHxak89huPGsJBG9c6KEXiQ=;
 b=ru9ivok/hQm9OUktAAL1yTU9XIcuxM0J/DCuqH1SIgKF7x1WaZMmrSs+wN7ySZDHczV/AinoUfjVvejGFa/vm4F/P/i2w+dehWd4Sn38OABG3qUvUCQesYRNTCYI/s3ZyrnbSeIQyqjglhPGcH/jBAQLKnx19k9r0WfoEtjWAtg=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 MW5PR10MB5716.namprd10.prod.outlook.com (2603:10b6:303:1a3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Wed, 17 Dec 2025 18:11:49 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 18:11:49 +0000
Message-ID: <4f54b07f-de1f-4b5b-89a7-a9d337b17ed9@oracle.com>
Date: Wed, 17 Dec 2025 10:11:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 13/28] x86: Secure Launch Kconfig
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
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
        trenchboot-devel@googlegroups.com, ross.philipson@oracle.com
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <20251215233316.1076248-14-ross.philipson@oracle.com>
 <f2b1d24f-86fd-4b90-b6c0-126a4a2368ec@infradead.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <f2b1d24f-86fd-4b90-b6c0-126a4a2368ec@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0137.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::22) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|MW5PR10MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: 870c6503-dab4-4dc3-e32c-08de3d97bf34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0c5N1NjeUVQZDR3SkVhMVcwOEgrcmJ3UytDUG8yRzR4Y1dJdHhXYUZVYjFa?=
 =?utf-8?B?YnhkdVRMYkNocHBadUk4VUtwTTh5ZzA2S29ZYkhtVkQxZ09zVmtaZDRicDFV?=
 =?utf-8?B?WWg2MHVSVGc4WXBGSXRkdGxIU0dlM2VUZVJETStPTmpDSzlJbnFWYzUvWHRt?=
 =?utf-8?B?eEZSN0lFRG01ZTVjc2s0Njc0Lzd3aktXQVdZSVgrcGVFZ0gwdFQ1MVJMd0ti?=
 =?utf-8?B?V3FwOE92WmNCUWNMdlBTQ3lLUzRWM0R4MHNuQVlhUnFraHptNnlHa2tlaHlo?=
 =?utf-8?B?STdTazluSTRNMEFYNUthZ2N5VlZUK0dLNENJcE5YTnZWSnhPa2hERS94R0hK?=
 =?utf-8?B?U1M4TzdseTdCZnRpQ0x2azZsWTVKQUFqOGZJVCs0ZDIvMW5hc0VkWisyUXdB?=
 =?utf-8?B?OUVGREY0MFdwZDA0eXRzQ01CZTNzTHZxRnBWSUp2MWRNN1ZnZ1Z0T2RvTWxw?=
 =?utf-8?B?NWJ0QVVTYjRBY1Q3QWtqL0ZlTG1lZmtJNjJMU3pKdEUwQy9PbHo1Ujh3K2xv?=
 =?utf-8?B?VUJCODd4WlAySXgzbHNsYVB1N0RJaFR2MmdWamlscElJcmNWTkZhRVQyaVE4?=
 =?utf-8?B?WEJEd1JDa0RCQ0Jud1lHQm54VU1haHBaclJVaDNRQmlPUW5aSkFFaGZJUVZa?=
 =?utf-8?B?VE5vVmRnYjRnTTloMDFKRXFaMEJORTZrNnJtdGp4ZFZMVjJIbTJPR0s2bW9C?=
 =?utf-8?B?TE9Qd2tnWHpXWWJCSi9zNTJOdWF0Mm9PWW5lOFl6TFhRNEJtQ2tibGNERkw4?=
 =?utf-8?B?WW15WElXYkp2TDVrN0QrM2hrMWdLdDFoWE9CY2YwQk9IRnlXSXVuOVg4djdn?=
 =?utf-8?B?RGtQQmQ3UVppYTdFVkw4ZGFKd1RvQkdsV1FyUzhweUxvMDNxYmsxSzc1T0J3?=
 =?utf-8?B?ZUlrM090S0dkeVI4MVcrVzVDblYzcmg1OHVRcEcyZ1diTldQUUJMZ3UySitF?=
 =?utf-8?B?QjZWeUd6TnNYWDRUdllrdm5JVjRoanMyL3p0V2RrYk9RYzhpWkM5ZEovM2ts?=
 =?utf-8?B?dWd6ZzREbnJtZ1VONXJIV2ZjOGlPSnBLZEpRNkJ5dGc2WG9aZUw5QWY1T1pV?=
 =?utf-8?B?VHVSU29MTEFseVVnK25WWFBJRUpXdVkydm9ZS0c3RWhxTEJERFpBaWdQU0hB?=
 =?utf-8?B?aDkrQWtkL3QxUmUxdlZ3ZC9HeCtmSERBSG5YMEQxRGYrNnRhb3cxeFFSUURW?=
 =?utf-8?B?bk9GQkdYVDVvakRDZk5SSWh2bEdGa1VNbGhDYlV1RjUyVFNCU2RwRk1SZnp3?=
 =?utf-8?B?anRhZ2w1UDQvZUJobDVpQVdDOC8xamRsUVNuZVJSZWFBN2duZFV3RlhUR3hE?=
 =?utf-8?B?QjJTMUtkSjc5VG94bmRIT1RxMzJGanI4RTBlN2lUWnNabHlRY1N5QzBTakEv?=
 =?utf-8?B?S0laa3dndkFjZHVKVGtmalgzUmtDeG5DN3JtUFBQQVlQcHZhTklXZTJUcHJr?=
 =?utf-8?B?ME1oc1l3VGliVDFhWm5NRmRHYXpuWExsYzZSRWlVSm9SdWJSejBqNUhjOWtk?=
 =?utf-8?B?cy9acEpGMDdNOEtyY0MwL1M3NGdqZzFua1VNZVFzWEJhWTFxbDU2aEdFbUFx?=
 =?utf-8?B?Y0dWUjFLc2tydHlHUEk4Z0VnMjVXbjh2Y1VKQTc0MUhTbGJ4WGdDelN1RzZF?=
 =?utf-8?B?Z3ZGdC8xOEpDY0pQc0lhTHBYaFpLY1Z2aXRWOVRTMkVsQ0ZpTUlsdW1KclI0?=
 =?utf-8?B?b1g3Q2kyVVhTZkhwRTZBd0dkN2F2djBtaVVaSURmTVpoTW9DWmlCbUZFQ1dq?=
 =?utf-8?B?cS9JK2dkaXVvalNrbElBVmVXdTZkUEgwMUFJQS91TkZmdGt4OVR5QmhXZFBz?=
 =?utf-8?B?WkNpcVpXenJPM0pXTnZla2hZUGtPZ1dCOXFtM29lTGFjZ21TVDFMeCs3TUw3?=
 =?utf-8?B?MmZlcnpSWjBmUWhHcTRuajU2L0dNYytFZ1Z0dUVvWER1a1laa2d5ZXZYczd6?=
 =?utf-8?Q?a9AMvEnSrP0N5SzjN6SWjDW7MTlKOB4B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnFNRkdKU2NQOHNnbVlyUDRxYW1MU0krZUpvekRQOE1yLzBOcjJacm13ejNS?=
 =?utf-8?B?RnZ0aDFTb0xSY00wbDUvTzA0bEFJZXJRbjYvRUg2WlF4azlVNW5XOVNNN2ty?=
 =?utf-8?B?cEFYZVJnN1BEOXNvUGFBZGp4NjZMVlhUVFB6Mzh2a2FIb0VoZTBsN204SXAz?=
 =?utf-8?B?MmZJTS8zZHE2c0hnZGFDMnVXUlBTdWdlb3ltRjBVamxEdkREcFhQMzVWN3dx?=
 =?utf-8?B?aUtUaGQ2MkhITWxnRlFLY3ZJZ21WQ1l5LzhyRHBrdDFvU2FSWUJmK2VScm5T?=
 =?utf-8?B?UEozOXpwOFZ3UWphazR2aTN3eGI4SE5ING9pcEc4bExtUXFWZ1dUUmNZV0lZ?=
 =?utf-8?B?OHNNSzk4VkxNREhDZnQxM0pTNzgxOUpiS3JMSTYvQWdIdDBDRGdDSitCVGE5?=
 =?utf-8?B?N05JR3ZuemcwSjF6ay94eEJYUXh6TEZLVHZlYno3cjI5SFR5empWMzRHS3Jl?=
 =?utf-8?B?T2N6NUNNMUM1Y0VWaGJEemR3WWZ6MSt3MTVtRzlpdjFZOXEwR1c4S2VYZFpR?=
 =?utf-8?B?amhQeDJlblM0dHY3ck9PTzlaSmJTZk1jYnE3ZHpiU05WZHBTYXZTU1pwR0RK?=
 =?utf-8?B?b3VJMzUrSWZqMEpaM0JuK0d1T0ViemhWWUpOL00yZGVwbXBBS0dYTkZ3RTc5?=
 =?utf-8?B?OEo2MlhWSEtJdlF4QzdobG11TEpkOXgxSktoVmxTZmFWRzRzSTdLYWlmcW1y?=
 =?utf-8?B?d0VteWNrMFhCcEowOGJhV3BlcVAzcDRSeEhNWTZkQ2ZScUdJZTdxdDUvYjFn?=
 =?utf-8?B?MW5acW9lM0JHUzc2K3dkdTdQSHBHMW1SR0h4VWFsSzgxV3ZyRlhXMjhSU05R?=
 =?utf-8?B?QlVRdnFNVGJiU1BNT0poVHVuN2o2TzdNOVZQNnZYdFU1M200WkpxNlpkN1FO?=
 =?utf-8?B?SktaSmRsbTE4UlhFYWRpY1Y5L1RRMlZSOEhwQnRzenB5d0pRbDh5WXZTaG52?=
 =?utf-8?B?NStzSG5TTDZBUVhwUGhUbGlyVVlVK1BMS1FiUTNDTjIyelFPVmpYVjl6N3FF?=
 =?utf-8?B?ZE53M1ZFdlNsZk9tRXM5LzJKSlVxcE9qWkJNMWY3aFozVk9OUGRGcFh3dDlx?=
 =?utf-8?B?MFdxb013dmVZV2RBUFZ1VXFvRU5JSWFiVVBwR3lTekx3b2xwRmZyRnp2N3pa?=
 =?utf-8?B?TUF5UHd4azc0d1IzdGlVcUZUNVc0QmpsU0RyNkRXTDdVYTlmUDZIeFhXTVVo?=
 =?utf-8?B?ODVUeXc4cFZOc0F5ekVIWnQ3RVNEUENjNnZzYkNpbzg0VkltMDBvVWFOeTJ2?=
 =?utf-8?B?U1cvVUtRMi85VDhaTWkxSVUxbmNzR3RERWJGeGRCYkdQVmRrU082N1RWMWV1?=
 =?utf-8?B?WDdyRElScUd3SmwxVFlJOStVRTExQ3A5QVBDM3BuQzh2S1ZtNUlndm9BbHdN?=
 =?utf-8?B?bXBKQXlYbDRacVdEcUIrblI5ZGtUUUtkWTlOaVQzTmsyUUFhVmZsS1RIT1Jn?=
 =?utf-8?B?YWhDQXlxclZNdnM3d1QycjR6NDB6QUhBbWkzQU95VUVXSG8wTndBWVF3LzMz?=
 =?utf-8?B?Qk04UStQSklheERRUEhiaW9qWWJMVGd5Vlp3ekpEdC9FSy9kYUFMMGZobC9v?=
 =?utf-8?B?dmozK1VDMUl6TG5lNm5OSzVHWXR3TDA0STNUQmRQclVlYlp4dFBRNmlaTTZ5?=
 =?utf-8?B?MytSNWtPN2pEUkh1TUMvYVhPdjJseXVJM0w1c3dGZU52U0Z1Z3FHcXRVS0xV?=
 =?utf-8?B?QUZtcFBmNnpvUi9sa045UlhOc0dNUU5wMTZiVjJ1Tng3eENaVEpWTGM5VnlY?=
 =?utf-8?B?YlZPYlpFUTI5aTh6K3g5VmU2U2RpVTBGcUF6aEZXc3E1WEJIYmlraVAxSUt1?=
 =?utf-8?B?ZVhFYnZLTTFQVlY5NkQ1Q3M5NHRuaWRESzgvTnV0dEtkZXdCSnFVbEZXNWor?=
 =?utf-8?B?TzA1WEJvcVdnczJYMzE0YWRPTFdPZWlLR2U1TEVQbG53dUl4UnJoSmFxQjNO?=
 =?utf-8?B?UTVLdmRnRUNlenQrNlAvbDBvOXdKWnZ4TmlyRk5BMXlsc1R5UjVFWFhtRUhD?=
 =?utf-8?B?N1RHUHU0RGNVWUphN3FFYUY3ZmIwVW5EM2tWT09qb1YrT3QyV3lOcWE5Z1lL?=
 =?utf-8?B?YnJBejM3T1hIUVJGNHVMM2l2ZndVUURVb1FMQmlqUHQrVExPa29xbW5kS3hu?=
 =?utf-8?B?eWY1ZFpmRzdDWndocUsyZWIzWnZZbnU1YXpWSU9WVytRNU1LdkhLaFVOMWNz?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R41DH42KceLJDVt8xgqRIGGDwX+ZV4Tk7t0JhHEIFDwAF9Nv1txnLXYuXEPz1MNWus+IvzAOW6LCpPg8Yq1SIW6KTSxwkvglkrG0eOoPOgJPUuXY7xJYswFNbKE+jUbTKWcHjHQL8/u86MuaieF4tAu2/o1i0W5BJx6XiptDxFV9BOCLyIePUtTEdrcmPFDQ1brszGDOiwjFHKwk2LhcKxSsKbrzWSEKpjmZ3okN5gpm/Re3kd0XLyR4ibMCztcLEcGnjxr8kQr1p18aXv22Woj/Nyc/bUJLU3MvO86ic+5pncZfE5TxjNDXmTVyng7+HUoDIZpqTNiKXtOY3fbaGkIA4NYbP5sMGJ1FhjhqE0hv026Z+kUMYEVPJTS39rUOVW7Qa/ehqFJagZrHNViM5abAr7zJUbUVc4OM3hMXvkiGcOovRzQ1I0Z2VezwGk5a24Ar7rlpvF0+yk9yB2JorHSy0KjqPvRlffJyr5UV6sl0yRCpFuWUUdNQGcpt0fm622hZWkQdhuCd4xxcCL6vRFVZuvzW9s8Bd3PywiSp4ltD5MRP2VL5ngmIKMIO6+uohn4pEW7lLaNdL8dzBOOFqPTwtRLavuojCaTdFHMAuE0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870c6503-dab4-4dc3-e32c-08de3d97bf34
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 18:11:49.2371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPQJ4P0qTGyDuMBFtjyDj3ctkVUDk7FaCZYbCOWdgC5JCxvNB325j9OhMOf1dIjyxegWumdUAqoaRa18ohJGAz65m0+eO2GobL54ImHyuoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512170144
X-Authority-Analysis: v=2.4 cv=Ot5CCi/t c=1 sm=1 tr=0 ts=6942f26a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=M_yetzAow2RrrQXGnDAA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13654
X-Proofpoint-GUID: UP_Iyt8lJgf-s2lY7UtpSgQcyiT7gDzK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDE0NSBTYWx0ZWRfX5MKv2qpi5OsZ
 4VxV97Q18CL+uBlXQe3fWWUd95d19RfzHGLqmN9fjooElxBXK4cQshC0s91ppXqTENDD4I7493k
 qwyq/H0SFLBeNNsrhmwsY48nOvRQkRfpA/1oA72gEUrtVTzJ1UJY3/UA/J00l6rUHjYPGmNuvOQ
 jSh9TCw5GWXXJXNKBUFV48OfIk2wh1opbZqYndrBsjEaIGmb4nLU9mY7G6QphoHybzRhjVlh3pS
 ytJ8zLeAe+LQ8s8+z85ELpX9zT4vKeYGsWdYStcgVrXnsKwsToQcvX5i0brPErD5GFS6SA/zxI4
 Dc6Q3dzTnodllJfua+FSbcJzwLATVuEcNVeS7zgyrDKimyW1RRf92zHc6RJ+ERw/wxd8xh3Zdx2
 HStbtogLPBxnxKi88sV/cLw8V2lCNy67aEJ3GJ8HIVywNR9J5eI=
X-Proofpoint-ORIG-GUID: UP_Iyt8lJgf-s2lY7UtpSgQcyiT7gDzK

On 12/15/25 7:20 PM, Randy Dunlap wrote:
> 
> 
> On 12/15/25 3:33 PM, Ross Philipson wrote:
>> Add a Kconfig option for compiling in/out the Secure Launch feature.
>> Secure Launch is controlled by a singel boolean on/off.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   arch/x86/Kconfig | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index fa3b616af03a..9404d207c420 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -1975,6 +1975,20 @@ config EFI_RUNTIME_MAP
>>   
>>   	  See also Documentation/ABI/testing/sysfs-firmware-efi-runtime-map.
>>   
>> +config SECURE_LAUNCH
>> +	bool "Secure Launch DRTM support"
>> +	depends on X86_64 && X86_X2APIC && TCG_TIS && TCG_CRB
>> +	select CRYPTO_LIB_SHA1
>> +	select CRYPTO_LIB_SHA256
>> +	help
>> +	  The Secure Launch feature allows a kernel to be launched directly
>> +	  through a vendor neutral DTRM (Dynamic Root of Trust for Measurement)
> 
> 	                           DRTM

Thank you, will fix.
Ross

> 
>> +	  solution, with Intel TXT being one example.  The DRTM establishes an
>> +	  environment where the CPU measures the kernel image, employing the TPM,
>> +	  before starting it. Secure Launch then continues the measurement chain
>> +	  over kernel configuration information and other launch artifacts (e.g.
>> +	  any initramfs image).
>> +
>>   source "kernel/Kconfig.hz"
>>   
>>   config ARCH_SUPPORTS_KEXEC
> 


