Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D7B6AFD66
	for <lists+linux-efi@lfdr.de>; Wed,  8 Mar 2023 04:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCHDa1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Mar 2023 22:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCHDa0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Mar 2023 22:30:26 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EA35B5D5
        for <linux-efi@vger.kernel.org>; Tue,  7 Mar 2023 19:30:25 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 132so8859934pgh.13
        for <linux-efi@vger.kernel.org>; Tue, 07 Mar 2023 19:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678246225;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IrGumBD3CuL7JhmpbkRoYLuQ9iRztdyj8h7PwNT0G+k=;
        b=nMEKpiB7FONecJfzkjebJwCPpi28Dj2XGpP4GXKQ26ESvbaACwC342Din9Ax1xxY5L
         wbOddRCSnmwOYMksQw3Qdu5mRfQureAx5/i/16NCIUODZpYPqRkiko+kmKKPlNGUXiEA
         aXYE5iDy1t1/dC5gzdd2qFFMC2Lsk2FIHb4DgjPfQlZUyXgTvmE5yxVkScVuFdMXQ8N/
         9PY7FQJCGGsTo0VGTQrba5VHI8TNPXOxIBhzPzY2mCeDhoalLaOSxSq41Fd1BV+9Keyz
         gR3qvdUJN5o2gNrh+SlnHyTyO3n8fbOGKSIRdfzol8xhkDct4RQZ0bUznxP61irRCIEl
         RvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678246225;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrGumBD3CuL7JhmpbkRoYLuQ9iRztdyj8h7PwNT0G+k=;
        b=z+mI3T/UhIlzhGbmKoOnNb8Z/0xrvi+locXEjhoTlGnoBUhJbQtLalwBH2Nh3l4BjG
         JhJbnvb8mFQzcq0pNyDBal0v2tlC95DxYHRrTK296IXVJ2yaaFFNndII9iAVhmyEKkGV
         XQ7Vz95Va2/Gof5Rt2Pf0hJUBalcPvoQuW7Uw8SxYwg7Yg7meQXeX5KM1Rg8RZ5Q3ek/
         0+S+1lynjtPt5Em/APFmCAFLwMOGCP12UTD9BYlIP8sX51l5akcmfR3DSaVXlM87Yqge
         XlCJny3fTdOTRMJKU+UzGMUyXUO0sccsGDte9mctbr3W5hQIjQTubybF+aXhM7hnXYW5
         cOiw==
X-Gm-Message-State: AO0yUKVnT2kNpBX17njpzXsnHskQ25RFZJ1Ir7CaGWkG1tb/Lmn2c8Al
        LGe27KMan8ijkB7kIkQDgkeMVg==
X-Google-Smtp-Source: AK7set8hzVBuskesB4GYntZLwYi23Uwo1MfEphVfa6NFwFtmeKv9GeZ8e6GgiHrVvGj/l+Hl+mwyWQ==
X-Received: by 2002:a62:1758:0:b0:593:d2ab:fdfb with SMTP id 85-20020a621758000000b00593d2abfdfbmr13432662pfx.13.1678246225092;
        Tue, 07 Mar 2023 19:30:25 -0800 (PST)
Received: from localhost ([135.180.224.71])
        by smtp.gmail.com with ESMTPSA id n13-20020aa7904d000000b0058b927b9653sm8771578pfo.92.2023.03.07.19.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 19:30:24 -0800 (PST)
In-Reply-To: <20230203075232.274282-1-alexghiti@rivosinc.com>
References: <20230203075232.274282-1-alexghiti@rivosinc.com>
Subject: Re: [PATCH v4 0/6] RISC-V kasan rework
Message-Id: <167824615129.30763.10646446884793553712.b4-ty@rivosinc.com>
Date:   Tue, 07 Mar 2023 19:29:11 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-efi@vger.kernel.org, kasan-dev@googlegroups.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        linux-riscv@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Conor Dooley <conor@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On Fri, 3 Feb 2023 08:52:26 +0100, Alexandre Ghiti wrote:
> As described in patch 2, our current kasan implementation is intricate,
> so I tried to simplify the implementation and mimic what arm64/x86 are
> doing.
> 
> In addition it fixes UEFI bootflow with a kasan kernel and kasan inline
> instrumentation: all kasan configurations were tested on a large ubuntu
> kernel with success with KASAN_KUNIT_TEST and KASAN_MODULE_TEST.
> 
> [...]

Applied, thanks!

[1/6] riscv: Split early and final KASAN population functions
      https://git.kernel.org/palmer/c/70a3bb1e1fd9
[2/6] riscv: Rework kasan population functions
      https://git.kernel.org/palmer/c/fec8e4f66e4d
[3/6] riscv: Move DTB_EARLY_BASE_VA to the kernel address space
      https://git.kernel.org/palmer/c/1cdf594686a3
[4/6] riscv: Fix EFI stub usage of KASAN instrumented strcmp function
      https://git.kernel.org/palmer/c/415e9a115124
[5/6] riscv: Fix ptdump when KASAN is enabled
      https://git.kernel.org/palmer/c/fe0c8624d20d
[6/6] riscv: Unconditionnally select KASAN_VMALLOC if KASAN
      https://git.kernel.org/palmer/c/4cdc06c5c741

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

