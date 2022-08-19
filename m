Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951F4599285
	for <lists+linux-efi@lfdr.de>; Fri, 19 Aug 2022 03:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239326AbiHSBaq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 21:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239199AbiHSBap (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 21:30:45 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1AACAC5B;
        Thu, 18 Aug 2022 18:30:43 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27J1Sgsg022685;
        Fri, 19 Aug 2022 01:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=VRkRcoh3Jh52i7miT7tFmjq6POaP5iqeQT6J7HFFKiA=;
 b=cuxui7tzvj28EL2HiK2Y1oB3KU4DRVsdRrReFDvm+610tZfi4jB0CWgGgWWz0WTo+g4Z
 aYcvedNqb5h2Dyon7FCSsqiEB30lUH3fepTW84YcOL7KUbyQiHuu9ISAWZ6xW9oIODXO
 MIo2tFORYpHOoff8F9nre1V30CyM+butxgiZEMwIKxG5GY126lHQRIVn4QajH4OvUYGP
 9i++tPoPE3rx8eOpn4Fh/wZX9PbyudiQth6ocDk2m2jQNBvzB+7ZQLHAL/3+42suKwQo
 hUEfowcw0xctt4PlkfzitMoNAeRGxHjEL8QTsIXkvl6hRSoe6XYwA4wGUcGRYPvQUyC/ NQ== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j20vgg0aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 01:29:40 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id BD34AD2EE;
        Fri, 19 Aug 2022 01:29:38 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 18 Aug 2022 13:29:38 -1200
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 18 Aug 2022 13:29:38 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 18 Aug 2022 13:29:38 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 19 Aug 2022 01:29:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaIn9BNLpo6H+0kCsUUhUzeml9FIoUuJRAjXe9G59sZ9ttRs9KKHh9djwEIjMf71duOnFR3vCMTGvaiwFBwBcI6ugh1Ohg7LUCJ8Juija2P1iHub8gLXTe5FD1NIUCHnYbo0Lr/nV8ukDKA8X0WpZqMsxUptvLPYUpRRzcIL3RIIX8GAv4LEJhf24Sr4Pvxe50mUK9uV7Ht00u0U+CRONiArGLeDMIlM3TPOVVd1z995lvbZKYVZUtSQD3PzRSSxYPKvSbil/Qafttkh3heOJEBxp78tq7JoRrNSQq4NtBP+CsWibTSwsVMQ9nleLipSm7zIxTHpjmJ6bb77R6QUqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRkRcoh3Jh52i7miT7tFmjq6POaP5iqeQT6J7HFFKiA=;
 b=X6Pi0HWiuyDBFUkGwZTEbVCfeRGCNqt0wJ67xUEe4ZDNuyu6fLPGYaGKuQBD8p4+DbjlQ9C18HQbEJHallS8JsHk6GOqDaYZJP3+XG9zpMzPRQWf+9/9H9Z5kkRnyrDVbbIOEnsl1/MsOqPbtpSbSKaBNqV9FOsYDiqwdmQctBrgsMZi15z40AABXSu1kqslTZA3gXlon1mjGWAh9TrvZTIAG8zdfdJg6r11uNe3XGAMXGnmzURZ74uIx8PUDCkso+ZBD62uR7N74Uitv+GU6Lmr/BwxDOZq8Zt3n4mLM2xTPxIbHXPeGk81UEf4Bz3Pm8xfMIu0+p1favZXa/4VWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4c::19) by
 SJ1PR84MB3115.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:45a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.10; Fri, 19 Aug 2022 01:29:35 +0000
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6]) by DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6%5]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 01:29:35 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Jia He <justin.he@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "nd@arm.com" <nd@arm.com>
Subject: RE: [PATCH v2 5/7] EDAC/ghes: Prevent chipset-specific edac from
 loading after ghes_edac is registered
Thread-Topic: [PATCH v2 5/7] EDAC/ghes: Prevent chipset-specific edac from
 loading after ghes_edac is registered
Thread-Index: AQHYskazgdaGLeNebEWQzyv29780RK21ZjbQ
Date:   Fri, 19 Aug 2022 01:29:35 +0000
Message-ID: <DM4PR84MB18538A56870A280CDC4637A7826C9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220817143458.335938-1-justin.he@arm.com>
 <20220817143458.335938-6-justin.he@arm.com>
In-Reply-To: <20220817143458.335938-6-justin.he@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67c61a9a-118a-4f2a-e188-08da81824692
x-ms-traffictypediagnostic: SJ1PR84MB3115:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Aewm7Fb3NlS7+1EzDhk24tUy329+3aoOH4VUpKdDdoWrVyEC9oZEsSAWzd0VyADZTbFaCAQHzgH0mlzz4n7jSp/8FtLeC+guAPMbKmXD35MD3pke2KNpUS+VsdXn3O6q1PDh1npEmRkN8uMJN4sDmHBEGSwBU0+rCZmkm/azgFq/RI7soi+wt/SAxZU4wROwjQi1JlIzm4fmMKx+ow6KEOgHGEkDpO7R24rm3nZp2NmuuHdOA//eUndqmK81SWqcXGjwIu/ASqtE096ppwXpgfzBzQyDAUnjpO62hGzj+un1kOSUN3wdMF8+3ITpgzyXYbjn8CdcpH4fbgS5Ts4JIOsOMizRCiDjm55LLXd3BpCqmwA9KvVtLW3xe+261SYJxEZhSzNXb9iwTlR7JFoK9ivPaRcYrvKpqKPhrehH/LAEL1jl0KJ2MK4dgJQw+T5iYiHxqERQbfdEO6tjxnUUxY7O8+NXGzJaAY35Ea47g/jROos3rLw6rOlX8ZibYPG/qtVLmP6L49ihVF56B7/zRxZ3kdG3s3vOmIMKgcv33heWM0Ad/32RtgPtr9QPk31ld7XqITK4YYq9Tt2sg9AoYprmCytrrJ0yJAU0nxK+OVl72PvBcAxDQ1tUceqS7eiobp2JxoSs1R5vNtRv4SeO9tv44/NX/WB1Dup2ciZCbstvsK0j/BI2GhvOfMkfoseALWSEsUxr64aIIx13SJSoNCWn2qWtB+3QJczL6rvR+w0L1Dp2/mGK9CcswmYLfwK4c8A94MAB2H8lHnsPZ6JXJCS2x9+zZWRa2Mv6aqLKDo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(396003)(376002)(136003)(346002)(7696005)(186003)(82960400001)(83380400001)(921005)(55016003)(71200400001)(41300700001)(478600001)(38100700002)(54906003)(66446008)(76116006)(7416002)(66556008)(38070700005)(8676002)(52536014)(316002)(5660300002)(9686003)(26005)(66946007)(64756008)(122000001)(53546011)(110136005)(4326008)(8936002)(2906002)(86362001)(66476007)(33656002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NYl13J+6pPwb0CztsuHGCLulDj4q4wlCTpeRYP3HUdHORHIFg7vnxXHjK8WP?=
 =?us-ascii?Q?4EnTztq0AeJvvxcISLiXyD/EiMlUYU2fI5AhkWpNCombdtDH8rWkwUYPYbEF?=
 =?us-ascii?Q?uQysJuHffAjvOIxixK3CMHkLlVPw6DD21LubL3IQwF50cW+LB9/9JjxxNn7x?=
 =?us-ascii?Q?/k97/45pUxRWAEo/r6bvAwO0v26wi83gjwdwAouDZHE3mcLucwy6w4AoGXbL?=
 =?us-ascii?Q?opaGf2K0ZNPy77OWUrsHimxwqL/+0yI8ZJ/d9FUopFvDMFUVfu5cYnmXol4m?=
 =?us-ascii?Q?FBCydbG7HrLFEyFibW8HQMiMmZ7Xe7Qoa2kYYA2TPoJBgoYC/vdBwUDrAYB0?=
 =?us-ascii?Q?QoyCv4GqYk68DVfuchfZ2NnOzEv2/jB6kFeOZaKEt3nH66rr+cQTaDCXvZE2?=
 =?us-ascii?Q?9lffaC8XEgonMa6JBVOxsB9+ELC9Y6oLarDe4vpo+cwroaviiaGdmaxH8Uyi?=
 =?us-ascii?Q?Nod0B7+NoT/SHaKyYQR6iyaybgEPygG0k+0FuUTNkv9AlLDz1r30wV+Tdrmg?=
 =?us-ascii?Q?JJ//tkByiSeHmxoaDLBPP0J8wPGrf+/+2qFprCMjNT78ApS5mZMpUfnZAJVu?=
 =?us-ascii?Q?jDxIqA9tRXse4lx61Or16iuB1NGHYqGi2oZGWw9vgHJZYdv+SyhzMtiPMRWx?=
 =?us-ascii?Q?iW1RSwaEVcvKuFV53hhdRUWVHbUatwg1B6/pxFJecE0JGyJDfzop6YnQ2cZa?=
 =?us-ascii?Q?jg7zJcRgMAy7YX2hNDIZ49r3xKluhJvluDsx5HHwErR3dqCxQKT/1Flsi+GH?=
 =?us-ascii?Q?6QMxMXurriKvuX4FKTcfgFFt6s7kpqOwKtbcPNHrf7CoLpqvlNk6nNZdGvrp?=
 =?us-ascii?Q?hdJR9xMc76dC6GNUjxBflCF9HJ4wnouJ32RyHC2OdS1CzUdDjqFrH3E+hIOa?=
 =?us-ascii?Q?f+5QwLpnJ/lUfmg72nTsGcuErqDZ42EEWrGuFf1YUVvjlYzK/cVDIm+6L8+j?=
 =?us-ascii?Q?TgsIAeEhBXtyEryARyQbKkVnqFAAFSTyN4Q6ntsa9b5ChUttPN0l4lfivheD?=
 =?us-ascii?Q?y9uQSFckl4mjXFj+QypI167B8R8A4p9dQawhSwQ5E8UWN4DiTDuwO6Z0qgHf?=
 =?us-ascii?Q?YzNWaJkFXXaJSmjByM+hrx437XgrfhffeGWr7+/4/xht3aroWARb1uIdy2Nu?=
 =?us-ascii?Q?UTSflNULRSzIresGer1K4Hf3PZGwqZOtfiMAN+N6dK1YUkc+kr0dmME2yJYQ?=
 =?us-ascii?Q?eonpoasTCJLaLJnZelivj0fRB2Jy09WtO+pZHhzHE7ogW3O+0Gg1eErpF9G9?=
 =?us-ascii?Q?Pvr0R+6HxdQJUwgejcQdLXZCZu0hXgc6EFxcpLKMQkdcvjD9bHMjiO98e6kN?=
 =?us-ascii?Q?los914Ap6SYpCvFLpJr0UeTJkotVdiv46cQvykbxsPdj57dzYAlnfoWIp2bG?=
 =?us-ascii?Q?NODtzNurIYOdiC3hdtI9aN82k7+dUnqjQkiCU9X6XpKC+nvntK+7YTZN2ML/?=
 =?us-ascii?Q?S1q5qG4peXIttu2VmZGJnzF1NJ0QPkLMKTlJWLSZIhdFtPeXLuoCfAFLRj3+?=
 =?us-ascii?Q?0UxyjkHaRz5gEzcFZl76U6en4FDIV+VgW4kRnAGor50ICpXCBelXKYbdh+Sx?=
 =?us-ascii?Q?yJrpDJwcFb0vsuL4G2EGYyCYL9W2siCT0eyIYc9M?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c61a9a-118a-4f2a-e188-08da81824692
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 01:29:35.5952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XKaK7TlfmxEqlahmv0VACAjrag5KiBnencFHq1P65fnKyCK7FWWu/l99/8pGUNITn6KcueLh1PszUF/KVGS70w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR84MB3115
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: UddhV0LRjKxI3KUYrxTZ0lrnlLgAynkD
X-Proofpoint-ORIG-GUID: UddhV0LRjKxI3KUYrxTZ0lrnlLgAynkD
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_18,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208190004
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wednesday, August 17, 2022 8:35 AM, Jia He wrote:
> Previous, there is only one edac can be registering in the EDAC core. Aft=
er
> ghes_edac is modularized, the registering of ghes devices may be deferred
> when ghes_edac is loaded. Prevent the chipset-specific edac drivers from
> loading after ghes_edac is registered, which allow the edac drivers to
> get selected in e.g. HPE platform.
...
> @@ -1382,6 +1395,7 @@ static int ghes_probe(struct platform_device
> *ghes_dev)
>  	platform_set_drvdata(ghes_dev, ghes);
>=20
>  	ghes->dev =3D &ghes_dev->dev;
> +	set_ghes_devs_registered(false);

This does not look right to me.

The condition of using ghes_edac is (ghes-present) && (ghes-preferred),
where:
 - ghes-present is latched on ghes_probe()
 - ghes-preferred is true if the platform-check passes.

ghes_get_device() introduced in the previous patch works as the=20
ghes-preferred check.

We cannot use ghes_edac registration as the ghes-present check in
this scheme since it is deferred to module_init().

I'd suggest the following changes:
- Update ghes_get_device() to check a flag latched on ghes_probe().
- Remove 'force' argument from ghes_get_device().  ghes_edac_init()
is too late to set this flag.  Also, other edac drivers should not be able
to control this flag.  I think this force_load kernel option needs to
belong to ghes with this scheme.
- ghes_get_device() exposes 'ghes_devs' to chipset-specific edac drivers,
which should be internal to ghes.  ghes_get_device() may be renamed
to something like ghes_edac_preferred() which returns true / false.

Toshi

