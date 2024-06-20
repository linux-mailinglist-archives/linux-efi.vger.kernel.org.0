Return-Path: <linux-efi+bounces-1262-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA919112F2
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2024 22:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094C31C215AA
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2024 20:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F162A1B4C5E;
	Thu, 20 Jun 2024 20:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J2/a1ruc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bmsy6cSd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61B241C67;
	Thu, 20 Jun 2024 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718914749; cv=fail; b=NNoJhAyfgvalwiwLxMA/qkuRoPmzQtqHp1wKHFm42bd5Xc6BvCUE/OXk/gMyyFZtd+dPDIrDTFJIZgR0lVnAuuBxQ0K4T87l1aKOQzE3rcoE1IkDoH1hIVslbsSZocO/p4jMN7LvCxQ8SvrBxLNALgJabEmLX6lpbgv7KI5mc6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718914749; c=relaxed/simple;
	bh=1hUqLgaqIN7nW4jeDofNdrQH70wQN58fvej2n6rXw6w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mg8tIoKgUuHsYm7NutFvDHlym71pTuLLEO50OLhLZXvKZHNE86LEpPeBD7kOslDbNrMXRzK8K0lg/TdOCW4mH5xgQbjjCRAmgboO+ql4/l5vMfhc6UfDIddXQdm/hPfvd4i+ln9vK0D3tgBa8zPT3BSOPamHRQQdRdJPma/1598=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J2/a1ruc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bmsy6cSd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KHAiDh022452;
	Thu, 20 Jun 2024 20:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=1hUqLgaqIN7nW4jeDofNdrQH70wQN58fvej2n6rXw
	6w=; b=J2/a1rucZefa1gElDA8C6bP9e8jiONVo++fq98oIRWUfPp7XnoDhy++uY
	56L+s+3mZ2GmNqJn5/cS/2wFx8ObCrRs4WkwJyx+hK066M4xve4cPJeJKlBCEu0/
	sfOAiEn6PYMtztZ7nx7N5XTO67CUZa494fqd5FtILuYHKXmAg5tvLH8OvV4MFJnW
	nm0SJhUEiycv5zziFVdvCCZ9K2BQjnP+osrheCLmC8jH8Ij+cyYiW93DrFbs8MzJ
	zCPYUXbPuWHMQ/c6w7S3zudGUZi2b2HlW+T7KQM2XPa49dB8JuTadGF/SBRbwSg+
	dVBsjFCStf3AJkDwGNV2OuqhTImjQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkfrbwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 20:18:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45KIpGV5012866;
	Thu, 20 Jun 2024 20:18:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn3pwfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 20:18:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbAeB7VAi99rPpC/FFk6ahDC/6MfHtpAghy2waDHaOxHsrWniS4IZGpm/9LQHO8mt46Stg+b+nhyySAsUZ9I1fRnEn1QM0DVXoMqlwxymvayxTP2WbmtBr4HZVyivUwI5Rnfo785/P2EDcSMubr4ONZ05uigCCoxDxDaDfc10Zk+siIJNjDPnnhWfCWBi5bjzr3EBV7URl6kBAjNCFpcsL8dkYKdDah0+SUZJj0UBdqGDm4zW7GSrf448ld0RpQyqUHxC846aOQEzpL5wpuZ0OjIhBbD46BkpGYkusE1qupJ3tTAs8xs5226DjlZ+qXOGesgZAbOnGwpHFabGxXzEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hUqLgaqIN7nW4jeDofNdrQH70wQN58fvej2n6rXw6w=;
 b=m0H3gKlYLcVrBQBCY3ZUMf/3LnTd0BtK+oG0sMJhq8gLwMXd5Ns5X2aSrwb6ekJxU9Szt4M+BD44stIQEpwybcurTUKiHf4Mw6Nv3Bz5Q/Rfx0SF7we5EL0R+wgSHvp+6EhwmTkvvIaB5D8wBThfesg3Ny400zgjc9evzEhiChTt44a8ByfUSs+tu/vQWJ4jzPqxpLUcY6FOe28tHeVlYQpbOUDJBwdJlsOTIrku1zy7k5FBXATiiydmzr8swMBumrH8yX54mkpZdTZ8lrMghi51Eb7Ac8GQwA3sgTZXRAGGmpelc5bUiU+x+/xA3gCd19rrqBovSHmtspY8UVaU1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hUqLgaqIN7nW4jeDofNdrQH70wQN58fvej2n6rXw6w=;
 b=Bmsy6cSdP80fdm6cBGFVzmE92iIwTOxKR6eT36m0Ix9r/wxxWDPeC4gcQdyfIj391K3uIH2pHI503xSQ+yDjWiLM3UgbqaMSV97pHwGo3ludhz90cX4n/FIfNsIGAftLwr2iKbqtdLxpSoDJeRt4XjjEkocyOsUHk+IFE9TTMfY=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SJ2PR10MB7110.namprd10.prod.outlook.com (2603:10b6:a03:4cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 20:18:26 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a%4]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 20:18:26 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: Mimi Zohar <zohar@linux.ibm.com>
CC: "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Ard Biesheuvel
	<ardb@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"
	<serge@hallyn.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
	<dmitry.kasatkin@gmail.com>,
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
Subject: Re: [RFC PATCH v2 0/8] Clavis LSM
Thread-Topic: [RFC PATCH v2 0/8] Clavis LSM
Thread-Index: AQHasvMN4yYIC0cA6U+n9RVkfqP38rHPUy6AgAHk4wA=
Date: Thu, 20 Jun 2024 20:18:26 +0000
Message-ID: <E82A5B50-7F88-4352-B08F-181536BFA66B@oracle.com>
References: <20240531003945.44594-1-eric.snowberg@oracle.com>
 <ce7232469844231f768c2f5b4cacc4d48c2f1db3.camel@linux.ibm.com>
In-Reply-To: <ce7232469844231f768c2f5b4cacc4d48c2f1db3.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|SJ2PR10MB7110:EE_
x-ms-office365-filtering-correlation-id: ed7c5933-bbeb-46c2-9032-08dc916624ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|1800799021|376011|7416011|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?akx3NGVoYzVPa09SbjRSSUJuM29GenZ0TWI2RlF0eS9ITzdmNHhYWlphYkZs?=
 =?utf-8?B?bEpWUlBLMkg4anV0eWt5UlBhSVhZaExZUGtCYzBrZUZ3UGR6dSsvVVRGWnI2?=
 =?utf-8?B?WmlXcXpqSTVrN1lTY1pHRnB1cWFmZHRQcjFiTTB3Zy92MTdOVVhOR2ZEMms2?=
 =?utf-8?B?YXBueHN4SmV1T3A0UUVKeGhicS9BSkNpaTJ6SllBWHpSZmxBcnQ3ZUh4ZlU4?=
 =?utf-8?B?cHJna2lwK3pPeXh0SDZiNnhYUGk0cXBkRjYvZXNFNWxDZUlkb2dRL1BrTk9y?=
 =?utf-8?B?TTZMQm1DckxmM25YWityTExvWU5rQlVtcVljdXcvZ0VwTkxXZUd2eUo4cDRw?=
 =?utf-8?B?U2ZNY05aMDY1MzJQNzlJTUpMNmc1RkE2c3VSOE1vNzNYRmpxVXRtbEVXWkhQ?=
 =?utf-8?B?RmlKRkVuLzYyUFFFaWxrRnBVc1piVk92c25aekJTbTdHNWZJcUNvTTMyVDhi?=
 =?utf-8?B?dzJuMEFMYmtBVk5BaDh3ZnkwVzBjS1ZyeXJKL3FNQnBuODAvRkd3Ymo1T2k5?=
 =?utf-8?B?VVlSSkJFdGFjcWpFSEFXVGVnaVFpT3ludDFnMHFZRmhNTUNyc25veE02ZG1H?=
 =?utf-8?B?QmdkT0xUOE5qa2JtRFVqRXh5dEw4WDNQK2VXTlk5d2taZTloWmI1MUticWlk?=
 =?utf-8?B?eExjYkpZTUpBcmpqbzJ0U3FWVXdQMmNzK2lUMGhrM3FPeGp5TUdOUmMrSytj?=
 =?utf-8?B?WnYyZHZETXR0ZWhGeDdlWnV2T1JJV0tTY09qVG55QWxLaFBMTzhGVEFaWGZV?=
 =?utf-8?B?VlZoS2drVy81dkUrNEZ5bllNUDVuVDdXamUyMWRIOGYyemZ6WlNnMVNQR3R0?=
 =?utf-8?B?WXVVL3loSEt2RW1aUWdKRThSWDNDNzN2NDdaSzMrNlBrUHRGQWxPaE8raU9k?=
 =?utf-8?B?UmJFV1BQbU1CdDJ6Mk9ZcXhZTDM0TzFlUi9pVElnc1g1N2MzelpjNDlJcGc5?=
 =?utf-8?B?VWY1UnVyc3VmSlVrQUxQanlPMk5neHRwbk9SRmJXUVE2Z0gwaElCR3JINEVZ?=
 =?utf-8?B?NTBUSGVKbmZWOCtUTlMxK3IwRys5cWwzTm1jYjRTbHFiRjFWZms4b29PcFFJ?=
 =?utf-8?B?bnlEc1AzMnROTkU3bzJxZlE4V1ZRQ0pFb2hXY2NJZ3V0VkNxQnlUSXJjQTJa?=
 =?utf-8?B?QTR5dzA1cTVSenV1TUdoQ3FFdDJKSW90QngxQW9PaDdoRjFIMG9CN0pwdDZi?=
 =?utf-8?B?Tm1NbnY2TlRyOXhXRktwRUdpd2VqaVVITFhETDBSVWlqeHpzMXowSXFEWTFZ?=
 =?utf-8?B?N0hKM0pTQTlrMUxuY1RBOUxRSlFrYXlXV0JPVmJqMlRtYzFsWkJrYXdRaTFV?=
 =?utf-8?B?alZ1dlpVM2tENTQxVmNNaC91UUhKUDdIaTBpb2pMeVlacTlTMUdHRmw3a25H?=
 =?utf-8?B?TER5TzV5dFd3TmM3eTVqRm01TjZsQjNNRVU4UzdoRENiZHRvazA2b0R0ck9R?=
 =?utf-8?B?R2R3eEY5TTd4SmJmTFMrNkQ3US9memo5RkZ0c1ZpQzNveFlQNXBIWFBQemxh?=
 =?utf-8?B?M05hMHd4T0FxaDVZZGRzSlFySHhBWm8zRE5hSWZGbmhnMUsyMkhUR1NrUm5a?=
 =?utf-8?B?eC9YV0xraWVoMG04Um84dkFiekY0Q0VETEhDWGE2MTYxV3RhWkpTVm1lR21u?=
 =?utf-8?B?S0J3YkRBVE5HVUhSL2wwb1NRZGtKTXBUcnY4TDlNRjZFUnVpd3dWT1dKVlZZ?=
 =?utf-8?B?WE15eTRLaXFvNXFjblhGYVJqUHY2Z0hHY3NOdzEvSHJLN01LY21jcjBKUTZk?=
 =?utf-8?Q?jhxSga3BnuJibHNZMXbJIptBciO4UgksGPT8FED?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(7416011)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eTluUm1uMHJIaTZWWDFiVW0zSzhMak9TZTNyWGFMQVliWTAyeWJFZ2dvZHJV?=
 =?utf-8?B?T0xDUCtuZVpyczRUdHU0V0VRYnFzbHczUkt1ckFOL0NxYS9VaFlUZWZUL0k1?=
 =?utf-8?B?YXY0eWhuYllETGpSSE4vSkJxWmh3QktPWGwzZ3ZIV2ZtRUl1TXlTSWhvK2o2?=
 =?utf-8?B?RUgxWWVlcGg0K1prV0hRRzQwcXdNTUl1QkErNU93Z0Q5ZjVwa2xmMG5GR3RP?=
 =?utf-8?B?a2Q4b3JlYnpLK2krQldBc2YvOXpHdU1Gbm5MYm9PY2tzUzV1L09GSnRyWG1u?=
 =?utf-8?B?c0NBNVVIbmd2MjhtbUhBSkI0dDlaaWE3V0FKQlZCRHQ4M3ZZRmJGOW5rTmZi?=
 =?utf-8?B?Mk42R0Y4Znpwb2pTNzBLQUZodzkxTkJUcUdzL2oydnArWXFSUTA3ZG1VbVox?=
 =?utf-8?B?Zmt1L2FYTEZYdTZSVjk2SVhtQU4zbStwVDVDRmdQclAvYXdqUnBwbnRUTSs0?=
 =?utf-8?B?ak5BNjMzOUxLbWhVbitFaG0zRUFTZVBIaTBrajlWbFpqN3VZd0owQW9RU3pR?=
 =?utf-8?B?dy8vYTh3WXQ0ZHJ5VDhpYytPRTdFblJ5aWFqSVZka0pTaFBqazlidnAxWFBr?=
 =?utf-8?B?VXpMUnB0RUpxcXlnMFhlZW5GWGQ5dlNwTktpL244SVcwSkpjNUN5Zld5M0lP?=
 =?utf-8?B?VlEzeFRuOEZvaDlrbjFOSmVsc1UycHQ1WGtXYU4zTkVHQ04yNUdGWEtaTUJp?=
 =?utf-8?B?K1ZnZDQvRG5GaHFIeDNvS2pUeGNDbHc5ZVR4TGlrLytTT3oyN1hlYmFwZ1Yv?=
 =?utf-8?B?QmM0b29hYStvbzRIMjhGK01YUERVbGRkS3BCYVBYcTdSZmRFRDJOWCtQN2o5?=
 =?utf-8?B?L3dBQUdzTk85K3lmNk90MXk1Ym1IUVBnQlZrVFNLWDY4a1oxRTBKWDZIbENT?=
 =?utf-8?B?THV0L1VxUzU0Sm43Wk9PL1JQandkazljOWhRNGg4cXBvLzVmdUlVbWRIdjRB?=
 =?utf-8?B?TG9pUVZzUjlqSCtOeGg0UnVCNGRuSUVQZk1zSmxtOFl2cG9JM09DY0dJY2Q0?=
 =?utf-8?B?Uzl4cjl1LzB2aHExT1ZDRGMxK0NDR0Y3ZkM5QmpQQzJmZEw5UUpUOVZvSi9k?=
 =?utf-8?B?YkFnUUJHQ2tNaGIvcmFPK1pTcWdSV0d4RW04dFFwa0FuSi9oNm9EdXpoa1or?=
 =?utf-8?B?VWgvN0xIWnEyY3o4M2k4NStGOC9HYlhsdElUdFJ1b2VUNnNzRDN2am9ZSXNV?=
 =?utf-8?B?elFuQXdiaGdJZVI0TndYeG1VR3UxWDhhS1pvbUw3WGZ2blV2dnVSQVU4LzB4?=
 =?utf-8?B?N2FlbU11WTJIY3B4Z0tPdUVzcHlXakY1ZEpZZGpobkxreGZDNTlzS0RrREtE?=
 =?utf-8?B?bEFxcnQ5YnJ2dnBpZVlFaWdSbVZrK25yUmZHWDV0QTB2czhTTjIraEY3OVo3?=
 =?utf-8?B?NXZNZm92b2kxQkU4aVoyUWN1UEZ3ajVRS29LTEJxcVhDamR0cWdNZE5POHNU?=
 =?utf-8?B?Y3lrVHlFRDg0RVVSa0lxbGpVbzlKRmVGTUQxZk5mTklwbE9jQ2l1N3RQajNZ?=
 =?utf-8?B?OFpVRmh5MldaZEdwd05FdzBHdjJISnVFcTFiczVDNitpeWhnSk5KYXZyb0Rq?=
 =?utf-8?B?T2FRV29WbHNYWnR0OTl0N1ZNdDNvYy9neis1SmFVMXZ6WllCVEVzVFlqbEJ1?=
 =?utf-8?B?ZEU3eHNxdld2aDZhK3lNaE9oUFBZNDFZK1Jnbi9EMmhCVlFTWkp6R29ZaUVQ?=
 =?utf-8?B?MWcvZlJtOHA4V3pHSmdjRkQ3emh5OS9lS2phTXIwVWJXWDVyVWJ6bFdocUFG?=
 =?utf-8?B?SksrZUJKbWc0TVlQUFNrWmZXOWZiSG92SmZndzlsYjNCdHlnZGJ3SDU0U2dM?=
 =?utf-8?B?RDBpMDkrNVFyTWFoeDRyMXBLT05RbGJFamIwbFo3TGFQcnBLSWtKbnRWeHAx?=
 =?utf-8?B?emdmeXd6a1BCek9JWk12bkk0UmpDZ1BVVTl4dnpQNXc1bDNZY0VpUWRCRERh?=
 =?utf-8?B?N25ld1cybWRjbUN5c3dPb1k1aTNjaXNMQUI3cTVUSWF4UXMvWnRlVWFCWkVN?=
 =?utf-8?B?c0dVV2ttbkRUVi9IQzZ1SzM5ajA0c0hVVCtVbVRUODYrVUxMQkRaRzVHc1R0?=
 =?utf-8?B?OEhqdHJZb1ZjYncydzNMM2lrQzMzL2thUU5OUWs5VVRxYm9uUVN5NHBNbnE1?=
 =?utf-8?B?cXNldEMwNDFhT3FlZXUwdmEwYkIwNkNYdHFEUGJRRTN2ZmtqQzV2MHhuLzRT?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CEBAEC8440D4B4CA3A25F45DA11723D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IQ4CFCnnFv1BE/5T/qeg5pDVPDLed6m49QduBd2VveANqU7x4T5WX2b6i4NMIanSjpyx5yh2Dz90cqC1Q2T754XwAUM/u9dPstgAzvcB10aKx2XsoafNxN/e53EbufA7L9dlQt3Qw1Lb+HKqqBLBsNEzT9QUyySELkGjhGmzfPokFyFL+96xx/smkJ/SMV61VlfqRDRjTTBlnG92A16avTexIOVovGTgQ1uXq2F8H0CLQwt4wsRZDq80RMh3mVRHFUb2qNrCPLJx5NaF/JoKPj0/o9Glfo/9GKG89iaQHjjSN2vl+1xWJRVFHjwA9GAFARXQl0KW3htdrfNDS0J5WljhW49tZRLAfPmLC6Xmb6pqX+D7zfCs+7b8kTuEQWz/P5ml6bvahrK/O3+S4lI73HycFfc9Tsrr+vPSMg2aHd5GVu4lOxEYE8xcYXd1fIO1/56De3FVelqiuOGRwsxuh4XC+kkI3pkR5YiwJDitOpex5MTGlV4r7Pw+XqSBNw0UbRIwMsbOW0HUEN5ae90g66fDU3TYmIjl5l8PuDQxXlBjnctbYtohXa+OPhSfJrHBQi6ClgoFMn8jqR8rPmlgylm92uV3Isv0Mw3frPCGbyo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7c5933-bbeb-46c2-9032-08dc916624ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 20:18:26.7323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QTSa4+vph0ERE8Y+LMyJ2PxnE8XMGbkptF5vSJE09ZdznEaRTCfkH4Vy8ASm+H5tsagW80qkECTNxZLPHfQEbJO2lUG8HF43cRFqOy7FJIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7110
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_08,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406200148
X-Proofpoint-GUID: P1pipZQmDU7jd6O3IsuHPOisBCC0z7XW
X-Proofpoint-ORIG-GUID: P1pipZQmDU7jd6O3IsuHPOisBCC0z7XW

DQoNCj4gT24gSnVuIDE5LCAyMDI0LCBhdCA5OjIy4oCvQU0sIE1pbWkgWm9oYXIgPHpvaGFyQGxp
bnV4LmlibS5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCAyMDI0LTA1LTMwIGF0IDE4OjM5IC0w
NjAwLCBFcmljIFNub3diZXJnIHdyb3RlOg0KPj4gSW50cm9kdWNlIGEgbmV3IExTTSBjYWxsZWQg
Q2xhdmlzIChMYXRpbiB3b3JkIG1lYW5pbmcga2V5KS4gIFRoZSBtb3RpdmF0aW9uDQo+PiBiZWhp
bmQgdGhpcyBMU00gaXMgdG8gcHJvdmlkZSBhY2Nlc3MgY29udHJvbCBmb3Igc3lzdGVtIGtleXMu
ICBCZWZvcmUgc3BlbmRpbmcNCj4+IG1vcmUgdGltZSBvbiB0aGlzIExTTSwgSSBhbSBzZW5kaW5n
IHRoaXMgYXMgYW4gUkZDIHRvIHN0YXJ0IGEgZGlzY3Vzc2lvbiB0byBzZWUNCj4+IGlmIHRoZSBj
dXJyZW50IGRpcmVjdGlvbiB0YWtlbiBoYXMgYSBwb3NzaWJpbGl0eSBvZiBiZWluZyBhY2NlcHRl
ZCBpbiB0aGUNCj4+IGZ1dHVyZS4NCj4+IA0KPj4gVG9kYXkgdGhlIGtlcm5lbCBoYXMgdGhlIGZv
bGxvd2luZyBzeXN0ZW0ga2V5cmluZ3M6IC5idWlsdGluX3RydXN0ZWRfa2V5cmluZywNCj4+IC5z
ZWNvbmRhcnlfdHJ1c3RlZF9rZXlyaW5nLCBhbmQgdGhlIC5tYWNoaW5lLiAgSXQgYWxzbyBoYXMg
dGhlIC5wbGF0Zm9ybQ0KPj4ga2V5cmluZyB3aGljaCBoYXMgbGltaXRlZCBjYXBhYmlsaXRpZXM7
IGl0IGNhbiBvbmx5IGJlIHVzZWQgdG8gdmVyaWZ5IGEga2VybmVsDQo+PiBmb3Iga2V4ZWMuDQo+
IA0KPiBQbGVhc2Ugc3RhcnQgdGhlIGNvdmVyIGxldHRlciB3aXRoIHRoZSBwcm9ibGVtIGRlc2Ny
aXB0aW9uL21vdGl2YXRpb24sIG5vdCB0aGUNCj4gc29sdXRpb24uDQo+IA0KPiBGcm9tIGh0dHBz
Oi8vZG9jcy5rZXJuZWwub3JnL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLmh0bWw6DQo+IA0K
PiAiRGVzY3JpYmUgeW91ciBwcm9ibGVtLiBXaGV0aGVyIHlvdXIgcGF0Y2ggaXMgYSBvbmUtbGlu
ZSBidWcgZml4IG9yIDUwMDAgbGluZXMNCj4gb2YgYSBuZXcgZmVhdHVyZSwgdGhlcmUgbXVzdCBi
ZSBhbiB1bmRlcmx5aW5nIHByb2JsZW0gdGhhdCBtb3RpdmF0ZWQgeW91IHRvIGRvDQo+IHRoaXMg
d29yay4gQ29udmluY2UgdGhlIHJldmlld2VyIHRoYXQgdGhlcmUgaXMgYSBwcm9ibGVtIHdvcnRo
IGZpeGluZyBhbmQgdGhhdA0KPiBpdCBtYWtlcyBzZW5zZSBmb3IgdGhlbSB0byByZWFkIHBhc3Qg
dGhlIGZpcnN0IHBhcmFncmFwaC4iDQo+IA0KPiBGb3IgZXhhbXBsZSwNCj4gDQo+IEFkZGl0aW9u
YWwga2V5cyBub3QgYnVpbHQgaW50byB0aGUga2VybmVsIGNvdWxkIG9yaWdpbmFsbHkgYmUgbG9h
ZGVkIG9udG8gdGhlDQo+IC5zZWNvbmRhcnlfdHJ1c3RlZF9rZXlyaW5nICpvbmx5KiBpZiB0aGV5
IHdlcmUgc2lnbmVkIGJ5IGEga2V5IGJ1aWx0IGludG8gdGhlDQo+IGtlcm5lbCBvciBieSBhIGtl
eSBhbHJlYWR5IG9uIHRoZSAuc2Vjb25kYXJ5X3RydXN0ZWRfa2V5cmluZy4gIFRoZSBjb25jZXJu
IGZvcg0KPiB1c2luZyB0aGUgd3Jvbmcga2V5IGZvciBzaWduYXR1cmUgdmVyaWZpY2F0aW9uIHdh
cyBtaW5pbWFsLiAgV2l0aCB0aGUgYWJpbGl0eSBvZg0KPiBsb2FkaW5nIE1hY2hpbmUgT3duZXIg
S2V5cyhNT0spIGtleXMgb250byB0aGUgLm1hY2hpbmUga2V5cmluZywgd2hpY2ggaXMgbGlua2Vk
DQo+IHRvIHRoZSAuc2Vjb25kYXJ5X3RydXN0ZWRfa2V5cyBrZXlyaW5nLCBrZXkgdXNhZ2UgaXMg
YSByZWFsIGNvbmNlcm4uDQo+IA0KPiBUbyBsaW1pdCBrZXkgdXNhZ2UgLi4uDQoNCkknbGwgY2hh
bmdlIHRoaXMgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KPj4gDQo+PiBUb2RheSB0aGUga2VybmVs
IGFsc28gdHJhY2tzIGtleSB1c2FnZSBmb3IgdmVyaWZpY2F0aW9uIGRvbmUgd2l0aCBhbnkgb2Yg
dGhlc2UNCj4+IGtleXMuIEN1cnJlbnQgdmVyaWZpY2F0aW9uIHVzYWdlIGluY2x1ZGVzOiBWRVJJ
RllJTkdfTU9EVUxFX1NJR05BVFVSRSwNCj4+IFZFUklGWUlOR19GSVJNV0FSRV9TSUdOQVRVUkUs
IFZFUklGWUlOR19LRVhFQ19QRV9TSUdOQVRVUkUsDQo+PiBWRVJJRllJTkdfS0VZX1NJR05BVFVS
RSwgVkVSSUZZSU5HX0tFWV9TRUxGX1NJR05BVFVSRSwgYW5kDQo+PiBWRVJJRllJTkdfVU5TUEVD
SUZJRURfU0lHTkFUVVJFLiBBZnRlciB0aGVzZSB1c2FnZSB0eXBlcyB3ZXJlIG9yaWdpbmFsbHkN
Cj4+IGludHJvZHVjZWQsIG1vc3QgYWRkaXRpb25zIGhhdmUgdHlwaWNhbGx5IHVzZWQgdGhlDQo+
PiBWRVJJRllJTkdfVU5TUEVDSUZJRURfU0lHTkFUVVJFLg0KPj4gDQo+PiBBdCB0aGUgbW9tZW50
LCBiZXNpZGVzIHRoZSB1c2FnZSBlbmZvcmNlbWVudCBmb3IgLnBsYXRmb3JtIGtleXMsIGFueSBr
ZXkNCj4+IGNvbnRhaW5lZCB3aXRoaW4gdGhlIHN5c3RlbSBrZXlyaW5ncyBjYW4gYmUgdXNlZCBm
b3IgYW55IHZlcmlmaWNhdGlvbg0KPj4gcHVycG9zZS4gIEZvciBleGFtcGxlLCBhIGtleSB0aGF0
IHdhcyBvcmlnaW5hbGx5IGNyZWF0ZWQgdG8gc2lnbiBrZXJuZWwNCj4+IG1vZHVsZXMgY291bGQg
YmUgdXNlZCBmb3IgQlBGIHZlcmlmaWNhdGlvbi4NCj4+IA0KPj4gVGhpcyBuZXcgTFNNIGFkZHMg
dGhlIGFiaWxpdHkgdG8gZG8gYWNjZXNzIGNvbnRyb2wgZm9yIGFsbCBzeXN0ZW0ga2V5cy4gV2hl
bg0KPj4gZW5hYmxlZCwgb25seSB0aGUgLmJ1aWx0aW5fdHJ1c3RlZF9rZXlzIGFyZSBhdmFpbGFi
bGUgZm9yIGxvYWRpbmcga2VybmVsDQo+PiBtb2R1bGVzIGFuZCBkb2luZyBhIGtleGVjLiAgVW50
aWwgYW4gQUNMIGVudHJ5IGlzIGFkZGVkIGZvciBhIHNwZWNpZmljIGtleSwgbm8NCj4+IG90aGVy
IHN5c3RlbSBrZXkgbWF5IGJlIHVzZWQgZm9yIGFueSBvdGhlciBwdXJwb3NlLg0KPiANCj4gS2V5
cyBzdG9yZWQgb24gdGhlIC5idWlsdGluX3RydXN0ZWRfa2V5cyBrZXlyaW5nIHNlZW0gdG8gYWx3
YXlzIGJlIHBlcm1pdHRlZCwNCj4gaW5kZXBlbmRlbnQgb2YgYSBDbGF2aXMgcnVsZSwgd2hpY2gg
aXMgZmluZSwgYnV0IHRoZSBhYm92ZSBwYXJhZ3JhcGggbmVlZHMgdG8gYmUNCj4gcmUtd29yZGVk
DQoNCkFuZCB0aGlzIHRvby4NCg0KPj4gDQo+PiBFbmFibGluZyB0aGUgTFNNIGlzIGRvbmUgZHVy
aW5nIGluaXRpYWwgYm9vdCBieSBwYXNzaW5nIGluIGEgc2luZ2xlIGFzeW1tZXRyaWMNCj4+IGtl
eSBpZCB3aXRoaW4gYSBuZXcgImNsYXZpcz0iIGJvb3QgcGFyYW0uIFRoZSBhc3ltbWV0cmljIGtl
eSBpZCBtdXN0IG1hdGNoIG9uZQ0KPj4gYWxyZWFkeSBjb250YWluZWQgd2l0aGluIGFueSBvZiB0
aGUgc3lzdGVtIGtleXJpbmdzLiAgSWYgYSBtYXRjaCBpcyBmb3VuZCwgYQ0KPj4gbGluayBpcyBj
cmVhdGVkIGludG8gdGhlIG5ldyAuY2xhdmlzIGtleXJpbmcuICBUaGlzIGtleSBzaGFsbCBiZSB1
c2VkIGFzIHRoZQ0KPj4gcm9vdCBvZiB0cnVzdCBmb3IgYW55IGtleXJpbmcgQUNMIHVwZGF0ZXMg
YWZ0ZXJ3YXJkcy4NCj4+IA0KPj4gT24gVUVGSSBzeXN0ZW1zIHRoZSAiY2xhdmlzIiBib290IHBh
cmFtIGlzIG1pcnJvcmVkIGludG8gYSBuZXcgVUVGSSB2YXJpYWJsZQ0KPj4gd2l0aGluIHRoZSBF
Rkkgc3R1YiBjb2RlLiBUaGlzIHZhcmlhYmxlIHdpbGwgcGVyc2lzdCB1bnRpbCB0aGUgbmV4dCBw
b3dlciBvbg0KPj4gcmVzZXQuICBUaGlzIHNhbWUgdHlwZSBvZiBmdW5jdGlvbmFsaXR5IGlzIGRv
bmUgd2l0aGluIHNoaW0uIFNpbmNlIHRoaXMNCj4+IHZhcmlhYmxlIGlzIGNyZWF0ZWQgYmVmb3Jl
IEV4aXRCb290U2VydmljZXMgKEVCUykgaXQgd2lsbCBub3QgaGF2ZSB0aGUgTlZSQU0NCj4+IGJp
dCBzZXQsIHNpZ25pZnlpbmcgaXQgd2FzIGNyZWF0ZWQgZHVyaW5nIHRoZSBCb290IFNlcnZpY2Vz
IHBoYXNlLiBUaGlzIGlzDQo+PiBiZWluZyB1c2VkIHNvIHRoZSAiY2xhdmlzIiBib290IHBhcmFt
IGNhbiBub3QgYmUgY2hhbmdlZCB2aWEga2V4ZWMsIHRoZXJlYnkNCj4+IHByZXZlbnRpbmcgYSBw
aXZvdCBvZiB0aGUgcm9vdCBvZiB0cnVzdC4NCj4gDQo+IE1vdmUgdGhpcyBwYXJhZ3JhcGggKGFu
ZCBwYXRjaCkgdG8gbGF0ZXIuICBEZWZpbmluZyBhIG5ldyBVRUZJIHZhcmlhYmxlIG1ha2VzIGl0
DQo+IG1vcmUgZGlmZmljdWx0IHRvIHRlc3QuICBDb25zaWRlciBkZWZlcmluZyBpbnRyb2R1Y2lu
ZyB0aGUgbmV3IFVFRkkgdmFyaWFibGUNCj4gcGF0Y2ggdG8gdGhlIGVuZC4NCg0KSSdsbCBtb3Zl
IGl0IHRvIHRoZSBlbmQgdG8gaGVscCB3aXRoIHRlc3RpbmcuDQoNCj4+IA0KPj4gQXMgbWVudGlv
bmVkIGVhcmxpZXIsIHRoaXMgTFNNIGludHJvZHVjZXMgYSBuZXcgLmNsYXZpcyBrZXlyaW5nLiAg
Rm9sbG93aW5nDQo+PiBib290LCBubyBuZXcgYXN5bW1ldHJpYyBrZXlzIGNhbiBiZSBhZGRlZCB0
byB0aGlzIGtleXJpbmcgYW5kIG9ubHkgdGhlIGtleQ0KPj4gZGVzaWduYXRlZCB2aWEgdGhlIGlu
aXRpYWwgYm9vdCBwYXJhbSBtYXkgYmUgdXNlZC4gVGhpcyBMU00gY2FuIG5vdCBiZSBzdGFydGVk
DQo+PiBhdCBhbnkgb3RoZXIgcG9pbnQgaW4gdGltZS4gIFRoZSAuY2xhdmlzIGtleXJpbmcgYWxz
byBob2xkcyB0aGUgYWNjZXNzIGNvbnRyb2wNCj4+IGxpc3QgZm9yIHN5c3RlbSBrZXlzLiBBIG5l
dyBrZXkgdHlwZSBjYWxsZWQgY2xhdmlzX2tleV9hY2wgaXMgYmVpbmcgaW50cm9kdWNlZC4NCj4+
IFRoaXMgY29udGFpbnMgdGhlIHVzYWdlIGZvbGxvd2VkIGJ5IHRoZSBhc3ltbWV0cmljIGtleSBp
ZC4gVG8gYmUgYWRkZWQgdG8gdGhlDQo+PiBjbGF2aXMga2V5cmluZywgdGhlIGNsYXZpc19rZXlf
YWNsIG11c3QgYmUgUy9NSU1FIHNpZ25lZCBieSB0aGUgc29sZSBhc3ltbWV0cmljDQo+PiBrZXkg
Y29udGFpbmVkIHdpdGhpbiBpdC4gTmV3IEFDTCBhZGRpdGlvbnMgdG8gdGhlIC5jbGF2aXMga2V5
cmluZyBtYXkgYmUgYWRkZWQNCj4+IGF0IGFueSB0aW1lLg0KPiANCj4gT2suIFRvIHN1bW1hcml6
ZSwgdGhlIENsYXZpcyBwb2xpY3kgcnVsZXMgYXJlIGxvYWRlZCBhdCBydW50aW1lIG9udG8gdGhl
IC5jbGF2aXMNCj4ga2V5cmluZy4gIFRoZSBDbGF2aXMgcnVsZXMgbXVzdCBiZSBzaWduZWQgYnkg
dGhlIGtleSBzcGVjaWZpZWQgb24gdGhlICJjbGF2aXM9Ig0KPiBib290IGNvbW1hbmQgbGluZS4g
IFRoZSBvbmx5IGtleSBvbiB0aGUgLmNsYXZpcyBrZXlyaW5nIGlzIHRoZSBvbmUgc3BlY2lmaWVk
IG9uDQo+IHRoZSBib290IGNvbW1hbmQgbGluZS4NCj4gDQo+IEFzIGZhciBhcyBJJ20gYXdhcmUs
IHRoaXMgd291bGQgYmUgdGhlIGZpcnN0IHRpbWUgcG9saWN5IHJ1bGVzIGFyZSBzdG9yZWQgaW4g
YQ0KPiBrZXlyaW5nLg0KDQpJIGJlbGlldmUgdGhhdCBpcyB0aGUgY2FzZSwgYW5kIHdvdWxkIGxp
a2UgdG8gaGVhciBpZiB0aGlzIGNvdWxkIGJlIGEgcG90ZW50aWFsbHkgDQphY2NlcHRhYmxlIHNv
bHV0aW9uLiAgSXQgc2ltcGxpZmllcyB0aGluZ3MgaW4gbWFueSBhc3BlY3RzLiBJdCBoYXMgZmV3
ZXIgZGVwZW5kYW5jaWVzLA0KY3VycmVudCB1c2VyLXNwYWNlIHRvb2xzIHdvcmsgd2l0aCBpdCBh
bHJlYWR5LCBldmVyeXRoaW5nIGlzIHNlbGYgY29udGFpbmVkIHdpdGhpbiB0aGlzIA0Ka2V5cmlu
ZywgZXRjLg0KDQpUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2suDQoNCg==

