Return-Path: <linux-efi+bounces-2499-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8347FA010D0
	for <lists+linux-efi@lfdr.de>; Sat,  4 Jan 2025 00:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2E2161603
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jan 2025 23:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519E11C3F1C;
	Fri,  3 Jan 2025 23:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZqZe7MGl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a/DDfIZX"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A0E1C1738;
	Fri,  3 Jan 2025 23:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735946135; cv=fail; b=eKBPlrEEOuGip/S4UjhEo0VnTSvBFQ+U+oFu40HD0G+A4VkZS14TcubgoSgLOELJQk8x3AA2y+Whhy8J3Mh8r5NZiVl7qo6uRVw4ZcNx5d1nU6tkan3A3OFX8CgZloK0onfdBQrebz6MyRmyBSGbD84xEEd6WSLsNVgT6mG9tB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735946135; c=relaxed/simple;
	bh=00yQqt+4txRvKiCo/r+I7DhuIPmb3GXPt7P/0VAG6i0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=buwtyXnUAR2jcSfairR+hD9hLicicz91/i0H0XB9KARBzzqnj+633kravORAHLBSiJIY+QWbpTd6Wh2HNoa/WmjM+V5fH+U7fB3/z1iqV/U+mUoWUBamMZ5S2O1k7tP45Z/5eKcB2h6NEG/zAhFsexAVUJch2ZAcCzjE/1qhY1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZqZe7MGl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a/DDfIZX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 503IdTQE004633;
	Fri, 3 Jan 2025 23:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=00yQqt+4txRvKiCo/r+I7DhuIPmb3GXPt7P/0VAG6i0=; b=
	ZqZe7MGlTo4Nj8rfLklnBAHStQqpYfEQJOgnlNIt9wU0To5cAGfclXWduXIbW6DD
	YmVS0jKjJ8gJXL4JqpEFWOeEMznbbac2IlCxxfyH/2GzQyPXfP9S574u10JcgzRx
	7BKWhfxeJg7wsqNQWB8TSXNeLu/qV0ZxYRftkwPpy53gRIZ8eCCSTEYN1PWdYcre
	FtwP/HVxk5ujUMWLERozFHRe7lN86ZUfHq+QREDFiTdYGsiba8Dk1yZmOXZYKGjf
	tvBdKaaJ8C9s3iffCptDxV8m2xCDU9hozhdeoX/yWUqxSHWkv3wOt9Yol6uOH8pp
	PyXapP2HmfnqLxd6cBQ3LQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t88a8x5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 23:15:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 503LI0ub012451;
	Fri, 3 Jan 2025 23:15:07 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43t7sa7skf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 23:15:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jR/4fks7J/4apc0Z6xxx+Ps2p3bzQhPm5B8jCY/HWZQwj7JjwyQjquLwj42u65O+zFnN2UdyuHB1NYUi0mCJVllRr8Rp8YoRipMUQC9SQYvWHOY+O55ArB2USQDnoNuY9H3YxzE9LDy5WSPBF4g1GZZgrws5ch7awPj0KVLvY9XPs4C0a3Q9i8v4VFSD6ryMcxNUdZJbrT0PAXVejpgblbXQTKOqb/Tf6LkZ5+C4xCVAWwdKkD4zDPJ3UMefuMx2TpBD6+8WP4F3uUBb/vFTT6uIi++b96COsT5DHyJsDpGINi4WKRSXcaQINlMliwnb99euF2HswZje0X251oOQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00yQqt+4txRvKiCo/r+I7DhuIPmb3GXPt7P/0VAG6i0=;
 b=mIk7zuuzHpCHsgb6Ezn9YYeEgjZU09gF0EV8RQmBW1Z8CbeLmX0Q/1xOWb0urt+v7mluzdBkq4dQrJ/U2YY8Nkp+EXJleCyeBUW8aG2v166AsPHEnAhdygYlO5w8nFeBiojai88nwoyEHueTSR7EgpxROfrQFj/sYVmddLZfc8/yDJMKV6Jlbv1kdpf05kZjq1oAWy4q42f57b7yJQuQL00A5lggvt56hj9OAhlkWPLyP8iwgJJJptqgFUgsr8kw92aOJYEezqUtM/MD8ErsG5oXVPsL9rDwOW0fiVTRGa+et5aGwUYNgFXKtDh31Z5UK33fJIv6t0+R0bSMMWplOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00yQqt+4txRvKiCo/r+I7DhuIPmb3GXPt7P/0VAG6i0=;
 b=a/DDfIZXIZlYyRIjne5slP/KQKDolOwL+jHEhL30GoMaygXpkCyrbudzaDLMR+AUIwg3AqoMkqcX4cDYfW59k2/Oh72KmPt9+OlChUMCtf7bk2A5mfvk6PPidVyUrviHcYrQ6s+deJsr+LYfxFFBcVTFaBpq7BRE50SNHdRCMyc=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by DM3PR10MB7971.namprd10.prod.outlook.com (2603:10b6:0:b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.12; Fri, 3 Jan 2025 23:15:01 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%7]) with mapi id 15.20.8293.000; Fri, 3 Jan 2025
 23:15:01 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: Mimi Zohar <zohar@linux.ibm.com>
CC: "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Ard Biesheuvel
	<ardb@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"
	<serge@hallyn.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
	<dmitry.kasatkin@gmail.com>,
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
Subject: Re: [RFC PATCH v3 01/13] certs: Remove
 CONFIG_INTEGRITY_PLATFORM_KEYRING check
Thread-Topic: [RFC PATCH v3 01/13] certs: Remove
 CONFIG_INTEGRITY_PLATFORM_KEYRING check
Thread-Index: AQHbIK0F7XGLtQUKx0Oz3ggNi2kbKrL0Ob6AgBHvewA=
Date: Fri, 3 Jan 2025 23:15:00 +0000
Message-ID: <8B4A339B-685C-4B6E-897B-825E53A16F23@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <20241017155516.2582369-2-eric.snowberg@oracle.com>
 <2e413e587556199c7403ecedef2ed854cd3e6c39.camel@linux.ibm.com>
In-Reply-To: <2e413e587556199c7403ecedef2ed854cd3e6c39.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|DM3PR10MB7971:EE_
x-ms-office365-filtering-correlation-id: 6190d4da-7050-4898-7f39-08dd2c4c72af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MG4vWHJkdGhZcFNLNXR2bmpPMFhuNkRxeDRsdHNQdlVuMm9WazdwY0F2U0dX?=
 =?utf-8?B?SFBIdlJJUUUxdFc3SkQ4cVlmOVZ5NmdjMGhldmdTYi9jaHhrZ1NwV2dUbW8y?=
 =?utf-8?B?bXk2dnNNeFlIdHdUanRtbTAzN0dNU25sUkJKOUpieEFIbWNSZzcwYkhzRkhQ?=
 =?utf-8?B?YzR4K2lFWDJZUFRnZ2xoZlZRanhPNnFaOVpvTDF5ZE9mTSt3TFNENVlDUFor?=
 =?utf-8?B?R2EyRWdGMlJHU2o1ckVPaTZCSlQxS1lmeElvdUVvQWVDSlo1TmRiM2x4R0Qr?=
 =?utf-8?B?OU1RdFhyU0Jha3pOWmF4RU9NMHU3NEM1Rk0xcEFOMEF3c2poQW5haHg2cXUy?=
 =?utf-8?B?RnYrc3VNcGQvY0t1OEdkUDR0Z0ZVYnVGbXlIOCs4MW5yVlV4amJQdzE1YlUw?=
 =?utf-8?B?K2dsaGhwR1JqYVpPZHNnS2IrUSs2Tk9pMW9leTVOTGkvd0syQUpoWXlob2h3?=
 =?utf-8?B?djdmTHFKMlkzZm10MVdkNXlMZTRKbVVkTjRDWVVhRzNiRE8xaTY5a0U1R0dJ?=
 =?utf-8?B?TStnZUFCd3dNZ0E3N29ObXV2R2FZQTdXU2dub3pUc29tTzZpL1ptdnBhZ0xY?=
 =?utf-8?B?QnREeE1GZHNWTEdVK0xpZlFpREsrNWZkOGpLWjVMTGoremc5OER1Z2R6QUFk?=
 =?utf-8?B?Y3RBNVF4cnBEamdVYjBiTEZ0ZzFtMnovdExocEhCU240VmhjOUpYZmNVbml3?=
 =?utf-8?B?c0VMWkpwamNycFF2eHRoYVRoSHhOenYrTG8rRDI4TGJtRVMrYXlFcktOaWZW?=
 =?utf-8?B?NVYxSnM0cm93aVZGTlgza1cyZUxubHdXNzNpWWlCVys5aEIzOEtJelhIS091?=
 =?utf-8?B?SU8yaXBmWk5pMWo2V2JoMW41ZER3ZVRFR2hVUCtzNnFTbEdZU0tpNmt2RjBM?=
 =?utf-8?B?MG0xekVmQUFJamtTTDkwWHZKN1UyTU1LSjdmd2RkcUEwTWYySDUxWE1GK2dS?=
 =?utf-8?B?dVlWRnhmaDA2YmVTNDh4K2J1a29PZWh6S0t4V2U3NGJvcWhDdjZQdmpWOGUx?=
 =?utf-8?B?ZE9sNTZ0Uml1OHhFMm5pWjE5QXhTaVB6TlRBcmZrRG1vYWVoY2svbXpOMHVo?=
 =?utf-8?B?WXdEeDVGMENIUFZuQVdrODNsMlc0L3JqLzVTOHBjNkorWUlDby91YVlnQ2J5?=
 =?utf-8?B?ZVdRaWp0MFVMRUZMazZsckd6clQ4ZlJmOGVtd0NxeVZOQk5vQVJUR0FvRFFJ?=
 =?utf-8?B?eUJLQXFMbnIyMnE3WXJWd2ZUVG1VZzFQbVZQUmo1STBReU9aRG92dEhDU21T?=
 =?utf-8?B?SjhSMTNHcUdVM1JxY2JPUE55aW85Z01UdnQ4M1lwc2NTSDNCOTlkZi9aWUht?=
 =?utf-8?B?R0RxYmw2bFRHMnQ4UjV2RXZOWnVGU3pOL2hsRURYb1dBUmV5anlFUEREamVn?=
 =?utf-8?B?SmhpOFRqTmsvMUFKZGxSeE1RdnlqVjdvQm9MaVo5YURXV0FrR1hCTzFJSy9s?=
 =?utf-8?B?NTJFZDk2L3pGZGg2UVdSTElzY29GcFVMSlRnRTg4aCt2QUEyN1VwRDA2SHh5?=
 =?utf-8?B?VVg5UTBPd0d4dkRUVjFHbW83TTZkdWpMOS92djlUOUlRZlBpN2xaSkdPRjgr?=
 =?utf-8?B?VkY0UkJrUUJWYks3VFFEMXhjcGJQMHExbEdVc2l3anZiUlVBR1JzRVAzSEEx?=
 =?utf-8?B?STVpU3Y4bDI4TVpUdmF1NmJ3UFVYODFla2liRTVtSmQwL1ZzYSsycld4YmFs?=
 =?utf-8?B?Y2RiQmdRcWtRbEhyK3JiVjhaVDQ2K2hrTHo1dVpFck1iY1B3b3dtOVkveUNr?=
 =?utf-8?B?Qk9PNGN0SkZrbjl6RTU5M0NENGIwWnF0ZjNneXBjaXYrRXhKbm51NGVDY2RW?=
 =?utf-8?B?Sm00WDZ6eUZXOXkrVlZFWUZ5dFU1QjhKemg4Zkl3a1VsMld5S2Z1MWRsc0la?=
 =?utf-8?B?WkdtQ1BudFNFL2ttYlVNanBNTVBsUm13Q1Fyemw2VWRmMWFVdzNOUHNxb1Jy?=
 =?utf-8?Q?D/OXyDsY0sklXD/tA+ZZhsc04finVtFV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TlpxaS9BRXZDN1VEaHMyNDFMM3JzSTJKTWY1OGpWOWJUdk1ZYkNGZTVidVo4?=
 =?utf-8?B?ZW5hdFB5Uk1NMnM1QlNwMzdreXJqNFd1eEsva0U0ZTh4eU1BMStrN2RNSlpN?=
 =?utf-8?B?NzFza0JUb01hZzBuMWJzd28wUThoV1FzREdIWVhJWXplTDVvdEZxZXlrcEFT?=
 =?utf-8?B?bW5uY2lIUzVtZVZ3bnJ3MTdzQlRqWmY3QzlsZU1pcXFwT0JwYzlOc2tCZUlx?=
 =?utf-8?B?V2c3dFF3YXR1Q0dFSCtseWdkY3hIZzZHYTFmUTNWUGE0Vks5TTJoUktPaXR4?=
 =?utf-8?B?dFJGR3k1Ukt6amhMb3ZSN2oxQzhXanhvSVVaSlhBZ2E1VURYSnV0dktTTExE?=
 =?utf-8?B?ZFE5a0ZNREhScDFsVHAzVWFYaU5FeEFFWmIzcENsclk0cUxBQjREVFpNbkhM?=
 =?utf-8?B?TWRTcU5LZnphNmZYT1dVL2Rob2NxYmdvWisyOW5Tb283THo3RGhJWEt6enFq?=
 =?utf-8?B?cEFpOXVVQUpyekp3SGZPWUtzVGdzVzFlc2ltTGNMamY1UGg5ZzQvU09Hd25U?=
 =?utf-8?B?dzFleU82M052OVlJRjdkNXZ3QkZHRzc1ak1vMEJraEJqOFVMMy9zbElUNS9Z?=
 =?utf-8?B?R1hJTHF6WmFoVW9JQmwvY0pNcXhzaHkwV0NPTHU1RlFSc2U2VDF5T0NFazdB?=
 =?utf-8?B?RUkzRDBDTGVEUnA0cE42S3VvcVRJK0htTkg0THJNczVWNWRKcWxhbjFLMTR1?=
 =?utf-8?B?NFJ6cFRkUm1qK2oxcjdhY1hBWEtNUUxyOFNiOFZwR0N0QmVVa2dIVHdyR2tB?=
 =?utf-8?B?TjJZako2eXhmaCtxSjVlL2UrcWhQM1BHU3ZqckFmOEZwR1Y5eVVpbHp5MEFH?=
 =?utf-8?B?VGxIcldsM1ZCUllKQWZJZkNDeXlQSVFML3M3d1IxVTE5Z2JrNTRzVmRLTU5J?=
 =?utf-8?B?dkNhM3pwb2s4K2NpTEtCZFV5ck4rVE8xZnJKNTU3NWRqNjMzUnZWQm9KcmRw?=
 =?utf-8?B?ZW9OZTRIdEs5VnhCTDdraDNuUFlXTjV3WWw1YzBLLzNVN25CdjJNbXlxcFJ4?=
 =?utf-8?B?bkpLTTZLNnRRWTc0RlVuWGZvRWl3UExxVkYvVVd3SngzdUsxOEttSnFyNU1S?=
 =?utf-8?B?Y3J6U3dTZTBTMDFRQUNUSXByalU1bkd3QlExeTBZWWRESmtXYkNqeU1Xemdk?=
 =?utf-8?B?YTk4ZDNsZGJkOGR1Q2h5Tjh0VjV5ZCtnVTFjWEtwSDZoSkRUNW9UcHZyNExa?=
 =?utf-8?B?SWVaMUpyRGtXN3IwcWw2b3AxRkNVNHk0bTcvUkh2RUorZXVRWmF0b3NOZ2ZZ?=
 =?utf-8?B?RDMwOWxQVTZzR2FqNWJEUUdvQnpNR2EyTHMxemZjUEhWKytMVGljbGM5NzhT?=
 =?utf-8?B?SFVJVlZMRFkrczJaSjFzSXU0K2hpSTJHWWFWVVdwcUQrZGRmOHp4NDRpbG1l?=
 =?utf-8?B?MXZFc0xvelpqU2s1MjBmSmlrb01RNE82KzVEVll6cUFhei9UWjIxWmVqRFpB?=
 =?utf-8?B?TG5VN213MHlBS2RjYzk4ekVJb29URmJUcmp2eVFqenhXN2dJSFpsUHdONXFx?=
 =?utf-8?B?UDJLRUk5V1hUbWs2RDYvODlHdzZxZUUxanJkZkw2QUtXR0xVemdzbUExYysv?=
 =?utf-8?B?Rm81WDdHNnZSUGFVK2VMQVUvQzJ3NStITUsya3lUbU5SeTVsOWdzTDB3QUQr?=
 =?utf-8?B?WE1SbWVsaUtwenFnOFl2N1lOd2dnMnVFT05QVzR4MEtIQmNJc2lNL3JXRGZ6?=
 =?utf-8?B?WHlWdjR2eVZqODZldklKTzNEV1ZMWmViM0JoNUZzN0VWTUdIcFBsd0NxQkg2?=
 =?utf-8?B?NWdGVFR6NUkweGt2YTB6b1ROVlNlUzJYaXdFYkFlV09QVGtzQWVVWWEzM1Jp?=
 =?utf-8?B?T3JhQmhhN0JmWm80dS9BUlJiL2xPaW9IVjNMcEdOOWZGNEZPRkVoQy84K05L?=
 =?utf-8?B?dTdtQnFPQlVlS25WWDVmdTVveng2ZSs2S2RZUUNJcUdCUkM3bGZ4RjdVMHZM?=
 =?utf-8?B?OUNSVHdxQ01sWkpsRU5XNWdvZ0hrcWFqUUV5U1U1cFZqdGVaNHhWeVExazhr?=
 =?utf-8?B?Nm5HRTV2V09wYWc0dTFjSUlhZ2dYZkd3RlYvSnltQ3dlVWJFUG5kNXhWcUdr?=
 =?utf-8?B?YnlUa1MvR2ZCWTNmM2xYQzFIM0V5MW9oZ2V0UEV2Vmx2Y1FoZ0U4YzVBY09U?=
 =?utf-8?B?ekFTaGRjVzE5dWRSZFAxa1RQNXg2UVpkYVNuanMwZFNTTWNBd0lJM2pQeFpR?=
 =?utf-8?B?cHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A48C4975E057C043A926F4EDAD2A7AF0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iM02tzjn+Hpvb4Pamc1IqrsN4w3AlnWGThXCq8O9IIAqe4ZxWnpCxgA1MlwVYmYYts4F2QKSBiZcCo2ppsBiy+lF0QdD4h4ZtMjtoI6zGL6s/OpRxPEeCkTKpajjE4fdI7ZE238ot97nORoXg3OQtkZQoQXp/etPEyL/m7evP++QcitB0fwEU0+5/XwoCNAfc0A5fFziWhIsITA2dipyp4SyLfyfbItAwXoELLNWiMf3o5ZTJAmRmkAUYetCd+wjefoSa6VtskzFWHOve8iV36ONSTBUTHWCEV7lDa7El65f8j8t3Pk+cKDYETfhXkHjfNmqIWls1H3iwwIrb4KW5ZV5N5isBXxtZRGfbSBWZ7YkIrRt7c5iXYboFVIgzFUr3IZJF/bHLqb4WHDfVHzrKigWWPxqS9UNTVNaltv6oXJTcywC/maxjBeotEL65LfXkr82Yz0NjBLFty+WXeKnSPXFm+qv/sUAQ+6k/OOOblIiylkjz4vtgWbqvBG7zqFzq3Jq9QTUDrbDeXGz7tnhsk3jqrgdvaXIvDrJL0wKJX+v0bRw4ON9Kc3OXkp2tOT1Rc13gwEsknOAwDGbg3TnZMCIRInebyJE9z7Vuq/97oU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6190d4da-7050-4898-7f39-08dd2c4c72af
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2025 23:15:00.9650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: agN1Sjv/mE/n3qoibCwGO6YhA74ru3YkDdaGoH5CNZNedeN5s6hmrav1/LWI+atjilRD+2qpMcRTSeKmPQv9zX7P09dVtiVEwJ6AhNfy048=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7971
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501030206
X-Proofpoint-GUID: tVkukDWAfVt9Ui0lUJROjppv95yIGT1F
X-Proofpoint-ORIG-GUID: tVkukDWAfVt9Ui0lUJROjppv95yIGT1F

DQoNCj4gT24gRGVjIDIzLCAyMDI0LCBhdCA2OjIx4oCvQU0sIE1pbWkgWm9oYXIgPHpvaGFyQGxp
bnV4LmlibS5jb20+IHdyb3RlOg0KPiANCj4gSGkgRXJpYywNCj4gDQo+IE9uIFRodSwgMjAyNC0x
MC0xNyBhdCAwOTo1NSAtMDYwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+IFJlbW92ZSB0aGUg
Q09ORklHX0lOVEVHUklUWV9QTEFURk9STV9LRVlSSU5HIGlmZGVmIGNoZWNrIHNvIHRoaXMNCj4+
IHBhdHRlcm4gZG9lcyBub3QgbmVlZCB0byBiZSByZXBlYXRlZCB3aXRoIG5ldyBjb2RlLg0KPj4g
DQo+PiBTaWduZWQtb2ZmLWJ5OiBFcmljIFNub3diZXJnIDxlcmljLnNub3diZXJnQG9yYWNsZS5j
b20+DQo+IA0KPiBPay4gVGhlIHJlYXNvbiB3aHkgdGVzdGluZyB0aGUgS2NvbmZpZyBpcyB1bm5l
Y2Vzc2FyeSBzaG91bGQgYmUgaW5jbHVkZWQgaW4gdGhlDQo+IHBhdGNoIGRlc2NyaXB0aW9uLiAg
Rm9yIGV4YW1wbGUsDQo+IA0KPiBDb21taXQgMjE5YTNlODY3NmYzICgiaW50ZWdyaXR5LCBLRVlT
OiBhZGQgYSByZWZlcmVuY2UgdG8gcGxhdGZvcm0ga2V5cmluZyIpDQo+IHVubmVjZXNzYXJpbHkg
YWRkZWQgdGhlIEtjb25maWcgdGVzdC4gIEFzIHBsYXRmb3JtX3RydXN0ZWRfa2V5cyBpcyBhbHJl
YWR5DQo+IGluaXRpYWxpemVkLCBzaW1wbHkgdXNlIGl0Lg0KDQpUaGFua3MsIEknbGwgYWRkIHRo
YXQgaW4gdGhlIG5leHQgcm91bmQuDQoNCj4gUmV2aWV3ZWQtYnk6IE1pbWkgWm9oYXIgPHpvaGFy
QGxpbnV4LmlibS5jb20+DQoNCg==

