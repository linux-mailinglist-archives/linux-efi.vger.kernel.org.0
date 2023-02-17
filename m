Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F9A69AE8E
	for <lists+linux-efi@lfdr.de>; Fri, 17 Feb 2023 15:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjBQO4a (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Feb 2023 09:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjBQO4R (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Feb 2023 09:56:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BFC6929F;
        Fri, 17 Feb 2023 06:55:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4547B82C67;
        Fri, 17 Feb 2023 14:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6C4C4339E;
        Fri, 17 Feb 2023 14:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676645749;
        bh=oBBS7zR/ngaH2wd6CRyl7EabRqWFBiQfaWOFffYmUc8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=vDnmzDRwGg1Y7r6T+vj7LV3ZNvbmsbJ/x9QV+2r2wdY10XvTG8Ant9vGbspp4AVNV
         3R+sF4jaFbPV/p6kTDCy0aasGD5lnVdty1dYd5iYgkReORuEpGp00fjCM6YEjrvxyI
         FRCfQKkzaGMw+SuDpP0bMF847gJxyRQtdJaASHJPN+4mieXMa9Wk55HD1yerLeXUK/
         eHM1At6dQi0Uzf87CFZrR+fVq4dDQyes49uSxWATDB55O8xHs/Zrn7ctCvg8D9y3F2
         pBcmjVEWAPDOz1/Rxx17945EAJM4/CzEDi9y7+gVGbvMOVKUC66Nqf5K/e7pjIk16P
         VX1cWeWRMgPDg==
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
Subject: Re: [PATCH v4 5/6] riscv: Fix ptdump when KASAN is enabled
In-Reply-To: <20230203075232.274282-6-alexghiti@rivosinc.com>
References: <20230203075232.274282-1-alexghiti@rivosinc.com>
 <20230203075232.274282-6-alexghiti@rivosinc.com>
Date:   Fri, 17 Feb 2023 15:55:46 +0100
Message-ID: <87fsb4mjd9.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> The KASAN shadow region was moved next to the kernel mapping but the
> ptdump code was not updated and it appears to break the dump of the kernel
> page table, so fix this by moving the KASAN shadow region in ptdump.
>
> Fixes: f7ae02333d13 ("riscv: Move KASAN mapping next to the kernel mappin=
g")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
