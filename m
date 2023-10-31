Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15657DC7B0
	for <lists+linux-efi@lfdr.de>; Tue, 31 Oct 2023 08:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343804AbjJaHyV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Oct 2023 03:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343788AbjJaHyS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Oct 2023 03:54:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE75DB;
        Tue, 31 Oct 2023 00:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698738852; x=1730274852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xN51CM09J6iiCjc32Yasf35DOisKTuCsqH+zHVd4erY=;
  b=itWmYCJqL6XK9sYKI91eNpc+noUPSZXNeg9TQEjA0Fu9aTkkbSyNZFfD
   incvx1PfruafMou1rPz1UCFPbdZVloBHPxOFc8Ek1NvT/lwj/daUhGB7c
   qwV6W0Jpcv9YXgyAr2kSSpXx2qEFprrsZOen8hOJUmq64vYDtFXwxOV0y
   rz4ckLGQ2l4boUnbE9YZjoSF5Ubz/nNaJX99ZwBuaXDsfviO1Dy3MceHt
   TPrI7BrBk3ciZ+H5DJMJod5b8zYy6xP/QKpQevHM9MJTBuLZ1B/o2tvxG
   F+ITnbOMJIU5WWYYq1CR6FRXc5/UtME17GRklippAqhM8WVxsjyrHqwJg
   A==;
X-CSE-ConnectionGUID: LPH+QcWOTpS555ipnBfRWA==
X-CSE-MsgGUID: 0Qv2u934SCCmsMjxrHIzVg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="asc'?scan'208";a="178052118"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Oct 2023 00:54:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 31 Oct 2023 00:53:17 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 31 Oct 2023 00:53:15 -0700
Date:   Tue, 31 Oct 2023 07:52:50 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Charlie Jenkins <charlie@rivosinc.com>
CC:     "Wang, Xiao W" <xiao.w.wang@intel.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
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
Subject: Re: [PATCH v4 2/2] riscv: Optimize bitops with Zbb extension
Message-ID: <20231031-triage-glacial-d70f5951627e@wendy>
References: <20231030063904.2116277-1-xiao.w.wang@intel.com>
 <20231030063904.2116277-3-xiao.w.wang@intel.com>
 <ZUAT5gKXM+pU6r3w@ghost>
 <DM8PR11MB5751DE93BE278FF01576E5A5B8A0A@DM8PR11MB5751.namprd11.prod.outlook.com>
 <ZUBgHC1GBm/Jg+cy@ghost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3v+8nSO/BFqyKTLR"
Content-Disposition: inline
In-Reply-To: <ZUBgHC1GBm/Jg+cy@ghost>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

--3v+8nSO/BFqyKTLR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > > +static __always_inline unsigned long variable__ffs(unsigned long w=
ord)
> > > > +{
> > > > +	int num;
> > > > +
> > > > +	asm_volatile_goto(
> > > > +		ALTERNATIVE("j %l[legacy]", "nop", 0, RISCV_ISA_EXT_ZBB, 1)
> > > > +		: : : : legacy);
> > > > +
> > >=20
> > > On this and following asm blocks, checkpatch outputs:  "Lines should =
not
> > > end with a '('".
> >=20
> > I did below check, but I got no warning.
> > # ./scripts/checkpatch.pl v4-0002-riscv-Optimize-bitops-with-Zbb-extens=
ion.patch
> > total: 0 errors, 0 warnings, 280 lines checked
> > May I know how you do the check?
> > BTW, I see arch/riscv/include/asm/jump_label.h and arch/riscv/include/a=
sm/cpufeature.h have similar code.
>=20
> I normally use the --strict flag since that is what the Patchwork server
> uses.

FWIW, checkpatch output does require human interpretation. It is only a
"dumb" perl script, and particularly for asm stuff the complaints can
often be ignored. IMO, this is one of those times.

--3v+8nSO/BFqyKTLR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUCyTgAKCRB4tDGHoIJi
0lb5AQCTfhMacWVDaEEfgJBvcrswUdOTbdqr3jTISqjE8bOYMgD+IZQdBokuYmL2
ontBt5Lb+1jxFiabOCOk+tl9dAAW5Qs=
=HvTx
-----END PGP SIGNATURE-----

--3v+8nSO/BFqyKTLR--
