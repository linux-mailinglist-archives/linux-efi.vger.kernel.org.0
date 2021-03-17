Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8C633F131
	for <lists+linux-efi@lfdr.de>; Wed, 17 Mar 2021 14:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhCQNcg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Mar 2021 09:32:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231181AbhCQNcR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 17 Mar 2021 09:32:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9239B64F44
        for <linux-efi@vger.kernel.org>; Wed, 17 Mar 2021 13:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615987936;
        bh=/zBrs2qpfyQqgkSu4uDzDPi48zZfM4qRDXoNtdc+6/o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GmBxoPmF3cAOwwvCqOPsxn1nuL+NnBnEnNK4eCj4jCzdyrBPeaEsHcHNyzAsPd1Ec
         F3bPR5L8/mH/yqpJs5zLnKoveN5sR/QbWjigQozAgUzBwPIcT7drPONdS9XMSphvm+
         cwDSAa07nDwhNiz4H6NG8r5xos9RrnLWMaztBjsAluWP2aslgZaivaPp4FF2k7+q7m
         h4q5j5TgcEj+MWOlg7LIptKZd1uIKFWyX/vTBV4iKQOljRn3FMp2gC+LH6hYUNScFQ
         AyRaPAda5HnR/lRGToh4o72gVMLqSxmMphYNmjjyRx2k04BoUiQgNZCClvgZGpPDgS
         pGM1yRAJA6tcw==
Received: by mail-ot1-f54.google.com with SMTP id l23-20020a05683004b7b02901b529d1a2fdso1759389otd.8
        for <linux-efi@vger.kernel.org>; Wed, 17 Mar 2021 06:32:16 -0700 (PDT)
X-Gm-Message-State: AOAM5331YrtLlrmlTH6r8frZx9Cd6Dw4oqyInpi5yS18ZsLlEGFGLAhh
        z20Hqq48Hc1HX/YtnVfMBtixXebOyo4Yx6VYvDI=
X-Google-Smtp-Source: ABdhPJyNqH4jcobchqimZ2s9xVAb5GKMVL7oO0JXZcMy4z9G+s6izLQCG1yij7p2i6oqekx9M4ieDgDxDd+bDYkR8LU=
X-Received: by 2002:a9d:6e15:: with SMTP id e21mr3301763otr.77.1615987935776;
 Wed, 17 Mar 2021 06:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <75d99346-73c1-993c-8bba-08cb3b3271a2@gmx.de>
In-Reply-To: <75d99346-73c1-993c-8bba-08cb3b3271a2@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 17 Mar 2021 14:32:04 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHue99LeDYHP4Cg6+-0iJrjkgti2H8=V4NChw5mScDLCA@mail.gmail.com>
Message-ID: <CAMj1kXHue99LeDYHP4Cg6+-0iJrjkgti2H8=V4NChw5mScDLCA@mail.gmail.com>
Subject: Re: [RFC] efi: variable name size limit in efivar_init()
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(cc Matthew and Peter)

On Wed, 17 Mar 2021 at 08:35, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
> Hello Ard,
>
> in efivar_init() I read:
>
>          /*
>           * Per EFI spec, the maximum storage allocated for both
>           * the variable name and variable data is 1024 bytes.
>           */
>
>          do {
>                  variable_name_size = 1024;
>
> This dates back at least to Linux 2.5.0 of 23-Nov-2001 where in
> arch/ia64/kernel/efivars.c we have:
>
> /*
>   * The maximum size of VariableName + Data = 1024
>   * Therefore, it's reasonable to save that much
>   * space in each part of the structure,
>   * and we use a page for reading/writing.
>   */
>
> I cannot find this 1024 byte size limit neither in UEFI spec 2.8B nor in
> EFI spec 1.1.
>
> Variable d719b2cb-3d3a-4596-a3bc-dad00e67656f-db has 5080 bytes of data
> on my laptop.
>
> It may not reasonable to use a variable name exceeding 512 UTF-16
> characters. But shouldn't we handle this case gracefully in efivar_init()?
>

This predates my involvement in EFI by a long time, so I've cc'ed
Peter and Matthew, who may be able to shed some light on this.
