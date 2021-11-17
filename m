Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A654454BD6
	for <lists+linux-efi@lfdr.de>; Wed, 17 Nov 2021 18:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbhKQRYg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Nov 2021 12:24:36 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20100 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229585AbhKQRYf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Nov 2021 12:24:35 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHGLwc5009085;
        Wed, 17 Nov 2021 17:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Zk+iMBMJEby6hx3gW8grT7yR1RYBd7V61YKwqCXQtBs=;
 b=V+jMf1znOwW3r11pGOxT9wUuuZn50VMz245QtKSjX9M0zbSdd+HHymIVY1qCmvELMmfL
 WmmkyHcCjabucvxmqBGDZ+kSoBmcIR96DDpZ+qsTrLlDsf6kd4SdURy6qbg9EOC5x+Lm
 ylOtyI/iW8Uv6sBvyA4VIhfqA+jU5ZI+nblBld2diO13D513863DLWacjpzeH9P7XHcd
 33iV01Xe3GYMLTn+MjZ7AlkratzmROAygXqpy/84wQ8guHqoKIYxIj3A25IgJVVO4dj6
 o+n2EHK8hKCYtZy+bFLv0GUbzUsQAZwZp6JW9KF+m+OYJMoMQs37TWT79Hse2DXuZdr9 ig== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd2ajhsq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 17:20:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AHHFElE027655;
        Wed, 17 Nov 2021 17:20:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3020.oracle.com with ESMTP id 3caq4ujppw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 17:20:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKfZ48L7D7t2sslL6XxZgE4otenfnXWBoV8mdak4TrNzOjV9xXt9zyL0lwhSY9DNmTcEJkCEnsXcQPmzqeirZDztvGPAocb7Mub7oP0QHt0NMVc4K05lKT87QzcCDmgubWX6blwus0o4HzuFdegrcoyEnDFGmt2cxEs80DL0VO+0483qrGauS3Io+GT1n8yte5aRR7JWCD/0esOnE+UbOOHYlQClch7EvB+IEYRa62bXb4Yy2sPnyOFincFFCiGj1dDEVf8qDhHIhcdlHSjDhJIlIK4Ibmg0ZhpVPQAIAFjw5IY27Zqc0CcylsM+qFj4dj8wEOIC78CXr19ZCfC8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zk+iMBMJEby6hx3gW8grT7yR1RYBd7V61YKwqCXQtBs=;
 b=G/3J6jydToVXTIRwQ0P14ViwKh04e5cI3aGzrXZTcpBDJ3NTeHnoSdND98Yjssxy6x2aKznrVdXLbxTeRMdtJPZmaqZit4PcVqyZhRqI3k9zeYa0sFssb4rTTBQx5p0Lfr4ZhvK6fdXygEh2yJSiXZLdq0bizw8OfJqsMp8lscli+xcx493oknY7IQ+ec6pVzr5I6yUcygIBuK9U43MaduclE3OPQHYqQv+OMH0wdfBtNIMx1h2VW7wh02i5FLFcxC47iHV3Av6HOF8joBtpdHjeEt4Ufbm3vL1I7s8zhKmIkm4aESgmFtkB4/CzVfCaOyFIeEQtRKyqZn1CzkjRgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zk+iMBMJEby6hx3gW8grT7yR1RYBd7V61YKwqCXQtBs=;
 b=GX8+XBgCsM1ZhRwyOvmMjgjSbflsZqM1PnC32w7aTc2M1dsVilgpCaeEXz/T4R2oeUzQGlVc1mwNRwbwVJFEu9ZN+d4ynwXRTmqoJ28o9/LqiRC5Zk4duLyYTnAJ5wwG0k3oBKknzzKcGkFJJttY+2t/8w2/rxtEWsXbIJG+xm4=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5322.namprd10.prod.outlook.com (2603:10b6:610:c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Wed, 17 Nov
 2021 17:20:53 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4713.021; Wed, 17 Nov 2021
 17:20:52 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Konrad Wilk <konrad.wilk@oracle.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC:     "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
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
        "pjones@redhat.com" <pjones@redhat.com>
Subject: Re: [PATCH v7 00/17] Enroll kernel keys thru MOK
Thread-Topic: [PATCH v7 00/17] Enroll kernel keys thru MOK
Thread-Index: AQHX2n8oMRUgs/J6QU6v5OZpHnpl1awGUS4AgAAE7ICAAAHeAIAABBAAgAD+koCAAAA+gIAAmeYAgAAFMgA=
Date:   Wed, 17 Nov 2021 17:20:52 +0000
Message-ID: <7E672BCB-EEA7-4DB8-AEB1-644B46EBE124@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
 <eac5f11d7ddcc65d16a9a949c5cf44851bff8f5f.camel@kernel.org>
 <YZPZww0bafYEQ0VS@0xbeefdead.lan>
 <f30a1399208a88257b3ff25b369088cf88a96367.camel@kernel.org>
 <YZPevFtTucji7gIm@0xbeefdead.lan>
 <8fcadcf2a5da5118fb7f9caea0a61440525a67b2.camel@kernel.org>
 <3939a2fac50d2e836c48855b1b00c7b36659f23f.camel@kernel.org>
 <YZU1lkBkphf73dF+@0xbeefdead.lan>
In-Reply-To: <YZU1lkBkphf73dF+@0xbeefdead.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ab6919c-11a7-4c9f-2e9a-08d9a9ee9bac
x-ms-traffictypediagnostic: CH0PR10MB5322:
x-microsoft-antispam-prvs: <CH0PR10MB53221B279A7D9317D9B8B134879A9@CH0PR10MB5322.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WYaWod+LK2N3RmikfompvFCXrbaDZ4miwcV4ax0GvcfOlPj0wbbvjnx7vLecvJrH4zUlKSkykaP+LjUD48Ki30+9JDIps7cnViAbguJuMAehr5nFlwUgglCJqZECUMOVXV7DlxEH2Li1RUQxlZPZA3q0Hx+IA9sM4Cxa7zSx1VmxAyWwZ1FOh/vKldqFNnRu2UCdVFDhu8rhjZX0TSWVpz42OAjSfxx+iAoNwTq9seNT4Hnn8vL0Uiwnv4og2W/z83N7XDTCvRtVR6X6z4F6T7JS0XQ8GzkhxBJerQN9xpP+RpAVARPNMOHR5GTdgcm6GYwRA9g0oxFFZWwnQH6yTuo8aJXULoRG4unzc4tUsIil4X4MhV1brr5kcB5d+ST0J/RetcdNODmB1nJM4IRC9bcHVOUIBbn2QuAxQ6U1ANwBq9eTGNtnEthP8LZ7yDXKfdTlj/KWD/8z8//db3/Z6mrlE9QiTEAtLIQZ8RZHmOPxTf2SrjwieOrRBnp9jsezIscdXh9bxv2hDjg64xAMXUogF72BLLeRwADtgALtzx86XccHuJFyIHcgLHYKhoC/teuaGVQChdeBNp4ap8VC3970oBIBIjU2ZIqskONIVDWslSMKByv3UbPnHWznvC3gWSSjQBBpkJ0V2ItLCM9MTcmkRfsya9ytoDOY4+PUl0/iDSMVkW9PE8CcdLKZ9ImdVgg07f+8Fq4ZRdw6z5jVWYtdEqmKzaPQtMTo7Oyoz1CzOUDoTV3KA8q6DBzvMDpQI28QRmk7Rq2gM9IOhlzi6QSr2wR9Qe5e1NbgIpUlupW/T/t3bg5IwGzJA1sxfgRHgbqQqptnedA2EciWXGiL2vD9Dd0TKMTfqoABM7eft/w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(4001150100001)(64756008)(4326008)(66556008)(66446008)(7416002)(66476007)(76116006)(5660300002)(66946007)(91956017)(36756003)(966005)(186003)(2616005)(8936002)(6486002)(6506007)(45080400002)(8676002)(44832011)(508600001)(6512007)(122000001)(38100700002)(86362001)(53546011)(71200400001)(2906002)(54906003)(110136005)(83380400001)(38070700005)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VndOWjV3bkx4UG5qSjZaUTQxWFY5QU9uaG44OWJrY3dCT0ZNRU13cm1BbHgv?=
 =?utf-8?B?UmdJd3l6U01jYjhGRTNzeUkrd1RHRGZvZ3dnMFYzTGdFZ0NiNStWRlNPYkZn?=
 =?utf-8?B?VmVlZWY5TFhubmtheGRzTVErK2pKSjFxeittT3RySksrNHI2dm1McHFKY2Fa?=
 =?utf-8?B?Q1RsVzdDdEVwRGZLMldXelpxYW1uMXdVWWlBR1BqOE5KUGFvYXh2Nlhia2hs?=
 =?utf-8?B?Nlo1eFBWSGRLdnl4WkRZNUY1R1kwdFNuN3FyWHA5eG9uQU9MblowK1RNRC9G?=
 =?utf-8?B?SnkvNldhdUtnVFFqVXlrMHE4RWxSaGpuZTRwTTBmRzhNWTZWYkJwUGo5aUtX?=
 =?utf-8?B?SmFUeWpISnlyb1Zsb2t4NW8yMk5oTHptSlVnd1BNODd5MVVuVXdSNUIzelVs?=
 =?utf-8?B?VVBtOG1wQlgwVXVld3ZBd3FrMWdvOXpIdnNRVzZyVTMvMTJRTER6OGd1blE0?=
 =?utf-8?B?aXhWWTJFT2xFakoyd202LzVyQU9XNkZ0SW11WVNWbjVVZDVXc2tFR29rZTU0?=
 =?utf-8?B?amFDMkd0SmhQZHUvYVhETk1Rb01aV05TOFk4UmV3SDFxSXB4NzlPMDZFdmRq?=
 =?utf-8?B?bWpPekFBbDNpdzdoKy9uVmJ6bll2UnJzOU1hZEtoeTJXS0FYVUlqRHVlU09m?=
 =?utf-8?B?RTc2aGVIeHFpN3puUjhPeng4WW5sd0FNUE9CdUtUZFo2K3ZqTXd3RkI4TFNB?=
 =?utf-8?B?ZUI2VkZaUjBITm9ka2RyaExGUmd0KytnTkR5T3ZDbmx3bGl2NVYwSjdXUys2?=
 =?utf-8?B?WVJVZW43RGkwV3A5T0xEWG1LMDkxNytRVHV4enBnS2ZKNVp6UkVTWVdrYVBw?=
 =?utf-8?B?QVR6d3VQUnBNTkU4SjQ0bnVFVjhwZ2d4QjRGQjREbXZ6WFNNK1Vjei8rY1N2?=
 =?utf-8?B?WUordmh4ajRjUllTTUw4YXM5bWxHUDRRSXgyOTdRczl0UGdwc2J0cThneXFZ?=
 =?utf-8?B?ZDdTNUVCSTZaK2NBZWFpb1E4SmIxcUlpc0xPNExuY2psSWhGaHpiTG1Ta0Y4?=
 =?utf-8?B?OWFMWnZwK0VGQjJwS3czMlcrUU5SSG9Zakw2SW5BZE8vSDY5azFHTiswMG1s?=
 =?utf-8?B?bTRPZDBXWjA1RU1IN0RYSVNtRnlEQ0ljNkVzZDJSSHVaY1Q5SjNWVHQ2ZEt1?=
 =?utf-8?B?VnVaUFRIektjekxvZytqd3FtOWhSSDRjdXExWnVOZWtydHRZVi8xUjY3ZzY4?=
 =?utf-8?B?TGR1MG1xNTdVVkpiYk85cStGU0p4UXdsTUgrcGlJUzg5b3JwME1CWUVGSHlB?=
 =?utf-8?B?dzRsOGxZd08vb3F1MDZWQStENFBqYjhhY3NHRTNPYUEveXYvalJPbWs4cmFP?=
 =?utf-8?B?NnZVRFpOTXBrbWFZdTNXMHE2Vjl3dmwzcUJYWFlsbERjVnV5UzRFcG9NbHFv?=
 =?utf-8?B?cjRyMW5YNlNwa3hlM3RwbzQ3M1loMnpaMDAvMnIzRlJab2ZOZThvMFRLN0ts?=
 =?utf-8?B?WU9oNDVHbGxLU3FLMm9hMGFrSnJpUlhCL0M2SWR2cUM2RGRneTk5dUQrY0Jh?=
 =?utf-8?B?TnBRMURQNkx6UklMMlYyeGRCeWlZRjgxZERIUy9NT3NRRVJkR0pXSmFURmZI?=
 =?utf-8?B?bENLNitXS2RoQW9ZY0s3dGd0RURyUFErTUI0L3NlNHo0bHlBR0lIU3RaZk5E?=
 =?utf-8?B?Zk5nV21YQWdXa1FDbURxbmxtcEpGZldlUTZERlFndzhQYU5LeW5GSEdKcTdP?=
 =?utf-8?B?ZExkNkxQbnZyR0lTckxYQ2NrcEptd3gwd1lHYXhrSVkvYWpTTExYdWtWc1JR?=
 =?utf-8?B?QnFNaGwvRzBtenc1QjQ1S3dvb2dTRmxwVldjZlpJK2xrU3BFbWJZcWtNTkxv?=
 =?utf-8?B?R2RKc05oeVFqVEljZ0Evb3owaVpscy9hSHdpamhxaUdkdWtVa3BLcnBhYlZY?=
 =?utf-8?B?SjJqZDltYmdjcGZQdGsxaUZrWnJRV25YblpldzhGdjJCMm45bXcySVlqMWE5?=
 =?utf-8?B?SVRnaEZaWTRYM2t1WWsxQWhsNHJuY1Z1d0FBaSt1VEo3TFREbittemxGa3d1?=
 =?utf-8?B?SmhqQVB6bVBoMUFiOHErY3VzdU0wZi9JdHIza0REQUFEelhIdGwwRFlrUUxO?=
 =?utf-8?B?SVhtbjV0TzZUZEh0TFhYdm04SHIwZzdOTmFjdVRrZ1F1S2dWTzFmamxmNS8v?=
 =?utf-8?B?bVhDZ1F4Z3BzTkN3RDFMUk5kSWhFUU1aNlBpYzlidndaejRmdDFaWGl5dnpa?=
 =?utf-8?B?L1F4MjJIcGx4VWFsTGtnam1EWGExRVRTRHFPK00wRHFSblJjTmJuWVBtdmhH?=
 =?utf-8?B?OGtCb2ZKM3ZZeHMzVE9tL1I1bVRiUUlzVDgyemFqL1VHQkZwWWZpV0I5bEN2?=
 =?utf-8?Q?587ZTMBw5iYhUF1Dh5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1B31B159D2D364F98139A208728741C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab6919c-11a7-4c9f-2e9a-08d9a9ee9bac
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 17:20:52.7434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k82NFyU/tUS6sJpkcj3s7jx8J2lMSiLGpPtFOCfcRSTK9AvtdjLZi6UtxVurUYNuWI4+kWn+8O1vqyygbg8QLHsp8963VydfTKRqO6bi6YI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5322
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10171 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111170080
X-Proofpoint-GUID: kxdMwwgBRG0m4xOy45Z918t_hludx2TG
X-Proofpoint-ORIG-GUID: kxdMwwgBRG0m4xOy45Z918t_hludx2TG
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCj4gT24gTm92IDE3LCAyMDIxLCBhdCAxMDowMiBBTSwgS29ucmFkIFdpbGsgPGtvbnJhZC53
aWxrQG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBOb3YgMTcsIDIwMjEgYXQgMDk6
NTE6MjVBTSArMDIwMCwgSmFya2tvIFNha2tpbmVuIHdyb3RlOg0KPj4gT24gV2VkLCAyMDIxLTEx
LTE3IGF0IDA5OjUwICswMjAwLCBKYXJra28gU2Fra2luZW4gd3JvdGU6DQo+Pj4gT24gVHVlLCAy
MDIxLTExLTE2IGF0IDExOjM5IC0wNTAwLCBLb25yYWQgUnplc3p1dGVrIFdpbGsgd3JvdGU6DQo+
Pj4+IE9uIFR1ZSwgTm92IDE2LCAyMDIxIGF0IDA2OjI0OjUyUE0gKzAyMDAsIEphcmtrbyBTYWtr
aW5lbiB3cm90ZToNCj4+Pj4+IE9uIFR1ZSwgMjAyMS0xMS0xNiBhdCAxMToxOCAtMDUwMCwgS29u
cmFkIFJ6ZXN6dXRlayBXaWxrIHdyb3RlOg0KPj4+Pj4+Pj4gSSBoYXZlIGluY2x1ZGVkICBhIGxp
bmsgdG8gdGhlIG1va3V0aWwgWzVdIGNoYW5nZXMgSSBoYXZlIG1hZGUgdG8gc3VwcG9ydCANCj4+
Pj4+Pj4+IHRoaXMgbmV3IGZ1bmN0aW9uYWxpdHkuICBUaGUgc2hpbSBjaGFuZ2VzIGhhdmUgbm93
IGJlZW4gYWNjZXB0ZWQNCj4+Pj4+Pj4+IHVwc3RyZWFtIFs2XS4NCj4+Pj4+PiANCj4+Pj4+PiAu
LnNuaXAuLg0KPj4+Pj4+Pj4gWzZdIGh0dHBzOi8vZ2l0aHViLmNvbS9yaGJvb3Qvc2hpbS9jb21t
aXQvNGU1MTM0MDViNGYxNjQxNzEwMTE1NzgwZDE5ZGNlYzEzMGM1MjA4Zg0KPj4+Pj4+IA0KPj4+
Pj4+IC4uc25pcC4uDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBEb2VzIHNoaW0gaGF2ZSB0aGUgbmVjZXNz
YXJ5IGZlYXR1cmVzIGluIGEgcmVsZWFzZT8NCj4+Pj4+PiANCj4+Pj4+PiBIaSENCj4+Pj4+PiAN
Cj4+Pj4+PiBJdCBoYXMgYmVlbiBhY2NlcHRlZCBpbiB0aGUgdXBzdHJlYW0gc2hpbS4gSWYgeW91
IGFyZSBsb29raW5nDQo+Pj4+Pj4gZm9yIGEgZGlzdHJpYnV0aW9uIGhhdmluZyByb2xsZWQgb3V0
IGEgc2hpbSB3aXRoIHRoaXMgZmVhdHVyZSAoc28gc2lnbmVkDQo+Pj4+Pj4gYnkgTVNGKSBJIGZl
YXIgdGhhdCBkaXN0cmlidXRpb25zIGFyZSBub3QgdGhhdCBmYXN0IHdpdGggc2hpbSByZWxlYXNl
cy4NCj4+PiAgICAgICAgICB+fn4NCj4+PiANCj4+PiBTaG91bGQgdGhhdCBiZSBNUywgb3Igd2hh
dCBkb2VzIE1TRiBtZWFuPw0KPiANCj4gTWljcm9zb2Z0IDotKQ0KDQpDb3JyZWN0LCBJ4oCZbGwg
Zml4IHRoYXQgaW4gdGhlIG5leHQgcm91bmQuDQoNCj4+Pj4+PiANCj4+Pj4+PiBBbHNvIHRoZXNl
Og0KPj4+Pj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9yaGJvb3Qvc2hpbS9wdWxscw0KPj4+Pj4+IGh0
dHBzOi8vZ2l0aHViLmNvbS9yaGJvb3Qvc2hpbS9pc3N1ZXMNCj4+Pj4+PiANCj4+Pj4+PiBkbyBt
ZWFuIHNvbWUgZXh0cmEgd29yayB3b3VsZCBuZWVkIHRvIGdvIGluIGJlZm9yZSBhbiBvZmZpY2lh
bA0KPj4+Pj4+IHJlbGVhc2UgaXMgY3V0Lg0KPj4+Pj4+IA0KPj4+Pj4+IEhvcGUgdGhpcyBoZWxw
cz8NCj4+Pj4+IA0KPj4+Pj4gWWVzLiBJJ2xsIGhvbGQgd2l0aCB0aGlzIHVwIHVudGlsIHRoZXJl
IGlzIGFuIG9mZmljaWFsIHJlbGVhc2UuIFRoYW5rIHlvdS4NCj4+Pj4gDQo+Pj4+IE5vdCBzdXJl
IEkgdW5kZXJzdGFuZCAtIGJ1dCB3aGF0IGFyZSB0aGUgY29uY2VybnMgeW91IGhhdmUgd2l0aCBz
aGltDQo+Pj4+IGNvZGUgdGhhdCBoYXMgYmVlbiBhY2NlcHRlZD8NCj4+PiANCj4+PiBNYXliZSBt
eSBjb25jZXJuIGlzIHRoYXQgbm9uZSBvZiB0aGUgcGF0Y2hlcyBoYXZlIGEgdGVzdGVkLWJ5Pw0K
Pj4+IA0KPj4+IFByb2JhYmx5IHdvdWxkIGJlIGVhc2llciB0byBnZXQgYSB0ZXN0IGNvdmVyYWdl
LCBlLmcuIGZvciBwZW9wbGUgbGlrZQ0KPj4+IG1lIHdobyBkbyBub3QgZXZlbiBrbm93IGhvdyB0
byBzZWxmLWNvbXBpbGUgU2hpbSwgaG93IHRvIHNldHVwIHVzZXINCj4+PiBzcGFjZSB1c2luZyB0
aGUgcHJvZHVjdCBhbmQgc28gZm9ydGguDQo+PiAgICAgICAgfn5+fn5+fn5+fn5+fn5+fn4NCj4+
IA0KPj4gZm9yIHRoZSBlbmQgcHJvZHVjdA0KPiANCj4gPG5vZHM+IFRoYXQgbWFrZXMgdG90YWwg
c2Vuc2UuIFRoYW5rcyBmb3IgdGhlIGV4cGxhbmF0aW9uLCBsZXQgbWUgZG91YmxlDQo+IGNoZWNr
IHdoZXRoZXINCj4gDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9yaGJvb3Qvc2hpbS9ibG9iL21haW4v
QlVJTERJTkcNCj4gDQo+IGlzIHN0aWxsIGNvcnJlY3QuDQoNClRob3NlIGFyZSB0aGUgc3RlcHMg
SSB1c2UgZm9yIGJ1aWxkaW5nLiAgIEkgdGhlbiBtb3ZlIG92ZXIgbW14NjQuZWZpIGFuZCAgDQpz
aGlteDY0LmVmaSB0byB0aGUgRVNQLiAgSSBjYW4gYWRkIHRoZSBzaGltIGJ1aWxkL2luc3RhbGwg
aW5zdHJ1Y3Rpb25zIHRvIHRoZSBuZXh0DQpjb3ZlciBsZXR0ZXIgSWYgeW91IHRoaW5rIHRoYXQg
d291bGQgYmUgYXBwcm9wcmlhdGUuDQoNCg0KDQoNCg==
