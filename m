Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DACC5A0461
	for <lists+linux-efi@lfdr.de>; Thu, 25 Aug 2022 01:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiHXXFX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 24 Aug 2022 19:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiHXXFV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 24 Aug 2022 19:05:21 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B58274DC2;
        Wed, 24 Aug 2022 16:05:17 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27ON2wtF008929;
        Wed, 24 Aug 2022 23:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=br185hFeo3GN9NsFW6byVcrCudUkHKTKn4ncsZLgEw0=;
 b=H/mCJamO5xWLRtuFRgP67z4T9drcwuche8K5xZJCGqE4eUFx1ZDPqRB3/1NTKy6uqRTP
 dE/dPaP7KTAtAKZ6MVECPSSeXHayGdakyQZg/PJ5yX2DE8gHQKsmP/DIu5mCJEs1vu4j
 7J5MF77rY/dUGZXQTZsxnhznChHGTasBXvpkUtg8Qa1K7pfj2r4pWHEHFXW1sUnqENa5
 5cpsCanzQayEUs9Uh/z50Wpz1aEASWkGsKGFI16BSIHpGTxfLNsxyvSXNdn0fpJK1gPM
 X7dKIBii/NBdRuIYYxMlWykmC/AYRecaeSKA67Pn4ZM9123mJJla+lb49oRxFfkGcmdc cA== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j5waeg0ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 23:04:35 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 5FADAD2E5;
        Wed, 24 Aug 2022 23:04:31 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 24 Aug 2022 11:04:31 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 24 Aug 2022 11:04:31 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 24 Aug 2022 23:04:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUseZlhWcXjQ1f9Gv1QCzzq1GpFfwvYAtgJjqttZiMHPjYt61AjVQ9bS6D1QuHEyoWr6yMyvwExlE9rjnO2lJ67CRhrMdofz9K/652r2Pp7wrl+2Q+3QPt+ZptwboBc6BVgUYEPdhtIisZvvyjHXmksWSAaGehSF8wdg/IzA4yGZh08ANRZ7/fK52TDVcBUxypEVFA9GILUn2yBbZo1z8UJeRiqh3l4ela5UwmfUGR0JfVE0H7DJodXiuA/VVLsEwRMAKnZFNwgk8d3SKPjtIwEOwGnlK54xEkQhhDx9uo8D+9+efsmcIzSpzbEsFvYNUTpIuulU6dhnEizBYMBLNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=br185hFeo3GN9NsFW6byVcrCudUkHKTKn4ncsZLgEw0=;
 b=GNosRtalhko/E77Oo2nxZD8fQnK26mmZl9MjOa6/eHxarzyLIUMp2k7ThuNjMBMQbFszF4Mq3Fj+ZtUippyivmrarwVa5xnqsTZKkNlv6VryneQiLl25QFRcKGtA1rfO4yFtlsU22hJrNj0K1UoQSaLgpAoChPQkiXGT8bcvMu8jzrwPkyWjhI7mDbQImGsKMmKBtLDsnKIL02ycLC3yhUU3wOdmyJiIpEuL3/d3H40dwc55OpyFAUhjhkHGEY7ndyuPx9U0L3y+D7k6WXOndDjMa1mdVSzS0Z4gpZCYLPaASXPoWRK3ESivXMXj3WkqSdxBhjya5Bzuvs8XC/dBFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4c::19) by
 SJ0PR84MB1799.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:435::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Wed, 24 Aug 2022 23:04:28 +0000
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6]) by DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6%5]) with mapi id 15.20.5546.016; Wed, 24 Aug 2022
 23:04:28 +0000
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
        "nd@arm.com" <nd@arm.com>, "Paul E. McKenney" <paulmck@kernel.org>,
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
Thread-Index: AQHYtj3CtK4qzp4YK06O7QvReAOI3K2+qefQ
Date:   Wed, 24 Aug 2022 23:04:28 +0000
Message-ID: <DM4PR84MB1853A76B1374A4BEAD8A1E3982739@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220822154048.188253-1-justin.he@arm.com>
 <20220822154048.188253-6-justin.he@arm.com>
In-Reply-To: <20220822154048.188253-6-justin.he@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28c7345c-e17a-483b-13c6-08da8624ff3b
x-ms-traffictypediagnostic: SJ0PR84MB1799:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zgYeOIuXRDaksJnWOwjKDJbLl67UW9MOJ+Z8qMRSLdtHECmW1fgW7mxckhAsLuOJ7RY8fgWhgXuKbsZOCjZkx2ORNdrVDDnr1lHmZtQ6IqXui+yRnoCoiXowP1fGixkUXuTdj9oqzy1PkQRFuT10DymKGfuSLPho4MtBo8caQ5gP5mfYOpK/tuj0140SK9B8r46BVrqswfFcjr4D4ljEPZ4hCufkgWFjiGHvBdKDbLLw6tEzOzIBvOIWYmwUM6UvZhQBNy+FmDNpU8GPbFG4MLWNkwS2wAqVjiuJYMnrEIh2LcERKZCph2Es2HZlE5wdt4Exj/KiVuWQ7+prbs0xQ4LFingwKOW/XrNfHMmFb9cV0xuf5rifWgIFFWMYioiKtQnoYY9RKfMVXJHZ1PpQFQMh6MWZE+A5gOUEzJsX84fgK+qg5FevjBhhDIpBBiKHxZL9jYYhySAFdwHXehlKnjPoJ3z+htSJKoFJlWPdrVhKTeVpSA8Q1326Xvw2LJS8CqWkQ9ciOzfGE2MZgDzyFG93mEiroS4NT77xIisNSsljvUdPybPlb/F/8S77OF4VIZ7Swiv5JVlW5PojsPxfC47cDrJ5FMpF7nKEV+gWrWjrhxhew4LjqFEf5Zd8tQ8a4ML3/cDQFDeQd/QIyif5daCLbQSrPXVR8YKGm9t6dQlnCKOPurDpE2hSmEuOvIIv4lCViBX/RN2g+cILDm9m59nL65oFXlI/M4b+9RB3gUsINT7KdRfesqlOEBJg5sGmetjrwhmxeYqA9W/rN5T2Dg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(136003)(376002)(366004)(110136005)(38100700002)(122000001)(316002)(186003)(54906003)(2906002)(7416002)(66446008)(71200400001)(4326008)(478600001)(38070700005)(64756008)(7406005)(52536014)(66476007)(8936002)(53546011)(86362001)(5660300002)(6506007)(66556008)(9686003)(66946007)(55016003)(8676002)(7696005)(82960400001)(76116006)(26005)(921005)(41300700001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XzdB2/TiutyGVpQMh9aCJQSNqSBzd7Tvry8cSt9HagvnhMYdpSvA8vC2lWfM?=
 =?us-ascii?Q?ywgtphFMQmwhjN49OYgHdgCo+1bnp0UXJq5q8ohZjKYRzgjFfh8SHcC700Vs?=
 =?us-ascii?Q?vJKzi9LiZhe6GZNnleaIe2ng+fLy+J3OyTLErdxs7JobA7+vXetefMoYZUYY?=
 =?us-ascii?Q?k7QfIKdLBClS+j9VhF/iB6aY6LXC+Ug6B0jOb8wkgWYe8cAjDUR5O3ZRL9hL?=
 =?us-ascii?Q?vUBGqHnV7sTAicGB1g1moxqTi/eN6teXidZ67usFaavbp8iqDCH8zeDhtwgk?=
 =?us-ascii?Q?vGyF8WYKx8KIG4rWr6kFl8MizHglC+A1dMeAwpFSaXPynaxIFBGz0FN/1Gho?=
 =?us-ascii?Q?bbh1GSO5xFSqumogbBcmf79bosm2kUH1LmR57+h8SNN0f/eOoS1cdQeMwXKE?=
 =?us-ascii?Q?QYVYSYVcIxMZd2Edj5JBaWYV7tBWSkZ/XEJFXK7cy65LaZ0eiU/xbySFoC9X?=
 =?us-ascii?Q?sCReXM2uyY/gY9S+h/SuuvtdOrGm6++/+FewMrKMbKl/0BJ6A0dTQuhrzQLS?=
 =?us-ascii?Q?QwIuv+LjyEAxqFL2tDQCQGk1oymYA9ETKdHu4H+4lMucyZI+k3KMu2qXcTKM?=
 =?us-ascii?Q?3qnhsEdfU1jEbQCAC0hbFGMzcltM2pjrQph1yP0ZCrSKsQ2aQR0uDszARrde?=
 =?us-ascii?Q?/9Tne9TPi+oF53IVDPuLXeYtIYoPWLvgFNvwelVi9ktwYvb5SjG7arA7e3nZ?=
 =?us-ascii?Q?GQ3bjCVmmuNau0CvsYJaHkNo76QAfe/pQgIwXnf/9HqsP5FWeieoRS8NMjhc?=
 =?us-ascii?Q?1hEF3rjPIsjy7Wz9Bq6n/WaoHZoOgK7fH1W1OxsvF5IA470X5xeeFhXCihMO?=
 =?us-ascii?Q?Byt0BjFu0H51fRh3zJt0ke2/oNPu0lMtfrDJa0xCujQbcBkVcMLcc+H3iCEk?=
 =?us-ascii?Q?rCvh873GEpLbQWb7wugIwhKCwGklUwuuvrZJZiimRBmXXlN0qatE7b8g+2te?=
 =?us-ascii?Q?PZ79QToATl+HNAazGfNSN3dB/Yz+ZsR6tzzzYOgIevyiPNn781usaP8TdPo0?=
 =?us-ascii?Q?cOwXKPOKJ7KELMQW94U/d70/0jNyQn8p/hTC1opgMRMYGfLzofdDvwZ1YD1v?=
 =?us-ascii?Q?Ue8tnM1qiNkW7MvDid4yHUp/b+SrnphV4WKJ2JUNlBZaPPAQAHHl0ROwrQT+?=
 =?us-ascii?Q?q1rRbPlHzR/Jvm1PH1qscKkY+lS2PsWRNm1YrL8JNnBUXsodBKmHQgu2IkIv?=
 =?us-ascii?Q?pkhC4EC68AsIsajuN1oBiOMckkovv3OkEY1p6VQ2JzyVUUlzj20l1+uZImMl?=
 =?us-ascii?Q?MPkCyFod4cOKSsczh4KSrmwsWLktASY9U9DAViL3HV3ka/uaAouih1iJVaGD?=
 =?us-ascii?Q?C7y7zY/FsOnFumgL1tITYQngnIhtg11jarkNTwsD8hNnERtgxHjHj/L4gAQK?=
 =?us-ascii?Q?pIuscH0hmol/YOfRIX9BKQIs6s07BtwFyXOOWwZ+K8JzP1sUvunmnjrFZqX3?=
 =?us-ascii?Q?1xXo19YTdMJn7VbIPF6f9zIyoDcGzS2Lem0V6aNcSsrXuviZc38G3WT6qk7G?=
 =?us-ascii?Q?jvlW+YMmBzEkYNTPvQkdizkLbTdlWkjhbKFFR8gF0o7aCUehbu/G9UCQG4Ey?=
 =?us-ascii?Q?ExMm8gN1wGYMVRx4wI0z4f4umYWR1z8Kz9cJE5X2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c7345c-e17a-483b-13c6-08da8624ff3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 23:04:28.4884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nobfnNppoUfGEfyJpF5aXI89jRK7RxNU08+tpJONNuR/1TLXVSmX0fo5a4lcu2DrptjzU3HrmY5tXfjlPernNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1799
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: eQT8xe2RLhK0F726wRUu52YerPmMbcdt
X-Proofpoint-GUID: eQT8xe2RLhK0F726wRUu52YerPmMbcdt
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_15,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 mlxlogscore=802 phishscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240087
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Monday, August 22, 2022 9:41 AM, Jia He wrote:
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index e17e0ee8f842..327386f3cf33 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1537,16 +1537,25 @@ static struct acpi_platform_list plat_list[] =3D =
{
>  	{ } /* End */
>  };
>=20
> -struct list_head *ghes_get_devices(void)
> +bool ghes_edac_preferred(void)
>  {
>  	int idx =3D -1;
>=20
>  	if (IS_ENABLED(CONFIG_X86)) {
>  		idx =3D acpi_match_platform_list(plat_list);
>  		if (idx < 0 && !ghes_edac_force)
> -			return NULL;
> +			return false;
>  	}
>=20
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(ghes_edac_preferred);
> +
> +struct list_head *ghes_get_devices(void)
> +{
> +	if (!ghes_edac_preferred())
> +		return NULL;
> +
>  	return &ghes_devs;
>  }

ghes_get_devices() changing multiple times in the series is=20
confusing to me.   Can you simply introduce ghes_get_devices()
and ghes_preferred() in the right state in a patch?  Perhaps,
patch #2, #5, #6 can collapse to introduce the two funcs?

The rest of patch #5 adding the call to ghes_edac_preferred()
into other edac drivers can remain as a separate patch.

Toshi
