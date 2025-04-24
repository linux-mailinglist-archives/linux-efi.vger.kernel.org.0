Return-Path: <linux-efi+bounces-3460-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2839EA9B831
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 21:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82925A35D9
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 19:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F351290BDF;
	Thu, 24 Apr 2025 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KOZX8ZZ7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kAdsRoDS"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7A2900B8;
	Thu, 24 Apr 2025 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745522445; cv=fail; b=OCiQXVFALTM6cOrrxA4I5WJFCGDFIhq7L/yzNIRg8s9X1+Oc1BdC59LLtpIGGoC4axZ6BeH3m2zOd8Gv/v5McII/gZFlgQp8KtAevYZHX7vGERylqsSIaQEdPz52IrzGRyP12+ijdcSnU9+ky2CzsNq1j4doUPcA1YoKFvkzdxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745522445; c=relaxed/simple;
	bh=S8jVUd0UD0zNfcquvPHcdPG4Wu0YIQXAcyIvl53npGw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gB+qfYU0+GKSH5b0zxm3vdlkldXT+8XA6MLmuABmQ00M1nhXs4zGAfbIcJr1z4iogov7FTKnOvZBQpU8k+pzdx/hrCTeSladknmygPimMhjGZmOtidfPojbQHwdPOKLgB+18G6LLomYD9XIA6HVYGH/2fLAdbt9rq3a1BWbJ/dI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KOZX8ZZ7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kAdsRoDS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OImWXS022622;
	Thu, 24 Apr 2025 19:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=d+/Rt+wLVjZVlryJfR3fWbz39gnNFvAAHsPQFGpwbLU=; b=
	KOZX8ZZ77Y6rWi1k+JCmqpF+3gQZyiwV/KLdZBblvVXb/+9Ze/VTxV54Esc6TMx2
	2EkiMqqbyNysa4KzaDKIj8zFQQW9AXLHHfsS/gJsRaBhRW56n7wlHQSCRonwQdrs
	/9Lwj3e+bxOG2KFXkQWDpznCuUbGaiV16snX3WkdhkcObTT2XSHQQ7KgDWWqM62W
	K3XrujHVzsJMqeY/DWdWR0RlqmHVwo2ilD/m/0GSsxiMa9COnz8Fbr8MePvb/9k4
	s8pB4SyYwvG8NZblT4pkHvLCsTlnR796KHTcYIBIbFMW/w1ExeG7G9ecwOeZVRTy
	Mg9/6nrbi5TQdLIt7KFtzg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467tvp8248-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 19:20:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53OIUctL025047;
	Thu, 24 Apr 2025 19:20:04 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010005.outbound.protection.outlook.com [40.93.13.5])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 467pubvjcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 19:20:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LoPb0bPuyrTABahe0RmQwL9EKFDFhAY0MB+T+SJ4Ts+FbHqQ4H/YSHUbnxiyHGAJdCmzvO0gc8EkW9Kz9wg45pRr7fv8O8g6Ed1UdQRMtkQfnHg9w9mn86PBwzJ1J54DZqzYpzwjhb2iqYcmvHU5TNpM8sejsXGNX1tgHXOT7rnxVQ41FGdU0D4ccH67gNhiYIaitQvuHqVA3ypmAMZ6ut7IhpKxAwYrIgwXPVJID8KjR2X2ZgbhkO410y6HS0l5YbvfxRKzSUjDURL2S9cqD3rD39dtod/cfWUbZrDhgzFj6k8pQ9O7VqKFgF0BXdQNSWpZi9irhLhfBMyJgTEWmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+/Rt+wLVjZVlryJfR3fWbz39gnNFvAAHsPQFGpwbLU=;
 b=f8IpfDJRDD+yH5p0JA2GOFLQU4rboiEP+cJIrgwrdRFhvAm8WwSLiWkv7uO/4MWwt7hjdVk0l+O7/fBuas9iQAZEy/uQe36V1HMR5xwWskCBfBfbM3Rl7e3Su9PHdNBkyAkd4n3JBioW/d5v2nwZj8xOZswwsSAZ5HEVr4fnJmY7HXixw7VrXaMcq/Lp3rVck4a99E9CHqTEsHYV/+Dt+bK9uA9y/73r1y1ob+9Jczx3kCSeksiYG2my8scWVx0frIiwOXLh5O3t0kxgkdW0ob3SdGXGfnrjnpqzBh/3dRt8o8Rk29db9tLIWbi9t4xMNLseXP67BUF1F1XoMygNzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+/Rt+wLVjZVlryJfR3fWbz39gnNFvAAHsPQFGpwbLU=;
 b=kAdsRoDSqybvcDPdY+Tn3+gMnWZ+yy9Xtr8ISZh1FEWry2x02VkUkkPuUtSd5vhtqfAAgNMjsQ0PC7XlG2PU1aGzy8Ikd5xrR/9ECwhT8QArnVU8yVeH+RUlsCQPrJIhH30siQOLwxLrI7uAb4Dm67EnHQ77q0wXx6dSLWdFYJQ=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.29; Thu, 24 Apr 2025 19:19:59 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%5]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 19:19:57 +0000
Message-ID: <50b62527-231f-4955-9a26-f87414cb46de@oracle.com>
Date: Thu, 24 Apr 2025 12:19:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 03/19] x86: Secure Launch Resource Table header file
To: "Huang, Kai" <kai.huang@intel.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "James.Bottomley@hansenpartnership.com"
 <James.Bottomley@hansenpartnership.com>,
        "trenchboot-devel@googlegroups.com" <trenchboot-devel@googlegroups.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Ghatraju, Kanth" <kanth.ghatraju@oracle.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "dpsmith@apertussolutions.com" <dpsmith@apertussolutions.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
        "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "nivedita@alum.mit.edu" <nivedita@alum.mit.edu>
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <20250421162712.77452-4-ross.philipson@oracle.com>
 <e5f5a76b5cc93861df23bd96642a94b7d549a467.camel@intel.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <e5f5a76b5cc93861df23bd96642a94b7d549a467.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:a03:180::46) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|CO6PR10MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: 5186ad22-01cc-4fd4-a67d-08dd8365001b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzZPcEc1QmFOcHduQzhnT0JvSW83WWgwMlpyRUlRMzVyMDBGTVlwMm1aVHR0?=
 =?utf-8?B?OGtQRXBxYWRzMmpJS2NyYTArbVlEbjZQdUlmOGtJUTh2a285SnppQUUzU2kr?=
 =?utf-8?B?V0g3dnpEN1pLTElIL212YjUya0xKa1VxaTludzZIWWpwUTh6dzE4cnFteHpV?=
 =?utf-8?B?K3lwb3p2bjd3QUZEcTVwSW9HMUtXekRBYVJ0RzNxRG1xc0dJYWhiOWVLbXRS?=
 =?utf-8?B?K0VjSjdmNHplWXhlSXNrS045V25SQTBQM2tSRVF6TnM1SVdUZDZ4YUtZZmUx?=
 =?utf-8?B?SGthR0syYlIyUWFWTWRSUXQrTEtBL0RvN29YUFNKYmZVQVRyOUFySGFqUFhM?=
 =?utf-8?B?b2JITjQxU0dGOWRaQlA0UzB0d1hWQkxOSTE0dVNqT0FVUWFkaDdKQ1J1WlJR?=
 =?utf-8?B?RXU0NGdrMFQvc1FVRExTRmloZlE0S0VFVjhMWi9PTm9Dd0NmTGFERS8zZ1p5?=
 =?utf-8?B?dkMwdHpuVjA4SUR6SGdDWWVIS0FwNnlhcEFRR2puNHdDeHRsMWlLWkI1ejhl?=
 =?utf-8?B?Zlh4YWJNMlppZ1pUK0EwOUwxTmlqU1JCQVpRb05iRTJicFVNMGRnWGhITG45?=
 =?utf-8?B?VEthMGlpbC9DVjdwTE4zWi9EdE95dXdscktYSUNxbDFXRTRPMXdlVFphT1NX?=
 =?utf-8?B?QlduT080bkpZai9Rb1BMaWk3akVzbklUZWcwUzNrb2w1eWdpOVVaNTBYOHpL?=
 =?utf-8?B?LzQ1Z3N0L0FOU3lvSCtwRVFXRmVENDZsUUgvcExOZHZhNmtacVA2MkpHcVZV?=
 =?utf-8?B?UUZqSWdnUGkzMnVpZlpOM0tXYkxhamk2VjhZQ2prdnJBdHJDVzVMeWJscGdX?=
 =?utf-8?B?Zjk3VDFiQ0MyUUhRYlI0WndyWTlXVTQ5a3psN0tveVptdXFtc2hPTkxWbWFP?=
 =?utf-8?B?QXFpWDhuNXlCSDFuR3VqSGk3QjR3RGoxWkR0ZGl4SnhKZERHSFhZNVQ5eGk1?=
 =?utf-8?B?bGZVYjdNNFF5Z1FZbnFsVFBTOElkZTlleCtreXViR0VtUUMyN3ZSSmx6SHRn?=
 =?utf-8?B?OTRnSERHd2NKY0cyekg2aU9wdFF6WldoUEo0emxUNjdBWU1qeDNLaU9IQ1p4?=
 =?utf-8?B?V1NvNHJDZHdXZWFOcHAzSm95NWh5SUw4d3VLM0VEdXE1amkrSmFETFFjZ1hm?=
 =?utf-8?B?dVk4dDMvNkxQZXZVOWQ2MXgxNnA3b1B0NWVwNGxwSVc5Wnd0WEhQd1JNUThx?=
 =?utf-8?B?ZHpRdlJkTCttbUZXdmM1TXZJdVRER1p0Z3lLeER5WFc1OE1nQjBudVZuMktF?=
 =?utf-8?B?aEFwYVI3bFEzOWtPSzdYZ1VWRUxZa2ZHcVFBMm5rZEgrNFg4TjU3a1BGYjdU?=
 =?utf-8?B?NU5MbEZReGE1NldicFZ0Q3FSQU00SkRMQm9BVlNEc1d6MUFnQXFCS0Jra0pN?=
 =?utf-8?B?aTJCUkxhQTZOVy9kTG9IQVh4YjNmWlc0RUEvVXJhUHZaOG8rdUZlU1RLSnJF?=
 =?utf-8?B?bHpOR2dVSGJsVHc4eWpzaXpOSXBJNlYvMk5GV0pyN3hGdWNkRzFCSE5jR01l?=
 =?utf-8?B?ekM4RmFUUVBTbUpZV1dBZXhFWE9BUFNRem5uZUI2RzVtT1ZVaDVTeDJNcVpi?=
 =?utf-8?B?Q21yVlhPN2NuN1BpR1FLZXBYYVJhYUQ4T0ZhVmlwYkxKclNCMTJ1SkUrSDdI?=
 =?utf-8?B?Z3dUei9PYTFvcHpIWWdOUnl2eTlzYjEvN1ZwS0UxNUltbDIvSlN5Y1o4dW5U?=
 =?utf-8?B?bkJGQ3BWcGtuSllpMzFLOENTS1JPeDBqTFdycWlhQjJRcGV0Ylp2LzNYT0Nx?=
 =?utf-8?B?ckV0eW80aEhHQ0wvTEwxZmdEYjhKY25NK1ZOY2hkdm9SRElqbDNoNTdSWkhS?=
 =?utf-8?B?UlZDL1pqbDlqRWl6S0hZbWp0bXpmTHlOTHgvZ0ZpK2RBOVE2dndRaStnOExV?=
 =?utf-8?B?QUFvdmcwcFFtNjlhSXBqNVIyWUNyOTVvalVCQ2JCbURHQVR3MmtxMkVraVVj?=
 =?utf-8?B?a2h6LytQRTlyUjRXNGVBM24rdTBOU0JlUWdvUjAzaHFoYXU5N3Y5cHpQZmdS?=
 =?utf-8?B?a21tb1U3cDhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0QrYThrNHg5a2dLR3ZyVHJDcmtackRxNjVNei9oZDl4d21qellnR0ZXSjBU?=
 =?utf-8?B?VThMVGMrWVRnemlBZTM2SG16N0ZKSzZzTHRlejUveTlydmRQNkx2aXRReVJB?=
 =?utf-8?B?SmFjSGt0YWtjME15c0M4Q3IxNDJaS1dDelJaVXNqL0pvYS9OVW1MejZROFZX?=
 =?utf-8?B?UXErV3BVSTNCcGVaM0xTRzFqSlYxT2wvZ1k5dmtWczBrWVJMYnZ5OHhMTXdV?=
 =?utf-8?B?RzhGdEptdFE5cEtPcVVoK3A1aTIxQWhRK0s1eFdqMHM0Z0hqSWRxRW5FSDJH?=
 =?utf-8?B?aUJBODVwUWxYaDg0YkhWTk45ZUJVdVJCV0hKYkRrajBRUWFJYzh4ZFIwaDNF?=
 =?utf-8?B?c0Y3NGhrbmI2aVpkaW9LMlcveXNyWW05UEdVNWZmSGNLTXV6UFFyZkRkS3o5?=
 =?utf-8?B?LzNFQXBrTWhIZHdLYkFWdDMwRmRQRzhpTjc2NHR0UjU4RHRMWWg2SHo1dVd4?=
 =?utf-8?B?SzNyNnBabU5rTjZjSk5QNVJKeSsvazdaajNXaDVYbU1ja0VUQmI2M1E4UFI5?=
 =?utf-8?B?L0h3bFVwTnU4SW43dzN2bVF6T2NvOXJJTHVuZUh4NjVFSWJ4dGI1UXBmTWQv?=
 =?utf-8?B?cVRIcEhodC85c3dLcUNwb1Fnd3cyb1VESkhRREw4aFI0SVFLbEcxY0F4bnlM?=
 =?utf-8?B?NTRjSEo3MXhwaUVIdmQ1Y0NhVHVROUJaWGZCZ3BPcVFBZ0xjdVBjaG5qcVZ3?=
 =?utf-8?B?M253M3lIWElZL1pEMmZldHkwMHBoa25MekFER0tPZHc1TGlwZ25kWW5yUFZo?=
 =?utf-8?B?TTYzTGNNbEJ4OWh2T0VuK1FlL0FSd3d0eGhSZDNCak5BS25pWGd0a09scjUy?=
 =?utf-8?B?Vk5OODBpSUhMbjg0Vm5xWWJNMG5zZzRXVnJZWWR0WC9GcFcwK3MwRzRUOEh6?=
 =?utf-8?B?ejErc050NWwxbFd2UjJvY1NpcUhmS2V5cVRqZ3U5bm9nTXIxalBjQXFQWEJs?=
 =?utf-8?B?Q052YXUxZ2tEQUdjZUpYQW1TdTJOSjV1MzkxZitkT0lQMzg3RnpsZVNMMGNW?=
 =?utf-8?B?N0s1dS9pTFZGQ2RhTEIvOERKVmtJcDFSQWZtbVRobUI2WHFwN1JVQW8wMGtQ?=
 =?utf-8?B?RHdtTllFR1pRQnB3dms1YU1yZ0lzZFVPVHU4dmNJeERiN1duV2dhUUh5NUMx?=
 =?utf-8?B?dHlvS1ZFZzdUOVNJRFNCbmwxQWZYVWZRa2FkTVpHL0NFeXVjKy9OOHRxOHNr?=
 =?utf-8?B?UnNMQ1pjeFJKM2NlT2lOYnMxYUNndEUvZit2YzNCWE90cHJxWVZWeDdJdXg5?=
 =?utf-8?B?VFQ4RStlQnFIWlZQdG03cEJBcnVMcmxseG9ZKy9XNTRkVmtjK1pJWXZHNFkx?=
 =?utf-8?B?K0FaeDFac0FBWGhneC9TMmdTU2NGcEFSWFNxUVluZHo3a2djMFU4bWFueGtT?=
 =?utf-8?B?SFpvOG02MFZtdHhzUUVVUTJRS3BsMFFtNGpaTEhFTjlybGh6VlBqTzMvUUZu?=
 =?utf-8?B?VlNQV1haOVVCT1dnQ1crdlNsOXFkeTUzUVIvL3N5K285WGd4Um9pdzZCL1Vl?=
 =?utf-8?B?SzBmRzVOaSt6dVM0U1hwckt0ZSs4VGR2Z1ZObHVuRVZWMFVIUmJNcmFNU0Vj?=
 =?utf-8?B?T3QvaHE4cno1aTE4ZHQ2M3Z2M0FnUkswblp1bmh5OTNzenRKdU8vVXRsNEJi?=
 =?utf-8?B?YUZhd1QyN0N4R0dhTElmT1ozclVKdW1ldFc1azVvUEwwT2R2bDZZam1VK2pq?=
 =?utf-8?B?Y3ZoVWpHMEkxY2RZcXNOckFJdEVkMjhjRDE1eXgwRWp2UVNYSDc1ZjJySld3?=
 =?utf-8?B?Q2Uya2J4R1AyN0kwb2pweWRQOUFZVU9tTEtvVUpsd2ZzaERPQXVySnpIQ1pL?=
 =?utf-8?B?ZGlPU3g0SllxaGN6dEEwVk9VM0l0UXFVYkhuSFExdlRRQXhZcTlSd0o4NUxB?=
 =?utf-8?B?d2p4Um1ITlhSV0lqRGxxdzQ1QWxlTWlLY3oreUw4SmptWm16U1Jqa3A3NGs0?=
 =?utf-8?B?QzcxSVB0TGt5dDN3ZkJ4VW42M0dLdWtmUXZrbWJYQ3NzZ1p1RS9JM0RiSitV?=
 =?utf-8?B?TThiaWN4cG9kR0RiS2JEZ2pBQS9KQ2Z3eFMzQ2JzUkl5cDB3OFZYQkNLUzU2?=
 =?utf-8?B?WEZRUE9sbEtBazc0QVB0Vm1ibGZ5aHlrVFFmaWk0SWFkZ0cwMmNRSWQyYWdr?=
 =?utf-8?B?TWV5N0w0VFErcG0vY2V6eXFsd2VkejBzcUJCdW9sanExN3NkeXc1akpOTk8x?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UECEP3+178D9Kk9rs4sTo6RRUEIcVPDrE8b+bpSsmHQKVJhOk0DSDuZR9dfwT6FiE2kjhRKqhdlTe5neqr/gF4cXKzgBiGeGiRxfa84Avwfkc4vViuj50ihF9KEGDr+UNubY7sGSGxtAWV8DBISa0jUywaSELQmG0lA9hu5NP7GyrDFgagH7vp2zq3SGvgDWcFEBDiswSnZbi1VLdgcg5wTBasRmoawOqYKa9LVCO5T+8YJaJqhvkWNd0C2QFkgA1HXB3n91vouMQvhC4BW4tm3WTf4BH25e0xzMVY81BEwKj93QvtO/RhKwOEcuX0TQk0v7+ZCGD2rS/mYTXTiy/V6ikCTGcwgxq7JWEvTJADtxi5F1sTzGVA52iN0EhjLyN1uqVDKdaKOxz/wnCA3BC1jUMF0WShaUO1mCcF9xPfZNYNK/1iTtmRx5Mah9mZ2b8yaOKVtjDCuQK0cjq60vOL7+EZfhM7/frBiwe9Ub/lA5xFKT3MXxE6NsOva/buyk7I50oO5gcC7N9FlLXhwK3VokR/tQZPIcIwpbiYsi5kS/A3LxqXECBopCozBI4CI9J4Ftjb5wOXD+7KFRBeO9N4oXgxXnhespd5HvBw23LKs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5186ad22-01cc-4fd4-a67d-08dd8365001b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 19:19:57.6614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gkQtS9EPi8StsRnOHhpHYf+yLH2SO+sn6jHYlav7w9KaSWJdDmhEF80i3mZKgACdPMgxUAjsRmRkwoISrCcaav5G83AwBMOVHtQ1kH+f/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5635
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504240134
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDEzNCBTYWx0ZWRfX9meB3vQhH06h m+wJjaQGwz7ddkLkn+IVXxe+fvYGfL7bdJix8KiKDMcnhwBc2epy4WfIx30b7jsmStqDGf+yFyd ou0Tfc0XO7m/wLiDq22XvAIJSS9qM5qn5sCos5zJ9FfDL1v/yvKchADqMcNdHL+fUZu7GjCJtjh
 0FEd69BSiqypBkLDQLK3bIQne5n2KfayZBM48WfkpkE3ddhOIRQ2P32l05NjdwRI3P1+TDwkxGz l8PomwNQAoQqQNbjninEpujSIKGL7NSfMwn7uQXa/mSuVl7Wj9sXhySkuagXBdssvSfyHOSuJCr pBTxzQWMntR7nFeE+1TjEBuJy1WCr17G4L8QtCNWVes0gHZbRr2xqjbcpxAHaMpqvdwIoxNCXaB +19LUsyI
X-Proofpoint-ORIG-GUID: Ogh2HonSBIHaOVahOk6rN7bRT9ZAxaLf
X-Proofpoint-GUID: Ogh2HonSBIHaOVahOk6rN7bRT9ZAxaLf

On 4/24/25 5:36 AM, Huang, Kai wrote:
> 
>> +
>> +#ifndef __ASSEMBLY__
>>
> [...]
> 
>> +#endif /* !__ASSEMBLY */
>>
> 
> A minor thing:
> 
> There's an attempt to convert __ASSEMBLY__ to __ASSEMBLER__ at tree-wide level:
> 
> https://urldefense.com/v3/__https://lore.kernel.org/lkml/20250314071013.1575167-1-thuth@redhat.com/__;!!ACWV5N9M2RV99hQ!MhSEDY0kYk37uZxtStR43EmL_ySswhslosStYlSCe97P72GzkHTmhJQsz9okEBy6HDQOCAWJkyV7mvRkYcA89g$
> 
> I am not sure the final result (there's some discussion around uapi part, but it
> seems there's no objection to changes to the headers visible only to the
> kernel), but the x86 ones have been merged:
> 
>        x86/headers: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-UAPI headers
>        x86/headers: Replace __ASSEMBLY__ with __ASSEMBLER__ in UAPI headers
> 
> So perhaps we should use __ASSEMBLER__ for the new code.

Yes good call. I see a number of those patches to switch to 
__ASSEMBLER__ are already in.

Thanks
Ross


