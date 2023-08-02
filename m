Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA0776D4AC
	for <lists+linux-efi@lfdr.de>; Wed,  2 Aug 2023 19:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjHBRGY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Aug 2023 13:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjHBRGW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Aug 2023 13:06:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BCAE57;
        Wed,  2 Aug 2023 10:06:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A89BF61A4F;
        Wed,  2 Aug 2023 17:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C88C433D9;
        Wed,  2 Aug 2023 17:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690995979;
        bh=skWUi5PcvVm7aAMMh7p/LFLr6m46fzBWFlwr2mR+KqQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t8q5cK8/F3VUNLPrZvxOWjfUw38QnpP2qxI4w1cVIAj64yQx0v1jm90/IIAvi9FAC
         hQ76tJw4gTPD+8fUVgVgamRQqmEOKPqIOTvZf3hc75Bkrwa4/RHs/bFQTNnGi9M2vA
         9tOC4Co75ohZk2g56b/xDj07zqhLumhox99xFLfCQX6kyju5XTJNpgTCppvOumZDMJ
         gO2XqQCH6eb+jlvXXZzTl53eQFXEwRYUy79+D0Ue9uo7UfVZXI1RnjgU6kqaI9DHq/
         2oWcZIqHjKvvv6uMiz7Dy/IiLcL1OTe57bA5EmyaDeblI/opln3F/VPuhShpuM2L8g
         18w9S7D1WQ/5A==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so62836e87.3;
        Wed, 02 Aug 2023 10:06:18 -0700 (PDT)
X-Gm-Message-State: ABy/qLapVkcbfcuJXwHFloqAvEgBH12O1Mbtiu4FXOOjkVXzq0D9TSQV
        QKKeB9yVGgexMBG40MOEDPbhuGRXmw+8GYxNs/w=
X-Google-Smtp-Source: APBJJlH8aHl8Ev+dsn2WRGd0DFDDeHJfddSlwE3ce49skr8nvJR+ykykzAuC1gEm+0c6TMr5KHuo6lrxbhdnErNWIzc=
X-Received: by 2002:a19:ca0b:0:b0:4f6:2b25:194e with SMTP id
 a11-20020a19ca0b000000b004f62b25194emr4208508lfg.58.1690995977047; Wed, 02
 Aug 2023 10:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230802151704.2147028-1-ardb@kernel.org> <20230802164603.fzy2lmflp4iann5c@box>
In-Reply-To: <20230802164603.fzy2lmflp4iann5c@box>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 2 Aug 2023 19:06:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGThVygFZNry+tBGdzw0XrFhOiWL_RFYRBy7p1oyT4LOQ@mail.gmail.com>
Message-ID: <CAMj1kXGThVygFZNry+tBGdzw0XrFhOiWL_RFYRBy7p1oyT4LOQ@mail.gmail.com>
Subject: Re: [PATCH v2] efi/x86: Ensure that EFI_RUNTIME_MAP is enabled for kexec
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
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

On Wed, 2 Aug 2023 at 18:46, Kirill A . Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Wed, Aug 02, 2023 at 05:17:04PM +0200, Ard Biesheuvel wrote:
> > CONFIG_EFI_RUNTIME_MAP needs to be enabled in order for kexec to be able
> > to provide the required information about the EFI runtime mappings to
> > the incoming kernel, regardless of whether kexec_load() or
> > kexec_file_load() is being used. Without this information, kexec boot in
> > EFI mode is not possible.
> >
> > The CONFIG_EFI_RUNTIME_MAP option is currently directly configurable if
> > CONFIG_EXPERT is enabled, so that it can be turned on for debugging
> > purposes even if KEXEC is. However, the upshot of this is that it can
>
> s/is/isn't/ ?
>

indeed, will fix.
