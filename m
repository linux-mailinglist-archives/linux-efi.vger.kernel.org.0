Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FA21B4BAA
	for <lists+linux-efi@lfdr.de>; Wed, 22 Apr 2020 19:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgDVR0F (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Apr 2020 13:26:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgDVR0E (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 22 Apr 2020 13:26:04 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96DA82137B
        for <linux-efi@vger.kernel.org>; Wed, 22 Apr 2020 17:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587576364;
        bh=xCBiL4UeKrv7hAKUKJgAhkl/9W+XzwM+RZ7hgiggjLA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OR8qtC+sAwprVmhowaRIZpLS27rtT8PE0VCGE2PJtkAU2z+cYEmQMD24DVQTnYRbx
         VmvWdTi5uurvMkkiKUVOP48yivOwotOobsc3mngIaMNPbhv7h06FX4/LotgOrelpe+
         1jFlc/LiaxwUnkO6CaQ+0re8Mbw6EHQZVEdFfQOA=
Received: by mail-io1-f52.google.com with SMTP id e9so3248220iok.9
        for <linux-efi@vger.kernel.org>; Wed, 22 Apr 2020 10:26:04 -0700 (PDT)
X-Gm-Message-State: AGi0Pua64tmuW8rsk0/yjFikmJvVR1v8Fhqml1tTaupGVacp/dwE3tKE
        DAiPLwYXeHMmd3BYm+A0tQmQP/jedWqDZtxaTkI=
X-Google-Smtp-Source: APiQypKgnUrxsoKaubXK1VqoevgVi/hWnfek7JkKhHrnbkHUsrr60pTcGH2Q0pqPhP6G2yqnoPOpaAi1zdTCcoFFkEM=
X-Received: by 2002:a5d:8b57:: with SMTP id c23mr26587932iot.161.1587576363980;
 Wed, 22 Apr 2020 10:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200422172414.6662-1-ardb@kernel.org>
In-Reply-To: <20200422172414.6662-1-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 22 Apr 2020 19:25:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGswTWFggax=xV8d6VSpWm9FnLQSLt7E+67L6dbmYEOpg@mail.gmail.com>
Message-ID: <CAMj1kXGswTWFggax=xV8d6VSpWm9FnLQSLt7E+67L6dbmYEOpg@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Add UEFI support for RISC-V
To:     linux-efi <linux-efi@vger.kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 22 Apr 2020 at 19:24, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> This is a rework of Atish's series [0] to add EFI stub loader support
> to the RISC-V port. The purpose is to split the code in a way that makes
> it amenable to being merged via different trees during the same cycle.
> While at it, I added a patch to disable initrd= loading for new ports,
> given that it is deprecated and replaced with a method based on a
> special UEFI device path.
>
> My changes are logged in the individual patches.
>
> I propose to take the first four patches via the EFI tree, and expose
> them via a stable tag so that the RISC-V maintainers can merge it before
> applying the remaining patches. That will ensure that both trees remain
> in a buildable state, with working EFI stub support on the riscv branch.
>

[0] https://lore.kernel.org/linux-efi/20200421033336.9663-1-atish.patra@wdc.com/
