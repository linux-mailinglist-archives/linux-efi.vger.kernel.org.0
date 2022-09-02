Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309135AB587
	for <lists+linux-efi@lfdr.de>; Fri,  2 Sep 2022 17:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237283AbiIBPna (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Sep 2022 11:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbiIBPnJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Sep 2022 11:43:09 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39F9D290E;
        Fri,  2 Sep 2022 08:31:30 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282FGXsj021007;
        Fri, 2 Sep 2022 15:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=4JHxuRAwKJEoAOGWXpAsRMAsXT01F89yLFEdf6ep2E4=;
 b=Y4VvRHbDB0woL5H+25h9GE0Eg16WmbQ1hMSt0XG/yYmq875uKVf8qEHbIJiZobt2vZhz
 TrQfXaZw+n3qeqh4jaAwiQtaLCFeHWE4aAcLMbdTfsA5hXLfduPKK0BDNZf5v+FASo06
 LCIglZnLqcR5VJYbBAzK9AKDFWbaDQQRUOw89yFLlRfBwMcsL3qpxnJdnZ90rJHQalYx
 Ep2e+MA2lzkrsxCe+vrVHoE4iPJ1R/HhtXZ4eAoRPph34yfYmUiV77v/qOzgXgUhKh80
 2ItioI5AsApv5lBtSLnUg6jIZh2BstF4A0wlSnX52lW83umURMZ6EBY+8OytccJH5pt3 lQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3jbmaxg41r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 15:31:04 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 5C48580173B;
        Fri,  2 Sep 2022 15:31:03 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 2 Sep 2022 03:31:00 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 2 Sep 2022 03:31:00 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 2 Sep 2022 03:31:00 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRUU8c+QzTYpGC5AtBD0EwAaI1BYdGWTA2SBdlo9eHqAYriH9RxinLERyAIOSBLPNFqYTAaldPpwBvxUKuE93BMZn1CAzJQsB7DqWOUilG+t+1PA+GVPaDYcSFsGUyRPabQ6lSyfHJx/3h/CA+qjzAPeQMYUUgA6ceHFBAQsDftNlMQ5TL5/qPnWaWHponIVcO3CZYT/cSgLOTSt/UHby6AJAHAYFksXTmBF6kHvdA4gC73RESQjbyz9eo43bnUTAQ1XmMlk1JfZC4ki1wmEJCnycbA+Bc+ReXc81v3n+njqjEX5TgGN3ajfaqm8lZdb11U0iq2VcxYjw2OKgzdrzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JHxuRAwKJEoAOGWXpAsRMAsXT01F89yLFEdf6ep2E4=;
 b=gCcyzAj8hw6Cn7zHVuayUqXem2eGMkCwNM8/CNdbQ9ys6YnHgE1xT0M0nXjpbcTAiLwkrQPNLrnyG7DUkmUZu8HxefcUWbJvq8wF/lAZ0RvdYADETvOwPbZ8/47uHaKNgJFggCorAESQLpTmNHuq7No7/XxMgYFNWOlrt3b6QRZ/Aa8rKrE5w93A6/HABzB2MllExO1dcOI9f3GeFes44c6hcSjOdGlscNnZ8Q0Hw15NIvrphve8Hbw3Uf2TIj9kP3yo6pBNpoKx45ciRbKU5oWbQAAgSkXInkMfwcs5G347ExTE1fLqIYUt9krzS5mE80E07rtKbVN9zT1Qs1eAVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4c::19) by
 MW5PR84MB1713.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 15:30:58 +0000
Received: from DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6]) by DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2033:298b:4062:29e6%4]) with mapi id 15.20.5566.021; Fri, 2 Sep 2022
 15:30:58 +0000
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
Subject: RE: [PATCH v4 4/8] ghes: Introduce a helper ghes_edac_preferred()
Thread-Topic: [PATCH v4 4/8] ghes: Introduce a helper ghes_edac_preferred()
Thread-Index: AQHYvQ0fYOUHlI6mjUq1nFSoDPM5TK3MQ3pg
Date:   Fri, 2 Sep 2022 15:30:58 +0000
Message-ID: <DM4PR84MB185370AC62413398C1E32003827A9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220831074027.13849-1-justin.he@arm.com>
 <20220831074027.13849-5-justin.he@arm.com>
In-Reply-To: <20220831074027.13849-5-justin.he@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c73bf6af-6d08-4de6-ccc0-08da8cf82260
x-ms-traffictypediagnostic: MW5PR84MB1713:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2GjlAZFp9COmxa9Iv7vM0Fb5UbIejpkJojPBDxIZt3aMIZsgVd+y2xvq4k5yfMAU3IZs5bgpvwzi2BiqwAxc+8GoGJ3+KlzPdDk6GzA6WsMZiPIBqzr0NkYBqiHPQrGftEwFJVc/on0P9URkwZ0yEkKY41JtHte5urAqQVGWhxVi1T2WgjYfCMhDPd7qqJMKRCTcdzMZt2Ge9brKokGmdntSywoXJMGV8zdi+h7LEyfjg6Zkc2EJM9S7qfryZwKh7CSyXNfeiL5vd9boE8IPKBTC1QkySrcsc92+C5NYBM7YSTRLL6L6k0ZvelQ4r5mru1JxM0yuCW8pgbEU24Id00TCMJkAdAA60cpwaiZpKJP2RBZ/JknFhhRM5RqXlXw5FdTev8uEk1eotTdinC8p2/c0u05P6+IKZuwMNJ/muEkQ+JL+8eueDkz1H5fNktxXdFZa4MsFmPNdSTaHbvHCFS55MV+l+uyVAAtiervXNC8E6qzaJkUBxG2L/WT1589BkkcrHW3hXEHgpGH5eq32urnqEslnjk8m9m1BjjqzThjORA9+p0JuyqLBMXFrfMBySatYgObu4sxIBGCQoQjA7J4e8cgY0FeYiFofeWex3Fc5rDzLQaBmE7VJ/wKzE3bFU1gGIYL9N9IQORj/rUmzET6goujdSCFzKZkK5NbW5nX9KQ7i1PzKjvE3H74YbatpqN1SAwPXkQTxSKi2SXx7FHqMs3ak5y3Ab5KVWiGq7r88+Sntda0VBf32gzgvE4oIx94shnZHrf9Dz7gRAqddmt1TEQuZaaQNpbY/JfIJb3U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(39860400002)(396003)(376002)(66476007)(54906003)(66446008)(38100700002)(76116006)(4326008)(71200400001)(110136005)(66946007)(66556008)(64756008)(478600001)(316002)(8676002)(7416002)(5660300002)(38070700005)(33656002)(8936002)(52536014)(86362001)(186003)(41300700001)(82960400001)(26005)(55016003)(4744005)(122000001)(921005)(53546011)(2906002)(9686003)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7UE7T9kvTTmOykixExBNwMcAzJ7EcxsJ/8O5wBYNbK4Z/T/1ofPfR77Om8w2?=
 =?us-ascii?Q?zySFfTP9Vw1sy6Hjo2TGuUYJCiCsqooVNovhnZrysN+HAKIOTXKMNB5wL8z5?=
 =?us-ascii?Q?3Ry3Nfx8bOMFoyMbLzYpFSy+kf/G/QB83IlGatgRzNhX3uZ/Crv52ykRKl4Z?=
 =?us-ascii?Q?YDBkH+O5QF9Vvom/wL16C8wlWQy+WaWX7HXUAQbtlZmS7tw4Jq5DXFpN4fsw?=
 =?us-ascii?Q?qcata3QY+VSO3ZLM8wp4Q3Z3Afkt/J1eKnlt7nLkZ7OXWir/k46pN+DsybYR?=
 =?us-ascii?Q?4VLZfS/ZFWDNZ9cULS/APUm9U+h6jKlIDycxi2k5+c9qb0GjmcMZnCt62fMa?=
 =?us-ascii?Q?RwzoxJA8qP6P9TOc2vm7zvkcsQQ8X/EEX5EIOTSXZ1CNli302CYfs1dEPVWO?=
 =?us-ascii?Q?xBQWM45yWnAJPaYZvQX4DCEnXsnumqsx8oNvIPb7HOutpbHRteA5DXB0DcT8?=
 =?us-ascii?Q?9+Xz/dw8F+is6MXpLU0ivaGyWEDx8NSuhwOUSSRR8bmSUN7Lc1SLvvg2GrUK?=
 =?us-ascii?Q?SbzTg4qwbb6l0xs88xyoldtTo9QaRjHIV6KFpEIrqD7iP/NkyVNXXD7JP1Bu?=
 =?us-ascii?Q?C/G2024nkwvT4HCPe3csRrSud7acPVoiejj/hWCnDXEa+20dcRDnqQt+vSHS?=
 =?us-ascii?Q?GnHUTvrs2Pt5THUQAHmGc8lEjDFX5wreko1bvgGHVgae+yNGmwQB/WFxjCRr?=
 =?us-ascii?Q?kX6vSNPkJYYKukQoRCB7zUlWoz1Go8jj1JxvNTcJPtVWtlArixTsKFEemDXf?=
 =?us-ascii?Q?WEelUKn8KLGaJQa734VdlTqwG0RGr4/P+OjT6jaFmh2aHm27hbzooCdQ4V8n?=
 =?us-ascii?Q?JXpia33OrhSt4Dd1+KFBG0K1XMJdBbIHnbJqMYdWBjuASMFDw6sgFU50KUFR?=
 =?us-ascii?Q?tlsr326uU39pFl82wWgMUfzPZHTUr8jfBTDbW8wBlwMgwlj/jvf2UfIdQspE?=
 =?us-ascii?Q?8g75J0iCarB5rfppTiZJQX4zliOzHf2J3mnl0PZgx1T8ckg5ytLnrbnClVhX?=
 =?us-ascii?Q?BVnmzcpjcqQmHi9BPjKUS/os/iDM0ZMLrb6dOTmGyxQtgMtcxWhO5WtPWeH3?=
 =?us-ascii?Q?FtAhPP/35iZAC8U+PM/VggBJDtJiYgOtirzMmJCKfDaOKkUP1Vqtwt0ywkuF?=
 =?us-ascii?Q?hnLh9DxbeJWKHZDCOrt/OvPzqppFn3vt4TrtQmAbTxtDRicBN3ZPWyARh0ta?=
 =?us-ascii?Q?mnz2TWXeIg1ToFWNOVrfOwczPY+yNiQen3TwN1XQPYKM5OxC4CaeyrMRzUX2?=
 =?us-ascii?Q?722FxuWQugOd7iNs8XfuSALf/ICR0DVGx/ezRhCWFZih/J0v/EIGBAbZs0Jx?=
 =?us-ascii?Q?uaGx/+2xY6cPDAzxOPEn29HZqjP/RLv51XaL4fEfKbjPzlh98EOECUOMW8dg?=
 =?us-ascii?Q?XztYm2lSYAncoSQ61VBnwOs3ABO2tw4t0lIDxpi3zAVuoRJuCZfJoQgTA38j?=
 =?us-ascii?Q?i788QCRUu29NgJjezHMLXwjchPDqYiDd5jlIP7iUfplcW2gu6rRvqlhvkvRT?=
 =?us-ascii?Q?paKyP8iC+4+pr3P/fy4qckdF0+JHFs+DABRsCjbk/ahvQgm6li1E0EQrNSRC?=
 =?us-ascii?Q?k3sFH/eNdjMOlJib5s2OLaDO+SxFfu5inlw+w/7A?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c73bf6af-6d08-4de6-ccc0-08da8cf82260
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 15:30:58.2581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bQFqcvUATds56yZpCUbOIYM2MMFEPbO7KGN8MnJa4XCzqpHm4CuKEDMSRwzIBEN41x7cjHfb+fk1MDd0uD3LnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1713
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: lsK3Z5uLMknGFZVrECqFt4cKbV2s1P_9
X-Proofpoint-ORIG-GUID: lsK3Z5uLMknGFZVrECqFt4cKbV2s1P_9
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 mlxlogscore=646 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209020075
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
> Introduce a flag ghes_present to differentiate between the system ROM
> really not offering GHES vs. the ghes module not running. ghes-present
> is latched on ghes_probe() and never unlatched since ACPI GHES table
> is static.
>=20
> Introduce a helper ghes_edac_preferred() and it is true if the
> platform-check passes.

I'd suggest to rephase a bit, something like:
=3D=3D
Introduce a helper ghes_edac_preferred(), which returns true when
ACPI GHES table is present and the platform-check passes on the system.
ghes_present is set once in ghes_probe() since ACPI GHES table is static.
=3D=3D

Otherwise, the patch looks good to me. =20
Reviewed-by: Toshi Kani <toshi.kani@hpe.com>

Toshi
