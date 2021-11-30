Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78799463CFD
	for <lists+linux-efi@lfdr.de>; Tue, 30 Nov 2021 18:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244953AbhK3RmK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 30 Nov 2021 12:42:10 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58848 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244935AbhK3RmJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 30 Nov 2021 12:42:09 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUHYMa3019746;
        Tue, 30 Nov 2021 17:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KrNS8J8peoBIOLYOyxCHxqIdVOXlgA7akUdJJYcxt3o=;
 b=gKFMY49rv6SxBthaZtCeNnrYS/1M0LNEYbnnk6f6spNkLMKQfhp8uYzqSFfEIzPXD+dz
 oZnGnMjFYYD4YMuAa+Q/y6gbfBTDemBu9nNaqMxfwdeb8bokEenawGmW5vZIL6ToNaP2
 3jeeCdGOoSOKxGy6amN/K8g0/i8SY2F8JiwMWd3Fo/yupTvB7T7c29SE9BZnDUzzJrOI
 AsddbUKjpfVnLm3ytf/k5paImnpYppoP+tDTcX9Lxe2ox3uxlgEBEPBapC5VwGZ53EVe
 Rp4cy2eGPWlvZyWjR5x7y6mbs0AxltCvcifryXy/5ShBkoCvVpoQGLwiXj6OnVko7Fq8 Yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmwu945-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 17:38:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AUHLmJb152834;
        Tue, 30 Nov 2021 17:21:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by userp3030.oracle.com with ESMTP id 3ck9sywmqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 17:21:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKbMVlWsY7a3mHzdeKhqMd67bjoie/8VSmnYK/fZcpL/SlGgvgl11YQzOUKLgOlN8Uye+47+yiMxgSPfM/2goz4Zq6I0E89vppOMSRDKqEQ56V1QOseUrie2Y8tKHlUZYA7t5N4sovOr7J5qPiQTe9a3KJ2VtDYYdGZx5Lxu73nwG9AaGHM+9L6utLdsi+KzwFE5aWmXlqn5xlhZJmJHhEDK0dShvYkawjrsGhr4sKkaOVGpm0+X4co1T9AZj3dUeKUN/k9O1HN/Z+YPNdIWcOj8PjFh7gTVwE6F0EZAPiMAjknm0yvVCVfR4M2y55o7V71xJWkGh0XRN/BQxNn/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrNS8J8peoBIOLYOyxCHxqIdVOXlgA7akUdJJYcxt3o=;
 b=YBR+DVegzsXDNRaSFoQ0bMgZ5qtDjNBxtTl16CqUBHAeznikukzuUM+rnw6/f21CfPJmmQjGCj/adIUegW1eYTnabvtV/gZqn9e0xCI2puZUQ0kOZqhPsOlcd/nBkh6BKx6yDRNuP4Cg/SwZpgxTgg3yKMQUGGdpWrIjvE6Dqc/IrWwCZiZAEXSEqE28llclnmn79UJl5zN2cDFdxwUv8uFEKeFWiwD58cHRaU/rx4fVwf85gtHhKpqI5d82+8Fznup1h8g27Xa6mbTUCHYgIwlsYlROxdY6wxvZljhGxRcqirBi4kPg6btmeHMymObwa7kfVHcLxRuAfGfWOPSGgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrNS8J8peoBIOLYOyxCHxqIdVOXlgA7akUdJJYcxt3o=;
 b=RNQvQgo6pk/giME/t/FrxYv9VxtbqJf6hBY6Kue218W6rksdgP1MgxFyB+LzN13OTWQ9PiDntItkhhNf6sNqponFf6LypRUh1yWHPLc6URdSLXM2IOIxZALfY4nf/230LbBpwvclQ31uyVn8kKxeTgCUi5UNNruVhCBbhRBtZRI=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4310.namprd10.prod.outlook.com (2603:10b6:610:ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 30 Nov
 2021 17:21:45 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4713.021; Tue, 30 Nov 2021
 17:21:45 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
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
        "pjones@redhat.com" <pjones@redhat.com>,
        Konrad Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v8 09/17] KEYS: Rename
 get_builtin_and_secondary_restriction
Thread-Topic: [PATCH v8 09/17] KEYS: Rename
 get_builtin_and_secondary_restriction
Thread-Index: AQHX4O2pDdgPDu39Wk2pZOJ3EdBmzqwWj2cAgAXMOQA=
Date:   Tue, 30 Nov 2021 17:21:45 +0000
Message-ID: <8906F8A4-313F-45E5-8ABD-A1A2D07BFD93@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
 <20211124044124.998170-10-eric.snowberg@oracle.com>
 <fb1d583f588e3f46fdadbe3cf6288bb098ff45f8.camel@kernel.org>
In-Reply-To: <fb1d583f588e3f46fdadbe3cf6288bb098ff45f8.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 463944b0-3f9d-4bd3-d41c-08d9b425e25a
x-ms-traffictypediagnostic: CH2PR10MB4310:
x-microsoft-antispam-prvs: <CH2PR10MB4310C249B8DC82AEC557E9B887679@CH2PR10MB4310.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +oKuCCV5D6mFrzP7YYZ/9HayQdEVTlqFxpykLrpaliVzXsUgipQIM/LY8vBwF05VKhea8jqcx21XubgT/PWi4y1AUNN26juRrE3hZOvxOEcasXsR17LzbdtYgK12hfMLrHWRF95GuuT7j4wqIoGpeY+DfbX3MxOVlOvdPwkV5T28odbHkEvMm5jE8J9D1jknkLgHATTlv4O4KVNyc/afLOgnHZwOhSWekjTfMDL3+pISoa8H/UYLlLCbmkRjDbjnLKi82mS56CddcIX4GVCon0MFZvf9rNnSzKrPbRS/0KACCK/du1Ug7jR157rSBJbbnrFBRc7HIlcLGSczLKC57rKeDyFjJ03XD8heATUVRHfVcIcH01NCIndZvDm1+lV3XPNUYT+99l5rGcAcZijHV1C+N6EprvauSd7/m6Da979VCKgZ+/gNuHcIFeLs7KfU8fHr1FMXdN1kgQgeVQ0JqEyimwy3bh+gFSyK8IxbotStUGV2rh5wFs01G0T2TK0inrF6IFnC404dsB6nrHyhlXGRB13ftJxxizxn2Fd60wto5twojuAEW2EZWGv+CnF9jzys0e16D++lzS2azdVNdvV8sxCstFxwlJm0UOIMepX8IKSIJjco1+1VA69GlH++KDnOb8F05NdPLHpWalBLMTFf61PEDR1eJHJl2mwwZeRXURWQ96yxwsfZINOt+iEZVVayqktzH1izoRRbiJ1Tnz3aKlIYGjxBzmSSyGRrakE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(6916009)(4001150100001)(8676002)(71200400001)(66556008)(66946007)(316002)(33656002)(66476007)(2616005)(6512007)(508600001)(64756008)(8936002)(38100700002)(76116006)(4326008)(54906003)(91956017)(44832011)(186003)(66446008)(38070700005)(107886003)(83380400001)(122000001)(53546011)(86362001)(6506007)(2906002)(6486002)(5660300002)(7416002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dESvCPo5pji3P7YFNn+kIJAmlyFr7oRlpOFb3IHafeQJPLCnkeUm9QK1g4fi?=
 =?us-ascii?Q?mxraiKGCbj2gNvmcD9hSJDv4lJG0yU/fbl0Bh8CzcNptePSKExvjvuREhRju?=
 =?us-ascii?Q?7La+TqjK/48bBGtId+6ShlNwoOw9JSzREGjN1mvQW8FhkbVkEl7PQKMoVU+s?=
 =?us-ascii?Q?2V95tWGfZCX5sk+Txos8f1X7wWr+nMqonNQ13/51/EEZukIl9h13NxiMz2+f?=
 =?us-ascii?Q?H+zKJRvoQgaL4fhPkz45kdf6BkCBxatR9gKc/7xMTt75u3lW1skKF0SMuZ5z?=
 =?us-ascii?Q?Poutd2f/lkliuPvaO5sSBhQWvITcdie1r8OpTYZPdC0WHdp05bLfyqqhg2Cb?=
 =?us-ascii?Q?eZbjhfahv64CKx9I5lVaJ44BTf40PDOZq9WZjNORIjKBZFJeivJ+0i24uuMR?=
 =?us-ascii?Q?V1/DtCMabftUsmIuFTUC9A5YGorxasTPG7nimm0/AfNwGRRPZuYydN8aLtas?=
 =?us-ascii?Q?omJwMsMJqmjKjyLJyKDNdHH+fR0LgXOWStDw/gKUg7Srlk2+PFhgxoLTsroL?=
 =?us-ascii?Q?ZszQ9891ClVrvicJ6afC0tslFhaaUmKqe1GotZ8mDw1dHBmz3lYJObnbhtw5?=
 =?us-ascii?Q?ntANITGK5VsvqoAqg2OZjhW9N4jBD2kBZA1eJWSdVOFdHfd/bmU0DYFa9WKP?=
 =?us-ascii?Q?tha5KYdfFo92y6Fu0fACOe8iKGM0GBW50IuDpgrKMxI98z9YLcFEVbolZvRZ?=
 =?us-ascii?Q?uys9CgROeeaKI7G9R84XyVODqYfNFPV3fOy7FRUdCYwhU4kPEs50tXxVxvTw?=
 =?us-ascii?Q?QMvzKlr+j5uD8CsuMpgfMj7/36QFohlmjZbNUeDDVh5QmSrxQp6pMQNKQgnn?=
 =?us-ascii?Q?0Ckow/LrxzAhTcYCn6+p7KTWK48+PDsP92+Vh5Wd0lPJ0QRIjxWz4IrzsHZ3?=
 =?us-ascii?Q?XnobOPyHB6JGcj02/tAngA2L8QWXtWTBKdOJg7b+WDIF7SKXmoNXQDpTs//3?=
 =?us-ascii?Q?y+kzyEaBwkzK33Cc/UWeXT2WQwQ7LKuK54fFr3Q3IFjU+wvNe5gzoGrFXuoe?=
 =?us-ascii?Q?MWasCqmWqbnWkAOKnzBn2wP1gWIcZxf2tcxJ3ihzP39Jg15b712HfBwjNRn/?=
 =?us-ascii?Q?KelWttgHF8sL8Vd8JyT8mMDEcAMII997VpoXiSM0NaACnPuPItGzltbPXiF/?=
 =?us-ascii?Q?YK49XXiexqFD/vF6/P/uG1lrwS7sNANmQdOwotc0IrF3bCetgWKUtJbZxyg0?=
 =?us-ascii?Q?hioeTCRBGHP394SWx3N215Pn+poZCPAmhEiqqvZHLpcjmbnlc1L4wABGte4A?=
 =?us-ascii?Q?zxncOeC3u6qa0wFtw1jSdAak3bNYI928E8DwpEWUWC3BqWpeiKRquHFHrFNY?=
 =?us-ascii?Q?wSRYpPteuZr6NVWba/U6jqHsr3cVBrDwuiSyRe/jhiYkys6ogK9KWq/9sEKR?=
 =?us-ascii?Q?CBc8Nhl1NKslpQ08BwOQ53oNajIa39NqV5OohTRB2bQR44SX/Ek/BIQYBs4y?=
 =?us-ascii?Q?yx41CxiX9jTduMryAOPqcraNZXWYbLSOWqpNay9x7hdY7e9J4BOV1NF6g7wI?=
 =?us-ascii?Q?Hp1XHJenNG1C61owLhS+5yWuEnP72dmrBQHARfbpmPPE1AjBBA5mkfWxIFzH?=
 =?us-ascii?Q?zsia+syaGHCG0SBVi/Fo+bSlp0XEHKp5cIbbdb/trBr5Gu5JtkdQbStWAOnW?=
 =?us-ascii?Q?f5ou78jy2c57pu1aEsa/UvWFR+1e8Wykqm+lv8qf5dOPNeJVqxUhPvYWt6uc?=
 =?us-ascii?Q?g3fVU5YQZw+501Fthk1L3bim6G9JFRbrhvkQY11Pv0FJj6Eg?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <51E04660718A564D903A8411D920E554@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 463944b0-3f9d-4bd3-d41c-08d9b425e25a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 17:21:45.2764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AGzOyYXAtk1y+opCdcYZ3dU6lrpEkUOfZa7VpVjcELWE3Nv7EEVBtvjbpkmm6+yiFxayot+FHMIYjo464IRrwO3rOPFpsy/CQD0e/kyKXhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4310
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111300089
X-Proofpoint-ORIG-GUID: DfJvNXh7shEXIvflWTvYaQyaoH3Ppcuf
X-Proofpoint-GUID: DfJvNXh7shEXIvflWTvYaQyaoH3Ppcuf
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> On Nov 26, 2021, at 5:49 PM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Tue, 2021-11-23 at 23:41 -0500, Eric Snowberg wrote:
>> In preparation for returning either the existing
>> restrict_link_by_builtin_and_secondary_trusted or the upcoming
>> restriction that includes the trusted builtin, secondary and
>> machine keys, to improve clarity, rename
>> get_builtin_and_secondary_restriction to get_secondary_restriction.
>>=20
>> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>> ---
>> v6: Initial version
>> v7: Unmodified from v7
>> v8: Code unmodified from v7, added Mimi's Reviewed-by
>> ---
>>  certs/system_keyring.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
>> index 692365dee2bd..8f1f87579819 100644
>> --- a/certs/system_keyring.c
>> +++ b/certs/system_keyring.c
>> @@ -77,7 +77,7 @@ int restrict_link_by_builtin_and_secondary_trusted(
>>   * Allocate a struct key_restriction for the "builtin and secondary tru=
st"
>>   * keyring. Only for use in system_trusted_keyring_init().
>>   */
>> -static __init struct key_restriction *get_builtin_and_secondary_restric=
tion(void)
>> +static __init struct key_restriction *get_secondary_restriction(void)
>>  {
>>         struct key_restriction *restriction;
>> =20
>> @@ -117,7 +117,7 @@ static __init int system_trusted_keyring_init(void)
>>                                KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEA=
RCH |
>>                                KEY_USR_WRITE),
>>                               KEY_ALLOC_NOT_IN_QUOTA,
>> -                             get_builtin_and_secondary_restriction(),
>> +                             get_secondary_restriction(),
>>                               NULL);
>>         if (IS_ERR(secondary_trusted_keys))
>>                 panic("Can't allocate secondary trusted keyring\n");
>=20
> This is wrong order.
>=20
> You should first do the changes that make the old name
> obsolete and only after that have a patch that does the
> rename. Unfortunately, this patch cannot possibly acked
> with the current order.

I can change the order, but I'm confused how this would work for a git bise=
ct.=20
If the rename happens afterwards, now two patches will always need to be=20
reverted instead of the possibility of one.  Is this your expectation?

