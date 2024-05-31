Return-Path: <linux-efi+bounces-1122-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB538D66A4
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 18:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F221F23ED1
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 16:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C2C3D57E;
	Fri, 31 May 2024 16:19:18 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD84768EC;
	Fri, 31 May 2024 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172358; cv=fail; b=m4yqiMsHUVWUBvf0B76b4VilHFS9Zl7GKnpzqZFv01iTrzJD5+dJDIlRC+b2Md4rBALpU+GzIE/oxAJQwGcSVG1hu+YZqw4QF4S3QrX4ptAZ1Uc/AUPiaPAGSKpSy7nS5oykzhgGU8ckGMFrINKrJEYOWu1BCZLGT6q/kq3LMG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172358; c=relaxed/simple;
	bh=NLesgijmZ0EBSkVrOTUyzx3PFBcSSbQDhy9hXPL1cYw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BVKGZ6P5cfx9VEkaNZs8gvTNnEq94u3rYa0s5VLmkQGi0YMyTz3CQFu9CojCnQiqlVH1BVzStZKiFC2rELS5X7aZ43kyH5s+dZD85pif/Ths2UYF1tLAyvbWy07Jpfa7byiHBepNfa7sm6cCWNm+kSt+ygRU3Kkv0qL+jke6oJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44V9T9UG006919;
	Fri, 31 May 2024 16:18:32 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DRDzr4cCsPEx3TbqMK2uzNHlhsYHQDvn1DJSyeURohs0=3D;_b?=
 =?UTF-8?Q?=3DlA3mhauIbj5eikWLyhZMGl4gqqHYp7fm02De5A3fzDHJxQZwS0KyBSeTwYFj?=
 =?UTF-8?Q?bSjADM2X_rlULLez9PaowxGLlJwClW5Fx/cU1qLGEYmOxOJY9U/Qw5WzTmJV0ef?=
 =?UTF-8?Q?Zx3YpJx0qqCC4S_h7UTrF7u380JKA0jIDFZ02Oa71dNgtM7/lF/0F7JI+x+zk3I?=
 =?UTF-8?Q?TdviXApq/uZOpdQtX6N4_cEku8xUMUOeuO2cIjmJwTu8Ntvw0jSEhVGUQLhjyNr?=
 =?UTF-8?Q?x/GwMfWphGhNr+fBK41qpA1cOR_rknDaMBfeRL6dRouC1XaUKEuUJUHWEF+sIpy?=
 =?UTF-8?Q?xyvw8gYayi28CVmN8RfF0xDMQhw5I2B+_mA=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g9uqak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 16:18:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44VFSVGG006248;
	Fri, 31 May 2024 16:18:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yd7c8k35n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 16:18:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mH9HI6QwNloOEhhWKJXV2K+EVqI/LPj0k+cH+/KCMudoaF2J2mJdum2RN11IOIzLZUcXWN1KocIcAGHN3rgQgwcRDbsUCMzda7+DcADDGhFyWacUhkz9mQdATthB4Mnmd4Ns4vdglQRu7oVSJJL6cBGtyixFzPB+64ydukl0EGFhn1FXjXW3ajpRlRDl8jF6C7cByQx8C2rTodWfCQDdbahGGJTmSSV70gXzTPmODmRCVuiqORXI+K9q9IgGoiBo8FuEOxa8njgXE/y0OVjIAOjWXF91I6DDRsLZIG7e61gVQOal8aa3Hxz7xE2vp0Mtn4LjAECt0YoA8ecZQFs7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDzr4cCsPEx3TbqMK2uzNHlhsYHQDvn1DJSyeURohs0=;
 b=oIMfokx3v1UKACUuTHzoLwsA9qEcxFppDQPRs+dZiJ7UxBga2uYiS3JbJnAptW3sIdLYlam5Bs6+uomXmBTqJiAL7HVgk36W/OQaZvhw/nW2eb4pO6TrXHbbP7KYwq1JYGax/h3ItJlaMK5US6uKqwZBvaos9yc+Nzp0pHaOLeW+l8qvaC+cueEZJsk4z37uSbv4wchRLFQfhbfHdCctdYTQdI1Z2YiqjqdCcOVqJQVOrcTEHpUmBpbrYdNI0lFsZma8cePHisX01W5+sBGWpfAwEIIEIj7tL4HOzJ38YpD2QuCe/xFv0dPQLmC+GRUanXpT5Dyy6PQWzj3Pi1vtlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDzr4cCsPEx3TbqMK2uzNHlhsYHQDvn1DJSyeURohs0=;
 b=JwAItvmc2wuv0GlklVTITztfeO/ISexFsgXXxaCzqR5bAmXc2xIcvaIkE9vtgbvnbj6OiHfaOOQfMhDXeqZjH99jXBncYVCJAF6rJE5SPOT6szRF+xjGtrR5tHtd2WiGRc8CdpQMuzvnivxAuoYl9BRWCL0C580Dr7jlyhu13/c=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 DS0PR10MB6845.namprd10.prod.outlook.com (2603:10b6:8:13e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.24; Fri, 31 May 2024 16:18:17 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%6]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 16:18:17 +0000
Message-ID: <e2e3df20-13b2-4883-8d0a-bd561ac43bc3@oracle.com>
Date: Fri, 31 May 2024 09:18:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <20240531021656.GA1502@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0169.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::24) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|DS0PR10MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 7838f045-fe1f-41af-6c4f-08dc818d4788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Z216WFA2SXkxRnArNThEbXVJUlFjSW0wK1F3eExuU2w1MXYxa2IzNlhvNXRo?=
 =?utf-8?B?eks3V1hIL2ZXblFqanRpOHhKMkZva3IySEE4QW5qek43c0JaQktUQURyUzRG?=
 =?utf-8?B?NFBRSlZwaFlNejZFNHZGNk5ZU211OUxyQUFIMlZSOEZpQjJ5Qi8xOHhGSkFx?=
 =?utf-8?B?c0tGTnRaYW8zLzhaVFBwa2lmb1haWGtoRWk0ZUFMTDU4bHZYK25JMFIyT0x6?=
 =?utf-8?B?eDlGUW5FZGEraXcvVFl1WHJTSVpwRFZQMVd2Y3QvcVJTbFJGVVFRSlBOUkhS?=
 =?utf-8?B?bDROMTJMeE9UNVRWZ3JpSjJORWtaK2UwZmtaNDZhSFdnRlF6dmJXRUFjL3Yr?=
 =?utf-8?B?VmZXUHNVTUdtTDlWU0xaWEtQelJJZzJwRXdZTjAvSE9DR2t1S0hmNEwwYitL?=
 =?utf-8?B?aHZ0ZnQ1alpLWEFuVWZjSnNvS2lIQzBLY0F0dFZJK2FPVm9JNEtydUtDQStt?=
 =?utf-8?B?dU5uUXZERWRaa1NwZ0s3Y1BaMFNWMW9HODE3TmE4cVREcWpjUXVQSWZ0dXV0?=
 =?utf-8?B?UjVZZU1SaXFsNGVkTjVmMHNCc2tMQVdVWjZVLzBuRnNlL3ZoUUJpZkxJQ2hk?=
 =?utf-8?B?M2Nmd2d1S3hJVUxOMklUajdzZnN3d2IrajJ4OWFYNDg4bWhGSGVydXRMaFg5?=
 =?utf-8?B?aXpLc0ZGM1ZIZXRLUnkvK0NFV2FQOEhqeEp5dXJTVkoyZkgyZGdHWXI5RXVy?=
 =?utf-8?B?ZFNXVTBsamF6bjBhUytxQTBKRXRxQUJ0MDhhTUdHYktibzRwN0lRb2syN1JC?=
 =?utf-8?B?UkRNUnJ1WEhSVTZUL1U2Wk4vY1VhOERKZG5PRGlmUnpTRlRHbWxvdS9zY0l6?=
 =?utf-8?B?RUVkTFFHYW5nbjZqZWNZcFFuOHh4Wm1zVEs3NVB3RWdZR1BPcGJKUWJDc3pn?=
 =?utf-8?B?V1VUc1pFdHNEZU1HNVFHMGE1djBOOGI5NnJickhxRnJvU3RwbmVYanQ2ZTI2?=
 =?utf-8?B?UzlrWWVOdjJuMHk1eHZxK0lRMHJHNzJiM2loa1J0ZForTHhGclVGYzN4d3pI?=
 =?utf-8?B?WlVJekFzcDU5RnBNbkk2TE9LQmxaU3VIQmlyWVNNd2xPRHlmRVhiNVBTUTRD?=
 =?utf-8?B?OFIzeHFHVDNpSHlGMzBnWGt3Wi9sMk5WUGtzemlDWGdOVWlTcHV6MmkxUkR5?=
 =?utf-8?B?WWJ0NzltVVBDeHFra0FMZGtEWHBhd1QzTDlEUUJWMTNZcWJ5MHVSWlBHSUdU?=
 =?utf-8?B?TnhNeWtGdklyU3h3d1RERlpvRHM1U2JOSGRWNmlhd3YvNTBZNFpYa2JOSHRh?=
 =?utf-8?B?WVB2UzZhVDZpY09sZ2pPYUVTbEJsVGNqU00rdXhUMi84ZEdWeS9GZ1EyRVlC?=
 =?utf-8?B?QVp1Q3hUWG1weUQ4d2hWTGhSY1M4Yk5QanpDRWpwL2pxUURUMHZYUUhva0Nt?=
 =?utf-8?B?d2JuTmZHd1dPZVkzZDlJVWdBN1ozSzJ1MkR0WEphM3VLMnIwVGZIL2xNSGlN?=
 =?utf-8?B?dHF2WFNNL1NsU1IydHVmUVBqYmtMMXhWTE85TDFxZVoxakE2dUorYUJHQ29Z?=
 =?utf-8?B?eEZ0a1JFeDdWS2drWW9vVUVzYVhCdWE4V0NDS1NDR1RSV2NzR1lQZERXZnhS?=
 =?utf-8?B?ZnJWN2pYZzQveFozWTRuTEJUcEtBVnZUL2MzbGd5S0VvaVJjTjJlTW9jOU0z?=
 =?utf-8?B?OGVKRHBMVlRLdGdvMm9XSWFVeHgvamVaKzhxUkNlOTZLNnhGRHZSME9BNUYr?=
 =?utf-8?B?SGREeitYbmczcWU4aFZYV0x3M1BzZUgvaDQ5ZnZJZm9ob3lMQ3ZtZ0d3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K3JIWDlqV2s2N2Q3eEVkNEppOU1YYUY3OEVUQmFDRmsrdnZzWlpUNnVTY244?=
 =?utf-8?B?NGVKc2h6Ym9DTWk5ZXRURlFKekUvR1dpeEpSb21VNXBHaVE0TjNMWGpjeG5P?=
 =?utf-8?B?cGpxWHIrVko0WDd3TUNnRjVGZHIxaUpLMHJ4cXBZTjBwUjlld2JQN3NMdnNJ?=
 =?utf-8?B?SkFtK1dVZ2pnRnlBaERnNy8xRW5MVC9xdXNUVUtWd0oxaGVaOExLOVRSMXNl?=
 =?utf-8?B?ckRpUnJydk05Rnp2WS85bUgxYmRiSXBIYzZkT1FLaTRuc1psSEQ4bGtkME9u?=
 =?utf-8?B?alRtRjVvM1dpcnNpa2dhTjFndWMwc2tTK28zdDFLNGhLMk8yT211SGhYTS9S?=
 =?utf-8?B?dTBFMjZsZG5ad0RSNDZVb0Z5RGNWV3hNSW81eXNKRGY5STAydGlTcGU3dUp3?=
 =?utf-8?B?amkwbno4Tlp0eXFNRGJkK0pRczhXVGFxMG1pL2tRK1FpdGtFaWhka3dQc0Rw?=
 =?utf-8?B?Q2NSK3d1K3gzUlRLa2tnWFd5UWdCL2xsRTVwS1dydEsvYzgzYTZ1Yi95OFpY?=
 =?utf-8?B?UEhCNkdmZGRkK2F5bXpFRkg5cHNrQnNDbURZdXRmZG9yMktOYXFqNjFUV0Va?=
 =?utf-8?B?MVRqamZuYTRpQlV3WnVmbzFFQ042NkZ3YkY1bnl6dExPU0twUWNhOEtURUUx?=
 =?utf-8?B?VTdyb0tsSjN4Q1dFN3ZVWTNjR05sc1NTbUhibFg1bUlZcURDdWdKd2FoUnc3?=
 =?utf-8?B?TzZFM2dpcUQyeGlYZzF4SFZIakxBM042Wi9CTmhFNkhMSGNtaWUrZnk0Skoy?=
 =?utf-8?B?Z3g4YkN2Nno3cVFkbDg4YXZBYjZ3UTVOa1dEQXFBZlhNQThlQkE4Qmgyck54?=
 =?utf-8?B?NlQyWVBJMWZOakRlRUFRWnZsOUEvSmNBSmxhVWl6dHQ2YmQyWFhsSll2ZEhO?=
 =?utf-8?B?dGFieWFoa0diRnBncFR2U3ljSTkzTzZsZHRyNG5EaFFLY0YvbE9sN0ladlhJ?=
 =?utf-8?B?cFZicUxicnl4Q1A0dDBGVTFoQllwUEFQSFkwNFBQUVJ4Ui90UEhFaHFPTXZS?=
 =?utf-8?B?aHBTQXk0aExTaG55VVlldE5JN3lqb1NFTGRDbnUrQ0grNWU5cWFxMXJ6VVJq?=
 =?utf-8?B?UXV0RkJXZFlNazJKbVZxQWNFbXdrTnkvU3hrMVdsbU9oOWFSTnU3N1NGaE9H?=
 =?utf-8?B?c1EyRFJGRks5Zm5SeURjT2pJczBJS3V4Mkd2MFJwOFJiTkoxYVNiYTNLcnlG?=
 =?utf-8?B?a3FvMlBTSjJ2RXZWaDcwN1ppS05UZ3JLTjNBWGo2M0s4bldaRnhQSDh5N0p0?=
 =?utf-8?B?WGZ0M2tYYzVZTmI4aDdWYnU3WWVEb0RGdWVnVU45Mmcyc25oYkNUOU4zcHRv?=
 =?utf-8?B?VlE1OWRSakNlcW1JbDNLV29DczJyYmZMZnM3R0dIb2JaV08vZXh6RENEbURO?=
 =?utf-8?B?VmRvd2Z3dzlCeWUraG9kVW9lUTJDT1JHckdTYzBHSWZIRWgrblh3OGRsRmxh?=
 =?utf-8?B?akFDTFRqbWhYWFovdWZIVzJ2eGFOMVlRUGhPQmpFaklBZWpJZEQ5VkFtbEYz?=
 =?utf-8?B?TUxHK0JCQ1gxNDRwYWVhQTF4NE1BRy9td2kvQTErQ2ZBTTlCS0hDNDIrODVP?=
 =?utf-8?B?ZTFKOVVrbysvRDU4M1YyQkRjREt0MkpnbVVpQUFsd0Z2MW11bGtsaXQ3aHhx?=
 =?utf-8?B?dFpOTXA5RDVvdExZVWZWb2tKMGV1VFkxbkJHYURLTVM4Zjl0MlNVZksvR2J4?=
 =?utf-8?B?ZndWc21NbG5Xb2NwSmlIL1UveDYraDRySTJibm0vWk9rK3llQjhwekJjWmN6?=
 =?utf-8?B?U0szOHJSdVJiKzNFUVhNaHlWMUlYYXNHL3FUcTdSdVY1d2ZzY1V1bm50Y0pU?=
 =?utf-8?B?SVIrQ2g1aENZVzYrUWozY3hCMkxxTGhDWkM5RmNnZndPMXJhMXFwaHpkSDJW?=
 =?utf-8?B?bXE0eXdwakdFeDB6dmhrWmw2TVBxNFQyRGwrMmFadDJUd1FLWkdxemZSMEY5?=
 =?utf-8?B?YzBYUis0YXBhZHpacXJwM0FpNWl1YXFBeThUcGJPSENBNWZNSVA5N3hGUWRH?=
 =?utf-8?B?dDF1TlBLMmZRa3ZsSkZJZmQ3L0JhaG1BaEFOQ1JxWUdYMmFlNmhkcFpQZHRs?=
 =?utf-8?B?RzJ5Rk4rSUF6MVlMSVM0alg4dXhlYjlkbFcvcmZuNE1qd01wb1ZyRjBuN2th?=
 =?utf-8?B?RzFWczg4ODBuVmdaOFhUa2dOdDRwL2pEbVBQL3Bqb1hCV1JzNHQrOW9kRTd5?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gWbX1htP5+7Cxlg9TF+wjAxS1FlhUurYgdecBtz6l9fuKBmyvT8Q/+95bWAgzfomiJdYttHVk5a6pS3yNiWv5n+0uQwOcpAUchpJ0/a2NARcqDV9AzE7e6mbOuMGfIbVZ+RzDz1j/DI7qxO/fpFNpqbnBpBUwGaayK6i11AoXXQKN8oNDyYG9P+M29GZikc4/l/QO9tdvHl3nx4lbuluxL1hfhNQ/1hfAgXZCrAd6q3h25SO9XXz9zA+3B5ZSPTNZ9FlDp2i7Z2pTt4QgwP58vdQGvuF/GU2e5QN06pvg+Ypc7vjPHBuO3okZi2/gkAFl1Xlf9174y3WoibDPi6ZD4qldrY6MUaSO4AjndTyTLkuF2uy6cwX9OMR7VKYScT7uUuI1Y2+kp1NONPXDGIvOWKZ/YfXQIm6ffyls+pAQQ9Eii5O8XQKNbKJG9wIQbtKiOz1zGOzGmGGjOuFQ05NVKAn5DYOu33aa2gOaw3lW/sA9H+IKmhOmkbIJIgi0J+aTw5x4qbfH1TsOMKYm76TpfPmYLNcCIUOXTYO5KpKP0ZWIZA/W3zaVOGAxz27ufIvRop3TmcYNg9208exG+X0KumKz7OVgzPIQkHpFQLrQIY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7838f045-fe1f-41af-6c4f-08dc818d4788
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:18:17.1851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWCwz4rh8/CkShWVEznih20ygQAMpVwer6lhiQFwyhX/ytvnpmNlsg+xi8/USSlArBarKNVbIXhZE05zFCCBkkZkn6rO7zVtB0JWFJYtmtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6845
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310123
X-Proofpoint-GUID: HQjBpf9v0VxXyeeD8BjnW2901M_Ak8IU
X-Proofpoint-ORIG-GUID: HQjBpf9v0VxXyeeD8BjnW2901M_Ak8IU

On 5/30/24 7:16 PM, Eric Biggers wrote:
> On Thu, May 30, 2024 at 06:03:18PM -0700, Ross Philipson wrote:
>> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>>
>> For better or worse, Secure Launch needs SHA-1 and SHA-256. The
>> choice of hashes used lie with the platform firmware, not with
>> software, and is often outside of the users control.
>>
>> Even if we'd prefer to use SHA-256-only, if firmware elected to start us
>> with the SHA-1 and SHA-256 backs active, we still need SHA-1 to parse
>> the TPM event log thus far, and deliberately cap the SHA-1 PCRs in order
>> to safely use SHA-256 for everything else.
>>
>> The SHA-1 code here has its origins in the code from the main kernel:
>>
>> commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
>>
>> A modified version of this code was introduced to the lib/crypto/sha1.c
>> to bring it in line with the SHA-256 code and allow it to be pulled into the
>> setup kernel in the same manner as SHA-256 is.
>>
>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> 
> Thanks.  This explanation doesn't seem to have made it into the actual code or
> documentation.  Can you please get it into a more permanent location?
> 
> Also, can you point to where the "deliberately cap the SHA-1 PCRs" thing happens
> in the code?
> 
> That paragraph is also phrased as a hypothetical, "Even if we'd prefer to use
> SHA-256-only".  That implies that you do not, in fact, prefer SHA-256 only.  Is
> that the case?  Sure, maybe there are situations where you *have* to use SHA-1,
> but why would you not at least *prefer* SHA-256?

Yes those are fair points. We will address them and indicate we prefer 
SHA-256 or better.

> 
>> /*
>>   * An implementation of SHA-1's compression function.  Don't use in new code!
>>   * You shouldn't be using SHA-1, and even if you *have* to use SHA-1, this isn't
>>   * the correct way to hash something with SHA-1 (use crypto_shash instead).
>>   */
>> #define SHA1_DIGEST_WORDS	(SHA1_DIGEST_SIZE / 4)
>> #define SHA1_WORKSPACE_WORDS	16
>> void sha1_init(__u32 *buf);
>> void sha1_transform(__u32 *digest, const char *data, __u32 *W);
>> +void sha1(const u8 *data, unsigned int len, u8 *out);
>  > Also, the comment above needs to be updated.

Ack, will address.

Thank you

> 
> - Eric


