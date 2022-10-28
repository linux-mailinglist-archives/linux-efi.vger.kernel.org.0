Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD0B61177D
	for <lists+linux-efi@lfdr.de>; Fri, 28 Oct 2022 18:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiJ1Q0d (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Oct 2022 12:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiJ1Q0c (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Oct 2022 12:26:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C31C1EEA12
        for <linux-efi@vger.kernel.org>; Fri, 28 Oct 2022 09:26:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE8C9B82AF5
        for <linux-efi@vger.kernel.org>; Fri, 28 Oct 2022 16:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922F4C433C1
        for <linux-efi@vger.kernel.org>; Fri, 28 Oct 2022 16:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666974389;
        bh=radQyyQtgbGcMwGty+11r+nwIhqFzEM4gNZ5fZWBSE4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NSIr/3A1xidCVD9jjF9VXARpW+Swe3rGc+wYpmCuUO3qvsJQ+kBlCSAUyDLkUytQb
         UvDBAHsm1jN4hEf4ar3HOw7w+u95sgqKauD1kSCcWrUfVgpZGwlKkcBxTVeCxVQ4KM
         PS9bFF7eRp/zY6Meyh13XKILVpA0bwT4OlJfTgMUcGVTqI6VTkEMZmiGf29aFRxjyz
         ucKsoppChTiI26yZfawkBfqcPArUSAjV8CYU2jNw1kjiDV/6Bn7HgLKRHkhwD803Rh
         G4FDCRnO+2+yZSuQzTC1l/ttFVBDQ+8yr32pCbZ6aPCKGMhw+KY4imeeWQ/R8M4tBO
         a6th3qMptN9lg==
Received: by mail-lf1-f44.google.com with SMTP id be13so9148630lfb.4
        for <linux-efi@vger.kernel.org>; Fri, 28 Oct 2022 09:26:29 -0700 (PDT)
X-Gm-Message-State: ACrzQf3oA28etBy1lxeQuhBP6dJwB9i+DfllGBg9nco6RpA584pDS68d
        Xhj8qzak2JaiGrsU0MWD3rM/uf/8cIFpm4sixU0=
X-Google-Smtp-Source: AMsMyM4+sVH6M0pO/WXgEbSlPpt7R5Vh8lxorHVZ8z8dO29fMv6Xu2AW+CTzXDIok6RPqCDfDD8UlZ/LBq/hHJKPt18=
X-Received: by 2002:a19:c20b:0:b0:4a2:40e5:78b1 with SMTP id
 l11-20020a19c20b000000b004a240e578b1mr65345lfc.228.1666974387568; Fri, 28 Oct
 2022 09:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221027135755.1732339-1-ardb@kernel.org> <0DE4AE6B-4437-4D5C-BE0E-3FE732EE8000@live.com>
In-Reply-To: <0DE4AE6B-4437-4D5C-BE0E-3FE732EE8000@live.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 28 Oct 2022 18:26:16 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG8YC2n1by_39fVBGgLV+NvHmS5AqSeLFozS9tpocq9tg@mail.gmail.com>
Message-ID: <CAMj1kXG8YC2n1by_39fVBGgLV+NvHmS5AqSeLFozS9tpocq9tg@mail.gmail.com>
Subject: Re: [PATCH] efi: efivars: Fix variable writes with unsupported query_variable_store()
To:     Aditya Garg <gargaditya08@live.com>
Cc:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 28 Oct 2022 at 14:21, Aditya Garg <gargaditya08@live.com> wrote:
>
>
>
> Hi Ard
>
> This patch you sent fixed my issue!
>

Thanks for testing!


> > On 27-Oct-2022, at 7:27 PM, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Commit 8a254d90a775 ("efi: efivars: Fix variable writes without
> > query_variable_store()") addressed an issue that was introduced during
> > the EFI variable store refactor, where alternative implementations of
> > the efivars layer that lacked query_variable_store() would no longer
> > work.
> >
> > Unfortunately, there is another case to consider here, which was missed:
> > if the efivars layer is backed by the EFI runtime services as usual, but
> > the EFI implementation predates the introduction of QueryVariableInfo(),
> > we will return EFI_UNSUPPORTED, and this is no longer being dealt with
> > correctly.
> >
> > So let's fix this, and while at it, clean up the code a bit, by merging
> > the check_var_size() routines as well as their callers.
> >
>
> Thanks
> Aditya
