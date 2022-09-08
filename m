Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E250E5B1152
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 02:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiIHAc5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 20:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiIHAcs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 20:32:48 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E03ED2746;
        Wed,  7 Sep 2022 17:32:01 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287Nbb21031142;
        Thu, 8 Sep 2022 00:31:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=A12lmkJRTRY74PPCGt3FjDYf2rNNHz4JKvlrAMqrFYc=;
 b=YOAa90nIlLZC4q9iNns4qYBuqxIf4XV545ZgfBQEgcnkPDmqnds//G/qsJTNuaY8TVv5
 CPhE27KFTQthD5tVOQAQr5akJpFUcSHv5H2GKrM8piMSQW3qvVC4+9IJymI0+1UbrR8x
 YHpnyTACgTbQSN/AxKvfvD0rz3KBZNY03Q2QG+WIM8zxX+dKdJiE5gvYQinliC/N6XG+
 UENf5g6yQ1pQhRZWY3vXnuLkejI3gL4nl0vC0Bnq7k91sZliZnlvd8Tv40xefpn862wm
 MTs+LjnmvzsYU04B4XQ3P56g+ooSqHUlRNvrl8u5Zwj4xufN42YVoadaa/MCfsI5lGpb 9A== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3jf54m8bjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 00:31:33 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id B163F80173A;
        Thu,  8 Sep 2022 00:31:32 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 7 Sep 2022 12:31:21 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 7 Sep 2022 12:31:21 -1200
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 7 Sep 2022 12:31:20 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2kB6zxAm6TwQ08MgQwsuf6bTTH0hAV4/pUX63GNQ67LNElk202Na8RJzYJRhxhsr2isD2uxoGe8y41tGRuK0/DCuK9ftwOHCRmQLLXomj+VJ+3fIdXqrHvfrs2p7uu5CG7j4oD1AMFJmJRTShXP0845r0lqkuKPUuzAp/gQ3u+Q6ejZRpFUD/oQFAetv5pgtmD+DUHakjADTO6ZiBENppb3Xzt6HZnfnWNBpA9gYc3U7LdyOBOR/MhudH86emOuOnR6icoPuUGjylYtnmioKDpOOTxnOep3Ou5BRdbtW3UlcWl4ooU6sNGrXnc3G6O9Wr0xPs0zyvkHPD4+a+Oq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A12lmkJRTRY74PPCGt3FjDYf2rNNHz4JKvlrAMqrFYc=;
 b=P7ddZZb9tgtUsxz+UxZ8TKB5gM2aqPCpYbcLTolhF2ImdHoC1E21zXZt5QceVu5W6VxFfU7y2y0RGaDe0oGkPa49H906BdbZ+H0iRRMw1sXbmY1EIa+IWKkUk/OiboC7r8J6d2JTAZJPSPM5xBDYArTxfYYX+kVpceEP/HfI9eLr8wlTOiOB45A8jux5UzbBTDfTPdO86xANS3Yt0qbRRjFYkiGNO7bf+R/OWUzbjln67lFnTswe+AtcBiFPIzx94AymuCSGGY0r6k6ZG5t2IiZCtastZ4yN9VUPV7KfS66Y5ypQUG0Lgau3vC6353x13gqw+XnwnMmH7lYkxJcjwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB1849.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b0::22)
 by PH0PR84MB1811.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:162::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Thu, 8 Sep
 2022 00:31:19 +0000
Received: from MW4PR84MB1849.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::3115:a8f7:34d0:6ac1]) by MW4PR84MB1849.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::3115:a8f7:34d0:6ac1%8]) with mapi id 15.20.5566.021; Thu, 8 Sep 2022
 00:31:19 +0000
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
Subject: RE: [PATCH v5 5/8] EDAC/ghes: Make ghes_edac a proper module to
 remove the dependency on ghes
Thread-Topic: [PATCH v5 5/8] EDAC/ghes: Make ghes_edac a proper module to
 remove the dependency on ghes
Thread-Index: AQHYwTvPhGTT0EVTLkKX2LSEZ7veqK3Urj8Q
Date:   Thu, 8 Sep 2022 00:31:18 +0000
Message-ID: <MW4PR84MB184996C9B94E6F5DA3EBB11E82409@MW4PR84MB1849.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220905152439.77770-1-justin.he@arm.com>
 <20220905152439.77770-6-justin.he@arm.com>
In-Reply-To: <20220905152439.77770-6-justin.he@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69defecd-dbd4-4a8e-5101-08da913172a6
x-ms-traffictypediagnostic: PH0PR84MB1811:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zo0lW8l9WLjxJ2PNM3fAQ5oAKFyoLAY5O+h5vB7hpPS/RUtTPQ5dn4dwYtCKABZSqJiWcW+U8bkh0nb2LyPMTKvOrNaE/bHDLMxP+DbBTomm/sJstjuBzo7d0xVNPZdcZo8wMG3vqi9kKcVoXFUydiymvNMxmRNjF1191xtUVTkUWDf0IqqCFoh0ILo+oW6ktrCCjsySyUaLXXRZpaGmqvmI5Di3gGI1U/KaofEwQ4KMe5q54qr9SIg9XkdkAb47TBOqVmFwd4nJVr6SKKfNHDploPSaQ3mZrhR0Lfd4t+eC6nePMrH6xov0S2+lsX+OokwBJebkZDmAdhEXuZz0L0btbo2dGPT3RgDojxEA/AOCVq/YlS1Ljw/JH6PZ5BgRDJskjBWdZV31bQPYZ/nwPv9FPGexYbo8gsrfAjwXwNW4nkdUmO541qQxrCJ1yAzyHun6ix1ZUwDct9vnZgEYhQ424r5qyS9k0iZ3pGiNqpvW54OqdGm5VcQZIFH0Isymyj7owi/DhLyRjGyQuay5pX+u3fh9gz/yietjpPMeUZHY4AJdxl6/HRYkEUHp5MW9pBvMOKBGVvMV/toAKD4rG2JBKs49Rpj5KzXFz5MSppgz31AdODaz2n4EpLSgJbqZ1XelY7QCLChl2p3JKtg9lnJdJAy/+ml1gl5uaPHzqGW9YRmjZjCfO9hcSG178SpzSTm6iNIgyA+cR6Bg6NUuSQYBNTGjzhDXDgiKQdf+4PX47pazPU2RvJUBVGkVsN5U2h10bKffhobdTgxbtBqxPJkYNZ2XxJnl23y87QvvZKI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB1849.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(136003)(396003)(39860400002)(83380400001)(921005)(82960400001)(38070700005)(122000001)(38100700002)(55016003)(4326008)(76116006)(66946007)(66476007)(66556008)(66446008)(64756008)(8676002)(110136005)(316002)(2906002)(52536014)(8936002)(7416002)(4744005)(5660300002)(7696005)(6506007)(53546011)(26005)(9686003)(54906003)(186003)(71200400001)(41300700001)(478600001)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1Fdtw9YsS0YB8cnTovG91n53E3At8xa0dw7m3r1cNKJlrgIOAB4wRmJCdzAb?=
 =?us-ascii?Q?yqjEdQO2U8WZqyoEu0MwBkSnXBV0GLlgEh1fNl7mMzssUiSRy0eu0iAi5qGy?=
 =?us-ascii?Q?Vxyoge86SgGNRJzF7q6f19qgeCnMZ+AMBAQHjRGg6Z9pT8XOwFlXD/njNJMp?=
 =?us-ascii?Q?250H1h0wY01KbFcd/d+NXyExSsXUfrTnknkp2TVLtYRORviFg8uWGe8HZ9jd?=
 =?us-ascii?Q?SIgmKQACuGaE3kP1/wZ38+W83fKaSk2jnunCUXeVPehWq50t7oCSM/+bHjoU?=
 =?us-ascii?Q?UyU8XgfWQxC1RJrHrkfYPnpx00+y6gcV6esleK/uuFopELiK0R5yKlw3GdkT?=
 =?us-ascii?Q?TS4Pu9pCOXG0LuPViqy7kvSpyuvSBtwX3R4tOWpdwP9S+yLZedGZHi/MACPT?=
 =?us-ascii?Q?s69i4siuLj89vv0jHD2R6JhPo2GbvFJvAYJK8kRySsRlS5HeEGMgpaVS+9d5?=
 =?us-ascii?Q?5FbTfBJbJ6PtQySZtRzLGxYHmc65L7zGijoPlGPbD1/E098Qxg7WCQjpZdam?=
 =?us-ascii?Q?xHCl8EeXLRRmv5HW2frgTK03q+b1w40pOb3YKgnmzzAtuFP+14xZBsKMqocY?=
 =?us-ascii?Q?OK/KLPy3ukmEssx0GtXpQZP5b4VpimzpIN+U7iS2n7kKTQlpAUi523BCU4KS?=
 =?us-ascii?Q?IeO8KSYBCgCu55/nPhpyfvIs1HcMO+8eMhMcVfvmQm1H+ZwfLjXYmM5LAWRZ?=
 =?us-ascii?Q?jgsRh2hUEHM72C5sQHAlMvrjoOH9MvSh9kc7pcfFZcFjSJWicnSIojgw1xEM?=
 =?us-ascii?Q?Crn4I95jAC9udzsaU8dP+GYQ2aEOwG+Mg76iva8GMFDRLrGjIXh0swEbtgIL?=
 =?us-ascii?Q?ATHoxm9G19WiWs0p/mnfQ9NE1t/gQmYDK/uOwATQcPNvlXIjuK5W8aOZjS5C?=
 =?us-ascii?Q?W83cTQ11F/NkBnb03qvS6Zw+1b0vdFVsxh1xD4kLiVRxqwAJq6y1DhST63Ng?=
 =?us-ascii?Q?4hmZqfHDKN80GuC7D8FrEZLyUDJHsPkYWdwGxS69iLxOkzTDmudHkAs1dmvz?=
 =?us-ascii?Q?hh3e6BiReOHYB4zQiXNkwwVtwZYdlsGi2t+4V0bLy2Yix5nqTO10KrPogdFk?=
 =?us-ascii?Q?ruuWBTCUK4gSRuJqSeBDw6sUPSJiBv1vt/IFmC3HJmp5uNodW36eRQ2GoIbp?=
 =?us-ascii?Q?5UZVP6AoYErm9U2Oy3hWYSo2wFKHxdO6Yd1jAUM0BErzFsbVIK85hOWN1cJj?=
 =?us-ascii?Q?3HPR3CcyehgfjY4gYj0zqwUaxy3gSaswulaumjJRi6uTFqY3K2ijtnDxYd6H?=
 =?us-ascii?Q?vd5BXmptBnRF5ybKBi+4yMGc7Qcx05gBIrMHfy44HS9clP+Q8aeHVhIEJ3KY?=
 =?us-ascii?Q?/FN5iI5Pb/H4J57DOep4rpRUv9R64ojX0NkRNGBBq3szq/PtEFs+2sRDNFSM?=
 =?us-ascii?Q?DkJXyb7J+B9CgyW1jNa7pxdde7M+DmD28jh2/S1cV4jL/U59qZWZDXzS4uwN?=
 =?us-ascii?Q?Kvx8XL2qJ8NBARpW2oGLO7Eb1Rha2RyZiXkhUEJuUivr6nXNoH53/7347ALk?=
 =?us-ascii?Q?ryLdzCb8tItvh9dot0aX4DixJPLte0xYZEPEBoRVXr2tZ0h/+fHVddv07Jef?=
 =?us-ascii?Q?Dd0+kiAHu19tRDY/09zZuy74cnRsceVqu2tOCeUu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB1849.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 69defecd-dbd4-4a8e-5101-08da913172a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 00:31:18.9118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQNALoTtZYi9xm4ltvO0t//BOQIWdo78/KllyTdZgVn9s2DeHdAAPQSX6ZB3+yD+nmz7HhPOW4noZX37gf9IVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1811
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: m8ed0dglT98T6lL-UUukz1cjYd7_ayuq
X-Proofpoint-ORIG-GUID: m8ed0dglT98T6lL-UUukz1cjYd7_ayuq
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_10,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=824 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080000
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
> -void ghes_edac_unregister(struct ghes *ghes)
> +static void ghes_edac_unregister(struct ghes *ghes)
>  {
>  	struct mem_ctl_info *mci;
>  	unsigned long flags;
>=20
> -	if (!ghes_edac_force_enable)
> -		return;
> -

I am not familiar with this original check.  Assuming it is safe to
delete it now (as you mentioned in other email w/o description),
I suggest adding some description to the commit log.

At high-level, the patch looks good to me.
Acked-by: Toshi Kani <toshi.kani@hpe.com>

Toshi
