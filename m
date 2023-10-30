Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B2A7DB203
	for <lists+linux-efi@lfdr.de>; Mon, 30 Oct 2023 03:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjJ3CMO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 29 Oct 2023 22:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjJ3CMO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 29 Oct 2023 22:12:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D7593;
        Sun, 29 Oct 2023 19:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698631932; x=1730167932;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7/yfviQway9pcIFyNlE/9FRZndPxMDTh69WBGvFnKZU=;
  b=kFgRr2uHzXHO/+Sl1GM/TAVEJpSetAUNH+p8BJ3YrjzbamIGRTT1CqP3
   rAUg8xiOpGqbpAnA2iJyY21ag6/wYY0OjLkFOSX+ae9RBFglnsm93zqvx
   tIdt23Le62eN6pJojvCGF8Cm7lTxvGBLK30W1Rh6spVZLBM1YQtjtroAY
   bvC305VtAE1I6yfY+cgcDd97CXD4GH/dVaywRpee/POIHK22RgzQq/M1P
   SgqYQn4lkx8Mx8hjVgww3wYWiFfI7+yG7Za+IxWbpIgHa4MHq/5uzVwrz
   tpmX+AMDMl8dVdg8Z3IhocHOhIXJEEN/2+kUguUSRuaCpACpa0KQQZwKt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="861618"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="861618"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 19:12:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="763774753"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="763774753"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2023 19:12:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 29 Oct 2023 19:12:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 29 Oct 2023 19:12:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 29 Oct 2023 19:12:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPYyZB3O7Pgc0FsGW4YuC70mfZaa72IW6tbU+7dgp1zmyQlnvyAlhGUs/UYWdHO/8thCG2rVDOLtU2gaV8y0p8XR0eP7eFuviKzLB9UTUCMMwy6/sXJk1uCsbmXf4ZqbUsQpFPARsiB8WwRRj9fn7Ue5/YwYhRca3CVe9OH2IxuMQUalm0XMhl01TfBIEjfvR8Q5MFgNw5Umk9S6O2b8nKSnftns7VjCmVKGnODdEJ7LhW8V8wQXVbpJvp0Y0bUy3x7KnXQkViTDy3TUP6KMkl6nwIHO5dyOX1d2jSoR4Y56PewCynm34JhCB623yQOvY6P3O3YSOA3m3hUd5e16Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLP2j6Aiv35JhogaOSwGd+hlUK1doHLSkXqJcVmfqb0=;
 b=PS5tlqnjpSqHQcsFHZ5YDY2Bfc8i0mG7mQse8QOd1JA0ETf4JhHt3lsrk9D0h0+woAS1PU00Lk+JxY/edf4ITwNyDFOtUJ/cANIZ8poYCzinD6Ed9jkK2KJCTgKVyW/dSiTDbyba1IcwDMYLYn6UXCVLavuDbcmrYBFWGBDqJPSPg73Rh46HSLAOZmd8mGYwKC0CCxMObarygRdSnus0P+KsIEetmzUBAkWd39PhqyLRxzcgxfC6cRp0XOD11C7Ik8lWAQXvF65lT8/79ZWY8QdkTP4DTIzU/AUe2d2w3iHWq++QX1DsIzw2Qk4xbhEIEPilIT2+ahSiMRxAcgh6Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 SJ0PR11MB4847.namprd11.prod.outlook.com (2603:10b6:a03:2d9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.27; Mon, 30 Oct 2023 02:12:07 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::d070:1879:5b04:5f57]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::d070:1879:5b04:5f57%4]) with mapi id 15.20.6933.027; Mon, 30 Oct 2023
 02:12:07 +0000
From:   "Wang, Xiao W" <xiao.w.wang@intel.com>
To:     Charlie Jenkins <charlie@rivosinc.com>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "Li, Haicheng" <haicheng.li@intel.com>,
        "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
        "Liu, Yujie" <yujie.liu@intel.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] riscv: Optimize bitops with Zbb extension
Thread-Topic: [PATCH v3 2/2] riscv: Optimize bitops with Zbb extension
Thread-Index: AQHZ8F1FzuY28oBr70GM2ry9gyuC7LBdW8yAgARp9YA=
Date:   Mon, 30 Oct 2023 02:12:07 +0000
Message-ID: <DM8PR11MB575198F5F23671E5B1E63F83B8A1A@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20230926094655.3102758-1-xiao.w.wang@intel.com>
 <20230926094655.3102758-3-xiao.w.wang@intel.com> <ZTtXp/jhzvjGqBTT@ghost>
In-Reply-To: <ZTtXp/jhzvjGqBTT@ghost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|SJ0PR11MB4847:EE_
x-ms-office365-filtering-correlation-id: 3b438066-f0df-40f3-1c8b-08dbd8ed9e33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7JFl+4lqRiBXzEDKPwYjLaJtDR4wCeFEpubV0zcbP8qaqyKtErQdzMUM/neR1uhT29mT2a5//GbWX5mxEX0V4EyCc0GOEjZ86I3b9bJrYbOsb9aB6hI+1AahegVtHnRDjNZ06hkuPY4t+DLYaoLbkfCgMGhtDEVKraDS9ChAQ97IbpJ/Rrq5qdSthPIPc6rw0LdDbntQkhz7EEDL9TKGhDP9jM+/D+MdRA/gOslVRUWNjB45DDLPxz+wAHUX4vrUoqhnYolB826t8yCyT7O/pUHtYa7DU5iLObqhvMibbuj5ulKWn0wzwj2QNBBOZzbzbYwZOPTTmXk7d+yLvdlAXiJNHhJRP7GW8o4yyHL6ppJDIG01CI5lEfWvNyFlgz/BHfn6K4dT/x/RpCnAeKLtE6Il5b/PrVYqMXs51mz7jS2aW3aGPdvYhJg6efUyh2RthAIfjxVcClNyqolDrAc7Itjps8pb4EMwxYFrtuod2Twqlly5Q6sVG+aPRjOdP6jcP6WU0LDlqdsnyKgo9f0BYsFNFnSG60LXZFH8MW2JrfxRkbfM8lOECNqJsPOwXOcR1mludfnhSGzgzY5rUsORV5dsHJvPBz9WHIrDMpJgxligDRI7m+oBvAXMfjuHTPfX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(5660300002)(33656002)(7696005)(38070700009)(26005)(6506007)(9686003)(71200400001)(53546011)(83380400001)(52536014)(8936002)(8676002)(122000001)(38100700002)(55016003)(86362001)(478600001)(54906003)(66556008)(2906002)(76116006)(66946007)(66476007)(7416002)(316002)(64756008)(6916009)(66446008)(82960400001)(41300700001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?nTE0b8Cf50M4jzPTPCtLCinnFxsQjAdKQQoEJLgas+sz9srStwdYt77d?=
 =?Windows-1252?Q?MtvU1BvNtv/Hrdy9q5dvDvCYrhK6Z1FV0AKsIwmP4fPmr/g+lPiZrp99?=
 =?Windows-1252?Q?Xc6uPmfv9jtxJIxSwV90bcuNqwbhO1DaBYDBk/XWl7pu4eeojfKXVxpR?=
 =?Windows-1252?Q?vWBTmEJScJUpmSsT5LPhF73TiLU2SEAB7g2HCpXBeu8DaE7wCdlPDLM5?=
 =?Windows-1252?Q?uQHazKBQU6cFOoAQu4JBQuPej6fXqTkPUANgb9Lnxuz7DputbSbXjpCX?=
 =?Windows-1252?Q?+j986W3aeXLSRt1wuunpxlBiT44ATf9UZ6253K8YznCfq/0zpLf0DFo5?=
 =?Windows-1252?Q?eCMCAVjKxjWxE5XpiW5CvKjlU2xunQQd9Iv/jqKG/uW8OevGvOuUo5Zm?=
 =?Windows-1252?Q?uM6MUcSavuSGZHznOHPSFmEj3Bg1iy44clsFnj2y7Glanyz3iLuIcINb?=
 =?Windows-1252?Q?mzFpWz7WaNBlqzythgPBLQCKtWEub6O64fOMFa1Lgsri4/0w1bBwAhWW?=
 =?Windows-1252?Q?XBL2/tkSUNxXanaE9v25RNk3L4RcHFqLaVLVglRL3ny/l54BR8p2nD4N?=
 =?Windows-1252?Q?d05MzSf3hckTue/vC2b8Qwz0qxGSRxhNkjKNvZSvjba5okFvWJZ7aB/l?=
 =?Windows-1252?Q?RKOD2C/PVJWOSrUmEb0McLfN7zACDf9/8fUpaPDczhKKr+rOcGUW/tEa?=
 =?Windows-1252?Q?UpcCiqzFuB9tZQOkaH+BfOWZGPG78aahVU2JiwExSWr1rKYmQxkhawMj?=
 =?Windows-1252?Q?LUfch+xpG6nPX3gNR7grQ97n1Vu6Xo7DyNA9iIBMhk8ILHx3PSaLU21M?=
 =?Windows-1252?Q?HO1y03SLJT0voY2ro9CFy0RMCC9N2Qg8LBHTJmGzKLk1cB0Cex8ny14b?=
 =?Windows-1252?Q?Rcea8TChwuAO98HMjx1e0q0aWmKMg6diZfWwAxHIt4BVyn6/BUgAGLjp?=
 =?Windows-1252?Q?py+ClbfAMTvt5n3REg28hPuUx5ld/OjWrcSv3qWgk/nyLoEYwQwszkwp?=
 =?Windows-1252?Q?R/kOh94CwaZxgGPWp/mIYr30iEhsu3oS+6pvKf2CrBSof9AL6upeajm3?=
 =?Windows-1252?Q?q8u140EFrYFXbASLMcE+hQ6uBsfTjMTDOW9qxlO0btPFfnVMXNw12veQ?=
 =?Windows-1252?Q?Y4FhQ8blSwlq0br/+x8Z1yidCCHOS+ZQWuP+filnoPGxAFOTiJxMeV/G?=
 =?Windows-1252?Q?M49HE97BXNcjpGY0k2vYx4JOgoGV50uACYZQ2mBSX91ruAfgwY2gdGSM?=
 =?Windows-1252?Q?dpii/hdLc3oDXvQVo3rN6WSuo1gaCDsrqw4mWXIzVqIjE+LT1WbVxPf5?=
 =?Windows-1252?Q?VnmtBo0387W69XTdi+sZMyfu5+iU09yQ2GSdQSA32BaJaTsVcFbWt3DF?=
 =?Windows-1252?Q?gZuF0w12e4pcnNzhP2ZO1bO70cHXAcfgbbRMI4HcfJZM4C/VyWEqnOOI?=
 =?Windows-1252?Q?mJbkUwjhZpanEauBMmKsSIFVSHFCabUdT4EI7VZWd9xxF4hij6t2jpyA?=
 =?Windows-1252?Q?I0IhtF9HrU/tm9lvT+6Yuo8dK2cR633bvfG2rEY38Kl2wwMvKkdUdOUz?=
 =?Windows-1252?Q?ID02zSeuzyNe8p8dcYsILEqpMwkrkvJcNXGOyO0YWAPBoAeYctN42eSy?=
 =?Windows-1252?Q?K6aIhpxUanwf1TwlkLY/hGc1WWMhBil1FTTE6Q9TOFZqomUs4RJEgr7w?=
 =?Windows-1252?Q?CrRBIW2QZtQOMivCcAroJHHsebz83HTN?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b438066-f0df-40f3-1c8b-08dbd8ed9e33
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 02:12:07.5629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pm39tmo8yGolbNUSxwzB3P8p1uYonoAYFMhQE5zwYamEW/hUKR5RqFc2YPZTwGhtOD3m7e9qNUAxze/F0TcNtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4847
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> -----Original Message-----
> From: Charlie Jenkins <charlie@rivosinc.com>
> Sent: Friday, October 27, 2023 2:25 PM
> To: Wang, Xiao W <xiao.w.wang@intel.com>
> Cc: paul.walmsley@sifive.com; palmer@dabbelt.com;
> aou@eecs.berkeley.edu; ardb@kernel.org; anup@brainfault.org; Li, Haicheng
> <haicheng.li@intel.com>; ajones@ventanamicro.com; Liu, Yujie
> <yujie.liu@intel.com>; linux-riscv@lists.infradead.org; linux-
> efi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3 2/2] riscv: Optimize bitops with Zbb extension
>=20
> On Tue, Sep 26, 2023 at 05:46:55PM +0800, Xiao Wang wrote:
> > This patch leverages the alternative mechanism to dynamically optimize
> > bitops (including __ffs, __fls, ffs, fls) with Zbb instructions. When
> > Zbb ext is not supported by the runtime CPU, legacy implementation is
> > used. If Zbb is supported, then the optimized variants will be selected
> > via alternative patching.
> >
> > The legacy bitops support is taken from the generic C implementation as
> > fallback.
> >
> > If the parameter is a build-time constant, we leverage compiler builtin=
 to
> > calculate the result directly, this approach is inspired by x86 bitops
> > implementation.
> >
> > EFI stub runs before the kernel, so alternative mechanism should not be
> > used there, this patch introduces a macro NO_ALTERNATIVE for this
> purpose.
> >
> > Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> > ---
> >  arch/riscv/include/asm/bitops.h       | 266 +++++++++++++++++++++++++-
> >  drivers/firmware/efi/libstub/Makefile |   2 +-
> >  2 files changed, 264 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/bitops.h
> b/arch/riscv/include/asm/bitops.h
> > index 3540b690944b..c97e774cb647 100644
> > --- a/arch/riscv/include/asm/bitops.h
> > +++ b/arch/riscv/include/asm/bitops.h
> > @@ -15,13 +15,273 @@
> >  #include <asm/barrier.h>
> >  #include <asm/bitsperlong.h>
> >
> > +#if !defined(CONFIG_RISCV_ISA_ZBB) || defined(NO_ALTERNATIVE)
> >  #include <asm-generic/bitops/__ffs.h>
> > -#include <asm-generic/bitops/ffz.h>
> > -#include <asm-generic/bitops/fls.h>
> >  #include <asm-generic/bitops/__fls.h>
> > +#include <asm-generic/bitops/ffs.h>
> > +#include <asm-generic/bitops/fls.h>
> > +
> > +#else
> > +#include <asm/alternative-macros.h>
> > +#include <asm/hwcap.h>
> > +
> > +#if (BITS_PER_LONG =3D=3D 64)
> > +#define CTZW	"ctzw "
> > +#define CLZW	"clzw "
> > +#elif (BITS_PER_LONG =3D=3D 32)
> > +#define CTZW	"ctz "
> > +#define CLZW	"clz "
> > +#else
> > +#error "Unexpected BITS_PER_LONG"
> > +#endif
> > +
> > +static __always_inline unsigned long variable__ffs(unsigned long word)
> > +{
> > +	int num;
> > +
> > +	asm_volatile_goto(
> > +		ALTERNATIVE("j %l[legacy]", "nop", 0, RISCV_ISA_EXT_ZBB, 1)
> > +		: : : : legacy);
> > +
> > +	asm volatile (
> > +		".option push\n"
> > +		".option arch,+zbb\n"
> > +		"ctz %0, %1\n"
> > +		".option pop\n"
> > +		: "=3Dr" (word) : "r" (word) :);
> > +
> > +	return word;
>=20
> That's so clean!
>=20
> > +
> > +legacy:
> > +	num =3D 0;
> > +#if BITS_PER_LONG =3D=3D 64
> > +	if ((word & 0xffffffff) =3D=3D 0) {
> > +		num +=3D 32;
> > +		word >>=3D 32;
> > +	}
> > +#endif
> > +	if ((word & 0xffff) =3D=3D 0) {
> > +		num +=3D 16;
> > +		word >>=3D 16;
> > +	}
> > +	if ((word & 0xff) =3D=3D 0) {
> > +		num +=3D 8;
> > +		word >>=3D 8;
> > +	}
> > +	if ((word & 0xf) =3D=3D 0) {
> > +		num +=3D 4;
> > +		word >>=3D 4;
> > +	}
> > +	if ((word & 0x3) =3D=3D 0) {
> > +		num +=3D 2;
> > +		word >>=3D 2;
> > +	}
> > +	if ((word & 0x1) =3D=3D 0)
> > +		num +=3D 1;
> > +	return num;
> > +}
> > +
> > +/**
> > + * __ffs - find first set bit in a long word
> > + * @word: The word to search
> > + *
> > + * Undefined if no set bit exists, so code should check against 0 firs=
t.
> > + */
> > +#define __ffs(word)				\
> > +	(__builtin_constant_p(word) ?		\
> > +	 (unsigned long)__builtin_ctzl(word) :	\
> > +	 variable__ffs(word))
> > +
> > +static __always_inline unsigned long variable__fls(unsigned long word)
> > +{
> > +	int num;
> > +
> > +	asm_volatile_goto(
> > +		ALTERNATIVE("j %l[legacy]", "nop", 0, RISCV_ISA_EXT_ZBB, 1)
> > +		: : : : legacy);
> > +
> > +	asm volatile (
> > +		".option push\n"
> > +		".option arch,+zbb\n"
> > +		"clz %0, %1\n"
> > +		".option pop\n"
> > +		: "=3Dr" (word) : "r" (word) :);
> > +
> > +	return BITS_PER_LONG - 1 - word;
> > +
> > +legacy:
> > +	num =3D BITS_PER_LONG - 1;
> > +#if BITS_PER_LONG =3D=3D 64
> > +	if (!(word & (~0ul << 32))) {
> > +		num -=3D 32;
> > +		word <<=3D 32;
> > +	}
> > +#endif
> > +	if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
> > +		num -=3D 16;
> > +		word <<=3D 16;
> > +	}
> > +	if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
> > +		num -=3D 8;
> > +		word <<=3D 8;
> > +	}
> > +	if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
> > +		num -=3D 4;
> > +		word <<=3D 4;
> > +	}
> > +	if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
> > +		num -=3D 2;
> > +		word <<=3D 2;
> > +	}
> > +	if (!(word & (~0ul << (BITS_PER_LONG-1))))
> > +		num -=3D 1;
> > +	return num;
> > +}
> > +
> > +/**
> > + * __fls - find last set bit in a long word
> > + * @word: the word to search
> > + *
> > + * Undefined if no set bit exists, so code should check against 0 firs=
t.
> > + */
> > +#define __fls(word)							\
> > +	(__builtin_constant_p(word) ?					\
> > +	 (unsigned long)(BITS_PER_LONG - 1 - __builtin_clzl(word)) :	\
> > +	 variable__fls(word))
> > +
> > +static __always_inline int variable_ffs(int x)
> > +{
> > +	int r;
> > +
> > +	asm_volatile_goto(
> > +		ALTERNATIVE("j %l[legacy]", "nop", 0, RISCV_ISA_EXT_ZBB, 1)
> > +		: : : : legacy);
> > +
> > +	asm volatile (
> > +		".option push\n"
> > +		".option arch,+zbb\n"
> > +		"bnez %1, 1f\n"
> > +		"li %0, 0\n"
> > +		"j 2f\n"
> > +		"1:\n"
> > +		CTZW "%0, %1\n"
> > +		"addi %0, %0, 1\n"
> > +		"2:\n"
> > +		".option pop\n"
> > +		: "=3Dr" (r) : "r" (x) :);
> > +
> > +	return r;
> > +
>=20
> I generally like to move as much code out of asm as possible. You are
> also able to remove one of the branches if you rearrange as follows:
>=20
> if (!x)
> 	return 0;
>=20
> asm volatile (
> 	".option push\n"
>         ".option arch,+zbb\n"
>         CTZW "%0, %1\n"
>         ".option pop\n"
>         : "=3Dr" (r) : "r" (x) :);
>=20
> return r + 1;
>=20
> You could then also extract out the "if (!x)" at the beginning of the
> legacy section at put it at the top of the function.
>=20

Agree, less asm code will be more reader friendly. And your sample code loo=
ks
nice, thanks for the suggestion. Will do the adjustment in next version.

> > +legacy:
> > +	r =3D 1;
> > +	if (!x)
> > +		return 0;
> > +	if (!(x & 0xffff)) {
> > +		x >>=3D 16;
> > +		r +=3D 16;
> > +	}
> > +	if (!(x & 0xff)) {
> > +		x >>=3D 8;
> > +		r +=3D 8;
> > +	}
> > +	if (!(x & 0xf)) {
> > +		x >>=3D 4;
> > +		r +=3D 4;
> > +	}
> > +	if (!(x & 3)) {
> > +		x >>=3D 2;
> > +		r +=3D 2;
> > +	}
> > +	if (!(x & 1)) {
> > +		x >>=3D 1;
> > +		r +=3D 1;
> > +	}
> > +	return r;
> > +}
> > +
> > +/**
> > + * ffs - find first set bit in a word
> > + * @x: the word to search
> > + *
> > + * This is defined the same way as the libc and compiler builtin ffs r=
outines.
> > + *
> > + * ffs(value) returns 0 if value is 0 or the position of the first set=
 bit if
> > + * value is nonzero. The first (least significant) bit is at position =
1.
> > + */
> > +#define ffs(x) (__builtin_constant_p(x) ? __builtin_ffs(x) : variable_=
ffs(x))
> > +
> > +static __always_inline int variable_fls(unsigned int x)
> > +{
> > +	int r;
> > +
> > +	asm_volatile_goto(
> > +		ALTERNATIVE("j %l[legacy]", "nop", 0, RISCV_ISA_EXT_ZBB, 1)
> > +		: : : : legacy);
> > +
> > +	asm volatile (
> > +		".option push\n"
> > +		".option arch,+zbb\n"
> > +		"bnez %1, 1f\n"
> > +		"li %0, 0\n"
> > +		"j 2f\n"
> > +		"1:\n"
> > +		CLZW "%0, %1\n"
> > +		"neg %0, %0\n"
> > +		"addi %0, %0, 32\n"
> > +		"2:\n"
> > +		".option pop\n"
> > +		: "=3Dr" (r) : "r" (x) :);
> > +
> > +	return r;
> > +
>=20
> Same comment as above but with appropriate changes.

Will refine it in next version.

>=20
> > +legacy:
> > +	r =3D 32;
> > +	if (!x)
> > +		return 0;
> > +	if (!(x & 0xffff0000u)) {
> > +		x <<=3D 16;
> > +		r -=3D 16;
> > +	}
> > +	if (!(x & 0xff000000u)) {
> > +		x <<=3D 8;
> > +		r -=3D 8;
> > +	}
> > +	if (!(x & 0xf0000000u)) {
> > +		x <<=3D 4;
> > +		r -=3D 4;
> > +	}
> > +	if (!(x & 0xc0000000u)) {
> > +		x <<=3D 2;
> > +		r -=3D 2;
> > +	}
> > +	if (!(x & 0x80000000u)) {
> > +		x <<=3D 1;
> > +		r -=3D 1;
> > +	}
> > +	return r;
> > +}
> > +
> > +/**
> > + * fls - find last set bit in a word
> > + * @x: the word to search
> > + *
> > + * This is defined in a similar way as ffs, but returns the position o=
f the most
> > + * significant set bit.
> > + *
> > + * fls(value) returns 0 if value is 0 or the position of the last set =
bit if
> > + * value is nonzero. The last (most significant) bit is at position 32=
.
> > + */
> > +#define fls(x)
> 	\
> > +	(__builtin_constant_p(x) ?					\
> > +	 (int)(((x) !=3D 0) ?						\
> > +	  (sizeof(unsigned int) * 8 - __builtin_clz(x)) : 0) :		\
> > +	 variable_fls(x))
> > +
> > +#endif
>=20
> As a nit, it's nice when large #ifdef blocks have a comment like
>=20
> /* !defined(CONFIG_RISCV_ISA_ZBB) || defined(NO_ALTERNATIVE) */
>=20

Yes, I will add it in next version. Thanks for the comments.

BRs,
Xiao

> Overall great changes, just that small optimization to get rid of the
> jump.
>=20
> - Charlie
>=20
> > +
> > +#include <asm-generic/bitops/ffz.h>
> >  #include <asm-generic/bitops/fls64.h>
> >  #include <asm-generic/bitops/sched.h>
> > -#include <asm-generic/bitops/ffs.h>
> >
> >  #include <asm-generic/bitops/hweight.h>
> >
