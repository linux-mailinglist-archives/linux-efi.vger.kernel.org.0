Return-Path: <linux-efi+bounces-1474-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D35938E53
	for <lists+linux-efi@lfdr.de>; Mon, 22 Jul 2024 13:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E94E281DAA
	for <lists+linux-efi@lfdr.de>; Mon, 22 Jul 2024 11:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6954D16C87D;
	Mon, 22 Jul 2024 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="F0IHpweM"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C049416D315;
	Mon, 22 Jul 2024 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721648934; cv=fail; b=lfqmm2mPS3r/rBCFh1+/3zefIDdj3sE3UrKR9mDmCqp48hnEXlRv0sqFb618vON+i6Fa7eXnNxtl2sS331Iz1mOUhy8bvtu1XVwrbOsfVM2M0a5etj6gxmTngUNK1LaMPlGOdY+OOPVwFoawSzDLNwHhcWncaWmWHFpp41K4jHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721648934; c=relaxed/simple;
	bh=rIjvjUQACBxiie8UE3hFYhYbFD2Lsa6xxBUr8wuQw7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jGiRFNv10PWuIs2Cw+HN7e258z0YqsUrjXsF/PaNMqIO3n6jH70qg9ClcZ/u5FtC5ddlBuUvejS2M5dRum72GVYCtSqv1VAlcelOiT6A/ja9MCUDAWocmAyu17nIuuwQmvlj8rGrpjWbOvhClqIaLwuRxzMEepS2AFtgEYFhei4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=Dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=F0IHpweM; arc=fail smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=Dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M8BXgf026096;
	Mon, 22 Jul 2024 07:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	smtpout1; bh=rIjvjUQACBxiie8UE3hFYhYbFD2Lsa6xxBUr8wuQw7E=; b=F0I
	HpweMch1g5rrM0x7VWIOZeNzhLq3Ms17jDy1jyQYz2TNVhesuR4Lb13L6Cx2a/O2
	SmaWzDH+z13VUnCePOsSKASIrSV736bRUgAu5yY9mTFvS37g6NDJaKGthSPhmoS/
	EmB9n/RZkVtZgiH9oult36Zv/dDp8RVpTFcg6a8qL33GIE1LbIVk3fuYetCHzgja
	H3r6rUgEPQQWb6EiSRCAWkUkgbhv7TEmv86gOWHGqV+wzkokOHTRIxFg7WtDaTMp
	8AFsAD91QvIdsy0vlvL2GxvbjddbxyzuE/vKwKSsKF5PlJR7ie/qK+6N8SiwUxYq
	bJAV4AnzrsxxwsqG8PA==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 40g7t2p3q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 07:45:14 -0400 (EDT)
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 46M8aFrm014246;
	Mon, 22 Jul 2024 07:45:13 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 40gtbky7dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 07:45:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nd5tLXg3fFUT4jOQy0Fh8vKqvAKcJnJl9zQezWDKd1Snu5F9Sn6fl39t+WwLfqGBIubiH+LTEai8l7pMsSy1Twc5IQBrO5cd1FrL3Ov8aJXTnVhZaZbW29Y0q5Uk1t6ihsh80E4Og3DC7TFwzW5sssX0Opr8KjNYcivkzfuczXFzcwtBLLRUrM1odnzxmFmGuacAYfhRb5nE1+LONYlEn/QWNBPnhXMS4tixLNwlA9GhrHbAZhbGXLnsvuZfn5ZnnmR8KP1fZdAN/hK2LXfi1xFG86yk/t3ADNtOM+V7pTTLJbY9hZhb4KjZEugvHuQNkWh44nQ8QXDsvz4rNzHX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIjvjUQACBxiie8UE3hFYhYbFD2Lsa6xxBUr8wuQw7E=;
 b=Iit117CSul8/Y98exuZpWOvWiWNiGp03GsoetiWJIJXlfSEn8ArkIue2/i/dDtGqOcvWxW2UusUH/To74PdS0/2MXKo25FQx54Yfrt7UIXrFkVK2KSYNEIsr+kCU0Z8aBXNNbqdMEL+Om7wf2OI+FCv/pkG7q74JveepLER5+T1bV+MDAZNs1xRJunAVA/po9o8WNZVYZcaNaUJMQl783sIz+fAmvDY7ZhN+E6Qhp/6AnEQhs+4Ce3+2GwwM+nm6G/OGUrmmDMBZ2AE14qHSS4s2B+suF+KuWKzdeMQSyIYUv80/+gRwqM/olUjaV395OfWW0Mkp6+ut47RXt4cZ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DS7PR19MB5709.namprd19.prod.outlook.com (2603:10b6:8:70::15) by
 DS0PR19MB7375.namprd19.prod.outlook.com (2603:10b6:8:147::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.25; Mon, 22 Jul 2024 11:45:10 +0000
Received: from DS7PR19MB5709.namprd19.prod.outlook.com
 ([fe80::3d06:d879:7717:36e0]) by DS7PR19MB5709.namprd19.prod.outlook.com
 ([fe80::3d06:d879:7717:36e0%5]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 11:45:10 +0000
From: "Shao, Marshall" <Marshall.Shao@Dell.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de"
	<tglx@linutronix.de>,
        "Mishra, Ashish" <Ashish.Mishra4@dell.com>,
        "Chia, Jia
 Yuan" <JiaYuan.Chia@dell.com>,
        "Dion, Christopher"
	<Christopher.Dion@dell.com>,
        "Caisse, Joe" <Joe.Caisse@dell.com>,
        "Mukundan,
 Govind" <Govind.Mukundan@dell.com>
Subject: RE: [Patch] Do not clear BSS region in x86 stub
Thread-Topic: [Patch] Do not clear BSS region in x86 stub
Thread-Index: AdrYGyaFCseU4QE3SCibBf0Ev6R9+wAQOiGAAABrtYAAlzZgQAAtv+GAAC61pjA=
Date: Mon, 22 Jul 2024 11:45:10 +0000
Message-ID:
 <DS7PR19MB570924EC5BB1BA3F321A65B98BA82@DS7PR19MB5709.namprd19.prod.outlook.com>
References:
 <DS7PR19MB570996A580C6F5D2C9CACCE48BA32@DS7PR19MB5709.namprd19.prod.outlook.com>
 <DS7PR19MB5709B2A263E769B461091B0D8BA32@DS7PR19MB5709.namprd19.prod.outlook.com>
 <CAMj1kXHBSNxrzbQoaDea7HFcjN9HHk5==tXg1WLHDzW61aj4cg@mail.gmail.com>
 <DS7PR19MB5709B39C90153DAA27DA122D8BAE2@DS7PR19MB5709.namprd19.prod.outlook.com>
 <CAMj1kXHS0rr9DfKCeD-Zz7y1Bk-3ncn2cEgVmnWE0Jq1B=+Acg@mail.gmail.com>
In-Reply-To:
 <CAMj1kXHS0rr9DfKCeD-Zz7y1Bk-3ncn2cEgVmnWE0Jq1B=+Acg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=951d364d-75e8-4652-bd76-78a47a2c17fb;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public
 No Visual
 Label;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2024-07-22T11:44:03Z;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR19MB5709:EE_|DS0PR19MB7375:EE_
x-ms-office365-filtering-correlation-id: 26ec40b4-cc0c-43b6-5b08-08dcaa43bda4
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QTd2Wmk2R2J4Sy91aUlCeHNqWldPRzF4d3NSZUIwRC9pYlJxNGlvYm95OHdF?=
 =?utf-8?B?REhhN0JaNkt1T2l3blpnS01nYldiWnZTandFampEM2lnMFFjSE9IcUIwZjVS?=
 =?utf-8?B?ZlNOc3oweG1ZZjVuYVJHb205TEplQ1NYYWVZS3JjdDh6YWxWc2xaeXkwV0tE?=
 =?utf-8?B?SFNXM2J3NnphV2VTdHJjb3FDL2hRQllMTkJQR0V1UVBKd015SGtMempmQVdX?=
 =?utf-8?B?S2doUFlhaW1iNzEzRjNxdFpTTGVKWGlUMmJCUkxUaDJGRXoxVTgvUUd4VUps?=
 =?utf-8?B?M2ZTa25JZXI5M2dLOUJBMEUrZmNxMjBNbFJaMXNUMnJtajdxdkVFMnBJb2pB?=
 =?utf-8?B?M0lWZTdYVVlqY2IzUHJVMlU2OHpEa3hRcy9Ta1NZeFhMTUZCWjVLdSt3dkZP?=
 =?utf-8?B?em4wS1lnNEVLbFl3ZGVBWjduZGJjalQxVDVxbFZmUm55SCt3anpBeWlWc3hy?=
 =?utf-8?B?REY4dXBIOUNlOWFVNHFqUWx3aC90ZGp6ejFOaTVVeTljenJXcmJBRk5ub2VV?=
 =?utf-8?B?L1NtK3pEdmx2SEhPaUtlYnhIRGYxdnFkV1lxdmYzSTFJa3Z5OEh6MXhtSnRC?=
 =?utf-8?B?R3VnYlZ4YkZRSGUwd2l0eHhiWlJRWlFmQW1ocmNYcHJsaktLSExtbE1HVFhL?=
 =?utf-8?B?VURpdHl4bEdxUktDbXIzemxpNmpZWXd1ajY3RWUrOGRyNmgyUlJBYmhYTGNI?=
 =?utf-8?B?cm1UVTNybmhWcFpMY1VOeXpJd0hOWTVSTEpWRTliTEVsdXpvYXFzcFo4akph?=
 =?utf-8?B?UXNDZWhtVjZJN2dxYkhMaHR3TDlyZ0QxMTN5MTN1UW0zSjU5YjRyMG1WNk84?=
 =?utf-8?B?SzZPNEN5WEw4YkU2M0ZmSFFqbXFIT0lTYWRMVm5vSkpKQUVGaURZK1RWRFFL?=
 =?utf-8?B?UFJuUWtGSWVoTkRpS0R6M1E3QXNtakFqMWo0K2NNSzdlSnhHeXBVVi9tNFhE?=
 =?utf-8?B?cy9NRTc2TVB3aVNPOEs1ZGU2ckNKWXUxKzdwZjBtREp3RnhCb1NxcG5LTXBG?=
 =?utf-8?B?NXFPd0hoVTNVVmlmNzNJbDYvK2lBZENNSEtxNkV4a2FlUmhna0tWT0wvMkE2?=
 =?utf-8?B?TXJydTA0WHdtaDFEcEd6Wk9QMGo3ckhLVWxFT240cGR4SFR4ek54RjRWeThp?=
 =?utf-8?B?RTFwa2RIa3FYak1ad3c3SGY2SW5rRllCTnNPQkNaZnVlK1d0MkVjaEZpaFdD?=
 =?utf-8?B?SEJ3TlZEVkJQVXpMdDlnS2RRdFhLMDd3NnRKRVI2R3l6dmUyT2tCbmY2ZVpD?=
 =?utf-8?B?dktyTFVzMlBNNjVLNUNFeVVYOWhBcnFTR3krLzFhRTExdmRQK1NYYVFoNE9X?=
 =?utf-8?B?VWhYbms3cFUrdWNuQmMvNjFydTlyNmtFdDZBNWNGZktHaGszNWlmNXRxZTBa?=
 =?utf-8?B?dlRHVVN0ZHd6Y3ZoZnpRTHRJWnQvcmNuRzg5ZHBLbytGVXIvL1BoU1ZseXBI?=
 =?utf-8?B?TC92a3AxUkxSbmNvSnFLK1h1d2pSMFVCbWwrQndrMU9NOUlua294elRURmxT?=
 =?utf-8?B?TGVrN1ZMSnUyMG13ZThIOGRsQm1MTWh2WEhIdGRyMFhtYTltZmlGUkNxK1dB?=
 =?utf-8?B?QjlWaGNYWEZvcDczRDlVY2JuYVlkT2VmZjJ2UloxZGJNa0NRakMwZVc3QU9h?=
 =?utf-8?B?T1FrM2NFMUNpeTZLbk4yNkNIRkYyaC9xbmRJbFdVZy95QTZYMHYydnlVQlA1?=
 =?utf-8?B?NnRqVmE0UVhyVERSN240WFJGK2hRQm9mUDBrT3diNm1leU9ONmpxMWQxd3pH?=
 =?utf-8?B?RzBicmlUNlBzZ01kQzVybitCZi9GenNENFFva3dqakZHWVpjTVVlbktnTkNh?=
 =?utf-8?B?dWZFamNabytzOVpvdnZ2TzVqUDA2T3lEZmEvbzlBeCtqeC9OdXpmS3ZFZ3JU?=
 =?utf-8?B?ZndKa3I2L0FiS1p6aUo5RUVDdkZXM1hRZzhVMzFqRWplWlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5709.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0x0UkRDTHE4ZStFTjdINDJhaDhPMi9wR25nYWQyblN6RGo4VTdPeGZZWitY?=
 =?utf-8?B?V0VqZ29XazdtdjJoRlpLR1V5MlAyUnJCUWQ3alNZTUFVOTVWTUxVUXhJOTJE?=
 =?utf-8?B?aFowYkt5QUlkbFFRZXZRNUJlczhPR3FnenEzLyt3ZDUyOU0vSEYwY2lEZDFx?=
 =?utf-8?B?b3U1VHRuN0RNcE9XSG51UjFSbXB4d0laMVZaNDJkNkN4VTFqbzJnakh2a0du?=
 =?utf-8?B?Z3ZYbWVZUlFWeDJjMDlJUWFDZDdIakcyalY2bkJBR3pYV09aVHkvYjlUNm90?=
 =?utf-8?B?U3laeVk2VG1FSWR1cW14R2NUdU1aMGtLY3lsd2dSeDNVUUpiRVhEUDJ0aXVn?=
 =?utf-8?B?bk56aVA1SmppWDRVTThCN0NsTEhQMkI5QzRPTGZ6UXY5L1ZRWnphWmpNcUxH?=
 =?utf-8?B?dWNDejNRMnlFMEdaREV3UFlNZHpZaVZaUFkyVnI0YzBQRzl4MW5veVBVVEkw?=
 =?utf-8?B?Y3NxbGlyRVVvdURwQllNS2xMWkErWlRIU3RMVEJXendUdUhhcTlTMnBjSzNr?=
 =?utf-8?B?QUtxcW52aVU4Mjc3UjczRDY2YmpsMXdGbVlsekpTakhUeHk0emhpcnNHQjQ2?=
 =?utf-8?B?NWRNaWxrVVFKbG53N2VHU2lTZlBDWWw1Y3Y1U2x3RUFtdGk0VG1zMXN0dnpr?=
 =?utf-8?B?ZFZJVktFZ1FzQWF0STg2Sm9JSWxWZ0ExSFVKbkttZWFoKy9yWGZleDV1dEZa?=
 =?utf-8?B?RmdMUFowaGRXdk1kdktlQmRUZFFEbkhzeW1UaXRoWW9wd0NjdXVtZjRyNEJr?=
 =?utf-8?B?Rng3ZFVLVW8wQlJOeFRETnZZU3A2R2FEVWk3bGI1cG84VTVHcFY2TGpWUkF3?=
 =?utf-8?B?elpOSlZDL1FmemxSQTVkbEhaSHJwbnNWMzRwUStqQ0FsbkdMai9IMnlQTCtM?=
 =?utf-8?B?NlJxRFMwVmxTT2FqeUFOeFVSa1hZZ1VWeGNMbUVQTGpKN1VtRGxoelhZN2Uw?=
 =?utf-8?B?SngrTVFsRGFUZ3VialltRE5mMHpWdkdGK3hhMDY1S3dSY09NTjBZYUw3dG1E?=
 =?utf-8?B?a1BKSXZSYU5XdzFWYzRWMWplZjdxcHdFZS9aKzZRbVJKc3dEb1Y4V0JHZklC?=
 =?utf-8?B?cG05elBRSVVWdFB4UFhHSlM0YVl4YVhUc0F1a3hhbWlFa21Ub2Y0VVV1N3NX?=
 =?utf-8?B?S2ZqeTh3VFdEZ0t4S1FyMXMvWTBQSlUxc3ZmNm4yZTNJeXc2RTNQUWM0cy90?=
 =?utf-8?B?bk03VmtLNW9rWENEU0huUnRGN283bUptOG1VTWtBbm1wT0lxNytNWVl2b1Z4?=
 =?utf-8?B?NWpwQ25HdFhvYk9WaUZpZTJqQkNlY29tandOcC82WDF3eHhZRWgvZXhBMmZP?=
 =?utf-8?B?QXlDdThqcWY1ejAycFNnMzRhQTdKN3FRZDhyRW5qTk12NXVzSmlrRWtrWU1z?=
 =?utf-8?B?NkRoN1pOUTl3WXh4MDZ5KzREemltWmorZ0taT3lkcmxBZ2NRZUlHNDI0azVm?=
 =?utf-8?B?ZlZlbWtoUEFrSmlJSktvbzdLMFpVakhzUUZsWWQ2clIzZDZpY0NZdHBrdHRt?=
 =?utf-8?B?eHNOSmpGUGFBT3pmRHlPb1pEblJFTXo3Y1BHUDFNVnkrRWJGWno4Q0hRUzFU?=
 =?utf-8?B?NDZiL1ZRTk5hWFBKQ01ZSTFnb0g0OEN1bUxQaStFKzlrMmVjdFlOQ3hRVG9Y?=
 =?utf-8?B?blc5YjdOSCtodTd4WFdJMEh0WG9NMEpBb2RxZndGOHFBZHZvVTMyNjZ3RFVn?=
 =?utf-8?B?dllNeDhtR0lUSWZaQnpEbjlVbTY5dk8yZktxaTd1L3dDWWNIZUtPWlluMitj?=
 =?utf-8?B?TWpZSTVrNmdad1VJWjFsWGQ3eFRWdVlERmEzTzRBaGZDdFIvM0ZSMEJQck9N?=
 =?utf-8?B?N1lOaDNSaitlU3NGdWhnS2haM1RvVDZqVmNzSkJEdlcyZkg0NlFkcXZGNGpz?=
 =?utf-8?B?dGhIc0dxVVBCNFVrOWphd0EybGk2ckFIcDdRZDNRNTdGREFmSTFCMTNmVlNN?=
 =?utf-8?B?KzFBK0VncDZZOG9Eekl2WWJ1ZDIyTE5ORXdIcW1sczY3YTFweEliYmF5NkZz?=
 =?utf-8?B?RDRiSXQrc1AxbjVNUVZaUzd2emZIdHNoQVk3cEE2b0JBbHlDcGoralJoRm4z?=
 =?utf-8?B?Q2cxcWxrMWxJcWgyWExlMnd3U3dEaWp3WVF2TW14UGZOVnR4YzVGNGQzek0z?=
 =?utf-8?Q?wSNce1bjLFHqygoOFPIeCW6Sg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5709.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ec40b4-cc0c-43b6-5b08-08dcaa43bda4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 11:45:10.0453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k7OoOoe68f1w7ihuibSEnEUJO+d1dg2HdRfvaemWsu072nEbcUZ3ILmsKtX8wuJOD7Lo2t8bsTfHfzWKuQjccw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7375
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_06,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=676
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407220089
X-Proofpoint-ORIG-GUID: lRtk3DjAQORJ0yMW7vMQbrbYbRWuW4aD
X-Proofpoint-GUID: lRtk3DjAQORJ0yMW7vMQbrbYbRWuW4aD
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0
 clxscore=1015 adultscore=0 mlxlogscore=633 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407220089

SGkgQXJkLA0KDQo+IEdpdmVuIHRoYXQgR1JVQiBub3cgc3VwcG9ydHMgdGhlIG5hdGl2ZSBFRkkg
ZW50cnlwb2ludCBwcm9wZXJseSwgDQo+IHRoZSBoYW5kb3ZlciBwcm90b2NvbCBpcyBlc3NlbnRp
YWxseSBkZXByZWNhdGVkLg0KDQpJbiBteSBjYXNlLCB0aGUgc3lzdGVtZC1ib290IGp1bXBlZCBp
bnRvIHRoZSBFRkkgc3R1YiBjb2RlIHZpYQ0KaGFuZG92ZXIgcHJvdG9jb2wsIHRoaXMgbWF5IG5v
dCBiZSBhbiBvcnRob2RveCB3YXkgdG8gYm9vdCB0aGUga2VybmVsDQpidXQgaXQgcGVyZm9ybXMg
d2VsbCBvbiB0aGUgb3RoZXJzLCBJIGhhdmUgdGVzdGVkIG9uIGF0IGxlYXN0IA0KNiBmaXJtd2Fy
ZS4NCg0KSSB1bmRlcnN0YW5kIHRoYXQgdGhlIGhhbmRvdmVyIHByb3RvY29sIGlzIGdvaW5nIHRv
IGJlIGRlcHJlY2F0ZWQuDQpIb3dldmVyLCBhcyBvZiBub3csIEkgY2FuJ3QgZ3VhcmFudGVlIHdo
aWNoIEVGSSBsb2FkZXIgd2lsbCBiZSANCnVzZWQgdG8gbG9hZCBteSBiekltYWdlLiBBbHRob3Vn
aCBpdOKAmXMgbm90IHZlcnkgY29tbW9uLCBib290aW5nIA0KZnJvbSB0aGUgaGFuZG92ZXIgcHJv
dG9jb2wgd2l0aCB1bmNsZWFuZWQgQlNTIG1lbW9yeSBpcyBwb3NzaWJsZS4NCg0KPj4gbWVtc2V0
KF9ic3MrMHgxMDAwMCwgMCwgX2Vic3MgLSBfYnNzIC0gMHgxMDAwMCkNCg0KPiBTbyBub3cgeW91
IGFyZSBhcHBseWluZyB0aGUgbWVtc2V0IG9ubHkgdG8gcGFydCBvZiBCU1MsIHJpZ2h0PyBIb3cN
Cj4gZG9lcyB0aGlzIGhlbHA/DQoNClRoaXMgcGFydCBkb2Vzbid0IHdvcmsgd2l0aG91dCBpbmNy
ZWFzaW5nIHRoZSBCT09UX1NUQUNLX1NJWkUuDQoNCkFuZCBmb2xsb3dpbmcgY29udGVudCBpcyBt
eSBQRSBtZXRhZGF0YSwgbWFueSB0aGFua3MhDQoNCg0KRmlsZTogYnpJbWFnZQ0KRm9ybWF0OiBD
T0ZGLXg4Ni02NA0KQXJjaDogeDg2XzY0DQpBZGRyZXNzU2l6ZTogNjRiaXQNCkltYWdlRmlsZUhl
YWRlciB7DQogIE1hY2hpbmU6IElNQUdFX0ZJTEVfTUFDSElORV9BTUQ2NCAoMHg4NjY0KQ0KICBT
ZWN0aW9uQ291bnQ6IDMNCiAgVGltZURhdGVTdGFtcDogMTk3MC0wMS0wMSAwMDowMDowMCAoMHgw
KQ0KICBQb2ludGVyVG9TeW1ib2xUYWJsZTogMHgwDQogIFN5bWJvbENvdW50OiAwDQogIFN0cmlu
Z1RhYmxlU2l6ZTogMA0KICBPcHRpb25hbEhlYWRlclNpemU6IDE2MA0KICBDaGFyYWN0ZXJpc3Rp
Y3MgWyAoMHgyMDYpDQogICAgSU1BR0VfRklMRV9ERUJVR19TVFJJUFBFRCAoMHgyMDApDQogICAg
SU1BR0VfRklMRV9FWEVDVVRBQkxFX0lNQUdFICgweDIpDQogICAgSU1BR0VfRklMRV9MSU5FX05V
TVNfU1RSSVBQRUQgKDB4NCkNCiAgXQ0KfQ0KSW1hZ2VPcHRpb25hbEhlYWRlciB7DQogIE1hZ2lj
OiAweDIwQg0KICBNYWpvckxpbmtlclZlcnNpb246IDINCiAgTWlub3JMaW5rZXJWZXJzaW9uOiAy
MA0KICBTaXplT2ZDb2RlOiA5NDE2NzA0DQogIFNpemVPZkluaXRpYWxpemVkRGF0YTogMjQxNjY0
DQogIFNpemVPZlVuaW5pdGlhbGl6ZWREYXRhOiAwDQogIEFkZHJlc3NPZkVudHJ5UG9pbnQ6IDB4
OEY4OTkwDQogIEJhc2VPZkNvZGU6IDB4NDAwMA0KICBJbWFnZUJhc2U6IDB4MA0KICBTZWN0aW9u
QWxpZ25tZW50OiA0MDk2DQogIEZpbGVBbGlnbm1lbnQ6IDUxMg0KICBNYWpvck9wZXJhdGluZ1N5
c3RlbVZlcnNpb246IDANCiAgTWlub3JPcGVyYXRpbmdTeXN0ZW1WZXJzaW9uOiAwDQogIE1ham9y
SW1hZ2VWZXJzaW9uOiAzDQogIE1pbm9ySW1hZ2VWZXJzaW9uOiAwDQogIE1ham9yU3Vic3lzdGVt
VmVyc2lvbjogMA0KICBNaW5vclN1YnN5c3RlbVZlcnNpb246IDANCiAgU2l6ZU9mSW1hZ2U6IDk2
NzQ3NTINCiAgU2l6ZU9mSGVhZGVyczogNDA5Ng0KICBTdWJzeXN0ZW06IElNQUdFX1NVQlNZU1RF
TV9FRklfQVBQTElDQVRJT04gKDB4QSkNCiAgQ2hhcmFjdGVyaXN0aWNzIFsgKDB4MTAwKQ0KICAg
IElNQUdFX0RMTF9DSEFSQUNURVJJU1RJQ1NfTlhfQ09NUEFUICgweDEwMCkNCiAgXQ0KICBTaXpl
T2ZTdGFja1Jlc2VydmU6IDANCiAgU2l6ZU9mU3RhY2tDb21taXQ6IDANCiAgU2l6ZU9mSGVhcFJl
c2VydmU6IDANCiAgU2l6ZU9mSGVhcENvbW1pdDogMA0KICBOdW1iZXJPZlJ2YUFuZFNpemU6IDYN
CiAgRGF0YURpcmVjdG9yeSB7DQogICAgRXhwb3J0VGFibGVSVkE6IDB4MA0KICAgIEV4cG9ydFRh
YmxlU2l6ZTogMHgwDQogICAgSW1wb3J0VGFibGVSVkE6IDB4MA0KICAgIEltcG9ydFRhYmxlU2l6
ZTogMHgwDQogICAgUmVzb3VyY2VUYWJsZVJWQTogMHgwDQogICAgUmVzb3VyY2VUYWJsZVNpemU6
IDB4MA0KICAgIEV4Y2VwdGlvblRhYmxlUlZBOiAweDANCiAgICBFeGNlcHRpb25UYWJsZVNpemU6
IDB4MA0KICAgIENlcnRpZmljYXRlVGFibGVSVkE6IDB4MA0KICAgIENlcnRpZmljYXRlVGFibGVT
aXplOiAweDANCiAgICBCYXNlUmVsb2NhdGlvblRhYmxlUlZBOiAweDANCiAgICBCYXNlUmVsb2Nh
dGlvblRhYmxlU2l6ZTogMHgwDQogIH0NCn0NCkRPU0hlYWRlciB7DQogIE1hZ2ljOiBNWg0KICBV
c2VkQnl0ZXNJblRoZUxhc3RQYWdlOiAwDQogIEZpbGVTaXplSW5QYWdlczogMA0KICBOdW1iZXJP
ZlJlbG9jYXRpb25JdGVtczogMA0KICBIZWFkZXJTaXplSW5QYXJhZ3JhcGhzOiAwDQogIE1pbmlt
dW1FeHRyYVBhcmFncmFwaHM6IDANCiAgTWF4aW11bUV4dHJhUGFyYWdyYXBoczogMA0KICBJbml0
aWFsUmVsYXRpdmVTUzogMA0KICBJbml0aWFsU1A6IDANCiAgQ2hlY2tzdW06IDANCiAgSW5pdGlh
bElQOiAwDQogIEluaXRpYWxSZWxhdGl2ZUNTOiAwDQogIEFkZHJlc3NPZlJlbG9jYXRpb25UYWJs
ZTogMA0KICBPdmVybGF5TnVtYmVyOiAwDQogIE9FTWlkOiAwDQogIE9FTWluZm86IDANCiAgQWRk
cmVzc09mTmV3RXhlSGVhZGVyOiA2NA0KfQ0KU2VjdGlvbnMgWw0KICBTZWN0aW9uIHsNCiAgICBO
dW1iZXI6IDENCiAgICBOYW1lOiAuc2V0dXAgKDJFIDczIDY1IDc0IDc1IDcwIDAwIDAwKQ0KICAg
IFZpcnR1YWxTaXplOiAweDMwMDANCiAgICBWaXJ0dWFsQWRkcmVzczogMHgxMDAwDQogICAgUmF3
RGF0YVNpemU6IDEyMjg4DQogICAgUG9pbnRlclRvUmF3RGF0YTogMHgxMDAwDQogICAgUG9pbnRl
clRvUmVsb2NhdGlvbnM6IDB4MA0KICAgIFBvaW50ZXJUb0xpbmVOdW1iZXJzOiAweDANCiAgICBS
ZWxvY2F0aW9uQ291bnQ6IDANCiAgICBMaW5lTnVtYmVyQ291bnQ6IDANCiAgICBDaGFyYWN0ZXJp
c3RpY3MgWyAoMHg0MjAwMDA0MCkNCiAgICAgIElNQUdFX1NDTl9DTlRfSU5JVElBTElaRURfREFU
QSAoMHg0MCkNCiAgICAgIElNQUdFX1NDTl9NRU1fRElTQ0FSREFCTEUgKDB4MjAwMDAwMCkNCiAg
ICAgIElNQUdFX1NDTl9NRU1fUkVBRCAoMHg0MDAwMDAwMCkNCiAgICBdDQogIH0NCiAgU2VjdGlv
biB7DQogICAgTnVtYmVyOiAyDQogICAgTmFtZTogLnRleHQgKDJFIDc0IDY1IDc4IDc0IDAwIDAw
IDAwKQ0KICAgIFZpcnR1YWxTaXplOiAweDhGQjAwMA0KICAgIFZpcnR1YWxBZGRyZXNzOiAweDQw
MDANCiAgICBSYXdEYXRhU2l6ZTogOTQxNjcwNA0KICAgIFBvaW50ZXJUb1Jhd0RhdGE6IDB4NDAw
MA0KICAgIFBvaW50ZXJUb1JlbG9jYXRpb25zOiAweDANCiAgICBQb2ludGVyVG9MaW5lTnVtYmVy
czogMHgwDQogICAgUmVsb2NhdGlvbkNvdW50OiAwDQogICAgTGluZU51bWJlckNvdW50OiAwDQog
ICAgQ2hhcmFjdGVyaXN0aWNzIFsgKDB4NjAwMDAwMjApDQogICAgICBJTUFHRV9TQ05fQ05UX0NP
REUgKDB4MjApDQogICAgICBJTUFHRV9TQ05fTUVNX0VYRUNVVEUgKDB4MjAwMDAwMDApDQogICAg
ICBJTUFHRV9TQ05fTUVNX1JFQUQgKDB4NDAwMDAwMDApDQogICAgXQ0KICB9DQogIFNlY3Rpb24g
ew0KICAgIE51bWJlcjogMw0KICAgIE5hbWU6IC5kYXRhICgyRSA2NCA2MSA3NCA2MSAwMCAwMCAw
MCkNCiAgICBWaXJ0dWFsU2l6ZTogMHgzQjAwMA0KICAgIFZpcnR1YWxBZGRyZXNzOiAweDhGRjAw
MA0KICAgIFJhd0RhdGFTaXplOiAxMDI0DQogICAgUG9pbnRlclRvUmF3RGF0YTogMHg4RkYwMDAN
CiAgICBQb2ludGVyVG9SZWxvY2F0aW9uczogMHgwDQogICAgUG9pbnRlclRvTGluZU51bWJlcnM6
IDB4MA0KICAgIFJlbG9jYXRpb25Db3VudDogMA0KICAgIExpbmVOdW1iZXJDb3VudDogMA0KICAg
IENoYXJhY3RlcmlzdGljcyBbICgweEMwMDAwMDQwKQ0KICAgICAgSU1BR0VfU0NOX0NOVF9JTklU
SUFMSVpFRF9EQVRBICgweDQwKQ0KICAgICAgSU1BR0VfU0NOX01FTV9SRUFEICgweDQwMDAwMDAw
KQ0KICAgICAgSU1BR0VfU0NOX01FTV9XUklURSAoMHg4MDAwMDAwMCkNCiAgICBdDQogIH0NCl0N
ClJlbG9jYXRpb25zIFsNCl0NClVud2luZEluZm9ybWF0aW9uIFsNCl0NClN5bWJvbHMgWw0KXQ0K
DQo=

