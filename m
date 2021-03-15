Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBDB33C728
	for <lists+linux-efi@lfdr.de>; Mon, 15 Mar 2021 20:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhCOTzF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Mar 2021 15:55:05 -0400
Received: from mail-bn8nam12on2090.outbound.protection.outlook.com ([40.107.237.90]:11773
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232491AbhCOTyy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 15 Mar 2021 15:54:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBD4OHcVChBH4WqNwE448Ol6Um7CASG1PZjZBIhwLNgYqaby3fSjB0O06CHjzC7+8L2Lr5t2q/+PGzlLPEU5Veaaaavdx4B2gsGZwYWllXt4CMYfP6uUbjoCMRbyrBKlvqGdCN216TIVcHCeSDs6KPg7f4vdiKgooE6MJukL52ogQH9K/PELPmO/kR11qZDK37gy/fvpY4XsgSm4QkDtPyXO+HJh5DEFPSsdq841W++31iPp1A6fFJ6340QDC240MYpijI6KdktVGDuMZriX3P8gg5m9DzsH3GRUSMxA52lXKHXVdPdBHAal8z/F87Oqazve+lQxoIfZRXRXxrIAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfRaIzVqPVUPdRwEgiB5HF9OfGrqVAE6vzWbjOtZkdw=;
 b=gAEz4LsZ3pDcfa8pklOcSR+RJXU3caN4g+iBv5rZ7IBlOMkEVamQsoQSdEP1mSqAGsDcLBnZjF1UPiKJgbnrjvhnh9ALqPQ6D6JtnquM5ngTE6Febex+dFW++ZLfLUrCssZVdlGEaahVFGwCgA9k9a/zjjn7FbWPGhLVQNijURjn/JMOjl4Ahh6hgua7BeR4we8OdQZ4tEsg5a8qg4JU/LBuucB0I9WbHU3xIq3aY0Ky9OPOVWEtxfqpSrT9ZNUPP+c7PGO7tmhrvqtH3YbwjdXpz5bva0mNiTIIe3ObmvINtTK9YCNVoVloTwQzSKgAb0+ZSQxeAcctzz86hmlMaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfRaIzVqPVUPdRwEgiB5HF9OfGrqVAE6vzWbjOtZkdw=;
 b=V+LaULpIPI94WpACet1UDnqRn9tO5RzzW6LEyNC3i5ogmyiCb9n2gO4w/bX564TFEOKvgRsRgYtxpLwCR0zG0q2PpAy0X0ScR0zuOcr+fr/rjOMMu/HcxJUvCU/Mf41e8I9USeu1fF/abxNaiC4FDRAQ0cg/kxMJR1vU51gY7KE=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SA0PR21MB2009.namprd21.prod.outlook.com
 (2603:10b6:806:132::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11; Mon, 15 Mar
 2021 19:54:52 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::9c4:80e2:3dca:bbeb]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::9c4:80e2:3dca:bbeb%3]) with mapi id 15.20.3955.011; Mon, 15 Mar 2021
 19:54:52 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
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
CC:     Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH v9 5/7] arm64: hyperv: Initialize hypervisor on boot
Thread-Topic: [PATCH v9 5/7] arm64: hyperv: Initialize hypervisor on boot
Thread-Index: AQHXFFV2mbhnb+E9ikC4/apxk9hKaqqFgJjg
Date:   Mon, 15 Mar 2021 19:54:52 +0000
Message-ID: <SN4PR2101MB08808F8FBD9C234C9D025392C06C9@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <1615233439-23346-1-git-send-email-mikelley@microsoft.com>
 <1615233439-23346-6-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1615233439-23346-6-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:148:effd:e189:3730]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 06b4aa22-3b71-4c86-d104-08d8e7ec3300
x-ms-traffictypediagnostic: SA0PR21MB2009:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SA0PR21MB2009F3E48239190F1EC273EFC06C9@SA0PR21MB2009.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s7a+ghG9NjJOSPvt2oP8Fn31I2CH+S4EYRdkUDFt5ogjiu0gEiARAz+N7gJQpmILtrzG32Mzz+OOMg0RNN2aaCUwaQgcMBi0kYuF+gDli/0GvXKQYzzBvQF+mKSjj8WhYes0qCa5cPOfJRxLHWxs5f0YTUwAZSARVZWcF/S6YaXZuSse6WpjArjDpX1xK21xICaOW72oxHMJY7SqRHuKJe1uDAoXw1nzwrrydhvpe09NY52KqHnTRX8jiqI1TmPcrVqBpWXQ7fTDWXRkiLnJDRdLPGSEtgNKiIMzdbFonxiqDSTgYuZgt0Tcu3ibmIAUBN40J+j0tIJHFZ/y63eq1ZjuMz/ZnhrXPVyugUuGK/zBSk4CybsdVULPM2cwkVLRKjecG1DFW36zXk1NdWTyF9LekO0VIdCjf9DgDwYaG5Vz3ESsHpM7Bf+fmhSUTR6DghBVGafLJ0FPQJ2SJNKp2sZkIRwnOi/6iPGmM3xKI0m4/KYtbWYWn+RuWZTvTBcBBVetE3poGuEEzP/O2/zoHClAI6DtkmYgR39tWfr0eLGf9RZlcTASsVl+tb2Kg43DyA62E0sQY+xEPMaMXglRRYrV5gboMpzNKym7nubFOAY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(4326008)(8936002)(7696005)(66556008)(921005)(4744005)(66946007)(76116006)(9686003)(2906002)(110136005)(66476007)(66446008)(33656002)(186003)(6506007)(64756008)(107886003)(10290500003)(7416002)(5660300002)(478600001)(8990500004)(52536014)(55016002)(83380400001)(316002)(82960400001)(71200400001)(6636002)(86362001)(82950400001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?93ZfhUpuhTqWm5Ya04yB6lvnXHx/bb+8em9zrvYeVT7goYHT+aHkrCj/3WY2?=
 =?us-ascii?Q?lWXRYN/33QQUbLOow558SXrbJD+UVwFuQr0ku1cMKDRpYwTEW5/1m9hRRBPV?=
 =?us-ascii?Q?FJDylqR+pfTZvL3xAAc3O4kpXQzXaflqQ0G9DbuF5twFacNMwmU83qtqhO+F?=
 =?us-ascii?Q?Q7oeFpzrBUDYls7oPGdcUbXSeYln1xp0HycIAc9Lyde1PPD6TXeUPNJEhcor?=
 =?us-ascii?Q?qwauBmB1wChvDDusqrKDBzd/8mjQwBukmPh+GfjSJP3lA2fMT1RFRMbeeYGE?=
 =?us-ascii?Q?l1KqCGm+KUbfNHNmACgh0rZTsRtkKXLvE1fg69LZp0MPsJ4BGaJQc3x8MfZe?=
 =?us-ascii?Q?D6dg8PknCDU23v5Y/BWHFbYWJomIp6sRebwMRogPF7ZOahYN8KsUw+j0GArx?=
 =?us-ascii?Q?7Mb59y18x5FGdeUXcXyXORHpIMrWXKDB9dYGA4QeTX6ogDEbvcSfjh1mBugp?=
 =?us-ascii?Q?FlfE6NRQBBsC790L7vRB/wFxU0VW3F50uj2Uj2w2RgOKShTmUXCK/mae+4bA?=
 =?us-ascii?Q?AFXvObtc4peuRU2R7Ad5A2WqnlHQzN3BqZRnb4kVS41TFzk8YHnkXKtO7DuU?=
 =?us-ascii?Q?L2hMVRx+9AKcrHs9fTE197trIPTd3R5YGyDoAFXTuNaWmbfPpneprEIHMXbQ?=
 =?us-ascii?Q?ujdl1tH7yIGLkz2DuFjr47QeGDiDIZ+avbzec6mHT1wwojQZHyi0W9HY9nP9?=
 =?us-ascii?Q?7fKR0YX0KEdD5MXbF/hu46sfErgf/OYpxWtIE86HSAlXRxHWQNp6IXi4ZrBy?=
 =?us-ascii?Q?QQlhdOy8yU9Gl+TVD9uQHLbJ7v45OE2Up5Cmkt8pZ9lXytmJbjC9xpeTux0P?=
 =?us-ascii?Q?qan/nxRcKubwc0vJh3HnPvVn9YnNUa3MW+1XOSziueK4pL/J5/kVl2YAUcLi?=
 =?us-ascii?Q?E3/1KsICcOwiXymr8lksoNNi9PaU16mliPZMML+u8Yw/INx8FbeZvb8iMmX9?=
 =?us-ascii?Q?JYnmGGrbGA8ki7gdHfVwl4b9xwZOoLtzllPkp+hsY5eQb2rrwfDE2CsHxjgN?=
 =?us-ascii?Q?x8cXl0LoxFdmE9S025WdiYyarws2JFbwb+EzDA6BmJf8IHakSeY0rjhVWl3v?=
 =?us-ascii?Q?ELOOX3x5Lsjmjnkso/NaVBtKef+iWYxcXs8ksDYEEpVW3pjuF+36nB7lPYhL?=
 =?us-ascii?Q?R5Rg01Wm2WRBPikgfXiEbwAYszPhzAhAd+xCbGAGoGHOIpCYv9YmKNMnflRs?=
 =?us-ascii?Q?aVxaWk/s03n8mX5gOCSXl+g+QiXBGp4+Sui9z+xRXzuvssFwhxX08XE+9JhO?=
 =?us-ascii?Q?nWM33Rwfe+o8d+BxPjvNCfdVDo1Vhw96IoiE+6R0TLg7Bl+DKnz4enwmt0e2?=
 =?us-ascii?Q?RnUZq3qsDl0K08a6wyVVBfbhLvxFHgPjccvpB2G/3NX0VGUkZOO4AFhy72Yq?=
 =?us-ascii?Q?MSy5rn0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b4aa22-3b71-4c86-d104-08d8e7ec3300
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 19:54:52.5135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GKcYZeIeGb/I09bCYEypRVbcD2svEl8K5GXElNy5PBC5zXCU4TH3brC6gl9GqFTbtfTb42b1tOxtE3ZejrJmNbo3SU5D4QzOveuToqQ/w6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB2009
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

>  static int num_standard_resources;
> @@ -340,6 +341,9 @@ void __init __no_sanitize_address setup_arch(char **c=
mdline_p)
>  	if (acpi_disabled)
>  		unflatten_device_tree();
>=20
> +	/* Do after acpi_boot_table_init() so local FADT is available */
> +	hyperv_early_init();
> +
>  	bootmem_init();
>=20
>  	kasan_init();
> --
> 1.8.3.1

Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
