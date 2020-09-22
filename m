Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB49273E3F
	for <lists+linux-efi@lfdr.de>; Tue, 22 Sep 2020 11:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgIVJMk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Sep 2020 05:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgIVJMk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Sep 2020 05:12:40 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2E4C061755
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 02:12:40 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 77so9881739lfj.0
        for <linux-efi@vger.kernel.org>; Tue, 22 Sep 2020 02:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xOLA0Br0gzqbj+JcQVCZx0f83MS3fViXZ2kO5rY0/+A=;
        b=osugVA8YtkwttL64IySs6K4p0iEFa0nKLbvpj2M+2ED2g+r+5meOI/f9fjzheEncw4
         0VNZ7CNPSd9W49F7IQSp4Jt6xHkJVH1ZvuDbJ2r7ybthJlsscNDDFs4kTLnYa99QLgk1
         XgMNiHOdm+IgVcadUYrJeFow92jYp7y4UzGi2zH2b+Gn1dJTRGWwDpN8khGTPmxWFVP/
         psVOukZWthyjgYXdRv4ZMwWVDa8cg8TL8ZDdbsupXi1mTHHx0DL7sIexXnVV4e0U52+Y
         U4+STKNkQoG5dry2g5bt9axn+9ILzEfOhgX1YfS5UYSWTBl65LtLxV3lxKhOJ79Rr5nB
         MIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xOLA0Br0gzqbj+JcQVCZx0f83MS3fViXZ2kO5rY0/+A=;
        b=tWoAM3Xausd3kmDxYsbt9mRo7EnGESoccAT+A5H3+tYqexqR9P0pj+3q2+Exc8BowZ
         eiIbqXzxohPG3U2Kt41BZjQj1CkR6/5Yqsziwi0p1ccSTvncI78WOla8mrypv4oJf1Zw
         teWNGxjvvoI3rq17T+fL3JfFJSctOLgaJSzIcUR5yTqrh/uGeFTib5XN0N4hts92daFz
         /peVBoSy0jnrfoRtHuWAD3u/qlx9D1CnleXaSk93SIU73dHBBLCxUzTOZO65uPWSzQbN
         4HLBWXjFK57sa2DpkVZCa1mBCL5mawuDvmyZ8ON/ADcQaTFu/ZIXMKAdx7dyqlzbIBzp
         SJXw==
X-Gm-Message-State: AOAM531A7K8+Cl7wrdt0WeLLTYUY6KQOGhsbpEHsnm7RczHbojojXhQ3
        CVfRKUKDZbJR6otBu7wNpQeSzjRCtVk9a+fNI/JU00abbjaiSw==
X-Google-Smtp-Source: ABdhPJxYvXmMF1MtNJ/nAFXX5120jENA6icpCqwYnvRUkoZadv8bfZEYAJg47+QLmOJ/QJEKjC0qyPAWEHBxdYqbws4=
X-Received: by 2002:a05:6512:370b:: with SMTP id z11mr1229904lfr.571.1600765958589;
 Tue, 22 Sep 2020 02:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200921154117.757-1-ardb@kernel.org>
In-Reply-To: <20200921154117.757-1-ardb@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 22 Sep 2020 11:12:27 +0200
Message-ID: <CACRpkdbRHuwo8qoqrYhimU0kxboEkGYeTTGWUb-dFN+Z+D_2=A@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] ARM: p2v: reduce min alignment to 2 MiB
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Sep 21, 2020 at 5:41 PM Ard Biesheuvel <ardb@kernel.org> wrote:

> This series is inspired by Zhei Len's series [0], which updates the
> ARM p2v patching code to optionally support p2v relative alignments
> of as little as 64 KiB.

I'm a big fan of this whole patch series, so I provided Review and
Ack for each individual patch. I would love to see this upstream for v5.10.

Yours,
Linus Walleij
