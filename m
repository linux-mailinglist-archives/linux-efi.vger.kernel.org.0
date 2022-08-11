Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69955906ED
	for <lists+linux-efi@lfdr.de>; Thu, 11 Aug 2022 21:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbiHKT0u (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 11 Aug 2022 15:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiHKT0s (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 11 Aug 2022 15:26:48 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F7995AEC;
        Thu, 11 Aug 2022 12:26:43 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BJKSmU031597;
        Thu, 11 Aug 2022 19:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=2BqRrcQhEY+uzEfns4fXPMe4RC32f1I5XCQlLDucZko=;
 b=WorhRitsVYtlyvGglEmDQ/AXGjIYxdf4ByXE4OSAPUJ10otrnO0GUz7Gf4Xmj/2M5mFc
 aPSPbVAM18vlPd7s/7cdQbqyIXuXaaFzo7VyUWNVWAnJeYiF9KG2S11aW6EfWKuIYESb
 0cXUR7KMXqMTupbXzeEfLChbmYhkfpMZh7VkegZaJuzV0o7GSziUU/D8gh1V2P+6CmS0
 p7UywQ0n8Y0Lshh4NdNlX33SHIUbJHWl7raXTKhozLbKt7UDCWg9mgqQsERxc0bb13i8
 bKjIgZ+9C8jbj+TdP2LuYl88PN4Ngiu2SwDfj4l5EPaTMvgtzQNjt9Bast8B9DhnaiZE mQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hw7ueg1eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 19:26:16 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 3E9A3D2D1;
        Thu, 11 Aug 2022 19:26:15 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 11 Aug 2022 07:26:09 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 11 Aug 2022 07:26:09 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 11 Aug 2022 19:26:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWtYMkIZ7iud1fyFFzW4s4IlI2vxv6fZDIHcD+wtVeqtS+ptewwQPJXQWtOPbbGuGJCz9IAKKHfFcSLArT6EwVy4UsNh66jRMvftQ2q5LSCNukYZ7Aq00LfVyVuSRy7wqrebWogyv74pl04WcrmikEfPRo477odVI1w13Jw9/pLSa+wmzPTjtmQZOYY85G9tSoKrDw4MpMMNeix1RL2qSo5R3oPQSfsH/bFsQrpxkAt5smqJdKLsZ7k/4unqlz31M+sdaQBOHc1g29KsWHLJlb2/+spC5u+p19iiJ89SGhZJ0ROFuOCGQi+wYH8Hdh4Lhqr61gAya5TFB0tpTxT6xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BqRrcQhEY+uzEfns4fXPMe4RC32f1I5XCQlLDucZko=;
 b=IKEXTYlae32D8rEPuHBx2BMbOU5G6MFrfCDFV46zL66AQcbZvT2TdhbPnAJkDzZ6nnHJrB8SagV5MadMm2CDcgdIoesskSsbYYjSs7zW/FtxXJa/jL3HnYnQj52vrohxpfuSd28r/0HIY/DCEO6Gu5/wXdhsXMWA92EsdtB86jx7u/f8jZwighNZN3mPzdprZki6+OEhZZM9LzuobEewC5O3vMyDHl/KCRQQXdi0wczQCQazRCMhI0LOU/xv6omdnCV8xJv6z3x2UIzRsZGn178N6hxNU0k7HPynw5psbr7tYxSPgVlFXS9/nKt4M182Je3VELFiucMo7WEmtqVx4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:154::8)
 by MW4PR84MB1372.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.22; Thu, 11 Aug
 2022 19:26:07 +0000
Received: from PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dcac:1265:7a54:ee2d]) by PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dcac:1265:7a54:ee2d%8]) with mapi id 15.20.5525.011; Thu, 11 Aug 2022
 19:26:07 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Jia He <justin.he@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "nd@arm.com" <nd@arm.com>, "stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH 2/2] EDAC/ghes: Modularize ghes_edac driver to remove the
 dependency on ghes
Thread-Topic: [PATCH 2/2] EDAC/ghes: Modularize ghes_edac driver to remove the
 dependency on ghes
Thread-Index: AQHYrWP5SAOmNkRRRk2vGxqNR/QEGq2qFH4Q
Date:   Thu, 11 Aug 2022 19:26:06 +0000
Message-ID: <PH7PR84MB183847AA20B2E879E0F2B90D82649@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220811091713.10427-1-justin.he@arm.com>
 <20220811091713.10427-3-justin.he@arm.com>
In-Reply-To: <20220811091713.10427-3-justin.he@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 651f70ed-14be-436b-60a0-08da7bcf56b8
x-ms-traffictypediagnostic: MW4PR84MB1372:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xImTNDoD12UvJXnn2yb5rBmDIenPi3fhJ9Eg3P5m7Bc94UqV5jrP8kE+3stQ5mBBMvOhVsxudCbu95W+pjKOfb9cSptdGcECqJEBNYwhq2WdOMAqbgSoHISPyX0578mOpJ6d7ZM3pxjOL9QlKok/pflcR/jxprGuUFrto2brSiqkVUNiJPIfWFpr3yDTRq/h6Td79HrA7H35LrNZOVue0+ihMPnN4NozctMvQfnXMGyQAASGhokxRuv0byVKpXFOGJJ5h8dC/cDCRncL1kcBylIXzN4vVtSkfrkZDv9UOltLhVW8B1+aPxrQ6OkqlrawphuQKpBrX7fU/6Nu/qaODUVDymtJZwRxfCC2bEFUFZYaQ2iCc2cBs4+U++xWkxnCCDOuQ7LhLjYvy4wZUOoaqnQILYB3my0SxHOyQppXl7aCC8tjDZ+Z/POrOxQJUwcCtFkmYeBjYJLCa6Jw8PcGcJSXWNVN/F832Fop7y5otgq6OT1EItyzQyR5HpmQ1ghRkeIrP/LvVswA2gxeIc8OxTQ7BoOm5EjzoT8OCpJW6P8AbnUiMZ1E9B3+n06Eesf4zhFqrz8r3thy2bRr2yVfTaYk44Y654sHYUZidijKRr98pS6+IZi1vZ8BHMwI3OYOfmq+DDAdpYvu8OPBt1Pw0MfmvNpb1lNDBG4s4HWyAWbWPsXM7B5Ll6CD1XVLMooG1xBLuT9ilUks2UBqYDFx9giMoXH0Xwuh6tuYc4fvku0taMpZnHnBnbwEV4eW8JRx0RTIBhBKTi4aa2Oh1S1AzepNrU4DIYM8T9WIYVclHZs3mZ4VYQlh1idMfsUfrVxM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(136003)(366004)(376002)(38070700005)(82960400001)(38100700002)(86362001)(122000001)(66476007)(64756008)(66946007)(66446008)(55016003)(76116006)(316002)(8676002)(4326008)(66556008)(2906002)(52536014)(8936002)(5660300002)(110136005)(7416002)(54906003)(9686003)(26005)(186003)(71200400001)(41300700001)(53546011)(6506007)(478600001)(33656002)(7696005)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1vDb68QoyY2CpUXNt/z+eXGwbocnPA6i5iClt3XmJ04N8VT9vbfFiTCpdWsJ?=
 =?us-ascii?Q?F/CpsruP9I7UmuVkpiy9p6n49WcUiH1mj3aWUKmw8zdvMjBW878xd2Nc1fpA?=
 =?us-ascii?Q?3sbIEpUuEgX97GJmU4tGqzmIgUB6sWhvk/0XfRWrW5GjutBAk7vP4SLAN6s8?=
 =?us-ascii?Q?39AVjruJOXHnvj6POE6YpZYqkGOtH39eh0VAQ3fNaaBSS3RWl0FiVC3ql0wB?=
 =?us-ascii?Q?AfPH07Je2FLHx4RxezfWEuFLGOqeFiKjvWZp7zgnkTT/68pE7cC6J70KfP4+?=
 =?us-ascii?Q?dEQUKR1KieLM7s/7wpbolKibYqaGV8w3jWueaS6jHGYlYR9aFD8JvY1/tS78?=
 =?us-ascii?Q?Y7ztE9SbtfuXqBjTdYEsk97kizC/Z7bBULh/jNr0vyq2umm8ARp+t8/AWuwJ?=
 =?us-ascii?Q?t21bpqZGZgg/nbzH6FY6zxIJ3sAtdaFeKPm+iTTHifka+NCXtsvrKObkUtmo?=
 =?us-ascii?Q?F1uwJvFGAU90DaZLZUep/avvSe99f8CPvifrsb/FmbfdNBCxnBLqDC6/u9BZ?=
 =?us-ascii?Q?VX17RrOF7wGttqwwsckerqIf9tHK9Wv3FTuDWCH9BAv0j/s3f4adXv/LwHUL?=
 =?us-ascii?Q?BGZcYC9fWjsJBl/QihKNl6JjNI55cIgyGeKCXIoc4/Vl+XrWHEv+wTETZztv?=
 =?us-ascii?Q?9qrxncv3T6w57/BiLcJtCb/ANJft7RuuhEbtZD/u11hq6C7xWIKP4qWCCrIN?=
 =?us-ascii?Q?26bBBZIaD5yODkldKx7ITWVj90+gf3xgdRbzEs2v6CCJ610311uW5m82MSdt?=
 =?us-ascii?Q?eemv5qGVsRS2vfqK01UFfmXksnn0fAeo1KT/Gi6UrOcGbnCrw/K+VdpKveGf?=
 =?us-ascii?Q?/zSNAqpg3KXNGxGf23oqi1WWPlbYjy64MKvbE6bDgCAhoAv1Qz3npT5KWvf+?=
 =?us-ascii?Q?JYEZgsNWSPEzH4Qf6D02eH1RWUcgOv+8shPD+EWt+ICmcKIhexRsiW2T75mB?=
 =?us-ascii?Q?wfF3PGficBkZtv2GE9XaKDKz2RJ/vpuEGpehT9XvUGcWlZNCNpxBotZRYW+C?=
 =?us-ascii?Q?NEBKmk2cHsn4OigazFJoPrNArLpiaeMZAgLqrGfKY19LMiH8oPOSfLtRmcQs?=
 =?us-ascii?Q?mNXTMl2K8nCZWqqqu8ntKhxonCm8e/PGgBcY2a25iwtNcGVpuzhJ1tddMYiB?=
 =?us-ascii?Q?CNuDTikzrsswuWigncCOP2sXFd5vlC0BwriQe/cYIScYRDDlQElP4bNfwtom?=
 =?us-ascii?Q?fbr6H3l7UMUgsx95W2X1/1XKUt06/LIOSPBVcGIEgGPJhZimlHl7/W/IuB5L?=
 =?us-ascii?Q?idPalcnKu/NUED+NKiwBMi6n9MssysTvqIotw29zfSaU5OcJGAcFHVwVCdrG?=
 =?us-ascii?Q?pNDBRkb1+iHTuJ5ApCzv+4Q248WFzDTCnczQ0Ke8r9dA5PbjhjypkTfVt8K9?=
 =?us-ascii?Q?4p16jWr1beDJilkaXY7Rdjib99W9c+K2qYhayGc6TRJvH6w1bwqCNYp2eoFP?=
 =?us-ascii?Q?UI2Z+lpHZkvjoBg7mSjIuJGV22jVfr6jizJ6y+c8UneCeFuyY5Ia8sT9jlt/?=
 =?us-ascii?Q?lflqUoB/nQg2Owt3zatkEsVvkv/9JG57cWemdkRd1wQmSPeaxmF1C/zTtIil?=
 =?us-ascii?Q?PsR4jt+6JYBxjaIFjp+xHYJLDICUx4GB/GX8V7Fq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 651f70ed-14be-436b-60a0-08da7bcf56b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 19:26:06.9404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NhFCblm81m+KeFtCSx061gm3g2HbpQmtD38NPIki62GuvgblvPLg5imlYrqUz6WbSE9U3m8alqdzrOeD4XRgkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1372
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: m-2kpa90as8IeTnABBy4Rhtmx_XXlp1k
X-Proofpoint-ORIG-GUID: m-2kpa90as8IeTnABBy4Rhtmx_XXlp1k
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_13,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 clxscore=1011 malwarescore=0 mlxscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=927 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208110060
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thursday, August 11, 2022 3:17 AM, Jia He wrote:
> Commit dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES in
> apci_init()") introduced a bug that ghes_edac_register() would be invoked
> before edac_init(). Because at that time, the bus "edac" hasn't been even
> registered, this created sysfs /devices/mc0 instead of
> /sys/devices/system/edac/mc/mc0 on an Ampere eMag server.
>=20
> The solution is modularizing the ghes_edac driver.
> Use a list to save the probing devices in ghes_probe(), and defer the
> ghes_edac_register() to the new ghes_edac module_init() by iterating over
> the devices list.

Since this approach defers the ghes_edac registration, the series needs
to include a way to prevent chipset-specific edac drivers from registering
before ghes_edac as discussed in the original email thread.

Toshi

