Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B2B4626CC
	for <lists+linux-efi@lfdr.de>; Mon, 29 Nov 2021 23:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbhK2W5n (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Nov 2021 17:57:43 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19950 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235742AbhK2W5H (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Nov 2021 17:57:07 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATM54HP020991;
        Mon, 29 Nov 2021 22:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=lTjzQjdEk+dBdS/m9E+KTgEs3d7HSW+rr3w8kvk3mGo=;
 b=AW8OE4HuaGYsvn04QNXAFIrRTQLTiBQun8ADtsnKOQjXuIWUwiuXRe0xA0AIc0rhSMxZ
 jlEf2DlH0Nyvl1vj8sznLkIZqSBnzdB6onHzx/d3PaE3x0UKAkCt9FXx4n2jH8shImJF
 DZB5us9ZmRKJGPjgy/OnEURisVgGOn0yXKS62zb3RJUvqc+JI39Lzr9PqrxIJTf8ketD
 KbBM6+msvsaws9p+Bhct94kDVa8H97FwBojJBsDefl0xVTBgqWa4skFvYL8ggb/+RQxK
 jTVAfZENQJ16QI1i1OtCLPJE129ru+MgtKmuT1gL6qx8Of1HuzQweMRRAUu+Em3BmDJr 1g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmwmr19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 22:51:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATMfiUg164686;
        Mon, 29 Nov 2021 22:50:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3030.oracle.com with ESMTP id 3ck9sx9nk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 22:50:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVm6o/3ia+CmKYh57tGVJsG0wE/UT6En8EglHzTf+DWarFqV3R2A3XHXAPV6Hjib+37jnf3alBRaKX/bMja8cQIiRnUA5Yk9UCaChwMT9k1FT3KbbEA/uM1H68Z3RAoB2G7ga8L68THreduT8n8wBrMLdZyTCRKMTSyYl20BcDkE9dfYl20WRcAdsTKmhoUOxfwQazA1SK+MomhkmMMapnPYX2U0qY3zA9wz3pN/bC7/xnEjlNir28BOgB8xH9bw6zDDlvv8+tzcKij+fRUBffvnEEaP0AnTshvIeNzDtfKOjqbOm8OVznhoUaGtS4ZpqkPCJit1QQ07LD90Whj9Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTjzQjdEk+dBdS/m9E+KTgEs3d7HSW+rr3w8kvk3mGo=;
 b=hxmo2ekIr4yMrX2KL+7aGMS+XShrhZ0sQRcrkzEDNGoxpzmWO8LSTSuxFLDwL4SO7kxQ9Vr5wY8kju2l1OYDl7JKozuMhkedpcnOMFtb+DyBjCouliaE9Vq1775Kg8ok6L2An2mmiHagYP/P5ub5w63MQ5M4fnYp4THTvgJ76pBcjz3rNjhao4nYWc5bJDYZmztCx480y1YoX6hlJjLT9SyeQy96pYxqWofBmw1ZXF8OuHvstciP6C5nSiZlh0MvD5BQU+cIwf6zcfeguzqy8Aqob2MvL80/FqpKLVPaUALa6dphEtxZGN8hGlEfwkQBnjLBTAeq/e+/E8N3XQjSXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTjzQjdEk+dBdS/m9E+KTgEs3d7HSW+rr3w8kvk3mGo=;
 b=rwL0LJOo+k67yqmegud0NZ4YQIa+46lxc57yJRXKseDjnew+YLprnpzkq0TS/YplapXvIO+aCLlm9gfp+7Jh7wcm3H9JN0OBBNAp/4bXB9FKu80YKWG3H6hWgiqwPhaf03ck4yO0USlzDnBS9kfuD+qx4RFF2T48BQKNXmwW2wE=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3879.namprd10.prod.outlook.com (2603:10b6:610:f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Mon, 29 Nov
 2021 22:50:55 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4713.021; Mon, 29 Nov 2021
 22:50:55 +0000
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
Subject: Re: [PATCH v8 03/17] integrity: Introduce a Linux keyring called
 machine
Thread-Topic: [PATCH v8 03/17] integrity: Introduce a Linux keyring called
 machine
Thread-Index: AQHX4O2fNnT5om4rjEOI1ag/jS1B5qwTjDqAgAeZCIA=
Date:   Mon, 29 Nov 2021 22:50:55 +0000
Message-ID: <DF08B019-DBE7-4236-B784-E5A62EC39198@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
 <20211124044124.998170-4-eric.snowberg@oracle.com>
 <15a001964945969dd7fc2422f0ab1eecfa299211.camel@linux.ibm.com>
In-Reply-To: <15a001964945969dd7fc2422f0ab1eecfa299211.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3351590c-5806-4602-dd0b-08d9b38ab41a
x-ms-traffictypediagnostic: CH2PR10MB3879:
x-microsoft-antispam-prvs: <CH2PR10MB387942191C94B94E1F31ADEA87669@CH2PR10MB3879.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bco0qwYw2jZdKX4qavut1GppcxSU0XPO+iL87cKZ2voi+HldFp69dsxRtT/z3A9sOfEoN/u//dLpegj+w/XqQ2j7mrNcN/z9Agr7MSj7+yjbVOOMcR5SqzEJgZNelTcV77dQZ9PeRUIhz/wQUwe9HHmKgQZnDC9i1xBxJK/1eEnxTFSSDOmkbrp5LRcc6TvwZgeZuUF8WEjuunsRqyOeLYQsTAQfDtjvBtEhDxwZP4hxMfrKNAT8ku7SA1HnPqSWT8SRUAZPOzcE8WQaiv/MdRiunyQXEFrThcGyTw6WR56SLgVtfMafJZA4dVoUIqOWKQaA0wNypYnXr8+48m2e1em0JVhInl0bYcFyF2WNPUNwk3Oc8bB6mAIG+G2vKXH/Gv/bGs+R3bdkThpw0SyduY8KB0+O4BlFZSzLgvpB864htaflEjqOp6cW+Ew0p+9BWbIT52iX17v1JbQyka5jYeCUrz64qYW7UEmuLbaqo+EStZjGkTfmQ62FYCEN3n9f202hPxRPItF5Li33yBPqOnYAuNrWIYLuenLtRWe8FtzfpcXnOE1TfQLhGsoGv+b9vgnQOGBRneD9nRadxjnfek7Pyf7xW/8Xby9GsnFl5V5pCYCPXNTNBaCl8Fk13MfrS+XA5RBC1MjAiTExA8YsY5EPnMCUg4i2dBJx5LdYd5RDc7+aFC/6vk7FxD0M9ZT3cvc2SzLQQsA+BN0Q/2KkQQSr6e+Z9p3RCCdOaiACp2E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4744005)(86362001)(2906002)(66946007)(8936002)(4001150100001)(6512007)(54906003)(107886003)(53546011)(7416002)(508600001)(33656002)(44832011)(6486002)(2616005)(8676002)(91956017)(6506007)(36756003)(122000001)(4326008)(71200400001)(38070700005)(66446008)(66556008)(66476007)(64756008)(5660300002)(83380400001)(38100700002)(6916009)(76116006)(26005)(186003)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXMyck01Qk9OOExsM0ZmNHVZbWUzRnRQTTJBYTBUbmRtRUJ6c0xKTzVWVU1O?=
 =?utf-8?B?TUFwY0JqVFZWT2t4NURGWXV1aVBwdnNGRnI5ZlZlSTFtRDVrVVQxUllpUitV?=
 =?utf-8?B?c0FSM3NkYml3M3I0SXo1N1R0NEE4cGN2Z3NFajRraUxjVDZiNHlvUmFiQUhB?=
 =?utf-8?B?aVZydmtaWldnL1FEaHVreGdWRWdid05ndGM3UDMvSXllcTdRMWQzU3IxNU9H?=
 =?utf-8?B?YzB2R0IwRWxoaGdTM3dwZ3hlVGRSTGdlWkM0OFI5VTc1RjZWWS9KYS9neEpG?=
 =?utf-8?B?R3I1RWJpOHZWSFRCbFRTbFNFMXRMVlZUMXBucEdNcFo5cjBnT2hGM2VtODJz?=
 =?utf-8?B?aVVRajFacXlCT3hpdHp6M0MxSUxlUGpZbDBNSmF3czhOcnVvTUNvTittN1hh?=
 =?utf-8?B?MTNhWFAzbFBtMms3ME9pWFJkMWtiY0NyMzVvaS8wUGRKanhYQXBpSE5nSGpj?=
 =?utf-8?B?RHk3QzFaR3Y3MFRsMkVRWjVJYnplUHZxM2FBdVlaRXNrb1dOSm5CeW0yclFK?=
 =?utf-8?B?M3JEbER2cUtoWHhNaHZLdExiZnU0c0FTbEJwa0dvQmlSdCt1dTFaaFRiTldO?=
 =?utf-8?B?U2lVSi9RS0tsdk1vU1hqTHVSb3RkYkpWb2pMeEorQXhyZWhCRzVVM0pHekt5?=
 =?utf-8?B?a0tXenpvRTUzNDl2eXdOcmtuMjhCV0dBbUQyR05LYURISFV2OGsydmxkQkEw?=
 =?utf-8?B?Vm5IUks1ZElodWg1NEJWZkgvOXJzenhaaURuM1hVaFpLMCtrYjNuS3hlbWVG?=
 =?utf-8?B?aFBUWEZOQklSVzlvZjdNV1lLazlyQWVvYjNKS3VMeTlVN0dsN05VRmZKSXBm?=
 =?utf-8?B?QVFUYWUwNy9HdXpMVjRQS3lEc2t1K01PUWc3RDNJd2JuUnVIVGl5MHBTQzZY?=
 =?utf-8?B?WWdQeTNiWmUyNWtUVXJsRkNsRFFtV2grZmJRVWdLd0VzV3ZVbnFxMG5GWVpB?=
 =?utf-8?B?Y1BDZFFQb010Um1KRmpXWmozL2pnVUl4SXpqcFVCSjZTUGl2TnVWOElIWVJt?=
 =?utf-8?B?czB5Y3pvSnRmVGp5Z1FMZTlmRS9Ed0lxOUVUNE9hdjlNZ2YyNFBSSWNOOXNO?=
 =?utf-8?B?L2VobHRYdUI3Mis1bGRzVlA0bjRhSS9tenlHcThYMmJIR3lTTmplak5nQkJt?=
 =?utf-8?B?ZThpWkxhVHFHS25wNmpjMllkTzRFUkhtcG9IWHdUZkRCL3VHUGxlYjkwdWhB?=
 =?utf-8?B?dzVMblo4cGtrSE1HN0U1MGpYQUpSb0NnYmswZ1lYMG9zVkpRNFVhNmhQQWR0?=
 =?utf-8?B?WmRxbi9QSm9xZ2tjbUJ5Z252TWhPTTI3WGl1Nmg0ZmxEQkYyN0N5blVVckdH?=
 =?utf-8?B?YmlrbjRya3NkUDd1WS8xWjhuOXc2MVRUNUZZalFpUXM0SUFYM2lLWEZlc2Nk?=
 =?utf-8?B?YjJBRnJHeWUvZEc1a3JsK2tHRXVaNTlDVDJQb0xUeUt5MW44dnJ4bEdhTDdB?=
 =?utf-8?B?ODFrUnZzWjAxTGErVXl5RUR0MS9wRnp5OWRDY2drYTVmUm4xQkVPRlAzWk9M?=
 =?utf-8?B?S2c3QVN1Z3dKVXhDbmNFd1MrNmo4YjB0Y2p1ZGJkMUtjSUp2Y2Nzc3RCNzZD?=
 =?utf-8?B?MzM2NzE0SWVCRVFQUklNZkR6U0Y4MjFySlg1YmxGVXZaNnZjZ0pzVGlLTnFt?=
 =?utf-8?B?NUFETC9aRUFPcCthNUczZmpoS0lxTVlyUU9PYmhsNkkxcjlGM09aV05FazNl?=
 =?utf-8?B?QU1SeEF0SGNaVGVMQjR0KzNiRU04em9BeU1RU29SZ2pMQVZPRmFncGIrdHJt?=
 =?utf-8?B?RGVrNmg5bDZFQjRlbDFGd3N4UmtZMVU3OWZ6bGRZcTNTbFNLWDlkV1orei9U?=
 =?utf-8?B?WFUySHRwa0ZpUldUSWk0a3BidERzZzJKbnAzVDJ5NmhwNUNiMnUyQkhtRzBP?=
 =?utf-8?B?ems5MGdyR1BoUEd6L2hrMDN1aGZqVUhkRTd6dmUrYVhkR3dRMXBwaTV4Ujd2?=
 =?utf-8?B?MzRKSGlTemUxWWs0dE9iZ2JmSHVQSzBYSTBRUjNlWHVOSjF1Y3ZKMTdjcFFw?=
 =?utf-8?B?Y0tXczZRVk9ua01PM2w3VzRDVWNsalJ2ck1GT3BNN1Mydnd6N2FDNXE4UW5a?=
 =?utf-8?B?KzNEWndQWGRBMmdtRWJMdFdEd0RzQXhBTnNCdFJaVU9CdlZyWDNDbktOUWdF?=
 =?utf-8?B?MTQ4Tjd3bEtkVnhnSms0TWVuMFRNQmlJS2lFUmE4VERLUmExTzJZMnpCM05J?=
 =?utf-8?B?RXA5NElONXZjaGcveGE4YTc4RlZFdnl0K09xajFIY0JKRXp0YjBjY1MxUzJh?=
 =?utf-8?B?cjRRVm5qc3RFWWRqWGJLYVN0cVhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D3F7C0DA9369748993F9327616CDA37@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3351590c-5806-4602-dd0b-08d9b38ab41a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 22:50:55.5187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J57rD4ryN1932xKzaBs1AKKRfU3d78h3gf0g72RHFRSJEVHNWAe5JWm/63R4BOy1VA5ojMTeaPPBmGxnuVxynHrGro+A0cOeaS2Fc3i3qjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3879
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290107
X-Proofpoint-ORIG-GUID: TZAEgxJHNj0L7_Yf2d-lRt_hB-SyqYgw
X-Proofpoint-GUID: TZAEgxJHNj0L7_Yf2d-lRt_hB-SyqYgw
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCj4gT24gTm92IDI0LCAyMDIxLCBhdCA3OjQ5IFBNLCBNaW1pIFpvaGFyIDx6b2hhckBsaW51
eC5pYm0uY29tPiB3cm90ZToNCj4gT24gVHVlLCAyMDIxLTExLTIzIGF0IDIzOjQxIC0wNTAwLCBF
cmljIFNub3diZXJnIHdyb3RlOg0KPj4gK2NvbmZpZyBJTlRFR1JJVFlfTUFDSElORV9LRVlSSU5H
DQo+PiArICAgICAgIGJvb2wgIlByb3ZpZGUgYSBrZXlyaW5nIHRvIHdoaWNoIENBIE1hY2hpbmUg
T3duZXIgS2V5cyBtYXkgYmUgYWRkZWQiDQo+PiArICAgICAgIGRlcGVuZHMgb24gU0VDT05EQVJZ
X1RSVVNURURfS0VZUklORw0KPj4gKyAgICAgICBkZXBlbmRzIG9uIElOVEVHUklUWV9BU1lNTUVU
UklDX0tFWVMNCj4gDQo+IFNob3VsZG4ndCB0aGlzIGJlICJBU1lNTUVUUklDX1BVQkxJQ19LRVlf
U1VCVFlQRT15Ij8gICBXaXRoIHRoaXMNCj4gY2hhbmdlLCBpcyAgIktFWVM6IENyZWF0ZSBzdGF0
aWMgdmVyc2lvbiBvZg0KPiBwdWJsaWNfa2V5X3ZlcmlmeV9zaWduYXR1cmUiIHRydXN0ZWQgbmVl
ZGVkPw0KDQpJIGJlbGlldmUgaXQgaXMgc3RpbGwgbmVlZGVkLiBJZiBzb21lb25lIHdlcmUgdG8g
dXNlIHRoZSBzYW1lIGNvbmZpZyBhcyB0aGUgYnVpbGQgYm90LCANCndoZXJlIEFTWU1NRVRSSUNf
UFVCTElDX0tFWV9TVUJUWVBFIGlzIG5vdCBkZWZpbmVkIGFuZCANCklOVEVHUklUWV9NQUNISU5F
X0tFWVJJTkcgaXMgbm90IGRlZmluZWQsIHRoZXkgd291bGQgc3RpbGwgaGl0IHRoZSBwcm9ibGVt
IHRoYXQgDQpoYXMgbm93IGJlZW4gZml4ZWQgaW4gICJLRVlTOiBDcmVhdGUgc3RhdGljIHZlcnNp
b24gb2YgcHVibGljX2tleV92ZXJpZnlfc2lnbmF0dXJl4oCdLiANCg0KSSB3aXNoIHRoZSBmaXJz
dCB0d28gcGF0Y2hlcyBpbiB0aGlzIHNlcmllcyB3b3VsZCBiZSBhY2NlcHRlZCwgc2luY2UgSeKA
mW0gb25seSBjYXJyeWluZyANCnRoZW0gdG8gZ2V0IHBhc3QgdGhlIGJ1aWxkIGJvdC4NCg0K
