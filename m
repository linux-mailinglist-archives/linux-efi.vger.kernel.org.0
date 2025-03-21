Return-Path: <linux-efi+bounces-3065-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0277A6C408
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 21:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407BD3BB6F3
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 20:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5882622D7BA;
	Fri, 21 Mar 2025 20:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D8RvYoMi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MIda8SbT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915931EBFFC;
	Fri, 21 Mar 2025 20:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742588198; cv=fail; b=iGhAuQNW1pQhp30aj4ZuzFn8GLYGU2uq/sK4S6KdrLJ3pxY0r7KcxSuHdFJXiPOtGa8Cqi1UUk0XLnhmPme7J+o8RAGNuViGzgyu/XzDyVxiI2yeyBweVv+CuFlgAtYkenvbrDXDBPraZWhSMDHF/HPuPTKmYHM7fPL6jrgFOxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742588198; c=relaxed/simple;
	bh=pSWy7i9wgcSoJKJTfN5Tp45tfjWVH/Sc8UAa+0dIk3g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U7km1Zh7PPq5Ep1DWY3wQIg5WRAx10L7Un49oTDSclNY/hZNIsdcagq1u80xHg44mSBTS65ejEMZYCkQLyTGI24NDDMv9N7OX7LTg+uUVe4bJfKZ74hj6b3sZBGGeJjy4xoZmRHWUTYUwLiBfsiTBt/P0eJ9nep9I29fRNxZivI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D8RvYoMi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MIda8SbT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LJZ8wj019659;
	Fri, 21 Mar 2025 20:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=pSWy7i9wgcSoJKJTfN5Tp45tfjWVH/Sc8UAa+0dIk3g=; b=
	D8RvYoMixh1TmIgFGf4LzJjPSdPAUqTWnRv8qQPPOeUIPIXVXcfs1VariN3Rhcz5
	jlg6PSxkAPqFuP5wHyhxWN5FCg/H/mDxQ1PZ06IgYP2LzjD/aJpndFK3FqjICFis
	2TecHsAWvWyh/w3PmfNaFDFHsP2Y3kqnhwInMbtFcdWSLNOMEnUdaeJuYcyW6vvk
	QgRbIihbpTWYduueZT+K6Oh86gqakjG6ZKWBXl5F5YbOYG6Ezwt1nnG9Emdbz5vV
	/zJf83GmzyWtcu03HRVYMq2F/NEkgxjhbVCjUQoZV5M+Pc6qhlhr5qFIgni+mCV9
	SMp+oIEqoBIx9BB30kkLrA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1s91x7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 20:16:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LJvWZx022346;
	Fri, 21 Mar 2025 20:16:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxcae72p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 20:16:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8/1/sEC9uOm9wPYd4hjxHXmefCIVdrgXQsFm9taxYEj4P1ft7WLdub2slhUWX4+fnDI6xazou/8OyHaVoTpAtnz26uzJ5uINqy4RWUmza9UGpRKVP7uT4YOgYlmVpdzqqmwlKvWFFjsxKSbf8DMnQCwM+1sNRniV77uKhZMyg4ElafNWbtId7GfxG5JseP/XgSwHfjaaPdQUa3BewPCqdHviCDkNq8RTzymkjloKb7fBuceFGob/dkEzONcW3fQ6lcDPRj3fYYAhkPLDbL1A9MBd/HSWWWoPfQTFfgeCmTky1Jq2oi3XmYfzUTIZrKus8Tda3zEIkBKgzd8m1bicg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSWy7i9wgcSoJKJTfN5Tp45tfjWVH/Sc8UAa+0dIk3g=;
 b=Ey/iUt3bXh2fFzEJi/VtMeuu3AC8T2A/i5K48GdHwW+IACKIrMpCdSpAeZRZrQVNHYbSKFycSRY8XX6fNe73BoETCM85FslLEzPxaaSnWawsx6wGbT+yzxl7UH4wERj9ABbS1H1lqk8ik+uwzKnwooTD/hnHc8l+wTwLHKHal72cxuASDFR1pI7Trc/PbcvBkvkHAhbk633jbAszC740fKrK7qYxz3HgJORDEYgsOb44Gfzs+auJhcveoDUP1UsRC1E4yOhiIdejGDCkp4v30IDNpTW6B54R2z4IEVX9UY0ja/kTQJJSUL2YdA3j8ZvQdEAez/mzVGlLibBr/5fSeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSWy7i9wgcSoJKJTfN5Tp45tfjWVH/Sc8UAa+0dIk3g=;
 b=MIda8SbTIRM7X/uw5E87nw7GdfeGczLNswCEWDZlibt8cmsHutZOwCZg6QKuNrmtmkvMyPrdYpFb/47RV9ZjECamJ+JVedvOOVA+taOVk215ZvdjdjXyGsVS38KYGP6tM9snPbfF/OfOmtFq/KVX0igoWhzcwd9Uj1JaHfcSmHQ=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 20:15:57 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 20:15:57 +0000
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
 AQHbIK0E/vdc4Eou30K4SgPRfeDFerL0Jc4AgBIDLwCAAF1+gIADEbkAgADjnYCAUfK8AIAAHD0AgAEIXICAACNLAIAAGwsAgAUHzgCAAQ2/gIAAoSGAgAFh24CAAD5VgIABZIsAgABIHQCAFVKsgIAAaUCAgAEtnICAAAQwgIAAN/mA
Date: Fri, 21 Mar 2025 20:15:57 +0000
Message-ID: <15462D72-FED1-4B71-8F16-715CA282D37D@oracle.com>
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
In-Reply-To:
 <3e400185af56a899a9d93e792ea314292fb2adb9.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|PH8PR10MB6290:EE_
x-ms-office365-filtering-correlation-id: dc0682a1-d328-461f-df08-08dd68b530cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q2Rwd3IzYVhIS1ZoeG9DSVZWQzNMVDdFNFhSdnNTT1E3WUVNQ1kwd0JkVVdK?=
 =?utf-8?B?ZlQwWFBGaWl3c21mT3dvRUwrUVVreUdCUG1nbjFua0ZrUzNmSE14aDE3aThU?=
 =?utf-8?B?OHF0Rml3Rmp6bUxXZEdBVjl6Ukk3S1o1cmhOYTBZMmZyQzdyVUlFQldRWXZW?=
 =?utf-8?B?SG8rVGQrcStSNWgvRjUwTFROMklQNmxZR3dQOEpES09aSi9XbFpoRWEzZTdN?=
 =?utf-8?B?MHRDaVZyeDV0NGwwcFQwUW9mUXVYZ082cHJZSTM0ajlTeDUwQ2pVdkcxRlpX?=
 =?utf-8?B?dzhMNXNPU1h6UDdwN0lENGV5YUQ0ZWxPa3VVVjd2MTR5QlFSUEJSMnBiVWV2?=
 =?utf-8?B?eElvMzBBSzZ4eWtkYnlDNHZpWXVlc2ZORzdlMVVCS3JPb29rMGcvOEtNRUgx?=
 =?utf-8?B?azlwQW1ISzY2bVp5d1laOXVmZW9mOGNqK3NYNlgzS1dJYmZ1Z3JEQSthOEtF?=
 =?utf-8?B?R3czWURza0F3Z2hkVmgxS2plaGFLZHlTLyt4K0RDa3dqUkJwVWJGVzIzTzVi?=
 =?utf-8?B?QjJZOWhBMjY5OXIzYU9HeFovTUpXQVcxbFdNc1lvZVlVMXFLMGo4VU5TTC9a?=
 =?utf-8?B?TkV5ejBSR2dHRzNGbmR6TlQ0TlRvRXZYRHUxVTkrbis1bXE5eU9yaGhPVHI2?=
 =?utf-8?B?b0ZJMmo4YUh1K2xoMFZKdDY1WDJOOTFRQmhMYUtaM05RZkRuUUpxeHh4NjZ6?=
 =?utf-8?B?WGVDWndjSE55dlJaelFkM1R1TUZCRllZSjJveGsrWVp1dG1XMVp6NmZPY2Rv?=
 =?utf-8?B?bysrSUJoOFhnSHlrcmwxclpIbHpLZmZLclpSYStodmRvNExOQm94WlRKbWk3?=
 =?utf-8?B?d1ZnRzlUbHV3RmNKT0lNTVgwSXJBY2JRS2xIUytsZDZDUUlqbUszelhkWjd5?=
 =?utf-8?B?dWpGeHlJRzkzdjhiRmF5L3BpdWFBQmxaWm9XbC9NU3lqNFhrdVhYNnpiYVFU?=
 =?utf-8?B?dVRxZTRxa0Z2K0JLNzdYY0IvekNIM3ZGTndFazBWSWNBbm1PcDY2VTYvSWpJ?=
 =?utf-8?B?UEFiQ3hqYXkzR2dpZXRRZG1jZFBHTmgrc1Vwcm1UenpBRjIyb1VHL2Y2OThQ?=
 =?utf-8?B?d2crODlsd1BraE4wUU9DR3JaNGRqV0pRYjA1aERRR3RBcDlrempiR1poSGFy?=
 =?utf-8?B?bGNUbjV2RkFSWHZrOFBmcVpHVzh4Z1dVQnBzai8wdmswT2dscGNyR2M4Snp2?=
 =?utf-8?B?bkxjeDdJdTRpK2pjVHA5ekpqT1V1b0tseldCTXRPY0grWDI0RUtoV3pzWm1h?=
 =?utf-8?B?MkVLSC8zdVdDYzhHYlBWMXN3Ri9mMjdxSWZBYTZHcjVWTktzaU92aWZnOWV2?=
 =?utf-8?B?OEZlMmNmZFZKWHNqSGhodWo0MnNzM2dvQ1E0dGZDR29kaFV5N1NyQU0xL3pG?=
 =?utf-8?B?ai9laWp0c1Z2Tk1MZWc3YjZoV2NaQkUzcGNWOXdDMWdJWjhidUhjVk1mN2xQ?=
 =?utf-8?B?aXRQNjRHZk5FR1QwTEdvVUdTYytlUVc5UGJIb09tUlgrdGM4MWE1WjJ0RGVk?=
 =?utf-8?B?MG9FVk9vZ1RMVnNxN010TXdrcVdrSjZrdkpFeWY2SGt6RmZ4WDM0aGtZUHZv?=
 =?utf-8?B?Z210Zm1YTGZmQzlQSlFTUk1Nc2Z2dGN2MEpXSTFVWm1mV0tjc2c5R3dNbU5W?=
 =?utf-8?B?QzRaellWV0g0bnlGTzY1SkRiNHd4MlJSKyt0RUV5bUlJTHJxeFRpSXJtTzMy?=
 =?utf-8?B?N3NQVHVwd2czUUljeTNoZFNGby9sKzdmeHhUUXF6REZqcXdRZDFubEFQY3Uy?=
 =?utf-8?B?cnA4L3R6RForL3NyK00xNHVrZDAzZDNUbDByaUNEQ05MbWRMOWFMallyTlhQ?=
 =?utf-8?B?VFEzazZucmNzOFA4bmhqaFZGU0dxNk1TNVI2MkhGMCtncFlIZTJmZWROcngx?=
 =?utf-8?B?RXlJK0svN3haSGNBOXlCRFR0WXdHWUwyd1hxaVo5cEd0TEZUd09WYlRaZFJE?=
 =?utf-8?Q?l3sv8zAEnR6KVHgvUhGIBfdBnu35H4B3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGNkRVhIcE5GbXUrYkQ4OVQrc1ZFWURrbVhVVjR1NXVNK3FQTzF4V09pbFc3?=
 =?utf-8?B?ZVJrNlhiRk9kS3poMkxtMnhxdzhqamFWdDE2MEhKd3JLZWRON3VadjZTdEMr?=
 =?utf-8?B?aThYU0t1RDlqUWZqcklKejFXYVRJQ3h4SHFIS3ZzUDJHb20wejN6bHFrbGw5?=
 =?utf-8?B?WjRhTkxZTjd6TmpvOWtGZDZISjJ0NVQrWDVnb00vaHBrM2VoeHFML2pLaGVp?=
 =?utf-8?B?eW11aVhQWTdoWDNMcEdMUTNmQWk5Z0kzK0FBWlF3dmd1MEZlM2xjMUFsUmpQ?=
 =?utf-8?B?NjVqNWRXL2gyMzFvV01DTldoRzBDODVvMk82aldJeWo0bWF6MTdVMDFMa1NP?=
 =?utf-8?B?WlQ5c0tpUTViTEE1ZEsvUjEzazNjZkp2ZHBUbDFoMVVJR1lFWWtMVlhtQVhU?=
 =?utf-8?B?OUN5Y1RoV1ZreUVBWWpvQkw1eHE3S2lBNUt4WjRPWS82WDc1YW1ndHltSXEw?=
 =?utf-8?B?TWp1QmV5SGtrTm5qeDJRTnRkM0RpRFdjRXBkQ203R2hXZVdzK2NxWXprWUI3?=
 =?utf-8?B?ZkV6bUkxSXFNb0UwNCt0dmFpNWY4OUQ2Qk0xd25TbG1nSkRNSWNFVlJoYyt5?=
 =?utf-8?B?SXVzRCtoL3Avd01TZnVsc3FtdEd4UjhDcTRLZG5GR2dqZXdyMk5vcExCYjVF?=
 =?utf-8?B?aUtFRzBSUFBiTTlKMUVkdUxYSlAwSElOd3RJcEExRnk1S0pRanluWmdpRXA0?=
 =?utf-8?B?aDduYTBuWDA5SWp3ZUNYQXY0T3RZU1ZVL3U3Yy82Mm9ocHVEUE1EV3ZSL3h2?=
 =?utf-8?B?RUwwMzNjT1U3a29kWXJTWlVHUHpsbkRmWTVBeHVvdi9IYTRleURJd0NkblFr?=
 =?utf-8?B?cHZlM3M0aVJEQkV2cjRzbXJmUzhZdkRWa2pxVDcxV3ZtYWt5U3R2RFdBcEdJ?=
 =?utf-8?B?YUo2ZkhZS2JiZ0xnUEhEN2h2SlZTSlV3bFQ4Uy9jRU5RQmNOb20ybjJ4Qkdm?=
 =?utf-8?B?ZlMvb2kxSTNIZE5ja1dhSENwU3pnaXBaeENFM1RVZ2llYTlaVkd2Wi94QmQ5?=
 =?utf-8?B?ejJmaEJsM2RzYzY4MXdYNldiTU9CZGVmL0pMeDRrdkVlWmtzVUFkWnpOYkhD?=
 =?utf-8?B?ZGJSSFdQbzRsWFZCMngvQ0VrYitlQi9vdENFRzFWWEZHSm1VQjdFN2RQWHlE?=
 =?utf-8?B?UzlqSEh3WVBHTXpmQXBKRS9lWGQ2T0NlbXNyQVc3aDJ6Q245QWtyNXhjeklL?=
 =?utf-8?B?V2tMNVhkck1JV0l5SDhpR0lTYVN0VkZzcml2VVlsclArdU1BR3pkbEhNWW8r?=
 =?utf-8?B?ZFBMLzRHbURYbllTTGlLREdMeFdLLzdHUkIrcjJ1SisyaWwvMnVBVDhEcmVu?=
 =?utf-8?B?NlRsRkxrZFNBWkNVcHVWRW9waVRReDRpdEVSRy9SbVhiTnRLL0RmWXpOUjZ1?=
 =?utf-8?B?MmVzME9GUlNVU1pFMzVQYkpFWDVOWW1ITy9sWmhIRzMxTlRZMUNXU1ZUYS9O?=
 =?utf-8?B?T1YxM2JiSStNVUpOZW5qS0lWWHJqbzMwSDM0RGI5a1paNk44a09nNGRqNU5Z?=
 =?utf-8?B?OXA0MnZ0Nm0rYU43U2tINXd2dkVoaTlXVG4vUWlzUWo4OTNQQkxHckhMR01t?=
 =?utf-8?B?cjlVVlJKTzFNZjNBSGxvYnF0UjZ4RXlWa0tJOUw5bGtkNERKUXZON09pZGo1?=
 =?utf-8?B?TU52a0RnL3krd1dkdFlSVWRYSENJem03NnIySGVDOURKM1ZrZy9uY04wYlFz?=
 =?utf-8?B?MEZqTklnaExVazdaV3hMdERSMVlDbzFCZTJVMkd2NmdDeEpoQ25idVZDU3k3?=
 =?utf-8?B?eVIzeDlDd1dQVFVNVHBsS2JoNW9FZTlydy9VZmpxdGVkcHNJa1ZJcGl1aTZF?=
 =?utf-8?B?YXZaMklTRGdVbWxJa2tIMGlwR1FlMEtaQWwrdmloK0Vnc0xYbS9Kc3VyQVBD?=
 =?utf-8?B?UkptUHZFZXpzdndIQjNSajhiRmpWa0VkU09sc1pMREZvbkpkbm8zcWlGdmtt?=
 =?utf-8?B?ZG9pWUFjVVBnRmMzWFU2UG1pUU1tNmN4QXNBTjdKak9ROGtuYU91VFYrQjJD?=
 =?utf-8?B?UytzRmhaMTZ2SEpwWHRYOVVLWTVadDd4a1I5SWtRMzlPUnFuNTQ4RmdyOVlH?=
 =?utf-8?B?RmZ3MlhzYlErK2Y5bmlNb2pLeDB1M0NBcWZjZE1ZdzlMWG1aRGhQVmVBNDQr?=
 =?utf-8?B?QlBmbzBJTVJMNmFWcjkxK2VMRm95UmpBRjhQQUtMYitsUXFTaGF1cUlLVEk1?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <077D04A155F60944959CDBC0A96658A1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CE8WKzuFtR5Q4PdKIqronigjgNDOgrZO7ZT4WbP+tWKShQ96mDpAeb5dajy8zd83EfPGhQScMi4Oh1qWvw/kipZq8WHSb2fNGvvVuqtkE14caQaUi3ORr2uZLDqwiewMAdvfzADtb5gg+e49a9zCqNwqVHDKGYf+OiKVI6oTvkPVvFC+Dhib6sG+l/z3xrQN8+mBFhR3YuBeqiHHpKFEoUwOViXS1R9wv/+zwMphHfFrLUscnyBfIRP1Erfx6YZaTctRJFRM+v5qRc977oziESCmKXKF9gv5lffk6z9TODrPWH49X8zEBq/eZG2r2j2UUzFSuneTOEojYcH3b/D8HtBAJpdaTHsSUh3eP6RmFN3as2XGcBynsBpnCWFIJWsspc7zqJI4TApYRC4aTyA27tcYP9VS7y7qpONmEwKLaTilH2eY/HJhNHZy4yLPYk6+M7zewcNqdpIcFOt5t2G2U6v8Hl6eH1uYxLca9T7SXJq3Naqy0hDRWWB90ZVRtxyNp2zgKlObKUmRACtzVFnby3MY8TyByFRus/UjHjyDAVXRkyCLVYNaA/grGcDZUGwY7bY0iGUV0EcYmoo1777o+IAl3uyGtyMwU4Anlx3k6Dk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0682a1-d328-461f-df08-08dd68b530cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 20:15:57.3319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o5l24/xxK7TxKHXvZFd3fS9ZmOOtmmNCdVDhcewv8IO+zgfhFq8WnzD4dhqmnqWTDZaOTXHvZVnkpOBEVUvyM/Lb674ys4HZPbiudT+8Aw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_06,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=874
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503210149
X-Proofpoint-ORIG-GUID: wvmrJux2DYyL_FTkOz-0v3n234ktj-EY
X-Proofpoint-GUID: wvmrJux2DYyL_FTkOz-0v3n234ktj-EY

DQoNCj4gT24gTWFyIDIxLCAyMDI1LCBhdCAxMDo1NeKAr0FNLCBKYW1lcyBCb3R0b21sZXkgPEph
bWVzLkJvdHRvbWxleUBIYW5zZW5QYXJ0bmVyc2hpcC5jb20+IHdyb3RlOg0KPiANCj4gT24gRnJp
LCAyMDI1LTAzLTIxIGF0IDE2OjQwICswMDAwLCBFcmljIFNub3diZXJnIHdyb3RlOg0KPj4+IE9u
IE1hciAyMCwgMjAyNSwgYXQgNDo0MOKAr1BNLCBKYW1lcyBCb3R0b21sZXkNCj4+PiA8SmFtZXMu
Qm90dG9tbGV5QEhhbnNlblBhcnRuZXJzaGlwLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gVGh1
LCAyMDI1LTAzLTIwIGF0IDE2OjI0ICswMDAwLCBFcmljIFNub3diZXJnIHdyb3RlOg0KPj4+PiBI
YXZpbmcgbG9ja2Rvd24gZW5mb3JjZW1lbnQgaGFzIGFsd2F5cyBiZWVuIA0KPj4+PiBhIHJlcXVp
cmVtZW50IHRvIGdldCBhIHNoaW0gc2lnbmVkIGJ5IE1pY3Jvc29mdC4NCj4+PiANCj4+PiBUaGlz
IGlzIGZhY3R1YWxseSBpbmNvcnJlY3QuICBNaWNyb3NvZnQgdHJhbnNmZXJyZWQgc2hpbSBzaWdu
aW5nIHRvDQo+Pj4gYW4gaW5kZXBlbmRlbnQgcHJvY2VzcyBydW4gYnkgYSBncm91cCBvZiBvcGVu
IHNvdXJjZSBtYWludGFpbmVycyBhDQo+Pj4gd2hpbGUgYWdvOg0KPj4gDQo+PiBZZXMsIHRoZSBz
aGltLXJldmlldyBwcm9jZXNzIGlzIHVuZGVyc3Rvb2QuICBJJ20gbm90IHN1cmUgaG93IG15DQo+
PiBzZW50ZW5jZSAgaXMgZmFjdHVhbGx5IGluY29ycmVjdCB0aG91Z2guDQo+IA0KPiBZb3Ugc2Fp
ZCBwZW9wbGUgImdldCBzaGltIHNpZ25lZCBieSBNaWNyb3NvZnQiLiAgVGhleSBkb24ndCwgdGhl
eSBnZXQNCj4gaXQgc2lnbmVkIGJ5IHRoZSBrZXkgaGVsZCBieSB0aGUgc2hpbS1yZXZpZXcgbWFp
bnRhaW5lcnMuDQo+IA0KPj4gVW5sZXNzIHlvdSBhcmUgc2F5aW5nIE1pY3Jvc29mdCBubyBsb25n
ZXIgIG1haW50YWlucyB0aGUgcHJpdmF0ZQ0KPj4ga2V5Lg0KPiANCj4gV2VsbCB0ZWNobmljYWxs
eSB0aGUgcHJpdmF0ZSBrZXkgaXMgb3duZWQgYnkgVUVGSSAoYW5kIHJlZmVycmVkIHRvIGFzDQo+
IHRoZSBVRUZJIENBKSBidXQgdGhlcmUgYXJlIG11bHRpcGxlIEhTTSBiYXNlZCBjb3BpZXMgZmxv
YXRpbmcgYXJvdW5kDQo+IHVuZGVyIHRoZSBjb250cm9sIG9mIHZhcmlvdXMgb3BlcmF0aW5nIHN5
c3RlbSBncm91cHMuICBUaGUgV2luZG93cyBPUw0KPiBncm91cCBob2xkcyBvbmUgYW5kIHRoZSBz
aGltLXJldmlldyBncm91cCBob2xkcyBhbm90aGVyIC4uLiB0aGVyZSBhcmUNCj4gcHJvYmFibHkg
b3RoZXIgY29waWVzIEkgZG9uJ3Qga25vdyBhYm91dCwgdGhvdWdoLg0KPiANCj4gVGhlIHBvaW50
IGFib3V0IHRoaXMgaXMgdGhhdCBVRUZJIGNvLW9yZGluYXRlcyB2YXJpb3VzIGRpc2N1c3Npb25z
DQo+IGJldHdlZW4gdGhlIHByaXZhdGUga2V5IGhvbGRlcnMgYWJvdXQgaG93IHRvIHByZXNlcnZl
IHNlY3VyaXR5IGluIHRoZQ0KPiBVRUZJIGJvb3QgZW52aXJvbm1lbnQgKG1vc3RseSBhdCB0aGUg
VUVGSSBTZWN1cml0eSBTdWIgVGVhbSBsZXZlbCkgaXQncw0KPiBubyBsb25nZXIgc29tZXRoaW5n
IE1pY3Jvc29mdCB1bmlxdWVseSBkZWNpZGVzLg0KPiANCj4+ICAgSG9wZWZ1bGx5IHRoYXQgaXMg
bm90IHRoZSBjYXNlLCBzaW5jZSB0aGUgcHVibGljICBrZXkgc2hpcHMgb24ganVzdA0KPj4gYWJv
dXQgZXZlcnkgc2luZ2xlIFBDIGJ1aWx0Lg0KPiANCj4gSSBkb24ndCB1bmRlcnN0YW5kIHdoeSBN
aWNyb3NvZnQgbm8tbG9uZ2VyIG93bmluZyB0aGUgcHJpdmF0ZSBrZXkgaXMgYQ0KPiBwcm9ibGVt
PyAgT25seSB0aGUgcHVibGljIGtleSBzaGlwcyBvbiBQQ3MgYW5kIHRoYXQgaGFzbid0IGNoYW5n
ZWQgKGF0DQo+IGxlYXN0IG5vdCB5ZXQsIGl0IG1pZ2h0IGhhdmUgdG8gZm9yIE5JU1QgcmVxdWly
ZW1lbnRzIHNpbmNlIFJTQTIwNDggaXMNCj4gYmVpbmcgZGVwcmVjYXRlZCkuDQoNCkEgY291cGxl
IGNvbmNlcm5zIGNvbWUgdG8gbWluZC4gIEZpcnN0LCB0aGUgdmV0dGluZyBwcm9jZXNzIGJlaW5n
IGRvbmUgZm9yIA0KaW5kaXZpZHVhbHMgdGhhdCBoYXZlIHNpZ25pbmcgYXV0aG9yaXR5IHdpdGgg
dGhlIEhTTSBvdXRzaWRlIG9mIE1pY3Jvc29mdC4gIA0KQW5vdGhlciB3b3VsZCBiZSBhY2Nlc3Mg
Y29udHJvbCBvZiB0aGUgSFNNLiAgRXNwZWNpYWxseSBpZiBpdCBpcyBub3Qgd2l0aGluDQpNaWNy
b3NvZnQncyBwb3NzZXNzaW9uLg0KDQo=

