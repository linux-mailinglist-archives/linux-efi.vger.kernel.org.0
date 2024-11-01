Return-Path: <linux-efi+bounces-2098-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CC29B98AE
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 20:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9125F1C21E97
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 19:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8231D130B;
	Fri,  1 Nov 2024 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="QgYGcyLt"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C505E1D0DE8;
	Fri,  1 Nov 2024 19:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489591; cv=fail; b=SeKJtabxaE4797Z5QGXW9cPxjJTxQcRmCP+fhDJHcOXwtdEveeCeWMsJPWpwBbmFfc/zjKRrTZ03QWDrfiVMwO7nNqxputJUMDIM+7T0OCzvR4o7mEUL/NZZCLa3VB/NHW72Uh8XvQULiJdtVkrdKmUmoXus2Nrm1eht0MS6H/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489591; c=relaxed/simple;
	bh=Qt+Y0EPvFNwRXHjcSs0d6bjl8BG+UwdVbcHZRPR0Jp4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UWWH2lsAbxSKLljWDPJHyX8QhQnRSTL+xKKKCa7DakL+hw4I2L1DWzdjSAKBhMR3ovDUOdh/txN6bfc+pXGzWHFMrZM1dZCX1c0o5096NyMPO0YlUgMx8XQT0T7tqltDeczI2WZxDsQLO6j01m8vxxh8NlyXkpqJcd2cQfPDK2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=QgYGcyLt; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1I2ean007644;
	Fri, 1 Nov 2024 19:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=Qt
	+Y0EPvFNwRXHjcSs0d6bjl8BG+UwdVbcHZRPR0Jp4=; b=QgYGcyLtYu8Q9Wl8z/
	Go3kL8iOhVOMpkzdE6N+v6eVQFTDLFcYvd7VmcPaJUC4NZAs050wGHYFmOTyZ98Q
	TnDuJWOwtHMS3JUbbgw4HiABgmPZKrVZO3jH5O1ZnU+KNyFvVwrWj2mvCKKR0nGp
	zgcw67fYZUYFLqpsqVmU5mQMRR+RYS3ZSvsKv41HKmawLlRp+bOVtdSO8Jk7wRCz
	7k6yqc+z62Kqv+tFP4y7Sc5wZYX98t40vfmIakVxfry8y/r8BkgdGWMk0NJLXcRo
	CYXobN2jEgtxl8euBiPUp20X7WPCpUUYJSc84p+J0Bo4HpxgSZgOpv6YMVmyHBSa
	IXsA==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 42mx053b68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 19:31:55 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 53DF21374A;
	Fri,  1 Nov 2024 19:31:50 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 1 Nov 2024 07:31:10 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 1 Nov 2024 07:31:00 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Fri, 1 Nov 2024 07:31:00 -1200
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 1 Nov 2024 07:31:09 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kyzhf8p46ZbgPMHDPYkvgp25hgFAWKBwfulOMS+VtYIljKy0k4ZibyndFtbDi33lhFIyjTBelVi5jioDRp1+Tl8TlHOwF33JeiGApgBxSHoY2y68O/i+JRTQGMxeHGdrq9foWKqQx1IZIrysu3HVdflxa6ZRgRhcYlkeU1cdL24064zw7sS28tvyt1uZz1f2ZKl+AQrdmWXlLG2RR667GjNvCQ+3vV0Cl7ExtgRK7wkMBn9sRtUA3zbOV8o7ObLvf2GfQav6Wr3RwzNjOikObmXB87x2e/Iaefk5w2keu/Y4EDu2UFJTHnIIsxcJQKh5+t5tNWE5QYI9cePw5lm3BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qt+Y0EPvFNwRXHjcSs0d6bjl8BG+UwdVbcHZRPR0Jp4=;
 b=uEaGY8xtSImCZADmhbXaIyoOnb7bbzmU94bRioNlcRez/Ddty3R33SsCPKnJoatd+YXi3cY3lFSNesIfSeKA/7Cv6CeFmHZiH/o23fNJdrdGkxW4WdNHWtWu3OS3G8neJZRR41xJUbz0iS3DyRrysUDnQr9TgygDdnr47q8TyBApidkB9ht2fUtCkQGvgD1s/SGQhcIlqpJ1e6lvY5K5clo33Q1GHeQG+RKSEplwkrnGFzXwAP9weMtXb/frOH/U7CvUx80WVjIP0mIAg6WwXDiPba4gfZ3KGG0E2df7gODSDMmkInu/CtiD5c6w12iLDJs2qQXpjfhaMhBQRsEatw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM3PR84MB3714.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:0:3d::17) by
 DM3PR84MB3715.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:0:44::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.23; Fri, 1 Nov 2024 19:31:07 +0000
Received: from DM3PR84MB3714.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8f56:e2a9:32b0:75bd]) by DM3PR84MB3714.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8f56:e2a9:32b0:75bd%2]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 19:31:07 +0000
From: "Elliott, Robert (Servers)" <elliott@hpe.com>
To: Ross Philipson <ross.philipson@oracle.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC: "dpsmith@apertussolutions.com" <dpsmith@apertussolutions.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "hpa@zytor.com"
	<hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "mjg59@srcf.ucam.org"
	<mjg59@srcf.ucam.org>,
        "James.Bottomley@hansenpartnership.com"
	<James.Bottomley@hansenpartnership.com>,
        "peterhuewe@gmx.de"
	<peterhuewe@gmx.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "jgg@ziepe.ca"
	<jgg@ziepe.ca>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "nivedita@alum.mit.edu" <nivedita@alum.mit.edu>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "corbet@lwn.net"
	<corbet@lwn.net>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>,
        "kanth.ghatraju@oracle.com"
	<kanth.ghatraju@oracle.com>,
        "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>,
        "trenchboot-devel@googlegroups.com"
	<trenchboot-devel@googlegroups.com>
Subject: RE: [PATCH v11 01/20] Documentation/x86: Secure Launch kernel
 documentation
Thread-Topic: [PATCH v11 01/20] Documentation/x86: Secure Launch kernel
 documentation
Thread-Index: AQHbBhk1cjmy5f0J5UyAHliCaIVLyrKjDwew
Date: Fri, 1 Nov 2024 19:31:06 +0000
Message-ID: <DM3PR84MB3714A4632C4C7B6B50D7A0F4AB562@DM3PR84MB3714.NAMPRD84.PROD.OUTLOOK.COM>
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <20240913200517.3085794-2-ross.philipson@oracle.com>
In-Reply-To: <20240913200517.3085794-2-ross.philipson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR84MB3714:EE_|DM3PR84MB3715:EE_
x-ms-office365-filtering-correlation-id: 8c74005e-14c2-4a6e-4381-08dcfaabbb60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U0J2Q0NUR2N4UWI2Q2dudUgyci8wU1JVTFpRbDlHR3Y4dWZNYVFwNTh3NHpa?=
 =?utf-8?B?UFVrMEU2ZUNCSVJQUlFnakNUVkdhaGNEZmVqd1luNC9QWmh5WnljSzIwN1lI?=
 =?utf-8?B?cXYrMEhKcVllQzZnZDRJdzFDZ2VHa2NBci9Xc2RoRTlIeDZ2alhGM092Um4y?=
 =?utf-8?B?MW5xTGxMOFRlbW9Da2hpZXVpZ2JraXdkeEpqREZyb1VacGN6L2dmSTlRNWha?=
 =?utf-8?B?OFpMWVplY3p6elprcWRJQlJkakpsWUEzY1NXRTh3aE15bXNMSWd0SzFiQjR2?=
 =?utf-8?B?YmRDSnMrMmMrNHFEWEhwTlAxQUpFMEhmenpiMmJRZFhZN3Zpa0NHTVpiQ2ZL?=
 =?utf-8?B?UDVEek1Cd0NlSkhDV1ZRZXVnd2paWnhsUnE5QmRHV0t0dlNLYUlIKzBQZW9n?=
 =?utf-8?B?SS9LVnhPTUdvakxyd3liL05pREtGK0NUZkZZaS9BbUtVNHMrVzdRSURxK09l?=
 =?utf-8?B?YU5uVFBMY1FuUmZGb0pmNnhXRmEyR0pwbHFId0hLbEtrck1GTGpVN3AyRUhL?=
 =?utf-8?B?cHZvRTJVVlczd3FLRzQyUmtQY2tMek9tZjNZak9DVmJuajRsN2ZpendnU1ox?=
 =?utf-8?B?MXoxQ04vSmF2VnJMQzVxTVNZdE9VT0VnMWhPR3JLZlowZmc1VHdJRlVnTGMy?=
 =?utf-8?B?SDg5aVYwWVpQQzNJT0hxUHpYRlllTU4rZ3A0bVhlLzgwT0VZQmhGdUI1anBk?=
 =?utf-8?B?OEVzNHdzREMvRXg5RWpvd1VFN2dFZkF0Q0dXeGUrTm8wQjBBUGNTU2RHcWZR?=
 =?utf-8?B?RS9ZcnVHTmhzYWp6SnMyZStLUnBBQ2Nyc0txbEQ1djNHU2xEbFp1ZFRpeVI2?=
 =?utf-8?B?RTVVbExqKytpV2prU3piV1d0aGJvUmR3RWlyNVRNY0RPbTV3QWdxVStmL0w5?=
 =?utf-8?B?K3FlcG9nalpsY2NaYVo5UXFtckQxeThiM3ZYYUZjVWszcXhQaWk3dmJpcGZk?=
 =?utf-8?B?ZlNlZkdHN01td2tzRWM3VmdySTBITjdmWVRPSmpaWmZwSXRWT1BVMGJuQU40?=
 =?utf-8?B?SDNpUjZjNEFCaXpXWjRXS2FJeWcxWlFWa0gyb3l4SjBkTWdGTXF0NWNIc3Zk?=
 =?utf-8?B?S2Yvbk5JZ1pvNjh4UUluVkpXdG5hNU0vdXZ4QmVzTlI0VGo1d3oraFNiNS9p?=
 =?utf-8?B?OVNGTXJiZnJmOFJrOE9QZWY0WXR4NVZNZzlyWVM1L3VNeW1CVHZybjJrMWNS?=
 =?utf-8?B?SldWOXhlVUJVcWUrRFJsZnMvU09lblRwQ1g4QTg0dEw1UFk3NzcrbE5WNUc4?=
 =?utf-8?B?OFBHZ2xWeEM1ZlFETXorMHR2YVhWMlYxM3U2d05iKzRPWjM2alYvczVVL3Bo?=
 =?utf-8?B?a0xsOEo2Vmw4M1daSGNKaGlxSWI5ZlVmSTNiN2JUdHF2R0ZLRUJjZU9TdHFL?=
 =?utf-8?B?V2VRd0pNVlVsNkZZc1J1aUl0QlhSZjdvbEN6bGF1VGVnQWFXZ1NHQnJnYlFm?=
 =?utf-8?B?bld3TmhJM1FKK3ViTHRid21NQ0RWeE5kaWYwNlVkV0ZJa3lDN1JsOHhOY3NV?=
 =?utf-8?B?OE5tMzJQekZPUmJoalVFOVpiYWExZzFRQUR1MzlYajJHdDRWZFRGNzhMMStY?=
 =?utf-8?B?ZXJXSDVTQ2VYLy9peU1xNlZRZ1U0SDQrK2JjNFlHaE1ubGNJM2ViYUpjR1Z4?=
 =?utf-8?B?dDFmWW1vU1hYd0x2SStYdjJ6NlVySHhZM3RPNzV3SHc1QU9pM2ZPU3A5dE9E?=
 =?utf-8?B?ZUh2U2RqaVRab2htREM0d3N2dy9qbHdzc2pmbTVCWUp0bVZFMnVlcnJjUVBP?=
 =?utf-8?Q?DoApppq37f/FZVwJV9wYFYFCTM6nqUUqdkrk3C6?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR84MB3714.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blBiMGpXaDFLaHROSTNKOEZhVXRRNks1RXUxejBYZkxCR3VET3VIempBOUV3?=
 =?utf-8?B?TnMvUGZBNWxESGhlc2szbFN2M2hQSEkxWEdqMUJ4akFvQUlUcFhjbXN4YW5V?=
 =?utf-8?B?QnJyV25taFVXbjVEaVg3ZFZmbkVlditQaU9IalRBa2hVZlFCbGJqdDJCRU9h?=
 =?utf-8?B?dzlzTUdWSjhBSGlFRy95TlZaUHpzUEtQYUpZMEhCVGd0VDd4dmJJY3NLbExK?=
 =?utf-8?B?UEoyUCthQUwvS1gyZVkzd2FxZW5yODVyMXpyejVMdktmN3hmRUNIdmtNYTlH?=
 =?utf-8?B?Y2FUSmRZV21lRFFVSXBQRHRkZjk5djk5OEtqeGJNTHlzTlRKOHBTanBHakUv?=
 =?utf-8?B?TWZhL1NmSXV1dGdmTDU0SEhFUWh3WUF3VDVnRnJsWmlZeTFlc3BmM0RhcE5P?=
 =?utf-8?B?K01Nb1RRNEkvVUcvblpmVUtPcm5rRzFWT1ZrSlpLdUlhWE5RUnZHNHAwRkhV?=
 =?utf-8?B?ZkNkQjZkSTdwUkQ0MmZiaXc5NTdwTWZyZ0tlT3BVb0V5VGw0cW10MTBJL1Br?=
 =?utf-8?B?YkJZTzNEZEI1SlNvT3Q1MFlXT2l5RHFaTnBEcXdUMS83UWI2TFRITzlEZU1B?=
 =?utf-8?B?eW5yMFcrbVM5d2U5WG5XOEtjQW9DR2RHVGFtbSticWprWkluVHZRS2FBeFp4?=
 =?utf-8?B?RXJLOWF4S1NpaS9yenE3OHJ2dnd1clU3QVQ5ZmNWalhwOVlNNlNvT3c4dld0?=
 =?utf-8?B?cXpZNEdaZGxMUUpaeElsOEYvQks5Y2J3N3VhVlg5RGhzV0pDaTRnQ2dUcERq?=
 =?utf-8?B?elRoZkg5WXVJMkJ0YVJHUXdHRVRmY2hTM0lSdC9oUm9lSmhQSG5qY0dNOW5J?=
 =?utf-8?B?ZmN4dHdRYmpjUzVSLzA5cXlRTTl4VzAwdnNxUUYxTHhFcTRpa3NDS1lKN3cr?=
 =?utf-8?B?UFZEQVZqZkhlWVZOeEprTm5pL0FTcllaOXd5OFB2bUh2NVlxeXdUdzN0OHEr?=
 =?utf-8?B?SEZsbE4wTUFSMGJWUk5xR2pLSVNlZ0ZKMUprUitjM0pZRHJKM2trN0hHb2xv?=
 =?utf-8?B?dHhXVG8vdnpBcW00NC9jc280U1k2bmJiNVN6Z0dJNHJzRDdWMzBIYzNoZUV4?=
 =?utf-8?B?dVJuanV5RzZqZ2hyaHZnNFFBWGQ0am9scjFJVDdHczFoUTdQRkFZUTNCSS93?=
 =?utf-8?B?bGhSTVFxMGx2SzR0YnIxYXk4aEM5b1VGcXdWQVdiV1lBbVVHR003NlI0cTla?=
 =?utf-8?B?enZLT3dCTzlZNFVRM2JEMnZ6YjFiT3hSRmFMWmFIWGlnLzBIaDhQejhZRHNU?=
 =?utf-8?B?UFJabGZNQTRpWW9vR3BPZ1Bzb3NDWEV5UFlXLzZoTTRWMkFRVWsxSk54dklr?=
 =?utf-8?B?YVFjU2trdnZvc3lmRk5RVlk0dVBwUjcxV0xRK0l0ZitwK296Z0dtaGJPNS9X?=
 =?utf-8?B?UU5qMjBWdlFKVUFlTG1adFJybXlKRnBEMW9OdU5SVUZWYzFyalQ0ZVZrU1NY?=
 =?utf-8?B?ZDJTSTNDSC9Cc2U3bFZzRjNsaVFSZTh1bEJYQXNIaEdiMTUwUFAxYU9la1A5?=
 =?utf-8?B?SjJIUU4xWHV4Rmc5alVvd3FQaVd2WUxnd3R6RW03MENZMnlnR25wajFSV3l2?=
 =?utf-8?B?ODZ5SXJSaHZqblZsSXNrTFB3cHFadUpaTGNZQjVFQjdkL1VEdTBUb2d5OXli?=
 =?utf-8?B?cHppMEZRVGx4UGVVeGdWM0s3RDhSNlVLdTgzSUd0YitmVjRCaDJzbDVkZGF2?=
 =?utf-8?B?WXpBbXZmcFUwM2p4Yy82UGRXdWZMRGFjeG5ITGZJU0RKYlVrWU5RcHdkUGdU?=
 =?utf-8?B?RCt4OGl2OHM2b0RRT0tEWE9OSlp0Y2NYVnBEYkNKdVh1QTgzVmJyRDJHanVx?=
 =?utf-8?B?aXorcXZxRmVlTXc2aWJnUWN3WFN5emVqdVRoVE11WHFVYU5rQU00T1J5YTZs?=
 =?utf-8?B?aU5XWWNUenBYcVZPaU05eWE0WmtLUitoVTIvcjVrYmhBOUhWdlZqZ3JwRkg0?=
 =?utf-8?B?THRqT2g3RjZTY1BSSVI4bTZtbm94UitnR0NaM0FLNWVMQmhIYmdZb2VQNUFv?=
 =?utf-8?B?dzRyLzA2Wk0raWIzdEJCMGVBcU9XWFkyU3NKSG5Jd2hucDdmS0RUMmxxSTNv?=
 =?utf-8?B?bEErNExBYlgvSmhVWW4xTWEyMUkzelV4TmZWM1Y2dDdQMzBCZU1td2owWVVO?=
 =?utf-8?Q?a8Mc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR84MB3714.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c74005e-14c2-4a6e-4381-08dcfaabbb60
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 19:31:06.9244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: veYmmTpuugPgwmuTy4vyGWMW5Ea3oy8yAoqFYp8cjAcwE+AnIegBAr7pDGRk3qFJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR84MB3715
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 01FIJu-WAqlPA-E1kMpd_jY-Iedi0M1v
X-Proofpoint-ORIG-GUID: 01FIJu-WAqlPA-E1kMpd_jY-Iedi0M1v
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010139

PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9zZWN1cml0eS9sYXVuY2gtaW50ZWdyaXR5L2lu
ZGV4LnJzdA0KPiBiL0RvY3VtZW50YXRpb24vc2VjdXJpdHkvbGF1bmNoLWludGVncml0eS9pbmRl
eC5yc3QNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9zZWN1
cml0eS9sYXVuY2gtaW50ZWdyaXR5L2luZGV4LnJzdA0KLi4uDQoNCj4gK1RoaXMgZG9jdW1lbnQg
c2VydmVzIHRvIGVzdGFibGlzaCBhIGNvbW1vbiB1bmRlcnN0YW5kaW5nIG9mIHdoYXQgYSBzeXN0
ZW0NCj4gK2xhdW5jaCBpcywgdGhlIGludGVncml0eSBjb25jZXJuIGZvciBzeXN0ZW0gbGF1bmNo
LCBhbmQgd2h5IHVzaW5nIGEgUm9vdCBvZiBUcnVzdA0KPiArKFJvVCkgZnJvbSBhIER5bmFtaWMg
TGF1bmNoIG1heSBiZSBkZXNpcmFibGUuIFRocm91Z2hvdXQgdGhpcyBkb2N1bWVudCwNCj4gK3Rl
cm1pbm9sb2d5IGZyb20gdGhlIFRydXN0ZWQgQ29tcHV0aW5nIEdyb3VwIChUQ0cpIGFuZCBOYXRp
b25hbCBJbnN0aXR1dGUgZm9yDQo+ICtTY2llbmNlIGFuZCBUZWNobm9sb2d5IChOSVNUKSBpcyB1
c2VkIHRvIGVuc3VyZSB0aGF0IHZlbmRvciBuYXR1cmFsIGxhbmd1YWdlIGlzDQo+ICt1c2VkIHRv
IGRlc2NyaWJlIGFuZCByZWZlcmVuY2Ugc2VjdXJpdHktcmVsYXRlZCBjb25jZXB0cy4NCg0KTklT
VCA9IE5hdGlvbmFsIEluc3RpdHV0ZSBvZiBTdGFuZGFyZHMgYW5kIFRlY2hub2xvZ3kNCg0KPiAr
R2xvc3NhcnkNCj4gKz09PT09PT09DQoNCj4gKyAgICAtIE5JU1QgQ05TU0kgTm8uIDQwMDkgLQ0K
PiBodHRwczovL3d3dy5jbnNzLmdvdi9DTlNTL2lzc3VhbmNlcy9JbnN0cnVjdGlvbnMuY2ZtDQoN
ClRoYXQgaXMgbm90IGEgTklTVCBwdWJsaWNhdGlvbi4NCg0KQ05TUyA9IENvbW1pdHRlZSBvbiBO
YXRpb25hbCBTZWN1cml0eSBTeXN0ZW1zLg0KSSA9IEluc3RydWN0aW9uLg0KTklTVCBpcyBqdXN0
IGEgbm9uLXZvdGluZyBvYnNlcnZlciBvZiB0aGF0IGNvbW1pdHRlZS4NCg0KVGhhdCB3ZWIgc2l0
ZSB1c2VzIGEgcm9vdCBjZXJ0aWZpY2F0ZSB0aGF0IGlzIG5vdCByZWNvZ25pemVkIGJ5IG1vc3QN
CmJyb3dzZXJzLiANCg0KVGhlIE5JU1QgZ2xvc3NhcnkgaW5jbHVkZXMgYWxsIHRoZSBDTlNTSSA0
MDA5LCBOSVNUIFNQLCBhbmQgTklTVCBJUg0KdGVybXMsIGFuZCBpcyBtb3JlIGVhc2lseSBhY2Nl
c3NpYmxlIChidXQgdGhlIGVudHJpZXMgYXJlIHN1YmplY3QNCnRvIGNoYW5nZSBhcyB0aGUgc291
cmNlIG1hdGVyaWFsIGNoYW5nZXMpLg0KaHR0cHM6Ly9jc3JjLm5pc3QuZ292L2dsb3NzYXJ5DQoN
ClRoYXQgY3VycmVudGx5IGNvdmVycyBhbGwgdGhlIHRlcm1zIGV4Y2VwdCAidHJhbnNpdGl2ZSB0
cnVzdCINCmZyb20gVENHLg0KDQo+ICsgICAgLSBOSVNUIFNwZWNpYWwgUHVibGljYXRpb24gODAw
LTE2MCAoVk9MVU1FIDEgKSAtDQo+IGh0dHBzOi8vbnZscHVicy5uaXN0Lmdvdi9uaXN0cHVicy9T
cGVjaWFsUHVibGljYXRpb25zL05JU1QuU1AuODAwLTE2MHYxLnBkZg0KDQpUaGF0J3MgYmVlbiBy
ZXBsYWNlZCBieSB2MXIxLg0KDQpUaGUgTklTVC1yZWNvbW1lbmRlZCBVUkwgaXMNCmh0dHBzOi8v
ZG9pLm9yZy8xMC42MDI4L05JU1QuU1AuODAwLTE2MHYxcjENCg0KPiArICAgIC0gTklTVCBTUCA4
MDAtMzAgUmV2LiAxIC0NCj4gaHR0cHM6Ly9udmxwdWJzLm5pc3QuZ292L25pc3RwdWJzL0xlZ2Fj
eS9TUC9uaXN0c3BlY2lhbHB1YmxpY2F0aW9uODAwLTMwcjEucGRmDQoNClRoZSBOSVNULXJlY29t
bWVuZGVkIFVSTCBpczoNCmh0dHBzOi8vZG9pLm9yZy8xMC42MDI4L05JU1QuU1AuODAwLTMwcjEN
Cg0KPiArICAgIC0gTklTVCBTUCA4MDAtNTcgUGFydCAxIFJldi4gNSAtDQo+IGh0dHBzOi8vbnZs
cHVicy5uaXN0Lmdvdi9uaXN0cHVicy9TcGVjaWFsUHVibGljYXRpb25zL05JU1QuU1AuODAwLTU3
cHQxcjUucGRmDQoNClRoZSBOSVNULXJlY29tbWVuZGVkIFVSTCBpczoNCmh0dHBzOi8vZG9pLm9y
Zy8xMC42MDI4L05JU1QuU1AuODAwLTU3cHQxcjUNCg0KPiArICAgIC0gTklTVElSIDgzMjBBIC0N
Cj4gaHR0cHM6Ly9udmxwdWJzLm5pc3QuZ292L25pc3RwdWJzL2lyLzIwMjEvTklTVC5JUi44MzIw
QS5wZGYNCg0KVGhlIE5JU1QtcmVjb21tZW5kZWQgVVJMIGlzOg0KaHR0cHM6Ly9kb2kub3JnLzEw
LjYwMjgvTklTVC5JUi44MzIwQQ0KDQoNCg==

