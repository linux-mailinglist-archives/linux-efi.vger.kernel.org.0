Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3596E78E5C7
	for <lists+linux-efi@lfdr.de>; Thu, 31 Aug 2023 07:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245132AbjHaFe2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Aug 2023 01:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbjHaFe1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Aug 2023 01:34:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA9AEE;
        Wed, 30 Aug 2023 22:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693460065; x=1724996065;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5fTpKtpTH7VHtgXBTshu0Z6bHpAk6pRiOhKHGWRzMK0=;
  b=BBueLt1+Wx65e5JBFX1h/MGLh7pHxG4+Y0ftjz0teiNAvWdg6mzxc82L
   H1jbd/RE2lzQLIA5jvHBSbLD9zoA+Euv/enTmVd/VYqEyCAwMjwejVUGo
   +u5wuYEh8Zaq5TH5FIRD/nqUVi8s8uwiOgq4+bTPOMIrF4nb+f9FMrOX+
   6qsC5Kog8mUOf8zleNJTTWmZY5aESvfHEbfVS2BgI7ICI8V7u0XDMpSa4
   qZQTEVzvcMe55X8Qkp1p9TKiZs/ZMAojnnKQEVqQYUV3K906XSgF8JLq9
   qn+X7PrD59RXdRc3kvV6c2xgAEcgdiGubpGZa/UQUvXuukWjHA+RdN/zg
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="asc'?scan'208";a="2169620"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2023 22:34:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 30 Aug 2023 22:34:24 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 30 Aug 2023 22:34:22 -0700
Date:   Thu, 31 Aug 2023 06:33:39 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Sami Tolvanen <samitolvanen@google.com>
CC:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 0/5] riscv: Introduce KASLR
Message-ID: <20230831-reclusive-panning-f6a912e07fbf@wendy>
References: <20230722123850.634544-1-alexghiti@rivosinc.com>
 <CABCJKucj78p4TBtXYmMdJ=vYK69XC=XU06uB+_fyfZLRnC4h0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XwDbeznsdT2oG++s"
Content-Disposition: inline
In-Reply-To: <CABCJKucj78p4TBtXYmMdJ=vYK69XC=XU06uB+_fyfZLRnC4h0A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

--XwDbeznsdT2oG++s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 30, 2023 at 02:30:31PM -0700, Sami Tolvanen wrote:

> Conor, in another reply you mentioned you're planning on reviewing the
> patches as well. Did you have any feedback or concerns?

I didn't even look at it again. Been really short on time & I guess just
deleted it from my queue when I noticed I'd tested it before.

--XwDbeznsdT2oG++s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPAmLwAKCRB4tDGHoIJi
0kjyAQDCH3DesLWi5bCCVWfpuHL32z+qMDgemCmZWh1kcLp/WAEA4qIw+dGQtQoi
81uNCBhySZ9MfnKpn2soFTsYUfMujwI=
=n/yh
-----END PGP SIGNATURE-----

--XwDbeznsdT2oG++s--
