Return-Path: <linux-efi+bounces-1179-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806428FF2E5
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jun 2024 18:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233CC28ED18
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jun 2024 16:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4656198A20;
	Thu,  6 Jun 2024 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NYIFy2S8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mbErOurd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5859195804;
	Thu,  6 Jun 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692633; cv=fail; b=gmd22+dD9GZGo8ph4vtaze3zfrXZcWlEYnRHF1IASp77frU7ArK0QGFQyvYirRMbgnQIpyoJDumf/H6HALPra0nxWGVjBPmiyRC0dqEkrP85w1ftI8E6GE8DFe0nE0XcMvRZw9eud3H7zTjnOVxPtid5PfJnpe/jy0kVQPLHUr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692633; c=relaxed/simple;
	bh=p7jPW4u50CRJtJZ7h3/hmofhOdlF4MQr5PjwifrngK4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t6JzpP5hhiRVEDvJhkk0p1EudCBPLlDSCPpwQ5FFWB2M+ok8UrETyHyvrcn+3YmHmaO1mGwtB7eO5lH0aI0DQ7CsLVloBkeJdFEJiiGeCR+Nv4PtFaLz5qo49Ar35Gy8+zg5JRh7Unax0jMk7qJNm5BU+HItNc8R2ZfJudx2W4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NYIFy2S8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mbErOurd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4568i1dG015415;
	Thu, 6 Jun 2024 16:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=Jddht4iiwiZ/P3TEEyOUuXGBDYqXMUZnGP5FSxro/KU=;
 b=NYIFy2S8emIyoFgQ1vAFSPBOs7bfa5ILYGLTV1vBIurvMyF4LPknYYlWGl9Ji/mohKSB
 lRSKBZJNbt3y6PxYfVBs4fYXoFAcEoJa0IvSZA6jARobY/XBI8vEjivHy5B+UyO2PSy/
 DApbJ6W/zxftIiIcve7tKmrt+8reiLvvLloZ46AaiOdCo1tIqFCALLRMAghQY9/9234x
 aIXwZqOvB+NGT9lcmdpdkO1S5su5LC3NGL/8w3zMQsQMe2UkTw9FY+pI2PbnmGNonGSp
 iFESqGXI6T7fKYVeTDxtvoOdeuaY1Wh8tis5thC/FJLJ+TjVbVlFnI1GflHC83Ugv5dv fA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjvwd21gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 16:49:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 456GAssC020581;
	Thu, 6 Jun 2024 16:49:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj5dj26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 16:49:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKf2wPzznLNnz0TkLDqdOxVz2Z58cyOYo0tg784W/MC663vLOaPfuMY7GMLO1on2soBjjqV6ub3zM7DN6oyAYg7mtKtI5MYpssQMwgzOBwD5EcjLq4/rsW9UuMa3M2nYVOL9r1jWZSmB8LC+75WO81HfK2RF8UJWn8RIopnTypYUr9kjock5X8OdkH9eaBk68+PpnlYeh7WzKCaZ4NbbpwxDw5FAYCKgMO97pFn+CbEgpXscTgvemwmSMJrNMrRx/kx4i0eYvs4wi2kjR39bBKFh6sPYXQULjSqPLfThSiTuAM+oIvpDaurp/ll8SWTmW6ynD4S9RnbjaUR/hAGOWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jddht4iiwiZ/P3TEEyOUuXGBDYqXMUZnGP5FSxro/KU=;
 b=PG3vOQ3/cp9mCpUozSOD6nK41LPadlmGSmJ1Rg8dbT+F2Ba0Wf92evhpNPgabTu6cnGJY0/oswYpaXkqLa71THP61hd6NFYmfcGe/p2RuP9qizkpOVwCjkIHjKHj/FTPNonEwpy2Thwer0LfRTtBgM+6AHh84VHGJkBBRMoC050jZa5L/2kd6nmJEbFR2dJreoiXSzBs5l3b3gfVn/wP2r6QA3QCWM7v0gixzVK0iah17kGHfNsAbSvfC4dNrxxxvxScQb3sqy+OIL2ygNzsux68TcxmM351L+B61qprMol+YnHVQFC0UYA6AVS1lg7Ao7eJgdNJFYaiMRhrNpaH/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jddht4iiwiZ/P3TEEyOUuXGBDYqXMUZnGP5FSxro/KU=;
 b=mbErOurdXOZOv2g1fTC0DkdMFuaDxZwNjrJuTooWvAqvXfVlORRSDd/SSdAEJX7n6tlJnlLfaKgktS65mKk9zu9+xlnwlFu5AM6E9XuPUOx7j33afLSUXxVo4C546w27oR8MI9fQYMt7qSlP/tGH53ljfnq77wTNloQyx1rSGTQ=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 SN7PR10MB6596.namprd10.prod.outlook.com (2603:10b6:806:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 6 Jun
 2024 16:49:27 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%3]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 16:49:27 +0000
Message-ID: <23961b5b-a52a-483c-876e-e5e39d9e6c01@oracle.com>
Date: Thu, 6 Jun 2024 09:49:19 -0700
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
 <249a9b27-c18d-4377-8b51-9bc610b53a8b@oracle.com>
 <D1RNKV4JIE5L.1LNG82UAC916M@kernel.org>
 <f66de08f-4905-48d6-8bcf-5b1ab847492f@oracle.com>
 <D1RSB1PB5XGS.2X032M0E1VMJW@kernel.org>
 <a865a25c-336e-47de-9718-de4cb957e6c2@oracle.com>
 <D1SPFVXS6FOG.IQQB3INFYEF2@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <D1SPFVXS6FOG.IQQB3INFYEF2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:208:fc::31) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|SN7PR10MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ca2e30-5639-48c7-e3c2-08dc8648a07b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MVRYbjVyUXg2STlVTkN3ZXJQOEM5UUxiTUhzaXRsY0h3Mkxkd1MrQVhSdDE0?=
 =?utf-8?B?TTFnT0QwT0FwMDFpaCszdXIzMXdFMDYzUW1NNHc5RTE0SWhwcnhHeldzVXRP?=
 =?utf-8?B?NExCYksyZHhkWUxuWHpPS2JhUy9tR2JwUTBaTzF6alpCWEEreUlhTjBHdFlN?=
 =?utf-8?B?cGNJNklCbWJGL2FhU3Z3NFZLQTd3TzJWWVNjVUZ3WFNDMndDZERpeTVURFR2?=
 =?utf-8?B?VjlReDE3UFZ5dW5aeExSYWRlQi93SUNzdXpIcWFKNnRxWjRoWmhCZ3dGejZV?=
 =?utf-8?B?cGhSazk5YXpnNE1LTk85VUQrclRMZHM2KzNLSWpmcStnVUZSTTA1ZE8yU2ZK?=
 =?utf-8?B?NTZZVmdhTnBJclc4b0N2OWFscVozTXJtZ0F4YTVGbjRzbldDLytxSjBFbFRD?=
 =?utf-8?B?RFpaQXFNQU83b3pidkxTaGZGamVzT3BDeFd0OVZoYis5UWo4ZVVlODNadVF4?=
 =?utf-8?B?dDNBcXZUV1lqVDhXL1VycTlEblFJaGNzMXJPeVBodE1SMmlwOU45SUZsSWdx?=
 =?utf-8?B?QlB1TnlVYVFRRHFoaDN1cjFndlRSbWpRdExIeTVsTjJJejlnRW00V3VLdDhR?=
 =?utf-8?B?QzJMYTc5TnNNMkFaYmY1REJsblVzMXQrZVMrR3dHMExDWk9JdHh0emJRdDB1?=
 =?utf-8?B?eXVFOUpQWHZuTXNJSSs2MHQxc0hGZ1FHa2dVdFQvdnlzTVVFKzFiS3RCMjA5?=
 =?utf-8?B?b3RsdE5WWlRLTFVxSGlkZHlLeG5FTUpsRWxHbFdkVHZiWG9jeCtGUmpOQk92?=
 =?utf-8?B?cUtLU2hGQXdRR2ZkRTVNZ1hQTEgrR1ZGOEVpVjhoRlZzRHZPZkRzT1NtVlV5?=
 =?utf-8?B?RmdOaE5XRTE5Zm83a0tpSHhRMEJ6eFpFWU5aRTRLTWgwQ1VrYXE4WjlFK3d6?=
 =?utf-8?B?WlcwL20vNU8zZi9xVllOTGlzVXdXdk1QUko0eWp1cWV3M2xwVWh6Z0syck1K?=
 =?utf-8?B?ZytJSFVrRit0bkdDVWtRZmE0YVJpVllQQzJjUDFDVVFFUUhSODk5Mlo2aG0w?=
 =?utf-8?B?K2FyRkd0UExXQUphZVZwMWZvS3VXR1NoNktTWERFWWwwQzVuQktHUEx1eVpD?=
 =?utf-8?B?OFN0eE5vNGx1Mjg4YkMvWEFRTlBZWHArWVFoNHgzOWgyVEpTOW9TOUFMNGw5?=
 =?utf-8?B?ZXdXbys0YVJwMWlDVjZEUUoxWlJUdWNpUEJxbUVROGo2cGtLR3hnVDFNUDBK?=
 =?utf-8?B?N0IxaWFNSlZCdnRLNXUzdE44OVRMSU93OWsrUUFOcmxHTWxFaEV2YkxYSnM0?=
 =?utf-8?B?VE5HZVdPblZJMk50TXM3cWNvS3NVZC8wczBTa2dUQVRjdk81eE5CVUJrVm1q?=
 =?utf-8?B?VklISWN4NEthNFZiWUZTVGlNTXFUOGhoZ0dzNmRZSVZlTTByRUhOV0dZUStG?=
 =?utf-8?B?d1UyajZPNlFIQ0dmeitJN3duU3dEV25QellZSm5RamxIYm9EWkpDWVMwemJE?=
 =?utf-8?B?RTVIMExZN1NIWEIybWVOdmNYUi9aTE1CcVZvNXZDZko2SUhzREp3TjBUdnU1?=
 =?utf-8?B?Tk56RzIxam1qa04zOU01cXYyR2szTWhpc1ZsVi9EakZjU3lrQlpLeHBVUVRu?=
 =?utf-8?B?dzhUeFloVUsySnc1QnJmVkoyUGdVM0ZqbUoyVDZ3TktNbEY1MGtWRkRKeHRa?=
 =?utf-8?B?U1dXM3NOeVkvZUg4TVR3aElGbkU2RzVwNjVrQTBzZVhFdnNRbGtWVzMvTVRF?=
 =?utf-8?B?WjZRQnVPemo5NkdERlhvd3d4WXBQTXdyUCtwaHdKNWFxeFkxSjI5cmZuQXNm?=
 =?utf-8?Q?6x/JmpalDWcptrAQa4no/7P0A4U08ybfN8cbDgw?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YXoxOFJkU0RyTGtkQ2F4UURFY2VCOEdZaDBTRUpDbSt0OVlSMVdneFJBMWsx?=
 =?utf-8?B?MjVWalJDMmVjanpxRmJQVXRaR1RkYkdtNW9lQmhQaVdwRkdYQ2daNUJzR0Iw?=
 =?utf-8?B?ZjBBV3hKN1diRkdUOHcyRWdsd3YrTU1GN1BhVTFweWRQM3RnSXg3elB3c2F1?=
 =?utf-8?B?U1Z3QkRUajE3Y3plM0pEbVdlMVN3ZFZtZHptNjhvRlhtT1J1aFFKUTJod1Bs?=
 =?utf-8?B?bkZUUTRER1F1bVVIMVB4SEV0M2x2c2s2VzVXMWVqOHI0SjR1d29aZjI5aWFy?=
 =?utf-8?B?R3VvRnRndFJuNm1SWDAvcmQ4Q1ZGaDdHaGdQRDhzY2ZzZVJSQ0FwM1hYS1h1?=
 =?utf-8?B?VGZOKzl2QW1DN2h6ZkhneG5yZFRmeXQ5SEdGejF1cGdFTDV1QVlrOGwrak1J?=
 =?utf-8?B?T2U0b0pFOFRwQVRudkF4QzdqSUpnR1lyY1pHN1J6aWR0TWVrcmlPSmVadXo1?=
 =?utf-8?B?QVkxRXNDaURxRjlnSGNHVjd1UnY5d3c1ejJZSnVaUElTbTZ4RmVTMlRISmsv?=
 =?utf-8?B?emdPMmYzdnpDVWxEL2NSQzZaSGIvMjVja0RESUFKRngwVG1vRHBXQ1QwK0Jl?=
 =?utf-8?B?bW41WDFia2RqNndnREViV1pFQ3ZVK3ZPSFhudUtzeS9pMlQ3ZzRMZUJUTlcz?=
 =?utf-8?B?eUQrZXQ1Q1V1UEltNXJ0bEMvM3VvN2s5Y2tQdmw3QWs3ems4eWJtRk9BOGdC?=
 =?utf-8?B?R1NQc0Q0bDJPMStiRHJxS0FoSDdHS2VCKzc2K0UvZHhHQlF3dzh2UjFsMUk4?=
 =?utf-8?B?OVVZMk1SSThwMEJoNnN1QmxBcXpYc2J5MmYvdHE3dXpkOW5vbmZFSmlIdGZB?=
 =?utf-8?B?azlPMUdMRWsrWWpJVlJrd0t0a0F3YzZ3Q0Z6U0lHVWkyeWlUaDhNTEliOGJB?=
 =?utf-8?B?em1YSW4vcFJZaUYrR2NITlU4cVNQR0xhWHBhcTIvT1krMXVJVkQ3SVd3WjFk?=
 =?utf-8?B?Q3FLUHN5UVlZOHpHSVZxdVJqckY4RzRyNVUwS2lJK0Fleitxa1JrVVMyakZQ?=
 =?utf-8?B?U24vR0xhZUlKeS95eGdXU05zVC9mVHhjdTFsSjB0Rmdrd1FOWkVsM2tVY0lF?=
 =?utf-8?B?cUJSak1aZ3VnQ3hlVnpuM1lkRnlma2c5cG01UmRLTzhpK1dYNGQvUmFkN2Vp?=
 =?utf-8?B?UnRkeUJ4K040bEw2emVHTkgyeUFrRGh6MlF2a0JqamQraVVGMzB4SFIweC9l?=
 =?utf-8?B?UFNqdUpUTG1GWUs5WjV4T2xLTXVtMzFwSDBDMElmdm5MbURjYXRLaFNnczNN?=
 =?utf-8?B?eGJrZm43WUZkYmtJNlcrU2FnazNkUDRmSHEyT2RCblFYTDN4NFE3STJsalA4?=
 =?utf-8?B?WXgyNjQ0VEg1K21pZEZrb2V1OHJVNEdmNkdQR05ZY1RkZlNFYVZIRDJqQ3BE?=
 =?utf-8?B?QXZQc1pPcDhMbEl4MHZyMllDRTlDOFhrTjZ3R0tBS3ZGLzNFSCtnTmhhMDh1?=
 =?utf-8?B?S3JPRUw1VnR5Yk42aHhyKzRTTXdackZZdkVuY3phdWRBMkVaaHRTMDQrZmJ1?=
 =?utf-8?B?N1NSLy94RUlZTTVVcjZtRHY4b0lFcmJPajJnRTVGekw4K0R5RG9nTTZqVlZP?=
 =?utf-8?B?UThrbTNYdzQyVVNYZ0Q3c1htbzh5UmhMeDh4aThiTmYrMm04Q1djRHhnRUdu?=
 =?utf-8?B?YmcvNG8rNVJGZjNQeVhmWk04K2JYOVZGNm9Ea3Q2WWVxaDdGNytXaGgwYVIv?=
 =?utf-8?B?Ujh3UzgvUEUyUHpjS09OQi8wSlNzNHE1dGVVV1k1Q1NYeDI5L3IwY2VTRWJO?=
 =?utf-8?B?aDFnUU40cXVMdGI0NjdqQi9CN3VlbkpJY0w4ak9wNW9kQXkzdkFzL0svaFR4?=
 =?utf-8?B?cDFwV2RVUENJYitHTWY1aTlaQ1JlUmZoUjM5S1FlTTF2MFJKNEZqSDIybzJ1?=
 =?utf-8?B?STNxbitENGIxMmQrL3hkNVB5SE54MFgzNWlJNHJBbDRDZE9uSU1EY3J6MURK?=
 =?utf-8?B?aytqb0NiaHE2ZFdRZG5vdURmZWYxT2VTVHZvcCt6VXJyTTIzZ05nbGR2TXky?=
 =?utf-8?B?Wk5EbUd4UzFzY2doNTJHT1VZeVNMWVV3NDlDeWEwRDcrOVpCeHAyRmlvSmFI?=
 =?utf-8?B?ZjNZeGJOdmFSQmVXUW14dk1BNzBLTTBNcm1SUUUrOUtyY1JDRTFvb01hMy8x?=
 =?utf-8?B?UW9BT1hvOTJzU00zbDh3K1hhMEoxWEN4d0VVNkt6cStaVnMvenR5c2tyTjFF?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ux+iWqibADWm+sIar4jds12VZSVG570D+O5feJtBdPRKsjb1P3OiLgbrnl6hjaZO/S3NXnX8xwNObDN1PkWoE1Gie2C15jnRI6i9N839NluKNiGRlyEkDH1CVSN7B7uoh4QplTKoQXDYmovvHkQi+Iv7111OZdAUdRxw9xW+XVIncXWyA/2yvNHjoHot4RrtDyE9a/TAlluVSG1plIl2Aa9Nzy1m+f8pGpmPjavbxK66n0aO/14EFeZWHd2B65MEt+nhoBpHJhX5XfTfVdKPzYS72H7RLM2CaFtyTYCtc8GazgQD6S7ypfJ5l27KdwDD9LFPkdEvcG+R4rxGSaPvvd7NtvnzsPN/PleD+Kn+Gn197mVYC0WAciSQb9FkbVWBKqCz89cPwjZCva4BdzGCycXKWcyQb9vW5c3ar2+1NFlzXtGlLw1hocOh5QimvwJeDoF8qdg/JQfZy1zNUGWDIf1BIrIZmRW+oLKjPISt/fRXj/zs92zQg8nKdoEqKBcBxd1A4E/+gpJNbT6jMg8TXNbn9fc+z7dr7z/2d8JOIFweT+pBKt3jKI9movwRWrN9KxI6vMvga+lkvD1XZuAeHsXSN54WZNVC5EwyM717/Gs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ca2e30-5639-48c7-e3c2-08dc8648a07b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 16:49:26.9618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nP13yE/4ui6UBc3bq6qEg1LQg4HV1ingOFs25MSdphLaQRRVOULHuU+M9y3SIMAqjQ8EqxWYabv/tUEJNMla0w/V6MW7KbGDF5CGF1jWGyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_13,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060119
X-Proofpoint-ORIG-GUID: M1_4A__4KLwGeHiEJQWMnUnFnn91-YTr
X-Proofpoint-GUID: M1_4A__4KLwGeHiEJQWMnUnFnn91-YTr

On 6/5/24 11:02 PM, Jarkko Sakkinen wrote:
> On Wed Jun 5, 2024 at 10:03 PM EEST,  wrote:
>> So I did not mean to imply that DRTM support on various
>> platforms/architectures has a short expiration date. In fact we are
>> actively working on DRTM support through the TrenchBoot project on
>> several platforms/architectures. Just a quick rundown here:
>>
>> Intel: Plenty of Intel platforms are vPro with TXT. It is really just
>> the lower end systems that don't have it available (like Core i3). And
>> my guess was wrong about x86s. You can find the spec on the page in the
>> following link. There is an entire subsection on SMX support on x86s and
>> the changes to the various GETSEC instruction leaves that were made to
>> make it work there (see 3.15).
>>
>> https://urldefense.com/v3/__https://www.intel.com/content/www/us/en/developer/articles/technical/envisioning-future-simplified-architecture.html__;!!ACWV5N9M2RV99hQ!Lt-srkRLHstA9PPCB-NWogvHP-9mfh2bHjkml-lARY79BhYlWJjhrHb6RyCN_WdGstcABq1FdqPUKn5dCdw$
> 
> Happend to bump into same PDF specification and exactly the seeked
> information is "3.15 SMX Changes". So just write this down to some
> patch that starts adding SMX things.
> 
> Link: https://urldefense.com/v3/__https://cdrdv2.intel.com/v1/dl/getContent/776648__;!!ACWV5N9M2RV99hQ!Lt-srkRLHstA9PPCB-NWogvHP-9mfh2bHjkml-lARY79BhYlWJjhrHb6RyCN_WdGstcABq1FdqPUuZy8Sfk$
> 
> So link and document, and other stuff above is not relevant from
> upstream context, only potential maintenance burden :-)

I am not 100% sure what you mean exactly here...

> 
> For any architectures dig a similar fact:
> 
> 1. Is not dead.
> 2. Will be there also in future.
> 
> Make any architecture existentially relevant for and not too much
> coloring in the text that is easy to check.
> 
> It is nearing 5k lines so you should be really good with measured
> facts too (not just launch) :-)

... but overall I get your meaning. We will spend time on this sort of 
documentation for the v10 release.

Thanks for the feedback,
Ross

> 
> BR, Jarkko
> 


