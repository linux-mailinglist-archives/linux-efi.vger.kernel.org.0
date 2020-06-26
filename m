Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C29020AA91
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jun 2020 05:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgFZDAh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Jun 2020 23:00:37 -0400
Received: from mout.gmx.net ([212.227.17.20]:54461 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbgFZDAg (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 25 Jun 2020 23:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593140426;
        bh=kBlVHxyUp3+0RDOPOn69M6zoqhE1t52hPzBx23SEtCg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=B+D8ULdLAfyQIFdlt4F+q9ObaZkMv4A78fPemKtrGI2mupPwU/Qsxwq8n8yZjP5DG
         27TOG+kUm85JT9QCT18m/PpCE8TYJdddpRuCDNItTTnFZjwAOkaXq6fSyK97+hc3tS
         3B1u0jJA0H1ZW44Q6vfiU6lPPDc56UBkq51xVtZQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.51] ([88.152.145.75]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsEx-1ix6D726FT-00sz8i; Fri, 26
 Jun 2020 05:00:26 +0200
Subject: Re: [RFC PATCH 10/11] efi: Rename arm-init to efi-init common for all
 arch
To:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200625234516.31406-1-atish.patra@wdc.com>
 <20200625234516.31406-11-atish.patra@wdc.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
Message-ID: <8b71b663-8a68-26f3-c806-a2873a6d8923@gmx.de>
Date:   Fri, 26 Jun 2020 05:00:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625234516.31406-11-atish.patra@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d8YfDH5rm/aIO6ZblpSCJcfvrT+bctc+tiI1/6xHvAvdC/Sqc1F
 CuIXhmT2IwP7hla2TlaR62Jkuwsy6iQUrdBHhxAuf/Mb56aUi2l5xLdZhjhj546j9XTNHkf
 YIIBM3rUjvH7ebu2Yf5c1k1ScTqK+9rPiLMIyn9DIL7cFoaZ9wq9UBug2b1vCk8izySugFa
 NV4bwY2mL1LKS2rI4zD9Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+uf1dLeMudA=:zKokUI9878ek4/6pUBVw92
 XI0JiV1GrkEaEbdT9qlI1glRS+mCpqlhi/CFgWzvdErXxbJZX0GewtoCR/H/b038f4ZO4q4iW
 Uc4P1lk6tYpV8Mnoqt+qXC8wT9tT1JvwUDxII8tdQeV9I6J7emJW5wrBIqHUuYlG/8B0ZP57W
 zAm4t0sqwr8fd2HWw56z0wkFjuiKwzkPgTel3PjqUJyp3t/3KmBwpyJQ221fFly2m3GrfHLA/
 YuVnAdwWqqFdIfeTPmFjqU3d/YlUT9UR1cPIFl2uO3P9RxZScPmblzL1iq/HYgva2ssn5WzIa
 9fcxhfSdw2RRQ6tzO23wB6ds+WtaNKmhGFJ+yo6RYDXaHoE5XT5I/fImiQGIKOOkoa37Exgqj
 gq5IsVoZy2kZtvgDKYJm9QUe/CwV+Q9+2VRJPS7GsHFjmL5e7fkxUYH9hxssitPJND3HSDPcp
 Y2w3knc3z3w+fTGAoa39eyNfXJkDBWwk4cKPoWoa0Gxd8fTEnl8AQ04WzgpZP8NTTXP+qtT4A
 C7OMuzLzs3lB4Gy7a9E4GklmU2XA5K15mVHyWs7tWSGihP6DPFZLxpXokeXX2e3roZgGT+OZA
 2R8ers1efV52j3evrX6d6FrvILRXvh91DaakypZ1nH2WI9FhjoN8EGtdJd17VnZQDjtHkf9K4
 L/UlBY2mPtzn073t25mkyvO+7a6E3xdVrnBI6Sof/9hEGmdCJVCFxesLfkkXx782K50LW8nbX
 CThv/x4bmPS8t2En1AdLxgP5YWZt2HSnAt2wu0ppNEtL+ZeRyZlrQ14ramXkG1R8drFcPaj0O
 zqjcvoCqb064E3E4grvkkbhku+4NWDWkLaNzx+W5ifFWy6+bNHy/gyAlYfckwjVmQPIAM2VLE
 1mE2dIP0juXXH2JN4AYknISVvUewkxnd6krvPpHzZeyQdd4kIuaKY3aw872MLIFpkb5yySMQU
 2mUXlLiZJAO29qtLPMvRN36kBUt/F+e3qctD4R5dxB2o3hORn/SkoJLgenU5iiyZ7aFY2KglE
 jaks5iC3OKlKo5tnZnabXYPHSVD4LnbARX8vHJxeTsi3qCm7KaYuYDxMe7fJJmMIlpu4CZ20h
 Bk6S7nAjeqFReSf5cX3JZTRPxJXG8t0l+DsEwJre39F2+jcupQlWsJO/HwE/76Xv1paY+pnkJ
 6HesQRttpG+njtO+m3GrUMcbWBnZEAP7xDKL7JevCDuLPGyarlTJIb/QIQ2wOIM8B2J5g=
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 6/26/20 1:45 AM, Atish Patra wrote:
> arm-init is responsible for setting up efi runtime and doesn't actually
> do any ARM specific stuff. RISC-V can use the same source code as it is.
>
> Rename it to efi-init so that RISC-V can use it.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  drivers/firmware/efi/{arm-init.c =3D> efi-init.c} | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename drivers/firmware/efi/{arm-init.c =3D> efi-init.c} (100%)
>
> diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/efi-=
init.c
> similarity index 100%
> rename from drivers/firmware/efi/arm-init.c
> rename to drivers/firmware/efi/efi-init.c
>

After each patch we should have code that builds. This helps when
bisecting. Therefore I would have expected an adjustment of
drivers/firmware/efi/Makefile in this patch and not in patch 11/11:

-arm-obj-$(CONFIG_EFI)			:=3D arm-init.o arm-runtime.o
+arm-obj-$(CONFIG_EFI)			:=3D efi-init.o arm-runtime.o

Best regards

Heinrich

