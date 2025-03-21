Return-Path: <linux-efi+bounces-3069-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9940FA6C620
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 23:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81AEF7A6408
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 22:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908D01F4179;
	Fri, 21 Mar 2025 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MZZJJ0JN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S8Ff7sZt"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C249C1F152D;
	Fri, 21 Mar 2025 22:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742597818; cv=fail; b=lfnBo7S6OdZTcmkWA9cNCeOelFPhRwOoH3qVj9Wpdd6bUGA4MayrF8WrrY+5AS4jI5YT2OIjUvKHf2j08LvEVivErm3WUC63g7VvRwcG1EFAXlpiuEi/lut+48ZSZQXKYIWG6DVJInB+p7zrVBEASjlKjVd/iDTP8/QYn+zh8Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742597818; c=relaxed/simple;
	bh=x46+VivWV/nlnFz4glrbZAcPK5CxNMF1XQ0AXbj0JL0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qixIz0jl+pLlZK9l8vj23NIr2YO6RsOzYFIBRx6fVzTDMZDKMk7AEanWZlRPAj1pGhKl7Xwf00CjNRaMokoQ84Hv5bmf5B+/SuVOs4A4EjCVw9dsLq/9maI1eZwEeHhuoGgfhyQcSQLda2QGIv7wg/2dAKsvyMZwx6NHMkWn4SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MZZJJ0JN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S8Ff7sZt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LKftSG021299;
	Fri, 21 Mar 2025 22:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=x46+VivWV/nlnFz4glrbZAcPK5CxNMF1XQ0AXbj0JL0=; b=
	MZZJJ0JNyBnojvygUYbzr2PiTP50Cxn9gWgsP0w9sTzdBYiZy2oktjm9LU+Sg8+5
	604KbP5nkuiZzC1nPPcaWoMSSmxmAjfotzqVkplCT4et+XJj342M+Mn6qNdLS+wb
	c8bAUR+7WpWoJHycB6IKF1Y1vU1gYu9wdnEnYXcaYn1xgawuA3einYGaGAtd37wi
	iYVOzLyU8JexG+t2reBt2XpyldCRBZ7+KTNy9ZOoo4b488S637SATkqh2LtcMTuq
	KLUNyQScsZVyII9sut8iHWQEHD7cpHQX/2IO+1do+NBMlZ8XzxFuvAlFcLfQ4nEg
	IuLRr1980bAPCDQTeiyeNw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1n8shu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 22:56:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LMNQR6008892;
	Fri, 21 Mar 2025 22:56:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxm4q53q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 22:56:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rm5pXwekeLjid7oam/Rq7qmWSuMbouPxs92jORxFVAkRswy3Za1VepXp9RVDjNKyLchAEhsGitbJxJX0CRHIFeb/RodZSqOT9zrnZ/J7Vn6tZtIjBOZ7idxB2s4+pMIXEze61CtCqg8a5nMCH9DtQx+wRnSigE1f8I4OwX9wPK6dX6z2eX4Fd0NWc+9aRN9ki/0TFv9wcPPMhd3cNJ98HkIHblPidIkBZ4SfrjgYqJMkQsbRa+hroLlBfetnJKlxnEPXjIyhls31hAhEg1BfMyY36JPuKiXkFpQsV5WDUOGOmvruQj6XkUCr9xJ/9CEXXVeqbwiRO7dVeFEa6yjwgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x46+VivWV/nlnFz4glrbZAcPK5CxNMF1XQ0AXbj0JL0=;
 b=N20ee9AILEWs0RXZ/JPzM/oLCtnky8FZJG6oMUNVFBxi/D0ridt/ZkPlahDf3KsyQW+1sUKukhaNUM1jFQwF8SNCTZKyRgOxEzWd9DQBBA5jzFdZdF/8nv5dNgiv7zKo3gPLj/2E6HvKlh0lBgRKAEAPBpnSDfw+76N4VsJk50zcCenPWC1dV68ueHbTbQwBUE4YonRNbpvFF9039H6lS2mIM6wAbL/5R++h6mQlNfG7dcyZiTEKpzpRqBcYxgyW+JBFfKxzOBo+5wkFgopo4DwfmGUEAE4mW3E8yccWkRvwDOBRbeGsebBgQwisHXIU9iC69zaUg2D6uTYjvUgooA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x46+VivWV/nlnFz4glrbZAcPK5CxNMF1XQ0AXbj0JL0=;
 b=S8Ff7sZty843d9b4d/ENOMrR9nI5vFw5iDrCCEw2USnxE4mZM8NbDFXM9czREutUbkKB6gUfIN6HeK9FC91Ww2RPP8Gaeid/q1RLkyMt0zcN46DBYaZCU6rzkKGheFbFSJow/Z2c/E7CF7RytHhcw6zU2JhrAE4iV+/Ta3PK4Wg=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by BN0PR10MB5175.namprd10.prod.outlook.com (2603:10b6:408:115::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 22:56:17 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 22:56:17 +0000
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
 AQHbIK0E/vdc4Eou30K4SgPRfeDFerL0Jc4AgBIDLwCAAF1+gIADEbkAgADjnYCAUfK8AIAAHD0AgAEIXICAACNLAIAAGwsAgAUHzgCAAQ2/gIAAoSGAgAFh24CAAD5VgIABZIsAgABIHQCAFVKsgIAAV02AgAE+nwCAACclAIAAJ/WAgAAO6gCAAAvjAA==
Date: Fri, 21 Mar 2025 22:56:17 +0000
Message-ID: <E8FD1D0D-4A71-45C3-B74C-5224ACD7CED1@oracle.com>
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
 <4F901DC6-51DC-47A1-8D2A-D84DCD9D0C2D@oracle.com>
 <CAHC9VhT0y5AO0Yjy649PbsYnN+Xf3_pTJCegW1kPW7=GM9RypQ@mail.gmail.com>
In-Reply-To:
 <CAHC9VhT0y5AO0Yjy649PbsYnN+Xf3_pTJCegW1kPW7=GM9RypQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|BN0PR10MB5175:EE_
x-ms-office365-filtering-correlation-id: 91a9b4bd-1a84-443b-2941-08dd68cb96eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NkFmOXJkZTJBZ2pMZ3Roekp1b1RDVlFRQ1lhb25BWlVRTkROY0E0T2tldjIv?=
 =?utf-8?B?UzRiN3BOWFVjK3dzLzl5dzAxNGpaNWdlSVJ3OXE2V1paSnBxckZkcGVUekNM?=
 =?utf-8?B?VUh2MnpDMTVIRDludHNCMjVMbXA3VTA4bHkzbFFUR3VIWi8rMklHUVkvR0dx?=
 =?utf-8?B?TUtsNUtGU0JVWElha2F0VGxvbjZnOW1jZzkyUGw3Z1NoSjBjN0srY2dYY1JD?=
 =?utf-8?B?QXZlem5kUlQzc3MrRGNHTnl2bHY1NFEzbjVEcVJVdkdiNG1XWnFLNndRY0Q1?=
 =?utf-8?B?aGg1VVd6czloNmdJMk1BWVFrcjcrenFmSVBkc01aT2NzZlJ6TkJzdDRpcFRE?=
 =?utf-8?B?bStQYmwrRGJMNUR4UWIzdFhGd0Nlcm5RNkY1TXV3dFhJYVZRTGZRazRzUWFm?=
 =?utf-8?B?Y1dZT0RkZGxxRXh3ZGVPSXlMRC9OakMvd1VucW4rNGg0aVBFOEpFcTk2cDN0?=
 =?utf-8?B?QU9ia0cycGxOVWd3bjNONm5SRkhnQzJ3OGNpYlBSQlo2STFURDg4ZEwvOVFT?=
 =?utf-8?B?KzU5alRkWWVERy9tTk95L3BaVkRiY0NPdU5INThRbG9KR0o3VS9MM2dvR0Nr?=
 =?utf-8?B?U1FCL25NemlBdFczQVFpd1RmcWx3ZjNHVG1CUlRyTWhZWEZzOTJ0ZFMwZy95?=
 =?utf-8?B?c0F5TGJYUWJacUlhVnBOMTZoS2JjOW5kYjJVeC9HemtLYU9BbXZPYStrczR0?=
 =?utf-8?B?Uy9QOVVsdEpIUklFdXJ1d1p6MXd2eGZCWUtjc0dKb3dRdGh2VXFkcjE3cUlH?=
 =?utf-8?B?eDkvbWpCWk5vZVR6bTd5MUY3UUJTKzBydXlPR1lyN3R4eGpLVlJ0Z2lWUStq?=
 =?utf-8?B?bXBiQVZ2NnpocklUSXo5cnBVcGpScC95N0xFVmc0dUNXenVWSk5saHQxYUkx?=
 =?utf-8?B?dkpHWmRleEMybFhjdUJ3YzFJTHEwU3N5eU0zR1dBM3UwU2kzbUR1WVNhR1Vw?=
 =?utf-8?B?eFRGcGlKWk1jamRHZ3MxWDhrUGN1a09ML1ltektSRFdSNzBBaHYvSERXZFo2?=
 =?utf-8?B?OG83UUY1dlN6OUNwaHBsTXVSVy8wb1A1d3FIU3o2aEczQ296RVJQMlIyRVBl?=
 =?utf-8?B?bFVDMFRBSW5LQUNpU0dIc0Zua250ZjFEK0ZNWng0NzllUlVWRHc1MWkzSVBv?=
 =?utf-8?B?VmlWY3d2dXJ2cFFCY2lTWUxnQzYwekVmSzdINit2QkEveHhCSEdRa2ZWKzh5?=
 =?utf-8?B?Q0NqUzNFSzZxV3l0YXRzK0g5OFgzLzk0ZFhwMnhiWXd0RHkzaFNiVDVjTWVK?=
 =?utf-8?B?eG85cm1zbmt2cGdkYk45WGtKOTAyTmRhWHoyWnlVUjBGaVlKOXpya0lYRXBn?=
 =?utf-8?B?ZVoyMStuV0huMFhlcmFGL3NFNGlWREthUzVFdWQxVTVRdUpRV3JnbkJxWVNC?=
 =?utf-8?B?enlpR1p0d1FsaWR2VlVaVjlNQWpSVFc2WlJCTkREOVd3dTVwWWNiRFFrRWdo?=
 =?utf-8?B?YlFKSFI1VUpEYnlTWGFseExsdkpybW8zbjJ5aDFkLzVHSzVuRG9kYlErZXV5?=
 =?utf-8?B?bzNSMm5XaUVOV3ZOeFpVRzRuMDQ4YmNJUXZtRnBzV0xBZFNCRytDeUZjYjJE?=
 =?utf-8?B?amI5aEtpOWNwVG5hWWhJL0hUYWs4OWRGU0RwNU1KYmhQSllQWEhvNktFTzBO?=
 =?utf-8?B?Nk5YZk5qUkc3RXJPdTVDZi9IaTJoS1dpa0Fzc1FVSEpMejVjVnJtUyt5SHY3?=
 =?utf-8?B?Zk1qc1FiTWZoNE4rV1RYZzdheXZTYTgzbmx1K05USjVIcHFEUFo5TW5lUzZ3?=
 =?utf-8?B?RHpFUmVVdzdKSFZGNkRwcFYyTWJLZFFtKzlxY3ZwNlpIY2ZVQWhvUTYxdlk5?=
 =?utf-8?B?eGd3RHpDV0FmUXd0UGxXakJPdzltT3NsQm85VnVvTmQ4WWhhTUVGYmNBQUE2?=
 =?utf-8?B?VEtXSzRmaVRUMUxadHVFTWZ3TStVNjB2Rk1BWThaSi9XZXY4ZkM0dEJFdVZW?=
 =?utf-8?Q?BMLuMKXDaUaRxHpLzYSjWE4LUjkn95s2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MzFWa2p0ajB3RUhFaGt3L2oxc2FSeEJlempURlVxWUxFREh2WDRXRHl0WUJN?=
 =?utf-8?B?QnRiZlJSM1E0SFoxOG1mMHhDaXRpS0Y1ck9QeHJQUHR6a2dqdW9uVFFzbXJq?=
 =?utf-8?B?WFY5OXY2ZXpnYmM2T2wzMnhQbW4yVVYxZ0R5OVQ2bnQxaC9mRjJxWDNpKy9V?=
 =?utf-8?B?bTVDWDhXVS82WUNLb3EvYVBUWm9yM3VZZGtSdHRnK1hnNWtDcStGNE1lSkx2?=
 =?utf-8?B?Y1NGc1d3NElodzRrZnFZNXF5TFpLWUVaZ05Fa0ZhYVBZQjNaSVM5U3RiNHJm?=
 =?utf-8?B?cXBsdEVFT3BMakxCODFxQVF5cjA5eGtUclJFYk1NUWJvejN1T2VJOFFtSCtH?=
 =?utf-8?B?TjIzK0lrMUVlU0Y4ZnFWdjNPb0oydVA3VXQyNGw2OHd0anlaOEZGbGpWQ1Ny?=
 =?utf-8?B?Q0ZVMWtzWnUvQ1VrVWZPUytkbWRya0NjcXczTlB0REFCZDRvWjNvWnZpTGo2?=
 =?utf-8?B?bU1HTUZtcExJRm9NVCtZa0s4SXJ1YVFlS3JoOGY2OFprU2hsdjQweFplT1Zt?=
 =?utf-8?B?aStIRklpZHdHMG9lYlQwVndlNWc4V1N6L1hydWVPN0hFTllSQnRHb1RWeThj?=
 =?utf-8?B?NkJRRXA0TERONW5lSTVCTGp6QVY0ai9RbkRuKzMrQm9TUFBxLzAvV2pXZ0g5?=
 =?utf-8?B?LytsYnl0eFRJTmtCVnB0Zm1wVWRUM3ZDd2N2di9QY0krZU5ZdDE4VlhkS1FS?=
 =?utf-8?B?dy96eEdIcUZRS012VzRQblkyaHQvd2pVdGxockM4c1NScjRrZ0hHOWJvNkJZ?=
 =?utf-8?B?c2RxenZBd2JDWi9pMGhCNXZRYWh3QXlRSWRISjJYNlYweXY1YXVQZTFNYVZq?=
 =?utf-8?B?MkxzLzc4Y3lrckNZRzErZlN1RkFGREljWXRiSW0waXdIYnNRWTJVL2pleHl6?=
 =?utf-8?B?MmZmeHZJa3JiNTBxTDVrcGw3UndxVjI2TUFLeDZEVkFlVlJiM0Jxemp0T0F5?=
 =?utf-8?B?YytZUGRzNFk1WUgxNGExTnJLQzVXMkFueVhnbEJtcnpmVXRlOG93aWFoWlp5?=
 =?utf-8?B?OXVVNGFDVVI1OFR2endTejYvVmUxUHo3MFJZUWVUWVZuTG5jd1VyVGtqb0F4?=
 =?utf-8?B?QUUvYjk4cm5IbFk4NTFmSVFNQVh4TU9HTXBnTXBIWURyNDgzeU9CRWMwMVh2?=
 =?utf-8?B?TXRkUVV5TVFHQkY0ZTFMMGJkNHUwdW9xc2xkWGR3ZzhrWENKekNCbjA1UVZl?=
 =?utf-8?B?N05pOWkvbm9WdDZlYy9Ub2ZSemtlakkxSEtGUEliZXRERnkwY2JyWk81UDBV?=
 =?utf-8?B?Y0Z2VUlOSUgzWTI1aXlseGZEbjdUQnE1cDhyVUtlcjFIeG5qN01TOTFwblB3?=
 =?utf-8?B?bWIzdU4xeTV5NlBuOUhFejNyaGpSdnZzVHhBMlN1d1FPdlBLL0xVTTIzVytJ?=
 =?utf-8?B?WldSb2V5bjVaZTkzQ3RQVEsrSnRQNitnYWlZSjZvV0w2NGxQb2lIRisvTGlw?=
 =?utf-8?B?WXZRS2h1UUE5aXY3TWp6QkhIYVc1Z2o3ZXJnczE1VjJkbHRRM2oxT1NvSjFQ?=
 =?utf-8?B?Q2NWSjBJR1ZlTlUweGFzTldvbHRUZkdRRTdxSE1EYnJtNWpEZUxDalUyaFJy?=
 =?utf-8?B?UzBva2srSkc3UzdGd1dXcGNVaGU2N0lTSFRhMTI1aGJReEFJOGNOR2QzL1NC?=
 =?utf-8?B?Q2VHNDhoMHNpdUVLamhhSWhNdmpKa29wcG1UNWpzV1RtdHVnT0ovYkNTQ3dB?=
 =?utf-8?B?anErSjd1WTRBTTIvVE5yR3hpZlk1N3ZsSmk5b2tLZnBWT3hBV2FUeHNrOUw5?=
 =?utf-8?B?VjJwUzZXdjdac1kxOFNGNlZzSy9mc3BuUGo1a1hQTWEvRDFFRnRiK3VPQTVZ?=
 =?utf-8?B?T2FOaXJEZi8zT0FXMDZWSDhqVERITEdZYnRPT1RVd3ZGOGp4OEpnc3B0RDN4?=
 =?utf-8?B?VEc3RWZ6eVlvc01kQmZMakVJR2p6ZzNWQkE1WTJQRDlmbGw2bmppSENyWkY3?=
 =?utf-8?B?T1dtaHNadXd1YkRvUU9iL0dYb1YwSGFvUlpvdzdPWEg4L3JKei9Uc1lSbncx?=
 =?utf-8?B?dCt5cFBINU1Pay8vWlJ4RUxWNy9KUXlqTFN2UmI1QkdrdmJTeVRDVzBXVUJq?=
 =?utf-8?B?cngreWZKS280N3cvNjY4RStoMHZxMytBSU1FQVZEM0srbU5VekpSSUlPbnlv?=
 =?utf-8?B?NXV3Nm9GS00rdnk3M1dmdmN4MENyZlI3bHA0Zm44eW8rRjVhRHpHd1luaENL?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C901D699F2C0B2468863779556476649@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4/zZhhkZbHYJrtlGhACC4KbdfELL04pI8S9UgrZZHUBZqVQ36MdZRms2gtKinLLf0cxE5EcGwqBGnE6vSRgCygbXhPZDF689vwAOtKXNrjVzUaTO35qZyhsG5z4nggD1UGwCu6/08v1vvrbns2LtIN9JRlLuq/coQTTbLJIcSI1vhmzmSUK6pURwvxVZs3htHIVeslaJ4AmqbMipiS+9309smsXA75XCBJMDOMr6/l2/vSvF293x5B0YWxMC4oLkf7FE5qDR11RpzKb+XE7Bj2jOASzeQEJPmvuiOvsV950Y32hG3alJyVwTmhWdruz4Da+KX0PCNDYeWPKmzi2KeBZDw/0I2SQF2msuCZsN0u5zBwsDX2TbpW9bcIumNpljG/Qnq49yo6RNJ1OMUBGQVIB8EXuuYqRlaKC6lxEikPBeUtM7BX156vR+Ca0ReT8IkQw+sVHFdWt6NAAPw8BjQ+I+N5t39/1A9lRxq6CfJ5ILwrKJ6ZOy3UsSvgWlB3zqt2k0ymQsydnRo4wZAMyOkZW/jWRHnuInjOPEfpu2N9wa/FKB/IfTKv4EfKHIicBJeyX+F2cuM9AhgevB0SgNlT3msvU7XUW8vrEuaF9ad8U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a9b4bd-1a84-443b-2941-08dd68cb96eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 22:56:17.5573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4IjF2tUDHdCyv9p6ZcWleO3GBynWQIOKvcm4a0Aw8mLc5uaGFQ6xpS3qFJfBbAM7hkXiaYJhKpuldOHT5eoMggtZecOV3RRd0cNn10ss9hM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_08,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503210167
X-Proofpoint-ORIG-GUID: 4ErToT-N2iY9AaNiltRYIp3pGdbHoFfX
X-Proofpoint-GUID: 4ErToT-N2iY9AaNiltRYIp3pGdbHoFfX

DQoNCj4gT24gTWFyIDIxLCAyMDI1LCBhdCA0OjEz4oCvUE0sIFBhdWwgTW9vcmUgPHBhdWxAcGF1
bC1tb29yZS5jb20+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBNYXIgMjEsIDIwMjUgYXQgNToyMeKA
r1BNIEVyaWMgU25vd2JlcmcgPGVyaWMuc25vd2JlcmdAb3JhY2xlLmNvbT4gd3JvdGU6DQo+Pj4g
T24gTWFyIDIxLCAyMDI1LCBhdCAxMjo1N+KAr1BNLCBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9v
cmUuY29tPiB3cm90ZToNCj4+IC4uLg0KPj4+ICwgYnV0IEkgd2lsbCBub3RlIHRoYXQgSSBkb24n
dCByZWNhbGwgeW91IG9mZmVyaW5nIHRvIHN0ZXANCj4+PiB1cCBhbmQgbWFpbnRhaW4gTG9ja2Rv
d24gYW55d2hlcmUgaW4gdGhpcyB0aHJlYWQuDQo+PiANCj4+IEkgZGlkbid0IHJlYWxpemUgdGhh
dCB0cnlpbmcgdG8gY29udHJpYnV0ZSBhIG5ldyBMU00gYW5kIGJlaW5nIHdpbGxpbmcgdG8NCj4+
IGJlIHRoZSBtYWludGFpbmVyIG9mIGl0IGFsc28gaW52b2x2ZWQgc3RlcHBpbmcgdXAgdG8gbWFp
bnRhaW4gbG9ja2Rvd24uDQo+IA0KPiBJdCBkb2Vzbid0LCBidXQgeW91ciBjcml0aWNpc20gb2Yg
aG93IExvY2tkb3duIGlzIGJlaW5nIGhhbmRsZWQNCj4gZGVmaW5pdGVseSBmYWxscyBhIGJpdCBm
bGF0Lg0KDQpJIG1lcmVseSBwb2ludGVkIG91dCB0aGUgaW5hY2N1cmFjeSBvZiB5b3VyIGFzc2Vy
dGlvbiB0aGF0IHBlb3BsZSBhcmUgZnJlZWxvYWRpbmcgDQpvZmYgaXQgYW5kIG5vdCBjb250cmli
dXRpbmcgYW55dGhpbmcgc3Vic3RhbnRpYWwgYnkgcHJvdmlkaW5nIGFuIGV4YW1wbGUuDQoNCg==

