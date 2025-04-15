Return-Path: <linux-efi+bounces-3341-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C95DEA8A9D0
	for <lists+linux-efi@lfdr.de>; Tue, 15 Apr 2025 23:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C194430F5
	for <lists+linux-efi@lfdr.de>; Tue, 15 Apr 2025 21:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8971D222578;
	Tue, 15 Apr 2025 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JK940+AJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0HujS3ns"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF01624EF8B;
	Tue, 15 Apr 2025 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744751124; cv=fail; b=OPmBn+FrDBZ7oS1NUepTtndfQcbx7AQJ08QmFcI5QG/Tq5PY05FEmIW7v0//eEnUe0UcnThfziVt54yYfhsF566QGvSYoW085Uww3sJ9vM6BQZOiSkj0Zo+mu16fEWOItiXstUa6GvmzXF6vJtz46LZneBM+EtjIw+LXh5X8Z8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744751124; c=relaxed/simple;
	bh=RGowmKIlLeNiQ80Jez4KDq9ki2DcIsVNwTTw1JepHB4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EPuWI6Nu/rZ360SJ8Qv8jh1pKT7Oeg0iH+IjCs9f7EN7jOzTmuvAKjpKruFXC2dW3dC+M10giddhGRQ+3TdN18ohPLhRmb6t7eBfAgD3Bc+rG/Rw1SBFqIF9GXVfF6d0rehKXCArEJ+KRyd1SlMEtp1FVUACJaQoFFVJiBzn1a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JK940+AJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0HujS3ns; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FKuCqa017175;
	Tue, 15 Apr 2025 21:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=i+FyXxuyOqAP2nsOjAqdlEApFC5WC1wFXYRS9X50oNg=; b=
	JK940+AJPJuFeirwOnQdsRw7/OGsI2IN1w/DMvecqHqaXDqbVAChnYyCSNiAzRRX
	qr6hOUBDnZNoDsKoc4NzjLI1edLxZbgBL1FF4jUjVQijUVhCLcCLFhFLNfyA2aHH
	i/Rkz7drKqv3qm4yArTEzB+cbPSzMpJjkRn0ROULvqj4oehIGXrPZNDHv4BjVld+
	C6KhH6zV4f7CvygGw6I5mv1vQZtvnS9CeK104x1HCdxPHdUmVwPLQ0yIxVn37MYW
	A9Gib0QJV7b7O/PcuL5bH1tGgaIDLtldDPhmihAWUfB4qrFWdzN/+WGmdUOtCVry
	kIQbDdNNB/t+v1IhYjieXQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46185mtmsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 21:04:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53FJxRr8008553;
	Tue, 15 Apr 2025 21:04:42 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011024.outbound.protection.outlook.com [40.93.13.24])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460d2qpwmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 21:04:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kunUyIZWK9p8+OZlDDDMvhfpVvGkH++YfpTga/EwVbVE/SV8V0WcijienNbPdAoEyp4Vh/aidJPeZpKK5yPnuIGYkhpGUox6ImPQ/C8K4c5iUfzvQvvmx47B23ZWrv7fEni7a38cQWfwTVJeVmoo3TI/aej5+xesXLr/GBV3dfWUucDJHOWSSHSC9mU406ocS93ecajS//dSBZZBd/uMdaeU/ml61fQ97oIyoXEaS2/uhB5Kx9HBiv6zVbSoSrRhJvWOemyE7/WLer6ePaOnZ4cXdoOypb9Dkbj6gb1fOC6Vb6eGTkBUbCLGTOqmtBdPWbRlmxfRccrC1fDHZeUaOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+FyXxuyOqAP2nsOjAqdlEApFC5WC1wFXYRS9X50oNg=;
 b=csALZbAfFIRapbUfXUygbs9bfRePf8SnLeYwBUY0t3vOIJbwJ3FAXDhyqf56KW746ArmJYbUvaVLFFeLbyH/rUhr423LY4fK/WUVWniOQsF6l+IBQO9+AwoWtPU1PJBUty4bcRpqYaWf3dOsrnvB6brsJVTT3W4MEutbDm66fnK++xBY6GmgM+T6APE13E/p4VVCePztB0Ibb2+ZnlWJYzCe2pqrOXNz24z94sTBB889ErULXM2217ihK0XdbVXRGcgL4EaB3PSkICZQJeKgUdkzQEv1I3rQMb1QpR+vP8jwJB4qpoTj+7rM7MS5t0mMEAAx9krvmhL52Rl63RcvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+FyXxuyOqAP2nsOjAqdlEApFC5WC1wFXYRS9X50oNg=;
 b=0HujS3nsymkLdiFHfmDos65b6c9ZMdffLWGBGm0TTCbnPZZDjwfXHdC9UAEMQIjGCGnigh97RJSbn77RebrIuBLFF5vIQMraampEIm60jirxcjKBpGsItHV8nmr5pR92JMmiVApbVcafLrKBLl0KcB/43buunjRQygIpFrGH7wc=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 SA1PR10MB7700.namprd10.prod.outlook.com (2603:10b6:806:38f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 21:04:40 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 21:04:40 +0000
Message-ID: <195241fa-64c1-4c8a-974d-69313e2d0eb3@oracle.com>
Date: Tue, 15 Apr 2025 14:04:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 16/19] tpm, tpm_tis: Allow locality to be set to a
 different value
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
 <20250410204149.2576104-17-ross.philipson@oracle.com>
 <40d90268-272c-45b1-add5-220e9e162101@oracle.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <40d90268-272c-45b1-add5-220e9e162101@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:a03:255::23) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|SA1PR10MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f6ea30-bd74-4b07-cadc-08dd7c61230c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3ZxM004YU9kbmkzc0N2Y0RnT0h5VmFXZE5ScVpNb1I3OEZ1WEVmUnlOTFEz?=
 =?utf-8?B?TjBZSzBOL2VnWlNQdnJLbytoT2krYnFxZVpoQXpMcUxodEZGbjVjL0RNa2pD?=
 =?utf-8?B?RUN2NU9WU1dGYWdHQS9HRDFySzlVZGNYcHZmbmNwK2FQeklJc3NERU5Vb3Jv?=
 =?utf-8?B?Z2VnNGppUWlHWGxpUUluelYzakttSlA3TDR2MWZzT2hDcDVBNC92UVdmQXQy?=
 =?utf-8?B?VWRRNVBTL0NZMzBURlhLRUE2N0V4N3dna3phM2k0dEFmdEw5Tjhzb21mZ0dX?=
 =?utf-8?B?VlZSTW5UUEFucktOYXh3WUpWdC9vNlJjeitWb1NkV0RwRC9qWkZFYkxjc211?=
 =?utf-8?B?Um4rakVoR1NsODBTRDM5VThKMWdkMnRhdWErSlZkTUFPOE5hQmN5UTJnOGRh?=
 =?utf-8?B?SStLUXpiZlVoc01ESTZoaW03KzRYeWFxWXlJeFlQWWxCSm0venBseUJ6b1RO?=
 =?utf-8?B?MzlMSk1iMXh1a08yL3VoKzVzQTBYMmd6WUNtUUdQenVPUVo5ajM3WmlkYUti?=
 =?utf-8?B?RUJoNm41dXBHb3pDMjBBSFYyekc2TkNVWDlkYVZMQnV4SmdHTlppR29HM2ZJ?=
 =?utf-8?B?YXI3S1U2dzlyMlBEZXY1d21LaGhKQWtTL2x6RDZ0czdtR2MyakxDcHlpNEda?=
 =?utf-8?B?ZWVyZUVwbVh2NVNsdWFTZ29aK1A1TEFXT29MQlBKdkRHVHFsbVVScFBnS2lS?=
 =?utf-8?B?b2toQlJISytxcWpyU1NXbmVNKzVERjcxU2hGcU5NTVRNNW5pMUVuVUtzNGFq?=
 =?utf-8?B?c1FpYzQ3aTBiaW1tU0tIUTIyTnB2SVhBZW1NYmY1TWwveTlZQjNtVjV0RHpI?=
 =?utf-8?B?anJwV2xSYlpURDlreVd5TElsczNnVTEwRklLU1pFTnZkLzNmb1RVbUVHdkN6?=
 =?utf-8?B?UkRNR3B3eVRkU3ovdDJRd2E1RE0yTG1Ga0JDQ1VmaHBTbHBuK1F3WjUxNjBD?=
 =?utf-8?B?L0lSMnBQWlh1K21tMEEzMDVuS2hJQ0RlWDR4MlY0LzFKOElRTlNRSUd5ajg4?=
 =?utf-8?B?eDNaUEgybWwrRnRaaktiaXJyMjJVTVZEQmhGalUrRTBmd05JcnBHNGt2Nis5?=
 =?utf-8?B?YUVqbCtBNHR1SHkyeEVaaTBvOGZLbDkwUVdaSnc5d05UTHlIellIeWVSRCtI?=
 =?utf-8?B?QmZVeWxXSDBtVitXU2VWQXNtTU9uVGUzSDhvb1piazRBRmJuYVM3eHhhWlIy?=
 =?utf-8?B?RTc2WkhDN05acDZ2MThNQTI0NVl1U202ZnBGVlkwRXNxV1JPc04xRmN0eFZk?=
 =?utf-8?B?M0RITnp6cXFYeERpQnBGOWVUV3NFY1FZVitsOElzdEpoMnc1N2JrNkdpaHpG?=
 =?utf-8?B?ZjRPY1E5QW9OTEpQR1Yzd0w5bHcxTEJCeFVwT3llam9KdEVkbHlvOUVVckVR?=
 =?utf-8?B?QjF1VCttNXdtZjJVNnJSc1BZSG1jNE1XdlFJbzhwaGlndGwyalJNRTdwVWhU?=
 =?utf-8?B?S0JxU3FZV3NIanBhblJqdFR5aU1JcXp6UGswWWxaYzN5U1RKVGMwV2NTWmFN?=
 =?utf-8?B?d1FrTzBKZ2Qvek5KMjdmQy93SktZcStwMDMvN2FHb3RlU3lJdmsxekh3YmZU?=
 =?utf-8?B?amNFSHRWcDZ4bUtiaE82Z1BkeVVaZzA5T0JOYlZoLzE0UUViNlA5UlRNZlFv?=
 =?utf-8?B?TEovd1VRMzV1N0tRbDJUZGxkMkxVczEvWExOUHNlOEJ3SnlFSlY4QTBDQjZ1?=
 =?utf-8?B?ZkxNd3VZNmJ4UE02ZnV0aXRMM2pscXZSREVWQ09EVG1aSjkvZlh1VlpjS0xp?=
 =?utf-8?B?OERabGhTdjIzV09rZTByblN5VW5BdjFmN2JKanh1WWdNNnhhakVxTHJIMnZM?=
 =?utf-8?B?ZHl6VFFJV3dwNWJ2UlpNNm9UOWdOY2thSjV1Q2tlU1JNbUViQ2VDNnhzcjBM?=
 =?utf-8?B?YWdWSmxHSDhoN2NGeGJJUlJHVlRYK3h2NCtqc1VGU0drSElReVljSllFSVFG?=
 =?utf-8?Q?qyq3QtIDFNQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0NzR09ydExmUFFpL2Q2TVVYSGVteSt4Tm0xdEZLMFhGeUt0OFJJM3EreW9X?=
 =?utf-8?B?VG9FNlpHRTFSRzY4OHV5ZjZ1Tk1kaGdkM3pYUG9yMHlEVThsL1Y1bHhUQkRU?=
 =?utf-8?B?aWtQZnV6a0hqbUZUVlB2UjhqWldpMGZpd3dHRlpCNlBLOW1wUzBJeDhqUWlx?=
 =?utf-8?B?K3lyQkdScWVkaDhxM3hzcEU2ZkhBK2lpUnFHc3dkZDBvQVpTSTluMTVhNWVt?=
 =?utf-8?B?blNIbmw4dERDbUtlVTc1N3JqbUgwWGVIb0p2QnFmekU2VG5pb2J4aWUza3B1?=
 =?utf-8?B?UW9ZWThsSFM1QUowS2hya3M4WXYzQ3hLQTFvZkNGdVBCNGRoL2RodTMxUzlP?=
 =?utf-8?B?Q1BIa01ibjBzMXY2c0dkTDFZMjVlanI3c1ArU0d2SkJOc1l1OUdWZ0hFU3hO?=
 =?utf-8?B?TXcwRUt1a2xFaE1nUmNBbDgyejFWaFlqRG1UckVGRDNBT0k2cHU5RWo4K3o5?=
 =?utf-8?B?WVNjd3dnYkE0SXdGdEpQNHpOV3J2ZlkvYTlMM2VTZENOV0VZeStZSlRrajZG?=
 =?utf-8?B?V0tSWTVITXMvQzRVSkRVdEV5L3I4QTlUWE50SngvUXlOd3RKOXE1VXJLbVJq?=
 =?utf-8?B?T0Z1YUI3alcrN3M4NTM4dU15OVFvUnVpUGdUbUhSTjdLRWVKNUhXWEFtcVZs?=
 =?utf-8?B?clZCbkpuM0NJMTN2cTBCYjd3bVFGRlBpaVRMRTBLVElzR0hwQmczQVVLampa?=
 =?utf-8?B?c0lMZTdTdkZKUU5LWFI3VS9VMmd5VXJKTDlXSjUzTEJTQjBrRnJtSVg1UFN3?=
 =?utf-8?B?dWZDVTJUeGd6V3ZVZ3pKS2pTWjJtS0d6dVE1SzdRaVY1ODYwRVlIRFl0RFFQ?=
 =?utf-8?B?K3I4YkRUWUpCaGlwY2NhODlURTZYRFdUL1pQTDNPd0ZTTlAxZ0dnS2FCMlRp?=
 =?utf-8?B?Yi9jQS80MjFVSEdaeTZoUEsza3NFSVRlTU96enVFYTBLcS9XUElMaWZtYUNP?=
 =?utf-8?B?aVQyMElxK0lQVEl2ZTU1RUxEZmNFeUdTRWdlRnAxb0VtK3JLTXl2WDV1VnRr?=
 =?utf-8?B?Q09GNXREL1VjaEVIM2N3Umc0eVF1QVd6ZE1EUEtaSmpXZTA0YlI3ek5hRm1T?=
 =?utf-8?B?VzAzdTFJbERXc1NzYkRnRFpxcHNidlBFQ3cxUm5kYnBlNEVkYzBxaTNpUy9k?=
 =?utf-8?B?UEpid3AzQnRtUFZWdFlJRUkzM1luSWR0ODl2ZHNyNEFnVWZyYmNHamlIcDJp?=
 =?utf-8?B?b1BBanpJb1hVb1FrRDZVVHY4U3d5TFhuSmxWRnVpL3gyMVh6YVNYQy83aDd2?=
 =?utf-8?B?dWJxZ09wR3lwbGE0V04wSkpVVi9xaTgyUG0xY2FVNjkvSlp3SnNibURORS9Q?=
 =?utf-8?B?eVB3aGZ3WU8zSjArQ1hsa3VSWVNnUVUvdXI2aVpFZTloRWFneXcwUEJqNmtK?=
 =?utf-8?B?MmZnaTFKeGFmMGVjWXBmNFVRL2hVbUxxZ2ZTYmxMYThHRzNOZmN1RGw4MEp6?=
 =?utf-8?B?MmVMRnRZYkhpRTE2WnBZdmFFQkNEaVVhNi9WRS9wZXlnVDd4Mm15Wkw1Y1Nl?=
 =?utf-8?B?NENXZzlicFU1RG5nV1FXck5yZnplNTdBNzBpZGV0MzduSGt3eWdwcWJJZExr?=
 =?utf-8?B?UU51SGx0Q0oxVWxPZ1VJL3c3TFdMcnpObm5QcnVTSmRPNmZndzBDN2FJcTlx?=
 =?utf-8?B?SnNWdFJ0OW41Q3IvNVpMOE1tc083SDNhMHNKQ1lYK0pFa3hvQXR4KzQyWGpV?=
 =?utf-8?B?UlVMZXVQMlE2Ykk0M3hzRDlUS2JxL05RRlRHeXc4QWdpUmRuU2xUZm1ObTlW?=
 =?utf-8?B?WGpITXhHWUgwWkladkZtazNweEw5RE5uNHpveFF5ZElvLzU1TXlSMWhYRWx6?=
 =?utf-8?B?SUNYOUpiQ0RhU3gzbWNNaEM5QXZpQjN2dlNMOE9Hbzl4Z0RyR2J2cFJ0ZG1T?=
 =?utf-8?B?UVVtTWRtaHlMYndvNHZ3VXdSbEpHUTh1R01WQU4wSFdtQnN6TGRLWENxQnI0?=
 =?utf-8?B?NUZON0tzNkZleDhKdzA4VXJMRnVuRnZxOEZ5MkoyNVpjVUtqck5UUWZGc3FV?=
 =?utf-8?B?Y1A1amlRV1ZHWUJmdUxxOFFMZmpidml0emhMekhnNFpoN0x5U2dzNi9WMm5N?=
 =?utf-8?B?UzNuMmJjL21ISEFNd284dEk4K0xYZjJCa2RlSktVbkRXd2RKT1VUeUhNcUdP?=
 =?utf-8?B?QkRORVJHZld6SDlzMzF5cjI5ZGUwakM1RjZRRzRNZm1HOGtTVi9RQXpmeW5M?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Yukqp0MhM2b2sTJSXxdWLXLDZiw806J95237qW1zdtvt3mKPZ1kmvbVq1KMq+7QtaMGc+DnRR1G6B7LV1uuaZH1Yx1K/NqFp8OQZzOd5kAzYobzAL3v4J/7oVlZT4NtYONSSPvgWhGr76dN2ZXe6ghOtrYx1j8H1U/jUiIzff4u/ab37Acdn9lT2Hxd8Uy6xwXEUF7DLwQr2/ATGaN+QKL35aQ5H/CTm8RCs94IhHNsyfB09nKbUD/SV3ZEYmevQmKMbxAVjGcEQ0X9JKpmrdg8ChJs8X4ek2Z1+YfYUYpUvmnv7HuU5r8GnXMhAspF0wwYmAMWeT2H5CkxNyLXrESWNXU7SU1gekRHgQSYfqYqWYC5fgrMiql3t1ffTQA7BP8cuwubx5pFnX3sI3NZOcuaqCTzkEqNHg7RE+BnZbcXdW5xgiEq/LMxrH8EACah+DdVWJ4YHCcWfwvGAdhr6Dov401j+g+a8HrkHL5flh8sibnyEBsMHz6PmcsDWsGuc+teny18CmtV6RJtpoVG8Gmteykha8B8gAS4sWYqd6v3EPOqnr8ZNDgZN7AQ3VBU7ERPY7MiBkfHzzerEcFhsdSwM3jcZ49mhXp2dhr6NDg4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f6ea30-bd74-4b07-cadc-08dd7c61230c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 21:04:40.2562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrUHG5MOf5gY5WzycPzrhpAew2xV0aWX01VfT/KShdyLvAfOmCrXvYDy+1wedDVlHTcaZEqE+NZFooheyWKCa2aSuSh/WpM09rlnVbexZ6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_07,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504150148
X-Proofpoint-ORIG-GUID: 3rmyJ5czYTDVa68SEzjNkmMzpsRxk7ak
X-Proofpoint-GUID: 3rmyJ5czYTDVa68SEzjNkmMzpsRxk7ak

On 4/12/25 12:15 PM, ALOK TIWARI wrote:
> 
> 
> On 11-04-2025 02:11, Ross Philipson wrote:
>> DRTM needs to be able to set the locality used by kernel. Provide
>> a one-shot function tpm_chip_set_locality() for the purpose.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>> ---
>>   drivers/char/tpm/tpm-chip.c     | 33 ++++++++++++++++++++++++++++++++-
>>   drivers/char/tpm/tpm_tis_core.c |  2 ++
>>   include/linux/tpm.h             |  4 ++++
>>   3 files changed, 38 insertions(+), 1 deletion(-)
>>
>> +/**
>> + * tpm_chip_set_locality() - Set the TPM locality kernel uses
>> + * @chip:    &tpm_chip instance
>> + * @locality:   new locality
>> + *
>> + * This a one-shot function. Returns zero or POSIX error on failure.
>> + */
>> +int tpm_chip_set_locality(struct tpm_chip *chip, u8 locality)
>> +{
>> +    int ret;
>> +
>> +    if (locality < 0 || locality >= TPM_MAX_LOCALITY)
>> +        return -EINVAL;
>> +
>> +    ret = tpm_try_get_ops(chip);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (!(chip->flags & TPM_CHIP_FLAG_SET_LOCALITY_ENABLED)) {
>> +        tpm_put_ops(chip);
>> +        return -EINVAL;
>> +    }
>> +
>> +    chip->kernel_locality = locality;
>> +    chip->flags &= ~TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
>> +    tpm_put_ops(chip);
>> +    return 0;
> 
> a '\n' before return is customary

Can do, thanks

> 
>> +}
>> +EXPORT_SYMBOL_GPL(tpm_chip_set_locality);
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/ 
>> tpm_tis_core.c
> 
> 
> Thanks,
> Alok


