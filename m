Return-Path: <linux-efi+bounces-805-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 882C4878A10
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 22:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176971F21886
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 21:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A078456B89;
	Mon, 11 Mar 2024 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m5eNXqHA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FcBTtplG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AC656B63;
	Mon, 11 Mar 2024 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710192633; cv=fail; b=l8Wb0Lt+L6A5i7MGTpqzjGC9D2SpXrEZCJuB/kY7WThmO7q2oD9JhIWeIGoWF3EJYVTbaSls5yFfoUA0IZi/9vr0Vpln/Dt9BPOVsZ7WMSGnFxiGSC/7iGa7RPbUmIfSp7lBzGIVb1vldR4SnS5FTpx0NMuB1ZBuhLRy/3e90rI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710192633; c=relaxed/simple;
	bh=1oo85V7D0DR5LEpf1uC4Vx3vBWcJS0e5C2nV9yktZ/k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q1wB83xgksfaxTM/wBG1qM5+8eMIOx3DeywGQ/2hn7W5qHP8Yb05Ev8xG0zd97FyQxD0tvibPpzrsgcbZ8S0BN/o3skChUnhKroD2UIzZveSW4tQn+xg5bRxeI2ZY6q2rxgzbiVv/lI36No0S/7ia2dic7J6Og9VJIyqdZr6g8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m5eNXqHA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FcBTtplG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BLE00b024097;
	Mon, 11 Mar 2024 21:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=1oo85V7D0DR5LEpf1uC4Vx3vBWcJS0e5C2nV9yktZ/k=;
 b=m5eNXqHA9GVc81dbKhcRKwtpEr4NOeNiA5QfDWEDWCzgKQqgE1fHsN8a1AXQxKDS0lRN
 vO5i4djwjC/F3BQz5iZIyoXY0hAxFYArca3Cze4BKeIxw3RxmLsu9n/ZBrVx495vXIBF
 NniOQryIK7ZVNQDrP9mllkQGWIxozvj1N7eyyWvvwRTwZbH+5vt4Cvae4eRVACV7CACj
 3O0h8GJTxvd0dFRA7xYFxaes7/+3CZCZ6e0Yaa4xqorU8gvEJBjzh8MNi0GrcmRTBVeq
 Y4JaXXIVT8n4z5z4RfGJ0SjNEvhwnwBe6zA55ic5+tCJuyt4fHsFDIBEXtFM7ZA8uLpx EA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrfcucfex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 21:30:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42BKpKqi009100;
	Mon, 11 Mar 2024 21:30:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7cj8v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 21:30:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxviUEnLMrcSImKOxRdie/kzf5/uTkTuhSKO3s4+ID/Im5GU8vk/+bL4wmrB1WfuLnzL+iyk8S9UNa8Tu5eQDBu2JnUgGBdGPRUmgFQ1BYLIcLyrv2EicG8Rt6VkjpYiNb9gmbLA70k+QCYMjwx8hfobK/DVV2Ii1l/Wb/k0DZQlB5teVlXmIj41QU/HIEgi2WZUrJgTDjo6kLzgvXpJsQtjq7wjvj7ztMTtQgCnqHYnKlRy8/5Irpv7v0KMLONSA5dH/CbuNt0TAUxy8tLvhsCAgGecDEHhQHQgM3inhkiCjfEu26O328uEMxNZQK+NRwXTki/g1q4XOMzt/Oilcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oo85V7D0DR5LEpf1uC4Vx3vBWcJS0e5C2nV9yktZ/k=;
 b=WBNfhgITkHc0VxOeIWXjCcpc0fKJPnKsrMiqUZnQoM+A4W9aoQjtj2fbFlAAxzO7gX14qkEwAluP38mtJO4QyPj7kq4tx1ILVdKLSifNzsagAoXsSCs5rtIAaNeaAeekZDUocWhFVTVBmHv4//SHASR4f5Lm6Pv6VaiQQ6oFcnLHyP5kZCTmgam9GXS58xemYjw30+trC5zF6g41JnMuQ7S10Cts1uUrYqhzmOTHFWUN+c0lVYzln6vvKG3vJNLIsJbzjpHb3yjgd4hBeoIUd4wMbBWehxIGaPmX+db1jYCulVj5rO4o6BXMZ3TxC5K4ZlQObBMxG27yXLtHpMizpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oo85V7D0DR5LEpf1uC4Vx3vBWcJS0e5C2nV9yktZ/k=;
 b=FcBTtplGY2uwIGXHIMTcjISm9gboySc2isoY+mrzmawVlGbvP3fneIqKUodzZX6F8lpqTP9Br+Bh+Re4yuagLSKKufL77dJQ5CfxZhyE6BF8a6fAtAEpjMtIurQUMNLEtMvwLkM5RVE+wUIBPPo1Zno0F/1OTSRYqYWv18auj9k=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CO1PR10MB4771.namprd10.prod.outlook.com (2603:10b6:303:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 21:29:59 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 21:29:59 +0000
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
        open list <linux-kernel@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH RFC 1/8] certs: Introduce ability to link to a system key
Thread-Topic: [PATCH RFC 1/8] certs: Introduce ability to link to a system key
Thread-Index: AQHac8/Wy3kR1DBbWUSwLVt/DZ3pl7Ey6Z+AgAAlPQA=
Date: Mon, 11 Mar 2024 21:29:59 +0000
Message-ID: <2163E0AB-77B5-46EA-9987-6C9CC4937E0B@oracle.com>
References: <20240311161111.3268190-1-eric.snowberg@oracle.com>
 <20240311161111.3268190-2-eric.snowberg@oracle.com>
 <CZR5UBHJL9RC.1NA7Q0F10XSJF@kernel.org>
In-Reply-To: <CZR5UBHJL9RC.1NA7Q0F10XSJF@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|CO1PR10MB4771:EE_
x-ms-office365-filtering-correlation-id: a7531471-a1a1-4856-029d-08dc42126759
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zYA5DBW/SV0GiF6lGogqRfynVGmhJCJxR8i9vVniy8oLpYQEJgOVdwyEXgxP8DASDv/JG11QkCALbxYnYt7aqj0gbfxEMnHDV4n7APEZkJPnHYG5HZxGJRXpqteD2EwyfLmbSDcTyyemTRRifqkIaFI3EzayoS0+hgnVYi5Q7rkkC58EkMe3ZQHSOD0bs/pxWW6KShlZ0RMDJAK1OqCOeHZND4QnmCB3QuFcFalC2cxjczcPULzany9SAtx579cJuRAX1TCdW1BsnMugMP3XFmQFrow4cGHsm4M49OrzoJQubcKtShMsYiMeBkUuO9kzM4NSm85M/fSdREHCZz0ZJamShLBcByW1icjKHrpyd9Q4ZFO0FC9JeLBHijZwyFoJ/XHIvVssE5R/34hIb6mGkTXtTavurrxYa/vizqu9hpr2zIGAm8exhhtxG7azSG1eOGvO4bC+rZH2TeqEw0B2BxpNMMzgGmhs3mgC2OgjvYKlQhMJhZqLCeTUU4t/QF6Q5vsz0wWtRLJk2xyQEeKpMWMUJCGRwVM+tIzQv5Lp1LSFVPRUzYqhmEPSh6zr5fhJFiZxc/+YLXePSFZ5AbgI4jaS87pmOlSYlpGVdN6AT97yOnLyv8ywWy1RP0+d2nueyrpS+lkGutw2h8tZ/NCYD7XK6TjztWSzrdToH4zqduTUWqZE+gVNHaGskiaZ9o7bnVuhCEu+n5QdHt3SIjSqhVwremdDAgWOfpD+m5Ci1h4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?L2hNWWkwVUxERVZKLzZrSXQwa2tobGdWOUlnWVhycy8vcnJXclRrS3hyV2Fz?=
 =?utf-8?B?Q25YK0xHN3kvVVowK2pIZFVGSVVOWU5ISWk2NjFQYWJlNUhBM040MTF3NHdK?=
 =?utf-8?B?OG9NY21ISlcvTDA3V1BKaUtrQ1NVUEZaY3J3Tm5wNnd0VnlsS0hmbWg4NzQy?=
 =?utf-8?B?VTZsakFYTnJsK0dXM3JTOG9uWE0xcXZJTkhDR3dBY1pvZzlkWDE5UmdLUE5s?=
 =?utf-8?B?UGFac1RHdHkwbzN6OFNTK2g3ZWtOdjUvSTcvWU9EdFg4UzNvMFhxMjI1Mk9h?=
 =?utf-8?B?UlBsMEpQRUVvMGhHeDRvL1dYZTZlVU5rZnpRNTh1SmhMc2MwMnlzOGg4WEQ5?=
 =?utf-8?B?a2V6T1pMVlBjSFp4ZjFncTVialBxV3AxNzFnWGtnbXBqSlpsTTYwY3NEK0VB?=
 =?utf-8?B?bjFqdlBueEhxOU1td0d1bWJCNVdMZ1lSMTRzZG51YVpTOHNJVWZSR3h5THFW?=
 =?utf-8?B?MUF1RTNvZ1RoTm1zMlF6Y0hUYXRnMHlETXRxTkdNR09ZZm00UjJHNlhmdVVk?=
 =?utf-8?B?NDczakJqNWJ6Sjd1K1BEazB3UUxQWUt1WTYwNVQwdmhNQjVnUGFKTnowOXhj?=
 =?utf-8?B?ZWJNeExjQ0oxRDBWdTZUU3NlanFlTkx2YVl4WktGRWtRZlIveW0zWGpaNEg0?=
 =?utf-8?B?Sk9PZXlXN1hDdVcxTUxEQ2tIWjVCWE5QTzZIbXFWYTNUM1RSbXRtZmpCOHB2?=
 =?utf-8?B?cDNjdlFYdUhOL3ZNenpudTJtR2cxRFg1R3BBS3dJMzBrOTZWWTlJWlhPd25v?=
 =?utf-8?B?dXY1ZjhkVU1iZTB3U1NEWHNXWE0veVlRZ0lkZHUzSnFEOWlRWkY4bkZ5cGM4?=
 =?utf-8?B?ck5HQ0daK2dzWWdjREtvYXhEdUFxcWwwZGx5Vmp3a0poandqUWdTb1pPUXlH?=
 =?utf-8?B?RjBNOUpoUlUySjdRQWxzY3hWWCtpUTVVOFdQck91TlpzTnQyaWpMUVAySmlY?=
 =?utf-8?B?VW5sZTBXWktrQmRleXYwUkNQTC9nY0VZSk9ZTGJ1YXN6aHIrWEx5amdJQitn?=
 =?utf-8?B?NmEramJNdWpxZ0hIUkllT0pCSGhITy9CMEdZeThDRWlvV3NLYnF4MHFXbjFE?=
 =?utf-8?B?dU5MZkJQQWhTeEFibTI1MVNpSTlyYW1XQ0FzTVU2S1cza2JVU25pV3RjaVdV?=
 =?utf-8?B?WkR6b1RxczZKbi9Cc25EL1dzNk84RUdCSG1EaU5pZ3RoTlNQTHpKa3BzMFg2?=
 =?utf-8?B?TEVHbVdyWjc5bmtubVNxY0luRTZ3aXVvL2wzNzJPMkRpT25RTEd4OThueFZV?=
 =?utf-8?B?V2ljaDFZbStiSTF0UUxZcVhST2ZPVTZDbzgySHE5ZEhDRDhodEFDVkR3eldP?=
 =?utf-8?B?RUFMd1E5NXVYQ3dyOXFCd2hpakhJVnFHeFhLc0lQK3NSbkxkQzRxekcxenhU?=
 =?utf-8?B?eGY3TXJEbDBXWHI1M2p3YnFVWHBuNncweE5yQVM5eHhTMjVyclNVYWtKZkF6?=
 =?utf-8?B?ZWt5bW53cW56SloxanFMYTRHVzlxMmh0K0VXRkRkZ1Z4Q1poZ3M4dEdQYkd4?=
 =?utf-8?B?T1pSaVFOMjNVQXUwUFR4bXNqUm9XamxlVE1TLzd6TmUwYTY0eTZOZ050MTBH?=
 =?utf-8?B?ZEJXYmgxUTNjcGYreFl6TnBHRHNDUG9DY1kreU50Y3ZrZWgyTE4yZVVINDZs?=
 =?utf-8?B?YVpicUlFRnJ6RkQwcHlIQ2wwY00vdHNIVUpnQy9MRFgreGQ3djBIbWphNE83?=
 =?utf-8?B?VE9Xc1hKS0ljelBwY3pMbWw1OHRlM1R5cjZSZnpKU1lBMnM2TGh4TWVPcjR0?=
 =?utf-8?B?OEFZRFFpcXJJM3lXRzZtVVY0ZEZFdHZuRHJacE13WnhjdllZZ3k1QkFWM084?=
 =?utf-8?B?TmJwN2Rxbk9RSVl4TmU5OG54WmcwMVJqMXhQU1NLN2FhOEN2WXhSUUZORGh3?=
 =?utf-8?B?Vy9hQmdsWGNhSWFqaFl0Y2pKYWg4RGdBV09HTjU4NkxHZDEwQmRUUS8xalRB?=
 =?utf-8?B?alQvZWNCVzJuRGt0eWlhNVFqazB4K1BZTWJYYWxPTVd1RUd0emFQTStYUjhy?=
 =?utf-8?B?aTlhSTRDZWhqb2JQWXF2b2JxUmVwTjRvOUZUeVF5NndGaHl3Nk00QUxVWUN1?=
 =?utf-8?B?N3duaUVHTW01eFZTR0gxZGd1TVdtRStWSGMyeS9qYzJ5MVk3dU1pRUF5UTRP?=
 =?utf-8?B?VUhCK1BEV0NITXpwSjQzTWVRK0ZSbUpVMFdLRTNsTjJBaTB3ZXp2TzRVeUxI?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0848E653372E854D98EED4F223F7B000@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Kf9f3SKgKncecYe0biYM7ER9I+Vj8W/Ray4ubG+v3ZgZhQQQNnuXUHT62Rkv9CXOYvTKS4KboXQtbnH8r/nTYQ5NK+FNR2TW14jtl+8bYRSr4LdZQIU/gAGKeelir2H7WP/29/bmG+6JVQxrDuTBt/K+0lpj7BoGlD7ecfIxHaiUzoX15rJ61W57De8IS/LYQjG8Lbp5Nx8BIWKfHHNHj85DH7k6nWht5AUneDJ/P8E9F7ZFoq35FFwj2q8ZPUghnOU48EtGaeU/AMRLpTX9D2mlpTihFhKKXMaqCqXM4+UgcGbhMvQ6vBfsiGJoBA79jJcuMrHAFN1tNZ/Igi5uJdfLTORZtuzhEW2ICQNSpMiBiUTVA1eQ+17uToELmF51w1hn/r6ST/8tWhyJqdBmkTiKjcZxA9Jc9NahHBQxJVGNioiwi7U2LVUMckMvoLijrrYoZAzVgYPrFLy7fFgY+DYB9FjJyjvQABInFk/WVUCxM5kQj/JNBsVFJZwnX81r7mUgZESjR2eOZccfu0/z5V44E/F46Q5oR+vr/YFfpOvy6kLfhirqL1We6SIWwm5SQHowrPlTiTHLoSO/ZDPej2JYzviyM/ykDSPBkeqLgfE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7531471-a1a1-4856-029d-08dc42126759
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 21:29:59.0302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yefWYYOkovxAD8WhLNZ9hQeoTgq9Cca7hjFVPXSlbZi1o+P3jJTynz80asn4QooDiizD2TrqAoH0n6qlz6aUqKPOQasFdUR53f2LMluFgKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4771
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110166
X-Proofpoint-ORIG-GUID: 9cEj8ynIaxcECfjcJph9AU06kubQzFQy
X-Proofpoint-GUID: 9cEj8ynIaxcECfjcJph9AU06kubQzFQy

DQoNCj4gT24gTWFyIDExLCAyMDI0LCBhdCAxOjE24oCvUE0sIEphcmtrbyBTYWtraW5lbiA8amFy
a2tvQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gTW9uIE1hciAxMSwgMjAyNCBhdCA2OjEx
IFBNIEVFVCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+IEludHJvZHVjZSBhIG5ldyBmdW5jdGlv
biB0byBhbGxvdyBhIGtleXJpbmcgdG8gbGluayB0byBhIGtleSBjb250YWluZWQNCj4+IHdpdGhp
biBvbmUgb2YgdGhlIHN5c3RlbSBrZXlyaW5ncyAoYnVpbHRpbiwgc2Vjb25kYXJ5LCBvciBwbGF0
Zm9ybSkuDQo+PiBEZXBlbmRpbmcgb24gaG93IHRoZSBrZXJuZWwgaXMgYnVpbHQsIGlmIHRoZSBt
YWNoaW5lIGtleXJpbmcgaXMNCj4+IGF2YWlsYWJsZSwgaXQgd2lsbCBiZSBjaGVja2VkIGFzIHdl
bGwsIHNpbmNlIGl0IGlzIGxpbmtlZCB0byB0aGUgc2Vjb25kYXJ5DQo+PiBrZXlyaW5nLiBJZiB0
aGUgYXN5bW1ldHJpYyBrZXkgaWQgbWF0Y2hlcyBhIGtleSB3aXRoaW4gb25lIG9mIHRoZXNlDQo+
PiBzeXN0ZW0ga2V5cmluZ3MsIHRoZSBtYXRjaGluZyBrZXkgaXMgbGlua2VkIGludG8gdGhlIHBh
c3NlZCBpbg0KPj4ga2V5cmluZy4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogRXJpYyBTbm93YmVy
ZyA8ZXJpYy5zbm93YmVyZ0BvcmFjbGUuY29tPg0KPj4gLS0tDQo+PiBjZXJ0cy9zeXN0ZW1fa2V5
cmluZy5jICAgICAgICB8IDI5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiBpbmNs
dWRlL2tleXMvc3lzdGVtX2tleXJpbmcuaCB8ICA3ICsrKysrKy0NCj4+IDIgZmlsZXMgY2hhbmdl
ZCwgMzUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEv
Y2VydHMvc3lzdGVtX2tleXJpbmcuYyBiL2NlcnRzL3N5c3RlbV9rZXlyaW5nLmMNCj4+IGluZGV4
IDlkZTYxMGJmMWY0Yi4uYjY0N2JlNDlmNmUwIDEwMDY0NA0KPj4gLS0tIGEvY2VydHMvc3lzdGVt
X2tleXJpbmcuYw0KPj4gKysrIGIvY2VydHMvc3lzdGVtX2tleXJpbmcuYw0KPj4gQEAgLTQyNiwz
ICs0MjYsMzIgQEAgdm9pZCBfX2luaXQgc2V0X3BsYXRmb3JtX3RydXN0ZWRfa2V5cyhzdHJ1Y3Qg
a2V5ICprZXlyaW5nKQ0KPj4gcGxhdGZvcm1fdHJ1c3RlZF9rZXlzID0ga2V5cmluZzsNCj4+IH0N
Cj4+ICNlbmRpZg0KPj4gKw0KPj4gKy8qKg0KPj4gKyAqIHN5c3RlbV9rZXlfbGluayAtIExpbmsg
dG8gYSBzeXN0ZW0ga2V5DQo+PiArICogQGtleXJpbmc6IFRoZSBrZXlyaW5nIHRvIGxpbmsgaW50
bw0KPj4gKyAqIEBpZDogVGhlIGFzeW1tZXRyaWMga2V5IGlkIHRvIGxvb2sgZm9yIGluIHRoZSBz
eXN0ZW0ga2V5cmluZw0KPj4gKyAqLw0KPj4gK2ludCBzeXN0ZW1fa2V5X2xpbmsoc3RydWN0IGtl
eSAqa2V5cmluZywgc3RydWN0IGFzeW1tZXRyaWNfa2V5X2lkICppZCkNCj4+ICt7DQo+PiArIHN0
cnVjdCBrZXkgKnRrZXk7DQo+IA0KPiBJJ2Qgc3VnZ2VzdCB0byByZXBsYWNlIHRoaXMgd2l0aCBq
dXN0ICd0a2V5Jy4gU2luZ2xlIG9ic2N1cmUgY2hhcmFjdGVyDQo+IGRvZXMgbm90IGJyaW5nIGFu
eSByZWFkYWJpbGl0eSB2YWx1ZS4NCg0KSSBhc3N1bWUgeW91IG1lYW4gcmVwbGFjZSBpdCB3aXRo
ICJrZXkiPyAgSWYgc28sIHllcywgSSdsbCBjaGFuZ2UgdGhhdCBpbiB0aGUgbmV4dCByb3VuZC4N
Cg0KPj4gKw0KPj4gKyNpZmRlZiBDT05GSUdfU0VDT05EQVJZX1RSVVNURURfS0VZUklORw0KPj4g
KyB0a2V5ID0gZmluZF9hc3ltbWV0cmljX2tleShzZWNvbmRhcnlfdHJ1c3RlZF9rZXlzLCBpZCwg
TlVMTCwgTlVMTCwgZmFsc2UpOw0KPj4gKyNlbHNlDQo+PiArIHRrZXkgPSBmaW5kX2FzeW1tZXRy
aWNfa2V5KGJ1aWx0aW5fdHJ1c3RlZF9rZXlzLCBpZCwgTlVMTCwgTlVMTCwgZmFsc2UpOw0KPj4g
KyNlbmRpZg0KPiANCj4gSSdkIGhhdmUganVzdCBzaW5nbGUgY2FsbCBzaXRlIGhlcmUgYW5kIGlu
c2lkZSBpZmRlZi1zaGVuYW5pZ2FucyBpJ2QNCj4ganVzdCBzZXQgaGVscGVyICJrZXlyaW5nIiB0
byBwb2ludCB0byB0aGUgYXBwcm9wcmlhdGUga2V5cmluZy4NCg0KSSdsbCBhbHNvIG1ha2UgdGhp
cyBjaGFuZ2UNCg0KPj4gKyBpZiAoIUlTX0VSUih0a2V5KSkNCj4+ICsgZ290byBmb3VuZDsNCj4+
ICsNCj4+ICsgdGtleSA9IGZpbmRfYXN5bW1ldHJpY19rZXkocGxhdGZvcm1fdHJ1c3RlZF9rZXlz
LCBpZCwgTlVMTCwgTlVMTCwgZmFsc2UpOw0KPj4gKw0KPiANCj4gUGxlYXNlIHJlbW92ZSB0aGlz
IGVtcHR5IGxpbmUgYXMgdGhlIGNoZWNrIGJlbG93IGlzIGFzc29jaWF0ZWQgd2l0aCBpdC4NCg0K
YW5kIHJlbW92ZSB0aGUgZW1wdHkgbGluZS4gICAgVGhhbmtzLg0KDQo=

