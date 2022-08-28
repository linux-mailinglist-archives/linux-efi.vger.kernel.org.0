Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A575A3D08
	for <lists+linux-efi@lfdr.de>; Sun, 28 Aug 2022 11:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiH1Jw1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 Aug 2022 05:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiH1Jw0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 28 Aug 2022 05:52:26 -0400
X-Greylist: delayed 105033 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 28 Aug 2022 02:52:25 PDT
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7712C642
        for <linux-efi@vger.kernel.org>; Sun, 28 Aug 2022 02:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661680345;
        bh=wtcwcDCiI084EwY2VXzH4RkkInq3xnjGC9hx6cx7USI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aiDmPu2/u5VwHq/T5djbRuLwEWwMkFEiPlFdNclPhYkVtp82wloDWIFv1tv6fT++w
         Ij+WEas1HXQNes0PGk5qYY7C1H/SNnUFVnHIaedFyh0QAXx67wrc+7PAboyjaQ9f7s
         isjV63U1SizMJqy1+gqCsKM2QYL5THnOEOO7c4sI=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id DB18066775;
        Sun, 28 Aug 2022 05:52:21 -0400 (EDT)
Message-ID: <ec399503712be2d79bd1ab789452028c1fdcaa32.camel@xry111.site>
Subject: Re: [PATCH v4 9/9] loongarch: efi: enable generic EFI compressed
 boot
From:   Xi Ruoyao <xry111@xry111.site>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>
Date:   Sun, 28 Aug 2022 17:52:20 +0800
In-Reply-To: <20220827083850.2702465-10-ardb@kernel.org>
References: <20220827083850.2702465-1-ardb@kernel.org>
         <20220827083850.2702465-10-ardb@kernel.org>
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

Hi Ard,

Should we also add

--

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 063a578bbdaa..6ee3d7826893 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -9,10 +9,16 @@ KBUILD_DEFCONFIG :=3D loongson3_defconfig
=20
 ifndef CONFIG_EFI_STUB
 KBUILD_IMAGE	:=3D $(boot)/vmlinux.elf
-else
+else # CONFIG_EFI_STUB
+
+ifndef CONFIG_EFI_ZBOOT
 KBUILD_IMAGE	:=3D $(boot)/vmlinux.efi
+else
+KBUILD_IMAGE	:=3D $(boot)/vmlinuz.efi
 endif
=20
+endif # CONFIG_EFI_STUB
+
 #
 # Select the object file format to substitute into the linker script.
 #

--

or do we deliberately expect builders to run "make vmlinuz.efi"
explicitly?

On Sat, 2022-08-27 at 10:38 +0200, Ard Biesheuvel wrote:
> Wire up the generic EFI zboot support for LoongArch64
>=20
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> =C2=A0arch/loongarch/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0arch/loongarch/boot/Makefile | 6 ++++++
> =C2=A02 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index 4bc47f47cfd8..7051a95f7f31 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -93,7 +93,7 @@ vdso_install:
> =C2=A0
> =C2=A0all:=C2=A0=C2=A0=C2=A0$(notdir $(KBUILD_IMAGE))
> =C2=A0
> -vmlinux.elf vmlinux.efi: vmlinux
> +vmlinux.elf vmlinux.efi vmlinuz.efi: vmlinux
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(Q)$(MAKE) $(build)=3D$(=
boot) $(bootvars-y) $(boot)/$@
> =C2=A0
> =C2=A0install:
> diff --git a/arch/loongarch/boot/Makefile
> b/arch/loongarch/boot/Makefile
> index fecf34f50e56..4e1c374c5782 100644
> --- a/arch/loongarch/boot/Makefile
> +++ b/arch/loongarch/boot/Makefile
> @@ -18,3 +18,9 @@ $(obj)/vmlinux.elf: vmlinux FORCE
> =C2=A0targets +=3D vmlinux.efi
> =C2=A0$(obj)/vmlinux.efi: vmlinux FORCE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(call if_changed,objcopy=
)
> +
> +EFI_ZBOOT_PAYLOAD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :=3D vmlinux.efi
> +EFI_ZBOOT_BFD_TARGET=C2=A0=C2=A0 :=3D elf64-loongarch
> +EFI_ZBOOT_MACH_TYPE=C2=A0=C2=A0=C2=A0 :=3D LOONGARCH64
> +
> +include $(srctree)/drivers/firmware/efi/libstub/Makefile.zboot

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
