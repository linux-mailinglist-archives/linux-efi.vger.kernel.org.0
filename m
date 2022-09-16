Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C2E5BA8B9
	for <lists+linux-efi@lfdr.de>; Fri, 16 Sep 2022 10:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiIPIz4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Sep 2022 04:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiIPIzy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Sep 2022 04:55:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B279E2DC
        for <linux-efi@vger.kernel.org>; Fri, 16 Sep 2022 01:55:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id dv25so47834703ejb.12
        for <linux-efi@vger.kernel.org>; Fri, 16 Sep 2022 01:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=9WYQ00oM/psZnfqZ8IN5UQuCscgsZZskY6DVgNNatHE=;
        b=Ba1gRhP1OGNIHGffCQK675ZglFYIK88Dd/iWcUPj9faApbySB98SZYRz78E5CtZ1Cc
         zjpl8Apj/M2GcQ3vXHaCGwIP0bkdCC/bTiwm0wjc1OzqVBQfUz5E7X83HD1YowXcYR95
         l9UZ1sJcFbCSEnSvANbAuW889pq7TmVcSf3RBw7pDdoa+RQ2ypvwoS/RCCOgC9Blcroh
         jHinARkOtkcJWbMBo1ed6QiL6hFVLYnbLiWtwdGBmOY6oqyWcLY9ifX0+5hq8hTbU71O
         zGpD0a4gIGyf1Dv/yGKTzBmUI5JDgtBYNSE9AYmbb/6nfZCstLVM57K87z4Be9+t9MCj
         gFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9WYQ00oM/psZnfqZ8IN5UQuCscgsZZskY6DVgNNatHE=;
        b=iBJBQLXD4RYBtDWhCNy65MpFV16UcLFQfxLyygT73sZRLOzn8DYjGwGxgoqWVhGV1G
         DXWdYNVaHEZzx42OH+mnIsTEoSudPb09LleTIX4i38F9iJ5CIdWhHvOzK5tqz3OHoqXG
         CTj5M6ZR1xo4+ce45XDwE7e4Bqb+o7ybvXnNalK3Bt/F01G0LeCndOUHu8ei9aT00lla
         orZ39+FsqJRL8Pzv7Wh8glQFLxk194a2ED3lURYdNk8iNFHcw2EPTgeGBpQWcN5x8DGT
         xiPwEFrORilO/zy1TKS5mL7qfabEsK5gzlLpf3MM4Bvs16y3n0JcaH9gzgcyJJJokoD0
         vVHw==
X-Gm-Message-State: ACrzQf1JEjdlb51WVhngYmZLgiypkbpe2Rmzp6YTQliTqnaV6MLZ9Kxs
        b+7SkpCgJ3u7w3hN9qlYKXl0+Q==
X-Google-Smtp-Source: AMsMyM4kkO1+l0qae3N2unk3E9wEnD90ZjnDWCxJjg68+pqMozDBUB5CPVUYG15S/jbsSPP6FuOYtg==
X-Received: by 2002:a17:907:25c7:b0:77b:c193:9230 with SMTP id ae7-20020a17090725c700b0077bc1939230mr2840163ejc.316.1663318551517;
        Fri, 16 Sep 2022 01:55:51 -0700 (PDT)
Received: from hera ([46.103.15.185])
        by smtp.gmail.com with ESMTPSA id e17-20020a170906249100b00778e3e2830esm4684110ejb.9.2022.09.16.01.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 01:55:51 -0700 (PDT)
Date:   Fri, 16 Sep 2022 11:55:48 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     pjones@redhat.com, daniel.kiper@oracle.com,
        James.Bottomley@hansenpartnership.com, leif@nuviainc.com,
        jroedel@suse.de, Sunil V L <sunilvl@ventanamicro.com>,
        Baskov Evgeniy <baskov@ispras.ru>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] efi/libstub: measure EFI LoadOptions
Message-ID: <YyQ6FFNfeG3sw4/n@hera>
References: <20220916081441.1993492-1-ilias.apalodimas@linaro.org>
 <20220916081441.1993492-2-ilias.apalodimas@linaro.org>
 <CAMj1kXEtzCF-19MHNmBB45t3X343bd1G+PRNn=h8=PMfLVq+pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXEtzCF-19MHNmBB45t3X343bd1G+PRNn=h8=PMfLVq+pA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard, 

On Fri, Sep 16, 2022 at 10:26:46AM +0200, Ard Biesheuvel wrote:
> On Fri, 16 Sept 2022 at 10:15, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > The EFI TCG spec, in §10.2.6 Measuring UEFI Variables and UEFI GPT Data,
> > is  measuring the entire UEFI_LOAD_OPTION (in PCR5).  As a result boot
> > variables that point to the same UEFI application but with different
> > optional data,  will have distinct measurements.
> >
> 
> That is not the main problem. The main problem is that
> LoadImage()/StartImage() may be used to invoke things beyond Boot####
> options, and at StartImage() time, the load options could be anything.
> So not measuring the load options when the image is actually being
> invoked is a huge oversight.

Fair enough, I'll update the description

> 
> 
> > However, PCR5 is used for more than that and there might be a need to use
> > +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > @@ -370,6 +370,27 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
> >         int options_bytes = 0, safe_options_bytes = 0;  /* UTF-8 bytes */
> >         bool in_quote = false;
> >         efi_status_t status;
> > +       static const struct efi_measured_event load_options_tcg2_event = {
> > +               {
> > +                       sizeof(load_options_tcg2_event) + sizeof("Load Options"),
> > +                       {
> > +                               sizeof(load_options_tcg2_event.event_data.event_header),
> > +                               EFI_TCG2_EVENT_HEADER_VERSION,
> > +                               9,
> > +                               EV_EVENT_TAG,
> > +                       },
> > +               },
> > +               {
> > +                       LOAD_OPTIONS_EVENT_TAG_ID,
> > +                       sizeof("Load Options"),
> > +               },
> > +               { "Load Options" },
> > +       };
> > +
> > +       if (options_chars > 0)
> > +               efi_measure_tagged_event((unsigned long) options,
> > +                                        (unsigned long) options_chars,
> > +                                        &load_options_tcg2_event);
> >
> 
> The name 'options_chars' is a bit misleading here, as it is actually
> the size in bytes at this point.

True but any suggestions on how to fix this? Rename the declaration?

> 
> >         efi_apply_loadoptions_quirk((const void **)&options, &options_chars);
> >         options_chars /= sizeof(*options);
> > diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> > index cb7eb5ed9f14..e3605b383964 100644
> > --- a/drivers/firmware/efi/libstub/efistub.h
> > +++ b/drivers/firmware/efi/libstub/efistub.h
> > @@ -741,6 +741,7 @@ union apple_properties_protocol {
> >  typedef u32 efi_tcg2_event_log_format;
> >
> >  #define INITRD_EVENT_TAG_ID 0x8F3B22ECU
> > +#define LOAD_OPTIONS_EVENT_TAG_ID 0x8F3B22EDU
> 
> Is this an arbitrarily chosen value?

Yea.  As far as events are concerned I've found 2 event types:
- EV_IPL: This event is deprecated for platform
  firmware. It may be used by Boot Manager
  Code to measure events
- EV_EVENT_TAG: Used for PCRs defined for OS and
  application usage.  Defined for use by Host Platform Operating
  System or Software.

The latter seemed better for our case and it must include a 
'struct TCG_PCClientTaggedEvent' in the event. 
The first member of that struct is the ID which is a unique identifier
defined by the measuring OS or application. 

Cheers
/Ilias

> 
> >  #define EV_EVENT_TAG 0x00000006U
> >  #define EFI_TCG2_EVENT_HEADER_VERSION  0x1
> >
> > --
> > 2.34.1
> >
