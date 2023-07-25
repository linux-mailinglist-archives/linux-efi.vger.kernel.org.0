Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1FE760B38
	for <lists+linux-efi@lfdr.de>; Tue, 25 Jul 2023 09:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjGYHMW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Jul 2023 03:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGYHMV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Jul 2023 03:12:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1022BD;
        Tue, 25 Jul 2023 00:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690269141; x=1721805141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bFFMQtUbkfGkBIZKnBOwBMrcXWpHq+8AmjNjOfszGlU=;
  b=ADXm3fz6lWTAlGalSxTHYhHkCzTyMKhtAdVOsGrk2R+AwcC9FSPOqLvu
   KX59cea3YW2v3ZYvX31bgv70qt4YBUS4bC7hC3a3WH5+ZMq3jsve/uxrv
   Ubsxx+40tGJICuxdmqPFXqOQfdIuTDh3Hnaw3bHvNBJ/yC2PR6zfTlQ47
   vZDELiPD2n1BzaW2BLYZuU7ksJWTwBv744Dmn7sJZLNwCsQn93vYLyWtE
   yPeW7D1Og4bpzJLfEe6FIfDzMBTin8fiYapHyU3U9xHt1gnie23qGp9jU
   9/ttpHZrIReNI06vmU77/5/70b1lT1FyV6NCxu+v1HT/s7Naaf2X7g/x+
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="asc'?scan'208";a="225784961"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2023 00:12:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 25 Jul 2023 00:12:19 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 25 Jul 2023 00:12:17 -0700
Date:   Tue, 25 Jul 2023 08:11:43 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-efi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v6 2/5] riscv: Dump out kernel offset information on panic
Message-ID: <20230725-clunky-violet-22e909b65bcf@wendy>
References: <20230722123850.634544-1-alexghiti@rivosinc.com>
 <20230722123850.634544-3-alexghiti@rivosinc.com>
 <20230724-fineness-sectional-8cdd1e4bbff2@wendy>
 <CAHVXubhVOpdZhmENkNbavAYGVZB47K9Q_4GN6RZ+rCex4uBb5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ug5/aA5lWs5nDlds"
Content-Disposition: inline
In-Reply-To: <CAHVXubhVOpdZhmENkNbavAYGVZB47K9Q_4GN6RZ+rCex4uBb5g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

--Ug5/aA5lWs5nDlds
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 09:05:37AM +0200, Alexandre Ghiti wrote:
> Hi Conor,
>=20
> On Mon, Jul 24, 2023 at 4:20=E2=80=AFPM Conor Dooley <conor.dooley@microc=
hip.com> wrote:
> >
> > Hey Alex,
> >
> > On Sat, Jul 22, 2023 at 02:38:47PM +0200, Alexandre Ghiti wrote:
> > > Dump out the KASLR virtual kernel offset when panic to help debug ker=
nel.
> > >
> > > Signed-off-by: Zong Li <zong.li@sifive.com>
> >
> > Either you're missing a Co-developed-by: or the author of this patch is
> > incorrect.
>=20
> Ok, I thought it would work this way, Zong first did something similar
> a few years ago, so we need his name here. @Palmer Dabbelt if no other
> changes are needed, do you mind replacing the SoB with a
> Co-developed-by?

You can't have a Co-developed-by without a SoB, so both are needed :)

--Ug5/aA5lWs5nDlds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL91qwAKCRB4tDGHoIJi
0o+rAP9z5FelZ0n3DrX8+EzVEZ5gNidCyctFi0OT1UBXZsWkmwD8CrSIlVke8g3W
Rgkqo3TvjNCB/0xyKodEtvQW+nlNbQo=
=VCzr
-----END PGP SIGNATURE-----

--Ug5/aA5lWs5nDlds--
