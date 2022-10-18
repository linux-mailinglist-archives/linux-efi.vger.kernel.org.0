Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878B2602AD4
	for <lists+linux-efi@lfdr.de>; Tue, 18 Oct 2022 13:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJRL7z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Oct 2022 07:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJRL7N (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Oct 2022 07:59:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4906EBD05E
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 04:58:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4246AB81EB0
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 11:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D22CC433D6;
        Tue, 18 Oct 2022 11:58:02 +0000 (UTC)
Date:   Tue, 18 Oct 2022 12:57:59 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, keescook@chromium.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 03/21] arm64: efi: Move efi-entry.S into the libstub
 source directory
Message-ID: <Y06Ux2qMSGu5jro5@arm.com>
References: <20221017171700.3736890-1-ardb@kernel.org>
 <20221017171700.3736890-4-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017171700.3736890-4-ardb@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Oct 17, 2022 at 07:16:42PM +0200, Ard Biesheuvel wrote:
> We will be sharing efi-entry.S with the zboot decompressor build, which
> does not link against vmlinux directly. So move it into the libstub
> source directory so we can include in the libstub static library.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
