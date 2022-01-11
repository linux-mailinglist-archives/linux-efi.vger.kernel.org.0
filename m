Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC1C48B999
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jan 2022 22:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244671AbiAKV1Q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jan 2022 16:27:16 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33178 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244558AbiAKV1P (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jan 2022 16:27:15 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BJNw29028126;
        Tue, 11 Jan 2022 21:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fO2EEn2Ftc3ENqMafJZSP2ahFMFEv8HBB8zaQHfAZB8=;
 b=SeMcXaC41MZrDQb+eOwxhYgLIlOnxQubIeR0W5SfzL6H8mr2tRgqO5tr3rvDJCu+AAeh
 I/2vqxfLtBn6i9PBrOEn5EX+7KgugcY4c+ZuvqPc2axaIGzv6pWPC02C1jyUTbUDhHa9
 SMn2ZvwzbVWXzhtapoJPxo1fvVn7VioY5jSmojuJaF2Cutt1dVmHE7U4pMIiWR+KrSlQ
 +SbeNdD5O7ffX56qJoMnKB7BC+3fjl4GPRmesuELRukTdfI2sCyUa3h8+yf4FXDTFTeZ
 Jvi2CibQm90WN743DYHE7JL9C9ZBCtM6D9vSfrNgBDCtSxzX68s7z6juvVilF8m6mu/u BQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgn74c8qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 21:26:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BLFcN1196395;
        Tue, 11 Jan 2022 21:26:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by userp3020.oracle.com with ESMTP id 3df42nd7pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 21:26:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0P4L3DMZKAe0LP99OtqdQIKK1YVKQV0MEB2wc6FioxycnJXhvcnGQXKxdaKUwoDxKxqhmheZTPlAyk0I3jjaP+0hJQ4eczhsOWNbWscfW6wonJQrWG3VoMd7I07cA0VE/FHS5sXusyPZ6UnPFNCCCFB6CQw4z15n4tCRmIm81RZjKNSa9ZCSF/iyUmcLXlAHASbxDf042koGQlr61Jt/vKcsf3pZawl+q7WzJVBI/Sj5Gwpij/ftindrNzpnLfiHKOeCVWvbIVc1obWicHPeuSymDQiypwslVrv4ykOPfJovv8/13Xe//i76ijTAk1yfuedkiwHJrmdQu8bLwOd0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fO2EEn2Ftc3ENqMafJZSP2ahFMFEv8HBB8zaQHfAZB8=;
 b=Lzyd0xawjbnSKkXlQUr7MeQmNvkdwgkVeh1h2cmARDSiy3rRRtl+6ak+pIVFBMgmOgrmTbNRfllvmn+UM36h3DgZL2EcPaJNhtotQekoZYky/muGvfmEqWHpLY1tRtcyCiLHWQROlZ4T8CbOzIADYvbhVZuMX7Wq6Twvo7lTcS49plrird96Bmboz5+XH2jvnBGIf00LM2OX77jkEMxIgUZoy2OWhmPSNPsgPABTsYl6YFVJeZmOGQUWvst2Yq8S5LBSKrWcSKJjsOmj1ahdDBsjEOEONUoEx8pxX4N8vWNtMrh7UW1p2CzzmQOa8JI4q1GbFz2yC4flrudFTaC56g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fO2EEn2Ftc3ENqMafJZSP2ahFMFEv8HBB8zaQHfAZB8=;
 b=pfyg7Lx1VGPFR1nFSzslXti3+lf5KLMHqf4rpBv1QJex1d8ea0hX159rXHkD1dNg9+CA4n6QhoVvlKD4RwsiVcar6GmGYlI+13dOswQiJc5ZGcimjobpWdLsyURWGFcQ8bdocxsWTL3SduJR+stRls6G4NoaluSZEYkPGD5tH88=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5306.namprd10.prod.outlook.com (2603:10b6:610:da::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 21:26:44 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 21:26:44 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     David Howells <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
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
        <James.Bottomley@HansenPartnership.com>,
        "pjones@redhat.com" <pjones@redhat.com>,
        Konrad Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v9 2/8] integrity: Introduce a Linux keyring called
 machine
Thread-Topic: [PATCH v9 2/8] integrity: Introduce a Linux keyring called
 machine
Thread-Index: AQHYAo8H0Sj261FHG0itWWPoxYX3jKxbQpAAgAGq5wCAATwoAIAANR6A
Date:   Tue, 11 Jan 2022 21:26:44 +0000
Message-ID: <F1F41DB2-171A-4A6F-9AE7-E03C4D3B7DD0@oracle.com>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
 <20220105235012.2497118-3-eric.snowberg@oracle.com>
 <883da244c04fcb07add9984859a09d7b1827880a.camel@linux.ibm.com>
 <100B070F-7EB4-4BF7-B2B9-E5AE78D3066A@oracle.com>
 <a384fcf8bdd9ff79456e9669fc61ab50ec4e1c55.camel@linux.ibm.com>
In-Reply-To: <a384fcf8bdd9ff79456e9669fc61ab50ec4e1c55.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 307787c7-45f5-43ce-5371-08d9d5491112
x-ms-traffictypediagnostic: CH0PR10MB5306:EE_
x-microsoft-antispam-prvs: <CH0PR10MB53061E92FD38CCEF6A05CB8387519@CH0PR10MB5306.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7/e+ltwvyqshqJ3pppOy0hnN37033Ff+/yHI7PjDsrxJ0D0/vR40Wy5kT9I5DBP8egRGQ3/I7vt82Xa72i/n7bNcMfdh8mmK+8c5Cs6/wtjwsRu5mT5IKqQgoXXJcq6EZY63e2zD7m8ckBKmlWUJUW8PBYCyGOQ6N8dKD7hVFQ1elknilVGgGL/b0WHcBKgQ/7Tw0LpNoVtYZ5K4+e87J+Vb7VNz4FvcINZKuLVNYkxqURkv0uTKN059y/jUxJ26l0GKV7VNjxyN7FTEdlf1p1CrP+sE2ts+TKA5D7bIdz1v3MReu4GH8+Mu+iddgBuYoBGVsy6RU3V/QpBcebiR8n9JtAxN8Sgt48psKpCbrl5mdMv1+qDCElqLtxD/rvA+QXv8jFz4F3s9DtEyxXJX2/sraDqVzDB9wDNSOMZ/vkYVBZIYSPgiO10MypPKjcvoMGWGJWuVFSmjzn1iPWoq45OMCe8HJCmvdQ7dbDMdOnwNFAGyaIwAV+GMgPPhlAtehbSVvsxBAmiiP6/WTMa1brPZ5p3Ow5e3+QAMciN8codxTrrUHYs7HeQosY5F31DLGt4Y3VfkRZ7FO9EdjGFFkoMJxAJBL6pvajKC3efxAZvO8V+G6GUqqW8NEBBKq7ffCY7Pqe7M6gp2Ko5tFaXWHLu2e+OWWNLHWjqwKogC2X/Emi3b+Nd0Otk/xlTYp5q4JWGcYtXiC2kBudmOxeip9C7+X2DqUMMunAYrLicQizAzWJKumkF845rVrbX/+yoH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(107886003)(2616005)(44832011)(2906002)(38100700002)(86362001)(33656002)(36756003)(6512007)(6916009)(122000001)(71200400001)(6486002)(64756008)(508600001)(53546011)(76116006)(4326008)(186003)(5660300002)(66556008)(8936002)(66446008)(7416002)(54906003)(83380400001)(316002)(8676002)(66476007)(91956017)(66946007)(6506007)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEdGbjVMT3lIbkpsRThVN1kvTjdzSjFNQmc2Y3NYNFpkV1N6RmV5bVJSZmFN?=
 =?utf-8?B?YklUdzlCa0s4QlM0NGIxRWlZbjJTeTNwVTRhREs3NXdCNTN6MHQzSENwTlJw?=
 =?utf-8?B?RzJ5c240dmJHUWpTY0lHd2g2a0pzdTdBTlZQNklDbjJBbmN6Yy92NE03Ymh0?=
 =?utf-8?B?enlNZUdRN1dhVkFyelU2RTUvTVgrQ29aSjl0dmhaczlEd2g4STNlSXBzeHU0?=
 =?utf-8?B?WDBkQTlWSEtDWUdjZzZMbzdHRElnc1QyVEZJbDFoMndNNDBOSzJ4UVExeHNN?=
 =?utf-8?B?d0pEbG5TRUtNK3Q0ZXNLMGlwa0VuamZkcStCM28rOWFUd2xYcnZlNXZGVGlq?=
 =?utf-8?B?RjVHcnB6MDYzY0V3RTJ5eFNvSHFuQWhyVkpMYm5EbHdDeko2NzNtRGxPY2cv?=
 =?utf-8?B?NHRvSTIxbHRlZjh1MTZnYTd1TkEvM0tLbjlXUnZBbmV0cHR4cFgyYk1iUGxP?=
 =?utf-8?B?bmg2a2RNcHJFVjAvV0h2STB3OS9ENWxzL0JnY0hpTEdkcDQ3bjB4ZVNXVGRX?=
 =?utf-8?B?MW50dFBEZmVqVG90M09OT0gyMXZvQ1NPQWRzRlZ2ODlKRGVzUThJaWdvL0Fu?=
 =?utf-8?B?RXhlK1hNVVNsY2dWWFNCSlp3aUJVZE5sWnhaV3hEMk1ZMGVYeDFNcVVCSFBN?=
 =?utf-8?B?WlNJOTVqcEVwQUhadCtjNjYxK1AxUGtQL2RpbHdvT2ZKaWg2bEMveVZyYlk4?=
 =?utf-8?B?a1pCb3BNRGlvcC82ZnBjWWtRelM1OXZ0ZGd0VmdyNzRjeGF1ZkQ1NnN5cmdm?=
 =?utf-8?B?WC9saitDR0VXYWk3MG1oWGo0YWpVajR2YkpNbUNXZ0ZRMXJiSGNYWmgxMFpN?=
 =?utf-8?B?QldpaUl4TW51R3VNdHZvQWY4V09jTmZ1RWhvcEFTcHBTdjRtWEJybWZoU0JJ?=
 =?utf-8?B?Qy9zdndiSksxYzJCTGVtS2Rhb2oxeXV0TlUxZDVuT2Mwek9hS0Y3TDU3NlJk?=
 =?utf-8?B?SE4zY0FuNDhLZG10RVJLWHE1SFhwYUg1WUVkMlJWT3BxbGtSOUZuT3BoMlNN?=
 =?utf-8?B?SGdIR3NwSW83WXlUQXNiQ0UvdmNEWHdWODdiK1p6cjBhaDdiekJUVk8rWUlz?=
 =?utf-8?B?UHdUaDFEek0zYVdxL2JRM0ZrYWNQRHlYRHd6NE05ZzhzSnVyVE9KQmE3dTRq?=
 =?utf-8?B?Z2R1MGFPNm1GRGZpMURmb1Y0SFVxK29QM0FmbnhqK1BnUGx6cGIwNmlacUcy?=
 =?utf-8?B?OS9uQkJnd0VQZm5WZExXU3VISjdIY0RJOVVYd2UzR0pBR3drRjA2SEI0UnhX?=
 =?utf-8?B?WTB6S05hWkNlaUxTbVdyRDMzd3kzSEJQWmZjWjllU2F5ZGhZYVBFVklzOHZ0?=
 =?utf-8?B?SFA4MHlQVVFjVjdFUmUvVHVlZUNhU1hTcFVQWXRSZmNZOS9UeUU4OXFhVDJY?=
 =?utf-8?B?NFJES3loU1B6blljTlZHbHFjSGE0b2M2VDJ1TWQydXBHL2JrK09saElZaFdx?=
 =?utf-8?B?Z1FMQVBTTVcySWhKVlI3czNPMDk0djVFNUtxRjl6R1lPa2x6OTBiaU5mb095?=
 =?utf-8?B?MXdGT05Ockx5eGMzeERqYlhwWXpRbDIwSXovRHRlSE14UU9SZkloZGhFT3k4?=
 =?utf-8?B?VFR0R2piRW5zWHpwbHZLNEdLYlJ2cTBGdk5RQUlTS1hPaklWOUxaUXhGRXFi?=
 =?utf-8?B?ZHR3L3FKYktMOHZKSnl4NlFhVmwvM3pHS1hhWHhubFNpWEpMeUg4WUlWb1cv?=
 =?utf-8?B?dG5mMUF6SWUvWEUxTHhTaFBraWw0V01KTWs0VFgveWxMb2FkV3FxLzJsOHJz?=
 =?utf-8?B?enBLdG1icndvWWE2d0x5WU9aRm01TDBaVGorajhzZk9PbWptdWRuQnh3VHlq?=
 =?utf-8?B?cVBGeEhBeTM5TzZTbklJWEdEMEdUVmxMRFgyKzBFYmxOOU93VlVBMHUwck1O?=
 =?utf-8?B?cWc2di9ZNFZDM3FEV1haall1YVZCVGZsTHNGSUVBSUM2cllRd1JNOTloUFUx?=
 =?utf-8?B?QzBTdlZ1eWdoa3ppY0xYY2xnZlc4d1p4SnF6OXIwdnY3OVVCcUNkdU1ISG9u?=
 =?utf-8?B?T1QyMTRFMVA1b3hZY0R1VHFERDEzcFZ4Z3FuSU9ZSm9oUm4reUROemcxTVVM?=
 =?utf-8?B?TUViNnpwMkxhVzAxMDVyWWM1NzlSZDRPT1U2b3ZTK1pKZ2hNTWFFRWVUWHNP?=
 =?utf-8?B?TTAvdjdWQktnNHp3U1REOW5NUFdYNTRjblhITSt5TGpVNGNTbVpKVUtjSS9p?=
 =?utf-8?B?M1NwNVk4R2hnMlkvRy9ub0xjNjlCaEtPOFkxKzFVb1pPUXJ6Z1FjSTdsNGtG?=
 =?utf-8?B?RDkzSzJMa2xMZmR5TGphNGc0TGNZQTZIR29tOGVza2tOT3dpMldtSTFmZFNj?=
 =?utf-8?Q?kQY+1EyDdsnq2Taqvi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CED07B8ABC52574F9027D296606B3EC1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307787c7-45f5-43ce-5371-08d9d5491112
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 21:26:44.4909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qdQit/iQIrtJm3BnfWfD1BhFtdZJy0RTZb71KGZpTPgxKlOUFnpJjhJvjl/I+X1iO3/Jqekb1B9TyHIwa/9ALjhyCFagi9JuhumwQl9eRMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5306
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110110
X-Proofpoint-ORIG-GUID: 6cZp4NwyyYvBIAx2DT-JL9JtJ0TGqkfi
X-Proofpoint-GUID: 6cZp4NwyyYvBIAx2DT-JL9JtJ0TGqkfi
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCj4gT24gSmFuIDExLCAyMDIyLCBhdCAxMToxNiBBTSwgTWltaSBab2hhciA8em9oYXJAbGlu
dXguaWJtLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIDIwMjItMDEtMTAgYXQgMjM6MjUgKzAw
MDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+Pj4gSmFya2tvLCBteSBjb25jZXJuIGlzIHRoYXQg
b25jZSB0aGlzIHZlcnNpb24gb2YgdGhlIHBhdGNoIHNldCBpcw0KPj4+IHVwc3RyZWFtZWQsIHdv
dWxkIGxpbWl0aW5nIHdoaWNoIGtleXMgbWF5IGJlIGxvYWRlZCBvbnRvIHRoZSAubWFjaGluZQ0K
Pj4+IGtleXJpbmcgYmUgY29uc2lkZXJlZCBhIHJlZ3Jlc3Npb24/DQo+PiANCj4+IA0KPj4gQ3Vy
cmVudGx5IGNlcnRpZmljYXRlcyBidWlsdCBpbnRvIHRoZSBrZXJuZWwgZG8gbm90IGhhdmUgYSBD
QSByZXN0cmljdGlvbiBvbiB0aGVtLiAgDQo+PiBJTUEgd2lsbCB0cnVzdCBhbnl0aGluZyBpbiB0
aGlzIGtleXJpbmcgZXZlbiBpZiB0aGUgQ0EgYml0IGlzIG5vdCBzZXQuICBXaGlsZSBpdCB3b3Vs
ZCANCj4+IGJlIGFkdmlzYWJsZSBmb3IgYSBrZXJuZWwgdG8gYmUgYnVpbHQgd2l0aCBhIENBLCBu
b3RoaW5nIGN1cnJlbnRseSBlbmZvcmNlcyBpdC4gDQo+PiANCj4+IE15IHRoaW5raW5nIGZvciB0
aGUgZHJvcHBlZCBDQSByZXN0cmljdGlvbiBwYXRjaGVzIHdhcyB0byBpbnRyb2R1Y2UgYSBuZXcg
S2NvbmZpZy4gIA0KPj4gVGhpcyBLY29uZmlnIHdvdWxkIGRvIHRoZSBDQSBlbmZvcmNlbWVudCBv
biB0aGUgbWFjaGluZSBrZXlyaW5nLiAgSG93ZXZlciBpZiB0aGUgDQo+PiBLY29uZmlnIG9wdGlv
biB3YXMgbm90IHNldCBmb3IgZW5mb3JjZW1lbnQsIGl0IHdvdWxkIHdvcmsgYXMgaXQgZG9lcyBp
biB0aGlzIHNlcmllcywgDQo+PiBwbHVzIGl0IHdvdWxkIGFsbG93IElNQSB0byB3b3JrIHdpdGgg
bm9uLUNBIGtleXMuICBUaGlzIHdvdWxkIGJlIGRvbmUgYnkgcmVtb3ZpbmcgDQo+PiB0aGUgcmVz
dHJpY3Rpb24gcGxhY2VkIGluIHRoaXMgcGF0Y2guIExldCBtZSBrbm93IHlvdXIgdGhvdWdodHMg
b24gd2hldGhlciB0aGlzIHdvdWxkIA0KPj4gYmUgYW4gYXBwcm9wcmlhdGUgc29sdXRpb24uICBJ
IGJlbGlldmUgdGhpcyB3b3VsZCBnZXQgYXJvdW5kIHdoYXQgeW91IGFyZSBpZGVudGlmeWluZyBh
cyANCj4+IGEgcG9zc2libGUgcmVncmVzc2lvbi4NCj4gDQo+IFRydWUgdGhlIHByb2JsZW0gY3Vy
cmVudGx5IGV4aXN0cyB3aXRoIHRoZSBidWlsdGluIGtleXMsIGJ1dCB0aGVyZSdzIGENCj4gbWFq
b3IgZGlmZmVyZW5jZSBiZXR3ZWVuIHRydXN0aW5nIHRoZSBidWlsdGluIGtleXMgYW5kIHRob3Nl
IGJlaW5nDQo+IGxvYWRpbmcgdmlhIE1PSy4gIFRoaXMgaXMgYW4gaW50ZWdyaXR5IGdhcCB0aGF0
IG5lZWRzIHRvIGJlIGNsb3NlZCBhbmQNCj4gc2hvdWxkbid0IGJlIGV4cGFuZGVkIHRvIGtleXMg
b24gdGhlIC5tYWNoaW5lIGtleXJpbmcuDQo+IA0KPiAicGx1cyBpdCB3b3VsZCBhbGxvdyBJTUEg
dG8gd29yayB3aXRoIG5vbi1DQSBrZXlzIiBpcyB1bmFjY2VwdGFibGUuDQoNCk9rLCBJ4oCZbGwg
bGVhdmUgdGhhdCBwYXJ0IG91dC4gIENvdWxkIHlvdSBjbGFyaWZ5IHRoZSB3b3JkaW5nIEkgc2hv
dWxkIGluY2x1ZGUgaW4gdGhlIGZ1dHVyZSANCmNvdmVyIGxldHRlciwgd2hpY2ggYWRkcyBJTUEg
c3VwcG9ydCwgb24gd2h5IGl0IGlzIHVuYWNjZXB0YWJsZSBmb3IgdGhlIGVuZC11c2VyIHRvDQpt
YWtlIHRoaXMgZGVjaXNpb24/DQoNCg==
