Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B571D796D9B
	for <lists+linux-efi@lfdr.de>; Thu,  7 Sep 2023 01:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjIFX2G (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 Sep 2023 19:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236954AbjIFX2F (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 6 Sep 2023 19:28:05 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C351BC2
        for <linux-efi@vger.kernel.org>; Wed,  6 Sep 2023 16:28:00 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34e1ddc38c6so1341665ab.3
        for <linux-efi@vger.kernel.org>; Wed, 06 Sep 2023 16:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694042880; x=1694647680; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AFyiC8eHkWIMwsI59KIjZiFw1+6YiNLMABtanoGSqWg=;
        b=i5dHf90djM/djmRS79tLCLXD2yHi/5Nhl46wTerHlOfM0iuwYXQ9+2iC40NwnDhUx7
         DusysM9RNAfC5mNyfAsdlREc6PWSx50WLAqp4UXyNueqOmY68j6uFyeM2zgOt0vfXaMF
         nTDuJ9EQaHYGbdIiM/vKTGCXq1A2tVf5AMtOBMNT7dTZYQBi4mSovyQpJAAZdWbjYFTp
         W6KOg+Yvqk8Z0D7fwbea63KMBx10uGQWOyfz5JIUDQ+4DfJ18oMoCSODncNClDlm5209
         vsdJ3p7sv5PTDJgpVOJZUMcvoQHe1t8KtVx+yXbVS6GJar5xDb4KCWbSpqHRP100G6nK
         k24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694042880; x=1694647680;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AFyiC8eHkWIMwsI59KIjZiFw1+6YiNLMABtanoGSqWg=;
        b=ZnyqTpx6K0Prl8U9kkHA5FowhGLNoRv637rzQ5mJ+t6bQTBp7wGDGV22Wsww63FW9s
         IdMrBUxRiQGdyjb38zKGxjwP6KTh/NHNKKibpsqZmN0zgrD7uGvQE2oqSEmr0765dofO
         vpSlAUN3vNixO5aFSIq0tDBR6NkU/3oLUI8VQh0p9BCxBBcwUPfH1z8kGOtqwU4iLPC8
         f5kiCvYXUjNieoFKQXb6uVsK6SKk3Ka1+wP1K5QRI4/9fVO4Akxdv3pr21IO+GP6UEMi
         tesDPNRvY3M3DGhRVHHm4gOVlpFOXJkElif/hPXCgyk888wyVtSMk14CdM945A2cSEb0
         0UKg==
X-Gm-Message-State: AOJu0Ywcu+AjTg+lEpx740PMcBMrjmzN+2Z2jJPRGNoJ+sfNYgqxU6rO
        jopNTnWLwsjtUXAQO3wGi4A3tw==
X-Google-Smtp-Source: AGHT+IEW3bEf1qwaoHwHqiJ2ntB4DNfwsVgOuUsOTx0tFEGdDUuCnEPdyg3nAaGE1emGXhAqinGv/Q==
X-Received: by 2002:a05:6e02:cb1:b0:34c:dd54:10c6 with SMTP id 17-20020a056e020cb100b0034cdd5410c6mr17981765ilg.12.1694042879889;
        Wed, 06 Sep 2023 16:27:59 -0700 (PDT)
Received: from ghost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id ca1-20020a17090af30100b00260a5ecd273sm296537pjb.1.2023.09.06.16.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 16:27:59 -0700 (PDT)
Date:   Wed, 6 Sep 2023 16:27:56 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 0/5] riscv: Introduce KASLR
Message-ID: <ZPkK/MNGKZIW2mvc@ghost>
References: <20230722123850.634544-1-alexghiti@rivosinc.com>
 <CABCJKucj78p4TBtXYmMdJ=vYK69XC=XU06uB+_fyfZLRnC4h0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABCJKucj78p4TBtXYmMdJ=vYK69XC=XU06uB+_fyfZLRnC4h0A@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 30, 2023 at 02:30:31PM -0700, Sami Tolvanen wrote:
> Hi Alexandre,
> 
> On Sat, Jul 22, 2023 at 5:39 AM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
> >
> > The following KASLR implementation allows to randomize the kernel mapping:
> >
> > - virtually: we expect the bootloader to provide a seed in the device-tree
> > - physically: only implemented in the EFI stub, it relies on the firmware to
> >   provide a seed using EFI_RNG_PROTOCOL. arm64 has a similar implementation
> >   hence the patch 3 factorizes KASLR related functions for riscv to take
> >   advantage.
> >
> > The new virtual kernel location is limited by the early page table that only
> > has one PUD and with the PMD alignment constraint, the kernel can only take
> > < 512 positions.
> >
> > base-commit-tag: v6.5-rc1
> 
> Thanks for continuing to work on this!
> 
> I reviewed the patches and the code looks correct to me. I also
> applied the series on top of v6.5 and after patching qemu to provide a
> kaslr-seed, I confirmed that the virtual offset appears to be random
> and is printed out when I panic the machine:
> 
> # echo PANIC > /sys/kernel/debug/provoke-crash/DIRECT
> [   17.510012] lkdtm: Performing direct entry PANIC
> [   17.510411] Kernel panic - not syncing: dumptest
> [...]
> [   17.518693] Kernel Offset: 0x32c00000 from 0xffffffff80000000
> 
> For the series:
> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
> 
> I didn't test the EFI bits, but the rest of the series:
> Tested-by: Sami Tolvanen <samitolvanen@google.com>
> 
> Conor, in another reply you mentioned you're planning on reviewing the
> patches as well. Did you have any feedback or concerns?
> 
> Sami
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

In addition to testing this patch in QEMU by patching like Sami did, I
also booted this with a Debian kernel and tested it with EFI. I was able
to use lkdtm as Sami did to force a panic and see the kernel offset
changing in both scenarios.

Tested-by: Charlie Jenkins <charlie@rivosinc.com>

- Charlie
