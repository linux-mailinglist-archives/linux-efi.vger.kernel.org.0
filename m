Return-Path: <linux-efi+bounces-1165-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980808FBF7A
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 01:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890F61C225EA
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 23:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7CD14D42C;
	Tue,  4 Jun 2024 23:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="knuCr98s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uZpoVVf2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB3214D2BA;
	Tue,  4 Jun 2024 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717542050; cv=fail; b=mez40tiRPDMkb80mZuj615iPpckeELtDPaTZskDyRqDmoZ+z7PUQCzWXlyLbQ73Ez6qgGk58IB5OwV8vCYd7XDsWhEsw2NgSverhfsb5LigmOobFSPoiIEdGcnqXbjFqLMIDGh14erwm74irhQt2hU8MvJTDarfN7CDMl3BJk8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717542050; c=relaxed/simple;
	bh=H3Xa3l90TmqzUKSs0d0/LKV/JJ/dH3oPOY6eLr9EtZo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZsMkcAYpwwcYtHlEpU3EHHl6h7wvdjogLx+NYbF9nLwTRGxIDlLLoUten8k3hy2ySLlkR+6avem2p3sxkKLNtWYZAEArQZYkemeyfGE7k8ghjWSV6D8WssdM1m5R+vm4feOoCdSe1fjG79+lllJuCQZ6Wa6fkDOuCqiDrbqaSDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=knuCr98s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uZpoVVf2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454MTVIr006878;
	Tue, 4 Jun 2024 23:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=UMRziMkdsAc11cvliLjvpCFFddp8Z49+PY6WroBgORc=;
 b=knuCr98sXIf0XwyomsHhWaVMRWQMlfNixMHOovR2TklgRBO9oRjK7oKG/cKWD4bHdwJH
 u9n1Sl3295nvLqK5oTTGWFPI++zowvUADCmqAw3a0E5EV8msTgtKSFpVt+42G2b9cfLQ
 jN7uEnki+B8w8OWFiScY+wzgjtJFFHWUDC6OmCCsJ4ByjbEmVscdzUGmFjZeoMsWMOZi
 MlIVTjRwKreU7mVIAmPW6PjoW2mBRtZoO9+1tZygjW04UE8e0oGmqtVr60Ch+L6jjB6J
 RNnLK2jZtR6z923wWyHuWTQalKHgixMIhDXBHbYQZz5b65DEdKELNphMh0GPmBlTjzLv 3g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrh80th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 23:00:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454L1uX3020731;
	Tue, 4 Jun 2024 23:00:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj2npqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 23:00:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPFQGGfDBLAewoONwp7C8PSUeWXcXYerYYXWqIjcseFkhC/AafhY4ZGLhdNZ1Hagu5Vgw9FGROtr23TX9pxWBoPOS5+bxdjcVsQqhbJSVM4dnpn9Mkn/UM0owgpNPuXHjc3qPItvVzHtGefPKdXYXlQ9V3L9cIeICv+6iJywuLeOJmIQmeCGBC/R96+ca7BwUS7Ku9djLkEzWS9U1SDeECZvk2hwbmbq+OtSyDJWwosyDYkRD5smXoQ4DP2R7jdruSlNIqWJ2xIOqhzQFAJsXt01iXaWykODzwjhjsWF0Yvb+M+HAze91GNWu3JT4V2hAmMMCFz6VnCXrf9Nffpz4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMRziMkdsAc11cvliLjvpCFFddp8Z49+PY6WroBgORc=;
 b=flpDt00wblT81qcl1gHQM3852J4zQ/mza6JKr2ZdcP74dKqQKdjGbCNirrb1KDTASAWAGS1EbsaOMrv7+mldVfwcAN7GdOb2Bes7LFO7jYNG9Bz1mTjRR+PWmJyE0rJCM8ZzVTN0FNCaMaVrhlyIUVdDrsYnR4wosGP9fdVCVTOob4ATU9MNVd5LvJ1bshM1dbR8JN5nG00ZcInJuOnD5653CA8gm6hJNw7m7dblAUTQXRlrtYnEvi0KS0nNRIvVhjuYV1ljUPAVmldryAd5MaTv83zTBnGiqlWS7dVS+6wPbX/qtYCoJ2vzAf+RFtW2bx8AsVxnkFp2cUdjoEWEBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMRziMkdsAc11cvliLjvpCFFddp8Z49+PY6WroBgORc=;
 b=uZpoVVf2MaFrGoJhFSQLT1gmX51iqVVnJkTcl8URZlLrEeuKP6kCE7ZHSD1z2t4nTGb0SRLQPyf5zqvbLOsXIwsm4u4ExXRNeExLKAGVkK7YHIAfI1QDksHyoNP4NOkSiBijVNKHp2OWlMkj22VYEsvP40/yltth80fWy/Zexdk=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 SJ0PR10MB4719.namprd10.prod.outlook.com (2603:10b6:a03:2d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Tue, 4 Jun
 2024 23:00:06 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 23:00:06 +0000
Message-ID: <249a9b27-c18d-4377-8b51-9bc610b53a8b@oracle.com>
Date: Tue, 4 Jun 2024 16:00:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/19] x86: Secure Launch Resource Table header file
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        luto@amacapital.net, nivedita@alum.mit.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com, ross.philipson@oracle.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-5-ross.philipson@oracle.com>
 <D1RFWFIJEYWL.2FC7V79321264@kernel.org>
 <1eca8cb1-4b3b-402b-993b-53de7c810016@oracle.com>
 <D1RLBMTUKRFN.34KQXEFZTBA08@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <D1RLBMTUKRFN.34KQXEFZTBA08@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::7) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|SJ0PR10MB4719:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fbcfed5-8c7c-4c38-9159-08dc84ea1346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TFl5bXkra0dncTAyRXN1NXJ6MFUrUHRkOWxlbTNQZnRObGpneUNRZXZoT0Zr?=
 =?utf-8?B?UVRES0o2NFo0dXMwT0pwRmlBWW5Ha2FsNGJwMUhPTEFoT2ZwZThFaFVUVnRJ?=
 =?utf-8?B?Wnd4TWExQURzNUp5VEh1WHYrVlBidVNCa0pCTk92SzMybUJCTXpxV3VnTUww?=
 =?utf-8?B?MVhWSS9PRDRxMjlnY3FMcStOWVIwR3BkL2dlRFd3Sk9zZ3ZPZTJsZ2F6T0xM?=
 =?utf-8?B?Z0ptOU1sdDBQTVJsaklGVWlTT1AxZ0RUMnl1T2w5YmM2WWt5c0hHUkwrMzBk?=
 =?utf-8?B?dTF3Smx4Y0VpS3BOL2NHV2lXR2l6T1U0MFFrckhLdHE1b2g0cVE4WVRxeEJZ?=
 =?utf-8?B?UnpRYmluUWFxais5d2FoOWs1aW05VDZPSjlrZ08zbExMVkt0VE5mMzZHNDlS?=
 =?utf-8?B?UGxIRExhZERqMktSTndZWXpIeHZGR0FtVm1GVDdvdkl4NkpvOWd1NThlaTFz?=
 =?utf-8?B?Ulk1RXlTSS94YllLQThLVG5SaytZQXdkT1J6ODVPZ1ByaktBTFNFeGkyUmgw?=
 =?utf-8?B?YW9RbnQyL1lLUDFwT0NiZGxmTUFaNTdHODNHQ2oxYyt4WHlsNnAzTjhLZERh?=
 =?utf-8?B?Y3pRVjd5UmZDbk5wcGx1enhrSXJiNW5aZG90L0FnOUxHZmF5elNEZUpGODNh?=
 =?utf-8?B?dnJRUWVTWFFZMTlwQncxVEN6RkxWT3dSMWlkSGxRZzVIL3RPM0x2UmxNSkxF?=
 =?utf-8?B?bHdlckF4N1lpTnhxVWFvd2pwTnp1K2NNR3l5NzNuaFZTYlA0QUJLUzFFbmdX?=
 =?utf-8?B?ZzB1QXNCNmhqYWF1VjZWRTlaVW80Ykdpa0ZsSk5YblJPQU1jQTU4R2R5MmJE?=
 =?utf-8?B?bEVKamE2RkpWdi91RC9NZ21yb0RXbXArcUhqaUpHaG15bzFkQWxDVkNlbDlT?=
 =?utf-8?B?dmE2V1hRREg3Nmo1S2ZLeTgvSXpiWWZQVUdxNDZURi9jNWR0OEEySW4vNWZp?=
 =?utf-8?B?dHEybnhVbitQWEVpZXN4T1A4SnBlNFNDb2RZWldoOGFxV29jNmltT2NDaFM0?=
 =?utf-8?B?WXN3d1hSMk5EdFBtRGpNSnZ6bzZ6VVFpcmE0Y3pZYUR0STlTaDd3cWhoZ2tZ?=
 =?utf-8?B?YTlBRFFxTjZzYVlYM0RmYU96T1pPVEhKYmQwNG5XSzAwUmFUMno5M2llK0pr?=
 =?utf-8?B?bDZCQ2VMc0RpZWUydTNpVDRLOEhmdE9WVW1ST0EyNk9IVkY3UFd0Vy9FSFl4?=
 =?utf-8?B?SkluUjFKbGtuNDJvZGwzR0swMkVYVmR2dVFZWS9VODFpMXNKTlNZNGJqM0Ny?=
 =?utf-8?B?Q1NreExzWXlRMXV1MHJxNGt5NHlWUTQ2VEJwME13bGh1Mm42d1A3NXJhRVoy?=
 =?utf-8?B?ZjFQU0VLMGhVQ2JLek1Vek9ia3hpK0lzU2NyUWFGREZ0TThueTkzMmxlMnpB?=
 =?utf-8?B?YTByTVc3Mjk3V200QXZscXJhUTgrdTY4VWpBOFNTQklTMTRjVjVXVzZPMGtp?=
 =?utf-8?B?VlhVLzZaOFU0OTNWd002NmJHbUVyZldPQ3ZnK2xLOHlKamRsMVNhTGhKSXM4?=
 =?utf-8?B?cW5wa1krY0VwdHl0VkEydkU4TFc5RHgwakloTWJrVUx3WFNqalFxOWRxMzdB?=
 =?utf-8?B?RVhLMDk1NUZiNmNnZ3M0ZVA5Q2ZNM01GVXVqdDEyNThlK2VtNExZU2k2K1F3?=
 =?utf-8?B?ZTRwMFVUV0lLWlZkUTM3QXBodmtXMnJnaTdxem1PTUdvRHYzQmNndDZEWkpG?=
 =?utf-8?B?QktDU0QvUkZuaHpndWNEc0VWdlFKdUgvTm5JbzRGejNrZG9uYzBsdkhBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SlUyKzJId0tYK1VrbEhHc2pXQ0xMUkxvY1EzaVJTSW42Mi9nUVNYQ2lJOHhC?=
 =?utf-8?B?SSs3RVd5cG55Nm9nQW10TTlpTExZNTlYeHdUL0h4b0ZWM0pZamM5RW9mTzhF?=
 =?utf-8?B?NFV4YTAvUWtrcnFwb2N4WmJtMDUwZWJrRC80N25JY0xjbTVLYy9aS2VlVGNK?=
 =?utf-8?B?RFVRYVRuZXNuZ1ZkMTJ1RkxVamZoVDZyMFRucWtUQWs1N2pkMXJyVk9wVG9R?=
 =?utf-8?B?WWYxTFViTzltZkcyRUh0SDhGb0l2NUw3aWd4YWdSbWZISjdaQmV0bVBxbEc3?=
 =?utf-8?B?UkhHZ1FwSXh4U2hDVy9xZm8yUk1JRjMrYk5EV3J2NzAzMG9YT1dEVk5BN1NZ?=
 =?utf-8?B?V1B0eEswRnpoL1RiS2pvWGhBelRhY29CWVgzbTl1bkt2VlRjZGI5VGhKYjFz?=
 =?utf-8?B?ZjljY00vZVRBM2FYL2RKMy83cDM4MXZwTkVYaklYSE5EcG5JSCtQYWpTV0FB?=
 =?utf-8?B?V0k2KzByNmFQMEZrU1ludWxpaGFneWdRUVRWS0N1bnlaQXFEUUV5cU83dU1N?=
 =?utf-8?B?OFc3aXhsMW5kZW1HcUFjVHpSWXk5aXNZUXdDcll2SmoxR3JxVUFLdHUyYm9Q?=
 =?utf-8?B?MVZqK0pJMWl1YWorRlRCNnArbzVHcjN0WkcvQ0dIazlmVWNkWjhmc3dpWXR6?=
 =?utf-8?B?K1VzY0FYVFY3cStMMjkxMmZJSWdHWWp6UzRWc2tEQzRadnNtaVF6MWExbDlG?=
 =?utf-8?B?alg4OUw1cDkvUjZyRGo4MmljV3ZyVnVtY3V5SnpGemkrSFhRTlIrVVNiSTZT?=
 =?utf-8?B?anZLU1NDU21tVjhFZngrdEJFejRPN1JZbjlWZXdLeml4ZFQ1c1d1d3hLcjkv?=
 =?utf-8?B?cEYxNHBGQWREU083T0pMZk4wZ0FqaTJ0ZkFxcmp2OW9wazJCdHdtR3BmaU9T?=
 =?utf-8?B?MVVyNXpKa1BZaC9peU5FYjErc29NZXlmRElZVEVad2ZyMloybkwvSUVNZ1JG?=
 =?utf-8?B?bEV5VkozU1JqVnBjM3pHSCtXc0wxamp4Ty8yVHI3Qk0vSmdHOE0vUzhOZU4v?=
 =?utf-8?B?cDYrNWJ5c2xzNnpTSkYyN3daLy9nWDV2WWg4WFM2MnFmL0daTEUzTzdhQmNX?=
 =?utf-8?B?ZzVQUDZJWU03cUtKSVZRVzdpWUtZTGZhVnpJVnVON3AxZS9lMS9aTE8zT1FN?=
 =?utf-8?B?NmlTYnVzNmpVYk9SemJ3UXZPeU5uMUVndW9laFBBR0tUL2xHSkRSVHMwUFNM?=
 =?utf-8?B?UHVwNEsxeDVKalZhK04xR3c2R3pFWjhieWRoYmxqZHBmZmdIMUR3OFJ1SEw2?=
 =?utf-8?B?ayt0eVNsTDRFODBZWmoyRE4vc25xYjdqRFp3TFRacHlBZ25oY2lTc2xIa01P?=
 =?utf-8?B?Zk4raTZ0YkM1MkR3eVV2bXlIVjlUUVgrVElDWWRNVFhhZEgxdXdqVTdnL3Zr?=
 =?utf-8?B?Y2cvTDBDN1NJRlM1Y1RSd3Rza3BsaVhvSHB0YWJKT1dDYTZ3RXhLVFd5elp2?=
 =?utf-8?B?dmN3djhnUFpkVFc1SFFuVjBlYmtLWjN1NW83ZnVHU3ZBTW5zV3pidDl1ZWcw?=
 =?utf-8?B?M0t2cDB2TmJZQ3ZscGxyZUhsZS82VFFPSDYvVnlYeFlkNXh3bDhUNHpxSTdi?=
 =?utf-8?B?bHdmOVZZekZJaStwa2E5TGJtb0xUajMxUUxBcXBrRUxjUDhmRHIxd0Eya1B2?=
 =?utf-8?B?aGFqYnFjTnFZRy9wR3ZZTTFtcEFBYTgvbjljUjJGYjFyUjJ4emQrd1VIeWQv?=
 =?utf-8?B?ZGQ4Y3R5VlRZT21aS003UFZqaG5tdWxibml6Ym9KUGNMVC9yWStXTGpmRklj?=
 =?utf-8?B?SThiMWdrQk5pa2JxU3RRWEVrZjlublQzK29Pcno2SXhDUWozVUJSczZZMWMr?=
 =?utf-8?B?Mm5yQmFWOXhPQmxVTGlzdEl3ZFNNOGwvaGVnek1SWnp6MXVOSGtwRlhjUEU4?=
 =?utf-8?B?MXErZEgwRVFLQ0NMNWRXZ2NsbzUzdWdtcjMzN1JhdE1sVFFkdHAxMVg4Y25H?=
 =?utf-8?B?SS9CUWozVlZuZ1VQa21VdXF6dVJjNVNvTGovdEFEMFlWb0dWb05zSjFJK1JF?=
 =?utf-8?B?Wm55cWc5bEZqYzZ4cXFsQ1ZJRTZ3Q3lyQ1pHK01iVHZ5YVh3ZVJSRDA5UFRS?=
 =?utf-8?B?VTF4R2M1d2ZmS3AxK3ZOemo2M0VNMFFKQzJyQVM5UEtMa1FpRGExS3dyNWkz?=
 =?utf-8?B?cnZYZzdTZUsrVHlVbDZCZnQ3a3BLVVUwSit0VlZlKzEzZ1FmcXJZd2xBVFB2?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yp4L4rxTvj+Iiy37SyjY36OQ1cO6SXB+FRHAkmfXunnWfBHGbC5my/mFDoH5nFvCq27l7VgVVGkgWCJ761arNWS/ZZ2WFGXXopH6ExILOZY7azxH08WpJ0tr3c2Wr9Tij9meWSdvKF6preLvBPIYaqgR7vJup+HdFu1b3nzu7cCnzNSasy9UeVhky2oqXO8ngjXk6c5n3lk3UUOjnBoaRw3BWgGFxw0kCMAY5vxxiEMyNO51jn5/OjPoy7a1o9WBEitV38MrYyW8VEQTREv6RUlVw8KGVVc72JQw+8HAF0VW2XulQNHtFsSr2F3YGV7LXcoiuT2kL2J4Xuv5ZkGXFj/04Nv0Ixp5TiSWDEDxqzHI9usjNvBWCwkaUDEe7/8yC81EJzYJnVbcEsZ/+A/rQ88mg142+SKesxshY7+/pgTVOEgv07OBUGtj4JXjfL0RU36ZYA2vTv7btVCEHxMa6Uqj17Qeursf7Qeh9mvE3xSip++RrNzVwDAXgzK0EITNKMNlncFsijYQGWswFnoy1CAJovKpn+UR+dEXlTiu/n+mjeXiobsFsokSFGbsRoDLK0mfeTSPNCPPFpupffK6yMLHw6DOFFLOnx5TEnao7M8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbcfed5-8c7c-4c38-9159-08dc84ea1346
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 23:00:06.2115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1DQ2w9BQXzxcrPIZH49G7tmHDCh9mdTzE+juIiFhrzIsYPHa4/IscgiQRsaHd5TbyArjo1/vxnkvCzMHqHD/cnmjqV/4XK8FeQDQ4l0n9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040186
X-Proofpoint-GUID: 9_CE23UrkCgvi41thVbmCr59hCr8z_Hh
X-Proofpoint-ORIG-GUID: 9_CE23UrkCgvi41thVbmCr59hCr8z_Hh

On 6/4/24 3:36 PM, Jarkko Sakkinen wrote:
> On Tue Jun 4, 2024 at 11:31 PM EEST,  wrote:
>> On 6/4/24 11:21 AM, Jarkko Sakkinen wrote:
>>> On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
>>>> Introduce the Secure Launch Resource Table which forms the formal
>>>> interface between the pre and post launch code.
>>>>
>>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>>>
>>> If a uarch specific, I'd appreciate Intel SDM reference here so that I
>>> can look it up and compare. Like in section granularity.
>>
>> This table is meant to not be architecture specific though it can
>> contain architecture specific sub-entities. E.g. there is a TXT specific
>> table and in the future there will be an AMD and ARM one (and hopefully
>> some others). I hope that addresses what you are pointing out or maybe I
>> don't fully understand what you mean here...
> 
> At least Intel SDM has a definition of any possible architecture
> specific data structure. It is handy to also have this available
> in inline comment for any possible such structure pointing out the
> section where it is defined.

The TXT specific structure is not defined in the SDM or the TXT dev 
guide. Part of it is driven by requirements in the TXT dev guide but 
that guide does not contain implementation details.

That said, if you would like links to relevant documents in the comments 
before arch specific structures, I can add them.

Ross

> 
> BR, Jarkko


