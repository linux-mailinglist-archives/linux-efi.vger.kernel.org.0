Return-Path: <linux-efi+bounces-2498-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09307A010CC
	for <lists+linux-efi@lfdr.de>; Sat,  4 Jan 2025 00:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA7307A1C96
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jan 2025 23:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E433F1BEF73;
	Fri,  3 Jan 2025 23:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mrXHHnKO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fGzl/K0u"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D873B17B402;
	Fri,  3 Jan 2025 23:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735946099; cv=fail; b=LyL1IbXWKdEX/IM0OCbVPOLZm+Gm6BgcOLWDZzQRvTio4Uvodvtq4N4gYFseTUKvNlVwxjT6JN0UjDXEomkq81000pXv/1ZC1F4HFtvB0ALPz7YHfthVEr3uVhglu+RmwvrEpKNysxod8qky/UMVjyV8FvfXV0u/S9b8/V+OIAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735946099; c=relaxed/simple;
	bh=aVOdQrcc6ZlojbNzaCYhGba2UmWHCwtxagrSsotSrBg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gjc0OPojLZj7o6GTQMoFXbwIEWPhE7UghSz4btqcIos+D/s6qYn+ySYQeoWwVcNgKB3knlgc6wYl0Ay3eMJfGure2fiM73jS5BqPvyE+0eWhWOzatr5Mhh1hewBJleRR904amI7NLHg89pJ/ZuiQaKIJU3VE4+IbMUV2tm9rdnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mrXHHnKO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fGzl/K0u; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 503IdeiJ026059;
	Fri, 3 Jan 2025 23:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=aVOdQrcc6ZlojbNzaCYhGba2UmWHCwtxagrSsotSrBg=; b=
	mrXHHnKO3GkyYdUPu1rR3LxncLuRbzlyNoPdz/bZtnVzgzAi30YZhq66/vsRSOS8
	LX06r4Xqc6kxm9bI1HetWbFuCO9KbPUHhP8PUMk/4vhaS9oWFJc7CdsVEWex+b7o
	60uPmX9IkCfkmn4xRu9VauE/xwZDpxzE9cyIZDooPL6RdeLqJcxhbLLCEAH8feFJ
	KlPsKZbe7TIGHP202X6S3qQ3yVkb77JlodKrk5lRDu4nzQkHL1e+eHcWHq57WKnX
	5pTt1K7pFaJHNMK1pks67OdDDpNu7Y1wUiZ20FGjnGzIRVc3t79724dWoojHC7Nc
	gK8085g8pyOYNR04S26pmw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43wrb8btk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 23:14:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 503K8hbJ013017;
	Fri, 3 Jan 2025 23:14:18 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7sa5en0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 23:14:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKNfXnRdk2PFRFLUoRG4H0XvAF3fq8KoCuYLivVnQqbZ6UL8RMGqlbjMSRohUJCAeGe21rlY8W61ah7uD9aZC+yT4DyhFdEmblH6lYGPtkr41bXdL0u3L69oo/Y+isFmD24PPxoshQtMtNqlSG3pxZKLj+r5Vebdi97t1eioolqd4Zqpo2ba35YDTCdGR8eGAMVS2VJ5cxsj8AhN+2JUvcdEhCdNnsZus7DyRyV0HqmB2YQ5+n+0PJRqTnJDPPWzsrazLVcFOD4hjE79+tRG+rmyvnBFH82zOA7T+hUcKetlAJfjsHip8RwstRCAMYxpLzsDCTT8zxSO4qy1L5m3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVOdQrcc6ZlojbNzaCYhGba2UmWHCwtxagrSsotSrBg=;
 b=O2I1bOE9A7AUjbtOsQoOlZhqJWHkAws6izbcgZVKB9AsSFMrvCUSbV6IgCuQ0bJhINvDudSxoz15GlEVS7N0Po3wo5Vq/Q6CwG9n1JcDJmGh+rLCw/YGvlFf8lZu9aI85PEAoAC3SsDa0fkkhx4vj02aqlZwMFGpp6+9FK+eEDo6luDEsgwxzm7P0DPnafaiZC5/X1i07E+8NLBPqGyY0/xaVjizYhfv3UQN3B/mNS19Qo4a0FzwaPeuE883EyEcJ3AkhtfEtQrktxh/oWfqlLwWNTW7IMOMudNBTPBRDEyPhSUB5gsikarHNVkDGW39PPC7/sVKBqPV/VBNSt2GLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVOdQrcc6ZlojbNzaCYhGba2UmWHCwtxagrSsotSrBg=;
 b=fGzl/K0uA4VvpxsFsCKhz6nR6nsz3lS+jdPVDMpknp8ecr+ZfImnmCZmvC6e7y9RiMLSOucKlFQdk7FW+fPyt31Lb/vKpU/FrGVExiitDqCZcQqz5YL7GmENi0JJEF20f4Yhk49ICAkX0qdmrgMJJeLlMVOnHyVPHtkyolpYFZg=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by LV8PR10MB7967.namprd10.prod.outlook.com (2603:10b6:408:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 23:14:11 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%7]) with mapi id 15.20.8293.000; Fri, 3 Jan 2025
 23:14:11 +0000
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
Subject: Re: [RFC PATCH v3 00/13] Clavis LSM
Thread-Topic: [RFC PATCH v3 00/13] Clavis LSM
Thread-Index: AQHbIK0E/vdc4Eou30K4SgPRfeDFerL0Jc4AgBIDLwA=
Date: Fri, 3 Jan 2025 23:14:11 +0000
Message-ID: <72F52F71-C7F3-402D-8441-3D636A093FE8@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <c490397315c2704e9ef65c8ad3fefedb239f1997.camel@linux.ibm.com>
In-Reply-To: <c490397315c2704e9ef65c8ad3fefedb239f1997.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|LV8PR10MB7967:EE_
x-ms-office365-filtering-correlation-id: 6a114fbf-603d-46fd-d96f-08dd2c4c552b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T1EzNDRMRWdSY2pSRDZWMzY3M1VwcGs5TkxwTXcvUytVbzJVcGdGZFp0SEJH?=
 =?utf-8?B?R0dWZnBUbEFqVzJwQW1iZitZZHdrUktuRVJoUU5ZY0xLVW1ET0FQL0M4MGZ5?=
 =?utf-8?B?Nml0K3VTNjg3VjVQeXJPTWI0bHBYVVVqRzMyWGJnazdLeEhKMERMaWlNQi96?=
 =?utf-8?B?clBnYWRPNW1iU2IwbUtzTFcvTmwrS2JoUlhvUHMxbkFHdkpRTExSTm5nYUFs?=
 =?utf-8?B?MkJOdFdUZ0JSdEVndXFzV2ZkY0FaRWtBUzM1a1lwdG9namUyNU5DTWlXRkRD?=
 =?utf-8?B?L09nR3NaR3FJSzUxd2E1ZWgxbmdzMHZKd0JPaW4xeTdjVDgwOS94Y0Mwczh1?=
 =?utf-8?B?MEhhRmoyOXBKeW85S1lSTmpQUHhaRjgzMi9HSSthc2x6VzRqbEZmN1NjQTVS?=
 =?utf-8?B?NDNMTFVRYVhmZzgrYlZpZG5xOExsS3pMem50Wk1sMzYvbzFnSEI0bmVTbTlR?=
 =?utf-8?B?QlZYd2Znak8yRVIxaFlsNGZNbVRBK1pZcFIxL3FrTWpHdWNOYWZSc3BjeENO?=
 =?utf-8?B?TkpZUC9LUjBvUFpxRlhnTk5oNDJldm9NZXNzbU9FN3M3VGlTWHJvdXJwYVZD?=
 =?utf-8?B?UE9HVHRGWWg1NzRjV1dtSDRvQStoSVZBWDFXV3dyZVZmK1dtODQydnZYY0FO?=
 =?utf-8?B?QVc3Q1dsd1doVW1WNzlTRThuQnMrb3NOdU9VVUtXbGo3MytDSzFTS3ZSOEg4?=
 =?utf-8?B?NFZrQmNHd1FDMTY3U2crY3hFU2lNdmFobHJIejR3NDYrekUxTXJzL01BSG1Q?=
 =?utf-8?B?UnpjdzNaNElFN2VGSHZkYVFaSmE3L2FWcm5tSGRVMGJmMXpjZExZYXZtSDdh?=
 =?utf-8?B?N2JnZDZJY2M1bi9jaGNqQzVYQkNTT2d5eHl2SUJRWE5TRzFjbFFtN21QS1Ew?=
 =?utf-8?B?UEVyVW92cHJYSGVJVm51VmcvZCtCTEJuT0dhRC9ZNXpKUXJzZy94aXZwVGI2?=
 =?utf-8?B?TXpoZXIvdzlPaDhJTUNrOVZJRitwbkdGWHBCcUYxeEVWcVFFQW1BSkRBa0Fr?=
 =?utf-8?B?cnBuNlFzS21WWGliWUIzalVUcGJ3eWdueFFucnU2RXFyK2x0cnNaa3N1ajd2?=
 =?utf-8?B?NDljVUNKU0VDZUJ4K0xtcjgzbi9IY2hRTjhqZjA4YU1XRmpNU1Z5bWtBZHox?=
 =?utf-8?B?YjBURERRemFtaXFYeDFDVFBRcEhOeVAreW03Y1oyVGRTR3pLYnAwd1RiNTBa?=
 =?utf-8?B?RnZoV1FodHNlb2lmRlltZFc4VjNBVTBsdlc5ejVFS0pxMVNJT3RGQms4UVZr?=
 =?utf-8?B?c0RZQk8yZjB4MVhtbHh4NE1EWnlQbUZTYmpqckl2MFZyMkkwUUJCSjI2ak5m?=
 =?utf-8?B?SSt2QVFIRy9JRnZUNlkrVlhqVVA3SnZLM01CWlI4RmZYRnUwcXMySUJ0UU03?=
 =?utf-8?B?dFZjdU1rVXp1NXhmNU5vb1dNVnp4NThmMi9ROWh3NlBGcjBQSTVpREpzSURm?=
 =?utf-8?B?ajdsc1F1Q0tIb3dyUlBKR2Z4ZmNJbTF5cCtUUUdhWENKbGh2RGNrcXdUNFpx?=
 =?utf-8?B?bXB5VDlUbUZnamZJeWZKMXRBdzZWSEJmODhwT0ROdXNqZWFkN1BYMjY2TXkx?=
 =?utf-8?B?eGFQTEdVQVMydWZTK2dMaVhjaGpFSWxka0hDWUZ5U25LanQzSTlkWkw5TDRj?=
 =?utf-8?B?TFdsblNrZVBKcGRHbnB0aFl5ODd0dW4xeFJMQjVtQVhSeU53Y3RRbmkwc1Nz?=
 =?utf-8?B?L0tmdEwzWFVOY1ovaWZzdDY2UDc0ZVMxTHh4b2RJSnpqbmg5SWNsSkRvYUhL?=
 =?utf-8?B?RDlDenpDWTdKak9LN25mdDRSbWxpSVpsdjE5dXZUYmkrdVdwK2ZHNlVWWEVv?=
 =?utf-8?B?R2ZFK2NaV1NEVURreHpQSkFSMFhlZVZSVS9mN3VFZDlrY2ZVRTRuTU5SZU5L?=
 =?utf-8?B?NXRYTnNCRzh0NkhDdmNkdnUrVVVVdUdMSFpybzFJQVA3U0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YSt6b0NSMWQxV3RTREdQVHRRNW81Y1YyUDVuT1hYVXJoUld6OEUyTFB5RkdT?=
 =?utf-8?B?ZnhJSHR1QUQwMFIvMGFjc1pFVEFEQXh5VW1VYnU5OTJqZ216YVZUS0Z3b2tn?=
 =?utf-8?B?b212SXU3NUp0cEdKcnZqWGxkcEdZZnhNSW4wZzh2VmRjalRIY0ZEeVFWRVZP?=
 =?utf-8?B?MmIvNlRhQ1l3dExnTDNNYk83d1A4TjdIYWMzemNvMlMvNW1MaVNiVW4zS0NN?=
 =?utf-8?B?QmhJeTUyYitwbkdFd0NLWTExQVduZGJtaHZ6VUE4M1dEYzFYeTZVdDJSOEVo?=
 =?utf-8?B?TzVaV204d0N4b3Z0eWlZbUZDZHhnWVJ5UzVtRFRMRE5kNGxqUnQzZ3V0L1ZZ?=
 =?utf-8?B?eGU3VHBLaGt4cEJJTWk1K3EyQ2k0VFRaakFiM3Nta0lSSjd2U1NCUTdkZVFJ?=
 =?utf-8?B?MVFNL3N0YXhxa0c4endVSzlsS0UyaWp3clpBVWR1Z1NkeElpUXgxdTZNbEJz?=
 =?utf-8?B?cm1QcVVQdCtGL2ZROXduZVlkSHZBelcvaDluNDYyVzhxZmhPVzh2Z0hlYm1w?=
 =?utf-8?B?SGNkK2MwWkRPQ1dtTzl4M1Z5ZnVIOWdkRmE2dEcwZ1NuWGwxNkl1UVpsbU1h?=
 =?utf-8?B?TVhmUjFjQzlMT055cXhOQlVVbFJIQU1ZdDBxTis3cXNic0psRXNzS2d3MlJm?=
 =?utf-8?B?dGd1eHJZYTNTTlZEZ1ZRYVNRbk80YjEzVzEzMStYV0NXR3pQN3h5b2FJMGpP?=
 =?utf-8?B?N0Zqdlo0dVZGdjdYem5lNFpxZmhJYnZPTVZNM1dTTXZRaXUweXd3ZzVNd3NF?=
 =?utf-8?B?NlBScVd5YVVZMDhtT0V4NkhWZWhTOG95NU40b1Rwd2YyeVVNV1ozd3J4L3gv?=
 =?utf-8?B?YXNWUytIM0ZXK0cvNG8vVE94L1MrSFN3ZTRZaHhPVHd0UEdwNW03N1RKemd1?=
 =?utf-8?B?bUlMeXlidjAzQ0lQN1IvNVhNTXpMbEVqNk9zMmRTY2J1bTcwNkRsOVNaeENU?=
 =?utf-8?B?M0tYSFhTS3ErOGMrU3YvSzRVcVhHUjNwQzdGVEVZbTViUkE1blY0S041UjJo?=
 =?utf-8?B?eWtNQStnS0Q5amNCaFdmUjZkcHl1NUtBZ01qMGhISlhZUHFscThvbmZMUElX?=
 =?utf-8?B?RUY2UXRNaHVKNmpZMUxBREYzeFFCc05vbXVZZkpJQi9YL0Q4U0hqcHE0bllh?=
 =?utf-8?B?Zkd5alZRMXdmclMzSDNnL2d5UG8waTRkWnA4T3N4dWtWcS92QTh2M1hxM1NC?=
 =?utf-8?B?cmV0RFZkSlNveE9kQmRVQnFPWmFHdUVVTE85ZmhNR2pzYWZucVN2SVlxY2py?=
 =?utf-8?B?SU90S25SVWx2SmlVS2JuSjVwWXlVdnBFaTU1V29BbEtiZnJzdmUrQ0hYODhz?=
 =?utf-8?B?WGg0alNmSks0cElwRStIZGdSNWdQU3Jvd3RGcVFEWEdVTldJOWJCRnplNlE5?=
 =?utf-8?B?SHpnNkZ1UTAva1dJb0hiNk81TzN2eGdCU2lWcms4NUFTTktpME5Gc0lwK3Rq?=
 =?utf-8?B?d0dhQjkzUlU1REFES2FrdHlFeHozMzA1SG03OGVqK3VZTGlaMXBMR2ZtOGtw?=
 =?utf-8?B?Q1JGMWhNRm5nQ1BneDFpdUY5S1FLZHQrQlhYeFRqNHdLQlN5T3A5M3dRdzBw?=
 =?utf-8?B?c1JPZW9pZzd1Y2thcUlGaEZJUXFYNzFCcE80UzEvZStVUzB1WFJjRDloS2oz?=
 =?utf-8?B?b0E5N2xMV251TVRpODQ2MDV3REZubFU1ZlJwbkVKUkNrT2NLWjlMYWJNTU9D?=
 =?utf-8?B?b0pybkh0OXJjLzA0YkFLMVhyMzJoeXhHOHhNZ2I2MUhia1FqS2pNLy9DY2d2?=
 =?utf-8?B?cTBJNnRJZFZDZTNEckpieFgwZGpiT1Q3NkhvRlYrVDZzSUsxbUpDenA3d2VS?=
 =?utf-8?B?N2h1ZWl5bFFUQlFEb0hTSEV1OTFEY2JiTGU4S3dwbVlrMmVnemU4Rmx1Zlp4?=
 =?utf-8?B?cm84bnhRcDY1cWk3YmtwZEdwUkR4UHlUT2R5TlN2dDUxZWRNUThRODJsN3RO?=
 =?utf-8?B?anZTYWRlbE1STVFKWjhmWElaOHRrUWYyaGtjUnlMdncrNUZLT2d0aFdldTl2?=
 =?utf-8?B?eGFZaUs0U1BDN0ZiVG16MGZLOHkzMjBydTRNME53ZXljM0U5cSt2SmpySS96?=
 =?utf-8?B?d1g1V2hPQ2FwaFE3akRId2YrZ0Q0SDhoZ0xBQXZwUTI2RmdXeU5ZeXQyeWZk?=
 =?utf-8?B?TzMwV05jYnRTMXlCQmREZVVtRkpHdjhRMmFnVCtWZnJ1RnpWZVd0bDRvYVZZ?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <164EBC74ED7541439EFB0FD74A214825@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uHQIzqdkMeODZqvPXyBbowMvlJmuJMR5svd9OXBluMkEiGBR0dklQh5C7y4J/DkoeT87h9fSbWMMescW3swLJJbsrbVgDPr4bHnjvPGGikLucZuVRe9ntm7vS0f8nDBAZnlCj7K6WeCMV/USaWUuEiwfoLmwvEO+ryWOE31GRAMq5CjQ11DBo3NLrGMtD+7p/qMYzGPhCyuXk+kCKhS9QpMC7C7cUga1r+KfBFJ1ZIUwEp56voqT92nE+OK0mGOoMXNyMfAwoV6dhsH1bWA+8eJxBcXNOyaBO63NyMaedzibNYTdAEQqQA+2WdrR/66+546UAEikEnb0RW1QgFlk9Och4c1TzMHxjAp2s6jHMA7Rv19cShFMNss6sgJpAd1dtqJPY+Wv/H2/JZs/Wy2vCrM0/H9J4cIfgP2wcfS6peGSz4oP4frGpZB3NWEKlVFvBQ5yDERjZZOFitYKLjQViX+mFkXz45IjpGd6gRp3h04rZNd397e3OM2kY7D+L5Rb9llWiGpzag0cPIGL5+oBnCr86MBXI0hNkH16VgGP71fWMEbbQlSHFUTTwKYoZHbUJqzl/HMnoAzZkmHEz3gX8PcwqTmanWQMBrMe6O61EaA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a114fbf-603d-46fd-d96f-08dd2c4c552b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2025 23:14:11.4040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rxkMhs284IJbm4HaiRKgy0X8IRTUjiu5hVyVuQ0Fm2Xk9YJqb1wA0/pfNEYaWXqyjSTSPuOWxWVAUz2I9J9zOSeSYMIJ1TylqTYl4y4Gu4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7967
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501030206
X-Proofpoint-GUID: iScp2SUclzkSc6nXZOGW7p35gtpmoT2c
X-Proofpoint-ORIG-GUID: iScp2SUclzkSc6nXZOGW7p35gtpmoT2c

SGkgTWltaSwNCg0KPiBPbiBEZWMgMjMsIDIwMjQsIGF0IDU6MDnigK9BTSwgTWltaSBab2hhciA8
em9oYXJAbGludXguaWJtLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIDIwMjQtMTAtMTcgYXQg
MDk6NTUgLTA2MDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+PiBNb3RpdmF0aW9uOg0KPj4gDQo+
PiBFYWNoIGVuZC11c2VyIGhhcyB0aGVpciBvd24gc2VjdXJpdHkgdGhyZWF0IG1vZGVsLiBXaGF0
IGlzIGltcG9ydGFudCB0byBvbmUNCj4+IGVuZC11c2VyIG1heSBub3QgYmUgaW1wb3J0YW50IHRv
IGFub3RoZXIuIFRoZXJlIGlzIG5vdCBhIHJpZ2h0IG9yIHdyb25nIHRocmVhdA0KPj4gbW9kZWwu
DQo+PiANCj4+IEEgY29tbW9uIHJlcXVlc3QgbWFkZSB3aGVuIGFkZGluZyBuZXcga2VybmVsIGNo
YW5nZXMgdGhhdCBjb3VsZCBpbXBhY3QgdGhlDQo+PiB0aHJlYXQgbW9kZWwgYXJvdW5kIHN5c3Rl
bSBrZXJuZWwga2V5cyBpcyB0byBhZGQgYWRkaXRpb25hbCBLY29uZmlnIG9wdGlvbnMuDQo+PiBB
cyBrZXJuZWwgZGV2ZWxvcGVycywgaXQgaXMgY2hhbGxlbmdpbmcgdG8gYm90aCBhZGQgYW5kIGtl
ZXAgdHJhY2sgb2YgYWxsIHRoZQ0KPj4gS2NvbmZpZyBvcHRpb25zIGFyb3VuZCBzZWN1cml0eSBm
ZWF0dXJlcyB0aGF0IG1heSBsaW1pdCBvciByZXN0cmljdA0KPj4gc3lzdGVtIGtleSB1c2FnZS4g
IEl0IGlzIGFsc28gZGlmZmljdWx0IGZvciBhIGdlbmVyYWwgcHVycG9zZSBkaXN0cm8gdG8gdGFr
ZQ0KPj4gYWR2YW50YWdlIG9mIHNvbWUgb2YgdGhlc2UgZmVhdHVyZXMsIHNpbmNlIGl0IG1heSBw
cmV2ZW50IHNvbWUgdXNlcnMgZnJvbQ0KPj4gZXhlY3V0aW5nIHRoZWlyIHdvcmtsb2FkLg0KPj4g
DQo+PiBJdCBpcyB0aGUgYXV0aG9yJ3MgYmVsaWVmIHRoYXQgaXQgaXMgYmV0dGVyIGxlZnQgdXAg
dG8gdGhlIGVuZC11c2VyIG9uIGhvdw0KPj4ga2VybmVsIGtleXMgc2hvdWxkIGJlIHVzZWQgd2l0
aGluIHRoZWlyIHN5c3RlbS4NCj4+IA0KPj4gVGhyb3VnaG91dCB0aGUgTGludXgga2VybmVsLCBr
ZXkgdXNhZ2UgaXMgdHJhY2tlZCB3aGVuIGRvaW5nIHNpZ25hdHVyZQ0KPj4gdmVyaWZpY2F0aW9u
IHdpdGgga2V5cyBjb250YWluZWQgd2l0aGluIG9uZSBvZiB0aGUgc3lzdGVtIGtleXJpbmdzOyAg
aG93ZXZlciwNCj4+IHRoZXJlIGlzbid0IGEgd2F5IGZvciB0aGUgZW5kLXVzZXIgdG8gZW5mb3Jj
ZSB0aGlzIHVzYWdlLiAgVGhpcyBzZXJpZXMgZ2l2ZXMgdGhlDQo+PiBlbmQtdXNlciB0aGUgYWJp
bGl0eSB0byBjb25maWd1cmUga2V5IHVzYWdlIGJhc2VkIG9uIHRoZWlyIHRocmVhdCBtb2RlbC4N
Cj4+IEhhdmluZyB0aGUgYWJpbGl0eSB0byBlbmZvcmNlIGtleSB1c2FnZSBhbHNvIGltcHJvdmVz
IHNlY3VyaXR5IGJ5IHJlZHVjaW5nIHRoZQ0KPj4gYXR0YWNrIHN1cmZhY2Ugc2hvdWxkIGEgc3lz
dGVtIGtleSBiZSBjb21wcm9taXNlZC4gSXQgYWxsb3dzIG5ldyBmZWF0dXJlcyB0byBiZQ0KPj4g
YWRkZWQgd2l0aG91dCB0aGUgbmVlZCBmb3IgYWRkaXRpb25hbCBLY29uZmlnIG9wdGlvbnMgZm9y
IGZlYXIgb2YgY2hhbmdpbmcgdGhlDQo+PiBlbmQtdXNlcidzIHRocmVhdCBtb2RlbC4gSXQgYWxz
byBhbGxvd3MgYSBkaXN0cm8gdG8gYnVpbGQgYSBrZXJuZWwgdGhhdCBzdWl0cw0KPj4gdmFyaW91
cyBlbmQtdXNlcidzIG5lZWRzIHdpdGhvdXQgcmVzb3J0aW5nIHRvIHNlbGVjdGluZyBLY29uZmln
IG9wdGlvbnMgd2l0aA0KPj4gdGhlIGxlYXN0IHJlc3RyaWN0aXZlIHNlY3VyaXR5IG9wdGlvbnMu
DQo+IA0KPiBUaGUgbW90aXZhdGlvbiBmb3IgdGhpcyBwYXRjaCBzZXQgaXMgY29udmluY2luZyBh
bmQgYWRkcmVzc2VzIGxpbWl0aW5nIHRoZSB1c2FnZQ0KPiBvZiBrZXlzIGxvYWRlZCBkaXJlY3Rs
eSBvciBpbmRpcmVjdGx5IG9udG8gdGhlIHN5c3RlbSB0cnVzdGVkIGtleXJpbmdzIC0gDQo+IC5i
dWlsdGluLCAubWFjaGluZSwgYW5kIC5zZWNvbmRhcnlfdHJ1c3RlZF9rZXlzIGtleXJpbmdzLiAg
UHJlLWxvYWRpbmcgdGhlIGJ1aWxkDQo+IHRpbWUgZXBoZW1lcmFsIGtlcm5lbCBtb2R1bGUgc2ln
bmluZyBrZXkgaXMgYSBuaWNlIGltcHJvdmVtZW50IGZyb20gdGhlIHByZXZpb3VzDQo+IHZlcnNp
b25zLiAgDQoNCkFwb2xvZ2llcyBmb3IgdGhlIGRlbGF5ZWQgcmVzcG9uc2UgYW5kIHRoYW5rcyBm
b3IgeW91ciBmZWVkYmFjayBvbiB0aGlzIA0KYW5kIHRoZSBvdGhlciBwYXRjaGVzIHlvdSByZXZp
ZXdlZCBpbiB0aGUgc2VyaWVzLg0KDQo+IE15IG1haW4gY29uY2VybiBpcyBub3Qgd2l0aCBDbGF2
aXMgcGVyLXNlLCBidXQgdGhhdCB0aGUgTFNNDQo+IGluZnJhc3RydWN0dXJlIGFsbG93cyBjb25m
aWd1cmluZyBhbGwgdGhlIExTTXMsIGJ1dCBlbmFibGluZyBhdCBidWlsZCB0aW1lIGFuZA0KPiBt
b2RpZnlpbmcgYXQgcnVudGltZSBhIHN1YnNldCBvZiB0aGVtLiAgV2l0aG91dCBDbGF2aXMgZW5h
YmxlZCwgbm90aGluZyBjaGFuZ2VzDQo+IC0gYW55IGtleSBvbiB0aGUgc3lzdGVtIHRydXN0ZWQg
a2V5cmluZ3MgcmVtYWlucyB1c2FibGUgZm9yIGFueSBwdXJwb3NlLiAgV2l0aA0KPiB0aGUgY3Vy
cmVudCBMU00gZGVzaWduLCB0aGUgZW5kIHVzZXIgc2VjdXJpdHkgdGhyZWF0IG1vZGVsIGNhbm5v
dCBiZSBndWFyYW50ZWVkLg0KDQpJIHdlbnQgaW4gdGhlIGRpcmVjdGlvbiBvZiBjcmVhdGluZyBh
IG5ldyBMU00gYmFzZWQgb24gdGhpcyBkaXNjdXNzaW9uIFsxXS4gIA0KSSB3YXMgaG9waW5nIHRv
IGdldCBzb21lIGZlZWRiYWNrIGZyb20gUGF1bCwgc2luY2UgSSBiZWxpZXZlIEkgaGF2ZSANCmFk
ZHJlc3NlZCB0aGUgZ3VpZGVsaW5lcyBmb3IgYSBuZXcgTFNNLiAgQ3VycmVudGx5LCB0aGUgQ2xh
dmlzIExTTSBvbmx5IA0KYWRkcyBhIHNpbmdsZSBMU00gaG9vay4gIFRvIGFkZHJlc3MgeW91ciBj
b25jZXJuLCBtYXliZSBDbGF2aXMgc2hvdWxkbid0IA0KYmUgYSBMU00/ICBQb3NzaWJseSBpdCBj
b3VsZCBsaXZlIGluIHRoZSBrZXlyaW5nIGNvZGUgb24gaXRzIG93bi4NCg0KMS4gaHR0cHM6Ly9s
a21sLm9yZy9sa21sLzIwMjMvMTAvNS8zMTINCg0K

