Return-Path: <linux-efi+bounces-2003-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 488BE9A2EDA
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 22:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9B71C2298D
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 20:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDF12281F3;
	Thu, 17 Oct 2024 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GXOt0R5o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N6ZW9q0h"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEF02281D9;
	Thu, 17 Oct 2024 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729197630; cv=fail; b=ir7pLgfLsB/hj4gzHrdUyXT5B4YVzoEgbxyF7zt7fs1R+bpRQDrxWq8XW9fo6HEhRzsoRY/zztaxA5qkbsyNYk7pcsSiva+UJ42nx5Zyc1md7bvSLERvnLZHddqPMeEx1787awYQhiW6vIeEN0fUgedbd+7QHkYoDnOD6TwAjxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729197630; c=relaxed/simple;
	bh=R7+pdD1L6bBwcshbq0ECU1kQf8amuGxWdN74qZAJGhQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uBwYnaM4NUCd+zwQnUXPZbpVkqBw0BYFhlbf3Gteh1S7KFG6cR42NlH+q0DamHgn8BSSlBAzTRJvVs47ePSjVVd6lOVqUsqEXBD42KAdU1bhshVRGF9HbUIocpplodFELCuU5Td2NZzCiEbMyMvlf0KfHEQKdJ8e46lN/sCOO+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GXOt0R5o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N6ZW9q0h; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBdJT025066;
	Thu, 17 Oct 2024 20:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=R7+pdD1L6bBwcshbq0ECU1kQf8amuGxWdN74qZAJGhQ=; b=
	GXOt0R5o8bI5VSyF/s9SY0W7tJkN8H4GZkZknWmjQ7d9mEPqFJFjFrlUtF0AR5zC
	okHoFrH5e/nXf9UlD9JQGQ268nGltg1eg9DAblK/Us055w/W/kG379f1fyS5xMNE
	AKDN4ES5/5FHMpvAUu0kxVnYQDFeKB7jeANUXDoZXTMzCyOHE9laZy8+c1D2qQvk
	7nFfuk0lKOFzw6EooO5zWXNypJYfpmu6wDYTSZhQGqenRpq1tWSBT7cMTwkm3Y7d
	J8SeOld6MQPKXkVpLTfzlcxs1Yl39MmcX+KUbw31tmNa+oXUzDJYMCEHDCaU8IAE
	2w2lJg2Q8aJ3W/kjcilkuA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1aq603-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 20:34:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HIiueh036110;
	Thu, 17 Oct 2024 20:34:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjh8kd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 20:34:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoDDYyeT8YU5iIQh6rhB2gU8d/Gtg+6mb+ICgYPY2mrUUXdbItWJ/zSNewAwF21p6M7faiUk6mBiFjqrY/yONbgIH8l38ArrcjaPkQ1Sw4aF4iRkBqXEbZ0gyiNXndnONSJYcQojGh4s5eMt9RE9xLDGRmggpiEL8i+okqEHA3gH4Xmec25fIFYobIVb3qY9IVOEHNJ9I96z6EqJi+BWztrf1Rgyn1WT8jXJwX0w4jY8XUI0wn41y54M48j0p9sQPXd7AeDUNC9NgeIDZe6yOmRR8YevM/AvpJ1X3Zig+g8nFeeThq4VLhrK+7UG06/nSgt5rsWYuROl6gkYnCb58g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7+pdD1L6bBwcshbq0ECU1kQf8amuGxWdN74qZAJGhQ=;
 b=lxFj2pC6KHXaMRh1b2QQLkRNlihcnoqmtTz7cH7LTv39IBQHlzGIqjg8boAUqb/dDuemmcuYA2vcsXJwxFfKIORQKme6enNyZoAbcvivqB2oIoDgBBvuCCP7Gau5viT8LjvzYHAjA4f61sjKhTYUnXGKdPHPYHRWR5kTZgz/DadwDGEvKL20OzedagxcXiPLsDdAqjw8ue6Q0BvUhr8j7F6lp+ZMl+jvAx/AIVY3IIlH0OwiZIW7a5iDxcgoaU0a7RvPQpqTevoqFuKVKC0NAb81ejlZoSsV/KqTKyzBv0ZAu5hOOcgCIlMZDPFeNwVjwbSMoVBl+9q3nTJpY2j/5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7+pdD1L6bBwcshbq0ECU1kQf8amuGxWdN74qZAJGhQ=;
 b=N6ZW9q0hFgk4dIs0PZhCnZwFxKcaas57iSin5ItgnR7e1w9ujZn6e0wDPYTn7U4bdokaYXvJiB1qVvzMszv2it4bMGtDLLANPZ+XnhpFneaR/SwMHgh/hnVexo/9TWhwaajGH60W3Scr4AnKLDbGKHcSVWbGNif+EIkL8YlDYy0=
Received: from LV3PR10MB7748.namprd10.prod.outlook.com (2603:10b6:408:1b4::11)
 by SA2PR10MB4651.namprd10.prod.outlook.com (2603:10b6:806:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 20:34:48 +0000
Received: from LV3PR10MB7748.namprd10.prod.outlook.com
 ([fe80::1683:6bbd:7cd2:fff1]) by LV3PR10MB7748.namprd10.prod.outlook.com
 ([fe80::1683:6bbd:7cd2:fff1%5]) with mapi id 15.20.8048.017; Thu, 17 Oct 2024
 20:34:48 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
CC: "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Ard Biesheuvel
	<ardb@kernel.org>, Paul Moore <paul@paul-moore.com>,
        James Morris
	<jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar
	<zohar@linux.ibm.com>,
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
Subject: Re: [RFC PATCH v3 03/13] clavis: Introduce a new system keyring
 called clavis
Thread-Topic: [RFC PATCH v3 03/13] clavis: Introduce a new system keyring
 called clavis
Thread-Index: AQHbIK0Hzf+Cg4+90kWI3AEp5Tt7kLKLKCAAgAA+fgA=
Date: Thu, 17 Oct 2024 20:34:48 +0000
Message-ID: <BF17F069-BCAE-4FA4-B956-4D7E69C2EAB6@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <20241017155516.2582369-4-eric.snowberg@oracle.com>
 <30308614a1229870d205c33deba193f3d6732bef.camel@kernel.org>
In-Reply-To: <30308614a1229870d205c33deba193f3d6732bef.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR10MB7748:EE_|SA2PR10MB4651:EE_
x-ms-office365-filtering-correlation-id: 0c3dcdaa-ae13-4583-765f-08dceeeb2530
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eU5qL21QcFpDSDIvTTEzdWJ6RTRqTWpSa1dZOVp3U2VVaEZ0VWMxV2Y1SVQx?=
 =?utf-8?B?WlNhbzZnN2JRZUdJRjNyY3BrS0hKNUdIU0FlV2twdlNNUUh5SXhMUENBRUUz?=
 =?utf-8?B?WnhISUhOMFJHaUlOZDFRQ0JMU1Rvb3gwUzcwV2FpTGJwNzlsSEduME5PMmdP?=
 =?utf-8?B?cW0ycWlweSs1ZVE4STVIM2RVb0t2MlRMaUVSL1ZqZW5vcVlCaHZwNmZtWncr?=
 =?utf-8?B?bmF4Wm1OV0JYamZkWmJkTGYwaVBvSWRPa3pOQWF3Y0hTbjhqSGtqQ1g4Z2Zu?=
 =?utf-8?B?SFVScVFFVlltTk5CY0ZYVVd1eHcxd2c3dEhVTE5SM1FtRWJlMVVDbHIzWWFx?=
 =?utf-8?B?dStoWUVuUkxubjlXL0Z6VlFKMFZBOXRXcEx5OGpVaWdFL3FWcEMvM096bjNH?=
 =?utf-8?B?czdZdHRFOU5aVElMS3k2cEVLdSsyb1dmWkgzdjV4VlZRbnNQRTlFUE1iNUdj?=
 =?utf-8?B?L3ZaNjdMZXdtMFAyNUxZZXpzVmxMTmlzVEdOWC9kVVV4aHE2UzRQak43Tmhx?=
 =?utf-8?B?ZGVkT21FVGprOXYwNVlKamZseWUrdE9ydGdCUVJkNXhpWGllZ3h0SjBiYmlU?=
 =?utf-8?B?T29MMnFVWDA1QVc5L1BXTEpMM3dFM1lkbVBXQjBVK3JGc2JEaUswaisvdTlI?=
 =?utf-8?B?cExIb0x1cTNDMlg0QkE4bWNXemJtM1FJUHBTc0tGVWsyeHBsdG5CTEx2dXBZ?=
 =?utf-8?B?a21ENW5Fc2hQQWIzdkgzSG5IMm0rRmY5S1hPMkE5aUhaaVgweTVVcjJQSkVp?=
 =?utf-8?B?cHlqSlFxTE5OOHhWbTJUQ0hUZWNBaTNyc1VoOVdFclFzQlhMd2pIeWJIUXBG?=
 =?utf-8?B?MnNJZ0NsRkhYbEZMV3pzZXJSYzdFdlpiYzZMZDJWK2w1VVEzS3V4Vk0yOFZZ?=
 =?utf-8?B?cStRbC9qZklLb0ZSRkc0R2pUcXRZZ1R1YXFVNDkya050VVhZTGdoNDZlU1dX?=
 =?utf-8?B?Zkh4TnJsN3lPOVp0M3FTT1MzblNDazJwSGFhYUF0bDRxem5ZOWpzNzJsTDFJ?=
 =?utf-8?B?RWdybm0yM3UwMlY0Y1pzWFF2UUlHd3k2UUIxRTYrQVhMVFlMUUt1YjNlR2RB?=
 =?utf-8?B?YllKWWN1S292UVZNaDBhNDRSLzVCODh2TW5pTlFHMXQ2Y0VxTkk3L0FvNmZ4?=
 =?utf-8?B?a2p1NnBPeS9qSkRQRVExNWN4QWdwWXJZYVJ5Uzk1eExsR2d2WEtVak5kZ2tB?=
 =?utf-8?B?M0dBUVhDQ25zcmhVTWFBOU1vQjdHbjcxdC9GWUpOUWRIMnI1Skh6a09la1lB?=
 =?utf-8?B?VmZoZitIVjJ5MVJ3cHdqQjYwNDVYL0ZXbFIyck1oaEhEQWpFY0ZvV2t0aTFT?=
 =?utf-8?B?ZE1KYWpZcmRBUi83dExkRCs2c3ZZdUViYVlITzE4T3hzdGVSODlhamh1eHVT?=
 =?utf-8?B?QURkNGpEN2ljZHZKS2hlSzNYSjMxbFlWc2hkZE0vbXZ5SjRhL2VrWVo1K3kz?=
 =?utf-8?B?c1dSRGVuMUpqSmpRQVlYOVN2Si91NWxZbk9kWUxUcDJQanQyeGcxYUE4OEVp?=
 =?utf-8?B?bUh4OFEyNGVKOXNNeDdjeE1aYjlCZFY2TWY3TU1obHI3aFhhcnVEZlNuam9C?=
 =?utf-8?B?R1JGaFFKd2tHOVVnQWdwQWtiWVQ0S1dwcmpWeFFDK0xPckVTakFZT2lVbHV6?=
 =?utf-8?B?MmpBbDJWRnpzNTFsbTRSaEszRk5tUzg3STdhMi9nbkRRcGZXRHAzNTc1OWZn?=
 =?utf-8?B?TzU4azNDSld6V1IrL1FwbFp3WmhqeWN4cnhOeHZiaVFFdkJGUFFSR240NXFl?=
 =?utf-8?B?V2ZFSWdhTVFaekJPSWtrWWl2TXUrY0hiTzRuNlNEVFVhY1l4VWEza3BTbXBN?=
 =?utf-8?Q?8Cj4nYdXEOBguIFDnbTU5kF6GkIDt4qm2qzqQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7748.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1Z3RStRcnNCUmlmdmdxVm1pMmU3NjBRR3lFTCtuZkhMVGtLbHI0VVdYeTRs?=
 =?utf-8?B?dTNNZElpNTNFTU94NmlEcFlDcDF5ZXRoZ3BNVXBTanRrRHhSd1BIUVpCdm0v?=
 =?utf-8?B?dkg3M3N4S0FOSDdtSFAyT2JwSVlXTWZrOU56cjk0N1dIdUtpR0dxV2ZDNnJ0?=
 =?utf-8?B?dGNTYmp3anY0RWhrTk90a0JybXA5NzcvSjBITEJiRFFGeTg5N3EvN01pVmFO?=
 =?utf-8?B?NHNRZzF3eWpCS0lXeWRFendYRkNXcWFlL1ltK05xcStjWVlPQzBMcGRBb2tu?=
 =?utf-8?B?SSs2N0N0eTJURDZQUDdJT2NaTm1DU0hybjd6YUJsTmZIWHc1cnlmYnV6TWNK?=
 =?utf-8?B?QW1YdXdXSHY0MWV2djVXaUVPZmQ3cnJlb08xb21HN1JDUWhKVDJ1ODlDcmxi?=
 =?utf-8?B?UEpaaVlNTGJsSm9SdHRHd2liZXNaNGx2U0dwNHh6cTJack5FY0xRUDJ2KzRj?=
 =?utf-8?B?VWROeVE1dE55SmRieGM2MDJEdms5SVovQ0JwL1RSUjA0K0MzcHlIcDV1R2tD?=
 =?utf-8?B?WjhBWEZ1dDM5N0xCRFhCaE4vUHBHZHdUclhoRWZQdEQrMXhzU09uTGlTY0ht?=
 =?utf-8?B?SWtiODJWTWwrc0J3T01aMGxkZnVIaVk3TnRTSTJ1UVVVZVVYOVlHUXl5T2dU?=
 =?utf-8?B?ZkRrVkJDNTdQSFhLaHV5VVlObWpiTlJoOE1TK2FOQTIxdStrTy9CK0xZWnVp?=
 =?utf-8?B?K0lRSnBORzRGelp4Vk5WaFNheXpyY1B6Qm92ZlNub08vWUdFYVBpWmFXdkln?=
 =?utf-8?B?eVJITjFYSXV0Rmo4dTBGckV2bVRpcGo3RGI3VG9ROXhxOUZsTXFDeElaV3VZ?=
 =?utf-8?B?VVcxR29rMU1UbyszQjdvVCsvd2t5R29DUW1WbnluWFlyRFhKZnZXVzdCNlc0?=
 =?utf-8?B?VmFRNUl5UUxzcDU3ZXJVc05PRjluSEtncXpBdDBDVzlsTW9NQlFicldXeFdS?=
 =?utf-8?B?SXFZdmh6RzlRL1A0ak9lNDQ1TWdCWDFGNUdaQzBmV3ozZ0Nna0RQVHpPM1d2?=
 =?utf-8?B?ZkdnMXlaQzJTd1hUbWpWanE1R3Q2VktmN3JzaitrOEdXR01zakdkN0pRT0h1?=
 =?utf-8?B?d0ZFNlpvUmRnUzY5VVpzNW9uTVVXRmNhNm1kU1pHWGhzekxtQ1BZd2w1bDVF?=
 =?utf-8?B?VjFFNjZmK3Y5WnBxem0xY2JqYVlucEJmRDQzRjc1VWdsZTd2RVBVOHh6VUhU?=
 =?utf-8?B?SW9FMTNQU0xhUUxqRSsrdyt2eDAxK2YxbXN0WEhvRE8wdksxN0NmekNnbkNZ?=
 =?utf-8?B?b0hIbVo1UGZITnkybEQwNWNDSlRrNlZ2Z014S0RnQzBoakFiL3F2QXNVa2N0?=
 =?utf-8?B?bmlpd1ZVbTBNZFFJVDljZWpyOXVtODNyc1pOck5lSlFQcHVNYk1DVzg3WFNH?=
 =?utf-8?B?dXpIYmNKK21XNUxDc0dSSkpuOEFFSHhFQXFqaDFlcHk4cUt0TDREWGYxaXFU?=
 =?utf-8?B?MUlEdFVKbmQvOFJncm1xQ2JuNWx1c2ozR09YNTNOalhnRGxWR2xkMlJmRkcx?=
 =?utf-8?B?OXplOWwvSG9Pd2RnOUlQM3dnL084ekYyOFlrZnh6d0lDNkFROUtxcVFFZGFB?=
 =?utf-8?B?S1hKSmtGMkRnY3lLQlpvME9wcVdNMm1QKzAxNWQ1VG5IZlJ0Wll1bU1VRjFx?=
 =?utf-8?B?eTJmcTZRWjgwNjBNVjhjN1VFc3Z6dTZDZzcwcmhzbjQ2YW9JQjVqWXhHVVJx?=
 =?utf-8?B?TDhkK2RJcWJ5Y1dVQ3ZXUXNPY3lOTVptMzJDYWRveWFZWVA1Z3dld2ZoY0ZM?=
 =?utf-8?B?RlpHUTJpU29uTCt2YWJNR1dTMGs2RkFtYlM0ZTA3aks3Y2pFaEhVUkR5R1JU?=
 =?utf-8?B?VmxyeldxcE95S3BwVExza1Y5UFh2SEtEb0dpdW0yZVBoT3dGVlNuSHlxUkVO?=
 =?utf-8?B?Si8xOVVWWEVZN05Sb2E1Qk8rU3pZdjlDc1VmdGRoR21QSHE2Y25KeStDSEYw?=
 =?utf-8?B?QVhGYUJJZURXbThKQ1VpL1RtZlpYZm9FaFNqbVZXa2RJaGlGc1JUNWZSSG9R?=
 =?utf-8?B?SzJWSW41TTBhRmJrOE5PSkthQ243cnN5VEJYWng5aDhMcG12REplSzA4cjlG?=
 =?utf-8?B?YndQeHBSTDFLbEVHa2c3bitVTGFYKzVuRXErbTZoOVpNWEZRNmNuUE1XUUpp?=
 =?utf-8?B?ckNwUDFhOTgySEhNWUFmUGVOZHhlQTUzb0ZGTFdQMjh6Y0V2b2pzZXl4NExY?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A2ACA3E83CAA24786D1C690070DCF72@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	srJUvLxVU0Oybzv8KqQSPtPAwsq1ujvZxMM0+zqCBpugYy0ODUPGkWskbm3ePj+W0gsLiX84NkpvlVfw39+8nnDwjTzS+ryeBLzRjhtKcugxoMpPI38vo/6Mufp3WGtdknG4rArnhgV9iJCsPK8R4Kz9SWiQGDTdmPUzNXzzFLIq1X2TO8Jif01aaN7FcKbvN8Pk2EE4TNO66DmJFLDTD88mMOvNuiBZV8WrGkX09/LdUYLvWaLhWV1MnnOP6DGP9VNlYarcyaVBkB5mf56gK/9Id5hprVDv7N2Bht7xeQh23Q/H9z4NQrXJjt+lbvY+BCYr3Trxdo94GolTTS3fRN/gyAO994wR/tG6X0SRWy34sV0vKV8I54+pDqsbcZLN5MxQL+zw/SWG5WrGcSfA1n3omKU2ZZcV7EacW+vZ4S7Unf0oNp/1OXrjq/O8c7W16RbZpZyg22X09sql9s06ZC4MUrlasWMuU6zPSh85zYDB7efurmIBOy8tpPuiqsyOTSta3xv/SdQ01ht174T7BzLPRLOgVu0pXsbUFEFO6gMuS/BNARSo5ZNo0bNQR3TMO1CH/0qxdLc+vJy16hV3RX59V/8LxX0O4M+xYPsHLAo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7748.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3dcdaa-ae13-4583-765f-08dceeeb2530
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 20:34:48.8008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m1nPqWnxUfSObYs82J2K4mWMKFdcVggEeYUQ61y4P+L7E3TS7bAYPHRi1ll3DQyc+xKvaneLLH1jxFEXrYedLlRw7JlGeqixvJT78Y7GM+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_23,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170138
X-Proofpoint-GUID: WeMvAVtnCwLdmw_Jjv75RWZtLfYXjnpj
X-Proofpoint-ORIG-GUID: WeMvAVtnCwLdmw_Jjv75RWZtLfYXjnpj

DQoNCj4gT24gT2N0IDE3LCAyMDI0LCBhdCAxMDo1MOKAr0FNLCBKYXJra28gU2Fra2luZW4gPGph
cmtrb0BrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgMjAyNC0xMC0xNyBhdCAwOTo1
NSAtMDYwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+ICtzdGF0aWMgc3RydWN0IGFzeW1tZXRy
aWNfa2V5X2lkICpjbGF2aXNfcGFyc2VfYm9vdF9wYXJhbShjaGFyICpraWQsDQo+PiBzdHJ1Y3Qg
YXN5bW1ldHJpY19rZXlfaWQgKmFraWQsDQo+PiArIGludA0KPj4gYWtpZF9tYXhfbGVuKQ0KPj4g
K3sNCj4+ICsgaW50IGVycm9yLCBoZXhfbGVuOw0KPj4gKw0KPj4gKyBpZiAoIWtpZCkNCj4+ICsg
cmV0dXJuIDA7DQo+PiArDQo+PiArIGhleF9sZW4gPSBzdHJsZW4oa2lkKSAvIDI7DQo+IA0KPiBI
bW1tLi4uIEknZCBjb25zaWRlciBzYW5pdHkgY2hlY2tpbmcgdGhpczoNCj4gDQo+IHNpemVfdCBs
ZW47DQo+IA0KPiAvKiAuLi4gKi8NCj4gDQo+IGxlbiA9IHN0cmxlbihraWQpOw0KPiBpZiAobGVu
ICUgMikgew0KPiBwcl9lcnIoIkNsYXZpcyBrZXkgaWQgaGFzIGludmFsaWQgbGVuZ3RoICVsdVxu
IiwgbGVuKTsNCj4gcmV0dXJuIDA7DQo+IH0NCj4gDQo+IGhleF9sZW4gPSBsZW4gLyAyOw0KPiAN
Cg0KR29vZCBjYXRjaCwgSSB3aWxsIGluY2x1ZGUgdGhpcyBpbiB0aGUgbmV4dCByb3VuZC4gIEkg
aGF2ZSBhbHNvIGFkZGVkIGEga3VuaXQgdGVzdCANCmZvciB0aGlzIGFzIHdlbGwuICBUaGFua3Mu
DQoNCg==

