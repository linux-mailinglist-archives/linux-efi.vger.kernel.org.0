Return-Path: <linux-efi+bounces-808-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC80878E5E
	for <lists+linux-efi@lfdr.de>; Tue, 12 Mar 2024 07:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83C91F22D18
	for <lists+linux-efi@lfdr.de>; Tue, 12 Mar 2024 06:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCC01EF12;
	Tue, 12 Mar 2024 06:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Nu6ePbg5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B234AEC8;
	Tue, 12 Mar 2024 06:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710223300; cv=fail; b=qkivq68SvTRgwaj9AQoOrfRYiTRKzXbF8UiuX+G600KcViOpwwkg2N+pbus64jdV4JQl5H0NuFLfILhhKT9Xa0QGc8s1ayJUG1fOQKoEG53H9pBvqLzlW16TyD13QIPrHncUyJEg6CcXT0pnYA5wFsl6uugC8t9fAAKBKrdx0kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710223300; c=relaxed/simple;
	bh=riKpPX2QeJHixLuAY1PK8Xikn2YbTpGY29yv893tRq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dV9IZ/LABpn8qpu6C6FP9SkkElyb6xV0+XJxMTS7AA5CiGRX3jN1kL306JgWg3ueXGmV+OrE39rjGFOwgkjvye0kNKhu3Pl0VX7j8kJhcI+5MVsPZktT3G7rHAHEszgYCODN5VP+HmK6OtRO6xLuwP9n56iN/PKyEIR89NcTwdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Nu6ePbg5; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42BIWdYb004951;
	Mon, 11 Mar 2024 23:00:43 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wt54n22q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 23:00:43 -0700 (PDT)
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 42C5u2M3021178;
	Mon, 11 Mar 2024 23:00:43 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wt54n22q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 23:00:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z189J0PsxrjilTf525KtrTfFaK2JsppgfouNardV2bpTsW4PadPyJM8JZaAmTpAmQXMGBRl/Qd0dHYYyt5DRUJntbsJkz+pAFBIlAdnn4SO5/YDX/qB2BPA2UnIs4dyVdf8TUimsb0srxw3llpZ5nCMP93ZRF2j5Fqp7Uac8VGz4XsJ8eAZ5bEFxf3CAp6FqK1ppEaFNAINhcpGWB6syJtlVj6vDKJajPsu0Q2X5I/1JqVdycVOnVxl5PTjBUsI5tULbL+lwWa62TyJ/P8Kz+v/6CS3gOgHCRibT2+38OwhDzgKQaa+4VQYACMmZEsBWDo/9Fq3hl12u3XM+x0zG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3J1egQyqh+N13C/UpntpnTzOMbfIbd19T46uP5Apbo=;
 b=Oq9wExr4nFAleqYLs44uPqO+9a1PaD4Wm29Ucyv9I/5gjyaTTkh9UN2rI/ozOUEhwAZeqhsGcX/6CXLsJWneAzczx44hF+/2W1iNv+R+lFfabyFty6YCj7dGPfY5lLoonYSzHc4smLw7to0UDpR9w8WifKjtxr3s7uHZi/EjtleJTEWnQ1Qc6uLFKQtZQRcrpmSq5WSPyTg1ew9Do1so/D9OJZJg/y/oRKYfWVSyKL/Tee/I1ocJeeecW82ACPfT7dFvO0XmAG/QGJNggWWUSBWgWcNGSsbtjXflGUv20zTxvPSkyp5I1anpjwi492hZhRNSvI2PAmRzDkNpSTtKVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3J1egQyqh+N13C/UpntpnTzOMbfIbd19T46uP5Apbo=;
 b=Nu6ePbg5miuHaxFPbJCt995JET5BDUcu8l2tjm9xJ9mPps7m2G8EyRUYjwWoLHaxz19fP15Pcc5A7pK20tSCihAQUhFsGTj2xJGeeGiC5Ae7aTPhVYPWPpAQnx06Q3TpzWaDP8KZXGgmveQlXfHMLqHY8Yj4iimqEECeVL41F5A=
Received: from SN7PR18MB5314.namprd18.prod.outlook.com (2603:10b6:806:2ef::8)
 by SJ0PR18MB3897.namprd18.prod.outlook.com (2603:10b6:a03:2e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 06:00:40 +0000
Received: from SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::926a:6eb8:6d4b:656a]) by SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::926a:6eb8:6d4b:656a%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 06:00:39 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Eric Snowberg <eric.snowberg@oracle.com>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>
CC: "dhowells@redhat.com" <dhowells@redhat.com>,
        "dwmw2@infradead.org"
	<dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org"
	<jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "roberto.sassu@huawei.com"
	<roberto.sassu@huawei.com>,
        "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>,
        "mic@digikod.net" <mic@digikod.net>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        "stefanb@linux.ibm.com"
	<stefanb@linux.ibm.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "keyrings@vger.kernel.org"
	<keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>,
        "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>,
        "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH RFC 1/8] certs: Introduce ability to link to a
 system key
Thread-Topic: [EXTERNAL] [PATCH RFC 1/8] certs: Introduce ability to link to a
 system key
Thread-Index: AQHac9CFMcx0ZAmc50GyYG9txBMctrEznUOQ
Date: Tue, 12 Mar 2024 06:00:39 +0000
Message-ID: 
 <SN7PR18MB5314CEAF1CEDC95B2C874696E32B2@SN7PR18MB5314.namprd18.prod.outlook.com>
References: <20240311161111.3268190-1-eric.snowberg@oracle.com>
 <20240311161111.3268190-2-eric.snowberg@oracle.com>
In-Reply-To: <20240311161111.3268190-2-eric.snowberg@oracle.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR18MB5314:EE_|SJ0PR18MB3897:EE_
x-ms-office365-filtering-correlation-id: 52229d1a-11ee-457b-08aa-08dc4259beb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ZGXAy3vyiCA+Ff5K+2ayApX7RbO16xPcJ1UcAF6A/HHEIOwBkcwiO1kGMkkgptiu5Bc5ZwmkgM68UwbTBDocs57QxTtWbtDCPyP2HocgGoTZVMVXTG2EIyLM+c4cQql96YuRGsaEeErGcbSfdLrsV0sz+AbBd2bXGY8bwYJmpuWm14MoEtPpWl3PF0kB3qsivs6fx4ixncHr5AScC+SdufKPjggcUnE8zCv6wPUHQsg+oNmCjz6tYe/oGUdXl3CZG6BcL88frk1jGC91ZJ83+n3QJahj4/Iq4Y9vBJVOQsHKwZJ7NQGmD8rIiiJMXWyR7fiFHyijjT5GzEu1RmLG8xK26WbMC3hgf70dDoHK53nQf+kgaCVW9RjmTDc2yAv4tigZyJFEr992AQlAyCcBlpPYexpXVu561jE+kNU+I9cki3YjqU9NA43guGevsfOpJXNWHzfDZUL1kpakM6Hgbcj3Phqnn6L5KYacin3R7MjENCntxwrdiuA/OarHnK+xX5MDxFlGXPWThNx7cAqrpeOjMzHcG20HZAe+K9g21xpL99KzqX7VRaoUGMp6tnrcIId464gJca7rIrr6JBlJz7ek/1lboDGFU1D6HeXMbQZOWtocIGOIFRGkjttUGzyz0N3UglBPeOBOLbqgBAjyWeVIKMMOrNAaWYQKbcO6vMA4DKiW/75aUi2U8pShBHCNWwOgY9lYqZoU7rb2JQQXtpe/Ss8wjEhvRjjCf5VO0R0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR18MB5314.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?vvwAmjHJIU9jPOtUcME4M+nVVuKEbL9C9uXmxm05GE4RIghACxP5OxMW9F0n?=
 =?us-ascii?Q?5RpwShaBJE+8YX8GYouKkdntLdTM+svZLVp42FwngUHTB7v6htzpI+XrnN26?=
 =?us-ascii?Q?SDHW/dxUJg3bMJy7w6PV5bRkPhxqyLPwDPE2YRKvmIoKHs8kgSyYHRQMisE+?=
 =?us-ascii?Q?A4F08KT2oiNGo2nLVY4M3Ceno9QMfs20NTyYLz1dpXk4mQhI23z2SX2rgGj8?=
 =?us-ascii?Q?FO6pTrbk8gDGEEGxEJCzY14nkY5sJWFZ/yTI2gXrNmtJXsT+orCCTs28k9jF?=
 =?us-ascii?Q?ZjU2EMzgVI72HSufsZ1ac7lyg2Dy3IiD8/7RUFVKtHCUuVEwFzbBy/RTUMyq?=
 =?us-ascii?Q?qk5asNFDuJjn5LvHKVEzGLIpzbbTtrJOeP0Zgm562NJQBQVMO/lM+4v4n0PZ?=
 =?us-ascii?Q?NA0KZBeVT0ilTUiS8DnJ8NKxbkx+JbDpMsH9YJDnbE6/vb8YUl1jnc21X+u/?=
 =?us-ascii?Q?5RDkabMKx7IaxZajDiryHID/fuli3lIr/J1KInLciP9GvCBPTMjU541sDV5W?=
 =?us-ascii?Q?Fr5FD09xTNzH0E0iy9r/q99Aq4FDgQABr8uMJ9Y9fSLEO36X7rmWtDN3lMQF?=
 =?us-ascii?Q?E4s6rFtcCohrbc8WnNFT7zKtXAKnbLLvHaWV4Vmo1ZGAwD8SdFgvozrQI0Uc?=
 =?us-ascii?Q?DiXLEcFnzvSv4CNBlxsf7QrPV25VpFOzOcV0Q/GwzpVIcOttU1/ht3/lGe9c?=
 =?us-ascii?Q?Wk6JTv22W/HHsSEw6H9xcs76ciWMJdqRYAUJ5U6aupjohBbnkPphGgN1qywh?=
 =?us-ascii?Q?OfWnvYEUGc5WBKeltHyss7g5CKgWdDCS+YpwiOKMBLAFgEOmv+ThfoHpsgqP?=
 =?us-ascii?Q?AjGiI+x2W+wZ7Fc4EqKRVL70f1JBRtGHDlH1i2KXVuhibCq8deVdmIFNEu3f?=
 =?us-ascii?Q?oCP/kE1v3xfzcajHgP9th0o1span65CYL2Hbzk9/JHE3nW6OVd+INL7fu0/2?=
 =?us-ascii?Q?Ri4hBVzMAamfm2Cs3pBorsvekrJRfU8nyqfcFueuivOahxmhJiPF2mWNoiBe?=
 =?us-ascii?Q?iYm1+w8LEx19wi5rZHwaeKd+qBCOoD5adHd3YuwmCPZaYwsewN0PnvPIxJ+q?=
 =?us-ascii?Q?ZaXo8wLm4Lh06vBFv3et0W9BEdYsQrMX3TQjV+Zkomt0ef6j9j3uGD+vxMV9?=
 =?us-ascii?Q?PrbYFiCDv3j/QhO5jfwIOeSHGuNIKnSUB0OS8zuhuOcHHBZP1VeLK3JpHvAy?=
 =?us-ascii?Q?5BocTyFJdXF7SIrWmD7b7Obn4p8cydGRQ3J7cIZLq99RkSdVlL+I86X0dKfy?=
 =?us-ascii?Q?c+HFJ7nKEZDDtbQzh3nPfNGuU9HGC5jN/ZEnv9SHciZZv1ByL6dnzVMs6qEZ?=
 =?us-ascii?Q?e2A+iZf8qaEtF4h5yyy4xdJDtaZ3GIA6gUMkS8tRJTG2ei21D741oaZefrLW?=
 =?us-ascii?Q?mKkkK1cgIYOUFPiedsuGREqZ8NS8tcGZWyE9Ha4ESGg0fhTVPkKsU/iYnGQJ?=
 =?us-ascii?Q?3fqAJCC5n6lwPUSj/1T/ZZmjSZbLmRKV48qTA8jZ7XYUTasllGZgUTxYVC18?=
 =?us-ascii?Q?I/6ivJADPpQiPr39WQw8xDYzw+mwWeyVBnTJg/GbimcVCSRTQqtEYeq2jWxc?=
 =?us-ascii?Q?LRSWmBiJQX7r2mhVhv/aSEiM2jltm/caV04R0ILn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR18MB5314.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52229d1a-11ee-457b-08aa-08dc4259beb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 06:00:39.8614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i85vqeRD2nQNT3F1OLgzPHMCdp+r+82/9bi1yAuMbXip0LFpdcxxauI12wH9pugq7PmpEyuJohVI4ZNENiu1vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3897
X-Proofpoint-ORIG-GUID: XU4hx-nmz1y0IemWA1ymkq1jqG2TGdyq
X-Proofpoint-GUID: 8kOb7gfFbKAlhzoDFl4hz8OfIbUXw5IE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_05,2024-03-11_01,2023-05-22_02



> -----Original Message-----
> From: Eric Snowberg <eric.snowberg@oracle.com>
> Sent: Monday, March 11, 2024 9:41 PM
> To: linux-security-module@vger.kernel.org
> Cc: dhowells@redhat.com; dwmw2@infradead.org;
> herbert@gondor.apana.org.au; davem@davemloft.net; ardb@kernel.org;
> jarkko@kernel.org; paul@paul-moore.com; jmorris@namei.org;
> serge@hallyn.com; zohar@linux.ibm.com; roberto.sassu@huawei.com;
> dmitry.kasatkin@gmail.com; mic@digikod.net; casey@schaufler-ca.com;
> stefanb@linux.ibm.com; eric.snowberg@oracle.com; linux-
> kernel@vger.kernel.org; keyrings@vger.kernel.org; linux-
> crypto@vger.kernel.org; linux-efi@vger.kernel.org; linux-
> integrity@vger.kernel.org
> Subject: [EXTERNAL] [PATCH RFC 1/8] certs: Introduce ability to link to a
> system key
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y
> before clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> Introduce a new function to allow a keyring to link to a key contained
> within one of the system keyrings (builtin, secondary, or platform).
> Depending on how the kernel is built, if the machine keyring is
> available, it will be checked as well, since it is linked to the secondar=
y
> keyring. If the asymmetric key id matches a key within one of these
> system keyrings, the matching key is linked into the passed in
> keyring.
>=20
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  certs/system_keyring.c        | 29 +++++++++++++++++++++++++++++
>  include/keys/system_keyring.h |  7 ++++++-
>  2 files changed, 35 insertions(+), 1 deletion(-)
>=20
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 9de610bf1f4b..b647be49f6e0 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -426,3 +426,32 @@ void __init set_platform_trusted_keys(struct key
> *keyring)
>  	platform_trusted_keys =3D keyring;
>  }
>  #endif
> +
> +/**
> + * system_key_link - Link to a system key
> + * @keyring: The keyring to link into
> + * @id: The asymmetric key id to look for in the system keyring
> + */
> +int system_key_link(struct key *keyring, struct asymmetric_key_id *id)
> +{
> +	struct key *tkey;
> +
> +#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
> +	tkey =3D find_asymmetric_key(secondary_trusted_keys, id, NULL, NULL,
> false);
> +#else
> +	tkey =3D find_asymmetric_key(builtin_trusted_keys, id, NULL, NULL,
> false);
> +#endif
> +	if (!IS_ERR(tkey))
> +		goto found;
> +
> +	tkey =3D find_asymmetric_key(platform_trusted_keys, id, NULL, NULL,
> false);
> +
> +	if (!IS_ERR(tkey))
> +		goto found;
> +
> +	return -1;

Please use -ENOKEY.

Thanks
-Bharat

> +
> +found:
> +	key_link(keyring, tkey);
> +	return 0;
> +}
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.=
h
> index 8365adf842ef..b47ac8e2001a 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -9,6 +9,7 @@
>  #define _KEYS_SYSTEM_KEYRING_H
>=20
>  #include <linux/key.h>
> +struct asymmetric_key_id;
>=20
>  enum blacklist_hash_type {
>  	/* TBSCertificate hash */
> @@ -28,7 +29,7 @@ int restrict_link_by_digsig_builtin(struct key
> *dest_keyring,
>  				    const union key_payload *payload,
>  				    struct key *restriction_key);
>  extern __init int load_module_cert(struct key *keyring);
> -
> +extern int system_key_link(struct key *keyring, struct asymmetric_key_id
> *id);
>  #else
>  #define restrict_link_by_builtin_trusted restrict_link_reject
>  #define restrict_link_by_digsig_builtin restrict_link_reject
> @@ -38,6 +39,10 @@ static inline __init int load_module_cert(struct key
> *keyring)
>  	return 0;
>  }
>=20
> +static inline int system_key_link(struct key *keyring, struct asymmetric=
_key_id
> *id)
> +{
> +	return 0;
> +}
>  #endif
>=20
>  #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
> --
> 2.39.3
>=20


