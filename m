Return-Path: <linux-efi+bounces-1174-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B63C98FD79F
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 22:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409A01F21052
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 20:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A1615EFBF;
	Wed,  5 Jun 2024 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h5IE9Bm5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xdAG8FyO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736CA15ECD4;
	Wed,  5 Jun 2024 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619866; cv=fail; b=JQ1ljvWBawVYh3EI0zRX85pB0APJM103vkKvczIoMl7F1DXZfKbutGtw/QXGZWw3/3tQl3OWvz6wWGrW6336f/GmCvQopyOzaX40REGueOqdLY32gu5SR/sWJ+GrQsI7U7l317xfPBO6wOWEzQuSjeC7hEYDfIeBTM5MHscCY68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619866; c=relaxed/simple;
	bh=i7SP9mcg/c//3+syRSrP0qfzD3Qcl8HtsXxyv/AAhRQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IJrtc47rNVcPPRLb3cxOlLb/7mAdfeOW7/gtbhhQT54dT1zTp4DJ1XHusQyb1sQhIghnZjnoMBCVQ7Dps3g7uCdWXHmUlSQ9GRwjW+LNhvwy2gRqGIrtuixMkNz0we+5KR08IAGsnkH1TztQuy4dSz3/SkDMw9L3ISANEDlmPiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h5IE9Bm5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xdAG8FyO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 455JUS71015969;
	Wed, 5 Jun 2024 20:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc : content-id :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=i7SP9mcg/c//3+syRSrP0qfzD3Qcl8HtsXxyv/AAhRQ=;
 b=h5IE9Bm54//orq52M4owqShXl+MEAsGf5Y/i8YqVh/UvtTjzpMZvBpwV6Bb9PRHEMngK
 9hdWZxN4vcqpFV9Ip/BDNCQQSzxl8NciSSzUw/Vf8ir1gYyCM7eCTDOrJ6zz3g2bi0PR
 JlSdAdgHxZ8brX8CubSFyrh3m0Jf9cNd+wlOh//fATPDn3HWEaiuTFljqDRGxf0lEaGD
 1U4tUv06OUmv438Cx1A/xVAFD9dbaJ1YBFg9pl9hb445fTuWiVkiK/uKbd9+BdabuwtH
 JumlceVq/XWkfPMbV/hfoEGq9MeVaNQJUWYpH1d9sxpfvzunHrQ+QHtEFwteN0ZNIlS/ TA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbtwa6sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 20:36:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 455Jk8be015592;
	Wed, 5 Jun 2024 20:36:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrje9207-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 20:36:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDiSkyhetCgXrXKxCcan1AyrO0Z55rpgfQ68VVlwAl4lTGmqWvQa/QFq2Yg4UbXxAcA6bvEynrwXDAErOfNPs8lZJjwDya8RdGOv8dCZ8ig62K2fy2ZveMNZva5hAgWcEGjxPomLvGjxQfTHHJlmGIleSBNp6QqNHCGRFNUMYWQH09aRicVrePxAe+ZvwelrpBq+KROzt0JYkzlFqf0rYCTQMSSGWWfd9vg+EC/t+3qVQBDe8MlOQG4RnyicepY1bQLphZf12gjYDhAGFKg7trexJ1RdSa7l/qWk9Z110FHK9TAdLgTcHJiyFpsDrp4LY9LMZSVPXn0ozfQqczIV2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7SP9mcg/c//3+syRSrP0qfzD3Qcl8HtsXxyv/AAhRQ=;
 b=Vdrs+8sAUXAmTfGcFoEla3vxPiLuUixBbwz/KwBUDd9HgFt5aLIXOHIEUPTImRRYiUfxXVxZI0nNXvV12lTiGPL19WYygEBacWzGPa9fwgKaEPVllCNT6pqLX9FLDKBYYPHVtK+AE44d34RKyZkOnBxw7DpH7loWyuEVw5Mn8CaW2pSnxx1ucISkjxwIxMBQWoxG3RE/iZytVL4mx14j3b5INGiWlLgonqlDb9fEMQXyuDgsbSdQUNCyakBXcNlonfvfS1pypkEY2Jj6qF3dizLImRP0vdbrJ+WzrmWcbUqymvZ1TD77KL9Q+9nse2KWJEFAqD7pz3lc0mBom5/BVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7SP9mcg/c//3+syRSrP0qfzD3Qcl8HtsXxyv/AAhRQ=;
 b=xdAG8FyO2whs7rHwEhWdv3lNdndRa1A5CNqlBokz6zf2spfhT+uVUzEk+p27+eW/emjnA0VsDPtgIsiKZRYdllbkS/qSiS4tzdKgP6YuJEiw2T0/nYOzyWtnm8rzLsDRw98q26kYEOk4PNnwM3IASBjRAmerHFIo0xk1xHeZ58A=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SJ0PR10MB6398.namprd10.prod.outlook.com (2603:10b6:a03:44a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Wed, 5 Jun
 2024 20:36:55 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 20:36:55 +0000
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
Subject: Re: [RFC PATCH v2 1/8] certs: Introduce ability to link to a system
 key
Thread-Topic: [RFC PATCH v2 1/8] certs: Introduce ability to link to a system
 key
Thread-Index: AQHasvMOpGsOl/liCUOq6BMDbNf1SbG37l4AgAG74oA=
Date: Wed, 5 Jun 2024 20:36:55 +0000
Message-ID: <B67718D4-8924-4488-AC25-1C26E0DDBF1C@oracle.com>
References: <20240531003945.44594-1-eric.snowberg@oracle.com>
 <20240531003945.44594-2-eric.snowberg@oracle.com>
 <D1RFM5ZWU1O4.1QU546DO1UNKD@kernel.org>
In-Reply-To: <D1RFM5ZWU1O4.1QU546DO1UNKD@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|SJ0PR10MB6398:EE_
x-ms-office365-filtering-correlation-id: aae5f215-7fce-40d4-4ec9-08dc859f3d15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cW80UWVDR0tXWHhHQkNjYVhVSEdEeEtKemJOOGtKbXFQVXd2ZFBLWVo5UlMv?=
 =?utf-8?B?UjhweXJxN3BUeVN1aHJkQ0JKUnZCMXl3dDhGVGZwb1ZnY0tFemV5c1lVQXYw?=
 =?utf-8?B?MmNvSXVKNzVEUzZvcTMrVlBDcnpINnhMM2hyM2RUb3RyTDI3SGRINlJQZjRj?=
 =?utf-8?B?Y3Q3dWJ5dXZQNVBpbFdpTi9PNVFsOFkrU3J3UWZSZ0x5ekhCSW0zcEpXYUh6?=
 =?utf-8?B?VVNBdnVNNzZBeTBRakdiTnFWUFNBQSttcHJ0TzhtMjVCV3lFdDFyRzNmbGhj?=
 =?utf-8?B?UTRNK2VYTkxmMTNHaU54WGdjTm5sc1A1QzVSdDVlT1ZnYlVNTnR2a3l5UFZ3?=
 =?utf-8?B?T3AxR0RRTitHdVNqTEo4K1NUZVBjMWpPdytLTHZtU21CRnBtYnM4d1gxT0Z4?=
 =?utf-8?B?RThmVDhYaGYrWHA1OXYvN3Q0c1AzV0ZQMGxjSi9PSzMyanBoQzBaR09tSi94?=
 =?utf-8?B?eDJCUTFVelc2OHZlS3FISEkzVENIU1hBMTNwRDlLY2VHM0VBeWhKUlBrbVQ2?=
 =?utf-8?B?UERlNDRzUkJGZG1EcXVvRTJEMFZRdi9uTzQxREs5dDdUdU81akljclpxc0Fq?=
 =?utf-8?B?aHBIL2VRQ0RIZ0pJZ2ZVNEM5RG40ZWRmUmJ5c01HY05jTndwQ2taSjVyK3dE?=
 =?utf-8?B?UUZtR1lhUlQ0NC9EM21EZUd3M2tDT2pjV25BbkZSSWVwU3BYeFMyZjNmZE02?=
 =?utf-8?B?dk40WkV5WmRTaDRWakRUd2VvNkFybVovT2JUSnJVZmpzUEdKM21makVnZlFv?=
 =?utf-8?B?NGcyOEtmMTVVcjc4OGtlRWxyNkl5S2pYTFRWa2I3aVdlYTNmWmtJMlk0b2RN?=
 =?utf-8?B?RFN5WSs4NmcvVWcwckhoQ1Zjc0J2OVMrRTNZeE4vSXlCVEZNaDU2QXdWNUdl?=
 =?utf-8?B?YTQ4NWtXdVlheld2N1pjRmZnWExjVCtmWHlXdGdhUkhkYmNyUHdjcW9qSzB3?=
 =?utf-8?B?YTJxck90RlAvSldrbnV1SE5qQmYxLytRcm9CUHRkVk9PVVdFdzg2M1dQZjZx?=
 =?utf-8?B?aUJGb294OEtvM2o3MDdTSUx6aEU5RmpwWUcrMkdKbzMwOWVqVm0zdjJ2RTBi?=
 =?utf-8?B?S3JycU5scWF3aWI2T3lGVWtvM2xEOGIxV0MvVVBvV1o1R3UzM0NZbUY1eU4x?=
 =?utf-8?B?Y2hiM2JKOTExWXowcjI1V1hjamdYMkk5R1RrempibUtJM25yMWVBanNYTVVl?=
 =?utf-8?B?R1V4b1Q5Nmp1M0YrRDdhVmJPQWV1M1dXNjk0b1VMNG9Tb21MNWgrZlZRaERZ?=
 =?utf-8?B?QS9QakxPd3dxYzlTbFRvUXdSY1dNdG1hMFlPR1NrZTlNeGxMQnZKUjMyd3Ur?=
 =?utf-8?B?eXh6cG9xb3lwR2Q4b0k2a09ER0ZjQ3VOVFZSSWdNdjI5ZGc3SzZmb1k5YUpl?=
 =?utf-8?B?MU9rSDUvR1gzcGdOWWtDdlNTWlA3VlBsNmd1VkRLYkxqSFBQNG9aUmVUUHJz?=
 =?utf-8?B?dGwxYWFQVk5iOExXWHpRYXAycnlmcFByT0RvdEZRSVZ4TXBZVm11andsU1RL?=
 =?utf-8?B?TnFiNzQ0SjIzSXZXUU1XNTJDSi8xZE5meHRHa2FIeEJGbXltZ2tQOFYrdm43?=
 =?utf-8?B?eXM2eUpzVk1ROWlZQ1JENGhmSFg4cktJZmk2U3RmblR1UFA3Vnpua2FuU1Z4?=
 =?utf-8?B?dVNMMlBJQVlybWpSYWFyWkhEaGFsS1lSaklvd0YzS3hObDdEam54SlJZSFRw?=
 =?utf-8?B?SzJPbXZ4bzcwaGFsOWhzTlF2SktPdjZ3Y2ZMdWpwZjBFTmF6ZWh6d2lnVm5L?=
 =?utf-8?B?Z2RMdWFqSklKOENhZjNQZFFuRmhhRnJIbUFiTTA0VDZNeVo4SmhuczVtNDVx?=
 =?utf-8?B?d0dtR3htWDJtTGRmUWVzdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?b1hJRkdmZ2lid0h6RnlFNU11NkF0amdVaFdMNFBEMTlseUYydy9KQmdNbU9s?=
 =?utf-8?B?MjlhZWpsUk9IRnVQUUtJTmJUb3EyVm5aQ1RUSTV6L1hhZnFTN3NpdUtIejhS?=
 =?utf-8?B?aitwaUY3RGs5VWx2ODE2ZFZ0YnZtRlZiQVdZamU3RXZoc1VYQmZoTG8vSnFT?=
 =?utf-8?B?NElwZ2lrKzVYYS8rR0YrRHhOcTZ4ajlEWmJzbU9GQXpDNmxWb1RHektHcXNn?=
 =?utf-8?B?QlE2MXUwbUtCM3NJaEIxbVYybG1hMnJJOEM1dU80Ni9TejVYblhIenByU1NK?=
 =?utf-8?B?OEl1bHZiTDdkSzVjSzQ2Rll3NWpCRVlQVzJBcjJDTzF4Q2xsc0xFaDY1MzBs?=
 =?utf-8?B?Q2I2cCsrUklJTnhGK2hSRFBQd3BhY0xBZjhPSkNJTWxmUW5WdGlFOUlyZDNy?=
 =?utf-8?B?L0hkRy8yM296cUFDZ2pUUGM2SHRJYmtkaGVRcStZUHd4bEdLT0N5NDc0Q013?=
 =?utf-8?B?STN0T1Z3U3BpbmRMUzJtdCtHK2xyWExlS0xOanQ0Wkc4Y3lMdENxS0dDYW1r?=
 =?utf-8?B?RjNzWHRBL2V5Z3VMYy9lWUNKbFV1UWhrNlVzTFQ4VkpONFdMQlo4QVU3QzFI?=
 =?utf-8?B?aFJkcStvcDllWlRieVE4MmVTNTJ3TCszTDlpQUZsc3ZDS3lEVXc0dFpVMGNz?=
 =?utf-8?B?eXFLNTdERldicGVUK3pBeEZSNW5SNDNjb2V4dXAzMG56N2srd0YxUFgrTlBL?=
 =?utf-8?B?YnAyTkZvaHlCV2xpT2tHT0J0dTYyUFp1ZzF0Q3M0QlBsRWp6VHZXNEI3K2Jn?=
 =?utf-8?B?V2JRdkJOYVZkL1VjUDUvQkJyWXREaURuMktpZWxZZ09xWDNrODRuRUtZeEI1?=
 =?utf-8?B?VVBjSWN0L2JGaVNpT21yOWJOZlYxQzg1TFcyMStWUml0SERHSWJ4aGU0c3NU?=
 =?utf-8?B?Sm4rTW95dzRCRTN1UExkSmtQOThxdTY1OERSeG8xejcvWHBQdGxJZzU3TGx3?=
 =?utf-8?B?QzFGM1VJQmxFZTZ4OWlrYmt4K1pWTk8zS09nRm9vUnJObjliMjVmSnhGTm1q?=
 =?utf-8?B?bms0UVpBZGk1cVU3UHhPOU9Xd2U3S1NsNk5HUS9vMEV4WVdLOHpHdXhwYVhV?=
 =?utf-8?B?bkNaU29rRVNQbEZUaGtSVkNWcDBFbDRtb0hMczlick8xTktCMmpqdUFRWjBE?=
 =?utf-8?B?eHF5cXZEOFhQYjEwc1FHeHQ2QkZWZWw4aWx2TURURitmdS9tYXRXZ2sveTh6?=
 =?utf-8?B?SDA0V3JwNjV4RnVZdmFjOTVDcUl3UkVmMnNSZExxcFNiQ1ZER2NuR0hzQmdB?=
 =?utf-8?B?cEd1R3VKOFplcGdXL1V6TDg1cTZJdGRRaE85bVJtWUkwRjNFOHpsUFJxeDJJ?=
 =?utf-8?B?ZUFwM2R4UnhEK1ZRWlNoZjNlYmt6TnpLTWFWOFJqZUVRb2Y2VWowWnZpZ1hl?=
 =?utf-8?B?MWdwU0I5Wm4vdEYrM3pHRmhqT0xGU040aTU5QVY5dFFuMzBLUlNLczJob25W?=
 =?utf-8?B?TEVKSWVTeGhYZDJWZ0xlVmdJdDJ0eDAzWnNCWCt2MW1yZWFxdXZBMkNjY1Vs?=
 =?utf-8?B?MnN6bElxVjBoTDJsL3NEekdjaUZFd3d4dkYvSGVlcThOc3RLWjVaKzJhRlNi?=
 =?utf-8?B?blQ5RVZUVzRRUEgwNHNEblFQRVVIeFV5OE5lbDZSc1hCbUZnVXhhT3VSdWRz?=
 =?utf-8?B?anBqNzNxNnlXbjJaUmxUWGJKNW0wTSs5enBIbzZoTTNuZjR3azRJRWpIbVdM?=
 =?utf-8?B?b2ZPMVpmRDh1NU1DaGdmWGhBdUlraXN5UDFEOGR4N3YzRy9qN0JaMDI5Y2Mx?=
 =?utf-8?B?cFZUSUdhazhCUDBPOTBESWJlUWZPODErWjdBY2ZJcWlNMVdCN1JwR2hEWThK?=
 =?utf-8?B?ZEc1Sm1MNTdqTzFxb1lpcldZNXk4eUZzWk1mRExwSTZwVE1EeEZnK2FNTkpX?=
 =?utf-8?B?MXJWaWs0bVgvT2RmR3V1alB0ZVlLSDdnSmRlVG0yZWYxd29ZdVlEM1FEM3BF?=
 =?utf-8?B?cFZqb1AwdEwwTGk1cE1OdHdLMnFjVVVsNm1iMFVZTkE5U3dsUjNjSFBTd0Zl?=
 =?utf-8?B?S3RhQjVUU2drNU9EU3U0aFdhMGUxM2R2cVF1UEpQVW1pbUhCMUw2blNKbU55?=
 =?utf-8?B?cFJtMzhjMCs0bkk2T3hUZ1BKVEQwV1Nwd0ZEci95c3dqRjEzczlqelpzN3pE?=
 =?utf-8?B?c25GK3JTdFR5TDJvSXU1Y3Vzek5sdWNqQVNIUVN2T1Q3SEM3dXVpUVAvdTlG?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96A4EBA692932F48965922D0B136E5F0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vXqDUZ2ef1L7vz8g2UxdYxA+Uxj5ujrZDq2EdQfvv6M7UZZAhAfn5WkoO3mlrCsPdT9Tlz8/1SAa3xpxRkb/3LkbuOALuA3aYeX1V7WDvAenPsO6A+OlNnKLwXXMEaHzINqKw83mRlTL5W0ViYnMshxjPlR/L4K8EDzbsfp2nb4+fIAcUtUiHp9q9uvoZFY0z0QhcDZ/Td0GslDPdLP1LQt6hBoWML+gJptvUYDUKKATFRB0Xm0d2TIOjTPDMR0wLCzM7h5f8rLMTesuecli+jBxiJCgl8tgXzAkEU1TLpZLdUYc3P5JkMLabBdkMQQ12rOIOcDoDV+9Aie1PPDkcG1WEw5BYNLV5DlLlRmTYS9SKWQMxU0XMhT+2MGo3Cj71bYPB1fA30UpV9+7vpcK20a24yV5oInYLOuGWgBGuc0jzNqUbcyK6uqn3S+e+ShRF913IjGJLki4FjVuhQvYD9tfjq7mt4/oUi6o0vOSQzrK0eiutyPV8Am1M43X/NDaUH3hDZGlckLiJS4Yort/8OPJ4GypXtf/Vmlxj8uasR0ZmJb/zGSKtAieX6jU1MVtnC4D3J1coQVxCquA6Xt7NMLX7tEmw5zTc2aqiPpinu8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae5f215-7fce-40d4-4ec9-08dc859f3d15
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 20:36:55.0683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 98LLYQ+i4Bi9UqmZaj5YdGSYH5QDZgLhluzerYBR4WK2neQhdkzFOHYthANjdF3p8DxS1pBAEIvtwUaXSn8hvLSFl+z7LR6itF1iErQTZIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6398
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406050156
X-Proofpoint-GUID: SRN4-zZjp56LTp8YiFC17kl9pvZ0onjE
X-Proofpoint-ORIG-GUID: SRN4-zZjp56LTp8YiFC17kl9pvZ0onjE

DQoNCj4gT24gSnVuIDQsIDIwMjQsIGF0IDEyOjA44oCvUE0sIEphcmtrbyBTYWtraW5lbiA8amFy
a2tvQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gRnJpIE1heSAzMSwgMjAyNCBhdCAzOjM5
IEFNIEVFU1QsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+PiBJbnRyb2R1Y2UgYSBuZXcgZnVuY3Rp
b24gdG8gYWxsb3cgYSBrZXlyaW5nIHRvIGxpbmsgdG8gYSBrZXkgY29udGFpbmVkDQo+PiB3aXRo
aW4gb25lIG9mIHRoZSBzeXN0ZW0ga2V5cmluZ3MgKGJ1aWx0aW4sIHNlY29uZGFyeSwgb3IgcGxh
dGZvcm0pLg0KPiANCj4gIkludHJvZHVjZSBzeXN0ZW1fa2V5X2xpbmsoKSwgYSBuZXcgZnVuY3Rp
b24uLi4iDQo+IA0KPiBJIGhhdGUgd2hlbiB0aGUgZXhhY3QgdGhpbmcgYWRkZWQgaXMgbm90IGlt
bWVkaWF0ZWx5IHRyYW5zcGFyZW50IGZyb20NCj4gdGhlIGNvbW1pdCBtZXNzYWdlIDstKSBIZWxw
cyBhIGxvdCB3aGVuIGJpc2VjdGluZyBmb3IgaW5zdGFuY2UuDQo+IA0KPj4gRGVwZW5kaW5nIG9u
IGhvdyB0aGUga2VybmVsIGlzIGJ1aWx0LCBpZiB0aGUgbWFjaGluZSBrZXlyaW5nIGlzDQo+PiBh
dmFpbGFibGUsIGl0IHdpbGwgYmUgY2hlY2tlZCBhcyB3ZWxsLCBzaW5jZSBpdCBpcyBsaW5rZWQg
dG8gdGhlIHNlY29uZGFyeQ0KPj4ga2V5cmluZy4gSWYgdGhlIGFzeW1tZXRyaWMga2V5IGlkIG1h
dGNoZXMgYSBrZXkgd2l0aGluIG9uZSBvZiB0aGVzZQ0KPj4gc3lzdGVtIGtleXJpbmdzLCB0aGUg
bWF0Y2hpbmcga2V5IGlzIGxpbmtlZCBpbnRvIHRoZSBwYXNzZWQgaW4NCj4+IGtleXJpbmcuDQo+
PiANCj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgU25vd2JlcmcgPGVyaWMuc25vd2JlcmdAb3JhY2xl
LmNvbT4NCj4+IC0tLQ0KPj4gY2VydHMvc3lzdGVtX2tleXJpbmcuYyAgICAgICAgfCAzMSArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiBpbmNsdWRlL2tleXMvc3lzdGVtX2tleXJp
bmcuaCB8ICA3ICsrKysrKy0NCj4+IDIgZmlsZXMgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvY2VydHMvc3lzdGVtX2tleXJpbmcu
YyBiL2NlcnRzL3N5c3RlbV9rZXlyaW5nLmMNCj4+IGluZGV4IDlkZTYxMGJmMWY0Yi4uOTRlNDdi
NmIzMzMzIDEwMDY0NA0KPj4gLS0tIGEvY2VydHMvc3lzdGVtX2tleXJpbmcuYw0KPj4gKysrIGIv
Y2VydHMvc3lzdGVtX2tleXJpbmcuYw0KPj4gQEAgLTQyNiwzICs0MjYsMzQgQEAgdm9pZCBfX2lu
aXQgc2V0X3BsYXRmb3JtX3RydXN0ZWRfa2V5cyhzdHJ1Y3Qga2V5ICprZXlyaW5nKQ0KPj4gcGxh
dGZvcm1fdHJ1c3RlZF9rZXlzID0ga2V5cmluZzsNCj4+IH0NCj4+ICNlbmRpZg0KPj4gKw0KPj4g
Ky8qKg0KPj4gKyAqIHN5c3RlbV9rZXlfbGluayAtIExpbmsgdG8gYSBzeXN0ZW0ga2V5DQo+IA0K
PiAic3lzdGVtX2tleV9saW5rKCkgLSBMaW5rIHRvIGEgc3lzdGVtIGtleSINCj4gDQo+PiArICog
QGtleXJpbmc6IFRoZSBrZXlyaW5nIHRvIGxpbmsgaW50bw0KPj4gKyAqIEBpZDogVGhlIGFzeW1t
ZXRyaWMga2V5IGlkIHRvIGxvb2sgZm9yIGluIHRoZSBzeXN0ZW0ga2V5cmluZw0KPj4gKyAqLw0K
PiANCj4gUmVhbGx5IGNvdWxkIHVzZSBzb21lIG92ZXJ2aWV3IGtleXJpbmdzIHRyYXZlcnNlZCBq
dXN0IGFzIGEgcmVtaW5kZXIuDQoNClN1cmUsIEkgd2lsbCBtYWtlIHRoZSB0aHJlZSBjaGFuZ2Vz
IGFib3ZlIGluIHRoZSBuZXh0IHJvdW5kLg0KDQo+PiAraW50IHN5c3RlbV9rZXlfbGluayhzdHJ1
Y3Qga2V5ICprZXlyaW5nLCBzdHJ1Y3QgYXN5bW1ldHJpY19rZXlfaWQgKmlkKQ0KPj4gK3sNCj4+
ICsgc3RydWN0IGtleSAqc3lzdGVtX2tleXJpbmc7DQo+PiArIHN0cnVjdCBrZXkgKmtleTsNCj4+
ICsNCj4+ICsjaWZkZWYgQ09ORklHX1NFQ09OREFSWV9UUlVTVEVEX0tFWVJJTkcNCj4+ICsgc3lz
dGVtX2tleXJpbmcgPSBzZWNvbmRhcnlfdHJ1c3RlZF9rZXlzOw0KPj4gKyNlbHNlDQo+PiArIHN5
c3RlbV9rZXlyaW5nID0gYnVpbHRpbl90cnVzdGVkX2tleXM7DQo+PiArI2VuZGlmDQo+IA0KPiBX
aHkgbm90IHNpbXBseSBtYWtlIHNlY29uZGFyeV90cnVzdGVkX2tleXMgaW4gdGhlIGZpcnN0IHBs
YWNlIGJlIGFsaWFzDQo+IHRvIGJ1aWx0aW5fdHJ1c3RlZF9rZXlzIHdoZW4gaXQgaXMgbm90IGVu
YWJsZWQ/DQoNCkknbGwgY2hhbmdlIHRoYXQgaW4gdGhlIG5leHQgcm91bmQgYW5kIHJlbW92ZSB0
aGUgI2lmZGVmIGNvbXBsZXRlbHkgZnJvbSB3aXRoaW4gdGhpcyANCmZ1bmN0aW9uLiAgSSdsbCBh
ZGQgYSBjbGVhbiB1cCBwYXRjaCBmaXJzdCB0aGF0IHJlbW92ZXMgdGhpcyBzYW1lIHBhdHRlcm4g
ZWxzZXdoZXJlDQppbiB0aGUgZmlsZS4gIEkgdGhpbmsgSSBzZWUgaG93IHRoZSBnb3RvIGNhbiBi
ZSByZW1vdmVkIG5vdy4gIEFuZCBJJ2xsIGFsc28gdGFrZSBjYXJlIA0Kb2YgdGhlIGNhc2Ugd2hl
cmUgdGhlIGtlcm5lbCBpcyBidWlsdCB3aXRob3V0IHRoZSBwbGF0Zm9ybSBrZXlyaW5nIGVuYWJs
ZWQuICBXaGljaCBJDQpub3cgc2VlIGlzIGEgcHJvYmxlbSB3aXRoIHRoaXMgY3VycmVudCB2ZXJz
aW9uLiBUaGFua3MuDQoNCg==

