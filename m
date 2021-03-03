Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C3232C98D
	for <lists+linux-efi@lfdr.de>; Thu,  4 Mar 2021 02:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242007AbhCDBJ0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Mar 2021 20:09:26 -0500
Received: from mail-eopbgr760090.outbound.protection.outlook.com ([40.107.76.90]:46649
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1377136AbhCCTsA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 3 Mar 2021 14:48:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqf0oBSoCmeSna+tGRkDjvSnocqJ1iNLd9KBSbS/pE4gGmdQZElm2kxykeTTf0xfKgZ6hxbokQu3GUm3HCCushSDP6klRzXfvrgNFV+rA8Z8bLg+UMG5uyhz42XyBeTXdMgNqYBn9UW5+d6i4oPpN4On23XqbWY4xgByY1Say20bJse/MaijkIg7fYkq5KUyXHiTZZXzmyERbBWSwohdDa/tTrX9IhLGATaxaE9v1BlMfLbwMXVsj4rp274Bbw4OVfl9QrhA26QcBe1ZhgoqGdt91BVXrTFOLI9Pz9dlE/ObHH3+OgpuXKfNe3pBHQg3nFn0fB5rzdxwcsInQYIPMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9t7X1lUzsjHd9Tq8lJqR9/fEv9hAlcNifRVc9UB02I=;
 b=m2iibOLUHd2Tb8S+6Zn8P42YGCzzRezip3adn1LmE6io+TTecbhhKJF2010EZYUOiu39njG7TaRjozj4ABDyAHlPTpsFAeFlnGeqs/yjPgqJ//LV3OX40bb6EeY/N/p5DNFsE1Q6RU2jqxIRot27xBO4hkVzkA9v2aWBJX1senVQ3s78LyC1GFkLcEVN6w7Ws29z9ztjlH7yCOEjCCARmK4afS6eDBOHprykxzuaC/1bKJLkTE9LKtKgc3oaKaMOk7bZ9TJz7o+qdC/m7pos0vf/EKlk1/ILyoixH8Gc0lCDB6MbX1x3Wa6aW+5XSaOtvXmaL2dKNrsEOu/AoyluUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9t7X1lUzsjHd9Tq8lJqR9/fEv9hAlcNifRVc9UB02I=;
 b=JeyxAa4Kk13tEUSXayfeVRJwxDXk3PEYplSHBv1HKn2tFYloBpJna4J4dv18hGROl2d1oU94cvFV+wMyiyEqex6/o3JkYIU0MLeD9yhed8jKtbpSf912PIw32hAVp5wIdbfTBQVSaG+hBxjEUvTBdhQcmD+XqebukHntvlIT5tQ=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN6PR2101MB1133.namprd21.prod.outlook.com
 (2603:10b6:805:4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.8; Wed, 3 Mar
 2021 19:29:12 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::c01:cceb:3ece:dd61]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::c01:cceb:3ece:dd61%8]) with mapi id 15.20.3912.011; Wed, 3 Mar 2021
 19:29:12 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>
CC:     "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH v8 2/6] arm64: hyperv: Add Hyper-V clocksource/clockevent
 support
Thread-Topic: [PATCH v8 2/6] arm64: hyperv: Add Hyper-V clocksource/clockevent
 support
Thread-Index: AQHXDwVnPBVXgTtwVUeaXba0vhRD16pyp5PQ
Date:   Wed, 3 Mar 2021 19:29:12 +0000
Message-ID: <SN4PR2101MB0880CD584840B9E87AF5C9F4C0989@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <1614649360-5087-1-git-send-email-mikelley@microsoft.com>
 <1614649360-5087-3-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1614649360-5087-3-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:3132:9d16:d3c9:b7bf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d759f2f6-cea0-4e73-bc53-08d8de7aa038
x-ms-traffictypediagnostic: SN6PR2101MB1133:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SN6PR2101MB1133FF8FAC4B422A83EE3CB7C0989@SN6PR2101MB1133.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6UcNHFz75qeB+LwOLS3fQhesoAPwGCdc6fu6dxPGi7ApEhuQqQ2aoZv8k0C2KMKvLHfrr26KRUSkJIJlRM8ZcnaV7Hh/aqENcg+XRgNVeARTaBfFvQ4Ea8ZQxxEZwggEcjclsRbwf7eblylwyW6v9TB30w7FpC2Sbx073MvYVZ1pB7zDxVqmsUQA+45zQONl2C2y0O4r7lOXCN0skl+CkAAJGHtsPTB8QmqZlwcJohXYfK8+jxVpHVHPuuLX8hmwhBsCxejhXjV/nXSXq57vRix95TlDQK1AhCRHsaszlGktGW3Hr5GWAiCwWR++Lav8Jh2+CFMkB3PILQ7OWyZh9hj4+Jun2Yqax502BFOSbAigF9tnQVXbtLT5dhGXsUW8F0dr25WDtORHJjylbHDhGWMMqKi75EYcuPSMOKF13HZLEia3GnL5teAjBzUiIhB+Ip1xOWiTF3Jx1bbi57ZSgs1VAUGwdnxziUpIZbtfooYy9c7niJ3fPy6uQq2bGNSZfb0eoq81Dltc8/IabVKcJWrWT+e6uNXb/LaTJSHM+/qFV1Ss8AlqAxroT5dc7sa7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(71200400001)(66556008)(6862004)(7696005)(10290500003)(2906002)(76116006)(6506007)(66446008)(86362001)(8990500004)(54906003)(66476007)(6636002)(107886003)(64756008)(52536014)(316002)(9686003)(55016002)(186003)(5660300002)(7416002)(4744005)(478600001)(8676002)(8936002)(82950400001)(82960400001)(66946007)(33656002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dwAgAwwktq+s9cGMJI8Vn7bxOnOQOgfpv4CCrlIVO8HHhUJueiB5SyUCjcHX?=
 =?us-ascii?Q?UAzA2WwVttqg67JaZFSp0sMZwgbi1dg+Y6aF6sMPXoy5nrILQycO7vlOyYXb?=
 =?us-ascii?Q?r8ckTxx4cYLPnQIUrJ+U4a51ixWrcbIEJmguwYAa1yfhXnhdqdDuxCaq3i6B?=
 =?us-ascii?Q?X3yWu5bAGU34x9uzNdyhdOx/0OYqhlYoyL4DsbRMATr2UYmHcrtVUfcnm1Ze?=
 =?us-ascii?Q?GuWJ3rbsIvru8BrBChlZE5G04G3/WWZFtB0WnngJITEAN7nn++ecr3I2tLho?=
 =?us-ascii?Q?oBJR3hCfNcUg7BXKBUxLFnVw2iAZh5fAltcHuL2122VeKXpNHUvlJImrLvoa?=
 =?us-ascii?Q?s1MKP2nBoJ7YKeqMiZsUSGilSVc4eUyLyDnAmApXQ18fPMYSYtK6iHH/Nfes?=
 =?us-ascii?Q?ougXYU8w9GuT3csZhtYEhOKMPQbduCGPdKNWQCF0Fcq2S1gtuBf/lMXtbH4p?=
 =?us-ascii?Q?cA8/F/6ejb0C1edH4iZn2WxkWLAVr5qoLKl6Fbfqf4/wjy5cp7RuWKpS90DE?=
 =?us-ascii?Q?DuqFaTMMC9TIky/DdqcGxyJxEfnJNkBpbN5wj6Pra5gTG3D2SgAXlZzsBGaT?=
 =?us-ascii?Q?L3UpwdeEUOe2AWNwcAjr7GSfDh9po8TKeH1jHORNxVamWBwlJJ+K2HeNddrR?=
 =?us-ascii?Q?jsyaEprOmLPoNCJuXqA5LNCB/kZ15VYPtoKM3jPcM30EyDPpUOcwXbdOS4QT?=
 =?us-ascii?Q?z5NtcGctMlXAQYekXYX+icOKZ/TpzlyxlLdgIomyLopRk8dAa73CrBxxAXJD?=
 =?us-ascii?Q?gh4RTFSulbbzZFU/QKhtWxroD8PjnTZBo7REH4HxnskZcquCQoxb+1BVoG+H?=
 =?us-ascii?Q?2knGYSMIaeqK5W3N1JUAldWyB+ctuyr9jkO2OIsGpiqMjFsLKMn8ZsW2Kd9M?=
 =?us-ascii?Q?n7os28gapI95eFXHLFkXmP0DH+VTrM5aAQo15d1HSel9XcChn+O3LUXyidPU?=
 =?us-ascii?Q?yV+8yfHZ8Kx/b3OytBmuntH6RU0XRtVx+srIEqQsfiMcuAkNaR11BYMQ9ZIq?=
 =?us-ascii?Q?DSEEoCRQYHFZtnSDMxFjR3HWKvYFSzlXE2MH76/gyqczwVbyZ9CCJjHciW8p?=
 =?us-ascii?Q?HcyMdIYscWMepBumTr2ogRmD41r6Fz1vxo1Frkc8OAGyEN5bSsbERz8rQ5s1?=
 =?us-ascii?Q?Bq6/fWNdhz+f8LyauSRaOx/R1AY3VA6d4UCRfhBAnm/ENO8JK7gJpCzz94QU?=
 =?us-ascii?Q?kBHM8VOLZCQUlDqF+iLO6zbUBQNRuJyiRKulG8Z/yg8FM5l+EP4ZWaZqWlDP?=
 =?us-ascii?Q?E2qPIO1xNKWSv3tAL5k4tByj8eCkggtQ9eyjNLt3KWAZL4hbjSWhLMLyFP+m?=
 =?us-ascii?Q?SJ5V+bu4GJegYG6aMGNi35aYJZ3epJoCrEAVGL4QW9SDMChG7q8w+bnDKIH1?=
 =?us-ascii?Q?6P3e6n8F5eIgXoscn8dQ10aBV8OJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d759f2f6-cea0-4e73-bc53-08d8de7aa038
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 19:29:12.7255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ECsDtkaKLAYvs4HxhY3tN2k8BUV2Qe2Mj73DSjuYq5jB6esx4wd9C9DafFJftKC7XP7VlYV4IELCExAA7IXilTGNkjEV7L1QViLpO/5SK5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1133
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> +/* Define the interrupt ID used by STIMER0 Direct Mode interrupts. This
> + * value can't come from ACPI tables because it is needed before the
> + * Linux ACPI subsystem is initialized.
> + */
> +#define HYPERV_STIMER0_VECTOR	31
nit: On x64, this is defined in HEX

> +
> +	return 0;
> +}
> +TIMER_ACPI_DECLARE(hyperv, ACPI_SIG_GTDT, hyperv_timer_init);
> --
> 1.8.3.1

Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>

