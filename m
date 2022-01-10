Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAD848A399
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jan 2022 00:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238752AbiAJXZl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jan 2022 18:25:41 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:37280 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241114AbiAJXZk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Jan 2022 18:25:40 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AJlXx0026175;
        Mon, 10 Jan 2022 23:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mwV1FPiIdvDGu4dU+sayJ513lYr2ziqHI2JhIYEbMzg=;
 b=iUjnphETFCKQDJE/opnoiaW+Lv0oyj9Bqk1rzFzd8J1Kg3bNmDfheb1y4SRKVwSFmtdB
 YIQnE9KdlmcIYJE5p2o10t0fzASYcWR9Pxbg522H1sGMQVVVi8KeolYUXqx0IjftmaoJ
 fBRqsSb6445JK5XohQh3iRipmVY8v5uLba2S+mm6xDOKv8a9MCVOYeQgXbTiiuSmlQSM
 rCGDbJp3/gew41HKLl9xyVRxCqJKsycuNwu8U69pxvkbmSunvPAQLSKs3LFy9d6C/kzk
 dtKQ3vre8VOxzpX8f7yIzTiX2bSTecwNtvLi+VFbVCs+H1R/bHf4E6/H42kYPk/rodNN FQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjtg9x0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 23:25:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20ANFoiJ133229;
        Mon, 10 Jan 2022 23:25:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by userp3020.oracle.com with ESMTP id 3df42kqwmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 23:25:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYGgG/VitMwbMMhhOuRXmaF0TQ68BfKbfAF+Mw9GBSuK9QqHkBePVdvXShvzOcyb4vN1oBFv3U2Rjr9/2dxKJDu3KtUXfJDR5N57irwM91tAFLGyEAHer/iPg0zRLR7b/x8KEcEG6CC/rxtAXtN1lI04t5W0i70QBEC2YKnUsk1AVCe/obJPnCryZzfnnp0G4ITsUV6mqNo9DYw5zWK3jF3jMA3783kXgM6D3en9dsCi0Hzee5Wz8nOQ8DgnV3AtK4eaGYIbBhE7wTjz2yNTWOLeGrcIJJXcqwt13svsIDJZZNCqqLw00Ea7Z4vVoatgnEN0Q3YdaIEBnO2KvdABxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwV1FPiIdvDGu4dU+sayJ513lYr2ziqHI2JhIYEbMzg=;
 b=bVwRpZRNAbir9FjYXL/6/FefzETol14NSyIKIMEk7ECGdy99o8438nOD3J20fglhnqZ39MhyfJ85EG4zySkpAKPtlQOWyr2jAt48NmhtiJAC4tLLBATtElwR2ttWyZ264W73qbJHBuZFhBcwPos6wgyZMi9gnK4Sl7viae3lPh75K7+6vjVUKNUT0IHaqeU13J20AJnlI/S+VNSlcC5RkxtMc/XCuga/kkg6BwAThar519Jq5EA9ElqyOzyQ3TEYQMJQNFz1FZLwKs6fppsxKSRe9c/MZGw5sSIc1TX+x9q0+0DBjg2v9cpaMqghNS2FKrbUZ9Obol6eluZ2KiQYwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwV1FPiIdvDGu4dU+sayJ513lYr2ziqHI2JhIYEbMzg=;
 b=hJaF0WenLkgoinSociFTzwUjoqHJDTvFl2QmqQizWNMXezudu4fshUKgc5+P4y1X2P8k4091FHybNndG7heI/e0N1cZqc21WY4tTHB4OHTzSRUXAZlJ0tH0iz0Ac1czSU176ZYbevyStmZ1lPb5ErN+KmUSCIf3F4P6C767CgBQ=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4214.namprd10.prod.outlook.com (2603:10b6:610:a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 23:25:03 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a%4]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 23:25:03 +0000
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
Subject: Re: [PATCH v9 2/8] integrity: Introduce a Linux keyring called
 machine
Thread-Topic: [PATCH v9 2/8] integrity: Introduce a Linux keyring called
 machine
Thread-Index: AQHYAo8H0Sj261FHG0itWWPoxYX3jKxbQpAAgAGq5wA=
Date:   Mon, 10 Jan 2022 23:25:03 +0000
Message-ID: <100B070F-7EB4-4BF7-B2B9-E5AE78D3066A@oracle.com>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
 <20220105235012.2497118-3-eric.snowberg@oracle.com>
 <883da244c04fcb07add9984859a09d7b1827880a.camel@linux.ibm.com>
In-Reply-To: <883da244c04fcb07add9984859a09d7b1827880a.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a74a27ea-58d8-425d-f44f-08d9d4906de2
x-ms-traffictypediagnostic: CH2PR10MB4214:EE_
x-microsoft-antispam-prvs: <CH2PR10MB4214E758F04FE099931EF86F87509@CH2PR10MB4214.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /73snNmFdbe5vyHHVGhF0dYIWhN/LYKsTmUx4y6Vfx6nZLEi8Auwg+tY4oYXdQ96w2Eoqm4ngLLaryL4GTZH21DY1B5agcNZt16+Mg4XTrfS9rJ6aE50akVLOrAwom519IKXvw8PZ9jrPmcWJsaEaDQwVJ3p1ZVvntaxk2TLu5RnrvuxCTwP0ZNSqMmp7qzQphx6ZA2S0TzBpW0JWgiKwR4WupYd8mgX2jhRyJsllmMio3uUOB5wyeFBFQ/PH+VcxDUnG3rT+B/FRFC0Zwia8rX5A5r+NbQlSNg4xVZDADJuN3BzoA1l1XqPyt8fIuJEXFCvZt/Q75cZWrhWEupJeM7SbKbwk56UMoQ8/2j3dQlG4kOuDc1SNCinX3MaR8H9YRYdiy1REUMHGf7GYOx8Domm7amo+IAuvCUgSLd+qA2U2vYQXtz4oTe+59EgdMkPH6PY1vohymYqqJczEHn362qRBPLwtOKe679GzHZQbAT9aqS53+Az3KnlojbuDIvhi1agWg5NwBheebDqlRfvFtCGnYXNerSfLNYtlxrYSZv6tiQCd0SX66hjyXrNA1ZXEN/mR7G1VyWuUEG38rq72t0+NbQgmYyT190OaZeXTR6y4kJOhtfv+tMzmLHb77CkbZDv0zHg+GEH1zcZTXY0gqjs2C4Z9BBmasYfVx7UXYaNkdoCA3MnNPm4NfnocfiYF8dY9djObMHcvj3pr1JVcxpWwIieD1RxO/JAdIajRPI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(71200400001)(44832011)(76116006)(36756003)(6486002)(2616005)(53546011)(6506007)(8936002)(186003)(83380400001)(4326008)(6512007)(316002)(26005)(38100700002)(2906002)(33656002)(54906003)(107886003)(122000001)(66556008)(66476007)(5660300002)(38070700005)(8676002)(66446008)(64756008)(7416002)(508600001)(86362001)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+1EOIP3D/vOPAkGExsTFwx5c/2bSy4ia0YrezFQLJ1OE0/h6A9EwwaJmF+dc?=
 =?us-ascii?Q?WUvDKNm+Un8ywBZBAxu0gqlbDBoem3XUBwtK1SKsvHosGr9yB9Fn5FY+aF1f?=
 =?us-ascii?Q?g4M4smlauS5E3XxjsHnpqidtOFTlg9RIEv7xkHZmc9goxJewoFaMP+dvfJgR?=
 =?us-ascii?Q?5IpPhVF5mbAKIUXFHSv/JQmHJV70BBNecp3ZdQI2H1qA2aYipkEDzi+MXdJh?=
 =?us-ascii?Q?kPSiG8eeMbmeFRAyxl9OqmkMW1H0JaYgNwhP9UvaIqQGXQJsC4d9y/sJAJ5V?=
 =?us-ascii?Q?8PHcEjecy91WWSB3hOcf8TV0x05eDtwT8nZhjIej8Kyr8W9AW0HmK57rzV6t?=
 =?us-ascii?Q?eHHpKm4eaAM5VnyVgSrtrQ8lqEDxCJoUtXZ851Iw5b6mcVz/BBA4xGRfuiQ+?=
 =?us-ascii?Q?vEQf7B7KIYE+N/OSt7R87HbF1859PfVFROAo1Rp2LNLNs9ZWOyQgki6BL5RD?=
 =?us-ascii?Q?4FahyVhf2apeaQ28qDxP8IKchgVjJiXNr2udwJjN0zJtRj2SD/03yY9HfJ15?=
 =?us-ascii?Q?h77JX5R59Lerdc+kEq/FjKDhlaNfRlIBEkAcjmmc4z/C3YTnQNuxE36mbQJh?=
 =?us-ascii?Q?xUVo/3dOv7lIbRDAZ1Fx4w34UOpUTCPXsBRaS022VXSRgASqixeOFXS7JiDa?=
 =?us-ascii?Q?qp1XXq2scz+Ha3h62W7awzY2LjXEpzJzcNp9OZ3151o/YibOzlu9ccQZsi6Q?=
 =?us-ascii?Q?MlzKS/aCP7PexfVUH8p0MRSPxsH/66agRc9T68nvAZmafZu0NFLj8lrgBOXz?=
 =?us-ascii?Q?vtlgtyx3I3LmfdV2FEFMwhVknArvrL4bRLwXwOD8CoGsPiaYF3J/nAcMIE7g?=
 =?us-ascii?Q?RcDXP12fC/WYqvljytHcKDIszPWOmt9NayanKTG6EDjXz0UZrQhfjMLuCLqD?=
 =?us-ascii?Q?mJ32fXDX0QYvyKDiJlsyWE+7gytW5CMPgfaDSZrytnPK4BEsMb6ViuC1Qb92?=
 =?us-ascii?Q?4b2xDcWdDR7XWoFaeXyKQsF3AEB/mxo9MO3gXPwhUNFj2fgYpxmn/i7o7PTI?=
 =?us-ascii?Q?IAZ0mRlspZL0GRWlrw8ZTY3xbrzTPEyTM5PRFOp8VQdiOBrCWoX2Y/ud0hgP?=
 =?us-ascii?Q?OeJKZU4E5c9t00M/ryHFc/H0iVJq6AGmkooBlzOfDBeVVMtKM6TMkAFcg0OU?=
 =?us-ascii?Q?uiEKcJg85lJ8GHVOx92EjWgHZLdlEM3srFJKPwMk95s7vJlz4y+YZhudAsNp?=
 =?us-ascii?Q?z+KXWMSaFye9r4etPf13WTLx0YxqPoVBrSCYV+OnzRauGxvD7sx7E+zB4dJi?=
 =?us-ascii?Q?tzxelKftqU22qC54KWfofA2RMeuY3rQ5s+ac+6H+6k4aeRn4dI7kEQ1+o0Uj?=
 =?us-ascii?Q?byFeuiQ7HS89Q4SX9Cn/LAXS5yCcg8/7Wmby+sN6dgEVzaS7JJMG1u+L3oix?=
 =?us-ascii?Q?iBmOAKHYC9sBhHxd2N6rZAAoJ9qYN8BOeTXCnxPoXcZSeLuUn/1ec41QF5Oo?=
 =?us-ascii?Q?5tlsNQmZWYGMsbjgLQRRFkLuad8Yhxu624CUBzTp7W7bRsH4ivd/UYaOcES+?=
 =?us-ascii?Q?7us/w6D9ZjieQ+Q87axvGJXEbOuFrsusviqZRHQcMoJf8u358Vy/l1f2+waX?=
 =?us-ascii?Q?PIlh9TbXIrr4erdAYsY5mZjyyosQ5f32UWiL4NiGbF+o+2FEjtSQzvClLsvi?=
 =?us-ascii?Q?5UkRW0RO7XEZzDeWU+SMCP86f2LfPCI1JFarWry2XYAuh8q1WYKscrVUHnQY?=
 =?us-ascii?Q?wFkg9sCPRccl59xWfvTnxg/qSa8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <51AB519C616D9E42926B09654AC232B6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a74a27ea-58d8-425d-f44f-08d9d4906de2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 23:25:03.2511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v4pgFhjs8D25oFTNQBCLTHXoJYhjLQzVuOxjcJOf2vNT7T8DhLCt/co1YaIa+r8ECQ1mYDT3BBgWjatW+8unNLibBLAdfdysaNZ6HPN/xFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4214
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100149
X-Proofpoint-GUID: QHdqxM6R8tzvvGIojuajCNlGk-nvB2nG
X-Proofpoint-ORIG-GUID: QHdqxM6R8tzvvGIojuajCNlGk-nvB2nG
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> On Jan 9, 2022, at 2:57 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Wed, 2022-01-05 at 18:50 -0500, Eric Snowberg wrote:
>> Many UEFI Linux distributions boot using shim.  The UEFI shim provides
>> what is called Machine Owner Keys (MOK). Shim uses both the UEFI Secure
>> Boot DB and MOK keys to validate the next step in the boot chain.  The
>> MOK facility can be used to import user generated keys.  These keys can
>> be used to sign an end-users development kernel build.  When Linux
>> boots, both UEFI Secure Boot DB and MOK keys get loaded in the Linux
>> .platform keyring.
>>=20
>> Define a new Linux keyring called machine.  This keyring shall contain j=
ust
>> MOK CA keys and not the remaining keys in the platform keyring. This new
>> machine keyring will be used in follow on patches.  Unlike keys in the
>> platform keyring, keys contained in the machine keyring will be trusted
>> within the kernel if the end-user has chosen to do so.
>=20
> True, from an IMA perspective only the CA keys should be loaded onto
> the .machine keyring, but this version (v9) of the patch set does not
> enforce that.  The patch set and this paragraph are out of sync.

I missed that when I dropped IMA support.  I will strike that sentence
in the next round.  Or if no code changes are identified, feel free to
remove that sentence. =20

> Jarkko, my concern is that once this version of the patch set is
> upstreamed, would limiting which keys may be loaded onto the .machine
> keyring be considered a regression?


Currently certificates built into the kernel do not have a CA restriction o=
n them. =20
IMA will trust anything in this keyring even if the CA bit is not set.  Whi=
le it would=20
be advisable for a kernel to be built with a CA, nothing currently enforces=
 it.=20

My thinking for the dropped CA restriction patches was to introduce a new K=
config. =20
This Kconfig would do the CA enforcement on the machine keyring.  However i=
f the=20
Kconfig option was not set for enforcement, it would work as it does in thi=
s series,=20
plus it would allow IMA to work with non-CA keys.  This would be done by re=
moving=20
the restriction placed in this patch. Let me know your thoughts on whether =
this would=20
be an appropriate solution.  I believe this would get around what you are i=
dentifying as=20
a possible regression.

