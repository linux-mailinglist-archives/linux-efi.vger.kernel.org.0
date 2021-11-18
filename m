Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD44C45651D
	for <lists+linux-efi@lfdr.de>; Thu, 18 Nov 2021 22:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhKRVkz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Nov 2021 16:40:55 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:23212 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229777AbhKRVkz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Nov 2021 16:40:55 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIKhxaV020979;
        Thu, 18 Nov 2021 21:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IgQvc7gwhFBDSx7KsNPwZC0WrfqOkkIogQJbuc/IovE=;
 b=tAOE4LMQP/L/q4KDVf5Ybcu7Y27ceE3mN6L3KFNZb77vp4vma8Sg0gmdZlUdKnqvKmTB
 +Tkxr3pFULEl8eOjiE0Dl2w/iCeYK6dBHZpWRSSBB5cBdgtcPUAqlonu4FvmMRflphNc
 hXRXxNBuCHdcCC+ZkOxGf2mQq5w2F8QXPccyopep3kl1IkLL4t3gn92c1xHhu2jiK4LW
 x0B/AMwKyl9bZUgTfl18p8reGJEfB6S372qTo2YknsKNVQOmBzvCV1/j+JImz0d0K9pR
 +dN3Gd9ciwyYc+2JT9H90wKZ86a62YV996oSSQhSlt7xiw8v7Y9Qd9hfgIEEM3PPezYM Qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd4qystur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 21:37:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AILUXe0171529;
        Thu, 18 Nov 2021 21:37:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by aserp3030.oracle.com with ESMTP id 3ccccsehba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 21:37:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxXgst3GnABrw/1Lw4ro9/9xBV4KXOBEijRcTs0H7djMHA1U00DDjc3r27ghMHdRgGuyAORC0+akUu42F885QLbwDA5kWM3ZYotEwU7XQ2RUDDyPA47Nco4xJrHWmIurDG54ay7vTqSrLvOEmY1/f2tojEspb0nM4W2uw7u3XUZjcqx0kuQFCHV/npthsacYpEF2Y+8boVVas2ZHZ2omIKatZhNf/qg0WTcNbhYYKgM1iJEg8i2VqRu4+hMjr7ORXcYzgt59G1/EHsNpnjt0eFuytABr4tvL98MVyayn2di5EhsWdGD4xlE8C+P5YK4/UGyXN1YDqa4/IKEOPWrPlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgQvc7gwhFBDSx7KsNPwZC0WrfqOkkIogQJbuc/IovE=;
 b=cDLNXKiHVIPAQEOaGNk+cjUWMOjalFwGjI85qkLKCByVwzQ5oyPItM1JqzsXEujQMi7UoGLk3+oyxyLOV4WVrqeFm4FYh6W0qrU70CTQ0biXRilAXYkYiUdShg9Uxa7EYpGLUk9ILGBTxIAihrLpqtfWA7iqtgq9IOos5PRmC+IXMNWZ8YgYnIC24pJPnNd39qK50m7fZrI2QjR/jy1gy6LPISJmMAm4yhAHRtAJxgD7yxDmUjJaiWsOEq5sfjmHh6TIXtBSntkvFN05bJv0+0ZByQC7KCIYk26CP8mjnGDuMNHQJunhry9OCTIunC62hbYDupw3IQ40jxuQM+RgIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgQvc7gwhFBDSx7KsNPwZC0WrfqOkkIogQJbuc/IovE=;
 b=l0jevBNeVbQs50STkmH5kXRJQkGr0MU5bjOk+tBIe6KxyMS8K5f++Etqm4k5Z55ih6nGDGIVOxW8hlPKKFgWp3u6RTDJKfpAtiJt9KAAwqXmGUFN0UuPVyyXtaI1CzwkKmX5Y/ehiiczqXYy+JRIhmnSa93PVEvwLpxJEC34Yjg=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB4892.namprd10.prod.outlook.com (2603:10b6:610:dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 18 Nov
 2021 21:37:00 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4713.021; Thu, 18 Nov 2021
 21:37:00 +0000
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
Subject: Re: [PATCH v7 13/17] KEYS: link secondary_trusted_keys to machine
 trusted keys
Thread-Topic: [PATCH v7 13/17] KEYS: link secondary_trusted_keys to machine
 trusted keys
Thread-Index: AQHX2n89MvQ7HB3/cUqIRoLmnQvdoawJO7eAgACYH4A=
Date:   Thu, 18 Nov 2021 21:37:00 +0000
Message-ID: <02B8A5B0-1284-4DC5-A844-21265129C417@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
 <20211116001545.2639333-14-eric.snowberg@oracle.com>
 <e0e704761d5929f73e5e53ac99cd4935ea268cc5.camel@linux.ibm.com>
In-Reply-To: <e0e704761d5929f73e5e53ac99cd4935ea268cc5.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 697349a9-7f42-4c57-c8d0-08d9aadb8db8
x-ms-traffictypediagnostic: CH0PR10MB4892:
x-microsoft-antispam-prvs: <CH0PR10MB4892BDE555C56D642A6FFB84879B9@CH0PR10MB4892.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X13x8K+9BQw5Kxy2Xal4yIHqDsnBbv6uo2gL7I0wRvXyMVtVOush62z+8vWSMRJcQIJm9UxPYTJCwrvPdPitTpo2gmJL58hpHzO/iyrblV1ttq63RsphyR82QooFhDPLDi2Fq+yT9rTxq8IShmqDyqK0Sj0xRschhATie2XHIA/BYL/b9RtzLfL+be1VfhRhNL1DfxaUlK0Ue0UnqkJ/DcLr6U6MrbSJniaBpV3CnABdC5XFGAx+sVOo+2c3hYzf6U1CJ1MucMyltL63tcQeQhuafwCVgU738OIJ/gFiqLjD/h8GP7BbI8ZfwqJVBVtzkVMzzNdHx612gtXkTOTv+CJbXMMnCIucYTzjXahhe7qOD1kWqCqafxW+bbmFkWBA//uB+WJqiAQETwRQJZUiIwUjytMOHjW/Pp/fht9CpFbtfj5MVkEckNcFpAqQadMBH33yxzPnM7huBDlesWiLy/JR2CpWgz2hn1tkmSQM5i+QcdRO5FsMS4LtO6TXU1A4iDBDGdL91ZTgV+vXO52bJms4AzU8+SpZQ9WlsUKlaIQGJg8S+yauU8N91OHfuoASC34pFw0UQKRE/d7GxJlGfJyAkvrHysNC+3xWdYIiFcCfaUal9HRojDut6WwILMlIW0FWUuY7zTk/qcefujVqrAi4I2BkAW0X3MuYbWCdb3ygh7bKdWEafYRO1pOxH9IQCb2+7Rj5dfUTpo3GY6A/6Qi7SNnXs5t6q2/0drmcaiFZaJP4TedjrZZv509opsHY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(6506007)(8676002)(53546011)(6512007)(2906002)(38070700005)(36756003)(122000001)(91956017)(7416002)(86362001)(66446008)(44832011)(83380400001)(66476007)(66556008)(64756008)(508600001)(4326008)(66946007)(5660300002)(2616005)(107886003)(4001150100001)(76116006)(6486002)(33656002)(71200400001)(8936002)(316002)(6916009)(54906003)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGkxbE91K0tWa2RpVXhFbGRtOEx4c280M1dFbWlITm1XMkM2aWdXTWhTc1FZ?=
 =?utf-8?B?Z3Z0ekFCUUp5MTNXY2t4aTIrRWFtYmZDWE95cUh6N0JEK3NlQ1A1Uk9CZ1lV?=
 =?utf-8?B?SGFVc0h1TnJoRzBKQjB4YzNoaGRpTTZabGZWeVN1Y090SUV0UHBiNGltbTFr?=
 =?utf-8?B?ME40dmVOS1V6ait2Q29VTnJIQlkrR1pBNEgvWEJzRUVpUllDeEdteloyY21Y?=
 =?utf-8?B?emsvTDJOc0dobGJOQi9tV3ZTaTJkVXd5NTI5R3Y5a2dVNGszMWp3ejM1NzhW?=
 =?utf-8?B?VmxsUHcxWG9HSzRzYmo4cjF0RVBOOU9oZVUveGFJN2hzS090NUUwNUV4N3k3?=
 =?utf-8?B?TUYrd3hueFd2dmhVUGV3NWZXV1Uvd2kzUlBkdFQ0Qjh1MGtjWjlZY3YzTVNQ?=
 =?utf-8?B?WHZsTUtYaG40UjBmUjlUcUlFRzY2NU1ldGlSUEFwTlNzdTE1TFZ1ZVg2WDJp?=
 =?utf-8?B?eXAvTjNxblZ5SDZZd2NpNjJGeWdqYmxEdndkeG5haWQvcWRLNkN5aHorclNL?=
 =?utf-8?B?ZWdndUxsUFZDZTllWHNRNk9Ic1FGcGF2dk1URUtYa0hxQlVjcThDQlRmUjFO?=
 =?utf-8?B?K2N1b2pwWWttRGZEWTdQZklTd1JESWQ2ckliVkJqZ21iR2VyK0NySFdoRVcv?=
 =?utf-8?B?Q1VoNDRkYThZU1l6SDZIa0NtZ3dlTXYvSFdBSVROdGZ5YmJNZ2xJL3htUG9O?=
 =?utf-8?B?djhRQ3J2a1l6VTJqcnFDYW84MVlYMCtGYlp1WXFSU1JtOVY2TElwOFprR2dl?=
 =?utf-8?B?bFFDYzY2dWtzUitaUjc1c1B1alNodGlCdzh0M3ZPZ2NDT01ZQTZOZU9yR29Y?=
 =?utf-8?B?SWozS282THVwbHh6a3F4ODljYUxXNllMam5MelJYZ0FNS3Nic21rVUtpNk1H?=
 =?utf-8?B?bnk2Ny9xcG1VTFowcjJiRDgyZ0htbVU3eGx4cEFLNFlxMFdXVk9zRVhXZWR5?=
 =?utf-8?B?TlRsM0JhbGdxeXdSUFk3cGpoQUN0MlFBU3Evb2w0Z0NhTnlDSThoeE0zdlZD?=
 =?utf-8?B?djFmcTNJLzJZYVo4QkF2NEFNQUl0NzZYSUEzZzlHVkJ1eXg2alRkckcrcDB1?=
 =?utf-8?B?ZG9UU2xLbUVOUUxzQzNNbkVqRm0xZXk1ZncvUTc0aHFrTEdnTS9tK2RJcGg4?=
 =?utf-8?B?R1dqRXlEelJFNDc4ZW02TjFVZDBWTHI5UEVaMzZSN3ZVRmI3aU1xUEJ5OUgx?=
 =?utf-8?B?WUk5SWVkN2dZSEV0cDJZenlKNGFkUGZVYnNKSzg1RzQxb2oreVcwTGNGVitp?=
 =?utf-8?B?MEtLcEI3UjFwZURyVWVIblNqeWZQK0sybEFsK2xjT2RBek5nczJPWUcrbEJq?=
 =?utf-8?B?ck9WRk4yTHQwWFRMTVlXRHVudG5vWGQ0ZTdlVjdiNGpZQlhpNDV3d2Y5bk95?=
 =?utf-8?B?K2hyU2F2TkVtSEIzY1FRck02M3BKamxkWGloOUJJZE1FUkhzSkhielk0VC9P?=
 =?utf-8?B?RVZ3OHFlc3VhQytYWmRVTGNML3RwRjBZb1pEK1YyeExWL05sTjNyOUo2NGJo?=
 =?utf-8?B?SWgwbnVsZGFuYjM1aXZGdk54UGtWN003K25SWUUxSGZ3U2RjODFHai9jV1lY?=
 =?utf-8?B?TVNiRi9pSDdRbVRqK0E1bzBsbHhuQ08yYmRHdmM1MTd3WkFQLzJ1MU1ETDFq?=
 =?utf-8?B?MUJzTlhDNU9UdnlDMkpHTUtKd1JNbWVuOE92YUQwRzlGeTgxNldPd21wODkv?=
 =?utf-8?B?ekVEc3htYWw3bFg1ZGhDZDdXMlVaT0NHa01nUmZSZHJmRThkZG5RblB1TzdK?=
 =?utf-8?B?ZzBnanFMeTRqN3BLWGsrNnorelpObmNCYWVBYzBDUjN3SnZlOUM4Z1VKYWp6?=
 =?utf-8?B?ZFkwZTlZdEE2K0VzUi9NUmdXcDc0aHU0QWhyRjVKWXN3NkhtYVdVWDltV09t?=
 =?utf-8?B?cDNrNFhDRWpHWXVtZko3bWorSTNoYkl4azJBZGJyTFBQZ20xVldCY2psN2w3?=
 =?utf-8?B?a05DTUJkT2RvUUErbWRNSUNud2lTanR5Q002UnJWUVZXRWNLWkIvaEdhZjVF?=
 =?utf-8?B?ODhOQ25NRjgwUkIzMTM3TC8vUncxSkU2NGI0d29idzNPV3YzNTVlUHp2N05L?=
 =?utf-8?B?UmMvODRjbjUvbkUvekpTOVNXM0dVUXZoMGNOUHhLa3NwQ0duTFF3STM5VHBw?=
 =?utf-8?B?cENHN0o5UGFzUDlXNURVMnNkd0lMNjgvcUJzOTNRWmJPM21Hc0NMTUhjeU5M?=
 =?utf-8?B?UVBNRTZkZUVuOHpjMFo0RnorYVFTbEVJVjJtVDMzNEhMZGRyekdrY0NNTFUr?=
 =?utf-8?B?VjV1TDRkWk5xSTBQRzJCZHFHT1NaL09JM1BjL283NkZseTdqQklaVFl6cFdV?=
 =?utf-8?Q?cknAZLKn+I6gZc1rWZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C18A7FF8E2C4F4B9DA22AA853935E71@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697349a9-7f42-4c57-c8d0-08d9aadb8db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 21:37:00.0389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: awfaP8XuEWYV/m/YvXOLENZDgcLIRMVG2bKSSFDyox1QNiZlhDcT7V9thkzdbpAff9ncVituQExNOwdwweEh6LrXDRfh0UXawj0HPR06KlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4892
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10172 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111180112
X-Proofpoint-ORIG-GUID: P2KzVFKy2l_4njiK_yeFLeW8KJhnfT15
X-Proofpoint-GUID: P2KzVFKy2l_4njiK_yeFLeW8KJhnfT15
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCj4gT24gTm92IDE4LCAyMDIxLCBhdCA1OjMyIEFNLCBNaW1pIFpvaGFyIDx6b2hhckBsaW51
eC5pYm0uY29tPiB3cm90ZToNCj4gDQo+IEhpIEVyaWMsDQo+IA0KPiBJcyB0aGUgc3ViamVjdCBs
aW5lIGxlZnQgb3ZlciBmcm9tIHRoZSBvcmlnaW5hbCBwYXRjaD8gICBTaG91bGRuJ3QgaXQNCj4g
YmUgImxpbmsgbWFjaGluZSB0cnVzdGVkIGtleXMgdG8gc2Vjb25kYXJ5X3RydXN0ZWRfa2V5cyIu
DQoNClllcywgeW91IGFyZSByaWdodCwgdGhpcyB3YXMgbGVmdCBvdmVyIGZyb20gdGhlIG9yaWdp
bmFsIHBhdGNoLiAgSeKAmWxsIHVwZGF0ZQ0KdGhlIGhlYWRpbmcgaW4gdGhlIG5leHQgcm91bmQu
DQoNCj4gT24gTW9uLCAyMDIxLTExLTE1IGF0IDE5OjE1IC0wNTAwLCBFcmljIFNub3diZXJnIHdy
b3RlOg0KPj4gQWxsb3cgdGhlIC5tYWNoaW5lIGtleXJpbmcgdG8gYmUgbGlua2VkIHRvIHRoZSBz
ZWNvbmRhcnlfdHJ1c3RlZF9rZXlzLg0KPj4gQWZ0ZXIgdGhlIGxpbmsgaXMgY3JlYXRlZCwga2V5
cyBjb250YWluZWQgaW4gdGhlIC5tYWNoaW5lIGtleXJpbmcgd2lsbA0KPj4gYXV0b21hdGljYWxs
eSBiZSBzZWFyY2hlZCB3aGVuIHNlYXJjaGluZyBzZWNvbmRhcnlfdHJ1c3RlZF9rZXlzLg0KPj4g
DQo+PiBTaWduZWQtb2ZmLWJ5OiBFcmljIFNub3diZXJnIDxlcmljLnNub3diZXJnQG9yYWNsZS5j
b20+DQo+PiAtLS0NCj4+IHYzOiBJbml0aWFsIHZlcnNpb24NCj4+IHY0OiBVbm1vZGlmaWVkIGZy
b20gdjMNCj4+IHY1OiBSZW5hbWUgdG8gbWFjaGluZSBrZXlyaW5nDQo+PiB2NzogVW5tb2RpZmll
ZCBmcm9tIHY1DQo+PiAtLS0NCj4+IGNlcnRzL3N5c3RlbV9rZXlyaW5nLmMgfCAzICsrKw0KPj4g
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvY2Vy
dHMvc3lzdGVtX2tleXJpbmcuYyBiL2NlcnRzL3N5c3RlbV9rZXlyaW5nLmMNCj4+IGluZGV4IGJh
NzMyODU2ZWJkMC4uMmEyZGM3MGIxMjZjIDEwMDY0NA0KPj4gLS0tIGEvY2VydHMvc3lzdGVtX2tl
eXJpbmcuYw0KPj4gKysrIGIvY2VydHMvc3lzdGVtX2tleXJpbmcuYw0KPj4gQEAgLTEwMSw2ICsx
MDEsOSBAQCBzdGF0aWMgX19pbml0IHN0cnVjdCBrZXlfcmVzdHJpY3Rpb24gKmdldF9zZWNvbmRh
cnlfcmVzdHJpY3Rpb24odm9pZCkNCj4+IHZvaWQgX19pbml0IHNldF9tYWNoaW5lX3RydXN0ZWRf
a2V5cyhzdHJ1Y3Qga2V5ICprZXlyaW5nKQ0KPj4gew0KPj4gCW1hY2hpbmVfdHJ1c3RlZF9rZXlz
ID0ga2V5cmluZzsNCj4+ICsNCj4+ICsJaWYgKGtleV9saW5rKHNlY29uZGFyeV90cnVzdGVkX2tl
eXMsIG1hY2hpbmVfdHJ1c3RlZF9rZXlzKSA8IDApDQo+PiArCQlwYW5pYygiQ2FuJ3QgbGluayAo
bWFjaGluZSkgdHJ1c3RlZCBrZXlyaW5nc1xuIik7DQo+PiB9DQo+PiANCj4+IC8qKg0KPiANCj4g
SW4gZ2VuZXJhbCBpcyB0aGUgb3JkZXJpbmcgb2YgdGhlIHBhdGNoZXMgImJpc2VjdCBzYWZlIlsx
XT8gIE9ubHkgaW4NCj4gdGhlIG5leHQgcGF0Y2ggaXMgbWFjaGluZV90cnVzdGVkX2tleXMgc2V0
LiAgIEluIHRoaXMgY2FzZSwgZWl0aGVyDQo+IG1lcmdlIHRoZSB0d28gcGF0Y2hlcyBvciByZXZl
cnNlIHRoZWlyIG9yZGVyLg0KDQpJ4oCZbGwgYWxzbyByZXZlcnNlIHRoZSBvcmRlcmluZyBpbiB0
aGUgbmV4dCByb3VuZCB0b28uICBUaGFua3MuDQoNCg==
