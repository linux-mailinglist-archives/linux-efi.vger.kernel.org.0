Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F7E5A3227
	for <lists+linux-efi@lfdr.de>; Sat, 27 Aug 2022 00:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241517AbiHZWnZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Aug 2022 18:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiHZWnX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 26 Aug 2022 18:43:23 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507FD8E47D;
        Fri, 26 Aug 2022 15:43:21 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QK86pb009372;
        Fri, 26 Aug 2022 22:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=j7kU0ZPnxkOj3cwZnn5N4hrHgR+Bh2n1GCTcH5f1oMw=;
 b=Jw+q4u4PMbASk8y9fyW0ZupfJi7z7WivLirL6BBNRRBbNlFe1dh23LoblGWMLJyPDJsp
 bT75vzPeCrrII3yjS1XBJwsutE2cPxatpZYhvpoiW318660PjTA0+evCPvSvx+1F5QVG
 ahgTL2GEwyouxouKwrQeURZ+JaUIoIVIYpguCAmx2DKPCJ6OVITNNq7aaIuasOnGqd9v
 P7azHO5fCE2yZorao57FDNaQ8ebB4xapJoCvpeXR6dNnGwopNMA3vxvMkNF/97qtzImA
 lt1Lg5dig5m4RcejLD093ibsynvm2VcyLLWu+v498Wye/pJpfYa3y6tGAShK2x4w0BFW Gw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j74xgrvhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 22:42:41 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 2C8B18000B9;
        Fri, 26 Aug 2022 22:42:36 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 26 Aug 2022 10:42:21 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 26 Aug 2022 10:42:21 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 26 Aug 2022 10:42:21 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBwpide6NpF3uiJoHypObNbz1Wxc1cE23FzezNz9L8iogWIcwewjXOm+Uy5hAVHIkp9p1w8/5eTJeK8tMqTixtYhdWF3c70M77nLojr95mXJpeKvizH/CRJdjZmXEP4UbjTGU3yWoYpedd/eE6JLRWQxBgYPLxINQciEiLhIFqGMB76PTD518X5m+dAi9bU9D/eSPUWOptwe0KBbzNsGTSIe83/Xqt70IhhdxXw5MTisJXPQAm9iwHtVc4un5x0iv6kFYvIjYAXEiydSboritnb9dqrJIU7hVSQRXrhLT2pdpRdDpofrqjDYJtXeANOy4BEb4xMaM0Jkx/hk/pmZgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7kU0ZPnxkOj3cwZnn5N4hrHgR+Bh2n1GCTcH5f1oMw=;
 b=MyhKtyybZLMEyjn3LtNSODMugkICUFt7Msj+zLnE4uno2yoBalH1U/hoNy1Hop/1NGJrLA/p3T1BBFiCFptIG17+EkZd8pKLly2cyV9p4BaoIc3YgF+YLuqewzR1xrK6/h9XLusloHatvhFuHwsC+wqLPs6irqbt3tpzZoG5PaQr1rn/usv0fYrEl4qJpcotdVEmkKB2aOHcDrum0pvJ84EKIOEqmVvdaSwi+jT9EAa8Nii/T7BMQ7L0toqTXwYfT5qL4Ilh4pViNLUNkB3Qq6HH594/8gu3hyP/PMD4ZiuKONqM9Cm2YpFGJ4qCNv3FL4hedRL3VD2GX7g4fUOXbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by SJ0PR84MB1650.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:431::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Fri, 26 Aug
 2022 22:42:13 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4%5]) with mapi id 15.20.5525.011; Fri, 26 Aug 2022
 22:42:13 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Jia He <justin.he@arm.com>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "nd@arm.com" <nd@arm.com>, "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Neeraj Upadhyay" <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>
Subject: RE: [RESEND PATCH v3 3/9] EDAC/ghes: Make ghes_edac a proper module
 to remove the dependency on ghes
Thread-Topic: [RESEND PATCH v3 3/9] EDAC/ghes: Make ghes_edac a proper module
 to remove the dependency on ghes
Thread-Index: AQHYtj4QY1WIruQcBEWj6kcOv43zB63BtmGw
Date:   Fri, 26 Aug 2022 22:42:13 +0000
Message-ID: <MW5PR84MB1842F7107770654C46CB0311AB759@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220822154048.188253-1-justin.he@arm.com>
 <20220822154048.188253-4-justin.he@arm.com>
In-Reply-To: <20220822154048.188253-4-justin.he@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd2cb38b-9af6-4fd0-4d8a-08da87b43878
x-ms-traffictypediagnostic: SJ0PR84MB1650:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6sNEJWosog9dz2pMlIgLpNmg8uhPOk/+eJVbKLiNzmkIOMzMNsN7kwzpJky//mVmX5WR16YDnjafzkFXdG0Uzu00jD2uO1uD987SgQ2g2z1GaGUlfC5KeXuudAljZJQn4ksxNfz5y7mXOGHJBOBOjtjLK7XV8f9Mz39R3D4Hafg2/E2m1FP+vfxlnK8b3TxmFs8yMZJE3shbxNfyiktwEXnhmbeYvsJ/eIRul+bOHj67EJP5E8f54Sd0zZOShLEzWwlUiOrEwuaLFALPgqYUgEm02S5rVLIc7t3yFlRBpk8F2leUpa145sOMZPr8jAOVr1/WNzImlU+UC6sMIvC8VcY33iXW4wCDgK8nuE34zAYdMMTf0tp3Y+91ctfTWsVzawG2s+H1/+w1s3g6svI/URwyevJ6BhiSn5jq127EkoWBsf5i/XFLXx5PyDQxNpyAf5QIlyBSZMLkf054X96Dy6QIWkYPDzlcFysFL3WqWDE99R6GFzoTtOj4lFq4qfY4hc7wqrzm6vmqPXiXkrEn+bCUWFJYhrDHLWqhQ1pSez4jAQMKyURykqgFe/R6/ZjyDSIepTf+SmuBGgZp5Ft5O14JzdDY7r8EAQ0aa3/yv2v+0YtFqhukq5yjSrgIw6oQb9L69yaoGeVcnxRMqo/yq49tlJ5d2MkFeUC7stc0meybcNK81AWPv7RIcHj9QZy/QdlhAPQEGiQNlj7tkGadKLMSDTPsMmtOH6fO8FkDuumuhsfRB2UD/nciYI7eC68g3EvJYs4UIrCuYgQutdZOc2sgLRtQdWt1MLAWyRkwbbQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(136003)(396003)(346002)(64756008)(26005)(66476007)(38100700002)(7696005)(6506007)(41300700001)(122000001)(53546011)(66446008)(9686003)(66556008)(55016003)(8936002)(8676002)(5660300002)(86362001)(7406005)(33656002)(66946007)(7416002)(52536014)(2906002)(4326008)(76116006)(110136005)(478600001)(38070700005)(186003)(83380400001)(921005)(54906003)(316002)(71200400001)(82960400001)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YW5FJ6QOI/QWJxIdyR0VOZTpxmxg8R3MfybxODQS/4xHSZaCP2CTmgDwSOlu?=
 =?us-ascii?Q?ANhxGYWdE3m0rBy54aRRClnx4PRgeo6NfYK5X5YfgMLG2SDTa/KJFlySV+3G?=
 =?us-ascii?Q?eveRwlxRkRL3EZfKOiu/0v6vKJ7QuUvSd+O8029yTibjsd1gBwfQPEydz0iM?=
 =?us-ascii?Q?DgyrzH4P1OW1fSqV+cO6j+uvrKubWJ/nwR+FHyPDq1iq3HXbupIR6triGv7G?=
 =?us-ascii?Q?mhV1DtI9DK36LYAPqFfwPFrhNfEyEJqY9pBB1e9khgkjMdHFjezE5awQdzWx?=
 =?us-ascii?Q?bbK0stANNCwGK0ndXAMCuJwkGCHD0D4RyqZkyAekV4ebpmCryw/KBWznlpZ0?=
 =?us-ascii?Q?GKL4Jl0bZ5K7CIxcgOtGpgm9K8ZsfR//wBtRj5/IAKqkyk7WcVtjwKepArU8?=
 =?us-ascii?Q?Ie+uIqy9O8NFr3vMfwCYwB7HVJ8oWgBXCKC6260hDBd23hFZ0SJcSrXv98Jf?=
 =?us-ascii?Q?ZBXmoJLgehCk1k+5KfaeJfvAz2NgrBG89nJxe4h3lORgBQyuXTcgYBq48iIe?=
 =?us-ascii?Q?67g4d4FGBKF5mKcCeFtEifX6Cr+fL/m2smK7A9M3XoTaXXkAwbEzHWq1gHVu?=
 =?us-ascii?Q?v201fU5zIjf0LhX2gmHWRPm1TVwduNgjl6k8/TsDQBATyESZuAsHTw/feA/+?=
 =?us-ascii?Q?XxqZA4Fcn+ysXH+kZDlzWLqhUURi32QH+K2vOqX0ER1UyVlP7caBCA2xK2RT?=
 =?us-ascii?Q?XdE+Ro+egpznfBE4a0DjqIqe266JRS96LtCiVTELg/7xbTLDg8cZJ2lH9+Ie?=
 =?us-ascii?Q?UZIB3QK5nUli54daAfSdxKqEM0PlDoFoP3HfYHpB6AVnifJ9KhA9yIWOLB8k?=
 =?us-ascii?Q?vPMtK7LwG8dTkwtj4GIFmM++FDTfq6hWykfVCRdmE+Tg9jxd1FULPS0F+VtI?=
 =?us-ascii?Q?6f/XtzJBRbKuCDLXlMG7BkSYFtrjVspdI13nLz+xCO7G7xGKFM7nJ6XL/XDk?=
 =?us-ascii?Q?H3w2KzGoWZry/v6PcmND5bHi8RuvwozEP3xMvZDcMggbY5gkjqv8HjLF046I?=
 =?us-ascii?Q?q30ZzNZobTYHPCrfYhw1uAtsdiXmJCO482uGMUrtgwjVwLTBvWRbEgj8X1y0?=
 =?us-ascii?Q?rQkJ61DPWhNb8bnkbuEoEsloLokLt0h4fVDkgD8UNbozBsJYr2ixZJ48dPwq?=
 =?us-ascii?Q?LQy10WNIVxPXTQbHx9sBfGRf3kNEoUabF4Luq9+r73sUkbnRgFBXnReVwuxo?=
 =?us-ascii?Q?HHHYXQVMVoW9ZqY8SQZBq/PMzV0ZJL+BA/2heM6bbonYgiWAe4rDgSJMBRZV?=
 =?us-ascii?Q?+EXwv3lZnluy66IIN8Sde5zWZmXqoVNrtYbXFdSo2JDIvyXtZLMFJVnb9F7V?=
 =?us-ascii?Q?d7/3yu44x93bdvJbAy6x2BZdzdIKCnV7161SHLeB/z0bZ0Q1lwOO14eODkr+?=
 =?us-ascii?Q?NAPfHjzgiTL0RR8vceZf9ZtHFZ6a2LK/HZnx6qd+cjXiy6/DpMDtO2cJEEWh?=
 =?us-ascii?Q?KWGHTSKxLjTM6UxrxDUevD23asiyt1kLY6zMq38x7YcsZHv5pbxPkRHkNof4?=
 =?us-ascii?Q?la/ozkfUTIzlNgA90KzIR+tKb2tnnjz20gbwiRcakRrs8lHtvYE7Sm+lJopo?=
 =?us-ascii?Q?jqKARBDGXyKeMCSnDu8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2cb38b-9af6-4fd0-4d8a-08da87b43878
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 22:42:13.6993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MoLRdne2KrQx781MGEzDkxbfqdbGud5yjukz1jufzYvRGqiDgLAPc6Kc2VbjqgCa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1650
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: xZpK39fHTlepzJEh2ZBh5UBQB8AEcpnL
X-Proofpoint-GUID: xZpK39fHTlepzJEh2ZBh5UBQB8AEcpnL
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_12,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=680
 malwarescore=0 clxscore=1011 bulkscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208260089
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> -----Original Message-----
> From: Jia He <justin.he@arm.com>
> Sent: Monday, August 22, 2022 10:41 AM
> Subject: [RESEND PATCH v3 3/9] EDAC/ghes: Make ghes_edac a proper module =
to
> remove the dependency on ghes

1. I suggest adding:
    MODULE_ALIAS("acpi*")

so udev will automatically load the module on any system with ACPI.=20

> drivers/edac/Kconfig
> config EDAC_GHES
> +	tristate "Output ACPI APEI/GHES BIOS detected errors via EDAC"

2. I suggest:
    tristate "APEI (ACPI Platform Error Interfaces) GHES (Generic Hardware =
Error Source)"

That's in a menu of EDAC drivers, so no suffix is needed.

3. The Kconfig help text needs some updates, since the drivers are now orde=
ring
themselves to avoid race conditions.

Current:
          Not all machines support hardware-driven error report. Some of th=
ose
          provide a BIOS-driven error report mechanism via ACPI, using the
          APEI/GHES driver. By enabling this option, the error reports prov=
ided
          by GHES are sent to userspace via the EDAC API.

          When this option is enabled, it will disable the hardware-driven
          mechanisms, if a GHES BIOS is detected, entering into the
          "Firmware First" mode.

          It should be noticed that keeping both GHES and a hardware-driven
          error mechanism won't work well, as BIOS will race with OS, while
          reading the error registers. So, if you want to not use "Firmware
          first" GHES error mechanism, you should disable GHES either at
          compilation time or by passing "ghes.disable=3D1" Kernel paramete=
r
          at boot time.

          In doubt, say 'Y'.

Suggestion:
  Support for error detection and correction based on APEI (ACPI Platform
  Error Interfaces), which allows system firmware to report hardware errors=
=20
  via the HEST (Hardware Error Source Table) using GHES (Generic Hardware
  Error Source) records. Some systems perform "firmware first" processing
  of errors before reporting them.

  This module is supported in systems supporting GHES. If the architecture
  is x86, the module only loads if the platform is listed in a known-good
  platform list (see drivers/edac/ghes_edac.c) or if ghes.force_load=3D1
  is specified on the kernel command line).


4. In the help text for each module that looks for GHES and refuses to load=
=20
(e.g., EDAC_AMD64), add a sentence:

  This module does not load on a system supporting ACPI GHES.

> drivers/acpi/apei/ghes.c
> +MODULE_DESCRIPTION("Output ACPI APEI/GHES BIOS detected errors module vi=
a EDAC");

5. I suggest:
    MODULE_DESCRIPTION("APEI (ACPI Platform Error Interfaces) GHES (Generic=
 Hardware Error Source) EDAC driver")


