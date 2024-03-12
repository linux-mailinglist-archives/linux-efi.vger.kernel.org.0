Return-Path: <linux-efi+bounces-809-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D2287959F
	for <lists+linux-efi@lfdr.de>; Tue, 12 Mar 2024 15:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5F21F22789
	for <lists+linux-efi@lfdr.de>; Tue, 12 Mar 2024 14:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11087A72C;
	Tue, 12 Mar 2024 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="doHbd3ii";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zKsvfpXX"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ED47A713;
	Tue, 12 Mar 2024 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710252321; cv=fail; b=GlI5KzymMsXQ4c/HfOIKiionbLguCgspPnsvtfT4pxGkMgvy54res7ZTwPL7P3bZbce2TNqqwJ1azzWGLRHZYDdmDeDwTg9jvDid1m52FFaW8Rp5CdMMt/Hg0XBe7ZjtksoXLLaLCUxRpp8I4KrYAHV0kvjTuf/vnzV7ivUltzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710252321; c=relaxed/simple;
	bh=GXWq5ptBJTTaMQsSB50m9feSP4ridXMVXeTl1xs1dy8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L4P8xlpq836/b+Zb3RYtAvFOWkvgTUJdABndVZfg+L0gXMXJs8qZwcGNq+6fFSM4xbfq6vAeWNIyrnFTJlvftVr5i36waecAXdkw+I3xcyiOWLxa5V7jQyJmsUcNx3HXxkeAPWeIISG6t5J0UcmFBXHtd+2epyx/7645jOTyd0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=doHbd3ii; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zKsvfpXX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42CE40ul021352;
	Tue, 12 Mar 2024 14:04:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=GXWq5ptBJTTaMQsSB50m9feSP4ridXMVXeTl1xs1dy8=;
 b=doHbd3ii+GftN2/EWdpQqG8fFppAZ3lkuX08nXNHZ85GH68xg7YBYYyFhWq1mR3EiPDN
 D9QXfugJoYxxW/SXwyDNi7KKwOPneYCIn55kXRdFV+u7tcoeHq4YRpHWKIvOpZyCVST8
 Rq67CR60cn3HuLd7MyDOX88Fbz7t9s25qfggIcSOCfEDdbWPHGe7GQMZbXit1OMs7pfg
 ICLhHeFoviOTKVvQEF6Z9cbtRzN0LhI/tc/MfLjaMISfww14ZFOxnwrwnFr3mzdGdLYy
 sdSkSrpzEs6mg+KeNdJlU5tdZoVUCNIhaf0xDt76SU8zT63zbbpYudJeYrRDgZ0YCARG LA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wre6ee310-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 14:04:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42CDBe9W009124;
	Tue, 12 Mar 2024 14:04:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7dftaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 14:04:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RckjSEyhpowfE9UHqdnLgcXOng3e3cmJowN4Ou5nbTXzDyVu/qn5cSwWVl0gTKyzwX+LO4pMYXBTAJNiEAw4BJDBigfV7K3sRMbrIl92sTfP7QcejXYUi487e1PmwYjYSrQVV2OOJslG+JWNjkZ3+gYAJRcS24u1hsGQbsgZwJjaPM9Jn/VJ9jH7eDrS2GbE5JQ5UbPHLKf8QV669q5tS0Q4q/RnD4WFsQXyfgo0Xwy4u2PNUbj7gI/TF0IqWjnlCoswAbopK1hvVJrxAJaU2rip0jwFLu6+xfad2dNnuZa3hazzetpqrGhZH+JUD3H8RHoTBA9iJESm8jb4umWQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXWq5ptBJTTaMQsSB50m9feSP4ridXMVXeTl1xs1dy8=;
 b=btSMl3s/evfqM/HfvUxcIkAeu1+b3Uy0eZuxCPNjweEu5d8LRRSx375beNZNf1cE5AVwXjrrBc6IozaoTfS8bVQ2CZAiZPEJBR/KU4dv9ButVT9K4bMYtNJv6kX6bVasnLmhDeEl/4mcBNnEOPAVlnRQQVHMU1p9VudqxvuXpls2jlY2d0/xcfap0N2jRehdDoWu2XyLy5bn1tIvcs7CPl83rGLGkkV8zQ1umwKHiw9Xts3qm0r9fOmRv1OKEOJctqUc3VsnEsaAHb9r1sYnFza7JSgRyyLYmJijwKhKA7OHFUT0+/rlRV0JHZbQyrUu/jB4RayU9uXpAJXUC4q7fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXWq5ptBJTTaMQsSB50m9feSP4ridXMVXeTl1xs1dy8=;
 b=zKsvfpXXp6s8mU5qrpvvycWkmMtiej772bNral/4ZPSjvCkErjxEOlJ4mghLHy1JFJpad9frD3o1r+ynNmvXGT/db1a7pWLO739iqtUlJ5uMfsousM3RWF+pNWjv15mYzeAggz/1/uLbfi7op3arsEf/IPo0zSVUZxL3iNon2HM=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by PH8PR10MB6338.namprd10.prod.outlook.com (2603:10b6:510:1cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 14:04:42 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 14:04:42 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: Randy Dunlap <rdunlap@infradead.org>
CC: "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Ard Biesheuvel
	<ardb@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Moore
	<paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "zohar@linux.ibm.com"
	<zohar@linux.ibm.com>,
        "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "mic@digikod.net"
	<mic@digikod.net>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        "stefanb@linux.ibm.com" <stefanb@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH RFC 8/8] clavis: Introduce new LSM called clavis
Thread-Topic: [PATCH RFC 8/8] clavis: Introduce new LSM called clavis
Thread-Index: AQHac8/nSTH+qUOhGUmJdxTnWM0JLrEzZxYAgAC9soA=
Date: Tue, 12 Mar 2024 14:04:42 +0000
Message-ID: <C9A0995A-2390-486F-99EF-89098E78021A@oracle.com>
References: <20240311161111.3268190-1-eric.snowberg@oracle.com>
 <20240311161111.3268190-9-eric.snowberg@oracle.com>
 <50ec3230-c2c9-4c16-899e-d93d164a3e79@infradead.org>
In-Reply-To: <50ec3230-c2c9-4c16-899e-d93d164a3e79@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|PH8PR10MB6338:EE_
x-ms-office365-filtering-correlation-id: 341b335b-d989-4624-f1a9-08dc429d5d55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 lLV+AvavJbPR5vnAL7j+B+zSFyY0nYhodidiXuypHnqu+YEEZd5H3El854bUv08qSVPbdk1WQlHHrUlRcBQRZHWwieRUq1QdnYggwfyYTHwrU7NU4XocLu+nmaWy2pA+YoJhMz+S1Z0/ZOVvNYBCLlcMO4XMzaKevlbdBt7l4ha6ocw4CfhkItFPLgqmMa4650guOzZ021uFuYWdG2dYY81pnQKmO3o0X8YyapJYFXfK8TU6Lid7CpriX/7+7gAeZlwNfxCLJt6BfX3BGQa0NOXrkX8HbmrER/e75SYRMGujoK8A8cgL575ENg4wS0X/UrNyMGLJrqZhK5DTn0LeRusNUl3SJdbwS0ihO48ym9wUVVRMWpdA6gTADE5A1EEvs5l43fRgNtG8+lCk6535m9H0rtCp0O2nTkEtzZnjyATcth46kBdrLq4DEsME74PAF/AfkHk8KuL8/WvxhC4VY54RM52/7D6WZp9AaDqrYwEcGn2WeGB8ebWmkVQYkphl0nL/7VcuRgtkM/cgjHBMlaseze4aCRIPfkmDT94C450oX0qm260ABKgjthjmfhPxLfNlJiUMDvskCVy2G2OnA65Xad+0JjFubL7bayOWvP8GO4IEZi60QHLqzIq6E3jINgEIQAHlBL9YQRXD9ktR7Idwt9wrQwGVpLIPVmMFZK/CSED8ZDiNhX4y8A3OMmO8gj8iCo+i8BruX3+XIrZSE3gawcKDMRi9QgF0Fz2A7jg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NFducklwVGRHM0liOUI3c1lTVmlHbzlsdVZRNUNXeXJiVFNPVGhiY1NEaHVo?=
 =?utf-8?B?d3dwNVZGNlN0b2xpc2pta3RCb0dyNG12d0hsRjlOMnQ4NmlTcUVrK2huSStu?=
 =?utf-8?B?ZDZGRnpkVDQ3T3lwclo1K0cxa3VqTmJYVWUyaDVOaDJJUkJRWkhSQUNkNyti?=
 =?utf-8?B?ak9FemR2TGE2eU5oajFWbmJlcllyTEk5L0hkckUxVHYvendhVVNDZGwvdmFm?=
 =?utf-8?B?MnN3Mk9SWmt1Zzh4QS9hYjlCSmd0eUxpL3FwTTg3ZXI0R2w1ZDA1eVNGS1Nq?=
 =?utf-8?B?blRZZHpLMkZFNC8rcEptK0loMWlxWkM2b1dDSnRGMVpSZGdYN3FleGZoc3V6?=
 =?utf-8?B?R0ZDVW0zVHVneUhnRjU2Y1E0WFVFUUNrcEJRVE9GVXVOSC9ZUGthajFaNXR1?=
 =?utf-8?B?QWdNb053S0wvaWRYS2R6aSt1N0E4YjJzekdpL2ZyeEY0Y1JjNVBzaThKYXM1?=
 =?utf-8?B?aGd2WXRnbUJzb2ZBM20rYmUwQ2t5dWppcWJ6Qm9JMS9WTTBpQ2UzclEwdDRD?=
 =?utf-8?B?cGRKRGc4ZHVlM05GOGhHOEp6MVZocll0N1dWM3V0bktnT2NoNEpiaTNMTHNS?=
 =?utf-8?B?R2JRSVlXZkdrSWphMElqVXQwWnFISkY1di9hVmtJRXprVTh6bDJhT1pRRHpJ?=
 =?utf-8?B?R3V6SjVDQi9iZ3JoblkrSHMwWFJ5WUN1WTVFc1llVElEME1HWGR1UFJZLzFw?=
 =?utf-8?B?UFFKbXNxU00vZk9FYWlzNElNMTdHQ0w0bDlLMzF0N1RlaC81Tis0TmFHZFpJ?=
 =?utf-8?B?NURMdGE4UVdzRG82cmxHRU9LYWtWdDQzVHgzdlhnb09ybkhwSmsvc1ZzSWo5?=
 =?utf-8?B?OCtNMGJIVlFaNmIvZlhTeExjcjVQTGZ6ODhmTTZUdFVENlNkcWtFaWZNZVEr?=
 =?utf-8?B?bTIvWjZyWDVlTVQvMElRSVZxVU05MW43c2UremFMbm5Jb3VEZWd4ckRTZmFv?=
 =?utf-8?B?RGZOeDZxdXVJamluU3VYZ0NPRmsyQUREbFFyRERXZGlVSTU1bzBza1QxaVRF?=
 =?utf-8?B?aVNjSzF1MzVjK0lpRDhoa3VCTXpsZ0NmeE96M3ZUeFUrZjFyUTdYdGtkakd0?=
 =?utf-8?B?dnFRWFhCSDNncUE4VDZld1NiYTJnM0k5c3BBeExocm0ycjU4MW9Nc0pIVzAy?=
 =?utf-8?B?WG9qbVUrdTlkNjhwVXZkVzRNZ2dwWkZyREg5SzhJRFR3T1BnVXE1LzdraktI?=
 =?utf-8?B?TDZwM3h0V1hhb1RHVm16ZXRWdkZEWklBSDBoYVI5YnpEUkxjTzhyVGJrdXV6?=
 =?utf-8?B?emhKVmRzczZBNHRBWHhXRmsvZWNtRnlNTGJncjZ1cmttdUh1cXphWUtaWjNx?=
 =?utf-8?B?TEl1TStzUHUxcDJod2s1UFhqL1JMTkhrL0wrWUdXbTc1WnF3TU4vN3ppS3Zo?=
 =?utf-8?B?bDBKbEJ6WkoxVDFkanZNU2IzRDduRGZaZHgyRGlMNlEyWk82OWpPUmJmN0tT?=
 =?utf-8?B?WW9NenI1NU9CUGNGcmxSaFZCUkZpTzNKaFp4Y0cxbjR2enQvaGdQUmlJdmU3?=
 =?utf-8?B?UFFNUE1EbjRjU0VsdTdyTjR6RVl2cUdLTTlWdjdpMkpjL3VHYmZ6Nm9oUUFv?=
 =?utf-8?B?RGczYTFlWGFienZKdmFzWmlJc3JTa0tMbTJnaGo4NlZEbUI2SnlRMHhpdVdH?=
 =?utf-8?B?VXlPL3dKMENmSDBUT0dROUk0bTBXSkFCTjZ5SkZDdEJNNEp3R0Q1NUZXUkhi?=
 =?utf-8?B?Q09lYUVkWmlMUGVBd01LNWN3Z2RtLzMzMVFmOXNxU0YraFlCT3RISTNOWGhW?=
 =?utf-8?B?RDFwKzhjU3RZWGYwSm1KRHRJVEI5Y0JYejdTYkVuMVV6anRpYWhqRGpmbGJx?=
 =?utf-8?B?SlNUWDhhSW9HU1IwZTQzaGxNZmlPS2tDeEcyS1lVYWFiWWI4Y1BTdm11RzJj?=
 =?utf-8?B?UFpwekhiOFFHTWkyZUNkK2g3cXFEWFZRWWM2bEUrRXRNY1EvNE84WTVlMVRE?=
 =?utf-8?B?di9YeHlRNFFML2FNRkpvMHNXb3ZlZk9TYndCTm9CY0xOVUZMNWZnbXQ3U0pr?=
 =?utf-8?B?YW9menVMMkdEZzlDY2ZQN3NvOGpOcEJoUDVpdHRXd3lFY2hLZVZtL2JRRTkv?=
 =?utf-8?B?bHhENVNQemV5WldjTkJoaWNFRTR6RFVwSm1ybzREWHZRUTB2cnBJdml1SitG?=
 =?utf-8?B?Wkg3RjQ0aGlvYUg2MGRrK25UcWNOUmhaYVVlTjlBNzNBNXprdGlBUWt4SUtO?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FBB005F76ACCD46AE1476A99762CA2E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UmZKMOShmyHcHB2kh54VPm43NJx2yUZra+zBY66VH7KmRkRJb/SScBwLOw8KoyXPtZ+BFGGr5padW4e3f0oH0H8nzPk07ZEjxIUzCiy0u6vqZX/FVWQsCcVE7udhVgC5caNEsDHPI8XqiaUixacwR7Gs40oBCyKcB+wzTpHxu1ScGYfpOAd/kqA9kQGEoFbeTELMnp/Sn9XiW/UKRps4Ne4Ibd0EcyVtYG8d99ECh4TOhtlB2Uvx90d69SgjDwxEcFhlrETEs/QE90Xes5Zy35hNDylYGhs3qN4argsOQpuE0y/taDKN4JOuEv+KQKAmwbCSoACPhagtzT6Tk5RjUIeQIwL1bsMsIt0uju5xckROcUaUFResCdxBgfH7IbNDFFFnrqs2aH1K0YKI7oMra4DkLLREHx/nMVhZyxqThGQukq0XuqzLtlHVXOXCYQ6eDc7oDXcFj/olLrggWvdO0tW4G6/q0H9o2B54Cg4A+fub6T0WqcYmOE+g85bkQTDcF3Dv1V5ptq4EwHUfnP6me92GoBcCV8OFMQSVdN+QoDjRJD8UtEe8Jo63/b3b1/b1/qyRLGnjRsT8ncBEjDA9HmUrLpr7pabgRme/t7eMiJM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341b335b-d989-4624-f1a9-08dc429d5d55
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 14:04:42.2365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1SSspOQdquhzVQJ98Z6WKmA/AYxX7cC6z486bwQZ6r4WJmPwJf/Mabf3RlMbcRbuQ3mEnEfWaq7jCx0JdkQOeIGjxDwRblMFrm2OcvQZ5SQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6338
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_09,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120108
X-Proofpoint-GUID: NdHA_cMJ2kZmKYJ_XqjVpBgBulqfnffQ
X-Proofpoint-ORIG-GUID: NdHA_cMJ2kZmKYJ_XqjVpBgBulqfnffQ

DQoNCj4gT24gTWFyIDExLCAyMDI0LCBhdCA4OjQ14oCvUE0sIFJhbmR5IER1bmxhcCA8cmR1bmxh
cEBpbmZyYWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IE9uIDMvMTEvMjQgMDk6MTEsIEVyaWMgU25v
d2Jlcmcgd3JvdGU6DQo+PiBJbiB0aGUgZnV0dXJlIGl0IGlzIGVudmlzaW9uZWQgdGhpcyBMU00g
Y291bGQgYmUgZW5oYW5jZWQgdG8gcHJvdmlkZQ0KPj4gYWNjZXNzIGNvbnRyb2wgZm9yIFVFRkkg
U2VjdXJlIEJvb3QgQWR2YW5jZWQgVGFyZ2V0aW5nIChTQkFUKS4gIFVzaW5nDQo+PiB0aGUgc2Ft
ZSBjbGF2aXM9IGJvb3QgcGFyYW0gYW5kIHN0b3JpbmcgdGhlIGFkZGl0aW9uYWwgY29udGVudHMg
d2l0aGluDQo+PiB0aGUgbmV3IFJUIFVFRkkgdmFyLCBTQkFUIHJlc3RyaWN0aW9ucyBjb3VsZCBi
ZSBtYWludGFpbmVkIGFjcm9zcyBrZXhlYy4NCj4gDQo+IFdoYXQgZG9lcyAiUlQiIG1lYW4gaGVy
ZT8NCg0KSSB3aWxsIGRlZmluZSBpdCBpbiB0aGUgbmV4dCByb3VuZC4gIEl0IHN0YW5kcyBmb3Ig
UnVuLVRpbWUuDQoNCj4+ICsNCj4+ICtDbGF2aXMgaXMgYSBMaW51eCBTZWN1cml0eSBNb2R1bGUg
dGhhdCBwcm92aWRlcyBtYW5kYXRvcnkgYWNjZXNzIGNvbnRyb2wgdG8NCj4+ICtzeXN0ZW0ga2Vy
bmVsIGtleXMgKGkuZS4gYnVpbHRpbiwgc2Vjb25kYXJ5LCBtYWNoaW5lIGFuZCBwbGF0Zm9ybSku
IFRoZXNlDQo+PiArcmVzdHJpY3Rpb25zIHdpbGwgcHJvaGl0IGtleXMgZnJvbSBiZWluZyB1c2Vk
IGZvciB2YWxpZGF0aW9uLiBVcG9uIGJvb3QsIHRoZQ0KPiANCj4gICAgICAgICAgICAgICAgICAg
ICBwcm9oaWJpdA0KDQpJIHdpbGwgZml4IHRoaXMgc3BlbGxpbmcgZXJyb3IgYW5kIGFsbCB0aGUg
b3RoZXJzIHlvdSBpZGVudGlmaWVkIGJlbG93Lg0KDQo+IA0KPj4gK0NsYXZpcyBMU00gaXMgcHJv
dmlkZWQgYSBrZXkgaWQgYXMgYSBib290IHBhcmFtLiAgVGhpcyBzaW5nbGUga2V5IGlzIHRoZW4N
Cj4+ICt1c2VkIGFzIHRoZSByb290IG9mIHRydXN0IGZvciBhbnkgYWNjZXNzIGNvbnRyb2wgbW9k
aWZpY2F0aW9ucyBtYWRlIGdvaW5nDQo+PiArZm9yd2FyZC4gQWNjZXNzIGNvbnRyb2wgdXBkYXRl
cyBtdXN0IGJlIHNpZ25lZCBhbmQgdmFsaWRhdGVkIGJ5IHRoaXMga2V5Lg0KPj4gKw0KPj4gK0Ns
YXZpcyBoYXMgaXRzIG93biBrZXlyaW5nLiAgQWxsIEFDTCB1cGRhdGVzIGFyZSBhcHBsaWVkIHRo
cm91Z2ggdGhpcyBrZXlyaW5nLg0KPj4gK1RoZSB1cGRhdGUgbXVzdCBiZSBzaWduZWQgYnkgdGhl
IHNpbmdsZSByb290IG9mIHRydXN0IGtleS4NCj4+ICsNCj4+ICtXaGVuIGVuYWJsZWQsIGFsbCBz
eXN0ZW0ga2V5cyBhcmUgcHJvaGliaXRlZCBmcm9tIGJlaW5nIHVzZWQgdW50aWwgYW4gQUNMIGlz
DQo+PiArYWRkZWQgZm9yIGl0LiBUaGVyZSBpcyB0d28gZXhjZXB0aW9ucyB0byB0aGlzIHJ1bGUs
IGJ1aWx0aW4ga2V5cyBtYXkgYmUgdXNlZA0KPiANCj4gV2hhdCBpcyAgICAgIml0Ij8gIFRoZSBw
cmVkZWNlc3NvciBzZWVtcyB0byBiZSAiYWxsIHN5c3RlbSBrZXlzIiAocGx1cmFsKS4NCg0KVGhl
IHdvcmQgImZvciIgc2hvdWxkIGJlICJ0byIgYWJvdmUuICBUaGUgc2VudGVuY2Ugc2hvdWxkIGJl
Og0KDQpXaGVuIGVuYWJsZWQsIGFsbCBzeXN0ZW0ga2V5cyBhcmUgcHJvaGliaXRlZCBmcm9tIGJl
aW5nIHVzZWQgdW50aWwgYW4gQUNMIGlzDQphZGRlZCB0byBpdC4NCg0KPj4gKw0KPj4gK1RoZSBD
bGF2aXMgTFNNIGNvbnRhaW5zIGEgc3lzdGVtIGtleXJpbmcgY2FsbCAuY2xhdmlzLiAgSXQgY29u
dGFpbnMgYSBzaW5nbGUNCj4+ICthc3ltbWV0cmljIGtleSB0aGF0IGlzIHVzZSB0byB2YWxpZGF0
ZSBhbnl0aGluZyBhZGRlZCB0byBpdC4gIFRoaXMga2V5IGNhbiBvbmx5DQo+PiArYmUgYWRkZWQg
ZHVyaW5nIGJvb3QgYW5kIG11c3QgYmUgYSBwcmVleGlzdGluZyBzeXN0ZW0ga2VybmVsIGtleS4g
IElmIHRoZQ0KPj4gK2NsYXZpcz0gYm9vdCBwYXJhbSBpcyBub3QgdXNlZCwgdGhlIGtleXJpbmcg
ZG9lcyBub3QgZXhpc3QgYW5kIHRoZSBmZWF0dXJlDQo+PiArY2FuIG5vdCBiZSB1c2VkIHVudGls
IHRoZSBuZXh0IHBvd2VyIG9uIHJlc2V0Lg0KPiANCj4gU28ganVzdCBhIHJlYm9vdCB3b24ndCBj
YXVzZSBpdCB0byBiZSB1c2VkPyAgTXVzdCBiZSBwb3dlciBvZmYvb24/DQoNCkEgcmVib290IHdv
dWxkIHRvby4gIEkgd2lsbCByZXdvcmsgdGhpcyBzZW50ZW5jZS4gIEkganVzdCB3YW50IHRvIHNo
b3cgdGhhdCBkb2luZyBhIGtleGVjIA0KY2FuIG5vdCBiZSB1c2VkIHRvIG1ha2UgY2hhbmdlcyB0
byB0aGUgcm9vdCBvZiB0cnVzdC4NCg0KPj4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L3NlY3VyaXR5
LmMgYi9zZWN1cml0eS9zZWN1cml0eS5jDQo+PiBpbmRleCA0Y2I4MzJiMDBjNDAuLmQxZGE2MGEx
YjdhNCAxMDA2NDQNCj4+IC0tLSBhL3NlY3VyaXR5L3NlY3VyaXR5LmMNCj4+ICsrKyBiL3NlY3Vy
aXR5L3NlY3VyaXR5LmMNCj4gDQo+PiBAQCAtNTMxMyw2ICs1MzE0LDE5IEBAIHZvaWQgc2VjdXJp
dHlfa2V5X3Bvc3RfY3JlYXRlX29yX3VwZGF0ZShzdHJ1Y3Qga2V5ICprZXlyaW5nLCBzdHJ1Y3Qg
a2V5ICprZXksDQo+PiBjYWxsX3ZvaWRfaG9vayhrZXlfcG9zdF9jcmVhdGVfb3JfdXBkYXRlLCBr
ZXlyaW5nLCBrZXksIHBheWxvYWQsDQo+PiAgICAgICBwYXlsb2FkX2xlbiwgZmxhZ3MsIGNyZWF0
ZSk7DQo+PiB9DQo+PiArDQo+PiArLyoqDQo+PiArICogc2VjdXJpdHlfa2V5X3ZlcmlmeV9zaWdu
YXR1cmUgLSB2ZXJpZnkgc2lnbmF0dXJlDQo+PiArICogQGtleToga2V5DQo+PiArICogQHB1Ymxp
Y19rZXlfc2lnbmF0dXJlOiBzaWduYXR1cmUNCj4gDQo+IEFib3ZlIHNob3VsZCBiZSAiQHNpZzoi
Lg0KDQpJIHdpbGwgZml4IHRoYXQgdG9vLiAgVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0K

