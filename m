Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD5C48F8FD
	for <lists+linux-efi@lfdr.de>; Sat, 15 Jan 2022 20:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbiAOTNX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 15 Jan 2022 14:13:23 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11100 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230216AbiAOTNW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 15 Jan 2022 14:13:22 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20FHEBuu018497;
        Sat, 15 Jan 2022 19:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=O5IIA33hZPL54dB2mPo5SF5r6pOkDmU+F4p+43zdsWw=;
 b=1M8MwERjyQar4IYlaCYCJfs75O6M3Icj2sQNWGI1p2hA9JncJFtPyqCtzfR/P3gD+DEZ
 +awgGoDjDKm22OGg/eVs94D5HyEEBrvFOHntgeDG5qOss6Pa3URsnLqZuf9RghJrihJZ
 wplf7k26Gg9jnGgUy3PcUOTlymjG6HgKrM5PJfR9+Ray4VmLSEy8Twgn1/QLwbCb6Mp+
 AJmOLMlYPPlChKaAiTWUURuL1IPTO6X2iSfMu9OPzzGfmwPN2v9jB8RGKD+6inAEuFJE
 hhQ/H7d1UIcLsfhMv7HQ/LthfgQn6sPQzBcJkI1JvCi+kH1HSjQSL6kd8ydWGqiUvDwI +Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dkpttgr5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Jan 2022 19:12:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20FJAQRf176110;
        Sat, 15 Jan 2022 19:12:38 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by userp3030.oracle.com with ESMTP id 3dkkctcxg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Jan 2022 19:12:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asSBQWWR0ULI053ne0hAIT4OYQLGnIV1SHD2X2zASp0+eSo6HqtJiDK9ch/iftq1GFsbfcjV4bocx1195vBTplnPJKK0mMhn0WMnOw7An+pxBH1hvmAwAl2rWnnYLP2S1WD9zFfMztibkyB5LmEuImbOx9TL9qpVo/SeBU7ucyeeXeV+RttbeQWhTtD4LxCV6loYp7Tb2Y5gyfNPzGfa1StTN0xhV5UbUmwTRMgsoryilRvYwM0n5KHaNhukhRp0aPjDtu4JuLcG/aR8ADJXs22TVsKSl8+/gVyYjyoB4oRlahODddGli9TbqCN+ZP1CPs48Zi/AiH8p8sRkMdIEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5IIA33hZPL54dB2mPo5SF5r6pOkDmU+F4p+43zdsWw=;
 b=RS4ZKUVHt24zu3+XbYHGJ1I2Q3H/pQADdKLnAUo77zR8BUeJbLragTHBfELjTlfGEgQQ8pMu/efCbaSwLbkV6kwk+I0QBuH+uzidW3hCAPLZLA1BySvrtCAD413crY2cp2exSctLqZmMuGYiqcRxIrqs0ICv7Ekb4EIiSUwPfbNwaVIHYTUemBqJck6uS5noFX+kaKVwoPeAsPRxA1T4WL7iQwRB3Z9JIy24KRb2sXG4mcVruRfJzltu8y+TsW3pBfStgYUHbu9oRJKliUNVK2BIVk7gKTI8seoZtOvqDBVxvNUDIxlp1pFYqZFx78kfvEnEpyAzWcNG8Nr/946oUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5IIA33hZPL54dB2mPo5SF5r6pOkDmU+F4p+43zdsWw=;
 b=wUX4bcYUMrO7JXQUVx6hFrN4QNdZWbqe0QdvvWOhhJPosQmQnwoG6hFHWO8mlNpaZ9VQLj6k7X2ofqx+CbLZskzyk3eXTzgF3JRt6RfqwSazEXz6Pc/+zWQafwP6NCsqmWGBvGhcC4as3nngbXqReAp862q6TuPndRdVvxUmkPc=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CO1PR10MB4562.namprd10.prod.outlook.com (2603:10b6:303:93::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Sat, 15 Jan
 2022 19:12:35 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a%4]) with mapi id 15.20.4888.013; Sat, 15 Jan 2022
 19:12:35 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "pjones@redhat.com" <pjones@redhat.com>,
        Konrad Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v9 2/8] integrity: Introduce a Linux keyring called
 machine
Thread-Topic: [PATCH v9 2/8] integrity: Introduce a Linux keyring called
 machine
Thread-Index: AQHYAo8H0Sj261FHG0itWWPoxYX3jKxbQpAAgAGq5wCAATwoAIAANR6AgAA/vYCAATVGgIAEjROAgAAhwgA=
Date:   Sat, 15 Jan 2022 19:12:35 +0000
Message-ID: <153F495F-EAF9-4C11-A476-293CC3B78F0A@oracle.com>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
 <20220105235012.2497118-3-eric.snowberg@oracle.com>
 <883da244c04fcb07add9984859a09d7b1827880a.camel@linux.ibm.com>
 <100B070F-7EB4-4BF7-B2B9-E5AE78D3066A@oracle.com>
 <a384fcf8bdd9ff79456e9669fc61ab50ec4e1c55.camel@linux.ibm.com>
 <F1F41DB2-171A-4A6F-9AE7-E03C4D3B7DD0@oracle.com>
 <eece68eba2beceeb410748c1f9f32162793d2057.camel@linux.ibm.com>
 <2d681148b6ea57241f6a7c518dd331068a5f47b0.camel@linux.ibm.com>
 <YeMAURSR8/fRjBHD@iki.fi>
In-Reply-To: <YeMAURSR8/fRjBHD@iki.fi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49160017-ee46-4c82-ccf6-08d9d85afd12
x-ms-traffictypediagnostic: CO1PR10MB4562:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4562035E68E641F217752F6887559@CO1PR10MB4562.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t8mwrzaaos5zKjCT6UNDHps8KwxO+2JbDamajdeUPQvTt+5IoD3UwsQv3lkHIzH25nCvQjIcrLgYz5A6XRigVBpnr80q+Sy7nsYmCmOKiOYWCaZ2FpvKDucL9iKKn2pNtyvBJmOCD8zZG/sb+8en87SUCO3/BuLL0tUhuyQYrOexit8A44K9ckvt4igNQ1B2/u9d9XCQ+SDRHsdvk3HrrQ/kWU+7iPCzw6aFPkewuYGQqhiMS6ZPwMHOLne8hqiUzpn9vPrj3F2S40WsvtCGVR/vd/rMBySvzZ8P8sX6ceEhdu9SKubh1aXIopZc+NCSqF+9V7Z1I6MU9P5vE7AlAbS1ihzeI3DK8PnelaFr30zdLsBXahM1MAk9Nf0cN7OypaQWRIySnCoF0mB2VlKWyfDgWHhq8X7YHWKTtNxP3GKBP4ZIbSK5bb+uq3DiCYYORZ6OxxgUljNC1GGRVIuIvSpYZheyz+uWEHh/L1VcHYD8uVFC+kzr+d0gitia+9Lq8Evndlxdr3CZo16b+0r8LTXVuZTKiT3BDXmIIse4xXPIrsT6aPklbmNsa8VoyX/L1db6m294LzskGlV1srLxCfZ+KiBd4Alvw8x93AojmDnNUoky7Ol1ckVKSxEFHhPUWf2mpTMbzyFLr8AyZ1IkvkKtMaFQQGv6JoUDtJJYiJBphInLjG53r2qBwAJh/KEvbUrFcJhly58y0VZuYcje+mgEXVLMjWYXjED0KkS7CQw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(508600001)(6506007)(53546011)(4326008)(6916009)(122000001)(33656002)(38100700002)(44832011)(107886003)(8676002)(8936002)(54906003)(316002)(6486002)(66476007)(66946007)(83380400001)(86362001)(2616005)(26005)(6512007)(38070700005)(64756008)(66446008)(71200400001)(186003)(7416002)(66556008)(36756003)(2906002)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHgrQWRBbDlnYTU0Rkx2dGl6ZnVrU2gvU2lVSHYwSkhXbUFta2ZteUpLb3JE?=
 =?utf-8?B?MHltQ2JIRUh0eUVpNGx3TytkTjBzMWlURFh1OVkrK2xPUzIvL0NyeHZ6d2RX?=
 =?utf-8?B?bnhzdi9FVzB4VklvSFQyRDhyTzRraThhalJaTGF1M3V2ZnJEZldmUi9iQ3JC?=
 =?utf-8?B?ZXVnRlZhZVR1elBmbm4wdlh4ZkRheWFWUUsvK0c5L21uWldNcUpQdUg5UElV?=
 =?utf-8?B?UVFyR3VkK2JFRjVHNHdVNWtPS2pxZGVCWkF3UlNqMlpCRlhVblR6NW0vVWdr?=
 =?utf-8?B?RXpoNFRobi83SUhnRFdyL1VSRHlkdGxBUTh3eUVocXNLc1o3QkE5Tkw0OXpp?=
 =?utf-8?B?RkQvTXk4aTA0VklXSnJzQU83akF4UU1GQmRpQzRuMzB6UEtSdW9qM0RBd3lG?=
 =?utf-8?B?MzFMT2l2MjB5UHhnYlJVbUxYcjdXVWR0Ykt4YWlGbGJ1Qi85Tmhya2tlK2Zz?=
 =?utf-8?B?TlROeFRnWURTUFpjc3E5bWxUaUJRYzNCeEhZK3FMbnpHODRpWHE1MFNkaVRB?=
 =?utf-8?B?Y0dndWhoRURZYkJ4T1M3eUFpZS85Njg1MjBDdXhRRzFHUHZFQTdlbGhtQzlN?=
 =?utf-8?B?Zk12eHFpSGNNakF1Tm5TSjhlU3gxWERoZTNiY2w4SnU2aUdJQXo5b29rVkY4?=
 =?utf-8?B?U2FXdEdEem40c1VBTjZyTXozUE9MOXZrZVI5ZjhXZlJUM1ZoazNTSWd0T0VG?=
 =?utf-8?B?YVIvQVF0anh4VlBSVDQ0L0NGYVFhVGJqamJyenVubDlxL3Vxb1R4TGtkTmFu?=
 =?utf-8?B?UnBmV0FBMmtKaWV6V0tONG13b0JmQkFCdUNUZUYrdlB5MTQ2ZlY1dUFaZzFZ?=
 =?utf-8?B?S2JhRTRLb0p6OWZ1azNWNk1VcVkxRDc1MDR4RDcyL20xQWptZWRsTTZhTEsw?=
 =?utf-8?B?bVMyT1BtSWFvdXFKcnN4T1I3Z0RNTVZQVlNtMUF5cFFBRGVCUUFTYnBYUkp1?=
 =?utf-8?B?N2FaTkhmYXpHVmNUTUUxYjdLalNCQ3pNTzZaaW5HVGJlUmkyS2FEL255dHR4?=
 =?utf-8?B?WnRXMmJuZmF5VHFEcFpwVTl0YzJPc1BWczVEeGxPelE4cE5GMGdJcERBaFQ2?=
 =?utf-8?B?QngvYzBmK3ByeHVnOHdZRExVRXk3ck5tNG5xMUdSbWZtd2IvVzVzand5TW55?=
 =?utf-8?B?N1EzZmhrQ21tWFY1VlFkaGNWOHFZakpDUHE4d2RUOUlNVy95VmgwWWQ1WGE2?=
 =?utf-8?B?RkJWMDR0SDdHL3ltbEFDTnE4dzZmQlR4K3ZmLzVBVE1vdnNCcGtOQ2lxeTZy?=
 =?utf-8?B?MUEyQStVazFVRGdadVRNdkZ2MUh2QTF1Mkt1elV5R3lNcVlTRTdXV3o3T1Fw?=
 =?utf-8?B?WlMzbExUeWl3bGljMGpUTndUWjA0MmFLWFQ4WURBZVVBVm9iYjVRUkliUThv?=
 =?utf-8?B?NFJZaUczaTVZNEp4OTdUNENLVHBqYXJiekVyRXN5MFBsYXdtS2Q1SXBOdHdl?=
 =?utf-8?B?NTc2Smo4TVpEYjhhcWI3MVFQTTdXOC9kOTRCOUJzQlUwWlNZeXpMbHdKUEdW?=
 =?utf-8?B?aW45NmVuT2QyMGI1ZTVqK3I3WUxBU3ZPc3ZmRnZuT2VpL1ZwMGd1dkxZdmlq?=
 =?utf-8?B?U202bzBzR2grQTgreHExcUxKcHUxQVRwcExsWFhhME91NFRJaXZuWHVmc05E?=
 =?utf-8?B?clpwMmh4V1o5MksvdU85M2I2UzJXZlNCY2R5REY1RFdWbHFFMEY0THo1TE1P?=
 =?utf-8?B?NkpFRGhmNTVsdlZEdWJtY2Y4T2RCZS9mNmRHdVJ5b2t4S0hhWmozMHFVbnVG?=
 =?utf-8?B?WkdmWDlud0ZOdytqL3FxcG16dzl3OFpKVTBianJoMnF1bUg1bnlNemZsUVVm?=
 =?utf-8?B?c1V3UXdqeXFOSHVOU29BelVqVDZXY3pHUC8zRXEwY3hsL0lUUHdNa09qdTRr?=
 =?utf-8?B?b0JwVXNBeFpIdjFUeVBSb2s2aW5hVUFzai9DQzJibTVrWEJVU1paOXl6NWdN?=
 =?utf-8?B?VGZuR3UrN0F1dzZjeEVxWlhsaEpRbHE2ZVlwTnYwWThKWTRRaGVUYlZMZ3lB?=
 =?utf-8?B?MlFCcnAxQ0ovMlJtQVp3MnV1dzNOVS9WWk9zTmpmcjNGU2xGWVR3enJ5OEpY?=
 =?utf-8?B?L1h2TGlycVlkMHRlUlJRWWpubTg4SEFSTU81aFdsVXM4MTdwd0x2cjIzYko5?=
 =?utf-8?B?cHp1dmtIa3Rvem0yWkppcWE1SkNoTElKbk5kdlZzWFR3bDNFRXFCU3ZYMGJI?=
 =?utf-8?B?TFlzaWZzSTA5M3dzb0lXeFl3VXg1MExWOUlRZFllRXlvV2hRK2dGaVlRZkM3?=
 =?utf-8?Q?zyUNFBhhjwfJVxY84DpeWQz9j9+lXY3KPyUodh0jjM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D8C1247876DCB45A45ED5CA469AE517@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49160017-ee46-4c82-ccf6-08d9d85afd12
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2022 19:12:35.3222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zu+vWR8dMORf8l5ng++tB4S5x3f117ifwbr6yIwbaZlkKScHf/j08aCYWU1sQ9feTS4QkQ1AA8CGK/sDo6jx14k77Lwdzl7NWv0u11cInW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4562
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10228 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201150125
X-Proofpoint-ORIG-GUID: Sb6GeGEOgjusncJEx-nvdcHg88mrZAwq
X-Proofpoint-GUID: Sb6GeGEOgjusncJEx-nvdcHg88mrZAwq
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCj4gT24gSmFuIDE1LCAyMDIyLCBhdCAxMDoxMSBBTSwgSmFya2tvIFNha2tpbmVuIDxqYXJr
a29Aa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIEphbiAxMiwgMjAyMiBhdCAwMjo0
MTo0N1BNIC0wNTAwLCBNaW1pIFpvaGFyIHdyb3RlOg0KPj4gT24gVHVlLCAyMDIyLTAxLTExIGF0
IDIwOjE0IC0wNTAwLCBNaW1pIFpvaGFyIHdyb3RlOg0KPj4+IE9uIFR1ZSwgMjAyMi0wMS0xMSBh
dCAyMToyNiArMDAwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+Pj4gDQo+Pj4+PiBPbiBKYW4g
MTEsIDIwMjIsIGF0IDExOjE2IEFNLCBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3
cm90ZToNCj4+Pj4+IA0KPj4+Pj4gT24gTW9uLCAyMDIyLTAxLTEwIGF0IDIzOjI1ICswMDAwLCBF
cmljIFNub3diZXJnIHdyb3RlOg0KPj4+Pj4+PiBKYXJra28sIG15IGNvbmNlcm4gaXMgdGhhdCBv
bmNlIHRoaXMgdmVyc2lvbiBvZiB0aGUgcGF0Y2ggc2V0IGlzDQo+Pj4+Pj4+IHVwc3RyZWFtZWQs
IHdvdWxkIGxpbWl0aW5nIHdoaWNoIGtleXMgbWF5IGJlIGxvYWRlZCBvbnRvIHRoZSAubWFjaGlu
ZQ0KPj4+Pj4+PiBrZXlyaW5nIGJlIGNvbnNpZGVyZWQgYSByZWdyZXNzaW9uPw0KPj4+Pj4+IA0K
Pj4+Pj4+IA0KPj4+Pj4+IEN1cnJlbnRseSBjZXJ0aWZpY2F0ZXMgYnVpbHQgaW50byB0aGUga2Vy
bmVsIGRvIG5vdCBoYXZlIGEgQ0EgcmVzdHJpY3Rpb24gb24gdGhlbS4gIA0KPj4+Pj4+IElNQSB3
aWxsIHRydXN0IGFueXRoaW5nIGluIHRoaXMga2V5cmluZyBldmVuIGlmIHRoZSBDQSBiaXQgaXMg
bm90IHNldC4gIFdoaWxlIGl0IHdvdWxkIA0KPj4+Pj4+IGJlIGFkdmlzYWJsZSBmb3IgYSBrZXJu
ZWwgdG8gYmUgYnVpbHQgd2l0aCBhIENBLCBub3RoaW5nIGN1cnJlbnRseSBlbmZvcmNlcyBpdC4g
DQo+Pj4+Pj4gDQo+Pj4+Pj4gTXkgdGhpbmtpbmcgZm9yIHRoZSBkcm9wcGVkIENBIHJlc3RyaWN0
aW9uIHBhdGNoZXMgd2FzIHRvIGludHJvZHVjZSBhIG5ldyBLY29uZmlnLiAgDQo+Pj4+Pj4gVGhp
cyBLY29uZmlnIHdvdWxkIGRvIHRoZSBDQSBlbmZvcmNlbWVudCBvbiB0aGUgbWFjaGluZSBrZXly
aW5nLiAgSG93ZXZlciBpZiB0aGUgDQo+Pj4+Pj4gS2NvbmZpZyBvcHRpb24gd2FzIG5vdCBzZXQg
Zm9yIGVuZm9yY2VtZW50LCBpdCB3b3VsZCB3b3JrIGFzIGl0IGRvZXMgaW4gdGhpcyBzZXJpZXMs
IA0KPj4+Pj4+IHBsdXMgaXQgd291bGQgYWxsb3cgSU1BIHRvIHdvcmsgd2l0aCBub24tQ0Ega2V5
cy4gIFRoaXMgd291bGQgYmUgZG9uZSBieSByZW1vdmluZyANCj4+Pj4+PiB0aGUgcmVzdHJpY3Rp
b24gcGxhY2VkIGluIHRoaXMgcGF0Y2guIExldCBtZSBrbm93IHlvdXIgdGhvdWdodHMgb24gd2hl
dGhlciB0aGlzIHdvdWxkIA0KPj4+Pj4+IGJlIGFuIGFwcHJvcHJpYXRlIHNvbHV0aW9uLiAgSSBi
ZWxpZXZlIHRoaXMgd291bGQgZ2V0IGFyb3VuZCB3aGF0IHlvdSBhcmUgaWRlbnRpZnlpbmcgYXMg
DQo+Pj4+Pj4gYSBwb3NzaWJsZSByZWdyZXNzaW9uLg0KPj4+Pj4gDQo+Pj4+PiBUcnVlIHRoZSBw
cm9ibGVtIGN1cnJlbnRseSBleGlzdHMgd2l0aCB0aGUgYnVpbHRpbiBrZXlzLCBidXQgdGhlcmUn
cyBhDQo+Pj4+PiBtYWpvciBkaWZmZXJlbmNlIGJldHdlZW4gdHJ1c3RpbmcgdGhlIGJ1aWx0aW4g
a2V5cyBhbmQgdGhvc2UgYmVpbmcNCj4+Pj4+IGxvYWRpbmcgdmlhIE1PSy4gIFRoaXMgaXMgYW4g
aW50ZWdyaXR5IGdhcCB0aGF0IG5lZWRzIHRvIGJlIGNsb3NlZCBhbmQNCj4+Pj4+IHNob3VsZG4n
dCBiZSBleHBhbmRlZCB0byBrZXlzIG9uIHRoZSAubWFjaGluZSBrZXlyaW5nLg0KPj4+Pj4gDQo+
Pj4+PiAicGx1cyBpdCB3b3VsZCBhbGxvdyBJTUEgdG8gd29yayB3aXRoIG5vbi1DQSBrZXlzIiBp
cyB1bmFjY2VwdGFibGUuDQo+Pj4+IA0KPj4+PiBPaywgSeKAmWxsIGxlYXZlIHRoYXQgcGFydCBv
dXQuICBDb3VsZCB5b3UgY2xhcmlmeSB0aGUgd29yZGluZyBJIHNob3VsZCBpbmNsdWRlIGluIHRo
ZSBmdXR1cmUgDQo+Pj4+IGNvdmVyIGxldHRlciwgd2hpY2ggYWRkcyBJTUEgc3VwcG9ydCwgb24g
d2h5IGl0IGlzIHVuYWNjZXB0YWJsZSBmb3IgdGhlIGVuZC11c2VyIHRvDQo+Pj4+IG1ha2UgdGhp
cyBkZWNpc2lvbj8NCj4+PiANCj4+PiBUaGUgS2NvbmZpZyBJTUFfS0VZUklOR1NfUEVSTUlUX1NJ
R05FRF9CWV9CVUlMVElOX09SX1NFQ09OREFSWQ0KPj4+ICJoZWxwIiBpcyB2ZXJ5IGNsZWFyOg0K
Pj4gDQo+PiBbUmVwb3N0aW5nIHRoZSB0ZXh0IGR1ZSB0byBlbWFpbCBmb3JtYXR0aW5nIGlzc3Vl
cy5dDQo+PiANCj4+IGhlbHANCj4+ICBLZXlzIG1heSBiZSBhZGRlZCB0byB0aGUgSU1BIG9yIElN
QSBibGFja2xpc3Qga2V5cmluZ3MsIGlmIHRoZQ0KPj4gIGtleSBpcyB2YWxpZGx5IHNpZ25lZCBi
eSBhIENBIGNlcnQgaW4gdGhlIHN5c3RlbSBidWlsdC1pbiBvcg0KPj4gIHNlY29uZGFyeSB0cnVz
dGVkIGtleXJpbmdzLg0KPj4gDQo+PiAgSW50ZXJtZWRpYXRlIGtleXMgYmV0d2VlbiB0aG9zZSB0
aGUga2VybmVsIGhhcyBjb21waWxlZCBpbiBhbmQgdGhlIA0KPj4gIElNQSBrZXlzIHRvIGJlIGFk
ZGVkIG1heSBiZSBhZGRlZCB0byB0aGUgc3lzdGVtIHNlY29uZGFyeSBrZXlyaW5nLA0KPj4gIHBy
b3ZpZGVkIHRoZXkgYXJlIHZhbGlkbHkgc2lnbmVkIGJ5IGEga2V5IGFscmVhZHkgcmVzaWRlbnQg
aW4gdGhlDQo+PiAgYnVpbHQtaW4gb3Igc2Vjb25kYXJ5IHRydXN0ZWQga2V5cmluZ3MuDQo+PiAN
Cj4+IA0KPj4gVGhlIGZpcnN0IHBhcmFncmFwaCByZXF1aXJlcyAidmFsaWRseSBzaWduZWQgYnkg
YSBDQSBjZXJ0IGluIHRoZSBzeXN0ZW0NCj4+IGJ1aWx0LWluIG9yIHNlY29uZGFyeSB0cnVzdGVk
IGtleXJpbmdzIiBmb3Iga2V5cyB0byBiZSBsb2FkZWQgb250byB0aGUNCj4+IElNQSBrZXlyaW5n
LiAgVGhpcyBLY29uZmlnIGlzIGxpbWl0ZWQgdG8ganVzdCB0aGUgYnVpbHRpbiBhbmQgc2Vjb25k
YXJ5DQo+PiBrZXlyaW5ncy4gIENoYW5naW5nIHRoaXMgc2lsZW50bHkgdG8gaW5jbHVkZSB0aGUg
Ii5tYWNoaW5lIiBrZXlyaW5nDQo+PiBpbnRyb2R1Y2VzIGludGVncml0eSByaXNrcyB0aGF0IHBy
ZXZpb3VzbHkgZGlkIG5vdCBleGlzdC4gIEEgbmV3IElNQQ0KPj4gS2NvbmZpZyBuZWVkcyB0byBi
ZSBkZWZpbmVkIHRvIGFsbG93IGFsbCB0aHJlZSBrZXlyaW5ncyAtIGJ1aWx0aW4sDQo+PiBtYWNo
aW5lLCBhbmQgc2Vjb25kYXJ5Lg0KPj4gDQo+PiBUaGUgc2Vjb25kIHBhcmFncmFwaCBpbXBsaWVz
IHRoYXQgb25seSBDQSBhbmQgaW50ZXJtZWRpYXRlIENBIGtleXMgYXJlDQo+PiBvbiBzZWNvbmRh
cnkga2V5cmluZywgb3IgYXMgaW4gb3VyIGNhc2UgdGhlICIubWFjaGluZSIga2V5cmluZyBsaW5r
ZWQNCj4+IHRvIHRoZSBzZWNvbmRhcnkga2V5cmluZy4NCj4+IA0KPj4gTWltaQ0KPj4gDQo+IEkg
aGF2ZSBhbHNvIG5vdyB0ZXN0IGVudmlyb25tZW50IGZvciB0aGlzIHBhdGNoIHNldCBidXQgaWYg
dGhlcmUgYXJlDQo+IGFueSBwb3NzaWJsZSBjaGFuZ2VzLCBJJ20gd2FpdGluZyBmb3IgYSBuZXcg
dmVyc2lvbiwgYXMgaXQgaXMgYW55d2F5DQo+IGZvciA1LjE4IGN5Y2xlIGVhcmxpZXN0Lg0KDQpP
dGhlciB0aGFuIHRoZSB0d28gc2VudGVuY2UgY2hhbmdlcywgSSBoYXZlIG5vdCBzZWVuIGFueXRo
aW5nIGlkZW50aWZpZWQgDQpjb2RlIHdpc2UgcmVxdWlyaW5nIGEgY2hhbmdlLiAgSWYgeW914oCZ
ZCBsaWtlIG1lIHRvIHJlc3BpbiBhIHYxMCB3aXRoIHRoZSBzZW50ZW5jZSANCmNoYW5nZXMgbGV0
IG1lIGtub3cuICBPciBpZiB5b3Ugd2FudCB0byByZW1vdmUgdGhlIGltYSByZWZlcmVuY2UsIHRo
YXQgd29ya3MgDQp0b28uICBKdXN0IGxldCBtZSBrbm93IGhvdyB5b3Ugd2FudCB0byBoYW5kbGUg
dGhpcy4gIFRoYW5rcy4NCg0K
