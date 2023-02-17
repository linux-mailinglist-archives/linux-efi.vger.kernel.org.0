Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E8E69AEB8
	for <lists+linux-efi@lfdr.de>; Fri, 17 Feb 2023 15:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjBQO6s (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Feb 2023 09:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjBQO5s (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Feb 2023 09:57:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26616F7CC;
        Fri, 17 Feb 2023 06:57:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A45C9B82C3B;
        Fri, 17 Feb 2023 14:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5798C4339B;
        Fri, 17 Feb 2023 14:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676645837;
        bh=BTFggd/Tt+eYMh7lG7jR9TXG1g1R8MGJ9JNjMNiGaD4=;
        h=From:To:Cc:Subject:In-Reply-To:Date:From;
        b=i049caV7QowGeYyrdkLo2D7kaH90CDnl/kJLMQvMx6LXEwaa60eKsV5DFFCk+T1OU
         gesF9+EJKdUhEXCRH0YQ3cGkAlw8KAYxrVvk0t6SyETurpMYYV+H2qLNgSMDIBTEAE
         Erg7vWUni8MpsyNL9TrX+xq09LF5ICFlqTFPjsjV3FDtqKyAJusbDT4/QQ7CYUYBVc
         3aXUnJNGLy6MfL/CcDT0cUOR+/+uap4YfGqU+irMPimYuYGevTQwjtN5pDkE87E9uL
         /tn8BPSYaLH9Jym1fa6rxX2EE8HIGfWB95raBC19SBWS7kAWatBSaOGgisbMnt7cbd
         TFuNvxspTPNow==
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
Subject: Re: [PATCH v4 6/6] riscv: Unconditionnally select KASAN_VMALLOC if
 KASAN
In-Reply-To: <20230203075232.274282-7-alexghiti@rivosinc.com>
Date:   Fri, 17 Feb 2023 15:57:14 +0100
Message-ID: <877cwguyph.fsf@all.your.base.are.belong.to.us>
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

> If KASAN is enabled, VMAP_STACK depends on KASAN_VMALLOC so enable
> KASAN_VMALLOC with KASAN so that we can enable VMAP_STACK by default.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
