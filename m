Return-Path: <linux-efi+bounces-2868-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA11A4A0E7
	for <lists+linux-efi@lfdr.de>; Fri, 28 Feb 2025 18:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC8A3BC0C6
	for <lists+linux-efi@lfdr.de>; Fri, 28 Feb 2025 17:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB651AA1FE;
	Fri, 28 Feb 2025 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V67wKnkj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WlRpx08g"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1127219993D;
	Fri, 28 Feb 2025 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765177; cv=fail; b=AdAYNZedm66HFOiPUqkIQ9mSm8aqGiaGL5YTXekdAnkyVaFsEWzQyWhPPiiSFeReRCGdBg+ydYBjG3/Eafo8FeHG9vdid8FIRci1ZBZrN6ljTQCnuvdhCtL2GNHIQra0ZpX8qe40CpkXCXqV4aUxUnLsAoSbQA9q5lNeI/o23Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765177; c=relaxed/simple;
	bh=9jfEYFVmsGZjCN55lf3aDtHbsxNGaJzFCsgN/oABeeQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pOl9Px81hn6JiLOtl2crEVGgul4+lK7KUIKa8Xr1GrvVpnd0uzt8GEwU1cw9ghfYeG6h7MKiRr+26cvKgzFtlmeb1HzHGdLuSePCRzGOJj0DWWY0VCXag/PvfJWOZ9/U9ZOtTxYA0PyWWiH8nZaElXN2mGnSx4S/uH9SkB11d1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V67wKnkj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WlRpx08g; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SEHZ0Y002783;
	Fri, 28 Feb 2025 17:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9jfEYFVmsGZjCN55lf3aDtHbsxNGaJzFCsgN/oABeeQ=; b=
	V67wKnkjXX13/IdpfQbq6TIjJRkMoq0vaPBNZzFlAMgmwmthlbjrqKlDtKk+t2PG
	SKsNvIVwEBdts0eguPaRgl02hlWqDRhtP+/7DNT/N3BOKMCLPUWgbZI2okXrKd4I
	f7alE0Fd9fm5J0dy7GXHfy8woT+DzuQvd79R67dk+Cf0N3M+2k/gzn/CN6g+vrhR
	7lFb5VU4q1My/mbDx40ZwP+XggCvxeichtvMe62m62rC8AdRORrzlQjbxPs3AII2
	5AHKLpTw+nCW2xZGXq7liY6EPFmmh9/KbC/ot/iwzT6aYsf6KSKSDpqc3J/T5oZD
	s1YPd6wsxWufkN9rGp/T8w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse63ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 17:51:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51SH7JIe025584;
	Fri, 28 Feb 2025 17:51:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51mhw6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 17:51:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nK8czA9ZoGTkvd8C3+aPAoo94lnc0GFqK/bFOHVCCYTjPEZL/YJib667li34BbuFF8XJoUyohISK2wjIGxI8BhDK062jKWNW8UIXNQ9XQ7NkEdcCsxCV8EIqAzyu1PmqKqwBjN6KPM8Qepjo4Czb2ZO0KOvh/ERoIvq0tZOmwyzcoMzp4G1h7R/VpKmklAxzJ+xtUQPpbsitLKd+8s2DHFpFj6aVLW6ZYIRBBd4+0W0S+7ykrl+734+MPaSqKe9niwOhWmSL/2Nk3SE4PAkDWvEFo9SgEcFZrO9YGxjE1S0SqYoWmb/ALQsoTqUNHDAFLFHl6+48d0nljYssITqz9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jfEYFVmsGZjCN55lf3aDtHbsxNGaJzFCsgN/oABeeQ=;
 b=nXd3QoXAH4aC0GN6Aj/Oz4lZdYF0/SxWghaaSpPliKDsINU9zUSHIOv+1hC0h3h6ManOEQIF+qWKz5qaImaIx9yPs17w4ka5xg2Xx4syHv3qOBYCiDV8a8t/i/MRZEypQnj9Fu5szlcZs8cx/QjnrvAN4Cm3329TWLLMqlw9ajokBtlh43TpZXG1z5ekl8v1rDOWaDIUqahdnKDSaYt7vzUazbvjQOaXF86E0uVMECqGUi81bAGGXPqf3anAQjsjDEM7XUIttbtkmAFZ3lWjUm29AX2x7myaGAEfO3moGmDgtwxMGFAmltlOr+wVV53ElGiOuAlZDjKqZRTQ+lyx3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jfEYFVmsGZjCN55lf3aDtHbsxNGaJzFCsgN/oABeeQ=;
 b=WlRpx08gh3NaTSDGOLgQ0MbTBCmY/RsKCirHpTYrUdjgnUM4HXLPMQAHGJsg5Wv+dl//+h5bz71DamFv21QJdsLo4efV+ikFxNmt0Nt1qg0xyE0zC/42BPdKEAQaTDiwgeiAI0KkB4Cnlyl0m5LfKwP434HpVdoFn717mVmVj9c=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by DS0PR10MB6947.namprd10.prod.outlook.com (2603:10b6:8:145::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 17:51:52 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 17:51:52 +0000
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
 AQHbIK0E/vdc4Eou30K4SgPRfeDFerL0Jc4AgBIDLwCAAF1+gIADEbkAgADjnYCAUfK8AIAAHD0AgAEIXICAACNLAIAAGwsA
Date: Fri, 28 Feb 2025 17:51:52 +0000
Message-ID: <FD501FB8-72D2-4B10-A03A-F52FC5B67646@oracle.com>
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
In-Reply-To:
 <CAHC9VhTz6U5rRdbJBWq0_U4BSKTsiGCsaX=LTgisNNoZXZokOA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|DS0PR10MB6947:EE_
x-ms-office365-filtering-correlation-id: 0a191117-edc6-434c-4b10-08dd5820955f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SXRyNE4rU0IzMDVwdW9VeStXTDBnMURLVGNlQlZOUlpodWVUWmpEVkpMQ3ph?=
 =?utf-8?B?MDRMQ3NVa252SWxsdkZWTkNVdmg1S0lVemFrUDUzWGF4YzdBZS9ScERlckcw?=
 =?utf-8?B?ZW1BYXZ6em51TFhoZEEyUFU5QXlvQlM1ZUhLNjBNd2dmVGRabSswaE9FTWZV?=
 =?utf-8?B?WVpDZjBseDJmYndlZHlmbDBMTVl6alh6TU1rUXptVERVN29LT1pIeWRoclM5?=
 =?utf-8?B?UkVoUCtoMkREcFhjQ3R4dzY3OFlhR2hPaVZodEEvM2Q4QVI5T2c0N1FUODdW?=
 =?utf-8?B?blpnWkZZaDFMWmJRYmE2azlWTHlTOHY4SkRyTE1mMkg0MXRYd0FRb0dUVGZ4?=
 =?utf-8?B?RTNuUXIrQW5zdk1kdE8vTlYxS3J6TGE2VDZOdXRTRVphTm9zek1KdWlLSDIx?=
 =?utf-8?B?RG9mYWJ3T2U5MjcyNDhYenJFMmx4bS9WdTVQQjVUNEVFM0RrSlkvTVE2Tjh3?=
 =?utf-8?B?LytKbU9HdUs4eCtSbVdxcVFhVHNPQk9BMERPNmtXTFhDVCtRZFo4VmtsL3Zn?=
 =?utf-8?B?MndtaENPVGlMSVMvTE9FMUtQMUNzeXQwRVZYTmErSzgwRkRUckxFQlFIRWRk?=
 =?utf-8?B?VlZWNE0rbWpraDQ0VEY1K2hRK1hHcTBCY1JTeE5ydkRVT1M0VVF4bk9rSWpW?=
 =?utf-8?B?bW12Y29sL3duYTQ2V1hIaDVQWHpvcGJXenIveU84aVAzN21QMzI2UTQ5UmRR?=
 =?utf-8?B?NnZSTkJWSnQrSU1jSXdDUjFUNEFoR1BrMjBRbjN1QTlzenZPdDM4ZEExa3h5?=
 =?utf-8?B?aitGZWs4a3pHRWx0czVhWWJURDYweVIwc3Y5ZHVqejZNd0FCYTk4djJSVFJ0?=
 =?utf-8?B?QkxxTzN3VDNGRXRBWHFWbEN2UG1sQi9FM1FQek1hNUt2dldURHZhVWY5SXJy?=
 =?utf-8?B?WVJCS0lreTEvSTlxNzdhaXQ4MGdZb0wvUXl3aVNSYUY4b1g2eEJnb1ppZWNn?=
 =?utf-8?B?dUlFVUJwVkRPNnZaK3ZYYUh1OFlIZVI2TGpWT3lhS3d6YmZDdEpKaDRSN2ZD?=
 =?utf-8?B?ZEtJMEs2eDRzS3lVakFtcUFOVGU3K0tMQUc3TGY4dWtiYW5TMXA5NklHTmsv?=
 =?utf-8?B?ZVBIZGpXc1J2M0d2c2VEY1dtN1BxVldLRVJPL1EwQjMyNnhhTS9lV0lzaFdB?=
 =?utf-8?B?V1Z6Z3UxZzROcGlIZzJtN3MyV1oyM25uUTIxY3lwVkRwTkNXUXZmTHk3ZHgy?=
 =?utf-8?B?LytqRHUwNU9LOWJrQ0o5ZWFpemJISjFsNERJYzlNcWNHUTVsTVpBRVkwNHl1?=
 =?utf-8?B?dEVlTDdCYUNYcGhOOUtjbmF3ZnlpdWVuQkJZSzJDYitSRVZVRVloMlM5N2N2?=
 =?utf-8?B?YmpxbFlQeWRVYjZLWHVJVVkwVWNUZnlQNmZEdEc3WDMxOXl2QkUxelVEQkN6?=
 =?utf-8?B?VjJIZjdrak5MZTFkekNKcVBUSUxyMEo3MFp1d3NxSGlmYm44M1ptcmVCdkFI?=
 =?utf-8?B?bjN3NGFOMExqT1lMK1hFN1F4OGVXS0N0dGNLSUxQM1NMOFNsU1NFcVMvZHlw?=
 =?utf-8?B?ekN3eDdqVFNnem5uSWNKOEUyeXpnVy9FVlNEdUNTNFJnOUViMXlEalhKQ3RY?=
 =?utf-8?B?TVBIRC9mYVRnem1tSzNGZU1veFlnL3RteC9ReHBFK3M1V0dTdkZiN2xNZ3pV?=
 =?utf-8?B?aFd3ZzJIYWFSRUsvUkVFRDVzYjYySHAzajk4MHJiUnY1bVpxSnlDZmllVkRx?=
 =?utf-8?B?VENZcGZrMm5PTk80UkFmMkRPdzBCcXVUVXFWNk5UY3EvNldha0NlYnBoVUUz?=
 =?utf-8?B?ak5zVDZmeFdicmJ2aG5Tb0ExQU5tb1NGRm1GbEZ0Vk5wVlp4Yms4RG40Wkdm?=
 =?utf-8?B?RXZhTFp5OWU3aGRiSWdjVEVhaVNNNWRndlBWa3JKMlZNTUxTbG1FL2JmbXlm?=
 =?utf-8?B?c0xCakNZUlVFWUl5ZEk5c1ovMW84T2hiekpKZi9hQmNkZFBKSC93RFZYRVBV?=
 =?utf-8?Q?yLLPhRYvWPvsab0yuxgZcXoVKonzRB59?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VHRaRDN1OHlPUHBtWDJRM1U4QWcvMWdKWTlURFQ0aTRWV3RBZjhLUEtnZVha?=
 =?utf-8?B?RHNYY2RYR1lhNGxsNWVkWHNGN0Jxa0tZY0NXT0EzNzVMc2N1WDluOFVHeTV6?=
 =?utf-8?B?NUhvRTAxSWpTclJxaEJWejNPaUt2WjhaaE9laFZ6OWhVTlFKK3M5VWQxbUp4?=
 =?utf-8?B?djhRKy9LQjZYT2JsWFpsdS9kSmpGdTVpbll2OHE0NUdyY1duT0duSC95MitX?=
 =?utf-8?B?NmlsaHNaUE1Vb0J1ZkZvUzZmK1RmbVA1dnlvQ0E0a3BPRThPeElmV3R1SjFJ?=
 =?utf-8?B?Q254SDVXV0h2VGE2NHhqZkRGUGlKdGNKT1VMS1A0M1l6UjZDczdDZEJMUTc4?=
 =?utf-8?B?eVRCYlpaYmxVRHpDYkNRR3l6RGVINi9sYUR5TExrT0pjWDl5c3lHT0RKbmd0?=
 =?utf-8?B?UFpIOTZ6UFBpR3dUenlNbFJUbStsNDhxU3VVL2VPUjJLejFQZjFad1BpRzRP?=
 =?utf-8?B?YnczYkJtU1JtWmFZRXFZWWNnMVVPTXNJMVgraXhJb0JFM0ptNWNjRFpyY2Fy?=
 =?utf-8?B?ZG52SDBIdy9wK0hmeHpOdWNvR3NEUnBDL2UyT3hqbnQ3dHBRb0luM21oMWFS?=
 =?utf-8?B?V2QwOW1nVGdyY0I3SFFMRHF2eHNOell2cVVNakJWc0FEVkdoRUdaZ1hoOXpI?=
 =?utf-8?B?Z2xySDYvcUtPM3pqS3pwbDNHQ3M5TmNuYUJhbkowSm1wYVdJQ0FDcGRrWkZh?=
 =?utf-8?B?L204Qnl5SEZoeTBVY0lwdWNxenpJdHF6eFl1K0d4TE1QdU5pbmhnRGZwSC9C?=
 =?utf-8?B?TmhoNjVkS3VkQ3RGMkJmcDM3L0ltWW9SMXJvTkxwdDVrVzBwZHBNQmhVeWpk?=
 =?utf-8?B?aGNSOEhkbkkvVUhMbE9VYjFERHJWY3Q4czkzamtGVUpqaVM2elhEUEg2TGNJ?=
 =?utf-8?B?RmFkRktmckRvSFJ2azBGdnF1NGR1dzZJSzV6amYxQUlwMVpXYWtPOXNvNzhm?=
 =?utf-8?B?NXpBTjA3ckV4enRXNTVjL0w5QnNuU3loRHZxNXhWbGdxZ2tKcFZsME9Lc3pH?=
 =?utf-8?B?Umsxb0xHZll4Vy8xZ2lZOFJHVlh0QUZ2d0wrUzlxNVVjMGorSlRlTGJzS2VH?=
 =?utf-8?B?UElmVmlkQ05OYjB1dWJRTDI2blphM0d5ZWlnMGczWi9yc2s5NENvZVhWNkhi?=
 =?utf-8?B?Q3BWdXVGZDk1RGJzalc4N1NaWlRkdURDaHNqZ0pXSStzVnFwUVExSTR4RVhm?=
 =?utf-8?B?Tk9Rc3Z6ZDNVWnZ0STFhckd5VlRWQU8xZEhUTm81U3BlTEpRV0NEL0lNY0tE?=
 =?utf-8?B?NkdWdC9aQnJ5YjJIeVd6NUlJbUZxVy9kN2hkUFJsVCtrbjJQa0g3Ri96eG90?=
 =?utf-8?B?RjFFZHUzUGdkaXhRNmpGSHRqQ1NrYlJZcERzQzZDWFFLMHJyd2F5MFBKeVoy?=
 =?utf-8?B?SkgrWW5NRFIvelVxRTBHQVJDRm84alV0R0JGS0dVYWFZZHp0d3hrOVpGMSti?=
 =?utf-8?B?RTRVaENqb2hDSDNpZmFpQ3BuK3BRTzJKbWEvUEN6VW1OMHVaTU11SlU0NGlP?=
 =?utf-8?B?RFkxcmcwRVJ5Mzl6Z1FTWVpqaXdkWjk5amJPS3hsMDVVUEZocXY4c1hEWGRt?=
 =?utf-8?B?RnZhWE9veWV5OVBKM3pLVVhnSFdxdHc4UC9EN3hwVjlwNWtRNDI5RlJtV0hL?=
 =?utf-8?B?U1VWVjIzeTdscXVPc3RQd1hqS2NDV0RYak1jbTlzL1pqZ3MrNE96U2xyVWIy?=
 =?utf-8?B?QjJOdktaUjhHOWZkMHJFNW5yYWIvaWg1Zk0zMnhveXFNRU95d1V4aXFHZXpT?=
 =?utf-8?B?WFhOcXl3VzQ5NDVMOS90cktKMGhGR2VWNlZrbkxaZllINlgwOGh5Q0dVWk5J?=
 =?utf-8?B?cERsMndlQVBBSGUrWGNLTjN0OTVrcFlzajUrMVk1cjdtNHAzOVY5Yjd0ME43?=
 =?utf-8?B?bUZlRjNhMGVZS1BFNDZQUlNoeUROcjllbnBiZ0VVbHk0ZUtIRDN0TkZhUU5w?=
 =?utf-8?B?Z0Z5NVdpVmMwK2U5OFhDY1lWWHBHY3h3UUdUSXhmZXpIbGhnYkZzNEpISHNs?=
 =?utf-8?B?c3Jlbks0d3JhNkpkWWY1K05zWlcwRml5eFpTdGJFbUNteVVqTTd3Qm1GTmtL?=
 =?utf-8?B?ZURVZnRiSWh4c3BLbUZtU1VwWlNLTHh6VE1XVTRNU0pxb2NubWdDa3BTV09J?=
 =?utf-8?B?aHJTdnBHL0tVMm4vaUNBMERLNWJnSHlTdnFRSXJLTkhvQjFLZ3NLREdoL3lq?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA691F83A968DE42B23A2C975D4D2A08@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5VJbG4ZWEprBZZ11lGAoaMniV5pkjFAqm0VCIWcQ4YrxsdoarZenBGDTGkwOqaXlB1ohAIiFLYiftP+ZkqiJl3ujvMLDTDF+NP1pjS2+naIqGZZVWEbDZft+cP+rdFI+75Fz6JO3r0pOJTKdCgG0aLIWukgCthtuxTcSCYjFINbXdfnRqjwlk34GITeim9S7gMCyqRaYdNoCfFEZAo2UzbyL8UdygAf0GrF+avWN6+oPQWWUwuVVZRjtevLeIkYKlfNgMpLPeFyC1BBF7VtEHs1DqB8oDM3JyLNT/QrPNNPnOsfC3QsSX1nohaav8/dx1KdVInObuQl01j5crboNeoAbvUhANXyn+5ayY1aC6FZKyn6o6EQ/sVALj1oKqfduAL2IlFk1FdauQGyjc0lK5BC7pNJYdMP8B1hjjmQFFe7GzXjcFIbAh7S5hWneBreBrXIY2i+UibLFea29C/5XkdcY+/mqXT7Y7wYbn/pbGhVMruttGzCWcF6EabdarkjiYPD2RMKSRo/bkC4LSQjPMyBqU4fLfB++cw0/+5wC6DBSpD+7bW/NNQ0cMuvY54X7ENjAO2hyTnhxdmdJanf30HpXOB+rLqKURBFRpDRUCwA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a191117-edc6-434c-4b10-08dd5820955f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 17:51:52.4333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yAYRGAKyVdq/qukttGFCuJUAVGVKwAGOyzjPunMwTGJT/PGqX9mBswiHztk6yttPXWejI8Pf3EyNeYzpvYxJKloOPpxVKteb9rIXT7RYd1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6947
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_05,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=985
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502280130
X-Proofpoint-ORIG-GUID: TaOlv5QZY8UX8BBQzIHB3wTA2fMhbv5B
X-Proofpoint-GUID: TaOlv5QZY8UX8BBQzIHB3wTA2fMhbv5B

DQoNCj4gT24gRmViIDI4LCAyMDI1LCBhdCA5OjE04oCvQU0sIFBhdWwgTW9vcmUgPHBhdWxAcGF1
bC1tb29yZS5jb20+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBGZWIgMjgsIDIwMjUgYXQgOTowOeKA
r0FNIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPj4gT24gVGh1LCAy
MDI1LTAyLTI3IGF0IDE3OjIyIC0wNTAwLCBQYXVsIE1vb3JlIHdyb3RlOg0KPj4+IA0KPj4+IEkn
ZCBzdGlsbCBhbHNvIGxpa2UgdG8gc2VlIHNvbWUgZGlzY3Vzc2lvbiBhYm91dCBtb3ZpbmcgdG93
YXJkcyB0aGUNCj4+PiBhZGRpdGlvbiBvZiBrZXlyaW5ncyBvcmllbnRlZCB0b3dhcmRzIHVzYWdl
IGluc3RlYWQgb2YgbGltaXRpbmcNCj4+PiBvdXJzZWx2ZXMgdG8ga2V5cmluZ3MgdGhhdCBhcmUg
b3JpZW50ZWQgb24gdGhlIHNvdXJjZSBvZiB0aGUga2V5cy4NCj4+PiBQZXJoYXBzIEknbSBtaXNz
aW5nIHNvbWUgaW1wb3J0YW50IGRldGFpbCB3aGljaCBtYWtlcyB0aGlzDQo+Pj4gaW1wcmFjdGlj
YWwsIGJ1dCBpdCBzZWVtcyBsaWtlIGFuIG9idmlvdXMgaW1wcm92ZW1lbnQgdG8gbWUgYW5kIHdv
dWxkDQo+Pj4gZ28gYSBsb25nIHdheSB0b3dhcmRzIHNvbHZpbmcgc29tZSBvZiB0aGUgcHJvYmxl
bXMgdGhhdCB3ZSB0eXBpY2FsbHkNCj4+PiBzZWUgd2l0aCBrZXJuZWwga2V5cy4NCg0KVGhlIGlu
dGVudCBpcyBub3QgdG8gbGltaXQgb3Vyc2VsdmVzIHRvIHRoZSBzb3VyY2Ugb2YgdGhlIGtleS4g
IFRoZSBtYWluIA0KcG9pbnQgb2YgQ2xhdmlzIGlzIHRvIGFsbG93IHRoZSBlbmQtdXNlciB0byBk
ZXRlcm1pbmUgd2hhdCBrZXJuZWwga2V5cyANCnRoZXkgd2FudCB0byB0cnVzdCBhbmQgZm9yIHdo
YXQgcHVycG9zZSwgaXJyZXNwZWN0aXZlIG9mIHRoZSBvcmlnaW5hdGluZyANCnNvdXJjZSAoLmJ1
aWx0aW5fdHJ1c3RlZCwgLnNlY29uZGFyeSwgLm1hY2hpbmUsIG9yIC5wbGF0Zm9ybSkuIElmIHdl
IGNvdWxkIA0KZ28gYmFjayBpbiB0aW1lLCBpbmRpdmlkdWFsIGtleXJpbmdzIGNvdWxkIGJlIGNy
ZWF0ZWQgdGhhdCBhcmUgb3JpZW50ZWQgDQp0b3dhcmQgdXNhZ2UuICAgVGhlIGlkZWEgZm9yIGlu
dHJvZHVjaW5nIENsYXZpcyBpcyB0byBicmlkZ2Ugd2hhdCB3ZSANCmhhdmUgdG9kYXkgd2l0aCBr
ZXJuZWwga2V5cyBhbmQgYWxsb3cgdGhlbSB0byBiZSB1c2FnZSBiYXNlZC4NCg0KPj4gDQo+PiBU
aGUgcHJvbGlmZXJhdGlvbiBvZiBrZXlyaW5ncyB3b24ndCBzb2x2ZSB0aGUga2V5IHVzYWdlIHBy
b2JsZW0gZm9yIElNQS0NCj4+IGFwcHJhaXNhbC4gIElNQS1hcHByYWlzYWwgY2FuIGJlIHVzZWQg
dG8gdmVyaWZ5IHRoZSBrZXhlYyBpbWFnZSwga2VybmVsIG1vZHVsZXMsDQo+PiBmaXJ3bWFyZSwg
ZXRjLCBidXQgaXQgYWxzbyB2ZXJpZmllcyBmaWxlIHNpZ25hdHVyZXMgY29udGFpbmVkIGluIHVz
ZXJzcGFjZQ0KPj4gcGFja2FnZXMuDQo+IA0KPiBUbyBiZSBjbGVhciBJIGRvbid0IHRoaW5rIHRo
ZSB1c2FnZSBvcmllbnRlZCBrZXlyaW5nIGlkZWEgd2lsbCBzb2x2ZQ0KPiBldmVyeSBrZXlyaW5n
IHByb2JsZW0sIGJ1dCBpdCBzZWVtcyBsaWtlIGl0IHNvbHZlcyBhIGZhaXIgbnVtYmVyIG9mDQo+
IHRoaW5ncyB0aGF0IEkndmUgaGVhcmQgbGF0ZWx5Lg0KPiANCj4+IFRvIHN1cHBvcnQgdGhlIGxh
dHRlciBjYXNlLCBrZXlyaW5ncyB3b3VsZCBuZWVkIHRvIGJlIGFwcGxpY2F0aW9uDQo+PiBzcGVj
aWZpYy4gIChUaGlzIHZlcnNpb24gb2YgQ2xhdmlzIGRvZXNuJ3Qgc29sdmUgdGhlIGxhdHRlciBr
ZXkgdXNhZ2UgZm9yIElNQS0NCj4+IGFwcHJhaXNhbCBlaXRoZXIuKQ0KPiANCj4gQXBwbGljYXRp
b24gc3BlY2lmaWMga2V5cmluZ3MgYXJlIG1vcmUtb3ItbGVzcyB3aGF0IEkndmUgYmVlbiB0cnlp
bmcNCj4gdG8gZGVzY3JpYmUuDQo+IA0KPj4gVGhlIGtleXMgYmFrZWQgaW50byB0aGUga2VybmVs
IGFyZSB0cnVzdGVkIGJlY2F1c2UgdGhlIGtlcm5lbCBpdHNlbGYgd2FzIHNpZ25lZA0KPj4gYW5k
IHZlcmlmaWVkIChzZWN1cmUgYm9vdCkuICBBbnlvbmUgYnVpbGRpbmcgYSBrZXJuZWwgY2FuIGJ1
aWxkIGEga2V5IGludG8gdGhlDQo+PiBrZXJuZWwgaW1hZ2UsIHdoaWNoIGVzdGFibGlzaGVzIGEg
InJvb3Qgb2YgdHJ1c3QiLiAgVGhhdCBrZXkgY2FuIHRoZW4gYmUgdXNlZCB0bw0KPj4gdmVyaWZ5
IGFuZCBsb2FkIG90aGVyIGtleXMgb250byB0aGUgSU1BIGtleXJpbmcuDQo+IA0KPiBTdXJlLCBJ
J20gbm90IHNheWluZyB0aGF0IHRydXN0IGlzbid0IGltcG9ydGFudCwgYW5kIHRoYXQgdGhlcmUg
YXJlDQo+IHZhcnlpbmcgbGV2ZWxzIG9mIHRydXN0LiAgTXkgYXJndW1lbnQgaXMgdGhhdCBoYXZp
bmcgYWRkaXRpb25hbCwNCj4gdXNhZ2UvYXBwbGljYXRpb24gb3JpZW50ZWQga2V5cmluZ3Mgd2hp
Y2ggY29udGFpbiBsaW5rcyBiYWNrIHRvIGtleXMNCj4gaW1wb3J0ZWQgYW5kIHN0b3JlZCBpbiB0
aGUgdHJhZGl0aW9uYWwgdHJ1c3Qgb3JpZW50ZWQga2V5cmluZ3MgY291bGQNCj4gbmVhdGx5IHNv
bHZlIGEgbnVtYmVyIG9mIGtleXJpbmcgYWNjZXNzIGNvbnRyb2wgaXNzdWVzLg0KDQpJJ20gbm90
IHN1cmUgSSBjb21wbGV0ZWx5IGZvbGxvdyB0aGlzLiBJZiBhIHVzZXIgc3BhY2UgYXBwbGljYXRp
b24gd2FudHMgdG8gDQp1c2Ugc3lzdGVtIGtlcm5lbCBrZXlzIGluIHRoaXMgbWFubmVyLCBjYW4n
dCB0aGlzIGJlICBkb25lIHRvZGF5PyAoSSdtIA0Kbm90IHRhbGtpbmcgYWJvdXQgSU1BIGhlcmUp
LiAgVGhlIGtleWN0bCBoYXMgYm90aCB0aGUgImxpbmsiIGFuZCANCiJyZXN0cmljdF9rZXlyaW5n
Ii4gDQoNCk9yIGRvIHlvdSBtZWFuIHRha2UgdGhpbmdzIGZ1cnRoZXIgd2l0aCBDbGF2aXM/ICBN
ZWFuaW5nIHdoZW4gdXNhZ2UgaXMNCnNldHVwIGZvciBhIGtleSwgaXQgaXMgdGhlbiBwb3B1bGF0
ZWQgaW4gYSBuZXcgdXNhZ2UgYmFzZWQga2V5cmluZz8NCg0K

