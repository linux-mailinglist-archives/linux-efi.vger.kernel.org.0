Return-Path: <linux-efi+bounces-5900-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9767DCC9539
	for <lists+linux-efi@lfdr.de>; Wed, 17 Dec 2025 19:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CB633059ADE
	for <lists+linux-efi@lfdr.de>; Wed, 17 Dec 2025 18:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370DB27F4CA;
	Wed, 17 Dec 2025 18:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pFMfVHS/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GIEbmnGe"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43CD22A1D5;
	Wed, 17 Dec 2025 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765997298; cv=fail; b=bRyew+C/Pf/MZ57zC6yvZ8J6WgJwqG8dgfnUWAPiXIX5IWvVgxlP1LOaJ7YbKe4JfNj9GmvHGLn0vDncHpsfuhS69t4SUo5FgN9LjnGUuFl/rsOe6bWzYp7ijiPJFrNA9sEy36Dky1l1f6vu60cwNuAzfzl2KKkrR44xGPUOuWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765997298; c=relaxed/simple;
	bh=dHp8AKZvo+ktdEOLWNSiaAow8whxK/pvBr6PSxxO3LM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rSFhj6o5Vveoo3jBrB2NJOhx6XV6Xg+kJF/pVTB1V6TweidXDE0C6SIAFdp+prGmJ6tEkiazl3uPRSWu3zuscbWnT927j1feciAMJr+yDrpbQjL/RcE/dtMxkSJyqEt/V/2IuUTmJHZ0jAjiVGLOVI62kz51unoo89LtBDDb7ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pFMfVHS/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GIEbmnGe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHH1nlP3203047;
	Wed, 17 Dec 2025 18:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=XAw1k58qagZI8XRQpXp46ovkFLHQDFz1jOuJFjHbLAk=; b=
	pFMfVHS/XfLVtyzmYsIZ5OKFKUAskIM76dOZDbb/iISB75kr346ni31x0hjSQSCU
	YkOR9323PBZqTBFR7iOFZuzy5G8Vb0kbo+rTe4AJEAQD3+QWNOXOY6dyDipldQQ/
	xBmeMKYt0U14c/l3meYhzaYrIcvKrLiKujp6tl62Ns3LXI3ngqX3Lm4I+ap2SREY
	rVyyaMoyFm0ZKSp1varKkxKFrgkAAdUlOOEwoK8LogSCzKW0CcNUrSe6iwkEKvmo
	pl7fyyqwtVSdHefA5X0IzAcoDLsP+LLQ9Nb1luozo2OKGKKJ9F7vAzjjtRmoSvzg
	gsqiPrwYtZT5E1B392Gjsw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0y28efb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 18:47:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHHGS8r022770;
	Wed, 17 Dec 2025 18:47:26 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013021.outbound.protection.outlook.com [40.93.201.21])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkmxp38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 18:47:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUgbn5uhzy/CuDlgrYu6u4rhsN2OXNQgFg+wyL+BWH0Vo3byduwRd47ZjsRlBvTGQ7s9ydO4MHW/9maO72lh3eUrN6NnGko6rrEGDmBfLftptcgEgT77NrTSUJRhI0U7DAKxFr87KGeVEmX6CSuEkLDOAooBe8FXABwaV13dlSku9XhSjrhH9f1IrmDprd+v7/Rp4+EAQy81jhztaDgndJPMrLfkXHKROGDNO7jJqfYpC/8K72RbOHW799aak9+d8CZlwa2bV1jKFjb8P53EnlK+1Kv30fkEVa/MMQCkI2l7D+fL+cis6pyg/aw4mQqi75cWUNpIYYBKe443jb8/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAw1k58qagZI8XRQpXp46ovkFLHQDFz1jOuJFjHbLAk=;
 b=sSxoThffIeHvD8YL79qyZjHBpshvbElR1xktlut1EJ+wOWhdqLfNzGySvP89M2wDC5L5+CXW+8V1dKDdk3Wp4jJALmvmG1Cp3MfN/Q3lo8GERQflyApkfQPbo0VOqrRt2tuBtfbi5bMXgqCHTsLk9fQ8ZG7FL/m/9uLFlb1ezxFc+Mrql0Il47uFMf3pPWvueH57c18v3yFFx7ouV1anKWZcWe3OHEGwt6chtMgihuRQDgCjslfBkolUEx6Y+/jj4Ehe0AJV7PLRK/WtaNDerUr0S/SiQLfvLMjAaR2HbgeV3pbgyXpbFVqB7DdLyiAbDv7qRs+1ZhSXo8GfXHNYMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAw1k58qagZI8XRQpXp46ovkFLHQDFz1jOuJFjHbLAk=;
 b=GIEbmnGeesHVyaSpljDLxQCTofaf43HDJmh2lWSBH3Tih+1C+5sLpvyDd9nqB5ksb+IMuVomdjMbjazBI8hagi6wIdrAQe4N2C+5dqSUOQdsvta77wg3M9N5NNYm0XU4DmzFWf+cqZb/1Q4dswpLl9qtxeD8f4vhMjxcSA8WILM=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 IA4PR10MB8256.namprd10.prod.outlook.com (2603:10b6:208:56c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 18:47:23 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 18:47:23 +0000
Message-ID: <0d1b4a13-965f-4b1e-bebc-9a8f1cc395b4@oracle.com>
Date: Wed, 17 Dec 2025 10:47:19 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 22/28] x86: Secure Launch kernel early boot stub
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
        trenchboot-devel@googlegroups.com, ross.philipson@oracle.com
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <20251215233316.1076248-23-ross.philipson@oracle.com>
 <5c4734af-d72c-4b1d-9d2f-8c07d4c0dd6d@intel.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <5c4734af-d72c-4b1d-9d2f-8c07d4c0dd6d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0167.namprd05.prod.outlook.com
 (2603:10b6:a03:339::22) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|IA4PR10MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd33c76-feb2-4302-d543-08de3d9cb6fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFhnU1B4akpzdFhmcCsxQzJBdC9Tbk5sVW1JNFM1R3RBN3o0akxFdUhwYzZY?=
 =?utf-8?B?cCtSSUkvb3dlTGFtOWRmRWRZTHpaUU5NcXJRUkNSajBIMDFqUEk3M3luaW96?=
 =?utf-8?B?QVBEeW83VTFvRlc1NFREV0ZGaTZmZnpxdmNTREU1c083ZGxXbDd0emFqYTRR?=
 =?utf-8?B?R2hyanpDaGpQVElRZVFwaUZxQ0R6WVpYbDg2WFN6THhlZmlEcVdsMkNLNG1V?=
 =?utf-8?B?WEU4N0NmSE1kdUVTT05lamtlL3RMZVdjcThRbE9YUzJnbU9kMUpGZ3ozSFY1?=
 =?utf-8?B?TnRPTUVndXJ3WWZiUzhkYkQwN2kwdVMzNUltVXNzZkR6WW81RjlYeTRHNGxE?=
 =?utf-8?B?dGFpY3VBei9hWlFhWjQ3SzJ1eW5KSkxTandKQm1LWlpxNWlWcXBiTGJpcHht?=
 =?utf-8?B?VERuTWUrbXhYVVpibDZMMmE0QmFxZDVnV0ZseFJNYWh2M2xpelZFQmtmL1hB?=
 =?utf-8?B?VUJuOW9nQXVLcEtjNzV4ZWhQNW1OSDBBamtjMXRlU2V2eEd3Kzd4VHBQNmlo?=
 =?utf-8?B?ZERndSszUXFycWRXK0M1SSt6STlYVVpaTEVzWkNFeThsMWEzZDVtQ0hSYnZ0?=
 =?utf-8?B?WEpuK3N2bDZDU0xmOTFOaU8wSUdsRnpZOVVFRW80UUwxN093VnJCcmR4Wmo4?=
 =?utf-8?B?blJTUm9OdmxyVHFvdnVvbHdCOWRCR1Z1aEl3U2x5cEdxTWkrZkVrRUpUT3l3?=
 =?utf-8?B?TDAyWDRPaEZScFEzNVVkV0Y2TUFsQUxMd1pLNWx1QklUbkFBZVBISDNuaWJ0?=
 =?utf-8?B?V0VSUmhhbDRqai9jWUJheWVrRmlud0JzcDZKKzJvRWh1eGdWR3NPd2hWZk5W?=
 =?utf-8?B?TjRLU0xrajJOaFhMWVVWRGV5YnIvWUFBMktPUDFSZzNPR3p3cnJwd3UwN2ha?=
 =?utf-8?B?RHlNR2NwVDRzV1FzczFuMjJKQU52M3dMWWZ1U0JNYlFaWm83Ujh3MTNQbWpa?=
 =?utf-8?B?dTVBRmk4Q0ZWVG9Rc1VFU0pLMDVKTysxMGhzeHE5UHRzSFprbHA4SWtXY080?=
 =?utf-8?B?UGc2OGRCc3p0Uk1rS3ZNWklBUjZqNlo4dmNid2h3alZ1UXMzbnNTYUtTYUU2?=
 =?utf-8?B?NlpUWWlhRkVVanllSUZuUnlzMjgrUDZwOThFZU8wQVlySWdSbG5qNEpWUzZq?=
 =?utf-8?B?MGFINUJ4Ti9uc2dYRTVyYlZKeGtsRGEvNTVxV2p3ZllMK0NzVHVnUnIzbFZL?=
 =?utf-8?B?MG4wNWFwZDluR1ppVlNJYW5SOHBFY0NreHpNN2x1dkZxNnhtVUFuODNhdTNJ?=
 =?utf-8?B?aGFOMzBNRndYbysvTEh0bmJhWk11d3VJcFJDVmIyV09NQ3BQenhVYzVJSXBV?=
 =?utf-8?B?M0R4RXdicmhNbzJqY0plb1lvUjU3eXJia0pvbkdiNzZzR2J5V0NFcEVienlh?=
 =?utf-8?B?b0VVcWVzbFhPeXBIcEhsTUkySUZkb2FZa1FZTDNFbmt6akR0WjdYdTljK3Q0?=
 =?utf-8?B?QzNzWGh0WjFWZjI1ZVhzUUpZd2U1eVFBK0hnWTBaZDJ6dld5QllYTnRjaHAy?=
 =?utf-8?B?a0cvVmNuQ0VVZWxkd3p6a3F5bTFoTUlSUlN1NVlxMFNwUnVLRURRV2JkSGd3?=
 =?utf-8?B?S1MvUUpUMFEya0NHc0FqQXJVUHAyWFQ4UXZ4STFFdGJCSjYweDc4VTRidzRw?=
 =?utf-8?B?VXVMbU9RS2g0NXJnd0pTQXk0RzNJMmxlZlg1Z0FmNDFJc0RCSFV5eXdVaDJN?=
 =?utf-8?B?TEJ2bzVHLy91aWFnM1BrclRBN0dPSjBHMlh3eHdZOUl0cC9NVHAza1VmMXcr?=
 =?utf-8?B?amtOMW1ibVRDbGxJeDQvc2xjNDFyZjRSdTZ1UUxzNG84dU85YWJVdEVWNG52?=
 =?utf-8?B?Z0h3Z1ovNDF2bnBISVdZWWFqOTJTMUp0MWJsMEdCQXg5L0lheWZJMnA5c25T?=
 =?utf-8?B?TE1Hd29sRjV1eStpc21kRnNXTDBGTEpPNlN6VFhwUEI4dVAveExUUEJvUkJz?=
 =?utf-8?Q?b4rzFhvyFpEh6glHevP9OxwiZuKjl9HY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2JIQXJCNTFmMXpmR2tXZGd6V090TEgvQ3NGS1FQaW14TVhkTjRYUW4vb3FW?=
 =?utf-8?B?RHBDZmVReFF6aE5xdjZFbjVZeUNDaWR1ajBMQmNxVkFhYUdWSU93cDhlby9u?=
 =?utf-8?B?WFNOS013US9PZlJoNGdnZjZHc00xbWF5WlY3dXQ0T2RLTWFqcmVINHRzRUtu?=
 =?utf-8?B?TjI4bFN1N3p0cnJSbzJGc2RBajVrZTVPOGI1aHI5d25lMi9NTzRtbEV5bGpS?=
 =?utf-8?B?bHRYUUVoQm9OdG9JWkpJQnd3N1lVZTU3Q3NFbjBSczRQTlJ5TXZ1M0RXK3lq?=
 =?utf-8?B?TW1ZelpBMVdZeGNTeG9TMUhLL3ZpZGJ2aEczN1dzNUprMzBJbktIanl5aUt5?=
 =?utf-8?B?U0Z6WFh1NTN0Z0NPWmtCdkd4RDFRMUc3aElMRjk1UnZ3YzE5ZnM3S2J6Q01N?=
 =?utf-8?B?cnNkVEt3Y1BhcGhjS3h5RmxVbmFydDhuUnBkZUlHS0JTWXdrTUVvYVFLeGhq?=
 =?utf-8?B?TEtMVzhNYzZDdEkxMkdSeXNFZjhZUkZpcVhoYTc1dXk0dWJTSnF0ZVBrNVhZ?=
 =?utf-8?B?Y01PM214dm5TRVY0MHN5QkVDQjhraksvWDE4RDh6dFdTODFlNGhJc2hsWi9F?=
 =?utf-8?B?MUdRSFZ4WGp6bzk4c0lja042WGc5aTdIRVpXUzJYTmg3Z2lCWWJackJXY3Zp?=
 =?utf-8?B?R0oxc1BPYXIvUTU0aVZqSm1qVjJVY1U1bWVYNHgxZnlHMkpGVWU2VitYMFV1?=
 =?utf-8?B?cHVMSXVHNlFLN0tseEoxQk0wL1RJUzhHeXVWNHpYV2lSVjBkTlRUdkZKNjdZ?=
 =?utf-8?B?Z0VDVFRFZGlCRFpNczZzeVFnWnRQc2xuQXBFZEh5K0dvbEVJL0FNQktaUTEx?=
 =?utf-8?B?U1NPVWsyN2xyYjZNbUhaK3E5ZFZLSFRTbzU0dkZIemw5WnFQME01OGYwYVQv?=
 =?utf-8?B?VThiTHBGVjlCTGUrZVAxMHR4S2tMdldkTWlqajZ5R1NkNndhQmp2TVdadmxt?=
 =?utf-8?B?Z1RJTE54Tk9ObWthblFNZjNSVy9WWW9sQUZTcEZFTG5xZE1CRmhnaGkzbEkv?=
 =?utf-8?B?UExyd2FGbXpPT2VPNmlUZHc0M1c2NzZ3a1k2ZnFoS1hGNko3dW1CbzBZTU5P?=
 =?utf-8?B?N3hDK1VBODlzSkw5OU0zSk9PZnJPTHp5ZWh2VWhXQS9FQ1MybDNQRUJGTU1D?=
 =?utf-8?B?MHo2UnV5RE5ZNFV0c3dHYXNHdzdqWkxWNWlMQTM4R2FTNnRsY2JXTG5WMUVL?=
 =?utf-8?B?QWhSWHYzbCs4TTZya0oxM25wbm5kQTIzVEFBRmVKWEFLOFROZDQ2elBTc1dS?=
 =?utf-8?B?NE0zQ05tZUt1Wk1Pa1hoemRObFZBS3ZucW5yZmpCcFRwdTE4YXpaSmpYYmth?=
 =?utf-8?B?R3c1OXdKdnQwMzY3aFJBM3ZiSm5lVjhIdzVHRzV4dFFmYms3bjZwdDcyeE1q?=
 =?utf-8?B?bTA1VDdJSm9heTdiSFcyRFdCc1BMZm4zZVdJbE93enpiZDNLQkcyRXFUYzN3?=
 =?utf-8?B?SEtWcFZRc3pTZktXWnRmTEhuYnhrMGthTGtSZ2YwcithVy9GNGIxQVRpblNL?=
 =?utf-8?B?aHVUblAxZDRyTzcwYWtzcVQrQTl4WXRRdFZSY2EyMTEydDFFTzMzMnRqbmpC?=
 =?utf-8?B?R0tvL1krc1BWWjhUK0k4OEN4Y1Q3TmxMU2s4eDRwSnVTWGR3VS91VWRuUnI0?=
 =?utf-8?B?OHhxeHZKYTZEM01qbVBjL09tWVoxd0FHRWlnY3dYa1hJenNhaFlsdkE4NzFX?=
 =?utf-8?B?VzY2SkM3THRXOGxpdDVjM3lVRU9jaTVyVmcxSC9mRWNUZzVENUV0UTg2ZWc0?=
 =?utf-8?B?MHJFZmVleUQ1aFE2VWhHRGY1cHhEdTQzcWw5T0hPVmp5TllyUDRYUmVnS2VK?=
 =?utf-8?B?NG0yU0RDakl3N0FrdytnZ1BHLy9CNVhZL0daL0lpWUdHYUtNcDB4Uk80aWdI?=
 =?utf-8?B?bXVYQTB1cUJIa3dRTE16b1JLTTBqUHRsdUlDL0ErUm0vWUFpZGlCQUpMV21D?=
 =?utf-8?B?QzZxSGpGemJIbnlHOG9IWG4reEloWTB3SElRQzV3NS9NeXlhcVJpV1BpSit5?=
 =?utf-8?B?eEgwVUJJSTJYMDhXaFk4OFMyVmtkdEpyNDZwYkVxdU5MNTFWcSt4YVNRRDFC?=
 =?utf-8?B?c2trNElwMTBWV0s4bU85Q3FOYWlOSEcwNkdCOUdVK2JRWkpPbnZaZEFQN0c3?=
 =?utf-8?B?RHo3TjdjYVNlRWtoTU5JSkRPL21yYmtRTGo4TTM4d3NPSUxiVW5FRTdNVURE?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PS3MxtCUGFNnr/Vg8ecKF67tYqNm4mkYMr/jFrreXPDEy1ZW809/BEf16uOrMYxAp5WFI/hPtLIwAjAO1ZIBYt6kcFDeimOFAUfaVXkWrHRodlahELL3GxqHqz28HBDT+uZ6K4xX1Rw7myDxxKmnSnjMN8nvj4vTJhfSyDc3cn5VMyIPHLlLhURS45EEBCf/d32TQbV622I2sLqDAUE2bSVuKajIYMcnAkOHhTp56CsuiFxEls5Lj8z0Wn9+HcwqIXWjwFo5yC9QvrnEFZqN4fn6HdV3tkL+iD5UzxaULO5nkjASfyefWxKDqfuWtuC16QAQYzBnlRF/zwcp6GOiba+4mXAXFHlG+agh+lhA2QHK5HCS+A8/tE9tC9gGWqSP4ekNW3WbplStWe+3DShXTHb4Cq9G680MBadE4cBHx41CTxx5DdfJXr+74wyGkIsalqGvjQK7lzTOiTKh0Ru0V4d5At/6Dyl1sZMZt80fk1aSfHQ9gUmbfiRMTjKJ8TUx4KEDk9w7db4TFltuXzOo7/yPTXSCxfb4tzD5I98Q3NpT3050Xh25I9oZPtvI206eh2Ng8yHGdhYOfPXkK7tpxfP1NZ8V/loUts0a7ZKrmkk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd33c76-feb2-4302-d543-08de3d9cb6fe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 18:47:22.9587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rSqnmGPAUVF8n6jWlJJ4T7uBJ9GlPE+jlRkSlZKZ+3x7Ky6rgwOoy+RyIwV71waL+6ZgE717EPtadKqvSH3JbDyaqR4SeQp7tOjDSyU5sA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8256
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512170149
X-Proofpoint-GUID: abqLo391Nuzkre_LHaK3OeTMS59l31_5
X-Proofpoint-ORIG-GUID: abqLo391Nuzkre_LHaK3OeTMS59l31_5
X-Authority-Analysis: v=2.4 cv=fOQ0HJae c=1 sm=1 tr=0 ts=6942fabf b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=LM-ZNlZBlvJARfZOwDsA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13654
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDE0OSBTYWx0ZWRfX2SashjZ9mZhV
 RTellnNmMaFxSF350fMe2TuaQMCsTAAIVrlEnM0/HAtRKzmxFS6EjHKltiKwN6n5Ss1v9eflWxI
 RkxE/KH/bG8OByRfBfcIXevAgzaDRZt+/vnkyzqr+ueOCXwmABxMqTB+voqnfg0vpCY3SakBrUi
 2UVCgg/ox5ngNw74Ncze2FnN5dnmIYtL7fs0t4NYig989n0EtLt6dEK3cMizxyr+9h4rB2VtnLS
 WgSyYsn/r7jQ6AmCbjXyhZf6L3v5Pkm5+p8X/x9/I0J2ZIjkoCsLbzEXn77+GgR1Jt1VbKmB+iG
 4vG6/UnqPHX3fSuVcAmv5BTIcFpm0jKr6Ua9Q7NSqP8Sfvt97DtZ20pOmJSmulQ/i0WHTMjeUZn
 0jYAfluTaYhmPbL5sE0f1INu3G1/I7CeV4gF/pCE4gbGiwttVvI=

On 12/16/25 2:32 PM, Dave Hansen wrote:
> On 12/15/25 15:33, Ross Philipson wrote:
>> +static u64 sl_txt_read(u32 reg)
>> +{
>> +	return readq((void *)(u64)(TXT_PRIV_CONFIG_REGS_BASE + reg));
>> +}
>> +
>> +static void sl_txt_write(u32 reg, u64 val)
>> +{
>> +	writeq(val, (void *)(u64)(TXT_PRIV_CONFIG_REGS_BASE + reg));
>> +}
> 
> Man, that's a lot of casting. If TXT_PRIV_CONFIG_REGS_BASE were just a
> pointer to being with, it could be:
> 
> 	writeq(val, TXT_PRIV_CONFIG_REGS_BASE + reg);
> 
> Right?

Indeed, we can simplify this per your suggestion.

> 
> This _looks_ like it was just written and then had casts added to it
> until it compiled.

Thank you for you feedback so far.

Ross

