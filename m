Return-Path: <linux-efi+bounces-2507-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0758A02EB7
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jan 2025 18:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D08F3A44F8
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jan 2025 17:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3854D1369B4;
	Mon,  6 Jan 2025 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XZ1CQAGJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sBaTXm7L"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965A81547F2;
	Mon,  6 Jan 2025 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736183789; cv=fail; b=sFFk6rOxX++oXVf21NQTAMlTH+AOZMad57o0sdpFMyi0TWyvSfJsKQLcn/JTdsM7dzv+4Q7AZfS7U6SmAaI8d0SMiN1FBnkvN6L2RpaT0gntDyJab0M+iGMDX2PQH08sE8l2aZeOC9azGScreGDgUykrzaOe9C245nJwbY6vgJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736183789; c=relaxed/simple;
	bh=3WjVQmDVamdLo7KMjXd0vIrPSrLdgVcJIS/K4vIe6Y4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ij4SxqxjKCSWyArJq8DlBJf0XZg08jFbtl+r6O8zcLIR77rRp+hoklxEm2PFoaoADaDydinP4Q7SAhI1yyrkhhZN10Thwy+x0s1MMlsbMKoATvW3tBDH9x9CZqQiNE7e04YoXmYGBErcinSX80MAPq5d0nypDCjQGCztMD/scmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XZ1CQAGJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sBaTXm7L; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506HBsQx018141;
	Mon, 6 Jan 2025 17:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=3WjVQmDVamdLo7KMjXd0vIrPSrLdgVcJIS/K4vIe6Y4=; b=
	XZ1CQAGJlRM28K7EnqVcyiOMdbW7GX8oIA48CzJCjVfpoF+/RuSN3OPL2hhkt6iW
	BxjLuW8Q168sTqTUHvYvaWUKyjaYRWF70GXF+bmDCpZDD+LDMi0C27DrE7ave9i6
	+960qmWWKeQ4c8M6yR5OzF055JftTwTAXgLTMCGeZwyAi1M2xtclzPnVkPN9WVY1
	yRTIiZw1DhTo2/x6ivXRl5VIIKJqe/Na5zKKz09wEoPn0W9RowVRFp4SQupv/0Ga
	VotkMK4DKfqN5ejzM6Qp/m5OrP9KhAYBjnuP2bB9ghMjABg8WLvKLcX2gBNS8b48
	M+CdF6aljcifHIN5MtIDBA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xvkstrhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jan 2025 17:15:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 506GH5de002803;
	Mon, 6 Jan 2025 17:15:46 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xue7h18e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jan 2025 17:15:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uaQDqfZX2BeGdfWFBoOrBHJjUv+YTjzVlohr/hRnGBUjDKUm8ETNc5Ew+bHCcFTj0ONKFipjJF3sEULZfzOmXTeslZ6p60Ktecp0Mh6xTLYczGrKFS5kCpqrxFvql+wEC+p0bldYtRXL4NS0F1i16v7jZX0XnnGMkCbSYG13r4MPb7Ts/qfURlmCqf31HlMt4W+DI1+QQcSD0BvPIr4r/HegYJAz96zV15amr6RWpl5BlCG2P73fnvSHdF4eziCvQv1M9Bc8/jKJ5zfFitV90kEDUAj4N/O3hXWi30UAvgSm3ybi/k9/qxCjC9ga93ArWRJLghuUOt2HmJwC7NgvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WjVQmDVamdLo7KMjXd0vIrPSrLdgVcJIS/K4vIe6Y4=;
 b=XV2tWn+lvrd8MACTI8kxUeJT7m8n1F+/OSXCrR7OV++PM4dbHNQh56GNuR0vpkizef06VMbn5qSXNnW+QvmYDYpJG0Z25mmWFJzAYM38RskqwWqMdeCIvB4ZUOGZYf+wgbtBfCTkbOItE5VBFH3Au2Q65w1HeX6SF66BQ73kchAjPuEy0XZ6c6vFo6vnqYlF3lDxTJ7/73VRaTeu3ktdQ/MIkc+uawfiuG8BxnbUfpQlbkBhfNwL/rvUJf+J4PONSRDBadSXZ2i9QuYWuOSM6DFITj4C1F5FLTcm0yqx64ncnpenvCZ9JT0eOfYnGlMCFfispOYnTo5fGGN9o8l46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WjVQmDVamdLo7KMjXd0vIrPSrLdgVcJIS/K4vIe6Y4=;
 b=sBaTXm7LN/uRaASHd/SFaHvPtP2VVOt4llxUHO4Eu7oL8RALhNIErRG4YHwPeI7wZFCP7AYrJlPHaBSrA8Pe3+A5+/duxxgNmahwmFxh9FXbyqV89MctYr3eS8shNJt30cvBjzjPWa715ec6+rDis8eBQwPGHhya4SN10PJu6B4=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by CH4PR10MB8075.namprd10.prod.outlook.com (2603:10b6:610:236::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 17:15:40 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 17:15:40 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: Paul Moore <paul@paul-moore.com>, David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC: Mimi Zohar <zohar@linux.ibm.com>,
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
Thread-Index: AQHbIK0E/vdc4Eou30K4SgPRfeDFerL0Jc4AgBIDLwCAAF1+gIADEbkAgADjnYA=
Date: Mon, 6 Jan 2025 17:15:40 +0000
Message-ID: <E20C617B-EA01-4E69-B5E2-31E9AAD6F7A2@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <c490397315c2704e9ef65c8ad3fefedb239f1997.camel@linux.ibm.com>
 <72F52F71-C7F3-402D-8441-3D636A093FE8@oracle.com>
 <CAHC9VhRHEw5c+drC=aX4xTqWoQJJZ+qkJ7aHUT5dcu+Q5f7BqA@mail.gmail.com>
 <CAHC9VhSJpnaAK1efgs1Uk0Tr3CaDNR1LiDU-t_yDKDQG6J-74Q@mail.gmail.com>
In-Reply-To:
 <CAHC9VhSJpnaAK1efgs1Uk0Tr3CaDNR1LiDU-t_yDKDQG6J-74Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|CH4PR10MB8075:EE_
x-ms-office365-filtering-correlation-id: db816eff-b8c8-49fb-ba81-08dd2e75becb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VzJXdThGa3g5RjhDdkVnTHlIT3lPdis1WHVxM0RIY0Q5TXF4eHEwUGgyZmhN?=
 =?utf-8?B?TFdGSStML0h1ZmdoSGdJVjdoajljMDhlZUhtK3QrU2JuOUR0ZkUwOTlaN0FL?=
 =?utf-8?B?MVAzRFNSZjQzMElqUTNKRVdsWjY5bDYrUU9uOHVJT2R5M01oMkd0YzRrQXQx?=
 =?utf-8?B?d1BmOExiTUZ4S3lWMm1lK0tIc0RjcTFrbkhlYk83ZW00eGhYVXVWd1hPdUZy?=
 =?utf-8?B?ZXlGUURUUURPS1B0Z3YxcXQyRWRONW01Z2ZiWlZSVHN5SG83NzhlR29FTmVy?=
 =?utf-8?B?SCttM0l4ZmZoRk4zQWtJZUhmOTg1WXhGdzVNMHNUSUFjU3JITGNWVHNTNk9Q?=
 =?utf-8?B?cVpiaTdka2ZiTzk5emIzaEtDUGh3bWl5eTZPSkNNcFFlV0JlUGVtODIxeFg1?=
 =?utf-8?B?T2JlamtiUlJ4SWl6R2tDbjQ0NE1qR01wc2xxd1Y4YTNodXA1bStHV1NYVnlC?=
 =?utf-8?B?ZFEyRTdCTkhyOUNFQUlTMUNjZmo4WFBvUjFqRXY1ZUJsajVROFY2SDJzV01R?=
 =?utf-8?B?b0JReG9UeTJoM20zdHdJSG5nOWZid1VIYjladERTZWFOVW4rc3BDa0dONDdO?=
 =?utf-8?B?UGhlOFhwem9XNWtJUmZ3TlRSeFlweUdJZFlWaktYbWdvT2dBTGoxMi9zVDVK?=
 =?utf-8?B?T2htL2NZWmFjQ293OWE2cFdDTXlCbU9LUU02UG9zZFN1UGc4bFhpMDFWdG02?=
 =?utf-8?B?M2pLaEVBdWFqUzAvTmpFSXRlTUc5WVFrTno5RmxZTUliSFJPOU1IdUgxRk5U?=
 =?utf-8?B?eTJIZC80cFYvZVpaTHVoejlQOHd5WGlkWGhHOXlJVC9kaFlZYUJjUWQzZVJ5?=
 =?utf-8?B?TFlaU0RaUXd0QlFhclZrWHU1WjZNNndMeXlYMHNkZ216UzhCTmFrTGs5QVVI?=
 =?utf-8?B?NnhRV24yMm4rOVg0S01lRFBoQTBUR0ltT3JVd2NjTjFOQUJKVk1iTHVWWEt4?=
 =?utf-8?B?eXpLRjBZNVVyRW03QXFua3lnRk9FMDRseXVUY2kwOE1SNFlDVGVDUTE0alpT?=
 =?utf-8?B?VVM5YkkzdU9BYzQ5em50UElDSkNVSlNqMzdYRlhiT0oxSlZoVWE4eUd4N1U3?=
 =?utf-8?B?U2FQL2x6Q0tVVzV2M0xLTk81STdhQjA2VEVvZWM3anE3MEJ5QlFvdXB0MDFX?=
 =?utf-8?B?ZlR5aTlkV1lEOHlReEJtVThCSnh4MFNuRk5TSEtUSnRQLzB5YkloVlZJQmZr?=
 =?utf-8?B?eU1hMWRVSU9Nb2JjczNVWVRVVDN4VU14M21ydVFsbElnRVlEMFZtODFMZTNx?=
 =?utf-8?B?dndJT2FvYVl5T2RJc1pSL0praG5QT3pNWnRzREY2SUE1TWR3K0dWdEZmUFhL?=
 =?utf-8?B?THVIQnhwOTlIeVcwem41NUtmSGZQNDk0dzlRa2VpL0hrcEVSNks2MVJZbmdO?=
 =?utf-8?B?bWlwai9EZVFtU1psbGlKa2tJZWdvR3JtdEtFQXZ2bTNOVVptS0dCQUZPN1hM?=
 =?utf-8?B?N1lCZ1E2SStVeXpvZ29BODRuU3FLcXQ1UWt0ZmhaTzA2RFlwVW04Z1lXYnM0?=
 =?utf-8?B?ZVpzY0pWblFtK1lxZjNYOGlwUWl6M1dscDNKa1Q2a0xJRGJENFBzZVVyTlYy?=
 =?utf-8?B?WnNKT0lZb2dCNTZnWFVGM0VyRExia0M2UHhNOWR0UVF0UFdtUVFvWDg5ektD?=
 =?utf-8?B?aHIyOWFnaGVmc1JDYWl1VjdCVUJMQlgwdUhESVhrMDVZK05OWWlmcW5RZEZJ?=
 =?utf-8?B?QVdoa3dUMHZWMmdadG5xR2FOOGlHYjNFVFdnVHFERVBwb0hWUkFoY25qR2NT?=
 =?utf-8?B?TWoyRzlOdGJCUzZtcU14endXQk5XeWlEMlFaazQya0g5b3FBaUdER25YM0t1?=
 =?utf-8?B?ZFMzNFQwNnVmbXRiVzhTRG44NWcvYnpNZzdGOU1ERzFVblZlWDdaSWpCL2FS?=
 =?utf-8?B?SGMwa0FWSmwzQVhOUDlhSWNScU0yajFadFRXNlZMRUJGOW92MVZ0T01VWDVn?=
 =?utf-8?Q?Zt/qxuh5eLoYH0ymWqquKZ93TFMD38/j?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WnFhMkhoYXl4bkxRbVBmUW93eEg3V3A1bll2OHBJQjJtVjBMM2lTWmpsdHRI?=
 =?utf-8?B?ZFYwMlNWQ0J1Z2lrZXJXUnk0R29KYndJb0Z6U0F4bDZvRU82dy8wTTFmOUls?=
 =?utf-8?B?N3Fld1p0TkduSzVIeitkN0htZ3FXUkR5MUErRXRXQS81cWxsbjZvUnp3ZkRL?=
 =?utf-8?B?clNPZmI0VjNTVDlpS2ZTYU9OZmM3bU1ROVUzODlXajdUVDBEZ1BsSkwyVGR1?=
 =?utf-8?B?WmFaSllScVVGSlVJYmdPWkFaTkpQaW56S2ZZcTFPNzVSVk82YjJmMXJZbk8r?=
 =?utf-8?B?RFoydzJYWjNpRlJSQzhJQ3BvdThHVk5jTVZGczJDWjZsSjdQQlVZMTdBS29I?=
 =?utf-8?B?aHI1VXhKcTBsbGd0T0h1WjZLM05UMkFsMjhEeW56WUl4RTlOdzFmSHBGV2gx?=
 =?utf-8?B?NTVRS0UrRzlNUVBldnFOUXFocisrZUk2VXdkblI3NWM2M2NKYXp3OGQ0Q3Rj?=
 =?utf-8?B?b2dLZ2hYcG02cmlQOURNYWh1d1Z4ZFYraG9PQWNVOVNZSzNzRUNTZXNIdmI5?=
 =?utf-8?B?RVZIRDFNS1p6aEEvMllad0Q5M2UvOEttUHBpNjhpQm1VdGFGazc4OXB4anlU?=
 =?utf-8?B?dDFraTV6Wm1DMlBnWnhFcXZoSDJleHJva0s4VFNYelR3NTYzRWdtTUg3WTc4?=
 =?utf-8?B?ZFc2ckxmNVBqMWRBR0lMSUtiTjZEeW1SeFFBK0FCOFg0c3FhQmdJcDU5eVRW?=
 =?utf-8?B?aFlYRElOMnJQTW9NcnhuUmdLMWVVZzNucFIzZkRkWHZ2KzNpQllTMnUrT0FG?=
 =?utf-8?B?TFRJOCtQb2Zsd2VITFlsY0JydE9kb3dBcDdDc2pSWjAxK29HMkl6SzY1azRi?=
 =?utf-8?B?Y1FFOXNNRlo0UXh6RWRBMXJOdWx4VmdwRUlOMk5BYXIxRFNuanpZQTY0M0Y4?=
 =?utf-8?B?dzQ2QkxtSzQvVk12NnFoYUViaEZSUldWZ096cXI3M3VabHVDVzM1aElZeFhN?=
 =?utf-8?B?bm81Z2k1UGtYa1lTTEhONmsxREFvY3dpU20rVHNBYjFteW5BZlk1Z1QyaHBS?=
 =?utf-8?B?eFRNckgzL1pDTDE3Y2lDT21ybmNHajlLVkhtTHY4MWJFSGhhV1VKWGUrNXNU?=
 =?utf-8?B?bjZDNWxsaU9vWThXTjV0U1MzUUVSNzh0ZkluMTVLcmw4L054Ry82VGRhdk9q?=
 =?utf-8?B?SkREUlVoTFJQQzlONXY3SE1RaWkrWDZZb1dFbVl5NkpCMEpvbjA4ZHpaRDNn?=
 =?utf-8?B?UXRYQ0dDK3NRTy9WUTZ0RThRTGUzMTJZVlB5aUtOSmMzY2VFbnN6bnU0MHBJ?=
 =?utf-8?B?Q1gwbkNTbEcySWJnODZWcXI2bk40bnZGdS9iNFR3UXRtS1p2MzhNRkJyeWlN?=
 =?utf-8?B?Y0Mzc3JoNVhFWUpRQnBYM1RSTXVBM01HcXZkYVExMmNyNU9ZMVRRc2JjRlJx?=
 =?utf-8?B?Zk9DMEZNRXhRZ1JwWlI3L1B6OHdhUEZ5clU4WnNVdy85c1l4OTFqMkFxQ2t5?=
 =?utf-8?B?d3VaT1hackU0Uzc1WHpiUEVTQXVFZU5zQ2w4eTRuN3NlcDVJelFCL1daZ0Z4?=
 =?utf-8?B?RFlXT21ydVc0UTBEUk9mL2ZyKyt6c3dtdDY0dk5kSXVGampyS2x2UnN5TXFG?=
 =?utf-8?B?NHVTUUZwTUo5dDN1VUhiTjc1OHZHUW9aNDRkblpmdnFQaUhMR2o1MjdvaWVD?=
 =?utf-8?B?QkFqSDBqUjRnQTBNdGZxWWFTRitqVjNXczFyV0xMeEVUU3dsbE12Vk5JSDdk?=
 =?utf-8?B?c0NpcUtIenJGTUY1WitDSnpjZW9mQUE5MjZXR0w4eDFEbCtmZGVlQ1hGUXgv?=
 =?utf-8?B?STNiSjZKMXIrQnkyQjZPUE54SU40eFdOVlpUQmZEODVBSE5lTUtWTVg1b1o1?=
 =?utf-8?B?d1dadmgveTRnTmhzU1JUYnlnTVpuRWt5dEJjZ0lTQnlZNkx2U0NaRUxOUHk5?=
 =?utf-8?B?Ykt1STd4cEYrVkdWSnBYU29XekJEdjRnSHFIYTA0MUxiMWhZTjNOb1BWb1o4?=
 =?utf-8?B?OHNJaXVUREZKeGkzZ04xWHpLdVlRYmdNaU0rM0xEcHI2TnE3cFhOYzg3eEpB?=
 =?utf-8?B?SFdNZEc2ZjVkU1FBMHhZdEMzOHRQVmd2dW40MjIwa0Jsd3QzS3B0MnNCb1ow?=
 =?utf-8?B?ditDRG90QlF3WFVCWGppVmRWQzF2U1FpYVMzSmI5TlZyejJ0eFNyakw0Y0RQ?=
 =?utf-8?B?UXYxbk5vMFZ2MlhaUEtDSndUaXNRek8vaW5BbXcvcUQyNFdjSWFsMVAzUWZQ?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E209867240EBB645AF29C3287576AF7E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DIoJtsPuwpgDo92NIO/XyWfuBXfuY7zrf1m+DEvBjrwGXTRYQe8IDeJ68i8ewEZiNZTJGNGuPBcOQ6WrD8sHnsLgR7R3jU2dau8xDfdukk9dcLZsy/X+AFAUS6GhJN/FwJh91742s+UZ8BZnnzhundBpTDjZu0Yg+CAIMv51a/2cNKZBFEaNamNfcehsrW5lD8m2sPxp2IAY2hqLhJjBuIVp66fjfVl8BFysHY3dYQEB+o901FYWEB2oxe5b0qI4HOPlYo5NLmCWXRwU6snfFPnvtdpz6/qhBevpnt7zQ2QB+3LmNkXFp5A1CsMl3mKZ9PhEqHMx74JdgQMJwwJLcftA5LHzo8bGPxPtE5o30rE6u/8nzsA7yq40aDbHr09QNI4LnUzBzUfJgXkpONzPQWEJElltCrzydDznoCmm/QgLz1oRTglHUiDSOTeRd4JBl1E8ru+OVTh67YY939FTkzhmsv7Ii0uVEKWGt4+rU0TFm5aC4pATjKbtsc7Tq0CocCLUaKgBMFuu8Liojp9dCf8/Uecuii+Ud+8lrz9t8ijBuHRxbIh5I2QSa3c+YQSrC72WXIYBaPjkIIhqoAFi0041kJNdlXghpkDy5q2Q7r8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db816eff-b8c8-49fb-ba81-08dd2e75becb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 17:15:40.3292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DBsvynRElY2Rip5ggiUrNjsKJnbW4H4yA3f2sn0e9mpU5WcNmYA4gtHmhU9GaVp7MRqgZOBKiwKdEP0no/4kHM5MebHEGohwAWF2uGMrCRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501060151
X-Proofpoint-GUID: pMQsNCZ5BU-u3sTe-zC8-BXm09JFMN5w
X-Proofpoint-ORIG-GUID: pMQsNCZ5BU-u3sTe-zC8-BXm09JFMN5w

DQoNCj4gT24gSmFuIDUsIDIwMjUsIGF0IDg6NDDigK9QTSwgUGF1bCBNb29yZSA8cGF1bEBwYXVs
LW1vb3JlLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIEphbiAzLCAyMDI1IGF0IDExOjQ44oCv
UE0gUGF1bCBNb29yZSA8cGF1bEBwYXVsLW1vb3JlLmNvbT4gd3JvdGU6DQo+PiANCj4+IFJlZ2Fy
ZGxlc3MsIGJhY2sgdG8gQ2xhdmlzIC4uLiByZWFkaW5nIHF1aWNrbHkgdGhyb3VnaCB0aGUgY292
ZXINCj4+IGxldHRlciBhZ2FpbiwgSSBkbyBzb21ld2hhdCB3b25kZXIgaWYgdGhpcyBpc24ndCBi
ZXR0ZXIgaW50ZWdyYXRlZA0KPj4gaW50byB0aGUga2V5cmluZyBwcm9wZXI7IGhhdmUgeW91IHRh
bGtlZCB0byBib3RoIERhdmlkIGFuZCBKYXJra28NCj4+IGFib3V0IHRoaXM/DQo+IA0KPiBJIHJl
YWxpemUgSSBzaG91bGQgcHJvYmFibHkgZXhwYW5kIG9uIG15IHRoaW5raW5nIGEgYml0LCBlc3Bl
Y2lhbGx5DQo+IHNpbmNlIG15IGNvbW1lbnQgYSB3aGlsZSByZWdhcmRpbmcgTFNNcyBkZWRpY2F0
ZWQgdG8gZW5mb3JjaW5nIGFjY2Vzcw0KPiBjb250cm9sIG9uIGtleXMgaXMgd2hhdCB3YXMgZ2l2
ZW4gYXMgYSByZWFzb24gZm9yIG1ha2luZyBDbGF2aXMgYSBMU00uDQo+IA0KPiBJIHN0aWxsIHN0
YW5kIGJ5IG15IGNvbW1lbnQgZnJvbSBvdmVyIGEgeWVhciBhZ28gdGhhdCBJIHNlZSBubyByZWFz
b24NCj4gd2h5IHdlIGNvdWxkbid0IHN1cHBvcnQgYSBMU00gdGhhdCBlbmZvcmNlcyBhY2Nlc3Mg
Y29udHJvbHMgb24NCj4ga2V5cmluZ3Mva2V5cy4gIFdoYXQgZ2l2ZXMgbWUgcGF1c2Ugd2l0aCB0
aGUgQ2xhdmlzIExTTSBpcyB0aGF0IHNvDQo+IG11Y2ggb2YgQ2xhdmlzIGlzIHJlc2lkZW50IGlu
IHRoZSBrZXlyaW5ncyB0aGVtc2VsdmVzLCBlLmcuIENsYXZpcw0KPiBwb2xpY3kgQUNMcyBhbmQg
YXV0aG9yaXphdGlvbiBrZXlzLCB0aGF0IGl0IHJlYWxseSBmZWVscyBsaWtlIGl0DQo+IHNob3Vs
ZCBiZSBwYXJ0IG9mIHRoZSBrZXlzIHN1YnN5c3RlbSBhbmQgbm90IGEgTFNNLiAgWWVzLCBleGlz
dGluZw0KPiBMU01zIGRvIGhhdmUgTFNNIHNwZWNpZmljIGRhdGEgdGhhdCByZXNpZGVzIG91dHNp
ZGUgb2YgdGhlIExTTSBhbmQgaW4NCj4gYW4gb2JqZWN0J3Mgc3Vic3lzdGVtLCBidXQgdGhhdCBp
cyB1c3VhbGx5IGxpbWl0ZWQgdG8gc2VjdXJpdHkNCj4gaWRlbnRpZmllcnMgYW5kIHNpbWlsYXIg
dGhpbmdzLCBub3QgdGhlIExTTSdzIHNlY3VyaXR5IHBvbGljeS4NCj4gDQo+IFRoYXQncyBteSBj
dXJyZW50IHRoaW5raW5nLCBhbmQgd2h5IEkgYXNrZWQgYWJvdXQgbG9jYXRpbmcgQ2xhdmlzIGlu
DQo+IHRoZSBrZXlzIHN1YnN5c3RlbSBkaXJlY3RseSAoYWx0aG91Z2ggSSBzdGlsbCB0aGluayBi
ZXR0ZXIga2V5cmluZw0KPiBncmFudWxhcml0eSBhbmQgYSBzaGlmdCB0b3dhcmRzIHVzYWdlIGJh
c2VkIGtleXJpbmdzIGlzIHRoZSBiZXR0ZXINCj4gb3B0aW9uKS4gIElmIERhdmlkIGFuZCBKYXJr
a28gYXJlIG9wcG9zZWQgdG8gaW50ZWdyYXRpbmcgQ2xhdmlzIGludG8NCj4gdGhlIGtleXMgc3Vi
c3lzdGVtIHdlIGNhbiBjb25zaWRlciB0aGlzIGFzIGEgTFNNLCBJJ20ganVzdCBub3Qgc3VyZQ0K
PiBpdCdzIHRoZSBiZXN0IGZpcnN0IG9wdGlvbi4gIERvZXMgdGhhdCBtYWtlIHNlbnNlPw0KDQpU
aGFua3MgZm9yIHlvdXIgZmVlZGJhY2sgUGF1bC4gIEkgaGF2ZSBubyBwcmVmZXJlbmNlIGlmIGl0
IGlzIGEgbmV3IExTTSANCm9yIG5vdC4gIE15IGludGVyZXN0IGlzIGZpbmRpbmcgdGhlIHBhdGgg
b2YgbGVhc3QgcmVzaXN0YW5jZSB0byBnZXQgdGhpcyB0eXBlIA0Kb2YgY2FwYWJpbGl0eSBhZGRl
ZCB0byBtYWlubGluZSBjb2RlLiAgSG9wZWZ1bGx5IERhdmlkIGFuZCBKYXJra28gd2lsbCANCnBy
b3ZpZGUgdGhlaXIgb3BpbmlvbnMuIA0KDQo=

