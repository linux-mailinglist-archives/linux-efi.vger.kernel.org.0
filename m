Return-Path: <linux-efi+bounces-1442-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3E093380C
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 09:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC332816C3
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 07:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2311862A;
	Wed, 17 Jul 2024 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="I280gY8W"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF5317577;
	Wed, 17 Jul 2024 07:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721201612; cv=fail; b=mBr2WU9JgmrYelkaboVgskyM/2Dc54YK6SGbpz2T1DrK6jutJmVdgOm12zmlbF43YXa+jNFXQCN3wxRJ/PBYdprPNtkcd4gLW02tXf/Uyqea9JsevkOFU9b1Ljq7TN7+HF5if7qLTPsK1qbZp4K4FedwHUUHJEMvpGGuSWAbTdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721201612; c=relaxed/simple;
	bh=wrT2QHSTK7EfG4xMSLYPsWCcugrKDb2Dp0qJeakpNQM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=A8CX4EUTT6RUkJU1iKk8TMOQtdZeSYdgFhIwa6xEhEPDQIxGfjbe+NPzzaYtiQoU3GzTlZvQizZ9tlwJOYMiY2C7t86oXyjHRH93bunjy/LOpwtpOV0/HralkChMpw56rF1GQHNpSNPQ5Tldj2PuapUjxBLDiBkymMB4/achkpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=Dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=I280gY8W; arc=fail smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=Dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H18t8l029220;
	Wed, 17 Jul 2024 03:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from
	:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=smtpout1; bh=wPxfyjZD
	he/SCI+SAJNeYunYTHRr1iL6It/QQoGJ9nA=; b=I280gY8W+D14fF8kJKYwtgCo
	1H2U06uq01j5maW6SPPMO0qxIPUsz8eiQSnWN63fZdeEHaylnHks9OaV5BnHN9kX
	Ta3qxHBm+kgOgaaHX1zI1Wtt0ioxd/r160OmOkbk1sXNfK+V9ZgVjbX7NANqWqpH
	0nL3uIaMIa9/KOF3bv08Ztp+C04Fho7gAxaITifMc9xO/3ktRm91G5R7SUgqdtGP
	Oo2bk/ZyTvPrn3pfzcPpNrTfIQ+lJFm4noUZ6ptqYhBaVaac5KqhXeZnS1JiKxKN
	r4vMftp6auKMS230pzcSkp9acKA6K8ZQFr9k8CVpcyVVLDlFP01ciLCKr37WAw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 40dwfp311y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 03:33:13 -0400 (EDT)
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 46H7RwcU037904;
	Wed, 17 Jul 2024 03:33:13 -0400
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 40e9kf02mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 03:33:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjkIvffwgG3CHmt1lhHNtdk5ifk7WwW2KzqWWCvNNtD/QNG0DijhBV0/7kRpjRDvDCK6YaWL+AhtQvkSf2B/jVpoeSFCXdpwWEg46C1gqu7Hjf3r8Zt3u2thdA/8ixKpqpMv965T420WF9RPANQ9Z5aVbSg1rPjvLmLhrqP14vqq+BJmK6T8hrF62IUdDrbRsU+Pu4KIC+H2uPNXmcmimTQdTiLVlom278e5PIACZZxJ39/qYD5TfOitekI4UBxiu+tR/iVoFymG6gGzTHTxC+GobKr5Bm6yh0dCRgNuLsSGvM1kt3DBNKvcKxXjOvwPzCUX7ri0d5NbxGmO1rgWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPxfyjZDhe/SCI+SAJNeYunYTHRr1iL6It/QQoGJ9nA=;
 b=h8ONwCSrF1AEZzXyOGowO0SG/TSu+6Gi+/B4splY8u3y2hq+x0C+J0r30M1QDodP3pZrUWcSuaAGBSMrXIY8GEOEQPEcAaIQBatQZa5rAfXnfNMI3OZs2fDHPUQqUhBgoK0/KbqRCSA0xYhHWRqXQTAyjxlQJaYIKe499li3hfEpBxEQXpYfSy3AM1tkdcf4Iy6Y/Eh4RlB/zCIr5+eHIpFjnJpi+xObjS9gzu3Hdkzo7jOMFDXsxM3y+AP1jikFiuDE4GyYnrZFtb1jCsQI3NHCoaCJVDX8NtCAYjCSg0wBayRVmAyuF4ZCX4HC3vDX5k+g+0orUFNWC0euSfHu7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DS7PR19MB5709.namprd19.prod.outlook.com (2603:10b6:8:70::15) by
 PH8PR19MB6881.namprd19.prod.outlook.com (2603:10b6:510:1bd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Wed, 17 Jul
 2024 07:33:09 +0000
Received: from DS7PR19MB5709.namprd19.prod.outlook.com
 ([fe80::3d06:d879:7717:36e0]) by DS7PR19MB5709.namprd19.prod.outlook.com
 ([fe80::3d06:d879:7717:36e0%5]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 07:33:08 +0000
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
CC: "Mishra, Ashish" <Ashish.Mishra4@dell.com>,
        "Dion, Christopher"
	<Christopher.Dion@dell.com>,
        "Caisse, Joe" <Joe.Caisse@dell.com>,
        "Chia, Jia
 Yuan" <JiaYuan.Chia@dell.com>,
        "Mukundan, Govind" <Govind.Mukundan@dell.com>
Subject: [Patch] Do not clear BSS region in x86 stub
Thread-Topic: [Patch] Do not clear BSS region in x86 stub
Thread-Index: AdrYGyaFCseU4QE3SCibBf0Ev6R9+w==
Date: Wed, 17 Jul 2024 07:33:08 +0000
Message-ID: 
 <DS7PR19MB570996A580C6F5D2C9CACCE48BA32@DS7PR19MB5709.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=37d26f2c-3fd7-48a6-ba05-08288b1c2997;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2024-07-17T07:28:18Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR19MB5709:EE_|PH8PR19MB6881:EE_
x-ms-office365-filtering-correlation-id: 78bdf296-d3a6-4fa8-5b06-08dca632b4a9
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?vBBoP6Qa8Kjz1+CSFl2kiJ8Ibc1IBuuCHG0/I6e3UvWo/ZtWhOGOVot3bm1p?=
 =?us-ascii?Q?fRR4mgR8Ndm/dEUW7RigXN8z585vgxGBZ2TNJ23SV7h4pcduKBMfvXZRQKuQ?=
 =?us-ascii?Q?59ZG1f+rdGhf+Pj4xOBt+yQcBKdfwIuyD2A7kdDwZ3cbAhFg9v0gkug5/sek?=
 =?us-ascii?Q?qkz//MC1aMLjAYuENFOVTiFvPQhUP5iXiocjY91N0mw0Gz1hFY+f/sQzEzds?=
 =?us-ascii?Q?E59sRcW13JDr1ytnEA/2MrFuBjfgA5RWRvw+KE9kegIES12cJP322MCB8/NN?=
 =?us-ascii?Q?pJmAgsTL4olm6lMuS4x2c7JHPFgcasktIvCzWLcjIbqi4MUPlp1OfXCem9x5?=
 =?us-ascii?Q?b3xqO7f1kefEh5Ov/Gx1iPYl7yKsj91BB8GmqSgPiVTGD2sWVzOzuDmzdCEr?=
 =?us-ascii?Q?gIQgAAA6aY9GsZPHpICnhQDeV2bo6gWYnrMEVPv+UdkM5CJuqjzFoVtbFryO?=
 =?us-ascii?Q?/+ezlDsPGZdnhL9NPtUjOIta/KIHrA0ev62Zs0v88A2BHt/HqdZo4pjk2PO7?=
 =?us-ascii?Q?ljtyzImLKqhAGH4CmOIpCCam/OuHedVpeJU+iu/UXLf6ql1EEf7iqk7CU5Bs?=
 =?us-ascii?Q?1scc3bE8WT9MdeXDxPNl0vqD27J6nKSglrOoan4WmUnj3rst3xr+MDHrICBT?=
 =?us-ascii?Q?3uSYVlS31hGhtG0QeZWyy3fRuo+SQA+Bx7gnxXrxEA4jO9I2vujn1I56b/A8?=
 =?us-ascii?Q?R+s2dLmLCvKH0t5E9BxfOpdFWttH6J6uTCNz56M3IigJJxJJdhxJqH+a19ou?=
 =?us-ascii?Q?yFEP1b4f7j8jiR7ooEEA+SSJsdSO879wzXKx8up/WdhA2Yf15XuzTfeTOHxl?=
 =?us-ascii?Q?DkzGN2qX0APlAgTtDWxRhvvu66Syn88o87+7RdsVSJquVmVELlNX05aE1Bs2?=
 =?us-ascii?Q?CqjFInXztJQguIoRP4ZZCkP8nx/EDPZdS+vo3OT31dFHK0ezkf4dQqK2MGCO?=
 =?us-ascii?Q?ZkXXCPQ19u9wUoqJ+z68ZZZGaIsNlcoxT6sGHgirk+3Ch8bqCcnkjKUCfyEl?=
 =?us-ascii?Q?3tK3+lKrryWgk4VF4+QnVR2Wf6UXZvwxeKroAzJyg7tTfbqPOykYiryhIc4s?=
 =?us-ascii?Q?2vUpaolI2O/0vai1D2JIjCx8DcO5xCSqRWZwHatgqMmNgxbTbSkn+3CoH1kE?=
 =?us-ascii?Q?29Yj6/bjqLMepmJ2QVNA15oMeeOcS6YBPh+tgvyDkN/VkG48y767qJIiArLg?=
 =?us-ascii?Q?el18VYc/i1SQCERreiZS8b3pxf1WSl6CxJCPqmxJE+BkdclRVFuqTRU6XNdm?=
 =?us-ascii?Q?NayIa+D+3N7FJNGsC5AEFKGBVuHxs3/gy2CBc4DePZSFDQqsisLviyL7pKO2?=
 =?us-ascii?Q?Y2IwBI+s0DzxzGWindHhFB/8GGEmZKa+XO0aEu1D0LpcxcgEy2T0p8fjAeRq?=
 =?us-ascii?Q?OUES6l7q6a9Ftf8qePEE32pd1GIvJjWyfoWezThnSgGoLEAEog=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5709.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?A/wmB0Hi8B9sqSYyrIdh0Ce3mdayOQKr7migiBJaOsp+qrNZAscBYxlp+ihi?=
 =?us-ascii?Q?sObLzS8i36BF8AVY0XmCciU0NJ9UbDFs/kkrfdDxh1Tg1Dlq8W4psac/CVIY?=
 =?us-ascii?Q?4xKLdjMPTLcfIcEs+IHgCHjSHFwiMuzg3IOZsy3ltaf7Zc8gaoDiA21f+x1w?=
 =?us-ascii?Q?6frOpFW94Bf05deNaXweBD290AALkj/epl0iDQIJyAnw23aear+/Y5cCREhf?=
 =?us-ascii?Q?s3jamUu0SZWeJWtjH9cBtZn1MIoIfKbXgdh/9XviROLLxlXA4z5oiV3536x5?=
 =?us-ascii?Q?4SCQlEyLbTkhqo9Wp7uq5ZuBbBjJudiyuFx85cwmFrIGjNKe4b3aPEECTf5S?=
 =?us-ascii?Q?WdRLHswaqci0onwCPxK4QXpVoPe79tCMNDrKbLNs1kyU1fiD6mFlPEAGRiRO?=
 =?us-ascii?Q?x9d+Jw1L9wDkwoPR9+2qsAV+b3BPoODOd5G531aOHTHo+Yb+x/J4UoRspyOv?=
 =?us-ascii?Q?4uTX4MaR6QAT/lvlAa2NCs5D8pEG1DJSJdhgLZaTNtUptOT1V1ZDGpJYLga3?=
 =?us-ascii?Q?bR4Qw15kjuhbts8xvcUYLLTnIsxZhgebBkTxSqE0uuTQQOVL1ZROzoLNmLjX?=
 =?us-ascii?Q?TalSyV6gyqOvIlJ/4oBmmw45Oe721is0Ki6X3d5HvNjPnJeeeg910nPg8eBN?=
 =?us-ascii?Q?QSaGxPEYtDqd/UL11MDnMIYX616m37Yq+p/p/rrbJMH+RmrMFYHZp2ozKo6G?=
 =?us-ascii?Q?hgeJv3G7F0WUdWsmmC35YxcDmqA037r9H41BVBdiea7uv9MUqckKFpbdBWfl?=
 =?us-ascii?Q?EcOJYlPIzkHlEOR8OaoJLrkVyKO1qw6YebWIWYwrOb2Y5qiopEFpcKL8FFC3?=
 =?us-ascii?Q?6Hjmh7gDIzaeMESDsenuNkTXNTbjFEVXFBV7OoWThYh/mZfLnPeU9x5iXObM?=
 =?us-ascii?Q?/sk+wd8sF99a6ytTUsoWqDdQqcaX1QBETmltFvkFM7Hy/Ic5gZyynJUOdCRw?=
 =?us-ascii?Q?B2VUOq9o3U02NB4Blmd6gk+pp6Si4eAjm8OPni2Y66dN4EuSmz17d7PUoHRp?=
 =?us-ascii?Q?YZCi6FzYxech4X2liVvB24J0khLGPdHEmv7FXgtRwTbuFLFpCKlIsIx3sf0d?=
 =?us-ascii?Q?OAhm7vQQMaRLYGPs2XUHG5Bp1Ez0Ro//hpzqds3TkpOfwT9R2xKq7cDxr6c5?=
 =?us-ascii?Q?QWWTK4U8JzIrUC7n5Y5PUlWd/q19nonGwYQxOU+0DEwJTiZ5OeS4UPAarP8W?=
 =?us-ascii?Q?zEDW+oWEOBywZkqL5YWySFcagz52zADqAMg8FiprVbF5Nkl8zeXjFS6ki+9B?=
 =?us-ascii?Q?Jsn4TdUB2+/UpOaagMirsNiFfabcHwt5ZQ98ph61eYqBd+DhcGGhTZeiLNqc?=
 =?us-ascii?Q?CK7OvAJ+f2eoVd43NyFVnQuZmll6sEXf8wy7BfQjqFhSsOMzlr64v6YXFrTl?=
 =?us-ascii?Q?uqKuKa6m+7lT9ddChUnX8iZ0nNlB673kZtIkTNGqrRnYQW5VNovlbKl2GGWS?=
 =?us-ascii?Q?uUu8+5kMfWydKx/L7P+DgcQG9j9ZDzng/WHJZ1u9oXgxYb3Sgv7jaa9j35T5?=
 =?us-ascii?Q?1jOknJ59SrQOZa1T77DqUXP1cm0pk7J4P11HwFNbmed3He1EauBRyYuqEGUy?=
 =?us-ascii?Q?74EI97Uf9ucWT6NB/qmIWr7dbq0BqSvJa9mDOV7m?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 78bdf296-d3a6-4fa8-5b06-08dca632b4a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 07:33:08.9268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y7fiimgLfj3i/1sl4eqMbU9ubFu5ZE/yjY+Lis19dk5/iTluU2uEcAmUBm9DTRl2kbR9/WM/sAFzTV8l7ggn0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB6881
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_04,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407170056
X-Proofpoint-ORIG-GUID: -1J0Cxvsdn4O-tE5MW42mqbilEKr0ZOx
X-Proofpoint-GUID: -1J0Cxvsdn4O-tE5MW42mqbilEKr0ZOx
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407170056

From: Marshall Shao <marshall.shao@dell.com>

Clearing the BSS region may cause the UEFI firmware to malfunction
during boot.

When booting the kernel from an older firmware version that has TPM
enabled and the MemoryOverwriteRequestControl bit set to 1, the
firmware's boot service might encounter an exception if it attempts
to initialize the BSS region within the x86 stub.

To circumvent the firmware exception, it is advisable to enlarge the
BOOT_STACK_SIZE and to perform the initialization of static variables
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
-       if (!free_mem_ptr) {
-               free_mem_ptr     =3D (unsigned long)boot_heap;
-               free_mem_end_ptr =3D (unsigned long)boot_heap + sizeof(boot=
_heap);
-       }
+       free_mem_ptr     =3D (unsigned long)boot_heap;
+       free_mem_end_ptr =3D (unsigned long)boot_heap + sizeof(boot_heap);
+       malloc_ptr =3D free_mem_ptr;

        if (__decompress(input_data, input_len, NULL, NULL, outbuf, output_=
len,
                         NULL, error) < 0)
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 3e5b111e619d..312bc87ab027 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -33,7 +33,7 @@
 #endif

 #ifdef CONFIG_X86_64
-# define BOOT_STACK_SIZE       0x4000
+# define BOOT_STACK_SIZE       0x10000

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

-extern char _bss[], _ebss[];

 const efi_system_table_t *efi_system_table;
 const efi_dxe_services_table_t *efi_dxe_table;
@@ -476,9 +475,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
        efi_status_t status;
        char *cmdline_ptr;

-       if (efi_is_native())
-               memset(_bss, 0, _ebss - _bss);
-
        efi_system_table =3D sys_table_arg;

        /* Check if we were booted by the EFI firmware */
@@ -1000,7 +996,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 void efi_handover_entry(efi_handle_t handle, efi_system_table_t *sys_table=
_arg,
                        struct boot_params *boot_params)
 {
-       memset(_bss, 0, _ebss - _bss);
        efi_stub_entry(handle, sys_table_arg, boot_params);
 }

--
2.34.1


Internal Use - Confidential

