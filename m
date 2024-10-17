Return-Path: <linux-efi+bounces-1999-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CC49A29D6
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 18:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9805281877
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 16:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B0A1F8903;
	Thu, 17 Oct 2024 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y3WvaV5/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="doHTVfRO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD87C1F80CF;
	Thu, 17 Oct 2024 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184034; cv=fail; b=g0dfaRNR0P9pq7LiGkeZpMBe5amjlqa8eiFJOir0ph5MHylnGl5F+Yp++WRP7SNRWg+y6xD0d2bCOzTIAeGkGH13JZdsTbclzcZW6/kIDW/rFpnxdRTY691r0QOpRxUHgY7ZYrwz3AGLa3eu9lpBZj3dUkv25HpanTHElACeZEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184034; c=relaxed/simple;
	bh=rRwIDCeheizhqPtRPAGzmCOwiA5JrQimm51e/66qm4U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H1M0hufJNBqmJvjYHu6c8cR1QoaQCc4dlQLG4wBHg3xa7zaEJR1YXEPG1OxIDQ+tHUhltx7/FH5GH3QdGT2DDeezcRx/9TcWfddu/HHF+FbptZy8vSH6RLBUnGld9TZ3KSBdQMmicNsIHM8DBxG8R0nx+Qx0BqqtrKbO+7KFxbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y3WvaV5/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=doHTVfRO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBbGf009189;
	Thu, 17 Oct 2024 16:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=rRwIDCeheizhqPtRPAGzmCOwiA5JrQimm51e/66qm4U=; b=
	Y3WvaV5/jkVuF59xFdPccluJvT72WIDBExiL60uucqMdIJQLN8GScqGs96J2Avaj
	7PDHGyBOfPlV7oeh4SdvviEkZsvG8nAqRSbOgKPGJUU2W1Aw+ARQZt/DlbeHU6jN
	njYTaT+mblKXPmLL1NYWwIfBX0PSZe+WFsZMagB/cv5/rdr47lHxeEbUZrzyNv5j
	TasBX/iTeh6ldnxVMUCyLYKZJOVaGaHW0vg1zedc7WjWnZIA8gqHgZNEderGYWYW
	LkJbrEXVoQavP7JOWKE91/3PSZriU9KXBeELtCabZAdo5sUaH8gQOHsqQL/G3amn
	OGk20O2//v0RsIzHpBEfXA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gq7pyxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 16:53:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HGlFC9011105;
	Thu, 17 Oct 2024 16:53:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjgug5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 16:53:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IK79Ab1flSVRMPHVACS3ZuQaVTEFu2/P6eCXYnETLBUSS9wHfBZsrOMBGFxDqvu5QSnSX08QdVRqVFBUzNnu31qpJgvn4TOGrAl5Iq2WPS/wwJkFo29g2SunAei/SWNa8e0YYP2nFqFzdHhNiCJ9f9NChbl8JHCU84nv3M4HajISSekPqAYiL7JyiP36Ky0qMfEeQxkyXSlQo94RJ2oQVWoeGBVQ8CKIEgkM5erWWf+L8lJhEwietB+raF4hhU6pzCGtmF9RqBU3e/dm28AeDPbYqn1iHOLpuItMKAyYJR6/Y4ENLfhNiyHG8bBBwKJqNeRpJ4LmL0ukGA5xiBc6Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRwIDCeheizhqPtRPAGzmCOwiA5JrQimm51e/66qm4U=;
 b=CIhvtQ2Fm5vwTfTewUCdwQk09iW/UO37iW2+QeDcceaQTUu7+7JBOt/RgG1PVC41IGLPrzzwEHWSddYtyOPf5NKtdej9F3Poi+rjdjIuKXcX88y05Mwj93vIC4XcN2AEDPe/UR6FjMa3KNUsNW4H4BWK2Zdl5moq38nRg/LlHT0y19yySJdE3R0YQ/fjxWzWuN+ZPfS1qpP2gUayACDm5pwcAX65IOHA3p55eMzhcziXTjuVrCMzx6c0jYqJvWl1XH4czpMlCOsiimKDb+j6GHsjCm+lArGN6ISJCHejfZw1qp36vZr/OuQLIrzstxCsohPF3lQRu+ismx1Ua6wyhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRwIDCeheizhqPtRPAGzmCOwiA5JrQimm51e/66qm4U=;
 b=doHTVfROHHnyNNlzsC3fSJFlx5Cy5t7XWAp1nGQDr9xE4wrSy7+Xo/MTiBnbywWFjzwWB2WF91B1TYKmYm/JPY8unG6KBrZ4Z6dmTZEKMczYxEPpC/0hZ8EVR3LbaE56E1TDu+59RvJr1cRYIT/oUopOR4rtKkgzGwdQcVExcfk=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by SN7PR10MB7030.namprd10.prod.outlook.com (2603:10b6:806:349::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 16:53:17 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8048.017; Thu, 17 Oct 2024
 16:53:17 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
CC: "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ardb@kernel.org"
	<ardb@kernel.org>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com"
	<serge@hallyn.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
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
Subject: Re: [RFC PATCH v3 02/13] certs: Introduce ability to link to a system
 key
Thread-Topic: [RFC PATCH v3 02/13] certs: Introduce ability to link to a
 system key
Thread-Index: AQHbIK0GwItBr9zrG0uhmWgGGK2lKrKLHoEAgAAKOAA=
Date: Thu, 17 Oct 2024 16:53:17 +0000
Message-ID: <97B1D2D6-DB0A-4EE3-A24C-C70D81650707@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <20241017155516.2582369-3-eric.snowberg@oracle.com>
 <cc7e23de36edb50999cfd9c8dd6acc9d5962a479.camel@kernel.org>
In-Reply-To: <cc7e23de36edb50999cfd9c8dd6acc9d5962a479.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|SN7PR10MB7030:EE_
x-ms-office365-filtering-correlation-id: 6911ad75-217a-4fac-2b84-08dceecc32ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b3FhcnhaSFZIVC9LNk5iQVJsNUlIOEh0STRndGk1bFU2RkFjeE1LcjVhZkdC?=
 =?utf-8?B?NVhVRzVOWjdlODg4M2RxSXh0RUx3VVF5WTM4ZnRERWhIMjdBdm5wZzltT0dS?=
 =?utf-8?B?TXZJTkNHK2xIUWZ3ZHRreXBHZjdpVldFcFdZTEcwR3VGNm1KYkVYS2ZlV2h1?=
 =?utf-8?B?enVCeXlGT3ZhZDFHK1dseUgzSkh0dW9HUStMRDNCM3dmZTBwcTJVUVJDMks1?=
 =?utf-8?B?WVFqT2hVZEpnRFlaMEhwU0NreTJaL28reW95VEpaV2xJUGZIM2w0NEVCaXpp?=
 =?utf-8?B?Y0RSQVRCK2NDUGtpc1hEVHZ4Q0pMUHZEM0lNQTN0MjNaYXJpQk9ZTWFWV2Va?=
 =?utf-8?B?d2NEVmMwVEluUUdyaW9jQ0xOcFBoZXNkbXNjWjJtT2tldE42QW9aUUpRWmVX?=
 =?utf-8?B?WUVEZkx3Zzl3SDFEV3VBNEs4RGk2MTR1Rmx1dDFUZnRua1R1dGxUYms4Y1l1?=
 =?utf-8?B?MEpDSktrWVJpT3k1RGZkaVlPa0JZUWZ5TENCZUFDVXhRMnFpT1A4NjFMbk9z?=
 =?utf-8?B?NHZQa3kzSXNuT2FXTG5ab2ZQdXZ4WmlFRnY2Y0gzQXVZb0NjdU02WWpXTzhO?=
 =?utf-8?B?R1NsM2psaWYrTlI4TDFDaTRYMnR5UW0vYmVib0pJdHFzVmo0eUpkRXQ2UTZV?=
 =?utf-8?B?UWRkRlRrcDZTaVNZWWphNFdnM1IvWHJHTXUwUVBYZVZCWXdON1o3UkRtOVEw?=
 =?utf-8?B?WE00azJRblJGOXRsRUVveThyQTFiWVloVXhXOVcwdnUreGZnYWNYc0NaSTdx?=
 =?utf-8?B?bVRxTklNZWYvVnJyVlJBOWdEclJ2RnBJWGVpRkhXN3g2aGFkdVV1MG9obG1j?=
 =?utf-8?B?Kyt2aURreGpWR0lNaitkRi9kbmFGanZzVzV3YWtaWWF0Vmd2R2MyVjJRZVdz?=
 =?utf-8?B?VUgwYUw5WXBuMU51c1pKa3J0TkVscHpmVWR0V1NidEovUjF3d2VWYi84dnln?=
 =?utf-8?B?c1RhMGxIQ3JqVnUvaS83RnAzTVh6T0ZXbk43MG5nendWRU43VG15a3Jzc2l6?=
 =?utf-8?B?dGZrVXZFTnRiRkRJcy9vOE55OXUwWkFDWlZETFM5UEErYUNidHFxbTlqYXdu?=
 =?utf-8?B?UC9FNXY1ZU5tWHlDSUFKNEsyVk1oZHlNaDh0Z2xDTGtkdmdSMzFHOGRsUU1k?=
 =?utf-8?B?M1JtTFpzV3ArSHlQWHFtM2luSEhWVlBjalpibnRqRjZ3SWMydlplVm45aW9F?=
 =?utf-8?B?ZnF4ZWZ2TEREaFM5Tk0vQ2RxNjVGVW91a084Y0MzUEYxUzNDUzJtSDdCKzJW?=
 =?utf-8?B?eDZEVm81dW0veDJOUHNSNGcrYzE1cVhJSENyaVh1TG5JY3dha2tmcjkzNTdh?=
 =?utf-8?B?Sng5cGgvZUJDbWNnOE45ODd6RnhoQkI3a3l6cFU0NHkwaDNCanBzeXIvWlh0?=
 =?utf-8?B?K2FGK2UzV1BMZnNkMjk0L25nMXlGdGU4dzgwVTlLZGwzN1V6UkVJTXJ1SzFy?=
 =?utf-8?B?c2ZUdVNjV3VsOXpWSmI5UGdyZzdMZEplYXNuazVsMExxVW8vTU0rRGxhM2xa?=
 =?utf-8?B?TFpCS25XeExuSHA2ZG1zV2d2K2xFSXNYc3lydVNjVHE3YThUNjVUTENuMCtk?=
 =?utf-8?B?RTVqMXBmRFZMUC9rR1VTNkQ4MHFOQjdvSzVmVUhOTk9oUnJJeTJjWGQzSm1r?=
 =?utf-8?B?R2NxV0FPM2tQWjBxU3VUQmpwOEdhdHFGb2JRQ0pyaWlrZ1RSZEJqL0hzbUhC?=
 =?utf-8?B?YzB2RG5GZmdnMFN2dGRQaWtpUFV5OW1ERlRNZXVGMTltL3NCT1B3U3FqWTZJ?=
 =?utf-8?B?Z3hXMnduTTc0Z2oyUTZDSW1FQ3kxQUtHeC93Z1lrWDVhQjlBejd2WlZhZVow?=
 =?utf-8?Q?skLylSxJIh0o0b4qzpBo5Yum+Uc117w2fSZR0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cUNzWm5jY21BSklxNnc2NW5iTzE0Tnpkcm13UVJIY0NvSEl5djZMNFNoV09i?=
 =?utf-8?B?TTFhRytCcFI0QmRBeUVUSnlXeUVPR3NsK0ZjdWQwSmlhMWU0QmFHL3ZtLzht?=
 =?utf-8?B?eVNvK0VzSkliWWVMdU93by9VSnM3ZUhBdnBpT2xncWd2Y1ZDVmN5THFDM1pz?=
 =?utf-8?B?TlFQV21oaGlRQXJjY2puelB4a2wzUUtKTjJDTWl6Z1hDUEhEcGE4eGNXZjE5?=
 =?utf-8?B?Rk5Kckd0U01GTUFnZXJaY2JYblk0ZEdpRU9iK254TUprV3psMWdYektRcitp?=
 =?utf-8?B?bDh2TU40K1h2Z2RFNlhYWUYwM295TEdDMDhXYng0bXVScGVzQ1k3cWhSbGxG?=
 =?utf-8?B?NzFsWGpKbTVFbmlNSWFEMmp3OVpKdklSeUV4UXN2ak8wejBoN2psdVdrWWIr?=
 =?utf-8?B?QzNmM1pHWXdVaEJSanB2TkRQY3lUSWtGODVEbFlFd0QxbWc0dlp4cjdJWHVz?=
 =?utf-8?B?SVk2Z2VSRzRUbGRwM1B2aTA1WURLT080ZFJnZ1h6ejVNTGwyNWhRTDZRK0lT?=
 =?utf-8?B?b3dDRWRxcXRORVJpOFk1aUVIRTh4c3BMSTMwaGZ2YXpLdlIzK3V1aUpDNjJh?=
 =?utf-8?B?Vjk2eXRxSStyUEhMc2xUS2VSVWpkOUtlYmJnRFhTS0tqRVZHMTlpMllQRGFS?=
 =?utf-8?B?REhjQlRRWGIxdTF6Y3VmQmIvSmxPTGZJUEpNaUQ4STVJMk5XQjZmN2tTRTM3?=
 =?utf-8?B?Tm5UTkJWemM2dzFzdTIzdXg4M0JFZEZzOWZGZ1FBbE1IeTVGeC94M1QxUmkz?=
 =?utf-8?B?NVRhNG1CVllteE1IR0E0Tk8vcW1pV2RGanRpaDhCMng5RTVMZG5yUWFyNVVY?=
 =?utf-8?B?UHlhTHBMTGQ0UHVSd093NU1KTU56Nis3dEtncGNTTElKdkduUWN1bHlHZ0JH?=
 =?utf-8?B?WU5EbFBNZE5KNjFVeU5TZ3MwQnh2M1pRbDAxcEI5WHZkb0U1T1FXS1Avai9U?=
 =?utf-8?B?b1NZQkgwUnA1eEh0c3pnQXNTVnJpZzBQLzdoNVlWd3ZQbEFsSkY4U21OUUZw?=
 =?utf-8?B?V2N0ZzJTTTRwN3RZKzhnd3lMMmg3S1JpR1VJaVYrRDF3LzBJeGJ5V3cyWk9E?=
 =?utf-8?B?L3JOY3hKamhFa2dSN1JseitXZFFFL0UrQUNJckp6Z1NVdFFRRW1FUGNhUHBP?=
 =?utf-8?B?dzk3eDVQSDQ5bUNLYWQ3NU1Kby8wR2ZjNUI2SUgzQWJUWmVTQzBER1BJT2tk?=
 =?utf-8?B?aUl4MURvZGVwbnpBenlENlRwTHNWbndtMGtiK2MzYWVzWStuUHJJdjlGMHAz?=
 =?utf-8?B?TTdPUEM3aTRIblRZZFFIYXRCclh4dHU2NDRDTmc5d3YvRUVjUzBLNW5vUW5r?=
 =?utf-8?B?cUw3c1VPTzdybFBTRTJveGxpZk5ucGNWOFhkSlkwR0tNWmZMZ3p3NkwzVFhO?=
 =?utf-8?B?MjBhUWhUdDhCUzFURktFbWp6N1Zoa1RxNEFQMzJQaGoyeG9KOU9leVdlMjlv?=
 =?utf-8?B?UFhZa3hKMVFUczd5M0xDM0lzUFNBbjFjQStVN2dhUEU1S2hCVHBGckh5NlJH?=
 =?utf-8?B?ZVllZElZV1RsdDhvaW9iR0RLa3JEcHMySTQ2Qk5Pb2ZXRWlOYmZ0ekw0M2pU?=
 =?utf-8?B?Mmw0VjhaQW9YdE4xQnpFWlZjOEF2em5QcXNIQzBoR0lEWTBWMXlZMUY4L1JQ?=
 =?utf-8?B?UzZJbTJrS1hZWjNCNzNGQWNVdkVtUG9mYVhmeloveXcxYThadWFKTWNFOEJU?=
 =?utf-8?B?eWZLaVJCaXZmNXFydDcxTHA1azVHTi9YVllxcTdoZEVqSzhTdm9NMXEzSDFM?=
 =?utf-8?B?NkxncWpEREVieFcvbENVeU9PWnZ1VUQrTlFacW0yNWgrSVA3RGtqMU00aFNP?=
 =?utf-8?B?WXliVzhZTWRYSU5VZXBHQ001eXorZTJYY2t1aktlOWdrYnM1aVRFTGhOdXZZ?=
 =?utf-8?B?TFh3YUxvdGlWd05Ld0lLWnBOOFR5V0xGUmR0WUtVa2c2TmttaHE1MkpuSkM3?=
 =?utf-8?B?Tk9IMHMwaTlHZ1c0aWJtdUNNN0Ftb0dwWEVaRHFNdU16SWFnS2FtZEJBdi9C?=
 =?utf-8?B?elRicVBkNEo4bFBjaGVRNTdHNGs3OUVqRVo1THVjNzVmTUNXd0o4REFPMVht?=
 =?utf-8?B?a2QrNFkrc0dFMnc0VDhsUkE5SmxZdUxkaUFSVjcyaXZLdGgyNy9veTJuVHpD?=
 =?utf-8?B?OE10Y1F5MmJ5NGdNM1ZYVEFXejhVSGxadHMwcmxyQ0Fqam9lbldyeERsVjFV?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3CD8199C296484A985351A88E68A4D8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xqIFvIPLOwaEvp5jftMhFZN9NCJzSlgXPXgcYDH5isXf4vsbp6BA4mQhYtlWZmh2yVk3Lw+9oVvo24uzklz9uTAYzBU2sCc/EJ9rcpSpkDZR2W+mpG+bfDRahGcUP71EfjsTPHryznVnPD6uTq+qxiceudssbeZQQoZZ5799gLT8oSO3HGHSXWYKBuZz4KnxfGVTNRSJG5kBdJrcsKgV41kwStISraujvcKi1O0Nw2lseHNg1Fv3x+0pPbilusCil6IWtNwivlnJtleLIVCyELq22pjBvLoUe/3P27FciwkeiHJt6DDjJ6Dpv1ASIxWsWE4a4ibLcTyDHOr1vK/ZHy+f5f4fNVWy++/l8CposyOvBHFbmyKoc6Ee7ghWk5tRQ0yMj2KvS//h1TkMasFZpjp4rrlTcfBV3zx6nPhL5/e/MsdA/rkxOhBjGMwdQFRjx9LJJfK8YpTnVv+2pP/7/gLsLDxyGq5T7gA5MX9xm5C+5J2sCZV2gCYN8fDXf5ENyiYFNnUfm8qcDwoMxhSGWEB3LCZLHIVWCuc+9LNfG67a23BDTihN2UGhHhmx/TeqPDjZzX/PxYHNQrvur/Dv8Q4Z05lOujFoSP0xfmBexXg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6911ad75-217a-4fac-2b84-08dceecc32ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 16:53:17.0185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Zl4Lindb7uQVUCWwtj7gyp4WLIrvhJGVFwOO6tqSq76gvYXBvsMVWq2iDvxBrxt3+JzsWXBUxh7/X1aLuLJEXVfP/oKBtS4WdK9yKHK14E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7030
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_19,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170115
X-Proofpoint-ORIG-GUID: hLAky7jsf146GUb-6O4OzDPUII4G96NI
X-Proofpoint-GUID: hLAky7jsf146GUb-6O4OzDPUII4G96NI

DQoNCj4gT24gT2N0IDE3LCAyMDI0LCBhdCAxMDoxNuKAr0FNLCBKYXJra28gU2Fra2luZW4gPGph
cmtrb0BrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgMjAyNC0xMC0xNyBhdCAwOTo1
NSAtMDYwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+IEludHJvZHVjZSBzeXN0ZW1fa2V5X2xp
bmsoKSwgYSBuZXcgZnVuY3Rpb24gdG8gYWxsb3cgYSBrZXlyaW5nIHRvDQo+PiBsaW5rDQo+PiB0
byBhIGtleSBjb250YWluZWQgd2l0aGluIG9uZSBvZiB0aGUgc3lzdGVtIGtleXJpbmdzIChidWls
dGluLA0KPj4gc2Vjb25kYXJ5LA0KPj4gb3IgcGxhdGZvcm0pLiBEZXBlbmRpbmcgb24gaG93IHRo
ZSBrZXJuZWwgaXMgYnVpbHQsIGlmIHRoZSBtYWNoaW5lDQo+PiBrZXlyaW5nIGlzIGF2YWlsYWJs
ZSwgaXQgd2lsbCBiZSBjaGVja2VkIGFzIHdlbGwsIHNpbmNlIGl0IGlzIGxpbmtlZA0KPj4gdG8N
Cj4+IHRoZSBzZWNvbmRhcnkga2V5cmluZy4gSWYgdGhlIGFzeW1tZXRyaWMga2V5IGlkIG1hdGNo
ZXMgYSBrZXkgd2l0aGluDQo+PiBvbmUNCj4+IG9mIHRoZXNlIHN5c3RlbSBrZXlyaW5ncywgdGhl
IG1hdGNoaW5nIGtleSBpcyBsaW5rZWQgaW50byB0aGUgcGFzc2VkDQo+PiBpbg0KPj4ga2V5cmlu
Zy4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogRXJpYyBTbm93YmVyZyA8ZXJpYy5zbm93YmVyZ0Bv
cmFjbGUuY29tPg0KPj4gLS0tDQo+PiAgY2VydHMvc3lzdGVtX2tleXJpbmcuYyAgICAgICAgfCAz
MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICBpbmNsdWRlL2tleXMvc3lzdGVt
X2tleXJpbmcuaCB8ICA3ICsrKysrKy0NCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDM2IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2NlcnRzL3N5c3RlbV9r
ZXlyaW5nLmMgYi9jZXJ0cy9zeXN0ZW1fa2V5cmluZy5jDQo+PiBpbmRleCBlMzQ0Y2VlMTBkMjgu
LjRhYmVlNzUxNDQ0MiAxMDA2NDQNCj4+IC0tLSBhL2NlcnRzL3N5c3RlbV9rZXlyaW5nLmMNCj4+
ICsrKyBiL2NlcnRzL3N5c3RlbV9rZXlyaW5nLmMNCj4+IEBAIC0yMCw2ICsyMCw5IEBADQo+PiAg
c3RhdGljIHN0cnVjdCBrZXkgKmJ1aWx0aW5fdHJ1c3RlZF9rZXlzOw0KPj4gICNpZmRlZiBDT05G
SUdfU0VDT05EQVJZX1RSVVNURURfS0VZUklORw0KPj4gIHN0YXRpYyBzdHJ1Y3Qga2V5ICpzZWNv
bmRhcnlfdHJ1c3RlZF9rZXlzOw0KPiANCj4gLyoNCj4gKiBFeHBsYWluIHN5c3RlbV90cnVzdGVk
X2tleXMgKG5vdGhpbmcgdG9vIGRldGFpbGVkLCBvbmx5IHRoZSBnaXN0KQ0KPiAqLw0KPiANCj4+
ICsjZGVmaW5lIHN5c3RlbV90cnVzdGVkX2tleXMgc2Vjb25kYXJ5X3RydXN0ZWRfa2V5cw0KPj4g
KyNlbHNlDQo+PiArI2RlZmluZSBzeXN0ZW1fdHJ1c3RlZF9rZXlzIGJ1aWx0aW5fdHJ1c3RlZF9r
ZXlzDQo+PiAgI2VuZGlmDQo+PiAgI2lmZGVmIENPTkZJR19JTlRFR1JJVFlfTUFDSElORV9LRVlS
SU5HDQo+PiAgc3RhdGljIHN0cnVjdCBrZXkgKm1hY2hpbmVfdHJ1c3RlZF9rZXlzOw0KPiANCj4g
V2UgaGF2ZSBlbm91Z2ggdGhlc2UgdG8gbWFrZSB0aGlzIHF1aXRlIGNvbnZvbHV0ZWQgc28gbGV0
J3MgcHV0IHNvbWUNCj4gaGVscGZ1bCByZW1pbmRlcnMuIEkgd291bGQgZm9yZ2V0IHRoaXMgaW4g
bm8gdGltZSA7LSkgU28gaWYgaXQgY29tZXMNCj4gZG93biB0byB0aGF0LCBwbGVhc2UgcHV0IHNv
bWV0aGluZyBiZWNhdXNlIEkgaGF2ZSBhIGdvbGRmaXNoIG1lbW9yeS4NCg0KSSdsbCBhZGQgYSBj
b21tZW50IGV4cGxhaW5pbmcgdGhpcyBpbiB0aGUgbmV4dCByb3VuZCwgdGhhbmtzLg0KDQo=

