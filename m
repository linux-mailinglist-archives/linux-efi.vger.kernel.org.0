Return-Path: <linux-efi+bounces-3048-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B15A6AB09
	for <lists+linux-efi@lfdr.de>; Thu, 20 Mar 2025 17:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A51F189205E
	for <lists+linux-efi@lfdr.de>; Thu, 20 Mar 2025 16:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208402147ED;
	Thu, 20 Mar 2025 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ds+M8q9y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H0EJH2nS"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D7F111AD;
	Thu, 20 Mar 2025 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488197; cv=fail; b=C5RNskM9vPoiqo/zfQTbfKqFXsS/4zrqsPgk/jucyn2HSWOwH0x//+15Ys3dEADDzhxc89T6FRwVQdE97n83cC4A/uqyF1nETjTeYnZoOFrrz/+1KSGZ9JbNd80EmXSKZG3yNXdi9s8imB3MqqW+190ErKWtRqiYxixyUxcwxc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488197; c=relaxed/simple;
	bh=HkEbAZCA7kMA3uDibfgaaYU1qWIafj9lS8y+mSw6Pz4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JIUW3HYjr1CA0dZZOUffxKqWfgBwSTlSTGjnFG8k+H3gZk2klWC6Mf7kLfE0IA/BPLPwMHdLcenAU9fGrUFxqTIBxt76uDuqPgUv8xrz24zlK5tcx2X+Bj3Q6+Z3eQdXg0zdDAnOvxoZ1UPQ0PGhfsLtVaLhfxxPzvux740CUIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ds+M8q9y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H0EJH2nS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KGMqqU025727;
	Thu, 20 Mar 2025 16:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HkEbAZCA7kMA3uDibfgaaYU1qWIafj9lS8y+mSw6Pz4=; b=
	ds+M8q9y9CCNPCpNj9KWjl7jy2RhBderIytXN2GclIel/iUw6E6mQj7UuIacIsnL
	WLsVTsVdwXQ9wusQe7z6Lr0qD1/jzRJsUEwpP5xjUjIObc96MZjfcAJ/fuB7DPX6
	GSj8mGRkJ5a0x73icqI7eKTwSfl/NEqvifKAfrrOvWREderctpggSdARd0G9bkJQ
	hsA+wQGn4TG5/rZtDe09UhI9qg+qxjpfKkFpV9APlkTYrQeln+eNMvsjMsWiwesk
	V7CcubaR5+osiYNbPFWtsJSmpyVgVCX2dCeVb9MFH+H4OLcoToveAqQe1lfXzosq
	KknJzrHdufo9kLU5xySBRA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1hg6pxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 16:24:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52KF2aNT024432;
	Thu, 20 Mar 2025 16:24:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxbmnn45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 16:24:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QeUhgSiwcfH9QfLwJuxk3fwGob7uz0myFleRp3XIPQ2mIVggw6Q0wblkkgc2DtSCe/JMrOPEkS4hA9r9ZQVUX4JV/lMJREHKSnLmu7cfOAG/yVUwZ4diLPDwxjbiI83CxI3sa5KediztKaZzmzPf7sWSFv2E8U+4u4RkS8BiY7UnBljNRZnj/1cCsDCMSZqoluuRTH/XJanV/BztZcFNwuys+9si9AcoyyiIwM/Hajt2tXTNbCOY0QL/pWmT9hN1N+oIpuOLfZIXWDIZpuq582SO3+olIQV7M4EETpxw1I/xPuBpYJEOdVEWrbQnVBkLO/C7a42FUoL7ijJM5L489Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkEbAZCA7kMA3uDibfgaaYU1qWIafj9lS8y+mSw6Pz4=;
 b=Vyiygz++mETVwmwLSoB1BWzQGzjF9ZjcxLNzoPrQRiQmhrtbZ5Qnr+BPZky0Eu2h6LW5n/1l52nfT1FQjS+VhIW3njJt3ooshIkNBnY8/R240wlcOXDnMYshH2pigbBuc1+FSbgHco4krNgkmCD+dSwyMQlhE96QJ/P3kzUyEt72omVK3DHE6O/ot2oYgDFIgPHo/Hk86MblxJ/uk76WEO+qHJKxEQ/C/MY5z+JLEUj4ry83FPhBmhkQZI7eqGV7M9UsIR/7iWRRjsTynguJ3Wan4/A68tmAwYKQE9HONrGOI48ZoboyjelmXcEA4dyFSIgsUbYpiMQCwduzooNh9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkEbAZCA7kMA3uDibfgaaYU1qWIafj9lS8y+mSw6Pz4=;
 b=H0EJH2nSpCCpjMYWvlRDC7Cu6AwbrM85ffC+XZvtJd/GCfy8++0L25HhOu6Q2rrkY3AfZqQl5YQ6+1KhEhbT7TvCDTgV2DbyADsv9dEUigEFjeXlQ8SevEsEhsqEM/UoRj9v/KnZ5f9sr40fBjOsjaknZ0y4fGY0n+FTBuJd7Jc=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by LV3PR10MB8106.namprd10.prod.outlook.com (2603:10b6:408:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 16:24:15 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 16:24:15 +0000
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
 AQHbIK0E/vdc4Eou30K4SgPRfeDFerL0Jc4AgBIDLwCAAF1+gIADEbkAgADjnYCAUfK8AIAAHD0AgAEIXICAACNLAIAAGwsAgAUHzgCAAQ2/gIAAoSGAgAFh24CAAD5VgIABZIsAgABIHQCAFVKsgA==
Date: Thu, 20 Mar 2025 16:24:15 +0000
Message-ID: <A3A29FB9-E015-4C87-B5F0-190A4C779CB3@oracle.com>
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
In-Reply-To:
 <1956e7f9d60.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|LV3PR10MB8106:EE_
x-ms-office365-filtering-correlation-id: fe289f53-0bdb-45d1-f968-08dd67cba82a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWdkQTlmblJXWGw3MGR6WEFwVWZyZUdxVDdodkNrL2xnNGZhR3E4QkJheTNj?=
 =?utf-8?B?U1EvWmh6dzlIQlRQUnJyMnE2MHA3RjI4eE5ZY1BUZVlPVlpIWWdxZ3A0VFdM?=
 =?utf-8?B?Z29vL09pdmFkNnkvak1UNkFEQTl5dHMvMmluZWRsSDZFQW5GVzJ2ZnBvck5r?=
 =?utf-8?B?TkZGOGJtMEozZlVDWmdoV0c1cnNOYnBBdnZkc013RmFkVWROZDByK1RIMWU3?=
 =?utf-8?B?TTBJOGdJWGZFckxzaVRUb0lZNXlqSElERjJ1K0piMHJtV2xsb1RVSTdFaG1p?=
 =?utf-8?B?aytQVnVEa09iNVpFdXpvMC9TcjA2R1FmeFU0L3ZKVXAyRC82WU11Y1NDZ0xV?=
 =?utf-8?B?NHA1MWdlamE2d2tyQkE5Z0t4b0hVaFVXWVdSR09WUmI4WW5zdkRhT29TbmNX?=
 =?utf-8?B?UFFoRW0vRnhOUXVtRHQralF4MFpLbFE0Ym9rNkdSOXhSNHoxczRXczBlc0o0?=
 =?utf-8?B?V0Y3ZGl6REtjZUZ0Sng0YVlzV21LMHJzdUZnVm1OUEpCbjNlOCt2ajJRMkN6?=
 =?utf-8?B?QitUNk80ZWtja0xmTnVwMGYwRkhjNnh5c3d1Q0pJTDdva2c1THZ6SEF4Zldn?=
 =?utf-8?B?c0FWeTkwSWUvMks0bmpYa0kzeHA5RWJRY2dsMkFvSTlibXRiQU5ORmllT3Rm?=
 =?utf-8?B?aVRlSlUvWlpkN1orZ2dwK01sZHZteGd5d0RxcmtjUmtIckVqeFJ0SjVNSVJn?=
 =?utf-8?B?S1BLMm5yU203NXVQTGFqTnA0eTd0cENyU2kwcnlRNE1UcTdUdVl6K21JY1U5?=
 =?utf-8?B?c1IxSVM0NG9JUnY1K21TVUsrZjJPNVJHbUg1V1BDT0ZLSDRrRTdqTE0zTEV3?=
 =?utf-8?B?SnVwdm9vZmRmQ3I0dnVVV2RMaHYzVmx6OThyd2l4SjZIYnhxSmoxYVNaNmls?=
 =?utf-8?B?T2pyc1BVVVNGNjBoRzZ6VFNTcXkvZ0UvMDRBRE1aNG1YeVFYZFVHU1NSVVUz?=
 =?utf-8?B?c2RqU1pFbnl5bWZVS20vbk9NbFE3SkxXTGpkQW1vQUVPNzlmdjlpb3ErN05F?=
 =?utf-8?B?bXlnTnU2VUR6S0UzK2d5YksyellVUEFMVytlajMvK050QTNRZWhIRnViR2w2?=
 =?utf-8?B?OURKcVVQUTNPdXdpcEMybEFzcFZXY05DU0NkWDRqN2VFVVRYMGRKNEc1M3d0?=
 =?utf-8?B?cVdOcytQaTlZdmY2VkI1TnZVaEE4dkJjWUx2MTdIT1orWGNFKy9QR1JjWU9Z?=
 =?utf-8?B?OTBMaWIvS1IrY0Zwck1nT1ZrQlZJdU5CQVNYTHh5Y0ZMNmpQSEdJaTRTYzVq?=
 =?utf-8?B?dkZmek5qc0J3NWJLdXlOY1FWRzZ4MUFKOWQ4QVU2WHZ1MEdxVDk4bm9NVjNn?=
 =?utf-8?B?bG5hOXl0Vlltd25NTGtRaVg5VDZFbU5oRCs4ZkVPeFBYUWJ4Zk0xaDVuanJM?=
 =?utf-8?B?TUxRZkpBV3hLQmg2UXpTSXptNkJEaXlQZWIwQktTUnNMUzJoaDhwUHZ6K2lE?=
 =?utf-8?B?NDhocmwzQXVSZlN0QTI3VzdnUTJBVzYvWWZ4b2phMy80V0JvQVAwTmhBSGpx?=
 =?utf-8?B?dGRMeVdJVFJnY1pLdW5wbU1PSzc0K2JkU3R2K3dRNHNLTjErN0VTeU5hSE8z?=
 =?utf-8?B?NG9zN05JVlVkalZBWHIvTitoRGxubGphRDJOWVFIdWJpdzh2M1NwcVQ3K3ZJ?=
 =?utf-8?B?RXJFd3Y2ZkRsb3EyM0tFVHVONEhFcmRsZHY0aTBYeUZ6OCtpRm42S2VhcHdZ?=
 =?utf-8?B?ME1sMFNxVEhPUnpLcG5MS1ZrbzJXcnpzRURGZ2VkcFZ1V3VMYkhrcFFteDlr?=
 =?utf-8?B?b2dncUwwSnBFS0g5ekFFSWtMc1hGdTdqMlFwOU0rZ2krcGhYYUgxTStPU2dN?=
 =?utf-8?B?Zm1WY1pDM1hONFFxSEIwUG9oR0ZBWDVuSzNndnRzY0djQTd3b0NXWGwrajJI?=
 =?utf-8?B?MzV1SlZ0YkRadzBiS0hjWHpzWHEwYTMvU2Zjam1FVVExS3cyZGpQa1duSDVH?=
 =?utf-8?Q?w1vSxFAwmn4rFo4lUcCyU736mB/cc9eS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZlNDaUpvUE1rWlJmcTJyL3lmbWk4N3RoclFTeHJaWG5JS1NVN0RnRUVkbjNj?=
 =?utf-8?B?d0JwK3V4WFoyUFNxQkN2SFZsdDM4WWhtbmNOTGdYeVpic05tYUt5MUErZStG?=
 =?utf-8?B?UnRzeHV4MzVZUFVwZUZ3ZUUrY2tERjMvN0NnaVlOUnR2SzRZYVFCOTlSSnZw?=
 =?utf-8?B?cUJnaEs4bEdTcFhaY0hVUXJDaVZ5anN6V2VsVDVIbkFaRy92cnJ0WEphdEht?=
 =?utf-8?B?dllLNFJ0T3VheVliNnNrNXNDUEhRUXllRFJKYUI0UFpKcytXSDN1c1I0Q3hy?=
 =?utf-8?B?N05jUHpSZjk4cW9TVGdsQWRDemU3b0x3K3lkTEI0RGlWUTVNR3pRdGxlSVFz?=
 =?utf-8?B?OTJmZkNQdzNkR1U2NTJnN0JTVVZSTGFZOE1lR2RRYjZON0tzWUUxaEM3WDA2?=
 =?utf-8?B?ekExVTBsNVZsVEw5V0FUUVRQakpyaXVRczRscE9Hck8yZUhSdStsY0s4b0tS?=
 =?utf-8?B?YlFGa1MrZ3pMU21XcWpLaXhnMENIeis3Y3RONVV2ckNpVDh1TVU0VGpCZUxJ?=
 =?utf-8?B?SzRkekFqanVldTJad1FMNHNXU1YyOThWNThJUjA0MFMrTzZpMmRuN21QSmZ3?=
 =?utf-8?B?aDJkdGdicXNkaXh6cDJLVlA1a2VOWGVnOWd0dzg4UVI4SzBvNUFOQnY0NzNM?=
 =?utf-8?B?NVBiV2ZkZkdoSk5WMVJBS2JFNWJ5ayttNDQ0eFo0TWorRVdHLzZWMGd5UW5U?=
 =?utf-8?B?NFV6ZGVjNjNONUw1Z1pKL3dKT2YwVHJBa1JNckF4VE0vWmNoRmtvOEVRQnVm?=
 =?utf-8?B?K1pWbE5uNVVmVWpwVlY3MWo3anRpeU5sZDU1V0FqNC9CRFZqMkI1d0dKaCtz?=
 =?utf-8?B?M2l2QmZQcFdzNHBNNVV1OHRKbkc1WFVDY2xuUDNXQ2NTKzN1bGh5TjRnb0dE?=
 =?utf-8?B?R1phdm5hN0xsOGpxVFZvK3N0RGVFcWdwRmJBR1ZWVTdIczkwZkZyajV5dnMr?=
 =?utf-8?B?c1h1aC9NR0xPZDByZ0ttWVczSjFQdnFEelRXWFd3R200SHNTMmVPeUNoSFRW?=
 =?utf-8?B?M1l3N0tUVUY1Qi9xc3RZZ1hUdjZGdE4xYW9td3pNZ3k0aVZudnJkSlcvMGhI?=
 =?utf-8?B?WW53UVl2OHZqUEtsd24xdHJtYURyUno5WkRpM2hnNVlwanV6Qi9lbkFtdVlJ?=
 =?utf-8?B?NXdiblR3UjRMZFA3WGNkYzZ5UFFPWmJxdVBCTUNhTUgzcWEyb0dudE9HNG45?=
 =?utf-8?B?R1JRTlFJV2EzMW9BSDRGS3lwMEtVT2N5dUs3NU1vQnhzYnhRNlY0c1pRSUFK?=
 =?utf-8?B?bGFXSGphNzV4bnNnb0gxNElReDdXN2FoaXRIcmJSTDBsWFUvOHV5UkpRcU1v?=
 =?utf-8?B?bnFidmhrS1luL2lzZVM3VGlmbmlHUHFqY2d1S1ZGQ2xFY1g0bGFOd1dpNmtx?=
 =?utf-8?B?bGUrN3VwZUlnSXRtNVpBZ01teklDYTNvbjkweXYxN3FBOUZuNmVMcVlycU45?=
 =?utf-8?B?QzZ3a241blRuTHlSZmxaNFJMbUhSN2dYVjZ3dXNpamp0K0ZYdldnME9NcytW?=
 =?utf-8?B?SHJDOHVmOCtRemE1NlhFM3h3S3RuLzdFcFJxRnhGY1dZaXZseFh1V3lRVmFn?=
 =?utf-8?B?RFN3bkpvQndJWWR0OHk3amZDOGNlM0ZrM0hOMno3dThIaDZKdExFcjd3UGw5?=
 =?utf-8?B?ZHJScS81VnVoRFE3NG1XUW5ycDQzeTVEeHJXdXVzRXU4NzZ3TzhnbEthMXpQ?=
 =?utf-8?B?c0JuSzlFOXFRNjZBQ1pBVjRweGRSMS8rZXBESmc4ZjJuK1BZNHlQREJneWQz?=
 =?utf-8?B?QXc2cjdLZEljdG1HV25VUldQYTNCT3YxcEtBYjlkU3ExYWtYZTZFVUxlaTNw?=
 =?utf-8?B?VWRUVHpJeVNzN2xVeTV0aXlsbGlMY0FSM3k3My9tdnFteDE2eFdHZWs3U3R5?=
 =?utf-8?B?emtjSUNBY1c2akw1S0llWmlqdVh5aEsyV1d6emI5c2Vzd1cxTFRlcW80QkFU?=
 =?utf-8?B?NXJ2QmcvM2tKZW1kMFJPNE5VN2dCVCtRYUxIWmcyL0wvMGRGdkVtelMxQWJZ?=
 =?utf-8?B?SzdyakR6T3l4bk4rT29CNUg5YTZSQXNwTldaYTdlcXNZaWdSUExtWTNwT1BR?=
 =?utf-8?B?dEdLVENubVNBWHB4LzNpZnNkM3kwYVlOMmdvOWJsRHpraVN3V3N2NWdRK0Vk?=
 =?utf-8?B?K3FNa0JQa0ZGNkJEREJ2ckcwZFNUM3I5anJlcHVSSzRpRjlFMXRuQ3VSR0gy?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <916C5B99622975468CE913ECF2BD3028@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Dmj+UjLrPw3oHJ/+NwM3AeMo7ORgOu3469mk/tt3r8/bykAKYht4ffLzkPLUDrdfkN3obJQObnpeU0uv+sGrxmNG+PSHpwTcLdGuDo377n4N19GiwHUn9k7JSCrQUO7I13d2dOxJScC0Vo8dUuWsy7pz7vbRGWwKF3vDwo+e9DrSEsVIknH9DbSakEHQRlCeBCEf/gBogZpvN2AqAAUsH1WYsyVP14EsxF3cIYujg9YD4l92CiOzBGo2egMPV37Uq3n1CymOD6qj9HqWb3BtoeFZfS28fsV8G+9nPsh6JvIshBveWxmro8NXLhppyi1ToCgOs0KSVuXVSMpnBnFGd7tIcdePHnihxuZVRgRlLMVpW6Q3rdSM8T9SOuE+HslnzIiNjwL7sex2eux2Y4PETk1XzsTLWc9iMtEeDjXvGZJxlc9UNvVQevZXbOeLsCvm/Z/VWF1MSsL/m/KeFdGIpZuO8TjMRUezwuEOhLZrSg/gZEsyTMNQWXa94XFeTBCRN6obRAkuArf2Ly7F25WKroeeHnOw4WnLrXRpNqfLxjMuQzLZM9IpGKGC2cpKwJzTeZUGeorgAMmWI6jXYA4wpCwkhiLnsZip2PDNsTpKunU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe289f53-0bdb-45d1-f968-08dd67cba82a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 16:24:15.3720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uMIcc/i3z3PpxN1Fxxr7D9Lo8jEFIBnT4nV7opCYc+MA3u2v4bgxkwcTRyM5qSoGF+kSLP+th4M+rSKdOK41YzZ+WJwNDhpvTGDsm29c3YE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503200103
X-Proofpoint-GUID: RrGwIEwDvstGWPWYmxqpuxdgyFHC_Iut
X-Proofpoint-ORIG-GUID: RrGwIEwDvstGWPWYmxqpuxdgyFHC_Iut

DQoNCj4gT24gTWFyIDYsIDIwMjUsIGF0IDc6NDbigK9QTSwgUGF1bCBNb29yZSA8cGF1bEBwYXVs
LW1vb3JlLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBNYXJjaCA2LCAyMDI1IDU6Mjk6MzYgUE0gRXJp
YyBTbm93YmVyZyA8ZXJpYy5zbm93YmVyZ0BvcmFjbGUuY29tPiB3cm90ZToNCj4+PiBPbiBNYXIg
NSwgMjAyNSwgYXQgNjoxMuKAr1BNLCBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9vcmUuY29tPiB3
cm90ZToNCj4+PiANCj4+PiBPbiBXZWQsIE1hciA1LCAyMDI1IGF0IDQ6MzDigK9QTSBFcmljIFNu
b3diZXJnIDxlcmljLnNub3diZXJnQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4+Pj4gT24gTWFyIDQs
IDIwMjUsIGF0IDU6MjPigK9QTSwgUGF1bCBNb29yZSA8cGF1bEBwYXVsLW1vb3JlLmNvbT4gd3Jv
dGU6DQo+Pj4+PiBPbiBUdWUsIE1hciA0LCAyMDI1IGF0IDk6NDfigK9BTSBFcmljIFNub3diZXJn
IDxlcmljLnNub3diZXJnQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4+Pj4+PiBPbiBNYXIgMywgMjAy
NSwgYXQgMzo0MOKAr1BNLCBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9vcmUuY29tPiB3cm90ZToN
Cj4+Pj4+Pj4gT24gRnJpLCBGZWIgMjgsIDIwMjUgYXQgMTI6NTLigK9QTSBFcmljIFNub3diZXJn
IDxlcmljLnNub3diZXJnQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4+Pj4+Pj4+IE9uIEZlYiAyOCwg
MjAyNSwgYXQgOToxNOKAr0FNLCBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9vcmUuY29tPiB3cm90
ZToNCj4+Pj4+Pj4+PiBPbiBGcmksIEZlYiAyOCwgMjAyNSBhdCA5OjA54oCvQU0gTWltaSBab2hh
ciA8em9oYXJAbGludXguaWJtLmNvbT4gd3JvdGU6DQo+Pj4+Pj4+Pj4+IE9uIFRodSwgMjAyNS0w
Mi0yNyBhdCAxNzoyMiAtMDUwMCwgUGF1bCBNb29yZSB3cm90ZToNCj4+Pj4+Pj4+Pj4+IA0KPj4+
Pj4+Pj4+Pj4gSSdkIHN0aWxsIGFsc28gbGlrZSB0byBzZWUgc29tZSBkaXNjdXNzaW9uIGFib3V0
IG1vdmluZyB0b3dhcmRzIHRoZQ0KPj4+Pj4+Pj4+Pj4gYWRkaXRpb24gb2Yga2V5cmluZ3Mgb3Jp
ZW50ZWQgdG93YXJkcyB1c2FnZSBpbnN0ZWFkIG9mIGxpbWl0aW5nDQo+Pj4+Pj4+Pj4+PiBvdXJz
ZWx2ZXMgdG8ga2V5cmluZ3MgdGhhdCBhcmUgb3JpZW50ZWQgb24gdGhlIHNvdXJjZSBvZiB0aGUg
a2V5cy4NCj4+Pj4+Pj4+Pj4+IFBlcmhhcHMgSSdtIG1pc3Npbmcgc29tZSBpbXBvcnRhbnQgZGV0
YWlsIHdoaWNoIG1ha2VzIHRoaXMNCj4+Pj4+Pj4+Pj4+IGltcHJhY3RpY2FsLCBidXQgaXQgc2Vl
bXMgbGlrZSBhbiBvYnZpb3VzIGltcHJvdmVtZW50IHRvIG1lIGFuZCB3b3VsZA0KPj4+Pj4+Pj4+
Pj4gZ28gYSBsb25nIHdheSB0b3dhcmRzIHNvbHZpbmcgc29tZSBvZiB0aGUgcHJvYmxlbXMgdGhh
dCB3ZSB0eXBpY2FsbHkNCj4+Pj4+Pj4+Pj4+IHNlZSB3aXRoIGtlcm5lbCBrZXlzLg0KPj4+Pj4+
Pj4gDQo+Pj4+Pj4+PiBUaGUgaW50ZW50IGlzIG5vdCB0byBsaW1pdCBvdXJzZWx2ZXMgdG8gdGhl
IHNvdXJjZSBvZiB0aGUga2V5LiAgVGhlIG1haW4NCj4+Pj4+Pj4+IHBvaW50IG9mIENsYXZpcyBp
cyB0byBhbGxvdyB0aGUgZW5kLXVzZXIgdG8gZGV0ZXJtaW5lIHdoYXQga2VybmVsIGtleXMNCj4+
Pj4+Pj4+IHRoZXkgd2FudCB0byB0cnVzdCBhbmQgZm9yIHdoYXQgcHVycG9zZSwgaXJyZXNwZWN0
aXZlIG9mIHRoZSBvcmlnaW5hdGluZw0KPj4+Pj4+Pj4gc291cmNlICguYnVpbHRpbl90cnVzdGVk
LCAuc2Vjb25kYXJ5LCAubWFjaGluZSwgb3IgLnBsYXRmb3JtKS4gSWYgd2UgY291bGQNCj4+Pj4+
Pj4+IGdvIGJhY2sgaW4gdGltZSwgaW5kaXZpZHVhbCBrZXlyaW5ncyBjb3VsZCBiZSBjcmVhdGVk
IHRoYXQgYXJlIG9yaWVudGVkDQo+Pj4+Pj4+PiB0b3dhcmQgdXNhZ2UuICAgVGhlIGlkZWEgZm9y
IGludHJvZHVjaW5nIENsYXZpcyBpcyB0byBicmlkZ2Ugd2hhdCB3ZQ0KPj4+Pj4+Pj4gaGF2ZSB0
b2RheSB3aXRoIGtlcm5lbCBrZXlzIGFuZCBhbGxvdyB0aGVtIHRvIGJlIHVzYWdlIGJhc2VkLg0K
Pj4+Pj4+PiANCj4+Pj4+Pj4gV2hpbGUgaXQgaXMgdW5saWtlbHkgdGhhdCB0aGUgY3VycmVudCB3
ZWxsIGtub3duIGtleXJpbmdzIGNvdWxkIGJlDQo+Pj4+Pj4+IHJlbW92ZWQsIEkgc2VlIG5vIHJl
YXNvbiB3aHkgbmV3IHVzYWdlIG9yaWVudGVkIGtleXJpbmdzIGNvdWxkIG5vdCBiZQ0KPj4+Pj4+
PiBpbnRyb2R1Y2VkLiAgV2UndmUgc2VlbiBmYXIgbW9yZSBzaWduaWZpY2FudCBzaGlmdHMgaW4g
dGhlIGtlcm5lbCBvdmVyDQo+Pj4+Pj4+IHRoZSB5ZWFycy4NCj4+Pj4+PiANCj4+Pj4+PiBDb3Vs
ZCB5b3UgZnVydGhlciBjbGFyaWZ5IGhvdyBhIHVzYWdlIG9yaWVudGVkIGtleXJpbmcgd291bGQg
d29yaz8gIEZvcg0KPj4+Pj4+IGV4YW1wbGUsIGlmIGEga2VybmVsIG1vZHVsZSBrZXlyaW5nIHdh
cyBhZGRlZCwgaG93IHdvdWxkIHRoZSBlbmQtdXNlcg0KPj4+Pj4+IGFkZCBrZXlzIHRvIGl0IHdo
aWxlIG1haW50YWluaW5nIGEgcm9vdCBvZiB0cnVzdD8NCj4+Pj4+IA0KPj4+Pj4gQ29uc2lkZXIg
aXQgYW4gZXhlcmNpc2UgbGVmdCB0byB0aGUgcmVhZGVyIDopDQo+Pj4+PiANCj4+Pj4+IEkgaW1h
Z2luZSB0aGVyZSBhcmUgZGlmZmVyZW50IHdheXMgb25lIGNvdWxkIGRvIHRoYXQsIGVpdGhlciB1
c2luZw0KPj4+Pj4gdHJhZGl0aW9uYWwgdXNlci9ncm91cC9jYXBhYmlsaXR5IHBlcm1pc3Npb25z
IGFuZC9vciBMU00gcGVybWlzc2lvbnMsDQo+Pj4+PiBpdCB3b3VsZCBkZXBlbmQgb24gdGhlIGVu
dmlyb25tZW50IGFuZCB0aGUgc2VjdXJpdHkgZ29hbHMgb2YgdGhlDQo+Pj4+PiBvdmVyYWxsIHN5
c3RlbS4NCj4+Pj4gDQo+Pj4+IFRoZXNlIGtleXMgYXJlIHVzZWQgYnkgdGhlIExvY2tkb3duIExT
TSB0byBwcm92aWRlIHNpZ25hdHVyZQ0KPj4+PiB2YWxpZGF0aW9uLg0KPj4+PiANCj4+Pj4gSSBy
ZWFsaXplIHRoZSBjb250ZW50cyB0aGF0IGZvbGxvdyBpbiB0aGlzIHBhcmFncmFwaCBpcyBvdXRz
aWRlIHRoZQ0KPj4+PiBib3VuZGFyeSBvZiBtYWlubGluZSBrZXJuZWwgY29kZS4gIEV2ZXJ5IGRp
c3RybyB0aGF0IHdhbnRzIHRoZWlyDQo+Pj4+IHNoaW0gc2lnbmVkIG11c3QgZXhwbGFpbiBob3cg
dGhlaXIga2VybmVsIGVuZm9yY2VzIGxvY2tkb3duDQo+Pj4+IG1vZGUuICBUaGUgbWluaW11bSBy
ZXF1aXJlbWVudCBpcyBsb2NrZG93biBpbiBpbnRlZ3JpdHkgbW9kZS4NCj4+Pj4gQWxzbywgdGhl
IGV4cGVjdGF0aW9uIGlzIGxvY2tkb3duIGVuZm9yY2VtZW50IGNvbnRpbnVlcyBvbg0KPj4+PiB0
aHJvdWdoIGEga2V4ZWMuDQo+Pj4gDQo+Pj4gSSBwZXJzb25hbGx5IGZpbmQgaXQgdmVyeSBhbXVz
aW5nIHRoZSBVRUZJIFNlY3VyZSBCb290IHNoaW0gaXMgcmVsaWFudA0KPj4+IG9uIGFuIHVubWFp
bnRhaW5lZCBhbmQgb25seSBtYXJnaW5hbGx5IHN1cHBvcnRlZCBMU00sIExvY2tkb3duLiAgSGFz
DQo+Pj4gYW55b25lIHJlY2VudGx5IHZlcmlmaWVkIHRoYXQgTG9ja2Rvd24ncyBwcm90ZWN0aW9u
cyBhcmUgc3RpbGwgaW50YWN0DQo+Pj4gYW5kIGNvbXByZWhlbnNpdmUgZW5vdWdoIHRvIGJlIHdv
cnRod2hpbGU/ICBTb3JyeSwgdGhpcyBpcyBhIGJpdCBvZiBhDQo+Pj4gZGlncmVzc2lvbiwgYnV0
IHNpbmNlIHlvdSB3ZXJlIHRoZSBvbmUgdG8gYnJpbmcgdXAgTG9ja2Rvd24gSSB0aG91Z2h0DQo+
Pj4gaXQgd291bGQgYmUgaW1wb3J0YW50IHRvIG1lbnRpb24gdGhhdCBJIGRvbid0IGhhdmUgbXVj
aCBmYWl0aCB0aGF0IGl0DQo+Pj4gaXMgc3RpbGwgd29ya2luZyB0byB0aGUgc2FtZSBsZXZlbCBh
cyBpdCBvcmlnaW5hbGx5IHdhcyBpbnRlbmRlZC4gIEkNCj4+PiBoYXZlIGEgVE9ETyBsaXN0IGl0
ZW0gdG8gZHJhZnQgYSBwb2xpY3kgYXJvdW5kIGRlcHJlY2F0aW5nDQo+Pj4gdW5tYWludGFpbmVk
IExTTXMgYWZ0ZXIgYW4gZXh0ZW5kZWQgcGVyaW9kIG9mIHRpbWUsIGFuZCBvbmNlIHRoYXQgaXMN
Cj4+PiBpbiBwbGFjZSBpZiB3ZSBkb24ndCBoYXZlIGEgcXVhbGlmaWVkIG1haW50YWluZXIgZm9y
IExvY2tkb3duIGl0IHdpbGwNCj4+PiBsaWtlbHkgZmFsbCBpbnRvIHRoZSBkZXByZWNhdGlvbiBw
cm9jZXNzICh3aGF0ZXZlciB0aGF0IG1heSBiZSkuDQo+PiANCj4+IERvZXMgdGhpcyBtZWFuIE1p
Y3Jvc29mdCB3aWxsIGJlZ2luIHNpZ25pbmcgc2hpbXMgaW4gdGhlIGZ1dHVyZSB3aXRob3V0DQo+
PiB0aGUgbG9ja2Rvd24gcmVxdWlyZW1lbnQ/DQo+IA0KPiBUaGF0J3Mgbm90IGEgcXVlc3Rpb24g
SSBjYW4gYW5zd2VyLCB5b3UnbGwgbmVlZCB0byBkaXNjdXNzIHRoYXQgd2l0aCB0aGUgVUVGSSBT
QiBwZW9wbGUuDQoNCkJhc2VkIG9uIHlvdXIgcHJldmlvdXMgbG9ja2Rvd24gY29tbWVudHMsIEkg
dGhvdWdodCB5b3UgbWlnaHQgaGF2ZSANCnNvbWUgbmV3IGluZm9ybWF0aW9uLiAgSGF2aW5nIGxv
Y2tkb3duIGVuZm9yY2VtZW50IGhhcyBhbHdheXMgYmVlbiANCmEgcmVxdWlyZW1lbnQgdG8gZ2V0
IGEgc2hpbSBzaWduZWQgYnkgTWljcm9zb2Z0LiANCg0KVGhlIGFsdGVybmF0aXZlICJ1c2FnZS1v
cmllbnRlZCBrZXlyaW5nIiBhcHByb2FjaCB5b3UndmUgc3VnZ2VzdGVkIA0Kd291bGRuJ3QgYWxp
Z24gd2l0aCB0aGUgdGhyZWF0IG1vZGVsIHRoYXQgbG9ja2Rvd24gYWltcyB0byBhY2hpZXZlLiAg
Rm9yIA0KYSBkaXN0cm8tYmFzZWQga2VybmVsLCBJIGRvbid0IHNlZSB0aGUgdmFsdWUgaW4gcHVy
c3Vpbmcgc3VjaCBhbiBhcHByb2FjaC4gDQpGb3Igc29tZW9uZSBjb21waWxpbmcgdGhlaXIgb3du
IGtlcm5lbCBhbmQgbm90IHVzaW5nIGEgZGlzdHJvIGtlcm5lbCwgDQp0aGV5IGNvdWxkIGNvbXBp
bGUgaW4gdGhlaXIgb3duIGtleXMuICBXaXRoIENsYXZpcywgSSBhdHRlbXB0ZWQgdG8gZGV2ZWxv
cCANCmFuIGFwcHJvYWNoIHRoYXQgd291bGQgbWVldCB0aGUgbG9ja2Rvd24gdGhyZWF0IG1vZGVs
IHJlcXVpcmVtZW50cyANCndoaWxlIGFsbG93aW5nIHRoZSBlbmQgdXNlciB0byBjb250cm9sIGtl
eSB1c2FnZSBhcyB0aGV5IGRlZW0gZml0Lg0KDQo=

