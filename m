Return-Path: <linux-efi+bounces-2013-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 512549AD4BC
	for <lists+linux-efi@lfdr.de>; Wed, 23 Oct 2024 21:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7208F1C2276F
	for <lists+linux-efi@lfdr.de>; Wed, 23 Oct 2024 19:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FD81D4177;
	Wed, 23 Oct 2024 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W/8V/48n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vIq8F2xy"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABA81AD3F6;
	Wed, 23 Oct 2024 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729711578; cv=fail; b=rn/mIYKNGmlcIYOi+5djSS7EulMLEPeC56LH8c4UewT5GfGyy651rZ4olEl1yPK14nwbPbwnmCclIWpbRvNniZRYb89N5G+vgxsU1a5Javx/Z8op8HIWrH2dTixGWrmODvzM6k/nzh0hOTR+SEzYn40rAlFUL6ndiSlgvzUx01c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729711578; c=relaxed/simple;
	bh=uBPUKggpKm0625+L0Z7czFzYQZt4OJ1AkY92TrkQmsY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MlmBL3LyexJnONRbv2u2ZVdbNWp/5swhJGGUi9Fs3VfJpw+MrHrV+RjJTuL9/JW/XnhmkO2pvgvFoGO+11KwBVbtBMbLc1WfU6IsLqIvtTDxnbtE3u42EoJqxgX8OYFmS5pp5YI6wHjDAzPZ9DoBMmNdnMPyq/lZIxFJsIma3Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W/8V/48n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vIq8F2xy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfdog012074;
	Wed, 23 Oct 2024 19:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=uBPUKggpKm0625+L0Z7czFzYQZt4OJ1AkY92TrkQmsY=; b=
	W/8V/48nzTq4Nrxyhh5hunPBqilZSxwCnj+INGSqiy3ugorWKbd42KWoMyvaROfm
	Fq1R74fi2RMbgMxrT5ZUbZLpXg4VObi0ydbdA/lW7qlhY+UYoQxstDSgiM97Awzr
	RVYzMxent/gDMrn0Gq1C87wa9uy7MDKcuzfjWFu4aokFcRKzi2cEID8ouHiY7ob6
	ZGcbWMABwm/Dek0KO5c6MULhU0BsR6EGbE/SJhDzcUg3zU/lBgsuFFFNySHViIR5
	8N2rYf8jANr4hRgZWVgl9HvVvOh/21zfAkRpUE8hgUjk6v8Y5QH3gXiKk4JxU0dy
	rH71QPRCgcMxEiELc9MSBg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53urybx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 19:25:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NJG2Eo018490;
	Wed, 23 Oct 2024 19:25:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhjyw6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 19:25:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CR2ozpwMINZ9sPsJIOoJeT4UyquubrVw6+4ve4Mgwy1KX7mIwYPa7qbiQAdH9pZRR64dr9zBtkolEfTfP/JaCGs9Tb8dgnLCKw5/zj9HEFYdCYT7p87wLZc4sKt0wl6sSTC/P/L3vznXNjCA970JXsQ2nuOy/zL5rFJqtfCPqJjrO2ix4EbtTzxwRuKTlLFgmbHr5XQGyUi+LptpUy/uFmir/em5iGhwpLZYawFZbgdbIMOwl6hWZ+ajpJlmqRH6rGHGdwg8Lc3PBqigJFFd4QeB3ANkpFXgN27tW+0hESrfnHDpb4R4yselktzGMDb5oLVNf9W7/x8JZkAGbEQx6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBPUKggpKm0625+L0Z7czFzYQZt4OJ1AkY92TrkQmsY=;
 b=AeTn4m+9OJ/k0a6375UjBu6NmkIVFtftJ9ZZStCgq2rT48jU9dL9Mb8DM1BtfKf7RPxgCfrgl+eTs9MlOF+Hr4dKo4JDs15hvblNlhGpSpiVoBLvK3trxvh8o+3SII0RKAd/MFoiPq0ku3fKCPhHbKlAxStlLeQqC994CteJoelW7OegB6rrOqqPePjgXL0JmIs1ogbD+KXW7UrNowf7oV48J0qAgq+IUWAWMPNx88Sl8WACdWKKLE430Bv56EF/prDpt6E0E4S2p+v3gc/X0+ER41LTqK50r+HTrQ4kpetL9NUkUSkzFfVA02ZzjXd7NhbtLjAAocFXjGMP9tKBug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBPUKggpKm0625+L0Z7czFzYQZt4OJ1AkY92TrkQmsY=;
 b=vIq8F2xyg5HuAh1BZUo53lixH3JzGmtYFq+sILN7lzOJMPmDqqiZrpNdm/HxdkclfyUn0d7VYo4TMYij7UKfcaExBNuJS5nXtUR0r/VuyPm7uiLTs6WpS9/l2XHmgtFULUmyNYig8x32PlG13Dyy6xWRQzVb7h+b64th3drfDog=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by PH7PR10MB7087.namprd10.prod.outlook.com (2603:10b6:510:27f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 19:25:22 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8048.017; Wed, 23 Oct 2024
 19:25:22 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: "sergeh@kernel.org" <sergeh@kernel.org>
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
        Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu
	<roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        Stefan Berger
	<stefanb@linux.ibm.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        Randy
 Dunlap <rdunlap@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [RFC PATCH v3 08/13] clavis: Introduce new LSM called clavis
Thread-Topic: [RFC PATCH v3 08/13] clavis: Introduce new LSM called clavis
Thread-Index: AQHbIK0RMggp9a3W+USqBJd5xzNEfbKTpG0AgAEcxQA=
Date: Wed, 23 Oct 2024 19:25:21 +0000
Message-ID: <F911D28D-F8EC-4773-8143-2B4E207DA202@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <20241017155516.2582369-9-eric.snowberg@oracle.com> <ZxhetCy5RE1k4_Jk@lei>
In-Reply-To: <ZxhetCy5RE1k4_Jk@lei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|PH7PR10MB7087:EE_
x-ms-office365-filtering-correlation-id: f5e35f1f-b16d-4012-2612-08dcf3987004
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OXI3TmlUUmxIS0NKZ2ZOdXUyZHAyRC9QUG9aMkF1bHFFdjcvVVBUL1ZpR0lK?=
 =?utf-8?B?RDhnMHZjMlg0akNNUWl4SVBnay9tZ3FNTmI2STVsd20rZmNwUW14eVRxWkYy?=
 =?utf-8?B?L0tkcTFlSlJCMEVMSUY2V0JYZytOYTFYSFhEYThMUXBKejF3T21Qd1pYSDVW?=
 =?utf-8?B?TDBPL2duNUJGWnl3YnRxQmdDb0FRS0RZNVBCUmxRRGlvc0hPblJwTHhIM3BF?=
 =?utf-8?B?WGRWWDVYeDdSd0haNkJ3M1lUcGM3WVFPQm1oZ2NaN09uTm12MnVCQmZUZUQ3?=
 =?utf-8?B?SEl3dnY4czJyS0pOSTArT201RDZQbEExYnM5a2FBb0lmYjJNd3lyRkFKZ1Er?=
 =?utf-8?B?RHMxQjAwM0p5SkZ2VzcwOTIwOTNuUlFGRldNazVzWjNqeWd6dDhCVTNhalI5?=
 =?utf-8?B?UVpjK1hTaVJHRkVtZ3htU1V0blQzTXhoeXk4UU9ta01NS0p0OUxVU1Npd3Nu?=
 =?utf-8?B?TUVyL1lOVjYwd1NSZmdRNGZEdFhXZ0RWeml1Q0xBREo3TVFPZ3lYQlY1SFZn?=
 =?utf-8?B?QmJQR09pUUtRRHJtS0daQVJFOEhBQmZ3bGNmZ1p5NHBRYU8xTkZDUW5XSEpv?=
 =?utf-8?B?V3V3LzBpaGpyeEgxT2M2R0IvZ1EzMGtyNUpHaTlXVEdqdGpJTWZOM0grMUVH?=
 =?utf-8?B?ZC9oWExvbDF5NnVKMHFTcmRpU2ZCNmo2blJlaVZWYkVRQzRUTEFVbGFjanY5?=
 =?utf-8?B?L1NzdERQOFJrRkJrMU9MRXloaU5BdHNJQnhxR2FmZkY4U09VcXZyYmg3MTkw?=
 =?utf-8?B?OXl6Mksrc2pxZ3pENUxsN3AyUmMvaVp3L3VpbzRPeTZtTVJRRkNtc3pVMW5J?=
 =?utf-8?B?L3kxVm5BVjVwSTJsSDBzNEd2YkY0VGVEVFcwdjU3Z01UWnZzc1pKQUhXNDdk?=
 =?utf-8?B?Vkh5aWNaeEp5ckM1Qk8rWFJhZVNreFBseUVaZW9DTXJReWNBY2dNMlJ4QzRx?=
 =?utf-8?B?c0tpb0VMK3FvcnI3ZU40VjYyS3JJVG9sR1VCWDlpeWpIRnB4VnplSFFUZjZ1?=
 =?utf-8?B?cEwyWU9zR2J5YlhyMFlRMFBjTDhYbEhESDZ1N0lYQlJzaHdIbENVMk1SNWpB?=
 =?utf-8?B?eHJkbzIwVHRkSDJ5cjgrNVo5SUR1MDJTU1gyUFQvTjdZZzNvMTZjdUNEbmcy?=
 =?utf-8?B?MTZEUWJ6RFhTNU5NV2VLeDZiL1RtbVJseHlSaDhNeGJlcG9IM2NIcUpQU25i?=
 =?utf-8?B?S3VnZmhIN2RGb3RtNjZHK3FqOWdzcmRzSEZhTmNHaHZCUGdqYUc1NEFGamhq?=
 =?utf-8?B?b2EyWWlxanhma0xyN0NTbjl6c0w4MWw0YXNDZHFJSzVlVFp4UjRodkhGMWtr?=
 =?utf-8?B?ZU1DdjhKK1liUklyYWdBVFJrNzV0cG9qVWpKa2ptVHFuQjA1QWFzandFSWl2?=
 =?utf-8?B?TmJQTU1POWdWaklDWm80eEs5T2pTd0lMNlpNSWovNXpGaFNaU0gyZllZTmd5?=
 =?utf-8?B?YlFLQ1RqWEo0cTYxcjdIY1F4M2dXb3hwSGFFVWp5QVJERWhsZUdKTWMzYUJY?=
 =?utf-8?B?TlFLbEZQWnAxS01EN0Uxd0RHNkRkODRzM2tGb2REaU9ETWtQYTEwTjRtTW1q?=
 =?utf-8?B?TDZlQ1AyeVU3eGpUd01kSXEzd29aSGpQcnI3VW9FNCt5ZE53SmRvbUN5dlRM?=
 =?utf-8?B?Um9FeWtYK29XTUpFMEZJMStraEhjNDcyem5Jb0ZUZFJiWE95STVGdkdoYW1o?=
 =?utf-8?B?WGlYUXZEV24xb205WTFwSGRpN3FERnlVa1FjM0toUlFad0FhcTZVTSsrRUwz?=
 =?utf-8?B?TGl2SEp2S2pOZFkxZkpUU0NuN093Vkd4T2w2OUtmcDEzdXFWQWFQR05oTDVu?=
 =?utf-8?Q?KJKrXU7Ca7gE46tKEgo3rLa+4vTS2OIPvSBPw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vm1vRTZsQmUzblBZQnZHanNic09ucXhrbkE1OE1kM0lZZE1sRjNHaHJwRlg5?=
 =?utf-8?B?UThUQUFpL3BJZndZWTc1c2JwSFFiS2M0UHlMQ2xqUFpwWXVlT1ZWUlBWU0oy?=
 =?utf-8?B?MTVFeE4xQU85dkkrZEw3bDZTTlVnQ0VBbUI2VjRWNGlhK21tQ29tYk05Nm1l?=
 =?utf-8?B?Rzk2Z2FWcHh5UXVhZnl6RVZYQjNxMEtUanUzUGxkOFhrMDcrb1VvQVNaM3F3?=
 =?utf-8?B?N3Q0bHNIQ3FKbGpNWXBObW4wbkg1SnVzMkNqZk1QbGtwcnF1Tkd5UzMrN0g0?=
 =?utf-8?B?UGRIYTB3VlpldVFpWkJsV1E5bVQxVXFoSW5nNkRDdnAxYkdUdDNxdmJncFFO?=
 =?utf-8?B?QkJEUVdNK1NwQURPa1BENUpVbWxVa2xEUWV0R1pqL09ZN0Q1OHZtMTFnOWdD?=
 =?utf-8?B?bUpOc2E4Y0M0ZlRpSzVzd0hvcFVuUGJZVFdrZFVLczVHajB6aFN4ekdaTDJV?=
 =?utf-8?B?ZmorLzVBcldqcm9leFAyck1aYjNoVUR4VFNjYW13RXFNbEhsWW1YeC9XZEhi?=
 =?utf-8?B?MWFTKzZMTEk4RjJVSWY2dnJHbFVuYVFtSWtUdlVsVzQrdzBQK2F3Z2F2aSth?=
 =?utf-8?B?dW9IdDNoMmlHbmhGZkJoRmplUEt3eHlJQlN3Und4SElMcmJpZXpFUkQ1ZDdp?=
 =?utf-8?B?dFJlWS9LTHpTcHZPYThIQ0pBc1p5SzBJZlZYRjlTMXQ2aWJxMXE3c0tpVDBG?=
 =?utf-8?B?ZnNnUk9JVVpIeHF6YXZnUS9GSzB3ejcwNkVGelBXbzl0TllCZWlzZWVmRk14?=
 =?utf-8?B?SCt1Y1h6TVR3clVKY1dxT1o3NjdBOWplbzlkU3B1bW81QVBVM2RzTUJHaHhp?=
 =?utf-8?B?OXcydzQvOVFqZjB5VC91eGV3QlJiU2hGU1JMQnQ0bmFGa2pHSjVlcnJ2T25p?=
 =?utf-8?B?S3lzVGY5TU1YcDFkN1drQXNUaHJVSGhlbGNjZmZBREVBM3VxdW1YNm9zMisy?=
 =?utf-8?B?dzhWZlUvTDBuVXJzNCtjbSs5WVNpemlKVDUyejd0c2x5MDVTU0RSQTU0UFB1?=
 =?utf-8?B?TC84TzkrajhJdWk4MlJzNEFWTUpPTDRnTlRneGp4NXJCMWR3OUEwWFYyeDJv?=
 =?utf-8?B?NFJ2ZkU1dW1LTFFyNGo0aytrR29zZkUySXA2bUE0bnJnT0lDV2szQlc4NFBF?=
 =?utf-8?B?UmttR3hmY0MvZzJWMlVrblo3NXNybS9peHlXaHJBZVFoeFJtTmx2ck42WDNy?=
 =?utf-8?B?ekdVNDcxa3lXSXFNUTJ4QjViRG1FTG1USUpBZ09wYmtTc1dxTElxK1BIYW4y?=
 =?utf-8?B?dHZUSVBrMlNzN0g1R2ozNjBKUHl6bkViSUJtM3N4RjV3ajMzVTVLSXczYjgw?=
 =?utf-8?B?TXNLVzlnYlIybktOZ1J6ZnRKSTUzMnM3VW5pN1ZxcmNubVdoL1NMTHN0a01m?=
 =?utf-8?B?TWMrOFlFK094SUZtU0FoaEpiV1YrSXd0S2R3M2JsUUFqNk5lQ0RwWjdhb3ZX?=
 =?utf-8?B?cGxlRy8xKzFtZGpxcmpYc1lld1ZoMjdJL2l4RU1LbEl6enI3ZWxETlJ0Tzdq?=
 =?utf-8?B?KzNyVEJjUTllcmtxd1lwVXo4R0x0K09KQ080M3Jmb2VyZ2NkVGtsMVVQemNW?=
 =?utf-8?B?NXMvOG4vY0wvYlhTelNjcVJ3Y0wwbUpLSVNhTkh0b0U2dlRzUlRTS00wRDJu?=
 =?utf-8?B?Y294L0tJeGNLQzg1ZlJWOGN4MGJSc2VsZ1Fha3Nud0tCUFhjb1J1bStBc3FL?=
 =?utf-8?B?NDBTZnpwSmcwM0J1QklCSDR3Sk93cUlNZ01wMlVqalEvZ1ppek1WazhHL1FX?=
 =?utf-8?B?UlVnajMzSTRvb3Fva0FvQ2dCbXhOeHhMbk5MOEcxb2dsRitOcXY2WmpNUGs0?=
 =?utf-8?B?RnNlbUt4MnFwSVBQTUdSNllUckpScUpxQnJ1ZDNrcllBZVZibWxlUmtjZGk5?=
 =?utf-8?B?d1JLTFRhcm5EaVRGNjJ2WDcxVzg4RzJGemEzNnVyVXNpRGZkMnlIMmpoSlRm?=
 =?utf-8?B?SUE2eWtuWmFDT0Q3MkZ0R1hVVjQ5ZkZ5djNzaUVwOC9IcmRGZkM2WG1LYlBu?=
 =?utf-8?B?RnRhUFg0Q01tY0gyM1gwT0pKanpRVG1oczNxYUhaeWZiZmR3NkovZFBDcmZH?=
 =?utf-8?B?SVk0WWR1NWRzT1F4cEsybHd2MHRyTFBDNmJsZU5xTEd3R3pSMGJEb1UyMTVZ?=
 =?utf-8?B?K1ZXVG5mdHJpR0JjQVBMMVZ6V1VqeXBNWXB5OVhWSVlYTzk0YjZjNW91VGhO?=
 =?utf-8?B?d0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C60A0C7A9AFBCA4AA41C4AABDCFBD5B2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MGB1KMX+W9zfrLOzvaGqqfa/MwpKxCtTjknnpixtqJcSPwGdyo7aupKmY1kj9QsA9JqOax4W2wqW1VQrpuhKDlYnQT+OejdJkwkOmevgLgGOxU4k1N76FT6alq5MliPxsRZQtyOI7lD1PA4z+bHomBxYAMmPU8urRThHdzsfCVK8rOoy7gw4slo4Hek7+3smEEvbSqcH4BU0778XoyRJmqE6O5V+OCdmCx1oDsaJsiNz3ekCxZNibtqdbTZhXfLoa8l1xL/VmzQBQ7CVEW5KIVFZI+0XRMDGsLag/TlYSwaeZd0S87mjpp0MLrrE2pZxsv2yLLsJdB3qsATjN4VCZPu61QdH3iIKhmu+lELr8WB79OpQprOdetM6dnAdpAoRj2XTlVevB9UYybJ5OvR//DxCl0nkAda4PS4V/S9Bzfv1ftS8EJtrmb7rxZXyw6nmM9U0y8+Ys9KSKJnT+KoqbciObrzPSEVl2vI60i3+AcxI+ojYSk8ba/h7nxyVupKYndbQn0liUgFHwPqbPhmf4j6G5lKY2wUkWoseqGQPZzps4+uI7RPENQ+meyznaf9HMWfRmytsZ0G+wkURLDcr5dcNRiRTIUtf5pkWjXlNrnQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e35f1f-b16d-4012-2612-08dcf3987004
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 19:25:21.9341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dKrALcyf8VuJR1xRbqOOZDs42WUpyn28zrZ757mw63GKiVqnFjgobJFE5iYkosz0FgbIMSITIqOYeaaLamNSmP88PnBB71iiJXDecz2fqxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7087
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_15,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230124
X-Proofpoint-GUID: JLMeRzHlYQrheG6LC2c2BErv2kKCMphR
X-Proofpoint-ORIG-GUID: JLMeRzHlYQrheG6LC2c2BErv2kKCMphR

DQoNCj4gT24gT2N0IDIyLCAyMDI0LCBhdCA4OjI14oCvUE0sIHNlcmdlaEBrZXJuZWwub3JnIHdy
b3RlOg0KPiANCj4gT24gVGh1LCBPY3QgMTcsIDIwMjQgYXQgMDk6NTU6MTFBTSAtMDYwMCwgRXJp
YyBTbm93YmVyZyB3cm90ZToNCj4+IA0KPj4gK1RoZSBDbGF2aXMgTFNNIGNvbnRhaW5zIGEgc3lz
dGVtIGtleXJpbmcgY2FsbCAuY2xhdmlzLiAgSXQgY29udGFpbnMgYSBzaW5nbGUNCj4gDQo+IHMv
Y2FsbC9jYWxsZWQvDQoNCkkgd2lsbCBjaGFuZ2UgdGhhdCwgdGhhbmtzLg0KDQo+PiArYXN5bW1l
dHJpYyBrZXkgdGhhdCBpcyB1c2VkIHRvIHZhbGlkYXRlIGFueXRoaW5nIGFkZGVkIHRvIGl0LiAg
VGhpcyBrZXkgY2FuDQo+PiArYmUgYWRkZWQgZHVyaW5nIGJvb3QgYW5kIG11c3QgYmUgYSBwcmVl
eGlzdGluZyBzeXN0ZW0ga2VybmVsIGtleS4gIElmIHRoZQ0KPj4gK2BgY2xhdmlzPWBgIGJvb3Qg
cGFyYW1ldGVyIGlzIG5vdCB1c2VkLCBhbnkgYXN5bW1ldHJpYyBrZXkgdGhlIHVzZXIgb3ducw0K
PiANCj4gV2hvIGlzICJ0aGUgdXNlciIsIGFuZCBwcmVjaXNlbHkgd2hhdCBkb2VzICJvd25zJyBt
ZWFuIGhlcmU/ICBJcyBpdCBqdXN0DQo+IHJlc3RhdGluZyB0aGF0IGl0IG11c3QgYmUgYSBrZXkg
YWxyZWFkeSBpbiBvbmUgb2YgdGhlIGJ1aWx0aW4gb3Igc2Vjb25kYXJ5DQo+IG9yIHBsYXRmb3Jt
IGtleXJpbmdzPw0KDQpJbiB0aGUgY2FzZSB3aGVyZSBDbGF2aXMgd2FzIG5vdCBwcm92aWRlZCBh
IGtleSBpZCBkdXJpbmcgYm9vdCwgcm9vdCBjYW4gDQphZGQgYSBzaW5nbGUgcHVibGljIGtleSB0
byB0aGUgLmNsYXZpcyBrZXlyaW5nIGFueXRpbWUgYWZ0ZXJ3YXJkcy4gIFRoaXMgDQprZXkgZG9l
cyBub3QgbmVlZCB0byBiZSBpbiBhbnkgb2YgdGhlIHN5c3RlbSBrZXlyaW5ncy4gIE9uY2UgdGhl
IGtleSBpcyANCmFkZGVkLCB0aGUgQ2xhdmlzIExTTSBpcyBlbmFibGVkLiBUaGUgcm9vdCB1c2Vy
IG11c3QgYWxzbyBvd24gdGhlIHByaXZhdGUgDQprZXksIHNpbmNlIHRoaXMgaXMgcmVxdWlyZWQg
dG8gZG8gdGhlIEFDTCBzaWduaW5nLiBJIHdpbGwgdHJ5IHRvIGNsYXJpZnkgdGhpcyBiZXR0ZXIg
DQppbiB0aGUgZG9jdW1lbnRhdGlvbi4gDQoNCkkgd291bGRuJ3QgZXhwZWN0IHRoaXMgdG8gYmUg
dGhlIHR5cGljYWwgd2F5IENsYXZpcyB3b3VsZCBiZSB1c2VkLiBJIHdvdWxkIA0KYWxzbyBiZSBp
bnRlcmVzdGVkIGluIGFueSBmZWVkYmFjayBpZiBlbmFibGluZyB0aGUgQ2xhdmlzIExTTSB0aGlz
IHdheSANCmZvbGxvd2luZyBib290IHNob3VsZCBiZSByZW1vdmVkLiAgSWYgdGhpcyB3ZXJlIHJl
bW92ZWQsIENsYXZpcyBjb3VsZCANCm9ubHkgYmUgZW5hYmxlZCB3aGVuIHVzaW5nIHRoZSBib290
IHBhcmFtZXRlci4NCg0KPiBBbmQgdGhpcyBpcyBkb25lIGJ5IHNpbXBseSBsb2FkaW5nIGl0IGlu
dG8gdGhlIGNsYXZpcyBrZXlyaW5nLCByaWdodD8NCg0KQ29ycmVjdC4NCg0K

