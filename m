Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F3A69AED0
	for <lists+linux-efi@lfdr.de>; Fri, 17 Feb 2023 16:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjBQPAb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Feb 2023 10:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjBQPA3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Feb 2023 10:00:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BAC7290D;
        Fri, 17 Feb 2023 07:00:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84BE9B82A26;
        Fri, 17 Feb 2023 14:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECF2C433D2;
        Fri, 17 Feb 2023 14:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676645931;
        bh=MtqNCOwgfK+uXpcr0rZdEnDp31xRiNLfgJsnxPeWYqI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Y+nxlJ/gcm1x1jXsY3cF3B2F4DeZFxJ9wZOVnugbYAbAfjCUaUNp6p8wLm6FsPubc
         y2vH2kqB56EDNmv6n9vtjALmNGH0PYbk1CIRl/oF53U5XcUxCzzv9XtK04QMvq4Qhg
         n8t43QZ+dFseHw1S4ynHE9XUtR4jMpd2TtHiKWBgTrrnP9fdYcYAmbp4ojbYCkQni9
         4JWBeXVn+vRxHUTHYiG8pQT89DD73jY/kZVn5jLYwZklPZsb1ujOFPKmcJKTzRnW6X
         e7Z54JinCqoqpi2P+C/zcmlGwW5QT/aNTofmP7TJgXMt/maIyvhVUGBl4v5sE6sAGU
         6ClN341Ryg/0A==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v4 3/6] riscv: Move DTB_EARLY_BASE_VA to the kernel
 address space
In-Reply-To: <20230203075232.274282-4-alexghiti@rivosinc.com>
References: <20230203075232.274282-1-alexghiti@rivosinc.com>
 <20230203075232.274282-4-alexghiti@rivosinc.com>
Date:   Fri, 17 Feb 2023 15:58:48 +0100
Message-ID: <873574uymv.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> The early virtual address should lie in the kernel address space for
> inline kasan instrumentation to succeed, otherwise kasan tries to
> dereference an address that does not exist in the address space (since
> kasan only maps *kernel* address space, not the userspace).
>
> Simply use the very first address of the kernel address space for the
> early fdt mapping.
>
> It allowed an Ubuntu kernel to boot successfully with inline
> instrumentation.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
