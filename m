Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C286065F1
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 18:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJTQhm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 12:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJTQhl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 12:37:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E371F1C2F11
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 09:37:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DA66B827A3
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 16:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC4BC433B5
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 16:37:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Lvg8HUFc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666283853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+a8/I2NoG0L7bGEQqGeau7pQCMxH5pRROgLji8zUnBI=;
        b=Lvg8HUFcA7KzSpoq47es0nJ/NXsB+pmrLYFuvwCrRsRyg0biEyeBHro4IwTMR7L72K5akK
        TbPcpsmfM+RJaVnURyiWL4a/bhYo4n/qMHYRlUMjA8++MDDUGFbfyKqJXGPco32W+iH0Qo
        IBSXfSmSA7kAdEAqXbq4WIcnJv5VCy8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 04c3b889 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-efi@vger.kernel.org>;
        Thu, 20 Oct 2022 16:37:33 +0000 (UTC)
Received: by mail-ua1-f53.google.com with SMTP id y20so9993804uao.8
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 09:37:33 -0700 (PDT)
X-Gm-Message-State: ACrzQf0XbVL/qs1BkNp4B5wZXOE1BiwDPBibC+RN3uCmIJxIYqU1/49r
        v3lEIksVIZsoekSMVl5G/l/pyoMmUyYurCpDVoQ=
X-Google-Smtp-Source: AMsMyM4ByCCQOasSbdLUm3jQJPPnHJHYDJyldYl9Cmpvv/clB1x7n2jBJ5UaSv4eEd2CxnrQ+pI+BRza9jLYhEf9f78=
X-Received: by 2002:a67:df18:0:b0:3a9:f07f:876c with SMTP id
 s24-20020a67df18000000b003a9f07f876cmr1916485vsk.21.1666283852389; Thu, 20
 Oct 2022 09:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221020083910.1902009-1-ardb@kernel.org>
In-Reply-To: <20221020083910.1902009-1-ardb@kernel.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 20 Oct 2022 10:37:21 -0600
X-Gmail-Original-Message-ID: <CAHmME9rZCYDE7-nP4_tqPQzDv+Qfsyb5+igTCMe3wkftU8Sfuw@mail.gmail.com>
Message-ID: <CAHmME9rZCYDE7-nP4_tqPQzDv+Qfsyb5+igTCMe3wkftU8Sfuw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] efi: consume random seed provided by loader
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 20, 2022 at 2:40 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> For maximum simplicity, just concatenate the existing seed with the one
> obtained from EFI_RNG_PROTOCOL if both are available, and leave it to
> the core kernel code to mix it in and credit it appropriately. This way,
> we have no need for copies of the Blake2s library in the EFI stub and in
> the zboot decompressor.

FTR, while I think this is okay for the final stage that the kernel's
EFI loader does, it's less good for earlier stages. So, for example,
systemd-boot should still use the hashing scheme we discussed.
