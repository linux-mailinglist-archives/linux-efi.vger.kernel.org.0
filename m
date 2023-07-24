Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8215A75ECE9
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jul 2023 09:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjGXH4x (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Jul 2023 03:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjGXH4Z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Jul 2023 03:56:25 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D702E5A;
        Mon, 24 Jul 2023 00:55:50 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-63cf6f49a9fso2278176d6.1;
        Mon, 24 Jul 2023 00:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690185347; x=1690790147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oO2PaBPMPgNdhD2v5D/LrK8XAtymTxzQa6+Wp6imTI0=;
        b=dBX304bKzvJ9AbsxqXvs2MvHEftCsEVgOLvRiWccFE9hxumIuUv3a7y0npVz41zJ5Q
         vMyydB6vwQUzPDH37sUSD5adC12ZaotinoKEquGG94sx/rmG+Uu2yvUJ3Sk2T24v2vfZ
         04cmNo9WVO1gbm6BNotp/Fre5Tsi38zqujwUIm4Y9SeKQ5vb9YEap0LOhxHc9SLrTCwz
         2pkla2U0k2eAFRWZKA7BenbngpkDjnaUg0oisd4E5S2zF7oxFQ1yMuFhQT/qUkqifd0C
         sfkk5mRUYV/Dt8AMwEfFR+7pxPWe98L3He0DJoG3VpJP7k/mj3G/qp6g0vd3P7t9p5G3
         wQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690185347; x=1690790147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oO2PaBPMPgNdhD2v5D/LrK8XAtymTxzQa6+Wp6imTI0=;
        b=Bd0VjiZVFTU/Y4ug4B1UaSaKP9X+yRc5z42DryWm4jHqCxvE5nf8XR8KEUigcFsUMz
         ysS+gIbgPxTD6k44A1e4lUKHfko+h09QOQlOPIpuSTJdf/JIDF+o0UAKLfF1ixfXQ0DT
         T3d6MQqHUVXI6EzFDJW2+u40sElymmGNPR3Rpmvuq3h70Xg2DqFIEUCsI8gy8AbFGr8x
         SAG7x3kL/X5lm+lz90jTAaxzGOw3a4NX7VHRL1VVlTy2bkdId+Somn2ld1d2VmMkdpms
         ZEtFf/9snXKRrzfVfeDqzhp4SbWa1o0qEYUUGvHBpwxdp8lgs4m4TNCXP2Lk1ZCCsPNa
         DtLA==
X-Gm-Message-State: ABy/qLZnIoNyUlLo0nw26u08wh45Ff8WVa0MuWxTZ+UkGazBHpTUDM4N
        pRGoz5lLaQ/G7XwJkQgkcib7kRRsEwhh9wWmlUo=
X-Google-Smtp-Source: APBJJlF0OMaRw0Uv5+eIczYDG7NDZAVZ8OLqa4zVIlCOMUglxe2CPmAkW6SJI5zy0MMxy5WMRy6SW5i1HIl5Lwga8u4=
X-Received: by 2002:a05:6214:f03:b0:636:dae2:dc4 with SMTP id
 gw3-20020a0562140f0300b00636dae20dc4mr11643747qvb.5.1690185346993; Mon, 24
 Jul 2023 00:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <22bca736-4cab-9ee5-6a52-73a3b2bbe865@google.com>
In-Reply-To: <22bca736-4cab-9ee5-6a52-73a3b2bbe865@google.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 24 Jul 2023 12:55:36 +0500
Message-ID: <CABXGCsPe+gjOy3WiVYHsnLX+jiQkizE2g+wF4t3yS2emgCMNYQ@mail.gmail.com>
Subject: Re: [PATCH mm-hotfixes] mm/pagewalk: fix EFI_PGT_DUMP of espfix area
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Laura Abbott <labbott@fedoraproject.org>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jul 24, 2023 at 2:17=E2=80=AFAM Hugh Dickins <hughd@google.com> wro=
te:
>
> Booting x86_64 with CONFIG_EFI_PGT_DUMP=3Dy shows messages of the form
> "mm/pgtable-generic.c:53: bad pmd (____ptrval____)(8000000100077061)".
>
> EFI_PGT_DUMP dumps all of efi_mm, including the espfix area, which is
> set up with pmd entries which fit the pmd_bad() check: so 0d940a9b270b
> warns and clears those entries, which would ruin running Win16 binaries.
>
> The failing pte_offset_map() stopped such a kernel from even booting,
> until a few commits later be872f83bf57 changed the pagewalk to tolerate
> that: but it needs to be even more careful, to not spoil those entries.
>
> I might have preferred to change init_espfix_ap() not to use "bad" pmd
> entries; or to leave them out of the efi_mm dump.  But there is great
> value in staying away from there, and a pagewalk check of address
> against TASK_SIZE may protect from other such aberrations too.
>
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Closes: https://lore.kernel.org/linux-mm/CABXGCsN3JqXckWO=3DV7p=3DFhPU1tK=
03RE1w9UE6xL5Y86SMk209w@mail.gmail.com/
> Fixes: 0d940a9b270b ("mm/pgtable: allow pte_offset_map[_lock]() to fail")
> Fixes: be872f83bf57 ("mm/pagewalk: walk_pte_range() allow for pte_offset_=
map()")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/pagewalk.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index 64437105fe0d..2022333805d3 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -48,8 +48,11 @@ static int walk_pte_range(pmd_t *pmd, unsigned long ad=
dr, unsigned long end,
>         if (walk->no_vma) {
>                 /*
>                  * pte_offset_map() might apply user-specific validation.
> +                * Indeed, on x86_64 the pmd entries set up by init_espfi=
x_ap()
> +                * fit its pmd_bad() check (_PAGE_NX set and _PAGE_RW cle=
ar),
> +                * and CONFIG_EFI_PGT_DUMP efi_mm goes so far as to walk =
them.
>                  */
> -               if (walk->mm =3D=3D &init_mm)
> +               if (walk->mm =3D=3D &init_mm || addr >=3D TASK_SIZE)
>                         pte =3D pte_offset_kernel(pmd, addr);
>                 else
>                         pte =3D pte_offset_map(pmd, addr);
> --
> 2.35.3
>

Thanks,
I confirm with this patch "bad pmd" went from kernel logs on all my machine=
s.
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

--=20
Best Regards,
Mike Gavrilov.
