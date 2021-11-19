Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1815A456848
	for <lists+linux-efi@lfdr.de>; Fri, 19 Nov 2021 03:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhKSCxj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Nov 2021 21:53:39 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:41040 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230059AbhKSCxi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Nov 2021 21:53:38 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AJ2QbPF019316;
        Fri, 19 Nov 2021 02:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pwMqgUTNlMwxQDQCxlGP2x07zuezjnWAAKy4Aehwk50=;
 b=InqYB9sdNT/xo/LWchGKUwoxSIYTkoRqtgFIjxBiwCAu0u8NK3smNryKco1dhy0y8bCy
 6C+HBJhb/7U0PYU49R3ZAn22k+GLc3MoiG+X7kMPQ0VdyQyLyiPolx1sFKkIJJ7Avdvf
 QpNnLdjkW95MgCm0wJjmsmOKFGPARlHpm+ucPWlpnZwLSaleI4tBy+Q5e+gImN4plPrH
 y2MA0F2pkzi63CLh9r0BGlrOZnPBIIS+YECRGPrDLT6/Nus2gs6qNcIfuGN6wRp5Rky1
 D/U7iIeC831ApqZw/lZFViYwqnUjgEQo6zIA692/8iwj5sxxHPepaEB/vEK/M9K1i+tD ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd2w93bja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Nov 2021 02:50:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AJ2kaXq117278;
        Fri, 19 Nov 2021 02:50:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3030.oracle.com with ESMTP id 3ccccssvaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Nov 2021 02:50:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOSX51gnROGKIaiH3WRlDMWaUOB3hYTf+xsQdwHsGjsi6OLPrqVlAuGEMcWq30EnbxFlaS8VoVNQwHOs1V0gb1fRnN5cfmZTVMiuQ3gNMuI6/YmNCzWC9gxZIG3XiaaBUjpPLvPqYiBWfIrdtETZ4g0grE1onmOvjHl5l1f6UdvABiqzTK0+qjNrKRoKdZrtALyDCdC8D9yP6FcGN7HVirCfGxmKxb9LxRg5IjJ7CX1B/u3TI7c8Kx6ZwzQPJBhuCwODfgWGo4G79IjDcrleCLwaxLDS8SUWUmhM/hpgWcTOvMKQi+uXRW8glNlfEChcrsH5IQNaS/LYPtj0qCPiaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwMqgUTNlMwxQDQCxlGP2x07zuezjnWAAKy4Aehwk50=;
 b=B68zIyXMw6Cwmx2zbPPdGh2fb8eZwZkExK724ljkUpYeBrlfZKcqNh1h9N10SSdgh4vNonnDdRNneKxp3YD3OYX2eXhW+p3fg2kHefEszc/EYBNM2vhNTm4hQHPwYkkCuWuS9MFmlregmY4bqLWLzv90n+LEpvQXaNBaxt02mlDLtry1/4bdriWlAEbQmpV6lZjJE3ng7BtidqR3sn4q5gVTD2vFPiTxCXEi+bUsusFR+f+6D3xjujf4ImrXi5CXO0QpNV7GomkfsEQHD1HoLC8dwbXzQKJAR/cjM7bUZLGb8EfTNJIJQSDv+b5dIdzXq3NQ0nwzsBSVkxMbNyuS2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwMqgUTNlMwxQDQCxlGP2x07zuezjnWAAKy4Aehwk50=;
 b=cCoSAa1puyJK4yT4zr6nGzamGyVknrSWIe7yM13MYF52E/FEO1Ygg6hmU3rZyhYrnfU3UryGRrHtjTS+6Xh6HEe4vxaFi56Q58vUl1qrpi5DDVIRDf5flqrTh7VRyW0N/uv+mruHKtcJb5qzJb/YKxUdbwe5jUS7IANOWMQNdQI=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB4954.namprd10.prod.outlook.com (2603:10b6:610:ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Fri, 19 Nov
 2021 02:50:11 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4713.021; Fri, 19 Nov 2021
 02:50:11 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "nramas@linux.microsoft.com" <nramas@linux.microsoft.com>,
        "lszubowi@redhat.com" <lszubowi@redhat.com>,
        "jason@zx2c4.com" <jason@zx2c4.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "pjones@redhat.com" <pjones@redhat.com>,
        Konrad Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v7 11/17] KEYS: Introduce link restriction for machine
 keys
Thread-Topic: [PATCH v7 11/17] KEYS: Introduce link restriction for machine
 keys
Thread-Index: AQHX2n86aqCce8ZTIUCo0lA3thol4awKAWkAgAAp6wA=
Date:   Fri, 19 Nov 2021 02:50:11 +0000
Message-ID: <FEEBC8B5-EF20-41A7-9883-018C6B25C6B6@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
 <20211116001545.2639333-12-eric.snowberg@oracle.com>
 <f1007bba5daa81d6abdb89fffa6237b54d1ad496.camel@linux.ibm.com>
In-Reply-To: <f1007bba5daa81d6abdb89fffa6237b54d1ad496.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79ea79c9-971d-4d68-ecd1-08d9ab074e39
x-ms-traffictypediagnostic: CH0PR10MB4954:
x-microsoft-antispam-prvs: <CH0PR10MB495433FC108158335CA613F7879C9@CH0PR10MB4954.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3RccSCo4eue3ye2IeZP/FIsPj1KeiXAZKB+TW7pI2Ytho0wouzIeNC/54NQbnAZmSoyWEdy/OqdM4kWMMuWayngU8bePTa0IRJm2qcxLstmUlYaABV8MHaWxB0Zn4dP0ZVfqGz8AE5CTBV+n4mD4U44w0SB99AOncz66RH5GlbCEaVnUL+yEYXeYY+MhgaQEL7vB/wcyZzVA1bgw4VQm+OhG93UtH3Dyv/qNXV7HDfquFHpqttj2XnL/7BG3S/s8TFbNWeTAgNbfZPZ889+QWPPlIg7ezwUFmlgz2Menx8Y1kGwKbmqc717A2SLPDRaD+vc08G9W4qJdnDu5TEWFjnrJe8QB1s1mSSWgGoIRK1E9zCtlg8Ene2ywa2TB5xTDotH3+dWViIGsy453koC4SXNByUCfetO/jxBDwPRx4yhyxKitO2U4kccM/8tKYHb71yrTHSZ6/6CMoJkWc+FIi67UzpcHp89pOFf1v05j/5KrP4+IFmGChST2uMzxl/oV5OdJpFWjGhmxiNBvh8zLxHLYOqVp9gdgatOe0WrdiRGhL1GQZ8Zy5+7Dgki3EXUdlZXe2gl1MxQqnIpSCSDYjc7Czav43vth8rdHKy0pFXOvRs/P4ZdiZLO6f9oR+4ZYYQWebObH1I/DfIJ579dzlTPQ2PTOT9a807l7pqHP7TNlw2ENJxsdC+yO8zhBWwjOJggtS9dntEP8pUqnOIO8CjGurja9RxpsPyb9QUtelZpyOhKVvpmAM6SUJ02Hy5Bb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(2616005)(8936002)(33656002)(316002)(508600001)(38100700002)(4326008)(7416002)(66946007)(71200400001)(66446008)(38070700005)(76116006)(4001150100001)(54906003)(107886003)(64756008)(44832011)(66476007)(6506007)(186003)(122000001)(6916009)(86362001)(66556008)(6512007)(2906002)(36756003)(53546011)(8676002)(6486002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlloU3FCYVQrUldjTjExa1BrK1RlZ0JackRPYWptSURFUUFnSVRHWU9TeFNx?=
 =?utf-8?B?SWNLdnZldTB1UFV3UmVUWnBIYmtvYUlDeXpCZXFRZTV4NmFSdnVjT09oMVZK?=
 =?utf-8?B?Tkw4djZVY2RpcmlsQSt3bDZIUVZTM1VvL1N2alFxN3BBZlc1R1VPMlZ5YUVo?=
 =?utf-8?B?UW5hSjhPOU5FUS9ESE9aY2JMM3dLVUx6cUdUT2RtZ1NuMkxBdU1MMzJ0RDRK?=
 =?utf-8?B?eEIwTkluY0h6ekFUV1NkOEc5d0FDbFJoMVdSNjdKbVh4bXR3a2JTZ2k3cGFm?=
 =?utf-8?B?K1pPSkFBWElCVDU0a29JdEFLYWRBZ0p0ZVU1NlV6TEtSajlWalhpcnYvY2Zw?=
 =?utf-8?B?ekV6bzV3YVU4cXhodyttb0JiZHd0MGYwbmpyU2VFaUhYZnVNK0MvNDFTaExo?=
 =?utf-8?B?SmZSRi8xVXV5Ukg1d1NLenErLzFPK256aU9QUWdteWgzb2lqMTJKUXlFaTBP?=
 =?utf-8?B?ZTVEbkxhTmxQblNXYlBjWnFTc3Jtb0RmOU1kbHNVUTJRQW1aaWZtOG9jamx2?=
 =?utf-8?B?bk9sTXJyazBBbUQwQUQvVHZnbXdoY2tsT2ZKbWxWUW8vU0NPbzU2ZVR3amxl?=
 =?utf-8?B?TmhxTlF1V1ZSMUVvejRsQ21jM1RiN3ljVlhVbjVBeGFRcXVSYUtvN0tFZkhX?=
 =?utf-8?B?K2dWTGlvTmJzVExUY2NiMk9zT05EUUxzWjMrSWVzeHh6RGVadUtzVFNYVU5t?=
 =?utf-8?B?V3dnMTJCQytwcWtPN3Nvb3FiRnZxL3l6Q2Q4OWhIWFJzcFV0bWRMbFBoQlRO?=
 =?utf-8?B?MUpLVEVpSXpnWTcxVlNJZ1pwMEk5Mng5TlJlektvZy9XR3M2SHVFTzNxbE1T?=
 =?utf-8?B?d1RnTkRRS2NLMUMrVWZaLzJCNnZYdGN6WVFjT2JSYStzOWtQTHU3T3U4cEl6?=
 =?utf-8?B?cm1GQlhXSzhpd1VaazVMMzRESG91Rkx6VjhnSlp5cFR6YldKejZlc1QyUldU?=
 =?utf-8?B?NlhRUmJSU1l6ZWNSWGs5RjZJSkRzdkVuVWpzcVF4MHZkbUFCdlB0NVdWTmFS?=
 =?utf-8?B?YU9jT2FkN09YbnB2ajlleUpzb0lYRmJ5NC9wWE51bHlWQzUrVlN0RmdDUkFq?=
 =?utf-8?B?ckg2Z0greDVzSUxCM2xCS1pmVW16YUhleS8rQ1ZyaDdrVk01YmZ6QmxqNCtG?=
 =?utf-8?B?RE5BVWQycnQ5Mjd2UlM1YnRaRnlpb1VSOGtOODg1RS9RRVAraDFSZ1J3QXEy?=
 =?utf-8?B?SlZ2bVJ2TFRBLytUblNpNkVLYmZvSDFQRHM1V3dxVnRZQWl1NXkyM0hnVy9G?=
 =?utf-8?B?YS8zNjBKN2ZLUTBRekNDdUZxR2ppaDZ3TERra1ZPOWQxT1FtN2hSM3B4ZDN3?=
 =?utf-8?B?WGxlZm5PQkM0Qm9WM1Q3T28wNE03K2xaZkFMRXBBRnlxS01neVp5aEJtWjd0?=
 =?utf-8?B?VWQyTklXODBVREF4Y1pHK0Y2d0RRY3g2ZkN3dUUyNmtIdWsvSHI3NXhsSWlF?=
 =?utf-8?B?cGY4dEMwRXE2Ty95TktEYTY1bjBhd0Y1empzek56NDRaUmhKL1piWGxaRmtL?=
 =?utf-8?B?Y2VKcDltS3VOaUhjOFgrN1B2bXBoMkptRnNzbDI2TjBFcFcwRG9HR0V6eTlI?=
 =?utf-8?B?NVpzUW9DaUVkTmhkZ0ExMVRxVEFGUkdEVnhoOUNOdi84RUU1bnlFbEhDbzJE?=
 =?utf-8?B?YVpNOXpBQy8zaUlRejNHaUhsdThYVTBINHBpTjJ0b20xTUxEcXRuUnBnN1Ur?=
 =?utf-8?B?K1g5VitpRWNhampzRXpTOHUrVGZ6R0pDdGVoMGNVdVJVUU55TGxqVjZ5ellU?=
 =?utf-8?B?NWV3RFkxbkhzb1c3NUhsTU5XVEpBY01DaVVQdjdQQkJtb1BZQWVkeFVteEZD?=
 =?utf-8?B?eHdhaFBKb1VGT09HeXFOM05NcHJwWWxDZVNjeFp1VnBBV2d5SFpublU4RmJX?=
 =?utf-8?B?ZjlvR1p0QzRURXZxMDJyMkg3SEdhYStPUXFJd3kzRXdhdFF2ekxRSjFLUjNX?=
 =?utf-8?B?QUNUTmNsZEtVUTNoWDljb3Z1UUVvMGtHRllCY3pSMVBQNitib282WWZsR0lr?=
 =?utf-8?B?S1pDbXp3R05Ic3pCazQ0N1JBcEZkZEZ2NVh2UW9GSjdacGt3blVDc0VucVJL?=
 =?utf-8?B?S0t2UW5wK0Irdkc1SVlqZ1YwQVIyVXMrVE9GT1BMd3lXYVkwaFlvUC94VFBL?=
 =?utf-8?B?UUZnTkZiL1VFVWdvek9LQUZna1E0MzFqYmhkcmJPU01nN0Vidk9lMmkzVE5N?=
 =?utf-8?B?Snprd3J6S2Zta2FvbFFSQUIyQVRpT3RRR2drOC93L2RkN2dnR3c4UWREOU4x?=
 =?utf-8?B?dEhUMTI2UUxhMVI1L3llOFJQS2hyMExsUDV6VE50YnVDdmRUR3FzMWh5cDdE?=
 =?utf-8?Q?bejn61oRiWHoUK0an6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5D2EB41AB5673498FE32004D0A5D313@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ea79c9-971d-4d68-ecd1-08d9ab074e39
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2021 02:50:11.2855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+E0eTvjuoMJh6gPjK8BRD7Tzy8n6gEn61kiH7qOAXqddadWrqzaH+wMAF2+czXL3479P8RP5wPcPwVEGu2UNmlozt8FG9nt+hXewtGYECg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4954
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10172 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111190011
X-Proofpoint-GUID: cZdhJPyxecjB9bzU1MqbjlI9L9vBaCRa
X-Proofpoint-ORIG-GUID: cZdhJPyxecjB9bzU1MqbjlI9L9vBaCRa
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCj4gT24gTm92IDE4LCAyMDIxLCBhdCA1OjIwIFBNLCBNaW1pIFpvaGFyIDx6b2hhckBsaW51
eC5pYm0uY29tPiB3cm90ZToNCj4gDQo+IEhpIEVyaWMsDQo+IA0KPiBPbiBNb24sIDIwMjEtMTEt
MTUgYXQgMTk6MTUgLTA1MDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+PiBJbnRyb2R1Y2UgYSBu
ZXcgbGluayByZXN0cmljdGlvbiB0aGF0IGluY2x1ZGVzIHRoZSB0cnVzdGVkIGJ1aWx0aW4sDQo+
PiBzZWNvbmRhcnkgYW5kIG1hY2hpbmUga2V5cy4gVGhlIHJlc3RyaWN0aW9uIGlzIGJhc2VkIG9u
IHRoZSBrZXkgdG8gYmUNCj4+IGFkZGVkIGJlaW5nIHZvdWNoZWQgZm9yIGJ5IGEga2V5IGluIGFu
eSBvZiB0aGVzZSB0aHJlZSBrZXlyaW5ncy4NCj4+IA0KPj4gU3VnZ2VzdGVkLWJ5OiBNaW1pIFpv
aGFyIDx6b2hhckBsaW51eC5pYm0uY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogRXJpYyBTbm93YmVy
ZyA8ZXJpYy5zbm93YmVyZ0BvcmFjbGUuY29tPg0KPj4gLS0tDQo+PiB2MzogSW5pdGlhbCB2ZXJz
aW9uDQo+PiB2NDogbW92ZWQgY29kZSB1bmRlciBDT05GSUdfSU5URUdSSVRZX01PS19LRVlSSU5H
DQo+PiB2NTogUmVuYW1lIHRvIG1hY2hpbmUga2V5cmluZw0KPj4gdjY6IENoYW5nZSBzdWJqZWN0
IG5hbWUgKHN1Z2dlc3RlZCBieSBNaW1pKQ0KPj4gICAgUmVuYW1lIHJlc3RyaWN0X2xpbmtfYnlf
YnVpbHRpbl9zZWNvbmRhcnlfYW5kX2NhX3RydXN0ZWQNCj4+ICAgICAgdG8gcmVzdHJpY3RfbGlu
a19ieV9idWlsdGluX3NlY29uZGFyeV9hbmRfbWFjaGluZSAoc3VnZ2VzdGVkIGJ5DQo+PiAgICAg
IE1pbWkpDQo+PiB2NzogVW5tb2RpZmllZCBmcm9tIHY2DQo+PiAtLS0NCj4+IGNlcnRzL3N5c3Rl
bV9rZXlyaW5nLmMgICAgICAgIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysNCj4+IGluY2x1
ZGUva2V5cy9zeXN0ZW1fa2V5cmluZy5oIHwgIDYgKysrKysrDQo+PiAyIGZpbGVzIGNoYW5nZWQs
IDI5IGluc2VydGlvbnMoKykNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2NlcnRzL3N5c3RlbV9rZXly
aW5nLmMgYi9jZXJ0cy9zeXN0ZW1fa2V5cmluZy5jDQo+PiBpbmRleCBiYzdlNDRmYzgyYzIuLjcx
YTAwYWRkOTgwNSAxMDA2NDQNCj4+IC0tLSBhL2NlcnRzL3N5c3RlbV9rZXlyaW5nLmMNCj4+ICsr
KyBiL2NlcnRzL3N5c3RlbV9rZXlyaW5nLmMNCj4+IEBAIC05OSw2ICs5OSwyOSBAQCB2b2lkIF9f
aW5pdCBzZXRfbWFjaGluZV90cnVzdGVkX2tleXMoc3RydWN0IGtleSAqa2V5cmluZykNCj4+IHsN
Cj4+IAltYWNoaW5lX3RydXN0ZWRfa2V5cyA9IGtleXJpbmc7DQo+PiB9DQo+PiArDQo+PiArLyoq
DQo+IA0KPiBUaGlzIGJlZ2lucyB0aGUgc3RhcnQgb2Yga2VybmVsIGRvYy4gDQo+IA0KPj4gKyAq
IHJlc3RyaWN0X2xpbmtfYnlfYnVpbHRpbl9zZWNvbmRhcnlfYW5kX21hY2hpbmUNCj4gDQo+IE1p
c3NpbmcgYXJlIHRoZSBwYXJhbWV0ZXIgZGVmaW50aW9ucy4gIFBsZWFzZSByZWZlciB0bw0KPiBE
b2N1bWVudGF0aW9uL2RvYy1ndWlkZS9rZXJuZWwtZG9jLnJzdCBmb3IgZGV0YWlscy4NCg0KSeKA
mWxsIGFkZCB0aGlzIGluIHRoZSBuZXh0IHJvdW5kLCB0aGFua3MuDQoNCg==
