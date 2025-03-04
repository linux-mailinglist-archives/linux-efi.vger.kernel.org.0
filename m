Return-Path: <linux-efi+bounces-2876-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A56A4E1EC
	for <lists+linux-efi@lfdr.de>; Tue,  4 Mar 2025 15:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95FA717F717
	for <lists+linux-efi@lfdr.de>; Tue,  4 Mar 2025 14:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345AE27703F;
	Tue,  4 Mar 2025 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V6YlQNqF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G41M9DNM"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F72277028;
	Tue,  4 Mar 2025 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099649; cv=fail; b=FK9H+JHYYOTWty1mTi6MHyy6Z5tOGxGNx0Q+GcRPu9xJ9j4upN7OMwP9zAgeM9gY0oSEpzM9iWPXUtjcw5PFKD2mX/+fWYP9G11FqW2nqRpye5ZwEFOsS3UX6bqb+E3usWl8S8j/NL0cIS75RkElNiLwnoUDmfgfPM8ZIE3LfX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099649; c=relaxed/simple;
	bh=qm/foSSClkvlnDTX/ZzOPLLBmduSSQEuQpzMQ9iUyss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GB63e2WV7jyP1otl41CrlroMrrUmfR5LttSXmRzoEvS6Jtbv4vqbG8sX0y6ahxKeYsJGRx6n/uIeTrU58qtN2vIC+s/dLE1/rEhb4Km3MDQhBYjOiwFlAQatvZRygSZoiZcHG1FGTyO5/90OohnRW+Xa65aNKoLGlGdeWtPQchg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V6YlQNqF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G41M9DNM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524Caog6023826;
	Tue, 4 Mar 2025 14:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=qm/foSSClkvlnDTX/ZzOPLLBmduSSQEuQpzMQ9iUyss=; b=
	V6YlQNqFZgBuq6WXjOKSJHaodNQEz1o2VJc3Qq4vCDes6obHqWpoCLEGKYOwMgSw
	QckA4Y5m/QL28C9ZqODPOLDdPV1jf11iSNL+e+YaraGHk0xQaAmzI9pHQLMB+aRV
	bTBIKY6u8ywGLdR2hdMxu7DyfouATSdWbzT5o4Rkcf3SLVTTO1EI36GkQFYv/t+E
	LI/fx1X3AP4D5bAlpRE089ob5igClyqYoVMlg/hWX10nsKUqZJF3x2bWK6VjFP1j
	ozifxUbQBtACw0zBgXVqPr83CP1tWhnySLahpbUZGEdGIXBdLSi8gK+1gbI/eCGE
	AcDBULwA9IHamcxMb+HdzA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub75att-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 14:46:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 524EAwvm010979;
	Tue, 4 Mar 2025 14:46:35 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpajv8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 14:46:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgkxNzk2NsQobjdO++zWOs7RwZYUPcsuEKpiUZ9RUT1udTRxabTL7oLa66YVPQ0u+JL1ikiWCBWVmpLZpr8+/PJxHJYLvpdFKBRqlUK/xKbFbYBS3V/Ao+L46lm7jkW7mE/oMbtUVkrf8fFiaghfYLJRHDanRIbRHnpvboZKyptM3vAX+FJiUOtpCSBL1Byq+5JqiPe7xGSaREw3nwQwA3WRJjGLNVDJjlY0LKi8uSv60EdMUa7GFBtXphAYeQhCAdYyl/lTGLnPtKIS+VmwaSSqdEkTFa04JGPqoN1KrbNPB/qoALZtrf/NUU7wfUfuNC4Mp7ie0KjtIgMchnSpgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qm/foSSClkvlnDTX/ZzOPLLBmduSSQEuQpzMQ9iUyss=;
 b=qb0fU3uBECkTkfaeWJqp0AZGL30kYJgvpRUyUqebylFzq6fHt/sDISP7V17mfypQ+1ZMossVKvbtlieU8xwCGRhFDXe9xPNw7eK0v6+CK5CCbQyICnJFArP3J3LvSyUVCSAifgSKnyaGx4CyPC15Slno9mfOrhMiW3DvUmn7QPjEQdU70VNR2Mr75K2kkmUiKpAXzN0BTJ2TuBgX1xNYFdTl9IwusijEjH9RiH4gO+u4+FjcRL0rXoFTM9lm/8/6yy6+Bn+0prZ17y4bNQRUnTibE3tiwwON52rvHderArXLhftpWdvpHIYH+Ga/H5GVlIjx7m52n2B1qhnspZgphg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qm/foSSClkvlnDTX/ZzOPLLBmduSSQEuQpzMQ9iUyss=;
 b=G41M9DNM6kXX5YGUJlN5TyFCL/FHCOAD6jdaq4/ZyI14xNpzqUT8l70NZUFBoNTkso4S0eQ0DfdaDNYNFR8gkSDk/qzbDWIzw4TQcf6aPhX6woE5YpzwPdkGuxrwfSz2SOWnr5QaBy8X/DPP/YcYgULWP+fCQySfKZb07jR1SRE=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by CYXPR10MB7975.namprd10.prod.outlook.com (2603:10b6:930:d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 14:46:33 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 14:46:32 +0000
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
 AQHbIK0E/vdc4Eou30K4SgPRfeDFerL0Jc4AgBIDLwCAAF1+gIADEbkAgADjnYCAUfK8AIAAHD0AgAEIXICAACNLAIAAGwsAgAUHzgCAAQ2/gA==
Date: Tue, 4 Mar 2025 14:46:32 +0000
Message-ID: <73B78CE7-1BB8-4065-9EBA-FB69E327725E@oracle.com>
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
In-Reply-To:
 <CAHC9VhR961uTFueovLXXaOf-3ZAnvQCWOTfw-wCRuAKOKPAOKw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|CYXPR10MB7975:EE_
x-ms-office365-filtering-correlation-id: 174b17bd-9efd-4e33-4991-08dd5b2b5b2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SjQrdXlFc3VvSFhxMnRiYjJXbWZWdlYrRjd4ZVBBUWliZzNiYmc5R3RvNEpU?=
 =?utf-8?B?RGNLUmljUFBlZkthaGprRUM3VGM5ZlNWSlZsZGI2QVp3WlBOakQ2a0c0OWt0?=
 =?utf-8?B?N0Q2QXk3OUpUWS9hMEZBNUVBTThxSVAvZVJjUEljbkhnYyt2dkJmU0EyMU81?=
 =?utf-8?B?N2ZRTHFlN29zVzkvanVUZHNIalp6OHRBNjlTY01DaDdWRFNaQmN0VWdmQjNJ?=
 =?utf-8?B?ZHo2M0xLVUZQb21YTXIydFFQaGtKM0RuMitzNzQzaUZNTjlRUnBQTEpGOUZQ?=
 =?utf-8?B?VlY0RkdQeWdqNm44RU1oUlMwN3AwWVRIUmxrOVNwTW1lOUV0VFhyMkNYQ2wx?=
 =?utf-8?B?KzBpcUw1cEF5V3ZCOWJnaWs4NWFvU2QxRlZxdkYvVThUV1g0MGVITEN3ZEhq?=
 =?utf-8?B?bzNXeXBlZmFyNWhqb2QxMTVwUlRkNUFkbEJBbjF3bnJETWtPUVl6cVBOQzBF?=
 =?utf-8?B?ZTFON05ISU9POFI4ZXFPbFNCUjE5aUMxQVh1TTVpTUEyMDdZclZBQndseFo4?=
 =?utf-8?B?eXdCOXlhdXJsdUNiTXM0dUJlQUNsSXBEL0VRQlJwVVNvOVFCUG9hSW1HLzg2?=
 =?utf-8?B?NlAyTGZTWVVUZm1UcGRqa2VSVnlHbHNPRkhMcm5QRHNCSXdicGc4YlBiYUVo?=
 =?utf-8?B?VWRwZFhld29kK05temdyUEtZNmw3WEpkcjdVcUw5b08vMVI5TDlEM2M1S3hZ?=
 =?utf-8?B?Y3pyaHJ2T093TXpKY3N4U05vZmRteGFFMk41eExhbWlqalcrU2J0K1hpK2Fx?=
 =?utf-8?B?eHk4cmZ5aUp5ZkZENitKblpYNWY1ckZnbjR2bngxUFJCeUo1R3V4aWpuMy9X?=
 =?utf-8?B?MHhqb1pVVWlHeSs1bWgyTHRNK3ZPL3ptQ2ZnMnArMHNTNkxWMzFTMkxOR2du?=
 =?utf-8?B?OXNWd0MxajVLUlN3T3ExQWdGbm9xK1c5VmZGLzFEQU5ibW9zcXY1bitaYlZs?=
 =?utf-8?B?d1ZJcm9zL08rLzhLdExjZ2poYWx5QU9FamVGdTRQOU1EWGs2S3QwKzk3ZWZ2?=
 =?utf-8?B?Y0Q1elJ0cG1MTThEREo1VURVVEd6cDVJZjNDRUlCbTJwWFhOajBRV01HUkZP?=
 =?utf-8?B?a3Vud1kyM1Jwc0lRbzVXWHJteUk5eWZuMCsyOURXR3RHMS9kS00ySTFvcmNp?=
 =?utf-8?B?U21vcDlNRm1aT24xQUFvWlRTenprQ2lsTE45NWFmRmN4aFRaMEpuU2JNN2hs?=
 =?utf-8?B?SnJjODZRK1dkeERsVng5TGdNVDdObGtKV1gxcnY0bmh4NmxQTmJHN1lWWktx?=
 =?utf-8?B?cE1mMkdYR3BsS25CV0xBZ1NVUjY5UTZ0Zi9sMytGdEhMN0d2cHlORjFPZEtR?=
 =?utf-8?B?YXhhU1lwSjFRanZGZUVkcGlnWDBCTlRGa1VHRlpiNFVCOWJ6cU1jMFBnM3Rl?=
 =?utf-8?B?ODRTdGZ3ckNkZFZIT2lWWjBnaXFJMStYNDF5cUFoRmE3UysyUUtJcEMwNVhM?=
 =?utf-8?B?Mk1xK2RFZ2xRcmNjelVNTGI0YWNtd2RtMGpZNHExTlVUQlhrd3YrTFI5WmNJ?=
 =?utf-8?B?UWhXS1Rla3ZqS2ZrZWNGRmNjN3FjUHpINkZLVHZjc0tObDBMcVJadnZWTnZB?=
 =?utf-8?B?MG93T0hMZnRVRWNweHU5Z1cvRTJONGcvMkxJNTdxWjhEVnkwUUFINFdkTEZP?=
 =?utf-8?B?aFVhcHd3M21PL0VVbHEzNUJDdWhxVXdvTFA0RWd3TXpsVG9VM0ZncXFNVVVs?=
 =?utf-8?B?Q0RUT1pBRnYycG40K2lQNlhNa0ZDc3pZbkU2eVF1WXp6RWJPekJQU0U3SktE?=
 =?utf-8?B?R3czMW16WlUwRFBXV3hNWEsvOE9iTGR2dVF0RUkrNXBZYzVvSXlTUXhCWlNL?=
 =?utf-8?B?MnN4Q1RncXVZK204Y1p6aEc3TDY3QThUaHZJR2dzWlhrMis4bnpta3lpRm9P?=
 =?utf-8?B?aGV1aTd6b1dnbXQzV2lLVGhmOVR2ejc4a0t0cGlKWVQ4UHJmcHREYXBWRFRx?=
 =?utf-8?Q?rY9Awb1Uq+YOPqthuDKT5rRGgPLLQYYP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUxzTmZaU2lrYjBkUjNLVGJBanEyRVhHTjRyOW8rMHU2b1VZWGw5bThRV1ht?=
 =?utf-8?B?b29WcjFIZ1Z2QUVxeVR1RW1DaEl6UXJLT1J3SndQMXMzTzc5T3pDUWVGSEo1?=
 =?utf-8?B?S0VFRlQ5QitqQlE0VWJickhkSmEzQmxIeFRqYW5Qdi91SWU0eG1zaHhxcTg5?=
 =?utf-8?B?NWdMekhQV2daZlBNOThVT1lhWnRxU0d2NWtvaFNKNXkrMUsyOElySFhzVkhH?=
 =?utf-8?B?VGRReFpBbG42dUlsT092eFRNTjBCaCtyNHkxZmtaQUlhY2d5ZnRvREZ0dDNr?=
 =?utf-8?B?ZTVFL0F6UXZpbnM3MlJVUzdSR3hRTkNJZ2tsQVA4NE9iNVROMHgzYjlaMXdo?=
 =?utf-8?B?WTN0MFhnYlZ1Y3dwajlCa3ZWZ2hELzFqSUdySUxQQ3B0Z0daK3ljRTdFYUNH?=
 =?utf-8?B?djU2akRva2o4eklEZFdEMjBPbjBnUnJVWXIrYmpnT0xBUzhBc0lIVStGVzhm?=
 =?utf-8?B?WjlNRC8vL3U2dzQ5RzU4RWRuVGRtaXNKSnZsOU5jYXRzL0swUUlSb0ZTWkVq?=
 =?utf-8?B?ZnByTzdFbnN4blFuZUFYMEk4ZFEzdkdQb1hreU1Bbks4anp2Vnd4T1Axc2NB?=
 =?utf-8?B?aXM4Z3NwcE81Vkx5RUVOMzQxdThJUDlsNWZCRlVERXhUMlhyVlBEOVgvak5i?=
 =?utf-8?B?V0d2R0V2RHUyYng0NFcyenZMQjV2V042VUJvZ0NMdURHK2taRHBkN0g1azVo?=
 =?utf-8?B?SWZ0VW1kdWxNSFZIRXdWZjNtME9hdzVQWXpDaGRlMG43UGhyUjVqWXBIZGMz?=
 =?utf-8?B?cHYvalBOQlhDU2g0VTNSeGJYWldjUWppVjczM0JKWDVRRXIyMnhDQUVFUUFV?=
 =?utf-8?B?TC8wSUR3M1cveGprWWlxSnpsWmxXNVFNTVZkT1ltaklrVlA2WUorSDJ5WUk0?=
 =?utf-8?B?dzlVM2lQY1VsQlNzYmdGVlhtMXVOUnczeFlCbUx6YnFNa3FwMDVpbG9paDNS?=
 =?utf-8?B?OFYxbm9zK0QrNyttNUNVczMvQlVRNElhZktmRGord3pmdndQcUUrRWd1OEpj?=
 =?utf-8?B?Sm1qMi9Gc05XNTg2cDFXUkVIaytqbS96bmozRnV0dHdmNE9GWTQ4OU1oSU1v?=
 =?utf-8?B?YWxxc29VS3dteTE3N3krdXhJNXBlbFFMdC8zWGJPQm4rQmN5ZDJTUXNHYlJ6?=
 =?utf-8?B?UFYraFgyUmxuOTFKV1RKWDRVNEFoaUQ2cFM3NEhSNmJVMUdhaGVON1JSbWpa?=
 =?utf-8?B?bndWVU9VL0RCc3YwNWpudUl3aG1CN2lDNmREaVlwNm44ekhJZFhtUUJKQXJ5?=
 =?utf-8?B?Z1p1ZVJFNjBqOTRtbGxXWmlBSGVVOXM5LzRaaDNCVnRWM1FpRWRsY1d0Tk5N?=
 =?utf-8?B?ZDRZNTBKQ1VJNTFsckRZQndDdkc3THdCbXY0b09Wd0Z2NTFxYnd2dTNQVm03?=
 =?utf-8?B?MTdSLzd4VHdmQmthaEZmWkMwVXVqb1puTkJXRHp2V0RNcXlQc0hEYTNCUmNj?=
 =?utf-8?B?YnpkSVZkb2hsZ1dlaGFWT3ZsQnhiZWREVEdrOGJQbGZFeDZtQ0JCaXhqRVVM?=
 =?utf-8?B?cGl0WW1SczJlaDIwOHR5a2pBSmxsYVRnSGVmWW9yZTBDbjVCclBSVXJ4bE13?=
 =?utf-8?B?U1pBMUsxMnJiUGFBS1VwT2tEcGNTWE1udk9tOGtCVU9ieVRyVG5SbS9Mdm0v?=
 =?utf-8?B?RjBySnRydkFCYzBxdGg1eWpwUHNUV0srRHM2azNjVE8xVTZiMXQxVURBb2dK?=
 =?utf-8?B?dnFHUWErRlk1NTJnT0xIQ1dUb3BrTllNSUpwN3dJbWtESXZwNk1oMi9MYUlR?=
 =?utf-8?B?K0NWVXFrNUp6YVNocG52N1RVS1pGTkVqN0ZPc3Y0WDhMQlJxSVpySjlhTmxL?=
 =?utf-8?B?TnYvNHBpdHJrckxBS0laa0FrTjJ4UnRKTE9CQkJQejlyNDhhZWNCWkREWEdr?=
 =?utf-8?B?V1g0b0t6aWo1aUl6ZkFoeXpRMGVzWG9LTTdSbkIwbnpjWDRLZzVGTWJyTVgr?=
 =?utf-8?B?UHhDbkJpMVZGelpkSTN5MGp4VGY0QlFiWWdocmxVbFYrQkJOU3YrK0p1QURw?=
 =?utf-8?B?d0ZJdjgxckc5c0cyNFlsRUtYYjdETFUrbFYwTHBYRGRxa29iRVNIZzJEWTFJ?=
 =?utf-8?B?bjltbW9iNFVUL2xGUm81R2tEL1ZvcEE4a09KUzJweDhOR0xUNkxpWlNuMlh4?=
 =?utf-8?B?QURPM3BrcU11M01IZnppRTcrb0E2UXRYbGhyUGVsQlNZL1h1Z0NtV0JEdWc0?=
 =?utf-8?B?M2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF7D8D7AE38FDF4D942A5BD9C0984EF4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3xoqKyq49NKPQatikkWuMFq/sWnRPpzGIGVgtj2UpyFWublD/MwKNNR/K7IMuiOPdWKIvjwJ3jihWFkzILzZKOq/nahKdPvmg2qME+R84X3vvnfyVrYF/1VovIEfex/itCmgmsda9wX82WbH38oZT8UWWOh8kNfbACgXx5KOhLk1cgQNaJRJ2ih1MhNIjrUxZtd+1a8Ino06kr/A9BvmLt9W8K+w9wdeg1jkvM4kPLP/dIm4b7rqaXQrcbUkneHOTjmrNQfVWsFdCUW86oNrTb9frp1Y4+HnAX9k8VSKa88J6H/XHLtbNosppi3MBHe9TDLbIub4vdn+pX/uOAVVRWg06RStKrL2vLZxRxm5BN3VjBRWdgA8pNMJvr4r4UDCOTsj65OyKGSTqIx5H96jnp0pG64M8dZtPU3phcv/jaXEwVLqumjS5fMlk1/JUv383HtseDe9lSojKNTLoHqVLKXHfuy9hGzsOTpmTDosZ2NW4WL8XfCtDSrykKBBWa7ygiji2CC+dHA6HOia/R4XxbyTG6SSRhSv/aR6S54aqMeLBrgEro2+c7QocUlxFVz4rYgkfxvUP3riNQ/kzDMJabReWOPY/92niHfdHFkADuM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174b17bd-9efd-4e33-4991-08dd5b2b5b2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 14:46:32.7549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hqimcZQTfOynCDnjinMSoi+JUcMpqt2xobxA/U7himVXoBxSZHSpwaeNNjMn5Gk8u2BT5cM4xCRoEkEXvCbKlp1Z5uh0+jZuYWYrD2B5dGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7975
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_06,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503040120
X-Proofpoint-GUID: Xsov6567dhuZDUk3n64mHQa0PF700Ddw
X-Proofpoint-ORIG-GUID: Xsov6567dhuZDUk3n64mHQa0PF700Ddw

DQoNCj4gT24gTWFyIDMsIDIwMjUsIGF0IDM6NDDigK9QTSwgUGF1bCBNb29yZSA8cGF1bEBwYXVs
LW1vb3JlLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIEZlYiAyOCwgMjAyNSBhdCAxMjo1MuKA
r1BNIEVyaWMgU25vd2JlcmcgPGVyaWMuc25vd2JlcmdAb3JhY2xlLmNvbT4gd3JvdGU6DQo+Pj4g
T24gRmViIDI4LCAyMDI1LCBhdCA5OjE04oCvQU0sIFBhdWwgTW9vcmUgPHBhdWxAcGF1bC1tb29y
ZS5jb20+IHdyb3RlOg0KPj4+IE9uIEZyaSwgRmViIDI4LCAyMDI1IGF0IDk6MDnigK9BTSBNaW1p
IFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3cm90ZToNCj4+Pj4gT24gVGh1LCAyMDI1LTAy
LTI3IGF0IDE3OjIyIC0wNTAwLCBQYXVsIE1vb3JlIHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBJJ2Qg
c3RpbGwgYWxzbyBsaWtlIHRvIHNlZSBzb21lIGRpc2N1c3Npb24gYWJvdXQgbW92aW5nIHRvd2Fy
ZHMgdGhlDQo+Pj4+PiBhZGRpdGlvbiBvZiBrZXlyaW5ncyBvcmllbnRlZCB0b3dhcmRzIHVzYWdl
IGluc3RlYWQgb2YgbGltaXRpbmcNCj4+Pj4+IG91cnNlbHZlcyB0byBrZXlyaW5ncyB0aGF0IGFy
ZSBvcmllbnRlZCBvbiB0aGUgc291cmNlIG9mIHRoZSBrZXlzLg0KPj4+Pj4gUGVyaGFwcyBJJ20g
bWlzc2luZyBzb21lIGltcG9ydGFudCBkZXRhaWwgd2hpY2ggbWFrZXMgdGhpcw0KPj4+Pj4gaW1w
cmFjdGljYWwsIGJ1dCBpdCBzZWVtcyBsaWtlIGFuIG9idmlvdXMgaW1wcm92ZW1lbnQgdG8gbWUg
YW5kIHdvdWxkDQo+Pj4+PiBnbyBhIGxvbmcgd2F5IHRvd2FyZHMgc29sdmluZyBzb21lIG9mIHRo
ZSBwcm9ibGVtcyB0aGF0IHdlIHR5cGljYWxseQ0KPj4+Pj4gc2VlIHdpdGgga2VybmVsIGtleXMu
DQo+PiANCj4+IFRoZSBpbnRlbnQgaXMgbm90IHRvIGxpbWl0IG91cnNlbHZlcyB0byB0aGUgc291
cmNlIG9mIHRoZSBrZXkuICBUaGUgbWFpbg0KPj4gcG9pbnQgb2YgQ2xhdmlzIGlzIHRvIGFsbG93
IHRoZSBlbmQtdXNlciB0byBkZXRlcm1pbmUgd2hhdCBrZXJuZWwga2V5cw0KPj4gdGhleSB3YW50
IHRvIHRydXN0IGFuZCBmb3Igd2hhdCBwdXJwb3NlLCBpcnJlc3BlY3RpdmUgb2YgdGhlIG9yaWdp
bmF0aW5nDQo+PiBzb3VyY2UgKC5idWlsdGluX3RydXN0ZWQsIC5zZWNvbmRhcnksIC5tYWNoaW5l
LCBvciAucGxhdGZvcm0pLiBJZiB3ZSBjb3VsZA0KPj4gZ28gYmFjayBpbiB0aW1lLCBpbmRpdmlk
dWFsIGtleXJpbmdzIGNvdWxkIGJlIGNyZWF0ZWQgdGhhdCBhcmUgb3JpZW50ZWQNCj4+IHRvd2Fy
ZCB1c2FnZS4gICBUaGUgaWRlYSBmb3IgaW50cm9kdWNpbmcgQ2xhdmlzIGlzIHRvIGJyaWRnZSB3
aGF0IHdlDQo+PiBoYXZlIHRvZGF5IHdpdGgga2VybmVsIGtleXMgYW5kIGFsbG93IHRoZW0gdG8g
YmUgdXNhZ2UgYmFzZWQuDQo+IA0KPiBXaGlsZSBpdCBpcyB1bmxpa2VseSB0aGF0IHRoZSBjdXJy
ZW50IHdlbGwga25vd24ga2V5cmluZ3MgY291bGQgYmUNCj4gcmVtb3ZlZCwgSSBzZWUgbm8gcmVh
c29uIHdoeSBuZXcgdXNhZ2Ugb3JpZW50ZWQga2V5cmluZ3MgY291bGQgbm90IGJlDQo+IGludHJv
ZHVjZWQuICBXZSd2ZSBzZWVuIGZhciBtb3JlIHNpZ25pZmljYW50IHNoaWZ0cyBpbiB0aGUga2Vy
bmVsIG92ZXINCj4gdGhlIHllYXJzLg0KDQpDb3VsZCB5b3UgZnVydGhlciBjbGFyaWZ5IGhvdyBh
IHVzYWdlIG9yaWVudGVkIGtleXJpbmcgd291bGQgd29yaz8gIEZvciANCmV4YW1wbGUsIGlmIGEg
a2VybmVsIG1vZHVsZSBrZXlyaW5nIHdhcyBhZGRlZCwgaG93IHdvdWxkIHRoZSBlbmQtdXNlcg0K
YWRkIGtleXMgdG8gaXQgd2hpbGUgbWFpbnRhaW5pbmcgYSByb290IG9mIHRydXN0Pw0KDQo=

