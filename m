Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748AF5AB60E
	for <lists+linux-efi@lfdr.de>; Fri,  2 Sep 2022 17:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237737AbiIBP5U (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Sep 2022 11:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237613AbiIBPz7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Sep 2022 11:55:59 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91103BE7;
        Fri,  2 Sep 2022 08:49:45 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282FbNWA022714;
        Fri, 2 Sep 2022 15:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=ph6rsTuhBK6bp7wLrqd6UKAPSMGWbEK8wp4PrREKFU4=;
 b=Qh1gduJbhcrY80TS2ZOxttAqTV2RMTrP8bZ5Sifh93WYqAhmml18251zro1WWRtsvJPJ
 Pwpb9n4CI31l3Pe4NmVuFjAsbPYfhjkz25UreFTgmfKJlpmMIa9GPRbxi+0aEH7LDWfY
 c6pDINLGaNrjI3qeloXA/BkgcB+1ugfJp4+yIGLbzj1WnPVn4MNWOfZf30vL7PkipEin
 z1M9AdRRW5WfVo5+KW6ZL4wF/zeXKuMx5Qe0qgnseQzwZolJYn0koQvn51K+uCicMnUP
 VNUwoM2wv2Na26iFFYCRcEeV6ZePpqk7SNJ6ILB0W4yWHLef+u5vtqGrlMZU2DFMffq5 bQ== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3jbmmu8457-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 15:49:18 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id B2134D2A3;
        Fri,  2 Sep 2022 15:49:16 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 2 Sep 2022 03:48:42 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 2 Sep 2022 03:48:42 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 2 Sep 2022 03:48:42 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 2 Sep 2022 03:48:41 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZ7JZKb5nt3ibYtcDOXmH7AqUZ4d+4vquc/V7p08ZBeEv3xXR2A6baw95K70XNMjnt/cDppda38GKspMh3NRfme4Hkou960af96aGfr0pYnLKAqCt5u4EW7NP0tebyhU/MGYc2x2p+Odct9VeH2Wgv36ERsDuYE0msFsn/fyEDmwIWsrZHWqB4NKMHHxKdCFesXtlCd5bLvPo7Nem9zIVb8mKPeADc2I8xYyRx3WS7FDUaPGCm5ZFnbEOcy6mF6bU4A58TZ/PY8vv57S3k+pi5rG1Wrrxh9uua6L1VMs4C8FAqJtWQWQCRUoKHnbm8SJyMZnzE1uJ2wY9gzq8gY0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ph6rsTuhBK6bp7wLrqd6UKAPSMGWbEK8wp4PrREKFU4=;
 b=XqEI+d8TGnx4H7qu0XDVRQbtIyuvcTEJQf9SnuWPpfXPcTh4pVxqR5gbdLJtuWCPRjwIp0DQ3XKvOki7p3naE5FlNzi1/I10kc55U8QqLnvhiPpRC9xTGAN9WuL4RfJP2+CzIwqdDxa26r/qvafPujxrazPNDRJP0LRYdICWP6wx7l6SZ+IWvIqWantzeRwvYY9AgO7Ob6/wypoF5EFUFjMMuGdOEZgnwEjjmUZxRWfdDUdoOYz1EzNm8/RYoXpoQwlzoHN4Ouri4UKMia4dCi1VQE09ROmyZLEyzUYEwF5A6v98V6KIodJJ+xFa9T2Ub3brYWCm0M6Vko1+twEuFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4c::19) by
 MW4PR84MB1419.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 15:48:40 +0000
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6]) by DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6%4]) with mapi id 15.20.5566.021; Fri, 2 Sep 2022
 15:48:40 +0000
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
Subject: RE: [PATCH v4 6/8] EDAC: Add the ghes_edac_preferred check for
 chipset-specific edac drivers
Thread-Topic: [PATCH v4 6/8] EDAC: Add the ghes_edac_preferred check for
 chipset-specific edac drivers
Thread-Index: AQHYvQ0mmogQVBatMkyjPYFxxib2mK3MSEdA
Date:   Fri, 2 Sep 2022 15:48:40 +0000
Message-ID: <DM4PR84MB1853050924AA00C26C1DAA1A827A9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220831074027.13849-1-justin.he@arm.com>
 <20220831074027.13849-7-justin.he@arm.com>
In-Reply-To: <20220831074027.13849-7-justin.he@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e7210e2-10b9-44fb-768d-08da8cfa9b66
x-ms-traffictypediagnostic: MW4PR84MB1419:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A8tnkRSuYC+ryXbXNxvLMhQR4+/1J2yqRakX2q9LBRt6F04RO4n017n/MW0g4zrWKAvFVUYL/3N+/RbJYDVqUI3DKL6cPeGQvaejSPMsWmOSnyE7gwOnPF/WKIiS8G4JHEhssGzDgwYuZwO5MAsoPmIo+bBysIkQFF5Jh4TX9X6e8Pzy724phTvEEhMyEiTBArVv3n7CBEAMtJ2KMPDKWY7DUamter83dAUrBFy8zo02NA1fKfmz+JQB9VPR1EQ18uRVjgfBrr5wfKNmwD4kkKjs7dP2zxkY2KVofdyg8dEXCVG+cnwwD+qOuXK8A+tRNI6QM6GPJLtOa+yQysIk3I1Q1GdgjiJANy+Y+oGv0dg3MjKrL4duNwfAGY5xcfaQjXw59rySRbL18lOmqtDF0Gg7Ae2uE7ofRaqJNg6o0nb/MWJQPnCsDvOcl9l4wlMSFYjAb2aj1O9u3beRr17oaVCAcpH0CEkZlGOn5vFLBnzRhU6UKLo1hwfkPwJgRhAUbAcWGbbnEn9+oAN38/SWyOVg3RORZbZvrYhF6kxiMpI744EreJLh8WUxr+P7LPIo8BoVZwT3fTM68zsPBH+LgA5rIDnTjLSbh/Km2EuTv4Q0oXrrhZ8sVv5W73PY4laBNnVpSYy6o0Ey7vTvLabt2RWtC4GzEZ9ky0/v0FE71b4rWptY51lEUMc9VF2+O7r4eTo23y1tq6vm9zpobhhwuLDSWX6ng5pwdoZtO/0Ls1h0Qi4QnS8VKj28Rr0RzCydomVonanLdsT0rx5wb4dLb9TzlUSItZu3vYxV2W8NpW0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(39860400002)(366004)(396003)(376002)(82960400001)(7416002)(66946007)(66556008)(8676002)(38100700002)(64756008)(4326008)(66476007)(66446008)(38070700005)(122000001)(76116006)(52536014)(53546011)(86362001)(921005)(5660300002)(2906002)(7696005)(26005)(9686003)(8936002)(6506007)(4744005)(478600001)(41300700001)(186003)(316002)(83380400001)(110136005)(54906003)(71200400001)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p+W30jYOyvBGwrKD19P0dnXvrnAJEVHlfewUNPbnQj7EelRV+sxC9ZFOjEsF?=
 =?us-ascii?Q?s+2EoEmvfcp0k10zkBCcXFGi6czlzyts8pMqkB+Ip/yBGgvGHU8PwfRXZt4h?=
 =?us-ascii?Q?Y7tNAbCqJE+GKRuX2pIpnZaNvDIjFHMzW5l6F4GumNkVz6ouGiwrSfsUTl/b?=
 =?us-ascii?Q?5vbDi5MBlcPa4L/syU3PAFcKgTVsXzo6hxDnTEC1Ky9gJeBldORVzud1/XKn?=
 =?us-ascii?Q?ebzz9xIM0lrxrJzjxR6gKfvg9qK8WGH3s5CgfHtfJX160e63VW2CYA7QaVc1?=
 =?us-ascii?Q?eDFI5u0HSacwGnUoy8fvzt88IBLH97gqntOtTD78kj9pu5rO/JEOBQ4rywrA?=
 =?us-ascii?Q?WFffOzesfVDzUiYBy5i3Wu/5TlQrNqC3zz7qKjsJYNY8JfG8su1V9Ucur8UC?=
 =?us-ascii?Q?LQq0aHQLeYdl/yddKqji66Mhh6VmHafHQ6T3ZNt/f2FL1kElUCGW3bfDp6ow?=
 =?us-ascii?Q?y4R2egsn0bsRO0H5jHj6SQFWPZb+w3qDk8w236sXAuozImsFzddtqxVGwgJS?=
 =?us-ascii?Q?k7Y05k5x1Cd1R7ybZiJDqwC/rAzypWqlgc4/cQ/82DgzMAkute2Kpe3NrAO0?=
 =?us-ascii?Q?lvQtfwJLZxCc054sECglkre6ku/8wxf9QAD2Dh9GWg9IRSuDWHiH1WMhktPz?=
 =?us-ascii?Q?Foln/3wzr78js2skCxrYNi7YM6a5ikj/oJa/2E+rgp+B0jBXZjJOhlWQgxPS?=
 =?us-ascii?Q?ZVWFXx5OGzmespevlocXbXHaGRXPgM5E8mP5qSjqxDYgoyx/4ertqQGrusRO?=
 =?us-ascii?Q?yq6ms22/bvmC12MLYVTa/wOu/zO6yerGEC53pdiN39zoWLb7+5XF0pcgN11M?=
 =?us-ascii?Q?CPkt0LcxtdMCAbUjf2sZYBVT1YlyM2yMV41kFLsBvp91nx6nwHzB0GYIIb8T?=
 =?us-ascii?Q?tjs2cqzDp5kgsezIIXJRGJyLqayfj1jcNqFsfkqP7JB80t81QX4pB4vjwRob?=
 =?us-ascii?Q?RqkvsFlWoFS+hf5RB2IxCmdgqtZ4z3DFKXgVBe9JnZIAMI0VvBnAwUvdh8t+?=
 =?us-ascii?Q?JXGzN5C3uIX1CclAiZDzR+hVVzTYxoXRwBT9g8duKLx9bhP84VFDYjMJjZLE?=
 =?us-ascii?Q?PxORR3H37X/F73sjuiUIR9LKcjATpXtku3cZyCGtm+ov19dwhnoccw7yoC8P?=
 =?us-ascii?Q?EHQi1yUAganuAgAf/RpTgcAymrYt+xwR6i8NWj0BD4jy1jfdoWryWzgYT1rc?=
 =?us-ascii?Q?T6WYWBHPYGIawLzOOvZTxVytzW8TAIHd+1Wp+Q+Eo5P50v36W+b4UsBBBOOO?=
 =?us-ascii?Q?df6joyDUxatUOPXpEEEoKiYPLW98wwwEiRkTaMxXHnFjEyeg3li5/TNoKIFR?=
 =?us-ascii?Q?OC0Mw8mzPyPMIw/NwjYaikYv9y0UU/6wUDrHSBNiuu5+RNGJ8DeKWXWMDg/V?=
 =?us-ascii?Q?sTQr8GIOJh5AwSOYtOt/RAVmFGTV2iQXdRdBdSZ+PSBlXTktKHekANIm+6C+?=
 =?us-ascii?Q?58VDbE8VPWxw09CzyGFBxSGtzUlY7lf7qGrYTj2bCx9yi1DfWQx5SvPnHmup?=
 =?us-ascii?Q?EW1HihsN9dzvsYrsVL9Qt+X5U8mr0jUtX0dJlIN6j84ZlPsnpB3cDB3iPwEG?=
 =?us-ascii?Q?mt+AFln89egCw7pG2QUUPdHCE/0/dmxNxm4ImQ+q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7210e2-10b9-44fb-768d-08da8cfa9b66
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 15:48:40.2773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kuGg4A0ar11TccDsue4MI38hFjASdaguKq+sJpp+TxVmEGAJB18NrBniHgflKVmBeVYiV6PU9+D6vF/Ku14Gmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1419
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 2xHE_WuM3qXdjMU3U-1-msm4_nfRD9Iu
X-Proofpoint-ORIG-GUID: 2xHE_WuM3qXdjMU3U-1-msm4_nfRD9Iu
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_03,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=533 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209020077
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On Wednesday, August 31, 2022 1:40 AM, Jia He wrote:
> edac_mc_add_mc* is too late in the init path and that check should happen
> as the very first thing in the driver init function.
> Add the newly introduced helper ghes_edac_preferred() for the platform
> check.

I'd suggest to rephase a bit, something like:
=3D=3D
Add ghes_edac_preferred() check to chipset-specific edac drivers to ensure
that ghes_edac is used on the platform where ghes_edac is preferred over
chipset-specific edac driver.

Unlike the existing edac_get_owner() check, the ghes_edac_preferred() check
works independent to the module_init ordering.
=3D=3D

Otherwise, the patch looks good to me. =20
Reviewed-by: Toshi Kani <toshi.kani@hpe.com>

Toshi
