Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414484FC298
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 18:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbiDKQnE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 12:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348772AbiDKQms (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 12:42:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781EC2E69B;
        Mon, 11 Apr 2022 09:40:33 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BFIGnA029074;
        Mon, 11 Apr 2022 16:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=t62xmfONaOcGbjemj6hOeWxMqxrWKjBKEtHpcWrrX3A=;
 b=xYCHrElD5iC6j4svtxPY0YT1dBBMKCmzoOQghrB91YosNpSDwyLe3tQgOLCwF3azVTq7
 IpMo8RcVrS1wj3lQ4Akbn5MPfqILPsERt+Gul7/NGNie65m0sEv5pGYNKg6Q+CH1bsmB
 dRndbmdSx17E/QsdLVhOPR7goff2ZUuls+g94zd2WqpFFS6w6Uv3918zK5k13Qwxi1hJ
 6vp8XSP+CRCphfbSfYWOf5q8yE2CZ8eatRAffkjyR1+DDU+ehr03bPdu5QcUoNTw1JkZ
 OmwnRr4xN/7ct8BHDGlhRCZPcGVfc7JNRgZyxxChz3JLGOwF6nfJtorI1SmQcAglPWvq 8Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rs4ayu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:39:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BGV9VV001203;
        Mon, 11 Apr 2022 16:39:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k1mau7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:39:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPKiYZW+cfPz/kNYj/J7kBtZNKmCO9mDfkugW8RkFBwM2pOoSh720XU97yfLLlL/RPvX63Z2vlHyAVzXSdYcxlKkGHC5Ve4NTpJg9uCoUyCcSuwcRtAR96YdjSPsukAFq4tGBIGxlomxM6+cRnvnUxyeb3eOgnP/VdHica3K7S6zyudAQ8couMoYgpJo3msfWnDGwhbOZuFZlA4qz7F+avtq7JoGtaotmxEIhFSTCOdR4Hn0KMM38pH8VOXuyS7KbvVG8BhOEgG+Zlb9T3sLmRn5dLEZrnEV5+Phca8Z0jSNLQPLOJ82PCM9HC7ajdqYBFT5/e+RSmgChH2R1dSD0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t62xmfONaOcGbjemj6hOeWxMqxrWKjBKEtHpcWrrX3A=;
 b=AU0qLeMXiFN5EWkGV4hCuLWMq07WfeT97X2FMRqg5F7gyQ6t3rTzQS8xctp/CnQD0ubyRua/exFARwGnbRX+fbev5jAtOt+yr0CIrNEQZiPLp6wH567sHPjEr5jzXhG++/g4GoNb2W4mKxbSp7h6R3gMsVfiwSTNzibCd9483wAuC5ZcTVctpc4JsHxziA33rqV7m0++YPTlzNj0UVm1If7aypTrsKYbRtVg3jNlGJdfrmKXXhM9+qy80lHCLCIKA7AWQ26kkEmqedsj6ybjvVKhk+i1Sl7CLCRIjD+zwiY3ZsRPpcubeq0N4m0Nb4PYh7sjnkJuAOKky/fjWwStjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t62xmfONaOcGbjemj6hOeWxMqxrWKjBKEtHpcWrrX3A=;
 b=VTw0MBP47I0tO7Eb8wJtCMucjc2+VtcjSND1Ec0FDO1aagTG4eKY4s0AGfbFRu0ltcvBRtIGuB9amswOC0Xs7/B/ERUrvZMY4TDIILi7DLBEJo6s1RL06xw4caoh39261lk/8kHBORmmyTZxGrzKellCLSRPqRgsy09VBXOOSRI=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BYAPR10MB3622.namprd10.prod.outlook.com (2603:10b6:a03:120::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 16:39:42 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55%7]) with mapi id 15.20.5144.030; Mon, 11 Apr 2022
 16:39:42 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     =?utf-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>
CC:     David Howells <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
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
Subject: Re: [PATCH v10 8/8] integrity: Only use machine keyring when
 uefi_check_trust_mok_keys is true
Thread-Topic: [PATCH v10 8/8] integrity: Only use machine keyring when
 uefi_check_trust_mok_keys is true
Thread-Index: AQHYEmDFShDCf3sk8k+AOahiwptnWqzrA64AgABdC4A=
Date:   Mon, 11 Apr 2022 16:39:42 +0000
Message-ID: <C970A5DB-0238-4B5A-9935-588DF9B1DDEF@oracle.com>
References: <20220126025834.255493-1-eric.snowberg@oracle.com>
 <20220126025834.255493-9-eric.snowberg@oracle.com>
 <20220411110640.GC163591@kunlun.suse.cz>
In-Reply-To: <20220411110640.GC163591@kunlun.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0b1e6c4-6394-4aaa-c090-08da1bd9e128
x-ms-traffictypediagnostic: BYAPR10MB3622:EE_
x-microsoft-antispam-prvs: <BYAPR10MB3622F184F6A4C076BB99882887EA9@BYAPR10MB3622.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vwNImotemSP5A5TmAsqNl53K6nfZfYswTxh0pyYmtjmW1qtAPpn9dZytXLe/ybGIWCFO96cnkZhmRQ754O5UdmtLU9W8M8hRDPowsRgPRPYSUV08eqUZM6dO8/Kgpj2hcAU5UCg2naEeh8+bn3dyUsXYotssPBcBewSG/VeuZ3+bUQsij2rRr/1U24AiXjMp4aLUkurKwC7plw/pZLY2bWvU2llnNyogYP/UuGjJh1qUJgT8o9I0jvUcmZi5vfMrMKheYb7m1Rqiq6FUjoi1PTsR9VjT/cLo0lkdQb1460zmvES5kzh4Mli9nS5PctmUd31PUwlwTTBQarQiXJsQu7ABGtLbAMq1rcy0lKVqDN450RwytKQwaruwcSiaz9pwLfoDItC63AtEi/dzfvrGpnAWvCjgzgwKYPNyKU+qxdO357bklnDuF3Y2m8v9U85M7P0o8hUuEkmC7jHRH8Dq8Xy6YpC0rELjPpwruSMQbKSArJxiZ2iY54xBsxkqsnMcGtqbR1vFAaLMiFH5h/H7ob85FLMMglksrUg/rq2GpE/qGcdpu6SislffGp2NNkEF+1qWQWiQB2qzFvBQdnjtOa8/DjT/Zqk0DZUU4/jzdhZJ14xavmVoFuYSFb79+I7PhSygEVWqax8Wsiy2osUhGfewBpfHSj7qzHYDX/Ybrk8YHg+0+pxgtdg/VZsruZFulFQpFnIGcK+OCPpSjtoigoaCET3gyJoZl4Y8rhX0ApU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(36756003)(86362001)(76116006)(6916009)(316002)(66446008)(64756008)(8676002)(4326008)(122000001)(508600001)(44832011)(66476007)(38100700002)(2906002)(38070700005)(5660300002)(8936002)(91956017)(71200400001)(7416002)(33656002)(186003)(53546011)(6506007)(26005)(107886003)(2616005)(6512007)(6486002)(66946007)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTF1VVVoc01Gc3pFVHRXMDJwaG1tOG9ldmdSMEFlRUhPaHhiMHhrdVV1TzJs?=
 =?utf-8?B?QnovdzY5bDE3b0lKQmxHM1RhOFF5TWhsQXcxWnFiZWpHblBFV1lPOGIzajZy?=
 =?utf-8?B?S2V1V2xJYXF3WnF4RnN4d1U4ckdrK1g2OUU2OUdTU3VObzloUU1TNmN0Kys4?=
 =?utf-8?B?SlhCcGU3anpxcklBMk1BL083Y0ZLbXBBaksrc242SEQ0QmNHNHo0OTQ5Slo2?=
 =?utf-8?B?ZWdycDU0TWR2VTROTE4vbjRNYzgyVldZTzhxT1J3VDFaTnJCZEtTa2RDck1o?=
 =?utf-8?B?OEFBRlFvOHJkbHBEZGsycStsUkFPQ0NPdTRicmJXVmpSeWtnN3FMdDBtcVlI?=
 =?utf-8?B?VnlyZzB4RWU4b0JoMzc2MkhaVUZLbTJLYmx6MXZHb1BlSURTVUpIempjRWx0?=
 =?utf-8?B?dCtQT3dZYzZnMEtYU1ZqUmVlZCtiaXBWTCtBVXJtMCtKbCtqS3owbnppUW5J?=
 =?utf-8?B?QkRCNG5DNklET3kzTVpGVlVzV29rdnRDTVVpbFIybDAySUtOdG91ZHJtQTlN?=
 =?utf-8?B?Q3N2Qjh4TnlCRmVNbW5wOXlHcTgvN2VhYmJBR2JQdkVJamFXVGRtWVMvTVho?=
 =?utf-8?B?cnkzTUlmeFIzVXhjRXhwdmtWV0ZYK2Nhc2NTSGQxL04wZE14QlVOL0NhaWZN?=
 =?utf-8?B?bUtBc0lhQ2ZUZDFsSlNzWVVBQUgxSnJpOUJXaCtrQXp4WmU2ZlZsRnhQMytV?=
 =?utf-8?B?ZnRWMy9DbHU2UkVCQm9qZWlwb01MekdMT3QydzdCUmVCR3cyUUlibVptdUR1?=
 =?utf-8?B?OFk5NXJucHdmMmh5dHBxMXJmdjlvYzN3QXZHTjIrOXdVd3g1MmMwS20vM0RJ?=
 =?utf-8?B?bDJYZ3ZjK0UyN1hNaThYQ3p4OHk1YjFUOEN6cU1BTXI1ckNmYTBvYWZCVzRP?=
 =?utf-8?B?MkhxNE1vMHkxUGhUaGZZLzFxTE9aTjVZeW9lbmJIb0Y1bXpncTRabTVGUEdt?=
 =?utf-8?B?SHlOWXhDQ2dHbFhHQlBUTTZ6dmh1QlJ5Y3lmUXEzRS9JV2VkcDltK0FHYnlv?=
 =?utf-8?B?RzNLdXZDMUx3M0tMSHFmT0FYbEtPTTlDMStldHY2azVhVmdncXJ1RnVxOVVP?=
 =?utf-8?B?Tno2eWhqTzRnZVBKRlBHWFI3NG1BT0Rqd05xQlRNajk3UHVBdEhKS1FzUmp3?=
 =?utf-8?B?Y3VFWWRqOGFVYjMzM3dsd1lPR1Y4ZXR4SVB2RVdzVWNYbmpkamI0dlBGYlhG?=
 =?utf-8?B?Tm13NmJ6UVdodDA2cjZmNzE2OVB2Rkk0eHhaeC9VMGZnRDdqK3RiVmowQXJZ?=
 =?utf-8?B?bWZMWUk4SnVoNGRPNjVsOXNOQVlBK0JabllkL2JvQlJQeFp1WlE3SFJBSkg5?=
 =?utf-8?B?Wi9sZU5HdTMxcTdoVFRFSUwwSDd3MHhReHoxWm9OQzdKbldodEd2TmJXWENw?=
 =?utf-8?B?WnNZWmhuVUpHUllmMTRkKzFBZzZQYzFBOWhCTWxQSEhVNlo4dFkxeUhOVVo4?=
 =?utf-8?B?NWt2OGt3WXNYOHNqcERuLy9NVjlVVlpjMGpDNWlLME91blVmOEZSZ1BYNkNm?=
 =?utf-8?B?ajJpT2g0dVUyRkcxVU52bTAxZGVaYlA0ZGVNakRmQUlUOVVURnFVM0ZUZU03?=
 =?utf-8?B?bDAwK3ZZTXNPTG1PTmlnaVlYOGdhc2dzVDRQMzFPMGI0T3BRaTNPUG1JTW5y?=
 =?utf-8?B?UXZRQURlSjl3VEJqQ1pCdldLM3NqOTBrR2lUZkhLMkY0NGhsV3VNbzBQTGE0?=
 =?utf-8?B?cFpoNmYzZkxLVUF0SXZ1c0pTWXRFN3BWTTJvcGFTeEhGYWZHUjIvQU5aamM1?=
 =?utf-8?B?LzIveWRzN2FQbmRJRGZ0M3dRZHlNaE9NbFdEOWZKaTJRUjkwaTRqNlh4L2pD?=
 =?utf-8?B?YUs2YlhXQXJaay9ia2wrQWJkS2ZKeEFJaWxpTTIvckNoWTFsQm9BdU1SeE03?=
 =?utf-8?B?UVpycDlKSVV6cDNrUnl0ZU1rcSs3U3BiS3pJemVPZjdILzZ2blpHWW1aY1hS?=
 =?utf-8?B?Wm45ejVUbm9wdExBdnlPYW1YRXNzcEF1NGxURldKc0JRTmF6b1o0Z1J2Uzkz?=
 =?utf-8?B?N2ovZTlES0F2TDZNOXl4YXYyYzQrV0tjWWtxK0VzUWJvMGp6ZlNsYTVHUDZ0?=
 =?utf-8?B?UjhQdUJsVUtPdVFVVVVibHNSck5xRWQyMzZjQnYrbUhaWnFLMmpLN0JJQUxa?=
 =?utf-8?B?QUtwd1dOK1JML3dNSm9mMzd6VGo3R093WFYxK0N0U0lLS1NsL3RSSzJsV09W?=
 =?utf-8?B?bnpMUVVFSFg0Zkp5eDZoWER3cVZDRXIxdmdiY3pDS0tZVGF4R2JDeHVnaE5r?=
 =?utf-8?B?aDIrZ01sTVVlOUh0UFBnVnkxbDd2NllkOTBWODZ4SEI2K2JhMzQyTlczc0RP?=
 =?utf-8?B?RkgzcEtXV2tpcE5yaUpVMllxUnJiVUJTSTJSVGNJbElrc2o0SWlaUzhmQlN0?=
 =?utf-8?Q?2l3ppfmmbIg1WdqA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD87B7AE2477FD469E5559DDDF8C7D5B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b1e6c4-6394-4aaa-c090-08da1bd9e128
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 16:39:42.4494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RL33xqcq0JjSktDWlTyCZSu8JFAkj3zYulBwoDU8F6lJDI1vk2b7LBt8jLIoxN5fsL+lyY/9yuuSToWPpyynl7wsjaQVcKxQPVViRmN90Tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3622
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_06:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=973 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204110091
X-Proofpoint-ORIG-GUID: Alv70M4V4L8VNYRx8-4ZSwvdVtjPUNaj
X-Proofpoint-GUID: Alv70M4V4L8VNYRx8-4ZSwvdVtjPUNaj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCj4gT24gQXByIDExLCAyMDIyLCBhdCA1OjA2IEFNLCBNaWNoYWwgU3VjaMOhbmVrIDxtc3Vj
aGFuZWtAc3VzZS5kZT4gd3JvdGU6DQo+IA0KPiBIZWxsbywNCj4gDQo+IE9uIFR1ZSwgSmFuIDI1
LCAyMDIyIGF0IDA5OjU4OjM0UE0gLTA1MDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+PiBXaXRo
IHRoZSBpbnRyb2R1Y3Rpb24gb2YgdWVmaV9jaGVja190cnVzdF9tb2tfa2V5cywgaXQgc2lnbmlm
aWVzIHRoZSBlbmQtDQo+IA0KPiBXaGF0IHZhbHVlIGRvZXMgc3VjaCBmbGFnIGhhdmU/DQo+IA0K
PiBUaGUgdXNlciBpcyBhcyBtdWNoIGluIGNvbnRyb2wgb2YgdGhlIGZsYWcgYXMgdGhlIE1PSyBr
ZXlzLg0KDQpUaGUgZmxhZyBhbGxvd3MgdGhlIHN5c3RlbSBvd25lciAobm90IHJvb3QpIHRoZSBh
YmlsaXR5IHRvIGRldGVybWluZSANCmlmIHRoZXkgd2FudCB0byBsb2FkIE1PS0xpc3QgaW50byB0
aGUgbWFjaGluZSBrZXlyaW5nLiAgS2V5cyBjb250YWluZWQgDQppbiB0aGUgbWFjaGluZSBrZXly
aW5nIGFyZSB0aGVuIGxpbmtlZCB0byB0aGUgc2Vjb25kYXJ5LiAgVGhlIGZsYWcgaXMgbm8gDQpk
aWZmZXJlbnQgdGhhbiB0aGUgJ+KAlGlnbm9yZS1kYicgY3VycmVudGx5IGF2YWlsYWJsZSBpbiBz
aGltLCB3aGljaCB0aGVuIA0KZ2V0cyBwcm9wYWdhdGVkIHRvIExpbnV4ICh1ZWZpX2NoZWNrX2ln
bm9yZV9kYikuICBUaGVzZSBmbGFncyBjYW4gYmUgDQpzZXQgYnkgdGhlIHN5c3RlbSBvd25lciwg
d2hvIGNhbiBwcm92ZSBwaHlzaWNhbCBwcmVzZW5jZS4gIA0KDQo+PiB1c2VyIHdhbnRzIHRvIHRy
dXN0IHRoZSBtYWNoaW5lIGtleXJpbmcgYXMgdHJ1c3RlZCBrZXlzLiAgSWYgdGhleSBoYXZlDQo+
PiBjaG9zZW4gdG8gdHJ1c3QgdGhlIG1hY2hpbmUga2V5cmluZywgbG9hZCB0aGUgcXVhbGlmeWlu
ZyBrZXlzIGludG8gaXQNCj4+IGR1cmluZyBib290LCB0aGVuIGxpbmsgaXQgdG8gdGhlIHNlY29u
ZGFyeSBrZXlyaW5nIC4gIElmIHRoZSB1c2VyIGhhcyBub3QNCj4+IGNob3NlbiB0byB0cnVzdCB0
aGUgbWFjaGluZSBrZXlyaW5nLCBpdCB3aWxsIGJlIGVtcHR5IGFuZCBub3QgbGlua2VkIHRvDQo+
PiB0aGUgc2Vjb25kYXJ5IGtleXJpbmcuDQo+IA0KPiBXaHkgaXMgaW1wb3J0aW5nIHRoZSBrZXlz
IGFuZCB1c2luZyB0aGVtIGxpbmtlZCB0b2dldGhlcj8NCj4gDQo+IElmIGxhdGVyIHdlIGdldCwg
c2F5LCBtYWNoaW5lIGtleXJpbmcgb24gcG93ZXJwYyBtYW5hZ2VkIGJ5IHNlY3ZhcmN0bA0KPiB0
aGVuIGl0IGhhcyBpdHMgdmFsdWUgdG8gaW1wb3J0IHRoZSBrZXlyaW5nIGFuZCBiZSBhYmxlIHRv
IGxpc3QgdGhlDQo+IGNvbnRlbnQgd2l0aCB0aGUgc2FtZSB0b29scyBvbiBFRkkgYW5kIHBvd2Vy
cGMuDQoNClRoZSBtYWNoaW5lIGtleXJpbmcgaXMgbGlua2VkIHRvIHRoZSBzZWNvbmRhcnkga2V5
cmluZywgZXhhY3RseSB0aGUgc2FtZSB3YXkgDQp0aGUgYnVpbHRpbiBpcyBsaW5rZWQgdG8gaXQu
ICBMaW5raW5nIHRoaXMgd2F5IHNob3VsZCBlbGltaW5hdGUgdGhlIG5lZWQgdG8gY2hhbmdlIA0K
YW55IHVzZXIgc3BhY2UgdG9vbHMgdG8gbGlzdCB0aGUgY29udGVudHMuIA0KDQo+IEl0IGFsc28g
bWFrZXMgc2Vuc2UgdG8gYmUgYWJsZSB0byBjb25maWd1cmUgdGhlIGtlcm5lbCB0byBpbXBvcnQg
dGhlDQo+IGtleXMgYW5kIG5vdCB1c2UgdGhlbS4gSSBkb24ndCBzZWUgYW55IHZhbHVlIGluIGNv
bmZpZ3VyaW5nIHRoYXQgaW4NCj4gc2hpbSwgdGhvdWdoLiBzaGltIGlzIGJvdGggc291cmNlIG9m
IHRoZSBrZXkgbWF0ZXJpYWwgYW5kIHRoZSBmbGFnIHNvDQo+IHRoZSBmbGFnIGlzIHJlZHVuZGFu
dCwgaXQgZG9lcyBub3QgZXhpc3Qgb24gZXhpc3Rpbmcgc2hpbSB2ZXJzaW9ucw0KPiBpbnN0YWxs
ZWQgb24gdXNlciBzeXN0ZW1zLCBhbmQgaXQncyB1bmxpa2VseSB0byBleGlzdCBvbiBvdGhlcg0K
PiBwbGFsdGZvcm1zLCBlaXRoZXIuDQoNCknigJltIHN1cmUgb3RoZXIgc29sdXRpb25zIHRvIGVu
YWJsZSBpdCB3aWxsIGJlIGFjY2VwdGVkIGFzIHdlbGwuICBJIGtub3cgTWltaSB3YXMgdGVzdGlu
ZyANCndpdGhvdXQgc2hpbSB1c2luZyBhIGRpZmZlcmVudCBtZXRob2QuDQoNCg==
