Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AA1677A8B
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jan 2023 13:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjAWMGY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Jan 2023 07:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjAWMGX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Jan 2023 07:06:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72539008;
        Mon, 23 Jan 2023 04:06:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24DD4B80CB1;
        Mon, 23 Jan 2023 12:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49BFC4339C;
        Mon, 23 Jan 2023 12:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674475579;
        bh=YB38QU59UEOqm7ADbTysVzycOZ08uNvIpt0U3juErFU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sIyaIVk/xBEwPCDP/Aq1mufXGJlaMduvBrJjyPWiePqon65h33Hl+lhUihZn7vzbO
         50JgV5hZhXnne3a+gATjY9clUimNx+fz9K3xoSjXfhVD4Np3ZzQt1n7STjuhSvEdL/
         +hJqArUyhmxhbGLs3UkFFtqh6I58OYCtkTBJU1hNNzrvQu/yzR0Yb+2NQSKdJHdJ3z
         A+2tcTZmsHUe21PYnkiCZawGoceIaoSukaJK4ytglsqH3jT9trWO0ltRzA1wMN+LMl
         1mJAWQqD2T93lsTRzll91A2H7CBSo7UOyDqoD4Ai8CdPb3KY94ZxjizLCY/AVljyZE
         ZgvnmvCdca6Qw==
Received: by mail-lf1-f49.google.com with SMTP id g13so17801370lfv.7;
        Mon, 23 Jan 2023 04:06:19 -0800 (PST)
X-Gm-Message-State: AFqh2kpGrjI81R6CM/xL4iu4wM7ICnpHw420ZkF/QZ0hNGEMgXZvhTv3
        KYDcCEMisPJibHNpIUxWidkKyactnxD1AwE1hbg=
X-Google-Smtp-Source: AMrXdXv4bOFImaFVPX5qGqiZLtY3AlufsTuh/HuMtRDfAfpVxGs2BPHBw9l7n5BJIQc30rkhov5ScxpkqvUIqhDeY/0=
X-Received: by 2002:ac2:4bd5:0:b0:4d5:76af:f890 with SMTP id
 o21-20020ac24bd5000000b004d576aff890mr1248969lfq.228.1674475577848; Mon, 23
 Jan 2023 04:06:17 -0800 (PST)
MIME-Version: 1.0
References: <20230119164255.28091-1-johan+linaro@kernel.org>
In-Reply-To: <20230119164255.28091-1-johan+linaro@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 23 Jan 2023 13:06:06 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGpk9AF42TRPFbCBSWtsVj-0_YTnJiSd_QEpXC0ZDSQQg@mail.gmail.com>
Message-ID: <CAMj1kXGpk9AF42TRPFbCBSWtsVj-0_YTnJiSd_QEpXC0ZDSQQg@mail.gmail.com>
Subject: Re: [PATCH 0/4] efi: verify that variable services are supported
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>, Jeremy Kerr <jk@ozlabs.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 19 Jan 2023 at 17:45, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> This series adds a sanity check to make sure that the variable services
> are actually available before registering the generic efivar ops.
>
> This is used to address some potential races with custom efivars
> implementation such as the Google SMI or upcoming Qualcomm SCM ones.
>
> Specifically, efivarfs currently requires that the efivar ops have been
> registered before module init time even though the Google driver can be
> built as a module. Instead, the driver has so far relied on the fact
> that the generic ops have been registered by efi core only to later be
> overridden by the custom implementation (or Google doesn't use
> efivarfs).
>
> Instead, let's move the efivars sanity check to mount time to allow for
> late registration of efivars.
>
> Note that requiring that all efivars implementation to always be
> built-in and registered before module init time could be an alternative,
> but we'd still need to make sure that the custom implementation is then
> not overridden by the default (broken) one. To avoid such init call
> games, allowing late registration seems preferable.
>
> This would however require any drivers that use efivars to probe defer
> until it becomes available, which is also unfortunate, but possibly
> still better than having generic kernels carry multiple built-in efivars
> implementations.
>
> Note that there are currently no such (efivars consumer) drivers in-tree
> except for the efivars_pstore driver, which currently do rely on
> efivarfs being available at module init time (and hence may fail to
> initialise with the custom efivar implementations).
>
> Johan
>
>
> Johan Hovold (4):
>   efi: efivars: add efivars printk prefix
>   efivarfs: always register filesystem
>   efi: verify that variable services are supported
>   efi: efivars: prevent double registration
>

Queued up in efi/next - thanks.

>  drivers/firmware/efi/efi.c  | 22 ++++++++++++++++++++++
>  drivers/firmware/efi/vars.c | 17 ++++++++++++++---
>  fs/efivarfs/super.c         |  6 +++---
>  3 files changed, 39 insertions(+), 6 deletions(-)
>
> --
> 2.38.2
>
