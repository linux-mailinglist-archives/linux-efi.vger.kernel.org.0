Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2205C60EAC4
	for <lists+linux-efi@lfdr.de>; Wed, 26 Oct 2022 23:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiJZVUl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Oct 2022 17:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbiJZVUi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Oct 2022 17:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D782B72FD8;
        Wed, 26 Oct 2022 14:20:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC983620D4;
        Wed, 26 Oct 2022 21:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF94C43144;
        Wed, 26 Oct 2022 21:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666819234;
        bh=xFK9vhrZ57tkHdq2fZio/r4aau2MYUNcvDSiX8wbTWw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cQEPR/5XQ0hjK8EAMbPf7nTle28yI0S3UPvvIB50hKl6qPesnnvi9qOn7y6spU2XS
         kGfv3CLZAPAdcSdJizqDJZ+rtp+BykHurb4hbEyQG3oA5n6Zckipdcp/TLhLypiX2I
         8EKPqdbbx8hDQZYY94WvsyRR5fewmyi7xzRvdPm4S900Dvrw1plSZuezywRZh0PSA6
         s3H6i3XQ14FT7EMYbv7VfhNEdhNYybxWdS3wzZlC44+EjXWtmP4EPHRNig2e2OBER+
         fzRRfmg9W7QEz/Mtg3u59r0mSVKOhJJtkbI5/KAaa5A77SOv4++ubBJF+s6gR/TtyM
         yU0y8bryGooog==
Received: by mail-lf1-f44.google.com with SMTP id d6so31431809lfs.10;
        Wed, 26 Oct 2022 14:20:34 -0700 (PDT)
X-Gm-Message-State: ACrzQf3khWeMkd8lEIFPO1+OxJxWLm68Yml78XS+rJAjokasnbtJMxP9
        22DAd9MXDdgPpozYDZbVDlDxSLDth9LXg5VRroM=
X-Google-Smtp-Source: AMsMyM5IsxplRe36IJzIWtBYJAncStThHmClzt0VaxyESyFwze6QetkEewKgVu/d7mnhP+NQRyjCSGJ6MDIvSWO3Rg4=
X-Received: by 2002:a05:6512:3119:b0:4a2:d749:ff82 with SMTP id
 n25-20020a056512311900b004a2d749ff82mr17759347lfb.637.1666819232150; Wed, 26
 Oct 2022 14:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <23DC077F-69DF-402C-A940-2E7EEABF2D97@live.com>
 <CAMj1kXG03-0AdM_ROf2UhH-N2Z52v7ox_emSQw=y5p3sMeTrMA@mail.gmail.com> <E48DD0F8-D9C5-4BD2-87A9-CFF0C22D0447@live.com>
In-Reply-To: <E48DD0F8-D9C5-4BD2-87A9-CFF0C22D0447@live.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 26 Oct 2022 23:20:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH+ZQNcGXk96ta6SmAkU_hTCnCgU_AH0UbeAbfZtr83CA@mail.gmail.com>
Message-ID: <CAMj1kXH+ZQNcGXk96ta6SmAkU_hTCnCgU_AH0UbeAbfZtr83CA@mail.gmail.com>
Subject: Re: [REGRESSION] Failure to write the NVRAM variables starting from
 kernel 6.0 on T2 Macs
To:     Aditya Garg <gargaditya08@live.com>
Cc:     "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>,
        "jk@ozlabs.org" <jk@ozlabs.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orlando Chamberlain <redecorating@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 26 Oct 2022 at 23:18, Aditya Garg <gargaditya08@live.com> wrote:
>
> Hi Ard
>
> Just a friendly reminder to get updates on the patch you asked me to test, as it seems to fix my issue.
>

This should be fixed now in v6.1-rc2


> > Thanks for the report. I did identify an issue in some refactoring
> > work of the efivars layer that went into 6.0
> >
> > Can you please check whether the change below fixes the issue for you?
> >
> > diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> > index dd74d2ad3184..35edba93cf14 100644
> > --- a/drivers/firmware/efi/vars.c
> > +++ b/drivers/firmware/efi/vars.c
> > @@ -209,7 +209,7 @@ efivar_set_variable_blocking(efi_char16_t *name,
> > efi_guid_t *vendor,
> >        if (data_size > 0) {
> >                status = check_var_size(attr, data_size +
> >                                              ucs2_strsize(name, 1024));
> > -               if (status != EFI_SUCCESS)
> > +               if (status != EFI_SUCCESS && status != EFI_UNSUPPORTED)
> >                        return status;
> >        }
> >        return __efivars->ops->set_variable(name, vendor, attr,
> > data_size, data);
> > @@ -242,7 +242,7 @@ efi_status_t
> > efivar_set_variable_locked(efi_char16_t *name, efi_guid_t *vendor,
> >        if (data_size > 0) {
> >                status = check_var_size_nonblocking(attr, data_size +
> >
> > ucs2_strsize(name, 1024));
> > -               if (status != EFI_SUCCESS)
> > +               if (status != EFI_SUCCESS && status != EFI_UNSUPPORTED)
> >                        return status;
> >        }
> >        return setvar(name, vendor, attr, data_size, data);
>
> Regards
> Aditya
