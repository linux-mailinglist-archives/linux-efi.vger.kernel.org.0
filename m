Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9974F6D4C
	for <lists+linux-efi@lfdr.de>; Wed,  6 Apr 2022 23:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbiDFVuF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 Apr 2022 17:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbiDFVtt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 6 Apr 2022 17:49:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3B8269;
        Wed,  6 Apr 2022 14:37:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18A0261B6F;
        Wed,  6 Apr 2022 21:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D227C385A1;
        Wed,  6 Apr 2022 21:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649281037;
        bh=Ei4jOiexJMk2axruEb9A6TUDgWkGiI0ovXWw6/kdmE8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pDZmRYypkbK785V+TI0+r1z9cJyPZbU2vo5MOtlSBuRs1dA+Jd/HQOd9uMyfT4Jqd
         lw2CVjpueFiWKZe2H/nrVrt9ufbk7VW7yrdCPose0PX2E1ukwzWXT/tNWhlhLMoaJq
         6VKRutlV4RcmQsf3aP591M7ZqDCJalFzcW/xNgO2w9Y35WATCEblXoYin6q+IsSu8+
         cTY86sfjgEgRDwDNRneu9qYwAA7SXm8adIVhmEY01To/HAkbaujy4h2mcuxUi+JfcQ
         AB5WxdzcM64JTG114ZwPkWQNCzFdO98WtOCbjHUCO0f3eH4+jha1Gml5pKol8dXPvN
         A6K5d4RHDbXfA==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-dacc470e03so4386303fac.5;
        Wed, 06 Apr 2022 14:37:17 -0700 (PDT)
X-Gm-Message-State: AOAM530E8sxkM4DmO220k2R2ZJvp3pEjfxqAntjyeNHryP2B1bWmAv+T
        aKbbacVmvDbN1VdQbrC7mEOhHqwhJki8g++HouI=
X-Google-Smtp-Source: ABdhPJwN68i6oJ3p8bDepCraDIsOUuZtHk97SeycBdw3Mng2vEZhfHBr3fs5ZaiSlF6rQTiHkge9ewSdR5nNCSeCNoA=
X-Received: by 2002:a05:6870:b027:b0:de:7fcd:fabf with SMTP id
 y39-20020a056870b02700b000de7fcdfabfmr4970738oae.126.1649281036634; Wed, 06
 Apr 2022 14:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
 <20220308144053.49090-2-xueshuai@linux.alibaba.com> <YkdkHtNzRJ1SL0/k@zn.tnic>
In-Reply-To: <YkdkHtNzRJ1SL0/k@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 6 Apr 2022 23:37:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFz_kpUf_XGqi1sBA8Qp-eXM09HbJCazhXEx6J4QYP7Eg@mail.gmail.com>
Message-ID: <CAMj1kXFz_kpUf_XGqi1sBA8Qp-eXM09HbJCazhXEx6J4QYP7Eg@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] efi/cper: add cper_mem_err_status_str to decode
 error description
To:     Borislav Petkov <bp@alien8.de>
Cc:     Shuai Xue <xueshuai@linux.alibaba.com>, rric@kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 1 Apr 2022 at 22:44, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Mar 08, 2022 at 10:40:51PM +0800, Shuai Xue wrote:
> > Introduce a new helper function cper_mem_err_status_str() which is used to
> > decode the description of error status, and the cper_print_mem() will call
> > it and report the details of error status.
> >
> > Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> > ---
> >  drivers/firmware/efi/cper.c | 30 +++++++++++++++++++++++++++++-
> >  include/linux/cper.h        |  1 +
> >  2 files changed, 30 insertions(+), 1 deletion(-)
>
> Ard, ack to take this one and patch 3 through the EDAC tree?
>

Works for me.

Acked-by: Ard Biesheuvel <ardb@kernel.org>
