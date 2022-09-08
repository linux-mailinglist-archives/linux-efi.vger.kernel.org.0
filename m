Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9055B10D9
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 02:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiIHAQn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 20:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiIHAQm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 20:16:42 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE648BBA44;
        Wed,  7 Sep 2022 17:16:41 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288029Vn024315;
        Thu, 8 Sep 2022 00:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=WrCSQgc9XUun6VUVN7qE7yUUugA79k0So1z6B2pghuU=;
 b=afeRRSJKCpPU1YyfkN+ooRpIn+ySzRT057HzxZoLSNsoavwwUarsyTz3ppnIf6Nmyp5H
 41N0zDYO3eVT+XhdI51F3sPuuFW4EEXyWh8L2j1V0kPnLmo0V+IZ584Im5a5UN0HXdKy
 NTDb4PXf0V14ZQr/rpkHZ+4dsmnIYNNYgqjjQaobmjuCvskv2qDDaLpnoYjjP5EoPwhz
 N5OBMXT86o8awc6GCdqlN1D5ag+kLcbKgZSBEpPh+JCn8bUnhArYAnF1mSmKpeXS9PF6
 8Neio45e28Ui8CSTVorWtoNVmDnriPA69Vq7P7K/pNKJi+zKY8FWtHIQZoBzdd/njWRl yg== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3jf54m88aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 00:15:54 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id ACDEF807921;
        Thu,  8 Sep 2022 00:15:52 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 7 Sep 2022 12:15:52 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 7 Sep 2022 12:15:52 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 7 Sep 2022 12:15:51 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKE9Ky2WtUBomhxQ7pecRYr52QE6Sq7HQ0iAg2uyXVwdM3rwnfxzHGg3+A7yiRsgK0Zu5/PDTDGjd0XJks6NqfXJC5XpCfkX463TIvgIvuXqARp+mF6qf1lT9NOoILgysWwnZ7aJnfhbfph0goVkRGsoB95BZMAPFvHIkQTP2bpL5JDok5LmoHVg8xxA6apT6h0KnS0VFG7D7+Qvq7k8ByV1vahq8zye1j7MDydfB8SSoDpZ07eLZYv29T3CKmaxC/GzjtvW9uz6J5Q1p7QupxdNmioYg+gWhUq4QGK8DgS7J6vKLBJuFrvf85TREArrKQafYZoDw7U0YyFxmIDukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrCSQgc9XUun6VUVN7qE7yUUugA79k0So1z6B2pghuU=;
 b=LnCdF57vEwXYkKQTQjewGKdUVSpulSsX0z4TL+vfj8qgZ6oOFnDGBJvy0ki5XY1aOVIBSX73CfSSZsKamipP4RH+vAHkCoovAzl7NqzcgOkXj7ymMcp52Jkzb746PDZogIMYC1giMZSXwJgerbnY1klYYBCanyjb6Wkyx0Ji1lg5AI7EwcphDxBEOMys+03XPiFyutxygRMFPchPhJnLVLYJmEKWVFhkrf6S5Z+tELmPs+6fGxn05WzEBz/V3N6ngEu1X3OjgfgJgPE6idpoODfmsP0r7U57Q3OcdhNrZ7e5vybQYHZ/6oyg3GHrf53/e2ExMJJGUoRQN7iTXKT+Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB1849.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b0::22)
 by MW5PR84MB1500.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 8 Sep
 2022 00:15:50 +0000
Received: from MW4PR84MB1849.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::3115:a8f7:34d0:6ac1]) by MW4PR84MB1849.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::3115:a8f7:34d0:6ac1%8]) with mapi id 15.20.5566.021; Thu, 8 Sep 2022
 00:15:49 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Jia He <justin.he@arm.com>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "nd@arm.com" <nd@arm.com>
Subject: RE: [PATCH v5 3/8] EDAC:ghes: Move ghes_edac.force_load to ghes
 module parameter
Thread-Topic: [PATCH v5 3/8] EDAC:ghes: Move ghes_edac.force_load to ghes
 module parameter
Thread-Index: AQHYwTvGbABQAB55v0iGhuvI/sLGGa3UrWrg
Date:   Thu, 8 Sep 2022 00:15:49 +0000
Message-ID: <MW4PR84MB1849ECCAA0F67451B369FBF882409@MW4PR84MB1849.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220905152439.77770-1-justin.he@arm.com>
 <20220905152439.77770-4-justin.he@arm.com>
In-Reply-To: <20220905152439.77770-4-justin.he@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f1ad294-8dbf-4128-9895-08da912f48d9
x-ms-traffictypediagnostic: MW5PR84MB1500:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B2eDZi59xvwFUFr1sJhN1ILiGcmTdwTK2FBdH4jeBhKUHm4INGscQxreAc+loAYyIWH9AZ60uoHn+CrfSoj+5/7K+BOoeYKk9FRfdpfVUGEpQcGXntGsv7hxo5o1LEXviA2fdYJWHtsGd++fejOPRdtZL+ju1BXo+ZLFmugt2dCz23MMseh52L5Tveo6TNOVu+/ht2onLD9ezG+++U7quMVd/XTzIywX3yOcwfMJkGLPfdhKUICQlrTFB2f70ByAeR0iE/Xa7R42L6VTo93OifoVQ7HM9Z7AiIAcGpxiErO2li1/epelHRme5yUKgUic5UiFEwLWLYjbrDSsNRk614AqoKVcsROOdEFg3+r1lAFP1q3ruaTidFmUmYdLAQQDsUxOyZP4cM8M5pxve1MRCkB/81BZ+QeP1jacPsYr32PFgPfBTa57ndbqQySsIBmSmt8b/31paUz2RV0x+JrBnplYfvKPFjPeBfbAqNXJwqci64ieNwRwITqsby4qieME1E5U7YuJlZObC/oPS8lstNmMa9j4JqQl/Fr0pr9oiSyq6hRsv6IIDkNsr96V/9SMEk8rK0iDdbZ+IJCPXrQuWzZ+ChMYH/ID6m11rCszf9Rt5HBXOXqW7mu5syxFo6WX38xkVsgGJkFrDufyE2KA6Ay5NAEdm7GnuS4aXKxjOiig544rbJOesnPNC0WaTRpRASwFCyfsoNbuySHJnHjCw9x5SvJqvhrDfpl8svy2V9UZRCnWENhtdMzzARrAmGUEiD4+Kz1sx9kAuCWbeYKuz0b7DRlvIbLwiKBR0zNvl/4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB1849.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(376002)(366004)(39860400002)(8936002)(76116006)(83380400001)(4326008)(9686003)(66556008)(8676002)(316002)(478600001)(54906003)(71200400001)(110136005)(66476007)(55016003)(64756008)(5660300002)(52536014)(82960400001)(2906002)(7416002)(921005)(66446008)(38070700005)(66946007)(4744005)(122000001)(53546011)(86362001)(33656002)(38100700002)(7696005)(186003)(26005)(6506007)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EpkVpTZp/TTZsOMKIx1oPcMk9U2Ax2tl2zs/TT17+t1ggoSGSKUatj1rn11D?=
 =?us-ascii?Q?ksYjxS2inqgpzSNWwWq0shonv0/AxaH3Zgesoq2z/Y+H6W8vOZfZBG7rhEF6?=
 =?us-ascii?Q?0FCIDp1KhHc9LbL5E/FnVv518eppSq6/MfnerrhXFlOOOFfqAnvOhX7c2HCn?=
 =?us-ascii?Q?egbgIXwrvYzOcycwb+WJwZg7X1MiE1yLUFT7kowDSp14lpUwSslq7cY6ARmk?=
 =?us-ascii?Q?3J+SfQ6zjCMPMevx/KhGdSccPL6q746XonMsfKB7uVgHdQ9ClN58t6Mt4Imi?=
 =?us-ascii?Q?fP+FCbg6+XbioIuz2D+pqLILhFLbACvnaX0aeq7caA70UAH1W/3oM1txdc3a?=
 =?us-ascii?Q?//w8aQoAtAyiOgYryZ7to5lvvxjbTb7glfTgBU/ArW5XGVwQUcsC/IZ4sp17?=
 =?us-ascii?Q?ySOwgLv0tlMii1jhI7jhvisJjSuo8/kiKdR/mLHiFM4bZ7rHSue8o0Mi4bTK?=
 =?us-ascii?Q?abYHjscmtUgyYHQlrwrrsJHtu7GtcDpK0hqDSlYhlhosXdgKin8UChvqOYMO?=
 =?us-ascii?Q?Ecl0S3ApniI4FvMspeOv6tSI8MmgmsvTtAYOZnmpwZXoiPPFKNLfh9myaVA1?=
 =?us-ascii?Q?ih9iWB4Kp/bTeH5qs5Ko6yrAJPUcOTyN9WnyihbSx+vxrG+JDGLegycvbc60?=
 =?us-ascii?Q?LJ3fqFHUmm+yKL7Ys5Wcf8xkhnejd+q+pAFbIB/MOUavB4V3Y4nEgBtXSoDu?=
 =?us-ascii?Q?xsldB9Wxhd9dMNX+oT6a9Eo7SwdTPVLrJVDU7y+KtpM3JGk/WSPNXRy7aDkQ?=
 =?us-ascii?Q?fEzZXNgMrIIfLNm/jooLQnm1+6MUd87t2CZybkZjTXmmYUMFeQHACwFT70e/?=
 =?us-ascii?Q?xHLDH7Ym76jUmVDR696ULr0qTMeDxZZC33b9neVNahxW6BTUFGFDMUZJMzZo?=
 =?us-ascii?Q?3A4wetEmE0IaYetJ+H0HzPUkTEijz02HmOZ11s+ntYoIYoFt1u5BPWrWRehN?=
 =?us-ascii?Q?GkfzQ7VL4uqvVSolerslUbu6Fcn+LOPmCC+3wnRMW0YORWFhtLzK5ekDILIO?=
 =?us-ascii?Q?doP34hPrbCM3KFOOMXtb66ZKUUmb0TaMU+8GMFlEnJSBClWR4GwDKgf1/gT2?=
 =?us-ascii?Q?27c0wUdkZpnnPuYq0LtNwH5S59n0APD4r+0b7+bACu1elHODcaPpNoHmzF0d?=
 =?us-ascii?Q?Idu7D6J+mzjAFtJYmfSPXcI8TBpvLqfix4z1YjNUtxP5za+dr4E55KKNoTAy?=
 =?us-ascii?Q?o+JbKEYncRYzFapEaBcOFYbNHyPpalS/u902yHIE1xq/n20p3SWC8fg59PD8?=
 =?us-ascii?Q?LWSbAvtAbPf0PbzoTwGt7cUbhRCWtDC+IJgx5mzyR0F4rao+Hwn/5YV9FlNq?=
 =?us-ascii?Q?yLpmarZFYzCClAGsQwAgdsUPT2ky2OfBLlathUeX6h+OZMCXUynC9mLMvdai?=
 =?us-ascii?Q?bQMWkOvOfNUXboqFIloCOeSkW6oOeAAxdkGaEWHWmlK0cFE9Vqe70umhhybA?=
 =?us-ascii?Q?U/SJlfjzt1IncvE8ObbNkvDl/z62sX5v5gHNlnvOkckwhliWiC7ETlCZXbCo?=
 =?us-ascii?Q?kHp/jpThSIAtPkl2/9TIonJFirw4W683riHTWgr2VRgzjDwtCiULNY4DEVCa?=
 =?us-ascii?Q?Qa3r6dq/ercQwsIsWThW3Q0fnvp/y3GksmM/rUhR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB1849.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1ad294-8dbf-4128-9895-08da912f48d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 00:15:49.7901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J6VwSNyC3QA2QRWreAGgfnAtinBH82Gsy7AMHA0OdwTGj4DwlQt/2i9UquILCZ/mGpwUm5Mgh2ApM0Lc9M2ssA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1500
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: zsu6p8GAXtFn_dm-hx3F2AbiGMaWzRS4
X-Proofpoint-ORIG-GUID: zsu6p8GAXtFn_dm-hx3F2AbiGMaWzRS4
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_10,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209070089
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Monday, September 5, 2022 9:25 AM, Jia He wrote:
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 8cb65f757d06..b0a6445c6da2 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -109,6 +109,14 @@ static inline bool is_hest_type_generic_v2(struct
> ghes *ghes)
>  bool ghes_disable;
>  module_param_named(disable, ghes_disable, bool, 0);
>=20
> +/*
> + * "ghes.edac_force_enable" forcibly enables ghes_edac and skips the
> platform
> + * check.
> + */
> +bool ghes_edac_force_enable;
> +EXPORT_SYMBOL(ghes_edac_force_enable);
> +module_param_named(edac_force_enable, ghes_edac_force_enable,
> bool, 0);

Thanks for the update.  It looks good to me.
Reviewed-by: Toshi Kani <toshi.kani@hpe.com>

Toshi

