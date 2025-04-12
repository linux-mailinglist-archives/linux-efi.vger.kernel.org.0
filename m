Return-Path: <linux-efi+bounces-3310-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF41A86ECD
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 20:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32E447A6E3E
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 18:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A5D215783;
	Sat, 12 Apr 2025 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZodTNxEt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JhS/LRJu"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E78202C5A;
	Sat, 12 Apr 2025 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744482966; cv=fail; b=tGW3y5r5xUbLnf4j9ThigiHIgj+WJ+O2KKbH50+NkUkZcQlQqs1uaawKVTOXRPxCFd6cmWhS33CTb5iKsUOnzJlD6dvStU8Ou70ZICG/5Lj0T0al73+UEvK1GUdNLNePOuvl4FnTkATsJK3m4cE9WL5REIdal4xY2FzQBycq6Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744482966; c=relaxed/simple;
	bh=9DHXxd1Sho+h1Ead1+eLl6tyAlGZppGpBhkXRgcHmbA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XVgOfTl6MmED/FKMkcgl6B5GpXQI01KGTHan+rMhBcUuI3XTxS2qbTtxgdmlxPls4F44Z/cHMXw0zNBQoMb/wNmows6ha0cr67X0+RC8ePQa6IUIgHgJH+fRKvFQziealHVHnwkc2pAIJbfPv4kQvYGHp5RNjYhX3GMCSWPMNik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZodTNxEt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JhS/LRJu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53CINpDi024031;
	Sat, 12 Apr 2025 18:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=nBW8Uhb2ocMhiEZ/Am2fNjOraFGZ+fRAqNK9lamyinQ=; b=
	ZodTNxEtWvoZfN6qsmP7cw3VRiU37/e3UBl9Dkm9GXwyYD7ynxM/5mOcr6oqClbZ
	xSjHnADi8GlAls11aYYtrxH79rgNyE4uQaIEmcr8zf0+IPS7G0/G5h8JY68h7eBF
	zYGmiiJ1QHXhWMGykPzKkPS4lCMGdfuaLOb5IBAeQTvtL6vjgUUpwBey0UXGzzt8
	t6Tnb73uMPgbwuj3JQZy/TeJ8Rn9RRhOYQQ/h1TCRCNs7fXODhsAhUtkRkTayGYf
	+jyDZPo3ddIDX00opZz3SNhoqsJ8tm1NPc+YUtIS63oT/28AdWYiIXijmCb8mtXl
	jsR3CzETaij+8A6moN1tdQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45ywcw807w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Apr 2025 18:35:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53CHMZmh008063;
	Sat, 12 Apr 2025 18:35:08 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010006.outbound.protection.outlook.com [40.93.1.6])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45yem68v5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Apr 2025 18:35:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GY+mikCrA5v7lApGFuPANppq6qhpNEICueFXh6ag8ziJJ+mlN82rN014u/EJkrhUF3zRYX0ZsmGhIqSTuDzv2SMSYaPmzlCtDKEqn0bfL287SljapagOCxWs/xn0KSjW5nyASOxUv2yqQZU5GDXvj5VYUgRPNk/K4k+bIg9vIR04bcVLra8ZIlMZWnpvoaCmAEe6T4VZ6mEnMKfxEvoq1ad3SePRGobCqxU7jSImBngzkjTxPGF820kTMcM/4cbRj9e9Ewwb4/kRIs45QKyvDT7vBic/3eHO1bYAm4ps1ylivoi95H4eDdkeBmYf/Ph/ulptj8xeEuhUO8edF40zyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBW8Uhb2ocMhiEZ/Am2fNjOraFGZ+fRAqNK9lamyinQ=;
 b=GcWuoDQwld+eJTzNZM4DEJn1BO1s8UEKsbebcf1Uk0+L5VycO+XF+YOI6lnzb3CGKEuzOIRpIsLZHaaTx+cQ2pIviPuLOrZm28akCIqozhzVTBt2F9evx3ua5HtYTWn5CZnGq9lsiLa58Wu/VLe78TUbdH/6iBHCQ9bdP8hKrjUZOqTtW96OMN1ZFInCgjjDTwO7G0NIyV6msZqGT1+EiAZegvKwc5P+CNU2UKKm0RKFEf92pmH/ZozsaMNOoVwb0H0lpq7p76beW3nKQ5dFN2vdSWufW8R6RQ4NAuVDuENp7ZVraGw3YHVrLyVuFhlwY+gUSRh1fl/zbe7x/wDBZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBW8Uhb2ocMhiEZ/Am2fNjOraFGZ+fRAqNK9lamyinQ=;
 b=JhS/LRJuCZP9ZIL1iVcUFjp95xRwCTaf6QxPtn01u0G5ricBPSX5okfGV8VdeapLqOYsZFqt4rWFemGkry1szuVsAr+GRwn4Kw9xz8qoUN4mxiVrbekzVFDnQKrAuB597NHTPKda6MVaNpOXx1Vjg/WHebT3KLkuhZ+auJIMF8w=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DM4PR10MB6231.namprd10.prod.outlook.com (2603:10b6:8:8e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Sat, 12 Apr
 2025 18:35:05 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.8632.030; Sat, 12 Apr 2025
 18:35:05 +0000
Message-ID: <0e40a1d6-34d7-4966-bc23-34c0ea15ea29@oracle.com>
Date: Sun, 13 Apr 2025 00:04:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 04/19] x86: Secure Launch main header file
To: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
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
References: <20250410204149.2576104-1-ross.philipson@oracle.com>
 <20250410204149.2576104-5-ross.philipson@oracle.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250410204149.2576104-5-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::15) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DM4PR10MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 2461cfc0-3687-4f5b-6f10-08dd79f0be3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEJ4M24zOVlSR055V0hOKzR6ZnB1cS9vbFVWNHBaNElLbHErZGFycGdtQTE4?=
 =?utf-8?B?QVF4SUhTVDFkT3R6RWpvcFMxOEhzRmRCbmNnL0V5dENycXdHTEdHRTFGOUY4?=
 =?utf-8?B?UnlXVjJDcUx0N2lqb3VlOWszZ3lUSy9laDEwVTF5a1BIcEFPK2tOckw4U1RG?=
 =?utf-8?B?c0VIeSs5OFJMTlB4NGN1VHVqUklESWZSVzVtNThrTmdPQTZ5S0pvTENjT1Iy?=
 =?utf-8?B?SFBUa3pXSHpOaS9nbmg1RXlKWjU4aDR4dmdiM2NvS0hCbTJDSENsQXJHY3hY?=
 =?utf-8?B?UkJtd1NQcVhDMGF3UldjTVQ4ajBPWTNCRnRjdEVacmU4N1FqcTRub3dzVDh3?=
 =?utf-8?B?Y0VsY2lnbUo2U0doTlBrN3V5aEpwbThyU1hkODA5SW9INGtuVHFQR0Y0NTlt?=
 =?utf-8?B?Zmk4b05LdWkxb0VVQmlaK1BPeGFUWXF1T3V3ZDBnL3l2Nmw5YXZjSmY3aGph?=
 =?utf-8?B?VjFFNjJpOG9kN3Bid1NWUlJseTlvUW05OWpnQ0xrK3NLZmk0QzY2REh0MVBt?=
 =?utf-8?B?NGpKYWNCQnRnZU1iWE0rb1VGbzdVVnczWm1JbzUzRmduV3MrYUJ5RlVFdjlx?=
 =?utf-8?B?Uk9oS1FCejl2NnRBYldUTVpDSHRmUXZuV0JFcTl0S2Nnb1V3clFPOU9kQ3A4?=
 =?utf-8?B?eFdhS1NqNFNTNUd2OURIcEFuSytLNHFpK0Z2TFFhVm00WHo2Q1VRSU5oV21q?=
 =?utf-8?B?NHBTZk9zcnJkUHZSakhJcFRaL25ML1JCSjBkUVZsU2NtcVpIVE0yN1lCaExW?=
 =?utf-8?B?NFZQZUZhYVp4cHl6MzRETDdaejdQT2F3QUllb29zamhEOG90aHFISHJpTmY4?=
 =?utf-8?B?TFNUcUQrM0t5Q3A2V0UwRWVlakFDaS96RVJrL0lJT3ltUDZTRTRuT1JESXdO?=
 =?utf-8?B?ejZGRUdtdWtITHNaQnYzSWRheHVGWnlHQmtkYkFCeVlEbHZzNVJHdlVyZW11?=
 =?utf-8?B?WmxJU05TVVpNN2ptOEZMdWE0ZDd3eHM0dXhJKzVmQmRRZHRFSjN3K0IycHNm?=
 =?utf-8?B?VWsrMzlramk1YVJSV3NsZG1tL2tEdlZrN0c1WE44WVE4MnVrQlI0SnNISjI0?=
 =?utf-8?B?MUU5WWhSM2kxOFhxYS9sZmpnaFBwWWZjOWJjaFRTaEYxWVpCbHQ0dHpwKzJN?=
 =?utf-8?B?RzhORnJ0WWxGSXQ5UW5VY1FqaHIwd3VKQlVodGVOeWhrYnZoVmZLOTVYM1dx?=
 =?utf-8?B?SGhVazhVS3ptM24zT2t2T1hmRjVLc1pmMGpmLzQvL0NjdGJmRmNIdlY1ME5q?=
 =?utf-8?B?NWQ0ZzR5WXFza1hubEJVQ0ZGRHViakZsam9qdGJJSlJjcW1pa2UzaXh0dktL?=
 =?utf-8?B?QWw1bnd0R2VwSVIrajBpSnpZMUdGMkZ2RUQ3aE9QQ2pEL1BLT1QwdkVzNTlm?=
 =?utf-8?B?amt3MHMvZzlKdHNuelZwc09ISzVNT2N3UmFTUlBWd1h4bitVWWNLMlVvYTRn?=
 =?utf-8?B?Q01vYkxlN2NCZUo3S2RjZDF1YUp5Y1RiUk5rRHVtMUpNR2hLVWE0SlpKVi9I?=
 =?utf-8?B?cFROZ3BCTUY0YlJqZ0pHYzR6engzY0VUOU9sVnNSVnFCTUpSeldlanFjYXBa?=
 =?utf-8?B?R0JHdkFwM0VJVWZRWGI3bHFWRHdVMXhKMVVoLzRxUU9IR3d6YUJzMWNneDdu?=
 =?utf-8?B?a3dUVDdIeUJkMFBaV0VRREV4OU5YdzE5cjFmTmFvS3ptNVcxbVV3ZjcrN1A0?=
 =?utf-8?B?ZmVZK2lUa2Z6THNyNDdNV2pNYjJrK3o4bFFxTTdlU1pDOXREV3RTTS9CemFm?=
 =?utf-8?B?RnlLaTdWU1ByTjduWG5KUVhGeU0rK1U1cy9LTzdoZFg1NWpETFY0RUh6L2d0?=
 =?utf-8?B?cm5qYmhCU2ttemFKQ21VWjBxNUNWelhMZHRjRXZBZ1Qyb09NWHowY3BHblV0?=
 =?utf-8?B?c3NuWnEvWGtCRW9YR2F5UTBXRGFSU2NYQlNyZzFJdVVPc044L2NPc2NMQWpU?=
 =?utf-8?Q?q28Q/MTq188=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZU5yZzhBa012Wk95RngwUVJ6ZHA2bnNJRjMrVWdVQnl6eU5yK0tKRVJBdDQr?=
 =?utf-8?B?T0I5dFBpQlZwSjF6OWJZRXFhVTFjQlJqeGRaWWRzZFoyaGQ5SkZkeHlmcG10?=
 =?utf-8?B?bVVKSEdEcFdLUkQ1Q250K0dlck5GbTZ5Q1N2YnNZMzg2Q2VnOGVDRVlQMWY5?=
 =?utf-8?B?dVdvQnhrcDMrYnRyUzhiQ1Y4SmZGc1ZyV1Zkdk43azdWb3hXak1CSkVlYkZC?=
 =?utf-8?B?ck5GVHFXLy92djBBTmxOelVQRHVsR2dFWXYvdzQ3cDkvT1I5bEY5VUs2VS85?=
 =?utf-8?B?N1ZxQlJsMXMxV0d0NUUrWmc4QU1Ia1lhWHRwZEJWd0VlRXVTaUlyY3hpS1B5?=
 =?utf-8?B?MHZtcmQ3U3JWVUdjNCtLUVRSaXFRWlI2SkcvNlFVOVQ1MmpRZ3M0bHBheUl1?=
 =?utf-8?B?SWhDZWpBRHpnemE3ckE3cWIyS0dRUDdzYUFtRDZvbzU2TmVaSVZtQlJyR0ZD?=
 =?utf-8?B?QjlrVmhiWGlHSFFrNktGa3c5VjViWlM5blhwbkxJMUF1eXFMSWxJNGkvQUo4?=
 =?utf-8?B?RnE5SkFWZk9UaTNBaE5qZ1BnNVh3NWxvMEkzYlFxaHA4MXR4Umg1TzNMa2xP?=
 =?utf-8?B?VWdhRVdyeUZ1MWlNWU9sczNlU05TQ09WRmx4UEZQT0grTnlxVURSSUQ3a1NF?=
 =?utf-8?B?SC9rRnlvc2xKSnZEbW00S2JJNURZNmNjVWZpMmVyZU1zbE5YOVhhZ083NzZw?=
 =?utf-8?B?WXRLS0JPaWtpejNwTEVMVDIrb0V6UkYyV2NHalh2NnlFMmUyVWV5UklWMS9V?=
 =?utf-8?B?UTFkMkx4eFRrLzBvcCtjV1QvTVhlT21rL0I0YXZ4emxHazQ5UUI2a3NVV3VC?=
 =?utf-8?B?SFdrT01SSkhQbndlUTVnRUQ0VjdZR0NsZXBadXZyK3ZNVWFEVVpuYUpZd1Rr?=
 =?utf-8?B?UmVmb0JsZjA0QnErdG5HU1orTUQ2QXI5aHoyc2tWUjB0cjhyMjlVa0MxVGZE?=
 =?utf-8?B?aGh5QVFwYW5WUUNYNUJobi9rL2FXTTdnZ1VudTB5T3IxaTl6cEZhVld5SVlk?=
 =?utf-8?B?V1VZT3JXSGlDcXdYZjVEZUxKUFo2bENGNmxwVUttZjhUQnFvNmVabldVR1lK?=
 =?utf-8?B?YUk5a216SUI0dmVTT0N4dXRtamJ4Wk42VUROMDFOUXRrcWhKMkg4cFozbjU0?=
 =?utf-8?B?bWRKWkxGa1FMOU9mVDVrL2RmcGhpeE40YjhZWEQzVWxxSEhtMXozMmh1dzhm?=
 =?utf-8?B?b3lqZmthQ0hPKzZJaitGUlVqVGRhb3hwT1FuVi9DQU1iYXI4Zjk0SkEzcXRS?=
 =?utf-8?B?RlpEOUhreWdSNUpxaTNtZWJ1Zyt2ZWpCc2VRUUN0eVJvUVJoSkFWdlJ5S1hy?=
 =?utf-8?B?ODd0cEFoOE5kQjYrYVZ3NjZCc3NNM0t2cnk3bTBZaHRQUkt1V0o2Q2xmQlFW?=
 =?utf-8?B?Mjd2NStOYUxpU3YrTGNaanpwYmNwcWhCNk9mYnEwNnVVTTNVOSt4dDdjdFBV?=
 =?utf-8?B?cTdQemYySEMxOFhXRGFnRzJXbVh6aXc0d3RBMW55WGdPcWVsbk5nb3BPQ05a?=
 =?utf-8?B?TjN0dVNuM2J2bkR3L2tMZ2hSRGxtc1NBdnh6cTJKREtZenVZclBrc09BYUxV?=
 =?utf-8?B?QkI2L2RHdWpQWk4zNEFmd2Q1czBUNEZGcTZycWJ6MW11Y0hvK1VJVjRUOWJU?=
 =?utf-8?B?RUNQWlg5S05HU1hhZHVhcFFldHlBK3kxNEFVWkFHQ2Z6L25tZE9ia2JhbUtO?=
 =?utf-8?B?RVdad09qaUtQY1ExdWxROG5oMkpPWFIzRHh3bVRlUmxYS1VXZ0k3Qm1BMW9s?=
 =?utf-8?B?UjI0ZXBzN29Ka2twd3EybjZ3a1NHcTJINWFjSWZRSWN3SDlFYmFCVGJudmUx?=
 =?utf-8?B?WkY1TWxGVG85czc1ZkYyQmRzbGp0NkFncmZxTXl1N2xoQzE4ZmRVR0RBN01U?=
 =?utf-8?B?NjdWcmNZZWtkZ1N3SVk2R1dydXd3ZGFuT2xNclVFRi9QYWs4OGFhY0NENm9V?=
 =?utf-8?B?aDdHVVBkaVhkelZTanQ1T1BpQ1dyNlhVY2QwUG8ydGtaT0htMjY1Q2dtZlhw?=
 =?utf-8?B?TXoydTFPT0doMmVmcjE2VXNDYnBHSHR4YXQvaXBTdExqbUVpbEtMRDhZZUMz?=
 =?utf-8?B?TitnYkw4NDBJRnpFVkg3NmVtN3VvZTRETUdBTTFJdVE3TXJkdjNBVW5PYW92?=
 =?utf-8?B?dm9ieVBvNVMwQlRPcVBiZGgrd3FKSTNiR1BCbHUzRHJ4cTJ4VWZJQnVlVW0w?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vlj4/KkNGKwiKChNAAMi5/l0AHIxgtTDTsTTF65KeP9yJCeLLWWxJPExKmvIoVwMfm2GKgTxDinP8uDoVkUCNDTOdBwttTEBEm1wvpzHZnycVwe6uXetenT3D1rnhwGQuAw2RE9kvR4unwv9m7goRiujg62l6SAbfU9+MaI1F2cKGFE/Q6+cCEp+q/R5mXTdwMf/LoB+tpQyviu4JZvH0Q1AxdytqXGOwp5iizLsWivspfQO7Bi8JVfv5cLbf0n8dveo6U8gK8ZOTTE1t7Y8byZnitBVgaehx5Ui/w49Y7jIeYwbwRkM+6pVwS+WFs3nC4mpvXWGw3ikUVWysrcHgTSx07C6vPA0A2H3gth96I05enFdq68MaTOcl6LG9RDyyRe0lkKTfUt7djCpYTCIl7cHZbxnyUVhBESHQKLecJpa1ExvAxO2aGFDsyzdnv/06RQA1mVs8l/uyCtL/D7wFqv+e94O9FRZ8ClGsIk04psagSytIQVKnfMjJGJ91HFZVsKjq2BEzcBoRGR2rXkqgozUFUwgeZJQL9JgNFqAg0eh9nt6yjTjiFMX4GsMGh6T1pzjHpBKliMi56TWJ//mVvm7uW4Z11hX+5nFxpiCUdo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2461cfc0-3687-4f5b-6f10-08dd79f0be3e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2025 18:35:05.0988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDstXOEWEDJM3Vf+pojk4p7en5ChyTMZ30aqPJ3l1ooOD/eR8tbGnTlI9HmUH5altVzaFgyrtTQCTXmPGqeKaeV5Sqb7kPuB3zR6I6fePdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_08,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504120142
X-Proofpoint-ORIG-GUID: y3KW4PwEfAqqITchvw9QNgEEz3FIfSkQ
X-Proofpoint-GUID: y3KW4PwEfAqqITchvw9QNgEEz3FIfSkQ



On 11-04-2025 02:11, Ross Philipson wrote:
> Introduce the main Secure Launch header file used in the early SL stub
> and the early setup code.
> 
> This header file contains the following categories:
>   - Secure Launch implementation specific structures and definitions.
>   - Intel TXT architecture specific DRTM structures, definitions and functions
> used by Secure Launch.
>   - DRTM TPM event logging definitions and helper functions.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---


> +#define TXT_HEAP_EXTDATA_TYPE_TPM_EVENT_LOG_PTR		5
> +
> +struct txt_heap_event_log_element {
> +	u64 event_log_phys_addr;
> +} __packed;
> +

can be consistence with PTR

> +#define TXT_HEAP_EXTDATA_TYPE_EVENT_LOG_POINTER2_1	8
> +
> +struct txt_heap_event_log_pointer2_1_element {
> +	u64 phys_addr;
> +	u32 allocated_event_container_size;
> +	u32 first_record_offset;
> +	u32 next_record_offset;
> +} __packed;



> +/*
> + * Find the TPM v2 event log element in the TXT heap. This element contains
> + * the information about the size and location of the DRTM event log. Note
> + * this is a TXT specific structure.
> + *
> + * See:
> + *   Intel Trusted Execution Technology - Measured Launch Environment Developer's Guide - Appendix C.
> + */
> +static inline struct txt_heap_event_log_pointer2_1_element*
> +tpm2_find_log2_1_element(struct txt_os_sinit_data *os_sinit_data)
> +{
> +	struct txt_heap_ext_data_element *ext_elem;
> +
> +	/* The extended element array as at the end of this table */
> +	ext_elem = (struct txt_heap_ext_data_element *)
> +		((u8 *)os_sinit_data + sizeof(struct txt_os_sinit_data));
> +
> +	while (ext_elem->type != TXT_HEAP_EXTDATA_TYPE_END) {
> +		if (ext_elem->type ==
> +		    TXT_HEAP_EXTDATA_TYPE_EVENT_LOG_POINTER2_1) {
> +			return (struct txt_heap_event_log_pointer2_1_element *)
> +				((u8 *)ext_elem +
> +					sizeof(struct txt_heap_ext_data_element));

indentation can be better here

> +		}
> +		ext_elem =
> +			(struct txt_heap_ext_data_element *)
> +			((u8 *)ext_elem + ext_elem->size);
> +	}
> +
> +	return NULL;
> +}
> +
'
'
> +
> +/*
> + * External functions avalailable in mainline kernel.

typo  avalailable -> available

> + */
> +void slaunch_setup_txt(void);
> +void slaunch_fixup_jump_vector(void);
> +u32 slaunch_get_flags(void);
> +struct sl_ap_wake_info *slaunch_get_ap_wake_info(void);
> +struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar);
> +void __noreturn slaunch_txt_reset(void __iomem *txt,
> +					 const char *msg, u64 error);
> +void slaunch_finalize(int do_sexit);
> +
> +static inline bool slaunch_is_txt_launch(void)
> +{
> +	u32 mask =  SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT;

extra ' ' after =

> +
> +	return (slaunch_get_flags() & mask) == mask;
> +}


Thanks,
Alok


