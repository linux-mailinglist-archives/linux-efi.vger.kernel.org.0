Return-Path: <linux-efi+bounces-1481-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2C093AABA
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jul 2024 03:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8231F226BB
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jul 2024 01:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1285733FD;
	Wed, 24 Jul 2024 01:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="B0v1HhUc"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFA24C6D;
	Wed, 24 Jul 2024 01:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721785771; cv=fail; b=Zjb8dZHS2xkWopL2o8EgVafwW5EREdSaR/Z3s9JLFa/ooG+iy4bhmHRW368gXgTMmnye200lR6Qgqxfqx7GBCcAkrCm1Mk33nQK+9T3Z7YreKniUiPH4H8FFnnYF+qqboyWadtPw2eDrrmXU5OoCtjk249btSo2l9E7UsS11hlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721785771; c=relaxed/simple;
	bh=N1WmVEMq2LOb8/W8ECebcbg6LGM1KUKNc50ht+8mOb4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZjmBPu1iy0Fij231Pks13veGCNMk5wau2hZyDLmTBtqg4h9CB1r7eEBumnfRihtzffwGzWuvTvuE5OBfRJuWOmoPeAcYKbqy/DXch76yi5P+4znkSae1LdxvHWkbK/07d7KXy6UqDpngrBYSsLK/SJfLkyoHAv7SrlesteGWGic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=Dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=B0v1HhUc; arc=fail smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=Dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NNgSqb016712;
	Tue, 23 Jul 2024 21:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	smtpout1; bh=N1WmVEMq2LOb8/W8ECebcbg6LGM1KUKNc50ht+8mOb4=; b=B0v
	1HhUcPrbysN0O24g/QOVaD2R8tm8OcLiDRpq+02a6EzQvJw0YAp9LW/GXDDTD5WP
	IUyYw3F/sD+Y7eg/Tm9EFTnvwBb3RbVjacBbkwc9E8vvFSRO83BDUFNtAQ7+ux7B
	3CKlrBYqyE+Fmy1jJHRO1dW3nbF5tN1AzIie9KMZ6iDYrCK9FOjm8ABP+H5H4k4E
	yw5w1FfBrfVGGh9NmTkpwOBaLpCSilHtPK2vThDmD8SjzQb02hFF9QOIh/m8I23p
	twBpOr8AzhbUtEQgykY1zENU1Jra9F+3eBbjztn7Rh+QG0VMstQPcUQcB/mgnd4K
	TnznD8ZaaT6ubN0XUZg==
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 40g8dadfyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 21:49:10 -0400 (EDT)
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 46O1Sm4a015709;
	Tue, 23 Jul 2024 21:49:09 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 40ja12qft5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 21:49:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFCzzMJd+JIrr7yul8b3sTE2DvXYpNXT4omq7T/32skTM0UV4PIOAyBbLCT5gGQgY+hlA1hUazIrXPREIq2rsVst2HskXuDcpaM4NWdK5W+iWyL3/fw0tKxACqRdc0QgH6G0fIC3r40YR80Uf2dQWqwO2MX6mv/RZnpVhSnqeBhL0WmKs18WLR/qySKyS8JpYj+E3cNOXrLtR16G4+M0rwE/vPyX+OfWfJvJZp+jAFemPFMxncYQxU1BXPPKtZJ4fJu7sR0XgmFqqR0gYAiVBZa5KQ+ahvxBFm4U0VsD5Q+qA60mITsdpH6SJxpvOX+fRmi83Y/+sNf08BzRBSgq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1WmVEMq2LOb8/W8ECebcbg6LGM1KUKNc50ht+8mOb4=;
 b=VrBMPOoUM8ns9umqYgfUilDKArucd0In5ZxSuCTvW6xNDVXvBR5gNFPpsDjoJAk4NEYmseUGgO28IubbQe/EVCYKiwXapMLEzhPHkxQNM/oP+RzBChahYJ02E/cg5hN67LQd7utGamVpxsbM8YZwICU+J+R5oMPP0JisNa/AjsGHJ8RqF8acfBqVOtVE2C+0Po5kFprnTuaDiaQCC9cV5fkIJHuG6ASuxGOnuOuB2OWm4ULBZBz4j9sih22p+iiH0uuDcmhDDgQwXA+QoqDnSp01hwCWyVmu1ePNKM3i+aVRSL7fBsWohdL0Gn3WD+MK5ezFehC0ecZnGJqtTdQ18w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DS7PR19MB5709.namprd19.prod.outlook.com (2603:10b6:8:70::15) by
 DS7PR19MB6000.namprd19.prod.outlook.com (2603:10b6:8:83::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.20; Wed, 24 Jul 2024 01:48:52 +0000
Received: from DS7PR19MB5709.namprd19.prod.outlook.com
 ([fe80::3d06:d879:7717:36e0]) by DS7PR19MB5709.namprd19.prod.outlook.com
 ([fe80::3d06:d879:7717:36e0%5]) with mapi id 15.20.7784.016; Wed, 24 Jul 2024
 01:48:52 +0000
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
Thread-Index:
 AdrYGyaFCseU4QE3SCibBf0Ev6R9+wAQOiGAAABrtYAAlzZgQAAtv+GAAC61pjAAFgXwgAAb9bQQAAX92YAAFi3EMA==
Date: Wed, 24 Jul 2024 01:48:52 +0000
Message-ID:
 <DS7PR19MB5709AD7037E8B6BC1C7171908BAA2@DS7PR19MB5709.namprd19.prod.outlook.com>
References:
 <DS7PR19MB570996A580C6F5D2C9CACCE48BA32@DS7PR19MB5709.namprd19.prod.outlook.com>
 <DS7PR19MB5709B2A263E769B461091B0D8BA32@DS7PR19MB5709.namprd19.prod.outlook.com>
 <CAMj1kXHBSNxrzbQoaDea7HFcjN9HHk5==tXg1WLHDzW61aj4cg@mail.gmail.com>
 <DS7PR19MB5709B39C90153DAA27DA122D8BAE2@DS7PR19MB5709.namprd19.prod.outlook.com>
 <CAMj1kXHS0rr9DfKCeD-Zz7y1Bk-3ncn2cEgVmnWE0Jq1B=+Acg@mail.gmail.com>
 <DS7PR19MB570924EC5BB1BA3F321A65B98BA82@DS7PR19MB5709.namprd19.prod.outlook.com>
 <CAMj1kXFjWBpOij5V3=-9etqTW9p8guqPDCGU3DK0Yxq6zrBiBQ@mail.gmail.com>
 <DS7PR19MB57092B4012BEFBBA52E2C2748BA92@DS7PR19MB5709.namprd19.prod.outlook.com>
 <CAMj1kXEQXZc2Vpgh5JA3nCCw=LB0kjLgQoximQ4pZhcJ91iOnw@mail.gmail.com>
In-Reply-To:
 <CAMj1kXEQXZc2Vpgh5JA3nCCw=LB0kjLgQoximQ4pZhcJ91iOnw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=75adc379-3fff-4811-9d73-9913a0bf1794;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public
 No Visual
 Label;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2024-07-24T01:01:48Z;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR19MB5709:EE_|DS7PR19MB6000:EE_
x-ms-office365-filtering-correlation-id: cf717aa8-811d-4e1b-86b1-08dcab82c58a
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ajcrbzNBbjd2M0I5V01xcTlwZGlKWEhZVjNWSnhEWm4wSkp2dzZ1N1FDbDNw?=
 =?utf-8?B?c3dWWExYYTFtVmpXVzFjajIzL1Zab2tJbHlUR0pNNWhVTHlmRlQvL05wd3NE?=
 =?utf-8?B?ejlGTUhBc0RuczlaeXhDL2ZNdVhRb2JESjVzL2liS0ErNGhNK041MWpmb05Z?=
 =?utf-8?B?YjMzVU1KMEdSZWVzQlI5cExvakdXc0laR2djSjVYWEdkRFhRUmpDZ0hSQnNQ?=
 =?utf-8?B?M2RhcTU5aDhUZTFzbmRiMS9LQkl1OXBoRzg2SGw0WHNKTk5mSXEvWEFOMTQ1?=
 =?utf-8?B?RkU2K1VQYXg4OW40WG9XbFgzd0JZWnRhTDBFcGFHVGRCd3NwaDhpSnFRRmhC?=
 =?utf-8?B?c1Zaa0ErYkY5d3Z5c2V1Rk9Hb1pZclhzUEpNUGluQTNTdnVLeHpVWmpKNHF3?=
 =?utf-8?B?TDlsaFFjdEVXWC9iZzM5N254Vms5YThWWmZqZVUyem9HRTFUbURqZEduV0xR?=
 =?utf-8?B?SEZsVVdoWStFQ0RwQTM1T25xNTVKTW9MM1dDSHZVTWE0cHBzS29DNGZab1ha?=
 =?utf-8?B?Mk9ralVjNDJTc1l5cFFkNno5MG5rT0V5cWoydGhKWElxMU5LMk9tcUx2YlhW?=
 =?utf-8?B?d3RHZDV5azdkVFgvQWNpejJ4VkVEcjZiZHRBSmZ3SGVPWWloUkYxMm03K3NX?=
 =?utf-8?B?M3dMRUVhbkdzZGg5NFc5d0ZnWSthZ3FkZWFUbnAwN2JLbXh3U21aV2ZaZlQv?=
 =?utf-8?B?YWZ4bHJFaGJ2Ny9TdExoZzZENld4UlM2Q2FxVHM5cURaVWFNMVc4d1hoaWNv?=
 =?utf-8?B?L1pzWXVqOXQxSmlEZHRZVndkMzBQK2VDaW5MNUh0dnBJQno2a2YwMTkvd2pD?=
 =?utf-8?B?TzdJZnF5UjlaRnpkM01jOEZIaWNvNXFrSE9acE4yVnd4aUZtREIyczRVK0NM?=
 =?utf-8?B?SktvaS8rZEZud2xWVHF2UE0wWHFpV0wzdTh5b2RnNHAwbDhwUnZlWERxN291?=
 =?utf-8?B?U1hZSUEzQ3VXL2ZZNEJRRmZLSVZpRjM5NzRYKzV4RkdCRGZMNFcram5QSm1w?=
 =?utf-8?B?bkh3S21rUU1XR09DbXBJTnVtbHIvS3hnUU1YMnBxRDB4S0YvMERZUDJzcWFh?=
 =?utf-8?B?Rk5LSldrRm9CdVVHK1NUWHRLMkN3azJISHZXQTROVVVtdmpNNUxWd0piN0ZN?=
 =?utf-8?B?dndQRnY5cUpDNGJvRGxRUDNPTXBEcldLMEdOenhkY0d1SVV1NCsyTWFReGM0?=
 =?utf-8?B?UkNsZE1Hbm0ySUZlWkVwQ1Vxam5YZ2VQTTNpQWkxb0UzNGVJYjZTR2V3Q0lN?=
 =?utf-8?B?WjdqQWV3bXQxWlAxSTcwaDVDa1M2M1gyUjUxdzlEU3ZGeWtYS21nTFdxK2x1?=
 =?utf-8?B?TVVrS3g3OC9EQlFhMWVDa0t6ZjloQkdtcnEyOUI1WWhkaUlXRlI1T1RGUWtq?=
 =?utf-8?B?b2ZPZDBwN1R5N05ZUUx2N1dFYlM4elBCMGxIbnFVQmNPamYvOHF5UngvR3JW?=
 =?utf-8?B?cWY4a1E1SngyTmhLeXQyNFRJbW8xak90eWs2eWlxdDJrQ1VQUjg3c1VLYWky?=
 =?utf-8?B?V2x2a0lYQzFMMU1NUEF4UVFhNXBHbnR2RDFkT25PTEdBZVY3UEh4WDVEV04x?=
 =?utf-8?B?OW9ab3daVnRaVnJ1SjdsL2tWTVM4UG8wd2hBWG51WWpsTnM4N2hZWlEySnV6?=
 =?utf-8?B?Qm0xWXlCRXZpcUdBK3FyY1Y5eUswZ1hjdmZFSzF1YW1lTHNUOU5WcFArd2Uw?=
 =?utf-8?B?TDVtT1VVOE1URGRDN1hmTE5CcjhIUU5SenFFMmxKNm0weFQydHhqNjNQa0Rt?=
 =?utf-8?B?ZUhTOXUyRXNhUk9EdndaYXFaS0RPQ2tlbDkvOG4zblo2MWg3OTBPMnltV2hV?=
 =?utf-8?B?NjIvM0NyUkg5OHJjeVpuSGtuL2hheU9rNjRzVHR1SUNDQTExK0xxUDd5YU9L?=
 =?utf-8?B?K1RUVHk0OU53OElqOEpKUGpMbXZTREdmcnFveUNuZGRHZlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5709.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QlNoeWgvZXdMZUE1WFVGejBQM29TYW42QnU1OExKcFZTbW5vMUJDT0tHSkU5?=
 =?utf-8?B?eG9xbUpXSnFVVW4wdmtXTlRsTDBaaVh2WFgrMDNDOE11UDQvZUdjM0cya0FT?=
 =?utf-8?B?VmRtM2lrdTNrRUpxRUd6M3gvL1pIWXpMMXY0TVM4T1QvaVEyY2Y0UE9BUkcx?=
 =?utf-8?B?U0h4UGRRQlZZNWQ0Szdrb0ZzYW1pTVdYVklHVVlTdGFOSDFhRmIwSDZlc2VF?=
 =?utf-8?B?aXBQTDdEa1JFQ214dHZtUzNPUE16NnhiZ0xQZkxLcTBvMjgrcm9yRVpiZzl1?=
 =?utf-8?B?Y3Q4WnhkWVpJOVBYL1NrMjd0R2VnOVNJSVdUMmxrckFKK0ZLcXkwbE92blAx?=
 =?utf-8?B?Q0licXVDU2JuVkgxTk10MW5lN1NtNWg2a2tlaWtyY1NFUWdZbWI3MDJQQXJ5?=
 =?utf-8?B?UStYTDBBR1BMWWFuVHdUNE5kZXAwQ1RiRlJjKzVOY0FwQmdqYys0bHZEZWxJ?=
 =?utf-8?B?Ym5NNzZmblczbWVxNG1PSjc3cXhsRVdZbjR2eElIOUFMb09OUm5nM0labll1?=
 =?utf-8?B?MitqKzU4Vy9tb0ZJYnA0NE9QVEVXd0hocnNjNU0zeTVZd0xtekU4Yy90M1Rp?=
 =?utf-8?B?UWRiVElaZlVWb3dPWG8vM0NBZUI5U3VoUENKdytEM1h5Q1NGcDgyZ01Ua01N?=
 =?utf-8?B?VTcySTV0Mnd0NndZRFZlWkRXd0lsSElsZEZrcUZJTU9XaXpLNE1TeXFoNzcw?=
 =?utf-8?B?eGxkbEplYkdYdXhjVkhpWmxWbjN1NlAvdFh0cVNvWmFKdWRQcjg1b1RWREJP?=
 =?utf-8?B?b3Mxb21lM0xlRUdEaWNOczJoeHdpZGUvWC9DdHFHdHdxd0RWTTVjYU96R3Ur?=
 =?utf-8?B?OFNsL1k0cWR6a252VTBJNHdHeUFJWmtFMnhqTVZZYS9pSWdCRGpDWmpnUk13?=
 =?utf-8?B?aVBFMFQ5YXg1bG1TaVNGS0xIcUhpalM5SEkzUEZRZXFwTGVBWWhRQnVZRkNV?=
 =?utf-8?B?amJMQ3g2MUw4WFNOWU1XeXJJSWdxaFVqVXBJeDEzY3JtM0FKQisxeWJvczQw?=
 =?utf-8?B?QWVtZ2F2YXB0MUNUSkp1NWFTcWZNYUVDaml0TDNkY2pIWGVsbmVldXluV2RN?=
 =?utf-8?B?d3M1K1dKek1TRmhWdlVYWVErSUpKcEgvKzN6WjQyK21lRGdCR0YweUFtU25S?=
 =?utf-8?B?N3JpR2FzKzU3S3JWQjI0Q3dKMkwyQzcySzlENHVBZWRJMy91dUQ3RzlHQ0k3?=
 =?utf-8?B?WEJ0algvRlMzbFNsbGJsaDUzRVJPR3Z3VVZWdkxhODhaSWxyWk1rTWRZeVBN?=
 =?utf-8?B?UDB1azZ3K1VDbmpCTWVnT05ncW5zZ0ZNd04zdjFNbFFna3FGdENEVkNVTFJS?=
 =?utf-8?B?bG0xN3hzT2xOMk1rUGZ0cnh1eVRIejNiRi83Q05wRWZYQkoybjJRM0cwWS92?=
 =?utf-8?B?NkRnSDlMQW51WVVyUzMvV0pHRHYwUmV5YlJhVzFnb2ZZNzlhQ0pTdUNNekQw?=
 =?utf-8?B?MTc0NlNjYTN5Wjl1VndJRHA0WVZPS29TVzFhOUswbG9qdVhPaVErbFVDbU1L?=
 =?utf-8?B?b2ZVcjhKT2dMd1pUUGtZdXBaU29xVCs4UFNPUTBDeXNiN29VekVaZ3VPVWgz?=
 =?utf-8?B?amRGQkwzZXEwb0R3NTREMTFIQUdzTWFDN20vdW5QemJ1ZWtSVVprQ3U3VndN?=
 =?utf-8?B?dW9uUUFFbHNZZUUyRjNzTXdRQkloZThOcUlNcDRJakUyWXdEWXd1UjdtbGJZ?=
 =?utf-8?B?OGFMd1FZaEFsNWhGekNlV2J3VHJDYWFnUDNPWVdzbENwRzloSUlObWpaaWhU?=
 =?utf-8?B?Rmp5SGhjaEUrajRGVENTS0JURllOZFI4b0tyQndZaW1NMGxNWW82YldYMHNj?=
 =?utf-8?B?cE80cDJ4cVBHK3ZRWldzUmNLdEZqVENBZmJ2RXUrZU54eGF1ejZkRVFXTTZm?=
 =?utf-8?B?Z0QvcmtXcXRvdjBPdm9hVyswOG14b1cxQ0tJdGZHM0NLaVlFK1dpck4vQmZL?=
 =?utf-8?B?cjdUNlRRckw5SmVkcWRWNXkzQkNwUHpUUmNvMDI2bzJwMkZsZnB6Ly9IZlRu?=
 =?utf-8?B?Y2VZbStkNVdqRndReGM1dHpmT2ZRZTZQbnd1U3A3Tm1YNTRnN00zckxLQkNm?=
 =?utf-8?B?c1JzbGUyWkJVOWt3TjZMQUViUkdHVnYzaVd5dERFTFFlYkU4aEV2QWFBaEZw?=
 =?utf-8?Q?9oOA8H4017t2d95cSvs7uAklX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf717aa8-811d-4e1b-86b1-08dcab82c58a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 01:48:52.7654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NXh2yhW+Cddj1bi/6uwwHhZGM6/T6yrpBDpZ5U7xx007fHXMCIy9mqJ0mpE41JRCe7NckT34VmnyIotgib6rPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB6000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_18,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=657 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407240012
X-Proofpoint-GUID: V5ExHC5SJ22x9eKnoh8uK9h7pY4132Ki
X-Proofpoint-ORIG-GUID: V5ExHC5SJ22x9eKnoh8uK9h7pY4132Ki
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=614
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407240012

PiBDYW4geW91IGV4cGxhaW4gd2h5IHRoaXMgaXMgdGhlIGNhc2U/IHN5c3RlbWQtc3R1YiBzaG91
bGQgb25seSB1c2UgdGhlDQo+IEVGSSBoYW5kb3ZlciBwcm90b2NvbCBmb3IgdjUuOCBvciBvbGRl
ci4NCg0KQXJlIHlvdSByZWZlcnJpbmcgdG8gdGhpcyBjb21tZW50PyBJbiBzeXN0ZW1kL3NyYy9i
b290L2VmaS9saW51eC5jDQoNCj4gVGhpcyBtZXRob2Qgd29ya3MgZm9yIExpbnV4IDUuOCBhbmQg
bmV3ZXIgb24gQVJNL0FhcmNoNjQsIHg4Ni94NjhfNjQgDQo+IGFuZCBSSVNDLVYuDQoNCkkgbm90
aWNlZCB0aGF0IHRoaXMgd2FzIG5vdCBwcmVzZW50IGluIHN5c3RlbWQgdjI0OSwgdGhhdCBjb3Vs
ZCBiZSB0aGUgcmVhc29uLiANClVwZ3JhZGluZyB0aGUgc3lzdGVtZCB2ZXJzaW9uIG1heSBzb2x2
ZSB0aGUgaXNzdWUuIEkgd2lsbCBnaXZlIGl0IGEgdHJ5Lg0KDQpBbnl3YXksIHRoYW5rcyBmb3Ig
YnJpbmdpbmcgdGhlIGlzc3VlIHRvIHN5c3RlbWQncyBhdHRlbnRpb24uDQo=

