Return-Path: <linux-efi+bounces-3067-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8059CA6C4FF
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 22:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CE3B7A4B7E
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 21:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBC2230BF0;
	Fri, 21 Mar 2025 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZUTtHM6n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PEMq+uT+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1731E9B34;
	Fri, 21 Mar 2025 21:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742592072; cv=fail; b=Up9U1+iKhDA4L0frF1TgFtYFEbntjHsO1G/gtGzOVw2SWl9ahhxKNm9fdln1sSM3/PRtvAfVktr9u6MHTrkviKK9uFih2hWOy/lnaL8eu8Cwt9B5BkuNDoK72E214C2uRc0TMgdbJOsL7uVRTtcpylYX72WFxdMOJilbxhXbao0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742592072; c=relaxed/simple;
	bh=xfG//GkuIQeVOEnte4p76vTNK4nCrIEXN2QHK8dNpGg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O/SpoCoEf+Ak4OratuqMIqcEO85rRPkDkDfmZJhWgZoR4eEsU4ty+69H2ySk0bI6yudfD6U9fgBS5I+0VawAiHxJoLt8+zngkFa+kHeoxqOgWG5ozg9jV3PbqhZ62UombxWUsOEuyBoUBpuoUKVh1OSGgBAkMLfrw1ew5esNpLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZUTtHM6n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PEMq+uT+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LKfwAf001575;
	Fri, 21 Mar 2025 21:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=xfG//GkuIQeVOEnte4p76vTNK4nCrIEXN2QHK8dNpGg=; b=
	ZUTtHM6n+X4vE4ajEPeRyd/zUGMTyrr+0VsoucR381QfmYVQ1mTPuiLqrPKT1L5+
	0wafh9z4Lnb1EpavUcaNBoJLQbZ5meMHzpA6mzE1jNwVy61vOm0juXOKQFkBtsri
	UsG8xAmmhW0FZTKat8Bj+DpGHd3bXEkNRLvIZyi9oAMylv46ZB9L9nf+DIq6L0V9
	PTp9tIu4WnRRWgGeeLMTrPZe5adOnKVO/aF9jgkJn9T0BO+2PGAJ1rIh6m+Wa1z1
	Gx9pmzTuyrDKJm2CeQhSyT6czp774wJr+NtFNnMnJ+Q0sYwXdHgkIVmiTa4wujnY
	4fDm1In0qZxPWb6J30uBpg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m19pp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 21:20:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LK5lSr022792;
	Fri, 21 Mar 2025 21:20:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxem8qnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 21:20:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoJSb4bKCqqbymRd3IqB4XT1rqQamvxFrESBjqpgbYk7Tg62LYEhBpdCB9Rql2AfiYGReYnyGJAncgmxjEnxVs0fnGOXnmMMx0tw8srKtRQh9gOBF6f4ftFYIuqXU4kKiBbC69abK1Lw73CSG9n/VJxFGdu8s4Lxosphp1U7KnclM7QY7kE5cG6rvOk/IdAqM53wjeuzztqcHIXqyADvaV0hWDBu5+jLRk7JW34ItBIGSys93COg0tltq+MRXygi2MOJQyVTtK61Wzow2RgGFMHrcGi1og4WBkwONtC9A9KJyveTavM6OYYSvP6qsjnqU+/3FCHym8Rm3/Hq/U7O4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfG//GkuIQeVOEnte4p76vTNK4nCrIEXN2QHK8dNpGg=;
 b=e6z4Qj9Qw3RX6CE2z1Bb/EftYC+a3XctY+x2VRtfspe+b6Cv76Qc0WUKcVBrkgEmac1Jp82brOx7H7ys3Zh5kmngMsFZwbsbg1mz6DujT6zk+8Z81uvJHoYxTqTObOuuf65GKCUvt5/8EoT/nOUjEhQqqOwjIZtKBp70WGkHyWN3dMVqFJEUPI36KoYXQSPnUOly/VE9xN0+m5tDN16pg8VcIxLmbGzSa3jdMCjmReT/c+1Q+leKhquWYKdQW/SL9ZbxOqDudl62WVyG2s7c9ERzut9NKAH09tPgtxMmneWI6VJklMfe0heZYUUK7Wk2JDpVzR5o5kMOxdW5k2lP2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfG//GkuIQeVOEnte4p76vTNK4nCrIEXN2QHK8dNpGg=;
 b=PEMq+uT+jisoWtJGhatuQFz62m2gPxHg/v8rGdxhZHCAfT2Dcl4Jlg7vGuV8tztYFXnJdUcIj1X9JSBQKxBC7kngpJUQONF7/foIUPIDv8b3qoeHnKjCsTacOSphnxRE+6ODXHxUE6lAlnfHp4RnaK8zO8tp6AsX54jsCZ2hrqM=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by SJ0PR10MB4718.namprd10.prod.outlook.com (2603:10b6:a03:2dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 21:20:22 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 21:20:22 +0000
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
 AQHbIK0E/vdc4Eou30K4SgPRfeDFerL0Jc4AgBIDLwCAAF1+gIADEbkAgADjnYCAUfK8AIAAHD0AgAEIXICAACNLAIAAGwsAgAUHzgCAAQ2/gIAAoSGAgAFh24CAAD5VgIABZIsAgABIHQCAFVKsgIAAV02AgAE+nwCAACclAIAAJ/WA
Date: Fri, 21 Mar 2025 21:20:22 +0000
Message-ID: <4F901DC6-51DC-47A1-8D2A-D84DCD9D0C2D@oracle.com>
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
 <CAHC9VhQMN6cgWbxdAgBNffpCAo=ogGdm4qBGS_kKdDmiT8b3cw@mail.gmail.com>
 <B89ED288-1A01-41D2-8ECF-285669139553@oracle.com>
 <CAHC9VhQb55+SmwmrsVpyw5X2Ys0oo6gJ_dbDf64mS5c008230A@mail.gmail.com>
In-Reply-To:
 <CAHC9VhQb55+SmwmrsVpyw5X2Ys0oo6gJ_dbDf64mS5c008230A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|SJ0PR10MB4718:EE_
x-ms-office365-filtering-correlation-id: bf77570b-a285-46a8-30ca-08dd68be3057
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TmEzOUUxZDlaQk1Rc1FoWFI0cWxUMUZ3V2tZSUx1QmVRb0g1dUpkYVMvUjhy?=
 =?utf-8?B?U3BkcHF5SHJqOVRZTVI1RmNaYThDVTN6TFpqZ2p6b05rNnQ2MHhLTDh4QW44?=
 =?utf-8?B?aGJpemJ5a1ZWd1hVSlA4ZmErTGRmb2pFM3Jhb0ErQVhxSVRseVlFSVZQbVd5?=
 =?utf-8?B?d2xhY1NYbEFPaDJnaDRmMnVxTVNEOTRuRTVGc0ZaZWR3ZGdkeVNOdUlQclkw?=
 =?utf-8?B?TnQyUzRHbEltd2JSdUV2TTZ3WS9ETDFrSWh0bUlwdndLR20wdkUwVnNjMUk4?=
 =?utf-8?B?OUFSbk94d0FhbmM2R0w1UzNob2QvazdFSGxLeUNNNHFjYmZpbVhsR3FjRjkx?=
 =?utf-8?B?VEUzR0ZoajlMSGVKWmhybGNxSk5yd21WWnl4WnZRb3V4YnAyWkx5UjI2Umhy?=
 =?utf-8?B?S0w5Q3NiUFl1SUFaN3gvOWpBK2MvbmVTbThIODVVUUt6Z3JjRFdIaHlqT0hY?=
 =?utf-8?B?RGU5ekt6OTAyYTg3MEZyc1VpaHZyWStLZ3c2Y2RPQno2OGh4OGxMaEFWbmd3?=
 =?utf-8?B?NzBkZ3lnakdrME1kbDRWd3BGSTY2SDRFdXk5KzZxMXpzbDNndkpxRzQ2b0th?=
 =?utf-8?B?aXh1eHpTeTVaMTJCTXlzTGgxeEpJUmJobCtpY2VvMWxuWVRuYTlSNWF6OTFO?=
 =?utf-8?B?WGdyLzFJZ2hOckxzQ0RvSVVHZlA1NjgvOEoxbEhoeTF5N2xkVU04RmpvdE5t?=
 =?utf-8?B?V2k2OFNFbHh1Y0dqYklWTnI3WXB2dm9MRlVzdnlpYjJVbWcwYms5Z1pGL2d1?=
 =?utf-8?B?VkU4b3Q1N2dHNDQ4NEE5OFJCaWJjdnNaclQxWlc5R2RKb1JKalUwbUxnUDFF?=
 =?utf-8?B?Q0YzR25QSlM3ME4zODlXY0R5bVE4T3hvbktmcnVwUmI1YndpTzdrdmdCUHZp?=
 =?utf-8?B?NENHV3J2cnZPME5OSkEyeS9sOVZJVzJSM3loQWt5Wmo3WVd4LzhPK3J3RW1m?=
 =?utf-8?B?ZEQ3WlhBbVZmZG1zZTBzWXJSRVZVWGtSWG9XblRvblF4ayt0c0h1MUhyYmxX?=
 =?utf-8?B?TmhXNWNkMHRqYzlNQm9XQXd3ek1DQkFvQXlJd3dtVkh0U3EycXo4TEdhNWNJ?=
 =?utf-8?B?MUphaGNOUTBaN3BpVlFqMGdWcjBXdHpBaGc4SEJ4UW0wZzdjcnJOVFVPbzhr?=
 =?utf-8?B?cklMenF1QmVGR2o0czIzYStzUUNMbmNqR3A0QlY3cFBuY3laY25ObnpHbzNz?=
 =?utf-8?B?aGJ5QlVYdFRkSWVLMG5FbWNCQTl3SzRWU1pKZGpQRkZncUVtSzF6b2s3dXA5?=
 =?utf-8?B?MC9sMlFUU1dDM01yZVUwbkRtd3g0VVlKVGNYZjZienl4cGhJTVdOa3pURmt3?=
 =?utf-8?B?Wi9STTBiQitSdDFpbnp3TFl2Qm5SN3FCMU1leGpQOUR3czRFZW80Y21Gendr?=
 =?utf-8?B?MFA3S2QrblZxWnZ0cmNNTU9LU2IvZVIweDhHVHkxczRORFo4ejdxUVpXZmdP?=
 =?utf-8?B?QWpva1FjanN5ZkQ2bkFIMFpqYkxJTWRnR2E3QndmVnBLbWNsVm5WSFRDSGsr?=
 =?utf-8?B?MTlORmcrek9hR09OQUhZQXZrRUZJeVl1ZUxJaDQ3NTVNRTd1UURQVTBiRTdN?=
 =?utf-8?B?NmZjbnNwNi9KU0M0RUpuSkFtOGtRc2ZIcVVoUVNGTCtmMExmcmdMUlVIZ1F5?=
 =?utf-8?B?ZHJ0N1ZOMnRKamxIL1pFd05KOUhkc25rbVoxS2VOeGpnVC9aa3BMUHRRbWQ3?=
 =?utf-8?B?dk83U2RVOVJNNktMdUxaWExJK2RweHdCd0UyRmptcWR3aDF1UzhjR0RaQTVp?=
 =?utf-8?B?NFFYL0RvK1JvL2VZUFFobm9FckxlRFVXcDlSZjNKUnJyc0hZQzJUbVRXZlc2?=
 =?utf-8?B?aVJnR05IL2VFT0hWS3RBUTFGSldRai9jSWtzSVNhbTNEdDF6cVRRd3ljZFc1?=
 =?utf-8?B?M0FwMlJ3QXVvQnVnRFZ4Z0NWaXU4ejJtOEdKeFRiQlZ3K1A4RXJaVGpqdVVB?=
 =?utf-8?Q?YxkcOFs511EF83Ctp+9IASeFl6mGqf/h?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXZZdzFDZ3VlZVREc0lHWkh2Q3dIOGQ2ZTBGaWUza2pySi9Uejhyd2wyT09T?=
 =?utf-8?B?ckpvWVkralozNGlVTUU5RStPWDF3RVF1aXduTnU4TzNFc2REUkxnUkNiTEZK?=
 =?utf-8?B?bHFkeWhZeCt6dDBXQzZ5OE9xU1FGSGo2SWlEOXUrakliRllJYVlqR0ZuZEsw?=
 =?utf-8?B?dFZnYTdiV1NxVmVKcGxROEZpV2tPWXZ2ZTBSVTBWZ3Z1VkFrbnJLRDY4SDZp?=
 =?utf-8?B?V2tlR1Rwa0RPL0ttZHZWVFRSMmp6WC9vbVpkR2RjT0JXUjUrVm52b2xQQUVQ?=
 =?utf-8?B?R1J1cnZwR05XekZ4WGk3S3pKMjFKckljRlFadHpNN1l0UXRyOEZPeCtNaFpq?=
 =?utf-8?B?bXpXYXlhcHh1WWZhOVVlMStLZGxUS1h4SWRCUThmQnV5c1Erbzd4OXczekNX?=
 =?utf-8?B?NW1DaGFNNWRWUHYyTVpYamJacE1XWG1KTTQ5U2M3NzByRnl6d1ZleHRWdis1?=
 =?utf-8?B?cEN3cTUwTXU5ZFRnRnNuNlVoaXc4dHpVaEVSb2F3V0ptTitVcnBydDNOazFw?=
 =?utf-8?B?N3dnWGJ6OTFVMUlwVFhpYm9oOTl2STBIdVBveGF6UDBXVUE5T29GdnlSVFRM?=
 =?utf-8?B?UFFzcVhnb0VTYzdTdmI3UU9zZmpxRmtFRnRQV3NFbndkOSs5cHRDVzNiLzBo?=
 =?utf-8?B?dE8xK1BwTjhOaVRDc3lvTkhoSkIwaDkrcFFWazI0WmhtU0tpUmdvNGVvanU4?=
 =?utf-8?B?NjlQaHZhSFkvZVB4WGp3dEM4YVNLZnZiVGoyb3hiS081SXZOanJlQ1BVcCts?=
 =?utf-8?B?QnBMQmF4THh5OStsYk5sY3FYY0lhazdMbVlUNTJCV1g2S0J6cmVURVFQRXhX?=
 =?utf-8?B?SUlYZFJkdElQcTdWMnlYVVcwMUU3MTFTVVlGaEE0dWxCYURTZW5TVVZRZWxQ?=
 =?utf-8?B?NmlVbXl5SkgyNFJvcGk4Q09CaG83bFdzRzRvQ2lMdDQ1WStzWUZYS0lOR1JE?=
 =?utf-8?B?NDMxZ1d5TnU1SEprRzVUdGs5a0NIRG5JaWVNemxYTnhVVThOb2RnbXFPRlNH?=
 =?utf-8?B?MmNtTUxTckJNWS92ZWFUdzZSbDVITWh6RmxYa0lqTEVySnFoeENnNWxTVzg3?=
 =?utf-8?B?TU91anI2dzJTMjVMOTB3T29Tb1VEdS9nSEQrNzA3aysvMVpMOThjK29jVCt6?=
 =?utf-8?B?YUVscnB4NDJobEp0bXlpWUZFdzRqWklTVlFOR1ZwWnhsSlRqMUM0eXdLRDMw?=
 =?utf-8?B?eTQrRW91eStDMy9rNGVzc2JsRENHNmRxVWkyb21PUEI0Z2tMZ3h0V2l2Z0VB?=
 =?utf-8?B?a3ZCdEV0b3RkeHNWemRQMU5ncG1wMlZjZ3ZvRC81Y3owOXVIYjd4RUVPTlNC?=
 =?utf-8?B?aWxpK0FSOE43K05nQWFtOENEY3VuSHlydk5NNXh0NnVDVnhmeGpMUndROE8r?=
 =?utf-8?B?VTl2Y29HMjlHd2syWWxiUEp0WUtQUXgzLzhFODRNU0szSHpaeXhCeHQ0V1pL?=
 =?utf-8?B?Yk8wUlJUUS8wMlFaSitiN2UrQWpNN1ZkUDhsWEI1SnFKdUlVYVg0aXJ0cE9W?=
 =?utf-8?B?eldCa1R3Vm04NmVnWDMyaFB1WFRQcUFGNDRwbGg5RlpHRTdOSnpuMUpYdTdx?=
 =?utf-8?B?L0hZRDRJbWlkVXZrempNL0RLTWF1MVQ2UDZsYWR6L1ArV3oveGd1YVBmbysz?=
 =?utf-8?B?ZnkyTkhvdnZxMTkrN1FuTHRsaldpZ0c2bUlsZ1dBMGZBdmEvZkxVVmFhZ3Js?=
 =?utf-8?B?ZzVZSXpVdnlXckU0ZjVZYkhuanpqNGE5UFJNTVpIelZJZmgzV1hzQ01ZMkQ3?=
 =?utf-8?B?VmNIZ0Fad3FpUmUzS080Qll3QUJqMWtOL0s5SDU4akZGdTR0Q1Vkc1JZSUdO?=
 =?utf-8?B?UkZveDJ6Y3V2cElHelh5d24zbkJjOWZKMVRHcVlrN1BOVVg1Y1M5cFRwSGov?=
 =?utf-8?B?UDBqUStZQ2lvdWtZWDU0Ym80cDlMeGo1YXZzbWhva2lYMzZpQU9CY0twRkl5?=
 =?utf-8?B?WFFZRWhDazJZQWY1OGJqU2dGenlSS1BlQnJ4N0M0bUlpamZxSkl5YTk0K2FM?=
 =?utf-8?B?dzY5WklPaExjTFhMQ0pmZTNNOVR2dFlaeG42NUdmVVRmWnlxQ2xKNmthbjBB?=
 =?utf-8?B?SS9WcHgyajQxNTZXbmdaT2hveU0veE5YY0YxSzBjdlpZc1FnWG1YeGZFMnVx?=
 =?utf-8?B?SVBoQnViSDVNRWdjTUQ0bWw5RFRhU1Y1M2VlWFlpbTB5VlRSWFNQZm02d1RY?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F21F0FAEA502D2438A41CC99D6BE78FB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zmqoC81wyWLbLesY8OJFmh6gNzX1rug5KZrWrEdN6IJurFaOCg7/lfIYc7gpQvJKFObdIBZL6i+pryUXDjT5aS4Kv/gOKRwL4k30OgGLmtR9SUIox3bQvKJm6/6mM5i4+fBZ+obFnjXW/aZRusc744Ti211m0C/ENUPDtZzOy/zFF9MrOqVSA+9y3Hw0E+FcmVDzhM4Q4DraBrhZ6pLOi7CQa3gs8sShzCpQc3UGaqnUwyPSZUXr+FHx1aEPLEiUsRjTlME4atNJRE3b5jmMKTQ24gpeGBbtPuxEruGV+J+XmDdBlAksrePs+jJiIY/cRhdbAWsQRvikoCjdA/fMo6rWvGRDg2/FobffkjoJNwXJg7RG2S0Qje5vn9UFcbx+3FZ1lz3OxBNf2QPP3GBY3z1alju2ifW1sROHSK8C9TToI/HgsXhSFs8rV5tp8Qeo+FB3rtOHGCzoJNUWGspi84LJVuwRr5Z3OjIkVESZNYcZUCWVX11rHqOIw9tzztH6+3fESomyYj8QvRUptNqSWR10nz4iws3p0zRmKAFGrcwgLAekWs60eXPrfTjCI3Rl3jbN9QC2hhgpceCdsSSiDzgDNq2v208iLK9bclocQyM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf77570b-a285-46a8-30ca-08dd68be3057
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 21:20:22.0445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m11DOPv3wFxT3dW7PPXDQ7OXG9XqjhW2xfXQKvN759lpPBU3LY3xhbZ4PfueRtVbBKNBC0m8zFuVQIsbJPQC86fmRfrn5KZWBJkELqSnhFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4718
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_07,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=869 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503210155
X-Proofpoint-GUID: A96UP-W9ckLD8OXVvu8MZvAz4I0sa7M8
X-Proofpoint-ORIG-GUID: A96UP-W9ckLD8OXVvu8MZvAz4I0sa7M8

DQoNCj4gT24gTWFyIDIxLCAyMDI1LCBhdCAxMjo1N+KAr1BNLCBQYXVsIE1vb3JlIDxwYXVsQHBh
dWwtbW9vcmUuY29tPiB3cm90ZToNCi4uLiANCj4gLCBidXQgSSB3aWxsIG5vdGUgdGhhdCBJIGRv
bid0IHJlY2FsbCB5b3Ugb2ZmZXJpbmcgdG8gc3RlcA0KPiB1cCBhbmQgbWFpbnRhaW4gTG9ja2Rv
d24gYW55d2hlcmUgaW4gdGhpcyB0aHJlYWQuDQoNCg0KSSBkaWRuJ3QgcmVhbGl6ZSB0aGF0IHRy
eWluZyB0byBjb250cmlidXRlIGEgbmV3IExTTSBhbmQgYmVpbmcgd2lsbGluZyB0byANCmJlIHRo
ZSBtYWludGFpbmVyIG9mIGl0IGFsc28gaW52b2x2ZWQgc3RlcHBpbmcgdXAgdG8gbWFpbnRhaW4g
bG9ja2Rvd24uDQoNCg==

