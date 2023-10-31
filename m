Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3837DC400
	for <lists+linux-efi@lfdr.de>; Tue, 31 Oct 2023 02:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjJaByK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Oct 2023 21:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbjJaByH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 30 Oct 2023 21:54:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC91D102;
        Mon, 30 Oct 2023 18:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698717239; x=1730253239;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7r7sBM9fpeQ3s996ImKA/KC9FyHFtaTJ81Y9KIMpDAA=;
  b=e/l2ufzqK6FV6Uwzx7diio/q/vOdl7FtwVg3Uc11ZviDluPAMtHIMh3v
   uWjCw0o3Pq9Egi7i2b01j/fXPgi3TA45DVjWbcAorXimlO19E2ipVt/Sf
   /w4039IcOtbOHnBbgLgrzfqmtEB4s6uo8QcrJDrOsTtA25DneZRXxbXFP
   zzkcSdPpTNqVzVtiivNtn3CMjOcwFZv5dwJ8EoWVGHssnJEQKwv6pZ4Zu
   iWOeLwD5ZzdmeFZUM9f9Un/bHNxHkBO7EXQnxegeLaKbKKhBSgN7feefv
   e3yJOlxxTRdMTngvQ+LtyuwypZCtRGJlkoj/oNdv555KilVDKIdL/sGnF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="392057872"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="392057872"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 18:53:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="877334520"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="877334520"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 18:53:58 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 18:53:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 18:53:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 18:53:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 18:53:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMj20iSien5nNi6Ze2qc+CCPc3QQhh+aG/dYuUUuWN/dy4kr54l+UHdliAO5mXJNWQ2mujOYUfoLNFtYKjULbDMsFv+DsYHjO7z4X1jlgpdTm00ZT6maCezxKPczP9XdSFL/hg1FoGp2OWSPQaKOuISG6J4e3w/4LjQB72d9uGq7wcWn76XQ+cAXVdFACYlswz+MBqs4T+5fNB2S15/uBIo7iSOEkG2MGRrTQ8zqvc+owf8TGkH3tq6N7C7ssL2nKLFR4U8KpYzD0ujqkIrLO2yMyGbHsLfNlAYeA2ueNAkRhidodyNJaAL0QWUW0Iu3pj13V9t7P61qsvDUl2LCuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bwPTqlzj9pbOn+tlH9aSlojbBAHeLXAPMDoiOnp6TE=;
 b=f866jGXw5tOiJh3vXLXUcCfpxHT+2AqDcmqRZ41Av5xzupex41KRNblsAQ39q5kCNIWukg/JfuZN8UA+x9k5ppRuPDmlnVPbBgiF0mEnmEsN8AZp3KZm8yzXZUrIYKC0GDUgMddvZsQaT/gqL5V7h7kAWQfOIzq9+SHl0RL7IoY9uOXBtz9fL14+tB2m9iZBCi9Kcn5zPcad+PSTcNTMhagwU5K1QfHLXI0Z5pgxOp1EKjx5bPL1RJaWhmRDqiVeQeoJCqP+yhpufdKbI6+4Wy2MPk3GdDMnkzAzMcKRv34fLc5JhkDyLrQal6WsCFLQizf/9MpCOo2/ow6wJ8lK1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 BL1PR11MB5461.namprd11.prod.outlook.com (2603:10b6:208:30b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 01:53:55 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::d070:1879:5b04:5f57]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::d070:1879:5b04:5f57%4]) with mapi id 15.20.6933.028; Tue, 31 Oct 2023
 01:53:55 +0000
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
Subject: RE: [PATCH v4 2/2] riscv: Optimize bitops with Zbb extension
Thread-Topic: [PATCH v4 2/2] riscv: Optimize bitops with Zbb extension
Thread-Index: AQHaCvp2pr7eekB1vU+a3i97SbKEQ7Biy64AgABNtHA=
Date:   Tue, 31 Oct 2023 01:53:55 +0000
Message-ID: <DM8PR11MB5751DE93BE278FF01576E5A5B8A0A@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20231030063904.2116277-1-xiao.w.wang@intel.com>
 <20231030063904.2116277-3-xiao.w.wang@intel.com> <ZUAT5gKXM+pU6r3w@ghost>
In-Reply-To: <ZUAT5gKXM+pU6r3w@ghost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|BL1PR11MB5461:EE_
x-ms-office365-filtering-correlation-id: aa6bedf6-0ab5-4c80-3b8f-08dbd9b43d85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qlh7VSTOYgXWy5F/kuUDiiiPgABBVHs5C6klz1vF5MjQzC+f8c4ElHXrOIVpYDS2VPZmA/7JEOmeOKUzvKTWkAg6EeEj9orlqj9kQ0XljAWGTUwt3BpnGlZOIOg6T7XCxk9ZXLpBmc2wFXW7VB4/Dpq+nxFFOL3enTKQbgC/8fkYvdGcrNsM9oMRdgvhZZvhA1PuMUkMM6hjSEem6u1VEyWrt02iJaASDajKvVK6yNHZPeMxLF3Vd1d+cAeUG6iAi2OQd1oi0aVxaJzYQF0rVSbDO5zhR3KAlhwut5nU/+zDKE5XAeEgn1vO1hwa/1n7ah5XyloEHoG+iKxCWTtO+CeGXuQ9b8AUPs2Rbho4a6j0sJ21aamkOySZm41quAo93GvAjz9Dcd+UYudUaH8+tMskMz46+MAsmB34JVpbzikI6cnlOMs1q4XCkSVgYI2ZWwvEIxSVx6UoL8yfqP9Vz9wWUEqDdyf9NgqEiUoQYxcoC0k9yE44Uel1SiX72SOI6dUbz0+T5e5BxlxO6KCJ5d4v7NdTjw27xFWUYQy71seDAQ8Wi5wH0MIyB5J7+o9rauelWXB2eeeMg+JHUt9Bt09+NM3Wj1n+golxsKoxRvQcKRxgkr16tjtuOzozfV2ReQNOlUM921p0WOAaxySKf5NA8cp0GTjNqjwhpsK7Gpg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(39860400002)(136003)(230922051799003)(230273577357003)(230173577357003)(1800799009)(186009)(64100799003)(451199024)(76116006)(66946007)(2906002)(8676002)(4326008)(53546011)(8936002)(316002)(66476007)(66446008)(64756008)(26005)(66556008)(478600001)(41300700001)(52536014)(7416002)(5660300002)(83380400001)(7696005)(9686003)(71200400001)(38100700002)(122000001)(82960400001)(6506007)(6916009)(54906003)(86362001)(55016003)(38070700009)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?nehiyFWjJErHhnNOPqDTHhprwHSYAYGbh8vf0ivG63xr5JWOXDDionGZ?=
 =?Windows-1252?Q?d3hAVpvZiipKobikLIsbu2c3DB/sSemD/UgBuey4jTLag0rumvQlbWF7?=
 =?Windows-1252?Q?YzEOiVhHiMT0vfScoRmBun7sSgT/lSSP6MSGHYgIBbnYL9ZStOARMJ7L?=
 =?Windows-1252?Q?ilWjKMsgyA2TWGbqbsr8KgD9wwjNCtBcYkGUNukUn/Pcp5jbCl+oXBKg?=
 =?Windows-1252?Q?0PUBlCGGNmmqHzqkdzJbEuJGL3hteXek4IlSfP3VRfamBhow0GSgfv6k?=
 =?Windows-1252?Q?Q8kUoP5NhGxwkIQa1uo3hhZ+on41ViAy4E0nQOXJ/osPChejo967k9Du?=
 =?Windows-1252?Q?d1O04w9GVEYpyDB3r/sp9P/60o0nOTfYcFYVX9bTnjdWvHFiMgqUls9P?=
 =?Windows-1252?Q?k1nvsBQqlpa9phF2tg8GebFR6OvZD99xDPv0QJleI4Bpjy/YOytQUoWN?=
 =?Windows-1252?Q?BRAojZpgFPhi7SXCXYuupLb6lgXp61Za7r7I4iwgHCdWwKySsXpaWvWk?=
 =?Windows-1252?Q?ewI6W4A7nvngVzQXmYF2tombJ0pn/PVU4hPPgV5yhKPYTCYUlKqRhjbD?=
 =?Windows-1252?Q?iWMIcpStUkBWXf9q/tckTIBTYiBWsVWr0d4DVEZSS8kPkl+99u+ZULXl?=
 =?Windows-1252?Q?ITfLB1tBRBucezd05+i5QwavC6TEtiR64/0xJz6ZqvMH4Xr9RlHm67pf?=
 =?Windows-1252?Q?sAefoe5bKSOQgL89XkKKeFxCIQbsmDmMFHMNecHNFiMZ7vpADkffxUCK?=
 =?Windows-1252?Q?dV/Vx8XGADPlvoL1om3wFQ8DRHY/C2YS493frv9PUSM3SXuIvaV2a6T/?=
 =?Windows-1252?Q?QICg3+o7pJycPehLEB8nbteR63F8KX5LX0XhwW5jpRZmNl9GzpBPSVXD?=
 =?Windows-1252?Q?v//yr++RzS93CYJpTMuabRV1YPrlDDfvIY+tcp1i2kMg99/V8SJzGEfM?=
 =?Windows-1252?Q?xvAJt8RdpH2Xy3z9E+gJRQpFZKCY1l6G2mK88eRniMXx7z/Ckg6Xu8hh?=
 =?Windows-1252?Q?redSNAe15wAJCt9eYB56sXgWf3leDEPAT45whbMf298MncZV7RHetwl0?=
 =?Windows-1252?Q?23iUhl9YZSXZshh4hPGUtbU3I1XMgVdZe8vQKEcBGpv/OEl2Id/+YjkT?=
 =?Windows-1252?Q?HhWz2mBhDyzUD2kVbV300CbwEA7o/VjULaR5dIsht/vEUQA5vhE+YQ5v?=
 =?Windows-1252?Q?CeEYlkFYUPgfHr0vThpbkeiigjvesXYRSR6phiLEoJRN+Vx5NNHqXuD7?=
 =?Windows-1252?Q?v6mbyijIPOA+B81fFDg0BExExLD4ixAvMyvIpB4mgmfmLCUFHsx+pMYx?=
 =?Windows-1252?Q?kKEtfxQ2zKcRaofAR4eNbymi4TwkXBysACT7uqxKLi1jCKX1qwXm/EV8?=
 =?Windows-1252?Q?IFtJzUSoyCsdLbxHtvcZADQomkIbwCxUu0Nulltn2qkZsGmbaiUClY/h?=
 =?Windows-1252?Q?8CXTXe/DjuHKBVatUXTtWUIaHk1YyCHMY4bem/s+WtbwusRunHThRpJQ?=
 =?Windows-1252?Q?IO9l7BthaEZmrv0qgf0Q9pLhTxDhulBcS0OMo9BbMCrtc/cn1GFkyNrw?=
 =?Windows-1252?Q?eEisZwicUQPIsSbmcsTjy6f3jax4S3CCvpP4C8z0CCvI14Yqz1yEKfiC?=
 =?Windows-1252?Q?qalvYODPgh+sEBFUnDcry5EZ6mQJjiy7SjTgDmWj7V1lwPiQ18W28fKE?=
 =?Windows-1252?Q?m1Q5e2iXg2cz+XX6KDoSfaLhbx5M4HB8?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6bedf6-0ab5-4c80-3b8f-08dbd9b43d85
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 01:53:55.2375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9mAqZPlopUC087ph5ma/maeENBUTsnsBM/+aOM56YbYUL/QBg/18YATs7rvjPdfmCPKdnHrZSlYoasgAAeCRAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5461
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> -----Original Message-----
> From: Charlie Jenkins <charlie@rivosinc.com>
> Sent: Tuesday, October 31, 2023 4:37 AM
> To: Wang, Xiao W <xiao.w.wang@intel.com>
> Cc: paul.walmsley@sifive.com; palmer@dabbelt.com;
> aou@eecs.berkeley.edu; ardb@kernel.org; anup@brainfault.org; Li, Haicheng
> <haicheng.li@intel.com>; ajones@ventanamicro.com; Liu, Yujie
> <yujie.liu@intel.com>; linux-riscv@lists.infradead.org; linux-
> efi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v4 2/2] riscv: Optimize bitops with Zbb extension
>=20
> On Mon, Oct 30, 2023 at 02:39:04PM +0800, Xiao Wang wrote:
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
> >  arch/riscv/include/asm/bitops.h       | 255 +++++++++++++++++++++++++-
> >  drivers/bitopstest/Kconfig            |   1 +
> >  drivers/firmware/efi/libstub/Makefile |   2 +-
> >  3 files changed, 254 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/bitops.h
> b/arch/riscv/include/asm/bitops.h
> > index 3540b690944b..ef35c9ebc2ed 100644
> > --- a/arch/riscv/include/asm/bitops.h
> > +++ b/arch/riscv/include/asm/bitops.h
> > @@ -15,13 +15,262 @@
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
>=20
> On this and following asm blocks, checkpatch outputs:  "Lines should not
> end with a '('".

I did below check, but I got no warning.
# ./scripts/checkpatch.pl v4-0002-riscv-Optimize-bitops-with-Zbb-extension.=
patch
total: 0 errors, 0 warnings, 280 lines checked
May I know how you do the check?
BTW, I see arch/riscv/include/asm/jump_label.h and arch/riscv/include/asm/c=
pufeature.h have similar code.

>=20
> > +	asm volatile (
> > +		".option push\n"
> > +		".option arch,+zbb\n"
> > +		"ctz %0, %1\n"
> > +		".option pop\n"
> > +		: "=3Dr" (word) : "r" (word) :);
> > +
> > +	return word;
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
> > +	if (!x)
> > +		return 0;
> > +
> > +	asm_volatile_goto(
> > +		ALTERNATIVE("j %l[legacy]", "nop", 0, RISCV_ISA_EXT_ZBB, 1)
> > +		: : : : legacy);
> > +
> > +	asm volatile (
> > +		".option push\n"
> > +		".option arch,+zbb\n"
> > +		CTZW "%0, %1\n"
> > +		".option pop\n"
> > +		: "=3Dr" (r) : "r" (x) :);
> > +
> > +	return r + 1;
> > +
> > +legacy:
> > +	r =3D 1;
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
> > +	if (!x)
> > +		return 0;
> > +
> > +	asm_volatile_goto(
> > +		ALTERNATIVE("j %l[legacy]", "nop", 0, RISCV_ISA_EXT_ZBB, 1)
> > +		: : : : legacy);
> > +
> > +	asm volatile (
> > +		".option push\n"
> > +		".option arch,+zbb\n"
> > +		CLZW "%0, %1\n"
> > +		".option pop\n"
> > +		: "=3Dr" (r) : "r" (x) :);
> > +
> > +	return 32 - r;
> > +
> > +legacy:
> > +	r =3D 32;
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
>=20
> Checkpath complains: "Macro argument reuse 'x' - possible side-effects"
>=20

Ditto.

> > +#endif /* !defined(CONFIG_RISCV_ISA_ZBB) || defined(NO_ALTERNATIVE)
> */
> > +
> > +#include <asm-generic/bitops/ffz.h>
> >  #include <asm-generic/bitops/fls64.h>
> >  #include <asm-generic/bitops/sched.h>
> > -#include <asm-generic/bitops/ffs.h>
> >
> >  #include <asm-generic/bitops/hweight.h>
> >
> > diff --git a/drivers/bitopstest/Kconfig b/drivers/bitopstest/Kconfig
> > index d0e2af4b801e..6ef6dcd41d49 100644
> > --- a/drivers/bitopstest/Kconfig
> > +++ b/drivers/bitopstest/Kconfig
> > @@ -1,6 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  menuconfig BITOPSTEST
> >  	tristate "self test for bitops optimization"
> > +	default y
> >  	help
> >  	  Enable this to test the bitops APIs.
>=20
> Is this a test you wanted to add? The source code isn't included.

Sorry, I mistakenly did a "git add" for my local test. Will drop it.

BRs,
Xiao

>=20
> - Charlie
>=20
> >
> > diff --git a/drivers/firmware/efi/libstub/Makefile
> b/drivers/firmware/efi/libstub/Makefile
> > index a1157c2a7170..d68cacd4e3af 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -28,7 +28,7 @@ cflags-$(CONFIG_ARM)		+=3D -
> DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
> >  				   -DEFI_HAVE_MEMCHR -
> DEFI_HAVE_STRRCHR \
> >  				   -DEFI_HAVE_STRCMP -fno-builtin -fpic \
> >  				   $(call cc-option,-mno-single-pic-base)
> > -cflags-$(CONFIG_RISCV)		+=3D -fpic
> > +cflags-$(CONFIG_RISCV)		+=3D -fpic -DNO_ALTERNATIVE
> >  cflags-$(CONFIG_LOONGARCH)	+=3D -fpie
> >
> >  cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)	+=3D -
> I$(srctree)/scripts/dtc/libfdt
> > --
> > 2.25.1
> >
