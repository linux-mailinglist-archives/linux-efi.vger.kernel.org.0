Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E2426CDF5
	for <lists+linux-efi@lfdr.de>; Wed, 16 Sep 2020 23:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgIPVH2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Sep 2020 17:07:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgIPQDk (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 16 Sep 2020 12:03:40 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04959224B8
        for <linux-efi@vger.kernel.org>; Wed, 16 Sep 2020 15:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600271949;
        bh=7kQAynxxle7Un1t1kFes05omb418iypz8P9cKdbAPE8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Rh4aBiZMMafxZf4gYt2pm8VYmnZpwGpqiGWq0SD+6q02QbWRqy503Wj5fddMRvzOO
         4f98BSaZ7wV6rPelR7cCVpm0Y/byvEcw3nKiKSmHz8faDb6vTrptpz5bK1imcunzUf
         owgmfQc/p8o45ZVWle+v+qzgmTpDrFjZe9x1J5Ng=
Received: by mail-ot1-f43.google.com with SMTP id m12so7203414otr.0
        for <linux-efi@vger.kernel.org>; Wed, 16 Sep 2020 08:59:08 -0700 (PDT)
X-Gm-Message-State: AOAM531wwkJJyyE+6t1Xiav1VilQ5qSV1ppC3911ozkAnUzGxjMA9N6t
        qoZ6H/8CngT6cbvjQ+Fp23XRVRmyIfHRU9a0z6o=
X-Google-Smtp-Source: ABdhPJyolqTtmQUVDbomuF3NpG/UJ9qQKfQOYHVC/Ku6sND00C88mInH6BSmG6wdF8oG6nvZdV6OrlUd6fcIdJpvg48=
X-Received: by 2002:a9d:6193:: with SMTP id g19mr16542365otk.108.1600271948331;
 Wed, 16 Sep 2020 08:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXG6VRXOPRhHmeyiPP06BVByEYsqYE001BZYyRDqtvyDBg@mail.gmail.com>
 <mhng-f3ca14fc-58f7-423e-8abe-a85de1a2d55b@palmerdabbelt-glaptop1>
 <CAMj1kXH5pA-9uWCRzvN2OKzxTr0mG8knZZnpuOPn+b5BBAn4dw@mail.gmail.com>
 <CAD8XO3YQfWQv_WxWuJ0ur_chfK-iSjDwhWA4KWXP85VOYCi_qQ@mail.gmail.com>
 <CAMj1kXECRr+E4=r+7fuaRAXQUyLi5Z1_HgNWgLGZVHdPSABE0A@mail.gmail.com> <CAD8XO3ZLn-zSrdmr6GL6cwYFhAtS2FpXA3izwpEC3+_iVmN9Jg@mail.gmail.com>
In-Reply-To: <CAD8XO3ZLn-zSrdmr6GL6cwYFhAtS2FpXA3izwpEC3+_iVmN9Jg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 16 Sep 2020 18:58:57 +0300
X-Gmail-Original-Message-ID: <CAMj1kXFYJ3oPZGWEy8viqwXLeYGWqH+uy+DhPpcLstn4=T0GmA@mail.gmail.com>
Message-ID: <CAMj1kXFYJ3oPZGWEy8viqwXLeYGWqH+uy+DhPpcLstn4=T0GmA@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT 0/3] efi/libstub: arm32: Remove dependency on dram_base
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>,
        Etienne CARRIERE <etienne.carriere@st.com>,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        Patrice CHOTARD <patrice.chotard@st.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Grant Likely <Grant.Likely@arm.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Christophe Priouzeau <christophe.priouzeau@linaro.org>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        Patrick Delaunay <patrick.delaunay@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 16 Sep 2020 at 18:43, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> On Fri, 11 Sep 2020 at 21:45, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 11 Sep 2020 at 13:27, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
> > >
> > > Changes look fine for and should fix booting, while I can test them in
> > > my environment next week.
> > >
> >
> > Thanks
> >
> > Please use the version below for testing:
> > https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/tag/?h=efi-riscv-shared-for-v5.10
> >
> tested this one, qemu 5.0 ( qemu-system-arm -machine virt,secure=on
> -cpu cortex-a15 -m 2048 ..)
> atf - fc721f83085
> optee - d1c635434
> uboot - 9f04a634ef
> All components are almost the latest versions for the current moment.
> Works fine for me.
>
> Reviewed-and-Tested-by: Maxim Uvarov <maxim.uvarov@linaro.org
>

Thanks!


> Maxim.
>
