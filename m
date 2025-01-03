Return-Path: <linux-efi+bounces-2502-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AD3A0110E
	for <lists+linux-efi@lfdr.de>; Sat,  4 Jan 2025 00:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF665163B27
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jan 2025 23:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3682B1386C9;
	Fri,  3 Jan 2025 23:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VReypsTg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mSEox3Cp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BA6CA6F;
	Fri,  3 Jan 2025 23:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735947170; cv=fail; b=BYF5PR2aX81NoTvFrIAMbj8RMT6eBaYgrKv46VYo2e9nv124X+v9Z/hSInr0TGdF/PR6X3oSY/325nZVprPlS/kBIOXohmKHiw8/2yxhBT8MvlwaLFuUZ3oLFoGcV3Yf8fsQg9oFlq/HK8fs6wv9QUidOLOrOvkMD1L3wgkKE5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735947170; c=relaxed/simple;
	bh=N7cdpIoBaEnfyWWZbUItOApEXnzoBWV7X+hgSFF1Grw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iaScbN7yAM0DCsq2Gz+EueJtotcaHbvmL11JFDcMZ2RqMUBPgmzqhDw6cyMpx4UD4iW7zjZTCJq5A9UuYdtY2gQmwNA//01zsavyaIQyC1SawoQjfBYKDu2xgBYYXXNslWozxcqGjsIgXnJjcNF3Pn8oUvVVxuDypWtbDTOzN08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VReypsTg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mSEox3Cp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 503Id3kT013114;
	Fri, 3 Jan 2025 23:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=N7cdpIoBaEnfyWWZbUItOApEXnzoBWV7X+hgSFF1Grw=; b=
	VReypsTgrjZxJG191nTa9wIL2JMmCXWQOIzmP3b60QuC6rtNdWMPM+Qfd7fCfbkY
	pV4+mTQQBVam1uO9eVdHkChXoZiJuyxU95hv7wxQGyyMNyYepkP6lnIsEEdJ+g0J
	+tQYb9xl3sCD7zgZAOAqwUPQPYu9aCyZEriJOOPp6qf8GomADDYOfiujDO8wBbE+
	zN0fj+NsXdKfpsKmwRU4RSu8kiYevYX2zxpdz6wcE+CDwnoq8+9SrjgLejD6mxUT
	KuBFjGAlvT9YPgDbquaxgt2IyTeUQ5RUDeNJ5AbCSKXxkve1VEgh7iWB3QoU1x9o
	OefTNxQkPB8c7wkn05FnfQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t7rc0vk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 23:32:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 503KjR47012360;
	Fri, 3 Jan 2025 23:32:23 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7sa5tte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 23:32:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wITvvJxQtSHoz6tFSPxDUHnzRzmpwwmmliLlvyvDjkQStYW1VPBWsd81GRB2pGWojs1QXgLwvbl3HHC+J2l0Uc5AdTkgpfHomBCPsbFneNoRYAJTt8Jn7CG3dx09CpkznkHZSoy3iI12ewxQrLaE4M3+JcZx8tZJDgUEir+wUJLpCE0BxQbYbibMNAwwb1L2H6nxh1alklGUiwu5YqlvY86RX61fTtFm5A4bEOrdjInG0rjeFK/LpF7uy2ytplj8R3Q76DDBiDyc13JDggLigkHBkMvcJADLdnjBNbvae4sME2ZbChHaj+JaFebAsevpb3sAzDt9ff0gLTSKZo/A8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7cdpIoBaEnfyWWZbUItOApEXnzoBWV7X+hgSFF1Grw=;
 b=X7cTSk+nkKBo0mdsINECh/rufYICPyBicybAVOUsowG/PzNQ2dENY4fWoS+hDuVPyaYCectxx3aAOYILjOdB3a4AVoyM6M4lrdhos8RC5h6VDr67PBqWsUyT65UjltUt+E/65AdpSrGdKkLh93BXlkBvpqdgCL2nIum9yd/0s/SdflXKQlY/L9T1RZTeGJqSmE2sdRtp0Cb/YG1ZxMjx9d1KoweYcTTvuJ4RYGs4CNtep/aroN0yke4kTQJhr6XAusqauKrW399rc4I4iQ8KtKG27CL10O8UIzBq3Px/lMgPnN82YbaGz5VkNMBUetdxKvpzOA53daV9XmDMauXwWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7cdpIoBaEnfyWWZbUItOApEXnzoBWV7X+hgSFF1Grw=;
 b=mSEox3Cpw0n0RLraJlKt/obE6EDFcDEq/s9aYmh5V78/rkQDfQR6iTHXy4EIdmpNQP7HvBQMylSyA4IvGdV17sx5na8cNvwbnXab8rB26mf0mrGeChkCaoC9NSrgS5EBcCKky13KAZZlLvQvDdWPOsfFxMVQHIIIeZFMBE0SHJI=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 23:32:17 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%7]) with mapi id 15.20.8293.000; Fri, 3 Jan 2025
 23:32:17 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: Mimi Zohar <zohar@linux.ibm.com>
CC: "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ardb@kernel.org"
	<ardb@kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org"
	<jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "mic@digikod.net"
	<mic@digikod.net>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        "stefanb@linux.ibm.com" <stefanb@linux.ibm.com>,
        "ebiggers@kernel.org"
	<ebiggers@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [RFC PATCH v3 08/13] clavis: Introduce new LSM called clavis
Thread-Topic: [RFC PATCH v3 08/13] clavis: Introduce new LSM called clavis
Thread-Index: AQHbIK0RMggp9a3W+USqBJd5xzNEfbL2FVMAgBAYuQA=
Date: Fri, 3 Jan 2025 23:32:16 +0000
Message-ID: <6DDCFABC-8440-4316-98D4-E3F5C9532925@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <20241017155516.2582369-9-eric.snowberg@oracle.com>
 <0d71ffced35abf40bbfadb6e03b053c24757183d.camel@linux.ibm.com>
In-Reply-To: <0d71ffced35abf40bbfadb6e03b053c24757183d.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|CH0PR10MB4858:EE_
x-ms-office365-filtering-correlation-id: e46cc3ed-5c82-4be7-abb3-08dd2c4edc35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VW9veWgrOEE0TDloZVRXN05SM0E1dVgzbGVZcnpWTEpycGljTHRtTEFiN0JM?=
 =?utf-8?B?QndsbE9WNUJvS09jQ21OT3dzSmJTeGl1VnNLNEdpNHdXRGRKVldFVENLN3Ru?=
 =?utf-8?B?czFPczcxd2RkK3pKaXZyTXlETk5VbkE2K1J6WnkzN0dJQUR1QTVIZ3B1Smp0?=
 =?utf-8?B?U2c3OFlhcjQ2Nm9SdHA4NVdURytEV1dHeU1TRGJoOGNJUFl0VDYxMFJxVzhi?=
 =?utf-8?B?MVlVdUFHZWRqWTludkY1cWRKSHYxR1ZLaktOZzhyc3dJeU5RQlgyMFMzQS9l?=
 =?utf-8?B?ZVhzSDlvb3lpc3JsbERlTmNYVER1d3dWQk9ENldmY3k1L2t3TGVZT0ptYzNU?=
 =?utf-8?B?Q2s5cEZSZ3ZybDUvOVF0alhSSWVZTG1hR21XSzZBcGxsQlFzVUsxTUY4c3JH?=
 =?utf-8?B?WTdnNWhoQWhPVFlzY2dJUUx6OHVsUkM4S0dyN1d5MzhCdWRvU2dSSW5pSW1p?=
 =?utf-8?B?elZ3ZHdCcEJha01TcHJ5ck0wVFphK2FXenNTb0xRdzFTR09ObFVzcDdEK1d5?=
 =?utf-8?B?MTVIdnlpSngwcGZ2VVYvQ1RxenNCb2ZUcTZVZkV4bngzUVBsYmlWbWZzYVNR?=
 =?utf-8?B?RXBNZWZmc1ljQ2pNWGZMa1NLbjBHNy9OOVNrTDhma0NzMURDRzlFRTRucitz?=
 =?utf-8?B?djBlVjdGcFpCeWxUMVU3NERZUUxwdUwzelB6OVlKaGZjclptQnF6a3FyN1o4?=
 =?utf-8?B?TVJhU01NeUdRbjBVZm5lQ1R1dm1VMFF1RHdwbTA0ZTQ0bCtOek5CUExqcGdt?=
 =?utf-8?B?QWxnUTBEa0hpTGV5cnFlc1VnSjcxV1kyZVpLc0FncWgrbUg0cHQ1czdMNXF2?=
 =?utf-8?B?dy9rUG1UQ2lRTmhZT3R4K2F1VWRuQ0NLMnRhYjhzSWdkeVovMmtXa1h5RGNu?=
 =?utf-8?B?cmcyVU5XMCtKZEc3OWg2Mk8zci9WUnZIZGlBU1cycE9OdHJvcHJRVzNHOUxm?=
 =?utf-8?B?ejNBQlEvcTF2U0w1RXpXREJyUW90UWRQdU1YcENVOXBEYmdhc3ROT3hlSnFa?=
 =?utf-8?B?cVVoZlk1NC8rejBLZEJsbytYSTN0NFg4SkVSdVBkSE4xeU56UW5GZUR6NERM?=
 =?utf-8?B?dC9UVFE2aVFWeTBYQUR6Y2JKdTNJc1Jqc2REZWlaMzlwQ09qclltZFJCNEtY?=
 =?utf-8?B?SXBENDZzckkwcFRnRmN6WHM1UDJlN2VpRmIxOHNmZ1JZMG1JYlJRU295ekxF?=
 =?utf-8?B?YTErdHdVL1NVVjN6NzdRQnBDR05TOC9NWWhoQVZEZUhIZkR1RVRUUmZyNDVp?=
 =?utf-8?B?OXRDNnZaeW42emRpaitmbmFrUy85YnN3Y01LM0dPbk1OQjRIbjlJcEN5WGVh?=
 =?utf-8?B?c0l4SGlzeFFDSFFwSXhEK0R5K294Q3c1c1BJRVc1NmxhRUp1c1RUNUxIRVpj?=
 =?utf-8?B?N1hIZnFhaC9lbWdQUzVkMHNYYXM2RFF2VDZlSWtKSllNSU9SWkQ4Vk9IZDRT?=
 =?utf-8?B?MHZTakxYWUlUbndSK0VDOEwwZUlZYkNKRGdmbzRpaVdxdEtOZE5CQUd6S0xP?=
 =?utf-8?B?dm82dzZsWmYxR3FGU21vNGNTZURkU1ZBQ2M2TWs4OUEvUnhhVy9GRlVyTlJK?=
 =?utf-8?B?TE9paGpHb0syZEpveU5xUzFmQzhZdDFUZXU3Zm5Qc0FhR2g2ZWh4N1lFbDdq?=
 =?utf-8?B?K3o5M3V4RHM1WkR1TDUzYzRYMGNoV0VsUFdYMW8vOFN0Y3EwUk9iV0JhT21U?=
 =?utf-8?B?SWpoMzd4YWI4d0t0Y2tOdGlOUGo3TVE1QTI2Wm85TTVmYlJBMVhvNS80Smps?=
 =?utf-8?B?ZnM3RWlQV3BrK0JwUjh3eGpQczF2aEx6TWpSYkgzcTlSaU0zZU5reUN4dXkx?=
 =?utf-8?B?YzRRNFdDVndzUGYzSjJzakVIZHQvdlA2K3EzOVZacC9RY0lBZkljNUdhR0tW?=
 =?utf-8?B?Z29FVDdRdmFhdlRXWURSeTRMbVlUL2NiOWRDRGthc2Q4SHpKQ0Z2VHFjT2Jy?=
 =?utf-8?Q?3RVbDqDQ4J2xpwiic2Bee4cVQ7BAalxf?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cTIwVEdJNzltem84dEVRZHNxZW5saGM3TjNlS0NVM1NDaFA1RFZabmd6c3FS?=
 =?utf-8?B?V3FocEl6Y3JhaHlmS1lIRDVBYUZBRjRpMi9QdjAwbFRzQytkQkFuWU5Yc1Bp?=
 =?utf-8?B?UFR6Y25rY3Y1ajhYVkRjT0xVZFlmMDVnWGpaTWV4VU1lTDgrbFNHdk5wRnpC?=
 =?utf-8?B?QVBrbmNQbUJmWjZFTmlEbDFvaWpLckxZbkVvbTV0MkRCcjkyeENrZ2tnQTlI?=
 =?utf-8?B?YldoOWphUkE1emFVL1NkMElzY1o2MkRCOXJtRU9Vc3BNRlM1VjhCODlMVlBH?=
 =?utf-8?B?ZG1JTnk2dG0xTGxubmlEdW9PWXJWb3JKekk3RllPM1ExNUFCM2VkQTlFb0Jj?=
 =?utf-8?B?L2xNd2VVYzQ3WVlENDNNbkJwR3I0RzVUbUViTERhOXVsMzJBakt5OHVmTlY3?=
 =?utf-8?B?aG4xVVYxRE9ZOVZQZXJPWmp4R0ZHVEI2Tlp4Y2NaZUF6dWFMaU94a3lyNG1v?=
 =?utf-8?B?SG4xcUQvOStuTitXZnVNU1pLVjMyR2IvQ2RIVlRNUVYyZlpCZFROUWlUZGlo?=
 =?utf-8?B?UC91Wk1qYkxsaVFLMVJKWVprV1dzWHcyV1NIQ2RiQzRUVzc3MjBVMk0rY3Za?=
 =?utf-8?B?QmQyZWZSVmVnb0M3RDZVdFIxYVgza2xSOXhqUm00VURuMFVDUmxYbHhBQU8y?=
 =?utf-8?B?elhST09tTmpqY294d0VNN1R3R1g0SHZjWVpxM3dQTjlxc0NBV3A0S3BEYW5V?=
 =?utf-8?B?UnZ3WWsweTdaSkxlTzVvemtHVGY4WElDaXByNkNJQ1h1WG9Nc0VRMi9RYTVY?=
 =?utf-8?B?UUF6eGpOQlR6dFJhVHpxc1pWbGhTSFhLWC8yWFF5R2wzVGMxUFNSOUJkTm9i?=
 =?utf-8?B?aDU3UURvbmVacGcybU9WQmpLek5pcmx3Skd6SXQvbm5FYXp5UU1XNjQ1MkZj?=
 =?utf-8?B?QUlKTHluaFpxem92R205YUJ3Zkt2VTA5NXRURmVlcnI0ODZmVTFBbFV5VndF?=
 =?utf-8?B?aHc5eFlJMlhrU2Z5a1JxNm5hUXQxaWNKV3ZwWjJRN2loUXdGV01QdGJhZmJN?=
 =?utf-8?B?WGVPSm5ZaEx6eDN2N2lmbHcxcUF1Q21sVkFSUWtCNy91OXV1QTZVWitQU3JT?=
 =?utf-8?B?cWxFL0tTdGdHcEcyaXRIb1k4VkFBS2llNFFCbmxUNWZROFZna2VjdFYwZXBi?=
 =?utf-8?B?QXFRMTdpTXh4V1RwUnp1dFdVZFlvbVhSWjFYcGg2azZsbGF3b3FqL3VGdVdE?=
 =?utf-8?B?eDl3WXJ0Ny9GQjVNOVF6S1lwYTEreTBiV01DM1lvak5CeVNleFBYNjhzTHFC?=
 =?utf-8?B?WlZjUzhNbGNaNkRDdDdENGJtaGNOMDc3bVRpNzlZd2YxcVlyV0hqSDcwaTR0?=
 =?utf-8?B?cG0waWJSaTQvVmRlaHc2bXB1OWg1bndPR05hZVVveTFvQlU1bW1FLzg1WVl4?=
 =?utf-8?B?Q2hUVHVvRFNCTWp5cG9uQU9RNEVpeTBrWHVZMFZDS3pWK2pYdDk2T21RQlFx?=
 =?utf-8?B?d3Y5Unk5UXREU01ITTBEMVhKbG1aQjNLcHRIY21JcXZMTDAyY0FBWG5iSjRs?=
 =?utf-8?B?Z2N6eUo3aHJLbTdhck9Ia0J4WEpDZ2JBaUgzZm10aUlLSVJxSzluMEowMll6?=
 =?utf-8?B?Y0tZL2FRTnRjaDE4cEt1MUNkWGZZTzQ4blhtUVBzN0NxekxIT0lUWmpLd3M5?=
 =?utf-8?B?S25JZEprc1RtbTFlb0hZU01CeTFPem9tOERJTU1vYWNBVWc2TnBGM0tQL1p0?=
 =?utf-8?B?ejRPamJaN2NoZDFUUlgrRVVhekU2UUxaSjc2TkRob2dwSDJaT3lzb0Y0RWl3?=
 =?utf-8?B?VGhYS0p5RGtXY2l6VGdzaWpuTmdSMHdpNVlxeCtZNithSEtoVTVwbytUdjI1?=
 =?utf-8?B?a2ZmMTVxL1dxNmRKelVGMW0zaHJwUER3aGlaNEM4dlNidmpNQ3d6UlRHQkNX?=
 =?utf-8?B?cmt1a2xSMHZwSjM5TVA1SGo3aEVHWElxR2hjVldUWXRQbm1qZ215Rk45K1F2?=
 =?utf-8?B?Z204Ym85aE9EVDkyM0ZBL2pZWEdWNHBZUzNRbkFHcU93VVpwYkcyZ3pDbGtz?=
 =?utf-8?B?MkRFT01ZbTdaR2UvUGt2VjVRWnpuUDBsaTZ3V3hxZVhVa0pudkN6OUF2UzFy?=
 =?utf-8?B?SEU0QnR2SUFuZEZ6K3JFaHFMcXlrcnNnVHd0SzV5VUxoSitvblJOR2hRSEpv?=
 =?utf-8?B?ZjNERkZteFBRV2pQaWxaejdGYVArb1J2TEpFNk02d1QyQ3JlbVNGcEZ6WlpQ?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5803A1D732DCC48BD1DD0BC365C17A4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YPJPVDd/SW9BPpP25DtD2pGjzYbjvwUg/nree4hZ5tdDxB169k9LdPSH/w57DWWrb7lAmxy+omJ0Obyp0nsLwG9LleKxvVOToWofTGNL1GM9WtlHjSkvaEBhbYb5Pio1e0VHqc2Nak/neXTR4q6+vpHN6dunXK5+PrYF/EnRMPyOFMTji3OLRHx56UfS94x58OQjziqMb5e8QL0IghuZVEDwe7zHlU6vzhOy8XCoT6w5NNPvbA77JaNCXzMMIRGp9BP/mH+Qwn4Hx2GdKItnDYj7ql8RBbl1MSH9aJof9FJmne3o9aWMHRrhvJByox3ffj4TrU++rc3Pl8wxcCrUwqu8WDhNA86vpc6AxkhJnE/lwZnvlTRrQKE05Zk8Ni3CCPRkU8WuHVy+6QCkB27qvB/7BKm/JiaTSNA89b5iYD8bmQaCgoYHCzLz5e9x5wIwZH1MPAQ5f+mc6w/PaJWzm3dsMzBLhNcd5U0qbFU3i4crb/pZAr4paYBWEmNshxiq286isodDWHRWUohz3GuhQL/NX87V6Kz+28d8VCejso3EHFRgUyvy6XF0zXDB42cFNftfG0sHE37vxg2nNjYmZrZypDwyc4LQyAyyIVwFZA0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46cc3ed-5c82-4be7-abb3-08dd2c4edc35
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2025 23:32:16.9887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2RyNlSUzMQdWJ45EXao4wXZ4cHGiBDmslREqi88SbBn8HMVESG0E5tjeudioJUtuhv6aS1oewJDq/wd7MOQbgObpC6m3HYSbsR0UE9V9rUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4858
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501030208
X-Proofpoint-ORIG-GUID: H-uYjzUiGycZzPn9JYZ_yGRNcq37zw30
X-Proofpoint-GUID: H-uYjzUiGycZzPn9JYZ_yGRNcq37zw30

DQoNCj4gT24gRGVjIDI0LCAyMDI0LCBhdCAxMDo0M+KAr0FNLCBNaW1pIFpvaGFyIDx6b2hhckBs
aW51eC5pYm0uY29tPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgMjAyNC0xMC0xNyBhdCAwOTo1NSAt
MDYwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+IEludHJvZHVjZSBhIG5ldyBMU00gY2FsbGVk
IGNsYXZpcy4gIFRoZSBtb3RpdmF0aW9uIGJlaGluZCB0aGlzIExTTSBpcyB0bw0KPj4gcHJvdmlk
ZSBhY2Nlc3MgY29udHJvbCBmb3Igc3lzdGVtIGtleXMuICBUaGUgYWNjZXNzIGNvbnRyb2wgbGlz
dCBpcw0KPj4gY29udGFpbmVkIHdpdGhpbiBhIGtleXJpbmcgY2FsbCAuY2xhdmlzLiAgRHVyaW5n
IGJvb3QgaWYgdGhlIGNsYXZpcz0gYm9vdA0KPj4gYXJnIGlzIHN1cHBsaWVkIHdpdGggYSBrZXkg
aWQgY29udGFpbmVkIHdpdGhpbiBhbnkgb2YgdGhlIGN1cnJlbnQgc3lzdGVtDQo+PiBrZXlyaW5n
cyAoYnVpbHRpbiwgc2Vjb25kYXJ5LCBtYWNoaW5lLCBvciBwbGF0Zm9ybSkgaXQgc2hhbGwgYmUg
dXNlZCBhcw0KPj4gdGhlIHJvb3Qgb2YgdHJ1c3QgZm9yIHZhbGlkYXRpbmcgYW55dGhpbmcgdGhh
dCBpcyBhZGRlZCB0byB0aGUgQUNMIGxpc3QuDQo+PiANCj4+IFRoZSBmaXJzdCByZXN0cmljdGlv
biBpbnRyb2R1Y2VkIHdpdGggdGhpcyBMU00gaXMgdGhlIGFiaWxpdHkgdG8gZW5mb3JjZQ0KPj4g
a2V5IHVzYWdlLiAgVGhlIGtlcm5lbCBhbHJlYWR5IGhhcyBhIG5vdGlvbiBvZiB0cmFja2luZyBr
ZXkgdXNhZ2UuICBUaGlzDQo+PiBMU00gYWRkcyB0aGUgYWJpbGl0eSB0byBlbmZvcmNlIHRoaXMg
dXNhZ2UgYmFzZWQgb24gdGhlIHN5c3RlbSBvd25lcnMNCj4+IGNvbmZpZ3VyYXRpb24uDQo+PiAN
Cj4+IEVhY2ggc3lzdGVtIGtleSBtYXkgaGF2ZSBvbmUgb3IgbW9yZSB1c2VzIGRlZmluZWQgd2l0
aGluIHRoZSBBQ0wgbGlzdC4NCj4+IFVudGlsIGFuIGVudHJ5IGlzIGFkZGVkIHRvIHRoZSAuY2xh
dmlzIGtleXJpbmcsIG5vIG90aGVyIHN5c3RlbSBrZXkgbWF5DQo+PiBiZSB1c2VkIGZvciBhbnkg
b3RoZXIgcHVycG9zZS4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogRXJpYyBTbm93YmVyZyA8ZXJp
Yy5zbm93YmVyZ0BvcmFjbGUuY29tPg0KPj4gLS0tDQo+PiBEb2N1bWVudGF0aW9uL2FkbWluLWd1
aWRlL0xTTS9jbGF2aXMucnN0ICAgICAgfCAxOTEgKysrKysrKysrKysrKysrKysrDQo+PiBNQUlO
VEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDcgKw0KPj4gY3J5
cHRvL2FzeW1tZXRyaWNfa2V5cy9zaWduYXR1cmUuYyAgICAgICAgICAgIHwgICA0ICsNCj4+IGlu
Y2x1ZGUvbGludXgvbHNtX2NvdW50LmggICAgICAgICAgICAgICAgICAgICB8ICAgOCArLQ0KPj4g
aW5jbHVkZS9saW51eC9sc21faG9va19kZWZzLmggICAgICAgICAgICAgICAgIHwgICAyICsNCj4+
IGluY2x1ZGUvbGludXgvc2VjdXJpdHkuaCAgICAgICAgICAgICAgICAgICAgICB8ICAgNyArDQo+
PiBpbmNsdWRlL3VhcGkvbGludXgvbHNtLmggICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0K
Pj4gc2VjdXJpdHkvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEwICst
DQo+PiBzZWN1cml0eS9jbGF2aXMvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgfCAgIDEg
Kw0KPj4gc2VjdXJpdHkvY2xhdmlzL2NsYXZpcy5jICAgICAgICAgICAgICAgICAgICAgIHwgIDI2
ICsrKw0KPj4gc2VjdXJpdHkvY2xhdmlzL2NsYXZpcy5oICAgICAgICAgICAgICAgICAgICAgIHwg
ICA0ICsNCj4+IHNlY3VyaXR5L2NsYXZpcy9jbGF2aXNfa2V5cmluZy5jICAgICAgICAgICAgICB8
ICA3OCArKysrKystDQo+PiBzZWN1cml0eS9zZWN1cml0eS5jICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgMTMgKysNCj4+IC4uLi9zZWxmdGVzdHMvbHNtL2xzbV9saXN0X21vZHVsZXNfdGVz
dC5jICAgICB8ICAgMyArDQo+PiAxNCBmaWxlcyBjaGFuZ2VkLCAzNDYgaW5zZXJ0aW9ucygrKSwg
OSBkZWxldGlvbnMoLSkNCj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2FkbWlu
LWd1aWRlL0xTTS9jbGF2aXMucnN0DQo+PiBjcmVhdGUgbW9kZSAxMDA2NDQgc2VjdXJpdHkvY2xh
dmlzL2NsYXZpcy5jDQo+PiANCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1
aWRlL0xTTS9jbGF2aXMucnN0IGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9MU00vY2xhdmlz
LnJzdA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uMGU5
MjRmNjM4YTg2DQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2FkbWlu
LWd1aWRlL0xTTS9jbGF2aXMucnN0DQo+PiBAQCAtMCwwICsxLDE5MSBAQA0KPj4gKy4uIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+PiArDQo+PiArPT09PT09DQo+PiArQ2xhdmlz
DQo+PiArPT09PT09DQo+PiArDQo+PiArQ2xhdmlzIGlzIGEgTGludXggU2VjdXJpdHkgTW9kdWxl
IHRoYXQgcHJvdmlkZXMgbWFuZGF0b3J5IGFjY2VzcyBjb250cm9sIHRvDQo+PiArc3lzdGVtIGtl
cm5lbCBrZXlzIChpLmUuIGJ1aWx0aW4sIHNlY29uZGFyeSwgbWFjaGluZSBhbmQgcGxhdGZvcm0p
LiBUaGVzZQ0KPj4gK3Jlc3RyaWN0aW9ucyB3aWxsIHByb2hpYml0IGtleXMgZnJvbSBiZWluZyB1
c2VkIGZvciB2YWxpZGF0aW9uLiBVcG9uIGJvb3QsIHRoZQ0KPj4gK0NsYXZpcyBMU00gaXMgcHJv
dmlkZWQgYSBrZXkgaWQgYXMgYSBib290IHBhcmFtZXRlci4gIFRoaXMgc2luZ2xlIGtleSBpcyB0
aGVuDQo+PiArdXNlZCBhcyB0aGUgcm9vdCBvZiB0cnVzdCBmb3IgYW55IGFjY2VzcyBjb250cm9s
IG1vZGlmaWNhdGlvbnMgbWFkZSBnb2luZw0KPj4gK2ZvcndhcmQuIEFjY2VzcyBjb250cm9sIHVw
ZGF0ZXMgbXVzdCBiZSBzaWduZWQgYW5kIHZhbGlkYXRlZCBieSB0aGlzIGtleS4NCj4+ICsNCj4+
ICtDbGF2aXMgaGFzIGl0cyBvd24ga2V5cmluZy4gIEFsbCBBQ0wgdXBkYXRlcyBhcmUgYXBwbGll
ZCB0aHJvdWdoIHRoaXMga2V5cmluZy4NCj4+ICtUaGUgdXBkYXRlIG11c3QgYmUgc2lnbmVkIGJ5
IHRoZSBzaW5nbGUgcm9vdCBvZiB0cnVzdCBrZXkuDQo+PiArDQo+PiArV2hlbiBlbmFibGVkLCBh
bGwgc3lzdGVtIGtleXMgYXJlIHByb2hpYml0ZWQgZnJvbSBiZWluZyB1c2VkIHVudGlsIGFuIEFD
TCBpcw0KPj4gK2FkZGVkIGZvciB0aGVtLg0KPiANCj4gVW50aWwgdGhlIHNpbmdsZSBrZXkgaGFz
IGJlZW4gbG9hZGVkLCBDbGF2aXMgaXMgbm90IGVuYWJsZWQuICBBbnkga2V5IG9uIHRoZQ0KPiBz
eXN0ZW0gdHJ1c3RlZCBrZXlyaW5ncyByZW1haW5zIHVzYWJsZSBmb3IgYW55IHB1cnBvc2UuDQo+
IA0KPiAtPiBXaGVuIGVuYWJsZWQsIG1lYW5pbmcgdGhlIHNpbmdsZSBrZXkgaGFzIGJlZW4gbG9h
ZGVkIG9udG8gdGhlIENsYXZpcyBrZXlyaW5nLA0KPiBhbGwgc3lzdGVtIGtleXMgYXJlIHByb2hp
Yml0ZWQgLi4uDQo+IA0KPiBVbnRpbCBjbGF2aXMgaXMgZW5hYmxlZCwgaW4gbXkgb3BpbmlvbiB0
aGUgZGVmYXVsdHMgc2hvdWxkIGJlIHJlc3RyaWN0aXZlIChlLmcuDQo+IENPTkZJR19JTlRFR1JJ
VFlfQ0FfTUFDSElORV9LRVlSSU5HLA0KPiBDT05GSUdfU0VDT05EQVJZX1RSVVNURURfS0VZUklO
R19TSUdORURfQllfQlVJTFRJTikuIE9uY2UgQ2xhdmlzIGlzIGVuYWJsZWQsDQo+IGJhc2VkIG9u
IGEgbmV3IGhlbHBlciBmdW5jdGlvbiBpc19jbGF2aXNfZW5mb3JjZWQoKSB3ZSBjb3VsZCBjb25z
aWRlciByZWxheGluZw0KPiBzb21lIG9mIHRoZSBleGlzdGluZyBrZXlyaW5nIHJlcXVpcmVtZW50
cyAoZS5nLiBrZXJuZWwgbW9kdWxlcykuDQoNCklmIEkgbWFkZSB0aGlzIGNoYW5nZSwgd291bGQg
aXQgYmUgYWNjZXB0YWJsZSB0byB1cGRhdGUgdGhlIEtjb25maWcgDQpkZXNjcmlwdGlvbiBmb3Ig
Q09ORklHX0lOVEVHUklUWV9DQV9NQUNISU5FX0tFWVJJTkcgYW5kIENPTkZJR19TRUNPTkRBUllf
VFJVU1RFRF9LRVlSSU5HX1NJR05FRF9CWV9CVUlMVElOIA0KdGhhdCB0aGUgcmVzdHJpY3Rpb24g
b25seSBhcHBsaWVzIHdoZW4gQ2xhdmlzIGlzIG5vdCBlbmFibGVkPyAgWW91IGRvbid0IA0KdGhp
bmsgdGhlcmUgd291bGQgYmUgcHVzaCBiYWNrIHRoYXQgdGhvc2UgcmVzdHJpY3Rpb25zIGFyZSBu
b3QgYWx3YXlzIA0KYmVpbmcgZW5mb3JjZWQ/DQoNCg0K

