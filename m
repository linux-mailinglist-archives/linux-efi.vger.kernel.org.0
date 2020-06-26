Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA0020AA7A
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jun 2020 04:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgFZCnR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Jun 2020 22:43:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:42843 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbgFZCnQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 25 Jun 2020 22:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593139375;
        bh=DYtHPfwpCJJKc0GqD63QONboqwpuMFw48ADI1vGBkfE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=D9LBXStYT0ZyOfJPe078AUotHpvpwhf8u7T6/090nYLo4zv/t/yvuIaeB41sDEtHM
         0X+58800Hz9TC1rg8vLQaLnznYmYYvELcnQEiXPqHOdIZ7MG6pfJQIVUbgUDRC7343
         a8esRG8AVQ4orrqYxfty0FmLC0OBva/o8Ps0QObY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.51] ([88.152.145.75]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7zBb-1ikz0u2xTH-0153gH; Fri, 26
 Jun 2020 04:42:55 +0200
Subject: Re: [RFC PATCH 01/11] efi: Fix gcc error around __umoddi3 for 32 bit
 builds
To:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200625234516.31406-1-atish.patra@wdc.com>
 <20200625234516.31406-2-atish.patra@wdc.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
Message-ID: <5e2ce2ae-5458-8579-576a-76721f7d3b08@gmx.de>
Date:   Fri, 26 Jun 2020 04:42:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625234516.31406-2-atish.patra@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DNir3hMAMYmQ87pJwppxYJqIekpH3I3jRR832mYeUNJrc23wAOp
 HbPxmf10cNMzuii472N+t3Kj5r64eOm1lManQ01GefmPRkEx7/gDJlewZnR5XaDAczcFIVz
 pm2bNrbsZi9EavGXOCyDSgh5bazavfd3XZzPTIl+JGPvZYuS6sV2SmHuQlnjXp7dXXAlgZ7
 xpCbkt+5XAP2NRv/Zvb5A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xq8K61p4ypI=:fU2r66EwJMt+drFGGv2Ny/
 IocZxyE6K6ZixZ0rXD2jNMSWjOaS6hNqvRaeQpXiCBiWUA6ZxoTdhRBzJq/gO8xaOefbNDXjS
 7evuYkpsRxnc5iJe31Qvr256OHjR85Lg0/dnar70YVNHt6GJl7YeB6Sui8mTlvzy9Y7ydb5l2
 g3PCW5HcKaNKgJdYo7MTxefe7NCiZjWadhO06t86x/XzSSLsU5gD67GzC5MDzX+hF1PMFbucP
 /B+iSJA2ylOMcOJ17KlQuSf0JJMYD1QpsmeGrq3rn8vruKqkh8CDPaYP6yBgAwDBnFpXOkrDw
 LK1TYKkLgsHV9ZKKMN8wxJgErkYGBB8EwPMe8diWGigebHsy1+VkCBatnA9ROs2r0cQZnA4sX
 uxygkKJROdXLW0nGaJuQywT6qIVlaHuirlFUI7sGAddCpVBV9Rk+VlASaMpRKbR6208hG/VTU
 NIdmSn9paIcZbJuTzfv+drOZ/jmysT6VzBxvEEloVcpDz5uFDAMvT4s43Yo091LuGS1AQu8oh
 sEK51ZQCdZQ2JSljiXPXsHwTl9O58QLze/yTILrhOp4GbXLNxyUlOkRe5Zyq6xdr25RhiML5J
 lxXXNZjlYaikX73NHIaDA3dupY7kakXf62qfzDlLlW17VQ/hZxu4QHhz0pgjQvLaRoFSJ/C+b
 mf6sGNRjXuZGip71whdUIsdarm7sohO2z2VBZaF3OJwJmEAFNl3rfH9r+BxqEuL7WF4auSOo/
 OvI6LUXXqUMFwoHowoLodsqpOT03EWgIZaeYS7ff/V97wI/w5I8R+SNjoSkK2X2UNHyzMT7Sr
 vl6qJLuF7wHXJMQEf1BxCmglTY344dxSG3n3ukjS7Jyz23SLdPioD+0rq2GAoXkij2HG+Q4fe
 +y9MfnO5oI2V7L1zhlIx41WQtfAbRo+p2mKSHHQEWWKEovokPVuYFeoxR2jIaxpnX0L4/WNtH
 hjOiwirrdy+v6irBzPhxy3ICQbgypxEoNvBY8KeNtAG8jZYOdePMJBr1jINcdSBJTOeEDV4FB
 iMiOe+mChG3fzIPp0Qf/bHyRleQgKl6e6ZDZdF2uZvrgrwl/YKJxS6FqHR/2LkHT7wZxaBQLU
 I4D5PfIiafYWcsn9UIKKsUqUjs27tIw51IVE3tak/ebB3Z8opl64OTvGbNxTFri2WL+C8lYxw
 0T6Ht2YljGNLkPxKktXuUhfV4vZDZa4j8idoWlJcAMrHEC7lgwW+8PAp7BfEOI9XwHxIkJ4b+
 p1NBpPev7YIBV4/KK
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 6/26/20 1:45 AM, Atish Patra wrote:
> 32bit gcc doesn't support modulo operation on 64 bit data. It results in
> a __umoddi3 error while building EFI for 32 bit.
>
> Use bitwise operations instead of modulo operations to fix the issue.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  drivers/firmware/efi/libstub/alignedmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/alignedmem.c b/drivers/firmwar=
e/efi/libstub/alignedmem.c
> index cc89c4d6196f..1de9878ddd3a 100644
> --- a/drivers/firmware/efi/libstub/alignedmem.c
> +++ b/drivers/firmware/efi/libstub/alignedmem.c
> @@ -44,7 +44,7 @@ efi_status_t efi_allocate_pages_aligned(unsigned long =
size, unsigned long *addr,
>  	*addr =3D ALIGN((unsigned long)alloc_addr, align);
>
>  	if (slack > 0) {
> -		int l =3D (alloc_addr % align) / EFI_PAGE_SIZE;
> +		int l =3D (alloc_addr & (align - 1)) / EFI_PAGE_SIZE;

Here you rely on the compiler to silently convert the division by
EFI_PAGE_SIZE into a right shift. Wouldn't it be cleaner to use
EFI_PAGE_SHIFT to explicitly avoid a dependency on __udivdi3()?

slack =3D (align >> EFI_PAGE_SHIFT) - 1;
...
int l =3D (alloc_addr & (align - 1)) >> EFI_PAGE_SHIFT;

Best regards

Heinrich

>
>  		if (l) {
>  			efi_bs_call(free_pages, alloc_addr, slack - l + 1);
>

