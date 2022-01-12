Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663B948CEA2
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jan 2022 00:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbiALXBl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Jan 2022 18:01:41 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42352 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234747AbiALXBk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 Jan 2022 18:01:40 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20CK7qe0001605;
        Wed, 12 Jan 2022 23:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LXcw2kKNALxXJOSFPpLfLfFiEQEeRNMLEZ4Vzxfe2Uw=;
 b=Y6P+WpMjYBdXC/Z4k6GcVFeJUISOb9GvzrSmPPhUUqfQA5HyQWQaBuKoxDaFeMRAX52w
 GejZCLRM2aLr1WRjyz5pFZRe90p6KV5S0SsEEFY3T5ETZ8885zahocuI9OcjxgpCT0Om
 e0bG0eSV4Zr87XYPY4j5HfvXq+LrvhkL9N5As6C61jBxvFue8eS7+GNgY/uRnoSWSxOO
 y/ZA6cNgnSk1r1g0dV0stHZuDbmdPlHV2rmedibqzuJLkqbc2Lk8b6YPiwYj4owsbMfB
 FURSYOknuzcnsOfV291OSyuiSSQA7C6EN+TP7hSLlgLQT5eicaY6Bga7KMupvf5NonTB Hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjdc025c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 23:01:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20CMo46w097712;
        Wed, 12 Jan 2022 23:01:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by aserp3020.oracle.com with ESMTP id 3df2e700de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 23:00:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHQnA/xiNtV5fqqjNq2KMkg2AtgPC8DnaOGJ7JqZ0DQ33Kk7fcAEMGY14UH8rfy6YRRgruiqogvYC9BoMd97MZPD9TSCZgSf9WnJqx9fb/2GHJotu5HJ+eCW2Qt6uJklm9iig1ZekD7hr1YUp693eDvtm/EZyqOoNzJUqgzgSZOPNDKgDvhGaag/LylgeRB7Fkmdc0EIZ2Oofnwv8VQSGB/qNBDWE0Bss+luDZlq9pOvw8ctLjV/u3prK8WnuOKqrvRlf/jLd10FurYjKfX1s2GixPJ3WR5bWgM8odEc4a/YgKFp53BFpkyP4vMcFaG32/O7tx5B0txfuLvkINm40g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXcw2kKNALxXJOSFPpLfLfFiEQEeRNMLEZ4Vzxfe2Uw=;
 b=n+9buwPyb7fwz7iRsBAa4THQb2VjcQJ6PhhBD8bZmSxReKadFDxzIpDZ6ag1iRrauevDr8X4DI97KNgET5H+TIHPZ+fVeHjBBQ8/FvDgDsfsAQAz7N8lWOHGa0NQIR1MiWgaYzWWsKPoQblNhjGbGIMsE0l+fLdsM6YJQsdjhX59ZQ0lILiT40MCDDgmgfH3nBsSYp1AsSLcRVWFpFoy35RpZfMVxRbAeu8DvGBqGdqK63wLtpFpzXdxqbEa+8ZIawNF3uxmlsKxqqsvOI25SrAzpvwDCSjTF6fTlLS484DiScdW/BLBIxZfNIh0zAn4QQtvKFNEJKjusoSjLrOKVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXcw2kKNALxXJOSFPpLfLfFiEQEeRNMLEZ4Vzxfe2Uw=;
 b=HOYSaXrtYYERJNs+Dop9amQ744nqW68lQSrNFmVmDfE4RWOMw7YLIFxAXlcSpgcieTMks5D8Dwf5pg0NCpErkDfLv6dW6Bwmvs7kOD+2/TGwcTj23oT3G0/H9/THwenJXPdKFAZVQ5p/kUW3tNbih3eyyDxaipRhxyDjI9uQJ4k=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4294.namprd10.prod.outlook.com (2603:10b6:610:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 12 Jan
 2022 23:00:57 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a%4]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 23:00:57 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     Jarkko Sakkinen <jarkko@kernel.org>,
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
        <James.Bottomley@HansenPartnership.com>,
        "pjones@redhat.com" <pjones@redhat.com>,
        Konrad Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v9 2/8] integrity: Introduce a Linux keyring called
 machine
Thread-Topic: [PATCH v9 2/8] integrity: Introduce a Linux keyring called
 machine
Thread-Index: AQHYAo8H0Sj261FHG0itWWPoxYX3jKxbQpAAgAGq5wCAATwoAIAANR6AgAA/vYCAATUdAIAAN8yA
Date:   Wed, 12 Jan 2022 23:00:56 +0000
Message-ID: <A5C3ED7A-5233-41D2-9F27-ED05899DE97C@oracle.com>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
 <20220105235012.2497118-3-eric.snowberg@oracle.com>
 <883da244c04fcb07add9984859a09d7b1827880a.camel@linux.ibm.com>
 <100B070F-7EB4-4BF7-B2B9-E5AE78D3066A@oracle.com>
 <a384fcf8bdd9ff79456e9669fc61ab50ec4e1c55.camel@linux.ibm.com>
 <F1F41DB2-171A-4A6F-9AE7-E03C4D3B7DD0@oracle.com>
 <eece68eba2beceeb410748c1f9f32162793d2057.camel@linux.ibm.com>
 <ef68ddaf498925dc0ff03d9463cd306f40e19119.camel@linux.ibm.com>
In-Reply-To: <ef68ddaf498925dc0ff03d9463cd306f40e19119.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8295ad9e-21a3-42b6-a1ec-08d9d61f64a3
x-ms-traffictypediagnostic: CH2PR10MB4294:EE_
x-microsoft-antispam-prvs: <CH2PR10MB4294672B81A89A6102611D5287529@CH2PR10MB4294.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3SKYvWUVa6vCaAUpFoM9CnVkzDaw3B0KoA1RWVfh94faPnlRTQun3gHGecJBzaNfMaKzWnwvHVpwCVCQ7hYGilqmM3KBz3WntWA2zgBbNCMyYCCuqD5ujgAq3UphIOwZN6i1pCjXVTtwMlbLMcCfvXwiZw0XpW/ekdHRJDXDqCQ4hD/gQwqZpG/Diz05ctGEO50uEtHFXUZXY2a2gd+eyO50psumpN5Bgnar/JWVsevcznWHgFGmOkrfg4PgJX7Z3gjjX/csJBlwv0E7gXKPhOBKi7FdgXo4I7Jo9iM1+Ebz8iCioQkj+0pPd1ynwepaaQ6eg4oCB83UjR6M3DTtwW7fcKPtXxUzG+WHfQbLnNzZaYGaStMgd7XUFhz6LzYmyMCqwe7wjj2QykjfWRGddmQZsLVq4XYdBudEufN1dLRQi5LBTWRxoBDKQm4o6dRGgh5nL2TbOJbdiix5qEo34E39lrZEfibOE4BGI/KAPwvyaLyN/63xLVuofbC5dAnA9/wGEzO55/lQD+Nk4UlQ603XTBWh8rgL2y9yuuCyrDF3rN1hmggPD610cfRrhF4kvlV9MtfjBR+C44s+RCjhm9LUfXACKuf6hVr5CAxk4q1lGGqJzVUDuyHqrZV6Wg+sY9CJk0Sat5FQjP4zzW47keidMZtdfVMUsdY5b+dih0diMpkqVdFl3lc4zgCukSG969cZvq2LpmwzB7+ptPnwz1/AzR5uFlvcapXysUAmAjE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(36756003)(186003)(6512007)(38100700002)(508600001)(7416002)(66946007)(54906003)(53546011)(91956017)(2906002)(6916009)(86362001)(6506007)(6486002)(76116006)(316002)(71200400001)(66556008)(38070700005)(107886003)(83380400001)(8676002)(64756008)(44832011)(66476007)(33656002)(66446008)(5660300002)(2616005)(4326008)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1grUytlZnowUVIzdFFWSHF1cnE2bzdTNEhxSGxVQVlCM3BSMjJkcWFmdkVz?=
 =?utf-8?B?OHZONjBlVjhNUGNCb2F1ZW56eU9nTVQxd0x6UFlTYmx4Y0ZLeVdpQTdPTjlI?=
 =?utf-8?B?UlFwS2Q2T095WUNRb3pLQVZ2Z3labFk1aU1NdEg4bzZkV09hTkQxVW5paWUv?=
 =?utf-8?B?b3gzV1FrR2FhTFlINXNhaHkrL09adENlTUxmRHlTSHpEMnBERGEvbUhZVjJt?=
 =?utf-8?B?RXF2cEpnMW5sbE9IN01Tc3J5WU50SnhoM2VqV3lXMk1rOTlZRUZWYWJ3czVN?=
 =?utf-8?B?ZEZ1NHZUZEF4SnE0eSt5azRQZHpjeDBzTk14SENyU2Rmai8vY2VZV1E0c0RU?=
 =?utf-8?B?VU55M09lUmdCQytxT042RWJSaTh2anozb3luUHIyRUkyNTRvSWhDZERhdWtm?=
 =?utf-8?B?dHVGRlpnelI2V0xieTkzSzZzNXh4WEJXaGJpV0xyL3lmdnUzcFMyaTVLcVQv?=
 =?utf-8?B?cjRrbEhucGZNVmlTT0RUYnFRWUZkVEtpdWtqM0kwRWNuOFpDazNhYUsyS2VY?=
 =?utf-8?B?NnBPd1U4NjMzbUdDQUdZblp4d3ZKZ1p3aGJsNXRpMVRGeTZnYVFPUzFjRUN1?=
 =?utf-8?B?a3RSU0ZSTi9FMzBNeTdqSWgvalkzM3YweExYTkZPZTBKeFpsYThVdjVySmlK?=
 =?utf-8?B?ZnkwQ0VwNHhkazVKM05DS0gwOEFQamgxTFVVZVkyZlIyUnptUUk3SzN6aUVx?=
 =?utf-8?B?V2pVc2hkTkkxYTdNU1FNZDczUzNKM01yUHdwYm54Mi81dGJ0T1oxdGwwbXFO?=
 =?utf-8?B?RHZRamUzMVd4U2ZIWFlYY2s0QTVrd1B2dWtoQkMxM2NtNVZ5WjR5czVlRFAr?=
 =?utf-8?B?U2pOdldWT1FMWXF5eWwzazkzaUtRd3V4bTAxaEFOUXRteUpSQ25CMm9MZldj?=
 =?utf-8?B?K2t6TTBHTjRmbVl0YkszOXc5QTNuaFBVZXJGQ3R4VUhuU2pRcnFjM3BIa0Yz?=
 =?utf-8?B?S1UyMkdFdDAwOXRFQTIzbXN3M0Jzc0Y0Tlc1VzdMKzBSTjVuaVNydmkwUVc5?=
 =?utf-8?B?M09nQ05TWFRYaklCVTVCak52bjdpTFp2SFVOc3JJY1Zkd1R6cG9EV2dkTUVa?=
 =?utf-8?B?c3p1RGxjZzJHQnEzRFBhbzRCUTU3WkhUT0REazJmMDNYVzNqRm1ZL1ZRUW40?=
 =?utf-8?B?ZVVmQWtSK0FVVzZOc2cyL25TOUc2cFdVQys4cmFEaUY4TXplVERHTHlZOWhF?=
 =?utf-8?B?YStjUlAvanBrVGdPNUE1Uk81MnlhczJSbUgvWFVYZzBSYlJBNG53K3RXQm5s?=
 =?utf-8?B?cStEUmdINXBIOWdsVEtJVnhlSG04RE1EeTBza1I3dHNnN3RzRW5mOXd6Tm53?=
 =?utf-8?B?OHFxaWh1aExudG5XRUZNeUd5VDcyR291L2pxM2Z2KzA0aTJGclkxbmtmVjRz?=
 =?utf-8?B?b09QV29VcCtaMzJiL3ZSK215YTdtdTduSXdkNmswRUZJdTNhWUlZVHNjb3E0?=
 =?utf-8?B?aFZJQVp5SVR1Q21DS2hoSTMyc1RSV3FhckdIdnpoRThzaTdWWVZKNVpQbFBM?=
 =?utf-8?B?VmcwN1F3THNhN05KbFZVT3NTd1BXNmxYYlFXaTh6MGhLbUZ5bldDS2hXTVps?=
 =?utf-8?B?SndMcEI4OFEydUdhWEVGNlNaWkpuTGFtQ0Z5Y0IwRjdyNWs5UWVza0UxMDha?=
 =?utf-8?B?ai9UT1F4TFRocXYvWkhUM2lNWmtma21GOEFnTU1VOVp6REZTSUQrZ1ZlSUtt?=
 =?utf-8?B?Z2E5NUlXUTF5MnJZSFpXYmR1TDlwRjNqcmdNQWJ4MHg1Q3habjhOOHFKUk8y?=
 =?utf-8?B?aFVBK1RQTldKMFhka2Y4SEY1OTVhWE1xSnlTbENCYTEyRHp2ZmZScXF2cTRK?=
 =?utf-8?B?WGFPWFhGdlNkMGF3Zi9ObFhpNkFacTFpaW9yeWVTTGJJazVIQUNGVStVd0NO?=
 =?utf-8?B?NE1qSlJUeVdXVTFwbzVud2E4UTI0c2RmZ1dlejJDVFlFN3Q1QlltdUtyREFI?=
 =?utf-8?B?RWdTNjBBQlAyMVZDQjhuU2hnL2oxTFdIaFJvSUdXVWtwaHlhYkhxR3ZjZlJi?=
 =?utf-8?B?dFdNb0Fob1dHT0F2a0VMN2JVNUdlWXhEYWhETnpoMjBlRnJ2TUJpOUJVYXBR?=
 =?utf-8?B?NEEwbVlRY1pGSUpBS0pGbTFDV1YxRXhIazNnQVA2ZVBSZHQ5UEdBSEpzMCtD?=
 =?utf-8?B?U09IYllldmhjek9LKzFidCs2ci9PWTRxMlQrYTVCdGJrOHQyMW5tcUZLQ1Nt?=
 =?utf-8?B?dFVMQU1yUUJwcCtRd3kzVDFxQ2tkQWZlRmNRcFdJMGlYQVBZaTFFM0NTWEZN?=
 =?utf-8?B?RUVkb2Q1RXFETGg4SWU2OXFsd09qQW95cnE3aUV0MG55b0NtcGtpS3hUTUNF?=
 =?utf-8?Q?UImZbdf+zVUet2CzfI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C43467AED8EBA48B93F91860B18F4FE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8295ad9e-21a3-42b6-a1ec-08d9d61f64a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 23:00:56.9630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DBn78v2noVoChUGaWEggYiKZfRF6L4LIRXrH4Bwo0f2liAO7+MxqQ1/NXHQdeekwi45cOkoTNGrwErdQgmoF2blkgMXDDG/imzCZzEmeTS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4294
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10225 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201120136
X-Proofpoint-GUID: MhFAgQOt3G3uEknVwjWF1uVNoEYh-zV3
X-Proofpoint-ORIG-GUID: MhFAgQOt3G3uEknVwjWF1uVNoEYh-zV3
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCj4gT24gSmFuIDEyLCAyMDIyLCBhdCAxMjo0MSBQTSwgTWltaSBab2hhciA8em9oYXJAbGlu
dXguaWJtLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIDIwMjItMDEtMTEgYXQgMjA6MTQgLTA1
MDAsIE1pbWkgWm9oYXIgd3JvdGU6DQo+PiBPbiBUdWUsIDIwMjItMDEtMTEgYXQgMjE6MjYgKzAw
MDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+Pj4gDQo+Pj4+IE9uIEphbiAxMSwgMjAyMiwgYXQg
MTE6MTYgQU0sIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPj4+PiAN
Cj4+Pj4gT24gTW9uLCAyMDIyLTAxLTEwIGF0IDIzOjI1ICswMDAwLCBFcmljIFNub3diZXJnIHdy
b3RlOg0KPj4+Pj4+IEphcmtrbywgbXkgY29uY2VybiBpcyB0aGF0IG9uY2UgdGhpcyB2ZXJzaW9u
IG9mIHRoZSBwYXRjaCBzZXQgaXMNCj4+Pj4+PiB1cHN0cmVhbWVkLCB3b3VsZCBsaW1pdGluZyB3
aGljaCBrZXlzIG1heSBiZSBsb2FkZWQgb250byB0aGUgLm1hY2hpbmUNCj4+Pj4+PiBrZXlyaW5n
IGJlIGNvbnNpZGVyZWQgYSByZWdyZXNzaW9uPw0KPj4+Pj4gDQo+Pj4+PiANCj4+Pj4+IEN1cnJl
bnRseSBjZXJ0aWZpY2F0ZXMgYnVpbHQgaW50byB0aGUga2VybmVsIGRvIG5vdCBoYXZlIGEgQ0Eg
cmVzdHJpY3Rpb24gb24gdGhlbS4gIA0KPj4+Pj4gSU1BIHdpbGwgdHJ1c3QgYW55dGhpbmcgaW4g
dGhpcyBrZXlyaW5nIGV2ZW4gaWYgdGhlIENBIGJpdCBpcyBub3Qgc2V0LiAgV2hpbGUgaXQgd291
bGQgDQo+Pj4+PiBiZSBhZHZpc2FibGUgZm9yIGEga2VybmVsIHRvIGJlIGJ1aWx0IHdpdGggYSBD
QSwgbm90aGluZyBjdXJyZW50bHkgZW5mb3JjZXMgaXQuIA0KPj4+Pj4gDQo+Pj4+PiBNeSB0aGlu
a2luZyBmb3IgdGhlIGRyb3BwZWQgQ0EgcmVzdHJpY3Rpb24gcGF0Y2hlcyB3YXMgdG8gaW50cm9k
dWNlIGEgbmV3IEtjb25maWcuICANCj4+Pj4+IFRoaXMgS2NvbmZpZyB3b3VsZCBkbyB0aGUgQ0Eg
ZW5mb3JjZW1lbnQgb24gdGhlIG1hY2hpbmUga2V5cmluZy4gIEhvd2V2ZXIgaWYgdGhlIA0KPj4+
Pj4gS2NvbmZpZyBvcHRpb24gd2FzIG5vdCBzZXQgZm9yIGVuZm9yY2VtZW50LCBpdCB3b3VsZCB3
b3JrIGFzIGl0IGRvZXMgaW4gdGhpcyBzZXJpZXMsIA0KPj4+Pj4gcGx1cyBpdCB3b3VsZCBhbGxv
dyBJTUEgdG8gd29yayB3aXRoIG5vbi1DQSBrZXlzLiAgVGhpcyB3b3VsZCBiZSBkb25lIGJ5IHJl
bW92aW5nIA0KPj4+Pj4gdGhlIHJlc3RyaWN0aW9uIHBsYWNlZCBpbiB0aGlzIHBhdGNoLiBMZXQg
bWUga25vdyB5b3VyIHRob3VnaHRzIG9uIHdoZXRoZXIgdGhpcyB3b3VsZCANCj4+Pj4+IGJlIGFu
IGFwcHJvcHJpYXRlIHNvbHV0aW9uLiAgSSBiZWxpZXZlIHRoaXMgd291bGQgZ2V0IGFyb3VuZCB3
aGF0IHlvdSBhcmUgaWRlbnRpZnlpbmcgYXMgDQo+Pj4+PiBhIHBvc3NpYmxlIHJlZ3Jlc3Npb24u
DQo+Pj4+IA0KPj4+PiBUcnVlIHRoZSBwcm9ibGVtIGN1cnJlbnRseSBleGlzdHMgd2l0aCB0aGUg
YnVpbHRpbiBrZXlzLCBidXQgdGhlcmUncyBhDQo+Pj4+IG1ham9yIGRpZmZlcmVuY2UgYmV0d2Vl
biB0cnVzdGluZyB0aGUgYnVpbHRpbiBrZXlzIGFuZCB0aG9zZSBiZWluZw0KPj4+PiBsb2FkaW5n
IHZpYSBNT0suICBUaGlzIGlzIGFuIGludGVncml0eSBnYXAgdGhhdCBuZWVkcyB0byBiZSBjbG9z
ZWQgYW5kDQo+Pj4+IHNob3VsZG4ndCBiZSBleHBhbmRlZCB0byBrZXlzIG9uIHRoZSAubWFjaGlu
ZSBrZXlyaW5nLg0KPj4+PiANCj4+Pj4gInBsdXMgaXQgd291bGQgYWxsb3cgSU1BIHRvIHdvcmsg
d2l0aCBub24tQ0Ega2V5cyIgaXMgdW5hY2NlcHRhYmxlLg0KPj4+IA0KPj4+IE9rLCBJ4oCZbGwg
bGVhdmUgdGhhdCBwYXJ0IG91dC4gIENvdWxkIHlvdSBjbGFyaWZ5IHRoZSB3b3JkaW5nIEkgc2hv
dWxkIGluY2x1ZGUgaW4gdGhlIGZ1dHVyZSANCj4+PiBjb3ZlciBsZXR0ZXIsIHdoaWNoIGFkZHMg
SU1BIHN1cHBvcnQsIG9uIHdoeSBpdCBpcyB1bmFjY2VwdGFibGUgZm9yIHRoZSBlbmQtdXNlciB0
bw0KPj4+IG1ha2UgdGhpcyBkZWNpc2lvbj8NCj4+IA0KPj4gVGhlIEtjb25maWcgSU1BX0tFWVJJ
TkdTX1BFUk1JVF9TSUdORURfQllfQlVJTFRJTl9PUl9TRUNPTkRBUlkNCj4+ICJoZWxwIiBpcyB2
ZXJ5IGNsZWFyOg0KPiANCj4gW1JlcG9zdGluZyB0aGUgdGV4dCBkdWUgdG8gZW1haWwgZm9ybWF0
dGluZyBpc3N1ZXMuXQ0KPiANCj4gaGVscA0KPiAgS2V5cyBtYXkgYmUgYWRkZWQgdG8gdGhlIElN
QSBvciBJTUEgYmxhY2tsaXN0IGtleXJpbmdzLCBpZiB0aGUNCj4gIGtleSBpcyB2YWxpZGx5IHNp
Z25lZCBieSBhIENBIGNlcnQgaW4gdGhlIHN5c3RlbSBidWlsdC1pbiBvcg0KPiAgc2Vjb25kYXJ5
IHRydXN0ZWQga2V5cmluZ3MuDQo+IA0KPiAgSW50ZXJtZWRpYXRlIGtleXMgYmV0d2VlbiB0aG9z
ZSB0aGUga2VybmVsIGhhcyBjb21waWxlZCBpbiBhbmQgdGhlIA0KPiAgSU1BIGtleXMgdG8gYmUg
YWRkZWQgbWF5IGJlIGFkZGVkIHRvIHRoZSBzeXN0ZW0gc2Vjb25kYXJ5IGtleXJpbmcsDQo+ICBw
cm92aWRlZCB0aGV5IGFyZSB2YWxpZGx5IHNpZ25lZCBieSBhIGtleSBhbHJlYWR5IHJlc2lkZW50
IGluIHRoZQ0KPiAgYnVpbHQtaW4gb3Igc2Vjb25kYXJ5IHRydXN0ZWQga2V5cmluZ3MuDQo+IA0K
PiANCj4gVGhlIGZpcnN0IHBhcmFncmFwaCByZXF1aXJlcyAidmFsaWRseSBzaWduZWQgYnkgYSBD
QSBjZXJ0IGluIHRoZSBzeXN0ZW0NCj4gYnVpbHQtaW4gb3Igc2Vjb25kYXJ5IHRydXN0ZWQga2V5
cmluZ3MiIGZvciBrZXlzIHRvIGJlIGxvYWRlZCBvbnRvIHRoZQ0KPiBJTUEga2V5cmluZy4gIFRo
aXMgS2NvbmZpZyBpcyBsaW1pdGVkIHRvIGp1c3QgdGhlIGJ1aWx0aW4gYW5kIHNlY29uZGFyeQ0K
PiBrZXlyaW5ncy4gIENoYW5naW5nIHRoaXMgc2lsZW50bHkgdG8gaW5jbHVkZSB0aGUgIi5tYWNo
aW5lIiBrZXlyaW5nDQo+IGludHJvZHVjZXMgaW50ZWdyaXR5IHJpc2tzIHRoYXQgcHJldmlvdXNs
eSBkaWQgbm90IGV4aXN0LiAgQSBuZXcgSU1BDQo+IEtjb25maWcgbmVlZHMgdG8gYmUgZGVmaW5l
ZCB0byBhbGxvdyBhbGwgdGhyZWUga2V5cmluZ3MgLSBidWlsdGluLA0KPiBtYWNoaW5lLCBhbmQg
c2Vjb25kYXJ5Lg0KPiANCj4gVGhlIHNlY29uZCBwYXJhZ3JhcGggaW1wbGllcyB0aGF0IG9ubHkg
Q0EgYW5kIGludGVybWVkaWF0ZSBDQSBrZXlzIGFyZQ0KPiBvbiBzZWNvbmRhcnkga2V5cmluZywg
b3IgYXMgaW4gb3VyIGNhc2UgdGhlICIubWFjaGluZSIga2V5cmluZyBsaW5rZWQNCj4gdG8gdGhl
IHNlY29uZGFyeSBrZXlyaW5nLg0KDQpHb3QgaXQsIHRoYW5rcy4gIEnigJlsbCB1c2UgdGhpcyBp
biB0aGUgY292ZXIgbGV0dGVyIHRoYXQgaW50cm9kdWNlcyB0aGUgQ0EgcmVzdHJpY3Rpb25zIA0K
dG8gZW5hYmxlIElNQS4NCg0K
