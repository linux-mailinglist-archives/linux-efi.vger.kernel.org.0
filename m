Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DDF476080
	for <lists+linux-efi@lfdr.de>; Wed, 15 Dec 2021 19:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343627AbhLOSP2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Dec 2021 13:15:28 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15606 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343605AbhLOSP0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Dec 2021 13:15:26 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFHw5dP030510;
        Wed, 15 Dec 2021 18:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xT8Fh9kMzvIu+YvAIU7axDKgidNDef/THtLXIOP8jYE=;
 b=y8bFCtm6DgAvjwQ0zLoXg2H42hNbWcROkSoQW8kAn7hcgekbx2hkpYyLWf76LpyW4sQa
 Zg8h0DAuiVDoAvc+M4X4w5QL/rNlFPFWQyW7R6QXe34UDLd08Nv+uec0rNoYzhxCSBKz
 Y0FSoc3Dn19vTN1vwNpSs+w2eX89VdYbpbZMsvI+uSOoNOjUB/UuneQIWfibnYonbUm5
 o5j/wtyOPadL2KEgCEXlkhxpJoV/is+PdS1D+g+uR4j0KiBwk9uP0zj6vYwJYtFPbAl7
 yecreQPOWeXGyRSAC2S1GqenEocbMVHEgWjh5PM2ovxg1TKnZZ/8pq0nvhyeFWhUEAKy 9g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykm58eek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 18:14:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BFHuXRa163199;
        Wed, 15 Dec 2021 18:14:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by aserp3020.oracle.com with ESMTP id 3cxmrc7ab8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 18:14:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQ656U5zRBwAZ8TlagaVuALx8e3Ow0di+ud+CPFoJyGDis5dTmZvs7E0rekCLMcaam7jX6vs3t1D7Vb0jvaVMs2fyg/hJYlPY0ia+QOFyDmd9+TqWrWai6ObckHPUbf2y09UbW3/JchPIZtBdwjqQHM1vrRTosnwuuTRm67VHZgxh8BGA4IZikZHdNS2pYnhMzu6SwcH6HM+p0iOCp59j1S11okeUZP6jF84BaZgDiJNH2rbnLh5J5MkWoqNhY6La+c1pXr+lhSDs6/BmsDH29MlCGCYj1r7Ocag1Xgd4M+LHGBqiVIq5S7gVrmY3DJPfMgs5xOq19qMjPK5lJI+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xT8Fh9kMzvIu+YvAIU7axDKgidNDef/THtLXIOP8jYE=;
 b=WSU3vKfalPfgzq7GuJ79Ek255qEPr1s2gE8InNzY3UI/riom5oj+1D1WioS00Bx9WhAF1y4Pi/wjK+N7hDEpXTb4P5uWbYIHwE8kVp9oKYnTNl5uhcfVlzOFgSM+8QviRMBEG0I7rtDgRPasRBDnwL8xgamTABg6u4iRCtT5pPnT68Vs+MsJHMgTeWv3F1ZW6MpO8Se5bHiG+yKuywNxbIGa5KIY0nsTGoD3aGn8Tt9PCAJvFJ34ve94xoklUOqEAyAdEgvRBlfLYvblW/fbuUKFUnEmMmFDyyZceAdcL4FiX9m1/5Vhc5zGs6rHRioN8q8Tjc4JRi4Ze4G11wFADA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xT8Fh9kMzvIu+YvAIU7axDKgidNDef/THtLXIOP8jYE=;
 b=ugU41m1D88n///onx3gKlo3KJtWhymex7NqEFNgt7iQTwI6O2FGltPrTmd8+/Tw/0pNnREVpQdJsyGS96wMO7tnTivDfCFyDBn5+OpIRCsS5DTzemGQOJzexNHQzUMRs2bBRrTQwbCMZeUQDfoSVvNomPJvA8kz/AqwqOihGGc4=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB4827.namprd10.prod.outlook.com (2603:10b6:610:df::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Wed, 15 Dec
 2021 18:14:44 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::65b8:d8e7:e373:4896%9]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 18:14:44 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC:     "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
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
        <James.Bottomley@hansenpartnership.com>,
        "pjones@redhat.com" <pjones@redhat.com>,
        Konrad Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v8 09/17] KEYS: Rename
 get_builtin_and_secondary_restriction
Thread-Topic: [PATCH v8 09/17] KEYS: Rename
 get_builtin_and_secondary_restriction
Thread-Index: AQHX4O2pDdgPDu39Wk2pZOJ3EdBmzqwWj2cAgAXMOQCAAR68AIAAN5SAgBZLdwA=
Date:   Wed, 15 Dec 2021 18:14:44 +0000
Message-ID: <31FE813A-91D5-46B8-9658-21F3F1418643@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
 <20211124044124.998170-10-eric.snowberg@oracle.com>
 <fb1d583f588e3f46fdadbe3cf6288bb098ff45f8.camel@kernel.org>
 <8906F8A4-313F-45E5-8ABD-A1A2D07BFD93@oracle.com> <YadOLrHb14MEfphi@iki.fi>
 <61f5d74f861ce1015831649d3bca9272a2e3b7bf.camel@linux.ibm.com>
In-Reply-To: <61f5d74f861ce1015831649d3bca9272a2e3b7bf.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99e81cd5-7d6b-413e-c459-08d9bff6c54e
x-ms-traffictypediagnostic: CH0PR10MB4827:EE_
x-microsoft-antispam-prvs: <CH0PR10MB48276B70DB6C787DA8EE98D987769@CH0PR10MB4827.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ofbt8VLsz+252ZNoPqSLmCkQzElx3Ha9s5sNXO7/HYwShDKfgknlcSrX6VGXzw7XoAGQqCR8RqoRmi1zMGfs9dgixYKVT/iu1OkoJs3HYyyp5ZGv9DdtjJ0jOVEsgQ2QNoKZsprGj1HPctInFp4YEEMUrsumFOjpSTzoCqGa1b2T8k0OrLxo+uhR8ftk+5StW8SY1EmZ2QhSBudDuPNSY5NudQm3J6BAKT1zrchK8X012CAxrXg+eJqkk18jnyP+vSALAHyWL9KJv+2n0eVenQjVljwnIblDKGdbRAi4zRBSu14R1yS6MPIeUjYIRp5954WsRTB0GwBJ8rdOd1pUapx4iVWGXvj27VgLx55auugo8wOUQUdZ9NljjzpQ9WYleG3TCfGK1uuVxWhZ5t7XKj+xUDQd4SI1QERRvwaLOiIS1C0F/A4rRnKGHXeLeyzsjV7yAWsig236urliABVTSP+swB+b3RnK2h0rTJp4QHOvfNhp9JHHX/NfCv1Hy5fgmMDm/ZMGg5pmHQXxt98Ogy8+g83Wp7luqcLM2d6fpfCq+D68GvYCTkPXqA8SDxlxsn/h8YyYKoOLJFd9Q9IwqhBWIS0m7vgbTT9ASIQyTEu8/mx04jJ8i+mI6BXJDX/765jwT4zI4gmzHV3Q/O14XncmksL3sQ51shqMS4jMqisgzYp2E9EaUzaYkG1GEJj+cd/tRt73xU9Uxy0Mu7UMs8RGKNONuzRFT9tOrxn60SM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(316002)(66476007)(66556008)(76116006)(508600001)(4326008)(2616005)(44832011)(86362001)(6512007)(66446008)(5660300002)(6486002)(83380400001)(66946007)(91956017)(71200400001)(64756008)(122000001)(36756003)(54906003)(8676002)(107886003)(38100700002)(8936002)(33656002)(2906002)(186003)(6506007)(38070700005)(110136005)(53546011)(4001150100001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cgWnJK64xH0TWy9AkJFCcXOLCP8sek7F/1JddlYP82gQUF0jfQi2IGkScuBQ?=
 =?us-ascii?Q?xabto89yvy88D9ZfGmEkYf1E/tuw/nvD43XLNuNx/YQaVez73XD4KCJV/yPz?=
 =?us-ascii?Q?9IgUuhyOowhDKczZgPCOPoqsnGTG2/LBdVH4qff0CQpUCn6zOrWqOrrecbOh?=
 =?us-ascii?Q?OpWJDgnC6TPKtTfqKyuckvPoaXFUi4qTuKVQ+VXJUoJninI8lT3EyasR5YKU?=
 =?us-ascii?Q?5szAONSDv3RyJc5Mzj/xwZNQPcwIkEMfgVyr8/ziiqRbGOEGiueBpSBwBgrr?=
 =?us-ascii?Q?ZMhdWXK/5y7aPWILO419a6C66RXqf3Mx2IpZl98w3chNrDfKdjaKa8tAvaO3?=
 =?us-ascii?Q?WeOWZmdgvUUfbd1864Wmi5CnVoDE1xgVxPrcYCVhNOF/v30qVBVA7DIMsG0b?=
 =?us-ascii?Q?xCecfTLUSvbgHyAhM3ZnNNlxGgE2fPfTFFRSCEA6fH4+DgPJ8f7otnoZNxXE?=
 =?us-ascii?Q?HsBGGu5iiv8yRPE24h1Lvw8rXiiiCHZCEXBExl++TDn/5WLIyjdlBd5sZAA+?=
 =?us-ascii?Q?iqOG2ShqCMMJS8kuhBoArD5U7Rm0/8u6Kz4QX6GajTexl34Bo0YzZOZ0jtG1?=
 =?us-ascii?Q?jupOte/gMfNM53+s8acU6agR0asgndKhf7de0A//JwunVknbg2wY2xIla9sq?=
 =?us-ascii?Q?UVHAMcppz38Kv0ZhlrLCGY7vXP5C42agJnTBcnbPTxj1iUUA4eVMHgPST0kR?=
 =?us-ascii?Q?AQ9qVWw3gAB5Hw3SS7eJGzASo8RI6nSDMlSoXW0UunJgHP9hAYUp7Y/HHzfa?=
 =?us-ascii?Q?r7mJdsM+gToPr8XT7mSboTTvgIvDmb4jpREIuIcHWF25vnWs4UCJ8IgTJT/u?=
 =?us-ascii?Q?uhtqhuGgw7xX2YKYGtfLCaCYoTiqti/TjBJ3GXtE3Qx0d397uIb06c8y7PWl?=
 =?us-ascii?Q?arcSidUqrKVizjRbhdZ0h7bzBirUgBPYuY4seUkHQkJew4lUPOK94MCz7PKa?=
 =?us-ascii?Q?dnu43sggDUku6dj59Ha6UYh5JKtq2d6ACR101NfUpUbqmMH0EaMrI2CDwhpI?=
 =?us-ascii?Q?tco04lKH69NyDQfZIUiPRzsIgHHxic0RAgmFQxMgAALZJVV3DDB5YaB14Kj+?=
 =?us-ascii?Q?1S04va/1kHZGsmfk9pYc0iPSHiacKm4wZYrCbxa+4XpDu+rK5omNZ+2X9kGz?=
 =?us-ascii?Q?Pv8utcj6Vyko5j2ggQnwEidcwqJs1JTJQG0MoO6gUmsoEcNs8IZMMS5Pec0D?=
 =?us-ascii?Q?xlo62nS35+Yh9vNJOikyTwwvk3rjuCkfAKvrtSEDqmYLpihUXYSfYuflDik6?=
 =?us-ascii?Q?WN6KyPE178UBoowz8QD9RAeuhaTNhaapJ0rLGJlu2px+hMwAegkOJ8jlJH3l?=
 =?us-ascii?Q?vxnO3UULinM2Dsb+AOnFq+5+abgk9lSI3CH6sSsbVD04QrJevSK090WHAvYG?=
 =?us-ascii?Q?miytPESeFvUnU44ZyZyKaDNY1+JKniBEPlWGu/btv3GPcppHfq4ClFeHtmBM?=
 =?us-ascii?Q?G+7gQPNISgtYrixM89A9jctWzEawW3C95P0eRO1jySJe61KllxQu5dQ3Xltu?=
 =?us-ascii?Q?6W69GsjNHr37y47ZdicyowqaYD1wvU6Ewj12rSVeH8VRTvwWr0mDgdPEj0O5?=
 =?us-ascii?Q?Va/TkWbMpOPnCn7CxPBZob/1Bl607LpDf1nxkKz1uMN72rxFL6ddqsCjjKdQ?=
 =?us-ascii?Q?i8mwWHX00OQ/dVGdIOphrmpNhXsGl2OvCR33Zr7j75KGQgZU75ofSnsRQDgz?=
 =?us-ascii?Q?fjzEZhrZBdEnoowyHF/B8rraX1rBU3zpRbtfVZVi/e5fSH3C?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BBD756BBB259AD418485FD83577B4CB6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e81cd5-7d6b-413e-c459-08d9bff6c54e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 18:14:44.1276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bXla887beIeLxpwcqj0LhDhTz6YIzXfKcqOFgrvR/xT+9PG1G+chlE9fbCJ1ECcfboWjHxr8StU35tcxQcD7vCNoy/70mmWtOFn+UOvOEJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4827
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10199 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112150101
X-Proofpoint-GUID: Ui4k1O4r0BhR4ly9aPHpzXQDYU4cPFJg
X-Proofpoint-ORIG-GUID: Ui4k1O4r0BhR4ly9aPHpzXQDYU4cPFJg
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> On Dec 1, 2021, at 6:46 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Wed, 2021-12-01 at 12:27 +0200, Jarkko Sakkinen wrote:
>> On Tue, Nov 30, 2021 at 05:21:45PM +0000, Eric Snowberg wrote:
>>>=20
>>>=20
>>>> On Nov 26, 2021, at 5:49 PM, Jarkko Sakkinen <jarkko@kernel.org> wrote=
:
>>>>=20
>>>> On Tue, 2021-11-23 at 23:41 -0500, Eric Snowberg wrote:
>>>>> In preparation for returning either the existing
>>>>> restrict_link_by_builtin_and_secondary_trusted or the upcoming
>>>>> restriction that includes the trusted builtin, secondary and
>>>>> machine keys, to improve clarity, rename
>>>>> get_builtin_and_secondary_restriction to get_secondary_restriction.
>>>>>=20
>>>>> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>>>>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
>>>>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>>>>> ---
>>>>> v6: Initial version
>>>>> v7: Unmodified from v7
>>>>> v8: Code unmodified from v7, added Mimi's Reviewed-by
>>>>> ---
>>>>> certs/system_keyring.c | 4 ++--
>>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>=20
>>>>> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
>>>>> index 692365dee2bd..8f1f87579819 100644
>>>>> --- a/certs/system_keyring.c
>>>>> +++ b/certs/system_keyring.c
>>>>> @@ -77,7 +77,7 @@ int restrict_link_by_builtin_and_secondary_trusted(
>>>>>  * Allocate a struct key_restriction for the "builtin and secondary t=
rust"
>>>>>  * keyring. Only for use in system_trusted_keyring_init().
>>>>>  */
>>>>> -static __init struct key_restriction *get_builtin_and_secondary_rest=
riction(void)
>>>>> +static __init struct key_restriction *get_secondary_restriction(void=
)
>>>>> {
>>>>>        struct key_restriction *restriction;
>>>>>=20
>>>>> @@ -117,7 +117,7 @@ static __init int system_trusted_keyring_init(voi=
d)
>>>>>                               KEY_USR_VIEW | KEY_USR_READ | KEY_USR_S=
EARCH |
>>>>>                               KEY_USR_WRITE),
>>>>>                              KEY_ALLOC_NOT_IN_QUOTA,
>>>>> -                             get_builtin_and_secondary_restriction()=
,
>>>>> +                             get_secondary_restriction(),
>>>>>                              NULL);
>>>>>        if (IS_ERR(secondary_trusted_keys))
>>>>>                panic("Can't allocate secondary trusted keyring\n");
>>>>=20
>>>> This is wrong order.
>>>>=20
>>>> You should first do the changes that make the old name
>>>> obsolete and only after that have a patch that does the
>>>> rename. Unfortunately, this patch cannot possibly acked
>>>> with the current order.
>>>=20
>>> I can change the order, but I'm confused how this would work for a git =
bisect.=20
>>> If the rename happens afterwards, now two patches will always need to b=
e=20
>>> reverted instead of the possibility of one.  Is this your expectation?
>=20
> If the keyring name change is independent of any other changes, as
> Jarkko suggested, nothing would break.
>=20
>> I'd drop this patch altogether. Old name is a bit ugly but does it matte=
r
>> all that much?
>=20
> The name "get_builtin_and_secondary_restriction" implies trust based on
> keys in the ".builtin_trusted_keys" and ".secondary_trusted_keys"
> keyrings.  This patch set is extending that to include keys on the new
> ".machine" keyring, by linking it to the secondary keyring.  Is leaving
> the name unchanged really an option?
>=20
>>=20
>> You already 16 patches without this.
>=20
> Agreed, it's a lot.  In the past, I've asked Eric to see if some of
> them could be squashed.

The series grew based on requests added in each round.  How about
I drop IMA support from the next round?  This would eliminate nine patches
from the series (5, 6, 7, 9-14), leaving six patches to introduce and enabl=
e=20
the new machine keyring (3, 4, 8, 15-17).  The first two patches could=20
be taken today.  The only reason the first two are included is to get this =
series=20
through the kernel test robot.

This would allow the machine keyring to be used for module signing.  Afterw=
ards=20
I could introduce the CA restriction behind another Kconfig in a different =
series to=20
add back IMA support. Let me know if this would be a better approach.

