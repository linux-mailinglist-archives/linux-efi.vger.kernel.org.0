Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FD5492B3F
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jan 2022 17:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243318AbiARQcv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Jan 2022 11:32:51 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63706 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233718AbiARQcu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Jan 2022 11:32:50 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IF4TF4016680;
        Tue, 18 Jan 2022 16:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=DTmzZITat96hZ0Pu1rJkxFsc2J2LzCZAZSEvlBNo8EI=;
 b=k1Qw/BbNRLKlL2NNU9ZBGH9Tx6w8HB7ANDi5t5vekpg6p+h7FjBxO7XgJpR1t563ijQ0
 OFqpJS1UW58w8D5+irJdMaITwYy3aWMttI2Z50ir07jU0i1nkHJMi+ebQOCkC6d/5Rwv
 20tgZA+kBmYvKXU0QFbjHrCVh3kDVVoFmCZU4Rcqh5byn3kJLu4buihXRODAiN35PHwj
 +MjENukZr3lr3r4TbhiWnozlV5tVVSXQRTeD25AauVcWco4uAJR2Kw2O5tzzdgqALV0+
 kDiCC56s2+GqiHnTZYGZrazsidmNgq8YgIphl83qm57Pg0BgXc0G4XCpwOsSuyF7JbzQ Dw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc51aan1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 16:32:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20IGUdYu048998;
        Tue, 18 Jan 2022 16:32:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by aserp3020.oracle.com with ESMTP id 3dkp34ebq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 16:32:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWgMXBL1GkIiDSzFBNlmObAw2GOcFZC6HXw7ifhLJjgqCtYvRuGRyozWLVFEKtzsfn7KqKvgCa7nS+RhWzuVlWUWrrY99SlXfZKdW2F1BRch7Dx+qHb4KwYbDlwZMS3yse61HciHq9AwE+rabUosjiBUV3btTkDMjwf+3w8gWUmITSFjmDFAWe8gJILXDIPmjES/34T11/DMuXFYLO04apIgETmlnlAtqFVS8WcIrkpwrWc9jw7R/D0ftMrAu7+m9tWdLpkrJZ7kUoZ+blEZyllnQ4ydHM3mHlNtMRICOmos7n1jK5hmx+AyEabaRbRCtYOGbrrIrLsijeXDKnrJ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTmzZITat96hZ0Pu1rJkxFsc2J2LzCZAZSEvlBNo8EI=;
 b=ktZ+5uUlC8AMiTgWhdC50/5bmkLoSnNiFrE/sMk8W3UzqaYuK1OXKAgqoLQDgvDL0Vytw4lKPGZFPOhiepKzFrW+niqBfP03sWkBsNnWwbkPhT5GG/0t55yKX0EY8YnTNBSjNxOJPPt/bmGz7jvk7bNu9ZoMf5OYGoq6mf5QM2YwE2W83JrejTWWmdbT2t6BvejC/IYUWmfWWjymBDDdmlm8IlZOOEQGXLhJTnqK+202OaO17k9yaU75d0pFNCGq/+J63apPNHG7ysXrbj1ghi/v9yGD6CYTmRm2TIlpIP7R0zEckJSFcME9sR9/MvrTDFpe2AZ6VaDDQyHiOBVDEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTmzZITat96hZ0Pu1rJkxFsc2J2LzCZAZSEvlBNo8EI=;
 b=Gs8PNqVTBQO0fMfZy42aVUodLNlIzIunt4opjMwdm4DK5Hv9t2DX9ew/aa1gFGDkyk+euci0E85Q1wHF6YuJUuDuO6jZn+t9pYWXNWEpDIlW8pRkX1ELYZtMnPeGC+ErvQNunRcJbUx45sv8RRDnR9UcTd10Am547J7WMWcGxao=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by PH7PR10MB5772.namprd10.prod.outlook.com (2603:10b6:510:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 16:32:10 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a%4]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 16:32:10 +0000
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
Thread-Index: AQHYAo8H0Sj261FHG0itWWPoxYX3jKxbQpAAgAGq5wCAATwoAIAANR6AgAA/vYCAATVGgIAEjROAgAAhwgCAAACZAIAAAE2AgACAhoCAASEtgIAC55SA
Date:   Tue, 18 Jan 2022 16:32:10 +0000
Message-ID: <34864BBD-BB02-4736-BC27-FD4C1BB90B20@oracle.com>
References: <100B070F-7EB4-4BF7-B2B9-E5AE78D3066A@oracle.com>
 <a384fcf8bdd9ff79456e9669fc61ab50ec4e1c55.camel@linux.ibm.com>
 <F1F41DB2-171A-4A6F-9AE7-E03C4D3B7DD0@oracle.com>
 <eece68eba2beceeb410748c1f9f32162793d2057.camel@linux.ibm.com>
 <2d681148b6ea57241f6a7c518dd331068a5f47b0.camel@linux.ibm.com>
 <YeMAURSR8/fRjBHD@iki.fi> <153F495F-EAF9-4C11-A476-293CC3B78F0A@oracle.com>
 <YeMdIrMXbSq7BgzY@iki.fi> <YeMdY+FLM32tmRMz@iki.fi>
 <f8598ca4e51e0b98aa98a1386c6f40bd04acdf15.camel@linux.ibm.com>
 <YeR7x9fMuvW/dvRA@iki.fi>
In-Reply-To: <YeR7x9fMuvW/dvRA@iki.fi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ae901e0-dc8e-4ddf-b32b-08d9daa01366
x-ms-traffictypediagnostic: PH7PR10MB5772:EE_
x-microsoft-antispam-prvs: <PH7PR10MB577244E0B4F637D02CBE7A0987589@PH7PR10MB5772.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kw336a5TtN8yIs0yVBkzuxFj6+4Voj7+Yi8VK7JuMtN0dewgdkSt73u/gx4h3C4L3ZXD82HFqKAaoddiJ9Tdu0kWROdMMnAWpsLRdxIRDnyw3riUhMZezdwJ1+7t9lpluxsryD6xxD5vaak9LpCudlNUM4n1UmJEPrb0pne1fUPjAJSqQDM92p3yDTlIAMrjoU26exValqFk19COKoNVV6Z+Bzcsy7S3PAaBDDNg31eZTCe82SkJLAiJJly3y1KSzO3UeBlgt76ofhQDUYpLcPaT6jvfw4/3ua5MJ2E7u6SFNL7i3xZlyXu9uI0rDKNIlpk0RBnx/YPFyR5jFR9Da+HuUM+4Hc4DPYAosPlRTA1/j7zzinGcn3JKIw7J0j3wgWD3h5Siovn82gHKzcE9+eW3GhS7gexYyysRpyVGqYjKQnfkKNISxg3FpzXW41ATB4FcLL0Hmk+JJBepHmXKuFr5gd0xJoHxhutsAvKw8uLqQXuAUor5MV3D5ZNJy5tDjfme2gg3SZ4SBJX4xp4e4+h8mLlcyhiIKUSwhuvp+MUYuFCcbrLA4EL7OERGz4KXd/Z0oklYRwoObyc57b7DFBhlXenbzaTpEZdlatahQt2FLqjp+Hte64hEDhUZKEQKK5Ucnb4ocbaacvTRpW1HLPgAFowwhGo0H4+va05fG8FB0aYm8iKwok+eFZnXO2fqNtKSnBHu4CwCM8B9kNYN3uk5EXzsIdavixiKLwLt7Ds=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(508600001)(8676002)(6506007)(26005)(71200400001)(186003)(76116006)(66946007)(6916009)(66556008)(64756008)(6486002)(66476007)(6512007)(38070700005)(38100700002)(83380400001)(44832011)(53546011)(5660300002)(86362001)(8936002)(7416002)(2616005)(107886003)(316002)(2906002)(122000001)(66446008)(4326008)(36756003)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGlwcDdmVzNwclJsRmFvNkh1ZkdXcFFmZmJ6SlRRa1V4QTZKVEdRNGpGRzJX?=
 =?utf-8?B?TUFHUFVKa01WK1dJU2pyejJIOWhqRytMMEJXM2F0dCtIaXFIRmpUU3ROS3U4?=
 =?utf-8?B?ZlJTUUJXMktaaXhwYmYrOGgyS1lsVlF1R2xrVWMrQUFLcVBhZWVwZndkdGwy?=
 =?utf-8?B?U3JROVlzbWxCM0NmeGNpMkVwYlVGYlBwaXZPeVE3Q0NUTVZCc2g3YnY4UTlw?=
 =?utf-8?B?d2V0aW1hbXZNeDk4ZHQ1WXptS25PeitRVkZxODhKQlVyK1BMUnBmMmxwTFFh?=
 =?utf-8?B?Y084ZUhGWVJISkduVS9XOUZYZjR4cE8yOVprKzYzVkY1eXJyemdlcWV5aUZZ?=
 =?utf-8?B?UTBKQWlMaVVUWUxDQ3JENnhSb0dFV1BSblBIZ3NIYmJ5SnNqTDRtem5Nb3hX?=
 =?utf-8?B?VEdOQXVMbTU2bUxtWEpPbzN6WjQ5dG1WQyt1dkhCRFNseTlkQ2JPTmp4QkVr?=
 =?utf-8?B?dHFXZFFEYVViY1BEcUdBRTJHWFdac042a2E4Um1KaVVqb3h0MGxGSGF5SXhX?=
 =?utf-8?B?Qm9iaGpxSzcrWnphZTJsL0owdy9McUljWExrcnJqYkpWSWpFbVFqZjVWaEZv?=
 =?utf-8?B?aWZmVkpTN29ZanRxN25WSHRqL0hUQWVGeEJ5L3VWMXlwYS9BclIvenJ0SGRB?=
 =?utf-8?B?RW1LNXAyeS9vaG9mVnJIbWM3ZFg5OXJHdUlrWmMwS1dPU3grYldIcnNVZ3FX?=
 =?utf-8?B?ZEIwTFZHOVZYT3FTK3JoVHludTNobFZvbnh5eExzN1NOSzRVMGxnZ3NvaUJP?=
 =?utf-8?B?RVdkekhkOWpmUThmcm9abXRvOHlhOVlLKzQ5L2lUejhpMm9lY3JzRDNzQndx?=
 =?utf-8?B?UW9KM200bjRHMG5QNmR6amJaNzlOYlVsR21XdUNuSWx1Y25Vd0N4eWxzUThK?=
 =?utf-8?B?eDhBQmV4RjltNzJVdExlQkc5V1FQMzBUMUdxYVNVTmJ0a0FZTCtBcyswZTls?=
 =?utf-8?B?eksxTVFNYTVoaDNySXBmU05raDYvdE1JVFdFeUcwMjJxaStQbzNROXNWZG02?=
 =?utf-8?B?ZkZTSHJQVjc0clhoRXRvRUFGV3dzTWN6S0ZKbit4SzQ1L3JzQ21FMlQ5YmFw?=
 =?utf-8?B?M0szUXUyVEprbWtSRWR1MkwzdDBldWhONTZiNnVRL3BzZ3VTN014SlhHNDlX?=
 =?utf-8?B?UVdaYlhmMzg5YVVjLzlEQjBjVUVnTVNRVHIwUWJwYnpqZjZiOURIekFiSVRa?=
 =?utf-8?B?cmc2L2IwSDZxdkRNQ1RmWmJxaGwzcHlQYmtYclE2cVVoRC9aS29UbFliQmJY?=
 =?utf-8?B?NXBXSUtJejRJRWFWbHV4a1RJem9oTzZDZnVEelVQVGV5dkRwNVVWOGFyYUUz?=
 =?utf-8?B?UGU0Tk5OTnZKekVsMDNyU3Zsb1VLcnNtQjgxYmswbFRqUXFCZXRJWEtjVWNP?=
 =?utf-8?B?blJjcGJVYXVnK3dVSHFJSUFTOXVjbmNaUVh6cXhaRjdDL21WMm1hSFdKbkNl?=
 =?utf-8?B?NG5WQ0lCNHhRWGoyODZuWHk5d1V4TkpMeDc1OS9leVNITVoxWUp6VWxvWGJ4?=
 =?utf-8?B?R0wwQ1NZalVBZEtHUlhzeCtTQ0gvTVE4dVhheFpDU3RPUGFpWFhIQ0JNVWtn?=
 =?utf-8?B?U20xUXhoUHNEZnprRHBsWHZmSjlIMHZZam9nRGZqeUhIRk4vLzdJUDZUM3Fk?=
 =?utf-8?B?TFNaZjZoUVE0R3dlaFJrUWpqOHRZWmJLaTFRNjJBdFhnZEFnREJjalNCdVNu?=
 =?utf-8?B?NUJzS2NDbHpBN2xObll1aTJUQ09JVW1GU2hJSnI2WHZKbkZwbUh4QnVoMlpk?=
 =?utf-8?B?NE1QcnRkVm8zcTg1UUwxcS8xbEZsSjJkemhFMlFlTVF0QmIyZFhIUElVSENi?=
 =?utf-8?B?THhIdmQvc3hUQWoyenhlZXRDcTZYa2hnZ243NmtZdWFPKzdRSkE1TWRDcjQx?=
 =?utf-8?B?cHB1cm1JdVVHREwvYjlxdUFpaVozbVBYYVRHT002Yk9LNHU4RzI3bTAwVmhW?=
 =?utf-8?B?ak5icHdDUEthVnVGNlJhQ1Q0b2JtazdxMlFHM29OWWpUMHAvcU0vVlh6U2Nx?=
 =?utf-8?B?RnJsUGpqK1VZd1dyRE9zQUhKTmhPQndMNFNSRVZMYzYxYytVVGtoT2JDZ05o?=
 =?utf-8?B?RGdTQnZTMURFQlVLUWY0dzVnYzB4VFFkUExOb25NNmhpd2ZWYit2L0UxcjNq?=
 =?utf-8?B?R0F1WHRMbXgxNjlqM2F3alBQMkZtMWQ1VE9jRk41ekxjMGx1NTdiNFJwV00y?=
 =?utf-8?B?cG9DYU5taUpkTDZqdFR2bGdRTjZJVTA4NEVFUmkrbnR1dXlNamFTVWN0cTJL?=
 =?utf-8?Q?ARkzy1T216S6EUw4CbVzMCX1AV0LLWBWLB4qz6DQLQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1AA428F381B4344BA71A2CB2DB36990E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae901e0-dc8e-4ddf-b32b-08d9daa01366
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 16:32:10.3662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xgCpoIOlyO1q1dsMyrZQ31hegASM53ZXxstJFKN6JRkXgM86sd6rWKvhu/FRapRjmjmmxcmuqay6Q0gmVNVdwjUqIGdAzHWGqjYOH9ZidMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5772
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10230 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180101
X-Proofpoint-GUID: 7NBrrOb35yl3HU3nhhKkuUeqzckLA8_o
X-Proofpoint-ORIG-GUID: 7NBrrOb35yl3HU3nhhKkuUeqzckLA8_o
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCj4gT24gSmFuIDE2LCAyMDIyLCBhdCAxOjEwIFBNLCBKYXJra28gU2Fra2luZW4gPGphcmtr
b0BrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFNhdCwgSmFuIDE1LCAyMDIyIGF0IDA5OjU1
OjQ3UE0gLTA1MDAsIE1pbWkgWm9oYXIgd3JvdGU6DQo+PiBPbiBTYXQsIDIwMjItMDEtMTUgYXQg
MjE6MTUgKzAyMDAsIEphcmtrbyBTYWtraW5lbiB3cm90ZToNCj4+PiBPbiBTYXQsIEphbiAxNSwg
MjAyMiBhdCAwOToxNDo0NVBNICswMjAwLCBKYXJra28gU2Fra2luZW4gd3JvdGU6DQo+Pj4+IE9u
IFNhdCwgSmFuIDE1LCAyMDIyIGF0IDA3OjEyOjM1UE0gKzAwMDAsIEVyaWMgU25vd2Jlcmcgd3Jv
dGU6DQo+Pj4+PiANCj4+Pj4+IA0KPj4+Pj4+IE9uIEphbiAxNSwgMjAyMiwgYXQgMTA6MTEgQU0s
IEphcmtrbyBTYWtraW5lbiA8amFya2tvQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+Pj4+IA0KPj4+
Pj4+IE9uIFdlZCwgSmFuIDEyLCAyMDIyIGF0IDAyOjQxOjQ3UE0gLTA1MDAsIE1pbWkgWm9oYXIg
d3JvdGU6DQo+Pj4+Pj4+IE9uIFR1ZSwgMjAyMi0wMS0xMSBhdCAyMDoxNCAtMDUwMCwgTWltaSBa
b2hhciB3cm90ZToNCj4+Pj4+Pj4+IE9uIFR1ZSwgMjAyMi0wMS0xMSBhdCAyMToyNiArMDAwMCwg
RXJpYyBTbm93YmVyZyB3cm90ZToNCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4gT24gSmFuIDExLCAy
MDIyLCBhdCAxMToxNiBBTSwgTWltaSBab2hhciA8em9oYXJAbGludXguaWJtLmNvbT4gd3JvdGU6
DQo+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+PiBPbiBNb24sIDIwMjItMDEtMTAgYXQgMjM6MjUgKzAw
MDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+Pj4+Pj4+Pj4+Pj4gSmFya2tvLCBteSBjb25jZXJu
IGlzIHRoYXQgb25jZSB0aGlzIHZlcnNpb24gb2YgdGhlIHBhdGNoIHNldCBpcw0KPj4+Pj4+Pj4+
Pj4+IHVwc3RyZWFtZWQsIHdvdWxkIGxpbWl0aW5nIHdoaWNoIGtleXMgbWF5IGJlIGxvYWRlZCBv
bnRvIHRoZSAubWFjaGluZQ0KPj4+Pj4+Pj4+Pj4+IGtleXJpbmcgYmUgY29uc2lkZXJlZCBhIHJl
Z3Jlc3Npb24/DQo+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4gQ3VycmVu
dGx5IGNlcnRpZmljYXRlcyBidWlsdCBpbnRvIHRoZSBrZXJuZWwgZG8gbm90IGhhdmUgYSBDQSBy
ZXN0cmljdGlvbiBvbiB0aGVtLiAgDQo+Pj4+Pj4+Pj4+PiBJTUEgd2lsbCB0cnVzdCBhbnl0aGlu
ZyBpbiB0aGlzIGtleXJpbmcgZXZlbiBpZiB0aGUgQ0EgYml0IGlzIG5vdCBzZXQuICBXaGlsZSBp
dCB3b3VsZCANCj4+Pj4+Pj4+Pj4+IGJlIGFkdmlzYWJsZSBmb3IgYSBrZXJuZWwgdG8gYmUgYnVp
bHQgd2l0aCBhIENBLCBub3RoaW5nIGN1cnJlbnRseSBlbmZvcmNlcyBpdC4gDQo+Pj4+Pj4+Pj4+
PiANCj4+Pj4+Pj4+Pj4+IE15IHRoaW5raW5nIGZvciB0aGUgZHJvcHBlZCBDQSByZXN0cmljdGlv
biBwYXRjaGVzIHdhcyB0byBpbnRyb2R1Y2UgYSBuZXcgS2NvbmZpZy4gIA0KPj4+Pj4+Pj4+Pj4g
VGhpcyBLY29uZmlnIHdvdWxkIGRvIHRoZSBDQSBlbmZvcmNlbWVudCBvbiB0aGUgbWFjaGluZSBr
ZXlyaW5nLiAgSG93ZXZlciBpZiB0aGUgDQo+Pj4+Pj4+Pj4+PiBLY29uZmlnIG9wdGlvbiB3YXMg
bm90IHNldCBmb3IgZW5mb3JjZW1lbnQsIGl0IHdvdWxkIHdvcmsgYXMgaXQgZG9lcyBpbiB0aGlz
IHNlcmllcywgDQo+Pj4+Pj4+Pj4+PiBwbHVzIGl0IHdvdWxkIGFsbG93IElNQSB0byB3b3JrIHdp
dGggbm9uLUNBIGtleXMuICBUaGlzIHdvdWxkIGJlIGRvbmUgYnkgcmVtb3ZpbmcgDQo+Pj4+Pj4+
Pj4+PiB0aGUgcmVzdHJpY3Rpb24gcGxhY2VkIGluIHRoaXMgcGF0Y2guIExldCBtZSBrbm93IHlv
dXIgdGhvdWdodHMgb24gd2hldGhlciB0aGlzIHdvdWxkIA0KPj4+Pj4+Pj4+Pj4gYmUgYW4gYXBw
cm9wcmlhdGUgc29sdXRpb24uICBJIGJlbGlldmUgdGhpcyB3b3VsZCBnZXQgYXJvdW5kIHdoYXQg
eW91IGFyZSBpZGVudGlmeWluZyBhcyANCj4+Pj4+Pj4+Pj4+IGEgcG9zc2libGUgcmVncmVzc2lv
bi4NCj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+IFRydWUgdGhlIHByb2JsZW0gY3VycmVudGx5IGV4
aXN0cyB3aXRoIHRoZSBidWlsdGluIGtleXMsIGJ1dCB0aGVyZSdzIGENCj4+Pj4+Pj4+Pj4gbWFq
b3IgZGlmZmVyZW5jZSBiZXR3ZWVuIHRydXN0aW5nIHRoZSBidWlsdGluIGtleXMgYW5kIHRob3Nl
IGJlaW5nDQo+Pj4+Pj4+Pj4+IGxvYWRpbmcgdmlhIE1PSy4gIFRoaXMgaXMgYW4gaW50ZWdyaXR5
IGdhcCB0aGF0IG5lZWRzIHRvIGJlIGNsb3NlZCBhbmQNCj4+Pj4+Pj4+Pj4gc2hvdWxkbid0IGJl
IGV4cGFuZGVkIHRvIGtleXMgb24gdGhlIC5tYWNoaW5lIGtleXJpbmcuDQo+Pj4+Pj4+Pj4+IA0K
Pj4+Pj4+Pj4+PiAicGx1cyBpdCB3b3VsZCBhbGxvdyBJTUEgdG8gd29yayB3aXRoIG5vbi1DQSBr
ZXlzIiBpcyB1bmFjY2VwdGFibGUuDQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gT2ssIEnigJlsbCBs
ZWF2ZSB0aGF0IHBhcnQgb3V0LiAgQ291bGQgeW91IGNsYXJpZnkgdGhlIHdvcmRpbmcgSSBzaG91
bGQgaW5jbHVkZSBpbiB0aGUgZnV0dXJlIA0KPj4+Pj4+Pj4+IGNvdmVyIGxldHRlciwgd2hpY2gg
YWRkcyBJTUEgc3VwcG9ydCwgb24gd2h5IGl0IGlzIHVuYWNjZXB0YWJsZSBmb3IgdGhlIGVuZC11
c2VyIHRvDQo+Pj4+Pj4+Pj4gbWFrZSB0aGlzIGRlY2lzaW9uPw0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+
PiBUaGUgS2NvbmZpZyBJTUFfS0VZUklOR1NfUEVSTUlUX1NJR05FRF9CWV9CVUlMVElOX09SX1NF
Q09OREFSWQ0KPj4+Pj4+Pj4gImhlbHAiIGlzIHZlcnkgY2xlYXI6DQo+Pj4+Pj4+IA0KPj4+Pj4+
PiBbUmVwb3N0aW5nIHRoZSB0ZXh0IGR1ZSB0byBlbWFpbCBmb3JtYXR0aW5nIGlzc3Vlcy5dDQo+
Pj4+Pj4+IA0KPj4+Pj4+PiBoZWxwDQo+Pj4+Pj4+IEtleXMgbWF5IGJlIGFkZGVkIHRvIHRoZSBJ
TUEgb3IgSU1BIGJsYWNrbGlzdCBrZXlyaW5ncywgaWYgdGhlDQo+Pj4+Pj4+IGtleSBpcyB2YWxp
ZGx5IHNpZ25lZCBieSBhIENBIGNlcnQgaW4gdGhlIHN5c3RlbSBidWlsdC1pbiBvcg0KPj4+Pj4+
PiBzZWNvbmRhcnkgdHJ1c3RlZCBrZXlyaW5ncy4NCj4+Pj4+Pj4gDQo+Pj4+Pj4+IEludGVybWVk
aWF0ZSBrZXlzIGJldHdlZW4gdGhvc2UgdGhlIGtlcm5lbCBoYXMgY29tcGlsZWQgaW4gYW5kIHRo
ZSANCj4+Pj4+Pj4gSU1BIGtleXMgdG8gYmUgYWRkZWQgbWF5IGJlIGFkZGVkIHRvIHRoZSBzeXN0
ZW0gc2Vjb25kYXJ5IGtleXJpbmcsDQo+Pj4+Pj4+IHByb3ZpZGVkIHRoZXkgYXJlIHZhbGlkbHkg
c2lnbmVkIGJ5IGEga2V5IGFscmVhZHkgcmVzaWRlbnQgaW4gdGhlDQo+Pj4+Pj4+IGJ1aWx0LWlu
IG9yIHNlY29uZGFyeSB0cnVzdGVkIGtleXJpbmdzLg0KPj4+Pj4+PiANCj4+Pj4+Pj4gDQo+Pj4+
Pj4+IFRoZSBmaXJzdCBwYXJhZ3JhcGggcmVxdWlyZXMgInZhbGlkbHkgc2lnbmVkIGJ5IGEgQ0Eg
Y2VydCBpbiB0aGUgc3lzdGVtDQo+Pj4+Pj4+IGJ1aWx0LWluIG9yIHNlY29uZGFyeSB0cnVzdGVk
IGtleXJpbmdzIiBmb3Iga2V5cyB0byBiZSBsb2FkZWQgb250byB0aGUNCj4+Pj4+Pj4gSU1BIGtl
eXJpbmcuICBUaGlzIEtjb25maWcgaXMgbGltaXRlZCB0byBqdXN0IHRoZSBidWlsdGluIGFuZCBz
ZWNvbmRhcnkNCj4+Pj4+Pj4ga2V5cmluZ3MuICBDaGFuZ2luZyB0aGlzIHNpbGVudGx5IHRvIGlu
Y2x1ZGUgdGhlICIubWFjaGluZSIga2V5cmluZw0KPj4+Pj4+PiBpbnRyb2R1Y2VzIGludGVncml0
eSByaXNrcyB0aGF0IHByZXZpb3VzbHkgZGlkIG5vdCBleGlzdC4gIEEgbmV3IElNQQ0KPj4+Pj4+
PiBLY29uZmlnIG5lZWRzIHRvIGJlIGRlZmluZWQgdG8gYWxsb3cgYWxsIHRocmVlIGtleXJpbmdz
IC0gYnVpbHRpbiwNCj4+Pj4+Pj4gbWFjaGluZSwgYW5kIHNlY29uZGFyeS4NCj4+Pj4+Pj4gDQo+
Pj4+Pj4+IFRoZSBzZWNvbmQgcGFyYWdyYXBoIGltcGxpZXMgdGhhdCBvbmx5IENBIGFuZCBpbnRl
cm1lZGlhdGUgQ0Ega2V5cyBhcmUNCj4+Pj4+Pj4gb24gc2Vjb25kYXJ5IGtleXJpbmcsIG9yIGFz
IGluIG91ciBjYXNlIHRoZSAiLm1hY2hpbmUiIGtleXJpbmcgbGlua2VkDQo+Pj4+Pj4+IHRvIHRo
ZSBzZWNvbmRhcnkga2V5cmluZy4NCj4+Pj4+Pj4gDQo+Pj4+Pj4+IE1pbWkNCj4+Pj4+Pj4gDQo+
Pj4+Pj4gSSBoYXZlIGFsc28gbm93IHRlc3QgZW52aXJvbm1lbnQgZm9yIHRoaXMgcGF0Y2ggc2V0
IGJ1dCBpZiB0aGVyZSBhcmUNCj4+Pj4+PiBhbnkgcG9zc2libGUgY2hhbmdlcywgSSdtIHdhaXRp
bmcgZm9yIGEgbmV3IHZlcnNpb24sIGFzIGl0IGlzIGFueXdheQ0KPj4+Pj4+IGZvciA1LjE4IGN5
Y2xlIGVhcmxpZXN0Lg0KPj4+Pj4gDQo+Pj4+PiBPdGhlciB0aGFuIHRoZSB0d28gc2VudGVuY2Ug
Y2hhbmdlcywgSSBoYXZlIG5vdCBzZWVuIGFueXRoaW5nIGlkZW50aWZpZWQgDQo+Pj4+PiBjb2Rl
IHdpc2UgcmVxdWlyaW5nIGEgY2hhbmdlLiAgSWYgeW914oCZZCBsaWtlIG1lIHRvIHJlc3BpbiBh
IHYxMCB3aXRoIHRoZSBzZW50ZW5jZSANCj4+Pj4+IGNoYW5nZXMgbGV0IG1lIGtub3cuICBPciBp
ZiB5b3Ugd2FudCB0byByZW1vdmUgdGhlIGltYSByZWZlcmVuY2UsIHRoYXQgd29ya3MgDQo+Pj4+
PiB0b28uICBKdXN0IGxldCBtZSBrbm93IGhvdyB5b3Ugd2FudCB0byBoYW5kbGUgdGhpcy4gIFRo
YW5rcy4NCj4+Pj4gDQo+Pj4+IEknbSBiYXNpY2FsbHkgd2FpdGluZyBhbHNvIE1pbWkgdG8gdGVz
dCB0aGlzIGFzIEkgZG8gbm90IGhhdmUgSU1BIHRlc3QNCj4+Pj4gZW52aXJvbm1lbnQuDQo+Pj4+
IA0KPj4+PiBGcm9tIG15IHNpZGU6DQo+Pj4+IA0KPj4+PiBUZXN0ZWQtYnk6IEphcmtrbyBTYWtr
aW5lbiA8amFya2tvQGtlcm5lbC5vcmc+DQo+Pj4gDQo+Pj4gSSBjYW4gcGljayB0aGUgd2hvbGUg
dGhpbmcgYXQgdGhlIHRpbWUgd2hlbiBJIGdldCBncmVlbiBsaWdodC4NCj4+IA0KPj4gVGhlIE1P
SyBrZXlzIGFyZSBub3QgbG9hZGVkIG9udG8gdGhlIC5tYWNoaW5lIGtleXJpbmcgaWYNCj4+IENP
TkZJR19JTUFfS0VZUklOR1NfUEVSTUlUX1NJR05FRF9CWV9CVUlMVElOX09SX1NFQ09OREFSWSBp
cyBlbmFibGVkLiANCj4+IEZyb20gYW4gSU1BIHBlcnNwZWN0aXZlIG5vdGhpbmcgaGFzIGNoYW5n
ZWQuDQo+PiANCj4+IEFmdGVyIHRoZSBJTUEgcmVmZXJlbmNlcyBpbiB0aGUgcGF0Y2ggZGVzY3Jp
cHRpb25zIGFyZSByZW1vdmVkLCBmZWVsDQo+PiBmcmVlIHRvIGFkZCBUZXN0ZWQtYnk6IE1pbWkg
Wm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IG9uIHBhdGNoZXMgMSAtDQo+PiA1Lg0KPj4gDQo+
PiB0aGFua3MsDQo+PiANCj4+IE1pbWkNCj4gDQo+IEVyaWMsIGZvciBtZSBpdCB3b3VsZCBiZSBh
dCBsZWFzdCBhIGNvbnZlbmllbmNlLCBhbmQgb3ZlcmFsbHkgaXQgd291bGQNCj4gbWFrZSBzdXJl
IHRoYXQgSSBwaWNrIHRoZSByaWdodCB0aGluZyBpZiB5b3Ugd291bGQgZml4IHRoZSB0eXBvcyAo
YW5kDQo+IHlvdSBjYW4gYWRkIGFsbCB0aGUgdGVzdGVkLWJ5IHRhZ3Mgb2YgY291cnNlIGFzIG5v
IGZ1bmN0aW9uYWwgY2hhbmdlcykuDQo+IA0KPiBUaGVyZSdzIGJlZW4gdGltZXMgd2hlbiBJJ3Zl
IG1hbnVhbGx5ICJqdXN0IGZpeGVkIHR5cG9zIiwgYW5kIGZhaWxlZCBpbiBhDQo+IHdheSBvciBh
bm90aGVyIGJlY2F1c2Ugb2YgaHVtYW4gZXJyb3IuIEp1c3Qgd2FudCB0byBtYWtlIHN1cmUgdGhh
dCB3ZQ0KPiBoYXZlIGV4YWN0bHkgdGhlIHJpZ2h0IGNvbnRlbnQgYXBwbGllZCwgSSBob3BlIHlv
dSB1bmRlcnN0YW5kIG15IHBvaW50DQo+IG9mIHZpZXcuIEFuZCB3ZSBhcmUgZWFybHkgZm9yIHRo
ZSA1LjE4IHJlbGVhc2UgY3ljbGUgYW55d2F5Lg0KDQpObyBwcm9ibGVtLCBJ4oCZbGwgcHV0IHRv
Z2V0aGVyIGEgdjEwIHdpdGggdGhlIGNoYW5nZXMuICBUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0K
DQo=
