Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D361062389C
	for <lists+linux-efi@lfdr.de>; Thu, 10 Nov 2022 02:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiKJBHg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 20:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiKJBHc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 20:07:32 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CD322503;
        Wed,  9 Nov 2022 17:07:25 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA12wqp021777;
        Thu, 10 Nov 2022 01:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Txps/w/WIYyrQXJGyJqpzqO8ItMCnVptG8chSzAB3Jk=;
 b=o4N+HLf+RMlAdvMvTNHwJC3RoC6MyHgKK38t73ZBBWlnm9+AZd4kPUNM66kClHXsGd3Z
 VQ4+nruImH9MSzrnwsOeUziKK/50BDAEFGJp6V9gYeTEH6HGSF2h20IpNb6YoS2qhUgS
 XuzyxXobyBKYbhOW80uuR8CFGnu0Lj8U2rMDW7jRyl4jAhqBJUXuNBoisAU+WyfLrzlo
 N88Cwls2PHjjuR2AP83HFjdyIyZs1zx1PceTI/89nF0TuCjmftX+03rgv7f9Ah4NSIiy
 ZBPEJxSx7TNDrmh9c94xfWvS6zpxmH97VkFrLBVPokhoQg5i0mkTOdPnUHj7HzqUjjCX nQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krq9k004p-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 01:06:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9MfJAQ036333;
        Thu, 10 Nov 2022 00:54:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcyr34sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 00:54:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6hOuldmyozIv38Ba98iikdaf91tV1WY0b0m2FNyH2RLyHLaNI24KDC8NXk0PVZAByzw5HINd/cJ6i2u5q2zqZpUFX3rJjNTKbkN/U6+PvFvs7HoW5BCLT1+oCffAlH1InoMz61rY0haAhEd3kncx+gqoabfRfeuIR6jgKk26SKsRBYSvXAQEElkts8LeowUKfVRs872QC1ApikPI3vmZjL8oSlkpixF6/HHFiSYwx+1vkbMLVnbV2OawptWZKWg3QYcCr1dbH6vKz1qiJEINg6kD+81YLWtjlmOrhnKNlOAxDpOK4vJU8xkjzs7Y4tYzQiR7jAfFYmrkCLtFebQEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Txps/w/WIYyrQXJGyJqpzqO8ItMCnVptG8chSzAB3Jk=;
 b=Ut7yud2O+RP/sRsNiQUKvZReppJnbwuWETHN5MlzoqDffZQ30fGVppNkI89N0ia2Lw+pORjugQDlX8OSwmcgfUJepNMpDjJ12gsNWU9cdVE46YlHZ1zm2nSGHUs9fLcNiINgEeChsKUHlnt4JC9cpAelDo/6NWv0oQ+B3EPWVk8B8R5gGPYFyUaZGGtFrk7bQqEjE1AX+mU2F6Zryq5Q2rsxHYOeJMLIhZTknK42/w0eruqkjZae42OXXuPoSCylBzLIFNAm3DGq5DSgn0ytZPjfCQQw8vaWf01G89mseEvzhuI5LGHhBm2H4gANiegcW9Sxcu3+NZGbB8Eq9jiHDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Txps/w/WIYyrQXJGyJqpzqO8ItMCnVptG8chSzAB3Jk=;
 b=J6bNuTEUUJ13Yv4HJiDkuxWA0SOGJtlNXH5j6NnBor9yF5rJzxgtNKcLQDCxvhqhdFa78ooiCcyHwkN8o5jEPVynIsIy9ip66D12gt6NwQpXJHewEiSzkvW0Cn065vrCa5SraRvTSOXO3dMpTxJF0Oi9ca1htGdA2USX7TnTtP0=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BLAPR10MB5073.namprd10.prod.outlook.com (2603:10b6:208:307::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 00:54:44 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%5]) with mapi id 15.20.5813.012; Thu, 10 Nov 2022
 00:54:43 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Morten Linderud <morten@linderud.pw>
CC:     "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Biggers <ebiggers@google.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "lszubowi@redhat.com" <lszubowi@redhat.com>,
        "jason@zx2c4.com" <jason@zx2c4.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "pjones@redhat.com" <pjones@redhat.com>,
        Konrad Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v8 16/17] integrity: Trust MOK keys if MokListTrustedRT
 found
Thread-Topic: [PATCH v8 16/17] integrity: Trust MOK keys if MokListTrustedRT
 found
Thread-Index: AQHX4O22o7n05FQT4kqWdM0Hvcs3jK45bU+AgAAO3YA=
Date:   Thu, 10 Nov 2022 00:54:43 +0000
Message-ID: <4A479B96-4B41-4323-9920-5A909423F998@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
 <20211124044124.998170-17-eric.snowberg@oracle.com>
 <20221110000129.kl6pjy5mafpuptbk@framework>
In-Reply-To: <20221110000129.kl6pjy5mafpuptbk@framework>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|BLAPR10MB5073:EE_
x-ms-office365-filtering-correlation-id: 01a384d9-6bc7-49e9-0887-08dac2b62812
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eMT4T46DvpB1pCLMul6z0+7Vw/yvRAeNrpSHY8nj28vY+NWpZLMSObMzSEciJ9hEHm+zw5TwIMlG/SozCfSoO6H17+MrrEnBDdRv4M37KjYJ4mJniJfzJwjh8jFJKoNMmt7v4ddeZMqpKxS6+RESIcKMLjRnS2IJJXhkLh3OCsC26vwa2mtn9LYudf28k/Sd0k37EaezNYjwrmwX7IpUVCih56axzyfXlMR0gf6ECfv8IwbfTFi86g5lvEjEDXASAhzf/6mH00dCAtHWLg8is/mHCNzZPCAIQntEfLKlIen+AYwCKkGB1y7o+te+tT4armT2FI225S+gmBD/GIPaQJBHQZ5VTAyYX7QKswURI63Ru/fA3lh4RdSAjdZlxuNgJeGpiatR2wr6rXMuDNMYj/gB0xoqWbF9nk/Z8eZgwD5rVABWA7+Exjvg8nogfDVK9fqjYLvuM8C5ZZflaYKAhXaARNF5Dbvgg8im7xPyT9jTLeawO+HuIMc1PlvZ17aE5xUL9fUyh3/vC8WkFrD+/Ht+5DAU63Lxrc7qW9UJOnD+3vz9VbGMSbiWidMo1sfSubvq3InVxy/VWZ6866Dw6i5gvf974HM2Y/yDrnrvAlSWqQ+HFLeXtcKKXSb4Fx6zHM61sizWDTW2EMI/uR9AkLwI30dJkXcyrGUJJ7nylaJXXbg8baWsX4MYW8ga8Qilf4QOsnm7fKdg9Hx8S4GohLMcepqvEaopRjNDYmz02r+AwT6PpVD4yqi0TYptON5P3YnQIDT0WRWSMzcPgH4xoriN3taMIfLQ59IZkXbuoFmDd1ainEZbj9tRwqyZtHmqFGu3vghwww8N8x7LkwNnVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(6506007)(316002)(6916009)(54906003)(8936002)(83380400001)(2616005)(33656002)(44832011)(5660300002)(2906002)(7416002)(186003)(76116006)(64756008)(66946007)(66446008)(66476007)(66556008)(91956017)(53546011)(41300700001)(6512007)(8676002)(4326008)(86362001)(36756003)(71200400001)(38070700005)(38100700002)(6486002)(966005)(107886003)(122000001)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1lWb1B1ajBnUFNZeGFGRW5zZ0RhVXo2eVp3UG96dXY0Znh0QktIRUt2WlNC?=
 =?utf-8?B?SUo5MVgzYkd1dnJEL3krMTBrR3M3WFlLY05tUms2NzIrRTBrbHVWT3lZYzhm?=
 =?utf-8?B?dTRMTGtHYWNhSThNQUpQZVJETklXbzB4M25SUzlSN3dGcEhqb0JuM2I2ZjlG?=
 =?utf-8?B?Mi9Va0JnSzlNRW40cGtHUmJtelVhWFhlMVpUZXdsdmFrWU5zczRsSEQwK3lq?=
 =?utf-8?B?UzVEbm5xQmU5ZFdRbzRJTzhSeWNDb05iOGxmdVFybVhnbUxtSkpOdnAxTTBF?=
 =?utf-8?B?YzdCYm9YYjJpdkxDMzU0SU1jekozUlNzREJMbGY1UlFqMHNjVjV3aTZ0clBx?=
 =?utf-8?B?a0labkZJZFJDazQ5cndZTzlLNUx5YmFlaGI0WWtZNEF1a0VRNzdpMkdmQnlz?=
 =?utf-8?B?b2tZNE9SWldKVnYwbjBhNWNjdHZSOUdENjUxSW1RbWVJRWVxRzNrdnJuRTVr?=
 =?utf-8?B?OVBPQVJOcXA3RDluWXphN0Z6T0lqZGNpVzZicGhMV1JZeHlzaGNESXZxcnZm?=
 =?utf-8?B?MEZhb2ViNWhyM3FEcUlUTU15dFZ3bTZHTFFDQi9vbXhOVW95dVpzQ085dWhU?=
 =?utf-8?B?RDRPNmwyM3hXelBJdHVXd0lqaUEwZ29pRENYc0VnMHQwN01EU3RqYVZaampY?=
 =?utf-8?B?ZFVtcWcyQzFPbnYyV2JaTmV3b0VDSk4yUXhFckFQR0M1ZERCOXJDRFU1RU1U?=
 =?utf-8?B?Q0pDS2pOS1FMRGI4dG5ZK1ErdWpqaHRaeEhpWVhsK2drSk5pRGlEendVbXJk?=
 =?utf-8?B?V2s1Yjh4anVBK0RsRzBRaE53YzVncGZ3cHUrN0I1b0FKVkVQNy9sWCtUYlJ1?=
 =?utf-8?B?UXcwRnZ2MkZQMlZRUjFETVZSUzJITzhSbFhBWFhKT2NMbE1adHU0bHZnMUEv?=
 =?utf-8?B?QmJ1Yy9kcG5hVjdjakNkcU5kTlFoSHM2WkxwdFVqSlZKbnFDLzFoUEhUT0cx?=
 =?utf-8?B?anhxaFdrb1pFL3Vua2JZWTAxbWJZaWpWYk1hNHFaemJSd21acERCSFl6bDNV?=
 =?utf-8?B?L2hRc0hxTlI3SFZFbTNrdXlYL0IxZUJDejNvNXhUQkhzdWd6YVpXOU5uc3lZ?=
 =?utf-8?B?QU5naHFyV2pDUWt1VW5TMllPdzlwenAyY09CVlZmakpxZy9YZUIwUUxJL3d3?=
 =?utf-8?B?bzJmN0lEc1BiU2t1UVh3MlFidSt1UlNZR0pjYk4vYUswTlp0bFVhZDJrMlc3?=
 =?utf-8?B?MTNEUTNIN2N1NG5pQytUc3AxdWZkR0dURGduWTFNWkQ4cUFPUjgxWWY4Y1Rx?=
 =?utf-8?B?WmMwWEdqS1kya2QyLzVEVXlKSzRhRHVNbk8zUitoOVFySjFrdjFNaktlejZ2?=
 =?utf-8?B?R0FXaFlJTERpRFQ3Ky85UHJ1NjRtakY1ak42RE54WE5qTHVVYW1vWEdhci9y?=
 =?utf-8?B?c0lBditHWG9saEJlZGhvaHROeFRydHZsci84MUR4RE1MbVl1cHlmdmNrWHFv?=
 =?utf-8?B?SnF5ZlRTU2ovWmpuQmdVY0tmNGZhaTM5RG8zbkJzVzduUnRpbXkzOFo2UlhM?=
 =?utf-8?B?YmR5M1JzT29mbVBMVGhYaHlBYXZwdkd2VnAzSkh4MnFIa0R5Y2NqNzQ5RjY3?=
 =?utf-8?B?YnlaTGMrdmZnZVo5U3BYaVBxRldmazRQbTdkak84ZlIwTUlSRnV0ejdUYjI5?=
 =?utf-8?B?VlpvS1JLc1dIc2hQc0tiTy9rczF4Y3dpMTg1WHYzcENFTTVMMkg2bWljY2I0?=
 =?utf-8?B?ZGRTaDUweklHV21qZjlEM3RCQVVJZVRVTEs3ODZyRUF5N3dUdDY0alk0ZmRB?=
 =?utf-8?B?bk9lMWJpY3VWbWdaSmpOempvRlV0Ylhlck4vNVc4cGY1RGxPVTdQVThIY2Jn?=
 =?utf-8?B?UjB5UkptVzR5azFDalhvQ2FuV1FCMDVQZlVKT3htcDFvaTk4cDJ1YVVuWTQv?=
 =?utf-8?B?NnAvNDd6SXJpSGhDMnF4WEFaaU91TVZYZS9EcERrdDhwSVc5dEtRSVlKaDB5?=
 =?utf-8?B?Wm1yK3lMY3JHaitJMUZxMmdWZGkyM0RlT21rbFhHRnduVndlaGFvbUQrQkk0?=
 =?utf-8?B?ZUxERUI2eFU2Q1JTYU5lVzl3WnlZTVpneExOL3BRcWZMeENNSXkvWmI1Q1Fw?=
 =?utf-8?B?UFZ0S2FkeC9ZZnFDZHNKc0xRdG1QLy9GUGZpazlmNnZ2TTgraXk4S092cnBO?=
 =?utf-8?B?amFLV0p3aktqRjZmbm1tZXVETjAzVGlTOGtMaThpRnd1WHFQMTVWVkFEL0Y5?=
 =?utf-8?Q?VsUxnM/FJCcWrQa9FqSxdQEy69D14epgzYDbil7UQTYQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD8CF4EF58B4184F9156299ECCB5E0BF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a384d9-6bc7-49e9-0887-08dac2b62812
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 00:54:43.7828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T4InuXlYO2lzQHQ6nxR8c19mDMrgxgS3Z9U702GsyuKDGuV/B5fZOS2hILpiPgQ4ceyGQC/6tCUrPzqPdzIvcA3pBgSFNfexUL3BDzevibI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5073
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100004
X-Proofpoint-ORIG-GUID: 6spophyHnZ3IJCsLyb_t4jAH4ONmpKPc
X-Proofpoint-GUID: 6spophyHnZ3IJCsLyb_t4jAH4ONmpKPc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCj4gT24gTm92IDksIDIwMjIsIGF0IDU6MDEgUE0sIE1vcnRlbiBMaW5kZXJ1ZCA8bW9ydGVu
QGxpbmRlcnVkLnB3PiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgTm92IDIzLCAyMDIxIGF0IDExOjQx
OjIzUE0gLTA1MDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+PiBBIG5ldyBNYWNoaW5lIE93bmVy
IEtleSAoTU9LKSB2YXJpYWJsZSBjYWxsZWQgTW9rTGlzdFRydXN0ZWRSVCBoYXMgYmVlbg0KPj4g
aW50cm9kdWNlZCBpbiBzaGltLiBXaGVuIHRoaXMgVUVGSSB2YXJpYWJsZSBpcyBzZXQsIGl0IGlu
ZGljYXRlcyB0aGUNCj4+IGVuZC11c2VyIGhhcyBtYWRlIHRoZSBkZWNpc2lvbiB0aGVtc2VsdmVz
IHRoYXQgdGhleSB3aXNoIHRvIHRydXN0IE1PSyBrZXlzDQo+PiB3aXRoaW4gdGhlIExpbnV4IHRy
dXN0IGJvdW5kYXJ5LiAgSXQgaXMgbm90IGFuIGVycm9yIGlmIHRoaXMgdmFyaWFibGUNCj4+IGRv
ZXMgbm90IGV4aXN0LiBJZiBpdCBkb2VzIG5vdCBleGlzdCwgdGhlIE1PSyBrZXlzIHNob3VsZCBu
b3QgYmUgdHJ1c3RlZA0KPj4gd2l0aGluIHRoZSBrZXJuZWwuDQo+IA0KPiBIaSBFcmljLA0KPiAN
Cj4gSSd2ZSBiZWVuIG1pbGxpbmcgYXJvdW5kIG9uIHRoaXMgcGF0Y2gtc2V0IGZvciBhIHdoaWxl
IGFuZCBJIGhhdmUgYSBmZXcgaXNzdWVzDQo+IHdpdGggdGhlIGRlc2NyaXB0aW9uIG9mIHRoZSBj
b21taXQgYW5kIHdoYXQgdGhlIGNvZGUgYWN0dWFsbHkgZG9lcy4NCj4gDQo+IGVmaV9tb2t2YXJf
ZW50cnlfZmluZCBkb2Vzbid0IHNpbXBseSByZWFkIGFuIFVFRkkgdmFyaWFibGUgYXMgdGhlIGNv
bW1pdCBtZXNzYWdlDQo+IHN1Z2dlc3RzLCBpdCB3aWxsIGxvb2sgZm9yIHRoZSBNT0sgdmFyaWFi
bGUgbG9hZGVkIGludG8gdGhlIEVGSSBjb25maWd1cmF0aW9uDQo+IHRhYmxlLiBUaGlzIGltcGxp
ZXMgd2UgbmVlZCB0aGlzIHRhYmxlIHNldHVwIGluIGVhcmx5IGJvb3QgdG8gdGFrZSB1c2FnZSBv
ZiB0aGlzDQo+IHBhdGNoIHNldC4NCj4gDQo+IFRoZSBvbmx5IGJvb3Rsb2FkZXIgdGhhdCBkb2Vz
IHNldHVwIHRoaXMgdGFibGUsIGlzIHRoZSBgc2hpbWAgYXMgZGVzY3JpYmVkLiBCdXQNCj4gbm8g
b3RoZXIgYm9vdGxvYWRlciBpbXBsZW1lbnRzIHN1cHBvcnQgZm9yIHRoZSBNT0sgRUZJIGNvbmZp
Z3VyYXRpb24gdGFibGUuDQo+IA0KPiBUaGlzIGVmZmVjdGl2ZWx5IG1lYW5zIHRoYXQgdGhlcmUg
aXMgc3RpbGwgbm8gd2F5IGZvciBNYWNoaW5lIE93bmVycyB0byBsb2FkDQo+IGtleXMgaW50byB0
aGUga2V5cmluZywgZm9yIHRoaW5ncyBsaWtlIG1vZHVsZSBzaWduaW5nLCB3aXRob3V0IHRoZSBz
aGltIHByZXNlbnQNCj4gaW4gdGhlIGJvb3RjaGFpbi4gSSBmaW5kIHRoaXMgYSBiaXQgd2VpcmQu
DQo+IA0KPiBJcyB0aGlzIGFuIGludGVudGlvbmFsIGRlc2lnbiBkZWNpc2lvbiwgb3IgY291bGQg
b3RoZXIgd2F5cyBiZSBzdXBwb3J0ZWQgYXMNCj4gd2VsbD8NCg0KSW4gdjYgSSBoYWQgaXQgYXMg
YSBSVCB2YXJpYWJsZSwgZHVyaW5nIHRoZSByZXZpZXcgYSByZXF1ZXN0IHdhcyBtYWRlIFsxXSB0
byBqdXN0IA0KdXNlIHRoZSBFRkkgY29uZmlndXJhdGlvbiB0YWJsZS4gIElmIHRoZXJlIGFyZSBv
dGhlciBib290IGxvYWRlcnMgdGhhdCB3YW50IHRvIHVzZSB0aGlzLA0KSSBkb27igJl0IHNlZSB3
aHkgdGhlIGNvZGUgaW4gdjYgY291bGRu4oCZdCBiZSBhZGRlZCBiYWNrLiAgSWYgdGhlIGNvbmZp
Z3VyYXRpb24gdGFibGUgaXNu4oCZdA0KYXZhaWxhYmxlLCBpdCBjb3VsZCB0cnkgcmVhZGluZyB0
aGUgUlQgdmFyIG5leHQuDQoNCjEuIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVj
dC9saW51eC1pbnRlZ3JpdHkvcGF0Y2gvMjAyMTA5MTQyMTE0MTYuMzQwOTYtMTMtZXJpYy5zbm93
YmVyZ0BvcmFjbGUuY29tLyMyNDQ1MzQwOQ0KDQo=
