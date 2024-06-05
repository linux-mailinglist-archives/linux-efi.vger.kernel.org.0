Return-Path: <linux-efi+bounces-1175-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F0F8FD7B4
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 22:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A491F22B34
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 20:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52DC15F301;
	Wed,  5 Jun 2024 20:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AbP3KVDt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H4rMG3Ue"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D4615EFD0;
	Wed,  5 Jun 2024 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620119; cv=fail; b=b9ZSKLPMpMEKP/8Xzm4tO1XMNrYXf8OuyRMYxM/gM0RpKddZY/+l/dYbZ48P9X8rzu/4F+kU0RPPAcpcpjT5k4dt/U/HQy+FxWZCbtyAu0yXWvWLR6yqB0DF5+GmEnSjKyfPtYAvIJVAJ9On7u4c1Tg5h+iUCK/R7MqE4MFY4e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620119; c=relaxed/simple;
	bh=hn4NJnSvJD3COFv8L5xwdH+VqHEh2FAaTeLr0Vns86I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=STg6dY+KGGqlXMeb2EJfH/6Uhcbvs4Iij84PB5gT7VlnG6mmYb5NupdXAhOCrDDjhiOkZFCpuWwwJkltD0AkqAAC28UGIR2+oJ4B7G/c/qWTqTScEBgP9SRetLIRuSmmZfOiQkk7W7/EC6l3eZAWXXGJ9NzfchKeGTllbM2tE3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AbP3KVDt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H4rMG3Ue; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 455IxhNI015509;
	Wed, 5 Jun 2024 20:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc : content-id :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=hn4NJnSvJD3COFv8L5xwdH+VqHEh2FAaTeLr0Vns86I=;
 b=AbP3KVDt8YuFIK2/dSZ9u5llSkAjIdBKTZPvLGspVHq5zMVKuCk1LV5XS08GXQ50tlaP
 cY2t+LPGz+jie9mpM43DrxyqXn0dOmNprK6z7v4oGg1FDO5AxDR2OByuTsmbCGWJBUKc
 ur059LExsv1aYn9Xfodp7E/POJk74JK0Tri7wWjZ4yD7DuJFgIuDN6MU0IbpXAbdaC8U
 ZVUkVGOTwZaB4a4/Cpyh5ermxlQqCuhQzMnmVZj1fCPYCcNATwaeNVs+RaiaSs6toISl
 6Xr1aiWx9fapDKpkA1PrFmj80O7Q2A1pFFy/0BALtgfUBntTEkS84x64m6FpICfIcPwv AQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbtwa71g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 20:41:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 455JigJS020731;
	Wed, 5 Jun 2024 20:41:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj42d77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 20:41:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A83Vad7ZqhOjz5zhcIFc4E2dfx0XeKo5HvC9wcKqRwjuNEt9xp89Yui2fzH8fGg1pPykmX4j8zA9wb7xtm2jtpsIUD5tpFRyYGNlYygz/UONWC0lTkFnldpDGOuLMPdnguprljY3Hwi+zDlpwOMVw57FHAGPDJQ+YUu4L6hEw61uUaTQX8pRv+tMd2uu9QmS136kxP6yAU6uw5wMCKO6ot7ovNplG4FlAVaFD4lmrrrHjKuVlKAkwQ/gH1KeiNhiNaywNSYKIf519rnHlKzI3BWx5qFD8W3cTIU+QzsVHdQXugW9FP7zI9qOXjFTlnsrhTD107hwHT0JZo5fLyXyjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hn4NJnSvJD3COFv8L5xwdH+VqHEh2FAaTeLr0Vns86I=;
 b=AsUS1mJgfvMNlKBtdQP9msHTjauTKxNn5xaF1Zotqly8SOs9vahkXoycqK6VVAkSuMI5UjadRjP/P2F3QE/KYGZHGijuN3Dq1Tg/eh8CLB0UjIsxz8pjBsuMGKDKUsRpqOsACMfK9Bne9tW9JrZCTUA38WSvWzj3miEdgGYAn285V14cpnihTM1vu/DkdwLWc1sED41BNTJf614hrBMcJnUxTSTITGb3Fa+IpgYdtm7bI22FNgYt0mDhyIsmUOThdC2jo+WVgP+3csdyla1ZkRP1cez2WJ+UHChhPwr0//nzoYQeX+bigO8JSGXwpwDkvJapFHIjsjWlOTDdewmxaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hn4NJnSvJD3COFv8L5xwdH+VqHEh2FAaTeLr0Vns86I=;
 b=H4rMG3UeRhMnEdisOLF7X50iyMbgb9j/mPQAIky56j1e7q8C3FQo0GotBb9wQ0N64ayqkdso+wlvOHWt/pZqjSIMLsiF2kPK4SkHNrJ7LXWm8dGQ5kCu4HD6VpudYOlFNaoyAF4cLR9jfN+/DSQgPq2lXy0ixJvGF6Y1OnHWg2U=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SJ1PR10MB6001.namprd10.prod.outlook.com (2603:10b6:a03:488::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Wed, 5 Jun
 2024 20:41:28 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 20:41:27 +0000
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
Subject: Re: [RFC PATCH v2 0/8] Clavis LSM
Thread-Topic: [RFC PATCH v2 0/8] Clavis LSM
Thread-Index: AQHasvMN4yYIC0cA6U+n9RVkfqP38rG36/IAgAG/lYA=
Date: Wed, 5 Jun 2024 20:41:27 +0000
Message-ID: <80B82939-AE39-41A8-A417-BAC8611E3121@oracle.com>
References: <20240531003945.44594-1-eric.snowberg@oracle.com>
 <D1RFFIVMEENQ.3RXXNAGNWBE1O@kernel.org>
In-Reply-To: <D1RFFIVMEENQ.3RXXNAGNWBE1O@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|SJ1PR10MB6001:EE_
x-ms-office365-filtering-correlation-id: 2de1a7cd-a900-4fdd-7a4e-08dc859fdfb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UVArbHArRG9XUDd1ZTJvaEYvY2ZwQkhBY1ZySzN6RnprRXI0dU9ha1R1R0FD?=
 =?utf-8?B?cGNlWUQzTndNenhVYnhDLzhuNG0weTk3a0JvemcxQitrT2NqbUFqV0FNQm5N?=
 =?utf-8?B?OVN3RUZUYTVtSGtVSGNkOXVjbktuVUFLLzBGZ2FSMHg4TzdhNUFaRW9TMVJC?=
 =?utf-8?B?aDcwdGk1VXcvUG5Fa3ViamRPVzNEejlpWG4vMC9wcTV3NWtwcEtTM1F3QVZx?=
 =?utf-8?B?N3ZLL1FIWDhWRjNiZnVFK2F5Y0RPL2JsSHpRTnVvWjdadjFSMGpEbjM3Q2Qx?=
 =?utf-8?B?dTg5Yko3ZHFjaGVjOGxnY2FKaFFHSzJlMnlYOG1zWmJRZlBGYkpNcjhWbnQz?=
 =?utf-8?B?MFV2T2lJSllLSGZZV1J5VGMySkd3d2dTa0tVdEtXbDRZNlJBTmNrMzk3TjZF?=
 =?utf-8?B?VGNBVnlobUNKUktiS25uVEFvOExUdDFIZjdlUnpUSzl2eFV6T25oR2pwRDhq?=
 =?utf-8?B?S3NIS2dqS1RRdFo5K09SY0ZUS0F3anlycHJ0THhQNjArRVFYeWIxWTFaZ2M4?=
 =?utf-8?B?QjAwdGNOY3MwQmNrWlg3VUxhRFdUcUdCQWFRZEpwRzJHVmM2RnhGTjhmY1pN?=
 =?utf-8?B?bFYyVzU3cjFyc1NFTWdOdmRhMEJWV29YUTRJaE5uN3d0L1pBbEtoeUZTdXZX?=
 =?utf-8?B?bDMxQTl0OSsxL1MyVEsybW9kYVNQZVZxaS8ydGovY3B3YnRRZ1pONk9qZjli?=
 =?utf-8?B?SXRBNEt3aDdVWHNTWDZCU1VLUzVpbW5KUFVadE5uYlJvOEhCVWpJS2Roa3hB?=
 =?utf-8?B?eisxekRzMzZhZmlVbC9oeXFudGxNaGgybGREV09BaHpOalJORndlTkt6RUFF?=
 =?utf-8?B?ODkxNStvOHljRi9VWHA5WVVQTGs3TWdVSlpqdWFiaTZqaklvRGhPZlAwNGxJ?=
 =?utf-8?B?VXdYUmJCb2ZMS1V2VFBmc2g4ZXdsb1ZyaHV1WGtJQ2VsQVNrRitzMUs0alNr?=
 =?utf-8?B?Q2NXZnh0Mnc5TUJKUlZQV0FVY1E0Y3c2Tm5ranh1Sk9sUlpORzNLeS9qcTBp?=
 =?utf-8?B?L3ZCM1FnUExmVmNrVGVKaUQvZHAyOWN1V0pPQy9VaXhhcHIySWJic1A2Sk5W?=
 =?utf-8?B?K0xXZkJyWlBuWXJoQ1Zaa21HR2ZyMTdSMkZxdzlidW1vUGxrSGpPZ0pocFFZ?=
 =?utf-8?B?bXpiQ2VFZXlsTXVwQ2V5dWQ2aloxZUFKWWdtR0NmdFBjUXVYTWUycGQzSENB?=
 =?utf-8?B?RXlXb0l1NXBad01qQ0RCbC9ITE9UbjQ0K21rQ1hpRFRUdGhpWGthZCtzMjds?=
 =?utf-8?B?TmZTNENPVWFUaXFmVUFCZDhQckNBUHR1RVVlVHNHTUxHWmdEeEtlOUg0Mk1D?=
 =?utf-8?B?Wk9NSmhyc2dTYi81dm5ROXIwVmpVRWNETEJ3Z3VOSmpRZ1A0RERkZDQ3L2I1?=
 =?utf-8?B?UmVVenZuYS91dDNUM3hjSGNEUGNrSjdYT3JRUXg0N1FtT3I4NXIwTkg1OGRU?=
 =?utf-8?B?ck9lbkJ0b3hnZzA4MkEvVVVNQjBYQVZSa3B0aUw0UUhqbnFKTnNpRENFaS94?=
 =?utf-8?B?akJEbTdmQXVadSsyeWIwVjArY2FJUzZvSUQ4UVJSMjI2MWNXV0Vub3JhVlFv?=
 =?utf-8?B?b3dTeE04NkRFQmZKQlp1RVIxQ0l5UEp2QWllZi81SmxrRjRaZHdwR0xmR1hK?=
 =?utf-8?B?NjhCVlZvNzZmTTdEYm9FdDdwVVRuS3luNlU4REc4aHFKcVZNd2tzSVVjQzc3?=
 =?utf-8?B?UzdoeWVsbFJiSksxWVQvaUdtLzJXQXYyVU1JVjJGUFVMb1Bmb3R1OWpqRWJ3?=
 =?utf-8?B?MFlPNTBuclZUT3h3MUs3S1VpcFRzcklNZUkzeUU2SVEyaWFxWWd4aFRCZDVO?=
 =?utf-8?Q?IQL2wGiCa5UK9XsWVIpPP0r5PlPD5zo0r3TFg=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bnJKekI5dHF0Nkl2ZjZ3SnNtWlJuSncybGJKNEhtTGtQbnkvWUo2d0lNTkN4?=
 =?utf-8?B?UW9XQVRTVUM2alZqRytER2Z6VUNNdFFQV2ZQSFdlSTJ3U0FyMmR0bGIvbUpO?=
 =?utf-8?B?aTZkbFoyMlFmT1ZMRnFnUVAyakt1bVRtczFxMmpsUUNwdnJUTmtIVzNucUpF?=
 =?utf-8?B?U3Nna1k3TXlNMjNEYmFXZE1TVUJia3VzSldOb3Z4bkpSeWpXVWVENW81WmZC?=
 =?utf-8?B?bHN3aUtzU2FuTnR3d2RNd1oxcE1PdXN3TVVob2JKbWJBSDU2VlhibFVFM0tu?=
 =?utf-8?B?cFk4Y0IzWmNoQ3hwcEU2OHNWMEdoaTdhU2dEOVAwV1VvQkJWdG1ML2VFc3dr?=
 =?utf-8?B?c1g1YTR5WnFsQUxoRksrSzBwRGoyd0J1TWVrNnRtOHkzcTVjQTZ1UlM1RVRK?=
 =?utf-8?B?SXUyWDFqdCthRXorVDBPbUgwWW9HbXhXWityeUE3SnN2WTJLd1lJV1RFQlA4?=
 =?utf-8?B?cjloZ1pZWVBYZXZZUnlzMlM4eVJiRWxyWk13VE5ETW1QTmNIRDFndVVSOUFz?=
 =?utf-8?B?andaSE1Dc3FIZXkyK2NjQ1NjWlFoZmxhMWwvcmlENTFUWlBWdzloNkY4RlU3?=
 =?utf-8?B?WFJHU2M5VFZsM2JDditsLzE5R3RuY3RPRERuWlh4YzFzbmdkaW9Hais3a3g4?=
 =?utf-8?B?QzdEMkhSazdBWWo2QTdKZytCbEY3QUNBalo2QnRteVArL0lxWUMvY1lCOUxB?=
 =?utf-8?B?WmsyREN0M29kdjRzMHNsS2tUd0xONU5ydVd4MkV5ci9ucUh5OGo4OEdMVHJ5?=
 =?utf-8?B?cTE5VUdYcGJLUXdnVXE0ZUd1SlVTQjFNY0Rzb1NIZnZNa1Z5cy9QY1FpQzdV?=
 =?utf-8?B?UHVTQm1RVUZVZ3NVMVQ2bkkrTXlMWHJOM3llTjZWRWQwMFZIV2RVS3NuRTZ3?=
 =?utf-8?B?U2hnejhFZlJxSXpCYnJXMXcxNFJsZXA3L21rK2wvNGVtbjhocDNlNjBwb0xJ?=
 =?utf-8?B?Qk9TcTVIQkt6dEkrNEZwbzhza0RTM0s2TjZXWkpDZlFtdVMvaDF3Y0NYUDBn?=
 =?utf-8?B?VDl2KzNQMFJwUEV5VFMwbUhxeVprQ1ZsR3ZNbk83QjJCelY1YXp0RnlPV1l2?=
 =?utf-8?B?Vzl2ZmlvSnl0dXZCbXo0TkdzdzcvSVZRSlpEdmZ6VUFORmUxcHpDUE9id1g4?=
 =?utf-8?B?MmwrM0dUWEhHY0JnMHdQNkNrMkQyMnRpTmxTeU9pWDhMajVXMnJOaTh6T2or?=
 =?utf-8?B?dFd0YlVzZU9QMmhQejV3dDBadWw5Tm9adEt5dGV1Nmt6ZUlaenpDT2FaV0Na?=
 =?utf-8?B?L1UrbXNLRG0xZ29jQXlqMFlzUkdaMlp4bkJWMitQc0pMd2Y5NzZyUTVHQlNV?=
 =?utf-8?B?K2NzL1hYUnloTEZkc1pvaXQwbEVCS0xPd3QzUWd6RDQraGVPenZ0VS9NZ1BW?=
 =?utf-8?B?OExweU50RWZidysvYTFOT2VjeVVFM1FUUkVzRTRBZG83RUR2SVRRWERnZ2F6?=
 =?utf-8?B?WXQ4TEkrZE85UlBTbm8wVzVwNm1YTGNCdmdBdG5qdjM1MnUwTHdFa2hqdUlu?=
 =?utf-8?B?UjF5ZzZ2cDg1VEgxTkFDYTRSc2NaZTJ3NE5kUWJHb2IzS3Q4dEtQbmk4OVdK?=
 =?utf-8?B?MkF0K2hnMDRvVjRzV1M4NVpmMkVoUk42YUtIcVhYSnd4c21DbWk5U3R4Nldp?=
 =?utf-8?B?K1ZMUzZ2UytBOUJyZ1g0NEhPdFkyRzNrYzFPelpMOVJoVzVkbWhDZGF0ek9o?=
 =?utf-8?B?Wnh5QzVRNTZVQmVFdmsvcjkxVzhLMEZaUUt1K0RrZ1oyQ1NtWFA4VzU5ZXRk?=
 =?utf-8?B?Q2NlN1JvdFlFNzJMaGJncEpxc1FSMFVIenRBblJ1ZWcxZE1qL1hoN2NmR25K?=
 =?utf-8?B?bnRsMUdkVjZJbG45L2VkZmlFMFZWM2FkK0lLN2dGU3cwb2t5WjhiaWlNdTZT?=
 =?utf-8?B?M3d0MU9TK2g5VnhVWnNHVFJEK3oyakI4RHdDa29xSkJ5VFd0NXJJdks5MFJJ?=
 =?utf-8?B?a0xaNGhsZTZ4NTZuU1I5bEFuMXJUV21zTVBhaWNldStlaEI1Si9QVTVTK3R1?=
 =?utf-8?B?Z1dqRGp2V2RzcjNUNGxWb3RpLzFxNEFOUXhCelR6Y2ZneXliTXRsYi96RlpC?=
 =?utf-8?B?c20yT3Y4YVFmTjNRTjdzcTNKUUYxbmtPRzZRMHlpNVh4cGRnUVJRVFB6U0Rh?=
 =?utf-8?B?T2l5RkRjUGFsbUtLVjNqcytDZzU4WDJReGV3SjVTaW9LN3pJMUVOdXBndFh0?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0B7FD73E578D0448A1BFFA20408D3CB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Fc/sZ7XxoxzE+VBA4iacYlOTpQRV06Mbio9Xo8O59i2L4qARH3BL+NaJcWgSjJowuLTczAcYYDDvxwI3VOf6p9WTaHMFrXvmmy7M5Fx9OOVL1VEmVYGIltC56ApYcqx27424Ali4YiLPKb9+Gng3xmLiZMMivFSNlR0L6KRQBCmcKIDjPaC13d1Vd3fuHbAMUwGwb/F245SFf9hHRmVx44AMwbCdmueYlyR9tiEdBc7hOII0P929m8nkh+iI9BNxDJQBnEdjCSGc16kvj5vmXheSWVDFvJWvDnFVbVT8R53rePUTD7AtNDamIVO7ynYE2lKrVCny9/LHYChoEzwWNpzSAOWwOOkboKprpvhoSeopAbqdNHQJpRN5ClVvUQDauqUnq7Rs38u75N0zbtbAHf/zLf1+MBLFPAx8V81V8lWlCaQYi20yZli+jVKs0VX+DgzVmBjleWsWkmBwAUPHqMX8jam6fxsFEb0z5+CXtPxlTK0H/h6dYhEgZdcNnYVDj3EO3xzMibj8XqzGyxpidUQI/5IaY0efHWc8cnZ3fX03HzPrRLF8/n2NXy6WyEH6iDNSzkoRDrpHXxb/jCtHHW5eT6dS+eqSp00AQX7QwIg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de1a7cd-a900-4fdd-7a4e-08dc859fdfb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 20:41:27.8689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: edFmOVX2XynIGAPiRNktX4vPEM3z/RwR+JY4tFR7GYjmMFmv3P+0ol0I7QXKHqzZ1i2/qNCwNs/BHwNTZ4Ys7II6Ao/seZJfMxpI/E0kjvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406050156
X-Proofpoint-GUID: 8EgDYpXtb0WBY2YBhefU6PK3tS5hwHsE
X-Proofpoint-ORIG-GUID: 8EgDYpXtb0WBY2YBhefU6PK3tS5hwHsE

DQoNCj4gT24gSnVuIDQsIDIwMjQsIGF0IDExOjU54oCvQU0sIEphcmtrbyBTYWtraW5lbiA8amFy
a2tvQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gRnJpIE1heSAzMSwgMjAyNCBhdCAzOjM5
IEFNIEVFU1QsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+PiBJbnRyb2R1Y2UgYSBuZXcgTFNNIGNh
bGxlZCBDbGF2aXMgKExhdGluIHdvcmQgbWVhbmluZyBrZXkpLiAgVGhlIG1vdGl2YXRpb24NCj4+
IGJlaGluZCB0aGlzIExTTSBpcyB0byBwcm92aWRlIGFjY2VzcyBjb250cm9sIGZvciBzeXN0ZW0g
a2V5cy4gIEJlZm9yZSBzcGVuZGluZw0KPj4gbW9yZSB0aW1lIG9uIHRoaXMgTFNNLCBJIGFtIHNl
bmRpbmcgdGhpcyBhcyBhbiBSRkMgdG8gc3RhcnQgYSBkaXNjdXNzaW9uIHRvIHNlZQ0KPj4gaWYg
dGhlIGN1cnJlbnQgZGlyZWN0aW9uIHRha2VuIGhhcyBhIHBvc3NpYmlsaXR5IG9mIGJlaW5nIGFj
Y2VwdGVkIGluIHRoZQ0KPj4gZnV0dXJlLg0KPj4gDQo+PiBUb2RheSB0aGUga2VybmVsIGhhcyB0
aGUgZm9sbG93aW5nIHN5c3RlbSBrZXlyaW5nczogLmJ1aWx0aW5fdHJ1c3RlZF9rZXlyaW5nLA0K
Pj4gLnNlY29uZGFyeV90cnVzdGVkX2tleXJpbmcsIGFuZCB0aGUgLm1hY2hpbmUuICBJdCBhbHNv
IGhhcyB0aGUgLnBsYXRmb3JtDQo+PiBrZXlyaW5nIHdoaWNoIGhhcyBsaW1pdGVkIGNhcGFiaWxp
dGllczsgaXQgY2FuIG9ubHkgYmUgdXNlZCB0byB2ZXJpZnkgYSBrZXJuZWwNCj4+IGZvciBrZXhl
Yy4NCj4gDQo+IFdvdWxkIGJlIG5pY2UgdG8gaGF2ZSBhIHJlbWluZGVyIG9mIGFwcGxpY2F0aW9u
cyBmb3Igc2Vjb25kYXJ5IGtleXJpbmdzDQo+IHVzZSBjYXNlcyBvZiB0b2RheSBbMV0uIEl0IGlz
IG5vdCBlbnRpcmVseSBjbGVhciBmb3IgbWUsIGdpdmVuIHRoYXQgSQ0KPiBuZWVkIHBlcnNvbmFs
bHkganVzdCB0aGUgYnVpbHRpbiBhbmQgbWFjaGluZSBrZXlyaW5nLiBUaGlzIGlzIG5vdCB0aGUN
Cj4gc2FtZSBhcyBzYXlpbmcgdGhhdCBpdCB3b3VsZCBub3QgYmUgdXNlZnVsLCBidXQgaXQgd291
bGQgY2xhcml0eSB0bw0KPiBzY29wZSBpdCBhIGJpdCBpbiB0aGUgY3VycmVudCBzdGF0ZSBvZiB0
aGUgYXJ0Lg0KPiANCj4+IA0KPj4gVG9kYXkgdGhlIGtlcm5lbCBhbHNvIHRyYWNrcyBrZXkgdXNh
Z2UgZm9yIHZlcmlmaWNhdGlvbiBkb25lIHdpdGggYW55IG9mIHRoZXNlDQo+PiBrZXlzLiBDdXJy
ZW50IHZlcmlmaWNhdGlvbiB1c2FnZSBpbmNsdWRlczogVkVSSUZZSU5HX01PRFVMRV9TSUdOQVRV
UkUsDQo+PiBWRVJJRllJTkdfRklSTVdBUkVfU0lHTkFUVVJFLCBWRVJJRllJTkdfS0VYRUNfUEVf
U0lHTkFUVVJFLA0KPj4gVkVSSUZZSU5HX0tFWV9TSUdOQVRVUkUsIFZFUklGWUlOR19LRVlfU0VM
Rl9TSUdOQVRVUkUsIGFuZA0KPj4gVkVSSUZZSU5HX1VOU1BFQ0lGSUVEX1NJR05BVFVSRS4gQWZ0
ZXIgdGhlc2UgdXNhZ2UgdHlwZXMgd2VyZSBvcmlnaW5hbGx5DQo+PiBpbnRyb2R1Y2VkLCBtb3N0
IGFkZGl0aW9ucyBoYXZlIHR5cGljYWxseSB1c2VkIHRoZQ0KPj4gVkVSSUZZSU5HX1VOU1BFQ0lG
SUVEX1NJR05BVFVSRS4NCj4gDQo+IFNpbmNlIHRoZXJlIGFyZSBzbyBtYW55IHdoeSBub3QganVz
dCBmb3JtYXQgdGhlbSBhcyBhIGxpc3QgaGVyZT8NCj4gDQo+IE1heWJlIHN0YXJ0IHRoZSB3aG9s
ZSBjb3ZlciBsZXR0ZXIgd2l0aCBleGFjdGx5IHR3byBsaXN0czoNCj4gDQo+IDEuIEFsbCBwb3Nz
aWJsZSBrZXlyaW5ncyB0aGF0IGFyZSBiZWxvdyBkZXNjcmliZWQgYXMgInN5c3RlbSBrZXlzIiwN
Cj4gICBhbmQgdGhlaXIgcHVycG9zZSBhbmQgc2NvcGUgKGJyaWVmbHkpLg0KPiAyLiBUaGUgYWJv
dmUgdmVyaWZpY2F0aW9uIG1ldGhvZHMgYW5kIGV4YWN0IHNhbWUgbGV2ZWwgb2YgZGV0YWlsDQo+
ICAgZm9yIGVhY2guDQo+IA0KPiBUaGVyZSdzIHNvIG11Y2ggdGV4dCBoZXJlIHRoYXQgbWF5YmUg
ZXZlbiBzdWJzZWN0aW9ucyBsaWtlOg0KPiANCj4gQmFja2dyb3VuZA0KPiA9PT09PT09PT09DQo+
IA0KPiA8VGhvc2UgdHdvIGxpc3RzPg0KPiANCj4gTW90aXZhdGlvbg0KPiA9PT09PT09PT09DQo+
IA0KPiA8TW90aXZhdGlvbiBiZWhpbmQgQ2xhdmlzPg0KPiANCj4gU29sdXRpb24NCj4gPT09PT09
PT0NCj4gDQo+IDxNZWNoYW5pY3Mgb2YgQ2xhdmlzPg0KPiANCj4gV291bGQgbWFrZSByZXZpZXdp
bmcgdGhpcyBoZWNrIGEgbG90IGVhc2llciBhcyB5b3UgY2FuIHRoZW4gZm9jdXMgaW4gb25lDQo+
IG9mIHRoZXNlIHRocmVlIHBhcnRzLiBBbmQgSSBndWVzcyBJIGhhdmUgYSBicmFpbiBvZiBhIGdv
bGRmaXNoIDstKQ0KDQpJZiB5b3UgdGhpbmsgdGhhdCB3b3VsZCBtYWtlIHJldmlld2luZyBlYXNp
ZXIsIEknbGwgbWFrZSB0aGVzZSBjaGFuZ2VzIHRvIHRoZSBjb3ZlciANCmxldHRlciBpbiB0aGUg
bmV4dCByb3VuZC4gIFRoYW5rcy4NCg0K

