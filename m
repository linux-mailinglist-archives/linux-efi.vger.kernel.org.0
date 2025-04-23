Return-Path: <linux-efi+bounces-3441-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F07DA99925
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 22:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC65E3B7B82
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 20:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC425265609;
	Wed, 23 Apr 2025 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CWu0iT1C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a5M0rp0S"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8CA139566;
	Wed, 23 Apr 2025 20:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745438781; cv=fail; b=kt5T67zmbWB0ByfjeyGd+WUh1jX5Pec+B1Ky3TersSo+4ldCG95QiLD4TbmPWGGMu3muV51bFE4n8U/5Rk5i/J5vqyePKbd4moAWxOV6llRcyYP+Pwc3acmVKz7euvTLVBmEyY/7WSALb+kYxiVfv4NzP2rV7Z7qLjNrv9Tf+MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745438781; c=relaxed/simple;
	bh=nK721j1KaI9P32V06dWrAj+9ZmBCXETbNHI4ehsb7Po=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jpRm8LODI87yZBsOpa7tWofDEMUePbdj96PmE9yNFFt6+S2Lt0ZlrRgKojFxyjQssn4ewaOzq769z92eTYhQ4AGU67mD4ID7Qa/EHOAk5Zh8sfr3Xd6QCUAAsJFJdR2s2uCTA58eHoIdABzpwyjeOp4ZWywQTfg29705fjW6XlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CWu0iT1C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a5M0rp0S; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NJtlbk027841;
	Wed, 23 Apr 2025 20:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Jb1cyTiLpDmWu43ZpAp+oisH4S7oK0lOjZYf07iKhXg=; b=
	CWu0iT1CgyQsmgrpqkEsUpKewUrOpX/adOlM3XmojvJA3sMkmG/0pu+22wnoOlRv
	WZtSOJj/09U5JeVAg+/5wrTtgkiH+LrLGiWWoXQS9hrS1xbk2zurLyCGG5xC7z35
	+5VM4E5WfP/Y6V22r7CkEIy4MBkWQIImURcnTsbT5z2xaucX45CFJJDCu2P8pwXA
	OrtA/IjhKMQ1RNPMyEmGJMZpO6FCjoV7dy5cLL87ZSVcRneSA5FZGIRtAOqSPKWq
	KwT4Z8+5raohtep9u+TSPfw0VA+3s9tImnwUJFNSNEr1zmsGDB9zhfKdkP4lV3kw
	5OSOv43GRjZTZMbpeXE+eA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jha29e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 20:05:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53NJHx4R017344;
	Wed, 23 Apr 2025 20:04:56 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jvfkvc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 20:04:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aY+GJ9Ts/tUZyTDY7/kQUEqLnM3EGaO0BGsYa1VMY3jKPrrtVuIlnSisbanoiXLfvu/ylp9/vV8UAZZrkNZqqre118cpzOVmXDA++ygFRRNDUEgxlu6x2grVXWzjL7pf8Zlo9WYecVAsr/4slR5yL602QmjmTzofC4ieWrMU0DWh6pJAd76ue+3CDokaHDRAIjPONhhjtVnleeBm/tQaoPL7QAAJLFfP96waTp8h8SL/JwLZAeFjjn2veHfq3lqpBObttF1Xkap2Vl95Zd2J1K+xR5tlyzIWINPDqtTABIR6emT3ywhahFtGj5Oh6+r+3pSmucoMmgYIqoyHiXCAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jb1cyTiLpDmWu43ZpAp+oisH4S7oK0lOjZYf07iKhXg=;
 b=BttigrJVHfma6D725AHu4KZ+vAOyzEeyQyy9SZEUG6jWrIIuXr+zo40nENeRpkrrRH1oMNjPeffWe6jQw44OQkzrUaDYBlY4/YkR3lo6lzB4ppQzOOey4FxirhUHKJ1MLwTJgmIddi0hfgeJ8DFiQJ92pwnH451cnQCsFiLMfa1wsIUTLAfBwHVAqWsrzXPwTe9CAyc6jgRZXtSsOsCxC638I0Aji6WIN8BeoBufi5MzC1+MS1FO8V6gn2QJqbMeABqiVgmL7mqkOdngUoMSxDE6JM36/slKDkbU9PlwbfnAYZ6Ew0/izs542CsOziQwpQicAFFRx4VgB/dJb/RtNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jb1cyTiLpDmWu43ZpAp+oisH4S7oK0lOjZYf07iKhXg=;
 b=a5M0rp0SNHegerAcNdjWtPHe2Om5qh1c+q2/v1InMOkNLj8kpIHXMuHHbRvYX/Ct520SxXAyhCIeDUNnWbn2KvcSUigphrXaWpif41PepPQZjJ7VHOqMmy6ruK8ienVU8FRIkwPf2m8PeBgpLv/aLG87ykg58bHcBkIKW3sIgdk=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 DM4PR10MB6814.namprd10.prod.outlook.com (2603:10b6:8:10a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.23; Wed, 23 Apr 2025 20:04:53 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%5]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 20:04:53 +0000
Message-ID: <362d2e07-9781-4c7b-9485-b388f025f6af@oracle.com>
Date: Wed, 23 Apr 2025 13:04:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 03/19] x86: Secure Launch Resource Table header file
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, linux-kernel@vger.kernel.org,
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
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <20250421162712.77452-4-ross.philipson@oracle.com>
 <78f10b6a-cfee-4cd0-b449-ccda84913b48@oracle.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <78f10b6a-cfee-4cd0-b449-ccda84913b48@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0158.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::34) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|DM4PR10MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b843b3f-f80e-4f51-d0ba-08dd82a21c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0NHK2wyTnRIV2xYZzJTK1FtNi9DbkpOaEVLZHlUL1ZLTHJqUWs3dHVqUVov?=
 =?utf-8?B?RnQ1VXhCTVBZTHd0S2xCenIyZjNGODcxaGo2Z0VGWjV4bDdZeGYyYVBrNjZ1?=
 =?utf-8?B?bDR0eFZmcnhTd0RpUDZ3Y2ZzQlREL1ZoK1hQNjF6N016SDZpV2hWMUhCcHJI?=
 =?utf-8?B?azBNNWxQZm9qMy95UWJlSURveTNqRExEQjBPV1d2eWZ1WXQ5QVEwQWMraGN2?=
 =?utf-8?B?SnpDWitBeWZsTXEzUFFGUkhTenFzZ0pEVjBacFBqOVRQNWZDRE8wRTNjYnNP?=
 =?utf-8?B?YkV1SWY2ZDNRalFKa1gxTzBVWnJ1RzY3aWVLeDhxenRzdjVVcUNSaGRnTVI4?=
 =?utf-8?B?MGZYZXJCanhFSXZMa3JJZXJocHZGaGRDVythRzgyVGlvZ2xsUXFjd0tqYS9W?=
 =?utf-8?B?a3d1RXRnZkwydnpINDZWN0YzbmRlbDNKamw3ME9QUDJXWjVUSkhzWGZVZTVx?=
 =?utf-8?B?cFhPdlJzb2tNbjIvdU53WFNIWTdnNjJHRXNyc04venVJN00vZGhuNkRuS0xi?=
 =?utf-8?B?aDVObm1IdldGQTIvQ0JOdm92eXBqZTgza1ZXOXdScmlqNDFNM2xMV255b0po?=
 =?utf-8?B?c1pVWWNpY3p5RnRzT2NIUFR5TXRrRGdSYXNTVXVabG1tNHFkSjdiN0NtU2ZG?=
 =?utf-8?B?ZU16ZEdFbEl6dkxvNnlRNkx0Y3dyMlZtMHZ6VHU5c2hlWG1FbmtpUzdEY0Fs?=
 =?utf-8?B?QzUwRm40RExvaFVJTzk0cTFjQkVGYzJlaUgzTDVSODF4d0U5S0ZwcmZYOCsz?=
 =?utf-8?B?MmUrRnNXeS9lem94dUZFZ2l2OEVBTlhJa3dKc2puVlFDSzFVTFoyU3FWcmlk?=
 =?utf-8?B?eHlUcjhOd1hUMWorTjZNbG9XeXNqcjhBSXBjNkNFK3RQenBtL3VwMHdYZnZC?=
 =?utf-8?B?S3g4c0hsNXNQNVp2M1Y2bkFyZ2ZCUmkyMEUzMGorNjRFbHBObCtPMHh3VUhK?=
 =?utf-8?B?Kzl0Y2t5dmdHZmRBeUxnK3UxdkdvSDlrUnRpbUg3REx5a2hXZmlHQUM4bTBl?=
 =?utf-8?B?NXN5WWUrNTZZc1hlZHdvU2ZUenQzekxTbGJ6QzFhUktWUUhQei80NDBNME9C?=
 =?utf-8?B?QmZpTE5sSUdkb3JER0pIUkNlaUNkS250dVV3cnI1WlUzd00zYklDSnRROExC?=
 =?utf-8?B?QkFhMUhhc2M4SHRIb3Yzci9IenBaRUhPSUw5aS9HZW54Yk5uUUVlRGlvQTBB?=
 =?utf-8?B?cXhNQmVycnpiUVNoQW1BcG5yaTRYeXhDVzFVaDFSRlVseUorL1ZSVXd3bUVX?=
 =?utf-8?B?dmpCWXhHYlBWNXBELzUwZU5GVEZuNjNXRFJiNjhFOTlnSDFYYmQ1VElwNk5M?=
 =?utf-8?B?bGFaQmhDS2dEbkM4SzNMelQ4L3lEcjBnOW1Fd3NLWnkvQUZENWpuMExRQ1VT?=
 =?utf-8?B?aHJhTnZ4dHNHT0xVRThQaGRsVEpkUHE0N2dtSkFTU2wzekxqMXZiNVJJSStu?=
 =?utf-8?B?YkdxdXBHN1RKVlZzajV3TEpJUzFVUFkzMWV5aFczVlM1UkhIZHpIdzY2cVJZ?=
 =?utf-8?B?TDJVQjkyWlVOZm1uZzVPelhSWm52YmZKYWtGYUpuQkpXaE9yckgvNkc3VWwv?=
 =?utf-8?B?Y201WUpCb0szVXg5a0dvdis2VXFHSTNxUDNzcDJlWTcvWDFzdnVlQ3VXbHhj?=
 =?utf-8?B?Y0xlOWtkNjhHYWNreHM2S2Y5WmJSQllZU3pTSWFGUEMzWUF4akgzbjEvcmpT?=
 =?utf-8?B?RG1KMllaVDF1eGQwWXFtN2tXQ3R2TlRrV2grQk1LYXF3b1RraG1TUklKM0xo?=
 =?utf-8?B?ZmtXN0FHcERQcXZPdGVMU1c1ZWRYZnkvMzczTmtUeFlpUVVmaTRLV2creGtD?=
 =?utf-8?B?UXg1NDVMa2RVTlcrTFZISlhZMlhhQ2lyUStaZDBwOFFicjZuZExEVXdlclg4?=
 =?utf-8?B?a0VjMm1FeG54SlhiVjZKVUZ2VU0yeFVSQkt0TERYY2VyYTgydjRhM3J5Yjlt?=
 =?utf-8?Q?CNIRc8C/cPQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1ZYbllpaDRNbEdGV1RuTXpZSUJ1c0I5REF3cGV2YlZveXpkZjFJb1VvYlBj?=
 =?utf-8?B?SUs4UXZTaExjMHlGUmlwYVJtazlaTUxRSjAzcWNaRk9LWnRoVW9Da0V5R2VU?=
 =?utf-8?B?eE1Ec0Vwbk1yOVRHUGVwWlhoS2REUndUWjU1RmlBNXBtR3ZsT2lUem9zV3pR?=
 =?utf-8?B?cTlMQzlOSUZjcUE2eWp3eTk0bkt4Yy9RbkFNQzQ4YmpCMmxmTlJheUM2cWE1?=
 =?utf-8?B?UWwwaXZvV2c5L2pleCtGNlRtTStuVG1JblNUZGF4eFhIYnJuMlpFSXB3WHNC?=
 =?utf-8?B?c1Yra1MxVWxUT3lRd2pXaVVGanpuejBqWnVqY3AydHpudHlQemFNRU11R0dE?=
 =?utf-8?B?Mkt4WVk3YkNuTHR1dVFib0N3eHNRa1N6SFdBN2hydTFOdXV3dmxScU9NUTdy?=
 =?utf-8?B?OG1nZTNiRGJMSnp6TER6Ny9xQkc3WG4zTWVScTZTVHhCVVA0L1M5MmVWMy9z?=
 =?utf-8?B?cmJSeEJpNGFXVzZyYUI0UXFKSHZpU0U4bDVlZlg2RmNudHRNVERPYW52Zm5J?=
 =?utf-8?B?eVdFMDIzTUFkTXp5MnEzVERtL0hkS280U0RUZjRzTjRPVTBzajVaTVl4b3Nz?=
 =?utf-8?B?bGNBZEYyWG5WR3FaNDFIc2FQT0psbTRHWkRqb2ZqcEt2WDlkQUlSWWVRb3hT?=
 =?utf-8?B?UUFKSGN3QXl4Y2ZRbWdLS0JxR3U3UFVTQXZKalFnc0htMjlnQmpaSEQvczBr?=
 =?utf-8?B?MDVZOVZnN2R6SWJ5aCtVdVpTQmFzclJYaWRVQ2cwODFYWmxxZDA4bml3MnV3?=
 =?utf-8?B?Q3UzU3FrRGVwMlRWRm1OSnAwYm5GVm5rZExqTTlLaUJkbGlYdnVtak9KRlRF?=
 =?utf-8?B?WXh6YzI3SmVZZ1QyWmU0MFo5V2U2NmhzR3crM3JPU2xTajVyNng1WUpXT2NB?=
 =?utf-8?B?cFBNb1EycENPVXd1NmpGRmpXdEJXcGlyRUpvZW9pck95RGNZWXVoaWVVM2Jo?=
 =?utf-8?B?dlhISGx0VGprNVRrRVZXeEptRnp0UjNvQTQ1aXZHclYxdTNJalhHR3Bub2lQ?=
 =?utf-8?B?cGhNVC9hQ29pZUt5eVluN2lGMnNNNjlpMmJacjI4NE9Fa0hnbS9jdnFEWlI4?=
 =?utf-8?B?NHBnZUVRdHFWL2NVQ3RTRFR1SmkzTWVOYklYeE1BbTdzU3Z5a25YaFp6cVgw?=
 =?utf-8?B?ekNLaGF6d01vUW1EcjJzMm1sM29yYnlMVkV4ajFDWkVuS0w4Wmp0SHVndDlV?=
 =?utf-8?B?OHJ2MUI1cXNwZWZlazhpalFwWlAvd0ZYLzZ4c2JBNUVEODNxUVJvN3JPUzFQ?=
 =?utf-8?B?aU5lZzRzMjJNYU00cTM5bHZBUitRUEJrWlU2VnRvT3BPUmE3d0dwc2c5NmZr?=
 =?utf-8?B?aDRLZVcybXFndEQvWjhRQUp6U2xrUU1LRkxUa3lsdStnb1BPMWJwQm1BZWd3?=
 =?utf-8?B?WmhjU0lLQTIyc0dPR3Zram9maHBhR0tKaXVwZ3Q3MVg4eEZVR1E4dDkwL0ZZ?=
 =?utf-8?B?bll2OHlJSzRtUUpaV2VkTnptc3BEb3IwVTg1VXltWXFzbm1uUlZxZHB2WGtn?=
 =?utf-8?B?a2QvbkFuQUV3NWw4MEZnWnF1Ly9HUzBQVzl1MkJJdmhPenpjOVpHeGpiUHZI?=
 =?utf-8?B?SUNsVS9HaFNsZFM2Q1RNcnZtb0JRWFFYbHdVNGVKditEL1ZBK1JmSjRCcUox?=
 =?utf-8?B?c2lYMWIxSEVVdDh3K3JpUVBtOFRwN0FrNmYzaGo4NEVLTWhvNHFyMVQzQ1Ns?=
 =?utf-8?B?b2ZsV0xaWVJKNDZLcDloTmRwdEcvWmN0OEF2SVRvcEplNXhERG9CSFFraHpT?=
 =?utf-8?B?amNuRHl5WUUvdUhScFdrWmhUZmU1akVJWU1nRmVUdmE4Q3hkMFB6dXRlMW1D?=
 =?utf-8?B?UG11VGYvT2VhTUdVODhsQjFSREs0eFFPYWdtam1XOGNOWFNla01HRnhDMEc2?=
 =?utf-8?B?UmlkMlhXRXZsanBxMDdYNjhoQ0JvVnR1NEQzWlBYRGIzK0hWVWlROGlqREg3?=
 =?utf-8?B?RHljL1d1c0lqNlZ5b0xqYTEzYzhVUU54T1lmb0w0c29kK0VHWng0VElyVzNL?=
 =?utf-8?B?Vmd5NWRZTFgxQ0lJS2xvQWVNakpDT0Fhd25FQnVucStXamlHMlNZU0Y3Wlhq?=
 =?utf-8?B?QW1xdzRmYno3SHMyakVuRnhmamRPaTlERHVpaGxjMEJna25LenhrOHYxZ3VW?=
 =?utf-8?B?RjE0ZGlSSkdHN2hiWGdwb3RocnhHaGUrM2ROQ2hJbFZHZVlDQkMvZ2Z0bWQ0?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kOj5Fl6xBCNW4nwrMjyi43iiKTaVD3++lWk7pFxRbFm2QCWb1xlBZwAMBenj1ih+Jx/wnwL3CmKJwxmTDRMt4LR7ewaJAZG1dCg2NpKhsAj1tXtZQrNO2dxZiT9ShkKBeCHoqeaqYIm9g9EpE8Nn7b43c4RUAoldHFLqYSobZ+sV7HR0eVTi06Vxi/IS018EdykkxG+3y3cy930/wDMIp9RXWkGizZNXOnnduPVNw2HAjH2GHSAhnsMI2bbZqsikYBexj4eiwEPQrnrky4q7Cx2dyxVzL/K/VltImYXgfXt+WGCXgYdppyCOIZ0eIhkjdAzMdSjHqaC8REO7RHLohZkbXRZkjig3Sc24oZ6Evx2/V9bDqYIOXIgSdPA2AqPf050j/vd8l7Rk1GmsHL1QyqLr588Uhf1GN1EItOcRSHks+XwxDrxyLqrl9PswthkgiRAMAOyTJcrFiO0l5NkISdl4AUNOEYqtFjujRuccNPFVxsaD6LgeXxMiqmc42ODZwG+g6DJx/tWvrdmiEDRieuX89SGLAAyAoZTaT2xXguUoVmzwufMp+lW2x7yw9b17eD0yEL0hakw4J7O4/0g1Mu2OtV/CIkKjtJQyvJGKIzI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b843b3f-f80e-4f51-d0ba-08dd82a21c3f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 20:04:52.9012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQ1YeBUDkXAakbcKS4FxzVAKwrQTmc/yBPcc3QY4xx7GHzOBgXq/kgF0QghsgznDchVVkbS9LADh1xcId97XhBv5x2wTkZmcr5xaQ3mJVHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_11,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504230139
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDEzOSBTYWx0ZWRfX0XEGBn3udMYC 45sUuIwheAAtxgbhby+5mG67SDSm3Qr4/x7X3A/JaSJO0+y56sMEmzkejX+Q1cl6WtdgwDlGCTc S+M9DSKFxwSw2z0Kwo4xXNO2Odwgdb7JqyvGI6oXbsbw6mknAzY/nYaTzrMYNOUzDByff+ovQp1
 TpYAA4/V91of4P4Q2oCBKHKo/qkc4HBtf5J0SkLtF6MXxiN+jdBMesu1PTb9s2XIO7qyhLxVcv6 i6Vyet8+ci3o+rKFdb7NRta3RGM5P4B6o9L8qHMG91j249EbPu/9KdRR7pX/tiE6S0lpcGLZceD 72ne8I2TCoF1+Yo9feoNz40CtB6d+zlGl1nVqr6WOh74IEsGbiVn0fRMo5byUYDlzUlXuW1WlVz JthZ2Lrh
X-Proofpoint-GUID: muNGLSbNDEN0EHuaohXSoIdfzJQVU_-i
X-Proofpoint-ORIG-GUID: muNGLSbNDEN0EHuaohXSoIdfzJQVU_-i

On 4/23/25 11:23 AM, ALOK TIWARI wrote:
> 
> 
> On 21-04-2025 21:56, Ross Philipson wrote:
>> +static inline int
>> +slr_add_entry(struct slr_table *table,
>> +          struct slr_entry_hdr *entry)
>> +{
>> +    struct slr_entry_hdr *end;
>> +
>> +    if ((table->size + entry->size) > table->max_size)
>> +        return -1;
>> +
>> +    memcpy((u8 *)table + table->size - sizeof(*end), entry, entry- 
>> >size);
>> +    table->size += entry->size;
>> +
>> +    end  = (struct slr_entry_hdr *)((u8 *)table + table->size - 
>> sizeof(*end));
> 
> remove extra ' ' before =

Ack thanks

> 
>> +    end->tag = SLR_ENTRY_END;
>> +    end->size = sizeof(*end);
>> +
>> +    return 0;
> 
> 
> Thanks,
> Alok


