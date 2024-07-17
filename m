Return-Path: <linux-efi+bounces-1444-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BAF933F64
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 17:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89642284BF4
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 15:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E60C17F4F1;
	Wed, 17 Jul 2024 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="Q2V/YtHT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4F9381DE;
	Wed, 17 Jul 2024 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721229444; cv=fail; b=l2rcwixY1r8udl4j4cwukAoEIEXbSbgVGfJU6LdzQV735/BgcO0BIVxJRaiY6dyjonUgtXu8xUFFmeoCpUgZev22/qKL0WeE5swqB1dfviBtROX3SOYC2RqF5D7iuM8rYevFOpAjfNdHlKmNBgGly16emwkn8rk2dwYherqrxeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721229444; c=relaxed/simple;
	bh=Ild5cfZij020Za+qGy8ctxAJdjYtxJ/0aIXbxSu+DCY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I/KQp7QYT9vL7mvaPKn3eMgi+2kvW3W0WiXVzQq4wXcpiSkNKacEwusV5AsffLoE1umioFXP4mLIOqM44nOWeynDH3aXeHvhQ/XL0yhfotRN5N+y/RwWQs2E1WcXcf3v7y/eEuHQN5PJ4swwrjm4l5AfyglAD47cI6j5nNht4yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=Dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=Q2V/YtHT; arc=fail smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=Dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HEb8Vs010233;
	Wed, 17 Jul 2024 11:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from
	:to:subject:date:message-id:references:in-reply-to:content-type
	:content-transfer-encoding:mime-version; s=smtpout1; bh=sJTfdz8y
	cPatfchT2f/VuINShj0Eq8Y42mO4VR+t5dA=; b=Q2V/YtHTGWgPUAbvpm60FTFj
	8tV7q0jrSDCXZX+84jevjBaYSMMLOuG0xWjtqBGDJfVLyoItq3B+eduRyo+LvVut
	rtcAvKXKyD8I5tDtvRWZkP4867MSkslKb1y4CZ7xL3hlYUxpA60LbD7Jod5PJkto
	BbsyXjiBzC17RHMJ+f8e2F2EVJCHjA9DOqnq8yAmBdEzvByifz0LVTOKG2++zB9H
	bIrertQSPVT5XCkD3OsCKiJRmiv4LKUatcL6r9KbP+szXwjhvL4w/eKSnTLx9Fx8
	QKW16BPftkKgMrmSE6T/FpjlvqIs8E1k4lVPN9Z5fwdECbQ7Cw3B1ddmYKtoPw==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 40dwfrw50f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 11:17:01 -0400 (EDT)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 46HF8rWh021070;
	Wed, 17 Jul 2024 11:17:00 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 40dwfyr7qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 11:16:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQZPKLAUf/6HdatsjDYtxtmOwf8KCK8j7k1V8ZL/f5X8BqmFPzGj0NtoLo5ejLhiScxrBryooHoVU3DaPqd+52FbYMpm+Xr2HcFNMagxuqVnaNvHMi5ER12whjowkbHEEzoHUioclMvQEEoJF7Fgyj2rmPdA/RWkSJqTfDixouYSob9mlPsWAqwKvUnXZoQj/48aOzxsbntTBGHytTW4zN+qFURsUVZf8pRGJtpK4GFn1WJmGjb0wJ+eqXmgXW+Bi5ZQj4X/odhj27OfqAe3SL3h8ze25rP0yYG9GijP8a7rtUyAlfwyGNhAdt5TWc9qp/G+SkucI4LwT0bx5CZsBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJTfdz8ycPatfchT2f/VuINShj0Eq8Y42mO4VR+t5dA=;
 b=rGiutOV8QrxFe3HGpaqE1XbHKUzvzoiDTTpioUrnbUqRrP5aVWR5fq37yriZzqGOYNoj56SXzXBWx3gCS0OTklUmB0OMeQl7hu+/iKYGI2o5lGzEBtlQxAQH7786aEfFYDkKgmw7/3w+alhYpInomhQBQphZIRT/U/SyYRbxF1tngcyFPe0WVVPofCvJLXek2GDyBuhaImB8HKrN1ruJbogSQiLl6595xaa0jrN/sBkPeFtnOxfo5+heZcNBVLPU+52M0zX4gofWAlGwHln5ooQU//+uRIS+0OIrRDvPRNnMoEB9X0s1riywA0Tbc6x1qmlzzRgpuhgYvy64YIS4hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DS7PR19MB5709.namprd19.prod.outlook.com (2603:10b6:8:70::15) by
 LV8PR19MB8670.namprd19.prod.outlook.com (2603:10b6:408:25a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 15:16:56 +0000
Received: from DS7PR19MB5709.namprd19.prod.outlook.com
 ([fe80::3d06:d879:7717:36e0]) by DS7PR19MB5709.namprd19.prod.outlook.com
 ([fe80::3d06:d879:7717:36e0%5]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 15:16:56 +0000
From: "Shao, Marshall" <Marshall.Shao@Dell.com>
To: "ardb@kernel.org" <ardb@kernel.org>,
        "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de"
	<bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de"
	<tglx@linutronix.de>
Subject: [Patch] Do not clear BSS region in x86 stub
Thread-Topic: [Patch] Do not clear BSS region in x86 stub
Thread-Index: AdrYGyaFCseU4QE3SCibBf0Ev6R9+wAQOiGA
Date: Wed, 17 Jul 2024 15:16:56 +0000
Message-ID: 
 <DS7PR19MB5709B2A263E769B461091B0D8BA32@DS7PR19MB5709.namprd19.prod.outlook.com>
References: 
 <DS7PR19MB570996A580C6F5D2C9CACCE48BA32@DS7PR19MB5709.namprd19.prod.outlook.com>
In-Reply-To: 
 <DS7PR19MB570996A580C6F5D2C9CACCE48BA32@DS7PR19MB5709.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=676a33c1-39d7-4baf-a488-a1649cd23f68;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public
 No Visual
 Label;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2024-07-17T15:15:10Z;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR19MB5709:EE_|LV8PR19MB8670:EE_
x-ms-office365-filtering-correlation-id: e5d9da02-2cbb-452b-842b-08dca6737eef
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?5vQ/lwaUNN5OClJFtLp9Fgdtlj1UCCUqUiuwxXVsCCbawqdb4vy+Ctbv07R2?=
 =?us-ascii?Q?z5RnGXpyXGDpJcL8lrsB3byyR6lIdhVubwPzyE6aRcFE5Tp0W+7jnHUdQIvJ?=
 =?us-ascii?Q?oG/Liff20rWd40xo1xqQLpBfYWIi5V3T5+KHlabm1tfzMNFK7HwiIzJ9oQMg?=
 =?us-ascii?Q?JUqb8JAV7QBasgx+YorX/n8MyVZJ2oQQxmWXQq4pWMjtTFuzfCK+BcyFFcvy?=
 =?us-ascii?Q?auucz9RiT0uwbtNB1gsH5wvmDiRN8Q5nnBMvHo2fdUaIJfm/RmXCy+UFY48t?=
 =?us-ascii?Q?Q22Q26qm8Cjc+80OvpPYhTIExgDmuo8iwOizWbkMI76r+SOSC2mO+WRiz/6W?=
 =?us-ascii?Q?nhiUyVUpgmfzreVmkmQWEX+C1NsRRoldp6B+M7TLGUDf52bC2cHqq2mUQCNg?=
 =?us-ascii?Q?KnBwh2pC+oUzHTIKn6TEqiZ7cgeRlUxQliHBg9VSn50+fKi/lbbQrG4aGyBk?=
 =?us-ascii?Q?lrOWNROQk/JZT9XSsFVNMF2FYP8nS4fbxu1KqmbAVspc8Abj/5IhOmqZXrkw?=
 =?us-ascii?Q?0GofF0oqbdNThUa54CUFH4uJUzqZLWb/kAH0GoY14zJCpwpwGo6oG4m2scUd?=
 =?us-ascii?Q?q0mw7oHZFoDUrTxZ5h+biOTI4oVW0c6NfQy4imH/S+LhG46hXmKjxfATCT5y?=
 =?us-ascii?Q?vTVU4v/wSAncKDALz8OX/TbpPUrIGD35PyUrg+1xP1RQHUKASLPvU99itdiV?=
 =?us-ascii?Q?Q9wbxAt7BDGzB5eg2EQU3EcBsKZvGUAqzEJ2gAhZ0uQH++x5Gwj/HCH145CR?=
 =?us-ascii?Q?dAVVfKjMHe4wsZigF3bVbrznK32P7z2iQvsirZWbOlIaEujat/u0HTdXsFxs?=
 =?us-ascii?Q?ctYolLZXetYp3K+gqTM+oLg9F68fdLqiYasH02OZzxxvC8pbRUvmPAfebv8W?=
 =?us-ascii?Q?K4Y1qMdE6N5iPGCGA46lOC8BGZcMuKd8SV+706bJlvM24UhN/UHaMiZWMARx?=
 =?us-ascii?Q?T7JcPTOTSlDEI/lIiFaTZDNT251/XW9MYkbogfkBeNbnCCK7hZand8nUcfB7?=
 =?us-ascii?Q?GMSuIGiJBYvPGC+OKNePPIotTpIKyqJgLEJsORRJfDbb0erF6P9bmFTXQbPp?=
 =?us-ascii?Q?L2OzBPAN4wwcbBpebxurJPMMselxnza0JGnqNVS/4nmnqohkcCvI6dGWeF2H?=
 =?us-ascii?Q?CsPZuiZQ2oBjAvZEdcRtXxXKTNLGDN60i4PrvTXUaegAqiq6iS6RAHd4vJ4C?=
 =?us-ascii?Q?QYa6Gylv+nrPOzLktsU1dRN9I7jwj6b2YwXWN4ucrJGrdv1ThOmyJQQtPE8p?=
 =?us-ascii?Q?CvV7uqfm/ujBzXMhfHwjf5q0KgmZaeC4BMtxg/9zSSmQTwqJNIzouYIm+zKM?=
 =?us-ascii?Q?5YcJ1+svUgQXeyClUqjQM5VvBINh9KLhJo+8OvkSCIcpXSHTDTJ7ScSM2jHJ?=
 =?us-ascii?Q?EfMJxgK8aIhixYEvGgz3+1nSav/OW2Gr9UgEAET/lsc/r9AXFQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5709.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?wLck3/3+cLslfQMIWxRBB3Nd4bRinkUsfEPjkng5C1zjNBanrAU+KM/XiLoJ?=
 =?us-ascii?Q?8GD61V0o1z0K/D5KV7mPKKUiKLID/th4+t6ceMNZ8Mj1pR1FrkW7HekcsN8a?=
 =?us-ascii?Q?aiOcpPrkjKfqqmPGq830fNa+VgrQvk9tuXRq6pOXEU0oSFIIwIcMhgHXdp4B?=
 =?us-ascii?Q?M/NRXO5h8jR5fnzcV2W5tI8a06uEseoL/UdtrkQLXYTDMOOZ7NqsDpvghvVP?=
 =?us-ascii?Q?UJDorotv+Kutfz0xKvGfKKXbu4yCeFPp0O/1krUDPM0oGzsgaVs02lyLaH+L?=
 =?us-ascii?Q?BIlaEEmXq3Rs6Y8zXe12BZ5SKPl6JJ0cfefy2TUVd3LD6aiAs5FnzQsygsPy?=
 =?us-ascii?Q?9amiIpfWCzb7SLEimrT4CgQ99KjskotIcfwTVbHLmQwu5MqsdE1n3L3o+YdR?=
 =?us-ascii?Q?A7kR1QBYobt7ggTuW2WGXwizSZWFwtOPNyd5cZe29YkJyNJc07J1AordI1Yt?=
 =?us-ascii?Q?Xc3CLXHs2V9yc6Rrmg/jfGYbtes+0heAIhAdpYy4hfI/fUGbc1MZ1hAUCJ7c?=
 =?us-ascii?Q?PSzQUWC2RUttADMVvwtW2QS7mtRoU+iGHL97LqxdKC8m6GU42d+c1vCF12kW?=
 =?us-ascii?Q?kz4wzAwrgSia1sgSoVi77hRuL2EK6tSsMi3KDwIQ7c7UTZwPKCdnNSaGxWcV?=
 =?us-ascii?Q?H58JV+A6QgZcN1ftojy8JKgR3dRbF9cULyyCWrc0jY7g/Hx8j1ZBPuzT39/9?=
 =?us-ascii?Q?3zEeGRBffEmWcnKCuhiywtYHKXxBF6Q1GM+s8LEbONsJKQFWJ9tc+ZkiDwfM?=
 =?us-ascii?Q?dDsC+61apCn6yIlZPRVnxG12Rr52oXxHLjuXPor9zw3maKDnNaMKp0TgRDkl?=
 =?us-ascii?Q?ZfySXBi7aim3LRLgqOxEtHOp9NBWgueT/YPsR5TWUqVrulQwPYK7CMqlxiQv?=
 =?us-ascii?Q?fjdnIk0xzVBcgtIFMWj5pdvTsxJd4Vm+Fl2UD6zWInD3DEBiumqOX6Nt+0oq?=
 =?us-ascii?Q?BYtbHG2ajovfO5dZA56ZnesRLRynjqO691C1ML+f07oTSpr892uuPpxPLyGr?=
 =?us-ascii?Q?6oLi7gpvyPD4ZQM7i52kMoVJcZfEvrmYot3opNHoJ3xKb5kazigj6IJe/rfk?=
 =?us-ascii?Q?BGzvLrAB6UN/eADNDQqCYdTAos30uizTAl9DeJLDIFmpW6luTnTTSo2BmqT2?=
 =?us-ascii?Q?Q9N7gOfi4BvdQX0oLnj/bpspemu9sUgX3EhlZVZHcd6PL5SFdPHCe2r0dqk5?=
 =?us-ascii?Q?fXlgEOTyOT3jJmFf+pFv2PwssvmqeR1NYdFFD3GpGzlbyN+iTRLBUK8VWuAr?=
 =?us-ascii?Q?1kfsTdVFPlaIrdgg6r9UslYpoYSuICH9+ydmQY2ts7a2BzESP5yCTHHsozQp?=
 =?us-ascii?Q?4MOMVQCA3EnoFMRbiET4UtIYLIn0ZFPaUy/zTxABLxsKEpP/hW4Zs3U/j+cA?=
 =?us-ascii?Q?2Sum79sv4gkzaQUI20mKl0NLLkH1VulLshu6OUokpbnls+UVymvff0WRCahi?=
 =?us-ascii?Q?PnWoEfKuVRHE+bBdq3F/0UV9kAIHLRmX26Al38NFYPp3RD/uPD7nvwrJ46T+?=
 =?us-ascii?Q?OgyIxm0/CsokTxPqlpQ/C2A2PEfeW/NvOPBcaH7O1wFFDfVlHyAY04tLS+TP?=
 =?us-ascii?Q?Ho+pwrnyupwoQFchBs1QY7qTadJBAYVxKzNjLFnW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5709.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d9da02-2cbb-452b-842b-08dca6737eef
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 15:16:56.0333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dWYBblzWEYXEm18VaWB+mRcSoAEi1DDIvq68Bv+PWEeSsUwcr1rJ/W0ek5y4KWRSbvi4WiaMkEbgHAP19GSQgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_11,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 malwarescore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407170117
X-Proofpoint-GUID: lIXbWlGNpe05WEYmXENK6Sl4DJh2m7DU
X-Proofpoint-ORIG-GUID: lIXbWlGNpe05WEYmXENK6Sl4DJh2m7DU
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407170117

Clearing the BSS region may cause the UEFI firmware to malfunction
during boot.

When booting the kernel from an older firmware version that has TPM
enabled and the MemoryOverwriteRequestControl bit set to 1, the=20
firmware's boot service might encounter an exception if it attempts=20
to initialize the BSS region within the x86 stub.

To circumvent the firmware exception, it is advisable to enlarge the=20
BOOT_STACK_SIZE and to perform the initialization of static variables=20
prior to the decompression of the bzImage.

Signed-off-by: Marshall Shao <marshall.shao@dell.com>
---
 arch/x86/boot/compressed/misc.c         | 8 +++-----
 arch/x86/include/asm/boot.h             | 2 +-
 drivers/firmware/efi/libstub/x86-stub.c | 5 -----
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/mis=
c.c
index b70e4a21c15f..bac5a3c55c2c 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -356,11 +356,9 @@ unsigned long decompress_kernel(unsigned char *outbuf,=
 unsigned long virt_addr,
 				void (*error)(char *x))
 {
 	unsigned long entry;
-
-	if (!free_mem_ptr) {
-		free_mem_ptr     =3D (unsigned long)boot_heap;
-		free_mem_end_ptr =3D (unsigned long)boot_heap + sizeof(boot_heap);
-	}
+	free_mem_ptr     =3D (unsigned long)boot_heap;
+	free_mem_end_ptr =3D (unsigned long)boot_heap + sizeof(boot_heap);
+	malloc_ptr =3D free_mem_ptr;
=20
 	if (__decompress(input_data, input_len, NULL, NULL, outbuf, output_len,
 			 NULL, error) < 0)
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 3e5b111e619d..312bc87ab027 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -33,7 +33,7 @@
 #endif
=20
 #ifdef CONFIG_X86_64
-# define BOOT_STACK_SIZE	0x4000
+# define BOOT_STACK_SIZE	0x10000
=20
 /*
  * Used by decompressor's startup_32() to allocate page tables for identit=
y
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi=
/libstub/x86-stub.c
index 1983fd3bf392..d92d2ccc709b 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -21,7 +21,6 @@
 #include "efistub.h"
 #include "x86-stub.h"
=20
-extern char _bss[], _ebss[];
=20
 const efi_system_table_t *efi_system_table;
 const efi_dxe_services_table_t *efi_dxe_table;
@@ -476,9 +475,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	efi_status_t status;
 	char *cmdline_ptr;
=20
-	if (efi_is_native())
-		memset(_bss, 0, _ebss - _bss);
-
 	efi_system_table =3D sys_table_arg;
=20
 	/* Check if we were booted by the EFI firmware */
@@ -1000,7 +996,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 void efi_handover_entry(efi_handle_t handle, efi_system_table_t *sys_table=
_arg,
 			struct boot_params *boot_params)
 {
-	memset(_bss, 0, _ebss - _bss);
 	efi_stub_entry(handle, sys_table_arg, boot_params);
 }
=20
--=20
2.34.1


