Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578C65A3B2D
	for <lists+linux-efi@lfdr.de>; Sun, 28 Aug 2022 05:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiH1Dby (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Aug 2022 23:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1Dbx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Aug 2022 23:31:53 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C646A3AB1A
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 20:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661657509;
        bh=Zk6WIVodQZWT/v1nuFDCeMPblZ8B33oAv6WsZiY7nSc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Smlj93cICa2p6J+YDJGVEFwpRSCaNLmtEw1UWRoeeFm8e1jGHmgo+ULgKYJIwYrri
         Luz2fIj8obYjVogxzUI0RpdVuvxYUcUOCNrotgG7I5zr7WHHwpmY6doi+fCqFkpUVz
         ajZk+Tu6INgUqept7FErgCW9nTh7DzVHnNF+JxTU=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id C3EFC668E6;
        Sat, 27 Aug 2022 23:31:45 -0400 (EDT)
Message-ID: <adb55eda511ad6de85936dd37f584687a22e7437.camel@xry111.site>
Subject: Re: [PATCH v4 8/9] loongarch: avoid orphan input sections
From:   Xi Ruoyao <xry111@xry111.site>
To:     Ard Biesheuvel <ardb@kernel.org>,
        =?gb2312?Q?=B3=C2=BB=AA=B2=C5?= <chenhuacai@loongson.cn>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>
Date:   Sun, 28 Aug 2022 11:31:43 +0800
In-Reply-To: <CAMj1kXG4CXUEtx9r=r-sOyU6cUmDaknKqu3_W_FUQ+_gpdLzXg@mail.gmail.com>
References: <20220827083850.2702465-1-ardb@kernel.org>
         <20220827083850.2702465-9-ardb@kernel.org>
         <7aa14d72.3a4f.182deccc341.Coremail.chenhuacai@loongson.cn>
         <CAMj1kXG4CXUEtx9r=r-sOyU6cUmDaknKqu3_W_FUQ+_gpdLzXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.45.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 2022-08-27 at 15:27 +0200, Ard Biesheuvel wrote:
> It does have a relation: the signing tool will complain because the
> PE/COFF metadata goes out of sync, like so
>=20
> =C2=A0 SBSIGN=C2=A0 arch/loongarch/boot/vmlinux.efi.signed
> warning: data remaining[20754944 vs 20755016]: gaps between PE/COFF
> sections?
>=20
> This is because of the *(.rela.dyn) section created by the linker,
> which is appended after the .data section, and so the PE/COFF .data
> section size does not match the file size.
>=20
> *However*, you explained to me that vmlinux is not a PIC binary, and
> the link should be non-PIE as well. So this looks like another
> toolchain issue to me, that you may want to look into.

In my builds:

With Binutils 2.39 and GCC 12, vmlinux rela.dyn contains 48 zero bytes
(or 3 R_LARCH_NONE relocations, which is defined "do thing" and is
ignored by ld, ld.so, and kernel module loader).

With Binutils trunk and GCC trunk, rela.dyn does not exist in
vmlinux.(But for using the trunks of Binutils and GCC we'll need to
either disable CONFIG_MODULES or apply [1].)

[1]:https://lore.kernel.org/loongarch/20220827175436.156464-1-xry111@xry111=
.site/T/

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
