Return-Path: <linux-efi+bounces-2500-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80605A010FC
	for <lists+linux-efi@lfdr.de>; Sat,  4 Jan 2025 00:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FAE71881224
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jan 2025 23:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC681A4F22;
	Fri,  3 Jan 2025 23:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DN0ylsPb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZzZdWBfW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE6F55896;
	Fri,  3 Jan 2025 23:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735946882; cv=fail; b=G3oMC8jHTAj3NK2iKduL06uB5RZ2HPmKvuOLR0SvbG9uKxHOdCCtA3z+pNNOCgEPnbpMBSb8HX3rUnkkFVMp5eb/puK10uvzBepTnJDjxu8JZ/nxDNyHN1RAgj84zPmhlloIAV6g6NTeFuAMYaXBj3ManiCcdSBDbkFGolgxQvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735946882; c=relaxed/simple;
	bh=C62+Jk3Qkr4W0ivNVD4tb7jDqphEP3vsGcE/Gfos8TU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ofEjEBnLAgtdPo79A9HynL5iZy8xGYQ3u+1oXx5aFNJIUpXnwwI1hEYNpGvpxxIb6mCb+Lmt2VR0OolEocCoMagFk4+lgOH6GJv9HKLASzlgQJ9d6Aa+R3sjf6a3Y9z4UEInvfiRDW82BSxVPzWpbvJbMZOLjEA695LYB7jpIP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DN0ylsPb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZzZdWBfW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 503Id1gd003977;
	Fri, 3 Jan 2025 23:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=C62+Jk3Qkr4W0ivNVD4tb7jDqphEP3vsGcE/Gfos8TU=; b=
	DN0ylsPbPtfTLb2PgNKteOQW4yaLn7C/5mpyFk/jI9USzitJExIHR3YJr2fyc7I3
	9C/5FutRPMgx7wUF+dJ0xXs6+cxZoeiWQnyPsMyD5XEPvAhmxFwnOYaydImr05kw
	muU8JdMkV9iEfefE0tuj2S4ka2wNeG0VQNx2/H9nFAfr12VhgopBJyCQGPMWdelT
	JhAxdTJsDMyFk195M0bDNI8ZT9RM/kAXwy9KBXjvInXjZhUljBeQISbyZ3jgj4f7
	Oe9d5jihbkRs2G2MEp7WM10gKdGOfoZBtX82jjSlgRw5CrvoOAVMsbz7qrmJHeb0
	czOsb7tnhDFIFSBUT4Km4w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t8420w5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 23:27:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 503Kbo9p030152;
	Fri, 3 Jan 2025 23:27:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xcwgnv9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 23:27:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovFoSl0RwyarnL24VblLlfvRDpRSOccWOp1CgInrTzJq6JwB3Va5VOIDo+ICGd5xAQ6Q+OxruGniUj02q3UQl0ieRf+bPHKNFuuc8erlOAjWiyHuIQWutek9T54YKo8hs4GtBSSObf4C+Fg8vzagjcfXvADxk/Tv4J9Pe9sJf+MLhnJeIOAsUkGUYMzI5nEmQjm7TYLdEoTwcr24xNUBpwOi8DLb2396b5nHod/pfYkQIX2RgVeCDboVL90WAizRChYzrCfKW3kgxEJ1WurQdc+pFNmt7YakyRwjPt/u9/o/He5NI4Z0GDXi7MqVVUT8W+NrKUM7/RYdYZ2qsB30IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C62+Jk3Qkr4W0ivNVD4tb7jDqphEP3vsGcE/Gfos8TU=;
 b=BEmmFOezJT0UKnOPfOJ9GiIROLcw4xYT53Hn+duLKFL5e5m1RmJVLhn0wMel3au0g8CxpCETkE0JsPZrocot9ApR6goBDH3SOpo9WgoQU8wof+7NBbS3ifu1iCOcb1p96wEfdU2B0j5cAg5H+Sk/GDPXyymt+onKv8yXAzddO7M7mN2wmidmtg5a8g+oGGg2gUfWs2/Kk9gjqU0sqwmk95aNKhsBZBQ2w+fgILTOufHV8EE+Mm9Ad+pIbMNLsevjBDO+6vXI8FLk1lh2gFIbOE/n3oNFTzZO1/tl3rn3ZjIFfYJ18UP6HVOMujby+V7lzRW1K7JYe1InEdTZ5A/1iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C62+Jk3Qkr4W0ivNVD4tb7jDqphEP3vsGcE/Gfos8TU=;
 b=ZzZdWBfWN1RHn9lChulsgpGqn3Em1KvES1EKeWkZqZo4B+4mjk9pzO4dN7ExajFXjF8a7xM8RZ5eeV4X2N30FaeLPayT4ab7c8r0KlCSiwUwGtw2BsMq3mrgepsphurVjdawgKphJsqxA4cvRRPKQ8Zoqy2Dl1r/+Mhp7WkTVGI=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 23:27:16 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%7]) with mapi id 15.20.8293.000; Fri, 3 Jan 2025
 23:27:16 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: Mimi Zohar <zohar@linux.ibm.com>
CC: "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Ard Biesheuvel
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
Subject: Re: [RFC PATCH v3 03/13] clavis: Introduce a new system keyring
 called clavis
Thread-Topic: [RFC PATCH v3 03/13] clavis: Introduce a new system keyring
 called clavis
Thread-Index: AQHbIK0Hzf+Cg4+90kWI3AEp5Tt7kLL07H8AgBFAJwA=
Date: Fri, 3 Jan 2025 23:27:16 +0000
Message-ID: <13BE76D4-9001-4D80-A4AF-4DE63827E05A@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <20241017155516.2582369-4-eric.snowberg@oracle.com>
 <0dcd6ccea49026950608d8ddde5700ace84a2548.camel@linux.ibm.com>
In-Reply-To: <0dcd6ccea49026950608d8ddde5700ace84a2548.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|CH0PR10MB4858:EE_
x-ms-office365-filtering-correlation-id: 1a64e43f-1fab-45ee-7337-08dd2c4e2942
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R0ZDejIzVXNOZmxiWXA1OUNJYmU5YlFwN0J0N1NLL050b2ozNnMrekJVeU9T?=
 =?utf-8?B?akE0bENqYkt4R3E1QS9Ub0xTYnNhQURuTGJTZTJ4SEIvNXU1SUc5dUh1d2Ux?=
 =?utf-8?B?b2dtVHVqbk43WFo5YmJ6T2RnTWlPdDVSSlZNSmkyM25MbmJvSVphdVNPSFda?=
 =?utf-8?B?Q0V6K0c2ZVR5NUJFQm5ybjVPRTM2NHliZi9Pb1lhNE85NmhuTlVlRGlyenB1?=
 =?utf-8?B?M2hHTjYrMmNTMXJ1elU2OWxBSWNubG00dEpmV0NYY2lvV1dFZnZDbWlJNnlU?=
 =?utf-8?B?V25kYlo0Q0NvdFV3R2hQYjVVbDVQVm9IRmZmSlFXOGVYSVdlV2RXaVdKR1VL?=
 =?utf-8?B?KzBCc2pPaDYxRFU1QndTMjA1b2tFMG40eGFnTHYrNHVVVnpkbU1PV3FxcUVt?=
 =?utf-8?B?a1BUN2lEbm1JM3FGOTJqaFpERjE4czUycmovbXZQWkdwMHNsZ0IrTXBob2I5?=
 =?utf-8?B?cHpMSDYxc3h4YTFIMnJIcUwyWkpTZ0RIdHBwU1daMEt1QUoxMHRacFl4UXNF?=
 =?utf-8?B?aGt2bDhYakdXc0JwQVNWM29nc2FDeCtsVHk2L0VKVEJoWXdjYmR5dXVzSmxt?=
 =?utf-8?B?bmp3WHBCVEhDS0JsTkFLQTd5N2hKV3ZFeWEyVCtXdktYQzFKTHVaL1pMc3FC?=
 =?utf-8?B?VmgrTmRpZHNvSkViSFA1Z1pZcS9aMHJsZ040cGQxVlQzQ3hMNUttNkNXWUxj?=
 =?utf-8?B?VjR4L2tGRjBFQmc3dVk2aDRIRnErcDFzS3ZLRDJoWEVBNE1xYVNvTnd2S08z?=
 =?utf-8?B?Q1V6MTQ1MXp3TUdsMWhkMUR3bmtaaWVwWW5lVFVMbWlEZnkyUGo3QThpdTgz?=
 =?utf-8?B?eXozYUJMVHdEYXNaaFlJdXVTYk1ZTVQ3TmVsZXNpTlVwejJyRGxubWpxV0xu?=
 =?utf-8?B?TWlQQnFNSi81OEIyUDBpRG1EUHZJUWlPQ252VzVTVmk4Z3pUQmgyb0ZGaGR2?=
 =?utf-8?B?Z3YwR0hvUHZFY2NWKzJBeWZaeC9qMm1leGxjTWxGRHNYZ2Z3MUpOL1NkQTU0?=
 =?utf-8?B?N0RYN2hnQ3ZoMlBBSFlYdEtlbFBMVGJzV0lGQTMrYWR3Yk1SY005VzJvRFpB?=
 =?utf-8?B?S0dPQjM0NG8velM0VWhHcXRabXFVWFljTklPeUIycmhXYUlubXFxempsZ1gy?=
 =?utf-8?B?eHlmZ0VnS0tVTHlzclhBK0FTZDkrbm9EaWczL2tRWS9ISE42VWMrRVI0QURo?=
 =?utf-8?B?bHZsdndsaXFPaXl5eURoeUxKZ2w2QnFjSjBDcHd2RFkxZlkxV29HR2hqZldE?=
 =?utf-8?B?UnZ2bUhnL1dxeXVOKzh3eTdMZkpFK0VGR3U5b3V2SkVxWnNYK3N6RklicWNy?=
 =?utf-8?B?RkdmekIvK0xxUHpCN1hvelBZcnBJVTVySHdzRDNlM3l6M1hEWXVESEJBdk9D?=
 =?utf-8?B?S2VpZWlEYzlUYVVuRWtKclIxZytuZDRWckFUKzBCUEtFUEl6NzRPL1RvV2x3?=
 =?utf-8?B?NmsxbHY2cTlXUDlGNGVYUk56N2FqWnFMN2NuczFhUVpNOCtKSGtYYkQvZkZ3?=
 =?utf-8?B?L1FhakFHNjRGRmZ5NG5wZk0xWGphRi9KMFh4c1piVkRVZzNLSEN1TGFUL0hQ?=
 =?utf-8?B?c2tpaHp2U21SV2xhZ3ZxajY5c2Evd2hhQ2ZtV25yKy9GZ293MXpoUS95NVp6?=
 =?utf-8?B?M3IwTUJkZGNmZ1A5NkdvUml0Y0N4UEpHdFptMWdBZnJIZ3Vjcm5WLy9icDln?=
 =?utf-8?B?d2pxL0p0UUNJeHY5eTJxQ2tEQ3k0QmhnbEtFdW1oMENjK1B2TDVxb3B0MGh0?=
 =?utf-8?B?N09ZQlRxemYvMXlYUW9JUDNzbFU2NUxKK2Rjc1Z5S3FnTldDZSsweTNRdVZY?=
 =?utf-8?B?VFBUaVRvckVjTnpiUWNUc2JGRWJxSi94VlJNVXYxRHQyOVlNcDVGOXJJQ3N0?=
 =?utf-8?B?VzFmQ1FyTDRDMDc0ZmcyM2tCbDdzTDlLVTkwb0Jsd2srUm05UW5aRjBRbW9x?=
 =?utf-8?Q?kBvFPjv4PsYbGAaAu84esSH1WiKciLWt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFJ2UVVSTkZJeThSSWU5NGZQQzhnTENJcnRMbXhFZVM0STh1ZGpmNUkyODUr?=
 =?utf-8?B?OHdnSlVqMEN3Q1hFcTBpWWp0SWJUM3hUTURLa3NVMjFYVzA3cDV6MjZWVnM5?=
 =?utf-8?B?cXJHaHhXQngxbE5jRmxpWmtuL295RTB5a1ZSQ3JpaFBKWDlrS3lITnBUYXRP?=
 =?utf-8?B?eGFzV1p0T2JDN3J6QlE1YUFDZHNsaEowNGJmQW9tZVZhbENJdFEwSW51MEx0?=
 =?utf-8?B?aU1TbmZPUVoweVRKZzZvUzk2Q25OM0c3RXJqM3lwWmh4MVZIYzVPeWs0R3p5?=
 =?utf-8?B?bTN2K2lFelhreWNiUHljbG9xZUtXcGJzUC96QVA3eE1adk5sNXI5d05SaHY0?=
 =?utf-8?B?UXJRUmJ6Vm9vUU04cUc0MGNRd25VdmxKb3k1VWtIbEF6ckpHVnJ0N1hKL0p3?=
 =?utf-8?B?eTFUM2Jkb1JDMGFqTnppU0VJVEU4MllTN1lPUW9EZ1NJT0w4V04xS0wzdE9H?=
 =?utf-8?B?ZFEzUTkxdytnc0tBOUlMcmYrU2VaK2cxL1lEcFRBTEIrOUhraDZwUGU0NDBj?=
 =?utf-8?B?Z0VRYTI0Z0tBY3BmUk9lelZLWVFGOXFIcmlISjFFVkZaUWxBTnVlREJLYXVt?=
 =?utf-8?B?TUtQNWJ0ZENDQ3JEVlozc2c0S2cxY09kekYzOU1CcFpXNkN4bkVXbmlwYnNP?=
 =?utf-8?B?MFVnNmI1TTNmaVFOQ0JlYVpIdGg5aWhHY1ZzV1I0Y2hUdGVkR0JwWE1LaGg1?=
 =?utf-8?B?Snc4SzVhWHN1RGJqN0dSWWFTUUFJNGpQM2kyc0duMzQ5SmQ5RHNvbHA2T05w?=
 =?utf-8?B?YUR1WFF0ZGh3OVRZcklvdy9YaTJ0QlRBeEd6T1VieFhISU9YSk1uc3liNVM1?=
 =?utf-8?B?ZldFYU1meXBjVFgvZ2UvRVVMTzIwMVVuT0ZuWUNYTUNaQmlBYUlxSkJnb2Z1?=
 =?utf-8?B?bUh5MHFQaXdGd0JDczdDMGYyQnIvQWFMNngrRG9MeUZyTlVqaHJwY0dqT1lW?=
 =?utf-8?B?NW85aDE2UnJsZHEzbXFZY1JoblhJZ2wzQUZzQWF0L3h5akxMUFVCdkY2Nnlw?=
 =?utf-8?B?L0RuR2ZTM1dnNU82NVFBekZXZTZNdHdHWk8zU3dLYzU0a1BOeHNCRC9Denc1?=
 =?utf-8?B?YzZzZ1BtZTBGUFpyeWdaMm9WQUtvZVdlUXJCbk9MdFhYN2JYdllSdHRoSW95?=
 =?utf-8?B?WFp4QWhFenFnZDZBanQwUW5PMkVLZ2NHT1NsZ3VJcE9UdXpZSVBpemNZV1F0?=
 =?utf-8?B?anRNM3VENXprQm5YbFFScTU2ZFl4bW0rNStaVVhGcUVLeG5ET011SHhUTXR0?=
 =?utf-8?B?RllhOVp6ZG9yVHBHU0ZJaHpnK1FncndBY2dDMWlaU0NPS2FIL3lpTWNlaDU4?=
 =?utf-8?B?dnN4OUd4L2xaSnJhSkUzRkJVMGZzTHB1M1RiSExtbEdtWDl0OTB0RkpIQUxx?=
 =?utf-8?B?QzF5Y1pYeWFBcGJaWjNudVlicldaKzM4MlVxYm4rR2dIV0UyOTZ4NExjWVZT?=
 =?utf-8?B?ODlKUVY3V3RMT1pUV0hjY25EbEgvS0p2VWh4S3NlZDdTMmdjQXUrdWJhRzgx?=
 =?utf-8?B?cDF1dUJRVmJ6RWJMSnNEZGVWWHRScXNFUjZhdExTa2twU2k1M1BBYWQ3M25V?=
 =?utf-8?B?OE9XVE9CNnM0dXlMRmRKVkxYMEFiZDY0Wm0ya2NFUDJhRDBnbzVMT0o3WjZh?=
 =?utf-8?B?QXdadjZ0K1N5b1pkb3JVMldLK1dIT0dIUkRaNTJZUDdScUt1N2NMVlFDSDJi?=
 =?utf-8?B?cDJxN01GeWJqU0hHV3ZvU0FCSnVPQXdENVN6c2huemlJRFAxOTJLU2Z5dVc1?=
 =?utf-8?B?NFRZR0dWZ2V6dHpGRDF6TnQ3UUpabjJMR3dUNGpVeXpqMllFeG9KZEc3Zi9t?=
 =?utf-8?B?Q2VKT3lxbTdMSjN3WURoaXZBRGErSVl0ck00L1lhK3prYzRvcjVkV2VWSlMw?=
 =?utf-8?B?MFMyK084aHE4VURHYVpWWGJWbG5nUWw3Z3Zub3c4VldBQnZCMWFEQi9UVXRp?=
 =?utf-8?B?QlhvaWhvaXJ2dUlQUE1BbmtTeEgxTTRtYlJMNi9CdGcyL2E3eWpFL1U0SkVG?=
 =?utf-8?B?Mno2YVRzcnBZZU1kWHVLbnk0QzBLSlkrdmtRL3lUL1JGOUZSYU5zMzFsa1pY?=
 =?utf-8?B?RG9LazJ2c01FWHE2VEw4UkRyQThGbzFFLzZNOS9zRkU2Q3FUYzJoNG56QTB6?=
 =?utf-8?B?T29OZi9zVnczZzdyb2pHZ2pET0JzemlrenEzQ255Q25UaWJ2ZWhjYm53L2Vu?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C71A93143C110C4186B828D3A18E1E21@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uIt9DTpkeN4d4z9EB3GKl+4C1l+Rn3tsTWsAb9MVxmYY9DkOoLbgezsOSpBCP/efDPx/sKTvkU5JyyS72lIuBBfDZrBkdfyxSuITFNLZxTNsqrlWOFLjwMrVFj5iY6/i9+b0pyjud/6C7yc1ECB2p0yk/IrKCbajHXrvxiNQvypsEhiHnA7LfjtO5wmm7U8oe48Ft86w/0b3xds/wzusWffaejeP1p2f3J9FxDZPoNkQkh4du2m9PuAlQ4RdNSEuw0rCa8Gth9f7gwhxb+2rOJT4bSeTk9gbu8l0i8UcLjdInxgt9eFj8oFdiUfPmZC++36C7OHf8ABXjsQoIV65MZY1P92vbUnWLeWHySevVEoE5/XF5KluK3pLLyzr9tHdiHOW+VCFPsb6Gph/kkxsLx+0HaESMDBViZsfA5h5V/stXkytgm9ZwDnFkWTFWtBG+24LwIWZBSMGH2QhOQdk9s8YmTutaP5XzMONaPlJGeiZRQbiKXVceHPu0VtH5YTKAEVgSvhnlpPG9pRlR2Mb6QTIWdKg5gNakDWY1ENBZC13IeKwBh4VCUW1Qw4LwdCofsAREzI1rFqIUZs+IB4mk70w18vNgZkIP6LanArm2Ic=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a64e43f-1fab-45ee-7337-08dd2c4e2942
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2025 23:27:16.7282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w/q7+rd/gnRAk+TNxsRoC3tZ8jpuxi6m/qSoZqAYh430VMjKgtNMNrh2pTQaiR80YTklNhoUNpPsOjhzOUH82koXCjQqlRnZOXOUIyKhFEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4858
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501030208
X-Proofpoint-ORIG-GUID: a9W1diEiUg_akX3KQyOMksPcZYO0zLbL
X-Proofpoint-GUID: a9W1diEiUg_akX3KQyOMksPcZYO0zLbL

DQoNCj4gT24gRGVjIDIzLCAyMDI0LCBhdCA1OjAx4oCvUE0sIE1pbWkgWm9oYXIgPHpvaGFyQGxp
bnV4LmlibS5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCAyMDI0LTEwLTE3IGF0IDA5OjU1IC0w
NjAwLCBFcmljIFNub3diZXJnIHdyb3RlOg0KPj4gSW50cm9kdWNlIGEgbmV3IHN5c3RlbSBrZXly
aW5nIGNhbGxlZCBjbGF2aXMuICBUaGlzIGtleXJpbmcgc2hhbGwgY29udGFpbg0KPj4gYSBzaW5n
bGUgYXN5bW1ldHJpYyBrZXkuIFRoaXMga2V5IG1heSBiZSBhIGxpbmtlZCB0byBhIGtleSBhbHJl
YWR5DQo+PiBjb250YWluZWQgaW4gb25lIG9mIHRoZSBzeXN0ZW0ga2V5cmluZ3MgKGJ1aWx0aW4s
IHNlY29uZGFyeSwgb3IgcGxhdGZvcm0pLg0KPiANCj4gQWx0aG91Z2ggIlRoaXMga2V5IG1heSBi
ZSBhIGxpbmtlZCB0byAuLi4iIGlzIG1pZ2h0IGJlIGNvcnJlY3QuICBCZWluZw0KPiBpbnRyb2R1
Y2VkIGluIHRoaXMgcGF0Y2ggaXMgb25seSB0aGUgYWJpbGl0eSBvZiBsb2FkaW5nIGEga2V5IGJ5
IHNwZWNpZnlpbmcgaXQNCj4gb24gdGhlIGJvb3QgY29tbWFuZCBsaW5lLiAgSW4gdGhpcyBjYXNl
LCB0aGUga2V5IG11c3QgYmUgb24gb25lIG9mIHRoZSBzeXN0ZW0NCj4ga2V5cmluZ3MuDQoNCkkn
bGwgcmV3b3JkIHRoaXMNCg0KPj4gT25lIHdheSB0byBhZGQgdGhpcyBrZXkgaW50byB0aGlzIGtl
eXJpbmcgaXMgZHVyaW5nIGJvb3QgYnkgcGFzc2luZyBpbiB0aGUNCj4+IGFzeW1tZXRyaWMga2V5
IGlkIHdpdGhpbiB0aGUgbmV3ICJjbGF2aXM9IiBib290IHBhcmFtLiAgSWYgYSBtYXRjaGluZyBr
ZXkNCj4+IGlzIGZvdW5kIGluIG9uZSBvZiB0aGUgc3lzdGVtIGtleXJpbmdzLCBhIGxpbmsgc2hh
bGwgYmUgY3JlYXRlZC4gVGhpcw0KPj4ga2V5cmluZyB3aWxsIGJlIHVzZWQgaW4gdGhlIGZ1dHVy
ZSBieSB0aGUgbmV3IENsYXZpcyBMU00uDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgU25v
d2JlcmcgPGVyaWMuc25vd2JlcmdAb3JhY2xlLmNvbT4NCj4+IC0tLQ0KPj4gLi4uL2FkbWluLWd1
aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCAgICAgICAgIHwgICA2ICsNCj4+IGluY2x1ZGUvbGlu
dXgvaW50ZWdyaXR5LmggICAgICAgICAgICAgICAgICAgICB8ICAgOCArKw0KPj4gc2VjdXJpdHkv
S2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4+IHNlY3VyaXR5
L01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+PiBzZWN1cml0
eS9jbGF2aXMvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgfCAgMTEgKysNCj4+IHNlY3Vy
aXR5L2NsYXZpcy9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICB8ICAgMyArDQo+PiBzZWN1
cml0eS9jbGF2aXMvY2xhdmlzLmggICAgICAgICAgICAgICAgICAgICAgfCAgMTMgKysNCj4+IHNl
Y3VyaXR5L2NsYXZpcy9jbGF2aXNfa2V5cmluZy5jICAgICAgICAgICAgICB8IDExNSArKysrKysr
KysrKysrKysrKysNCj4+IHNlY3VyaXR5L2ludGVncml0eS9paW50LmMgICAgICAgICAgICAgICAg
ICAgICB8ICAgMiArDQo+PiA5IGZpbGVzIGNoYW5nZWQsIDE2MCBpbnNlcnRpb25zKCspDQo+PiBj
cmVhdGUgbW9kZSAxMDA2NDQgc2VjdXJpdHkvY2xhdmlzL0tjb25maWcNCj4+IGNyZWF0ZSBtb2Rl
IDEwMDY0NCBzZWN1cml0eS9jbGF2aXMvTWFrZWZpbGUNCj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBz
ZWN1cml0eS9jbGF2aXMvY2xhdmlzLmgNCj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBzZWN1cml0eS9j
bGF2aXMvY2xhdmlzX2tleXJpbmcuYw0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQgYi9Eb2N1bWVudGF0aW9uL2FkbWlu
LWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KPj4gaW5kZXggMTUxODM0M2JiZTIyLi5kNzEz
OTdlN2QyNTQgMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5l
bC1wYXJhbWV0ZXJzLnR4dA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJu
ZWwtcGFyYW1ldGVycy50eHQNCj4+IEBAIC02NDUsNiArNjQ1LDEyIEBADQo+PiBjaW9faWdub3Jl
PSBbUzM5MF0NCj4+IFNlZSBEb2N1bWVudGF0aW9uL2FyY2gvczM5MC9jb21tb25faW8ucnN0IGZv
ciBkZXRhaWxzLg0KPj4gDQo+PiArIGNsYXZpcz0gW1NFQ1VSSVRZLEVBUkxZXQ0KPj4gKyBJZGVu
dGlmaWVzIGEgc3BlY2lmaWMga2V5IGNvbnRhaW5lZCBpbiBvbmUgb2YgdGhlIHN5c3RlbQ0KPj4g
KyBrZXlyaW5ncyAoYnVpbHRpbiwgc2Vjb25kYXJ5LCBvciBwbGF0Zm9ybSkgdG8gYmUgdXNlZCBh
cw0KPj4gKyB0aGUgQ2xhdmlzIHJvb3Qgb2YgdHJ1c3QuDQo+PiArIEZvcm1hdDogeyA8a2V5aWQ+
IH0NCj4gDQo+IEluY2x1ZGUgLm1hY2hpbmUga2V5cmluZyBoZXJlLg0KDQphbmQgSSdsbCBhZGQg
dGhpcyB0b28uDQoNCj4+ICsNCj4+IGNsZWFyY3B1aWQ9WFssWC4uLl0gW1g4Nl0NCj4+IERpc2Fi
bGUgQ1BVSUQgZmVhdHVyZSBYIGZvciB0aGUga2VybmVsLiBTZWUNCj4+IGFyY2gveDg2L2luY2x1
ZGUvYXNtL2NwdWZlYXR1cmVzLmggZm9yIHRoZSB2YWxpZCBiaXQNCj4+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L2ludGVncml0eS5oIGIvaW5jbHVkZS9saW51eC9pbnRlZ3JpdHkuaA0KPj4g
aW5kZXggZjU4NDIzNzIzNTliLi44MzdjNTJlMWQ4M2IgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRl
L2xpbnV4L2ludGVncml0eS5oDQo+PiArKysgYi9pbmNsdWRlL2xpbnV4L2ludGVncml0eS5oDQo+
PiBAQCAtMjMsNiArMjMsMTQgQEAgZW51bSBpbnRlZ3JpdHlfc3RhdHVzIHsNCj4+ICNpZmRlZiBD
T05GSUdfSU5URUdSSVRZDQo+PiBleHRlcm4gdm9pZCBfX2luaXQgaW50ZWdyaXR5X2xvYWRfa2V5
cyh2b2lkKTsNCj4+IA0KPj4gKyNpZmRlZiBDT05GSUdfU0VDVVJJVFlfQ0xBVklTDQo+PiArdm9p
ZCBfX2luaXQgbGF0ZV9pbml0X2NsYXZpc19zZXR1cCh2b2lkKTsNCj4+ICsjZWxzZQ0KPj4gK3N0
YXRpYyBpbmxpbmUgdm9pZCBsYXRlX2luaXRfY2xhdmlzX3NldHVwKHZvaWQpDQo+PiArew0KPj4g
K30NCj4+ICsjZW5kaWYNCj4+ICsNCj4+ICNlbHNlDQo+PiBzdGF0aWMgaW5saW5lIHZvaWQgaW50
ZWdyaXR5X2xvYWRfa2V5cyh2b2lkKQ0KPj4gew0KPj4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L0tj
b25maWcgYi9zZWN1cml0eS9LY29uZmlnDQo+PiBpbmRleCAyOGU2ODVmNTNiZDEuLjcxNGVjMDhk
ZGE5NiAxMDA2NDQNCj4+IC0tLSBhL3NlY3VyaXR5L0tjb25maWcNCj4+ICsrKyBiL3NlY3VyaXR5
L0tjb25maWcNCj4+IEBAIC0yMjUsNiArMjI1LDcgQEAgc291cmNlICJzZWN1cml0eS9zYWZlc2V0
aWQvS2NvbmZpZyINCj4+IHNvdXJjZSAic2VjdXJpdHkvbG9ja2Rvd24vS2NvbmZpZyINCj4+IHNv
dXJjZSAic2VjdXJpdHkvbGFuZGxvY2svS2NvbmZpZyINCj4+IHNvdXJjZSAic2VjdXJpdHkvaXBl
L0tjb25maWciDQo+PiArc291cmNlICJzZWN1cml0eS9jbGF2aXMvS2NvbmZpZyINCj4+IA0KPj4g
c291cmNlICJzZWN1cml0eS9pbnRlZ3JpdHkvS2NvbmZpZyINCj4+IA0KPj4gZGlmZiAtLWdpdCBh
L3NlY3VyaXR5L01ha2VmaWxlIGIvc2VjdXJpdHkvTWFrZWZpbGUNCj4+IGluZGV4IGNjMDk4MjIx
NGI4NC4uNjk1NzY1NTEwMDdhIDEwMDY0NA0KPj4gLS0tIGEvc2VjdXJpdHkvTWFrZWZpbGUNCj4+
ICsrKyBiL3NlY3VyaXR5L01ha2VmaWxlDQo+PiBAQCAtMjYsNiArMjYsNyBAQCBvYmotJChDT05G
SUdfQ0dST1VQUykgKz0gZGV2aWNlX2Nncm91cC5vDQo+PiBvYmotJChDT05GSUdfQlBGX0xTTSkg
Kz0gYnBmLw0KPj4gb2JqLSQoQ09ORklHX1NFQ1VSSVRZX0xBTkRMT0NLKSArPSBsYW5kbG9jay8N
Cj4+IG9iai0kKENPTkZJR19TRUNVUklUWV9JUEUpICs9IGlwZS8NCj4+ICtvYmotJChDT05GSUdf
U0VDVVJJVFlfQ0xBVklTKSArPSBjbGF2aXMvDQo+PiANCj4+ICMgT2JqZWN0IGludGVncml0eSBm
aWxlIGxpc3RzDQo+PiBvYmotJChDT05GSUdfSU5URUdSSVRZKSArPSBpbnRlZ3JpdHkvDQo+PiBk
aWZmIC0tZ2l0IGEvc2VjdXJpdHkvY2xhdmlzL0tjb25maWcgYi9zZWN1cml0eS9jbGF2aXMvS2Nv
bmZpZw0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uMDRm
NzU2NWYyZTJiDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9zZWN1cml0eS9jbGF2aXMvS2Nv
bmZpZw0KPj4gQEAgLTAsMCArMSwxMSBAQA0KPj4gK2NvbmZpZyBTRUNVUklUWV9DTEFWSVMNCj4+
ICsgYm9vbCAiQ2xhdmlzIGtleXJpbmciDQo+IA0KPiBJc24ndCBTRUNVUklUWV9DTEFWSVMgdGhl
IG5ldyBMU00/ICBXaHkgaXMgdGhlIGJvb2wgZGVmaW5lZCBhcyBqdXN0ICJDbGF2aXMNCj4ga2V5
cmluZyI/DQo+IA0KPj4gKyBkZXBlbmRzIG9uIFNFQ1VSSVRZDQo+PiArIHNlbGVjdCBTWVNURU1f
REFUQV9WRVJJRklDQVRJT04NCj4+ICsgc2VsZWN0IENSWVBUT19TSEEyNTYNCj4+ICsgaGVscA0K
Pj4gKyAgIEVuYWJsZSB0aGUgY2xhdmlzIGtleXJpbmcuIFRoaXMga2V5cmluZyBzaGFsbCBjb250
YWluIGEgc2luZ2xlIGFzeW1tZXRyaWMga2V5Lg0KPj4gKyAgIFRoaXMga2V5IHNoYWxsIGJlIGxp
bmtlZCB0byBhIGtleSBhbHJlYWR5IGNvbnRhaW5lZCBpbiBvbmUgb2YgdGhlIHN5c3RlbQ0KPj4g
KyAgIGtleXJpbmdzIChidWlsdGluLCBzZWNvbmRhcnksIG9yIHBsYXRmb3JtKS4gT25lIHdheSB0
byBhZGQgdGhpcyBrZXkNCj4+ICsgICBpcyBkdXJpbmcgYm9vdCBieSBwYXNzaW5nIGluIHRoZSBh
c3ltbWV0cmljIGtleSBpZCB3aXRoaW4gdGhlICJjbGF2aXM9IiBib290DQo+PiArICAgcGFyYW0u
ICBUaGlzIGtleXJpbmcgaXMgcmVxdWlyZWQgYnkgdGhlIENsYXZpcyBMU00uDQo+IA0KPiBJZiBT
RUNVUklUWV9DTEFWSVMgaXMgYSBuZXcgTFNNLCB0aGUgJ2hlbHAnIHNob3VsZG4ndCBiZSBsaW1p
dGVkIHRvIGp1c3QgdGhlDQo+IGNsYXZpcyBrZXlyaW5nLCBidXQgd3JpdHRlbiBhdCBhIGhpZ2hl
ciBsZXZlbCBkZXNjcmliaW5nIHRoZSBuZXcgTFNNLiAgRm9yDQo+IGV4YW1wbGUsDQo+IA0KPiBU
aGlzIG9wdGlvbiBlbmFibGVzIHRoZSBDbGF2aXMgTFNNLCB3aGljaCBwcm92aWRlcyB0aGUgYWJp
bGl0eSB0byBjb25maWd1cmUgYW5kDQo+IGVuZm9yY2UgdGhlIHVzYWdlIG9mIGtleXMgY29udGFp
bmVkIG9uIHRoZSBzeXN0ZW0ga2V5cmluZ3MgLQ0KPiAuYnVpbHRpbl90cnVzdGVkX2tleXMsIC5z
ZWNvbmRhcnlfdHJ1c3RlZF9rZXlzLCAubWFjaGluZSwgYW5kIC5wbGF0Zm9ybQ0KPiBrZXlyaW5n
cy4gIFRoZSBjbGF2aXMgTFNNIGRlZmluZXMgYSBrZXlyaW5nIG5hbWVkICJjbGF2aXMiLCB3aGlj
aCBjb250YWlucyBhDQo+IHNpbmdsZSBhc3ltbWV0cmljIGtleSBhbmQgdGhlIGtleSB1c2FnZSBy
dWxlcy4NCj4gDQo+IFRoZSBzaW5nbGUgYXN5bW1ldHJpYyBrZXkgbWF5IGJlIHNwZWNpZmllZCBv
biB0aGUgYm9vdCBjb21tYW5kIGxpbmUgLi4uDQo+IA0KPiBbVGhlIHBhdGNoIHRoYXQgaW50cm9k
dWNlcyB0aGUga2V5IHVzYWdlIHJ1bGVzIHdvdWxkIGFkZCBhZGRpdGlvbmFsIGluZm8gaGVyZS5d
DQo+IA0KPiBbVGhlIHBhdGNoIHRoYXQgYWRkcyB0aGUgRG9jdW1lbnRhdG9pbiB3b3VsZCBhZGQg
YSByZWZlcmVuY2UgaGVyZS5dDQoNCkkgd2VudCB0aGUgcm91dGUgb2YgY3JlYXRpbmcgdGhlIGtl
eXJpbmcgaW4gdGhpcyBwYXRjaCBhbmQgdGhlbiBpbnRyb2R1Y2luZyB0aGUgDQpMU00gd2hpY2gg
dXNlcyBpdCBpbiBhIGxhdGVyIHBhdGNoLiAgTXkgcmVhc29uaW5nIHdhcyBpdCBjYW4gYmUgdGVz
dGVkIA0KaW5kZXBlbmRlbnRseS4gIEFsc28sIEkgdGhvdWdodCBpdCB3b3VsZCBtYWtlIGl0IGVh
c2llciB0byByZXZpZXcsIHNpbmNlIA0KZXZlcnl0aGluZyBpc24ndCBjb250YWluZWQgd2l0aGlu
IGEgc2luZ2xlIHBhdGNoLiAgSSBjb3VsZCBsb29rIGF0IGNvbWJpbmluZyANCnRoZW0gdG9nZXRo
ZXIgaWYgeW91IHRoaW5rIHRoYXQgd291bGQgYmUgYmV0dGVyLg0KDQo+IA0KPj4gZGlmZiAtLWdp
dCBhL3NlY3VyaXR5L2NsYXZpcy9NYWtlZmlsZSBiL3NlY3VyaXR5L2NsYXZpcy9NYWtlZmlsZQ0K
Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uMTZjNDUxZjQ1
ZjM3DQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9zZWN1cml0eS9jbGF2aXMvTWFrZWZpbGUN
Cj4+IEBAIC0wLDAgKzEsMyBAQA0KPj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjANCj4+ICsNCj4+ICtvYmotJChDT05GSUdfU0VDVVJJVFlfQ0xBVklTKSArPSBjbGF2aXNfa2V5
cmluZy5vDQo+PiBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvY2xhdmlzL2NsYXZpcy5oIGIvc2VjdXJp
dHkvY2xhdmlzL2NsYXZpcy5oDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAw
MDAwMDAwMDAwLi41ZTM5N2I1NWE2MGENCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL3NlY3Vy
aXR5L2NsYXZpcy9jbGF2aXMuaA0KPj4gQEAgLTAsMCArMSwxMyBAQA0KPj4gKy8qIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICovDQo+PiArI2lmbmRlZiBfU0VDVVJJVFlfQ0xBVklT
X0hfDQo+PiArI2RlZmluZSBfU0VDVVJJVFlfQ0xBVklTX0hfDQo+PiArI2luY2x1ZGUgPGtleXMv
YXN5bW1ldHJpYy10eXBlLmg+DQo+PiArDQo+PiArLyogTWF4IGxlbmd0aCBmb3IgdGhlIGFzeW1t
ZXRyaWMga2V5IGlkIGNvbnRhaW5lZCBvbiB0aGUgYm9vdCBwYXJhbSAqLw0KPj4gKyNkZWZpbmUg
Q0xBVklTX0JJTl9LSURfTUFYICAgMzINCj4+ICsNCj4+ICtzdHJ1Y3QgYXN5bW1ldHJpY19zZXR1
cF9raWQgew0KPj4gKyBzdHJ1Y3QgYXN5bW1ldHJpY19rZXlfaWQgaWQ7DQo+PiArIHVuc2lnbmVk
IGNoYXIgZGF0YVtDTEFWSVNfQklOX0tJRF9NQVhdOw0KPj4gK307DQo+PiArI2VuZGlmIC8qIF9T
RUNVUklUWV9DTEFWSVNfSF8gKi8NCj4+IGRpZmYgLS1naXQgYS9zZWN1cml0eS9jbGF2aXMvY2xh
dmlzX2tleXJpbmcuYyBiL3NlY3VyaXR5L2NsYXZpcy9jbGF2aXNfa2V5cmluZy5jDQo+PiBuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi40MDBlZDQ1NWEzYTINCj4+
IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL3NlY3VyaXR5L2NsYXZpcy9jbGF2aXNfa2V5cmluZy5j
DQo+PiBAQCAtMCwwICsxLDExNSBAQA0KPj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wDQo+PiArDQo+PiArI2luY2x1ZGUgPGxpbnV4L3NlY3VyaXR5Lmg+DQo+PiArI2luY2x1
ZGUgPGxpbnV4L2ludGVncml0eS5oPg0KPj4gKyNpbmNsdWRlIDxrZXlzL2FzeW1tZXRyaWMtdHlw
ZS5oPg0KPj4gKyNpbmNsdWRlIDxrZXlzL3N5c3RlbV9rZXlyaW5nLmg+DQo+PiArI2luY2x1ZGUg
ImNsYXZpcy5oIg0KPj4gKw0KPj4gK3N0YXRpYyBzdHJ1Y3Qga2V5ICpjbGF2aXNfa2V5cmluZzsN
Cj4+ICtzdGF0aWMgc3RydWN0IGFzeW1tZXRyaWNfa2V5X2lkICpjbGF2aXNfYm9vdF9ha2lkOw0K
Pj4gK3N0YXRpYyBzdHJ1Y3QgYXN5bW1ldHJpY19zZXR1cF9raWQgY2xhdmlzX3NldHVwX2FraWQ7
DQo+PiArc3RhdGljIGJvb2wgY2xhdmlzX2VuZm9yY2VkOw0KPj4gKw0KPj4gK3N0YXRpYyBib29s
IGNsYXZpc19hY2xfZW5mb3JjZWQodm9pZCkNCj4+ICt7DQo+PiArIHJldHVybiBjbGF2aXNfZW5m
b3JjZWQ7DQo+PiArfQ0KPiANCj4gQWRkIGJsYW5rIGxpbmUgYmV0d2VlbiBmdW5jdGlvbnMuDQoN
CkknbGwgYWRkIHRoZSBibGFuayBsaW5lIGluIHRoZSBuZXh0IHJvdW5kLiAgVGhhbmtzLg0KDQoN
Cg==

