Return-Path: <linux-efi+bounces-2901-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B32BA559C5
	for <lists+linux-efi@lfdr.de>; Thu,  6 Mar 2025 23:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA3907A6DAB
	for <lists+linux-efi@lfdr.de>; Thu,  6 Mar 2025 22:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F31F27C857;
	Thu,  6 Mar 2025 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E2IUmfwE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MjeUyNVQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782FD1FC11F;
	Thu,  6 Mar 2025 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741300182; cv=fail; b=UGzaROMPjFZUbqbeq/TWWKCyp9+p1YFXJvEhekShclOGuW/s05D41k7yE5BqnKzhi3NdBW+gEGEvX0p6Fv93gx94d5v3dx5wLtuZLBA1jg4BkMzliam7bRcDzsubc6k6DyiC4eXD0A8f57LqWSWly97PAEGdYY0LyU9fhRNP3Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741300182; c=relaxed/simple;
	bh=EZNIB4hmeuS5SQvEm/E4l4u4nMWdM4JFb7106NQYYhU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KYhEfuuoRhFMHKtmG+POibgxyOKXOhT9710EUax+5GKLs+TYSD63XVNB1/XnrW5gecUDBlQyhujS2xI1fhMijWQhjDlClFWaACeFkw2p8lcun2gqaS3PqOpET9zMBaUmNWqXDh3lGwQWEzimF2q+UMRe8nwq6DOH7EZDwa5tZrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E2IUmfwE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MjeUyNVQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526LBsEF023412;
	Thu, 6 Mar 2025 22:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=EZNIB4hmeuS5SQvEm/E4l4u4nMWdM4JFb7106NQYYhU=; b=
	E2IUmfwEYavFFVwtYfwwu5oM/XVCu7MhfMK8VOlRc7U20NxI7r7vT4tg9btzKA/l
	mQmLAs7Ox8w2q66fv4BMkR7EEurajpD3XMbgqVS/sy7jpLEyfA1dVfSLI5ZeCPAr
	J9xNOCcTtRtVKUTh2XO7g5A7naxyBKiRVm8c2990+dP+gvKPl+kBiDwvzyjcyWWn
	MTLjgrOhd4ig8crSGHPxWf6rQPdrJMgZq8H0v6KGRgAf2MoPCA4VtzvHMskfQg2D
	vanLzIBNZfynTTijZfuDZnOVVDLO1vtw11khtgCdc2Mmz3gvT4FxahJ6rELIYuW+
	ea8VMTzUos6Cc43kmUfhHQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u9qk9cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 22:29:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 526MCdPu039151;
	Thu, 6 Mar 2025 22:29:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpdfm3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 22:29:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oaGsFN+ux8zYxJfhnsErWxXh//5T0OoydQd8PEOWpBCwFhZ8RUzCSVjhsIeXiIu1HZnatdyhvfRXOYyL+VbITr2TJiHEU7GhADv9AxFDtHCVdizZ0ul0XxJEp8UqmXBalQc6uWRnu7TNtMc3UGBYh68uqzYLZXDbuj9whQnVW0HVODveROq2BF0IxT+Ra/arSVbhnUCBq7FY8uKpRj2icmivi8oj+yagb+SGuIPiWnEZ/dlkcUJIok8samKUPzRPQ6SfRjmcMIBVZC9JSh3tP7tvTF1p8QtHeUaV5cKyAK8xEfadbjsqyvnLQdSTCPwWmvoJy7Lv8I0NBuawEyn0Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZNIB4hmeuS5SQvEm/E4l4u4nMWdM4JFb7106NQYYhU=;
 b=BdjIYVGZQ/KO9KRmGCmE4QY0DumhU0+nFQtyk2ZdUy6IsuCbLeQ+e7qyQoK+bSTSXKhnifNPVfLVEdl2xR23qP1ZfXNOJsSLajjReE11SODFLV9ZFnj2fkIFaEwxpMb61TDMdBbNSC46h4z5RmIBlOp2cjwYf/QjXmFgVwcpAU/dv8BgY/9qHfsLOleRRhcvCQNu9OwKl6cgEYR6QgMZGUqNLHnQ1VdM87OiTooQt5wldztnCRiAsdWkqE45JhYq7dXnoDIVa+77OJDioCI9C0BmnLYJghpBGygsh5mByIg3T7yt/5oQ9WrtRaCulHJ6Ve8BWkGojY91rezIigT8wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZNIB4hmeuS5SQvEm/E4l4u4nMWdM4JFb7106NQYYhU=;
 b=MjeUyNVQECugOhYsTtzxW8GQI7Jy31G4nKi8VqhdR8rhLK5ENLgNIfO7KLb08oSTRaisi9cxgeGAbF/T9jZcMsxTzYkmIAd6kWQQpFpG4gJm5rkXwUY02oGB44FFFOfqeQ1XgywUoRLsxRK+1Bzq43QUI+C53l5xHyl7lnRatpc=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by SA1PR10MB6445.namprd10.prod.outlook.com (2603:10b6:806:29d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 22:28:57 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 22:28:57 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: Paul Moore <paul@paul-moore.com>
CC: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "open list:SECURITY SUBSYSTEM"
	<linux-security-module@vger.kernel.org>,
        David Woodhouse
	<dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>, James Morris <jmorris@namei.org>,
        "Serge E.
 Hallyn" <serge@hallyn.com>,
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
Subject: Re: [RFC PATCH v3 00/13] Clavis LSM
Thread-Topic: [RFC PATCH v3 00/13] Clavis LSM
Thread-Index:
 AQHbIK0E/vdc4Eou30K4SgPRfeDFerL0Jc4AgBIDLwCAAF1+gIADEbkAgADjnYCAUfK8AIAAHD0AgAEIXICAACNLAIAAGwsAgAUHzgCAAQ2/gIAAoSGAgAFh24CAAD5VgIABZIsA
Date: Thu, 6 Mar 2025 22:28:57 +0000
Message-ID: <EB757F96-E152-4EAB-B3F7-75C1DBE3A03B@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <c490397315c2704e9ef65c8ad3fefedb239f1997.camel@linux.ibm.com>
 <72F52F71-C7F3-402D-8441-3D636A093FE8@oracle.com>
 <CAHC9VhRHEw5c+drC=aX4xTqWoQJJZ+qkJ7aHUT5dcu+Q5f7BqA@mail.gmail.com>
 <CAHC9VhSJpnaAK1efgs1Uk0Tr3CaDNR1LiDU-t_yDKDQG6J-74Q@mail.gmail.com>
 <E20C617B-EA01-4E69-B5E2-31E9AAD6F7A2@oracle.com>
 <506e8e58e5236a4525b18d84bafa9aae80b24452.camel@linux.ibm.com>
 <CAHC9VhTsZntLdGBV7=4suauS+rzSQv1O4UAoGcy2vEB02wRkoA@mail.gmail.com>
 <c580811716f550ed5d6777db5e143afe4ad06edc.camel@linux.ibm.com>
 <CAHC9VhTz6U5rRdbJBWq0_U4BSKTsiGCsaX=LTgisNNoZXZokOA@mail.gmail.com>
 <FD501FB8-72D2-4B10-A03A-F52FC5B67646@oracle.com>
 <CAHC9VhR961uTFueovLXXaOf-3ZAnvQCWOTfw-wCRuAKOKPAOKw@mail.gmail.com>
 <73B78CE7-1BB8-4065-9EBA-FB69E327725E@oracle.com>
 <CAHC9VhRMUkzLVT5GT5c5hgpfaaKubzcPOTWFDpOmhNne0sswPA@mail.gmail.com>
 <1A222B45-FCC4-4BBD-8E17-D92697FE467D@oracle.com>
 <CAHC9VhTObTee95SwZ+C4EwPotovE9R3vy0gVXf+kATtP3vfXrg@mail.gmail.com>
In-Reply-To:
 <CAHC9VhTObTee95SwZ+C4EwPotovE9R3vy0gVXf+kATtP3vfXrg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|SA1PR10MB6445:EE_
x-ms-office365-filtering-correlation-id: e7161bcc-8bb8-4504-6369-08dd5cfe4921
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QVFBUklreC9uNUtyemZGM0V3VXRscHFlSTJoaVRGN3FudnorbFFKS1ZZL3ZW?=
 =?utf-8?B?RlhEWERMK2tlb0Y3bmRJN21INTdxY01VOWZWK05tZ2VWdVVJVi9ZV1RUeGho?=
 =?utf-8?B?Y0huemR5VmVCMlBIVWRnV29ZcGtpQnY0ZHRMcVJlcXl5eTdVNWxDUnZDNktC?=
 =?utf-8?B?aS9Yb0trQW54MkJ4Mm1XTkx4bk9ILzFZRDZOM1V4VTNXcHR6MUJxQ1d1VEI0?=
 =?utf-8?B?MzlacWVTOGdTdFZYY0hKcCtmUk9qV1RkRENHM2EvaFo4YWU5SVQraUtaU3Jh?=
 =?utf-8?B?RkJPbFpma3ltelFlWStFdWdtWEVqdGM3YnBkUmtIL1VkazMzdXZFMjlYdkdp?=
 =?utf-8?B?ZlFhNGx4YWNTdjc0OGdGTXJVTmdzYVB3eitIUjZsUXJVTFZtK0IxV1VJQTBa?=
 =?utf-8?B?ODRSSUpQc2wzelpXTndzTHZpRkkzYmRSVi9kc1pjREt3aEQ3OEVjMytBbG81?=
 =?utf-8?B?d1FPRmd3Z0J1T3VaRjRNMDRidGFrUWpzdzlLbEhiMEtlOEhQazFoZEJIOHpK?=
 =?utf-8?B?cDdoTXlZMWxML3NkaHFJQ2dCdkhwUVJtYSt6YnRJTlJaeXRwbTBVRXZFN1FW?=
 =?utf-8?B?aEd6Znp3YmoxckdFN0EvRUJoZlFKemJCZ1AvV3BOM3hTcDd0MjJBTEZhdEw3?=
 =?utf-8?B?cTloZk1rdCtnS0NZNlpqNnB2TmlJelBCanozaDAzSjRaYmt4aXBTYXlkaUlv?=
 =?utf-8?B?UllxQmtrVU5PeTNSR3N0T0ZQOUtpWE1zT05IYjJpaU9VNGVTQ1RyZmNscFIv?=
 =?utf-8?B?THViSjlvUEQ4bjZ3emMwcXVFTm5MV1NtRHlNM09DVnBHTklUdmYvbFBLNmFa?=
 =?utf-8?B?Yk80M1RUekNEUFpFb2JuN29obmFpV01YclVOeFFielFobFdVTG0xU3JXelN5?=
 =?utf-8?B?R2IyODViSCt1QUpDZzdmUkJDckFUbWFtc0V0YzlqblllWXNqWEtTR1VvMTM4?=
 =?utf-8?B?bnBlZmt6eUtwUjNSY0dxellHRWxyZExoTEppK3RGQlJxVi9MWFMyTGh2OEZG?=
 =?utf-8?B?OG9xdHFHdFFKaFArVFhOVnFSN0ErRDNUMmUzU2pyTldMYmM2b2VIOEhubG50?=
 =?utf-8?B?NjRBTEl1WFRDQmtLRjZ1RGRLQ0x6cWd4VEVUR1lGb01KK0YycnZoOGhaaEdX?=
 =?utf-8?B?N29rbHR3eXNuMG5DMHBVOG9QT2UxRzRNMGlFYWl2OGtPRjc3Y1RqWEh6RHhk?=
 =?utf-8?B?Mi95emRhTDh1Zk5QbWs4bWowbHNDVWNvUUJuSnB1ZXhRK2p0SnFCSi9GN21s?=
 =?utf-8?B?bmpjSlh0cEUzU0NXRkR5Y3dUVHJUbVlwd0xVSFRQaG1rN0dVV0dWYzc5dWFL?=
 =?utf-8?B?d1UxREdhdXQvUWZFaDQvU3FHVnYvWnNZcUcvbW9oRDdmY2dVcThraDBmdDZy?=
 =?utf-8?B?UDEvaUJqRUV4L1FON0ZSdWhjTTJCRzBrdVRXa0hPZXFaK3VUV2lRMXVHRUky?=
 =?utf-8?B?R1dwdGMyaVVBbkhyd0x2T1ljRkswQUVwZ1d0Uk9mN2o4Z1NUd3hQQmVmVEp1?=
 =?utf-8?B?NElXM25RUDhJYnk0bUxMYU1OWlE2ZHhlMG01VS83TmhESHpma1k2UlZyaXRq?=
 =?utf-8?B?SjN0NmFQOWFBOTgxeEw4N0k0WTZrUVhHOXMyaFZZcW5WSm1wZnpGVTRUUzNQ?=
 =?utf-8?B?SEZPT2FkMGltNkx3SE5lNzcrUzBVRzFYTlZhKzNEUVRBb2VCb0Q2VUlGZlVR?=
 =?utf-8?B?SzZZYis4T0N2T1I0amtGNzA3ZVBnbVRGcTZZdXVsSkNUNjBzUDZYaXo3OHpT?=
 =?utf-8?B?OWcyQkJHVjNsSDF0ZzRnSFhIRi9QY0NlcWkvdE02d3ZLb01iWWJCNGlnc21m?=
 =?utf-8?B?SENldWh4eTBJOHBFaEc1ZDF0UmQxbTB0QVZtbkhrUkovNUZjTnFTWUdpMFRG?=
 =?utf-8?B?dm1wZCs0MllXWUV5VUcwU0wrdlV3Sjh0T0daWWxPWlV0aTlsaVpzU0VmaDhk?=
 =?utf-8?Q?GIbnstCuRqVKpXBNYo8vS6GhUnPcfAQF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZEdIc01aeTNQbnAwUTViamVPTngxZ1NRMk9IQXdMaTIxWERjRW1hZ2s0dVVD?=
 =?utf-8?B?eXBaTFZrVVR5NzEzUUloMi9sbUZBd2wrNXlhWDI5ZzZmOVZNcWFtRUtCL1NS?=
 =?utf-8?B?bVJEbUNJVE1KZWw3U3dZckJVZEw0OWdyZkJhQjAvcXFhK2toYWx3VXhkNFJM?=
 =?utf-8?B?R2dGdGFGcmVGOWFOaTl0QmhtQ0ZrLzVGaXJFRnVQZ0VZWUVRcnhZeHExZXlo?=
 =?utf-8?B?Y3lZTXcxZWcvNnpTOU0xTVNPVWFjOUZkZ2tzaGlwVE1CcWc4ZlIvSkdTUk1p?=
 =?utf-8?B?eERhV2tSWSt5ck5rb3RCUW02cmVWRitrTStMTW1EWjBYQ1J0WjNvN0cveWtv?=
 =?utf-8?B?UGF3ZVNMWmRmdU94a2RsNXlnMFRmU2FFWXFiNkM2ZmdNVnlWc0ROSzNteVln?=
 =?utf-8?B?Z1kzRllyVlUxY3p1L1YzelcySU91aFVUMVVrREhtTlFCcHE0citXS0dDS05E?=
 =?utf-8?B?bk5BeGtpa255R1BIazZlMXFOR1pNL0NkZ0Y4Wk9aUFVYRzZHUU1lSUFlUjhh?=
 =?utf-8?B?dkFZMnlZUEppYWRXQ2pLL0lrQVhLM3B3SkpiRGxpN3pGQVlmVFpSOENPTjBC?=
 =?utf-8?B?K0lGOUNTMEJzOUgvMXZvT2ZRcGoxTGpaNFcxUUpYZGg0ZThaZ3BKazRvWk1C?=
 =?utf-8?B?UjhSclJrVjlhbUkvb29jWDhJTytPQUF5YUNtNUF1NEVTRlYvU2FhaEJhd0Vk?=
 =?utf-8?B?QVI0Z0Y3dzBvVEI4dFlWdTczc1RGSkNDU2NSS1g5QXJZUlRuZHZkQkFaQ3hE?=
 =?utf-8?B?YUNuQ0NVdUhDb0Uwd1ovOFZSK1I5Y2FYb3ZBV2ZUdUJSSHJwNmduU2dzTm56?=
 =?utf-8?B?VXgxV2RnVkRQUG1ORkdtcVRHdS9vT2x6RENxRkpWVmpOZEMrVmhxUFhNZlRt?=
 =?utf-8?B?YmVPV0VYKy9Ub3pHNHRiYlBoMHlZVU1ZZW9FSGtEWEV6SFNLbVhhNnoyOFg1?=
 =?utf-8?B?aTlKV2hCckhET1c3NGlldytUN0wwKzhwUHNIQTFxZmZmUnpHTG1zK2NDM3hI?=
 =?utf-8?B?QjF4cTFNaGNTV3BUK0EwazNSZndZcm9kVURvbVl5dFdzaHN0cUZPWVpTUENn?=
 =?utf-8?B?SHJObnVOSENLM3pZSEZJZldLcWxMWWZYYVdMSHptbW8xVERpdlF4ck5VemI0?=
 =?utf-8?B?dlJ4V2lqVE5jZFJ5aGgyd2NGRWVlUjZ1YXR0dVZ2bTNXOVo1VjY3bDlFZmI0?=
 =?utf-8?B?dmhLdWVCUGx4R1pMdnplTEo5WE8zTmhaNjNuU2tVazVnU01DTnhIWmYzVXdr?=
 =?utf-8?B?aEZUVlZMVG13WWpJK3QvM0tGUXloSzVjUW90WkJpVS9xZlRZcFRrRnNMdVpj?=
 =?utf-8?B?YjNHMzR0Y1ZrM25JUEpDQ2JTaFRyNE1BbjZ3b21lbHB4Z1RodWhSV1VlUVhp?=
 =?utf-8?B?V3NHT1pzWVZ6OENyQS9EOENLOWdNN1VoYlZXWWdTRHFnR0ozZVg4NGFjZEZ0?=
 =?utf-8?B?TzFFSVdGcWJEaFovU3o0NWFlc05sYmxZbHB2V1lRaDBUeXlEbTF5cCt2VmVt?=
 =?utf-8?B?cVBDZS9IVlNlRzBPWmF6dFJUM1NwWEszWlpudXhGektBN2EyQnZJUW5tLzVO?=
 =?utf-8?B?OWRONDArSEdoY1JoV1FObnYwb245SUF6STArRkpmVmUrZnVFYXZOWmVvSHZ4?=
 =?utf-8?B?M29hYUJ6UDlBek5KMUxwSE5NNnhEVnRFMmJQYzlGZkkzQzZtZFNtd2RxdkJF?=
 =?utf-8?B?aGZFNWtLa2tDU2RwMUhodHlkZ0FHdGdNa1FldkVXYitRNDRnZUtRcDRaVkFz?=
 =?utf-8?B?KzkwK2pHMzFSRVB2ei8xQ3hzTGNJbWE1RXJReVNEWVlscTNMTFFZZitzTHEw?=
 =?utf-8?B?RGo0UmhEUWs5eFZHRzRGWkEyb2l5b3cwQW92WlJuRm45Nk1Ubmd5WUEvL2t2?=
 =?utf-8?B?TTVFVFY2TUhKQVBYNE9kNHdpaDZ1bDRIcHk5NUVhdEpWK1ZCcU1HODVvd05Y?=
 =?utf-8?B?djRHNFR3WHIwQnhxRTRFdTJnT04xZjdSekZXdExaZEpROHRMSGJpSTZoR3Vv?=
 =?utf-8?B?QVlQVWdEOUdjTDFERlozbU1JdjBFT212cXpoK1ZqZ25STXBRQUZSSzF4eEpE?=
 =?utf-8?B?THlORElCa0pKRDJIY1MzcEsxT1N2QzNkbEZ5akVxSFVQWW1pTDlrR09wdk1j?=
 =?utf-8?B?b2JoWXFBV1ZRUW11b2F5MitkR3k0S2c0Vm9XSmpNMWVLNW9TU1FxMDNXcTAr?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC9293DEF99CC34D80660347CE0971D3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O0LLlx87e9yJFh0nq0bm90/DapeEfMpJQV2/TGaw+2CWHfmzMdNU0GGpwb/65OXE+J5KF+H2t7DyCkuqjY7gs0aOWMw9eqId5SK8l7oC3GT/EkMY3H3r/N7VZB5fs+Nub2mmsFp1rS/3L0SZwTlqiangFnBnKHOqlAD0BKmBtXZ1Tp0Db+jKzLQrvT6RrFayptUy1X17w87Ws6TUy3Qr5QH+Eo6LPyTefPDkn8EyIRkIQM9cIXGjuThNV7CdbbcrKxACrtuWwBBU1PrcUNK7cPtnYktZZVJzQsY1PBjDjzBmdsh2B/D/FLB7EFqnRkdl8pXQMZiP8uC81dj+QXOziSnwHo/QUe1H9XQYm9IzDHp2n5Q1hpYv/QUZP2OUkMaFq4uY5Iip2BPBbdERABFHF2jx2Zfn6n9XyLllafV+EG4ck2fiJOYnisP6iNg3axxSGQ8qFRDsiSIPGE0rMZChbyv7IuqtrMQT4macDMnZJSXWSUJpID3J4c5DvScVxbbsrv9vEzDIhgLDco2y5uWnoOM7+xYIGEMFWR7ehy9Mgyk/RicpyCHICpp7il4E1XNDFH3uOUfZXi3R9K86NQ0k+7phwyRAkeReodBXUd5yJac=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7161bcc-8bb8-4504-6369-08dd5cfe4921
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 22:28:57.4686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KM5YI2Zw+2j1RgpmSJJ/qV+7CgsBgycfw1qj542Vh0BaLMiaEdZ7TOoXf96sxnr9HG9jM0TZ7HH0MZkoN8iAm2JaFU+jj7MhIklEyPhds44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6445
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_08,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060173
X-Proofpoint-ORIG-GUID: OEOuz6dLbe2mpaK6BjptStpKqrPuRXwy
X-Proofpoint-GUID: OEOuz6dLbe2mpaK6BjptStpKqrPuRXwy

DQoNCj4gT24gTWFyIDUsIDIwMjUsIGF0IDY6MTLigK9QTSwgUGF1bCBNb29yZSA8cGF1bEBwYXVs
LW1vb3JlLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIE1hciA1LCAyMDI1IGF0IDQ6MzDigK9Q
TSBFcmljIFNub3diZXJnIDxlcmljLnNub3diZXJnQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4+IE9u
IE1hciA0LCAyMDI1LCBhdCA1OjIz4oCvUE0sIFBhdWwgTW9vcmUgPHBhdWxAcGF1bC1tb29yZS5j
b20+IHdyb3RlOg0KPj4+IE9uIFR1ZSwgTWFyIDQsIDIwMjUgYXQgOTo0N+KAr0FNIEVyaWMgU25v
d2JlcmcgPGVyaWMuc25vd2JlcmdAb3JhY2xlLmNvbT4gd3JvdGU6DQo+Pj4+PiBPbiBNYXIgMywg
MjAyNSwgYXQgMzo0MOKAr1BNLCBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9vcmUuY29tPiB3cm90
ZToNCj4+Pj4+IE9uIEZyaSwgRmViIDI4LCAyMDI1IGF0IDEyOjUy4oCvUE0gRXJpYyBTbm93YmVy
ZyA8ZXJpYy5zbm93YmVyZ0BvcmFjbGUuY29tPiB3cm90ZToNCj4+Pj4+Pj4gT24gRmViIDI4LCAy
MDI1LCBhdCA5OjE04oCvQU0sIFBhdWwgTW9vcmUgPHBhdWxAcGF1bC1tb29yZS5jb20+IHdyb3Rl
Og0KPj4+Pj4+PiBPbiBGcmksIEZlYiAyOCwgMjAyNSBhdCA5OjA54oCvQU0gTWltaSBab2hhciA8
em9oYXJAbGludXguaWJtLmNvbT4gd3JvdGU6DQo+Pj4+Pj4+PiBPbiBUaHUsIDIwMjUtMDItMjcg
YXQgMTc6MjIgLTA1MDAsIFBhdWwgTW9vcmUgd3JvdGU6DQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4g
SSdkIHN0aWxsIGFsc28gbGlrZSB0byBzZWUgc29tZSBkaXNjdXNzaW9uIGFib3V0IG1vdmluZyB0
b3dhcmRzIHRoZQ0KPj4+Pj4+Pj4+IGFkZGl0aW9uIG9mIGtleXJpbmdzIG9yaWVudGVkIHRvd2Fy
ZHMgdXNhZ2UgaW5zdGVhZCBvZiBsaW1pdGluZw0KPj4+Pj4+Pj4+IG91cnNlbHZlcyB0byBrZXly
aW5ncyB0aGF0IGFyZSBvcmllbnRlZCBvbiB0aGUgc291cmNlIG9mIHRoZSBrZXlzLg0KPj4+Pj4+
Pj4+IFBlcmhhcHMgSSdtIG1pc3Npbmcgc29tZSBpbXBvcnRhbnQgZGV0YWlsIHdoaWNoIG1ha2Vz
IHRoaXMNCj4+Pj4+Pj4+PiBpbXByYWN0aWNhbCwgYnV0IGl0IHNlZW1zIGxpa2UgYW4gb2J2aW91
cyBpbXByb3ZlbWVudCB0byBtZSBhbmQgd291bGQNCj4+Pj4+Pj4+PiBnbyBhIGxvbmcgd2F5IHRv
d2FyZHMgc29sdmluZyBzb21lIG9mIHRoZSBwcm9ibGVtcyB0aGF0IHdlIHR5cGljYWxseQ0KPj4+
Pj4+Pj4+IHNlZSB3aXRoIGtlcm5lbCBrZXlzLg0KPj4+Pj4+IA0KPj4+Pj4+IFRoZSBpbnRlbnQg
aXMgbm90IHRvIGxpbWl0IG91cnNlbHZlcyB0byB0aGUgc291cmNlIG9mIHRoZSBrZXkuICBUaGUg
bWFpbg0KPj4+Pj4+IHBvaW50IG9mIENsYXZpcyBpcyB0byBhbGxvdyB0aGUgZW5kLXVzZXIgdG8g
ZGV0ZXJtaW5lIHdoYXQga2VybmVsIGtleXMNCj4+Pj4+PiB0aGV5IHdhbnQgdG8gdHJ1c3QgYW5k
IGZvciB3aGF0IHB1cnBvc2UsIGlycmVzcGVjdGl2ZSBvZiB0aGUgb3JpZ2luYXRpbmcNCj4+Pj4+
PiBzb3VyY2UgKC5idWlsdGluX3RydXN0ZWQsIC5zZWNvbmRhcnksIC5tYWNoaW5lLCBvciAucGxh
dGZvcm0pLiBJZiB3ZSBjb3VsZA0KPj4+Pj4+IGdvIGJhY2sgaW4gdGltZSwgaW5kaXZpZHVhbCBr
ZXlyaW5ncyBjb3VsZCBiZSBjcmVhdGVkIHRoYXQgYXJlIG9yaWVudGVkDQo+Pj4+Pj4gdG93YXJk
IHVzYWdlLiAgIFRoZSBpZGVhIGZvciBpbnRyb2R1Y2luZyBDbGF2aXMgaXMgdG8gYnJpZGdlIHdo
YXQgd2UNCj4+Pj4+PiBoYXZlIHRvZGF5IHdpdGgga2VybmVsIGtleXMgYW5kIGFsbG93IHRoZW0g
dG8gYmUgdXNhZ2UgYmFzZWQuDQo+Pj4+PiANCj4+Pj4+IFdoaWxlIGl0IGlzIHVubGlrZWx5IHRo
YXQgdGhlIGN1cnJlbnQgd2VsbCBrbm93biBrZXlyaW5ncyBjb3VsZCBiZQ0KPj4+Pj4gcmVtb3Zl
ZCwgSSBzZWUgbm8gcmVhc29uIHdoeSBuZXcgdXNhZ2Ugb3JpZW50ZWQga2V5cmluZ3MgY291bGQg
bm90IGJlDQo+Pj4+PiBpbnRyb2R1Y2VkLiAgV2UndmUgc2VlbiBmYXIgbW9yZSBzaWduaWZpY2Fu
dCBzaGlmdHMgaW4gdGhlIGtlcm5lbCBvdmVyDQo+Pj4+PiB0aGUgeWVhcnMuDQo+Pj4+IA0KPj4+
PiBDb3VsZCB5b3UgZnVydGhlciBjbGFyaWZ5IGhvdyBhIHVzYWdlIG9yaWVudGVkIGtleXJpbmcg
d291bGQgd29yaz8gIEZvcg0KPj4+PiBleGFtcGxlLCBpZiBhIGtlcm5lbCBtb2R1bGUga2V5cmlu
ZyB3YXMgYWRkZWQsIGhvdyB3b3VsZCB0aGUgZW5kLXVzZXINCj4+Pj4gYWRkIGtleXMgdG8gaXQg
d2hpbGUgbWFpbnRhaW5pbmcgYSByb290IG9mIHRydXN0Pw0KPj4+IA0KPj4+IENvbnNpZGVyIGl0
IGFuIGV4ZXJjaXNlIGxlZnQgdG8gdGhlIHJlYWRlciA6KQ0KPj4+IA0KPj4+IEkgaW1hZ2luZSB0
aGVyZSBhcmUgZGlmZmVyZW50IHdheXMgb25lIGNvdWxkIGRvIHRoYXQsIGVpdGhlciB1c2luZw0K
Pj4+IHRyYWRpdGlvbmFsIHVzZXIvZ3JvdXAvY2FwYWJpbGl0eSBwZXJtaXNzaW9ucyBhbmQvb3Ig
TFNNIHBlcm1pc3Npb25zLA0KPj4+IGl0IHdvdWxkIGRlcGVuZCBvbiB0aGUgZW52aXJvbm1lbnQg
YW5kIHRoZSBzZWN1cml0eSBnb2FscyBvZiB0aGUNCj4+PiBvdmVyYWxsIHN5c3RlbS4NCj4+IA0K
Pj4gVGhlc2Uga2V5cyBhcmUgdXNlZCBieSB0aGUgTG9ja2Rvd24gTFNNIHRvIHByb3ZpZGUgc2ln
bmF0dXJlDQo+PiB2YWxpZGF0aW9uLg0KPj4gDQo+PiBJIHJlYWxpemUgdGhlIGNvbnRlbnRzIHRo
YXQgZm9sbG93IGluIHRoaXMgcGFyYWdyYXBoIGlzIG91dHNpZGUgdGhlDQo+PiBib3VuZGFyeSBv
ZiBtYWlubGluZSBrZXJuZWwgY29kZS4gIEV2ZXJ5IGRpc3RybyB0aGF0IHdhbnRzIHRoZWlyDQo+
PiBzaGltIHNpZ25lZCBtdXN0IGV4cGxhaW4gaG93IHRoZWlyIGtlcm5lbCBlbmZvcmNlcyBsb2Nr
ZG93bg0KPj4gbW9kZS4gIFRoZSBtaW5pbXVtIHJlcXVpcmVtZW50IGlzIGxvY2tkb3duIGluIGlu
dGVncml0eSBtb2RlLg0KPj4gQWxzbywgdGhlIGV4cGVjdGF0aW9uIGlzIGxvY2tkb3duIGVuZm9y
Y2VtZW50IGNvbnRpbnVlcyBvbg0KPj4gdGhyb3VnaCBhIGtleGVjLg0KPiANCj4gSSBwZXJzb25h
bGx5IGZpbmQgaXQgdmVyeSBhbXVzaW5nIHRoZSBVRUZJIFNlY3VyZSBCb290IHNoaW0gaXMgcmVs
aWFudA0KPiBvbiBhbiB1bm1haW50YWluZWQgYW5kIG9ubHkgbWFyZ2luYWxseSBzdXBwb3J0ZWQg
TFNNLCBMb2NrZG93bi4gIEhhcw0KPiBhbnlvbmUgcmVjZW50bHkgdmVyaWZpZWQgdGhhdCBMb2Nr
ZG93bidzIHByb3RlY3Rpb25zIGFyZSBzdGlsbCBpbnRhY3QNCj4gYW5kIGNvbXByZWhlbnNpdmUg
ZW5vdWdoIHRvIGJlIHdvcnRod2hpbGU/ICBTb3JyeSwgdGhpcyBpcyBhIGJpdCBvZiBhDQo+IGRp
Z3Jlc3Npb24sIGJ1dCBzaW5jZSB5b3Ugd2VyZSB0aGUgb25lIHRvIGJyaW5nIHVwIExvY2tkb3du
IEkgdGhvdWdodA0KPiBpdCB3b3VsZCBiZSBpbXBvcnRhbnQgdG8gbWVudGlvbiB0aGF0IEkgZG9u
J3QgaGF2ZSBtdWNoIGZhaXRoIHRoYXQgaXQNCj4gaXMgc3RpbGwgd29ya2luZyB0byB0aGUgc2Ft
ZSBsZXZlbCBhcyBpdCBvcmlnaW5hbGx5IHdhcyBpbnRlbmRlZC4gIEkNCj4gaGF2ZSBhIFRPRE8g
bGlzdCBpdGVtIHRvIGRyYWZ0IGEgcG9saWN5IGFyb3VuZCBkZXByZWNhdGluZw0KPiB1bm1haW50
YWluZWQgTFNNcyBhZnRlciBhbiBleHRlbmRlZCBwZXJpb2Qgb2YgdGltZSwgYW5kIG9uY2UgdGhh
dCBpcw0KPiBpbiBwbGFjZSBpZiB3ZSBkb24ndCBoYXZlIGEgcXVhbGlmaWVkIG1haW50YWluZXIg
Zm9yIExvY2tkb3duIGl0IHdpbGwNCj4gbGlrZWx5IGZhbGwgaW50byB0aGUgZGVwcmVjYXRpb24g
cHJvY2VzcyAod2hhdGV2ZXIgdGhhdCBtYXkgYmUpLg0KDQpEb2VzIHRoaXMgbWVhbiBNaWNyb3Nv
ZnQgd2lsbCBiZWdpbiBzaWduaW5nIHNoaW1zIGluIHRoZSBmdXR1cmUgd2l0aG91dCANCnRoZSBs
b2NrZG93biByZXF1aXJlbWVudD8NCg0K

