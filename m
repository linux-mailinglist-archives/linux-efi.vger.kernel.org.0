Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C317CD8AC
	for <lists+linux-efi@lfdr.de>; Wed, 18 Oct 2023 11:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjJRJzo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Oct 2023 05:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJRJzo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Oct 2023 05:55:44 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD46DBA
        for <linux-efi@vger.kernel.org>; Wed, 18 Oct 2023 02:55:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9be7e3fa1daso685106966b.3
        for <linux-efi@vger.kernel.org>; Wed, 18 Oct 2023 02:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697622940; x=1698227740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJcpH9sB3ms7+3XwTyaD7VgesiKyUZ7PQzRdWETFRww=;
        b=YrhCV7E1qFk5RXx5FbOWJmfsh47cOBSL/Y8GBv7FA2KwZqxPux73gBCwWX5asDrZ5C
         0Sp7u+hOjYal5Yh0TEyNzBpUWCGaQKGyeR40vTGZpMWDF1/oKrzpkdiOiyta5oTdVaAO
         +wdotPC91IEnBHz22BB676y6llftelxikOTOjY3qt4XDg/SBSpOCYdB72SUQIqYotVvz
         IxCfnh83V3asnVjQvcyHjEqkOdA07OFd9zJb8TFmzf1ff6dKtFw6DG52FERYlpwnCNZu
         DdDvrpu8Oqz8SbiHVrMpyBwf08+rq2Qvo3Hx2/iIPQ8sjwxJoRsLYEw1Z9oytQvmW0jY
         9XiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697622940; x=1698227740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJcpH9sB3ms7+3XwTyaD7VgesiKyUZ7PQzRdWETFRww=;
        b=ZiT2XuANwcDxRTI/osLX2DBfGOypyCHcceY7LjrwKW07NxwyaNr3ZN50XYAWlySQUP
         EKC8Kfor6CAxNNAKUcU7JXIPh3q70W+uUL1hCi6U+G5oeuiIHZmdXbUhdybxgaTdzU1N
         UWKG50/ETUCfutET7mdvtZj24Eu8zkolUgCs20UO9/ryUloVmEQmZ1trSEZjPedNznfM
         8VYWRwHm5bOwOD5uC7PfrvfAmR+FQWgebHH10Vta/9bY4rK6D3IDGJg73x+4WmHOpa1p
         0kXTK7nQE5XA5IVczHpfiRp7VuvLBWVqsw4GmdKtSiFgLKuR0/AA78kSyYz8DG8SBQFg
         +JSw==
X-Gm-Message-State: AOJu0YzmdjKkLLzW6P6IOkBomiBr/6+8K3wU48S1szcyGSdsx1IErDO4
        BaKfiZ4kJunZX5GTu/BXtU8=
X-Google-Smtp-Source: AGHT+IFByxntUdVBPNA4Lk4SsVnsOfq8BGBj7WlUEw2e59yg0EHsVj6VWADB7k7QiKMfgWVynl4Y5g==
X-Received: by 2002:a17:906:7952:b0:9ba:2fe3:c976 with SMTP id l18-20020a170906795200b009ba2fe3c976mr3914700ejo.12.1697622940066;
        Wed, 18 Oct 2023 02:55:40 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id c10-20020a1709063f0a00b009887f4e0291sm1338623ejj.27.2023.10.18.02.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 02:55:39 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 18 Oct 2023 11:55:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@google.com>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 0/2] x86/boot: Fix boot_params init in EFI stub
Message-ID: <ZS+rmaT2SAGdBxat@gmail.com>
References: <20231017132510.3845531-4-ardb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017132510.3845531-4-ardb@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@google.com> wrote:

> From: Ard Biesheuvel <ardb@kernel.org>
> 
> v2:
> add separate patch to rename the decompressor's version of the
> boot_params global variable
> 
> Ard Biesheuvel (2):
>   x86/boot: Rename conflicting boot_params pointer to boot_params_p
>   x86/boot: efistub: Assign global boot_params variable
> 
>  arch/x86/boot/compressed/acpi.c         | 14 +++++------
>  arch/x86/boot/compressed/cmdline.c      |  4 +--
>  arch/x86/boot/compressed/ident_map_64.c |  7 +++---
>  arch/x86/boot/compressed/kaslr.c        | 26 ++++++++++----------
>  arch/x86/boot/compressed/mem.c          |  6 ++---
>  arch/x86/boot/compressed/misc.c         | 24 +++++++++---------
>  arch/x86/boot/compressed/misc.h         |  1 -
>  arch/x86/boot/compressed/pgtable_64.c   |  9 +++----
>  arch/x86/boot/compressed/sev.c          |  2 +-
>  arch/x86/include/asm/boot.h             |  2 ++
>  drivers/firmware/efi/libstub/x86-stub.c |  2 ++
>  11 files changed, 50 insertions(+), 47 deletions(-)

Thanks!

I renamed 'boot_params_p' to 'boot_params_ptr' for clarity - fortunately 
haven't run out of 't' and 'r' letters yet in the kernel.

Thanks,

	Ingo
