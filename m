Return-Path: <linux-efi+bounces-3053-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD63A6C047
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 17:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DBDA1898FAE
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 16:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C503022B8D2;
	Fri, 21 Mar 2025 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UrzdgfF3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VPBwNz1n"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71F413B59B;
	Fri, 21 Mar 2025 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575276; cv=fail; b=MzMxQn4/7yqj2AfIWewI9nM8PJ2+BS0Bq7MwI2ZTJAsO8t2XtXLL3xEqH5wFgdBTkQzmgde1+b3kOsoIysG80EThln1YiLm29CZzutvo6SnVTeRJ232894zr9SYvJ/+YGv9m/4Eek0LyNJFegcmwefseot5f3KGgy6t3RWiOorY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575276; c=relaxed/simple;
	bh=nWHpgt1Tuv/IJ4IQeyEvuNDgCBjNO9hDfCFlowxn+r4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mLwWQQjQg+4osuzZosLfZjM1YPQOa90m2GHweEjXng4EtwDcEdJkEl1qubcEiUzq9T8JMX4oGvpya1tK50AQu/pbu/Imn73MdBdTlSXVMRNHl1QOmbuXqDOeZOrJHQs2p0KU4AdGSpErr9YJPPmtB4rcCq6K2faXj0IuZU/wsOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UrzdgfF3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VPBwNz1n; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LEBuWj031699;
	Fri, 21 Mar 2025 16:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=nWHpgt1Tuv/IJ4IQeyEvuNDgCBjNO9hDfCFlowxn+r4=; b=
	UrzdgfF3H6iu1BHeARz3JTMP/KNG4WezoBIYirrycuXqci6xIhyskT7IKJdlwxxZ
	qBAEeMHGggZxxDJ3jqCj86nQP3iZp8GlUBOOIDMXDiBN1BPFIwFosDzy6SGjYJet
	0VYTy25a5ZSnvvc/ZOYasLUnpkniMSNOd+v75giLKb61L+Z1XpaAvrMG0m1AkneR
	Mr16yJ0BtXW9cs2H5nAlX6ZJCbt/6t3BG6Rxjnh9k6Q5dRt4R0VNYoh2ysmTYTtG
	v+5OGGxUyvBAdcFVs4WMXXRC/XjQOkj8hZViIUKmgj74s6fpo8LwciD0etn2/zZX
	rinTBERJOx8xd42HcTlPZQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1ka94kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 16:40:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LFkcRM004645;
	Fri, 21 Mar 2025 16:40:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ftmyp5pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 16:40:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oS0Jp7RYDuQVC7zPd1OunH0Dt6T3IkZi46548BlVP6aJIjtlVvhf/oiXTJeP0PJR+H824Js64ScBg3wFHQkbsBFB/J4gaWtmq+wmaVtl+i4c1WH+GtnBX7fCW/hWclS5WyFcwxKClWKZvJSUpnWABUZnL1dKx29IOHS5TUCZOZIvvCg+uuSRCKLj4xy23C4uvtCoMzwZNHXYQcO30FGZf5Z3mJsI3YEZzzD65jTjM5q2Ch9cbyzs0f3vATEV5oQ5xJz+tdCPqJCV9Tobqfg98sjO3M1RfXo0Y6KfxzvG3toNMZTgt5x/jbyRc5LpZOgVjKQZVzdSfNKhW0mqTbKfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWHpgt1Tuv/IJ4IQeyEvuNDgCBjNO9hDfCFlowxn+r4=;
 b=ckMchg1dDjNMNU4Tk9u+fvMS4mfD78O3SSsux9oYW4WxNGAa88p1UjAyqmbbpau4Rjxe2qfMeyitf7H8XOJH2swNmMwjdwgf8b7frqSi/innI7pvjzluwQ2Px6pv+EsBUCYW52P2xv1VCFgCT74VUDnz6+dV1+nMtuv3E5T716OinSwtnRgN1EJo9BgUMb4Jmj121a0HbxLCMUcvV6UJujqFLAax/woengO/dfYyTr1LaoSESgZol81AN1lY2owvjpv3y34/o7zntSCFAA9Dt54jgE4iUVmYum1v8ZEbHxwn9Ui3PhQi52QaDm/Nk5Mua8zhsGbnS00qfpBfvQj1rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWHpgt1Tuv/IJ4IQeyEvuNDgCBjNO9hDfCFlowxn+r4=;
 b=VPBwNz1nEzIfzxMDo6rq0dsTZfpy39C92cNdlVKtqNUaGZl8BfScAvy6y0v/Wwu+cqak3BJvcuvk7pO7SMZny+tG/af0WeH5hldjPdMUIV4Scli8HPiuyMuxa+XJMbs1Zb2PXChkeE9P1YsCU09SgEBoFkcYyQ3YPW56IdlWVvQ=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by SA2PR10MB4475.namprd10.prod.outlook.com (2603:10b6:806:118::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Fri, 21 Mar
 2025 16:40:36 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 16:40:36 +0000
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
 AQHbIK0E/vdc4Eou30K4SgPRfeDFerL0Jc4AgBIDLwCAAF1+gIADEbkAgADjnYCAUfK8AIAAHD0AgAEIXICAACNLAIAAGwsAgAUHzgCAAQ2/gIAAoSGAgAFh24CAAD5VgIABZIsAgABIHQCAFVKsgIAAaUCAgAEtnIA=
Date: Fri, 21 Mar 2025 16:40:35 +0000
Message-ID: <172F304A-B719-4FBB-8FF5-23B6961A2DCE@oracle.com>
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
In-Reply-To:
 <95e7a43a2dd675615a146c56a10abf6921f955f9.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|SA2PR10MB4475:EE_
x-ms-office365-filtering-correlation-id: ddf394f1-826c-4ff3-aa40-08dd68971b0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QkVFRER4dHJrZCsxK3pQeXNLTUwwY25ieGF0cDBFUG5Xai9xR1ZwZGJLSG1h?=
 =?utf-8?B?OUhRbkZnNi9Nb1poV0h1eWdxN1UxekZTa0c3MzlTSHpDWk1qNmpRU0NWRm5D?=
 =?utf-8?B?bStkQjFaVk1OYmUvYXJqMHNpUXdScEZkSlBKeTJSc2hmOWxycC9ldDB3ekZT?=
 =?utf-8?B?L2Z5USsxSnN0NkJwa2srOHhnYlpWcVFSYWJDcHVnM3BjKzliK1NEQ2wyZHpl?=
 =?utf-8?B?K0p4dnI1VmtoRFR5bUtsT2tFMERNSFpwS2trVGlwaGIyZE9uZGJ3cVVLd1Fm?=
 =?utf-8?B?S0ZFOHkwWGoxSkU3RzYxZDg4Y3E2NU9yVmFoZXZqVXVtWXdSQkZ0VEJyS3RH?=
 =?utf-8?B?THRDeHBVNE9qNGMvNmlzR1VGS3RLd3pWYUJmcTZzZkdVcXVmWUxEZ2craUZJ?=
 =?utf-8?B?SnJZM0tlNUlLUUxObTM1SWVZN0RHMjc3QUQ3TUVnK2dBanBYcmZrVXppbnZB?=
 =?utf-8?B?M2xQTTJZQUhOMWNRdlFWZEJGYlJMakZ6enhxU3dQYmFKREkvTGNCOXNpaFhT?=
 =?utf-8?B?bVNxTU83ZzYxY1BOSW5iejlDZFJZVkxORHc4QmU1Lzh2Z2dIUmhKWlFoOGhC?=
 =?utf-8?B?SDdWNXMxVy9EdzMzQWU4V2luSFpSRVd5NlNGTVpIZWgzeG1KcVpFbzZ6ZDRs?=
 =?utf-8?B?cTFyRjd3YjZHU3hTWnkrMDROOFk3VDVNWHNKVHcvcVJMTzN3MG5HSXkzcVhS?=
 =?utf-8?B?OHBxM21USS9qaDdCTUZENWZtMUYzWmNLM2RMOC9FNFRTdDJiK0k5V1NsbVZv?=
 =?utf-8?B?dCtJTW1pMjMxSGhkVEYzVzZUbnFCckpLVkpJNmdzZDNnNUozck9naUllMWZ5?=
 =?utf-8?B?Q25IMy9TcWphT0t4eERJN3hDUjVzQ3VlaHhiUHd4MW5GT284SjdaSjhoVGsy?=
 =?utf-8?B?N3docEl2RExtY0ZSazB2R3lXSitpbUdJelo2NEZUUExNbVkvcSs0RFV4Umlm?=
 =?utf-8?B?UlVoYi85Q01ETlIydzBZVjA4WUpuc3ZabkUrdm1jOFp6UkJZUis3Q25kWDFm?=
 =?utf-8?B?TFVDQkxXMjZSajNZM0twK3EvZ1I0RkNnZ0tXN2NOWUpIejB0cmFpSGNHTHJM?=
 =?utf-8?B?aGhlTmpKS0JXOXJMTXpHZ0hhTjBoMGp4a0svNzlHQzd2aExLSFZBS2FNZk40?=
 =?utf-8?B?Q0EzZEhCY2w1MDBORHdyV3JVcmt5d29NOWlMRHdCY0lUVEtaUjJCNVVnWU8w?=
 =?utf-8?B?c2ljaEpvZlYwQnRNU1hpUy95eEJHcDRRak1kdjgxUU41ZkxDYm12cHhlTXRK?=
 =?utf-8?B?eGlzdDFZcmlKaHYxdHFDbGVRYVhYVVFhODhpVWh3dDJyYXkxRFlLQVo5elNO?=
 =?utf-8?B?MEVZZGozcnJiQ3hscGhZNnBheWdDSExnV05HRWM4Y0xnOWVUbEhOeGtLQWI1?=
 =?utf-8?B?T2lHK1k5OE91YTRZLzRRNFBLMDVmT0ZQQndDZGZ3TGNMdjIrbGRUZnoxYnlz?=
 =?utf-8?B?anJBVkdpQkRiOVRydmR0NHpXOFVER3lkaFk1N3lsSTRMTXFrRTJXemdGMHhN?=
 =?utf-8?B?Z28rbkNrbTZtQlFGME5abTQvbGE4dlNwZnZIby9ENUErS2p6ZlVuQTVDamZT?=
 =?utf-8?B?QzVLbVYzNVdHTmtmeGN1bzF1TDZTajlISUlyYStDWERwaXBrR05hd0ozZnZU?=
 =?utf-8?B?L1liMlJuRXRPV3M2UTFEc0tsYWZ5b004MXFwVEFodzJ0WkFxdzhyd1QyVUhO?=
 =?utf-8?B?dUpOdTJlem5CZGtCVHRCU1I1RDBkdjhYT1JlWGFtUE81NmhuR1JLaFo1VU10?=
 =?utf-8?B?U1FPNTFZNUZOR25vc2hOczI2NUNWdUtWdmJ0ZkhBMGQ4ZXJIeXNIbWRJOFVr?=
 =?utf-8?B?N1BoMTZ1MThOUGZpUXdHZjlkZGNSejVMbEEzVU5CVFJwTmlzVDZVYWduK0sx?=
 =?utf-8?B?c29taG90ZFp5d2tHbi9oL0JIQjJTdEZYOEF3aDV4TmFJV0R2eWVLK0ZkYUFC?=
 =?utf-8?Q?JbEKs91RqM+eWTi5s4gXCeER8fWhAEsU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTJ1VkhXZmVuWWNQeVdFcU9iS25CSms1Y2hjby9penlnVDRsSVIvdzJiSUJ6?=
 =?utf-8?B?Unl2NUl1dXgraVlqelR6S3paM0NBTG95eHBjTGJrU3RxWDNSTndOMWhzbWF2?=
 =?utf-8?B?cWVRNCtERzdrSDR1R3Ric1RjbXJSY1piZjhLcUprV2xwVlRUZmIxVW1rSkZj?=
 =?utf-8?B?NHpWTjZtMVFjc1BOTUxRcWxDaGZId3ZHSjV5bGxsZmR1bWNtZ0RzOTMzSEIx?=
 =?utf-8?B?bmlvcklqdkcvNVBpSVphUHQ1MVNNc3paRnQyVUdEN0NFR1dvSnJFY1FLZ2V6?=
 =?utf-8?B?OUFKa3pBMFFWbXdzVnhCVXcxUjJsdWF2a1J1NkNMQnh1U1lvaHdqdFIvcGgr?=
 =?utf-8?B?eDBtMEpHN3FnczE0ejBQU0NCSk9Gdm1IZFZqSVRvNS9uRGFEa0tFRE9yZ25B?=
 =?utf-8?B?YVFCRnZoRnpBd2Vuc0NIb3VLSnhZdEx3U2RTSUpQamM1Q1g5Ulg3VmM5RWlW?=
 =?utf-8?B?QmVnNWRveTEydFhWOWhXN29jMGRBcEZMeWpsRkl5TEZBdU14YmdXNzlETjB0?=
 =?utf-8?B?dGM5MWJnMktGMzAvWlYxSmFNQk9NdEtISXhaOEpGV1dNdTFOWFBiaTM0VkhI?=
 =?utf-8?B?eDFtbUNscUR5cXBmVWhGRmIyYkMzV3BNcHNENERuL1JsTGZlVFhQTUVTUTdm?=
 =?utf-8?B?bTZoZmMvSzl1Y1o2cUpnS0pNRitLUzdLM3ZkekRDTFdTelpNRVhXNzNSMjVN?=
 =?utf-8?B?bS9UTzI5U24rZ0F2NGNneTNHQ0JTKzhtZkRnMFlrQUNtc3FWdmlidFBsTm0v?=
 =?utf-8?B?bm83bStuK2haZkFOTnI0bHc1ajVYQUVvQ0VhVXpOT25LM1dmMGdvUFBtZFNo?=
 =?utf-8?B?S1JFeitWcE1yeDN0Y3o5TjBTbllOUUtrcjVkcjVLeUdWQkM2dUhxTzZ6SkNE?=
 =?utf-8?B?LzlUOWpPOElFd2lDVEJXM3kxcHd0TTNTV0N1TG5mNEI1SWRyQWZQZ2h1QUwv?=
 =?utf-8?B?MmllL3lxbkE0cEdsMGlwV0c1V1dQL0ZVT3c0WHN0bWVNU3p0NXRQZXlrcFVU?=
 =?utf-8?B?UEw5RVFTQlEwdW9VVlZ6SlFqeUFXNlRERXBtcXFqczVFODI3UmJRdmVkRGhI?=
 =?utf-8?B?S3dNdHNvakxsYXhBOEgzZ1hncEJicFVhVGxGdmdma0NiR3I0M05zK3NxTk1S?=
 =?utf-8?B?STVuRmtTMVdNd24xd01JKytyZWMvVC83Q0FlL2dFbVgrQ0hac2Q3QjlaQTV0?=
 =?utf-8?B?SVB3S3RyNmtSRC9kNEVpTU1IaFRaSVh1RHkxOXJLRThYNndWNnJNQWg3SXZG?=
 =?utf-8?B?N0dnR21HR2tKZm9Tc1RDMzcwODRLQnA2Qkw4b0pWcC95NXVUOU8zVzNpaFc4?=
 =?utf-8?B?cnFYN1A4NFFkN1FxN0ZudDhIaUcwKzdPV2VMVmlab1FSYmlZeUJWUFUweVYr?=
 =?utf-8?B?d3VvdFphSDZHSzRVWjRobXZySllzRTljSThPV0dIamp0NVpaS1NsLzR4WmI2?=
 =?utf-8?B?MmxwWVRaM1pic0JRYTNjTnFGMEV2akMycmtIVDNGNEk5OC9pNmpEa0w1aWhZ?=
 =?utf-8?B?Rm5MUHhEMmNBMGk3d3hoR1RpTGJaTjZFNFcweGpaSFAwN3gyTTh3ZHF4R05P?=
 =?utf-8?B?YlIwTmNiWU1UUUlBVEhZU1p4Q1RtSUtsS21EWEJpS0Rvc2lybmMveFRIU1hZ?=
 =?utf-8?B?TlJaU2tNSm5lc2xkOHB2WUJxWVVqeEVDTk5BaUhxdWVEMzlINUxaTUVaNlRH?=
 =?utf-8?B?bEhFYUx0SXl0cDVVc3JvWlYvZmV1RHpPdnFYTnBDY2FNK2VsMDgwY0psdHl4?=
 =?utf-8?B?cmFjUk1PN1BCQmZIQno1azhGazlRMEhlTUdnYzZhdnpaV05XWHVpLzVvOHhh?=
 =?utf-8?B?ZXM0R0VLcFU3Yld3Kzh4ZU01RmNrcnY5eFQ2OWtHQmxTVEl0eWhGMEpreE85?=
 =?utf-8?B?ZmdyMzY2dkxpQmt1OGZJVFRYSFdYRVhDUVZQOG4zYm1DbTA1T3lOU2ovb09k?=
 =?utf-8?B?UENBOXlpU0V5VXdJTEdNc21WQ2NrTmtVZHhia3hWK1hiV0hjNXJkR2tPWU9y?=
 =?utf-8?B?TjlreXRjNzFKaXBiWGt6R0hIem1JOFJKREpDSzVGR1ZNdDM5ZkM3QTg0UWdw?=
 =?utf-8?B?S3NBZEdySVRNNDFkTG1aenNEWGRTWE9XV2JwL3ZDMUJxTERoY01VOWR5SjFF?=
 =?utf-8?B?eDI0S3ZPblp3UGpjY3JmaFFtN2pLdDFhajNabW1xUVcvU0xZWnRhQmZVZHRU?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC6F570596C31F4589F7FB4C3813C32E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	trn1XZ52gMDjEpAEuEcd8YuxoUGigCe8edJHjmV+QnoKjWeODJXdN4pnEVyZMiiIKcJ7kbyxm0GY9orhgCVmGlPaIrcDcm8nX+uSkhNQ4FK98dx9d1v3zQdXftyDRExRTujtyGFEDfU9PFoOWJgfWxzN9EOBjxcG4l6V8B1Idw5KYi+3AiTPNNOOs0Z+DEvVeOyPuJofwYkz1hNV6d/ZMPQ1mxKAvsW3f55Lq978tvA3itoLEJD4S0ZlZ5ECT8SeT9hHvbIukaJlRhV3G9T1IO6Z4JhERUK2ynRjzy43ZfzmX1wvTPDSGqvENCGizrH3Sbjg9ooqrKzhPl18nH1mdPsXT9QneezF6/7C263f/mbjDlKGHR4AnZJLw+mTlqcCqn0Tztx3eZy1qlbC2PJXSg3ZzBGkYAnWM3ANcSj3eM+Wxq3w3leFp/Au2JMRiltGDDb9gSc+eBkYZh0F/JfwbzRUfXmyEx56fNWSHP2D2KFTViStLz3AuCbBq1t17cBammMhJGVBruJ4J6Ff6YkYrdagyWCPLhTRzbejX6n+lCEORwx65XyPEeicBzlFdEgYWMfevjy7IfChj5aapLxPShWIJqp1hsZ/D/4O86OPj1g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf394f1-826c-4ff3-aa40-08dd68971b0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 16:40:35.9324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5DMOPgITtfTEIc/MHExMgnNTlPrAqYC/k723xApYp9zN9NhnOpxJHlgHZE/D1Hi1pI9yq0XOYG6vLdW9Q3JwGZaDawyGn/nRC2e+zhKyKks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4475
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=868 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503210122
X-Proofpoint-GUID: brtcN5x4PC-vWorSlBrApCvH8TQIkrV1
X-Proofpoint-ORIG-GUID: brtcN5x4PC-vWorSlBrApCvH8TQIkrV1

DQoNCj4gT24gTWFyIDIwLCAyMDI1LCBhdCA0OjQw4oCvUE0sIEphbWVzIEJvdHRvbWxleSA8SmFt
ZXMuQm90dG9tbGV5QEhhbnNlblBhcnRuZXJzaGlwLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUs
IDIwMjUtMDMtMjAgYXQgMTY6MjQgKzAwMDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+PiBIYXZp
bmcgbG9ja2Rvd24gZW5mb3JjZW1lbnQgaGFzIGFsd2F5cyBiZWVuIA0KPj4gYSByZXF1aXJlbWVu
dCB0byBnZXQgYSBzaGltIHNpZ25lZCBieSBNaWNyb3NvZnQuDQo+IA0KPiBUaGlzIGlzIGZhY3R1
YWxseSBpbmNvcnJlY3QuICBNaWNyb3NvZnQgdHJhbnNmZXJyZWQgc2hpbSBzaWduaW5nIHRvIGFu
DQo+IGluZGVwZW5kZW50IHByb2Nlc3MgcnVuIGJ5IGEgZ3JvdXAgb2Ygb3BlbiBzb3VyY2UgbWFp
bnRhaW5lcnMgYSB3aGlsZQ0KPiBhZ286DQoNClllcywgdGhlIHNoaW0tcmV2aWV3IHByb2Nlc3Mg
aXMgdW5kZXJzdG9vZC4gIEknbSBub3Qgc3VyZSBob3cgbXkgc2VudGVuY2UgDQppcyBmYWN0dWFs
bHkgaW5jb3JyZWN0IHRob3VnaC4gVW5sZXNzIHlvdSBhcmUgc2F5aW5nIE1pY3Jvc29mdCBubyBs
b25nZXIgDQptYWludGFpbnMgdGhlIHByaXZhdGUga2V5LiAgSG9wZWZ1bGx5IHRoYXQgaXMgbm90
IHRoZSBjYXNlLCBzaW5jZSB0aGUgcHVibGljIA0Ka2V5IHNoaXBzIG9uIGp1c3QgYWJvdXQgZXZl
cnkgc2luZ2xlIFBDIGJ1aWx0Lg0KDQo=

