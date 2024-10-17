Return-Path: <linux-efi+bounces-2000-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7E79A29EA
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 19:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EBD02822EB
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 17:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52A61E0B74;
	Thu, 17 Oct 2024 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c0xEKjbG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZFs8jTJg"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100C51E0B68;
	Thu, 17 Oct 2024 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184145; cv=fail; b=mwqhCOO7eVWFe/4xEGnHPjcxbMw/MKnWyGMdeWjpdck1haapwH08k6YejJydGdR5lWwP33AVWAnXMrmnPD309lTbbJlYQYQxLKvVJ9rE1cI5ZWdAIPn38lioGYg1Bti4kqHEBSBW8Lb345t3Im2wX3FP9meq62AiLqjQjCzbUw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184145; c=relaxed/simple;
	bh=ikhIPUp/Tw6ZDwjWAuDfdRA7JXVdatIIkuu8S105zro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ppduueAOFB0QiUIIDVDNOFbnY8333irrSzw8FN8M+lIr+EElOjSlOc66zjb5K6QBljPoIz5wksPQa1O8a9H1qSkMkgnmtrkJ+vLBGj656KtpG4Tz8KBEDLbrBoXLudzUcXRMNqN3EvmxVwFsBrGQfelwa+UeCahrOSwn/py3rEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c0xEKjbG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZFs8jTJg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBdEG025043;
	Thu, 17 Oct 2024 16:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ikhIPUp/Tw6ZDwjWAuDfdRA7JXVdatIIkuu8S105zro=; b=
	c0xEKjbG9JEmjwv5bjO9TxZFNu46qGa3Ku8rUxxGHuFMYnKZshrOUUs24gQvrojn
	r6pmxDIZDeAfvDNkpXlvF0jYeM8MfB0YC8QwHRFAC82aEtx3eYkuqEmGj/a6zf/6
	lrxDuFH5KGZMNghRdzCH5KjXyw7Em4Fpg7vFyRZ+gJ4HuXhiegx0sG/+SHi/2/ZP
	vQvL6Lb+N9iWZrPVKyxMQJCilksY1pp1/abTrdRUs6oOopISVaS5MLbv2+4N4ahM
	q1DaMWQP1cFZlwQSVes4D58tXLaw5EsjfzsZok/Vmc9ioXOPEDQZe5nT1nmihkOc
	FBxp/9v7a/m2jBde2iNNsQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1apqmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 16:50:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HGnYtG010979;
	Thu, 17 Oct 2024 16:50:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjguc1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 16:50:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IX08TkhqF+Ikflt5QWACNXWY0G3oTki2fBvAoiowcseIZQb3Wtv1D4H2HNx44y9CWW2CpXU0H7lY49Pq0xoy9/OqdaMBSq0G0m+b7wJHYCXTYXH1p0p3yAgNSD7iHBwJosFARD/S9ip4IzewAVeIJgrKwktiJtJBFdRnNSU/7xoSVsEU2mGnPqtgcDkXUsxAqVZl2xesEugN8k/ldOBb40T1+Y1dBxihwgWvBP3GNkg9a0mRgUONG42CcTrnJouLpzWdxkCMGt2HYaH8tNpz2pB8sgB9I0DcHwK9tP0Q1/MiwkQOf4xz+QHVrwePSZruYvdc/xpy0VFkUTxG8dAI5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikhIPUp/Tw6ZDwjWAuDfdRA7JXVdatIIkuu8S105zro=;
 b=I2Bzw6XUYAeyPswr7x6bMxNLGZ7VQlAwFWwTomf/ZkrwRwlhUrpNSqc6cmahcVUeoUjDQnFj5lP+JsXXvYDj5b9pH74wj4lfFby0esNuck3bKwH6tSBLir/17Je3mIaONtBpfNvRyUJV9/IOQt/FpfEc7qc2atVnP9I2IMj4hgm4bhCPSKYzPVkni4ONEaYzAN6TABfsMkT7TdIOImLjqa7uPEjKzMgFxZ1jFeVWznTu7Q2l2OaHh7ip106VE/Vnza2eSaX/29tX0xRSODjeywfhOBBZmGemoF3ujvL8+78rE6/8UhmdLAearoy/XG7LcqQQWp4X1kzN6zXeN7NCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikhIPUp/Tw6ZDwjWAuDfdRA7JXVdatIIkuu8S105zro=;
 b=ZFs8jTJgAqz0UzcL+Ll2BvZGIfRWjKn0xOWQx6EYWNEybJcsn4zfyH4mkwsE0wudJ6odkTRCMfmKOKuOghR5VS7oHUmhbWWaGeBW2gHnlwycGtzum/S8liyAQvpXlutXcL2ioSgjcvRSP90b4HTwVRsxBiEdrcBwwTCcYFDOPjQ=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by SA1PR10MB6343.namprd10.prod.outlook.com (2603:10b6:806:256::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 16:50:10 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8048.017; Thu, 17 Oct 2024
 16:50:10 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
CC: "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Ard Biesheuvel
	<ardb@kernel.org>, Paul Moore <paul@paul-moore.com>,
        James Morris
	<jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar
	<zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?=
	<mic@digikod.net>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        Stefan
 Berger <stefanb@linux.ibm.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        open list
	<linux-kernel@vger.kernel.org>,
        "keyrings@vger.kernel.org"
	<keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>,
        "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>,
        "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>
Subject: Re: [RFC PATCH v3 01/13] certs: Remove
 CONFIG_INTEGRITY_PLATFORM_KEYRING check
Thread-Topic: [RFC PATCH v3 01/13] certs: Remove
 CONFIG_INTEGRITY_PLATFORM_KEYRING check
Thread-Index: AQHbIK0F7XGLtQUKx0Oz3ggNi2kbKrKLHZ6AgAAKOwA=
Date: Thu, 17 Oct 2024 16:50:09 +0000
Message-ID: <0935469D-35BF-4AB6-BDC5-C54D90368092@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <20241017155516.2582369-2-eric.snowberg@oracle.com>
 <213ec040cf30ad8af6ea9706b10ced8219f6e3aa.camel@kernel.org>
In-Reply-To: <213ec040cf30ad8af6ea9706b10ced8219f6e3aa.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|SA1PR10MB6343:EE_
x-ms-office365-filtering-correlation-id: 55b5fddb-eb6e-493f-6c6f-08dceecbc329
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1RCbzA4NWhqMnozYWdmUFV3TWV0OFFKMWticmtHVG9qdDZ3UDdDUUtIQ1Jo?=
 =?utf-8?B?SkdlZkloeTU5ZjFhODZYUmNIWUxhZUxYQWswVFV0U0FVMmFFN21VRU0xOVRl?=
 =?utf-8?B?bHluc1krNzBFMjNKVm5RR21BdVRDcHBBL0s0Wlp6Si8zMkhvKy9JYnFZMlVX?=
 =?utf-8?B?RTc1SU9qWTJXVmo1WDhmbkZWSlAxRytwWUNwZGV5Yzc5UHZYanZ4YnhiSS9r?=
 =?utf-8?B?S25YbW9DMUhpZ3VtUUd1bnhOTVZMR3RTK1dOMWNMS0VlSnFWK1owNFZTb0Y5?=
 =?utf-8?B?NnJzUGc3VmVGaTFSbHhSWGw1Z2lVMURmcjl4WVVXZlUrbVkvYm5nVEhBMmJp?=
 =?utf-8?B?bmNFVmxOYktHZEh6U1VMcFh4NHk2cUVNUlN4SXEwMUZtdzA5dlpyeEdYcWlV?=
 =?utf-8?B?c1NXZytHdjlOdEdQRzhPWmFteVhXcFpodkx1QU1kRU03dEQ1WXNVcFJHVWlL?=
 =?utf-8?B?bjdGZkpNeUZISW45SHluSTdDbVJkUnRpU25uZVN4ZDlCVTBiUURYUk8wWnFh?=
 =?utf-8?B?c2ZqL0lRSGpQT3J3cE5NSDBDWHRqY1NxOE1xZzJJUWhNUjBLbm94d0QyMWRu?=
 =?utf-8?B?VTVGa2I2VDlCWFp1ckpSTHA5UFRMNnlvSDVwekFoWUxOQVpzbDFHRnFQbUJT?=
 =?utf-8?B?UkUxREYwTXJEUGtpTFlDbzJ3NWhBMFViaWk4bFdSbUlvb21WMGFuekRPTzhZ?=
 =?utf-8?B?ZjdvR0lqckxrMDhOTWhnMkZmeEJKV0p0VXk4Y04yQzB3aFNmRmFXa1ZjZ01j?=
 =?utf-8?B?U01lMGgzSkJ3UENGUnlocjFISXJqejkwSTZZVzMybE9VY0RHL1A4UGZoWlN0?=
 =?utf-8?B?RER2Rk9LSmFKRFNCSGQzZ2xKYjZyUTZIQjJxS0dOWWV1Uy9XQXFhbjdzL3VP?=
 =?utf-8?B?VndodkZHYkI1cFJLRCs0RzV3TTNyYjZxWk42YnVxMkxPOCtaN0VaaXZIVWlF?=
 =?utf-8?B?aWhob0o4empuVmF3bWI2L1FBQndoRHRvd2wrR0FJTExiMlBTRmZUTm1BcnNJ?=
 =?utf-8?B?cG1RdTRDcG9qV0FMalRTbk9rTHJ2anRPRTlHdUIyMStpVThaTzFxMEVqN2Rq?=
 =?utf-8?B?ZWFhbkFjRDIwN2pXU3FsY3hweVFjRlM4cktUVzdteVZueEdiTG9wUE9GRCs0?=
 =?utf-8?B?WFNEczRDVWllQnlKR3dSeFJMV2FPZEdjZUxyZkNSL0NsU0JlU09sc2RRVHgy?=
 =?utf-8?B?Z2ZUMElxaUMyQ016NXBLK0xUZDZra1dqUXNDdEVPUjlrZjZLa0kxVkZtSDFR?=
 =?utf-8?B?T01NM1VmZ29HWVVBY2hMTEErRDFKMHZQNjMraGJVOGxnZW5vb2tIbk9oZlVD?=
 =?utf-8?B?SDByTGNUUyt3TWkzSExmYm1aL24wam9hTFl4S1dQdUdJNjV1NTcxMHNGUXI2?=
 =?utf-8?B?bEw2R29ySzloaElaNjB6Y3dXZk1nMjVacmlvWXZFME81YUgrZDhIbm12dGlS?=
 =?utf-8?B?M1FyTXJldTVoK1c3NXpxdjlXTWNCaUlMN2NHdE03S2M1d2htaUNpOGV2VHll?=
 =?utf-8?B?ZzIweUxvNE93UFhESjNaOU5jbXA5NXFBTXFKWjVWTHVYWlpoUVZnMFVMSC90?=
 =?utf-8?B?ajZqc0QwdjQwUEFJQlRaNi90Z25lWUplUGt5dTk5MWRBV1AxYVkyYklRZHhx?=
 =?utf-8?B?a0oxOVRIb3hsSzhKQUJCSG9aOXFKUDdqeUtOTXllVHBuUGpkYU5BbjAzUk8v?=
 =?utf-8?B?M3RKc0trMUkzZDhwQ2pqYmFjaWdsZTdyWUJrRElXUDk0ZkpBTUFobjA3cEw2?=
 =?utf-8?B?NDFjd2R1akZUNncwbTNwSUJ0bG9jdG9xc2N5NGpyK2pyQTE4UmJ6NlR0M1A4?=
 =?utf-8?Q?hSKyg5Iy8vX9/I9kUdidy04PGuZvKO/dtGQOg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGdvcWxRUTZyWVZsMXlNSFRON1NuakM0d1Z0WWdHQ3ovRnVWNVRVMElhQkI4?=
 =?utf-8?B?WnRlRUI5WWdnMzkyaTY3VE13Y3pwUm1CdWtvZWdkTVd2UTl4TEp5TU41R2Zh?=
 =?utf-8?B?UDZDNllQS1plY0I1WUVla256cW15dVZDdXZDWFhUMXpFTk8xTEZsNlNYYTY2?=
 =?utf-8?B?QVJudlZyanJucjExZWc2aTRQVy9aalV6TFhua0ZMbGtmd2Fva1ZKWVJzZ1h6?=
 =?utf-8?B?dkppaHVFVTJiUTF4TzlGdnVrQTFxSUVuQmRIc1JvM0tkb24vSS9EVXpkeVZD?=
 =?utf-8?B?UlEycUtKRXJ3MVJWaktyZExocytpbC8wTk9XcktYb0JxekVBM2R0azFIZ3dZ?=
 =?utf-8?B?NXF0V0laSnYvd0V5OUxGdW1mUmVXQnhmcUdCWUlMYVFoSVNsY1ZwWTg5YWl0?=
 =?utf-8?B?M1RBSFVpUmJhNWoxRHZMUXVVMXYvRUxKbURNUndpSnV0ZEk1RFc0OTBZT1RW?=
 =?utf-8?B?RmVWR0I5UlZZejNJNXFuYlNSdFdoYlF6R2ZUamthNkdZak4rMzNFdU1FT2sw?=
 =?utf-8?B?Rk5EY1Jmb0Y0MUFWY3RORnQvYytYQjgybGlWRzlteE9jK3NvRENBMkpOY09h?=
 =?utf-8?B?dHdnU2paYWJSNWNjWkNRMzcxd2FEOTNHVXJORVUxaG94Vm55bWJaVmtEcXU5?=
 =?utf-8?B?M1pXalRIeUZkVEU4WTVuRm5Id1ZxcXEyRStiQUR1NTVqMlNFTzZxL3lOODhx?=
 =?utf-8?B?NnRwd2FpN0tHWE1TeExzOG9ZaEFpbTY0Y1h0aE9TUHQxa1czeWlzU3djTFRw?=
 =?utf-8?B?c0VvU2VCeDc3V1NSNHI1eHZlc3BrYUlhWVZKblhZUzRsaE5MM0N5Nis2VHV1?=
 =?utf-8?B?eXNhbkZjUkFNNC9RLzBjWU1nVHlpaDNLZVlFWkJIZ0lyUWpINk5UK3FsTlRI?=
 =?utf-8?B?ZWpMNDFkeTZHSXFiWTRUbkpaempLUTBGZUwwUXU5SDZiM0d5VVlMakdmQ3k5?=
 =?utf-8?B?RUFXdS9vTFZQR0NRckpONTNVTXB4NWJKQThXWThmTDQ4MXZTMXlRZHRxdVVZ?=
 =?utf-8?B?dmpaTE93azdoMVZrWWE0a3Q3MkdEdE1HNHNkUm1JbVAzdFM5SHp6eE1vczBS?=
 =?utf-8?B?d2NXcHdsU0pULzQzd3c0SUkvZ2hqYm5FVUpTcisvckZzZ2JiWEhxZlBkRDZS?=
 =?utf-8?B?RDJYb0VYYnBIRElRVnY3THNQTk5pUzJlQ2NPV0YyRHVLY3hUUnQrN3Y5MGxU?=
 =?utf-8?B?SnN1T0REeVJBRG1acjIwM0dNVVFTcEFnUEJiWkVFdy96SjhxRjZIaDRaZUxx?=
 =?utf-8?B?eW1BaVRLY1FWck1nbDNTdjZqcmExTVN6N2g4bUN3YXBIaGRaY0NqOWVYK0Jz?=
 =?utf-8?B?SzBQci93VkNkNVlqc3NHY0NPWXJrQng1QXR6NmR1YUJrTERBRmxrWXNTTUVh?=
 =?utf-8?B?Z0pudGw2TkdtNTMwbkVYZlpPTDBIdkZObmZWMDdjeUN5Z1AvMVlETDRqVGla?=
 =?utf-8?B?c1hhZW5nL20yTVFiZU1RVDlJa0d3ZlBGWWd6dHdzYnFvaDJYc2tHQVo4aitR?=
 =?utf-8?B?RkxpN2x1eGJIN3l6SmZITFFjZEVUc003eUFoeXFudloySkgxY2FrUGlrL1BV?=
 =?utf-8?B?WFFlMVhPd1FESHVtZkR4NEkwVDUxZzFZeGxZVGdaaXd6Z1h6WTRDUXhOZHJH?=
 =?utf-8?B?YXE0QmQxV0hiR1RYbkl6aHd6UVFHT3V4bkZpbUFVK1daMS9ndmttVUg0NFBq?=
 =?utf-8?B?UDQ3d001alJDeHM4TW1wRlhGUTJkU0RXRU5IWnJuMStkdFVlK001YlNEbjZS?=
 =?utf-8?B?U01nTnYrNVBJRE1IYXplTVVucHVzSmtmWUtaU0lDV1c5eTg3RjRrNlFPNU5n?=
 =?utf-8?B?UlYzajFlZmRUeC9rU0FNQ29hV0hWZS96Q1Z4SEpkQkJJWjNQck5HNk9MdHFY?=
 =?utf-8?B?cFJkbWlTcVBFcmVWZ3Y1WnBjUDFLUzZKT0huK1lCRU1XVU1WTjE4T28zcHND?=
 =?utf-8?B?SHZpOHdvd3hWZ0FMMFNIem1qSmI1cDZoMk83Ym9ERDNNOWk2TEFTa2xYSStn?=
 =?utf-8?B?RTM3OUN6OXJPdTM0SUd5NlZMWFEwd0RsTjlvaGY3S3g1RlJRNVZ1VmJjQnFR?=
 =?utf-8?B?TFFMOUswOFk1N2RBeVV1aGJNYmJZaGQxUUZZK0RJdmFXRldSTG03NXJtcXhD?=
 =?utf-8?B?TldpM3AxYVc0QXN5NGhIV0xRakx3eHQwS0RXRUk3OUUzQWdUc0RXTU5lTjNl?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4902ED37A6CB47418C3107B78FB22BE3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0XEIRw+nBtLti9uOSf4eYKfJvzGPJH8U+9XJoaPAYfJ/HXBgvYy0wnVGoGSqC1DRb86USIgZ5HdPYk5yTH5xyf3KliBSh1GEIgutprN4yBZ8hQFz9cpohU6e23pLtYL4giaJCJeOQVEL3Shu0Sv1p7K1IW6ISnyOoNEGWd+pCtpykvx8kp/TLji45LfJ/WzSqOE7fr8cCWGDLGlXKa6YD2hEcrADQPFvAVWhzetIAdoUa083CpdU2RyBxmxc/OlGhtKIBPOxKPtGcD4Y5VdR6KYAkbFeS/b/IpUztRez33tJViXypNRAiGoQgOjRBzbcmzOmuGhUOkMAGzXELVjhWB/gU4G0KzRDGIwm/H44sz3/jVMVQXTwRm2XwZomIQ+juqDrFQTLPHn2BDOU1ccq7vpYqyPxPB1u+8dLozgbuie8C/yOHXy7TOPENRFPkQdtiJWtmFZS/WZGSJXGxvumSRKKbZ9REyFVrL9S0jf5L6D79fXCMpeK2cwoeoqOEsStk8VcnXL/rUvVZxis6ctDB62m+T7Wa05c7YKNAaENeOBf0HIEA05z9VXAbpu+k0MevqHGA6rWtfpPO6gGDfhwdM5f2s1ylAn0djHikUtD/JI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b5fddb-eb6e-493f-6c6f-08dceecbc329
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 16:50:09.9578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DctsqdA9xWGQvhmvy3ohdw8SpS6IswTFDVrzJDU19Ygqqihq+/htDLMRKw4iTQpCRnERzsdV87qTwYr+zEN4GbuSSwJCQQLcktoatGr+hKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6343
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_19,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170115
X-Proofpoint-GUID: 58XdsnciefOp3Tu5Zldv0pY5PG8WpfgL
X-Proofpoint-ORIG-GUID: 58XdsnciefOp3Tu5Zldv0pY5PG8WpfgL

DQo+IE9uIE9jdCAxNywgMjAyNCwgYXQgMTA6MTPigK9BTSwgSmFya2tvIFNha2tpbmVuIDxqYXJr
a29Aa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIDIwMjQtMTAtMTcgYXQgMDk6NTUg
LTA2MDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+PiBSZW1vdmUgdGhlIENPTkZJR19JTlRFR1JJ
VFlfUExBVEZPUk1fS0VZUklORyBpZmRlZiBjaGVjayBzbyB0aGlzDQo+PiBwYXR0ZXJuIGRvZXMg
bm90IG5lZWQgdG8gYmUgcmVwZWF0ZWQgd2l0aCBuZXcgY29kZS4NCj4+IA0KPj4gU2lnbmVkLW9m
Zi1ieTogRXJpYyBTbm93YmVyZyA8ZXJpYy5zbm93YmVyZ0BvcmFjbGUuY29tPg0KPj4gLS0tDQo+
PiAgY2VydHMvc3lzdGVtX2tleXJpbmcuYyB8IDYgLS0tLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQs
IDYgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9jZXJ0cy9zeXN0ZW1fa2V5cmlu
Zy5jIGIvY2VydHMvc3lzdGVtX2tleXJpbmcuYw0KPj4gaW5kZXggOWRlNjEwYmYxZjRiLi5lMzQ0
Y2VlMTBkMjggMTAwNjQ0DQo+PiAtLS0gYS9jZXJ0cy9zeXN0ZW1fa2V5cmluZy5jDQo+PiArKysg
Yi9jZXJ0cy9zeXN0ZW1fa2V5cmluZy5jDQo+PiBAQCAtMjQsOSArMjQsNyBAQCBzdGF0aWMgc3Ry
dWN0IGtleSAqc2Vjb25kYXJ5X3RydXN0ZWRfa2V5czsNCj4+ICAjaWZkZWYgQ09ORklHX0lOVEVH
UklUWV9NQUNISU5FX0tFWVJJTkcNCj4+ICBzdGF0aWMgc3RydWN0IGtleSAqbWFjaGluZV90cnVz
dGVkX2tleXM7DQo+PiAgI2VuZGlmDQo+PiAtI2lmZGVmIENPTkZJR19JTlRFR1JJVFlfUExBVEZP
Uk1fS0VZUklORw0KPj4gIHN0YXRpYyBzdHJ1Y3Qga2V5ICpwbGF0Zm9ybV90cnVzdGVkX2tleXM7
DQo+PiAtI2VuZGlmDQo+PiAgDQo+PiAgZXh0ZXJuIF9faW5pdGNvbnN0IGNvbnN0IHU4IHN5c3Rl
bV9jZXJ0aWZpY2F0ZV9saXN0W107DQo+PiAgZXh0ZXJuIF9faW5pdGNvbnN0IGNvbnN0IHVuc2ln
bmVkIGxvbmcgc3lzdGVtX2NlcnRpZmljYXRlX2xpc3Rfc2l6ZTsNCj4+IEBAIC0zNDUsMTEgKzM0
Myw3IEBAIGludCB2ZXJpZnlfcGtjczdfbWVzc2FnZV9zaWcoY29uc3Qgdm9pZCAqZGF0YSwNCj4+
IHNpemVfdCBsZW4sDQo+PiAgIHRydXN0ZWRfa2V5cyA9IGJ1aWx0aW5fdHJ1c3RlZF9rZXlzOw0K
Pj4gICNlbmRpZg0KPj4gICB9IGVsc2UgaWYgKHRydXN0ZWRfa2V5cyA9PSBWRVJJRllfVVNFX1BM
QVRGT1JNX0tFWVJJTkcpIHsNCj4+IC0jaWZkZWYgQ09ORklHX0lOVEVHUklUWV9QTEFURk9STV9L
RVlSSU5HDQo+PiAgIHRydXN0ZWRfa2V5cyA9IHBsYXRmb3JtX3RydXN0ZWRfa2V5czsNCj4+IC0j
ZWxzZQ0KPj4gLSB0cnVzdGVkX2tleXMgPSBOVUxMOw0KPj4gLSNlbmRpZg0KPj4gICBpZiAoIXRy
dXN0ZWRfa2V5cykgew0KPj4gICByZXQgPSAtRU5PS0VZOw0KPj4gICBwcl9kZXZlbCgiUEtDUyM3
IHBsYXRmb3JtIGtleXJpbmcgaXMgbm90DQo+PiBhdmFpbGFibGVcbiIpOw0KPiANCj4gSnVzdCB0
byBjaGVjayB3aXRoIHRoZSBhcmd1bWVudCB0aGF0IGFueSBjb21taXQgc2hvdWxkIGJyaW5nIHRo
ZSBHaXQNCj4gdHJlZSB0byBhbm90aGVyICJnb29kIHN0YXRlIi4gV2h5IHRoaXMgd2FzIGZsYWdn
ZWQ/IFdoYXQgd291bGQgYmUgdGhlDQo+IGNvbGxhdGVyYWwgZGFtYWdlIGlmIG9ubHkgdGhpcyBj
b21taXQgd2FzIHBpY2tlZCBhbmQgcHV0IHRvIGEgcHVsbA0KPiByZXF1ZXN0PyBObyBpbnRlbnRp
b25zIHRvIGRvIHRoYXQsIHRoaXMgbW9yZSBsaWtlIGZvcm1pbmcgYSBiZXR0ZXINCj4gdW5kZXJz
dGFuZGluZyB3aGF0IGlzIGF0IHN0YWtlIGhlcmUuDQo+IA0KPiBJLmUuIEkgZ2V0IHRoYXQgeW91
IG5lZWQgdGhpcyBmb3Igc3Vic2VxdWVudCBjb21taXRzIGJ1dCBJIHRoaW5rIHRoZQ0KPiBjb21t
aXQgbWVzc2FnZSBzaG91bGQgYWxzbyBoYXZlIGxpa2UgZXhwbGFuYXRpb24gd2h5IHRoaXMgaXMg
YSBsZWdpdA0KPiBjaGFuZ2Ugb3RoZXJ3aXNlLg0KDQpUaGFua3MgZm9yIHRha2luZyBhIGxvb2sg
YXQgdGhpcywgSSB3aWxsIGFkZCBhIGJldHRlciBleHBsYW5hdGlvbiBpbiB0aGUNCm5leHQgcm91
bmQuIA0KDQo=

