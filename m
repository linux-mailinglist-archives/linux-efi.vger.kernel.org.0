Return-Path: <linux-efi+bounces-2501-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE05A01102
	for <lists+linux-efi@lfdr.de>; Sat,  4 Jan 2025 00:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D6418812FB
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jan 2025 23:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7147A1AD3E5;
	Fri,  3 Jan 2025 23:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fZJE58zb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dNFQswYW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9D655896;
	Fri,  3 Jan 2025 23:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735946913; cv=fail; b=AEAxgiPN+Ry7pbDIG8I7sKXkmSy0Po0R3tUfV5cojFPy2Az6qkDtZklBZT1HBew7ptcQsjRACtYb3XPBt/oT7VxRUMsOv81PXMlHI8D1TXXjUAz+U3ZJQmK7nBRMVzy+oyndXx4dMQ5QbmHzrgLVw4O8+aerB7k8prJxbfMxk+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735946913; c=relaxed/simple;
	bh=G4S2BLcCEO2xOdmfmQZTMRCkhqJQ1CheP5bYrHhsZa4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KVaDLsvj+gl/q2y84Ty3qRlsux/G/HY+1ekkZTYJD3z9CMmnPVwNI+IFIl9Ekb0gutR+J5uPeYqbqd+JQ73StqBDifYbXHj3gVgHftUCT6MtFz5GkEy/Ptx7B/iVfQSmaO73nCRzJSSivs5mSpzgzs56Im2sysb0D1ScNQ5vv7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fZJE58zb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dNFQswYW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 503Id3QD013106;
	Fri, 3 Jan 2025 23:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=G4S2BLcCEO2xOdmfmQZTMRCkhqJQ1CheP5bYrHhsZa4=; b=
	fZJE58zbTlEMdDc7OhssNX+iJIEgYoEOFYlhU+34dN9ohnQdCd2g8F5xU3DT1jAR
	7OavRKYablI8aN6KkN/Bi6BGQDsyi3cPgm+7/2AYt24mkQ2Cwe81hLujlo5zzftc
	CIfHv6mAChvySr99x8OC3RxGDpTIdyI19zarOdS5rLj6MjAMuWks5RECge38+q5a
	s9dCUT3wlZpU+mknyNdhXr9cx58nzIqesjLfMqUot2ql5LVagG6ST181O89nvNKD
	aHqTIfijddFGQJyB7avTTAs5PXwUmu33uMoyadGSCMLYm7H7yfuUeeOoNOqkCJxG
	bwZMtefUBEKfy9e12CUchA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t7rc0va3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 23:28:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 503KRVig027497;
	Fri, 3 Jan 2025 23:28:09 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43vry387bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 23:28:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OuH2Rg1xGYV7XdHy0cjO9K2KiV5z+wOhL8iMdfK36ZLcrMrVqToGTXZZvMrgjx61Shsyp+QoeiNwjzQ5zQlykO9nRfVpe6P7TB1yNqscqVSe1pisgXbB+2AjmECXi70vuUsQhZB+1PJJoL+VtTdBdzW0T5fx/4a+jE80dVyR01sGS2ssV1TaGzMwgThR41GmGkBtMOcLv2k+1NUThPeBs6+TY1LuGxauAdoh4PdbOC530zsLVagBJL0ehgcVpHDLPg396nfbcs/gFb+QuJqmo4L9doMeELeO6w7K5RpPoFwx50C/gIQFoBHQ9+m3mw1Bnq/gyKR5qbYdx+okYDwTMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4S2BLcCEO2xOdmfmQZTMRCkhqJQ1CheP5bYrHhsZa4=;
 b=Wf1oGxq6elQLYJgL+hSflO+eT3wKAx+kPKZRRYD7IfC/zeymRewBQoDI5dGjGvyp6tu3opyiweCdQ+/KgUYA2V1e0i6zqK/oYzOpYwVMSijJGugSv+OwZqYoYKgk0XdKfdHT+KTGB4zRXQpBJWpA3vLSH+YuYtXBRJNoLNc4oUBw2Bnlexvw8Gse4p40MmJaLzn1rvvBWhjvDrmE22wmVTcXEOY2cuCZOW6PmPDAA8EUlM/JTdUzyVmKtD5wkfR9RdkU7Ku6FPs7v1CTGedp9IOGIYt02rUkpb36uZB5JStdySuG5ZGj3cayTreKBIwJZName5tu+mPIyRqYXnpmEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4S2BLcCEO2xOdmfmQZTMRCkhqJQ1CheP5bYrHhsZa4=;
 b=dNFQswYWDE1OjCJUc0hDLLQ4J8xEd5bWc5JcvKwKTpwJLbJuBcdniI48vwCdM2Uwt9NbYc56uzb202LfNmUuJjkfBJ6q8xDgJLA1JkfSdmb8FJKleC7tT08l00/cYFidJ1I1jmy9CS+5vWbMwYzFlI3TOeKg0usvwKWElGkkh4I=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 23:28:03 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%7]) with mapi id 15.20.8293.000; Fri, 3 Jan 2025
 23:28:03 +0000
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
Subject: Re: [RFC PATCH v3 04/13] keys: Add new verification type
 (VERIFYING_CLAVIS_SIGNATURE)
Thread-Topic: [RFC PATCH v3 04/13] keys: Add new verification type
 (VERIFYING_CLAVIS_SIGNATURE)
Thread-Index: AQHbIK0JFPRRNg0utke6tqHI/Bzp27L08PUAgBE784A=
Date: Fri, 3 Jan 2025 23:28:03 +0000
Message-ID: <089BFB7E-0FDD-4C2F-8055-BC79A31048E9@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <20241017155516.2582369-5-eric.snowberg@oracle.com>
 <12e2743cfe0c05c613a622ea52a126f48368b896.camel@linux.ibm.com>
In-Reply-To: <12e2743cfe0c05c613a622ea52a126f48368b896.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|CH0PR10MB4858:EE_
x-ms-office365-filtering-correlation-id: 36e672e4-1d21-443b-f594-08dd2c4e4505
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QUhvNkFiKys5aGN6SnAxaGNuVmdESEYwT3dQQjdETGVuNU9ZV3dxbHM4R1cy?=
 =?utf-8?B?T2hKbmZtT3YwbkZsUTRrUUowUGV0OUV3b3cwR3ZqbnErZFdFT1BKaXkwZmdY?=
 =?utf-8?B?a3JvRXBNbjd5eE5CeFFOeEFVMkprcXEvSG9Ockp1ZVREczlsWVBEOFZLNThW?=
 =?utf-8?B?RW4zSEZQL0I4TGE2TlVONk5pRXliVEtUWDFhcERYRXVwY2IzUDZETVJBMnVa?=
 =?utf-8?B?QVcxZjJkSS9HWTZPbW5obHB1eURBT3daUEJvajZucmtSV1dtWmt1czV1NExi?=
 =?utf-8?B?aG5DTTF1TTdnR0RaUWt6N0FQb2JmNThjY2pqbk81R0lpek50U3AyN0FMZDdu?=
 =?utf-8?B?M0Izd3pBY0VhTzFmZlZtNU5FSmVoVVhkN1lkK0hIVlZuRWZxSnJMWkM1akRR?=
 =?utf-8?B?UDh1WGkvQWJRSVJ2OXc0bjdVdzBnWUNzbUZOTklqanJySEdWT0hLalFiNSt3?=
 =?utf-8?B?ck9vWmN5R1JiOW1aSHlJV21DTFBYMlV4Unk5S0dmMTM1enpnL0tTY2t3NXFV?=
 =?utf-8?B?NmxIUEgyREdwR2pyQlZQNDd4V2k2Q1VYS1ZMMUVjaHFnNUp4SWlpK0pqVnFP?=
 =?utf-8?B?d1BzTGN6bGNkY09SV2puNDBtTFF2cTZJTkFYdUw4d01DaWVYczBsMTJDRWI4?=
 =?utf-8?B?cmovdTNHZFhoeVgybjNOZUY2OFhXM1l2N2RNNTJoTU5TYU9hUnR4RWpQL2p1?=
 =?utf-8?B?ZUFHMHRqL0J6eTFSWXVLalluYkhvcS8xT2FxemQ0SWJ2R29haHlINTIvakpD?=
 =?utf-8?B?WjdqU05LQ1FkbnhEdFBKS0tScVREOFZZd3h0Z0loOGtZc3RsNS91cWladE10?=
 =?utf-8?B?cDhVRDB0S081VWhzcWt1a1djUjhOazd5bWwzVks5QjdIaXQ4ZWpBRDJ0Ukxu?=
 =?utf-8?B?cWRZdFJhTTVQbTFHb01VUGdUZnRPcXJMb0FTTmhGYzZKcXBaWFd5cEE1SmtP?=
 =?utf-8?B?WnowTEhnS1JSWWg1ZjFWNHNSVEFwQWtvbCtHaHVqK0FRY0hZY1duM2FUUGNp?=
 =?utf-8?B?a2UxN3Jqdm9FeXk5WUhIMWtvU2U4d1kvbHVQRVcyZzRvWkxXcS9sNGlNK1dM?=
 =?utf-8?B?dU5pb01GSkk3aGRjZU5ZNVZ1bTEvWnN5TVBkMkI5Z0JnODcrOWFHeHFFWkRU?=
 =?utf-8?B?UDZOOUdzblp2aDVvd1dMYnkvRFdRelREcTBJb0EyN3hJUUQ2UGQxQmJ6aUlB?=
 =?utf-8?B?amExQUtqcGVGWEdJTlN1MXVSZ0Vrak1WSmFaelZNdkg0SkNFbGtuWUpQanN3?=
 =?utf-8?B?QkpSdnAyekFCbm5YeVJ2MklocjZRR2kvK3Q0UUxDYndDNTJZRGlwd1JiU1kv?=
 =?utf-8?B?cnNyU1d1d00zUVJLNk9vUDVHaXpxL3hQNW1BZUxpZndlUlBaT002NFhwYUJG?=
 =?utf-8?B?M01ldWFvMmxPZHZiOGhZTUpjYVBXSDhCL3BybEJmYVBZTjFDVVNGeWMrdFN5?=
 =?utf-8?B?WHJJTXdmbWZ6Y0JmNFBYZ2lEWGJXQmIrVlIrVUJvSlpJbWwyNTB6THJVS2VP?=
 =?utf-8?B?RVg0ZkpHMGhpOHlOYVptVHBFUVRPUUJQT010dzVFVGdoNkxCaFZnaEF4aDJQ?=
 =?utf-8?B?a3pIYkhvSk9wM0poOWlDZGcrYXN2ZzBXVldIK3ZxWjY2MkVZN0pzcCtCb0RY?=
 =?utf-8?B?UmNyUXNYd3FoZ053bndnL0RqbVQvbmExY2MrbjBreVVGWEpycHZoV2VQL2Fw?=
 =?utf-8?B?MkdHSWx3VWhxVEFGZU9ta3RKbHNoV0xWZUIySCtZeDd1MFJ3ZUFYaWh0K3JX?=
 =?utf-8?B?cEMxckgwaVY4Vk1kdm5PNklLMEpVcHNveTliOExFZW5TQjN5QUx0WElPWXRF?=
 =?utf-8?B?OHIwaG5vZm8xaUt0U3R6N202YktyamppNTlxZDI0dHY0UWRZMUNyaVh4K045?=
 =?utf-8?B?elNPazdLNDk1QlBQZHhTNkVsUDMvTGdGZzREeWtTQkVMTWxESVJKM05tdWl4?=
 =?utf-8?Q?G/OGMGgjEmTKWte7u4VjJzubParyacu2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?djR6N3VoTGxYdWQrVmNGeWpKNXFBaTV2ckdHMm1KYnNEWE1FRitMam52a0Rk?=
 =?utf-8?B?SWNXekRQNWdFUzFzdjJRSFhnY2QvaUZsTmxJSCtwUUF6OGluMFgwcm40U2Jv?=
 =?utf-8?B?RUo0cWoxS2U2UFFuSUtNWVFsTFpsaDlTZUlwYnp6Qm9YQ2lJOWlxUUVlTFM5?=
 =?utf-8?B?VlErMjdFbFEzTE5RQUMxSFZkelhxV1hydVRxS3BtS2lFR1c2MlN6Q2hkUWZE?=
 =?utf-8?B?NjREQWRyNytvSmZuNTdUbHJCa0xvdlpGeTduVnd3TlVPc3p3UjA3RVRxVWJF?=
 =?utf-8?B?WjByQWhvYXBRZjd2MkRicG9iTm8wQklkY0ltMk5sNUx1ZTEvQnhmdnZiVU9t?=
 =?utf-8?B?UHhsZFVybDV4NUVLK05YZk0wdTNCKzJZa1V1dUlTcWltVWlhbHR5cFo1MUlX?=
 =?utf-8?B?ZUQ4SFQxSzMyKzN3WnYvN0s5Z3cyUTlRTUsvZGU1SzFkbVppdG9VSFNhekw5?=
 =?utf-8?B?a2c0cTFocDVRNnpSMVV6K20wQkh0YmJhb2N4VWV3c0dGRUdCaFlJRXR1TFpt?=
 =?utf-8?B?QVBCaVhFTVp4dGQ1MVFON1RRYnl3b0F0VzdnZTF2dEJyU1JqMXpMVzlGZWxB?=
 =?utf-8?B?NlJ4OWwxdU1WUXVvd0xCV21IaWprd0poWEIwc090c09QYzJSbWNnenZBeG4x?=
 =?utf-8?B?a3RNb3g3ZFJKOW1OenlrRTZndWdOL1kwRWdFTFhwN3JMbEJQU1VEV3o4Skcv?=
 =?utf-8?B?cHNZbU15alBrRjVCZXJzdFFqdXpNSVU4WWRkbjQzRW1KcDVZK1l3MEpDbndR?=
 =?utf-8?B?NVIxeXBrMEhqa1ZrSCtWS1BueHd1QmpNSWwwT2NIYmMwTHNpdGRHYjZmZnh6?=
 =?utf-8?B?Mm1CaXdsT1NIcHBiRGZMeDRJdGgweVpXdHBwaEZlaXdsRk5NQ04xUFpMWndS?=
 =?utf-8?B?ZEZ6VWFSZHlycUJpY2E0bEdYWFRsQmw3K21Od0tER1RPUXpaakx6YWovVjdk?=
 =?utf-8?B?MllLRzlQQVM5K3BLM1lXREtxUFdxSy9VcUJxSHBaOC9qb0tINzd2ZWRiaXA5?=
 =?utf-8?B?QTBRMHFWWlNqWXJIdk5FaWxhVS8rcXVKckN4anE2ZWxRMXc1ekFXOUFkNzEw?=
 =?utf-8?B?aE9CKzJPM0RVTmZIcVVUOWFkL3NnU0tISWs4U1crNlBLaVJJUFA2WHhib0dR?=
 =?utf-8?B?SlVFaytSMTBqcVdDdk4xNXpKTEpvdFMzeTE2UC83bHFlK3U2dC9kejVIQi95?=
 =?utf-8?B?em1rWDd5ZXVpbStqclhyc0d3MUdMS2djSjZ4Q0ZiaFJlaGgzTHhkY3FWNW9r?=
 =?utf-8?B?QVFCcVVSZ1NCb3Z2clUvajdUVHhuNHBaTFArUG4rUlFiUjlzQzgvMTUvYXFN?=
 =?utf-8?B?RFBydFcyRHpDZERlMDZvN0VwRjZUeVBlSVljWUcvdHZTbUkrOUE4NTdLSGll?=
 =?utf-8?B?K2s2VWZleHJmN0lBbTFjTk05YmxsVGdwUENKRitVakliU1VBR2paRGYwcThR?=
 =?utf-8?B?ODNOVlBDVmhVQ0ZrNmhjUXF0dnUxR3psVUExcFMvRGZnRFVuZVhaRXpsVGk5?=
 =?utf-8?B?bkQvVTdNVDhQc2lMZVVTYUhOSnNUcXZYNWsyWWp2R0JjRGhweVFPTXZrU2tk?=
 =?utf-8?B?OFhzZ01rVmZIWXptSmYxa0tDS0tMTlVxWUN5UnpEWEdOYzR4bEFHaVFHaHVz?=
 =?utf-8?B?cWJrT1dtZ1NIbWtMM01DT24rd0o3aVhOMDBTTktqQTVDMU0rd25mS2ZNRmFN?=
 =?utf-8?B?am15azBjNUtjRnpOSmR1OWVJZDJBbnZjOFlraVVrMHJnQ2srckZ5Q0lPSHZq?=
 =?utf-8?B?TWE1TTFPWk5Kb1JwMjl2a1R3MmZhd0g1N2RhbzJCakV1ZDVrbkw3ekQvV2Nx?=
 =?utf-8?B?N29qd0NyQ3dzVnFSOFJ1Vzk0UnVRL015cWE5dGpRcUdLTVhNaXBaSEhmQUdz?=
 =?utf-8?B?T3FNdzIzMG5hNTk5UkRvcTdtNUJZR0tyZUdOK05IU0dmUEgvLysyYXBoNjNs?=
 =?utf-8?B?c1pPYkpmM09ZdVNQN0ZRdmh4TDQ3R1pRb2hBdHlXWHdKYnRicVVrMWFoY0Ja?=
 =?utf-8?B?dmc3dDR1RWxKQS9oam5QR1lhK3lkeEw1RlhJWVdLTmUzSmIyTzQwRjFGRGJz?=
 =?utf-8?B?RXFaVld6MHVkZmQvTVRuWGxwSlIxdTloN2VmbG9hQjRHdmxLeXlUcWRydENk?=
 =?utf-8?B?cXJwbEo5SkI5NVlQelhEMXBad0crRW05L292UG5qajNBSFNPTmlzU0VQVXVD?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD88A83D410D0647992199C15777E73B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	thzBJdvVYD0b1nVqA0Qilo1k17ye3NysvRl6wcrt5xyfwwb5mEuUlPy5vqmZAjqRydhgIch6t4itnK2FewcaK2YVgWo8/PMtmG3KXTI9BINvWc3pB7xduBrFC8CZfvALYxe2T3kIvgAlOh8U7dVsfDm4TSiYu2eiyENSHd/xpb9XlC4GgVVKQHOwKr+tX+awFwZhb0AnaAVfA73k5Ur+vUY0ycj/nl6UqDJFj9r4ITZUYLYL68dwKhQU6yo6OpWvJyQcYnIQyJxNgeLjB0+cdHI5cwB/9/L9VEamvWuYGmPuVg1ndX4eLRznv/SC6v/Y/HiQAxRxj0pqShtEpR8StUm7xgN+p3Xeo/7u6yewmQ2KP4FLYrdH+ZzYolsVcmk2WetjKnQYoBe6MgBGbJbxo5do7RrQr4O1FeB8aILrGMxkqFnhxMmdd8xGhmDNONppAjUR57xG1zqn7eFZxQHeYANQJkDFB54+LPoBTB50Yf8PpHajLigz4e2o8CY7VY8kGRxPc1NQvn+GdL3cGoaqaDg+cf44HMR1KoVcEO19sXRsjPaaG7TDUBfi0AbAttJy1vjjhc6c6j2cH11EfFpJIdD4FR2RhyyDUcK7+J0XgKI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e672e4-1d21-443b-f594-08dd2c4e4505
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2025 23:28:03.3504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jKG9c4s8YJMzh5c5r6/L6S9QtROMFWF/H1u48BzR4oWZr0dXafOzcVJxcLe+6RvxDalg7FUKAZK/XPkksIND7HLmoDCK5CDH1TQbNbqs53Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4858
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501030208
X-Proofpoint-ORIG-GUID: 4scsTz7s4T3g4OBch31tAS5vXfNiEgO6
X-Proofpoint-GUID: 4scsTz7s4T3g4OBch31tAS5vXfNiEgO6

DQoNCj4gT24gRGVjIDIzLCAyMDI0LCBhdCA1OjE34oCvUE0sIE1pbWkgWm9oYXIgPHpvaGFyQGxp
bnV4LmlibS5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCAyMDI0LTEwLTE3IGF0IDA5OjU1IC0w
NjAwLCBFcmljIFNub3diZXJnIHdyb3RlOg0KPj4gQWRkIGEgbmV3IHZlcmlmaWNhdGlvbiB0eXBl
IGNhbGxlZCBWRVJJRllJTkdfQ0xBVklTX1NJR05BVFVSRS4gIFRoaXMgbmV3DQo+PiB1c2FnZSB3
aWxsIGJlIHVzZWQgZm9yIHZhbGlkYXRpbmcga2V5cyBhZGRlZCB0byB0aGUgbmV3IGNsYXZpcyBM
U00ga2V5cmluZy4NCj4+IFRoaXMgd2lsbCBiZSBpbnRyb2R1Y2VkIGluIGEgZm9sbG93LW9uIHBh
dGNoLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBFcmljIFNub3diZXJnIDxlcmljLnNub3diZXJn
QG9yYWNsZS5jb20+DQo+PiAtLS0NCj4+IGNyeXB0by9hc3ltbWV0cmljX2tleXMvYXN5bW1ldHJp
Y190eXBlLmMgfCAxICsNCj4+IGNyeXB0by9hc3ltbWV0cmljX2tleXMvcGtjczdfdmVyaWZ5LmMg
ICAgfCAxICsNCj4+IGluY2x1ZGUvbGludXgvdmVyaWZpY2F0aW9uLmggICAgICAgICAgICAgfCAy
ICsrDQo+PiAzIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPj4gDQo+PiBkaWZmIC0t
Z2l0IGEvY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy9hc3ltbWV0cmljX3R5cGUuYyBiL2NyeXB0by9h
c3ltbWV0cmljX2tleXMvYXN5bW1ldHJpY190eXBlLmMNCj4+IGluZGV4IDQzYWY1ZmE1MTBjMC4u
ZDdiZjk1Yzc3ZjRhIDEwMDY0NA0KPj4gLS0tIGEvY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy9hc3lt
bWV0cmljX3R5cGUuYw0KPj4gKysrIGIvY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy9hc3ltbWV0cmlj
X3R5cGUuYw0KPj4gQEAgLTI1LDYgKzI1LDcgQEAgY29uc3QgY2hhciAqY29uc3Qga2V5X2JlaW5n
X3VzZWRfZm9yW05SX19LRVlfQkVJTkdfVVNFRF9GT1JdID0gew0KPj4gW1ZFUklGWUlOR19LRVlf
U0lHTkFUVVJFXSA9ICJrZXkgc2lnIiwNCj4+IFtWRVJJRllJTkdfS0VZX1NFTEZfU0lHTkFUVVJF
XSA9ICJrZXkgc2VsZiBzaWciLA0KPj4gW1ZFUklGWUlOR19VTlNQRUNJRklFRF9TSUdOQVRVUkVd
ID0gInVuc3BlYyBzaWciLA0KPj4gKyBbVkVSSUZZSU5HX0NMQVZJU19TSUdOQVRVUkVdID0gImNs
YXZpcyBzaWciLA0KPj4gfTsNCj4+IEVYUE9SVF9TWU1CT0xfR1BMKGtleV9iZWluZ191c2VkX2Zv
cik7DQo+PiANCj4+IGRpZmYgLS1naXQgYS9jcnlwdG8vYXN5bW1ldHJpY19rZXlzL3BrY3M3X3Zl
cmlmeS5jIGIvY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy9wa2NzN192ZXJpZnkuYw0KPj4gaW5kZXgg
ZjBkNGZmM2MyMGE4Li4xZGM4MGU2OGNlOTYgMTAwNjQ0DQo+PiAtLS0gYS9jcnlwdG8vYXN5bW1l
dHJpY19rZXlzL3BrY3M3X3ZlcmlmeS5jDQo+PiArKysgYi9jcnlwdG8vYXN5bW1ldHJpY19rZXlz
L3BrY3M3X3ZlcmlmeS5jDQo+PiBAQCAtNDI4LDYgKzQyOCw3IEBAIGludCBwa2NzN192ZXJpZnko
c3RydWN0IHBrY3M3X21lc3NhZ2UgKnBrY3M3LA0KPj4gfQ0KPj4gLyogQXV0aGF0dHIgcHJlc2Vu
Y2UgY2hlY2tlZCBpbiBwYXJzZXIgKi8NCj4+IGJyZWFrOw0KPj4gKyBjYXNlIFZFUklGWUlOR19D
TEFWSVNfU0lHTkFUVVJFOg0KPiANCj4gQWRkICJmYWxsdGhyb3VnaDsiDQo+IA0KPiBodHRwczov
L3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL3Y1LjcvcHJvY2Vzcy9kZXByZWNhdGVkLmh0bWw/aGln
aGxpZ2h0PWZhbGx0aHJvdWdoI2ltcGxpY2l0LXN3aXRjaC1jYXNlLWZhbGwtdGhyb3VnaA0KPiAN
Cg0KSSdsbCBhZGQgdGhlIGZhbGx0aHJvdWdoIGluIHRoZSBuZXh0IHJvdW5kLCB0aGFua3MuDQoN
Cg==

