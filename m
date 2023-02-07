Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBDF68D19C
	for <lists+linux-efi@lfdr.de>; Tue,  7 Feb 2023 09:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjBGIoW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Feb 2023 03:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjBGIoW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Feb 2023 03:44:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C46975F;
        Tue,  7 Feb 2023 00:44:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5262EB816BF;
        Tue,  7 Feb 2023 08:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3210C4339B;
        Tue,  7 Feb 2023 08:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675759458;
        bh=uIFZ6C+dgvqZ2HFhkvL6C0xfNCDjt7/o6qgCfeq7fWc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ma4Rnx03MnBDSv7NBePrO9s8eXbuDDmnuqcyF/ChHcKOLYVMr6TxWzczh8YkwQ2yx
         ZqMLnnoxyIJaiMlFvnip4QhcK/H8C+CqsCYEiSpzlqkWhZcutnPRbdo/rTxfBXV1S7
         Lt7HrSnq9C2l3Gfhq3px/HUIEng1ryoWSZUi5mjLMuPze8UHuRTJfzQ2icKIeB1/rh
         f1D6zGA5nBv6hty0x8+tKmfHRCHPd5kJmVDhBn9+lLVs4mymGQSdMNQCD6zeXtXOe9
         +4Y930DqnMTYjqgWN2ucDFVS61R8+bnxHFLcgD4qpDY+wzwbqy8NcaEs5+BF7OmRE0
         zeIYmAUm5hOqg==
Received: by mail-lj1-f177.google.com with SMTP id h4so14758469lja.2;
        Tue, 07 Feb 2023 00:44:16 -0800 (PST)
X-Gm-Message-State: AO0yUKUWqO6pgVodqzUiSgqp/wdZuXmHAV2//rw0XLJpKdwO7C1BR7P9
        InJKHVz6PJQhTRP+fAQeNYPwqinHQJLV7ovVPaI=
X-Google-Smtp-Source: AK7set/bHazqwePHFFINFuJAswX+GNy5VqD+MiexpeWuQYU0k1J46ViK6/39NayfRuNVhQhPh7BlthQTdqE3en2m56w=
X-Received: by 2002:a05:651c:3c6:b0:290:5011:2332 with SMTP id
 f6-20020a05651c03c600b0029050112332mr300579ljp.120.1675759455022; Tue, 07 Feb
 2023 00:44:15 -0800 (PST)
MIME-Version: 1.0
References: <20230131040355.3116-1-justin.he@arm.com> <CAMj1kXFTUXgaENBSYh+cGCS3wFCFunf+auk3nKwHVJWiZ7crig@mail.gmail.com>
 <DBBPR08MB45383B479656BA18FEFFB7D5F7D09@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y9lchEgyNGLKu/4R@zx2c4.com> <DBBPR08MB4538E2CE68BCBF15B9F0093AF7D69@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <DBBPR08MB4538A07A62DC4A10257B3277F7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
In-Reply-To: <DBBPR08MB4538A07A62DC4A10257B3277F7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 7 Feb 2023 09:44:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFE7A0=+MA2tCtuwjeGMcc1hgzvDnEJy1xGE=fh9Kgc2Q@mail.gmail.com>
Message-ID: <CAMj1kXFE7A0=+MA2tCtuwjeGMcc1hgzvDnEJy1xGE=fh9Kgc2Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix boot hang issue on Ampere Emag server
To:     Justin He <Justin.He@arm.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 7 Feb 2023 at 04:21, Justin He <Justin.He@arm.com> wrote:
>
> Hi Ard
>
> > -----Original Message-----
> [...]
> > As your suggested (comment above execute_with_initialized_rng in latest
> > kernel):
> > The efibootmgr -t X will be hung. Looks like one certain commit before =
your
> > patch broke the set_variable efi call. I will dig into the further debu=
g and tell
> > you the result.
>
> The root cause of the hung IMO might be similar to
> commit 550b33cfd445296868a478e8413ffb2e963eed32
> Author: Ard Biesheuvel <ardb@kernel.org>
> Date:   Thu Nov 10 10:36:20 2022 +0100
>
>     arm64: efi: Force the use of SetVirtualAddressMap() on Altra machines
>
> Do you agree with the idea if I add Ampere =E2=80=9DeMAG=E2=80=9D machine=
 into the list of
> Using SetVirtualAddressMap() forcibly?
>
> Please note that even in previous kernel patch, the efibootmgr -t 10 will=
 make
> kernel hung if I passed "efi=3Dnovamap" to the boot parameter.
>

Interesting. What does dmidecode return for the family in the type 1 record=
?
