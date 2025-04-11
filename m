Return-Path: <linux-efi+bounces-3298-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4046BA86687
	for <lists+linux-efi@lfdr.de>; Fri, 11 Apr 2025 21:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F8C9A51A0
	for <lists+linux-efi@lfdr.de>; Fri, 11 Apr 2025 19:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB56280CD9;
	Fri, 11 Apr 2025 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IzvJ7jl7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eUCb/zPB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D96C278E78;
	Fri, 11 Apr 2025 19:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744400542; cv=fail; b=E4vUbhP6uTq/l9EKNrW+mdCBM0fQGcDDvbgkvT1c5culsqQMadJCREFcUN8IMJC+20GaqK3DwSbJ4MO4CbH/NjfIxVSGWsqdevgHg4M3q64Ei0rQyf1o/H0jSGfoVrXwl8br2vRnqMC8Wy4Grklv3EZRYj4Pa3BOOiCIsXyWk6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744400542; c=relaxed/simple;
	bh=xD7fjeuWshAEGKAZ2gz6gf/AJmSrBVLyaTG/Pg2aNuo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qR9qcn4rEz2umx/CtYfbkY2pbxvsESJbMCsE98quZ1GtORjX5Ig1SHup9Fjw37xkfMDlm6aInuiZUXUlHDLw1D0o9B2/Izygc0N+3k38RLGhmCa4DgVQ7gu0UqHw9tLuDPeqNT9XE4aKAH3xr91xG87pKKQ80uwlv1rxZy/UcJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IzvJ7jl7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eUCb/zPB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BJGgKA006144;
	Fri, 11 Apr 2025 19:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9TbUPw3xFjBCmbFp+oGeNx2lCK0QnZ1/KAz/fvDN8ts=; b=
	IzvJ7jl7g9KrvxUAc6vytym8yvlBaOziQWT+aG1nKA9hB4xPxwcK4Zew5UZuzEo6
	2qrk6iNrtjd8Ju3QFFM0WzQBKHE68kNm0tX7FL1AVo2sQ+Bl5M1TDY2j4/9w93pe
	PHx7IV+rVIo2Og4ZmG08t4fIpN+fHB8aWMlS6RdF2O0qrLIl9RojJfXvSL5slA7t
	gmmOMmPs/ySbx1JGDSZrI8cSGdyXNpcbJ7fIg68tYQf1M1fHboWkubQJyi7ZVMiU
	qMnYM3HCxnmQmKlvCkTpXjqc+xhh2WlQGo5GvczhY0jceoNLBv0NoKm96KAhF3xe
	+i+TxfHF3hUEqDC7jTniZA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45y93m81dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 19:41:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53BJ0KOa016476;
	Fri, 11 Apr 2025 19:41:30 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010000.outbound.protection.outlook.com [40.93.13.0])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttye2xes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 19:41:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqoLfC/IyUq0kRdkP45tNAvoavybKE8iCgXxH/lR7T/JAecKT7DS+CzjQffUtbOx1a1nGo+oWbfvFtJs2hGtJlX6rdHhE8ZPNPYS31oAKsGQQCJECl7+SDBiw9xRx5EI3jKJs9LG+eM8Qed0n1f9mwvaTw5xkg0omFY7d+YJyCQo0TIVpESddbR4behvmQxdIeqk8zZPAClCg0lIzyeS2/J40YfIfl5sop+wMiZpzjBZ1WNL/W7Y6uCiyPVs25vTvBZGi/thUvel6keOLCntDe7faQBPYhGOnZt12HZOgakv6ixkyLX7if7ZYA+4MMZAaiz6uFTmq4/LbFFFfRo2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TbUPw3xFjBCmbFp+oGeNx2lCK0QnZ1/KAz/fvDN8ts=;
 b=YKxm3L0YImUH8k4eIC7lZFBJNmULKL4nEW10+eetX+ntaMN6BDzt7k2ia9YOe2+VBt8WJpc36qX1vQRWiF2NDvs/5I4K+6vRY9bpKxjOIweLpWtOOqIYOqGqDhQVtqNYLL/Elh4acJyvlwbZ9xvcMmNBdawEWl5/5NJplAIKhZeASsZmCZtcFbe+BgeFS0RUeGySJU6VYhdFNEHIObzv0VdEAi9SE1kkfpwfJbMDbfwwRpM1fbZ5hotXaYhhRVmbuftBRjiMi+a5TrsKEEL9RJE0GGT65BuAXl0Q/2TIidQNccFcYWd1jpRl249xsUbW0IOj+qvK0cQM2GzVv4nTgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TbUPw3xFjBCmbFp+oGeNx2lCK0QnZ1/KAz/fvDN8ts=;
 b=eUCb/zPBl155p5ZEa2xkT9BhS0rGtIAeGzgRK+trgKDY5KvUNR7m1eODbfXfVMmVFOBiRHqDj03NVprY680b4nYjVjbY5gK5ea7Hphwvs8U6U1qI8V4PvenhkmmKDwR3emKvS3sZKy7PmNe+1ufEU4gvngaW08ihcb5Immlz5/M=
Received: from CY8PR10MB7218.namprd10.prod.outlook.com (2603:10b6:930:76::22)
 by DM3PPF97BE3526C.namprd10.prod.outlook.com (2603:10b6:f:fc00::c38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 19:41:27 +0000
Received: from CY8PR10MB7218.namprd10.prod.outlook.com
 ([fe80::3bfd:d89c:954f:747f]) by CY8PR10MB7218.namprd10.prod.outlook.com
 ([fe80::3bfd:d89c:954f:747f%6]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 19:41:27 +0000
Message-ID: <b06b187a-54e2-460e-8fc5-b440184b6f7a@oracle.com>
Date: Fri, 11 Apr 2025 12:41:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 01/19] Documentation/x86: Secure Launch kernel
 documentation
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
References: <20250410204149.2576104-1-ross.philipson@oracle.com>
 <20250410204149.2576104-2-ross.philipson@oracle.com>
 <f816c36c-cb7e-4143-b58c-f96a40699f7a@oracle.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <f816c36c-cb7e-4143-b58c-f96a40699f7a@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0090.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::13) To CY8PR10MB7218.namprd10.prod.outlook.com
 (2603:10b6:930:76::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7218:EE_|DM3PPF97BE3526C:EE_
X-MS-Office365-Filtering-Correlation-Id: e6bab464-3291-4218-ca25-08dd7930d971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzRKU2NqdjlPOWV0K3UxamJzajZCMTVYZ3ljV3VVTk96MzhXRExzSkhFQ2xK?=
 =?utf-8?B?a3AzTWt1S3F1b2ppNXcxaElOWEorbm0vYkJoTUxlSHBEOWhYQ2w5YXZ0a3Nh?=
 =?utf-8?B?ODMrTmp3eVRuaFY1dmpaK05ZYTcvOTlLTCtERzd4MWRtWlB2MmJ4cFQ5R1Bk?=
 =?utf-8?B?QVVlV1drWW1qMEdtS2JZZUdsdUZ3enFTVHhJbGR5TDJPQ3lnVld0Q1YreElr?=
 =?utf-8?B?dFZhNU02cTNramVHMktKcUNlTnlCaEtVcFdOdkMwNlBrQklwc0lZU09qcGlK?=
 =?utf-8?B?VWNUcEY4VDZndnZNRnlpWE9FdEhXSVEzclZzV3JrZVoza2pUajJNR3AwU1Br?=
 =?utf-8?B?RWMvcVNqM3lIemIrejhsdEk1SStrOGtFNjVvc2FKeC9acVdNYVZWazdpNCtW?=
 =?utf-8?B?d0QxaC9zT3FieGltZm1ha2hLZFlUYk1KQi9VYWo0cUxDbEp4amR1Q1M2S1ha?=
 =?utf-8?B?NGczTkdENkZ4Zm1CeEREN3pzUGlmVkNRUVBWNmoxZWhmd3dJQkY5ZFVpVVZ6?=
 =?utf-8?B?c0xpZDJpNE1NMXl0ajd1Zlo5WEU0bzQ2bTFHSTlsUHZvZ0tia3V3TnE2UW9p?=
 =?utf-8?B?RnNOeTJnWlpIWWxCczZqSW04QU9Sd29oNWZoM3NtVHg3Qks5V0E0bmsyQy9p?=
 =?utf-8?B?UC9Gbk5pTTVocUxMRFpCRjM1VlFmcnN6T1Racm1VaWJITzhMNGlvM21tWXRY?=
 =?utf-8?B?TlVCaWYvUW5OdCtyM3h0QmIvUUxTYzIwOEhndURvazFlNTdPc053aFpQTE11?=
 =?utf-8?B?YWhjYS9Mc0ErMG55WW1QTVBKMzJreSsrY0tFQzF6eFh3RTc2cGM2ZjcyQ2Fo?=
 =?utf-8?B?d25JUG15NzJndEFCSjZXWlBmaEtNYzB6R3hNVURhRVAxbXZLcEtTcHJZZEF0?=
 =?utf-8?B?Vm5GQWlPYVpGeElFYkRYZDdhUUh6V1dlNFgzbzN5ejhSSDVvVUlnbjJiVDFT?=
 =?utf-8?B?UjNTWXZORnpLTHJpcTJZQ1dscFRwb0w3RzVQcG51TUpIaFJVUEJPcldtMG9m?=
 =?utf-8?B?dFdxb3NlUkhYbytlZGF5TjkyWjBtSFpVUUV5UUIrM3JGNDZ0ZWZ2TlBKTmdI?=
 =?utf-8?B?K0wxSkYrZXltMytLc1hsb0l4MDl5MEdIZHMyTy81c2ExTmRqVFJrTUt3VnJU?=
 =?utf-8?B?enFMcThEK3J2RGg3ajZPMlpUaWpFbnREZjZyWHVsVTIxOUJMUWgzS0k1eE1G?=
 =?utf-8?B?L2R1MFREK3pBZFdOemdJSzNIOUg4TXNrNVlncGJ6UWg2LzRONlQ5UUtIbUtx?=
 =?utf-8?B?dUJ5Z2xORG1IeHFJQldOaEJuNjg0OXNlS3ZVbEFlUHZOKzlRTXZrOWljL20x?=
 =?utf-8?B?M3lBTE9jSXFMazdEdEFWNW9OWEZqNDdjM2MrbzlRaXNGeFFTMWptTStIYm8v?=
 =?utf-8?B?eG0xU0dEeEpaMzIvS3JHc2Q0Kyt2ejQwQWxtNzVWTWhoenNpUy9ETm9BZllD?=
 =?utf-8?B?bzBpS0loR2doQURpYU85bmpLMEZoaC9zNXhJNElWUW1tbitDSE0rckpLc3ZJ?=
 =?utf-8?B?a3A3WnpBR2JVNE5CVUJoS29OTmZDcTYzVHhwSlZNcHJUYzF4Z3VlVnFPT3lw?=
 =?utf-8?B?VjBKTDRsUFJMTm5lVlg2MDZMWVhHMFBQTmFzSThya1pjSnczdzNjU3BCOE5G?=
 =?utf-8?B?RElQaWNRQVhjRlM2ZUJzWFpMNjZEUnJrNy91VEQvOUhqdE1vSjMvTEI0a1lS?=
 =?utf-8?B?Vzd2eHhYU0l3KzJBRS9OUm9kbko4bGs5bXR5RmxQNlRFbHhPVTFnaTlWTi9P?=
 =?utf-8?B?b2xESVVGc21tbVRYb1BPSTFrdFVqYi9Nd1RmSmNUUWxFclNZMTFOWXc5UUts?=
 =?utf-8?B?VEVXRXhyTnBSTm90V1JhdGRPa0lSS3owOVN1T0NHY2I3SmJyNjFvTDRneDkw?=
 =?utf-8?B?Q1VQRE9wQ3R0bTZSSFFuYnJxZVJlWk45Nm5QWW45bW9RYkVyYkhobnFzLzhW?=
 =?utf-8?Q?ReInuKTvUMQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0pLaThBeC8zUVJXTUZWWGdlaGhRNWNtd0J1RncvSlQ1UUlvOWMvcWk0UHl1?=
 =?utf-8?B?K3oyZW1FNzNpUFkwR0ZlSU1zMVdHWFd4Y0NJVlBkNDd3WTk3OWQyeU1LbzRP?=
 =?utf-8?B?UEFoS1BCSExzc1ZZRHFXY3NyUEsxL3BnWFdIV2tZeUNpczM3dVBNalBienp3?=
 =?utf-8?B?ZVdnOG9ReURZMWk5NVZnUEY3TXVFeDZDcEhVa2NCU0VlRWpwb1dUVlM4c2dZ?=
 =?utf-8?B?TjVpNXhqcDlFbXY1RHVZclk0SjZ1VnhzekQxMC9oczVsR1F6eWFmQWN3WXZH?=
 =?utf-8?B?QWZBZkhBTzNPdHBoMFZQKzRBR2granFBMDM1aXZ4dEF1Y2NtdUlBbmxXVzRt?=
 =?utf-8?B?Zjk3M2xwMlVKM2pLMnZGZlk3dVpQeThabW1tcVBEVVJVNzNPZW9nOUFrOER6?=
 =?utf-8?B?MXV3eDB4NFZiM2ZOcFVCbDBrQ3dJcFc1MFFzZDdQdk96b3VxdXVuU1pML2JK?=
 =?utf-8?B?aFREenI4a1UrR3FpblVNeXNmRW1MS0NFa1RRaHR4aWRiYUVJT1czN3J5NmU4?=
 =?utf-8?B?MzBINEVjSEQ0aWF2UEdBd0sxZ1RKWVVMMzZFSzY0cFJVRHdJcXg4MEpYaDRl?=
 =?utf-8?B?VU5Yd3FNY1YzM3BneCtVaGgzQ3RHWFdhZzFUa2x5dFE2TFkveFRadTc5a2Fa?=
 =?utf-8?B?MnFhZDU4Mlc4Y3NJSE9WTkZpeW5CbU5ydXU1MWdSeTFGb3JoWVhKV3dNNHNV?=
 =?utf-8?B?WDFkYjJRL2xMVWpIMndLWUlKTjMwcm0zcnFabVZTSUkyK283eVcvMXJpRDR6?=
 =?utf-8?B?aVpNeklQcDZ3Q2M5bW5hOXh1R21hcGZOUlA1M25RTGxFRFd6OWZzeE9SNHV1?=
 =?utf-8?B?R1B1YXBjMzMwVDFhcTVTbllkMmprUU1FTm5KMUR2UUFtWCtPTTVFb1pSS0tY?=
 =?utf-8?B?WUNjaEZOK1IwaXM2ajVHek96S0t6eVoxUWg5N2dxWk5tZmt4eGsyWUtYVEVo?=
 =?utf-8?B?ajFoYUNnSUUrekJVb2dSTWpjbzJtbzRNZ3ZneFNqeHdTbWttYTJvQWZoSXRO?=
 =?utf-8?B?UTlSUXJua044Y0hOdFZ5SXdWUmNkOCtnR3NFR1NiRHBBTW5ERVBtTDFYRVFl?=
 =?utf-8?B?QlZVUlJiRmNhSlo0Q2xQWFZ6M05FL0NXRDg4ZkxuM0R6bU5lbDFqdmxnc0I5?=
 =?utf-8?B?OHpJOExwZGZsTEFMQ2h3NU9oczhzaUhLTUJmRzR3bXYvY0JUL2tTeXpzV1lJ?=
 =?utf-8?B?SWNQK3dtdE41dGhndzQvKzhKR3J1TFc3T2hpQ0xJbEo3d3ZTeW9nZGtHM0pK?=
 =?utf-8?B?ZmFHL2Z6L2N6dTFTU2FEQlBRejZ3cURMbnRQT3dsSElXSW90dkdFdTV3WHYy?=
 =?utf-8?B?bFpteGFFTS9sWUJFVVRIVE84dk1xM3BZbWo0UzRERGxVUzdlSUZjU1p5T0ZO?=
 =?utf-8?B?alo5ZDUrdVUxdmNvY1lvNkhNL0FpcnF5d0xZUXlpYVVYYWlXM2VWUktYSzRE?=
 =?utf-8?B?QWxuTzBkUG5OTlhCNFVQTGhVVHIxWUdoVzlEOXYvN3B2U3VveWV1bDF3Nlc2?=
 =?utf-8?B?MDZVUUNvQjZIZHMxSk1mdm9KY3JzY3g3c3VML2dmZkRadm5pZzNaZjdhNlFh?=
 =?utf-8?B?S3VWUEZkSWpzK2hjZTkxMDg1TE8xeEJibm5JM000T09RUmJKMWpacWxHVU9t?=
 =?utf-8?B?LzgzTWRyR0NPR3o4SU1WaDkzWjJVRnJaeEZmNEk2ZzRzWnhkSzVaaTBBYkVU?=
 =?utf-8?B?UTFkazlGQXJQYXcxQ2tMUEFuY2RQYWJLSnZZNzJtdXJTWnlWVXNFKzVzL2Vn?=
 =?utf-8?B?R0kydy9LWTAySGtxb0x5d0RvQlBhaFhGdGc3T1VkRHYvWXdUdmNrK0VuTFdL?=
 =?utf-8?B?VUZtQnJLRTBvVnpGMml4NzdBWmpZOTg2ci9ZNE1Cek8vS3lZTmFhemladXY4?=
 =?utf-8?B?NUJIOG1TbUM5VVE4S3Ivdnd6dmMxNk9tVjh4cml2ZGZ5WTZQRTk4aGxDSTht?=
 =?utf-8?B?Nk1HakdvNC94V2Y0OC9kMXhuc25jTlNLOHFNM3F2TjlLZGMwOHB4RG5FZ2VK?=
 =?utf-8?B?dkl2ZkdCMWRWeEJUQm1HL0FidmJQRGh0OHd5bDdMTjZoVXZidDZBbFlVYjFQ?=
 =?utf-8?B?SFpZMHVqWTRKUlhodnN1NFpSVkhvSU9oZHgzNHlCTEpyRXdvZkVDYVhtcGR2?=
 =?utf-8?B?TDhwNkxGb2xsVkJSTlZBQk9YR0d4Y3lKbFBlQmd0Z1JCZ1RCN3NNTjBWNGVT?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D8iYJpdKWA8ZU1gSPOfkyGgnXjZ6iIaWYKEcA7zNJLPOVns1/xRw3V5bnlVk/mJthZBARmv7ihmnXDaXI7yMAvRuEoXOFe4XfrRPqnHY/ZjpEwYTfoU7fqaapzKLwtwmuOzmZ2llnfI/PFe8dGIsRGxv1vfD5cBjHLQ2f4KPyDWEryvzD6laoLjeN6DYXeSshY562+lQWqXm0N+i7uotsNjlGhwUJN9HkJdXPh4e1wuasof25lXwA328VxgGDCp3YhJ/YZNbyg2TtICO0ATv9Y76VOFaZcMustQgTPTYcs1NbK7b2c+wWvKPcB8P5JgneTZNONOE6p2U2vZ2MC8pXzmk819qqicVrcRu7N/1UqSHnG7aADfPe+mF4y6u+ZIoSk6CLGP4gGiTMHlZhwgakltyW/bCET79AQFjmw0qsUEtz3ydY4E1Ds+B1nwngFCHjM7RarmZVac5dbKhebltmvnJdOFx5VcFZxcsL7Lzengc7wGOnBWFO2JTSzfQ3haFWH1oKST7F186dE5TqVE7TB/Ge754lNcpgMSIEUemfzeyKgs+ZkZbcJLkQMrc8PgZ2HKRXUwfvbmtIFnZmxflhKGx3sPQGUQMNDnufnfRy8Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bab464-3291-4218-ca25-08dd7930d971
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 19:41:27.2181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBVG9ukJYQvVTDQqo+c5FD/dFs7eXLR+NuoT8tGH+JKuiKr6YQcO0TPpnSmpn+PLouAcKTxCbSJa7pda6qEEqVyjRJlfUDNHL4xzWmOSTkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF97BE3526C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504110125
X-Proofpoint-GUID: 2z1IZ_NURtlyjEr8E5uML-652ysVJ18C
X-Proofpoint-ORIG-GUID: 2z1IZ_NURtlyjEr8E5uML-652ysVJ18C

On 4/10/25 10:50 PM, ALOK TIWARI wrote:
> 
> 
> On 11-04-2025 02:11, Ross Philipson wrote:
>> +
>> + - Entry from the dynamic launch jumps to the SL stub.
>> + - SL stub fixes up the world on the BSP.
>> + - For TXT, SL stub wakes the APs, fixes up their worlds.
>> + - For TXT, APs are left halted using MONITOR/MWAIT intructions.
> 
> typo intructions -> instruction

Thanks for the review. They are two separate instructions so is this 
really incorrect?

Thanks
Ross

>> + - SL stub jumps to startup_32.
>> + - SL main does validation of buffers and memory locations. It sets
>> +   the boot parameter loadflag value SLAUNCH_FLAG to inform the main
>> +   kernel that a Secure Launch was done.
>> + - SL main locates the TPM event log and writes the measurements of
> 
> Thanks,
> Alok


