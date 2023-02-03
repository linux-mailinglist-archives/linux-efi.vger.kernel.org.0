Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE5B68A6B3
	for <lists+linux-efi@lfdr.de>; Sat,  4 Feb 2023 00:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjBCXBH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Feb 2023 18:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbjBCXBG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Feb 2023 18:01:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EF88A7DA;
        Fri,  3 Feb 2023 15:01:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49868B82C2A;
        Fri,  3 Feb 2023 23:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B1AC4339B;
        Fri,  3 Feb 2023 23:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675465257;
        bh=xiyk1+P1FTc2Er9/TloFWBOvx0vE6nnxjpmQ3MiK05Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZKIGwijlaxfsGHZChWnZCnDXbN2nk5b7fCaoKSNeSs1680QfdheRepCG2HEiU1Ted
         7DG1JQCOl5BPaHA4cgsYMR4YEaOPIIEGI09vAps35uqWw3mwI26Qxwl4WG17MK7Fn/
         pwrEimt5h1+cSWEA22wOZAlyVDDff8RxqTgZ2+mwYviCYr+QlGYnHyDteY+oMd/36D
         YjEodmcI2T15VjOZC7sH7LHfMdk3lxJ0VXFAaHq7lE0dtzGkJldybPtGvg4yrQWmNS
         4muVFydzaV0LrLmlF9S4UrSqhHAy6Zrp/VqgK0+jLlVhlGtxYaOiz5u9ep7OPEo4aC
         J0Ghhxi07BzYg==
Received: by mail-lf1-f51.google.com with SMTP id bp15so9859552lfb.13;
        Fri, 03 Feb 2023 15:00:57 -0800 (PST)
X-Gm-Message-State: AO0yUKVX6b24Ig0VF+GXhovwGWgCjAkF/g5dl8V0pACZo7d21me79Mqi
        oMglRgV9jHPJGVyGES/ODxZ2HsU9rpQjGoeuH1I=
X-Google-Smtp-Source: AK7set+nm9Pzl/OQSo9eXO+SNOnEcdvwMukTVXzWpui/wfsvjD019+LUExd61ZYx6PODOdqQkmzYEXI9fKoQeOeu/iY=
X-Received: by 2002:a19:500b:0:b0:4cc:789a:dac8 with SMTP id
 e11-20020a19500b000000b004cc789adac8mr2188309lfb.198.1675465255810; Fri, 03
 Feb 2023 15:00:55 -0800 (PST)
MIME-Version: 1.0
References: <167545240944.3932004.13241445887801999410.stgit@dwillia2-xfh.jf.intel.com>
 <63dd81ecfd91_dfba82949f@iweiny-mobl.notmuch>
In-Reply-To: <63dd81ecfd91_dfba82949f@iweiny-mobl.notmuch>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 4 Feb 2023 00:00:44 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFTgt2AaLao=xHgKgoOW65D0jBL9hvBbSN0wCYrVimp_g@mail.gmail.com>
Message-ID: <CAMj1kXFTgt2AaLao=xHgKgoOW65D0jBL9hvBbSN0wCYrVimp_g@mail.gmail.com>
Subject: Re: [PATCH] efi/cper, cxl: Remove cxl_err.h
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        linux-cxl@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 3 Feb 2023 at 22:51, Ira Weiny <ira.weiny@intel.com> wrote:
>
> Dan Williams wrote:
> > While going to create include/linux/cxl.h for some cross-subsystem CXL
> > definitions I noticed that include/linux/cxl_err.h was already present.
> > That header has no reason to be global, and it duplicates the RAS
> > Capability Structure definitions in drivers/cxl/cxl.h.
>
> Change looks fine to me but I'm failing to find these duplicate
> definitions?  Without any duplication it seems like stronger change to me.
>
> > A follow-on patch
> > can consider unifying the CXL native error tracing with the CPER error
> > printing.
> >
> > Also fixed up the spec reference as the latest released spec is v3.0.
> >
> > Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>

Thanks. I'll queue this up in efi/next


> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/firmware/efi/cper_cxl.c |   12 +++++++++++-
> >  include/linux/cxl_err.h         |   22 ----------------------
> >  2 files changed, 11 insertions(+), 23 deletions(-)
> >  delete mode 100644 include/linux/cxl_err.h
> >
> > diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
> > index 53e435c4f310..a55771b99a97 100644
> > --- a/drivers/firmware/efi/cper_cxl.c
> > +++ b/drivers/firmware/efi/cper_cxl.c
> > @@ -9,7 +9,6 @@
> >
> >  #include <linux/cper.h>
> >  #include "cper_cxl.h"
> > -#include <linux/cxl_err.h>
> >
> >  #define PROT_ERR_VALID_AGENT_TYPE            BIT_ULL(0)
> >  #define PROT_ERR_VALID_AGENT_ADDRESS         BIT_ULL(1)
> > @@ -19,6 +18,17 @@
> >  #define PROT_ERR_VALID_DVSEC                 BIT_ULL(5)
> >  #define PROT_ERR_VALID_ERROR_LOG             BIT_ULL(6)
> >
> > +/* CXL RAS Capability Structure, CXL v3.0 sec 8.2.4.16 */
> > +struct cxl_ras_capability_regs {
> > +     u32 uncor_status;
> > +     u32 uncor_mask;
> > +     u32 uncor_severity;
> > +     u32 cor_status;
> > +     u32 cor_mask;
> > +     u32 cap_control;
> > +     u32 header_log[16];
> > +};
> > +
> >  static const char * const prot_err_agent_type_strs[] = {
> >       "Restricted CXL Device",
> >       "Restricted CXL Host Downstream Port",
> > diff --git a/include/linux/cxl_err.h b/include/linux/cxl_err.h
> > deleted file mode 100644
> > index 629e1bdeda44..000000000000
> > --- a/include/linux/cxl_err.h
> > +++ /dev/null
> > @@ -1,22 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0-only */
> > -/*
> > - * Copyright (C) 2022 Advanced Micro Devices, Inc.
> > - *
> > - * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> > - */
> > -
> > -#ifndef LINUX_CXL_ERR_H
> > -#define LINUX_CXL_ERR_H
> > -
> > -/* CXL RAS Capability Structure, CXL v3.1 sec 8.2.4.16 */
> > -struct cxl_ras_capability_regs {
> > -     u32 uncor_status;
> > -     u32 uncor_mask;
> > -     u32 uncor_severity;
> > -     u32 cor_status;
> > -     u32 cor_mask;
> > -     u32 cap_control;
> > -     u32 header_log[16];
> > -};
> > -
> > -#endif //__CXL_ERR_
> >
>
>
