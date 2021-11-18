Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A945545667A
	for <lists+linux-efi@lfdr.de>; Fri, 19 Nov 2021 00:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhKRXdJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Nov 2021 18:33:09 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62200 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233171AbhKRXdJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Nov 2021 18:33:09 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIMm8a0000706;
        Thu, 18 Nov 2021 23:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HKZlX1JKyf6ujfrZ+IqtjBrMWkKztIOkvz0pllIoKC8=;
 b=z3b01Hsx8rabkBNdIscfL1TuHg9C865RM+iUkfVClTu4kRpM2IyfyV24uVHyqc2vXmYy
 YiHxQxunLoeicVxjmpKS4p7d/caizrCy+eudwP1cHC6+m+hZgMXyWVzhKt6oOyxZZPxi
 igvOt6KBrx9ZOE0e6+ukEg+vPJnSMClYYnhtYfPxweJ/rDnO+4FeQuVTTflWvlkX1p7L
 HPRKwegUuTAdSRjzYL2APfVVnII+ub51Z8B+lVDJtzNUUzFe70JExy544JLDQ+bALtLe
 SAnAvGNQFM5iszJgSf9HxjlMkmNDcJN9jz5NcLTFe6HF4SN09ks8O/gc2iuFN9rkwezz NQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd205kkbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 23:29:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AINKLiL148052;
        Thu, 18 Nov 2021 23:29:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by userp3030.oracle.com with ESMTP id 3ca2g1bfc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 23:29:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gdb8EcLPFntRs+sAvVGgU7gpJRQECCZKTA3RT8UNkn6SPszyDCHnnDV8tgSyxK6vp2lnC1UcAkWVF5iv+BvJGG/IzUmB88rcHaN63X+aUDXk4c+eoaZ8TmuS3MWyK0fnh9G6HKrd8MokAWXhjrUNS/FQlAwdy3IFxTk+79mIQXVHpAqCz+lNGT/KbEuNYHCX9jpVviS47V0Jl8N1UG+fVqAUa96obojGqxyKBs0BoM1/JUngayGeipxgKkjxsMRN06CKrq5Vy8cNF7JOxltkxAp9NLiyegA6PR2135HuVM5rhrqCVKTcuwDYmS2mNdpPXyQktonEeQP0NsdRpXkZ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKZlX1JKyf6ujfrZ+IqtjBrMWkKztIOkvz0pllIoKC8=;
 b=BAEd0GVXAvTiQ97XUOgelzedkHCjkmFYAaZs13lnMSLAVsJDALk51Xx3ItjelL162Qd7W3eVyvO9GvuRPi5Bs1QcWM/WAH1QjJrn4cKDCRVnSZPo8jnnNSZ/RnxzXa14dH9f6K1yDpZqpv0vD+09PqWuz+IpUYtNzEB0z7VJiBcCvZ8vyObbSbdcBNVuMMzE7ii0yI0bKBdLxyZFRZVChWwo8k4PRaMoLleUYX24m5k/lGBI62kK0aTfPrP1oaP6GrkIsxzvkKL9+Qwbl6k1pFMbxVoUwv8DUs4K1Hm1z6NIKHD4NNCAYOV1hLzCuUqhaSM3NVM69YomK//iS37F0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKZlX1JKyf6ujfrZ+IqtjBrMWkKztIOkvz0pllIoKC8=;
 b=Oq8IoW64pFE2zdJVspKJrvhSG35LBe5H5Das9reoljhbcjKIcgX58RGIJFniBuWGmBsHCx/XCFMZ9VukrC2NCGl2QHNP64BG8kYihulcWn2rbiTp4X+VvG7rKr1RtcAR0LcAzKhQuqLWbA7ezhi04la3L/8Oc9uKIjx3QNviII8=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5210.namprd10.prod.outlook.com (2603:10b6:610:ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 18 Nov
 2021 23:29:40 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4713.021; Thu, 18 Nov 2021
 23:29:40 +0000
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
Subject: Re: [PATCH v7 04/17] X.509: Parse Basic Constraints for CA
Thread-Topic: [PATCH v7 04/17] X.509: Parse Basic Constraints for CA
Thread-Index: AQHX2n8vGlq8E5chlkWad9I6nU/9tqwJ6v8AgAAIT4A=
Date:   Thu, 18 Nov 2021 23:29:40 +0000
Message-ID: <275E8989-0384-46B6-B75C-6BD9F4F9DE85@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
 <20211116001545.2639333-5-eric.snowberg@oracle.com>
 <90223050186b384288e5d8f7aed8af5c8111d3e8.camel@linux.ibm.com>
In-Reply-To: <90223050186b384288e5d8f7aed8af5c8111d3e8.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 273ea6c0-2efd-4438-2b11-08d9aaeb4b5f
x-ms-traffictypediagnostic: CH0PR10MB5210:
x-microsoft-antispam-prvs: <CH0PR10MB521028B7FB5BDBBD682EE775879B9@CH0PR10MB5210.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f4HPTi2fds6r+k68Ez7AGOtEpxAGPrT9zZW7EnhrmgFzaAA/Vc1e5joaFNQRIJB2k/S9T010jW8n9tszXyHT+EMCcgeCQD2FpSx0K95lAuKHlPOE3VrHT2SQHndrD2ErCLp+vj08fRBNeZUBBZsv+6aWOnzjMz65LwNEV5kXVj1PYOoyOQgWAnuSsAVmnV/qVBSVMUTPu7aW0lByH692MLOI+Te9GFhxsRyKcDD1cIVT9TMwCSIQDzipV18SdaQDNK2AoMqaQ8tz1NwS8k8F7dT1byxxuEG4r5zhw4gSeRikXWtvd+xgs5z2/OtOGH9Oy1CnaRb01DvPMZQfKarMZ4cY+iCsnlvYQ68xkppEJ1OfOg00x5hFfxwoqf5B48gD87dd5Uzg0scKDtslsGzBimiCFd2D8h8VvA4zD0K5knhKon/6EtyNPutZZWaMhh913RnIMmLWNRZT6KJF/tAnmo2AchjcZx8moUSOnnLLYSaZY46K6p2oWStMCAGMypxPwW5xlFbeI8b6kt/0JXJ7N1tUsCG1TImLA1a+IHp/q8ksRQg6BKe45Tn40OyyJZhojo37lWVY8nfqzk/0JHOTPTFP9CheiffeWgKXWj/EwyVxbu/Y5gRQymAPj2o9jqOF72qFL87lYV7268xKE8mbJ39fLZRLIXp/1EGrBTgVMCG3Dvvk49GewcJluSewpIpFzX+p0eycFhqbGhOAn49TepxkMkyZ+CqWfBhLWPa8dJI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(53546011)(6506007)(508600001)(8676002)(38070700005)(2906002)(6512007)(36756003)(122000001)(7416002)(91956017)(86362001)(66446008)(66556008)(66476007)(64756008)(44832011)(83380400001)(4326008)(76116006)(66946007)(5660300002)(2616005)(107886003)(4001150100001)(6486002)(8936002)(33656002)(71200400001)(316002)(54906003)(6916009)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dU01UENNWkdmc1Zxa0s1NEZqOGxBU0xuNURURWhudVA2ODFNR0dNNnhPcUlj?=
 =?utf-8?B?Q2NPNHgxZHI3NU0zWXJxK2RGdUdYSmNnUmF5enIzUVZyd0JrejNCOHVuYzBU?=
 =?utf-8?B?SkZJN1F5K3hPS3dnVE1JbExjcXpFWUtpYjMrZkFFWkJjUlVoL0RuRlpDL0Jk?=
 =?utf-8?B?QzBYYU5ROTJYcTFjY1JTc0ZUeUNNaVRjNm80SlZsV3FjaDRoSnV2OTNFZVo3?=
 =?utf-8?B?YldBUDZUOSszZVAzaGVPTUZQdVYraUV4SXRHeXVyTURRMGY3aGM0U1pKOEJP?=
 =?utf-8?B?TytGWFdyZUQ2cEJXTXVuRTZBbmdaTmxKaEcvRXRDQUEzNjY5Z0NNa2R3M3ZM?=
 =?utf-8?B?eHJQY3NJSWR2MGhOZm1hUzJNSFlycW5ydDNZOHVFQVMyVklGeSs3OENWVjJ3?=
 =?utf-8?B?NWNQaFB1bzZZMldIdHFpZGt1RXNyYXNRVmZ0RkNEUkZ5TTYrT0FVa3JZb0xQ?=
 =?utf-8?B?djB5NlRIQWVFNFZGelkwVnVyZU9SbFdrWlh3UVBTQTZ1QytyRkgxUG1oY2dq?=
 =?utf-8?B?MG0xb0pwQ2w2d2tTMTBXUzlHSzhXZTV6VFZRYTg0SUsxejhoQWszMjZnQlZK?=
 =?utf-8?B?eUdFK1duT1V6dlhrOC9sWXNMczNkOFZXM3U1L1ErUjB0bmxWVTkzb3A5amdi?=
 =?utf-8?B?QTl5Vldwb1lKRmVucnEwN3BVU0wwVm9MY2VUamRRdUQwWmdQYTA5U1M3TTB2?=
 =?utf-8?B?N3JUUmVYZUhjakUvUTIvcEFKaGU0T3QxRTBjaFpkR0pURkF3Z1lQb00rYTQv?=
 =?utf-8?B?c0ZiV2V4L2RQOW9leUU1bzAybnpHTFlCcDRuM2U5dysvSHNHaUo2Tzh0V2Fm?=
 =?utf-8?B?NVVMbllvMndtTlpONnNkUHdWRUZFeHgyVWR5U1NtdXVzb3FEcEFydTRFc1V5?=
 =?utf-8?B?cSt4b0JiNXNObW5ibnVBbFV2TFd4WjFFN01GMTllL2kvcCthaGVUZUNHNDNC?=
 =?utf-8?B?UDBwejRuZStYR0R3ZldnWUluWUJwVkYxL011L0svY2hHeVk2Q1VWNmR0V2sr?=
 =?utf-8?B?UzdGTk5kcC9ENjEvcWxVTzNYb2lmM1F3djRnNGhKRldtNEg4cnlzTFpuNkdi?=
 =?utf-8?B?K1BVbHRKZlBWN1ZDS2MzNzdqdzBVanR5V2ZDdWxCUVJpZFZ0NzV6bWQreXY4?=
 =?utf-8?B?cXNiTDR6L25wT0ZiQ2tCL1IvaWV5NWE2V21ENjFyNXVMNXVUTGhCZzlaVkF3?=
 =?utf-8?B?ZU1RNTlYVmRZdjZGRm1rcDN4UlJEUjBINDlzTCtTYnZpeTVlTWR6UjNHMHJ6?=
 =?utf-8?B?R2g5SVdrNlNTWS9XMXdzNkxlR3JCUXZrSGN3RTQ5T203OXdOcVZGUmZETHRU?=
 =?utf-8?B?YXdBcUhFeklVWUZhdVFFb1ZOcEVWUndBaW9Hd2c2VWwydk55b01BK3Y4bFRs?=
 =?utf-8?B?N0hxejU4b3JodWZ1RjR5dWtDZGN5eDh3WGNwWTRvWlcvWFQvUXk0WFZIclpj?=
 =?utf-8?B?ajhxc3p0dG1Db2NBcVhzR0x4SzRSMGlRd2VhYVVlQ1cvNWpEbks1VkNJKzNs?=
 =?utf-8?B?emRRMkxGOUJyU2Rld0hWWlRnVjJ6cDNYazFmY0JpUTVqTFhJd0FxNUNqQUIz?=
 =?utf-8?B?WXRZQUxKVkRsSTdGbW9Zb1czci9EQmN2NjRCdXVKcHJvRlRKTnZnS1I5aFFI?=
 =?utf-8?B?alM5TWFLRHdEb3hoYlhoZnJvdEQ4ODRFVzJIUm10ajJScGEySGhpdXB1YklS?=
 =?utf-8?B?cjlRZ003VkhFeGg3SU5KcWRBVlBBZHBLVitaS1hTQmErOEExNU1UeWJTVnZy?=
 =?utf-8?B?bXo1ZXFwZVkrclFoTGtXa2JzemdRdE9OYjdzMFV5dzdQVmNpbWJJeThpL2Ro?=
 =?utf-8?B?UHhaRHlzR2RjKzhIRFFqbEYrb0dBWCtQM2ZWWXFMQ2VYblpYdWMxdStOUEl3?=
 =?utf-8?B?OXZFYWxjdDFGS2g1WjZqM3VMdUdLU0IyYUZrQVNyMXZVTi9hYWpMZUFSeXNh?=
 =?utf-8?B?ZFdjWUw3RXRtOFJReHMvSEdUREJHcGxwSEZsNGRTQ2kreTVaYUFWWVdLdGpE?=
 =?utf-8?B?MnB5TEdlUXN1bzRSZVdJZFVnK3NwVGVxcUNOdDVDUDhGK21DeU51QzBCK0dk?=
 =?utf-8?B?b1pPSHVaMVI2YWxPWEZqR2NNS2VOZWRKN0FHNUxONjJ2QWhPNFBaWjRxZjFH?=
 =?utf-8?B?NFNjSXoyVzA4SDdSbXBwRmFUU3ZCRWlzYzZBYmx6QnhkTElXVWRETWJQcW5S?=
 =?utf-8?B?ZGxUbUhINFl3TVFVc2ttc05aQktUQlJmeDl5WUZkMW9VdTQ0TVVSMm9ibjZM?=
 =?utf-8?B?clVKRFlKQWxqRURoNkYzcjFBQllMLzZDcXdnczFoM2t0N3hYNVFDWWVFbmxG?=
 =?utf-8?Q?shdJzLoojpxWW/+bu/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D82AC1FBA812514C88FEDB43BB1B4129@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273ea6c0-2efd-4438-2b11-08d9aaeb4b5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 23:29:40.6069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: esl7iN/QLFGhmJuHavgev281WNyKU2w5Do96OGn0DIQ4dLwc3r5rOqBz81QbyfkXx3DdFBd7JUA70Su8uOhsqDudTMPAMQOWgU9DeHZ57zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5210
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10172 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111180120
X-Proofpoint-ORIG-GUID: djucKJX_S5nszqTxtam2TCiq98SOy1u6
X-Proofpoint-GUID: djucKJX_S5nszqTxtam2TCiq98SOy1u6
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCj4gT24gTm92IDE4LCAyMDIxLCBhdCAzOjU5IFBNLCBNaW1pIFpvaGFyIDx6b2hhckBsaW51
eC5pYm0uY29tPiB3cm90ZToNCj4gDQo+IEhpIEVyaWMsDQo+IA0KPiBPbiBNb24sIDIwMjEtMTEt
MTUgYXQgMTk6MTUgLTA1MDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+PiBQYXJzZSB0aGUgWC41
MDkgQmFzaWMgQ29uc3RyYWludHMuICBUaGUgYmFzaWMgY29uc3RyYWludHMgZXh0ZW5zaW9uDQo+
PiBpZGVudGlmaWVzIHdoZXRoZXIgdGhlIHN1YmplY3Qgb2YgdGhlIGNlcnRpZmljYXRlIGlzIGEg
Q0EuDQo+PiANCj4+IEJhc2ljQ29uc3RyYWludHMgOjo9IFNFUVVFTkNFIHsNCj4+ICAgICAgICBj
QSAgICAgICAgICAgICAgICAgICAgICBCT09MRUFOIERFRkFVTFQgRkFMU0UsDQo+PiAgICAgICAg
cGF0aExlbkNvbnN0cmFpbnQgICAgICAgSU5URUdFUiAoMC4uTUFYKSBPUFRJT05BTCB9DQo+PiAN
Cj4+IElmIHRoZSBDQSBpcyB0cnVlLCBzdG9yZSBpdCBpbiBhIG5ldyBwdWJsaWNfa2V5IGZpZWxk
IGNhbGwga2V5X2lzX2NhLg0KPj4gVGhpcyB3aWxsIGJlIHVzZWQgaW4gYSBmb2xsb3cgb24gcGF0
Y2ggdGhhdCByZXF1aXJlcyBrbm93aW5nIGlmIHRoZQ0KPj4gcHVibGljIGtleSBpcyBhIENBLg0K
Pj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBFcmljIFNub3diZXJnIDxlcmljLnNub3diZXJnQG9yYWNs
ZS5jb20+DQo+PiAtLS0NCj4+IHY3OiBJbml0aWFsIHZlcnNpb24NCj4+IC0tLQ0KPj4gY3J5cHRv
L2FzeW1tZXRyaWNfa2V5cy94NTA5X2NlcnRfcGFyc2VyLmMgfCA5ICsrKysrKysrKw0KPj4gaW5j
bHVkZS9jcnlwdG8vcHVibGljX2tleS5oICAgICAgICAgICAgICAgfCAxICsNCj4+IDIgZmlsZXMg
Y2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvY3J5cHRvL2Fz
eW1tZXRyaWNfa2V5cy94NTA5X2NlcnRfcGFyc2VyLmMgYi9jcnlwdG8vYXN5bW1ldHJpY19rZXlz
L3g1MDlfY2VydF9wYXJzZXIuYw0KPj4gaW5kZXggNmQwMDMwOTZiNWJjLi5mNDI5OWI4YTQ5MjYg
MTAwNjQ0DQo+PiAtLS0gYS9jcnlwdG8vYXN5bW1ldHJpY19rZXlzL3g1MDlfY2VydF9wYXJzZXIu
Yw0KPj4gKysrIGIvY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy94NTA5X2NlcnRfcGFyc2VyLmMNCj4+
IEBAIC01NzEsNiArNTcxLDE1IEBAIGludCB4NTA5X3Byb2Nlc3NfZXh0ZW5zaW9uKHZvaWQgKmNv
bnRleHQsIHNpemVfdCBoZHJsZW4sDQo+PiAJCXJldHVybiAwOw0KPj4gCX0NCj4+IA0KPj4gKwlp
ZiAoY3R4LT5sYXN0X29pZCA9PSBPSURfYmFzaWNDb25zdHJhaW50cykgew0KPj4gKwkJaWYgKHZb
MF0gIT0gKEFTTjFfQ09OU19CSVQgfCBBU04xX1NFUSkpDQo+PiArCQkJcmV0dXJuIC1FQkFETVNH
Ow0KPj4gKwkJaWYgKHZbMV0gIT0gdmxlbiAtIDIpDQo+PiArCQkJcmV0dXJuIC1FQkFETVNHOw0K
Pj4gKwkJaWYgKHZbMV0gIT0gMCAmJiB2WzJdID09IEFTTjFfQk9PTCAmJiB2WzNdID09IDEpDQo+
PiArCQkJY3R4LT5jZXJ0LT5wdWItPmtleV9pc19jYSA9IHRydWU7DQo+PiArCX0NCj4+ICsNCj4+
IAlyZXR1cm4gMDsNCj4+IH0NCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvY3J5cHRvL3B1
YmxpY19rZXkuaCBiL2luY2x1ZGUvY3J5cHRvL3B1YmxpY19rZXkuaA0KPj4gaW5kZXggYTliMmU2
MDBiN2NjLi42MWM2NmJlODA5OTUgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2NyeXB0by9wdWJs
aWNfa2V5LmgNCj4+ICsrKyBiL2luY2x1ZGUvY3J5cHRvL3B1YmxpY19rZXkuaA0KPj4gQEAgLTI4
LDYgKzI4LDcgQEAgc3RydWN0IHB1YmxpY19rZXkgew0KPj4gCWJvb2wga2V5X2lzX3ByaXZhdGU7
DQo+PiAJY29uc3QgY2hhciAqaWRfdHlwZTsNCj4+IAljb25zdCBjaGFyICpwa2V5X2FsZ287DQo+
PiArCWJvb2wga2V5X2lzX2NhOw0KPiANCj4gRGF2aWQgYWRkZWQgImtleV9pc19wcml2YXRlIiBp
bnRlbnRpb25hbGx5IHdoZXJlIGhlIGRpZC4gIEFkZGluZyB0aGUNCj4gImtleV9pc19jYSIgaW1t
ZWRpYXRlbHkgYWZ0ZXJ3YXJkcyBkb2Vzbid0IGNoYW5nZSB0aGUgc3RydWN0IHNpemUuDQoNCk9r
LCBJ4oCZbGwgY2hhbmdlIHRoYXQgaW4gdGhlIG5leHQgcm91bmQuICBUaGFua3MuDQoNCg==
