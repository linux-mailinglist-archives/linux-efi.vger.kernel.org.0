Return-Path: <linux-efi+bounces-3052-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E478EA6C027
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 17:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F19D3A8B37
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 16:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFBF22A7FF;
	Fri, 21 Mar 2025 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oZiJ9i+w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xNRYnM4P"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373A178F30;
	Fri, 21 Mar 2025 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575083; cv=fail; b=VbsEQm4Hoa8rYSPDwWknDhLKFrjYGdK4DJbIQlRggKkM5L5mHdjuLsg1w7D3+thE0Im9VmB25xSjAgRkpEixDYyQbQ+BNB8xtz9loHOmM4hKrScUAF2rylCWmB+2a/9uG394YoG0LlFKm12EuldBvP6rN7FXSF0n2J53saCxpJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575083; c=relaxed/simple;
	bh=s3jj5l1vS9qmSzhaCRKUka/onEKJkjbfemgPehibnHo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dSZVHgv24Apa51BrJLUnYVBQaKYvIi5j3JYisNIJ8A5DRCReTlMIdCYrh+zJwuWX4/s+3wW25yTwwvJVdQunqnGnFKkdxgjcm78rQvZtlyeDC9FsuJMr/2+mNaoieVY/tGRvz23PIu7cYnRj/duY2hpcBk+0LxN+3urLqcL8Mco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oZiJ9i+w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xNRYnM4P; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LEBu3q002588;
	Fri, 21 Mar 2025 16:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=s3jj5l1vS9qmSzhaCRKUka/onEKJkjbfemgPehibnHo=; b=
	oZiJ9i+w68Cp4826eoGLLkonoFQL9jYZOLeKv6XyvCbgx2tjEVLqeNqoUoZvb73V
	ce7Eugq7UdXkwRcMB9SvcQqVxDvnO5rXqc+lgeAIZYBK+ppYEz7clewrgcWQpf/q
	DBo03mP2LCJfGzDSdnva99xv7PC5dR3Og49m2mWrHbUAmpckfKb4spUK6ECs0z8F
	NngyHRhWAE5hQa4WAQXLh7skaKDVHCt8KKwr2WO3O58c4ui8b1eUR6HTJWSMN3YO
	sMRwsTuAOP/MnRC9Fkd1JoNL4jxkS5oX1rygjkmom1j33L7B0i/ZdvZj0O/AeIkc
	oj8e06a4BnY7wUYD9xMsbQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m40ggd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 16:37:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LFXiq6004732;
	Fri, 21 Mar 2025 16:37:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ftmyp1n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 16:37:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYuv1QCLnesoT4Fxxn3Mg9jhztSeP/3dodtZYPWexlCHHQLzcVoYYqbzr0ujLFpWuGtn7jgXvLGNhJyja00b2y896oqj+qRsqknqVAYsitB6a2xV2ZHh4EEt+yvfXvR1zP4KerTjzhvz1w6hJhXYiLUD8YNTWomOPeyzkBHEUyfHsUOV+qJILfIy4281ctqC2XB9fffBUsHqohLFBeOouzkOjSFZL4wPEhwFbbkuV8de3bW4+wkBo023t+hO/eKFPMt+hoR1S0RsH31E/J6XTePsd2UqKQFhKJn5UgIAcxdKIWI2N7J8pAfX6enSsQuuoK4UuoNfV0kVjl0Clj9UAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3jj5l1vS9qmSzhaCRKUka/onEKJkjbfemgPehibnHo=;
 b=MiD2X1vWcMVsTVkp0g+HcqBMYjVrZ/I9AU96BeYUxjg09YC2BU87KiG5mc7ZFfsQEwgsQLML0SuJbz5aj8xRX9djuxcJb4IjhogdExhPkAjI7bBjzQi5iAqeLdA+I20Q9nvCd0jR83pJ1Idm9hjovz7qZwUGSn46JsUES1DlZdV3Jlkh8VBuOEjPTvx+RFAMT+Vwp1D0UQEVnGoAfxfcyiamYwgcTPgnchD7B+nlWacO/Jmfdf1O5emsl/V0THf6ZgO4Tw5PnU1N2rMWOkNGEO3TDBvjFkKa0gegeFuSDYa31MOJm7MEiVW1nqys+6pmXcnmotr1khbJc33CDBQWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3jj5l1vS9qmSzhaCRKUka/onEKJkjbfemgPehibnHo=;
 b=xNRYnM4PDw9pBXxNY1mSec1ud8C9UplOx/a8whWBCrls9uwp9te5/ntTVrvsly9P4iT50kUzqc2wXQs7w2HK+lNK9ZxUkztwLs2h6T7O0dYIXU3gvCLJdGbmBXnScg2nbv9kCrA0nQei+I5P1MrpvoIYZ7TVoZqdvp2TvKsXnsw=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by BN0PR10MB5013.namprd10.prod.outlook.com (2603:10b6:408:120::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 16:37:15 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 16:37:15 +0000
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
 AQHbIK0E/vdc4Eou30K4SgPRfeDFerL0Jc4AgBIDLwCAAF1+gIADEbkAgADjnYCAUfK8AIAAHD0AgAEIXICAACNLAIAAGwsAgAUHzgCAAQ2/gIAAoSGAgAFh24CAAD5VgIABZIsAgABIHQCAFVKsgIAAV02AgAE+nwA=
Date: Fri, 21 Mar 2025 16:37:15 +0000
Message-ID: <B89ED288-1A01-41D2-8ECF-285669139553@oracle.com>
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
In-Reply-To:
 <CAHC9VhQMN6cgWbxdAgBNffpCAo=ogGdm4qBGS_kKdDmiT8b3cw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|BN0PR10MB5013:EE_
x-ms-office365-filtering-correlation-id: 808cafad-d8e1-44e2-429b-08dd6896a37b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U091VUNXL1RhR1ZpaTBzWVBXMHlIN1RKd0R5dEd5T3BXZWsxM0QvTUpodXAy?=
 =?utf-8?B?QzNFQ013M1gzdm16d1dGZVVESmZsMG5lRXRNa1ducis1OTluMjc0Rms0RFBD?=
 =?utf-8?B?c0VkSmQ5NFFFNHB3YjY0QTRaVnVNYllWQ0FkRGlLT0I2b1FvMTI2dmVmcXE0?=
 =?utf-8?B?aTU2T1VqQUUxbk9yMDNJRTVIQkZBbkdzUEtDSkgxc24wQkpSaDA3NS9tay9J?=
 =?utf-8?B?R2Z5RWNWQndGRTRqbjZzM09zNmVQamxqVUR5VHd0UGRYTHRxZ1p4TWc1alRP?=
 =?utf-8?B?TFVXdS9hK2VGRkVFSTlNMXNzVlpBejJjMGVTbmVveFViV2hiVlhFcGt5b24v?=
 =?utf-8?B?UERmR3pPOXI1RG5BN25wNHhLZjZCcFVEelJBR3lobTNVaHF3ZW9SR3BrZTFy?=
 =?utf-8?B?OGk1UUpzYWJ6NXZZcHo1b3FZcitxdHkrNjZhcEpNQTFuWUQwZjVPOTI3VEow?=
 =?utf-8?B?TnRpdjhXNE9GRjB2d0VOWTVhTitsYmRJYnh5MFJLbFovYy92a2ZyMjVSMzFt?=
 =?utf-8?B?UlJ5SkpPMDYvV1FOQkFFUWtLakRkRnI0YXZONVBFMjFydGpnY1RwNzdrdm45?=
 =?utf-8?B?Z2J0MXhmRXVaZUlXV0FqcDVyaC9aZlQwZmYrWTM0ckZuZjBWcEtCQ2JiZjY0?=
 =?utf-8?B?SkpCdkVibTViajRUZEs4eGVnZm1sMnQ5eEtuUlJlT3FnTHpwanl1N1JtYUM4?=
 =?utf-8?B?c0tWeUtJMm5LbFFzRWlzUnAvNld2ZlhtRGJrZ045RkZhdjlOMmVNZVExTjQ2?=
 =?utf-8?B?Ym9BZ1VGem41eHdXZFZDOGVCeUMyQ3NvZE90ZEFJLy9pa0tSeGlIMTRpNzJN?=
 =?utf-8?B?cVVVb2hMTmtmaXhiZU1lV3ZpYXl0SVRFcUF5NjN1ZVFMc3Rmc1A4d0MyTFBj?=
 =?utf-8?B?ZG1wSjZ4YU5URktsbmZTQ3BNTGREY1RSd3NsTGVUVElUejhtOHdtbDBDeCsr?=
 =?utf-8?B?MkNkU3NyMHYvV3dxNXJsdnQ4bCszN0E4N3dlZXFDT2Z3K3I3cS9xVndaVWhB?=
 =?utf-8?B?aTMvWll5VVUzbTZmVFBnSXBwcHl2aCtBYXRScFp3QUYxNEtBRVgxOHZlVDJy?=
 =?utf-8?B?R2ZKdnNwZzBaTTgvTEJRTWQ5ZlBMczJVY1VWK0h6czZuMGx5ZmZGKzF6ZUtB?=
 =?utf-8?B?djNDQ3FVZ2FMcXBJRnpGby83YVdCOW91amhoYkdnMEdDd1haZkYxaERvSndK?=
 =?utf-8?B?ZTNHVEVKMXRpdVJPVlhTU3RYNjB4Vng2MEhvdzVncVl2aXlhTkdrUjdUaTJq?=
 =?utf-8?B?RDhZdENyRWcwcVE4R045aDdQbXYwMUpuTjdNUmFEVTdGVDJvSW5WVmM4TXpt?=
 =?utf-8?B?QmV0c1FCVnNuZ0hDcVJjbHp2UmN1ZkdDV25URklPS0VGNzdVckc0ekxxKzJp?=
 =?utf-8?B?dmRhbG92cGhrTUxKYXlHa0ZOOGE1TFYza3VydnBoSW9QUXpkdWl6WlRQNVAx?=
 =?utf-8?B?QndlbTRka1ZKaDdrM1VuVjF1bnF5M1VEUDZIaGpiMG95aFBFT3JoZm0vMTJ1?=
 =?utf-8?B?NjBXbUEwVFFvSlRPbE8wL2d0MlN5T2hNSWdoeng2b01GRTFEdnpSWkwyQUpp?=
 =?utf-8?B?a3N2SGJaRTFHUUgrS3N1dVRlVmFzZnJKRWdIamsxVFpBRUtuQUQybGFqaFFi?=
 =?utf-8?B?dEhkYlpad1JmVS8rY1d0ckFFQWYyRm9ZZ0ZsbUxlVnVHTUNGY293R3FrU1I1?=
 =?utf-8?B?bDBiVW5lTnZkT3htQ2tONEFJbUpPaUJ5eVhDV2ZMUmJpMjduZGY3a2E2QjhB?=
 =?utf-8?B?SU42NHhzVmZnUmg4c0NxNXpNbzRoY2JmN0dYNjh4NjhlWjlERUUxN0Q4cTBG?=
 =?utf-8?B?YjlRQXFOVklEUm9VYjk3NmJUR1ZXRVlWQWovYlIwVzFuYUFZS0RuR1VnU1J5?=
 =?utf-8?B?YUt0VXI1T0FabXgwY2JvajRNeEtnNlhjRS83eWhnYkVvSnJycGlJN1VyTWs4?=
 =?utf-8?Q?xzNuYGL3nzS0sqTI5/dGVp0cekgtT4my?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QmNqU1F2dThPZzRnL01jdnVtZDRWbW5vSVFCd0h2blRPczFvTXRuS2dqb1l6?=
 =?utf-8?B?RlRMNzBEOThucVBmNGZqMVFtU2F2dTlsK29VYlpXeWJuZkJaSCttQTBZRjBX?=
 =?utf-8?B?OW1uV0JkM0VvOEIxSmc3Ry92V2crSXY4Y2hGYlg2ZFNNdXhyREhPV0hOTDZq?=
 =?utf-8?B?L0VrOTZkSHEyOFhhS0oweUtqbG9wS3l0TEVtaDRjNFo4am9SYlVmTGZJajNM?=
 =?utf-8?B?aGwxdWQ3M0tBQW1JVnpuQ3VCYkFqbzBZRUFTQ2NoUkpSam53TEEwdzhDOWlt?=
 =?utf-8?B?dEZoYk5CMHRtY3h5MytHbzJTMjNZY0hocGk5dW9KelRHZkxTbVVIdVhOSUlZ?=
 =?utf-8?B?aHpOWnJuZ3pHYkZhODNwYlNxanZVRU1nRU5kcW5pUm92bmxVSlBwM2d6L1Br?=
 =?utf-8?B?bjZjRzNJMUNVS0pRU1VJQ2cxNFJCRElCU0FUdWdRVXg4S1I1QVo3bVVoVTNK?=
 =?utf-8?B?Mk9wc2llaVJZc2pFKzZvOW51eVJBR1E5TkxpTGVDWk15S0hDaktucDRKTHNG?=
 =?utf-8?B?elJxYzk4VS9OWnB5RUNKbGlmRjFsZG03SmdJb2tEa1Brak5HWnZNMkkxUGVL?=
 =?utf-8?B?SlhweG9mMkNWNDcvam52Z0ExeUUvSFJBei9Gb096aXhMR1ppZ2FsaTZSeVJ1?=
 =?utf-8?B?WTdYc3dUN1VNOSs5Sk5jTWNQa3RnbTE1QXEvNXp5TERyWFViT1NVb1F5UlJX?=
 =?utf-8?B?aXlqbmlwY29BQ2NTNGV3eTk2ay9GZFB0Z0FPbnRIT29XMnlQQnJRUk9XTU5Q?=
 =?utf-8?B?Q3E1S2VEUWgzRTFNTE13Zm4zeWFBdEdqWE80cFYwZjROWDVvaWxXMlhWMm43?=
 =?utf-8?B?RFhKYXV1NDIzY0ZON214Rko3UExnWEZGL20zQTlZN2VqblN6VWdQMEFaN1Bz?=
 =?utf-8?B?OVdKQnltQ2J2YVNwNk1sRzVLYXZQUVFISTBBMU5Hb0ZCZ0pPRHppVzd3VzNN?=
 =?utf-8?B?a05lWTRiWnRKTXZHVWlqWFJLd1NPSS9uWGI2SWgyT1BtYmpIdUVzRFEzdmhB?=
 =?utf-8?B?UjVpLzFWVnVpRlFjbngvS0lGSWNGZFF6K1J5VVRabVdvZUZpdWR2b2pCT3BX?=
 =?utf-8?B?cmg2TldtUGZSM1RDRHBXWS9DU3NYWGV6b0ZnbnFPdzh3aTV3aVZvVGJjazNi?=
 =?utf-8?B?NXFIVGVQV1c5cGJUK0R3NkpnRXVWbk10bC9kNGxudThqRDB2VDBaRE1Md1E1?=
 =?utf-8?B?dUNBWko5aDJ1NmMxMGUrOHF5OVViT0YrTnJ0RWtvVVJmVnBxSU5YT1lHVHpY?=
 =?utf-8?B?Uk0zaUZXN1FmOFJOTXE5OVdPL0pQZGV0KzQ2YStIeUVJcEZ2Rmw4b3hoWEtZ?=
 =?utf-8?B?Zm9IYVE4SXpRdlhsd1JaOTFyWm1TOHAyMjZLQXAzLzB4U0ZNQnNDRHZsbit2?=
 =?utf-8?B?VXhDMnJGeTB2WUxmalVMcHZYR0NackxQczJWN0xCT1ZXNVpOTVhqUVNpM2pG?=
 =?utf-8?B?KzRMekFJb0h1NDl0VnhMU0UyVUc4UFJWTktUODl4K1AzaTRMeVZUMmJ6TS9w?=
 =?utf-8?B?QmgrNWsvTHVCdWUxS254ZWdCejBsRHhVMFl3eEFzTXdBKzRSam1kMFp4dXhK?=
 =?utf-8?B?Ulo3MXZpemh1bDVnTzhYNC9SejRZK3VCUncyazIrV1psUnR6ejVlSHJKbjA4?=
 =?utf-8?B?bmhmTm9Fclo1Y1FJdy9PQ05UM3FlbjNwa2tNZ01JamZYZ2NxcUJmZnBBMW9H?=
 =?utf-8?B?T2Q0UVZmdmhJeE1XUm9hWTQ0M3BtemRGUmxkUFhtVnVFVk5uK2YrbHQ2ZEl6?=
 =?utf-8?B?U1ViclFrR1QvcXcrTW90d0plcStzckQ2eDFMZmRJUG93WHRpOWZVcGo2V0I2?=
 =?utf-8?B?cm9ZV2NaSEkzaDQ3UUpwY2hQRmVGdEhESk9ZUzJrRkpIRk54REQ0Q2I0UGV2?=
 =?utf-8?B?S0oxdnFuaG5nMFRQSFhBWVZiYlRJY2JrVitnVU1MZWxSeDkweTRWbTlZVWxX?=
 =?utf-8?B?cS9uQksrMExyWkl4aGRRRHNnajVyNVdLYkd0NkI3bUVIVmduVW5FOUxuTU9i?=
 =?utf-8?B?d2N5RkNiTVVjUlBoM2svZ2x2SlNmbW1BR3JDd1p3cVVDdHRLSW1iSmxVYytL?=
 =?utf-8?B?WHI1ek13Z0RLbkZtMnFkYlpNWmI4MGdHYS8xNHVON0lvbUVncW5BRlJwYUhr?=
 =?utf-8?B?NWpzREhOQ01vRzhrcGFBTm5QYVVOcmhlZHlwaFlZTWh0MDlwdmk1K09EcmVh?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98CD335E156DAB4497B0EF13EC396421@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iM8DPrA3IaR/yxxULfEWatIWUfRSsqlNHspBaPnYNvW33YW+hW0hDjqt1IAwIV9dhamYvxFhr5PnuAgML94RiLXprwD2UFRXu04QFwp8BHNyYP6zt+OiJveX45pM77ozjcOKSBcS0PLJVSjNSTesypGlvdAIL380RSFX294xrd6BQU8dH6iWfzKunH8sG/NlnsRkykJdOCo5rMzZvcq+8bb5kFSaOkpOJ84h9Q8EN+w4pdpG0c53aqsvGekQejXu3Lj204z37onfYq/4y/TR3OY7ScqlePzxXa9VYgl4s9FfAgtfiVakOd4ICeZJLTaKb6Lii/pfTBYG21wIK6wTlUX8dk8mr1CM/k9WtyGaBL8hbPcQICLGSm73gs3S47O3w9kb1fkFBwJLbptO1GaIMFQXRE58+ARDyc186imkEIWU/D0X7XQMerQ8AIOqgKdJgxCbD2IS/0tXj+bxPf7g9S/M02MGi0g1wQB6OeI0zXt4sulTaGGEmsDRmmRl9z0T+lsJUmrPCQ5i9Hij10+GaeUrytN8vLLriVEi/GGVEYwNasj1Ub8le3bH1TlQYK1k8EPU6IF7NVb7tQI7/lrj2IbcNwc7ewjrywqxyGf1QXI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 808cafad-d8e1-44e2-429b-08dd6896a37b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 16:37:15.3225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7294K4I5L1BdzaB42v4WDYkRAMeDoJ02azkLQVeGVS0pmwtWHNTKEWNaXa1b+UERgcBjl0GOJT+uK6icGwGiFMXiixELeWcFaCtjE7JIIGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5013
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503210121
X-Proofpoint-ORIG-GUID: pZdxIfP-ALA0OrGLbD36LiaF6cafYy-f
X-Proofpoint-GUID: pZdxIfP-ALA0OrGLbD36LiaF6cafYy-f

DQoNCj4gT24gTWFyIDIwLCAyMDI1LCBhdCAzOjM24oCvUE0sIFBhdWwgTW9vcmUgPHBhdWxAcGF1
bC1tb29yZS5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBNYXIgMjAsIDIwMjUgYXQgMTI6Mjni
gK9QTSBFcmljIFNub3diZXJnIDxlcmljLnNub3diZXJnQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4+
IE9uIE1hciA2LCAyMDI1LCBhdCA3OjQ24oCvUE0sIFBhdWwgTW9vcmUgPHBhdWxAcGF1bC1tb29y
ZS5jb20+IHdyb3RlOg0KPj4+IE9uIE1hcmNoIDYsIDIwMjUgNToyOTozNiBQTSBFcmljIFNub3di
ZXJnIDxlcmljLnNub3diZXJnQG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4gLi4uDQo+IA0KPj4+
PiBEb2VzIHRoaXMgbWVhbiBNaWNyb3NvZnQgd2lsbCBiZWdpbiBzaWduaW5nIHNoaW1zIGluIHRo
ZSBmdXR1cmUgd2l0aG91dA0KPj4+PiB0aGUgbG9ja2Rvd24gcmVxdWlyZW1lbnQ/DQo+Pj4gDQo+
Pj4gVGhhdCdzIG5vdCBhIHF1ZXN0aW9uIEkgY2FuIGFuc3dlciwgeW91J2xsIG5lZWQgdG8gZGlz
Y3VzcyB0aGF0IHdpdGggdGhlIFVFRkkgU0IgcGVvcGxlLg0KPj4gDQo+PiBCYXNlZCBvbiB5b3Vy
IHByZXZpb3VzIGxvY2tkb3duIGNvbW1lbnRzLCBJIHRob3VnaHQgeW91IG1pZ2h0IGhhdmUNCj4+
IHNvbWUgbmV3IGluZm9ybWF0aW9uLiAgSGF2aW5nIGxvY2tkb3duIGVuZm9yY2VtZW50IGhhcyBh
bHdheXMgYmVlbg0KPj4gYSByZXF1aXJlbWVudCB0byBnZXQgYSBzaGltIHNpZ25lZCBieSBNaWNy
b3NvZnQuDQoNCi4uLg0KDQo+IA0KPj4gVGhlIGFsdGVybmF0aXZlICJ1c2FnZS1vcmllbnRlZCBr
ZXlyaW5nIiBhcHByb2FjaCB5b3UndmUgc3VnZ2VzdGVkDQo+PiB3b3VsZG4ndCBhbGlnbiB3aXRo
IHRoZSB0aHJlYXQgbW9kZWwgdGhhdCBsb2NrZG93biBhaW1zIHRvIGFjaGlldmUuDQo+IA0KPiBU
aGF0J3MgYSBMb2NrZG93biBwcm9ibGVtLCBvciBtb3JlIHNwZWNpZmljYWxseSBhIHByb2JsZW0g
Zm9yIHRoZQ0KPiBwZW9wbGUgd2hvIGFyZSBmcmVlbG9hZGluZyBvbiB0aGUgTG9ja2Rvd24gTFNN
IGFuZCBleHBlY3RpbmcgaXQgdG8gYmUNCj4gbWFpbnRhaW5lZCB3aXRob3V0IGNvbnRyaWJ1dGlu
ZyBhbnl0aGluZyBtZWFuaW5nZnVsLg0KDQpUaGVyZSBhcmUgcGFzdCBleGFtcGxlcyBvZiBwcmV2
aW91cyBjb250cmlidXRpb25zLCBidXQgdGhleSBkb24ndCBzZWVtIHRvIA0KZ28gYW55d2hlcmU6
DQoNCmh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIzLzUvMjYvMTA1Nw0KDQpXaGljaCBjYXVzZXMg
dXMgdG8gY2FycnkgcGF0Y2hlcyBsaWtlIHRoaXMgZG93bnN0cmVhbS4NCg0KPiANCj4+IFdpdGgg
Q2xhdmlzLCBJIGF0dGVtcHRlZCB0byBkZXZlbG9wDQo+PiBhbiBhcHByb2FjaCB0aGF0IHdvdWxk
IG1lZXQgdGhlIGxvY2tkb3duIHRocmVhdCBtb2RlbCByZXF1aXJlbWVudHMNCj4+IHdoaWxlIGFs
bG93aW5nIHRoZSBlbmQgdXNlciB0byBjb250cm9sIGtleSB1c2FnZSBhcyB0aGV5IGRlZW0gZml0
Lg0KPiANCj4gQXMgbWVudGlvbmVkIHByZXZpb3VzbHksIHRoZSBkZXNpZ24vaW1wbGVtZW50YXRp
b24gY2hvaWNlcyB5b3UgbWFkZQ0KPiBmb3IgQ2xhdmlzIG1lYW5zIGl0IGlzIGJldHRlciBzdWl0
ZWQgZm9yIGluY2x1c2lvbiBpbiB0aGUga2V5DQo+IHN1YnN5c3RlbSBhbmQgbm90IGFzIGEgc3Rh
bmRhbG9uZSBMU00uICBJZiB5b3Ugd2FudGVkIHRvDQo+IHJlZGVzaWduL3Jld29yayBDbGF2aXMg
dG8gc3RpY2sgdG8gdGhlIHRyYWRpdGlvbmFsIExTTSBzZWN1cml0eSBibG9icw0KPiBwZXJoYXBz
IHRoYXQgaXMgc29tZXRoaW5nIHdlIGNvdWxkIGNvbnNpZGVyIGFzIGEgTFNNLCBidXQgaXQncw0K
PiBwcm9iYWJseSB3b3J0aCBzZWVpbmcgaWYgRGF2aWQgYW5kIEphcmtrbyBoYXZlIGFueSBpbnRl
cmVzdCBpbg0KPiBpbmNsdWRpbmcgQ2xhdmlzIGZ1bmN0aW9uYWxpdHkgaW4gdGhlIGtleSBzdWJz
eXN0ZW0gZmlyc3QuDQoNClRoZSBkaXJlY3Rpb24gb2YgY3JlYXRpbmcgYSBuZXcgTFNNIHdhcyBi
YXNlZCBvbiB0aGlzIGRpc2N1c3Npb246DQoNCmh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIzLzEw
LzUvMzEyDQoNCkEgbG90IG9mIHRpbWUgY291bGQgaGF2ZSBiZWVuIHNhdmVkIGhhZCB5b3VyIGNv
bmNlcm5zIGJlZW4gDQp2b2ljZWQgaW4gZWl0aGVyIHRoZSBmaXJzdCBvciBzZWNvbmQgcm91bmQu
ICBJZiBEYXZpZCBvciBKYXJra28gYXJlIA0KaW50ZXJlc3RlZCBpbiBhIG5vbiBMU00gdmVyc2lv
biwgSSBjYW4gd29yayBvbiB0aGF0LiAgDQoNCg==

