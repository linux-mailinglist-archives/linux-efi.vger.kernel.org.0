Return-Path: <linux-efi+bounces-2770-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6D7A2D14B
	for <lists+linux-efi@lfdr.de>; Sat,  8 Feb 2025 00:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D154E169A57
	for <lists+linux-efi@lfdr.de>; Fri,  7 Feb 2025 23:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3E01D07BA;
	Fri,  7 Feb 2025 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WZsm939q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BetFPk2A"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1CC1A5BA6;
	Fri,  7 Feb 2025 23:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738969811; cv=fail; b=GtIGN59Pt/Bk3i0TisM5WywexoMWRRx4Aar4fIpjrHtC57OLAl25tAn/g5LpCpxooMAspLK94OM5nsAWLINAH75z946N1gJmf7ndVrtiKXl8HB9i36W7CX/U6Gl/NDT7Qbro+RBTya0qPWVl1znjXgbBoe//e4wBT/9WAo8w14E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738969811; c=relaxed/simple;
	bh=UMw0d8OHFmOQndOzb89rB11YbScLlumv/P8uPVUXdyI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=no99F6XpjwzwmZxzYld0g81okYoYo/NWHwTxd/AVM1Kz3abHm0p8tT3AXmh9fwYaxH2O4EuM81NMrUa/Kxbob/KsR9X7aNViieIJAE1zlLZco8LwtDn798VUeFFY9teVvVxw2nDDFF1MoGB2aAPKHpprI65ad3/IhT7T3Lg58nA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WZsm939q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BetFPk2A; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517LfoDf008481;
	Fri, 7 Feb 2025 23:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=UMw0d8OHFmOQndOzb89rB11YbScLlumv/P8uPVUXdyI=; b=
	WZsm939qjGEUN03D8ZMkWkTw3ecxFyQ3pQTbyCWe+FGwC4PcL3/1pumdh0JUwwEk
	oCo5vDD9VHd1ERBiL7B1vjlTCDMdtLykjVjWPPXFH4Y5V5MVCQD6j+2u3H+v9WDV
	HvK6BRMZwWzbEOWbB81ADNG6ig8+Vh9lFASBqPb6Hf7F6bJPl9mIaMuVo+mhNwL3
	2jxEmcBl7+GfjsrI2V7WFum44AZREC59bZ35eGqpdABdojJwbFpBtH7Y9AEbrmxl
	c0pIf4XRXJdpAeJ0qDD2QZMiXNDcvrZZ8ZhEw0LimtrR+fwmKxHnXTs8rajTV61J
	SkYlgqff/x4mRExtXo4SPg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44mqk8brqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 23:09:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 517KngS8023573;
	Fri, 7 Feb 2025 23:09:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8gnqg0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 23:09:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5y4buPRHSMG19CEWIPMPhIfC5Kh8PSuyQ3OLH9OktpvjU4BXL633C4PEFj0+UO27I7uNmZx3gTifXiGK6vCMjuUbfAhv9e6zx8vqAlTcnVFmFo/sKK+jiZzJy15+qRqa6p+I9LD6EftEmpK8Zj3JTxU0qX2Vk+2Xlpctbh9KvYFP6DuEQA1t5GQFFfn62C6SZubSxozOpDIF7C/uDdJsqnP1KN1R0AMEKKCYV/X2fT8RyIJlgW3vnY9Rilh+PF1is5RKfwQDsjri2W/KmetleKjEX8qEYDhXJrD5GZMIx/3YgJVPTc9XVci7s6voOLcYTsulnEdWG+AzeSTyQu8Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMw0d8OHFmOQndOzb89rB11YbScLlumv/P8uPVUXdyI=;
 b=M3FPX4tQJVTWtUOKxwV96NWLIiIJFa77+HCubKWKUDMuRXp77eIdtuWebMjmchCqmb0WkCDGCpQsxedsa+zGTN6SwoAFPNq6FJgxV2WJW6d6fbbUl13puqYV1Bo5Ao0DU74Ejbh1tuy5FRC/iYqnk2F5S9s6kz51f7l0Lt5qJBkmaLesKVhHF0oDk7jHIeLY1SEJaXTrzq9sxDnyoo+JRqw0CuJWN1aghma7wdgCnvEUNw++a7ja5pwBSYUUhoY4yO7kgorVsK8CrELGuKBz5P8QM3prJ/VP9rV6U3oZv2Bj8Q/Ebo+RVbtEjBVt/xNy+2BvrIy12UFanTzyt3VkNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMw0d8OHFmOQndOzb89rB11YbScLlumv/P8uPVUXdyI=;
 b=BetFPk2AnmGwiLIRqMMOxbh+9bQeYlVfYaKok/UvQU9dcNVxIYLXOKg2Nii/rhJaG/5qq6N8nx7QeX8m+uVWt2Wrs8zBzUwdQ4UvhgZfqkWCBzohfFZwR6vlElblAIUrt4QRk50eRWERctNOwXdoJWpNXXJwJXGagsC5T8li2yk=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by SJ0PR10MB4493.namprd10.prod.outlook.com (2603:10b6:a03:2dd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 23:09:30 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%6]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 23:09:30 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: Jarkko Sakkinen <jarkko.sakkinen@kernel.org>
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
Subject: Re: [RFC PATCH v3 07/13] keys: Add ability to track intended usage of
 the public key
Thread-Topic: [RFC PATCH v3 07/13] keys: Add ability to track intended usage
 of the public key
Thread-Index: AQHbIK0PwY7/7xucfkuU/kLmv/GwMLM7ZcGAgAHDhoA=
Date: Fri, 7 Feb 2025 23:09:30 +0000
Message-ID: <C32A61D2-4C87-482E-B7CE-37C5C5780D89@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <20241017155516.2582369-8-eric.snowberg@oracle.com>
 <Z6UU7anXtW43AhNR@kernel.org>
In-Reply-To: <Z6UU7anXtW43AhNR@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|SJ0PR10MB4493:EE_
x-ms-office365-filtering-correlation-id: 964d721f-77c2-48ef-a358-08dd47cc79ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eE9nMGdibEo0SmlvejR5VUJKT0s2SlVDeCs2d1A0eVk4bGkwV2xLM2txb2s3?=
 =?utf-8?B?Y1lLendrTDhweEdvd1pNWTZtdWRCekNHNmZ3MlNBWkZPd1dOdytpTi9EL3Rn?=
 =?utf-8?B?OG0wOHdXNjNLVkMwaFVRRWxtTnVIZ2NWNGFIN0NqTXVibFdwdXZUangyaytN?=
 =?utf-8?B?ckZJY0E1bFVSSC8zSUZadjJlMFhmL0ZHUHg4aUtsczFibkFZVXAyL2F5dm1O?=
 =?utf-8?B?SWIwemJNb2VXcnd1K0dUcGlCbFZIRzVaWjd1Z1UwV0dCdEpqZGo1N0t6bVJX?=
 =?utf-8?B?aUdXY05uUHF2RzErMWxWcnFZR3ZwUkxRcmQ5SGJKZGRxUXluWUxoc3QvWEdj?=
 =?utf-8?B?V2hVT2NQemRIdXNBOHpqVFN6bTE4UGpZQlpxNEtTdlhPSjB3bUVaY3VFanlu?=
 =?utf-8?B?K3ZGTHFNSHdaYTdQT1JHbjBGdWxsNkJtSVRyNjVZSm10Uis0TWVlVVY3cExz?=
 =?utf-8?B?cDVaRGdBdlRPYlkyT0t6KzYxK1R0U0tPNkwzQ0hON3V5bmo3dlhiMVhpeGk2?=
 =?utf-8?B?cjBmWEpGR3pXK3U4UEdqc2Y4eUF5bFVHSnh5YUxJQ1BTdUJWdC9oZUFyVEwr?=
 =?utf-8?B?RFhEUkZFZGlTVnMrNm52UVJpU05PTE1LOGROM3B2bllrZTF0RjREcVU0SGVo?=
 =?utf-8?B?OFhDSzdpR1VuYjZZaCtHTmNveUZUN0dNVnlNRkpMcDRXb0VYK0ZCc2w2emZ1?=
 =?utf-8?B?OURmOHg2OEZNVUdpMUZyZmgwV1k3WWxUMGJhSTFqN21RL1pmS21VVHJ2bkoy?=
 =?utf-8?B?MEZwQ0taUTROeWRDOVlKUUlkV0VTa2pWK3VnVmtYTjZMUjBqZnBJS3RaYU8x?=
 =?utf-8?B?UDJSSExsODBzUVgwSFdkNUpTMU4yQ2R1eGdWSWZoKzBtcWhqOEpnczFnSXls?=
 =?utf-8?B?c3Z5K1lZZUVKdHlLSy9aT09wTVZYZnVCUDRLaU0vbi9vaFpNM1h1djlldUtY?=
 =?utf-8?B?RG9NbExOSFRmZi9obXNhUk85d0p1R05iMFg1WWc4RjlGMXVqVnd3UVcrMlJp?=
 =?utf-8?B?cHRHUVZMWm5QZ1U5YU4vUkFEVlE4RlN5TGJxbTRjSWdUY0pvUDh6TUMzMlI3?=
 =?utf-8?B?MDE2YUl4VytrY2xjc0d1Skw5ZFpRaXNmU3JhZlRjSjEzd0gyVkYyWkUzZWlV?=
 =?utf-8?B?M3pHNVhEVU1FS3U0ZWROOWtIMTgxNVRsZjcwQkc4d2R6VVZHWHNVdFFqVktD?=
 =?utf-8?B?TUlOTjhwdW5sK1F2L2lUelI4V1RBei9UbUE5SXN0ZW9TcWEwdUFJYUQwQlU5?=
 =?utf-8?B?YXY1eVg3Slo1bHhvN2xjem1CVXQvQjZGVURjS1pjZVJ1emt4UmhzVGNyc084?=
 =?utf-8?B?aEU0UzhLU0tnTm43YWxjd3RMZlByY0NjKzdoMHlqVXZ1aUt2T1ljRDIzc0tZ?=
 =?utf-8?B?TGRmT3FDOGU5bzZpb2hpcy9pYzBuVG9zZTdYYzVsUzJzWlZZbDV5MlJpRElJ?=
 =?utf-8?B?R1kwbSsxbTVCbVRsUTV3aEl5YmNJOWdvOGhVZVJUamw4a0JTNFZORDU2UTNG?=
 =?utf-8?B?WE1pRWVZUTZtQm91aE5nOUFyRmorM3Rxb1ZZY2hBdDJPRG92YkJzUkV5NlRT?=
 =?utf-8?B?VTVVVEN4bTNRdzY2ZytXOGlGcEhhZGk2eUFWYlNFUXB2OUs5cUZ0U1RSQW1y?=
 =?utf-8?B?SkUxc2x4YWV3bTF3cDVGRFBudlltWFllNGpiMlp6SHhiYU51TGNpSFdoMmdw?=
 =?utf-8?B?TlJSdGN0RzZLdlRQbG5rT1N2djJZNVliMkd2MjRBM3RoeDVITTd3Y0psMFNa?=
 =?utf-8?B?ZHhMall0VkdjWnVCSk9zMk5WN3hxRFBiL045VEtZRVl1QnJsTVRaMjRhQmhE?=
 =?utf-8?B?ekVZNFdaSzZxSTI2VDY4UUh4VytrUUI4WStpMzM2My9abzdocFpha2U5YjFV?=
 =?utf-8?B?eThYWDNLelIycG1EalBaZ0FUak9WQlk0ZGlSeStWcjhVZ3UvT1JUSGNaUjVM?=
 =?utf-8?Q?Hidmxmt0s2fEMCEoYa1XMBuys362aep9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHVCbHQwV2RnK3Q0NDlNMXplRjFDS0FJb2pDVWN2QWZBa1hxZzEvb05OR1lY?=
 =?utf-8?B?eW1nUXEyamhCWXpWekNOTVM0MnRLTFZyci9SQ0RYU3ZkeFJiYTMwemlpemRF?=
 =?utf-8?B?cDhrOWVod3I1R2FVa2wzMHhEdEJoWTJKSFBQcW90RFVZcXJPMEVRQ2IxUTVJ?=
 =?utf-8?B?cGd6bFFjVXpxWlptVEdjM1kwUmg4bW9VbFVrT1JNRW9XZmhaWG9mSW9wd0t1?=
 =?utf-8?B?akM4MC9pVE5SMm1CbHM0cnFWV2lieml5QWVTNlJtWENzaEUwWmxuaWx1SDRP?=
 =?utf-8?B?NzB3b0p1amk5ZlR6dVpBd3ZWNWRJS3dITUFjUWh0WTBvaEIxRWxKZXVTUHJ1?=
 =?utf-8?B?bWNhWkFjcERpSC9iYWdXSlZZVFA5c2loU2pVNUVWeE9pdDFOb2h5ekIwcHcw?=
 =?utf-8?B?OXR2OXJuUk5tZ1pFL0ZhOWkranlYcVhMZUxjUmZIRlVvOUhyaUo4bTRWbE9k?=
 =?utf-8?B?a1BpWjA5UkhzbEFQbGdZNDUxemNXdVExbWtKQlBXdi9uQzgyemF6RXdQQ0dm?=
 =?utf-8?B?V1RFeCtPSE5mU0YzZHcwakNPRnE0eXJTT3J1ZndKRWRZejRsTm8rU1lhTHNT?=
 =?utf-8?B?QVNlYmlrL3pKR2VPK0ZCYXorQklCZXhRV0Uyd3FhdFNkNXU4NTVWaUlXWkVk?=
 =?utf-8?B?WGx1NSsrcGpGK1NqNkFia0kwQmRSV1pxeXJoeWNWVkJnQVgwNVZQbVZSTk9M?=
 =?utf-8?B?SzFqOG95QTFtaFRXeXgxaURrcEtEc3F3TXNQZWk4aUEzdndsVThZWGwzTjha?=
 =?utf-8?B?emxUTzJCQVVNZ2Z5b2pvampYMVpyVXduL2l6N2JaajJ0Mm8vSEgyNDl1RnJZ?=
 =?utf-8?B?L2R1U0FLcUI0OVpIYm9mSWFrbXdLWDlhVHBOb010VWNFRm5rajhuR1N5TkJK?=
 =?utf-8?B?SHNKeFZvKzdxaVVvTUJJNkRBRDZMcTR1ZGk1NFFudVUrbytKNmpRWENMcXdJ?=
 =?utf-8?B?bjZUQjN4c20rYVNzY3IwYWh3Vld1Sm42emRSQThzNXl2WktmRzlMaWY5eDN6?=
 =?utf-8?B?cTJYVXdRUmhkNmpGNzVIcVVkUnc1WTJZeTNsQUp6L1BTQ1puaTdSbi9xQmpD?=
 =?utf-8?B?MnZsQWo5UmlkS1pja01XbWlyWkdVeTRTTVJjcW9QSDgyNHJLOTliVmpQTVMy?=
 =?utf-8?B?eFgvNkN6cXNGU0NacWcycGMxN1dGZHdyMHRzZmdWdmxidG01U2M2TmF1NWov?=
 =?utf-8?B?bDhwRWFGcUdzcVdJdlkvTkFyM0t1SUlNYmVROW1CSGpPejM3MkpQckRteG9B?=
 =?utf-8?B?YjJQZ0hoOEhkVEpoR0JUcmZZSDZham9oYUhCdzFiQW9BNk5STWhSbDYxS25v?=
 =?utf-8?B?N0hCWWJPVkxLcWlVZzJmVlZsd21ocHNMdjFtcGZBYUMwWkt3dFU1RlJhNEd4?=
 =?utf-8?B?RDVpSVNiZHJ1aGJiUktaaXh6ZmNyRkQ3YXRWNHpGanQrMGtSdFIzbnBhQks4?=
 =?utf-8?B?NVpnUGl2dnhBOVJZd1FldU1hWGxaUjBwN0J5cXc3MFN1NWlnWHh1YStkb0VH?=
 =?utf-8?B?Z2dFTmNoVWpSZzk5Wkg0UkwxVlhrb0pyczJNblJDOU9OdHJlVlBaR0xhYmFF?=
 =?utf-8?B?ZVFXZEs2RDBlcjBLejQ2Z3oyaExQYzB5RGg5Z3lXc3F2bnNnYjhjOTRyekh0?=
 =?utf-8?B?RmkwTGF5L1FWa3IzTUJ5alhXYW5MUzc4cFdpNDluOWVFcjhNL1dnLzc3dTh6?=
 =?utf-8?B?UGw0NUhMcVNJQ3c3bWpTL0Nob2oydXVoZktIM0NHQVBGTlhkMlpDVVYrcmRx?=
 =?utf-8?B?aUlwZjRQMVdJbmtpWE8wUDU5bXJUUnIvWXgzZC9ieGJBRGlROFhyR0dWYzl3?=
 =?utf-8?B?QUV6R1UyRTdVY0cySU1QeGJqYm9JOWlHUmltMDZUUTV4VFBnQkwxWTcxRDBI?=
 =?utf-8?B?dEhDQlBRSjBVWDI5WjRqVGhvYUVqdjJFdE00amhuV1JEV0FrYVhlalJIVzVa?=
 =?utf-8?B?ZkhnZ08wUXZGUER1Zm5uN1JoM3U0V2tQZWM2OC9PeTI0ZUM2KzdSY212Q2pp?=
 =?utf-8?B?Tzc2bkFGVWxCQUgrd2wvL2JuTUZ4dklPa3NNT3l3aWhCa3FlbkZJZkZVd2dE?=
 =?utf-8?B?elFVWXpERGs3RE1tbmRwdDE2NEk1VGtQTFZOYWZ6a3hISktGMmtQZnFxVE9N?=
 =?utf-8?B?K044a056aWNoRmFzejg0Vm9TdVhKZmR0anRKd09NOU5xdS9URU51N0pvWUE2?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0525586201FAF147915BF460C7561056@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zcPDCfYkCBvpY4xC32Ncfa/ltATLm3EzVXQd5kBogIheFixquJsnSv9kSDaG5OxeMh8r27ToTvwABZLrS+HZnPi8jL3pyR7O4t1tYwie+GiK+2VXX5rg9qojns6nD2mC4hkbWziobo9s+mhjn3IzchaSuRvCryaumz6LhJgKaLx2uZEmJBr8pFuvjvXz+xCW7MZbIUaHRVVL7VoMjcdjSrH4klwTCqCGNP+K5hQaA5WIe+dq5bSqubow3LdZUxq5gtbDjojLHRqzptNA/iROeA/lyvdCZ3EnXrAhxmxbp6WiO55Ukxjqw8ghcZbR+jg3WVMQz+u4japwXvgxzVcCnuiHSFwaEQiclOTb1eGjg4ugIvhdWT7TU9IClMVs95n/sfxlMr3hq1RhZuu5BMs7liporzEQDAV5e3T4Kz1WQ3aNcU4EX0fOrAh8LxIdlbdAhcrD/HyuqBTiXik7uuhuYgDt56TkdnrAgj35zy1lmaRWs224cypv4hWJ7yDvByYVT4kBTJmryZfo5x4w1cgSFBtRCJbiBWPvCLbSyl+ihheDNbEsKUC1H8wRgdyPSd589ufOVqQUL5pnHHJsG7/WoxSKx+jS3hroTwnWYsIYkoA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964d721f-77c2-48ef-a358-08dd47cc79ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 23:09:30.0534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cOkYs9GORwRiCXfuCwHH6k9iwQl4CiuZX6GHap7q0ltVe3zzh/xigFo0p7CmKSKzIa3ttH19ftaDjWoSC3LeJHNwCJSt1Z8QFVu5D3x/S18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4493
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_11,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502070175
X-Proofpoint-GUID: Jpz9o3CWZ-a5Pq0ydafirM-2vu4zYivz
X-Proofpoint-ORIG-GUID: Jpz9o3CWZ-a5Pq0ydafirM-2vu4zYivz

DQoNCj4gT24gRmViIDYsIDIwMjUsIGF0IDE6MTPigK9QTSwgSmFya2tvIFNha2tpbmVuIDxqYXJr
a28uc2Fra2luZW5Aa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIE9jdCAxNywgMjAy
NCBhdCAwOTo1NToxMEFNIC0wNjAwLCBFcmljIFNub3diZXJnIHdyb3RlOg0KPj4gQWRkIHR3byBu
ZXcgZmllbGRzIGluIHB1YmxpY19rZXlfc2lnbmF0dXJlIHRvIHRyYWNrIHRoZSBpbnRlbmRlZCB1
c2FnZSBvZg0KPj4gdGhlIHNpZ25hdHVyZS4gIEFsc28gYWRkIGEgZmxhZyBmb3IgdGhlIHJldm9j
YXRpb24gcGFzcy4gIER1cmluZyBzaWduYXR1cmUNCj4+IHZhbGlkYXRpb24sIHR3byB2ZXJpZmlj
YXRpb25zIGNhbiB0YWtlIHBsYWNlIGZvciB0aGUgc2FtZSBzaWduYXR1cmUuICBPbmUNCj4+IHRv
IHNlZSBpZiBpdCB2ZXJpZmllcyBhZ2FpbnN0IHNvbWV0aGluZyBvbiB0aGUgLmJsYWNrbGlzdCBr
ZXlyaW5nIGFuZA0KPj4gdGhlIG90aGVyIHRvIHNlZSBpZiBpdCB2ZXJpZmllcyBhZ2FpbnN0IHRo
ZSBzdXBwbGllZCBrZXlyaW5nLiBUaGUgZmxhZw0KPj4gaXMgdXNlZCB0byBkZXRlcm1pbmUgd2hp
Y2ggc3RhZ2UgdGhlIHZlcmlmaWNhdGlvbiBpcyBpbi4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTog
RXJpYyBTbm93YmVyZyA8ZXJpYy5zbm93YmVyZ0BvcmFjbGUuY29tPg0KPiANCj4gTWltaSwgd2Fz
IHRoaXMgdGhlIHBhdGNoIHNldCB5b3UgYXNrZWQgdG8gbG9vayBhdCB3aGlsZSBhZ28/PC9vZmZ0
b3BpYz4NCj4gDQo+IFRoaXMgcGF0Y2ggYWRkcyBQS1NfUkVWT0NBVElPTl9QQVNTIGFuZCBSRVZP
Q0FUSU9OX1NFVC4gSXQgd291bGQgYmUNCj4gbmljZSB0byBwdXQgaW4gc2ltcGxlIHRlcm1zIGhv
dyB0aGV5IGFyZSB1c2VkIGluIGRvd24gdG8gZWFydCB0ZXJtcy4NCg0KT2ssIEknbGwgYWRkIG1v
cmUgZGV0YWlscyBleHBsYWluaW5nIHRoZW0gYmV0dGVyIGluIHRoZSBuZXh0IHJvdW5kLg0KDQo+
PiAtLS0NCj4+IGNlcnRzL2JsYWNrbGlzdC5jICAgICAgICAgICAgICAgICAgICAgfCAgMyArKysN
Cj4+IGNyeXB0by9hc3ltbWV0cmljX2tleXMvcGtjczdfdHJ1c3QuYyAgfCAyMCArKysrKysrKysr
KysrKysrKysrKw0KPj4gY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy9wa2NzN192ZXJpZnkuYyB8ICA0
ICsrKysNCj4+IGluY2x1ZGUvY3J5cHRvL3BrY3M3LmggICAgICAgICAgICAgICAgfCAgMyArKysN
Cj4+IGluY2x1ZGUvY3J5cHRvL3B1YmxpY19rZXkuaCAgICAgICAgICAgfCAgNCArKysrDQo+PiA1
IGZpbGVzIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKykNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2Nl
cnRzL2JsYWNrbGlzdC5jIGIvY2VydHMvYmxhY2tsaXN0LmMNCj4+IGluZGV4IDY3NWRkN2E4ZjA3
YS4uZGQzNGU1NmE2MzYyIDEwMDY0NA0KPj4gLS0tIGEvY2VydHMvYmxhY2tsaXN0LmMNCj4+ICsr
KyBiL2NlcnRzL2JsYWNrbGlzdC5jDQo+PiBAQCAtMTcsNiArMTcsNyBAQA0KPj4gI2luY2x1ZGUg
PGxpbnV4L3VpZGdpZC5oPg0KPj4gI2luY2x1ZGUgPGtleXMvYXN5bW1ldHJpYy10eXBlLmg+DQo+
PiAjaW5jbHVkZSA8a2V5cy9zeXN0ZW1fa2V5cmluZy5oPg0KPj4gKyNpbmNsdWRlIDxjcnlwdG8v
cHVibGljX2tleS5oPg0KPj4gI2luY2x1ZGUgImJsYWNrbGlzdC5oIg0KPj4gDQo+PiAvKg0KPj4g
QEAgLTI4OSw3ICsyOTAsOSBAQCBpbnQgaXNfa2V5X29uX3Jldm9jYXRpb25fbGlzdChzdHJ1Y3Qg
cGtjczdfbWVzc2FnZSAqcGtjczcpDQo+PiB7DQo+PiBpbnQgcmV0Ow0KPj4gDQo+PiArIHBrY3M3
X3NldF91c2FnZV9mbGFnKHBrY3M3LCBQS1NfUkVWT0NBVElPTl9QQVNTKTsNCj4+IHJldCA9IHBr
Y3M3X3ZhbGlkYXRlX3RydXN0KHBrY3M3LCBibGFja2xpc3Rfa2V5cmluZyk7DQo+PiArIHBrY3M3
X2NsZWFyX3VzYWdlX2ZsYWcocGtjczcsIFBLU19SRVZPQ0FUSU9OX1BBU1MpOw0KPj4gDQo+PiBp
ZiAocmV0ID09IDApDQo+PiByZXR1cm4gLUVLRVlSRUpFQ1RFRDsNCj4+IGRpZmYgLS1naXQgYS9j
cnlwdG8vYXN5bW1ldHJpY19rZXlzL3BrY3M3X3RydXN0LmMgYi9jcnlwdG8vYXN5bW1ldHJpY19r
ZXlzL3BrY3M3X3RydXN0LmMNCj4+IGluZGV4IDlhODdjMzRlZDE3My4uNjRkNzBlYjY4ODY0IDEw
MDY0NA0KPj4gLS0tIGEvY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy9wa2NzN190cnVzdC5jDQo+PiAr
KysgYi9jcnlwdG8vYXN5bW1ldHJpY19rZXlzL3BrY3M3X3RydXN0LmMNCj4+IEBAIC0xMzEsNiAr
MTMxLDI2IEBAIHN0YXRpYyBpbnQgcGtjczdfdmFsaWRhdGVfdHJ1c3Rfb25lKHN0cnVjdCBwa2Nz
N19tZXNzYWdlICpwa2NzNywNCj4+IHJldHVybiAwOw0KPj4gfQ0KPj4gDQo+PiArdm9pZCBwa2Nz
N19jbGVhcl91c2FnZV9mbGFnKHN0cnVjdCBwa2NzN19tZXNzYWdlICpwa2NzNywgdW5zaWduZWQg
bG9uZyB1c2FnZSkNCj4+ICt7DQo+PiArIHN0cnVjdCBwa2NzN19zaWduZWRfaW5mbyAqc2luZm87
DQo+PiArDQo+PiArIGZvciAoc2luZm8gPSBwa2NzNy0+c2lnbmVkX2luZm9zOyBzaW5mbzsgc2lu
Zm8gPSBzaW5mby0+bmV4dCkgew0KPj4gKyBpZiAoc2luZm8tPnNpZykNCj4+ICsgY2xlYXJfYml0
KHVzYWdlLCAmc2luZm8tPnNpZy0+dXNhZ2VfZmxhZ3MpOw0KPj4gKyB9DQo+PiArfQ0KPj4gKw0K
Pj4gK3ZvaWQgcGtjczdfc2V0X3VzYWdlX2ZsYWcoc3RydWN0IHBrY3M3X21lc3NhZ2UgKnBrY3M3
LCB1bnNpZ25lZCBsb25nIHVzYWdlKQ0KPj4gK3sNCj4+ICsgc3RydWN0IHBrY3M3X3NpZ25lZF9p
bmZvICpzaW5mbzsNCj4+ICsNCj4+ICsgZm9yIChzaW5mbyA9IHBrY3M3LT5zaWduZWRfaW5mb3M7
IHNpbmZvOyBzaW5mbyA9IHNpbmZvLT5uZXh0KSB7DQo+PiArIGlmIChzaW5mby0+c2lnKQ0KPj4g
KyBzZXRfYml0KHVzYWdlLCAmc2luZm8tPnNpZy0+dXNhZ2VfZmxhZ3MpOw0KPj4gKyB9DQo+PiAr
fQ0KPj4gKw0KPj4gLyoqDQo+PiAgKiBwa2NzN192YWxpZGF0ZV90cnVzdCAtIFZhbGlkYXRlIFBL
Q1MjNyB0cnVzdCBjaGFpbg0KPj4gICogQHBrY3M3OiBUaGUgUEtDUyM3IGNlcnRpZmljYXRlIHRv
IHZhbGlkYXRlDQo+PiBkaWZmIC0tZ2l0IGEvY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy9wa2NzN192
ZXJpZnkuYyBiL2NyeXB0by9hc3ltbWV0cmljX2tleXMvcGtjczdfdmVyaWZ5LmMNCj4+IGluZGV4
IDFkYzgwZTY4Y2U5Ni4uNDRiOGJkMGFkNGQ4IDEwMDY0NA0KPj4gLS0tIGEvY3J5cHRvL2FzeW1t
ZXRyaWNfa2V5cy9wa2NzN192ZXJpZnkuYw0KPj4gKysrIGIvY3J5cHRvL2FzeW1tZXRyaWNfa2V5
cy9wa2NzN192ZXJpZnkuYw0KPj4gQEAgLTQ1NSw2ICs0NTUsMTAgQEAgaW50IHBrY3M3X3Zlcmlm
eShzdHJ1Y3QgcGtjczdfbWVzc2FnZSAqcGtjczcsDQo+PiByZXR1cm4gcmV0Ow0KPj4gfQ0KPj4g
YWN0dWFsX3JldCA9IDA7DQo+PiArIGlmIChzaW5mby0+c2lnKSB7DQo+PiArIHNpbmZvLT5zaWct
PnVzYWdlID0gdXNhZ2U7DQo+PiArIHNldF9iaXQoUEtTX1VTQUdFX1NFVCwgJnNpbmZvLT5zaWct
PnVzYWdlX2ZsYWdzKTsNCj4+ICsgfQ0KPj4gfQ0KPj4gDQo+PiBrbGVhdmUoIiA9ICVkIiwgYWN0
dWFsX3JldCk7DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9jcnlwdG8vcGtjczcuaCBiL2luY2x1
ZGUvY3J5cHRvL3BrY3M3LmgNCj4+IGluZGV4IDM4ZWM3ZjVmOTA0MS4uNmMzYzkwNjFiMTE4IDEw
MDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9jcnlwdG8vcGtjczcuaA0KPj4gKysrIGIvaW5jbHVkZS9j
cnlwdG8vcGtjczcuaA0KPj4gQEAgLTMyLDYgKzMyLDkgQEAgZXh0ZXJuIGludCBwa2NzN19nZXRf
Y29udGVudF9kYXRhKGNvbnN0IHN0cnVjdCBwa2NzN19tZXNzYWdlICpwa2NzNywNCj4+IGV4dGVy
biBpbnQgcGtjczdfdmFsaWRhdGVfdHJ1c3Qoc3RydWN0IHBrY3M3X21lc3NhZ2UgKnBrY3M3LA0K
Pj4gc3RydWN0IGtleSAqdHJ1c3Rfa2V5cmluZyk7DQo+PiANCj4+ICtleHRlcm4gdm9pZCBwa2Nz
N19zZXRfdXNhZ2VfZmxhZyhzdHJ1Y3QgcGtjczdfbWVzc2FnZSAqcGtjczcsIHVuc2lnbmVkIGxv
bmcgdXNhZ2UpOw0KPj4gK2V4dGVybiB2b2lkIHBrY3M3X2NsZWFyX3VzYWdlX2ZsYWcoc3RydWN0
IHBrY3M3X21lc3NhZ2UgKnBrY3M3LCB1bnNpZ25lZCBsb25nIHVzYWdlKTsNCj4+ICsNCj4+IC8q
DQo+PiAgKiBwa2NzN192ZXJpZnkuYw0KPj4gICovDQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9j
cnlwdG8vcHVibGljX2tleS5oIGIvaW5jbHVkZS9jcnlwdG8vcHVibGljX2tleS5oDQo+PiBpbmRl
eCBiN2YzMDg5NzdjODQuLjM5NDAyMmI1ZDg1NiAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvY3J5
cHRvL3B1YmxpY19rZXkuaA0KPj4gKysrIGIvaW5jbHVkZS9jcnlwdG8vcHVibGljX2tleS5oDQo+
PiBAQCAtNDksNiArNDksMTAgQEAgc3RydWN0IHB1YmxpY19rZXlfc2lnbmF0dXJlIHsNCj4+IGNv
bnN0IGNoYXIgKnBrZXlfYWxnbzsNCj4+IGNvbnN0IGNoYXIgKmhhc2hfYWxnbzsNCj4+IGNvbnN0
IGNoYXIgKmVuY29kaW5nOw0KPj4gKyB1MzIgdXNhZ2U7IC8qIEludGVuZGVkIHVzYWdlICovDQo+
IA0KPiBJJ2Qgd291bGQgbm90IHNpemUgZW5jb2RlIHRoaXMgYnV0IGluc3RlYWQgdXNlICJ1bnNp
Z25lZCBpbnQiLg0KDQpJJ2xsIGNoYW5nZSB0aGF0DQoNCj4gDQo+PiArIHVuc2lnbmVkIGxvbmcg
dXNhZ2VfZmxhZ3M7DQo+IA0KPiBJdCB3b3VsZCBiZSBsZXNzIGNvbnZvbHV0aW5nIGlmIHRoaXMg
d2FzIGp1c3QgImZsYWdzIi4gTm93IHRoaXMgbGVhdmVzDQo+IHRvIHdvbmRlciB3aGF0IGl0IGlz
IGVuY29kZWQgZm9yLiBFLmcuIGZvciBpb2N0bCBBUEkgb25lIGRvZWVzIGl0IGZvcg0KPiB0aGUg
QVBJIHRvIGJlIHNpemUgYWdub3N0aWMgYmV0d2VlbiAzMi82NC1iaXQga2VybmVscy4NCg0KYW5k
IGNoYW5nZSB1c2FnZV9mbGFncyB0byBqdXN0ICJmbGFncyINCg0KPiANCj4+ICsjZGVmaW5lIFBL
U19VU0FHRV9TRVQgMA0KPj4gKyNkZWZpbmUgUEtTX1JFVk9DQVRJT05fUEFTUyAxDQo+PiB9Ow0K
PiANCj4gSSdkIGFkZCB0aGVzZSBiZWZvcmUgdGhlIHN0cnVjdCBhbmQ6DQo+IA0KPiAvKiAuLi4g
Ki8NCj4gI2RlZmluZSBQS1NfVVNBR0VfU0VUIDANCj4gDQo+IC8qIC4uLiAqLw0KPiAjZGVmaW5l
IFBLU19SRVZPQ0FUSU9OX1BBU1MgMQ0KDQpJIHdhcyBmb2xsb3dpbmcgdGhlIHNhbWUgcGF0dGVy
biBkb25lIGVsc2V3aGVyZSBpbiB0aGUgY3J5cHRvIGNvZGUsIA0KYnV0IEkgY2FuIG1vdmUgdGhl
bSBiZWZvcmUgdGhlIHN0cnVjdHVyZS4NCg0KPj4gDQo+PiBleHRlcm4gdm9pZCBwdWJsaWNfa2V5
X3NpZ25hdHVyZV9mcmVlKHN0cnVjdCBwdWJsaWNfa2V5X3NpZ25hdHVyZSAqc2lnKTsNCj4+IC0t
IA0KPj4gMi40NS4wDQo+PiANCj4gDQo+IEJSLCBKYXJra28NCg0KVGhhbmtzIGZvciB5b3VyIHJl
dmlldy4NCg0KDQo=

