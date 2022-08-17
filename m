Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892255978BC
	for <lists+linux-efi@lfdr.de>; Wed, 17 Aug 2022 23:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242397AbiHQVKr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Aug 2022 17:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242393AbiHQVKm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Aug 2022 17:10:42 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D606BA0627;
        Wed, 17 Aug 2022 14:10:41 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HJjkQa019145;
        Wed, 17 Aug 2022 21:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=UmqgMxII6tjAc2aeC5WqJkZ209EVRxK+IQkIbpXmC+s=;
 b=WSmB9AMSwDO3BwO2eERhWAkF+2HDM9oOSxpWlDCHyDPjR3mi+W4tZTTAJxuLGO1I1LWO
 6S9NoMfXqWgxTF0LOcOJNsD477hZrT8ZyhnDYfPq8/Wzp2g7MJaIuY9IdBUi3I3JD/km
 KseO/V4UQO47lIE7+YsM5zJ2rSM+EZjyO9g1STFOWXywxzjo+psDCSvsG3p6xhmxAstq
 mPt1CUI+OfU6DLFIBbB0AGJC8KUfty2GrAhUjLQmrNbdZs1KZkdx3YyGlibKc2sB+tSX
 fyEsQ/3NEwDawMAiq01AEJIqAYlZZEjl61SZYtHJkF7MMvmE8U6GJ0QYCI/z5Cd/90xm sA== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j16rv0nga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 21:09:51 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id D731F801711;
        Wed, 17 Aug 2022 21:09:46 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 17 Aug 2022 09:09:43 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 17 Aug 2022 09:09:43 -1200
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 17 Aug 2022 21:09:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeYTxLo6/so6/jaQjWCBbebTCm7ujdZqLjUzruycDLFwN2YOqjwvTaaotAFcHLO4MdfmbICxOYwp9U2FlshHBOIJkLK1iJZFD/yyDcu1Hq7zToM7LoK1aYlfHlPcMaqwT+Mm/LMcQ+Tzf1piQPrXtWARJRMICfccctJ986kuJ+ktuT+sQgaQn/MTXyMdsYQIdzS9tehzBzUMPAYx2U4GvbvVruHdvZ9tVm340k4cZcEpFSFi4t4dIpAzBi3b2T8X5rr28Qu3beWuX2FQyo1InTIvpouHgCumaoHodLxpSqJbIrwfTQgltuEMAPIs3Kui2VZe0DbFmv8FvaSAezlkTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmqgMxII6tjAc2aeC5WqJkZ209EVRxK+IQkIbpXmC+s=;
 b=L9Vo5avUmArDTLuPxQQJDFX7v0m32MpDL5pNdavtnKwvYbivE3jGa9zu2vqDEoLeCusp9T6eMxOnFe0CSzUJXUT0qDLsDSGmx1DC0/6drMWis+lPM/Ia1TRQsnfYpAFvsGApPemarlAqdNtLO98lcAIp5P4aBL61MyQaAO+4JhDwEYMSp//LdW8G+GgEGZ62fNQ5AsmMU1TKvDVoSi9Huh6Bb3hKBmd9kzVvRgH5YmkuAXyeDW9XzhOz/PwaKydFdof2yN9AJpMyHKwn+3ZJf3eZcXrFn7rpReenScnHWSST+KJc7wwJ/9FVboSqcJZg0Hz1n0XTNON9pz3UlFV5OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:154::8)
 by PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:154::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 17 Aug
 2022 21:09:41 +0000
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dcac:1265:7a54:ee2d]) by PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dcac:1265:7a54:ee2d%8]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 21:09:41 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Justin He <Justin.He@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Robert Richter" <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        nd <nd@arm.com>, "stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH 2/2] EDAC/ghes: Modularize ghes_edac driver to remove the
 dependency on ghes
Thread-Topic: [PATCH 2/2] EDAC/ghes: Modularize ghes_edac driver to remove the
 dependency on ghes
Thread-Index: AQHYrWP5SAOmNkRRRk2vGxqNR/QEGq2rWbeAgAV49oCAAW4e0IAAkRcAgAC+XmCAAAyZAIAAAUTw
Date:   Wed, 17 Aug 2022 21:09:41 +0000
Message-ID: <PH7PR84MB1838B5AE91C939D3C9D872A2826A9@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220811091713.10427-1-justin.he@arm.com>
 <20220811091713.10427-3-justin.he@arm.com> <YvZnrTrXhRn8FV3I@zn.tnic>
 <DBBPR08MB45389A9DB098F1AC14C19074F76B9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <PH7PR84MB1838203B478319EA45167BB4826A9@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvyruNX+BUi+O3Df@zn.tnic>
 <PH7PR84MB183888AC20B37A3D891C332D826A9@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <Yv1V+gWICIcuNXdE@zn.tnic>
In-Reply-To: <Yv1V+gWICIcuNXdE@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31fbb3ec-a978-4d60-727a-08da8094cd27
x-ms-traffictypediagnostic: PH7PR84MB1957:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tm0x+wgyVSXq2IJomty/t4cBM+oXeiyIAt6eWOI4Q4+RTHfpxg1sDqpEpU/AwwOI1d3j+iA8xKNPtgMaIzwYQ6MaW6RvG/1aCzSOccR/IdejyUQcumxt0lMkPlXFlXT3fk1g5d8/BxgGnoK0Ro1NMGgFxBi7mFugJp1iYwvhi+0gqCWsq+iUXmr7EwOaWZhG1SNb2+6VTIkWPf2koTAvlQvowY/CgYcbK27M4kBvcRLQtZCpOhwF5wm9nw57ORf2XsmYCq+U88Fa0HUoBkb+iYgzXmQot92mvgcdjwE+A3WaJpX9c6XHXwhcAkmg5eOcr3MuxPN19ryGQ3VwOfKqSL7zbX41WP+CIF9lx2+m4yPIe/6/ouS7r3GK+isQlL5ArmWMP+KF2n2++veVSkZAn6n+3xDL7eB60BQV1ZwJB1V/YSEXfY+xONAmOSrc6ldRW26Pe3nBAMMFFsgIr18a0cqlOEoXOaaSJ7htZ5mzfha+aaj4uhIrZCfhdRVFQt09Id7ZD8oWj204IGKyUoA12aQYTuLqo/5zn4CQYlEAReHBdrMVlXFJl+w5e92S5EjqH41l2PC69VNYjFJmjkmcBq82+BdqM8Kzm5fb+BYbg/noJp5Mbe8n7c7ab6kS0oonBchhG7wXYMPVwFw2u3xuOxYdmA8Ye3sNlqVJMT4EecUDGz6l94IVTl/NUXV2iqJbcCUJYp3YsPLyv/OVPFol9P4QANEu6vf+VT4UcMHWL9QnAuQxzEBQ2VW5rjo6DnznNtmz0yfvaFVVlMAz6479oQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(376002)(39860400002)(346002)(9686003)(38100700002)(41300700001)(316002)(55016003)(186003)(54906003)(71200400001)(53546011)(478600001)(26005)(122000001)(86362001)(6916009)(7696005)(82960400001)(6506007)(38070700005)(33656002)(2906002)(4326008)(7416002)(8676002)(8936002)(52536014)(5660300002)(66946007)(66476007)(66556008)(64756008)(4744005)(66446008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XIf9LdZHqOkbA7XyDg2t1P4qTlgtqPBlWZxhPoj2ELzEOCE63KGrh1s5h+Gr?=
 =?us-ascii?Q?wbpqqLCVK3Phm5B+V8PU4ELSmkhdwim0ioEP2tBeX31RFtiPs4gK2XLVVBcG?=
 =?us-ascii?Q?QriwRFZtYXmPcPv1nRX6G9emNnX5c8BC1Hf+3TAu5kELB5QtdKte0sasJj7x?=
 =?us-ascii?Q?mZ7fq15sg3dHOWLX8waRxQ29ZSHnDf/kTXt+HvzbchN8zXP6I4cwJaePF0+G?=
 =?us-ascii?Q?AyGal9xJdlC32nFCr26D/RJLlKPFlIKCw0MkS/Xui/aW4DzStjD9QNAO1fFY?=
 =?us-ascii?Q?eblbN9461O4M0NZzDRQV7bXgDqzdnhRZQoApUtOdd/P9TML8WbHJ+nz+/2oO?=
 =?us-ascii?Q?CUT0rnyGlW0M+wM93bmc03FhpZc7pL/9ZuISgM8VCGjkI1YDxX0WocTzZFxQ?=
 =?us-ascii?Q?jLuRaB5zGtRp+Fo1TNMRjeo43IQpzhwOmPq+cMn8TZoCrwyMDFyp7X+5xV8g?=
 =?us-ascii?Q?sxMY6DmqHlN37q8jKiiHTZlwkyT7Jx5u1dfX8MofLL0iescHO8bGRraElAuK?=
 =?us-ascii?Q?UhUWUIyxDGhQxJwU+cWHoclCmQnI9d8kQOdCpoQ1zdH41abEa9msuySTSX79?=
 =?us-ascii?Q?PSHaVqhARCHlTJeolRKIJ4bZvS6wER+PR+zj8wg4Cbjp9cGjSRtsr36lbSz2?=
 =?us-ascii?Q?9/XaPAPo0ScMXsFO8Eh/qQxT+arfgCRDNac44s4af7t7JKnaKvo+L9PuvLQq?=
 =?us-ascii?Q?Ht03exUR1xzgbv5HqNZapOLZKHyYIpDECGpQL1rsfg0rO/vlcu1RXJ1vRe50?=
 =?us-ascii?Q?NJfTNIylRX/Zo5lzjfu0cqDL0AUgLsGDX/w3StGuSbZpSjdMrDoHBVdPyi0v?=
 =?us-ascii?Q?oqnNDeRzyXLqiBikXtYuQx7W7+YJO6L65Pdgcy0St3KzNn7e3vsetpfaxIHJ?=
 =?us-ascii?Q?amkX47RdFniZRvLeEk8pL/SN8qfg1I5PT1h4XrQyA214g3w9ELZlbFZ7Q9wf?=
 =?us-ascii?Q?1LhnyoG7nQ8D7PlTpY0IQnIxwVgdzzySAhDG0KLwKF6fJZzvzwZV7scUdQ8h?=
 =?us-ascii?Q?NlkiPC9FNnLygfn+YN8sspnNBFBKwqFSmYwn0ETSj4LXmD/Nm1N3sQ2QuDhO?=
 =?us-ascii?Q?CHwswuwSWpK/6LE7agEja2j2ZTDIkM0lLnqbPBEjm8LcAqrtMlqFD7+0ak9J?=
 =?us-ascii?Q?SsBEL/kOVlIcjZQLjTq3KqSgADyKzFwGLbKVCTnMKnJamPHa+wN0py5O2q/x?=
 =?us-ascii?Q?qWc/jC138pMf9idlhIFi6sfwJI59sw/P6XYS3+uDssrirDeQPgr8ZMLKqdUt?=
 =?us-ascii?Q?92NQ6jeOLpS1neJKMXBgABGlARspa73IqMJln7z1DQvckHGqrbOLqKGpKhbw?=
 =?us-ascii?Q?1jmoP8u3+7+eZMItHhss49C9qbHw65zRg/GLWgEHprPRybzYlLcFl7nX/9NU?=
 =?us-ascii?Q?Wl8PbF1vOM0QALRkMBeW9elxvqSr7s0oFIqTC4wsW1sZ4kv9amYz8EG3AIPV?=
 =?us-ascii?Q?8C7os7O7w7MHaVG8hKfhJ6MckvGLlA3pe+rOUVqEEBR9BrEWTRZvclA/Cyte?=
 =?us-ascii?Q?GFRTd91qBzSHbn3Mj1Kthf+k8y5dA4VWDaGF1L4bRDhmcYf5utdLauRtw2Z5?=
 =?us-ascii?Q?XhLVt6HaIatZx7YGhWB1AgUWq/3zGKHV2sojqYKj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 31fbb3ec-a978-4d60-727a-08da8094cd27
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 21:09:41.1464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7P8gyMcVGknQ+CaVGvhtvb5b3xLVFn2EJhTlS+mL9hGx2UQ82EkyQgfLr5UspULbsaBf2ZHfzjPvoLDtu8XaoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1957
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: IT79jBqeDCJdkdmZVr0-Nk2AOTIp7GgW
X-Proofpoint-ORIG-GUID: IT79jBqeDCJdkdmZVr0-Nk2AOTIp7GgW
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_15,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 mlxlogscore=526 mlxscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208170079
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wednesday, August 17, 2022 2:56 PM, Borislav Petkov wrote:
> On Wed, Aug 17, 2022 at 08:22:58PM +0000, Kani, Toshi wrote:
> > ghes_edac is used on Arm. This original issue happened on a non-HPE
> > platform.
>=20
> Remember: ghes_edac loads only on known-good platforms - not the other
> way around. If ARM folks wanna use it there, then I'd expect explicit
> enablement to do so.

Well, that was the case originally, which is why 301375e76432 was made
for x86 chipset-specific edac drivers only at that time.

Since then, the change below enabled ghes_edac on Arm without this
known-good platforms check.

commit eaa3a1d46 ("EDAC, ghes: Make platform-based whitelisting x86-only")

Toshi
