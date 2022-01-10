Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5B248A3BB
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jan 2022 00:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345423AbiAJXgr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jan 2022 18:36:47 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38962 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241114AbiAJXgq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Jan 2022 18:36:46 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AJlfSt011393;
        Mon, 10 Jan 2022 23:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=68e0BPZd9qRg4c7+s1t0i+7mBLmDBVmL/b1xosFB6Jc=;
 b=ij+psEifx9zZ/xe1jyoBB+mypyFVjKgLM0HbPSMbWtpAULMpbOCYcZTnYhBmDVloxCTs
 P1OJY3F8xpHn7SGi5/sNwq13MMwFuF6QiUf5A3GNmzDydrYFbD77aKtOlpoO/DueX94n
 rgAB9wcBLimsVZQy2zx1x9GuiMh8nBPp/+g8g59j2Ppzbzpb0t0h51L/enqeAlKYB0nm
 8oRXgAQOvAzQ+BR3KGyo55rMLmQ8B3/c9neL+QnFQMai1rIh0FqKaTN8/fgXv9ruiSYj
 MPZ8snZt1BBsMj5KDPsjPIMMe5S/feMsfWSvJuJ06s9QESoemicG/9v/FfrwYA2DhBMq Xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjdbsyr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 23:36:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20ANVbvu181025;
        Mon, 10 Jan 2022 23:36:20 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by userp3020.oracle.com with ESMTP id 3df42kr7rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 23:36:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJYUMYefC7RZY4YgH58cHXL8higof8CcR8yoxJbLSZn610Nw7Gu0d8Scv2tBetNIhFvrdd755FibH0iP9PF0EDSWtdeDXmGX8XG4YAfMc/fzp+KfPF0OpdNLJGgYIlrsFuNdETsJkBrYOBQIwmUIdZ/4i+gS6KTyiFtI2YOJnJTbsPIEZeZSvAl8afmDgmzEIiw1vsfr8w/8TLqJYVnI7WZzKq2X761TzyLrxdEYjRVd4dIkJDJfxnIQGrJ95q72sE4FyVw1dATqCfbK5n1hAIRnir9rE8FptVfYbuDLmz8MDNPcTyuCqR1JZwu8J0ZrbaYW973kvmBauQnvBXBZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68e0BPZd9qRg4c7+s1t0i+7mBLmDBVmL/b1xosFB6Jc=;
 b=RtFqqUUNMwl4HNPqn/Rw1bLdr37MFf2pPBpY6Q+/m99kLRZ74j4FRNPpyscwtaXT8oQ83jNvnJBimUbREFTXgNG7d6yxey4eJQjkim/6kLv/KrFtwT1iaoxyRh17B3uJYExEFdQ4PY/FyV94qjvFLhVJOYDYqZDNr0AZIP+awfM3YRv3dE8LRlJVRI62pfdtDFTnvGsqNRlGVihTZ5PdBXURVQmtUnFtyRlp9SsYmfVMJHHPIfZt7jPxEML5jk6vblnrcOS0S5tmRgGEh45rwvCNSfHcfO9tr1/XeNtXMWpvww+dxGZaZZRUEPfyyo7mr7OTrzxRkUB0Q9AsSPl33w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68e0BPZd9qRg4c7+s1t0i+7mBLmDBVmL/b1xosFB6Jc=;
 b=EJXHuNHUb2ztpfhPQW2KZWVbyCkSLO+hfakKeba1nowNOFtVXdFI4Vtd9czgove2g9QGW/odAaEcSuN23d/ArwW3e2jnjrFYP5a4Ggd1/D6VwXbBZDhct/Ps1ImBnlXNzlzn3qbbTJ7o7V+akvXHBYfXaegbeLNYozzbjWkrQiQ=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB4921.namprd10.prod.outlook.com (2603:10b6:610:c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 23:36:18 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a%4]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 23:36:18 +0000
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
Subject: Re: [PATCH v9 5/8] KEYS: Introduce link restriction for machine keys
Thread-Topic: [PATCH v9 5/8] KEYS: Introduce link restriction for machine keys
Thread-Index: AQHYAo8Lf6JJxZcbbUa/7SoRhFBHJaxbTyeAgAGhdQA=
Date:   Mon, 10 Jan 2022 23:36:18 +0000
Message-ID: <D9CB25CD-3A9B-4A9D-A0D3-11A7E6DCADE1@oracle.com>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
 <20220105235012.2497118-6-eric.snowberg@oracle.com>
 <4038761f32f97ab60802fc0bc9cfa65fa0ed4bca.camel@linux.ibm.com>
In-Reply-To: <4038761f32f97ab60802fc0bc9cfa65fa0ed4bca.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0aa25f67-425f-4c7a-3da7-08d9d4920066
x-ms-traffictypediagnostic: CH0PR10MB4921:EE_
x-microsoft-antispam-prvs: <CH0PR10MB4921A44497A55A27B2E708CA87509@CH0PR10MB4921.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Dj53T+tGxxaN66iyd07ny9+Qqb6jaK9BcjUA1zSq0UJArVnj3FKUT4aFlkDIvuQbeWih+1miz1iYqAHJzm60JOzO6HLQvPPcY5XVlIN64f2NdfwRKSHUL1sKWe0HqPrv6ivbhuMHAYs86j5ECa9+9XI+AbkK/DLk9SppZK6jzn0dQdJ/V/2k01TqX6m+mkaLNQ75/Avo8NHLCzF42rC69oGhRzSvXSN5y+kz8vY/550wO0havWnUi9P9yofnndNH87wBaIhO8T5VQAopTINolIRRnQti2mnIOs4MML9OcsF7e0hAPgySqvQv/OqRMLJeDQCUcqAXgJcjz6Sx+oT7Wd9Fv7VT19Deq0VYTscPZ1akWqds0kqng7H5UMqlPRtLIkcB9ibB1zH/tu7mIxjDWyevFqvBDUV+bIrzXnVldbdhpmP7RLa3R4VZuEPjKAnJVRoLczCY77GX4FUJ1xw146AqMZUdhAajeX+AEUhrBx5Ur4sZ4allaVuDABtwJKhasTuoCxr/pVUX9jK4gJb1nFOoDn+V3xjODpdQOYxuq6yb/4OqqxtZek4akOEMTq0X2ggPPW+C3JGdT4Qq542rwlL2bj2kXjGLwtFfpZsg/VgaL0thRKsfMUAz5lLsjARDJa8G826o00xXXGq6afOpMc0t4ymP6xOJF9hPZ13OblWtDpDgBRGfAj5QmgmukazJVLw+UNxLKTY8M1Ka85j8V45E4k+p9HlKo2fQQLa8pc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(71200400001)(6916009)(66946007)(2616005)(122000001)(76116006)(38100700002)(38070700005)(64756008)(508600001)(2906002)(316002)(66476007)(186003)(7416002)(26005)(83380400001)(6512007)(6506007)(107886003)(53546011)(86362001)(8936002)(44832011)(8676002)(36756003)(54906003)(33656002)(66556008)(66446008)(5660300002)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SBToVq9abeM9HgN1ZXk1AgudfV0Ku35a4BzCFsZFgr91aBRhTfGpYCruzFsE?=
 =?us-ascii?Q?+H3c8FUVCGgnp/lYLJKoKFqgSqu0ykUF11TGj9ooGikZEx72V0LPgj7zP1EQ?=
 =?us-ascii?Q?xhVkUzcs1O+jPV7zQTiZDLnHwhQxEnSIkZ4DQx/nC77jqQM+Yr6MmHPvfu6R?=
 =?us-ascii?Q?NDnadRBn2X7qdBQzzSgBjFu/eM+pYgNUXn1XmKGteAax0mjJ7YqCJdnVXtlt?=
 =?us-ascii?Q?/OG/wuYp3M57FAkkHALHXOM+yPN4pBC0GjwKXwFIKFDvZ8Xc2aNLTgKd+a9D?=
 =?us-ascii?Q?IuMUx9DPdi1ISyytDhT14ulajfTlmHbInuAqIBq6IPqWXKPYSkNfatPEB/ip?=
 =?us-ascii?Q?5gB/N9d2On8ngCXRVT9pAtJtS4Jg1cWpj9dzy9gOIU3pbqEYSAUvElCFc8+H?=
 =?us-ascii?Q?DculH4OQxpHDH5C7Ofnzop4f/IAqQhrnO74DGPRpgtOZFSHdPFon1Z5mxcgk?=
 =?us-ascii?Q?MROdu0avbxzZaqiwSk47mWArrBE6tnun9/bJLrFBeSzEsPZPFGrvuqG/tSRz?=
 =?us-ascii?Q?2QeXt6sjfTcIjIjAyjML0eOYYrR6uGbHB3QDgQPx0PnHHOfeIkTuOcezoW0A?=
 =?us-ascii?Q?taoz+CfcXS2xVrGQfNfiktoTAy6rLp1YHJVaKVobBPbvSuUbfBfLn8AR9J+E?=
 =?us-ascii?Q?9RCudmNCYLertfU/aro/7RdY5sinZ5tru2469G2e9fQMjeA+37FzqHse5nDa?=
 =?us-ascii?Q?Fojzb6dLS1gbwQiOdYiiFdia2OqapRR/zNz0ZYx+RvS+1HqiGTxjVpnZCWm0?=
 =?us-ascii?Q?zCBHTPNt1aeBjfTiKL9BqFzEHbeio5SjY4wGyt9kEhVRs4Xp/u+FlYsS3yzN?=
 =?us-ascii?Q?gbfevolzP3pzKDz+oKBpfvqqtob4EPfKGNK/G29TP3q2J4YS6OIppLv6UAXU?=
 =?us-ascii?Q?souoDkNcKoTvaEXVNvUUDrdtTXMKs/WQnaBgwkRgGlNf5L8Tvxftli+bXVGn?=
 =?us-ascii?Q?roQunQuFCEIipgmk9TxSso+qxMU3yderTmGSM9W5bCYPhvdzvJYo96RVl0YV?=
 =?us-ascii?Q?9TLJR+vzR8NpT+0i2OvBOk4jxukrRZg8guEOf7mf5KOCpijhcu1S8WX6eQwH?=
 =?us-ascii?Q?3T9rVMUJMA7WARgbcGcEkH6TblFCcW7aXxtFVfv4CT4bPc9ZaDkfKguf2eZZ?=
 =?us-ascii?Q?7KE/wmlBq8KvRgHwD91i5oQ6LoI46HOruok7prCeNVNJtjOq+QMXVooW8DjF?=
 =?us-ascii?Q?ZecXsbM+FA3hjIO4uIV3G0+BimumcYCEztY5r8GVfGPaasy8d6qX7yF8POJu?=
 =?us-ascii?Q?Vql634mHpW/zEs3q1E8VMbffZyacGYN/FCzLKupVgqWJqY9s6mb37kUzjyVM?=
 =?us-ascii?Q?n6SO7blslCRGqkBojPQ58XoNZw7G14pUsGD59VlcAnR1kQhl8sv1HZ0mTfm7?=
 =?us-ascii?Q?4TWG8VVjeyPmQiAymnsZPyUNad45VCpRs4VwTI06ncUbrgl4NN2B+vMaxDZg?=
 =?us-ascii?Q?bLrZNLxy7lJq8hPo8PQ/gxEVCbv00d+V9Sxi/9DDFFuW1cW86cSdJCpNBx2a?=
 =?us-ascii?Q?pj7CDo6U9nnUtyrlSxiwM+x9ZFAFZps9ZCVRAqjK2Hz6fjRnoFkKBLTruonm?=
 =?us-ascii?Q?k7Keme07iQZNHoNmJVGxCuF5deO8xIfjia3GufExSY0/tFLOkr1lZlmk5TZ0?=
 =?us-ascii?Q?WeGrQw59a55YmYEwaFmyFKWptZqo4plpDJQKcF40fIQy5M4j4zGKg4iJgqgQ?=
 =?us-ascii?Q?Hk3pmcTG/AOtIUmDdWn+28Wqy64=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8547326A2E9A574C8557EF5357D27B0A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa25f67-425f-4c7a-3da7-08d9d4920066
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 23:36:18.5556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /MCjSS2q8KXl2wHQNtMwSCOUwudC24hg8IvR4bahczH9DdnkzpW3yq4IHoolPmo5fSLvEMtW67YxS7eLuovieUCU9E0KYIDxS1ah32u0f8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4921
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100150
X-Proofpoint-GUID: l44z8ZdSfr8oEzrfK9aak0mIhFbNlGbI
X-Proofpoint-ORIG-GUID: l44z8ZdSfr8oEzrfK9aak0mIhFbNlGbI
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> On Jan 9, 2022, at 3:42 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Wed, 2022-01-05 at 18:50 -0500, Eric Snowberg wrote:
>> Introduce a new link restriction that includes the trusted builtin,
>> secondary and machine keys. The restriction is based on the key to be
>> added being vouched for by a key in any of these three keyrings.
>>=20
>> With the introduction of the machine keyring, the end-user may choose to
>> trust Machine Owner Keys (MOK) within the kernel. If they have chosen to
>> trust them, the .machine keyring will contain these keys.  If not, the
>> machine keyring will always be empty.  Update the restriction check to
>> allow the secondary trusted keyring and ima keyring to also trust
>> machine keys.
>=20
> As suggested the Kconfig in "[PATCH v9 2/8] integrity: Introduce a
> Linux keyring called machine" only loads the platform keys onto the
> .machine keyring, when
> IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is not enabled.  The
> last sentence needs to be updated to reflect v9.

I missed that when I dropped IMA support.  I will remove the ima reference =
in the next
round.  Thanks.

