Return-Path: <linux-efi+bounces-2925-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFD2A5718D
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 20:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCFA7188C8D0
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 19:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6388524113D;
	Fri,  7 Mar 2025 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RoIK+oSG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h3Eocd8l"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3351746426;
	Fri,  7 Mar 2025 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741375386; cv=fail; b=BjnHHY5anX9fbyA+MnNaUKURg414itdeKNz1DEPZnr/0S0paRVGBKsuM4Yz4urSsFntAq/EglujnhvQYktX9fB4BHdb2dce8dVbTP9zR0Pn8pfzSUrA2dwNoK5h6FzqZWz5OcGcAGRzaO3XBwTHmf/J3Q5eI6LIOFIIHOizOH8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741375386; c=relaxed/simple;
	bh=cQmvn+jYdQt8l1TvNQuG6NTDEOWagleBRczxF6+BV1M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VXviNJt8w069dbjynfWcxq7N7vBeYzNShj5MwdBuJEVlka10z1c8ztgNLnOk6yK6hV9lxyTLLPjWAzP50qusvUpGnaH5qhByBN8G2tJWYA6hm6jPzt36wto4eP4mfJC2e6P0v3nHeQdmQthmVUbprKUpjXOnQIm/aYDOZ+LNU3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RoIK+oSG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h3Eocd8l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527ItfZr017816;
	Fri, 7 Mar 2025 19:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0ybAfd8bIBisnMu4hOe2GBD6r8ZO11aAXUD4YHxbpNE=; b=
	RoIK+oSGwKSGMoY3msiMzQQqV1pjHbWtvuSf89tFSwl5jmf7pdS/yu1lhK/UtYGe
	IrYLsQEvzl0OFupNlzU+AhEQDq90J5QBGV1N2hVVEkKubGdG/cvJjhrN/gEqAPhh
	sSa5m7l09/1B4LgX88k/9lyPHUu1pChM/Pg1Ubjzu4SEnWmL4zakFZzQl+lnInPe
	7PrFX/Qh4kJhufdnx6EVrLATVASeJsXINK4e8oNtVPeXcys+IAEp5wKk2tNs2FEU
	gBI7GBonE5EoVA/rMFlOPpeX418yffO5iOIHTsUYGZExtIzGtn1CFC+PkfN33PPE
	HxZ07qWfkHUTzZrt/wPumg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8wvqxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 19:22:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527Ij8Tt022504;
	Fri, 7 Mar 2025 19:22:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rx0vd6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 19:22:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfXO4i9BXzyDmJbWnlN1r9wypz+E4HMwmXdGD9P9L+dXaqCkcyLC6Z8herLqpD6i+cBo9GaUNW2jh4xKC+1wo5rE1ZOTK8FKe0oAlWUIjauB9En/5zETm0qKCFe/KuFwakrLmNVTzn39cp6/58AUh0byLxTemL1czudrm0TjmYTGNIdkxDAHkM6aVdqTbLdfdqXJNxNSLK7XTYxc28JKqa2Kw+zyHmnyZjyWSzQuz5f6eUZAJRvIsZAEZGBP4vhJxxZv2ByB5S6BsR5RSurKX44SKLZEH/yX+Sbc/4CM8GLVq68iJNscN8VrP4RIZ+GvKcm+y+TJwzDV1Hhg0bxRog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ybAfd8bIBisnMu4hOe2GBD6r8ZO11aAXUD4YHxbpNE=;
 b=Ju4aJh4l6UVgBtfpUfC02n21p/KRtRRicEajEZeRYSHYMjDm96/rKprV5cK96QA9uTZ4nTzNnE1vq4JslGk/CePWYuOzb9YEQpX92E+Rz6BNAiTbncen3r32szoIVqE1IhmOslFP0+va2jy7Wb6pZYaKEwI4XFmu0Zu60f9GPOQZ+79Xw6Rep/X4c1NQlaOWWbfi9MwBhfoW/3xWMd/HOzznKsUL3+snBWrZmGOO4H9AHngNfvFiq0PCun0Wr5qtp7RBmd57xdrqeTSFut4rH30bi/MjAI8pgaxQCLITkAhRPtOmTbysny+weEYPGrZbONu7z5F/RdDOWsIHiOHulQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ybAfd8bIBisnMu4hOe2GBD6r8ZO11aAXUD4YHxbpNE=;
 b=h3Eocd8lTfqa0q/RodAVN/TVEh/tFVU6gMCeRNTrnL2mXM1CMrlcP1F9Ayt5pHLFC8dNtHc0LSQz5h3WrwCUgAXvmHLbf68xQPG+JYi2h2LYZcGIVLdmChonwEwEivioiIHvOd1f+t4hqtrXNbF9KxzuCw4iLhOS3BB+ApbIVIM=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 LV3PR10MB7844.namprd10.prod.outlook.com (2603:10b6:408:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Fri, 7 Mar
 2025 19:22:05 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 19:22:05 +0000
Message-ID: <de143ab2-44b3-4609-a575-63c47d99ea09@oracle.com>
Date: Fri, 7 Mar 2025 11:22:02 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 03/19] x86: Secure Launch Resource Table header file
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        luto@amacapital.net, nivedita@alum.mit.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-4-ross.philipson@oracle.com>
 <Z8qE1B47InxE7n-v@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <Z8qE1B47InxE7n-v@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::24) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|LV3PR10MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: e87c23c5-5545-4c0a-bd2f-08dd5dad589d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTVkRU5IUENXYTFnL0F6cjBxMDMwVlNBUEh3T0xsR0ZzcFpGREFYWHo5dE1j?=
 =?utf-8?B?QjF6bkpVL2M2aVprMk5rUEVBWGkrbTd6Znp0MStWOWY3WVJkU0lHSEVKZWcx?=
 =?utf-8?B?RFlKRzRUcDJxbkZCUUV2aEprS0R5b1hrTkY5Y05kOVREUkpQVW43VmZrTk03?=
 =?utf-8?B?V2k0NTNOTTNPR1R4VzdNdnRFdDdwczVPZXNWWXVxVHBxeGJTOTRZY2Zndk1G?=
 =?utf-8?B?bXJXM05FanVxck5VQzVnK3I4M0JUSmNqODhzbkNpVzhxaDk5cUxBS1h3ZEJq?=
 =?utf-8?B?QlFaU0lRVWdVaElteExLQUZlS1h6dUQ1V2ZldG1aUXJVRDY3Nm1VdlU1Kzkz?=
 =?utf-8?B?MWZTYS9sc0JhNC9PTjdSN2h5TVRORExJMUxINC9DQnZtY3lYUVZXSno4USth?=
 =?utf-8?B?d1RjVlpHTmxnaWNzS1g1U2JEeU0xR3VtZFk5dlIwZVF3aGN4b3hBQVB3Tmtz?=
 =?utf-8?B?WDVFNTZ2OCtVY3JqSG5GdFh3SXhIZzNTU0Z3VzJxSlJtOHBaVy9NVkF1c1Nw?=
 =?utf-8?B?VG8vNmlUM0s4NzcxMHllZ0NVbVc2c0xmSjRSclNEaEo4SmFJU2s0SjFmenB2?=
 =?utf-8?B?ZEYwa2N3T0V4bVo2SkpHSW8yb0JPOHg0N3U2RmphT21VTXNDVkMzZWRWckdT?=
 =?utf-8?B?V2lJOGtaM1Z3dGU0WUdFTmNVLzVweHBWVkFDMFJyUElMR3VYTC9tZDRHSHdx?=
 =?utf-8?B?ZFE5Q0NnbjQ4QzhYMDV2dVhRWUdHVG1NSm9xbTZoTC9oY2hQcDhycXVocUpp?=
 =?utf-8?B?VGpuaWRUSDVkL2hVamFLWkk2UktpSDA0UVFHQmhzMHBvM2VVY3lpK2FLejIz?=
 =?utf-8?B?eXR3amFXMXA1cFJIT3NjYmg5T1N3SE9semZJMERVZzBrRHN6R3c3VmRaWm53?=
 =?utf-8?B?MytyQ3BubGVtMGVQU0xLS0ZldG8zdVpSL0VsWStDeVN4N0NEc2F1MXhnQU9r?=
 =?utf-8?B?SExvMU1nQUtldUV1NHNmOW9LRUk4ZmxiOEdYUldUMWh3ckZNWm9NV0hTaUN3?=
 =?utf-8?B?RCtLTEQwTlNaMEpLdmJOSHVDWUhianQwYW9RSHEvYUZTNmx2b0xUWDBENElp?=
 =?utf-8?B?QjAzSVpjbFQzVVMrcUplUml4c1BpTkQxSDdvWXh4UkFQSDBlNVIvR0FvenRk?=
 =?utf-8?B?bkFOKzZTNUgza0F0Y3o0LzR2NGE5d2o1OFRiL1pWazZULzZNTWFBSTdiNUNQ?=
 =?utf-8?B?bDZTa2RsSUU3c3BJTzJKUjdZS0NKODlKa1VyWExoakoyMkVtVDBSWEZnbndt?=
 =?utf-8?B?U2hpajk0bW9PenNWdDBrQ2UvbVFobnZhb2x3Sk1MNElialowbFVTQ0YrdWRo?=
 =?utf-8?B?aERCbGFCWkxQWE9DcmhHOWJoaVRRcFBuUVlwRUVCVGd6NzBPVHhxQitTRlJk?=
 =?utf-8?B?dVlsU1Q2N21qTGJpRFRHR1RZREZRQitUcjVPbC9BTGZEclFyd2EvRFJlVXhC?=
 =?utf-8?B?T05hVVU5YkZSZVlNZS9mZHhwalArRW9lOSs4endCdGZBeG1pNGt3RXJrUVNC?=
 =?utf-8?B?QzE1K0t4RENvS1dIL3dRbElVUVIveUJESUlHcTEzMDBsT2pMYnFDK24yQXZa?=
 =?utf-8?B?VjNsNUp4YzBaQlFWUi9jZ1FYZlRHZDlTRTFUNENXN3JDM0UyQVBuM25qcjIy?=
 =?utf-8?B?c0JtbFp0RWt1ZWtZV3JOTzZKS1pOLzFaNlNYTDA0Nkw4VUJndFNRVTdDY05p?=
 =?utf-8?B?NW5GVWtib0pLWnEyU1Z0aGVWOS8vVGdPOEZOVklKbnBCREhMemlDUDRidGND?=
 =?utf-8?B?eFVLRkJNd1VwRkRLWk9SbFd6c3I1VW5xOFBlWHR0cW4xTnZTTDg1K1NYTWIr?=
 =?utf-8?B?aGtDK0dzbkN6WWJEMVpram5XZjcwR2tnd1FlejBwNklNTEh5Tk1KQU5nS3E1?=
 =?utf-8?Q?ACcLQaX96WZ7F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXdlVnZ1UkhUd2duUTZmTENubEV5QnIwK2ZQUHZRRWZDLzhJSEl5eUp2aWEv?=
 =?utf-8?B?SUhxTGRHL0JvdHZVRW1zeVFSa1o5ekVITE84VmExU0ZrYkM0WGhXb3dOVTNY?=
 =?utf-8?B?V0sxZk9ETGs0TERISFNheVJPcW0zSWVRL2pGVGpyS1RRR3R2b0FOUm1lZkpq?=
 =?utf-8?B?cnV0MjRablhmeGJNZ2NtYXcxalQzdjhKeW9URktGSXpLNlRMU3NldWxlNGJy?=
 =?utf-8?B?Wkd5MHo2L0NRMno3MFlleGJhWS9WSGY1UTVzR0RxRS9GNHVhWm9FNzN1QnhW?=
 =?utf-8?B?cEE2S0IwTU1qbXVpcGt5elRGZDBPYVJXNzlaVEVndGpwdzQ4cGI1Wnl4cGR2?=
 =?utf-8?B?bVVGVHMxR1hKaGJzUGJWM1hKeUg2eG1pMzNhR3pUQUg0a2pRUUNtUnBPQjNI?=
 =?utf-8?B?VEJFWmQ3U2dNcnFQUHUwSkZLb0RKSUU4NnJ3VURQNlRhUzVyU1Voa1NvVlp3?=
 =?utf-8?B?M1dhVWY1cGhuYWpCZnpTcFZnSGl1dWhadjl1YjBVT1M2NG9peTV6b2s3V3lN?=
 =?utf-8?B?OGNVcDNxVDJWcFJyWE9vVkFXRVIxdmUrRzZxSEgyNmZFS2lmVTg0QXVYb0h3?=
 =?utf-8?B?K0E3dEhWeXJ5eGY5YXk5TDBEakZKRmJjOU5vcHlSTlFWSXZ0eUsyNml5bWlM?=
 =?utf-8?B?dmVRU3lId1pwbWFnbXFFWWExTUhYUjZCMkZ0Qm9yME40UEhtUzJyWk1hWW1P?=
 =?utf-8?B?KzhQOWw4VVo4ZjFRK3p1dnpYWTJMdmN1VHBlRzNMUVA0V2s4QndxZ3RmQnQy?=
 =?utf-8?B?TDY0dUJzYXVWUjRrNWlOeXM0dkJDUktId2dST1R3dlNwbUdUN1VqTld0eWFM?=
 =?utf-8?B?WFE4Z1cycU93czJXQjBpNnl4RUl2aHJmSzlqeFVtOFdPWjh0OUJTR3NiQXdp?=
 =?utf-8?B?bVQ0TW9CWGxMelVWTk1iajl6MlR5SE5GZDMxUUZWTHE3TC9pZys3L0daK21t?=
 =?utf-8?B?Y3c4ZXdyN2p1Mlpvd2VRSXdLcmkyRitkaGJoUFVtOUhkSDVhZm9aa2NHTXIr?=
 =?utf-8?B?NGNuTzltOGRCU3lBNXZvKzl1VUpEV05sZWRpY2l2SnpacWNYWkpsdUpQMHlH?=
 =?utf-8?B?dlk2Zy9yRmQ1b3ArYVE5RkQ2STAwSjNoYUJNczl5cTdHeE9TYzB1UlZ0cSs2?=
 =?utf-8?B?YjZ2YkZQejFNREZLNVhDT3JWcThxSmNLV3V3WWZiS0k5amZIdnRxeXJiRCtC?=
 =?utf-8?B?eEVPZS9WcXJrQVBrMnREZ2pSUG9mRXBuOGw0WnpqUGF1NGh0dktiYmVnRFdl?=
 =?utf-8?B?M0pDVWVDN1h2QStZYXFJN0JpbVNHYlQ1bU1FdkZQcWxnZyt2QXZXcFlhSkwr?=
 =?utf-8?B?VnNDazBjWXVTNDFMa3ZvYjVzTU9vS2N2VUFXekpITVBwL1pQV2ZMZDA1N2N6?=
 =?utf-8?B?SHhla3QwbXp0aVdRMUdsK01PZGR6azR5SEJLR2d5Z1dzeDJVckhiek1YSjhR?=
 =?utf-8?B?UEl2bUJUVUE4MnRYYzZWSzJ4cGtWaFBTbFhVcFhHRUZid09EYUhZaEtRaG1r?=
 =?utf-8?B?THFTSGNiUi9UTWM1aUZzSlB6VmxMTlFndmRWbHNKOUxBSXdyaWZnL0VDU0N4?=
 =?utf-8?B?NWxvbDZmd1lIVlNlVGhiaHV6OUlLU2hFd0dKcjloWE9VN2RLTTFnNnMxUlI3?=
 =?utf-8?B?MGxEVWNiMkxpN1V4U3VLazVnT0xsRWNtOHFIQjdXK2laek9vZ2ExN21ZRGZL?=
 =?utf-8?B?TmNGazRDbU1uVDNXMFJodnNnU0VOWDNiOXpLWjJaRzJqdFNTOVZXTFU2eG0r?=
 =?utf-8?B?ZGF6aHloNlRGU1ZZUEVTV2xJWE5lWkVtQjQ2NzBjaStVT1FKZFBWVXBsbjdw?=
 =?utf-8?B?UEo0U2luZElzME1uNm0xOGV4UDVURFBXcCs0Y2FyQkxiSkMwcGpFT0R2SFBF?=
 =?utf-8?B?U0Y5Qk8zSUJDQjJCc0FIdTVzWHpVa0IxQzVYVkM3Y2t1UVBnd0JqTy9iWFlj?=
 =?utf-8?B?ekRMY0xEcUJpRnVWL1MybFc3NVJJMkJWVHNlMjhqQ3hJengxd09JaXVtQWRp?=
 =?utf-8?B?a3YyaUdjSmhzeTd4ZHN0U1JOYU9Zdy9lZHNzc1lRdzZ6ZmM3OHl6aGRMY3Ft?=
 =?utf-8?B?S3ZRcm9EQkE2MnRyM1ZsSHNCS0RXRTVyZjEzeW5LaS84OWhyNGVrRjdldzRS?=
 =?utf-8?B?RXJtc0xpUDF5azVyRUVMZlM3QWpTSWFtUnQxWS8vYUhDVVFTMVRwa2hNcDRC?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	apJ97vEDprkNJCl5Vr9tPIxN9yaPiWJ97iXwr0Mdy29/WGUgb4QQHZDFOKvk0onp+qXVy6kmyPoPqNPCPa3edCPo5673EAzCAGlopaDzS/zKiHzP581+wHRekYmHMvElFEZ9u7XkQ71RVCLwv8VWBcrK7f04afZDl8Ay4gb52ykK2GRtaZFwcbhxpVGDs//TnaPu4mtvDKkgJsBuPrUQu7P/rPEe6IQ+9RH32+SjV60nZikkZgx6AoiRYZCNxCdJb9aUuDEBQu2ItRsDuq07uN5tBAjjDBPSNwdqQYUrZZqNxOSG2mli1a7hBzw35iRTr4bUWis+bFUycnUge6e+Ue6yXpoMlQcj4bH1xGUa76HA3eXgJ6qV/lsGfYjiu4wJd1wwWlv8R0e/rMKsCDk5q8RY4noQlUAd1yl58WgYpZ387Obje9cVB5zsxkjDKxrD2NEiwzxAG8s7162Sj366unyP2HdkBeu+rpj05uyLQwIDAfb3iCdFRa47pYILBgbb6s78U8J3FITX2EOhCbdqZJivWY3fOmahyvJ/dPAComJA3DqCQOMj8/MxqUCdvd+BCrZtjvTCrDTW+BnDN4zImEF2z65p4aT5EWQiNZLlVVI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e87c23c5-5545-4c0a-bd2f-08dd5dad589d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 19:22:05.6174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +a+tTV2O5R8M4XJ3Klal922uZ1MQTc7LR+g963nKxQZNH5/eDaWwEVvRbxYyOBusU1PH7Yq90eJERP2xm0rc5dYDCXSPU1Nm/QUB+grdS8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7844
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_06,2025-03-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503070145
X-Proofpoint-ORIG-GUID: l1aK7-_0FKrMIAU1HUxOzH9__4pEp9_i
X-Proofpoint-GUID: l1aK7-_0FKrMIAU1HUxOzH9__4pEp9_i

On 3/6/25 9:32 PM, Jarkko Sakkinen wrote:
> On Thu, Dec 19, 2024 at 11:42:00AM -0800, Ross Philipson wrote:
>> Introduce the Secure Launch Resource Table which forms the formal
>> interface between the pre and post launch code.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> 
> Is this interface kernel specific or uarch specific? I'd just
> explicitly state the context of the formal interface, that's
> all.

It is specific to our DRTM solution (i.e. Secure Launch). It is meant to 
be extensible to accommodate future architectures that have DRTM support 
available. Not sure if I am getting at your specific question.

> 
>> ---
>>   include/linux/slr_table.h | 277 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 277 insertions(+)
>>   create mode 100644 include/linux/slr_table.h
>>
>> diff --git a/include/linux/slr_table.h b/include/linux/slr_table.h
>> new file mode 100644
>> index 000000000000..48d85d505a50
>> --- /dev/null
>> +++ b/include/linux/slr_table.h
>> @@ -0,0 +1,277 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * TrenchBoot Secure Launch Resource Table
>> + *
>> + * The Secure Launch Resource Table is TrenchBoot project defined
>> + * specfication to provide cross-architecture compatibility. See
>> + * TrenchBoot Secure Launch kernel documentation for details.
>> + *
>> + * Copyright (c) 2024 Apertus Solutions, LLC
>> + * Copyright (c) 2024, Oracle and/or its affiliates.
>> + */
>> +
>> +#ifndef _LINUX_SLR_TABLE_H
>> +#define _LINUX_SLR_TABLE_H
>> +
>> +/* Put this in efi.h if it becomes a standard */
>> +#define SLR_TABLE_GUID				EFI_GUID(0x877a9b2a, 0x0385, 0x45d1, 0xa0, 0x34, 0x9d, 0xac, 0x9c, 0x9e, 0x56, 0x5f)
>> +
>> +/* SLR table header values */
>> +#define SLR_TABLE_MAGIC		0x4452544d
>> +#define SLR_TABLE_REVISION	1
>> +
>> +/* Current revisions for the policy and UEFI config */
>> +#define SLR_POLICY_REVISION		1
>> +#define SLR_UEFI_CONFIG_REVISION	1
>> +
>> +/* SLR defined architectures */
>> +#define SLR_INTEL_TXT		1
>> +#define SLR_AMD_SKINIT		2
>> +
>> +/* SLR defined bootloaders */
>> +#define SLR_BOOTLOADER_INVALID	0
>> +#define SLR_BOOTLOADER_GRUB	1
>> +
>> +/* Log formats */
>> +#define SLR_DRTM_TPM12_LOG	1
>> +#define SLR_DRTM_TPM20_LOG	2
>> +
>> +/* DRTM Policy Entry Flags */
>> +#define SLR_POLICY_FLAG_MEASURED	0x1
>> +#define SLR_POLICY_IMPLICIT_SIZE	0x2
>> +
>> +/* Array Lengths */
>> +#define TPM_EVENT_INFO_LENGTH		32
>> +#define TXT_VARIABLE_MTRRS_LENGTH	32
>> +
>> +/* Tags */
>> +#define SLR_ENTRY_INVALID	0x0000
>> +#define SLR_ENTRY_DL_INFO	0x0001
>> +#define SLR_ENTRY_LOG_INFO	0x0002
>> +#define SLR_ENTRY_ENTRY_POLICY	0x0003
>> +#define SLR_ENTRY_INTEL_INFO	0x0004
>> +#define SLR_ENTRY_AMD_INFO	0x0005
>> +#define SLR_ENTRY_ARM_INFO	0x0006
>> +#define SLR_ENTRY_UEFI_INFO	0x0007
>> +#define SLR_ENTRY_UEFI_CONFIG	0x0008
>> +#define SLR_ENTRY_END		0xffff
>> +
>> +/* Entity Types */
>> +#define SLR_ET_UNSPECIFIED	0x0000
>> +#define SLR_ET_SLRT		0x0001
>> +#define SLR_ET_BOOT_PARAMS	0x0002
>> +#define SLR_ET_SETUP_DATA	0x0003
>> +#define SLR_ET_CMDLINE		0x0004
>> +#define SLR_ET_UEFI_MEMMAP	0x0005
>> +#define SLR_ET_RAMDISK		0x0006
>> +#define SLR_ET_TXT_OS2MLE	0x0010
>> +#define SLR_ET_UNUSED		0xffff
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +/*
>> + * Primary Secure Launch Resource Table Header
>> + */
>> +struct slr_table {
>> +	u32 magic;
>> +	u16 revision;
>> +	u16 architecture;
>> +	u32 size;
>> +	u32 max_size;
>> +	/* table entries */
>> +} __packed;
>> +
>> +/*
>> + * Common SLRT Table Header
>> + */
>> +struct slr_entry_hdr {
>> +	u32 tag;
>> +	u32 size;
>> +} __packed;
>> +
>> +/*
>> + * Boot loader context
>> + */
>> +struct slr_bl_context {
>> +	u16 bootloader;
>> +	u16 reserved[3];
>> +	u64 context;
>> +} __packed;
>> +
>> +/*
>> + * Dynamic Launch Callback Function type
>> + */
>> +typedef void (*dl_handler_func)(struct slr_bl_context *bl_context);
>> +
>> +/*
>> + * DRTM Dynamic Launch Configuration
>> + */
>> +struct slr_entry_dl_info {
>> +	struct slr_entry_hdr hdr;
>> +	u64 dce_size;
>> +	u64 dce_base;
>> +	u64 dlme_size;
>> +	u64 dlme_base;
>> +	u64 dlme_entry;
>> +	struct slr_bl_context bl_context;
>> +	u64 dl_handler;
>> +} __packed;
>> +
>> +/*
>> + * TPM Log Information
>> + */
>> +struct slr_entry_log_info {
>> +	struct slr_entry_hdr hdr;
>> +	u16 format;
>> +	u16 reserved;
>> +	u32 size;
>> +	u64 addr;
>> +} __packed;
>> +
>> +/*
>> + * DRTM Measurement Entry
>> + */
>> +struct slr_policy_entry {
>> +	u16 pcr;
>> +	u16 entity_type;
>> +	u16 flags;
>> +	u16 reserved;
>> +	u64 size;
>> +	u64 entity;
>> +	char evt_info[TPM_EVENT_INFO_LENGTH];
>> +} __packed;
>> +
>> +/*
>> + * DRTM Measurement Policy
>> + */
>> +struct slr_entry_policy {
>> +	struct slr_entry_hdr hdr;
>> +	u16 reserved[2];
>> +	u16 revision;
>> +	u16 nr_entries;
>> +	struct slr_policy_entry policy_entries[];
>> +} __packed;
>> +
>> +/*
>> + * Secure Launch defined MTRR saving structures
>> + */
>> +struct slr_txt_mtrr_pair {
>> +	u64 mtrr_physbase;
>> +	u64 mtrr_physmask;
>> +} __packed;
>> +
>> +struct slr_txt_mtrr_state {
>> +	u64 default_mem_type;
>> +	u64 mtrr_vcnt;
>> +	struct slr_txt_mtrr_pair mtrr_pair[TXT_VARIABLE_MTRRS_LENGTH];
>> +} __packed;
>> +
>> +/*
>> + * Intel TXT Info table
>> + */
>> +struct slr_entry_intel_info {
>> +	struct slr_entry_hdr hdr;
>> +	u64 boot_params_addr;
>> +	u64 txt_heap;
>> +	u64 saved_misc_enable_msr;
>> +	struct slr_txt_mtrr_state saved_bsp_mtrrs;
>> +} __packed;
>> +
>> +/*
>> + * UEFI config measurement entry
>> + */
>> +struct slr_uefi_cfg_entry {
>> +	u16 pcr;
>> +	u16 reserved;
>> +	u32 size;
>> +	u64 cfg; /* address or value */
>> +	char evt_info[TPM_EVENT_INFO_LENGTH];
>> +} __packed;
>> +
>> +/*
>> + * UEFI config measurements
>> + */
>> +struct slr_entry_uefi_config {
>> +	struct slr_entry_hdr hdr;
>> +	u16 reserved[2];
>> +	u16 revision;
>> +	u16 nr_entries;
>> +	struct slr_uefi_cfg_entry uefi_cfg_entries[];
>> +} __packed;
>> +
>> +static inline void *slr_end_of_entries(struct slr_table *table)
> 
> I'd document these functions. No need to go over the top here i.e.,
> no need to have full parameter descriptions but more like

Will do. Same for functions below.

Thank you,
Ross

> 
> /*
>   * Tell a short description.
>   */
> 
>> +{
>> +	return (void *)table + table->size;
>> +}
>> +
>> +static inline void *
>> +slr_next_entry(struct slr_table *table,
>> +	       struct slr_entry_hdr *curr)
>> +{
>> +	struct slr_entry_hdr *next = (struct slr_entry_hdr *)((u8 *)curr + curr->size);
>> +
>> +	if ((void *)next >= slr_end_of_entries(table))
>> +		return NULL;
>> +	if (next->tag == SLR_ENTRY_END)
>> +		return NULL;
>> +
>> +	return next;
>> +}
>> +
>> +static inline void *
>> +slr_next_entry_by_tag(struct slr_table *table,
>> +		      struct slr_entry_hdr *entry,
>> +		      u16 tag)
>> +{
>> +	if (!entry) /* Start from the beginning */
>> +		entry = (struct slr_entry_hdr *)(((u8 *)table) + sizeof(*table));
>> +
>> +	for ( ; ; ) {
>> +		if (entry->tag == tag)
>> +			return entry;
>> +
>> +		entry = slr_next_entry(table, entry);
>> +		if (!entry)
>> +			return NULL;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static inline int
>> +slr_add_entry(struct slr_table *table,
>> +	      struct slr_entry_hdr *entry)
>> +{
>> +	struct slr_entry_hdr *end;
>> +
>> +	if ((table->size + entry->size) > table->max_size)
>> +		return -1;
>> +
>> +	memcpy((u8 *)table + table->size - sizeof(*end), entry, entry->size);
>> +	table->size += entry->size;
>> +
>> +	end  = (struct slr_entry_hdr *)((u8 *)table + table->size - sizeof(*end));
>> +	end->tag = SLR_ENTRY_END;
>> +	end->size = sizeof(*end);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline void
>> +slr_init_table(struct slr_table *slrt, u16 architecture, u32 max_size)
> 
> E.g., what does slr_init_table() do and why and when it is called. Basic
> shit.
> 
>> +{
>> +	struct slr_entry_hdr *end;
>> +
>> +	slrt->magic = SLR_TABLE_MAGIC;
>> +	slrt->revision = SLR_TABLE_REVISION;
>> +	slrt->architecture = architecture;
>> +	slrt->size = sizeof(*slrt) + sizeof(*end);
>> +	slrt->max_size = max_size;
>> +	end = (struct slr_entry_hdr *)((u8 *)slrt + sizeof(*slrt));
>> +	end->tag = SLR_ENTRY_END;
>> +	end->size = sizeof(*end);
>> +}
>> +
>> +#endif /* !__ASSEMBLY */
>> +
>> +#endif /* _LINUX_SLR_TABLE_H */
>> -- 
>> 2.39.3
>>
> 
> BR, Jarkko


