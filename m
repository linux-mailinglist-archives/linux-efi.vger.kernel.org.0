Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829285A1D42
	for <lists+linux-efi@lfdr.de>; Fri, 26 Aug 2022 01:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244551AbiHYXjg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Aug 2022 19:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiHYXjf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 25 Aug 2022 19:39:35 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D161BAD9A2;
        Thu, 25 Aug 2022 16:39:34 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PNH2Bk014516;
        Thu, 25 Aug 2022 23:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=m3dNM5weGvQvaZQWEYxIK3G/zD/1bNUUa1wHJcocj6E=;
 b=QiFMVXNmxmLs32GiNJrUUQPT8ILkNGUJkuxf8qqdtD/mReM9siFEn7p/FD57TsISbGOz
 0rjZJ7ZYDrxERLCIg5s3Wc781O9s/Tdmoxwrjx5BkSZzVHpcA+c4vGAH5t80uc0IMjTe
 0pHdnAlt2gDPa8kdRlwrN5vYnpWzauru3ybP4O0AgCxjFqpGAEzLj2T+ft2CvpY3/w9R
 /gMNHEemeqzNgkKvyX/BUGPHKLeL4xoZeIWtD32Sah1yWvA7dshywBC9yw+Kvz95tbn5
 WGrsmEqSetoCZ8As0PlMzxsojCNglBvQXS+jew+mbZpwZLJ8Xj3El3bws1IXtdKBK6h8 MA== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j6jm4r50p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 23:38:38 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 35946801707;
        Thu, 25 Aug 2022 23:38:34 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 25 Aug 2022 11:38:33 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 25 Aug 2022 11:38:33 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 25 Aug 2022 11:38:33 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvq1iuWzQGKCfhzrKA4z9Hq3vvB40sXzd7tBW31eMoMfoJxYokr+kCFejBmjwlM7VY+7znxQucAHauhEF1pEI9NccjtIQAlt7+mq2S7luVvosr5pch97E3IBvGfqQpGcwyCYhjAzghOLtiK/G1yp8n0QSXUxmXjtbZqr0qCeXlL2NREdLQQSJK62TJpd2GbYcizSOGEBNx9Toerb2NmBe3MHBeggil+eTxpjajltZQTOc3KjXGVXKvdbG0Mlbjaz3Jg+TeRaPKbZNH3TXZux28fFy3QHH+NSLCtMLXp7a1viMmpBbCIaAlMpG6DAJO96vG6wj6iRqmj62D8RgXYTeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3dNM5weGvQvaZQWEYxIK3G/zD/1bNUUa1wHJcocj6E=;
 b=RSO2R/sstWst2h0G1GxuoE91ayKzKyfFXwhIsRDXjjzIgzVEznWDsgLrYKCNYvklyveVFIicJsSkw+Nz3YEH83d9OoleU64CfJs/vvng1yzEYx5+o5/m33AwEE/ovZ3nBkziymEhmFmMsxCJghKZ0Xdtcjf+Z1Edrfv57eoFBgRrxQZUMs3lMXo4a1tN0wiW64xLPnFd5jQwawT8fUD4lqgtlwxTmm8hiJuF9VuhGkTSnU9LAmjK48CIbuZd5RdUqLBInnrwvAxYT8ghu5O7dkN2rGCBtL+o8sNgt3vyW3DGGVrz/aY/d/AyMNsiNo65s1XPWDlfEZIHiHfB1cF2RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4c::19) by
 DM4PR84MB3029.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:ab::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Thu, 25 Aug 2022 23:38:31 +0000
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6]) by DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6%5]) with mapi id 15.20.5546.016; Thu, 25 Aug 2022
 23:38:31 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Justin He <Justin.He@arm.com>, Len Brown <lenb@kernel.org>,
        James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
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
        nd <nd@arm.com>, "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Neeraj Upadhyay" <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [RESEND PATCH v3 5/9] EDAC: Don't load chipset-specific edac
 drivers when ghes_edac is preferred
Thread-Topic: [RESEND PATCH v3 5/9] EDAC: Don't load chipset-specific edac
 drivers when ghes_edac is preferred
Thread-Index: AQHYtj3CtK4qzp4YK06O7QvReAOI3K2+qefQgAC4gQCAAN6V8A==
Date:   Thu, 25 Aug 2022 23:38:31 +0000
Message-ID: <DM4PR84MB1853B18D5B6CF94CD8CEA78782729@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220822154048.188253-1-justin.he@arm.com>
 <20220822154048.188253-6-justin.he@arm.com>
 <DM4PR84MB1853A76B1374A4BEAD8A1E3982739@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
 <DBBPR08MB453861C0EA7FB40AB3A13FCBF7729@DBBPR08MB4538.eurprd08.prod.outlook.com>
In-Reply-To: <DBBPR08MB453861C0EA7FB40AB3A13FCBF7729@DBBPR08MB4538.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddafab17-5a9f-4489-0b24-08da86f2eb46
x-ms-traffictypediagnostic: DM4PR84MB3029:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YhCLSD9jTxFyl99TA3hf7b8kR0kw7grdPm7TfRcPuq1f7X7HkMXW6u+WAbnPE0uueZa+t5Sz0iITswV9sMpphCsl3Vhn6a1ZksozdOLd/vuBKKJAxOZbumUOFGF464a0/f1o6qSHkdkUt+OcNVnsDM9qnlk0/+lkO1AJCyIKNpe+LJxynNHtUz32M9lktgq2dV/HmB/PdYj6HnlgGqDodxsE1j1oLjJBeRIkWVFx2Tt5lCoJcMn2+DGMNeMkF9sMHNMZoKjgrGQU1+Su2pC/CfwTCRqfCRROqLyilmOplEIJkcC6kdPoycBs7s+vKr7KEGZtaYAFtybJwqluV6pupadx0aO9s/XLySINhmWmb31XmMBdNLf+pDbGNIsBXEqlCjNJbsE1zEd29nfuG2IvsBT0WvsjwjOKcBlun9u5Q0Bx265vdKHD7eiAoxaT3Ze6DlSjOELY13+OKQcbnJ9w/Yz6WMU6urG57nEXQgG2ntQf/KWgygkGEA3DUJ8Ed6va7bHwWo80Q+5M+IXFcV0LggGYyjiviFDf9sN186Xg4UnRk5c3CrXq1uNn55EO8AHczVrO2KsePpyjROnqRdl1M4frb3Lx1BpMJxDtGDkqH6yTuRQJ/cMiksKgM5KWpyxDJrUFXI0OEVE6sQX70br7vz480aFVQmsFRbasAvWfq7qIUxpodCca7u8fD73+4fdE+nxFpR8Lv1QhEDE6UiBtOZxcwDp4po2aIN7v42jO1usUuY0TtbtP6oebQ2rXWEAUC1p9yPD87rnFArKSv1zJZLVTUpCqTxCuY6/1GJPmliM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(136003)(376002)(39860400002)(366004)(186003)(66446008)(38070700005)(66556008)(54906003)(66476007)(66946007)(64756008)(316002)(71200400001)(8676002)(110136005)(76116006)(4326008)(26005)(9686003)(5660300002)(8936002)(478600001)(41300700001)(7406005)(2906002)(7416002)(52536014)(33656002)(82960400001)(921005)(122000001)(6506007)(7696005)(55016003)(86362001)(53546011)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AlxWijo0KrFu54a34q0UvVIN5TbyzKv9ht9OV12NfTimKUGmiZOkGpB89+hP?=
 =?us-ascii?Q?eXH5yAFLYwiF2FpWqvmTMf9hUX+m6URNBkUbnQNT0ObSUUssu3dZGEd1S/Ub?=
 =?us-ascii?Q?z+lHhdUZi0adjLypR2WO5jyDOn8IYd1ZJcFn5uYI2m9mBQ/liMzjw+rzUKx1?=
 =?us-ascii?Q?eIRlkyOJA4tT2Bps1y2OCgRcxB+AjCQiUB5/tP33dnJqWfdBzitiIOcPiDVs?=
 =?us-ascii?Q?zmRlXLGAWL9QjTcle7JMxV2Evq3dieC14nCys3cSuxtLMUmpmN9sC7c4Pgu0?=
 =?us-ascii?Q?kjPgFndsCKRfGPwhOrGOJb1W8rFpbOPI+u2xmcxwSxRu6nPUA4zfls318WPM?=
 =?us-ascii?Q?etkJs2XvCWzzcSJPTZ1b+nIMrryvm2+XTuRGAZ0AGDGk2iJEoz5+W0NKhy7i?=
 =?us-ascii?Q?Tz31ZR3qdmga7NlIJhDZrnQfQlNDXjSeB1hFNovLjVlj+3ACT2R/Q0ZeQdlL?=
 =?us-ascii?Q?VozZqIsabAC9ZeoeP10t+coXmm62tSkrN8B5R4CVMgICceaUG1XnZUovVe28?=
 =?us-ascii?Q?SAylPczPUYfUh0id2iYROgy0qZmOGcUl1Dd3ZBrqrkUJ0ahe5uQZe2PnpDqJ?=
 =?us-ascii?Q?r4isSpju8Lfk4fo8PjFudxeUNbIuYNbNP+7KmR9UuJIJTXQs2xB5S5PAzkfc?=
 =?us-ascii?Q?jRS330dQbUNbY+SSTv1Se3D5wArxPtBFXURicI5SCC5lZ73EK0ExJqmpEP/E?=
 =?us-ascii?Q?U8nxP086VCVGSClSt9Cj5XmrRcz5g6Y/yTf+KlxwmjJaRIWN109QpFdFZ3BY?=
 =?us-ascii?Q?73FmHTDQPgRyGDQtdaAl6rTk/DDdz06Wv9s44Xrh+BPKp1TCocZnLNQu0b8x?=
 =?us-ascii?Q?N6imPK1jsKXjc0j7ILvYjI963WVJboKM5NDJ8hwXflXII45Sey9IFALQnw2P?=
 =?us-ascii?Q?C8pdD9vYWXWrVRWmRcr4alKbVrQDRVb6BS3l5xMVNTA5JOqgdLhWbqfoV4Kp?=
 =?us-ascii?Q?8jyNAwR+mF5uXnKG7Qcv1O95E/+j/ZGWpAIFt1g5VVsWCGy1q4OkF6h6E2lG?=
 =?us-ascii?Q?fkUJsVmSSWwnJD+XMCT13wlB+eL9zrm8/bqJNe1FSBy+EjtkMwqFUqD5uZJ0?=
 =?us-ascii?Q?L+n9m9kN/mwLoSgteJcWnbtNhgkb7s0rKeLAW7FNi4cfyJKlDQretMxJ1fZV?=
 =?us-ascii?Q?KwzRivrslodMpPy9Jt9Jy/3FdUidi5HcMeR78vadqehGe8LdZdcCKVvbDSC8?=
 =?us-ascii?Q?i/MdIB0vK5zgFV0IPzmVzUHuPU0YFr9WzoguFsMKNNQhS/yMII8tkDmxev6Y?=
 =?us-ascii?Q?xdq45ZyLKVjjeKMLtTb1yXYWRNVGCUYCYDSaJy5zbvEHMj+2Hz8ikIe8na3G?=
 =?us-ascii?Q?zFlJAXRGEnHldEH3jVXo9f2/wXEjap2iXVAPxNLz6mo458FlmXQeCwUVwB4Q?=
 =?us-ascii?Q?BN5hRXxKdw0WsOTp9YHZWNPwiHWFzK6MtM2NzoU/Z7/3JMtWH57edLKFvCU8?=
 =?us-ascii?Q?5sPrwAI6/aNSgQWorhjN1+5sBWZph9V6bUBFWrBSYs/glnU2ngRvaMcGUibl?=
 =?us-ascii?Q?GuFLPSyRZRHyrYfY2lkzwr8GzDZwUP37tM1doL9vBA7AKSffTlpYeIaLwUDN?=
 =?us-ascii?Q?GM24AorboDfiZpNqV3McRBHcVcVFwRIvzgBb3X38?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ddafab17-5a9f-4489-0b24-08da86f2eb46
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 23:38:31.3477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6LZUcV26W94MRd0JdwVzzaxPJXxfPiHtBQr4ax0iFvR3cKk+gVVGILAwLrDfHcReAkPAo/to5DXAJWYdvB47oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB3029
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 7kKiTtpjShxQKNz6S7ZWSPa1nEzr9Zjg
X-Proofpoint-ORIG-GUID: 7kKiTtpjShxQKNz6S7ZWSPa1nEzr9Zjg
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_11,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=558 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208250090
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thursday, August 25, 2022 3:46 AM, Justin He wrote:
> > ghes_get_devices() changing multiple times in the series is
> > confusing to me.   Can you simply introduce ghes_get_devices()
> > and ghes_preferred() in the right state in a patch?  Perhaps, patch #2,=
 #5,
> > #6 can collapse to introduce the two funcs?
>=20
> My purpose was to make it easy for review. I am ok to merge these patches
> into one.

This series starts with your original patchset and then has additional
patches to address the issues with the original patchset.  The number
of the patches continues to increase in this way...  You do not need to=20
record the history of discussions and design changes in the series.
=20
> > The rest of patch #5 adding the call to ghes_edac_preferred() into othe=
r edac
> > drivers can remain as a separate patch.
>=20
> Okay, I assume you mean to merge all of the ghes_edac_preferred()
> checking for intel and
> Arm edac drivers into 1 separate patch, am I understanding well?

No, that's not what I meant.

ghes_get_devices() and ghes_edac_preferred() look good to me after
all patches are applied.  So, instead of introducing the original design of
ghes_get_devices() and then changing its design multiple times in the
series, please simply add the final version of ghes_get_devices() and=20
ghes_edac_preferred() in a single patch.  They are small functions anyway.

That is, your series includes something like:
  - PATCH: Add ghes_get_devices() and ghes_edac_preferred() interfaces
  - PATCH: Add ghes_edac_preferred check to chipset-specific edac drivers

Toshi




