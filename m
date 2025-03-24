Return-Path: <linux-efi+bounces-3072-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 017CAA6E1C8
	for <lists+linux-efi@lfdr.de>; Mon, 24 Mar 2025 18:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2241896EC2
	for <lists+linux-efi@lfdr.de>; Mon, 24 Mar 2025 17:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEF3264F9E;
	Mon, 24 Mar 2025 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RGYM0idj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yl795Yx1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792602690FF;
	Mon, 24 Mar 2025 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838314; cv=fail; b=qqP4LqHkXMH+1rdWz+rgMN+g+nayK6uSU14oIGFuh0rYt0b/D4BZPaDr5/ecqL2hbG6mTAhnTFLhWRBa5Q1hui2/EtIhMyfZuluxkPjddTPmRvEarI2bDdaPMaHgS8U8R+P9E7QqlBgkVqC8UCvNnWoEQY9EPJI/CYT2NODD+qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838314; c=relaxed/simple;
	bh=yO62eYzoFZIzv4Cb3LEX3LZ0Pg3VBRsUv4Mx3kaYg88=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XbtrK31C4OQcLWUFSR8pnA+Z+ZG2BIzIdD/J/hqhZYWICzmq6Yi9a2jJ/WfMaQ/PPA4hN+3eSCiKYfvMeOYe2FfU7imx6L/NZh3NeWZz+NAOm5PajGkGWF/sN62Pp+I+GXbY7witoEkO4fhvwjQ8c2h9BOEgazz1Mm/XforozjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RGYM0idj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yl795Yx1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OGXx2E000456;
	Mon, 24 Mar 2025 17:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=yO62eYzoFZIzv4Cb3LEX3LZ0Pg3VBRsUv4Mx3kaYg88=; b=
	RGYM0idjdMwLlW6Z7RDFFSDhzd9tDjkVsbguK/Kh02KAXnAfkfrHCIQHebnPelEu
	G8RMoKIf95lv2ju6mUvqvwpSn/mFZlvrJUe5uHyMNJxno40WHN1Jbcpyj6TrycVP
	34Qgj9zeR2lKDb6knApGaqB3uxJrUKF3E4NGb/dgV8ljpdLa4YIOKbI5C55wVf9z
	TaN0Dm98kkgbNfIM4kxViVmTJ+abeYo7oxn0cEL1QKrgaQBNdORFCycSB46b3zfz
	KxnIlyn00SZ77aT8gDO1P9vr9DUdgpS6F8T12ylvAZtdIH8+WsXbLolWevgtr7RF
	cZCjDABB26EtFgMW5ITrHQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn9bvj21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 17:44:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52OGAigK015201;
	Mon, 24 Mar 2025 17:44:34 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jj90mxxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 17:44:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y29FZ6SJYaL5qy6uL7awF3ad9xwyUHwQv13CTSjf9ssw/50odMwNGL/ZmTDIcPVV6WYnLaij703BExbVNywsDmq4SPmfhSLBxfyERm5XJZREykmDByCwcOhtGZ1vRmChOZyPa6xpodaYPfXBTUvkyAU9wogCXr2oM4g/bKhCqO/K/20bhLkeFpCCczn+ILutSGBLVkZG1zuVZ0s6Z46n03nkUZv6JaUGzRdQZfKJWbtSMZScYPqRH8U96RqxyQMn+Q1wVQTyrViBMfRD7E64Yf95XqEo6XtGMIh4ZPfk2ghmDBNQvuNk3aesZ0XyrDi3RrbX9Ycrfmdr9r5/dizIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yO62eYzoFZIzv4Cb3LEX3LZ0Pg3VBRsUv4Mx3kaYg88=;
 b=CvKr/G/0j/w15DKNta4acm6mjHky9Oi1zNHAAfvv0C68H4AGK6+Iku6xwLsqDfPOxGjpJMBJJKVFW+gPJPSJTEUqSAfZMILWta/7JULBUnMGF/anzE+x0olApvM0BfdW47f368woKisSIcm8pJWO0RA/TlCQaMsIY+aPMV9bPT9gv74gVIjVz1PS1o9p0ybLyDHrksCvhRwFjjd5kiR9PDZYckzQx1zCeXP8TRc2gr8nYtbMhJLhWq1rf3i+4Gzf916m3uW2HscfEyo95xAc5RQ756pwVA6wU9vbrZs2/3jP4T+IEZDhzGcOQ/g3ZwlpRWwtM3Z6HAZAQgFDGO8J4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yO62eYzoFZIzv4Cb3LEX3LZ0Pg3VBRsUv4Mx3kaYg88=;
 b=yl795Yx1lechYlPG2lRL19YK3ABYprF9i3guEXTGRfWhoWlHUBwXudVLwH+la8jimX43B8l3XN2nTgL48XRpqvqdaOeiJEdA+jxQXEM9GrsEYgAeWCrgAXh/1W9thfIv1Dxp6CN5/3ankkU4B4rU9GG1qzDw4Tc/3p5Zg3fv5ko=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by BLAPR10MB4929.namprd10.prod.outlook.com (2603:10b6:208:324::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 17:44:27 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 17:44:27 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
CC: Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>,
        David
 Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "open
 list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        David
 Woodhouse <dwmw2@infradead.org>,
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
 AQHbIK0E/vdc4Eou30K4SgPRfeDFerL0Jc4AgBIDLwCAAF1+gIADEbkAgADjnYCAUfK8AIAAHD0AgAEIXICAACNLAIAAGwsAgAUHzgCAAQ2/gIAAoSGAgAFh24CAAD5VgIABZIsAgABIHQCAFVKsgIAAaUCAgAEtnICAAAQwgIAAN/mAgAAKpACABIIIAA==
Date: Mon, 24 Mar 2025 17:44:27 +0000
Message-ID: <A8EE4069-D797-4792-BD82-D7F34BCD885F@oracle.com>
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
 <EB757F96-E152-4EAB-B3F7-75C1DBE3A03B@oracle.com>
 <1956e7f9d60.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <A3A29FB9-E015-4C87-B5F0-190A4C779CB3@oracle.com>
 <95e7a43a2dd675615a146c56a10abf6921f955f9.camel@HansenPartnership.com>
 <172F304A-B719-4FBB-8FF5-23B6961A2DCE@oracle.com>
 <3e400185af56a899a9d93e792ea314292fb2adb9.camel@HansenPartnership.com>
 <15462D72-FED1-4B71-8F16-715CA282D37D@oracle.com>
 <6de0d2978abd641ac1e5ddaaf88d1c25ba612a85.camel@HansenPartnership.com>
In-Reply-To:
 <6de0d2978abd641ac1e5ddaaf88d1c25ba612a85.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|BLAPR10MB4929:EE_
x-ms-office365-filtering-correlation-id: 9b031044-ee87-4d8f-8733-08dd6afb863d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TmJzSi92VnhURVRlOWxMNi9Ka20rdnFpcUhUVVlYU3JyN2hWbDdPNVN1Zytp?=
 =?utf-8?B?NWdVbjFVV29KeEZWL0lIbXoxT0FSMURYRWcxZUEzeFJzeFExQVhqWkQwZXdC?=
 =?utf-8?B?V2dOeG5tQ1F0c1JpanFmTE5ydHRGK1JNSXlmZkptdzVVSStJZ0JIR3p4ZmZy?=
 =?utf-8?B?Z0dOSWNzY2JsY0x1eUhCTjlaZFErMDhSWnhvck5zbnFwT1N6SERFVnBZTWpY?=
 =?utf-8?B?OFFoY2FjTG53a1pyMTNqWUp5VzFvVlc4VHNjK0Q0eXRzNkl3ZUkxaWVsNzZT?=
 =?utf-8?B?ZVFRQ3FyUkp1ZmpOK2hLVElVZ05rSDh3bGl0RjB3dm5sT0pSWlJrenlFanBX?=
 =?utf-8?B?cGs0RWxESGdGUVJsM2NoK3h1QzQ0SkExTkp5OEU4VDJNQURBazM0b2FCWmJq?=
 =?utf-8?B?K3RRMTYrRmtUSXFzY2k5N3hKS0h0eFdia1Y1cWdSbC9JSWllQUhrbFpOTXNs?=
 =?utf-8?B?YkFHTyt1cjNGUit2TUh4RU1HVC9oSHc1czA5OVZNMlNZc1hQTThEUmQ4d3Zv?=
 =?utf-8?B?MXE3S2x0NkRzNFNEN2Fzc010a3RWMWQ1d2tSME5ha3g5KzVYdkxPeHZkUnhi?=
 =?utf-8?B?bmk4VHplQ3VqUVZqMklIbytaVmZQeWZmUkNDZE5qNHdzc3l4ZUswSW1jdzl5?=
 =?utf-8?B?bzVaNmZwY0RGMnpQT1pYa0JUL2Q3VFRtRnNFYlJUa0hQNytQaW9HcERqZ3p4?=
 =?utf-8?B?SFhxQ3FXZW53bEFwLzl4bHpNSTNYT2NkeFVqdUh2VkhZcm8vcHhtZlZsMVFG?=
 =?utf-8?B?WHpQSTBFS253VUNGdjc3WnBNbWxPREhMTEhZbEZ0TWhOQUV2OXE1T3UwYTlY?=
 =?utf-8?B?QkVCU3pmYXJFNEtpL2ZYR1E1TUc3RDNIVmRtcEJDV0dMQ0ROWG5raEZKb211?=
 =?utf-8?B?QUdoSWVpdVNqWFhlY3NHZ3FpblJhWGhJa0pwZktoK3JIY0U4SUtGM0FleTBX?=
 =?utf-8?B?QkVIRll3SmYrNjR0MlNXNHBld3AvalpwRjhZZmkwNExsOVBta2F2MHdHMkhO?=
 =?utf-8?B?RlBoVlA3NG5MRXh3M0VHd2d1THVmcklGaWc5dmNWYXUrWFZkYVR2Y3dDbVpT?=
 =?utf-8?B?dGovY1dneTdFdUVCZDN2ZkhybWMzY0wvWE5sVGdNd29lUC94b0FubENwQlpa?=
 =?utf-8?B?TVYxYktISmVQY3kyTUtxNzRLOGM5dmE0YTZQN1l5Q1ltYVlGOGFZdURaMmtG?=
 =?utf-8?B?MkU3WmZKazUra3ErdEkxUVhKUVcvWWZhZitHR2JoOTZldVlUcEI4eWcrYjhW?=
 =?utf-8?B?R25KbE44eXNrYWJRWksxNHA4OWwya3ZoZm1oSkF4TVFKSWxxaU1nb2FOSlpK?=
 =?utf-8?B?ZlozaWxSSjBwTWdwcjFBdm5HU2tTNm5ncTkzc3lCTkFRdWJUQi9UUkhJOW52?=
 =?utf-8?B?bm1tb0xjVVlWUWhDUElKQlc3TlVuUjJsTFhkdDVKNHRhSHVxRTNTd0Y3M2tp?=
 =?utf-8?B?S0NGTWxYcmVBQmFrYndGOFRGb2pGdkF6MmVQN3IwbmlrL2hlTVZ3YnBxOS84?=
 =?utf-8?B?cmdQK0RDNWkxNkp0MThGOWh2UmZaZGNOWWMwOGNBOERIWW0vRE8ra3hpOHVH?=
 =?utf-8?B?dVFkcDFpS3FsRmpUQSs2R280U0k0TW9HeDJmZmZwL200bFZvL09mbmRlOU5N?=
 =?utf-8?B?eXI1MTV5d0xtU1pTRXRTNjl2SGhiYlllLzcrVVdlR1Z2Z1ZOcll3MlVUM29x?=
 =?utf-8?B?aVdSMGpuQnQrWkFBRGZzMWhMRHBrU09vYlZPYkFIZyttNEVyUElPTFZNcW9s?=
 =?utf-8?B?Z0ljWmZxWTNEbzRsQ2JCcnc3TUpKeXFXeWsyR0NoREtoZlZab2tCaHpmRzNX?=
 =?utf-8?B?S2E3TllmRXEzU3JNem1TMHk1Z3RkUEo3NW9vTklLSW00K0N0dzFqQ1p1bExp?=
 =?utf-8?B?eGtJMXViTENLbUl6Ty84Y3VvSWN2akJQR0RFZ1cyNytGb1p5Y0NxM1VuckhM?=
 =?utf-8?Q?C9Sbz+qi8X4tXTt4hyAKC/yiyRbAC5jY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2U0SGpubDFXb0xhQjN4NkNyRGw4aDBkY2tsTmZYMTgzK2NnK2dGNVE1b2pa?=
 =?utf-8?B?Zmozc3JqYUNaRDd6RjlBQWlXQ3ZyZFVmblcrendOT1Y4NWxTaU9Ba1Jjdjcx?=
 =?utf-8?B?K0sya2lnOUlwL0JJR2xUcWZyaWlLd3VVWi9qcG1WSjIxZ213aGRuVFFncnYw?=
 =?utf-8?B?a2llNHFxWS9YNkxGUXd4dVZnSWowb3Q0bUN3S2VlZ3o1d0F2Vmd5K0QwWmhy?=
 =?utf-8?B?L0xKUHZnUEs0NzV4c25jNTluSFFjaGRtTjhiS3M1QS9HY284c0FDMXcvWmhk?=
 =?utf-8?B?U280KzRya3JVTHAxUlNHekV6WlZwZ3NueVROWUVsL0tLbnl4cHVOZit3TTZm?=
 =?utf-8?B?VHIwNGxwUFBGanNUZldCTXBxcGFDKzFKNWlLN0svRXJsL2dmOXlvTkF5bkNY?=
 =?utf-8?B?V1R4eGt0VG9rSzNxZnJFd0pUaHg1MjlRcEhrem1Dc0NpRm1wYUxXOGd1aUh1?=
 =?utf-8?B?RzNOMGtrdExMM01PU053Q052ZmZsQ3NQeDJZVjV5R1NVSnZtK3BHZXcyNWk2?=
 =?utf-8?B?SGQyL1F4eTlpQjZxaWIza1RFR1licmg4bnZUVDErZmVkZlk2Rno3dk9GcE9i?=
 =?utf-8?B?a3ZQMTdaTW85N2dPSEppeko0Nkc0U01YSzIvN1ZPTlloVkVKVlRwdUdBdXJW?=
 =?utf-8?B?WGhvaEdrRzArWFo3Ynhmc2pkSkYxM2kxUU14NkM0VDZqc09MREwveWU4NG9X?=
 =?utf-8?B?aDFBSnlHMDcxUWFYeTRZWXRTM0JCWlF2dEw1Z1B3bGVXRWxRZkNjOTdoOExh?=
 =?utf-8?B?WGc5bkRyVzEzNmViWkdvZG1wUHlvWVJRRzB1U1JxWG52VFQ4OXZ6VXdkeVVY?=
 =?utf-8?B?QWlMOFhVelM0dlN5cW44SlFwMFhtcTBnU1BhVS82c2JYaWxqT0dENi80djIv?=
 =?utf-8?B?ako5ZVNNUlR4S05pUGlqdDZkcmlWVWtBUnVoS0tRS0tpVkt4VTNNZEcrT0Nl?=
 =?utf-8?B?WDVyejFHTTcyZVRyL3o4NUxOeHd6MDk4N3Z5alB5bitsbk5lSW0xWElReE9k?=
 =?utf-8?B?NHVOWlFORHNoVHh5SWtIUVVsR3VFcHJGMVpRb01nYk5jZU9mb3c3OHVnRmhD?=
 =?utf-8?B?Mkw5U2M3dzl2VGhsYXZoZjMxWDVxUkRES2lEZVI5RG9VdDBqem13TGczblhk?=
 =?utf-8?B?TXVuKzZTbVdMb2Z6cUpTMERGT2JGM2VPVzZzRmxrMytOOXo1ckhzNm5LZnh0?=
 =?utf-8?B?eWhNRlU1bVJyS05KL0VKY1dZY1ByVGttcDZPbEtFN2lnSVdhK2RvclNzc2xD?=
 =?utf-8?B?ZGFPZFVFMUZ4S0xtdXNUZGVuUU5lZHgveWxleTVlUUYrZ0hHdkdEZDMzejlT?=
 =?utf-8?B?ZXNYUVZDWXZBY1ZhWjNlTWRsbWYwQXRWTnozUGdEMXBlTEFYTWt2b3lrOWJR?=
 =?utf-8?B?d1llOXFsZW9aeUZtZkRKdFZHVVdrVEdoNmZWaTVzWXNvNHc4L1BEaEhhM2FB?=
 =?utf-8?B?elJKbU9PdmtWWlRoNDNzc2FVRzY4UXVacVRTZ1phRG12TFZ6eHBVTVNxMU8v?=
 =?utf-8?B?azB3d3VMS1dGOHRpSU1oK09hNlZEeEIzalAzL3NMUnl3MG43UTNGZUdYOHRu?=
 =?utf-8?B?dkR2NHMyUzZibUxyenFlRWVaSVBmZWV6c3JLKy9sMi92bVlsd0RZSElVSTZ6?=
 =?utf-8?B?NENWNlA2QXVWSSt3ZDZ6WGhVckQyOFhVN2VZSUlBM2swMVozRVFDVTBuZzFt?=
 =?utf-8?B?RE05RFBhUnZlTjgzeG9qSGVUUjZHLzgwaUQxcTluRHZ2MUFDb0p3ejlCU0RR?=
 =?utf-8?B?YkRCRGM1cUVKbnZWS09mcElURDN3bHF4UFhaQU1PV012ZXhiWmp0VmFVekVV?=
 =?utf-8?B?d0pWemFRZERrMXpGSDRnRmJ2UjJPdU5BcEx6eVBTWGZiSDBBZ09uOTJJN0N1?=
 =?utf-8?B?YWNrZzVVc3JXU0toSHpRY1AxT3lNc0R2QitWblZkUEhRWGsySGE0UENKSDJr?=
 =?utf-8?B?UnBnc3Ixamd1Uk1uNERMOUdnWUhXUUNDTlpEMHJVVnhFUzc5V2VLMTJ6VVhU?=
 =?utf-8?B?Qks2RGxYR2lxc0pzUGpQaE4za3VDOHpZdjFoYnJyQTlxSytQdlJlUmZYWVEr?=
 =?utf-8?B?eWxic1F3NkdnUFRwZmk0TTdKSzlGamVualM4MjRVb0lkVEc5OWwrVGxJZzB4?=
 =?utf-8?B?bFZ6Z2RqeVRJaGtvNm5hbmdiK0JuaHV5TTQ1OUNwbndqOTE3VEtEK3NKcUhL?=
 =?utf-8?B?QUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A356CDB273C9148B24C49B497CF091D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c5alHmqcJDZZzCEE8RjOEeH+PLfqLvtYzCAwQRcKmy/WIFliFOFPII7sEQ4FN1mSRVoDoaqd5EQ3Gv0QrnTSp7hKvd+NqKYno2aLTmfAZj1G5xqji9uC7ENkOrbFE2ywi8cO+zfk+qgBdi2SUWr8DC5J3MPcWIQnskkTxv+iifD1pseX4nRYnUYcvgD0AoctJk0K8pl6R8PpWoYPBTSipW6NhEQEBSxckFnnVmDkKioOpmiVIK++h6AKB8z3usfPmD1jqHBH3t2T8GAPFyhfDUPI1xjDrDdWcKFQxEsb8lVpFAnxl8nEpKQ14sTElRNy31AlnvmJEF6whx168vUlfDmqllznXwypTmqQcvxzqp21agfJbKQCAmP+elD1nsrRMRtQ7WhJC+YSMW2Sg+Qa9ivjy1NnfTUnTlGXHCcBqdIcncGPrEc7rnCPiAGiEXlbHYE8/vvgsD32j5iwDZKwMisL+/aSU3azxktpwRYwIA2ua6K+QLZPOC3PlusJkOX4DuHSrjrdXWUXub2H0v8L1tnnxWPkNlQwtUP3R2UF22Kqb3hTulaRAbOq5YszIfVzPAl3/2jFjLmg4kAG1wMDeOAMeuiLZELL+h25VNXSR4k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b031044-ee87-4d8f-8733-08dd6afb863d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 17:44:27.7907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IsylLKCwX7dMrjoaATmTeLoQ8gczpuHQxsYLOAe5pzxUUTZzfytshJK9YidKwQqwoBEf6L2LVY+7+WYLnZExEvNgMGrDBwl7O+JFjL9offw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4929
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_06,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503240127
X-Proofpoint-GUID: 7ge8ong6zc9xLEkWbF-vxvJxrErQy1KA
X-Proofpoint-ORIG-GUID: 7ge8ong6zc9xLEkWbF-vxvJxrErQy1KA

DQoNCj4gT24gTWFyIDIxLCAyMDI1LCBhdCAyOjUz4oCvUE0sIEphbWVzIEJvdHRvbWxleSA8SmFt
ZXMuQm90dG9tbGV5QEhhbnNlblBhcnRuZXJzaGlwLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBGcmks
IDIwMjUtMDMtMjEgYXQgMjA6MTUgKzAwMDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+Pj4gT24g
TWFyIDIxLCAyMDI1LCBhdCAxMDo1NeKAr0FNLCBKYW1lcyBCb3R0b21sZXkNCj4+PiA8SmFtZXMu
Qm90dG9tbGV5QEhhbnNlblBhcnRuZXJzaGlwLmNvbT4gd3JvdGU6DQo+IFsuLi5dDQo+Pj4+ICAg
SG9wZWZ1bGx5IHRoYXQgaXMgbm90IHRoZSBjYXNlLCBzaW5jZSB0aGUgcHVibGljICBrZXkgc2hp
cHMgb24NCj4+Pj4ganVzdCBhYm91dCBldmVyeSBzaW5nbGUgUEMgYnVpbHQuDQo+Pj4gDQo+Pj4g
SSBkb24ndCB1bmRlcnN0YW5kIHdoeSBNaWNyb3NvZnQgbm8tbG9uZ2VyIG93bmluZyB0aGUgcHJp
dmF0ZSBrZXkNCj4+PiBpcyBhIHByb2JsZW0/ICBPbmx5IHRoZSBwdWJsaWMga2V5IHNoaXBzIG9u
IFBDcyBhbmQgdGhhdCBoYXNuJ3QNCj4+PiBjaGFuZ2VkIChhdCBsZWFzdCBub3QgeWV0LCBpdCBt
aWdodCBoYXZlIHRvIGZvciBOSVNUIHJlcXVpcmVtZW50cw0KPj4+IHNpbmNlIFJTQTIwNDggaXMg
YmVpbmcgZGVwcmVjYXRlZCkuDQo+PiANCj4+IEEgY291cGxlIGNvbmNlcm5zIGNvbWUgdG8gbWlu
ZC4gIEZpcnN0LCB0aGUgdmV0dGluZyBwcm9jZXNzIGJlaW5nDQo+PiBkb25lIGZvciBpbmRpdmlk
dWFscyB0aGF0IGhhdmUgc2lnbmluZyBhdXRob3JpdHkgd2l0aCB0aGUgSFNNIG91dHNpZGUNCj4+
IG9mIE1pY3Jvc29mdC4NCj4gDQo+IEknbSBub3QgYXdhcmUgVUVGSSBoYXMgcHVibGlzaGVkIGFu
eSBpbmZvcm1hdGlvbiBvbiB0aGlzLiAgSSB0aGluayB0aGUNCj4gc2hpbS1yZXZpZXcgcmVwbyBw
cmVkYXRlcyBVRUZJIG93bmVyc2hpcCwgYnV0IEknbSBzdXJlIHRoZSBtYWludGFpbmVycw0KPiBv
ZiB0aGUgcmVwb3NpdG9yeSBjYW4gYW5zd2VyIGhvdyB0aGV5IGNhbWUgdG8gYmUgdHJ1c3RlZCAu
Li4NCg0KVGhhbmtzIGZvciBjbGFyaWZ5aW5nLCBJIGRpZG7igJl0IHJlYWxpemUgdGhlcmUgd2Vy
ZSBjb3BpZXMgb2YgdGhlIHByaXZhdGUga2V5IA0Kb3V0c2lkZSBvZiBNaWNyb3NvZnQuDQoNCj4+
IEFub3RoZXIgd291bGQgYmUgYWNjZXNzIGNvbnRyb2wgb2YgdGhlIEhTTS4gIEVzcGVjaWFsbHkg
aWYgaXQgaXMgbm90DQo+PiB3aXRoaW4gTWljcm9zb2Z0J3MgcG9zc2Vzc2lvbi4NCj4gDQo+IC4u
LiBhbmQgaG93IHRoZXkgaGFuZGxlIHRoZSBIU00uDQo+IA0KPiBIb3dldmVyLCBpZiB5b3UncmUg
d29ycmllZCBhYm91dCByaXNrcyB0byB0aGUgaW50ZWdyaXR5IG9mIHNlY3VyZSBib290LA0KPiBJ
J2QgYmUgbXVjaCBtb3JlIGNvbmNlcm5lZCBhYm91dCB0aGUgbnVtYmVyIG9mIE9ETSBtb3RoZXJi
b2FyZA0KPiBtYW51ZmFjdHVyZXJzIHdobyBzZWVtIHRvIGhhdmUgbWFuYWdlZCB0byBsb3NlIHRo
ZWlyIFBLIHByaXZhdGUga2V5cywNCj4gb3Iga2V5cyB0aGV5IHBsYWNlZCBpbnRvIGRiLCBzb21l
aG93IC4uLg0KDQpUaGF04oCZcyBwcmVjaXNlbHkgdGhlIHByb3RlY3Rpb24gQ2xhdmlzIG9mZmVy
cy4gSXQgYmVnaW5zIGltbWVkaWF0ZWx5IGFmdGVyIA0KRXhpdEJvb3RTZXJ2aWNlcyBhbmQgY29u
dGludWVzIHRocm91Z2ggYWxsIGtleGVjcy4gT25jZSB0aGUga2VybmVsIHN0YXJ0cywgDQp0aGUg
ZW5kLXVzZXIgaXMgaW4gY29udHJvbCBvZiBhbGwgc3lzdGVtIGtlcm5lbCBrZXlzLiAgT2J2aW91
c2x5IHNvbWUgdHlwZSANCm9mIHByZWNhdXRpb24gbXVzdCBiZSB0YWtlbiB0byBnZXQgaW50byB0
aGUgZmlyc3Qga2VybmVsLiAgVGhlIENsYXZpcyBrZXkgDQpiZWxvbmdzIHRvIHRoZSBlbmQtdXNl
ciwgYW5kIHRoZXkgaGF2ZSB0aGUgZnJlZWRvbSB0byBkZXRlcm1pbmUgd2hpY2ggDQprZXJuZWwg
a2V5cyBwZXJmb3JtIHNwZWNpZmljIHRhc2tzIHdpdGhpbiB0aGUgc3lzdGVtLiBUaGlzIGxldmVs
IG9mIHByb3RlY3Rpb24gDQp3b3VsZG7igJl0IGJlIGZlYXNpYmxlIHdpdGggdGhlIHByb3Bvc2Vk
IG5hbWVkIGtlcm5lbCBrZXlyaW5nIGFwcHJvYWNoLiAgDQpXaXRoIHRoZSBuYW1lZCBrZXJuZWwg
a2V5cmluZyBhcHByb2FjaCwgaXQgY291bGQgYmUgZGVmZWF0ZWQgd2l0aCBrZXhlYy4NCldoZW4g
eW91IGhhdmUgaGFyZHdhcmUgdmVuZG9ycyBzaGlwcGluZyBzeXN0ZW1zIGluIHRoZSBwYXN0IHdp
dGggdGVzdC9kZW1vIA0KREIvS0VLL1BLIGtleXMsIG9yIG90aGVyIGNvbXBhbmllcyB0aGF0IGFs
bG93IHRoZWlyIHNpZ25pbmcga2V5IHRvIGJlIHVzZWQgDQpieSBvdGhlcnMsIHRoaXMgbGV2ZWwg
b2YgcHJvdGVjdGlvbiBpcyBzb3VnaHQgYWZ0ZXIgYnkgc29tZSB1c2Vycy4gIA0KDQo=

