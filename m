Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BF35BE281
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 11:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiITJzk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 05:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiITJzk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 05:55:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617E466104;
        Tue, 20 Sep 2022 02:55:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F16F362896;
        Tue, 20 Sep 2022 09:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4406CC433D6;
        Tue, 20 Sep 2022 09:55:35 +0000 (UTC)
Date:   Tue, 20 Sep 2022 10:55:31 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v5 6/8] arm64: efi: enable generic EFI compressed boot
Message-ID: <YymOEwJsyHqxn4Te@arm.com>
References: <20220910081152.2238369-1-ardb@kernel.org>
 <20220910081152.2238369-7-ardb@kernel.org>
 <CAMj1kXHFsSUHjyuwj3aThoq=oZdEJca9XSCu=Fbkhk+qTj6khQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHFsSUHjyuwj3aThoq=oZdEJca9XSCu=Fbkhk+qTj6khQ@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Sep 17, 2022 at 06:36:38PM +0200, Ard Biesheuvel wrote:
> On Sat, 10 Sept 2022 at 10:12, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Wire up the generic EFI zboot support for arm64.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> 
> I've queued up most of this now for 6.1 - Catalin, Will, any
> objections if I queue this one as well via the efi tree?

No objections.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
